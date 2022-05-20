CREATE OR REPLACE PACKAGE HRA_YEAR_ADJUST_FILE_G
AS

-------------------------------------------------------------------------------
-- 연말정산 지급조서 생성 대상 SELECT.
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
-- 근로소득 파일생성 및 조회.
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
-- 근로소득 파일생성 : 생성된 인원수 RETURN.
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
-- 의료비 명세서 파일생성 및 조회.
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
-- 의료비 명세서 파일생성 : 생성된 인원수 RETURN.
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
-- 기부금 파일생성 및 조회.
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
-- 기부금 명세서 파일생성 : 생성된 인원수 RETURN.
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
-- 2011년도 근로소득 파일생성.
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
-- 2011년도 의료비 파일생성.
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
-- 2011년도 기부금 파일생성.
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
-- 2012년도 근로소득 파일생성.
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
-- 2012년도 의료비 파일생성.
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
-- 2012년도 기부금 파일생성.
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
-- 2013년도 근로소득 파일생성.
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
-- 2013년도 근로소득 파일생성.
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
-- 2013년도 의료비 파일생성.
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
-- 2013년도 기부금 파일생성.
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

END HRA_YEAR_ADJUST_FILE_G;
/
CREATE OR REPLACE PACKAGE BODY HRA_YEAR_ADJUST_FILE_G
AS
/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : HRA_YEAR_ADJUST_FILE_G
/* Description  : 연말정산 계산 관리.
/*
/* Reference by :
/* Program History :
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 18-MAR-2011  Lee Sun Hee        Initialize
/******************************************************************************/
-------------------------------------------------------------------------------
-- 연말정산 지급조서 생성 대상 SELECT.
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
-- 근로소득 파일생성 및 조회.
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
    -- TEMPORARY 삭제.
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
-- 근로소득 파일생성 : 생성된 인원수 RETURN.
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
-- 의료비 명세서 파일생성 및 조회.
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
    -- TEMPORARY 삭제.
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
-- 의료비 명세서 파일생성 : 생성된 인원수 RETURN.
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
-- 기부금 파일생성 및 조회.
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
    -- TEMPORARY 삭제.
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
-- 기부금 명세서 파일생성 : 생성된 인원수 RETURN.
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
-- 2011년도 근로소득 파일생성 및 조회.
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
                    || '20'  -- 갑종근로소득(20);
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
                    || RPAD(' ', 1082, ' ') AS RECORD_FILE
                    , CM.CORP_NAME  -- 법인명.
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
                      || '20'  -- 갑종근로소득(20);
                      || LPAD(REPLACE(OU.TAX_OFFICE_CODE, '-', ''), 3, 0)   -- 세무서코드; 
                      || LPAD(1, 6, 0)                                      -- B레코드의 일련번호;
                      --> 제출자;
                      || RPAD(NVL(REPLACE(OU.VAT_NUMBER, '-', ''), ' '), 10, ' ')      -- 원천징수의무자의 사업자등록번호;
                      || RPAD(NVL(CM.CORP_NAME, ' '), 40, ' ')              -- 법인명(상호);
                      || RPAD(NVL(CM.PRESIDENT_NAME, ' '), 30, ' ')         -- 대표자 성명;
                      || RPAD(NVL(REPLACE(CM.LEGAL_NUMBER, '-', ''), ' '), 13, ' ') -- 법인등록번호;
                      --> 제출내역;
                      || LPAD(NVL(S_YA.NOW_WORKER_COUNT, 0), 7, 0)   -- 수록한 C레코드의 수(근로소득자의 수);
                      || LPAD(NVL(S_YA.PRE_WORKER_COUNT, 0), 7, 0)   -- 수록한 D레코드(전근무처)의 수(C레코드 항목6의 합계)
                      || LPAD(NVL(S_YA.INCOME_TOT_AMT, 0), 14, 0)    -- 총급여 총계(C레코드 급여 합);
                      || LPAD(NVL(S_YA.FIX_IN_TAX, 0), 13, 0)        -- 소득세 결정세액 총계(C레코드 소득세의 합);
                      || LPAD(0, 13, 0)  -- LPAD(NVL(S_YA.FIX_LEGAL_TAX, 0), 13, 0) : 2009년 연말정산 수정(MODIFIED BY YOUNG MIN) 법인세 결정세액총계->공란으로 변경;            
                      || LPAD(NVL(S_YA.FIX_LOCAL_TAX, 0), 13, 0)     -- 주민세 결정세액 총계;
                      || LPAD(NVL(S_YA.FIX_SP_TAX, 0), 13, 0)        -- 농특세 결정세액 총계;
                      || LPAD(NVL(S_YA.FIX_TOTAL_TAX, 0) - NVL(S_YA.FIX_LEGAL_TAX, 0), 13, 0)  -- 결정세액 총계;
                      -- LPAD(NVL(S_YA.FIX_TOTAL_TAX, 0), 13, 0)  -- 결정세액 총계 : 2009년 연말정산 수정(MODIFIED BY YOUNG MIN) 결정세액총계-법인세 결정세액 총계;
                      || LPAD(NVL(P_SUBMIT_PERIOD, '1'), 1, 0)   -- (연간합산 : 1, 휴/폐업에 의한 수시제출 : 2, 수시 분할제출 : 3);
                      || RPAD(' ', 1061, ' ') AS RECORD_FILE
                      , LPAD(REPLACE(OU.TAX_OFFICE_CODE, '-', ''), 3, 0) AS TAX_OFFICE_CODE
                      , RPAD(NVL(REPLACE(OU.VAT_NUMBER, '-', ''), ' '), 10, ' ') AS VAT_NUMBER
                    FROM HRM_CORP_MASTER CM
                       , HRM_OPERATING_UNIT OU
                       , ( -- 제출내역.
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
                               , ( -- 종전근무지 자료수.
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
                          'C'                                           -- 자료관리번호.
                        || '20'                                         --AS DATA_TYPE
                        || RPAD(NVL(B1.TAX_OFFICE_CODE, ' '), 3, ' ')   -- 세무서코드.
                        || LPAD(ROW_NUMBER() OVER(PARTITION BY YA.YEAR_YYYY ORDER BY PM.PERSON_NUM), 6, 0)   -- 일련번호.
                        || LPAD(NVL(B1.VAT_NUMBER, ' '), 10, ' ')       -- 사업자번호.
                        || LPAD(NVL(S_PW.PRE_WORK_COUNT, 0), 2, 0)      -- 종(전)근무처 수;
                        || LPAD(NVL(PM.RESIDENT_TYPE, '1'), 1, 0)       -- 거주자 구분코드(거주자:1, 비거주자:2);
                        || RPAD(CASE 
                                  WHEN PM.RESIDENT_TYPE = '1' THEN ' '
                                  WHEN SUBSTR(REPLACE(PM.REPRE_NUM, '-', ''), 7, 1) BETWEEN '1' AND '4' THEN ' '  -- 1900, 2000년생.
                                  WHEN SUBSTR(REPLACE(PM.REPRE_NUM, '-', ''), 7, 1) BETWEEN '9' AND '0' THEN ' '  -- 1800년대생..
                                  ELSE NVL(S_HN.ISO_NATION_CODE, ' ')
                                END, 2, ' ')  -- 거구지국 코드 : 비거주자만 기록, 거주자는 공란;
                        || LPAD(DECODE(PM.FOREIGN_TAX_YN, 'Y', 1, 2), 1, 0)  -- 외국인단일세율적용(적용:1, 비적용:2);
                        || RPAD(NVL(PM.NAME, ' '), 30, ' ')  -- 성명;
                        || RPAD(CASE
                                  WHEN PM.NATIONALITY_TYPE IS NOT NULL THEN PM.NATIONALITY_TYPE
                                  WHEN SUBSTR(REPLACE(PM.REPRE_NUM, '-', ''), 7, 1) BETWEEN '5' AND '8' THEN '9'
                                  ELSE '1'
                                END, 1, 0)  -- 내/외국인 구분코드;
                        || RPAD(NVL(REPLACE(PM.REPRE_NUM, '-', ''), ' '), 13, ' ')  -- 주민등록번호;
                        || RPAD(CASE
                                  WHEN PM.NATIONALITY_TYPE = '9' THEN NVL(S_HN.ISO_NATION_CODE, ' ')
                                  WHEN SUBSTR(REPLACE(PM.REPRE_NUM, '-', ''), 7, 1) BETWEEN '5' AND '8' THEN NVL(S_HN.ISO_NATION_CODE, ' ')
                                  ELSE ' '
                                END, 2, ' ')  -- 국적코드(외국인인 경우만 기재);
                        || RPAD(NVL(PM.HOUSEHOLD_TYPE, '1'), 1, 0)  -- 세대주여부.
                        || RPAD(CASE 
                                  WHEN (PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE > TO_DATE(P_YEAR_YYYY||'-12-31','YYYY-MM-DD')) THEN '1'
                                  ELSE '2' 
                                END, 1, 0)  -- 연말정산구분.
                        || RPAD(NVL(B1.VAT_NUMBER, ' '), 10, ' ')  -- 사업자등록번호;
                        || RPAD(NVL(A1.CORP_NAME, ' '), 40, ' ')  -- 법인명(상호);
                        -- 2009년 연말정산 수정(MODIFIED BY YOUNG MIN). 귀속년도 시작년월일 -> 근무기간 시작연월일로 변경;
                        || RPAD(/*CASE 
                                  WHEN PM.JOIN_DATE > TRUNC(TO_DATE(P_YEAR_YYYY, 'YYYY'), 'MM') THEN
                                    REPLACE(TO_CHAR(PM.JOIN_DATE, 'YYYY-MM-DD'), '-', '')
                                  ELSE TO_CHAR(P_YEAR_YYYY || '0101')
                                END*/TO_CHAR(YA.ADJUST_DATE_FR, 'YYYYMMDD'), 8, 0)  -- 근무기간 시작연월일;
                        || RPAD(/*CASE 
                                  WHEN PM.RETIRE_DATE IS NOT NULL AND PM.RETIRE_DATE < TO_DATE(P_YEAR_YYYY || '-12-31') THEN
                                    REPLACE(TO_CHAR(PM.RETIRE_DATE, 'YYYY-MM-DD'), '-', '')
                                  ELSE P_YEAR_YYYY || '1231'
                                END*/TO_CHAR(YA.ADJUST_DATE_TO, 'YYYYMMDD'), 8, 0)  -- 근무기간 종료연월일;
                        || LPAD(0, 8, 0)  -- 감면기간 시작연월일;
                        || LPAD(0, 8, 0)  -- 감면기간 종료연월일;
                        --> 근무처별 소득명세-주(현)근무처 총급여.
                        || LPAD(NVL(YA.NOW_PAY_TOT_AMT, 0), 11, 0)  -- 급여총액;
                        || LPAD(NVL(YA.NOW_BONUS_TOT_AMT, 0), 11, 0) -- 상여총액;
                        || LPAD(NVL(YA.NOW_ADD_BONUS_AMT, 0), 11, 0) -- 인정상여;
                        || LPAD(NVL(YA.NOW_STOCK_BENE_AMT, 0), 11, 0) -- 주식매수선택권행사이익;
                        ----> 2009년 연말정산 수정(MODIFIED BY YOUNG MIN). 우리사주조합인출금 추가;
                        || LPAD(0, 11, 0) -- 우리사주조합인출금(계에는 포함하지 않았음);
                        || LPAD(0, 22, 0) -- 공란;
                        || LPAD(NVL(YA.NOW_PAY_TOT_AMT, 0) +
                                NVL(YA.NOW_BONUS_TOT_AMT, 0) +
                                NVL(YA.NOW_ADD_BONUS_AMT, 0) +
                                NVL(YA.NOW_STOCK_BENE_AMT, 0), 11, 0) -- 계;
                        --> 주(현)근무처 비과세 소득.
                        -- 2009년 연말정산 수정(MODIFIED BY YOUNG MIN).주(현)근무처 비과세 소득 전면변경;
                        || LPAD(NVL(YA.NONTAX_SCH_EDU_AMT, 0), 10, 0) -- 비과세-학자금;
                        || LPAD(NVL(YA.NONTAX_MEMBER_AMT, 0), 10, 0) -- 비과세-무보수위원수당;
                        || LPAD(NVL(YA.NONTAX_GUARD_AMT, 0), 10, 0) -- 비과세-경호/승선수당;
                        || LPAD(NVL(YA.NONTAX_CHILD_AMT, 0), 10, 0) -- 비과세-유아/초중등_연구보조/활동비;
                        || LPAD(NVL(YA.NONTAX_HIGH_SCH_AMT, 0), 10, 0) -- 비과세-고등교육_연구보조/활동비;
                        || LPAD(NVL(YA.NONTAX_SPECIAL_AMT, 0), 10, 0) -- 비과세-특정연구기관육성법_연구보조/활동비;
                        || LPAD(NVL(YA.NONTAX_RESEARCH_AMT, 0), 10, 0) -- 비과세-연구기관_연구보조/활동비;
                        || LPAD(NVL(YA.NONTAX_COMPANY_AMT, 0), 10, 0) -- 비과세-기업연구소_연구보조/활동비;
                        || LPAD(NVL(YA.NONTAX_COVER_AMT, 0), 10, 0) -- 비과세-취재수당;
                        || LPAD(NVL(YA.NONTAX_WILD_AMT, 0), 10, 0) -- 비과세-벽지수당;
                        || LPAD(NVL(YA.NONTAX_DISASTER_AMT, 0), 10, 0) -- 비과세-재해관련급여;
                        || LPAD(NVL(YA.NONTAX_OUTS_GOVER_AMT, 0), 10, 0) -- 비과세-외국정부등근무자;
                        || LPAD(NVL(YA.NONTAX_OUTS_ARMY_AMT, 0), 10, 0) -- 비과세-외국주둔군인등;
                        || LPAD(NVL(YA.NONTAX_OUTS_WORK_1, 0), 10, 0) -- 비과세-국외근로(100만원);
                        || LPAD(NVL(YA.NONTAX_OUTS_WORK_2, 0), 10, 0) -- 비과세-국외근로(150만원);
                        || LPAD(NVL(YA.NONTAX_OUTSIDE_AMT, 0), 10, 0) -- 비과세 국외소득;
                        || LPAD(NVL(YA.NONTAX_OT_AMT, 0), 10, 0) -- 비과세 야간근로;
                        || LPAD(NVL(YA.NONTAX_BIRTH_AMT, 0), 10, 0) -- 비과세 출생/보육수당;
                        || LPAD(0, 10, 0)  -- 근로장학금.
                        || LPAD(NVL(YA.NONTAX_STOCK_BENE_AMT, 0), 10, 0) -- 비과세-주식매수선택권;
                        || LPAD(NVL(YA.NONTAX_FOR_ENG_AMT, 0), 10, 0) -- 비과세-외국인기술자;
                        --|| LPAD(NVL(YA.NONTAX_FOREIGNER_AMT, 0), 10, 0) -- 비과세 외국인 근로자(X);
                        --|| LPAD(NVL(YA.NONTAX_EMPL_STOCK_AMT, 0), 10, 0) --  비과세-우리사주조합배정(X);
                        || LPAD(NVL(YA.NONTAX_EMPL_BENE_AMT_1, 0), 10, 0) -- 비과세-우리사주조합인출금(50%);
                        || LPAD(NVL(YA.NONTAX_EMPL_BENE_AMT_2, 0), 10, 0) -- 비과세-우리사주조합인출금(75%);
                        || LPAD(0, 10, 0) -- 비과세-장기미취업자 중소기업 취업;
                        --|| LPAD(NVL(YA.NONTAX_HOUSE_SUBSIDY_AMT, 0), 10, 0) -- 비과세-주택자금보조금(X);
                        || LPAD(NVL(YA.NONTAX_SEA_RESOURCE_AMT, 0), 10, 0) -- 비과세-해저광물자원개발;
                        || LPAD(0, 10, 0) -- 지정비과세;
                        -- 비과세 계;
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
                                --NVL(YA.NONTAX_FOR_ENG_AMT, 0) +  -- 외국인 기술자(감면소득 계로 이동);
                                NVL(YA.NONTAX_EMPL_BENE_AMT_1, 0) +
                                NVL(YA.NONTAX_EMPL_BENE_AMT_2, 0) +
                                --NVL(YA.NONTAX_HOUSE_SUBSIDY_AMT, 0) +                       
                                NVL(YA.NONTAX_SEA_RESOURCE_AMT, 0))  -- 해저광물자원개발(감면소득 계로 이동);
                                --NVL(YA.NONTAX_ETC_AMT, 0),
                                , 10, 0)  -- 비과세계.
                        || LPAD(NVL(YA.NONTAX_FOR_ENG_AMT, 0) + NVL(YA.NONTAX_SEA_RESOURCE_AMT, 0), 10, 0)    -- 감면소득계(항목48 + 항목52);
                        /*|| LPAD(NVL(YA.NONTAX_RESEA_AMT, 0), 10, 0)      -- AS NONTAX_RESEA_AMT
                        || LPAD(NVL(YA.NONTAX_OUTSIDE_AMT, 0), 10, 0) --AS  NONTAX_OUTSIDE_AMT
                        || LPAD(NVL(YA.NONTAX_OT_AMT, 0), 10, 0)  --AS NONTAX_OT_AMT
                        || LPAD(NVL(YA.NONTAX_BIRTH_AMT, 0), 10, 0)  --AS NONTAX_BIRTH_AMT
                        || LPAD(NVL(YA.NONTAX_FOREIGNER_AMT, 0), 10, 0)  --AS NONTAX_FOREIGNER_AMT
                        || LPAD(NVL(YA.NONTAX_ETC_AMT, 0), 10, 0)  --AS NONTAX_ETC_AMT
                        || LPAD(NVL(YA.NONTAX_OUTSIDE_AMT, 0) + 
                                NVL(YA.NONTAX_OT_AMT, 0) + 
                                NVL(YA.NONTAX_RESEA_AMT, 0) + 
                                NVL(YA.NONTAX_ETC_AMT, 0), 10, 0)  --비과세 합계.*/
                        --> 정산명세.
                        || LPAD(NVL(YA.INCOME_TOT_AMT, 0), 11, 0) -- 총급여;
                        || LPAD(NVL(YA.INCOME_DED_AMT, 0), 10, 0) -- 근로소득공제;
                        || LPAD(NVL(YA.INCOME_TOT_AMT, 0) - NVL(YA.INCOME_DED_AMT, 0), 11, 0) -- 근로소득금액;
                        --> 기본공제.
                        || LPAD(NVL(YA.PER_DED_AMT, 0), 8, 0) -- 본인공제금액;
                        || LPAD(NVL(YA.SPOUSE_DED_AMT, 0), 8, 0) -- 배우자공제금액;
                        || LPAD(NVL(YA.SUPP_DED_COUNT, 0), 2, 0) -- 부양가족공제인원;
                        || LPAD(NVL(YA.SUPP_DED_AMT, 0), 8, 0) -- 부양가족공제금액;
                        --> 추가공제.
                        -- 2009년 연말정산 수정(MODIFIED BY YOUNG MIN). 경로우대공제인원 70세이상만 적용;
                        || LPAD(NVL(YA.OLD_DED_COUNT1, 0), 2, 0) -- 경로우대공제인원;
                        || LPAD(NVL(YA.OLD_DED_AMT1, 0), 8, 0) -- 경로우대공제금액;
                        /*|| LPAD(NVL(YA.OLD_DED_COUNT, 0) + NVL(YA.OLD_DED_COUNT1, 0), 2, 0) -- 경로우대공제인원;*/
                        /*|| LPAD(NVL(YA.OLD_DED_AMT, 0) + NVL(YA.OLD_DED_AMT1, 0), 8, 0) -- 경로우대공제금액;*/
                        || LPAD(NVL(YA.DISABILITY_DED_COUNT, 0), 2, 0) -- 장애인공제인원;
                        || LPAD(NVL(YA.DISABILITY_DED_AMT, 0), 8, 0) -- 장애인공제금액;
                        || LPAD(NVL(YA.WOMAN_DED_AMT, 0), 8, 0) -- 부녀자공제금액;
                        || LPAD(NVL(YA.CHILD_DED_COUNT, 0), 2, 0) -- 자녀양육비공제인원;
                        || LPAD(NVL(YA.CHILD_DED_AMT, 0), 8, 0) -- 자녀양육비공제금액;
                        || LPAD(NVL(YA.BIRTH_DED_COUNT, 0), 2, 0) -- 출산/입양자공제인원;
                        || LPAD(NVL(YA.BIRTH_DED_AMT, 0), 8, 0) --  출산/입양자공제금액;
                        || LPAD(0, 10, 0) -- 공란;
                        -- LPAD(NVL(YA.PER_ADD_DED_AMT, 0), 8, 0)   PER_ADD_DED_AMT;
                        --> 다자녀추가공제;
                        || LPAD(NVL(YA.MANY_CHILD_DED_COUNT, 0), 2, 0) -- 다자녀추가공제인원;
                        || LPAD(NVL(YA.MANY_CHILD_DED_AMT, 0), 8, 0) -- 다자녀추가공제금액;
                        -->연금보험료;
                        || LPAD(NVL(YA.NATI_ANNU_AMT, 0), 10, 0) -- 국민연금보험료공제;
                        || LPAD(0, 10, 0)  -- 기타연금보험료공제_공무원연금;
                        || LPAD(0, 10, 0)  -- 기타연금보험료공제_군인연금;
                        || LPAD(0, 10, 0)  -- 기타연금보험료공제_사립학교교직원연금;
                        || LPAD(0, 10, 0)  -- 기타연금보험료공제_별정우체국연금;
                        || LPAD(0, 10, 0)  -- 기타연금보험료공제_과학기술인공제;
                        || LPAD(0, 10, 0)  -- 기타연금보험료공제_근로자퇴직급여보장법;
                        --|| LPAD(NVL(YA.ANNU_INSUR_AMT, 0), 10, 0) -- 기타연금보험료공제;
                        --|| LPAD(NVL(YA.RETR_ANNU_AMT, 0), 10, 0) -- 퇴직연금소득공제;
                        --> 특별공제.
                        -- 보험료공제금;
                        -- 2009년 연말정산 수정(MODIFIED BY YOUNG MIN). 보험료공제금 0원 미만인 경우에는 0원 처리;
                        || LPAD(CASE 
                                  WHEN NVL(YA.MEDIC_INSUR_AMT, 0) < 0 THEN 0
                                  ELSE NVL(YA.MEDIC_INSUR_AMT, 0) 
                                END, 10, 0)  -- 건강보험료;
                        || LPAD(CASE 
                                  WHEN NVL(YA.HIRE_INSUR_AMT, 0) < 0 THEN 0
                                  ELSE NVL(YA.HIRE_INSUR_AMT, 0) 
                                END, 10, 0)  -- 고용보험료;
                        || LPAD(NVL(YA.GUAR_INSUR_AMT, 0), 10, 0)                           -- 보장보험료 ;
                        || LPAD(NVL(YA.DISABILITY_INSUR_AMT, 0), 10, 0)                     -- 장애보험료 ;
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
                        || LPAD(NVL(YA.MEDIC_AMT, 0), 10, 0)  -- 의료비공제금액;
                        || LPAD(NVL(YA.EDUCATION_AMT, 0), 8, 0) -- 교육비공제금액;
                        || LPAD(NVL(YA.HOUSE_INTER_AMT, 0), 8, 0) -- 주택임대차차입금원리금상환공제금액(대출자);
                        || LPAD(0, 8, 0)  -- 주택임차차입금원리금상환액(거주자).
                        || LPAD(NVL(YA.HOUSE_MONTHLY_AMT, 0), 8, 0)  -- 주택자금_월세액;
                        || LPAD(NVL(YA.LONG_HOUSE_PROF_AMT, 0), 8, 0) -- 장기주택저당차입금이자상환공제금액;
                        || LPAD(NVL(YA.LONG_HOUSE_PROF_AMT_1, 0), 8, 0) -- 장기주택저당차입금이자상환공제금액(15);
                        || LPAD(NVL(YA.LONG_HOUSE_PROF_AMT_2, 0), 8, 0) -- 장기주택저당차입금이자상환공제금액(30);
                        || LPAD(NVL(YA.DONAT_AMT, 0), 10, 0)  -- 기부금공제금액;
                        || LPAD(0, 20, 0) --AS SP_DED_SPACE_VALUE
                        -- 2009년 연말정산 수정(MODIFIED BY YOUNG MIN). 혼인/이사비용 폐지;
                        /*|| LPAD(NVL(YA.MARRY_ETC_AMT, 0), 10, 0) -- 혼인/이사비용;*/
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
                                  NVL(YA.MARRY_ETC_AMT, 0)*/, 10, 0) -- 계;
                        || LPAD(NVL(YA.STAND_DED_AMT, 0), 8, 0) -- 표준공제;
                        || LPAD(NVL(YA.SUBT_DED_AMT, 0), 11, 0) -- 차감소득금액;
                        --> 그 밖의 소득공제.
                        || LPAD(NVL(YA.PERS_ANNU_BANK_AMT, 0), 8, 0) -- 개인연금저축소득공제;
                        || LPAD(NVL(YA.ANNU_BANK_AMT, 0), 8, 0) -- 연금저축소득공제;
                        || LPAD(NVL(YA.SMALL_CORPOR_DED_AMT, 0), 10, 0) -- 소기업공제부금소득공제;
                        || LPAD(NVL(YA.HOUSE_APP_DEPOSIT_AMT, 0), 10, 0)  -- 가)주택마련저축소득공제-청약저축;
                        || LPAD(NVL(YA.HOUSE_APP_SAVE_AMT, 0), 10, 0) -- 나)주택마련저축소득공제-주택청약종합저축;
                        || LPAD(NVL(YA.HOUSE_SAVE_AMT, 0), 10, 0)  -- 다)장기주택마련저축.
                        || LPAD(NVL(YA.WORKER_HOUSE_SAVE_AMT, 0), 10, 0)  -- 라)근로자주택마련저축.
                        --|| LPAD(NVL(YA.HOUSE_SAVE_AMT, 0), 10, 0) -- 주택마련저축소득공제;
                        || LPAD(NVL(YA.INVES_AMT, 0), 10, 0) -- 투자조합출자등소득공제;
                        || LPAD(NVL(YA.CREDIT_AMT, 0), 8, 0) -- 신용카드등 소득공제;                        
                        --|| LPAD(CASE
                        --        WHEN NVL(YA.EMPL_STOCK_AMT, 0) < 0 THEN 0
                        --        ELSE 1
                        --      END, 1, 0) -- 우리사주조합소득공제(양수이면 0);
                        || LPAD(ABS(NVL(YA.EMPL_STOCK_AMT, 0)), 10, 0) -- 우리사주조합소득공제(한도 400만원);
                        || LPAD(NVL(YA.LONG_STOCK_SAVING_AMT, 0), 10, 0) -- 장기주식형저축소득공제;
                        -- 2009년 연말정산 수정(MODIFIED BY YOUNG MIN). 고용유지중소기업근로자소득공제/공란 추가;
                        || LPAD(NVL(YA.HIRE_KEEP_EMPLOY_AMT, 0), 10, 0) -- 고용유지중소기업근로자소득공제;
                        || LPAD(0, 10, 0) --AS  PERSON_DED_SPACE                                                      -- 공란;
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
                                END, 1, 0) -- 그밖의 소득공제 계(양수이면 '0'수록);*/
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
                                NVL(YA.HIRE_KEEP_EMPLOY_AMT, 0)), 10, 0) -- 그밖의 소득공제 계(양수이면 '0'수록);
                        || LPAD(NVL(YA.TAX_STD_AMT, 0), 11, 0) -- 종합소득 과세표준;
                        || LPAD(NVL(YA.COMP_TAX_AMT, 0), 10, 0) -- 산출세액;
                        --> 세액감면.
                        || LPAD(NVL(YA.TAX_REDU_IN_LAW_AMT, 0), 10, 0) --소득세법;
                        || LPAD(NVL(YA.TAX_REDU_SP_LAW_AMT, 0), 10, 0) -- 조세특례제한법;
                        || LPAD(0, 10, 0) -- 조세조약.
                        || LPAD(0, 10, 0) -- 공란;
                        || LPAD(NVL(YA.TAX_REDU_IN_LAW_AMT, 0) +
                                NVL(YA.TAX_REDU_SP_LAW_AMT, 0), 10, 0) -- 감면세액계;
                        --> 세액공제.
                        || LPAD(NVL(YA.TAX_DED_INCOME_AMT, 0), 10, 0) -- 근로소득세액공제;
                        || LPAD(NVL(YA.TAX_DED_TAXGROUP_AMT, 0), 10, 0) -- 납세조합공제;
                        || LPAD(NVL(YA.TAX_DED_HOUSE_DEBT_AMT, 0), 10, 0) -- 주택차입금;
                        --  , LPAD(NVL(YA.TAX_DED_LONG_STOCK_AMT, 0), 8, 0) -- 장기주택공제.
                        || LPAD(NVL(YA.TAX_DED_DONAT_POLI_AMT, 0), 10, 0) -- 기부정치자금;
                        || LPAD(NVL(YA.TAX_DED_OUTSIDE_PAY_AMT, 0), 10, 0) -- 외국납부;
                        || LPAD(0, 10, 0) -- 공란;
                        || LPAD(NVL(YA.TAX_DED_INCOME_AMT, 0) +
                                NVL(YA.TAX_DED_TAXGROUP_AMT, 0) +
                                NVL(YA.TAX_DED_HOUSE_DEBT_AMT, 0) +
                                NVL(YA.TAX_DED_DONAT_POLI_AMT, 0) +
                                NVL(YA.TAX_DED_OUTSIDE_PAY_AMT, 0), 10, 0) -- 세액공제계;
                        --> 결정세액.
                        || LPAD(TRUNC(NVL(YA.FIX_IN_TAX_AMT, 0), 0), 10, 0) -- 소득세(원단위 절사);
                        || LPAD(TRUNC(NVL(YA.FIX_LOCAL_TAX_AMT, 0), 0), 10, 0) -- 주민세;
                        || LPAD(TRUNC(NVL(YA.FIX_SP_TAX_AMT, 0), 0), 10, 0) -- 농특세;
                        /* -- 전호수 주석 : 합계 없음.
                        || LPAD(TRUNC(NVL(YA.FIX_IN_TAX_AMT, 0), -1) +
                                TRUNC(NVL(YA.FIX_LOCAL_TAX_AMT, 0), -1) +
                                TRUNC(NVL(YA.FIX_SP_TAX_AMT, 0), -1), 10, 0) -- 결정세액 합계;*/ 
                        /* -- 종(전)납부세액 없음.
                        --> 종(전) 납부세액.
                        || LPAD(TRUNC(NVL(HEW1.IN_TAX_AMT, 0), -1), 10, 0) -- 소득세.
                        || LPAD(TRUNC(NVL(HEW1.LOCAL_TAX_AMT, 0), -1), 10, 0) -- 주민세.
                        || LPAD(TRUNC(NVL(HEW1.SP_TAX_AMT, 0), -1), 10, 0) -- 농특세;
                        || LPAD(TRUNC(NVL(HEW1.IN_TAX_AMT, 0), -1) + 
                                TRUNC(NVL(HEW1.LOCAL_TAX_AMT, 0), -1) + 
                                TRUNC(NVL(HEW1.SP_TAX_AMT, 0), -1), 10, 0) -- 종전 납부세액 합계;*/
                        -- 2009년 연말정산 수정(MODIFIED BY YOUNG MIN). "종(현) 납부세액"에서 "기납부세액 - 주(현)근무지"로 명칭 변경;
                        --> 기납부세액 - 주(현)근무지;
                        || LPAD(TRUNC(NVL(YA.PRE_IN_TAX_AMT, 0) - NVL(S_PW.IN_TAX_AMT, 0), -1), 10, 0) -- 소득세.
                        || LPAD(TRUNC(NVL(YA.PRE_LOCAL_TAX_AMT, 0) - NVL(S_PW.LOCAL_TAX_AMT, 0), -1), 10, 0) --주민세.
                        || LPAD(TRUNC(NVL(YA.PRE_SP_TAX_AMT, 0) - NVL(S_PW.SP_TAX_AMT, 0), -1), 10, 0) -- 농특세.
                        /* -- 전호수 주석 : 합계 없음.
                        || LPAD(TRUNC(NVL(YA.PRE_IN_TAX_AMT, 0) - NVL(HEW1.IN_TAX_AMT, 0), -1) +
                                TRUNC(NVL(YA.PRE_LOCAL_TAX_AMT, 0) - NVL(HEW1.LOCAL_TAX_AMT, 0), -1) +
                                TRUNC(NVL(YA.PRE_SP_TAX_AMT, 0) - NVL(HEW1.SP_TAX_AMT, 0), -1), 10, 0) -- 주(현) 납부세액 합계;*/
                        --> 차감징수세액;
                        -- 2009년 연말정산 수정(MODIFIED BY YOUNG MIN). "차감징수세액"추가(10원미만 단수절사);
                        -- 결정세액 - [주(현)근무지 기납부세액 + 종(전)근무지 기납부세액의 합];
                        || LPAD(CASE
                                  WHEN TRUNC(NVL(YA.FIX_IN_TAX_AMT, 0), -1) - TRUNC(NVL(YA.PRE_IN_TAX_AMT, 0), -1) < 0 THEN 1
                                  ELSE 0
                                END, 1, 0)  -- 0 <= 차감징수세액(소득세) < 1000 인 경우 "0"기재;
                        || LPAD(ABS(TRUNC(TRUNC(NVL(YA.FIX_IN_TAX_AMT, 0), -1) - TRUNC(NVL(YA.PRE_IN_TAX_AMT, 0), -1))), 10, 0) -- 차감소득세.
                        || LPAD(CASE
                                  WHEN (TRUNC(NVL(YA.FIX_LOCAL_TAX_AMT, 0), -1) - TRUNC(NVL(YA.PRE_LOCAL_TAX_AMT, 0), -1)) < 0 THEN 1
                                  ELSE 0
                                END, 1, 0)  -- 0 <= 차감징수세액(주민세) < 1000 인 경우 "0"기재;
                        || LPAD(ABS(TRUNC(TRUNC(NVL(YA.FIX_LOCAL_TAX_AMT, 0), -1) - TRUNC(NVL(YA.PRE_LOCAL_TAX_AMT, 0), -1))), 10, 0) -- 차감주민세.
                        || LPAD(CASE
                                  WHEN (TRUNC(NVL(YA.FIX_SP_TAX_AMT, 0), -1) - TRUNC(NVL(YA.PRE_SP_TAX_AMT, 0), -1)) < 0 THEN 1
                                  ELSE 0
                                END, 1, 0)  -- 0 <= 차감징수세액(농특세) < 1000 인 경우 "0"기재;
                        || LPAD(ABS(TRUNC(TRUNC(NVL(YA.FIX_SP_TAX_AMT, 0), -1) - TRUNC(NVL(YA.PRE_SP_TAX_AMT, 0), -1))), 10, 0)  -- 차감 농특세.
                        /*|| LPAD(CASE
                                  WHEN (TRUNC(NVL(YA.FIX_IN_TAX_AMT, 0), -1) - TRUNC(NVL(YA.PRE_IN_TAX_AMT, 0), -1) +
                                      TRUNC(NVL(YA.FIX_LOCAL_TAX_AMT, 0), -1) - TRUNC(NVL(YA.PRE_LOCAL_TAX_AMT, 0), -1) +
                                      TRUNC(NVL(YA.FIX_SP_TAX_AMT, 0), -1) - TRUNC(NVL(YA.PRE_SP_TAX_AMT, 0), -1)) < 0 THEN 1
                                  ELSE 0
                                END, 1, 0) -- 차감징수세액 계;
                        -- 전호수 주석.
                        || LPAD(ABS(TRUNC(TRUNC(NVL(YA.FIX_IN_TAX_AMT, 0), -1) - TRUNC(NVL(YA.PRE_IN_TAX_AMT, 0), -1)) +
                                   TRUNC(TRUNC(NVL(YA.FIX_LOCAL_TAX_AMT, 0), -1) - TRUNC(NVL(YA.PRE_LOCAL_TAX_AMT, 0), -1)) +
                                   TRUNC(TRUNC(NVL(YA.FIX_SP_TAX_AMT, 0), -1) - TRUNC(NVL(YA.PRE_SP_TAX_AMT, 0), -1))), 10, 0) -- 차감징수세액 계;*/
                        --> 공백.
                        || LPAD(' ', 5, ' ') AS RECORD_FILE
                        , NVL(YA.MEDIC_INSUR_AMT, 0) + NVL(YA.HIRE_INSUR_AMT, 0) AS MEDIC_INSUR_AMT  -- 'E'레코드에서 사용(국세청제공 보험료 포함 예정).
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
                        , ( -- 종전근무처 정보.
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
            --> 종(전)근무처 레코드 <--
            FOR D1 IN ( SELECT -- 자료관리번호;
                              'D' -- 레코드 구분;
                            || '20' -- 자료구분;
                            || RPAD(B1.TAX_OFFICE_CODE, 3, ' ') -- 세무서코드;
                            || LPAD(C1.C_SEQ_NO, 6, '0') -- C레코드의 일련번호.
                            -- 원천징수의무자;
                            || RPAD(B1.VAT_NUMBER, 10, ' ') -- 사업자번호.
                            || RPAD(' ', 50, ' ') -- 공란;
                            -- 소득자;
                            || RPAD(NVL(C1.REPRE_NUM, ' '), 13, ' ') -- 주민번호.
                            -- 근무처별 소득명세 - 종(전)근무처;
                            || RPAD('2',1,' ') -- 납세조합구분;
                            || RPAD(PW.COMPANY_NAME, 40, ' ') -- 법인명(상호);
                            || RPAD(REPLACE(PW.COMPANY_NUM, '-', ''), 10, ' ') -- 사업자등록번호;
                            -- 2009년 연말정산 수정(MODIFIED BY YOUNG MIN). 근무기간/감면기간 시작/종료연월일 추가;
                            || RPAD(CASE -- 근무기간 시작연월일;
                                      WHEN PW.JOIN_DATE > TO_DATE(P_YEAR_YYYY || '-01-01', 'YYYY-MM-DD') THEN TO_CHAR(PW.JOIN_DATE, 'YYYYMMDD')
                                      ELSE P_YEAR_YYYY || '0101'
                                    END, 8, '0')
                            || RPAD(TO_CHAR(NVL(PW.RETR_DATE, C1.JOIN_DATE -1), 'YYYYMMDD'), 8, '0') -- 근무기간 종료연월일;
                            || LPAD('0', 8, '0') -- 감면기간 시작연월일;
                            || LPAD('0', 8, '0') -- 감면기간 종료연월일;
                            || LPAD(NVL(PW.PAY_TOTAL_AMT, 0), 11, 0) -- 급여총액;
                            || LPAD(NVL(PW.BONUS_TOTAL_AMT, 0), 11, 0) -- 상여총액;
                            || LPAD(NVL(PW.ADD_BONUS_AMT, 0), 11, 0) -- 인정상여;
                            || LPAD(NVL(PW.STOCK_BENE_AMT, 0), 11, 0) -- 주식매수선택권행사이익;
                            -- 2009년 연말정산 수정(MODIFIED BY YOUNG MIN). 우리사주조합인출금 추가;
                            || LPAD(0, 11, 0) -- 우리사주조합인출금(계에는 포함하지 않았음);
                            || LPAD(0, 22, 0)
                            || LPAD(NVL(PW.PAY_TOTAL_AMT, 0) +
                                    NVL(PW.BONUS_TOTAL_AMT, 0) +
                                    NVL(PW.ADD_BONUS_AMT, 0) +
                                    NVL(PW.STOCK_BENE_AMT, 0), 11, 0)  -- 계.
                            --> 종(전)근무처 비과세 소득.
                            -- 2009년 연말정산 수정(MODIFIED BY YOUNG MIN).종(전)근무처 비과세 소득 전면변경;
                            || LPAD(NVL(PW.NT_SCH_EDU_AMT, 0), 10, 0) -- 비과세-학자금;
                            || LPAD(NVL(PW.NT_MEMBER_AMT, 0), 10, 0) -- 비과세-무보수위원수당;
                            || LPAD(NVL(PW.NT_GUARD_AMT, 0), 10, 0) -- 비과세-경호/승선수당;
                            || LPAD(NVL(PW.NT_CHILD_AMT, 0), 10, 0) -- 비과세-유아/초중등_연구보조/활동비;
                            || LPAD(NVL(PW.NT_HIGH_SCH_AMT, 0), 10, 0) -- 비과세-고등교육_연구보조/활동비;
                            || LPAD(NVL(PW.NT_SPECIAL_AMT, 0), 10, 0) -- 비과세-특정연구기관육성법_연구보조/활동비;
                            || LPAD(NVL(PW.NT_RESEARCH_AMT, 0), 10, 0) -- 비과세-연구기관_연구보조/활동비;
                            || LPAD(NVL(PW.NT_COMPANY_AMT, 0), 10, 0) -- 비과세-기업연구소_연구보조/활동비;
                            || LPAD(NVL(PW.NT_COVER_AMT, 0), 10, 0) -- 비과세-취재수당;
                            || LPAD(NVL(PW.NT_WILD_AMT, 0), 10, 0) -- 비과세-벽지수당;
                            || LPAD(NVL(PW.NT_DISASTER_AMT, 0), 10, 0) -- 비과세-재해관련급여;
                            || LPAD(NVL(PW.NT_OUTSIDE_GOVER_AMT, 0), 10, 0) -- 비과세-외국정부등근무자;
                            || LPAD(NVL(PW.NT_OUTSIDE_ARMY_AMT, 0), 10, 0) -- 비과세-외국주둔군인등;
                            || LPAD(NVL(PW.NT_OUTSIDE_WORK1, 0), 10, 0) -- 비과세-국외근로(100만원);
                            || LPAD(NVL(PW.NT_OUTSIDE_WORK2, 0), 10, 0) -- 비과세-국외근로(150만원);
                            || LPAD(NVL(PW.NT_OUTSIDE_AMT, 0), 10, 0) -- 비과세 국외소득;
                            || LPAD(NVL(PW.NT_OT_AMT, 0), 10, 0) -- 비과세 야간근로;
                            || LPAD(NVL(PW.NT_BIRTH_AMT, 0), 10, 0) -- 비과세 출생/보육수당;
                            || LPAD(0, 10, 0) -- 근로장학금.
                            || LPAD(NVL(PW.NT_STOCK_BENE_AMT, 0), 10, 0) -- 비과세-주식매수선택권;
                            || LPAD(NVL(PW.NT_FOREIGNER_AMT, 0), 10, 0) -- 비과세-외국인기술자;
                            --|| LPAD(NVL(PW.NONTAX_FOREIGNER_AMT, 0), 10, 0) -- 비과세 외국인 근로자;
                            --|| LPAD(NVL(PW.NONTAX_EMPL_STOCK_AMT, 0), 10, 0) --  비과세-우리사주조합배정;
                            || LPAD(NVL(PW.NT_EMPL_STOCK_AMT, 0), 10, 0) -- 비과세-우리사주조합인출금(50%);
                            || LPAD(NVL(PW.NT_EMPL_BENE_AMT2, 0), 10, 0) -- 비과세-우리사주조합인출금(75%);
                            || LPAD(0, 10, 0)                                  -- 비과세-장기미취업자 중소기업 취업;
                            --|| LPAD(NVL(PW.NONTAX_HOUSE_SUBSIDY_AMT, 0), 10, 0) -- 비과세-주택자금보조금;
                            || LPAD(NVL(PW.NT_SEA_RESOURCE_AMT, 0), 10, 0) -- 비과세-해저광물자원개발;
                            || LPAD(0, 10, 0)                                  -- 지정비과세;
                            --|| LPAD(NVL(PW.NONTAX_ETC_AMT, 0), 10, 0) --AS NONTAX_ETC_AMT     -- 비과세 기타;
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
                                    --NVL(PW.NONTAX_FOR_ENG_AMT, 0) +                           -- 감면소득 계로 이동;
                                    --NVL(PW.NONTAX_FOREIGNER_AMT, 0) +
                                    --NVL(PW.NONTAX_EMPL_STOCK_AMT, 0) +
                                    NVL(PW.NT_EMPL_BENE_AMT1, 0) +
                                    NVL(PW.NT_EMPL_BENE_AMT2, 0),
                                    --NVL(PW.NONTAX_HOUSE_SUBSIDY_AMT, 0) +
                                    --NVL(PW.NONTAX_SEA_RESOURCE_AMT, 0) +                      -- 감면소득 계로 이동;
                                    --NVL(PW.NONTAX_ETC_AMT, 0),
                                    10, 0)  -- 비과세 계;
                            || LPAD(NVL(PW.NT_FOREIGNER_AMT, 0) +
                                    NVL(PW.NT_SEA_RESOURCE_AMT, 0), 10, 0)  -- 감면소득 계;
                            -- 기납부세액 - 종(전)근무지;
                            || LPAD(NVL(PW.IN_TAX_AMT, 0), 10, 0)
                            || LPAD(NVL(PW.LOCAL_TAX_AMT, 0), 10, 0)
                            || LPAD(NVL(PW.SP_TAX_AMT, 0), 10, 0)
                            /*-- 전호수 주석 : 2011년 없어짐.
                            || LPAD(NVL(PW.IN_TAX_AMT, 0) +
                                    NVL(PW.LOCAL_TAX_AMT, 0) +
                                    NVL(PW.SP_TAX_AMT, 0), 10, 0)*/
                            -- || LPAD(NVL(PW.PAY_TOTAL_AMT, 0) + NVL(PW.BONUS_TOTAL_AMT, 0) + NVL(PW.ADD_BONUS_AMT, 0) + NVL(PW.STOCK_BENE_AMT, 0),11, 0) --AS PAY_SUM_AMT                       -- 계;
                            || LPAD(ROW_NUMBER() OVER(PARTITION BY PW.PERSON_ID ORDER BY PW.SEQ_NUM), 2, 0) -- 종(전)근무처 일련번호;
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
-- 외국인 단일세율이 아닐경우만 적용.
          IF C1.FOREIGN_TAX_YN = 'N' THEN
            V_RECORD_FILE := NULL;
            V_SEQ_NO    := 0;
            V_RECORD_COUNT := 0;
            FOR E1 IN ( SELECT 
                              'E' --AS RECORD_TYPE
                            || '20' --AS DATA_TYPE
                            || RPAD(NVL(B1.TAX_OFFICE_CODE, ' '), 3, ' ') -- 세무서코드.
                            || LPAD(NVL(C1.C_SEQ_NO, 0), 6, 0)  -- C레코드의 일련번호.
                            || RPAD(NVL(B1.VAT_NUMBER, ' '), 10, ' ') -- 사업자번호.
                            || RPAD(NVL(C1.REPRE_NUM, ' '), 13, ' ') AS RECORD_HEADER -- 주민번호.
                            --> 소득공제명세 인적사항.
                            , RPAD(NVL(SF.RELATION_CODE, ' '), 1, ' ') -- 관계;
                            || RPAD(CASE
                                      WHEN SUBSTR(REPLACE(SF.REPRE_NUM, '-', ''), 7, 1) BETWEEN '5' AND '8' THEN '9'
                                      ELSE '1'
                                    END, 1, ' ') -- 내/외국인 구분 코드;
                            || RPAD(NVL(SF.FAMILY_NAME, ' '), 20, ' ') -- 성명;
                            || RPAD(REPLACE(SF.REPRE_NUM, '-', ''), 13, ' ') -- 주민번호;
                            || DECODE(SF.BASE_YN, 'Y', '1', ' ') -- 기본공제;
                            || CASE 
                                 WHEN SF.BASE_YN = 'Y' AND SF.DISABILITY_YN = 'Y' THEN '1'
                                 ELSE ' '
                               END  -- 장애인공제;
                            || DECODE(SF.CHILD_YN, 'Y', '1', ' ') -- 자녀양육비공제;
                            || DECODE(SF.WOMAN_YN, 'Y', '1', ' ') -- 부녀자공제;
                            -- 2009년 연말정산 수정(MODIFIED BY YOUNG MIN).경로우대 만70세이상으로 변경;
                            || CASE
                                 --WHEN SF.OLD_YN = 'Y' THEN '1'
                                 WHEN SF.OLD1_YN = 'Y' THEN '1'
                                 ELSE ' '
                               END -- 경로우대공제;
                            -- 2009년 연말정산 수정(MODIFIED BY YOUNG MIN).출산입양자공제추가;
                            || DECODE(SF.BIRTH_YN, 'Y', '1', ' ') -- 출산입양자공제.
                            /*-- 2009년 연말정산 수정(MODIFIED BY YOUNG MIN).다자녀추가공제 폐지;
                            || CASE
                                 WHEN SF.BASE_YN = 'Y' AND C1.MANY_CHILD_DED_AMT <> 0 AND SF.RELATION_CODE = '4' THEN '1'
                                 ELSE ' '
                               END -- 다자녀추가공제;*/
                            --> 국세청 자료.
                            -- 2009년 연말정산 수정(MODIFIED BY YOUNG MIN).국세청자료 공제금액이 음수일 경우 0으로 표기;
                            || LPAD((CASE
                                       WHEN DECODE(SF.RELATION_CODE, 0, NVL(C1.MEDIC_INSUR_AMT, 0), 0) + 
                                            NVL(SF.INSURE_AMT, 0) + NVL(SF.DISABILITY_INSURE_AMT, 0) < 0 THEN 0
                                       ELSE DECODE(SF.RELATION_CODE, 0, NVL(C1.MEDIC_INSUR_AMT, 0), 0) + 
                                            NVL(SF.INSURE_AMT, 0) + NVL(SF.DISABILITY_INSURE_AMT, 0)
                                     END), 10, 0) -- 보험료(본인은 건강보험료 포함);
                            || LPAD(NVL(SF.MEDICAL_AMT, 0), 10, 0) --  의료비;
                            || LPAD(NVL(SF.EDUCATION_AMT, 0), 10, 0) -- 교육비;
                            || LPAD(NVL(SF.CREDIT_AMT, 0), 10, 0) -- 신용카드등;
                            || LPAD(NVL(SF.CHECK_CREDIT_AMT , 0), 10, 0) -- 직불카드;
                            || LPAD(NVL(SF.CASH_AMT, 0) + NVL(SF.ACADE_GIRO_AMT, 0), 10, 0) -- 현금영수증;
                            || LPAD(NVL(SF.DONAT_ALL, 0) +
                                    NVL(SF.DONAT_50P, 0) +
                                    NVL(SF.DONAT_30P, 0) +
                                    NVL(SF.DONAT_10P, 0) +
                                    NVL(SF.DONAT_10P_RELIGION, 0), 10, 0)  -- 기부금.
                            -->국세청자료 이외.
                            || LPAD(NVL(SF.ETC_INSURE_AMT, 0), 10, 0) -- 국세청제공외의 보험료;
                            || LPAD(NVL(SF.ETC_MEDICAL_AMT, 0), 10, 0) -- 국세청제공외의 의료비;
                            || LPAD(NVL(SF.ETC_EDUCATION_AMT, 0), 10, 0) -- 국세청제공외의 교육비;
                            || LPAD(NVL(SF.ETC_CREDIT_AMT, 0) + NVL(SF.ETC_ACADE_GIRO_AMT, 0), 10, 0) -- 국세청제공외의 신용카드;
                            || LPAD(NVL(SF.ETC_CHECK_CREDIT_AMT, 0), 10, 0) -- 국세청제공외의 직불카드;
                            || LPAD(NVL(SF.ETC_DONAT_ALL, 0) +
                                    NVL(SF.ETC_DONAT_50P, 0) +
                                    NVL(SF.ETC_DONAT_30P, 0) +
                                    NVL(SF.ETC_DONAT_10P, 0) +
                                    NVL(SF.ETC_DONAT_10P_RELIGION, 0), 10, 0) AS RECORD_LINE -- 국세청제공외의 기부금;
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
              --> 부양가족수 5인 이상일 경우.
              IF V_E_REC_STD <= V_RECORD_COUNT THEN
                V_SEQ_NO := NVL(V_SEQ_NO, 0) + 1;  -- 부양가족 생성 일련번호.
                V_RECORD_FILE := V_RECORD_FILE 
                                 || LPAD(NVL(V_SEQ_NO, 1), 2, 0)  -- 일련번호.
                                 || RPAD(' ', 368, ' ');  -- 공란.
                
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
                V_SEQ_NO := NVL(V_SEQ_NO, 0) + 1;  -- 부양가족 생성 일련번호.
                V_RECORD_FILE := V_RECORD_FILE 
                                 || LPAD(NVL(V_SEQ_NO, 1), 2, 0)  -- 일련번호.
                                 || RPAD(' ', 368, ' ');  -- 공란.
                                 
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
                            || RPAD(NVL(B1.TAX_OFFICE_CODE, ' '), 3, ' ') -- 세무서코드.
                            || LPAD(C1.C_SEQ_NO, 6, 0) -- C레코드의 일련번호.
                            || RPAD(NVL(B1.VAT_NUMBER, ' '), 10, ' ') -- 사업자번호.
                            || RPAD(NVL(C1.REPRE_NUM, ' '), 13, ' ') AS RECORD_HEADER -- 주민번호.
                            , LPAD(NVL(SI.SAVING_TYPE, ' '), 2, '0')  -- 소득공제구분;
                            || RPAD(SI.BANK_CODE, 3, ' ') -- 금융기관 코드수록;
                            || RPAD(YB.YEAR_BANK_NAME, 30, ' ') -- 금융기관 상호수록;
                            || RPAD(SI.ACCOUNT_NUM, 20, ' ') -- 계좌번호;
                            || LPAD(DECODE(SI.SAVING_TYPE, '41', CASE WHEN 3 < SI.SAVING_COUNT THEN 3 ELSE SI.SAVING_COUNT END , '0'), 2, 0) -- 납입연차-장기주식형저축만 해당;
                            || LPAD(SI.SAVING_AMOUNT, 10, 0) -- 불입금액;
                            || LPAD(SI.SAVING_DED_AMOUNT, 10, 0) AS RECORD_LINE               -- 공제금액;
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
              --> 연금저축등 명세서 15개 이상일 경우.
              IF V_F_REC_STD <= V_RECORD_COUNT THEN
                V_SEQ_NO := NVL(V_SEQ_NO, 0) + 1;  -- 연금저축 생성 일련번호.
                V_RECORD_FILE := V_RECORD_FILE || RPAD(' ', 70, ' ');  -- 공란.
                
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
                V_SEQ_NO := NVL(V_SEQ_NO, 0) + 1;  -- 부양가족 생성 일련번호.
                V_RECORD_FILE := V_RECORD_FILE || RPAD(' ', 70, ' ');  -- 공란.
                
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
          END IF;  -- 외국인 단일세율 적용 안할경우만 적용.
          END LOOP C1;    
        END LOOP B1;
    END LOOP A1;
    
  END SET_YEAR_ADJUST_FILE_2011;

-------------------------------------------------------------------------------
-- 2011년도 의료비 파일생성.
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
      RAISE_APPLICATION_ERROR(-20001, 'Error - 사업장 정보를 찾을수 없습니다. 확인하세요');
      RETURN;
    END;
    FOR A1 IN ( SELECT 'A'   -- 자료관리번호.
                    || '26'  -- 26;
                    || LPAD(REPLACE(V_TAX_OFFICE_CODE, '-', ''), 3, 0)  -- 세무서 코드;
                    || LPAD(ROWNUM, 6, 0)  -- 일련번호.
                    || RPAD(TO_CHAR(P_WRITE_DATE, 'YYYYMMDD'), 8, 0) -- 자료를 세무서에 제출하는 연월일;
                    --> 제출자;
/*                    || LPAD(NVL(P_SUBMIT_AGENT, '2'), 1, 0)  -- 제출자구분(세무대리인1, 법인2, 개인3);
                    || RPAD(NVL(P_TAX_PROGRAM_CODE, ' '), 6, ' ')  -- 세무대리인 관리번호(자료제출자가 세무대리인인경우 수록);
*/                    || RPAD(NVL(REPLACE(V_VAT_NUMBER, '-', ''), ' '), 10, ' ')  -- 사업자등록번호;
                    || RPAD(NVL(P_HOMETAX_LOGIN_ID, ' '), 20, ' ')  -- 홈택스ID;
                    || RPAD(NVL(P_TAX_PROGRAM_CODE, '1001'), 4, ' ')  -- 세무프로그램코드;                    
                    || RPAD(NVL(REPLACE(V_VAT_NUMBER, '-', ''), ' '), 10, ' ')  -- 사업자등록번호;
                    || RPAD(NVL(V_CORP_NAME, ' '), 40, ' ')  -- 법인명(상호);
                    || RPAD(NVL(REPLACE(PM.REPRE_NUM, '-', '') ,' '), 13, ' ')  -- 소득자주민번호.
                    || RPAD(NVL(PM.NATIONALITY_TYPE, ' '), 1, 0)  -- 내외국인구분.
                    || RPAD(NVL(PM.NAME, ' '), 30, ' ') --소득자의 성명;
                    || LPAD(NVL(REPLACE(MI.CORP_TAX_REG_NO, '-', ''), ' '), 10, ' ') --AS 지급처의 사업자등록번호;
                    || RPAD(NVL(MI.CORP_NAME, ' '), 40, ' ') -- 지급처 상호;
                    || RPAD(NVL(MI.EVIDENCE_CODE, ' '), 1, ' ')  -- 의료증빙코드;
                    || LPAD(NVL(MI.CREDIT_COUNT, 0) + NVL(MI.ETC_COUNT, 0), 5, 0) -- 건수;
                    || LPAD(NVL(MI.CREDIT_AMT, 0) + NVL(MI.ETC_AMT, 0), 11, 0) --  지급금액;
                    || LPAD(REPLACE(MI.REPRE_NUM, '-', ''), 13, ' ') -- 의료비 지급 대상자의 주민등록번호;
                    || RPAD(CASE
                              WHEN SUBSTR(REPLACE(MI.REPRE_NUM, '-', ''), 7, 1) BETWEEN '5' AND '8' THEN '9'
                              ELSE '1'
                            END, 1, 0) -- 의료비 지급 대상자의 내/외국인 코드;
                    || RPAD(CASE
                              WHEN MI.RELATION_CODE = '0' OR 'Y' IN(MI.DISABILITY_YN, MI.OLD_YN) THEN '1'
                              ELSE '2'
                            END, 1, 0) -- 본인등 해당여부;
                    || RPAD(P_SUBMIT_PERIOD, 1, 0) -- (연간합산 : 1, 휴/폐업에 의한 수시제출 : 2, 수시 분할제출 : 3);
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
-- 2011년도 기부금 파일생성.
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
    FOR A1 IN ( SELECT 'A'   -- 자료관리번호.
                    || '27'  -- 27;
                    || LPAD(NVL(OU.TAX_OFFICE_CODE, ' '), 3, 0)  -- 세무서 코드;
                    || TO_CHAR(P_WRITE_DATE, 'YYYYMMDD')  -- 자료를 세무서에 제출하는 연월일;
                    --> 제출자;
                    || LPAD(NVL(P_SUBMIT_AGENT, '2'), 1, 0)  -- 제출자구분(세무대리인1, 법인2, 개인3);
                    || RPAD(NVL(P_TAX_AGENT, ' '), 6, ' ')  -- 세무대리인 관리번호(자료제출자가 세무대리인인경우 수록);
                    || RPAD(NVL(P_HOMETAX_LOGIN_ID, ' '), 20, ' ')  -- 홈택스ID;
                    || RPAD(NVL(P_TAX_PROGRAM_CODE, '9000'), 4, ' ')  -- 세무프로그램코드;
                    || RPAD(NVL(REPLACE(OU.VAT_NUMBER, '-', ''), ' '), 10, ' ')  -- 사업자등록번호;
                    || RPAD(NVL(CM.CORP_NAME, ' '), 40, ' ')  -- 법인명(상호);
                    || RPAD(NVL(S_PM.DEPT_NAME, ' '), 30, ' ')  -- 담당자(제출자) 부서;
                    || RPAD(NVL(S_PM.NAME, ' '), 30, ' ')  -- 담당자(제출자) 성명;
                    || RPAD(NVL(REPLACE(CM.TEL_NUMBER, '-', ''), ' '), 15, ' ')  -- 담당자(제출자) 전화번호;
                    --> 제출내역.
                    || LPAD(1, 5, 0)  -- 신고의무자수 (B레코드);
                    || LPAD(NVL(P_USE_LANGUAGE_CODE, '101'), 3, 0)  -- 사용한글코드;
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
      FOR B1 IN ( -- 기부금 지급명세서.
                  SELECT 'B' --AS RECORD_TYPE   -- 자료관리번호(레코드 구분);
                      || '27' --AS DATA_TYPE     -- 자료구분(명세서 27);
                      || RPAD(A1.TAX_OFFICE_CODE, 3, 0) -- 세무서코드;
                      || LPAD(ROWNUM, 6, 0) -- 일련번호;
                      -- 원천징수의무자;
                      || RPAD(A1.VAT_NUMBER, 10, ' ') -- 사업자등록번호;
                      || RPAD(A1.CORP_NAME, 40, ' ') -- 상호명;
                      -- 제출내역;
                      || LPAD(NVL(SX1.DONA_ADJUST_COUNT, 0), 7, 0) -- 기부금조정명세레코드수;
                      || LPAD(NVL(SX1.THIS_YEAR_COUNT, 0), 7, 0) -- 해당년도 기부금조정명세레코드수;
                      || LPAD(NVL(SX1.TOTAL_DONA_AMT, 0), 13, 0)  -- 기부금액 총액.
                      || LPAD(NVL(SX1.TOTAL_DONA_DED_AMT, 0), 13, 0)  -- 공제대상금액총액;
                      || LPAD(NVL(P_SUBMIT_PERIOD, '1'), 1, 0) -- (연간합산 : 1, 휴/폐업에 의한 수시제출 : 2, 수시 분할제출 : 3);
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
          FOR C2 IN ( -- 기부금 조정명세서.
                      SELECT 'C' -- 자료관리번호(레코드 구분);
                          || '27' -- 자료구분(명세서 27);
                          || LPAD(A1.TAX_OFFICE_CODE, 3, 0) -- 세무서코드;
                          || LPAD(C1.SEQ_NO, 6, 0)   -- 일련번호.
                              -- 일련번호;
  /*                              || LPAD(ROWNUM, 6, 0) --AS SEQ_NO    -- 일련번호;*/
                          || RPAD(A1.VAT_NUMBER, 10, ' ') -- 사업자등록번호;
                          || RPAD(REPLACE(PM.REPRE_NUM, '-', ''), 13, ' ') -- 소득자의 주민등록번호;
                          || RPAD(CASE
                                    WHEN SUBSTR(REPLACE(PM.REPRE_NUM, '-', ''), 7, 1) BETWEEN '5' AND '8' THEN '9'
                                    ELSE '1'
                                  END, 1, 0) -- 내외국인 구분코드;
                          || RPAD(PM.NAME, 30, ' ') -- 소득자의 성명;
                          || RPAD(NVL(DA.DONA_TYPE, ' '), 2, ' ') -- 기부코드;
                          || LPAD(DA.DONA_YYYY, 4, 0)           -- 기부년도;
                          || LPAD(NVL(DA.DONA_AMT, 0), 13, 0) -- 기부금액(기부자,기부처별,유형별 합산);
                          || LPAD(NVL(DA.PRE_DONA_DED_AMT, 0), 13, 0) -- 전년까지 공제된 금액;
                          || LPAD(NVL(DA.TOTAL_DONA_AMT, 0), 13, 0) -- 공제대상금액;
                          || LPAD(NVL(DA.DONA_DED_AMT, 0), 13, 0)    -- 해당년도 공제금액;
                          || LPAD(NVL(DA.LAPSE_DONA_AMT, 0), 13, 0)    -- 해당년도 소멸금액;
                          || LPAD(NVL(DA.NEXT_DONA_AMT, 0), 13, 0)    -- 해당년도 이월금액;
                          || LPAD(ROW_NUMBER() OVER(PARTITION BY PM.PERSON_NUM ORDER BY PM.PERSON_NUM, SX1.YEAR_YYYY), 5, 0)         -- 기부금조정명세 일련번호;
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
          FOR D1 IN ( -- 기부금 명세서.
                      SELECT 'D' -- 자료관리번호(레코드 구분);
                          || '27' -- 자료구분(명세서 27);
                          || LPAD(A1.TAX_OFFICE_CODE, 3, 0) -- 세무서코드;
                          || LPAD(C1.SEQ_NO, 6, 0)    -- 일련번호;
                          || RPAD(A1.VAT_NUMBER, 10, ' ') -- 사업자등록번호;
                          || RPAD(REPLACE(PM.REPRE_NUM, '-', ''), 13, ' ') -- 소득자의 주민등록번호;
                          || RPAD(NVL(DI.DONA_TYPE, ' '), 2, ' ') -- 기부코드;
                          || RPAD(NVL(REPLACE(DI.CORP_TAX_REG_NO, '-', ''), ' '), 13, ' ') -- 기부처 사업등록번호;
                          || RPAD(NVL(DI.CORP_NAME, ' '), 30, ' ') -- 기부처 상호;
                          || RPAD(NVL(CASE 
                                        WHEN DI.RELATION_CODE = '0' THEN '1'
                                        WHEN DI.RELATION_CODE = '3' THEN '2'
                                        WHEN DI.RELATION_CODE IN('4', '5') THEN '3'
                                        WHEN DI.RELATION_CODE IN('1', '2') THEN '4'
                                        WHEN DI.RELATION_CODE IN('6') THEN '5'
                                        ELSE '6'
                                      END, ' '), 1, ' ') -- 기부자와의 관계;
                          || RPAD(CASE
                                    WHEN SUBSTR(REPLACE(DI.REPRE_NUM, '-', ''), 7, 1) BETWEEN '5' AND '8' THEN '9'
                                    ELSE '1'
                                  END, 1, ' ') --  내/외국인 코드;
                          || RPAD(NVL(DI.FAMILY_NAME, ' '), 20, ' ') -- 성명;
                          || RPAD(NVL(REPLACE(DI.REPRE_NUM, '-', ''), ' '), 13, ' ') -- 기부자 주민등록번호;
                          || LPAD(NVL(DI.DONA_COUNT, 0), 5, 0) --기부횟수(기부자,기부처별,유형별 합산);
                          || LPAD(NVL(DI.DONA_AMT, 0), 13, 0) -- 기부금(기부자,기부처별,유형별 합산);/*|| LPAD(I_YEAR_YYYY || '0101', 8, 0) --AS TAX_PERIOD_START
                          || LPAD(ROW_NUMBER() OVER(PARTITION BY PM.PERSON_NUM ORDER BY PM.PERSON_NUM), 5, 0)
                          --|| LPAD(C1.SORT_NUM, 5, 0)         -- 기부금조정명세 일련번호;
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
-- 2012년도 근로소득 파일생성 및 조회.
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
                    || '20'  -- 갑종근로소득(20);
                    || LPAD(REPLACE(OU.TAX_OFFICE_CODE, '-', ''), 3, 0)  -- 세무서 코드;
                    || TO_CHAR(P_WRITE_DATE, 'YYYYMMDD')  -- 자료를 세무서에 제출하는 연월일;
                    --> 제출자;
                    || LPAD(NVL(P_SUBMIT_AGENT, '2'), 1, 0)  -- 제출자구분(세무대리인1, 법인2, 개인3);
                    || RPAD(NVL(P_TAX_AGENT, ' '), 6, ' ')  -- 세무대리인 관리번호(자료제출자가 세무대리인인경우 수록);
                    || RPAD(NVL(P_HOMETAX_LOGIN_ID, ' '), 20, ' ')  -- 홈택스ID;
                    || RPAD(NVL(P_TAX_PROGRAM_CODE, '1001'), 4, ' ')  -- 세무프로그램코드;
                    || RPAD(NVL(REPLACE(OU.VAT_NUMBER, '-', ''), ' '), 10, ' ')  -- 사업자등록번호;
                    || RPAD(NVL(REPLACE(CM.CORP_NAME, ' ', ''), ' '), 40, ' ')  -- 법인명(상호);
                    || RPAD(NVL(REPLACE(S_PM.DEPT_NAME, ' ', ''), ' '), 30, ' ')  -- 담당자(제출자) 부서;
                    || RPAD(NVL(REPLACE(S_PM.NAME, ' ', ''), ' '), 30, ' ')  -- 담당자(제출자) 성명;
                    || RPAD(NVL(REPLACE(CM.TEL_NUMBER, '-', ''), ' '), 15, ' ')  -- 담당자(제출자) 전화번호;
                    --> 제출내역.
                    || LPAD(1, 5, 0)  -- 신고의무자수 (B레코드);
                    || LPAD(NVL(P_USE_LANGUAGE_CODE, '101'), 3, 0)  -- 사용한글코드;
                    || RPAD(' ', 1152, ' ') AS RECORD_FILE
                    , CM.CORP_NAME  -- 법인명.
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
                      || '20'  -- 갑종근로소득(20);
                      || LPAD(REPLACE(OU.TAX_OFFICE_CODE, '-', ''), 3, 0)   -- 세무서코드; 
                      || LPAD(1, 6, 0)                                      -- B레코드의 일련번호;
                      --> 제출자;
                      || RPAD(NVL(REPLACE(OU.VAT_NUMBER, '-', ''), ' '), 10, ' ')  -- 원천징수의무자의 사업자등록번호;
                      || RPAD(NVL(REPLACE(CM.CORP_NAME, ' ', ''), ' '), 40, ' ')  -- 법인명(상호);
                      || RPAD(NVL(REPLACE(CM.PRESIDENT_NAME, ' ', ''), ' '), 30, ' ')  -- 대표자 성명;
                      || RPAD(NVL(REPLACE(CM.LEGAL_NUMBER, '-', ''), ' '), 13, ' ') -- 법인등록번호;
                      --> 제출내역;
                      || LPAD(NVL(S_YA.NOW_WORKER_COUNT, 0), 7, 0)   -- 수록한 C레코드의 수(근로소득자의 수);
                      || LPAD(NVL(S_YA.PRE_WORKER_COUNT, 0), 7, 0)   -- 수록한 D레코드(전근무처)의 수(C레코드 항목6의 합계)
                      || LPAD(NVL(S_YA.INCOME_TOT_AMT, 0), 14, 0)    -- 총급여 총계(C레코드 급여 합);
                      || LPAD(NVL(S_YA.FIX_IN_TAX, 0), 13, 0)        -- 소득세 결정세액 총계(C레코드 소득세의 합);
                      || LPAD(0, 13, 0)  -- LPAD(NVL(S_YA.FIX_LEGAL_TAX, 0), 13, 0) : 2009년 연말정산 수정 -- 법인세 결정세액총계->공란으로 변경;            
                      || LPAD(NVL(S_YA.FIX_LOCAL_TAX, 0), 13, 0)     -- 주민세 결정세액 총계;
                      || LPAD(NVL(S_YA.FIX_SP_TAX, 0), 13, 0)        -- 농특세 결정세액 총계;
                      || LPAD(NVL(S_YA.FIX_TOTAL_TAX, 0) - NVL(S_YA.FIX_LEGAL_TAX, 0), 13, 0)  -- 결정세액 총계;
                      -- LPAD(NVL(S_YA.FIX_TOTAL_TAX, 0), 13, 0)  -- 결정세액 총계 : 2009년 연말정산 수정 결정세액총계-법인세 결정세액 총계;
                      || LPAD(NVL(P_SUBMIT_PERIOD, '1'), 1, 0)   -- (연간합산 : 1, 휴/폐업에 의한 수시제출 : 2, 수시 분할제출 : 3);
                      || RPAD(' ', 1131, ' ') AS RECORD_FILE
                      , LPAD(REPLACE(OU.TAX_OFFICE_CODE, '-', ''), 3, 0) AS TAX_OFFICE_CODE
                      , RPAD(NVL(REPLACE(OU.VAT_NUMBER, '-', ''), ' '), 10, ' ') AS VAT_NUMBER
                    FROM HRM_CORP_MASTER CM
                       , HRM_OPERATING_UNIT OU
                       , ( -- 제출내역.
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
                               , ( -- 종전근무지 자료수.
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
                          'C'                                           -- 1.자료관리번호.
                        || '20'                                         -- 2.AS DATA_TYPE
                        || RPAD(NVL(B1.TAX_OFFICE_CODE, ' '), 3, ' ')   -- 3.세무서코드.
                        || LPAD(ROW_NUMBER() OVER(PARTITION BY YA.YEAR_YYYY ORDER BY PM.PERSON_NUM), 6, 0)   -- 4.일련번호.
                        || LPAD(NVL(B1.VAT_NUMBER, ' '), 10, ' ')       -- 5.사업자번호.
                        || LPAD(NVL(S_PW.PRE_WORK_COUNT, 0), 2, 0)      -- 6.종(전)근무처 수;
                        || LPAD(NVL(PM.RESIDENT_TYPE, '1'), 1, 0)       -- 7.거주자 구분코드(거주자:1, 비거주자:2);
                        || RPAD(CASE 
                                  WHEN PM.RESIDENT_TYPE = '1' THEN ' '
                                  WHEN SUBSTR(REPLACE(PM.REPRE_NUM, '-', ''), 7, 1) BETWEEN '1' AND '4' THEN ' '  -- 1900, 2000년생.
                                  WHEN SUBSTR(REPLACE(PM.REPRE_NUM, '-', ''), 7, 1) BETWEEN '9' AND '0' THEN ' '  -- 1800년대생..
                                  ELSE NVL(S_HN.ISO_NATION_CODE, ' ')
                                END, 2, ' ')  -- 8.거구지국 코드 : 비거주자만 기록, 거주자는 공란;
                        || LPAD(DECODE(PM.FOREIGN_TAX_YN, 'Y', 1, 2), 1, 0)  -- 9.외국인단일세율적용(적용:1, 비적용:2);
                        || RPAD(NVL(REPLACE(PM.NAME, ' ', ''), ' '), 30, ' ')  -- 10.성명;
                        || RPAD(CASE
                                  WHEN PM.NATIONALITY_TYPE IS NOT NULL THEN PM.NATIONALITY_TYPE
                                  WHEN SUBSTR(REPLACE(PM.REPRE_NUM, '-', ''), 7, 1) BETWEEN '5' AND '8' THEN '9'
                                  ELSE '1'
                                END, 1, 0)  -- 11.내/외국인 구분코드;
                        || RPAD(NVL(REPLACE(PM.REPRE_NUM, '-', ''), ' '), 13, ' ')  -- 12.주민등록번호;
                        || RPAD(CASE
                                  WHEN PM.NATIONALITY_TYPE = '9' THEN NVL(S_HN.ISO_NATION_CODE, ' ')
                                  WHEN SUBSTR(REPLACE(PM.REPRE_NUM, '-', ''), 7, 1) BETWEEN '5' AND '8' THEN NVL(S_HN.ISO_NATION_CODE, ' ')
                                  ELSE ' '
                                END, 2, ' ')  -- 13.국적코드(외국인인 경우만 기재);
                        || RPAD(NVL(PM.HOUSEHOLD_TYPE, '1'), 1, 0)  -- 14.세대주여부.
                        || RPAD(CASE 
                                  WHEN (PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE > TO_DATE(P_YEAR_YYYY||'-12-31','YYYY-MM-DD')) THEN '1'
                                  ELSE '2' 
                                END, 1, 0)  -- 15.연말정산구분(계속근로: 1, 중도퇴사:2).
                        || RPAD(NVL(B1.VAT_NUMBER, ' '), 10, ' ')  -- 주현근무처 사업자등록번호;
                        || RPAD(NVL(A1.CORP_NAME, ' '), 40, ' ')  -- 주현근무처 법인명(상호);
                        || RPAD(TO_CHAR(YA.ADJUST_DATE_FR, 'YYYYMMDD'), 8, 0)  -- 근무기간 시작연월일;
                        || RPAD(TO_CHAR(YA.ADJUST_DATE_TO, 'YYYYMMDD'), 8, 0)  -- 근무기간 종료연월일;
                        || LPAD(0, 8, 0)  -- 감면기간 시작연월일;
                        || LPAD(0, 8, 0)  -- 감면기간 종료연월일;
                        --> 근무처별 소득명세-주(현)근무처 총급여.
                        || LPAD(NVL(YA.NOW_PAY_TOT_AMT, 0)+ 
                                NVL(YA.INCOME_OUTSIDE_AMT, 0), 11, 0)  -- 급여총액;
                        || LPAD(NVL(YA.NOW_BONUS_TOT_AMT, 0), 11, 0) -- 상여총액;
                        || LPAD(NVL(YA.NOW_ADD_BONUS_AMT, 0), 11, 0) -- 인정상여;
                        || LPAD(NVL(YA.NOW_STOCK_BENE_AMT, 0), 11, 0) -- 주식매수선택권행사이익;
                        ----> 2009년 연말정산 수정(우리사주조합인출금 추가);
                        || LPAD(0, 11, 0) -- 우리사주조합인출금(계에는 포함하지 않았음);
                        || LPAD(0, 22, 0) -- 공란;
                        || LPAD(NVL(YA.NOW_PAY_TOT_AMT, 0) +
                                NVL(YA.NOW_BONUS_TOT_AMT, 0) +
                                NVL(YA.NOW_ADD_BONUS_AMT, 0) +
                                NVL(YA.NOW_STOCK_BENE_AMT, 0) + 
                                NVL(YA.INCOME_OUTSIDE_AMT, 0), 11, 0) -- 계;
                        --> 주(현)근무처 비과세 소득.
                        -- 2009년 연말정산 수정(주(현)근무처 비과세 소득 변경);
                        || LPAD(NVL(YA.NONTAX_SCH_EDU_AMT, 0), 10, 0) -- 비과세-학자금;
                        || LPAD(NVL(YA.NONTAX_MEMBER_AMT, 0), 10, 0) -- 비과세-무보수위원수당;
                        || LPAD(NVL(YA.NONTAX_GUARD_AMT, 0), 10, 0) -- 비과세-경호/승선수당;
                        || LPAD(NVL(YA.NONTAX_CHILD_AMT, 0), 10, 0) -- 비과세-유아/초중등_연구보조/활동비;
                        || LPAD(NVL(YA.NONTAX_HIGH_SCH_AMT, 0), 10, 0) -- 비과세-고등교육_연구보조/활동비;
                        || LPAD(NVL(YA.NONTAX_SPECIAL_AMT, 0), 10, 0) -- 비과세-특정연구기관육성법_연구보조/활동비;
                        || LPAD(NVL(YA.NONTAX_RESEARCH_AMT, 0), 10, 0) -- 비과세-연구기관_연구보조/활동비;
                        || LPAD(NVL(YA.NONTAX_COMPANY_AMT, 0), 10, 0) -- 비과세-기업연구소_연구보조/활동비;
                        -- 전호수 : 2012년도 추가 BEGIN --
                        || LPAD(0, 10, 0)  -- 비과세 : 보육교사 근무환경개선비.
                        || LPAD(0, 10, 0)  -- 비과세 : 사립유치원 수석교사/교사의 인건비.
                        -- END --
                        || LPAD(NVL(YA.NONTAX_COVER_AMT, 0), 10, 0) -- 비과세-취재수당;
                        || LPAD(NVL(YA.NONTAX_WILD_AMT, 0), 10, 0) -- 비과세-벽지수당;
                        || LPAD(NVL(YA.NONTAX_DISASTER_AMT, 0), 10, 0) -- 비과세-재해관련급여;
                        || LPAD(NVL(YA.NONTAX_OUTS_GOVER_AMT, 0), 10, 0) -- 비과세-외국정부등근무자;
                        || LPAD(NVL(YA.NONTAX_OUTS_ARMY_AMT, 0), 10, 0) -- 비과세-외국주둔군인등;
                        || LPAD(NVL(YA.NONTAX_OUTS_WORK_1, 0), 10, 0) -- 비과세-국외근로(100만원);
                        || LPAD(NVL(YA.NONTAX_OUTS_WORK_2, 0), 10, 0) -- 국외근로200만원(300만원);
                        || LPAD(NVL(YA.NONTAX_OUTSIDE_AMT, 0), 10, 0) -- 비과세 국외소득;
                        || LPAD(NVL(YA.NONTAX_OT_AMT, 0), 10, 0) -- 비과세 야간근로;
                        || LPAD(NVL(YA.NONTAX_BIRTH_AMT, 0), 10, 0) -- 비과세 출생/보육수당;
                        || LPAD(0, 10, 0)  -- 근로장학금.
                        || LPAD(NVL(YA.NONTAX_STOCK_BENE_AMT, 0), 10, 0) -- 비과세-주식매수선택권;
                        || LPAD(NVL(YA.NONTAX_FOR_ENG_AMT, 0), 10, 0) -- 비과세-외국인기술자;
                        --|| LPAD(NVL(YA.NONTAX_FOREIGNER_AMT, 0), 10, 0) -- 비과세 외국인 근로자(X);
                        --|| LPAD(NVL(YA.NONTAX_EMPL_STOCK_AMT, 0), 10, 0) --  비과세-우리사주조합배정(X);
                        || LPAD(NVL(YA.NONTAX_EMPL_BENE_AMT_1, 0), 10, 0) -- 비과세-우리사주조합인출금(50%);
                        || LPAD(NVL(YA.NONTAX_EMPL_BENE_AMT_2, 0), 10, 0) -- 비과세-우리사주조합인출금(75%);
                        || LPAD(0, 10, 0) -- 비과세-장기미취업자 중소기업 취업;
                        --|| LPAD(NVL(YA.NONTAX_HOUSE_SUBSIDY_AMT, 0), 10, 0) -- 비과세-주택자금보조금(X);
                        || LPAD(NVL(YA.NONTAX_SEA_RESOURCE_AMT, 0), 10, 0) -- 비과세-해저광물자원개발;
                        -- 전호수 추가 : 2012년도 적용 BEGIN --
                        || LPAD(0, 10, 0)  -- 전공의수련보조수당.
                        || LPAD(0, 10, 0)  -- 중소기업 취업 청년 소득세 감면;
                        || LPAD(0, 10, 0)  -- 조세조약상 교직자 감면;
                        --|| LPAD(0, 10, 0) -- 지정비과세;
                        -- 전호수 추가 : 2012년도 적용 END --
                        -- 비과세 계;
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
                                --NVL(YA.NONTAX_FOR_ENG_AMT, 0) +  -- 외국인 기술자(감면소득 계로 이동);
                                NVL(YA.NONTAX_EMPL_BENE_AMT_1, 0) +
                                NVL(YA.NONTAX_EMPL_BENE_AMT_2, 0) +
                                --NVL(YA.NONTAX_HOUSE_SUBSIDY_AMT, 0) +                       
                                NVL(YA.NONTAX_SEA_RESOURCE_AMT, 0))  -- 해저광물자원개발(감면소득 계로 이동);
                                --NVL(YA.NONTAX_ETC_AMT, 0),
                                , 10, 0)  -- 비과세계.
                        || LPAD(NVL(YA.NONTAX_FOR_ENG_AMT, 0) + NVL(YA.NONTAX_SEA_RESOURCE_AMT, 0), 10, 0)    -- 감면소득계(항목48 + 항목52);
                        --> 정산명세.
                        || LPAD(NVL(YA.INCOME_TOT_AMT, 0), 11, 0) -- 총급여;
                        || LPAD(NVL(YA.INCOME_DED_AMT, 0), 10, 0) -- 근로소득공제;
                        || LPAD(NVL(YA.INCOME_TOT_AMT, 0) - NVL(YA.INCOME_DED_AMT, 0), 11, 0) -- 근로소득금액;
                        --> 기본공제.
                        || LPAD(NVL(YA.PER_DED_AMT, 0), 8, 0) -- 본인공제금액;
                        || LPAD(NVL(YA.SPOUSE_DED_AMT, 0), 8, 0) -- 배우자공제금액;
                        || LPAD(NVL(YA.SUPP_DED_COUNT, 0), 2, 0) -- 부양가족공제인원;
                        || LPAD(NVL(YA.SUPP_DED_AMT, 0), 8, 0) -- 부양가족공제금액;
                        --> 추가공제.
                        -- 2009년 BEGIN : 경로우대공제인원 70세이상만 적용;
                        || LPAD(NVL(YA.OLD_DED_COUNT1, 0), 2, 0) -- 경로우대공제인원;
                        || LPAD(NVL(YA.OLD_DED_AMT1, 0), 8, 0) -- 경로우대공제금액;
                        /*
                        || LPAD(NVL(YA.OLD_DED_COUNT, 0) + NVL(YA.OLD_DED_COUNT1, 0), 2, 0) -- 경로우대공제인원;
                        || LPAD(NVL(YA.OLD_DED_AMT, 0) + NVL(YA.OLD_DED_AMT1, 0), 8, 0) -- 경로우대공제금액;*/
                        -- 2009년 END;
                        || LPAD(NVL(YA.DISABILITY_DED_COUNT, 0), 2, 0) -- 장애인공제인원;
                        || LPAD(NVL(YA.DISABILITY_DED_AMT, 0), 8, 0) -- 장애인공제금액;
                        || LPAD(NVL(YA.WOMAN_DED_AMT, 0), 8, 0) -- 부녀자공제금액;
                        || LPAD(NVL(YA.CHILD_DED_COUNT, 0), 2, 0) -- 자녀양육비공제인원;
                        || LPAD(NVL(YA.CHILD_DED_AMT, 0), 8, 0) -- 자녀양육비공제금액;
                        || LPAD(NVL(YA.BIRTH_DED_COUNT, 0), 2, 0) -- 출산/입양자공제인원;
                        || LPAD(NVL(YA.BIRTH_DED_AMT, 0), 8, 0) --  출산/입양자공제금액;
                        || LPAD(0, 10, 0) -- 공란;
                        -- LPAD(NVL(YA.PER_ADD_DED_AMT, 0), 8, 0)   PER_ADD_DED_AMT;
                        --> 다자녀추가공제;
                        || LPAD(NVL(YA.MANY_CHILD_DED_COUNT, 0), 2, 0) -- 다자녀추가공제인원;
                        || LPAD(NVL(YA.MANY_CHILD_DED_AMT, 0), 8, 0) -- 다자녀추가공제금액;
                        -->연금보험료;
                        || LPAD(NVL(YA.NATI_ANNU_AMT, 0), 10, 0) -- 국민연금보험료공제;
                        || LPAD(NVL(YA.ANNU_INSUR_AMT, 0), 10, 0)  -- 기타연금보험료공제_공무원연금;
                        || LPAD(0, 10, 0)  -- 기타연금보험료공제_군인연금;
                        || LPAD(0, 10, 0)  -- 기타연금보험료공제_사립학교교직원연금;
                        || LPAD(0, 10, 0)  -- 기타연금보험료공제_별정우체국연금;
                        || LPAD(0, 10, 0)  -- 기타연금보험료공제_과학기술인공제;
                        || LPAD(NVL(YA.RETR_ANNU_AMT, 0), 10, 0)  -- 기타연금보험료공제_근로자퇴직급여보장법;
                        --> 특별공제.
                        -- 보험료공제금;
                        -- 2009년 연말정산 BEGIN. 보험료공제금 0원 미만인 경우에는 0원 처리;
                        || LPAD(CASE 
                                  WHEN NVL(YA.MEDIC_INSUR_AMT, 0) < 0 THEN 0
                                  ELSE NVL(YA.MEDIC_INSUR_AMT, 0) 
                                END, 10, 0)  -- 건강보험료;
                        || LPAD(CASE 
                                  WHEN NVL(YA.HIRE_INSUR_AMT, 0) < 0 THEN 0
                                  ELSE NVL(YA.HIRE_INSUR_AMT, 0) 
                                END, 10, 0)  -- 고용보험료;
                        || LPAD(NVL(YA.GUAR_INSUR_AMT, 0), 10, 0)                           -- 보장보험료 ;
                        || LPAD(NVL(YA.DISABILITY_INSUR_AMT, 0), 10, 0)                     -- 장애보험료 ;
                        || LPAD(NVL(YA.MEDIC_AMT, 0), 10, 0)  -- 의료비공제금액;
                        || LPAD(NVL(YA.EDUCATION_AMT, 0), 8, 0) -- 교육비공제금액;
                        || LPAD(NVL(YA.HOUSE_INTER_AMT, 0), 8, 0) -- 주택임대차차입금원리금상환공제금액(대출자);
                        || LPAD(0, 8, 0)  -- 주택임차차입금원리금상환액(거주자).
                        || LPAD(NVL(YA.HOUSE_MONTHLY_AMT, 0), 8, 0)  -- 주택자금_월세액;
                        || LPAD(NVL(YA.LONG_HOUSE_PROF_AMT, 0), 8, 0) -- 장기주택저당차입금이자상환공제금액;
                        || LPAD(NVL(YA.LONG_HOUSE_PROF_AMT_1, 0), 8, 0) -- 장기주택저당차입금이자상환공제금액(15);
                        || LPAD(NVL(YA.LONG_HOUSE_PROF_AMT_2, 0), 8, 0) -- 장기주택저당차입금이자상환공제금액(30);
                        -- 전호수 추가 : 2012년도 연말정산 BEGIN --
                        || LPAD(NVL(YA.LONG_HOUSE_PROF_AMT_3_FIX, 0), 8, 0) -- 12년 이후 장기주택저당차입금이자상환공제금액(고정금리);
                        || LPAD(NVL(YA.LONG_HOUSE_PROF_AMT_3_ETC, 0), 8, 0) -- 12년 이후 장기주택저당차입금이자상환공제금액(기타);
                        -- 전호수 추가 : 2012년도 연말정산 END --
                        || LPAD(NVL(YA.DONAT_AMT, 0), 13, 0)  -- 기부금공제금액;
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
                                  NVL(YA.DONAT_AMT, 0), 10, 0) -- 계;
                        || LPAD(NVL(YA.STAND_DED_AMT, 0), 8, 0) -- 표준공제;
                        || LPAD(NVL(YA.SUBT_DED_AMT, 0), 11, 0) -- 차감소득금액;
                        --> 그 밖의 소득공제.
                        || LPAD(NVL(YA.PERS_ANNU_BANK_AMT, 0), 8, 0) -- 개인연금저축소득공제;
                        || LPAD(NVL(YA.ANNU_BANK_AMT, 0), 8, 0) -- 연금저축소득공제;
                        || LPAD(NVL(YA.SMALL_CORPOR_DED_AMT, 0), 10, 0) -- 소기업공제부금소득공제;
                        || LPAD(NVL(YA.HOUSE_APP_DEPOSIT_AMT, 0), 10, 0)  -- 가)주택마련저축소득공제-청약저축;
                        || LPAD(NVL(YA.HOUSE_APP_SAVE_AMT, 0), 10, 0) -- 나)주택마련저축소득공제-주택청약종합저축;
                        || LPAD(NVL(YA.HOUSE_SAVE_AMT, 0), 10, 0)  -- 다)장기주택마련저축.
                        || LPAD(NVL(YA.WORKER_HOUSE_SAVE_AMT, 0), 10, 0)  -- 라)근로자주택마련저축.
                        || LPAD(NVL(YA.INVES_AMT, 0), 10, 0) -- 투자조합출자등소득공제;
                        || LPAD(NVL(YA.CREDIT_AMT, 0), 8, 0) -- 신용카드등 소득공제;                        
                        --|| LPAD(CASE
                        --        WHEN NVL(YA.EMPL_STOCK_AMT, 0) < 0 THEN 0
                        --        ELSE 1
                        --      END, 1, 0) -- 우리사주조합소득공제(양수이면 0);
                        || LPAD(ABS(NVL(YA.EMPL_STOCK_AMT, 0)), 10, 0) -- 우리사주조합소득공제(한도 400만원);
                        || LPAD(NVL(YA.LONG_STOCK_SAVING_AMT, 0), 10, 0) -- 장기주식형저축소득공제;
                        -- 2009년 연말정산 추가 BEGIN. 고용유지중소기업근로자소득공제/공란 추가;
                        || LPAD(NVL(YA.HIRE_KEEP_EMPLOY_AMT, 0), 10, 0) -- 고용유지중소기업근로자소득공제;
                        -- 2009년 연말정산 추가 END --
                        || LPAD(0, 10, 0) -- 공란;
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
                                NVL(YA.HIRE_KEEP_EMPLOY_AMT, 0)), 10, 0) -- 그밖의 소득공제 계(양수이면 '0'수록);
                        || LPAD(NVL(YA.TAX_STD_AMT, 0), 11, 0) -- 종합소득 과세표준;
                        || LPAD(NVL(YA.COMP_TAX_AMT, 0), 10, 0) -- 산출세액;
                        --> 세액감면.
                        || LPAD(NVL(YA.TAX_REDU_IN_LAW_AMT, 0), 10, 0) --소득세법;
                        || LPAD(NVL(YA.TAX_REDU_SP_LAW_AMT, 0), 10, 0) -- 조세특례제한법;
                        -- 2012년 연말정산 추가 START --
                        || LPAD(0, 10, 0) -- 조세특례제한법 : 중소기업 취업 청년 소득세 감면;
                        -- 2012년 연말정산 추가 END --
                        || LPAD(NVL(YA.TAX_REDU_TAX_TREATY, 0), 10, 0) -- 조세조약.
                        || LPAD(0, 10, 0) -- 공란;
                        || LPAD(NVL(YA.TAX_REDU_IN_LAW_AMT, 0) +
                                NVL(YA.TAX_REDU_SP_LAW_AMT, 0) +
                                NVL(YA.TAX_REDU_TAX_TREATY, 0), 10, 0) -- 감면세액계;
                        --> 세액공제.
                        || LPAD(NVL(YA.TAX_DED_INCOME_AMT, 0), 10, 0) -- 근로소득세액공제;
                        || LPAD(NVL(YA.TAX_DED_TAXGROUP_AMT, 0), 10, 0) -- 납세조합공제;
                        || LPAD(NVL(YA.TAX_DED_HOUSE_DEBT_AMT, 0), 10, 0) -- 주택차입금;
                        || LPAD(NVL(YA.TAX_DED_DONAT_POLI_AMT, 0), 10, 0) -- 기부정치자금;
                        || LPAD(NVL(YA.TAX_DED_OUTSIDE_PAY_AMT, 0), 10, 0) -- 외국납부;
                        || LPAD(0, 10, 0) -- 공란;
                        || LPAD(NVL(YA.TAX_DED_INCOME_AMT, 0) +
                                NVL(YA.TAX_DED_TAXGROUP_AMT, 0) +
                                NVL(YA.TAX_DED_HOUSE_DEBT_AMT, 0) +
                                NVL(YA.TAX_DED_DONAT_POLI_AMT, 0) +
                                NVL(YA.TAX_DED_OUTSIDE_PAY_AMT, 0), 10, 0) -- 세액공제계;
                        --> 결정세액.
                        || LPAD(TRUNC(NVL(YA.FIX_IN_TAX_AMT, 0), 0), 10, 0) -- 소득세(원단위 절사);
                        || LPAD(TRUNC(NVL(YA.FIX_LOCAL_TAX_AMT, 0), 0), 10, 0) -- 주민세;
                        || LPAD(TRUNC(NVL(YA.FIX_SP_TAX_AMT, 0), 0), 10, 0) -- 농특세;
                        /* -- 전호수 주석 : 합계 없음.
                        || LPAD(TRUNC(NVL(YA.FIX_IN_TAX_AMT, 0), -1) +
                                TRUNC(NVL(YA.FIX_LOCAL_TAX_AMT, 0), -1) +
                                TRUNC(NVL(YA.FIX_SP_TAX_AMT, 0), -1), 10, 0) -- 결정세액 합계;*/ 
                        /* -- 종(전)납부세액 없음.
                        --> 종(전) 납부세액.
                        || LPAD(TRUNC(NVL(HEW1.IN_TAX_AMT, 0), -1), 10, 0) -- 소득세.
                        || LPAD(TRUNC(NVL(HEW1.LOCAL_TAX_AMT, 0), -1), 10, 0) -- 주민세.
                        || LPAD(TRUNC(NVL(HEW1.SP_TAX_AMT, 0), -1), 10, 0) -- 농특세;
                        || LPAD(TRUNC(NVL(HEW1.IN_TAX_AMT, 0), -1) + 
                                TRUNC(NVL(HEW1.LOCAL_TAX_AMT, 0), -1) + 
                                TRUNC(NVL(HEW1.SP_TAX_AMT, 0), -1), 10, 0) -- 종전 납부세액 합계;*/
                        -- 2009년 연말정산 수정(MODIFIED BY YOUNG MIN). "종(현) 납부세액"에서 "기납부세액 - 주(현)근무지"로 명칭 변경;
                        --> 기납부세액 - 주(현)근무지;
                        || LPAD(TRUNC(NVL(YA.PRE_IN_TAX_AMT, 0) - NVL(S_PW.IN_TAX_AMT, 0), -1), 10, 0) -- 소득세.
                        || LPAD(TRUNC(NVL(YA.PRE_LOCAL_TAX_AMT, 0) - NVL(S_PW.LOCAL_TAX_AMT, 0), -1), 10, 0) --주민세.
                        || LPAD(TRUNC(NVL(YA.PRE_SP_TAX_AMT, 0) - NVL(S_PW.SP_TAX_AMT, 0), -1), 10, 0) -- 농특세.
                        /* -- 전호수 주석 : 합계 없음.
                        || LPAD(TRUNC(NVL(YA.PRE_IN_TAX_AMT, 0) - NVL(HEW1.IN_TAX_AMT, 0), -1) +
                                TRUNC(NVL(YA.PRE_LOCAL_TAX_AMT, 0) - NVL(HEW1.LOCAL_TAX_AMT, 0), -1) +
                                TRUNC(NVL(YA.PRE_SP_TAX_AMT, 0) - NVL(HEW1.SP_TAX_AMT, 0), -1), 10, 0) -- 주(현) 납부세액 합계;*/
                        --> 차감징수세액;
                        -- 2009년 연말정산 수정(MODIFIED BY YOUNG MIN). "차감징수세액"추가(10원미만 단수절사);
                        -- 결정세액 - [주(현)근무지 기납부세액 + 종(전)근무지 기납부세액의 합];
                        || LPAD(CASE
                                  WHEN TRUNC(NVL(YA.FIX_IN_TAX_AMT, 0), -1) - TRUNC(NVL(YA.PRE_IN_TAX_AMT, 0), -1) < 0 THEN 1
                                  ELSE 0
                                END, 1, 0)  -- 0 <= 차감징수세액(소득세) < 1000 인 경우 "0"기재;
                        || LPAD(ABS(TRUNC(TRUNC(NVL(YA.FIX_IN_TAX_AMT, 0), -1) - TRUNC(NVL(YA.PRE_IN_TAX_AMT, 0), -1))), 10, 0) -- 차감소득세.
                        || LPAD(CASE
                                  WHEN (TRUNC(NVL(YA.FIX_LOCAL_TAX_AMT, 0), -1) - TRUNC(NVL(YA.PRE_LOCAL_TAX_AMT, 0), -1)) < 0 THEN 1
                                  ELSE 0
                                END, 1, 0)  -- 0 <= 차감징수세액(주민세) < 1000 인 경우 "0"기재;
                        || LPAD(ABS(TRUNC(TRUNC(NVL(YA.FIX_LOCAL_TAX_AMT, 0), -1) - TRUNC(NVL(YA.PRE_LOCAL_TAX_AMT, 0), -1))), 10, 0) -- 차감주민세.
                        || LPAD(CASE
                                  WHEN (TRUNC(NVL(YA.FIX_SP_TAX_AMT, 0), -1) - TRUNC(NVL(YA.PRE_SP_TAX_AMT, 0), -1)) < 0 THEN 1
                                  ELSE 0
                                END, 1, 0)  -- 0 <= 차감징수세액(농특세) < 1000 인 경우 "0"기재;
                        || LPAD(ABS(TRUNC(TRUNC(NVL(YA.FIX_SP_TAX_AMT, 0), -1) - TRUNC(NVL(YA.PRE_SP_TAX_AMT, 0), -1))), 10, 0)  -- 차감 농특세.
                        /*|| LPAD(CASE
                                  WHEN (TRUNC(NVL(YA.FIX_IN_TAX_AMT, 0), -1) - TRUNC(NVL(YA.PRE_IN_TAX_AMT, 0), -1) +
                                      TRUNC(NVL(YA.FIX_LOCAL_TAX_AMT, 0), -1) - TRUNC(NVL(YA.PRE_LOCAL_TAX_AMT, 0), -1) +
                                      TRUNC(NVL(YA.FIX_SP_TAX_AMT, 0), -1) - TRUNC(NVL(YA.PRE_SP_TAX_AMT, 0), -1)) < 0 THEN 1
                                  ELSE 0
                                END, 1, 0) -- 차감징수세액 계;
                        -- 전호수 주석.
                        || LPAD(ABS(TRUNC(TRUNC(NVL(YA.FIX_IN_TAX_AMT, 0), -1) - TRUNC(NVL(YA.PRE_IN_TAX_AMT, 0), -1)) +
                                   TRUNC(TRUNC(NVL(YA.FIX_LOCAL_TAX_AMT, 0), -1) - TRUNC(NVL(YA.PRE_LOCAL_TAX_AMT, 0), -1)) +
                                   TRUNC(TRUNC(NVL(YA.FIX_SP_TAX_AMT, 0), -1) - TRUNC(NVL(YA.PRE_SP_TAX_AMT, 0), -1))), 10, 0) -- 차감징수세액 계;*/
                        --> 공백.
                        || LPAD(' ', 6, ' ') AS RECORD_FILE
                        , NVL(YA.MEDIC_INSUR_AMT, 0) + NVL(YA.HIRE_INSUR_AMT, 0) AS MEDIC_INSUR_AMT  -- 'E'레코드에서 사용(국세청제공 보험료 포함 예정).
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
                        , ( -- 종전근무처 정보.
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
            --> 종(전)근무처 레코드 <--
            FOR D1 IN ( SELECT -- 자료관리번호;
                              'D' -- 레코드 구분;
                            || '20' -- 자료구분;
                            || RPAD(B1.TAX_OFFICE_CODE, 3, ' ') -- 세무서코드;
                            || LPAD(C1.C_SEQ_NO, 6, '0') -- C레코드의 일련번호.
                            -- 원천징수의무자;
                            || RPAD(B1.VAT_NUMBER, 10, ' ') -- 사업자번호.
                            || RPAD(' ', 50, ' ') -- 공란;
                            -- 소득자;
                            || RPAD(NVL(C1.REPRE_NUM, ' '), 13, ' ') -- 주민번호.
                            -- 근무처별 소득명세 - 종(전)근무처;
                            || RPAD('2',1,' ') -- 납세조합구분;
                            || RPAD(REPLACE(PW.COMPANY_NAME, ' ' , ''), 40, ' ') -- 법인명(상호);
                            || RPAD(REPLACE(PW.COMPANY_NUM, '-', ''), 10, ' ') -- 사업자등록번호;
                            -- 2009년 연말정산 수정. 근무기간/감면기간 시작/종료연월일 추가;
                            || RPAD(CASE -- 근무기간 시작연월일;
                                      WHEN PW.JOIN_DATE > TO_DATE(P_YEAR_YYYY || '-01-01', 'YYYY-MM-DD') THEN TO_CHAR(PW.JOIN_DATE, 'YYYYMMDD')
                                      ELSE P_YEAR_YYYY || '0101'
                                    END, 8, '0')
                            || RPAD(TO_CHAR(NVL(PW.RETR_DATE, C1.JOIN_DATE -1), 'YYYYMMDD'), 8, '0') -- 근무기간 종료연월일;
                            || LPAD('0', 8, '0') -- 감면기간 시작연월일;
                            || LPAD('0', 8, '0') -- 감면기간 종료연월일;
                            || LPAD(NVL(PW.PAY_TOTAL_AMT, 0), 11, 0) -- 급여총액;
                            || LPAD(NVL(PW.BONUS_TOTAL_AMT, 0), 11, 0) -- 상여총액;
                            || LPAD(NVL(PW.ADD_BONUS_AMT, 0), 11, 0) -- 인정상여;
                            || LPAD(NVL(PW.STOCK_BENE_AMT, 0), 11, 0) -- 주식매수선택권행사이익;
                            -- 2009년 연말정산 수정(MODIFIED BY YOUNG MIN). 우리사주조합인출금 추가;
                            || LPAD(0, 11, 0)  -- 우리사주조합인출금(계에는 포함하지 않았음);
                            || LPAD(0, 22, 0)  -- 공란.
                            || LPAD(NVL(PW.PAY_TOTAL_AMT, 0) +
                                    NVL(PW.BONUS_TOTAL_AMT, 0) +
                                    NVL(PW.ADD_BONUS_AMT, 0) +
                                    NVL(PW.STOCK_BENE_AMT, 0), 11, 0)  -- 계.
                            --> 종(전)근무처 비과세 소득.
                            -- 2009년 연말정산 수정(MODIFIED BY YOUNG MIN).종(전)근무처 비과세 소득 전면변경;
                            || LPAD(NVL(PW.NT_SCH_EDU_AMT, 0), 10, 0) -- 비과세-학자금;
                            || LPAD(NVL(PW.NT_MEMBER_AMT, 0), 10, 0) -- 비과세-무보수위원수당;
                            || LPAD(NVL(PW.NT_GUARD_AMT, 0), 10, 0) -- 비과세-경호/승선수당;
                            || LPAD(NVL(PW.NT_CHILD_AMT, 0), 10, 0) -- 비과세-유아/초중등_연구보조/활동비;
                            || LPAD(NVL(PW.NT_HIGH_SCH_AMT, 0), 10, 0) -- 비과세-고등교육_연구보조/활동비;
                            || LPAD(NVL(PW.NT_SPECIAL_AMT, 0), 10, 0) -- 비과세-특정연구기관육성법_연구보조/활동비;
                            || LPAD(NVL(PW.NT_RESEARCH_AMT, 0), 10, 0) -- 비과세-연구기관_연구보조/활동비;
                            || LPAD(NVL(PW.NT_COMPANY_AMT, 0), 10, 0) -- 비과세-기업연구소_연구보조/활동비;
                            -- 2012년 연말정산 추가 START --
                            || LPAD(0, 10, 0) -- 비과세-보육교사 근무환경개선비;
                            || LPAD(0, 10, 0) -- 비과세-사립유치원 수석교사/교사의 인건비;
                            -- 2012년 연말정산 추가 END --
                            || LPAD(NVL(PW.NT_COVER_AMT, 0), 10, 0) -- 비과세-취재수당;
                            || LPAD(NVL(PW.NT_WILD_AMT, 0), 10, 0) -- 비과세-벽지수당;
                            || LPAD(NVL(PW.NT_DISASTER_AMT, 0), 10, 0) -- 비과세-재해관련급여;
                            || LPAD(NVL(PW.NT_OUTSIDE_GOVER_AMT, 0), 10, 0) -- 비과세-외국정부등근무자;
                            || LPAD(NVL(PW.NT_OUTSIDE_ARMY_AMT, 0), 10, 0) -- 비과세-외국주둔군인등;
                            || LPAD(NVL(PW.NT_OUTSIDE_WORK1, 0), 10, 0) -- 비과세-국외근로(100만원);
                            || LPAD(NVL(PW.NT_OUTSIDE_WORK2, 0), 10, 0) -- 비과세-국외근로(300만원);
                            || LPAD(NVL(PW.NT_OUTSIDE_AMT, 0), 10, 0) -- 비과세 국외소득;
                            || LPAD(NVL(PW.NT_OT_AMT, 0), 10, 0) -- 비과세 야간근로;
                            || LPAD(NVL(PW.NT_BIRTH_AMT, 0), 10, 0) -- 비과세 출생/보육수당;
                            || LPAD(0, 10, 0) -- 근로장학금.
                            || LPAD(NVL(PW.NT_STOCK_BENE_AMT, 0), 10, 0) -- 비과세-주식매수선택권;
                            || LPAD(NVL(PW.NT_FOREIGNER_AMT, 0), 10, 0) -- 비과세-외국인기술자;
                            --|| LPAD(NVL(PW.NONTAX_FOREIGNER_AMT, 0), 10, 0) -- 비과세 외국인 근로자;
                            --|| LPAD(NVL(PW.NONTAX_EMPL_STOCK_AMT, 0), 10, 0) --  비과세-우리사주조합배정;
                            || LPAD(NVL(PW.NT_EMPL_STOCK_AMT, 0), 10, 0) -- 비과세-우리사주조합인출금(50%);
                            || LPAD(NVL(PW.NT_EMPL_BENE_AMT2, 0), 10, 0) -- 비과세-우리사주조합인출금(75%);
                            || LPAD(0, 10, 0)                                  -- 비과세-장기미취업자 중소기업 취업;
                            --|| LPAD(NVL(PW.NONTAX_HOUSE_SUBSIDY_AMT, 0), 10, 0) -- 비과세-주택자금보조금;
                            || LPAD(NVL(PW.NT_SEA_RESOURCE_AMT, 0), 10, 0) -- 비과세-해저광물자원개발;
                            -- 2012년 연말정산 추가 START --
                            || LPAD(0, 10, 0) -- 비과세-전공의 수련보조수당;
                            || LPAD(0, 10, 0) -- 비과세-중소기업 취업청년 소득세 감면;
                            || LPAD(0, 10, 0) -- 비과세-조세조약상 교직자 감면;
                            -- 2012년 연말정산 추가 END --
                            --|| LPAD(0, 10, 0)  -- 지정비과세;
                            --|| LPAD(NVL(PW.NONTAX_ETC_AMT, 0), 10, 0) --AS NONTAX_ETC_AMT     -- 비과세 기타;
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
                                    --NVL(PW.NONTAX_FOR_ENG_AMT, 0) +                           -- 감면소득 계로 이동;
                                    --NVL(PW.NONTAX_FOREIGNER_AMT, 0) +
                                    --NVL(PW.NONTAX_EMPL_STOCK_AMT, 0) +
                                    NVL(PW.NT_EMPL_BENE_AMT1, 0) +
                                    NVL(PW.NT_EMPL_BENE_AMT2, 0),
                                    --NVL(PW.NONTAX_HOUSE_SUBSIDY_AMT, 0) +
                                    --NVL(PW.NONTAX_SEA_RESOURCE_AMT, 0) +                      -- 감면소득 계로 이동;
                                    --NVL(PW.NONTAX_ETC_AMT, 0),
                                    10, 0)  -- 비과세 계;
                            || LPAD(NVL(PW.NT_FOREIGNER_AMT, 0) +
                                    NVL(PW.NT_SEA_RESOURCE_AMT, 0), 10, 0)  -- 감면소득 계;
                            -- 기납부세액 - 종(전)근무지;
                            || LPAD(NVL(PW.IN_TAX_AMT, 0), 10, 0)
                            || LPAD(NVL(PW.LOCAL_TAX_AMT, 0), 10, 0)
                            || LPAD(NVL(PW.SP_TAX_AMT, 0), 10, 0)
                            /*-- 전호수 주석 : 2011년 없어짐.
                            || LPAD(NVL(PW.IN_TAX_AMT, 0) +
                                    NVL(PW.LOCAL_TAX_AMT, 0) +
                                    NVL(PW.SP_TAX_AMT, 0), 10, 0)*/
                            -- || LPAD(NVL(PW.PAY_TOTAL_AMT, 0) + NVL(PW.BONUS_TOTAL_AMT, 0) + NVL(PW.ADD_BONUS_AMT, 0) + NVL(PW.STOCK_BENE_AMT, 0),11, 0) --AS PAY_SUM_AMT                       -- 계;
                            || LPAD(ROW_NUMBER() OVER(PARTITION BY PW.PERSON_ID ORDER BY PW.SEQ_NUM), 2, 0) -- 종(전)근무처 일련번호;
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
--E1 부양가족 명세 ----------------------------------------------------------------------------
-- 외국인 단일세율이 아닐경우만 적용.
          IF C1.FOREIGN_TAX_YN = 'N' THEN
            V_RECORD_FILE := NULL;
            V_SEQ_NO    := 0;
            V_RECORD_COUNT := 0;
            FOR E1 IN ( SELECT 
                              'E' --AS RECORD_TYPE
                            || '20' --AS DATA_TYPE
                            || RPAD(NVL(B1.TAX_OFFICE_CODE, ' '), 3, ' ') -- 세무서코드.
                            || LPAD(NVL(C1.C_SEQ_NO, 0), 6, 0)  -- C레코드의 일련번호.
                            || RPAD(NVL(B1.VAT_NUMBER, ' '), 10, ' ') -- 사업자번호.
                            || RPAD(NVL(C1.REPRE_NUM, ' '), 13, ' ') AS RECORD_HEADER -- 주민번호.
                            --> 소득공제명세 인적사항.
                            , RPAD(NVL(SF.RELATION_CODE, ' '), 1, ' ') -- 관계;
                            || RPAD(CASE
                                      WHEN SUBSTR(REPLACE(SF.REPRE_NUM, '-', ''), 7, 1) BETWEEN '5' AND '8' THEN '9'
                                      ELSE '1'
                                    END, 1, ' ') -- 내/외국인 구분 코드;
                            || RPAD(NVL(SF.FAMILY_NAME, ' '), 20, ' ') -- 성명;
                            || RPAD(NVL(REPLACE(SF.REPRE_NUM, '-', ''), ' ') , 13, ' ') -- 주민번호;
                            || DECODE(SF.BASE_YN, 'Y', '1', ' ') -- 기본공제;
                            || CASE 
                                 WHEN SF.BASE_YN = 'Y' AND SF.DISABILITY_YN = 'Y' THEN '1'
                                 ELSE ' '
                               END  -- 장애인공제;
                            || DECODE(SF.CHILD_YN, 'Y', '1', ' ') -- 자녀양육비공제;
                            || DECODE(SF.WOMAN_YN, 'Y', '1', ' ') -- 부녀자공제;
                            -- 2009년 연말정산 수정(MODIFIED BY YOUNG MIN).경로우대 만70세이상으로 변경;
                            || CASE
                                 --WHEN SF.OLD_YN = 'Y' THEN '1'
                                 WHEN SF.OLD1_YN = 'Y' THEN '1'
                                 ELSE ' '
                               END -- 경로우대공제;
                            -- 2009년 연말정산 수정(MODIFIED BY YOUNG MIN).출산입양자공제추가;
                            || DECODE(SF.BIRTH_YN, 'Y', '1', ' ') -- 출산입양자공제.
                            /*-- 2009년 연말정산 수정(MODIFIED BY YOUNG MIN).다자녀추가공제 폐지;
                            || CASE
                                 WHEN SF.BASE_YN = 'Y' AND C1.MANY_CHILD_DED_AMT <> 0 AND SF.RELATION_CODE = '4' THEN '1'
                                 ELSE ' '
                               END -- 다자녀추가공제;*/
                            --> 국세청 자료.
                            -- 2009년 연말정산 수정(MODIFIED BY YOUNG MIN).국세청자료 공제금액이 음수일 경우 0으로 표기;
                            || LPAD((CASE
                                       WHEN DECODE(SF.RELATION_CODE, 0, NVL(C1.MEDIC_INSUR_AMT, 0), 0) + 
                                            NVL(SF.INSURE_AMT, 0) + NVL(SF.DISABILITY_INSURE_AMT, 0) < 0 THEN 0
                                       ELSE DECODE(SF.RELATION_CODE, 0, NVL(C1.MEDIC_INSUR_AMT, 0), 0) + 
                                            NVL(SF.INSURE_AMT, 0) + NVL(SF.DISABILITY_INSURE_AMT, 0)
                                     END), 10, 0) -- 보험료(본인은 건강보험료 포함);
                            || LPAD(NVL(SF.MEDICAL_AMT, 0), 10, 0) --  의료비;
                            || LPAD(NVL(SF.EDUCATION_AMT, 0), 10, 0) -- 교육비;
                            || LPAD(NVL(SF.CREDIT_AMT, 0), 10, 0) -- 신용카드등;
                            || LPAD(NVL(SF.CHECK_CREDIT_AMT , 0), 10, 0) -- 직불카드;
                            || LPAD(NVL(SF.CASH_AMT, 0) + NVL(SF.ACADE_GIRO_AMT, 0), 10, 0) -- 현금영수증;
                            --2012년 연말정산 추가 START --
                            || LPAD(NVL(SF.TRAD_MARKET_AMT, 0), 10, 0) -- 전통시장사용액;
                            --2012년 연말정산 추가 END --
                            || LPAD(NVL(SF.DONAT_ALL, 0) +
                                    NVL(SF.DONAT_50P, 0) +
                                    NVL(SF.DONAT_30P, 0) +
                                    NVL(SF.DONAT_10P, 0) +
                                    NVL(SF.DONAT_10P_RELIGION, 0), 13, 0)  -- 기부금.
                            -->국세청자료 이외.
                            || LPAD(NVL(SF.ETC_INSURE_AMT, 0), 10, 0) -- 국세청제공외의 보험료;
                            || LPAD(NVL(SF.ETC_MEDICAL_AMT, 0), 10, 0) -- 국세청제공외의 의료비;
                            || LPAD(NVL(SF.ETC_EDUCATION_AMT, 0), 10, 0) -- 국세청제공외의 교육비;
                            || LPAD(NVL(SF.ETC_CREDIT_AMT, 0) + NVL(SF.ETC_ACADE_GIRO_AMT, 0), 10, 0) -- 국세청제공외의 신용카드;
                            || LPAD(NVL(SF.ETC_CHECK_CREDIT_AMT, 0), 10, 0) -- 국세청제공외의 직불카드;
                            --2012년 연말정산 추가 START --
                            || LPAD(NVL(SF.ACADE_GIRO_AMT, 0) + NVL(SF.ETC_ACADE_GIRO_AMT, 0), 10, 0) -- 학원비 지로납부액;
                            || LPAD(NVL(SF.ETC_TRAD_MARKET_AMT, 0), 10, 0) -- 전통시장사용액;
                            --2012년 연말정산 추가 END --
                            || LPAD(NVL(SF.ETC_DONAT_ALL, 0) +
                                    NVL(SF.ETC_DONAT_50P, 0) +
                                    NVL(SF.ETC_DONAT_30P, 0) +
                                    NVL(SF.ETC_DONAT_10P, 0) +
                                    NVL(SF.ETC_DONAT_10P_RELIGION, 0), 13, 0) AS RECORD_LINE -- 국세청제공외의 기부금;
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
              --> 부양가족수 5인 이상일 경우.
              IF V_E_REC_STD <= V_RECORD_COUNT THEN
                V_SEQ_NO := NVL(V_SEQ_NO, 0) + 1;  -- 부양가족 생성 일련번호.
                V_RECORD_FILE := V_RECORD_FILE 
                                 || LPAD(NVL(V_SEQ_NO, 1), 2, 0)  -- 일련번호.
                                 || RPAD(' ', 258, ' ');  -- 공란.
                
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
                V_RECORD_FILE := V_RECORD_FILE || RPAD(' ', 207, ' ');  -- 소득공제 명세서 부양가족 길이.
              END LOOP E1S;
              IF V_RECORD_FILE IS NOT NULL THEN
                V_SEQ_NO := NVL(V_SEQ_NO, 0) + 1;  -- 부양가족 생성 일련번호.
                V_RECORD_FILE := V_RECORD_FILE 
                                 || LPAD(NVL(V_SEQ_NO, 1), 2, 0)  -- 일련번호.
                                 || RPAD(' ', 258, ' ');  -- 공란.
                                 
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

--F1 연금/저축등 소득공제 명세 레코드 -----------------------------------------------------------------
            V_RECORD_FILE := NULL;
            V_SEQ_NO    := 0;
            V_RECORD_COUNT := 0;
            FOR F1 IN ( SELECT 'F' --AS RECORD_TYPE
                            || '20' --AS DATA_TYPE
                            || RPAD(NVL(B1.TAX_OFFICE_CODE, ' '), 3, ' ') -- 세무서코드.
                            || LPAD(C1.C_SEQ_NO, 6, 0) -- C레코드의 일련번호.
                            || RPAD(NVL(B1.VAT_NUMBER, ' '), 10, ' ') -- 사업자번호.
                            || RPAD(NVL(C1.REPRE_NUM, ' '), 13, ' ') AS RECORD_HEADER -- 주민번호.
                            , LPAD(NVL(SI.SAVING_TYPE, ' '), 2, '0')  -- 소득공제구분;
                            || RPAD(SI.BANK_CODE, 3, ' ') -- 금융기관 코드수록;
                            || RPAD(YB.YEAR_BANK_NAME, 30, ' ') -- 금융기관 상호수록;
                            || RPAD(SI.ACCOUNT_NUM, 20, ' ') -- 계좌번호;
                            || LPAD(DECODE(SI.SAVING_TYPE, '41', CASE WHEN 3 < SI.SAVING_COUNT THEN 3 ELSE SI.SAVING_COUNT END , '0'), 2, 0) -- 납입연차-장기주식형저축만 해당;
                            || LPAD(SI.SAVING_AMOUNT, 10, 0) -- 불입금액;
                            || LPAD(SI.SAVING_DED_AMOUNT, 10, 0) AS RECORD_LINE               -- 공제금액;
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
              --> 연금저축등 명세서 15개 이상일 경우.
              IF V_F_REC_STD <= V_RECORD_COUNT THEN
                V_SEQ_NO := NVL(V_SEQ_NO, 0) + 1;  -- 연금저축 생성 일련번호.
                V_RECORD_FILE := V_RECORD_FILE || RPAD(' ', 70, ' ');  -- 공란.
                
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
                V_SEQ_NO := NVL(V_SEQ_NO, 0) + 1;  -- 부양가족 생성 일련번호.
                V_RECORD_FILE := V_RECORD_FILE || RPAD(' ', 140, ' ');  -- 연금저축  소득공제명세 순수 길이 => 공란.
                
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
          END IF;  -- 외국인 단일세율 적용 안할경우만 적용.
          END LOOP C1;    
        END LOOP B1;
    END LOOP A1;
    
  END SET_YEAR_ADJUST_FILE_2012;

-------------------------------------------------------------------------------
-- 2012년도 의료비 파일생성.
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
      RAISE_APPLICATION_ERROR(-20001, 'Error - 사업장 정보를 찾을수 없습니다. 확인하세요');
      RETURN;
    END;
    FOR A1 IN ( SELECT 'A'   -- 자료관리번호.
                    || '26'  -- 26;
                    || LPAD(REPLACE(V_TAX_OFFICE_CODE, '-', ''), 3, 0)  -- 세무서 코드;
                    || LPAD(ROWNUM, 6, 0)  -- 일련번호.
                    || RPAD(TO_CHAR(P_WRITE_DATE, 'YYYYMMDD'), 8, 0) -- 자료를 세무서에 제출하는 연월일;
                    --> 제출자;
/*                    || LPAD(NVL(P_SUBMIT_AGENT, '2'), 1, 0)  -- 제출자구분(세무대리인1, 법인2, 개인3);
                    || RPAD(NVL(P_TAX_PROGRAM_CODE, ' '), 6, ' ')  -- 세무대리인 관리번호(자료제출자가 세무대리인인경우 수록);
*/                    || RPAD(NVL(REPLACE(V_VAT_NUMBER, '-', ''), ' '), 10, ' ')  -- 사업자등록번호;
                    || RPAD(NVL(P_HOMETAX_LOGIN_ID, ' '), 20, ' ')  -- 홈택스ID;
                    || RPAD(NVL(P_TAX_PROGRAM_CODE, '1001'), 4, ' ')  -- 세무프로그램코드;                    
                    || RPAD(NVL(REPLACE(V_VAT_NUMBER, '-', ''), ' '), 10, ' ')  -- 사업자등록번호;
                    || RPAD(NVL(REPLACE(V_CORP_NAME, ' ', ''), ' '), 40, ' ')  -- 법인명(상호);
                    || RPAD(NVL(REPLACE(PM.REPRE_NUM, '-', '') ,' '), 13, ' ')  -- 소득자주민번호.
                    || RPAD(NVL(PM.NATIONALITY_TYPE, ' '), 1, 0)  -- 내외국인구분.
                    || RPAD(NVL(REPLACE(PM.NAME, ' ', ''), ' '), 30, ' ') --소득자의 성명;
                    || LPAD(NVL(REPLACE(MI.CORP_TAX_REG_NO, '-', ''), ' '), 10, ' ') --AS 지급처의 사업자등록번호;
                    || RPAD(NVL(REPLACE(MI.CORP_NAME, ' ' , ''), ' '), 40, ' ') -- 지급처 상호;
                    || RPAD(NVL(MI.EVIDENCE_CODE, ' '), 1, ' ')  -- 의료증빙코드;
                    || LPAD(NVL(MI.CREDIT_COUNT, 0) + NVL(MI.ETC_COUNT, 0), 5, 0) -- 건수;
                    || LPAD(NVL(MI.CREDIT_AMT, 0) + NVL(MI.ETC_AMT, 0), 11, 0) --  지급금액;
                    || LPAD(REPLACE(MI.REPRE_NUM, '-', ''), 13, ' ') -- 의료비 지급 대상자의 주민등록번호;
                    || RPAD(CASE
                              WHEN SUBSTR(REPLACE(MI.REPRE_NUM, '-', ''), 7, 1) BETWEEN '5' AND '8' THEN '9'
                              ELSE '1'
                            END, 1, 0) -- 의료비 지급 대상자의 내/외국인 코드;
                    || RPAD(CASE
                              WHEN MI.RELATION_CODE = '0' OR 'Y' IN(MI.DISABILITY_YN, MI.OLD_YN) THEN '1'
                              ELSE '2'
                            END, 1, 0) -- 본인등 해당여부;
                    || RPAD(P_SUBMIT_PERIOD, 1, 0) -- (연간합산 : 1, 휴/폐업에 의한 수시제출 : 2, 수시 분할제출 : 3);
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
-- 2012년도 기부금 파일생성.
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
    FOR A1 IN ( SELECT 'A'   -- 자료관리번호.
                    || '27'  -- 27;
                    || LPAD(NVL(OU.TAX_OFFICE_CODE, ' '), 3, 0)  -- 세무서 코드;
                    || TO_CHAR(P_WRITE_DATE, 'YYYYMMDD')  -- 자료를 세무서에 제출하는 연월일;
                    --> 제출자;
                    || LPAD(NVL(P_SUBMIT_AGENT, '2'), 1, 0)  -- 제출자구분(세무대리인1, 법인2, 개인3);
                    || RPAD(NVL(P_TAX_AGENT, ' '), 6, ' ')  -- 세무대리인 관리번호(자료제출자가 세무대리인인경우 수록);
                    || RPAD(NVL(P_HOMETAX_LOGIN_ID, ' '), 20, ' ')  -- 홈택스ID;
                    || RPAD(NVL(P_TAX_PROGRAM_CODE, '9000'), 4, ' ')  -- 세무프로그램코드;
                    || RPAD(NVL(REPLACE(OU.VAT_NUMBER, '-', ''), ' '), 10, ' ')  -- 사업자등록번호;
                    || RPAD(NVL(CM.CORP_NAME, ' '), 40, ' ')  -- 법인명(상호);
                    || RPAD(NVL(S_PM.DEPT_NAME, ' '), 30, ' ')  -- 담당자(제출자) 부서;
                    || RPAD(NVL(S_PM.NAME, ' '), 30, ' ')  -- 담당자(제출자) 성명;
                    || RPAD(NVL(REPLACE(CM.TEL_NUMBER, '-', ''), ' '), 15, ' ')  -- 담당자(제출자) 전화번호;
                    --> 제출내역.
                    || LPAD(1, 5, 0)  -- 신고의무자수 (B레코드);
                    || LPAD(NVL(P_USE_LANGUAGE_CODE, '101'), 3, 0)  -- 사용한글코드;
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
      FOR B1 IN ( -- 기부금 지급명세서.
                  SELECT 'B' --AS RECORD_TYPE   -- 자료관리번호(레코드 구분);
                      || '27' --AS DATA_TYPE     -- 자료구분(명세서 27);
                      || RPAD(A1.TAX_OFFICE_CODE, 3, 0) -- 세무서코드;
                      || LPAD(ROWNUM, 6, 0) -- 일련번호;
                      -- 원천징수의무자;
                      || RPAD(A1.VAT_NUMBER, 10, ' ') -- 사업자등록번호;
                      || RPAD(A1.CORP_NAME, 40, ' ') -- 상호명;
                      -- 제출내역;
                      || LPAD(NVL(SX1.DONA_ADJUST_COUNT, 0), 7, 0) -- 기부금조정명세레코드수;
                      || LPAD(NVL(SX1.THIS_YEAR_COUNT, 0), 7, 0) -- 해당년도 기부금조정명세레코드수;
                      || LPAD(NVL(SX1.TOTAL_DONA_AMT, 0), 13, 0)  -- 기부금액 총액.
                      || LPAD(NVL(SX1.TOTAL_DONA_DED_AMT, 0), 13, 0)  -- 공제대상금액총액;
                      || LPAD(NVL(P_SUBMIT_PERIOD, '1'), 1, 0) -- (연간합산 : 1, 휴/폐업에 의한 수시제출 : 2, 수시 분할제출 : 3);
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
          FOR C2 IN ( -- 기부금 조정명세서.
                      SELECT 'C' -- 자료관리번호(레코드 구분);
                          || '27' -- 자료구분(명세서 27);
                          || LPAD(A1.TAX_OFFICE_CODE, 3, 0) -- 세무서코드;
                          || LPAD(C1.SEQ_NO, 6, 0)   -- 일련번호.
                              -- 일련번호;
  /*                              || LPAD(ROWNUM, 6, 0) --AS SEQ_NO    -- 일련번호;*/
                          || RPAD(A1.VAT_NUMBER, 10, ' ') -- 사업자등록번호;
                          || RPAD(REPLACE(PM.REPRE_NUM, '-', ''), 13, ' ') -- 소득자의 주민등록번호;
                          || RPAD(CASE
                                    WHEN SUBSTR(REPLACE(PM.REPRE_NUM, '-', ''), 7, 1) BETWEEN '5' AND '8' THEN '9'
                                    ELSE '1'
                                  END, 1, 0) -- 내외국인 구분코드;
                          || RPAD(PM.NAME, 30, ' ') -- 소득자의 성명;
                          || RPAD(NVL(DA.DONA_TYPE, ' '), 2, ' ') -- 기부코드;
                          || LPAD(DA.DONA_YYYY, 4, 0)           -- 기부년도;
                          || LPAD(NVL(DA.DONA_AMT, 0), 13, 0) -- 기부금액(기부자,기부처별,유형별 합산);
                          || LPAD(NVL(DA.PRE_DONA_DED_AMT, 0), 13, 0) -- 전년까지 공제된 금액;
                          || LPAD(NVL(DA.TOTAL_DONA_AMT, 0), 13, 0) -- 공제대상금액;
                          || LPAD(NVL(DA.DONA_DED_AMT, 0), 13, 0)    -- 해당년도 공제금액;
                          || LPAD(NVL(DA.LAPSE_DONA_AMT, 0), 13, 0)    -- 해당년도 소멸금액;
                          || LPAD(NVL(DA.NEXT_DONA_AMT, 0), 13, 0)    -- 해당년도 이월금액;
                          || LPAD(ROW_NUMBER() OVER(PARTITION BY PM.PERSON_NUM ORDER BY PM.PERSON_NUM, DA.YEAR_YYYY), 5, 0)         -- 기부금조정명세 일련번호;
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
          FOR D1 IN ( -- 기부금 명세서.
                      SELECT 'D' -- 자료관리번호(레코드 구분);
                          || '27' -- 자료구분(명세서 27);
                          || LPAD(A1.TAX_OFFICE_CODE, 3, 0) -- 세무서코드;
                          || LPAD(C1.SEQ_NO, 6, 0)    -- 일련번호;
                          || RPAD(A1.VAT_NUMBER, 10, ' ') -- 사업자등록번호;
                          || RPAD(REPLACE(PM.REPRE_NUM, '-', ''), 13, ' ') -- 소득자의 주민등록번호;
                          || RPAD(NVL(DI.DONA_TYPE, ' '), 2, ' ') -- 기부코드;
                          || RPAD(NVL(REPLACE(DI.CORP_TAX_REG_NO, '-', ''), ' '), 13, ' ') -- 기부처 사업등록번호;
                          || RPAD(NVL(DI.CORP_NAME, ' '), 30, ' ') -- 기부처 상호;
                          || RPAD(NVL(CASE 
                                        WHEN DI.RELATION_CODE = '0' THEN '1'
                                        WHEN DI.RELATION_CODE = '3' THEN '2'
                                        WHEN DI.RELATION_CODE IN('4', '5') THEN '3'
                                        WHEN DI.RELATION_CODE IN('1', '2') THEN '4'
                                        WHEN DI.RELATION_CODE IN('6') THEN '5'
                                        ELSE '6'
                                      END, ' '), 1, ' ') -- 기부자와의 관계;
                          || RPAD(CASE
                                    WHEN SUBSTR(REPLACE(DI.REPRE_NUM, '-', ''), 7, 1) BETWEEN '5' AND '8' THEN '9'
                                    ELSE '1'
                                  END, 1, ' ') --  내/외국인 코드;
                          || RPAD(NVL(DI.FAMILY_NAME, ' '), 20, ' ') -- 성명;
                          || RPAD(NVL(REPLACE(DI.REPRE_NUM, '-', ''), ' '), 13, ' ') -- 기부자 주민등록번호;
                          || LPAD(NVL(DI.DONA_COUNT, 0), 5, 0) --기부횟수(기부자,기부처별,유형별 합산);
                          || LPAD(NVL(DI.DONA_AMT, 0), 13, 0) -- 기부금(기부자,기부처별,유형별 합산);/*|| LPAD(I_YEAR_YYYY || '0101', 8, 0) --AS TAX_PERIOD_START
                          || LPAD(ROW_NUMBER() OVER(PARTITION BY PM.PERSON_NUM ORDER BY PM.PERSON_NUM), 5, 0)
                          --|| LPAD(C1.SORT_NUM, 5, 0)         -- 기부금조정명세 일련번호;
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
-- 2013년도 근로소득 파일생성.
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
  --> 주(현) 업체 정보 변수.
    V_SEQ_NUM                   NUMBER := 0;
    V_SOURCE_FILE               VARCHAR2(150);
    V_RECORD_COUNT              NUMBER := 0;
    V_E_REC_STD                 CONSTANT NUMBER := 5;
    V_F_REC_STD                 CONSTANT NUMBER := 15;
    V_G_REC_STD                 CONSTANT NUMBER := 3;    
    V_SEQ_NO                    NUMBER;          -- 레코드 생성 번호.
    V_RECORD_FILE               VARCHAR2(3000);  -- 부양가족 조합위해.
    
    V_REC_TEMP_1                VARCHAR2(300);   
    V_REC_TEMP_2                VARCHAR2(300);   
  BEGIN
    
    -- 전산매체 생성--.
--A1 ------------------------------------------------------------------------------------
    FOR A1 IN ( SELECT 'A'   -- 자료관리번호.
                    || '20'  -- 갑종근로소득(20);
                    || LPAD(REPLACE(OU.TAX_OFFICE_CODE, '-', ''), 3, 0)  -- 세무서 코드;
                    || TO_CHAR(P_WRITE_DATE, 'YYYYMMDD')  -- 자료를 세무서에 제출하는 연월일;
                    --> 제출자;
                    || LPAD(NVL(P_SUBMIT_AGENT, '2'), 1, 0)  -- 제출자구분(세무대리인1, 법인2, 개인3);
                    || RPAD(NVL(P_TAX_AGENT, ' '), 6, ' ')  -- 세무대리인 관리번호(자료제출자가 세무대리인인경우 수록);
                    || RPAD(NVL(P_HOMETAX_LOGIN_ID, ' '), 20, ' ')  -- 홈택스ID;
                    || RPAD(NVL(P_TAX_PROGRAM_CODE, '1001'), 4, ' ')  -- 세무프로그램코드;
                    || RPAD(NVL(REPLACE(OU.VAT_NUMBER, '-', ''), ' '), 10, ' ')  -- 사업자등록번호;
                    || RPAD(NVL(REPLACE(CM.CORP_NAME, ' ', ''), ' '), 40, ' ')  -- 법인명(상호);
                    || RPAD(NVL(REPLACE(S_PM.DEPT_NAME, ' ', ''), ' '), 30, ' ')  -- 담당자(제출자) 부서;
                    || RPAD(NVL(REPLACE(S_PM.NAME, ' ', ''), ' '), 30, ' ')  -- 담당자(제출자) 성명;
                    || RPAD(NVL(REPLACE(CM.TEL_NUMBER, '-', ''), ' '), 15, ' ')  -- 담당자(제출자) 전화번호;
                    --> 제출내역.
                    || LPAD(1, 5, 0)  -- 신고의무자수 (B레코드);
                    || LPAD(NVL(P_USE_LANGUAGE_CODE, '101'), 3, 0)  -- 사용한글코드;
                    || RPAD(' ', 1222, ' ') AS RECORD_FILE
                    , CM.CORP_NAME  -- 법인명.
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
                      || '20'  -- 갑종근로소득(20);
                      || LPAD(REPLACE(OU.TAX_OFFICE_CODE, '-', ''), 3, 0)   -- 세무서코드; 
                      || LPAD(1, 6, 0)                                      -- B레코드의 일련번호;
                      --> 제출자;
                      || RPAD(NVL(REPLACE(OU.VAT_NUMBER, '-', ''), ' '), 10, ' ')  -- 원천징수의무자의 사업자등록번호;
                      || RPAD(NVL(REPLACE(CM.CORP_NAME, ' ', ''), ' '), 40, ' ')  -- 법인명(상호);
                      || RPAD(NVL(REPLACE(CM.PRESIDENT_NAME, ' ', ''), ' '), 30, ' ')  -- 대표자 성명;
                      || RPAD(NVL(REPLACE(CM.LEGAL_NUMBER, '-', ''), ' '), 13, ' ') -- 법인등록번호;
                      --> 제출내역;
                      || LPAD(NVL(S_YA.NOW_WORKER_COUNT, 0), 7, 0)   -- 9.수록한 C레코드의 수(근로소득자의 수);
                      || LPAD(NVL(S_YA.PRE_WORKER_COUNT, 0), 7, 0)   -- 10.수록한 D레코드(전근무처)의 수(C레코드 항목6의 합계)
                      || LPAD(NVL(S_YA.INCOME_TOT_AMT, 0), 14, 0)    -- 11.총급여 총계(C레코드 급여 합);
                      || LPAD(NVL(S_YA.FIX_IN_TAX, 0), 13, 0)        -- 소득세 결정세액 총계(C레코드 소득세의 합);
                      || LPAD(NVL(S_YA.FIX_LOCAL_TAX, 0), 13, 0)     -- 주민세 결정세액 총계;
                      || LPAD(NVL(S_YA.FIX_SP_TAX, 0), 13, 0)        -- 농특세 결정세액 총계;
                      || LPAD(NVL(S_YA.FIX_TOTAL_TAX, 0) - NVL(S_YA.FIX_LEGAL_TAX, 0), 13, 0)  -- 결정세액 총계;
                      -- LPAD(NVL(S_YA.FIX_TOTAL_TAX, 0), 13, 0)  -- 결정세액 총계 : 2009년 연말정산 수정 결정세액총계-법인세 결정세액 총계;
                      || LPAD(NVL(P_SUBMIT_PERIOD, '1'), 1, 0)   -- (연간합산 : 1, 휴/폐업에 의한 수시제출 : 2, 수시 분할제출 : 3);
                      || RPAD(' ', 1214, ' ') AS RECORD_FILE
                      , LPAD(REPLACE(OU.TAX_OFFICE_CODE, '-', ''), 3, 0) AS TAX_OFFICE_CODE
                      , RPAD(NVL(REPLACE(OU.VAT_NUMBER, '-', ''), ' '), 10, ' ') AS VAT_NUMBER
                    FROM HRM_CORP_MASTER CM
                       , HRM_OPERATING_UNIT OU
                       , ( -- 제출내역.
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
                                             -- 비과세 
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
                                             -- 종전-- 
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
                               , ( -- 종전근무지 자료수.
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
                          'C'                                           -- 1.자료관리번호.
                        || '20'                                         -- 2.AS DATA_TYPE
                        || RPAD(NVL(B1.TAX_OFFICE_CODE, ' '), 3, ' ')   -- 3.세무서코드.
                        || LPAD(ROW_NUMBER() OVER(PARTITION BY YA.YEAR_YYYY ORDER BY PM.PERSON_NUM), 6, 0)   -- 4.일련번호.
                        || LPAD(NVL(B1.VAT_NUMBER, ' '), 10, ' ')       -- 5.사업자번호.
                        || LPAD(NVL(S_PW.PRE_WORK_COUNT, 0), 2, 0)      -- 6.종(전)근무처 수;
                        || LPAD(NVL(PM.RESIDENT_TYPE, '1'), 1, 0)       -- 7.거주자 구분코드(거주자:1, 비거주자:2);
                        || RPAD(CASE 
                                  WHEN PM.RESIDENT_TYPE = '1' THEN ' '
                                  WHEN SUBSTR(REPLACE(PM.REPRE_NUM, '-', ''), 7, 1) BETWEEN '1' AND '4' THEN ' '  -- 1900, 2000년생.
                                  WHEN SUBSTR(REPLACE(PM.REPRE_NUM, '-', ''), 7, 1) BETWEEN '9' AND '0' THEN ' '  -- 1800년대생..
                                  ELSE NVL(S_HN.ISO_NATION_CODE, ' ')
                                END, 2, ' ')  -- 8.거구지국 코드 : 비거주자만 기록, 거주자는 공란;
                        || LPAD(DECODE(NVL(YA.FOREIGN_FIX_TAX_YN, 'N'), 'Y', 1, 2), 1, 0)  -- 9.외국인단일세율적용(적용:1, 비적용:2);
                        || RPAD(NVL(REPLACE(PM.NAME, ' ', ''), ' '), 30, ' ')  -- 10.성명;
                        || RPAD(CASE
                                  WHEN PM.NATIONALITY_TYPE IS NOT NULL THEN PM.NATIONALITY_TYPE
                                  WHEN SUBSTR(REPLACE(PM.REPRE_NUM, '-', ''), 7, 1) BETWEEN '5' AND '8' THEN '9'
                                  ELSE '1'
                                END, 1, 0)  -- 11.내/외국인 구분코드;
                        || RPAD(NVL(REPLACE(PM.REPRE_NUM, '-', ''), ' '), 13, ' ')  -- 12.주민등록번호;
                        || RPAD(CASE
                                  WHEN PM.NATIONALITY_TYPE = '9' THEN NVL(S_HN.ISO_NATION_CODE, ' ')
                                  WHEN SUBSTR(REPLACE(PM.REPRE_NUM, '-', ''), 7, 1) BETWEEN '5' AND '8' THEN NVL(S_HN.ISO_NATION_CODE, ' ')
                                  ELSE ' '
                                END, 2, ' ')  -- 13.국적코드(외국인인 경우만 기재);
                        || RPAD(NVL(PM.HOUSEHOLD_TYPE, '1'), 1, 0)  -- 14.세대주여부.
                        || RPAD(CASE 
                                  WHEN (PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE > TO_DATE(P_YEAR_YYYY||'-12-31','YYYY-MM-DD')) THEN '1'
                                  ELSE '2' 
                                END, 1, 0)  -- 15.연말정산구분(계속근로: 1, 중도퇴사:2).
                        || RPAD(NVL(B1.VAT_NUMBER, ' '), 10, ' ')  -- 16.주현근무처 사업자등록번호;
                        || RPAD(NVL(A1.CORP_NAME, ' '), 40, ' ')  -- 17.주현근무처 법인명(상호);
                        || RPAD(TO_CHAR(YA.ADJUST_DATE_FR, 'YYYYMMDD'), 8, 0)  -- 18.근무기간 시작연월일;
                        || RPAD(TO_CHAR(YA.ADJUST_DATE_TO, 'YYYYMMDD'), 8, 0)  -- 19.근무기간 종료연월일;
                        || LPAD(0, 8, 0)  -- 20.감면기간 시작연월일;
                        || LPAD(0, 8, 0)  -- 21.감면기간 종료연월일;
                        --> 근무처별 소득명세-주(현)근무처 총급여.
                        || LPAD(NVL(YA.NOW_PAY_TOT_AMT, 0)+ 
                                NVL(YA.INCOME_OUTSIDE_AMT, 0), 11, 0)  -- 22.급여총액;
                        || LPAD(NVL(YA.NOW_BONUS_TOT_AMT, 0), 11, 0) -- 23.상여총액;
                        || LPAD(NVL(YA.NOW_ADD_BONUS_AMT, 0), 11, 0) -- 24.인정상여;
                        || LPAD(NVL(YA.NOW_STOCK_BENE_AMT, 0), 11, 0) -- 25.주식매수선택권행사이익;
                        ----> 2009년 연말정산 수정(우리사주조합인출금 추가);
                        || LPAD(0, 11, 0) -- 26.우리사주조합인출금(계에는 포함하지 않았음);
                        || LPAD(NVL(YA.NOW_OFFICE_RETIRE_OVER_AMT, 0), 11, 0)  -- 27.2013년도 추가 : 임원 퇴직소득금액 한도초과액  
                        || LPAD(0, 22, 0) -- 28.공란;
                        || LPAD(NVL(YA.NOW_PAY_TOT_AMT, 0) +
                                NVL(YA.NOW_BONUS_TOT_AMT, 0) +
                                NVL(YA.NOW_ADD_BONUS_AMT, 0) +
                                NVL(YA.NOW_STOCK_BENE_AMT, 0) + 
                                NVL(YA.INCOME_OUTSIDE_AMT, 0) +
                                NVL(YA.NOW_OFFICE_RETIRE_OVER_AMT, 0), 11, 0) -- 29.급여총액(항목22)+상여총액(항목23)+인정상여(항목24)+ 주식매수선택권행사이익(항목25)+우리사주조합인출금(항목26)+ 임원퇴직소득한도초과액(항목27)
                        --> 주(현)근무처 비과세 소득.
                        -- 2009년 연말정산 수정(주(현)근무처 비과세 소득 변경);
                        || LPAD(NVL(YA.NONTAX_SCH_EDU_AMT, 0), 10, 0) -- 30.비과세-학자금;
                        || LPAD(NVL(YA.NONTAX_MEMBER_AMT, 0), 10, 0) -- 31.비과세-무보수위원수당;
                        || LPAD(NVL(YA.NONTAX_GUARD_AMT, 0), 10, 0) -- 32.비과세-경호/승선수당;
                        || LPAD(NVL(YA.NONTAX_CHILD_AMT, 0), 10, 0) -- 33.비과세-유아/초중등_연구보조/활동비;
                        || LPAD(NVL(YA.NONTAX_HIGH_SCH_AMT, 0), 10, 0) -- 34.비과세-고등교육_연구보조/활동비;
                        || LPAD(NVL(YA.NONTAX_SPECIAL_AMT, 0), 10, 0) -- 35.비과세-특정연구기관육성법_연구보조/활동비;
                        || LPAD(NVL(YA.NONTAX_RESEARCH_AMT, 0), 10, 0) -- 36.비과세-연구기관_연구보조/활동비;
                        || LPAD(NVL(YA.NONTAX_COMPANY_AMT, 0), 10, 0) -- 37.비과세-기업연구소_연구보조/활동비;
                        -- 전호수 : 2012년도 추가 BEGIN --
                        || LPAD(0, 10, 0)  -- 38.비과세 : 보육교사 근무환경개선비.
                        || LPAD(0, 10, 0)  -- 39.비과세 : 사립유치원 수석교사/교사의 인건비.
                        -- END --
                        || LPAD(NVL(YA.NONTAX_COVER_AMT, 0), 10, 0) -- 40.비과세-취재수당;
                        || LPAD(NVL(YA.NONTAX_WILD_AMT, 0), 10, 0) -- 41.비과세-벽지수당;
                        || LPAD(NVL(YA.NONTAX_DISASTER_AMT, 0), 10, 0) -- 42.비과세-재해관련급여;
                        || LPAD(0, 10, 0)  -- 43.2013년도 추가 : 정부/공공기관  지방이전기관 종사자 이주수당; 
                        || LPAD(NVL(YA.NONTAX_OUTS_GOVER_AMT, 0), 10, 0) -- 44.비과세-외국정부등근무자;
                        || LPAD(NVL(YA.NONTAX_OUTS_ARMY_AMT, 0), 10, 0) -- 45.비과세-외국주둔군인등;
                        || LPAD(NVL(YA.NONTAX_OUTS_WORK_1, 0), 10, 0) -- 46.비과세-국외근로(100만원);
                        || LPAD(NVL(YA.NONTAX_OUTS_WORK_2, 0), 10, 0) -- 47.국외근로200만원(300만원);
                        || LPAD(NVL(YA.NONTAX_OUTSIDE_AMT, 0), 10, 0) -- 48.비과세 국외소득;
                        || LPAD(NVL(YA.NONTAX_OT_AMT, 0), 10, 0) -- 49.비과세 야간근로;
                        || LPAD(NVL(YA.NONTAX_BIRTH_AMT, 0), 10, 0) -- 50.비과세 출생/보육수당;
                        || LPAD(0, 10, 0)  -- 51.근로장학금.
                        || LPAD(NVL(YA.NONTAX_STOCK_BENE_AMT, 0), 10, 0) -- 52.비과세-주식매수선택권;
                        || LPAD(NVL(YA.NONTAX_FOR_ENG_AMT, 0), 10, 0) -- 53.비과세-외국인기술자;
                        || LPAD(NVL(YA.NONTAX_EMPL_BENE_AMT_1, 0), 10, 0) -- 54.비과세-우리사주조합인출금(50%);
                        || LPAD(NVL(YA.NONTAX_EMPL_BENE_AMT_2, 0), 10, 0) -- 55.비과세-우리사주조합인출금(75%);
                        || LPAD(0, 10, 0) -- 56.비과세-장기미취업자 중소기업 취업;
                        --|| LPAD(NVL(YA.NONTAX_HOUSE_SUBSIDY_AMT, 0), 10, 0) -- 비과세-주택자금보조금(X);
                        || LPAD(NVL(YA.NONTAX_SEA_RESOURCE_AMT, 0), 10, 0) -- 57.비과세-해저광물자원개발;
                        -- 전호수 추가 : 2012년도 적용 BEGIN --
                        || LPAD(0, 10, 0)  -- 58.전공의수련보조수당.
                        || LPAD(0, 10, 0)  -- 59.중소기업 취업 청년 소득세 감면;
                        || LPAD(0, 10, 0)  -- 60.조세조약상 교직자 감면;
                        --|| LPAD(0, 10, 0) -- 지정비과세;
                        -- 전호수 추가 : 2012년도 적용 END --
                        -- 비과세 계;
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
                                --NVL(YA.NONTAX_FOR_ENG_AMT, 0) +  -- 외국인 기술자(감면소득 계로 이동);
                                NVL(YA.NONTAX_EMPL_BENE_AMT_1, 0) +
                                NVL(YA.NONTAX_EMPL_BENE_AMT_2, 0)) 
                                --NVL(YA.NONTAX_HOUSE_SUBSIDY_AMT, 0) +                       
                                --NVL(YA.NONTAX_SEA_RESOURCE_AMT, 0))  -- 해저광물자원개발(감면소득 계로 이동);
                                --NVL(YA.NONTAX_ETC_AMT, 0),
                                , 10, 0)  -- 61.비과세계.
                        || LPAD(NVL(YA.NONTAX_FOR_ENG_AMT, 0) + NVL(YA.NONTAX_SEA_RESOURCE_AMT, 0), 10, 0)    -- 62감면소득계(항목53 + 항목57);
                        --> 정산명세.
                        || LPAD( CASE
                                   WHEN NVL(YA.FOREIGN_FIX_TAX_YN, 'N') = 'N' THEN NVL(YA.INCOME_TOT_AMT, 0)
                                   ELSE (NVL(YA.NOW_PAY_TOT_AMT, 0) + NVL(YA.NOW_BONUS_TOT_AMT, 0) +
                                         NVL(YA.NOW_ADD_BONUS_AMT, 0) + NVL(YA.NOW_STOCK_BENE_AMT, 0) +
                                         NVL(YA.PRE_PAY_TOT_AMT, 0) + NVL(YA.PRE_BONUS_TOT_AMT, 0) +
                                         NVL(YA.PRE_ADD_BONUS_AMT, 0) + NVL(YA.PRE_STOCK_BENE_AMT, 0) +
                                         NVL(YA.INCOME_OUTSIDE_AMT, 0) +
                                         NVL(YA.NOW_EMPLOYEE_STOCK_AMT, 0) + NVL(YA.NOW_OFFICE_RETIRE_OVER_AMT, 0) +
                                         NVL(YA.PRE_EMPLOYEE_STOCK_AMT, 0) + NVL(YA.PRE_OFFICE_RETIRE_OVER_AMT, 0) + 
                                         -- 비과세 
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
                                         -- 종전-- 
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
                                 END, 11, 0) -- 63.총급여;
                        || LPAD(NVL(YA.INCOME_DED_AMT, 0), 10, 0) -- 64.근로소득공제;
                        || LPAD(NVL(YA.INCOME_TOT_AMT, 0) - NVL(YA.INCOME_DED_AMT, 0), 11, 0) -- 65.근로소득금액;
                        --> 기본공제.
                        || LPAD(NVL(YA.PER_DED_AMT, 0), 8, 0) -- 66.본인공제금액;
                        || LPAD(NVL(YA.SPOUSE_DED_AMT, 0), 8, 0) -- 67.배우자공제금액;
                        || LPAD(NVL(YA.SUPP_DED_COUNT, 0), 2, 0) -- 68.부양가족공제인원;
                        || LPAD(NVL(YA.SUPP_DED_AMT, 0), 8, 0) -- 69.부양가족공제금액;
                        --> 추가공제.
                        -- 2009년 BEGIN : 경로우대공제인원 70세이상만 적용;
                        || LPAD(NVL(YA.OLD_DED_COUNT1, 0), 2, 0) -- 70.경로우대공제인원;
                        || LPAD(NVL(YA.OLD_DED_AMT1, 0), 8, 0) -- 71.경로우대공제금액;
                        /*
                        || LPAD(NVL(YA.OLD_DED_COUNT, 0) + NVL(YA.OLD_DED_COUNT1, 0), 2, 0) -- 경로우대공제인원;
                        || LPAD(NVL(YA.OLD_DED_AMT, 0) + NVL(YA.OLD_DED_AMT1, 0), 8, 0) -- 경로우대공제금액;*/
                        -- 2009년 END;
                        || LPAD(NVL(YA.DISABILITY_DED_COUNT, 0), 2, 0) -- 72.장애인공제인원;
                        || LPAD(NVL(YA.DISABILITY_DED_AMT, 0), 8, 0) -- 73.장애인공제금액;
                        || LPAD(NVL(YA.WOMAN_DED_AMT, 0), 8, 0) -- 74.부녀자공제금액;
                        || LPAD(NVL(YA.CHILD_DED_COUNT, 0), 2, 0) -- 75.자녀양육비공제인원;
                        || LPAD(NVL(YA.CHILD_DED_AMT, 0), 8, 0) -- 76.자녀양육비공제금액;
                        || LPAD(NVL(YA.BIRTH_DED_COUNT, 0), 2, 0) -- 77.출산/입양자공제인원;
                        || LPAD(NVL(YA.BIRTH_DED_AMT, 0), 8, 0) --  78.출산/입양자공제금액;
                        || LPAD(NVL(YA.SINGLE_PARENT_DED_AMT, 0), 10, 0) -- 79.2013년도 추가 : 한부모 가족 공제금액;
                        -- LPAD(NVL(YA.PER_ADD_DED_AMT, 0), 8, 0)   PER_ADD_DED_AMT;
                        --> 다자녀추가공제;
                        || LPAD(NVL(YA.MANY_CHILD_DED_COUNT, 0), 2, 0) -- 80.다자녀추가공제인원;
                        || LPAD(NVL(YA.MANY_CHILD_DED_AMT, 0), 8, 0) -- 81.다자녀추가공제금액;
                        -->연금보험료;
                        || LPAD(NVL(YA.NATI_ANNU_AMT, 0), 10, 0) -- 82.국민연금보험료공제;
                        || LPAD(NVL(YA.PUBLIC_INSUR_AMT, 0), 10, 0)  -- 83.기타연금보험료공제_공무원연금;
                        || LPAD(NVL(YA.MARINE_INSUR_AMT, 0), 10, 0)  -- 84.기타연금보험료공제_군인연금;
                        || LPAD(NVL(YA.SCHOOL_STAFF_INSUR_AMT, 0), 10, 0)  -- 85.기타연금보험료공제_사립학교교직원연금;
                        || LPAD(NVL(YA.POST_OFFICE_INSUR_AMT, 0), 10, 0)  -- 86.기타연금보험료공제_별정우체국연금;
                        || LPAD(NVL(YA.SCIENTIST_ANNU_AMT, 0), 10, 0)  -- 87.기타연금보험료공제_과학기술인공제;
                        || LPAD(NVL(YA.RETR_ANNU_AMT, 0), 10, 0)  -- 88.기타연금보험료공제_근로자퇴직급여보장법;
                        || LPAD(NVL(YA.ANNU_BANK_AMT, 0), 10, 0) -- 89.2013년도 수정 : 연금저축소득공제;
                        --> 특별공제.
                        -- 보험료공제금;
                        -- 2009년 연말정산 BEGIN. 보험료공제금 0원 미만인 경우에는 0원 처리;
                        || LPAD(CASE 
                                  WHEN NVL(YA.MEDIC_INSUR_AMT, 0) < 0 THEN 0
                                  ELSE NVL(YA.MEDIC_INSUR_AMT, 0) 
                                END, 10, 0)  -- 90.건강보험료;
                        || LPAD(CASE 
                                  WHEN NVL(YA.HIRE_INSUR_AMT, 0) < 0 THEN 0
                                  ELSE NVL(YA.HIRE_INSUR_AMT, 0) 
                                END, 10, 0)  -- 91.고용보험료;
                        || LPAD(NVL(YA.GUAR_INSUR_AMT, 0), 10, 0)  -- 92.보장보험료 ;
                        || LPAD(NVL(YA.DISABILITY_INSUR_AMT, 0), 10, 0)  -- 93.장애보험료 ;
                        || LPAD(NVL(YA.DISABILITY_MEDIC_AMT, 0), 10, 0)  -- 94.2013년도 수정 : 의료비공제금액-장애인;
                        || LPAD(NVL(YA.ETC_MEDIC_AMT, 0), 10, 0)  -- 95.2013년도 수정 : 의료비공제금액-기타;
                        || LPAD(NVL(YA.DISABILITY_EDUCATION_AMT, 0), 8, 0) -- 96.2013년도 수정 : 교육비공제금액-장애인;
                        || LPAD(NVL(YA.ETC_EDUCATION_AMT, 0), 8, 0) -- 97.2013년도 수정 : 교육비공제금액-기타;
                        || LPAD(NVL(YA.HOUSE_INTER_AMT, 0), 8, 0) -- 98.주택임대차차입금원리금상환공제금액(대출자);
                        || LPAD(NVL(YA.HOUSE_INTER_AMT_ETC, 0), 8, 0)  -- 99.2013년도 수정 : 주택임차차입금원리금상환액(거주자).
                        || LPAD(NVL(YA.HOUSE_MONTHLY_AMT, 0), 8, 0)  -- 100.주택자금_월세액;
                        || LPAD(NVL(YA.LONG_HOUSE_PROF_AMT, 0), 8, 0) -- 101.장기주택저당차입금이자상환공제금액;
                        || LPAD(NVL(YA.LONG_HOUSE_PROF_AMT_1, 0), 8, 0) -- 102.장기주택저당차입금이자상환공제금액(15);
                        || LPAD(NVL(YA.LONG_HOUSE_PROF_AMT_2, 0), 8, 0) -- 103.장기주택저당차입금이자상환공제금액(30);
                        -- 전호수 추가 : 2012년도 연말정산 BEGIN --
                        || LPAD(NVL(YA.LONG_HOUSE_PROF_AMT_3_FIX, 0), 8, 0) -- 104.12년 이후 장기주택저당차입금이자상환공제금액(고정금리);
                        || LPAD(NVL(YA.LONG_HOUSE_PROF_AMT_3_ETC, 0), 8, 0) -- 105.12년 이후 장기주택저당차입금이자상환공제금액(기타);
                        -- 전호수 추가 : 2012년도 연말정산 END --
                        || LPAD(NVL(YA.DONAT_DED_POLI_AMT, 0), 11, 0)  -- 106.2013년도 수정 : 정치자금 기부금;
                        || LPAD(NVL(YA.DONAT_DED_ALL, 0), 11, 0)  -- 107.2013년도 수정 : 법정기부금;
                        || LPAD(NVL(YA.DONAT_DED_30, 0), 11, 0)  -- 108.013년도 수정 : 우리사주조합 기부금;
                        || LPAD(NVL(YA.DONAT_DED_RELIGION_10, 0) + 
                                NVL(YA.DONAT_DED_10, 0), 11, 0)  -- 109.2013년도 수정 : 지정기부금 기부금 합계;
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
                                  NVL(YA.DONAT_AMT, 0), 11, 0) -- 111.계;
                        || LPAD(NVL(YA.STAND_DED_AMT, 0), 8, 0) -- 112.표준공제;
                        || LPAD(NVL(YA.SUBT_DED_AMT, 0), 11, 0) -- 113.차감소득금액; 
                        --> 그 밖의 소득공제.
                        || LPAD(NVL(YA.PERS_ANNU_BANK_AMT, 0), 8, 0) -- 114.개인연금저축소득공제;
                        || LPAD(NVL(YA.SMALL_CORPOR_DED_AMT, 0), 10, 0) -- 115.소기업공제부금소득공제;
                        || LPAD(NVL(YA.HOUSE_APP_DEPOSIT_AMT, 0), 10, 0)  -- 116.가)주택마련저축소득공제-청약저축;
                        || LPAD(NVL(YA.HOUSE_APP_SAVE_AMT, 0), 10, 0) -- 117.나)주택마련저축소득공제-주택청약종합저축;
                        --|| LPAD(NVL(YA.HOUSE_SAVE_AMT, 0), 10, 0)  -- 2013년도 삭제 : 다)장기주택마련저축.
                        || LPAD(NVL(YA.WORKER_HOUSE_SAVE_AMT, 0), 10, 0)  -- 118.라)근로자주택마련저축.
                        || LPAD(NVL(YA.INVES_AMT, 0), 10, 0) -- 119.투자조합출자등소득공제;
                        || LPAD(NVL(YA.CREDIT_AMT, 0), 8, 0) -- 120.신용카드등 소득공제;                        
                        --|| LPAD(CASE
                        --        WHEN NVL(YA.EMPL_STOCK_AMT, 0) < 0 THEN 0
                        --        ELSE 1
                        --      END, 1, 0) -- 우리사주조합소득공제(양수이면 0);
                        || LPAD(NVL(YA.EMPL_STOCK_AMT, 0), 10, 0) -- 121.우리사주조합소득공제(한도 400만원);
                        --|| LPAD(NVL(YA.LONG_STOCK_SAVING_AMT, 0), 10, 0) -- 2013년도 수정(적용 안함) : 장기주식형저축소득공제;
                        -- 2009년 연말정산 추가 BEGIN. 고용유지중소기업근로자소득공제/공란 추가;
                        || LPAD(NVL(YA.HIRE_KEEP_EMPLOY_AMT, 0), 10, 0) -- 122.고용유지중소기업근로자소득공제;
                        || LPAD(NVL(YA.FIX_LEASE_DED_AMT, 0), 10, 0) -- 123.2013년도 추가 : 목돈안드는전세이자상환액공제;
                        -- 2009년 연말정산 추가 END --
                        || LPAD((NVL(YA.PERS_ANNU_BANK_AMT, 0) +
                                NVL(YA.SMALL_CORPOR_DED_AMT, 0) +
                                NVL(YA.HOUSE_APP_DEPOSIT_AMT, 0) +
                                NVL(YA.HOUSE_APP_SAVE_AMT, 0) +
                                NVL(YA.WORKER_HOUSE_SAVE_AMT, 0) +
                                NVL(YA.INVES_AMT, 0) +
                                NVL(YA.CREDIT_AMT, 0) +
                                NVL(YA.EMPL_STOCK_AMT, 0) +
                                NVL(YA.HIRE_KEEP_EMPLOY_AMT, 0) + 
                                NVL(YA.FIX_LEASE_DED_AMT, 0)), 10, 0) -- 124.그밖의 소득공제 계(양수이면 '0'수록);
                        || LPAD(NVL(YA.SP_DED_TOT_AMT, 0), 11, 0) -- 125.특별공제 종합한도 초과액;
                        || LPAD(NVL(YA.TAX_STD_AMT, 0), 11, 0) -- 126.종합소득 과세표준;
                        || LPAD(NVL(YA.COMP_TAX_AMT, 0), 10, 0) -- 127.산출세액;
                        --> 세액감면.
                        || LPAD(NVL(YA.TAX_REDU_IN_LAW_AMT, 0), 10, 0) --128.소득세법;
                        || LPAD(NVL(YA.TAX_REDU_SP_LAW_AMT, 0), 10, 0) -- 129.조세특례제한법;
                        -- 2012년 연말정산 추가 START --
                        || LPAD(0, 10, 0) -- 130.조세특례제한법 : 중소기업 취업 청년 소득세 감면;
                        -- 2012년 연말정산 추가 END --
                        || LPAD(NVL(YA.TAX_REDU_TAX_TREATY, 0), 10, 0) -- 131.조세조약.
                        || LPAD(0, 10, 0) -- 132.공란;
                        || LPAD(NVL(YA.TAX_REDU_IN_LAW_AMT, 0) +
                                NVL(YA.TAX_REDU_SP_LAW_AMT, 0) +
                                NVL(YA.TAX_REDU_TAX_TREATY, 0), 10, 0) -- 133.감면세액계;
                        --> 세액공제.
                        || LPAD(NVL(YA.TAX_DED_INCOME_AMT, 0), 10, 0) -- 134.근로소득세액공제;
                        || LPAD(NVL(YA.TAX_DED_TAXGROUP_AMT, 0), 10, 0) -- 135.납세조합공제;
                        || LPAD(NVL(YA.TAX_DED_HOUSE_DEBT_AMT, 0), 10, 0) -- 136.주택차입금;
                        || LPAD(NVL(YA.TAX_DED_DONAT_POLI_AMT, 0), 10, 0) -- 137.기부정치자금;
                        || LPAD(NVL(YA.TAX_DED_OUTSIDE_PAY_AMT, 0), 10, 0) -- 138.외국납부;
                        || LPAD(0, 10, 0) -- 139.공란;
                        || LPAD(NVL(YA.TAX_DED_INCOME_AMT, 0) +
                                NVL(YA.TAX_DED_TAXGROUP_AMT, 0) +
                                NVL(YA.TAX_DED_HOUSE_DEBT_AMT, 0) +
                                NVL(YA.TAX_DED_DONAT_POLI_AMT, 0) +
                                NVL(YA.TAX_DED_OUTSIDE_PAY_AMT, 0), 10, 0) -- 140.세액공제계;
                        --> 결정세액.
                        || LPAD(NVL(YA.FIX_IN_TAX_AMT, 0), 10, 0) -- 141.소득세(원단위 절사);
                        || LPAD(NVL(YA.FIX_LOCAL_TAX_AMT, 0), 10, 0) -- 142.주민세;
                        || LPAD(NVL(YA.FIX_SP_TAX_AMT, 0), 10, 0) -- 143.농특세;
                        /* -- 전호수 주석 : 합계 없음.
                        || LPAD(TRUNC(NVL(YA.FIX_IN_TAX_AMT, 0), -1) +
                                TRUNC(NVL(YA.FIX_LOCAL_TAX_AMT, 0), -1) +
                                TRUNC(NVL(YA.FIX_SP_TAX_AMT, 0), -1), 10, 0) -- 결정세액 합계;*/ 
                        /* -- 종(전)납부세액 없음.
                        --> 종(전) 납부세액.
                        || LPAD(TRUNC(NVL(HEW1.IN_TAX_AMT, 0), -1), 10, 0) -- 소득세.
                        || LPAD(TRUNC(NVL(HEW1.LOCAL_TAX_AMT, 0), -1), 10, 0) -- 주민세.
                        || LPAD(TRUNC(NVL(HEW1.SP_TAX_AMT, 0), -1), 10, 0) -- 농특세;
                        || LPAD(TRUNC(NVL(HEW1.IN_TAX_AMT, 0), -1) + 
                                TRUNC(NVL(HEW1.LOCAL_TAX_AMT, 0), -1) + 
                                TRUNC(NVL(HEW1.SP_TAX_AMT, 0), -1), 10, 0) -- 종전 납부세액 합계;*/
                        -- 2009년 연말정산 수정(MODIFIED BY YOUNG MIN). "종(현) 납부세액"에서 "기납부세액 - 주(현)근무지"로 명칭 변경;
                        --> 기납부세액 - 주(현)근무지;
                        || LPAD((NVL(YA.PRE_IN_TAX_AMT, 0) - NVL(S_PW.IN_TAX_AMT, 0)), 10, 0) -- 144.소득세.
                        || LPAD((NVL(YA.PRE_LOCAL_TAX_AMT, 0) - NVL(S_PW.LOCAL_TAX_AMT, 0)), 10, 0) --145.주민세.
                        || LPAD((NVL(YA.PRE_SP_TAX_AMT, 0) - NVL(S_PW.SP_TAX_AMT, 0)), 10, 0) -- 146.농특세.
                        /* -- 전호수 주석 : 합계 없음.
                        || LPAD(TRUNC(NVL(YA.PRE_IN_TAX_AMT, 0) - NVL(HEW1.IN_TAX_AMT, 0), -1) +
                                TRUNC(NVL(YA.PRE_LOCAL_TAX_AMT, 0) - NVL(HEW1.LOCAL_TAX_AMT, 0), -1) +
                                TRUNC(NVL(YA.PRE_SP_TAX_AMT, 0) - NVL(HEW1.SP_TAX_AMT, 0), -1), 10, 0) -- 주(현) 납부세액 합계;*/
                        --> 차감징수세액;
                        -- 2009년 연말정산 수정(MODIFIED BY YOUNG MIN). "차감징수세액"추가(10원미만 단수절사);
                        -- 결정세액 - [주(현)근무지 기납부세액 + 종(전)근무지 기납부세액의 합];
                        || LPAD(CASE
                                  WHEN TRUNC((NVL(YA.FIX_IN_TAX_AMT, 0) - NVL(YA.PRE_IN_TAX_AMT, 0)), -1) < 0 THEN 1
                                  ELSE 0
                                END, 1, 0)  -- 147. 0 <= 차감징수세액(소득세) < 1000 인 경우 "0"기재;
                        || LPAD(ABS(TRUNC((NVL(YA.FIX_IN_TAX_AMT, 0) - NVL(YA.PRE_IN_TAX_AMT, 0)), -1)), 10, 0) -- 147.차감소득세.
                        || LPAD(CASE
                                  WHEN TRUNC((NVL(YA.FIX_LOCAL_TAX_AMT, 0) - NVL(YA.PRE_LOCAL_TAX_AMT, 0)), -1) < 0 THEN 1
                                  ELSE 0
                                END, 1, 0)  -- 148. 0 <= 차감징수세액(주민세) < 1000 인 경우 "0"기재;
                        || LPAD(ABS(TRUNC((NVL(YA.FIX_LOCAL_TAX_AMT, 0) - NVL(YA.PRE_LOCAL_TAX_AMT, 0)), -1)), 10, 0) -- 148.차감주민세.
                        || LPAD(CASE
                                  WHEN TRUNC((NVL(YA.FIX_SP_TAX_AMT, 0) - NVL(YA.PRE_SP_TAX_AMT, 0)), -1) < 0 THEN 1
                                  ELSE 0
                                END, 1, 0)  -- 149. 0 <= 차감징수세액(농특세) < 1000 인 경우 "0"기재;
                        || LPAD(ABS(TRUNC((NVL(YA.FIX_SP_TAX_AMT, 0) - NVL(YA.PRE_SP_TAX_AMT, 0)), -1)), 10, 0)  -- 149.차감 농특세.                      
                        --> 150.공백.
                        || LPAD(' ', 12, ' ') AS RECORD_FILE
                        , NVL(YA.MEDIC_INSUR_AMT, 0) + NVL(YA.HIRE_INSUR_AMT, 0) AS MEDIC_INSUR_AMT  -- 'E'레코드에서 사용(국세청제공 보험료 포함 예정).
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
                        , ( -- 종전근무처 정보.
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
            --> 종(전)근무처 레코드 <--
            FOR D1 IN ( SELECT -- 자료관리번호;
                              'D' -- 1.레코드 구분;
                            || '20' -- 2.자료구분;
                            || RPAD(B1.TAX_OFFICE_CODE, 3, ' ') -- 3.세무서코드;
                            || LPAD(C1.C_SEQ_NO, 6, '0') -- 4.C레코드의 일련번호.
                            -- 원천징수의무자;
                            || RPAD(B1.VAT_NUMBER, 10, ' ') -- 5.사업자번호.
                            || RPAD(' ', 50, ' ') -- 6.공란;
                            -- 소득자;
                            || RPAD(NVL(C1.REPRE_NUM, ' '), 13, ' ') -- 7.주민번호.
                            -- 근무처별 소득명세 - 종(전)근무처;
                            || RPAD('2',1,' ') -- 8.납세조합구분;
                            || RPAD(REPLACE(PW.COMPANY_NAME, ' ' , ''), 40, ' ') -- 9.법인명(상호);
                            || RPAD(REPLACE(PW.COMPANY_NUM, '-', ''), 10, ' ') -- 10.사업자등록번호;
                            -- 2009년 연말정산 수정. 근무기간/감면기간 시작/종료연월일 추가;
                            || RPAD(CASE -- 11.근무기간 시작연월일;
                                      WHEN PW.JOIN_DATE > TO_DATE(P_YEAR_YYYY || '-01-01', 'YYYY-MM-DD') THEN TO_CHAR(PW.JOIN_DATE, 'YYYYMMDD')
                                      ELSE P_YEAR_YYYY || '0101'
                                    END, 8, '0')
                            || RPAD(TO_CHAR(NVL(PW.RETR_DATE, C1.JOIN_DATE -1), 'YYYYMMDD'), 8, '0') -- 12.근무기간 종료연월일;
                            || LPAD('0', 8, '0') -- 13.감면기간 시작연월일;
                            || LPAD('0', 8, '0') -- 14.감면기간 종료연월일;
                            || LPAD(NVL(PW.PAY_TOTAL_AMT, 0), 11, 0) -- 15.급여총액;
                            || LPAD(NVL(PW.BONUS_TOTAL_AMT, 0), 11, 0) -- 16.상여총액;
                            || LPAD(NVL(PW.ADD_BONUS_AMT, 0), 11, 0) -- 17.인정상여;
                            || LPAD(NVL(PW.STOCK_BENE_AMT, 0), 11, 0) -- 18.주식매수선택권행사이익;
                            -- 2009년 연말정산 수정(MODIFIED BY YOUNG MIN). 우리사주조합인출금 추가;
                            || LPAD(0, 11, 0)  -- 19.우리사주조합인출금(계에는 포함하지 않았음);
                            || LPAD(NVL(PW.OFFICERS_RETIRE_OVER_AMT, 0), 11, 0)  -- 20. 2013년 추가 : 임원 퇴직소득금액 한도초과액 
                            || LPAD(0, 22, 0)  -- 21.공란.
                            || LPAD(NVL(PW.PAY_TOTAL_AMT, 0) +
                                    NVL(PW.BONUS_TOTAL_AMT, 0) +
                                    NVL(PW.ADD_BONUS_AMT, 0) +
                                    NVL(PW.STOCK_BENE_AMT, 0) +
                                    NVL(PW.OFFICERS_RETIRE_OVER_AMT, 0), 11, 0)  -- 22.계.
                            --> 종(전)근무처 비과세 소득.
                            -- 2009년 연말정산 수정(MODIFIED BY YOUNG MIN).종(전)근무처 비과세 소득 전면변경;
                            || LPAD(NVL(PW.NT_SCH_EDU_AMT, 0), 10, 0) -- 23.비과세-학자금;
                            || LPAD(NVL(PW.NT_MEMBER_AMT, 0), 10, 0) -- 24.비과세-무보수위원수당;
                            || LPAD(NVL(PW.NT_GUARD_AMT, 0), 10, 0) -- 25.비과세-경호/승선수당;
                            || LPAD(NVL(PW.NT_CHILD_AMT, 0), 10, 0) -- 26.비과세-유아/초중등_연구보조/활동비;
                            || LPAD(NVL(PW.NT_HIGH_SCH_AMT, 0), 10, 0) -- 27.비과세-고등교육_연구보조/활동비;
                            || LPAD(NVL(PW.NT_SPECIAL_AMT, 0), 10, 0) -- 28.비과세-특정연구기관육성법_연구보조/활동비;
                            || LPAD(NVL(PW.NT_RESEARCH_AMT, 0), 10, 0) -- 29.비과세-연구기관_연구보조/활동비;
                            || LPAD(NVL(PW.NT_COMPANY_AMT, 0), 10, 0) -- 30.비과세-기업연구소_연구보조/활동비;
                            -- 2012년 연말정산 추가 START --
                            || LPAD(0, 10, 0) -- 31.비과세-보육교사 근무환경개선비;
                            || LPAD(0, 10, 0) -- 32.비과세-사립유치원 수석교사/교사의 인건비;
                            -- 2012년 연말정산 추가 END --
                            || LPAD(NVL(PW.NT_COVER_AMT, 0), 10, 0) -- 33.비과세-취재수당;
                            || LPAD(NVL(PW.NT_WILD_AMT, 0), 10, 0) -- 34.비과세-벽지수당;
                            || LPAD(NVL(PW.NT_DISASTER_AMT, 0), 10, 0) -- 35.비과세-재해관련급여;
                            || LPAD(0, 10, 0) -- 36.비과세-정부공공기관 지방이전기관 종사자 이주수당;
                            || LPAD(NVL(PW.NT_OUTSIDE_GOVER_AMT, 0), 10, 0) -- 37.비과세-외국정부등근무자;
                            || LPAD(NVL(PW.NT_OUTSIDE_ARMY_AMT, 0), 10, 0) -- 38.비과세-외국주둔군인등;
                            || LPAD(NVL(PW.NT_OUTSIDE_WORK1, 0), 10, 0) -- 39.비과세-국외근로(100만원);
                            || LPAD(NVL(PW.NT_OUTSIDE_WORK2, 0), 10, 0) -- 40.비과세-국외근로(300만원);
                            || LPAD(NVL(PW.NT_OUTSIDE_AMT, 0), 10, 0) -- 41.비과세 국외소득;
                            || LPAD(NVL(PW.NT_OT_AMT, 0), 10, 0) -- 42.비과세 야간근로;
                            || LPAD(NVL(PW.NT_BIRTH_AMT, 0), 10, 0) -- 43.비과세 출생/보육수당;
                            || LPAD(0, 10, 0) -- 44.근로장학금.
                            || LPAD(NVL(PW.NT_STOCK_BENE_AMT, 0), 10, 0) -- 45.비과세-주식매수선택권;
                            || LPAD(NVL(PW.NT_FOREIGNER_AMT, 0), 10, 0) -- 46.비과세-외국인기술자;
                            --|| LPAD(NVL(PW.NONTAX_FOREIGNER_AMT, 0), 10, 0) -- 비과세 외국인 근로자;
                            --|| LPAD(NVL(PW.NONTAX_EMPL_STOCK_AMT, 0), 10, 0) --  비과세-우리사주조합배정;
                            || LPAD(NVL(PW.NT_EMPL_STOCK_AMT, 0), 10, 0) -- 47.비과세-우리사주조합인출금(50%);
                            || LPAD(NVL(PW.NT_EMPL_BENE_AMT2, 0), 10, 0) -- 48.비과세-우리사주조합인출금(75%);
                            || LPAD(0, 10, 0)                                  -- 49.비과세-장기미취업자 중소기업 취업;
                            --|| LPAD(NVL(PW.NONTAX_HOUSE_SUBSIDY_AMT, 0), 10, 0) -- 비과세-주택자금보조금;
                            || LPAD(NVL(PW.NT_SEA_RESOURCE_AMT, 0), 10, 0) -- 50.비과세-해저광물자원개발;
                            -- 2012년 연말정산 추가 START --
                            || LPAD(0, 10, 0) -- 51.비과세-전공의 수련보조수당;
                            || LPAD(0, 10, 0) -- 52.비과세-중소기업 취업청년 소득세 감면;
                            || LPAD(0, 10, 0) -- 53.비과세-조세조약상 교직자 감면;
                            -- 2012년 연말정산 추가 END --
                            --|| LPAD(0, 10, 0)  -- 지정비과세;
                            --|| LPAD(NVL(PW.NONTAX_ETC_AMT, 0), 10, 0) --AS NONTAX_ETC_AMT     -- 비과세 기타;
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
                                    --NVL(PW.NONTAX_FOR_ENG_AMT, 0) +                           -- 감면소득 계로 이동;
                                    --NVL(PW.NONTAX_FOREIGNER_AMT, 0) +
                                    --NVL(PW.NONTAX_EMPL_STOCK_AMT, 0) +
                                    NVL(PW.NT_EMPL_BENE_AMT1, 0) +
                                    NVL(PW.NT_EMPL_BENE_AMT2, 0),
                                    --NVL(PW.NONTAX_HOUSE_SUBSIDY_AMT, 0) +
                                    --NVL(PW.NONTAX_SEA_RESOURCE_AMT, 0) +                      -- 감면소득 계로 이동;
                                    --NVL(PW.NONTAX_ETC_AMT, 0),
                                    10, 0)  -- 54.비과세 계;
                            || LPAD(NVL(PW.NT_FOREIGNER_AMT, 0) +
                                    NVL(PW.NT_SEA_RESOURCE_AMT, 0), 10, 0)  -- 55.감면소득 계;
                            -- 기납부세액 - 종(전)근무지;
                            || LPAD(NVL(PW.IN_TAX_AMT, 0), 10, 0)  -- 56. 기납부 소득세 
                            || LPAD(NVL(PW.LOCAL_TAX_AMT, 0), 10, 0)  -- 57. 기납부 지방소득세 
                            || LPAD(NVL(PW.SP_TAX_AMT, 0), 10, 0)  -- 58.기납부 농특세 
                            /*-- 전호수 주석 : 2011년 없어짐.
                            || LPAD(NVL(PW.IN_TAX_AMT, 0) +
                                    NVL(PW.LOCAL_TAX_AMT, 0) +
                                    NVL(PW.SP_TAX_AMT, 0), 10, 0)*/
                            -- || LPAD(NVL(PW.PAY_TOTAL_AMT, 0) + NVL(PW.BONUS_TOTAL_AMT, 0) + NVL(PW.ADD_BONUS_AMT, 0) + NVL(PW.STOCK_BENE_AMT, 0),11, 0) --AS PAY_SUM_AMT                       -- 계;
                            || LPAD(ROW_NUMBER() OVER(PARTITION BY PW.PERSON_ID ORDER BY PW.SEQ_NUM), 2, 0) -- 59.종(전)근무처 일련번호;
                            -- 60.공란 
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
--E1 부양가족 명세 ----------------------------------------------------------------------------
-- 외국인 단일세율이 아닐경우만 적용.
          IF C1.FOREIGN_TAX_YN = 'N' THEN
            V_RECORD_FILE := NULL;
            V_SEQ_NO    := 0;
            V_RECORD_COUNT := 0;
            FOR E1 IN ( SELECT 
                              'E' -- 1.RECORD_TYPE
                            || '20' --2. DATA_TYPE
                            || RPAD(NVL(B1.TAX_OFFICE_CODE, ' '), 3, ' ') -- 3.세무서코드.
                            || LPAD(NVL(C1.C_SEQ_NO, 0), 6, 0)  -- 4.C레코드의 일련번호.
                            || RPAD(NVL(B1.VAT_NUMBER, ' '), 10, ' ') -- 5.사업자번호.
                            || RPAD(NVL(C1.REPRE_NUM, ' '), 13, ' ') AS RECORD_HEADER -- 6.주민번호.
                            --> 소득공제명세 인적사항.
                            , RPAD(CASE
                                     WHEN NVL(SF.BASE_LIVING_YN, 'N') = 'Y' THEN '7'  -- 2013년도 추가 - 기초수급자 
                                     ELSE NVL(SF.RELATION_CODE, ' ')
                                   END, 1, ' ') -- 7.관계;
                            || RPAD(CASE
                                      WHEN SUBSTR(REPLACE(SF.REPRE_NUM, '-', ''), 7, 1) BETWEEN '5' AND '8' THEN '9'
                                      ELSE '1'
                                    END, 1, ' ') -- 8.내/외국인 구분 코드;
                            || RPAD(NVL(SF.FAMILY_NAME, ' '), 20, ' ') -- 9.성명;
                            || RPAD(NVL(REPLACE(SF.REPRE_NUM, '-', ''), ' ') , 13, ' ') -- 10.주민번호;
                            || DECODE(SF.BASE_YN, 'Y', '1', ' ') -- 11.기본공제;
                            || CASE 
                                 WHEN NVL(SF.BASE_YN, 'N') = 'Y' AND NVL(SF.DISABILITY_YN, 'N') = 'Y' THEN NVL(SF.DISABILITY_CODE, ' ')
                                 ELSE ' '
                               END  -- 12.장애인공제;
                            || DECODE(SF.CHILD_YN, 'Y', '1', ' ') -- 13.자녀양육비공제;
                            || DECODE(SF.WOMAN_YN, 'Y', '1', ' ') -- 14.부녀자공제;
                            -- 2009년 연말정산 수정(MODIFIED BY YOUNG MIN).경로우대 만70세이상으로 변경;
                            || CASE
                                 --WHEN SF.OLD_YN = 'Y' THEN '1'
                                 WHEN SF.OLD1_YN = 'Y' THEN '1'
                                 ELSE ' '
                               END -- 15.경로우대공제;
                            -- 2009년 연말정산 수정(MODIFIED BY YOUNG MIN).출산입양자공제추가;
                            || DECODE(SF.BIRTH_YN, 'Y', '1', ' ') -- 16.출산입양자공제.
                            || DECODE(SF.SINGLE_PARENT_DED_YN, 'Y', '1', ' ') -- 17.한부모1 
                            /*-- 2009년 연말정산 수정(MODIFIED BY YOUNG MIN).다자녀추가공제 폐지;
                            || CASE
                                 WHEN SF.BASE_YN = 'Y' AND C1.MANY_CHILD_DED_AMT <> 0 AND SF.RELATION_CODE = '4' THEN '1'
                                 ELSE ' '
                               END -- 다자녀추가공제;*/
                            --> 국세청 자료.
                            -- 2009년 연말정산 수정(MODIFIED BY YOUNG MIN).국세청자료 공제금액이 음수일 경우 0으로 표기;
                            || LPAD((CASE
                                       WHEN DECODE(SF.RELATION_CODE, 0, NVL(C1.MEDIC_INSUR_AMT, 0), 0) + 
                                            NVL(SF.INSURE_AMT, 0) + NVL(SF.DISABILITY_INSURE_AMT, 0) < 0 THEN 0
                                       ELSE DECODE(SF.RELATION_CODE, 0, NVL(C1.MEDIC_INSUR_AMT, 0), 0) + 
                                            NVL(SF.INSURE_AMT, 0) + NVL(SF.DISABILITY_INSURE_AMT, 0)
                                     END), 10, 0) -- 18.보험료(본인은 건강보험료 포함);
                            || LPAD(NVL(SF.MEDICAL_AMT, 0), 10, 0) -- 19.의료비;
                            || LPAD(NVL(SF.EDUCATION_AMT, 0), 10, 0) -- 20.교육비;
                            || LPAD(NVL(SF.CREDIT_AMT, 0), 10, 0) -- 21.신용카드등;
                            || LPAD(NVL(SF.CHECK_CREDIT_AMT , 0), 10, 0) -- 22.직불카드;
                            || LPAD(NVL(SF.CASH_AMT, 0) + NVL(SF.ACADE_GIRO_AMT, 0), 10, 0) -- 23.현금영수증;
                            --2012년 연말정산 추가 START --
                            || LPAD(NVL(SF.TRAD_MARKET_AMT, 0), 10, 0) -- 24.전통시장사용액;
                            || LPAD(NVL(SF.PUBLIC_TRANSIT_AMT, 0), 10, 0) -- 25.대중교통이용액1;
                            --2012년 연말정산 추가 END --
                            || LPAD(NVL(SF.DONAT_ALL, 0) +
                                    NVL(SF.DONAT_50P, 0) +
                                    NVL(SF.DONAT_30P, 0) +
                                    NVL(SF.DONAT_10P, 0) +
                                    NVL(SF.DONAT_10P_RELIGION, 0), 13, 0)  -- 26.기부금.
                            -->국세청자료 이외.
                            || LPAD(NVL(SF.ETC_INSURE_AMT, 0), 10, 0) -- 27.국세청제공외의 보험료;
                            || LPAD(NVL(SF.ETC_MEDICAL_AMT, 0), 10, 0) -- 28.국세청제공외의 의료비;
                            || LPAD(NVL(SF.ETC_EDUCATION_AMT, 0), 10, 0) -- 29.국세청제공외의 교육비;
                            || LPAD(NVL(SF.ETC_CREDIT_AMT, 0) + NVL(SF.ETC_ACADE_GIRO_AMT, 0), 10, 0) -- 30.국세청제공외의 신용카드;
                            || LPAD(NVL(SF.ETC_CHECK_CREDIT_AMT, 0), 10, 0) -- 31.국세청제공외의 직불카드;
                            --2012년 연말정산 추가 START --
                            || LPAD(NVL(SF.ETC_TRAD_MARKET_AMT, 0), 10, 0) -- 32.전통시장사용액;
                            || LPAD(NVL(SF.ETC_PUBLIC_TRANSIT_AMT, 0), 10, 0)  -- 33. 대중교통이용액;
                            --2012년 연말정산 추가 END --
                            || LPAD(NVL(SF.ETC_DONAT_ALL, 0) +
                                    NVL(SF.ETC_DONAT_50P, 0) +
                                    NVL(SF.ETC_DONAT_30P, 0) +
                                    NVL(SF.ETC_DONAT_10P, 0) +
                                    NVL(SF.ETC_DONAT_10P_RELIGION, 0), 13, 0) AS RECORD_LINE -- 34.국세청제공외의 기부금;
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
              --> 부양가족수 5인 이상일 경우.
              IF V_E_REC_STD <= V_RECORD_COUNT THEN
                V_SEQ_NO := NVL(V_SEQ_NO, 0) + 1;  -- 부양가족 생성 일련번호.
                V_RECORD_FILE := V_RECORD_FILE 
                                 || LPAD(NVL(V_SEQ_NO, 1), 2, 0)  -- 일련번호.
                                 || RPAD(' ', 273, ' ');  -- 공란.
                
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
                V_RECORD_FILE := V_RECORD_FILE || RPAD(' ', 218, ' ');  -- 소득공제 명세서 부양가족 길이.
              END LOOP E1S;
              IF V_RECORD_FILE IS NOT NULL THEN
                V_SEQ_NO := NVL(V_SEQ_NO, 0) + 1;  -- 부양가족 생성 일련번호.
                V_RECORD_FILE := V_RECORD_FILE 
                                 || LPAD(NVL(V_SEQ_NO, 1), 2, 0)  -- 일련번호.
                                 || RPAD(' ', 273, ' ');  -- 공란.
                                 
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

--F1 연금/저축등 소득공제 명세 레코드 -----------------------------------------------------------------
            V_RECORD_FILE := NULL;
            V_SEQ_NO    := 0;
            V_RECORD_COUNT := 0;
            FOR F1 IN ( SELECT 'F' --1.RECORD_TYPE
                            || '20' --2. DATA_TYPE
                            || RPAD(NVL(B1.TAX_OFFICE_CODE, ' '), 3, ' ') -- 3.세무서코드.
                            || LPAD(C1.C_SEQ_NO, 6, 0) -- 4.C레코드의 일련번호.
                            || RPAD(NVL(B1.VAT_NUMBER, ' '), 10, ' ') -- 5.사업자번호.
                            || RPAD(NVL(C1.REPRE_NUM, ' '), 13, ' ') AS RECORD_HEADER -- 6.주민번호.
                            , LPAD(NVL(SI.SAVING_TYPE, ' '), 2, '0')  -- 7.소득공제구분;
                            || RPAD(SI.BANK_CODE, 3, ' ') -- 8.금융기관 코드수록;
                            || RPAD(YB.YEAR_BANK_NAME, 30, ' ') -- 9.금융기관 상호수록;
                            || RPAD(SI.ACCOUNT_NUM, 20, ' ') -- 10.계좌번호;
                            || LPAD(DECODE(SI.SAVING_TYPE, '41', CASE WHEN 3 < SI.SAVING_COUNT THEN 3 ELSE SI.SAVING_COUNT END , '0'), 2, 0) -- 11.납입연차-장기주식형저축만 해당;
                            || LPAD(SI.SAVING_AMOUNT, 10, 0) -- 12.불입금액;
                            || LPAD(SI.SAVING_DED_AMOUNT, 10, 0) AS RECORD_LINE               -- 13.공제금액;
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
              --> 연금저축등 명세서 15개 이상일 경우.
              IF V_F_REC_STD <= V_RECORD_COUNT THEN
                V_SEQ_NO := NVL(V_SEQ_NO, 0) + 1;  -- 연금저축 생성 일련번호.
                V_RECORD_FILE := V_RECORD_FILE || RPAD(' ', 210, ' ');  -- 공란.
                
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
                V_SEQ_NO := NVL(V_SEQ_NO, 0) + 1;  -- 연금저축 생성 일련번호.
                V_RECORD_FILE := V_RECORD_FILE || RPAD(' ', 210, ' ');  -- 연금저축  소득공제명세 순수 길이 => 공란.
                
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
--G1 월세/거주자간 주택임차차입금 원리금 상환액 소득공제명세서 레코드 --------------------
            V_REC_TEMP_1 := RPAD(' ', 20, ' ') ||  -- 임대인 성명
                            RPAD(' ', 13, ' ') || -- 주민등록번호(사업자번호) 
                            RPAD(' ', 100, ' ') ||  --  임대차계약서상 주소지 
                            LPAD(0, 8, 0) ||  -- 임대차계약기간 시작 
                            LPAD(0, 8, 0) ||  -- 임대차계약기간 종료 
                            LPAD(0, 10, 0) ||  -- 월세액 
                            LPAD(0, 10, 0);
            V_REC_TEMP_2 := RPAD(' ', 20, ' ') ||  --    -- 대주성명 
                            RPAD(' ', 13, ' ') || -- 대주 주민번호 
                            LPAD(0, 8, 0) ||  -- 금전소비대차 계약기간 시작 
                            LPAD(0, 8, 0) ||  -- 금전소비대차 계약기간 종료 
                            LPAD(0, 4, 0) ||  -- 차입금 이자율 
                            LPAD(0, 10, 0) ||  -- 원리금 상환액계 
                            LPAD(0, 10, 0) ||  -- 원금 
                            LPAD(0, 10, 0) ||  -- 이자 
                            LPAD(0, 10, 0) ||  -- 공제금액 
                            RPAD(' ', 20, ' ') ||  -- 임대인 성명
                            RPAD(' ', 13, ' ') || -- 주민등록번호(사업자번호) 
                            RPAD(' ', 100, ' ') ||  --  임대차계약서상 주소지 
                            LPAD(0, 8, 0) ||  -- 임대차계약기간 시작 
                            LPAD(0, 8, 0) ||  -- 임대차계약기간 종료 
                            LPAD(0, 10, 0);
            V_RECORD_FILE := NULL;
            V_SEQ_NO    := 0;
            V_RECORD_COUNT := 0;
            FOR G1 IN ( SELECT 'G' --1.RECORD_TYPE
                            || '20' --2. DATA_TYPE
                            || RPAD(NVL(B1.TAX_OFFICE_CODE, ' '), 3, ' ') -- 3.세무서코드.
                            || LPAD(C1.C_SEQ_NO, 6, 0) -- 4.C레코드의 일련번호.
                            || RPAD(NVL(B1.VAT_NUMBER, ' '), 10, ' ') -- 5.사업자번호.
                            || RPAD(NVL(C1.REPRE_NUM, ' '), 13, ' ') AS RECORD_HEADER -- 6.주민번호.
                            
                             , MAX(HL.HOUSE_LEASE_INFO_10) AS HOUSE_LEASE_INFO_10
                             , MAX(HL.HOUSE_LEASE_INFO_20) AS HOUSE_LEASE_INFO_20
                          FROM (SELECT ROWNUM AS ROW_NUM 
                                     , RPAD(NVL(HLI.LESSOR_NAME, ' '), 20, ' ') ||  -- 임대인 성명
                                       RPAD(NVL(REPLACE(HLI.LESSOR_REPRE_NUM, '-', ''), ' '), 13, ' ') || -- 주민등록번호(사업자번호) 
                                       RPAD(NVL(HLI.LEASE_ADDR1, ' ') || ' ' || NVL(HLI.LEASE_ADDR2, ' '), 100, ' ') ||  --  임대차계약서상 주소지 
                                       LPAD(NVL(TO_CHAR(HLI.LEASE_TERM_FR, 'YYYYMMDD'), '0'), 8, 0) ||  -- 임대차계약기간 시작 
                                       LPAD(NVL(TO_CHAR(HLI.LEASE_TERM_TO, 'YYYYMMDD'), '0'), 8, 0) ||  -- 임대차계약기간 종료 
                                       LPAD(NVL(HLI.MONTLY_LEASE_AMT, 0), 10, 0) ||  -- 월세액 
                                       LPAD(NVL(HLI.HOUSE_DED_AMT, 0), 10, 0) AS HOUSE_LEASE_INFO_10
                                     , NULL AS HOUSE_LEASE_INFO_20
                                  FROM HRA_HOUSE_LEASE_INFO HLI
                                WHERE HLI.YEAR_YYYY         = P_YEAR_YYYY
                                  AND HLI.PERSON_ID         = C1.PERSON_ID
                                  AND HLI.SOB_ID            = P_SOB_ID
                                  AND HLI.ORG_ID            = P_ORG_ID
                                  AND HLI.HOUSE_LEASE_TYPE  = '10'  -- 월세  
                                  AND HLI.HOUSE_DED_AMT     != 0    -- 공제금액 있는것만 처리 
                                UNION ALL
                                SELECT ROWNUM AS ROW_NUM 
                                     , NULL AS HOUSE_LEASE_INFO_10
                                     , RPAD(NVL(HLI.LOANER_NAME, ' '), 20, ' ') ||  --    -- 대주성명 
                                       RPAD(NVL(REPLACE(HLI.LOANER_REPRE_NUM, '-', ''), ' '), 13, ' ') || -- 대주 주민번호 
                                       LPAD(NVL(TO_CHAR(HLI.LOAN_TERM_FR, 'YYYYMMDD'), '0'), 8, 0) ||  -- 금전소비대차 계약기간 시작 
                                       LPAD(NVL(TO_CHAR(HLI.LOAN_TERM_TO, 'YYYYMMDD'), '0'), 8, 0) ||  -- 금전소비대차 계약기간 종료 
                                       LPAD(NVL(HLI.LOAN_INTEREST_RATE, 0), 4, 0) ||  -- 차입금 이자율 
                                       LPAD((NVL(HLI.LOAN_AMT, 0) + NVL(HLI.LOAN_INTEREST_AMT, 0)), 10, 0) ||  -- 원리금 상환액계 
                                       LPAD(NVL(HLI.LOAN_AMT, 0), 10, 0) ||  -- 원금 
                                       LPAD(NVL(HLI.LOAN_INTEREST_AMT, 0), 10, 0) ||  -- 이자 
                                       LPAD(NVL(HLI.HOUSE_DED_AMT, 0), 10, 0) ||  -- 공제금액 
                                       RPAD(NVL(HLI.LESSOR_NAME, ' '), 20, ' ') ||  -- 임대인 성명
                                       RPAD(NVL(REPLACE(HLI.LESSOR_REPRE_NUM, '-', ''), ' '), 13, ' ') || -- 주민등록번호(사업자번호) 
                                       RPAD(NVL(HLI.LEASE_ADDR1, ' ') || ' ' || NVL(HLI.LEASE_ADDR2, ' '), 100, ' ') ||  --  임대차계약서상 주소지 
                                       LPAD(NVL(TO_CHAR(HLI.LEASE_TERM_FR, 'YYYYMMDD'), '0'), 8, 0) ||  -- 임대차계약기간 시작 
                                       LPAD(NVL(TO_CHAR(HLI.LEASE_TERM_TO, 'YYYYMMDD'), '0'), 8, 0) ||  -- 임대차계약기간 종료 
                                       LPAD(NVL(HLI.DEPOSIT_AMT, 0), 10, 0) AS HOUSE_LEASE_INFO_20  -- 전세보증금            
                                  FROM HRA_HOUSE_LEASE_INFO HLI
                                WHERE HLI.YEAR_YYYY         = P_YEAR_YYYY
                                  AND HLI.PERSON_ID         = C1.PERSON_ID
                                  AND HLI.SOB_ID            = P_SOB_ID
                                  AND HLI.ORG_ID            = P_ORG_ID
                                  AND HLI.HOUSE_LEASE_TYPE  = '20'  -- 거주자 주택임차차입원리금 
                               ) HL
                        GROUP BY HL.ROW_NUM
                        ORDER BY HL.ROW_NUM
                        )
            LOOP
              V_RECORD_COUNT := NVL(V_RECORD_COUNT, 0) + 1;
              IF V_RECORD_COUNT = 1 THEN
                V_RECORD_FILE := G1.RECORD_HEADER;
                -- 월세  
                IF G1.HOUSE_LEASE_INFO_10 IS NULL THEN
                  V_RECORD_FILE := V_RECORD_FILE || V_REC_TEMP_1;
                ELSE
                  V_RECORD_FILE := V_RECORD_FILE || G1.HOUSE_LEASE_INFO_10;
                END IF;
                -- 거주자간 주택임차차입금 
                IF G1.HOUSE_LEASE_INFO_20 IS NULL THEN
                  V_RECORD_FILE := V_RECORD_FILE || V_REC_TEMP_2;
                ELSE
                  V_RECORD_FILE := V_RECORD_FILE || G1.HOUSE_LEASE_INFO_20;
                END IF;
              ELSE
                -- 월세  
                IF G1.HOUSE_LEASE_INFO_10 IS NULL THEN
                  V_RECORD_FILE := V_RECORD_FILE || V_REC_TEMP_1;
                ELSE
                  V_RECORD_FILE := V_RECORD_FILE || G1.HOUSE_LEASE_INFO_10;
                END IF;
                -- 거주자간 주택임차차입금 
                IF G1.HOUSE_LEASE_INFO_20 IS NULL THEN
                  V_RECORD_FILE := V_RECORD_FILE || V_REC_TEMP_2;
                ELSE
                  V_RECORD_FILE := V_RECORD_FILE || G1.HOUSE_LEASE_INFO_20;
                END IF;
              END IF;
              --> 월세/거주자간 주택임차차입금 원리금 명세서 3개 이상일 경우.
              IF V_G_REC_STD <= V_RECORD_COUNT THEN
                V_SEQ_NO := NVL(V_SEQ_NO, 0) + 1;  -- 월세/거주자간 주택임차차입금 원리금 생성 일련번호.
                V_RECORD_FILE := V_RECORD_FILE || LPAD(V_SEQ_NO, 2, 0);  -- 일련번호 
                V_RECORD_FILE := V_RECORD_FILE || RPAD(' ', 100, ' ');  -- 공란.
                
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
                V_SEQ_NO := NVL(V_SEQ_NO, 0) + 1;  -- 월세/거주자간 주택임차차입금 원리금 생성 일련번호.
                V_RECORD_FILE := V_RECORD_FILE || LPAD(V_SEQ_NO, 2, 0);  -- 일련번호 
                V_RECORD_FILE := V_RECORD_FILE || RPAD(' ', 100, ' ');  -- 공란.

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
          END IF;  -- 외국인 단일세율 적용 안할경우만 적용.
          END LOOP C1;    
        END LOOP B1;
    END LOOP A1;
  END SET_YEAR_ADJUST_FILE_2013_1;            


-------------------------------------------------------------------------------
-- 2013년도 근로소득 파일생성.
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
  --> 주(현) 업체 정보 변수.
    V_SEQ_NUM                   NUMBER := 0;
    V_SOURCE_FILE               VARCHAR2(150);
    V_RECORD_COUNT              NUMBER := 0;
    V_E_REC_STD                 CONSTANT NUMBER := 5;
    V_F_REC_STD                 CONSTANT NUMBER := 15;
    V_G_REC_STD                 CONSTANT NUMBER := 3;    
    V_SEQ_NO                    NUMBER;          -- 레코드 생성 번호.
    V_RECORD_FILE               VARCHAR2(3000);  -- 부양가족 조합위해.
    
    V_REC_TEMP_1                VARCHAR2(300);   
    V_REC_TEMP_2                VARCHAR2(300);   
  BEGIN
    
    -- 전산매체 생성--.
--A1 ------------------------------------------------------------------------------------
    FOR A1 IN ( SELECT 'A'   -- 자료관리번호.
                    || '20'  -- 갑종근로소득(20);
                    || LPAD(REPLACE(OU.TAX_OFFICE_CODE, '-', ''), 3, 0)  -- 세무서 코드;
                    || TO_CHAR(P_WRITE_DATE, 'YYYYMMDD')  -- 자료를 세무서에 제출하는 연월일;
                    --> 제출자;
                    || LPAD(NVL(P_SUBMIT_AGENT, '2'), 1, 0)  -- 제출자구분(세무대리인1, 법인2, 개인3);
                    || RPAD(NVL(P_TAX_AGENT, ' '), 6, ' ')  -- 세무대리인 관리번호(자료제출자가 세무대리인인경우 수록);
                    || RPAD(NVL(P_HOMETAX_LOGIN_ID, ' '), 20, ' ')  -- 홈택스ID;
                    || RPAD(NVL(P_TAX_PROGRAM_CODE, '1001'), 4, ' ')  -- 세무프로그램코드;
                    || RPAD(NVL(REPLACE(OU.VAT_NUMBER, '-', ''), ' '), 10, ' ')  -- 사업자등록번호;
                    || RPAD(NVL(REPLACE(CM.CORP_NAME, ' ', ''), ' '), 40, ' ')  -- 법인명(상호);
                    || RPAD(NVL(REPLACE(S_PM.DEPT_NAME, ' ', ''), ' '), 30, ' ')  -- 담당자(제출자) 부서;
                    || RPAD(NVL(REPLACE(S_PM.NAME, ' ', ''), ' '), 30, ' ')  -- 담당자(제출자) 성명;
                    || RPAD(NVL(REPLACE(CM.TEL_NUMBER, '-', ''), ' '), 15, ' ')  -- 담당자(제출자) 전화번호;
                    --> 제출내역.
                    || LPAD(1, 5, 0)  -- 신고의무자수 (B레코드);
                    || LPAD(NVL(P_USE_LANGUAGE_CODE, '101'), 3, 0)  -- 사용한글코드;
                    || RPAD(' ', 1222, ' ') AS RECORD_FILE
                    , CM.CORP_NAME  -- 법인명.
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
      FOR B1 IN ( SELECT --> 자료관리번호;
                         'B'    -- 레코드 구분;
                      || '20'  -- 갑종근로소득(20);
                      || LPAD(REPLACE(OU.TAX_OFFICE_CODE, '-', ''), 3, 0)   -- 세무서코드; 
                      || LPAD(1, 6, 0)                                      -- B레코드의 일련번호;
                      --> 제출자;
                      || RPAD(NVL(REPLACE(OU.VAT_NUMBER, '-', ''), ' '), 10, ' ')  -- 원천징수의무자의 사업자등록번호;
                      || RPAD(NVL(REPLACE(CM.CORP_NAME, ' ', ''), ' '), 40, ' ')  -- 법인명(상호);
                      || RPAD(NVL(REPLACE(CM.PRESIDENT_NAME, ' ', ''), ' '), 30, ' ')  -- 대표자 성명;
                      || RPAD(NVL(REPLACE(CM.LEGAL_NUMBER, '-', ''), ' '), 13, ' ') -- 법인등록번호;
                      --> 제출내역;
                      || LPAD(NVL(S_YA.NOW_WORKER_COUNT, 0), 7, 0)   -- 9.수록한 C레코드의 수(근로소득자의 수);
                      || LPAD(NVL(S_PW.PRE_WORKER_COUNT, 0), 7, 0)   -- 10.수록한 D레코드(전근무처)의 수(C레코드 항목6의 합계)
                      || LPAD(NVL(S_YA.INCOME_TOT_AMT, 0), 14, 0)    -- 11.총급여 총계(C레코드 급여 합);
                      || LPAD(NVL(S_YA.FIX_IN_TAX, 0), 13, 0)        -- 소득세 결정세액 총계(C레코드 소득세의 합);
                      || LPAD(NVL(S_YA.FIX_LOCAL_TAX, 0), 13, 0)     -- 주민세 결정세액 총계;
                      || LPAD(NVL(S_YA.FIX_SP_TAX, 0), 13, 0)        -- 농특세 결정세액 총계;
                      || LPAD(NVL(S_YA.FIX_TOTAL_TAX, 0) - NVL(S_YA.FIX_LEGAL_TAX, 0), 13, 0)  -- 결정세액 총계;
                      -- LPAD(NVL(S_YA.FIX_TOTAL_TAX, 0), 13, 0)  -- 결정세액 총계 : 2009년 연말정산 수정 결정세액총계-법인세 결정세액 총계;
                      || LPAD(NVL(P_SUBMIT_PERIOD, '1'), 1, 0)   -- (연간합산 : 1, 휴/폐업에 의한 수시제출 : 2, 수시 분할제출 : 3);
                      || RPAD(' ', 1214, ' ') AS RECORD_FILE
                      , LPAD(REPLACE(OU.TAX_OFFICE_CODE, '-', ''), 3, 0) AS TAX_OFFICE_CODE
                      , RPAD(NVL(REPLACE(OU.VAT_NUMBER, '-', ''), ' '), 10, ' ') AS VAT_NUMBER
                    FROM HRM_CORP_MASTER CM
                       , HRM_OPERATING_UNIT OU
                       , ( -- 제출내역.
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
                                             -- 비과세 
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
                                             -- 종전-- 
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
                               /*, (-- 시점 인사내역.
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
                       , ( -- 종전근무지 자료수.
                          SELECT PW.YEAR_YYYY
                               --, T1.OPERATING_UNIT_ID 
                               , COUNT(PW.PERSON_ID) AS PRE_WORKER_COUNT 
                            FROM HRA_YEAR_ADJUSTMENT YA
                              , HRA_PREVIOUS_WORK PW
                              , HRM_PERSON_MASTER PM
                              /*, (-- 시점 인사내역.
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
                          'C'                                           -- 1.자료관리번호.
                        || '20'                                         -- 2.AS DATA_TYPE
                        || RPAD(NVL(B1.TAX_OFFICE_CODE, ' '), 3, ' ')   -- 3.세무서코드.
                        || LPAD(ROW_NUMBER() OVER(PARTITION BY YA.YEAR_YYYY ORDER BY PM.PERSON_NUM), 6, 0)   -- 4.일련번호.
                        || LPAD(NVL(B1.VAT_NUMBER, ' '), 10, ' ')       -- 5.사업자번호.
                        || LPAD(NVL(S_PW.PRE_WORK_COUNT, 0), 2, 0)      -- 6.종(전)근무처 수;
                        || LPAD(NVL(PM.RESIDENT_TYPE, '1'), 1, 0)       -- 7.거주자 구분코드(거주자:1, 비거주자:2);
                        || RPAD(CASE 
                                  WHEN PM.RESIDENT_TYPE = '1' THEN ' '
                                  WHEN SUBSTR(REPLACE(PM.REPRE_NUM, '-', ''), 7, 1) BETWEEN '1' AND '4' THEN ' '  -- 1900, 2000년생.
                                  WHEN SUBSTR(REPLACE(PM.REPRE_NUM, '-', ''), 7, 1) BETWEEN '9' AND '0' THEN ' '  -- 1800년대생..
                                  ELSE NVL(S_HN.ISO_NATION_CODE, ' ')
                                END, 2, ' ')  -- 8.거구지국 코드 : 비거주자만 기록, 거주자는 공란;
                        || LPAD(DECODE(NVL(YA.FOREIGN_FIX_TAX_YN, 'N'), 'Y', 1, 2), 1, 0)  -- 9.외국인단일세율적용(적용:1, 비적용:2);
                        || RPAD(NVL(REPLACE(PM.NAME, ' ', ''), ' '), 30, ' ')  -- 10.성명;
                        || RPAD(CASE
                                  WHEN PM.NATIONALITY_TYPE IS NOT NULL THEN PM.NATIONALITY_TYPE
                                  WHEN SUBSTR(REPLACE(PM.REPRE_NUM, '-', ''), 7, 1) BETWEEN '5' AND '8' THEN '9'
                                  ELSE '1'
                                END, 1, 0)  -- 11.내/외국인 구분코드;
                        || RPAD(NVL(REPLACE(PM.REPRE_NUM, '-', ''), ' '), 13, ' ')  -- 12.주민등록번호;
                        || RPAD(CASE
                                  WHEN PM.NATIONALITY_TYPE = '9' THEN NVL(S_HN.ISO_NATION_CODE, ' ')
                                  WHEN SUBSTR(REPLACE(PM.REPRE_NUM, '-', ''), 7, 1) BETWEEN '5' AND '8' THEN NVL(S_HN.ISO_NATION_CODE, ' ')
                                  ELSE ' '
                                END, 2, ' ')  -- 13.국적코드(외국인인 경우만 기재);
                        || RPAD(NVL(PM.HOUSEHOLD_TYPE, '1'), 1, 0)  -- 14.세대주여부.
                        || RPAD(CASE 
                                  WHEN (PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE > TO_DATE(P_YEAR_YYYY||'-12-31','YYYY-MM-DD')) THEN '1'
                                  ELSE '2' 
                                END, 1, 0)  -- 15.연말정산구분(계속근로: 1, 중도퇴사:2).
                        || RPAD(NVL(B1.VAT_NUMBER, ' '), 10, ' ')  -- 16.주현근무처 사업자등록번호;
                        || RPAD(NVL(A1.CORP_NAME, ' '), 40, ' ')  -- 17.주현근무처 법인명(상호);
                        || RPAD(TO_CHAR(YA.ADJUST_DATE_FR, 'YYYYMMDD'), 8, 0)  -- 18.근무기간 시작연월일;
                        || RPAD(TO_CHAR(YA.ADJUST_DATE_TO, 'YYYYMMDD'), 8, 0)  -- 19.근무기간 종료연월일;
                        || LPAD(0, 8, 0)  -- 20.감면기간 시작연월일;
                        || LPAD(0, 8, 0)  -- 21.감면기간 종료연월일;
                        --> 근무처별 소득명세-주(현)근무처 총급여.
                        || LPAD(NVL(YA.NOW_PAY_TOT_AMT, 0)+ 
                                NVL(YA.INCOME_OUTSIDE_AMT, 0), 11, 0)  -- 22.급여총액;
                        || LPAD(NVL(YA.NOW_BONUS_TOT_AMT, 0), 11, 0) -- 23.상여총액;
                        || LPAD(NVL(YA.NOW_ADD_BONUS_AMT, 0), 11, 0) -- 24.인정상여;
                        || LPAD(NVL(YA.NOW_STOCK_BENE_AMT, 0), 11, 0) -- 25.주식매수선택권행사이익;
                        ----> 2009년 연말정산 수정(우리사주조합인출금 추가);
                        || LPAD(0, 11, 0) -- 26.우리사주조합인출금(계에는 포함하지 않았음);
                        || LPAD(NVL(YA.NOW_OFFICE_RETIRE_OVER_AMT, 0), 11, 0)  -- 27.2013년도 추가 : 임원 퇴직소득금액 한도초과액  
                        || LPAD(0, 22, 0) -- 28.공란;
                        || LPAD(NVL(YA.NOW_PAY_TOT_AMT, 0) +
                                NVL(YA.NOW_BONUS_TOT_AMT, 0) +
                                NVL(YA.NOW_ADD_BONUS_AMT, 0) +
                                NVL(YA.NOW_STOCK_BENE_AMT, 0) + 
                                NVL(YA.INCOME_OUTSIDE_AMT, 0) +
                                NVL(YA.NOW_OFFICE_RETIRE_OVER_AMT, 0), 11, 0) -- 29.급여총액(항목22)+상여총액(항목23)+인정상여(항목24)+ 주식매수선택권행사이익(항목25)+우리사주조합인출금(항목26)+ 임원퇴직소득한도초과액(항목27)
                        --> 주(현)근무처 비과세 소득.
                        -- 2009년 연말정산 수정(주(현)근무처 비과세 소득 변경);
                        || LPAD(NVL(YA.NONTAX_SCH_EDU_AMT, 0), 10, 0) -- 30.비과세-학자금;
                        || LPAD(NVL(YA.NONTAX_MEMBER_AMT, 0), 10, 0) -- 31.비과세-무보수위원수당;
                        || LPAD(NVL(YA.NONTAX_GUARD_AMT, 0), 10, 0) -- 32.비과세-경호/승선수당;
                        || LPAD(NVL(YA.NONTAX_CHILD_AMT, 0), 10, 0) -- 33.비과세-유아/초중등_연구보조/활동비;
                        || LPAD(NVL(YA.NONTAX_HIGH_SCH_AMT, 0), 10, 0) -- 34.비과세-고등교육_연구보조/활동비;
                        || LPAD(NVL(YA.NONTAX_SPECIAL_AMT, 0), 10, 0) -- 35.비과세-특정연구기관육성법_연구보조/활동비;
                        || LPAD(NVL(YA.NONTAX_RESEARCH_AMT, 0), 10, 0) -- 36.비과세-연구기관_연구보조/활동비;
                        || LPAD(NVL(YA.NONTAX_COMPANY_AMT, 0), 10, 0) -- 37.비과세-기업연구소_연구보조/활동비;
                        -- 전호수 : 2012년도 추가 BEGIN --
                        || LPAD(0, 10, 0)  -- 38.비과세 : 보육교사 근무환경개선비.
                        || LPAD(0, 10, 0)  -- 39.비과세 : 사립유치원 수석교사/교사의 인건비.
                        -- END --
                        || LPAD(NVL(YA.NONTAX_COVER_AMT, 0), 10, 0) -- 40.비과세-취재수당;
                        || LPAD(NVL(YA.NONTAX_WILD_AMT, 0), 10, 0) -- 41.비과세-벽지수당;
                        || LPAD(NVL(YA.NONTAX_DISASTER_AMT, 0), 10, 0) -- 42.비과세-재해관련급여;
                        || LPAD(0, 10, 0)  -- 43.2013년도 추가 : 정부/공공기관  지방이전기관 종사자 이주수당; 
                        || LPAD(NVL(YA.NONTAX_OUTS_GOVER_AMT, 0), 10, 0) -- 44.비과세-외국정부등근무자;
                        || LPAD(NVL(YA.NONTAX_OUTS_ARMY_AMT, 0), 10, 0) -- 45.비과세-외국주둔군인등;
                        || LPAD(NVL(YA.NONTAX_OUTS_WORK_1, 0), 10, 0) -- 46.비과세-국외근로(100만원);
                        || LPAD(NVL(YA.NONTAX_OUTS_WORK_2, 0), 10, 0) -- 47.국외근로200만원(300만원);
                        || LPAD(NVL(YA.NONTAX_OUTSIDE_AMT, 0), 10, 0) -- 48.비과세 국외소득;
                        || LPAD(NVL(YA.NONTAX_OT_AMT, 0), 10, 0) -- 49.비과세 야간근로;
                        || LPAD(NVL(YA.NONTAX_BIRTH_AMT, 0), 10, 0) -- 50.비과세 출생/보육수당;
                        || LPAD(0, 10, 0)  -- 51.근로장학금.
                        || LPAD(NVL(YA.NONTAX_STOCK_BENE_AMT, 0), 10, 0) -- 52.비과세-주식매수선택권;
                        || LPAD(NVL(YA.NONTAX_FOR_ENG_AMT, 0), 10, 0) -- 53.비과세-외국인기술자;
                        || LPAD(NVL(YA.NONTAX_EMPL_BENE_AMT_1, 0), 10, 0) -- 54.비과세-우리사주조합인출금(50%);
                        || LPAD(NVL(YA.NONTAX_EMPL_BENE_AMT_2, 0), 10, 0) -- 55.비과세-우리사주조합인출금(75%);
                        || LPAD(0, 10, 0) -- 56.비과세-장기미취업자 중소기업 취업;
                        --|| LPAD(NVL(YA.NONTAX_HOUSE_SUBSIDY_AMT, 0), 10, 0) -- 비과세-주택자금보조금(X);
                        || LPAD(NVL(YA.NONTAX_SEA_RESOURCE_AMT, 0), 10, 0) -- 57.비과세-해저광물자원개발;
                        -- 전호수 추가 : 2012년도 적용 BEGIN --
                        || LPAD(0, 10, 0)  -- 58.전공의수련보조수당.
                        || LPAD(0, 10, 0)  -- 59.중소기업 취업 청년 소득세 감면;
                        || LPAD(0, 10, 0)  -- 60.조세조약상 교직자 감면;
                        --|| LPAD(0, 10, 0) -- 지정비과세;
                        -- 전호수 추가 : 2012년도 적용 END --
                        -- 비과세 계;
                        || LPAD( NVL(YA.NONTAX_OUTSIDE_AMT, 0) + NVL(YA.NONTAX_OT_AMT, 0) +  -- NONTAX_OUTSIDE_AMT : 비과세 국외근로 합계 
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
                                 -- 종전-- 
                                 NVL(YA.PRE_NT_OUTSIDE_AMT, 0) + NVL(YA.PRE_NT_OT_AMT, 0) +  -- NONTAX_OUTSIDE_AMT : 비과세 국외근로 합계  
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
                                --NVL(YA.NONTAX_SEA_RESOURCE_AMT, 0))  -- 해저광물자원개발(감면소득 계로 이동);
                                --NVL(YA.NONTAX_ETC_AMT, 0),
                                , 10, 0)  -- 61.비과세계.
                        || LPAD(NVL(YA.NONTAX_FOR_ENG_AMT, 0) + NVL(YA.NONTAX_SEA_RESOURCE_AMT, 0), 10, 0)    -- 62감면소득계(항목53 + 항목57);
                        --> 정산명세.
                        || LPAD( CASE
                                   WHEN NVL(YA.FOREIGN_FIX_TAX_YN, 'N') = 'N' THEN NVL(YA.INCOME_TOT_AMT, 0)
                                   ELSE (NVL(YA.NOW_PAY_TOT_AMT, 0) + NVL(YA.NOW_BONUS_TOT_AMT, 0) +
                                         NVL(YA.NOW_ADD_BONUS_AMT, 0) + NVL(YA.NOW_STOCK_BENE_AMT, 0) +
                                         NVL(YA.PRE_PAY_TOT_AMT, 0) + NVL(YA.PRE_BONUS_TOT_AMT, 0) +
                                         NVL(YA.PRE_ADD_BONUS_AMT, 0) + NVL(YA.PRE_STOCK_BENE_AMT, 0) +
                                         NVL(YA.INCOME_OUTSIDE_AMT, 0) +
                                         NVL(YA.NOW_EMPLOYEE_STOCK_AMT, 0) + NVL(YA.NOW_OFFICE_RETIRE_OVER_AMT, 0) +
                                         NVL(YA.PRE_EMPLOYEE_STOCK_AMT, 0) + NVL(YA.PRE_OFFICE_RETIRE_OVER_AMT, 0) + 
                                         -- 비과세 
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
                                         -- 종전-- 
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
                                 END, 11, 0) -- 63.총급여;
                        || LPAD(NVL(YA.INCOME_DED_AMT, 0), 10, 0) -- 64.근로소득공제;
                        || LPAD(NVL(YA.INCOME_TOT_AMT, 0) - NVL(YA.INCOME_DED_AMT, 0), 11, 0) -- 65.근로소득금액;
                        --> 기본공제.
                        || LPAD(NVL(YA.PER_DED_AMT, 0), 8, 0) -- 66.본인공제금액;
                        || LPAD(NVL(YA.SPOUSE_DED_AMT, 0), 8, 0) -- 67.배우자공제금액;
                        || LPAD(NVL(YA.SUPP_DED_COUNT, 0), 2, 0) -- 68.부양가족공제인원;
                        || LPAD(NVL(YA.SUPP_DED_AMT, 0), 8, 0) -- 69.부양가족공제금액;
                        --> 추가공제.
                        -- 2009년 BEGIN : 경로우대공제인원 70세이상만 적용;
                        || LPAD(NVL(YA.OLD_DED_COUNT1, 0), 2, 0) -- 70.경로우대공제인원;
                        || LPAD(NVL(YA.OLD_DED_AMT1, 0), 8, 0) -- 71.경로우대공제금액;
                        /*
                        || LPAD(NVL(YA.OLD_DED_COUNT, 0) + NVL(YA.OLD_DED_COUNT1, 0), 2, 0) -- 경로우대공제인원;
                        || LPAD(NVL(YA.OLD_DED_AMT, 0) + NVL(YA.OLD_DED_AMT1, 0), 8, 0) -- 경로우대공제금액;*/
                        -- 2009년 END;
                        || LPAD(NVL(YA.DISABILITY_DED_COUNT, 0), 2, 0) -- 72.장애인공제인원;
                        || LPAD(NVL(YA.DISABILITY_DED_AMT, 0), 8, 0) -- 73.장애인공제금액;
                        || LPAD(NVL(YA.WOMAN_DED_AMT, 0), 8, 0) -- 74.부녀자공제금액;
                        || LPAD(NVL(YA.CHILD_DED_COUNT, 0), 2, 0) -- 75.자녀양육비공제인원;
                        || LPAD(NVL(YA.CHILD_DED_AMT, 0), 8, 0) -- 76.자녀양육비공제금액;
                        || LPAD(NVL(YA.BIRTH_DED_COUNT, 0), 2, 0) -- 77.출산/입양자공제인원;
                        || LPAD(NVL(YA.BIRTH_DED_AMT, 0), 8, 0) --  78.출산/입양자공제금액;
                        || LPAD(NVL(YA.SINGLE_PARENT_DED_AMT, 0), 10, 0) -- 79.2013년도 추가 : 한부모 가족 공제금액;
                        -- LPAD(NVL(YA.PER_ADD_DED_AMT, 0), 8, 0)   PER_ADD_DED_AMT;
                        --> 다자녀추가공제;
                        || LPAD(NVL(YA.MANY_CHILD_DED_COUNT, 0), 2, 0) -- 80.다자녀추가공제인원;
                        || LPAD(NVL(YA.MANY_CHILD_DED_AMT, 0), 8, 0) -- 81.다자녀추가공제금액;
                        -->연금보험료;
                        || LPAD(NVL(YA.NATI_ANNU_AMT, 0), 10, 0) -- 82.국민연금보험료공제;
                        || LPAD(NVL(YA.PUBLIC_INSUR_AMT, 0), 10, 0)  -- 83.기타연금보험료공제_공무원연금;
                        || LPAD(NVL(YA.MARINE_INSUR_AMT, 0), 10, 0)  -- 84.기타연금보험료공제_군인연금;
                        || LPAD(NVL(YA.SCHOOL_STAFF_INSUR_AMT, 0), 10, 0)  -- 85.기타연금보험료공제_사립학교교직원연금;
                        || LPAD(NVL(YA.POST_OFFICE_INSUR_AMT, 0), 10, 0)  -- 86.기타연금보험료공제_별정우체국연금;
                        || LPAD(NVL(YA.SCIENTIST_ANNU_AMT, 0), 10, 0)  -- 87.기타연금보험료공제_과학기술인공제;
                        || LPAD(NVL(YA.RETR_ANNU_AMT, 0), 10, 0)  -- 88.기타연금보험료공제_근로자퇴직급여보장법;
                        || LPAD(NVL(YA.ANNU_BANK_AMT, 0), 10, 0) -- 89.2013년도 수정 : 연금저축소득공제;
                        --> 특별공제.
                        -- 보험료공제금;
                        -- 2009년 연말정산 BEGIN. 보험료공제금 0원 미만인 경우에는 0원 처리;
                        || LPAD(CASE 
                                  WHEN NVL(YA.MEDIC_INSUR_AMT, 0) < 0 THEN 0
                                  ELSE NVL(YA.MEDIC_INSUR_AMT, 0) 
                                END, 10, 0)  -- 90.건강보험료;
                        || LPAD(CASE 
                                  WHEN NVL(YA.HIRE_INSUR_AMT, 0) < 0 THEN 0
                                  ELSE NVL(YA.HIRE_INSUR_AMT, 0) 
                                END, 10, 0)  -- 91.고용보험료;
                        || LPAD(NVL(YA.GUAR_INSUR_AMT, 0), 10, 0)  -- 92.보장보험료 ;
                        || LPAD(NVL(YA.DISABILITY_INSUR_AMT, 0), 10, 0)  -- 93.장애보험료 ;
                        || LPAD(NVL(YA.DISABILITY_MEDIC_AMT, 0), 10, 0)  -- 94.2013년도 수정 : 의료비공제금액-장애인;
                        || LPAD(NVL(YA.ETC_MEDIC_AMT, 0), 10, 0)  -- 95.2013년도 수정 : 의료비공제금액-기타;
                        || LPAD(NVL(YA.DISABILITY_EDUCATION_AMT, 0), 8, 0) -- 96.2013년도 수정 : 교육비공제금액-장애인;
                        || LPAD(NVL(YA.ETC_EDUCATION_AMT, 0), 8, 0) -- 97.2013년도 수정 : 교육비공제금액-기타;
                        || LPAD(NVL(YA.HOUSE_INTER_AMT, 0), 8, 0) -- 98.주택임대차차입금원리금상환공제금액(대출자);
                        || LPAD(NVL(YA.HOUSE_INTER_AMT_ETC, 0), 8, 0)  -- 99.2013년도 수정 : 주택임차차입금원리금상환액(거주자).
                        || LPAD(NVL(YA.HOUSE_MONTHLY_AMT, 0), 8, 0)  -- 100.주택자금_월세액;
                        || LPAD(NVL(YA.LONG_HOUSE_PROF_AMT, 0), 8, 0) -- 101.장기주택저당차입금이자상환공제금액;
                        || LPAD(NVL(YA.LONG_HOUSE_PROF_AMT_1, 0), 8, 0) -- 102.장기주택저당차입금이자상환공제금액(15);
                        || LPAD(NVL(YA.LONG_HOUSE_PROF_AMT_2, 0), 8, 0) -- 103.장기주택저당차입금이자상환공제금액(30);
                        -- 전호수 추가 : 2012년도 연말정산 BEGIN --
                        || LPAD(NVL(YA.LONG_HOUSE_PROF_AMT_3_FIX, 0), 8, 0) -- 104.12년 이후 장기주택저당차입금이자상환공제금액(고정금리);
                        || LPAD(NVL(YA.LONG_HOUSE_PROF_AMT_3_ETC, 0), 8, 0) -- 105.12년 이후 장기주택저당차입금이자상환공제금액(기타);
                        -- 전호수 추가 : 2012년도 연말정산 END --
                        || LPAD(NVL(YA.DONAT_DED_POLI_AMT, 0), 11, 0)  -- 106.2013년도 수정 : 정치자금 기부금;
                        || LPAD(NVL(YA.DONAT_DED_ALL, 0), 11, 0)  -- 107.2013년도 수정 : 법정기부금;
                        || LPAD(NVL(YA.DONAT_DED_30, 0), 11, 0)  -- 108.013년도 수정 : 우리사주조합 기부금;
                        || LPAD(NVL(YA.DONAT_DED_RELIGION_10, 0) + 
                                NVL(YA.DONAT_DED_10, 0), 11, 0)  -- 109.2013년도 수정 : 지정기부금 기부금 합계;
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
                                  NVL(YA.DONAT_AMT, 0), 11, 0) -- 111.계;
                        || LPAD(NVL(YA.STAND_DED_AMT, 0), 8, 0) -- 112.표준공제;
                        || LPAD(NVL(YA.SUBT_DED_AMT, 0), 11, 0) -- 113.차감소득금액; 
                        --> 그 밖의 소득공제.
                        || LPAD(NVL(YA.PERS_ANNU_BANK_AMT, 0), 8, 0) -- 114.개인연금저축소득공제;
                        || LPAD(NVL(YA.SMALL_CORPOR_DED_AMT, 0), 10, 0) -- 115.소기업공제부금소득공제;
                        || LPAD(NVL(YA.HOUSE_APP_DEPOSIT_AMT, 0), 10, 0)  -- 116.가)주택마련저축소득공제-청약저축;
                        || LPAD(NVL(YA.HOUSE_APP_SAVE_AMT, 0), 10, 0) -- 117.나)주택마련저축소득공제-주택청약종합저축;
                        --|| LPAD(NVL(YA.HOUSE_SAVE_AMT, 0), 10, 0)  -- 2013년도 삭제 : 다)장기주택마련저축.
                        || LPAD(NVL(YA.WORKER_HOUSE_SAVE_AMT, 0), 10, 0)  -- 118.라)근로자주택마련저축.
                        || LPAD(NVL(YA.INVES_AMT, 0), 10, 0) -- 119.투자조합출자등소득공제;
                        || LPAD(NVL(YA.CREDIT_AMT, 0), 8, 0) -- 120.신용카드등 소득공제;                        
                        --|| LPAD(CASE
                        --        WHEN NVL(YA.EMPL_STOCK_AMT, 0) < 0 THEN 0
                        --        ELSE 1
                        --      END, 1, 0) -- 우리사주조합소득공제(양수이면 0);
                        || LPAD(NVL(YA.EMPL_STOCK_AMT, 0), 10, 0) -- 121.우리사주조합소득공제(한도 400만원);
                        --|| LPAD(NVL(YA.LONG_STOCK_SAVING_AMT, 0), 10, 0) -- 2013년도 수정(적용 안함) : 장기주식형저축소득공제;
                        -- 2009년 연말정산 추가 BEGIN. 고용유지중소기업근로자소득공제/공란 추가;
                        || LPAD(NVL(YA.HIRE_KEEP_EMPLOY_AMT, 0), 10, 0) -- 122.고용유지중소기업근로자소득공제;
                        || LPAD(NVL(YA.FIX_LEASE_DED_AMT, 0), 10, 0) -- 123.2013년도 추가 : 목돈안드는전세이자상환액공제;
                        -- 2009년 연말정산 추가 END --
                        || LPAD((NVL(YA.PERS_ANNU_BANK_AMT, 0) +
                                NVL(YA.SMALL_CORPOR_DED_AMT, 0) +
                                NVL(YA.HOUSE_APP_DEPOSIT_AMT, 0) +
                                NVL(YA.HOUSE_APP_SAVE_AMT, 0) +
                                NVL(YA.WORKER_HOUSE_SAVE_AMT, 0) +
                                NVL(YA.INVES_AMT, 0) +
                                NVL(YA.CREDIT_AMT, 0) +
                                NVL(YA.EMPL_STOCK_AMT, 0) +
                                NVL(YA.HIRE_KEEP_EMPLOY_AMT, 0) + 
                                NVL(YA.FIX_LEASE_DED_AMT, 0)), 10, 0) -- 124.그밖의 소득공제 계(양수이면 '0'수록);
                        || LPAD(NVL(YA.SP_DED_TOT_AMT, 0), 11, 0) -- 125.특별공제 종합한도 초과액;
                        || LPAD(NVL(YA.TAX_STD_AMT, 0), 11, 0) -- 126.종합소득 과세표준;
                        || LPAD(NVL(YA.COMP_TAX_AMT, 0), 10, 0) -- 127.산출세액;
                        --> 세액감면.
                        || LPAD(NVL(YA.TAX_REDU_IN_LAW_AMT, 0), 10, 0) --128.소득세법;
                        || LPAD(NVL(YA.TAX_REDU_SP_LAW_AMT, 0), 10, 0) -- 129.조세특례제한법;
                        -- 2012년 연말정산 추가 START --
                        || LPAD(0, 10, 0) -- 130.조세특례제한법 : 중소기업 취업 청년 소득세 감면;
                        -- 2012년 연말정산 추가 END --
                        || LPAD(NVL(YA.TAX_REDU_TAX_TREATY, 0), 10, 0) -- 131.조세조약.
                        || LPAD(0, 10, 0) -- 132.공란;
                        || LPAD(NVL(YA.TAX_REDU_IN_LAW_AMT, 0) +
                                NVL(YA.TAX_REDU_SP_LAW_AMT, 0) +
                                NVL(YA.TAX_REDU_TAX_TREATY, 0), 10, 0) -- 133.감면세액계;
                        --> 세액공제.
                        || LPAD(NVL(YA.TAX_DED_INCOME_AMT, 0), 10, 0) -- 134.근로소득세액공제;
                        || LPAD(NVL(YA.TAX_DED_TAXGROUP_AMT, 0), 10, 0) -- 135.납세조합공제;
                        || LPAD(NVL(YA.TAX_DED_HOUSE_DEBT_AMT, 0), 10, 0) -- 136.주택차입금;
                        || LPAD(NVL(YA.TAX_DED_DONAT_POLI_AMT, 0), 10, 0) -- 137.기부정치자금;
                        || LPAD(NVL(YA.TAX_DED_OUTSIDE_PAY_AMT, 0), 10, 0) -- 138.외국납부;
                        || LPAD(0, 10, 0) -- 139.공란;
                        || LPAD(NVL(YA.TAX_DED_INCOME_AMT, 0) +
                                NVL(YA.TAX_DED_TAXGROUP_AMT, 0) +
                                NVL(YA.TAX_DED_HOUSE_DEBT_AMT, 0) +
                                NVL(YA.TAX_DED_DONAT_POLI_AMT, 0) +
                                NVL(YA.TAX_DED_OUTSIDE_PAY_AMT, 0), 10, 0) -- 140.세액공제계;
                        --> 결정세액.
                        || LPAD(NVL(YA.FIX_IN_TAX_AMT, 0), 10, 0) -- 141.소득세(원단위 절사);
                        || LPAD(NVL(YA.FIX_LOCAL_TAX_AMT, 0), 10, 0) -- 142.주민세;
                        || LPAD(NVL(YA.FIX_SP_TAX_AMT, 0), 10, 0) -- 143.농특세;
                        /* -- 전호수 주석 : 합계 없음.
                        || LPAD(TRUNC(NVL(YA.FIX_IN_TAX_AMT, 0), -1) +
                                TRUNC(NVL(YA.FIX_LOCAL_TAX_AMT, 0), -1) +
                                TRUNC(NVL(YA.FIX_SP_TAX_AMT, 0), -1), 10, 0) -- 결정세액 합계;*/ 
                        /* -- 종(전)납부세액 없음.
                        --> 종(전) 납부세액.
                        || LPAD(TRUNC(NVL(HEW1.IN_TAX_AMT, 0), -1), 10, 0) -- 소득세.
                        || LPAD(TRUNC(NVL(HEW1.LOCAL_TAX_AMT, 0), -1), 10, 0) -- 주민세.
                        || LPAD(TRUNC(NVL(HEW1.SP_TAX_AMT, 0), -1), 10, 0) -- 농특세;
                        || LPAD(TRUNC(NVL(HEW1.IN_TAX_AMT, 0), -1) + 
                                TRUNC(NVL(HEW1.LOCAL_TAX_AMT, 0), -1) + 
                                TRUNC(NVL(HEW1.SP_TAX_AMT, 0), -1), 10, 0) -- 종전 납부세액 합계;*/
                        -- 2009년 연말정산 수정(MODIFIED BY YOUNG MIN). "종(현) 납부세액"에서 "기납부세액 - 주(현)근무지"로 명칭 변경;
                        --> 기납부세액 - 주(현)근무지;
                        || LPAD((NVL(YA.PRE_IN_TAX_AMT, 0) - NVL(S_PW.IN_TAX_AMT, 0)), 10, 0) -- 144.소득세.
                        || LPAD((NVL(YA.PRE_LOCAL_TAX_AMT, 0) - NVL(S_PW.LOCAL_TAX_AMT, 0)), 10, 0) --145.주민세.
                        || LPAD((NVL(YA.PRE_SP_TAX_AMT, 0) - NVL(S_PW.SP_TAX_AMT, 0)), 10, 0) -- 146.농특세.
                        /* -- 전호수 주석 : 합계 없음.
                        || LPAD(TRUNC(NVL(YA.PRE_IN_TAX_AMT, 0) - NVL(HEW1.IN_TAX_AMT, 0), -1) +
                                TRUNC(NVL(YA.PRE_LOCAL_TAX_AMT, 0) - NVL(HEW1.LOCAL_TAX_AMT, 0), -1) +
                                TRUNC(NVL(YA.PRE_SP_TAX_AMT, 0) - NVL(HEW1.SP_TAX_AMT, 0), -1), 10, 0) -- 주(현) 납부세액 합계;*/
                        --> 차감징수세액;
                        -- 2009년 연말정산 수정(MODIFIED BY YOUNG MIN). "차감징수세액"추가(10원미만 단수절사);
                        -- 결정세액 - [주(현)근무지 기납부세액 + 종(전)근무지 기납부세액의 합];
                        || LPAD(CASE
                                  WHEN TRUNC((NVL(YA.FIX_IN_TAX_AMT, 0) - NVL(YA.PRE_IN_TAX_AMT, 0)), -1) < 0 THEN 1
                                  ELSE 0
                                END, 1, 0)  -- 147. 0 <= 차감징수세액(소득세) < 1000 인 경우 "0"기재;
                        || LPAD(ABS(TRUNC((NVL(YA.FIX_IN_TAX_AMT, 0) - NVL(YA.PRE_IN_TAX_AMT, 0)), -1)), 10, 0) -- 147.차감소득세.
                        || LPAD(CASE
                                  WHEN TRUNC((NVL(YA.FIX_LOCAL_TAX_AMT, 0) - NVL(YA.PRE_LOCAL_TAX_AMT, 0)), -1) < 0 THEN 1
                                  ELSE 0
                                END, 1, 0)  -- 148. 0 <= 차감징수세액(주민세) < 1000 인 경우 "0"기재;
                        || LPAD(ABS(TRUNC((NVL(YA.FIX_LOCAL_TAX_AMT, 0) - NVL(YA.PRE_LOCAL_TAX_AMT, 0)), -1)), 10, 0) -- 148.차감주민세.
                        || LPAD(CASE
                                  WHEN TRUNC((NVL(YA.FIX_SP_TAX_AMT, 0) - NVL(YA.PRE_SP_TAX_AMT, 0)), -1) < 0 THEN 1
                                  ELSE 0
                                END, 1, 0)  -- 149. 0 <= 차감징수세액(농특세) < 1000 인 경우 "0"기재;
                        || LPAD(ABS(TRUNC((NVL(YA.FIX_SP_TAX_AMT, 0) - NVL(YA.PRE_SP_TAX_AMT, 0)), -1)), 10, 0)  -- 149.차감 농특세.                      
                        --> 150.공백.
                        || LPAD(' ', 12, ' ') AS RECORD_FILE
                        , NVL(YA.MEDIC_INSUR_AMT, 0) + NVL(YA.HIRE_INSUR_AMT, 0) AS MEDIC_INSUR_AMT  -- 'E'레코드에서 사용(국세청제공 보험료 포함 예정).
                        , NVL(YA.TAX_DED_DONAT_POLI_AMT, 0) AS TAX_DED_DONAT_POLI_AMT 
                        , PM.PERSON_ID
                        , REPLACE(PM.REPRE_NUM, '-') AS REPRE_NUM
                        , ROW_NUMBER() OVER(PARTITION BY YA.YEAR_YYYY ORDER BY PM.PERSON_NUM) AS C_SEQ_NO
                        , PM.JOIN_DATE
                        , PM.FOREIGN_TAX_YN
                      FROM HRM_PERSON_MASTER  PM
                        , HRA_YEAR_ADJUSTMENT YA
                        /*, (-- 시점 인사내역.
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
                        , ( -- 종전근무처 정보.
                            SELECT PW.YEAR_YYYY
                                , PW.PERSON_ID
                                , COUNT(PW.PERSON_ID) AS PRE_WORK_COUNT
                                , SUM(PW.IN_TAX_AMT) AS IN_TAX_AMT
                                , SUM(PW.LOCAL_TAX_AMT) AS LOCAL_TAX_AMT
                                , SUM(PW.SP_TAX_AMT) AS SP_TAX_AMT
                              FROM HRA_PREVIOUS_WORK PW
                                , HRM_PERSON_MASTER  PM
                                /*, (-- 시점 인사내역.
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
            --> 종(전)근무처 레코드 <--
            FOR D1 IN ( SELECT -- 자료관리번호;
                              'D' -- 1.레코드 구분;
                            || '20' -- 2.자료구분;
                            || RPAD(B1.TAX_OFFICE_CODE, 3, ' ') -- 3.세무서코드;
                            || LPAD(C1.C_SEQ_NO, 6, '0') -- 4.C레코드의 일련번호.
                            -- 원천징수의무자;
                            || RPAD(B1.VAT_NUMBER, 10, ' ') -- 5.사업자번호.
                            || RPAD(' ', 50, ' ') -- 6.공란;
                            -- 소득자;
                            || RPAD(NVL(C1.REPRE_NUM, ' '), 13, ' ') -- 7.주민번호.
                            -- 근무처별 소득명세 - 종(전)근무처;
                            || RPAD('2',1,' ') -- 8.납세조합구분;
                            || RPAD(REPLACE(PW.COMPANY_NAME, ' ' , ''), 40, ' ') -- 9.법인명(상호);
                            || RPAD(REPLACE(PW.COMPANY_NUM, '-', ''), 10, ' ') -- 10.사업자등록번호;
                            -- 2009년 연말정산 수정. 근무기간/감면기간 시작/종료연월일 추가;
                            || RPAD(CASE -- 11.근무기간 시작연월일;
                                      WHEN PW.JOIN_DATE > TO_DATE(P_YEAR_YYYY || '-01-01', 'YYYY-MM-DD') THEN TO_CHAR(PW.JOIN_DATE, 'YYYYMMDD')
                                      ELSE P_YEAR_YYYY || '0101'
                                    END, 8, '0')
                            || RPAD(TO_CHAR(NVL(PW.RETR_DATE, C1.JOIN_DATE -1), 'YYYYMMDD'), 8, '0') -- 12.근무기간 종료연월일;
                            || LPAD('0', 8, '0') -- 13.감면기간 시작연월일;
                            || LPAD('0', 8, '0') -- 14.감면기간 종료연월일;
                            || LPAD(NVL(PW.PAY_TOTAL_AMT, 0), 11, 0) -- 15.급여총액;
                            || LPAD(NVL(PW.BONUS_TOTAL_AMT, 0), 11, 0) -- 16.상여총액;
                            || LPAD(NVL(PW.ADD_BONUS_AMT, 0), 11, 0) -- 17.인정상여;
                            || LPAD(NVL(PW.STOCK_BENE_AMT, 0), 11, 0) -- 18.주식매수선택권행사이익;
                            -- 2009년 연말정산 수정(MODIFIED BY YOUNG MIN). 우리사주조합인출금 추가;
                            || LPAD(0, 11, 0)  -- 19.우리사주조합인출금(계에는 포함하지 않았음);
                            || LPAD(NVL(PW.OFFICERS_RETIRE_OVER_AMT, 0), 11, 0)  -- 20. 2013년 추가 : 임원 퇴직소득금액 한도초과액 
                            || LPAD(0, 22, 0)  -- 21.공란.
                            || LPAD(NVL(PW.PAY_TOTAL_AMT, 0) +
                                    NVL(PW.BONUS_TOTAL_AMT, 0) +
                                    NVL(PW.ADD_BONUS_AMT, 0) +
                                    NVL(PW.STOCK_BENE_AMT, 0) +
                                    NVL(PW.OFFICERS_RETIRE_OVER_AMT, 0), 11, 0)  -- 22.계.
                            --> 종(전)근무처 비과세 소득.
                            -- 2009년 연말정산 수정(MODIFIED BY YOUNG MIN).종(전)근무처 비과세 소득 전면변경;
                            || LPAD(NVL(PW.NT_SCH_EDU_AMT, 0), 10, 0) -- 23.비과세-학자금;
                            || LPAD(NVL(PW.NT_MEMBER_AMT, 0), 10, 0) -- 24.비과세-무보수위원수당;
                            || LPAD(NVL(PW.NT_GUARD_AMT, 0), 10, 0) -- 25.비과세-경호/승선수당;
                            || LPAD(NVL(PW.NT_CHILD_AMT, 0), 10, 0) -- 26.비과세-유아/초중등_연구보조/활동비;
                            || LPAD(NVL(PW.NT_HIGH_SCH_AMT, 0), 10, 0) -- 27.비과세-고등교육_연구보조/활동비;
                            || LPAD(NVL(PW.NT_SPECIAL_AMT, 0), 10, 0) -- 28.비과세-특정연구기관육성법_연구보조/활동비;
                            || LPAD(NVL(PW.NT_RESEARCH_AMT, 0), 10, 0) -- 29.비과세-연구기관_연구보조/활동비;
                            || LPAD(NVL(PW.NT_COMPANY_AMT, 0), 10, 0) -- 30.비과세-기업연구소_연구보조/활동비;
                            -- 2012년 연말정산 추가 START --
                            || LPAD(0, 10, 0) -- 31.비과세-보육교사 근무환경개선비;
                            || LPAD(0, 10, 0) -- 32.비과세-사립유치원 수석교사/교사의 인건비;
                            -- 2012년 연말정산 추가 END --
                            || LPAD(NVL(PW.NT_COVER_AMT, 0), 10, 0) -- 33.비과세-취재수당;
                            || LPAD(NVL(PW.NT_WILD_AMT, 0), 10, 0) -- 34.비과세-벽지수당;
                            || LPAD(NVL(PW.NT_DISASTER_AMT, 0), 10, 0) -- 35.비과세-재해관련급여;
                            || LPAD(0, 10, 0) -- 36.비과세-정부공공기관 지방이전기관 종사자 이주수당;
                            || LPAD(NVL(PW.NT_OUTSIDE_GOVER_AMT, 0), 10, 0) -- 37.비과세-외국정부등근무자;
                            || LPAD(NVL(PW.NT_OUTSIDE_ARMY_AMT, 0), 10, 0) -- 38.비과세-외국주둔군인등;
                            || LPAD(NVL(PW.NT_OUTSIDE_WORK1, 0), 10, 0) -- 39.비과세-국외근로(100만원);
                            || LPAD(NVL(PW.NT_OUTSIDE_WORK2, 0), 10, 0) -- 40.비과세-국외근로(300만원);
                            || LPAD(NVL(PW.NT_OUTSIDE_AMT, 0), 10, 0) -- 41.비과세 국외소득;
                            || LPAD(NVL(PW.NT_OT_AMT, 0), 10, 0) -- 42.비과세 야간근로;
                            || LPAD(NVL(PW.NT_BIRTH_AMT, 0), 10, 0) -- 43.비과세 출생/보육수당;
                            || LPAD(0, 10, 0) -- 44.근로장학금.
                            || LPAD(NVL(PW.NT_STOCK_BENE_AMT, 0), 10, 0) -- 45.비과세-주식매수선택권;
                            || LPAD(NVL(PW.NT_FOREIGNER_AMT, 0), 10, 0) -- 46.비과세-외국인기술자;
                            --|| LPAD(NVL(PW.NONTAX_FOREIGNER_AMT, 0), 10, 0) -- 비과세 외국인 근로자;
                            --|| LPAD(NVL(PW.NONTAX_EMPL_STOCK_AMT, 0), 10, 0) --  비과세-우리사주조합배정;
                            || LPAD(NVL(PW.NT_EMPL_STOCK_AMT, 0), 10, 0) -- 47.비과세-우리사주조합인출금(50%);
                            || LPAD(NVL(PW.NT_EMPL_BENE_AMT2, 0), 10, 0) -- 48.비과세-우리사주조합인출금(75%);
                            || LPAD(0, 10, 0)                                  -- 49.비과세-장기미취업자 중소기업 취업;
                            --|| LPAD(NVL(PW.NONTAX_HOUSE_SUBSIDY_AMT, 0), 10, 0) -- 비과세-주택자금보조금;
                            || LPAD(NVL(PW.NT_SEA_RESOURCE_AMT, 0), 10, 0) -- 50.비과세-해저광물자원개발;
                            -- 2012년 연말정산 추가 START --
                            || LPAD(0, 10, 0) -- 51.비과세-전공의 수련보조수당;
                            || LPAD(0, 10, 0) -- 52.비과세-중소기업 취업청년 소득세 감면;
                            || LPAD(0, 10, 0) -- 53.비과세-조세조약상 교직자 감면;
                            -- 2012년 연말정산 추가 END --
                            --|| LPAD(0, 10, 0)  -- 지정비과세;
                            --|| LPAD(NVL(PW.NONTAX_ETC_AMT, 0), 10, 0) --AS NONTAX_ETC_AMT     -- 비과세 기타;
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
                                    --NVL(PW.NONTAX_FOR_ENG_AMT, 0) +                           -- 감면소득 계로 이동;
                                    --NVL(PW.NONTAX_FOREIGNER_AMT, 0) +
                                    --NVL(PW.NONTAX_EMPL_STOCK_AMT, 0) +
                                    NVL(PW.NT_EMPL_BENE_AMT1, 0) +
                                    NVL(PW.NT_EMPL_BENE_AMT2, 0),
                                    --NVL(PW.NONTAX_HOUSE_SUBSIDY_AMT, 0) +
                                    --NVL(PW.NONTAX_SEA_RESOURCE_AMT, 0) +                      -- 감면소득 계로 이동;
                                    --NVL(PW.NONTAX_ETC_AMT, 0),
                                    10, 0)  -- 54.비과세 계;
                            || LPAD(NVL(PW.NT_FOREIGNER_AMT, 0) +
                                    NVL(PW.NT_SEA_RESOURCE_AMT, 0), 10, 0)  -- 55.감면소득 계;
                            -- 기납부세액 - 종(전)근무지;
                            || LPAD(NVL(PW.IN_TAX_AMT, 0), 10, 0)  -- 56. 기납부 소득세 
                            || LPAD(NVL(PW.LOCAL_TAX_AMT, 0), 10, 0)  -- 57. 기납부 지방소득세 
                            || LPAD(NVL(PW.SP_TAX_AMT, 0), 10, 0)  -- 58.기납부 농특세 
                            /*-- 전호수 주석 : 2011년 없어짐.
                            || LPAD(NVL(PW.IN_TAX_AMT, 0) +
                                    NVL(PW.LOCAL_TAX_AMT, 0) +
                                    NVL(PW.SP_TAX_AMT, 0), 10, 0)*/
                            -- || LPAD(NVL(PW.PAY_TOTAL_AMT, 0) + NVL(PW.BONUS_TOTAL_AMT, 0) + NVL(PW.ADD_BONUS_AMT, 0) + NVL(PW.STOCK_BENE_AMT, 0),11, 0) --AS PAY_SUM_AMT                       -- 계;
                            || LPAD(ROW_NUMBER() OVER(PARTITION BY PW.PERSON_ID ORDER BY PW.SEQ_NUM), 2, 0) -- 59.종(전)근무처 일련번호;
                            -- 60.공란 
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
--E1 부양가족 명세 ----------------------------------------------------------------------------
-- 외국인 단일세율이 아닐경우만 적용.
          IF C1.FOREIGN_TAX_YN = 'N' THEN
            V_RECORD_FILE := NULL;
            V_SEQ_NO    := 0;
            V_RECORD_COUNT := 0;
            FOR E1 IN ( SELECT 
                              'E' -- 1.RECORD_TYPE
                            || '20' --2. DATA_TYPE
                            || RPAD(NVL(B1.TAX_OFFICE_CODE, ' '), 3, ' ') -- 3.세무서코드.
                            || LPAD(NVL(C1.C_SEQ_NO, 0), 6, 0)  -- 4.C레코드의 일련번호.
                            || RPAD(NVL(B1.VAT_NUMBER, ' '), 10, ' ') -- 5.사업자번호.
                            || RPAD(NVL(C1.REPRE_NUM, ' '), 13, ' ') AS RECORD_HEADER -- 6.주민번호.
                            --> 소득공제명세 인적사항.
                            , RPAD(CASE
                                     WHEN NVL(SF.BASE_LIVING_YN, 'N') = 'Y' THEN '7'  -- 2013년도 추가 - 기초수급자 
                                     ELSE NVL(SF.RELATION_CODE, ' ')
                                   END, 1, ' ') -- 7.관계;
                            || RPAD(CASE
                                      WHEN SUBSTR(REPLACE(SF.REPRE_NUM, '-', ''), 7, 1) BETWEEN '5' AND '8' THEN '9'
                                      ELSE '1'
                                    END, 1, ' ') -- 8.내/외국인 구분 코드;
                            || RPAD(NVL(SF.FAMILY_NAME, ' '), 20, ' ') -- 9.성명;
                            || RPAD(NVL(REPLACE(SF.REPRE_NUM, '-', ''), ' ') , 13, ' ') -- 10.주민번호;
                            || DECODE(SF.BASE_YN, 'Y', '1', ' ') -- 11.기본공제;
                            || CASE 
                                 WHEN NVL(SF.BASE_YN, 'N') = 'Y' AND NVL(SF.DISABILITY_YN, 'N') = 'Y' THEN NVL(SF.DISABILITY_CODE, ' ')
                                 ELSE ' '
                               END  -- 12.장애인공제;
                            || DECODE(SF.CHILD_YN, 'Y', '1', ' ') -- 13.자녀양육비공제;
                            || DECODE(SF.WOMAN_YN, 'Y', '1', ' ') -- 14.부녀자공제;
                            -- 2009년 연말정산 수정(MODIFIED BY YOUNG MIN).경로우대 만70세이상으로 변경;
                            || CASE
                                 --WHEN SF.OLD_YN = 'Y' THEN '1'
                                 WHEN SF.OLD1_YN = 'Y' THEN '1'
                                 ELSE ' '
                               END -- 15.경로우대공제;
                            -- 2009년 연말정산 수정(MODIFIED BY YOUNG MIN).출산입양자공제추가;
                            || DECODE(SF.BIRTH_YN, 'Y', '1', ' ') -- 16.출산입양자공제.
                            || DECODE(SF.SINGLE_PARENT_DED_YN, 'Y', '1', ' ') -- 17.한부모1 
                            /*-- 2009년 연말정산 수정(MODIFIED BY YOUNG MIN).다자녀추가공제 폐지;
                            || CASE
                                 WHEN SF.BASE_YN = 'Y' AND C1.MANY_CHILD_DED_AMT <> 0 AND SF.RELATION_CODE = '4' THEN '1'
                                 ELSE ' '
                               END -- 다자녀추가공제;*/
                            --> 국세청 자료.
                            -- 2009년 연말정산 수정(MODIFIED BY YOUNG MIN).국세청자료 공제금액이 음수일 경우 0으로 표기;
                            || LPAD((CASE
                                       WHEN DECODE(SF.RELATION_CODE, 0, NVL(C1.MEDIC_INSUR_AMT, 0), 0) + 
                                            NVL(SF.INSURE_AMT, 0) + NVL(SF.DISABILITY_INSURE_AMT, 0) < 0 THEN 0
                                       ELSE DECODE(SF.RELATION_CODE, 0, NVL(C1.MEDIC_INSUR_AMT, 0), 0) + 
                                            NVL(SF.INSURE_AMT, 0) + NVL(SF.DISABILITY_INSURE_AMT, 0)
                                     END), 10, 0) -- 18.보험료(본인은 건강보험료 포함);
                            || LPAD(NVL(SF.MEDICAL_AMT, 0), 10, 0) -- 19.의료비;
                            || LPAD(NVL(SF.EDUCATION_AMT, 0), 10, 0) -- 20.교육비;
                            || LPAD(NVL(SF.CREDIT_AMT, 0), 10, 0) -- 21.신용카드등;
                            || LPAD(NVL(SF.CHECK_CREDIT_AMT , 0), 10, 0) -- 22.직불카드;
                            || LPAD(NVL(SF.CASH_AMT, 0) + NVL(SF.ACADE_GIRO_AMT, 0), 10, 0) -- 23.현금영수증;
                            --2012년 연말정산 추가 START --
                            || LPAD(NVL(SF.TRAD_MARKET_AMT, 0), 10, 0) -- 24.전통시장사용액;
                            || LPAD(NVL(SF.PUBLIC_TRANSIT_AMT, 0), 10, 0) -- 25.대중교통이용액1;
                            --2012년 연말정산 추가 END --
                            || LPAD(NVL(SF.DONAT_ALL, 0) +
                                    NVL(SF.DONAT_50P, 0) +
                                    NVL(SF.DONAT_30P, 0) +
                                    NVL(SF.DONAT_10P, 0) +
                                    NVL(SF.DONAT_10P_RELIGION, 0), 13, 0)  -- 26.기부금.
                            -->국세청자료 이외.
                            || LPAD(NVL(SF.ETC_INSURE_AMT, 0), 10, 0) -- 27.국세청제공외의 보험료;
                            || LPAD(NVL(SF.ETC_MEDICAL_AMT, 0), 10, 0) -- 28.국세청제공외의 의료비;
                            || LPAD(NVL(SF.ETC_EDUCATION_AMT, 0), 10, 0) -- 29.국세청제공외의 교육비;
                            || LPAD(NVL(SF.ETC_CREDIT_AMT, 0) + NVL(SF.ETC_ACADE_GIRO_AMT, 0), 10, 0) -- 30.국세청제공외의 신용카드;
                            || LPAD(NVL(SF.ETC_CHECK_CREDIT_AMT, 0), 10, 0) -- 31.국세청제공외의 직불카드;
                            --2012년 연말정산 추가 START --
                            || LPAD(NVL(SF.ETC_TRAD_MARKET_AMT, 0), 10, 0) -- 32.전통시장사용액;
                            || LPAD(NVL(SF.ETC_PUBLIC_TRANSIT_AMT, 0), 10, 0)  -- 33. 대중교통이용액;
                            --2012년 연말정산 추가 END --
                            || LPAD(NVL(SF.ETC_DONAT_ALL, 0) +
                                    NVL(SF.ETC_DONAT_50P, 0) +
                                    NVL(SF.ETC_DONAT_30P, 0) +
                                    NVL(SF.ETC_DONAT_10P, 0) +
                                    NVL(SF.ETC_DONAT_10P_RELIGION, 0), 13, 0) AS RECORD_LINE -- 34.국세청제공외의 기부금;
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
              --> 부양가족수 5인 이상일 경우.
              IF V_E_REC_STD <= V_RECORD_COUNT THEN
                V_SEQ_NO := NVL(V_SEQ_NO, 0) + 1;  -- 부양가족 생성 일련번호.
                V_RECORD_FILE := V_RECORD_FILE 
                                 || LPAD(NVL(V_SEQ_NO, 1), 2, 0)  -- 일련번호.
                                 || RPAD(' ', 273, ' ');  -- 공란.
                
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
                V_RECORD_FILE := V_RECORD_FILE || RPAD(' ', 218, ' ');  -- 소득공제 명세서 부양가족 길이.
              END LOOP E1S;
              IF V_RECORD_FILE IS NOT NULL THEN
                V_SEQ_NO := NVL(V_SEQ_NO, 0) + 1;  -- 부양가족 생성 일련번호.
                V_RECORD_FILE := V_RECORD_FILE 
                                 || LPAD(NVL(V_SEQ_NO, 1), 2, 0)  -- 일련번호.
                                 || RPAD(' ', 273, ' ');  -- 공란.
                                 
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

--F1 연금/저축등 소득공제 명세 레코드 -----------------------------------------------------------------
            V_RECORD_FILE := NULL;
            V_SEQ_NO    := 0;
            V_RECORD_COUNT := 0;
            FOR F1 IN ( SELECT 'F' --1.RECORD_TYPE
                            || '20' --2. DATA_TYPE
                            || RPAD(NVL(B1.TAX_OFFICE_CODE, ' '), 3, ' ') -- 3.세무서코드.
                            || LPAD(C1.C_SEQ_NO, 6, 0) -- 4.C레코드의 일련번호.
                            || RPAD(NVL(B1.VAT_NUMBER, ' '), 10, ' ') -- 5.사업자번호.
                            || RPAD(NVL(C1.REPRE_NUM, ' '), 13, ' ') AS RECORD_HEADER -- 6.주민번호.
                            , LPAD(NVL(SI.SAVING_TYPE, ' '), 2, '0')  -- 7.소득공제구분;
                            || RPAD(SI.BANK_CODE, 3, ' ') -- 8.금융기관 코드수록;
                            || RPAD(YB.YEAR_BANK_NAME, 30, ' ') -- 9.금융기관 상호수록;
                            || RPAD(SI.ACCOUNT_NUM, 20, ' ') -- 10.계좌번호;
                            || LPAD(DECODE(SI.SAVING_TYPE, '41', CASE WHEN 3 < SI.SAVING_COUNT THEN 3 ELSE SI.SAVING_COUNT END , '0'), 2, 0) -- 11.납입연차-장기주식형저축만 해당;
                            || LPAD(SI.SAVING_AMOUNT, 10, 0) -- 12.불입금액;
                            || LPAD(SI.SAVING_DED_AMOUNT, 10, 0) AS RECORD_LINE               -- 13.공제금액;
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
              --> 연금저축등 명세서 15개 이상일 경우.
              IF V_F_REC_STD <= V_RECORD_COUNT THEN
                V_SEQ_NO := NVL(V_SEQ_NO, 0) + 1;  -- 연금저축 생성 일련번호.
                V_RECORD_FILE := V_RECORD_FILE || RPAD(' ', 210, ' ');  -- 공란.
                
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
                V_SEQ_NO := NVL(V_SEQ_NO, 0) + 1;  -- 연금저축 생성 일련번호.
                V_RECORD_FILE := V_RECORD_FILE || RPAD(' ', 210, ' ');  -- 연금저축  소득공제명세 순수 길이 => 공란.
                
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
--G1 월세/거주자간 주택임차차입금 원리금 상환액 소득공제명세서 레코드 --------------------
            V_REC_TEMP_1 := RPAD(' ', 20, ' ') ||  -- 임대인 성명
                            RPAD(' ', 13, ' ') || -- 주민등록번호(사업자번호) 
                            RPAD(' ', 100, ' ') ||  --  임대차계약서상 주소지 
                            LPAD(0, 8, 0) ||  -- 임대차계약기간 시작 
                            LPAD(0, 8, 0) ||  -- 임대차계약기간 종료 
                            LPAD(0, 10, 0) ||  -- 월세액 
                            LPAD(0, 10, 0);
            V_REC_TEMP_2 := RPAD(' ', 20, ' ') ||  --    -- 대주성명 
                            RPAD(' ', 13, ' ') || -- 대주 주민번호 
                            LPAD(0, 8, 0) ||  -- 금전소비대차 계약기간 시작 
                            LPAD(0, 8, 0) ||  -- 금전소비대차 계약기간 종료 
                            LPAD(0, 4, 0) ||  -- 차입금 이자율 
                            LPAD(0, 10, 0) ||  -- 원리금 상환액계 
                            LPAD(0, 10, 0) ||  -- 원금 
                            LPAD(0, 10, 0) ||  -- 이자 
                            LPAD(0, 10, 0) ||  -- 공제금액 
                            RPAD(' ', 20, ' ') ||  -- 임대인 성명
                            RPAD(' ', 13, ' ') || -- 주민등록번호(사업자번호) 
                            RPAD(' ', 100, ' ') ||  --  임대차계약서상 주소지 
                            LPAD(0, 8, 0) ||  -- 임대차계약기간 시작 
                            LPAD(0, 8, 0) ||  -- 임대차계약기간 종료 
                            LPAD(0, 10, 0);
            V_RECORD_FILE := NULL;
            V_SEQ_NO    := 0;
            V_RECORD_COUNT := 0;
            FOR G1 IN ( SELECT 'G' --1.RECORD_TYPE
                            || '20' --2. DATA_TYPE
                            || RPAD(NVL(B1.TAX_OFFICE_CODE, ' '), 3, ' ') -- 3.세무서코드.
                            || LPAD(C1.C_SEQ_NO, 6, 0) -- 4.C레코드의 일련번호.
                            || RPAD(NVL(B1.VAT_NUMBER, ' '), 10, ' ') -- 5.사업자번호.
                            || RPAD(NVL(C1.REPRE_NUM, ' '), 13, ' ') AS RECORD_HEADER -- 6.주민번호.
                            
                             , MAX(HL.HOUSE_LEASE_INFO_10) AS HOUSE_LEASE_INFO_10
                             , MAX(HL.HOUSE_LEASE_INFO_20) AS HOUSE_LEASE_INFO_20
                          FROM (SELECT ROWNUM AS ROW_NUM 
                                     , RPAD(NVL(HLI.LESSOR_NAME, ' '), 20, ' ') ||  -- 임대인 성명
                                       RPAD(NVL(REPLACE(HLI.LESSOR_REPRE_NUM, '-', ''), ' '), 13, ' ') || -- 주민등록번호(사업자번호) 
                                       RPAD(NVL(HLI.LEASE_ADDR1, ' ') || ' ' || NVL(HLI.LEASE_ADDR2, ' '), 100, ' ') ||  --  임대차계약서상 주소지 
                                       LPAD(NVL(TO_CHAR(HLI.LEASE_TERM_FR, 'YYYYMMDD'), '0'), 8, 0) ||  -- 임대차계약기간 시작 
                                       LPAD(NVL(TO_CHAR(HLI.LEASE_TERM_TO, 'YYYYMMDD'), '0'), 8, 0) ||  -- 임대차계약기간 종료 
                                       LPAD(NVL(HLI.MONTLY_LEASE_AMT, 0), 10, 0) ||  -- 월세액 
                                       LPAD(NVL(HLI.HOUSE_DED_AMT, 0), 10, 0) AS HOUSE_LEASE_INFO_10
                                     , NULL AS HOUSE_LEASE_INFO_20
                                  FROM HRA_HOUSE_LEASE_INFO HLI
                                WHERE HLI.YEAR_YYYY         = P_YEAR_YYYY
                                  AND HLI.PERSON_ID         = C1.PERSON_ID
                                  AND HLI.SOB_ID            = P_SOB_ID
                                  AND HLI.ORG_ID            = P_ORG_ID
                                  AND HLI.HOUSE_LEASE_TYPE  = '10'  -- 월세  
                                  AND HLI.HOUSE_DED_AMT     != 0    -- 공제금액 있는것만 처리 
                                UNION ALL
                                SELECT ROWNUM AS ROW_NUM 
                                     , NULL AS HOUSE_LEASE_INFO_10
                                     , RPAD(NVL(HLI.LOANER_NAME, ' '), 20, ' ') ||  --    -- 대주성명 
                                       RPAD(NVL(REPLACE(HLI.LOANER_REPRE_NUM, '-', ''), ' '), 13, ' ') || -- 대주 주민번호 
                                       LPAD(NVL(TO_CHAR(HLI.LOAN_TERM_FR, 'YYYYMMDD'), '0'), 8, 0) ||  -- 금전소비대차 계약기간 시작 
                                       LPAD(NVL(TO_CHAR(HLI.LOAN_TERM_TO, 'YYYYMMDD'), '0'), 8, 0) ||  -- 금전소비대차 계약기간 종료 
                                       LPAD(NVL(HLI.LOAN_INTEREST_RATE, 0), 4, 0) ||  -- 차입금 이자율 
                                       LPAD((NVL(HLI.LOAN_AMT, 0) + NVL(HLI.LOAN_INTEREST_AMT, 0)), 10, 0) ||  -- 원리금 상환액계 
                                       LPAD(NVL(HLI.LOAN_AMT, 0), 10, 0) ||  -- 원금 
                                       LPAD(NVL(HLI.LOAN_INTEREST_AMT, 0), 10, 0) ||  -- 이자 
                                       LPAD(NVL(HLI.HOUSE_DED_AMT, 0), 10, 0) ||  -- 공제금액 
                                       RPAD(NVL(HLI.LESSOR_NAME, ' '), 20, ' ') ||  -- 임대인 성명
                                       RPAD(NVL(REPLACE(HLI.LESSOR_REPRE_NUM, '-', ''), ' '), 13, ' ') || -- 주민등록번호(사업자번호) 
                                       RPAD(NVL(HLI.LEASE_ADDR1, ' ') || ' ' || NVL(HLI.LEASE_ADDR2, ' '), 100, ' ') ||  --  임대차계약서상 주소지 
                                       LPAD(NVL(TO_CHAR(HLI.LEASE_TERM_FR, 'YYYYMMDD'), '0'), 8, 0) ||  -- 임대차계약기간 시작 
                                       LPAD(NVL(TO_CHAR(HLI.LEASE_TERM_TO, 'YYYYMMDD'), '0'), 8, 0) ||  -- 임대차계약기간 종료 
                                       LPAD(NVL(HLI.DEPOSIT_AMT, 0), 10, 0) AS HOUSE_LEASE_INFO_20  -- 전세보증금            
                                  FROM HRA_HOUSE_LEASE_INFO HLI
                                WHERE HLI.YEAR_YYYY         = P_YEAR_YYYY
                                  AND HLI.PERSON_ID         = C1.PERSON_ID
                                  AND HLI.SOB_ID            = P_SOB_ID
                                  AND HLI.ORG_ID            = P_ORG_ID
                                  AND HLI.HOUSE_LEASE_TYPE  = '20'  -- 거주자 주택임차차입원리금 
                               ) HL
                        GROUP BY HL.ROW_NUM
                        ORDER BY HL.ROW_NUM
                        )
            LOOP
              V_RECORD_COUNT := NVL(V_RECORD_COUNT, 0) + 1;
              IF V_RECORD_COUNT = 1 THEN
                V_RECORD_FILE := G1.RECORD_HEADER;
                -- 월세  
                IF G1.HOUSE_LEASE_INFO_10 IS NULL THEN
                  V_RECORD_FILE := V_RECORD_FILE || V_REC_TEMP_1;
                ELSE
                  V_RECORD_FILE := V_RECORD_FILE || G1.HOUSE_LEASE_INFO_10;
                END IF;
                -- 거주자간 주택임차차입금 
                IF G1.HOUSE_LEASE_INFO_20 IS NULL THEN
                  V_RECORD_FILE := V_RECORD_FILE || V_REC_TEMP_2;
                ELSE
                  V_RECORD_FILE := V_RECORD_FILE || G1.HOUSE_LEASE_INFO_20;
                END IF;
              ELSE
                -- 월세  
                IF G1.HOUSE_LEASE_INFO_10 IS NULL THEN
                  V_RECORD_FILE := V_RECORD_FILE || V_REC_TEMP_1;
                ELSE
                  V_RECORD_FILE := V_RECORD_FILE || G1.HOUSE_LEASE_INFO_10;
                END IF;
                -- 거주자간 주택임차차입금 
                IF G1.HOUSE_LEASE_INFO_20 IS NULL THEN
                  V_RECORD_FILE := V_RECORD_FILE || V_REC_TEMP_2;
                ELSE
                  V_RECORD_FILE := V_RECORD_FILE || G1.HOUSE_LEASE_INFO_20;
                END IF;
              END IF;
              --> 월세/거주자간 주택임차차입금 원리금 명세서 3개 이상일 경우.
              IF V_G_REC_STD <= V_RECORD_COUNT THEN
                V_SEQ_NO := NVL(V_SEQ_NO, 0) + 1;  -- 월세/거주자간 주택임차차입금 원리금 생성 일련번호.
                V_RECORD_FILE := V_RECORD_FILE || LPAD(V_SEQ_NO, 2, 0);  -- 일련번호 
                V_RECORD_FILE := V_RECORD_FILE || RPAD(' ', 100, ' ');  -- 공란.
                
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
                V_SEQ_NO := NVL(V_SEQ_NO, 0) + 1;  -- 월세/거주자간 주택임차차입금 원리금 생성 일련번호.
                V_RECORD_FILE := V_RECORD_FILE || LPAD(V_SEQ_NO, 2, 0);  -- 일련번호 
                V_RECORD_FILE := V_RECORD_FILE || RPAD(' ', 100, ' ');  -- 공란.

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
          END IF;  -- 외국인 단일세율 적용 안할경우만 적용.
          END LOOP C1;    
        END LOOP B1;
    END LOOP A1;
  END SET_YEAR_ADJUST_FILE_2013;            

-------------------------------------------------------------------------------
-- 2013년도 의료비 파일생성.
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
      RAISE_APPLICATION_ERROR(-20001, 'Error - 사업장 정보를 찾을수 없습니다. 확인하세요');
      RETURN;
    END;
    FOR A1 IN ( SELECT 'A'   -- 1.자료관리번호.
                    || '26'  -- 2. 26;
                    || LPAD(REPLACE(V_TAX_OFFICE_CODE, '-', ''), 3, 0)  -- 3.세무서 코드;
                    || LPAD(ROWNUM, 6, 0)  -- 4.일련번호.
                    || RPAD(TO_CHAR(P_WRITE_DATE, 'YYYYMMDD'), 8, 0) -- 5.자료를 세무서에 제출하는 연월일;
                    --> 제출자;
/*                    || LPAD(NVL(P_SUBMIT_AGENT, '2'), 1, 0)  -- 제출자구분(세무대리인1, 법인2, 개인3);
                    || RPAD(NVL(P_TAX_PROGRAM_CODE, ' '), 6, ' ')  -- 세무대리인 관리번호(자료제출자가 세무대리인인경우 수록);
*/                    || RPAD(NVL(REPLACE(V_VAT_NUMBER, '-', ''), ' '), 10, ' ')  -- 6.사업자등록번호;
                    || RPAD(NVL(P_HOMETAX_LOGIN_ID, ' '), 20, ' ')  -- 7.홈택스ID;
                    || RPAD(NVL(P_TAX_PROGRAM_CODE, '1001'), 4, ' ')  -- 8.세무프로그램코드;                    
                    || RPAD(NVL(REPLACE(V_VAT_NUMBER, '-', ''), ' '), 10, ' ')  -- 9.사업자등록번호;
                    || RPAD(NVL(REPLACE(V_CORP_NAME, ' ', ''), ' '), 40, ' ')  -- 10.법인명(상호);
                    || RPAD(NVL(REPLACE(PM.REPRE_NUM, '-', '') ,' '), 13, ' ')  -- 11.소득자주민번호.
                    || RPAD(NVL(PM.NATIONALITY_TYPE, ' '), 1, 0)  -- 12.내외국인구분.
                    || RPAD(NVL(REPLACE(PM.NAME, ' ', ''), ' '), 30, ' ') -- 13.소득자의 성명;
                    || LPAD(NVL(REPLACE(MI.CORP_TAX_REG_NO, '-', ''), ' '), 10, ' ') -- 14.지급처의 사업자등록번호;
                    || RPAD(NVL(REPLACE(MI.CORP_NAME, ' ' , ''), ' '), 40, ' ') -- 15.지급처 상호;
                    || RPAD(NVL(MI.EVIDENCE_CODE, ' '), 1, ' ')  -- 16.의료증빙코드;
                    || LPAD(NVL(MI.CREDIT_COUNT, 0) + NVL(MI.ETC_COUNT, 0), 5, 0) -- 17.건수;
                    || LPAD(NVL(MI.CREDIT_AMT, 0) + NVL(MI.ETC_AMT, 0), 11, 0) --  18.지급금액;
                    || LPAD(REPLACE(MI.REPRE_NUM, '-', ''), 13, ' ') -- 19.의료비 지급 대상자의 주민등록번호;
                    || RPAD(CASE
                              WHEN SUBSTR(REPLACE(MI.REPRE_NUM, '-', ''), 7, 1) BETWEEN '5' AND '8' THEN '9'
                              ELSE '1'
                            END, 1, 0) -- 20.의료비 지급 대상자의 내/외국인 코드;
                    || RPAD(CASE
                              WHEN MI.RELATION_CODE = '0' OR 'Y' IN(MI.DISABILITY_YN, MI.OLD_YN) THEN '1'
                              ELSE '2'
                            END, 1, 0) -- 21.본인등 해당여부;
                    || RPAD(P_SUBMIT_PERIOD, 1, 0) -- 22.(연간합산 : 1, 휴/폐업에 의한 수시제출 : 2, 수시 분할제출 : 3);
                    || RPAD(' ', 19, ' ') AS RECORD_FILE
                    , ROWNUM AS SORT_NUM
                  FROM HRA_MEDICAL_INFO MI
                    , HRM_PERSON_MASTER PM
                    , (-- 시점 인사내역.
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
-- 2013년도 기부금 파일생성.
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
    FOR A1 IN ( SELECT 'A'   -- 1.자료관리번호.
                    || '27'  -- 2. 27;
                    || LPAD(NVL(OU.TAX_OFFICE_CODE, ' '), 3, 0)  -- 세무서 코드;
                    || TO_CHAR(P_WRITE_DATE, 'YYYYMMDD')  -- 자료를 세무서에 제출하는 연월일;
                    --> 제출자;
                    || LPAD(NVL(P_SUBMIT_AGENT, '2'), 1, 0)  -- 제출자구분(세무대리인1, 법인2, 개인3);
                    || RPAD(NVL(P_TAX_AGENT, ' '), 6, ' ')  -- 세무대리인 관리번호(자료제출자가 세무대리인인경우 수록);
                    || RPAD(NVL(P_HOMETAX_LOGIN_ID, ' '), 20, ' ')  -- 홈택스ID;
                    || RPAD(NVL(P_TAX_PROGRAM_CODE, '9000'), 4, ' ')  -- 세무프로그램코드;
                    || RPAD(NVL(REPLACE(OU.VAT_NUMBER, '-', ''), ' '), 10, ' ')  -- 사업자등록번호;
                    || RPAD(NVL(CM.CORP_NAME, ' '), 40, ' ')  -- 법인명(상호);
                    || RPAD(NVL(S_PM.DEPT_NAME, ' '), 30, ' ')  -- 담당자(제출자) 부서;
                    || RPAD(NVL(S_PM.NAME, ' '), 30, ' ')  -- 담당자(제출자) 성명;
                    || RPAD(NVL(REPLACE(CM.TEL_NUMBER, '-', ''), ' '), 15, ' ')  -- 담당자(제출자) 전화번호;
                    --> 제출내역.
                    || LPAD(1, 5, 0)  -- 신고의무자수 (B레코드);
                    || LPAD(NVL(P_USE_LANGUAGE_CODE, '101'), 3, 0)  -- 사용한글코드;
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
      FOR B1 IN ( -- 기부금 지급명세서.
                  SELECT 'B' --AS RECORD_TYPE   -- 자료관리번호(레코드 구분);
                      || '27' --AS DATA_TYPE     -- 자료구분(명세서 27);
                      || RPAD(A1.TAX_OFFICE_CODE, 3, 0) -- 세무서코드;
                      || LPAD(ROWNUM, 6, 0) -- 일련번호;
                      -- 원천징수의무자;
                      || RPAD(A1.VAT_NUMBER, 10, ' ') -- 사업자등록번호;
                      || RPAD(A1.CORP_NAME, 40, ' ') -- 상호명;
                      -- 제출내역;
                      || LPAD(NVL(SX1.DONA_ADJUST_COUNT, 0), 7, 0) -- 기부금조정명세레코드수;
                      || LPAD(NVL(SX1.THIS_YEAR_COUNT, 0), 7, 0) -- 해당년도 기부금조정명세레코드수;
                      || LPAD(NVL(SX1.TOTAL_DONA_AMT, 0), 13, 0)  -- 기부금액 총액.
                      || LPAD(NVL(SX1.TOTAL_DONA_DED_AMT, 0), 13, 0)  -- 공제대상금액총액;
                      || LPAD(NVL(P_SUBMIT_PERIOD, '1'), 1, 0) -- (연간합산 : 1, 휴/폐업에 의한 수시제출 : 2, 수시 분할제출 : 3);
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
                                      , (-- 시점 인사내역.
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
                                      , (-- 시점 인사내역.
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
                         , (-- 시점 인사내역.
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
          FOR C2 IN ( -- 기부금 조정명세서.
                      SELECT 'C' -- 자료관리번호(레코드 구분);
                          || '27' -- 자료구분(명세서 27);
                          || LPAD(A1.TAX_OFFICE_CODE, 3, 0) -- 세무서코드;
                          || LPAD(C1.SEQ_NO, 6, 0)   -- 일련번호.
                              -- 일련번호;
  /*                              || LPAD(ROWNUM, 6, 0) --AS SEQ_NO    -- 일련번호;*/
                          || RPAD(A1.VAT_NUMBER, 10, ' ') -- 사업자등록번호;
                          || RPAD(REPLACE(PM.REPRE_NUM, '-', ''), 13, ' ') -- 소득자의 주민등록번호;
                          || RPAD(CASE
                                    WHEN SUBSTR(REPLACE(PM.REPRE_NUM, '-', ''), 7, 1) BETWEEN '5' AND '8' THEN '9'
                                    ELSE '1'
                                  END, 1, 0) -- 내외국인 구분코드;
                          || RPAD(PM.NAME, 30, ' ') -- 소득자의 성명;
                          || RPAD(NVL(DA.DONA_TYPE, ' '), 2, ' ') -- 기부코드;
                          || LPAD(DA.DONA_YYYY, 4, 0)           -- 기부년도;
                          || LPAD(NVL(DA.DONA_AMT, 0), 13, 0) -- 기부금액(기부자,기부처별,유형별 합산);
                          || LPAD(NVL(DA.PRE_DONA_DED_AMT, 0), 13, 0) -- 전년까지 공제된 금액;
                          || LPAD(NVL(DA.TOTAL_DONA_AMT, 0), 13, 0) -- 공제대상금액;
                          || LPAD(NVL(DA.DONA_DED_AMT, 0), 13, 0)    -- 해당년도 공제금액;
                          || LPAD(NVL(DA.LAPSE_DONA_AMT, 0), 13, 0)    -- 해당년도 소멸금액;
                          || LPAD(NVL(DA.NEXT_DONA_AMT, 0), 13, 0)    -- 해당년도 이월금액;
                          || LPAD(ROW_NUMBER() OVER(PARTITION BY PM.PERSON_NUM ORDER BY PM.PERSON_NUM, DA.YEAR_YYYY), 5, 0)         -- 기부금조정명세 일련번호;
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
          FOR D1 IN ( -- 기부금 명세서.
                      SELECT 'D' -- 자료관리번호(레코드 구분);
                          || '27' -- 자료구분(명세서 27);
                          || LPAD(A1.TAX_OFFICE_CODE, 3, 0) -- 세무서코드;
                          || LPAD(C1.SEQ_NO, 6, 0)    -- 일련번호;
                          || RPAD(A1.VAT_NUMBER, 10, ' ') -- 사업자등록번호;
                          || RPAD(REPLACE(PM.REPRE_NUM, '-', ''), 13, ' ') -- 소득자의 주민등록번호;
                          || RPAD(NVL(DI.DONA_TYPE, ' '), 2, ' ') -- 기부코드;
                          || RPAD(NVL(REPLACE(DI.CORP_TAX_REG_NO, '-', ''), ' '), 13, ' ') -- 기부처 사업등록번호;
                          || RPAD(NVL(DI.CORP_NAME, ' '), 30, ' ') -- 기부처 상호;
                          || RPAD(NVL(CASE 
                                        WHEN DI.RELATION_CODE = '0' THEN '1'
                                        WHEN DI.RELATION_CODE = '3' THEN '2'
                                        WHEN DI.RELATION_CODE IN('4', '5') THEN '3'
                                        WHEN DI.RELATION_CODE IN('1', '2') THEN '4'
                                        WHEN DI.RELATION_CODE IN('6') THEN '5'
                                        ELSE '6'
                                      END, ' '), 1, ' ') -- 기부자와의 관계;
                          || RPAD(CASE
                                    WHEN SUBSTR(REPLACE(DI.REPRE_NUM, '-', ''), 7, 1) BETWEEN '5' AND '8' THEN '9'
                                    ELSE '1'
                                  END, 1, ' ') --  내/외국인 코드;
                          || RPAD(NVL(DI.FAMILY_NAME, ' '), 20, ' ') -- 성명;
                          || RPAD(NVL(REPLACE(DI.REPRE_NUM, '-', ''), ' '), 13, ' ') -- 기부자 주민등록번호;
                          || LPAD(NVL(DI.DONA_COUNT, 0), 5, 0) --기부횟수(기부자,기부처별,유형별 합산);
                          || LPAD(NVL(DI.DONA_AMT, 0), 13, 0) -- 기부금(기부자,기부처별,유형별 합산);/*|| LPAD(I_YEAR_YYYY || '0101', 8, 0) --AS TAX_PERIOD_START
                          || LPAD(ROW_NUMBER() OVER(PARTITION BY PM.PERSON_NUM ORDER BY PM.PERSON_NUM), 5, 0)
                          --|| LPAD(C1.SORT_NUM, 5, 0)         -- 기부금조정명세 일련번호;
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
  
END HRA_YEAR_ADJUST_FILE_G;
/
