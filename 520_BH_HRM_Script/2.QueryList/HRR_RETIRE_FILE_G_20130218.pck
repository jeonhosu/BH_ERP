CREATE OR REPLACE PACKAGE HRR_RETIRE_FILE_G
AS

-------------------------------------------------------------------------------
-- �������� �������� ���� ��� SELECT.
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
-- �����ҵ� ���ϻ��� �� ��ȸ.
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
-- 2011�⵵ �����ҵ� ���ϻ��� �� ��ȸ.
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
-- 2012�⵵ �����ҵ� ���ϻ��� �� ��ȸ.
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
-- ���� DATA INSERT.
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
/* Description  : �������� ��� ����.
/*
/* Reference by :
/* Program History :
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 18-MAR-2011  Lee Sun Hee        Initialize
/******************************************************************************/
-------------------------------------------------------------------------------
-- �������� �������� ���� ��� SELECT.
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
-- �����ҵ� ���ϻ��� �� ��ȸ.
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

    -- TEMPORARY ����.
    DELETE FROM HRM_REPORT_FILE_GT RF
    WHERE RF.SOB_ID           = P_SOB_ID
      AND RF.ORG_ID           = P_ORG_ID
    ;
    IF V_YEAR_YYYY = '2011' THEN
      -- 2011�⵵ --
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
      -- 2012�⵵ --
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
-- 2011�⵵ �����ҵ� ���ϻ��� �� ��ȸ.
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
    --> ��(��) ��ü ���� ����.
    V_SEQ_NUM                   NUMBER := 0;
    V_SOURCE_FILE               VARCHAR2(150);
    V_RECORD_COUNT              NUMBER := 0;
    V_E_REC_STD                 CONSTANT NUMBER := 5;
    V_F_REC_STD                 CONSTANT NUMBER := 15;
    V_SEQ_NO                    NUMBER;          -- ���ڵ� ���� ��ȣ.
    V_RECORD_FILE               VARCHAR2(3000);  -- �ξ簡�� ��������.
  BEGIN
    -- �����ü ����--.
--A1 ------------------------------------------------------------------------------------
    FOR A1 IN ( SELECT 'A'   -- �ڷ������ȣ.
                    || '25'  -- �����ٷμҵ�(20);
                    || LPAD(REPLACE(OU.TAX_OFFICE_CODE, '-', ''), 3, 0)  -- ������ �ڵ�;
                    || TO_CHAR(P_WRITE_DATE, 'YYYYMMDD')  -- �ڷḦ �������� �����ϴ� ������;
                    --> ������;
                    || LPAD(NVL(P_SUBMIT_AGENT, '2'), 1, 0)  -- �����ڱ���(�����븮��1, ����2, ����3);
                    || RPAD(NVL(P_TAX_AGENT, ' '), 6, ' ')  -- �����븮�� ������ȣ(�ڷ������ڰ� �����븮���ΰ�� ����);
                    || RPAD(NVL(P_HOMETAX_LOGIN_ID, ' '), 20, ' ')  -- Ȩ�ý�ID;
                    || RPAD(NVL(P_TAX_PROGRAM_CODE, '1001'), 4, ' ')  -- �������α׷��ڵ�;
                    || RPAD(NVL(REPLACE(OU.VAT_NUMBER, '-', ''), ' '), 10, ' ')  -- ����ڵ�Ϲ�ȣ;
                    || RPAD(NVL(CM.CORP_NAME, ' '), 40, ' ')  -- ���θ�(��ȣ);
                    || RPAD(NVL(S_PM.DEPT_NAME, ' '), 30, ' ')  -- �����(������) �μ�;
                    || RPAD(NVL(S_PM.NAME, ' '), 30, ' ')  -- �����(������) ����;
                    || RPAD(NVL(REPLACE(CM.TEL_NUMBER, '-', ''), ' '), 15, ' ')  -- �����(������) ��ȭ��ȣ;
                    --> ���⳻��.
                    || LPAD(1, 5, 0)  -- �Ű��ǹ��ڼ� (B���ڵ�);
                    || LPAD(NVL(P_USE_LANGUAGE_CODE, '101'), 3, 0)  -- ����ѱ��ڵ�;
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
      FOR B1 IN ( SELECT --> �ڷ������ȣ;
                         'B'    -- ���ڵ� ����;
                      || '25'  -- �����ٷμҵ�(20);
                      || LPAD(REPLACE(OU.TAX_OFFICE_CODE, '-', ''), 3, 0)   -- �������ڵ�;
                      || LPAD(1, 6, 0)                                      -- B���ڵ��� �Ϸù�ȣ;
                      --> ������;
                      || RPAD(NVL(REPLACE(OU.VAT_NUMBER, '-', ''), ' '), 10, ' ')      -- ��õ¡���ǹ����� ����ڵ�Ϲ�ȣ;
                      || RPAD(NVL(CM.CORP_NAME, ' '), 40, ' ')              -- ���θ�(��ȣ);
                      || RPAD(NVL(CM.PRESIDENT_NAME, ' '), 30, ' ')         -- ��ǥ�� ����;
                      || RPAD(NVL(REPLACE(CM.LEGAL_NUMBER, '-', ''), ' '), 13, ' ') -- ���ε�Ϲ�ȣ;
                      --> ���⳻��;
                      || LPAD(NVL(S_RA.PERSON_COUNT, 0), 7, 0)   -- ������ C���ڵ��� ��(�ٷμҵ����� ��);
                      || LPAD(NVL(S_RA.PRE_PERSON_COUNT, 0), 7, 0)   -- ������ D���ڵ�(���ٹ�ó)�� ��(C���ڵ� �׸�6�� �հ�)
                      || LPAD(NVL(S_RA.RETIRE_TOTAL_AMOUNT, 0), 14, 0)    -- �����޿��� �Ѱ�(C���ڵ� �����޿� ��);
                      || LPAD(NVL(S_RA.INCOME_TAX_AMOUNT, 0), 13, 0)  -- �ҵ漼 �������� �Ѱ�(C���ڵ� �ҵ漼�� ��);
                      || LPAD(0, 13, 0)  -- LPAD(NVL(S_YA.FIX_LEGAL_TAX, 0), 13, 0) : 2009�� �������� ����(MODIFIED BY YOUNG MIN) ���μ� ���������Ѱ�->�������� ����;
                      || LPAD(NVL(S_RA.RESIDENT_TAX_AMOUNT, 0), 13, 0) -- ���漼 �������� �Ѱ�;
                      || LPAD(NVL(S_RA.SP_TAX_AMOUNT, 0), 13, 0) -- ��Ư�� �������� �Ѱ�;
                      || LPAD(NVL(SUM_TAX_AMOUNT, 0), 13, 0)  -- �������� �Ѱ�;
                      -- LPAD(NVL(S_YA.FIX_TOTAL_TAX, 0), 13, 0)  -- �������� �Ѱ� : 2009�� �������� ����(MODIFIED BY YOUNG MIN) ���������Ѱ�-���μ� �������� �Ѱ�;
                      || LPAD(NVL(P_SUBMIT_PERIOD, '1'), 1, 0)   -- (�����ջ� : 1, ��/����� ���� �������� : 2, ���� �������� : 3);
                      || RPAD(' ', 791, ' ') AS RECORD_FILE
                      , CM.CORP_NAME  -- ���θ�.
                      , LPAD(REPLACE(OU.TAX_OFFICE_CODE, '-', ''), 3, 0) AS TAX_OFFICE_CODE
                      , RPAD(NVL(REPLACE(OU.VAT_NUMBER, '-', ''), ' '), 10, ' ') AS VAT_NUMBER
                    FROM HRM_CORP_MASTER CM
                       , HRM_OPERATING_UNIT OU
                       , ( -- ���⳻��.
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
                          'C'                                           -- 1.�ڷ������ȣ.
                        || '25'                                         -- 2.
                        || RPAD(NVL(B1.TAX_OFFICE_CODE, ' '), 3, ' ')   -- 3.�������ڵ�.
                        || LPAD(ROW_NUMBER() OVER(PARTITION BY RA.ADJUSTMENT_YYYY ORDER BY PM.PERSON_NUM), 6, 0)   -- 4. �Ϸù�ȣ.
                        || RPAD(NVL(B1.VAT_NUMBER, ' '), 10, ' ')       -- 5. ����ڹ�ȣ.
                        || RPAD(NVL(B1.VAT_NUMBER, ' '), 10, ' ')       -- 6. ���� �ٹ�ó ����ڹ�ȣ.
                        || RPAD(NVL(B1.CORP_NAME, ' '), 40, ' ')       -- 7. ���� �ٹ�ó��.
                        || LPAD(0, 2, 0)      -- 8. ��(��)�ٹ�ó ��;
                        || RPAD(NVL(PM.RESIDENT_TYPE, '1'), 1, 0)       -- 9. ������ �����ڵ�(������:1, �������:2);
                        || RPAD(CASE
                                  WHEN PM.RESIDENT_TYPE = '1' THEN ' '
                                  WHEN SUBSTR(REPLACE(PM.REPRE_NUM, '-', ''), 7, 1) BETWEEN '1' AND '4' THEN ' '  -- 1900, 2000���.
                                  WHEN SUBSTR(REPLACE(PM.REPRE_NUM, '-', ''), 7, 1) BETWEEN '9' AND '0' THEN ' '  -- 1800����..
                                  ELSE NVL(S_HN.ISO_NATION_CODE, ' ')
                                END, 2, ' ')  -- 10.�ű����� �ڵ� : ������ڸ� ���, �����ڴ� ����;
                        || RPAD(CASE
                                  WHEN PM.JOIN_DATE > TO_DATE(P_YEAR_YYYY || '-01-01', 'YYYY-MM-DD') THEN TO_CHAR(PM.JOIN_DATE, 'YYYYMMDD')
                                  ELSE TO_CHAR(P_YEAR_YYYY || '0101')
                                END, 8, 0)  -- 11. �ٹ��Ⱓ ���ۿ�����;
                        || RPAD(CASE
                                  WHEN PM.RETIRE_DATE IS NOT NULL AND PM.RETIRE_DATE < TO_DATE(P_YEAR_YYYY || '-12-31', 'YYYY-MM-DD') THEN
                                    TO_CHAR(PM.RETIRE_DATE, 'YYYYMMDD')
                                  ELSE P_YEAR_YYYY || '1231'
                                END, 8, 0)  -- 12. �ٹ��Ⱓ ���Ῥ����;
                        || RPAD(PM.NAME, 30, ' ')  -- 13. ����;
                        || RPAD(CASE
                                  WHEN PM.NATIONALITY_TYPE IS NOT NULL THEN PM.NATIONALITY_TYPE
                                  WHEN SUBSTR(REPLACE(PM.REPRE_NUM, '-', ''), 7, 1) BETWEEN '1' AND '4' THEN '1'  -- 1900, 2000���.
                                  WHEN SUBSTR(REPLACE(PM.REPRE_NUM, '-', ''), 7, 1) BETWEEN '9' AND '0' THEN '1'  -- 1800����.
                                  WHEN SUBSTR(REPLACE(PM.REPRE_NUM, '-', ''), 7, 1) BETWEEN '5' AND '8' THEN '9'  -- �ܱ���.
                                END, 1, 0)  -- 14. ��/�ܱ��� �����ڵ�;
                        || RPAD(NVL(REPLACE(PM.REPRE_NUM, '-', ''), ' '), 13, ' ')  -- 15.�ֹε�Ϲ�ȣ;
                        || RPAD(CASE
                                  WHEN RA.ADJUSTMENT_TYPE = 'M' THEN '5'
                                  WHEN PC.POST_CODE < '200' THEN '4'
                                  ELSE NVL(S_RT.RETIRE_GROUP_CODE, '3')
                                END, 1, 0)  -- 16.��������.                        
                        || LPAD(NVL(RA.RETIRE_TOTAL_AMOUNT, 0), 10, 0) -- 17.�����޿�(����).
                        || LPAD(NVL(RA.HONORARY_AMOUNT, 0), 10, 0) -- 18.�����޿�(�����̿�).
                        || LPAD(0, 10, 0) -- 19.���������Ͻñ�(����).
                        || LPAD(0, 10, 0) -- 20.���������Ͻñ�(�����̿�)����;
                        || LPAD(NVL(RA.RETIRE_TOTAL_AMOUNT, 0), 10, 0) -- 21.����(����)�޿��װ�.
                        || LPAD(NVL(RA.HONORARY_AMOUNT, 0), 10, 0) -- 22.����(�����̿�)�޿��װ�.
                        || LPAD(0, 10, 0) -- 23.������ҵ�.
                        --> ��(��)�ٹ��� �������ݸ�.
                        || LPAD(' ', 20, ' ') -- 24.�������ݰ��¹�ȣ;
                        || LPAD(0, 10, 0) -- 25.���������Ͻñ��Ѽ��ɾ�.
                        || LPAD(0, 10, 0) -- 26.�������ݿ������հ��.
                        || LPAD(0, 10, 0) -- 27.�������ݼҵ��ں��Ծ�.
                        || LPAD(0, 10, 0) -- 28.�������ݼҵ������.
                        || LPAD(0, 10, 0) -- 29.���������Ͻñ�.
                        --> ��(��)�ٹ��� �������ݸ�.
                        || LPAD(' ', 20, ' ') -- 24-1.�������ݰ��¹�ȣ.
                        || LPAD(0, 10, 0) -- 25-1.���������Ͻñ��Ѽ��ɾ�.
                        || LPAD(0, 10, 0) -- 26-1.�������ݿ������հ��.
                        || LPAD(0, 10, 0) -- 27-1.�������ݼҵ��ں��Ծ�.
                        || LPAD(0, 10, 0) -- 28-1.�������ݼҵ������.
                        || LPAD(0, 10, 0) -- 29-1.���������Ͻñ�.
                        --> ����ȯ���-���������޿�;
                        || LPAD(0, 10, 0) -- 30.���������Ͻñ����޿����-��(��);
                        || LPAD(0, 10, 0) -- 31.���������Ͻñ����޿����-��(��);
                        || LPAD(0, 10, 0) -- 32.���������Ͻñ����޿���� �����̿��ݾ�-��(��)(���������Ͻñ�����);
                        || LPAD(0, 10, 0) -- 33.���������Ͻñ����޿���� �����̿��ݾ�-��(��)(���������Ͻñ�����);
                        || LPAD(0, 10, 0) -- 34.������������޿���-��(��);
                        || LPAD(0, 10, 0) -- 35.������������޿���-��(��);
                        || LPAD(0, 10, 0) -- 36. �����������Ͻñ�.
                        || LPAD(0, 10, 0) -- 37. ���ɰ��������޿���.
                        || LPAD(0, 10, 0) -- 38. ȯ�������ҵ����.
                        || LPAD(0, 10, 0) -- 39. ȯ�������ҵ� ����ǥ��.
                        || LPAD(0, 10, 0) -- 40. ȯ�꿬��հ���ǥ��.
                        || LPAD(0, 10, 0) -- 41. ȯ�꿬��ջ��⼼��.
                       --> ����ȯ���-�����̿� �����޿�;
                        || LPAD(0, 10, 0) --30-1. ���������Ͻñ����޿����-��(��);
                        || LPAD(0, 10, 0) --31-1. ���������Ͻñ����޿����-��(��);
                        || LPAD(0, 10, 0) --32-1. ���������Ͻñ����޿���� �����̿��ݾ�-��(��)(���������Ͻñ�����);
                        || LPAD(0, 10, 0) --33-1. ���������Ͻñ����޿���� �����̿��ݾ�-��(��)(���������Ͻñ�����);
                        || LPAD(0, 10, 0) --34-1. ������������޿���-��(��);
                        || LPAD(0, 10, 0) --35-1. ������������޿���-��(��);
                        || LPAD(0, 10, 0) --36-1. �����������Ͻñ�.
                        || LPAD(0, 10, 0) --37-1. ���ɰ��� �����޿���.
                        || LPAD(0, 10, 0) --38-1. ȯ�������ҵ����.
                        || LPAD(0, 10, 0) --39-1. ȯ�������ҵ� ����ǥ��.
                        || LPAD(0, 10, 0) --40-1. ȯ�꿬��հ���ǥ��.
                        || LPAD(0, 10, 0) --41-1. ȯ�꿬��ջ��⼼��.
                        -- �ټӿ���-���������޿�.
                        || LPAD(NVL(TO_CHAR(RA.RETIRE_DATE_FR, 'YYYYMMDD'), '0'), 8, 0) --42. ��(��)�ٹ��� �Ի翬����;
                        || LPAD(NVL(TO_CHAR(RA.RETIRE_DATE_TO, 'YYYYMMDD'), '0'), 8, 0) --43. ��(��)�ٹ��� �Ի翬����;
                        || LPAD(NVL(RA.LONG_MONTH, 0), 4, 0) --44. ��(��)�ٹ��� �ټӿ���.
                        || LPAD(CASE 
                                  WHEN TRUNC(RA.DED_DAY / 30) <= 0 THEN 0
                                  WHEN TRUNC(RA.DED_DAY / 30) <= 1 THEN 1
                                  ELSE TRUNC(RA.DED_DAY / 30)
                                END, 4, 0) -- 45. ��(��)�ٹ��� ���ܿ���.
                        || LPAD(0, 8, 0) -- 46. ��(��)�ٹ��� �Ի翬����.
                        || LPAD(0, 8, 0) -- 47. ��(��)�ٹ��� ��翬����.
                        || LPAD(0, 4, 0) -- 48. ��(��)�ٹ��� �ټӿ���.
                        || LPAD(0, 4, 0) -- 49. ��(��)�ٹ��� ���ܿ���.
                        || LPAD(0, 4, 0) -- 50. �ߺ�����.
                        || LPAD(NVL(RA.LONG_YEAR, 0), 2, 0) --51. �ټӿ���.
                        --> �ټӿ��� -�����̿� �����޿�;
                        || LPAD(NVL(TO_CHAR(NVL(RA.H_RETIRE_DATE_FR, RA.RETIRE_DATE_FR), 'YYYYMMDD'), '0'), 8, 0) -- 42-1. ��(��)�ٹ��� �Ի翬����;
                        || LPAD(NVL(TO_CHAR(NVL(RA.H_RETIRE_DATE_TO, RA.RETIRE_DATE_TO), 'YYYYMMDD'), '0'), 8, 0) -- 43-1. ��(��)�ٹ��� ��翬����;
                        || LPAD(DECODE(NVL(RA.H_LONG_MONTH, 0), 0, NVL(RA.LONG_MONTH, 0), NVL(RA.H_LONG_MONTH, 0)), 4, 0) -- 44-1. ��(��)�ٹ��� �ټӿ���.
                        || LPAD(/*CASE 
                                  WHEN TRUNC(NVL(RA.DED_DAY, 0) / 30) <= 0 THEN 0
                                  WHEN TRUNC(NVL(RA.DED_DAY, 0) / 30) <= 1 THEN 1
                                  ELSE TRUNC(NVL(RA.DED_DAY / 30)
                                END*/0, 4, 0) -- 45-1. ��(��)�ٹ��� ���ܿ���.
                        || LPAD(0, 8, 0) -- 46-1. ��(��)�ٹ��� �Ի翬����.
                        || LPAD(0, 8, 0) -- 47-1. ��(��)�ٹ��� ��翬����.
                        || LPAD(0, 4, 0) -- 48-1. ��(��)�ٹ��� �ټӿ���.
                        || LPAD(0, 4, 0) -- 49-1. ��(��)�ٹ��� ���ܿ���.
                        || LPAD(0, 4, 0) -- 50-1. �ߺ�����.
                        || LPAD(DECODE(NVL(RA.H_LONG_YEAR, 0), 0, NVL(RA.LONG_YEAR, 0), NVL(RA.H_LONG_YEAR, 0)), 2, 0) -- 51-1. �ټӿ���.
                        --> ����� - ���������޿�;
                        || LPAD(NVL(RA.RETIRE_TOTAL_AMOUNT, 0), 10, 0) -- 52.�����޿���.
                        || LPAD(CASE
                                  WHEN NVL(RA.RETIRE_TOTAL_AMOUNT, 0) < (NVL(RA.INCOME_DED_AMOUNT, 0) + NVL(RA.LONG_DED_AMOUNT, 0)) THEN NVL(RA.RETIRE_TOTAL_AMOUNT, 0)
                                  ELSE (NVL(RA.INCOME_DED_AMOUNT, 0) + NVL(RA.LONG_DED_AMOUNT, 0))
                                END, 10, 0) -- 53. �����ҵ����.
                        || LPAD(NVL(RA.TAX_STD_AMOUNT, 0), 10, 0) -- 54. �����ҵ����ǥ��.
                        || LPAD(NVL(RA.AVG_TAX_STD_AMOUNT, 0), 10, 0) -- 55. ����հ���ǥ��.
                        || LPAD(NVL(RA.AVG_COMP_TAX_AMOUNT, 0), 10, 0) -- 56. ����� ���⼼��.
                        || LPAD(NVL(RA.COMP_TAX_AMOUNT, 0), 10, 0) -- 57. ���⼼��.
                        --|| LPAD(NVL(HA.TAX_DED_AMT, 0), 10, 0) -- AS �����ҵ漼�װ���;
                        || LPAD(0, 10, 0) -- 58. �ܱ����μ��װ���.
                        --> ����� - �����̿������޿�;
                        || LPAD(NVL(RA.HONORARY_AMOUNT, 0), 10, 0) -- 52-1. �����޿���.
                        || LPAD(CASE
                                  WHEN NVL(RA.HONORARY_AMOUNT, 0) < (NVL(RA.H_INCOME_DED_AMOUNT, 0) + NVL(RA.H_LONG_DED_AMOUNT, 0)) THEN NVL(RA.HONORARY_AMOUNT, 0)
                                  ELSE (NVL(RA.H_INCOME_DED_AMOUNT, 0) + NVL(RA.H_LONG_DED_AMOUNT, 0))
                                END, 10, 0) -- 53.-1 �����ҵ����.
                        || LPAD(NVL(RA.H_TAX_STD_AMOUNT, 0), 10, 0) -- 54-1. �����ҵ����ǥ��.
                        || LPAD(NVL(RA.H_AVG_TAX_STD_AMOUNT, 0), 10, 0) -- 55-1. ����հ���ǥ��.
                        || LPAD(NVL(RA.H_AVG_COMP_TAX_AMOUNT, 0), 10, 0) -- 56-1. ����ջ��⼼��.
                        || LPAD(NVL(RA.H_COMP_TAX_AMOUNT, 0), 10, 0) -- 57-1. ���⼼��.
                        || LPAD(0, 10, 0) -- 58-1. �ܱ����μ��װ���.

                       --> ����� ��(�����(���������޿�) + �����(�����̿������޿�))
                        || LPAD(NVL(RA.RETIRE_TOTAL_AMOUNT, 0) + NVL(RA.HONORARY_AMOUNT, 0), 10, 0) -- 59. �����޿���.
                        || LPAD(CASE
                                  WHEN NVL(RA.RETIRE_TOTAL_AMOUNT, 0) < (NVL(RA.INCOME_DED_AMOUNT, 0) + NVL(RA.LONG_DED_AMOUNT, 0)) THEN NVL(RA.RETIRE_TOTAL_AMOUNT, 0)
                                  ELSE (NVL(RA.INCOME_DED_AMOUNT, 0) + NVL(RA.LONG_DED_AMOUNT, 0))
                                END + 
                                CASE
                                  WHEN NVL(RA.HONORARY_AMOUNT, 0) < (NVL(RA.H_INCOME_DED_AMOUNT, 0) + NVL(RA.H_LONG_DED_AMOUNT, 0)) THEN NVL(RA.HONORARY_AMOUNT, 0)
                                  ELSE (NVL(RA.H_INCOME_DED_AMOUNT, 0) + NVL(RA.H_LONG_DED_AMOUNT, 0))
                                END, 10, 0) -- 60. �����ҵ����.
                        || LPAD(NVL(RA.TAX_STD_AMOUNT, 0) + NVL(RA.H_TAX_STD_AMOUNT, 0), 10, 0) -- 61. �����ҵ����ǥ��.
                        || LPAD(NVL(RA.AVG_TAX_STD_AMOUNT, 0) + NVL(RA.H_AVG_TAX_STD_AMOUNT, 0), 10, 0) -- 62. ����հ���ǥ��.
                        || LPAD(NVL(RA.AVG_COMP_TAX_AMOUNT, 0) + NVL(RA.H_AVG_COMP_TAX_AMOUNT, 0), 10, 0) -- 63. ����ջ��⼼��.
                        || LPAD(NVL(RA.COMP_TAX_AMOUNT, 0) + NVL(RA.H_COMP_TAX_AMOUNT, 0), 10, 0) -- 64. ���⼼��.
                        --|| LPAD(NVL(HA.TAX_DED_AMT, 0), 10, 0) -- AS �����ҵ漼�װ���;
                        || LPAD(0, 10, 0) -- 65. �ܱ����μ��װ���.
                       --> ��������.
                        || LPAD(NVL(RA.INCOME_TAX_AMOUNT, 0) + NVL(RA.H_INCOME_TAX_AMOUNT, 0), 10, 0) -- 66. �ҵ漼��.
                        || LPAD(NVL(RA.RESIDENT_TAX_AMOUNT, 0) + NVL(RA.H_RESIDENT_TAX_AMOUNT, 0), 10, 0) -- 67. �ֹμ�
                        || LPAD(NVL(RA.SP_TAX_AMOUNT, 0) + NVL(RA.H_SP_TAX_AMOUNT, 0), 10, 0) -- 68. ��Ư��
                        || LPAD(NVL(RA.INCOME_TAX_AMOUNT, 0) + NVL(RA.RESIDENT_TAX_AMOUNT, 0) + NVL(RA.SP_TAX_AMOUNT, 0), 10, 0) -- 69. ��.
                       --> ��(��)�ٹ���;
                        || LPAD(0, 10, 0) -- 70. �ҵ漼.
                        || LPAD(0, 10, 0) -- 71. �ֹμ�.
                        || LPAD(0, 10, 0) -- 72. ��Ư��.
                        || LPAD(0, 10, 0) -- 73. ��.
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
                        , ( -- ��������.
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
            --> ��(��)�ٹ�ó ���ڵ� <--
            
          END LOOP C1;
        END LOOP B1;
    END LOOP A1;

  END SET_RETIRE_FILE_2011;

-------------------------------------------------------------------------------
-- 2012�⵵ �����ҵ� ���ϻ��� �� ��ȸ.
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
    --> ��(��) ��ü ���� ����.
    V_SEQ_NUM                   NUMBER := 0;
    V_SOURCE_FILE               VARCHAR2(150);
    V_RECORD_COUNT              NUMBER := 0;
    V_E_REC_STD                 CONSTANT NUMBER := 5;
    V_F_REC_STD                 CONSTANT NUMBER := 15;
    V_SEQ_NO                    NUMBER;          -- ���ڵ� ���� ��ȣ.
    V_RECORD_FILE               VARCHAR2(3000);  -- �ξ簡�� ��������.
  BEGIN
    -- �����ü ����--.
--A1 ------------------------------------------------------------------------------------
    FOR A1 IN ( SELECT 'A'   -- �ڷ������ȣ.
                    || '25'  -- �����ٷμҵ�(20);
                    || LPAD(REPLACE(OU.TAX_OFFICE_CODE, '-', ''), 3, 0)  -- ������ �ڵ�;
                    || TO_CHAR(P_WRITE_DATE, 'YYYYMMDD')  -- �ڷḦ �������� �����ϴ� ������;
                    --> ������;
                    || LPAD(NVL(P_SUBMIT_AGENT, '2'), 1, 0)  -- �����ڱ���(�����븮��1, ����2, ����3);
                    || RPAD(NVL(P_TAX_AGENT, ' '), 6, ' ')  -- �����븮�� ������ȣ(�ڷ������ڰ� �����븮���ΰ�� ����);
                    || RPAD(NVL(P_HOMETAX_LOGIN_ID, ' '), 20, ' ')  -- Ȩ�ý�ID;
                    || RPAD(NVL(P_TAX_PROGRAM_CODE, '1001'), 4, ' ')  -- �������α׷��ڵ�;
                    || RPAD(NVL(REPLACE(OU.VAT_NUMBER, '-', ''), ' '), 10, ' ')  -- ����ڵ�Ϲ�ȣ;
                    || RPAD(NVL(CM.CORP_NAME, ' '), 40, ' ')  -- ���θ�(��ȣ);
                    || RPAD(NVL(S_PM.DEPT_NAME, ' '), 30, ' ')  -- �����(������) �μ�;
                    || RPAD(NVL(S_PM.NAME, ' '), 30, ' ')  -- �����(������) ����;
                    || RPAD(NVL(REPLACE(CM.TEL_NUMBER, '-', ''), ' '), 15, ' ')  -- �����(������) ��ȭ��ȣ;
                    --> ���⳻��.
                    || LPAD(1, 5, 0)  -- �Ű��ǹ��ڼ� (B���ڵ�);
                    || LPAD(NVL(P_USE_LANGUAGE_CODE, '101'), 3, 0)  -- ����ѱ��ڵ�;
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
      FOR B1 IN ( SELECT --> �ڷ������ȣ;
                         'B'    -- ���ڵ� ����;
                      || '25'  -- �����ٷμҵ�(20);
                      || LPAD(REPLACE(OU.TAX_OFFICE_CODE, '-', ''), 3, 0)   -- �������ڵ�;
                      || LPAD(1, 6, 0)                                      -- B���ڵ��� �Ϸù�ȣ;
                      --> ������;
                      || RPAD(NVL(REPLACE(OU.VAT_NUMBER, '-', ''), ' '), 10, ' ')      -- ��õ¡���ǹ����� ����ڵ�Ϲ�ȣ;
                      || RPAD(NVL(CM.CORP_NAME, ' '), 40, ' ')              -- ���θ�(��ȣ);
                      || RPAD(NVL(CM.PRESIDENT_NAME, ' '), 30, ' ')         -- ��ǥ�� ����;
                      || RPAD(NVL(REPLACE(CM.LEGAL_NUMBER, '-', ''), ' '), 13, ' ') -- ���ε�Ϲ�ȣ;
                      || LPAD('1', 1, 0)  -- ¡���ǹ��� ����(�����1/�������ݻ����2/�������ݻ����3) --
                      --> ���⳻��;
                      || LPAD(NVL(S_RA.PERSON_COUNT, 0), 7, 0)   -- ������ C���ڵ��� ��(�ٷμҵ����� ��);
                      || LPAD(NVL(S_RA.PRE_PERSON_COUNT, 0), 7, 0)   -- ������ D���ڵ�(���ٹ�ó)�� ��(C���ڵ� �׸�6�� �հ�)
                      || LPAD(NVL(S_RA.RETIRE_TOTAL_AMOUNT, 0), 14, 0)    -- �����޿��� �Ѱ�(C���ڵ� �����޿� ��);
                      || LPAD(NVL(S_RA.INCOME_TAX_AMOUNT, 0), 13, 0)  -- �ҵ漼 �������� �Ѱ�(C���ڵ� �ҵ漼�� ��);
                      || LPAD(0, 13, 0)  -- LPAD(NVL(S_YA.FIX_LEGAL_TAX, 0), 13, 0) : 2009�� �������� ����(MODIFIED BY YOUNG MIN) ���μ� ���������Ѱ�->�������� ����;
                      || LPAD(NVL(S_RA.RESIDENT_TAX_AMOUNT, 0), 13, 0) -- ���漼 �������� �Ѱ�;
                      || LPAD(NVL(S_RA.SP_TAX_AMOUNT, 0), 13, 0) -- ��Ư�� �������� �Ѱ�;
                      || LPAD(NVL(SUM_TAX_AMOUNT, 0), 13, 0)  -- �������� �Ѱ�;
                      -- LPAD(NVL(S_YA.FIX_TOTAL_TAX, 0), 13, 0)  -- �������� �Ѱ� : 2009�� �������� ����(MODIFIED BY YOUNG MIN) ���������Ѱ�-���μ� �������� �Ѱ�;
                      || LPAD(NVL(P_SUBMIT_PERIOD, '1'), 1, 0)   -- (�����ջ� : 1, ��/����� ���� �������� : 2, ���� �������� : 3);
                      || RPAD(' ', 810, ' ') AS RECORD_FILE
                      , CM.CORP_NAME  -- ���θ�.
                      , LPAD(REPLACE(OU.TAX_OFFICE_CODE, '-', ''), 3, 0) AS TAX_OFFICE_CODE
                      , RPAD(NVL(REPLACE(OU.VAT_NUMBER, '-', ''), ' '), 10, ' ') AS VAT_NUMBER
                    FROM HRM_CORP_MASTER CM
                       , HRM_OPERATING_UNIT OU
                       , ( -- ���⳻��.
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
                          'C'                                           -- 1.�ڷ������ȣ.
                        || '25'                                         -- 2.
                        || RPAD(NVL(B1.TAX_OFFICE_CODE, ' '), 3, ' ')   -- 3.�������ڵ�.
                        || LPAD(ROW_NUMBER() OVER(PARTITION BY RA.ADJUSTMENT_YYYY ORDER BY PM.PERSON_NUM), 6, 0)   -- 4. �Ϸù�ȣ.
                        || RPAD(NVL(B1.VAT_NUMBER, ' '), 10, ' ')       -- 5. ����ڹ�ȣ.
                        || RPAD(NVL(B1.VAT_NUMBER, ' '), 10, ' ')       -- 6. ���� �ٹ�ó ����ڹ�ȣ.
                        || RPAD(NVL(B1.CORP_NAME, ' '), 40, ' ')       -- 7. ���� �ٹ�ó��.
                        || LPAD(0, 2, 0)      -- 8. ��(��)�ٹ�ó ��;
                        || RPAD(NVL(PM.RESIDENT_TYPE, '1'), 1, 0)       -- 9. ������ �����ڵ�(������:1, �������:2);
                        || RPAD(CASE
                                  WHEN PM.RESIDENT_TYPE = '1' THEN ' '
                                  WHEN SUBSTR(REPLACE(PM.REPRE_NUM, '-', ''), 7, 1) BETWEEN '1' AND '4' THEN ' '  -- 1900, 2000���.
                                  WHEN SUBSTR(REPLACE(PM.REPRE_NUM, '-', ''), 7, 1) BETWEEN '9' AND '0' THEN ' '  -- 1800����..
                                  ELSE NVL(S_HN.ISO_NATION_CODE, ' ')
                                END, 2, ' ')  -- 10.�ű����� �ڵ� : ������ڸ� ���, �����ڴ� ����;
                        || RPAD(CASE
                                  WHEN RA.RETIRE_DATE_FR > TO_DATE(P_YEAR_YYYY || '-01-01', 'YYYY-MM-DD') THEN TO_CHAR(RA.RETIRE_DATE_FR, 'YYYYMMDD')
                                  WHEN PM.JOIN_DATE > TO_DATE(P_YEAR_YYYY || '-01-01', 'YYYY-MM-DD') THEN TO_CHAR(PM.JOIN_DATE, 'YYYYMMDD')
                                  ELSE TO_CHAR(P_YEAR_YYYY || '0101')
                                END, 8, 0)  -- 11. �ٹ��Ⱓ ���ۿ�����;
                        || RPAD(CASE
                                  WHEN PM.RETIRE_DATE IS NOT NULL AND PM.RETIRE_DATE < TO_DATE(P_YEAR_YYYY || '-12-31', 'YYYY-MM-DD') THEN
                                    CASE
                                      WHEN RA.RETIRE_DATE_TO < PM.RETIRE_DATE THEN TO_CHAR(RA.RETIRE_DATE_TO, 'YYYYMMDD')
                                      ELSE TO_CHAR(PM.RETIRE_DATE, 'YYYYMMDD')
                                    END
                                  ELSE P_YEAR_YYYY || '1231'
                                END, 8, 0)  -- 12. �ٹ��Ⱓ ���Ῥ����;
                        || RPAD(PM.NAME, 30, ' ')  -- 13. ����;
                        || RPAD(CASE
                                  WHEN PM.NATIONALITY_TYPE IS NOT NULL THEN PM.NATIONALITY_TYPE
                                  WHEN SUBSTR(REPLACE(PM.REPRE_NUM, '-', ''), 7, 1) BETWEEN '1' AND '4' THEN '1'  -- 1900, 2000���.
                                  WHEN SUBSTR(REPLACE(PM.REPRE_NUM, '-', ''), 7, 1) BETWEEN '9' AND '0' THEN '1'  -- 1800����.
                                  WHEN SUBSTR(REPLACE(PM.REPRE_NUM, '-', ''), 7, 1) BETWEEN '5' AND '8' THEN '9'  -- �ܱ���.
                                END, 1, 0)  -- 14. ��/�ܱ��� �����ڵ�;
                        || RPAD(NVL(REPLACE(PM.REPRE_NUM, '-', ''), ' '), 13, ' ')  -- 15.�ֹε�Ϲ�ȣ;
                        || LPAD(DECODE(NVL(RA.OFFICER_YN, 'N'), 'Y', '1', '2'), 1, '2') -- 16.�ӿ�����(1-��/2-��)--
                        -- �ٹ�ó�� �ҵ�� - ��(��)�ٹ�ó --
                        || RPAD(CASE
                                  WHEN RA.ADJUSTMENT_TYPE = 'M' THEN '5'  -- �ߵ����� --
                                  WHEN NVL(RA.OFFICER_YN, 'N') = 'Y' THEN '4'  -- �ӿ����� --
                                  ELSE NVL(S_RT.RETIRE_GROUP_CODE, '3')
                                END, 1, 0)  -- 17.��������.
                        || LPAD(NVL(RA.RETIRE_TOTAL_AMOUNT, 0), 10, 0) -- 18.�����޿�(����).
                        || LPAD(NVL(RA.HONORARY_AMOUNT, 0), 10, 0) -- 19.�����޿�(�����̿�).
                        || LPAD(0, 10, 0) -- 20.���������Ͻñ�(����).
                        || LPAD(0, 10, 0) -- 21.���������Ͻñ�(�����̿�)����;
                        || LPAD(NVL(RA.RETIRE_TOTAL_AMOUNT, 0), 10, 0) -- 22.����(����)�޿��װ�.
                        || LPAD(NVL(RA.HONORARY_AMOUNT, 0), 10, 0) -- 23.����(�����̿�)�޿��װ�.
                        || LPAD(0, 10, 0) -- 24.������ҵ�.
                        -- �ټӿ���-���������޿�.
                        || LPAD(NVL(TO_CHAR(RA.RETIRE_DATE_FR, 'YYYYMMDD'), '0'), 8, 0) --25. ��(��)�ٹ��� �Ի翬����;
                        || LPAD(NVL(TO_CHAR(RA.RETIRE_DATE_TO, 'YYYYMMDD'), '0'), 8, 0) --26. ��(��)�ٹ��� �Ի翬����;
                        || LPAD(NVL(RA.LONG_MONTH, 0), 4, 0) --27. ��(��)�ٹ��� �ټӿ���.
                        || LPAD(CASE 
                                  WHEN TRUNC(RA.DED_DAY / 30) <= 0 THEN 0
                                  WHEN TRUNC(RA.DED_DAY / 30) <= 1 THEN 1
                                  ELSE TRUNC(RA.DED_DAY / 30)
                                END, 4, 0) -- 28. ��(��)�ٹ��� ���ܿ���.
                        || LPAD(0, 4, 0) -- 29. ��(��)�ٹ��� �������.
                        || LPAD(0, 8, 0) -- 30. ��(��)�ٹ��� �Ի翬����.
                        || LPAD(0, 8, 0) -- 31. ��(��)�ٹ��� ��翬����.
                        || LPAD(0, 4, 0) -- 32. ��(��)�ٹ��� �ټӿ���.
                        || LPAD(0, 4, 0) -- 33. ��(��)�ٹ��� ���ܿ���.
                        || LPAD(0, 4, 0) -- 34. ��(��)�ٹ��� �������.
                        || LPAD(0, 4, 0) -- 35. �ߺ�����.
                        || LPAD(NVL(RA.LONG_YEAR, 0), 2, 0) --36. �ټӿ���.
                        --> �ټӿ��� -�����̿� �����޿�;
                        || LPAD(NVL(TO_CHAR(NVL(RA.H_RETIRE_DATE_FR, RA.RETIRE_DATE_FR), 'YYYYMMDD'), '0'), 8, 0) -- 25-1. ��(��)�ٹ��� �Ի翬����;
                        || LPAD(NVL(TO_CHAR(NVL(RA.H_RETIRE_DATE_TO, RA.RETIRE_DATE_TO), 'YYYYMMDD'), '0'), 8, 0) -- 26-1. ��(��)�ٹ��� ��翬����;
                        || LPAD(DECODE(NVL(RA.H_LONG_MONTH, 0), 0, NVL(RA.LONG_MONTH, 0), NVL(RA.H_LONG_MONTH, 0)), 4, 0) -- 27-1. ��(��)�ٹ��� �ټӿ���.
                        || LPAD(/*CASE 
                                  WHEN TRUNC(NVL(RA.DED_DAY, 0) / 30) <= 0 THEN 0
                                  WHEN TRUNC(NVL(RA.DED_DAY, 0) / 30) <= 1 THEN 1
                                  ELSE TRUNC(NVL(RA.DED_DAY / 30)
                                END*/0, 4, 0) -- 28-1. ��(��)�ٹ��� ���ܿ���.
                        || LPAD(0, 4, 0) -- 29_1. ��(��)�ٹ����������.
                        || LPAD(0, 8, 0) -- 30-1. ��(��)�ٹ��� �Ի翬����.
                        || LPAD(0, 8, 0) -- 31-1. ��(��)�ٹ��� ��翬����.
                        || LPAD(0, 4, 0) -- 32-1. ��(��)�ٹ��� �ټӿ���.
                        || LPAD(0, 4, 0) -- 33-1. ��(��)�ٹ��� ���ܿ���.
                        || LPAD(0, 4, 0) -- 34-1.��(��)�ٹ����������.
                        || LPAD(0, 4, 0) -- 35-1. �ߺ�����.
                        || LPAD(DECODE(NVL(RA.H_LONG_YEAR, 0), 0, NVL(RA.LONG_YEAR, 0), NVL(RA.H_LONG_YEAR, 0)), 2, 0) -- 36-1. �ټӿ���.
                        --> ��(��)�ٹ��� �������ݸ�.
                        || LPAD(DECODE(SQ1.ACCOUNT_NUM, NULL, ' ', SQ1.ACCOUNT_NUM), 20, ' ') -- 37.�������ݰ��¹�ȣ;
                        || LPAD(DECODE(SQ1.ACCOUNT_NUM, NULL, 0, NVL(RA.RETIRE_TOTAL_AMOUNT, 0)), 10, 0) -- 38.���������Ͻñ��Ѽ��ɾ�.
                        || LPAD(DECODE(SQ1.ACCOUNT_NUM, NULL, 0, NVL(RA.RETIRE_TOTAL_AMOUNT, 0)), 10, 0) -- 39.�������ݿ������հ��.
                        || LPAD(0, 10, 0) -- 40.�������ݼҵ��ں��Ծ�.
                        || LPAD(0, 10, 0) -- 41.�������ݼҵ������.
                        || LPAD(DECODE(SQ1.ACCOUNT_NUM, NULL, 0,NVL(RA.RETIRE_TOTAL_AMOUNT, 0)), 10, 0) -- 42.���������Ͻñ�.
                        --> ��(��)�ٹ��� �������ݸ�.
                        || LPAD(' ', 20, ' ') -- 37-1.�������ݰ��¹�ȣ.
                        || LPAD(0, 10, 0) -- 38-1.���������Ͻñ��Ѽ��ɾ�.
                        || LPAD(0, 10, 0) -- 39-1.�������ݿ������հ��.
                        || LPAD(0, 10, 0) -- 40-1.�������ݼҵ��ں��Ծ�.
                        || LPAD(0, 10, 0) -- 41-1.�������ݼҵ������.
                        || LPAD(0, 10, 0) -- 42-1.���������Ͻñ�.
                        --> ����ȯ���-���������޿�;
                        || LPAD(0, 10, 0) -- 43.���������Ͻñ����޿����-��(��);
                        || LPAD(0, 10, 0) -- 44.���������Ͻñ����޿����-��(��);
                        || LPAD(0, 10, 0) -- 45.���������Ͻñ����޿���� �����̿��ݾ�-��(��)(���������Ͻñ�����);
                        || LPAD(0, 10, 0) -- 46.���������Ͻñ����޿���� �����̿��ݾ�-��(��)(���������Ͻñ�����);
                        || LPAD(0, 10, 0) -- 47.������������޿���-��(��);
                        || LPAD(0, 10, 0) -- 48.������������޿���-��(��);
                        || LPAD(0, 10, 0) -- 49. �����������Ͻñ�.
                        || LPAD(0, 10, 0) -- 50. ���ɰ��������޿���.
                        || LPAD(0, 10, 0) -- 51. ȯ�������ҵ����.
                        || LPAD(0, 10, 0) -- 52. ȯ�������ҵ� ����ǥ��.
                        || LPAD(0, 10, 0) -- 53. ȯ�꿬��հ���ǥ��.
                        || LPAD(0, 10, 0) -- 54. ȯ�꿬��ջ��⼼��.
                       --> ����ȯ���-�����̿� �����޿�;
                        || LPAD(0, 10, 0) --43-1. ���������Ͻñ����޿����-��(��);
                        || LPAD(0, 10, 0) --44-1. ���������Ͻñ����޿����-��(��);
                        || LPAD(0, 10, 0) --45-1. ���������Ͻñ����޿���� �����̿��ݾ�-��(��)(���������Ͻñ�����);
                        || LPAD(0, 10, 0) --46-1. ���������Ͻñ����޿���� �����̿��ݾ�-��(��)(���������Ͻñ�����);
                        || LPAD(0, 10, 0) --47-1. ������������޿���-��(��);
                        || LPAD(0, 10, 0) --48-1. ������������޿���-��(��);
                        || LPAD(0, 10, 0) --49-1. �����������Ͻñ�.
                        || LPAD(0, 10, 0) --50-1. ���ɰ��� �����޿���.
                        || LPAD(0, 10, 0) --51-1. ȯ�������ҵ����.
                        || LPAD(0, 10, 0) --52-1. ȯ�������ҵ� ����ǥ��.
                        || LPAD(0, 10, 0) --53-1. ȯ�꿬��հ���ǥ��.
                        || LPAD(0, 10, 0) --54-1. ȯ�꿬��ջ��⼼��.
                        
                        --> ����� - ���������޿�;
                        || LPAD(NVL(RA.RETIRE_TOTAL_AMOUNT, 0), 10, 0) -- 55.�����޿���.
                        || LPAD(CASE
                                  WHEN NVL(RA.RETIRE_TOTAL_AMOUNT, 0) < (NVL(RA.INCOME_DED_AMOUNT, 0) + NVL(RA.LONG_DED_AMOUNT, 0)) THEN NVL(RA.RETIRE_TOTAL_AMOUNT, 0)
                                  ELSE (NVL(RA.INCOME_DED_AMOUNT, 0) + NVL(RA.LONG_DED_AMOUNT, 0))
                                END, 10, 0) -- 56. �����ҵ����.
                        || LPAD(NVL(RA.TAX_STD_AMOUNT, 0), 10, 0) -- 57. �����ҵ����ǥ��.
                        || LPAD(NVL(RA.AVG_TAX_STD_AMOUNT, 0), 10, 0) -- 58. ����հ���ǥ��.
                        || LPAD(NVL(RA.AVG_COMP_TAX_AMOUNT, 0), 10, 0) -- 59. ����� ���⼼��.
                        || LPAD(NVL(RA.COMP_TAX_AMOUNT, 0), 10, 0) -- 60. ���⼼��.
                        --|| LPAD(NVL(HA.TAX_DED_AMT, 0), 10, 0) -- AS �����ҵ漼�װ���;
                        || LPAD(0, 10, 0) -- 61. �ܱ����μ��װ���.
                        --> ����� - �����̿������޿�;
                        || LPAD(NVL(RA.HONORARY_AMOUNT, 0), 10, 0) -- 55-1. �����޿���.
                        || LPAD(CASE
                                  WHEN NVL(RA.HONORARY_AMOUNT, 0) < (NVL(RA.H_INCOME_DED_AMOUNT, 0) + NVL(RA.H_LONG_DED_AMOUNT, 0)) THEN NVL(RA.HONORARY_AMOUNT, 0)
                                  ELSE (NVL(RA.H_INCOME_DED_AMOUNT, 0) + NVL(RA.H_LONG_DED_AMOUNT, 0))
                                END, 10, 0) -- 56.-1 �����ҵ����.
                        || LPAD(NVL(RA.H_TAX_STD_AMOUNT, 0), 10, 0) -- 57-1. �����ҵ����ǥ��.
                        || LPAD(NVL(RA.H_AVG_TAX_STD_AMOUNT, 0), 10, 0) -- 58-1. ����հ���ǥ��.
                        || LPAD(NVL(RA.H_AVG_COMP_TAX_AMOUNT, 0), 10, 0) -- 59-1. ����ջ��⼼��.
                        || LPAD(NVL(RA.H_COMP_TAX_AMOUNT, 0), 10, 0) -- 60-1. ���⼼��.
                        || LPAD(0, 10, 0) -- 61-1. �ܱ����μ��װ���.

                       --> ����� ��(�����(���������޿�) + �����(�����̿������޿�))
                        || LPAD(NVL(RA.RETIRE_TOTAL_AMOUNT, 0) + NVL(RA.HONORARY_AMOUNT, 0), 10, 0) -- 62. �����޿���.
                        || LPAD(CASE
                                  WHEN NVL(RA.RETIRE_TOTAL_AMOUNT, 0) < (NVL(RA.INCOME_DED_AMOUNT, 0) + NVL(RA.LONG_DED_AMOUNT, 0)) THEN NVL(RA.RETIRE_TOTAL_AMOUNT, 0)
                                  ELSE (NVL(RA.INCOME_DED_AMOUNT, 0) + NVL(RA.LONG_DED_AMOUNT, 0))
                                END + 
                                CASE
                                  WHEN NVL(RA.HONORARY_AMOUNT, 0) < (NVL(RA.H_INCOME_DED_AMOUNT, 0) + NVL(RA.H_LONG_DED_AMOUNT, 0)) THEN NVL(RA.HONORARY_AMOUNT, 0)
                                  ELSE (NVL(RA.H_INCOME_DED_AMOUNT, 0) + NVL(RA.H_LONG_DED_AMOUNT, 0))
                                END, 10, 0) -- 63. �����ҵ����.
                        || LPAD(NVL(RA.TAX_STD_AMOUNT, 0) + NVL(RA.H_TAX_STD_AMOUNT, 0), 10, 0) -- 64. �����ҵ����ǥ��.
                        || LPAD(NVL(RA.AVG_TAX_STD_AMOUNT, 0) + NVL(RA.H_AVG_TAX_STD_AMOUNT, 0), 10, 0) -- 65. ����հ���ǥ��.
                        || LPAD(NVL(RA.AVG_COMP_TAX_AMOUNT, 0) + NVL(RA.H_AVG_COMP_TAX_AMOUNT, 0), 10, 0) -- 66. ����ջ��⼼��.
                        || LPAD(NVL(RA.COMP_TAX_AMOUNT, 0) + NVL(RA.H_COMP_TAX_AMOUNT, 0), 10, 0) -- 67. ���⼼��.
                        --|| LPAD(NVL(HA.TAX_DED_AMT, 0), 10, 0) -- AS �����ҵ漼�װ���;
                        || LPAD(0, 10, 0) -- 68. �ܱ����μ��װ���.
                       --> ��������.
                        || LPAD(NVL(RA.INCOME_TAX_AMOUNT, 0) + NVL(RA.H_INCOME_TAX_AMOUNT, 0), 10, 0) -- 69. �ҵ漼��.
                        || LPAD(NVL(RA.RESIDENT_TAX_AMOUNT, 0) + NVL(RA.H_RESIDENT_TAX_AMOUNT, 0), 10, 0) -- 70. �ֹμ�
                        || LPAD(NVL(RA.SP_TAX_AMOUNT, 0) + NVL(RA.H_SP_TAX_AMOUNT, 0), 10, 0) -- 71. ��Ư��
                        || LPAD(NVL(RA.INCOME_TAX_AMOUNT, 0) + NVL(RA.RESIDENT_TAX_AMOUNT, 0) + NVL(RA.SP_TAX_AMOUNT, 0), 10, 0) -- 72. ��.
                       --> ��(��)�ٹ���;
                        || LPAD(0, 10, 0) -- 73. �ҵ漼.
                        || LPAD(0, 10, 0) -- 74. �ֹμ�.
                        || LPAD(0, 10, 0) -- 75. ��Ư��.
                        || LPAD(0, 10, 0) -- 76. ��.
                        || RPAD(' ', 7, ' ') AS RECORD_FILE
                        , PM.PERSON_ID  -- ���ID.
                        , REPLACE(PM.REPRE_NUM, '-') AS REPRE_NUM  -- �ֹι�ȣ.
                        , NVL(B1.TAX_OFFICE_CODE, ' ') AS TAX_OFFICE_CODE --�������ڵ�.
                        , NVL(B1.VAT_NUMBER, ' ') AS VAT_NUMBER  -- ����ڹ�ȣ.
                        , ROW_NUMBER() OVER(PARTITION BY RA.ADJUSTMENT_YYYY ORDER BY PM.PERSON_NUM) AS C_SEQ_NO
                        , NVL(RA.RETIRE_TOTAL_AMOUNT, 0) AS RETIRE_TOTAL_AMOUNT  -- ���������޿���.
                        , NVL(RA.HONORARY_AMOUNT, 0) AS HONORARY_AMOUNT  -- ������ �����޿���.
                        , NVL(RA.INCOME_TAX_AMOUNT, 0) + NVL(RA.H_INCOME_TAX_AMOUNT, 0) AS INCOME_TAX_AMOUNT  -- �����̿�����.
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
                        , ( -- ��������.
                            SELECT HC.COMMON_ID AS RETIRE_ID
                                , HC.CODE AS RETIRE_CODE
                                , HC.CODE_NAME AS RETIRE_NAME
                                , HC.VALUE1 AS RETIRE_GROUP_CODE
                              FROM HRM_COMMON HC
                            WHERE HC.GROUP_CODE         = 'RETIRE'
                              AND HC.SOB_ID             = P_SOB_ID
                              AND HC.ORG_ID             = P_ORG_ID
                          ) S_RT
                        , ( -- �������� ���¹�ȣ --
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
            --> ��(��)�ٹ�ó ���ڵ� <--

--E1 ------------------------------------------------------------------------------------
            --> �����̿����� ���ڵ� <--
            FOR E1 IN ( SELECT 'E'  
                             || '25'  -- �ڷᱸ��.
                             || RPAD(NVL(B1.TAX_OFFICE_CODE, ' '), 3, ' ')   -- 3.�������ڵ�.
                             || LPAD(ROW_NUMBER() OVER(PARTITION BY RP.PERSON_ID ORDER BY RP.PERSON_ID), 6, 0)   -- 4. �Ϸù�ȣ.
                             --> ��õ¡���ǹ��� --
                             || RPAD(NVL(B1.VAT_NUMBER, ' '), 10, ' ')       -- 5. ����ڹ�ȣ.
                             || RPAD(' ', 50, ' ')  -- 6. ����.
                             || RPAD(NVL(REPLACE(C1.REPRE_NUM, '-', ''), ' '), 13, ' ') -- 7.�ҵ��� �ֹι�ȣ.
                             -- �����̿����� --
                             || RPAD(NVL(REPLACE(RP.CORP_NAME, ' ', ''), ' '), 40, ' ')  -- 8.�������ݻ���ڸ�.
                             || RPAD(NVL(REPLACE(RP.TAX_REG_NUM, '-', ''), ' '), 10, ' ')  -- 9.�������ݻ������ ����ڵ�Ϲ�ȣ.
                             || RPAD(NVL(REPLACE(RP.ACCOUNT_NUM, '-', ''), ' '), 20, ' ')  -- 10.���¹�ȣ.
                             || LPAD(NVL(C1.RETIRE_TOTAL_AMOUNT, 0), 11, 0) -- 11.�Աݱݾ�-���������޿���.
                             || LPAD(NVL(C1.HONORARY_AMOUNT, 0), 11, 0) -- 12.�Աݱݾ�-�����������޿���.
                             || RPAD(TO_CHAR(RP.ISSUE_DATE, 'YYYYMMDD'), 8, ' ')  -- 13.�Ա���.
                             || RPAD(NVL(TO_CHAR(RP.DUE_DATE, 'YYYYMMDD'), ' '), 8, ' ') -- 14.������.
                             || LPAD(NVL(C1.INCOME_TAX_AMOUNT, 0), 11, 0) -- 15.�����̿�����.
                             || LPAD(ROW_NUMBER() OVER(PARTITION BY RP.PERSON_ID ORDER BY RP.PERSON_ID), 2, 0) -- 16.�����̿����� �Ϸù�ȣ.
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
-- ���� DATA INSERT.
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
