CREATE OR REPLACE PACKAGE HRR_RETIRE_FILE_G
AS

-------------------------------------------------------------------------------
-- �������� �������� ���� ��� SELECT.
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
-- �����ҵ� ���ϻ��� �� ��ȸ.
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
-- �����ҵ� ���ϻ��� : ������ �ο��� RETURN.
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
-- 2013�⵵ �����ҵ� ���ϻ��� �� ��ȸ.
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
-- ���� DATA INSERT.
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
                   /*, ( -- ���� �λ系��.
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
-- �����ҵ� ���ϻ��� �� ��ȸ.
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

    -- TEMPORARY ����.
    DELETE FROM HRM_REPORT_FILE_GT RF
    WHERE RF.SOB_ID           = P_SOB_ID
      AND RF.ORG_ID           = P_ORG_ID
    ;
    IF P_YEAR_YYYY = '2011' THEN
      -- 2011�⵵ --
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
      -- 2012�⵵ --
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
      -- 2013�⵵ --
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
-- �����ҵ� ���ϻ��� : ������ �ο��� RETURN.
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
                                  WHEN NVL(RA.DED_DAY, 0) < 0 
                                    THEN  CASE 
                                            WHEN TRUNC(RA.DED_DAY / 30) <= 0 THEN 0
                                            WHEN TRUNC(RA.DED_DAY / 30) <= 1 THEN 1
                                            ELSE TRUNC(RA.DED_DAY / 30)
                                          END
                                  ELSE 0
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
                                  WHEN NVL(RA.DED_DAY, 0) < 0 
                                    THEN  CASE 
                                            WHEN TRUNC(RA.DED_DAY / 30) <= 0 THEN 0
                                            WHEN TRUNC(RA.DED_DAY / 30) <= 1 THEN 1
                                            ELSE TRUNC(RA.DED_DAY / 30)
                                          END
                                  ELSE 0
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
-- 2013�⵵ �����ҵ� ���ϻ��� �� ��ȸ.
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
    FOR A1 IN ( SELECT 'A'   -- 1.�ڷ������ȣ.
                    || '25'  -- 2.�����ٷμҵ�(20);
                    || LPAD(REPLACE(OU.TAX_OFFICE_CODE, '-', ''), 3, 0)  -- 3.������ �ڵ�;
                    || TO_CHAR(P_WRITE_DATE, 'YYYYMMDD')  -- 4.�ڷḦ �������� �����ϴ� ������;
                    --> ������;
                    || LPAD(NVL(P_SUBMIT_AGENT, '2'), 1, 0)  -- 5.�����ڱ���(�����븮��1, ����2, ����3);
                    || RPAD(NVL(P_TAX_AGENT, ' '), 6, ' ')  -- 6.�����븮�� ������ȣ(�ڷ������ڰ� �����븮���ΰ�� ����);
                    || RPAD(NVL(P_HOMETAX_LOGIN_ID, ' '), 20, ' ')  -- 7.Ȩ�ý�ID;
                    || RPAD(NVL(P_TAX_PROGRAM_CODE, '1001'), 4, ' ')  -- 8.�������α׷��ڵ�;
                    || RPAD(NVL(REPLACE(OU.VAT_NUMBER, '-', ''), ' '), 10, ' ')  -- 9.����ڵ�Ϲ�ȣ;
                    || RPAD(NVL(CM.CORP_NAME, ' '), 40, ' ')  -- 10.���θ�(��ȣ);
                    || RPAD(NVL(S_PM.DEPT_NAME, ' '), 30, ' ')  -- 11.�����(������) �μ�;
                    || RPAD(NVL(S_PM.NAME, ' '), 30, ' ')  -- 12.�����(������) ����;
                    || RPAD(NVL(REPLACE(CM.TEL_NUMBER, '-', ''), ' '), 15, ' ')  -- 13.�����(������) ��ȭ��ȣ;
                    --> ���⳻��.
                    || LPAD(1, 5, 0)  -- 14.�Ű��ǹ��ڼ� (B���ڵ�);
                    || LPAD(NVL(P_USE_LANGUAGE_CODE, '101'), 3, 0)  -- 15.����ѱ��ڵ�;
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
      FOR B1 IN ( SELECT --> �ڷ������ȣ;
                         'B'    -- ���ڵ� ����;
                      || '25'  -- �����ٷμҵ�(20);
                      || LPAD(REPLACE(OU.TAX_OFFICE_CODE, '-', ''), 3, 0)   -- 3.�������ڵ�;
                      || LPAD(1, 6, 0)                                      -- 4.B���ڵ��� �Ϸù�ȣ;
                      --> ������;
                      || RPAD(NVL(REPLACE(OU.VAT_NUMBER, '-', ''), ' '), 10, ' ')      -- 5.��õ¡���ǹ����� ����ڵ�Ϲ�ȣ;
                      || RPAD(NVL(CM.CORP_NAME, ' '), 40, ' ')              -- 6.���θ�(��ȣ);
                      || RPAD(NVL(CM.PRESIDENT_NAME, ' '), 30, ' ')         -- 7.��ǥ�� ����;
                      || RPAD(NVL(REPLACE(CM.LEGAL_NUMBER, '-', ''), ' '), 13, ' ') -- 8.���ε�Ϲ�ȣ;
                      || LPAD('1', 1, 0)  -- 9.¡���ǹ��� ����(�����1/�������ݻ����2/�������ݻ����3) --
                      --> ���⳻��;
                      || LPAD(NVL(S_RA.PERSON_COUNT, 0), 7, 0)   -- 10.������ C���ڵ��� ��(�ٷμҵ����� ��);
                      || LPAD(' ', 7, ' ')   -- 11.2013�⵵ ���� : ���� ó��  
                      || LPAD(NVL(S_RA.RETIRE_TOTAL_AMOUNT, 0), 14, 0)      --12.�����޿��� �Ѱ�(C���ڵ� �����޿� ��);
                      || LPAD(CASE 
                                WHEN NVL(S_RA.INCOME_TAX_AMOUNT, 0) < 0 THEN 1
                                ELSE 0
                              END, 1, 0)                                        --13.1 �Ű��� �ҵ漼�հ� ��ȣ(0-���, 1-����) 
                      || LPAD(ABS(NVL(S_RA.INCOME_TAX_AMOUNT, 0)), 13, 0)       --13.2 �ҵ漼 �������� �Ѱ�(C���ڵ� �ҵ漼�� ��);
                      || LPAD(NVL(S_RA.TRANS_INCOME_TAX_AMOUNT, 0), 13, 0)      --14. �̿������ҵ漼���հ� 
                      || LPAD(CASE
                                WHEN NVL(S_RA.SUB_INCOME_TAX_AMOUNT, 0) < 0 THEN 1
                                ELSE 0
                              END, 1, 0)                                        --15.2 ������õ¡��-�ҵ漼�� �հ� ��ȣ 
                      || LPAD(ABS(NVL(S_RA.SUB_INCOME_TAX_AMOUNT, 0)), 13, 0)   --15.2 ������õ¡��-�ҵ漼�� �հ� 
                      || LPAD(CASE
                                WHEN NVL(S_RA.SUB_RESIDENT_TAX_AMOUNT, 0) < 0 THEN 1
                                ELSE 0
                              END, 1, 0)                                        --16.1 ������õ¡��-����ҵ漼�� �հ� ��ȣ 
                      || LPAD(ABS(NVL(S_RA.SUB_RESIDENT_TAX_AMOUNT, 0)), 13, 0) --16.2 ������õ¡��-����ҵ漼�� �հ� 
                      || LPAD(CASE
                                WHEN NVL(S_RA.SUB_SP_TAX_AMOUNT, 0) < 0 THEN 1
                                ELSE 0
                              END, 1, 0)                                        --17.1 ������õ¡��-��Ư���� �հ� ��ȣ 
                      || LPAD(ABS(NVL(S_RA.SUB_SP_TAX_AMOUNT, 0)), 13, 0)       --17.2 ������õ¡��-��Ư���� �հ� 
                      || LPAD(CASE
                                WHEN NVL(S_RA.SUB_TAX_AMOUNT, 0) < 0 THEN 1
                                ELSE 0
                              END, 1, 0)                                        --18.1 ������õ¡��-���� �հ� ��ȣ 
                      || LPAD(ABS(NVL(S_RA.SUB_TAX_AMOUNT, 0)), 13, 0)          --18.2 ������õ¡��-���� �հ� 
                      || RPAD(' ', 1183, ' ') AS RECORD_FILE
                      , CM.CORP_NAME  -- ���θ�.
                      , LPAD(REPLACE(OU.TAX_OFFICE_CODE, '-', ''), 3, 0) AS TAX_OFFICE_CODE
                      , RPAD(NVL(REPLACE(OU.VAT_NUMBER, '-', ''), ' '), 10, ' ') AS VAT_NUMBER
                    FROM HRM_CORP_MASTER CM
                       , HRM_OPERATING_UNIT OU
                       , ( -- ���⳻��.
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
                                    END) AS SUB_INCOME_TAX_AMOUNT  -- ���� �ҵ漼  
                              , SUM(CASE
                                      WHEN SQ1.ACCOUNT_NUM IS NOT NULL THEN 0
                                      ELSE TRUNC((NVL(RA.COMP_TAX_AMOUNT_1, 0) +
                                                  NVL(RA.COMP_TAX_AMOUNT_2, 0)) / 10)
                                    END) AS SUB_RESIDENT_TAX_AMOUNT  -- ���� ����ҵ漼 
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
                               /*, ( -- ���� �λ系��.
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
                          WHERE RA.PERSON_ID          = PM.PERSON_ID
                            /*AND PM.PERSON_ID          = T1.PERSON_ID */
                            AND RA.PERSON_ID          = SQ1.PERSON_ID(+)  
                            --AND T1.OPERATING_UNIT_ID  = A1.OPERATING_UNIT_ID -- ����� 
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
                          'C'                                           -- 1.�ڷ������ȣ.
                        || '25'                                         -- 2.
                        || RPAD(NVL(B1.TAX_OFFICE_CODE, ' '), 3, ' ')   -- 3.�������ڵ�.
                        || LPAD(ROW_NUMBER() OVER(PARTITION BY RA.ADJUSTMENT_YYYY ORDER BY PM.PERSON_NUM), 6, 0)   -- 4. �Ϸù�ȣ.
                        
                        -- [��õ¡���ǹ���] -- 
                        || RPAD(NVL(B1.VAT_NUMBER, ' '), 10, ' ')       -- 5. ����ڹ�ȣ.
                        || RPAD('1', 1, 1)                              -- 6. ¡���ǹ��� ���� 
                        
                        -- [�ҵ���] -- 
                        || RPAD(NVL(PM.RESIDENT_TYPE, '1'), 1, 0)       -- 7. ������ �����ڵ�(������:1, �������:2);
                        || RPAD(CASE
                                  WHEN PM.NATIONALITY_TYPE IS NOT NULL THEN PM.NATIONALITY_TYPE
                                  WHEN SUBSTR(REPLACE(PM.REPRE_NUM, '-', ''), 7, 1) BETWEEN '1' AND '4' THEN '1'  -- 1900, 2000���.
                                  WHEN SUBSTR(REPLACE(PM.REPRE_NUM, '-', ''), 7, 1) BETWEEN '9' AND '0' THEN '1'  -- 1800����.
                                  WHEN SUBSTR(REPLACE(PM.REPRE_NUM, '-', ''), 7, 1) BETWEEN '5' AND '8' THEN '9'  -- �ܱ���.
                                END, 1, 0)                              -- 8. ��/�ܱ��� �����ڵ�;                                
                        || RPAD(CASE
                                  WHEN PM.RESIDENT_TYPE = '1' THEN ' '
                                  WHEN SUBSTR(REPLACE(PM.REPRE_NUM, '-', ''), 7, 1) BETWEEN '1' AND '4' THEN ' '  -- 1900, 2000���.
                                  WHEN SUBSTR(REPLACE(PM.REPRE_NUM, '-', ''), 7, 1) BETWEEN '9' AND '0' THEN ' '  -- 1800����..
                                  ELSE NVL(S_HN.ISO_NATION_CODE, ' ')
                                END, 2, ' ')                            -- 9.�ű����� �ڵ� : ������ڸ� ���, �����ڴ� ����;
                        || RPAD(PM.NAME, 30, ' ')                       -- 10. ����;
                        || RPAD(NVL(REPLACE(PM.REPRE_NUM, '-', ''), ' '), 13, ' ')      -- 11.�ֹε�Ϲ�ȣ;
                        || LPAD(DECODE(NVL(RA.OFFICER_YN, 'N'), 'Y', '1', '2'), 1, '2') -- 12.�ӿ�����(1-��/2-��)--
                        || LPAD(CASE
                                 WHEN SQ1.ISSUE_DATE IS NULL THEN '0'
                                 ELSE NVL(TO_CHAR(SQ1.ISSUE_DATE, 'YYYYMMDD'), '0')
                               END, 8, '0')                                             -- 13. Ȯ���޿��� ������������ ������ 
                        || LPAD(CASE
                                  WHEN TO_CHAR(NVL(PM.ORI_JOIN_DATE, PM.JOIN_DATE), 'YYYYMMDD') > '20111231' THEN 0  -- 2012�� ���� �Ի��ڴ� ����  
                                  WHEN NVL(RA.OFFICER_YN, 'N') = 'Y' THEN 0  -- �ӿ��� ��츸 ����  
                                  ELSE 0
                                END, 11, '0')                           -- 14.11. 2011.12.31 ������ 
                        || RPAD(CASE
                                  WHEN RA.RETIRE_DATE_FR > TO_DATE(P_YEAR_YYYY || '-01-01', 'YYYY-MM-DD') THEN TO_CHAR(RA.RETIRE_DATE_FR, 'YYYYMMDD')
                                  WHEN PM.JOIN_DATE > TO_DATE(P_YEAR_YYYY || '-01-01', 'YYYY-MM-DD') THEN TO_CHAR(PM.JOIN_DATE, 'YYYYMMDD')
                                  ELSE TO_CHAR(P_YEAR_YYYY || '0101')
                                END, 8, 0)                              -- 15. �ٹ��Ⱓ ���ۿ�����;
                        || RPAD(CASE
                                  WHEN PM.RETIRE_DATE IS NOT NULL AND PM.RETIRE_DATE < TO_DATE(P_YEAR_YYYY || '-12-31', 'YYYY-MM-DD') THEN
                                    CASE
                                      WHEN RA.RETIRE_DATE_TO < PM.RETIRE_DATE THEN TO_CHAR(RA.RETIRE_DATE_TO, 'YYYYMMDD')
                                      ELSE TO_CHAR(PM.RETIRE_DATE, 'YYYYMMDD')
                                    END
                                  ELSE P_YEAR_YYYY || '1231'
                                END, 8, 0)                              -- 16. �ٹ��Ⱓ ���Ῥ����;
                        || RPAD(CASE
                                  WHEN RA.ADJUSTMENT_TYPE = 'M' THEN '5'       -- �ߵ����� --
                                  WHEN NVL(RA.OFFICER_YN, 'N') = 'Y' THEN '4'  -- �ӿ����� --
                                  ELSE NVL(S_RT.RETIRE_GROUP_CODE, '3')
                                END, 1, 0)                              -- 17.��������.
                                
                        -- [�����޿� ��Ȳ - �߰����޵�] --         
                        || RPAD(' ', 40, ' ')                           -- 18.13. �ٹ�ó��         
                        || RPAD(' ', 10, ' ')                           -- 19.14.�ٹ�ó����ڵ�Ϲ�ȣ 
                        || LPAD(0, 11, 0)                               -- 20.15.�����޿�(����)(�ӿ������ҵ� �ѵ��ʰ��ݾ� ����).
                        || LPAD(0, 11, 0)                               -- 21.16.����� �����޿�;
                        || LPAD(0, 11, 0)                               -- 22.17.������� �����޿�.
                                
                        -- [�����޿� ��Ȳ - ������] -- 
                        || RPAD(NVL(B1.CORP_NAME, ' '), 40, ' ')        -- 23.13. �ٹ�ó��         
                        || RPAD(NVL(B1.VAT_NUMBER, ' '), 10, ' ')       -- 24.14. �ٹ�ó����ڵ�Ϲ�ȣ
                        || LPAD(NVL(RA.RETIRE_TOTAL_AMOUNT, 0), 11, 0)  -- 25.15. �����޿�(����)(�ӿ������ҵ� �ѵ��ʰ��ݾ� ����).
                        || LPAD(0, 11, 0) -- 26.16. ����� �����޿�;
                        || LPAD(NVL(RA.RETIRE_TOTAL_AMOUNT, 0), 11, 0)  -- 27.17. ������� �����޿�.
                        
                        -- [�����޿���Ȳ - ����] --                         
                        || LPAD(NVL(RA.RETIRE_TOTAL_AMOUNT, 0), 11, 0)  -- 28.15. ���������Ͻñ�(�����̿�)����;
                        || LPAD(0, 11, 0)                               -- 29.16. ����(����)�޿��װ�.
                        || LPAD(NVL(RA.RETIRE_TOTAL_AMOUNT, 0), 11, 0)  -- 30.17. ������������޿�.
                                
                        -- [�ټӿ��� -�߰����޵�] -- 
                        || LPAD(0, 8, 0)                                --31.18. �Ի��� - �߰����� �� �ٹ�ó �Ի��� ����                              
                        || LPAD('0', 8, 0)                              --32.19. ����� - �߰����� �� �ٹ�ó �Ի��� ���� 
                        || LPAD('0', 8, 0)                              --33.20. ����� - �߰����� �� �ٹ�ó ����� ����
                        || LPAD('0', 8, 0)                              --34.21. ������ - ������ �������� ����                                                                                
                        || LPAD(0, 4, 0)                                --35.22. �ټӿ���.
                        || LPAD(0, 4, 0)                                --36.23. ���ܿ��� 
                        || LPAD(0, 4, 0)                                --37.24. �������
                        || LPAD(0, 4, 0)                                --38.25. �ߺ�����        
                        || LPAD(0, 4, 0)                                --39.26. �ټӿ��� 
                                
                        -- [�ټӿ��� - ����] -- 
                        || LPAD(NVL(TO_CHAR(PM.JOIN_DATE, 'YYYYMMDD'), '0'), 8, 0)        --40.18. �Ի��� - �߰����� �� �ٹ�ó �Ի��� ����                              
                        || LPAD(NVL(TO_CHAR(RA.RETIRE_DATE_FR, 'YYYYMMDD'), '0'), 8, 0)   --41.19. ����� - �߰����� �� �ٹ�ó �Ի��� ���� 
                        || LPAD(NVL(TO_CHAR(RA.RETIRE_DATE_TO, 'YYYYMMDD'), '0'), 8, 0)   --42.20. ����� - �߰����� �� �ٹ�ó ����� ����
                        || LPAD(NVL(TO_CHAR(NVL(RA.CLOSED_DATE, (RA.RETIRE_DATE_TO + 5)), 'YYYYMMDD'), '0'), 8, 0)      --43.21. ������ - ������ �������� ����                                                                                
                        || LPAD(NVL(RA.LONG_MONTH, 0), 4, 0)                              --44.22. �ټӿ���.
                        || LPAD(/*CASE
                                  WHEN NVL(RA.DED_DAY, 0) < 0 THEN CEIL(RA.DED_DAY / 30)
                                  ELSE 0
                                END*/NVL(RA.DED_DAY, 0), 4, 0)                                                --45.23. ���ܿ��� 
                        || LPAD(/*CASE
                                  WHEN NVL(RA.DED_DAY, 0) > 0 THEN CEIL(RA.DED_DAY / 30)
                                  ELSE 0
                                END*/0, 4, 0)                                                --46.24. �������
                        || LPAD(0, 4, 0)                                                  --47.25. �ߺ�����        
                        || LPAD(NVL(RA.LONG_YEAR, 0), 4, 0)                               --48.26. �ټӿ��� 
                        
                        -- [�ټӿ��� - ����] -- 
                        || LPAD(0, 8, 0)                                                  --49.18. �Ի��� 
                        || LPAD(NVL(TO_CHAR(RA.RETIRE_DATE_FR, 'YYYYMMDD'), '0'), 8, 0)   --50.19. ����� - �߰����� �Ǵ� ������ ������� ���� ����  
                        || LPAD(NVL(TO_CHAR(RA.RETIRE_DATE_TO, 'YYYYMMDD'), '0'), 8, 0)   --51.20. ����� 
                        || LPAD(0, 8, 0)                                                  --52.21. ������ 
                        || LPAD(NVL(RA.LONG_MONTH, 0), 4, 0)                              --53.22. �ټӿ���   
                        || LPAD(/*CASE
                                  WHEN NVL(RA.DED_DAY, 0) < 0 THEN CEIL(RA.DED_DAY / 30)
                                  ELSE 0
                                END*/NVL(RA.DED_DAY, 0), 4, 0)                                                --54.23. ���ܿ��� 
                        || LPAD(/*CASE
                                  WHEN NVL(RA.DED_DAY, 0) > 0 THEN CEIL(RA.DED_DAY / 30)
                                  ELSE 0
                                END*/0, 4, 0)                                                --55.24. �������       
                        || LPAD(0, 4, 0)                                                  --56.25. �ߺ�����
                        || LPAD(NVL(RA.LONG_YEAR, 0), 4, 0)                               --57.26. �ټӿ���   
                        
                        -- [�ټӿ��� - �Ⱥ� - 2013.12.31 ����] --               
                        || LPAD(0, 8, 0)                                                  --58.18. �Ի���                                 
                        || LPAD(CASE
                                  WHEN NVL(RA.LONG_DAY_1, 0) = 0 THEN NVL(TO_CHAR(RA.RETIRE_DATE_FR, 'YYYYMMDD'), '0')
                                  ELSE NVL(TO_CHAR(RA.RETIRE_DATE_FR, 'YYYYMMDD'), '0') 
                                END, 8, 0)                                                --59.19. ����� 
                        || LPAD(CASE
                                  WHEN NVL(RA.LONG_DAY_1, 0) = 0 THEN TO_CHAR(RA.RETIRE_DATE_TO, 'YYYYMMDD') 
                                  ELSE '20121231' 
                                END, 8, 0)                                                --60.20. �����
                        || LPAD(0, 8, 0)                                                  --61.21. ������
                        || LPAD(CASE
                                  WHEN NVL(RA.LONG_DAY_1, 0) = 0 THEN NVL(RA.LONG_MONTH_1, 0)
                                  ELSE NVL(RA.LONG_MONTH_1, 0) 
                                END, 4, 0)                                                --62.22. �ټӿ��� 
                        || LPAD(0, 4, 0)                                                  --63.23. ���ܿ���
                        || LPAD(0, 4, 0)                                                  --64.24. �������                
                        || LPAD(0, 4, 0)                                                  --65.25. �ߺ�����
                        || LPAD(CASE
                                  WHEN NVL(RA.LONG_DAY_1, 0) = 0 THEN NVL(RA.LONG_YEAR_1, 0) 
                                  ELSE NVL(RA.LONG_YEAR_1, 0)  
                                END, 4, 0)                                                --66.26. �ټӿ���
                        
                        -- [�ټӿ��� - �Ⱥ� - 2013.01.01 ����] -- 
                        || LPAD(0, 8, 0)                                                  --67.18. �Ի���                                 
                        || LPAD(CASE
                                  WHEN TO_CHAR(RA.RETIRE_DATE_FR, 'YYYYMMDD') < '20130101' THEN '20130101'
                                  ELSE TO_CHAR(RA.RETIRE_DATE_FR, 'YYYYMMDD') 
                                END, 8, 0)                                                --68.19. ����� 
                        || LPAD(NVL(TO_CHAR(RA.RETIRE_DATE_TO, 'YYYYMMDD'), '0'), 8, 0)   --69.20. �����
                        || LPAD(0, 8, 0)                                                  --70.21. ������
                        || LPAD(NVL(RA.LONG_MONTH_2, 0), 4, 0)                            --71.22. �ټӿ��� 
                        || LPAD(/*CASE
                                  WHEN NVL(RA.DED_DAY, 0) < 0 THEN CEIL(RA.DED_DAY / 30)
                                  ELSE 0
                                END*/NVL(RA.DED_DAY, 0), 4, 0)                                                --72.23. ���ܿ���
                        || LPAD(/*CASE
                                  WHEN NVL(RA.DED_DAY, 0) > 0 THEN CEIL(RA.DED_DAY / 30) 
                                  ELSE 0
                                END*/0, 4, 0)                                                --73.24. �������                
                        || LPAD(0, 4, 0)                                                  --74.25. �ߺ�����
                        || LPAD(NVL(RA.LONG_YEAR_2, 0), 4, 0)                             --75.26. �ټӿ���
                                       
                        -- [�����ҵ����ǥ�ذ��] -- 
                        || LPAD(0, 11, 0)                                                 --76.27.������� �����޿� - �߰�����.
                        || LPAD(NVL(RA.RETIRE_TOTAL_AMOUNT, 0), 11, 0)                    --77.27. ������� �����޿� - ������.
                        || LPAD(NVL(RA.RETIRE_TOTAL_AMOUNT, 0), 11, 0)                    --78.27. �����޿� - ����.
                        || LPAD(NVL(RA.INCOME_DED_AMOUNT, 0), 11, 0)                      --79.28. �����ҵ���������-���� 
                        || LPAD(NVL(RA.LONG_DED_AMOUNT, 0), 11, 0)                        --80.29. �ټӿ�������-����         
                        || LPAD(NVL(RA.TAX_STD_AMOUNT, 0), 11, 0)                         --81.30. �����ҵ����ǥ�� -����         
                        
                        -- [�����ҵ� ���װ�� - 2012.12.31 ����] -- 
                        || LPAD(TRUNC(NVL(RA.TAX_STD_AMOUNT, 0) * 
                                      NVL(RA.LONG_YEAR_1, 0) /
                                      NVL(RA.LONG_YEAR, 0)), 11, 0)                       --82.31. ����ǥ�ؾȺ� 
                        || LPAD(NVL(RA.AVG_TAX_STD_AMOUNT_1, 0), 11, 0)                   --83.31. ����հ���ǥ��
                        || LPAD(0, 11, 0)                                                 --84.33. ȯ�����ǥ�� 
                        || LPAD(0, 11, 0)                                                 --85.34. ȯ����⼼��                         
                        || LPAD(NVL(RA.AVG_COMP_TAX_AMOUNT_1, 0), 11, 0)                  --86.35. ����ջ��⼼��   
                        || LPAD(NVL(RA.COMP_TAX_AMOUNT_1, 0), 11, 0)                      --87.36. ���⼼�� 
                        || LPAD(0, 11, 0)                                                 --88.37. �ⳳ��(������̿�)���� 
                        || LPAD(0, 11, 0)                                                 --89.38. �Ű��󼼾� 
                        
                        -- [�����ҵ� ���װ�� - 2013.1.1 ����] --
                        || LPAD(NVL(RA.TAX_STD_AMOUNT, 0) -
                                TRUNC(NVL(RA.TAX_STD_AMOUNT, 0) * 
                                      NVL(RA.LONG_YEAR_1, 0) /
                                      NVL(RA.LONG_YEAR, 0)), 11, 0)                       --90.31. ����ǥ�ؾȺ� 
                        || LPAD(TRUNC(NVL(RA.AVG_TAX_STD_AMOUNT_2, 0) / 5), 11, 0)        --91.31. ����հ���ǥ��
                        || LPAD(TRUNC(NVL(RA.AVG_TAX_STD_AMOUNT_2, 0) / 5) * 5, 11, 0)    --92.33. ȯ�����ǥ�� 
                        || LPAD(NVL(RA.AVG_COMP_TAX_AMOUNT_2, 0), 11, 0)                  --93.34. ȯ����⼼��                         
                        || LPAD(TRUNC(NVL(RA.AVG_COMP_TAX_AMOUNT_2, 0) / 5), 11, 0)       --94.35. ����ջ��⼼��   
                        || LPAD(NVL(RA.COMP_TAX_AMOUNT_2, 0), 11, 0)                      --95.36. ���⼼�� 
                        || LPAD(0, 11, 0)                                                 --96.37. �ⳳ��(������̿�)���� 
                        || LPAD(0, 11, 0)                                                 --97.38. �Ű��󼼾� 
                        
                        -- [�����ҵ漼�װ�� �հ�] -- 
                        || LPAD(NVL(RA.TAX_STD_AMOUNT, 0), 11, 0)                         --98.31. ����ǥ�ؾȺ� 
                        || LPAD(0, 11, 0)                                                 --99.32. ����հ���ǥ�� 
                        || LPAD(TRUNC(NVL(RA.AVG_TAX_STD_AMOUNT_2, 0) / 5) * 5, 11, 0)    --100.33. ȯ�����ǥ�� 
                        || LPAD(NVL(RA.AVG_COMP_TAX_AMOUNT_2, 0), 11, 0)                  --101.34. ȯ����⼼�� 
                        || LPAD(NVL(RA.AVG_COMP_TAX_AMOUNT_1, 0) + 
                                TRUNC(NVL(RA.AVG_COMP_TAX_AMOUNT_2, 0) / 5)
                                , 11, 0)                                                  --102.35. ����ջ��⼼��
                        || LPAD((NVL(RA.COMP_TAX_AMOUNT_1, 0) +
                                 NVL(RA.COMP_TAX_AMOUNT_2, 0)), 11, 0)                    --103.36. ���⼼�� 
                        || LPAD(0, 11, 0)                                                 --104.37. �ⳳ��(������̿�) ���� 
                        || LPAD(CASE
                                  WHEN (NVL(RA.COMP_TAX_AMOUNT_1, 0) +
                                       NVL(RA.COMP_TAX_AMOUNT_2, 0)) < 0 THEN 1
                                  ELSE 0
                                END, 1, 0)                                                --105.38. �Ű��󼼾� ��ȣ 
                        || LPAD(ABS( (NVL(RA.COMP_TAX_AMOUNT_1, 0) +
                                      NVL(RA.COMP_TAX_AMOUNT_2, 0))), 11, 0)              --105.38. �Ű��󼼾� 
                        
                        -- [�̿������ҵ漼�װ��] --                         
                        || LPAD(CASE
                                  WHEN SQ1.ACCOUNT_NUM IS NULL THEN 0
                                  WHEN (NVL(RA.COMP_TAX_AMOUNT_1, 0) +
                                        NVL(RA.COMP_TAX_AMOUNT_2, 0)) < 0 THEN 1
                                   ELSE 0
                                 END, 1, 0)                                               --106.38. �Ű��󼼾� ��ȣ 
                        || LPAD(CASE
                                  WHEN SQ1.ACCOUNT_NUM IS NULL THEN 0
                                  ELSE ABS((NVL(RA.COMP_TAX_AMOUNT_1, 0) +
                                            NVL(RA.COMP_TAX_AMOUNT_2, 0)))
                                END, 11, 0)                                               --106.38. �Ű��󼼾� 
                        || LPAD(CASE
                                  WHEN SQ1.ACCOUNT_NUM IS NULL THEN ' '
                                  ELSE NVL(SQ1.CORP_NAME, ' ')
                                END, 30, ' ')                                             --107. ���ݰ��������        
                        || LPAD(CASE
                                  WHEN SQ1.ACCOUNT_NUM IS NULL THEN ' '
                                  ELSE NVL(REPLACE(SQ1.TAX_REG_NUM, '-', ''), ' ')
                                END, 10, ' ')                                             --108. ����ڵ�Ϲ�ȣ 
                        || LPAD(CASE
                                  WHEN SQ1.ACCOUNT_NUM IS NULL THEN ' '
                                  ELSE NVL(REPLACE(SQ1.ACCOUNT_NUM, '-', ''), ' ')
                                END, 20, ' ')                                             --109. �������ݰ��¹�ȣ;
                        || LPAD(CASE
                                  WHEN SQ1.ACCOUNT_NUM IS NULL THEN '0'
                                  ELSE NVL(TO_CHAR(RA.CLOSED_DATE, 'YYYYMMDD'), '0') 
                                END, 8, '0')                                              --110. �Ա���         
                        || LPAD(CASE
                                  WHEN SQ1.ACCOUNT_NUM IS NULL THEN 0
                                  ELSE NVL(RA.RETIRE_TOTAL_AMOUNT, 0)
                                END, 11, 0)                                               --111.40. �����Աݱݾ�                                 
                        || LPAD(CASE
                                  WHEN SQ1.ACCOUNT_NUM IS NULL THEN 0
                                  ELSE NVL(RA.RETIRE_TOTAL_AMOUNT, 0)
                                END, 11, 0)                                               --112.41. ������ ������������޿� 
                        || LPAD(CASE
                                  WHEN SQ1.ACCOUNT_NUM IS NULL THEN 0
                                  ELSE CASE
                                         WHEN (NVL(RA.COMP_TAX_AMOUNT_1, 0) +
                                               NVL(RA.COMP_TAX_AMOUNT_2, 0)) < 0 THEN 0
                                         ELSE (NVL(RA.COMP_TAX_AMOUNT_1, 0) +
                                               NVL(RA.COMP_TAX_AMOUNT_2, 0))
                                       END 
                                END, 11, 0)                                               --113.42. �̿������ҵ漼 
                        
                        -- [���θ�-�Ű��󼼾�] -- 
                        || LPAD(CASE
                                  WHEN (NVL(RA.COMP_TAX_AMOUNT_1, 0) +
                                        NVL(RA.COMP_TAX_AMOUNT_2, 0)) < 0 THEN 1
                                  ELSE 0
                                END, 1, 0)                                                --114.43. �ҵ漼 ��ȣ 
                        || LPAD(ABS((NVL(RA.COMP_TAX_AMOUNT_1, 0) +
                                     NVL(RA.COMP_TAX_AMOUNT_2, 0))), 11, 0)               --114.43. �ҵ漼�� 
                        || LPAD(CASE
                                  WHEN TRUNC((NVL(RA.COMP_TAX_AMOUNT_1, 0) +
                                              NVL(RA.COMP_TAX_AMOUNT_2, 0)) / 10) < 0 THEN 1
                                  ELSE 0
                                END, 1, 0)                                                --115.43. ����ҵ漼 ��ȣ 
                        || LPAD(ABS(TRUNC((NVL(RA.COMP_TAX_AMOUNT_1, 0) +
                                           NVL(RA.COMP_TAX_AMOUNT_2, 0)) / 10)), 11, 0)   --115.43. ����ҵ漼��
                        || LPAD(CASE
                                  WHEN (NVL(RA.SP_TAX_AMOUNT_1, 0)  + 
                                        NVL(RA.SP_TAX_AMOUNT_2, 0)) < 0 THEN 1
                                  ELSE 0
                                END, 1, 0)                                                --116.43. ��Ư����ȣ 
                        || LPAD(ABS((NVL(RA.SP_TAX_AMOUNT_1, 0)  + 
                                     NVL(RA.SP_TAX_AMOUNT_2, 0))), 11, 0)                 --116.43. ��Ư����
                        || LPAD(CASE
                                  WHEN (NVL(RA.COMP_TAX_AMOUNT_1, 0) +
                                              NVL(RA.COMP_TAX_AMOUNT_2, 0)) + 
                                       TRUNC((NVL(RA.COMP_TAX_AMOUNT_1, 0) +
                                              NVL(RA.COMP_TAX_AMOUNT_2, 0)) / 10) +
                                       (NVL(RA.SP_TAX_AMOUNT_1, 0)  + 
                                        NVL(RA.SP_TAX_AMOUNT_2, 0)) < 0 THEN 1
                                  ELSE 0
                                END, 1, 0)                                                --117.43. �հ� ��ȣ 
                        || LPAD(ABS((NVL(RA.COMP_TAX_AMOUNT_1, 0) +
                                            NVL(RA.COMP_TAX_AMOUNT_2, 0)) + 
                                     TRUNC((NVL(RA.COMP_TAX_AMOUNT_1, 0) +
                                            NVL(RA.COMP_TAX_AMOUNT_2, 0)) / 10) +
                                     (NVL(RA.SP_TAX_AMOUNT_1, 0)  + 
                                      NVL(RA.SP_TAX_AMOUNT_2, 0))), 11, 0)                 --117.43. �հ� 
                                     
                        -- [���θ� - �̿������ҵ漼] --  
                        || LPAD(CASE
                                  WHEN SQ1.ACCOUNT_NUM IS NULL THEN 0
                                  WHEN (NVL(RA.COMP_TAX_AMOUNT_1, 0) +
                                        NVL(RA.COMP_TAX_AMOUNT_2, 0)) < 0 THEN 0
                                  ELSE (NVL(RA.COMP_TAX_AMOUNT_1, 0) +
                                        NVL(RA.COMP_TAX_AMOUNT_2, 0))
                                END, 11, 0)                                               --118.44. �ҵ漼�� 
                        || LPAD(CASE
                                  WHEN SQ1.ACCOUNT_NUM IS NULL THEN 0
                                  WHEN (NVL(RA.COMP_TAX_AMOUNT_1, 0) +
                                        NVL(RA.COMP_TAX_AMOUNT_2, 0)) < 0 THEN 0
                                  ELSE TRUNC((NVL(RA.COMP_TAX_AMOUNT_1, 0) +
                                              NVL(RA.COMP_TAX_AMOUNT_2, 0)) / 10)
                                END, 11, 0)                                               --119.44. ����ҵ漼��
                        || LPAD(CASE
                                  WHEN SQ1.ACCOUNT_NUM IS NULL THEN 0
                                  WHEN (NVL(RA.COMP_TAX_AMOUNT_1, 0) +
                                        NVL(RA.COMP_TAX_AMOUNT_2, 0)) < 0 THEN 0
                                  ELSE (NVL(RA.SP_TAX_AMOUNT_1, 0)  + 
                                        NVL(RA.SP_TAX_AMOUNT_2, 0))
                                END, 11, 0)                                               --120.44. ��Ư����
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
                                END, 11, 0)                                               --121.44. �հ� 
                         
                        -- [���θ�-������õ¡������] - ������ ����      
                        || LPAD(CASE
                                  WHEN SQ1.ACCOUNT_NUM IS NOT NULL THEN 0
                                  WHEN (NVL(RA.COMP_TAX_AMOUNT_1, 0) +
                                        NVL(RA.COMP_TAX_AMOUNT_2, 0)) < 0 THEN 1
                                  ELSE 0
                                END, 1, 0)                                                --122.44. �ҵ漼 ��ȣ 
                        || LPAD(CASE
                                  WHEN SQ1.ACCOUNT_NUM IS NOT NULL THEN 0
                                  ELSE ABS((NVL(RA.COMP_TAX_AMOUNT_1, 0) +
                                            NVL(RA.COMP_TAX_AMOUNT_2, 0)))
                                END, 11, 0)                                               --122.44. �ҵ漼�� 
                        || LPAD(CASE
                                  WHEN SQ1.ACCOUNT_NUM IS NOT NULL THEN 0
                                  WHEN TRUNC((NVL(RA.COMP_TAX_AMOUNT_1, 0) +
                                              NVL(RA.COMP_TAX_AMOUNT_2, 0)) / 10) < 0 THEN 1
                                  ELSE 0
                                END, 1, 0)                                                --123.44. ����ҵ漼 ��ȣ 
                        || LPAD(CASE
                                  WHEN SQ1.ACCOUNT_NUM IS NOT NULL THEN 0
                                  ELSE ABS(TRUNC((NVL(RA.COMP_TAX_AMOUNT_1, 0) +
                                            NVL(RA.COMP_TAX_AMOUNT_2, 0)) / 10))
                                END, 11, 0)                                               --123.44. ����ҵ漼��
                        || LPAD(CASE
                                  WHEN SQ1.ACCOUNT_NUM IS NOT NULL THEN 0
                                  WHEN (NVL(RA.SP_TAX_AMOUNT_1, 0)  + 
                                        NVL(RA.SP_TAX_AMOUNT_2, 0)) < 0 THEN 1
                                  ELSE 0
                                END, 1, 0)                                                --124.44. ��Ư����ȣ 
                        || LPAD(CASE
                                  WHEN SQ1.ACCOUNT_NUM IS NOT NULL THEN 0
                                  ELSE ABS((NVL(RA.SP_TAX_AMOUNT_1, 0)  + 
                                            NVL(RA.SP_TAX_AMOUNT_2, 0)))
                                END, 11, 0)                                               --124.44. ��Ư����
                                                        
                        || LPAD(CASE
                                  WHEN SQ1.ACCOUNT_NUM IS NOT NULL THEN 0
                                  WHEN (NVL(RA.COMP_TAX_AMOUNT_1, 0) +
                                        NVL(RA.COMP_TAX_AMOUNT_2, 0)) + 
                                       TRUNC((NVL(RA.COMP_TAX_AMOUNT_1, 0) +
                                              NVL(RA.COMP_TAX_AMOUNT_2, 0)) / 10) +
                                       (NVL(RA.SP_TAX_AMOUNT_1, 0)  + 
                                        NVL(RA.SP_TAX_AMOUNT_2, 0)) < 0 THEN 1
                                  ELSE 0
                                END, 1, 0)                                                --125.44. �հ� ��ȣ 
                        || LPAD(CASE
                                  WHEN SQ1.ACCOUNT_NUM IS NOT NULL THEN 0
                                  ELSE ABS((NVL(RA.COMP_TAX_AMOUNT_1, 0) +
                                            NVL(RA.COMP_TAX_AMOUNT_2, 0)) + 
                                           TRUNC((NVL(RA.COMP_TAX_AMOUNT_1, 0) +
                                                  NVL(RA.COMP_TAX_AMOUNT_2, 0)) / 10) +
                                           (NVL(RA.SP_TAX_AMOUNT_1, 0)  + 
                                            NVL(RA.SP_TAX_AMOUNT_2, 0)))
                                END, 11, 0)                                               --1215.44. �հ�  
                        || RPAD(' ', 250, ' ') AS RECORD_FILE               
                        , PM.PERSON_ID  -- ���ID.
                        , REPLACE(PM.REPRE_NUM, '-') AS REPRE_NUM  -- �ֹι�ȣ.
                        , NVL(B1.TAX_OFFICE_CODE, ' ') AS TAX_OFFICE_CODE --�������ڵ�.
                        , NVL(B1.VAT_NUMBER, ' ') AS VAT_NUMBER  -- ����ڹ�ȣ.
                        , ROW_NUMBER() OVER(PARTITION BY RA.ADJUSTMENT_YYYY ORDER BY PM.PERSON_NUM) AS C_SEQ_NO
                        , NVL(RA.RETIRE_TOTAL_AMOUNT, 0) AS RETIRE_TOTAL_AMOUNT  -- ���������޿���.
                        , NVL(RA.HONORARY_AMOUNT, 0) AS HONORARY_AMOUNT  -- ������ �����޿���.
                        , NVL(RA.INCOME_TAX_AMOUNT, 0) + NVL(RA.H_INCOME_TAX_AMOUNT, 0) AS INCOME_TAX_AMOUNT  -- �����̿�����.
                      FROM HRM_PERSON_MASTER PM
                        , ( -- ���� �λ系��.
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
            --> ��(��)�ٹ�ó ���ڵ� <--
          END LOOP C1;
        END LOOP B1;
    END LOOP A1;
  END SET_RETIRE_FILE_2013;


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
