CREATE OR REPLACE PACKAGE HRA_YEAR_ADJUST_FILE_G
AS

-------------------------------------------------------------------------------
-- �������� �������� ���� ��� SELECT.
-------------------------------------------------------------------------------
  PROCEDURE SELECT_YEAR_ADJUST_FILE_LIST
            ( P_CURSOR            OUT TYPES.TCURSOR
            , P_YEAR_YYYY         IN  HRA_YEAR_ADJUSTMENT.YEAR_YYYY%TYPE 
            , P_START_DATE        IN HRA_YEAR_ADJUSTMENT.SUBMIT_DATE%TYPE
            , P_END_DATE          IN HRA_YEAR_ADJUSTMENT.SUBMIT_DATE%TYPE
            , P_CORP_ID           IN HRA_YEAR_ADJUSTMENT.CORP_ID%TYPE
            , P_SOB_ID            IN HRA_YEAR_ADJUSTMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRA_YEAR_ADJUSTMENT.ORG_ID%TYPE
            );
            
-------------------------------------------------------------------------------
-- �ٷμҵ� ���ϻ��� �� ��ȸ.
-------------------------------------------------------------------------------
  PROCEDURE SELECT_YEAR_ADJUST
            ( P_CURSOR            OUT TYPES.TCURSOR
            , P_YEAR_YYYY         IN  HRA_YEAR_ADJUSTMENT.YEAR_YYYY%TYPE 
            , P_START_DATE        IN  HRA_YEAR_ADJUSTMENT.SUBMIT_DATE%TYPE
            , P_END_DATE          IN  HRA_YEAR_ADJUSTMENT.SUBMIT_DATE%TYPE
            , P_CORP_ID           IN  HRA_YEAR_ADJUSTMENT.CORP_ID%TYPE
            , P_OPERATING_UNIT_ID IN  NUMBER 
            , P_SOB_ID            IN  HRA_YEAR_ADJUSTMENT.SOB_ID%TYPE
            , P_ORG_ID            IN  HRA_YEAR_ADJUSTMENT.ORG_ID%TYPE
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
-- �ٷμҵ� ���ϻ��� : ������ �ο��� RETURN.
-------------------------------------------------------------------------------
  PROCEDURE GET_YEAR_ADJUST_FILE_P
            ( P_YEAR_YYYY         IN  VARCHAR2
            , P_START_DATE        IN  HRA_YEAR_ADJUSTMENT.SUBMIT_DATE%TYPE
            , P_END_DATE          IN  HRA_YEAR_ADJUSTMENT.SUBMIT_DATE%TYPE
            , P_CORP_ID           IN  HRA_YEAR_ADJUSTMENT.CORP_ID%TYPE
            , P_OPERATING_UNIT_ID IN  NUMBER 
            , P_SOB_ID            IN  HRA_YEAR_ADJUSTMENT.SOB_ID%TYPE
            , P_ORG_ID            IN  HRA_YEAR_ADJUSTMENT.ORG_ID%TYPE
            , P_CONNECT_PERSON_ID IN  NUMBER
            , O_REC_COUNT         OUT NUMBER 
            );
            
                        
-------------------------------------------------------------------------------
-- �Ƿ�� ���� ���ϻ��� �� ��ȸ.
-------------------------------------------------------------------------------
  PROCEDURE SELECT_MEDICAL
            ( P_CURSOR            OUT TYPES.TCURSOR
            , P_YEAR_YYYY         IN  HRA_YEAR_ADJUSTMENT.YEAR_YYYY%TYPE 
            , P_START_DATE        IN  HRA_YEAR_ADJUSTMENT.SUBMIT_DATE%TYPE
            , P_END_DATE          IN  HRA_YEAR_ADJUSTMENT.SUBMIT_DATE%TYPE
            , P_CORP_ID           IN  HRA_YEAR_ADJUSTMENT.CORP_ID%TYPE
            , P_OPERATING_UNIT_ID IN  NUMBER 
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
-- �Ƿ�� ���� ���ϻ��� : ������ �ο��� RETURN.
-------------------------------------------------------------------------------
  PROCEDURE GET_YEAR_MEDICAL_FILE_P
            ( P_YEAR_YYYY         IN  VARCHAR2
            , P_START_DATE        IN  HRA_YEAR_ADJUSTMENT.SUBMIT_DATE%TYPE
            , P_END_DATE          IN  HRA_YEAR_ADJUSTMENT.SUBMIT_DATE%TYPE
            , P_CORP_ID           IN  HRA_YEAR_ADJUSTMENT.CORP_ID%TYPE
            , P_OPERATING_UNIT_ID IN  NUMBER 
            , P_SOB_ID            IN  HRA_YEAR_ADJUSTMENT.SOB_ID%TYPE
            , P_ORG_ID            IN  HRA_YEAR_ADJUSTMENT.ORG_ID%TYPE
            , P_CONNECT_PERSON_ID IN  NUMBER
            , O_REC_COUNT         OUT NUMBER 
            );
            
-------------------------------------------------------------------------------
-- ��α� ���ϻ��� �� ��ȸ.
-------------------------------------------------------------------------------
  PROCEDURE SELECT_DONATION
            ( P_CURSOR            OUT TYPES.TCURSOR
            , P_YEAR_YYYY         IN  HRA_YEAR_ADJUSTMENT.YEAR_YYYY%TYPE 
            , P_START_DATE        IN  HRA_YEAR_ADJUSTMENT.SUBMIT_DATE%TYPE
            , P_END_DATE          IN  HRA_YEAR_ADJUSTMENT.SUBMIT_DATE%TYPE
            , P_CORP_ID           IN  HRA_YEAR_ADJUSTMENT.CORP_ID%TYPE
            , P_OPERATING_UNIT_ID IN  NUMBER 
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
-- ��α� ���� ���ϻ��� : ������ �ο��� RETURN.
-------------------------------------------------------------------------------
  PROCEDURE GET_YEAR_DONA_FILE_P
            ( P_YEAR_YYYY         IN  VARCHAR2
            , P_START_DATE        IN  HRA_YEAR_ADJUSTMENT.SUBMIT_DATE%TYPE
            , P_END_DATE          IN  HRA_YEAR_ADJUSTMENT.SUBMIT_DATE%TYPE
            , P_CORP_ID           IN  HRA_YEAR_ADJUSTMENT.CORP_ID%TYPE
            , P_OPERATING_UNIT_ID IN  NUMBER 
            , P_SOB_ID            IN  HRA_YEAR_ADJUSTMENT.SOB_ID%TYPE
            , P_ORG_ID            IN  HRA_YEAR_ADJUSTMENT.ORG_ID%TYPE
            , P_CONNECT_PERSON_ID IN  NUMBER
            , O_REC_COUNT         OUT NUMBER 
            );
                        
-------------------------------------------------------------------------------
-- 2011�⵵ �ٷμҵ� ���ϻ���.
-------------------------------------------------------------------------------
  PROCEDURE SET_YEAR_ADJUST_FILE_2011
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
-- 2011�⵵ �Ƿ�� ���ϻ���.
-------------------------------------------------------------------------------
  PROCEDURE SET_MEDICAL_FILE_2011
            ( P_YEAR_YYYY         IN VARCHAR2
            , P_START_DATE        IN HRA_YEAR_ADJUSTMENT.SUBMIT_DATE%TYPE
            , P_END_DATE          IN HRA_YEAR_ADJUSTMENT.SUBMIT_DATE%TYPE
            , P_CORP_ID           IN HRA_YEAR_ADJUSTMENT.CORP_ID%TYPE
            , P_SOB_ID            IN HRA_YEAR_ADJUSTMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRA_YEAR_ADJUSTMENT.ORG_ID%TYPE
            , P_CONNECT_PERSON_ID IN NUMBER
            , P_TAX_PROGRAM_CODE  IN VARCHAR2
            , P_SUBMIT_PERIOD     IN VARCHAR2
            , P_HOMETAX_LOGIN_ID  IN VARCHAR2
            , P_WRITE_DATE        IN DATE
            );

-------------------------------------------------------------------------------
-- 2011�⵵ ��α� ���ϻ���.
-------------------------------------------------------------------------------
  PROCEDURE SET_DONATION_FILE_2011
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
-- 2012�⵵ �ٷμҵ� ���ϻ���.
-------------------------------------------------------------------------------
  PROCEDURE SET_YEAR_ADJUST_FILE_2012
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
-- 2012�⵵ �Ƿ�� ���ϻ���.
-------------------------------------------------------------------------------
  PROCEDURE SET_MEDICAL_FILE_2012
            ( P_YEAR_YYYY         IN VARCHAR2
            , P_START_DATE        IN HRA_YEAR_ADJUSTMENT.SUBMIT_DATE%TYPE
            , P_END_DATE          IN HRA_YEAR_ADJUSTMENT.SUBMIT_DATE%TYPE
            , P_CORP_ID           IN HRA_YEAR_ADJUSTMENT.CORP_ID%TYPE
            , P_SOB_ID            IN HRA_YEAR_ADJUSTMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRA_YEAR_ADJUSTMENT.ORG_ID%TYPE
            , P_CONNECT_PERSON_ID IN NUMBER
            , P_TAX_PROGRAM_CODE  IN VARCHAR2
            , P_SUBMIT_PERIOD     IN VARCHAR2
            , P_HOMETAX_LOGIN_ID  IN VARCHAR2
            , P_WRITE_DATE        IN DATE
            );
            
-------------------------------------------------------------------------------
-- 2012�⵵ ��α� ���ϻ���.
-------------------------------------------------------------------------------
  PROCEDURE SET_DONATION_FILE_2012
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
-- 2013�⵵ �ٷμҵ� ���ϻ���.
-------------------------------------------------------------------------------
  PROCEDURE SET_YEAR_ADJUST_FILE_2013_1
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
-- 2013�⵵ �ٷμҵ� ���ϻ���.
-------------------------------------------------------------------------------
  PROCEDURE SET_YEAR_ADJUST_FILE_2013
            ( P_YEAR_YYYY         IN  VARCHAR2
            , P_START_DATE        IN  HRA_YEAR_ADJUSTMENT.SUBMIT_DATE%TYPE
            , P_END_DATE          IN  HRA_YEAR_ADJUSTMENT.SUBMIT_DATE%TYPE
            , P_CORP_ID           IN  HRA_YEAR_ADJUSTMENT.CORP_ID%TYPE
            , P_OPERATING_UNIT_ID IN  NUMBER 
            , P_SOB_ID            IN  HRA_YEAR_ADJUSTMENT.SOB_ID%TYPE
            , P_ORG_ID            IN  HRA_YEAR_ADJUSTMENT.ORG_ID%TYPE
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
-- 2013�⵵ �Ƿ�� ���ϻ���.
-------------------------------------------------------------------------------
  PROCEDURE SET_MEDICAL_FILE_2013
            ( P_YEAR_YYYY         IN VARCHAR2
            , P_START_DATE        IN HRA_YEAR_ADJUSTMENT.SUBMIT_DATE%TYPE
            , P_END_DATE          IN HRA_YEAR_ADJUSTMENT.SUBMIT_DATE%TYPE
            , P_CORP_ID           IN HRA_YEAR_ADJUSTMENT.CORP_ID%TYPE
            , P_OPERATING_UNIT_ID IN NUMBER 
            , P_SOB_ID            IN HRA_YEAR_ADJUSTMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRA_YEAR_ADJUSTMENT.ORG_ID%TYPE
            , P_CONNECT_PERSON_ID IN NUMBER
            , P_TAX_PROGRAM_CODE  IN VARCHAR2
            , P_SUBMIT_PERIOD     IN VARCHAR2
            , P_HOMETAX_LOGIN_ID  IN VARCHAR2
            , P_WRITE_DATE        IN DATE
            );
            
-------------------------------------------------------------------------------
-- 2013�⵵ ��α� ���ϻ���.
-------------------------------------------------------------------------------
  PROCEDURE SET_DONATION_FILE_2013
            ( P_YEAR_YYYY         IN VARCHAR2
            , P_START_DATE        IN HRA_YEAR_ADJUSTMENT.SUBMIT_DATE%TYPE
            , P_END_DATE          IN HRA_YEAR_ADJUSTMENT.SUBMIT_DATE%TYPE
            , P_CORP_ID           IN HRA_YEAR_ADJUSTMENT.CORP_ID%TYPE
            , P_OPERATING_UNIT_ID IN NUMBER 
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
            , P_RECORD_TYPE       IN VARCHAR2 DEFAULT NULL   
            );

END HRA_YEAR_ADJUST_FILE_G;
/
CREATE OR REPLACE PACKAGE BODY HRA_YEAR_ADJUST_FILE_G
AS
/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : HRA_YEAR_ADJUST_FILE_G
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
  PROCEDURE SELECT_YEAR_ADJUST_FILE_LIST
            ( P_CURSOR            OUT TYPES.TCURSOR
            , P_YEAR_YYYY         IN  HRA_YEAR_ADJUSTMENT.YEAR_YYYY%TYPE 
            , P_START_DATE        IN  HRA_YEAR_ADJUSTMENT.SUBMIT_DATE%TYPE
            , P_END_DATE          IN  HRA_YEAR_ADJUSTMENT.SUBMIT_DATE%TYPE
            , P_CORP_ID           IN  HRA_YEAR_ADJUSTMENT.CORP_ID%TYPE
            , P_SOB_ID            IN  HRA_YEAR_ADJUSTMENT.SOB_ID%TYPE
            , P_ORG_ID            IN  HRA_YEAR_ADJUSTMENT.ORG_ID%TYPE
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
           , SUM(NVL(S_YA.PERSON_COUNT, 0)) AS ADJUST_PERSON_COUNT
           , 0 AS REC_ADJUST_PERSON_COUNT
           , SUM(NVL(S_YA.FIX_IN_TAX_AMT, 0)) AS FIX_IN_TAX_AMT
           , SUM(NVL(S_YA.FIX_LOCAL_TAX_AMT, 0)) AS FIX_LOCAL_TAX_AMT
           , SUM(NVL(S_YA.FIX_SP_TAX_AMT, 0)) AS FIX_SP_TAX_AMT
           , SUM(NVL(S_YA.FIX_TAX_SUM, 0)) AS FIX_TAX_SUM
           , SUM(NVL(S_MI.PERSON_COUNT, 0)) AS MEDIC_PERSON_COUNT
           , 0 AS REC_MEDIC_PERSON_COUNT
           , SUM(NVL(S_DA.PERSON_COUNT, 0)) AS DONA_PERSON_COUNT
           , 0 AS REC_DONA_PERSON_COUNT
           , SUM(NVL(S_DA.DONATION_ADJUST_COUNT, 0)) AS DONA_ADJUST_COUNT
           , SUM(NVL(S_DA.TOTAL_DONA_AMT, 0)) AS TOTAL_DONA_AMT
           , SUM(NVL(S_DA.DONA_DED_AMT, 0)) AS DONA_DED_AMT
           , SUM(NVL(S_DI.PERSON_COUNT, 0)) AS DONA_DOC_PERSON_COUNT
           , NVL(OU.CORP_ID, NULL) AS CORP_ID
           , NVL(OU.OPERATING_UNIT_ID, NULL) AS OPERATING_UNIT_ID
        FROM HRM_OPERATING_UNIT OU
          , ( SELECT YA.YEAR_YYYY AS YEAR_YYYY
                  --, T1.OPERATING_UNIT_ID 
                  , COUNT(YA.PERSON_ID) AS PERSON_COUNT
                  , SUM(NVL(YA.FIX_IN_TAX_AMT, 0)) AS FIX_IN_TAX_AMT
                  , SUM(NVL(YA.FIX_LOCAL_TAX_AMT, 0)) AS FIX_LOCAL_TAX_AMT
                  , SUM(NVL(YA.FIX_SP_TAX_AMT, 0)) AS FIX_SP_TAX_AMT
                  , SUM(NVL(YA.FIX_IN_TAX_AMT, 0) + NVL(YA.FIX_LOCAL_TAX_AMT, 0) + NVL(YA.FIX_SP_TAX_AMT, 0)) AS FIX_TAX_SUM
                FROM HRA_YEAR_ADJUSTMENT YA
                  , HRM_PERSON_MASTER    PM
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
               WHERE YA.PERSON_ID       = PM.PERSON_ID
                 --AND PM.PERSON_ID       = T1.PERSON_ID 
                 AND YA.YEAR_YYYY       = P_YEAR_YYYY
                 AND YA.CORP_ID         = P_CORP_ID
                 AND YA.SOB_ID          = P_SOB_ID
                 AND YA.ORG_ID          = P_ORG_ID
                 AND YA.SUBMIT_DATE     BETWEEN P_START_DATE AND P_END_DATE
                 AND NVL(YA.INCOME_TOT_AMT, 0) != 0
                 AND YA.ADJUST_DATE_TO  BETWEEN P_START_DATE AND P_END_DATE
               GROUP BY YA.YEAR_YYYY 
                      --, T1.OPERATING_UNIT_ID 
            ) S_YA  
          , ( SELECT MI.YEAR_YYYY
                  --, T1.OPERATING_UNIT_ID 
                  , COUNT(MI.PERSON_ID) AS PERSON_COUNT
                FROM HRA_MEDICAL_INFO MI
                  , HRM_PERSON_MASTER PM
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
              WHERE MI.PERSON_ID       = PM.PERSON_ID
                --AND PM.PERSON_ID       = T1.PERSON_ID 
                AND MI.YEAR_YYYY       = P_YEAR_YYYY
                AND PM.CORP_ID         = P_CORP_ID
                AND MI.SOB_ID          = P_SOB_ID
                AND MI.ORG_ID          = P_ORG_ID
              GROUP BY MI.YEAR_YYYY 
                     --, T1.OPERATING_UNIT_ID 
            ) S_MI
          , ( SELECT DA.YEAR_YYYY
                  --, T1.OPERATING_UNIT_ID 
                  , COUNT(DISTINCT DA.PERSON_ID) AS PERSON_COUNT
                  , COUNT(DA.PERSON_ID) AS DONATION_ADJUST_COUNT
                  , SUM(DA.TOTAL_DONA_AMT) AS TOTAL_DONA_AMT
                  , SUM(DA.DONA_DED_AMT) AS DONA_DED_AMT
                FROM HRA_DONATION_ADJUSTMENT DA
                  , HRM_PERSON_MASTER        PM
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
              WHERE DA.PERSON_ID              = PM.PERSON_ID
                --AND PM.PERSON_ID              = T1.PERSON_ID 
                AND DA.YEAR_YYYY              = P_YEAR_YYYY
                AND PM.CORP_ID                = P_CORP_ID
                AND DA.SOB_ID                 = P_SOB_ID
                AND DA.ORG_ID                 = P_ORG_ID
              GROUP BY DA.YEAR_YYYY
                     --, T1.OPERATING_UNIT_ID 
            ) S_DA
          , ( SELECT DI.YEAR_YYYY
                  --, T1.OPERATING_UNIT_ID 
                  , COUNT(DISTINCT DI.PERSON_ID) AS PERSON_COUNT
                FROM HRA_DONATION_INFO DI
                  , HRM_PERSON_MASTER  PM
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
              WHERE DI.PERSON_ID              = PM.PERSON_ID
                --AND PM.PERSON_ID              = T1.PERSON_ID 
                AND DI.YEAR_YYYY              = P_YEAR_YYYY
                AND PM.CORP_ID                = P_CORP_ID
                AND DI.SOB_ID                 = P_SOB_ID
                AND DI.ORG_ID                 = P_ORG_ID
              GROUP BY DI.YEAR_YYYY
                     --, T1.OPERATING_UNIT_ID 
            ) S_DI
      WHERE P_YEAR_YYYY           = S_YA.YEAR_YYYY
        /*AND OU.OPERATING_UNIT_ID  = S_YA.OPERATING_UNIT_ID*/
        AND P_YEAR_YYYY           = S_MI.YEAR_YYYY(+)
        /*AND OU.OPERATING_UNIT_ID  = S_MI.OPERATING_UNIT_ID(+)*/
        AND P_YEAR_YYYY           = S_DA.YEAR_YYYY(+)
        /*AND OU.OPERATING_UNIT_ID  = S_DA.OPERATING_UNIT_ID(+)*/
        AND P_YEAR_YYYY           = S_DI.YEAR_YYYY(+)
        /*AND OU.OPERATING_UNIT_ID  = S_DI.OPERATING_UNIT_ID(+)*/
        AND OU.CORP_ID            = P_CORP_ID
        AND OU.USABLE             = 'Y'
        AND OU.START_DATE         <= P_END_DATE
        AND (OU.END_DATE          >= P_START_DATE OR OU.END_DATE IS NULL) 
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
  END SELECT_YEAR_ADJUST_FILE_LIST;


-------------------------------------------------------------------------------
-- �ٷμҵ� ���ϻ��� �� ��ȸ.
-------------------------------------------------------------------------------
  PROCEDURE SELECT_YEAR_ADJUST
            ( P_CURSOR            OUT TYPES.TCURSOR
            , P_YEAR_YYYY         IN  HRA_YEAR_ADJUSTMENT.YEAR_YYYY%TYPE 
            , P_START_DATE        IN  HRA_YEAR_ADJUSTMENT.SUBMIT_DATE%TYPE
            , P_END_DATE          IN  HRA_YEAR_ADJUSTMENT.SUBMIT_DATE%TYPE
            , P_CORP_ID           IN  HRA_YEAR_ADJUSTMENT.CORP_ID%TYPE
            , P_OPERATING_UNIT_ID IN  NUMBER 
            , P_SOB_ID            IN  HRA_YEAR_ADJUSTMENT.SOB_ID%TYPE
            , P_ORG_ID            IN  HRA_YEAR_ADJUSTMENT.ORG_ID%TYPE
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
      SET_YEAR_ADJUST_FILE_2011
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
      SET_YEAR_ADJUST_FILE_2012
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
      SET_YEAR_ADJUST_FILE_2013
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
  END SELECT_YEAR_ADJUST;

-------------------------------------------------------------------------------
-- �ٷμҵ� ���ϻ��� : ������ �ο��� RETURN.
-------------------------------------------------------------------------------
  PROCEDURE GET_YEAR_ADJUST_FILE_P
            ( P_YEAR_YYYY         IN  VARCHAR2
            , P_START_DATE        IN  HRA_YEAR_ADJUSTMENT.SUBMIT_DATE%TYPE
            , P_END_DATE          IN  HRA_YEAR_ADJUSTMENT.SUBMIT_DATE%TYPE
            , P_CORP_ID           IN  HRA_YEAR_ADJUSTMENT.CORP_ID%TYPE
            , P_OPERATING_UNIT_ID IN  NUMBER 
            , P_SOB_ID            IN  HRA_YEAR_ADJUSTMENT.SOB_ID%TYPE
            , P_ORG_ID            IN  HRA_YEAR_ADJUSTMENT.ORG_ID%TYPE
            , P_CONNECT_PERSON_ID IN  NUMBER
            , O_REC_COUNT         OUT NUMBER 
            )
  AS
  BEGIN
    BEGIN
      SELECT COUNT(RF.SOURCE_FILE) AS COUNT
        INTO O_REC_COUNT       
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
        O_REC_COUNT := 0;
    END;
  END GET_YEAR_ADJUST_FILE_P;
  
  
-------------------------------------------------------------------------------
-- �Ƿ�� ���� ���ϻ��� �� ��ȸ.
-------------------------------------------------------------------------------
  PROCEDURE SELECT_MEDICAL
            ( P_CURSOR            OUT TYPES.TCURSOR
            , P_YEAR_YYYY         IN  HRA_YEAR_ADJUSTMENT.YEAR_YYYY%TYPE 
            , P_START_DATE        IN  HRA_YEAR_ADJUSTMENT.SUBMIT_DATE%TYPE
            , P_END_DATE          IN  HRA_YEAR_ADJUSTMENT.SUBMIT_DATE%TYPE
            , P_CORP_ID           IN  HRA_YEAR_ADJUSTMENT.CORP_ID%TYPE
            , P_OPERATING_UNIT_ID IN  NUMBER 
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
  BEGIN
    -- TEMPORARY ����.
    DELETE FROM HRM_REPORT_FILE_GT RF
    WHERE RF.SOB_ID           = P_SOB_ID
      AND RF.ORG_ID           = P_ORG_ID
    ;
    IF P_YEAR_YYYY = '2011' THEN
      SET_MEDICAL_FILE_2011
        ( P_YEAR_YYYY         => P_YEAR_YYYY
        , P_START_DATE        => P_START_DATE
        , P_END_DATE          => P_END_DATE
        , P_CORP_ID           => P_CORP_ID
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , P_CONNECT_PERSON_ID => P_CONNECT_PERSON_ID
        , P_TAX_PROGRAM_CODE  => P_TAX_PROGRAM_CODE
        , P_SUBMIT_PERIOD     => P_SUBMIT_PERIOD
        , P_HOMETAX_LOGIN_ID  => P_HOMETAX_LOGIN_ID
        , P_WRITE_DATE        => P_WRITE_DATE
        );
    ELSIF P_YEAR_YYYY = '2011' THEN
      SET_MEDICAL_FILE_2012
        ( P_YEAR_YYYY         => P_YEAR_YYYY
        , P_START_DATE        => P_START_DATE
        , P_END_DATE          => P_END_DATE
        , P_CORP_ID           => P_CORP_ID
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , P_CONNECT_PERSON_ID => P_CONNECT_PERSON_ID
        , P_TAX_PROGRAM_CODE  => P_TAX_PROGRAM_CODE
        , P_SUBMIT_PERIOD     => P_SUBMIT_PERIOD
        , P_HOMETAX_LOGIN_ID  => P_HOMETAX_LOGIN_ID
        , P_WRITE_DATE        => P_WRITE_DATE
        );
    ELSE
      SET_MEDICAL_FILE_2013
        ( P_YEAR_YYYY         => P_YEAR_YYYY
        , P_START_DATE        => P_START_DATE
        , P_END_DATE          => P_END_DATE
        , P_CORP_ID           => P_CORP_ID
        , P_OPERATING_UNIT_ID => P_OPERATING_UNIT_ID 
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , P_CONNECT_PERSON_ID => P_CONNECT_PERSON_ID
        , P_TAX_PROGRAM_CODE  => P_TAX_PROGRAM_CODE
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
  END SELECT_MEDICAL;

-------------------------------------------------------------------------------
-- �Ƿ�� ���� ���ϻ��� : ������ �ο��� RETURN.
-------------------------------------------------------------------------------
  PROCEDURE GET_YEAR_MEDICAL_FILE_P
            ( P_YEAR_YYYY         IN  VARCHAR2
            , P_START_DATE        IN  HRA_YEAR_ADJUSTMENT.SUBMIT_DATE%TYPE
            , P_END_DATE          IN  HRA_YEAR_ADJUSTMENT.SUBMIT_DATE%TYPE
            , P_CORP_ID           IN  HRA_YEAR_ADJUSTMENT.CORP_ID%TYPE
            , P_OPERATING_UNIT_ID IN  NUMBER 
            , P_SOB_ID            IN  HRA_YEAR_ADJUSTMENT.SOB_ID%TYPE
            , P_ORG_ID            IN  HRA_YEAR_ADJUSTMENT.ORG_ID%TYPE
            , P_CONNECT_PERSON_ID IN  NUMBER
            , O_REC_COUNT         OUT NUMBER 
            )
  AS
  BEGIN
    BEGIN
      SELECT COUNT(RF.SOURCE_FILE) AS COUNT
        INTO O_REC_COUNT       
        FROM HRM_REPORT_FILE_GT RF
      WHERE /*RF.YEAR_YYYY          = P_YEAR_YYYY
        AND RF.CORP_ID            = P_CORP_ID
        AND RF.OPERATING_UNIT_ID  = P_OPERATING_UNIT_ID
        AND */RF.SOB_ID             = P_SOB_ID
        AND RF.ORG_ID             = P_ORG_ID
        AND RF.SEQ_NUM            IS NOT NULL
        AND RF.RECORD_TYPE        = 'A'  -- C RECORD COUNT 
      ;
    EXCEPTION
      WHEN OTHERS THEN
        O_REC_COUNT := 0;
    END;
  END GET_YEAR_MEDICAL_FILE_P;
  
  
  
-------------------------------------------------------------------------------
-- ��α� ���ϻ��� �� ��ȸ.
-------------------------------------------------------------------------------
  PROCEDURE SELECT_DONATION
            ( P_CURSOR            OUT TYPES.TCURSOR
            , P_YEAR_YYYY         IN  HRA_YEAR_ADJUSTMENT.YEAR_YYYY%TYPE 
            , P_START_DATE        IN  HRA_YEAR_ADJUSTMENT.SUBMIT_DATE%TYPE
            , P_END_DATE          IN  HRA_YEAR_ADJUSTMENT.SUBMIT_DATE%TYPE
            , P_CORP_ID           IN  HRA_YEAR_ADJUSTMENT.CORP_ID%TYPE
            , P_OPERATING_UNIT_ID IN  NUMBER 
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
  BEGIN
    -- TEMPORARY ����.
    DELETE FROM HRM_REPORT_FILE_GT RF
    WHERE RF.SOB_ID           = P_SOB_ID
      AND RF.ORG_ID           = P_ORG_ID
    ;
    IF P_YEAR_YYYY = '2011' THEN
      SET_DONATION_FILE_2011
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
      SET_DONATION_FILE_2012
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
      SET_DONATION_FILE_2013
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
  END SELECT_DONATION;

-------------------------------------------------------------------------------
-- ��α� ���� ���ϻ��� : ������ �ο��� RETURN.
-------------------------------------------------------------------------------
  PROCEDURE GET_YEAR_DONA_FILE_P
            ( P_YEAR_YYYY         IN  VARCHAR2
            , P_START_DATE        IN  HRA_YEAR_ADJUSTMENT.SUBMIT_DATE%TYPE
            , P_END_DATE          IN  HRA_YEAR_ADJUSTMENT.SUBMIT_DATE%TYPE
            , P_CORP_ID           IN  HRA_YEAR_ADJUSTMENT.CORP_ID%TYPE
            , P_OPERATING_UNIT_ID IN  NUMBER 
            , P_SOB_ID            IN  HRA_YEAR_ADJUSTMENT.SOB_ID%TYPE
            , P_ORG_ID            IN  HRA_YEAR_ADJUSTMENT.ORG_ID%TYPE
            , P_CONNECT_PERSON_ID IN  NUMBER
            , O_REC_COUNT         OUT NUMBER 
            )
  AS
  BEGIN
    BEGIN
      SELECT COUNT(RF.SOURCE_FILE) AS COUNT
        INTO O_REC_COUNT       
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
        O_REC_COUNT := 0;
    END;
  END GET_YEAR_DONA_FILE_P;
  
      
-------------------------------------------------------------------------------
-- 2011�⵵ �ٷμҵ� ���ϻ��� �� ��ȸ.
-------------------------------------------------------------------------------
  PROCEDURE SET_YEAR_ADJUST_FILE_2011
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
                    || '20'  -- �����ٷμҵ�(20);
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
                    || RPAD(' ', 1082, ' ') AS RECORD_FILE
                    , CM.CORP_NAME  -- ���θ�.
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
                      || '20'  -- �����ٷμҵ�(20);
                      || LPAD(REPLACE(OU.TAX_OFFICE_CODE, '-', ''), 3, 0)   -- �������ڵ�; 
                      || LPAD(1, 6, 0)                                      -- B���ڵ��� �Ϸù�ȣ;
                      --> ������;
                      || RPAD(NVL(REPLACE(OU.VAT_NUMBER, '-', ''), ' '), 10, ' ')      -- ��õ¡���ǹ����� ����ڵ�Ϲ�ȣ;
                      || RPAD(NVL(CM.CORP_NAME, ' '), 40, ' ')              -- ���θ�(��ȣ);
                      || RPAD(NVL(CM.PRESIDENT_NAME, ' '), 30, ' ')         -- ��ǥ�� ����;
                      || RPAD(NVL(REPLACE(CM.LEGAL_NUMBER, '-', ''), ' '), 13, ' ') -- ���ε�Ϲ�ȣ;
                      --> ���⳻��;
                      || LPAD(NVL(S_YA.NOW_WORKER_COUNT, 0), 7, 0)   -- ������ C���ڵ��� ��(�ٷμҵ����� ��);
                      || LPAD(NVL(S_YA.PRE_WORKER_COUNT, 0), 7, 0)   -- ������ D���ڵ�(���ٹ�ó)�� ��(C���ڵ� �׸�6�� �հ�)
                      || LPAD(NVL(S_YA.INCOME_TOT_AMT, 0), 14, 0)    -- �ѱ޿� �Ѱ�(C���ڵ� �޿� ��);
                      || LPAD(NVL(S_YA.FIX_IN_TAX, 0), 13, 0)        -- �ҵ漼 �������� �Ѱ�(C���ڵ� �ҵ漼�� ��);
                      || LPAD(0, 13, 0)  -- LPAD(NVL(S_YA.FIX_LEGAL_TAX, 0), 13, 0) : 2009�� �������� ����(MODIFIED BY YOUNG MIN) ���μ� ���������Ѱ�->�������� ����;            
                      || LPAD(NVL(S_YA.FIX_LOCAL_TAX, 0), 13, 0)     -- �ֹμ� �������� �Ѱ�;
                      || LPAD(NVL(S_YA.FIX_SP_TAX, 0), 13, 0)        -- ��Ư�� �������� �Ѱ�;
                      || LPAD(NVL(S_YA.FIX_TOTAL_TAX, 0) - NVL(S_YA.FIX_LEGAL_TAX, 0), 13, 0)  -- �������� �Ѱ�;
                      -- LPAD(NVL(S_YA.FIX_TOTAL_TAX, 0), 13, 0)  -- �������� �Ѱ� : 2009�� �������� ����(MODIFIED BY YOUNG MIN) ���������Ѱ�-���μ� �������� �Ѱ�;
                      || LPAD(NVL(P_SUBMIT_PERIOD, '1'), 1, 0)   -- (�����ջ� : 1, ��/����� ���� �������� : 2, ���� �������� : 3);
                      || RPAD(' ', 1061, ' ') AS RECORD_FILE
                      , LPAD(REPLACE(OU.TAX_OFFICE_CODE, '-', ''), 3, 0) AS TAX_OFFICE_CODE
                      , RPAD(NVL(REPLACE(OU.VAT_NUMBER, '-', ''), ' '), 10, ' ') AS VAT_NUMBER
                    FROM HRM_CORP_MASTER CM
                       , HRM_OPERATING_UNIT OU
                       , ( -- ���⳻��.
                           SELECT YA.YEAR_YYYY
                               , COUNT(YA.PERSON_ID) AS NOW_WORKER_COUNT
                               , NVL(S_PW.PRE_WORK_COUNT, 0) AS PRE_WORKER_COUNT
                               , SUM(YA.INCOME_TOT_AMT) AS INCOME_TOT_AMT
                               , SUM(YA.FIX_IN_TAX_AMT) FIX_IN_TAX
                               , 0 AS FIX_LEGAL_TAX
                               , SUM(YA.FIX_LOCAL_TAX_AMT) FIX_LOCAL_TAX
                               , SUM(YA.FIX_SP_TAX_AMT) FIX_SP_TAX
                               , SUM(NVL(YA.FIX_IN_TAX_AMT, 0) +
                                     NVL(YA.FIX_LOCAL_TAX_AMT, 0) +
                                     NVL(YA.FIX_SP_TAX_AMT, 0)) FIX_TOTAL_TAX
                             FROM HRA_YEAR_ADJUSTMENT YA
                               , ( -- �����ٹ��� �ڷ��.
                                  SELECT PW.YEAR_YYYY
                                      , COUNT(PW.PERSON_ID) AS PRE_WORK_COUNT
                                    FROM HRA_YEAR_ADJUSTMENT YA
                                      , HRA_PREVIOUS_WORK PW
                                      , HRM_PERSON_MASTER PM
                                   WHERE YA.YEAR_YYYY     = PW.YEAR_YYYY
                                     AND YA.PERSON_ID     = PW.PERSON_ID
                                     AND PW.PERSON_ID     = PM.PERSON_ID
                                     AND PW.YEAR_YYYY     = P_YEAR_YYYY
                                     AND PM.CORP_ID       = P_CORP_ID
                                     AND PW.SOB_ID        = P_SOB_ID
                                     AND PW.ORG_ID        = P_ORG_ID
                                     AND YA.ADJUST_DATE_TO BETWEEN P_START_DATE AND P_END_DATE
                                   GROUP BY PW.YEAR_YYYY
                                  ) S_PW
                            WHERE YA.YEAR_YYYY      = S_PW.YEAR_YYYY(+)
                              AND YA.CORP_ID        = P_CORP_ID
                              AND YA.YEAR_YYYY      = P_YEAR_YYYY
                              AND YA.SOB_ID         = P_SOB_ID
                              AND YA.ORG_ID         = P_ORG_ID
                              AND YA.SUBMIT_DATE    BETWEEN P_START_DATE AND P_END_DATE
                              AND YA.INCOME_TOT_AMT <> 0
                              AND YA.ADJUST_DATE_TO BETWEEN P_START_DATE AND P_END_DATE
                            GROUP BY YA.YEAR_YYYY
                                  , NVL(S_PW.PRE_WORK_COUNT, 0)
                         ) S_YA
                    WHERE CM.CORP_ID        = OU.CORP_ID
                      AND P_YEAR_YYYY       = S_YA.YEAR_YYYY
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
                          'C'                                           -- �ڷ������ȣ.
                        || '20'                                         --AS DATA_TYPE
                        || RPAD(NVL(B1.TAX_OFFICE_CODE, ' '), 3, ' ')   -- �������ڵ�.
                        || LPAD(ROW_NUMBER() OVER(PARTITION BY YA.YEAR_YYYY ORDER BY PM.PERSON_NUM), 6, 0)   -- �Ϸù�ȣ.
                        || LPAD(NVL(B1.VAT_NUMBER, ' '), 10, ' ')       -- ����ڹ�ȣ.
                        || LPAD(NVL(S_PW.PRE_WORK_COUNT, 0), 2, 0)      -- ��(��)�ٹ�ó ��;
                        || LPAD(NVL(PM.RESIDENT_TYPE, '1'), 1, 0)       -- ������ �����ڵ�(������:1, �������:2);
                        || RPAD(CASE 
                                  WHEN PM.RESIDENT_TYPE = '1' THEN ' '
                                  WHEN SUBSTR(REPLACE(PM.REPRE_NUM, '-', ''), 7, 1) BETWEEN '1' AND '4' THEN ' '  -- 1900, 2000���.
                                  WHEN SUBSTR(REPLACE(PM.REPRE_NUM, '-', ''), 7, 1) BETWEEN '9' AND '0' THEN ' '  -- 1800����..
                                  ELSE NVL(S_HN.ISO_NATION_CODE, ' ')
                                END, 2, ' ')  -- �ű����� �ڵ� : ������ڸ� ���, �����ڴ� ����;
                        || LPAD(DECODE(PM.FOREIGN_TAX_YN, 'Y', 1, 2), 1, 0)  -- �ܱ��δ��ϼ�������(����:1, ������:2);
                        || RPAD(NVL(PM.NAME, ' '), 30, ' ')  -- ����;
                        || RPAD(CASE
                                  WHEN PM.NATIONALITY_TYPE IS NOT NULL THEN PM.NATIONALITY_TYPE
                                  WHEN SUBSTR(REPLACE(PM.REPRE_NUM, '-', ''), 7, 1) BETWEEN '5' AND '8' THEN '9'
                                  ELSE '1'
                                END, 1, 0)  -- ��/�ܱ��� �����ڵ�;
                        || RPAD(NVL(REPLACE(PM.REPRE_NUM, '-', ''), ' '), 13, ' ')  -- �ֹε�Ϲ�ȣ;
                        || RPAD(CASE
                                  WHEN PM.NATIONALITY_TYPE = '9' THEN NVL(S_HN.ISO_NATION_CODE, ' ')
                                  WHEN SUBSTR(REPLACE(PM.REPRE_NUM, '-', ''), 7, 1) BETWEEN '5' AND '8' THEN NVL(S_HN.ISO_NATION_CODE, ' ')
                                  ELSE ' '
                                END, 2, ' ')  -- �����ڵ�(�ܱ����� ��츸 ����);
                        || RPAD(NVL(PM.HOUSEHOLD_TYPE, '1'), 1, 0)  -- �����ֿ���.
                        || RPAD(CASE 
                                  WHEN (PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE > TO_DATE(P_YEAR_YYYY||'-12-31','YYYY-MM-DD')) THEN '1'
                                  ELSE '2' 
                                END, 1, 0)  -- �������걸��.
                        || RPAD(NVL(B1.VAT_NUMBER, ' '), 10, ' ')  -- ����ڵ�Ϲ�ȣ;
                        || RPAD(NVL(A1.CORP_NAME, ' '), 40, ' ')  -- ���θ�(��ȣ);
                        -- 2009�� �������� ����(MODIFIED BY YOUNG MIN). �ͼӳ⵵ ���۳���� -> �ٹ��Ⱓ ���ۿ����Ϸ� ����;
                        || RPAD(/*CASE 
                                  WHEN PM.JOIN_DATE > TRUNC(TO_DATE(P_YEAR_YYYY, 'YYYY'), 'MM') THEN
                                    REPLACE(TO_CHAR(PM.JOIN_DATE, 'YYYY-MM-DD'), '-', '')
                                  ELSE TO_CHAR(P_YEAR_YYYY || '0101')
                                END*/TO_CHAR(YA.ADJUST_DATE_FR, 'YYYYMMDD'), 8, 0)  -- �ٹ��Ⱓ ���ۿ�����;
                        || RPAD(/*CASE 
                                  WHEN PM.RETIRE_DATE IS NOT NULL AND PM.RETIRE_DATE < TO_DATE(P_YEAR_YYYY || '-12-31') THEN
                                    REPLACE(TO_CHAR(PM.RETIRE_DATE, 'YYYY-MM-DD'), '-', '')
                                  ELSE P_YEAR_YYYY || '1231'
                                END*/TO_CHAR(YA.ADJUST_DATE_TO, 'YYYYMMDD'), 8, 0)  -- �ٹ��Ⱓ ���Ῥ����;
                        || LPAD(0, 8, 0)  -- ����Ⱓ ���ۿ�����;
                        || LPAD(0, 8, 0)  -- ����Ⱓ ���Ῥ����;
                        --> �ٹ�ó�� �ҵ��-��(��)�ٹ�ó �ѱ޿�.
                        || LPAD(NVL(YA.NOW_PAY_TOT_AMT, 0), 11, 0)  -- �޿��Ѿ�;
                        || LPAD(NVL(YA.NOW_BONUS_TOT_AMT, 0), 11, 0) -- ���Ѿ�;
                        || LPAD(NVL(YA.NOW_ADD_BONUS_AMT, 0), 11, 0) -- ������;
                        || LPAD(NVL(YA.NOW_STOCK_BENE_AMT, 0), 11, 0) -- �ֽĸż����ñ��������;
                        ----> 2009�� �������� ����(MODIFIED BY YOUNG MIN). �츮������������� �߰�;
                        || LPAD(0, 11, 0) -- �츮�������������(�迡�� �������� �ʾ���);
                        || LPAD(0, 22, 0) -- ����;
                        || LPAD(NVL(YA.NOW_PAY_TOT_AMT, 0) +
                                NVL(YA.NOW_BONUS_TOT_AMT, 0) +
                                NVL(YA.NOW_ADD_BONUS_AMT, 0) +
                                NVL(YA.NOW_STOCK_BENE_AMT, 0), 11, 0) -- ��;
                        --> ��(��)�ٹ�ó ����� �ҵ�.
                        -- 2009�� �������� ����(MODIFIED BY YOUNG MIN).��(��)�ٹ�ó ����� �ҵ� ���麯��;
                        || LPAD(NVL(YA.NONTAX_SCH_EDU_AMT, 0), 10, 0) -- �����-���ڱ�;
                        || LPAD(NVL(YA.NONTAX_MEMBER_AMT, 0), 10, 0) -- �����-��������������;
                        || LPAD(NVL(YA.NONTAX_GUARD_AMT, 0), 10, 0) -- �����-��ȣ/�¼�����;
                        || LPAD(NVL(YA.NONTAX_CHILD_AMT, 0), 10, 0) -- �����-����/���ߵ�_��������/Ȱ����;
                        || LPAD(NVL(YA.NONTAX_HIGH_SCH_AMT, 0), 10, 0) -- �����-����_��������/Ȱ����;
                        || LPAD(NVL(YA.NONTAX_SPECIAL_AMT, 0), 10, 0) -- �����-Ư���������������_��������/Ȱ����;
                        || LPAD(NVL(YA.NONTAX_RESEARCH_AMT, 0), 10, 0) -- �����-�������_��������/Ȱ����;
                        || LPAD(NVL(YA.NONTAX_COMPANY_AMT, 0), 10, 0) -- �����-���������_��������/Ȱ����;
                        || LPAD(NVL(YA.NONTAX_COVER_AMT, 0), 10, 0) -- �����-�������;
                        || LPAD(NVL(YA.NONTAX_WILD_AMT, 0), 10, 0) -- �����-��������;
                        || LPAD(NVL(YA.NONTAX_DISASTER_AMT, 0), 10, 0) -- �����-���ذ��ñ޿�;
                        || LPAD(NVL(YA.NONTAX_OUTS_GOVER_AMT, 0), 10, 0) -- �����-�ܱ����ε�ٹ���;
                        || LPAD(NVL(YA.NONTAX_OUTS_ARMY_AMT, 0), 10, 0) -- �����-�ܱ��ֵб��ε�;
                        || LPAD(NVL(YA.NONTAX_OUTS_WORK_1, 0), 10, 0) -- �����-���ܱٷ�(100����);
                        || LPAD(NVL(YA.NONTAX_OUTS_WORK_2, 0), 10, 0) -- �����-���ܱٷ�(150����);
                        || LPAD(NVL(YA.NONTAX_OUTSIDE_AMT, 0), 10, 0) -- ����� ���ܼҵ�;
                        || LPAD(NVL(YA.NONTAX_OT_AMT, 0), 10, 0) -- ����� �߰��ٷ�;
                        || LPAD(NVL(YA.NONTAX_BIRTH_AMT, 0), 10, 0) -- ����� ���/��������;
                        || LPAD(0, 10, 0)  -- �ٷ����б�.
                        || LPAD(NVL(YA.NONTAX_STOCK_BENE_AMT, 0), 10, 0) -- �����-�ֽĸż����ñ�;
                        || LPAD(NVL(YA.NONTAX_FOR_ENG_AMT, 0), 10, 0) -- �����-�ܱ��α����;
                        --|| LPAD(NVL(YA.NONTAX_FOREIGNER_AMT, 0), 10, 0) -- ����� �ܱ��� �ٷ���(X);
                        --|| LPAD(NVL(YA.NONTAX_EMPL_STOCK_AMT, 0), 10, 0) --  �����-�츮�������չ���(X);
                        || LPAD(NVL(YA.NONTAX_EMPL_BENE_AMT_1, 0), 10, 0) -- �����-�츮�������������(50%);
                        || LPAD(NVL(YA.NONTAX_EMPL_BENE_AMT_2, 0), 10, 0) -- �����-�츮�������������(75%);
                        || LPAD(0, 10, 0) -- �����-��������� �߼ұ�� ���;
                        --|| LPAD(NVL(YA.NONTAX_HOUSE_SUBSIDY_AMT, 0), 10, 0) -- �����-�����ڱݺ�����(X);
                        || LPAD(NVL(YA.NONTAX_SEA_RESOURCE_AMT, 0), 10, 0) -- �����-���������ڿ�����;
                        || LPAD(0, 10, 0) -- ���������;
                        -- ����� ��;
                        || LPAD((NVL(YA.NONTAX_SCH_EDU_AMT, 0) +
                                NVL(YA.NONTAX_MEMBER_AMT, 0) +
                                NVL(YA.NONTAX_GUARD_AMT, 0) +
                                NVL(YA.NONTAX_CHILD_AMT, 0) +
                                NVL(YA.NONTAX_HIGH_SCH_AMT, 0) +
                                NVL(YA.NONTAX_SPECIAL_AMT, 0) +
                                NVL(YA.NONTAX_RESEARCH_AMT, 0) +
                                NVL(YA.NONTAX_COMPANY_AMT, 0) +
                                NVL(YA.NONTAX_COVER_AMT, 0) +
                                NVL(YA.NONTAX_WILD_AMT, 0) +
                                NVL(YA.NONTAX_DISASTER_AMT, 0) +
                                NVL(YA.NONTAX_OUTS_GOVER_AMT, 0) +
                                NVL(YA.NONTAX_OUTS_ARMY_AMT, 0) +
                                NVL(YA.NONTAX_OUTS_WORK_1, 0) +
                                NVL(YA.NONTAX_OUTS_WORK_2, 0) +
                                NVL(YA.NONTAX_OUTSIDE_AMT, 0) +
                                NVL(YA.NONTAX_OT_AMT, 0) +
                                NVL(YA.NONTAX_BIRTH_AMT, 0) +
                                --NVL(YA.NONTAX_FOREIGNER_AMT, 0) +
                                --NVL(YA.NONTAX_EMPL_STOCK_AMT, 0) +
                                NVL(YA.NONTAX_EMPL_STOCK_AMT, 0) +
                                --NVL(YA.NONTAX_FOR_ENG_AMT, 0) +  -- �ܱ��� �����(����ҵ� ��� �̵�);
                                NVL(YA.NONTAX_EMPL_BENE_AMT_1, 0) +
                                NVL(YA.NONTAX_EMPL_BENE_AMT_2, 0) +
                                --NVL(YA.NONTAX_HOUSE_SUBSIDY_AMT, 0) +                       
                                NVL(YA.NONTAX_SEA_RESOURCE_AMT, 0))  -- ���������ڿ�����(����ҵ� ��� �̵�);
                                --NVL(YA.NONTAX_ETC_AMT, 0),
                                , 10, 0)  -- �������.
                        || LPAD(NVL(YA.NONTAX_FOR_ENG_AMT, 0) + NVL(YA.NONTAX_SEA_RESOURCE_AMT, 0), 10, 0)    -- ����ҵ��(�׸�48 + �׸�52);
                        /*|| LPAD(NVL(YA.NONTAX_RESEA_AMT, 0), 10, 0)      -- AS NONTAX_RESEA_AMT
                        || LPAD(NVL(YA.NONTAX_OUTSIDE_AMT, 0), 10, 0) --AS  NONTAX_OUTSIDE_AMT
                        || LPAD(NVL(YA.NONTAX_OT_AMT, 0), 10, 0)  --AS NONTAX_OT_AMT
                        || LPAD(NVL(YA.NONTAX_BIRTH_AMT, 0), 10, 0)  --AS NONTAX_BIRTH_AMT
                        || LPAD(NVL(YA.NONTAX_FOREIGNER_AMT, 0), 10, 0)  --AS NONTAX_FOREIGNER_AMT
                        || LPAD(NVL(YA.NONTAX_ETC_AMT, 0), 10, 0)  --AS NONTAX_ETC_AMT
                        || LPAD(NVL(YA.NONTAX_OUTSIDE_AMT, 0) + 
                                NVL(YA.NONTAX_OT_AMT, 0) + 
                                NVL(YA.NONTAX_RESEA_AMT, 0) + 
                                NVL(YA.NONTAX_ETC_AMT, 0), 10, 0)  --����� �հ�.*/
                        --> �����.
                        || LPAD(NVL(YA.INCOME_TOT_AMT, 0), 11, 0) -- �ѱ޿�;
                        || LPAD(NVL(YA.INCOME_DED_AMT, 0), 10, 0) -- �ٷμҵ����;
                        || LPAD(NVL(YA.INCOME_TOT_AMT, 0) - NVL(YA.INCOME_DED_AMT, 0), 11, 0) -- �ٷμҵ�ݾ�;
                        --> �⺻����.
                        || LPAD(NVL(YA.PER_DED_AMT, 0), 8, 0) -- ���ΰ����ݾ�;
                        || LPAD(NVL(YA.SPOUSE_DED_AMT, 0), 8, 0) -- ����ڰ����ݾ�;
                        || LPAD(NVL(YA.SUPP_DED_COUNT, 0), 2, 0) -- �ξ簡�������ο�;
                        || LPAD(NVL(YA.SUPP_DED_AMT, 0), 8, 0) -- �ξ簡�������ݾ�;
                        --> �߰�����.
                        -- 2009�� �������� ����(MODIFIED BY YOUNG MIN). ��ο������ο� 70���̻� ����;
                        || LPAD(NVL(YA.OLD_DED_COUNT1, 0), 2, 0) -- ��ο������ο�;
                        || LPAD(NVL(YA.OLD_DED_AMT1, 0), 8, 0) -- ��ο������ݾ�;
                        /*|| LPAD(NVL(YA.OLD_DED_COUNT, 0) + NVL(YA.OLD_DED_COUNT1, 0), 2, 0) -- ��ο������ο�;*/
                        /*|| LPAD(NVL(YA.OLD_DED_AMT, 0) + NVL(YA.OLD_DED_AMT1, 0), 8, 0) -- ��ο������ݾ�;*/
                        || LPAD(NVL(YA.DISABILITY_DED_COUNT, 0), 2, 0) -- ����ΰ����ο�;
                        || LPAD(NVL(YA.DISABILITY_DED_AMT, 0), 8, 0) -- ����ΰ����ݾ�;
                        || LPAD(NVL(YA.WOMAN_DED_AMT, 0), 8, 0) -- �γ��ڰ����ݾ�;
                        || LPAD(NVL(YA.CHILD_DED_COUNT, 0), 2, 0) -- �ڳ����������ο�;
                        || LPAD(NVL(YA.CHILD_DED_AMT, 0), 8, 0) -- �ڳ����������ݾ�;
                        || LPAD(NVL(YA.BIRTH_DED_COUNT, 0), 2, 0) -- ���/�Ծ��ڰ����ο�;
                        || LPAD(NVL(YA.BIRTH_DED_AMT, 0), 8, 0) --  ���/�Ծ��ڰ����ݾ�;
                        || LPAD(0, 10, 0) -- ����;
                        -- LPAD(NVL(YA.PER_ADD_DED_AMT, 0), 8, 0)   PER_ADD_DED_AMT;
                        --> ���ڳ��߰�����;
                        || LPAD(NVL(YA.MANY_CHILD_DED_COUNT, 0), 2, 0) -- ���ڳ��߰������ο�;
                        || LPAD(NVL(YA.MANY_CHILD_DED_AMT, 0), 8, 0) -- ���ڳ��߰������ݾ�;
                        -->���ݺ����;
                        || LPAD(NVL(YA.NATI_ANNU_AMT, 0), 10, 0) -- ���ο��ݺ�������;
                        || LPAD(0, 10, 0)  -- ��Ÿ���ݺ�������_����������;
                        || LPAD(0, 10, 0)  -- ��Ÿ���ݺ�������_���ο���;
                        || LPAD(0, 10, 0)  -- ��Ÿ���ݺ�������_�縳�б�����������;
                        || LPAD(0, 10, 0)  -- ��Ÿ���ݺ�������_������ü������;
                        || LPAD(0, 10, 0)  -- ��Ÿ���ݺ�������_���б���ΰ���;
                        || LPAD(0, 10, 0)  -- ��Ÿ���ݺ�������_�ٷ��������޿������;
                        --|| LPAD(NVL(YA.ANNU_INSUR_AMT, 0), 10, 0) -- ��Ÿ���ݺ�������;
                        --|| LPAD(NVL(YA.RETR_ANNU_AMT, 0), 10, 0) -- �������ݼҵ����;
                        --> Ư������.
                        -- ����������;
                        -- 2009�� �������� ����(MODIFIED BY YOUNG MIN). ���������� 0�� �̸��� ��쿡�� 0�� ó��;
                        || LPAD(CASE 
                                  WHEN NVL(YA.MEDIC_INSUR_AMT, 0) < 0 THEN 0
                                  ELSE NVL(YA.MEDIC_INSUR_AMT, 0) 
                                END, 10, 0)  -- �ǰ������;
                        || LPAD(CASE 
                                  WHEN NVL(YA.HIRE_INSUR_AMT, 0) < 0 THEN 0
                                  ELSE NVL(YA.HIRE_INSUR_AMT, 0) 
                                END, 10, 0)  -- ��뺸���;
                        || LPAD(NVL(YA.GUAR_INSUR_AMT, 0), 10, 0)                           -- ���庸��� ;
                        || LPAD(NVL(YA.DISABILITY_INSUR_AMT, 0), 10, 0)                     -- ��ֺ���� ;
                        /*|| LPAD((CASE
                                  WHEN NVL(YA.MEDIC_INSUR_AMT, 0) +
                                      NVL(YA.HIRE_INSUR_AMT, 0) +
                                      NVL(YA.GUAR_INSUR_AMT, 0) +
                                      NVL(YA.DISABILITY_INSUR_AMT, 0) < 0 THEN 0
                                  ELSE NVL(YA.MEDIC_INSUR_AMT, 0) +
                                      NVL(YA.HIRE_INSUR_AMT, 0) +
                                      NVL(YA.GUAR_INSUR_AMT, 0) +
                                      NVL(YA.DISABILITY_INSUR_AMT, 0)
                                END), 10, 0) --AS ETC_INSURE_AMT*/
                        || LPAD(NVL(YA.MEDIC_AMT, 0), 10, 0)  -- �Ƿ������ݾ�;
                        || LPAD(NVL(YA.EDUCATION_AMT, 0), 8, 0) -- ����������ݾ�;
                        || LPAD(NVL(YA.HOUSE_INTER_AMT, 0), 8, 0) -- �����Ӵ������Աݿ����ݻ�ȯ�����ݾ�(������);
                        || LPAD(0, 8, 0)  -- �����������Աݿ����ݻ�ȯ��(������).
                        || LPAD(NVL(YA.HOUSE_MONTHLY_AMT, 0), 8, 0)  -- �����ڱ�_������;
                        || LPAD(NVL(YA.LONG_HOUSE_PROF_AMT, 0), 8, 0) -- ��������������Ա����ڻ�ȯ�����ݾ�;
                        || LPAD(NVL(YA.LONG_HOUSE_PROF_AMT_1, 0), 8, 0) -- ��������������Ա����ڻ�ȯ�����ݾ�(15);
                        || LPAD(NVL(YA.LONG_HOUSE_PROF_AMT_2, 0), 8, 0) -- ��������������Ա����ڻ�ȯ�����ݾ�(30);
                        || LPAD(NVL(YA.DONAT_AMT, 0), 10, 0)  -- ��αݰ����ݾ�;
                        || LPAD(0, 20, 0) --AS SP_DED_SPACE_VALUE
                        -- 2009�� �������� ����(MODIFIED BY YOUNG MIN). ȥ��/�̻��� ����;
                        /*|| LPAD(NVL(YA.MARRY_ETC_AMT, 0), 10, 0) -- ȥ��/�̻���;*/
                        || LPAD(( CASE
                                    WHEN NVL(YA.MEDIC_INSUR_AMT, 0) +
                                        NVL(YA.HIRE_INSUR_AMT, 0) +
                                        NVL(YA.GUAR_INSUR_AMT, 0) +
                                        NVL(YA.DISABILITY_INSUR_AMT, 0) < 0 THEN 0
                                    ELSE NVL(YA.MEDIC_INSUR_AMT, 0) +
                                        NVL(YA.HIRE_INSUR_AMT, 0) +
                                        NVL(YA.GUAR_INSUR_AMT, 0) +
                                        NVL(YA.DISABILITY_INSUR_AMT, 0)
                                  END) +
                                  NVL(YA.MEDIC_AMT, 0) +
                                  NVL(YA.EDUCATION_AMT, 0) +
                                  NVL(YA.HOUSE_INTER_AMT, 0) +
                                  NVL(YA.HOUSE_MONTHLY_AMT, 0) +
                                  NVL(YA.LONG_HOUSE_PROF_AMT, 0) +
                                  NVL(YA.LONG_HOUSE_PROF_AMT_1, 0) +
                                  NVL(YA.LONG_HOUSE_PROF_AMT_2, 0) +
                                  NVL(YA.DONAT_AMT, 0)/* + 
                                  NVL(YA.MARRY_ETC_AMT, 0)*/, 10, 0) -- ��;
                        || LPAD(NVL(YA.STAND_DED_AMT, 0), 8, 0) -- ǥ�ذ���;
                        || LPAD(NVL(YA.SUBT_DED_AMT, 0), 11, 0) -- �����ҵ�ݾ�;
                        --> �� ���� �ҵ����.
                        || LPAD(NVL(YA.PERS_ANNU_BANK_AMT, 0), 8, 0) -- ���ο�������ҵ����;
                        || LPAD(NVL(YA.ANNU_BANK_AMT, 0), 8, 0) -- ��������ҵ����;
                        || LPAD(NVL(YA.SMALL_CORPOR_DED_AMT, 0), 10, 0) -- �ұ�������αݼҵ����;
                        || LPAD(NVL(YA.HOUSE_APP_DEPOSIT_AMT, 0), 10, 0)  -- ��)���ø�������ҵ����-û������;
                        || LPAD(NVL(YA.HOUSE_APP_SAVE_AMT, 0), 10, 0) -- ��)���ø�������ҵ����-����û����������;
                        || LPAD(NVL(YA.HOUSE_SAVE_AMT, 0), 10, 0)  -- ��)������ø�������.
                        || LPAD(NVL(YA.WORKER_HOUSE_SAVE_AMT, 0), 10, 0)  -- ��)�ٷ������ø�������.
                        --|| LPAD(NVL(YA.HOUSE_SAVE_AMT, 0), 10, 0) -- ���ø�������ҵ����;
                        || LPAD(NVL(YA.INVES_AMT, 0), 10, 0) -- �����������ڵ�ҵ����;
                        || LPAD(NVL(YA.CREDIT_AMT, 0), 8, 0) -- �ſ�ī��� �ҵ����;                        
                        --|| LPAD(CASE
                        --        WHEN NVL(YA.EMPL_STOCK_AMT, 0) < 0 THEN 0
                        --        ELSE 1
                        --      END, 1, 0) -- �츮�������ռҵ����(����̸� 0);
                        || LPAD(ABS(NVL(YA.EMPL_STOCK_AMT, 0)), 10, 0) -- �츮�������ռҵ����(�ѵ� 400����);
                        || LPAD(NVL(YA.LONG_STOCK_SAVING_AMT, 0), 10, 0) -- ����ֽ�������ҵ����;
                        -- 2009�� �������� ����(MODIFIED BY YOUNG MIN). ��������߼ұ���ٷ��ڼҵ����/���� �߰�;
                        || LPAD(NVL(YA.HIRE_KEEP_EMPLOY_AMT, 0), 10, 0) -- ��������߼ұ���ٷ��ڼҵ����;
                        || LPAD(0, 10, 0) --AS  PERSON_DED_SPACE                                                      -- ����;
/*                        || LPAD(CASE
                                  WHEN NVL(YA.PERS_ANNU_BANK_AMT, 0) +
                                      NVL(YA.ANNU_BANK_AMT, 0) +
                                      NVL(YA.SMALL_CORPOR_DED_AMT, 0) +
                                      NVL(YA.HOUSE_SAVE_AMT, 0) +
                                      NVL(YA.INVES_AMT, 0) + NVL(YA.CREDIT_AMT, 0) +
                                      NVL(YA.EMPL_STOCK_AMT, 0) +
                                      NVL(YA.LONG_STOCK_SAVING_AMT, 0) +
                                      NVL(YA.HIRE_KEEP_EMPLOY_AMT, 0) < 0 THEN 1
                                  ELSE 0
                                END, 1, 0) -- �׹��� �ҵ���� ��(����̸� '0'����);*/
                        || LPAD((NVL(YA.PERS_ANNU_BANK_AMT, 0) +
                                NVL(YA.ANNU_BANK_AMT, 0) +
                                NVL(YA.SMALL_CORPOR_DED_AMT, 0) +
                                --NVL(YA.HOUSE_SAVE_AMT, 0) +
                                NVL(YA.HOUSE_APP_DEPOSIT_AMT, 0) +
                                NVL(YA.HOUSE_APP_SAVE_AMT, 0) +
                                NVL(YA.HOUSE_SAVE_AMT, 0) +
                                NVL(YA.WORKER_HOUSE_SAVE_AMT, 0) +
                                NVL(YA.INVES_AMT, 0) +
                                NVL(YA.CREDIT_AMT, 0) +
                                ABS(NVL(YA.EMPL_STOCK_AMT, 0)) +
                                NVL(YA.LONG_STOCK_SAVING_AMT, 0) +
                                NVL(YA.HIRE_KEEP_EMPLOY_AMT, 0)), 10, 0) -- �׹��� �ҵ���� ��(����̸� '0'����);
                        || LPAD(NVL(YA.TAX_STD_AMT, 0), 11, 0) -- ���ռҵ� ����ǥ��;
                        || LPAD(NVL(YA.COMP_TAX_AMT, 0), 10, 0) -- ���⼼��;
                        --> ���װ���.
                        || LPAD(NVL(YA.TAX_REDU_IN_LAW_AMT, 0), 10, 0) --�ҵ漼��;
                        || LPAD(NVL(YA.TAX_REDU_SP_LAW_AMT, 0), 10, 0) -- ����Ư�����ѹ�;
                        || LPAD(0, 10, 0) -- ��������.
                        || LPAD(0, 10, 0) -- ����;
                        || LPAD(NVL(YA.TAX_REDU_IN_LAW_AMT, 0) +
                                NVL(YA.TAX_REDU_SP_LAW_AMT, 0), 10, 0) -- ���鼼�װ�;
                        --> ���װ���.
                        || LPAD(NVL(YA.TAX_DED_INCOME_AMT, 0), 10, 0) -- �ٷμҵ漼�װ���;
                        || LPAD(NVL(YA.TAX_DED_TAXGROUP_AMT, 0), 10, 0) -- �������հ���;
                        || LPAD(NVL(YA.TAX_DED_HOUSE_DEBT_AMT, 0), 10, 0) -- �������Ա�;
                        --  , LPAD(NVL(YA.TAX_DED_LONG_STOCK_AMT, 0), 8, 0) -- ������ð���.
                        || LPAD(NVL(YA.TAX_DED_DONAT_POLI_AMT, 0), 10, 0) -- �����ġ�ڱ�;
                        || LPAD(NVL(YA.TAX_DED_OUTSIDE_PAY_AMT, 0), 10, 0) -- �ܱ�����;
                        || LPAD(0, 10, 0) -- ����;
                        || LPAD(NVL(YA.TAX_DED_INCOME_AMT, 0) +
                                NVL(YA.TAX_DED_TAXGROUP_AMT, 0) +
                                NVL(YA.TAX_DED_HOUSE_DEBT_AMT, 0) +
                                NVL(YA.TAX_DED_DONAT_POLI_AMT, 0) +
                                NVL(YA.TAX_DED_OUTSIDE_PAY_AMT, 0), 10, 0) -- ���װ�����;
                        --> ��������.
                        || LPAD(TRUNC(NVL(YA.FIX_IN_TAX_AMT, 0), 0), 10, 0) -- �ҵ漼(������ ����);
                        || LPAD(TRUNC(NVL(YA.FIX_LOCAL_TAX_AMT, 0), 0), 10, 0) -- �ֹμ�;
                        || LPAD(TRUNC(NVL(YA.FIX_SP_TAX_AMT, 0), 0), 10, 0) -- ��Ư��;
                        /* -- ��ȣ�� �ּ� : �հ� ����.
                        || LPAD(TRUNC(NVL(YA.FIX_IN_TAX_AMT, 0), -1) +
                                TRUNC(NVL(YA.FIX_LOCAL_TAX_AMT, 0), -1) +
                                TRUNC(NVL(YA.FIX_SP_TAX_AMT, 0), -1), 10, 0) -- �������� �հ�;*/ 
                        /* -- ��(��)���μ��� ����.
                        --> ��(��) ���μ���.
                        || LPAD(TRUNC(NVL(HEW1.IN_TAX_AMT, 0), -1), 10, 0) -- �ҵ漼.
                        || LPAD(TRUNC(NVL(HEW1.LOCAL_TAX_AMT, 0), -1), 10, 0) -- �ֹμ�.
                        || LPAD(TRUNC(NVL(HEW1.SP_TAX_AMT, 0), -1), 10, 0) -- ��Ư��;
                        || LPAD(TRUNC(NVL(HEW1.IN_TAX_AMT, 0), -1) + 
                                TRUNC(NVL(HEW1.LOCAL_TAX_AMT, 0), -1) + 
                                TRUNC(NVL(HEW1.SP_TAX_AMT, 0), -1), 10, 0) -- ���� ���μ��� �հ�;*/
                        -- 2009�� �������� ����(MODIFIED BY YOUNG MIN). "��(��) ���μ���"���� "�ⳳ�μ��� - ��(��)�ٹ���"�� ��Ī ����;
                        --> �ⳳ�μ��� - ��(��)�ٹ���;
                        || LPAD(TRUNC(NVL(YA.PRE_IN_TAX_AMT, 0) - NVL(S_PW.IN_TAX_AMT, 0), -1), 10, 0) -- �ҵ漼.
                        || LPAD(TRUNC(NVL(YA.PRE_LOCAL_TAX_AMT, 0) - NVL(S_PW.LOCAL_TAX_AMT, 0), -1), 10, 0) --�ֹμ�.
                        || LPAD(TRUNC(NVL(YA.PRE_SP_TAX_AMT, 0) - NVL(S_PW.SP_TAX_AMT, 0), -1), 10, 0) -- ��Ư��.
                        /* -- ��ȣ�� �ּ� : �հ� ����.
                        || LPAD(TRUNC(NVL(YA.PRE_IN_TAX_AMT, 0) - NVL(HEW1.IN_TAX_AMT, 0), -1) +
                                TRUNC(NVL(YA.PRE_LOCAL_TAX_AMT, 0) - NVL(HEW1.LOCAL_TAX_AMT, 0), -1) +
                                TRUNC(NVL(YA.PRE_SP_TAX_AMT, 0) - NVL(HEW1.SP_TAX_AMT, 0), -1), 10, 0) -- ��(��) ���μ��� �հ�;*/
                        --> ����¡������;
                        -- 2009�� �������� ����(MODIFIED BY YOUNG MIN). "����¡������"�߰�(10���̸� �ܼ�����);
                        -- �������� - [��(��)�ٹ��� �ⳳ�μ��� + ��(��)�ٹ��� �ⳳ�μ����� ��];
                        || LPAD(CASE
                                  WHEN TRUNC(NVL(YA.FIX_IN_TAX_AMT, 0), -1) - TRUNC(NVL(YA.PRE_IN_TAX_AMT, 0), -1) < 0 THEN 1
                                  ELSE 0
                                END, 1, 0)  -- 0 <= ����¡������(�ҵ漼) < 1000 �� ��� "0"����;
                        || LPAD(ABS(TRUNC(TRUNC(NVL(YA.FIX_IN_TAX_AMT, 0), -1) - TRUNC(NVL(YA.PRE_IN_TAX_AMT, 0), -1))), 10, 0) -- �����ҵ漼.
                        || LPAD(CASE
                                  WHEN (TRUNC(NVL(YA.FIX_LOCAL_TAX_AMT, 0), -1) - TRUNC(NVL(YA.PRE_LOCAL_TAX_AMT, 0), -1)) < 0 THEN 1
                                  ELSE 0
                                END, 1, 0)  -- 0 <= ����¡������(�ֹμ�) < 1000 �� ��� "0"����;
                        || LPAD(ABS(TRUNC(TRUNC(NVL(YA.FIX_LOCAL_TAX_AMT, 0), -1) - TRUNC(NVL(YA.PRE_LOCAL_TAX_AMT, 0), -1))), 10, 0) -- �����ֹμ�.
                        || LPAD(CASE
                                  WHEN (TRUNC(NVL(YA.FIX_SP_TAX_AMT, 0), -1) - TRUNC(NVL(YA.PRE_SP_TAX_AMT, 0), -1)) < 0 THEN 1
                                  ELSE 0
                                END, 1, 0)  -- 0 <= ����¡������(��Ư��) < 1000 �� ��� "0"����;
                        || LPAD(ABS(TRUNC(TRUNC(NVL(YA.FIX_SP_TAX_AMT, 0), -1) - TRUNC(NVL(YA.PRE_SP_TAX_AMT, 0), -1))), 10, 0)  -- ���� ��Ư��.
                        /*|| LPAD(CASE
                                  WHEN (TRUNC(NVL(YA.FIX_IN_TAX_AMT, 0), -1) - TRUNC(NVL(YA.PRE_IN_TAX_AMT, 0), -1) +
                                      TRUNC(NVL(YA.FIX_LOCAL_TAX_AMT, 0), -1) - TRUNC(NVL(YA.PRE_LOCAL_TAX_AMT, 0), -1) +
                                      TRUNC(NVL(YA.FIX_SP_TAX_AMT, 0), -1) - TRUNC(NVL(YA.PRE_SP_TAX_AMT, 0), -1)) < 0 THEN 1
                                  ELSE 0
                                END, 1, 0) -- ����¡������ ��;
                        -- ��ȣ�� �ּ�.
                        || LPAD(ABS(TRUNC(TRUNC(NVL(YA.FIX_IN_TAX_AMT, 0), -1) - TRUNC(NVL(YA.PRE_IN_TAX_AMT, 0), -1)) +
                                   TRUNC(TRUNC(NVL(YA.FIX_LOCAL_TAX_AMT, 0), -1) - TRUNC(NVL(YA.PRE_LOCAL_TAX_AMT, 0), -1)) +
                                   TRUNC(TRUNC(NVL(YA.FIX_SP_TAX_AMT, 0), -1) - TRUNC(NVL(YA.PRE_SP_TAX_AMT, 0), -1))), 10, 0) -- ����¡������ ��;*/
                        --> ����.
                        || LPAD(' ', 5, ' ') AS RECORD_FILE
                        , NVL(YA.MEDIC_INSUR_AMT, 0) + NVL(YA.HIRE_INSUR_AMT, 0) AS MEDIC_INSUR_AMT  -- 'E'���ڵ忡�� ���(����û���� ����� ���� ����).
                        , NVL(YA.TAX_DED_DONAT_POLI_AMT, 0) AS TAX_DED_DONAT_POLI_AMT 
                        , PM.PERSON_ID
                        , REPLACE(PM.REPRE_NUM, '-') AS REPRE_NUM
                        , ROW_NUMBER() OVER(PARTITION BY YA.YEAR_YYYY ORDER BY PM.PERSON_NUM) AS C_SEQ_NO
                        , PM.JOIN_DATE
                        , PM.FOREIGN_TAX_YN
                      FROM HRM_PERSON_MASTER PM
                        , HRA_YEAR_ADJUSTMENT YA
                        , ( SELECT HC.COMMON_ID AS NATION_ID
                                , HC.CODE AS NATION_CODE
                                , HC.CODE_NAME AS NATION_NAME
                                , HC.VALUE1 AS ISO_NATION_CODE
                              FROM HRM_COMMON HC
                            WHERE HC.GROUP_CODE   = 'NATION'
                              AND HC.SOB_ID       = P_SOB_ID
                              AND HC.ORG_ID       = P_ORG_ID
                           ) S_HN
                        , ( -- �����ٹ�ó ����.
                            SELECT PW.YEAR_YYYY
                                , PW.PERSON_ID
                                , COUNT(PW.PERSON_ID) AS PRE_WORK_COUNT
                                , SUM(PW.IN_TAX_AMT) AS IN_TAX_AMT
                                , SUM(PW.LOCAL_TAX_AMT) AS LOCAL_TAX_AMT
                                , SUM(PW.SP_TAX_AMT) AS SP_TAX_AMT
                              FROM HRA_PREVIOUS_WORK PW
                                , HRM_PERSON_MASTER PM
                            WHERE PW.PERSON_ID    = PM.PERSON_ID
                              AND PW.YEAR_YYYY    = P_YEAR_YYYY
                              AND PM.CORP_ID      = P_CORP_ID
                              AND PW.SOB_ID       = P_SOB_ID
                              AND PW.ORG_ID       = P_ORG_ID
                            GROUP BY PW.YEAR_YYYY
                                , PW.PERSON_ID
                          ) S_PW
                    WHERE PM.PERSON_ID      = YA.PERSON_ID
                      AND PM.NATION_ID      = S_HN.NATION_ID(+)
                      AND YA.YEAR_YYYY      = S_PW.YEAR_YYYY(+)
                      AND YA.PERSON_ID      = S_PW.PERSON_ID(+)
                      AND YA.YEAR_YYYY      = P_YEAR_YYYY
                      AND YA.CORP_ID        = P_CORP_ID
                      AND YA.SOB_ID         = P_SOB_ID
                      AND YA.ORG_ID         = P_ORG_ID
                      AND YA.SUBMIT_DATE    BETWEEN P_START_DATE AND P_END_DATE
                      AND YA.INCOME_TOT_AMT <> 0
                      AND YA.ADJUST_DATE_TO BETWEEN P_START_DATE AND P_END_DATE
                      /*AND PM.ORI_JOIN_DATE  <= TO_DATE(P_YEAR_YYYY||'-12-31','YYYY-MM-DD')
                      AND (PM.RETIRE_DATE   >= TO_DATE(P_YEAR_YYYY||'-12-31','YYYY-MM-DD') OR PM.RETIRE_DATE IS NULL)*/
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
              , P_SORT_NUM          => 1
              );
            --DBMS_OUTPUT.PUT_LINE(C1.RECORD_FILE); 
--D1 ------------------------------------------------------------------------------------
            --> ��(��)�ٹ�ó ���ڵ� <--
            FOR D1 IN ( SELECT -- �ڷ������ȣ;
                              'D' -- ���ڵ� ����;
                            || '20' -- �ڷᱸ��;
                            || RPAD(B1.TAX_OFFICE_CODE, 3, ' ') -- �������ڵ�;
                            || LPAD(C1.C_SEQ_NO, 6, '0') -- C���ڵ��� �Ϸù�ȣ.
                            -- ��õ¡���ǹ���;
                            || RPAD(B1.VAT_NUMBER, 10, ' ') -- ����ڹ�ȣ.
                            || RPAD(' ', 50, ' ') -- ����;
                            -- �ҵ���;
                            || RPAD(NVL(C1.REPRE_NUM, ' '), 13, ' ') -- �ֹι�ȣ.
                            -- �ٹ�ó�� �ҵ�� - ��(��)�ٹ�ó;
                            || RPAD('2',1,' ') -- �������ձ���;
                            || RPAD(PW.COMPANY_NAME, 40, ' ') -- ���θ�(��ȣ);
                            || RPAD(REPLACE(PW.COMPANY_NUM, '-', ''), 10, ' ') -- ����ڵ�Ϲ�ȣ;
                            -- 2009�� �������� ����(MODIFIED BY YOUNG MIN). �ٹ��Ⱓ/����Ⱓ ����/���Ῥ���� �߰�;
                            || RPAD(CASE -- �ٹ��Ⱓ ���ۿ�����;
                                      WHEN PW.JOIN_DATE > TO_DATE(P_YEAR_YYYY || '-01-01', 'YYYY-MM-DD') THEN TO_CHAR(PW.JOIN_DATE, 'YYYYMMDD')
                                      ELSE P_YEAR_YYYY || '0101'
                                    END, 8, '0')
                            || RPAD(TO_CHAR(NVL(PW.RETR_DATE, C1.JOIN_DATE -1), 'YYYYMMDD'), 8, '0') -- �ٹ��Ⱓ ���Ῥ����;
                            || LPAD('0', 8, '0') -- ����Ⱓ ���ۿ�����;
                            || LPAD('0', 8, '0') -- ����Ⱓ ���Ῥ����;
                            || LPAD(NVL(PW.PAY_TOTAL_AMT, 0), 11, 0) -- �޿��Ѿ�;
                            || LPAD(NVL(PW.BONUS_TOTAL_AMT, 0), 11, 0) -- ���Ѿ�;
                            || LPAD(NVL(PW.ADD_BONUS_AMT, 0), 11, 0) -- ������;
                            || LPAD(NVL(PW.STOCK_BENE_AMT, 0), 11, 0) -- �ֽĸż����ñ��������;
                            -- 2009�� �������� ����(MODIFIED BY YOUNG MIN). �츮������������� �߰�;
                            || LPAD(0, 11, 0) -- �츮�������������(�迡�� �������� �ʾ���);
                            || LPAD(0, 22, 0)
                            || LPAD(NVL(PW.PAY_TOTAL_AMT, 0) +
                                    NVL(PW.BONUS_TOTAL_AMT, 0) +
                                    NVL(PW.ADD_BONUS_AMT, 0) +
                                    NVL(PW.STOCK_BENE_AMT, 0), 11, 0)  -- ��.
                            --> ��(��)�ٹ�ó ����� �ҵ�.
                            -- 2009�� �������� ����(MODIFIED BY YOUNG MIN).��(��)�ٹ�ó ����� �ҵ� ���麯��;
                            || LPAD(NVL(PW.NT_SCH_EDU_AMT, 0), 10, 0) -- �����-���ڱ�;
                            || LPAD(NVL(PW.NT_MEMBER_AMT, 0), 10, 0) -- �����-��������������;
                            || LPAD(NVL(PW.NT_GUARD_AMT, 0), 10, 0) -- �����-��ȣ/�¼�����;
                            || LPAD(NVL(PW.NT_CHILD_AMT, 0), 10, 0) -- �����-����/���ߵ�_��������/Ȱ����;
                            || LPAD(NVL(PW.NT_HIGH_SCH_AMT, 0), 10, 0) -- �����-����_��������/Ȱ����;
                            || LPAD(NVL(PW.NT_SPECIAL_AMT, 0), 10, 0) -- �����-Ư���������������_��������/Ȱ����;
                            || LPAD(NVL(PW.NT_RESEARCH_AMT, 0), 10, 0) -- �����-�������_��������/Ȱ����;
                            || LPAD(NVL(PW.NT_COMPANY_AMT, 0), 10, 0) -- �����-���������_��������/Ȱ����;
                            || LPAD(NVL(PW.NT_COVER_AMT, 0), 10, 0) -- �����-�������;
                            || LPAD(NVL(PW.NT_WILD_AMT, 0), 10, 0) -- �����-��������;
                            || LPAD(NVL(PW.NT_DISASTER_AMT, 0), 10, 0) -- �����-���ذ��ñ޿�;
                            || LPAD(NVL(PW.NT_OUTSIDE_GOVER_AMT, 0), 10, 0) -- �����-�ܱ����ε�ٹ���;
                            || LPAD(NVL(PW.NT_OUTSIDE_ARMY_AMT, 0), 10, 0) -- �����-�ܱ��ֵб��ε�;
                            || LPAD(NVL(PW.NT_OUTSIDE_WORK1, 0), 10, 0) -- �����-���ܱٷ�(100����);
                            || LPAD(NVL(PW.NT_OUTSIDE_WORK2, 0), 10, 0) -- �����-���ܱٷ�(150����);
                            || LPAD(NVL(PW.NT_OUTSIDE_AMT, 0), 10, 0) -- ����� ���ܼҵ�;
                            || LPAD(NVL(PW.NT_OT_AMT, 0), 10, 0) -- ����� �߰��ٷ�;
                            || LPAD(NVL(PW.NT_BIRTH_AMT, 0), 10, 0) -- ����� ���/��������;
                            || LPAD(0, 10, 0) -- �ٷ����б�.
                            || LPAD(NVL(PW.NT_STOCK_BENE_AMT, 0), 10, 0) -- �����-�ֽĸż����ñ�;
                            || LPAD(NVL(PW.NT_FOREIGNER_AMT, 0), 10, 0) -- �����-�ܱ��α����;
                            --|| LPAD(NVL(PW.NONTAX_FOREIGNER_AMT, 0), 10, 0) -- ����� �ܱ��� �ٷ���;
                            --|| LPAD(NVL(PW.NONTAX_EMPL_STOCK_AMT, 0), 10, 0) --  �����-�츮�������չ���;
                            || LPAD(NVL(PW.NT_EMPL_STOCK_AMT, 0), 10, 0) -- �����-�츮�������������(50%);
                            || LPAD(NVL(PW.NT_EMPL_BENE_AMT2, 0), 10, 0) -- �����-�츮�������������(75%);
                            || LPAD(0, 10, 0)                                  -- �����-��������� �߼ұ�� ���;
                            --|| LPAD(NVL(PW.NONTAX_HOUSE_SUBSIDY_AMT, 0), 10, 0) -- �����-�����ڱݺ�����;
                            || LPAD(NVL(PW.NT_SEA_RESOURCE_AMT, 0), 10, 0) -- �����-���������ڿ�����;
                            || LPAD(0, 10, 0)                                  -- ���������;
                            --|| LPAD(NVL(PW.NONTAX_ETC_AMT, 0), 10, 0) --AS NONTAX_ETC_AMT     -- ����� ��Ÿ;
                            || LPAD(NVL(PW.NT_SCH_EDU_AMT, 0) +
                                    NVL(PW.NT_MEMBER_AMT, 0) +
                                    NVL(PW.NT_GUARD_AMT, 0) +
                                    NVL(PW.NT_CHILD_AMT, 0) +
                                    NVL(PW.NT_HIGH_SCH_AMT, 0) +
                                    NVL(PW.NT_SPECIAL_AMT, 0) +
                                    NVL(PW.NT_RESEARCH_AMT, 0) +
                                    NVL(PW.NT_COMPANY_AMT, 0) +
                                    NVL(PW.NT_COVER_AMT, 0) +
                                    NVL(PW.NT_WILD_AMT, 0) +
                                    NVL(PW.NT_DISASTER_AMT, 0) +
                                    NVL(PW.NT_OUTSIDE_GOVER_AMT, 0) +
                                    NVL(PW.NT_OUTSIDE_ARMY_AMT, 0) +
                                    NVL(PW.NT_OUTSIDE_WORK1, 0) +
                                    NVL(PW.NT_OUTSIDE_WORK2, 0) +
                                    NVL(PW.NT_OUTSIDE_AMT, 0) +
                                    NVL(PW.NT_OT_AMT, 0) +
                                    NVL(PW.NT_BIRTH_AMT, 0) +
                                    --NVL(PW.NONTAX_FOR_ENG_AMT, 0) +                           -- ����ҵ� ��� �̵�;
                                    --NVL(PW.NONTAX_FOREIGNER_AMT, 0) +
                                    --NVL(PW.NONTAX_EMPL_STOCK_AMT, 0) +
                                    NVL(PW.NT_EMPL_BENE_AMT1, 0) +
                                    NVL(PW.NT_EMPL_BENE_AMT2, 0),
                                    --NVL(PW.NONTAX_HOUSE_SUBSIDY_AMT, 0) +
                                    --NVL(PW.NONTAX_SEA_RESOURCE_AMT, 0) +                      -- ����ҵ� ��� �̵�;
                                    --NVL(PW.NONTAX_ETC_AMT, 0),
                                    10, 0)  -- ����� ��;
                            || LPAD(NVL(PW.NT_FOREIGNER_AMT, 0) +
                                    NVL(PW.NT_SEA_RESOURCE_AMT, 0), 10, 0)  -- ����ҵ� ��;
                            -- �ⳳ�μ��� - ��(��)�ٹ���;
                            || LPAD(NVL(PW.IN_TAX_AMT, 0), 10, 0)
                            || LPAD(NVL(PW.LOCAL_TAX_AMT, 0), 10, 0)
                            || LPAD(NVL(PW.SP_TAX_AMT, 0), 10, 0)
                            /*-- ��ȣ�� �ּ� : 2011�� ������.
                            || LPAD(NVL(PW.IN_TAX_AMT, 0) +
                                    NVL(PW.LOCAL_TAX_AMT, 0) +
                                    NVL(PW.SP_TAX_AMT, 0), 10, 0)*/
                            -- || LPAD(NVL(PW.PAY_TOTAL_AMT, 0) + NVL(PW.BONUS_TOTAL_AMT, 0) + NVL(PW.ADD_BONUS_AMT, 0) + NVL(PW.STOCK_BENE_AMT, 0),11, 0) --AS PAY_SUM_AMT                       -- ��;
                            || LPAD(ROW_NUMBER() OVER(PARTITION BY PW.PERSON_ID ORDER BY PW.SEQ_NUM), 2, 0) -- ��(��)�ٹ�ó �Ϸù�ȣ;
                            || RPAD(' ', 692, ' ') AS RECORD_FILE 
                            , ROW_NUMBER() OVER(PARTITION BY PW.PERSON_ID ORDER BY PW.SEQ_NUM) AS D_SEQ_NO
                          FROM HRA_PREVIOUS_WORK PW
                        WHERE PW.YEAR_YYYY    = P_YEAR_YYYY
                          AND PW.SOB_ID       = P_SOB_ID
                          AND PW.ORG_ID       = P_ORG_ID
                          AND PW.PERSON_ID    = C1.PERSON_ID
                      )
            LOOP
              V_SOURCE_FILE := 'D_RECORD';
              INSERT_REPORT_FILE
                ( P_SEQ_NUM           => V_SEQ_NUM
                , P_SOURCE_FILE       => V_SOURCE_FILE
                , P_SOB_ID            => P_SOB_ID
                , P_ORG_ID            => P_ORG_ID
                , P_REPORT_FILE       => D1.RECORD_FILE
                , P_SORT_NUM          => 2 + ( 0.1 * D1.D_SEQ_NO)
                );
              --DBMS_OUTPUT.PUT_LINE(D1.RECORD_FILE); 
            END LOOP D1;
--E1 ------------------------------------------------------------------------------------
-- �ܱ��� ���ϼ����� �ƴҰ�츸 ����.
          IF C1.FOREIGN_TAX_YN = 'N' THEN
            V_RECORD_FILE := NULL;
            V_SEQ_NO    := 0;
            V_RECORD_COUNT := 0;
            FOR E1 IN ( SELECT 
                              'E' --AS RECORD_TYPE
                            || '20' --AS DATA_TYPE
                            || RPAD(NVL(B1.TAX_OFFICE_CODE, ' '), 3, ' ') -- �������ڵ�.
                            || LPAD(NVL(C1.C_SEQ_NO, 0), 6, 0)  -- C���ڵ��� �Ϸù�ȣ.
                            || RPAD(NVL(B1.VAT_NUMBER, ' '), 10, ' ') -- ����ڹ�ȣ.
                            || RPAD(NVL(C1.REPRE_NUM, ' '), 13, ' ') AS RECORD_HEADER -- �ֹι�ȣ.
                            --> �ҵ������ ��������.
                            , RPAD(NVL(SF.RELATION_CODE, ' '), 1, ' ') -- ����;
                            || RPAD(CASE
                                      WHEN SUBSTR(REPLACE(SF.REPRE_NUM, '-', ''), 7, 1) BETWEEN '5' AND '8' THEN '9'
                                      ELSE '1'
                                    END, 1, ' ') -- ��/�ܱ��� ���� �ڵ�;
                            || RPAD(NVL(SF.FAMILY_NAME, ' '), 20, ' ') -- ����;
                            || RPAD(REPLACE(SF.REPRE_NUM, '-', ''), 13, ' ') -- �ֹι�ȣ;
                            || DECODE(SF.BASE_YN, 'Y', '1', ' ') -- �⺻����;
                            || CASE 
                                 WHEN SF.BASE_YN = 'Y' AND SF.DISABILITY_YN = 'Y' THEN '1'
                                 ELSE ' '
                               END  -- ����ΰ���;
                            || DECODE(SF.CHILD_YN, 'Y', '1', ' ') -- �ڳ���������;
                            || DECODE(SF.WOMAN_YN, 'Y', '1', ' ') -- �γ��ڰ���;
                            -- 2009�� �������� ����(MODIFIED BY YOUNG MIN).��ο�� ��70���̻����� ����;
                            || CASE
                                 --WHEN SF.OLD_YN = 'Y' THEN '1'
                                 WHEN SF.OLD1_YN = 'Y' THEN '1'
                                 ELSE ' '
                               END -- ��ο�����;
                            -- 2009�� �������� ����(MODIFIED BY YOUNG MIN).����Ծ��ڰ����߰�;
                            || DECODE(SF.BIRTH_YN, 'Y', '1', ' ') -- ����Ծ��ڰ���.
                            /*-- 2009�� �������� ����(MODIFIED BY YOUNG MIN).���ڳ��߰����� ����;
                            || CASE
                                 WHEN SF.BASE_YN = 'Y' AND C1.MANY_CHILD_DED_AMT <> 0 AND SF.RELATION_CODE = '4' THEN '1'
                                 ELSE ' '
                               END -- ���ڳ��߰�����;*/
                            --> ����û �ڷ�.
                            -- 2009�� �������� ����(MODIFIED BY YOUNG MIN).����û�ڷ� �����ݾ��� ������ ��� 0���� ǥ��;
                            || LPAD((CASE
                                       WHEN DECODE(SF.RELATION_CODE, 0, NVL(C1.MEDIC_INSUR_AMT, 0), 0) + 
                                            NVL(SF.INSURE_AMT, 0) + NVL(SF.DISABILITY_INSURE_AMT, 0) < 0 THEN 0
                                       ELSE DECODE(SF.RELATION_CODE, 0, NVL(C1.MEDIC_INSUR_AMT, 0), 0) + 
                                            NVL(SF.INSURE_AMT, 0) + NVL(SF.DISABILITY_INSURE_AMT, 0)
                                     END), 10, 0) -- �����(������ �ǰ������ ����);
                            || LPAD(NVL(SF.MEDICAL_AMT, 0), 10, 0) --  �Ƿ��;
                            || LPAD(NVL(SF.EDUCATION_AMT, 0), 10, 0) -- ������;
                            || LPAD(NVL(SF.CREDIT_AMT, 0), 10, 0) -- �ſ�ī���;
                            || LPAD(NVL(SF.CHECK_CREDIT_AMT , 0), 10, 0) -- ����ī��;
                            || LPAD(NVL(SF.CASH_AMT, 0) + NVL(SF.ACADE_GIRO_AMT, 0), 10, 0) -- ���ݿ�����;
                            || LPAD(NVL(SF.DONAT_ALL, 0) +
                                    NVL(SF.DONAT_50P, 0) +
                                    NVL(SF.DONAT_30P, 0) +
                                    NVL(SF.DONAT_10P, 0) +
                                    NVL(SF.DONAT_10P_RELIGION, 0), 10, 0)  -- ��α�.
                            -->����û�ڷ� �̿�.
                            || LPAD(NVL(SF.ETC_INSURE_AMT, 0), 10, 0) -- ����û�������� �����;
                            || LPAD(NVL(SF.ETC_MEDICAL_AMT, 0), 10, 0) -- ����û�������� �Ƿ��;
                            || LPAD(NVL(SF.ETC_EDUCATION_AMT, 0), 10, 0) -- ����û�������� ������;
                            || LPAD(NVL(SF.ETC_CREDIT_AMT, 0) + NVL(SF.ETC_ACADE_GIRO_AMT, 0), 10, 0) -- ����û�������� �ſ�ī��;
                            || LPAD(NVL(SF.ETC_CHECK_CREDIT_AMT, 0), 10, 0) -- ����û�������� ����ī��;
                            || LPAD(NVL(SF.ETC_DONAT_ALL, 0) +
                                    NVL(SF.ETC_DONAT_50P, 0) +
                                    NVL(SF.ETC_DONAT_30P, 0) +
                                    NVL(SF.ETC_DONAT_10P, 0) +
                                    NVL(SF.ETC_DONAT_10P_RELIGION, 0), 10, 0) AS RECORD_LINE -- ����û�������� ��α�;
                         FROM HRA_SUPPORT_FAMILY SF
                        WHERE SF.YEAR_YYYY      = P_YEAR_YYYY
                          AND (SF.BASE_YN        = 'Y'
                            OR SF.SPOUSE_YN      = 'Y'
                            OR SF.OLD_YN         = 'Y'
                            OR SF.OLD1_YN        = 'Y'
                            OR (SF.BASE_YN       = 'Y' AND SF.DISABILITY_YN  = 'Y')
                            OR SF.WOMAN_YN       = 'Y'
                            OR SF.CHILD_YN       = 'Y'
                            OR SF.BIRTH_YN       = 'Y'
                            OR ((NVL(SF.INSURE_AMT, 0) + NVL(SF.ETC_INSURE_AMT, 0) + NVL(SF.DISABILITY_INSURE_AMT, 0) + 
                                NVL(SF.ETC_DISABILITY_INSURE_AMT, 0) + NVL(SF.MEDICAL_AMT, 0) + NVL(SF.ETC_MEDICAL_AMT, 0) +
                                NVL(SF.EDUCATION_TYPE, 0) + NVL(SF.EDUCATION_AMT, 0) + NVL(SF.ETC_EDUCATION_AMT, 0) + 
                                NVL(SF.CREDIT_AMT, 0) + NVL(SF.ETC_CREDIT_AMT, 0) + NVL(SF.CHECK_CREDIT_AMT, 0) + 
                                NVL(SF.ETC_CHECK_CREDIT_AMT, 0) + NVL(SF.CASH_AMT, 0) + NVL(SF.ETC_CASH_AMT, 0) + 
                                NVL(SF.ACADE_GIRO_AMT, 0) + NVL(SF.ETC_ACADE_GIRO_AMT, 0) + 
                                NVL(SF.DONAT_ALL, 0) + NVL(SF.ETC_DONAT_ALL, 0) + NVL(SF.DONAT_50P, 0) + NVL(SF.ETC_DONAT_50P, 0) + 
                                NVL(SF.DONAT_30P, 0) + NVL(SF.ETC_DONAT_30P, 0) + NVL(SF.DONAT_10P, 0) + NVL(SF.ETC_DONAT_10P, 0) + 
                                NVL(SF.DONAT_10P_RELIGION, 0) + NVL(SF.ETC_DONAT_10P_RELIGION, 0) + 
                                NVL(SF.DONAT_POLI, 0) + NVL(SF.ETC_DONAT_POLI, 0))) > 0)
                          AND SF.PERSON_ID      = C1.PERSON_ID
                          AND SF.REPRE_NUM      IS NOT NULL
                        ORDER BY SF.RELATION_CODE
                      )
            LOOP
              V_RECORD_COUNT := NVL(V_RECORD_COUNT, 0) + 1;
              IF V_RECORD_COUNT = 1 THEN
                V_RECORD_FILE := E1.RECORD_HEADER || E1.RECORD_LINE;
              ELSE
                V_RECORD_FILE := V_RECORD_FILE || E1.RECORD_LINE;
              END IF;
              --> �ξ簡���� 5�� �̻��� ���.
              IF V_E_REC_STD <= V_RECORD_COUNT THEN
                V_SEQ_NO := NVL(V_SEQ_NO, 0) + 1;  -- �ξ簡�� ���� �Ϸù�ȣ.
                V_RECORD_FILE := V_RECORD_FILE 
                                 || LPAD(NVL(V_SEQ_NO, 1), 2, 0)  -- �Ϸù�ȣ.
                                 || RPAD(' ', 368, ' ');  -- ����.
                
                V_SOURCE_FILE := 'E_RECORD';
                INSERT_REPORT_FILE
                  ( P_SEQ_NUM           => V_SEQ_NUM
                  , P_SOURCE_FILE       => V_SOURCE_FILE
                  , P_SOB_ID            => P_SOB_ID
                  , P_ORG_ID            => P_ORG_ID
                  , P_REPORT_FILE       => V_RECORD_FILE
                  , P_SORT_NUM          => 3 + (0.001 * V_SEQ_NO)
                  );
                --DBMS_OUTPUT.PUT_LINE(V_RECORD_FILE); 
                V_RECORD_FILE  := NULL;
                V_RECORD_COUNT := 0;
              END IF;
            END LOOP E1;
            IF V_RECORD_COUNT <> 0 THEN
              FOR E1S IN V_RECORD_COUNT + 1 .. V_E_REC_STD
              LOOP
                V_RECORD_FILE := V_RECORD_FILE || RPAD(' ', 171, ' ');
              END LOOP E1S;
              IF V_RECORD_FILE IS NOT NULL THEN
                V_SEQ_NO := NVL(V_SEQ_NO, 0) + 1;  -- �ξ簡�� ���� �Ϸù�ȣ.
                V_RECORD_FILE := V_RECORD_FILE 
                                 || LPAD(NVL(V_SEQ_NO, 1), 2, 0)  -- �Ϸù�ȣ.
                                 || RPAD(' ', 368, ' ');  -- ����.
                                 
                V_SOURCE_FILE := 'E_RECORD';
                INSERT_REPORT_FILE
                  ( P_SEQ_NUM           => V_SEQ_NUM
                  , P_SOURCE_FILE       => V_SOURCE_FILE
                  , P_SOB_ID            => P_SOB_ID
                  , P_ORG_ID            => P_ORG_ID
                  , P_REPORT_FILE       => V_RECORD_FILE
                  , P_SORT_NUM          => 3 + (0.001 * V_SEQ_NO)
                  );
                --DBMS_OUTPUT.PUT_LINE(V_RECORD_FILE); 
              END IF;
            END IF;

--F1 ---------------------------------------------------------------------------------
            V_RECORD_FILE := NULL;
            V_SEQ_NO    := 0;
            V_RECORD_COUNT := 0;
            FOR F1 IN ( SELECT 'F' --AS RECORD_TYPE
                            || '20' --AS DATA_TYPE
                            || RPAD(NVL(B1.TAX_OFFICE_CODE, ' '), 3, ' ') -- �������ڵ�.
                            || LPAD(C1.C_SEQ_NO, 6, 0) -- C���ڵ��� �Ϸù�ȣ.
                            || RPAD(NVL(B1.VAT_NUMBER, ' '), 10, ' ') -- ����ڹ�ȣ.
                            || RPAD(NVL(C1.REPRE_NUM, ' '), 13, ' ') AS RECORD_HEADER -- �ֹι�ȣ.
                            , LPAD(NVL(SI.SAVING_TYPE, ' '), 2, '0')  -- �ҵ��������;
                            || RPAD(SI.BANK_CODE, 3, ' ') -- ������� �ڵ����;
                            || RPAD(YB.YEAR_BANK_NAME, 30, ' ') -- ������� ��ȣ����;
                            || RPAD(SI.ACCOUNT_NUM, 20, ' ') -- ���¹�ȣ;
                            || LPAD(DECODE(SI.SAVING_TYPE, '41', CASE WHEN 3 < SI.SAVING_COUNT THEN 3 ELSE SI.SAVING_COUNT END , '0'), 2, 0) -- ���Կ���-����ֽ������ุ �ش�;
                            || LPAD(SI.SAVING_AMOUNT, 10, 0) -- ���Աݾ�;
                            || LPAD(SI.SAVING_DED_AMOUNT, 10, 0) AS RECORD_LINE               -- �����ݾ�;
                          FROM HRA_SAVING_INFO SI
                            , ( SELECT HC.COMMON_ID AS YEAR_BANK_ID
                                    , HC.CODE AS YEAR_BANK_CODE
                                    , HC.CODE_NAME AS YEAR_BANK_NAME
                                    , HC.SOB_ID
                                    , HC.ORG_ID
                                  FROM HRM_COMMON HC
                                WHERE HC.GROUP_CODE   = 'YEAR_BANK'
                                  AND HC.SOB_ID       = P_SOB_ID
                                  AND HC.ORG_ID       = P_ORG_ID
                               ) YB
                        WHERE SI.BANK_CODE      = YB.YEAR_BANK_CODE
                          AND SI.SOB_ID         = YB.SOB_ID
                          AND SI.ORG_ID         = YB.ORG_ID
                          AND SI.YEAR_YYYY      = P_YEAR_YYYY
                          AND SI.PERSON_ID      = C1.PERSON_ID
                          AND NVL(SI.SAVING_DED_AMOUNT, 0) > 0
                        ORDER BY SI.BANK_CODE ASC
                        )
            LOOP
              V_RECORD_COUNT := NVL(V_RECORD_COUNT, 0) + 1;
              IF V_RECORD_COUNT = 1 THEN
                V_RECORD_FILE := F1.RECORD_HEADER || F1.RECORD_LINE;
              ELSE
                V_RECORD_FILE := V_RECORD_FILE || F1.RECORD_LINE;
              END IF;
              --> ��������� ���� 15�� �̻��� ���.
              IF V_F_REC_STD <= V_RECORD_COUNT THEN
                V_SEQ_NO := NVL(V_SEQ_NO, 0) + 1;  -- �������� ���� �Ϸù�ȣ.
                V_RECORD_FILE := V_RECORD_FILE || RPAD(' ', 70, ' ');  -- ����.
                
                V_SOURCE_FILE := 'F_RECORD';
                INSERT_REPORT_FILE
                  ( P_SEQ_NUM           => V_SEQ_NUM
                  , P_SOURCE_FILE       => V_SOURCE_FILE
                  , P_SOB_ID            => P_SOB_ID
                  , P_ORG_ID            => P_ORG_ID
                  , P_REPORT_FILE       => V_RECORD_FILE
                  , P_SORT_NUM          => 4 + (0.00001 * V_SEQ_NO)
                  );
                --DBMS_OUTPUT.PUT_LINE(V_RECORD_FILE); 
                V_RECORD_FILE  := NULL;
                V_RECORD_COUNT := 0;
              END IF;
            END LOOP F1;
            IF V_RECORD_COUNT <> 0 THEN
              FOR F1S IN V_RECORD_COUNT + 1 .. V_F_REC_STD
              LOOP
                V_RECORD_FILE := V_RECORD_FILE || RPAD(' ', 77, ' ');
              END LOOP F1S;
              IF V_RECORD_FILE IS NOT NULL THEN
                V_SEQ_NO := NVL(V_SEQ_NO, 0) + 1;  -- �ξ簡�� ���� �Ϸù�ȣ.
                V_RECORD_FILE := V_RECORD_FILE || RPAD(' ', 70, ' ');  -- ����.
                
                V_SOURCE_FILE := 'F_RECORD';                
                INSERT_REPORT_FILE
                  ( P_SEQ_NUM           => V_SEQ_NUM
                  , P_SOURCE_FILE       => V_SOURCE_FILE
                  , P_SOB_ID            => P_SOB_ID
                  , P_ORG_ID            => P_ORG_ID
                  , P_REPORT_FILE       => V_RECORD_FILE
                  , P_SORT_NUM          => 4 + (0.00001 * V_SEQ_NO)
                  );
                --DBMS_OUTPUT.PUT_LINE(V_RECORD_FILE); 
              END IF;
            END IF;
--F1 END ---------------------------------------------------------------------------------
          END IF;  -- �ܱ��� ���ϼ��� ���� ���Ұ�츸 ����.
          END LOOP C1;    
        END LOOP B1;
    END LOOP A1;
    
  END SET_YEAR_ADJUST_FILE_2011;

-------------------------------------------------------------------------------
-- 2011�⵵ �Ƿ�� ���ϻ���.
-------------------------------------------------------------------------------
  PROCEDURE SET_MEDICAL_FILE_2011
            ( P_YEAR_YYYY         IN VARCHAR2
            , P_START_DATE        IN HRA_YEAR_ADJUSTMENT.SUBMIT_DATE%TYPE
            , P_END_DATE          IN HRA_YEAR_ADJUSTMENT.SUBMIT_DATE%TYPE
            , P_CORP_ID           IN HRA_YEAR_ADJUSTMENT.CORP_ID%TYPE
            , P_SOB_ID            IN HRA_YEAR_ADJUSTMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRA_YEAR_ADJUSTMENT.ORG_ID%TYPE
            , P_CONNECT_PERSON_ID IN NUMBER
            , P_TAX_PROGRAM_CODE  IN VARCHAR2
            , P_SUBMIT_PERIOD     IN VARCHAR2
            , P_HOMETAX_LOGIN_ID  IN VARCHAR2
            , P_WRITE_DATE        IN DATE
            )
  AS
    V_SEQ_NUM                   NUMBER := 0;
    V_SOURCE_FILE               VARCHAR2(150);
    
    V_TAX_OFFICE_CODE           VARCHAR2(5);
    V_VAT_NUMBER                VARCHAR2(15);
    V_CORP_NAME                 VARCHAR2(50);
  BEGIN
    BEGIN
      SELECT CM.CORP_NAME
          , OU.VAT_NUMBER
          , OU.TAX_OFFICE_CODE
        INTO V_CORP_NAME
          , V_VAT_NUMBER
          , V_TAX_OFFICE_CODE
        FROM HRM_CORP_MASTER CM
          , HRM_OPERATING_UNIT OU
      WHERE CM.CORP_ID            = OU.CORP_ID
        AND CM.CORP_ID            = P_CORP_ID
        AND CM.SOB_ID             = P_SOB_ID
        AND CM.ORG_ID             = P_ORG_ID
        AND CM.ENABLED_FLAG       = 'Y'
        AND (OU.DEFAULT_FLAG      = 'Y'
        OR (OU.DEFAULT_FLAG       = 'N'
        AND ROWNUM                <= 1))
      ;
    EXCEPTION WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20001, 'Error - ����� ������ ã���� �����ϴ�. Ȯ���ϼ���');
      RETURN;
    END;
    FOR A1 IN ( SELECT 'A'   -- �ڷ������ȣ.
                    || '26'  -- 26;
                    || LPAD(REPLACE(V_TAX_OFFICE_CODE, '-', ''), 3, 0)  -- ������ �ڵ�;
                    || LPAD(ROWNUM, 6, 0)  -- �Ϸù�ȣ.
                    || RPAD(TO_CHAR(P_WRITE_DATE, 'YYYYMMDD'), 8, 0) -- �ڷḦ �������� �����ϴ� ������;
                    --> ������;
/*                    || LPAD(NVL(P_SUBMIT_AGENT, '2'), 1, 0)  -- �����ڱ���(�����븮��1, ����2, ����3);
                    || RPAD(NVL(P_TAX_PROGRAM_CODE, ' '), 6, ' ')  -- �����븮�� ������ȣ(�ڷ������ڰ� �����븮���ΰ�� ����);
*/                    || RPAD(NVL(REPLACE(V_VAT_NUMBER, '-', ''), ' '), 10, ' ')  -- ����ڵ�Ϲ�ȣ;
                    || RPAD(NVL(P_HOMETAX_LOGIN_ID, ' '), 20, ' ')  -- Ȩ�ý�ID;
                    || RPAD(NVL(P_TAX_PROGRAM_CODE, '1001'), 4, ' ')  -- �������α׷��ڵ�;                    
                    || RPAD(NVL(REPLACE(V_VAT_NUMBER, '-', ''), ' '), 10, ' ')  -- ����ڵ�Ϲ�ȣ;
                    || RPAD(NVL(V_CORP_NAME, ' '), 40, ' ')  -- ���θ�(��ȣ);
                    || RPAD(NVL(REPLACE(PM.REPRE_NUM, '-', '') ,' '), 13, ' ')  -- �ҵ����ֹι�ȣ.
                    || RPAD(NVL(PM.NATIONALITY_TYPE, ' '), 1, 0)  -- ���ܱ��α���.
                    || RPAD(NVL(PM.NAME, ' '), 30, ' ') --�ҵ����� ����;
                    || LPAD(NVL(REPLACE(MI.CORP_TAX_REG_NO, '-', ''), ' '), 10, ' ') --AS ����ó�� ����ڵ�Ϲ�ȣ;
                    || RPAD(NVL(MI.CORP_NAME, ' '), 40, ' ') -- ����ó ��ȣ;
                    || RPAD(NVL(MI.EVIDENCE_CODE, ' '), 1, ' ')  -- �Ƿ������ڵ�;
                    || LPAD(NVL(MI.CREDIT_COUNT, 0) + NVL(MI.ETC_COUNT, 0), 5, 0) -- �Ǽ�;
                    || LPAD(NVL(MI.CREDIT_AMT, 0) + NVL(MI.ETC_AMT, 0), 11, 0) --  ���ޱݾ�;
                    || LPAD(REPLACE(MI.REPRE_NUM, '-', ''), 13, ' ') -- �Ƿ�� ���� ������� �ֹε�Ϲ�ȣ;
                    || RPAD(CASE
                              WHEN SUBSTR(REPLACE(MI.REPRE_NUM, '-', ''), 7, 1) BETWEEN '5' AND '8' THEN '9'
                              ELSE '1'
                            END, 1, 0) -- �Ƿ�� ���� ������� ��/�ܱ��� �ڵ�;
                    || RPAD(CASE
                              WHEN MI.RELATION_CODE = '0' OR 'Y' IN(MI.DISABILITY_YN, MI.OLD_YN) THEN '1'
                              ELSE '2'
                            END, 1, 0) -- ���ε� �ش翩��;
                    || RPAD(P_SUBMIT_PERIOD, 1, 0) -- (�����ջ� : 1, ��/����� ���� �������� : 2, ���� �������� : 3);
                    || RPAD(' ', 19, ' ') AS RECORD_FILE
                    , ROWNUM AS SORT_NUM
                  FROM HRA_MEDICAL_INFO MI
                    , HRM_PERSON_MASTER PM
                WHERE MI.PERSON_ID        = PM.PERSON_ID
                  AND MI.YEAR_YYYY        = P_YEAR_YYYY
                  AND MI.SOB_ID           = P_SOB_ID
                  AND MI.ORG_ID           = P_ORG_ID    
                  AND PM.CORP_ID          = P_CORP_ID              
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
        , P_SORT_NUM          => A1.SORT_NUM
        );
      --DBMS_OUTPUT.PUT_LINE(A1.RECORD_FILE);
    END LOOP A1; 
  END SET_MEDICAL_FILE_2011;

-------------------------------------------------------------------------------
-- 2011�⵵ ��α� ���ϻ���.
-------------------------------------------------------------------------------
  PROCEDURE SET_DONATION_FILE_2011
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
    V_SEQ_NUM                   NUMBER := 0;
    V_SOURCE_FILE               VARCHAR2(150);
    
    V_TAX_OFFICE_CODE           VARCHAR2(5);
    V_VAT_NUMBER                VARCHAR2(15);
    V_CORP_NAME                 VARCHAR2(50);
  BEGIN
--A1 ------------------------------------------------------------------------------------
    FOR A1 IN ( SELECT 'A'   -- �ڷ������ȣ.
                    || '27'  -- 27;
                    || LPAD(NVL(OU.TAX_OFFICE_CODE, ' '), 3, 0)  -- ������ �ڵ�;
                    || TO_CHAR(P_WRITE_DATE, 'YYYYMMDD')  -- �ڷḦ �������� �����ϴ� ������;
                    --> ������;
                    || LPAD(NVL(P_SUBMIT_AGENT, '2'), 1, 0)  -- �����ڱ���(�����븮��1, ����2, ����3);
                    || RPAD(NVL(P_TAX_AGENT, ' '), 6, ' ')  -- �����븮�� ������ȣ(�ڷ������ڰ� �����븮���ΰ�� ����);
                    || RPAD(NVL(P_HOMETAX_LOGIN_ID, ' '), 20, ' ')  -- Ȩ�ý�ID;
                    || RPAD(NVL(P_TAX_PROGRAM_CODE, '9000'), 4, ' ')  -- �������α׷��ڵ�;
                    || RPAD(NVL(REPLACE(OU.VAT_NUMBER, '-', ''), ' '), 10, ' ')  -- ����ڵ�Ϲ�ȣ;
                    || RPAD(NVL(CM.CORP_NAME, ' '), 40, ' ')  -- ���θ�(��ȣ);
                    || RPAD(NVL(S_PM.DEPT_NAME, ' '), 30, ' ')  -- �����(������) �μ�;
                    || RPAD(NVL(S_PM.NAME, ' '), 30, ' ')  -- �����(������) ����;
                    || RPAD(NVL(REPLACE(CM.TEL_NUMBER, '-', ''), ' '), 15, ' ')  -- �����(������) ��ȭ��ȣ;
                    --> ���⳻��.
                    || LPAD(1, 5, 0)  -- �Ű��ǹ��ڼ� (B���ڵ�);
                    || LPAD(NVL(P_USE_LANGUAGE_CODE, '101'), 3, 0)  -- ����ѱ��ڵ�;
                    || RPAD(' ', 2, ' ') AS RECORD_FILE
                    , NVL(OU.TAX_OFFICE_CODE, ' ') AS TAX_OFFICE_CODE
                    , NVL(REPLACE(OU.VAT_NUMBER, '-', ''), ' ') AS VAT_NUMBER
                    , NVL(CM.CORP_NAME, ' ') AS CORP_NAME
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
      
--B1 ------------------------------------------------------------------------------------
      FOR B1 IN ( -- ��α� ���޸���.
                  SELECT 'B' --AS RECORD_TYPE   -- �ڷ������ȣ(���ڵ� ����);
                      || '27' --AS DATA_TYPE     -- �ڷᱸ��(���� 27);
                      || RPAD(A1.TAX_OFFICE_CODE, 3, 0) -- �������ڵ�;
                      || LPAD(ROWNUM, 6, 0) -- �Ϸù�ȣ;
                      -- ��õ¡���ǹ���;
                      || RPAD(A1.VAT_NUMBER, 10, ' ') -- ����ڵ�Ϲ�ȣ;
                      || RPAD(A1.CORP_NAME, 40, ' ') -- ��ȣ��;
                      -- ���⳻��;
                      || LPAD(NVL(SX1.DONA_ADJUST_COUNT, 0), 7, 0) -- ��α����������ڵ��;
                      || LPAD(NVL(SX1.THIS_YEAR_COUNT, 0), 7, 0) -- �ش�⵵ ��α����������ڵ��;
                      || LPAD(NVL(SX1.TOTAL_DONA_AMT, 0), 13, 0)  -- ��αݾ� �Ѿ�.
                      || LPAD(NVL(SX1.TOTAL_DONA_DED_AMT, 0), 13, 0)  -- �������ݾ��Ѿ�;
                      || LPAD(NVL(P_SUBMIT_PERIOD, '1'), 1, 0) -- (�����ջ� : 1, ��/����� ���� �������� : 2, ���� �������� : 3);
                      || RPAD(' ', 77, ' ') AS RECORD_FILE
                    FROM (SELECT SUM(PX1.DONA_ADJUST_COUNT) AS DONA_ADJUST_COUNT
                               , SUM(PX1.THIS_YEAR_COUNT) AS THIS_YEAR_COUNT
                               , SUM(PX1.TOTAL_DONA_AMT) AS TOTAL_DONA_AMT
                               , SUM(PX1.TOTAL_DONA_DED_AMT) AS TOTAL_DONA_DED_AMT
                            FROM (SELECT COUNT(DA.PERSON_ID) AS DONA_ADJUST_COUNT
                                        , 0 AS THIS_YEAR_COUNT
                                        , SUM(DA.DONA_AMT) AS TOTAL_DONA_AMT
                                        , SUM(DA.TOTAL_DONA_AMT) AS TOTAL_DONA_DED_AMT
                                      FROM HRA_DONATION_ADJUSTMENT DA
                                        , HRM_PERSON_MASTER PM
                                    WHERE DA.PERSON_ID            = PM.PERSON_ID
                                      AND DA.YEAR_YYYY            = P_YEAR_YYYY
                                      AND DA.SOB_ID               = P_SOB_ID
                                      AND DA.ORG_ID               = P_ORG_ID
                                      AND PM.CORP_ID              = P_CORP_ID
                                   UNION ALL
                                   SELECT 0 AS DONA_ADJUST_COUNT
                                        , COUNT(DI.DONATION_INFO_ID) AS THIS_YEAR_COUNT
                                        , 0 AS TOTAL_DONA_AMT
                                        , 0 AS TOTAL_DONA_DED_AMT
                                      FROM HRA_DONATION_INFO DI
                                        , HRM_PERSON_MASTER PM
                                    WHERE DI.PERSON_ID            = PM.PERSON_ID
                                      AND DI.YEAR_YYYY            = P_YEAR_YYYY
                                      AND DI.SOB_ID               = P_SOB_ID
                                      AND DI.ORG_ID               = P_ORG_ID
                                      AND PM.CORP_ID              = P_CORP_ID
                                 ) PX1
                         ) SX1
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
--C2 ------------------------------------------------------------------------------------
        FOR C1 IN ( SELECT PM.PERSON_ID
                         , PM.CORP_ID
                         , P_YEAR_YYYY AS YEAR_YYYY
                         , PM.SOB_ID
                         , PM.ORG_ID
                         , ROW_NUMBER () OVER (ORDER BY PM.PERSON_NUM) AS SEQ_NO
                      FROM HRM_PERSON_MASTER PM
                    WHERE PM.CORP_ID        = P_CORP_ID
                      AND EXISTS
                            ( SELECT 'X'
                                FROM HRA_DONATION_ADJUSTMENT DA
                              WHERE DA.PERSON_ID      = PM.PERSON_ID
                                AND DA.YEAR_YYYY      = P_YEAR_YYYY
                                AND DA.SOB_ID         = P_SOB_ID
                                AND DA.ORG_ID         = P_ORG_ID
                            )
                    ORDER BY PM.PERSON_NUM
                  )
        LOOP
          FOR C2 IN ( -- ��α� ��������.
                      SELECT 'C' -- �ڷ������ȣ(���ڵ� ����);
                          || '27' -- �ڷᱸ��(���� 27);
                          || LPAD(A1.TAX_OFFICE_CODE, 3, 0) -- �������ڵ�;
                          || LPAD(C1.SEQ_NO, 6, 0)   -- �Ϸù�ȣ.
                              -- �Ϸù�ȣ;
  /*                              || LPAD(ROWNUM, 6, 0) --AS SEQ_NO    -- �Ϸù�ȣ;*/
                          || RPAD(A1.VAT_NUMBER, 10, ' ') -- ����ڵ�Ϲ�ȣ;
                          || RPAD(REPLACE(PM.REPRE_NUM, '-', ''), 13, ' ') -- �ҵ����� �ֹε�Ϲ�ȣ;
                          || RPAD(CASE
                                    WHEN SUBSTR(REPLACE(PM.REPRE_NUM, '-', ''), 7, 1) BETWEEN '5' AND '8' THEN '9'
                                    ELSE '1'
                                  END, 1, 0) -- ���ܱ��� �����ڵ�;
                          || RPAD(PM.NAME, 30, ' ') -- �ҵ����� ����;
                          || RPAD(NVL(DA.DONA_TYPE, ' '), 2, ' ') -- ����ڵ�;
                          || LPAD(DA.DONA_YYYY, 4, 0)           -- ��γ⵵;
                          || LPAD(NVL(DA.DONA_AMT, 0), 13, 0) -- ��αݾ�(�����,���ó��,������ �ջ�);
                          || LPAD(NVL(DA.PRE_DONA_DED_AMT, 0), 13, 0) -- ������� ������ �ݾ�;
                          || LPAD(NVL(DA.TOTAL_DONA_AMT, 0), 13, 0) -- �������ݾ�;
                          || LPAD(NVL(DA.DONA_DED_AMT, 0), 13, 0)    -- �ش�⵵ �����ݾ�;
                          || LPAD(NVL(DA.LAPSE_DONA_AMT, 0), 13, 0)    -- �ش�⵵ �Ҹ�ݾ�;
                          || LPAD(NVL(DA.NEXT_DONA_AMT, 0), 13, 0)    -- �ش�⵵ �̿��ݾ�;
                          || LPAD(ROW_NUMBER() OVER(PARTITION BY PM.PERSON_NUM ORDER BY PM.PERSON_NUM, SX1.YEAR_YYYY), 5, 0)         -- ��α������� �Ϸù�ȣ;
                          || RPAD(' ', 25, ' ') AS RECORD_FILE
                          , DA.YEAR_YYYY AS YEAR_YYYY
                          , PM.PERSON_ID
                          , DA.DONA_TYPE
                          , ROW_NUMBER() OVER(PARTITION BY PM.PERSON_NUM ORDER BY PM.PERSON_NUM) AS SORT_NUM
                        FROM HRM_PERSON_MASTER PM
                          , HRA_DONATION_ADJUSTMENT DA
                          , ( SELECT HDA.YEAR_YYYY
                                  , HDA.PERSON_ID
                                  , ROW_NUMBER() OVER( ORDER BY HDA.PERSON_ID, HDA.YEAR_YYYY) AS SEQ_NO
                                FROM HRA_DONATION_ADJUSTMENT HDA 
                              WHERE HDA.YEAR_YYYY       = C1.YEAR_YYYY
                                AND HDA.SOB_ID          = C1.SOB_ID
                                AND HDA.ORG_ID          = C1.ORG_ID
                              GROUP BY HDA.YEAR_YYYY
                                  , HDA.PERSON_ID
                                  , HDA.DONA_YYYY
                            ) SX1
                      WHERE PM.PERSON_ID      = DA.PERSON_ID
                        AND DA.YEAR_YYYY      = SX1.YEAR_YYYY
                        AND DA.PERSON_ID      = SX1.PERSON_ID
                        AND PM.CORP_ID        = C1.CORP_ID
                        AND DA.YEAR_YYYY      = C1.YEAR_YYYY
                        AND DA.SOB_ID         = C1.SOB_ID
                        AND DA.ORG_ID         = C1.ORG_ID
                        AND DA.PERSON_ID      = C1.PERSON_ID
                      ORDER BY PM.PERSON_NUM, SX1.YEAR_YYYY
                    ) 
          LOOP
            V_SEQ_NUM := NVL(V_SEQ_NUM, 0) + 1;
            V_SOURCE_FILE := 'C_RECORD';
            INSERT_REPORT_FILE
              ( P_SEQ_NUM           => V_SEQ_NUM
              , P_SOURCE_FILE       => V_SOURCE_FILE
              , P_SOB_ID            => P_SOB_ID
              , P_ORG_ID            => P_ORG_ID
              , P_REPORT_FILE       => C2.RECORD_FILE
              , P_SORT_NUM          => C2.SORT_NUM
              );
          END LOOP C2;
  --D1 ------------------------------------------------------------------------------------
          FOR D1 IN ( -- ��α� ����.
                      SELECT 'D' -- �ڷ������ȣ(���ڵ� ����);
                          || '27' -- �ڷᱸ��(���� 27);
                          || LPAD(A1.TAX_OFFICE_CODE, 3, 0) -- �������ڵ�;
                          || LPAD(C1.SEQ_NO, 6, 0)    -- �Ϸù�ȣ;
                          || RPAD(A1.VAT_NUMBER, 10, ' ') -- ����ڵ�Ϲ�ȣ;
                          || RPAD(REPLACE(PM.REPRE_NUM, '-', ''), 13, ' ') -- �ҵ����� �ֹε�Ϲ�ȣ;
                          || RPAD(NVL(DI.DONA_TYPE, ' '), 2, ' ') -- ����ڵ�;
                          || RPAD(NVL(REPLACE(DI.CORP_TAX_REG_NO, '-', ''), ' '), 13, ' ') -- ���ó �����Ϲ�ȣ;
                          || RPAD(NVL(DI.CORP_NAME, ' '), 30, ' ') -- ���ó ��ȣ;
                          || RPAD(NVL(CASE 
                                        WHEN DI.RELATION_CODE = '0' THEN '1'
                                        WHEN DI.RELATION_CODE = '3' THEN '2'
                                        WHEN DI.RELATION_CODE IN('4', '5') THEN '3'
                                        WHEN DI.RELATION_CODE IN('1', '2') THEN '4'
                                        WHEN DI.RELATION_CODE IN('6') THEN '5'
                                        ELSE '6'
                                      END, ' '), 1, ' ') -- ����ڿ��� ����;
                          || RPAD(CASE
                                    WHEN SUBSTR(REPLACE(DI.REPRE_NUM, '-', ''), 7, 1) BETWEEN '5' AND '8' THEN '9'
                                    ELSE '1'
                                  END, 1, ' ') --  ��/�ܱ��� �ڵ�;
                          || RPAD(NVL(DI.FAMILY_NAME, ' '), 20, ' ') -- ����;
                          || RPAD(NVL(REPLACE(DI.REPRE_NUM, '-', ''), ' '), 13, ' ') -- ����� �ֹε�Ϲ�ȣ;
                          || LPAD(NVL(DI.DONA_COUNT, 0), 5, 0) --���Ƚ��(�����,���ó��,������ �ջ�);
                          || LPAD(NVL(DI.DONA_AMT, 0), 13, 0) -- ��α�(�����,���ó��,������ �ջ�);/*|| LPAD(I_YEAR_YYYY || '0101', 8, 0) --AS TAX_PERIOD_START
                          || LPAD(ROW_NUMBER() OVER(PARTITION BY PM.PERSON_NUM ORDER BY PM.PERSON_NUM), 5, 0)
                          --|| LPAD(C1.SORT_NUM, 5, 0)         -- ��α������� �Ϸù�ȣ;
                          || RPAD(' ', 42, ' ') AS RECORD_FILE
                          , ROW_NUMBER() OVER(PARTITION BY PM.PERSON_NUM ORDER BY PM.PERSON_NUM) AS SORT_NUM
                        FROM HRM_PERSON_MASTER PM
                          , HRA_DONATION_INFO DI
                      WHERE PM.PERSON_ID    = DI.PERSON_ID
                        AND DI.YEAR_YYYY    = C1.YEAR_YYYY
                        AND DI.SOB_ID       = C1.SOB_ID
                        AND DI.ORG_ID       = C1.ORG_ID
                        AND DI.PERSON_ID    = C1.PERSON_ID
--                        AND DI.DONA_TYPE    = C1.DONA_TYPE
                      ORDER BY PM.PERSON_NUM
                     ) 
          LOOP
            V_SOURCE_FILE := 'D_RECORD';
            INSERT_REPORT_FILE
              ( P_SEQ_NUM           => V_SEQ_NUM
              , P_SOURCE_FILE       => V_SOURCE_FILE
              , P_SOB_ID            => P_SOB_ID
              , P_ORG_ID            => P_ORG_ID
              , P_REPORT_FILE       => D1.RECORD_FILE
              , P_SORT_NUM          => C1.SEQ_NO + (0.00001 * D1.SORT_NUM)
              );
          END LOOP D1;
        END LOOP C1;
      END LOOP B1;
    END LOOP A1; 
  END SET_DONATION_FILE_2011;
  

-------------------------------------------------------------------------------
-- 2012�⵵ �ٷμҵ� ���ϻ��� �� ��ȸ.
-------------------------------------------------------------------------------
  PROCEDURE SET_YEAR_ADJUST_FILE_2012
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
                    || '20'  -- �����ٷμҵ�(20);
                    || LPAD(REPLACE(OU.TAX_OFFICE_CODE, '-', ''), 3, 0)  -- ������ �ڵ�;
                    || TO_CHAR(P_WRITE_DATE, 'YYYYMMDD')  -- �ڷḦ �������� �����ϴ� ������;
                    --> ������;
                    || LPAD(NVL(P_SUBMIT_AGENT, '2'), 1, 0)  -- �����ڱ���(�����븮��1, ����2, ����3);
                    || RPAD(NVL(P_TAX_AGENT, ' '), 6, ' ')  -- �����븮�� ������ȣ(�ڷ������ڰ� �����븮���ΰ�� ����);
                    || RPAD(NVL(P_HOMETAX_LOGIN_ID, ' '), 20, ' ')  -- Ȩ�ý�ID;
                    || RPAD(NVL(P_TAX_PROGRAM_CODE, '1001'), 4, ' ')  -- �������α׷��ڵ�;
                    || RPAD(NVL(REPLACE(OU.VAT_NUMBER, '-', ''), ' '), 10, ' ')  -- ����ڵ�Ϲ�ȣ;
                    || RPAD(NVL(REPLACE(CM.CORP_NAME, ' ', ''), ' '), 40, ' ')  -- ���θ�(��ȣ);
                    || RPAD(NVL(REPLACE(S_PM.DEPT_NAME, ' ', ''), ' '), 30, ' ')  -- �����(������) �μ�;
                    || RPAD(NVL(REPLACE(S_PM.NAME, ' ', ''), ' '), 30, ' ')  -- �����(������) ����;
                    || RPAD(NVL(REPLACE(CM.TEL_NUMBER, '-', ''), ' '), 15, ' ')  -- �����(������) ��ȭ��ȣ;
                    --> ���⳻��.
                    || LPAD(1, 5, 0)  -- �Ű��ǹ��ڼ� (B���ڵ�);
                    || LPAD(NVL(P_USE_LANGUAGE_CODE, '101'), 3, 0)  -- ����ѱ��ڵ�;
                    || RPAD(' ', 1152, ' ') AS RECORD_FILE
                    , CM.CORP_NAME  -- ���θ�.
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
                      || '20'  -- �����ٷμҵ�(20);
                      || LPAD(REPLACE(OU.TAX_OFFICE_CODE, '-', ''), 3, 0)   -- �������ڵ�; 
                      || LPAD(1, 6, 0)                                      -- B���ڵ��� �Ϸù�ȣ;
                      --> ������;
                      || RPAD(NVL(REPLACE(OU.VAT_NUMBER, '-', ''), ' '), 10, ' ')  -- ��õ¡���ǹ����� ����ڵ�Ϲ�ȣ;
                      || RPAD(NVL(REPLACE(CM.CORP_NAME, ' ', ''), ' '), 40, ' ')  -- ���θ�(��ȣ);
                      || RPAD(NVL(REPLACE(CM.PRESIDENT_NAME, ' ', ''), ' '), 30, ' ')  -- ��ǥ�� ����;
                      || RPAD(NVL(REPLACE(CM.LEGAL_NUMBER, '-', ''), ' '), 13, ' ') -- ���ε�Ϲ�ȣ;
                      --> ���⳻��;
                      || LPAD(NVL(S_YA.NOW_WORKER_COUNT, 0), 7, 0)   -- ������ C���ڵ��� ��(�ٷμҵ����� ��);
                      || LPAD(NVL(S_YA.PRE_WORKER_COUNT, 0), 7, 0)   -- ������ D���ڵ�(���ٹ�ó)�� ��(C���ڵ� �׸�6�� �հ�)
                      || LPAD(NVL(S_YA.INCOME_TOT_AMT, 0), 14, 0)    -- �ѱ޿� �Ѱ�(C���ڵ� �޿� ��);
                      || LPAD(NVL(S_YA.FIX_IN_TAX, 0), 13, 0)        -- �ҵ漼 �������� �Ѱ�(C���ڵ� �ҵ漼�� ��);
                      || LPAD(0, 13, 0)  -- LPAD(NVL(S_YA.FIX_LEGAL_TAX, 0), 13, 0) : 2009�� �������� ���� -- ���μ� ���������Ѱ�->�������� ����;            
                      || LPAD(NVL(S_YA.FIX_LOCAL_TAX, 0), 13, 0)     -- �ֹμ� �������� �Ѱ�;
                      || LPAD(NVL(S_YA.FIX_SP_TAX, 0), 13, 0)        -- ��Ư�� �������� �Ѱ�;
                      || LPAD(NVL(S_YA.FIX_TOTAL_TAX, 0) - NVL(S_YA.FIX_LEGAL_TAX, 0), 13, 0)  -- �������� �Ѱ�;
                      -- LPAD(NVL(S_YA.FIX_TOTAL_TAX, 0), 13, 0)  -- �������� �Ѱ� : 2009�� �������� ���� ���������Ѱ�-���μ� �������� �Ѱ�;
                      || LPAD(NVL(P_SUBMIT_PERIOD, '1'), 1, 0)   -- (�����ջ� : 1, ��/����� ���� �������� : 2, ���� �������� : 3);
                      || RPAD(' ', 1131, ' ') AS RECORD_FILE
                      , LPAD(REPLACE(OU.TAX_OFFICE_CODE, '-', ''), 3, 0) AS TAX_OFFICE_CODE
                      , RPAD(NVL(REPLACE(OU.VAT_NUMBER, '-', ''), ' '), 10, ' ') AS VAT_NUMBER
                    FROM HRM_CORP_MASTER CM
                       , HRM_OPERATING_UNIT OU
                       , ( -- ���⳻��.
                           SELECT YA.YEAR_YYYY
                               , COUNT(YA.PERSON_ID) AS NOW_WORKER_COUNT
                               , NVL(S_PW.PRE_WORK_COUNT, 0) AS PRE_WORKER_COUNT
                               , SUM(YA.INCOME_TOT_AMT) AS INCOME_TOT_AMT
                               , SUM(YA.FIX_IN_TAX_AMT) FIX_IN_TAX
                               , 0 AS FIX_LEGAL_TAX
                               , SUM(YA.FIX_LOCAL_TAX_AMT) FIX_LOCAL_TAX
                               , SUM(YA.FIX_SP_TAX_AMT) FIX_SP_TAX
                               , SUM(NVL(YA.FIX_IN_TAX_AMT, 0) +
                                     NVL(YA.FIX_LOCAL_TAX_AMT, 0) +
                                     NVL(YA.FIX_SP_TAX_AMT, 0)) FIX_TOTAL_TAX
                             FROM HRA_YEAR_ADJUSTMENT YA
                               , HRM_PERSON_MASTER    PM
                               , ( -- �����ٹ��� �ڷ��.
                                  SELECT PW.YEAR_YYYY
                                      , COUNT(PW.PERSON_ID) AS PRE_WORK_COUNT
                                    FROM HRA_YEAR_ADJUSTMENT YA
                                      , HRA_PREVIOUS_WORK PW
                                      , HRM_PERSON_MASTER PM
                                   WHERE YA.YEAR_YYYY     = PW.YEAR_YYYY
                                     AND YA.PERSON_ID     = PW.PERSON_ID
                                     AND PW.PERSON_ID     = PM.PERSON_ID
                                     AND PW.YEAR_YYYY     = P_YEAR_YYYY
                                     AND PM.CORP_ID       = P_CORP_ID
                                     AND PW.SOB_ID        = P_SOB_ID
                                     AND PW.ORG_ID        = P_ORG_ID
                                     AND YA.ADJUST_DATE_TO BETWEEN P_START_DATE AND P_END_DATE
                                   GROUP BY PW.YEAR_YYYY
                                  ) S_PW
                            WHERE YA.PERSON_ID      = PM.PERSON_ID
                              AND YA.YEAR_YYYY      = S_PW.YEAR_YYYY(+)
                              AND YA.CORP_ID        = P_CORP_ID
                              AND YA.YEAR_YYYY      = P_YEAR_YYYY
                              AND YA.SOB_ID         = P_SOB_ID
                              AND YA.ORG_ID         = P_ORG_ID
                              AND YA.SUBMIT_DATE    BETWEEN P_START_DATE AND P_END_DATE
                              AND YA.INCOME_TOT_AMT <> 0
                              AND YA.ADJUST_DATE_TO BETWEEN P_START_DATE AND P_END_DATE
                            GROUP BY YA.YEAR_YYYY
                                  , NVL(S_PW.PRE_WORK_COUNT, 0)
                         ) S_YA
                    WHERE CM.CORP_ID        = OU.CORP_ID
                      AND P_YEAR_YYYY       = S_YA.YEAR_YYYY
                      AND CM.ENABLED_FLAG   = 'Y'
                      AND (OU.DEFAULT_FLAG  = 'Y'
                      OR (OU.DEFAULT_FLAG   = 'N'
                      AND ROWNUM            <= 1))
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
                        || '20'                                         -- 2.AS DATA_TYPE
                        || RPAD(NVL(B1.TAX_OFFICE_CODE, ' '), 3, ' ')   -- 3.�������ڵ�.
                        || LPAD(ROW_NUMBER() OVER(PARTITION BY YA.YEAR_YYYY ORDER BY PM.PERSON_NUM), 6, 0)   -- 4.�Ϸù�ȣ.
                        || LPAD(NVL(B1.VAT_NUMBER, ' '), 10, ' ')       -- 5.����ڹ�ȣ.
                        || LPAD(NVL(S_PW.PRE_WORK_COUNT, 0), 2, 0)      -- 6.��(��)�ٹ�ó ��;
                        || LPAD(NVL(PM.RESIDENT_TYPE, '1'), 1, 0)       -- 7.������ �����ڵ�(������:1, �������:2);
                        || RPAD(CASE 
                                  WHEN PM.RESIDENT_TYPE = '1' THEN ' '
                                  WHEN SUBSTR(REPLACE(PM.REPRE_NUM, '-', ''), 7, 1) BETWEEN '1' AND '4' THEN ' '  -- 1900, 2000���.
                                  WHEN SUBSTR(REPLACE(PM.REPRE_NUM, '-', ''), 7, 1) BETWEEN '9' AND '0' THEN ' '  -- 1800����..
                                  ELSE NVL(S_HN.ISO_NATION_CODE, ' ')
                                END, 2, ' ')  -- 8.�ű����� �ڵ� : ������ڸ� ���, �����ڴ� ����;
                        || LPAD(DECODE(PM.FOREIGN_TAX_YN, 'Y', 1, 2), 1, 0)  -- 9.�ܱ��δ��ϼ�������(����:1, ������:2);
                        || RPAD(NVL(REPLACE(PM.NAME, ' ', ''), ' '), 30, ' ')  -- 10.����;
                        || RPAD(CASE
                                  WHEN PM.NATIONALITY_TYPE IS NOT NULL THEN PM.NATIONALITY_TYPE
                                  WHEN SUBSTR(REPLACE(PM.REPRE_NUM, '-', ''), 7, 1) BETWEEN '5' AND '8' THEN '9'
                                  ELSE '1'
                                END, 1, 0)  -- 11.��/�ܱ��� �����ڵ�;
                        || RPAD(NVL(REPLACE(PM.REPRE_NUM, '-', ''), ' '), 13, ' ')  -- 12.�ֹε�Ϲ�ȣ;
                        || RPAD(CASE
                                  WHEN PM.NATIONALITY_TYPE = '9' THEN NVL(S_HN.ISO_NATION_CODE, ' ')
                                  WHEN SUBSTR(REPLACE(PM.REPRE_NUM, '-', ''), 7, 1) BETWEEN '5' AND '8' THEN NVL(S_HN.ISO_NATION_CODE, ' ')
                                  ELSE ' '
                                END, 2, ' ')  -- 13.�����ڵ�(�ܱ����� ��츸 ����);
                        || RPAD(NVL(PM.HOUSEHOLD_TYPE, '1'), 1, 0)  -- 14.�����ֿ���.
                        || RPAD(CASE 
                                  WHEN (PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE > TO_DATE(P_YEAR_YYYY||'-12-31','YYYY-MM-DD')) THEN '1'
                                  ELSE '2' 
                                END, 1, 0)  -- 15.�������걸��(��ӱٷ�: 1, �ߵ����:2).
                        || RPAD(NVL(B1.VAT_NUMBER, ' '), 10, ' ')  -- �����ٹ�ó ����ڵ�Ϲ�ȣ;
                        || RPAD(NVL(A1.CORP_NAME, ' '), 40, ' ')  -- �����ٹ�ó ���θ�(��ȣ);
                        || RPAD(TO_CHAR(YA.ADJUST_DATE_FR, 'YYYYMMDD'), 8, 0)  -- �ٹ��Ⱓ ���ۿ�����;
                        || RPAD(TO_CHAR(YA.ADJUST_DATE_TO, 'YYYYMMDD'), 8, 0)  -- �ٹ��Ⱓ ���Ῥ����;
                        || LPAD(0, 8, 0)  -- ����Ⱓ ���ۿ�����;
                        || LPAD(0, 8, 0)  -- ����Ⱓ ���Ῥ����;
                        --> �ٹ�ó�� �ҵ��-��(��)�ٹ�ó �ѱ޿�.
                        || LPAD(NVL(YA.NOW_PAY_TOT_AMT, 0)+ 
                                NVL(YA.INCOME_OUTSIDE_AMT, 0), 11, 0)  -- �޿��Ѿ�;
                        || LPAD(NVL(YA.NOW_BONUS_TOT_AMT, 0), 11, 0) -- ���Ѿ�;
                        || LPAD(NVL(YA.NOW_ADD_BONUS_AMT, 0), 11, 0) -- ������;
                        || LPAD(NVL(YA.NOW_STOCK_BENE_AMT, 0), 11, 0) -- �ֽĸż����ñ��������;
                        ----> 2009�� �������� ����(�츮������������� �߰�);
                        || LPAD(0, 11, 0) -- �츮�������������(�迡�� �������� �ʾ���);
                        || LPAD(0, 22, 0) -- ����;
                        || LPAD(NVL(YA.NOW_PAY_TOT_AMT, 0) +
                                NVL(YA.NOW_BONUS_TOT_AMT, 0) +
                                NVL(YA.NOW_ADD_BONUS_AMT, 0) +
                                NVL(YA.NOW_STOCK_BENE_AMT, 0) + 
                                NVL(YA.INCOME_OUTSIDE_AMT, 0), 11, 0) -- ��;
                        --> ��(��)�ٹ�ó ����� �ҵ�.
                        -- 2009�� �������� ����(��(��)�ٹ�ó ����� �ҵ� ����);
                        || LPAD(NVL(YA.NONTAX_SCH_EDU_AMT, 0), 10, 0) -- �����-���ڱ�;
                        || LPAD(NVL(YA.NONTAX_MEMBER_AMT, 0), 10, 0) -- �����-��������������;
                        || LPAD(NVL(YA.NONTAX_GUARD_AMT, 0), 10, 0) -- �����-��ȣ/�¼�����;
                        || LPAD(NVL(YA.NONTAX_CHILD_AMT, 0), 10, 0) -- �����-����/���ߵ�_��������/Ȱ����;
                        || LPAD(NVL(YA.NONTAX_HIGH_SCH_AMT, 0), 10, 0) -- �����-����_��������/Ȱ����;
                        || LPAD(NVL(YA.NONTAX_SPECIAL_AMT, 0), 10, 0) -- �����-Ư���������������_��������/Ȱ����;
                        || LPAD(NVL(YA.NONTAX_RESEARCH_AMT, 0), 10, 0) -- �����-�������_��������/Ȱ����;
                        || LPAD(NVL(YA.NONTAX_COMPANY_AMT, 0), 10, 0) -- �����-���������_��������/Ȱ����;
                        -- ��ȣ�� : 2012�⵵ �߰� BEGIN --
                        || LPAD(0, 10, 0)  -- ����� : �������� �ٹ�ȯ�氳����.
                        || LPAD(0, 10, 0)  -- ����� : �縳��ġ�� ��������/������ �ΰǺ�.
                        -- END --
                        || LPAD(NVL(YA.NONTAX_COVER_AMT, 0), 10, 0) -- �����-�������;
                        || LPAD(NVL(YA.NONTAX_WILD_AMT, 0), 10, 0) -- �����-��������;
                        || LPAD(NVL(YA.NONTAX_DISASTER_AMT, 0), 10, 0) -- �����-���ذ��ñ޿�;
                        || LPAD(NVL(YA.NONTAX_OUTS_GOVER_AMT, 0), 10, 0) -- �����-�ܱ����ε�ٹ���;
                        || LPAD(NVL(YA.NONTAX_OUTS_ARMY_AMT, 0), 10, 0) -- �����-�ܱ��ֵб��ε�;
                        || LPAD(NVL(YA.NONTAX_OUTS_WORK_1, 0), 10, 0) -- �����-���ܱٷ�(100����);
                        || LPAD(NVL(YA.NONTAX_OUTS_WORK_2, 0), 10, 0) -- ���ܱٷ�200����(300����);
                        || LPAD(NVL(YA.NONTAX_OUTSIDE_AMT, 0), 10, 0) -- ����� ���ܼҵ�;
                        || LPAD(NVL(YA.NONTAX_OT_AMT, 0), 10, 0) -- ����� �߰��ٷ�;
                        || LPAD(NVL(YA.NONTAX_BIRTH_AMT, 0), 10, 0) -- ����� ���/��������;
                        || LPAD(0, 10, 0)  -- �ٷ����б�.
                        || LPAD(NVL(YA.NONTAX_STOCK_BENE_AMT, 0), 10, 0) -- �����-�ֽĸż����ñ�;
                        || LPAD(NVL(YA.NONTAX_FOR_ENG_AMT, 0), 10, 0) -- �����-�ܱ��α����;
                        --|| LPAD(NVL(YA.NONTAX_FOREIGNER_AMT, 0), 10, 0) -- ����� �ܱ��� �ٷ���(X);
                        --|| LPAD(NVL(YA.NONTAX_EMPL_STOCK_AMT, 0), 10, 0) --  �����-�츮�������չ���(X);
                        || LPAD(NVL(YA.NONTAX_EMPL_BENE_AMT_1, 0), 10, 0) -- �����-�츮�������������(50%);
                        || LPAD(NVL(YA.NONTAX_EMPL_BENE_AMT_2, 0), 10, 0) -- �����-�츮�������������(75%);
                        || LPAD(0, 10, 0) -- �����-��������� �߼ұ�� ���;
                        --|| LPAD(NVL(YA.NONTAX_HOUSE_SUBSIDY_AMT, 0), 10, 0) -- �����-�����ڱݺ�����(X);
                        || LPAD(NVL(YA.NONTAX_SEA_RESOURCE_AMT, 0), 10, 0) -- �����-���������ڿ�����;
                        -- ��ȣ�� �߰� : 2012�⵵ ���� BEGIN --
                        || LPAD(0, 10, 0)  -- �����Ǽ��ú�������.
                        || LPAD(0, 10, 0)  -- �߼ұ�� ��� û�� �ҵ漼 ����;
                        || LPAD(0, 10, 0)  -- ��������� ������ ����;
                        --|| LPAD(0, 10, 0) -- ���������;
                        -- ��ȣ�� �߰� : 2012�⵵ ���� END --
                        -- ����� ��;
                        || LPAD((NVL(YA.NONTAX_SCH_EDU_AMT, 0) +
                                NVL(YA.NONTAX_MEMBER_AMT, 0) +
                                NVL(YA.NONTAX_GUARD_AMT, 0) +
                                NVL(YA.NONTAX_CHILD_AMT, 0) +
                                NVL(YA.NONTAX_HIGH_SCH_AMT, 0) +
                                NVL(YA.NONTAX_SPECIAL_AMT, 0) +
                                NVL(YA.NONTAX_RESEARCH_AMT, 0) +
                                NVL(YA.NONTAX_COMPANY_AMT, 0) +
                                NVL(YA.NONTAX_COVER_AMT, 0) +
                                NVL(YA.NONTAX_WILD_AMT, 0) +
                                NVL(YA.NONTAX_DISASTER_AMT, 0) +
                                NVL(YA.NONTAX_OUTS_GOVER_AMT, 0) +
                                NVL(YA.NONTAX_OUTS_ARMY_AMT, 0) +
                                NVL(YA.NONTAX_OUTS_WORK_1, 0) +
                                NVL(YA.NONTAX_OUTS_WORK_2, 0) +
                                NVL(YA.NONTAX_OUTSIDE_AMT, 0) +
                                NVL(YA.NONTAX_OT_AMT, 0) +
                                NVL(YA.NONTAX_BIRTH_AMT, 0) +
                                --NVL(YA.NONTAX_FOREIGNER_AMT, 0) +
                                --NVL(YA.NONTAX_EMPL_STOCK_AMT, 0) +
                                NVL(YA.NONTAX_EMPL_STOCK_AMT, 0) +
                                --NVL(YA.NONTAX_FOR_ENG_AMT, 0) +  -- �ܱ��� �����(����ҵ� ��� �̵�);
                                NVL(YA.NONTAX_EMPL_BENE_AMT_1, 0) +
                                NVL(YA.NONTAX_EMPL_BENE_AMT_2, 0) +
                                --NVL(YA.NONTAX_HOUSE_SUBSIDY_AMT, 0) +                       
                                NVL(YA.NONTAX_SEA_RESOURCE_AMT, 0))  -- ���������ڿ�����(����ҵ� ��� �̵�);
                                --NVL(YA.NONTAX_ETC_AMT, 0),
                                , 10, 0)  -- �������.
                        || LPAD(NVL(YA.NONTAX_FOR_ENG_AMT, 0) + NVL(YA.NONTAX_SEA_RESOURCE_AMT, 0), 10, 0)    -- ����ҵ��(�׸�48 + �׸�52);
                        --> �����.
                        || LPAD(NVL(YA.INCOME_TOT_AMT, 0), 11, 0) -- �ѱ޿�;
                        || LPAD(NVL(YA.INCOME_DED_AMT, 0), 10, 0) -- �ٷμҵ����;
                        || LPAD(NVL(YA.INCOME_TOT_AMT, 0) - NVL(YA.INCOME_DED_AMT, 0), 11, 0) -- �ٷμҵ�ݾ�;
                        --> �⺻����.
                        || LPAD(NVL(YA.PER_DED_AMT, 0), 8, 0) -- ���ΰ����ݾ�;
                        || LPAD(NVL(YA.SPOUSE_DED_AMT, 0), 8, 0) -- ����ڰ����ݾ�;
                        || LPAD(NVL(YA.SUPP_DED_COUNT, 0), 2, 0) -- �ξ簡�������ο�;
                        || LPAD(NVL(YA.SUPP_DED_AMT, 0), 8, 0) -- �ξ簡�������ݾ�;
                        --> �߰�����.
                        -- 2009�� BEGIN : ��ο������ο� 70���̻� ����;
                        || LPAD(NVL(YA.OLD_DED_COUNT1, 0), 2, 0) -- ��ο������ο�;
                        || LPAD(NVL(YA.OLD_DED_AMT1, 0), 8, 0) -- ��ο������ݾ�;
                        /*
                        || LPAD(NVL(YA.OLD_DED_COUNT, 0) + NVL(YA.OLD_DED_COUNT1, 0), 2, 0) -- ��ο������ο�;
                        || LPAD(NVL(YA.OLD_DED_AMT, 0) + NVL(YA.OLD_DED_AMT1, 0), 8, 0) -- ��ο������ݾ�;*/
                        -- 2009�� END;
                        || LPAD(NVL(YA.DISABILITY_DED_COUNT, 0), 2, 0) -- ����ΰ����ο�;
                        || LPAD(NVL(YA.DISABILITY_DED_AMT, 0), 8, 0) -- ����ΰ����ݾ�;
                        || LPAD(NVL(YA.WOMAN_DED_AMT, 0), 8, 0) -- �γ��ڰ����ݾ�;
                        || LPAD(NVL(YA.CHILD_DED_COUNT, 0), 2, 0) -- �ڳ����������ο�;
                        || LPAD(NVL(YA.CHILD_DED_AMT, 0), 8, 0) -- �ڳ����������ݾ�;
                        || LPAD(NVL(YA.BIRTH_DED_COUNT, 0), 2, 0) -- ���/�Ծ��ڰ����ο�;
                        || LPAD(NVL(YA.BIRTH_DED_AMT, 0), 8, 0) --  ���/�Ծ��ڰ����ݾ�;
                        || LPAD(0, 10, 0) -- ����;
                        -- LPAD(NVL(YA.PER_ADD_DED_AMT, 0), 8, 0)   PER_ADD_DED_AMT;
                        --> ���ڳ��߰�����;
                        || LPAD(NVL(YA.MANY_CHILD_DED_COUNT, 0), 2, 0) -- ���ڳ��߰������ο�;
                        || LPAD(NVL(YA.MANY_CHILD_DED_AMT, 0), 8, 0) -- ���ڳ��߰������ݾ�;
                        -->���ݺ����;
                        || LPAD(NVL(YA.NATI_ANNU_AMT, 0), 10, 0) -- ���ο��ݺ�������;
                        || LPAD(NVL(YA.ANNU_INSUR_AMT, 0), 10, 0)  -- ��Ÿ���ݺ�������_����������;
                        || LPAD(0, 10, 0)  -- ��Ÿ���ݺ�������_���ο���;
                        || LPAD(0, 10, 0)  -- ��Ÿ���ݺ�������_�縳�б�����������;
                        || LPAD(0, 10, 0)  -- ��Ÿ���ݺ�������_������ü������;
                        || LPAD(0, 10, 0)  -- ��Ÿ���ݺ�������_���б���ΰ���;
                        || LPAD(NVL(YA.RETR_ANNU_AMT, 0), 10, 0)  -- ��Ÿ���ݺ�������_�ٷ��������޿������;
                        --> Ư������.
                        -- ����������;
                        -- 2009�� �������� BEGIN. ���������� 0�� �̸��� ��쿡�� 0�� ó��;
                        || LPAD(CASE 
                                  WHEN NVL(YA.MEDIC_INSUR_AMT, 0) < 0 THEN 0
                                  ELSE NVL(YA.MEDIC_INSUR_AMT, 0) 
                                END, 10, 0)  -- �ǰ������;
                        || LPAD(CASE 
                                  WHEN NVL(YA.HIRE_INSUR_AMT, 0) < 0 THEN 0
                                  ELSE NVL(YA.HIRE_INSUR_AMT, 0) 
                                END, 10, 0)  -- ��뺸���;
                        || LPAD(NVL(YA.GUAR_INSUR_AMT, 0), 10, 0)                           -- ���庸��� ;
                        || LPAD(NVL(YA.DISABILITY_INSUR_AMT, 0), 10, 0)                     -- ��ֺ���� ;
                        || LPAD(NVL(YA.MEDIC_AMT, 0), 10, 0)  -- �Ƿ������ݾ�;
                        || LPAD(NVL(YA.EDUCATION_AMT, 0), 8, 0) -- ����������ݾ�;
                        || LPAD(NVL(YA.HOUSE_INTER_AMT, 0), 8, 0) -- �����Ӵ������Աݿ����ݻ�ȯ�����ݾ�(������);
                        || LPAD(0, 8, 0)  -- �����������Աݿ����ݻ�ȯ��(������).
                        || LPAD(NVL(YA.HOUSE_MONTHLY_AMT, 0), 8, 0)  -- �����ڱ�_������;
                        || LPAD(NVL(YA.LONG_HOUSE_PROF_AMT, 0), 8, 0) -- ��������������Ա����ڻ�ȯ�����ݾ�;
                        || LPAD(NVL(YA.LONG_HOUSE_PROF_AMT_1, 0), 8, 0) -- ��������������Ա����ڻ�ȯ�����ݾ�(15);
                        || LPAD(NVL(YA.LONG_HOUSE_PROF_AMT_2, 0), 8, 0) -- ��������������Ա����ڻ�ȯ�����ݾ�(30);
                        -- ��ȣ�� �߰� : 2012�⵵ �������� BEGIN --
                        || LPAD(NVL(YA.LONG_HOUSE_PROF_AMT_3_FIX, 0), 8, 0) -- 12�� ���� ��������������Ա����ڻ�ȯ�����ݾ�(�����ݸ�);
                        || LPAD(NVL(YA.LONG_HOUSE_PROF_AMT_3_ETC, 0), 8, 0) -- 12�� ���� ��������������Ա����ڻ�ȯ�����ݾ�(��Ÿ);
                        -- ��ȣ�� �߰� : 2012�⵵ �������� END --
                        || LPAD(NVL(YA.DONAT_AMT, 0), 13, 0)  -- ��αݰ����ݾ�;
                        || LPAD(0, 20, 0) --AS SP_DED_SPACE_VALUE
                        || LPAD(( CASE
                                    WHEN NVL(YA.MEDIC_INSUR_AMT, 0) +
                                        NVL(YA.HIRE_INSUR_AMT, 0) +
                                        NVL(YA.GUAR_INSUR_AMT, 0) +
                                        NVL(YA.DISABILITY_INSUR_AMT, 0) < 0 THEN 0
                                    ELSE NVL(YA.MEDIC_INSUR_AMT, 0) +
                                        NVL(YA.HIRE_INSUR_AMT, 0) +
                                        NVL(YA.GUAR_INSUR_AMT, 0) +
                                        NVL(YA.DISABILITY_INSUR_AMT, 0)
                                  END) +
                                  NVL(YA.MEDIC_AMT, 0) +
                                  NVL(YA.EDUCATION_AMT, 0) +
                                  NVL(YA.HOUSE_INTER_AMT, 0) +
                                  NVL(YA.HOUSE_MONTHLY_AMT, 0) +
                                  NVL(YA.LONG_HOUSE_PROF_AMT, 0) +
                                  NVL(YA.LONG_HOUSE_PROF_AMT_1, 0) +
                                  NVL(YA.LONG_HOUSE_PROF_AMT_2, 0) +
                                  NVL(YA.LONG_HOUSE_PROF_AMT_3_FIX, 0) +
                                  NVL(YA.LONG_HOUSE_PROF_AMT_3_ETC, 0) +
                                  NVL(YA.DONAT_AMT, 0), 10, 0) -- ��;
                        || LPAD(NVL(YA.STAND_DED_AMT, 0), 8, 0) -- ǥ�ذ���;
                        || LPAD(NVL(YA.SUBT_DED_AMT, 0), 11, 0) -- �����ҵ�ݾ�;
                        --> �� ���� �ҵ����.
                        || LPAD(NVL(YA.PERS_ANNU_BANK_AMT, 0), 8, 0) -- ���ο�������ҵ����;
                        || LPAD(NVL(YA.ANNU_BANK_AMT, 0), 8, 0) -- ��������ҵ����;
                        || LPAD(NVL(YA.SMALL_CORPOR_DED_AMT, 0), 10, 0) -- �ұ�������αݼҵ����;
                        || LPAD(NVL(YA.HOUSE_APP_DEPOSIT_AMT, 0), 10, 0)  -- ��)���ø�������ҵ����-û������;
                        || LPAD(NVL(YA.HOUSE_APP_SAVE_AMT, 0), 10, 0) -- ��)���ø�������ҵ����-����û����������;
                        || LPAD(NVL(YA.HOUSE_SAVE_AMT, 0), 10, 0)  -- ��)������ø�������.
                        || LPAD(NVL(YA.WORKER_HOUSE_SAVE_AMT, 0), 10, 0)  -- ��)�ٷ������ø�������.
                        || LPAD(NVL(YA.INVES_AMT, 0), 10, 0) -- �����������ڵ�ҵ����;
                        || LPAD(NVL(YA.CREDIT_AMT, 0), 8, 0) -- �ſ�ī��� �ҵ����;                        
                        --|| LPAD(CASE
                        --        WHEN NVL(YA.EMPL_STOCK_AMT, 0) < 0 THEN 0
                        --        ELSE 1
                        --      END, 1, 0) -- �츮�������ռҵ����(����̸� 0);
                        || LPAD(ABS(NVL(YA.EMPL_STOCK_AMT, 0)), 10, 0) -- �츮�������ռҵ����(�ѵ� 400����);
                        || LPAD(NVL(YA.LONG_STOCK_SAVING_AMT, 0), 10, 0) -- ����ֽ�������ҵ����;
                        -- 2009�� �������� �߰� BEGIN. ��������߼ұ���ٷ��ڼҵ����/���� �߰�;
                        || LPAD(NVL(YA.HIRE_KEEP_EMPLOY_AMT, 0), 10, 0) -- ��������߼ұ���ٷ��ڼҵ����;
                        -- 2009�� �������� �߰� END --
                        || LPAD(0, 10, 0) -- ����;
                        || LPAD((NVL(YA.PERS_ANNU_BANK_AMT, 0) +
                                NVL(YA.ANNU_BANK_AMT, 0) +
                                NVL(YA.SMALL_CORPOR_DED_AMT, 0) +
                                NVL(YA.HOUSE_APP_DEPOSIT_AMT, 0) +
                                NVL(YA.HOUSE_APP_SAVE_AMT, 0) +
                                NVL(YA.HOUSE_SAVE_AMT, 0) +
                                NVL(YA.WORKER_HOUSE_SAVE_AMT, 0) +
                                NVL(YA.INVES_AMT, 0) +
                                NVL(YA.CREDIT_AMT, 0) +
                                ABS(NVL(YA.EMPL_STOCK_AMT, 0)) +
                                NVL(YA.LONG_STOCK_SAVING_AMT, 0) +
                                NVL(YA.HIRE_KEEP_EMPLOY_AMT, 0)), 10, 0) -- �׹��� �ҵ���� ��(����̸� '0'����);
                        || LPAD(NVL(YA.TAX_STD_AMT, 0), 11, 0) -- ���ռҵ� ����ǥ��;
                        || LPAD(NVL(YA.COMP_TAX_AMT, 0), 10, 0) -- ���⼼��;
                        --> ���װ���.
                        || LPAD(NVL(YA.TAX_REDU_IN_LAW_AMT, 0), 10, 0) --�ҵ漼��;
                        || LPAD(NVL(YA.TAX_REDU_SP_LAW_AMT, 0), 10, 0) -- ����Ư�����ѹ�;
                        -- 2012�� �������� �߰� START --
                        || LPAD(0, 10, 0) -- ����Ư�����ѹ� : �߼ұ�� ��� û�� �ҵ漼 ����;
                        -- 2012�� �������� �߰� END --
                        || LPAD(NVL(YA.TAX_REDU_TAX_TREATY, 0), 10, 0) -- ��������.
                        || LPAD(0, 10, 0) -- ����;
                        || LPAD(NVL(YA.TAX_REDU_IN_LAW_AMT, 0) +
                                NVL(YA.TAX_REDU_SP_LAW_AMT, 0) +
                                NVL(YA.TAX_REDU_TAX_TREATY, 0), 10, 0) -- ���鼼�װ�;
                        --> ���װ���.
                        || LPAD(NVL(YA.TAX_DED_INCOME_AMT, 0), 10, 0) -- �ٷμҵ漼�װ���;
                        || LPAD(NVL(YA.TAX_DED_TAXGROUP_AMT, 0), 10, 0) -- �������հ���;
                        || LPAD(NVL(YA.TAX_DED_HOUSE_DEBT_AMT, 0), 10, 0) -- �������Ա�;
                        || LPAD(NVL(YA.TAX_DED_DONAT_POLI_AMT, 0), 10, 0) -- �����ġ�ڱ�;
                        || LPAD(NVL(YA.TAX_DED_OUTSIDE_PAY_AMT, 0), 10, 0) -- �ܱ�����;
                        || LPAD(0, 10, 0) -- ����;
                        || LPAD(NVL(YA.TAX_DED_INCOME_AMT, 0) +
                                NVL(YA.TAX_DED_TAXGROUP_AMT, 0) +
                                NVL(YA.TAX_DED_HOUSE_DEBT_AMT, 0) +
                                NVL(YA.TAX_DED_DONAT_POLI_AMT, 0) +
                                NVL(YA.TAX_DED_OUTSIDE_PAY_AMT, 0), 10, 0) -- ���װ�����;
                        --> ��������.
                        || LPAD(TRUNC(NVL(YA.FIX_IN_TAX_AMT, 0), 0), 10, 0) -- �ҵ漼(������ ����);
                        || LPAD(TRUNC(NVL(YA.FIX_LOCAL_TAX_AMT, 0), 0), 10, 0) -- �ֹμ�;
                        || LPAD(TRUNC(NVL(YA.FIX_SP_TAX_AMT, 0), 0), 10, 0) -- ��Ư��;
                        /* -- ��ȣ�� �ּ� : �հ� ����.
                        || LPAD(TRUNC(NVL(YA.FIX_IN_TAX_AMT, 0), -1) +
                                TRUNC(NVL(YA.FIX_LOCAL_TAX_AMT, 0), -1) +
                                TRUNC(NVL(YA.FIX_SP_TAX_AMT, 0), -1), 10, 0) -- �������� �հ�;*/ 
                        /* -- ��(��)���μ��� ����.
                        --> ��(��) ���μ���.
                        || LPAD(TRUNC(NVL(HEW1.IN_TAX_AMT, 0), -1), 10, 0) -- �ҵ漼.
                        || LPAD(TRUNC(NVL(HEW1.LOCAL_TAX_AMT, 0), -1), 10, 0) -- �ֹμ�.
                        || LPAD(TRUNC(NVL(HEW1.SP_TAX_AMT, 0), -1), 10, 0) -- ��Ư��;
                        || LPAD(TRUNC(NVL(HEW1.IN_TAX_AMT, 0), -1) + 
                                TRUNC(NVL(HEW1.LOCAL_TAX_AMT, 0), -1) + 
                                TRUNC(NVL(HEW1.SP_TAX_AMT, 0), -1), 10, 0) -- ���� ���μ��� �հ�;*/
                        -- 2009�� �������� ����(MODIFIED BY YOUNG MIN). "��(��) ���μ���"���� "�ⳳ�μ��� - ��(��)�ٹ���"�� ��Ī ����;
                        --> �ⳳ�μ��� - ��(��)�ٹ���;
                        || LPAD(TRUNC(NVL(YA.PRE_IN_TAX_AMT, 0) - NVL(S_PW.IN_TAX_AMT, 0), -1), 10, 0) -- �ҵ漼.
                        || LPAD(TRUNC(NVL(YA.PRE_LOCAL_TAX_AMT, 0) - NVL(S_PW.LOCAL_TAX_AMT, 0), -1), 10, 0) --�ֹμ�.
                        || LPAD(TRUNC(NVL(YA.PRE_SP_TAX_AMT, 0) - NVL(S_PW.SP_TAX_AMT, 0), -1), 10, 0) -- ��Ư��.
                        /* -- ��ȣ�� �ּ� : �հ� ����.
                        || LPAD(TRUNC(NVL(YA.PRE_IN_TAX_AMT, 0) - NVL(HEW1.IN_TAX_AMT, 0), -1) +
                                TRUNC(NVL(YA.PRE_LOCAL_TAX_AMT, 0) - NVL(HEW1.LOCAL_TAX_AMT, 0), -1) +
                                TRUNC(NVL(YA.PRE_SP_TAX_AMT, 0) - NVL(HEW1.SP_TAX_AMT, 0), -1), 10, 0) -- ��(��) ���μ��� �հ�;*/
                        --> ����¡������;
                        -- 2009�� �������� ����(MODIFIED BY YOUNG MIN). "����¡������"�߰�(10���̸� �ܼ�����);
                        -- �������� - [��(��)�ٹ��� �ⳳ�μ��� + ��(��)�ٹ��� �ⳳ�μ����� ��];
                        || LPAD(CASE
                                  WHEN TRUNC(NVL(YA.FIX_IN_TAX_AMT, 0), -1) - TRUNC(NVL(YA.PRE_IN_TAX_AMT, 0), -1) < 0 THEN 1
                                  ELSE 0
                                END, 1, 0)  -- 0 <= ����¡������(�ҵ漼) < 1000 �� ��� "0"����;
                        || LPAD(ABS(TRUNC(TRUNC(NVL(YA.FIX_IN_TAX_AMT, 0), -1) - TRUNC(NVL(YA.PRE_IN_TAX_AMT, 0), -1))), 10, 0) -- �����ҵ漼.
                        || LPAD(CASE
                                  WHEN (TRUNC(NVL(YA.FIX_LOCAL_TAX_AMT, 0), -1) - TRUNC(NVL(YA.PRE_LOCAL_TAX_AMT, 0), -1)) < 0 THEN 1
                                  ELSE 0
                                END, 1, 0)  -- 0 <= ����¡������(�ֹμ�) < 1000 �� ��� "0"����;
                        || LPAD(ABS(TRUNC(TRUNC(NVL(YA.FIX_LOCAL_TAX_AMT, 0), -1) - TRUNC(NVL(YA.PRE_LOCAL_TAX_AMT, 0), -1))), 10, 0) -- �����ֹμ�.
                        || LPAD(CASE
                                  WHEN (TRUNC(NVL(YA.FIX_SP_TAX_AMT, 0), -1) - TRUNC(NVL(YA.PRE_SP_TAX_AMT, 0), -1)) < 0 THEN 1
                                  ELSE 0
                                END, 1, 0)  -- 0 <= ����¡������(��Ư��) < 1000 �� ��� "0"����;
                        || LPAD(ABS(TRUNC(TRUNC(NVL(YA.FIX_SP_TAX_AMT, 0), -1) - TRUNC(NVL(YA.PRE_SP_TAX_AMT, 0), -1))), 10, 0)  -- ���� ��Ư��.
                        /*|| LPAD(CASE
                                  WHEN (TRUNC(NVL(YA.FIX_IN_TAX_AMT, 0), -1) - TRUNC(NVL(YA.PRE_IN_TAX_AMT, 0), -1) +
                                      TRUNC(NVL(YA.FIX_LOCAL_TAX_AMT, 0), -1) - TRUNC(NVL(YA.PRE_LOCAL_TAX_AMT, 0), -1) +
                                      TRUNC(NVL(YA.FIX_SP_TAX_AMT, 0), -1) - TRUNC(NVL(YA.PRE_SP_TAX_AMT, 0), -1)) < 0 THEN 1
                                  ELSE 0
                                END, 1, 0) -- ����¡������ ��;
                        -- ��ȣ�� �ּ�.
                        || LPAD(ABS(TRUNC(TRUNC(NVL(YA.FIX_IN_TAX_AMT, 0), -1) - TRUNC(NVL(YA.PRE_IN_TAX_AMT, 0), -1)) +
                                   TRUNC(TRUNC(NVL(YA.FIX_LOCAL_TAX_AMT, 0), -1) - TRUNC(NVL(YA.PRE_LOCAL_TAX_AMT, 0), -1)) +
                                   TRUNC(TRUNC(NVL(YA.FIX_SP_TAX_AMT, 0), -1) - TRUNC(NVL(YA.PRE_SP_TAX_AMT, 0), -1))), 10, 0) -- ����¡������ ��;*/
                        --> ����.
                        || LPAD(' ', 6, ' ') AS RECORD_FILE
                        , NVL(YA.MEDIC_INSUR_AMT, 0) + NVL(YA.HIRE_INSUR_AMT, 0) AS MEDIC_INSUR_AMT  -- 'E'���ڵ忡�� ���(����û���� ����� ���� ����).
                        , NVL(YA.TAX_DED_DONAT_POLI_AMT, 0) AS TAX_DED_DONAT_POLI_AMT 
                        , PM.PERSON_ID
                        , REPLACE(PM.REPRE_NUM, '-') AS REPRE_NUM
                        , ROW_NUMBER() OVER(PARTITION BY YA.YEAR_YYYY ORDER BY PM.PERSON_NUM) AS C_SEQ_NO
                        , PM.JOIN_DATE
                        , PM.FOREIGN_TAX_YN
                      FROM HRM_PERSON_MASTER PM
                        , HRA_YEAR_ADJUSTMENT YA
                        , ( SELECT HC.COMMON_ID AS NATION_ID
                                , HC.CODE AS NATION_CODE
                                , HC.CODE_NAME AS NATION_NAME
                                , HC.VALUE1 AS ISO_NATION_CODE
                              FROM HRM_COMMON HC
                            WHERE HC.GROUP_CODE   = 'NATION'
                              AND HC.SOB_ID       = P_SOB_ID
                              AND HC.ORG_ID       = P_ORG_ID
                           ) S_HN
                        , ( -- �����ٹ�ó ����.
                            SELECT PW.YEAR_YYYY
                                , PW.PERSON_ID
                                , COUNT(PW.PERSON_ID) AS PRE_WORK_COUNT
                                , SUM(PW.IN_TAX_AMT) AS IN_TAX_AMT
                                , SUM(PW.LOCAL_TAX_AMT) AS LOCAL_TAX_AMT
                                , SUM(PW.SP_TAX_AMT) AS SP_TAX_AMT
                              FROM HRA_PREVIOUS_WORK PW
                                , HRM_PERSON_MASTER PM
                            WHERE PW.PERSON_ID    = PM.PERSON_ID
                              AND PW.YEAR_YYYY    = P_YEAR_YYYY
                              AND PM.CORP_ID      = P_CORP_ID
                              AND PW.SOB_ID       = P_SOB_ID
                              AND PW.ORG_ID       = P_ORG_ID
                            GROUP BY PW.YEAR_YYYY
                                , PW.PERSON_ID
                          ) S_PW
                    WHERE PM.PERSON_ID      = YA.PERSON_ID
                      AND PM.NATION_ID      = S_HN.NATION_ID(+)
                      AND YA.YEAR_YYYY      = S_PW.YEAR_YYYY(+)
                      AND YA.PERSON_ID      = S_PW.PERSON_ID(+)
                      AND YA.YEAR_YYYY      = P_YEAR_YYYY
                      AND YA.CORP_ID        = P_CORP_ID
                      AND YA.SOB_ID         = P_SOB_ID
                      AND YA.ORG_ID         = P_ORG_ID
                      AND YA.SUBMIT_DATE    BETWEEN P_START_DATE AND P_END_DATE
                      AND YA.INCOME_TOT_AMT <> 0
                      AND YA.ADJUST_DATE_TO BETWEEN P_START_DATE AND P_END_DATE
                      /*AND PM.ORI_JOIN_DATE  <= TO_DATE(P_YEAR_YYYY||'-12-31','YYYY-MM-DD')
                      AND (PM.RETIRE_DATE   >= TO_DATE(P_YEAR_YYYY||'-12-31','YYYY-MM-DD') OR PM.RETIRE_DATE IS NULL)*/
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
              , P_SORT_NUM          => 1
              );
            --DBMS_OUTPUT.PUT_LINE(C1.RECORD_FILE); 
--D1 ------------------------------------------------------------------------------------
            --> ��(��)�ٹ�ó ���ڵ� <--
            FOR D1 IN ( SELECT -- �ڷ������ȣ;
                              'D' -- ���ڵ� ����;
                            || '20' -- �ڷᱸ��;
                            || RPAD(B1.TAX_OFFICE_CODE, 3, ' ') -- �������ڵ�;
                            || LPAD(C1.C_SEQ_NO, 6, '0') -- C���ڵ��� �Ϸù�ȣ.
                            -- ��õ¡���ǹ���;
                            || RPAD(B1.VAT_NUMBER, 10, ' ') -- ����ڹ�ȣ.
                            || RPAD(' ', 50, ' ') -- ����;
                            -- �ҵ���;
                            || RPAD(NVL(C1.REPRE_NUM, ' '), 13, ' ') -- �ֹι�ȣ.
                            -- �ٹ�ó�� �ҵ�� - ��(��)�ٹ�ó;
                            || RPAD('2',1,' ') -- �������ձ���;
                            || RPAD(REPLACE(PW.COMPANY_NAME, ' ' , ''), 40, ' ') -- ���θ�(��ȣ);
                            || RPAD(REPLACE(PW.COMPANY_NUM, '-', ''), 10, ' ') -- ����ڵ�Ϲ�ȣ;
                            -- 2009�� �������� ����. �ٹ��Ⱓ/����Ⱓ ����/���Ῥ���� �߰�;
                            || RPAD(CASE -- �ٹ��Ⱓ ���ۿ�����;
                                      WHEN PW.JOIN_DATE > TO_DATE(P_YEAR_YYYY || '-01-01', 'YYYY-MM-DD') THEN TO_CHAR(PW.JOIN_DATE, 'YYYYMMDD')
                                      ELSE P_YEAR_YYYY || '0101'
                                    END, 8, '0')
                            || RPAD(TO_CHAR(NVL(PW.RETR_DATE, C1.JOIN_DATE -1), 'YYYYMMDD'), 8, '0') -- �ٹ��Ⱓ ���Ῥ����;
                            || LPAD('0', 8, '0') -- ����Ⱓ ���ۿ�����;
                            || LPAD('0', 8, '0') -- ����Ⱓ ���Ῥ����;
                            || LPAD(NVL(PW.PAY_TOTAL_AMT, 0), 11, 0) -- �޿��Ѿ�;
                            || LPAD(NVL(PW.BONUS_TOTAL_AMT, 0), 11, 0) -- ���Ѿ�;
                            || LPAD(NVL(PW.ADD_BONUS_AMT, 0), 11, 0) -- ������;
                            || LPAD(NVL(PW.STOCK_BENE_AMT, 0), 11, 0) -- �ֽĸż����ñ��������;
                            -- 2009�� �������� ����(MODIFIED BY YOUNG MIN). �츮������������� �߰�;
                            || LPAD(0, 11, 0)  -- �츮�������������(�迡�� �������� �ʾ���);
                            || LPAD(0, 22, 0)  -- ����.
                            || LPAD(NVL(PW.PAY_TOTAL_AMT, 0) +
                                    NVL(PW.BONUS_TOTAL_AMT, 0) +
                                    NVL(PW.ADD_BONUS_AMT, 0) +
                                    NVL(PW.STOCK_BENE_AMT, 0), 11, 0)  -- ��.
                            --> ��(��)�ٹ�ó ����� �ҵ�.
                            -- 2009�� �������� ����(MODIFIED BY YOUNG MIN).��(��)�ٹ�ó ����� �ҵ� ���麯��;
                            || LPAD(NVL(PW.NT_SCH_EDU_AMT, 0), 10, 0) -- �����-���ڱ�;
                            || LPAD(NVL(PW.NT_MEMBER_AMT, 0), 10, 0) -- �����-��������������;
                            || LPAD(NVL(PW.NT_GUARD_AMT, 0), 10, 0) -- �����-��ȣ/�¼�����;
                            || LPAD(NVL(PW.NT_CHILD_AMT, 0), 10, 0) -- �����-����/���ߵ�_��������/Ȱ����;
                            || LPAD(NVL(PW.NT_HIGH_SCH_AMT, 0), 10, 0) -- �����-����_��������/Ȱ����;
                            || LPAD(NVL(PW.NT_SPECIAL_AMT, 0), 10, 0) -- �����-Ư���������������_��������/Ȱ����;
                            || LPAD(NVL(PW.NT_RESEARCH_AMT, 0), 10, 0) -- �����-�������_��������/Ȱ����;
                            || LPAD(NVL(PW.NT_COMPANY_AMT, 0), 10, 0) -- �����-���������_��������/Ȱ����;
                            -- 2012�� �������� �߰� START --
                            || LPAD(0, 10, 0) -- �����-�������� �ٹ�ȯ�氳����;
                            || LPAD(0, 10, 0) -- �����-�縳��ġ�� ��������/������ �ΰǺ�;
                            -- 2012�� �������� �߰� END --
                            || LPAD(NVL(PW.NT_COVER_AMT, 0), 10, 0) -- �����-�������;
                            || LPAD(NVL(PW.NT_WILD_AMT, 0), 10, 0) -- �����-��������;
                            || LPAD(NVL(PW.NT_DISASTER_AMT, 0), 10, 0) -- �����-���ذ��ñ޿�;
                            || LPAD(NVL(PW.NT_OUTSIDE_GOVER_AMT, 0), 10, 0) -- �����-�ܱ����ε�ٹ���;
                            || LPAD(NVL(PW.NT_OUTSIDE_ARMY_AMT, 0), 10, 0) -- �����-�ܱ��ֵб��ε�;
                            || LPAD(NVL(PW.NT_OUTSIDE_WORK1, 0), 10, 0) -- �����-���ܱٷ�(100����);
                            || LPAD(NVL(PW.NT_OUTSIDE_WORK2, 0), 10, 0) -- �����-���ܱٷ�(300����);
                            || LPAD(NVL(PW.NT_OUTSIDE_AMT, 0), 10, 0) -- ����� ���ܼҵ�;
                            || LPAD(NVL(PW.NT_OT_AMT, 0), 10, 0) -- ����� �߰��ٷ�;
                            || LPAD(NVL(PW.NT_BIRTH_AMT, 0), 10, 0) -- ����� ���/��������;
                            || LPAD(0, 10, 0) -- �ٷ����б�.
                            || LPAD(NVL(PW.NT_STOCK_BENE_AMT, 0), 10, 0) -- �����-�ֽĸż����ñ�;
                            || LPAD(NVL(PW.NT_FOREIGNER_AMT, 0), 10, 0) -- �����-�ܱ��α����;
                            --|| LPAD(NVL(PW.NONTAX_FOREIGNER_AMT, 0), 10, 0) -- ����� �ܱ��� �ٷ���;
                            --|| LPAD(NVL(PW.NONTAX_EMPL_STOCK_AMT, 0), 10, 0) --  �����-�츮�������չ���;
                            || LPAD(NVL(PW.NT_EMPL_STOCK_AMT, 0), 10, 0) -- �����-�츮�������������(50%);
                            || LPAD(NVL(PW.NT_EMPL_BENE_AMT2, 0), 10, 0) -- �����-�츮�������������(75%);
                            || LPAD(0, 10, 0)                                  -- �����-��������� �߼ұ�� ���;
                            --|| LPAD(NVL(PW.NONTAX_HOUSE_SUBSIDY_AMT, 0), 10, 0) -- �����-�����ڱݺ�����;
                            || LPAD(NVL(PW.NT_SEA_RESOURCE_AMT, 0), 10, 0) -- �����-���������ڿ�����;
                            -- 2012�� �������� �߰� START --
                            || LPAD(0, 10, 0) -- �����-������ ���ú�������;
                            || LPAD(0, 10, 0) -- �����-�߼ұ�� ���û�� �ҵ漼 ����;
                            || LPAD(0, 10, 0) -- �����-��������� ������ ����;
                            -- 2012�� �������� �߰� END --
                            --|| LPAD(0, 10, 0)  -- ���������;
                            --|| LPAD(NVL(PW.NONTAX_ETC_AMT, 0), 10, 0) --AS NONTAX_ETC_AMT     -- ����� ��Ÿ;
                            || LPAD(NVL(PW.NT_SCH_EDU_AMT, 0) +
                                    NVL(PW.NT_MEMBER_AMT, 0) +
                                    NVL(PW.NT_GUARD_AMT, 0) +
                                    NVL(PW.NT_CHILD_AMT, 0) +
                                    NVL(PW.NT_HIGH_SCH_AMT, 0) +
                                    NVL(PW.NT_SPECIAL_AMT, 0) +
                                    NVL(PW.NT_RESEARCH_AMT, 0) +
                                    NVL(PW.NT_COMPANY_AMT, 0) +
                                    NVL(PW.NT_COVER_AMT, 0) +
                                    NVL(PW.NT_WILD_AMT, 0) +
                                    NVL(PW.NT_DISASTER_AMT, 0) +
                                    NVL(PW.NT_OUTSIDE_GOVER_AMT, 0) +
                                    NVL(PW.NT_OUTSIDE_ARMY_AMT, 0) +
                                    NVL(PW.NT_OUTSIDE_WORK1, 0) +
                                    NVL(PW.NT_OUTSIDE_WORK2, 0) +
                                    NVL(PW.NT_OUTSIDE_AMT, 0) +
                                    NVL(PW.NT_OT_AMT, 0) +
                                    NVL(PW.NT_BIRTH_AMT, 0) +
                                    --NVL(PW.NONTAX_FOR_ENG_AMT, 0) +                           -- ����ҵ� ��� �̵�;
                                    --NVL(PW.NONTAX_FOREIGNER_AMT, 0) +
                                    --NVL(PW.NONTAX_EMPL_STOCK_AMT, 0) +
                                    NVL(PW.NT_EMPL_BENE_AMT1, 0) +
                                    NVL(PW.NT_EMPL_BENE_AMT2, 0),
                                    --NVL(PW.NONTAX_HOUSE_SUBSIDY_AMT, 0) +
                                    --NVL(PW.NONTAX_SEA_RESOURCE_AMT, 0) +                      -- ����ҵ� ��� �̵�;
                                    --NVL(PW.NONTAX_ETC_AMT, 0),
                                    10, 0)  -- ����� ��;
                            || LPAD(NVL(PW.NT_FOREIGNER_AMT, 0) +
                                    NVL(PW.NT_SEA_RESOURCE_AMT, 0), 10, 0)  -- ����ҵ� ��;
                            -- �ⳳ�μ��� - ��(��)�ٹ���;
                            || LPAD(NVL(PW.IN_TAX_AMT, 0), 10, 0)
                            || LPAD(NVL(PW.LOCAL_TAX_AMT, 0), 10, 0)
                            || LPAD(NVL(PW.SP_TAX_AMT, 0), 10, 0)
                            /*-- ��ȣ�� �ּ� : 2011�� ������.
                            || LPAD(NVL(PW.IN_TAX_AMT, 0) +
                                    NVL(PW.LOCAL_TAX_AMT, 0) +
                                    NVL(PW.SP_TAX_AMT, 0), 10, 0)*/
                            -- || LPAD(NVL(PW.PAY_TOTAL_AMT, 0) + NVL(PW.BONUS_TOTAL_AMT, 0) + NVL(PW.ADD_BONUS_AMT, 0) + NVL(PW.STOCK_BENE_AMT, 0),11, 0) --AS PAY_SUM_AMT                       -- ��;
                            || LPAD(ROW_NUMBER() OVER(PARTITION BY PW.PERSON_ID ORDER BY PW.SEQ_NUM), 2, 0) -- ��(��)�ٹ�ó �Ϸù�ȣ;
                            || RPAD(' ', 722, ' ') AS RECORD_FILE 
                            , ROW_NUMBER() OVER(PARTITION BY PW.PERSON_ID ORDER BY PW.SEQ_NUM) AS D_SEQ_NO
                          FROM HRA_PREVIOUS_WORK PW
                        WHERE PW.YEAR_YYYY    = P_YEAR_YYYY
                          AND PW.SOB_ID       = P_SOB_ID
                          AND PW.ORG_ID       = P_ORG_ID
                          AND PW.PERSON_ID    = C1.PERSON_ID
                      )
            LOOP
              V_SOURCE_FILE := 'D_RECORD';
              INSERT_REPORT_FILE
                ( P_SEQ_NUM           => V_SEQ_NUM
                , P_SOURCE_FILE       => V_SOURCE_FILE
                , P_SOB_ID            => P_SOB_ID
                , P_ORG_ID            => P_ORG_ID
                , P_REPORT_FILE       => D1.RECORD_FILE
                , P_SORT_NUM          => 2 + ( 0.1 * D1.D_SEQ_NO)
                );
              --DBMS_OUTPUT.PUT_LINE(D1.RECORD_FILE); 
            END LOOP D1;
--E1 �ξ簡�� �� ----------------------------------------------------------------------------
-- �ܱ��� ���ϼ����� �ƴҰ�츸 ����.
          IF C1.FOREIGN_TAX_YN = 'N' THEN
            V_RECORD_FILE := NULL;
            V_SEQ_NO    := 0;
            V_RECORD_COUNT := 0;
            FOR E1 IN ( SELECT 
                              'E' --AS RECORD_TYPE
                            || '20' --AS DATA_TYPE
                            || RPAD(NVL(B1.TAX_OFFICE_CODE, ' '), 3, ' ') -- �������ڵ�.
                            || LPAD(NVL(C1.C_SEQ_NO, 0), 6, 0)  -- C���ڵ��� �Ϸù�ȣ.
                            || RPAD(NVL(B1.VAT_NUMBER, ' '), 10, ' ') -- ����ڹ�ȣ.
                            || RPAD(NVL(C1.REPRE_NUM, ' '), 13, ' ') AS RECORD_HEADER -- �ֹι�ȣ.
                            --> �ҵ������ ��������.
                            , RPAD(NVL(SF.RELATION_CODE, ' '), 1, ' ') -- ����;
                            || RPAD(CASE
                                      WHEN SUBSTR(REPLACE(SF.REPRE_NUM, '-', ''), 7, 1) BETWEEN '5' AND '8' THEN '9'
                                      ELSE '1'
                                    END, 1, ' ') -- ��/�ܱ��� ���� �ڵ�;
                            || RPAD(NVL(SF.FAMILY_NAME, ' '), 20, ' ') -- ����;
                            || RPAD(NVL(REPLACE(SF.REPRE_NUM, '-', ''), ' ') , 13, ' ') -- �ֹι�ȣ;
                            || DECODE(SF.BASE_YN, 'Y', '1', ' ') -- �⺻����;
                            || CASE 
                                 WHEN SF.BASE_YN = 'Y' AND SF.DISABILITY_YN = 'Y' THEN '1'
                                 ELSE ' '
                               END  -- ����ΰ���;
                            || DECODE(SF.CHILD_YN, 'Y', '1', ' ') -- �ڳ���������;
                            || DECODE(SF.WOMAN_YN, 'Y', '1', ' ') -- �γ��ڰ���;
                            -- 2009�� �������� ����(MODIFIED BY YOUNG MIN).��ο�� ��70���̻����� ����;
                            || CASE
                                 --WHEN SF.OLD_YN = 'Y' THEN '1'
                                 WHEN SF.OLD1_YN = 'Y' THEN '1'
                                 ELSE ' '
                               END -- ��ο�����;
                            -- 2009�� �������� ����(MODIFIED BY YOUNG MIN).����Ծ��ڰ����߰�;
                            || DECODE(SF.BIRTH_YN, 'Y', '1', ' ') -- ����Ծ��ڰ���.
                            /*-- 2009�� �������� ����(MODIFIED BY YOUNG MIN).���ڳ��߰����� ����;
                            || CASE
                                 WHEN SF.BASE_YN = 'Y' AND C1.MANY_CHILD_DED_AMT <> 0 AND SF.RELATION_CODE = '4' THEN '1'
                                 ELSE ' '
                               END -- ���ڳ��߰�����;*/
                            --> ����û �ڷ�.
                            -- 2009�� �������� ����(MODIFIED BY YOUNG MIN).����û�ڷ� �����ݾ��� ������ ��� 0���� ǥ��;
                            || LPAD((CASE
                                       WHEN DECODE(SF.RELATION_CODE, 0, NVL(C1.MEDIC_INSUR_AMT, 0), 0) + 
                                            NVL(SF.INSURE_AMT, 0) + NVL(SF.DISABILITY_INSURE_AMT, 0) < 0 THEN 0
                                       ELSE DECODE(SF.RELATION_CODE, 0, NVL(C1.MEDIC_INSUR_AMT, 0), 0) + 
                                            NVL(SF.INSURE_AMT, 0) + NVL(SF.DISABILITY_INSURE_AMT, 0)
                                     END), 10, 0) -- �����(������ �ǰ������ ����);
                            || LPAD(NVL(SF.MEDICAL_AMT, 0), 10, 0) --  �Ƿ��;
                            || LPAD(NVL(SF.EDUCATION_AMT, 0), 10, 0) -- ������;
                            || LPAD(NVL(SF.CREDIT_AMT, 0), 10, 0) -- �ſ�ī���;
                            || LPAD(NVL(SF.CHECK_CREDIT_AMT , 0), 10, 0) -- ����ī��;
                            || LPAD(NVL(SF.CASH_AMT, 0) + NVL(SF.ACADE_GIRO_AMT, 0), 10, 0) -- ���ݿ�����;
                            --2012�� �������� �߰� START --
                            || LPAD(NVL(SF.TRAD_MARKET_AMT, 0), 10, 0) -- ����������;
                            --2012�� �������� �߰� END --
                            || LPAD(NVL(SF.DONAT_ALL, 0) +
                                    NVL(SF.DONAT_50P, 0) +
                                    NVL(SF.DONAT_30P, 0) +
                                    NVL(SF.DONAT_10P, 0) +
                                    NVL(SF.DONAT_10P_RELIGION, 0), 13, 0)  -- ��α�.
                            -->����û�ڷ� �̿�.
                            || LPAD(NVL(SF.ETC_INSURE_AMT, 0), 10, 0) -- ����û�������� �����;
                            || LPAD(NVL(SF.ETC_MEDICAL_AMT, 0), 10, 0) -- ����û�������� �Ƿ��;
                            || LPAD(NVL(SF.ETC_EDUCATION_AMT, 0), 10, 0) -- ����û�������� ������;
                            || LPAD(NVL(SF.ETC_CREDIT_AMT, 0) + NVL(SF.ETC_ACADE_GIRO_AMT, 0), 10, 0) -- ����û�������� �ſ�ī��;
                            || LPAD(NVL(SF.ETC_CHECK_CREDIT_AMT, 0), 10, 0) -- ����û�������� ����ī��;
                            --2012�� �������� �߰� START --
                            || LPAD(NVL(SF.ACADE_GIRO_AMT, 0) + NVL(SF.ETC_ACADE_GIRO_AMT, 0), 10, 0) -- �п��� ���γ��ξ�;
                            || LPAD(NVL(SF.ETC_TRAD_MARKET_AMT, 0), 10, 0) -- ����������;
                            --2012�� �������� �߰� END --
                            || LPAD(NVL(SF.ETC_DONAT_ALL, 0) +
                                    NVL(SF.ETC_DONAT_50P, 0) +
                                    NVL(SF.ETC_DONAT_30P, 0) +
                                    NVL(SF.ETC_DONAT_10P, 0) +
                                    NVL(SF.ETC_DONAT_10P_RELIGION, 0), 13, 0) AS RECORD_LINE -- ����û�������� ��α�;
                         FROM HRA_SUPPORT_FAMILY SF
                        WHERE SF.YEAR_YYYY      = P_YEAR_YYYY
                          AND (SF.BASE_YN        = 'Y'
                            OR SF.SPOUSE_YN      = 'Y'
                            OR SF.OLD_YN         = 'Y'
                            OR SF.OLD1_YN        = 'Y'
                            OR (SF.BASE_YN       = 'Y' AND SF.DISABILITY_YN  = 'Y')
                            OR SF.WOMAN_YN       = 'Y'
                            OR SF.CHILD_YN       = 'Y'
                            OR SF.BIRTH_YN       = 'Y'
                            OR ((NVL(SF.INSURE_AMT, 0) + NVL(SF.ETC_INSURE_AMT, 0) + NVL(SF.DISABILITY_INSURE_AMT, 0) + 
                                NVL(SF.ETC_DISABILITY_INSURE_AMT, 0) + NVL(SF.MEDICAL_AMT, 0) + NVL(SF.ETC_MEDICAL_AMT, 0) +
                                NVL(SF.EDUCATION_TYPE, 0) + NVL(SF.EDUCATION_AMT, 0) + NVL(SF.ETC_EDUCATION_AMT, 0) + 
                                NVL(SF.CREDIT_AMT, 0) + NVL(SF.ETC_CREDIT_AMT, 0) + NVL(SF.CHECK_CREDIT_AMT, 0) + 
                                NVL(SF.ETC_CHECK_CREDIT_AMT, 0) + NVL(SF.CASH_AMT, 0) + NVL(SF.ETC_CASH_AMT, 0) + 
                                NVL(SF.ACADE_GIRO_AMT, 0) + NVL(SF.ETC_ACADE_GIRO_AMT, 0) + 
                                NVL(SF.TRAD_MARKET_AMT, 0) + NVL(SF.ETC_TRAD_MARKET_AMT, 0) +
                                NVL(SF.DONAT_ALL, 0) + NVL(SF.ETC_DONAT_ALL, 0) + NVL(SF.DONAT_50P, 0) + NVL(SF.ETC_DONAT_50P, 0) + 
                                NVL(SF.DONAT_30P, 0) + NVL(SF.ETC_DONAT_30P, 0) + NVL(SF.DONAT_10P, 0) + NVL(SF.ETC_DONAT_10P, 0) + 
                                NVL(SF.DONAT_10P_RELIGION, 0) + NVL(SF.ETC_DONAT_10P_RELIGION, 0) + 
                                NVL(SF.DONAT_POLI, 0) + NVL(SF.ETC_DONAT_POLI, 0))) > 0)
                          AND SF.PERSON_ID      = C1.PERSON_ID
                          AND SF.REPRE_NUM      IS NOT NULL
                        ORDER BY SF.RELATION_CODE
                      )
            LOOP
              V_RECORD_COUNT := NVL(V_RECORD_COUNT, 0) + 1;
              IF V_RECORD_COUNT = 1 THEN
                V_RECORD_FILE := E1.RECORD_HEADER || E1.RECORD_LINE;
              ELSE
                V_RECORD_FILE := V_RECORD_FILE || E1.RECORD_LINE;
              END IF;
              --> �ξ簡���� 5�� �̻��� ���.
              IF V_E_REC_STD <= V_RECORD_COUNT THEN
                V_SEQ_NO := NVL(V_SEQ_NO, 0) + 1;  -- �ξ簡�� ���� �Ϸù�ȣ.
                V_RECORD_FILE := V_RECORD_FILE 
                                 || LPAD(NVL(V_SEQ_NO, 1), 2, 0)  -- �Ϸù�ȣ.
                                 || RPAD(' ', 258, ' ');  -- ����.
                
                V_SOURCE_FILE := 'E_RECORD';
                INSERT_REPORT_FILE
                  ( P_SEQ_NUM           => V_SEQ_NUM
                  , P_SOURCE_FILE       => V_SOURCE_FILE
                  , P_SOB_ID            => P_SOB_ID
                  , P_ORG_ID            => P_ORG_ID
                  , P_REPORT_FILE       => V_RECORD_FILE
                  , P_SORT_NUM          => 3 + (0.001 * V_SEQ_NO)
                  );
                --DBMS_OUTPUT.PUT_LINE(V_RECORD_FILE); 
                V_RECORD_FILE  := NULL;
                V_RECORD_COUNT := 0;
              END IF;
            END LOOP E1;
            IF V_RECORD_COUNT <> 0 THEN
              FOR E1S IN V_RECORD_COUNT + 1 .. V_E_REC_STD
              LOOP
                V_RECORD_FILE := V_RECORD_FILE || RPAD(' ', 207, ' ');  -- �ҵ���� ���� �ξ簡�� ����.
              END LOOP E1S;
              IF V_RECORD_FILE IS NOT NULL THEN
                V_SEQ_NO := NVL(V_SEQ_NO, 0) + 1;  -- �ξ簡�� ���� �Ϸù�ȣ.
                V_RECORD_FILE := V_RECORD_FILE 
                                 || LPAD(NVL(V_SEQ_NO, 1), 2, 0)  -- �Ϸù�ȣ.
                                 || RPAD(' ', 258, ' ');  -- ����.
                                 
                V_SOURCE_FILE := 'E_RECORD';
                INSERT_REPORT_FILE
                  ( P_SEQ_NUM           => V_SEQ_NUM
                  , P_SOURCE_FILE       => V_SOURCE_FILE
                  , P_SOB_ID            => P_SOB_ID
                  , P_ORG_ID            => P_ORG_ID
                  , P_REPORT_FILE       => V_RECORD_FILE
                  , P_SORT_NUM          => 3 + (0.001 * V_SEQ_NO)
                  );
                --DBMS_OUTPUT.PUT_LINE(V_RECORD_FILE); 
              END IF;
            END IF;

--F1 ����/����� �ҵ���� �� ���ڵ� -----------------------------------------------------------------
            V_RECORD_FILE := NULL;
            V_SEQ_NO    := 0;
            V_RECORD_COUNT := 0;
            FOR F1 IN ( SELECT 'F' --AS RECORD_TYPE
                            || '20' --AS DATA_TYPE
                            || RPAD(NVL(B1.TAX_OFFICE_CODE, ' '), 3, ' ') -- �������ڵ�.
                            || LPAD(C1.C_SEQ_NO, 6, 0) -- C���ڵ��� �Ϸù�ȣ.
                            || RPAD(NVL(B1.VAT_NUMBER, ' '), 10, ' ') -- ����ڹ�ȣ.
                            || RPAD(NVL(C1.REPRE_NUM, ' '), 13, ' ') AS RECORD_HEADER -- �ֹι�ȣ.
                            , LPAD(NVL(SI.SAVING_TYPE, ' '), 2, '0')  -- �ҵ��������;
                            || RPAD(SI.BANK_CODE, 3, ' ') -- ������� �ڵ����;
                            || RPAD(YB.YEAR_BANK_NAME, 30, ' ') -- ������� ��ȣ����;
                            || RPAD(SI.ACCOUNT_NUM, 20, ' ') -- ���¹�ȣ;
                            || LPAD(DECODE(SI.SAVING_TYPE, '41', CASE WHEN 3 < SI.SAVING_COUNT THEN 3 ELSE SI.SAVING_COUNT END , '0'), 2, 0) -- ���Կ���-����ֽ������ุ �ش�;
                            || LPAD(SI.SAVING_AMOUNT, 10, 0) -- ���Աݾ�;
                            || LPAD(SI.SAVING_DED_AMOUNT, 10, 0) AS RECORD_LINE               -- �����ݾ�;
                          FROM HRA_SAVING_INFO SI
                            , ( SELECT HC.COMMON_ID AS YEAR_BANK_ID
                                    , HC.CODE AS YEAR_BANK_CODE
                                    , HC.CODE_NAME AS YEAR_BANK_NAME
                                    , HC.SOB_ID
                                    , HC.ORG_ID
                                  FROM HRM_COMMON HC
                                WHERE HC.GROUP_CODE   = 'YEAR_BANK'
                                  AND HC.SOB_ID       = P_SOB_ID
                                  AND HC.ORG_ID       = P_ORG_ID
                               ) YB
                        WHERE SI.BANK_CODE      = YB.YEAR_BANK_CODE
                          AND SI.SOB_ID         = YB.SOB_ID
                          AND SI.ORG_ID         = YB.ORG_ID
                          AND SI.YEAR_YYYY      = P_YEAR_YYYY
                          AND SI.PERSON_ID      = C1.PERSON_ID
                          AND NVL(SI.SAVING_DED_AMOUNT, 0) > 0
                        ORDER BY SI.BANK_CODE ASC
                        )
            LOOP
              V_RECORD_COUNT := NVL(V_RECORD_COUNT, 0) + 1;
              IF V_RECORD_COUNT = 1 THEN
                V_RECORD_FILE := F1.RECORD_HEADER || F1.RECORD_LINE;
              ELSE
                V_RECORD_FILE := V_RECORD_FILE || F1.RECORD_LINE;
              END IF;
              --> ��������� ���� 15�� �̻��� ���.
              IF V_F_REC_STD <= V_RECORD_COUNT THEN
                V_SEQ_NO := NVL(V_SEQ_NO, 0) + 1;  -- �������� ���� �Ϸù�ȣ.
                V_RECORD_FILE := V_RECORD_FILE || RPAD(' ', 70, ' ');  -- ����.
                
                V_SOURCE_FILE := 'F_RECORD';
                INSERT_REPORT_FILE
                  ( P_SEQ_NUM           => V_SEQ_NUM
                  , P_SOURCE_FILE       => V_SOURCE_FILE
                  , P_SOB_ID            => P_SOB_ID
                  , P_ORG_ID            => P_ORG_ID
                  , P_REPORT_FILE       => V_RECORD_FILE
                  , P_SORT_NUM          => 4 + (0.00001 * V_SEQ_NO)
                  );
                --DBMS_OUTPUT.PUT_LINE(V_RECORD_FILE); 
                V_RECORD_FILE  := NULL;
                V_RECORD_COUNT := 0;
              END IF;
            END LOOP F1;
            IF V_RECORD_COUNT <> 0 THEN
              FOR F1S IN V_RECORD_COUNT + 1 .. V_F_REC_STD
              LOOP
                V_RECORD_FILE := V_RECORD_FILE || RPAD(' ', 77, ' ');
              END LOOP F1S;
              IF V_RECORD_FILE IS NOT NULL THEN
                V_SEQ_NO := NVL(V_SEQ_NO, 0) + 1;  -- �ξ簡�� ���� �Ϸù�ȣ.
                V_RECORD_FILE := V_RECORD_FILE || RPAD(' ', 140, ' ');  -- ��������  �ҵ������ ���� ���� => ����.
                
                V_SOURCE_FILE := 'F_RECORD';                
                INSERT_REPORT_FILE
                  ( P_SEQ_NUM           => V_SEQ_NUM
                  , P_SOURCE_FILE       => V_SOURCE_FILE
                  , P_SOB_ID            => P_SOB_ID
                  , P_ORG_ID            => P_ORG_ID
                  , P_REPORT_FILE       => V_RECORD_FILE
                  , P_SORT_NUM          => 4 + (0.00001 * V_SEQ_NO)
                  );
                --DBMS_OUTPUT.PUT_LINE(V_RECORD_FILE); 
              END IF;
            END IF;
--F1 END ---------------------------------------------------------------------------------
          END IF;  -- �ܱ��� ���ϼ��� ���� ���Ұ�츸 ����.
          END LOOP C1;    
        END LOOP B1;
    END LOOP A1;
    
  END SET_YEAR_ADJUST_FILE_2012;

-------------------------------------------------------------------------------
-- 2012�⵵ �Ƿ�� ���ϻ���.
-------------------------------------------------------------------------------
  PROCEDURE SET_MEDICAL_FILE_2012
            ( P_YEAR_YYYY         IN VARCHAR2
            , P_START_DATE        IN HRA_YEAR_ADJUSTMENT.SUBMIT_DATE%TYPE
            , P_END_DATE          IN HRA_YEAR_ADJUSTMENT.SUBMIT_DATE%TYPE
            , P_CORP_ID           IN HRA_YEAR_ADJUSTMENT.CORP_ID%TYPE
            , P_SOB_ID            IN HRA_YEAR_ADJUSTMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRA_YEAR_ADJUSTMENT.ORG_ID%TYPE
            , P_CONNECT_PERSON_ID IN NUMBER
            , P_TAX_PROGRAM_CODE  IN VARCHAR2
            , P_SUBMIT_PERIOD     IN VARCHAR2
            , P_HOMETAX_LOGIN_ID  IN VARCHAR2
            , P_WRITE_DATE        IN DATE
            )
  AS
    V_SEQ_NUM                   NUMBER := 0;
    V_SOURCE_FILE               VARCHAR2(150);
    
    V_TAX_OFFICE_CODE           VARCHAR2(5);
    V_VAT_NUMBER                VARCHAR2(15);
    V_CORP_NAME                 VARCHAR2(50);
  BEGIN
    BEGIN
      SELECT REPLACE(CM.CORP_NAME, ' ', '') AS CORP_NAME
          , OU.VAT_NUMBER
          , OU.TAX_OFFICE_CODE
        INTO V_CORP_NAME
          , V_VAT_NUMBER
          , V_TAX_OFFICE_CODE
        FROM HRM_CORP_MASTER CM
          , HRM_OPERATING_UNIT OU
      WHERE CM.CORP_ID            = OU.CORP_ID
        AND CM.CORP_ID            = P_CORP_ID
        AND CM.SOB_ID             = P_SOB_ID
        AND CM.ORG_ID             = P_ORG_ID
        AND CM.ENABLED_FLAG       = 'Y'
        AND (OU.DEFAULT_FLAG      = 'Y'
        OR (OU.DEFAULT_FLAG       = 'N'
        AND ROWNUM                <= 1))
      ;
    EXCEPTION WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20001, 'Error - ����� ������ ã���� �����ϴ�. Ȯ���ϼ���');
      RETURN;
    END;
    FOR A1 IN ( SELECT 'A'   -- �ڷ������ȣ.
                    || '26'  -- 26;
                    || LPAD(REPLACE(V_TAX_OFFICE_CODE, '-', ''), 3, 0)  -- ������ �ڵ�;
                    || LPAD(ROWNUM, 6, 0)  -- �Ϸù�ȣ.
                    || RPAD(TO_CHAR(P_WRITE_DATE, 'YYYYMMDD'), 8, 0) -- �ڷḦ �������� �����ϴ� ������;
                    --> ������;
/*                    || LPAD(NVL(P_SUBMIT_AGENT, '2'), 1, 0)  -- �����ڱ���(�����븮��1, ����2, ����3);
                    || RPAD(NVL(P_TAX_PROGRAM_CODE, ' '), 6, ' ')  -- �����븮�� ������ȣ(�ڷ������ڰ� �����븮���ΰ�� ����);
*/                    || RPAD(NVL(REPLACE(V_VAT_NUMBER, '-', ''), ' '), 10, ' ')  -- ����ڵ�Ϲ�ȣ;
                    || RPAD(NVL(P_HOMETAX_LOGIN_ID, ' '), 20, ' ')  -- Ȩ�ý�ID;
                    || RPAD(NVL(P_TAX_PROGRAM_CODE, '1001'), 4, ' ')  -- �������α׷��ڵ�;                    
                    || RPAD(NVL(REPLACE(V_VAT_NUMBER, '-', ''), ' '), 10, ' ')  -- ����ڵ�Ϲ�ȣ;
                    || RPAD(NVL(REPLACE(V_CORP_NAME, ' ', ''), ' '), 40, ' ')  -- ���θ�(��ȣ);
                    || RPAD(NVL(REPLACE(PM.REPRE_NUM, '-', '') ,' '), 13, ' ')  -- �ҵ����ֹι�ȣ.
                    || RPAD(NVL(PM.NATIONALITY_TYPE, ' '), 1, 0)  -- ���ܱ��α���.
                    || RPAD(NVL(REPLACE(PM.NAME, ' ', ''), ' '), 30, ' ') --�ҵ����� ����;
                    || LPAD(NVL(REPLACE(MI.CORP_TAX_REG_NO, '-', ''), ' '), 10, ' ') --AS ����ó�� ����ڵ�Ϲ�ȣ;
                    || RPAD(NVL(REPLACE(MI.CORP_NAME, ' ' , ''), ' '), 40, ' ') -- ����ó ��ȣ;
                    || RPAD(NVL(MI.EVIDENCE_CODE, ' '), 1, ' ')  -- �Ƿ������ڵ�;
                    || LPAD(NVL(MI.CREDIT_COUNT, 0) + NVL(MI.ETC_COUNT, 0), 5, 0) -- �Ǽ�;
                    || LPAD(NVL(MI.CREDIT_AMT, 0) + NVL(MI.ETC_AMT, 0), 11, 0) --  ���ޱݾ�;
                    || LPAD(REPLACE(MI.REPRE_NUM, '-', ''), 13, ' ') -- �Ƿ�� ���� ������� �ֹε�Ϲ�ȣ;
                    || RPAD(CASE
                              WHEN SUBSTR(REPLACE(MI.REPRE_NUM, '-', ''), 7, 1) BETWEEN '5' AND '8' THEN '9'
                              ELSE '1'
                            END, 1, 0) -- �Ƿ�� ���� ������� ��/�ܱ��� �ڵ�;
                    || RPAD(CASE
                              WHEN MI.RELATION_CODE = '0' OR 'Y' IN(MI.DISABILITY_YN, MI.OLD_YN) THEN '1'
                              ELSE '2'
                            END, 1, 0) -- ���ε� �ش翩��;
                    || RPAD(P_SUBMIT_PERIOD, 1, 0) -- (�����ջ� : 1, ��/����� ���� �������� : 2, ���� �������� : 3);
                    || RPAD(' ', 19, ' ') AS RECORD_FILE
                    , ROWNUM AS SORT_NUM
                  FROM HRA_MEDICAL_INFO MI
                    , HRM_PERSON_MASTER PM
                WHERE MI.PERSON_ID        = PM.PERSON_ID
                  AND MI.YEAR_YYYY        = P_YEAR_YYYY
                  AND MI.SOB_ID           = P_SOB_ID
                  AND MI.ORG_ID           = P_ORG_ID    
                  AND PM.CORP_ID          = P_CORP_ID              
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
        , P_SORT_NUM          => A1.SORT_NUM
        );
      --DBMS_OUTPUT.PUT_LINE(A1.RECORD_FILE);
    END LOOP A1; 
  END SET_MEDICAL_FILE_2012;

-------------------------------------------------------------------------------
-- 2012�⵵ ��α� ���ϻ���.
-------------------------------------------------------------------------------
  PROCEDURE SET_DONATION_FILE_2012
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
    V_SEQ_NUM                   NUMBER := 0;
    V_SOURCE_FILE               VARCHAR2(150);
    
    V_TAX_OFFICE_CODE           VARCHAR2(5);
    V_VAT_NUMBER                VARCHAR2(15);
    V_CORP_NAME                 VARCHAR2(50);
  BEGIN
--A1 ------------------------------------------------------------------------------------
    FOR A1 IN ( SELECT 'A'   -- �ڷ������ȣ.
                    || '27'  -- 27;
                    || LPAD(NVL(OU.TAX_OFFICE_CODE, ' '), 3, 0)  -- ������ �ڵ�;
                    || TO_CHAR(P_WRITE_DATE, 'YYYYMMDD')  -- �ڷḦ �������� �����ϴ� ������;
                    --> ������;
                    || LPAD(NVL(P_SUBMIT_AGENT, '2'), 1, 0)  -- �����ڱ���(�����븮��1, ����2, ����3);
                    || RPAD(NVL(P_TAX_AGENT, ' '), 6, ' ')  -- �����븮�� ������ȣ(�ڷ������ڰ� �����븮���ΰ�� ����);
                    || RPAD(NVL(P_HOMETAX_LOGIN_ID, ' '), 20, ' ')  -- Ȩ�ý�ID;
                    || RPAD(NVL(P_TAX_PROGRAM_CODE, '9000'), 4, ' ')  -- �������α׷��ڵ�;
                    || RPAD(NVL(REPLACE(OU.VAT_NUMBER, '-', ''), ' '), 10, ' ')  -- ����ڵ�Ϲ�ȣ;
                    || RPAD(NVL(CM.CORP_NAME, ' '), 40, ' ')  -- ���θ�(��ȣ);
                    || RPAD(NVL(S_PM.DEPT_NAME, ' '), 30, ' ')  -- �����(������) �μ�;
                    || RPAD(NVL(S_PM.NAME, ' '), 30, ' ')  -- �����(������) ����;
                    || RPAD(NVL(REPLACE(CM.TEL_NUMBER, '-', ''), ' '), 15, ' ')  -- �����(������) ��ȭ��ȣ;
                    --> ���⳻��.
                    || LPAD(1, 5, 0)  -- �Ű��ǹ��ڼ� (B���ڵ�);
                    || LPAD(NVL(P_USE_LANGUAGE_CODE, '101'), 3, 0)  -- ����ѱ��ڵ�;
                    || RPAD(' ', 2, ' ') AS RECORD_FILE
                    , NVL(OU.TAX_OFFICE_CODE, ' ') AS TAX_OFFICE_CODE
                    , NVL(REPLACE(OU.VAT_NUMBER, '-', ''), ' ') AS VAT_NUMBER
                    , NVL(CM.CORP_NAME, ' ') AS CORP_NAME
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
      
--B1 ------------------------------------------------------------------------------------
      FOR B1 IN ( -- ��α� ���޸���.
                  SELECT 'B' --AS RECORD_TYPE   -- �ڷ������ȣ(���ڵ� ����);
                      || '27' --AS DATA_TYPE     -- �ڷᱸ��(���� 27);
                      || RPAD(A1.TAX_OFFICE_CODE, 3, 0) -- �������ڵ�;
                      || LPAD(ROWNUM, 6, 0) -- �Ϸù�ȣ;
                      -- ��õ¡���ǹ���;
                      || RPAD(A1.VAT_NUMBER, 10, ' ') -- ����ڵ�Ϲ�ȣ;
                      || RPAD(A1.CORP_NAME, 40, ' ') -- ��ȣ��;
                      -- ���⳻��;
                      || LPAD(NVL(SX1.DONA_ADJUST_COUNT, 0), 7, 0) -- ��α����������ڵ��;
                      || LPAD(NVL(SX1.THIS_YEAR_COUNT, 0), 7, 0) -- �ش�⵵ ��α����������ڵ��;
                      || LPAD(NVL(SX1.TOTAL_DONA_AMT, 0), 13, 0)  -- ��αݾ� �Ѿ�.
                      || LPAD(NVL(SX1.TOTAL_DONA_DED_AMT, 0), 13, 0)  -- �������ݾ��Ѿ�;
                      || LPAD(NVL(P_SUBMIT_PERIOD, '1'), 1, 0) -- (�����ջ� : 1, ��/����� ���� �������� : 2, ���� �������� : 3);
                      || RPAD(' ', 77, ' ') AS RECORD_FILE
                    FROM (SELECT SUM(PX1.DONA_ADJUST_COUNT) AS DONA_ADJUST_COUNT
                               , SUM(PX1.THIS_YEAR_COUNT) AS THIS_YEAR_COUNT
                               , SUM(PX1.TOTAL_DONA_AMT) AS TOTAL_DONA_AMT
                               , SUM(PX1.TOTAL_DONA_DED_AMT) AS TOTAL_DONA_DED_AMT
                            FROM (SELECT COUNT(DA.PERSON_ID) AS DONA_ADJUST_COUNT
                                      , 0 AS THIS_YEAR_COUNT
                                      , SUM(DA.DONA_AMT) AS TOTAL_DONA_AMT
                                      , SUM(DA.TOTAL_DONA_AMT) AS TOTAL_DONA_DED_AMT
                                    FROM HRA_DONATION_ADJUSTMENT DA
                                      , HRM_PERSON_MASTER PM
                                  WHERE DA.PERSON_ID            = PM.PERSON_ID
                                    AND DA.YEAR_YYYY            = P_YEAR_YYYY
                                    AND DA.SOB_ID               = P_SOB_ID
                                    AND DA.ORG_ID               = P_ORG_ID
                                    AND PM.CORP_ID              = P_CORP_ID
                                 UNION ALL
                                 SELECT 0 AS DONA_ADJUST_COUNT
                                      , COUNT(DI.DONATION_INFO_ID) AS THIS_YEAR_COUNT
                                      , 0 AS TOTAL_DONA_AMT
                                      , 0 AS TOTAL_DONA_DED_AMT
                                    FROM HRA_DONATION_INFO DI
                                      , HRM_PERSON_MASTER PM
                                  WHERE DI.PERSON_ID            = PM.PERSON_ID
                                    AND DI.YEAR_YYYY            = P_YEAR_YYYY
                                    AND DI.SOB_ID               = P_SOB_ID
                                    AND DI.ORG_ID               = P_ORG_ID
                                    AND PM.CORP_ID              = P_CORP_ID
                                 ) PX1
                         ) SX1
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
--C2 ------------------------------------------------------------------------------------
        FOR C1 IN ( SELECT PM.PERSON_ID
                         , PM.CORP_ID
                         , P_YEAR_YYYY AS YEAR_YYYY
                         , PM.SOB_ID
                         , PM.ORG_ID
                         , ROW_NUMBER () OVER (ORDER BY PM.PERSON_NUM) AS SEQ_NO
                      FROM HRM_PERSON_MASTER PM
                    WHERE PM.CORP_ID        = P_CORP_ID
                      AND EXISTS
                            ( SELECT 'X'
                                FROM HRA_DONATION_ADJUSTMENT DA
                              WHERE DA.PERSON_ID      = PM.PERSON_ID
                                AND DA.YEAR_YYYY      = P_YEAR_YYYY
                                AND DA.SOB_ID         = P_SOB_ID
                                AND DA.ORG_ID         = P_ORG_ID
                            )
                    ORDER BY PM.PERSON_NUM
                  )
        LOOP
          FOR C2 IN ( -- ��α� ��������.
                      SELECT 'C' -- �ڷ������ȣ(���ڵ� ����);
                          || '27' -- �ڷᱸ��(���� 27);
                          || LPAD(A1.TAX_OFFICE_CODE, 3, 0) -- �������ڵ�;
                          || LPAD(C1.SEQ_NO, 6, 0)   -- �Ϸù�ȣ.
                              -- �Ϸù�ȣ;
  /*                              || LPAD(ROWNUM, 6, 0) --AS SEQ_NO    -- �Ϸù�ȣ;*/
                          || RPAD(A1.VAT_NUMBER, 10, ' ') -- ����ڵ�Ϲ�ȣ;
                          || RPAD(REPLACE(PM.REPRE_NUM, '-', ''), 13, ' ') -- �ҵ����� �ֹε�Ϲ�ȣ;
                          || RPAD(CASE
                                    WHEN SUBSTR(REPLACE(PM.REPRE_NUM, '-', ''), 7, 1) BETWEEN '5' AND '8' THEN '9'
                                    ELSE '1'
                                  END, 1, 0) -- ���ܱ��� �����ڵ�;
                          || RPAD(PM.NAME, 30, ' ') -- �ҵ����� ����;
                          || RPAD(NVL(DA.DONA_TYPE, ' '), 2, ' ') -- ����ڵ�;
                          || LPAD(DA.DONA_YYYY, 4, 0)           -- ��γ⵵;
                          || LPAD(NVL(DA.DONA_AMT, 0), 13, 0) -- ��αݾ�(�����,���ó��,������ �ջ�);
                          || LPAD(NVL(DA.PRE_DONA_DED_AMT, 0), 13, 0) -- ������� ������ �ݾ�;
                          || LPAD(NVL(DA.TOTAL_DONA_AMT, 0), 13, 0) -- �������ݾ�;
                          || LPAD(NVL(DA.DONA_DED_AMT, 0), 13, 0)    -- �ش�⵵ �����ݾ�;
                          || LPAD(NVL(DA.LAPSE_DONA_AMT, 0), 13, 0)    -- �ش�⵵ �Ҹ�ݾ�;
                          || LPAD(NVL(DA.NEXT_DONA_AMT, 0), 13, 0)    -- �ش�⵵ �̿��ݾ�;
                          || LPAD(ROW_NUMBER() OVER(PARTITION BY PM.PERSON_NUM ORDER BY PM.PERSON_NUM, DA.YEAR_YYYY), 5, 0)         -- ��α������� �Ϸù�ȣ;
                          || RPAD(' ', 25, ' ') AS RECORD_FILE
                          , DA.YEAR_YYYY AS YEAR_YYYY
                          , PM.PERSON_ID
                          , DA.DONA_TYPE
                          , ROW_NUMBER() OVER(PARTITION BY PM.PERSON_NUM ORDER BY PM.PERSON_NUM, DA.YEAR_YYYY) AS SORT_NUM
                        FROM HRM_PERSON_MASTER PM
                          , HRA_DONATION_ADJUSTMENT DA
                      WHERE PM.PERSON_ID      = DA.PERSON_ID
                        AND PM.CORP_ID        = C1.CORP_ID
                        AND DA.YEAR_YYYY      = C1.YEAR_YYYY
                        AND DA.SOB_ID         = C1.SOB_ID
                        AND DA.ORG_ID         = C1.ORG_ID
                        AND DA.PERSON_ID      = C1.PERSON_ID
                      ORDER BY PM.PERSON_NUM, DA.YEAR_YYYY
                    ) 
          LOOP
            V_SEQ_NUM := NVL(V_SEQ_NUM, 0) + 1;
            V_SOURCE_FILE := 'C_RECORD';
            INSERT_REPORT_FILE
              ( P_SEQ_NUM           => V_SEQ_NUM
              , P_SOURCE_FILE       => V_SOURCE_FILE
              , P_SOB_ID            => P_SOB_ID
              , P_ORG_ID            => P_ORG_ID
              , P_REPORT_FILE       => C2.RECORD_FILE
              , P_SORT_NUM          => C2.SORT_NUM
              );
          END LOOP C2;
  --D1 ------------------------------------------------------------------------------------
          FOR D1 IN ( -- ��α� ����.
                      SELECT 'D' -- �ڷ������ȣ(���ڵ� ����);
                          || '27' -- �ڷᱸ��(���� 27);
                          || LPAD(A1.TAX_OFFICE_CODE, 3, 0) -- �������ڵ�;
                          || LPAD(C1.SEQ_NO, 6, 0)    -- �Ϸù�ȣ;
                          || RPAD(A1.VAT_NUMBER, 10, ' ') -- ����ڵ�Ϲ�ȣ;
                          || RPAD(REPLACE(PM.REPRE_NUM, '-', ''), 13, ' ') -- �ҵ����� �ֹε�Ϲ�ȣ;
                          || RPAD(NVL(DI.DONA_TYPE, ' '), 2, ' ') -- ����ڵ�;
                          || RPAD(NVL(REPLACE(DI.CORP_TAX_REG_NO, '-', ''), ' '), 13, ' ') -- ���ó �����Ϲ�ȣ;
                          || RPAD(NVL(DI.CORP_NAME, ' '), 30, ' ') -- ���ó ��ȣ;
                          || RPAD(NVL(CASE 
                                        WHEN DI.RELATION_CODE = '0' THEN '1'
                                        WHEN DI.RELATION_CODE = '3' THEN '2'
                                        WHEN DI.RELATION_CODE IN('4', '5') THEN '3'
                                        WHEN DI.RELATION_CODE IN('1', '2') THEN '4'
                                        WHEN DI.RELATION_CODE IN('6') THEN '5'
                                        ELSE '6'
                                      END, ' '), 1, ' ') -- ����ڿ��� ����;
                          || RPAD(CASE
                                    WHEN SUBSTR(REPLACE(DI.REPRE_NUM, '-', ''), 7, 1) BETWEEN '5' AND '8' THEN '9'
                                    ELSE '1'
                                  END, 1, ' ') --  ��/�ܱ��� �ڵ�;
                          || RPAD(NVL(DI.FAMILY_NAME, ' '), 20, ' ') -- ����;
                          || RPAD(NVL(REPLACE(DI.REPRE_NUM, '-', ''), ' '), 13, ' ') -- ����� �ֹε�Ϲ�ȣ;
                          || LPAD(NVL(DI.DONA_COUNT, 0), 5, 0) --���Ƚ��(�����,���ó��,������ �ջ�);
                          || LPAD(NVL(DI.DONA_AMT, 0), 13, 0) -- ��α�(�����,���ó��,������ �ջ�);/*|| LPAD(I_YEAR_YYYY || '0101', 8, 0) --AS TAX_PERIOD_START
                          || LPAD(ROW_NUMBER() OVER(PARTITION BY PM.PERSON_NUM ORDER BY PM.PERSON_NUM), 5, 0)
                          --|| LPAD(C1.SORT_NUM, 5, 0)         -- ��α������� �Ϸù�ȣ;
                          || RPAD(' ', 42, ' ') AS RECORD_FILE
                          , ROW_NUMBER() OVER(PARTITION BY PM.PERSON_NUM ORDER BY PM.PERSON_NUM) AS SORT_NUM
                        FROM HRM_PERSON_MASTER PM
                          , HRA_DONATION_INFO DI
                      WHERE PM.PERSON_ID    = DI.PERSON_ID
                        AND DI.YEAR_YYYY    = C1.YEAR_YYYY
                        AND DI.SOB_ID       = C1.SOB_ID
                        AND DI.ORG_ID       = C1.ORG_ID
                        AND DI.PERSON_ID    = C1.PERSON_ID
--                        AND DI.DONA_TYPE    = C1.DONA_TYPE
                      ORDER BY PM.PERSON_NUM
                     ) 
          LOOP
            V_SOURCE_FILE := 'D_RECORD';
            INSERT_REPORT_FILE
              ( P_SEQ_NUM           => V_SEQ_NUM
              , P_SOURCE_FILE       => V_SOURCE_FILE
              , P_SOB_ID            => P_SOB_ID
              , P_ORG_ID            => P_ORG_ID
              , P_REPORT_FILE       => D1.RECORD_FILE
              , P_SORT_NUM          => C1.SEQ_NO + (0.00001 * D1.SORT_NUM)
              );
          END LOOP D1;
        END LOOP C1;
      END LOOP B1;
    END LOOP A1; 
  END SET_DONATION_FILE_2012;

-------------------------------------------------------------------------------
-- 2013�⵵ �ٷμҵ� ���ϻ���.
-------------------------------------------------------------------------------
  PROCEDURE SET_YEAR_ADJUST_FILE_2013_1
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
    V_G_REC_STD                 CONSTANT NUMBER := 3;    
    V_SEQ_NO                    NUMBER;          -- ���ڵ� ���� ��ȣ.
    V_RECORD_FILE               VARCHAR2(3000);  -- �ξ簡�� ��������.
    
    V_REC_TEMP_1                VARCHAR2(300);   
    V_REC_TEMP_2                VARCHAR2(300);   
  BEGIN
    
    -- �����ü ����--.
--A1 ------------------------------------------------------------------------------------
    FOR A1 IN ( SELECT 'A'   -- �ڷ������ȣ.
                    || '20'  -- �����ٷμҵ�(20);
                    || LPAD(REPLACE(OU.TAX_OFFICE_CODE, '-', ''), 3, 0)  -- ������ �ڵ�;
                    || TO_CHAR(P_WRITE_DATE, 'YYYYMMDD')  -- �ڷḦ �������� �����ϴ� ������;
                    --> ������;
                    || LPAD(NVL(P_SUBMIT_AGENT, '2'), 1, 0)  -- �����ڱ���(�����븮��1, ����2, ����3);
                    || RPAD(NVL(P_TAX_AGENT, ' '), 6, ' ')  -- �����븮�� ������ȣ(�ڷ������ڰ� �����븮���ΰ�� ����);
                    || RPAD(NVL(P_HOMETAX_LOGIN_ID, ' '), 20, ' ')  -- Ȩ�ý�ID;
                    || RPAD(NVL(P_TAX_PROGRAM_CODE, '1001'), 4, ' ')  -- �������α׷��ڵ�;
                    || RPAD(NVL(REPLACE(OU.VAT_NUMBER, '-', ''), ' '), 10, ' ')  -- ����ڵ�Ϲ�ȣ;
                    || RPAD(NVL(REPLACE(CM.CORP_NAME, ' ', ''), ' '), 40, ' ')  -- ���θ�(��ȣ);
                    || RPAD(NVL(REPLACE(S_PM.DEPT_NAME, ' ', ''), ' '), 30, ' ')  -- �����(������) �μ�;
                    || RPAD(NVL(REPLACE(S_PM.NAME, ' ', ''), ' '), 30, ' ')  -- �����(������) ����;
                    || RPAD(NVL(REPLACE(CM.TEL_NUMBER, '-', ''), ' '), 15, ' ')  -- �����(������) ��ȭ��ȣ;
                    --> ���⳻��.
                    || LPAD(1, 5, 0)  -- �Ű��ǹ��ڼ� (B���ڵ�);
                    || LPAD(NVL(P_USE_LANGUAGE_CODE, '101'), 3, 0)  -- ����ѱ��ڵ�;
                    || RPAD(' ', 1222, ' ') AS RECORD_FILE
                    , CM.CORP_NAME  -- ���θ�.
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
                      || '20'  -- �����ٷμҵ�(20);
                      || LPAD(REPLACE(OU.TAX_OFFICE_CODE, '-', ''), 3, 0)   -- �������ڵ�; 
                      || LPAD(1, 6, 0)                                      -- B���ڵ��� �Ϸù�ȣ;
                      --> ������;
                      || RPAD(NVL(REPLACE(OU.VAT_NUMBER, '-', ''), ' '), 10, ' ')  -- ��õ¡���ǹ����� ����ڵ�Ϲ�ȣ;
                      || RPAD(NVL(REPLACE(CM.CORP_NAME, ' ', ''), ' '), 40, ' ')  -- ���θ�(��ȣ);
                      || RPAD(NVL(REPLACE(CM.PRESIDENT_NAME, ' ', ''), ' '), 30, ' ')  -- ��ǥ�� ����;
                      || RPAD(NVL(REPLACE(CM.LEGAL_NUMBER, '-', ''), ' '), 13, ' ') -- ���ε�Ϲ�ȣ;
                      --> ���⳻��;
                      || LPAD(NVL(S_YA.NOW_WORKER_COUNT, 0), 7, 0)   -- 9.������ C���ڵ��� ��(�ٷμҵ����� ��);
                      || LPAD(NVL(S_YA.PRE_WORKER_COUNT, 0), 7, 0)   -- 10.������ D���ڵ�(���ٹ�ó)�� ��(C���ڵ� �׸�6�� �հ�)
                      || LPAD(NVL(S_YA.INCOME_TOT_AMT, 0), 14, 0)    -- 11.�ѱ޿� �Ѱ�(C���ڵ� �޿� ��);
                      || LPAD(NVL(S_YA.FIX_IN_TAX, 0), 13, 0)        -- �ҵ漼 �������� �Ѱ�(C���ڵ� �ҵ漼�� ��);
                      || LPAD(NVL(S_YA.FIX_LOCAL_TAX, 0), 13, 0)     -- �ֹμ� �������� �Ѱ�;
                      || LPAD(NVL(S_YA.FIX_SP_TAX, 0), 13, 0)        -- ��Ư�� �������� �Ѱ�;
                      || LPAD(NVL(S_YA.FIX_TOTAL_TAX, 0) - NVL(S_YA.FIX_LEGAL_TAX, 0), 13, 0)  -- �������� �Ѱ�;
                      -- LPAD(NVL(S_YA.FIX_TOTAL_TAX, 0), 13, 0)  -- �������� �Ѱ� : 2009�� �������� ���� ���������Ѱ�-���μ� �������� �Ѱ�;
                      || LPAD(NVL(P_SUBMIT_PERIOD, '1'), 1, 0)   -- (�����ջ� : 1, ��/����� ���� �������� : 2, ���� �������� : 3);
                      || RPAD(' ', 1214, ' ') AS RECORD_FILE
                      , LPAD(REPLACE(OU.TAX_OFFICE_CODE, '-', ''), 3, 0) AS TAX_OFFICE_CODE
                      , RPAD(NVL(REPLACE(OU.VAT_NUMBER, '-', ''), ' '), 10, ' ') AS VAT_NUMBER
                    FROM HRM_CORP_MASTER CM
                       , HRM_OPERATING_UNIT OU
                       , ( -- ���⳻��.
                           SELECT YA.YEAR_YYYY
                               , COUNT(YA.PERSON_ID) AS NOW_WORKER_COUNT
                               , NVL(S_PW.PRE_WORK_COUNT, 0) AS PRE_WORKER_COUNT
                               , SUM(CASE
                                       WHEN NVL(YA.FOREIGN_FIX_TAX_YN, 'N') = 'N' THEN YA.INCOME_TOT_AMT
                                       ELSE (NVL(YA.NOW_PAY_TOT_AMT, 0) + NVL(YA.NOW_BONUS_TOT_AMT, 0) +
                                             NVL(YA.NOW_ADD_BONUS_AMT, 0) + NVL(YA.NOW_STOCK_BENE_AMT, 0) +
                                             NVL(YA.PRE_PAY_TOT_AMT, 0) + NVL(YA.PRE_BONUS_TOT_AMT, 0) +
                                             NVL(YA.PRE_ADD_BONUS_AMT, 0) + NVL(YA.PRE_STOCK_BENE_AMT, 0) +
                                             NVL(YA.INCOME_OUTSIDE_AMT, 0) +
                                             NVL(YA.NOW_EMPLOYEE_STOCK_AMT, 0) + NVL(YA.NOW_OFFICE_RETIRE_OVER_AMT, 0) +
                                             NVL(YA.PRE_EMPLOYEE_STOCK_AMT, 0) + NVL(YA.PRE_OFFICE_RETIRE_OVER_AMT, 0) + 
                                             -- ����� 
                                             NVL(YA.NONTAX_OUTSIDE_AMT, 0) + NVL(YA.NONTAX_OT_AMT, 0) +  
                                             NVL(YA.NONTAX_RESEA_AMT, 0) + NVL(YA.NONTAX_ETC_AMT, 0) +
                                             NVL(YA.NONTAX_BIRTH_AMT, 0) + NVL(YA.NONTAX_FOREIGNER_AMT, 0) +
                                             NVL(YA.NONTAX_SCH_EDU_AMT, 0) + NVL(YA.NONTAX_MEMBER_AMT, 0) +
                                             NVL(YA.NONTAX_GUARD_AMT, 0) + NVL(YA.NONTAX_CHILD_AMT, 0) + 
                                             NVL(YA.NONTAX_HIGH_SCH_AMT, 0) + NVL(YA.NONTAX_SPECIAL_AMT, 0) +
                                             NVL(YA.NONTAX_RESEARCH_AMT, 0) + NVL(YA.NONTAX_COMPANY_AMT, 0) + 
                                             NVL(YA.NONTAX_COVER_AMT, 0) + NVL(YA.NONTAX_WILD_AMT, 0) + 
                                             NVL(YA.NONTAX_DISASTER_AMT, 0) + NVL(YA.NONTAX_OUTS_GOVER_AMT, 0) + 
                                             NVL(YA.NONTAX_OUTS_ARMY_AMT, 0) + NVL(YA.NONTAX_OUTS_WORK_1, 0) + 
                                             NVL(YA.NONTAX_OUTS_WORK_2, 0) + NVL(YA.NONTAX_STOCK_BENE_AMT, 0) + 
                                             NVL(YA.NONTAX_FOR_ENG_AMT, 0) + NVL(YA.NONTAX_EMPL_STOCK_AMT, 0) + 
                                             NVL(YA.NONTAX_EMPL_BENE_AMT_1, 0) + NVL(YA.NONTAX_EMPL_BENE_AMT_2, 0) + 
                                             NVL(YA.NONTAX_HOUSE_SUBSIDY_AMT, 0) + NVL(YA.NONTAX_SEA_RESOURCE_AMT, 0) +
                                             -- ����-- 
                                             NVL(YA.PRE_NT_OUTSIDE_AMT, 0) + NVL(YA.PRE_NT_OT_AMT, 0) +  
                                             NVL(YA.PRE_NT_RESEA_AMT, 0) + NVL(YA.PRE_NT_ETC_AMT, 0) +
                                             NVL(YA.PRE_NT_BIRTH_AMT, 0) + NVL(YA.PRE_NT_FOREIGNER_AMT, 0) +
                                             NVL(YA.PRE_NT_SCH_EDU_AMT, 0) + NVL(YA.PRE_NT_MEMBER_AMT, 0) +
                                             NVL(YA.PRE_NT_GUARD_AMT, 0) + NVL(YA.PRE_NT_CHILD_AMT, 0) + 
                                             NVL(YA.PRE_NT_HIGH_SCH_AMT, 0) + NVL(YA.PRE_NT_SPECIAL_AMT, 0) +
                                             NVL(YA.PRE_NT_RESEARCH_AMT, 0) + NVL(YA.PRE_NT_COMPANY_AMT, 0) + 
                                             NVL(YA.PRE_NT_COVER_AMT, 0) + NVL(YA.PRE_NT_WILD_AMT, 0) + 
                                             NVL(YA.PRE_NT_DISASTER_AMT, 0) + NVL(YA.PRE_NT_OUTS_GOVER_AMT, 0) + 
                                             NVL(YA.PRE_NT_OUTS_ARMY_AMT, 0) + NVL(YA.PRE_NT_OUTS_WORK_1, 0) + 
                                             NVL(YA.PRE_NT_OUTS_WORK_2, 0) + NVL(YA.PRE_NT_STOCK_BENE_AMT, 0) + 
                                             NVL(YA.PRE_NT_FOR_ENG_AMT, 0) + NVL(YA.PRE_NT_EMPL_STOCK_AMT, 0) + 
                                             NVL(YA.PRE_NT_EMPL_BENE_AMT_1, 0) + NVL(YA.PRE_NT_EMPL_BENE_AMT_2, 0) + 
                                             NVL(YA.PRE_NT_HOUSE_SUBSIDY_AMT, 0) + NVL(YA.PRE_NT_SEA_RESOURCE_AMT, 0))
                                     END) AS INCOME_TOT_AMT  -- 
                               , SUM(YA.FIX_IN_TAX_AMT) FIX_IN_TAX
                               , 0 AS FIX_LEGAL_TAX
                               , SUM(YA.FIX_LOCAL_TAX_AMT) FIX_LOCAL_TAX
                               , SUM(YA.FIX_SP_TAX_AMT) FIX_SP_TAX
                               , SUM(NVL(YA.FIX_IN_TAX_AMT, 0) +
                                     NVL(YA.FIX_LOCAL_TAX_AMT, 0) +
                                     NVL(YA.FIX_SP_TAX_AMT, 0)) FIX_TOTAL_TAX
                             FROM HRA_YEAR_ADJUSTMENT YA
                               , HRM_PERSON_MASTER    PM
                               , ( -- �����ٹ��� �ڷ��.
                                  SELECT PW.YEAR_YYYY
                                       , COUNT(PW.PERSON_ID) AS PRE_WORK_COUNT
                                    FROM HRA_YEAR_ADJUSTMENT YA
                                      , HRA_PREVIOUS_WORK PW
                                      , HRM_PERSON_MASTER PM
                                   WHERE YA.YEAR_YYYY       = PW.YEAR_YYYY
                                     AND YA.PERSON_ID       = PW.PERSON_ID
                                     AND PW.PERSON_ID       = PM.PERSON_ID
                                     AND PW.YEAR_YYYY       = P_YEAR_YYYY
                                     AND PM.CORP_ID         = P_CORP_ID
                                     AND PW.SOB_ID          = P_SOB_ID
                                     AND PW.ORG_ID          = P_ORG_ID
                                     AND YA.SUBMIT_DATE     BETWEEN P_START_DATE AND P_END_DATE
                                     AND NVL(YA.INCOME_TOT_AMT, 0) != 0
                                     AND YA.ADJUST_DATE_TO  BETWEEN P_START_DATE AND P_END_DATE
                                   GROUP BY PW.YEAR_YYYY
                                  ) S_PW
                            WHERE YA.PERSON_ID      = PM.PERSON_ID
                              AND YA.YEAR_YYYY      = S_PW.YEAR_YYYY(+)
                              AND YA.CORP_ID        = P_CORP_ID
                              AND YA.YEAR_YYYY      = P_YEAR_YYYY
                              AND YA.SOB_ID         = P_SOB_ID
                              AND YA.ORG_ID         = P_ORG_ID
                              AND YA.SUBMIT_DATE    BETWEEN P_START_DATE AND P_END_DATE
                              AND NVL(YA.INCOME_TOT_AMT, 0) != 0
                              AND YA.ADJUST_DATE_TO BETWEEN P_START_DATE AND P_END_DATE
                            GROUP BY YA.YEAR_YYYY
                                  , NVL(S_PW.PRE_WORK_COUNT, 0)
                         ) S_YA
                    WHERE CM.CORP_ID        = OU.CORP_ID
                      AND P_YEAR_YYYY       = S_YA.YEAR_YYYY
                      AND CM.ENABLED_FLAG   = 'Y'
                      AND (OU.DEFAULT_FLAG  = 'Y'
                      OR (OU.DEFAULT_FLAG   = 'N'
                      AND ROWNUM            <= 1))
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
                        || '20'                                         -- 2.AS DATA_TYPE
                        || RPAD(NVL(B1.TAX_OFFICE_CODE, ' '), 3, ' ')   -- 3.�������ڵ�.
                        || LPAD(ROW_NUMBER() OVER(PARTITION BY YA.YEAR_YYYY ORDER BY PM.PERSON_NUM), 6, 0)   -- 4.�Ϸù�ȣ.
                        || LPAD(NVL(B1.VAT_NUMBER, ' '), 10, ' ')       -- 5.����ڹ�ȣ.
                        || LPAD(NVL(S_PW.PRE_WORK_COUNT, 0), 2, 0)      -- 6.��(��)�ٹ�ó ��;
                        || LPAD(NVL(PM.RESIDENT_TYPE, '1'), 1, 0)       -- 7.������ �����ڵ�(������:1, �������:2);
                        || RPAD(CASE 
                                  WHEN PM.RESIDENT_TYPE = '1' THEN ' '
                                  WHEN SUBSTR(REPLACE(PM.REPRE_NUM, '-', ''), 7, 1) BETWEEN '1' AND '4' THEN ' '  -- 1900, 2000���.
                                  WHEN SUBSTR(REPLACE(PM.REPRE_NUM, '-', ''), 7, 1) BETWEEN '9' AND '0' THEN ' '  -- 1800����..
                                  ELSE NVL(S_HN.ISO_NATION_CODE, ' ')
                                END, 2, ' ')  -- 8.�ű����� �ڵ� : ������ڸ� ���, �����ڴ� ����;
                        || LPAD(DECODE(NVL(YA.FOREIGN_FIX_TAX_YN, 'N'), 'Y', 1, 2), 1, 0)  -- 9.�ܱ��δ��ϼ�������(����:1, ������:2);
                        || RPAD(NVL(REPLACE(PM.NAME, ' ', ''), ' '), 30, ' ')  -- 10.����;
                        || RPAD(CASE
                                  WHEN PM.NATIONALITY_TYPE IS NOT NULL THEN PM.NATIONALITY_TYPE
                                  WHEN SUBSTR(REPLACE(PM.REPRE_NUM, '-', ''), 7, 1) BETWEEN '5' AND '8' THEN '9'
                                  ELSE '1'
                                END, 1, 0)  -- 11.��/�ܱ��� �����ڵ�;
                        || RPAD(NVL(REPLACE(PM.REPRE_NUM, '-', ''), ' '), 13, ' ')  -- 12.�ֹε�Ϲ�ȣ;
                        || RPAD(CASE
                                  WHEN PM.NATIONALITY_TYPE = '9' THEN NVL(S_HN.ISO_NATION_CODE, ' ')
                                  WHEN SUBSTR(REPLACE(PM.REPRE_NUM, '-', ''), 7, 1) BETWEEN '5' AND '8' THEN NVL(S_HN.ISO_NATION_CODE, ' ')
                                  ELSE ' '
                                END, 2, ' ')  -- 13.�����ڵ�(�ܱ����� ��츸 ����);
                        || RPAD(NVL(PM.HOUSEHOLD_TYPE, '1'), 1, 0)  -- 14.�����ֿ���.
                        || RPAD(CASE 
                                  WHEN (PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE > TO_DATE(P_YEAR_YYYY||'-12-31','YYYY-MM-DD')) THEN '1'
                                  ELSE '2' 
                                END, 1, 0)  -- 15.�������걸��(��ӱٷ�: 1, �ߵ����:2).
                        || RPAD(NVL(B1.VAT_NUMBER, ' '), 10, ' ')  -- 16.�����ٹ�ó ����ڵ�Ϲ�ȣ;
                        || RPAD(NVL(A1.CORP_NAME, ' '), 40, ' ')  -- 17.�����ٹ�ó ���θ�(��ȣ);
                        || RPAD(TO_CHAR(YA.ADJUST_DATE_FR, 'YYYYMMDD'), 8, 0)  -- 18.�ٹ��Ⱓ ���ۿ�����;
                        || RPAD(TO_CHAR(YA.ADJUST_DATE_TO, 'YYYYMMDD'), 8, 0)  -- 19.�ٹ��Ⱓ ���Ῥ����;
                        || LPAD(0, 8, 0)  -- 20.����Ⱓ ���ۿ�����;
                        || LPAD(0, 8, 0)  -- 21.����Ⱓ ���Ῥ����;
                        --> �ٹ�ó�� �ҵ��-��(��)�ٹ�ó �ѱ޿�.
                        || LPAD(NVL(YA.NOW_PAY_TOT_AMT, 0)+ 
                                NVL(YA.INCOME_OUTSIDE_AMT, 0), 11, 0)  -- 22.�޿��Ѿ�;
                        || LPAD(NVL(YA.NOW_BONUS_TOT_AMT, 0), 11, 0) -- 23.���Ѿ�;
                        || LPAD(NVL(YA.NOW_ADD_BONUS_AMT, 0), 11, 0) -- 24.������;
                        || LPAD(NVL(YA.NOW_STOCK_BENE_AMT, 0), 11, 0) -- 25.�ֽĸż����ñ��������;
                        ----> 2009�� �������� ����(�츮������������� �߰�);
                        || LPAD(0, 11, 0) -- 26.�츮�������������(�迡�� �������� �ʾ���);
                        || LPAD(NVL(YA.NOW_OFFICE_RETIRE_OVER_AMT, 0), 11, 0)  -- 27.2013�⵵ �߰� : �ӿ� �����ҵ�ݾ� �ѵ��ʰ���  
                        || LPAD(0, 22, 0) -- 28.����;
                        || LPAD(NVL(YA.NOW_PAY_TOT_AMT, 0) +
                                NVL(YA.NOW_BONUS_TOT_AMT, 0) +
                                NVL(YA.NOW_ADD_BONUS_AMT, 0) +
                                NVL(YA.NOW_STOCK_BENE_AMT, 0) + 
                                NVL(YA.INCOME_OUTSIDE_AMT, 0) +
                                NVL(YA.NOW_OFFICE_RETIRE_OVER_AMT, 0), 11, 0) -- 29.�޿��Ѿ�(�׸�22)+���Ѿ�(�׸�23)+������(�׸�24)+ �ֽĸż����ñ��������(�׸�25)+�츮�������������(�׸�26)+ �ӿ������ҵ��ѵ��ʰ���(�׸�27)
                        --> ��(��)�ٹ�ó ����� �ҵ�.
                        -- 2009�� �������� ����(��(��)�ٹ�ó ����� �ҵ� ����);
                        || LPAD(NVL(YA.NONTAX_SCH_EDU_AMT, 0), 10, 0) -- 30.�����-���ڱ�;
                        || LPAD(NVL(YA.NONTAX_MEMBER_AMT, 0), 10, 0) -- 31.�����-��������������;
                        || LPAD(NVL(YA.NONTAX_GUARD_AMT, 0), 10, 0) -- 32.�����-��ȣ/�¼�����;
                        || LPAD(NVL(YA.NONTAX_CHILD_AMT, 0), 10, 0) -- 33.�����-����/���ߵ�_��������/Ȱ����;
                        || LPAD(NVL(YA.NONTAX_HIGH_SCH_AMT, 0), 10, 0) -- 34.�����-����_��������/Ȱ����;
                        || LPAD(NVL(YA.NONTAX_SPECIAL_AMT, 0), 10, 0) -- 35.�����-Ư���������������_��������/Ȱ����;
                        || LPAD(NVL(YA.NONTAX_RESEARCH_AMT, 0), 10, 0) -- 36.�����-�������_��������/Ȱ����;
                        || LPAD(NVL(YA.NONTAX_COMPANY_AMT, 0), 10, 0) -- 37.�����-���������_��������/Ȱ����;
                        -- ��ȣ�� : 2012�⵵ �߰� BEGIN --
                        || LPAD(0, 10, 0)  -- 38.����� : �������� �ٹ�ȯ�氳����.
                        || LPAD(0, 10, 0)  -- 39.����� : �縳��ġ�� ��������/������ �ΰǺ�.
                        -- END --
                        || LPAD(NVL(YA.NONTAX_COVER_AMT, 0), 10, 0) -- 40.�����-�������;
                        || LPAD(NVL(YA.NONTAX_WILD_AMT, 0), 10, 0) -- 41.�����-��������;
                        || LPAD(NVL(YA.NONTAX_DISASTER_AMT, 0), 10, 0) -- 42.�����-���ذ��ñ޿�;
                        || LPAD(0, 10, 0)  -- 43.2013�⵵ �߰� : ����/�������  ����������� ������ ���ּ���; 
                        || LPAD(NVL(YA.NONTAX_OUTS_GOVER_AMT, 0), 10, 0) -- 44.�����-�ܱ����ε�ٹ���;
                        || LPAD(NVL(YA.NONTAX_OUTS_ARMY_AMT, 0), 10, 0) -- 45.�����-�ܱ��ֵб��ε�;
                        || LPAD(NVL(YA.NONTAX_OUTS_WORK_1, 0), 10, 0) -- 46.�����-���ܱٷ�(100����);
                        || LPAD(NVL(YA.NONTAX_OUTS_WORK_2, 0), 10, 0) -- 47.���ܱٷ�200����(300����);
                        || LPAD(NVL(YA.NONTAX_OUTSIDE_AMT, 0), 10, 0) -- 48.����� ���ܼҵ�;
                        || LPAD(NVL(YA.NONTAX_OT_AMT, 0), 10, 0) -- 49.����� �߰��ٷ�;
                        || LPAD(NVL(YA.NONTAX_BIRTH_AMT, 0), 10, 0) -- 50.����� ���/��������;
                        || LPAD(0, 10, 0)  -- 51.�ٷ����б�.
                        || LPAD(NVL(YA.NONTAX_STOCK_BENE_AMT, 0), 10, 0) -- 52.�����-�ֽĸż����ñ�;
                        || LPAD(NVL(YA.NONTAX_FOR_ENG_AMT, 0), 10, 0) -- 53.�����-�ܱ��α����;
                        || LPAD(NVL(YA.NONTAX_EMPL_BENE_AMT_1, 0), 10, 0) -- 54.�����-�츮�������������(50%);
                        || LPAD(NVL(YA.NONTAX_EMPL_BENE_AMT_2, 0), 10, 0) -- 55.�����-�츮�������������(75%);
                        || LPAD(0, 10, 0) -- 56.�����-��������� �߼ұ�� ���;
                        --|| LPAD(NVL(YA.NONTAX_HOUSE_SUBSIDY_AMT, 0), 10, 0) -- �����-�����ڱݺ�����(X);
                        || LPAD(NVL(YA.NONTAX_SEA_RESOURCE_AMT, 0), 10, 0) -- 57.�����-���������ڿ�����;
                        -- ��ȣ�� �߰� : 2012�⵵ ���� BEGIN --
                        || LPAD(0, 10, 0)  -- 58.�����Ǽ��ú�������.
                        || LPAD(0, 10, 0)  -- 59.�߼ұ�� ��� û�� �ҵ漼 ����;
                        || LPAD(0, 10, 0)  -- 60.��������� ������ ����;
                        --|| LPAD(0, 10, 0) -- ���������;
                        -- ��ȣ�� �߰� : 2012�⵵ ���� END --
                        -- ����� ��;
                        || LPAD((NVL(YA.NONTAX_SCH_EDU_AMT, 0) +
                                NVL(YA.NONTAX_MEMBER_AMT, 0) +
                                NVL(YA.NONTAX_GUARD_AMT, 0) +
                                NVL(YA.NONTAX_CHILD_AMT, 0) +
                                NVL(YA.NONTAX_HIGH_SCH_AMT, 0) +
                                NVL(YA.NONTAX_SPECIAL_AMT, 0) +
                                NVL(YA.NONTAX_RESEARCH_AMT, 0) +
                                NVL(YA.NONTAX_COMPANY_AMT, 0) +
                                NVL(YA.NONTAX_COVER_AMT, 0) +
                                NVL(YA.NONTAX_WILD_AMT, 0) +
                                NVL(YA.NONTAX_DISASTER_AMT, 0) +
                                NVL(YA.NONTAX_OUTS_GOVER_AMT, 0) +
                                NVL(YA.NONTAX_OUTS_ARMY_AMT, 0) +
                                NVL(YA.NONTAX_OUTS_WORK_1, 0) +
                                NVL(YA.NONTAX_OUTS_WORK_2, 0) +
                                NVL(YA.NONTAX_OUTSIDE_AMT, 0) +
                                NVL(YA.NONTAX_OT_AMT, 0) +
                                NVL(YA.NONTAX_BIRTH_AMT, 0) +
                                --NVL(YA.NONTAX_FOREIGNER_AMT, 0) +
                                --NVL(YA.NONTAX_EMPL_STOCK_AMT, 0) +
                                NVL(YA.NONTAX_EMPL_STOCK_AMT, 0) +
                                --NVL(YA.NONTAX_FOR_ENG_AMT, 0) +  -- �ܱ��� �����(����ҵ� ��� �̵�);
                                NVL(YA.NONTAX_EMPL_BENE_AMT_1, 0) +
                                NVL(YA.NONTAX_EMPL_BENE_AMT_2, 0)) 
                                --NVL(YA.NONTAX_HOUSE_SUBSIDY_AMT, 0) +                       
                                --NVL(YA.NONTAX_SEA_RESOURCE_AMT, 0))  -- ���������ڿ�����(����ҵ� ��� �̵�);
                                --NVL(YA.NONTAX_ETC_AMT, 0),
                                , 10, 0)  -- 61.�������.
                        || LPAD(NVL(YA.NONTAX_FOR_ENG_AMT, 0) + NVL(YA.NONTAX_SEA_RESOURCE_AMT, 0), 10, 0)    -- 62����ҵ��(�׸�53 + �׸�57);
                        --> �����.
                        || LPAD( CASE
                                   WHEN NVL(YA.FOREIGN_FIX_TAX_YN, 'N') = 'N' THEN NVL(YA.INCOME_TOT_AMT, 0)
                                   ELSE (NVL(YA.NOW_PAY_TOT_AMT, 0) + NVL(YA.NOW_BONUS_TOT_AMT, 0) +
                                         NVL(YA.NOW_ADD_BONUS_AMT, 0) + NVL(YA.NOW_STOCK_BENE_AMT, 0) +
                                         NVL(YA.PRE_PAY_TOT_AMT, 0) + NVL(YA.PRE_BONUS_TOT_AMT, 0) +
                                         NVL(YA.PRE_ADD_BONUS_AMT, 0) + NVL(YA.PRE_STOCK_BENE_AMT, 0) +
                                         NVL(YA.INCOME_OUTSIDE_AMT, 0) +
                                         NVL(YA.NOW_EMPLOYEE_STOCK_AMT, 0) + NVL(YA.NOW_OFFICE_RETIRE_OVER_AMT, 0) +
                                         NVL(YA.PRE_EMPLOYEE_STOCK_AMT, 0) + NVL(YA.PRE_OFFICE_RETIRE_OVER_AMT, 0) + 
                                         -- ����� 
                                         NVL(YA.NONTAX_OUTSIDE_AMT, 0) + NVL(YA.NONTAX_OT_AMT, 0) +  
                                         NVL(YA.NONTAX_RESEA_AMT, 0) + NVL(YA.NONTAX_ETC_AMT, 0) +
                                         NVL(YA.NONTAX_BIRTH_AMT, 0) + NVL(YA.NONTAX_FOREIGNER_AMT, 0) +
                                         NVL(YA.NONTAX_SCH_EDU_AMT, 0) + NVL(YA.NONTAX_MEMBER_AMT, 0) +
                                         NVL(YA.NONTAX_GUARD_AMT, 0) + NVL(YA.NONTAX_CHILD_AMT, 0) + 
                                         NVL(YA.NONTAX_HIGH_SCH_AMT, 0) + NVL(YA.NONTAX_SPECIAL_AMT, 0) +
                                         NVL(YA.NONTAX_RESEARCH_AMT, 0) + NVL(YA.NONTAX_COMPANY_AMT, 0) + 
                                         NVL(YA.NONTAX_COVER_AMT, 0) + NVL(YA.NONTAX_WILD_AMT, 0) + 
                                         NVL(YA.NONTAX_DISASTER_AMT, 0) + NVL(YA.NONTAX_OUTS_GOVER_AMT, 0) + 
                                         NVL(YA.NONTAX_OUTS_ARMY_AMT, 0) + NVL(YA.NONTAX_OUTS_WORK_1, 0) + 
                                         NVL(YA.NONTAX_OUTS_WORK_2, 0) + NVL(YA.NONTAX_STOCK_BENE_AMT, 0) + 
                                         NVL(YA.NONTAX_FOR_ENG_AMT, 0) + NVL(YA.NONTAX_EMPL_STOCK_AMT, 0) + 
                                         NVL(YA.NONTAX_EMPL_BENE_AMT_1, 0) + NVL(YA.NONTAX_EMPL_BENE_AMT_2, 0) + 
                                         NVL(YA.NONTAX_HOUSE_SUBSIDY_AMT, 0) + NVL(YA.NONTAX_SEA_RESOURCE_AMT, 0) +
                                         -- ����-- 
                                         NVL(YA.PRE_NT_OUTSIDE_AMT, 0) + NVL(YA.PRE_NT_OT_AMT, 0) +  
                                         NVL(YA.PRE_NT_RESEA_AMT, 0) + NVL(YA.PRE_NT_ETC_AMT, 0) +
                                         NVL(YA.PRE_NT_BIRTH_AMT, 0) + NVL(YA.PRE_NT_FOREIGNER_AMT, 0) +
                                         NVL(YA.PRE_NT_SCH_EDU_AMT, 0) + NVL(YA.PRE_NT_MEMBER_AMT, 0) +
                                         NVL(YA.PRE_NT_GUARD_AMT, 0) + NVL(YA.PRE_NT_CHILD_AMT, 0) + 
                                         NVL(YA.PRE_NT_HIGH_SCH_AMT, 0) + NVL(YA.PRE_NT_SPECIAL_AMT, 0) +
                                         NVL(YA.PRE_NT_RESEARCH_AMT, 0) + NVL(YA.PRE_NT_COMPANY_AMT, 0) + 
                                         NVL(YA.PRE_NT_COVER_AMT, 0) + NVL(YA.PRE_NT_WILD_AMT, 0) + 
                                         NVL(YA.PRE_NT_DISASTER_AMT, 0) + NVL(YA.PRE_NT_OUTS_GOVER_AMT, 0) + 
                                         NVL(YA.PRE_NT_OUTS_ARMY_AMT, 0) + NVL(YA.PRE_NT_OUTS_WORK_1, 0) + 
                                         NVL(YA.PRE_NT_OUTS_WORK_2, 0) + NVL(YA.PRE_NT_STOCK_BENE_AMT, 0) + 
                                         NVL(YA.PRE_NT_FOR_ENG_AMT, 0) + NVL(YA.PRE_NT_EMPL_STOCK_AMT, 0) + 
                                         NVL(YA.PRE_NT_EMPL_BENE_AMT_1, 0) + NVL(YA.PRE_NT_EMPL_BENE_AMT_2, 0) + 
                                         NVL(YA.PRE_NT_HOUSE_SUBSIDY_AMT, 0) + NVL(YA.PRE_NT_SEA_RESOURCE_AMT, 0))
                                 END, 11, 0) -- 63.�ѱ޿�;
                        || LPAD(NVL(YA.INCOME_DED_AMT, 0), 10, 0) -- 64.�ٷμҵ����;
                        || LPAD(NVL(YA.INCOME_TOT_AMT, 0) - NVL(YA.INCOME_DED_AMT, 0), 11, 0) -- 65.�ٷμҵ�ݾ�;
                        --> �⺻����.
                        || LPAD(NVL(YA.PER_DED_AMT, 0), 8, 0) -- 66.���ΰ����ݾ�;
                        || LPAD(NVL(YA.SPOUSE_DED_AMT, 0), 8, 0) -- 67.����ڰ����ݾ�;
                        || LPAD(NVL(YA.SUPP_DED_COUNT, 0), 2, 0) -- 68.�ξ簡�������ο�;
                        || LPAD(NVL(YA.SUPP_DED_AMT, 0), 8, 0) -- 69.�ξ簡�������ݾ�;
                        --> �߰�����.
                        -- 2009�� BEGIN : ��ο������ο� 70���̻� ����;
                        || LPAD(NVL(YA.OLD_DED_COUNT1, 0), 2, 0) -- 70.��ο������ο�;
                        || LPAD(NVL(YA.OLD_DED_AMT1, 0), 8, 0) -- 71.��ο������ݾ�;
                        /*
                        || LPAD(NVL(YA.OLD_DED_COUNT, 0) + NVL(YA.OLD_DED_COUNT1, 0), 2, 0) -- ��ο������ο�;
                        || LPAD(NVL(YA.OLD_DED_AMT, 0) + NVL(YA.OLD_DED_AMT1, 0), 8, 0) -- ��ο������ݾ�;*/
                        -- 2009�� END;
                        || LPAD(NVL(YA.DISABILITY_DED_COUNT, 0), 2, 0) -- 72.����ΰ����ο�;
                        || LPAD(NVL(YA.DISABILITY_DED_AMT, 0), 8, 0) -- 73.����ΰ����ݾ�;
                        || LPAD(NVL(YA.WOMAN_DED_AMT, 0), 8, 0) -- 74.�γ��ڰ����ݾ�;
                        || LPAD(NVL(YA.CHILD_DED_COUNT, 0), 2, 0) -- 75.�ڳ����������ο�;
                        || LPAD(NVL(YA.CHILD_DED_AMT, 0), 8, 0) -- 76.�ڳ����������ݾ�;
                        || LPAD(NVL(YA.BIRTH_DED_COUNT, 0), 2, 0) -- 77.���/�Ծ��ڰ����ο�;
                        || LPAD(NVL(YA.BIRTH_DED_AMT, 0), 8, 0) --  78.���/�Ծ��ڰ����ݾ�;
                        || LPAD(NVL(YA.SINGLE_PARENT_DED_AMT, 0), 10, 0) -- 79.2013�⵵ �߰� : �Ѻθ� ���� �����ݾ�;
                        -- LPAD(NVL(YA.PER_ADD_DED_AMT, 0), 8, 0)   PER_ADD_DED_AMT;
                        --> ���ڳ��߰�����;
                        || LPAD(NVL(YA.MANY_CHILD_DED_COUNT, 0), 2, 0) -- 80.���ڳ��߰������ο�;
                        || LPAD(NVL(YA.MANY_CHILD_DED_AMT, 0), 8, 0) -- 81.���ڳ��߰������ݾ�;
                        -->���ݺ����;
                        || LPAD(NVL(YA.NATI_ANNU_AMT, 0), 10, 0) -- 82.���ο��ݺ�������;
                        || LPAD(NVL(YA.PUBLIC_INSUR_AMT, 0), 10, 0)  -- 83.��Ÿ���ݺ�������_����������;
                        || LPAD(NVL(YA.MARINE_INSUR_AMT, 0), 10, 0)  -- 84.��Ÿ���ݺ�������_���ο���;
                        || LPAD(NVL(YA.SCHOOL_STAFF_INSUR_AMT, 0), 10, 0)  -- 85.��Ÿ���ݺ�������_�縳�б�����������;
                        || LPAD(NVL(YA.POST_OFFICE_INSUR_AMT, 0), 10, 0)  -- 86.��Ÿ���ݺ�������_������ü������;
                        || LPAD(NVL(YA.SCIENTIST_ANNU_AMT, 0), 10, 0)  -- 87.��Ÿ���ݺ�������_���б���ΰ���;
                        || LPAD(NVL(YA.RETR_ANNU_AMT, 0), 10, 0)  -- 88.��Ÿ���ݺ�������_�ٷ��������޿������;
                        || LPAD(NVL(YA.ANNU_BANK_AMT, 0), 10, 0) -- 89.2013�⵵ ���� : ��������ҵ����;
                        --> Ư������.
                        -- ����������;
                        -- 2009�� �������� BEGIN. ���������� 0�� �̸��� ��쿡�� 0�� ó��;
                        || LPAD(CASE 
                                  WHEN NVL(YA.MEDIC_INSUR_AMT, 0) < 0 THEN 0
                                  ELSE NVL(YA.MEDIC_INSUR_AMT, 0) 
                                END, 10, 0)  -- 90.�ǰ������;
                        || LPAD(CASE 
                                  WHEN NVL(YA.HIRE_INSUR_AMT, 0) < 0 THEN 0
                                  ELSE NVL(YA.HIRE_INSUR_AMT, 0) 
                                END, 10, 0)  -- 91.��뺸���;
                        || LPAD(NVL(YA.GUAR_INSUR_AMT, 0), 10, 0)  -- 92.���庸��� ;
                        || LPAD(NVL(YA.DISABILITY_INSUR_AMT, 0), 10, 0)  -- 93.��ֺ���� ;
                        || LPAD(NVL(YA.DISABILITY_MEDIC_AMT, 0), 10, 0)  -- 94.2013�⵵ ���� : �Ƿ������ݾ�-�����;
                        || LPAD(NVL(YA.ETC_MEDIC_AMT, 0), 10, 0)  -- 95.2013�⵵ ���� : �Ƿ������ݾ�-��Ÿ;
                        || LPAD(NVL(YA.DISABILITY_EDUCATION_AMT, 0), 8, 0) -- 96.2013�⵵ ���� : ����������ݾ�-�����;
                        || LPAD(NVL(YA.ETC_EDUCATION_AMT, 0), 8, 0) -- 97.2013�⵵ ���� : ����������ݾ�-��Ÿ;
                        || LPAD(NVL(YA.HOUSE_INTER_AMT, 0), 8, 0) -- 98.�����Ӵ������Աݿ����ݻ�ȯ�����ݾ�(������);
                        || LPAD(NVL(YA.HOUSE_INTER_AMT_ETC, 0), 8, 0)  -- 99.2013�⵵ ���� : �����������Աݿ����ݻ�ȯ��(������).
                        || LPAD(NVL(YA.HOUSE_MONTHLY_AMT, 0), 8, 0)  -- 100.�����ڱ�_������;
                        || LPAD(NVL(YA.LONG_HOUSE_PROF_AMT, 0), 8, 0) -- 101.��������������Ա����ڻ�ȯ�����ݾ�;
                        || LPAD(NVL(YA.LONG_HOUSE_PROF_AMT_1, 0), 8, 0) -- 102.��������������Ա����ڻ�ȯ�����ݾ�(15);
                        || LPAD(NVL(YA.LONG_HOUSE_PROF_AMT_2, 0), 8, 0) -- 103.��������������Ա����ڻ�ȯ�����ݾ�(30);
                        -- ��ȣ�� �߰� : 2012�⵵ �������� BEGIN --
                        || LPAD(NVL(YA.LONG_HOUSE_PROF_AMT_3_FIX, 0), 8, 0) -- 104.12�� ���� ��������������Ա����ڻ�ȯ�����ݾ�(�����ݸ�);
                        || LPAD(NVL(YA.LONG_HOUSE_PROF_AMT_3_ETC, 0), 8, 0) -- 105.12�� ���� ��������������Ա����ڻ�ȯ�����ݾ�(��Ÿ);
                        -- ��ȣ�� �߰� : 2012�⵵ �������� END --
                        || LPAD(NVL(YA.DONAT_DED_POLI_AMT, 0), 11, 0)  -- 106.2013�⵵ ���� : ��ġ�ڱ� ��α�;
                        || LPAD(NVL(YA.DONAT_DED_ALL, 0), 11, 0)  -- 107.2013�⵵ ���� : ������α�;
                        || LPAD(NVL(YA.DONAT_DED_30, 0), 11, 0)  -- 108.013�⵵ ���� : �츮�������� ��α�;
                        || LPAD(NVL(YA.DONAT_DED_RELIGION_10, 0) + 
                                NVL(YA.DONAT_DED_10, 0), 11, 0)  -- 109.2013�⵵ ���� : ������α� ��α� �հ�;
                        || LPAD(0, 20, 0) -- 110.SP_DED_SPACE_VALUE
                        || LPAD(( CASE
                                    WHEN NVL(YA.MEDIC_INSUR_AMT, 0) +
                                        NVL(YA.HIRE_INSUR_AMT, 0) +
                                        NVL(YA.GUAR_INSUR_AMT, 0) +
                                        NVL(YA.DISABILITY_INSUR_AMT, 0) < 0 THEN 0
                                    ELSE NVL(YA.MEDIC_INSUR_AMT, 0) +
                                        NVL(YA.HIRE_INSUR_AMT, 0) +
                                        NVL(YA.GUAR_INSUR_AMT, 0) +
                                        NVL(YA.DISABILITY_INSUR_AMT, 0)
                                  END) +
                                  NVL(YA.MEDIC_AMT, 0) +
                                  NVL(YA.EDUCATION_AMT, 0) +
                                  NVL(YA.HOUSE_INTER_AMT, 0) +
                                  NVL(YA.HOUSE_INTER_AMT_ETC, 0) + 
                                  NVL(YA.HOUSE_MONTHLY_AMT, 0) +
                                  NVL(YA.LONG_HOUSE_PROF_AMT, 0) +
                                  NVL(YA.LONG_HOUSE_PROF_AMT_1, 0) +
                                  NVL(YA.LONG_HOUSE_PROF_AMT_2, 0) +
                                  NVL(YA.LONG_HOUSE_PROF_AMT_3_FIX, 0) +
                                  NVL(YA.LONG_HOUSE_PROF_AMT_3_ETC, 0) +
                                  NVL(YA.DONAT_AMT, 0), 11, 0) -- 111.��;
                        || LPAD(NVL(YA.STAND_DED_AMT, 0), 8, 0) -- 112.ǥ�ذ���;
                        || LPAD(NVL(YA.SUBT_DED_AMT, 0), 11, 0) -- 113.�����ҵ�ݾ�; 
                        --> �� ���� �ҵ����.
                        || LPAD(NVL(YA.PERS_ANNU_BANK_AMT, 0), 8, 0) -- 114.���ο�������ҵ����;
                        || LPAD(NVL(YA.SMALL_CORPOR_DED_AMT, 0), 10, 0) -- 115.�ұ�������αݼҵ����;
                        || LPAD(NVL(YA.HOUSE_APP_DEPOSIT_AMT, 0), 10, 0)  -- 116.��)���ø�������ҵ����-û������;
                        || LPAD(NVL(YA.HOUSE_APP_SAVE_AMT, 0), 10, 0) -- 117.��)���ø�������ҵ����-����û����������;
                        --|| LPAD(NVL(YA.HOUSE_SAVE_AMT, 0), 10, 0)  -- 2013�⵵ ���� : ��)������ø�������.
                        || LPAD(NVL(YA.WORKER_HOUSE_SAVE_AMT, 0), 10, 0)  -- 118.��)�ٷ������ø�������.
                        || LPAD(NVL(YA.INVES_AMT, 0), 10, 0) -- 119.�����������ڵ�ҵ����;
                        || LPAD(NVL(YA.CREDIT_AMT, 0), 8, 0) -- 120.�ſ�ī��� �ҵ����;                        
                        --|| LPAD(CASE
                        --        WHEN NVL(YA.EMPL_STOCK_AMT, 0) < 0 THEN 0
                        --        ELSE 1
                        --      END, 1, 0) -- �츮�������ռҵ����(����̸� 0);
                        || LPAD(NVL(YA.EMPL_STOCK_AMT, 0), 10, 0) -- 121.�츮�������ռҵ����(�ѵ� 400����);
                        --|| LPAD(NVL(YA.LONG_STOCK_SAVING_AMT, 0), 10, 0) -- 2013�⵵ ����(���� ����) : ����ֽ�������ҵ����;
                        -- 2009�� �������� �߰� BEGIN. ��������߼ұ���ٷ��ڼҵ����/���� �߰�;
                        || LPAD(NVL(YA.HIRE_KEEP_EMPLOY_AMT, 0), 10, 0) -- 122.��������߼ұ���ٷ��ڼҵ����;
                        || LPAD(NVL(YA.FIX_LEASE_DED_AMT, 0), 10, 0) -- 123.2013�⵵ �߰� : �񵷾ȵ���������ڻ�ȯ�װ���;
                        -- 2009�� �������� �߰� END --
                        || LPAD((NVL(YA.PERS_ANNU_BANK_AMT, 0) +
                                NVL(YA.SMALL_CORPOR_DED_AMT, 0) +
                                NVL(YA.HOUSE_APP_DEPOSIT_AMT, 0) +
                                NVL(YA.HOUSE_APP_SAVE_AMT, 0) +
                                NVL(YA.WORKER_HOUSE_SAVE_AMT, 0) +
                                NVL(YA.INVES_AMT, 0) +
                                NVL(YA.CREDIT_AMT, 0) +
                                NVL(YA.EMPL_STOCK_AMT, 0) +
                                NVL(YA.HIRE_KEEP_EMPLOY_AMT, 0) + 
                                NVL(YA.FIX_LEASE_DED_AMT, 0)), 10, 0) -- 124.�׹��� �ҵ���� ��(����̸� '0'����);
                        || LPAD(NVL(YA.SP_DED_TOT_AMT, 0), 11, 0) -- 125.Ư������ �����ѵ� �ʰ���;
                        || LPAD(NVL(YA.TAX_STD_AMT, 0), 11, 0) -- 126.���ռҵ� ����ǥ��;
                        || LPAD(NVL(YA.COMP_TAX_AMT, 0), 10, 0) -- 127.���⼼��;
                        --> ���װ���.
                        || LPAD(NVL(YA.TAX_REDU_IN_LAW_AMT, 0), 10, 0) --128.�ҵ漼��;
                        || LPAD(NVL(YA.TAX_REDU_SP_LAW_AMT, 0), 10, 0) -- 129.����Ư�����ѹ�;
                        -- 2012�� �������� �߰� START --
                        || LPAD(0, 10, 0) -- 130.����Ư�����ѹ� : �߼ұ�� ��� û�� �ҵ漼 ����;
                        -- 2012�� �������� �߰� END --
                        || LPAD(NVL(YA.TAX_REDU_TAX_TREATY, 0), 10, 0) -- 131.��������.
                        || LPAD(0, 10, 0) -- 132.����;
                        || LPAD(NVL(YA.TAX_REDU_IN_LAW_AMT, 0) +
                                NVL(YA.TAX_REDU_SP_LAW_AMT, 0) +
                                NVL(YA.TAX_REDU_TAX_TREATY, 0), 10, 0) -- 133.���鼼�װ�;
                        --> ���װ���.
                        || LPAD(NVL(YA.TAX_DED_INCOME_AMT, 0), 10, 0) -- 134.�ٷμҵ漼�װ���;
                        || LPAD(NVL(YA.TAX_DED_TAXGROUP_AMT, 0), 10, 0) -- 135.�������հ���;
                        || LPAD(NVL(YA.TAX_DED_HOUSE_DEBT_AMT, 0), 10, 0) -- 136.�������Ա�;
                        || LPAD(NVL(YA.TAX_DED_DONAT_POLI_AMT, 0), 10, 0) -- 137.�����ġ�ڱ�;
                        || LPAD(NVL(YA.TAX_DED_OUTSIDE_PAY_AMT, 0), 10, 0) -- 138.�ܱ�����;
                        || LPAD(0, 10, 0) -- 139.����;
                        || LPAD(NVL(YA.TAX_DED_INCOME_AMT, 0) +
                                NVL(YA.TAX_DED_TAXGROUP_AMT, 0) +
                                NVL(YA.TAX_DED_HOUSE_DEBT_AMT, 0) +
                                NVL(YA.TAX_DED_DONAT_POLI_AMT, 0) +
                                NVL(YA.TAX_DED_OUTSIDE_PAY_AMT, 0), 10, 0) -- 140.���װ�����;
                        --> ��������.
                        || LPAD(NVL(YA.FIX_IN_TAX_AMT, 0), 10, 0) -- 141.�ҵ漼(������ ����);
                        || LPAD(NVL(YA.FIX_LOCAL_TAX_AMT, 0), 10, 0) -- 142.�ֹμ�;
                        || LPAD(NVL(YA.FIX_SP_TAX_AMT, 0), 10, 0) -- 143.��Ư��;
                        /* -- ��ȣ�� �ּ� : �հ� ����.
                        || LPAD(TRUNC(NVL(YA.FIX_IN_TAX_AMT, 0), -1) +
                                TRUNC(NVL(YA.FIX_LOCAL_TAX_AMT, 0), -1) +
                                TRUNC(NVL(YA.FIX_SP_TAX_AMT, 0), -1), 10, 0) -- �������� �հ�;*/ 
                        /* -- ��(��)���μ��� ����.
                        --> ��(��) ���μ���.
                        || LPAD(TRUNC(NVL(HEW1.IN_TAX_AMT, 0), -1), 10, 0) -- �ҵ漼.
                        || LPAD(TRUNC(NVL(HEW1.LOCAL_TAX_AMT, 0), -1), 10, 0) -- �ֹμ�.
                        || LPAD(TRUNC(NVL(HEW1.SP_TAX_AMT, 0), -1), 10, 0) -- ��Ư��;
                        || LPAD(TRUNC(NVL(HEW1.IN_TAX_AMT, 0), -1) + 
                                TRUNC(NVL(HEW1.LOCAL_TAX_AMT, 0), -1) + 
                                TRUNC(NVL(HEW1.SP_TAX_AMT, 0), -1), 10, 0) -- ���� ���μ��� �հ�;*/
                        -- 2009�� �������� ����(MODIFIED BY YOUNG MIN). "��(��) ���μ���"���� "�ⳳ�μ��� - ��(��)�ٹ���"�� ��Ī ����;
                        --> �ⳳ�μ��� - ��(��)�ٹ���;
                        || LPAD((NVL(YA.PRE_IN_TAX_AMT, 0) - NVL(S_PW.IN_TAX_AMT, 0)), 10, 0) -- 144.�ҵ漼.
                        || LPAD((NVL(YA.PRE_LOCAL_TAX_AMT, 0) - NVL(S_PW.LOCAL_TAX_AMT, 0)), 10, 0) --145.�ֹμ�.
                        || LPAD((NVL(YA.PRE_SP_TAX_AMT, 0) - NVL(S_PW.SP_TAX_AMT, 0)), 10, 0) -- 146.��Ư��.
                        /* -- ��ȣ�� �ּ� : �հ� ����.
                        || LPAD(TRUNC(NVL(YA.PRE_IN_TAX_AMT, 0) - NVL(HEW1.IN_TAX_AMT, 0), -1) +
                                TRUNC(NVL(YA.PRE_LOCAL_TAX_AMT, 0) - NVL(HEW1.LOCAL_TAX_AMT, 0), -1) +
                                TRUNC(NVL(YA.PRE_SP_TAX_AMT, 0) - NVL(HEW1.SP_TAX_AMT, 0), -1), 10, 0) -- ��(��) ���μ��� �հ�;*/
                        --> ����¡������;
                        -- 2009�� �������� ����(MODIFIED BY YOUNG MIN). "����¡������"�߰�(10���̸� �ܼ�����);
                        -- �������� - [��(��)�ٹ��� �ⳳ�μ��� + ��(��)�ٹ��� �ⳳ�μ����� ��];
                        || LPAD(CASE
                                  WHEN TRUNC((NVL(YA.FIX_IN_TAX_AMT, 0) - NVL(YA.PRE_IN_TAX_AMT, 0)), -1) < 0 THEN 1
                                  ELSE 0
                                END, 1, 0)  -- 147. 0 <= ����¡������(�ҵ漼) < 1000 �� ��� "0"����;
                        || LPAD(ABS(TRUNC((NVL(YA.FIX_IN_TAX_AMT, 0) - NVL(YA.PRE_IN_TAX_AMT, 0)), -1)), 10, 0) -- 147.�����ҵ漼.
                        || LPAD(CASE
                                  WHEN TRUNC((NVL(YA.FIX_LOCAL_TAX_AMT, 0) - NVL(YA.PRE_LOCAL_TAX_AMT, 0)), -1) < 0 THEN 1
                                  ELSE 0
                                END, 1, 0)  -- 148. 0 <= ����¡������(�ֹμ�) < 1000 �� ��� "0"����;
                        || LPAD(ABS(TRUNC((NVL(YA.FIX_LOCAL_TAX_AMT, 0) - NVL(YA.PRE_LOCAL_TAX_AMT, 0)), -1)), 10, 0) -- 148.�����ֹμ�.
                        || LPAD(CASE
                                  WHEN TRUNC((NVL(YA.FIX_SP_TAX_AMT, 0) - NVL(YA.PRE_SP_TAX_AMT, 0)), -1) < 0 THEN 1
                                  ELSE 0
                                END, 1, 0)  -- 149. 0 <= ����¡������(��Ư��) < 1000 �� ��� "0"����;
                        || LPAD(ABS(TRUNC((NVL(YA.FIX_SP_TAX_AMT, 0) - NVL(YA.PRE_SP_TAX_AMT, 0)), -1)), 10, 0)  -- 149.���� ��Ư��.                      
                        --> 150.����.
                        || LPAD(' ', 12, ' ') AS RECORD_FILE
                        , NVL(YA.MEDIC_INSUR_AMT, 0) + NVL(YA.HIRE_INSUR_AMT, 0) AS MEDIC_INSUR_AMT  -- 'E'���ڵ忡�� ���(����û���� ����� ���� ����).
                        , NVL(YA.TAX_DED_DONAT_POLI_AMT, 0) AS TAX_DED_DONAT_POLI_AMT 
                        , PM.PERSON_ID
                        , REPLACE(PM.REPRE_NUM, '-') AS REPRE_NUM
                        , ROW_NUMBER() OVER(PARTITION BY YA.YEAR_YYYY ORDER BY PM.PERSON_NUM) AS C_SEQ_NO
                        , PM.JOIN_DATE
                        , PM.FOREIGN_TAX_YN
                      FROM HRM_PERSON_MASTER PM
                        , HRA_YEAR_ADJUSTMENT YA
                        , ( SELECT HC.COMMON_ID AS NATION_ID
                                , HC.CODE AS NATION_CODE
                                , HC.CODE_NAME AS NATION_NAME
                                , HC.VALUE1 AS ISO_NATION_CODE
                              FROM HRM_COMMON HC
                            WHERE HC.GROUP_CODE   = 'NATION'
                              AND HC.SOB_ID       = P_SOB_ID
                              AND HC.ORG_ID       = P_ORG_ID
                           ) S_HN
                        , ( -- �����ٹ�ó ����.
                            SELECT PW.YEAR_YYYY
                                , PW.PERSON_ID
                                , COUNT(PW.PERSON_ID) AS PRE_WORK_COUNT
                                , SUM(PW.IN_TAX_AMT) AS IN_TAX_AMT
                                , SUM(PW.LOCAL_TAX_AMT) AS LOCAL_TAX_AMT
                                , SUM(PW.SP_TAX_AMT) AS SP_TAX_AMT
                              FROM HRA_PREVIOUS_WORK PW
                                , HRM_PERSON_MASTER PM
                            WHERE PW.PERSON_ID    = PM.PERSON_ID
                              AND PW.YEAR_YYYY    = P_YEAR_YYYY
                              AND PM.CORP_ID      = P_CORP_ID
                              AND PW.SOB_ID       = P_SOB_ID
                              AND PW.ORG_ID       = P_ORG_ID
                            GROUP BY PW.YEAR_YYYY
                                , PW.PERSON_ID
                          ) S_PW
                    WHERE PM.PERSON_ID      = YA.PERSON_ID
                      AND PM.NATION_ID      = S_HN.NATION_ID(+)
                      AND YA.YEAR_YYYY      = S_PW.YEAR_YYYY(+)
                      AND YA.PERSON_ID      = S_PW.PERSON_ID(+)
                      AND YA.YEAR_YYYY      = P_YEAR_YYYY
                      AND YA.CORP_ID        = P_CORP_ID
                      AND YA.SOB_ID         = P_SOB_ID
                      AND YA.ORG_ID         = P_ORG_ID
                      AND YA.SUBMIT_DATE    BETWEEN P_START_DATE AND P_END_DATE
                      AND YA.INCOME_TOT_AMT != 0
                      AND YA.ADJUST_DATE_TO BETWEEN P_START_DATE AND P_END_DATE
                      /*AND PM.ORI_JOIN_DATE  <= TO_DATE(P_YEAR_YYYY||'-12-31','YYYY-MM-DD')
                      AND (PM.RETIRE_DATE   >= TO_DATE(P_YEAR_YYYY||'-12-31','YYYY-MM-DD') OR PM.RETIRE_DATE IS NULL)*/
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
              , P_SORT_NUM          => 1
              );
            --DBMS_OUTPUT.PUT_LINE(C1.RECORD_FILE); 
--D1 ------------------------------------------------------------------------------------
            --> ��(��)�ٹ�ó ���ڵ� <--
            FOR D1 IN ( SELECT -- �ڷ������ȣ;
                              'D' -- 1.���ڵ� ����;
                            || '20' -- 2.�ڷᱸ��;
                            || RPAD(B1.TAX_OFFICE_CODE, 3, ' ') -- 3.�������ڵ�;
                            || LPAD(C1.C_SEQ_NO, 6, '0') -- 4.C���ڵ��� �Ϸù�ȣ.
                            -- ��õ¡���ǹ���;
                            || RPAD(B1.VAT_NUMBER, 10, ' ') -- 5.����ڹ�ȣ.
                            || RPAD(' ', 50, ' ') -- 6.����;
                            -- �ҵ���;
                            || RPAD(NVL(C1.REPRE_NUM, ' '), 13, ' ') -- 7.�ֹι�ȣ.
                            -- �ٹ�ó�� �ҵ�� - ��(��)�ٹ�ó;
                            || RPAD('2',1,' ') -- 8.�������ձ���;
                            || RPAD(REPLACE(PW.COMPANY_NAME, ' ' , ''), 40, ' ') -- 9.���θ�(��ȣ);
                            || RPAD(REPLACE(PW.COMPANY_NUM, '-', ''), 10, ' ') -- 10.����ڵ�Ϲ�ȣ;
                            -- 2009�� �������� ����. �ٹ��Ⱓ/����Ⱓ ����/���Ῥ���� �߰�;
                            || RPAD(CASE -- 11.�ٹ��Ⱓ ���ۿ�����;
                                      WHEN PW.JOIN_DATE > TO_DATE(P_YEAR_YYYY || '-01-01', 'YYYY-MM-DD') THEN TO_CHAR(PW.JOIN_DATE, 'YYYYMMDD')
                                      ELSE P_YEAR_YYYY || '0101'
                                    END, 8, '0')
                            || RPAD(TO_CHAR(NVL(PW.RETR_DATE, C1.JOIN_DATE -1), 'YYYYMMDD'), 8, '0') -- 12.�ٹ��Ⱓ ���Ῥ����;
                            || LPAD('0', 8, '0') -- 13.����Ⱓ ���ۿ�����;
                            || LPAD('0', 8, '0') -- 14.����Ⱓ ���Ῥ����;
                            || LPAD(NVL(PW.PAY_TOTAL_AMT, 0), 11, 0) -- 15.�޿��Ѿ�;
                            || LPAD(NVL(PW.BONUS_TOTAL_AMT, 0), 11, 0) -- 16.���Ѿ�;
                            || LPAD(NVL(PW.ADD_BONUS_AMT, 0), 11, 0) -- 17.������;
                            || LPAD(NVL(PW.STOCK_BENE_AMT, 0), 11, 0) -- 18.�ֽĸż����ñ��������;
                            -- 2009�� �������� ����(MODIFIED BY YOUNG MIN). �츮������������� �߰�;
                            || LPAD(0, 11, 0)  -- 19.�츮�������������(�迡�� �������� �ʾ���);
                            || LPAD(NVL(PW.OFFICERS_RETIRE_OVER_AMT, 0), 11, 0)  -- 20. 2013�� �߰� : �ӿ� �����ҵ�ݾ� �ѵ��ʰ��� 
                            || LPAD(0, 22, 0)  -- 21.����.
                            || LPAD(NVL(PW.PAY_TOTAL_AMT, 0) +
                                    NVL(PW.BONUS_TOTAL_AMT, 0) +
                                    NVL(PW.ADD_BONUS_AMT, 0) +
                                    NVL(PW.STOCK_BENE_AMT, 0) +
                                    NVL(PW.OFFICERS_RETIRE_OVER_AMT, 0), 11, 0)  -- 22.��.
                            --> ��(��)�ٹ�ó ����� �ҵ�.
                            -- 2009�� �������� ����(MODIFIED BY YOUNG MIN).��(��)�ٹ�ó ����� �ҵ� ���麯��;
                            || LPAD(NVL(PW.NT_SCH_EDU_AMT, 0), 10, 0) -- 23.�����-���ڱ�;
                            || LPAD(NVL(PW.NT_MEMBER_AMT, 0), 10, 0) -- 24.�����-��������������;
                            || LPAD(NVL(PW.NT_GUARD_AMT, 0), 10, 0) -- 25.�����-��ȣ/�¼�����;
                            || LPAD(NVL(PW.NT_CHILD_AMT, 0), 10, 0) -- 26.�����-����/���ߵ�_��������/Ȱ����;
                            || LPAD(NVL(PW.NT_HIGH_SCH_AMT, 0), 10, 0) -- 27.�����-����_��������/Ȱ����;
                            || LPAD(NVL(PW.NT_SPECIAL_AMT, 0), 10, 0) -- 28.�����-Ư���������������_��������/Ȱ����;
                            || LPAD(NVL(PW.NT_RESEARCH_AMT, 0), 10, 0) -- 29.�����-�������_��������/Ȱ����;
                            || LPAD(NVL(PW.NT_COMPANY_AMT, 0), 10, 0) -- 30.�����-���������_��������/Ȱ����;
                            -- 2012�� �������� �߰� START --
                            || LPAD(0, 10, 0) -- 31.�����-�������� �ٹ�ȯ�氳����;
                            || LPAD(0, 10, 0) -- 32.�����-�縳��ġ�� ��������/������ �ΰǺ�;
                            -- 2012�� �������� �߰� END --
                            || LPAD(NVL(PW.NT_COVER_AMT, 0), 10, 0) -- 33.�����-�������;
                            || LPAD(NVL(PW.NT_WILD_AMT, 0), 10, 0) -- 34.�����-��������;
                            || LPAD(NVL(PW.NT_DISASTER_AMT, 0), 10, 0) -- 35.�����-���ذ��ñ޿�;
                            || LPAD(0, 10, 0) -- 36.�����-���ΰ������ ����������� ������ ���ּ���;
                            || LPAD(NVL(PW.NT_OUTSIDE_GOVER_AMT, 0), 10, 0) -- 37.�����-�ܱ����ε�ٹ���;
                            || LPAD(NVL(PW.NT_OUTSIDE_ARMY_AMT, 0), 10, 0) -- 38.�����-�ܱ��ֵб��ε�;
                            || LPAD(NVL(PW.NT_OUTSIDE_WORK1, 0), 10, 0) -- 39.�����-���ܱٷ�(100����);
                            || LPAD(NVL(PW.NT_OUTSIDE_WORK2, 0), 10, 0) -- 40.�����-���ܱٷ�(300����);
                            || LPAD(NVL(PW.NT_OUTSIDE_AMT, 0), 10, 0) -- 41.����� ���ܼҵ�;
                            || LPAD(NVL(PW.NT_OT_AMT, 0), 10, 0) -- 42.����� �߰��ٷ�;
                            || LPAD(NVL(PW.NT_BIRTH_AMT, 0), 10, 0) -- 43.����� ���/��������;
                            || LPAD(0, 10, 0) -- 44.�ٷ����б�.
                            || LPAD(NVL(PW.NT_STOCK_BENE_AMT, 0), 10, 0) -- 45.�����-�ֽĸż����ñ�;
                            || LPAD(NVL(PW.NT_FOREIGNER_AMT, 0), 10, 0) -- 46.�����-�ܱ��α����;
                            --|| LPAD(NVL(PW.NONTAX_FOREIGNER_AMT, 0), 10, 0) -- ����� �ܱ��� �ٷ���;
                            --|| LPAD(NVL(PW.NONTAX_EMPL_STOCK_AMT, 0), 10, 0) --  �����-�츮�������չ���;
                            || LPAD(NVL(PW.NT_EMPL_STOCK_AMT, 0), 10, 0) -- 47.�����-�츮�������������(50%);
                            || LPAD(NVL(PW.NT_EMPL_BENE_AMT2, 0), 10, 0) -- 48.�����-�츮�������������(75%);
                            || LPAD(0, 10, 0)                                  -- 49.�����-��������� �߼ұ�� ���;
                            --|| LPAD(NVL(PW.NONTAX_HOUSE_SUBSIDY_AMT, 0), 10, 0) -- �����-�����ڱݺ�����;
                            || LPAD(NVL(PW.NT_SEA_RESOURCE_AMT, 0), 10, 0) -- 50.�����-���������ڿ�����;
                            -- 2012�� �������� �߰� START --
                            || LPAD(0, 10, 0) -- 51.�����-������ ���ú�������;
                            || LPAD(0, 10, 0) -- 52.�����-�߼ұ�� ���û�� �ҵ漼 ����;
                            || LPAD(0, 10, 0) -- 53.�����-��������� ������ ����;
                            -- 2012�� �������� �߰� END --
                            --|| LPAD(0, 10, 0)  -- ���������;
                            --|| LPAD(NVL(PW.NONTAX_ETC_AMT, 0), 10, 0) --AS NONTAX_ETC_AMT     -- ����� ��Ÿ;
                            || LPAD(NVL(PW.NT_SCH_EDU_AMT, 0) +
                                    NVL(PW.NT_MEMBER_AMT, 0) +
                                    NVL(PW.NT_GUARD_AMT, 0) +
                                    NVL(PW.NT_CHILD_AMT, 0) +
                                    NVL(PW.NT_HIGH_SCH_AMT, 0) +
                                    NVL(PW.NT_SPECIAL_AMT, 0) +
                                    NVL(PW.NT_RESEARCH_AMT, 0) +
                                    NVL(PW.NT_COMPANY_AMT, 0) +
                                    NVL(PW.NT_COVER_AMT, 0) +
                                    NVL(PW.NT_WILD_AMT, 0) +
                                    NVL(PW.NT_DISASTER_AMT, 0) +
                                    NVL(PW.NT_OUTSIDE_GOVER_AMT, 0) +
                                    NVL(PW.NT_OUTSIDE_ARMY_AMT, 0) +
                                    NVL(PW.NT_OUTSIDE_WORK1, 0) +
                                    NVL(PW.NT_OUTSIDE_WORK2, 0) +
                                    NVL(PW.NT_OUTSIDE_AMT, 0) +
                                    NVL(PW.NT_OT_AMT, 0) +
                                    NVL(PW.NT_BIRTH_AMT, 0) +
                                    NVL(PW.NT_STOCK_BENE_AMT, 0) + 
                                    --NVL(PW.NONTAX_FOR_ENG_AMT, 0) +                           -- ����ҵ� ��� �̵�;
                                    --NVL(PW.NONTAX_FOREIGNER_AMT, 0) +
                                    --NVL(PW.NONTAX_EMPL_STOCK_AMT, 0) +
                                    NVL(PW.NT_EMPL_BENE_AMT1, 0) +
                                    NVL(PW.NT_EMPL_BENE_AMT2, 0),
                                    --NVL(PW.NONTAX_HOUSE_SUBSIDY_AMT, 0) +
                                    --NVL(PW.NONTAX_SEA_RESOURCE_AMT, 0) +                      -- ����ҵ� ��� �̵�;
                                    --NVL(PW.NONTAX_ETC_AMT, 0),
                                    10, 0)  -- 54.����� ��;
                            || LPAD(NVL(PW.NT_FOREIGNER_AMT, 0) +
                                    NVL(PW.NT_SEA_RESOURCE_AMT, 0), 10, 0)  -- 55.����ҵ� ��;
                            -- �ⳳ�μ��� - ��(��)�ٹ���;
                            || LPAD(NVL(PW.IN_TAX_AMT, 0), 10, 0)  -- 56. �ⳳ�� �ҵ漼 
                            || LPAD(NVL(PW.LOCAL_TAX_AMT, 0), 10, 0)  -- 57. �ⳳ�� ����ҵ漼 
                            || LPAD(NVL(PW.SP_TAX_AMT, 0), 10, 0)  -- 58.�ⳳ�� ��Ư�� 
                            /*-- ��ȣ�� �ּ� : 2011�� ������.
                            || LPAD(NVL(PW.IN_TAX_AMT, 0) +
                                    NVL(PW.LOCAL_TAX_AMT, 0) +
                                    NVL(PW.SP_TAX_AMT, 0), 10, 0)*/
                            -- || LPAD(NVL(PW.PAY_TOTAL_AMT, 0) + NVL(PW.BONUS_TOTAL_AMT, 0) + NVL(PW.ADD_BONUS_AMT, 0) + NVL(PW.STOCK_BENE_AMT, 0),11, 0) --AS PAY_SUM_AMT                       -- ��;
                            || LPAD(ROW_NUMBER() OVER(PARTITION BY PW.PERSON_ID ORDER BY PW.SEQ_NUM), 2, 0) -- 59.��(��)�ٹ�ó �Ϸù�ȣ;
                            -- 60.���� 
                            || RPAD(' ', 771, ' ') AS RECORD_FILE 
                            , ROW_NUMBER() OVER(PARTITION BY PW.PERSON_ID ORDER BY PW.SEQ_NUM) AS D_SEQ_NO
                          FROM HRA_PREVIOUS_WORK PW
                        WHERE PW.YEAR_YYYY    = P_YEAR_YYYY
                          AND PW.SOB_ID       = P_SOB_ID
                          AND PW.ORG_ID       = P_ORG_ID
                          AND PW.PERSON_ID    = C1.PERSON_ID
                      )
            LOOP
              V_SOURCE_FILE := 'D_RECORD';
              INSERT_REPORT_FILE
                ( P_SEQ_NUM           => V_SEQ_NUM
                , P_SOURCE_FILE       => V_SOURCE_FILE
                , P_SOB_ID            => P_SOB_ID
                , P_ORG_ID            => P_ORG_ID
                , P_REPORT_FILE       => D1.RECORD_FILE
                , P_SORT_NUM          => 2 + ( 0.1 * D1.D_SEQ_NO)
                );
              --DBMS_OUTPUT.PUT_LINE(D1.RECORD_FILE); 
            END LOOP D1;
--E1 �ξ簡�� �� ----------------------------------------------------------------------------
-- �ܱ��� ���ϼ����� �ƴҰ�츸 ����.
          IF C1.FOREIGN_TAX_YN = 'N' THEN
            V_RECORD_FILE := NULL;
            V_SEQ_NO    := 0;
            V_RECORD_COUNT := 0;
            FOR E1 IN ( SELECT 
                              'E' -- 1.RECORD_TYPE
                            || '20' --2. DATA_TYPE
                            || RPAD(NVL(B1.TAX_OFFICE_CODE, ' '), 3, ' ') -- 3.�������ڵ�.
                            || LPAD(NVL(C1.C_SEQ_NO, 0), 6, 0)  -- 4.C���ڵ��� �Ϸù�ȣ.
                            || RPAD(NVL(B1.VAT_NUMBER, ' '), 10, ' ') -- 5.����ڹ�ȣ.
                            || RPAD(NVL(C1.REPRE_NUM, ' '), 13, ' ') AS RECORD_HEADER -- 6.�ֹι�ȣ.
                            --> �ҵ������ ��������.
                            , RPAD(CASE
                                     WHEN NVL(SF.BASE_LIVING_YN, 'N') = 'Y' THEN '7'  -- 2013�⵵ �߰� - ���ʼ����� 
                                     ELSE NVL(SF.RELATION_CODE, ' ')
                                   END, 1, ' ') -- 7.����;
                            || RPAD(CASE
                                      WHEN SUBSTR(REPLACE(SF.REPRE_NUM, '-', ''), 7, 1) BETWEEN '5' AND '8' THEN '9'
                                      ELSE '1'
                                    END, 1, ' ') -- 8.��/�ܱ��� ���� �ڵ�;
                            || RPAD(NVL(SF.FAMILY_NAME, ' '), 20, ' ') -- 9.����;
                            || RPAD(NVL(REPLACE(SF.REPRE_NUM, '-', ''), ' ') , 13, ' ') -- 10.�ֹι�ȣ;
                            || DECODE(SF.BASE_YN, 'Y', '1', ' ') -- 11.�⺻����;
                            || CASE 
                                 WHEN NVL(SF.BASE_YN, 'N') = 'Y' AND NVL(SF.DISABILITY_YN, 'N') = 'Y' THEN NVL(SF.DISABILITY_CODE, ' ')
                                 ELSE ' '
                               END  -- 12.����ΰ���;
                            || DECODE(SF.CHILD_YN, 'Y', '1', ' ') -- 13.�ڳ���������;
                            || DECODE(SF.WOMAN_YN, 'Y', '1', ' ') -- 14.�γ��ڰ���;
                            -- 2009�� �������� ����(MODIFIED BY YOUNG MIN).��ο�� ��70���̻����� ����;
                            || CASE
                                 --WHEN SF.OLD_YN = 'Y' THEN '1'
                                 WHEN SF.OLD1_YN = 'Y' THEN '1'
                                 ELSE ' '
                               END -- 15.��ο�����;
                            -- 2009�� �������� ����(MODIFIED BY YOUNG MIN).����Ծ��ڰ����߰�;
                            || DECODE(SF.BIRTH_YN, 'Y', '1', ' ') -- 16.����Ծ��ڰ���.
                            || DECODE(SF.SINGLE_PARENT_DED_YN, 'Y', '1', ' ') -- 17.�Ѻθ�1 
                            /*-- 2009�� �������� ����(MODIFIED BY YOUNG MIN).���ڳ��߰����� ����;
                            || CASE
                                 WHEN SF.BASE_YN = 'Y' AND C1.MANY_CHILD_DED_AMT <> 0 AND SF.RELATION_CODE = '4' THEN '1'
                                 ELSE ' '
                               END -- ���ڳ��߰�����;*/
                            --> ����û �ڷ�.
                            -- 2009�� �������� ����(MODIFIED BY YOUNG MIN).����û�ڷ� �����ݾ��� ������ ��� 0���� ǥ��;
                            || LPAD((CASE
                                       WHEN DECODE(SF.RELATION_CODE, 0, NVL(C1.MEDIC_INSUR_AMT, 0), 0) + 
                                            NVL(SF.INSURE_AMT, 0) + NVL(SF.DISABILITY_INSURE_AMT, 0) < 0 THEN 0
                                       ELSE DECODE(SF.RELATION_CODE, 0, NVL(C1.MEDIC_INSUR_AMT, 0), 0) + 
                                            NVL(SF.INSURE_AMT, 0) + NVL(SF.DISABILITY_INSURE_AMT, 0)
                                     END), 10, 0) -- 18.�����(������ �ǰ������ ����);
                            || LPAD(NVL(SF.MEDICAL_AMT, 0), 10, 0) -- 19.�Ƿ��;
                            || LPAD(NVL(SF.EDUCATION_AMT, 0), 10, 0) -- 20.������;
                            || LPAD(NVL(SF.CREDIT_AMT, 0), 10, 0) -- 21.�ſ�ī���;
                            || LPAD(NVL(SF.CHECK_CREDIT_AMT , 0), 10, 0) -- 22.����ī��;
                            || LPAD(NVL(SF.CASH_AMT, 0) + NVL(SF.ACADE_GIRO_AMT, 0), 10, 0) -- 23.���ݿ�����;
                            --2012�� �������� �߰� START --
                            || LPAD(NVL(SF.TRAD_MARKET_AMT, 0), 10, 0) -- 24.����������;
                            || LPAD(NVL(SF.PUBLIC_TRANSIT_AMT, 0), 10, 0) -- 25.���߱����̿��1;
                            --2012�� �������� �߰� END --
                            || LPAD(NVL(SF.DONAT_ALL, 0) +
                                    NVL(SF.DONAT_50P, 0) +
                                    NVL(SF.DONAT_30P, 0) +
                                    NVL(SF.DONAT_10P, 0) +
                                    NVL(SF.DONAT_10P_RELIGION, 0), 13, 0)  -- 26.��α�.
                            -->����û�ڷ� �̿�.
                            || LPAD(NVL(SF.ETC_INSURE_AMT, 0), 10, 0) -- 27.����û�������� �����;
                            || LPAD(NVL(SF.ETC_MEDICAL_AMT, 0), 10, 0) -- 28.����û�������� �Ƿ��;
                            || LPAD(NVL(SF.ETC_EDUCATION_AMT, 0), 10, 0) -- 29.����û�������� ������;
                            || LPAD(NVL(SF.ETC_CREDIT_AMT, 0) + NVL(SF.ETC_ACADE_GIRO_AMT, 0), 10, 0) -- 30.����û�������� �ſ�ī��;
                            || LPAD(NVL(SF.ETC_CHECK_CREDIT_AMT, 0), 10, 0) -- 31.����û�������� ����ī��;
                            --2012�� �������� �߰� START --
                            || LPAD(NVL(SF.ETC_TRAD_MARKET_AMT, 0), 10, 0) -- 32.����������;
                            || LPAD(NVL(SF.ETC_PUBLIC_TRANSIT_AMT, 0), 10, 0)  -- 33. ���߱����̿��;
                            --2012�� �������� �߰� END --
                            || LPAD(NVL(SF.ETC_DONAT_ALL, 0) +
                                    NVL(SF.ETC_DONAT_50P, 0) +
                                    NVL(SF.ETC_DONAT_30P, 0) +
                                    NVL(SF.ETC_DONAT_10P, 0) +
                                    NVL(SF.ETC_DONAT_10P_RELIGION, 0), 13, 0) AS RECORD_LINE -- 34.����û�������� ��α�;
                         FROM HRA_SUPPORT_FAMILY SF
                        WHERE SF.YEAR_YYYY      = P_YEAR_YYYY
                          AND (SF.BASE_YN        = 'Y'
                            OR SF.SPOUSE_YN      = 'Y'
                            OR SF.OLD_YN         = 'Y'
                            OR SF.OLD1_YN        = 'Y'
                            OR (SF.BASE_YN       = 'Y' AND SF.DISABILITY_YN  = 'Y')
                            OR SF.WOMAN_YN       = 'Y'
                            OR SF.CHILD_YN       = 'Y'
                            OR SF.BIRTH_YN       = 'Y'
                            OR ((NVL(SF.INSURE_AMT, 0) + NVL(SF.ETC_INSURE_AMT, 0) + NVL(SF.DISABILITY_INSURE_AMT, 0) + 
                                NVL(SF.ETC_DISABILITY_INSURE_AMT, 0) + NVL(SF.MEDICAL_AMT, 0) + NVL(SF.ETC_MEDICAL_AMT, 0) +
                                NVL(SF.EDUCATION_TYPE, 0) + NVL(SF.EDUCATION_AMT, 0) + NVL(SF.ETC_EDUCATION_AMT, 0) + 
                                NVL(SF.CREDIT_AMT, 0) + NVL(SF.ETC_CREDIT_AMT, 0) + NVL(SF.CHECK_CREDIT_AMT, 0) + 
                                NVL(SF.ETC_CHECK_CREDIT_AMT, 0) + NVL(SF.CASH_AMT, 0) + NVL(SF.ETC_CASH_AMT, 0) + 
                                NVL(SF.ACADE_GIRO_AMT, 0) + NVL(SF.ETC_ACADE_GIRO_AMT, 0) + 
                                NVL(SF.TRAD_MARKET_AMT, 0) + NVL(SF.ETC_TRAD_MARKET_AMT, 0) +
                                NVL(SF.DONAT_ALL, 0) + NVL(SF.ETC_DONAT_ALL, 0) + NVL(SF.DONAT_50P, 0) + NVL(SF.ETC_DONAT_50P, 0) + 
                                NVL(SF.DONAT_30P, 0) + NVL(SF.ETC_DONAT_30P, 0) + NVL(SF.DONAT_10P, 0) + NVL(SF.ETC_DONAT_10P, 0) + 
                                NVL(SF.DONAT_10P_RELIGION, 0) + NVL(SF.ETC_DONAT_10P_RELIGION, 0) + 
                                NVL(SF.DONAT_POLI, 0) + NVL(SF.ETC_DONAT_POLI, 0))) > 0)
                          AND SF.PERSON_ID      = C1.PERSON_ID
                          AND SF.REPRE_NUM      IS NOT NULL
                        ORDER BY SF.RELATION_CODE
                      )
            LOOP
              V_RECORD_COUNT := NVL(V_RECORD_COUNT, 0) + 1;
              IF V_RECORD_COUNT = 1 THEN
                V_RECORD_FILE := E1.RECORD_HEADER || E1.RECORD_LINE;
              ELSE
                V_RECORD_FILE := V_RECORD_FILE || E1.RECORD_LINE;
              END IF;
              --> �ξ簡���� 5�� �̻��� ���.
              IF V_E_REC_STD <= V_RECORD_COUNT THEN
                V_SEQ_NO := NVL(V_SEQ_NO, 0) + 1;  -- �ξ簡�� ���� �Ϸù�ȣ.
                V_RECORD_FILE := V_RECORD_FILE 
                                 || LPAD(NVL(V_SEQ_NO, 1), 2, 0)  -- �Ϸù�ȣ.
                                 || RPAD(' ', 273, ' ');  -- ����.
                
                V_SOURCE_FILE := 'E_RECORD';
                INSERT_REPORT_FILE
                  ( P_SEQ_NUM           => V_SEQ_NUM
                  , P_SOURCE_FILE       => V_SOURCE_FILE
                  , P_SOB_ID            => P_SOB_ID
                  , P_ORG_ID            => P_ORG_ID
                  , P_REPORT_FILE       => V_RECORD_FILE
                  , P_SORT_NUM          => 3 + (0.001 * V_SEQ_NO)
                  );
                --DBMS_OUTPUT.PUT_LINE(V_RECORD_FILE); 
                V_RECORD_FILE  := NULL;
                V_RECORD_COUNT := 0;
              END IF;
            END LOOP E1;
            IF V_RECORD_COUNT <> 0 THEN
              FOR E1S IN V_RECORD_COUNT + 1 .. V_E_REC_STD
              LOOP
                V_RECORD_FILE := V_RECORD_FILE || RPAD(' ', 218, ' ');  -- �ҵ���� ���� �ξ簡�� ����.
              END LOOP E1S;
              IF V_RECORD_FILE IS NOT NULL THEN
                V_SEQ_NO := NVL(V_SEQ_NO, 0) + 1;  -- �ξ簡�� ���� �Ϸù�ȣ.
                V_RECORD_FILE := V_RECORD_FILE 
                                 || LPAD(NVL(V_SEQ_NO, 1), 2, 0)  -- �Ϸù�ȣ.
                                 || RPAD(' ', 273, ' ');  -- ����.
                                 
                V_SOURCE_FILE := 'E_RECORD';
                INSERT_REPORT_FILE
                  ( P_SEQ_NUM           => V_SEQ_NUM
                  , P_SOURCE_FILE       => V_SOURCE_FILE
                  , P_SOB_ID            => P_SOB_ID
                  , P_ORG_ID            => P_ORG_ID
                  , P_REPORT_FILE       => V_RECORD_FILE
                  , P_SORT_NUM          => 3 + (0.001 * V_SEQ_NO)
                  );
                --DBMS_OUTPUT.PUT_LINE(V_RECORD_FILE); 
              END IF;
            END IF;

--F1 ����/����� �ҵ���� �� ���ڵ� -----------------------------------------------------------------
            V_RECORD_FILE := NULL;
            V_SEQ_NO    := 0;
            V_RECORD_COUNT := 0;
            FOR F1 IN ( SELECT 'F' --1.RECORD_TYPE
                            || '20' --2. DATA_TYPE
                            || RPAD(NVL(B1.TAX_OFFICE_CODE, ' '), 3, ' ') -- 3.�������ڵ�.
                            || LPAD(C1.C_SEQ_NO, 6, 0) -- 4.C���ڵ��� �Ϸù�ȣ.
                            || RPAD(NVL(B1.VAT_NUMBER, ' '), 10, ' ') -- 5.����ڹ�ȣ.
                            || RPAD(NVL(C1.REPRE_NUM, ' '), 13, ' ') AS RECORD_HEADER -- 6.�ֹι�ȣ.
                            , LPAD(NVL(SI.SAVING_TYPE, ' '), 2, '0')  -- 7.�ҵ��������;
                            || RPAD(SI.BANK_CODE, 3, ' ') -- 8.������� �ڵ����;
                            || RPAD(YB.YEAR_BANK_NAME, 30, ' ') -- 9.������� ��ȣ����;
                            || RPAD(SI.ACCOUNT_NUM, 20, ' ') -- 10.���¹�ȣ;
                            || LPAD(DECODE(SI.SAVING_TYPE, '41', CASE WHEN 3 < SI.SAVING_COUNT THEN 3 ELSE SI.SAVING_COUNT END , '0'), 2, 0) -- 11.���Կ���-����ֽ������ุ �ش�;
                            || LPAD(SI.SAVING_AMOUNT, 10, 0) -- 12.���Աݾ�;
                            || LPAD(SI.SAVING_DED_AMOUNT, 10, 0) AS RECORD_LINE               -- 13.�����ݾ�;
                          FROM HRA_SAVING_INFO SI
                            , ( SELECT HC.COMMON_ID AS YEAR_BANK_ID
                                    , HC.CODE AS YEAR_BANK_CODE
                                    , HC.CODE_NAME AS YEAR_BANK_NAME
                                    , HC.SOB_ID
                                    , HC.ORG_ID
                                  FROM HRM_COMMON HC
                                WHERE HC.GROUP_CODE   = 'YEAR_BANK'
                                  AND HC.SOB_ID       = P_SOB_ID
                                  AND HC.ORG_ID       = P_ORG_ID
                               ) YB
                        WHERE SI.BANK_CODE      = YB.YEAR_BANK_CODE
                          AND SI.SOB_ID         = YB.SOB_ID
                          AND SI.ORG_ID         = YB.ORG_ID
                          AND SI.YEAR_YYYY      = P_YEAR_YYYY
                          AND SI.PERSON_ID      = C1.PERSON_ID
                          AND NVL(SI.SAVING_DED_AMOUNT, 0) > 0
                        ORDER BY SI.BANK_CODE ASC
                        )
            LOOP
              V_RECORD_COUNT := NVL(V_RECORD_COUNT, 0) + 1;
              IF V_RECORD_COUNT = 1 THEN
                V_RECORD_FILE := F1.RECORD_HEADER || F1.RECORD_LINE;
              ELSE
                V_RECORD_FILE := V_RECORD_FILE || F1.RECORD_LINE;
              END IF;
              --> ��������� ���� 15�� �̻��� ���.
              IF V_F_REC_STD <= V_RECORD_COUNT THEN
                V_SEQ_NO := NVL(V_SEQ_NO, 0) + 1;  -- �������� ���� �Ϸù�ȣ.
                V_RECORD_FILE := V_RECORD_FILE || RPAD(' ', 210, ' ');  -- ����.
                
                V_SOURCE_FILE := 'F_RECORD';
                INSERT_REPORT_FILE
                  ( P_SEQ_NUM           => V_SEQ_NUM
                  , P_SOURCE_FILE       => V_SOURCE_FILE
                  , P_SOB_ID            => P_SOB_ID
                  , P_ORG_ID            => P_ORG_ID
                  , P_REPORT_FILE       => V_RECORD_FILE
                  , P_SORT_NUM          => 4 + (0.00001 * V_SEQ_NO)
                  );
                --DBMS_OUTPUT.PUT_LINE(V_RECORD_FILE); 
                V_RECORD_FILE  := NULL;
                V_RECORD_COUNT := 0;
              END IF;
            END LOOP F1;
            IF V_RECORD_COUNT <> 0 THEN
              FOR F1S IN V_RECORD_COUNT + 1 .. V_F_REC_STD
              LOOP
                V_RECORD_FILE := V_RECORD_FILE || RPAD(' ', 77, ' ');
              END LOOP F1S;
              IF V_RECORD_FILE IS NOT NULL THEN
                V_SEQ_NO := NVL(V_SEQ_NO, 0) + 1;  -- �������� ���� �Ϸù�ȣ.
                V_RECORD_FILE := V_RECORD_FILE || RPAD(' ', 210, ' ');  -- ��������  �ҵ������ ���� ���� => ����.
                
                V_SOURCE_FILE := 'F_RECORD';                
                INSERT_REPORT_FILE
                  ( P_SEQ_NUM           => V_SEQ_NUM
                  , P_SOURCE_FILE       => V_SOURCE_FILE
                  , P_SOB_ID            => P_SOB_ID
                  , P_ORG_ID            => P_ORG_ID
                  , P_REPORT_FILE       => V_RECORD_FILE
                  , P_SORT_NUM          => 4 + (0.00001 * V_SEQ_NO)
                  );
                --DBMS_OUTPUT.PUT_LINE(V_RECORD_FILE); 
              END IF;
            END IF;
--F1 END ---------------------------------------------------------------------------------
--G1 ����/�����ڰ� �����������Ա� ������ ��ȯ�� �ҵ�������� ���ڵ� --------------------
            V_REC_TEMP_1 := RPAD(' ', 20, ' ') ||  -- �Ӵ��� ����
                            RPAD(' ', 13, ' ') || -- �ֹε�Ϲ�ȣ(����ڹ�ȣ) 
                            RPAD(' ', 100, ' ') ||  --  �Ӵ�����༭�� �ּ��� 
                            LPAD(0, 8, 0) ||  -- �Ӵ������Ⱓ ���� 
                            LPAD(0, 8, 0) ||  -- �Ӵ������Ⱓ ���� 
                            LPAD(0, 10, 0) ||  -- ������ 
                            LPAD(0, 10, 0);
            V_REC_TEMP_2 := RPAD(' ', 20, ' ') ||  --    -- ���ּ��� 
                            RPAD(' ', 13, ' ') || -- ���� �ֹι�ȣ 
                            LPAD(0, 8, 0) ||  -- �����Һ���� ���Ⱓ ���� 
                            LPAD(0, 8, 0) ||  -- �����Һ���� ���Ⱓ ���� 
                            LPAD(0, 4, 0) ||  -- ���Ա� ������ 
                            LPAD(0, 10, 0) ||  -- ������ ��ȯ�װ� 
                            LPAD(0, 10, 0) ||  -- ���� 
                            LPAD(0, 10, 0) ||  -- ���� 
                            LPAD(0, 10, 0) ||  -- �����ݾ� 
                            RPAD(' ', 20, ' ') ||  -- �Ӵ��� ����
                            RPAD(' ', 13, ' ') || -- �ֹε�Ϲ�ȣ(����ڹ�ȣ) 
                            RPAD(' ', 100, ' ') ||  --  �Ӵ�����༭�� �ּ��� 
                            LPAD(0, 8, 0) ||  -- �Ӵ������Ⱓ ���� 
                            LPAD(0, 8, 0) ||  -- �Ӵ������Ⱓ ���� 
                            LPAD(0, 10, 0);
            V_RECORD_FILE := NULL;
            V_SEQ_NO    := 0;
            V_RECORD_COUNT := 0;
            FOR G1 IN ( SELECT 'G' --1.RECORD_TYPE
                            || '20' --2. DATA_TYPE
                            || RPAD(NVL(B1.TAX_OFFICE_CODE, ' '), 3, ' ') -- 3.�������ڵ�.
                            || LPAD(C1.C_SEQ_NO, 6, 0) -- 4.C���ڵ��� �Ϸù�ȣ.
                            || RPAD(NVL(B1.VAT_NUMBER, ' '), 10, ' ') -- 5.����ڹ�ȣ.
                            || RPAD(NVL(C1.REPRE_NUM, ' '), 13, ' ') AS RECORD_HEADER -- 6.�ֹι�ȣ.
                            
                             , MAX(HL.HOUSE_LEASE_INFO_10) AS HOUSE_LEASE_INFO_10
                             , MAX(HL.HOUSE_LEASE_INFO_20) AS HOUSE_LEASE_INFO_20
                          FROM (SELECT ROWNUM AS ROW_NUM 
                                     , RPAD(NVL(HLI.LESSOR_NAME, ' '), 20, ' ') ||  -- �Ӵ��� ����
                                       RPAD(NVL(REPLACE(HLI.LESSOR_REPRE_NUM, '-', ''), ' '), 13, ' ') || -- �ֹε�Ϲ�ȣ(����ڹ�ȣ) 
                                       RPAD(NVL(HLI.LEASE_ADDR1, ' ') || ' ' || NVL(HLI.LEASE_ADDR2, ' '), 100, ' ') ||  --  �Ӵ�����༭�� �ּ��� 
                                       LPAD(NVL(TO_CHAR(HLI.LEASE_TERM_FR, 'YYYYMMDD'), '0'), 8, 0) ||  -- �Ӵ������Ⱓ ���� 
                                       LPAD(NVL(TO_CHAR(HLI.LEASE_TERM_TO, 'YYYYMMDD'), '0'), 8, 0) ||  -- �Ӵ������Ⱓ ���� 
                                       LPAD(NVL(HLI.MONTLY_LEASE_AMT, 0), 10, 0) ||  -- ������ 
                                       LPAD(NVL(HLI.HOUSE_DED_AMT, 0), 10, 0) AS HOUSE_LEASE_INFO_10
                                     , NULL AS HOUSE_LEASE_INFO_20
                                  FROM HRA_HOUSE_LEASE_INFO HLI
                                WHERE HLI.YEAR_YYYY         = P_YEAR_YYYY
                                  AND HLI.PERSON_ID         = C1.PERSON_ID
                                  AND HLI.SOB_ID            = P_SOB_ID
                                  AND HLI.ORG_ID            = P_ORG_ID
                                  AND HLI.HOUSE_LEASE_TYPE  = '10'  -- ����  
                                  AND HLI.HOUSE_DED_AMT     != 0    -- �����ݾ� �ִ°͸� ó�� 
                                UNION ALL
                                SELECT ROWNUM AS ROW_NUM 
                                     , NULL AS HOUSE_LEASE_INFO_10
                                     , RPAD(NVL(HLI.LOANER_NAME, ' '), 20, ' ') ||  --    -- ���ּ��� 
                                       RPAD(NVL(REPLACE(HLI.LOANER_REPRE_NUM, '-', ''), ' '), 13, ' ') || -- ���� �ֹι�ȣ 
                                       LPAD(NVL(TO_CHAR(HLI.LOAN_TERM_FR, 'YYYYMMDD'), '0'), 8, 0) ||  -- �����Һ���� ���Ⱓ ���� 
                                       LPAD(NVL(TO_CHAR(HLI.LOAN_TERM_TO, 'YYYYMMDD'), '0'), 8, 0) ||  -- �����Һ���� ���Ⱓ ���� 
                                       LPAD(NVL(HLI.LOAN_INTEREST_RATE, 0), 4, 0) ||  -- ���Ա� ������ 
                                       LPAD((NVL(HLI.LOAN_AMT, 0) + NVL(HLI.LOAN_INTEREST_AMT, 0)), 10, 0) ||  -- ������ ��ȯ�װ� 
                                       LPAD(NVL(HLI.LOAN_AMT, 0), 10, 0) ||  -- ���� 
                                       LPAD(NVL(HLI.LOAN_INTEREST_AMT, 0), 10, 0) ||  -- ���� 
                                       LPAD(NVL(HLI.HOUSE_DED_AMT, 0), 10, 0) ||  -- �����ݾ� 
                                       RPAD(NVL(HLI.LESSOR_NAME, ' '), 20, ' ') ||  -- �Ӵ��� ����
                                       RPAD(NVL(REPLACE(HLI.LESSOR_REPRE_NUM, '-', ''), ' '), 13, ' ') || -- �ֹε�Ϲ�ȣ(����ڹ�ȣ) 
                                       RPAD(NVL(HLI.LEASE_ADDR1, ' ') || ' ' || NVL(HLI.LEASE_ADDR2, ' '), 100, ' ') ||  --  �Ӵ�����༭�� �ּ��� 
                                       LPAD(NVL(TO_CHAR(HLI.LEASE_TERM_FR, 'YYYYMMDD'), '0'), 8, 0) ||  -- �Ӵ������Ⱓ ���� 
                                       LPAD(NVL(TO_CHAR(HLI.LEASE_TERM_TO, 'YYYYMMDD'), '0'), 8, 0) ||  -- �Ӵ������Ⱓ ���� 
                                       LPAD(NVL(HLI.DEPOSIT_AMT, 0), 10, 0) AS HOUSE_LEASE_INFO_20  -- ����������            
                                  FROM HRA_HOUSE_LEASE_INFO HLI
                                WHERE HLI.YEAR_YYYY         = P_YEAR_YYYY
                                  AND HLI.PERSON_ID         = C1.PERSON_ID
                                  AND HLI.SOB_ID            = P_SOB_ID
                                  AND HLI.ORG_ID            = P_ORG_ID
                                  AND HLI.HOUSE_LEASE_TYPE  = '20'  -- ������ �����������Կ����� 
                               ) HL
                        GROUP BY HL.ROW_NUM
                        ORDER BY HL.ROW_NUM
                        )
            LOOP
              V_RECORD_COUNT := NVL(V_RECORD_COUNT, 0) + 1;
              IF V_RECORD_COUNT = 1 THEN
                V_RECORD_FILE := G1.RECORD_HEADER;
                -- ����  
                IF G1.HOUSE_LEASE_INFO_10 IS NULL THEN
                  V_RECORD_FILE := V_RECORD_FILE || V_REC_TEMP_1;
                ELSE
                  V_RECORD_FILE := V_RECORD_FILE || G1.HOUSE_LEASE_INFO_10;
                END IF;
                -- �����ڰ� �����������Ա� 
                IF G1.HOUSE_LEASE_INFO_20 IS NULL THEN
                  V_RECORD_FILE := V_RECORD_FILE || V_REC_TEMP_2;
                ELSE
                  V_RECORD_FILE := V_RECORD_FILE || G1.HOUSE_LEASE_INFO_20;
                END IF;
              ELSE
                -- ����  
                IF G1.HOUSE_LEASE_INFO_10 IS NULL THEN
                  V_RECORD_FILE := V_RECORD_FILE || V_REC_TEMP_1;
                ELSE
                  V_RECORD_FILE := V_RECORD_FILE || G1.HOUSE_LEASE_INFO_10;
                END IF;
                -- �����ڰ� �����������Ա� 
                IF G1.HOUSE_LEASE_INFO_20 IS NULL THEN
                  V_RECORD_FILE := V_RECORD_FILE || V_REC_TEMP_2;
                ELSE
                  V_RECORD_FILE := V_RECORD_FILE || G1.HOUSE_LEASE_INFO_20;
                END IF;
              END IF;
              --> ����/�����ڰ� �����������Ա� ������ ���� 3�� �̻��� ���.
              IF V_G_REC_STD <= V_RECORD_COUNT THEN
                V_SEQ_NO := NVL(V_SEQ_NO, 0) + 1;  -- ����/�����ڰ� �����������Ա� ������ ���� �Ϸù�ȣ.
                V_RECORD_FILE := V_RECORD_FILE || LPAD(V_SEQ_NO, 2, 0);  -- �Ϸù�ȣ 
                V_RECORD_FILE := V_RECORD_FILE || RPAD(' ', 100, ' ');  -- ����.
                
                V_SOURCE_FILE := 'G_RECORD';
                INSERT_REPORT_FILE
                  ( P_SEQ_NUM           => V_SEQ_NUM
                  , P_SOURCE_FILE       => V_SOURCE_FILE
                  , P_SOB_ID            => P_SOB_ID
                  , P_ORG_ID            => P_ORG_ID
                  , P_REPORT_FILE       => V_RECORD_FILE
                  , P_SORT_NUM          => 5 + (0.00001 * V_SEQ_NO)
                  );
                --DBMS_OUTPUT.PUT_LINE(V_RECORD_FILE); 
                V_RECORD_FILE  := NULL;
                V_RECORD_COUNT := 0;
              END IF;
            END LOOP F1; 
            IF V_RECORD_COUNT <> 0 THEN
              FOR G1S IN (V_RECORD_COUNT + 1) .. V_G_REC_STD
              LOOP
                V_RECORD_FILE := V_RECORD_FILE || V_REC_TEMP_1 || V_REC_TEMP_2;
              END LOOP F1S;
              IF V_RECORD_FILE IS NOT NULL THEN
                V_SEQ_NO := NVL(V_SEQ_NO, 0) + 1;  -- ����/�����ڰ� �����������Ա� ������ ���� �Ϸù�ȣ.
                V_RECORD_FILE := V_RECORD_FILE || LPAD(V_SEQ_NO, 2, 0);  -- �Ϸù�ȣ 
                V_RECORD_FILE := V_RECORD_FILE || RPAD(' ', 100, ' ');  -- ����.

                V_SOURCE_FILE := 'G_RECORD';                
                INSERT_REPORT_FILE
                  ( P_SEQ_NUM           => V_SEQ_NUM
                  , P_SOURCE_FILE       => V_SOURCE_FILE
                  , P_SOB_ID            => P_SOB_ID
                  , P_ORG_ID            => P_ORG_ID
                  , P_REPORT_FILE       => V_RECORD_FILE
                  , P_SORT_NUM          => 5 + (0.00001 * V_SEQ_NO)
                  );
                --DBMS_OUTPUT.PUT_LINE(V_RECORD_FILE); 
              END IF;
            END IF;
--G1 END ---------------------------------------------------------------------------------
          END IF;  -- �ܱ��� ���ϼ��� ���� ���Ұ�츸 ����.
          END LOOP C1;    
        END LOOP B1;
    END LOOP A1;
  END SET_YEAR_ADJUST_FILE_2013_1;            


-------------------------------------------------------------------------------
-- 2013�⵵ �ٷμҵ� ���ϻ���.
-------------------------------------------------------------------------------
  PROCEDURE SET_YEAR_ADJUST_FILE_2013
            ( P_YEAR_YYYY         IN  VARCHAR2
            , P_START_DATE        IN  HRA_YEAR_ADJUSTMENT.SUBMIT_DATE%TYPE
            , P_END_DATE          IN  HRA_YEAR_ADJUSTMENT.SUBMIT_DATE%TYPE
            , P_CORP_ID           IN  HRA_YEAR_ADJUSTMENT.CORP_ID%TYPE
            , P_OPERATING_UNIT_ID IN  NUMBER 
            , P_SOB_ID            IN  HRA_YEAR_ADJUSTMENT.SOB_ID%TYPE
            , P_ORG_ID            IN  HRA_YEAR_ADJUSTMENT.ORG_ID%TYPE
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
    V_G_REC_STD                 CONSTANT NUMBER := 3;    
    V_SEQ_NO                    NUMBER;          -- ���ڵ� ���� ��ȣ.
    V_RECORD_FILE               VARCHAR2(3000);  -- �ξ簡�� ��������.
    
    V_REC_TEMP_1                VARCHAR2(300);   
    V_REC_TEMP_2                VARCHAR2(300);   
  BEGIN
    
    -- �����ü ����--.
--A1 ------------------------------------------------------------------------------------
    FOR A1 IN ( SELECT 'A'   -- �ڷ������ȣ.
                    || '20'  -- �����ٷμҵ�(20);
                    || LPAD(REPLACE(OU.TAX_OFFICE_CODE, '-', ''), 3, 0)  -- ������ �ڵ�;
                    || TO_CHAR(P_WRITE_DATE, 'YYYYMMDD')  -- �ڷḦ �������� �����ϴ� ������;
                    --> ������;
                    || LPAD(NVL(P_SUBMIT_AGENT, '2'), 1, 0)  -- �����ڱ���(�����븮��1, ����2, ����3);
                    || RPAD(NVL(P_TAX_AGENT, ' '), 6, ' ')  -- �����븮�� ������ȣ(�ڷ������ڰ� �����븮���ΰ�� ����);
                    || RPAD(NVL(P_HOMETAX_LOGIN_ID, ' '), 20, ' ')  -- Ȩ�ý�ID;
                    || RPAD(NVL(P_TAX_PROGRAM_CODE, '1001'), 4, ' ')  -- �������α׷��ڵ�;
                    || RPAD(NVL(REPLACE(OU.VAT_NUMBER, '-', ''), ' '), 10, ' ')  -- ����ڵ�Ϲ�ȣ;
                    || RPAD(NVL(REPLACE(CM.CORP_NAME, ' ', ''), ' '), 40, ' ')  -- ���θ�(��ȣ);
                    || RPAD(NVL(REPLACE(S_PM.DEPT_NAME, ' ', ''), ' '), 30, ' ')  -- �����(������) �μ�;
                    || RPAD(NVL(REPLACE(S_PM.NAME, ' ', ''), ' '), 30, ' ')  -- �����(������) ����;
                    || RPAD(NVL(REPLACE(CM.TEL_NUMBER, '-', ''), ' '), 15, ' ')  -- �����(������) ��ȭ��ȣ;
                    --> ���⳻��.
                    || LPAD(1, 5, 0)  -- �Ű��ǹ��ڼ� (B���ڵ�);
                    || LPAD(NVL(P_USE_LANGUAGE_CODE, '101'), 3, 0)  -- ����ѱ��ڵ�;
                    || RPAD(' ', 1222, ' ') AS RECORD_FILE
                    , CM.CORP_NAME  -- ���θ�.
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
                  /*AND OU.OPERATING_UNIT_ID  = P_OPERATING_UNIT_ID */
                  AND CM.SOB_ID             = P_SOB_ID
                  AND CM.ORG_ID             = P_ORG_ID
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
                      || '20'  -- �����ٷμҵ�(20);
                      || LPAD(REPLACE(OU.TAX_OFFICE_CODE, '-', ''), 3, 0)   -- �������ڵ�; 
                      || LPAD(1, 6, 0)                                      -- B���ڵ��� �Ϸù�ȣ;
                      --> ������;
                      || RPAD(NVL(REPLACE(OU.VAT_NUMBER, '-', ''), ' '), 10, ' ')  -- ��õ¡���ǹ����� ����ڵ�Ϲ�ȣ;
                      || RPAD(NVL(REPLACE(CM.CORP_NAME, ' ', ''), ' '), 40, ' ')  -- ���θ�(��ȣ);
                      || RPAD(NVL(REPLACE(CM.PRESIDENT_NAME, ' ', ''), ' '), 30, ' ')  -- ��ǥ�� ����;
                      || RPAD(NVL(REPLACE(CM.LEGAL_NUMBER, '-', ''), ' '), 13, ' ') -- ���ε�Ϲ�ȣ;
                      --> ���⳻��;
                      || LPAD(NVL(S_YA.NOW_WORKER_COUNT, 0), 7, 0)   -- 9.������ C���ڵ��� ��(�ٷμҵ����� ��);
                      || LPAD(NVL(S_PW.PRE_WORKER_COUNT, 0), 7, 0)   -- 10.������ D���ڵ�(���ٹ�ó)�� ��(C���ڵ� �׸�6�� �հ�)
                      || LPAD(NVL(S_YA.INCOME_TOT_AMT, 0), 14, 0)    -- 11.�ѱ޿� �Ѱ�(C���ڵ� �޿� ��);
                      || LPAD(NVL(S_YA.FIX_IN_TAX, 0), 13, 0)        -- �ҵ漼 �������� �Ѱ�(C���ڵ� �ҵ漼�� ��);
                      || LPAD(NVL(S_YA.FIX_LOCAL_TAX, 0), 13, 0)     -- �ֹμ� �������� �Ѱ�;
                      || LPAD(NVL(S_YA.FIX_SP_TAX, 0), 13, 0)        -- ��Ư�� �������� �Ѱ�;
                      || LPAD(NVL(S_YA.FIX_TOTAL_TAX, 0) - NVL(S_YA.FIX_LEGAL_TAX, 0), 13, 0)  -- �������� �Ѱ�;
                      -- LPAD(NVL(S_YA.FIX_TOTAL_TAX, 0), 13, 0)  -- �������� �Ѱ� : 2009�� �������� ���� ���������Ѱ�-���μ� �������� �Ѱ�;
                      || LPAD(NVL(P_SUBMIT_PERIOD, '1'), 1, 0)   -- (�����ջ� : 1, ��/����� ���� �������� : 2, ���� �������� : 3);
                      || RPAD(' ', 1214, ' ') AS RECORD_FILE
                      , LPAD(REPLACE(OU.TAX_OFFICE_CODE, '-', ''), 3, 0) AS TAX_OFFICE_CODE
                      , RPAD(NVL(REPLACE(OU.VAT_NUMBER, '-', ''), ' '), 10, ' ') AS VAT_NUMBER
                    FROM HRM_CORP_MASTER CM
                       , HRM_OPERATING_UNIT OU
                       , ( -- ���⳻��.
                           SELECT YA.YEAR_YYYY
                               --, T1.OPERATING_UNIT_ID 
                               , COUNT(YA.PERSON_ID) AS NOW_WORKER_COUNT
                               , SUM(CASE
                                       WHEN NVL(YA.FOREIGN_FIX_TAX_YN, 'N') = 'N' THEN YA.INCOME_TOT_AMT
                                       ELSE (NVL(YA.NOW_PAY_TOT_AMT, 0) + NVL(YA.NOW_BONUS_TOT_AMT, 0) +
                                             NVL(YA.NOW_ADD_BONUS_AMT, 0) + NVL(YA.NOW_STOCK_BENE_AMT, 0) +
                                             NVL(YA.PRE_PAY_TOT_AMT, 0) + NVL(YA.PRE_BONUS_TOT_AMT, 0) +
                                             NVL(YA.PRE_ADD_BONUS_AMT, 0) + NVL(YA.PRE_STOCK_BENE_AMT, 0) +
                                             NVL(YA.INCOME_OUTSIDE_AMT, 0) +
                                             NVL(YA.NOW_EMPLOYEE_STOCK_AMT, 0) + NVL(YA.NOW_OFFICE_RETIRE_OVER_AMT, 0) +
                                             NVL(YA.PRE_EMPLOYEE_STOCK_AMT, 0) + NVL(YA.PRE_OFFICE_RETIRE_OVER_AMT, 0) + 
                                             -- ����� 
                                             NVL(YA.NONTAX_OUTSIDE_AMT, 0) + NVL(YA.NONTAX_OT_AMT, 0) +  
                                             NVL(YA.NONTAX_RESEA_AMT, 0) + NVL(YA.NONTAX_ETC_AMT, 0) +
                                             NVL(YA.NONTAX_BIRTH_AMT, 0) + NVL(YA.NONTAX_FOREIGNER_AMT, 0) +
                                             NVL(YA.NONTAX_SCH_EDU_AMT, 0) + NVL(YA.NONTAX_MEMBER_AMT, 0) +
                                             NVL(YA.NONTAX_GUARD_AMT, 0) + NVL(YA.NONTAX_CHILD_AMT, 0) + 
                                             NVL(YA.NONTAX_HIGH_SCH_AMT, 0) + NVL(YA.NONTAX_SPECIAL_AMT, 0) +
                                             NVL(YA.NONTAX_RESEARCH_AMT, 0) + NVL(YA.NONTAX_COMPANY_AMT, 0) + 
                                             NVL(YA.NONTAX_COVER_AMT, 0) + NVL(YA.NONTAX_WILD_AMT, 0) + 
                                             NVL(YA.NONTAX_DISASTER_AMT, 0) + NVL(YA.NONTAX_OUTS_GOVER_AMT, 0) + 
                                             NVL(YA.NONTAX_OUTS_ARMY_AMT, 0) + NVL(YA.NONTAX_STOCK_BENE_AMT, 0) + 
                                             NVL(YA.NONTAX_FOR_ENG_AMT, 0) + NVL(YA.NONTAX_EMPL_STOCK_AMT, 0) + 
                                             NVL(YA.NONTAX_EMPL_BENE_AMT_1, 0) + NVL(YA.NONTAX_EMPL_BENE_AMT_2, 0) + 
                                             NVL(YA.NONTAX_HOUSE_SUBSIDY_AMT, 0) + NVL(YA.NONTAX_SEA_RESOURCE_AMT, 0) +
                                             -- ����-- 
                                             NVL(YA.PRE_NT_OUTSIDE_AMT, 0) + NVL(YA.PRE_NT_OT_AMT, 0) +  
                                             NVL(YA.PRE_NT_RESEA_AMT, 0) + NVL(YA.PRE_NT_ETC_AMT, 0) +
                                             NVL(YA.PRE_NT_BIRTH_AMT, 0) + NVL(YA.PRE_NT_FOREIGNER_AMT, 0) +
                                             NVL(YA.PRE_NT_SCH_EDU_AMT, 0) + NVL(YA.PRE_NT_MEMBER_AMT, 0) +
                                             NVL(YA.PRE_NT_GUARD_AMT, 0) + NVL(YA.PRE_NT_CHILD_AMT, 0) + 
                                             NVL(YA.PRE_NT_HIGH_SCH_AMT, 0) + NVL(YA.PRE_NT_SPECIAL_AMT, 0) +
                                             NVL(YA.PRE_NT_RESEARCH_AMT, 0) + NVL(YA.PRE_NT_COMPANY_AMT, 0) + 
                                             NVL(YA.PRE_NT_COVER_AMT, 0) + NVL(YA.PRE_NT_WILD_AMT, 0) + 
                                             NVL(YA.PRE_NT_DISASTER_AMT, 0) + NVL(YA.PRE_NT_OUTS_GOVER_AMT, 0) + 
                                             NVL(YA.PRE_NT_OUTS_ARMY_AMT, 0) + NVL(YA.PRE_NT_STOCK_BENE_AMT, 0) + 
                                             NVL(YA.PRE_NT_FOR_ENG_AMT, 0) + NVL(YA.PRE_NT_EMPL_STOCK_AMT, 0) + 
                                             NVL(YA.PRE_NT_EMPL_BENE_AMT_1, 0) + NVL(YA.PRE_NT_EMPL_BENE_AMT_2, 0) + 
                                             NVL(YA.PRE_NT_HOUSE_SUBSIDY_AMT, 0) + NVL(YA.PRE_NT_SEA_RESOURCE_AMT, 0))
                                     END) AS INCOME_TOT_AMT  -- 
                               , SUM(YA.FIX_IN_TAX_AMT) AS FIX_IN_TAX
                               , 0 AS FIX_LEGAL_TAX
                               , SUM(YA.FIX_LOCAL_TAX_AMT) AS FIX_LOCAL_TAX
                               , SUM(YA.FIX_SP_TAX_AMT) AS FIX_SP_TAX
                               , SUM(NVL(YA.FIX_IN_TAX_AMT, 0) +
                                     NVL(YA.FIX_LOCAL_TAX_AMT, 0) +
                                     NVL(YA.FIX_SP_TAX_AMT, 0)) AS FIX_TOTAL_TAX
                             FROM HRA_YEAR_ADJUSTMENT YA
                               , HRM_PERSON_MASTER    PM
                               /*, (-- ���� �λ系��.
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
                            WHERE YA.PERSON_ID          = PM.PERSON_ID
                              --AND PM.PERSON_ID          = T1.PERSON_ID 
                              --AND T1.OPERATING_UNIT_ID  = A1.OPERATING_UNIT_ID 
                              AND YA.CORP_ID            = A1.CORP_ID
                              AND YA.YEAR_YYYY          = P_YEAR_YYYY
                              AND YA.SOB_ID             = P_SOB_ID
                              AND YA.ORG_ID             = P_ORG_ID
                              AND YA.SUBMIT_DATE        BETWEEN P_START_DATE AND P_END_DATE
                              AND NVL(YA.INCOME_TOT_AMT, 0) != 0
                              AND YA.ADJUST_DATE_TO     BETWEEN P_START_DATE AND P_END_DATE
                            GROUP BY YA.YEAR_YYYY
                                  --, T1.OPERATING_UNIT_ID 
                         ) S_YA
                       , ( -- �����ٹ��� �ڷ��.
                          SELECT PW.YEAR_YYYY
                               --, T1.OPERATING_UNIT_ID 
                               , COUNT(PW.PERSON_ID) AS PRE_WORKER_COUNT 
                            FROM HRA_YEAR_ADJUSTMENT YA
                              , HRA_PREVIOUS_WORK PW
                              , HRM_PERSON_MASTER PM
                              /*, (-- ���� �λ系��.
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
                           WHERE YA.YEAR_YYYY           = PW.YEAR_YYYY
                             AND YA.PERSON_ID           = PW.PERSON_ID
                             AND PW.PERSON_ID           = PM.PERSON_ID
                             --AND PM.PERSON_ID           = T1.PERSON_ID 
                             --AND T1.OPERATING_UNIT_ID   = A1.OPERATING_UNIT_ID 
                             AND PW.YEAR_YYYY           = P_YEAR_YYYY
                             AND PM.CORP_ID             = A1.CORP_ID
                             AND PW.SOB_ID              = P_SOB_ID
                             AND PW.ORG_ID              = P_ORG_ID
                             AND YA.SUBMIT_DATE         BETWEEN P_START_DATE AND P_END_DATE
                             AND NVL(YA.INCOME_TOT_AMT, 0) != 0
                             AND YA.ADJUST_DATE_TO      BETWEEN P_START_DATE AND P_END_DATE
                           GROUP BY PW.YEAR_YYYY
                                  --, T1.OPERATING_UNIT_ID
                          ) S_PW
                    WHERE CM.CORP_ID            = OU.CORP_ID
                      AND P_YEAR_YYYY           = S_YA.YEAR_YYYY
                      --AND OU.OPERATING_UNIT_ID  = S_YA.OPERATING_UNIT_ID
                      AND P_YEAR_YYYY           = S_PW.YEAR_YYYY(+)                      
                      --AND OU.OPERATING_UNIT_ID  = S_PW.OPERATING_UNIT_ID(+)
                      AND OU.CORP_ID            = A1.CORP_ID 
                      --AND OU.OPERATING_UNIT_ID  = A1.OPERATING_UNIT_ID
                      AND (OU.DEFAULT_FLAG      = 'Y'
                        OR (OU.DEFAULT_FLAG     = 'N'
                        AND ROWNUM              <= 1)) 
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
                        || '20'                                         -- 2.AS DATA_TYPE
                        || RPAD(NVL(B1.TAX_OFFICE_CODE, ' '), 3, ' ')   -- 3.�������ڵ�.
                        || LPAD(ROW_NUMBER() OVER(PARTITION BY YA.YEAR_YYYY ORDER BY PM.PERSON_NUM), 6, 0)   -- 4.�Ϸù�ȣ.
                        || LPAD(NVL(B1.VAT_NUMBER, ' '), 10, ' ')       -- 5.����ڹ�ȣ.
                        || LPAD(NVL(S_PW.PRE_WORK_COUNT, 0), 2, 0)      -- 6.��(��)�ٹ�ó ��;
                        || LPAD(NVL(PM.RESIDENT_TYPE, '1'), 1, 0)       -- 7.������ �����ڵ�(������:1, �������:2);
                        || RPAD(CASE 
                                  WHEN PM.RESIDENT_TYPE = '1' THEN ' '
                                  WHEN SUBSTR(REPLACE(PM.REPRE_NUM, '-', ''), 7, 1) BETWEEN '1' AND '4' THEN ' '  -- 1900, 2000���.
                                  WHEN SUBSTR(REPLACE(PM.REPRE_NUM, '-', ''), 7, 1) BETWEEN '9' AND '0' THEN ' '  -- 1800����..
                                  ELSE NVL(S_HN.ISO_NATION_CODE, ' ')
                                END, 2, ' ')  -- 8.�ű����� �ڵ� : ������ڸ� ���, �����ڴ� ����;
                        || LPAD(DECODE(NVL(YA.FOREIGN_FIX_TAX_YN, 'N'), 'Y', 1, 2), 1, 0)  -- 9.�ܱ��δ��ϼ�������(����:1, ������:2);
                        || RPAD(NVL(REPLACE(PM.NAME, ' ', ''), ' '), 30, ' ')  -- 10.����;
                        || RPAD(CASE
                                  WHEN PM.NATIONALITY_TYPE IS NOT NULL THEN PM.NATIONALITY_TYPE
                                  WHEN SUBSTR(REPLACE(PM.REPRE_NUM, '-', ''), 7, 1) BETWEEN '5' AND '8' THEN '9'
                                  ELSE '1'
                                END, 1, 0)  -- 11.��/�ܱ��� �����ڵ�;
                        || RPAD(NVL(REPLACE(PM.REPRE_NUM, '-', ''), ' '), 13, ' ')  -- 12.�ֹε�Ϲ�ȣ;
                        || RPAD(CASE
                                  WHEN PM.NATIONALITY_TYPE = '9' THEN NVL(S_HN.ISO_NATION_CODE, ' ')
                                  WHEN SUBSTR(REPLACE(PM.REPRE_NUM, '-', ''), 7, 1) BETWEEN '5' AND '8' THEN NVL(S_HN.ISO_NATION_CODE, ' ')
                                  ELSE ' '
                                END, 2, ' ')  -- 13.�����ڵ�(�ܱ����� ��츸 ����);
                        || RPAD(NVL(PM.HOUSEHOLD_TYPE, '1'), 1, 0)  -- 14.�����ֿ���.
                        || RPAD(CASE 
                                  WHEN (PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE > TO_DATE(P_YEAR_YYYY||'-12-31','YYYY-MM-DD')) THEN '1'
                                  ELSE '2' 
                                END, 1, 0)  -- 15.�������걸��(��ӱٷ�: 1, �ߵ����:2).
                        || RPAD(NVL(B1.VAT_NUMBER, ' '), 10, ' ')  -- 16.�����ٹ�ó ����ڵ�Ϲ�ȣ;
                        || RPAD(NVL(A1.CORP_NAME, ' '), 40, ' ')  -- 17.�����ٹ�ó ���θ�(��ȣ);
                        || RPAD(TO_CHAR(YA.ADJUST_DATE_FR, 'YYYYMMDD'), 8, 0)  -- 18.�ٹ��Ⱓ ���ۿ�����;
                        || RPAD(TO_CHAR(YA.ADJUST_DATE_TO, 'YYYYMMDD'), 8, 0)  -- 19.�ٹ��Ⱓ ���Ῥ����;
                        || LPAD(0, 8, 0)  -- 20.����Ⱓ ���ۿ�����;
                        || LPAD(0, 8, 0)  -- 21.����Ⱓ ���Ῥ����;
                        --> �ٹ�ó�� �ҵ��-��(��)�ٹ�ó �ѱ޿�.
                        || LPAD(NVL(YA.NOW_PAY_TOT_AMT, 0)+ 
                                NVL(YA.INCOME_OUTSIDE_AMT, 0), 11, 0)  -- 22.�޿��Ѿ�;
                        || LPAD(NVL(YA.NOW_BONUS_TOT_AMT, 0), 11, 0) -- 23.���Ѿ�;
                        || LPAD(NVL(YA.NOW_ADD_BONUS_AMT, 0), 11, 0) -- 24.������;
                        || LPAD(NVL(YA.NOW_STOCK_BENE_AMT, 0), 11, 0) -- 25.�ֽĸż����ñ��������;
                        ----> 2009�� �������� ����(�츮������������� �߰�);
                        || LPAD(0, 11, 0) -- 26.�츮�������������(�迡�� �������� �ʾ���);
                        || LPAD(NVL(YA.NOW_OFFICE_RETIRE_OVER_AMT, 0), 11, 0)  -- 27.2013�⵵ �߰� : �ӿ� �����ҵ�ݾ� �ѵ��ʰ���  
                        || LPAD(0, 22, 0) -- 28.����;
                        || LPAD(NVL(YA.NOW_PAY_TOT_AMT, 0) +
                                NVL(YA.NOW_BONUS_TOT_AMT, 0) +
                                NVL(YA.NOW_ADD_BONUS_AMT, 0) +
                                NVL(YA.NOW_STOCK_BENE_AMT, 0) + 
                                NVL(YA.INCOME_OUTSIDE_AMT, 0) +
                                NVL(YA.NOW_OFFICE_RETIRE_OVER_AMT, 0), 11, 0) -- 29.�޿��Ѿ�(�׸�22)+���Ѿ�(�׸�23)+������(�׸�24)+ �ֽĸż����ñ��������(�׸�25)+�츮�������������(�׸�26)+ �ӿ������ҵ��ѵ��ʰ���(�׸�27)
                        --> ��(��)�ٹ�ó ����� �ҵ�.
                        -- 2009�� �������� ����(��(��)�ٹ�ó ����� �ҵ� ����);
                        || LPAD(NVL(YA.NONTAX_SCH_EDU_AMT, 0), 10, 0) -- 30.�����-���ڱ�;
                        || LPAD(NVL(YA.NONTAX_MEMBER_AMT, 0), 10, 0) -- 31.�����-��������������;
                        || LPAD(NVL(YA.NONTAX_GUARD_AMT, 0), 10, 0) -- 32.�����-��ȣ/�¼�����;
                        || LPAD(NVL(YA.NONTAX_CHILD_AMT, 0), 10, 0) -- 33.�����-����/���ߵ�_��������/Ȱ����;
                        || LPAD(NVL(YA.NONTAX_HIGH_SCH_AMT, 0), 10, 0) -- 34.�����-����_��������/Ȱ����;
                        || LPAD(NVL(YA.NONTAX_SPECIAL_AMT, 0), 10, 0) -- 35.�����-Ư���������������_��������/Ȱ����;
                        || LPAD(NVL(YA.NONTAX_RESEARCH_AMT, 0), 10, 0) -- 36.�����-�������_��������/Ȱ����;
                        || LPAD(NVL(YA.NONTAX_COMPANY_AMT, 0), 10, 0) -- 37.�����-���������_��������/Ȱ����;
                        -- ��ȣ�� : 2012�⵵ �߰� BEGIN --
                        || LPAD(0, 10, 0)  -- 38.����� : �������� �ٹ�ȯ�氳����.
                        || LPAD(0, 10, 0)  -- 39.����� : �縳��ġ�� ��������/������ �ΰǺ�.
                        -- END --
                        || LPAD(NVL(YA.NONTAX_COVER_AMT, 0), 10, 0) -- 40.�����-�������;
                        || LPAD(NVL(YA.NONTAX_WILD_AMT, 0), 10, 0) -- 41.�����-��������;
                        || LPAD(NVL(YA.NONTAX_DISASTER_AMT, 0), 10, 0) -- 42.�����-���ذ��ñ޿�;
                        || LPAD(0, 10, 0)  -- 43.2013�⵵ �߰� : ����/�������  ����������� ������ ���ּ���; 
                        || LPAD(NVL(YA.NONTAX_OUTS_GOVER_AMT, 0), 10, 0) -- 44.�����-�ܱ����ε�ٹ���;
                        || LPAD(NVL(YA.NONTAX_OUTS_ARMY_AMT, 0), 10, 0) -- 45.�����-�ܱ��ֵб��ε�;
                        || LPAD(NVL(YA.NONTAX_OUTS_WORK_1, 0), 10, 0) -- 46.�����-���ܱٷ�(100����);
                        || LPAD(NVL(YA.NONTAX_OUTS_WORK_2, 0), 10, 0) -- 47.���ܱٷ�200����(300����);
                        || LPAD(NVL(YA.NONTAX_OUTSIDE_AMT, 0), 10, 0) -- 48.����� ���ܼҵ�;
                        || LPAD(NVL(YA.NONTAX_OT_AMT, 0), 10, 0) -- 49.����� �߰��ٷ�;
                        || LPAD(NVL(YA.NONTAX_BIRTH_AMT, 0), 10, 0) -- 50.����� ���/��������;
                        || LPAD(0, 10, 0)  -- 51.�ٷ����б�.
                        || LPAD(NVL(YA.NONTAX_STOCK_BENE_AMT, 0), 10, 0) -- 52.�����-�ֽĸż����ñ�;
                        || LPAD(NVL(YA.NONTAX_FOR_ENG_AMT, 0), 10, 0) -- 53.�����-�ܱ��α����;
                        || LPAD(NVL(YA.NONTAX_EMPL_BENE_AMT_1, 0), 10, 0) -- 54.�����-�츮�������������(50%);
                        || LPAD(NVL(YA.NONTAX_EMPL_BENE_AMT_2, 0), 10, 0) -- 55.�����-�츮�������������(75%);
                        || LPAD(0, 10, 0) -- 56.�����-��������� �߼ұ�� ���;
                        --|| LPAD(NVL(YA.NONTAX_HOUSE_SUBSIDY_AMT, 0), 10, 0) -- �����-�����ڱݺ�����(X);
                        || LPAD(NVL(YA.NONTAX_SEA_RESOURCE_AMT, 0), 10, 0) -- 57.�����-���������ڿ�����;
                        -- ��ȣ�� �߰� : 2012�⵵ ���� BEGIN --
                        || LPAD(0, 10, 0)  -- 58.�����Ǽ��ú�������.
                        || LPAD(0, 10, 0)  -- 59.�߼ұ�� ��� û�� �ҵ漼 ����;
                        || LPAD(0, 10, 0)  -- 60.��������� ������ ����;
                        --|| LPAD(0, 10, 0) -- ���������;
                        -- ��ȣ�� �߰� : 2012�⵵ ���� END --
                        -- ����� ��;
                        || LPAD( NVL(YA.NONTAX_OUTSIDE_AMT, 0) + NVL(YA.NONTAX_OT_AMT, 0) +  -- NONTAX_OUTSIDE_AMT : ����� ���ܱٷ� �հ� 
                                 NVL(YA.NONTAX_RESEA_AMT, 0) + NVL(YA.NONTAX_ETC_AMT, 0) +
                                 NVL(YA.NONTAX_BIRTH_AMT, 0) + NVL(YA.NONTAX_FOREIGNER_AMT, 0) +
                                 NVL(YA.NONTAX_SCH_EDU_AMT, 0) + NVL(YA.NONTAX_MEMBER_AMT, 0) +
                                 NVL(YA.NONTAX_GUARD_AMT, 0) + NVL(YA.NONTAX_CHILD_AMT, 0) + 
                                 NVL(YA.NONTAX_HIGH_SCH_AMT, 0) + NVL(YA.NONTAX_SPECIAL_AMT, 0) +
                                 NVL(YA.NONTAX_RESEARCH_AMT, 0) + NVL(YA.NONTAX_COMPANY_AMT, 0) + 
                                 NVL(YA.NONTAX_COVER_AMT, 0) + NVL(YA.NONTAX_WILD_AMT, 0) + 
                                 NVL(YA.NONTAX_DISASTER_AMT, 0) + NVL(YA.NONTAX_OUTS_GOVER_AMT, 0) + 
                                 NVL(YA.NONTAX_OUTS_ARMY_AMT, 0) + NVL(YA.NONTAX_STOCK_BENE_AMT, 0) + 
                                 NVL(YA.NONTAX_FOR_ENG_AMT, 0) + NVL(YA.NONTAX_EMPL_STOCK_AMT, 0) + 
                                 NVL(YA.NONTAX_EMPL_BENE_AMT_1, 0) + NVL(YA.NONTAX_EMPL_BENE_AMT_2, 0) + 
                                 NVL(YA.NONTAX_HOUSE_SUBSIDY_AMT, 0) + NVL(YA.NONTAX_SEA_RESOURCE_AMT, 0) +
                                 -- ����-- 
                                 NVL(YA.PRE_NT_OUTSIDE_AMT, 0) + NVL(YA.PRE_NT_OT_AMT, 0) +  -- NONTAX_OUTSIDE_AMT : ����� ���ܱٷ� �հ�  
                                 NVL(YA.PRE_NT_RESEA_AMT, 0) + NVL(YA.PRE_NT_ETC_AMT, 0) +
                                 NVL(YA.PRE_NT_BIRTH_AMT, 0) + NVL(YA.PRE_NT_FOREIGNER_AMT, 0) +
                                 NVL(YA.PRE_NT_SCH_EDU_AMT, 0) + NVL(YA.PRE_NT_MEMBER_AMT, 0) +
                                 NVL(YA.PRE_NT_GUARD_AMT, 0) + NVL(YA.PRE_NT_CHILD_AMT, 0) + 
                                 NVL(YA.PRE_NT_HIGH_SCH_AMT, 0) + NVL(YA.PRE_NT_SPECIAL_AMT, 0) +
                                 NVL(YA.PRE_NT_RESEARCH_AMT, 0) + NVL(YA.PRE_NT_COMPANY_AMT, 0) + 
                                 NVL(YA.PRE_NT_COVER_AMT, 0) + NVL(YA.PRE_NT_WILD_AMT, 0) + 
                                 NVL(YA.PRE_NT_DISASTER_AMT, 0) + NVL(YA.PRE_NT_OUTS_GOVER_AMT, 0) + 
                                 NVL(YA.PRE_NT_OUTS_ARMY_AMT, 0) + NVL(YA.PRE_NT_STOCK_BENE_AMT, 0) + 
                                 NVL(YA.PRE_NT_FOR_ENG_AMT, 0) + NVL(YA.PRE_NT_EMPL_STOCK_AMT, 0) + 
                                 NVL(YA.PRE_NT_EMPL_BENE_AMT_1, 0) + NVL(YA.PRE_NT_EMPL_BENE_AMT_2, 0) + 
                                 NVL(YA.PRE_NT_HOUSE_SUBSIDY_AMT, 0) + NVL(YA.PRE_NT_SEA_RESOURCE_AMT, 0) 
                                --NVL(YA.NONTAX_HOUSE_SUBSIDY_AMT, 0) +                       
                                --NVL(YA.NONTAX_SEA_RESOURCE_AMT, 0))  -- ���������ڿ�����(����ҵ� ��� �̵�);
                                --NVL(YA.NONTAX_ETC_AMT, 0),
                                , 10, 0)  -- 61.�������.
                        || LPAD(NVL(YA.NONTAX_FOR_ENG_AMT, 0) + NVL(YA.NONTAX_SEA_RESOURCE_AMT, 0), 10, 0)    -- 62����ҵ��(�׸�53 + �׸�57);
                        --> �����.
                        || LPAD( CASE
                                   WHEN NVL(YA.FOREIGN_FIX_TAX_YN, 'N') = 'N' THEN NVL(YA.INCOME_TOT_AMT, 0)
                                   ELSE (NVL(YA.NOW_PAY_TOT_AMT, 0) + NVL(YA.NOW_BONUS_TOT_AMT, 0) +
                                         NVL(YA.NOW_ADD_BONUS_AMT, 0) + NVL(YA.NOW_STOCK_BENE_AMT, 0) +
                                         NVL(YA.PRE_PAY_TOT_AMT, 0) + NVL(YA.PRE_BONUS_TOT_AMT, 0) +
                                         NVL(YA.PRE_ADD_BONUS_AMT, 0) + NVL(YA.PRE_STOCK_BENE_AMT, 0) +
                                         NVL(YA.INCOME_OUTSIDE_AMT, 0) +
                                         NVL(YA.NOW_EMPLOYEE_STOCK_AMT, 0) + NVL(YA.NOW_OFFICE_RETIRE_OVER_AMT, 0) +
                                         NVL(YA.PRE_EMPLOYEE_STOCK_AMT, 0) + NVL(YA.PRE_OFFICE_RETIRE_OVER_AMT, 0) + 
                                         -- ����� 
                                         NVL(YA.NONTAX_OUTSIDE_AMT, 0) + NVL(YA.NONTAX_OT_AMT, 0) +  
                                         NVL(YA.NONTAX_RESEA_AMT, 0) + NVL(YA.NONTAX_ETC_AMT, 0) +
                                         NVL(YA.NONTAX_BIRTH_AMT, 0) + NVL(YA.NONTAX_FOREIGNER_AMT, 0) +
                                         NVL(YA.NONTAX_SCH_EDU_AMT, 0) + NVL(YA.NONTAX_MEMBER_AMT, 0) +
                                         NVL(YA.NONTAX_GUARD_AMT, 0) + NVL(YA.NONTAX_CHILD_AMT, 0) + 
                                         NVL(YA.NONTAX_HIGH_SCH_AMT, 0) + NVL(YA.NONTAX_SPECIAL_AMT, 0) +
                                         NVL(YA.NONTAX_RESEARCH_AMT, 0) + NVL(YA.NONTAX_COMPANY_AMT, 0) + 
                                         NVL(YA.NONTAX_COVER_AMT, 0) + NVL(YA.NONTAX_WILD_AMT, 0) + 
                                         NVL(YA.NONTAX_DISASTER_AMT, 0) + NVL(YA.NONTAX_OUTS_GOVER_AMT, 0) + 
                                         NVL(YA.NONTAX_OUTS_ARMY_AMT, 0) + NVL(YA.NONTAX_STOCK_BENE_AMT, 0) + 
                                         NVL(YA.NONTAX_FOR_ENG_AMT, 0) + NVL(YA.NONTAX_EMPL_STOCK_AMT, 0) + 
                                         NVL(YA.NONTAX_EMPL_BENE_AMT_1, 0) + NVL(YA.NONTAX_EMPL_BENE_AMT_2, 0) + 
                                         NVL(YA.NONTAX_HOUSE_SUBSIDY_AMT, 0) + NVL(YA.NONTAX_SEA_RESOURCE_AMT, 0) +
                                         -- ����-- 
                                         NVL(YA.PRE_NT_OUTSIDE_AMT, 0) + NVL(YA.PRE_NT_OT_AMT, 0) +  
                                         NVL(YA.PRE_NT_RESEA_AMT, 0) + NVL(YA.PRE_NT_ETC_AMT, 0) +
                                         NVL(YA.PRE_NT_BIRTH_AMT, 0) + NVL(YA.PRE_NT_FOREIGNER_AMT, 0) +
                                         NVL(YA.PRE_NT_SCH_EDU_AMT, 0) + NVL(YA.PRE_NT_MEMBER_AMT, 0) +
                                         NVL(YA.PRE_NT_GUARD_AMT, 0) + NVL(YA.PRE_NT_CHILD_AMT, 0) + 
                                         NVL(YA.PRE_NT_HIGH_SCH_AMT, 0) + NVL(YA.PRE_NT_SPECIAL_AMT, 0) +
                                         NVL(YA.PRE_NT_RESEARCH_AMT, 0) + NVL(YA.PRE_NT_COMPANY_AMT, 0) + 
                                         NVL(YA.PRE_NT_COVER_AMT, 0) + NVL(YA.PRE_NT_WILD_AMT, 0) + 
                                         NVL(YA.PRE_NT_DISASTER_AMT, 0) + NVL(YA.PRE_NT_OUTS_GOVER_AMT, 0) + 
                                         NVL(YA.PRE_NT_OUTS_ARMY_AMT, 0) + NVL(YA.PRE_NT_STOCK_BENE_AMT, 0) + 
                                         NVL(YA.PRE_NT_FOR_ENG_AMT, 0) + NVL(YA.PRE_NT_EMPL_STOCK_AMT, 0) + 
                                         NVL(YA.PRE_NT_EMPL_BENE_AMT_1, 0) + NVL(YA.PRE_NT_EMPL_BENE_AMT_2, 0) + 
                                         NVL(YA.PRE_NT_HOUSE_SUBSIDY_AMT, 0) + NVL(YA.PRE_NT_SEA_RESOURCE_AMT, 0))
                                 END, 11, 0) -- 63.�ѱ޿�;
                        || LPAD(NVL(YA.INCOME_DED_AMT, 0), 10, 0) -- 64.�ٷμҵ����;
                        || LPAD(NVL(YA.INCOME_TOT_AMT, 0) - NVL(YA.INCOME_DED_AMT, 0), 11, 0) -- 65.�ٷμҵ�ݾ�;
                        --> �⺻����.
                        || LPAD(NVL(YA.PER_DED_AMT, 0), 8, 0) -- 66.���ΰ����ݾ�;
                        || LPAD(NVL(YA.SPOUSE_DED_AMT, 0), 8, 0) -- 67.����ڰ����ݾ�;
                        || LPAD(NVL(YA.SUPP_DED_COUNT, 0), 2, 0) -- 68.�ξ簡�������ο�;
                        || LPAD(NVL(YA.SUPP_DED_AMT, 0), 8, 0) -- 69.�ξ簡�������ݾ�;
                        --> �߰�����.
                        -- 2009�� BEGIN : ��ο������ο� 70���̻� ����;
                        || LPAD(NVL(YA.OLD_DED_COUNT1, 0), 2, 0) -- 70.��ο������ο�;
                        || LPAD(NVL(YA.OLD_DED_AMT1, 0), 8, 0) -- 71.��ο������ݾ�;
                        /*
                        || LPAD(NVL(YA.OLD_DED_COUNT, 0) + NVL(YA.OLD_DED_COUNT1, 0), 2, 0) -- ��ο������ο�;
                        || LPAD(NVL(YA.OLD_DED_AMT, 0) + NVL(YA.OLD_DED_AMT1, 0), 8, 0) -- ��ο������ݾ�;*/
                        -- 2009�� END;
                        || LPAD(NVL(YA.DISABILITY_DED_COUNT, 0), 2, 0) -- 72.����ΰ����ο�;
                        || LPAD(NVL(YA.DISABILITY_DED_AMT, 0), 8, 0) -- 73.����ΰ����ݾ�;
                        || LPAD(NVL(YA.WOMAN_DED_AMT, 0), 8, 0) -- 74.�γ��ڰ����ݾ�;
                        || LPAD(NVL(YA.CHILD_DED_COUNT, 0), 2, 0) -- 75.�ڳ����������ο�;
                        || LPAD(NVL(YA.CHILD_DED_AMT, 0), 8, 0) -- 76.�ڳ����������ݾ�;
                        || LPAD(NVL(YA.BIRTH_DED_COUNT, 0), 2, 0) -- 77.���/�Ծ��ڰ����ο�;
                        || LPAD(NVL(YA.BIRTH_DED_AMT, 0), 8, 0) --  78.���/�Ծ��ڰ����ݾ�;
                        || LPAD(NVL(YA.SINGLE_PARENT_DED_AMT, 0), 10, 0) -- 79.2013�⵵ �߰� : �Ѻθ� ���� �����ݾ�;
                        -- LPAD(NVL(YA.PER_ADD_DED_AMT, 0), 8, 0)   PER_ADD_DED_AMT;
                        --> ���ڳ��߰�����;
                        || LPAD(NVL(YA.MANY_CHILD_DED_COUNT, 0), 2, 0) -- 80.���ڳ��߰������ο�;
                        || LPAD(NVL(YA.MANY_CHILD_DED_AMT, 0), 8, 0) -- 81.���ڳ��߰������ݾ�;
                        -->���ݺ����;
                        || LPAD(NVL(YA.NATI_ANNU_AMT, 0), 10, 0) -- 82.���ο��ݺ�������;
                        || LPAD(NVL(YA.PUBLIC_INSUR_AMT, 0), 10, 0)  -- 83.��Ÿ���ݺ�������_����������;
                        || LPAD(NVL(YA.MARINE_INSUR_AMT, 0), 10, 0)  -- 84.��Ÿ���ݺ�������_���ο���;
                        || LPAD(NVL(YA.SCHOOL_STAFF_INSUR_AMT, 0), 10, 0)  -- 85.��Ÿ���ݺ�������_�縳�б�����������;
                        || LPAD(NVL(YA.POST_OFFICE_INSUR_AMT, 0), 10, 0)  -- 86.��Ÿ���ݺ�������_������ü������;
                        || LPAD(NVL(YA.SCIENTIST_ANNU_AMT, 0), 10, 0)  -- 87.��Ÿ���ݺ�������_���б���ΰ���;
                        || LPAD(NVL(YA.RETR_ANNU_AMT, 0), 10, 0)  -- 88.��Ÿ���ݺ�������_�ٷ��������޿������;
                        || LPAD(NVL(YA.ANNU_BANK_AMT, 0), 10, 0) -- 89.2013�⵵ ���� : ��������ҵ����;
                        --> Ư������.
                        -- ����������;
                        -- 2009�� �������� BEGIN. ���������� 0�� �̸��� ��쿡�� 0�� ó��;
                        || LPAD(CASE 
                                  WHEN NVL(YA.MEDIC_INSUR_AMT, 0) < 0 THEN 0
                                  ELSE NVL(YA.MEDIC_INSUR_AMT, 0) 
                                END, 10, 0)  -- 90.�ǰ������;
                        || LPAD(CASE 
                                  WHEN NVL(YA.HIRE_INSUR_AMT, 0) < 0 THEN 0
                                  ELSE NVL(YA.HIRE_INSUR_AMT, 0) 
                                END, 10, 0)  -- 91.��뺸���;
                        || LPAD(NVL(YA.GUAR_INSUR_AMT, 0), 10, 0)  -- 92.���庸��� ;
                        || LPAD(NVL(YA.DISABILITY_INSUR_AMT, 0), 10, 0)  -- 93.��ֺ���� ;
                        || LPAD(NVL(YA.DISABILITY_MEDIC_AMT, 0), 10, 0)  -- 94.2013�⵵ ���� : �Ƿ������ݾ�-�����;
                        || LPAD(NVL(YA.ETC_MEDIC_AMT, 0), 10, 0)  -- 95.2013�⵵ ���� : �Ƿ������ݾ�-��Ÿ;
                        || LPAD(NVL(YA.DISABILITY_EDUCATION_AMT, 0), 8, 0) -- 96.2013�⵵ ���� : ����������ݾ�-�����;
                        || LPAD(NVL(YA.ETC_EDUCATION_AMT, 0), 8, 0) -- 97.2013�⵵ ���� : ����������ݾ�-��Ÿ;
                        || LPAD(NVL(YA.HOUSE_INTER_AMT, 0), 8, 0) -- 98.�����Ӵ������Աݿ����ݻ�ȯ�����ݾ�(������);
                        || LPAD(NVL(YA.HOUSE_INTER_AMT_ETC, 0), 8, 0)  -- 99.2013�⵵ ���� : �����������Աݿ����ݻ�ȯ��(������).
                        || LPAD(NVL(YA.HOUSE_MONTHLY_AMT, 0), 8, 0)  -- 100.�����ڱ�_������;
                        || LPAD(NVL(YA.LONG_HOUSE_PROF_AMT, 0), 8, 0) -- 101.��������������Ա����ڻ�ȯ�����ݾ�;
                        || LPAD(NVL(YA.LONG_HOUSE_PROF_AMT_1, 0), 8, 0) -- 102.��������������Ա����ڻ�ȯ�����ݾ�(15);
                        || LPAD(NVL(YA.LONG_HOUSE_PROF_AMT_2, 0), 8, 0) -- 103.��������������Ա����ڻ�ȯ�����ݾ�(30);
                        -- ��ȣ�� �߰� : 2012�⵵ �������� BEGIN --
                        || LPAD(NVL(YA.LONG_HOUSE_PROF_AMT_3_FIX, 0), 8, 0) -- 104.12�� ���� ��������������Ա����ڻ�ȯ�����ݾ�(�����ݸ�);
                        || LPAD(NVL(YA.LONG_HOUSE_PROF_AMT_3_ETC, 0), 8, 0) -- 105.12�� ���� ��������������Ա����ڻ�ȯ�����ݾ�(��Ÿ);
                        -- ��ȣ�� �߰� : 2012�⵵ �������� END --
                        || LPAD(NVL(YA.DONAT_DED_POLI_AMT, 0), 11, 0)  -- 106.2013�⵵ ���� : ��ġ�ڱ� ��α�;
                        || LPAD(NVL(YA.DONAT_DED_ALL, 0), 11, 0)  -- 107.2013�⵵ ���� : ������α�;
                        || LPAD(NVL(YA.DONAT_DED_30, 0), 11, 0)  -- 108.013�⵵ ���� : �츮�������� ��α�;
                        || LPAD(NVL(YA.DONAT_DED_RELIGION_10, 0) + 
                                NVL(YA.DONAT_DED_10, 0), 11, 0)  -- 109.2013�⵵ ���� : ������α� ��α� �հ�;
                        || LPAD(0, 20, 0) -- 110.SP_DED_SPACE_VALUE
                        || LPAD(( CASE
                                    WHEN NVL(YA.MEDIC_INSUR_AMT, 0) +
                                        NVL(YA.HIRE_INSUR_AMT, 0) +
                                        NVL(YA.GUAR_INSUR_AMT, 0) +
                                        NVL(YA.DISABILITY_INSUR_AMT, 0) < 0 THEN 0
                                    ELSE NVL(YA.MEDIC_INSUR_AMT, 0) +
                                        NVL(YA.HIRE_INSUR_AMT, 0) +
                                        NVL(YA.GUAR_INSUR_AMT, 0) +
                                        NVL(YA.DISABILITY_INSUR_AMT, 0)
                                  END) +
                                  NVL(YA.MEDIC_AMT, 0) +
                                  NVL(YA.EDUCATION_AMT, 0) +
                                  NVL(YA.HOUSE_INTER_AMT, 0) +
                                  NVL(YA.HOUSE_INTER_AMT_ETC, 0) + 
                                  NVL(YA.HOUSE_MONTHLY_AMT, 0) +
                                  NVL(YA.LONG_HOUSE_PROF_AMT, 0) +
                                  NVL(YA.LONG_HOUSE_PROF_AMT_1, 0) +
                                  NVL(YA.LONG_HOUSE_PROF_AMT_2, 0) +
                                  NVL(YA.LONG_HOUSE_PROF_AMT_3_FIX, 0) +
                                  NVL(YA.LONG_HOUSE_PROF_AMT_3_ETC, 0) +
                                  NVL(YA.DONAT_AMT, 0), 11, 0) -- 111.��;
                        || LPAD(NVL(YA.STAND_DED_AMT, 0), 8, 0) -- 112.ǥ�ذ���;
                        || LPAD(NVL(YA.SUBT_DED_AMT, 0), 11, 0) -- 113.�����ҵ�ݾ�; 
                        --> �� ���� �ҵ����.
                        || LPAD(NVL(YA.PERS_ANNU_BANK_AMT, 0), 8, 0) -- 114.���ο�������ҵ����;
                        || LPAD(NVL(YA.SMALL_CORPOR_DED_AMT, 0), 10, 0) -- 115.�ұ�������αݼҵ����;
                        || LPAD(NVL(YA.HOUSE_APP_DEPOSIT_AMT, 0), 10, 0)  -- 116.��)���ø�������ҵ����-û������;
                        || LPAD(NVL(YA.HOUSE_APP_SAVE_AMT, 0), 10, 0) -- 117.��)���ø�������ҵ����-����û����������;
                        --|| LPAD(NVL(YA.HOUSE_SAVE_AMT, 0), 10, 0)  -- 2013�⵵ ���� : ��)������ø�������.
                        || LPAD(NVL(YA.WORKER_HOUSE_SAVE_AMT, 0), 10, 0)  -- 118.��)�ٷ������ø�������.
                        || LPAD(NVL(YA.INVES_AMT, 0), 10, 0) -- 119.�����������ڵ�ҵ����;
                        || LPAD(NVL(YA.CREDIT_AMT, 0), 8, 0) -- 120.�ſ�ī��� �ҵ����;                        
                        --|| LPAD(CASE
                        --        WHEN NVL(YA.EMPL_STOCK_AMT, 0) < 0 THEN 0
                        --        ELSE 1
                        --      END, 1, 0) -- �츮�������ռҵ����(����̸� 0);
                        || LPAD(NVL(YA.EMPL_STOCK_AMT, 0), 10, 0) -- 121.�츮�������ռҵ����(�ѵ� 400����);
                        --|| LPAD(NVL(YA.LONG_STOCK_SAVING_AMT, 0), 10, 0) -- 2013�⵵ ����(���� ����) : ����ֽ�������ҵ����;
                        -- 2009�� �������� �߰� BEGIN. ��������߼ұ���ٷ��ڼҵ����/���� �߰�;
                        || LPAD(NVL(YA.HIRE_KEEP_EMPLOY_AMT, 0), 10, 0) -- 122.��������߼ұ���ٷ��ڼҵ����;
                        || LPAD(NVL(YA.FIX_LEASE_DED_AMT, 0), 10, 0) -- 123.2013�⵵ �߰� : �񵷾ȵ���������ڻ�ȯ�װ���;
                        -- 2009�� �������� �߰� END --
                        || LPAD((NVL(YA.PERS_ANNU_BANK_AMT, 0) +
                                NVL(YA.SMALL_CORPOR_DED_AMT, 0) +
                                NVL(YA.HOUSE_APP_DEPOSIT_AMT, 0) +
                                NVL(YA.HOUSE_APP_SAVE_AMT, 0) +
                                NVL(YA.WORKER_HOUSE_SAVE_AMT, 0) +
                                NVL(YA.INVES_AMT, 0) +
                                NVL(YA.CREDIT_AMT, 0) +
                                NVL(YA.EMPL_STOCK_AMT, 0) +
                                NVL(YA.HIRE_KEEP_EMPLOY_AMT, 0) + 
                                NVL(YA.FIX_LEASE_DED_AMT, 0)), 10, 0) -- 124.�׹��� �ҵ���� ��(����̸� '0'����);
                        || LPAD(NVL(YA.SP_DED_TOT_AMT, 0), 11, 0) -- 125.Ư������ �����ѵ� �ʰ���;
                        || LPAD(NVL(YA.TAX_STD_AMT, 0), 11, 0) -- 126.���ռҵ� ����ǥ��;
                        || LPAD(NVL(YA.COMP_TAX_AMT, 0), 10, 0) -- 127.���⼼��;
                        --> ���װ���.
                        || LPAD(NVL(YA.TAX_REDU_IN_LAW_AMT, 0), 10, 0) --128.�ҵ漼��;
                        || LPAD(NVL(YA.TAX_REDU_SP_LAW_AMT, 0), 10, 0) -- 129.����Ư�����ѹ�;
                        -- 2012�� �������� �߰� START --
                        || LPAD(0, 10, 0) -- 130.����Ư�����ѹ� : �߼ұ�� ��� û�� �ҵ漼 ����;
                        -- 2012�� �������� �߰� END --
                        || LPAD(NVL(YA.TAX_REDU_TAX_TREATY, 0), 10, 0) -- 131.��������.
                        || LPAD(0, 10, 0) -- 132.����;
                        || LPAD(NVL(YA.TAX_REDU_IN_LAW_AMT, 0) +
                                NVL(YA.TAX_REDU_SP_LAW_AMT, 0) +
                                NVL(YA.TAX_REDU_TAX_TREATY, 0), 10, 0) -- 133.���鼼�װ�;
                        --> ���װ���.
                        || LPAD(NVL(YA.TAX_DED_INCOME_AMT, 0), 10, 0) -- 134.�ٷμҵ漼�װ���;
                        || LPAD(NVL(YA.TAX_DED_TAXGROUP_AMT, 0), 10, 0) -- 135.�������հ���;
                        || LPAD(NVL(YA.TAX_DED_HOUSE_DEBT_AMT, 0), 10, 0) -- 136.�������Ա�;
                        || LPAD(NVL(YA.TAX_DED_DONAT_POLI_AMT, 0), 10, 0) -- 137.�����ġ�ڱ�;
                        || LPAD(NVL(YA.TAX_DED_OUTSIDE_PAY_AMT, 0), 10, 0) -- 138.�ܱ�����;
                        || LPAD(0, 10, 0) -- 139.����;
                        || LPAD(NVL(YA.TAX_DED_INCOME_AMT, 0) +
                                NVL(YA.TAX_DED_TAXGROUP_AMT, 0) +
                                NVL(YA.TAX_DED_HOUSE_DEBT_AMT, 0) +
                                NVL(YA.TAX_DED_DONAT_POLI_AMT, 0) +
                                NVL(YA.TAX_DED_OUTSIDE_PAY_AMT, 0), 10, 0) -- 140.���װ�����;
                        --> ��������.
                        || LPAD(NVL(YA.FIX_IN_TAX_AMT, 0), 10, 0) -- 141.�ҵ漼(������ ����);
                        || LPAD(NVL(YA.FIX_LOCAL_TAX_AMT, 0), 10, 0) -- 142.�ֹμ�;
                        || LPAD(NVL(YA.FIX_SP_TAX_AMT, 0), 10, 0) -- 143.��Ư��;
                        /* -- ��ȣ�� �ּ� : �հ� ����.
                        || LPAD(TRUNC(NVL(YA.FIX_IN_TAX_AMT, 0), -1) +
                                TRUNC(NVL(YA.FIX_LOCAL_TAX_AMT, 0), -1) +
                                TRUNC(NVL(YA.FIX_SP_TAX_AMT, 0), -1), 10, 0) -- �������� �հ�;*/ 
                        /* -- ��(��)���μ��� ����.
                        --> ��(��) ���μ���.
                        || LPAD(TRUNC(NVL(HEW1.IN_TAX_AMT, 0), -1), 10, 0) -- �ҵ漼.
                        || LPAD(TRUNC(NVL(HEW1.LOCAL_TAX_AMT, 0), -1), 10, 0) -- �ֹμ�.
                        || LPAD(TRUNC(NVL(HEW1.SP_TAX_AMT, 0), -1), 10, 0) -- ��Ư��;
                        || LPAD(TRUNC(NVL(HEW1.IN_TAX_AMT, 0), -1) + 
                                TRUNC(NVL(HEW1.LOCAL_TAX_AMT, 0), -1) + 
                                TRUNC(NVL(HEW1.SP_TAX_AMT, 0), -1), 10, 0) -- ���� ���μ��� �հ�;*/
                        -- 2009�� �������� ����(MODIFIED BY YOUNG MIN). "��(��) ���μ���"���� "�ⳳ�μ��� - ��(��)�ٹ���"�� ��Ī ����;
                        --> �ⳳ�μ��� - ��(��)�ٹ���;
                        || LPAD((NVL(YA.PRE_IN_TAX_AMT, 0) - NVL(S_PW.IN_TAX_AMT, 0)), 10, 0) -- 144.�ҵ漼.
                        || LPAD((NVL(YA.PRE_LOCAL_TAX_AMT, 0) - NVL(S_PW.LOCAL_TAX_AMT, 0)), 10, 0) --145.�ֹμ�.
                        || LPAD((NVL(YA.PRE_SP_TAX_AMT, 0) - NVL(S_PW.SP_TAX_AMT, 0)), 10, 0) -- 146.��Ư��.
                        /* -- ��ȣ�� �ּ� : �հ� ����.
                        || LPAD(TRUNC(NVL(YA.PRE_IN_TAX_AMT, 0) - NVL(HEW1.IN_TAX_AMT, 0), -1) +
                                TRUNC(NVL(YA.PRE_LOCAL_TAX_AMT, 0) - NVL(HEW1.LOCAL_TAX_AMT, 0), -1) +
                                TRUNC(NVL(YA.PRE_SP_TAX_AMT, 0) - NVL(HEW1.SP_TAX_AMT, 0), -1), 10, 0) -- ��(��) ���μ��� �հ�;*/
                        --> ����¡������;
                        -- 2009�� �������� ����(MODIFIED BY YOUNG MIN). "����¡������"�߰�(10���̸� �ܼ�����);
                        -- �������� - [��(��)�ٹ��� �ⳳ�μ��� + ��(��)�ٹ��� �ⳳ�μ����� ��];
                        || LPAD(CASE
                                  WHEN TRUNC((NVL(YA.FIX_IN_TAX_AMT, 0) - NVL(YA.PRE_IN_TAX_AMT, 0)), -1) < 0 THEN 1
                                  ELSE 0
                                END, 1, 0)  -- 147. 0 <= ����¡������(�ҵ漼) < 1000 �� ��� "0"����;
                        || LPAD(ABS(TRUNC((NVL(YA.FIX_IN_TAX_AMT, 0) - NVL(YA.PRE_IN_TAX_AMT, 0)), -1)), 10, 0) -- 147.�����ҵ漼.
                        || LPAD(CASE
                                  WHEN TRUNC((NVL(YA.FIX_LOCAL_TAX_AMT, 0) - NVL(YA.PRE_LOCAL_TAX_AMT, 0)), -1) < 0 THEN 1
                                  ELSE 0
                                END, 1, 0)  -- 148. 0 <= ����¡������(�ֹμ�) < 1000 �� ��� "0"����;
                        || LPAD(ABS(TRUNC((NVL(YA.FIX_LOCAL_TAX_AMT, 0) - NVL(YA.PRE_LOCAL_TAX_AMT, 0)), -1)), 10, 0) -- 148.�����ֹμ�.
                        || LPAD(CASE
                                  WHEN TRUNC((NVL(YA.FIX_SP_TAX_AMT, 0) - NVL(YA.PRE_SP_TAX_AMT, 0)), -1) < 0 THEN 1
                                  ELSE 0
                                END, 1, 0)  -- 149. 0 <= ����¡������(��Ư��) < 1000 �� ��� "0"����;
                        || LPAD(ABS(TRUNC((NVL(YA.FIX_SP_TAX_AMT, 0) - NVL(YA.PRE_SP_TAX_AMT, 0)), -1)), 10, 0)  -- 149.���� ��Ư��.                      
                        --> 150.����.
                        || LPAD(' ', 12, ' ') AS RECORD_FILE
                        , NVL(YA.MEDIC_INSUR_AMT, 0) + NVL(YA.HIRE_INSUR_AMT, 0) AS MEDIC_INSUR_AMT  -- 'E'���ڵ忡�� ���(����û���� ����� ���� ����).
                        , NVL(YA.TAX_DED_DONAT_POLI_AMT, 0) AS TAX_DED_DONAT_POLI_AMT 
                        , PM.PERSON_ID
                        , REPLACE(PM.REPRE_NUM, '-') AS REPRE_NUM
                        , ROW_NUMBER() OVER(PARTITION BY YA.YEAR_YYYY ORDER BY PM.PERSON_NUM) AS C_SEQ_NO
                        , PM.JOIN_DATE
                        , PM.FOREIGN_TAX_YN
                      FROM HRM_PERSON_MASTER  PM
                        , HRA_YEAR_ADJUSTMENT YA
                        /*, (-- ���� �λ系��.
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
                        , ( SELECT HC.COMMON_ID AS NATION_ID
                                , HC.CODE AS NATION_CODE
                                , HC.CODE_NAME AS NATION_NAME
                                , HC.VALUE1 AS ISO_NATION_CODE
                              FROM HRM_COMMON HC
                            WHERE HC.GROUP_CODE   = 'NATION'
                              AND HC.SOB_ID       = P_SOB_ID
                              AND HC.ORG_ID       = P_ORG_ID
                           ) S_HN
                        , ( -- �����ٹ�ó ����.
                            SELECT PW.YEAR_YYYY
                                , PW.PERSON_ID
                                , COUNT(PW.PERSON_ID) AS PRE_WORK_COUNT
                                , SUM(PW.IN_TAX_AMT) AS IN_TAX_AMT
                                , SUM(PW.LOCAL_TAX_AMT) AS LOCAL_TAX_AMT
                                , SUM(PW.SP_TAX_AMT) AS SP_TAX_AMT
                              FROM HRA_PREVIOUS_WORK PW
                                , HRM_PERSON_MASTER  PM
                                /*, (-- ���� �λ系��.
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
                                  ) TS1 */
                            WHERE PW.PERSON_ID          = PM.PERSON_ID
                              --AND PM.PERSON_ID          = TS1.PERSON_ID 
                              AND PW.YEAR_YYYY          = P_YEAR_YYYY
                              AND PM.CORP_ID            = A1.CORP_ID
                              --AND TS1.OPERATING_UNIT_ID = A1.OPERATING_UNIT_ID
                              AND PW.SOB_ID             = P_SOB_ID
                              AND PW.ORG_ID             = P_ORG_ID
                            GROUP BY PW.YEAR_YYYY
                                   , PW.PERSON_ID
                          ) S_PW
                    WHERE PM.PERSON_ID          = YA.PERSON_ID
                      --AND PM.PERSON_ID          = T1.PERSON_ID 
                      AND PM.NATION_ID          = S_HN.NATION_ID(+)
                      AND YA.YEAR_YYYY          = S_PW.YEAR_YYYY(+)
                      AND YA.PERSON_ID          = S_PW.PERSON_ID(+)
                      --AND T1.OPERATING_UNIT_ID  = A1.OPERATING_UNIT_ID
                      AND YA.YEAR_YYYY          = P_YEAR_YYYY
                      AND YA.CORP_ID            = A1.CORP_ID
                      AND YA.SOB_ID             = P_SOB_ID
                      AND YA.ORG_ID             = P_ORG_ID
                      AND YA.SUBMIT_DATE        BETWEEN P_START_DATE AND P_END_DATE
                      AND YA.INCOME_TOT_AMT     != 0
                      AND YA.ADJUST_DATE_TO     BETWEEN P_START_DATE AND P_END_DATE
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
              , P_SORT_NUM          => 1
              , P_RECORD_TYPE       => 'C' 
              );
            --DBMS_OUTPUT.PUT_LINE(C1.RECORD_FILE); 
--D1 ------------------------------------------------------------------------------------
            --> ��(��)�ٹ�ó ���ڵ� <--
            FOR D1 IN ( SELECT -- �ڷ������ȣ;
                              'D' -- 1.���ڵ� ����;
                            || '20' -- 2.�ڷᱸ��;
                            || RPAD(B1.TAX_OFFICE_CODE, 3, ' ') -- 3.�������ڵ�;
                            || LPAD(C1.C_SEQ_NO, 6, '0') -- 4.C���ڵ��� �Ϸù�ȣ.
                            -- ��õ¡���ǹ���;
                            || RPAD(B1.VAT_NUMBER, 10, ' ') -- 5.����ڹ�ȣ.
                            || RPAD(' ', 50, ' ') -- 6.����;
                            -- �ҵ���;
                            || RPAD(NVL(C1.REPRE_NUM, ' '), 13, ' ') -- 7.�ֹι�ȣ.
                            -- �ٹ�ó�� �ҵ�� - ��(��)�ٹ�ó;
                            || RPAD('2',1,' ') -- 8.�������ձ���;
                            || RPAD(REPLACE(PW.COMPANY_NAME, ' ' , ''), 40, ' ') -- 9.���θ�(��ȣ);
                            || RPAD(REPLACE(PW.COMPANY_NUM, '-', ''), 10, ' ') -- 10.����ڵ�Ϲ�ȣ;
                            -- 2009�� �������� ����. �ٹ��Ⱓ/����Ⱓ ����/���Ῥ���� �߰�;
                            || RPAD(CASE -- 11.�ٹ��Ⱓ ���ۿ�����;
                                      WHEN PW.JOIN_DATE > TO_DATE(P_YEAR_YYYY || '-01-01', 'YYYY-MM-DD') THEN TO_CHAR(PW.JOIN_DATE, 'YYYYMMDD')
                                      ELSE P_YEAR_YYYY || '0101'
                                    END, 8, '0')
                            || RPAD(TO_CHAR(NVL(PW.RETR_DATE, C1.JOIN_DATE -1), 'YYYYMMDD'), 8, '0') -- 12.�ٹ��Ⱓ ���Ῥ����;
                            || LPAD('0', 8, '0') -- 13.����Ⱓ ���ۿ�����;
                            || LPAD('0', 8, '0') -- 14.����Ⱓ ���Ῥ����;
                            || LPAD(NVL(PW.PAY_TOTAL_AMT, 0), 11, 0) -- 15.�޿��Ѿ�;
                            || LPAD(NVL(PW.BONUS_TOTAL_AMT, 0), 11, 0) -- 16.���Ѿ�;
                            || LPAD(NVL(PW.ADD_BONUS_AMT, 0), 11, 0) -- 17.������;
                            || LPAD(NVL(PW.STOCK_BENE_AMT, 0), 11, 0) -- 18.�ֽĸż����ñ��������;
                            -- 2009�� �������� ����(MODIFIED BY YOUNG MIN). �츮������������� �߰�;
                            || LPAD(0, 11, 0)  -- 19.�츮�������������(�迡�� �������� �ʾ���);
                            || LPAD(NVL(PW.OFFICERS_RETIRE_OVER_AMT, 0), 11, 0)  -- 20. 2013�� �߰� : �ӿ� �����ҵ�ݾ� �ѵ��ʰ��� 
                            || LPAD(0, 22, 0)  -- 21.����.
                            || LPAD(NVL(PW.PAY_TOTAL_AMT, 0) +
                                    NVL(PW.BONUS_TOTAL_AMT, 0) +
                                    NVL(PW.ADD_BONUS_AMT, 0) +
                                    NVL(PW.STOCK_BENE_AMT, 0) +
                                    NVL(PW.OFFICERS_RETIRE_OVER_AMT, 0), 11, 0)  -- 22.��.
                            --> ��(��)�ٹ�ó ����� �ҵ�.
                            -- 2009�� �������� ����(MODIFIED BY YOUNG MIN).��(��)�ٹ�ó ����� �ҵ� ���麯��;
                            || LPAD(NVL(PW.NT_SCH_EDU_AMT, 0), 10, 0) -- 23.�����-���ڱ�;
                            || LPAD(NVL(PW.NT_MEMBER_AMT, 0), 10, 0) -- 24.�����-��������������;
                            || LPAD(NVL(PW.NT_GUARD_AMT, 0), 10, 0) -- 25.�����-��ȣ/�¼�����;
                            || LPAD(NVL(PW.NT_CHILD_AMT, 0), 10, 0) -- 26.�����-����/���ߵ�_��������/Ȱ����;
                            || LPAD(NVL(PW.NT_HIGH_SCH_AMT, 0), 10, 0) -- 27.�����-����_��������/Ȱ����;
                            || LPAD(NVL(PW.NT_SPECIAL_AMT, 0), 10, 0) -- 28.�����-Ư���������������_��������/Ȱ����;
                            || LPAD(NVL(PW.NT_RESEARCH_AMT, 0), 10, 0) -- 29.�����-�������_��������/Ȱ����;
                            || LPAD(NVL(PW.NT_COMPANY_AMT, 0), 10, 0) -- 30.�����-���������_��������/Ȱ����;
                            -- 2012�� �������� �߰� START --
                            || LPAD(0, 10, 0) -- 31.�����-�������� �ٹ�ȯ�氳����;
                            || LPAD(0, 10, 0) -- 32.�����-�縳��ġ�� ��������/������ �ΰǺ�;
                            -- 2012�� �������� �߰� END --
                            || LPAD(NVL(PW.NT_COVER_AMT, 0), 10, 0) -- 33.�����-�������;
                            || LPAD(NVL(PW.NT_WILD_AMT, 0), 10, 0) -- 34.�����-��������;
                            || LPAD(NVL(PW.NT_DISASTER_AMT, 0), 10, 0) -- 35.�����-���ذ��ñ޿�;
                            || LPAD(0, 10, 0) -- 36.�����-���ΰ������ ����������� ������ ���ּ���;
                            || LPAD(NVL(PW.NT_OUTSIDE_GOVER_AMT, 0), 10, 0) -- 37.�����-�ܱ����ε�ٹ���;
                            || LPAD(NVL(PW.NT_OUTSIDE_ARMY_AMT, 0), 10, 0) -- 38.�����-�ܱ��ֵб��ε�;
                            || LPAD(NVL(PW.NT_OUTSIDE_WORK1, 0), 10, 0) -- 39.�����-���ܱٷ�(100����);
                            || LPAD(NVL(PW.NT_OUTSIDE_WORK2, 0), 10, 0) -- 40.�����-���ܱٷ�(300����);
                            || LPAD(NVL(PW.NT_OUTSIDE_AMT, 0), 10, 0) -- 41.����� ���ܼҵ�;
                            || LPAD(NVL(PW.NT_OT_AMT, 0), 10, 0) -- 42.����� �߰��ٷ�;
                            || LPAD(NVL(PW.NT_BIRTH_AMT, 0), 10, 0) -- 43.����� ���/��������;
                            || LPAD(0, 10, 0) -- 44.�ٷ����б�.
                            || LPAD(NVL(PW.NT_STOCK_BENE_AMT, 0), 10, 0) -- 45.�����-�ֽĸż����ñ�;
                            || LPAD(NVL(PW.NT_FOREIGNER_AMT, 0), 10, 0) -- 46.�����-�ܱ��α����;
                            --|| LPAD(NVL(PW.NONTAX_FOREIGNER_AMT, 0), 10, 0) -- ����� �ܱ��� �ٷ���;
                            --|| LPAD(NVL(PW.NONTAX_EMPL_STOCK_AMT, 0), 10, 0) --  �����-�츮�������չ���;
                            || LPAD(NVL(PW.NT_EMPL_STOCK_AMT, 0), 10, 0) -- 47.�����-�츮�������������(50%);
                            || LPAD(NVL(PW.NT_EMPL_BENE_AMT2, 0), 10, 0) -- 48.�����-�츮�������������(75%);
                            || LPAD(0, 10, 0)                                  -- 49.�����-��������� �߼ұ�� ���;
                            --|| LPAD(NVL(PW.NONTAX_HOUSE_SUBSIDY_AMT, 0), 10, 0) -- �����-�����ڱݺ�����;
                            || LPAD(NVL(PW.NT_SEA_RESOURCE_AMT, 0), 10, 0) -- 50.�����-���������ڿ�����;
                            -- 2012�� �������� �߰� START --
                            || LPAD(0, 10, 0) -- 51.�����-������ ���ú�������;
                            || LPAD(0, 10, 0) -- 52.�����-�߼ұ�� ���û�� �ҵ漼 ����;
                            || LPAD(0, 10, 0) -- 53.�����-��������� ������ ����;
                            -- 2012�� �������� �߰� END --
                            --|| LPAD(0, 10, 0)  -- ���������;
                            --|| LPAD(NVL(PW.NONTAX_ETC_AMT, 0), 10, 0) --AS NONTAX_ETC_AMT     -- ����� ��Ÿ;
                            || LPAD(NVL(PW.NT_SCH_EDU_AMT, 0) +
                                    NVL(PW.NT_MEMBER_AMT, 0) +
                                    NVL(PW.NT_GUARD_AMT, 0) +
                                    NVL(PW.NT_CHILD_AMT, 0) +
                                    NVL(PW.NT_HIGH_SCH_AMT, 0) +
                                    NVL(PW.NT_SPECIAL_AMT, 0) +
                                    NVL(PW.NT_RESEARCH_AMT, 0) +
                                    NVL(PW.NT_COMPANY_AMT, 0) +
                                    NVL(PW.NT_COVER_AMT, 0) +
                                    NVL(PW.NT_WILD_AMT, 0) +
                                    NVL(PW.NT_DISASTER_AMT, 0) +
                                    NVL(PW.NT_OUTSIDE_GOVER_AMT, 0) +
                                    NVL(PW.NT_OUTSIDE_ARMY_AMT, 0) +
                                    NVL(PW.NT_OUTSIDE_WORK1, 0) +
                                    NVL(PW.NT_OUTSIDE_WORK2, 0) +
                                    NVL(PW.NT_OUTSIDE_AMT, 0) +
                                    NVL(PW.NT_OT_AMT, 0) +
                                    NVL(PW.NT_BIRTH_AMT, 0) +
                                    NVL(PW.NT_STOCK_BENE_AMT, 0) + 
                                    --NVL(PW.NONTAX_FOR_ENG_AMT, 0) +                           -- ����ҵ� ��� �̵�;
                                    --NVL(PW.NONTAX_FOREIGNER_AMT, 0) +
                                    --NVL(PW.NONTAX_EMPL_STOCK_AMT, 0) +
                                    NVL(PW.NT_EMPL_BENE_AMT1, 0) +
                                    NVL(PW.NT_EMPL_BENE_AMT2, 0),
                                    --NVL(PW.NONTAX_HOUSE_SUBSIDY_AMT, 0) +
                                    --NVL(PW.NONTAX_SEA_RESOURCE_AMT, 0) +                      -- ����ҵ� ��� �̵�;
                                    --NVL(PW.NONTAX_ETC_AMT, 0),
                                    10, 0)  -- 54.����� ��;
                            || LPAD(NVL(PW.NT_FOREIGNER_AMT, 0) +
                                    NVL(PW.NT_SEA_RESOURCE_AMT, 0), 10, 0)  -- 55.����ҵ� ��;
                            -- �ⳳ�μ��� - ��(��)�ٹ���;
                            || LPAD(NVL(PW.IN_TAX_AMT, 0), 10, 0)  -- 56. �ⳳ�� �ҵ漼 
                            || LPAD(NVL(PW.LOCAL_TAX_AMT, 0), 10, 0)  -- 57. �ⳳ�� ����ҵ漼 
                            || LPAD(NVL(PW.SP_TAX_AMT, 0), 10, 0)  -- 58.�ⳳ�� ��Ư�� 
                            /*-- ��ȣ�� �ּ� : 2011�� ������.
                            || LPAD(NVL(PW.IN_TAX_AMT, 0) +
                                    NVL(PW.LOCAL_TAX_AMT, 0) +
                                    NVL(PW.SP_TAX_AMT, 0), 10, 0)*/
                            -- || LPAD(NVL(PW.PAY_TOTAL_AMT, 0) + NVL(PW.BONUS_TOTAL_AMT, 0) + NVL(PW.ADD_BONUS_AMT, 0) + NVL(PW.STOCK_BENE_AMT, 0),11, 0) --AS PAY_SUM_AMT                       -- ��;
                            || LPAD(ROW_NUMBER() OVER(PARTITION BY PW.PERSON_ID ORDER BY PW.SEQ_NUM), 2, 0) -- 59.��(��)�ٹ�ó �Ϸù�ȣ;
                            -- 60.���� 
                            || RPAD(' ', 771, ' ') AS RECORD_FILE 
                            , ROW_NUMBER() OVER(PARTITION BY PW.PERSON_ID ORDER BY PW.SEQ_NUM) AS D_SEQ_NO
                          FROM HRA_PREVIOUS_WORK PW
                        WHERE PW.YEAR_YYYY    = P_YEAR_YYYY
                          AND PW.SOB_ID       = P_SOB_ID
                          AND PW.ORG_ID       = P_ORG_ID
                          AND PW.PERSON_ID    = C1.PERSON_ID
                      )
            LOOP
              V_SOURCE_FILE := 'D_RECORD';
              INSERT_REPORT_FILE
                ( P_SEQ_NUM           => V_SEQ_NUM
                , P_SOURCE_FILE       => V_SOURCE_FILE
                , P_SOB_ID            => P_SOB_ID
                , P_ORG_ID            => P_ORG_ID
                , P_REPORT_FILE       => D1.RECORD_FILE
                , P_SORT_NUM          => 2 + ( 0.1 * D1.D_SEQ_NO)
                );
              --DBMS_OUTPUT.PUT_LINE(D1.RECORD_FILE); 
            END LOOP D1;
--E1 �ξ簡�� �� ----------------------------------------------------------------------------
-- �ܱ��� ���ϼ����� �ƴҰ�츸 ����.
          IF C1.FOREIGN_TAX_YN = 'N' THEN
            V_RECORD_FILE := NULL;
            V_SEQ_NO    := 0;
            V_RECORD_COUNT := 0;
            FOR E1 IN ( SELECT 
                              'E' -- 1.RECORD_TYPE
                            || '20' --2. DATA_TYPE
                            || RPAD(NVL(B1.TAX_OFFICE_CODE, ' '), 3, ' ') -- 3.�������ڵ�.
                            || LPAD(NVL(C1.C_SEQ_NO, 0), 6, 0)  -- 4.C���ڵ��� �Ϸù�ȣ.
                            || RPAD(NVL(B1.VAT_NUMBER, ' '), 10, ' ') -- 5.����ڹ�ȣ.
                            || RPAD(NVL(C1.REPRE_NUM, ' '), 13, ' ') AS RECORD_HEADER -- 6.�ֹι�ȣ.
                            --> �ҵ������ ��������.
                            , RPAD(CASE
                                     WHEN NVL(SF.BASE_LIVING_YN, 'N') = 'Y' THEN '7'  -- 2013�⵵ �߰� - ���ʼ����� 
                                     ELSE NVL(SF.RELATION_CODE, ' ')
                                   END, 1, ' ') -- 7.����;
                            || RPAD(CASE
                                      WHEN SUBSTR(REPLACE(SF.REPRE_NUM, '-', ''), 7, 1) BETWEEN '5' AND '8' THEN '9'
                                      ELSE '1'
                                    END, 1, ' ') -- 8.��/�ܱ��� ���� �ڵ�;
                            || RPAD(NVL(SF.FAMILY_NAME, ' '), 20, ' ') -- 9.����;
                            || RPAD(NVL(REPLACE(SF.REPRE_NUM, '-', ''), ' ') , 13, ' ') -- 10.�ֹι�ȣ;
                            || DECODE(SF.BASE_YN, 'Y', '1', ' ') -- 11.�⺻����;
                            || CASE 
                                 WHEN NVL(SF.BASE_YN, 'N') = 'Y' AND NVL(SF.DISABILITY_YN, 'N') = 'Y' THEN NVL(SF.DISABILITY_CODE, ' ')
                                 ELSE ' '
                               END  -- 12.����ΰ���;
                            || DECODE(SF.CHILD_YN, 'Y', '1', ' ') -- 13.�ڳ���������;
                            || DECODE(SF.WOMAN_YN, 'Y', '1', ' ') -- 14.�γ��ڰ���;
                            -- 2009�� �������� ����(MODIFIED BY YOUNG MIN).��ο�� ��70���̻����� ����;
                            || CASE
                                 --WHEN SF.OLD_YN = 'Y' THEN '1'
                                 WHEN SF.OLD1_YN = 'Y' THEN '1'
                                 ELSE ' '
                               END -- 15.��ο�����;
                            -- 2009�� �������� ����(MODIFIED BY YOUNG MIN).����Ծ��ڰ����߰�;
                            || DECODE(SF.BIRTH_YN, 'Y', '1', ' ') -- 16.����Ծ��ڰ���.
                            || DECODE(SF.SINGLE_PARENT_DED_YN, 'Y', '1', ' ') -- 17.�Ѻθ�1 
                            /*-- 2009�� �������� ����(MODIFIED BY YOUNG MIN).���ڳ��߰����� ����;
                            || CASE
                                 WHEN SF.BASE_YN = 'Y' AND C1.MANY_CHILD_DED_AMT <> 0 AND SF.RELATION_CODE = '4' THEN '1'
                                 ELSE ' '
                               END -- ���ڳ��߰�����;*/
                            --> ����û �ڷ�.
                            -- 2009�� �������� ����(MODIFIED BY YOUNG MIN).����û�ڷ� �����ݾ��� ������ ��� 0���� ǥ��;
                            || LPAD((CASE
                                       WHEN DECODE(SF.RELATION_CODE, 0, NVL(C1.MEDIC_INSUR_AMT, 0), 0) + 
                                            NVL(SF.INSURE_AMT, 0) + NVL(SF.DISABILITY_INSURE_AMT, 0) < 0 THEN 0
                                       ELSE DECODE(SF.RELATION_CODE, 0, NVL(C1.MEDIC_INSUR_AMT, 0), 0) + 
                                            NVL(SF.INSURE_AMT, 0) + NVL(SF.DISABILITY_INSURE_AMT, 0)
                                     END), 10, 0) -- 18.�����(������ �ǰ������ ����);
                            || LPAD(NVL(SF.MEDICAL_AMT, 0), 10, 0) -- 19.�Ƿ��;
                            || LPAD(NVL(SF.EDUCATION_AMT, 0), 10, 0) -- 20.������;
                            || LPAD(NVL(SF.CREDIT_AMT, 0), 10, 0) -- 21.�ſ�ī���;
                            || LPAD(NVL(SF.CHECK_CREDIT_AMT , 0), 10, 0) -- 22.����ī��;
                            || LPAD(NVL(SF.CASH_AMT, 0) + NVL(SF.ACADE_GIRO_AMT, 0), 10, 0) -- 23.���ݿ�����;
                            --2012�� �������� �߰� START --
                            || LPAD(NVL(SF.TRAD_MARKET_AMT, 0), 10, 0) -- 24.����������;
                            || LPAD(NVL(SF.PUBLIC_TRANSIT_AMT, 0), 10, 0) -- 25.���߱����̿��1;
                            --2012�� �������� �߰� END --
                            || LPAD(NVL(SF.DONAT_ALL, 0) +
                                    NVL(SF.DONAT_50P, 0) +
                                    NVL(SF.DONAT_30P, 0) +
                                    NVL(SF.DONAT_10P, 0) +
                                    NVL(SF.DONAT_10P_RELIGION, 0), 13, 0)  -- 26.��α�.
                            -->����û�ڷ� �̿�.
                            || LPAD(NVL(SF.ETC_INSURE_AMT, 0), 10, 0) -- 27.����û�������� �����;
                            || LPAD(NVL(SF.ETC_MEDICAL_AMT, 0), 10, 0) -- 28.����û�������� �Ƿ��;
                            || LPAD(NVL(SF.ETC_EDUCATION_AMT, 0), 10, 0) -- 29.����û�������� ������;
                            || LPAD(NVL(SF.ETC_CREDIT_AMT, 0) + NVL(SF.ETC_ACADE_GIRO_AMT, 0), 10, 0) -- 30.����û�������� �ſ�ī��;
                            || LPAD(NVL(SF.ETC_CHECK_CREDIT_AMT, 0), 10, 0) -- 31.����û�������� ����ī��;
                            --2012�� �������� �߰� START --
                            || LPAD(NVL(SF.ETC_TRAD_MARKET_AMT, 0), 10, 0) -- 32.����������;
                            || LPAD(NVL(SF.ETC_PUBLIC_TRANSIT_AMT, 0), 10, 0)  -- 33. ���߱����̿��;
                            --2012�� �������� �߰� END --
                            || LPAD(NVL(SF.ETC_DONAT_ALL, 0) +
                                    NVL(SF.ETC_DONAT_50P, 0) +
                                    NVL(SF.ETC_DONAT_30P, 0) +
                                    NVL(SF.ETC_DONAT_10P, 0) +
                                    NVL(SF.ETC_DONAT_10P_RELIGION, 0), 13, 0) AS RECORD_LINE -- 34.����û�������� ��α�;
                         FROM HRA_SUPPORT_FAMILY SF
                        WHERE SF.YEAR_YYYY      = P_YEAR_YYYY
                          AND (SF.BASE_YN        = 'Y'
                            OR SF.SPOUSE_YN      = 'Y'
                            OR SF.OLD_YN         = 'Y'
                            OR SF.OLD1_YN        = 'Y'
                            OR (SF.BASE_YN       = 'Y' AND SF.DISABILITY_YN  = 'Y')
                            OR SF.WOMAN_YN       = 'Y'
                            OR SF.CHILD_YN       = 'Y'
                            OR SF.BIRTH_YN       = 'Y'
                            OR ((NVL(SF.INSURE_AMT, 0) + NVL(SF.ETC_INSURE_AMT, 0) + NVL(SF.DISABILITY_INSURE_AMT, 0) + 
                                NVL(SF.ETC_DISABILITY_INSURE_AMT, 0) + NVL(SF.MEDICAL_AMT, 0) + NVL(SF.ETC_MEDICAL_AMT, 0) +
                                NVL(SF.EDUCATION_TYPE, 0) + NVL(SF.EDUCATION_AMT, 0) + NVL(SF.ETC_EDUCATION_AMT, 0) + 
                                NVL(SF.CREDIT_AMT, 0) + NVL(SF.ETC_CREDIT_AMT, 0) + NVL(SF.CHECK_CREDIT_AMT, 0) + 
                                NVL(SF.ETC_CHECK_CREDIT_AMT, 0) + NVL(SF.CASH_AMT, 0) + NVL(SF.ETC_CASH_AMT, 0) + 
                                NVL(SF.ACADE_GIRO_AMT, 0) + NVL(SF.ETC_ACADE_GIRO_AMT, 0) + 
                                NVL(SF.TRAD_MARKET_AMT, 0) + NVL(SF.ETC_TRAD_MARKET_AMT, 0) +
                                NVL(SF.DONAT_ALL, 0) + NVL(SF.ETC_DONAT_ALL, 0) + NVL(SF.DONAT_50P, 0) + NVL(SF.ETC_DONAT_50P, 0) + 
                                NVL(SF.DONAT_30P, 0) + NVL(SF.ETC_DONAT_30P, 0) + NVL(SF.DONAT_10P, 0) + NVL(SF.ETC_DONAT_10P, 0) + 
                                NVL(SF.DONAT_10P_RELIGION, 0) + NVL(SF.ETC_DONAT_10P_RELIGION, 0) + 
                                NVL(SF.DONAT_POLI, 0) + NVL(SF.ETC_DONAT_POLI, 0))) > 0)
                          AND SF.PERSON_ID      = C1.PERSON_ID
                          AND SF.REPRE_NUM      IS NOT NULL
                        ORDER BY SF.RELATION_CODE
                      )
            LOOP
              V_RECORD_COUNT := NVL(V_RECORD_COUNT, 0) + 1;
              IF V_RECORD_COUNT = 1 THEN
                V_RECORD_FILE := E1.RECORD_HEADER || E1.RECORD_LINE;
              ELSE
                V_RECORD_FILE := V_RECORD_FILE || E1.RECORD_LINE;
              END IF;
              --> �ξ簡���� 5�� �̻��� ���.
              IF V_E_REC_STD <= V_RECORD_COUNT THEN
                V_SEQ_NO := NVL(V_SEQ_NO, 0) + 1;  -- �ξ簡�� ���� �Ϸù�ȣ.
                V_RECORD_FILE := V_RECORD_FILE 
                                 || LPAD(NVL(V_SEQ_NO, 1), 2, 0)  -- �Ϸù�ȣ.
                                 || RPAD(' ', 273, ' ');  -- ����.
                
                V_SOURCE_FILE := 'E_RECORD';
                INSERT_REPORT_FILE
                  ( P_SEQ_NUM           => V_SEQ_NUM
                  , P_SOURCE_FILE       => V_SOURCE_FILE
                  , P_SOB_ID            => P_SOB_ID
                  , P_ORG_ID            => P_ORG_ID
                  , P_REPORT_FILE       => V_RECORD_FILE
                  , P_SORT_NUM          => 3 + (0.001 * V_SEQ_NO)
                  );
                --DBMS_OUTPUT.PUT_LINE(V_RECORD_FILE); 
                V_RECORD_FILE  := NULL;
                V_RECORD_COUNT := 0;
              END IF;
            END LOOP E1;
            IF V_RECORD_COUNT <> 0 THEN
              FOR E1S IN V_RECORD_COUNT + 1 .. V_E_REC_STD
              LOOP
                V_RECORD_FILE := V_RECORD_FILE || RPAD(' ', 218, ' ');  -- �ҵ���� ���� �ξ簡�� ����.
              END LOOP E1S;
              IF V_RECORD_FILE IS NOT NULL THEN
                V_SEQ_NO := NVL(V_SEQ_NO, 0) + 1;  -- �ξ簡�� ���� �Ϸù�ȣ.
                V_RECORD_FILE := V_RECORD_FILE 
                                 || LPAD(NVL(V_SEQ_NO, 1), 2, 0)  -- �Ϸù�ȣ.
                                 || RPAD(' ', 273, ' ');  -- ����.
                                 
                V_SOURCE_FILE := 'E_RECORD';
                INSERT_REPORT_FILE
                  ( P_SEQ_NUM           => V_SEQ_NUM
                  , P_SOURCE_FILE       => V_SOURCE_FILE
                  , P_SOB_ID            => P_SOB_ID
                  , P_ORG_ID            => P_ORG_ID
                  , P_REPORT_FILE       => V_RECORD_FILE
                  , P_SORT_NUM          => 3 + (0.001 * V_SEQ_NO)
                  );
                --DBMS_OUTPUT.PUT_LINE(V_RECORD_FILE); 
              END IF;
            END IF;

--F1 ����/����� �ҵ���� �� ���ڵ� -----------------------------------------------------------------
            V_RECORD_FILE := NULL;
            V_SEQ_NO    := 0;
            V_RECORD_COUNT := 0;
            FOR F1 IN ( SELECT 'F' --1.RECORD_TYPE
                            || '20' --2. DATA_TYPE
                            || RPAD(NVL(B1.TAX_OFFICE_CODE, ' '), 3, ' ') -- 3.�������ڵ�.
                            || LPAD(C1.C_SEQ_NO, 6, 0) -- 4.C���ڵ��� �Ϸù�ȣ.
                            || RPAD(NVL(B1.VAT_NUMBER, ' '), 10, ' ') -- 5.����ڹ�ȣ.
                            || RPAD(NVL(C1.REPRE_NUM, ' '), 13, ' ') AS RECORD_HEADER -- 6.�ֹι�ȣ.
                            , LPAD(NVL(SI.SAVING_TYPE, ' '), 2, '0')  -- 7.�ҵ��������;
                            || RPAD(SI.BANK_CODE, 3, ' ') -- 8.������� �ڵ����;
                            || RPAD(YB.YEAR_BANK_NAME, 30, ' ') -- 9.������� ��ȣ����;
                            || RPAD(SI.ACCOUNT_NUM, 20, ' ') -- 10.���¹�ȣ;
                            || LPAD(DECODE(SI.SAVING_TYPE, '41', CASE WHEN 3 < SI.SAVING_COUNT THEN 3 ELSE SI.SAVING_COUNT END , '0'), 2, 0) -- 11.���Կ���-����ֽ������ุ �ش�;
                            || LPAD(SI.SAVING_AMOUNT, 10, 0) -- 12.���Աݾ�;
                            || LPAD(SI.SAVING_DED_AMOUNT, 10, 0) AS RECORD_LINE               -- 13.�����ݾ�;
                          FROM HRA_SAVING_INFO SI
                            , ( SELECT HC.COMMON_ID AS YEAR_BANK_ID
                                    , HC.CODE AS YEAR_BANK_CODE
                                    , HC.CODE_NAME AS YEAR_BANK_NAME
                                    , HC.SOB_ID
                                    , HC.ORG_ID
                                  FROM HRM_COMMON HC
                                WHERE HC.GROUP_CODE   = 'YEAR_BANK'
                                  AND HC.SOB_ID       = P_SOB_ID
                                  AND HC.ORG_ID       = P_ORG_ID
                               ) YB
                        WHERE SI.BANK_CODE      = YB.YEAR_BANK_CODE
                          AND SI.SOB_ID         = YB.SOB_ID
                          AND SI.ORG_ID         = YB.ORG_ID
                          AND SI.YEAR_YYYY      = P_YEAR_YYYY
                          AND SI.PERSON_ID      = C1.PERSON_ID
                          AND NVL(SI.SAVING_DED_AMOUNT, 0) > 0
                        ORDER BY SI.BANK_CODE ASC
                        )
            LOOP
              V_RECORD_COUNT := NVL(V_RECORD_COUNT, 0) + 1;
              IF V_RECORD_COUNT = 1 THEN
                V_RECORD_FILE := F1.RECORD_HEADER || F1.RECORD_LINE;
              ELSE
                V_RECORD_FILE := V_RECORD_FILE || F1.RECORD_LINE;
              END IF;
              --> ��������� ���� 15�� �̻��� ���.
              IF V_F_REC_STD <= V_RECORD_COUNT THEN
                V_SEQ_NO := NVL(V_SEQ_NO, 0) + 1;  -- �������� ���� �Ϸù�ȣ.
                V_RECORD_FILE := V_RECORD_FILE || RPAD(' ', 210, ' ');  -- ����.
                
                V_SOURCE_FILE := 'F_RECORD';
                INSERT_REPORT_FILE
                  ( P_SEQ_NUM           => V_SEQ_NUM
                  , P_SOURCE_FILE       => V_SOURCE_FILE
                  , P_SOB_ID            => P_SOB_ID
                  , P_ORG_ID            => P_ORG_ID
                  , P_REPORT_FILE       => V_RECORD_FILE
                  , P_SORT_NUM          => 4 + (0.00001 * V_SEQ_NO)
                  );
                --DBMS_OUTPUT.PUT_LINE(V_RECORD_FILE); 
                V_RECORD_FILE  := NULL;
                V_RECORD_COUNT := 0;
              END IF;
            END LOOP F1;
            IF V_RECORD_COUNT <> 0 THEN
              FOR F1S IN V_RECORD_COUNT + 1 .. V_F_REC_STD
              LOOP
                V_RECORD_FILE := V_RECORD_FILE || RPAD(' ', 77, ' ');
              END LOOP F1S;
              IF V_RECORD_FILE IS NOT NULL THEN
                V_SEQ_NO := NVL(V_SEQ_NO, 0) + 1;  -- �������� ���� �Ϸù�ȣ.
                V_RECORD_FILE := V_RECORD_FILE || RPAD(' ', 210, ' ');  -- ��������  �ҵ������ ���� ���� => ����.
                
                V_SOURCE_FILE := 'F_RECORD';                
                INSERT_REPORT_FILE
                  ( P_SEQ_NUM           => V_SEQ_NUM
                  , P_SOURCE_FILE       => V_SOURCE_FILE
                  , P_SOB_ID            => P_SOB_ID
                  , P_ORG_ID            => P_ORG_ID
                  , P_REPORT_FILE       => V_RECORD_FILE
                  , P_SORT_NUM          => 4 + (0.00001 * V_SEQ_NO)
                  );
                --DBMS_OUTPUT.PUT_LINE(V_RECORD_FILE); 
              END IF;
            END IF;
--F1 END ---------------------------------------------------------------------------------
--G1 ����/�����ڰ� �����������Ա� ������ ��ȯ�� �ҵ�������� ���ڵ� --------------------
            V_REC_TEMP_1 := RPAD(' ', 20, ' ') ||  -- �Ӵ��� ����
                            RPAD(' ', 13, ' ') || -- �ֹε�Ϲ�ȣ(����ڹ�ȣ) 
                            RPAD(' ', 100, ' ') ||  --  �Ӵ�����༭�� �ּ��� 
                            LPAD(0, 8, 0) ||  -- �Ӵ������Ⱓ ���� 
                            LPAD(0, 8, 0) ||  -- �Ӵ������Ⱓ ���� 
                            LPAD(0, 10, 0) ||  -- ������ 
                            LPAD(0, 10, 0);
            V_REC_TEMP_2 := RPAD(' ', 20, ' ') ||  --    -- ���ּ��� 
                            RPAD(' ', 13, ' ') || -- ���� �ֹι�ȣ 
                            LPAD(0, 8, 0) ||  -- �����Һ���� ���Ⱓ ���� 
                            LPAD(0, 8, 0) ||  -- �����Һ���� ���Ⱓ ���� 
                            LPAD(0, 4, 0) ||  -- ���Ա� ������ 
                            LPAD(0, 10, 0) ||  -- ������ ��ȯ�װ� 
                            LPAD(0, 10, 0) ||  -- ���� 
                            LPAD(0, 10, 0) ||  -- ���� 
                            LPAD(0, 10, 0) ||  -- �����ݾ� 
                            RPAD(' ', 20, ' ') ||  -- �Ӵ��� ����
                            RPAD(' ', 13, ' ') || -- �ֹε�Ϲ�ȣ(����ڹ�ȣ) 
                            RPAD(' ', 100, ' ') ||  --  �Ӵ�����༭�� �ּ��� 
                            LPAD(0, 8, 0) ||  -- �Ӵ������Ⱓ ���� 
                            LPAD(0, 8, 0) ||  -- �Ӵ������Ⱓ ���� 
                            LPAD(0, 10, 0);
            V_RECORD_FILE := NULL;
            V_SEQ_NO    := 0;
            V_RECORD_COUNT := 0;
            FOR G1 IN ( SELECT 'G' --1.RECORD_TYPE
                            || '20' --2. DATA_TYPE
                            || RPAD(NVL(B1.TAX_OFFICE_CODE, ' '), 3, ' ') -- 3.�������ڵ�.
                            || LPAD(C1.C_SEQ_NO, 6, 0) -- 4.C���ڵ��� �Ϸù�ȣ.
                            || RPAD(NVL(B1.VAT_NUMBER, ' '), 10, ' ') -- 5.����ڹ�ȣ.
                            || RPAD(NVL(C1.REPRE_NUM, ' '), 13, ' ') AS RECORD_HEADER -- 6.�ֹι�ȣ.
                            
                             , MAX(HL.HOUSE_LEASE_INFO_10) AS HOUSE_LEASE_INFO_10
                             , MAX(HL.HOUSE_LEASE_INFO_20) AS HOUSE_LEASE_INFO_20
                          FROM (SELECT ROWNUM AS ROW_NUM 
                                     , RPAD(NVL(HLI.LESSOR_NAME, ' '), 20, ' ') ||  -- �Ӵ��� ����
                                       RPAD(NVL(REPLACE(HLI.LESSOR_REPRE_NUM, '-', ''), ' '), 13, ' ') || -- �ֹε�Ϲ�ȣ(����ڹ�ȣ) 
                                       RPAD(NVL(HLI.LEASE_ADDR1, ' ') || ' ' || NVL(HLI.LEASE_ADDR2, ' '), 100, ' ') ||  --  �Ӵ�����༭�� �ּ��� 
                                       LPAD(NVL(TO_CHAR(HLI.LEASE_TERM_FR, 'YYYYMMDD'), '0'), 8, 0) ||  -- �Ӵ������Ⱓ ���� 
                                       LPAD(NVL(TO_CHAR(HLI.LEASE_TERM_TO, 'YYYYMMDD'), '0'), 8, 0) ||  -- �Ӵ������Ⱓ ���� 
                                       LPAD(NVL(HLI.MONTLY_LEASE_AMT, 0), 10, 0) ||  -- ������ 
                                       LPAD(NVL(HLI.HOUSE_DED_AMT, 0), 10, 0) AS HOUSE_LEASE_INFO_10
                                     , NULL AS HOUSE_LEASE_INFO_20
                                  FROM HRA_HOUSE_LEASE_INFO HLI
                                WHERE HLI.YEAR_YYYY         = P_YEAR_YYYY
                                  AND HLI.PERSON_ID         = C1.PERSON_ID
                                  AND HLI.SOB_ID            = P_SOB_ID
                                  AND HLI.ORG_ID            = P_ORG_ID
                                  AND HLI.HOUSE_LEASE_TYPE  = '10'  -- ����  
                                  AND HLI.HOUSE_DED_AMT     != 0    -- �����ݾ� �ִ°͸� ó�� 
                                UNION ALL
                                SELECT ROWNUM AS ROW_NUM 
                                     , NULL AS HOUSE_LEASE_INFO_10
                                     , RPAD(NVL(HLI.LOANER_NAME, ' '), 20, ' ') ||  --    -- ���ּ��� 
                                       RPAD(NVL(REPLACE(HLI.LOANER_REPRE_NUM, '-', ''), ' '), 13, ' ') || -- ���� �ֹι�ȣ 
                                       LPAD(NVL(TO_CHAR(HLI.LOAN_TERM_FR, 'YYYYMMDD'), '0'), 8, 0) ||  -- �����Һ���� ���Ⱓ ���� 
                                       LPAD(NVL(TO_CHAR(HLI.LOAN_TERM_TO, 'YYYYMMDD'), '0'), 8, 0) ||  -- �����Һ���� ���Ⱓ ���� 
                                       LPAD(NVL(HLI.LOAN_INTEREST_RATE, 0), 4, 0) ||  -- ���Ա� ������ 
                                       LPAD((NVL(HLI.LOAN_AMT, 0) + NVL(HLI.LOAN_INTEREST_AMT, 0)), 10, 0) ||  -- ������ ��ȯ�װ� 
                                       LPAD(NVL(HLI.LOAN_AMT, 0), 10, 0) ||  -- ���� 
                                       LPAD(NVL(HLI.LOAN_INTEREST_AMT, 0), 10, 0) ||  -- ���� 
                                       LPAD(NVL(HLI.HOUSE_DED_AMT, 0), 10, 0) ||  -- �����ݾ� 
                                       RPAD(NVL(HLI.LESSOR_NAME, ' '), 20, ' ') ||  -- �Ӵ��� ����
                                       RPAD(NVL(REPLACE(HLI.LESSOR_REPRE_NUM, '-', ''), ' '), 13, ' ') || -- �ֹε�Ϲ�ȣ(����ڹ�ȣ) 
                                       RPAD(NVL(HLI.LEASE_ADDR1, ' ') || ' ' || NVL(HLI.LEASE_ADDR2, ' '), 100, ' ') ||  --  �Ӵ�����༭�� �ּ��� 
                                       LPAD(NVL(TO_CHAR(HLI.LEASE_TERM_FR, 'YYYYMMDD'), '0'), 8, 0) ||  -- �Ӵ������Ⱓ ���� 
                                       LPAD(NVL(TO_CHAR(HLI.LEASE_TERM_TO, 'YYYYMMDD'), '0'), 8, 0) ||  -- �Ӵ������Ⱓ ���� 
                                       LPAD(NVL(HLI.DEPOSIT_AMT, 0), 10, 0) AS HOUSE_LEASE_INFO_20  -- ����������            
                                  FROM HRA_HOUSE_LEASE_INFO HLI
                                WHERE HLI.YEAR_YYYY         = P_YEAR_YYYY
                                  AND HLI.PERSON_ID         = C1.PERSON_ID
                                  AND HLI.SOB_ID            = P_SOB_ID
                                  AND HLI.ORG_ID            = P_ORG_ID
                                  AND HLI.HOUSE_LEASE_TYPE  = '20'  -- ������ �����������Կ����� 
                               ) HL
                        GROUP BY HL.ROW_NUM
                        ORDER BY HL.ROW_NUM
                        )
            LOOP
              V_RECORD_COUNT := NVL(V_RECORD_COUNT, 0) + 1;
              IF V_RECORD_COUNT = 1 THEN
                V_RECORD_FILE := G1.RECORD_HEADER;
                -- ����  
                IF G1.HOUSE_LEASE_INFO_10 IS NULL THEN
                  V_RECORD_FILE := V_RECORD_FILE || V_REC_TEMP_1;
                ELSE
                  V_RECORD_FILE := V_RECORD_FILE || G1.HOUSE_LEASE_INFO_10;
                END IF;
                -- �����ڰ� �����������Ա� 
                IF G1.HOUSE_LEASE_INFO_20 IS NULL THEN
                  V_RECORD_FILE := V_RECORD_FILE || V_REC_TEMP_2;
                ELSE
                  V_RECORD_FILE := V_RECORD_FILE || G1.HOUSE_LEASE_INFO_20;
                END IF;
              ELSE
                -- ����  
                IF G1.HOUSE_LEASE_INFO_10 IS NULL THEN
                  V_RECORD_FILE := V_RECORD_FILE || V_REC_TEMP_1;
                ELSE
                  V_RECORD_FILE := V_RECORD_FILE || G1.HOUSE_LEASE_INFO_10;
                END IF;
                -- �����ڰ� �����������Ա� 
                IF G1.HOUSE_LEASE_INFO_20 IS NULL THEN
                  V_RECORD_FILE := V_RECORD_FILE || V_REC_TEMP_2;
                ELSE
                  V_RECORD_FILE := V_RECORD_FILE || G1.HOUSE_LEASE_INFO_20;
                END IF;
              END IF;
              --> ����/�����ڰ� �����������Ա� ������ ���� 3�� �̻��� ���.
              IF V_G_REC_STD <= V_RECORD_COUNT THEN
                V_SEQ_NO := NVL(V_SEQ_NO, 0) + 1;  -- ����/�����ڰ� �����������Ա� ������ ���� �Ϸù�ȣ.
                V_RECORD_FILE := V_RECORD_FILE || LPAD(V_SEQ_NO, 2, 0);  -- �Ϸù�ȣ 
                V_RECORD_FILE := V_RECORD_FILE || RPAD(' ', 100, ' ');  -- ����.
                
                V_SOURCE_FILE := 'G_RECORD';
                INSERT_REPORT_FILE
                  ( P_SEQ_NUM           => V_SEQ_NUM
                  , P_SOURCE_FILE       => V_SOURCE_FILE
                  , P_SOB_ID            => P_SOB_ID
                  , P_ORG_ID            => P_ORG_ID
                  , P_REPORT_FILE       => V_RECORD_FILE
                  , P_SORT_NUM          => 5 + (0.00001 * V_SEQ_NO)
                  );
                --DBMS_OUTPUT.PUT_LINE(V_RECORD_FILE); 
                V_RECORD_FILE  := NULL;
                V_RECORD_COUNT := 0;
              END IF;
            END LOOP F1; 
            IF V_RECORD_COUNT <> 0 THEN
              FOR G1S IN (V_RECORD_COUNT + 1) .. V_G_REC_STD
              LOOP
                V_RECORD_FILE := V_RECORD_FILE || V_REC_TEMP_1 || V_REC_TEMP_2;
              END LOOP F1S;
              IF V_RECORD_FILE IS NOT NULL THEN
                V_SEQ_NO := NVL(V_SEQ_NO, 0) + 1;  -- ����/�����ڰ� �����������Ա� ������ ���� �Ϸù�ȣ.
                V_RECORD_FILE := V_RECORD_FILE || LPAD(V_SEQ_NO, 2, 0);  -- �Ϸù�ȣ 
                V_RECORD_FILE := V_RECORD_FILE || RPAD(' ', 100, ' ');  -- ����.

                V_SOURCE_FILE := 'G_RECORD';                
                INSERT_REPORT_FILE
                  ( P_SEQ_NUM           => V_SEQ_NUM
                  , P_SOURCE_FILE       => V_SOURCE_FILE
                  , P_SOB_ID            => P_SOB_ID
                  , P_ORG_ID            => P_ORG_ID
                  , P_REPORT_FILE       => V_RECORD_FILE
                  , P_SORT_NUM          => 5 + (0.00001 * V_SEQ_NO)
                  );
                --DBMS_OUTPUT.PUT_LINE(V_RECORD_FILE); 
              END IF;
            END IF;
--G1 END ---------------------------------------------------------------------------------
          END IF;  -- �ܱ��� ���ϼ��� ���� ���Ұ�츸 ����.
          END LOOP C1;    
        END LOOP B1;
    END LOOP A1;
  END SET_YEAR_ADJUST_FILE_2013;            

-------------------------------------------------------------------------------
-- 2013�⵵ �Ƿ�� ���ϻ���.
-------------------------------------------------------------------------------
  PROCEDURE SET_MEDICAL_FILE_2013
            ( P_YEAR_YYYY         IN VARCHAR2
            , P_START_DATE        IN HRA_YEAR_ADJUSTMENT.SUBMIT_DATE%TYPE
            , P_END_DATE          IN HRA_YEAR_ADJUSTMENT.SUBMIT_DATE%TYPE
            , P_CORP_ID           IN HRA_YEAR_ADJUSTMENT.CORP_ID%TYPE
            , P_OPERATING_UNIT_ID IN NUMBER 
            , P_SOB_ID            IN HRA_YEAR_ADJUSTMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRA_YEAR_ADJUSTMENT.ORG_ID%TYPE
            , P_CONNECT_PERSON_ID IN NUMBER
            , P_TAX_PROGRAM_CODE  IN VARCHAR2
            , P_SUBMIT_PERIOD     IN VARCHAR2
            , P_HOMETAX_LOGIN_ID  IN VARCHAR2
            , P_WRITE_DATE        IN DATE
            )
  AS
    V_SEQ_NUM                   NUMBER := 0;
    V_SOURCE_FILE               VARCHAR2(150);
    
    V_TAX_OFFICE_CODE           VARCHAR2(5);
    V_VAT_NUMBER                VARCHAR2(15);
    V_CORP_NAME                 VARCHAR2(50);
  BEGIN
    BEGIN
      SELECT REPLACE(CM.CORP_NAME, ' ', '') AS CORP_NAME
          , OU.VAT_NUMBER
          , OU.TAX_OFFICE_CODE
        INTO V_CORP_NAME
          , V_VAT_NUMBER
          , V_TAX_OFFICE_CODE
        FROM HRM_CORP_MASTER CM
           , HRM_OPERATING_UNIT OU
      WHERE CM.CORP_ID            = OU.CORP_ID
        AND CM.CORP_ID            = P_CORP_ID
        AND CM.SOB_ID             = P_SOB_ID
        AND CM.ORG_ID             = P_ORG_ID
        AND OU.OPERATING_UNIT_ID  = P_OPERATING_UNIT_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20001, 'Error - ����� ������ ã���� �����ϴ�. Ȯ���ϼ���');
      RETURN;
    END;
    FOR A1 IN ( SELECT 'A'   -- 1.�ڷ������ȣ.
                    || '26'  -- 2. 26;
                    || LPAD(REPLACE(V_TAX_OFFICE_CODE, '-', ''), 3, 0)  -- 3.������ �ڵ�;
                    || LPAD(ROWNUM, 6, 0)  -- 4.�Ϸù�ȣ.
                    || RPAD(TO_CHAR(P_WRITE_DATE, 'YYYYMMDD'), 8, 0) -- 5.�ڷḦ �������� �����ϴ� ������;
                    --> ������;
/*                    || LPAD(NVL(P_SUBMIT_AGENT, '2'), 1, 0)  -- �����ڱ���(�����븮��1, ����2, ����3);
                    || RPAD(NVL(P_TAX_PROGRAM_CODE, ' '), 6, ' ')  -- �����븮�� ������ȣ(�ڷ������ڰ� �����븮���ΰ�� ����);
*/                    || RPAD(NVL(REPLACE(V_VAT_NUMBER, '-', ''), ' '), 10, ' ')  -- 6.����ڵ�Ϲ�ȣ;
                    || RPAD(NVL(P_HOMETAX_LOGIN_ID, ' '), 20, ' ')  -- 7.Ȩ�ý�ID;
                    || RPAD(NVL(P_TAX_PROGRAM_CODE, '1001'), 4, ' ')  -- 8.�������α׷��ڵ�;                    
                    || RPAD(NVL(REPLACE(V_VAT_NUMBER, '-', ''), ' '), 10, ' ')  -- 9.����ڵ�Ϲ�ȣ;
                    || RPAD(NVL(REPLACE(V_CORP_NAME, ' ', ''), ' '), 40, ' ')  -- 10.���θ�(��ȣ);
                    || RPAD(NVL(REPLACE(PM.REPRE_NUM, '-', '') ,' '), 13, ' ')  -- 11.�ҵ����ֹι�ȣ.
                    || RPAD(NVL(PM.NATIONALITY_TYPE, ' '), 1, 0)  -- 12.���ܱ��α���.
                    || RPAD(NVL(REPLACE(PM.NAME, ' ', ''), ' '), 30, ' ') -- 13.�ҵ����� ����;
                    || LPAD(NVL(REPLACE(MI.CORP_TAX_REG_NO, '-', ''), ' '), 10, ' ') -- 14.����ó�� ����ڵ�Ϲ�ȣ;
                    || RPAD(NVL(REPLACE(MI.CORP_NAME, ' ' , ''), ' '), 40, ' ') -- 15.����ó ��ȣ;
                    || RPAD(NVL(MI.EVIDENCE_CODE, ' '), 1, ' ')  -- 16.�Ƿ������ڵ�;
                    || LPAD(NVL(MI.CREDIT_COUNT, 0) + NVL(MI.ETC_COUNT, 0), 5, 0) -- 17.�Ǽ�;
                    || LPAD(NVL(MI.CREDIT_AMT, 0) + NVL(MI.ETC_AMT, 0), 11, 0) --  18.���ޱݾ�;
                    || LPAD(REPLACE(MI.REPRE_NUM, '-', ''), 13, ' ') -- 19.�Ƿ�� ���� ������� �ֹε�Ϲ�ȣ;
                    || RPAD(CASE
                              WHEN SUBSTR(REPLACE(MI.REPRE_NUM, '-', ''), 7, 1) BETWEEN '5' AND '8' THEN '9'
                              ELSE '1'
                            END, 1, 0) -- 20.�Ƿ�� ���� ������� ��/�ܱ��� �ڵ�;
                    || RPAD(CASE
                              WHEN MI.RELATION_CODE = '0' OR 'Y' IN(MI.DISABILITY_YN, MI.OLD_YN) THEN '1'
                              ELSE '2'
                            END, 1, 0) -- 21.���ε� �ش翩��;
                    || RPAD(P_SUBMIT_PERIOD, 1, 0) -- 22.(�����ջ� : 1, ��/����� ���� �������� : 2, ���� �������� : 3);
                    || RPAD(' ', 19, ' ') AS RECORD_FILE
                    , ROWNUM AS SORT_NUM
                  FROM HRA_MEDICAL_INFO MI
                    , HRM_PERSON_MASTER PM
                    , (-- ���� �λ系��.
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
                      ) T1
                WHERE MI.PERSON_ID          = PM.PERSON_ID
                  AND PM.PERSON_ID          = T1.PERSON_ID 
                  AND MI.YEAR_YYYY          = P_YEAR_YYYY
                  AND MI.SOB_ID             = P_SOB_ID
                  AND MI.ORG_ID             = P_ORG_ID    
                  AND PM.CORP_ID            = P_CORP_ID  
                  AND T1.OPERATING_UNIT_ID  = P_OPERATING_UNIT_ID             
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
        , P_SORT_NUM          => A1.SORT_NUM
        , P_RECORD_TYPE       => 'A'
        );
      --DBMS_OUTPUT.PUT_LINE(A1.RECORD_FILE);
    END LOOP A1; 
  END SET_MEDICAL_FILE_2013;
            
-------------------------------------------------------------------------------
-- 2013�⵵ ��α� ���ϻ���.
-------------------------------------------------------------------------------
  PROCEDURE SET_DONATION_FILE_2013
            ( P_YEAR_YYYY         IN VARCHAR2
            , P_START_DATE        IN HRA_YEAR_ADJUSTMENT.SUBMIT_DATE%TYPE
            , P_END_DATE          IN HRA_YEAR_ADJUSTMENT.SUBMIT_DATE%TYPE
            , P_CORP_ID           IN HRA_YEAR_ADJUSTMENT.CORP_ID%TYPE
            , P_OPERATING_UNIT_ID IN NUMBER 
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
    V_SEQ_NUM                   NUMBER := 0;
    V_SOURCE_FILE               VARCHAR2(150);
    
    V_TAX_OFFICE_CODE           VARCHAR2(5);
    V_VAT_NUMBER                VARCHAR2(15);
    V_CORP_NAME                 VARCHAR2(50);
  BEGIN
--A1 ------------------------------------------------------------------------------------
    FOR A1 IN ( SELECT 'A'   -- 1.�ڷ������ȣ.
                    || '27'  -- 2. 27;
                    || LPAD(NVL(OU.TAX_OFFICE_CODE, ' '), 3, 0)  -- ������ �ڵ�;
                    || TO_CHAR(P_WRITE_DATE, 'YYYYMMDD')  -- �ڷḦ �������� �����ϴ� ������;
                    --> ������;
                    || LPAD(NVL(P_SUBMIT_AGENT, '2'), 1, 0)  -- �����ڱ���(�����븮��1, ����2, ����3);
                    || RPAD(NVL(P_TAX_AGENT, ' '), 6, ' ')  -- �����븮�� ������ȣ(�ڷ������ڰ� �����븮���ΰ�� ����);
                    || RPAD(NVL(P_HOMETAX_LOGIN_ID, ' '), 20, ' ')  -- Ȩ�ý�ID;
                    || RPAD(NVL(P_TAX_PROGRAM_CODE, '9000'), 4, ' ')  -- �������α׷��ڵ�;
                    || RPAD(NVL(REPLACE(OU.VAT_NUMBER, '-', ''), ' '), 10, ' ')  -- ����ڵ�Ϲ�ȣ;
                    || RPAD(NVL(CM.CORP_NAME, ' '), 40, ' ')  -- ���θ�(��ȣ);
                    || RPAD(NVL(S_PM.DEPT_NAME, ' '), 30, ' ')  -- �����(������) �μ�;
                    || RPAD(NVL(S_PM.NAME, ' '), 30, ' ')  -- �����(������) ����;
                    || RPAD(NVL(REPLACE(CM.TEL_NUMBER, '-', ''), ' '), 15, ' ')  -- �����(������) ��ȭ��ȣ;
                    --> ���⳻��.
                    || LPAD(1, 5, 0)  -- �Ű��ǹ��ڼ� (B���ڵ�);
                    || LPAD(NVL(P_USE_LANGUAGE_CODE, '101'), 3, 0)  -- ����ѱ��ڵ�;
                    || RPAD(' ', 2, ' ') AS RECORD_FILE
                    , NVL(OU.TAX_OFFICE_CODE, ' ') AS TAX_OFFICE_CODE
                    , NVL(REPLACE(OU.VAT_NUMBER, '-', ''), ' ') AS VAT_NUMBER
                    , NVL(CM.CORP_NAME, ' ') AS CORP_NAME
                    , CM.CORP_ID
                    , OU.OPERATING_UNIT_ID
                  FROM HRM_CORP_MASTER   CM
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
                  AND OU.OPERATING_UNIT_ID  = P_OPERATING_UNIT_ID
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
      
--B1 ------------------------------------------------------------------------------------
      FOR B1 IN ( -- ��α� ���޸���.
                  SELECT 'B' --AS RECORD_TYPE   -- �ڷ������ȣ(���ڵ� ����);
                      || '27' --AS DATA_TYPE     -- �ڷᱸ��(���� 27);
                      || RPAD(A1.TAX_OFFICE_CODE, 3, 0) -- �������ڵ�;
                      || LPAD(ROWNUM, 6, 0) -- �Ϸù�ȣ;
                      -- ��õ¡���ǹ���;
                      || RPAD(A1.VAT_NUMBER, 10, ' ') -- ����ڵ�Ϲ�ȣ;
                      || RPAD(A1.CORP_NAME, 40, ' ') -- ��ȣ��;
                      -- ���⳻��;
                      || LPAD(NVL(SX1.DONA_ADJUST_COUNT, 0), 7, 0) -- ��α����������ڵ��;
                      || LPAD(NVL(SX1.THIS_YEAR_COUNT, 0), 7, 0) -- �ش�⵵ ��α����������ڵ��;
                      || LPAD(NVL(SX1.TOTAL_DONA_AMT, 0), 13, 0)  -- ��αݾ� �Ѿ�.
                      || LPAD(NVL(SX1.TOTAL_DONA_DED_AMT, 0), 13, 0)  -- �������ݾ��Ѿ�;
                      || LPAD(NVL(P_SUBMIT_PERIOD, '1'), 1, 0) -- (�����ջ� : 1, ��/����� ���� �������� : 2, ���� �������� : 3);
                      || RPAD(' ', 77, ' ') AS RECORD_FILE
                    FROM (SELECT SUM(PX1.DONA_ADJUST_COUNT) AS DONA_ADJUST_COUNT
                               , SUM(PX1.THIS_YEAR_COUNT) AS THIS_YEAR_COUNT
                               , SUM(PX1.TOTAL_DONA_AMT) AS TOTAL_DONA_AMT
                               , SUM(PX1.TOTAL_DONA_DED_AMT) AS TOTAL_DONA_DED_AMT
                            FROM (SELECT COUNT(DA.PERSON_ID) AS DONA_ADJUST_COUNT
                                      , 0 AS THIS_YEAR_COUNT
                                      , SUM(DA.DONA_AMT) AS TOTAL_DONA_AMT
                                      , SUM(DA.TOTAL_DONA_AMT) AS TOTAL_DONA_DED_AMT
                                    FROM HRA_DONATION_ADJUSTMENT DA
                                      , HRM_PERSON_MASTER        PM
                                      , (-- ���� �λ系��.
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
                                        ) T1
                                  WHERE DA.PERSON_ID            = PM.PERSON_ID
                                    AND PM.PERSON_ID            = T1.PERSON_ID 
                                    AND DA.YEAR_YYYY            = P_YEAR_YYYY
                                    AND DA.SOB_ID               = P_SOB_ID
                                    AND DA.ORG_ID               = P_ORG_ID
                                    AND PM.CORP_ID              = A1.CORP_ID
                                    AND T1.OPERATING_UNIT_ID    = A1.OPERATING_UNIT_ID
                                 UNION ALL
                                 SELECT 0 AS DONA_ADJUST_COUNT
                                      , COUNT(DI.DONATION_INFO_ID) AS THIS_YEAR_COUNT
                                      , 0 AS TOTAL_DONA_AMT
                                      , 0 AS TOTAL_DONA_DED_AMT
                                    FROM HRA_DONATION_INFO DI
                                      , HRM_PERSON_MASTER  PM
                                      , (-- ���� �λ系��.
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
                                        ) T1
                                  WHERE DI.PERSON_ID            = PM.PERSON_ID
                                    AND PM.PERSON_ID            = T1.PERSON_ID 
                                    AND DI.YEAR_YYYY            = P_YEAR_YYYY
                                    AND DI.SOB_ID               = P_SOB_ID
                                    AND DI.ORG_ID               = P_ORG_ID
                                    AND PM.CORP_ID              = A1.CORP_ID
                                    AND T1.OPERATING_UNIT_ID    = A1.OPERATING_UNIT_ID
                                 ) PX1
                         ) SX1
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
--C2 ------------------------------------------------------------------------------------
        FOR C1 IN ( SELECT PM.PERSON_ID
                         , PM.CORP_ID
                         , P_YEAR_YYYY AS YEAR_YYYY
                         , PM.SOB_ID
                         , PM.ORG_ID
                         , ROW_NUMBER () OVER (ORDER BY PM.PERSON_NUM) AS SEQ_NO
                      FROM HRM_PERSON_MASTER PM
                         , (-- ���� �λ系��.
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
                          ) T1
                    WHERE PM.PERSON_ID          = T1.PERSON_ID 
                      AND PM.CORP_ID            = A1.CORP_ID
                      AND T1.OPERATING_UNIT_ID  = A1.OPERATING_UNIT_ID 
                      AND PM.SOB_ID             = P_SOB_ID 
                      AND PM.ORG_ID             = P_ORG_ID 
                      AND EXISTS
                            ( SELECT 'X'
                                FROM HRA_DONATION_ADJUSTMENT DA
                              WHERE DA.PERSON_ID      = PM.PERSON_ID
                                AND DA.YEAR_YYYY      = P_YEAR_YYYY
                                AND DA.SOB_ID         = P_SOB_ID
                                AND DA.ORG_ID         = P_ORG_ID
                            )
                    ORDER BY PM.PERSON_NUM
                  )
        LOOP
          FOR C2 IN ( -- ��α� ��������.
                      SELECT 'C' -- �ڷ������ȣ(���ڵ� ����);
                          || '27' -- �ڷᱸ��(���� 27);
                          || LPAD(A1.TAX_OFFICE_CODE, 3, 0) -- �������ڵ�;
                          || LPAD(C1.SEQ_NO, 6, 0)   -- �Ϸù�ȣ.
                              -- �Ϸù�ȣ;
  /*                              || LPAD(ROWNUM, 6, 0) --AS SEQ_NO    -- �Ϸù�ȣ;*/
                          || RPAD(A1.VAT_NUMBER, 10, ' ') -- ����ڵ�Ϲ�ȣ;
                          || RPAD(REPLACE(PM.REPRE_NUM, '-', ''), 13, ' ') -- �ҵ����� �ֹε�Ϲ�ȣ;
                          || RPAD(CASE
                                    WHEN SUBSTR(REPLACE(PM.REPRE_NUM, '-', ''), 7, 1) BETWEEN '5' AND '8' THEN '9'
                                    ELSE '1'
                                  END, 1, 0) -- ���ܱ��� �����ڵ�;
                          || RPAD(PM.NAME, 30, ' ') -- �ҵ����� ����;
                          || RPAD(NVL(DA.DONA_TYPE, ' '), 2, ' ') -- ����ڵ�;
                          || LPAD(DA.DONA_YYYY, 4, 0)           -- ��γ⵵;
                          || LPAD(NVL(DA.DONA_AMT, 0), 13, 0) -- ��αݾ�(�����,���ó��,������ �ջ�);
                          || LPAD(NVL(DA.PRE_DONA_DED_AMT, 0), 13, 0) -- ������� ������ �ݾ�;
                          || LPAD(NVL(DA.TOTAL_DONA_AMT, 0), 13, 0) -- �������ݾ�;
                          || LPAD(NVL(DA.DONA_DED_AMT, 0), 13, 0)    -- �ش�⵵ �����ݾ�;
                          || LPAD(NVL(DA.LAPSE_DONA_AMT, 0), 13, 0)    -- �ش�⵵ �Ҹ�ݾ�;
                          || LPAD(NVL(DA.NEXT_DONA_AMT, 0), 13, 0)    -- �ش�⵵ �̿��ݾ�;
                          || LPAD(ROW_NUMBER() OVER(PARTITION BY PM.PERSON_NUM ORDER BY PM.PERSON_NUM, DA.YEAR_YYYY), 5, 0)         -- ��α������� �Ϸù�ȣ;
                          || RPAD(' ', 25, ' ') AS RECORD_FILE
                          , DA.YEAR_YYYY AS YEAR_YYYY
                          , PM.PERSON_ID
                          , DA.DONA_TYPE
                          , ROW_NUMBER() OVER(PARTITION BY PM.PERSON_NUM ORDER BY PM.PERSON_NUM, DA.YEAR_YYYY) AS SORT_NUM
                        FROM HRM_PERSON_MASTER PM
                          , HRA_DONATION_ADJUSTMENT DA
                      WHERE PM.PERSON_ID      = DA.PERSON_ID
                        AND DA.YEAR_YYYY      = C1.YEAR_YYYY
                        AND DA.SOB_ID         = C1.SOB_ID
                        AND DA.ORG_ID         = C1.ORG_ID
                        AND DA.PERSON_ID      = C1.PERSON_ID
                      ORDER BY PM.PERSON_NUM, DA.YEAR_YYYY
                    ) 
          LOOP
            V_SEQ_NUM := NVL(V_SEQ_NUM, 0) + 1;
            V_SOURCE_FILE := 'C_RECORD';
            INSERT_REPORT_FILE
              ( P_SEQ_NUM           => V_SEQ_NUM
              , P_SOURCE_FILE       => V_SOURCE_FILE
              , P_SOB_ID            => P_SOB_ID
              , P_ORG_ID            => P_ORG_ID
              , P_REPORT_FILE       => C2.RECORD_FILE
              , P_SORT_NUM          => C2.SORT_NUM
              , P_RECORD_TYPE       => 'C' 
              );
          END LOOP C2;
  --D1 ------------------------------------------------------------------------------------
          FOR D1 IN ( -- ��α� ����.
                      SELECT 'D' -- �ڷ������ȣ(���ڵ� ����);
                          || '27' -- �ڷᱸ��(���� 27);
                          || LPAD(A1.TAX_OFFICE_CODE, 3, 0) -- �������ڵ�;
                          || LPAD(C1.SEQ_NO, 6, 0)    -- �Ϸù�ȣ;
                          || RPAD(A1.VAT_NUMBER, 10, ' ') -- ����ڵ�Ϲ�ȣ;
                          || RPAD(REPLACE(PM.REPRE_NUM, '-', ''), 13, ' ') -- �ҵ����� �ֹε�Ϲ�ȣ;
                          || RPAD(NVL(DI.DONA_TYPE, ' '), 2, ' ') -- ����ڵ�;
                          || RPAD(NVL(REPLACE(DI.CORP_TAX_REG_NO, '-', ''), ' '), 13, ' ') -- ���ó �����Ϲ�ȣ;
                          || RPAD(NVL(DI.CORP_NAME, ' '), 30, ' ') -- ���ó ��ȣ;
                          || RPAD(NVL(CASE 
                                        WHEN DI.RELATION_CODE = '0' THEN '1'
                                        WHEN DI.RELATION_CODE = '3' THEN '2'
                                        WHEN DI.RELATION_CODE IN('4', '5') THEN '3'
                                        WHEN DI.RELATION_CODE IN('1', '2') THEN '4'
                                        WHEN DI.RELATION_CODE IN('6') THEN '5'
                                        ELSE '6'
                                      END, ' '), 1, ' ') -- ����ڿ��� ����;
                          || RPAD(CASE
                                    WHEN SUBSTR(REPLACE(DI.REPRE_NUM, '-', ''), 7, 1) BETWEEN '5' AND '8' THEN '9'
                                    ELSE '1'
                                  END, 1, ' ') --  ��/�ܱ��� �ڵ�;
                          || RPAD(NVL(DI.FAMILY_NAME, ' '), 20, ' ') -- ����;
                          || RPAD(NVL(REPLACE(DI.REPRE_NUM, '-', ''), ' '), 13, ' ') -- ����� �ֹε�Ϲ�ȣ;
                          || LPAD(NVL(DI.DONA_COUNT, 0), 5, 0) --���Ƚ��(�����,���ó��,������ �ջ�);
                          || LPAD(NVL(DI.DONA_AMT, 0), 13, 0) -- ��α�(�����,���ó��,������ �ջ�);/*|| LPAD(I_YEAR_YYYY || '0101', 8, 0) --AS TAX_PERIOD_START
                          || LPAD(ROW_NUMBER() OVER(PARTITION BY PM.PERSON_NUM ORDER BY PM.PERSON_NUM), 5, 0)
                          --|| LPAD(C1.SORT_NUM, 5, 0)         -- ��α������� �Ϸù�ȣ;
                          || RPAD(' ', 42, ' ') AS RECORD_FILE
                          , ROW_NUMBER() OVER(PARTITION BY PM.PERSON_NUM ORDER BY PM.PERSON_NUM) AS SORT_NUM
                        FROM HRM_PERSON_MASTER PM
                          , HRA_DONATION_INFO DI
                      WHERE PM.PERSON_ID    = DI.PERSON_ID
                        AND DI.YEAR_YYYY    = C1.YEAR_YYYY
                        AND DI.SOB_ID       = C1.SOB_ID
                        AND DI.ORG_ID       = C1.ORG_ID
                        AND DI.PERSON_ID    = C1.PERSON_ID
--                        AND DI.DONA_TYPE    = C1.DONA_TYPE
                      ORDER BY PM.PERSON_NUM
                     ) 
          LOOP
            V_SOURCE_FILE := 'D_RECORD';
            INSERT_REPORT_FILE
              ( P_SEQ_NUM           => V_SEQ_NUM
              , P_SOURCE_FILE       => V_SOURCE_FILE
              , P_SOB_ID            => P_SOB_ID
              , P_ORG_ID            => P_ORG_ID
              , P_REPORT_FILE       => D1.RECORD_FILE
              , P_SORT_NUM          => C1.SEQ_NO + (0.00001 * D1.SORT_NUM)
              , P_RECORD_TYPE       => 'D' 
              );
          END LOOP D1;
        END LOOP C1;
      END LOOP B1;
    END LOOP A1; 
  END SET_DONATION_FILE_2013;
               
                
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
  
END HRA_YEAR_ADJUST_FILE_G;
/
