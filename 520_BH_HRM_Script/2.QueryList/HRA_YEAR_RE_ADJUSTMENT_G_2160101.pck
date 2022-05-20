CREATE OR REPLACE PACKAGE HRA_YEAR_RE_ADJUSTMENT_G
AS

-------------------------------------------------------------------------------
-- 사원정보 조회 --
-------------------------------------------------------------------------------
  PROCEDURE SELECT_PERSON
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_CORP_ID           IN  NUMBER
            , W_STD_YYYYMM        IN  VARCHAR2
            , W_DEPT_ID           IN  NUMBER
            , W_FLOOR_ID          IN  NUMBER
            , W_YEAR_EMPLOYE_TYPE IN  VARCHAR2
            , W_PERSON_ID         IN  NUMBER
            , W_SOB_ID            IN  NUMBER
            , W_ORG_ID            IN  NUMBER
            );

-- 연말정산 계산 : DELETE.
  PROCEDURE DELETE_YEAR_ADJUSTMENT
            ( W_STD_YYYYMM        IN VARCHAR2
            , W_PERSON_ID         IN HRA_YEAR_ADJUSTMENT.PERSON_ID%TYPE
            , W_SOB_ID            IN HRA_YEAR_ADJUSTMENT.SOB_ID%TYPE
            , W_ORG_ID            IN HRA_YEAR_ADJUSTMENT.ORG_ID%TYPE
            );
            
-------------------------------------------------------------------------------
-- 연말정산 내역 마감 / 마감 취소 데이터 조회 --
-------------------------------------------------------------------------------
  PROCEDURE SELECT_YEAR_ADJUSTMENT_CLOSED
            ( P_CURSOR1           OUT TYPES.TCURSOR1
            , W_CORP_ID           IN  NUMBER
            , W_STD_YYYYMM        IN  VARCHAR2
            , W_DEPT_ID           IN  NUMBER
            , W_FLOOR_ID          IN  NUMBER
            , W_JOB_CATEGORY_ID   IN  NUMBER
            , W_YEAR_EMPLOYE_TYPE IN  VARCHAR2
            , W_PERSON_ID         IN  NUMBER
            , W_CLOSED_FLAG       IN  VARCHAR2
            , W_SOB_ID            IN  NUMBER
            , W_ORG_ID            IN  NUMBER
            );
            
-------------------------------------------------------------------------------
-- 2014 연말정산 계산 SELECT : 소급입법 전.
-------------------------------------------------------------------------------
  PROCEDURE SELECT_YEAR_ADJUSTMENT_OLD
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_STD_YYYYMM        IN VARCHAR2
            , W_PERSON_ID         IN HRA_YEAR_ADJUSTMENT.PERSON_ID%TYPE
            , W_SOB_ID            IN HRA_YEAR_ADJUSTMENT.SOB_ID%TYPE
            , W_ORG_ID            IN HRA_YEAR_ADJUSTMENT.ORG_ID%TYPE
            );
 
-------------------------------------------------------------------------------
-- 연말정산 내역 상세 조회 : 재정산 내역 
-------------------------------------------------------------------------------
  PROCEDURE SELECT_YEAR_READJUST_SPREAD
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_CORP_ID           IN  NUMBER 
            , W_STD_YYYYMM        IN  VARCHAR2
            , W_PERSON_ID         IN  NUMBER
            , W_POST_ID           IN  NUMBER
            , W_DEPT_ID           IN  NUMBER
            , W_FLOOR_ID          IN  NUMBER
            , W_SOB_ID            IN  NUMBER
            , W_ORG_ID            IN  NUMBER
            );

-------------------------------------------------------------------------------
-- 연말정산 내역 상세 조회 : 재정산 내역 
-------------------------------------------------------------------------------
  PROCEDURE SELECT_YEAR_READJUST_LIST
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_CORP_ID           IN  NUMBER 
            , W_STD_YYYYMM        IN  VARCHAR2
            , W_PERSON_ID         IN  NUMBER
            , W_POST_ID           IN  NUMBER
            , W_DEPT_ID           IN  NUMBER
            , W_FLOOR_ID          IN  NUMBER
            , W_SOB_ID            IN  NUMBER
            , W_ORG_ID            IN  NUMBER
            );


-------------------------------------------------------------------------------
-- 2014 연말정산 소급입법 적용 계산 SELECT.
-------------------------------------------------------------------------------
  PROCEDURE SELECT_YEAR_ADJUSTMENT_NEW
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_STD_YYYYMM        IN VARCHAR2
            , W_PERSON_ID         IN HRA_YEAR_ADJUSTMENT.PERSON_ID%TYPE
            , W_SOB_ID            IN HRA_YEAR_ADJUSTMENT.SOB_ID%TYPE
            , W_ORG_ID            IN HRA_YEAR_ADJUSTMENT.ORG_ID%TYPE
            );

---------------------------------------------------------------------
-- 연말정산 계산 -- 
---------------------------------------------------------------------
  PROCEDURE SET_MAIN_ADJUST
            ( P_CORP_ID           IN  NUMBER
            , P_YEAR_YYYYMM       IN  VARCHAR2
            , P_DEPT_ID           IN  NUMBER
            , P_FLOOR_ID          IN  NUMBER
            , P_YEAR_EMPLOYE_TYPE IN  VARCHAR2
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
            
-- 연말정산 마감여부 return  -- 
  FUNCTION GET_ADJUST_CLOSED_FLAG_F
            ( P_YEAR_YYYY         IN  VARCHAR2
            , P_PERSON_ID         IN  NUMBER
            , P_SOB_ID            IN  NUMBER
            , P_ORG_ID            IN  NUMBER
            ) RETURN VARCHAR2;      


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
-- 2014년도 근로소득 파일생성.
-------------------------------------------------------------------------------
  PROCEDURE SET_YEAR_ADJUST_FILE_2014
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
-- 2014년도 의료비 파일생성.
-------------------------------------------------------------------------------
  PROCEDURE SET_MEDICAL_FILE_2014
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
-- 2014년도 기부금 파일생성.
-------------------------------------------------------------------------------
  PROCEDURE SET_DONATION_FILE_2014
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
                                                                              
END HRA_YEAR_RE_ADJUSTMENT_G;
/
CREATE OR REPLACE PACKAGE BODY HRA_YEAR_RE_ADJUSTMENT_G
AS
/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : HRA_YEAR_ADJUSTMENT_G
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
-- 사원정보 조회 --
-------------------------------------------------------------------------------
  PROCEDURE SELECT_PERSON
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_CORP_ID           IN  NUMBER
            , W_STD_YYYYMM        IN  VARCHAR2
            , W_DEPT_ID           IN  NUMBER
            , W_FLOOR_ID          IN  NUMBER
            , W_YEAR_EMPLOYE_TYPE IN  VARCHAR2
            , W_PERSON_ID         IN  NUMBER
            , W_SOB_ID            IN  NUMBER
            , W_ORG_ID            IN  NUMBER
            )
  AS
    V_STD_DATE          DATE := LAST_DAY(TO_DATE(W_STD_YYYYMM, 'YYYY-MM'));
  BEGIN
    OPEN P_CURSOR FOR
      SELECT PM.NAME
          , PM.PERSON_NUM
          , T1.DEPT_NAME
          , T1.FLOOR_NAME
          , T1.POST_NAME
          , HRM_COMMON_G.ID_NAME_F(T1.PAY_GRADE_ID) AS PAY_GRADE_NAME
          , HRM_COMMON_G.CODE_NAME_F('EMPLOYE_TYPE', PM.EMPLOYE_TYPE, PM.SOB_ID, PM.ORG_ID) AS EMPLOYE_TYPE_NAME
          , PM.ORI_JOIN_DATE
          , PM.JOIN_DATE
          , PM.RETIRE_DATE
          , PM.REPRE_NUM
          , EAPP_REGISTER_AGE_F(PM.REPRE_NUM, V_STD_DATE, 0) AS AGE
          , PM.PERSON_ID
          , PM.CORP_ID
          , T1.DEPT_ID
          , T1.FLOOR_ID
          , T1.POST_ID
          , T1.PAY_GRADE_ID
      FROM HRM_PERSON_MASTER_V PM
        , (-- 시점 인사내역.
            SELECT  HL.PERSON_ID
                  , HL.DEPT_ID
                  , DM.DEPT_NAME
                  , DM.DEPT_SORT_NUM
                  , HL.POST_ID
                  , HP.POST_NAME
                  , HP.SORT_NUM AS POST_SORT_NUM
                  , HL.PAY_GRADE_ID
                  , HL.JOB_CATEGORY_ID
                  , HL.FLOOR_ID
                  , HF.FLOOR_NAME
                  , HF.SORT_NUM AS FLOOR_SORT_NUM
              FROM HRM_HISTORY_HEADER HH
                 , HRM_HISTORY_LINE   HL
                 , HRM_DEPT_MASTER    DM
                 , HRM_FLOOR_V        HF
                 , HRM_POST_CODE_V    HP
            WHERE HH.HISTORY_HEADER_ID    = HL.HISTORY_HEADER_ID
              AND HL.DEPT_ID              = DM.DEPT_ID
              AND HL.FLOOR_ID             = HF.FLOOR_ID
              AND HL.POST_ID              = HP.POST_ID
              AND HH.CHARGE_SEQ           IN 
                    (SELECT MAX(S_HH.CHARGE_SEQ) AS CHARGE_SEQ
                        FROM HRM_HISTORY_HEADER S_HH
                           , HRM_HISTORY_LINE   S_HL
                       WHERE S_HH.HISTORY_HEADER_ID = S_HL.HISTORY_HEADER_ID
                         AND S_HH.CHARGE_DATE       <= V_STD_DATE 
                         AND S_HL.PERSON_ID         = HL.PERSON_ID
                       GROUP BY S_HL.PERSON_ID
                     ) 
          ) T1
      WHERE PM.PERSON_ID            = T1.PERSON_ID
        AND ((W_CORP_ID             IS NULL AND 1 = 1)
          OR (W_CORP_ID             IS NOT NULL AND PM.CORP_ID = W_CORP_ID))
        AND ((W_PERSON_ID           IS NULL AND 1 = 1)
          OR (W_PERSON_ID           IS NOT NULL AND PM.PERSON_ID = W_PERSON_ID))
        AND PM.JOIN_DATE            <= V_STD_DATE
        AND ((W_STD_YYYYMM          = '2014-12' AND (PM.RETIRE_DATE > V_STD_DATE OR PM.RETIRE_DATE IS NULL))
        OR   (W_STD_YYYYMM          > '2014-12' AND (PM.RETIRE_DATE BETWEEN TRUNC(V_STD_DATE, 'MONTH') AND V_STD_DATE)))
        
        AND ((W_YEAR_EMPLOYE_TYPE   IS NULL AND 1 =1)
          OR (W_YEAR_EMPLOYE_TYPE   != '20' AND (PM.RETIRE_DATE > LAST_DAY(V_STD_DATE) OR PM.RETIRE_DATE IS NULL))
          OR (W_YEAR_EMPLOYE_TYPE   = '20' AND (PM.RETIRE_DATE BETWEEN TRUNC(V_STD_DATE, 'MONTH') AND V_STD_DATE)))
        AND PM.SOB_ID               = W_SOB_ID
        AND PM.ORG_ID               = W_ORG_ID
        AND ((W_DEPT_ID             IS NULL AND 1 = 1)
          OR (W_DEPT_ID             IS NOT NULL AND T1.DEPT_ID = W_DEPT_ID))
        AND ((W_FLOOR_ID            IS NULL AND 1 = 1)
          OR (W_FLOOR_ID            IS NOT NULL AND T1.FLOOR_ID = W_FLOOR_ID))
        AND NOT EXISTS
             ( SELECT 'X'
                 FROM HRA_YEAR_ADJUSTMENT_1505 HA1
                WHERE HA1.YEAR_YYYY        = TO_CHAR(V_STD_DATE, 'YYYY') 
                  AND HA1.PERSON_ID        = PM.PERSON_ID
                  AND HA1.SOB_ID           = PM.SOB_ID
                  AND HA1.ORG_ID           = PM.ORG_ID
                  AND HA1.FIX_IN_TAX_AMT   = 0
             )             -- 결정세액이 0이 아닌 사람만 풀어야 함 -- 
      ORDER BY T1.FLOOR_SORT_NUM
             , T1.POST_SORT_NUM
      ;
  END SELECT_PERSON;

-- 연말정산 계산 : DELETE.
  PROCEDURE DELETE_YEAR_ADJUSTMENT
            ( W_STD_YYYYMM        IN VARCHAR2
            , W_PERSON_ID         IN HRA_YEAR_ADJUSTMENT.PERSON_ID%TYPE
            , W_SOB_ID            IN HRA_YEAR_ADJUSTMENT.SOB_ID%TYPE
            , W_ORG_ID            IN HRA_YEAR_ADJUSTMENT.ORG_ID%TYPE
            )
  AS
    V_RECORD_COUNT      NUMBER := 0;
  BEGIN
    BEGIN
      SELECT COUNT(HA.PERSON_ID) AS RECORD_COUNT
        INTO V_RECORD_COUNT
        FROM HRA_YEAR_ADJUSTMENT HA
      WHERE HA.YEAR_YYYY        = W_STD_YYYYMM
        AND HA.PERSON_ID        = W_PERSON_ID
        AND HA.SOB_ID           = W_SOB_ID
        AND HA.ORG_ID           = W_ORG_ID
        AND HA.CLOSED_FLAG      = 'Y'
      ;
    EXCEPTION
      WHEN OTHERS THEN
        V_RECORD_COUNT := 0;
    END;
    IF V_RECORD_COUNT > 0 THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_MSG_F('FCM_10052'));
      RETURN;
    END IF;

    BEGIN
      DELETE FROM HRA_YEAR_ADJUSTMENT HA
       WHERE HA.YEAR_YYYY         = W_STD_YYYYMM
         AND HA.PERSON_ID         = W_PERSON_ID
         AND HA.SOB_ID            = W_SOB_ID
         AND HA.ORG_ID            = W_ORG_ID
         AND HA.CLOSED_FLAG       = 'N'  -- 마감 안된 자료만.
       ;
    EXCEPTION
      WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20001, 'Delete Error : Person ID - ' || W_PERSON_ID || CHR(10) || SQLERRM);
        RETURN;
    END;
  END DELETE_YEAR_ADJUSTMENT;

-------------------------------------------------------------------------------
-- 연말정산 내역 마감 / 마감 취소 데이터 조회 --
-------------------------------------------------------------------------------
  PROCEDURE SELECT_YEAR_ADJUSTMENT_CLOSED
            ( P_CURSOR1           OUT TYPES.TCURSOR1
            , W_CORP_ID           IN  NUMBER
            , W_STD_YYYYMM        IN  VARCHAR2
            , W_DEPT_ID           IN  NUMBER
            , W_FLOOR_ID          IN  NUMBER
            , W_JOB_CATEGORY_ID   IN  NUMBER
            , W_YEAR_EMPLOYE_TYPE IN  VARCHAR2
            , W_PERSON_ID         IN  NUMBER
            , W_CLOSED_FLAG       IN  VARCHAR2
            , W_SOB_ID            IN  NUMBER
            , W_ORG_ID            IN  NUMBER
            )
  AS
    V_YEAR_YYYY                   VARCHAR2(4);
    V_START_DATE                  DATE;
    V_END_DATE                    DATE;
    V_STD_DATE                    DATE := LAST_DAY(TO_DATE(W_STD_YYYYMM, 'YYYY-MM')); 
  BEGIN
    V_YEAR_YYYY := TO_CHAR(V_STD_DATE, 'YYYY');
    SELECT TRUNC(V_STD_DATE, 'MONTH') AS START_DATE
         , V_STD_DATE AS END_DATE
      INTO V_START_DATE, V_END_DATE
      FROM DUAL;
    ---RAISE_APPLICATION_ERROR(-20001, W_PERSON_ID || '/' || W_CLOSED_FLAG ||'/' || W_SOB_ID);

    OPEN P_CURSOR1 FOR
      SELECT 'N' AS SELECT_YN
          , HA.PERSON_ID AS  PERSON_ID
          , PM.NAME AS NAME
          , PM.PERSON_NUM
          , NVL(T1.DEPT_NAME, NULL) AS DEPT_NAME
          , NVL(T1.FLOOR_NAME, NULL) AS FLOOR_NAME
          , TO_CHAR(HA.ADJUST_DATE_FR, 'YYYY-MM-DD') || ' ~ ' ||
            TO_CHAR(HA.ADJUST_DATE_TO, 'YYYY-MM-DD') AS APPLY_TERM  -- 정산기간 --
          , TRUNC(NVL(HA.SUBT_IN_TAX_AMT, 0), -1) AS SUBT_IN_TAX_AMT  -- 차감 소득세 --
          , TRUNC(NVL(HA.SUBT_LOCAL_TAX_AMT, 0), -1) AS SUBT_LOCAL_TAX_AMT  -- 차감 주민세 --
          , TRUNC(NVL(HA.SUBT_SP_TAX_AMT, 0), -1) AS SUBT_SP_TAX_AMT  -- 차감 농특세 --
          , ( TRUNC(NVL(HA.SUBT_IN_TAX_AMT, 0), -1) +
              TRUNC(NVL(HA.SUBT_LOCAL_TAX_AMT, 0), -1) +
              TRUNC(NVL(HA.SUBT_SP_TAX_AMT, 0), -1)) AS SUBT_TAX_SUM   -- 차감 합계 --
          , NVL(HA.INCOME_TOT_AMT, 0) AS TAX_PAY_SUM
          , ( NVL(HA.NONTAX_OUTSIDE_AMT, 0) + NVL(HA.NONTAX_OT_AMT, 0) +  -- NONTAX_OUTSIDE_AMT : 비과세 국외근로 합계
              NVL(HA.NONTAX_RESEA_AMT, 0) + NVL(HA.NONTAX_ETC_AMT, 0) +
              NVL(HA.NONTAX_BIRTH_AMT, 0) + NVL(HA.NONTAX_FOREIGNER_AMT, 0) +
              NVL(HA.NONTAX_SCH_EDU_AMT, 0) + NVL(HA.NONTAX_MEMBER_AMT, 0) +
              NVL(HA.NONTAX_GUARD_AMT, 0) + NVL(HA.NONTAX_CHILD_AMT, 0) +
              NVL(HA.NONTAX_HIGH_SCH_AMT, 0) + NVL(HA.NONTAX_SPECIAL_AMT, 0) +
              NVL(HA.NONTAX_RESEARCH_AMT, 0) + NVL(HA.NONTAX_COMPANY_AMT, 0) +
              NVL(HA.NONTAX_COVER_AMT, 0) + NVL(HA.NONTAX_WILD_AMT, 0) +
              NVL(HA.NONTAX_DISASTER_AMT, 0) + NVL(HA.NONTAX_OUTS_GOVER_AMT, 0) +
              NVL(HA.NONTAX_OUTS_ARMY_AMT, 0) + NVL(HA.NONTAX_STOCK_BENE_AMT, 0) +
              NVL(HA.NONTAX_FOR_ENG_AMT, 0) + NVL(HA.NONTAX_EMPL_STOCK_AMT, 0) +
              NVL(HA.NONTAX_EMPL_BENE_AMT_1, 0) + NVL(HA.NONTAX_EMPL_BENE_AMT_2, 0) +
              NVL(HA.NONTAX_HOUSE_SUBSIDY_AMT, 0) + NVL(HA.NONTAX_SEA_RESOURCE_AMT, 0) +
              -- 종전--
              NVL(HA.PRE_NT_OUTSIDE_AMT, 0) + NVL(HA.PRE_NT_OT_AMT, 0) +
              NVL(HA.PRE_NT_RESEA_AMT, 0) + NVL(HA.PRE_NT_ETC_AMT, 0) +
              NVL(HA.PRE_NT_BIRTH_AMT, 0) + NVL(HA.PRE_NT_FOREIGNER_AMT, 0) +
              NVL(HA.PRE_NT_SCH_EDU_AMT, 0) + NVL(HA.PRE_NT_MEMBER_AMT, 0) +
              NVL(HA.PRE_NT_GUARD_AMT, 0) + NVL(HA.PRE_NT_CHILD_AMT, 0) +
              NVL(HA.PRE_NT_HIGH_SCH_AMT, 0) + NVL(HA.PRE_NT_SPECIAL_AMT, 0) +
              NVL(HA.PRE_NT_RESEARCH_AMT, 0) + NVL(HA.PRE_NT_COMPANY_AMT, 0) +
              NVL(HA.PRE_NT_COVER_AMT, 0) + NVL(HA.PRE_NT_WILD_AMT, 0) +
              NVL(HA.PRE_NT_DISASTER_AMT, 0) + NVL(HA.PRE_NT_OUTS_GOVER_AMT, 0) +
              NVL(HA.PRE_NT_OUTS_ARMY_AMT, 0) + NVL(HA.PRE_NT_OUTS_WORK_1, 0) +
              NVL(HA.PRE_NT_OUTS_WORK_2, 0) + NVL(HA.PRE_NT_STOCK_BENE_AMT, 0) +
              NVL(HA.PRE_NT_FOR_ENG_AMT, 0) + NVL(HA.PRE_NT_EMPL_STOCK_AMT, 0) +
              NVL(HA.PRE_NT_EMPL_BENE_AMT_1, 0) + NVL(HA.PRE_NT_EMPL_BENE_AMT_2, 0) +
              NVL(HA.PRE_NT_HOUSE_SUBSIDY_AMT, 0) + NVL(HA.PRE_NT_SEA_RESOURCE_AMT, 0)) AS NONTAX_PAY_SUM
          , TRUNC(NVL(HA.FIX_IN_TAX_AMT, 0), -1) AS FIX_IN_TAX_AMT  -- 원단위 절사.
          , TRUNC(NVL(HA.FIX_LOCAL_TAX_AMT, 0), -1) AS FIX_LOCAL_TAX_AMT
          , TRUNC(NVL(HA.FIX_SP_TAX_AMT, 0), -1) AS FIX_SP_TAX_AMT
          , ( TRUNC(NVL(HA.FIX_IN_TAX_AMT, 0), -1) +
              TRUNC(NVL(HA.FIX_LOCAL_TAX_AMT, 0), -1) +
              TRUNC(NVL(HA.FIX_SP_TAX_AMT, 0), -1)) AS FIX_TAX_SUM
          , TRUNC(NVL(HA.PRE_IN_TAX_AMT, 0), -1) AS PRE_IN_TAX_AMT
          , TRUNC(NVL(HA.PRE_LOCAL_TAX_AMT, 0), -1) AS PRE_LOCAL_TAX_AMT
          , TRUNC(NVL(HA.PRE_SP_TAX_AMT, 0), -1) AS PRE_SP_TAX_AMT
          , ( TRUNC(NVL(HA.PRE_IN_TAX_AMT, 0), -1) +
              TRUNC(NVL(HA.PRE_LOCAL_TAX_AMT, 0), -1) +
              TRUNC(NVL(HA.PRE_SP_TAX_AMT, 0), -1)) AS PRE_TAX_SUM
          , CASE
              WHEN PM.RETIRE_DATE IS NULL THEN '계속근무'
              WHEN TO_DATE(TO_CHAR(V_END_DATE, 'YYYY') || '12-31', 'YYYY-MM-DD') < PM.RETIRE_DATE THEN '계속근무'
              ELSE '중도퇴사'
            END AS EMPLOYEE_TYPE
          , PM.RETIRE_DATE
          , NVL(HA.TRANS_YN, 'N') AS TRANS_YN
          , DECODE(NVL(HA.TRANS_YN, 'N'), 'Y', NVL(HA.TRANS_PAY_YYYYMM, TO_CHAR(NULL)), NULL) AS TRANS_PAY_YYYYMM
          , DECODE(NVL(HA.TRANS_YN, 'N'), 'Y', NVL(HA.TRANS_DATE, TO_DATE(NULL)), NULL) AS TRANS_DATE
          , DECODE(NVL(HA.TRANS_YN, 'N'), 'Y',
            (SELECT PM1.NAME
               FROM HRM_PERSON_MASTER PM1
              WHERE PM1.PERSON_ID   = HA.TRANS_PERSON_ID), NULL) AS TRANS_BY
          , W_STD_YYYYMM AS YEAR_YYYYMM
        FROM HRA_YEAR_ADJUSTMENT HA
           , HRM_PERSON_MASTER   PM
           , (-- 시점 인사내역.
              SELECT  HL.PERSON_ID
                    , HL.DEPT_ID
                    , DM.DEPT_CODE
                    , DM.DEPT_NAME
                    , DM.DEPT_SORT_NUM
                    , HL.POST_ID
                    , HP.POST_NAME
                    , HP.SORT_NUM AS POST_SORT_NUM
                    , HL.PAY_GRADE_ID
                    , HL.JOB_CATEGORY_ID
                    , HL.FLOOR_ID
                    , HF.FLOOR_NAME
                    , HF.SORT_NUM AS FLOOR_SORT_NUM
                    , HL.JOB_CLASS_ID
                    , HL.OCPT_ID
                    , HL.ABIL_ID
                FROM HRM_HISTORY_HEADER HH
                   , HRM_HISTORY_LINE   HL
                   , HRM_DEPT_MASTER    DM
                   , HRM_FLOOR_V        HF
                   , HRM_POST_CODE_V    HP
              WHERE HH.HISTORY_HEADER_ID    = HL.HISTORY_HEADER_ID
                AND HL.DEPT_ID              = DM.DEPT_ID
                AND HL.FLOOR_ID             = HF.FLOOR_ID
                AND HL.POST_ID              = HP.POST_ID
                AND HH.CHARGE_SEQ           IN 
                      (SELECT MAX(S_HH.CHARGE_SEQ) AS CHARGE_SEQ
                          FROM HRM_HISTORY_HEADER S_HH
                             , HRM_HISTORY_LINE   S_HL
                         WHERE S_HH.HISTORY_HEADER_ID = S_HL.HISTORY_HEADER_ID
                           AND S_HH.CHARGE_DATE       <= V_STD_DATE 
                           AND S_HL.PERSON_ID         = HL.PERSON_ID
                         GROUP BY S_HL.PERSON_ID
                       ) 
            ) T1
      WHERE HA.PERSON_ID            = PM.PERSON_ID
        AND PM.PERSON_ID            = T1.PERSON_ID
        AND HA.YEAR_YYYY            = V_YEAR_YYYY
        AND ((W_PERSON_ID           IS NULL AND 1 = 1)
        OR   (W_PERSON_ID           IS NOT NULL AND HA.PERSON_ID = W_PERSON_ID))
        AND HA.SOB_ID               = W_SOB_ID
        AND HA.ORG_ID               = W_ORG_ID
        AND HA.SUBMIT_DATE          BETWEEN V_START_DATE AND V_END_DATE
        AND HA.CLOSED_FLAG          = W_CLOSED_FLAG  -- 마감 구분 --
        AND PM.CORP_ID              = W_CORP_ID
        AND PM.SOB_ID               = W_SOB_ID
        AND PM.ORG_ID               = W_ORG_ID
        AND ((W_PERSON_ID           IS NULL AND 1 = 1)
        OR   (W_PERSON_ID           IS NOT NULL AND PM.PERSON_ID = W_PERSON_ID))
        AND ((W_DEPT_ID             IS NULL AND 1 = 1)
        OR   (W_DEPT_ID             IS NOT NULL AND T1.DEPT_ID = W_DEPT_ID))
        AND ((W_FLOOR_ID            IS NULL AND 1 = 1)
        OR   (W_FLOOR_ID            IS NOT NULL AND T1.FLOOR_ID = W_FLOOR_ID))
        AND ((W_JOB_CATEGORY_ID     IS NULL AND 1 = 1)
        OR   (W_JOB_CATEGORY_ID     IS NOT NULL AND T1.JOB_CATEGORY_ID = W_JOB_CATEGORY_ID))        
        AND ((W_STD_YYYYMM          = '2014-12' AND (PM.RETIRE_DATE >= TO_DATE('2015-05-01', 'YYYY-MM-DD') OR PM.RETIRE_DATE IS NULL))
        OR   (W_STD_YYYYMM          >= '2015-01' AND (PM.RETIRE_DATE BETWEEN TRUNC(V_STD_DATE, 'MONTH') AND V_STD_DATE))) 
        AND NOT EXISTS
             ( SELECT 'X'
                 FROM HRA_YEAR_ADJUSTMENT_1505 HA1
                WHERE HA1.YEAR_YYYY        = HA.YEAR_YYYY 
                  AND HA1.PERSON_ID        = PM.PERSON_ID
                  AND HA1.SOB_ID           = PM.SOB_ID
                  AND HA1.ORG_ID           = PM.ORG_ID
                  AND HA1.FIX_IN_TAX_AMT   = 0
             )             -- 결정세액이 0이 아닌 사람만 풀어야 함 -- 
      ORDER BY T1.DEPT_SORT_NUM
             , T1.DEPT_CODE
             , T1.FLOOR_SORT_NUM
      ;
  END SELECT_YEAR_ADJUSTMENT_CLOSED;
            
   
-------------------------------------------------------------------------------
-- 2014 연말정산 계산 SELECT : 소급입법 전.
-------------------------------------------------------------------------------
  PROCEDURE SELECT_YEAR_ADJUSTMENT_OLD
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_STD_YYYYMM        IN VARCHAR2
            , W_PERSON_ID         IN HRA_YEAR_ADJUSTMENT.PERSON_ID%TYPE
            , W_SOB_ID            IN HRA_YEAR_ADJUSTMENT.SOB_ID%TYPE
            , W_ORG_ID            IN HRA_YEAR_ADJUSTMENT.ORG_ID%TYPE
            )
  AS
    V_YEAR_YYYY         VARCHAR2(4);
    V_START_DATE        DATE;
    V_END_DATE          DATE;
    V_STD_DATE          DATE := LAST_DAY(TO_DATE(W_STD_YYYYMM, 'YYYY-MM'));

  BEGIN
    V_YEAR_YYYY := TO_CHAR(V_STD_DATE, 'YYYY');
    BEGIN
      SELECT TRUNC(V_STD_DATE, 'MONTH') AS START_DATE,
             LAST_DAY(V_STD_DATE) AS END_DATE
        INTO V_START_DATE, V_END_DATE
        FROM DUAL
      ;
    EXCEPTION
      WHEN OTHERS THEN
        V_START_DATE := V_STD_DATE;
        V_END_DATE   := V_STD_DATE;
    END;
    
    OPEN P_CURSOR FOR
      SELECT HA.YEAR_YYYY AS YEAR_YYYY
           , HA.PERSON_ID AS PERSON_ID
           , HA.SUBMIT_DATE AS SUBMIT_DATE
           , HA.ADJUST_DATE_FR AS ADJUST_DATE_FR
           , HA.ADJUST_DATE_TO AS ADJUST_DATE_TO
           , NVL(HA.NOW_PAY_TOT_AMT, 0) AS NOW_PAY_TOT_AMT
           , NVL(HA.NOW_BONUS_TOT_AMT, 0) AS NOW_BONUS_TOT_AMT
           , NVL(HA.NOW_ADD_BONUS_AMT, 0) AS NOW_ADD_BONUS_AMT
           , NVL(HA.NOW_STOCK_BENE_AMT, 0) AS NOW_STOCK_BENE_AMT
           , NVL(HA.PRE_PAY_TOT_AMT, 0) AS PRE_PAY_TOT_AMT
           , NVL(HA.PRE_BONUS_TOT_AMT, 0) AS PRE_BONUS_TOT_AMT
           , NVL(HA.PRE_ADD_BONUS_AMT, 0) AS PRE_ADD_BONUS_AMT
           , NVL(HA.PRE_STOCK_BENE_AMT, 0) AS PRE_STOCK_BENE_AMT
           , NVL(HA.INCOME_OUTSIDE_AMT, 0) AS INCOME_OUTSIDE_AMT
           , ( NVL(HA.NOW_PAY_TOT_AMT, 0) + NVL(HA.NOW_BONUS_TOT_AMT, 0) +
               NVL(HA.NOW_ADD_BONUS_AMT, 0) + NVL(HA.NOW_STOCK_BENE_AMT, 0) +
               NVL(HA.PRE_PAY_TOT_AMT, 0) + NVL(HA.PRE_BONUS_TOT_AMT, 0) +
               NVL(HA.PRE_ADD_BONUS_AMT, 0) + NVL(HA.PRE_STOCK_BENE_AMT, 0) +
               NVL(HA.INCOME_OUTSIDE_AMT, 0) +
               NVL(HA.NOW_EMPLOYEE_STOCK_AMT, 0) + NVL(HA.NOW_OFFICE_RETIRE_OVER_AMT, 0) +
               NVL(HA.PRE_EMPLOYEE_STOCK_AMT, 0) + NVL(HA.PRE_OFFICE_RETIRE_OVER_AMT, 0) +
               -- 비과세
               NVL(HA.NONTAX_OUTSIDE_AMT, 0) + NVL(HA.NONTAX_OT_AMT, 0) +   -- NONTAX_OUTSIDE_AMT : 비과세 국외근로 합계
               NVL(HA.NONTAX_RESEA_AMT, 0) + NVL(HA.NONTAX_ETC_AMT, 0) +
               NVL(HA.NONTAX_BIRTH_AMT, 0) + NVL(HA.NONTAX_FOREIGNER_AMT, 0) +
               NVL(HA.NONTAX_SCH_EDU_AMT, 0) + NVL(HA.NONTAX_MEMBER_AMT, 0) +
               NVL(HA.NONTAX_GUARD_AMT, 0) + NVL(HA.NONTAX_CHILD_AMT, 0) +
               NVL(HA.NONTAX_HIGH_SCH_AMT, 0) + NVL(HA.NONTAX_SPECIAL_AMT, 0) +
               NVL(HA.NONTAX_RESEARCH_AMT, 0) + NVL(HA.NONTAX_COMPANY_AMT, 0) +
               NVL(HA.NONTAX_COVER_AMT, 0) + NVL(HA.NONTAX_WILD_AMT, 0) +
               NVL(HA.NONTAX_DISASTER_AMT, 0) + NVL(HA.NONTAX_OUTS_GOVER_AMT, 0) +
               NVL(HA.NONTAX_OUTS_ARMY_AMT, 0) + NVL(HA.NONTAX_STOCK_BENE_AMT, 0) +
               NVL(HA.NONTAX_FOR_ENG_AMT, 0) + NVL(HA.NONTAX_EMPL_STOCK_AMT, 0) +
               NVL(HA.NONTAX_EMPL_BENE_AMT_1, 0) + NVL(HA.NONTAX_EMPL_BENE_AMT_2, 0) +
               NVL(HA.NONTAX_HOUSE_SUBSIDY_AMT, 0) + NVL(HA.NONTAX_SEA_RESOURCE_AMT, 0) +
               -- 종전--
               NVL(HA.PRE_NT_OUTSIDE_AMT, 0) + NVL(HA.PRE_NT_OT_AMT, 0) +   -- NONTAX_OUTSIDE_AMT : 비과세 국외근로 합계
               NVL(HA.PRE_NT_RESEA_AMT, 0) + NVL(HA.PRE_NT_ETC_AMT, 0) +
               NVL(HA.PRE_NT_BIRTH_AMT, 0) + NVL(HA.PRE_NT_FOREIGNER_AMT, 0) +
               NVL(HA.PRE_NT_SCH_EDU_AMT, 0) + NVL(HA.PRE_NT_MEMBER_AMT, 0) +
               NVL(HA.PRE_NT_GUARD_AMT, 0) + NVL(HA.PRE_NT_CHILD_AMT, 0) +
               NVL(HA.PRE_NT_HIGH_SCH_AMT, 0) + NVL(HA.PRE_NT_SPECIAL_AMT, 0) +
               NVL(HA.PRE_NT_RESEARCH_AMT, 0) + NVL(HA.PRE_NT_COMPANY_AMT, 0) +
               NVL(HA.PRE_NT_COVER_AMT, 0) + NVL(HA.PRE_NT_WILD_AMT, 0) +
               NVL(HA.PRE_NT_DISASTER_AMT, 0) + NVL(HA.PRE_NT_OUTS_GOVER_AMT, 0) +
               NVL(HA.PRE_NT_OUTS_ARMY_AMT, 0) + NVL(HA.PRE_NT_STOCK_BENE_AMT, 0) +
               NVL(HA.PRE_NT_FOR_ENG_AMT, 0) + NVL(HA.PRE_NT_EMPL_STOCK_AMT, 0) +
               NVL(HA.PRE_NT_EMPL_BENE_AMT_1, 0) + NVL(HA.PRE_NT_EMPL_BENE_AMT_2, 0) +
               NVL(HA.PRE_NT_HOUSE_SUBSIDY_AMT, 0) + NVL(HA.PRE_NT_SEA_RESOURCE_AMT, 0)) AS TOTAL_PAY   -- 근로소득(과세 + 비과세) --
           , NVL(HA.NONTAX_OUTSIDE_AMT, 0) AS NONTAX_OUTSIDE_AMT
           , NVL(HA.NONTAX_OT_AMT, 0) AS NONTAX_OT_AMT
           , NVL(HA.NONTAX_RESEA_AMT, 0) AS NONTAX_RESEA_AMT
           , NVL(HA.NONTAX_ETC_AMT, 0) AS NONTAX_ETC_AMT
           , NVL(HA.NONTAX_BIRTH_AMT, 0) AS NONTAX_BIRTH_AMT
           , NVL(HA.NONTAX_FOREIGNER_AMT, 0) AS NONTAX_FOREIGNER_AMT
           , ( NVL(HA.NONTAX_OUTSIDE_AMT, 0) + NVL(HA.NONTAX_OT_AMT, 0) +  -- NONTAX_OUTSIDE_AMT : 비과세 국외근로 합계
               NVL(HA.NONTAX_RESEA_AMT, 0) + NVL(HA.NONTAX_ETC_AMT, 0) +
               NVL(HA.NONTAX_BIRTH_AMT, 0) + NVL(HA.NONTAX_FOREIGNER_AMT, 0) +
               NVL(HA.NONTAX_SCH_EDU_AMT, 0) + NVL(HA.NONTAX_MEMBER_AMT, 0) +
               NVL(HA.NONTAX_GUARD_AMT, 0) + NVL(HA.NONTAX_CHILD_AMT, 0) +
               NVL(HA.NONTAX_HIGH_SCH_AMT, 0) + NVL(HA.NONTAX_SPECIAL_AMT, 0) +
               NVL(HA.NONTAX_RESEARCH_AMT, 0) + NVL(HA.NONTAX_COMPANY_AMT, 0) +
               NVL(HA.NONTAX_COVER_AMT, 0) + NVL(HA.NONTAX_WILD_AMT, 0) +
               NVL(HA.NONTAX_DISASTER_AMT, 0) + NVL(HA.NONTAX_OUTS_GOVER_AMT, 0) +
               NVL(HA.NONTAX_OUTS_ARMY_AMT, 0) + NVL(HA.NONTAX_STOCK_BENE_AMT, 0) +
               NVL(HA.NONTAX_FOR_ENG_AMT, 0) + NVL(HA.NONTAX_EMPL_STOCK_AMT, 0) +
               NVL(HA.NONTAX_EMPL_BENE_AMT_1, 0) + NVL(HA.NONTAX_EMPL_BENE_AMT_2, 0) +
               NVL(HA.NONTAX_HOUSE_SUBSIDY_AMT, 0) + NVL(HA.NONTAX_SEA_RESOURCE_AMT, 0) +
               -- 종전--
               NVL(HA.PRE_NT_OUTSIDE_AMT, 0) + NVL(HA.PRE_NT_OT_AMT, 0) +   -- NONTAX_OUTSIDE_AMT : 비과세 국외근로 합계
               NVL(HA.PRE_NT_RESEA_AMT, 0) + NVL(HA.PRE_NT_ETC_AMT, 0) +
               NVL(HA.PRE_NT_BIRTH_AMT, 0) + NVL(HA.PRE_NT_FOREIGNER_AMT, 0) +
               NVL(HA.PRE_NT_SCH_EDU_AMT, 0) + NVL(HA.PRE_NT_MEMBER_AMT, 0) +
               NVL(HA.PRE_NT_GUARD_AMT, 0) + NVL(HA.PRE_NT_CHILD_AMT, 0) +
               NVL(HA.PRE_NT_HIGH_SCH_AMT, 0) + NVL(HA.PRE_NT_SPECIAL_AMT, 0) +
               NVL(HA.PRE_NT_RESEARCH_AMT, 0) + NVL(HA.PRE_NT_COMPANY_AMT, 0) +
               NVL(HA.PRE_NT_COVER_AMT, 0) + NVL(HA.PRE_NT_WILD_AMT, 0) +
               NVL(HA.PRE_NT_DISASTER_AMT, 0) + NVL(HA.PRE_NT_OUTS_GOVER_AMT, 0) +
               NVL(HA.PRE_NT_OUTS_ARMY_AMT, 0) + NVL(HA.PRE_NT_STOCK_BENE_AMT, 0) +
               NVL(HA.PRE_NT_FOR_ENG_AMT, 0) + NVL(HA.PRE_NT_EMPL_STOCK_AMT, 0) +
               NVL(HA.PRE_NT_EMPL_BENE_AMT_1, 0) + NVL(HA.PRE_NT_EMPL_BENE_AMT_2, 0) +
               NVL(HA.PRE_NT_HOUSE_SUBSIDY_AMT, 0) + NVL(HA.PRE_NT_SEA_RESOURCE_AMT, 0)) AS NONTAX_TOT_AMT
           , NVL(HA.INCOME_TOT_AMT, 0) AS INCOME_TOT_AMT  -- 총급여 --
           , NVL(HA.INCOME_DED_AMT, 0) AS INCOME_DED_AMT  -- 근로소득 공제 --
           , (NVL(HA.INCOME_TOT_AMT, 0) - NVL(HA.INCOME_DED_AMT, 0)) AS INCOME_AMT  -- 근로소득 금액 --
           , NVL(HA.PER_DED_AMT, 0) AS PER_DED_AMT
           , NVL(HA.SPOUSE_DED_AMT, 0) AS SPOUSE_DED_AMT
           , NVL(HA.SUPP_DED_COUNT, 0) AS SUPP_DED_COUNT
           , NVL(HA.SUPP_DED_AMT, 0) AS SUPP_DED_AMT
           , NVL(HA.OLD_DED_COUNT, 0) AS OLD_DED_COUNT
           , NVL(HA.OLD_DED_AMT, 0) AS OLD_DED_AMT
           , NVL(HA.OLD_DED_COUNT1, 0) AS OLD_DED_COUNT1
           , NVL(HA.OLD_DED_AMT1, 0) AS OLD_DED_AMT1
           , NVL(HA.DISABILITY_DED_COUNT, 0) AS DISABILITY_DED_COUNT
           , NVL(HA.DISABILITY_DED_AMT, 0) AS DISABILITY_DED_AMT
           , NVL(HA.WOMAN_DED_AMT, 0) AS WOMAN_DED_AMT
           , NVL(HA.CHILD_DED_COUNT, 0) AS CHILD_DED_COUNT
           , NVL(HA.CHILD_DED_AMT, 0) AS CHILD_DED_AMT
           , NVL(HA.PER_ADD_DED_AMT, 0) AS PER_ADD_DED_AMT
           , NVL(HA.MANY_CHILD_DED_COUNT, 0) AS MANY_CHILD_DED_COUNT
           , NVL(HA.MANY_CHILD_DED_AMT, 0) AS MANY_CHILD_DED_AMT
           , NVL(HA.NATI_ANNU_AMT, 0) AS NATI_ANNU_AMT          -- 국민연금 --
           , NVL(HA.ANNU_INSUR_AMT, 0) AS ANNU_INSUR_AMT        -- 연금보험료 합계 --
           , NVL(HA.MEDIC_INSUR_AMT, 0) AS MEDIC_INSUR_AMT      -- 건강보험(건강 + 장기요양보험)
           , NVL(HA.HIRE_INSUR_AMT, 0) AS HIRE_INSUR_AMT        -- 고용보험
           , NVL(HA.GUAR_INSUR_AMT, 0) AS GUAR_INSUR_AMT        -- 보장보험
           , NVL(HA.DISABILITY_INSUR_AMT, 0) AS DISABILITY_INSUR_AMT  -- 장애인보험
             -- 보험료 금액이 음수일 경우에는 0을 출력(연말정산 제출매채 양식에 -값이 들어가지 않음);
           , ( CASE
                 WHEN NVL(HA.MEDIC_INSUR_AMT, 0) + NVL(HA.HIRE_INSUR_AMT, 0) +
                      NVL(HA.GUAR_INSUR_AMT, 0) + NVL(HA.DISABILITY_INSUR_AMT, 0) < 0 THEN 0
                 ELSE NVL(HA.MEDIC_INSUR_AMT, 0) + NVL(HA.HIRE_INSUR_AMT, 0) +
                      NVL(HA.GUAR_INSUR_AMT, 0) + NVL(HA.DISABILITY_INSUR_AMT, 0)
               END) AS ETC_INSURE_AMT  -- 기타보험료 합계 --
           , NVL(HA.MEDIC_AMT, 0) AS MEDIC_AMT  -- 의료비 합계 (장애인 + 기타)
           , NVL(HA.EDUCATION_AMT, 0) AS EDUCATION_AMT  -- 교육비(장애인 + 기타)
           , (NVL(HA.HOUSE_INTER_AMT, 0) + NVL(HA.HOUSE_INTER_AMT_ETC, 0)) AS HOUSE_INTER_AMT  -- 주택임차차입금 대출기관 + 거주자
           , NVL(HA.HOUSE_FUND_AMT, 0) AS HOUSE_FUND_AMT
           , NVL(HA.DONAT_DED_ALL, 0) + NVL(HA.DONAT_DED_50, 0) +  
             NVL(HA.DONAT_DED_RELIGION_10, 0) + NVL(HA.DONAT_DED_10, 0) AS DONAT_AMT      -- 2014-특별소득공제(기부금이월분)
           , NVL(HA.MARRY_ETC_AMT, 0) AS MARRY_ETC_AMT
           , ((CASE
                 WHEN NVL(HA.MEDIC_INSUR_AMT, 0) + NVL(HA.HIRE_INSUR_AMT, 0)  < 0 THEN 0
                 ELSE NVL(HA.MEDIC_INSUR_AMT, 0) + NVL(HA.HIRE_INSUR_AMT, 0) 
               END) +
               (CASE
                 WHEN NVL(HA.HOUSE_INTER_AMT, 0) + NVL(HA.HOUSE_INTER_AMT_ETC, 0) + 
                      NVL(HA.LONG_HOUSE_PROF_AMT, 0) + 
                      NVL(HA.LONG_HOUSE_PROF_AMT_1, 0) + NVL(HA.LONG_HOUSE_PROF_AMT_2, 0) + 
                      NVL(HA.LONG_HOUSE_PROF_AMT_3_FIX, 0) + NVL(HA.LONG_HOUSE_PROF_AMT_3_ETC, 0) + 
                      NVL(HA.DONAT_DED_ALL, 0) + NVL(HA.DONAT_DED_50, 0) + 
                      NVL(HA.DONAT_DED_RELIGION_10, 0) + NVL(HA.DONAT_DED_10, 0) < 0 THEN 0
                 ELSE NVL(HA.HOUSE_INTER_AMT, 0) + NVL(HA.HOUSE_INTER_AMT_ETC, 0) + 
                      NVL(HA.LONG_HOUSE_PROF_AMT, 0) + 
                      NVL(HA.LONG_HOUSE_PROF_AMT_1, 0) + NVL(HA.LONG_HOUSE_PROF_AMT_2, 0) + 
                      NVL(HA.LONG_HOUSE_PROF_AMT_3_FIX, 0) + NVL(HA.LONG_HOUSE_PROF_AMT_3_ETC, 0) + 
                      NVL(HA.DONAT_DED_ALL, 0) + NVL(HA.DONAT_DED_50, 0) +  
                      NVL(HA.DONAT_DED_RELIGION_10, 0) + NVL(HA.DONAT_DED_10, 0)
               END) -- 주택자금(주택입차차입금 + 월세액 + 장기주택저당차입금 )
              ) AS SP_DED_SUM  -- 특별공제 합계 --                                                                                                                       
           , NVL(HA.STAND_DED_AMT, 0) AS STAND_DED_AMT  -- 표준공제   --
           , NVL(HA.SUBT_DED_AMT, 0) AS SUBT_DED_AMT    -- 차감소득금액 --
           
           , NVL(HA.PERS_ANNU_BANK_AMT, 0) AS PERS_ANNU_BANK_AMT  -- 개인연금 
           --, NVL(HA.ANNU_BANK_AMT, 0) AS ANNU_BANK_AMT  -- 2014-세액공제 이동 
           , NVL(HA.INVES_AMT, 0) AS INVES_AMT            -- 투자조합 
           , NVL(HA.FORE_INCOME_AMT, 0) AS FORE_INCOME_AMT  -- 외국 근로자 소득 --
           , NVL(HA.CREDIT_AMT, 0) AS CREDIT_AMT            -- 신용카드 
           --, NVL(HA.RETR_ANNU_AMT, 0) AS RETR_ANNU_AMT    -- 2014-세액공제 이동 
           , NVL(HA.EMPL_STOCK_AMT, 0) AS EMPL_STOCK_AMT
           , NVL(HA.DONAT_DED_30, 0) AS DONAT_DED_30                                      -- 2014-그밖의소득공제(우리사주조합기부금)
           , NVL(HA.INVEST_AMT_14, 0) AS INVEST_AMT_14                                     -- 2014-투자조합출자금액  14년
           , NVL(HA.LONG_SET_INVEST_SAVING_AMT, 0) AS LONG_SET_INVEST_SAVING_AMT           -- 2014-장기집합투자증권저축
            
           , NVL(HA.HIRE_KEEP_EMPLOY_AMT, 0) AS HIRE_KEEP_EMPLOY_AMT  -- 고용유지중소기업근로자소득공제
           , ( NVL(HA.PERS_ANNU_BANK_AMT, 0) + NVL(HA.SMALL_CORPOR_DED_AMT, 0) +
               NVL(HA.HOUSE_APP_DEPOSIT_AMT, 0) + NVL(HA.HOUSE_APP_SAVE_AMT, 0) +
               NVL(HA.HOUSE_SAVE_AMT, 0) + NVL(HA.WORKER_HOUSE_SAVE_AMT, 0) +
               NVL(HA.INVES_AMT, 0) + NVL(HA.CREDIT_AMT, 0) + NVL(HA.DONAT_DED_30, 0) + 
               NVL(HA.EMPL_STOCK_AMT, 0) + NVL(HA.LONG_STOCK_SAVING_AMT, 0) +
               NVL(HA.HIRE_KEEP_EMPLOY_AMT, 0) + NVL(HA.FIX_LEASE_DED_AMT, 0) + NVL(HA.LONG_SET_INVEST_SAVING_AMT, 0)
               ) AS TOT_ETC_DED_AMT   -- 그밖의 소득공제 합계 금액 --
               
           , NVL(HA.TAX_STD_AMT, 0) AS TAX_STD_AMT            -- 과세표준 
           , NVL(HA.COMP_TAX_AMT, 0) AS COMP_TAX_AMT          -- 산출세액 
          
           , NVL(HA.TAX_REDU_IN_LAW_AMT, 0) AS TAX_REDU_IN_LAW_AMT
           , NVL(HA.TAX_REDU_SMALL_BUSINESS, 0) AS TAX_SMALL_REDU_SP_LAW_AMT              -- 2014-세감 ( 중소기업취업청년)           
           , NVL(HA.TAX_REDU_SP_LAW_AMT, 0) + NVL(HA.TAX_REDU_SMALL_BUSINESS, 0) AS TAX_REDU_SP_LAW_AMT
           , (NVL(HA.TAX_REDU_IN_LAW_AMT, 0) + NVL(HA.TAX_REDU_SMALL_BUSINESS, 0) + NVL(HA.TAX_REDU_SP_LAW_AMT, 0))AS TAX_REDU_SUM  -- 세액감면 합계 
           
           , NVL(HA.TAX_DED_INCOME_AMT, 0) AS TAX_DED_INCOME_AMT  -- 근로소득공제 
           , NVL(HA.TAX_DED_TAXGROUP_AMT, 0) AS TAX_DED_TAXGROUP_AMT  -- 납세조합 
           , NVL(HA.TAX_DED_HOUSE_DEBT_AMT, 0) AS TAX_DED_HOUSE_DEBT_AMT  -- 주택차입금 
           , NVL(HA.TAX_DED_LONG_STOCK_AMT, 0) AS TAX_DED_LONG_STOCK_AMT  -- 
           --, NVL(HA.TAX_DED_DONAT_POLI_AMT, 0) AS TAX_DED_DONAT_POLI_AMT  -- 정치자금 기부금(2014 사용 안함)            
           , NVL(HA.TAX_DED_OUTSIDE_PAY_AMT, 0) AS TAX_DED_OUTSIDE_PAY_AMT  -- 외국납부 
           , ( NVL(HA.TAX_DED_INCOME_AMT, 0) + NVL(HA.TD_CHILD_RAISE_DED_AMT, 0) + 
               NVL(HA.TD_SCIENTIST_ANNU_DED_AMT, 0) + NVL(HA.TD_WORKER_RETR_ANNU_DED_AMT, 0) + 
               NVL(HA.TD_ANNU_BANK_DED_AMT, 0) + 
               NVL(HA.TD_GUAR_INSUR_DED_AMT, 0) + 
               NVL(HA.TD_MEDIC_DED_AMT, 0) + NVL(HA.TD_EDUCATION_DED_AMT, 0) + 
               NVL(HA.TD_POLI_DONAT_DED_AMT1, 0) + NVL(HA.TD_POLI_DONAT_DED_AMT2, 0) + 
               NVL(HA.TD_LEGAL_DONAT_DED_AMT, 0) + NVL(HA.TD_DESIGN_DONAT_DED_AMT, 0) + 
               NVL(HA.TD_STAND_DED_AMT, 0) + 
               NVL(HA.TAX_DED_TAXGROUP_AMT, 0) + NVL(HA.TAX_DED_HOUSE_DEBT_AMT, 0) + 
               NVL(HA.TAX_DED_OUTSIDE_PAY_AMT, 0) + NVL(HA.TD_HOUSE_MONTHLY_DED_AMT, 0)) AS TAX_DED_SUM  -- 세액공제 합계 
           
           , NVL(HA.FIX_TAX_AMT, 0) AS FIX_TAX_AMT  -- 결정세액
           , NVL(HA.FIX_IN_TAX_AMT, 0) AS FIX_IN_TAX_AMT           -- 원단위 절사.
           , NVL(HA.FIX_LOCAL_TAX_AMT, 0) AS FIX_LOCAL_TAX_AMT
           , NVL(HA.FIX_SP_TAX_AMT, 0) AS FIX_SP_TAX_AMT
           , ( NVL(HA.FIX_IN_TAX_AMT, 0) + NVL(HA.FIX_LOCAL_TAX_AMT, 0) +
               NVL(HA.FIX_SP_TAX_AMT, 0)) AS FIX_TAX_SUM
           , NVL(HPW1.IN_TAX_AMT, 0) AS PRE_IN_TAX_AMT
           , NVL(HPW1.LOCAL_TAX_AMT, 0) AS PRE_LOCAL_TAX_AMT
           , NVL(HPW1.SP_TAX_AMT, 0) AS PRE_SP_TAX_AMT
           , ( NVL(HPW1.IN_TAX_AMT, 0) + NVL(HPW1.LOCAL_TAX_AMT, 0) +
               NVL(HPW1.SP_TAX_AMT, 0)) AS PRE_TAX_SUM
           , ( NVL(HA.PRE_IN_TAX_AMT, 0) - NVL(HPW1.IN_TAX_AMT, 0)) AS PRE1_IN_TAX_AMT
           , ( NVL(HA.PRE_LOCAL_TAX_AMT, 0) - NVL(HPW1.LOCAL_TAX_AMT, 0)) AS PRE1_LOCAL_TAX_AMT
           , ( NVL(HA.PRE_SP_TAX_AMT, 0) - NVL(HPW1.SP_TAX_AMT, 0)) AS PRE1_SP_TAX_AMT
           , ( NVL(HA.PRE_IN_TAX_AMT, 0) - NVL(HPW1.IN_TAX_AMT, 0) +
               NVL(HA.PRE_LOCAL_TAX_AMT, 0) - NVL(HPW1.LOCAL_TAX_AMT, 0) +
               NVL(HA.PRE_SP_TAX_AMT, 0) - NVL(HPW1.SP_TAX_AMT, 0)) AS PRE1_TAX_SUM
           , NVL(HA.SUBT_IN_TAX_AMT, 0) AS SUBT_IN_TAX_AMT           -- 차감 소득세
           , NVL(HA.SUBT_LOCAL_TAX_AMT, 0) AS SUBT_LOCAL_TAX_AMT     -- 차감 주민세
           , NVL(HA.SUBT_SP_TAX_AMT, 0) AS SUBT_SP_TAX_AMT           -- 차감 농특세
           , ( NVL(HA.SUBT_IN_TAX_AMT, 0) + NVL(HA.SUBT_LOCAL_TAX_AMT, 0) +
               NVL(HA.SUBT_SP_TAX_AMT, 0)) AS SUBT_TAX_SUM
           --, NVL(HA.NONTAX_FOREIGNER_AMT, 0) AS NONTAX_FOREIGNER_AMT
           , NVL(HA.BIRTH_DED_COUNT, 0) AS BIRTH_DED_COUNT
           , NVL(HA.BIRTH_DED_AMT, 0) AS BIRTH_DED_AMT
           , ( NVL(HA.LONG_HOUSE_PROF_AMT, 0) + NVL(HA.LONG_HOUSE_PROF_AMT_1, 0) +
               NVL(HA.LONG_HOUSE_PROF_AMT_2, 0) + NVL(HA.LONG_HOUSE_PROF_AMT_3_FIX, 0) +
               NVL(HA.LONG_HOUSE_PROF_AMT_3_ETC, 0)) AS LONG_HOUSE_PROF_AMT
           , ( NVL(HA.HOUSE_APP_DEPOSIT_AMT, 0) + NVL(HA.HOUSE_APP_SAVE_AMT, 0) +
               NVL(HA.HOUSE_SAVE_AMT, 0) + NVL(HA.WORKER_HOUSE_SAVE_AMT, 0)) AS HOUSE_SAVE_AMT  -- 주택마련저축소득공제 --
           , NVL(HA.SMALL_CORPOR_DED_AMT, 0) AS SMALL_CORPOR_DED_AMT
           , NVL(HA.LONG_STOCK_SAVING_AMT, 0) AS LONG_STOCK_SAVING_AMT
           , NVL(HA.HOUSE_MONTHLY_AMT, 0) AS HOUSE_MONTHLY_AMT  -- 사용 안함 
           , HA.CLOSED_FLAG
           , DECODE(HA.CLOSED_FLAG, 'Y', HA.CLOSED_DATE) AS CLOSED_DATE
           , ( SELECT PM.NAME
                 FROM HRM_PERSON_MASTER PM
                WHERE PM.PERSON_ID    = DECODE(HA.CLOSED_FLAG, 'Y', HA.CLOSED_PERSON_ID, -1)
             ) AS CLOSED_PERSON
           -- 2013년 추가 --
           , NVL(HA.SINGLE_PARENT_DED_AMT, 0) AS SINGLE_PARENT_DED_AMT
           , NVL(HA.FIX_LEASE_DED_AMT, 0) AS FIX_LEASE_DED_AMT
           , NVL(HA.SP_DED_TOT_AMT, 0) AS SP_DED_TOT_AMT
           
           
           -- 2014년 추가 -- 
           , 0 AS TD_CHILD_RAISE_DED_CNT                  -- 2014-세공 자녀양육 인원수 
           , NVL(HA.TD_CHILD_RAISE_DED_AMT, 0) AS TD_CHILD_RAISE_DED_AMT                  -- 2014-세공 자녀양육 공제금액     
           , 0 AS TD_CHILD_6_UNDER_DED_CNT              -- 2014-세공 6세이하 인원수 
           , 0 AS TD_CHILD_6_UNDER_DED_AMT              -- 2014-세공 6세이하 공제금액
           , 0 AS TD_BIRTH_DED_CNT                              -- 2014-세공 출생/입양 인원수 
           , 0 AS TD_BIRTH_DED_AMT                              -- 2014-세공 출생/입양 공제금액 
           , NVL(HA.TD_SCIENTIST_ANNU_AMT, 0) AS TD_SCIENTIST_ANNU_AMT                    -- 2014-세공 과학기술인공제 대상
           , NVL(HA.TD_SCIENTIST_ANNU_DED_AMT, 0) AS TD_SCIENTIST_ANNU_DED_AMT            -- 2014-세공 과학기술인공제 세액
           , NVL(HA.TD_WORKER_RETR_ANNU_AMT, 0) AS TD_WORKER_RETR_ANNU_AMT                -- 2014-세공 근로자 퇴직연금 대상
           , NVL(HA.TD_WORKER_RETR_ANNU_DED_AMT, 0) AS TD_WORKER_RETR_ANNU_DED_AMT        -- 2014-세공 근로자 퇴직연금 세액 
           , NVL(HA.TD_ANNU_BANK_AMT, 0) AS TD_ANNU_BANK_AMT                              -- 2014-세공 연금저축 대상
           , NVL(HA.TD_ANNU_BANK_DED_AMT, 0) AS TD_ANNU_BANK_DED_AMT                      -- 2014-세공 연금저축 세액 
           , ( NVL(HA.TD_GUAR_INSUR_AMT, 0)) AS TD_GUAR_INSUR_AMT                   -- 2014-세공 보장성보험 대상            
           , ( NVL(HA.TD_GUAR_INSUR_DED_AMT, 0)) AS TD_GUAR_INSUR_DED_AMT           -- 2014-세공 보장성보험 세액공제 
           , NVL(HA.TD_MEDIC_AMT, 0) AS TD_MEDIC_AMT                                      -- 2014-세공 의료비 대상금액            
           , NVL(HA.TD_MEDIC_DED_AMT, 0) AS TAX_DED_MEDIC_AMT                             -- 2014-세공 의료비 세액공제
           , NVL(HA.TD_EDUCATION_AMT, 0) AS TD_EDUCATION_AMT                              -- 2014-세공 교유비 대상금액 
           , NVL(HA.TD_EDUCATION_DED_AMT, 0) AS TAX_DED_EDUCATION_AMT                     -- 2014-세공 교육비 세액공제 
           , NVL(HA.TD_POLI_DONAT_AMT1, 0) AS TD_POLI_DONAT_AMT1                          -- 2014-세공 정치자금기부금 대상(10만원 이하) 
           , NVL(HA.TD_POLI_DONAT_DED_AMT1, 0) AS TD_POLI_DONAT_DED_AMT1                  -- 2014-세공 정치자금 기부금 세액공제(10만원 이하) 
           , NVL(HA.TD_POLI_DONAT_AMT2, 0) AS TD_POLI_DONAT_AMT2                          -- 2014-세공 정치자금기부금 대상(10만원 초과) 
           , NVL(HA.TD_POLI_DONAT_DED_AMT2, 0) AS TD_POLI_DONAT_DED_AMT2                  -- 2014-세공 정치자금기부금 세액공제(10만원 초과) 
           , NVL(HA.TD_LEGAL_DONAT_AMT, 0) AS TD_LEGAL_DONAT_AMT                          -- 2014-세공 법정기부금 대상
           , NVL(HA.TD_LEGAL_DONAT_DED_AMT, 0) AS TD_LEGAL_DONAT_DED_AMT                  -- 2014-세공 법정기부금 세액공제
           , NVL(HA.TD_DESIGN_DONAT_AMT, 0) AS TD_DESIGN_DONAT_AMT                        -- 2014-세공 지정기부금 대상
           , NVL(HA.TD_DESIGN_DONAT_DED_AMT, 0) AS TD_DESIGN_DONAT_DED_AMT                -- 2014-세공 지정기부금 세액공제
           , ( NVL(HA.TD_GUAR_INSUR_DED_AMT, 0) + 
               NVL(HA.TD_MEDIC_DED_AMT, 0) + 
               NVL(HA.TD_EDUCATION_DED_AMT, 0) + 
               NVL(HA.TD_POLI_DONAT_DED_AMT1, 0) + 
               NVL(HA.TD_POLI_DONAT_DED_AMT2, 0) +
               NVL(HA.TD_LEGAL_DONAT_DED_AMT, 0) + 
               NVL(HA.TD_DESIGN_DONAT_DED_AMT, 0)) AS TD_SP_DED_TOTAL_AMT                 -- 2014-세공 특별세액공제 합계            
           , NVL(HA.TD_STAND_DED_AMT, 0) AS TD_STAND_DED_AMT                              -- 2014-세공 표준세액공제    
           , NVL(HA.TD_HOUSE_MONTHLY_AMT, 0) AS TD_HOUSE_MONTHLY_AMT                      -- 2014-세공 월세액 공제 대상
           , NVL(HA.TD_HOUSE_MONTHLY_DED_AMT, 0) AS TD_HOUSE_MONTHLY_DED_AMT              -- 2014-세공 월세액 공제금액            
        FROM HRA_YEAR_ADJUSTMENT_1505 HA
           , ( -- 종전 납부 세액
              SELECT HPW.YEAR_YYYY
                   , HPW.PERSON_ID
                   , SUM(HPW.IN_TAX_AMT) AS IN_TAX_AMT
                   , SUM(HPW.LOCAL_TAX_AMT) AS LOCAL_TAX_AMT
                   , SUM(HPW.SP_TAX_AMT) AS SP_TAX_AMT
                FROM HRA_PREVIOUS_WORK HPW
               WHERE HPW.YEAR_YYYY = V_YEAR_YYYY
                 AND HPW.PERSON_ID = W_PERSON_ID
                 AND HPW.SOB_ID    = W_SOB_ID
                 AND HPW.ORG_ID    = W_ORG_ID
               GROUP BY HPW.YEAR_YYYY, HPW.PERSON_ID
             ) HPW1
       WHERE HA.YEAR_YYYY = HPW1.YEAR_YYYY(+)
         AND HA.PERSON_ID = HPW1.PERSON_ID(+)
         AND HA.YEAR_YYYY = V_YEAR_YYYY
         AND HA.PERSON_ID = W_PERSON_ID
         AND HA.SOB_ID    = W_SOB_ID
         AND HA.ORG_ID    = W_ORG_ID
         AND HA.SUBMIT_DATE BETWEEN V_START_DATE AND V_END_DATE
       ;
  END SELECT_YEAR_ADJUSTMENT_OLD;
 
-------------------------------------------------------------------------------
-- 연말정산 내역 상세 조회 : 재정산 내역 
-------------------------------------------------------------------------------
  PROCEDURE SELECT_YEAR_READJUST_SPREAD
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_CORP_ID           IN  NUMBER 
            , W_STD_YYYYMM        IN  VARCHAR2
            , W_PERSON_ID         IN  NUMBER
            , W_POST_ID           IN  NUMBER
            , W_DEPT_ID           IN  NUMBER
            , W_FLOOR_ID          IN  NUMBER
            , W_SOB_ID            IN  NUMBER
            , W_ORG_ID            IN  NUMBER
            )
  AS
    V_YEAR_YYYY         VARCHAR2(4);
    V_AGE_STD_DATE      DATE;
    V_START_DATE        DATE;
    V_END_DATE          DATE;
  BEGIN
    V_START_DATE := TRUNC(TO_DATE(W_STD_YYYYMM, 'YYYY-MM'), 'MONTH');
    V_END_DATE   := LAST_DAY(V_START_DATE);
    V_YEAR_YYYY := TO_CHAR(V_END_DATE, 'YYYY');
    V_AGE_STD_DATE := TO_DATE(V_YEAR_YYYY || '-12-31', 'YYYY-MM-DD');
    
    OPEN P_CURSOR FOR
      SELECT CASE
               WHEN SX1.SORT_NUM = 1 THEN SX1.YEAR_YYYY
               ELSE NULL
             END AS YEAR_YYYY 
           , CASE
               WHEN SX1.SORT_NUM = 1 THEN SX1.NAME
               ELSE NULL
             END AS DIS_NAME 
           , CASE
               WHEN SX1.SORT_NUM = 1 THEN SX1.PERSON_NUM
               ELSE NULL
             END AS DIS_PERSON_NUM
           , CASE
               WHEN SX1.SORT_NUM = 1 THEN SX1.REPRE_NUM
               ELSE NULL
             END AS REPRE_NUM 
           , CASE
               WHEN SX1.SORT_NUM = 1 THEN SX1.AGE
               ELSE NULL
             END AS AGE 
           , CASE
               WHEN SX1.SORT_NUM = 1 THEN SX1.DEPT_NAME
               ELSE NULL
             END AS DEPT_NAME 
           , CASE
               WHEN SX1.SORT_NUM = 1 THEN SX1.FLOOR_NAME
               ELSE NULL
             END AS FLOOR_NAME 
           , CASE
               WHEN SX1.SORT_NUM = 1 THEN SX1.JOIN_DATE
               ELSE NULL
             END AS JOIN_DATE 
           , CASE
               WHEN SX1.SORT_NUM = 1 THEN SX1.RETIRE_DATE
               ELSE NULL
             END AS RETIRE_DATE 
           , SX1.ADJUSTMENT_TYPE 
           , SX1.NOW_SUM_PAY  -- 주현
           , SX1.PRE_SUM_PAY  -- 종전
           , SX1.TOTAL_PAY         -- 총급여
           , SX1.INCOME_DED_AMT    -- 근로소득공제
           , SX1.INCOME_AMT  -- 근로소득금액
           -- 인적공제
           , SX1.PER_DED_AMT                      -- 본인
           , SX1.SPOUSE_DED_AMT                -- 배우자
           , SX1.SUPP_DED_COUNT                -- 부양가족 인원수
           , SX1.SUPP_DED_AMT                    -- 부양가족 공제금액
           , SX1.OLD_DED_COUNT1                -- 경로우대 인원수
           , SX1.OLD_DED_AMT1                    -- 경로우대 공제금액
           , SX1.DISABILITY_DED_COUNT    -- 장애인 인원수
           , SX1.DISABILITY_DED_AMT        -- 장애인 공제금액
           , SX1.WOMAN_DED_AMT                  -- 부녀자 공제금액
           , SX1.SINGLE_PARENT_DED_AMT  -- 한부모가족
           -- 연금보험료 공제
           , SX1.NATI_ANNU_AMT                  -- 국민연금보험료 공제
           , SX1.PUBLIC_INSUR_AMT            -- 공무원연금
           , SX1.MARINE_INSUR_AMT            -- 군인연금보험
           , SX1.SCHOOL_STAFF_INSUR_AMT  -- 사립학교 교직원연금
           , SX1.POST_OFFICE_INSUR_AMT    -- 별정우체국연금
                             
           -- 특별공제
           , SX1.MEDIC_INSUR_AMT              -- 건강보험료
           , SX1.HIRE_INSUR_AMT                -- 고용보험료
                             
           , SX1.HOUSE_INTER_AMT                    -- 주택임차차입금원리금 상환액 - 대출기관
           , SX1.HOUSE_INTER_AMT_ETC            -- 주택임차차입금원리금 상환액 - 거주자
                             
           , SX1.LONG_HOUSE_PROF_AMT            -- 장기주택저당차입금이자상환액 2011년 이전차입분 15년 미만
           , SX1.LONG_HOUSE_PROF_AMT_1        -- 장기주택저당차입금이자상환액 2011년 이전차입분 15~29년
           , SX1.LONG_HOUSE_PROF_AMT_2        -- 장기주택저당차입금이자상환액 2011년 이전차입분 30년 이상
           , SX1.LONG_HOUSE_PROF_AMT_3_FIX  -- 장기주택저당차입금이자상환액 2012년 이후 차입분 15년 이상 고정금액 등
           , SX1.LONG_HOUSE_PROF_AMT_3_ETC  -- 장기주택저당차입금이자상환액 2012년 이후 차입분 15년 이상 기타대출등
           , SX1.FORWARD_DONATION_AMT            -- 기부금(이월분)
                             
           , SX1.SP_DED_SUM_AMT                       -- 특별소득공제 계 

           -- 차감소득금액
           , SX1.SUBT_DED_AMT
           -- 그밖의 소득공제
           , SX1.PERS_ANNU_BANK_AMT        -- 개인연금저축소득공제
           , SX1.SMALL_CORPOR_DED_AMT    -- 소기업/소상공인 공제부금 소득공제
           , SX1.HOUSE_APP_DEPOSIT_AMT  -- 주택청약저축
           , SX1.HOUSE_APP_SAVE_AMT        -- 주택청약종합저축
           , SX1.WORKER_HOUSE_SAVE_AMT  -- 근로자주택마련저축
           , SX1.INVES_AMT                          -- 투자조합출자등 소득공제
                             
           , SX1.CREDIT_AMT                        -- 신용카드등 소득공제
           , SX1.EMPL_STOCK_AMT                -- 우리사주조합소득공제
           , SX1.DONAT_DED_30                    -- 우리사주조합기부금
           , SX1.HIRE_KEEP_EMPLOY_AMT    -- 고용유지중소기업근로자
           , SX1.FIX_LEASE_DED_AMT          -- 목돈안드는 전세이자상환액
           , SX1.LONG_SET_INVEST_SAVING_AMT -- 장기집합투자증권저축
                             
           , SX1.ETC_DED_SUM_AMT   -- 그밖의 소득공제 합계 금액 --
           -- 특별공제 종합한도 초과액
           , SX1.SP_DED_TOT_AMT                -- 특별공제 종합한도 초과액
           -- 종합소득 과세표준
           , SX1.TAX_STD_AMT                      -- 종합소득 과세표준
           -- 산출세액
           , SX1.COMP_TAX_AMT                    -- 산출세액
           -- 세액감면
           , SX1.TAX_REDU_IN_LAW_AMT      -- 소득세법
           , SX1.TAX_REDU_SP_LAW_AMT      -- 조세특례 제한법
           , SX1.TAX_REDU_SP_LAW_AMT_1                   -- 조세특례 제한법 제30조
           , SX1.TAX_REDU_TAX_TREATY      -- 조세조약
           , SX1.TAX_REDU_SUM_AMT      -- 세액감면 합계
           -- 세액공제
           , SX1.TAX_DED_INCOME_AMT        -- 세공-근로소득
           , SX1.TD_CHILD_RAISE_DED_CNT  -- 세공-자녀양육 인원수 
           , SX1.TD_CHILD_RAISE_DED_AMT  -- 세공-자녀양육 금액 
           , SX1.TD_CHILD_6_UNDER_DED_CNT  -- 세공-자녀 6세이하 인원수 
           , SX1.TD_CHILD_6_UNDER_DED_AMT  -- 세공-자녀6세이하 금액 
           , SX1.TD_BIRTH_DED_CNT                  -- 세공-자녀 출생/입양 인원수 
           , SX1.TD_BIRTH_DED_AMT                  -- 세공-자녀 출생/입양 금액 
                             
           , SX1.TD_SCIENTIST_ANNU_AMT                            -- 2014-과학기술인 공제금액
           , SX1.TD_SCIENTIST_ANNU_DED_AMT                    -- 2014-과학기술인 세액공제
           , SX1.TD_WORKER_RETR_ANNU_AMT                        -- 2014-퇴직연금  공제금액
           , SX1.TD_WORKER_RETR_ANNU_DED_AMT                -- 2014-퇴직연금 세액공제
           , SX1.TD_ANNU_BANK_AMT                                      -- 2014-연금저축 공제금액
           , SX1.TD_ANNU_BANK_DED_AMT                              -- 2014-연금저축 세액공제
                              
           , SX1.TD_GUAR_INSUR_AMT                           -- 2014-세감 ( 보장성보험 공제금액)
           , SX1.TD_GUAR_INSUR_DED_AMT                   -- 2014-세감 ( 보장성보험 세액공제)
                              
           , SX1.TD_MEDIC_AMT                                              -- 2014-세감 (의료비 공제금액)
           , SX1.TD_MEDIC_DED_AMT                                      -- 2014-세감 (의료비 세액공제)
                              
           , SX1.TD_EDUCATION_AMT                                      -- 2014-세감 (교육비 공제금액)
           , SX1.TD_EDUCATION_DED_AMT                              -- 2014-세감 (교육비 세액공제) 
                              
           , SX1.TD_POLI_DONAT_AMT1                                       -- 2014-세감 (정치자금기부금-10만원이하) 공제금액
           , SX1.TD_POLI_DONAT_DED_AMT1                                 -- 2014-세감 (정치자금기부금-10만원이하) 세액공제
           , SX1.TD_POLI_DONAT_AMT2                                       -- 2014-세감 (정치자금기부금-10만원초과) 공제금액
           , SX1.TD_POLI_DONAT_DED_AMT2                                 -- 2014-세감 (정치자금기부금-10만원이하) 세액공제
           , SX1.TD_LEGAL_DONAT_AMT                                       -- 2014-세감 (법정기부금) 공제금액
           , SX1.TD_LEGAL_DONAT_DED_AMT                                 -- 2014-세감 (법정기부금) 세액공제
           , SX1.TD_DESIGN_DONAT_AMT                                    -- 2014-세감 (지정기부금) 공제금액
           , SX1.TD_DESIGN_DONAT_DED_AMT                               -- 2014-세감 (지정기부금) 세액공제
                             
           , SX1.SP_TAX_DED_SUM_AMT      -- 특별 세액  공제 
                             
           , SX1.STAND_DED_AMT                                 -- 표준세액공제 
                             
           , SX1.TAX_DED_TAXGROUP_AMT    -- 세공 - 납세조합
           , SX1.TAX_DED_HOUSE_DEBT_AMT  -- 세공 - 주택차입금
           , SX1.TAX_DED_OUTSIDE_PAY_AMT  -- 세공 - 외국납부
           , SX1.TD_HOUSE_MONTHLY_AMT        -- 세공 월세공제 대상 
           , SX1.TD_HOUSE_MONTHLY_DED_AMT   -- 세공 월세공제 세액 
                             
           , SX1.TAX_DED_SUM_AMT      -- 세액공제 합계
           , SX1.FIX_TAX_AMT                       -- 결정세액
           -- 결정세액
           , SX1.FIX_IN_TAX_AMT        -- 결정 소득세
           , SX1.FIX_LOCAL_TAX_AMT   -- 결정 주민세
           , SX1.FIX_SP_TAX_AMT         -- 결정 농특세
           , SX1.FIX_TAX_SUM_AMT     -- 결정 세액 합계
           -- (종전) 기납부 세액
           , SX1.PRE_IN_TAX_AMT           -- (종전) 소득세 합계
           , SX1.PRE_LOCAL_TAX_AMT     -- (종전) 주민세 합계
           , SX1.PRE_SP_TAX_AMT           -- (종전) 농특세 합계
           , SX1.PRE_TAX_SUM_AMT       -- (종전) 세액 합계
           -- (주현) 기납부 세액
           , SX1.NOW_IN_TAX_AMT        -- (주현) 소득세
           , SX1.NOW_LOCAL_TAX_AMT  -- (주현) 주민세
           , SX1.NOW_SP_TAX_AMT        -- (주현) 농특세
           , SX1.NOW_TAX_SUM_AMT  -- (주현) 세액 합계
           -- 차감 세액
           , SX1.SUBT_IN_TAX_AMT       -- (차감) 소득세
           , SX1.SUBT_LOCAL_TAX_AMT -- (차감) 주민세
           , SX1.SUBT_SP_TAX_AMT       -- (차감) 농특세
           , SX1.SUBT_TAX_SUM_AMT   -- (차감) 세액 합계          
           -- 비과세 합계
           , SX1.NONTAX_TOT_AMT  -- 비과세 합계
           -- 비과세 상세
           , SX1.NONTAX_OUTSIDE_AMT -- 비과세 국외근로 합계
           , SX1.NONTAX_OT_AMT
           , SX1.NONTAX_RESEA_AMT
           , SX1.NONTAX_ETC_AMT
           , SX1.NONTAX_BIRTH_AMT
           , SX1.NONTAX_FOREIGNER_AMT
           , SX1.NONTAX_SCH_EDU_AMT
           , SX1.NONTAX_MEMBER_AMT
           , SX1.NONTAX_GUARD_AMT
           , SX1.NONTAX_CHILD_AMT
           , SX1.NONTAX_HIGH_SCH_AMT
           , SX1.NONTAX_SPECIAL_AMT
           , SX1.NONTAX_RESEARCH_AMT
           , SX1.NONTAX_COMPANY_AMT
           , SX1.NONTAX_COVER_AMT
           , SX1.NONTAX_WILD_AMT
           , SX1.NONTAX_DISASTER_AMT
           , SX1.NONTAX_OUTS_GOVER_AMT
           , SX1.NONTAX_OUTS_ARMY_AMT
           , SX1.NONTAX_OUTS_WORK_1
           , SX1.NONTAX_OUTS_WORK_2
           , SX1.NONTAX_STOCK_BENE_AMT
           , SX1.NONTAX_FOR_ENG_AMT
           , SX1.NONTAX_EMPL_STOCK_AMT
           , SX1.NONTAX_EMPL_BENE_AMT_1
           , SX1.NONTAX_EMPL_BENE_AMT_2
           , SX1.NONTAX_HOUSE_SUBSIDY_AMT
           , SX1.NONTAX_SEA_RESOURCE_AMT
           , SX1.NAME
           , SX1.PERSON_NUM
        FROM (SELECT T1.YEAR_YYYY
                   , T1.NAME
                   , T1.PERSON_NUM
                   , T1.REPRE_NUM
                   , T1.AGE
                   , T1.DEPT_NAME
                   , T1.FLOOR_NAME
                   , T1.JOIN_DATE
                   , T1.RETIRE_DATE
                   , T1.ADJUSTMENT_TYPE 
                   , T1.NOW_SUM_PAY  -- 주현
                   , T1.PRE_SUM_PAY  -- 종전
                   , T1.TOTAL_PAY         -- 총급여
                   , T1.INCOME_DED_AMT    -- 근로소득공제
                   , T1.INCOME_AMT  -- 근로소득금액
                   -- 인적공제
                   , T1.PER_DED_AMT                      -- 본인
                   , T1.SPOUSE_DED_AMT                -- 배우자
                   , T1.SUPP_DED_COUNT                -- 부양가족 인원수
                   , T1.SUPP_DED_AMT                    -- 부양가족 공제금액
                   , T1.OLD_DED_COUNT1                -- 경로우대 인원수
                   , T1.OLD_DED_AMT1                    -- 경로우대 공제금액
                   , T1.DISABILITY_DED_COUNT    -- 장애인 인원수
                   , T1.DISABILITY_DED_AMT        -- 장애인 공제금액
                   , T1.WOMAN_DED_AMT                  -- 부녀자 공제금액
                   , T1.SINGLE_PARENT_DED_AMT  -- 한부모가족
                   -- 연금보험료 공제
                   , T1.NATI_ANNU_AMT                  -- 국민연금보험료 공제
                   , T1.PUBLIC_INSUR_AMT            -- 공무원연금
                   , T1.MARINE_INSUR_AMT            -- 군인연금보험
                   , T1.SCHOOL_STAFF_INSUR_AMT  -- 사립학교 교직원연금
                   , T1.POST_OFFICE_INSUR_AMT    -- 별정우체국연금
                             
                   -- 특별공제
                   , T1.MEDIC_INSUR_AMT              -- 건강보험료
                   , T1.HIRE_INSUR_AMT                -- 고용보험료
                             
                   , T1.HOUSE_INTER_AMT                    -- 주택임차차입금원리금 상환액 - 대출기관
                   , T1.HOUSE_INTER_AMT_ETC            -- 주택임차차입금원리금 상환액 - 거주자
                             
                   , T1.LONG_HOUSE_PROF_AMT            -- 장기주택저당차입금이자상환액 2011년 이전차입분 15년 미만
                   , T1.LONG_HOUSE_PROF_AMT_1        -- 장기주택저당차입금이자상환액 2011년 이전차입분 15~29년
                   , T1.LONG_HOUSE_PROF_AMT_2        -- 장기주택저당차입금이자상환액 2011년 이전차입분 30년 이상
                   , T1.LONG_HOUSE_PROF_AMT_3_FIX  -- 장기주택저당차입금이자상환액 2012년 이후 차입분 15년 이상 고정금액 등
                   , T1.LONG_HOUSE_PROF_AMT_3_ETC  -- 장기주택저당차입금이자상환액 2012년 이후 차입분 15년 이상 기타대출등
                   , T1.FORWARD_DONATION_AMT            -- 기부금(이월분)
                             
                   , T1.SP_DED_SUM_AMT                       -- 특별소득공제 계 

                   -- 차감소득금액
                   , T1.SUBT_DED_AMT
                   -- 그밖의 소득공제
                   , T1.PERS_ANNU_BANK_AMT        -- 개인연금저축소득공제
                   , T1.SMALL_CORPOR_DED_AMT    -- 소기업/소상공인 공제부금 소득공제
                   , T1.HOUSE_APP_DEPOSIT_AMT  -- 주택청약저축
                   , T1.HOUSE_APP_SAVE_AMT        -- 주택청약종합저축
                   , T1.WORKER_HOUSE_SAVE_AMT  -- 근로자주택마련저축
                   , T1.INVES_AMT                          -- 투자조합출자등 소득공제
                             
                   , T1.CREDIT_AMT                        -- 신용카드등 소득공제
                   , T1.EMPL_STOCK_AMT                -- 우리사주조합소득공제
                   , T1.DONAT_DED_30                    -- 우리사주조합기부금
                   , T1.HIRE_KEEP_EMPLOY_AMT    -- 고용유지중소기업근로자
                   , T1.FIX_LEASE_DED_AMT          -- 목돈안드는 전세이자상환액
                   , T1.LONG_SET_INVEST_SAVING_AMT -- 장기집합투자증권저축
                             
                   , T1.ETC_DED_SUM_AMT   -- 그밖의 소득공제 합계 금액 --
                   -- 특별공제 종합한도 초과액
                   , T1.SP_DED_TOT_AMT                -- 특별공제 종합한도 초과액
                   -- 종합소득 과세표준
                   , T1.TAX_STD_AMT                      -- 종합소득 과세표준
                   -- 산출세액
                   , T1.COMP_TAX_AMT                    -- 산출세액
                   -- 세액감면
                   , T1.TAX_REDU_IN_LAW_AMT      -- 소득세법
                   , T1.TAX_REDU_SP_LAW_AMT      -- 조세특례 제한법
                   , T1.TAX_REDU_SP_LAW_AMT_1                   -- 조세특례 제한법 제30조
                   , T1.TAX_REDU_TAX_TREATY      -- 조세조약
                   , T1.TAX_REDU_SUM_AMT      -- 세액감면 합계
                   -- 세액공제
                   , T1.TAX_DED_INCOME_AMT        -- 세공-근로소득
                   , T1.TD_CHILD_RAISE_DED_CNT  -- 세공-자녀양육 인원수 
                   , T1.TD_CHILD_RAISE_DED_AMT  -- 세공-자녀양육 금액 
                   , T1.TD_CHILD_6_UNDER_DED_CNT  -- 세공-자녀 6세이하 인원수 
                   , T1.TD_CHILD_6_UNDER_DED_AMT  -- 세공-자녀6세이하 금액 
                   , T1.TD_BIRTH_DED_CNT                  -- 세공-자녀 출생/입양 인원수 
                   , T1.TD_BIRTH_DED_AMT                  -- 세공-자녀 출생/입양 금액 
                             
                   , T1.TD_SCIENTIST_ANNU_AMT                            -- 2014-과학기술인 공제금액
                   , T1.TD_SCIENTIST_ANNU_DED_AMT                    -- 2014-과학기술인 세액공제
                   , T1.TD_WORKER_RETR_ANNU_AMT                        -- 2014-퇴직연금  공제금액
                   , T1.TD_WORKER_RETR_ANNU_DED_AMT                -- 2014-퇴직연금 세액공제
                   , T1.TD_ANNU_BANK_AMT                                      -- 2014-연금저축 공제금액
                   , T1.TD_ANNU_BANK_DED_AMT                              -- 2014-연금저축 세액공제
                              
                   , T1.TD_GUAR_INSUR_AMT                           -- 2014-세감 ( 보장성보험 공제금액)
                   , T1.TD_GUAR_INSUR_DED_AMT                   -- 2014-세감 ( 보장성보험 세액공제)
                              
                   , T1.TD_MEDIC_AMT                                              -- 2014-세감 (의료비 공제금액)
                   , T1.TD_MEDIC_DED_AMT                                      -- 2014-세감 (의료비 세액공제)
                              
                   , T1.TD_EDUCATION_AMT                                      -- 2014-세감 (교육비 공제금액)
                   , T1.TD_EDUCATION_DED_AMT                              -- 2014-세감 (교육비 세액공제) 
                              
                   , T1.TD_POLI_DONAT_AMT1                                       -- 2014-세감 (정치자금기부금-10만원이하) 공제금액
                   , T1.TD_POLI_DONAT_DED_AMT1                                 -- 2014-세감 (정치자금기부금-10만원이하) 세액공제
                   , T1.TD_POLI_DONAT_AMT2                                       -- 2014-세감 (정치자금기부금-10만원초과) 공제금액
                   , T1.TD_POLI_DONAT_DED_AMT2                                 -- 2014-세감 (정치자금기부금-10만원이하) 세액공제
                   , T1.TD_LEGAL_DONAT_AMT                                       -- 2014-세감 (법정기부금) 공제금액
                   , T1.TD_LEGAL_DONAT_DED_AMT                                 -- 2014-세감 (법정기부금) 세액공제
                   , T1.TD_DESIGN_DONAT_AMT                                    -- 2014-세감 (지정기부금) 공제금액
                   , T1.TD_DESIGN_DONAT_DED_AMT                               -- 2014-세감 (지정기부금) 세액공제
                             
                   , T1.SP_TAX_DED_SUM_AMT      -- 특별 세액  공제 
                             
                   , T1.STAND_DED_AMT                                 -- 표준세액공제 
                             
                   , T1.TAX_DED_TAXGROUP_AMT    -- 세공 - 납세조합
                   , T1.TAX_DED_HOUSE_DEBT_AMT  -- 세공 - 주택차입금
                   , T1.TAX_DED_OUTSIDE_PAY_AMT  -- 세공 - 외국납부
                   , T1.TD_HOUSE_MONTHLY_AMT        -- 세공 월세공제 대상 
                   , T1.TD_HOUSE_MONTHLY_DED_AMT   -- 세공 월세공제 세액 
                             
                   , T1.TAX_DED_SUM_AMT      -- 세액공제 합계
                   , T1.FIX_TAX_AMT                       -- 결정세액
                   -- 결정세액
                   , T1.FIX_IN_TAX_AMT        -- 결정 소득세
                   , T1.FIX_LOCAL_TAX_AMT   -- 결정 주민세
                   , T1.FIX_SP_TAX_AMT         -- 결정 농특세
                   , T1.FIX_TAX_SUM_AMT     -- 결정 세액 합계
                   -- (종전) 기납부 세액
                   , T1.PRE_IN_TAX_AMT           -- (종전) 소득세 합계
                   , T1.PRE_LOCAL_TAX_AMT     -- (종전) 주민세 합계
                   , T1.PRE_SP_TAX_AMT           -- (종전) 농특세 합계
                   , T1.PRE_TAX_SUM_AMT       -- (종전) 세액 합계
                   -- (주현) 기납부 세액
                   , T1.NOW_IN_TAX_AMT        -- (주현) 소득세
                   , T1.NOW_LOCAL_TAX_AMT  -- (주현) 주민세
                   , T1.NOW_SP_TAX_AMT        -- (주현) 농특세
                   , T1.NOW_TAX_SUM_AMT  -- (주현) 세액 합계
                   -- 차감 세액
                   , T1.SUBT_IN_TAX_AMT       -- (차감) 소득세
                   , T1.SUBT_LOCAL_TAX_AMT -- (차감) 주민세
                   , T1.SUBT_SP_TAX_AMT       -- (차감) 농특세
                   , T1.SUBT_TAX_SUM_AMT   -- (차감) 세액 합계          
                   -- 비과세 합계
                   , T1.NONTAX_TOT_AMT  -- 비과세 합계
                   -- 비과세 상세
                   , T1.NONTAX_OUTSIDE_AMT -- 비과세 국외근로 합계
                   , T1.NONTAX_OT_AMT
                   , T1.NONTAX_RESEA_AMT
                   , T1.NONTAX_ETC_AMT
                   , T1.NONTAX_BIRTH_AMT
                   , T1.NONTAX_FOREIGNER_AMT
                   , T1.NONTAX_SCH_EDU_AMT
                   , T1.NONTAX_MEMBER_AMT
                   , T1.NONTAX_GUARD_AMT
                   , T1.NONTAX_CHILD_AMT
                   , T1.NONTAX_HIGH_SCH_AMT
                   , T1.NONTAX_SPECIAL_AMT
                   , T1.NONTAX_RESEARCH_AMT
                   , T1.NONTAX_COMPANY_AMT
                   , T1.NONTAX_COVER_AMT
                   , T1.NONTAX_WILD_AMT
                   , T1.NONTAX_DISASTER_AMT
                   , T1.NONTAX_OUTS_GOVER_AMT
                   , T1.NONTAX_OUTS_ARMY_AMT
                   , T1.NONTAX_OUTS_WORK_1
                   , T1.NONTAX_OUTS_WORK_2
                   , T1.NONTAX_STOCK_BENE_AMT
                   , T1.NONTAX_FOR_ENG_AMT
                   , T1.NONTAX_EMPL_STOCK_AMT
                   , T1.NONTAX_EMPL_BENE_AMT_1
                   , T1.NONTAX_EMPL_BENE_AMT_2
                   , T1.NONTAX_HOUSE_SUBSIDY_AMT
                   , T1.NONTAX_SEA_RESOURCE_AMT
                   , T1.SORT_NUM 
                FROM (SELECT NVL(HA.YEAR_YYYY, NULL) AS YEAR_YYYY
                           , NVL(PM.NAME, NULL) AS NAME
                           , NVL(PM.PERSON_NUM, NULL) AS PERSON_NUM
                           , NVL(PM.REPRE_NUM, NULL) AS REPRE_NUM
                           , NVL(EAPP_REGISTER_AGE_F(PM.REPRE_NUM, V_AGE_STD_DATE, 0), NULL) AS AGE
                           , NVL(T1.DEPT_NAME, NULL) AS DEPT_NAME
                           , NVL(T1.FLOOR_NAME, NULL) AS FLOOR_NAME
                           , NVL(PM.JOIN_DATE, NULL) AS JOIN_DATE
                           , NVL(PM.RETIRE_DATE, NULL) AS RETIRE_DATE
                           , '기처리내역' AS ADJUSTMENT_TYPE              
                           , ( NVL(HA.NOW_PAY_TOT_AMT, 0) + NVL(HA.NOW_BONUS_TOT_AMT, 0) +
                               NVL(HA.NOW_ADD_BONUS_AMT, 0) + NVL(HA.NOW_STOCK_BENE_AMT, 0) +
                               NVL(HA.INCOME_OUTSIDE_AMT, 0) +
                               NVL(HA.NOW_EMPLOYEE_STOCK_AMT, 0) + NVL(HA.NOW_OFFICE_RETIRE_OVER_AMT, 0)) AS NOW_SUM_PAY  -- 주현
                           , ( NVL(HA.PRE_PAY_TOT_AMT, 0) + NVL(HA.PRE_BONUS_TOT_AMT, 0) +
                               NVL(HA.PRE_ADD_BONUS_AMT, 0) + NVL(HA.PRE_STOCK_BENE_AMT, 0) +
                               NVL(HA.PRE_EMPLOYEE_STOCK_AMT, 0) + NVL(HA.PRE_OFFICE_RETIRE_OVER_AMT, 0)) AS PRE_SUM_PAY  -- 종전
                           , NVL(HA.INCOME_TOT_AMT, 0) AS TOTAL_PAY         -- 총급여
                           , NVL(HA.INCOME_DED_AMT, 0) AS INCOME_DED_AMT    -- 근로소득공제
                           , ( NVL(HA.INCOME_TOT_AMT, 0) - NVL(HA.INCOME_DED_AMT, 0)) AS INCOME_AMT  -- 근로소득금액
                           -- 인적공제
                           , NVL(HA.PER_DED_AMT, 0) AS PER_DED_AMT                      -- 본인
                           , NVL(HA.SPOUSE_DED_AMT, 0) AS SPOUSE_DED_AMT                -- 배우자
                           , NVL(HA.SUPP_DED_COUNT, 0) AS SUPP_DED_COUNT                -- 부양가족 인원수
                           , NVL(HA.SUPP_DED_AMT, 0) AS SUPP_DED_AMT                    -- 부양가족 공제금액
                           , NVL(HA.OLD_DED_COUNT1, 0) AS OLD_DED_COUNT1                -- 경로우대 인원수
                           , NVL(HA.OLD_DED_AMT1, 0) AS OLD_DED_AMT1                    -- 경로우대 공제금액
                           , NVL(HA.DISABILITY_DED_COUNT, 0) AS DISABILITY_DED_COUNT    -- 장애인 인원수
                           , NVL(HA.DISABILITY_DED_AMT, 0) AS DISABILITY_DED_AMT        -- 장애인 공제금액
                           , NVL(HA.WOMAN_DED_AMT, 0) AS WOMAN_DED_AMT                  -- 부녀자 공제금액
                           , NVL(HA.SINGLE_PARENT_DED_AMT, 0) AS SINGLE_PARENT_DED_AMT  -- 한부모가족
                           -- 연금보험료 공제
                           , NVL(HA.NATI_ANNU_AMT, 0) AS NATI_ANNU_AMT                  -- 국민연금보험료 공제
                           , NVL(HA.PUBLIC_INSUR_AMT, 0) AS PUBLIC_INSUR_AMT            -- 공무원연금
                           , NVL(HA.MARINE_INSUR_AMT, 0) AS MARINE_INSUR_AMT            -- 군인연금보험
                           , NVL(HA.SCHOOL_STAFF_INSUR_AMT, 0) AS SCHOOL_STAFF_INSUR_AMT  -- 사립학교 교직원연금
                           , NVL(HA.POST_OFFICE_INSUR_AMT, 0) AS POST_OFFICE_INSUR_AMT    -- 별정우체국연금
                             
                           -- 특별공제
                           , NVL(HA.MEDIC_INSUR_AMT, 0) AS MEDIC_INSUR_AMT              -- 건강보험료
                           , NVL(HA.HIRE_INSUR_AMT, 0) AS HIRE_INSUR_AMT                -- 고용보험료
                             
                           , NVL(HA.HOUSE_INTER_AMT, 0) AS HOUSE_INTER_AMT                    -- 주택임차차입금원리금 상환액 - 대출기관
                           , NVL(HA.HOUSE_INTER_AMT_ETC, 0) AS HOUSE_INTER_AMT_ETC            -- 주택임차차입금원리금 상환액 - 거주자
                             
                           , NVL(HA.LONG_HOUSE_PROF_AMT, 0) AS LONG_HOUSE_PROF_AMT            -- 장기주택저당차입금이자상환액 2011년 이전차입분 15년 미만
                           , NVL(HA.LONG_HOUSE_PROF_AMT_1, 0) AS LONG_HOUSE_PROF_AMT_1        -- 장기주택저당차입금이자상환액 2011년 이전차입분 15~29년
                           , NVL(HA.LONG_HOUSE_PROF_AMT_2, 0) AS LONG_HOUSE_PROF_AMT_2        -- 장기주택저당차입금이자상환액 2011년 이전차입분 30년 이상
                           , NVL(HA.LONG_HOUSE_PROF_AMT_3_FIX, 0) AS LONG_HOUSE_PROF_AMT_3_FIX  -- 장기주택저당차입금이자상환액 2012년 이후 차입분 15년 이상 고정금액 등
                           , NVL(HA.LONG_HOUSE_PROF_AMT_3_ETC, 0) AS LONG_HOUSE_PROF_AMT_3_ETC  -- 장기주택저당차입금이자상환액 2012년 이후 차입분 15년 이상 기타대출등
                           /*, ( NVL(HA.LONG_HOUSE_PROF_AMT, 0) +
                               NVL(HA.LONG_HOUSE_PROF_AMT_1, 0) + NVL(HA.LONG_HOUSE_PROF_AMT_2, 0) +
                               NVL(HA.LONG_HOUSE_PROF_AMT_3_FIX, 0) + NVL(HA.LONG_HOUSE_PROF_AMT_3_ETC, 0)) AS LONG_HOUSE_PROF_SUM_AMT  -- 장기주택저당 합계*/
                           , NVL(HA.DONAT_NEXT_ALL, 0) + NVL(HA.DONAT_NEXT_50, 0) + NVL(HA.DONAT_NEXT_30, 0) + NVL(HA.DONAT_NEXT_RELIGION_10, 0) + NVL(HA.DONAT_NEXT_10, 0) AS FORWARD_DONATION_AMT            -- 기부금(이월분)
                             
                          --, NVL(HA.HOUSE_FUND_AMT, 0) AS HOUSE_FUND_AMT                -- 주택자금 합계
                             
                           , ((CASE
                                 WHEN NVL(HA.MEDIC_INSUR_AMT, 0) + NVL(HA.HIRE_INSUR_AMT, 0)  < 0 THEN 0
                                 ELSE NVL(HA.MEDIC_INSUR_AMT, 0) + NVL(HA.HIRE_INSUR_AMT, 0) 
                               END) +
                               NVL(HA.HOUSE_INTER_AMT, 0) +            -- 주택임차차입금원리금 상환액 - 대출기관
                               NVL(HA.HOUSE_INTER_AMT_ETC, 0) +        -- 주택임차차입금원리금 상환액 - 거주자            
                               NVL(HA.LONG_HOUSE_PROF_AMT, 0) +        -- 장기주택저당차입금이자상환액 2011년 이전차입분 15년 미만
                               NVL(HA.LONG_HOUSE_PROF_AMT_1, 0) +      -- 장기주택저당차입금이자상환액 2011년 이전차입분 15~29년
                               NVL(HA.LONG_HOUSE_PROF_AMT_2, 0) +      -- 장기주택저당차입금이자상환액 2011년 이전차입분 30년 이상
                               NVL(HA.LONG_HOUSE_PROF_AMT_3_FIX, 0) +  -- 장기주택저당차입금이자상환액 2012년 이후 차입분 15년 이상 고정금액 등
                               NVL(HA.LONG_HOUSE_PROF_AMT_3_ETC, 0) +  -- 장기주택저당차입금이자상환액 2012년 이후 차입분 15년 이상 기타대출등
                               NVL(HA.DONAT_NEXT_ALL, 0) + NVL(HA.DONAT_NEXT_50, 0) + NVL(HA.DONAT_NEXT_30, 0) + NVL(HA.DONAT_NEXT_RELIGION_10, 0) + NVL(HA.DONAT_NEXT_10, 0)-- 기부금(이월분)
                               ) AS SP_DED_SUM_AMT                       -- 특별소득공제 계 
                                         

                           -- 차감소득금액
                           , NVL(HA.SUBT_DED_AMT, 0) AS SUBT_DED_AMT
                           -- 그밖의 소득공제
                           , NVL(HA.PERS_ANNU_BANK_AMT, 0) AS PERS_ANNU_BANK_AMT        -- 개인연금저축소득공제
                           , NVL(HA.SMALL_CORPOR_DED_AMT, 0) AS SMALL_CORPOR_DED_AMT    -- 소기업/소상공인 공제부금 소득공제
                           , NVL(HA.HOUSE_APP_DEPOSIT_AMT, 0) AS HOUSE_APP_DEPOSIT_AMT  -- 주택청약저축
                           , NVL(HA.HOUSE_APP_SAVE_AMT, 0) AS HOUSE_APP_SAVE_AMT        -- 주택청약종합저축
                           , NVL(HA.WORKER_HOUSE_SAVE_AMT, 0) AS WORKER_HOUSE_SAVE_AMT  -- 근로자주택마련저축
                           , NVL(HA.INVES_AMT, 0) AS INVES_AMT                          -- 투자조합출자등 소득공제
                           /*, ( NVL(HA.HOUSE_APP_DEPOSIT_AMT, 0) + NVL(HA.HOUSE_APP_SAVE_AMT, 0) +
                               NVL(HA.HOUSE_SAVE_AMT, 0) + NVL(HA.WORKER_HOUSE_SAVE_AMT, 0)) AS HOUSE_SAVE_SUM_AMT  -- 주택마련 저축소득공제 합계*/
                             
                           , NVL(HA.CREDIT_AMT, 0) AS CREDIT_AMT                        -- 신용카드등 소득공제
                           , NVL(HA.EMPL_STOCK_AMT, 0) AS EMPL_STOCK_AMT                -- 우리사주조합소득공제
                           , NVL(HA.DONAT_DED_30, 0) AS DONAT_DED_30                    -- 우리사주조합기부금
                           , NVL(HA.HIRE_KEEP_EMPLOY_AMT, 0) AS HIRE_KEEP_EMPLOY_AMT    -- 고용유지중소기업근로자
                           , NVL(HA.FIX_LEASE_DED_AMT, 0) AS FIX_LEASE_DED_AMT          -- 목돈안드는 전세이자상환액
                           , NVL(HA.LONG_SET_INVEST_SAVING_AMT, 0) AS LONG_SET_INVEST_SAVING_AMT -- 장기집합투자증권저축
                             
                           , ( NVL(HA.PERS_ANNU_BANK_AMT, 0) + NVL(HA.SMALL_CORPOR_DED_AMT, 0) +
                               NVL(HA.HOUSE_APP_DEPOSIT_AMT, 0) + NVL(HA.HOUSE_APP_SAVE_AMT, 0) +
                               NVL(HA.WORKER_HOUSE_SAVE_AMT, 0) + NVL(HA.INVES_AMT, 0) +
                               NVL(HA.CREDIT_AMT, 0) + NVL(HA.EMPL_STOCK_AMT, 0) +
                               NVL(HA.DONAT_DED_30, 0) + NVL(HA.HIRE_KEEP_EMPLOY_AMT, 0) +
                               NVL(HA.FIX_LEASE_DED_AMT, 0) + NVL(HA.LONG_SET_INVEST_SAVING_AMT, 0)) AS ETC_DED_SUM_AMT   -- 그밖의 소득공제 합계 금액 --
                           -- 특별공제 종합한도 초과액
                           , NVL(HA.SP_DED_TOT_AMT, 0) AS SP_DED_TOT_AMT                -- 특별공제 종합한도 초과액
                           -- 종합소득 과세표준
                           , NVL(HA.TAX_STD_AMT, 0) AS TAX_STD_AMT                      -- 종합소득 과세표준
                           -- 산출세액
                           , NVL(HA.COMP_TAX_AMT, 0) AS COMP_TAX_AMT                    -- 산출세액
                           -- 세액감면
                           , NVL(HA.TAX_REDU_IN_LAW_AMT, 0) AS TAX_REDU_IN_LAW_AMT      -- 소득세법
                           , NVL(HA.TAX_REDU_SP_LAW_AMT, 0) AS TAX_REDU_SP_LAW_AMT      -- 조세특례 제한법
                           , NVL(HA.TAX_REDU_SMALL_BUSINESS, 0) AS TAX_REDU_SP_LAW_AMT_1                   -- 조세특례 제한법 제30조
                           , NVL(HA.TAX_REDU_TAX_TREATY, 0) AS TAX_REDU_TAX_TREATY      -- 조세조약
                           , ( NVL(HA.TAX_REDU_IN_LAW_AMT, 0) + NVL(HA.TAX_REDU_SP_LAW_AMT, 0) +
                               NVL(HA.TAX_REDU_TAX_TREATY, 0) + NVL(HA.TAX_REDU_SMALL_BUSINESS, 0)) AS TAX_REDU_SUM_AMT      -- 세액감면 합계
                           -- 세액공제
                           , NVL(HA.TAX_DED_INCOME_AMT, 0) AS TAX_DED_INCOME_AMT        -- 세공-근로소득
                           , 0 AS TD_CHILD_RAISE_DED_CNT  -- 세공-자녀양육 인원수 
                           , NVL(HA.TD_CHILD_RAISE_DED_AMT, 0) AS TD_CHILD_RAISE_DED_AMT  -- 세공-자녀양육 금액 
                           , 0 AS TD_CHILD_6_UNDER_DED_CNT  -- 세공-자녀 6세이하 인원수 
                           , 0 AS TD_CHILD_6_UNDER_DED_AMT  -- 세공-자녀6세이하 금액 
                           , 0 AS TD_BIRTH_DED_CNT                  -- 세공-자녀 출생/입양 인원수 
                           , 0 AS TD_BIRTH_DED_AMT                  -- 세공-자녀 출생/입양 금액 
                             
                           , NVL(HA.TD_SCIENTIST_ANNU_AMT, 0) AS TD_SCIENTIST_ANNU_AMT                            -- 2014-과학기술인 공제금액
                           , NVL(HA.TD_SCIENTIST_ANNU_DED_AMT, 0) AS TD_SCIENTIST_ANNU_DED_AMT                    -- 2014-과학기술인 세액공제
                           , NVL(HA.TD_WORKER_RETR_ANNU_AMT, 0) AS TD_WORKER_RETR_ANNU_AMT                        -- 2014-퇴직연금  공제금액
                           , NVL(HA.TD_WORKER_RETR_ANNU_DED_AMT, 0) AS TD_WORKER_RETR_ANNU_DED_AMT                -- 2014-퇴직연금 세액공제
                           , NVL(HA.TD_ANNU_BANK_AMT, 0) AS TD_ANNU_BANK_AMT                                      -- 2014-연금저축 공제금액
                           , NVL(HA.TD_ANNU_BANK_DED_AMT, 0) AS TD_ANNU_BANK_DED_AMT                              -- 2014-연금저축 세액공제
                              
                           , ( NVL(HA.TD_GUAR_INSUR_AMT, 0)) AS TD_GUAR_INSUR_AMT                           -- 2014-세감 ( 보장성보험 공제금액)
                           , ( NVL(HA.TD_GUAR_INSUR_DED_AMT, 0)) AS TD_GUAR_INSUR_DED_AMT                   -- 2014-세감 ( 보장성보험 세액공제)
                              
                           , NVL(HA.TD_MEDIC_AMT, 0) AS TD_MEDIC_AMT                                              -- 2014-세감 (의료비 공제금액)
                           , NVL(HA.TD_MEDIC_DED_AMT, 0) AS TD_MEDIC_DED_AMT                                      -- 2014-세감 (의료비 세액공제)
                              
                           , NVL(HA.TD_EDUCATION_AMT, 0) AS TD_EDUCATION_AMT                                      -- 2014-세감 (교육비 공제금액)
                           , NVL(HA.TD_EDUCATION_DED_AMT, 0) AS TD_EDUCATION_DED_AMT                              -- 2014-세감 (교육비 세액공제) 
                              
                           , NVL(HA.TD_POLI_DONAT_AMT1, 0) AS TD_POLI_DONAT_AMT1                                       -- 2014-세감 (정치자금기부금-10만원이하) 공제금액
                           , NVL(HA.TD_POLI_DONAT_DED_AMT1, 0) AS TD_POLI_DONAT_DED_AMT1                                 -- 2014-세감 (정치자금기부금-10만원이하) 세액공제
                           , NVL(HA.TD_POLI_DONAT_AMT2, 0) AS TD_POLI_DONAT_AMT2                                       -- 2014-세감 (정치자금기부금-10만원초과) 공제금액
                           , NVL(HA.TD_POLI_DONAT_DED_AMT2, 0) AS TD_POLI_DONAT_DED_AMT2                                 -- 2014-세감 (정치자금기부금-10만원이하) 세액공제
                           , NVL(HA.TD_LEGAL_DONAT_AMT, 0) AS TD_LEGAL_DONAT_AMT                                       -- 2014-세감 (법정기부금) 공제금액
                           , NVL(HA.TD_LEGAL_DONAT_DED_AMT, 0) AS TD_LEGAL_DONAT_DED_AMT                                 -- 2014-세감 (법정기부금) 세액공제
                           , NVL(HA.TD_DESIGN_DONAT_AMT, 0) AS TD_DESIGN_DONAT_AMT                                    -- 2014-세감 (지정기부금) 공제금액
                           , NVL(HA.TD_DESIGN_DONAT_DED_AMT, 0) AS TD_DESIGN_DONAT_DED_AMT                               -- 2014-세감 (지정기부금) 세액공제
                             
                           , ( NVL(HA.TD_GUAR_INSUR_DED_AMT, 0) +
                               NVL(HA.TD_POLI_DONAT_DED_AMT1, 0) + NVL(HA.TD_EDUCATION_DED_AMT, 0) +
                               NVL(HA.TD_POLI_DONAT_DED_AMT1, 0) + NVL(HA.TD_POLI_DONAT_DED_AMT2, 0) +
                               NVL(HA.TD_LEGAL_DONAT_DED_AMT, 0) + NVL(HA.TD_DESIGN_DONAT_DED_AMT, 0)) AS SP_TAX_DED_SUM_AMT      -- 특별 세액  공제 
                             
                           , NVL(HA.STAND_DED_AMT, 0) AS STAND_DED_AMT                                 -- 표준세액공제 
                             
                           , NVL(HA.TAX_DED_TAXGROUP_AMT, 0) AS TAX_DED_TAXGROUP_AMT    -- 세공 - 납세조합
                           , NVL(HA.TAX_DED_HOUSE_DEBT_AMT, 0) AS TAX_DED_HOUSE_DEBT_AMT  -- 세공 - 주택차입금
                           , NVL(HA.TAX_DED_OUTSIDE_PAY_AMT, 0) AS TAX_DED_OUTSIDE_PAY_AMT  -- 세공 - 외국납부
                           , NVL(HA.TD_HOUSE_MONTHLY_AMT, 0) AS TD_HOUSE_MONTHLY_AMT        -- 세공 월세공제 대상 
                           , NVL(HA.TD_HOUSE_MONTHLY_DED_AMT, 0) AS TD_HOUSE_MONTHLY_DED_AMT   -- 세공 월세공제 세액 
                             
                           , ( NVL(HA.TAX_DED_INCOME_AMT, 0) + NVL(HA.TD_CHILD_RAISE_DED_AMT, 0) + 
                               NVL(HA.TD_SCIENTIST_ANNU_DED_AMT, 0) + NVL(HA.TD_WORKER_RETR_ANNU_DED_AMT, 0) + 
                               NVL(HA.TD_ANNU_BANK_DED_AMT, 0) + 
                               NVL(HA.TD_GUAR_INSUR_DED_AMT, 0) + 
                               NVL(HA.TD_POLI_DONAT_DED_AMT1, 0) + NVL(HA.TD_EDUCATION_DED_AMT, 0) +
                               NVL(HA.TD_POLI_DONAT_DED_AMT1, 0) + NVL(HA.TD_POLI_DONAT_DED_AMT2, 0) +
                               NVL(HA.TD_LEGAL_DONAT_DED_AMT, 0) + NVL(HA.TD_DESIGN_DONAT_DED_AMT, 0) +
                               NVL(HA.TAX_DED_TAXGROUP_AMT, 0) + NVL(HA.TAX_DED_HOUSE_DEBT_AMT, 0) + 
                               NVL(HA.TAX_DED_OUTSIDE_PAY_AMT, 0) + NVL(HA.TD_HOUSE_MONTHLY_DED_AMT, 0)
                             ) AS TAX_DED_SUM_AMT      -- 세액공제 합계
                           , NVL(HA.FIX_TAX_AMT, 0) AS FIX_TAX_AMT                       -- 결정세액
                           -- 결정세액
                           , NVL(HA.FIX_IN_TAX_AMT, 0) AS FIX_IN_TAX_AMT        -- 결정 소득세
                           , NVL(HA.FIX_LOCAL_TAX_AMT, 0) AS FIX_LOCAL_TAX_AMT   -- 결정 주민세
                           , NVL(HA.FIX_SP_TAX_AMT, 0) AS FIX_SP_TAX_AMT         -- 결정 농특세
                           , ( NVL(HA.FIX_IN_TAX_AMT, 0) +
                               NVL(HA.FIX_LOCAL_TAX_AMT, 0) +
                               NVL(HA.FIX_SP_TAX_AMT, 0)) AS FIX_TAX_SUM_AMT     -- 결정 세액 합계
                           -- (종전) 기납부 세액
                           , NVL(HPW1.IN_TAX_AMT, 0) AS PRE_IN_TAX_AMT           -- (종전) 소득세 합계
                           , NVL(HPW1.LOCAL_TAX_AMT, 0) AS PRE_LOCAL_TAX_AMT     -- (종전) 주민세 합계
                           , NVL(HPW1.SP_TAX_AMT, 0) AS PRE_SP_TAX_AMT           -- (종전) 농특세 합계
                           , ( NVL(HPW1.IN_TAX_AMT, 0) +
                               NVL(HPW1.LOCAL_TAX_AMT, 0) +
                               NVL(HPW1.SP_TAX_AMT, 0)) AS PRE_TAX_SUM_AMT       -- (종전) 세액 합계
                           -- (주현) 기납부 세액
                           , ( NVL(HA.PRE_IN_TAX_AMT, 0) -
                               NVL(HPW1.IN_TAX_AMT, 0)) AS NOW_IN_TAX_AMT        -- (주현) 소득세
                           , ( NVL(HA.PRE_LOCAL_TAX_AMT, 0) -
                               NVL(HPW1.LOCAL_TAX_AMT, 0)) AS NOW_LOCAL_TAX_AMT  -- (주현) 주민세
                           , ( NVL(HA.PRE_SP_TAX_AMT, 0) -
                               NVL(HPW1.SP_TAX_AMT, 0)) AS NOW_SP_TAX_AMT        -- (주현) 농특세
                           , ( NVL(HA.PRE_IN_TAX_AMT, 0) - NVL(HPW1.IN_TAX_AMT, 0) +
                               NVL(HA.PRE_LOCAL_TAX_AMT, 0) - NVL(HPW1.LOCAL_TAX_AMT, 0) +
                               NVL(HA.PRE_SP_TAX_AMT, 0) - NVL(HPW1.SP_TAX_AMT, 0)) AS NOW_TAX_SUM_AMT  -- (주현) 세액 합계
                           -- 차감 세액
                           , NVL(HA.SUBT_IN_TAX_AMT, 0) AS SUBT_IN_TAX_AMT       -- (차감) 소득세
                           , NVL(HA.SUBT_LOCAL_TAX_AMT, 0) AS SUBT_LOCAL_TAX_AMT -- (차감) 주민세
                           , NVL(HA.SUBT_SP_TAX_AMT, 0) AS SUBT_SP_TAX_AMT       -- (차감) 농특세
                           , ( NVL(HA.SUBT_IN_TAX_AMT, 0) +
                               NVL(HA.SUBT_LOCAL_TAX_AMT, 0) +
                               NVL(HA.SUBT_SP_TAX_AMT, 0)) AS SUBT_TAX_SUM_AMT   -- (차감) 세액 합계          
                           -- 비과세 합계
                           , ( NVL(HA.NONTAX_OUTSIDE_AMT, 0) + NVL(HA.NONTAX_OT_AMT, 0) +  -- NONTAX_OUTSIDE_AMT : 비과세 국외근로 합계
                               NVL(HA.NONTAX_RESEA_AMT, 0) + NVL(HA.NONTAX_ETC_AMT, 0) +
                               NVL(HA.NONTAX_BIRTH_AMT, 0) + NVL(HA.NONTAX_FOREIGNER_AMT, 0) +
                               NVL(HA.NONTAX_SCH_EDU_AMT, 0) + NVL(HA.NONTAX_MEMBER_AMT, 0) +
                               NVL(HA.NONTAX_GUARD_AMT, 0) + NVL(HA.NONTAX_CHILD_AMT, 0) +
                               NVL(HA.NONTAX_HIGH_SCH_AMT, 0) + NVL(HA.NONTAX_SPECIAL_AMT, 0) +
                               NVL(HA.NONTAX_RESEARCH_AMT, 0) + NVL(HA.NONTAX_COMPANY_AMT, 0) +
                               NVL(HA.NONTAX_COVER_AMT, 0) + NVL(HA.NONTAX_WILD_AMT, 0) +
                               NVL(HA.NONTAX_DISASTER_AMT, 0) + NVL(HA.NONTAX_OUTS_GOVER_AMT, 0) +
                               NVL(HA.NONTAX_OUTS_ARMY_AMT, 0) + NVL(HA.NONTAX_STOCK_BENE_AMT, 0) +
                               NVL(HA.NONTAX_FOR_ENG_AMT, 0) + NVL(HA.NONTAX_EMPL_STOCK_AMT, 0) +
                               NVL(HA.NONTAX_EMPL_BENE_AMT_1, 0) + NVL(HA.NONTAX_EMPL_BENE_AMT_2, 0) +
                               NVL(HA.NONTAX_HOUSE_SUBSIDY_AMT, 0) + NVL(HA.NONTAX_SEA_RESOURCE_AMT, 0) +
                               -- 종전--
                               NVL(HA.PRE_NT_OUTSIDE_AMT, 0) + NVL(HA.PRE_NT_OT_AMT, 0) +  -- NONTAX_OUTSIDE_AMT : 비과세 국외근로 합계
                               NVL(HA.PRE_NT_RESEA_AMT, 0) + NVL(HA.PRE_NT_ETC_AMT, 0) +
                               NVL(HA.PRE_NT_BIRTH_AMT, 0) + NVL(HA.PRE_NT_FOREIGNER_AMT, 0) +
                               NVL(HA.PRE_NT_SCH_EDU_AMT, 0) + NVL(HA.PRE_NT_MEMBER_AMT, 0) +
                               NVL(HA.PRE_NT_GUARD_AMT, 0) + NVL(HA.PRE_NT_CHILD_AMT, 0) +
                               NVL(HA.PRE_NT_HIGH_SCH_AMT, 0) + NVL(HA.PRE_NT_SPECIAL_AMT, 0) +
                               NVL(HA.PRE_NT_RESEARCH_AMT, 0) + NVL(HA.PRE_NT_COMPANY_AMT, 0) +
                               NVL(HA.PRE_NT_COVER_AMT, 0) + NVL(HA.PRE_NT_WILD_AMT, 0) +
                               NVL(HA.PRE_NT_DISASTER_AMT, 0) + NVL(HA.PRE_NT_OUTS_GOVER_AMT, 0) +
                               NVL(HA.PRE_NT_OUTS_ARMY_AMT, 0) + NVL(HA.PRE_NT_STOCK_BENE_AMT, 0) +
                               NVL(HA.PRE_NT_FOR_ENG_AMT, 0) + NVL(HA.PRE_NT_EMPL_STOCK_AMT, 0) +
                               NVL(HA.PRE_NT_EMPL_BENE_AMT_1, 0) + NVL(HA.PRE_NT_EMPL_BENE_AMT_2, 0) +
                               NVL(HA.PRE_NT_HOUSE_SUBSIDY_AMT, 0) + NVL(HA.PRE_NT_SEA_RESOURCE_AMT, 0)) AS NONTAX_TOT_AMT  -- 비과세 합계
                           -- 비과세 상세
                           , (NVL(HA.NONTAX_OUTSIDE_AMT, 0) + NVL(HA.PRE_NT_OUTSIDE_AMT, 0)) AS NONTAX_OUTSIDE_AMT -- 비과세 국외근로 합계
                           , (NVL(HA.NONTAX_OT_AMT, 0) + NVL(HA.PRE_NT_OT_AMT, 0)) AS NONTAX_OT_AMT
                           , (NVL(HA.NONTAX_RESEA_AMT, 0) + NVL(HA.PRE_NT_RESEA_AMT, 0)) AS NONTAX_RESEA_AMT
                           , (NVL(HA.NONTAX_ETC_AMT, 0)+ NVL(HA.PRE_NT_ETC_AMT, 0)) AS NONTAX_ETC_AMT
                           , (NVL(HA.NONTAX_BIRTH_AMT, 0) + NVL(HA.PRE_NT_BIRTH_AMT, 0)) AS NONTAX_BIRTH_AMT
                           , (NVL(HA.NONTAX_FOREIGNER_AMT, 0) + NVL(HA.PRE_NT_FOREIGNER_AMT, 0)) AS NONTAX_FOREIGNER_AMT
                           , (NVL(HA.NONTAX_SCH_EDU_AMT, 0) + NVL(HA.PRE_NT_SCH_EDU_AMT, 0)) AS NONTAX_SCH_EDU_AMT
                           , (NVL(HA.NONTAX_MEMBER_AMT, 0) + NVL(HA.PRE_NT_MEMBER_AMT, 0)) AS NONTAX_MEMBER_AMT
                           , (NVL(HA.NONTAX_GUARD_AMT, 0) + NVL(HA.PRE_NT_GUARD_AMT, 0)) AS NONTAX_GUARD_AMT
                           , (NVL(HA.NONTAX_CHILD_AMT, 0) + NVL(HA.PRE_NT_CHILD_AMT, 0)) AS NONTAX_CHILD_AMT
                           , (NVL(HA.NONTAX_HIGH_SCH_AMT, 0) + NVL(HA.PRE_NT_HIGH_SCH_AMT, 0)) AS NONTAX_HIGH_SCH_AMT
                           , (NVL(HA.NONTAX_SPECIAL_AMT, 0) + NVL(HA.PRE_NT_SPECIAL_AMT, 0)) AS NONTAX_SPECIAL_AMT
                           , (NVL(HA.NONTAX_RESEARCH_AMT, 0) + NVL(HA.PRE_NT_RESEARCH_AMT, 0)) AS NONTAX_RESEARCH_AMT
                           , (NVL(HA.NONTAX_COMPANY_AMT, 0) + NVL(HA.PRE_NT_COMPANY_AMT, 0)) AS NONTAX_COMPANY_AMT
                           , (NVL(HA.NONTAX_COVER_AMT, 0) + NVL(HA.PRE_NT_COVER_AMT, 0)) AS NONTAX_COVER_AMT
                           , (NVL(HA.NONTAX_WILD_AMT, 0) + NVL(HA.PRE_NT_WILD_AMT, 0)) AS NONTAX_WILD_AMT
                           , (NVL(HA.NONTAX_DISASTER_AMT, 0) + NVL(HA.PRE_NT_DISASTER_AMT, 0)) AS NONTAX_DISASTER_AMT
                           , (NVL(HA.NONTAX_OUTS_GOVER_AMT, 0) + NVL(HA.PRE_NT_OUTS_GOVER_AMT, 0)) AS NONTAX_OUTS_GOVER_AMT
                           , (NVL(HA.NONTAX_OUTS_ARMY_AMT, 0) + NVL(HA.PRE_NT_OUTS_ARMY_AMT, 0)) AS NONTAX_OUTS_ARMY_AMT
                           , (NVL(HA.NONTAX_OUTS_WORK_1, 0) + NVL(HA.PRE_NT_OUTS_WORK_1, 0)) AS NONTAX_OUTS_WORK_1
                           , (NVL(HA.NONTAX_OUTS_WORK_2, 0) + NVL(HA.PRE_NT_OUTS_WORK_2, 0)) AS NONTAX_OUTS_WORK_2
                           , (NVL(HA.NONTAX_STOCK_BENE_AMT, 0) + NVL(HA.PRE_NT_STOCK_BENE_AMT, 0)) AS NONTAX_STOCK_BENE_AMT
                           , (NVL(HA.NONTAX_FOR_ENG_AMT, 0) + NVL(HA.PRE_NT_FOR_ENG_AMT, 0)) AS NONTAX_FOR_ENG_AMT
                           , (NVL(HA.NONTAX_EMPL_STOCK_AMT, 0) + NVL(HA.PRE_NT_EMPL_STOCK_AMT, 0)) AS NONTAX_EMPL_STOCK_AMT
                           , (NVL(HA.NONTAX_EMPL_BENE_AMT_1, 0) + NVL(HA.PRE_NT_EMPL_BENE_AMT_1, 0)) AS NONTAX_EMPL_BENE_AMT_1
                           , (NVL(HA.NONTAX_EMPL_BENE_AMT_2, 0) + NVL(HA.PRE_NT_EMPL_BENE_AMT_2, 0)) AS NONTAX_EMPL_BENE_AMT_2
                           , (NVL(HA.NONTAX_HOUSE_SUBSIDY_AMT, 0) + NVL(HA.PRE_NT_HOUSE_SUBSIDY_AMT, 0)) AS NONTAX_HOUSE_SUBSIDY_AMT
                           , (NVL(HA.NONTAX_SEA_RESOURCE_AMT, 0) + NVL(HA.PRE_NT_SEA_RESOURCE_AMT, 0)) AS NONTAX_SEA_RESOURCE_AMT
                           , 1 AS SORT_NUM 
                        FROM HRA_YEAR_ADJUSTMENT_1505 HA
                           , HRM_PERSON_MASTER_V      PM
                           , ( -- 종전 납부 세액
                               SELECT HPW.YEAR_YYYY
                                    , HPW.PERSON_ID
                                    , SUM(HPW.IN_TAX_AMT) AS IN_TAX_AMT
                                    , SUM(HPW.LOCAL_TAX_AMT) AS LOCAL_TAX_AMT
                                    , SUM(HPW.SP_TAX_AMT) AS SP_TAX_AMT
                                FROM HRA_PREVIOUS_WORK HPW
                               WHERE HPW.YEAR_YYYY = V_YEAR_YYYY
                                 AND ((W_PERSON_ID IS NULL AND 1 = 1)
                                 OR   (W_PERSON_ID IS NOT NULL AND HPW.PERSON_ID = W_PERSON_ID)) 
                                 AND HPW.SOB_ID    = W_SOB_ID
                                 AND HPW.ORG_ID    = W_ORG_ID
                               GROUP BY HPW.YEAR_YYYY
                                      , HPW.PERSON_ID
                             ) HPW1
                           , (-- 시점 인사내역.
                              SELECT  HL.PERSON_ID
                                    , HL.DEPT_ID
                                    , DM.DEPT_CODE
                                    , DM.DEPT_NAME
                                    , '1' || LPAD(TO_CHAR(DM.DEPT_SORT_NUM), 3, '0') AS DEPT_SORT_NUM
                                    , HL.POST_ID
                                    , HP.POST_NAME
                                    , HP.SORT_NUM AS POST_SORT_NUM
                                    , HL.PAY_GRADE_ID
                                    , HL.JOB_CATEGORY_ID
                                    , HL.FLOOR_ID
                                    , HF.FLOOR_NAME
                                    , HF.SORT_NUM AS FLOOR_SORT_NUM
                                FROM HRM_HISTORY_HEADER HH
                                   , HRM_HISTORY_LINE   HL
                                   , HRM_DEPT_MASTER    DM
                                   , HRM_FLOOR_V        HF
                                   , HRM_POST_CODE_V    HP
                              WHERE HH.HISTORY_HEADER_ID    = HL.HISTORY_HEADER_ID
                                AND HL.DEPT_ID              = DM.DEPT_ID
                                AND HL.FLOOR_ID             = HF.FLOOR_ID
                                AND HL.POST_ID              = HP.POST_ID
                                AND HH.CHARGE_SEQ           IN 
                                      (SELECT MAX(S_HH.CHARGE_SEQ) AS CHARGE_SEQ
                                          FROM HRM_HISTORY_HEADER S_HH
                                             , HRM_HISTORY_LINE   S_HL
                                         WHERE S_HH.HISTORY_HEADER_ID = S_HL.HISTORY_HEADER_ID
                                           AND S_HH.CHARGE_DATE       <= V_END_DATE 
                                           AND S_HL.PERSON_ID         = HL.PERSON_ID
                                         GROUP BY S_HL.PERSON_ID
                                       ) 
                             ) T1
                           , HRM_PERSON_MASTER C_PM
                       WHERE HA.YEAR_YYYY           = HPW1.YEAR_YYYY(+)
                         AND HA.PERSON_ID           = HPW1.PERSON_ID(+)
                         AND HA.PERSON_ID           = PM.PERSON_ID
                         AND PM.PERSON_ID           = T1.PERSON_ID
                         AND HA.CLOSED_PERSON_ID    = C_PM.PERSON_ID(+)
                         AND HA.YEAR_YYYY           = V_YEAR_YYYY
                         AND HA.CORP_ID             = W_CORP_ID 
                         AND HA.SOB_ID              = W_SOB_ID
                         AND HA.ORG_ID              = W_ORG_ID
                         AND HA.SUBMIT_DATE         = V_END_DATE --TO_DATE('2014-12-31', 'YYYY-MM-DD') 
                         AND ((W_PERSON_ID          IS NULL AND 1 = 1)
                         OR   (W_PERSON_ID          IS NOT NULL AND HA.PERSON_ID = W_PERSON_ID))
                         
                         AND PM.CORP_ID             = W_CORP_ID
                         AND PM.SOB_ID              = W_SOB_ID
                         AND PM.ORG_ID              = W_ORG_ID  
                         AND PM.JOIN_DATE           <= V_END_DATE
                         AND (PM.RETIRE_DATE        >= V_END_DATE OR PM.RETIRE_DATE IS NULL)
                            
                         AND ((W_POST_ID            IS NULL AND 1 = 1)
                         OR   (W_POST_ID            IS NOT NULL AND T1.POST_ID = W_POST_ID))
                         AND ((W_FLOOR_ID           IS NULL AND 1 = 1)
                         OR   (W_FLOOR_ID           IS NOT NULL AND T1.FLOOR_ID = W_FLOOR_ID))
                         AND ((W_DEPT_ID            IS NULL AND 1 = 1)
                         OR   (W_DEPT_ID            IS NOT NULL AND T1.DEPT_ID = W_DEPT_ID))
                      ---------
                      UNION ALL
                      ---------
                      SELECT NVL(HA.YEAR_YYYY, NULL) AS YEAR_YYYY
                           , NVL(PM.NAME, NULL) AS NAME
                           , NVL(PM.PERSON_NUM, NULL) AS PERSON_NUM
                           , NVL(PM.REPRE_NUM, NULL) AS REPRE_NUM
                           , NVL(EAPP_REGISTER_AGE_F(PM.REPRE_NUM, V_AGE_STD_DATE, 0), NULL) AS AGE
                           , NVL(T1.DEPT_NAME, NULL) AS DEPT_NAME
                           , NVL(T1.FLOOR_NAME, NULL) AS FLOOR_NAME
                           , NVL(PM.JOIN_DATE, NULL) AS JOIN_DATE
                           , NVL(PM.RETIRE_DATE, NULL) AS RETIRE_DATE
                           , '재정산내역' AS ADJUSTMENT_TYPE 
                           , ( NVL(HA.NOW_PAY_TOT_AMT, 0) + NVL(HA.NOW_BONUS_TOT_AMT, 0) +
                               NVL(HA.NOW_ADD_BONUS_AMT, 0) + NVL(HA.NOW_STOCK_BENE_AMT, 0) +
                               NVL(HA.INCOME_OUTSIDE_AMT, 0) +
                               NVL(HA.NOW_EMPLOYEE_STOCK_AMT, 0) + NVL(HA.NOW_OFFICE_RETIRE_OVER_AMT, 0)) AS NOW_SUM_PAY  -- 주현
                           , ( NVL(HA.PRE_PAY_TOT_AMT, 0) + NVL(HA.PRE_BONUS_TOT_AMT, 0) +
                               NVL(HA.PRE_ADD_BONUS_AMT, 0) + NVL(HA.PRE_STOCK_BENE_AMT, 0) +
                               NVL(HA.PRE_EMPLOYEE_STOCK_AMT, 0) + NVL(HA.PRE_OFFICE_RETIRE_OVER_AMT, 0)) AS PRE_SUM_PAY  -- 종전
                           , NVL(HA.INCOME_TOT_AMT, 0) AS TOTAL_PAY         -- 총급여
                           , NVL(HA.INCOME_DED_AMT, 0) AS INCOME_DED_AMT    -- 근로소득공제
                           , ( NVL(HA.INCOME_TOT_AMT, 0) - NVL(HA.INCOME_DED_AMT, 0)) AS INCOME_AMT  -- 근로소득금액
                           -- 인적공제
                           , NVL(HA.PER_DED_AMT, 0) AS PER_DED_AMT                      -- 본인
                           , NVL(HA.SPOUSE_DED_AMT, 0) AS SPOUSE_DED_AMT                -- 배우자
                           , NVL(HA.SUPP_DED_COUNT, 0) AS SUPP_DED_COUNT                -- 부양가족 인원수
                           , NVL(HA.SUPP_DED_AMT, 0) AS SUPP_DED_AMT                    -- 부양가족 공제금액
                           , NVL(HA.OLD_DED_COUNT1, 0) AS OLD_DED_COUNT1                -- 경로우대 인원수
                           , NVL(HA.OLD_DED_AMT1, 0) AS OLD_DED_AMT1                    -- 경로우대 공제금액
                           , NVL(HA.DISABILITY_DED_COUNT, 0) AS DISABILITY_DED_COUNT    -- 장애인 인원수
                           , NVL(HA.DISABILITY_DED_AMT, 0) AS DISABILITY_DED_AMT        -- 장애인 공제금액
                           , NVL(HA.WOMAN_DED_AMT, 0) AS WOMAN_DED_AMT                  -- 부녀자 공제금액
                           , NVL(HA.SINGLE_PARENT_DED_AMT, 0) AS SINGLE_PARENT_DED_AMT  -- 한부모가족
                           -- 연금보험료 공제
                           , NVL(HA.NATI_ANNU_AMT, 0) AS NATI_ANNU_AMT                  -- 국민연금보험료 공제
                           , NVL(HA.PUBLIC_INSUR_AMT, 0) AS PUBLIC_INSUR_AMT            -- 공무원연금
                           , NVL(HA.MARINE_INSUR_AMT, 0) AS MARINE_INSUR_AMT            -- 군인연금보험
                           , NVL(HA.SCHOOL_STAFF_INSUR_AMT, 0) AS SCHOOL_STAFF_INSUR_AMT  -- 사립학교 교직원연금
                           , NVL(HA.POST_OFFICE_INSUR_AMT, 0) AS POST_OFFICE_INSUR_AMT    -- 별정우체국연금
                             
                           -- 특별공제
                           , NVL(HA.MEDIC_INSUR_AMT, 0) AS MEDIC_INSUR_AMT              -- 건강보험료
                           , NVL(HA.HIRE_INSUR_AMT, 0) AS HIRE_INSUR_AMT                -- 고용보험료
                             
                           , NVL(HA.HOUSE_INTER_AMT, 0) AS HOUSE_INTER_AMT                    -- 주택임차차입금원리금 상환액 - 대출기관
                           , NVL(HA.HOUSE_INTER_AMT_ETC, 0) AS HOUSE_INTER_AMT_ETC            -- 주택임차차입금원리금 상환액 - 거주자
                             
                           , NVL(HA.LONG_HOUSE_PROF_AMT, 0) AS LONG_HOUSE_PROF_AMT            -- 장기주택저당차입금이자상환액 2011년 이전차입분 15년 미만
                           , NVL(HA.LONG_HOUSE_PROF_AMT_1, 0) AS LONG_HOUSE_PROF_AMT_1        -- 장기주택저당차입금이자상환액 2011년 이전차입분 15~29년
                           , NVL(HA.LONG_HOUSE_PROF_AMT_2, 0) AS LONG_HOUSE_PROF_AMT_2        -- 장기주택저당차입금이자상환액 2011년 이전차입분 30년 이상
                           , NVL(HA.LONG_HOUSE_PROF_AMT_3_FIX, 0) AS LONG_HOUSE_PROF_AMT_3_FIX  -- 장기주택저당차입금이자상환액 2012년 이후 차입분 15년 이상 고정금액 등
                           , NVL(HA.LONG_HOUSE_PROF_AMT_3_ETC, 0) AS LONG_HOUSE_PROF_AMT_3_ETC  -- 장기주택저당차입금이자상환액 2012년 이후 차입분 15년 이상 기타대출등
                           /*, ( NVL(HA.LONG_HOUSE_PROF_AMT, 0) +
                               NVL(HA.LONG_HOUSE_PROF_AMT_1, 0) + NVL(HA.LONG_HOUSE_PROF_AMT_2, 0) +
                               NVL(HA.LONG_HOUSE_PROF_AMT_3_FIX, 0) + NVL(HA.LONG_HOUSE_PROF_AMT_3_ETC, 0)) AS LONG_HOUSE_PROF_SUM_AMT  -- 장기주택저당 합계*/
                           , NVL(HA.DONAT_NEXT_ALL, 0) + NVL(HA.DONAT_NEXT_50, 0) + NVL(HA.DONAT_NEXT_30, 0) + NVL(HA.DONAT_NEXT_RELIGION_10, 0) + NVL(HA.DONAT_NEXT_10, 0) AS FORWARD_DONATION_AMT            -- 기부금(이월분)
                             
                          --, NVL(HA.HOUSE_FUND_AMT, 0) AS HOUSE_FUND_AMT                -- 주택자금 합계
                             
                           , ((CASE
                                 WHEN NVL(HA.MEDIC_INSUR_AMT, 0) + NVL(HA.HIRE_INSUR_AMT, 0)  < 0 THEN 0
                                 ELSE NVL(HA.MEDIC_INSUR_AMT, 0) + NVL(HA.HIRE_INSUR_AMT, 0) 
                               END) +
                               NVL(HA.HOUSE_INTER_AMT, 0) +            -- 주택임차차입금원리금 상환액 - 대출기관
                               NVL(HA.HOUSE_INTER_AMT_ETC, 0) +        -- 주택임차차입금원리금 상환액 - 거주자            
                               NVL(HA.LONG_HOUSE_PROF_AMT, 0) +        -- 장기주택저당차입금이자상환액 2011년 이전차입분 15년 미만
                               NVL(HA.LONG_HOUSE_PROF_AMT_1, 0) +      -- 장기주택저당차입금이자상환액 2011년 이전차입분 15~29년
                               NVL(HA.LONG_HOUSE_PROF_AMT_2, 0) +      -- 장기주택저당차입금이자상환액 2011년 이전차입분 30년 이상
                               NVL(HA.LONG_HOUSE_PROF_AMT_3_FIX, 0) +  -- 장기주택저당차입금이자상환액 2012년 이후 차입분 15년 이상 고정금액 등
                               NVL(HA.LONG_HOUSE_PROF_AMT_3_ETC, 0) +  -- 장기주택저당차입금이자상환액 2012년 이후 차입분 15년 이상 기타대출등
                               NVL(HA.DONAT_NEXT_ALL, 0) + NVL(HA.DONAT_NEXT_50, 0) + NVL(HA.DONAT_NEXT_30, 0) + NVL(HA.DONAT_NEXT_RELIGION_10, 0) + NVL(HA.DONAT_NEXT_10, 0)-- 기부금(이월분)
                               ) AS SP_DED_SUM_AMT                       -- 특별소득공제 계 
                                         

                           -- 차감소득금액
                           , NVL(HA.SUBT_DED_AMT, 0) AS SUBT_DED_AMT
                           -- 그밖의 소득공제
                           , NVL(HA.PERS_ANNU_BANK_AMT, 0) AS PERS_ANNU_BANK_AMT        -- 개인연금저축소득공제
                           , NVL(HA.SMALL_CORPOR_DED_AMT, 0) AS SMALL_CORPOR_DED_AMT    -- 소기업/소상공인 공제부금 소득공제
                           , NVL(HA.HOUSE_APP_DEPOSIT_AMT, 0) AS HOUSE_APP_DEPOSIT_AMT  -- 주택청약저축
                           , NVL(HA.HOUSE_APP_SAVE_AMT, 0) AS HOUSE_APP_SAVE_AMT        -- 주택청약종합저축
                           , NVL(HA.WORKER_HOUSE_SAVE_AMT, 0) AS WORKER_HOUSE_SAVE_AMT  -- 근로자주택마련저축
                           , NVL(HA.INVES_AMT, 0) AS INVES_AMT                          -- 투자조합출자등 소득공제
                           /*, ( NVL(HA.HOUSE_APP_DEPOSIT_AMT, 0) + NVL(HA.HOUSE_APP_SAVE_AMT, 0) +
                               NVL(HA.HOUSE_SAVE_AMT, 0) + NVL(HA.WORKER_HOUSE_SAVE_AMT, 0)) AS HOUSE_SAVE_SUM_AMT  -- 주택마련 저축소득공제 합계*/
                             
                           , NVL(HA.CREDIT_AMT, 0) AS CREDIT_AMT                        -- 신용카드등 소득공제
                           , NVL(HA.EMPL_STOCK_AMT, 0) AS EMPL_STOCK_AMT                -- 우리사주조합소득공제
                           , NVL(HA.DONAT_DED_30, 0) AS DONAT_DED_30                    -- 우리사주조합기부금
                           , NVL(HA.HIRE_KEEP_EMPLOY_AMT, 0) AS HIRE_KEEP_EMPLOY_AMT    -- 고용유지중소기업근로자
                           , NVL(HA.FIX_LEASE_DED_AMT, 0) AS FIX_LEASE_DED_AMT          -- 목돈안드는 전세이자상환액
                           , NVL(HA.LONG_SET_INVEST_SAVING_AMT, 0) AS LONG_SET_INVEST_SAVING_AMT -- 장기집합투자증권저축
                             
                           , ( NVL(HA.PERS_ANNU_BANK_AMT, 0) + NVL(HA.SMALL_CORPOR_DED_AMT, 0) +
                               NVL(HA.HOUSE_APP_DEPOSIT_AMT, 0) + NVL(HA.HOUSE_APP_SAVE_AMT, 0) +
                               NVL(HA.WORKER_HOUSE_SAVE_AMT, 0) + NVL(HA.INVES_AMT, 0) +
                               NVL(HA.CREDIT_AMT, 0) + NVL(HA.EMPL_STOCK_AMT, 0) +
                               NVL(HA.DONAT_DED_30, 0) + NVL(HA.HIRE_KEEP_EMPLOY_AMT, 0) +
                               NVL(HA.FIX_LEASE_DED_AMT, 0) + NVL(HA.LONG_SET_INVEST_SAVING_AMT, 0)) AS ETC_DED_SUM_AMT   -- 그밖의 소득공제 합계 금액 --
                           -- 특별공제 종합한도 초과액
                           , NVL(HA.SP_DED_TOT_AMT, 0) AS SP_DED_TOT_AMT                -- 특별공제 종합한도 초과액
                           -- 종합소득 과세표준
                           , NVL(HA.TAX_STD_AMT, 0) AS TAX_STD_AMT                      -- 종합소득 과세표준
                           -- 산출세액
                           , NVL(HA.COMP_TAX_AMT, 0) AS COMP_TAX_AMT                    -- 산출세액
                           -- 세액감면
                           , NVL(HA.TAX_REDU_IN_LAW_AMT, 0) AS TAX_REDU_IN_LAW_AMT      -- 소득세법
                           , NVL(HA.TAX_REDU_SP_LAW_AMT, 0) AS TAX_REDU_SP_LAW_AMT      -- 조세특례 제한법
                           , NVL(HA.TAX_REDU_SMALL_BUSINESS, 0) AS TAX_REDU_SP_LAW_AMT_1                   -- 조세특례 제한법 제30조
                           , NVL(HA.TAX_REDU_TAX_TREATY, 0) AS TAX_REDU_TAX_TREATY      -- 조세조약
                           , ( NVL(HA.TAX_REDU_IN_LAW_AMT, 0) + NVL(HA.TAX_REDU_SP_LAW_AMT, 0) +
                               NVL(HA.TAX_REDU_TAX_TREATY, 0) + NVL(HA.TAX_REDU_SMALL_BUSINESS, 0)) AS TAX_REDU_SUM_AMT      -- 세액감면 합계
                           -- 세액공제
                           , NVL(HA.TAX_DED_INCOME_AMT, 0) AS TAX_DED_INCOME_AMT        -- 세공-근로소득
                           , NVL(HA.TD_CHILD_RAISE_DED_CNT, 0) AS TD_CHILD_RAISE_DED_CNT  -- 세공-자녀양육 인원수 
                           , NVL(HA.TD_CHILD_RAISE_DED_AMT, 0) AS TD_CHILD_RAISE_DED_AMT  -- 세공-자녀양육 금액 
                           , NVL(HA.TD_CHILD_6_UNDER_DED_CNT, 0) AS TD_CHILD_6_UNDER_DED_CNT  -- 세공-자녀 6세이하 인원수 
                           , NVL(HA.TD_CHILD_6_UNDER_DED_AMT, 0) AS TD_CHILD_6_UNDER_DED_AMT  -- 세공-자녀6세이하 금액 
                           , NVL(HA.TD_BIRTH_DED_CNT, 0) AS TD_BIRTH_DED_CNT                  -- 세공-자녀 출생/입양 인원수 
                           , NVL(HA.TD_BIRTH_DED_AMT, 0) AS TD_BIRTH_DED_AMT                  -- 세공-자녀 출생/입양 금액 
                             
                           , NVL(HA.TD_SCIENTIST_ANNU_AMT, 0) AS TD_SCIENTIST_ANNU_AMT                            -- 2014-과학기술인 공제금액
                           , NVL(HA.TD_SCIENTIST_ANNU_DED_AMT, 0) AS TD_SCIENTIST_ANNU_DED_AMT                    -- 2014-과학기술인 세액공제
                           , NVL(HA.TD_WORKER_RETR_ANNU_AMT, 0) AS TD_WORKER_RETR_ANNU_AMT                        -- 2014-퇴직연금  공제금액
                           , NVL(HA.TD_WORKER_RETR_ANNU_DED_AMT, 0) AS TD_WORKER_RETR_ANNU_DED_AMT                -- 2014-퇴직연금 세액공제
                           , NVL(HA.TD_ANNU_BANK_AMT, 0) AS TD_ANNU_BANK_AMT                                      -- 2014-연금저축 공제금액
                           , NVL(HA.TD_ANNU_BANK_DED_AMT, 0) AS TD_ANNU_BANK_DED_AMT                              -- 2014-연금저축 세액공제
                              
                           , ( NVL(HA.TD_GUAR_INSUR_AMT, 0) + 
                               NVL(HA.TD_DISABILITY_INSUR_AMT, 0)) AS TD_GUAR_INSUR_AMT                           -- 2014-세감 ( 보장성보험 공제금액)
                           , ( NVL(HA.TD_GUAR_INSUR_DED_AMT, 0) + 
                               NVL(HA.TD_DISABILITY_INSUR_DED_AMT, 0)) AS TD_GUAR_INSUR_DED_AMT                   -- 2014-세감 ( 보장성보험 세액공제)
                              
                           , NVL(HA.TD_MEDIC_AMT, 0) AS TD_MEDIC_AMT                                              -- 2014-세감 (의료비 공제금액)
                           , NVL(HA.TD_MEDIC_DED_AMT, 0) AS TD_MEDIC_DED_AMT                                      -- 2014-세감 (의료비 세액공제)
                              
                           , NVL(HA.TD_EDUCATION_AMT, 0) AS TD_EDUCATION_AMT                                      -- 2014-세감 (교육비 공제금액)
                           , NVL(HA.TD_EDUCATION_DED_AMT, 0) AS TD_EDUCATION_DED_AMT                              -- 2014-세감 (교육비 세액공제) 
                              
                           , NVL(HA.TD_POLI_DONAT_AMT1, 0) AS TD_POLI_DONAT_AMT1                                       -- 2014-세감 (정치자금기부금-10만원이하) 공제금액
                           , NVL(HA.TD_POLI_DONAT_DED_AMT1, 0) AS TD_POLI_DONAT_DED_AMT1                                 -- 2014-세감 (정치자금기부금-10만원이하) 세액공제
                           , NVL(HA.TD_POLI_DONAT_AMT2, 0) AS TD_POLI_DONAT_AMT2                                       -- 2014-세감 (정치자금기부금-10만원초과) 공제금액
                           , NVL(HA.TD_POLI_DONAT_DED_AMT2, 0) AS TD_POLI_DONAT_DED_AMT2                                 -- 2014-세감 (정치자금기부금-10만원이하) 세액공제
                           , NVL(HA.TD_LEGAL_DONAT_AMT, 0) AS TD_LEGAL_DONAT_AMT                                       -- 2014-세감 (법정기부금) 공제금액
                           , NVL(HA.TD_LEGAL_DONAT_DED_AMT, 0) AS TD_LEGAL_DONAT_DED_AMT                                 -- 2014-세감 (법정기부금) 세액공제
                           , NVL(HA.TD_DESIGN_DONAT_AMT, 0) AS TD_DESIGN_DONAT_AMT                                    -- 2014-세감 (지정기부금) 공제금액
                           , NVL(HA.TD_DESIGN_DONAT_DED_AMT, 0) AS TD_DESIGN_DONAT_DED_AMT                               -- 2014-세감 (지정기부금) 세액공제
                             
                           , ( NVL(HA.TD_GUAR_INSUR_DED_AMT, 0) + NVL(HA.TD_DISABILITY_INSUR_DED_AMT, 0) + 
                               NVL(HA.TD_POLI_DONAT_DED_AMT1, 0) + NVL(HA.TD_EDUCATION_DED_AMT, 0) +
                               NVL(HA.TD_POLI_DONAT_DED_AMT1, 0) + NVL(HA.TD_POLI_DONAT_DED_AMT2, 0) +
                               NVL(HA.TD_LEGAL_DONAT_DED_AMT, 0) + NVL(HA.TD_DESIGN_DONAT_DED_AMT, 0)) AS SP_TAX_DED_SUM_AMT      -- 특별 세액  공제 
                             
                           , NVL(HA.STAND_DED_AMT, 0) AS STAND_DED_AMT                                 -- 표준세액공제 
                             
                           , NVL(HA.TAX_DED_TAXGROUP_AMT, 0) AS TAX_DED_TAXGROUP_AMT    -- 세공 - 납세조합
                           , NVL(HA.TAX_DED_HOUSE_DEBT_AMT, 0) AS TAX_DED_HOUSE_DEBT_AMT  -- 세공 - 주택차입금
                           , NVL(HA.TAX_DED_OUTSIDE_PAY_AMT, 0) AS TAX_DED_OUTSIDE_PAY_AMT  -- 세공 - 외국납부
                           , NVL(HA.TD_HOUSE_MONTHLY_AMT, 0) AS TD_HOUSE_MONTHLY_AMT        -- 세공 월세공제 대상 
                           , NVL(HA.TD_HOUSE_MONTHLY_DED_AMT, 0) AS TD_HOUSE_MONTHLY_DED_AMT   -- 세공 월세공제 세액 
                             
                           , ( NVL(HA.TAX_DED_INCOME_AMT, 0) + NVL(HA.TD_CHILD_RAISE_DED_AMT, 0) + 
                               NVL(HA.TD_CHILD_6_UNDER_DED_AMT, 0) + NVL(HA.TD_BIRTH_DED_AMT, 0) + 
                               NVL(HA.TD_SCIENTIST_ANNU_DED_AMT, 0) + NVL(HA.TD_WORKER_RETR_ANNU_DED_AMT, 0) + 
                               NVL(HA.TD_ANNU_BANK_DED_AMT, 0) + 
                               NVL(HA.TD_GUAR_INSUR_DED_AMT, 0) + NVL(HA.TD_DISABILITY_INSUR_DED_AMT, 0) + 
                               NVL(HA.TD_POLI_DONAT_DED_AMT1, 0) + NVL(HA.TD_EDUCATION_DED_AMT, 0) +
                               NVL(HA.TD_POLI_DONAT_DED_AMT1, 0) + NVL(HA.TD_POLI_DONAT_DED_AMT2, 0) +
                               NVL(HA.TD_LEGAL_DONAT_DED_AMT, 0) + NVL(HA.TD_DESIGN_DONAT_DED_AMT, 0) +
                               NVL(HA.TAX_DED_TAXGROUP_AMT, 0) + NVL(HA.TAX_DED_HOUSE_DEBT_AMT, 0) + 
                               NVL(HA.TAX_DED_OUTSIDE_PAY_AMT, 0) + NVL(HA.TD_HOUSE_MONTHLY_DED_AMT, 0)
                             ) AS TAX_DED_SUM_AMT      -- 세액공제 합계
                           , NVL(HA.FIX_TAX_AMT, 0) AS FIX_TAX_AMT                       -- 결정세액
                           -- 결정세액
                           , NVL(HA.FIX_IN_TAX_AMT, 0) AS FIX_IN_TAX_AMT        -- 결정 소득세
                           , NVL(HA.FIX_LOCAL_TAX_AMT, 0) AS FIX_LOCAL_TAX_AMT   -- 결정 주민세
                           , NVL(HA.FIX_SP_TAX_AMT, 0) AS FIX_SP_TAX_AMT         -- 결정 농특세
                           , ( NVL(HA.FIX_IN_TAX_AMT, 0) +
                               NVL(HA.FIX_LOCAL_TAX_AMT, 0) +
                               NVL(HA.FIX_SP_TAX_AMT, 0)) AS FIX_TAX_SUM_AMT     -- 결정 세액 합계
                           -- (종전) 기납부 세액
                           , NVL(HPW1.IN_TAX_AMT, 0) AS PRE_IN_TAX_AMT           -- (종전) 소득세 합계
                           , NVL(HPW1.LOCAL_TAX_AMT, 0) AS PRE_LOCAL_TAX_AMT     -- (종전) 주민세 합계
                           , NVL(HPW1.SP_TAX_AMT, 0) AS PRE_SP_TAX_AMT           -- (종전) 농특세 합계
                           , ( NVL(HPW1.IN_TAX_AMT, 0) +
                             NVL(HPW1.LOCAL_TAX_AMT, 0) +
                             NVL(HPW1.SP_TAX_AMT, 0)) AS PRE_TAX_SUM_AMT       -- (종전) 세액 합계
                         -- (주현) 기납부 세액
                         , ( NVL(HA.PRE_IN_TAX_AMT, 0) -
                             NVL(HPW1.IN_TAX_AMT, 0)) AS NOW_IN_TAX_AMT        -- (주현) 소득세
                         , ( NVL(HA.PRE_LOCAL_TAX_AMT, 0) -
                             NVL(HPW1.LOCAL_TAX_AMT, 0)) AS NOW_LOCAL_TAX_AMT  -- (주현) 주민세
                         , ( NVL(HA.PRE_SP_TAX_AMT, 0) -
                             NVL(HPW1.SP_TAX_AMT, 0)) AS NOW_SP_TAX_AMT        -- (주현) 농특세
                         , ( NVL(HA.PRE_IN_TAX_AMT, 0) - NVL(HPW1.IN_TAX_AMT, 0) +
                             NVL(HA.PRE_LOCAL_TAX_AMT, 0) - NVL(HPW1.LOCAL_TAX_AMT, 0) +
                             NVL(HA.PRE_SP_TAX_AMT, 0) - NVL(HPW1.SP_TAX_AMT, 0)) AS NOW_TAX_SUM_AMT  -- (주현) 세액 합계
                         -- 차감 세액
                         , NVL(HA.SUBT_IN_TAX_AMT, 0) AS SUBT_IN_TAX_AMT       -- (차감) 소득세
                         , NVL(HA.SUBT_LOCAL_TAX_AMT, 0) AS SUBT_LOCAL_TAX_AMT -- (차감) 주민세
                         , NVL(HA.SUBT_SP_TAX_AMT, 0) AS SUBT_SP_TAX_AMT       -- (차감) 농특세
                         , ( NVL(HA.SUBT_IN_TAX_AMT, 0) +
                             NVL(HA.SUBT_LOCAL_TAX_AMT, 0) +
                             NVL(HA.SUBT_SP_TAX_AMT, 0)) AS SUBT_TAX_SUM_AMT   -- (차감) 세액 합계          
                         -- 비과세 합계
                         , ( NVL(HA.NONTAX_OUTSIDE_AMT, 0) + NVL(HA.NONTAX_OT_AMT, 0) +  -- NONTAX_OUTSIDE_AMT : 비과세 국외근로 합계
                             NVL(HA.NONTAX_RESEA_AMT, 0) + NVL(HA.NONTAX_ETC_AMT, 0) +
                             NVL(HA.NONTAX_BIRTH_AMT, 0) + NVL(HA.NONTAX_FOREIGNER_AMT, 0) +
                             NVL(HA.NONTAX_SCH_EDU_AMT, 0) + NVL(HA.NONTAX_MEMBER_AMT, 0) +
                             NVL(HA.NONTAX_GUARD_AMT, 0) + NVL(HA.NONTAX_CHILD_AMT, 0) +
                             NVL(HA.NONTAX_HIGH_SCH_AMT, 0) + NVL(HA.NONTAX_SPECIAL_AMT, 0) +
                             NVL(HA.NONTAX_RESEARCH_AMT, 0) + NVL(HA.NONTAX_COMPANY_AMT, 0) +
                             NVL(HA.NONTAX_COVER_AMT, 0) + NVL(HA.NONTAX_WILD_AMT, 0) +
                             NVL(HA.NONTAX_DISASTER_AMT, 0) + NVL(HA.NONTAX_OUTS_GOVER_AMT, 0) +
                             NVL(HA.NONTAX_OUTS_ARMY_AMT, 0) + NVL(HA.NONTAX_STOCK_BENE_AMT, 0) +
                             NVL(HA.NONTAX_FOR_ENG_AMT, 0) + NVL(HA.NONTAX_EMPL_STOCK_AMT, 0) +
                             NVL(HA.NONTAX_EMPL_BENE_AMT_1, 0) + NVL(HA.NONTAX_EMPL_BENE_AMT_2, 0) +
                             NVL(HA.NONTAX_HOUSE_SUBSIDY_AMT, 0) + NVL(HA.NONTAX_SEA_RESOURCE_AMT, 0) +
                             -- 종전--
                             NVL(HA.PRE_NT_OUTSIDE_AMT, 0) + NVL(HA.PRE_NT_OT_AMT, 0) +  -- NONTAX_OUTSIDE_AMT : 비과세 국외근로 합계
                             NVL(HA.PRE_NT_RESEA_AMT, 0) + NVL(HA.PRE_NT_ETC_AMT, 0) +
                             NVL(HA.PRE_NT_BIRTH_AMT, 0) + NVL(HA.PRE_NT_FOREIGNER_AMT, 0) +
                             NVL(HA.PRE_NT_SCH_EDU_AMT, 0) + NVL(HA.PRE_NT_MEMBER_AMT, 0) +
                             NVL(HA.PRE_NT_GUARD_AMT, 0) + NVL(HA.PRE_NT_CHILD_AMT, 0) +
                             NVL(HA.PRE_NT_HIGH_SCH_AMT, 0) + NVL(HA.PRE_NT_SPECIAL_AMT, 0) +
                             NVL(HA.PRE_NT_RESEARCH_AMT, 0) + NVL(HA.PRE_NT_COMPANY_AMT, 0) +
                             NVL(HA.PRE_NT_COVER_AMT, 0) + NVL(HA.PRE_NT_WILD_AMT, 0) +
                             NVL(HA.PRE_NT_DISASTER_AMT, 0) + NVL(HA.PRE_NT_OUTS_GOVER_AMT, 0) +
                             NVL(HA.PRE_NT_OUTS_ARMY_AMT, 0) + NVL(HA.PRE_NT_STOCK_BENE_AMT, 0) +
                             NVL(HA.PRE_NT_FOR_ENG_AMT, 0) + NVL(HA.PRE_NT_EMPL_STOCK_AMT, 0) +
                             NVL(HA.PRE_NT_EMPL_BENE_AMT_1, 0) + NVL(HA.PRE_NT_EMPL_BENE_AMT_2, 0) +
                             NVL(HA.PRE_NT_HOUSE_SUBSIDY_AMT, 0) + NVL(HA.PRE_NT_SEA_RESOURCE_AMT, 0)) AS NONTAX_TOT_AMT  -- 비과세 합계
                         -- 비과세 상세
                         , (NVL(HA.NONTAX_OUTSIDE_AMT, 0) + NVL(HA.PRE_NT_OUTSIDE_AMT, 0)) AS NONTAX_OUTSIDE_AMT -- 비과세 국외근로 합계
                         , (NVL(HA.NONTAX_OT_AMT, 0) + NVL(HA.PRE_NT_OT_AMT, 0)) AS NONTAX_OT_AMT
                         , (NVL(HA.NONTAX_RESEA_AMT, 0) + NVL(HA.PRE_NT_RESEA_AMT, 0)) AS NONTAX_RESEA_AMT
                         , (NVL(HA.NONTAX_ETC_AMT, 0)+ NVL(HA.PRE_NT_ETC_AMT, 0)) AS NONTAX_ETC_AMT
                         , (NVL(HA.NONTAX_BIRTH_AMT, 0) + NVL(HA.PRE_NT_BIRTH_AMT, 0)) AS NONTAX_BIRTH_AMT
                         , (NVL(HA.NONTAX_FOREIGNER_AMT, 0) + NVL(HA.PRE_NT_FOREIGNER_AMT, 0)) AS NONTAX_FOREIGNER_AMT
                         , (NVL(HA.NONTAX_SCH_EDU_AMT, 0) + NVL(HA.PRE_NT_SCH_EDU_AMT, 0)) AS NONTAX_SCH_EDU_AMT
                         , (NVL(HA.NONTAX_MEMBER_AMT, 0) + NVL(HA.PRE_NT_MEMBER_AMT, 0)) AS NONTAX_MEMBER_AMT
                         , (NVL(HA.NONTAX_GUARD_AMT, 0) + NVL(HA.PRE_NT_GUARD_AMT, 0)) AS NONTAX_GUARD_AMT
                         , (NVL(HA.NONTAX_CHILD_AMT, 0) + NVL(HA.PRE_NT_CHILD_AMT, 0)) AS NONTAX_CHILD_AMT
                         , (NVL(HA.NONTAX_HIGH_SCH_AMT, 0) + NVL(HA.PRE_NT_HIGH_SCH_AMT, 0)) AS NONTAX_HIGH_SCH_AMT
                         , (NVL(HA.NONTAX_SPECIAL_AMT, 0) + NVL(HA.PRE_NT_SPECIAL_AMT, 0)) AS NONTAX_SPECIAL_AMT
                         , (NVL(HA.NONTAX_RESEARCH_AMT, 0) + NVL(HA.PRE_NT_RESEARCH_AMT, 0)) AS NONTAX_RESEARCH_AMT
                         , (NVL(HA.NONTAX_COMPANY_AMT, 0) + NVL(HA.PRE_NT_COMPANY_AMT, 0)) AS NONTAX_COMPANY_AMT
                         , (NVL(HA.NONTAX_COVER_AMT, 0) + NVL(HA.PRE_NT_COVER_AMT, 0)) AS NONTAX_COVER_AMT
                         , (NVL(HA.NONTAX_WILD_AMT, 0) + NVL(HA.PRE_NT_WILD_AMT, 0)) AS NONTAX_WILD_AMT
                         , (NVL(HA.NONTAX_DISASTER_AMT, 0) + NVL(HA.PRE_NT_DISASTER_AMT, 0)) AS NONTAX_DISASTER_AMT
                         , (NVL(HA.NONTAX_OUTS_GOVER_AMT, 0) + NVL(HA.PRE_NT_OUTS_GOVER_AMT, 0)) AS NONTAX_OUTS_GOVER_AMT
                         , (NVL(HA.NONTAX_OUTS_ARMY_AMT, 0) + NVL(HA.PRE_NT_OUTS_ARMY_AMT, 0)) AS NONTAX_OUTS_ARMY_AMT
                         , (NVL(HA.NONTAX_OUTS_WORK_1, 0) + NVL(HA.PRE_NT_OUTS_WORK_1, 0)) AS NONTAX_OUTS_WORK_1
                         , (NVL(HA.NONTAX_OUTS_WORK_2, 0) + NVL(HA.PRE_NT_OUTS_WORK_2, 0)) AS NONTAX_OUTS_WORK_2
                         , (NVL(HA.NONTAX_STOCK_BENE_AMT, 0) + NVL(HA.PRE_NT_STOCK_BENE_AMT, 0)) AS NONTAX_STOCK_BENE_AMT
                         , (NVL(HA.NONTAX_FOR_ENG_AMT, 0) + NVL(HA.PRE_NT_FOR_ENG_AMT, 0)) AS NONTAX_FOR_ENG_AMT
                         , (NVL(HA.NONTAX_EMPL_STOCK_AMT, 0) + NVL(HA.PRE_NT_EMPL_STOCK_AMT, 0)) AS NONTAX_EMPL_STOCK_AMT
                         , (NVL(HA.NONTAX_EMPL_BENE_AMT_1, 0) + NVL(HA.PRE_NT_EMPL_BENE_AMT_1, 0)) AS NONTAX_EMPL_BENE_AMT_1
                         , (NVL(HA.NONTAX_EMPL_BENE_AMT_2, 0) + NVL(HA.PRE_NT_EMPL_BENE_AMT_2, 0)) AS NONTAX_EMPL_BENE_AMT_2
                         , (NVL(HA.NONTAX_HOUSE_SUBSIDY_AMT, 0) + NVL(HA.PRE_NT_HOUSE_SUBSIDY_AMT, 0)) AS NONTAX_HOUSE_SUBSIDY_AMT
                         , (NVL(HA.NONTAX_SEA_RESOURCE_AMT, 0) + NVL(HA.PRE_NT_SEA_RESOURCE_AMT, 0)) AS NONTAX_SEA_RESOURCE_AMT
                         , 2 AS SORT_NUM 
                      FROM HRA_YEAR_ADJUSTMENT HA
                         , HRM_PERSON_MASTER_V   PM
                         , ( -- 종전 납부 세액
                             SELECT HPW.YEAR_YYYY
                                  , HPW.PERSON_ID
                                  , SUM(HPW.IN_TAX_AMT) AS IN_TAX_AMT
                                  , SUM(HPW.LOCAL_TAX_AMT) AS LOCAL_TAX_AMT
                                  , SUM(HPW.SP_TAX_AMT) AS SP_TAX_AMT
                              FROM HRA_PREVIOUS_WORK HPW
                             WHERE HPW.YEAR_YYYY = V_YEAR_YYYY
                               AND ((W_PERSON_ID IS NULL AND 1 = 1)
                               OR   (W_PERSON_ID IS NOT NULL AND HPW.PERSON_ID = W_PERSON_ID)) 
                               AND HPW.SOB_ID    = W_SOB_ID
                               AND HPW.ORG_ID    = W_ORG_ID
                             GROUP BY HPW.YEAR_YYYY
                                    , HPW.PERSON_ID
                           ) HPW1
                         , (-- 시점 인사내역.
                            SELECT  HL.PERSON_ID
                                  , HL.DEPT_ID
                                  , DM.DEPT_CODE
                                  , DM.DEPT_NAME
                                  , '1' || LPAD(TO_CHAR(DM.DEPT_SORT_NUM), 3, '0') AS DEPT_SORT_NUM
                                  , HL.POST_ID
                                  , HP.POST_NAME
                                  , HP.SORT_NUM AS POST_SORT_NUM
                                  , HL.PAY_GRADE_ID
                                  , HL.JOB_CATEGORY_ID
                                  , HL.FLOOR_ID
                                  , HF.FLOOR_NAME
                                  , HF.SORT_NUM AS FLOOR_SORT_NUM
                              FROM HRM_HISTORY_HEADER HH
                                 , HRM_HISTORY_LINE   HL
                                 , HRM_DEPT_MASTER    DM
                                 , HRM_FLOOR_V        HF
                                 , HRM_POST_CODE_V    HP
                            WHERE HH.HISTORY_HEADER_ID    = HL.HISTORY_HEADER_ID
                              AND HL.DEPT_ID              = DM.DEPT_ID
                              AND HL.FLOOR_ID             = HF.FLOOR_ID
                              AND HL.POST_ID              = HP.POST_ID
                              AND HH.CHARGE_SEQ           IN 
                                    (SELECT MAX(S_HH.CHARGE_SEQ) AS CHARGE_SEQ
                                        FROM HRM_HISTORY_HEADER S_HH
                                           , HRM_HISTORY_LINE   S_HL
                                       WHERE S_HH.HISTORY_HEADER_ID = S_HL.HISTORY_HEADER_ID
                                         AND S_HH.CHARGE_DATE       <= V_END_DATE 
                                         AND S_HL.PERSON_ID         = HL.PERSON_ID
                                       GROUP BY S_HL.PERSON_ID
                                     ) 
                           ) T1
                         , HRM_PERSON_MASTER C_PM
                     WHERE HA.YEAR_YYYY           = HPW1.YEAR_YYYY(+)
                       AND HA.PERSON_ID           = HPW1.PERSON_ID(+)
                       AND HA.PERSON_ID           = PM.PERSON_ID
                       AND PM.PERSON_ID           = T1.PERSON_ID
                       AND HA.CLOSED_PERSON_ID    = C_PM.PERSON_ID(+)
                       AND HA.YEAR_YYYY           = V_YEAR_YYYY
                       AND HA.CORP_ID             = W_CORP_ID 
                       AND HA.SOB_ID              = W_SOB_ID
                       AND HA.ORG_ID              = W_ORG_ID
                       AND HA.SUBMIT_DATE         = V_END_DATE --TO_DATE('2014-12-31', 'YYYY-MM-DD') 
                       AND ((W_PERSON_ID          IS NULL AND 1 = 1)
                       OR   (W_PERSON_ID          IS NOT NULL AND HA.PERSON_ID = W_PERSON_ID))
                       
                       AND PM.CORP_ID             = W_CORP_ID
                       AND PM.SOB_ID              = W_SOB_ID
                       AND PM.ORG_ID              = W_ORG_ID                          
                       AND PM.JOIN_DATE           <= V_END_DATE
                       AND (PM.RETIRE_DATE        >= V_END_DATE OR PM.RETIRE_DATE IS NULL)
                          
                       AND ((W_POST_ID            IS NULL AND 1 = 1)
                       OR   (W_POST_ID            IS NOT NULL AND T1.POST_ID = W_POST_ID))
                       AND ((W_FLOOR_ID           IS NULL AND 1 = 1)
                       OR   (W_FLOOR_ID           IS NOT NULL AND T1.FLOOR_ID = W_FLOOR_ID))
                       AND ((W_DEPT_ID            IS NULL AND 1 = 1)
                       OR   (W_DEPT_ID            IS NOT NULL AND T1.DEPT_ID = W_DEPT_ID))       
                  ) T1
            ---------     
            UNION ALL
            ---------
            SELECT T2.YEAR_YYYY
                 , T2.NAME
                 , T2.PERSON_NUM
                 , T2.REPRE_NUM
                 , T2.AGE
                 , T2.DEPT_NAME
                 , T2.FLOOR_NAME
                 , T2.JOIN_DATE
                 , T2.RETIRE_DATE
                 , '차감내역' AS ADJUSTMENT_TYPE 
                 , SUM(NVL(T2.NOW_SUM_PAY, 0) * T2.SIGN_FLAG) AS NOW_SUM_PAY  -- 주현
                 , SUM(NVL(T2.PRE_SUM_PAY, 0) * T2.SIGN_FLAG) AS PRE_SUM_PAY  -- 종전
                 , SUM(NVL(T2.TOTAL_PAY, 0) * T2.SIGN_FLAG) AS TOTAL_PAY         -- 총급여
                 , SUM(NVL(T2.INCOME_DED_AMT, 0) * T2.SIGN_FLAG) AS INCOME_DED_AMT    -- 근로소득공제
                 , SUM(NVL(T2.INCOME_AMT, 0) * T2.SIGN_FLAG) AS INCOME_AMT  -- 근로소득금액
                 -- 인적공제
                 , SUM(NVL(T2.PER_DED_AMT, 0) * T2.SIGN_FLAG) AS PER_DED_AMT                      -- 본인
                 , SUM(NVL(T2.SPOUSE_DED_AMT, 0) * T2.SIGN_FLAG) AS SPOUSE_DED_AMT                -- 배우자
                 , SUM(NVL(T2.SUPP_DED_COUNT, 0) * T2.SIGN_FLAG) AS SUPP_DED_COUNT                -- 부양가족 인원수
                 , SUM(NVL(T2.SUPP_DED_AMT, 0) * T2.SIGN_FLAG) AS SUPP_DED_AMT                    -- 부양가족 공제금액
                 , SUM(NVL(T2.OLD_DED_COUNT1, 0) * T2.SIGN_FLAG) AS OLD_DED_COUNT1                -- 경로우대 인원수
                 , SUM(NVL(T2.OLD_DED_AMT1, 0) * T2.SIGN_FLAG) AS OLD_DED_AMT1                    -- 경로우대 공제금액
                 , SUM(NVL(T2.DISABILITY_DED_COUNT, 0) * T2.SIGN_FLAG) AS DISABILITY_DED_COUNT    -- 장애인 인원수
                 , SUM(NVL(T2.DISABILITY_DED_AMT, 0) * T2.SIGN_FLAG) AS DISABILITY_DED_AMT        -- 장애인 공제금액
                 , SUM(NVL(T2.WOMAN_DED_AMT, 0) * T2.SIGN_FLAG) AS WOMAN_DED_AMT                  -- 부녀자 공제금액
                 , SUM(NVL(T2.SINGLE_PARENT_DED_AMT, 0) * T2.SIGN_FLAG) AS SINGLE_PARENT_DED_AMT  -- 한부모가족
                 -- 연금보험료 공제
                 , SUM(NVL(T2.NATI_ANNU_AMT, 0) * T2.SIGN_FLAG) AS NATI_ANNU_AMT                  -- 국민연금보험료 공제
                 , SUM(NVL(T2.PUBLIC_INSUR_AMT, 0) * T2.SIGN_FLAG) AS PUBLIC_INSUR_AMT            -- 공무원연금
                 , SUM(NVL(T2.MARINE_INSUR_AMT, 0) * T2.SIGN_FLAG) AS MARINE_INSUR_AMT            -- 군인연금보험
                 , SUM(NVL(T2.SCHOOL_STAFF_INSUR_AMT, 0) * T2.SIGN_FLAG) AS SCHOOL_STAFF_INSUR_AMT  -- 사립학교 교직원연금
                 , SUM(NVL(T2.POST_OFFICE_INSUR_AMT, 0) * T2.SIGN_FLAG) AS POST_OFFICE_INSUR_AMT    -- 별정우체국연금
                           
                 -- 특별공제
                 , SUM(NVL(T2.MEDIC_INSUR_AMT, 0) * T2.SIGN_FLAG) AS MEDIC_INSUR_AMT              -- 건강보험료
                 , SUM(NVL(T2.HIRE_INSUR_AMT, 0) * T2.SIGN_FLAG) AS HIRE_INSUR_AMT                -- 고용보험료
                           
                 , SUM(NVL(T2.HOUSE_INTER_AMT, 0) * T2.SIGN_FLAG) AS HOUSE_INTER_AMT                    -- 주택임차차입금원리금 상환액 - 대출기관
                 , SUM(NVL(T2.HOUSE_INTER_AMT_ETC, 0) * T2.SIGN_FLAG) AS HOUSE_INTER_AMT_ETC            -- 주택임차차입금원리금 상환액 - 거주자
                           
                 , SUM(NVL(T2.LONG_HOUSE_PROF_AMT, 0) * T2.SIGN_FLAG) AS LONG_HOUSE_PROF_AMT            -- 장기주택저당차입금이자상환액 2011년 이전차입분 15년 미만
                 , SUM(NVL(T2.LONG_HOUSE_PROF_AMT_1, 0) * T2.SIGN_FLAG) AS LONG_HOUSE_PROF_AMT_1        -- 장기주택저당차입금이자상환액 2011년 이전차입분 15~29년
                 , SUM(NVL(T2.LONG_HOUSE_PROF_AMT_2, 0) * T2.SIGN_FLAG) AS LONG_HOUSE_PROF_AMT_2        -- 장기주택저당차입금이자상환액 2011년 이전차입분 30년 이상
                 , SUM(NVL(T2.LONG_HOUSE_PROF_AMT_3_FIX, 0) * T2.SIGN_FLAG) AS LONG_HOUSE_PROF_AMT_3_FIX  -- 장기주택저당차입금이자상환액 2012년 이후 차입분 15년 이상 고정금액 등
                 , SUM(NVL(T2.LONG_HOUSE_PROF_AMT_3_ETC, 0) * T2.SIGN_FLAG) AS LONG_HOUSE_PROF_AMT_3_ETC  -- 장기주택저당차입금이자상환액 2012년 이후 차입분 15년 이상 기타대출등
                 , SUM(NVL(T2.FORWARD_DONATION_AMT, 0) * T2.SIGN_FLAG) AS FORWARD_DONATION_AMT            -- 기부금(이월분)
                           
                 , SUM(NVL(T2.SP_DED_SUM_AMT, 0) * T2.SIGN_FLAG) AS SP_DED_SUM_AMT                       -- 특별소득공제 계 

                 -- 차감소득금액
                 , SUM(NVL(T2.SUBT_DED_AMT, 0) * T2.SIGN_FLAG) AS SUBT_DED_AMT
                 -- 그밖의 소득공제
                 , SUM(NVL(T2.PERS_ANNU_BANK_AMT, 0) * T2.SIGN_FLAG) AS PERS_ANNU_BANK_AMT        -- 개인연금저축소득공제
                 , SUM(NVL(T2.SMALL_CORPOR_DED_AMT, 0) * T2.SIGN_FLAG) AS SMALL_CORPOR_DED_AMT    -- 소기업/소상공인 공제부금 소득공제
                 , SUM(NVL(T2.HOUSE_APP_DEPOSIT_AMT, 0) * T2.SIGN_FLAG) AS HOUSE_APP_DEPOSIT_AMT  -- 주택청약저축
                 , SUM(NVL(T2.HOUSE_APP_SAVE_AMT, 0) * T2.SIGN_FLAG) AS HOUSE_APP_SAVE_AMT        -- 주택청약종합저축
                 , SUM(NVL(T2.WORKER_HOUSE_SAVE_AMT, 0) * T2.SIGN_FLAG) AS WORKER_HOUSE_SAVE_AMT  -- 근로자주택마련저축
                 , SUM(NVL(T2.INVES_AMT, 0) * T2.SIGN_FLAG) AS INVES_AMT                          -- 투자조합출자등 소득공제
                           
                 , SUM(NVL(T2.CREDIT_AMT, 0) * T2.SIGN_FLAG) AS CREDIT_AMT                        -- 신용카드등 소득공제
                 , SUM(NVL(T2.EMPL_STOCK_AMT, 0) * T2.SIGN_FLAG) AS EMPL_STOCK_AMT                -- 우리사주조합소득공제
                 , SUM(NVL(T2.DONAT_DED_30, 0) * T2.SIGN_FLAG) AS DONAT_DED_30                    -- 우리사주조합기부금
                 , SUM(NVL(T2.HIRE_KEEP_EMPLOY_AMT, 0) * T2.SIGN_FLAG) AS HIRE_KEEP_EMPLOY_AMT    -- 고용유지중소기업근로자
                 , SUM(NVL(T2.FIX_LEASE_DED_AMT, 0) * T2.SIGN_FLAG) AS FIX_LEASE_DED_AMT          -- 목돈안드는 전세이자상환액
                 , SUM(NVL(T2.LONG_SET_INVEST_SAVING_AMT, 0) * T2.SIGN_FLAG) AS LONG_SET_INVEST_SAVING_AMT -- 장기집합투자증권저축
                           
                 , SUM(NVL(T2.ETC_DED_SUM_AMT, 0) * T2.SIGN_FLAG) AS ETC_DED_SUM_AMT   -- 그밖의 소득공제 합계 금액 --
                 -- 특별공제 종합한도 초과액
                 , SUM(NVL(T2.SP_DED_TOT_AMT, 0) * T2.SIGN_FLAG) AS SP_DED_TOT_AMT                -- 특별공제 종합한도 초과액
                 -- 종합소득 과세표준
                 , SUM(NVL(T2.TAX_STD_AMT, 0) * T2.SIGN_FLAG) AS TAX_STD_AMT                      -- 종합소득 과세표준
                 -- 산출세액
                 , SUM(NVL(T2.COMP_TAX_AMT, 0) * T2.SIGN_FLAG) AS COMP_TAX_AMT                    -- 산출세액
                 -- 세액감면
                 , SUM(NVL(T2.TAX_REDU_IN_LAW_AMT, 0) * T2.SIGN_FLAG) AS TAX_REDU_IN_LAW_AMT      -- 소득세법
                 , SUM(NVL(T2.TAX_REDU_SP_LAW_AMT, 0) * T2.SIGN_FLAG) AS TAX_REDU_SP_LAW_AMT      -- 조세특례 제한법
                 , SUM(NVL(T2.TAX_REDU_SP_LAW_AMT_1, 0) * T2.SIGN_FLAG) AS TAX_REDU_SP_LAW_AMT_1                   -- 조세특례 제한법 제30조
                 , SUM(NVL(T2.TAX_REDU_TAX_TREATY, 0) * T2.SIGN_FLAG) AS TAX_REDU_TAX_TREATY      -- 조세조약
                 , SUM(NVL(T2.TAX_REDU_SUM_AMT, 0) * T2.SIGN_FLAG) AS TAX_REDU_SUM_AMT            -- 세액감면 합계
                 -- 세액공제
                 , SUM(NVL(T2.TAX_DED_INCOME_AMT, 0) * T2.SIGN_FLAG) AS TAX_DED_INCOME_AMT        -- 세공-근로소득
                 , SUM(NVL(T2.TD_CHILD_RAISE_DED_CNT, 0) * T2.SIGN_FLAG) AS TD_CHILD_RAISE_DED_CNT  -- 세공-자녀양육 인원수 
                 , SUM(NVL(T2.TD_CHILD_RAISE_DED_AMT, 0) * T2.SIGN_FLAG) AS TD_CHILD_RAISE_DED_AMT  -- 세공-자녀양육 금액 
                 , SUM(NVL(T2.TD_CHILD_6_UNDER_DED_CNT, 0) * T2.SIGN_FLAG) AS TD_CHILD_6_UNDER_DED_CNT  -- 세공-자녀 6세이하 인원수 
                 , SUM(NVL(T2.TD_CHILD_6_UNDER_DED_AMT, 0) * T2.SIGN_FLAG) AS TD_CHILD_6_UNDER_DED_AMT  -- 세공-자녀6세이하 금액 
                 , SUM(NVL(T2.TD_BIRTH_DED_CNT, 0) * T2.SIGN_FLAG) AS TD_BIRTH_DED_CNT                  -- 세공-자녀 출생/입양 인원수 
                 , SUM(NVL(T2.TD_BIRTH_DED_AMT, 0) * T2.SIGN_FLAG) AS TD_BIRTH_DED_AMT                  -- 세공-자녀 출생/입양 금액 
                           
                 , SUM(NVL(T2.TD_SCIENTIST_ANNU_AMT, 0) * T2.SIGN_FLAG) AS TD_SCIENTIST_ANNU_AMT                            -- 2014-과학기술인 공제금액
                 , SUM(NVL(T2.TD_SCIENTIST_ANNU_DED_AMT, 0) * T2.SIGN_FLAG) AS TD_SCIENTIST_ANNU_DED_AMT                   -- 2014-과학기술인 세액공제
                 , SUM(NVL(T2.TD_WORKER_RETR_ANNU_AMT, 0) * T2.SIGN_FLAG) AS TD_WORKER_RETR_ANNU_AMT                        -- 2014-퇴직연금  공제금액
                 , SUM(NVL(T2.TD_WORKER_RETR_ANNU_DED_AMT, 0) * T2.SIGN_FLAG) AS TD_WORKER_RETR_ANNU_DED_AMT                -- 2014-퇴직연금 세액공제
                 , SUM(NVL(T2.TD_ANNU_BANK_AMT, 0) * T2.SIGN_FLAG) AS TD_ANNU_BANK_AMT                                      -- 2014-연금저축 공제금액
                 , SUM(NVL(T2.TD_ANNU_BANK_DED_AMT, 0) * T2.SIGN_FLAG) AS TD_ANNU_BANK_DED_AMT                              -- 2014-연금저축 세액공제
                            
                 , SUM(NVL(T2.TD_GUAR_INSUR_AMT, 0) * T2.SIGN_FLAG) AS TD_GUAR_INSUR_AMT                          -- 2014-세감 ( 보장성보험 공제금액)
                 , SUM(NVL(T2.TD_GUAR_INSUR_DED_AMT, 0) * T2.SIGN_FLAG) AS TD_GUAR_INSUR_DED_AMT                  -- 2014-세감 ( 보장성보험 세액공제)
                            
                 , SUM(NVL(T2.TD_MEDIC_AMT, 0) * T2.SIGN_FLAG) AS TD_MEDIC_AMT                                              -- 2014-세감 (의료비 공제금액)
                 , SUM(NVL(T2.TD_MEDIC_DED_AMT, 0) * T2.SIGN_FLAG) AS TD_MEDIC_DED_AMT                                      -- 2014-세감 (의료비 세액공제)
                            
                 , SUM(NVL(T2.TD_EDUCATION_AMT, 0) * T2.SIGN_FLAG) AS TD_EDUCATION_AMT                                      -- 2014-세감 (교육비 공제금액)
                 , SUM(NVL(T2.TD_EDUCATION_DED_AMT, 0) * T2.SIGN_FLAG) AS TD_EDUCATION_DED_AMT                              -- 2014-세감 (교육비 세액공제) 
                            
                 , SUM(NVL(T2.TD_POLI_DONAT_AMT1, 0) * T2.SIGN_FLAG) AS TD_POLI_DONAT_AMT1                                  -- 2014-세감 (정치자금기부금-10만원이하) 공제금액
                 , SUM(NVL(T2.TD_POLI_DONAT_DED_AMT1, 0) * T2.SIGN_FLAG) AS TD_POLI_DONAT_DED_AMT1                          -- 2014-세감 (정치자금기부금-10만원이하) 세액공제
                 , SUM(NVL(T2.TD_POLI_DONAT_AMT2, 0) * T2.SIGN_FLAG) AS TD_POLI_DONAT_AMT2                                       -- 2014-세감 (정치자금기부금-10만원초과) 공제금액
                 , SUM(NVL(T2.TD_POLI_DONAT_DED_AMT2, 0) * T2.SIGN_FLAG) AS TD_POLI_DONAT_DED_AMT2                                 -- 2014-세감 (정치자금기부금-10만원이하) 세액공제
                 , SUM(NVL(T2.TD_LEGAL_DONAT_AMT, 0) * T2.SIGN_FLAG) AS TD_LEGAL_DONAT_AMT                                       -- 2014-세감 (법정기부금) 공제금액
                 , SUM(NVL(T2.TD_LEGAL_DONAT_DED_AMT, 0) * T2.SIGN_FLAG) AS TD_LEGAL_DONAT_DED_AMT                                 -- 2014-세감 (법정기부금) 세액공제
                 , SUM(NVL(T2.TD_DESIGN_DONAT_AMT, 0) * T2.SIGN_FLAG) AS TD_DESIGN_DONAT_AMT                                    -- 2014-세감 (지정기부금) 공제금액
                 , SUM(NVL(T2.TD_DESIGN_DONAT_DED_AMT, 0) * T2.SIGN_FLAG) AS TD_DESIGN_DONAT_DED_AMT                               -- 2014-세감 (지정기부금) 세액공제
                           
                 , SUM(NVL(T2.SP_TAX_DED_SUM_AMT, 0) * T2.SIGN_FLAG) AS SP_TAX_DED_SUM_AMT      -- 특별 세액  공제 
                           
                 , SUM(NVL(T2.STAND_DED_AMT, 0) * T2.SIGN_FLAG) AS STAND_DED_AMT                                 -- 표준세액공제 
                           
                 , SUM(NVL(T2.TAX_DED_TAXGROUP_AMT, 0) * T2.SIGN_FLAG) AS TAX_DED_TAXGROUP_AMT    -- 세공 - 납세조합
                 , SUM(NVL(T2.TAX_DED_HOUSE_DEBT_AMT, 0) * T2.SIGN_FLAG) AS TAX_DED_HOUSE_DEBT_AMT  -- 세공 - 주택차입금
                 , SUM(NVL(T2.TAX_DED_OUTSIDE_PAY_AMT, 0) * T2.SIGN_FLAG) AS TAX_DED_OUTSIDE_PAY_AMT  -- 세공 - 외국납부
                 , SUM(NVL(T2.TD_HOUSE_MONTHLY_AMT, 0) * T2.SIGN_FLAG) AS TD_HOUSE_MONTHLY_AMT        -- 세공 월세공제 대상 
                 , SUM(NVL(T2.TD_HOUSE_MONTHLY_DED_AMT, 0) * T2.SIGN_FLAG) AS TD_HOUSE_MONTHLY_DED_AMT   -- 세공 월세공제 세액 
                           
                 , SUM(NVL(T2.TAX_DED_SUM_AMT, 0) * T2.SIGN_FLAG) AS TAX_DED_SUM_AMT      -- 세액공제 합계
                 , SUM(NVL(T2.FIX_TAX_AMT, 0) * T2.SIGN_FLAG) AS FIX_TAX_AMT                      -- 결정세액
                 -- 결정세액
                 , SUM(NVL(T2.FIX_IN_TAX_AMT, 0) * T2.SIGN_FLAG) AS FIX_IN_TAX_AMT        -- 결정 소득세
                 , SUM(NVL(T2.FIX_LOCAL_TAX_AMT, 0) * T2.SIGN_FLAG) AS FIX_LOCAL_TAX_AMT   -- 결정 주민세
                 , SUM(NVL(T2.FIX_SP_TAX_AMT, 0) * T2.SIGN_FLAG) AS FIX_SP_TAX_AMT         -- 결정 농특세
                 , SUM(NVL(T2.FIX_TAX_SUM_AMT, 0) * T2.SIGN_FLAG) AS FIX_TAX_SUM_AMT     -- 결정 세액 합계
                 -- (종전) 기납부 세액
                 , SUM(NVL(T2.PRE_IN_TAX_AMT, 0) * T2.SIGN_FLAG) AS PRE_IN_TAX_AMT           -- (종전) 소득세 합계
                 , SUM(NVL(T2.PRE_LOCAL_TAX_AMT, 0) * T2.SIGN_FLAG) AS PRE_LOCAL_TAX_AMT     -- (종전) 주민세 합계
                 , SUM(NVL(T2.PRE_SP_TAX_AMT, 0) * T2.SIGN_FLAG) AS PRE_SP_TAX_AMT           -- (종전) 농특세 합계
                 , SUM(NVL(T2.PRE_TAX_SUM_AMT, 0) * T2.SIGN_FLAG) AS PRE_TAX_SUM_AMT       -- (종전) 세액 합계
                 -- (주현) 기납부 세액
                 , SUM(NVL(T2.NOW_IN_TAX_AMT, 0) * T2.SIGN_FLAG) AS NOW_IN_TAX_AMT        -- (주현) 소득세
                 , SUM(NVL(T2.NOW_LOCAL_TAX_AMT, 0) * T2.SIGN_FLAG) AS NOW_LOCAL_TAX_AMT  -- (주현) 주민세
                 , SUM(NVL(T2.NOW_SP_TAX_AMT, 0) * T2.SIGN_FLAG) AS NOW_SP_TAX_AMT        -- (주현) 농특세
                 , SUM(NVL(T2.NOW_TAX_SUM_AMT, 0) * T2.SIGN_FLAG) AS NOW_TAX_SUM_AMT  -- (주현) 세액 합계
                 -- 차감 세액
                 , SUM(NVL(T2.SUBT_IN_TAX_AMT, 0) * T2.SIGN_FLAG) AS SUBT_IN_TAX_AMT       -- (차감) 소득세
                 , SUM(NVL(T2.SUBT_LOCAL_TAX_AMT, 0) * T2.SIGN_FLAG) AS SUBT_LOCAL_TAX_AMT -- (차감) 주민세
                 , SUM(NVL(T2.SUBT_SP_TAX_AMT, 0) * T2.SIGN_FLAG) AS SUBT_SP_TAX_AMT       -- (차감) 농특세
                 , SUM(NVL(T2.SUBT_TAX_SUM_AMT, 0) * T2.SIGN_FLAG) AS SUBT_TAX_SUM_AMT   -- (차감) 세액 합계          
                 -- 비과세 합계
                 , SUM(NVL(T2.NONTAX_TOT_AMT, 0) * T2.SIGN_FLAG) AS NONTAX_TOT_AMT  -- 비과세 합계
                 -- 비과세 상세
                 , SUM(NVL(T2.NONTAX_OUTSIDE_AMT, 0) * T2.SIGN_FLAG) AS NONTAX_OUTSIDE_AMT -- 비과세 국외근로 합계
                 , SUM(NVL(T2.NONTAX_OT_AMT, 0) * T2.SIGN_FLAG) AS NONTAX_OT_AMT
                 , SUM(NVL(T2.NONTAX_RESEA_AMT, 0) * T2.SIGN_FLAG) AS NONTAX_RESEA_AMT
                 , SUM(NVL(T2.NONTAX_ETC_AMT, 0) * T2.SIGN_FLAG) AS NONTAX_ETC_AMT
                 , SUM(NVL(T2.NONTAX_BIRTH_AMT, 0) * T2.SIGN_FLAG) AS NONTAX_BIRTH_AMT
                 , SUM(NVL(T2.NONTAX_FOREIGNER_AMT, 0) * T2.SIGN_FLAG) AS NONTAX_FOREIGNER_AMT
                 , SUM(NVL(T2.NONTAX_SCH_EDU_AMT, 0) * T2.SIGN_FLAG) AS NONTAX_SCH_EDU_AMT
                 , SUM(NVL(T2.NONTAX_MEMBER_AMT, 0) * T2.SIGN_FLAG) AS NONTAX_MEMBER_AMT
                 , SUM(NVL(T2.NONTAX_GUARD_AMT, 0) * T2.SIGN_FLAG) AS NONTAX_GUARD_AMT
                 , SUM(NVL(T2.NONTAX_CHILD_AMT, 0) * T2.SIGN_FLAG) AS NONTAX_CHILD_AMT
                 , SUM(NVL(T2.NONTAX_HIGH_SCH_AMT, 0) * T2.SIGN_FLAG) AS NONTAX_HIGH_SCH_AMT
                 , SUM(NVL(T2.NONTAX_SPECIAL_AMT, 0) * T2.SIGN_FLAG) AS NONTAX_SPECIAL_AMT
                 , SUM(NVL(T2.NONTAX_RESEARCH_AMT, 0) * T2.SIGN_FLAG) AS NONTAX_RESEARCH_AMT
                 , SUM(NVL(T2.NONTAX_COMPANY_AMT, 0) * T2.SIGN_FLAG) AS NONTAX_COMPANY_AMT
                 , SUM(NVL(T2.NONTAX_COVER_AMT, 0) * T2.SIGN_FLAG) AS NONTAX_COVER_AMT
                 , SUM(NVL(T2.NONTAX_WILD_AMT, 0) * T2.SIGN_FLAG) AS NONTAX_WILD_AMT
                 , SUM(NVL(T2.NONTAX_DISASTER_AMT, 0) * T2.SIGN_FLAG) AS NONTAX_DISASTER_AMT
                 , SUM(NVL(T2.NONTAX_OUTS_GOVER_AMT, 0) * T2.SIGN_FLAG) AS NONTAX_OUTS_GOVER_AMT
                 , SUM(NVL(T2.NONTAX_OUTS_ARMY_AMT, 0) * T2.SIGN_FLAG) AS NONTAX_OUTS_ARMY_AMT
                 , SUM(NVL(T2.NONTAX_OUTS_WORK_1, 0) * T2.SIGN_FLAG) AS NONTAX_OUTS_WORK_1
                 , SUM(NVL(T2.NONTAX_OUTS_WORK_2, 0) * T2.SIGN_FLAG) AS NONTAX_OUTS_WORK_2
                 , SUM(NVL(T2.NONTAX_STOCK_BENE_AMT, 0) * T2.SIGN_FLAG) AS NONTAX_STOCK_BENE_AMT
                 , SUM(NVL(T2.NONTAX_FOR_ENG_AMT, 0) * T2.SIGN_FLAG) AS NONTAX_FOR_ENG_AMT
                 , SUM(NVL(T2.NONTAX_EMPL_STOCK_AMT, 0) * T2.SIGN_FLAG) AS NONTAX_EMPL_STOCK_AMT
                 , SUM(NVL(T2.NONTAX_EMPL_BENE_AMT_1, 0) * T2.SIGN_FLAG) AS NONTAX_EMPL_BENE_AMT_1
                 , SUM(NVL(T2.NONTAX_EMPL_BENE_AMT_2, 0) * T2.SIGN_FLAG) AS NONTAX_EMPL_BENE_AMT_2
                 , SUM(NVL(T2.NONTAX_HOUSE_SUBSIDY_AMT, 0) * T2.SIGN_FLAG) AS NONTAX_HOUSE_SUBSIDY_AMT
                 , SUM(NVL(T2.NONTAX_SEA_RESOURCE_AMT, 0) * T2.SIGN_FLAG) AS NONTAX_SEA_RESOURCE_AMT
                 , 3 AS SORT_NUM 
              FROM (SELECT NVL(HA.YEAR_YYYY, NULL) AS YEAR_YYYY
                         , NVL(PM.NAME, NULL) AS NAME
                         , NVL(PM.PERSON_NUM, NULL) AS PERSON_NUM
                         , NVL(PM.REPRE_NUM, NULL) AS REPRE_NUM
                         , NVL(EAPP_REGISTER_AGE_F(PM.REPRE_NUM, V_AGE_STD_DATE, 0), NULL) AS AGE
                         , NVL(T1.DEPT_NAME, NULL) AS DEPT_NAME
                         , NVL(T1.FLOOR_NAME, NULL) AS FLOOR_NAME
                         , NVL(PM.JOIN_DATE, NULL) AS JOIN_DATE
                         , NVL(PM.RETIRE_DATE, NULL) AS RETIRE_DATE
                         , ( NVL(HA.NOW_PAY_TOT_AMT, 0) + NVL(HA.NOW_BONUS_TOT_AMT, 0) +
                             NVL(HA.NOW_ADD_BONUS_AMT, 0) + NVL(HA.NOW_STOCK_BENE_AMT, 0) +
                             NVL(HA.INCOME_OUTSIDE_AMT, 0) +
                             NVL(HA.NOW_EMPLOYEE_STOCK_AMT, 0) + NVL(HA.NOW_OFFICE_RETIRE_OVER_AMT, 0)) AS NOW_SUM_PAY  -- 주현
                         , ( NVL(HA.PRE_PAY_TOT_AMT, 0) + NVL(HA.PRE_BONUS_TOT_AMT, 0) +
                             NVL(HA.PRE_ADD_BONUS_AMT, 0) + NVL(HA.PRE_STOCK_BENE_AMT, 0) +
                             NVL(HA.PRE_EMPLOYEE_STOCK_AMT, 0) + NVL(HA.PRE_OFFICE_RETIRE_OVER_AMT, 0)) AS PRE_SUM_PAY  -- 종전
                         , NVL(HA.INCOME_TOT_AMT, 0) AS TOTAL_PAY         -- 총급여
                         , NVL(HA.INCOME_DED_AMT, 0) AS INCOME_DED_AMT    -- 근로소득공제
                         , ( NVL(HA.INCOME_TOT_AMT, 0) - NVL(HA.INCOME_DED_AMT, 0)) AS INCOME_AMT  -- 근로소득금액
                         -- 인적공제
                         , NVL(HA.PER_DED_AMT, 0) AS PER_DED_AMT                      -- 본인
                         , NVL(HA.SPOUSE_DED_AMT, 0) AS SPOUSE_DED_AMT                -- 배우자
                         , NVL(HA.SUPP_DED_COUNT, 0) AS SUPP_DED_COUNT                -- 부양가족 인원수
                         , NVL(HA.SUPP_DED_AMT, 0) AS SUPP_DED_AMT                    -- 부양가족 공제금액
                         , NVL(HA.OLD_DED_COUNT1, 0) AS OLD_DED_COUNT1                -- 경로우대 인원수
                         , NVL(HA.OLD_DED_AMT1, 0) AS OLD_DED_AMT1                    -- 경로우대 공제금액
                         , NVL(HA.DISABILITY_DED_COUNT, 0) AS DISABILITY_DED_COUNT    -- 장애인 인원수
                         , NVL(HA.DISABILITY_DED_AMT, 0) AS DISABILITY_DED_AMT        -- 장애인 공제금액
                         , NVL(HA.WOMAN_DED_AMT, 0) AS WOMAN_DED_AMT                  -- 부녀자 공제금액
                         , NVL(HA.SINGLE_PARENT_DED_AMT, 0) AS SINGLE_PARENT_DED_AMT  -- 한부모가족
                         -- 연금보험료 공제
                         , NVL(HA.NATI_ANNU_AMT, 0) AS NATI_ANNU_AMT                  -- 국민연금보험료 공제
                         , NVL(HA.PUBLIC_INSUR_AMT, 0) AS PUBLIC_INSUR_AMT            -- 공무원연금
                         , NVL(HA.MARINE_INSUR_AMT, 0) AS MARINE_INSUR_AMT            -- 군인연금보험
                         , NVL(HA.SCHOOL_STAFF_INSUR_AMT, 0) AS SCHOOL_STAFF_INSUR_AMT  -- 사립학교 교직원연금
                         , NVL(HA.POST_OFFICE_INSUR_AMT, 0) AS POST_OFFICE_INSUR_AMT    -- 별정우체국연금
                           
                         -- 특별공제
                         , NVL(HA.MEDIC_INSUR_AMT, 0) AS MEDIC_INSUR_AMT              -- 건강보험료
                         , NVL(HA.HIRE_INSUR_AMT, 0) AS HIRE_INSUR_AMT                -- 고용보험료
                           
                         , NVL(HA.HOUSE_INTER_AMT, 0) AS HOUSE_INTER_AMT                    -- 주택임차차입금원리금 상환액 - 대출기관
                         , NVL(HA.HOUSE_INTER_AMT_ETC, 0) AS HOUSE_INTER_AMT_ETC            -- 주택임차차입금원리금 상환액 - 거주자
                           
                         , NVL(HA.LONG_HOUSE_PROF_AMT, 0) AS LONG_HOUSE_PROF_AMT            -- 장기주택저당차입금이자상환액 2011년 이전차입분 15년 미만
                         , NVL(HA.LONG_HOUSE_PROF_AMT_1, 0) AS LONG_HOUSE_PROF_AMT_1        -- 장기주택저당차입금이자상환액 2011년 이전차입분 15~29년
                         , NVL(HA.LONG_HOUSE_PROF_AMT_2, 0) AS LONG_HOUSE_PROF_AMT_2        -- 장기주택저당차입금이자상환액 2011년 이전차입분 30년 이상
                         , NVL(HA.LONG_HOUSE_PROF_AMT_3_FIX, 0) AS LONG_HOUSE_PROF_AMT_3_FIX  -- 장기주택저당차입금이자상환액 2012년 이후 차입분 15년 이상 고정금액 등
                         , NVL(HA.LONG_HOUSE_PROF_AMT_3_ETC, 0) AS LONG_HOUSE_PROF_AMT_3_ETC  -- 장기주택저당차입금이자상환액 2012년 이후 차입분 15년 이상 기타대출등
                         /*, ( NVL(HA.LONG_HOUSE_PROF_AMT, 0) +
                             NVL(HA.LONG_HOUSE_PROF_AMT_1, 0) + NVL(HA.LONG_HOUSE_PROF_AMT_2, 0) +
                             NVL(HA.LONG_HOUSE_PROF_AMT_3_FIX, 0) + NVL(HA.LONG_HOUSE_PROF_AMT_3_ETC, 0)) AS LONG_HOUSE_PROF_SUM_AMT  -- 장기주택저당 합계*/
                         , NVL(HA.DONAT_NEXT_ALL, 0) + NVL(HA.DONAT_NEXT_50, 0) + NVL(HA.DONAT_NEXT_30, 0) + NVL(HA.DONAT_NEXT_RELIGION_10, 0) + NVL(HA.DONAT_NEXT_10, 0) AS FORWARD_DONATION_AMT            -- 기부금(이월분)
                           
                        --, NVL(HA.HOUSE_FUND_AMT, 0) AS HOUSE_FUND_AMT                -- 주택자금 합계
                           
                         , ((CASE
                               WHEN NVL(HA.MEDIC_INSUR_AMT, 0) + NVL(HA.HIRE_INSUR_AMT, 0)  < 0 THEN 0
                               ELSE NVL(HA.MEDIC_INSUR_AMT, 0) + NVL(HA.HIRE_INSUR_AMT, 0) 
                             END) +
                             NVL(HA.HOUSE_INTER_AMT, 0) +            -- 주택임차차입금원리금 상환액 - 대출기관
                             NVL(HA.HOUSE_INTER_AMT_ETC, 0) +        -- 주택임차차입금원리금 상환액 - 거주자            
                             NVL(HA.LONG_HOUSE_PROF_AMT, 0) +        -- 장기주택저당차입금이자상환액 2011년 이전차입분 15년 미만
                             NVL(HA.LONG_HOUSE_PROF_AMT_1, 0) +      -- 장기주택저당차입금이자상환액 2011년 이전차입분 15~29년
                             NVL(HA.LONG_HOUSE_PROF_AMT_2, 0) +      -- 장기주택저당차입금이자상환액 2011년 이전차입분 30년 이상
                             NVL(HA.LONG_HOUSE_PROF_AMT_3_FIX, 0) +  -- 장기주택저당차입금이자상환액 2012년 이후 차입분 15년 이상 고정금액 등
                             NVL(HA.LONG_HOUSE_PROF_AMT_3_ETC, 0) +  -- 장기주택저당차입금이자상환액 2012년 이후 차입분 15년 이상 기타대출등
                             NVL(HA.DONAT_NEXT_ALL, 0) + NVL(HA.DONAT_NEXT_50, 0) + NVL(HA.DONAT_NEXT_30, 0) + NVL(HA.DONAT_NEXT_RELIGION_10, 0) + NVL(HA.DONAT_NEXT_10, 0)-- 기부금(이월분)
                             ) AS SP_DED_SUM_AMT                       -- 특별소득공제 계 
                                       

                         -- 차감소득금액
                         , NVL(HA.SUBT_DED_AMT, 0) AS SUBT_DED_AMT
                         -- 그밖의 소득공제
                         , NVL(HA.PERS_ANNU_BANK_AMT, 0) AS PERS_ANNU_BANK_AMT        -- 개인연금저축소득공제
                         , NVL(HA.SMALL_CORPOR_DED_AMT, 0) AS SMALL_CORPOR_DED_AMT    -- 소기업/소상공인 공제부금 소득공제
                         , NVL(HA.HOUSE_APP_DEPOSIT_AMT, 0) AS HOUSE_APP_DEPOSIT_AMT  -- 주택청약저축
                         , NVL(HA.HOUSE_APP_SAVE_AMT, 0) AS HOUSE_APP_SAVE_AMT        -- 주택청약종합저축
                         , NVL(HA.WORKER_HOUSE_SAVE_AMT, 0) AS WORKER_HOUSE_SAVE_AMT  -- 근로자주택마련저축
                         , NVL(HA.INVES_AMT, 0) AS INVES_AMT                          -- 투자조합출자등 소득공제
                         /*, ( NVL(HA.HOUSE_APP_DEPOSIT_AMT, 0) + NVL(HA.HOUSE_APP_SAVE_AMT, 0) +
                             NVL(HA.HOUSE_SAVE_AMT, 0) + NVL(HA.WORKER_HOUSE_SAVE_AMT, 0)) AS HOUSE_SAVE_SUM_AMT  -- 주택마련 저축소득공제 합계*/
                           
                         , NVL(HA.CREDIT_AMT, 0) AS CREDIT_AMT                        -- 신용카드등 소득공제
                         , NVL(HA.EMPL_STOCK_AMT, 0) AS EMPL_STOCK_AMT                -- 우리사주조합소득공제
                         , NVL(HA.DONAT_DED_30, 0) AS DONAT_DED_30                    -- 우리사주조합기부금
                         , NVL(HA.HIRE_KEEP_EMPLOY_AMT, 0) AS HIRE_KEEP_EMPLOY_AMT    -- 고용유지중소기업근로자
                         , NVL(HA.FIX_LEASE_DED_AMT, 0) AS FIX_LEASE_DED_AMT          -- 목돈안드는 전세이자상환액
                         , NVL(HA.LONG_SET_INVEST_SAVING_AMT, 0) AS LONG_SET_INVEST_SAVING_AMT -- 장기집합투자증권저축
                           
                         , ( NVL(HA.PERS_ANNU_BANK_AMT, 0) + NVL(HA.SMALL_CORPOR_DED_AMT, 0) +
                             NVL(HA.HOUSE_APP_DEPOSIT_AMT, 0) + NVL(HA.HOUSE_APP_SAVE_AMT, 0) +
                             NVL(HA.WORKER_HOUSE_SAVE_AMT, 0) + NVL(HA.INVES_AMT, 0) +
                             NVL(HA.CREDIT_AMT, 0) + NVL(HA.EMPL_STOCK_AMT, 0) +
                             NVL(HA.DONAT_DED_30, 0) + NVL(HA.HIRE_KEEP_EMPLOY_AMT, 0) +
                             NVL(HA.FIX_LEASE_DED_AMT, 0) + NVL(HA.LONG_SET_INVEST_SAVING_AMT, 0)) AS ETC_DED_SUM_AMT   -- 그밖의 소득공제 합계 금액 --
                         -- 특별공제 종합한도 초과액
                         , NVL(HA.SP_DED_TOT_AMT, 0) AS SP_DED_TOT_AMT                -- 특별공제 종합한도 초과액
                         -- 종합소득 과세표준
                         , NVL(HA.TAX_STD_AMT, 0) AS TAX_STD_AMT                      -- 종합소득 과세표준
                         -- 산출세액
                         , NVL(HA.COMP_TAX_AMT, 0) AS COMP_TAX_AMT                    -- 산출세액
                         -- 세액감면
                         , NVL(HA.TAX_REDU_IN_LAW_AMT, 0) AS TAX_REDU_IN_LAW_AMT      -- 소득세법
                         , NVL(HA.TAX_REDU_SP_LAW_AMT, 0) AS TAX_REDU_SP_LAW_AMT      -- 조세특례 제한법
                         , NVL(HA.TAX_REDU_SMALL_BUSINESS, 0) AS TAX_REDU_SP_LAW_AMT_1                   -- 조세특례 제한법 제30조
                         , NVL(HA.TAX_REDU_TAX_TREATY, 0) AS TAX_REDU_TAX_TREATY      -- 조세조약
                         , ( NVL(HA.TAX_REDU_IN_LAW_AMT, 0) + NVL(HA.TAX_REDU_SP_LAW_AMT, 0) +
                             NVL(HA.TAX_REDU_TAX_TREATY, 0) + NVL(HA.TAX_REDU_SMALL_BUSINESS, 0)) AS TAX_REDU_SUM_AMT      -- 세액감면 합계
                         -- 세액공제
                         , NVL(HA.TAX_DED_INCOME_AMT, 0) AS TAX_DED_INCOME_AMT        -- 세공-근로소득
                         , 0 AS TD_CHILD_RAISE_DED_CNT  -- 세공-자녀양육 인원수 
                         , NVL(HA.TD_CHILD_RAISE_DED_AMT, 0) AS TD_CHILD_RAISE_DED_AMT  -- 세공-자녀양육 금액 
                         , 0 AS TD_CHILD_6_UNDER_DED_CNT  -- 세공-자녀 6세이하 인원수 
                         , 0 AS TD_CHILD_6_UNDER_DED_AMT  -- 세공-자녀6세이하 금액 
                         , 0 AS TD_BIRTH_DED_CNT                  -- 세공-자녀 출생/입양 인원수 
                         , 0 AS TD_BIRTH_DED_AMT                  -- 세공-자녀 출생/입양 금액 
                           
                         , NVL(HA.TD_SCIENTIST_ANNU_AMT, 0) AS TD_SCIENTIST_ANNU_AMT                            -- 2014-과학기술인 공제금액
                         , NVL(HA.TD_SCIENTIST_ANNU_DED_AMT, 0) AS TD_SCIENTIST_ANNU_DED_AMT                    -- 2014-과학기술인 세액공제
                         , NVL(HA.TD_WORKER_RETR_ANNU_AMT, 0) AS TD_WORKER_RETR_ANNU_AMT                        -- 2014-퇴직연금  공제금액
                         , NVL(HA.TD_WORKER_RETR_ANNU_DED_AMT, 0) AS TD_WORKER_RETR_ANNU_DED_AMT                -- 2014-퇴직연금 세액공제
                         , NVL(HA.TD_ANNU_BANK_AMT, 0) AS TD_ANNU_BANK_AMT                                      -- 2014-연금저축 공제금액
                         , NVL(HA.TD_ANNU_BANK_DED_AMT, 0) AS TD_ANNU_BANK_DED_AMT                              -- 2014-연금저축 세액공제
                            
                         , ( NVL(HA.TD_GUAR_INSUR_AMT, 0)) AS TD_GUAR_INSUR_AMT                           -- 2014-세감 ( 보장성보험 공제금액)
                         , ( NVL(HA.TD_GUAR_INSUR_DED_AMT, 0)) AS TD_GUAR_INSUR_DED_AMT                   -- 2014-세감 ( 보장성보험 세액공제)
                            
                         , NVL(HA.TD_MEDIC_AMT, 0) AS TD_MEDIC_AMT                                              -- 2014-세감 (의료비 공제금액)
                         , NVL(HA.TD_MEDIC_DED_AMT, 0) AS TD_MEDIC_DED_AMT                                      -- 2014-세감 (의료비 세액공제)
                            
                         , NVL(HA.TD_EDUCATION_AMT, 0) AS TD_EDUCATION_AMT                                      -- 2014-세감 (교육비 공제금액)
                         , NVL(HA.TD_EDUCATION_DED_AMT, 0) AS TD_EDUCATION_DED_AMT                              -- 2014-세감 (교육비 세액공제) 
                            
                         , NVL(HA.TD_POLI_DONAT_AMT1, 0) AS TD_POLI_DONAT_AMT1                                       -- 2014-세감 (정치자금기부금-10만원이하) 공제금액
                         , NVL(HA.TD_POLI_DONAT_DED_AMT1, 0) AS TD_POLI_DONAT_DED_AMT1                                 -- 2014-세감 (정치자금기부금-10만원이하) 세액공제
                         , NVL(HA.TD_POLI_DONAT_AMT2, 0) AS TD_POLI_DONAT_AMT2                                       -- 2014-세감 (정치자금기부금-10만원초과) 공제금액
                         , NVL(HA.TD_POLI_DONAT_DED_AMT2, 0) AS TD_POLI_DONAT_DED_AMT2                                 -- 2014-세감 (정치자금기부금-10만원이하) 세액공제
                         , NVL(HA.TD_LEGAL_DONAT_AMT, 0) AS TD_LEGAL_DONAT_AMT                                       -- 2014-세감 (법정기부금) 공제금액
                         , NVL(HA.TD_LEGAL_DONAT_DED_AMT, 0) AS TD_LEGAL_DONAT_DED_AMT                                 -- 2014-세감 (법정기부금) 세액공제
                         , NVL(HA.TD_DESIGN_DONAT_AMT, 0) AS TD_DESIGN_DONAT_AMT                                    -- 2014-세감 (지정기부금) 공제금액
                         , NVL(HA.TD_DESIGN_DONAT_DED_AMT, 0) AS TD_DESIGN_DONAT_DED_AMT                               -- 2014-세감 (지정기부금) 세액공제
                           
                         , ( NVL(HA.TD_GUAR_INSUR_DED_AMT, 0) +
                             NVL(HA.TD_POLI_DONAT_DED_AMT1, 0) + NVL(HA.TD_EDUCATION_DED_AMT, 0) +
                             NVL(HA.TD_POLI_DONAT_DED_AMT1, 0) + NVL(HA.TD_POLI_DONAT_DED_AMT2, 0) +
                             NVL(HA.TD_LEGAL_DONAT_DED_AMT, 0) + NVL(HA.TD_DESIGN_DONAT_DED_AMT, 0)) AS SP_TAX_DED_SUM_AMT      -- 특별 세액  공제 
                           
                         , NVL(HA.STAND_DED_AMT, 0) AS STAND_DED_AMT                                 -- 표준세액공제 
                           
                         , NVL(HA.TAX_DED_TAXGROUP_AMT, 0) AS TAX_DED_TAXGROUP_AMT    -- 세공 - 납세조합
                         , NVL(HA.TAX_DED_HOUSE_DEBT_AMT, 0) AS TAX_DED_HOUSE_DEBT_AMT  -- 세공 - 주택차입금
                         , NVL(HA.TAX_DED_OUTSIDE_PAY_AMT, 0) AS TAX_DED_OUTSIDE_PAY_AMT  -- 세공 - 외국납부
                         , NVL(HA.TD_HOUSE_MONTHLY_AMT, 0) AS TD_HOUSE_MONTHLY_AMT        -- 세공 월세공제 대상 
                         , NVL(HA.TD_HOUSE_MONTHLY_DED_AMT, 0) AS TD_HOUSE_MONTHLY_DED_AMT   -- 세공 월세공제 세액 
                           
                         , ( NVL(HA.TAX_DED_INCOME_AMT, 0) + NVL(HA.TD_CHILD_RAISE_DED_AMT, 0) + 
                             NVL(HA.TD_SCIENTIST_ANNU_DED_AMT, 0) + NVL(HA.TD_WORKER_RETR_ANNU_DED_AMT, 0) + 
                             NVL(HA.TD_ANNU_BANK_DED_AMT, 0) + 
                             NVL(HA.TD_GUAR_INSUR_DED_AMT, 0) + 
                             NVL(HA.TD_POLI_DONAT_DED_AMT1, 0) + NVL(HA.TD_EDUCATION_DED_AMT, 0) +
                             NVL(HA.TD_POLI_DONAT_DED_AMT1, 0) + NVL(HA.TD_POLI_DONAT_DED_AMT2, 0) +
                             NVL(HA.TD_LEGAL_DONAT_DED_AMT, 0) + NVL(HA.TD_DESIGN_DONAT_DED_AMT, 0) +
                             NVL(HA.TAX_DED_TAXGROUP_AMT, 0) + NVL(HA.TAX_DED_HOUSE_DEBT_AMT, 0) + 
                             NVL(HA.TAX_DED_OUTSIDE_PAY_AMT, 0) + NVL(HA.TD_HOUSE_MONTHLY_DED_AMT, 0)
                           ) AS TAX_DED_SUM_AMT      -- 세액공제 합계
                         , NVL(HA.FIX_TAX_AMT, 0) AS FIX_TAX_AMT                       -- 결정세액
                         -- 결정세액
                         , NVL(HA.FIX_IN_TAX_AMT, 0) AS FIX_IN_TAX_AMT        -- 결정 소득세
                         , NVL(HA.FIX_LOCAL_TAX_AMT, 0) AS FIX_LOCAL_TAX_AMT   -- 결정 주민세
                         , NVL(HA.FIX_SP_TAX_AMT, 0) AS FIX_SP_TAX_AMT         -- 결정 농특세
                         , ( NVL(HA.FIX_IN_TAX_AMT, 0) +
                             NVL(HA.FIX_LOCAL_TAX_AMT, 0) +
                             NVL(HA.FIX_SP_TAX_AMT, 0)) AS FIX_TAX_SUM_AMT     -- 결정 세액 합계
                         -- (종전) 기납부 세액
                         , NVL(HPW1.IN_TAX_AMT, 0) AS PRE_IN_TAX_AMT           -- (종전) 소득세 합계
                         , NVL(HPW1.LOCAL_TAX_AMT, 0) AS PRE_LOCAL_TAX_AMT     -- (종전) 주민세 합계
                         , NVL(HPW1.SP_TAX_AMT, 0) AS PRE_SP_TAX_AMT           -- (종전) 농특세 합계
                         , ( NVL(HPW1.IN_TAX_AMT, 0) +
                             NVL(HPW1.LOCAL_TAX_AMT, 0) +
                             NVL(HPW1.SP_TAX_AMT, 0)) AS PRE_TAX_SUM_AMT       -- (종전) 세액 합계
                         -- (주현) 기납부 세액
                         , ( NVL(HA.PRE_IN_TAX_AMT, 0) -
                             NVL(HPW1.IN_TAX_AMT, 0)) AS NOW_IN_TAX_AMT        -- (주현) 소득세
                         , ( NVL(HA.PRE_LOCAL_TAX_AMT, 0) -
                             NVL(HPW1.LOCAL_TAX_AMT, 0)) AS NOW_LOCAL_TAX_AMT  -- (주현) 주민세
                         , ( NVL(HA.PRE_SP_TAX_AMT, 0) -
                             NVL(HPW1.SP_TAX_AMT, 0)) AS NOW_SP_TAX_AMT        -- (주현) 농특세
                         , ( NVL(HA.PRE_IN_TAX_AMT, 0) - NVL(HPW1.IN_TAX_AMT, 0) +
                             NVL(HA.PRE_LOCAL_TAX_AMT, 0) - NVL(HPW1.LOCAL_TAX_AMT, 0) +
                             NVL(HA.PRE_SP_TAX_AMT, 0) - NVL(HPW1.SP_TAX_AMT, 0)) AS NOW_TAX_SUM_AMT  -- (주현) 세액 합계
                         -- 차감 세액
                         , NVL(HA.SUBT_IN_TAX_AMT, 0) AS SUBT_IN_TAX_AMT       -- (차감) 소득세
                         , NVL(HA.SUBT_LOCAL_TAX_AMT, 0) AS SUBT_LOCAL_TAX_AMT -- (차감) 주민세
                         , NVL(HA.SUBT_SP_TAX_AMT, 0) AS SUBT_SP_TAX_AMT       -- (차감) 농특세
                         , ( NVL(HA.SUBT_IN_TAX_AMT, 0) +
                             NVL(HA.SUBT_LOCAL_TAX_AMT, 0) +
                             NVL(HA.SUBT_SP_TAX_AMT, 0)) AS SUBT_TAX_SUM_AMT   -- (차감) 세액 합계          
                         -- 비과세 합계
                         , ( NVL(HA.NONTAX_OUTSIDE_AMT, 0) + NVL(HA.NONTAX_OT_AMT, 0) +  -- NONTAX_OUTSIDE_AMT : 비과세 국외근로 합계
                             NVL(HA.NONTAX_RESEA_AMT, 0) + NVL(HA.NONTAX_ETC_AMT, 0) +
                             NVL(HA.NONTAX_BIRTH_AMT, 0) + NVL(HA.NONTAX_FOREIGNER_AMT, 0) +
                             NVL(HA.NONTAX_SCH_EDU_AMT, 0) + NVL(HA.NONTAX_MEMBER_AMT, 0) +
                             NVL(HA.NONTAX_GUARD_AMT, 0) + NVL(HA.NONTAX_CHILD_AMT, 0) +
                             NVL(HA.NONTAX_HIGH_SCH_AMT, 0) + NVL(HA.NONTAX_SPECIAL_AMT, 0) +
                             NVL(HA.NONTAX_RESEARCH_AMT, 0) + NVL(HA.NONTAX_COMPANY_AMT, 0) +
                             NVL(HA.NONTAX_COVER_AMT, 0) + NVL(HA.NONTAX_WILD_AMT, 0) +
                             NVL(HA.NONTAX_DISASTER_AMT, 0) + NVL(HA.NONTAX_OUTS_GOVER_AMT, 0) +
                             NVL(HA.NONTAX_OUTS_ARMY_AMT, 0) + NVL(HA.NONTAX_STOCK_BENE_AMT, 0) +
                             NVL(HA.NONTAX_FOR_ENG_AMT, 0) + NVL(HA.NONTAX_EMPL_STOCK_AMT, 0) +
                             NVL(HA.NONTAX_EMPL_BENE_AMT_1, 0) + NVL(HA.NONTAX_EMPL_BENE_AMT_2, 0) +
                             NVL(HA.NONTAX_HOUSE_SUBSIDY_AMT, 0) + NVL(HA.NONTAX_SEA_RESOURCE_AMT, 0) +
                             -- 종전--
                             NVL(HA.PRE_NT_OUTSIDE_AMT, 0) + NVL(HA.PRE_NT_OT_AMT, 0) +  -- NONTAX_OUTSIDE_AMT : 비과세 국외근로 합계
                             NVL(HA.PRE_NT_RESEA_AMT, 0) + NVL(HA.PRE_NT_ETC_AMT, 0) +
                             NVL(HA.PRE_NT_BIRTH_AMT, 0) + NVL(HA.PRE_NT_FOREIGNER_AMT, 0) +
                             NVL(HA.PRE_NT_SCH_EDU_AMT, 0) + NVL(HA.PRE_NT_MEMBER_AMT, 0) +
                             NVL(HA.PRE_NT_GUARD_AMT, 0) + NVL(HA.PRE_NT_CHILD_AMT, 0) +
                             NVL(HA.PRE_NT_HIGH_SCH_AMT, 0) + NVL(HA.PRE_NT_SPECIAL_AMT, 0) +
                             NVL(HA.PRE_NT_RESEARCH_AMT, 0) + NVL(HA.PRE_NT_COMPANY_AMT, 0) +
                             NVL(HA.PRE_NT_COVER_AMT, 0) + NVL(HA.PRE_NT_WILD_AMT, 0) +
                             NVL(HA.PRE_NT_DISASTER_AMT, 0) + NVL(HA.PRE_NT_OUTS_GOVER_AMT, 0) +
                             NVL(HA.PRE_NT_OUTS_ARMY_AMT, 0) + NVL(HA.PRE_NT_STOCK_BENE_AMT, 0) +
                             NVL(HA.PRE_NT_FOR_ENG_AMT, 0) + NVL(HA.PRE_NT_EMPL_STOCK_AMT, 0) +
                             NVL(HA.PRE_NT_EMPL_BENE_AMT_1, 0) + NVL(HA.PRE_NT_EMPL_BENE_AMT_2, 0) +
                             NVL(HA.PRE_NT_HOUSE_SUBSIDY_AMT, 0) + NVL(HA.PRE_NT_SEA_RESOURCE_AMT, 0)) AS NONTAX_TOT_AMT  -- 비과세 합계
                         -- 비과세 상세
                         , (NVL(HA.NONTAX_OUTSIDE_AMT, 0) + NVL(HA.PRE_NT_OUTSIDE_AMT, 0)) AS NONTAX_OUTSIDE_AMT -- 비과세 국외근로 합계
                         , (NVL(HA.NONTAX_OT_AMT, 0) + NVL(HA.PRE_NT_OT_AMT, 0)) AS NONTAX_OT_AMT
                         , (NVL(HA.NONTAX_RESEA_AMT, 0) + NVL(HA.PRE_NT_RESEA_AMT, 0)) AS NONTAX_RESEA_AMT
                         , (NVL(HA.NONTAX_ETC_AMT, 0)+ NVL(HA.PRE_NT_ETC_AMT, 0)) AS NONTAX_ETC_AMT
                         , (NVL(HA.NONTAX_BIRTH_AMT, 0) + NVL(HA.PRE_NT_BIRTH_AMT, 0)) AS NONTAX_BIRTH_AMT
                         , (NVL(HA.NONTAX_FOREIGNER_AMT, 0) + NVL(HA.PRE_NT_FOREIGNER_AMT, 0)) AS NONTAX_FOREIGNER_AMT
                         , (NVL(HA.NONTAX_SCH_EDU_AMT, 0) + NVL(HA.PRE_NT_SCH_EDU_AMT, 0)) AS NONTAX_SCH_EDU_AMT
                         , (NVL(HA.NONTAX_MEMBER_AMT, 0) + NVL(HA.PRE_NT_MEMBER_AMT, 0)) AS NONTAX_MEMBER_AMT
                         , (NVL(HA.NONTAX_GUARD_AMT, 0) + NVL(HA.PRE_NT_GUARD_AMT, 0)) AS NONTAX_GUARD_AMT
                         , (NVL(HA.NONTAX_CHILD_AMT, 0) + NVL(HA.PRE_NT_CHILD_AMT, 0)) AS NONTAX_CHILD_AMT
                         , (NVL(HA.NONTAX_HIGH_SCH_AMT, 0) + NVL(HA.PRE_NT_HIGH_SCH_AMT, 0)) AS NONTAX_HIGH_SCH_AMT
                         , (NVL(HA.NONTAX_SPECIAL_AMT, 0) + NVL(HA.PRE_NT_SPECIAL_AMT, 0)) AS NONTAX_SPECIAL_AMT
                         , (NVL(HA.NONTAX_RESEARCH_AMT, 0) + NVL(HA.PRE_NT_RESEARCH_AMT, 0)) AS NONTAX_RESEARCH_AMT
                         , (NVL(HA.NONTAX_COMPANY_AMT, 0) + NVL(HA.PRE_NT_COMPANY_AMT, 0)) AS NONTAX_COMPANY_AMT
                         , (NVL(HA.NONTAX_COVER_AMT, 0) + NVL(HA.PRE_NT_COVER_AMT, 0)) AS NONTAX_COVER_AMT
                         , (NVL(HA.NONTAX_WILD_AMT, 0) + NVL(HA.PRE_NT_WILD_AMT, 0)) AS NONTAX_WILD_AMT
                         , (NVL(HA.NONTAX_DISASTER_AMT, 0) + NVL(HA.PRE_NT_DISASTER_AMT, 0)) AS NONTAX_DISASTER_AMT
                         , (NVL(HA.NONTAX_OUTS_GOVER_AMT, 0) + NVL(HA.PRE_NT_OUTS_GOVER_AMT, 0)) AS NONTAX_OUTS_GOVER_AMT
                         , (NVL(HA.NONTAX_OUTS_ARMY_AMT, 0) + NVL(HA.PRE_NT_OUTS_ARMY_AMT, 0)) AS NONTAX_OUTS_ARMY_AMT
                         , (NVL(HA.NONTAX_OUTS_WORK_1, 0) + NVL(HA.PRE_NT_OUTS_WORK_1, 0)) AS NONTAX_OUTS_WORK_1
                         , (NVL(HA.NONTAX_OUTS_WORK_2, 0) + NVL(HA.PRE_NT_OUTS_WORK_2, 0)) AS NONTAX_OUTS_WORK_2
                         , (NVL(HA.NONTAX_STOCK_BENE_AMT, 0) + NVL(HA.PRE_NT_STOCK_BENE_AMT, 0)) AS NONTAX_STOCK_BENE_AMT
                         , (NVL(HA.NONTAX_FOR_ENG_AMT, 0) + NVL(HA.PRE_NT_FOR_ENG_AMT, 0)) AS NONTAX_FOR_ENG_AMT
                         , (NVL(HA.NONTAX_EMPL_STOCK_AMT, 0) + NVL(HA.PRE_NT_EMPL_STOCK_AMT, 0)) AS NONTAX_EMPL_STOCK_AMT
                         , (NVL(HA.NONTAX_EMPL_BENE_AMT_1, 0) + NVL(HA.PRE_NT_EMPL_BENE_AMT_1, 0)) AS NONTAX_EMPL_BENE_AMT_1
                         , (NVL(HA.NONTAX_EMPL_BENE_AMT_2, 0) + NVL(HA.PRE_NT_EMPL_BENE_AMT_2, 0)) AS NONTAX_EMPL_BENE_AMT_2
                         , (NVL(HA.NONTAX_HOUSE_SUBSIDY_AMT, 0) + NVL(HA.PRE_NT_HOUSE_SUBSIDY_AMT, 0)) AS NONTAX_HOUSE_SUBSIDY_AMT
                         , (NVL(HA.NONTAX_SEA_RESOURCE_AMT, 0) + NVL(HA.PRE_NT_SEA_RESOURCE_AMT, 0)) AS NONTAX_SEA_RESOURCE_AMT
                         , -1 AS SIGN_FLAG  
                      FROM HRA_YEAR_ADJUSTMENT_1505 HA
                         , HRM_PERSON_MASTER_V      PM
                         , ( -- 종전 납부 세액
                             SELECT HPW.YEAR_YYYY
                                  , HPW.PERSON_ID
                                  , SUM(HPW.IN_TAX_AMT) AS IN_TAX_AMT
                                  , SUM(HPW.LOCAL_TAX_AMT) AS LOCAL_TAX_AMT
                                  , SUM(HPW.SP_TAX_AMT) AS SP_TAX_AMT
                              FROM HRA_PREVIOUS_WORK HPW
                             WHERE HPW.YEAR_YYYY = V_YEAR_YYYY
                               AND ((W_PERSON_ID IS NULL AND 1 = 1)
                               OR   (W_PERSON_ID IS NOT NULL AND HPW.PERSON_ID = W_PERSON_ID)) 
                               AND HPW.SOB_ID    = W_SOB_ID
                               AND HPW.ORG_ID    = W_ORG_ID
                             GROUP BY HPW.YEAR_YYYY
                                    , HPW.PERSON_ID
                           ) HPW1
                         , (-- 시점 인사내역.
                            SELECT  HL.PERSON_ID
                                  , HL.DEPT_ID
                                  , DM.DEPT_CODE
                                  , DM.DEPT_NAME
                                  , '1' || LPAD(TO_CHAR(DM.DEPT_SORT_NUM), 3, '0') AS DEPT_SORT_NUM
                                  , HL.POST_ID
                                  , HP.POST_NAME
                                  , HP.SORT_NUM AS POST_SORT_NUM
                                  , HL.PAY_GRADE_ID
                                  , HL.JOB_CATEGORY_ID
                                  , HL.FLOOR_ID
                                  , HF.FLOOR_NAME
                                  , HF.SORT_NUM AS FLOOR_SORT_NUM
                              FROM HRM_HISTORY_HEADER HH
                                 , HRM_HISTORY_LINE   HL
                                 , HRM_DEPT_MASTER    DM
                                 , HRM_FLOOR_V        HF
                                 , HRM_POST_CODE_V    HP
                            WHERE HH.HISTORY_HEADER_ID    = HL.HISTORY_HEADER_ID
                              AND HL.DEPT_ID              = DM.DEPT_ID
                              AND HL.FLOOR_ID             = HF.FLOOR_ID
                              AND HL.POST_ID              = HP.POST_ID
                              AND HH.CHARGE_SEQ           IN 
                                    (SELECT MAX(S_HH.CHARGE_SEQ) AS CHARGE_SEQ
                                        FROM HRM_HISTORY_HEADER S_HH
                                           , HRM_HISTORY_LINE   S_HL
                                       WHERE S_HH.HISTORY_HEADER_ID = S_HL.HISTORY_HEADER_ID
                                         AND S_HH.CHARGE_DATE       <= V_END_DATE 
                                         AND S_HL.PERSON_ID         = HL.PERSON_ID
                                       GROUP BY S_HL.PERSON_ID
                                     ) 
                           ) T1
                         , HRM_PERSON_MASTER C_PM
                     WHERE HA.YEAR_YYYY           = HPW1.YEAR_YYYY(+)
                       AND HA.PERSON_ID           = HPW1.PERSON_ID(+)
                       AND HA.PERSON_ID           = PM.PERSON_ID
                       AND PM.PERSON_ID           = T1.PERSON_ID
                       AND HA.CLOSED_PERSON_ID    = C_PM.PERSON_ID(+)
                       AND HA.YEAR_YYYY           = V_YEAR_YYYY
                       AND HA.CORP_ID             = W_CORP_ID 
                       AND HA.SOB_ID              = W_SOB_ID
                       AND HA.ORG_ID              = W_ORG_ID
                       AND HA.SUBMIT_DATE         = V_END_DATE --TO_DATE('2014-12-31', 'YYYY-MM-DD') 
                       AND ((W_PERSON_ID          IS NULL AND 1 = 1)
                       OR   (W_PERSON_ID          IS NOT NULL AND HA.PERSON_ID = W_PERSON_ID))
                       
                       AND PM.CORP_ID             = W_CORP_ID
                       AND PM.SOB_ID              = W_SOB_ID
                       AND PM.ORG_ID              = W_ORG_ID  
                       AND PM.JOIN_DATE           <= V_END_DATE
                       AND (PM.RETIRE_DATE        >= V_END_DATE OR PM.RETIRE_DATE IS NULL)
                          
                       AND ((W_POST_ID            IS NULL AND 1 = 1)
                       OR   (W_POST_ID            IS NOT NULL AND T1.POST_ID = W_POST_ID))
                       AND ((W_FLOOR_ID           IS NULL AND 1 = 1)
                       OR   (W_FLOOR_ID           IS NOT NULL AND T1.FLOOR_ID = W_FLOOR_ID))
                       AND ((W_DEPT_ID            IS NULL AND 1 = 1)
                       OR   (W_DEPT_ID            IS NOT NULL AND T1.DEPT_ID = W_DEPT_ID))
                    ---------
                    UNION ALL
                    ---------
                    SELECT NVL(HA.YEAR_YYYY, NULL) AS YEAR_YYYY
                         , NVL(PM.NAME, NULL) AS NAME
                         , NVL(PM.PERSON_NUM, NULL) AS PERSON_NUM
                         , NVL(PM.REPRE_NUM, NULL) AS REPRE_NUM
                         , NVL(EAPP_REGISTER_AGE_F(PM.REPRE_NUM, V_AGE_STD_DATE, 0), NULL) AS AGE
                         , NVL(T1.DEPT_NAME, NULL) AS DEPT_NAME
                         , NVL(T1.FLOOR_NAME, NULL) AS FLOOR_NAME
                         , NVL(PM.JOIN_DATE, NULL) AS JOIN_DATE
                         , NVL(PM.RETIRE_DATE, NULL) AS RETIRE_DATE
                         , ( NVL(HA.NOW_PAY_TOT_AMT, 0) + NVL(HA.NOW_BONUS_TOT_AMT, 0) +
                             NVL(HA.NOW_ADD_BONUS_AMT, 0) + NVL(HA.NOW_STOCK_BENE_AMT, 0) +
                             NVL(HA.INCOME_OUTSIDE_AMT, 0) +
                             NVL(HA.NOW_EMPLOYEE_STOCK_AMT, 0) + NVL(HA.NOW_OFFICE_RETIRE_OVER_AMT, 0)) AS NOW_SUM_PAY  -- 주현
                         , ( NVL(HA.PRE_PAY_TOT_AMT, 0) + NVL(HA.PRE_BONUS_TOT_AMT, 0) +
                             NVL(HA.PRE_ADD_BONUS_AMT, 0) + NVL(HA.PRE_STOCK_BENE_AMT, 0) +
                             NVL(HA.PRE_EMPLOYEE_STOCK_AMT, 0) + NVL(HA.PRE_OFFICE_RETIRE_OVER_AMT, 0)) AS PRE_SUM_PAY  -- 종전
                         , NVL(HA.INCOME_TOT_AMT, 0) AS TOTAL_PAY         -- 총급여
                         , NVL(HA.INCOME_DED_AMT, 0) AS INCOME_DED_AMT    -- 근로소득공제
                         , ( NVL(HA.INCOME_TOT_AMT, 0) - NVL(HA.INCOME_DED_AMT, 0)) AS INCOME_AMT  -- 근로소득금액
                         -- 인적공제
                         , NVL(HA.PER_DED_AMT, 0) AS PER_DED_AMT                      -- 본인
                         , NVL(HA.SPOUSE_DED_AMT, 0) AS SPOUSE_DED_AMT                -- 배우자
                         , NVL(HA.SUPP_DED_COUNT, 0) AS SUPP_DED_COUNT                -- 부양가족 인원수
                         , NVL(HA.SUPP_DED_AMT, 0) AS SUPP_DED_AMT                    -- 부양가족 공제금액
                         , NVL(HA.OLD_DED_COUNT1, 0) AS OLD_DED_COUNT1                -- 경로우대 인원수
                         , NVL(HA.OLD_DED_AMT1, 0) AS OLD_DED_AMT1                    -- 경로우대 공제금액
                         , NVL(HA.DISABILITY_DED_COUNT, 0) AS DISABILITY_DED_COUNT    -- 장애인 인원수
                         , NVL(HA.DISABILITY_DED_AMT, 0) AS DISABILITY_DED_AMT        -- 장애인 공제금액
                         , NVL(HA.WOMAN_DED_AMT, 0) AS WOMAN_DED_AMT                  -- 부녀자 공제금액
                         , NVL(HA.SINGLE_PARENT_DED_AMT, 0) AS SINGLE_PARENT_DED_AMT  -- 한부모가족
                         -- 연금보험료 공제
                         , NVL(HA.NATI_ANNU_AMT, 0) AS NATI_ANNU_AMT                  -- 국민연금보험료 공제
                         , NVL(HA.PUBLIC_INSUR_AMT, 0) AS PUBLIC_INSUR_AMT            -- 공무원연금
                         , NVL(HA.MARINE_INSUR_AMT, 0) AS MARINE_INSUR_AMT            -- 군인연금보험
                         , NVL(HA.SCHOOL_STAFF_INSUR_AMT, 0) AS SCHOOL_STAFF_INSUR_AMT  -- 사립학교 교직원연금
                         , NVL(HA.POST_OFFICE_INSUR_AMT, 0) AS POST_OFFICE_INSUR_AMT    -- 별정우체국연금
                           
                         -- 특별공제
                         , NVL(HA.MEDIC_INSUR_AMT, 0) AS MEDIC_INSUR_AMT              -- 건강보험료
                         , NVL(HA.HIRE_INSUR_AMT, 0) AS HIRE_INSUR_AMT                -- 고용보험료
                           
                         , NVL(HA.HOUSE_INTER_AMT, 0) AS HOUSE_INTER_AMT                    -- 주택임차차입금원리금 상환액 - 대출기관
                         , NVL(HA.HOUSE_INTER_AMT_ETC, 0) AS HOUSE_INTER_AMT_ETC            -- 주택임차차입금원리금 상환액 - 거주자
                           
                         , NVL(HA.LONG_HOUSE_PROF_AMT, 0) AS LONG_HOUSE_PROF_AMT            -- 장기주택저당차입금이자상환액 2011년 이전차입분 15년 미만
                         , NVL(HA.LONG_HOUSE_PROF_AMT_1, 0) AS LONG_HOUSE_PROF_AMT_1        -- 장기주택저당차입금이자상환액 2011년 이전차입분 15~29년
                         , NVL(HA.LONG_HOUSE_PROF_AMT_2, 0) AS LONG_HOUSE_PROF_AMT_2        -- 장기주택저당차입금이자상환액 2011년 이전차입분 30년 이상
                         , NVL(HA.LONG_HOUSE_PROF_AMT_3_FIX, 0) AS LONG_HOUSE_PROF_AMT_3_FIX  -- 장기주택저당차입금이자상환액 2012년 이후 차입분 15년 이상 고정금액 등
                         , NVL(HA.LONG_HOUSE_PROF_AMT_3_ETC, 0) AS LONG_HOUSE_PROF_AMT_3_ETC  -- 장기주택저당차입금이자상환액 2012년 이후 차입분 15년 이상 기타대출등
                         /*, ( NVL(HA.LONG_HOUSE_PROF_AMT, 0) +
                             NVL(HA.LONG_HOUSE_PROF_AMT_1, 0) + NVL(HA.LONG_HOUSE_PROF_AMT_2, 0) +
                             NVL(HA.LONG_HOUSE_PROF_AMT_3_FIX, 0) + NVL(HA.LONG_HOUSE_PROF_AMT_3_ETC, 0)) AS LONG_HOUSE_PROF_SUM_AMT  -- 장기주택저당 합계*/
                         , NVL(HA.DONAT_NEXT_ALL, 0) + NVL(HA.DONAT_NEXT_50, 0) + NVL(HA.DONAT_NEXT_30, 0) + NVL(HA.DONAT_NEXT_RELIGION_10, 0) + NVL(HA.DONAT_NEXT_10, 0) AS FORWARD_DONATION_AMT            -- 기부금(이월분)
                           
                        --, NVL(HA.HOUSE_FUND_AMT, 0) AS HOUSE_FUND_AMT                -- 주택자금 합계
                           
                         , ((CASE
                               WHEN NVL(HA.MEDIC_INSUR_AMT, 0) + NVL(HA.HIRE_INSUR_AMT, 0)  < 0 THEN 0
                               ELSE NVL(HA.MEDIC_INSUR_AMT, 0) + NVL(HA.HIRE_INSUR_AMT, 0) 
                             END) +
                             NVL(HA.HOUSE_INTER_AMT, 0) +            -- 주택임차차입금원리금 상환액 - 대출기관
                             NVL(HA.HOUSE_INTER_AMT_ETC, 0) +        -- 주택임차차입금원리금 상환액 - 거주자            
                             NVL(HA.LONG_HOUSE_PROF_AMT, 0) +        -- 장기주택저당차입금이자상환액 2011년 이전차입분 15년 미만
                             NVL(HA.LONG_HOUSE_PROF_AMT_1, 0) +      -- 장기주택저당차입금이자상환액 2011년 이전차입분 15~29년
                             NVL(HA.LONG_HOUSE_PROF_AMT_2, 0) +      -- 장기주택저당차입금이자상환액 2011년 이전차입분 30년 이상
                             NVL(HA.LONG_HOUSE_PROF_AMT_3_FIX, 0) +  -- 장기주택저당차입금이자상환액 2012년 이후 차입분 15년 이상 고정금액 등
                             NVL(HA.LONG_HOUSE_PROF_AMT_3_ETC, 0) +  -- 장기주택저당차입금이자상환액 2012년 이후 차입분 15년 이상 기타대출등
                             NVL(HA.DONAT_NEXT_ALL, 0) + NVL(HA.DONAT_NEXT_50, 0) + NVL(HA.DONAT_NEXT_30, 0) + NVL(HA.DONAT_NEXT_RELIGION_10, 0) + NVL(HA.DONAT_NEXT_10, 0)-- 기부금(이월분)
                             ) AS SP_DED_SUM_AMT                       -- 특별소득공제 계 
                                       

                         -- 차감소득금액
                         , NVL(HA.SUBT_DED_AMT, 0) AS SUBT_DED_AMT
                         -- 그밖의 소득공제
                         , NVL(HA.PERS_ANNU_BANK_AMT, 0) AS PERS_ANNU_BANK_AMT        -- 개인연금저축소득공제
                         , NVL(HA.SMALL_CORPOR_DED_AMT, 0) AS SMALL_CORPOR_DED_AMT    -- 소기업/소상공인 공제부금 소득공제
                         , NVL(HA.HOUSE_APP_DEPOSIT_AMT, 0) AS HOUSE_APP_DEPOSIT_AMT  -- 주택청약저축
                         , NVL(HA.HOUSE_APP_SAVE_AMT, 0) AS HOUSE_APP_SAVE_AMT        -- 주택청약종합저축
                         , NVL(HA.WORKER_HOUSE_SAVE_AMT, 0) AS WORKER_HOUSE_SAVE_AMT  -- 근로자주택마련저축
                         , NVL(HA.INVES_AMT, 0) AS INVES_AMT                          -- 투자조합출자등 소득공제
                         /*, ( NVL(HA.HOUSE_APP_DEPOSIT_AMT, 0) + NVL(HA.HOUSE_APP_SAVE_AMT, 0) +
                             NVL(HA.HOUSE_SAVE_AMT, 0) + NVL(HA.WORKER_HOUSE_SAVE_AMT, 0)) AS HOUSE_SAVE_SUM_AMT  -- 주택마련 저축소득공제 합계*/
                           
                         , NVL(HA.CREDIT_AMT, 0) AS CREDIT_AMT                        -- 신용카드등 소득공제
                         , NVL(HA.EMPL_STOCK_AMT, 0) AS EMPL_STOCK_AMT                -- 우리사주조합소득공제
                         , NVL(HA.DONAT_DED_30, 0) AS DONAT_DED_30                    -- 우리사주조합기부금
                         , NVL(HA.HIRE_KEEP_EMPLOY_AMT, 0) AS HIRE_KEEP_EMPLOY_AMT    -- 고용유지중소기업근로자
                         , NVL(HA.FIX_LEASE_DED_AMT, 0) AS FIX_LEASE_DED_AMT          -- 목돈안드는 전세이자상환액
                         , NVL(HA.LONG_SET_INVEST_SAVING_AMT, 0) AS LONG_SET_INVEST_SAVING_AMT -- 장기집합투자증권저축
                           
                         , ( NVL(HA.PERS_ANNU_BANK_AMT, 0) + NVL(HA.SMALL_CORPOR_DED_AMT, 0) +
                             NVL(HA.HOUSE_APP_DEPOSIT_AMT, 0) + NVL(HA.HOUSE_APP_SAVE_AMT, 0) +
                             NVL(HA.WORKER_HOUSE_SAVE_AMT, 0) + NVL(HA.INVES_AMT, 0) +
                             NVL(HA.CREDIT_AMT, 0) + NVL(HA.EMPL_STOCK_AMT, 0) +
                             NVL(HA.DONAT_DED_30, 0) + NVL(HA.HIRE_KEEP_EMPLOY_AMT, 0) +
                             NVL(HA.FIX_LEASE_DED_AMT, 0) + NVL(HA.LONG_SET_INVEST_SAVING_AMT, 0)) AS ETC_DED_SUM_AMT   -- 그밖의 소득공제 합계 금액 --
                         -- 특별공제 종합한도 초과액
                         , NVL(HA.SP_DED_TOT_AMT, 0) AS SP_DED_TOT_AMT                -- 특별공제 종합한도 초과액
                         -- 종합소득 과세표준
                         , NVL(HA.TAX_STD_AMT, 0) AS TAX_STD_AMT                      -- 종합소득 과세표준
                         -- 산출세액
                         , NVL(HA.COMP_TAX_AMT, 0) AS COMP_TAX_AMT                    -- 산출세액
                         -- 세액감면
                         , NVL(HA.TAX_REDU_IN_LAW_AMT, 0) AS TAX_REDU_IN_LAW_AMT      -- 소득세법
                         , NVL(HA.TAX_REDU_SP_LAW_AMT, 0) AS TAX_REDU_SP_LAW_AMT      -- 조세특례 제한법
                         , NVL(HA.TAX_REDU_SMALL_BUSINESS, 0) AS TAX_REDU_SP_LAW_AMT_1                   -- 조세특례 제한법 제30조
                         , NVL(HA.TAX_REDU_TAX_TREATY, 0) AS TAX_REDU_TAX_TREATY      -- 조세조약
                         , ( NVL(HA.TAX_REDU_IN_LAW_AMT, 0) + NVL(HA.TAX_REDU_SP_LAW_AMT, 0) +
                             NVL(HA.TAX_REDU_TAX_TREATY, 0) + NVL(HA.TAX_REDU_SMALL_BUSINESS, 0)) AS TAX_REDU_SUM_AMT      -- 세액감면 합계
                         -- 세액공제
                         , NVL(HA.TAX_DED_INCOME_AMT, 0) AS TAX_DED_INCOME_AMT        -- 세공-근로소득
                         , NVL(HA.TD_CHILD_RAISE_DED_CNT, 0) AS TD_CHILD_RAISE_DED_CNT  -- 세공-자녀양육 인원수 
                         , NVL(HA.TD_CHILD_RAISE_DED_AMT, 0) AS TD_CHILD_RAISE_DED_AMT  -- 세공-자녀양육 금액 
                         , NVL(HA.TD_CHILD_6_UNDER_DED_CNT, 0) AS TD_CHILD_6_UNDER_DED_CNT  -- 세공-자녀 6세이하 인원수 
                         , NVL(HA.TD_CHILD_6_UNDER_DED_AMT, 0) AS TD_CHILD_6_UNDER_DED_AMT  -- 세공-자녀6세이하 금액 
                         , NVL(HA.TD_BIRTH_DED_CNT, 0) AS TD_BIRTH_DED_CNT                  -- 세공-자녀 출생/입양 인원수 
                         , NVL(HA.TD_BIRTH_DED_AMT, 0) AS TD_BIRTH_DED_AMT                  -- 세공-자녀 출생/입양 금액 
                           
                         , NVL(HA.TD_SCIENTIST_ANNU_AMT, 0) AS TD_SCIENTIST_ANNU_AMT                            -- 2014-과학기술인 공제금액
                         , NVL(HA.TD_SCIENTIST_ANNU_DED_AMT, 0) AS TD_SCIENTIST_ANNU_DED_AMT                    -- 2014-과학기술인 세액공제
                         , NVL(HA.TD_WORKER_RETR_ANNU_AMT, 0) AS TD_WORKER_RETR_ANNU_AMT                        -- 2014-퇴직연금  공제금액
                         , NVL(HA.TD_WORKER_RETR_ANNU_DED_AMT, 0) AS TD_WORKER_RETR_ANNU_DED_AMT                -- 2014-퇴직연금 세액공제
                         , NVL(HA.TD_ANNU_BANK_AMT, 0) AS TD_ANNU_BANK_AMT                                      -- 2014-연금저축 공제금액
                         , NVL(HA.TD_ANNU_BANK_DED_AMT, 0) AS TD_ANNU_BANK_DED_AMT                              -- 2014-연금저축 세액공제
                            
                         , ( NVL(HA.TD_GUAR_INSUR_AMT, 0) + 
                             NVL(HA.TD_DISABILITY_INSUR_AMT, 0)) AS TD_GUAR_INSUR_AMT                           -- 2014-세감 ( 보장성보험 공제금액)
                         , ( NVL(HA.TD_GUAR_INSUR_DED_AMT, 0) + 
                             NVL(HA.TD_DISABILITY_INSUR_DED_AMT, 0)) AS TD_GUAR_INSUR_DED_AMT                   -- 2014-세감 ( 보장성보험 세액공제)
                            
                         , NVL(HA.TD_MEDIC_AMT, 0) AS TD_MEDIC_AMT                                              -- 2014-세감 (의료비 공제금액)
                         , NVL(HA.TD_MEDIC_DED_AMT, 0) AS TD_MEDIC_DED_AMT                                      -- 2014-세감 (의료비 세액공제)
                            
                         , NVL(HA.TD_EDUCATION_AMT, 0) AS TD_EDUCATION_AMT                                      -- 2014-세감 (교육비 공제금액)
                         , NVL(HA.TD_EDUCATION_DED_AMT, 0) AS TD_EDUCATION_DED_AMT                              -- 2014-세감 (교육비 세액공제) 
                            
                         , NVL(HA.TD_POLI_DONAT_AMT1, 0) AS TD_POLI_DONAT_AMT1                                       -- 2014-세감 (정치자금기부금-10만원이하) 공제금액
                         , NVL(HA.TD_POLI_DONAT_DED_AMT1, 0) AS TD_POLI_DONAT_DED_AMT1                                 -- 2014-세감 (정치자금기부금-10만원이하) 세액공제
                         , NVL(HA.TD_POLI_DONAT_AMT2, 0) AS TD_POLI_DONAT_AMT2                                       -- 2014-세감 (정치자금기부금-10만원초과) 공제금액
                         , NVL(HA.TD_POLI_DONAT_DED_AMT2, 0) AS TD_POLI_DONAT_DED_AMT2                                 -- 2014-세감 (정치자금기부금-10만원이하) 세액공제
                         , NVL(HA.TD_LEGAL_DONAT_AMT, 0) AS TD_LEGAL_DONAT_AMT                                       -- 2014-세감 (법정기부금) 공제금액
                         , NVL(HA.TD_LEGAL_DONAT_DED_AMT, 0) AS TD_LEGAL_DONAT_DED_AMT                                 -- 2014-세감 (법정기부금) 세액공제
                         , NVL(HA.TD_DESIGN_DONAT_AMT, 0) AS TD_DESIGN_DONAT_AMT                                    -- 2014-세감 (지정기부금) 공제금액
                         , NVL(HA.TD_DESIGN_DONAT_DED_AMT, 0) AS TD_DESIGN_DONAT_DED_AMT                               -- 2014-세감 (지정기부금) 세액공제
                           
                         , ( NVL(HA.TD_GUAR_INSUR_DED_AMT, 0) + NVL(HA.TD_DISABILITY_INSUR_DED_AMT, 0) + 
                             NVL(HA.TD_POLI_DONAT_DED_AMT1, 0) + NVL(HA.TD_EDUCATION_DED_AMT, 0) +
                             NVL(HA.TD_POLI_DONAT_DED_AMT1, 0) + NVL(HA.TD_POLI_DONAT_DED_AMT2, 0) +
                             NVL(HA.TD_LEGAL_DONAT_DED_AMT, 0) + NVL(HA.TD_DESIGN_DONAT_DED_AMT, 0)) AS SP_TAX_DED_SUM_AMT      -- 특별 세액  공제 
                           
                         , NVL(HA.STAND_DED_AMT, 0) AS STAND_DED_AMT                                 -- 표준세액공제 
                           
                         , NVL(HA.TAX_DED_TAXGROUP_AMT, 0) AS TAX_DED_TAXGROUP_AMT    -- 세공 - 납세조합
                         , NVL(HA.TAX_DED_HOUSE_DEBT_AMT, 0) AS TAX_DED_HOUSE_DEBT_AMT  -- 세공 - 주택차입금
                         , NVL(HA.TAX_DED_OUTSIDE_PAY_AMT, 0) AS TAX_DED_OUTSIDE_PAY_AMT  -- 세공 - 외국납부
                         , NVL(HA.TD_HOUSE_MONTHLY_AMT, 0) AS TD_HOUSE_MONTHLY_AMT        -- 세공 월세공제 대상 
                         , NVL(HA.TD_HOUSE_MONTHLY_DED_AMT, 0) AS TD_HOUSE_MONTHLY_DED_AMT   -- 세공 월세공제 세액 
                           
                         , ( NVL(HA.TAX_DED_INCOME_AMT, 0) + NVL(HA.TD_CHILD_RAISE_DED_AMT, 0) + 
                             NVL(HA.TD_CHILD_6_UNDER_DED_AMT, 0) + NVL(HA.TD_BIRTH_DED_AMT, 0) + 
                             NVL(HA.TD_SCIENTIST_ANNU_DED_AMT, 0) + NVL(HA.TD_WORKER_RETR_ANNU_DED_AMT, 0) + 
                             NVL(HA.TD_ANNU_BANK_DED_AMT, 0) + 
                             NVL(HA.TD_GUAR_INSUR_DED_AMT, 0) + NVL(HA.TD_DISABILITY_INSUR_DED_AMT, 0) + 
                             NVL(HA.TD_POLI_DONAT_DED_AMT1, 0) + NVL(HA.TD_EDUCATION_DED_AMT, 0) +
                             NVL(HA.TD_POLI_DONAT_DED_AMT1, 0) + NVL(HA.TD_POLI_DONAT_DED_AMT2, 0) +
                             NVL(HA.TD_LEGAL_DONAT_DED_AMT, 0) + NVL(HA.TD_DESIGN_DONAT_DED_AMT, 0) +
                             NVL(HA.TAX_DED_TAXGROUP_AMT, 0) + NVL(HA.TAX_DED_HOUSE_DEBT_AMT, 0) + 
                             NVL(HA.TAX_DED_OUTSIDE_PAY_AMT, 0) + NVL(HA.TD_HOUSE_MONTHLY_DED_AMT, 0)
                           ) AS TAX_DED_SUM_AMT      -- 세액공제 합계
                         , NVL(HA.FIX_TAX_AMT, 0) AS FIX_TAX_AMT                       -- 결정세액
                         -- 결정세액
                         , NVL(HA.FIX_IN_TAX_AMT, 0) AS FIX_IN_TAX_AMT        -- 결정 소득세
                         , NVL(HA.FIX_LOCAL_TAX_AMT, 0) AS FIX_LOCAL_TAX_AMT   -- 결정 주민세
                         , NVL(HA.FIX_SP_TAX_AMT, 0) AS FIX_SP_TAX_AMT         -- 결정 농특세
                         , ( NVL(HA.FIX_IN_TAX_AMT, 0) +
                             NVL(HA.FIX_LOCAL_TAX_AMT, 0) +
                             NVL(HA.FIX_SP_TAX_AMT, 0)) AS FIX_TAX_SUM_AMT     -- 결정 세액 합계
                         -- (종전) 기납부 세액
                         , NVL(HPW1.IN_TAX_AMT, 0) AS PRE_IN_TAX_AMT           -- (종전) 소득세 합계
                         , NVL(HPW1.LOCAL_TAX_AMT, 0) AS PRE_LOCAL_TAX_AMT     -- (종전) 주민세 합계
                         , NVL(HPW1.SP_TAX_AMT, 0) AS PRE_SP_TAX_AMT           -- (종전) 농특세 합계
                         , ( NVL(HPW1.IN_TAX_AMT, 0) +
                             NVL(HPW1.LOCAL_TAX_AMT, 0) +
                             NVL(HPW1.SP_TAX_AMT, 0)) AS PRE_TAX_SUM_AMT       -- (종전) 세액 합계
                         -- (주현) 기납부 세액
                         , ( NVL(HA.PRE_IN_TAX_AMT, 0) -
                             NVL(HPW1.IN_TAX_AMT, 0)) AS NOW_IN_TAX_AMT        -- (주현) 소득세
                         , ( NVL(HA.PRE_LOCAL_TAX_AMT, 0) -
                             NVL(HPW1.LOCAL_TAX_AMT, 0)) AS NOW_LOCAL_TAX_AMT  -- (주현) 주민세
                         , ( NVL(HA.PRE_SP_TAX_AMT, 0) -
                             NVL(HPW1.SP_TAX_AMT, 0)) AS NOW_SP_TAX_AMT        -- (주현) 농특세
                         , ( NVL(HA.PRE_IN_TAX_AMT, 0) - NVL(HPW1.IN_TAX_AMT, 0) +
                             NVL(HA.PRE_LOCAL_TAX_AMT, 0) - NVL(HPW1.LOCAL_TAX_AMT, 0) +
                             NVL(HA.PRE_SP_TAX_AMT, 0) - NVL(HPW1.SP_TAX_AMT, 0)) AS NOW_TAX_SUM_AMT  -- (주현) 세액 합계
                         -- 차감 세액
                         , NVL(HA.SUBT_IN_TAX_AMT, 0) AS SUBT_IN_TAX_AMT       -- (차감) 소득세
                         , NVL(HA.SUBT_LOCAL_TAX_AMT, 0) AS SUBT_LOCAL_TAX_AMT -- (차감) 주민세
                         , NVL(HA.SUBT_SP_TAX_AMT, 0) AS SUBT_SP_TAX_AMT       -- (차감) 농특세
                         , ( NVL(HA.SUBT_IN_TAX_AMT, 0) +
                             NVL(HA.SUBT_LOCAL_TAX_AMT, 0) +
                             NVL(HA.SUBT_SP_TAX_AMT, 0)) AS SUBT_TAX_SUM_AMT   -- (차감) 세액 합계          
                         -- 비과세 합계
                         , ( NVL(HA.NONTAX_OUTSIDE_AMT, 0) + NVL(HA.NONTAX_OT_AMT, 0) +  -- NONTAX_OUTSIDE_AMT : 비과세 국외근로 합계
                             NVL(HA.NONTAX_RESEA_AMT, 0) + NVL(HA.NONTAX_ETC_AMT, 0) +
                             NVL(HA.NONTAX_BIRTH_AMT, 0) + NVL(HA.NONTAX_FOREIGNER_AMT, 0) +
                             NVL(HA.NONTAX_SCH_EDU_AMT, 0) + NVL(HA.NONTAX_MEMBER_AMT, 0) +
                             NVL(HA.NONTAX_GUARD_AMT, 0) + NVL(HA.NONTAX_CHILD_AMT, 0) +
                             NVL(HA.NONTAX_HIGH_SCH_AMT, 0) + NVL(HA.NONTAX_SPECIAL_AMT, 0) +
                             NVL(HA.NONTAX_RESEARCH_AMT, 0) + NVL(HA.NONTAX_COMPANY_AMT, 0) +
                             NVL(HA.NONTAX_COVER_AMT, 0) + NVL(HA.NONTAX_WILD_AMT, 0) +
                             NVL(HA.NONTAX_DISASTER_AMT, 0) + NVL(HA.NONTAX_OUTS_GOVER_AMT, 0) +
                             NVL(HA.NONTAX_OUTS_ARMY_AMT, 0) + NVL(HA.NONTAX_STOCK_BENE_AMT, 0) +
                             NVL(HA.NONTAX_FOR_ENG_AMT, 0) + NVL(HA.NONTAX_EMPL_STOCK_AMT, 0) +
                             NVL(HA.NONTAX_EMPL_BENE_AMT_1, 0) + NVL(HA.NONTAX_EMPL_BENE_AMT_2, 0) +
                             NVL(HA.NONTAX_HOUSE_SUBSIDY_AMT, 0) + NVL(HA.NONTAX_SEA_RESOURCE_AMT, 0) +
                             -- 종전--
                             NVL(HA.PRE_NT_OUTSIDE_AMT, 0) + NVL(HA.PRE_NT_OT_AMT, 0) +  -- NONTAX_OUTSIDE_AMT : 비과세 국외근로 합계
                             NVL(HA.PRE_NT_RESEA_AMT, 0) + NVL(HA.PRE_NT_ETC_AMT, 0) +
                             NVL(HA.PRE_NT_BIRTH_AMT, 0) + NVL(HA.PRE_NT_FOREIGNER_AMT, 0) +
                             NVL(HA.PRE_NT_SCH_EDU_AMT, 0) + NVL(HA.PRE_NT_MEMBER_AMT, 0) +
                             NVL(HA.PRE_NT_GUARD_AMT, 0) + NVL(HA.PRE_NT_CHILD_AMT, 0) +
                             NVL(HA.PRE_NT_HIGH_SCH_AMT, 0) + NVL(HA.PRE_NT_SPECIAL_AMT, 0) +
                             NVL(HA.PRE_NT_RESEARCH_AMT, 0) + NVL(HA.PRE_NT_COMPANY_AMT, 0) +
                             NVL(HA.PRE_NT_COVER_AMT, 0) + NVL(HA.PRE_NT_WILD_AMT, 0) +
                             NVL(HA.PRE_NT_DISASTER_AMT, 0) + NVL(HA.PRE_NT_OUTS_GOVER_AMT, 0) +
                             NVL(HA.PRE_NT_OUTS_ARMY_AMT, 0) + NVL(HA.PRE_NT_STOCK_BENE_AMT, 0) +
                             NVL(HA.PRE_NT_FOR_ENG_AMT, 0) + NVL(HA.PRE_NT_EMPL_STOCK_AMT, 0) +
                             NVL(HA.PRE_NT_EMPL_BENE_AMT_1, 0) + NVL(HA.PRE_NT_EMPL_BENE_AMT_2, 0) +
                             NVL(HA.PRE_NT_HOUSE_SUBSIDY_AMT, 0) + NVL(HA.PRE_NT_SEA_RESOURCE_AMT, 0)) AS NONTAX_TOT_AMT  -- 비과세 합계
                         -- 비과세 상세
                         , (NVL(HA.NONTAX_OUTSIDE_AMT, 0) + NVL(HA.PRE_NT_OUTSIDE_AMT, 0)) AS NONTAX_OUTSIDE_AMT -- 비과세 국외근로 합계
                         , (NVL(HA.NONTAX_OT_AMT, 0) + NVL(HA.PRE_NT_OT_AMT, 0)) AS NONTAX_OT_AMT
                         , (NVL(HA.NONTAX_RESEA_AMT, 0) + NVL(HA.PRE_NT_RESEA_AMT, 0)) AS NONTAX_RESEA_AMT
                         , (NVL(HA.NONTAX_ETC_AMT, 0)+ NVL(HA.PRE_NT_ETC_AMT, 0)) AS NONTAX_ETC_AMT
                         , (NVL(HA.NONTAX_BIRTH_AMT, 0) + NVL(HA.PRE_NT_BIRTH_AMT, 0)) AS NONTAX_BIRTH_AMT
                         , (NVL(HA.NONTAX_FOREIGNER_AMT, 0) + NVL(HA.PRE_NT_FOREIGNER_AMT, 0)) AS NONTAX_FOREIGNER_AMT
                         , (NVL(HA.NONTAX_SCH_EDU_AMT, 0) + NVL(HA.PRE_NT_SCH_EDU_AMT, 0)) AS NONTAX_SCH_EDU_AMT
                         , (NVL(HA.NONTAX_MEMBER_AMT, 0) + NVL(HA.PRE_NT_MEMBER_AMT, 0)) AS NONTAX_MEMBER_AMT
                         , (NVL(HA.NONTAX_GUARD_AMT, 0) + NVL(HA.PRE_NT_GUARD_AMT, 0)) AS NONTAX_GUARD_AMT
                         , (NVL(HA.NONTAX_CHILD_AMT, 0) + NVL(HA.PRE_NT_CHILD_AMT, 0)) AS NONTAX_CHILD_AMT
                         , (NVL(HA.NONTAX_HIGH_SCH_AMT, 0) + NVL(HA.PRE_NT_HIGH_SCH_AMT, 0)) AS NONTAX_HIGH_SCH_AMT
                         , (NVL(HA.NONTAX_SPECIAL_AMT, 0) + NVL(HA.PRE_NT_SPECIAL_AMT, 0)) AS NONTAX_SPECIAL_AMT
                         , (NVL(HA.NONTAX_RESEARCH_AMT, 0) + NVL(HA.PRE_NT_RESEARCH_AMT, 0)) AS NONTAX_RESEARCH_AMT
                         , (NVL(HA.NONTAX_COMPANY_AMT, 0) + NVL(HA.PRE_NT_COMPANY_AMT, 0)) AS NONTAX_COMPANY_AMT
                         , (NVL(HA.NONTAX_COVER_AMT, 0) + NVL(HA.PRE_NT_COVER_AMT, 0)) AS NONTAX_COVER_AMT
                         , (NVL(HA.NONTAX_WILD_AMT, 0) + NVL(HA.PRE_NT_WILD_AMT, 0)) AS NONTAX_WILD_AMT
                         , (NVL(HA.NONTAX_DISASTER_AMT, 0) + NVL(HA.PRE_NT_DISASTER_AMT, 0)) AS NONTAX_DISASTER_AMT
                         , (NVL(HA.NONTAX_OUTS_GOVER_AMT, 0) + NVL(HA.PRE_NT_OUTS_GOVER_AMT, 0)) AS NONTAX_OUTS_GOVER_AMT
                         , (NVL(HA.NONTAX_OUTS_ARMY_AMT, 0) + NVL(HA.PRE_NT_OUTS_ARMY_AMT, 0)) AS NONTAX_OUTS_ARMY_AMT
                         , (NVL(HA.NONTAX_OUTS_WORK_1, 0) + NVL(HA.PRE_NT_OUTS_WORK_1, 0)) AS NONTAX_OUTS_WORK_1
                         , (NVL(HA.NONTAX_OUTS_WORK_2, 0) + NVL(HA.PRE_NT_OUTS_WORK_2, 0)) AS NONTAX_OUTS_WORK_2
                         , (NVL(HA.NONTAX_STOCK_BENE_AMT, 0) + NVL(HA.PRE_NT_STOCK_BENE_AMT, 0)) AS NONTAX_STOCK_BENE_AMT
                         , (NVL(HA.NONTAX_FOR_ENG_AMT, 0) + NVL(HA.PRE_NT_FOR_ENG_AMT, 0)) AS NONTAX_FOR_ENG_AMT
                         , (NVL(HA.NONTAX_EMPL_STOCK_AMT, 0) + NVL(HA.PRE_NT_EMPL_STOCK_AMT, 0)) AS NONTAX_EMPL_STOCK_AMT
                         , (NVL(HA.NONTAX_EMPL_BENE_AMT_1, 0) + NVL(HA.PRE_NT_EMPL_BENE_AMT_1, 0)) AS NONTAX_EMPL_BENE_AMT_1
                         , (NVL(HA.NONTAX_EMPL_BENE_AMT_2, 0) + NVL(HA.PRE_NT_EMPL_BENE_AMT_2, 0)) AS NONTAX_EMPL_BENE_AMT_2
                         , (NVL(HA.NONTAX_HOUSE_SUBSIDY_AMT, 0) + NVL(HA.PRE_NT_HOUSE_SUBSIDY_AMT, 0)) AS NONTAX_HOUSE_SUBSIDY_AMT
                         , (NVL(HA.NONTAX_SEA_RESOURCE_AMT, 0) + NVL(HA.PRE_NT_SEA_RESOURCE_AMT, 0)) AS NONTAX_SEA_RESOURCE_AMT 
                         , 1 AS SIGN_FLAG  
                      FROM HRA_YEAR_ADJUSTMENT HA
                         , HRM_PERSON_MASTER_V   PM
                         , ( -- 종전 납부 세액
                             SELECT HPW.YEAR_YYYY
                                  , HPW.PERSON_ID
                                  , SUM(HPW.IN_TAX_AMT) AS IN_TAX_AMT
                                  , SUM(HPW.LOCAL_TAX_AMT) AS LOCAL_TAX_AMT
                                  , SUM(HPW.SP_TAX_AMT) AS SP_TAX_AMT
                              FROM HRA_PREVIOUS_WORK HPW
                             WHERE HPW.YEAR_YYYY = V_YEAR_YYYY
                               AND ((W_PERSON_ID IS NULL AND 1 = 1)
                               OR   (W_PERSON_ID IS NOT NULL AND HPW.PERSON_ID = W_PERSON_ID)) 
                               AND HPW.SOB_ID    = W_SOB_ID
                               AND HPW.ORG_ID    = W_ORG_ID
                             GROUP BY HPW.YEAR_YYYY
                                    , HPW.PERSON_ID
                           ) HPW1
                         , (-- 시점 인사내역.
                            SELECT  HL.PERSON_ID
                                  , HL.DEPT_ID
                                  , DM.DEPT_CODE
                                  , DM.DEPT_NAME
                                  , '1' || LPAD(TO_CHAR(DM.DEPT_SORT_NUM), 3, '0') AS DEPT_SORT_NUM
                                  , HL.POST_ID
                                  , HP.POST_NAME
                                  , HP.SORT_NUM AS POST_SORT_NUM
                                  , HL.PAY_GRADE_ID
                                  , HL.JOB_CATEGORY_ID
                                  , HL.FLOOR_ID
                                  , HF.FLOOR_NAME
                                  , HF.SORT_NUM AS FLOOR_SORT_NUM
                              FROM HRM_HISTORY_HEADER HH
                                 , HRM_HISTORY_LINE   HL
                                 , HRM_DEPT_MASTER    DM
                                 , HRM_FLOOR_V        HF
                                 , HRM_POST_CODE_V    HP
                            WHERE HH.HISTORY_HEADER_ID    = HL.HISTORY_HEADER_ID
                              AND HL.DEPT_ID              = DM.DEPT_ID
                              AND HL.FLOOR_ID             = HF.FLOOR_ID
                              AND HL.POST_ID              = HP.POST_ID
                              AND HH.CHARGE_SEQ           IN 
                                    (SELECT MAX(S_HH.CHARGE_SEQ) AS CHARGE_SEQ
                                        FROM HRM_HISTORY_HEADER S_HH
                                           , HRM_HISTORY_LINE   S_HL
                                       WHERE S_HH.HISTORY_HEADER_ID = S_HL.HISTORY_HEADER_ID
                                         AND S_HH.CHARGE_DATE       <= V_END_DATE 
                                         AND S_HL.PERSON_ID         = HL.PERSON_ID
                                       GROUP BY S_HL.PERSON_ID
                                     ) 
                           ) T1
                         , HRM_PERSON_MASTER C_PM
                     WHERE HA.YEAR_YYYY           = HPW1.YEAR_YYYY(+)
                       AND HA.PERSON_ID           = HPW1.PERSON_ID(+)
                       AND HA.PERSON_ID           = PM.PERSON_ID
                       AND PM.PERSON_ID           = T1.PERSON_ID
                       AND HA.CLOSED_PERSON_ID    = C_PM.PERSON_ID(+)
                       AND HA.YEAR_YYYY           = V_YEAR_YYYY 
                       AND HA.CORP_ID             = W_CORP_ID
                       AND HA.SOB_ID              = W_SOB_ID
                       AND HA.ORG_ID              = W_ORG_ID
                       AND HA.SUBMIT_DATE         = V_END_DATE --TO_DATE('2014-12-31', 'YYYY-MM-DD') 
                       AND ((W_PERSON_ID          IS NULL AND 1 = 1)
                       OR   (W_PERSON_ID          IS NOT NULL AND HA.PERSON_ID = W_PERSON_ID))
                       
                       AND PM.CORP_ID             = W_CORP_ID
                       AND PM.SOB_ID              = W_SOB_ID
                       AND PM.ORG_ID              = W_ORG_ID 
                       AND PM.JOIN_DATE           <= V_END_DATE
                       AND (PM.RETIRE_DATE        >= V_END_DATE OR PM.RETIRE_DATE IS NULL)
                          
                       AND ((W_POST_ID            IS NULL AND 1 = 1)
                       OR   (W_POST_ID            IS NOT NULL AND T1.POST_ID = W_POST_ID))
                       AND ((W_FLOOR_ID           IS NULL AND 1 = 1)
                       OR   (W_FLOOR_ID           IS NOT NULL AND T1.FLOOR_ID = W_FLOOR_ID))
                       AND ((W_DEPT_ID            IS NULL AND 1 = 1)
                       OR   (W_DEPT_ID            IS NOT NULL AND T1.DEPT_ID = W_DEPT_ID))       
                  ) T2  
            GROUP BY T2.YEAR_YYYY
                   , T2.NAME
                   , T2.PERSON_NUM
                   , T2.REPRE_NUM
                   , T2.AGE
                   , T2.DEPT_NAME
                   , T2.FLOOR_NAME
                   , T2.JOIN_DATE
                   , T2.RETIRE_DATE
           ) SX1
      ORDER BY SX1.YEAR_YYYY
             , SX1.PERSON_NUM
             , SX1.SORT_NUM                 
      ;            
  END SELECT_YEAR_READJUST_SPREAD;

-------------------------------------------------------------------------------
-- 연말정산 내역 상세 조회 : 재정산 내역 
-------------------------------------------------------------------------------
  PROCEDURE SELECT_YEAR_READJUST_LIST
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_CORP_ID           IN  NUMBER 
            , W_STD_YYYYMM        IN  VARCHAR2
            , W_PERSON_ID         IN  NUMBER
            , W_POST_ID           IN  NUMBER
            , W_DEPT_ID           IN  NUMBER
            , W_FLOOR_ID          IN  NUMBER
            , W_SOB_ID            IN  NUMBER
            , W_ORG_ID            IN  NUMBER
            )
  AS
    V_YEAR_YYYY         VARCHAR2(4);
    V_START_DATE        DATE;
    V_END_DATE          DATE;
  BEGIN
    V_START_DATE := TRUNC(TO_DATE(W_STD_YYYYMM, 'YYYY-MM'), 'MONTH');
    V_END_DATE   := LAST_DAY(V_START_DATE);
    V_YEAR_YYYY := TO_CHAR(V_END_DATE, 'YYYY');
    
    OPEN P_CURSOR FOR 
      SELECT  T1.DEPT_NAME AS DEPT_NAME
            , T1.FLOOR_NAME
            , HA.PERSON_ID AS  PERSON_ID
            , PM.NAME AS NAME
            , PM.PERSON_NUM
            , TO_CHAR(HA.ADJUST_DATE_FR, 'YYYY-MM-DD') || ' ~ ' ||
              TO_CHAR(HA.ADJUST_DATE_TO, 'YYYY-MM-DD') APPLY_TERM
            , NVL(HA.INCOME_TOT_AMT, 0) AS TAX_PAY_SUM

            , ( NVL(HA.NONTAX_OUTSIDE_AMT, 0) + NVL(HA.NONTAX_OT_AMT, 0) +    -- NONTAX_OUTSIDE_AMT : 비과세 국외근로 합계
                NVL(HA.NONTAX_RESEA_AMT, 0) + NVL(HA.NONTAX_ETC_AMT, 0) +
                NVL(HA.NONTAX_BIRTH_AMT, 0) + NVL(HA.NONTAX_FOREIGNER_AMT, 0) +
                NVL(HA.NONTAX_SCH_EDU_AMT, 0) + NVL(HA.NONTAX_MEMBER_AMT, 0) +
                NVL(HA.NONTAX_GUARD_AMT, 0) + NVL(HA.NONTAX_CHILD_AMT, 0) +
                NVL(HA.NONTAX_HIGH_SCH_AMT, 0) + NVL(HA.NONTAX_SPECIAL_AMT, 0) +
                NVL(HA.NONTAX_RESEARCH_AMT, 0) + NVL(HA.NONTAX_COMPANY_AMT, 0) +
                NVL(HA.NONTAX_COVER_AMT, 0) + NVL(HA.NONTAX_WILD_AMT, 0) +
                NVL(HA.NONTAX_DISASTER_AMT, 0) + NVL(HA.NONTAX_OUTS_GOVER_AMT, 0) +
                NVL(HA.NONTAX_OUTS_ARMY_AMT, 0) + NVL(HA.NONTAX_STOCK_BENE_AMT, 0) +
                NVL(HA.NONTAX_FOR_ENG_AMT, 0) + NVL(HA.NONTAX_EMPL_STOCK_AMT, 0) +
                NVL(HA.NONTAX_EMPL_BENE_AMT_1, 0) + NVL(HA.NONTAX_EMPL_BENE_AMT_2, 0) +
                NVL(HA.NONTAX_HOUSE_SUBSIDY_AMT, 0) + NVL(HA.NONTAX_SEA_RESOURCE_AMT, 0) +
                -- 종전--
                NVL(HA.PRE_NT_OUTSIDE_AMT, 0) + NVL(HA.PRE_NT_OT_AMT, 0) +   -- NONTAX_OUTSIDE_AMT : 비과세 국외근로 합계
                NVL(HA.PRE_NT_RESEA_AMT, 0) + NVL(HA.PRE_NT_ETC_AMT, 0) +
                NVL(HA.PRE_NT_BIRTH_AMT, 0) + NVL(HA.PRE_NT_FOREIGNER_AMT, 0) +
                NVL(HA.PRE_NT_SCH_EDU_AMT, 0) + NVL(HA.PRE_NT_MEMBER_AMT, 0) +
                NVL(HA.PRE_NT_GUARD_AMT, 0) + NVL(HA.PRE_NT_CHILD_AMT, 0) +
                NVL(HA.PRE_NT_HIGH_SCH_AMT, 0) + NVL(HA.PRE_NT_SPECIAL_AMT, 0) +
                NVL(HA.PRE_NT_RESEARCH_AMT, 0) + NVL(HA.PRE_NT_COMPANY_AMT, 0) +
                NVL(HA.PRE_NT_COVER_AMT, 0) + NVL(HA.PRE_NT_WILD_AMT, 0) +
                NVL(HA.PRE_NT_DISASTER_AMT, 0) + NVL(HA.PRE_NT_OUTS_GOVER_AMT, 0) +
                NVL(HA.PRE_NT_OUTS_ARMY_AMT, 0) + NVL(HA.PRE_NT_STOCK_BENE_AMT, 0) +
                NVL(HA.PRE_NT_FOR_ENG_AMT, 0) + NVL(HA.PRE_NT_EMPL_STOCK_AMT, 0) +
                NVL(HA.PRE_NT_EMPL_BENE_AMT_1, 0) + NVL(HA.PRE_NT_EMPL_BENE_AMT_2, 0) +
                NVL(HA.PRE_NT_HOUSE_SUBSIDY_AMT, 0) + NVL(HA.PRE_NT_SEA_RESOURCE_AMT, 0)) AS NONTAX_PAY_SUM

            , NVL(HA.FIX_IN_TAX_AMT, 0) AS N_FIX_IN_TAX_AMT  -- 원단위 절사.
            , NVL(HA.FIX_LOCAL_TAX_AMT, 0) AS N_FIX_LOCAL_TAX_AMT
            , NVL(HA.FIX_SP_TAX_AMT, 0) AS N_FIX_SP_TAX_AMT
            , ( NVL(HA.FIX_IN_TAX_AMT, 0) +
                NVL(HA.FIX_LOCAL_TAX_AMT, 0) +
                NVL(HA.FIX_SP_TAX_AMT, 0)) AS N_FIX_TAX_SUM
            , NVL(SX1.FIX_IN_TAX_AMT, 0) AS O_FIX_IN_TAX_AMT
            , NVL(SX1.FIX_LOCAL_TAX_AMT, 0) AS O_FIX_LOCAL_TAX_AMT
            , NVL(SX1.FIX_SP_TAX_AMT, 0) AS O_FIX_SP_TAX_AMT
            , ( NVL(SX1.FIX_IN_TAX_AMT, 0) +
                NVL(SX1.FIX_LOCAL_TAX_AMT, 0) +
                NVL(SX1.FIX_SP_TAX_AMT, 0)) AS O_FIX_TAX_SUM
            , NVL(HA.PRE_IN_TAX_AMT, 0) AS PRE_IN_TAX_AMT
            , NVL(HA.PRE_LOCAL_TAX_AMT, 0) AS PRE_LOCAL_TAX_AMT
            , NVL(HA.PRE_SP_TAX_AMT, 0) AS PRE_SP_TAX_AMT
            , ( NVL(HA.PRE_IN_TAX_AMT, 0) +
                NVL(HA.PRE_LOCAL_TAX_AMT, 0) +
                NVL(HA.PRE_SP_TAX_AMT, 0)) AS PRE_TAX_SUM

            , NVL(HA.SUBT_IN_TAX_AMT, 0) AS N_SUBT_IN_TAX_AMT
            , NVL(HA.SUBT_LOCAL_TAX_AMT, 0) AS N_SUBT_LOCAL_TAX_AMT
            , NVL(HA.SUBT_SP_TAX_AMT, 0) AS N_SUBT_SP_TAX_AMT
            , ( NVL(HA.SUBT_IN_TAX_AMT, 0) +
                NVL(HA.SUBT_LOCAL_TAX_AMT, 0) +
                NVL(HA.SUBT_SP_TAX_AMT, 0)) AS N_SUBT_TAX_SUM
            , NVL(SX1.SUBT_IN_TAX_AMT, 0) AS O_SUBT_IN_TAX_AMT
            , NVL(SX1.SUBT_LOCAL_TAX_AMT, 0) AS O_SUBT_LOCAL_TAX_AMT
            , NVL(SX1.SUBT_SP_TAX_AMT, 0) AS O_SUBT_SP_TAX_AMT
            , ( NVL(SX1.SUBT_IN_TAX_AMT, 0) +
                NVL(SX1.SUBT_LOCAL_TAX_AMT, 0) +
                NVL(SX1.SUBT_SP_TAX_AMT, 0)) AS O_SUBT_TAX_SUM
                
            , (NVL(HA.SUBT_IN_TAX_AMT, 0) - NVL(SX1.SUBT_IN_TAX_AMT, 0)) AS G_SUBT_IN_TAX_AMT
            , (NVL(HA.SUBT_LOCAL_TAX_AMT, 0) - NVL(SX1.SUBT_LOCAL_TAX_AMT, 0)) AS G_SUBT_LOCAL_TAX_AMT
            , (NVL(HA.SUBT_SP_TAX_AMT, 0) - NVL(SX1.SUBT_SP_TAX_AMT, 0)) AS G_SUBT_SP_TAX_AMT
            , ((NVL(HA.SUBT_IN_TAX_AMT, 0) - NVL(SX1.SUBT_IN_TAX_AMT, 0)) +  
               (NVL(HA.SUBT_LOCAL_TAX_AMT, 0) - NVL(SX1.SUBT_LOCAL_TAX_AMT, 0)) + 
               (NVL(HA.SUBT_SP_TAX_AMT, 0) - NVL(SX1.SUBT_SP_TAX_AMT, 0))) AS G_SUBT_TAX_SUM 
            , CASE
                WHEN PM.RETIRE_DATE IS NULL THEN '계속근무'
                WHEN TO_DATE(V_YEAR_YYYY || '12-31', 'YYYY-MM-DD') < PM.RETIRE_DATE THEN '계속근무'
                ELSE '중도퇴사'
              END AS EMPLOYEE_TYPE
            , PM.RETIRE_DATE
        FROM HRA_YEAR_ADJUSTMENT HA
           , HRM_PERSON_MASTER   PM
           , ( -- 기존 처리 내역 --
               SELECT HYA.PERSON_ID
                    , HYA.YEAR_YYYY
                    , HYA.SOB_ID
                    , HYA.ORG_ID
                    , HYA.FIX_IN_TAX_AMT
                    , HYA.FIX_LOCAL_TAX_AMT
                    , HYA.FIX_SP_TAX_AMT
                    , HYA.SUBT_IN_TAX_AMT
                    , HYA.SUBT_LOCAL_TAX_AMT
                    , HYA.SUBT_SP_TAX_AMT
                 FROM HRA_YEAR_ADJUSTMENT_1505 HYA
                WHERE HYA.CORP_ID             = W_CORP_ID 
                  AND HYA.YEAR_YYYY           = V_YEAR_YYYY
                  AND HYA.SOB_ID              = W_SOB_ID
                  AND HYA.ORG_ID              = W_ORG_ID
                  AND ((W_PERSON_ID           IS NULL AND 1 = 1)
                  OR   (W_PERSON_ID           IS NOT NULL AND HYA.PERSON_ID = W_PERSON_ID))
             ) SX1
           , (-- 시점 인사내역.
              SELECT  HL.PERSON_ID
                    , HL.DEPT_ID
                    , DM.DEPT_CODE
                    , DM.DEPT_NAME
                    , '1' || LPAD(TO_CHAR(DM.DEPT_SORT_NUM), 3, '0') AS DEPT_SORT_NUM
                    , HL.POST_ID
                    , HP.POST_NAME
                    , HP.SORT_NUM AS POST_SORT_NUM
                    , HL.PAY_GRADE_ID
                    , HL.JOB_CATEGORY_ID
                    , HL.FLOOR_ID
                    , HF.FLOOR_NAME
                    , HF.SORT_NUM AS FLOOR_SORT_NUM
                FROM HRM_HISTORY_HEADER HH
                   , HRM_HISTORY_LINE   HL
                   , HRM_DEPT_MASTER    DM
                   , HRM_FLOOR_V        HF
                   , HRM_POST_CODE_V    HP
              WHERE HH.HISTORY_HEADER_ID    = HL.HISTORY_HEADER_ID
                AND HL.DEPT_ID              = DM.DEPT_ID
                AND HL.FLOOR_ID             = HF.FLOOR_ID
                AND HL.POST_ID              = HP.POST_ID
                AND HH.CHARGE_SEQ           IN
                      (SELECT MAX(S_HH.CHARGE_SEQ) AS CHARGE_SEQ
                          FROM HRM_HISTORY_HEADER S_HH
                             , HRM_HISTORY_LINE   S_HL
                         WHERE S_HH.HISTORY_HEADER_ID = S_HL.HISTORY_HEADER_ID
                           AND S_HH.CHARGE_DATE       <= V_END_DATE 
                           AND S_HL.PERSON_ID         = HL.PERSON_ID
                         GROUP BY S_HL.PERSON_ID
                       )
            ) T1
      WHERE HA.PERSON_ID              = PM.PERSON_ID
        AND PM.PERSON_ID              = T1.PERSON_ID
        AND HA.PERSON_ID              = SX1.PERSON_ID
        AND HA.YEAR_YYYY              = SX1.YEAR_YYYY
        AND HA.SOB_ID                 = SX1.SOB_ID
        AND HA.ORG_ID                 = SX1.ORG_ID
        
        AND HA.CORP_ID                = W_CORP_ID
        AND HA.YEAR_YYYY              = V_YEAR_YYYY 
        AND ((W_PERSON_ID             IS NULL AND 1 = 1)
        OR   (W_PERSON_ID             IS NOT NULL AND HA.PERSON_ID = W_PERSON_ID))
        AND HA.SOB_ID                 = W_SOB_ID
        AND HA.ORG_ID                 = W_ORG_ID
        AND HA.SUBMIT_DATE            = V_END_DATE
        AND NVL(HA.FIX_IN_TAX_AMT, 0) != NVL(SX1.FIX_IN_TAX_AMT, 0)
        AND ((W_DEPT_ID               IS NULL AND 1 = 1)
        OR   (W_DEPT_ID               IS NOT NULL AND T1.DEPT_ID = W_DEPT_ID))
        AND ((W_FLOOR_ID              IS NULL AND 1 = 1)
        OR   (W_FLOOR_ID              IS NOT NULL AND T1.FLOOR_ID = W_FLOOR_ID))
      ORDER BY T1.DEPT_SORT_NUM
             , T1.DEPT_CODE
     ;
  END SELECT_YEAR_READJUST_LIST;


-------------------------------------------------------------------------------
-- 2014 연말정산 계산 SELECT.
-------------------------------------------------------------------------------
  PROCEDURE SELECT_YEAR_ADJUSTMENT_NEW
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_STD_YYYYMM        IN VARCHAR2
            , W_PERSON_ID         IN HRA_YEAR_ADJUSTMENT.PERSON_ID%TYPE
            , W_SOB_ID            IN HRA_YEAR_ADJUSTMENT.SOB_ID%TYPE
            , W_ORG_ID            IN HRA_YEAR_ADJUSTMENT.ORG_ID%TYPE
            )
  AS
    V_YEAR_YYYY         VARCHAR2(4);
    V_START_DATE        DATE;
    V_END_DATE          DATE;
    V_STD_DATE          DATE := LAST_DAY(TO_DATE(W_STD_YYYYMM, 'YYYY-MM'));

  BEGIN
    V_YEAR_YYYY := TO_CHAR(V_STD_DATE, 'YYYY');
    BEGIN
      SELECT TRUNC(V_STD_DATE, 'MONTH') AS START_DATE,
             LAST_DAY(V_STD_DATE) AS END_DATE
        INTO V_START_DATE, V_END_DATE
        FROM DUAL
      ;
    EXCEPTION
      WHEN OTHERS THEN
        V_START_DATE := V_STD_DATE;
        V_END_DATE   := V_STD_DATE;
    END;
    
    OPEN P_CURSOR FOR
      SELECT HA.YEAR_YYYY AS YEAR_YYYY
           , HA.PERSON_ID AS PERSON_ID
           , HA.SUBMIT_DATE AS SUBMIT_DATE
           , HA.ADJUST_DATE_FR AS ADJUST_DATE_FR
           , HA.ADJUST_DATE_TO AS ADJUST_DATE_TO
           , NVL(HA.NOW_PAY_TOT_AMT, 0) AS NOW_PAY_TOT_AMT
           , NVL(HA.NOW_BONUS_TOT_AMT, 0) AS NOW_BONUS_TOT_AMT
           , NVL(HA.NOW_ADD_BONUS_AMT, 0) AS NOW_ADD_BONUS_AMT
           , NVL(HA.NOW_STOCK_BENE_AMT, 0) AS NOW_STOCK_BENE_AMT
           , NVL(HA.PRE_PAY_TOT_AMT, 0) AS PRE_PAY_TOT_AMT
           , NVL(HA.PRE_BONUS_TOT_AMT, 0) AS PRE_BONUS_TOT_AMT
           , NVL(HA.PRE_ADD_BONUS_AMT, 0) AS PRE_ADD_BONUS_AMT
           , NVL(HA.PRE_STOCK_BENE_AMT, 0) AS PRE_STOCK_BENE_AMT
           , NVL(HA.INCOME_OUTSIDE_AMT, 0) AS INCOME_OUTSIDE_AMT
           , ( NVL(HA.NOW_PAY_TOT_AMT, 0) + NVL(HA.NOW_BONUS_TOT_AMT, 0) +
               NVL(HA.NOW_ADD_BONUS_AMT, 0) + NVL(HA.NOW_STOCK_BENE_AMT, 0) +
               NVL(HA.PRE_PAY_TOT_AMT, 0) + NVL(HA.PRE_BONUS_TOT_AMT, 0) +
               NVL(HA.PRE_ADD_BONUS_AMT, 0) + NVL(HA.PRE_STOCK_BENE_AMT, 0) +
               NVL(HA.INCOME_OUTSIDE_AMT, 0) +
               NVL(HA.NOW_EMPLOYEE_STOCK_AMT, 0) + NVL(HA.NOW_OFFICE_RETIRE_OVER_AMT, 0) +
               NVL(HA.PRE_EMPLOYEE_STOCK_AMT, 0) + NVL(HA.PRE_OFFICE_RETIRE_OVER_AMT, 0) +
               -- 비과세
               NVL(HA.NONTAX_OUTSIDE_AMT, 0) + NVL(HA.NONTAX_OT_AMT, 0) +   -- NONTAX_OUTSIDE_AMT : 비과세 국외근로 합계
               NVL(HA.NONTAX_RESEA_AMT, 0) + NVL(HA.NONTAX_ETC_AMT, 0) +
               NVL(HA.NONTAX_BIRTH_AMT, 0) + NVL(HA.NONTAX_FOREIGNER_AMT, 0) +
               NVL(HA.NONTAX_SCH_EDU_AMT, 0) + NVL(HA.NONTAX_MEMBER_AMT, 0) +
               NVL(HA.NONTAX_GUARD_AMT, 0) + NVL(HA.NONTAX_CHILD_AMT, 0) +
               NVL(HA.NONTAX_HIGH_SCH_AMT, 0) + NVL(HA.NONTAX_SPECIAL_AMT, 0) +
               NVL(HA.NONTAX_RESEARCH_AMT, 0) + NVL(HA.NONTAX_COMPANY_AMT, 0) +
               NVL(HA.NONTAX_COVER_AMT, 0) + NVL(HA.NONTAX_WILD_AMT, 0) +
               NVL(HA.NONTAX_DISASTER_AMT, 0) + NVL(HA.NONTAX_OUTS_GOVER_AMT, 0) +
               NVL(HA.NONTAX_OUTS_ARMY_AMT, 0) + NVL(HA.NONTAX_STOCK_BENE_AMT, 0) +
               NVL(HA.NONTAX_FOR_ENG_AMT, 0) + NVL(HA.NONTAX_EMPL_STOCK_AMT, 0) +
               NVL(HA.NONTAX_EMPL_BENE_AMT_1, 0) + NVL(HA.NONTAX_EMPL_BENE_AMT_2, 0) +
               NVL(HA.NONTAX_HOUSE_SUBSIDY_AMT, 0) + NVL(HA.NONTAX_SEA_RESOURCE_AMT, 0) +
               -- 종전--
               NVL(HA.PRE_NT_OUTSIDE_AMT, 0) + NVL(HA.PRE_NT_OT_AMT, 0) +   -- NONTAX_OUTSIDE_AMT : 비과세 국외근로 합계
               NVL(HA.PRE_NT_RESEA_AMT, 0) + NVL(HA.PRE_NT_ETC_AMT, 0) +
               NVL(HA.PRE_NT_BIRTH_AMT, 0) + NVL(HA.PRE_NT_FOREIGNER_AMT, 0) +
               NVL(HA.PRE_NT_SCH_EDU_AMT, 0) + NVL(HA.PRE_NT_MEMBER_AMT, 0) +
               NVL(HA.PRE_NT_GUARD_AMT, 0) + NVL(HA.PRE_NT_CHILD_AMT, 0) +
               NVL(HA.PRE_NT_HIGH_SCH_AMT, 0) + NVL(HA.PRE_NT_SPECIAL_AMT, 0) +
               NVL(HA.PRE_NT_RESEARCH_AMT, 0) + NVL(HA.PRE_NT_COMPANY_AMT, 0) +
               NVL(HA.PRE_NT_COVER_AMT, 0) + NVL(HA.PRE_NT_WILD_AMT, 0) +
               NVL(HA.PRE_NT_DISASTER_AMT, 0) + NVL(HA.PRE_NT_OUTS_GOVER_AMT, 0) +
               NVL(HA.PRE_NT_OUTS_ARMY_AMT, 0) + NVL(HA.PRE_NT_STOCK_BENE_AMT, 0) +
               NVL(HA.PRE_NT_FOR_ENG_AMT, 0) + NVL(HA.PRE_NT_EMPL_STOCK_AMT, 0) +
               NVL(HA.PRE_NT_EMPL_BENE_AMT_1, 0) + NVL(HA.PRE_NT_EMPL_BENE_AMT_2, 0) +
               NVL(HA.PRE_NT_HOUSE_SUBSIDY_AMT, 0) + NVL(HA.PRE_NT_SEA_RESOURCE_AMT, 0)) AS TOTAL_PAY   -- 근로소득(과세 + 비과세) --
           , NVL(HA.NONTAX_OUTSIDE_AMT, 0) AS NONTAX_OUTSIDE_AMT
           , NVL(HA.NONTAX_OT_AMT, 0) AS NONTAX_OT_AMT
           , NVL(HA.NONTAX_RESEA_AMT, 0) AS NONTAX_RESEA_AMT
           , NVL(HA.NONTAX_ETC_AMT, 0) AS NONTAX_ETC_AMT
           , NVL(HA.NONTAX_BIRTH_AMT, 0) AS NONTAX_BIRTH_AMT
           , NVL(HA.NONTAX_FOREIGNER_AMT, 0) AS NONTAX_FOREIGNER_AMT
           , ( NVL(HA.NONTAX_OUTSIDE_AMT, 0) + NVL(HA.NONTAX_OT_AMT, 0) +  -- NONTAX_OUTSIDE_AMT : 비과세 국외근로 합계
               NVL(HA.NONTAX_RESEA_AMT, 0) + NVL(HA.NONTAX_ETC_AMT, 0) +
               NVL(HA.NONTAX_BIRTH_AMT, 0) + NVL(HA.NONTAX_FOREIGNER_AMT, 0) +
               NVL(HA.NONTAX_SCH_EDU_AMT, 0) + NVL(HA.NONTAX_MEMBER_AMT, 0) +
               NVL(HA.NONTAX_GUARD_AMT, 0) + NVL(HA.NONTAX_CHILD_AMT, 0) +
               NVL(HA.NONTAX_HIGH_SCH_AMT, 0) + NVL(HA.NONTAX_SPECIAL_AMT, 0) +
               NVL(HA.NONTAX_RESEARCH_AMT, 0) + NVL(HA.NONTAX_COMPANY_AMT, 0) +
               NVL(HA.NONTAX_COVER_AMT, 0) + NVL(HA.NONTAX_WILD_AMT, 0) +
               NVL(HA.NONTAX_DISASTER_AMT, 0) + NVL(HA.NONTAX_OUTS_GOVER_AMT, 0) +
               NVL(HA.NONTAX_OUTS_ARMY_AMT, 0) + NVL(HA.NONTAX_STOCK_BENE_AMT, 0) +
               NVL(HA.NONTAX_FOR_ENG_AMT, 0) + NVL(HA.NONTAX_EMPL_STOCK_AMT, 0) +
               NVL(HA.NONTAX_EMPL_BENE_AMT_1, 0) + NVL(HA.NONTAX_EMPL_BENE_AMT_2, 0) +
               NVL(HA.NONTAX_HOUSE_SUBSIDY_AMT, 0) + NVL(HA.NONTAX_SEA_RESOURCE_AMT, 0) +
               -- 종전--
               NVL(HA.PRE_NT_OUTSIDE_AMT, 0) + NVL(HA.PRE_NT_OT_AMT, 0) +   -- NONTAX_OUTSIDE_AMT : 비과세 국외근로 합계
               NVL(HA.PRE_NT_RESEA_AMT, 0) + NVL(HA.PRE_NT_ETC_AMT, 0) +
               NVL(HA.PRE_NT_BIRTH_AMT, 0) + NVL(HA.PRE_NT_FOREIGNER_AMT, 0) +
               NVL(HA.PRE_NT_SCH_EDU_AMT, 0) + NVL(HA.PRE_NT_MEMBER_AMT, 0) +
               NVL(HA.PRE_NT_GUARD_AMT, 0) + NVL(HA.PRE_NT_CHILD_AMT, 0) +
               NVL(HA.PRE_NT_HIGH_SCH_AMT, 0) + NVL(HA.PRE_NT_SPECIAL_AMT, 0) +
               NVL(HA.PRE_NT_RESEARCH_AMT, 0) + NVL(HA.PRE_NT_COMPANY_AMT, 0) +
               NVL(HA.PRE_NT_COVER_AMT, 0) + NVL(HA.PRE_NT_WILD_AMT, 0) +
               NVL(HA.PRE_NT_DISASTER_AMT, 0) + NVL(HA.PRE_NT_OUTS_GOVER_AMT, 0) +
               NVL(HA.PRE_NT_OUTS_ARMY_AMT, 0) + NVL(HA.PRE_NT_STOCK_BENE_AMT, 0) +
               NVL(HA.PRE_NT_FOR_ENG_AMT, 0) + NVL(HA.PRE_NT_EMPL_STOCK_AMT, 0) +
               NVL(HA.PRE_NT_EMPL_BENE_AMT_1, 0) + NVL(HA.PRE_NT_EMPL_BENE_AMT_2, 0) +
               NVL(HA.PRE_NT_HOUSE_SUBSIDY_AMT, 0) + NVL(HA.PRE_NT_SEA_RESOURCE_AMT, 0)) AS NONTAX_TOT_AMT
           , NVL(HA.INCOME_TOT_AMT, 0) AS INCOME_TOT_AMT  -- 총급여 --
           , NVL(HA.INCOME_DED_AMT, 0) AS INCOME_DED_AMT  -- 근로소득 공제 --
           , (NVL(HA.INCOME_TOT_AMT, 0) - NVL(HA.INCOME_DED_AMT, 0)) AS INCOME_AMT  -- 근로소득 금액 --
           , NVL(HA.PER_DED_AMT, 0) AS PER_DED_AMT
           , NVL(HA.SPOUSE_DED_AMT, 0) AS SPOUSE_DED_AMT
           , NVL(HA.SUPP_DED_COUNT, 0) AS SUPP_DED_COUNT
           , NVL(HA.SUPP_DED_AMT, 0) AS SUPP_DED_AMT
           , NVL(HA.OLD_DED_COUNT, 0) AS OLD_DED_COUNT
           , NVL(HA.OLD_DED_AMT, 0) AS OLD_DED_AMT
           , NVL(HA.OLD_DED_COUNT1, 0) AS OLD_DED_COUNT1
           , NVL(HA.OLD_DED_AMT1, 0) AS OLD_DED_AMT1
           , NVL(HA.DISABILITY_DED_COUNT, 0) AS DISABILITY_DED_COUNT
           , NVL(HA.DISABILITY_DED_AMT, 0) AS DISABILITY_DED_AMT
           , NVL(HA.WOMAN_DED_AMT, 0) AS WOMAN_DED_AMT
           , NVL(HA.CHILD_DED_COUNT, 0) AS CHILD_DED_COUNT
           , NVL(HA.CHILD_DED_AMT, 0) AS CHILD_DED_AMT
           , NVL(HA.PER_ADD_DED_AMT, 0) AS PER_ADD_DED_AMT
           , NVL(HA.MANY_CHILD_DED_COUNT, 0) AS MANY_CHILD_DED_COUNT
           , NVL(HA.MANY_CHILD_DED_AMT, 0) AS MANY_CHILD_DED_AMT
           , NVL(HA.NATI_ANNU_AMT, 0) AS NATI_ANNU_AMT          -- 국민연금 --
           , NVL(HA.ANNU_INSUR_AMT, 0) AS ANNU_INSUR_AMT        -- 연금보험료 합계 --
           , NVL(HA.MEDIC_INSUR_AMT, 0) AS MEDIC_INSUR_AMT      -- 건강보험(건강 + 장기요양보험)
           , NVL(HA.HIRE_INSUR_AMT, 0) AS HIRE_INSUR_AMT        -- 고용보험
           , NVL(HA.GUAR_INSUR_AMT, 0) AS GUAR_INSUR_AMT        -- 보장보험
           , NVL(HA.DISABILITY_INSUR_AMT, 0) AS DISABILITY_INSUR_AMT  -- 장애인보험
             -- 보험료 금액이 음수일 경우에는 0을 출력(연말정산 제출매채 양식에 -값이 들어가지 않음);
           , ( CASE
                 WHEN NVL(HA.MEDIC_INSUR_AMT, 0) + NVL(HA.HIRE_INSUR_AMT, 0) +
                      NVL(HA.GUAR_INSUR_AMT, 0) + NVL(HA.DISABILITY_INSUR_AMT, 0) < 0 THEN 0
                 ELSE NVL(HA.MEDIC_INSUR_AMT, 0) + NVL(HA.HIRE_INSUR_AMT, 0) +
                      NVL(HA.GUAR_INSUR_AMT, 0) + NVL(HA.DISABILITY_INSUR_AMT, 0)
               END) AS ETC_INSURE_AMT  -- 기타보험료 합계 --
           , NVL(HA.MEDIC_AMT, 0) AS MEDIC_AMT  -- 의료비 합계 (장애인 + 기타)
           , NVL(HA.EDUCATION_AMT, 0) AS EDUCATION_AMT  -- 교육비(장애인 + 기타)
           , (NVL(HA.HOUSE_INTER_AMT, 0) + NVL(HA.HOUSE_INTER_AMT_ETC, 0)) AS HOUSE_INTER_AMT  -- 주택임차차입금 대출기관 + 거주자
           , NVL(HA.HOUSE_FUND_AMT, 0) AS HOUSE_FUND_AMT
           , NVL(HA.DONAT_DED_ALL, 0) + NVL(HA.DONAT_DED_50, 0) +  
             NVL(HA.DONAT_DED_RELIGION_10, 0) + NVL(HA.DONAT_DED_10, 0) AS DONAT_AMT      -- 2014-특별소득공제(기부금이월분)
           , NVL(HA.MARRY_ETC_AMT, 0) AS MARRY_ETC_AMT
           , ((CASE
                 WHEN NVL(HA.MEDIC_INSUR_AMT, 0) + NVL(HA.HIRE_INSUR_AMT, 0)  < 0 THEN 0
                 ELSE NVL(HA.MEDIC_INSUR_AMT, 0) + NVL(HA.HIRE_INSUR_AMT, 0) 
               END) +
               (CASE
                 WHEN NVL(HA.HOUSE_INTER_AMT, 0) + NVL(HA.HOUSE_INTER_AMT_ETC, 0) + 
                      NVL(HA.LONG_HOUSE_PROF_AMT, 0) + 
                      NVL(HA.LONG_HOUSE_PROF_AMT_1, 0) + NVL(HA.LONG_HOUSE_PROF_AMT_2, 0) + 
                      NVL(HA.LONG_HOUSE_PROF_AMT_3_FIX, 0) + NVL(HA.LONG_HOUSE_PROF_AMT_3_ETC, 0) + 
                      NVL(HA.DONAT_DED_ALL, 0) + NVL(HA.DONAT_DED_50, 0) + 
                      NVL(HA.DONAT_DED_RELIGION_10, 0) + NVL(HA.DONAT_DED_10, 0) < 0 THEN 0
                 ELSE NVL(HA.HOUSE_INTER_AMT, 0) + NVL(HA.HOUSE_INTER_AMT_ETC, 0) + 
                      NVL(HA.LONG_HOUSE_PROF_AMT, 0) + 
                      NVL(HA.LONG_HOUSE_PROF_AMT_1, 0) + NVL(HA.LONG_HOUSE_PROF_AMT_2, 0) + 
                      NVL(HA.LONG_HOUSE_PROF_AMT_3_FIX, 0) + NVL(HA.LONG_HOUSE_PROF_AMT_3_ETC, 0) + 
                      NVL(HA.DONAT_DED_ALL, 0) + NVL(HA.DONAT_DED_50, 0) +  
                      NVL(HA.DONAT_DED_RELIGION_10, 0) + NVL(HA.DONAT_DED_10, 0)
               END) -- 주택자금(주택입차차입금 + 월세액 + 장기주택저당차입금 )
              ) AS SP_DED_SUM  -- 특별공제 합계 --                                                                                                                       
           , NVL(HA.STAND_DED_AMT, 0) AS STAND_DED_AMT  -- 표준공제   --
           , NVL(HA.SUBT_DED_AMT, 0) AS SUBT_DED_AMT    -- 차감소득금액 --
           
           , NVL(HA.PERS_ANNU_BANK_AMT, 0) AS PERS_ANNU_BANK_AMT  -- 개인연금 
           --, NVL(HA.ANNU_BANK_AMT, 0) AS ANNU_BANK_AMT  -- 2014-세액공제 이동 
           , NVL(HA.INVES_AMT, 0) AS INVES_AMT            -- 투자조합 
           , NVL(HA.FORE_INCOME_AMT, 0) AS FORE_INCOME_AMT  -- 외국 근로자 소득 --
           , NVL(HA.CREDIT_AMT, 0) AS CREDIT_AMT            -- 신용카드 
           --, NVL(HA.RETR_ANNU_AMT, 0) AS RETR_ANNU_AMT    -- 2014-세액공제 이동 
           , NVL(HA.EMPL_STOCK_AMT, 0) AS EMPL_STOCK_AMT
           , NVL(HA.DONAT_DED_30, 0) AS DONAT_DED_30                                      -- 2014-그밖의소득공제(우리사주조합기부금)
           , NVL(HA.INVEST_AMT_14, 0) AS INVEST_AMT_14                                     -- 2014-투자조합출자금액  14년
           , NVL(HA.LONG_SET_INVEST_SAVING_AMT, 0) AS LONG_SET_INVEST_SAVING_AMT           -- 2014-장기집합투자증권저축
            
           , NVL(HA.HIRE_KEEP_EMPLOY_AMT, 0) AS HIRE_KEEP_EMPLOY_AMT  -- 고용유지중소기업근로자소득공제
           , ( NVL(HA.PERS_ANNU_BANK_AMT, 0) + NVL(HA.SMALL_CORPOR_DED_AMT, 0) +
               NVL(HA.HOUSE_APP_DEPOSIT_AMT, 0) + NVL(HA.HOUSE_APP_SAVE_AMT, 0) +
               NVL(HA.HOUSE_SAVE_AMT, 0) + NVL(HA.WORKER_HOUSE_SAVE_AMT, 0) +
               NVL(HA.INVES_AMT, 0) + NVL(HA.CREDIT_AMT, 0) + NVL(HA.DONAT_DED_30, 0) + 
               NVL(HA.EMPL_STOCK_AMT, 0) + NVL(HA.LONG_STOCK_SAVING_AMT, 0) +
               NVL(HA.HIRE_KEEP_EMPLOY_AMT, 0) + NVL(HA.FIX_LEASE_DED_AMT, 0) + NVL(HA.LONG_SET_INVEST_SAVING_AMT, 0)
               ) AS TOT_ETC_DED_AMT   -- 그밖의 소득공제 합계 금액 --
               
           , NVL(HA.TAX_STD_AMT, 0) AS TAX_STD_AMT            -- 과세표준 
           , NVL(HA.COMP_TAX_AMT, 0) AS COMP_TAX_AMT          -- 산출세액 
          
           , NVL(HA.TAX_REDU_IN_LAW_AMT, 0) AS TAX_REDU_IN_LAW_AMT
           , NVL(HA.TAX_REDU_SMALL_BUSINESS, 0) AS TAX_SMALL_REDU_SP_LAW_AMT              -- 2014-세감 ( 중소기업취업청년)           
           , NVL(HA.TAX_REDU_SP_LAW_AMT, 0) + NVL(HA.TAX_REDU_SMALL_BUSINESS, 0) AS TAX_REDU_SP_LAW_AMT
           , (NVL(HA.TAX_REDU_IN_LAW_AMT, 0) + NVL(HA.TAX_REDU_SMALL_BUSINESS, 0) + NVL(HA.TAX_REDU_SP_LAW_AMT, 0))AS TAX_REDU_SUM  -- 세액감면 합계 
           
           , NVL(HA.TAX_DED_INCOME_AMT, 0) AS TAX_DED_INCOME_AMT  -- 근로소득공제 
           , NVL(HA.TAX_DED_TAXGROUP_AMT, 0) AS TAX_DED_TAXGROUP_AMT  -- 납세조합 
           , NVL(HA.TAX_DED_HOUSE_DEBT_AMT, 0) AS TAX_DED_HOUSE_DEBT_AMT  -- 주택차입금 
           , NVL(HA.TAX_DED_LONG_STOCK_AMT, 0) AS TAX_DED_LONG_STOCK_AMT  -- 
           --, NVL(HA.TAX_DED_DONAT_POLI_AMT, 0) AS TAX_DED_DONAT_POLI_AMT  -- 정치자금 기부금(2014 사용 안함)            
           , NVL(HA.TAX_DED_OUTSIDE_PAY_AMT, 0) AS TAX_DED_OUTSIDE_PAY_AMT  -- 외국납부 
           , ( NVL(HA.TAX_DED_INCOME_AMT, 0) + NVL(HA.TD_CHILD_RAISE_DED_AMT, 0) + 
               NVL(HA.TD_CHILD_6_UNDER_DED_AMT, 0) + NVL(HA.TD_BIRTH_DED_AMT, 0) + 
               NVL(HA.TD_SCIENTIST_ANNU_DED_AMT, 0) + NVL(HA.TD_WORKER_RETR_ANNU_DED_AMT, 0) + 
               NVL(HA.TD_ANNU_BANK_DED_AMT, 0) + 
               NVL(HA.TD_GUAR_INSUR_DED_AMT, 0) + NVL(HA.TD_DISABILITY_INSUR_DED_AMT, 0) + 
               NVL(HA.TD_MEDIC_DED_AMT, 0) + NVL(HA.TD_EDUCATION_DED_AMT, 0) + 
               NVL(HA.TD_POLI_DONAT_DED_AMT1, 0) + NVL(HA.TD_POLI_DONAT_DED_AMT2, 0) + 
               NVL(HA.TD_LEGAL_DONAT_DED_AMT, 0) + NVL(HA.TD_DESIGN_DONAT_DED_AMT, 0) + 
               NVL(HA.TD_STAND_DED_AMT, 0) + 
               NVL(HA.TAX_DED_TAXGROUP_AMT, 0) + NVL(HA.TAX_DED_HOUSE_DEBT_AMT, 0) + 
               NVL(HA.TAX_DED_OUTSIDE_PAY_AMT, 0) + NVL(HA.TD_HOUSE_MONTHLY_DED_AMT, 0)) AS TAX_DED_SUM  -- 세액공제 합계 
           
           , NVL(HA.FIX_TAX_AMT, 0) AS FIX_TAX_AMT  -- 결정세액
           , NVL(HA.FIX_IN_TAX_AMT, 0) AS FIX_IN_TAX_AMT           -- 원단위 절사.
           , NVL(HA.FIX_LOCAL_TAX_AMT, 0) AS FIX_LOCAL_TAX_AMT
           , NVL(HA.FIX_SP_TAX_AMT, 0) AS FIX_SP_TAX_AMT
           , ( NVL(HA.FIX_IN_TAX_AMT, 0) + NVL(HA.FIX_LOCAL_TAX_AMT, 0) +
               NVL(HA.FIX_SP_TAX_AMT, 0)) AS FIX_TAX_SUM
           , NVL(HPW1.IN_TAX_AMT, 0) AS PRE_IN_TAX_AMT
           , NVL(HPW1.LOCAL_TAX_AMT, 0) AS PRE_LOCAL_TAX_AMT
           , NVL(HPW1.SP_TAX_AMT, 0) AS PRE_SP_TAX_AMT
           , ( NVL(HPW1.IN_TAX_AMT, 0) + NVL(HPW1.LOCAL_TAX_AMT, 0) +
               NVL(HPW1.SP_TAX_AMT, 0)) AS PRE_TAX_SUM
           , ( NVL(HA.PRE_IN_TAX_AMT, 0) - NVL(HPW1.IN_TAX_AMT, 0)) AS PRE1_IN_TAX_AMT
           , ( NVL(HA.PRE_LOCAL_TAX_AMT, 0) - NVL(HPW1.LOCAL_TAX_AMT, 0)) AS PRE1_LOCAL_TAX_AMT
           , ( NVL(HA.PRE_SP_TAX_AMT, 0) - NVL(HPW1.SP_TAX_AMT, 0)) AS PRE1_SP_TAX_AMT
           , ( NVL(HA.PRE_IN_TAX_AMT, 0) - NVL(HPW1.IN_TAX_AMT, 0) +
               NVL(HA.PRE_LOCAL_TAX_AMT, 0) - NVL(HPW1.LOCAL_TAX_AMT, 0) +
               NVL(HA.PRE_SP_TAX_AMT, 0) - NVL(HPW1.SP_TAX_AMT, 0)) AS PRE1_TAX_SUM
           , NVL(HA.SUBT_IN_TAX_AMT, 0) AS SUBT_IN_TAX_AMT           -- 차감 소득세
           , NVL(HA.SUBT_LOCAL_TAX_AMT, 0) AS SUBT_LOCAL_TAX_AMT     -- 차감 주민세
           , NVL(HA.SUBT_SP_TAX_AMT, 0) AS SUBT_SP_TAX_AMT           -- 차감 농특세
           , ( NVL(HA.SUBT_IN_TAX_AMT, 0) + NVL(HA.SUBT_LOCAL_TAX_AMT, 0) +
               NVL(HA.SUBT_SP_TAX_AMT, 0)) AS SUBT_TAX_SUM
           --, NVL(HA.NONTAX_FOREIGNER_AMT, 0) AS NONTAX_FOREIGNER_AMT
           , NVL(HA.BIRTH_DED_COUNT, 0) AS BIRTH_DED_COUNT
           , NVL(HA.BIRTH_DED_AMT, 0) AS BIRTH_DED_AMT
           , ( NVL(HA.LONG_HOUSE_PROF_AMT, 0) + NVL(HA.LONG_HOUSE_PROF_AMT_1, 0) +
               NVL(HA.LONG_HOUSE_PROF_AMT_2, 0) + NVL(HA.LONG_HOUSE_PROF_AMT_3_FIX, 0) +
               NVL(HA.LONG_HOUSE_PROF_AMT_3_ETC, 0)) AS LONG_HOUSE_PROF_AMT
           , ( NVL(HA.HOUSE_APP_DEPOSIT_AMT, 0) + NVL(HA.HOUSE_APP_SAVE_AMT, 0) +
               NVL(HA.HOUSE_SAVE_AMT, 0) + NVL(HA.WORKER_HOUSE_SAVE_AMT, 0)) AS HOUSE_SAVE_AMT  -- 주택마련저축소득공제 --
           , NVL(HA.SMALL_CORPOR_DED_AMT, 0) AS SMALL_CORPOR_DED_AMT
           , NVL(HA.LONG_STOCK_SAVING_AMT, 0) AS LONG_STOCK_SAVING_AMT
           , NVL(HA.HOUSE_MONTHLY_AMT, 0) AS HOUSE_MONTHLY_AMT  -- 사용 안함 
           , HA.CLOSED_FLAG
           , DECODE(HA.CLOSED_FLAG, 'Y', HA.CLOSED_DATE) AS CLOSED_DATE
           , ( SELECT PM.NAME
                 FROM HRM_PERSON_MASTER PM
                WHERE PM.PERSON_ID    = DECODE(HA.CLOSED_FLAG, 'Y', HA.CLOSED_PERSON_ID, -1)
             ) AS CLOSED_PERSON
           -- 2013년 추가 --
           , NVL(HA.SINGLE_PARENT_DED_AMT, 0) AS SINGLE_PARENT_DED_AMT
           , NVL(HA.FIX_LEASE_DED_AMT, 0) AS FIX_LEASE_DED_AMT
           , NVL(HA.SP_DED_TOT_AMT, 0) AS SP_DED_TOT_AMT
           
           
           -- 2014년 추가 -- 
           , NVL(HA.TD_CHILD_RAISE_DED_CNT, 0) AS TD_CHILD_RAISE_DED_CNT                  -- 2014-세공 자녀양육 인원수 
           , NVL(HA.TD_CHILD_RAISE_DED_AMT, 0) AS TD_CHILD_RAISE_DED_AMT                  -- 2014-세공 자녀양육 공제금액     
           , NVL(HA.TD_CHILD_6_UNDER_DED_CNT, 0) AS TD_CHILD_6_UNDER_DED_CNT              -- 2014-세공 6세이하 인원수 
           , NVL(HA.TD_CHILD_6_UNDER_DED_AMT, 0) AS TD_CHILD_6_UNDER_DED_AMT              -- 2014-세공 6세이하 공제금액
           , NVL(HA.TD_BIRTH_DED_CNT, 0) AS TD_BIRTH_DED_CNT                              -- 2014-세공 출생/입양 인원수 
           , NVL(HA.TD_BIRTH_DED_AMT, 0) AS TD_BIRTH_DED_AMT                              -- 2014-세공 출생/입양 공제금액 
           , NVL(HA.TD_SCIENTIST_ANNU_AMT, 0) AS TD_SCIENTIST_ANNU_AMT                    -- 2014-세공 과학기술인공제 대상
           , NVL(HA.TD_SCIENTIST_ANNU_DED_AMT, 0) AS TD_SCIENTIST_ANNU_DED_AMT            -- 2014-세공 과학기술인공제 세액
           , NVL(HA.TD_WORKER_RETR_ANNU_AMT, 0) AS TD_WORKER_RETR_ANNU_AMT                -- 2014-세공 근로자 퇴직연금 대상
           , NVL(HA.TD_WORKER_RETR_ANNU_DED_AMT, 0) AS TD_WORKER_RETR_ANNU_DED_AMT        -- 2014-세공 근로자 퇴직연금 세액 
           , NVL(HA.TD_ANNU_BANK_AMT, 0) AS TD_ANNU_BANK_AMT                              -- 2014-세공 연금저축 대상
           , NVL(HA.TD_ANNU_BANK_DED_AMT, 0) AS TD_ANNU_BANK_DED_AMT                      -- 2014-세공 연금저축 세액 
           , ( NVL(HA.TD_GUAR_INSUR_AMT, 0) + 
               NVL(HA.TD_DISABILITY_INSUR_AMT, 0)) AS TD_GUAR_INSUR_AMT                   -- 2014-세공 보장성보험 대상            
           , ( NVL(HA.TD_GUAR_INSUR_DED_AMT, 0) + 
               NVL(HA.TD_DISABILITY_INSUR_DED_AMT, 0)) AS TD_GUAR_INSUR_DED_AMT           -- 2014-세공 보장성보험 세액공제 
           , NVL(HA.TD_MEDIC_AMT, 0) AS TD_MEDIC_AMT                                      -- 2014-세공 의료비 대상금액            
           , NVL(HA.TD_MEDIC_DED_AMT, 0) AS TAX_DED_MEDIC_AMT                             -- 2014-세공 의료비 세액공제
           , NVL(HA.TD_EDUCATION_AMT, 0) AS TD_EDUCATION_AMT                              -- 2014-세공 교유비 대상금액 
           , NVL(HA.TD_EDUCATION_DED_AMT, 0) AS TAX_DED_EDUCATION_AMT                     -- 2014-세공 교육비 세액공제 
           , NVL(HA.TD_POLI_DONAT_AMT1, 0) AS TD_POLI_DONAT_AMT1                          -- 2014-세공 정치자금기부금 대상(10만원 이하) 
           , NVL(HA.TD_POLI_DONAT_DED_AMT1, 0) AS TD_POLI_DONAT_DED_AMT1                  -- 2014-세공 정치자금 기부금 세액공제(10만원 이하) 
           , NVL(HA.TD_POLI_DONAT_AMT2, 0) AS TD_POLI_DONAT_AMT2                          -- 2014-세공 정치자금기부금 대상(10만원 초과) 
           , NVL(HA.TD_POLI_DONAT_DED_AMT2, 0) AS TD_POLI_DONAT_DED_AMT2                  -- 2014-세공 정치자금기부금 세액공제(10만원 초과) 
           , NVL(HA.TD_LEGAL_DONAT_AMT, 0) AS TD_LEGAL_DONAT_AMT                          -- 2014-세공 법정기부금 대상
           , NVL(HA.TD_LEGAL_DONAT_DED_AMT, 0) AS TD_LEGAL_DONAT_DED_AMT                  -- 2014-세공 법정기부금 세액공제
           , NVL(HA.TD_DESIGN_DONAT_AMT, 0) AS TD_DESIGN_DONAT_AMT                        -- 2014-세공 지정기부금 대상
           , NVL(HA.TD_DESIGN_DONAT_DED_AMT, 0) AS TD_DESIGN_DONAT_DED_AMT                -- 2014-세공 지정기부금 세액공제
           , ( NVL(HA.TD_GUAR_INSUR_DED_AMT, 0) + 
               NVL(HA.TD_DISABILITY_INSUR_DED_AMT, 0) + 
               NVL(HA.TD_MEDIC_DED_AMT, 0) + 
               NVL(HA.TD_EDUCATION_DED_AMT, 0) + 
               NVL(HA.TD_POLI_DONAT_DED_AMT1, 0) + 
               NVL(HA.TD_POLI_DONAT_DED_AMT2, 0) +
               NVL(HA.TD_LEGAL_DONAT_DED_AMT, 0) + 
               NVL(HA.TD_DESIGN_DONAT_DED_AMT, 0)) AS TD_SP_DED_TOTAL_AMT                 -- 2014-세공 특별세액공제 합계            
           , NVL(HA.TD_STAND_DED_AMT, 0) AS TD_STAND_DED_AMT                              -- 2014-세공 표준세액공제    
           , NVL(HA.TD_HOUSE_MONTHLY_AMT, 0) AS TD_HOUSE_MONTHLY_AMT                      -- 2014-세공 월세액 공제 대상
           , NVL(HA.TD_HOUSE_MONTHLY_DED_AMT, 0) AS TD_HOUSE_MONTHLY_DED_AMT              -- 2014-세공 월세액 공제금액            
        FROM HRA_YEAR_ADJUSTMENT HA
           , ( -- 종전 납부 세액
              SELECT HPW.YEAR_YYYY
                   , HPW.PERSON_ID
                   , SUM(HPW.IN_TAX_AMT) AS IN_TAX_AMT
                   , SUM(HPW.LOCAL_TAX_AMT) AS LOCAL_TAX_AMT
                   , SUM(HPW.SP_TAX_AMT) AS SP_TAX_AMT
                FROM HRA_PREVIOUS_WORK HPW
               WHERE HPW.YEAR_YYYY = V_YEAR_YYYY
                 AND HPW.PERSON_ID = W_PERSON_ID
                 AND HPW.SOB_ID    = W_SOB_ID
                 AND HPW.ORG_ID    = W_ORG_ID
               GROUP BY HPW.YEAR_YYYY, HPW.PERSON_ID
             ) HPW1
       WHERE HA.YEAR_YYYY = HPW1.YEAR_YYYY(+)
         AND HA.PERSON_ID = HPW1.PERSON_ID(+)
         AND HA.YEAR_YYYY = V_YEAR_YYYY
         AND HA.PERSON_ID = W_PERSON_ID
         AND HA.SOB_ID    = W_SOB_ID
         AND HA.ORG_ID    = W_ORG_ID
         AND HA.SUBMIT_DATE BETWEEN V_START_DATE AND V_END_DATE
       ;
  END SELECT_YEAR_ADJUSTMENT_NEW;
  

-- 연말정산 계산 MAIN --   
  PROCEDURE SET_MAIN_ADJUST
            ( P_CORP_ID           IN  NUMBER
            , P_YEAR_YYYYMM       IN  VARCHAR2
            , P_DEPT_ID           IN  NUMBER
            , P_FLOOR_ID          IN  NUMBER
            , P_YEAR_EMPLOYE_TYPE IN  VARCHAR2
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
          , P_YEAR_EMPLOYE_TYPE => P_YEAR_EMPLOYE_TYPE
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
        , P_EMPLOYE_TYPE      => NULL 
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
          , P_YEAR_EMPLOYE_TYPE => P_YEAR_EMPLOYE_TYPE
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
        , P_EMPLOYE_TYPE      => NULL 
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
          , P_YEAR_EMPLOYE_TYPE => '10'  -- 계속근로자 -- 
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
      
      -- 2014년도 연말정산.
      HRA_YEAR_ADJUST_SET_G_2014.MAIN_CAL
        ( P_CORP_ID           => P_CORP_ID
        , P_YEAR_YYYY         => V_YEAR_YYYY
        , P_STD_DATE          => V_STD_DATE
        , P_DEPT_ID           => P_DEPT_ID
        , P_FLOOR_ID          => P_FLOOR_ID
        , P_YEAR_EMPLOYE_TYPE => P_YEAR_EMPLOYE_TYPE
        , P_PERSON_ID         => P_PERSON_ID
        , P_USER_ID           => P_USER_ID
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , O_STATUS            => O_STATUS
        , O_MESSAGE           => O_MESSAGE
        );
    END IF;
  END SET_MAIN_ADJUST;


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
      /*-- 급여전송이 된 경우 마감취소 불가 --
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
      END IF;*/
      
      BEGIN
        UPDATE HRA_YEAR_ADJUSTMENT HA
           SET HA.CLOSED_FLAG       = 'N'
             , HA.CLOSED_DATE       = V_SYSDATE
             , HA.CLOSED_PERSON_ID  = P_CONNECT_PERSON_ID
         WHERE HA.YEAR_YYYY         = V_YEAR_YYYY        
           AND HA.PERSON_ID         = P_PERSON_ID
           AND HA.SOB_ID            = P_SOB_ID
           AND HA.ORG_ID            = P_ORG_ID
           AND HA.SUBMIT_DATE       BETWEEN V_START_DATE AND V_END_DATE
           AND HA.CLOSED_FLAG       = P_CLOSED_FLAG  -- 마감 구분 -- 
           AND NOT EXISTS
                 ( SELECT 'X'
                     FROM HRA_YEAR_ADJUSTMENT_1505 HA1
                    WHERE HA1.YEAR_YYYY        = HA.YEAR_YYYY
                      AND HA1.PERSON_ID        = HA.PERSON_ID
                      AND HA1.SOB_ID           = HA.SOB_ID
                      AND HA1.ORG_ID           = HA.ORG_ID
                      AND HA1.FIX_IN_TAX_AMT   = 0
                 )             -- 결정세액이 0이 아닌 사람만 풀어야 함 -- 
        ;
      EXCEPTION WHEN OTHERS THEN
        O_MESSAGE := 'Closed Flag Update Error : ' || SUBSTR(SQLERRM, 1, 150);
        RETURN;
      END;
    END IF;
    O_STATUS := 'S';
  END SET_ADJUST_CLOSED;


-- 연말정산 마감여부 return  -- 
  FUNCTION GET_ADJUST_CLOSED_FLAG_F
            ( P_YEAR_YYYY         IN  VARCHAR2
            , P_PERSON_ID         IN  NUMBER
            , P_SOB_ID            IN  NUMBER
            , P_ORG_ID            IN  NUMBER
            ) RETURN VARCHAR2
  AS
    V_ADJUST_CLOSED_FLAG        VARCHAR2(2) := 'N';
  BEGIN
     BEGIN
        SELECT NVL(HA.CLOSED_FLAG, 'N') AS CLOSED_FLAG 
          INTO V_ADJUST_CLOSED_FLAG
          FROM HRA_YEAR_ADJUSTMENT HA
         WHERE HA.YEAR_YYYY         = P_YEAR_YYYY        
           AND HA.PERSON_ID         = P_PERSON_ID
           AND HA.SOB_ID            = P_SOB_ID
           AND HA.ORG_ID            = P_ORG_ID
        ;
      EXCEPTION WHEN OTHERS THEN
        V_ADJUST_CLOSED_FLAG := 'N';
      END;
      RETURN V_ADJUST_CLOSED_FLAG;
  END GET_ADJUST_CLOSED_FLAG_F;

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
           , SUM(NVL(S_YA.PAY_TOT_AMT, 0)) AS PAY_TOT_AMT
           , SUM(NVL(S_YA.PAY_TAX_AMT, 0)) AS PAY_TAX_AMT
           , SUM(NVL(S_YA.PAY_TAX_FREE_AMT, 0)) AS PAY_TAX_FREE_AMT
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
                  /*--하나의 사업장으로 처리 위해 -- 
                  , T1.OPERATING_UNIT_ID */
                  , COUNT(YA.PERSON_ID) AS PERSON_COUNT
                  , SUM( NVL(YA.NOW_PAY_TOT_AMT, 0) + NVL(YA.NOW_BONUS_TOT_AMT, 0) +
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
                         NVL(YA.PRE_NT_HOUSE_SUBSIDY_AMT, 0) + NVL(YA.PRE_NT_SEA_RESOURCE_AMT, 0)) AS PAY_TOT_AMT
                  , SUM( CASE
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
                         END) AS PAY_TAX_AMT
                  , SUM( CASE
                           WHEN NVL(YA.FOREIGN_FIX_TAX_YN, 'N') = 'Y' THEN 0 
                           ELSE (-- 비과세 
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
                         END) AS PAY_TAX_FREE_AMT
                  , SUM(NVL(YA.FIX_IN_TAX_AMT, 0)) AS FIX_IN_TAX_AMT
                  , SUM(NVL(YA.FIX_LOCAL_TAX_AMT, 0)) AS FIX_LOCAL_TAX_AMT
                  , SUM(NVL(YA.FIX_SP_TAX_AMT, 0)) AS FIX_SP_TAX_AMT
                  , SUM(NVL(YA.FIX_IN_TAX_AMT, 0) + NVL(YA.FIX_LOCAL_TAX_AMT, 0) + NVL(YA.FIX_SP_TAX_AMT, 0)) AS FIX_TAX_SUM
                FROM HRA_YEAR_ADJUSTMENT YA
                  , HRM_PERSON_MASTER    PM
                  , ( -- 시점 인사내역.
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
               WHERE YA.PERSON_ID       = PM.PERSON_ID
                 AND PM.PERSON_ID       = T1.PERSON_ID 
                 AND YA.YEAR_YYYY       = P_YEAR_YYYY
                 AND YA.CORP_ID         = P_CORP_ID
                 AND YA.SOB_ID          = P_SOB_ID
                 AND YA.ORG_ID          = P_ORG_ID
                 AND YA.SUBMIT_DATE     BETWEEN P_START_DATE AND P_END_DATE
                 --AND NVL(YA.INCOME_TOT_AMT, 0) != 0
                 AND YA.ADJUST_DATE_TO  BETWEEN P_START_DATE AND P_END_DATE 
                 
                 -- 결정세액이 변경된 인원만 적용 --
                 AND EXISTS
                       ( SELECT 'X'
                           FROM HRA_YEAR_ADJUSTMENT_1505 HYA
                          WHERE HYA.CORP_ID               = YA.CORP_ID 
                            AND HYA.YEAR_YYYY             = YA.YEAR_YYYY
                            AND HYA.SOB_ID                = YA.SOB_ID
                            AND HYA.ORG_ID                = YA.ORG_ID 
                            AND HYA.PERSON_ID             = YA.PERSON_ID 
                            AND NVL(HYA.FIX_IN_TAX_AMT, 0) != NVL(YA.FIX_IN_TAX_AMT, 0)
                       ) 
                 -- 재계상 대상만 조회 -- 
                 AND TRUNC(YA.CREATION_DATE) >= TO_DATE('2015-05-01', 'YYYY-MM-DD')  
               GROUP BY YA.YEAR_YYYY 
                      /*--하나의 사업장으로 처리 위해 -- 
                      , T1.OPERATING_UNIT_ID */
            ) S_YA  
          , ( SELECT MI.YEAR_YYYY
                  /*--하나의 사업장으로 처리 위해 -- 
                  , T1.OPERATING_UNIT_ID */
                  , COUNT(DISTINCT MI.PERSON_ID) AS PERSON_COUNT
                FROM HRA_MEDICAL_INFO MI
                  , HRM_PERSON_MASTER PM
                  , ( -- 시점 인사내역.
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
              WHERE MI.PERSON_ID       = PM.PERSON_ID
                AND PM.PERSON_ID       = T1.PERSON_ID 
                AND MI.YEAR_YYYY       = P_YEAR_YYYY
                AND PM.CORP_ID         = P_CORP_ID
                AND MI.SOB_ID          = P_SOB_ID
                AND MI.ORG_ID          = P_ORG_ID
                AND EXISTS
                      ( SELECT 'X'
                          FROM HRA_YEAR_ADJUSTMENT YA
                         WHERE YA.YEAR_YYYY        = MI.YEAR_YYYY
                           AND YA.PERSON_ID        = MI.PERSON_ID
                           AND YA.SOB_ID           = MI.SOB_ID
                           AND YA.ORG_ID           = MI.ORG_ID
                           AND YA.TD_MEDIC_DED_AMT > 0        -- 의료비 공제금액이 있을경우 적용 -- 
                           
                           -- 결정세액이 변경된 인원만 적용 --
                           AND EXISTS
                                 ( SELECT 'X'
                                     FROM HRA_YEAR_ADJUSTMENT_1505 HYA
                                    WHERE HYA.CORP_ID               = YA.CORP_ID 
                                      AND HYA.YEAR_YYYY             = YA.YEAR_YYYY
                                      AND HYA.SOB_ID                = YA.SOB_ID
                                      AND HYA.ORG_ID                = YA.ORG_ID 
                                      AND HYA.PERSON_ID             = YA.PERSON_ID 
                                      AND NVL(HYA.FIX_IN_TAX_AMT, 0) != NVL(YA.FIX_IN_TAX_AMT, 0)
                                 ) 
                           -- 재계상 대상만 조회 -- 
                           AND TRUNC(YA.CREATION_DATE) >= TO_DATE('2015-05-01', 'YYYY-MM-DD')   
                      )
              GROUP BY MI.YEAR_YYYY 
                     /*--하나의 사업장으로 처리 위해 -- 
                     , T1.OPERATING_UNIT_ID */
            ) S_MI
          , ( SELECT DA.YEAR_YYYY
                  /*--하나의 사업장으로 처리 위해 -- 
                  , T1.OPERATING_UNIT_ID */
                  , COUNT(DISTINCT DA.PERSON_ID) AS PERSON_COUNT
                  , COUNT(DA.PERSON_ID) AS DONATION_ADJUST_COUNT
                  , SUM(DA.TOTAL_DONA_AMT) AS TOTAL_DONA_AMT
                  , SUM(DA.DONA_DED_AMT) AS DONA_DED_AMT
                FROM HRA_DONATION_ADJUSTMENT DA
                  , HRM_PERSON_MASTER        PM
                  , ( -- 시점 인사내역.
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
              WHERE DA.PERSON_ID              = PM.PERSON_ID
                AND PM.PERSON_ID              = T1.PERSON_ID 
                AND DA.YEAR_YYYY              = P_YEAR_YYYY
                AND PM.CORP_ID                = P_CORP_ID
                AND DA.SOB_ID                 = P_SOB_ID
                AND DA.ORG_ID                 = P_ORG_ID
              GROUP BY DA.YEAR_YYYY
                     /*--하나의 사업장으로 처리 위해 -- 
                     , T1.OPERATING_UNIT_ID*/ 
            ) S_DA
          , ( SELECT DI.YEAR_YYYY
                  /*--하나의 사업장으로 처리 위해 -- 
                  , T1.OPERATING_UNIT_ID */
                  , COUNT(DISTINCT DI.PERSON_ID) AS PERSON_COUNT
                FROM HRA_DONATION_INFO DI
                  , HRM_PERSON_MASTER  PM
                  , ( -- 시점 인사내역.
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
              WHERE DI.PERSON_ID              = PM.PERSON_ID
                AND PM.PERSON_ID              = T1.PERSON_ID 
                AND DI.YEAR_YYYY              = P_YEAR_YYYY
                AND PM.CORP_ID                = P_CORP_ID
                AND DI.SOB_ID                 = P_SOB_ID
                AND DI.ORG_ID                 = P_ORG_ID
              GROUP BY DI.YEAR_YYYY
                     /*--하나의 사업장으로 처리 위해 -- 
                     , T1.OPERATING_UNIT_ID */
            ) S_DI
      WHERE P_YEAR_YYYY           = S_YA.YEAR_YYYY
        --AND OU.OPERATING_UNIT_ID  = S_YA.OPERATING_UNIT_ID
        AND P_YEAR_YYYY           = S_MI.YEAR_YYYY(+)
        --AND OU.OPERATING_UNIT_ID  = S_MI.OPERATING_UNIT_ID(+)
        AND P_YEAR_YYYY           = S_DA.YEAR_YYYY(+)
        --AND OU.OPERATING_UNIT_ID  = S_DA.OPERATING_UNIT_ID(+)
        AND P_YEAR_YYYY           = S_DI.YEAR_YYYY(+)
        --AND OU.OPERATING_UNIT_ID  = S_DI.OPERATING_UNIT_ID(+)
        AND OU.CORP_ID            = P_CORP_ID
        AND OU.SOB_ID             = P_SOB_ID
        AND OU.ORG_ID             = P_ORG_ID 
        AND OU.ENABLED_FLAG       = 'Y'
        AND OU.EFFECTIVE_DATE_FR  <= P_END_DATE
        AND (OU.EFFECTIVE_DATE_TO >= P_START_DATE OR OU.EFFECTIVE_DATE_TO IS NULL)      
        
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
    
    SET_YEAR_ADJUST_FILE_2014
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
-- 2013년도 근로소득 파일생성.
-------------------------------------------------------------------------------
  PROCEDURE SET_YEAR_ADJUST_FILE_2014
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
    
    V_DONATION_POLI_1           NUMBER;          -- 기부금(정치자금기부금10만원 이하) 
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
                    || RPAD(NVL(P_TAX_PROGRAM_CODE, '9000'), 4, ' ')  -- 세무프로그램코드;
                    || RPAD(NVL(REPLACE(OU.VAT_NUMBER, '-', ''), ' '), 10, ' ')  -- 사업자등록번호;
                    || RPAD(NVL(REPLACE(CM.CORP_NAME, ' ', ''), ' '), 40, ' ')  -- 법인명(상호);
                    || RPAD(NVL(REPLACE(S_PM.DEPT_NAME, ' ', ''), ' '), 30, ' ')  -- 담당자(제출자) 부서;
                    || RPAD(NVL(REPLACE(S_PM.NAME, ' ', ''), ' '), 30, ' ')  -- 담당자(제출자) 성명;
                    || RPAD(NVL(REPLACE(CM.TEL_NUMBER, '-', ''), ' '), 15, ' ')  -- 담당자(제출자) 전화번호;
                    --> 제출내역.
                    || LPAD(1, 5, 0)  -- 신고의무자수 (B레코드);
                    || LPAD(NVL(P_USE_LANGUAGE_CODE, '101'), 3, 0)  -- 사용한글코드;
                    || RPAD(' ', 1402, ' ') AS RECORD_FILE
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
                  /*--하나의 사업장으로 처리 위해 -- 
                  AND OU.OPERATING_UNIT_ID  = P_OPERATING_UNIT_ID */
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
                      --|| LPAD(NVL(S_PW.PRE_WORKER_COUNT, 0), 7, 0)   -- 10.수록한 D레코드(전근무처)의 수(C레코드 항목6의 합계)
                      || LPAD(NVL((SELECT COUNT(PW.PERSON_ID) AS PRE_WORKER_COUNT 
                                     FROM HRA_YEAR_ADJUSTMENT HYA  
                                        , HRA_PREVIOUS_WORK    PW 
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
                                     WHERE HYA.PERSON_ID          = PW.PERSON_ID 
                                       AND PW.PERSON_ID           = T1.PERSON_ID 
                                       /*--하나의 사업장으로 처리 위해 -- 
                                       AND T1.OPERATING_UNIT_ID   = OU.OPERATING_UNIT_ID */
                                       AND PW.YEAR_YYYY           = P_YEAR_YYYY
                                       AND HYA.CORP_ID            = OU.CORP_ID
                                       AND PW.SOB_ID              = P_SOB_ID
                                       AND PW.ORG_ID              = P_ORG_ID
                                       AND HYA.SUBMIT_DATE        BETWEEN P_START_DATE AND P_END_DATE
                                       AND HYA.ADJUST_DATE_TO     BETWEEN P_START_DATE AND P_END_DATE
                                       
                                       -- 결정세액이 변경된 인원만 적용 --
                                       AND EXISTS
                                             ( SELECT 'X'
                                                 FROM HRA_YEAR_ADJUSTMENT_1505 HYA1
                                                WHERE HYA1.CORP_ID               = HYA.CORP_ID 
                                                  AND HYA1.YEAR_YYYY             = HYA.YEAR_YYYY
                                                  AND HYA1.SOB_ID                = HYA.SOB_ID
                                                  AND HYA1.ORG_ID                = HYA.ORG_ID 
                                                  AND HYA1.PERSON_ID             = HYA.PERSON_ID 
                                                  AND NVL(HYA1.FIX_IN_TAX_AMT, 0) != NVL(HYA.FIX_IN_TAX_AMT, 0)
                                             ) 
                                       -- 재계상 대상만 조회 -- 
                                       AND TRUNC(HYA.CREATION_DATE) >= TO_DATE('2015-05-01', 'YYYY-MM-DD')   
                                     GROUP BY HYA.YEAR_YYYY
                                            /*--하나의 사업장으로 처리 위해 -- 
                                            , T1.OPERATING_UNIT_ID*/
                                    ), 0), 7, 0)                     -- 10.수록한 D레코드(전근무처)의 수(C레코드 항목6의 합계)
                      || LPAD(NVL(S_YA.INCOME_TOT_AMT, 0), 14, 0)    -- 11.총급여 총계(C레코드 급여 합);
                      || LPAD(NVL(S_YA.FIX_IN_TAX, 0), 13, 0)        -- 소득세 결정세액 총계(C레코드 소득세의 합);
                      || LPAD(NVL(S_YA.FIX_LOCAL_TAX, 0), 13, 0)     -- 주민세 결정세액 총계;
                      || LPAD(NVL(S_YA.FIX_SP_TAX, 0), 13, 0)        -- 농특세 결정세액 총계;
                      || LPAD(NVL(S_YA.FIX_TOTAL_TAX, 0) - NVL(S_YA.FIX_LEGAL_TAX, 0), 13, 0)  -- 결정세액 총계;
                      -- LPAD(NVL(S_YA.FIX_TOTAL_TAX, 0), 13, 0)  -- 결정세액 총계 : 2009년 연말정산 수정 결정세액총계-법인세 결정세액 총계;
                      || LPAD(NVL(P_SUBMIT_PERIOD, '1'), 1, 0)   -- (연간합산 : 1, 휴/폐업에 의한 수시제출 : 2, 수시 분할제출 : 3);
                      || RPAD(' ', 1394, ' ') AS RECORD_FILE
                      , LPAD(REPLACE(OU.TAX_OFFICE_CODE, '-', ''), 3, 0) AS TAX_OFFICE_CODE
                      , RPAD(NVL(REPLACE(OU.VAT_NUMBER, '-', ''), ' '), 10, ' ') AS VAT_NUMBER
                    FROM HRM_CORP_MASTER CM
                       , HRM_OPERATING_UNIT OU
                       , ( -- 제출내역.
                           SELECT YA.YEAR_YYYY
                               /*--하나의 사업장으로 처리 위해 -- 
                               , T1.OPERATING_UNIT_ID */
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
                                             NVL(YA.NONTAX_RESEA_AMT, 0) + --NVL(YA.NONTAX_ETC_AMT, 0) +
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
                                             NVL(YA.PRE_NT_RESEA_AMT, 0) + --NVL(YA.PRE_NT_ETC_AMT, 0) +
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
                            WHERE YA.PERSON_ID          = PM.PERSON_ID
                              AND PM.PERSON_ID          = T1.PERSON_ID 
                              /*--하나의 사업장으로 처리 위해 -- 
                              AND T1.OPERATING_UNIT_ID  = A1.OPERATING_UNIT_ID */
                              AND YA.CORP_ID            = A1.CORP_ID
                              AND YA.YEAR_YYYY          = P_YEAR_YYYY
                              AND YA.SOB_ID             = P_SOB_ID
                              AND YA.ORG_ID             = P_ORG_ID
                              AND YA.SUBMIT_DATE        BETWEEN P_START_DATE AND P_END_DATE
                              --AND NVL(YA.INCOME_TOT_AMT, 0) != 0
                              AND YA.ADJUST_DATE_TO     BETWEEN P_START_DATE AND P_END_DATE
                              
                              -- 결정세액이 변경된 인원만 적용 --
                              AND EXISTS
                                     ( SELECT 'X'
                                         FROM HRA_YEAR_ADJUSTMENT_1505 HYA
                                        WHERE HYA.CORP_ID               = YA.CORP_ID 
                                          AND HYA.YEAR_YYYY             = YA.YEAR_YYYY
                                          AND HYA.SOB_ID                = YA.SOB_ID
                                          AND HYA.ORG_ID                = YA.ORG_ID 
                                          AND HYA.PERSON_ID             = YA.PERSON_ID 
                                          AND NVL(HYA.FIX_IN_TAX_AMT, 0) != NVL(YA.FIX_IN_TAX_AMT, 0)
                                     ) 
                              -- 재계상 대상만 조회 -- 
                              AND TRUNC(YA.CREATION_DATE) >= TO_DATE('2015-05-01', 'YYYY-MM-DD')   
                            GROUP BY YA.YEAR_YYYY
                                  /*--하나의 사업장으로 처리 위해 -- 
                                  , T1.OPERATING_UNIT_ID */
                         ) S_YA
                    WHERE CM.CORP_ID            = OU.CORP_ID
                      AND P_YEAR_YYYY           = S_YA.YEAR_YYYY
                      /*--하나의 사업장으로 처리 위해 -- 
                      AND OU.OPERATING_UNIT_ID  = S_YA.OPERATING_UNIT_ID*/
                      AND OU.CORP_ID            = A1.CORP_ID 
                      --하나의 사업장으로 처리 위해 -- 
                      AND OU.OPERATING_UNIT_ID  = A1.OPERATING_UNIT_ID
                      AND OU.SOB_ID             = P_SOB_ID
                      AND OU.ORG_ID             = P_ORG_ID 
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
                                  ELSE NVL(UPPER(S_HN.ISO_NATION_CODE), ' ')
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
                                  WHEN PM.NATIONALITY_TYPE = '9' THEN NVL(UPPER(S_HN.ISO_NATION_CODE), ' ')
                                  WHEN SUBSTR(REPLACE(PM.REPRE_NUM, '-', ''), 7, 1) BETWEEN '5' AND '8' THEN NVL(UPPER(S_HN.ISO_NATION_CODE), ' ')
                                  ELSE ' '
                                END, 2, ' ')  -- 13.국적코드(외국인인 경우만 기재);
                        || RPAD(CASE
                                  WHEN SUBSTR(REPLACE(PM.REPRE_NUM, '-', ''), 7, 1) BETWEEN '5' AND '8' THEN '2' 
                                  ELSE NVL(PM.HOUSEHOLD_TYPE, '1')
                                END, 1, 0)  -- 14.세대주여부(외국인의 경우 세대원으로 구분).
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
                                NVL(YA.INCOME_OUTSIDE_AMT, 0) +
                                NVL(YA.NOW_BONUS_TOT_AMT, 0) +
                                NVL(YA.NOW_ADD_BONUS_AMT, 0) +
                                NVL(YA.NOW_STOCK_BENE_AMT, 0) + 
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
                        || LPAD(0, 10, 0) -- 48.비과세 국외소득(공무원등 국외에서 근무하고 받는 수당 중 국내에서 근무할 경부 받는 금액상당액 초과하여 받은 금액);
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
                                 NVL(YA.NONTAX_RESEA_AMT, 0) + --NVL(YA.NONTAX_ETC_AMT, 0) +
                                 NVL(YA.NONTAX_BIRTH_AMT, 0) + NVL(YA.NONTAX_FOREIGNER_AMT, 0) +
                                 NVL(YA.NONTAX_SCH_EDU_AMT, 0) + NVL(YA.NONTAX_MEMBER_AMT, 0) +
                                 NVL(YA.NONTAX_GUARD_AMT, 0) + NVL(YA.NONTAX_CHILD_AMT, 0) + 
                                 NVL(YA.NONTAX_HIGH_SCH_AMT, 0) + NVL(YA.NONTAX_SPECIAL_AMT, 0) +
                                 NVL(YA.NONTAX_RESEARCH_AMT, 0) + NVL(YA.NONTAX_COMPANY_AMT, 0) + 
                                 NVL(YA.NONTAX_COVER_AMT, 0) + NVL(YA.NONTAX_WILD_AMT, 0) + 
                                 NVL(YA.NONTAX_DISASTER_AMT, 0) + NVL(YA.NONTAX_OUTS_GOVER_AMT, 0) + 
                                 NVL(YA.NONTAX_OUTS_ARMY_AMT, 0) + NVL(YA.NONTAX_STOCK_BENE_AMT, 0) + 
                                 NVL(YA.NONTAX_EMPL_STOCK_AMT, 0) + 
                                 NVL(YA.NONTAX_EMPL_BENE_AMT_1, 0) + NVL(YA.NONTAX_EMPL_BENE_AMT_2, 0) + 
                                 NVL(YA.NONTAX_HOUSE_SUBSIDY_AMT, 0) /*+  
                                 -- 종전-- 
                                 NVL(YA.PRE_NT_OUTSIDE_AMT, 0) + NVL(YA.PRE_NT_OT_AMT, 0) +  -- NONTAX_OUTSIDE_AMT : 비과세 국외근로 합계  
                                 NVL(YA.PRE_NT_RESEA_AMT, 0) + --NVL(YA.PRE_NT_ETC_AMT, 0) +
                                 NVL(YA.PRE_NT_BIRTH_AMT, 0) + NVL(YA.PRE_NT_FOREIGNER_AMT, 0) +
                                 NVL(YA.PRE_NT_SCH_EDU_AMT, 0) + NVL(YA.PRE_NT_MEMBER_AMT, 0) +
                                 NVL(YA.PRE_NT_GUARD_AMT, 0) + NVL(YA.PRE_NT_CHILD_AMT, 0) + 
                                 NVL(YA.PRE_NT_HIGH_SCH_AMT, 0) + NVL(YA.PRE_NT_SPECIAL_AMT, 0) +
                                 NVL(YA.PRE_NT_RESEARCH_AMT, 0) + NVL(YA.PRE_NT_COMPANY_AMT, 0) + 
                                 NVL(YA.PRE_NT_COVER_AMT, 0) + NVL(YA.PRE_NT_WILD_AMT, 0) + 
                                 NVL(YA.PRE_NT_DISASTER_AMT, 0) + NVL(YA.PRE_NT_OUTS_GOVER_AMT, 0) + 
                                 NVL(YA.PRE_NT_OUTS_ARMY_AMT, 0) + NVL(YA.PRE_NT_STOCK_BENE_AMT, 0) + 
                                 NVL(YA.PRE_NT_EMPL_STOCK_AMT, 0) + 
                                 NVL(YA.PRE_NT_EMPL_BENE_AMT_1, 0) + NVL(YA.PRE_NT_EMPL_BENE_AMT_2, 0) + 
                                 NVL(YA.PRE_NT_HOUSE_SUBSIDY_AMT, 0)    */
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
                                         NVL(YA.NONTAX_RESEA_AMT, 0) + --NVL(YA.NONTAX_ETC_AMT, 0) +
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
                                         NVL(YA.PRE_NT_RESEA_AMT, 0) + --NVL(YA.PRE_NT_ETC_AMT, 0) +
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
                       /* -- 2014년도 연말정산 변경 --  
                       || LPAD(NVL(YA.CHILD_DED_COUNT, 0), 2, 0) -- 75.자녀양육비공제인원;
                        || LPAD(NVL(YA.CHILD_DED_AMT, 0), 8, 0) -- 76.자녀양육비공제금액;
                        || LPAD(NVL(YA.BIRTH_DED_COUNT, 0), 2, 0) -- 77.출산/입양자공제인원;
                        || LPAD(NVL(YA.BIRTH_DED_AMT, 0), 8, 0) --  78.출산/입양자공제금액;*/
                        || LPAD(NVL(YA.SINGLE_PARENT_DED_AMT, 0), 10, 0) -- 79.2013년도 추가 : 한부모 가족 공제금액;
                        -- LPAD(NVL(YA.PER_ADD_DED_AMT, 0), 8, 0)   PER_ADD_DED_AMT;
                        /* -- 2014년도 연말정산 변경 --
                        --> 다자녀추가공제;
                        || LPAD(NVL(YA.MANY_CHILD_DED_COUNT, 0), 2, 0) -- 80.다자녀추가공제인원;
                        || LPAD(NVL(YA.MANY_CHILD_DED_AMT, 0), 8, 0) -- 81.다자녀추가공제금액;*/
                        -->연금보험료;
                        || LPAD(NVL(YA.NATI_ANNU_AMT, 0), 10, 0) -- 82.국민연금보험료공제;
                        || LPAD(NVL(YA.PUBLIC_INSUR_AMT, 0), 10, 0)  -- 83.기타연금보험료공제_공무원연금;
                        || LPAD(NVL(YA.MARINE_INSUR_AMT, 0), 10, 0)  -- 84.기타연금보험료공제_군인연금;
                        || LPAD(NVL(YA.SCHOOL_STAFF_INSUR_AMT, 0), 10, 0)  -- 85.기타연금보험료공제_사립학교교직원연금;
                        || LPAD(NVL(YA.POST_OFFICE_INSUR_AMT, 0), 10, 0)  -- 86.기타연금보험료공제_별정우체국연금;
                        
                        /* -- 2014년도 연말정산 변경 --
                        || LPAD(NVL(YA.SCIENTIST_ANNU_AMT, 0), 10, 0)  -- 87.기타연금보험료공제_과학기술인공제;
                        || LPAD(NVL(YA.RETR_ANNU_AMT, 0), 10, 0)  -- 88.기타연금보험료공제_근로자퇴직급여보장법;
                        || LPAD(NVL(YA.ANNU_BANK_AMT, 0), 10, 0) -- 89.2013년도 수정 : 연금저축소득공제;*/
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
                        /* -- 2014년도 연말정산 변경 --
                        || LPAD(NVL(YA.GUAR_INSUR_AMT, 0), 10, 0)  -- 92.보장보험료 ;
                        || LPAD(NVL(YA.DISABILITY_INSUR_AMT, 0), 10, 0)  -- 93.장애보험료 ;
                        || LPAD(NVL(YA.DISABILITY_MEDIC_AMT, 0), 10, 0)  -- 94.2013년도 수정 : 의료비공제금액-장애인;
                        || LPAD(NVL(YA.ETC_MEDIC_AMT, 0), 10, 0)  -- 95.2013년도 수정 : 의료비공제금액-기타;
                        || LPAD(NVL(YA.DISABILITY_EDUCATION_AMT, 0), 8, 0) -- 96.2013년도 수정 : 교육비공제금액-장애인;
                        || LPAD(NVL(YA.ETC_EDUCATION_AMT, 0), 8, 0) -- 97.2013년도 수정 : 교육비공제금액-기타;*/
                        || LPAD(NVL(YA.HOUSE_INTER_AMT, 0), 8, 0) -- 98.주택임대차차입금원리금상환공제금액(대출자);
                        || LPAD(NVL(YA.HOUSE_INTER_AMT_ETC, 0), 8, 0)  -- 99.2013년도 수정 : 주택임차차입금원리금상환액(거주자).
                        || LPAD(CASE
                                  WHEN NVL(YA.TD_HOUSE_MONTHLY_DED_AMT, 0) = 0 THEN 0
                                  ELSE NVL(YA.TD_HOUSE_MONTHLY_AMT, 0)
                                END, 8, 0)  -- 100.주택자금_월세공제 대상금액;
                        || LPAD(NVL(YA.LONG_HOUSE_PROF_AMT, 0), 8, 0) -- 101.장기주택저당차입금이자상환공제금액;
                        || LPAD(NVL(YA.LONG_HOUSE_PROF_AMT_1, 0), 8, 0) -- 102.장기주택저당차입금이자상환공제금액(15);
                        || LPAD(NVL(YA.LONG_HOUSE_PROF_AMT_2, 0), 8, 0) -- 103.장기주택저당차입금이자상환공제금액(30);
                        -- 전호수 추가 : 2012년도 연말정산 BEGIN --
                        || LPAD(NVL(YA.LONG_HOUSE_PROF_AMT_3_FIX, 0), 8, 0) -- 104.12년 이후 장기주택저당차입금이자상환공제금액(고정금리);
                        || LPAD(NVL(YA.LONG_HOUSE_PROF_AMT_3_ETC, 0), 8, 0) -- 105.12년 이후 장기주택저당차입금이자상환공제금액(기타);
                        -- 전호수 추가 : 2012년도 연말정산 END --
                        || LPAD(NVL(YA.DONAT_DED_ALL, 0) + -- 법정기부금 
                                NVL(YA.DONAT_DED_50, 0) +  -- 공익법인신탁기부금 
                                NVL(YA.DONAT_DED_RELIGION_10, 0) + -- 종교단체 기부금 
                                NVL(YA.DONAT_DED_10, 0), 11, 0)  -- 종교단체외 기부금 91. 기부금 이월분 
                                
                        || LPAD(0, 20, 0) -- 92.SP_DED_SPACE_VALUE
                        
                        || LPAD(((CASE
                                     WHEN NVL(YA.MEDIC_INSUR_AMT, 0) + NVL(YA.HIRE_INSUR_AMT, 0)  < 0 THEN 0
                                     ELSE NVL(YA.MEDIC_INSUR_AMT, 0) + NVL(YA.HIRE_INSUR_AMT, 0) 
                                   END) +
                                   (CASE
                                     WHEN NVL(YA.HOUSE_INTER_AMT, 0) + NVL(YA.HOUSE_INTER_AMT_ETC, 0) + 
                                          NVL(YA.LONG_HOUSE_PROF_AMT, 0) + 
                                          NVL(YA.LONG_HOUSE_PROF_AMT_1, 0) + NVL(YA.LONG_HOUSE_PROF_AMT_2, 0) + 
                                          NVL(YA.LONG_HOUSE_PROF_AMT_3_FIX, 0) + NVL(YA.LONG_HOUSE_PROF_AMT_3_ETC, 0) + 
                                          NVL(YA.DONAT_DED_ALL, 0) + NVL(YA.DONAT_DED_50, 0) + 
                                          NVL(YA.DONAT_DED_RELIGION_10, 0) + NVL(YA.DONAT_DED_10, 0) < 0 THEN 0
                                     ELSE NVL(YA.HOUSE_INTER_AMT, 0) + NVL(YA.HOUSE_INTER_AMT_ETC, 0) + 
                                          NVL(YA.LONG_HOUSE_PROF_AMT, 0) + 
                                          NVL(YA.LONG_HOUSE_PROF_AMT_1, 0) + NVL(YA.LONG_HOUSE_PROF_AMT_2, 0) + 
                                          NVL(YA.LONG_HOUSE_PROF_AMT_3_FIX, 0) + NVL(YA.LONG_HOUSE_PROF_AMT_3_ETC, 0) + 
                                          NVL(YA.DONAT_DED_ALL, 0) + NVL(YA.DONAT_DED_50, 0) +  
                                          NVL(YA.DONAT_DED_RELIGION_10, 0) + NVL(YA.DONAT_DED_10, 0)
                                   END) -- 주택자금(주택입차차입금 + 월세액 + 장기주택저당차입금 )
                                  ), 11, 0) -- 93.특별소득공제계;
                        /* -- 2014년도 연말정산 삭제 -- 
                        || LPAD(NVL(YA.STAND_DED_AMT, 0), 8, 0) -- 112.표준공제;*/
                        || LPAD(NVL(YA.SUBT_DED_AMT, 0), 11, 0) -- 94.차감소득금액; 
                        --> 그 밖의 소득공제.
                        || LPAD(NVL(YA.PERS_ANNU_BANK_AMT, 0), 8, 0) -- 95.개인연금저축소득공제;
                        || LPAD(NVL(YA.SMALL_CORPOR_DED_AMT, 0), 10, 0) -- 96.소기업공제부금소득공제;
                        || LPAD(NVL(YA.HOUSE_APP_DEPOSIT_AMT, 0), 10, 0)  -- 97.가)주택마련저축소득공제-청약저축;
                        || LPAD(NVL(YA.HOUSE_APP_SAVE_AMT, 0), 10, 0) -- 98.나)주택마련저축소득공제-주택청약종합저축; 
                        || LPAD(NVL(YA.WORKER_HOUSE_SAVE_AMT, 0), 10, 0)  -- 99.라)근로자주택마련저축.
                        || LPAD(NVL(YA.INVES_AMT, 0), 10, 0) -- 100.투자조합출자등소득공제;
                        || LPAD(NVL(YA.CREDIT_AMT, 0), 8, 0) -- 101.신용카드등 소득공제;                        
                        || LPAD(NVL(YA.EMPL_STOCK_AMT, 0), 10, 0) -- 102.우리사주조합소득공제(한도 400만원);
                        || LPAD(NVL(YA.DONAT_DED_30, 0), 11, 0) -- 103.우리사주조합 기부금 
                        -- 2009년 연말정산 추가 BEGIN. 고용유지중소기업근로자소득공제/공란 추가;
                        || LPAD(NVL(YA.HIRE_KEEP_EMPLOY_AMT, 0), 10, 0) -- 104.고용유지중소기업근로자소득공제;
                        || LPAD(NVL(YA.FIX_LEASE_DED_AMT, 0), 10, 0) -- 105.2013년도 추가 : 목돈안드는전세이자상환액공제;
                        || LPAD(NVL(YA.LONG_SET_INVEST_SAVING_AMT, 0), 10, 0) -- 106.2014년도 추가 : 장기집합투자증권저축 
                        -- 2009년 연말정산 추가 END --
                        || LPAD((NVL(YA.PERS_ANNU_BANK_AMT, 0) + NVL(YA.SMALL_CORPOR_DED_AMT, 0) +
                                 NVL(YA.HOUSE_APP_DEPOSIT_AMT, 0) + NVL(YA.HOUSE_APP_SAVE_AMT, 0) +
                                 NVL(YA.WORKER_HOUSE_SAVE_AMT, 0) +
                                 NVL(YA.INVES_AMT, 0) + NVL(YA.CREDIT_AMT, 0) +  
                                 NVL(YA.EMPL_STOCK_AMT, 0) + NVL(YA.DONAT_DED_30, 0) +
                                 NVL(YA.HIRE_KEEP_EMPLOY_AMT, 0) + NVL(YA.FIX_LEASE_DED_AMT, 0) + 
                                 NVL(YA.LONG_SET_INVEST_SAVING_AMT, 0)), 11, 0) -- 107.그밖의 소득공제 계(양수이면 '0'수록);
                                 
                        || LPAD(NVL(YA.SP_DED_TOT_AMT, 0), 11, 0) -- 108.특별공제 종합한도 초과액;
                        || LPAD(NVL(YA.TAX_STD_AMT, 0), 11, 0) -- 109.종합소득 과세표준;
                        || LPAD(NVL(YA.COMP_TAX_AMT, 0), 10, 0) -- 110.산출세액;
                        --> 세액감면.
                        || LPAD(NVL(YA.TAX_REDU_IN_LAW_AMT, 0), 10, 0) --111.소득세법;
                        || LPAD(NVL(YA.TAX_REDU_SP_LAW_AMT, 0), 10, 0) -- 112.조세특례제한법;
                        -- 2012년 연말정산 추가 START --
                        || LPAD(NVL(YA.TAX_REDU_SMALL_BUSINESS, 0), 10, 0) -- 113.조세특례제한법 : 중소기업 취업 청년 소득세 감면;
                        -- 2012년 연말정산 추가 END --
                        || LPAD(NVL(YA.TAX_REDU_TAX_TREATY, 0), 10, 0) -- 114.조세조약.
                        || LPAD(0, 10, 0) -- 115.공란;
                        || LPAD(NVL(YA.TAX_REDU_IN_LAW_AMT, 0) +
                                NVL(YA.TAX_REDU_SP_LAW_AMT, 0) +
                                NVL(YA.TAX_REDU_TAX_TREATY, 0) + 
                                NVL(YA.TAX_REDU_SMALL_BUSINESS, 0), 10, 0) -- 116.감면세액계;
                        --> 세액공제.
                        || LPAD(NVL(YA.TAX_DED_INCOME_AMT, 0), 10, 0) -- 117.근로소득세액공제;
                        || LPAD(NVL(YA.TD_CHILD_RAISE_DED_CNT, 0), 2, 0) -- 118.58-가 자녀세액공제인원;
                        || LPAD(NVL(YA.TD_CHILD_RAISE_DED_AMT, 0), 10, 0) -- 119.58-가 자녀세액공제;
                        || LPAD(NVL(YA.TD_CHILD_6_UNDER_DED_CNT, 0), 2, 0) -- 120.58-나 6세이하 자녀세액공제인원;
                        || LPAD(NVL(YA.TD_CHILD_6_UNDER_DED_AMT, 0), 10, 0) -- 121.58-나 6세이하 자녀세액공제;
                        || LPAD(NVL(YA.TD_BIRTH_DED_CNT, 0), 2, 0) -- 122.58-다 출생.입양 자녀세액공제인원;
                        || LPAD(NVL(YA.TD_BIRTH_DED_AMT, 0), 10, 0) -- 123.58-다 출생.입양 자녀세액공제;                        
                        || LPAD(CASE
                                  WHEN NVL(YA.TD_SCIENTIST_ANNU_DED_AMT, 0) = 0 THEN 0
                                  ELSE NVL(YA.TD_SCIENTIST_ANNU_AMT, 0)
                                END, 10, 0) -- 124.연금계좌 과학기술인공제 공제대상금액<2014추가>;
                        || LPAD(NVL(YA.TD_SCIENTIST_ANNU_DED_AMT, 0), 10, 0) -- 125.연금계좌 과학기술인공제 세액공제액<2014추가>;
                        || LPAD(CASE
                                  WHEN NVL(YA.TD_WORKER_RETR_ANNU_DED_AMT, 0) = 0 THEN 0
                                  ELSE NVL(YA.TD_WORKER_RETR_ANNU_AMT, 0)
                                END, 10, 0) -- 126.근로자 퇴직급여 공제대상금액<2014추가>;
                        || LPAD(NVL(YA.TD_WORKER_RETR_ANNU_DED_AMT, 0), 10, 0) -- 127.근로자 퇴직급여 세액공제액<2014추가>;
                        || LPAD(CASE
                                  WHEN NVL(YA.TD_ANNU_BANK_DED_AMT, 0) = 0 THEN 0
                                  ELSE NVL(YA.TD_ANNU_BANK_AMT, 0)
                                END, 10, 0) -- 128.연금계좌 연금저축 공제대상금액<2014추가>;
                        || LPAD(NVL(YA.TD_ANNU_BANK_DED_AMT, 0), 10, 0) -- 129.연금계좌 연금저축 세액공제액<2014추가>;
                        || LPAD(CASE
                                  WHEN NVL(YA.TD_GUAR_INSUR_DED_AMT, 0) = 0 THEN 0
                                  ELSE NVL(YA.TD_GUAR_INSUR_AMT, 0)
                                END, 10, 0) -- 130.보장성 보험료 공제대상금액<2014추가>;
                        || LPAD(NVL(YA.TD_GUAR_INSUR_DED_AMT, 0), 10, 0) -- 131.보장성 보험료 세액공제액<2014추가>;
                        || LPAD(CASE
                                  WHEN NVL(YA.TD_DISABILITY_INSUR_AMT, 0) = 0 THEN 0
                                  ELSE NVL(YA.TD_DISABILITY_INSUR_AMT, 0)
                                END, 10, 0) -- 132.장애인 보험료 공제대상금액<2014추가>;
                        || LPAD(NVL(YA.TD_DISABILITY_INSUR_DED_AMT, 0), 10, 0) -- 133.장애인 보험료 세액공제액<2014추가>;                        
                        || LPAD(CASE
                                  WHEN NVL(YA.TD_MEDIC_DED_AMT, 0) = 0 THEN 0
                                  ELSE NVL(YA.TD_MEDIC_AMT, 0)
                                END, 10, 0) -- 134.의료비 공제대상금액<2014추가>;
                        || LPAD(NVL(YA.TD_MEDIC_DED_AMT, 0), 10, 0) -- 135.의료비 세액공제액<2014추가>;
                        || LPAD(CASE
                                  WHEN NVL(YA.TD_EDUCATION_DED_AMT, 0) = 0 THEN 0
                                  ELSE NVL(YA.TD_EDUCATION_AMT, 0)
                                END, 10, 0) -- 136.교육비 공제대상금액<2014추가>;
                        || LPAD(NVL(YA.TD_EDUCATION_DED_AMT, 0), 10, 0) -- 137.교육비 세액공제액<2014추가>;
                        || LPAD(CASE
                                  WHEN NVL(YA.TD_POLI_DONAT_DED_AMT1, 0) = 0 THEN 0
                                  ELSE NVL(YA.TD_POLI_DONAT_AMT1, 0)
                                END, 10, 0) -- 138.기부금_정치자금_10만원이하_공제대상금액 공제대상금액<2014추가>;
                        || LPAD(NVL(YA.TD_POLI_DONAT_DED_AMT1, 0), 10, 0) -- 139.기부금_정치자금_10만원이하 세액공제액<2014추가>;
                        || LPAD(CASE
                                  WHEN NVL(YA.TD_POLI_DONAT_DED_AMT2, 0) = 0 THEN 0
                                  ELSE NVL(YA.TD_POLI_DONAT_AMT2, 0)
                                END, 11, 0) -- 140.기부금_정치자금_10만원초과_공제대상금액 공제대상금액<2014추가>;
                        || LPAD(NVL(YA.TD_POLI_DONAT_DED_AMT2, 0), 10, 0) -- 141.기부금_정치자금_10만원초과 세액공제액<2014추가>;
                        || LPAD(CASE
                                  WHEN NVL(YA.TD_LEGAL_DONAT_DED_AMT, 0) = 0 THEN 0
                                  ELSE NVL(YA.TD_LEGAL_DONAT_AMT, 0)
                                END, 11, 0) -- 142.기부금_법정기부금_공제대상금액 공제대상금액<2014추가>;
                        || LPAD(NVL(YA.TD_LEGAL_DONAT_DED_AMT, 0), 10, 0) -- 143.기부금_법정기부금 세액공제액<2014추가>;
                        || LPAD(CASE
                                  WHEN NVL(YA.TD_DESIGN_DONAT_DED_AMT, 0) = 0 THEN 0
                                  ELSE NVL(YA.TD_DESIGN_DONAT_AMT, 0)
                                END, 11, 0) -- 144.기부금_지정기부금_공제대상금액 공제대상금액<2014추가>;
                        || LPAD(NVL(YA.TD_DESIGN_DONAT_DED_AMT, 0), 10, 0) -- 145.기부금_지정기부금 세액공제액<2014추가>;
                        || LPAD((NVL(YA.TD_GUAR_INSUR_DED_AMT, 0) + 
                                 NVL(YA.TD_DISABILITY_INSUR_DED_AMT, 0) +
                                 NVL(YA.TD_MEDIC_DED_AMT, 0) + 
                                 NVL(YA.TD_EDUCATION_DED_AMT, 0) + 
                                 NVL(YA.TD_POLI_DONAT_DED_AMT1, 0) + 
                                 NVL(YA.TD_POLI_DONAT_DED_AMT2, 0) +
                                 NVL(YA.TD_LEGAL_DONAT_DED_AMT, 0) + 
                                 NVL(YA.TD_DESIGN_DONAT_DED_AMT, 0)), 10, 0)  -- 139.특별세액공제계<2014추가>;
                        || LPAD(NVL(YA.TD_STAND_DED_AMT, 0), 10, 0) -- 140.표준세액공제<2014추가>;
                        || LPAD(NVL(YA.TAX_DED_TAXGROUP_AMT, 0), 10, 0) -- 141.납세조합공제;
                        || LPAD(NVL(YA.TAX_DED_HOUSE_DEBT_AMT, 0), 10, 0) -- 142.주택차입금;
                        --|| LPAD(NVL(YA.TAX_DED_DONAT_POLI_AMT, 0), 10, 0) -- 143.기부정치자금;
                        || LPAD(NVL(YA.TAX_DED_OUTSIDE_PAY_AMT, 0), 10, 0) -- 143.외국납부;
                        || LPAD(NVL(YA.TD_HOUSE_MONTHLY_DED_AMT, 0), 10, 0) -- 144.월세세액공제;
                        || LPAD(NVL(YA.TAX_DED_INCOME_AMT, 0) + NVL(YA.TD_CHILD_RAISE_DED_AMT, 0) + 
                                NVL(YA.TD_CHILD_6_UNDER_DED_AMT, 0) + NVL(YA.TD_BIRTH_DED_AMT, 0) + 
                                NVL(YA.TD_SCIENTIST_ANNU_DED_AMT, 0) + NVL(YA.TD_WORKER_RETR_ANNU_DED_AMT, 0) + 
                                NVL(YA.TD_ANNU_BANK_DED_AMT, 0) + 
                                
                                NVL(YA.TD_GUAR_INSUR_DED_AMT, 0) + NVL(YA.TD_DISABILITY_INSUR_DED_AMT, 0) + 
                                NVL(YA.TD_MEDIC_DED_AMT, 0) + NVL(YA.TD_EDUCATION_DED_AMT, 0) + 
                                NVL(YA.TD_POLI_DONAT_DED_AMT1, 0) + NVL(YA.TD_POLI_DONAT_DED_AMT2, 0) +
                                NVL(YA.TD_LEGAL_DONAT_DED_AMT, 0) + NVL(YA.TD_DESIGN_DONAT_DED_AMT, 0) + 
                                NVL(YA.TD_STAND_DED_AMT, 0) + 
                                
                                NVL(YA.TAX_DED_TAXGROUP_AMT, 0) + NVL(YA.TAX_DED_HOUSE_DEBT_AMT, 0) +
                                NVL(YA.TAX_DED_OUTSIDE_PAY_AMT, 0) + NVL(YA.TD_HOUSE_MONTHLY_DED_AMT, 0), 10, 0) -- 145.세액공제계;
                        --> 결정세액.
                        || LPAD(NVL(YA.FIX_IN_TAX_AMT, 0), 10, 0) -- 146.소득세;
                        || LPAD(NVL(YA.FIX_LOCAL_TAX_AMT, 0), 10, 0) -- 147.주민세;
                        || LPAD(NVL(YA.FIX_SP_TAX_AMT, 0), 10, 0) -- 148.농특세;
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
                        || LPAD((NVL(YA.PRE_IN_TAX_AMT, 0) - NVL(S_PW.IN_TAX_AMT, 0)), 10, 0) -- 149.주(현)소득세.
                        || LPAD((NVL(YA.PRE_LOCAL_TAX_AMT, 0) - NVL(S_PW.LOCAL_TAX_AMT, 0)), 10, 0) --150.주(현)주민세.
                        || LPAD((NVL(YA.PRE_SP_TAX_AMT, 0) - NVL(S_PW.SP_TAX_AMT, 0)), 10, 0) -- 151.주(현)농특세. 
                        
                        || LPAD(0, 10, 0) -- 152.주(현)종(전) 근무처에서 납부특례세액 소득세.
                        || LPAD(0, 10, 0) --153.주(현)종(전) 근무처에서 납부특례세액 주민세.
                        || LPAD(0, 10, 0) -- 154.주(현)종(전) 근무처에서 납부특례세액 농특세.
                        
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
                                END, 1, 0)  -- 155. 0 <= 차감징수세액(소득세) < 1000 인 경우 "0"기재;
                        || LPAD(ABS(TRUNC((NVL(YA.FIX_IN_TAX_AMT, 0) - NVL(YA.PRE_IN_TAX_AMT, 0)), -1)), 10, 0) -- 155.차감소득세.
                        || LPAD(CASE
                                  WHEN TRUNC((NVL(YA.FIX_LOCAL_TAX_AMT, 0) - NVL(YA.PRE_LOCAL_TAX_AMT, 0)), -1) < 0 THEN 1
                                  ELSE 0
                                END, 1, 0)  -- 156. 0 <= 차감징수세액(주민세) < 1000 인 경우 "0"기재;
                        || LPAD(ABS(TRUNC((NVL(YA.FIX_LOCAL_TAX_AMT, 0) - NVL(YA.PRE_LOCAL_TAX_AMT, 0)), -1)), 10, 0) -- 156.차감주민세.
                        || LPAD(CASE
                                  WHEN TRUNC((NVL(YA.FIX_SP_TAX_AMT, 0) - NVL(YA.PRE_SP_TAX_AMT, 0)), -1) < 0 THEN 1
                                  ELSE 0
                                END, 1, 0)  -- 157. 0 <= 차감징수세액(농특세) < 1000 인 경우 "0"기재;
                        || LPAD(ABS(TRUNC((NVL(YA.FIX_SP_TAX_AMT, 0) - NVL(YA.PRE_SP_TAX_AMT, 0)), -1)), 10, 0)  -- 157.차감 농특세.                      
                        --> 150.공백.
                        || LPAD(' ', 28, ' ') AS RECORD_FILE
                        , NVL(YA.MEDIC_INSUR_AMT, 0) + NVL(YA.HIRE_INSUR_AMT, 0) AS MEDIC_INSUR_AMT  -- 'E'레코드에서 사용(건강, 고용보험료).
                        , NVL(YA.TAX_DED_DONAT_POLI_AMT, 0) AS TAX_DED_DONAT_POLI_AMT 
                        , PM.PERSON_ID
                        , REPLACE(PM.REPRE_NUM, '-') AS REPRE_NUM
                        , ROW_NUMBER() OVER(PARTITION BY YA.YEAR_YYYY ORDER BY PM.PERSON_NUM) AS C_SEQ_NO
                        , PM.JOIN_DATE
                        , PM.FOREIGN_TAX_YN
                        , NVL(YA.WOMAN_DED_AMT, 0) AS WOMAN_DED_AMT
                        , NVL(YA.SINGLE_PARENT_DED_AMT, 0) AS SINGLE_PARENT_DED_AMT  
                      FROM HRM_PERSON_MASTER_V PM
                        , HRA_YEAR_ADJUSTMENT YA
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
                                , HRM_PERSON_MASTER_V  PM
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
                                  ) TS1 
                            WHERE PW.PERSON_ID          = PM.PERSON_ID
                              AND PM.PERSON_ID          = TS1.PERSON_ID 
                              AND PW.YEAR_YYYY          = P_YEAR_YYYY
                              AND PM.CORP_ID            = A1.CORP_ID
                              /*--하나의 사업장으로 처리 위해 -- 
                              AND TS1.OPERATING_UNIT_ID = A1.OPERATING_UNIT_ID*/
                              AND PW.SOB_ID             = P_SOB_ID
                              AND PW.ORG_ID             = P_ORG_ID
                            GROUP BY PW.YEAR_YYYY
                                   , PW.PERSON_ID
                          ) S_PW
                    WHERE PM.PERSON_ID          = YA.PERSON_ID
                      AND PM.PERSON_ID          = T1.PERSON_ID 
                      AND PM.NATION_ID          = S_HN.NATION_ID(+)
                      AND YA.YEAR_YYYY          = S_PW.YEAR_YYYY(+)
                      AND YA.PERSON_ID          = S_PW.PERSON_ID(+)
                      /*--하나의 사업장으로 처리 위해 -- 
                      AND T1.OPERATING_UNIT_ID  = A1.OPERATING_UNIT_ID*/
                      AND YA.YEAR_YYYY          = P_YEAR_YYYY
                      AND YA.CORP_ID            = A1.CORP_ID
                      AND YA.SOB_ID             = P_SOB_ID
                      AND YA.ORG_ID             = P_ORG_ID
                      AND YA.SUBMIT_DATE        BETWEEN P_START_DATE AND P_END_DATE
                      --AND YA.INCOME_TOT_AMT     != 0
                      AND YA.ADJUST_DATE_TO     BETWEEN P_START_DATE AND P_END_DATE
                      
                      -- 결정세액이 변경된 인원만 적용 --
                      AND EXISTS
                            (SELECT 'X'
                               FROM HRA_YEAR_ADJUSTMENT_1505 HYA
                              WHERE HYA.CORP_ID               = YA.CORP_ID 
                                AND HYA.YEAR_YYYY             = YA.YEAR_YYYY
                                AND HYA.SOB_ID                = YA.SOB_ID
                                AND HYA.ORG_ID                = YA.ORG_ID 
                                AND HYA.PERSON_ID             = YA.PERSON_ID 
                                AND NVL(HYA.FIX_IN_TAX_AMT, 0) != NVL(YA.FIX_IN_TAX_AMT, 0)
                           ) 
                      -- 재계상 대상만 조회 -- 
                      AND TRUNC(YA.CREATION_DATE) >= TO_DATE('2015-05-01', 'YYYY-MM-DD')   
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
                            || LPAD(CASE
                                      WHEN NVL(PW.RD_SMALL_BUSINESS_AMT, 0) = 0 THEN '0'
                                      ELSE NVL(TO_CHAR(PW.JOIN_DATE, 'YYYYMMDD'), P_YEAR_YYYY || '0101')
                                    END, 8, '0') -- 13.감면기간 시작연월일;
                            || LPAD(CASE
                                      WHEN NVL(PW.RD_SMALL_BUSINESS_AMT, 0) = 0 THEN '0'
                                      ELSE NVL(TO_CHAR(PW.RETR_DATE, 'YYYYMMDD'), TO_CHAR(C1.JOIN_DATE - 1, 'YYYYMMDD'))
                                    END, 8, '0') -- 14.감면기간 종료연월일;
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
                            || LPAD(NVL(PW.RD_SMALL_BUSINESS_AMT, 0), 10, 0) -- 52.비과세-중소기업 취업청년 소득세 감면;
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
                                    NVL(PW.NT_SEA_RESOURCE_AMT, 0) + 
                                    NVL(PW.RD_SMALL_BUSINESS_AMT, 0), 10, 0)  -- 55.감면소득 계;
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
                            || RPAD(' ', 951, ' ') AS RECORD_FILE 
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
                            /* -- 2014 연말정산 삭제 -- 
                            || DECODE(SF.CHILD_YN, 'Y', '1', ' ') -- 13.자녀양육비공제;*/
                            
                            || DECODE( CASE
                                         WHEN NVL(C1.WOMAN_DED_AMT, 0) = 0 THEN 'N'
                                         ELSE SF.WOMAN_YN
                                       END, 'Y', '1', ' ') -- 13.부녀자공제;
                            -- 2009년 연말정산 수정(MODIFIED BY YOUNG MIN).경로우대 만70세이상으로 변경;
                            || CASE
                                 --WHEN SF.OLD_YN = 'Y' THEN '1'
                                 WHEN SF.OLD1_YN = 'Y' THEN '1'
                                 ELSE ' '
                               END -- 14.경로우대공제;
                            -- 2009년 연말정산 수정(MODIFIED BY YOUNG MIN).출산입양자공제추가;
                            /*-- 2014 연말정산 삭제 -- 
                            || DECODE(SF.BIRTH_YN, 'Y', '1', ' ') -- 16.출산입양자공제.*/
                            
                            || DECODE( CASE
                                         WHEN NVL(C1.SINGLE_PARENT_DED_AMT, 0) = 0 THEN 'N'
                                         ELSE SF.SINGLE_PARENT_DED_YN
                                       END, 'Y', '1', ' ') -- 15.한부모1 
                            /*-- 2009년 연말정산 수정(MODIFIED BY YOUNG MIN).다자녀추가공제 폐지;
                            || CASE
                                 WHEN SF.BASE_YN = 'Y' AND C1.MANY_CHILD_DED_AMT <> 0 AND SF.RELATION_CODE = '4' THEN '1'
                                 ELSE ' '
                               END -- 다자녀추가공제;*/
                            || DECODE(SF.BIRTH_YN, 'Y', '1', ' ') -- 16.출생/입양;
                            || DECODE(SF.CHILD_YN, 'Y', '1', ' ') -- 17.6세이하;
                            
                            --> 국세청 자료.
                            -- 2009년 연말정산 수정(MODIFIED BY YOUNG MIN).국세청자료 공제금액이 음수일 경우 0으로 표기;
                            || LPAD(CASE
                                       WHEN DECODE(SF.RELATION_CODE, 0, NVL(C1.MEDIC_INSUR_AMT, 0), 0) < 0 THEN 0
                                       ELSE NVL(SF.MEDIC_INSUR_AMT, 0) + NVL(SF.HIRE_INSUR_AMT, 0)
                                     END, 10, 0) -- 18.보험료(본인은 건강보험료 포함);
                            || LPAD(NVL(SF.INSURE_AMT, 0), 10, 0)            -- 19.보장성보험료;
                            || LPAD(NVL(SF.DISABILITY_INSURE_AMT, 0), 10, 0) -- 20.장애인 전용 보장성 보험료;
                            || LPAD(NVL(SF.MEDICAL_AMT, 0), 10, 0) -- 21.의료비;
                            || LPAD(NVL(SF.EDUCATION_AMT, 0), 10, 0) -- 22.교육비;
                            || LPAD(NVL(SF.CREDIT_AMT, 0), 10, 0) -- 23.신용카드등;
                            || LPAD(NVL(SF.CHECK_CREDIT_AMT , 0), 10, 0) -- 24.직불카드;
                            || LPAD(NVL(SF.CASH_AMT, 0) + NVL(SF.ACADE_GIRO_AMT, 0), 10, 0) -- 25.현금영수증;
                            --2012년 연말정산 추가 START --
                            || LPAD(NVL(SF.TRAD_MARKET_AMT, 0), 10, 0) -- 26.전통시장사용액;
                            || LPAD(NVL(SF.PUBLIC_TRANSIT_AMT, 0), 10, 0) -- 27.대중교통이용액1;
                            --2012년 연말정산 추가 END --
                            || LPAD(CASE
                                      WHEN  (NVL(SF.DONAT_ALL, 0) +
                                             NVL(SF.DONAT_50P, 0) +
                                             NVL(SF.DONAT_30P, 0) +
                                             NVL(SF.DONAT_10P, 0) +
                                             NVL(SF.DONAT_10P_RELIGION, 0) + 
                                             NVL(SF.ETC_DONAT_ALL, 0) +
                                             NVL(SF.ETC_DONAT_50P, 0) +
                                             NVL(SF.ETC_DONAT_30P, 0) +
                                             NVL(SF.ETC_DONAT_10P, 0) +
                                             NVL(SF.ETC_DONAT_10P_RELIGION, 0)) - 
                                             NVL(T1.DONA_AMT, 0) <= 0 THEN 0
                                      ELSE ( NVL(SF.DONAT_ALL, 0) +
                                             NVL(SF.DONAT_50P, 0) +
                                             NVL(SF.DONAT_30P, 0) +
                                             NVL(SF.DONAT_10P, 0) +
                                             NVL(SF.DONAT_10P_RELIGION, 0) + 
                                             NVL(SF.ETC_DONAT_ALL, 0) +
                                             NVL(SF.ETC_DONAT_50P, 0) +
                                             NVL(SF.ETC_DONAT_30P, 0) +
                                             NVL(SF.ETC_DONAT_10P, 0) +
                                             NVL(SF.ETC_DONAT_10P_RELIGION, 0)) - 
                                             NVL(T1.DONA_AMT, 0)
                                    END, 13, 0)  -- 28.기부금(정치자금 기부금중 10만원 이하 세액공제 기부금 지출금액은 제외).
                            -->국세청자료 이외.
                            || LPAD((CASE
                                       WHEN DECODE(SF.RELATION_CODE, 0, NVL(C1.MEDIC_INSUR_AMT, 0), 0) < 0 THEN 0
                                       ELSE DECODE(SF.RELATION_CODE, 0, NVL(SF.ETC_MEDIC_INSUR_AMT, 0) + NVL(SF.ETC_HIRE_INSUR_AMT, 0) + 
                                                                        NVL(C1.MEDIC_INSUR_AMT, 0), 0) 
                                     END), 10, 0) -- 29.국세청제공외의 건강/고용보험;
                            || LPAD(NVL(SF.ETC_INSURE_AMT, 0), 10, 0) -- 30.국세청제공외의 보험료;
                            || LPAD(NVL(SF.ETC_DISABILITY_INSURE_AMT, 0), 10, 0) -- 31.국세청제공외의 장애인 보험료;
                            
                            || LPAD(NVL(SF.ETC_MEDICAL_AMT, 0), 10, 0) -- 32.국세청제공외의 의료비;
                            || LPAD(NVL(SF.ETC_EDUCATION_AMT, 0), 10, 0) -- 33.국세청제공외의 교육비;
                            || LPAD(NVL(SF.ETC_CREDIT_AMT, 0) + NVL(SF.ETC_ACADE_GIRO_AMT, 0), 10, 0) -- 34.국세청제공외의 신용카드;
                            || LPAD(NVL(SF.ETC_CHECK_CREDIT_AMT, 0), 10, 0) -- 35.국세청제공외의 직불카드;
                            --2012년 연말정산 추가 START --
                            || LPAD(NVL(SF.ETC_TRAD_MARKET_AMT, 0), 10, 0) -- 36.전통시장사용액;
                            || LPAD(NVL(SF.ETC_PUBLIC_TRANSIT_AMT, 0), 10, 0)  -- 37. 대중교통이용액;
                            --2012년 연말정산 추가 END --
                            || LPAD(/*NVL(SF.ETC_DONAT_ALL, 0) +
                                    NVL(SF.ETC_DONAT_50P, 0) +
                                    NVL(SF.ETC_DONAT_30P, 0) +
                                    NVL(SF.ETC_DONAT_10P, 0) +
                                    NVL(SF.ETC_DONAT_10P_RELIGION, 0)*/0, 13, 0) AS RECORD_LINE -- 38.국세청제공외의 기부금;
                         FROM HRA_SUPPORT_FAMILY_V SF
                            , ( SELECT DI.YEAR_YYYY
                                     , DI.SOB_ID
                                     , DI.ORG_ID
                                     , DI.PERSON_ID
                                     , DI.REPRE_NUM
                                     , CASE
                                         WHEN SUM(DI.DONA_AMT) < 100000 THEN SUM(DI.DONA_AMT)
                                         ELSE 100000
                                       END  AS DONA_AMT -- 정치자금 기부금 10만원 이하 금액은 제외 위해 -- 
                                  FROM HRA_DONATION_INFO_V DI
                                 WHERE DI.YEAR_YYYY            = P_YEAR_YYYY
                                   AND DI.SOB_ID               = P_SOB_ID
                                   AND DI.ORG_ID               = P_ORG_ID
                                   AND DI.PERSON_ID            = C1.PERSON_ID 
                                   AND DI.DONA_TYPE            = '20'  -- 정치자금 기부금 
                                   AND DI.RELATION_CODE        = '0'   -- 본인 -- 
                                 GROUP BY DI.YEAR_YYYY
                                         , DI.SOB_ID
                                         , DI.ORG_ID
                                         , DI.PERSON_ID
                                         , DI.REPRE_NUM
                              ) T1 
                        WHERE SF.YEAR_YYYY      = T1.YEAR_YYYY(+)
                          AND SF.SOB_ID         = T1.SOB_ID(+)
                          AND SF.ORG_ID         = T1.ORG_ID(+)
                          AND SF.PERSON_ID      = T1.PERSON_ID(+) 
                          AND SF.REPRE_NUM      = T1.REPRE_NUM(+)  
                                               
                          AND SF.YEAR_YYYY      = P_YEAR_YYYY
                          AND (SF.BASE_YN        = 'Y'
                            OR SF.SPOUSE_YN      = 'Y'
                            OR SF.OLD_YN         = 'Y'
                            OR SF.OLD1_YN        = 'Y'
                            OR (SF.BASE_YN       = 'Y' AND SF.DISABILITY_YN  = 'Y')
                            OR SF.WOMAN_YN       = 'Y'
                            OR SF.CHILD_YN       = 'Y'
                            OR SF.BIRTH_YN       = 'Y'
                            OR ((NVL(SF.MEDIC_INSUR_AMT, 0) + NVL(SF.ETC_MEDIC_INSUR_AMT, 0) + 
                                NVL(SF.HIRE_INSUR_AMT, 0) + NVL(SF.ETC_HIRE_INSUR_AMT, 0) + 
                                NVL(SF.INSURE_AMT, 0) + NVL(SF.ETC_INSURE_AMT, 0) + NVL(SF.DISABILITY_INSURE_AMT, 0) + 
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
                                 || RPAD(' ', 253, ' ');   -- 공란.
                                 
                
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
                V_RECORD_FILE := V_RECORD_FILE 
                              || RPAD(' ', 1, ' ')             -- 7.관계;
                              || RPAD(' ', 1, ' ')             -- 8.내/외국인 구분 코드;
                              || RPAD(' ', 20, ' ')            -- 9.성명;
                              || RPAD(' ', 13, ' ')            -- 10.주민번호;
                              || ' '                           -- 11.기본공제;
                              || ' '                           -- 12.장애인공제;
                              || ' '                           -- 13.부녀자공제;
                              || ' '                           -- 14.경로우대공제;
                              || ' '                           -- 15.한부모1 
                              || ' '                           -- 16.출생입양1
                              || ' '                           -- 17.6세이하1
                              --> 국세청 자료 : 국세청자료 공제금액이 음수일 경우 0으로 표기;
                              || LPAD(0, 10, 0)                 -- 18.보험료(본인은 건강보험료 포함);
                              || LPAD(0, 10, 0)                 -- 19.보장성보험료;
                              || LPAD(0, 10, 0)                 -- 20.장애인 전용 보장성 보험료;
                              || LPAD(0, 10, 0)                 -- 21.의료비;
                              || LPAD(0, 10, 0)                 -- 22.교육비;
                              || LPAD(0, 10, 0)                 -- 23.신용카드등;
                              || LPAD(0, 10, 0)                 -- 24.직불카드;
                              || LPAD(0, 10, 0)                 -- 25.현금영수증;
                              || LPAD(0, 10, 0)                 -- 26.전통시장사용액;
                              || LPAD(0, 10, 0)                 -- 27.대중교통이용액1;
                              || LPAD(0, 13, 0)                 -- 28.기부금(정치자금 기부금중 10만원 이하 세액공제 기부금 지출금액은 제외).
                              -->국세청자료 이외.
                              || LPAD(0, 10, 0)                 -- 29.국세청제공외의 건강/고용보험;
                              || LPAD(0, 10, 0)                 -- 30.국세청제공외의 보험료;
                              || LPAD(0, 10, 0)                 -- 31.국세청제공외의 장애인 보험료;
                              || LPAD(0, 10, 0)                 -- 32.국세청제공외의 의료비;
                              || LPAD(0, 10, 0)                 -- 33.국세청제공외의 교육비;
                              || LPAD(0, 10, 0)                 -- 34.국세청제공외의 신용카드;
                              || LPAD(0, 10, 0)                 -- 35.국세청제공외의 직불카드;
                              || LPAD(0, 10, 0)                 -- 36.전통시장사용액;
                              || LPAD(0, 10, 0)                 -- 37.대중교통이용액;
                              || LPAD(0, 13, 0);                -- 38.기부금외;
              END LOOP E1S;
              IF V_RECORD_FILE IS NOT NULL THEN
                V_SEQ_NO := NVL(V_SEQ_NO, 0) + 1;  -- 부양가족 생성 일련번호.
                V_RECORD_FILE := V_RECORD_FILE 
                                 || LPAD(NVL(V_SEQ_NO, 1), 2, 0)  -- 일련번호.
                                 || RPAD(' ', 253, ' ');  -- 공란.
                                 
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
                            || RPAD(YB.YEAR_BANK_NAME, 50, ' ') -- 9.금융기관 상호수록;
                            || RPAD(SI.ACCOUNT_NUM, 20, ' ') -- 10.계좌번호;
                            /* -- 2014년도 연말정산 삭제 
                            || LPAD(DECODE(SI.SAVING_TYPE, '41', CASE WHEN 3 < SI.SAVING_COUNT THEN 3 ELSE SI.SAVING_COUNT END , '0'), 2, 0) -- 11.납입연차-장기주식형저축만 해당;
                            */
                            || LPAD(NVL(SI.SAVING_AMOUNT, 0), 10, 0) -- 11.불입금액;
                            || LPAD(NVL(CASE
                                          WHEN ST.TAX_DED_FLAG = 'Y' THEN SI.SAVING_REAL_DED_AMT
                                          ELSE SI.SAVING_DED_AMOUNT
                                        END, 0), 10, 0) AS RECORD_LINE               -- 12.공제금액;
                          FROM HRA_SAVING_INFO  SI
                            , HRM_SAVING_TYPE_V ST 
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
                        WHERE SI.SAVING_TYPE    = ST.SAVING_TYPE
                          AND SI.SOB_ID         = ST.SOB_ID
                          AND SI.ORG_ID         = ST.ORG_ID 
                          AND SI.BANK_CODE      = YB.YEAR_BANK_CODE
                          AND SI.SOB_ID         = YB.SOB_ID
                          AND SI.ORG_ID         = YB.ORG_ID
                          AND SI.YEAR_YYYY      = P_YEAR_YYYY
                          AND SI.PERSON_ID      = C1.PERSON_ID
                          --AND NVL(SI.SAVING_DED_AMOUNT, 0)       > 0
                          AND NVL(CASE
                                    WHEN ST.TAX_DED_FLAG = 'Y' THEN SI.SAVING_REAL_DED_AMT
                                    ELSE SI.SAVING_DED_AMOUNT
                                  END, 0)       > 0
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
                V_RECORD_FILE := V_RECORD_FILE || RPAD(' ', 120, ' ');  -- 공란.
                
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
            IF V_RECORD_COUNT != 0 THEN
              FOR F1S IN V_RECORD_COUNT + 1 .. V_F_REC_STD
              LOOP
                V_RECORD_FILE := V_RECORD_FILE || RPAD(' ', 95, ' ');
              END LOOP F1S;
              IF V_RECORD_FILE IS NOT NULL THEN
                V_SEQ_NO := NVL(V_SEQ_NO, 0) + 1;  -- 연금저축 생성 일련번호.
                V_RECORD_FILE := V_RECORD_FILE || RPAD(' ', 120, ' ');  -- 연금저축  소득공제명세 순수 길이 => 공란.
                
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
            V_REC_TEMP_1 := RPAD(' ', 20, ' ') ||  -- 7.임대인 성명
                            RPAD(' ', 13, ' ') || -- 8.주민등록번호(사업자번호) 
                            RPAD(' ', 1, ' ') ||  -- 9.주택유형1 
                            LPAD(0, 5, 0) ||  -- 10.주택계약면적 
                            RPAD(' ', 100, ' ') ||  -- 11.임대차계약서상 주소지 
                            LPAD(0, 8, 0) ||  -- 12.임대차계약기간 시작 
                            LPAD(0, 8, 0) ||  -- 13.임대차계약기간 종료 
                            LPAD(0, 10, 0) ||  -- 14.월세액 
                            LPAD(0, 10, 0);    -- 15.세액공제금액 
            V_REC_TEMP_2 := RPAD(' ', 20, ' ') ||  -- 16.대주성명 
                            RPAD(' ', 13, ' ') || -- 17.대주 주민번호 
                            LPAD(0, 8, 0) ||  -- 18.금전소비대차 계약기간 시작 
                            LPAD(0, 8, 0) ||  -- 19.금전소비대차 계약기간 종료 
                            LPAD(0, 4, 0) ||  -- 20.차입금 이자율 
                            LPAD(0, 10, 0) ||  -- 21.원리금 상환액계 
                            LPAD(0, 10, 0) ||  -- 22.원금 
                            LPAD(0, 10, 0) ||  -- 23.이자 
                            LPAD(0, 10, 0) ||  -- 24.공제금액 
                            RPAD(' ', 20, ' ') ||  -- 25.임대인 성명
                            RPAD(' ', 13, ' ') || -- 26.주민등록번호(사업자번호) 
                            RPAD(' ', 1, ' ') ||  -- 27.주택유형 
                            LPAD(0, 5, 0) ||      -- 28.주택계약면적 
                            RPAD(' ', 100, ' ') ||  -- 29.임대차계약서상 주소지 
                            LPAD(0, 8, 0) ||  -- 30.임대차계약기간 시작 
                            LPAD(0, 8, 0) ||  -- 31.임대차계약기간 종료                             
                            LPAD(0, 10, 0);   -- 32.전세보증금 
            V_RECORD_FILE := NULL;
            V_SEQ_NO    := 0;
            V_RECORD_COUNT := 0;
            FOR G1 IN ( SELECT 'G' --1.RECORD_TYPE
                            || '20' --2. DATA_TYPE
                            || RPAD(NVL(B1.TAX_OFFICE_CODE, ' '), 3, ' ') -- 3.세무서코드.
                            || LPAD(C1.C_SEQ_NO, 6, 0) -- 4.C레코드의 일련번호.
                            || RPAD(NVL(B1.VAT_NUMBER, ' '), 10, ' ') -- 5.사업자번호.
                            || RPAD(NVL(C1.REPRE_NUM, ' '), 13, ' ') AS RECORD_HEADER -- 6.주민번호.
                            
                             , HL.HOUSE_LEASE_INFO_10 AS HOUSE_LEASE_INFO_10
                             , HL.HOUSE_LEASE_INFO_20 AS HOUSE_LEASE_INFO_20
                          FROM (SELECT ROWNUM AS ROW_NUM 
                                     , RPAD(NVL(HLI.LESSOR_NAME, ' '), 20, ' ') ||  -- 7.임대인 성명
                                       RPAD(NVL(REPLACE(HLI.LESSOR_REPRE_NUM, '-', ''), ' '), 13, ' ') || -- 8.주민등록번호(사업자번호) 
                                       RPAD(NVL(HLI.HOUSE_TYPE, ' '), 1, ' ') ||  -- 9.주택유형 
                                       LPAD(REPLACE(CASE
                                                       WHEN 999.99 < TRUNC(NVL(HLI.HOUSE_AREA, 0), 2) THEN 999.99
                                                       ELSE TRUNC(NVL(HLI.HOUSE_AREA, 0), 2) 
                                                     END, '.', ''), 5, 0) ||  -- 10.주택계약면적 
                                       RPAD(NVL(HLI.LEASE_ADDR1, ' ') || ' ' || NVL(HLI.LEASE_ADDR2, ' '), 100, ' ') ||  --  11.임대차계약서상 주소지 
                                       LPAD(NVL(TO_CHAR(HLI.LEASE_TERM_FR, 'YYYYMMDD'), '0'), 8, 0) ||  -- 12.임대차계약기간 시작 
                                       LPAD(NVL(TO_CHAR(HLI.LEASE_TERM_TO, 'YYYYMMDD'), '0'), 8, 0) ||  -- 13.임대차계약기간 종료 
                                       LPAD(NVL(HLI.MONTLY_LEASE_AMT, 0), 10, 0) ||  -- 14.월세액 
                                       LPAD(NVL(HLI.HOUSE_DED_AMT, 0), 10, 0) AS HOUSE_LEASE_INFO_10  -- 15.세액공제금액 
                                     , NULL AS HOUSE_LEASE_INFO_20
                                  FROM HRA_HOUSE_LEASE_INFO_V HLI
                                WHERE HLI.YEAR_YYYY         = P_YEAR_YYYY
                                  AND HLI.PERSON_ID         = C1.PERSON_ID
                                  AND HLI.SOB_ID            = P_SOB_ID
                                  AND HLI.ORG_ID            = P_ORG_ID
                                  AND HLI.HOUSE_LEASE_TYPE  = '10'  -- 월세  
                                  AND HLI.HOUSE_DED_AMT     != 0    -- 공제금액 있는것만 처리 
                                UNION ALL
                                SELECT ROWNUM AS ROW_NUM 
                                     , NULL AS HOUSE_LEASE_INFO_10
                                     , RPAD(NVL(HLI.LOANER_NAME, ' '), 20, ' ') ||  -- 16.대주성명 
                                       RPAD(NVL(REPLACE(HLI.LOANER_REPRE_NUM, '-', ''), ' '), 13, ' ') || -- 17.대주 주민번호 
                                       LPAD(NVL(TO_CHAR(HLI.LOAN_TERM_FR, 'YYYYMMDD'), '0'), 8, 0) ||  -- 18.금전소비대차 계약기간 시작 
                                       LPAD(NVL(TO_CHAR(HLI.LOAN_TERM_TO, 'YYYYMMDD'), '0'), 8, 0) ||  -- 19.금전소비대차 계약기간 종료 
                                       LPAD(NVL(TRUNC(HLI.LOAN_INTEREST_RATE, 2), 0), 4, 0) ||  -- 20.차입금 이자율 
                                       LPAD((NVL(HLI.LOAN_AMT, 0) + NVL(HLI.LOAN_INTEREST_AMT, 0)), 10, 0) ||  -- 21.원리금 상환액계 
                                       LPAD(NVL(HLI.LOAN_AMT, 0), 10, 0) ||  -- 22.원금 
                                       LPAD(NVL(HLI.LOAN_INTEREST_AMT, 0), 10, 0) ||  -- 23.이자 
                                       LPAD(NVL(HLI.HOUSE_DED_AMT, 0), 10, 0) ||  -- 24.공제금액 
                                       RPAD(NVL(HLI.LESSOR_NAME, ' '), 20, ' ') ||  -- 25.임대인 성명
                                       RPAD(NVL(REPLACE(HLI.LESSOR_REPRE_NUM, '-', ''), ' '), 13, ' ') || -- 26.주민등록번호(사업자번호) 
                                       RPAD(NVL(HLI.HOUSE_TYPE, ' '), 1, ' ') ||  -- 27.주택유형 
                                       LPAD(REPLACE(CASE
                                                       WHEN 999.99 < TRUNC(NVL(HLI.HOUSE_AREA, 0), 2) THEN 999.99
                                                       ELSE TRUNC(NVL(HLI.HOUSE_AREA, 0), 2) 
                                                     END, '.', ''), 5, 0) ||  -- 28.주택계약면적 
                                       RPAD(NVL(HLI.LEASE_ADDR1, ' ') || ' ' || NVL(HLI.LEASE_ADDR2, ' '), 100, ' ') ||  --  임29.대차계약서상 주소지 
                                       LPAD(NVL(TO_CHAR(HLI.LEASE_TERM_FR, 'YYYYMMDD'), '0'), 8, 0) ||  -- 30.임대차계약기간 시작 
                                       LPAD(NVL(TO_CHAR(HLI.LEASE_TERM_TO, 'YYYYMMDD'), '0'), 8, 0) ||  -- 31.임대차계약기간 종료 
                                       LPAD(NVL(HLI.DEPOSIT_AMT, 0), 10, 0) AS HOUSE_LEASE_INFO_20  -- 32.전세보증금            
                                  FROM HRA_HOUSE_LEASE_INFO_V HLI
                                WHERE HLI.YEAR_YYYY         = P_YEAR_YYYY
                                  AND HLI.PERSON_ID         = C1.PERSON_ID
                                  AND HLI.SOB_ID            = P_SOB_ID
                                  AND HLI.ORG_ID            = P_ORG_ID
                                  AND HLI.HOUSE_LEASE_TYPE  = '20'  -- 거주자 주택임차차입원리금 
                               ) HL
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
                V_RECORD_FILE := V_RECORD_FILE || RPAD(' ', 244, ' ');  -- 공란.
                
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
                V_RECORD_FILE := V_RECORD_FILE || RPAD(' ', 244, ' ');  -- 공란.

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
  END SET_YEAR_ADJUST_FILE_2014;            

-------------------------------------------------------------------------------
-- 2013년도 의료비 파일생성.
-------------------------------------------------------------------------------
  PROCEDURE SET_MEDICAL_FILE_2014
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
                  FROM HRA_MEDICAL_INFO_V MI
                    , HRM_PERSON_MASTER_V PM
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
                  /*--하나의 사업장으로 처리 위해 -- 
                  AND T1.OPERATING_UNIT_ID  = P_OPERATING_UNIT_ID */     
                  AND EXISTS
                        ( SELECT 'X'
                            FROM HRA_YEAR_ADJUSTMENT YA
                           WHERE YA.YEAR_YYYY         = MI.YEAR_YYYY
                             AND YA.PERSON_ID         = MI.PERSON_ID
                             AND YA.SOB_ID            = MI.SOB_ID
                             AND YA.ORG_ID            = MI.ORG_ID
                             AND YA.TD_MEDIC_DED_AMT  > 0            -- 의료비 공제금액이 존재 하는 것만 적용 -- 
                        )       
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
  END SET_MEDICAL_FILE_2014;
            
-------------------------------------------------------------------------------
-- 2013년도 기부금 파일생성.
-------------------------------------------------------------------------------
  PROCEDURE SET_DONATION_FILE_2014
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
                                    /*--하나의 사업장으로 처리 위해 -- 
                                    AND T1.OPERATING_UNIT_ID    = A1.OPERATING_UNIT_ID*/
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
                                    /*--하나의 사업장으로 처리 위해 -- 
                                    AND T1.OPERATING_UNIT_ID    = A1.OPERATING_UNIT_ID*/
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
                      /*--하나의 사업장으로 처리 위해 -- 
                      AND T1.OPERATING_UNIT_ID  = A1.OPERATING_UNIT_ID */
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
                          || LPAD(A1.TAX_OFFICE_CODE, 3, '0') -- 세무서코드;
                          || LPAD(C1.SEQ_NO, 6, '0')   -- 일련번호.
                              -- 일련번호;
  /*                              || LPAD(ROWNUM, 6, 0) --AS SEQ_NO    -- 일련번호;*/
                          || RPAD(A1.VAT_NUMBER, 10, ' ') -- 사업자등록번호;
                          || RPAD(REPLACE(PM.REPRE_NUM, '-', ''), 13, ' ') -- 소득자의 주민등록번호;
                          || RPAD(CASE
                                    WHEN SUBSTR(REPLACE(PM.REPRE_NUM, '-', ''), 7, 1) BETWEEN '5' AND '8' THEN '9'
                                    ELSE '1'
                                  END, 1, '0') -- 내외국인 구분코드;
                          || RPAD(PM.NAME, 30, ' ') -- 소득자의 성명;
                          || RPAD(NVL(DA.DONA_TYPE, ' '), 2, ' ') -- 기부코드;
                          || LPAD(DA.DONA_YYYY, 4, '0')           -- 기부년도;
                          || LPAD(NVL(DA.DONA_AMT, '0'), 13, '0') -- 기부금액(기부자,기부처별,유형별 합산);
                          || LPAD(NVL(DA.PRE_DONA_DED_AMT, 0), 13, '0') -- 전년까지 공제된 금액;
                          || LPAD(NVL(DA.TOTAL_DONA_AMT, 0), 13, '0') -- 공제대상금액;
                          || LPAD(NVL(DA.DONA_DED_AMT, 0), 13, '0')    -- 해당년도 공제금액;
                          || LPAD(NVL(DA.LAPSE_DONA_AMT, 0), 13, '0')    -- 해당년도 소멸금액;
                          || LPAD(NVL(DA.NEXT_DONA_AMT, 0), 13, '0')    -- 해당년도 이월금액;
                          || LPAD(ROW_NUMBER() OVER(PARTITION BY PM.PERSON_NUM ORDER BY PM.PERSON_NUM, DA.YEAR_YYYY), 5, '0')         -- 기부금조정명세 일련번호;
                          || RPAD(' ', 25, ' ') AS RECORD_FILE
                          , DA.YEAR_YYYY AS YEAR_YYYY
                          , PM.PERSON_ID
                          , DA.DONA_TYPE
                          , ROW_NUMBER() OVER(PARTITION BY PM.PERSON_NUM ORDER BY PM.PERSON_NUM, DA.YEAR_YYYY) AS SORT_NUM
                        FROM HRM_PERSON_MASTER_V PM
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
                          || LPAD(A1.TAX_OFFICE_CODE, 3, '0') -- 세무서코드;
                          || LPAD(C1.SEQ_NO, 6, '0')    -- 일련번호;
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
                          || LPAD(NVL(DI.DONA_COUNT, 0), 5, '0') --기부횟수(기부자,기부처별,유형별 합산);
                          || LPAD(NVL(DI.DONA_AMT, 0), 13, '0') -- 기부금(기부자,기부처별,유형별 합산);/*|| LPAD(I_YEAR_YYYY || '0101', 8, 0) --AS TAX_PERIOD_START
                          || LPAD(ROW_NUMBER() OVER(PARTITION BY PM.PERSON_NUM ORDER BY PM.PERSON_NUM), 5, '0')
                          --|| LPAD(C1.SORT_NUM, 5, 0)         -- 기부금조정명세 일련번호;
                          || RPAD(' ', 42, ' ') AS RECORD_FILE
                          , ROW_NUMBER() OVER(PARTITION BY PM.PERSON_NUM ORDER BY PM.PERSON_NUM) AS SORT_NUM
                        FROM HRM_PERSON_MASTER_V PM
                          , HRA_DONATION_INFO_V DI
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
  END SET_DONATION_FILE_2014;
                  
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
        
END HRA_YEAR_RE_ADJUSTMENT_G;
/
