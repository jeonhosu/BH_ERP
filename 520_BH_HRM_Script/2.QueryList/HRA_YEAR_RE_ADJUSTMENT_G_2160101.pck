CREATE OR REPLACE PACKAGE HRA_YEAR_RE_ADJUSTMENT_G
AS

-------------------------------------------------------------------------------
-- ������� ��ȸ --
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

-- �������� ��� : DELETE.
  PROCEDURE DELETE_YEAR_ADJUSTMENT
            ( W_STD_YYYYMM        IN VARCHAR2
            , W_PERSON_ID         IN HRA_YEAR_ADJUSTMENT.PERSON_ID%TYPE
            , W_SOB_ID            IN HRA_YEAR_ADJUSTMENT.SOB_ID%TYPE
            , W_ORG_ID            IN HRA_YEAR_ADJUSTMENT.ORG_ID%TYPE
            );
            
-------------------------------------------------------------------------------
-- �������� ���� ���� / ���� ��� ������ ��ȸ --
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
-- 2014 �������� ��� SELECT : �ұ��Թ� ��.
-------------------------------------------------------------------------------
  PROCEDURE SELECT_YEAR_ADJUSTMENT_OLD
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_STD_YYYYMM        IN VARCHAR2
            , W_PERSON_ID         IN HRA_YEAR_ADJUSTMENT.PERSON_ID%TYPE
            , W_SOB_ID            IN HRA_YEAR_ADJUSTMENT.SOB_ID%TYPE
            , W_ORG_ID            IN HRA_YEAR_ADJUSTMENT.ORG_ID%TYPE
            );
 
-------------------------------------------------------------------------------
-- �������� ���� �� ��ȸ : ������ ���� 
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
-- �������� ���� �� ��ȸ : ������ ���� 
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
-- 2014 �������� �ұ��Թ� ���� ��� SELECT.
-------------------------------------------------------------------------------
  PROCEDURE SELECT_YEAR_ADJUSTMENT_NEW
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_STD_YYYYMM        IN VARCHAR2
            , W_PERSON_ID         IN HRA_YEAR_ADJUSTMENT.PERSON_ID%TYPE
            , W_SOB_ID            IN HRA_YEAR_ADJUSTMENT.SOB_ID%TYPE
            , W_ORG_ID            IN HRA_YEAR_ADJUSTMENT.ORG_ID%TYPE
            );

---------------------------------------------------------------------
-- �������� ��� -- 
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


-- �������� ���� / ���� ��� -- 
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
            
-- �������� �������� return  -- 
  FUNCTION GET_ADJUST_CLOSED_FLAG_F
            ( P_YEAR_YYYY         IN  VARCHAR2
            , P_PERSON_ID         IN  NUMBER
            , P_SOB_ID            IN  NUMBER
            , P_ORG_ID            IN  NUMBER
            ) RETURN VARCHAR2;      


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
-- 2014�⵵ �ٷμҵ� ���ϻ���.
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
-- 2014�⵵ �Ƿ�� ���ϻ���.
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
-- 2014�⵵ ��α� ���ϻ���.
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
                                                                              
END HRA_YEAR_RE_ADJUSTMENT_G;
/
CREATE OR REPLACE PACKAGE BODY HRA_YEAR_RE_ADJUSTMENT_G
AS
/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : HRA_YEAR_ADJUSTMENT_G
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
-- ������� ��ȸ --
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
        , (-- ���� �λ系��.
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
             )             -- ���������� 0�� �ƴ� ����� Ǯ��� �� -- 
      ORDER BY T1.FLOOR_SORT_NUM
             , T1.POST_SORT_NUM
      ;
  END SELECT_PERSON;

-- �������� ��� : DELETE.
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
         AND HA.CLOSED_FLAG       = 'N'  -- ���� �ȵ� �ڷḸ.
       ;
    EXCEPTION
      WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20001, 'Delete Error : Person ID - ' || W_PERSON_ID || CHR(10) || SQLERRM);
        RETURN;
    END;
  END DELETE_YEAR_ADJUSTMENT;

-------------------------------------------------------------------------------
-- �������� ���� ���� / ���� ��� ������ ��ȸ --
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
            TO_CHAR(HA.ADJUST_DATE_TO, 'YYYY-MM-DD') AS APPLY_TERM  -- ����Ⱓ --
          , TRUNC(NVL(HA.SUBT_IN_TAX_AMT, 0), -1) AS SUBT_IN_TAX_AMT  -- ���� �ҵ漼 --
          , TRUNC(NVL(HA.SUBT_LOCAL_TAX_AMT, 0), -1) AS SUBT_LOCAL_TAX_AMT  -- ���� �ֹμ� --
          , TRUNC(NVL(HA.SUBT_SP_TAX_AMT, 0), -1) AS SUBT_SP_TAX_AMT  -- ���� ��Ư�� --
          , ( TRUNC(NVL(HA.SUBT_IN_TAX_AMT, 0), -1) +
              TRUNC(NVL(HA.SUBT_LOCAL_TAX_AMT, 0), -1) +
              TRUNC(NVL(HA.SUBT_SP_TAX_AMT, 0), -1)) AS SUBT_TAX_SUM   -- ���� �հ� --
          , NVL(HA.INCOME_TOT_AMT, 0) AS TAX_PAY_SUM
          , ( NVL(HA.NONTAX_OUTSIDE_AMT, 0) + NVL(HA.NONTAX_OT_AMT, 0) +  -- NONTAX_OUTSIDE_AMT : ����� ���ܱٷ� �հ�
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
              -- ����--
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
          , TRUNC(NVL(HA.FIX_IN_TAX_AMT, 0), -1) AS FIX_IN_TAX_AMT  -- ������ ����.
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
              WHEN PM.RETIRE_DATE IS NULL THEN '��ӱٹ�'
              WHEN TO_DATE(TO_CHAR(V_END_DATE, 'YYYY') || '12-31', 'YYYY-MM-DD') < PM.RETIRE_DATE THEN '��ӱٹ�'
              ELSE '�ߵ����'
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
           , (-- ���� �λ系��.
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
        AND HA.CLOSED_FLAG          = W_CLOSED_FLAG  -- ���� ���� --
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
             )             -- ���������� 0�� �ƴ� ����� Ǯ��� �� -- 
      ORDER BY T1.DEPT_SORT_NUM
             , T1.DEPT_CODE
             , T1.FLOOR_SORT_NUM
      ;
  END SELECT_YEAR_ADJUSTMENT_CLOSED;
            
   
-------------------------------------------------------------------------------
-- 2014 �������� ��� SELECT : �ұ��Թ� ��.
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
               -- �����
               NVL(HA.NONTAX_OUTSIDE_AMT, 0) + NVL(HA.NONTAX_OT_AMT, 0) +   -- NONTAX_OUTSIDE_AMT : ����� ���ܱٷ� �հ�
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
               -- ����--
               NVL(HA.PRE_NT_OUTSIDE_AMT, 0) + NVL(HA.PRE_NT_OT_AMT, 0) +   -- NONTAX_OUTSIDE_AMT : ����� ���ܱٷ� �հ�
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
               NVL(HA.PRE_NT_HOUSE_SUBSIDY_AMT, 0) + NVL(HA.PRE_NT_SEA_RESOURCE_AMT, 0)) AS TOTAL_PAY   -- �ٷμҵ�(���� + �����) --
           , NVL(HA.NONTAX_OUTSIDE_AMT, 0) AS NONTAX_OUTSIDE_AMT
           , NVL(HA.NONTAX_OT_AMT, 0) AS NONTAX_OT_AMT
           , NVL(HA.NONTAX_RESEA_AMT, 0) AS NONTAX_RESEA_AMT
           , NVL(HA.NONTAX_ETC_AMT, 0) AS NONTAX_ETC_AMT
           , NVL(HA.NONTAX_BIRTH_AMT, 0) AS NONTAX_BIRTH_AMT
           , NVL(HA.NONTAX_FOREIGNER_AMT, 0) AS NONTAX_FOREIGNER_AMT
           , ( NVL(HA.NONTAX_OUTSIDE_AMT, 0) + NVL(HA.NONTAX_OT_AMT, 0) +  -- NONTAX_OUTSIDE_AMT : ����� ���ܱٷ� �հ�
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
               -- ����--
               NVL(HA.PRE_NT_OUTSIDE_AMT, 0) + NVL(HA.PRE_NT_OT_AMT, 0) +   -- NONTAX_OUTSIDE_AMT : ����� ���ܱٷ� �հ�
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
           , NVL(HA.INCOME_TOT_AMT, 0) AS INCOME_TOT_AMT  -- �ѱ޿� --
           , NVL(HA.INCOME_DED_AMT, 0) AS INCOME_DED_AMT  -- �ٷμҵ� ���� --
           , (NVL(HA.INCOME_TOT_AMT, 0) - NVL(HA.INCOME_DED_AMT, 0)) AS INCOME_AMT  -- �ٷμҵ� �ݾ� --
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
           , NVL(HA.NATI_ANNU_AMT, 0) AS NATI_ANNU_AMT          -- ���ο��� --
           , NVL(HA.ANNU_INSUR_AMT, 0) AS ANNU_INSUR_AMT        -- ���ݺ���� �հ� --
           , NVL(HA.MEDIC_INSUR_AMT, 0) AS MEDIC_INSUR_AMT      -- �ǰ�����(�ǰ� + ����纸��)
           , NVL(HA.HIRE_INSUR_AMT, 0) AS HIRE_INSUR_AMT        -- ��뺸��
           , NVL(HA.GUAR_INSUR_AMT, 0) AS GUAR_INSUR_AMT        -- ���庸��
           , NVL(HA.DISABILITY_INSUR_AMT, 0) AS DISABILITY_INSUR_AMT  -- ����κ���
             -- ����� �ݾ��� ������ ��쿡�� 0�� ���(�������� �����ä ��Ŀ� -���� ���� ����);
           , ( CASE
                 WHEN NVL(HA.MEDIC_INSUR_AMT, 0) + NVL(HA.HIRE_INSUR_AMT, 0) +
                      NVL(HA.GUAR_INSUR_AMT, 0) + NVL(HA.DISABILITY_INSUR_AMT, 0) < 0 THEN 0
                 ELSE NVL(HA.MEDIC_INSUR_AMT, 0) + NVL(HA.HIRE_INSUR_AMT, 0) +
                      NVL(HA.GUAR_INSUR_AMT, 0) + NVL(HA.DISABILITY_INSUR_AMT, 0)
               END) AS ETC_INSURE_AMT  -- ��Ÿ����� �հ� --
           , NVL(HA.MEDIC_AMT, 0) AS MEDIC_AMT  -- �Ƿ�� �հ� (����� + ��Ÿ)
           , NVL(HA.EDUCATION_AMT, 0) AS EDUCATION_AMT  -- ������(����� + ��Ÿ)
           , (NVL(HA.HOUSE_INTER_AMT, 0) + NVL(HA.HOUSE_INTER_AMT_ETC, 0)) AS HOUSE_INTER_AMT  -- �����������Ա� ������ + ������
           , NVL(HA.HOUSE_FUND_AMT, 0) AS HOUSE_FUND_AMT
           , NVL(HA.DONAT_DED_ALL, 0) + NVL(HA.DONAT_DED_50, 0) +  
             NVL(HA.DONAT_DED_RELIGION_10, 0) + NVL(HA.DONAT_DED_10, 0) AS DONAT_AMT      -- 2014-Ư���ҵ����(��α��̿���)
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
               END) -- �����ڱ�(�����������Ա� + ������ + ��������������Ա� )
              ) AS SP_DED_SUM  -- Ư������ �հ� --                                                                                                                       
           , NVL(HA.STAND_DED_AMT, 0) AS STAND_DED_AMT  -- ǥ�ذ���   --
           , NVL(HA.SUBT_DED_AMT, 0) AS SUBT_DED_AMT    -- �����ҵ�ݾ� --
           
           , NVL(HA.PERS_ANNU_BANK_AMT, 0) AS PERS_ANNU_BANK_AMT  -- ���ο��� 
           --, NVL(HA.ANNU_BANK_AMT, 0) AS ANNU_BANK_AMT  -- 2014-���װ��� �̵� 
           , NVL(HA.INVES_AMT, 0) AS INVES_AMT            -- �������� 
           , NVL(HA.FORE_INCOME_AMT, 0) AS FORE_INCOME_AMT  -- �ܱ� �ٷ��� �ҵ� --
           , NVL(HA.CREDIT_AMT, 0) AS CREDIT_AMT            -- �ſ�ī�� 
           --, NVL(HA.RETR_ANNU_AMT, 0) AS RETR_ANNU_AMT    -- 2014-���װ��� �̵� 
           , NVL(HA.EMPL_STOCK_AMT, 0) AS EMPL_STOCK_AMT
           , NVL(HA.DONAT_DED_30, 0) AS DONAT_DED_30                                      -- 2014-�׹��Ǽҵ����(�츮�������ձ�α�)
           , NVL(HA.INVEST_AMT_14, 0) AS INVEST_AMT_14                                     -- 2014-�����������ڱݾ�  14��
           , NVL(HA.LONG_SET_INVEST_SAVING_AMT, 0) AS LONG_SET_INVEST_SAVING_AMT           -- 2014-�������������������
            
           , NVL(HA.HIRE_KEEP_EMPLOY_AMT, 0) AS HIRE_KEEP_EMPLOY_AMT  -- ��������߼ұ���ٷ��ڼҵ����
           , ( NVL(HA.PERS_ANNU_BANK_AMT, 0) + NVL(HA.SMALL_CORPOR_DED_AMT, 0) +
               NVL(HA.HOUSE_APP_DEPOSIT_AMT, 0) + NVL(HA.HOUSE_APP_SAVE_AMT, 0) +
               NVL(HA.HOUSE_SAVE_AMT, 0) + NVL(HA.WORKER_HOUSE_SAVE_AMT, 0) +
               NVL(HA.INVES_AMT, 0) + NVL(HA.CREDIT_AMT, 0) + NVL(HA.DONAT_DED_30, 0) + 
               NVL(HA.EMPL_STOCK_AMT, 0) + NVL(HA.LONG_STOCK_SAVING_AMT, 0) +
               NVL(HA.HIRE_KEEP_EMPLOY_AMT, 0) + NVL(HA.FIX_LEASE_DED_AMT, 0) + NVL(HA.LONG_SET_INVEST_SAVING_AMT, 0)
               ) AS TOT_ETC_DED_AMT   -- �׹��� �ҵ���� �հ� �ݾ� --
               
           , NVL(HA.TAX_STD_AMT, 0) AS TAX_STD_AMT            -- ����ǥ�� 
           , NVL(HA.COMP_TAX_AMT, 0) AS COMP_TAX_AMT          -- ���⼼�� 
          
           , NVL(HA.TAX_REDU_IN_LAW_AMT, 0) AS TAX_REDU_IN_LAW_AMT
           , NVL(HA.TAX_REDU_SMALL_BUSINESS, 0) AS TAX_SMALL_REDU_SP_LAW_AMT              -- 2014-���� ( �߼ұ�����û��)           
           , NVL(HA.TAX_REDU_SP_LAW_AMT, 0) + NVL(HA.TAX_REDU_SMALL_BUSINESS, 0) AS TAX_REDU_SP_LAW_AMT
           , (NVL(HA.TAX_REDU_IN_LAW_AMT, 0) + NVL(HA.TAX_REDU_SMALL_BUSINESS, 0) + NVL(HA.TAX_REDU_SP_LAW_AMT, 0))AS TAX_REDU_SUM  -- ���װ��� �հ� 
           
           , NVL(HA.TAX_DED_INCOME_AMT, 0) AS TAX_DED_INCOME_AMT  -- �ٷμҵ���� 
           , NVL(HA.TAX_DED_TAXGROUP_AMT, 0) AS TAX_DED_TAXGROUP_AMT  -- �������� 
           , NVL(HA.TAX_DED_HOUSE_DEBT_AMT, 0) AS TAX_DED_HOUSE_DEBT_AMT  -- �������Ա� 
           , NVL(HA.TAX_DED_LONG_STOCK_AMT, 0) AS TAX_DED_LONG_STOCK_AMT  -- 
           --, NVL(HA.TAX_DED_DONAT_POLI_AMT, 0) AS TAX_DED_DONAT_POLI_AMT  -- ��ġ�ڱ� ��α�(2014 ��� ����)            
           , NVL(HA.TAX_DED_OUTSIDE_PAY_AMT, 0) AS TAX_DED_OUTSIDE_PAY_AMT  -- �ܱ����� 
           , ( NVL(HA.TAX_DED_INCOME_AMT, 0) + NVL(HA.TD_CHILD_RAISE_DED_AMT, 0) + 
               NVL(HA.TD_SCIENTIST_ANNU_DED_AMT, 0) + NVL(HA.TD_WORKER_RETR_ANNU_DED_AMT, 0) + 
               NVL(HA.TD_ANNU_BANK_DED_AMT, 0) + 
               NVL(HA.TD_GUAR_INSUR_DED_AMT, 0) + 
               NVL(HA.TD_MEDIC_DED_AMT, 0) + NVL(HA.TD_EDUCATION_DED_AMT, 0) + 
               NVL(HA.TD_POLI_DONAT_DED_AMT1, 0) + NVL(HA.TD_POLI_DONAT_DED_AMT2, 0) + 
               NVL(HA.TD_LEGAL_DONAT_DED_AMT, 0) + NVL(HA.TD_DESIGN_DONAT_DED_AMT, 0) + 
               NVL(HA.TD_STAND_DED_AMT, 0) + 
               NVL(HA.TAX_DED_TAXGROUP_AMT, 0) + NVL(HA.TAX_DED_HOUSE_DEBT_AMT, 0) + 
               NVL(HA.TAX_DED_OUTSIDE_PAY_AMT, 0) + NVL(HA.TD_HOUSE_MONTHLY_DED_AMT, 0)) AS TAX_DED_SUM  -- ���װ��� �հ� 
           
           , NVL(HA.FIX_TAX_AMT, 0) AS FIX_TAX_AMT  -- ��������
           , NVL(HA.FIX_IN_TAX_AMT, 0) AS FIX_IN_TAX_AMT           -- ������ ����.
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
           , NVL(HA.SUBT_IN_TAX_AMT, 0) AS SUBT_IN_TAX_AMT           -- ���� �ҵ漼
           , NVL(HA.SUBT_LOCAL_TAX_AMT, 0) AS SUBT_LOCAL_TAX_AMT     -- ���� �ֹμ�
           , NVL(HA.SUBT_SP_TAX_AMT, 0) AS SUBT_SP_TAX_AMT           -- ���� ��Ư��
           , ( NVL(HA.SUBT_IN_TAX_AMT, 0) + NVL(HA.SUBT_LOCAL_TAX_AMT, 0) +
               NVL(HA.SUBT_SP_TAX_AMT, 0)) AS SUBT_TAX_SUM
           --, NVL(HA.NONTAX_FOREIGNER_AMT, 0) AS NONTAX_FOREIGNER_AMT
           , NVL(HA.BIRTH_DED_COUNT, 0) AS BIRTH_DED_COUNT
           , NVL(HA.BIRTH_DED_AMT, 0) AS BIRTH_DED_AMT
           , ( NVL(HA.LONG_HOUSE_PROF_AMT, 0) + NVL(HA.LONG_HOUSE_PROF_AMT_1, 0) +
               NVL(HA.LONG_HOUSE_PROF_AMT_2, 0) + NVL(HA.LONG_HOUSE_PROF_AMT_3_FIX, 0) +
               NVL(HA.LONG_HOUSE_PROF_AMT_3_ETC, 0)) AS LONG_HOUSE_PROF_AMT
           , ( NVL(HA.HOUSE_APP_DEPOSIT_AMT, 0) + NVL(HA.HOUSE_APP_SAVE_AMT, 0) +
               NVL(HA.HOUSE_SAVE_AMT, 0) + NVL(HA.WORKER_HOUSE_SAVE_AMT, 0)) AS HOUSE_SAVE_AMT  -- ���ø�������ҵ���� --
           , NVL(HA.SMALL_CORPOR_DED_AMT, 0) AS SMALL_CORPOR_DED_AMT
           , NVL(HA.LONG_STOCK_SAVING_AMT, 0) AS LONG_STOCK_SAVING_AMT
           , NVL(HA.HOUSE_MONTHLY_AMT, 0) AS HOUSE_MONTHLY_AMT  -- ��� ���� 
           , HA.CLOSED_FLAG
           , DECODE(HA.CLOSED_FLAG, 'Y', HA.CLOSED_DATE) AS CLOSED_DATE
           , ( SELECT PM.NAME
                 FROM HRM_PERSON_MASTER PM
                WHERE PM.PERSON_ID    = DECODE(HA.CLOSED_FLAG, 'Y', HA.CLOSED_PERSON_ID, -1)
             ) AS CLOSED_PERSON
           -- 2013�� �߰� --
           , NVL(HA.SINGLE_PARENT_DED_AMT, 0) AS SINGLE_PARENT_DED_AMT
           , NVL(HA.FIX_LEASE_DED_AMT, 0) AS FIX_LEASE_DED_AMT
           , NVL(HA.SP_DED_TOT_AMT, 0) AS SP_DED_TOT_AMT
           
           
           -- 2014�� �߰� -- 
           , 0 AS TD_CHILD_RAISE_DED_CNT                  -- 2014-���� �ڳ���� �ο��� 
           , NVL(HA.TD_CHILD_RAISE_DED_AMT, 0) AS TD_CHILD_RAISE_DED_AMT                  -- 2014-���� �ڳ���� �����ݾ�     
           , 0 AS TD_CHILD_6_UNDER_DED_CNT              -- 2014-���� 6������ �ο��� 
           , 0 AS TD_CHILD_6_UNDER_DED_AMT              -- 2014-���� 6������ �����ݾ�
           , 0 AS TD_BIRTH_DED_CNT                              -- 2014-���� ���/�Ծ� �ο��� 
           , 0 AS TD_BIRTH_DED_AMT                              -- 2014-���� ���/�Ծ� �����ݾ� 
           , NVL(HA.TD_SCIENTIST_ANNU_AMT, 0) AS TD_SCIENTIST_ANNU_AMT                    -- 2014-���� ���б���ΰ��� ���
           , NVL(HA.TD_SCIENTIST_ANNU_DED_AMT, 0) AS TD_SCIENTIST_ANNU_DED_AMT            -- 2014-���� ���б���ΰ��� ����
           , NVL(HA.TD_WORKER_RETR_ANNU_AMT, 0) AS TD_WORKER_RETR_ANNU_AMT                -- 2014-���� �ٷ��� �������� ���
           , NVL(HA.TD_WORKER_RETR_ANNU_DED_AMT, 0) AS TD_WORKER_RETR_ANNU_DED_AMT        -- 2014-���� �ٷ��� �������� ���� 
           , NVL(HA.TD_ANNU_BANK_AMT, 0) AS TD_ANNU_BANK_AMT                              -- 2014-���� �������� ���
           , NVL(HA.TD_ANNU_BANK_DED_AMT, 0) AS TD_ANNU_BANK_DED_AMT                      -- 2014-���� �������� ���� 
           , ( NVL(HA.TD_GUAR_INSUR_AMT, 0)) AS TD_GUAR_INSUR_AMT                   -- 2014-���� ���强���� ���            
           , ( NVL(HA.TD_GUAR_INSUR_DED_AMT, 0)) AS TD_GUAR_INSUR_DED_AMT           -- 2014-���� ���强���� ���װ��� 
           , NVL(HA.TD_MEDIC_AMT, 0) AS TD_MEDIC_AMT                                      -- 2014-���� �Ƿ�� ���ݾ�            
           , NVL(HA.TD_MEDIC_DED_AMT, 0) AS TAX_DED_MEDIC_AMT                             -- 2014-���� �Ƿ�� ���װ���
           , NVL(HA.TD_EDUCATION_AMT, 0) AS TD_EDUCATION_AMT                              -- 2014-���� ������ ���ݾ� 
           , NVL(HA.TD_EDUCATION_DED_AMT, 0) AS TAX_DED_EDUCATION_AMT                     -- 2014-���� ������ ���װ��� 
           , NVL(HA.TD_POLI_DONAT_AMT1, 0) AS TD_POLI_DONAT_AMT1                          -- 2014-���� ��ġ�ڱݱ�α� ���(10���� ����) 
           , NVL(HA.TD_POLI_DONAT_DED_AMT1, 0) AS TD_POLI_DONAT_DED_AMT1                  -- 2014-���� ��ġ�ڱ� ��α� ���װ���(10���� ����) 
           , NVL(HA.TD_POLI_DONAT_AMT2, 0) AS TD_POLI_DONAT_AMT2                          -- 2014-���� ��ġ�ڱݱ�α� ���(10���� �ʰ�) 
           , NVL(HA.TD_POLI_DONAT_DED_AMT2, 0) AS TD_POLI_DONAT_DED_AMT2                  -- 2014-���� ��ġ�ڱݱ�α� ���װ���(10���� �ʰ�) 
           , NVL(HA.TD_LEGAL_DONAT_AMT, 0) AS TD_LEGAL_DONAT_AMT                          -- 2014-���� ������α� ���
           , NVL(HA.TD_LEGAL_DONAT_DED_AMT, 0) AS TD_LEGAL_DONAT_DED_AMT                  -- 2014-���� ������α� ���װ���
           , NVL(HA.TD_DESIGN_DONAT_AMT, 0) AS TD_DESIGN_DONAT_AMT                        -- 2014-���� ������α� ���
           , NVL(HA.TD_DESIGN_DONAT_DED_AMT, 0) AS TD_DESIGN_DONAT_DED_AMT                -- 2014-���� ������α� ���װ���
           , ( NVL(HA.TD_GUAR_INSUR_DED_AMT, 0) + 
               NVL(HA.TD_MEDIC_DED_AMT, 0) + 
               NVL(HA.TD_EDUCATION_DED_AMT, 0) + 
               NVL(HA.TD_POLI_DONAT_DED_AMT1, 0) + 
               NVL(HA.TD_POLI_DONAT_DED_AMT2, 0) +
               NVL(HA.TD_LEGAL_DONAT_DED_AMT, 0) + 
               NVL(HA.TD_DESIGN_DONAT_DED_AMT, 0)) AS TD_SP_DED_TOTAL_AMT                 -- 2014-���� Ư�����װ��� �հ�            
           , NVL(HA.TD_STAND_DED_AMT, 0) AS TD_STAND_DED_AMT                              -- 2014-���� ǥ�ؼ��װ���    
           , NVL(HA.TD_HOUSE_MONTHLY_AMT, 0) AS TD_HOUSE_MONTHLY_AMT                      -- 2014-���� ������ ���� ���
           , NVL(HA.TD_HOUSE_MONTHLY_DED_AMT, 0) AS TD_HOUSE_MONTHLY_DED_AMT              -- 2014-���� ������ �����ݾ�            
        FROM HRA_YEAR_ADJUSTMENT_1505 HA
           , ( -- ���� ���� ����
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
-- �������� ���� �� ��ȸ : ������ ���� 
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
           , SX1.NOW_SUM_PAY  -- ����
           , SX1.PRE_SUM_PAY  -- ����
           , SX1.TOTAL_PAY         -- �ѱ޿�
           , SX1.INCOME_DED_AMT    -- �ٷμҵ����
           , SX1.INCOME_AMT  -- �ٷμҵ�ݾ�
           -- ��������
           , SX1.PER_DED_AMT                      -- ����
           , SX1.SPOUSE_DED_AMT                -- �����
           , SX1.SUPP_DED_COUNT                -- �ξ簡�� �ο���
           , SX1.SUPP_DED_AMT                    -- �ξ簡�� �����ݾ�
           , SX1.OLD_DED_COUNT1                -- ��ο�� �ο���
           , SX1.OLD_DED_AMT1                    -- ��ο�� �����ݾ�
           , SX1.DISABILITY_DED_COUNT    -- ����� �ο���
           , SX1.DISABILITY_DED_AMT        -- ����� �����ݾ�
           , SX1.WOMAN_DED_AMT                  -- �γ��� �����ݾ�
           , SX1.SINGLE_PARENT_DED_AMT  -- �Ѻθ���
           -- ���ݺ���� ����
           , SX1.NATI_ANNU_AMT                  -- ���ο��ݺ���� ����
           , SX1.PUBLIC_INSUR_AMT            -- ����������
           , SX1.MARINE_INSUR_AMT            -- ���ο��ݺ���
           , SX1.SCHOOL_STAFF_INSUR_AMT  -- �縳�б� ����������
           , SX1.POST_OFFICE_INSUR_AMT    -- ������ü������
                             
           -- Ư������
           , SX1.MEDIC_INSUR_AMT              -- �ǰ������
           , SX1.HIRE_INSUR_AMT                -- ��뺸���
                             
           , SX1.HOUSE_INTER_AMT                    -- �����������Աݿ����� ��ȯ�� - ������
           , SX1.HOUSE_INTER_AMT_ETC            -- �����������Աݿ����� ��ȯ�� - ������
                             
           , SX1.LONG_HOUSE_PROF_AMT            -- ��������������Ա����ڻ�ȯ�� 2011�� �������Ժ� 15�� �̸�
           , SX1.LONG_HOUSE_PROF_AMT_1        -- ��������������Ա����ڻ�ȯ�� 2011�� �������Ժ� 15~29��
           , SX1.LONG_HOUSE_PROF_AMT_2        -- ��������������Ա����ڻ�ȯ�� 2011�� �������Ժ� 30�� �̻�
           , SX1.LONG_HOUSE_PROF_AMT_3_FIX  -- ��������������Ա����ڻ�ȯ�� 2012�� ���� ���Ժ� 15�� �̻� �����ݾ� ��
           , SX1.LONG_HOUSE_PROF_AMT_3_ETC  -- ��������������Ա����ڻ�ȯ�� 2012�� ���� ���Ժ� 15�� �̻� ��Ÿ�����
           , SX1.FORWARD_DONATION_AMT            -- ��α�(�̿���)
                             
           , SX1.SP_DED_SUM_AMT                       -- Ư���ҵ���� �� 

           -- �����ҵ�ݾ�
           , SX1.SUBT_DED_AMT
           -- �׹��� �ҵ����
           , SX1.PERS_ANNU_BANK_AMT        -- ���ο�������ҵ����
           , SX1.SMALL_CORPOR_DED_AMT    -- �ұ��/�һ���� �����α� �ҵ����
           , SX1.HOUSE_APP_DEPOSIT_AMT  -- ����û������
           , SX1.HOUSE_APP_SAVE_AMT        -- ����û����������
           , SX1.WORKER_HOUSE_SAVE_AMT  -- �ٷ������ø�������
           , SX1.INVES_AMT                          -- �����������ڵ� �ҵ����
                             
           , SX1.CREDIT_AMT                        -- �ſ�ī��� �ҵ����
           , SX1.EMPL_STOCK_AMT                -- �츮�������ռҵ����
           , SX1.DONAT_DED_30                    -- �츮�������ձ�α�
           , SX1.HIRE_KEEP_EMPLOY_AMT    -- ��������߼ұ���ٷ���
           , SX1.FIX_LEASE_DED_AMT          -- �񵷾ȵ�� �������ڻ�ȯ��
           , SX1.LONG_SET_INVEST_SAVING_AMT -- �������������������
                             
           , SX1.ETC_DED_SUM_AMT   -- �׹��� �ҵ���� �հ� �ݾ� --
           -- Ư������ �����ѵ� �ʰ���
           , SX1.SP_DED_TOT_AMT                -- Ư������ �����ѵ� �ʰ���
           -- ���ռҵ� ����ǥ��
           , SX1.TAX_STD_AMT                      -- ���ռҵ� ����ǥ��
           -- ���⼼��
           , SX1.COMP_TAX_AMT                    -- ���⼼��
           -- ���װ���
           , SX1.TAX_REDU_IN_LAW_AMT      -- �ҵ漼��
           , SX1.TAX_REDU_SP_LAW_AMT      -- ����Ư�� ���ѹ�
           , SX1.TAX_REDU_SP_LAW_AMT_1                   -- ����Ư�� ���ѹ� ��30��
           , SX1.TAX_REDU_TAX_TREATY      -- ��������
           , SX1.TAX_REDU_SUM_AMT      -- ���װ��� �հ�
           -- ���װ���
           , SX1.TAX_DED_INCOME_AMT        -- ����-�ٷμҵ�
           , SX1.TD_CHILD_RAISE_DED_CNT  -- ����-�ڳ���� �ο��� 
           , SX1.TD_CHILD_RAISE_DED_AMT  -- ����-�ڳ���� �ݾ� 
           , SX1.TD_CHILD_6_UNDER_DED_CNT  -- ����-�ڳ� 6������ �ο��� 
           , SX1.TD_CHILD_6_UNDER_DED_AMT  -- ����-�ڳ�6������ �ݾ� 
           , SX1.TD_BIRTH_DED_CNT                  -- ����-�ڳ� ���/�Ծ� �ο��� 
           , SX1.TD_BIRTH_DED_AMT                  -- ����-�ڳ� ���/�Ծ� �ݾ� 
                             
           , SX1.TD_SCIENTIST_ANNU_AMT                            -- 2014-���б���� �����ݾ�
           , SX1.TD_SCIENTIST_ANNU_DED_AMT                    -- 2014-���б���� ���װ���
           , SX1.TD_WORKER_RETR_ANNU_AMT                        -- 2014-��������  �����ݾ�
           , SX1.TD_WORKER_RETR_ANNU_DED_AMT                -- 2014-�������� ���װ���
           , SX1.TD_ANNU_BANK_AMT                                      -- 2014-�������� �����ݾ�
           , SX1.TD_ANNU_BANK_DED_AMT                              -- 2014-�������� ���װ���
                              
           , SX1.TD_GUAR_INSUR_AMT                           -- 2014-���� ( ���强���� �����ݾ�)
           , SX1.TD_GUAR_INSUR_DED_AMT                   -- 2014-���� ( ���强���� ���װ���)
                              
           , SX1.TD_MEDIC_AMT                                              -- 2014-���� (�Ƿ�� �����ݾ�)
           , SX1.TD_MEDIC_DED_AMT                                      -- 2014-���� (�Ƿ�� ���װ���)
                              
           , SX1.TD_EDUCATION_AMT                                      -- 2014-���� (������ �����ݾ�)
           , SX1.TD_EDUCATION_DED_AMT                              -- 2014-���� (������ ���װ���) 
                              
           , SX1.TD_POLI_DONAT_AMT1                                       -- 2014-���� (��ġ�ڱݱ�α�-10��������) �����ݾ�
           , SX1.TD_POLI_DONAT_DED_AMT1                                 -- 2014-���� (��ġ�ڱݱ�α�-10��������) ���װ���
           , SX1.TD_POLI_DONAT_AMT2                                       -- 2014-���� (��ġ�ڱݱ�α�-10�����ʰ�) �����ݾ�
           , SX1.TD_POLI_DONAT_DED_AMT2                                 -- 2014-���� (��ġ�ڱݱ�α�-10��������) ���װ���
           , SX1.TD_LEGAL_DONAT_AMT                                       -- 2014-���� (������α�) �����ݾ�
           , SX1.TD_LEGAL_DONAT_DED_AMT                                 -- 2014-���� (������α�) ���װ���
           , SX1.TD_DESIGN_DONAT_AMT                                    -- 2014-���� (������α�) �����ݾ�
           , SX1.TD_DESIGN_DONAT_DED_AMT                               -- 2014-���� (������α�) ���װ���
                             
           , SX1.SP_TAX_DED_SUM_AMT      -- Ư�� ����  ���� 
                             
           , SX1.STAND_DED_AMT                                 -- ǥ�ؼ��װ��� 
                             
           , SX1.TAX_DED_TAXGROUP_AMT    -- ���� - ��������
           , SX1.TAX_DED_HOUSE_DEBT_AMT  -- ���� - �������Ա�
           , SX1.TAX_DED_OUTSIDE_PAY_AMT  -- ���� - �ܱ�����
           , SX1.TD_HOUSE_MONTHLY_AMT        -- ���� �������� ��� 
           , SX1.TD_HOUSE_MONTHLY_DED_AMT   -- ���� �������� ���� 
                             
           , SX1.TAX_DED_SUM_AMT      -- ���װ��� �հ�
           , SX1.FIX_TAX_AMT                       -- ��������
           -- ��������
           , SX1.FIX_IN_TAX_AMT        -- ���� �ҵ漼
           , SX1.FIX_LOCAL_TAX_AMT   -- ���� �ֹμ�
           , SX1.FIX_SP_TAX_AMT         -- ���� ��Ư��
           , SX1.FIX_TAX_SUM_AMT     -- ���� ���� �հ�
           -- (����) �ⳳ�� ����
           , SX1.PRE_IN_TAX_AMT           -- (����) �ҵ漼 �հ�
           , SX1.PRE_LOCAL_TAX_AMT     -- (����) �ֹμ� �հ�
           , SX1.PRE_SP_TAX_AMT           -- (����) ��Ư�� �հ�
           , SX1.PRE_TAX_SUM_AMT       -- (����) ���� �հ�
           -- (����) �ⳳ�� ����
           , SX1.NOW_IN_TAX_AMT        -- (����) �ҵ漼
           , SX1.NOW_LOCAL_TAX_AMT  -- (����) �ֹμ�
           , SX1.NOW_SP_TAX_AMT        -- (����) ��Ư��
           , SX1.NOW_TAX_SUM_AMT  -- (����) ���� �հ�
           -- ���� ����
           , SX1.SUBT_IN_TAX_AMT       -- (����) �ҵ漼
           , SX1.SUBT_LOCAL_TAX_AMT -- (����) �ֹμ�
           , SX1.SUBT_SP_TAX_AMT       -- (����) ��Ư��
           , SX1.SUBT_TAX_SUM_AMT   -- (����) ���� �հ�          
           -- ����� �հ�
           , SX1.NONTAX_TOT_AMT  -- ����� �հ�
           -- ����� ��
           , SX1.NONTAX_OUTSIDE_AMT -- ����� ���ܱٷ� �հ�
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
                   , T1.NOW_SUM_PAY  -- ����
                   , T1.PRE_SUM_PAY  -- ����
                   , T1.TOTAL_PAY         -- �ѱ޿�
                   , T1.INCOME_DED_AMT    -- �ٷμҵ����
                   , T1.INCOME_AMT  -- �ٷμҵ�ݾ�
                   -- ��������
                   , T1.PER_DED_AMT                      -- ����
                   , T1.SPOUSE_DED_AMT                -- �����
                   , T1.SUPP_DED_COUNT                -- �ξ簡�� �ο���
                   , T1.SUPP_DED_AMT                    -- �ξ簡�� �����ݾ�
                   , T1.OLD_DED_COUNT1                -- ��ο�� �ο���
                   , T1.OLD_DED_AMT1                    -- ��ο�� �����ݾ�
                   , T1.DISABILITY_DED_COUNT    -- ����� �ο���
                   , T1.DISABILITY_DED_AMT        -- ����� �����ݾ�
                   , T1.WOMAN_DED_AMT                  -- �γ��� �����ݾ�
                   , T1.SINGLE_PARENT_DED_AMT  -- �Ѻθ���
                   -- ���ݺ���� ����
                   , T1.NATI_ANNU_AMT                  -- ���ο��ݺ���� ����
                   , T1.PUBLIC_INSUR_AMT            -- ����������
                   , T1.MARINE_INSUR_AMT            -- ���ο��ݺ���
                   , T1.SCHOOL_STAFF_INSUR_AMT  -- �縳�б� ����������
                   , T1.POST_OFFICE_INSUR_AMT    -- ������ü������
                             
                   -- Ư������
                   , T1.MEDIC_INSUR_AMT              -- �ǰ������
                   , T1.HIRE_INSUR_AMT                -- ��뺸���
                             
                   , T1.HOUSE_INTER_AMT                    -- �����������Աݿ����� ��ȯ�� - ������
                   , T1.HOUSE_INTER_AMT_ETC            -- �����������Աݿ����� ��ȯ�� - ������
                             
                   , T1.LONG_HOUSE_PROF_AMT            -- ��������������Ա����ڻ�ȯ�� 2011�� �������Ժ� 15�� �̸�
                   , T1.LONG_HOUSE_PROF_AMT_1        -- ��������������Ա����ڻ�ȯ�� 2011�� �������Ժ� 15~29��
                   , T1.LONG_HOUSE_PROF_AMT_2        -- ��������������Ա����ڻ�ȯ�� 2011�� �������Ժ� 30�� �̻�
                   , T1.LONG_HOUSE_PROF_AMT_3_FIX  -- ��������������Ա����ڻ�ȯ�� 2012�� ���� ���Ժ� 15�� �̻� �����ݾ� ��
                   , T1.LONG_HOUSE_PROF_AMT_3_ETC  -- ��������������Ա����ڻ�ȯ�� 2012�� ���� ���Ժ� 15�� �̻� ��Ÿ�����
                   , T1.FORWARD_DONATION_AMT            -- ��α�(�̿���)
                             
                   , T1.SP_DED_SUM_AMT                       -- Ư���ҵ���� �� 

                   -- �����ҵ�ݾ�
                   , T1.SUBT_DED_AMT
                   -- �׹��� �ҵ����
                   , T1.PERS_ANNU_BANK_AMT        -- ���ο�������ҵ����
                   , T1.SMALL_CORPOR_DED_AMT    -- �ұ��/�һ���� �����α� �ҵ����
                   , T1.HOUSE_APP_DEPOSIT_AMT  -- ����û������
                   , T1.HOUSE_APP_SAVE_AMT        -- ����û����������
                   , T1.WORKER_HOUSE_SAVE_AMT  -- �ٷ������ø�������
                   , T1.INVES_AMT                          -- �����������ڵ� �ҵ����
                             
                   , T1.CREDIT_AMT                        -- �ſ�ī��� �ҵ����
                   , T1.EMPL_STOCK_AMT                -- �츮�������ռҵ����
                   , T1.DONAT_DED_30                    -- �츮�������ձ�α�
                   , T1.HIRE_KEEP_EMPLOY_AMT    -- ��������߼ұ���ٷ���
                   , T1.FIX_LEASE_DED_AMT          -- �񵷾ȵ�� �������ڻ�ȯ��
                   , T1.LONG_SET_INVEST_SAVING_AMT -- �������������������
                             
                   , T1.ETC_DED_SUM_AMT   -- �׹��� �ҵ���� �հ� �ݾ� --
                   -- Ư������ �����ѵ� �ʰ���
                   , T1.SP_DED_TOT_AMT                -- Ư������ �����ѵ� �ʰ���
                   -- ���ռҵ� ����ǥ��
                   , T1.TAX_STD_AMT                      -- ���ռҵ� ����ǥ��
                   -- ���⼼��
                   , T1.COMP_TAX_AMT                    -- ���⼼��
                   -- ���װ���
                   , T1.TAX_REDU_IN_LAW_AMT      -- �ҵ漼��
                   , T1.TAX_REDU_SP_LAW_AMT      -- ����Ư�� ���ѹ�
                   , T1.TAX_REDU_SP_LAW_AMT_1                   -- ����Ư�� ���ѹ� ��30��
                   , T1.TAX_REDU_TAX_TREATY      -- ��������
                   , T1.TAX_REDU_SUM_AMT      -- ���װ��� �հ�
                   -- ���װ���
                   , T1.TAX_DED_INCOME_AMT        -- ����-�ٷμҵ�
                   , T1.TD_CHILD_RAISE_DED_CNT  -- ����-�ڳ���� �ο��� 
                   , T1.TD_CHILD_RAISE_DED_AMT  -- ����-�ڳ���� �ݾ� 
                   , T1.TD_CHILD_6_UNDER_DED_CNT  -- ����-�ڳ� 6������ �ο��� 
                   , T1.TD_CHILD_6_UNDER_DED_AMT  -- ����-�ڳ�6������ �ݾ� 
                   , T1.TD_BIRTH_DED_CNT                  -- ����-�ڳ� ���/�Ծ� �ο��� 
                   , T1.TD_BIRTH_DED_AMT                  -- ����-�ڳ� ���/�Ծ� �ݾ� 
                             
                   , T1.TD_SCIENTIST_ANNU_AMT                            -- 2014-���б���� �����ݾ�
                   , T1.TD_SCIENTIST_ANNU_DED_AMT                    -- 2014-���б���� ���װ���
                   , T1.TD_WORKER_RETR_ANNU_AMT                        -- 2014-��������  �����ݾ�
                   , T1.TD_WORKER_RETR_ANNU_DED_AMT                -- 2014-�������� ���װ���
                   , T1.TD_ANNU_BANK_AMT                                      -- 2014-�������� �����ݾ�
                   , T1.TD_ANNU_BANK_DED_AMT                              -- 2014-�������� ���װ���
                              
                   , T1.TD_GUAR_INSUR_AMT                           -- 2014-���� ( ���强���� �����ݾ�)
                   , T1.TD_GUAR_INSUR_DED_AMT                   -- 2014-���� ( ���强���� ���װ���)
                              
                   , T1.TD_MEDIC_AMT                                              -- 2014-���� (�Ƿ�� �����ݾ�)
                   , T1.TD_MEDIC_DED_AMT                                      -- 2014-���� (�Ƿ�� ���װ���)
                              
                   , T1.TD_EDUCATION_AMT                                      -- 2014-���� (������ �����ݾ�)
                   , T1.TD_EDUCATION_DED_AMT                              -- 2014-���� (������ ���װ���) 
                              
                   , T1.TD_POLI_DONAT_AMT1                                       -- 2014-���� (��ġ�ڱݱ�α�-10��������) �����ݾ�
                   , T1.TD_POLI_DONAT_DED_AMT1                                 -- 2014-���� (��ġ�ڱݱ�α�-10��������) ���װ���
                   , T1.TD_POLI_DONAT_AMT2                                       -- 2014-���� (��ġ�ڱݱ�α�-10�����ʰ�) �����ݾ�
                   , T1.TD_POLI_DONAT_DED_AMT2                                 -- 2014-���� (��ġ�ڱݱ�α�-10��������) ���װ���
                   , T1.TD_LEGAL_DONAT_AMT                                       -- 2014-���� (������α�) �����ݾ�
                   , T1.TD_LEGAL_DONAT_DED_AMT                                 -- 2014-���� (������α�) ���װ���
                   , T1.TD_DESIGN_DONAT_AMT                                    -- 2014-���� (������α�) �����ݾ�
                   , T1.TD_DESIGN_DONAT_DED_AMT                               -- 2014-���� (������α�) ���װ���
                             
                   , T1.SP_TAX_DED_SUM_AMT      -- Ư�� ����  ���� 
                             
                   , T1.STAND_DED_AMT                                 -- ǥ�ؼ��װ��� 
                             
                   , T1.TAX_DED_TAXGROUP_AMT    -- ���� - ��������
                   , T1.TAX_DED_HOUSE_DEBT_AMT  -- ���� - �������Ա�
                   , T1.TAX_DED_OUTSIDE_PAY_AMT  -- ���� - �ܱ�����
                   , T1.TD_HOUSE_MONTHLY_AMT        -- ���� �������� ��� 
                   , T1.TD_HOUSE_MONTHLY_DED_AMT   -- ���� �������� ���� 
                             
                   , T1.TAX_DED_SUM_AMT      -- ���װ��� �հ�
                   , T1.FIX_TAX_AMT                       -- ��������
                   -- ��������
                   , T1.FIX_IN_TAX_AMT        -- ���� �ҵ漼
                   , T1.FIX_LOCAL_TAX_AMT   -- ���� �ֹμ�
                   , T1.FIX_SP_TAX_AMT         -- ���� ��Ư��
                   , T1.FIX_TAX_SUM_AMT     -- ���� ���� �հ�
                   -- (����) �ⳳ�� ����
                   , T1.PRE_IN_TAX_AMT           -- (����) �ҵ漼 �հ�
                   , T1.PRE_LOCAL_TAX_AMT     -- (����) �ֹμ� �հ�
                   , T1.PRE_SP_TAX_AMT           -- (����) ��Ư�� �հ�
                   , T1.PRE_TAX_SUM_AMT       -- (����) ���� �հ�
                   -- (����) �ⳳ�� ����
                   , T1.NOW_IN_TAX_AMT        -- (����) �ҵ漼
                   , T1.NOW_LOCAL_TAX_AMT  -- (����) �ֹμ�
                   , T1.NOW_SP_TAX_AMT        -- (����) ��Ư��
                   , T1.NOW_TAX_SUM_AMT  -- (����) ���� �հ�
                   -- ���� ����
                   , T1.SUBT_IN_TAX_AMT       -- (����) �ҵ漼
                   , T1.SUBT_LOCAL_TAX_AMT -- (����) �ֹμ�
                   , T1.SUBT_SP_TAX_AMT       -- (����) ��Ư��
                   , T1.SUBT_TAX_SUM_AMT   -- (����) ���� �հ�          
                   -- ����� �հ�
                   , T1.NONTAX_TOT_AMT  -- ����� �հ�
                   -- ����� ��
                   , T1.NONTAX_OUTSIDE_AMT -- ����� ���ܱٷ� �հ�
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
                           , '��ó������' AS ADJUSTMENT_TYPE              
                           , ( NVL(HA.NOW_PAY_TOT_AMT, 0) + NVL(HA.NOW_BONUS_TOT_AMT, 0) +
                               NVL(HA.NOW_ADD_BONUS_AMT, 0) + NVL(HA.NOW_STOCK_BENE_AMT, 0) +
                               NVL(HA.INCOME_OUTSIDE_AMT, 0) +
                               NVL(HA.NOW_EMPLOYEE_STOCK_AMT, 0) + NVL(HA.NOW_OFFICE_RETIRE_OVER_AMT, 0)) AS NOW_SUM_PAY  -- ����
                           , ( NVL(HA.PRE_PAY_TOT_AMT, 0) + NVL(HA.PRE_BONUS_TOT_AMT, 0) +
                               NVL(HA.PRE_ADD_BONUS_AMT, 0) + NVL(HA.PRE_STOCK_BENE_AMT, 0) +
                               NVL(HA.PRE_EMPLOYEE_STOCK_AMT, 0) + NVL(HA.PRE_OFFICE_RETIRE_OVER_AMT, 0)) AS PRE_SUM_PAY  -- ����
                           , NVL(HA.INCOME_TOT_AMT, 0) AS TOTAL_PAY         -- �ѱ޿�
                           , NVL(HA.INCOME_DED_AMT, 0) AS INCOME_DED_AMT    -- �ٷμҵ����
                           , ( NVL(HA.INCOME_TOT_AMT, 0) - NVL(HA.INCOME_DED_AMT, 0)) AS INCOME_AMT  -- �ٷμҵ�ݾ�
                           -- ��������
                           , NVL(HA.PER_DED_AMT, 0) AS PER_DED_AMT                      -- ����
                           , NVL(HA.SPOUSE_DED_AMT, 0) AS SPOUSE_DED_AMT                -- �����
                           , NVL(HA.SUPP_DED_COUNT, 0) AS SUPP_DED_COUNT                -- �ξ簡�� �ο���
                           , NVL(HA.SUPP_DED_AMT, 0) AS SUPP_DED_AMT                    -- �ξ簡�� �����ݾ�
                           , NVL(HA.OLD_DED_COUNT1, 0) AS OLD_DED_COUNT1                -- ��ο�� �ο���
                           , NVL(HA.OLD_DED_AMT1, 0) AS OLD_DED_AMT1                    -- ��ο�� �����ݾ�
                           , NVL(HA.DISABILITY_DED_COUNT, 0) AS DISABILITY_DED_COUNT    -- ����� �ο���
                           , NVL(HA.DISABILITY_DED_AMT, 0) AS DISABILITY_DED_AMT        -- ����� �����ݾ�
                           , NVL(HA.WOMAN_DED_AMT, 0) AS WOMAN_DED_AMT                  -- �γ��� �����ݾ�
                           , NVL(HA.SINGLE_PARENT_DED_AMT, 0) AS SINGLE_PARENT_DED_AMT  -- �Ѻθ���
                           -- ���ݺ���� ����
                           , NVL(HA.NATI_ANNU_AMT, 0) AS NATI_ANNU_AMT                  -- ���ο��ݺ���� ����
                           , NVL(HA.PUBLIC_INSUR_AMT, 0) AS PUBLIC_INSUR_AMT            -- ����������
                           , NVL(HA.MARINE_INSUR_AMT, 0) AS MARINE_INSUR_AMT            -- ���ο��ݺ���
                           , NVL(HA.SCHOOL_STAFF_INSUR_AMT, 0) AS SCHOOL_STAFF_INSUR_AMT  -- �縳�б� ����������
                           , NVL(HA.POST_OFFICE_INSUR_AMT, 0) AS POST_OFFICE_INSUR_AMT    -- ������ü������
                             
                           -- Ư������
                           , NVL(HA.MEDIC_INSUR_AMT, 0) AS MEDIC_INSUR_AMT              -- �ǰ������
                           , NVL(HA.HIRE_INSUR_AMT, 0) AS HIRE_INSUR_AMT                -- ��뺸���
                             
                           , NVL(HA.HOUSE_INTER_AMT, 0) AS HOUSE_INTER_AMT                    -- �����������Աݿ����� ��ȯ�� - ������
                           , NVL(HA.HOUSE_INTER_AMT_ETC, 0) AS HOUSE_INTER_AMT_ETC            -- �����������Աݿ����� ��ȯ�� - ������
                             
                           , NVL(HA.LONG_HOUSE_PROF_AMT, 0) AS LONG_HOUSE_PROF_AMT            -- ��������������Ա����ڻ�ȯ�� 2011�� �������Ժ� 15�� �̸�
                           , NVL(HA.LONG_HOUSE_PROF_AMT_1, 0) AS LONG_HOUSE_PROF_AMT_1        -- ��������������Ա����ڻ�ȯ�� 2011�� �������Ժ� 15~29��
                           , NVL(HA.LONG_HOUSE_PROF_AMT_2, 0) AS LONG_HOUSE_PROF_AMT_2        -- ��������������Ա����ڻ�ȯ�� 2011�� �������Ժ� 30�� �̻�
                           , NVL(HA.LONG_HOUSE_PROF_AMT_3_FIX, 0) AS LONG_HOUSE_PROF_AMT_3_FIX  -- ��������������Ա����ڻ�ȯ�� 2012�� ���� ���Ժ� 15�� �̻� �����ݾ� ��
                           , NVL(HA.LONG_HOUSE_PROF_AMT_3_ETC, 0) AS LONG_HOUSE_PROF_AMT_3_ETC  -- ��������������Ա����ڻ�ȯ�� 2012�� ���� ���Ժ� 15�� �̻� ��Ÿ�����
                           /*, ( NVL(HA.LONG_HOUSE_PROF_AMT, 0) +
                               NVL(HA.LONG_HOUSE_PROF_AMT_1, 0) + NVL(HA.LONG_HOUSE_PROF_AMT_2, 0) +
                               NVL(HA.LONG_HOUSE_PROF_AMT_3_FIX, 0) + NVL(HA.LONG_HOUSE_PROF_AMT_3_ETC, 0)) AS LONG_HOUSE_PROF_SUM_AMT  -- ����������� �հ�*/
                           , NVL(HA.DONAT_NEXT_ALL, 0) + NVL(HA.DONAT_NEXT_50, 0) + NVL(HA.DONAT_NEXT_30, 0) + NVL(HA.DONAT_NEXT_RELIGION_10, 0) + NVL(HA.DONAT_NEXT_10, 0) AS FORWARD_DONATION_AMT            -- ��α�(�̿���)
                             
                          --, NVL(HA.HOUSE_FUND_AMT, 0) AS HOUSE_FUND_AMT                -- �����ڱ� �հ�
                             
                           , ((CASE
                                 WHEN NVL(HA.MEDIC_INSUR_AMT, 0) + NVL(HA.HIRE_INSUR_AMT, 0)  < 0 THEN 0
                                 ELSE NVL(HA.MEDIC_INSUR_AMT, 0) + NVL(HA.HIRE_INSUR_AMT, 0) 
                               END) +
                               NVL(HA.HOUSE_INTER_AMT, 0) +            -- �����������Աݿ����� ��ȯ�� - ������
                               NVL(HA.HOUSE_INTER_AMT_ETC, 0) +        -- �����������Աݿ����� ��ȯ�� - ������            
                               NVL(HA.LONG_HOUSE_PROF_AMT, 0) +        -- ��������������Ա����ڻ�ȯ�� 2011�� �������Ժ� 15�� �̸�
                               NVL(HA.LONG_HOUSE_PROF_AMT_1, 0) +      -- ��������������Ա����ڻ�ȯ�� 2011�� �������Ժ� 15~29��
                               NVL(HA.LONG_HOUSE_PROF_AMT_2, 0) +      -- ��������������Ա����ڻ�ȯ�� 2011�� �������Ժ� 30�� �̻�
                               NVL(HA.LONG_HOUSE_PROF_AMT_3_FIX, 0) +  -- ��������������Ա����ڻ�ȯ�� 2012�� ���� ���Ժ� 15�� �̻� �����ݾ� ��
                               NVL(HA.LONG_HOUSE_PROF_AMT_3_ETC, 0) +  -- ��������������Ա����ڻ�ȯ�� 2012�� ���� ���Ժ� 15�� �̻� ��Ÿ�����
                               NVL(HA.DONAT_NEXT_ALL, 0) + NVL(HA.DONAT_NEXT_50, 0) + NVL(HA.DONAT_NEXT_30, 0) + NVL(HA.DONAT_NEXT_RELIGION_10, 0) + NVL(HA.DONAT_NEXT_10, 0)-- ��α�(�̿���)
                               ) AS SP_DED_SUM_AMT                       -- Ư���ҵ���� �� 
                                         

                           -- �����ҵ�ݾ�
                           , NVL(HA.SUBT_DED_AMT, 0) AS SUBT_DED_AMT
                           -- �׹��� �ҵ����
                           , NVL(HA.PERS_ANNU_BANK_AMT, 0) AS PERS_ANNU_BANK_AMT        -- ���ο�������ҵ����
                           , NVL(HA.SMALL_CORPOR_DED_AMT, 0) AS SMALL_CORPOR_DED_AMT    -- �ұ��/�һ���� �����α� �ҵ����
                           , NVL(HA.HOUSE_APP_DEPOSIT_AMT, 0) AS HOUSE_APP_DEPOSIT_AMT  -- ����û������
                           , NVL(HA.HOUSE_APP_SAVE_AMT, 0) AS HOUSE_APP_SAVE_AMT        -- ����û����������
                           , NVL(HA.WORKER_HOUSE_SAVE_AMT, 0) AS WORKER_HOUSE_SAVE_AMT  -- �ٷ������ø�������
                           , NVL(HA.INVES_AMT, 0) AS INVES_AMT                          -- �����������ڵ� �ҵ����
                           /*, ( NVL(HA.HOUSE_APP_DEPOSIT_AMT, 0) + NVL(HA.HOUSE_APP_SAVE_AMT, 0) +
                               NVL(HA.HOUSE_SAVE_AMT, 0) + NVL(HA.WORKER_HOUSE_SAVE_AMT, 0)) AS HOUSE_SAVE_SUM_AMT  -- ���ø��� ����ҵ���� �հ�*/
                             
                           , NVL(HA.CREDIT_AMT, 0) AS CREDIT_AMT                        -- �ſ�ī��� �ҵ����
                           , NVL(HA.EMPL_STOCK_AMT, 0) AS EMPL_STOCK_AMT                -- �츮�������ռҵ����
                           , NVL(HA.DONAT_DED_30, 0) AS DONAT_DED_30                    -- �츮�������ձ�α�
                           , NVL(HA.HIRE_KEEP_EMPLOY_AMT, 0) AS HIRE_KEEP_EMPLOY_AMT    -- ��������߼ұ���ٷ���
                           , NVL(HA.FIX_LEASE_DED_AMT, 0) AS FIX_LEASE_DED_AMT          -- �񵷾ȵ�� �������ڻ�ȯ��
                           , NVL(HA.LONG_SET_INVEST_SAVING_AMT, 0) AS LONG_SET_INVEST_SAVING_AMT -- �������������������
                             
                           , ( NVL(HA.PERS_ANNU_BANK_AMT, 0) + NVL(HA.SMALL_CORPOR_DED_AMT, 0) +
                               NVL(HA.HOUSE_APP_DEPOSIT_AMT, 0) + NVL(HA.HOUSE_APP_SAVE_AMT, 0) +
                               NVL(HA.WORKER_HOUSE_SAVE_AMT, 0) + NVL(HA.INVES_AMT, 0) +
                               NVL(HA.CREDIT_AMT, 0) + NVL(HA.EMPL_STOCK_AMT, 0) +
                               NVL(HA.DONAT_DED_30, 0) + NVL(HA.HIRE_KEEP_EMPLOY_AMT, 0) +
                               NVL(HA.FIX_LEASE_DED_AMT, 0) + NVL(HA.LONG_SET_INVEST_SAVING_AMT, 0)) AS ETC_DED_SUM_AMT   -- �׹��� �ҵ���� �հ� �ݾ� --
                           -- Ư������ �����ѵ� �ʰ���
                           , NVL(HA.SP_DED_TOT_AMT, 0) AS SP_DED_TOT_AMT                -- Ư������ �����ѵ� �ʰ���
                           -- ���ռҵ� ����ǥ��
                           , NVL(HA.TAX_STD_AMT, 0) AS TAX_STD_AMT                      -- ���ռҵ� ����ǥ��
                           -- ���⼼��
                           , NVL(HA.COMP_TAX_AMT, 0) AS COMP_TAX_AMT                    -- ���⼼��
                           -- ���װ���
                           , NVL(HA.TAX_REDU_IN_LAW_AMT, 0) AS TAX_REDU_IN_LAW_AMT      -- �ҵ漼��
                           , NVL(HA.TAX_REDU_SP_LAW_AMT, 0) AS TAX_REDU_SP_LAW_AMT      -- ����Ư�� ���ѹ�
                           , NVL(HA.TAX_REDU_SMALL_BUSINESS, 0) AS TAX_REDU_SP_LAW_AMT_1                   -- ����Ư�� ���ѹ� ��30��
                           , NVL(HA.TAX_REDU_TAX_TREATY, 0) AS TAX_REDU_TAX_TREATY      -- ��������
                           , ( NVL(HA.TAX_REDU_IN_LAW_AMT, 0) + NVL(HA.TAX_REDU_SP_LAW_AMT, 0) +
                               NVL(HA.TAX_REDU_TAX_TREATY, 0) + NVL(HA.TAX_REDU_SMALL_BUSINESS, 0)) AS TAX_REDU_SUM_AMT      -- ���װ��� �հ�
                           -- ���װ���
                           , NVL(HA.TAX_DED_INCOME_AMT, 0) AS TAX_DED_INCOME_AMT        -- ����-�ٷμҵ�
                           , 0 AS TD_CHILD_RAISE_DED_CNT  -- ����-�ڳ���� �ο��� 
                           , NVL(HA.TD_CHILD_RAISE_DED_AMT, 0) AS TD_CHILD_RAISE_DED_AMT  -- ����-�ڳ���� �ݾ� 
                           , 0 AS TD_CHILD_6_UNDER_DED_CNT  -- ����-�ڳ� 6������ �ο��� 
                           , 0 AS TD_CHILD_6_UNDER_DED_AMT  -- ����-�ڳ�6������ �ݾ� 
                           , 0 AS TD_BIRTH_DED_CNT                  -- ����-�ڳ� ���/�Ծ� �ο��� 
                           , 0 AS TD_BIRTH_DED_AMT                  -- ����-�ڳ� ���/�Ծ� �ݾ� 
                             
                           , NVL(HA.TD_SCIENTIST_ANNU_AMT, 0) AS TD_SCIENTIST_ANNU_AMT                            -- 2014-���б���� �����ݾ�
                           , NVL(HA.TD_SCIENTIST_ANNU_DED_AMT, 0) AS TD_SCIENTIST_ANNU_DED_AMT                    -- 2014-���б���� ���װ���
                           , NVL(HA.TD_WORKER_RETR_ANNU_AMT, 0) AS TD_WORKER_RETR_ANNU_AMT                        -- 2014-��������  �����ݾ�
                           , NVL(HA.TD_WORKER_RETR_ANNU_DED_AMT, 0) AS TD_WORKER_RETR_ANNU_DED_AMT                -- 2014-�������� ���װ���
                           , NVL(HA.TD_ANNU_BANK_AMT, 0) AS TD_ANNU_BANK_AMT                                      -- 2014-�������� �����ݾ�
                           , NVL(HA.TD_ANNU_BANK_DED_AMT, 0) AS TD_ANNU_BANK_DED_AMT                              -- 2014-�������� ���װ���
                              
                           , ( NVL(HA.TD_GUAR_INSUR_AMT, 0)) AS TD_GUAR_INSUR_AMT                           -- 2014-���� ( ���强���� �����ݾ�)
                           , ( NVL(HA.TD_GUAR_INSUR_DED_AMT, 0)) AS TD_GUAR_INSUR_DED_AMT                   -- 2014-���� ( ���强���� ���װ���)
                              
                           , NVL(HA.TD_MEDIC_AMT, 0) AS TD_MEDIC_AMT                                              -- 2014-���� (�Ƿ�� �����ݾ�)
                           , NVL(HA.TD_MEDIC_DED_AMT, 0) AS TD_MEDIC_DED_AMT                                      -- 2014-���� (�Ƿ�� ���װ���)
                              
                           , NVL(HA.TD_EDUCATION_AMT, 0) AS TD_EDUCATION_AMT                                      -- 2014-���� (������ �����ݾ�)
                           , NVL(HA.TD_EDUCATION_DED_AMT, 0) AS TD_EDUCATION_DED_AMT                              -- 2014-���� (������ ���װ���) 
                              
                           , NVL(HA.TD_POLI_DONAT_AMT1, 0) AS TD_POLI_DONAT_AMT1                                       -- 2014-���� (��ġ�ڱݱ�α�-10��������) �����ݾ�
                           , NVL(HA.TD_POLI_DONAT_DED_AMT1, 0) AS TD_POLI_DONAT_DED_AMT1                                 -- 2014-���� (��ġ�ڱݱ�α�-10��������) ���װ���
                           , NVL(HA.TD_POLI_DONAT_AMT2, 0) AS TD_POLI_DONAT_AMT2                                       -- 2014-���� (��ġ�ڱݱ�α�-10�����ʰ�) �����ݾ�
                           , NVL(HA.TD_POLI_DONAT_DED_AMT2, 0) AS TD_POLI_DONAT_DED_AMT2                                 -- 2014-���� (��ġ�ڱݱ�α�-10��������) ���װ���
                           , NVL(HA.TD_LEGAL_DONAT_AMT, 0) AS TD_LEGAL_DONAT_AMT                                       -- 2014-���� (������α�) �����ݾ�
                           , NVL(HA.TD_LEGAL_DONAT_DED_AMT, 0) AS TD_LEGAL_DONAT_DED_AMT                                 -- 2014-���� (������α�) ���װ���
                           , NVL(HA.TD_DESIGN_DONAT_AMT, 0) AS TD_DESIGN_DONAT_AMT                                    -- 2014-���� (������α�) �����ݾ�
                           , NVL(HA.TD_DESIGN_DONAT_DED_AMT, 0) AS TD_DESIGN_DONAT_DED_AMT                               -- 2014-���� (������α�) ���װ���
                             
                           , ( NVL(HA.TD_GUAR_INSUR_DED_AMT, 0) +
                               NVL(HA.TD_POLI_DONAT_DED_AMT1, 0) + NVL(HA.TD_EDUCATION_DED_AMT, 0) +
                               NVL(HA.TD_POLI_DONAT_DED_AMT1, 0) + NVL(HA.TD_POLI_DONAT_DED_AMT2, 0) +
                               NVL(HA.TD_LEGAL_DONAT_DED_AMT, 0) + NVL(HA.TD_DESIGN_DONAT_DED_AMT, 0)) AS SP_TAX_DED_SUM_AMT      -- Ư�� ����  ���� 
                             
                           , NVL(HA.STAND_DED_AMT, 0) AS STAND_DED_AMT                                 -- ǥ�ؼ��װ��� 
                             
                           , NVL(HA.TAX_DED_TAXGROUP_AMT, 0) AS TAX_DED_TAXGROUP_AMT    -- ���� - ��������
                           , NVL(HA.TAX_DED_HOUSE_DEBT_AMT, 0) AS TAX_DED_HOUSE_DEBT_AMT  -- ���� - �������Ա�
                           , NVL(HA.TAX_DED_OUTSIDE_PAY_AMT, 0) AS TAX_DED_OUTSIDE_PAY_AMT  -- ���� - �ܱ�����
                           , NVL(HA.TD_HOUSE_MONTHLY_AMT, 0) AS TD_HOUSE_MONTHLY_AMT        -- ���� �������� ��� 
                           , NVL(HA.TD_HOUSE_MONTHLY_DED_AMT, 0) AS TD_HOUSE_MONTHLY_DED_AMT   -- ���� �������� ���� 
                             
                           , ( NVL(HA.TAX_DED_INCOME_AMT, 0) + NVL(HA.TD_CHILD_RAISE_DED_AMT, 0) + 
                               NVL(HA.TD_SCIENTIST_ANNU_DED_AMT, 0) + NVL(HA.TD_WORKER_RETR_ANNU_DED_AMT, 0) + 
                               NVL(HA.TD_ANNU_BANK_DED_AMT, 0) + 
                               NVL(HA.TD_GUAR_INSUR_DED_AMT, 0) + 
                               NVL(HA.TD_POLI_DONAT_DED_AMT1, 0) + NVL(HA.TD_EDUCATION_DED_AMT, 0) +
                               NVL(HA.TD_POLI_DONAT_DED_AMT1, 0) + NVL(HA.TD_POLI_DONAT_DED_AMT2, 0) +
                               NVL(HA.TD_LEGAL_DONAT_DED_AMT, 0) + NVL(HA.TD_DESIGN_DONAT_DED_AMT, 0) +
                               NVL(HA.TAX_DED_TAXGROUP_AMT, 0) + NVL(HA.TAX_DED_HOUSE_DEBT_AMT, 0) + 
                               NVL(HA.TAX_DED_OUTSIDE_PAY_AMT, 0) + NVL(HA.TD_HOUSE_MONTHLY_DED_AMT, 0)
                             ) AS TAX_DED_SUM_AMT      -- ���װ��� �հ�
                           , NVL(HA.FIX_TAX_AMT, 0) AS FIX_TAX_AMT                       -- ��������
                           -- ��������
                           , NVL(HA.FIX_IN_TAX_AMT, 0) AS FIX_IN_TAX_AMT        -- ���� �ҵ漼
                           , NVL(HA.FIX_LOCAL_TAX_AMT, 0) AS FIX_LOCAL_TAX_AMT   -- ���� �ֹμ�
                           , NVL(HA.FIX_SP_TAX_AMT, 0) AS FIX_SP_TAX_AMT         -- ���� ��Ư��
                           , ( NVL(HA.FIX_IN_TAX_AMT, 0) +
                               NVL(HA.FIX_LOCAL_TAX_AMT, 0) +
                               NVL(HA.FIX_SP_TAX_AMT, 0)) AS FIX_TAX_SUM_AMT     -- ���� ���� �հ�
                           -- (����) �ⳳ�� ����
                           , NVL(HPW1.IN_TAX_AMT, 0) AS PRE_IN_TAX_AMT           -- (����) �ҵ漼 �հ�
                           , NVL(HPW1.LOCAL_TAX_AMT, 0) AS PRE_LOCAL_TAX_AMT     -- (����) �ֹμ� �հ�
                           , NVL(HPW1.SP_TAX_AMT, 0) AS PRE_SP_TAX_AMT           -- (����) ��Ư�� �հ�
                           , ( NVL(HPW1.IN_TAX_AMT, 0) +
                               NVL(HPW1.LOCAL_TAX_AMT, 0) +
                               NVL(HPW1.SP_TAX_AMT, 0)) AS PRE_TAX_SUM_AMT       -- (����) ���� �հ�
                           -- (����) �ⳳ�� ����
                           , ( NVL(HA.PRE_IN_TAX_AMT, 0) -
                               NVL(HPW1.IN_TAX_AMT, 0)) AS NOW_IN_TAX_AMT        -- (����) �ҵ漼
                           , ( NVL(HA.PRE_LOCAL_TAX_AMT, 0) -
                               NVL(HPW1.LOCAL_TAX_AMT, 0)) AS NOW_LOCAL_TAX_AMT  -- (����) �ֹμ�
                           , ( NVL(HA.PRE_SP_TAX_AMT, 0) -
                               NVL(HPW1.SP_TAX_AMT, 0)) AS NOW_SP_TAX_AMT        -- (����) ��Ư��
                           , ( NVL(HA.PRE_IN_TAX_AMT, 0) - NVL(HPW1.IN_TAX_AMT, 0) +
                               NVL(HA.PRE_LOCAL_TAX_AMT, 0) - NVL(HPW1.LOCAL_TAX_AMT, 0) +
                               NVL(HA.PRE_SP_TAX_AMT, 0) - NVL(HPW1.SP_TAX_AMT, 0)) AS NOW_TAX_SUM_AMT  -- (����) ���� �հ�
                           -- ���� ����
                           , NVL(HA.SUBT_IN_TAX_AMT, 0) AS SUBT_IN_TAX_AMT       -- (����) �ҵ漼
                           , NVL(HA.SUBT_LOCAL_TAX_AMT, 0) AS SUBT_LOCAL_TAX_AMT -- (����) �ֹμ�
                           , NVL(HA.SUBT_SP_TAX_AMT, 0) AS SUBT_SP_TAX_AMT       -- (����) ��Ư��
                           , ( NVL(HA.SUBT_IN_TAX_AMT, 0) +
                               NVL(HA.SUBT_LOCAL_TAX_AMT, 0) +
                               NVL(HA.SUBT_SP_TAX_AMT, 0)) AS SUBT_TAX_SUM_AMT   -- (����) ���� �հ�          
                           -- ����� �հ�
                           , ( NVL(HA.NONTAX_OUTSIDE_AMT, 0) + NVL(HA.NONTAX_OT_AMT, 0) +  -- NONTAX_OUTSIDE_AMT : ����� ���ܱٷ� �հ�
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
                               -- ����--
                               NVL(HA.PRE_NT_OUTSIDE_AMT, 0) + NVL(HA.PRE_NT_OT_AMT, 0) +  -- NONTAX_OUTSIDE_AMT : ����� ���ܱٷ� �հ�
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
                               NVL(HA.PRE_NT_HOUSE_SUBSIDY_AMT, 0) + NVL(HA.PRE_NT_SEA_RESOURCE_AMT, 0)) AS NONTAX_TOT_AMT  -- ����� �հ�
                           -- ����� ��
                           , (NVL(HA.NONTAX_OUTSIDE_AMT, 0) + NVL(HA.PRE_NT_OUTSIDE_AMT, 0)) AS NONTAX_OUTSIDE_AMT -- ����� ���ܱٷ� �հ�
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
                           , ( -- ���� ���� ����
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
                           , (-- ���� �λ系��.
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
                           , '�����곻��' AS ADJUSTMENT_TYPE 
                           , ( NVL(HA.NOW_PAY_TOT_AMT, 0) + NVL(HA.NOW_BONUS_TOT_AMT, 0) +
                               NVL(HA.NOW_ADD_BONUS_AMT, 0) + NVL(HA.NOW_STOCK_BENE_AMT, 0) +
                               NVL(HA.INCOME_OUTSIDE_AMT, 0) +
                               NVL(HA.NOW_EMPLOYEE_STOCK_AMT, 0) + NVL(HA.NOW_OFFICE_RETIRE_OVER_AMT, 0)) AS NOW_SUM_PAY  -- ����
                           , ( NVL(HA.PRE_PAY_TOT_AMT, 0) + NVL(HA.PRE_BONUS_TOT_AMT, 0) +
                               NVL(HA.PRE_ADD_BONUS_AMT, 0) + NVL(HA.PRE_STOCK_BENE_AMT, 0) +
                               NVL(HA.PRE_EMPLOYEE_STOCK_AMT, 0) + NVL(HA.PRE_OFFICE_RETIRE_OVER_AMT, 0)) AS PRE_SUM_PAY  -- ����
                           , NVL(HA.INCOME_TOT_AMT, 0) AS TOTAL_PAY         -- �ѱ޿�
                           , NVL(HA.INCOME_DED_AMT, 0) AS INCOME_DED_AMT    -- �ٷμҵ����
                           , ( NVL(HA.INCOME_TOT_AMT, 0) - NVL(HA.INCOME_DED_AMT, 0)) AS INCOME_AMT  -- �ٷμҵ�ݾ�
                           -- ��������
                           , NVL(HA.PER_DED_AMT, 0) AS PER_DED_AMT                      -- ����
                           , NVL(HA.SPOUSE_DED_AMT, 0) AS SPOUSE_DED_AMT                -- �����
                           , NVL(HA.SUPP_DED_COUNT, 0) AS SUPP_DED_COUNT                -- �ξ簡�� �ο���
                           , NVL(HA.SUPP_DED_AMT, 0) AS SUPP_DED_AMT                    -- �ξ簡�� �����ݾ�
                           , NVL(HA.OLD_DED_COUNT1, 0) AS OLD_DED_COUNT1                -- ��ο�� �ο���
                           , NVL(HA.OLD_DED_AMT1, 0) AS OLD_DED_AMT1                    -- ��ο�� �����ݾ�
                           , NVL(HA.DISABILITY_DED_COUNT, 0) AS DISABILITY_DED_COUNT    -- ����� �ο���
                           , NVL(HA.DISABILITY_DED_AMT, 0) AS DISABILITY_DED_AMT        -- ����� �����ݾ�
                           , NVL(HA.WOMAN_DED_AMT, 0) AS WOMAN_DED_AMT                  -- �γ��� �����ݾ�
                           , NVL(HA.SINGLE_PARENT_DED_AMT, 0) AS SINGLE_PARENT_DED_AMT  -- �Ѻθ���
                           -- ���ݺ���� ����
                           , NVL(HA.NATI_ANNU_AMT, 0) AS NATI_ANNU_AMT                  -- ���ο��ݺ���� ����
                           , NVL(HA.PUBLIC_INSUR_AMT, 0) AS PUBLIC_INSUR_AMT            -- ����������
                           , NVL(HA.MARINE_INSUR_AMT, 0) AS MARINE_INSUR_AMT            -- ���ο��ݺ���
                           , NVL(HA.SCHOOL_STAFF_INSUR_AMT, 0) AS SCHOOL_STAFF_INSUR_AMT  -- �縳�б� ����������
                           , NVL(HA.POST_OFFICE_INSUR_AMT, 0) AS POST_OFFICE_INSUR_AMT    -- ������ü������
                             
                           -- Ư������
                           , NVL(HA.MEDIC_INSUR_AMT, 0) AS MEDIC_INSUR_AMT              -- �ǰ������
                           , NVL(HA.HIRE_INSUR_AMT, 0) AS HIRE_INSUR_AMT                -- ��뺸���
                             
                           , NVL(HA.HOUSE_INTER_AMT, 0) AS HOUSE_INTER_AMT                    -- �����������Աݿ����� ��ȯ�� - ������
                           , NVL(HA.HOUSE_INTER_AMT_ETC, 0) AS HOUSE_INTER_AMT_ETC            -- �����������Աݿ����� ��ȯ�� - ������
                             
                           , NVL(HA.LONG_HOUSE_PROF_AMT, 0) AS LONG_HOUSE_PROF_AMT            -- ��������������Ա����ڻ�ȯ�� 2011�� �������Ժ� 15�� �̸�
                           , NVL(HA.LONG_HOUSE_PROF_AMT_1, 0) AS LONG_HOUSE_PROF_AMT_1        -- ��������������Ա����ڻ�ȯ�� 2011�� �������Ժ� 15~29��
                           , NVL(HA.LONG_HOUSE_PROF_AMT_2, 0) AS LONG_HOUSE_PROF_AMT_2        -- ��������������Ա����ڻ�ȯ�� 2011�� �������Ժ� 30�� �̻�
                           , NVL(HA.LONG_HOUSE_PROF_AMT_3_FIX, 0) AS LONG_HOUSE_PROF_AMT_3_FIX  -- ��������������Ա����ڻ�ȯ�� 2012�� ���� ���Ժ� 15�� �̻� �����ݾ� ��
                           , NVL(HA.LONG_HOUSE_PROF_AMT_3_ETC, 0) AS LONG_HOUSE_PROF_AMT_3_ETC  -- ��������������Ա����ڻ�ȯ�� 2012�� ���� ���Ժ� 15�� �̻� ��Ÿ�����
                           /*, ( NVL(HA.LONG_HOUSE_PROF_AMT, 0) +
                               NVL(HA.LONG_HOUSE_PROF_AMT_1, 0) + NVL(HA.LONG_HOUSE_PROF_AMT_2, 0) +
                               NVL(HA.LONG_HOUSE_PROF_AMT_3_FIX, 0) + NVL(HA.LONG_HOUSE_PROF_AMT_3_ETC, 0)) AS LONG_HOUSE_PROF_SUM_AMT  -- ����������� �հ�*/
                           , NVL(HA.DONAT_NEXT_ALL, 0) + NVL(HA.DONAT_NEXT_50, 0) + NVL(HA.DONAT_NEXT_30, 0) + NVL(HA.DONAT_NEXT_RELIGION_10, 0) + NVL(HA.DONAT_NEXT_10, 0) AS FORWARD_DONATION_AMT            -- ��α�(�̿���)
                             
                          --, NVL(HA.HOUSE_FUND_AMT, 0) AS HOUSE_FUND_AMT                -- �����ڱ� �հ�
                             
                           , ((CASE
                                 WHEN NVL(HA.MEDIC_INSUR_AMT, 0) + NVL(HA.HIRE_INSUR_AMT, 0)  < 0 THEN 0
                                 ELSE NVL(HA.MEDIC_INSUR_AMT, 0) + NVL(HA.HIRE_INSUR_AMT, 0) 
                               END) +
                               NVL(HA.HOUSE_INTER_AMT, 0) +            -- �����������Աݿ����� ��ȯ�� - ������
                               NVL(HA.HOUSE_INTER_AMT_ETC, 0) +        -- �����������Աݿ����� ��ȯ�� - ������            
                               NVL(HA.LONG_HOUSE_PROF_AMT, 0) +        -- ��������������Ա����ڻ�ȯ�� 2011�� �������Ժ� 15�� �̸�
                               NVL(HA.LONG_HOUSE_PROF_AMT_1, 0) +      -- ��������������Ա����ڻ�ȯ�� 2011�� �������Ժ� 15~29��
                               NVL(HA.LONG_HOUSE_PROF_AMT_2, 0) +      -- ��������������Ա����ڻ�ȯ�� 2011�� �������Ժ� 30�� �̻�
                               NVL(HA.LONG_HOUSE_PROF_AMT_3_FIX, 0) +  -- ��������������Ա����ڻ�ȯ�� 2012�� ���� ���Ժ� 15�� �̻� �����ݾ� ��
                               NVL(HA.LONG_HOUSE_PROF_AMT_3_ETC, 0) +  -- ��������������Ա����ڻ�ȯ�� 2012�� ���� ���Ժ� 15�� �̻� ��Ÿ�����
                               NVL(HA.DONAT_NEXT_ALL, 0) + NVL(HA.DONAT_NEXT_50, 0) + NVL(HA.DONAT_NEXT_30, 0) + NVL(HA.DONAT_NEXT_RELIGION_10, 0) + NVL(HA.DONAT_NEXT_10, 0)-- ��α�(�̿���)
                               ) AS SP_DED_SUM_AMT                       -- Ư���ҵ���� �� 
                                         

                           -- �����ҵ�ݾ�
                           , NVL(HA.SUBT_DED_AMT, 0) AS SUBT_DED_AMT
                           -- �׹��� �ҵ����
                           , NVL(HA.PERS_ANNU_BANK_AMT, 0) AS PERS_ANNU_BANK_AMT        -- ���ο�������ҵ����
                           , NVL(HA.SMALL_CORPOR_DED_AMT, 0) AS SMALL_CORPOR_DED_AMT    -- �ұ��/�һ���� �����α� �ҵ����
                           , NVL(HA.HOUSE_APP_DEPOSIT_AMT, 0) AS HOUSE_APP_DEPOSIT_AMT  -- ����û������
                           , NVL(HA.HOUSE_APP_SAVE_AMT, 0) AS HOUSE_APP_SAVE_AMT        -- ����û����������
                           , NVL(HA.WORKER_HOUSE_SAVE_AMT, 0) AS WORKER_HOUSE_SAVE_AMT  -- �ٷ������ø�������
                           , NVL(HA.INVES_AMT, 0) AS INVES_AMT                          -- �����������ڵ� �ҵ����
                           /*, ( NVL(HA.HOUSE_APP_DEPOSIT_AMT, 0) + NVL(HA.HOUSE_APP_SAVE_AMT, 0) +
                               NVL(HA.HOUSE_SAVE_AMT, 0) + NVL(HA.WORKER_HOUSE_SAVE_AMT, 0)) AS HOUSE_SAVE_SUM_AMT  -- ���ø��� ����ҵ���� �հ�*/
                             
                           , NVL(HA.CREDIT_AMT, 0) AS CREDIT_AMT                        -- �ſ�ī��� �ҵ����
                           , NVL(HA.EMPL_STOCK_AMT, 0) AS EMPL_STOCK_AMT                -- �츮�������ռҵ����
                           , NVL(HA.DONAT_DED_30, 0) AS DONAT_DED_30                    -- �츮�������ձ�α�
                           , NVL(HA.HIRE_KEEP_EMPLOY_AMT, 0) AS HIRE_KEEP_EMPLOY_AMT    -- ��������߼ұ���ٷ���
                           , NVL(HA.FIX_LEASE_DED_AMT, 0) AS FIX_LEASE_DED_AMT          -- �񵷾ȵ�� �������ڻ�ȯ��
                           , NVL(HA.LONG_SET_INVEST_SAVING_AMT, 0) AS LONG_SET_INVEST_SAVING_AMT -- �������������������
                             
                           , ( NVL(HA.PERS_ANNU_BANK_AMT, 0) + NVL(HA.SMALL_CORPOR_DED_AMT, 0) +
                               NVL(HA.HOUSE_APP_DEPOSIT_AMT, 0) + NVL(HA.HOUSE_APP_SAVE_AMT, 0) +
                               NVL(HA.WORKER_HOUSE_SAVE_AMT, 0) + NVL(HA.INVES_AMT, 0) +
                               NVL(HA.CREDIT_AMT, 0) + NVL(HA.EMPL_STOCK_AMT, 0) +
                               NVL(HA.DONAT_DED_30, 0) + NVL(HA.HIRE_KEEP_EMPLOY_AMT, 0) +
                               NVL(HA.FIX_LEASE_DED_AMT, 0) + NVL(HA.LONG_SET_INVEST_SAVING_AMT, 0)) AS ETC_DED_SUM_AMT   -- �׹��� �ҵ���� �հ� �ݾ� --
                           -- Ư������ �����ѵ� �ʰ���
                           , NVL(HA.SP_DED_TOT_AMT, 0) AS SP_DED_TOT_AMT                -- Ư������ �����ѵ� �ʰ���
                           -- ���ռҵ� ����ǥ��
                           , NVL(HA.TAX_STD_AMT, 0) AS TAX_STD_AMT                      -- ���ռҵ� ����ǥ��
                           -- ���⼼��
                           , NVL(HA.COMP_TAX_AMT, 0) AS COMP_TAX_AMT                    -- ���⼼��
                           -- ���װ���
                           , NVL(HA.TAX_REDU_IN_LAW_AMT, 0) AS TAX_REDU_IN_LAW_AMT      -- �ҵ漼��
                           , NVL(HA.TAX_REDU_SP_LAW_AMT, 0) AS TAX_REDU_SP_LAW_AMT      -- ����Ư�� ���ѹ�
                           , NVL(HA.TAX_REDU_SMALL_BUSINESS, 0) AS TAX_REDU_SP_LAW_AMT_1                   -- ����Ư�� ���ѹ� ��30��
                           , NVL(HA.TAX_REDU_TAX_TREATY, 0) AS TAX_REDU_TAX_TREATY      -- ��������
                           , ( NVL(HA.TAX_REDU_IN_LAW_AMT, 0) + NVL(HA.TAX_REDU_SP_LAW_AMT, 0) +
                               NVL(HA.TAX_REDU_TAX_TREATY, 0) + NVL(HA.TAX_REDU_SMALL_BUSINESS, 0)) AS TAX_REDU_SUM_AMT      -- ���װ��� �հ�
                           -- ���װ���
                           , NVL(HA.TAX_DED_INCOME_AMT, 0) AS TAX_DED_INCOME_AMT        -- ����-�ٷμҵ�
                           , NVL(HA.TD_CHILD_RAISE_DED_CNT, 0) AS TD_CHILD_RAISE_DED_CNT  -- ����-�ڳ���� �ο��� 
                           , NVL(HA.TD_CHILD_RAISE_DED_AMT, 0) AS TD_CHILD_RAISE_DED_AMT  -- ����-�ڳ���� �ݾ� 
                           , NVL(HA.TD_CHILD_6_UNDER_DED_CNT, 0) AS TD_CHILD_6_UNDER_DED_CNT  -- ����-�ڳ� 6������ �ο��� 
                           , NVL(HA.TD_CHILD_6_UNDER_DED_AMT, 0) AS TD_CHILD_6_UNDER_DED_AMT  -- ����-�ڳ�6������ �ݾ� 
                           , NVL(HA.TD_BIRTH_DED_CNT, 0) AS TD_BIRTH_DED_CNT                  -- ����-�ڳ� ���/�Ծ� �ο��� 
                           , NVL(HA.TD_BIRTH_DED_AMT, 0) AS TD_BIRTH_DED_AMT                  -- ����-�ڳ� ���/�Ծ� �ݾ� 
                             
                           , NVL(HA.TD_SCIENTIST_ANNU_AMT, 0) AS TD_SCIENTIST_ANNU_AMT                            -- 2014-���б���� �����ݾ�
                           , NVL(HA.TD_SCIENTIST_ANNU_DED_AMT, 0) AS TD_SCIENTIST_ANNU_DED_AMT                    -- 2014-���б���� ���װ���
                           , NVL(HA.TD_WORKER_RETR_ANNU_AMT, 0) AS TD_WORKER_RETR_ANNU_AMT                        -- 2014-��������  �����ݾ�
                           , NVL(HA.TD_WORKER_RETR_ANNU_DED_AMT, 0) AS TD_WORKER_RETR_ANNU_DED_AMT                -- 2014-�������� ���װ���
                           , NVL(HA.TD_ANNU_BANK_AMT, 0) AS TD_ANNU_BANK_AMT                                      -- 2014-�������� �����ݾ�
                           , NVL(HA.TD_ANNU_BANK_DED_AMT, 0) AS TD_ANNU_BANK_DED_AMT                              -- 2014-�������� ���װ���
                              
                           , ( NVL(HA.TD_GUAR_INSUR_AMT, 0) + 
                               NVL(HA.TD_DISABILITY_INSUR_AMT, 0)) AS TD_GUAR_INSUR_AMT                           -- 2014-���� ( ���强���� �����ݾ�)
                           , ( NVL(HA.TD_GUAR_INSUR_DED_AMT, 0) + 
                               NVL(HA.TD_DISABILITY_INSUR_DED_AMT, 0)) AS TD_GUAR_INSUR_DED_AMT                   -- 2014-���� ( ���强���� ���װ���)
                              
                           , NVL(HA.TD_MEDIC_AMT, 0) AS TD_MEDIC_AMT                                              -- 2014-���� (�Ƿ�� �����ݾ�)
                           , NVL(HA.TD_MEDIC_DED_AMT, 0) AS TD_MEDIC_DED_AMT                                      -- 2014-���� (�Ƿ�� ���װ���)
                              
                           , NVL(HA.TD_EDUCATION_AMT, 0) AS TD_EDUCATION_AMT                                      -- 2014-���� (������ �����ݾ�)
                           , NVL(HA.TD_EDUCATION_DED_AMT, 0) AS TD_EDUCATION_DED_AMT                              -- 2014-���� (������ ���װ���) 
                              
                           , NVL(HA.TD_POLI_DONAT_AMT1, 0) AS TD_POLI_DONAT_AMT1                                       -- 2014-���� (��ġ�ڱݱ�α�-10��������) �����ݾ�
                           , NVL(HA.TD_POLI_DONAT_DED_AMT1, 0) AS TD_POLI_DONAT_DED_AMT1                                 -- 2014-���� (��ġ�ڱݱ�α�-10��������) ���װ���
                           , NVL(HA.TD_POLI_DONAT_AMT2, 0) AS TD_POLI_DONAT_AMT2                                       -- 2014-���� (��ġ�ڱݱ�α�-10�����ʰ�) �����ݾ�
                           , NVL(HA.TD_POLI_DONAT_DED_AMT2, 0) AS TD_POLI_DONAT_DED_AMT2                                 -- 2014-���� (��ġ�ڱݱ�α�-10��������) ���װ���
                           , NVL(HA.TD_LEGAL_DONAT_AMT, 0) AS TD_LEGAL_DONAT_AMT                                       -- 2014-���� (������α�) �����ݾ�
                           , NVL(HA.TD_LEGAL_DONAT_DED_AMT, 0) AS TD_LEGAL_DONAT_DED_AMT                                 -- 2014-���� (������α�) ���װ���
                           , NVL(HA.TD_DESIGN_DONAT_AMT, 0) AS TD_DESIGN_DONAT_AMT                                    -- 2014-���� (������α�) �����ݾ�
                           , NVL(HA.TD_DESIGN_DONAT_DED_AMT, 0) AS TD_DESIGN_DONAT_DED_AMT                               -- 2014-���� (������α�) ���װ���
                             
                           , ( NVL(HA.TD_GUAR_INSUR_DED_AMT, 0) + NVL(HA.TD_DISABILITY_INSUR_DED_AMT, 0) + 
                               NVL(HA.TD_POLI_DONAT_DED_AMT1, 0) + NVL(HA.TD_EDUCATION_DED_AMT, 0) +
                               NVL(HA.TD_POLI_DONAT_DED_AMT1, 0) + NVL(HA.TD_POLI_DONAT_DED_AMT2, 0) +
                               NVL(HA.TD_LEGAL_DONAT_DED_AMT, 0) + NVL(HA.TD_DESIGN_DONAT_DED_AMT, 0)) AS SP_TAX_DED_SUM_AMT      -- Ư�� ����  ���� 
                             
                           , NVL(HA.STAND_DED_AMT, 0) AS STAND_DED_AMT                                 -- ǥ�ؼ��װ��� 
                             
                           , NVL(HA.TAX_DED_TAXGROUP_AMT, 0) AS TAX_DED_TAXGROUP_AMT    -- ���� - ��������
                           , NVL(HA.TAX_DED_HOUSE_DEBT_AMT, 0) AS TAX_DED_HOUSE_DEBT_AMT  -- ���� - �������Ա�
                           , NVL(HA.TAX_DED_OUTSIDE_PAY_AMT, 0) AS TAX_DED_OUTSIDE_PAY_AMT  -- ���� - �ܱ�����
                           , NVL(HA.TD_HOUSE_MONTHLY_AMT, 0) AS TD_HOUSE_MONTHLY_AMT        -- ���� �������� ��� 
                           , NVL(HA.TD_HOUSE_MONTHLY_DED_AMT, 0) AS TD_HOUSE_MONTHLY_DED_AMT   -- ���� �������� ���� 
                             
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
                             ) AS TAX_DED_SUM_AMT      -- ���װ��� �հ�
                           , NVL(HA.FIX_TAX_AMT, 0) AS FIX_TAX_AMT                       -- ��������
                           -- ��������
                           , NVL(HA.FIX_IN_TAX_AMT, 0) AS FIX_IN_TAX_AMT        -- ���� �ҵ漼
                           , NVL(HA.FIX_LOCAL_TAX_AMT, 0) AS FIX_LOCAL_TAX_AMT   -- ���� �ֹμ�
                           , NVL(HA.FIX_SP_TAX_AMT, 0) AS FIX_SP_TAX_AMT         -- ���� ��Ư��
                           , ( NVL(HA.FIX_IN_TAX_AMT, 0) +
                               NVL(HA.FIX_LOCAL_TAX_AMT, 0) +
                               NVL(HA.FIX_SP_TAX_AMT, 0)) AS FIX_TAX_SUM_AMT     -- ���� ���� �հ�
                           -- (����) �ⳳ�� ����
                           , NVL(HPW1.IN_TAX_AMT, 0) AS PRE_IN_TAX_AMT           -- (����) �ҵ漼 �հ�
                           , NVL(HPW1.LOCAL_TAX_AMT, 0) AS PRE_LOCAL_TAX_AMT     -- (����) �ֹμ� �հ�
                           , NVL(HPW1.SP_TAX_AMT, 0) AS PRE_SP_TAX_AMT           -- (����) ��Ư�� �հ�
                           , ( NVL(HPW1.IN_TAX_AMT, 0) +
                             NVL(HPW1.LOCAL_TAX_AMT, 0) +
                             NVL(HPW1.SP_TAX_AMT, 0)) AS PRE_TAX_SUM_AMT       -- (����) ���� �հ�
                         -- (����) �ⳳ�� ����
                         , ( NVL(HA.PRE_IN_TAX_AMT, 0) -
                             NVL(HPW1.IN_TAX_AMT, 0)) AS NOW_IN_TAX_AMT        -- (����) �ҵ漼
                         , ( NVL(HA.PRE_LOCAL_TAX_AMT, 0) -
                             NVL(HPW1.LOCAL_TAX_AMT, 0)) AS NOW_LOCAL_TAX_AMT  -- (����) �ֹμ�
                         , ( NVL(HA.PRE_SP_TAX_AMT, 0) -
                             NVL(HPW1.SP_TAX_AMT, 0)) AS NOW_SP_TAX_AMT        -- (����) ��Ư��
                         , ( NVL(HA.PRE_IN_TAX_AMT, 0) - NVL(HPW1.IN_TAX_AMT, 0) +
                             NVL(HA.PRE_LOCAL_TAX_AMT, 0) - NVL(HPW1.LOCAL_TAX_AMT, 0) +
                             NVL(HA.PRE_SP_TAX_AMT, 0) - NVL(HPW1.SP_TAX_AMT, 0)) AS NOW_TAX_SUM_AMT  -- (����) ���� �հ�
                         -- ���� ����
                         , NVL(HA.SUBT_IN_TAX_AMT, 0) AS SUBT_IN_TAX_AMT       -- (����) �ҵ漼
                         , NVL(HA.SUBT_LOCAL_TAX_AMT, 0) AS SUBT_LOCAL_TAX_AMT -- (����) �ֹμ�
                         , NVL(HA.SUBT_SP_TAX_AMT, 0) AS SUBT_SP_TAX_AMT       -- (����) ��Ư��
                         , ( NVL(HA.SUBT_IN_TAX_AMT, 0) +
                             NVL(HA.SUBT_LOCAL_TAX_AMT, 0) +
                             NVL(HA.SUBT_SP_TAX_AMT, 0)) AS SUBT_TAX_SUM_AMT   -- (����) ���� �հ�          
                         -- ����� �հ�
                         , ( NVL(HA.NONTAX_OUTSIDE_AMT, 0) + NVL(HA.NONTAX_OT_AMT, 0) +  -- NONTAX_OUTSIDE_AMT : ����� ���ܱٷ� �հ�
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
                             -- ����--
                             NVL(HA.PRE_NT_OUTSIDE_AMT, 0) + NVL(HA.PRE_NT_OT_AMT, 0) +  -- NONTAX_OUTSIDE_AMT : ����� ���ܱٷ� �հ�
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
                             NVL(HA.PRE_NT_HOUSE_SUBSIDY_AMT, 0) + NVL(HA.PRE_NT_SEA_RESOURCE_AMT, 0)) AS NONTAX_TOT_AMT  -- ����� �հ�
                         -- ����� ��
                         , (NVL(HA.NONTAX_OUTSIDE_AMT, 0) + NVL(HA.PRE_NT_OUTSIDE_AMT, 0)) AS NONTAX_OUTSIDE_AMT -- ����� ���ܱٷ� �հ�
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
                         , ( -- ���� ���� ����
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
                         , (-- ���� �λ系��.
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
                 , '��������' AS ADJUSTMENT_TYPE 
                 , SUM(NVL(T2.NOW_SUM_PAY, 0) * T2.SIGN_FLAG) AS NOW_SUM_PAY  -- ����
                 , SUM(NVL(T2.PRE_SUM_PAY, 0) * T2.SIGN_FLAG) AS PRE_SUM_PAY  -- ����
                 , SUM(NVL(T2.TOTAL_PAY, 0) * T2.SIGN_FLAG) AS TOTAL_PAY         -- �ѱ޿�
                 , SUM(NVL(T2.INCOME_DED_AMT, 0) * T2.SIGN_FLAG) AS INCOME_DED_AMT    -- �ٷμҵ����
                 , SUM(NVL(T2.INCOME_AMT, 0) * T2.SIGN_FLAG) AS INCOME_AMT  -- �ٷμҵ�ݾ�
                 -- ��������
                 , SUM(NVL(T2.PER_DED_AMT, 0) * T2.SIGN_FLAG) AS PER_DED_AMT                      -- ����
                 , SUM(NVL(T2.SPOUSE_DED_AMT, 0) * T2.SIGN_FLAG) AS SPOUSE_DED_AMT                -- �����
                 , SUM(NVL(T2.SUPP_DED_COUNT, 0) * T2.SIGN_FLAG) AS SUPP_DED_COUNT                -- �ξ簡�� �ο���
                 , SUM(NVL(T2.SUPP_DED_AMT, 0) * T2.SIGN_FLAG) AS SUPP_DED_AMT                    -- �ξ簡�� �����ݾ�
                 , SUM(NVL(T2.OLD_DED_COUNT1, 0) * T2.SIGN_FLAG) AS OLD_DED_COUNT1                -- ��ο�� �ο���
                 , SUM(NVL(T2.OLD_DED_AMT1, 0) * T2.SIGN_FLAG) AS OLD_DED_AMT1                    -- ��ο�� �����ݾ�
                 , SUM(NVL(T2.DISABILITY_DED_COUNT, 0) * T2.SIGN_FLAG) AS DISABILITY_DED_COUNT    -- ����� �ο���
                 , SUM(NVL(T2.DISABILITY_DED_AMT, 0) * T2.SIGN_FLAG) AS DISABILITY_DED_AMT        -- ����� �����ݾ�
                 , SUM(NVL(T2.WOMAN_DED_AMT, 0) * T2.SIGN_FLAG) AS WOMAN_DED_AMT                  -- �γ��� �����ݾ�
                 , SUM(NVL(T2.SINGLE_PARENT_DED_AMT, 0) * T2.SIGN_FLAG) AS SINGLE_PARENT_DED_AMT  -- �Ѻθ���
                 -- ���ݺ���� ����
                 , SUM(NVL(T2.NATI_ANNU_AMT, 0) * T2.SIGN_FLAG) AS NATI_ANNU_AMT                  -- ���ο��ݺ���� ����
                 , SUM(NVL(T2.PUBLIC_INSUR_AMT, 0) * T2.SIGN_FLAG) AS PUBLIC_INSUR_AMT            -- ����������
                 , SUM(NVL(T2.MARINE_INSUR_AMT, 0) * T2.SIGN_FLAG) AS MARINE_INSUR_AMT            -- ���ο��ݺ���
                 , SUM(NVL(T2.SCHOOL_STAFF_INSUR_AMT, 0) * T2.SIGN_FLAG) AS SCHOOL_STAFF_INSUR_AMT  -- �縳�б� ����������
                 , SUM(NVL(T2.POST_OFFICE_INSUR_AMT, 0) * T2.SIGN_FLAG) AS POST_OFFICE_INSUR_AMT    -- ������ü������
                           
                 -- Ư������
                 , SUM(NVL(T2.MEDIC_INSUR_AMT, 0) * T2.SIGN_FLAG) AS MEDIC_INSUR_AMT              -- �ǰ������
                 , SUM(NVL(T2.HIRE_INSUR_AMT, 0) * T2.SIGN_FLAG) AS HIRE_INSUR_AMT                -- ��뺸���
                           
                 , SUM(NVL(T2.HOUSE_INTER_AMT, 0) * T2.SIGN_FLAG) AS HOUSE_INTER_AMT                    -- �����������Աݿ����� ��ȯ�� - ������
                 , SUM(NVL(T2.HOUSE_INTER_AMT_ETC, 0) * T2.SIGN_FLAG) AS HOUSE_INTER_AMT_ETC            -- �����������Աݿ����� ��ȯ�� - ������
                           
                 , SUM(NVL(T2.LONG_HOUSE_PROF_AMT, 0) * T2.SIGN_FLAG) AS LONG_HOUSE_PROF_AMT            -- ��������������Ա����ڻ�ȯ�� 2011�� �������Ժ� 15�� �̸�
                 , SUM(NVL(T2.LONG_HOUSE_PROF_AMT_1, 0) * T2.SIGN_FLAG) AS LONG_HOUSE_PROF_AMT_1        -- ��������������Ա����ڻ�ȯ�� 2011�� �������Ժ� 15~29��
                 , SUM(NVL(T2.LONG_HOUSE_PROF_AMT_2, 0) * T2.SIGN_FLAG) AS LONG_HOUSE_PROF_AMT_2        -- ��������������Ա����ڻ�ȯ�� 2011�� �������Ժ� 30�� �̻�
                 , SUM(NVL(T2.LONG_HOUSE_PROF_AMT_3_FIX, 0) * T2.SIGN_FLAG) AS LONG_HOUSE_PROF_AMT_3_FIX  -- ��������������Ա����ڻ�ȯ�� 2012�� ���� ���Ժ� 15�� �̻� �����ݾ� ��
                 , SUM(NVL(T2.LONG_HOUSE_PROF_AMT_3_ETC, 0) * T2.SIGN_FLAG) AS LONG_HOUSE_PROF_AMT_3_ETC  -- ��������������Ա����ڻ�ȯ�� 2012�� ���� ���Ժ� 15�� �̻� ��Ÿ�����
                 , SUM(NVL(T2.FORWARD_DONATION_AMT, 0) * T2.SIGN_FLAG) AS FORWARD_DONATION_AMT            -- ��α�(�̿���)
                           
                 , SUM(NVL(T2.SP_DED_SUM_AMT, 0) * T2.SIGN_FLAG) AS SP_DED_SUM_AMT                       -- Ư���ҵ���� �� 

                 -- �����ҵ�ݾ�
                 , SUM(NVL(T2.SUBT_DED_AMT, 0) * T2.SIGN_FLAG) AS SUBT_DED_AMT
                 -- �׹��� �ҵ����
                 , SUM(NVL(T2.PERS_ANNU_BANK_AMT, 0) * T2.SIGN_FLAG) AS PERS_ANNU_BANK_AMT        -- ���ο�������ҵ����
                 , SUM(NVL(T2.SMALL_CORPOR_DED_AMT, 0) * T2.SIGN_FLAG) AS SMALL_CORPOR_DED_AMT    -- �ұ��/�һ���� �����α� �ҵ����
                 , SUM(NVL(T2.HOUSE_APP_DEPOSIT_AMT, 0) * T2.SIGN_FLAG) AS HOUSE_APP_DEPOSIT_AMT  -- ����û������
                 , SUM(NVL(T2.HOUSE_APP_SAVE_AMT, 0) * T2.SIGN_FLAG) AS HOUSE_APP_SAVE_AMT        -- ����û����������
                 , SUM(NVL(T2.WORKER_HOUSE_SAVE_AMT, 0) * T2.SIGN_FLAG) AS WORKER_HOUSE_SAVE_AMT  -- �ٷ������ø�������
                 , SUM(NVL(T2.INVES_AMT, 0) * T2.SIGN_FLAG) AS INVES_AMT                          -- �����������ڵ� �ҵ����
                           
                 , SUM(NVL(T2.CREDIT_AMT, 0) * T2.SIGN_FLAG) AS CREDIT_AMT                        -- �ſ�ī��� �ҵ����
                 , SUM(NVL(T2.EMPL_STOCK_AMT, 0) * T2.SIGN_FLAG) AS EMPL_STOCK_AMT                -- �츮�������ռҵ����
                 , SUM(NVL(T2.DONAT_DED_30, 0) * T2.SIGN_FLAG) AS DONAT_DED_30                    -- �츮�������ձ�α�
                 , SUM(NVL(T2.HIRE_KEEP_EMPLOY_AMT, 0) * T2.SIGN_FLAG) AS HIRE_KEEP_EMPLOY_AMT    -- ��������߼ұ���ٷ���
                 , SUM(NVL(T2.FIX_LEASE_DED_AMT, 0) * T2.SIGN_FLAG) AS FIX_LEASE_DED_AMT          -- �񵷾ȵ�� �������ڻ�ȯ��
                 , SUM(NVL(T2.LONG_SET_INVEST_SAVING_AMT, 0) * T2.SIGN_FLAG) AS LONG_SET_INVEST_SAVING_AMT -- �������������������
                           
                 , SUM(NVL(T2.ETC_DED_SUM_AMT, 0) * T2.SIGN_FLAG) AS ETC_DED_SUM_AMT   -- �׹��� �ҵ���� �հ� �ݾ� --
                 -- Ư������ �����ѵ� �ʰ���
                 , SUM(NVL(T2.SP_DED_TOT_AMT, 0) * T2.SIGN_FLAG) AS SP_DED_TOT_AMT                -- Ư������ �����ѵ� �ʰ���
                 -- ���ռҵ� ����ǥ��
                 , SUM(NVL(T2.TAX_STD_AMT, 0) * T2.SIGN_FLAG) AS TAX_STD_AMT                      -- ���ռҵ� ����ǥ��
                 -- ���⼼��
                 , SUM(NVL(T2.COMP_TAX_AMT, 0) * T2.SIGN_FLAG) AS COMP_TAX_AMT                    -- ���⼼��
                 -- ���װ���
                 , SUM(NVL(T2.TAX_REDU_IN_LAW_AMT, 0) * T2.SIGN_FLAG) AS TAX_REDU_IN_LAW_AMT      -- �ҵ漼��
                 , SUM(NVL(T2.TAX_REDU_SP_LAW_AMT, 0) * T2.SIGN_FLAG) AS TAX_REDU_SP_LAW_AMT      -- ����Ư�� ���ѹ�
                 , SUM(NVL(T2.TAX_REDU_SP_LAW_AMT_1, 0) * T2.SIGN_FLAG) AS TAX_REDU_SP_LAW_AMT_1                   -- ����Ư�� ���ѹ� ��30��
                 , SUM(NVL(T2.TAX_REDU_TAX_TREATY, 0) * T2.SIGN_FLAG) AS TAX_REDU_TAX_TREATY      -- ��������
                 , SUM(NVL(T2.TAX_REDU_SUM_AMT, 0) * T2.SIGN_FLAG) AS TAX_REDU_SUM_AMT            -- ���װ��� �հ�
                 -- ���װ���
                 , SUM(NVL(T2.TAX_DED_INCOME_AMT, 0) * T2.SIGN_FLAG) AS TAX_DED_INCOME_AMT        -- ����-�ٷμҵ�
                 , SUM(NVL(T2.TD_CHILD_RAISE_DED_CNT, 0) * T2.SIGN_FLAG) AS TD_CHILD_RAISE_DED_CNT  -- ����-�ڳ���� �ο��� 
                 , SUM(NVL(T2.TD_CHILD_RAISE_DED_AMT, 0) * T2.SIGN_FLAG) AS TD_CHILD_RAISE_DED_AMT  -- ����-�ڳ���� �ݾ� 
                 , SUM(NVL(T2.TD_CHILD_6_UNDER_DED_CNT, 0) * T2.SIGN_FLAG) AS TD_CHILD_6_UNDER_DED_CNT  -- ����-�ڳ� 6������ �ο��� 
                 , SUM(NVL(T2.TD_CHILD_6_UNDER_DED_AMT, 0) * T2.SIGN_FLAG) AS TD_CHILD_6_UNDER_DED_AMT  -- ����-�ڳ�6������ �ݾ� 
                 , SUM(NVL(T2.TD_BIRTH_DED_CNT, 0) * T2.SIGN_FLAG) AS TD_BIRTH_DED_CNT                  -- ����-�ڳ� ���/�Ծ� �ο��� 
                 , SUM(NVL(T2.TD_BIRTH_DED_AMT, 0) * T2.SIGN_FLAG) AS TD_BIRTH_DED_AMT                  -- ����-�ڳ� ���/�Ծ� �ݾ� 
                           
                 , SUM(NVL(T2.TD_SCIENTIST_ANNU_AMT, 0) * T2.SIGN_FLAG) AS TD_SCIENTIST_ANNU_AMT                            -- 2014-���б���� �����ݾ�
                 , SUM(NVL(T2.TD_SCIENTIST_ANNU_DED_AMT, 0) * T2.SIGN_FLAG) AS TD_SCIENTIST_ANNU_DED_AMT                   -- 2014-���б���� ���װ���
                 , SUM(NVL(T2.TD_WORKER_RETR_ANNU_AMT, 0) * T2.SIGN_FLAG) AS TD_WORKER_RETR_ANNU_AMT                        -- 2014-��������  �����ݾ�
                 , SUM(NVL(T2.TD_WORKER_RETR_ANNU_DED_AMT, 0) * T2.SIGN_FLAG) AS TD_WORKER_RETR_ANNU_DED_AMT                -- 2014-�������� ���װ���
                 , SUM(NVL(T2.TD_ANNU_BANK_AMT, 0) * T2.SIGN_FLAG) AS TD_ANNU_BANK_AMT                                      -- 2014-�������� �����ݾ�
                 , SUM(NVL(T2.TD_ANNU_BANK_DED_AMT, 0) * T2.SIGN_FLAG) AS TD_ANNU_BANK_DED_AMT                              -- 2014-�������� ���װ���
                            
                 , SUM(NVL(T2.TD_GUAR_INSUR_AMT, 0) * T2.SIGN_FLAG) AS TD_GUAR_INSUR_AMT                          -- 2014-���� ( ���强���� �����ݾ�)
                 , SUM(NVL(T2.TD_GUAR_INSUR_DED_AMT, 0) * T2.SIGN_FLAG) AS TD_GUAR_INSUR_DED_AMT                  -- 2014-���� ( ���强���� ���װ���)
                            
                 , SUM(NVL(T2.TD_MEDIC_AMT, 0) * T2.SIGN_FLAG) AS TD_MEDIC_AMT                                              -- 2014-���� (�Ƿ�� �����ݾ�)
                 , SUM(NVL(T2.TD_MEDIC_DED_AMT, 0) * T2.SIGN_FLAG) AS TD_MEDIC_DED_AMT                                      -- 2014-���� (�Ƿ�� ���װ���)
                            
                 , SUM(NVL(T2.TD_EDUCATION_AMT, 0) * T2.SIGN_FLAG) AS TD_EDUCATION_AMT                                      -- 2014-���� (������ �����ݾ�)
                 , SUM(NVL(T2.TD_EDUCATION_DED_AMT, 0) * T2.SIGN_FLAG) AS TD_EDUCATION_DED_AMT                              -- 2014-���� (������ ���װ���) 
                            
                 , SUM(NVL(T2.TD_POLI_DONAT_AMT1, 0) * T2.SIGN_FLAG) AS TD_POLI_DONAT_AMT1                                  -- 2014-���� (��ġ�ڱݱ�α�-10��������) �����ݾ�
                 , SUM(NVL(T2.TD_POLI_DONAT_DED_AMT1, 0) * T2.SIGN_FLAG) AS TD_POLI_DONAT_DED_AMT1                          -- 2014-���� (��ġ�ڱݱ�α�-10��������) ���װ���
                 , SUM(NVL(T2.TD_POLI_DONAT_AMT2, 0) * T2.SIGN_FLAG) AS TD_POLI_DONAT_AMT2                                       -- 2014-���� (��ġ�ڱݱ�α�-10�����ʰ�) �����ݾ�
                 , SUM(NVL(T2.TD_POLI_DONAT_DED_AMT2, 0) * T2.SIGN_FLAG) AS TD_POLI_DONAT_DED_AMT2                                 -- 2014-���� (��ġ�ڱݱ�α�-10��������) ���װ���
                 , SUM(NVL(T2.TD_LEGAL_DONAT_AMT, 0) * T2.SIGN_FLAG) AS TD_LEGAL_DONAT_AMT                                       -- 2014-���� (������α�) �����ݾ�
                 , SUM(NVL(T2.TD_LEGAL_DONAT_DED_AMT, 0) * T2.SIGN_FLAG) AS TD_LEGAL_DONAT_DED_AMT                                 -- 2014-���� (������α�) ���װ���
                 , SUM(NVL(T2.TD_DESIGN_DONAT_AMT, 0) * T2.SIGN_FLAG) AS TD_DESIGN_DONAT_AMT                                    -- 2014-���� (������α�) �����ݾ�
                 , SUM(NVL(T2.TD_DESIGN_DONAT_DED_AMT, 0) * T2.SIGN_FLAG) AS TD_DESIGN_DONAT_DED_AMT                               -- 2014-���� (������α�) ���װ���
                           
                 , SUM(NVL(T2.SP_TAX_DED_SUM_AMT, 0) * T2.SIGN_FLAG) AS SP_TAX_DED_SUM_AMT      -- Ư�� ����  ���� 
                           
                 , SUM(NVL(T2.STAND_DED_AMT, 0) * T2.SIGN_FLAG) AS STAND_DED_AMT                                 -- ǥ�ؼ��װ��� 
                           
                 , SUM(NVL(T2.TAX_DED_TAXGROUP_AMT, 0) * T2.SIGN_FLAG) AS TAX_DED_TAXGROUP_AMT    -- ���� - ��������
                 , SUM(NVL(T2.TAX_DED_HOUSE_DEBT_AMT, 0) * T2.SIGN_FLAG) AS TAX_DED_HOUSE_DEBT_AMT  -- ���� - �������Ա�
                 , SUM(NVL(T2.TAX_DED_OUTSIDE_PAY_AMT, 0) * T2.SIGN_FLAG) AS TAX_DED_OUTSIDE_PAY_AMT  -- ���� - �ܱ�����
                 , SUM(NVL(T2.TD_HOUSE_MONTHLY_AMT, 0) * T2.SIGN_FLAG) AS TD_HOUSE_MONTHLY_AMT        -- ���� �������� ��� 
                 , SUM(NVL(T2.TD_HOUSE_MONTHLY_DED_AMT, 0) * T2.SIGN_FLAG) AS TD_HOUSE_MONTHLY_DED_AMT   -- ���� �������� ���� 
                           
                 , SUM(NVL(T2.TAX_DED_SUM_AMT, 0) * T2.SIGN_FLAG) AS TAX_DED_SUM_AMT      -- ���װ��� �հ�
                 , SUM(NVL(T2.FIX_TAX_AMT, 0) * T2.SIGN_FLAG) AS FIX_TAX_AMT                      -- ��������
                 -- ��������
                 , SUM(NVL(T2.FIX_IN_TAX_AMT, 0) * T2.SIGN_FLAG) AS FIX_IN_TAX_AMT        -- ���� �ҵ漼
                 , SUM(NVL(T2.FIX_LOCAL_TAX_AMT, 0) * T2.SIGN_FLAG) AS FIX_LOCAL_TAX_AMT   -- ���� �ֹμ�
                 , SUM(NVL(T2.FIX_SP_TAX_AMT, 0) * T2.SIGN_FLAG) AS FIX_SP_TAX_AMT         -- ���� ��Ư��
                 , SUM(NVL(T2.FIX_TAX_SUM_AMT, 0) * T2.SIGN_FLAG) AS FIX_TAX_SUM_AMT     -- ���� ���� �հ�
                 -- (����) �ⳳ�� ����
                 , SUM(NVL(T2.PRE_IN_TAX_AMT, 0) * T2.SIGN_FLAG) AS PRE_IN_TAX_AMT           -- (����) �ҵ漼 �հ�
                 , SUM(NVL(T2.PRE_LOCAL_TAX_AMT, 0) * T2.SIGN_FLAG) AS PRE_LOCAL_TAX_AMT     -- (����) �ֹμ� �հ�
                 , SUM(NVL(T2.PRE_SP_TAX_AMT, 0) * T2.SIGN_FLAG) AS PRE_SP_TAX_AMT           -- (����) ��Ư�� �հ�
                 , SUM(NVL(T2.PRE_TAX_SUM_AMT, 0) * T2.SIGN_FLAG) AS PRE_TAX_SUM_AMT       -- (����) ���� �հ�
                 -- (����) �ⳳ�� ����
                 , SUM(NVL(T2.NOW_IN_TAX_AMT, 0) * T2.SIGN_FLAG) AS NOW_IN_TAX_AMT        -- (����) �ҵ漼
                 , SUM(NVL(T2.NOW_LOCAL_TAX_AMT, 0) * T2.SIGN_FLAG) AS NOW_LOCAL_TAX_AMT  -- (����) �ֹμ�
                 , SUM(NVL(T2.NOW_SP_TAX_AMT, 0) * T2.SIGN_FLAG) AS NOW_SP_TAX_AMT        -- (����) ��Ư��
                 , SUM(NVL(T2.NOW_TAX_SUM_AMT, 0) * T2.SIGN_FLAG) AS NOW_TAX_SUM_AMT  -- (����) ���� �հ�
                 -- ���� ����
                 , SUM(NVL(T2.SUBT_IN_TAX_AMT, 0) * T2.SIGN_FLAG) AS SUBT_IN_TAX_AMT       -- (����) �ҵ漼
                 , SUM(NVL(T2.SUBT_LOCAL_TAX_AMT, 0) * T2.SIGN_FLAG) AS SUBT_LOCAL_TAX_AMT -- (����) �ֹμ�
                 , SUM(NVL(T2.SUBT_SP_TAX_AMT, 0) * T2.SIGN_FLAG) AS SUBT_SP_TAX_AMT       -- (����) ��Ư��
                 , SUM(NVL(T2.SUBT_TAX_SUM_AMT, 0) * T2.SIGN_FLAG) AS SUBT_TAX_SUM_AMT   -- (����) ���� �հ�          
                 -- ����� �հ�
                 , SUM(NVL(T2.NONTAX_TOT_AMT, 0) * T2.SIGN_FLAG) AS NONTAX_TOT_AMT  -- ����� �հ�
                 -- ����� ��
                 , SUM(NVL(T2.NONTAX_OUTSIDE_AMT, 0) * T2.SIGN_FLAG) AS NONTAX_OUTSIDE_AMT -- ����� ���ܱٷ� �հ�
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
                             NVL(HA.NOW_EMPLOYEE_STOCK_AMT, 0) + NVL(HA.NOW_OFFICE_RETIRE_OVER_AMT, 0)) AS NOW_SUM_PAY  -- ����
                         , ( NVL(HA.PRE_PAY_TOT_AMT, 0) + NVL(HA.PRE_BONUS_TOT_AMT, 0) +
                             NVL(HA.PRE_ADD_BONUS_AMT, 0) + NVL(HA.PRE_STOCK_BENE_AMT, 0) +
                             NVL(HA.PRE_EMPLOYEE_STOCK_AMT, 0) + NVL(HA.PRE_OFFICE_RETIRE_OVER_AMT, 0)) AS PRE_SUM_PAY  -- ����
                         , NVL(HA.INCOME_TOT_AMT, 0) AS TOTAL_PAY         -- �ѱ޿�
                         , NVL(HA.INCOME_DED_AMT, 0) AS INCOME_DED_AMT    -- �ٷμҵ����
                         , ( NVL(HA.INCOME_TOT_AMT, 0) - NVL(HA.INCOME_DED_AMT, 0)) AS INCOME_AMT  -- �ٷμҵ�ݾ�
                         -- ��������
                         , NVL(HA.PER_DED_AMT, 0) AS PER_DED_AMT                      -- ����
                         , NVL(HA.SPOUSE_DED_AMT, 0) AS SPOUSE_DED_AMT                -- �����
                         , NVL(HA.SUPP_DED_COUNT, 0) AS SUPP_DED_COUNT                -- �ξ簡�� �ο���
                         , NVL(HA.SUPP_DED_AMT, 0) AS SUPP_DED_AMT                    -- �ξ簡�� �����ݾ�
                         , NVL(HA.OLD_DED_COUNT1, 0) AS OLD_DED_COUNT1                -- ��ο�� �ο���
                         , NVL(HA.OLD_DED_AMT1, 0) AS OLD_DED_AMT1                    -- ��ο�� �����ݾ�
                         , NVL(HA.DISABILITY_DED_COUNT, 0) AS DISABILITY_DED_COUNT    -- ����� �ο���
                         , NVL(HA.DISABILITY_DED_AMT, 0) AS DISABILITY_DED_AMT        -- ����� �����ݾ�
                         , NVL(HA.WOMAN_DED_AMT, 0) AS WOMAN_DED_AMT                  -- �γ��� �����ݾ�
                         , NVL(HA.SINGLE_PARENT_DED_AMT, 0) AS SINGLE_PARENT_DED_AMT  -- �Ѻθ���
                         -- ���ݺ���� ����
                         , NVL(HA.NATI_ANNU_AMT, 0) AS NATI_ANNU_AMT                  -- ���ο��ݺ���� ����
                         , NVL(HA.PUBLIC_INSUR_AMT, 0) AS PUBLIC_INSUR_AMT            -- ����������
                         , NVL(HA.MARINE_INSUR_AMT, 0) AS MARINE_INSUR_AMT            -- ���ο��ݺ���
                         , NVL(HA.SCHOOL_STAFF_INSUR_AMT, 0) AS SCHOOL_STAFF_INSUR_AMT  -- �縳�б� ����������
                         , NVL(HA.POST_OFFICE_INSUR_AMT, 0) AS POST_OFFICE_INSUR_AMT    -- ������ü������
                           
                         -- Ư������
                         , NVL(HA.MEDIC_INSUR_AMT, 0) AS MEDIC_INSUR_AMT              -- �ǰ������
                         , NVL(HA.HIRE_INSUR_AMT, 0) AS HIRE_INSUR_AMT                -- ��뺸���
                           
                         , NVL(HA.HOUSE_INTER_AMT, 0) AS HOUSE_INTER_AMT                    -- �����������Աݿ����� ��ȯ�� - ������
                         , NVL(HA.HOUSE_INTER_AMT_ETC, 0) AS HOUSE_INTER_AMT_ETC            -- �����������Աݿ����� ��ȯ�� - ������
                           
                         , NVL(HA.LONG_HOUSE_PROF_AMT, 0) AS LONG_HOUSE_PROF_AMT            -- ��������������Ա����ڻ�ȯ�� 2011�� �������Ժ� 15�� �̸�
                         , NVL(HA.LONG_HOUSE_PROF_AMT_1, 0) AS LONG_HOUSE_PROF_AMT_1        -- ��������������Ա����ڻ�ȯ�� 2011�� �������Ժ� 15~29��
                         , NVL(HA.LONG_HOUSE_PROF_AMT_2, 0) AS LONG_HOUSE_PROF_AMT_2        -- ��������������Ա����ڻ�ȯ�� 2011�� �������Ժ� 30�� �̻�
                         , NVL(HA.LONG_HOUSE_PROF_AMT_3_FIX, 0) AS LONG_HOUSE_PROF_AMT_3_FIX  -- ��������������Ա����ڻ�ȯ�� 2012�� ���� ���Ժ� 15�� �̻� �����ݾ� ��
                         , NVL(HA.LONG_HOUSE_PROF_AMT_3_ETC, 0) AS LONG_HOUSE_PROF_AMT_3_ETC  -- ��������������Ա����ڻ�ȯ�� 2012�� ���� ���Ժ� 15�� �̻� ��Ÿ�����
                         /*, ( NVL(HA.LONG_HOUSE_PROF_AMT, 0) +
                             NVL(HA.LONG_HOUSE_PROF_AMT_1, 0) + NVL(HA.LONG_HOUSE_PROF_AMT_2, 0) +
                             NVL(HA.LONG_HOUSE_PROF_AMT_3_FIX, 0) + NVL(HA.LONG_HOUSE_PROF_AMT_3_ETC, 0)) AS LONG_HOUSE_PROF_SUM_AMT  -- ����������� �հ�*/
                         , NVL(HA.DONAT_NEXT_ALL, 0) + NVL(HA.DONAT_NEXT_50, 0) + NVL(HA.DONAT_NEXT_30, 0) + NVL(HA.DONAT_NEXT_RELIGION_10, 0) + NVL(HA.DONAT_NEXT_10, 0) AS FORWARD_DONATION_AMT            -- ��α�(�̿���)
                           
                        --, NVL(HA.HOUSE_FUND_AMT, 0) AS HOUSE_FUND_AMT                -- �����ڱ� �հ�
                           
                         , ((CASE
                               WHEN NVL(HA.MEDIC_INSUR_AMT, 0) + NVL(HA.HIRE_INSUR_AMT, 0)  < 0 THEN 0
                               ELSE NVL(HA.MEDIC_INSUR_AMT, 0) + NVL(HA.HIRE_INSUR_AMT, 0) 
                             END) +
                             NVL(HA.HOUSE_INTER_AMT, 0) +            -- �����������Աݿ����� ��ȯ�� - ������
                             NVL(HA.HOUSE_INTER_AMT_ETC, 0) +        -- �����������Աݿ����� ��ȯ�� - ������            
                             NVL(HA.LONG_HOUSE_PROF_AMT, 0) +        -- ��������������Ա����ڻ�ȯ�� 2011�� �������Ժ� 15�� �̸�
                             NVL(HA.LONG_HOUSE_PROF_AMT_1, 0) +      -- ��������������Ա����ڻ�ȯ�� 2011�� �������Ժ� 15~29��
                             NVL(HA.LONG_HOUSE_PROF_AMT_2, 0) +      -- ��������������Ա����ڻ�ȯ�� 2011�� �������Ժ� 30�� �̻�
                             NVL(HA.LONG_HOUSE_PROF_AMT_3_FIX, 0) +  -- ��������������Ա����ڻ�ȯ�� 2012�� ���� ���Ժ� 15�� �̻� �����ݾ� ��
                             NVL(HA.LONG_HOUSE_PROF_AMT_3_ETC, 0) +  -- ��������������Ա����ڻ�ȯ�� 2012�� ���� ���Ժ� 15�� �̻� ��Ÿ�����
                             NVL(HA.DONAT_NEXT_ALL, 0) + NVL(HA.DONAT_NEXT_50, 0) + NVL(HA.DONAT_NEXT_30, 0) + NVL(HA.DONAT_NEXT_RELIGION_10, 0) + NVL(HA.DONAT_NEXT_10, 0)-- ��α�(�̿���)
                             ) AS SP_DED_SUM_AMT                       -- Ư���ҵ���� �� 
                                       

                         -- �����ҵ�ݾ�
                         , NVL(HA.SUBT_DED_AMT, 0) AS SUBT_DED_AMT
                         -- �׹��� �ҵ����
                         , NVL(HA.PERS_ANNU_BANK_AMT, 0) AS PERS_ANNU_BANK_AMT        -- ���ο�������ҵ����
                         , NVL(HA.SMALL_CORPOR_DED_AMT, 0) AS SMALL_CORPOR_DED_AMT    -- �ұ��/�һ���� �����α� �ҵ����
                         , NVL(HA.HOUSE_APP_DEPOSIT_AMT, 0) AS HOUSE_APP_DEPOSIT_AMT  -- ����û������
                         , NVL(HA.HOUSE_APP_SAVE_AMT, 0) AS HOUSE_APP_SAVE_AMT        -- ����û����������
                         , NVL(HA.WORKER_HOUSE_SAVE_AMT, 0) AS WORKER_HOUSE_SAVE_AMT  -- �ٷ������ø�������
                         , NVL(HA.INVES_AMT, 0) AS INVES_AMT                          -- �����������ڵ� �ҵ����
                         /*, ( NVL(HA.HOUSE_APP_DEPOSIT_AMT, 0) + NVL(HA.HOUSE_APP_SAVE_AMT, 0) +
                             NVL(HA.HOUSE_SAVE_AMT, 0) + NVL(HA.WORKER_HOUSE_SAVE_AMT, 0)) AS HOUSE_SAVE_SUM_AMT  -- ���ø��� ����ҵ���� �հ�*/
                           
                         , NVL(HA.CREDIT_AMT, 0) AS CREDIT_AMT                        -- �ſ�ī��� �ҵ����
                         , NVL(HA.EMPL_STOCK_AMT, 0) AS EMPL_STOCK_AMT                -- �츮�������ռҵ����
                         , NVL(HA.DONAT_DED_30, 0) AS DONAT_DED_30                    -- �츮�������ձ�α�
                         , NVL(HA.HIRE_KEEP_EMPLOY_AMT, 0) AS HIRE_KEEP_EMPLOY_AMT    -- ��������߼ұ���ٷ���
                         , NVL(HA.FIX_LEASE_DED_AMT, 0) AS FIX_LEASE_DED_AMT          -- �񵷾ȵ�� �������ڻ�ȯ��
                         , NVL(HA.LONG_SET_INVEST_SAVING_AMT, 0) AS LONG_SET_INVEST_SAVING_AMT -- �������������������
                           
                         , ( NVL(HA.PERS_ANNU_BANK_AMT, 0) + NVL(HA.SMALL_CORPOR_DED_AMT, 0) +
                             NVL(HA.HOUSE_APP_DEPOSIT_AMT, 0) + NVL(HA.HOUSE_APP_SAVE_AMT, 0) +
                             NVL(HA.WORKER_HOUSE_SAVE_AMT, 0) + NVL(HA.INVES_AMT, 0) +
                             NVL(HA.CREDIT_AMT, 0) + NVL(HA.EMPL_STOCK_AMT, 0) +
                             NVL(HA.DONAT_DED_30, 0) + NVL(HA.HIRE_KEEP_EMPLOY_AMT, 0) +
                             NVL(HA.FIX_LEASE_DED_AMT, 0) + NVL(HA.LONG_SET_INVEST_SAVING_AMT, 0)) AS ETC_DED_SUM_AMT   -- �׹��� �ҵ���� �հ� �ݾ� --
                         -- Ư������ �����ѵ� �ʰ���
                         , NVL(HA.SP_DED_TOT_AMT, 0) AS SP_DED_TOT_AMT                -- Ư������ �����ѵ� �ʰ���
                         -- ���ռҵ� ����ǥ��
                         , NVL(HA.TAX_STD_AMT, 0) AS TAX_STD_AMT                      -- ���ռҵ� ����ǥ��
                         -- ���⼼��
                         , NVL(HA.COMP_TAX_AMT, 0) AS COMP_TAX_AMT                    -- ���⼼��
                         -- ���װ���
                         , NVL(HA.TAX_REDU_IN_LAW_AMT, 0) AS TAX_REDU_IN_LAW_AMT      -- �ҵ漼��
                         , NVL(HA.TAX_REDU_SP_LAW_AMT, 0) AS TAX_REDU_SP_LAW_AMT      -- ����Ư�� ���ѹ�
                         , NVL(HA.TAX_REDU_SMALL_BUSINESS, 0) AS TAX_REDU_SP_LAW_AMT_1                   -- ����Ư�� ���ѹ� ��30��
                         , NVL(HA.TAX_REDU_TAX_TREATY, 0) AS TAX_REDU_TAX_TREATY      -- ��������
                         , ( NVL(HA.TAX_REDU_IN_LAW_AMT, 0) + NVL(HA.TAX_REDU_SP_LAW_AMT, 0) +
                             NVL(HA.TAX_REDU_TAX_TREATY, 0) + NVL(HA.TAX_REDU_SMALL_BUSINESS, 0)) AS TAX_REDU_SUM_AMT      -- ���װ��� �հ�
                         -- ���װ���
                         , NVL(HA.TAX_DED_INCOME_AMT, 0) AS TAX_DED_INCOME_AMT        -- ����-�ٷμҵ�
                         , 0 AS TD_CHILD_RAISE_DED_CNT  -- ����-�ڳ���� �ο��� 
                         , NVL(HA.TD_CHILD_RAISE_DED_AMT, 0) AS TD_CHILD_RAISE_DED_AMT  -- ����-�ڳ���� �ݾ� 
                         , 0 AS TD_CHILD_6_UNDER_DED_CNT  -- ����-�ڳ� 6������ �ο��� 
                         , 0 AS TD_CHILD_6_UNDER_DED_AMT  -- ����-�ڳ�6������ �ݾ� 
                         , 0 AS TD_BIRTH_DED_CNT                  -- ����-�ڳ� ���/�Ծ� �ο��� 
                         , 0 AS TD_BIRTH_DED_AMT                  -- ����-�ڳ� ���/�Ծ� �ݾ� 
                           
                         , NVL(HA.TD_SCIENTIST_ANNU_AMT, 0) AS TD_SCIENTIST_ANNU_AMT                            -- 2014-���б���� �����ݾ�
                         , NVL(HA.TD_SCIENTIST_ANNU_DED_AMT, 0) AS TD_SCIENTIST_ANNU_DED_AMT                    -- 2014-���б���� ���װ���
                         , NVL(HA.TD_WORKER_RETR_ANNU_AMT, 0) AS TD_WORKER_RETR_ANNU_AMT                        -- 2014-��������  �����ݾ�
                         , NVL(HA.TD_WORKER_RETR_ANNU_DED_AMT, 0) AS TD_WORKER_RETR_ANNU_DED_AMT                -- 2014-�������� ���װ���
                         , NVL(HA.TD_ANNU_BANK_AMT, 0) AS TD_ANNU_BANK_AMT                                      -- 2014-�������� �����ݾ�
                         , NVL(HA.TD_ANNU_BANK_DED_AMT, 0) AS TD_ANNU_BANK_DED_AMT                              -- 2014-�������� ���װ���
                            
                         , ( NVL(HA.TD_GUAR_INSUR_AMT, 0)) AS TD_GUAR_INSUR_AMT                           -- 2014-���� ( ���强���� �����ݾ�)
                         , ( NVL(HA.TD_GUAR_INSUR_DED_AMT, 0)) AS TD_GUAR_INSUR_DED_AMT                   -- 2014-���� ( ���强���� ���װ���)
                            
                         , NVL(HA.TD_MEDIC_AMT, 0) AS TD_MEDIC_AMT                                              -- 2014-���� (�Ƿ�� �����ݾ�)
                         , NVL(HA.TD_MEDIC_DED_AMT, 0) AS TD_MEDIC_DED_AMT                                      -- 2014-���� (�Ƿ�� ���װ���)
                            
                         , NVL(HA.TD_EDUCATION_AMT, 0) AS TD_EDUCATION_AMT                                      -- 2014-���� (������ �����ݾ�)
                         , NVL(HA.TD_EDUCATION_DED_AMT, 0) AS TD_EDUCATION_DED_AMT                              -- 2014-���� (������ ���װ���) 
                            
                         , NVL(HA.TD_POLI_DONAT_AMT1, 0) AS TD_POLI_DONAT_AMT1                                       -- 2014-���� (��ġ�ڱݱ�α�-10��������) �����ݾ�
                         , NVL(HA.TD_POLI_DONAT_DED_AMT1, 0) AS TD_POLI_DONAT_DED_AMT1                                 -- 2014-���� (��ġ�ڱݱ�α�-10��������) ���װ���
                         , NVL(HA.TD_POLI_DONAT_AMT2, 0) AS TD_POLI_DONAT_AMT2                                       -- 2014-���� (��ġ�ڱݱ�α�-10�����ʰ�) �����ݾ�
                         , NVL(HA.TD_POLI_DONAT_DED_AMT2, 0) AS TD_POLI_DONAT_DED_AMT2                                 -- 2014-���� (��ġ�ڱݱ�α�-10��������) ���װ���
                         , NVL(HA.TD_LEGAL_DONAT_AMT, 0) AS TD_LEGAL_DONAT_AMT                                       -- 2014-���� (������α�) �����ݾ�
                         , NVL(HA.TD_LEGAL_DONAT_DED_AMT, 0) AS TD_LEGAL_DONAT_DED_AMT                                 -- 2014-���� (������α�) ���װ���
                         , NVL(HA.TD_DESIGN_DONAT_AMT, 0) AS TD_DESIGN_DONAT_AMT                                    -- 2014-���� (������α�) �����ݾ�
                         , NVL(HA.TD_DESIGN_DONAT_DED_AMT, 0) AS TD_DESIGN_DONAT_DED_AMT                               -- 2014-���� (������α�) ���װ���
                           
                         , ( NVL(HA.TD_GUAR_INSUR_DED_AMT, 0) +
                             NVL(HA.TD_POLI_DONAT_DED_AMT1, 0) + NVL(HA.TD_EDUCATION_DED_AMT, 0) +
                             NVL(HA.TD_POLI_DONAT_DED_AMT1, 0) + NVL(HA.TD_POLI_DONAT_DED_AMT2, 0) +
                             NVL(HA.TD_LEGAL_DONAT_DED_AMT, 0) + NVL(HA.TD_DESIGN_DONAT_DED_AMT, 0)) AS SP_TAX_DED_SUM_AMT      -- Ư�� ����  ���� 
                           
                         , NVL(HA.STAND_DED_AMT, 0) AS STAND_DED_AMT                                 -- ǥ�ؼ��װ��� 
                           
                         , NVL(HA.TAX_DED_TAXGROUP_AMT, 0) AS TAX_DED_TAXGROUP_AMT    -- ���� - ��������
                         , NVL(HA.TAX_DED_HOUSE_DEBT_AMT, 0) AS TAX_DED_HOUSE_DEBT_AMT  -- ���� - �������Ա�
                         , NVL(HA.TAX_DED_OUTSIDE_PAY_AMT, 0) AS TAX_DED_OUTSIDE_PAY_AMT  -- ���� - �ܱ�����
                         , NVL(HA.TD_HOUSE_MONTHLY_AMT, 0) AS TD_HOUSE_MONTHLY_AMT        -- ���� �������� ��� 
                         , NVL(HA.TD_HOUSE_MONTHLY_DED_AMT, 0) AS TD_HOUSE_MONTHLY_DED_AMT   -- ���� �������� ���� 
                           
                         , ( NVL(HA.TAX_DED_INCOME_AMT, 0) + NVL(HA.TD_CHILD_RAISE_DED_AMT, 0) + 
                             NVL(HA.TD_SCIENTIST_ANNU_DED_AMT, 0) + NVL(HA.TD_WORKER_RETR_ANNU_DED_AMT, 0) + 
                             NVL(HA.TD_ANNU_BANK_DED_AMT, 0) + 
                             NVL(HA.TD_GUAR_INSUR_DED_AMT, 0) + 
                             NVL(HA.TD_POLI_DONAT_DED_AMT1, 0) + NVL(HA.TD_EDUCATION_DED_AMT, 0) +
                             NVL(HA.TD_POLI_DONAT_DED_AMT1, 0) + NVL(HA.TD_POLI_DONAT_DED_AMT2, 0) +
                             NVL(HA.TD_LEGAL_DONAT_DED_AMT, 0) + NVL(HA.TD_DESIGN_DONAT_DED_AMT, 0) +
                             NVL(HA.TAX_DED_TAXGROUP_AMT, 0) + NVL(HA.TAX_DED_HOUSE_DEBT_AMT, 0) + 
                             NVL(HA.TAX_DED_OUTSIDE_PAY_AMT, 0) + NVL(HA.TD_HOUSE_MONTHLY_DED_AMT, 0)
                           ) AS TAX_DED_SUM_AMT      -- ���װ��� �հ�
                         , NVL(HA.FIX_TAX_AMT, 0) AS FIX_TAX_AMT                       -- ��������
                         -- ��������
                         , NVL(HA.FIX_IN_TAX_AMT, 0) AS FIX_IN_TAX_AMT        -- ���� �ҵ漼
                         , NVL(HA.FIX_LOCAL_TAX_AMT, 0) AS FIX_LOCAL_TAX_AMT   -- ���� �ֹμ�
                         , NVL(HA.FIX_SP_TAX_AMT, 0) AS FIX_SP_TAX_AMT         -- ���� ��Ư��
                         , ( NVL(HA.FIX_IN_TAX_AMT, 0) +
                             NVL(HA.FIX_LOCAL_TAX_AMT, 0) +
                             NVL(HA.FIX_SP_TAX_AMT, 0)) AS FIX_TAX_SUM_AMT     -- ���� ���� �հ�
                         -- (����) �ⳳ�� ����
                         , NVL(HPW1.IN_TAX_AMT, 0) AS PRE_IN_TAX_AMT           -- (����) �ҵ漼 �հ�
                         , NVL(HPW1.LOCAL_TAX_AMT, 0) AS PRE_LOCAL_TAX_AMT     -- (����) �ֹμ� �հ�
                         , NVL(HPW1.SP_TAX_AMT, 0) AS PRE_SP_TAX_AMT           -- (����) ��Ư�� �հ�
                         , ( NVL(HPW1.IN_TAX_AMT, 0) +
                             NVL(HPW1.LOCAL_TAX_AMT, 0) +
                             NVL(HPW1.SP_TAX_AMT, 0)) AS PRE_TAX_SUM_AMT       -- (����) ���� �հ�
                         -- (����) �ⳳ�� ����
                         , ( NVL(HA.PRE_IN_TAX_AMT, 0) -
                             NVL(HPW1.IN_TAX_AMT, 0)) AS NOW_IN_TAX_AMT        -- (����) �ҵ漼
                         , ( NVL(HA.PRE_LOCAL_TAX_AMT, 0) -
                             NVL(HPW1.LOCAL_TAX_AMT, 0)) AS NOW_LOCAL_TAX_AMT  -- (����) �ֹμ�
                         , ( NVL(HA.PRE_SP_TAX_AMT, 0) -
                             NVL(HPW1.SP_TAX_AMT, 0)) AS NOW_SP_TAX_AMT        -- (����) ��Ư��
                         , ( NVL(HA.PRE_IN_TAX_AMT, 0) - NVL(HPW1.IN_TAX_AMT, 0) +
                             NVL(HA.PRE_LOCAL_TAX_AMT, 0) - NVL(HPW1.LOCAL_TAX_AMT, 0) +
                             NVL(HA.PRE_SP_TAX_AMT, 0) - NVL(HPW1.SP_TAX_AMT, 0)) AS NOW_TAX_SUM_AMT  -- (����) ���� �հ�
                         -- ���� ����
                         , NVL(HA.SUBT_IN_TAX_AMT, 0) AS SUBT_IN_TAX_AMT       -- (����) �ҵ漼
                         , NVL(HA.SUBT_LOCAL_TAX_AMT, 0) AS SUBT_LOCAL_TAX_AMT -- (����) �ֹμ�
                         , NVL(HA.SUBT_SP_TAX_AMT, 0) AS SUBT_SP_TAX_AMT       -- (����) ��Ư��
                         , ( NVL(HA.SUBT_IN_TAX_AMT, 0) +
                             NVL(HA.SUBT_LOCAL_TAX_AMT, 0) +
                             NVL(HA.SUBT_SP_TAX_AMT, 0)) AS SUBT_TAX_SUM_AMT   -- (����) ���� �հ�          
                         -- ����� �հ�
                         , ( NVL(HA.NONTAX_OUTSIDE_AMT, 0) + NVL(HA.NONTAX_OT_AMT, 0) +  -- NONTAX_OUTSIDE_AMT : ����� ���ܱٷ� �հ�
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
                             -- ����--
                             NVL(HA.PRE_NT_OUTSIDE_AMT, 0) + NVL(HA.PRE_NT_OT_AMT, 0) +  -- NONTAX_OUTSIDE_AMT : ����� ���ܱٷ� �հ�
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
                             NVL(HA.PRE_NT_HOUSE_SUBSIDY_AMT, 0) + NVL(HA.PRE_NT_SEA_RESOURCE_AMT, 0)) AS NONTAX_TOT_AMT  -- ����� �հ�
                         -- ����� ��
                         , (NVL(HA.NONTAX_OUTSIDE_AMT, 0) + NVL(HA.PRE_NT_OUTSIDE_AMT, 0)) AS NONTAX_OUTSIDE_AMT -- ����� ���ܱٷ� �հ�
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
                         , ( -- ���� ���� ����
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
                         , (-- ���� �λ系��.
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
                             NVL(HA.NOW_EMPLOYEE_STOCK_AMT, 0) + NVL(HA.NOW_OFFICE_RETIRE_OVER_AMT, 0)) AS NOW_SUM_PAY  -- ����
                         , ( NVL(HA.PRE_PAY_TOT_AMT, 0) + NVL(HA.PRE_BONUS_TOT_AMT, 0) +
                             NVL(HA.PRE_ADD_BONUS_AMT, 0) + NVL(HA.PRE_STOCK_BENE_AMT, 0) +
                             NVL(HA.PRE_EMPLOYEE_STOCK_AMT, 0) + NVL(HA.PRE_OFFICE_RETIRE_OVER_AMT, 0)) AS PRE_SUM_PAY  -- ����
                         , NVL(HA.INCOME_TOT_AMT, 0) AS TOTAL_PAY         -- �ѱ޿�
                         , NVL(HA.INCOME_DED_AMT, 0) AS INCOME_DED_AMT    -- �ٷμҵ����
                         , ( NVL(HA.INCOME_TOT_AMT, 0) - NVL(HA.INCOME_DED_AMT, 0)) AS INCOME_AMT  -- �ٷμҵ�ݾ�
                         -- ��������
                         , NVL(HA.PER_DED_AMT, 0) AS PER_DED_AMT                      -- ����
                         , NVL(HA.SPOUSE_DED_AMT, 0) AS SPOUSE_DED_AMT                -- �����
                         , NVL(HA.SUPP_DED_COUNT, 0) AS SUPP_DED_COUNT                -- �ξ簡�� �ο���
                         , NVL(HA.SUPP_DED_AMT, 0) AS SUPP_DED_AMT                    -- �ξ簡�� �����ݾ�
                         , NVL(HA.OLD_DED_COUNT1, 0) AS OLD_DED_COUNT1                -- ��ο�� �ο���
                         , NVL(HA.OLD_DED_AMT1, 0) AS OLD_DED_AMT1                    -- ��ο�� �����ݾ�
                         , NVL(HA.DISABILITY_DED_COUNT, 0) AS DISABILITY_DED_COUNT    -- ����� �ο���
                         , NVL(HA.DISABILITY_DED_AMT, 0) AS DISABILITY_DED_AMT        -- ����� �����ݾ�
                         , NVL(HA.WOMAN_DED_AMT, 0) AS WOMAN_DED_AMT                  -- �γ��� �����ݾ�
                         , NVL(HA.SINGLE_PARENT_DED_AMT, 0) AS SINGLE_PARENT_DED_AMT  -- �Ѻθ���
                         -- ���ݺ���� ����
                         , NVL(HA.NATI_ANNU_AMT, 0) AS NATI_ANNU_AMT                  -- ���ο��ݺ���� ����
                         , NVL(HA.PUBLIC_INSUR_AMT, 0) AS PUBLIC_INSUR_AMT            -- ����������
                         , NVL(HA.MARINE_INSUR_AMT, 0) AS MARINE_INSUR_AMT            -- ���ο��ݺ���
                         , NVL(HA.SCHOOL_STAFF_INSUR_AMT, 0) AS SCHOOL_STAFF_INSUR_AMT  -- �縳�б� ����������
                         , NVL(HA.POST_OFFICE_INSUR_AMT, 0) AS POST_OFFICE_INSUR_AMT    -- ������ü������
                           
                         -- Ư������
                         , NVL(HA.MEDIC_INSUR_AMT, 0) AS MEDIC_INSUR_AMT              -- �ǰ������
                         , NVL(HA.HIRE_INSUR_AMT, 0) AS HIRE_INSUR_AMT                -- ��뺸���
                           
                         , NVL(HA.HOUSE_INTER_AMT, 0) AS HOUSE_INTER_AMT                    -- �����������Աݿ����� ��ȯ�� - ������
                         , NVL(HA.HOUSE_INTER_AMT_ETC, 0) AS HOUSE_INTER_AMT_ETC            -- �����������Աݿ����� ��ȯ�� - ������
                           
                         , NVL(HA.LONG_HOUSE_PROF_AMT, 0) AS LONG_HOUSE_PROF_AMT            -- ��������������Ա����ڻ�ȯ�� 2011�� �������Ժ� 15�� �̸�
                         , NVL(HA.LONG_HOUSE_PROF_AMT_1, 0) AS LONG_HOUSE_PROF_AMT_1        -- ��������������Ա����ڻ�ȯ�� 2011�� �������Ժ� 15~29��
                         , NVL(HA.LONG_HOUSE_PROF_AMT_2, 0) AS LONG_HOUSE_PROF_AMT_2        -- ��������������Ա����ڻ�ȯ�� 2011�� �������Ժ� 30�� �̻�
                         , NVL(HA.LONG_HOUSE_PROF_AMT_3_FIX, 0) AS LONG_HOUSE_PROF_AMT_3_FIX  -- ��������������Ա����ڻ�ȯ�� 2012�� ���� ���Ժ� 15�� �̻� �����ݾ� ��
                         , NVL(HA.LONG_HOUSE_PROF_AMT_3_ETC, 0) AS LONG_HOUSE_PROF_AMT_3_ETC  -- ��������������Ա����ڻ�ȯ�� 2012�� ���� ���Ժ� 15�� �̻� ��Ÿ�����
                         /*, ( NVL(HA.LONG_HOUSE_PROF_AMT, 0) +
                             NVL(HA.LONG_HOUSE_PROF_AMT_1, 0) + NVL(HA.LONG_HOUSE_PROF_AMT_2, 0) +
                             NVL(HA.LONG_HOUSE_PROF_AMT_3_FIX, 0) + NVL(HA.LONG_HOUSE_PROF_AMT_3_ETC, 0)) AS LONG_HOUSE_PROF_SUM_AMT  -- ����������� �հ�*/
                         , NVL(HA.DONAT_NEXT_ALL, 0) + NVL(HA.DONAT_NEXT_50, 0) + NVL(HA.DONAT_NEXT_30, 0) + NVL(HA.DONAT_NEXT_RELIGION_10, 0) + NVL(HA.DONAT_NEXT_10, 0) AS FORWARD_DONATION_AMT            -- ��α�(�̿���)
                           
                        --, NVL(HA.HOUSE_FUND_AMT, 0) AS HOUSE_FUND_AMT                -- �����ڱ� �հ�
                           
                         , ((CASE
                               WHEN NVL(HA.MEDIC_INSUR_AMT, 0) + NVL(HA.HIRE_INSUR_AMT, 0)  < 0 THEN 0
                               ELSE NVL(HA.MEDIC_INSUR_AMT, 0) + NVL(HA.HIRE_INSUR_AMT, 0) 
                             END) +
                             NVL(HA.HOUSE_INTER_AMT, 0) +            -- �����������Աݿ����� ��ȯ�� - ������
                             NVL(HA.HOUSE_INTER_AMT_ETC, 0) +        -- �����������Աݿ����� ��ȯ�� - ������            
                             NVL(HA.LONG_HOUSE_PROF_AMT, 0) +        -- ��������������Ա����ڻ�ȯ�� 2011�� �������Ժ� 15�� �̸�
                             NVL(HA.LONG_HOUSE_PROF_AMT_1, 0) +      -- ��������������Ա����ڻ�ȯ�� 2011�� �������Ժ� 15~29��
                             NVL(HA.LONG_HOUSE_PROF_AMT_2, 0) +      -- ��������������Ա����ڻ�ȯ�� 2011�� �������Ժ� 30�� �̻�
                             NVL(HA.LONG_HOUSE_PROF_AMT_3_FIX, 0) +  -- ��������������Ա����ڻ�ȯ�� 2012�� ���� ���Ժ� 15�� �̻� �����ݾ� ��
                             NVL(HA.LONG_HOUSE_PROF_AMT_3_ETC, 0) +  -- ��������������Ա����ڻ�ȯ�� 2012�� ���� ���Ժ� 15�� �̻� ��Ÿ�����
                             NVL(HA.DONAT_NEXT_ALL, 0) + NVL(HA.DONAT_NEXT_50, 0) + NVL(HA.DONAT_NEXT_30, 0) + NVL(HA.DONAT_NEXT_RELIGION_10, 0) + NVL(HA.DONAT_NEXT_10, 0)-- ��α�(�̿���)
                             ) AS SP_DED_SUM_AMT                       -- Ư���ҵ���� �� 
                                       

                         -- �����ҵ�ݾ�
                         , NVL(HA.SUBT_DED_AMT, 0) AS SUBT_DED_AMT
                         -- �׹��� �ҵ����
                         , NVL(HA.PERS_ANNU_BANK_AMT, 0) AS PERS_ANNU_BANK_AMT        -- ���ο�������ҵ����
                         , NVL(HA.SMALL_CORPOR_DED_AMT, 0) AS SMALL_CORPOR_DED_AMT    -- �ұ��/�һ���� �����α� �ҵ����
                         , NVL(HA.HOUSE_APP_DEPOSIT_AMT, 0) AS HOUSE_APP_DEPOSIT_AMT  -- ����û������
                         , NVL(HA.HOUSE_APP_SAVE_AMT, 0) AS HOUSE_APP_SAVE_AMT        -- ����û����������
                         , NVL(HA.WORKER_HOUSE_SAVE_AMT, 0) AS WORKER_HOUSE_SAVE_AMT  -- �ٷ������ø�������
                         , NVL(HA.INVES_AMT, 0) AS INVES_AMT                          -- �����������ڵ� �ҵ����
                         /*, ( NVL(HA.HOUSE_APP_DEPOSIT_AMT, 0) + NVL(HA.HOUSE_APP_SAVE_AMT, 0) +
                             NVL(HA.HOUSE_SAVE_AMT, 0) + NVL(HA.WORKER_HOUSE_SAVE_AMT, 0)) AS HOUSE_SAVE_SUM_AMT  -- ���ø��� ����ҵ���� �հ�*/
                           
                         , NVL(HA.CREDIT_AMT, 0) AS CREDIT_AMT                        -- �ſ�ī��� �ҵ����
                         , NVL(HA.EMPL_STOCK_AMT, 0) AS EMPL_STOCK_AMT                -- �츮�������ռҵ����
                         , NVL(HA.DONAT_DED_30, 0) AS DONAT_DED_30                    -- �츮�������ձ�α�
                         , NVL(HA.HIRE_KEEP_EMPLOY_AMT, 0) AS HIRE_KEEP_EMPLOY_AMT    -- ��������߼ұ���ٷ���
                         , NVL(HA.FIX_LEASE_DED_AMT, 0) AS FIX_LEASE_DED_AMT          -- �񵷾ȵ�� �������ڻ�ȯ��
                         , NVL(HA.LONG_SET_INVEST_SAVING_AMT, 0) AS LONG_SET_INVEST_SAVING_AMT -- �������������������
                           
                         , ( NVL(HA.PERS_ANNU_BANK_AMT, 0) + NVL(HA.SMALL_CORPOR_DED_AMT, 0) +
                             NVL(HA.HOUSE_APP_DEPOSIT_AMT, 0) + NVL(HA.HOUSE_APP_SAVE_AMT, 0) +
                             NVL(HA.WORKER_HOUSE_SAVE_AMT, 0) + NVL(HA.INVES_AMT, 0) +
                             NVL(HA.CREDIT_AMT, 0) + NVL(HA.EMPL_STOCK_AMT, 0) +
                             NVL(HA.DONAT_DED_30, 0) + NVL(HA.HIRE_KEEP_EMPLOY_AMT, 0) +
                             NVL(HA.FIX_LEASE_DED_AMT, 0) + NVL(HA.LONG_SET_INVEST_SAVING_AMT, 0)) AS ETC_DED_SUM_AMT   -- �׹��� �ҵ���� �հ� �ݾ� --
                         -- Ư������ �����ѵ� �ʰ���
                         , NVL(HA.SP_DED_TOT_AMT, 0) AS SP_DED_TOT_AMT                -- Ư������ �����ѵ� �ʰ���
                         -- ���ռҵ� ����ǥ��
                         , NVL(HA.TAX_STD_AMT, 0) AS TAX_STD_AMT                      -- ���ռҵ� ����ǥ��
                         -- ���⼼��
                         , NVL(HA.COMP_TAX_AMT, 0) AS COMP_TAX_AMT                    -- ���⼼��
                         -- ���װ���
                         , NVL(HA.TAX_REDU_IN_LAW_AMT, 0) AS TAX_REDU_IN_LAW_AMT      -- �ҵ漼��
                         , NVL(HA.TAX_REDU_SP_LAW_AMT, 0) AS TAX_REDU_SP_LAW_AMT      -- ����Ư�� ���ѹ�
                         , NVL(HA.TAX_REDU_SMALL_BUSINESS, 0) AS TAX_REDU_SP_LAW_AMT_1                   -- ����Ư�� ���ѹ� ��30��
                         , NVL(HA.TAX_REDU_TAX_TREATY, 0) AS TAX_REDU_TAX_TREATY      -- ��������
                         , ( NVL(HA.TAX_REDU_IN_LAW_AMT, 0) + NVL(HA.TAX_REDU_SP_LAW_AMT, 0) +
                             NVL(HA.TAX_REDU_TAX_TREATY, 0) + NVL(HA.TAX_REDU_SMALL_BUSINESS, 0)) AS TAX_REDU_SUM_AMT      -- ���װ��� �հ�
                         -- ���װ���
                         , NVL(HA.TAX_DED_INCOME_AMT, 0) AS TAX_DED_INCOME_AMT        -- ����-�ٷμҵ�
                         , NVL(HA.TD_CHILD_RAISE_DED_CNT, 0) AS TD_CHILD_RAISE_DED_CNT  -- ����-�ڳ���� �ο��� 
                         , NVL(HA.TD_CHILD_RAISE_DED_AMT, 0) AS TD_CHILD_RAISE_DED_AMT  -- ����-�ڳ���� �ݾ� 
                         , NVL(HA.TD_CHILD_6_UNDER_DED_CNT, 0) AS TD_CHILD_6_UNDER_DED_CNT  -- ����-�ڳ� 6������ �ο��� 
                         , NVL(HA.TD_CHILD_6_UNDER_DED_AMT, 0) AS TD_CHILD_6_UNDER_DED_AMT  -- ����-�ڳ�6������ �ݾ� 
                         , NVL(HA.TD_BIRTH_DED_CNT, 0) AS TD_BIRTH_DED_CNT                  -- ����-�ڳ� ���/�Ծ� �ο��� 
                         , NVL(HA.TD_BIRTH_DED_AMT, 0) AS TD_BIRTH_DED_AMT                  -- ����-�ڳ� ���/�Ծ� �ݾ� 
                           
                         , NVL(HA.TD_SCIENTIST_ANNU_AMT, 0) AS TD_SCIENTIST_ANNU_AMT                            -- 2014-���б���� �����ݾ�
                         , NVL(HA.TD_SCIENTIST_ANNU_DED_AMT, 0) AS TD_SCIENTIST_ANNU_DED_AMT                    -- 2014-���б���� ���װ���
                         , NVL(HA.TD_WORKER_RETR_ANNU_AMT, 0) AS TD_WORKER_RETR_ANNU_AMT                        -- 2014-��������  �����ݾ�
                         , NVL(HA.TD_WORKER_RETR_ANNU_DED_AMT, 0) AS TD_WORKER_RETR_ANNU_DED_AMT                -- 2014-�������� ���װ���
                         , NVL(HA.TD_ANNU_BANK_AMT, 0) AS TD_ANNU_BANK_AMT                                      -- 2014-�������� �����ݾ�
                         , NVL(HA.TD_ANNU_BANK_DED_AMT, 0) AS TD_ANNU_BANK_DED_AMT                              -- 2014-�������� ���װ���
                            
                         , ( NVL(HA.TD_GUAR_INSUR_AMT, 0) + 
                             NVL(HA.TD_DISABILITY_INSUR_AMT, 0)) AS TD_GUAR_INSUR_AMT                           -- 2014-���� ( ���强���� �����ݾ�)
                         , ( NVL(HA.TD_GUAR_INSUR_DED_AMT, 0) + 
                             NVL(HA.TD_DISABILITY_INSUR_DED_AMT, 0)) AS TD_GUAR_INSUR_DED_AMT                   -- 2014-���� ( ���强���� ���װ���)
                            
                         , NVL(HA.TD_MEDIC_AMT, 0) AS TD_MEDIC_AMT                                              -- 2014-���� (�Ƿ�� �����ݾ�)
                         , NVL(HA.TD_MEDIC_DED_AMT, 0) AS TD_MEDIC_DED_AMT                                      -- 2014-���� (�Ƿ�� ���װ���)
                            
                         , NVL(HA.TD_EDUCATION_AMT, 0) AS TD_EDUCATION_AMT                                      -- 2014-���� (������ �����ݾ�)
                         , NVL(HA.TD_EDUCATION_DED_AMT, 0) AS TD_EDUCATION_DED_AMT                              -- 2014-���� (������ ���װ���) 
                            
                         , NVL(HA.TD_POLI_DONAT_AMT1, 0) AS TD_POLI_DONAT_AMT1                                       -- 2014-���� (��ġ�ڱݱ�α�-10��������) �����ݾ�
                         , NVL(HA.TD_POLI_DONAT_DED_AMT1, 0) AS TD_POLI_DONAT_DED_AMT1                                 -- 2014-���� (��ġ�ڱݱ�α�-10��������) ���װ���
                         , NVL(HA.TD_POLI_DONAT_AMT2, 0) AS TD_POLI_DONAT_AMT2                                       -- 2014-���� (��ġ�ڱݱ�α�-10�����ʰ�) �����ݾ�
                         , NVL(HA.TD_POLI_DONAT_DED_AMT2, 0) AS TD_POLI_DONAT_DED_AMT2                                 -- 2014-���� (��ġ�ڱݱ�α�-10��������) ���װ���
                         , NVL(HA.TD_LEGAL_DONAT_AMT, 0) AS TD_LEGAL_DONAT_AMT                                       -- 2014-���� (������α�) �����ݾ�
                         , NVL(HA.TD_LEGAL_DONAT_DED_AMT, 0) AS TD_LEGAL_DONAT_DED_AMT                                 -- 2014-���� (������α�) ���װ���
                         , NVL(HA.TD_DESIGN_DONAT_AMT, 0) AS TD_DESIGN_DONAT_AMT                                    -- 2014-���� (������α�) �����ݾ�
                         , NVL(HA.TD_DESIGN_DONAT_DED_AMT, 0) AS TD_DESIGN_DONAT_DED_AMT                               -- 2014-���� (������α�) ���װ���
                           
                         , ( NVL(HA.TD_GUAR_INSUR_DED_AMT, 0) + NVL(HA.TD_DISABILITY_INSUR_DED_AMT, 0) + 
                             NVL(HA.TD_POLI_DONAT_DED_AMT1, 0) + NVL(HA.TD_EDUCATION_DED_AMT, 0) +
                             NVL(HA.TD_POLI_DONAT_DED_AMT1, 0) + NVL(HA.TD_POLI_DONAT_DED_AMT2, 0) +
                             NVL(HA.TD_LEGAL_DONAT_DED_AMT, 0) + NVL(HA.TD_DESIGN_DONAT_DED_AMT, 0)) AS SP_TAX_DED_SUM_AMT      -- Ư�� ����  ���� 
                           
                         , NVL(HA.STAND_DED_AMT, 0) AS STAND_DED_AMT                                 -- ǥ�ؼ��װ��� 
                           
                         , NVL(HA.TAX_DED_TAXGROUP_AMT, 0) AS TAX_DED_TAXGROUP_AMT    -- ���� - ��������
                         , NVL(HA.TAX_DED_HOUSE_DEBT_AMT, 0) AS TAX_DED_HOUSE_DEBT_AMT  -- ���� - �������Ա�
                         , NVL(HA.TAX_DED_OUTSIDE_PAY_AMT, 0) AS TAX_DED_OUTSIDE_PAY_AMT  -- ���� - �ܱ�����
                         , NVL(HA.TD_HOUSE_MONTHLY_AMT, 0) AS TD_HOUSE_MONTHLY_AMT        -- ���� �������� ��� 
                         , NVL(HA.TD_HOUSE_MONTHLY_DED_AMT, 0) AS TD_HOUSE_MONTHLY_DED_AMT   -- ���� �������� ���� 
                           
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
                           ) AS TAX_DED_SUM_AMT      -- ���װ��� �հ�
                         , NVL(HA.FIX_TAX_AMT, 0) AS FIX_TAX_AMT                       -- ��������
                         -- ��������
                         , NVL(HA.FIX_IN_TAX_AMT, 0) AS FIX_IN_TAX_AMT        -- ���� �ҵ漼
                         , NVL(HA.FIX_LOCAL_TAX_AMT, 0) AS FIX_LOCAL_TAX_AMT   -- ���� �ֹμ�
                         , NVL(HA.FIX_SP_TAX_AMT, 0) AS FIX_SP_TAX_AMT         -- ���� ��Ư��
                         , ( NVL(HA.FIX_IN_TAX_AMT, 0) +
                             NVL(HA.FIX_LOCAL_TAX_AMT, 0) +
                             NVL(HA.FIX_SP_TAX_AMT, 0)) AS FIX_TAX_SUM_AMT     -- ���� ���� �հ�
                         -- (����) �ⳳ�� ����
                         , NVL(HPW1.IN_TAX_AMT, 0) AS PRE_IN_TAX_AMT           -- (����) �ҵ漼 �հ�
                         , NVL(HPW1.LOCAL_TAX_AMT, 0) AS PRE_LOCAL_TAX_AMT     -- (����) �ֹμ� �հ�
                         , NVL(HPW1.SP_TAX_AMT, 0) AS PRE_SP_TAX_AMT           -- (����) ��Ư�� �հ�
                         , ( NVL(HPW1.IN_TAX_AMT, 0) +
                             NVL(HPW1.LOCAL_TAX_AMT, 0) +
                             NVL(HPW1.SP_TAX_AMT, 0)) AS PRE_TAX_SUM_AMT       -- (����) ���� �հ�
                         -- (����) �ⳳ�� ����
                         , ( NVL(HA.PRE_IN_TAX_AMT, 0) -
                             NVL(HPW1.IN_TAX_AMT, 0)) AS NOW_IN_TAX_AMT        -- (����) �ҵ漼
                         , ( NVL(HA.PRE_LOCAL_TAX_AMT, 0) -
                             NVL(HPW1.LOCAL_TAX_AMT, 0)) AS NOW_LOCAL_TAX_AMT  -- (����) �ֹμ�
                         , ( NVL(HA.PRE_SP_TAX_AMT, 0) -
                             NVL(HPW1.SP_TAX_AMT, 0)) AS NOW_SP_TAX_AMT        -- (����) ��Ư��
                         , ( NVL(HA.PRE_IN_TAX_AMT, 0) - NVL(HPW1.IN_TAX_AMT, 0) +
                             NVL(HA.PRE_LOCAL_TAX_AMT, 0) - NVL(HPW1.LOCAL_TAX_AMT, 0) +
                             NVL(HA.PRE_SP_TAX_AMT, 0) - NVL(HPW1.SP_TAX_AMT, 0)) AS NOW_TAX_SUM_AMT  -- (����) ���� �հ�
                         -- ���� ����
                         , NVL(HA.SUBT_IN_TAX_AMT, 0) AS SUBT_IN_TAX_AMT       -- (����) �ҵ漼
                         , NVL(HA.SUBT_LOCAL_TAX_AMT, 0) AS SUBT_LOCAL_TAX_AMT -- (����) �ֹμ�
                         , NVL(HA.SUBT_SP_TAX_AMT, 0) AS SUBT_SP_TAX_AMT       -- (����) ��Ư��
                         , ( NVL(HA.SUBT_IN_TAX_AMT, 0) +
                             NVL(HA.SUBT_LOCAL_TAX_AMT, 0) +
                             NVL(HA.SUBT_SP_TAX_AMT, 0)) AS SUBT_TAX_SUM_AMT   -- (����) ���� �հ�          
                         -- ����� �հ�
                         , ( NVL(HA.NONTAX_OUTSIDE_AMT, 0) + NVL(HA.NONTAX_OT_AMT, 0) +  -- NONTAX_OUTSIDE_AMT : ����� ���ܱٷ� �հ�
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
                             -- ����--
                             NVL(HA.PRE_NT_OUTSIDE_AMT, 0) + NVL(HA.PRE_NT_OT_AMT, 0) +  -- NONTAX_OUTSIDE_AMT : ����� ���ܱٷ� �հ�
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
                             NVL(HA.PRE_NT_HOUSE_SUBSIDY_AMT, 0) + NVL(HA.PRE_NT_SEA_RESOURCE_AMT, 0)) AS NONTAX_TOT_AMT  -- ����� �հ�
                         -- ����� ��
                         , (NVL(HA.NONTAX_OUTSIDE_AMT, 0) + NVL(HA.PRE_NT_OUTSIDE_AMT, 0)) AS NONTAX_OUTSIDE_AMT -- ����� ���ܱٷ� �հ�
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
                         , ( -- ���� ���� ����
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
                         , (-- ���� �λ系��.
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
-- �������� ���� �� ��ȸ : ������ ���� 
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

            , ( NVL(HA.NONTAX_OUTSIDE_AMT, 0) + NVL(HA.NONTAX_OT_AMT, 0) +    -- NONTAX_OUTSIDE_AMT : ����� ���ܱٷ� �հ�
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
                -- ����--
                NVL(HA.PRE_NT_OUTSIDE_AMT, 0) + NVL(HA.PRE_NT_OT_AMT, 0) +   -- NONTAX_OUTSIDE_AMT : ����� ���ܱٷ� �հ�
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

            , NVL(HA.FIX_IN_TAX_AMT, 0) AS N_FIX_IN_TAX_AMT  -- ������ ����.
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
                WHEN PM.RETIRE_DATE IS NULL THEN '��ӱٹ�'
                WHEN TO_DATE(V_YEAR_YYYY || '12-31', 'YYYY-MM-DD') < PM.RETIRE_DATE THEN '��ӱٹ�'
                ELSE '�ߵ����'
              END AS EMPLOYEE_TYPE
            , PM.RETIRE_DATE
        FROM HRA_YEAR_ADJUSTMENT HA
           , HRM_PERSON_MASTER   PM
           , ( -- ���� ó�� ���� --
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
           , (-- ���� �λ系��.
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
-- 2014 �������� ��� SELECT.
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
               -- �����
               NVL(HA.NONTAX_OUTSIDE_AMT, 0) + NVL(HA.NONTAX_OT_AMT, 0) +   -- NONTAX_OUTSIDE_AMT : ����� ���ܱٷ� �հ�
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
               -- ����--
               NVL(HA.PRE_NT_OUTSIDE_AMT, 0) + NVL(HA.PRE_NT_OT_AMT, 0) +   -- NONTAX_OUTSIDE_AMT : ����� ���ܱٷ� �հ�
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
               NVL(HA.PRE_NT_HOUSE_SUBSIDY_AMT, 0) + NVL(HA.PRE_NT_SEA_RESOURCE_AMT, 0)) AS TOTAL_PAY   -- �ٷμҵ�(���� + �����) --
           , NVL(HA.NONTAX_OUTSIDE_AMT, 0) AS NONTAX_OUTSIDE_AMT
           , NVL(HA.NONTAX_OT_AMT, 0) AS NONTAX_OT_AMT
           , NVL(HA.NONTAX_RESEA_AMT, 0) AS NONTAX_RESEA_AMT
           , NVL(HA.NONTAX_ETC_AMT, 0) AS NONTAX_ETC_AMT
           , NVL(HA.NONTAX_BIRTH_AMT, 0) AS NONTAX_BIRTH_AMT
           , NVL(HA.NONTAX_FOREIGNER_AMT, 0) AS NONTAX_FOREIGNER_AMT
           , ( NVL(HA.NONTAX_OUTSIDE_AMT, 0) + NVL(HA.NONTAX_OT_AMT, 0) +  -- NONTAX_OUTSIDE_AMT : ����� ���ܱٷ� �հ�
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
               -- ����--
               NVL(HA.PRE_NT_OUTSIDE_AMT, 0) + NVL(HA.PRE_NT_OT_AMT, 0) +   -- NONTAX_OUTSIDE_AMT : ����� ���ܱٷ� �հ�
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
           , NVL(HA.INCOME_TOT_AMT, 0) AS INCOME_TOT_AMT  -- �ѱ޿� --
           , NVL(HA.INCOME_DED_AMT, 0) AS INCOME_DED_AMT  -- �ٷμҵ� ���� --
           , (NVL(HA.INCOME_TOT_AMT, 0) - NVL(HA.INCOME_DED_AMT, 0)) AS INCOME_AMT  -- �ٷμҵ� �ݾ� --
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
           , NVL(HA.NATI_ANNU_AMT, 0) AS NATI_ANNU_AMT          -- ���ο��� --
           , NVL(HA.ANNU_INSUR_AMT, 0) AS ANNU_INSUR_AMT        -- ���ݺ���� �հ� --
           , NVL(HA.MEDIC_INSUR_AMT, 0) AS MEDIC_INSUR_AMT      -- �ǰ�����(�ǰ� + ����纸��)
           , NVL(HA.HIRE_INSUR_AMT, 0) AS HIRE_INSUR_AMT        -- ��뺸��
           , NVL(HA.GUAR_INSUR_AMT, 0) AS GUAR_INSUR_AMT        -- ���庸��
           , NVL(HA.DISABILITY_INSUR_AMT, 0) AS DISABILITY_INSUR_AMT  -- ����κ���
             -- ����� �ݾ��� ������ ��쿡�� 0�� ���(�������� �����ä ��Ŀ� -���� ���� ����);
           , ( CASE
                 WHEN NVL(HA.MEDIC_INSUR_AMT, 0) + NVL(HA.HIRE_INSUR_AMT, 0) +
                      NVL(HA.GUAR_INSUR_AMT, 0) + NVL(HA.DISABILITY_INSUR_AMT, 0) < 0 THEN 0
                 ELSE NVL(HA.MEDIC_INSUR_AMT, 0) + NVL(HA.HIRE_INSUR_AMT, 0) +
                      NVL(HA.GUAR_INSUR_AMT, 0) + NVL(HA.DISABILITY_INSUR_AMT, 0)
               END) AS ETC_INSURE_AMT  -- ��Ÿ����� �հ� --
           , NVL(HA.MEDIC_AMT, 0) AS MEDIC_AMT  -- �Ƿ�� �հ� (����� + ��Ÿ)
           , NVL(HA.EDUCATION_AMT, 0) AS EDUCATION_AMT  -- ������(����� + ��Ÿ)
           , (NVL(HA.HOUSE_INTER_AMT, 0) + NVL(HA.HOUSE_INTER_AMT_ETC, 0)) AS HOUSE_INTER_AMT  -- �����������Ա� ������ + ������
           , NVL(HA.HOUSE_FUND_AMT, 0) AS HOUSE_FUND_AMT
           , NVL(HA.DONAT_DED_ALL, 0) + NVL(HA.DONAT_DED_50, 0) +  
             NVL(HA.DONAT_DED_RELIGION_10, 0) + NVL(HA.DONAT_DED_10, 0) AS DONAT_AMT      -- 2014-Ư���ҵ����(��α��̿���)
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
               END) -- �����ڱ�(�����������Ա� + ������ + ��������������Ա� )
              ) AS SP_DED_SUM  -- Ư������ �հ� --                                                                                                                       
           , NVL(HA.STAND_DED_AMT, 0) AS STAND_DED_AMT  -- ǥ�ذ���   --
           , NVL(HA.SUBT_DED_AMT, 0) AS SUBT_DED_AMT    -- �����ҵ�ݾ� --
           
           , NVL(HA.PERS_ANNU_BANK_AMT, 0) AS PERS_ANNU_BANK_AMT  -- ���ο��� 
           --, NVL(HA.ANNU_BANK_AMT, 0) AS ANNU_BANK_AMT  -- 2014-���װ��� �̵� 
           , NVL(HA.INVES_AMT, 0) AS INVES_AMT            -- �������� 
           , NVL(HA.FORE_INCOME_AMT, 0) AS FORE_INCOME_AMT  -- �ܱ� �ٷ��� �ҵ� --
           , NVL(HA.CREDIT_AMT, 0) AS CREDIT_AMT            -- �ſ�ī�� 
           --, NVL(HA.RETR_ANNU_AMT, 0) AS RETR_ANNU_AMT    -- 2014-���װ��� �̵� 
           , NVL(HA.EMPL_STOCK_AMT, 0) AS EMPL_STOCK_AMT
           , NVL(HA.DONAT_DED_30, 0) AS DONAT_DED_30                                      -- 2014-�׹��Ǽҵ����(�츮�������ձ�α�)
           , NVL(HA.INVEST_AMT_14, 0) AS INVEST_AMT_14                                     -- 2014-�����������ڱݾ�  14��
           , NVL(HA.LONG_SET_INVEST_SAVING_AMT, 0) AS LONG_SET_INVEST_SAVING_AMT           -- 2014-�������������������
            
           , NVL(HA.HIRE_KEEP_EMPLOY_AMT, 0) AS HIRE_KEEP_EMPLOY_AMT  -- ��������߼ұ���ٷ��ڼҵ����
           , ( NVL(HA.PERS_ANNU_BANK_AMT, 0) + NVL(HA.SMALL_CORPOR_DED_AMT, 0) +
               NVL(HA.HOUSE_APP_DEPOSIT_AMT, 0) + NVL(HA.HOUSE_APP_SAVE_AMT, 0) +
               NVL(HA.HOUSE_SAVE_AMT, 0) + NVL(HA.WORKER_HOUSE_SAVE_AMT, 0) +
               NVL(HA.INVES_AMT, 0) + NVL(HA.CREDIT_AMT, 0) + NVL(HA.DONAT_DED_30, 0) + 
               NVL(HA.EMPL_STOCK_AMT, 0) + NVL(HA.LONG_STOCK_SAVING_AMT, 0) +
               NVL(HA.HIRE_KEEP_EMPLOY_AMT, 0) + NVL(HA.FIX_LEASE_DED_AMT, 0) + NVL(HA.LONG_SET_INVEST_SAVING_AMT, 0)
               ) AS TOT_ETC_DED_AMT   -- �׹��� �ҵ���� �հ� �ݾ� --
               
           , NVL(HA.TAX_STD_AMT, 0) AS TAX_STD_AMT            -- ����ǥ�� 
           , NVL(HA.COMP_TAX_AMT, 0) AS COMP_TAX_AMT          -- ���⼼�� 
          
           , NVL(HA.TAX_REDU_IN_LAW_AMT, 0) AS TAX_REDU_IN_LAW_AMT
           , NVL(HA.TAX_REDU_SMALL_BUSINESS, 0) AS TAX_SMALL_REDU_SP_LAW_AMT              -- 2014-���� ( �߼ұ�����û��)           
           , NVL(HA.TAX_REDU_SP_LAW_AMT, 0) + NVL(HA.TAX_REDU_SMALL_BUSINESS, 0) AS TAX_REDU_SP_LAW_AMT
           , (NVL(HA.TAX_REDU_IN_LAW_AMT, 0) + NVL(HA.TAX_REDU_SMALL_BUSINESS, 0) + NVL(HA.TAX_REDU_SP_LAW_AMT, 0))AS TAX_REDU_SUM  -- ���װ��� �հ� 
           
           , NVL(HA.TAX_DED_INCOME_AMT, 0) AS TAX_DED_INCOME_AMT  -- �ٷμҵ���� 
           , NVL(HA.TAX_DED_TAXGROUP_AMT, 0) AS TAX_DED_TAXGROUP_AMT  -- �������� 
           , NVL(HA.TAX_DED_HOUSE_DEBT_AMT, 0) AS TAX_DED_HOUSE_DEBT_AMT  -- �������Ա� 
           , NVL(HA.TAX_DED_LONG_STOCK_AMT, 0) AS TAX_DED_LONG_STOCK_AMT  -- 
           --, NVL(HA.TAX_DED_DONAT_POLI_AMT, 0) AS TAX_DED_DONAT_POLI_AMT  -- ��ġ�ڱ� ��α�(2014 ��� ����)            
           , NVL(HA.TAX_DED_OUTSIDE_PAY_AMT, 0) AS TAX_DED_OUTSIDE_PAY_AMT  -- �ܱ����� 
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
               NVL(HA.TAX_DED_OUTSIDE_PAY_AMT, 0) + NVL(HA.TD_HOUSE_MONTHLY_DED_AMT, 0)) AS TAX_DED_SUM  -- ���װ��� �հ� 
           
           , NVL(HA.FIX_TAX_AMT, 0) AS FIX_TAX_AMT  -- ��������
           , NVL(HA.FIX_IN_TAX_AMT, 0) AS FIX_IN_TAX_AMT           -- ������ ����.
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
           , NVL(HA.SUBT_IN_TAX_AMT, 0) AS SUBT_IN_TAX_AMT           -- ���� �ҵ漼
           , NVL(HA.SUBT_LOCAL_TAX_AMT, 0) AS SUBT_LOCAL_TAX_AMT     -- ���� �ֹμ�
           , NVL(HA.SUBT_SP_TAX_AMT, 0) AS SUBT_SP_TAX_AMT           -- ���� ��Ư��
           , ( NVL(HA.SUBT_IN_TAX_AMT, 0) + NVL(HA.SUBT_LOCAL_TAX_AMT, 0) +
               NVL(HA.SUBT_SP_TAX_AMT, 0)) AS SUBT_TAX_SUM
           --, NVL(HA.NONTAX_FOREIGNER_AMT, 0) AS NONTAX_FOREIGNER_AMT
           , NVL(HA.BIRTH_DED_COUNT, 0) AS BIRTH_DED_COUNT
           , NVL(HA.BIRTH_DED_AMT, 0) AS BIRTH_DED_AMT
           , ( NVL(HA.LONG_HOUSE_PROF_AMT, 0) + NVL(HA.LONG_HOUSE_PROF_AMT_1, 0) +
               NVL(HA.LONG_HOUSE_PROF_AMT_2, 0) + NVL(HA.LONG_HOUSE_PROF_AMT_3_FIX, 0) +
               NVL(HA.LONG_HOUSE_PROF_AMT_3_ETC, 0)) AS LONG_HOUSE_PROF_AMT
           , ( NVL(HA.HOUSE_APP_DEPOSIT_AMT, 0) + NVL(HA.HOUSE_APP_SAVE_AMT, 0) +
               NVL(HA.HOUSE_SAVE_AMT, 0) + NVL(HA.WORKER_HOUSE_SAVE_AMT, 0)) AS HOUSE_SAVE_AMT  -- ���ø�������ҵ���� --
           , NVL(HA.SMALL_CORPOR_DED_AMT, 0) AS SMALL_CORPOR_DED_AMT
           , NVL(HA.LONG_STOCK_SAVING_AMT, 0) AS LONG_STOCK_SAVING_AMT
           , NVL(HA.HOUSE_MONTHLY_AMT, 0) AS HOUSE_MONTHLY_AMT  -- ��� ���� 
           , HA.CLOSED_FLAG
           , DECODE(HA.CLOSED_FLAG, 'Y', HA.CLOSED_DATE) AS CLOSED_DATE
           , ( SELECT PM.NAME
                 FROM HRM_PERSON_MASTER PM
                WHERE PM.PERSON_ID    = DECODE(HA.CLOSED_FLAG, 'Y', HA.CLOSED_PERSON_ID, -1)
             ) AS CLOSED_PERSON
           -- 2013�� �߰� --
           , NVL(HA.SINGLE_PARENT_DED_AMT, 0) AS SINGLE_PARENT_DED_AMT
           , NVL(HA.FIX_LEASE_DED_AMT, 0) AS FIX_LEASE_DED_AMT
           , NVL(HA.SP_DED_TOT_AMT, 0) AS SP_DED_TOT_AMT
           
           
           -- 2014�� �߰� -- 
           , NVL(HA.TD_CHILD_RAISE_DED_CNT, 0) AS TD_CHILD_RAISE_DED_CNT                  -- 2014-���� �ڳ���� �ο��� 
           , NVL(HA.TD_CHILD_RAISE_DED_AMT, 0) AS TD_CHILD_RAISE_DED_AMT                  -- 2014-���� �ڳ���� �����ݾ�     
           , NVL(HA.TD_CHILD_6_UNDER_DED_CNT, 0) AS TD_CHILD_6_UNDER_DED_CNT              -- 2014-���� 6������ �ο��� 
           , NVL(HA.TD_CHILD_6_UNDER_DED_AMT, 0) AS TD_CHILD_6_UNDER_DED_AMT              -- 2014-���� 6������ �����ݾ�
           , NVL(HA.TD_BIRTH_DED_CNT, 0) AS TD_BIRTH_DED_CNT                              -- 2014-���� ���/�Ծ� �ο��� 
           , NVL(HA.TD_BIRTH_DED_AMT, 0) AS TD_BIRTH_DED_AMT                              -- 2014-���� ���/�Ծ� �����ݾ� 
           , NVL(HA.TD_SCIENTIST_ANNU_AMT, 0) AS TD_SCIENTIST_ANNU_AMT                    -- 2014-���� ���б���ΰ��� ���
           , NVL(HA.TD_SCIENTIST_ANNU_DED_AMT, 0) AS TD_SCIENTIST_ANNU_DED_AMT            -- 2014-���� ���б���ΰ��� ����
           , NVL(HA.TD_WORKER_RETR_ANNU_AMT, 0) AS TD_WORKER_RETR_ANNU_AMT                -- 2014-���� �ٷ��� �������� ���
           , NVL(HA.TD_WORKER_RETR_ANNU_DED_AMT, 0) AS TD_WORKER_RETR_ANNU_DED_AMT        -- 2014-���� �ٷ��� �������� ���� 
           , NVL(HA.TD_ANNU_BANK_AMT, 0) AS TD_ANNU_BANK_AMT                              -- 2014-���� �������� ���
           , NVL(HA.TD_ANNU_BANK_DED_AMT, 0) AS TD_ANNU_BANK_DED_AMT                      -- 2014-���� �������� ���� 
           , ( NVL(HA.TD_GUAR_INSUR_AMT, 0) + 
               NVL(HA.TD_DISABILITY_INSUR_AMT, 0)) AS TD_GUAR_INSUR_AMT                   -- 2014-���� ���强���� ���            
           , ( NVL(HA.TD_GUAR_INSUR_DED_AMT, 0) + 
               NVL(HA.TD_DISABILITY_INSUR_DED_AMT, 0)) AS TD_GUAR_INSUR_DED_AMT           -- 2014-���� ���强���� ���װ��� 
           , NVL(HA.TD_MEDIC_AMT, 0) AS TD_MEDIC_AMT                                      -- 2014-���� �Ƿ�� ���ݾ�            
           , NVL(HA.TD_MEDIC_DED_AMT, 0) AS TAX_DED_MEDIC_AMT                             -- 2014-���� �Ƿ�� ���װ���
           , NVL(HA.TD_EDUCATION_AMT, 0) AS TD_EDUCATION_AMT                              -- 2014-���� ������ ���ݾ� 
           , NVL(HA.TD_EDUCATION_DED_AMT, 0) AS TAX_DED_EDUCATION_AMT                     -- 2014-���� ������ ���װ��� 
           , NVL(HA.TD_POLI_DONAT_AMT1, 0) AS TD_POLI_DONAT_AMT1                          -- 2014-���� ��ġ�ڱݱ�α� ���(10���� ����) 
           , NVL(HA.TD_POLI_DONAT_DED_AMT1, 0) AS TD_POLI_DONAT_DED_AMT1                  -- 2014-���� ��ġ�ڱ� ��α� ���װ���(10���� ����) 
           , NVL(HA.TD_POLI_DONAT_AMT2, 0) AS TD_POLI_DONAT_AMT2                          -- 2014-���� ��ġ�ڱݱ�α� ���(10���� �ʰ�) 
           , NVL(HA.TD_POLI_DONAT_DED_AMT2, 0) AS TD_POLI_DONAT_DED_AMT2                  -- 2014-���� ��ġ�ڱݱ�α� ���װ���(10���� �ʰ�) 
           , NVL(HA.TD_LEGAL_DONAT_AMT, 0) AS TD_LEGAL_DONAT_AMT                          -- 2014-���� ������α� ���
           , NVL(HA.TD_LEGAL_DONAT_DED_AMT, 0) AS TD_LEGAL_DONAT_DED_AMT                  -- 2014-���� ������α� ���װ���
           , NVL(HA.TD_DESIGN_DONAT_AMT, 0) AS TD_DESIGN_DONAT_AMT                        -- 2014-���� ������α� ���
           , NVL(HA.TD_DESIGN_DONAT_DED_AMT, 0) AS TD_DESIGN_DONAT_DED_AMT                -- 2014-���� ������α� ���װ���
           , ( NVL(HA.TD_GUAR_INSUR_DED_AMT, 0) + 
               NVL(HA.TD_DISABILITY_INSUR_DED_AMT, 0) + 
               NVL(HA.TD_MEDIC_DED_AMT, 0) + 
               NVL(HA.TD_EDUCATION_DED_AMT, 0) + 
               NVL(HA.TD_POLI_DONAT_DED_AMT1, 0) + 
               NVL(HA.TD_POLI_DONAT_DED_AMT2, 0) +
               NVL(HA.TD_LEGAL_DONAT_DED_AMT, 0) + 
               NVL(HA.TD_DESIGN_DONAT_DED_AMT, 0)) AS TD_SP_DED_TOTAL_AMT                 -- 2014-���� Ư�����װ��� �հ�            
           , NVL(HA.TD_STAND_DED_AMT, 0) AS TD_STAND_DED_AMT                              -- 2014-���� ǥ�ؼ��װ���    
           , NVL(HA.TD_HOUSE_MONTHLY_AMT, 0) AS TD_HOUSE_MONTHLY_AMT                      -- 2014-���� ������ ���� ���
           , NVL(HA.TD_HOUSE_MONTHLY_DED_AMT, 0) AS TD_HOUSE_MONTHLY_DED_AMT              -- 2014-���� ������ �����ݾ�            
        FROM HRA_YEAR_ADJUSTMENT HA
           , ( -- ���� ���� ����
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
  

-- �������� ��� MAIN --   
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
---> �ʱ�ȭ  
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
    
    -- �������� ��Ű�� ȣ��.
    IF V_YEAR_YYYY = '2010' THEN
      -- 2010�⵵ ��������.
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
      -- 2011�⵵ ��������.
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
        -- ��α� �������� �ۼ� : 12��31�� �����ڿ� ���ؼ� ���� --
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
            
      -- 2012�⵵ ��������.
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
        -- ��α� �������� �ۼ� : 12��31�� �����ڿ� ���ؼ� ���� --
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
      
      -- 2013�⵵ ��������.
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
        -- ��α� �������� �ۼ� : 12��31�� �����ڿ� ���ؼ� ���� --
        HRA_DONATION_INFO_G.SET_DONATION_ADJUSTMENT
          ( P_CORP_ID           => P_CORP_ID
          , P_YEAR_YYYY         => V_YEAR_YYYY
          , P_DEPT_ID           => P_DEPT_ID
          , P_FLOOR_ID          => P_FLOOR_ID
          , P_YEAR_EMPLOYE_TYPE => '10'  -- ��ӱٷ��� -- 
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
      
      -- 2014�⵵ ��������.
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


-- �������� ���� / ���� ��� -- 
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
      -- �̸����� �ڷḦ ���� ó���� --
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
           AND HA.CLOSED_FLAG       = P_CLOSED_FLAG  -- ���� ���� -- 
        ;
      EXCEPTION WHEN OTHERS THEN
        O_MESSAGE := 'Closed Flag Update Error : ' || SUBSTR(SQLERRM, 1, 150);
        RETURN;
      END;
    ELSIF P_CLOSED_FLAG = 'Y' THEN
      -- ������ �ڷḦ ���� ��� ó���� --
      /*-- �޿������� �� ��� ������� �Ұ� --
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
           AND HA.CLOSED_FLAG       = P_CLOSED_FLAG  -- ���� ���� --
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
           AND HA.CLOSED_FLAG       = P_CLOSED_FLAG  -- ���� ���� -- 
           AND NOT EXISTS
                 ( SELECT 'X'
                     FROM HRA_YEAR_ADJUSTMENT_1505 HA1
                    WHERE HA1.YEAR_YYYY        = HA.YEAR_YYYY
                      AND HA1.PERSON_ID        = HA.PERSON_ID
                      AND HA1.SOB_ID           = HA.SOB_ID
                      AND HA1.ORG_ID           = HA.ORG_ID
                      AND HA1.FIX_IN_TAX_AMT   = 0
                 )             -- ���������� 0�� �ƴ� ����� Ǯ��� �� -- 
        ;
      EXCEPTION WHEN OTHERS THEN
        O_MESSAGE := 'Closed Flag Update Error : ' || SUBSTR(SQLERRM, 1, 150);
        RETURN;
      END;
    END IF;
    O_STATUS := 'S';
  END SET_ADJUST_CLOSED;


-- �������� �������� return  -- 
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
                  /*--�ϳ��� ��������� ó�� ���� -- 
                  , T1.OPERATING_UNIT_ID */
                  , COUNT(YA.PERSON_ID) AS PERSON_COUNT
                  , SUM( NVL(YA.NOW_PAY_TOT_AMT, 0) + NVL(YA.NOW_BONUS_TOT_AMT, 0) +
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
                         END) AS PAY_TAX_AMT
                  , SUM( CASE
                           WHEN NVL(YA.FOREIGN_FIX_TAX_YN, 'N') = 'Y' THEN 0 
                           ELSE (-- ����� 
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
                         END) AS PAY_TAX_FREE_AMT
                  , SUM(NVL(YA.FIX_IN_TAX_AMT, 0)) AS FIX_IN_TAX_AMT
                  , SUM(NVL(YA.FIX_LOCAL_TAX_AMT, 0)) AS FIX_LOCAL_TAX_AMT
                  , SUM(NVL(YA.FIX_SP_TAX_AMT, 0)) AS FIX_SP_TAX_AMT
                  , SUM(NVL(YA.FIX_IN_TAX_AMT, 0) + NVL(YA.FIX_LOCAL_TAX_AMT, 0) + NVL(YA.FIX_SP_TAX_AMT, 0)) AS FIX_TAX_SUM
                FROM HRA_YEAR_ADJUSTMENT YA
                  , HRM_PERSON_MASTER    PM
                  , ( -- ���� �λ系��.
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
                 
                 -- ���������� ����� �ο��� ���� --
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
                 -- ���� ��� ��ȸ -- 
                 AND TRUNC(YA.CREATION_DATE) >= TO_DATE('2015-05-01', 'YYYY-MM-DD')  
               GROUP BY YA.YEAR_YYYY 
                      /*--�ϳ��� ��������� ó�� ���� -- 
                      , T1.OPERATING_UNIT_ID */
            ) S_YA  
          , ( SELECT MI.YEAR_YYYY
                  /*--�ϳ��� ��������� ó�� ���� -- 
                  , T1.OPERATING_UNIT_ID */
                  , COUNT(DISTINCT MI.PERSON_ID) AS PERSON_COUNT
                FROM HRA_MEDICAL_INFO MI
                  , HRM_PERSON_MASTER PM
                  , ( -- ���� �λ系��.
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
                           AND YA.TD_MEDIC_DED_AMT > 0        -- �Ƿ�� �����ݾ��� ������� ���� -- 
                           
                           -- ���������� ����� �ο��� ���� --
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
                           -- ���� ��� ��ȸ -- 
                           AND TRUNC(YA.CREATION_DATE) >= TO_DATE('2015-05-01', 'YYYY-MM-DD')   
                      )
              GROUP BY MI.YEAR_YYYY 
                     /*--�ϳ��� ��������� ó�� ���� -- 
                     , T1.OPERATING_UNIT_ID */
            ) S_MI
          , ( SELECT DA.YEAR_YYYY
                  /*--�ϳ��� ��������� ó�� ���� -- 
                  , T1.OPERATING_UNIT_ID */
                  , COUNT(DISTINCT DA.PERSON_ID) AS PERSON_COUNT
                  , COUNT(DA.PERSON_ID) AS DONATION_ADJUST_COUNT
                  , SUM(DA.TOTAL_DONA_AMT) AS TOTAL_DONA_AMT
                  , SUM(DA.DONA_DED_AMT) AS DONA_DED_AMT
                FROM HRA_DONATION_ADJUSTMENT DA
                  , HRM_PERSON_MASTER        PM
                  , ( -- ���� �λ系��.
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
                     /*--�ϳ��� ��������� ó�� ���� -- 
                     , T1.OPERATING_UNIT_ID*/ 
            ) S_DA
          , ( SELECT DI.YEAR_YYYY
                  /*--�ϳ��� ��������� ó�� ���� -- 
                  , T1.OPERATING_UNIT_ID */
                  , COUNT(DISTINCT DI.PERSON_ID) AS PERSON_COUNT
                FROM HRA_DONATION_INFO DI
                  , HRM_PERSON_MASTER  PM
                  , ( -- ���� �λ系��.
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
                     /*--�ϳ��� ��������� ó�� ���� -- 
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
-- 2013�⵵ �ٷμҵ� ���ϻ���.
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
    
    V_DONATION_POLI_1           NUMBER;          -- ��α�(��ġ�ڱݱ�α�10���� ����) 
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
                    || RPAD(NVL(P_TAX_PROGRAM_CODE, '9000'), 4, ' ')  -- �������α׷��ڵ�;
                    || RPAD(NVL(REPLACE(OU.VAT_NUMBER, '-', ''), ' '), 10, ' ')  -- ����ڵ�Ϲ�ȣ;
                    || RPAD(NVL(REPLACE(CM.CORP_NAME, ' ', ''), ' '), 40, ' ')  -- ���θ�(��ȣ);
                    || RPAD(NVL(REPLACE(S_PM.DEPT_NAME, ' ', ''), ' '), 30, ' ')  -- �����(������) �μ�;
                    || RPAD(NVL(REPLACE(S_PM.NAME, ' ', ''), ' '), 30, ' ')  -- �����(������) ����;
                    || RPAD(NVL(REPLACE(CM.TEL_NUMBER, '-', ''), ' '), 15, ' ')  -- �����(������) ��ȭ��ȣ;
                    --> ���⳻��.
                    || LPAD(1, 5, 0)  -- �Ű��ǹ��ڼ� (B���ڵ�);
                    || LPAD(NVL(P_USE_LANGUAGE_CODE, '101'), 3, 0)  -- ����ѱ��ڵ�;
                    || RPAD(' ', 1402, ' ') AS RECORD_FILE
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
                  /*--�ϳ��� ��������� ó�� ���� -- 
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
                      --|| LPAD(NVL(S_PW.PRE_WORKER_COUNT, 0), 7, 0)   -- 10.������ D���ڵ�(���ٹ�ó)�� ��(C���ڵ� �׸�6�� �հ�)
                      || LPAD(NVL((SELECT COUNT(PW.PERSON_ID) AS PRE_WORKER_COUNT 
                                     FROM HRA_YEAR_ADJUSTMENT HYA  
                                        , HRA_PREVIOUS_WORK    PW 
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
                                     WHERE HYA.PERSON_ID          = PW.PERSON_ID 
                                       AND PW.PERSON_ID           = T1.PERSON_ID 
                                       /*--�ϳ��� ��������� ó�� ���� -- 
                                       AND T1.OPERATING_UNIT_ID   = OU.OPERATING_UNIT_ID */
                                       AND PW.YEAR_YYYY           = P_YEAR_YYYY
                                       AND HYA.CORP_ID            = OU.CORP_ID
                                       AND PW.SOB_ID              = P_SOB_ID
                                       AND PW.ORG_ID              = P_ORG_ID
                                       AND HYA.SUBMIT_DATE        BETWEEN P_START_DATE AND P_END_DATE
                                       AND HYA.ADJUST_DATE_TO     BETWEEN P_START_DATE AND P_END_DATE
                                       
                                       -- ���������� ����� �ο��� ���� --
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
                                       -- ���� ��� ��ȸ -- 
                                       AND TRUNC(HYA.CREATION_DATE) >= TO_DATE('2015-05-01', 'YYYY-MM-DD')   
                                     GROUP BY HYA.YEAR_YYYY
                                            /*--�ϳ��� ��������� ó�� ���� -- 
                                            , T1.OPERATING_UNIT_ID*/
                                    ), 0), 7, 0)                     -- 10.������ D���ڵ�(���ٹ�ó)�� ��(C���ڵ� �׸�6�� �հ�)
                      || LPAD(NVL(S_YA.INCOME_TOT_AMT, 0), 14, 0)    -- 11.�ѱ޿� �Ѱ�(C���ڵ� �޿� ��);
                      || LPAD(NVL(S_YA.FIX_IN_TAX, 0), 13, 0)        -- �ҵ漼 �������� �Ѱ�(C���ڵ� �ҵ漼�� ��);
                      || LPAD(NVL(S_YA.FIX_LOCAL_TAX, 0), 13, 0)     -- �ֹμ� �������� �Ѱ�;
                      || LPAD(NVL(S_YA.FIX_SP_TAX, 0), 13, 0)        -- ��Ư�� �������� �Ѱ�;
                      || LPAD(NVL(S_YA.FIX_TOTAL_TAX, 0) - NVL(S_YA.FIX_LEGAL_TAX, 0), 13, 0)  -- �������� �Ѱ�;
                      -- LPAD(NVL(S_YA.FIX_TOTAL_TAX, 0), 13, 0)  -- �������� �Ѱ� : 2009�� �������� ���� ���������Ѱ�-���μ� �������� �Ѱ�;
                      || LPAD(NVL(P_SUBMIT_PERIOD, '1'), 1, 0)   -- (�����ջ� : 1, ��/����� ���� �������� : 2, ���� �������� : 3);
                      || RPAD(' ', 1394, ' ') AS RECORD_FILE
                      , LPAD(REPLACE(OU.TAX_OFFICE_CODE, '-', ''), 3, 0) AS TAX_OFFICE_CODE
                      , RPAD(NVL(REPLACE(OU.VAT_NUMBER, '-', ''), ' '), 10, ' ') AS VAT_NUMBER
                    FROM HRM_CORP_MASTER CM
                       , HRM_OPERATING_UNIT OU
                       , ( -- ���⳻��.
                           SELECT YA.YEAR_YYYY
                               /*--�ϳ��� ��������� ó�� ���� -- 
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
                                             -- ����� 
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
                                             -- ����-- 
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
                            WHERE YA.PERSON_ID          = PM.PERSON_ID
                              AND PM.PERSON_ID          = T1.PERSON_ID 
                              /*--�ϳ��� ��������� ó�� ���� -- 
                              AND T1.OPERATING_UNIT_ID  = A1.OPERATING_UNIT_ID */
                              AND YA.CORP_ID            = A1.CORP_ID
                              AND YA.YEAR_YYYY          = P_YEAR_YYYY
                              AND YA.SOB_ID             = P_SOB_ID
                              AND YA.ORG_ID             = P_ORG_ID
                              AND YA.SUBMIT_DATE        BETWEEN P_START_DATE AND P_END_DATE
                              --AND NVL(YA.INCOME_TOT_AMT, 0) != 0
                              AND YA.ADJUST_DATE_TO     BETWEEN P_START_DATE AND P_END_DATE
                              
                              -- ���������� ����� �ο��� ���� --
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
                              -- ���� ��� ��ȸ -- 
                              AND TRUNC(YA.CREATION_DATE) >= TO_DATE('2015-05-01', 'YYYY-MM-DD')   
                            GROUP BY YA.YEAR_YYYY
                                  /*--�ϳ��� ��������� ó�� ���� -- 
                                  , T1.OPERATING_UNIT_ID */
                         ) S_YA
                    WHERE CM.CORP_ID            = OU.CORP_ID
                      AND P_YEAR_YYYY           = S_YA.YEAR_YYYY
                      /*--�ϳ��� ��������� ó�� ���� -- 
                      AND OU.OPERATING_UNIT_ID  = S_YA.OPERATING_UNIT_ID*/
                      AND OU.CORP_ID            = A1.CORP_ID 
                      --�ϳ��� ��������� ó�� ���� -- 
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
                                  ELSE NVL(UPPER(S_HN.ISO_NATION_CODE), ' ')
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
                                  WHEN PM.NATIONALITY_TYPE = '9' THEN NVL(UPPER(S_HN.ISO_NATION_CODE), ' ')
                                  WHEN SUBSTR(REPLACE(PM.REPRE_NUM, '-', ''), 7, 1) BETWEEN '5' AND '8' THEN NVL(UPPER(S_HN.ISO_NATION_CODE), ' ')
                                  ELSE ' '
                                END, 2, ' ')  -- 13.�����ڵ�(�ܱ����� ��츸 ����);
                        || RPAD(CASE
                                  WHEN SUBSTR(REPLACE(PM.REPRE_NUM, '-', ''), 7, 1) BETWEEN '5' AND '8' THEN '2' 
                                  ELSE NVL(PM.HOUSEHOLD_TYPE, '1')
                                END, 1, 0)  -- 14.�����ֿ���(�ܱ����� ��� ��������� ����).
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
                                NVL(YA.INCOME_OUTSIDE_AMT, 0) +
                                NVL(YA.NOW_BONUS_TOT_AMT, 0) +
                                NVL(YA.NOW_ADD_BONUS_AMT, 0) +
                                NVL(YA.NOW_STOCK_BENE_AMT, 0) + 
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
                        || LPAD(0, 10, 0) -- 48.����� ���ܼҵ�(�������� ���ܿ��� �ٹ��ϰ� �޴� ���� �� �������� �ٹ��� ��� �޴� �ݾ׻��� �ʰ��Ͽ� ���� �ݾ�);
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
                                 -- ����-- 
                                 NVL(YA.PRE_NT_OUTSIDE_AMT, 0) + NVL(YA.PRE_NT_OT_AMT, 0) +  -- NONTAX_OUTSIDE_AMT : ����� ���ܱٷ� �հ�  
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
                                         -- ����-- 
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
                       /* -- 2014�⵵ �������� ���� --  
                       || LPAD(NVL(YA.CHILD_DED_COUNT, 0), 2, 0) -- 75.�ڳ����������ο�;
                        || LPAD(NVL(YA.CHILD_DED_AMT, 0), 8, 0) -- 76.�ڳ����������ݾ�;
                        || LPAD(NVL(YA.BIRTH_DED_COUNT, 0), 2, 0) -- 77.���/�Ծ��ڰ����ο�;
                        || LPAD(NVL(YA.BIRTH_DED_AMT, 0), 8, 0) --  78.���/�Ծ��ڰ����ݾ�;*/
                        || LPAD(NVL(YA.SINGLE_PARENT_DED_AMT, 0), 10, 0) -- 79.2013�⵵ �߰� : �Ѻθ� ���� �����ݾ�;
                        -- LPAD(NVL(YA.PER_ADD_DED_AMT, 0), 8, 0)   PER_ADD_DED_AMT;
                        /* -- 2014�⵵ �������� ���� --
                        --> ���ڳ��߰�����;
                        || LPAD(NVL(YA.MANY_CHILD_DED_COUNT, 0), 2, 0) -- 80.���ڳ��߰������ο�;
                        || LPAD(NVL(YA.MANY_CHILD_DED_AMT, 0), 8, 0) -- 81.���ڳ��߰������ݾ�;*/
                        -->���ݺ����;
                        || LPAD(NVL(YA.NATI_ANNU_AMT, 0), 10, 0) -- 82.���ο��ݺ�������;
                        || LPAD(NVL(YA.PUBLIC_INSUR_AMT, 0), 10, 0)  -- 83.��Ÿ���ݺ�������_����������;
                        || LPAD(NVL(YA.MARINE_INSUR_AMT, 0), 10, 0)  -- 84.��Ÿ���ݺ�������_���ο���;
                        || LPAD(NVL(YA.SCHOOL_STAFF_INSUR_AMT, 0), 10, 0)  -- 85.��Ÿ���ݺ�������_�縳�б�����������;
                        || LPAD(NVL(YA.POST_OFFICE_INSUR_AMT, 0), 10, 0)  -- 86.��Ÿ���ݺ�������_������ü������;
                        
                        /* -- 2014�⵵ �������� ���� --
                        || LPAD(NVL(YA.SCIENTIST_ANNU_AMT, 0), 10, 0)  -- 87.��Ÿ���ݺ�������_���б���ΰ���;
                        || LPAD(NVL(YA.RETR_ANNU_AMT, 0), 10, 0)  -- 88.��Ÿ���ݺ�������_�ٷ��������޿������;
                        || LPAD(NVL(YA.ANNU_BANK_AMT, 0), 10, 0) -- 89.2013�⵵ ���� : ��������ҵ����;*/
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
                        /* -- 2014�⵵ �������� ���� --
                        || LPAD(NVL(YA.GUAR_INSUR_AMT, 0), 10, 0)  -- 92.���庸��� ;
                        || LPAD(NVL(YA.DISABILITY_INSUR_AMT, 0), 10, 0)  -- 93.��ֺ���� ;
                        || LPAD(NVL(YA.DISABILITY_MEDIC_AMT, 0), 10, 0)  -- 94.2013�⵵ ���� : �Ƿ������ݾ�-�����;
                        || LPAD(NVL(YA.ETC_MEDIC_AMT, 0), 10, 0)  -- 95.2013�⵵ ���� : �Ƿ������ݾ�-��Ÿ;
                        || LPAD(NVL(YA.DISABILITY_EDUCATION_AMT, 0), 8, 0) -- 96.2013�⵵ ���� : ����������ݾ�-�����;
                        || LPAD(NVL(YA.ETC_EDUCATION_AMT, 0), 8, 0) -- 97.2013�⵵ ���� : ����������ݾ�-��Ÿ;*/
                        || LPAD(NVL(YA.HOUSE_INTER_AMT, 0), 8, 0) -- 98.�����Ӵ������Աݿ����ݻ�ȯ�����ݾ�(������);
                        || LPAD(NVL(YA.HOUSE_INTER_AMT_ETC, 0), 8, 0)  -- 99.2013�⵵ ���� : �����������Աݿ����ݻ�ȯ��(������).
                        || LPAD(CASE
                                  WHEN NVL(YA.TD_HOUSE_MONTHLY_DED_AMT, 0) = 0 THEN 0
                                  ELSE NVL(YA.TD_HOUSE_MONTHLY_AMT, 0)
                                END, 8, 0)  -- 100.�����ڱ�_�������� ���ݾ�;
                        || LPAD(NVL(YA.LONG_HOUSE_PROF_AMT, 0), 8, 0) -- 101.��������������Ա����ڻ�ȯ�����ݾ�;
                        || LPAD(NVL(YA.LONG_HOUSE_PROF_AMT_1, 0), 8, 0) -- 102.��������������Ա����ڻ�ȯ�����ݾ�(15);
                        || LPAD(NVL(YA.LONG_HOUSE_PROF_AMT_2, 0), 8, 0) -- 103.��������������Ա����ڻ�ȯ�����ݾ�(30);
                        -- ��ȣ�� �߰� : 2012�⵵ �������� BEGIN --
                        || LPAD(NVL(YA.LONG_HOUSE_PROF_AMT_3_FIX, 0), 8, 0) -- 104.12�� ���� ��������������Ա����ڻ�ȯ�����ݾ�(�����ݸ�);
                        || LPAD(NVL(YA.LONG_HOUSE_PROF_AMT_3_ETC, 0), 8, 0) -- 105.12�� ���� ��������������Ա����ڻ�ȯ�����ݾ�(��Ÿ);
                        -- ��ȣ�� �߰� : 2012�⵵ �������� END --
                        || LPAD(NVL(YA.DONAT_DED_ALL, 0) + -- ������α� 
                                NVL(YA.DONAT_DED_50, 0) +  -- ���͹��ν�Ź��α� 
                                NVL(YA.DONAT_DED_RELIGION_10, 0) + -- ������ü ��α� 
                                NVL(YA.DONAT_DED_10, 0), 11, 0)  -- ������ü�� ��α� 91. ��α� �̿��� 
                                
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
                                   END) -- �����ڱ�(�����������Ա� + ������ + ��������������Ա� )
                                  ), 11, 0) -- 93.Ư���ҵ������;
                        /* -- 2014�⵵ �������� ���� -- 
                        || LPAD(NVL(YA.STAND_DED_AMT, 0), 8, 0) -- 112.ǥ�ذ���;*/
                        || LPAD(NVL(YA.SUBT_DED_AMT, 0), 11, 0) -- 94.�����ҵ�ݾ�; 
                        --> �� ���� �ҵ����.
                        || LPAD(NVL(YA.PERS_ANNU_BANK_AMT, 0), 8, 0) -- 95.���ο�������ҵ����;
                        || LPAD(NVL(YA.SMALL_CORPOR_DED_AMT, 0), 10, 0) -- 96.�ұ�������αݼҵ����;
                        || LPAD(NVL(YA.HOUSE_APP_DEPOSIT_AMT, 0), 10, 0)  -- 97.��)���ø�������ҵ����-û������;
                        || LPAD(NVL(YA.HOUSE_APP_SAVE_AMT, 0), 10, 0) -- 98.��)���ø�������ҵ����-����û����������; 
                        || LPAD(NVL(YA.WORKER_HOUSE_SAVE_AMT, 0), 10, 0)  -- 99.��)�ٷ������ø�������.
                        || LPAD(NVL(YA.INVES_AMT, 0), 10, 0) -- 100.�����������ڵ�ҵ����;
                        || LPAD(NVL(YA.CREDIT_AMT, 0), 8, 0) -- 101.�ſ�ī��� �ҵ����;                        
                        || LPAD(NVL(YA.EMPL_STOCK_AMT, 0), 10, 0) -- 102.�츮�������ռҵ����(�ѵ� 400����);
                        || LPAD(NVL(YA.DONAT_DED_30, 0), 11, 0) -- 103.�츮�������� ��α� 
                        -- 2009�� �������� �߰� BEGIN. ��������߼ұ���ٷ��ڼҵ����/���� �߰�;
                        || LPAD(NVL(YA.HIRE_KEEP_EMPLOY_AMT, 0), 10, 0) -- 104.��������߼ұ���ٷ��ڼҵ����;
                        || LPAD(NVL(YA.FIX_LEASE_DED_AMT, 0), 10, 0) -- 105.2013�⵵ �߰� : �񵷾ȵ���������ڻ�ȯ�װ���;
                        || LPAD(NVL(YA.LONG_SET_INVEST_SAVING_AMT, 0), 10, 0) -- 106.2014�⵵ �߰� : ������������������� 
                        -- 2009�� �������� �߰� END --
                        || LPAD((NVL(YA.PERS_ANNU_BANK_AMT, 0) + NVL(YA.SMALL_CORPOR_DED_AMT, 0) +
                                 NVL(YA.HOUSE_APP_DEPOSIT_AMT, 0) + NVL(YA.HOUSE_APP_SAVE_AMT, 0) +
                                 NVL(YA.WORKER_HOUSE_SAVE_AMT, 0) +
                                 NVL(YA.INVES_AMT, 0) + NVL(YA.CREDIT_AMT, 0) +  
                                 NVL(YA.EMPL_STOCK_AMT, 0) + NVL(YA.DONAT_DED_30, 0) +
                                 NVL(YA.HIRE_KEEP_EMPLOY_AMT, 0) + NVL(YA.FIX_LEASE_DED_AMT, 0) + 
                                 NVL(YA.LONG_SET_INVEST_SAVING_AMT, 0)), 11, 0) -- 107.�׹��� �ҵ���� ��(����̸� '0'����);
                                 
                        || LPAD(NVL(YA.SP_DED_TOT_AMT, 0), 11, 0) -- 108.Ư������ �����ѵ� �ʰ���;
                        || LPAD(NVL(YA.TAX_STD_AMT, 0), 11, 0) -- 109.���ռҵ� ����ǥ��;
                        || LPAD(NVL(YA.COMP_TAX_AMT, 0), 10, 0) -- 110.���⼼��;
                        --> ���װ���.
                        || LPAD(NVL(YA.TAX_REDU_IN_LAW_AMT, 0), 10, 0) --111.�ҵ漼��;
                        || LPAD(NVL(YA.TAX_REDU_SP_LAW_AMT, 0), 10, 0) -- 112.����Ư�����ѹ�;
                        -- 2012�� �������� �߰� START --
                        || LPAD(NVL(YA.TAX_REDU_SMALL_BUSINESS, 0), 10, 0) -- 113.����Ư�����ѹ� : �߼ұ�� ��� û�� �ҵ漼 ����;
                        -- 2012�� �������� �߰� END --
                        || LPAD(NVL(YA.TAX_REDU_TAX_TREATY, 0), 10, 0) -- 114.��������.
                        || LPAD(0, 10, 0) -- 115.����;
                        || LPAD(NVL(YA.TAX_REDU_IN_LAW_AMT, 0) +
                                NVL(YA.TAX_REDU_SP_LAW_AMT, 0) +
                                NVL(YA.TAX_REDU_TAX_TREATY, 0) + 
                                NVL(YA.TAX_REDU_SMALL_BUSINESS, 0), 10, 0) -- 116.���鼼�װ�;
                        --> ���װ���.
                        || LPAD(NVL(YA.TAX_DED_INCOME_AMT, 0), 10, 0) -- 117.�ٷμҵ漼�װ���;
                        || LPAD(NVL(YA.TD_CHILD_RAISE_DED_CNT, 0), 2, 0) -- 118.58-�� �ڳ༼�װ����ο�;
                        || LPAD(NVL(YA.TD_CHILD_RAISE_DED_AMT, 0), 10, 0) -- 119.58-�� �ڳ༼�װ���;
                        || LPAD(NVL(YA.TD_CHILD_6_UNDER_DED_CNT, 0), 2, 0) -- 120.58-�� 6������ �ڳ༼�װ����ο�;
                        || LPAD(NVL(YA.TD_CHILD_6_UNDER_DED_AMT, 0), 10, 0) -- 121.58-�� 6������ �ڳ༼�װ���;
                        || LPAD(NVL(YA.TD_BIRTH_DED_CNT, 0), 2, 0) -- 122.58-�� ���.�Ծ� �ڳ༼�װ����ο�;
                        || LPAD(NVL(YA.TD_BIRTH_DED_AMT, 0), 10, 0) -- 123.58-�� ���.�Ծ� �ڳ༼�װ���;                        
                        || LPAD(CASE
                                  WHEN NVL(YA.TD_SCIENTIST_ANNU_DED_AMT, 0) = 0 THEN 0
                                  ELSE NVL(YA.TD_SCIENTIST_ANNU_AMT, 0)
                                END, 10, 0) -- 124.���ݰ��� ���б���ΰ��� �������ݾ�<2014�߰�>;
                        || LPAD(NVL(YA.TD_SCIENTIST_ANNU_DED_AMT, 0), 10, 0) -- 125.���ݰ��� ���б���ΰ��� ���װ�����<2014�߰�>;
                        || LPAD(CASE
                                  WHEN NVL(YA.TD_WORKER_RETR_ANNU_DED_AMT, 0) = 0 THEN 0
                                  ELSE NVL(YA.TD_WORKER_RETR_ANNU_AMT, 0)
                                END, 10, 0) -- 126.�ٷ��� �����޿� �������ݾ�<2014�߰�>;
                        || LPAD(NVL(YA.TD_WORKER_RETR_ANNU_DED_AMT, 0), 10, 0) -- 127.�ٷ��� �����޿� ���װ�����<2014�߰�>;
                        || LPAD(CASE
                                  WHEN NVL(YA.TD_ANNU_BANK_DED_AMT, 0) = 0 THEN 0
                                  ELSE NVL(YA.TD_ANNU_BANK_AMT, 0)
                                END, 10, 0) -- 128.���ݰ��� �������� �������ݾ�<2014�߰�>;
                        || LPAD(NVL(YA.TD_ANNU_BANK_DED_AMT, 0), 10, 0) -- 129.���ݰ��� �������� ���װ�����<2014�߰�>;
                        || LPAD(CASE
                                  WHEN NVL(YA.TD_GUAR_INSUR_DED_AMT, 0) = 0 THEN 0
                                  ELSE NVL(YA.TD_GUAR_INSUR_AMT, 0)
                                END, 10, 0) -- 130.���强 ����� �������ݾ�<2014�߰�>;
                        || LPAD(NVL(YA.TD_GUAR_INSUR_DED_AMT, 0), 10, 0) -- 131.���强 ����� ���װ�����<2014�߰�>;
                        || LPAD(CASE
                                  WHEN NVL(YA.TD_DISABILITY_INSUR_AMT, 0) = 0 THEN 0
                                  ELSE NVL(YA.TD_DISABILITY_INSUR_AMT, 0)
                                END, 10, 0) -- 132.����� ����� �������ݾ�<2014�߰�>;
                        || LPAD(NVL(YA.TD_DISABILITY_INSUR_DED_AMT, 0), 10, 0) -- 133.����� ����� ���װ�����<2014�߰�>;                        
                        || LPAD(CASE
                                  WHEN NVL(YA.TD_MEDIC_DED_AMT, 0) = 0 THEN 0
                                  ELSE NVL(YA.TD_MEDIC_AMT, 0)
                                END, 10, 0) -- 134.�Ƿ�� �������ݾ�<2014�߰�>;
                        || LPAD(NVL(YA.TD_MEDIC_DED_AMT, 0), 10, 0) -- 135.�Ƿ�� ���װ�����<2014�߰�>;
                        || LPAD(CASE
                                  WHEN NVL(YA.TD_EDUCATION_DED_AMT, 0) = 0 THEN 0
                                  ELSE NVL(YA.TD_EDUCATION_AMT, 0)
                                END, 10, 0) -- 136.������ �������ݾ�<2014�߰�>;
                        || LPAD(NVL(YA.TD_EDUCATION_DED_AMT, 0), 10, 0) -- 137.������ ���װ�����<2014�߰�>;
                        || LPAD(CASE
                                  WHEN NVL(YA.TD_POLI_DONAT_DED_AMT1, 0) = 0 THEN 0
                                  ELSE NVL(YA.TD_POLI_DONAT_AMT1, 0)
                                END, 10, 0) -- 138.��α�_��ġ�ڱ�_10��������_�������ݾ� �������ݾ�<2014�߰�>;
                        || LPAD(NVL(YA.TD_POLI_DONAT_DED_AMT1, 0), 10, 0) -- 139.��α�_��ġ�ڱ�_10�������� ���װ�����<2014�߰�>;
                        || LPAD(CASE
                                  WHEN NVL(YA.TD_POLI_DONAT_DED_AMT2, 0) = 0 THEN 0
                                  ELSE NVL(YA.TD_POLI_DONAT_AMT2, 0)
                                END, 11, 0) -- 140.��α�_��ġ�ڱ�_10�����ʰ�_�������ݾ� �������ݾ�<2014�߰�>;
                        || LPAD(NVL(YA.TD_POLI_DONAT_DED_AMT2, 0), 10, 0) -- 141.��α�_��ġ�ڱ�_10�����ʰ� ���װ�����<2014�߰�>;
                        || LPAD(CASE
                                  WHEN NVL(YA.TD_LEGAL_DONAT_DED_AMT, 0) = 0 THEN 0
                                  ELSE NVL(YA.TD_LEGAL_DONAT_AMT, 0)
                                END, 11, 0) -- 142.��α�_������α�_�������ݾ� �������ݾ�<2014�߰�>;
                        || LPAD(NVL(YA.TD_LEGAL_DONAT_DED_AMT, 0), 10, 0) -- 143.��α�_������α� ���װ�����<2014�߰�>;
                        || LPAD(CASE
                                  WHEN NVL(YA.TD_DESIGN_DONAT_DED_AMT, 0) = 0 THEN 0
                                  ELSE NVL(YA.TD_DESIGN_DONAT_AMT, 0)
                                END, 11, 0) -- 144.��α�_������α�_�������ݾ� �������ݾ�<2014�߰�>;
                        || LPAD(NVL(YA.TD_DESIGN_DONAT_DED_AMT, 0), 10, 0) -- 145.��α�_������α� ���װ�����<2014�߰�>;
                        || LPAD((NVL(YA.TD_GUAR_INSUR_DED_AMT, 0) + 
                                 NVL(YA.TD_DISABILITY_INSUR_DED_AMT, 0) +
                                 NVL(YA.TD_MEDIC_DED_AMT, 0) + 
                                 NVL(YA.TD_EDUCATION_DED_AMT, 0) + 
                                 NVL(YA.TD_POLI_DONAT_DED_AMT1, 0) + 
                                 NVL(YA.TD_POLI_DONAT_DED_AMT2, 0) +
                                 NVL(YA.TD_LEGAL_DONAT_DED_AMT, 0) + 
                                 NVL(YA.TD_DESIGN_DONAT_DED_AMT, 0)), 10, 0)  -- 139.Ư�����װ�����<2014�߰�>;
                        || LPAD(NVL(YA.TD_STAND_DED_AMT, 0), 10, 0) -- 140.ǥ�ؼ��װ���<2014�߰�>;
                        || LPAD(NVL(YA.TAX_DED_TAXGROUP_AMT, 0), 10, 0) -- 141.�������հ���;
                        || LPAD(NVL(YA.TAX_DED_HOUSE_DEBT_AMT, 0), 10, 0) -- 142.�������Ա�;
                        --|| LPAD(NVL(YA.TAX_DED_DONAT_POLI_AMT, 0), 10, 0) -- 143.�����ġ�ڱ�;
                        || LPAD(NVL(YA.TAX_DED_OUTSIDE_PAY_AMT, 0), 10, 0) -- 143.�ܱ�����;
                        || LPAD(NVL(YA.TD_HOUSE_MONTHLY_DED_AMT, 0), 10, 0) -- 144.�������װ���;
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
                                NVL(YA.TAX_DED_OUTSIDE_PAY_AMT, 0) + NVL(YA.TD_HOUSE_MONTHLY_DED_AMT, 0), 10, 0) -- 145.���װ�����;
                        --> ��������.
                        || LPAD(NVL(YA.FIX_IN_TAX_AMT, 0), 10, 0) -- 146.�ҵ漼;
                        || LPAD(NVL(YA.FIX_LOCAL_TAX_AMT, 0), 10, 0) -- 147.�ֹμ�;
                        || LPAD(NVL(YA.FIX_SP_TAX_AMT, 0), 10, 0) -- 148.��Ư��;
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
                        || LPAD((NVL(YA.PRE_IN_TAX_AMT, 0) - NVL(S_PW.IN_TAX_AMT, 0)), 10, 0) -- 149.��(��)�ҵ漼.
                        || LPAD((NVL(YA.PRE_LOCAL_TAX_AMT, 0) - NVL(S_PW.LOCAL_TAX_AMT, 0)), 10, 0) --150.��(��)�ֹμ�.
                        || LPAD((NVL(YA.PRE_SP_TAX_AMT, 0) - NVL(S_PW.SP_TAX_AMT, 0)), 10, 0) -- 151.��(��)��Ư��. 
                        
                        || LPAD(0, 10, 0) -- 152.��(��)��(��) �ٹ�ó���� ����Ư�ʼ��� �ҵ漼.
                        || LPAD(0, 10, 0) --153.��(��)��(��) �ٹ�ó���� ����Ư�ʼ��� �ֹμ�.
                        || LPAD(0, 10, 0) -- 154.��(��)��(��) �ٹ�ó���� ����Ư�ʼ��� ��Ư��.
                        
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
                                END, 1, 0)  -- 155. 0 <= ����¡������(�ҵ漼) < 1000 �� ��� "0"����;
                        || LPAD(ABS(TRUNC((NVL(YA.FIX_IN_TAX_AMT, 0) - NVL(YA.PRE_IN_TAX_AMT, 0)), -1)), 10, 0) -- 155.�����ҵ漼.
                        || LPAD(CASE
                                  WHEN TRUNC((NVL(YA.FIX_LOCAL_TAX_AMT, 0) - NVL(YA.PRE_LOCAL_TAX_AMT, 0)), -1) < 0 THEN 1
                                  ELSE 0
                                END, 1, 0)  -- 156. 0 <= ����¡������(�ֹμ�) < 1000 �� ��� "0"����;
                        || LPAD(ABS(TRUNC((NVL(YA.FIX_LOCAL_TAX_AMT, 0) - NVL(YA.PRE_LOCAL_TAX_AMT, 0)), -1)), 10, 0) -- 156.�����ֹμ�.
                        || LPAD(CASE
                                  WHEN TRUNC((NVL(YA.FIX_SP_TAX_AMT, 0) - NVL(YA.PRE_SP_TAX_AMT, 0)), -1) < 0 THEN 1
                                  ELSE 0
                                END, 1, 0)  -- 157. 0 <= ����¡������(��Ư��) < 1000 �� ��� "0"����;
                        || LPAD(ABS(TRUNC((NVL(YA.FIX_SP_TAX_AMT, 0) - NVL(YA.PRE_SP_TAX_AMT, 0)), -1)), 10, 0)  -- 157.���� ��Ư��.                      
                        --> 150.����.
                        || LPAD(' ', 28, ' ') AS RECORD_FILE
                        , NVL(YA.MEDIC_INSUR_AMT, 0) + NVL(YA.HIRE_INSUR_AMT, 0) AS MEDIC_INSUR_AMT  -- 'E'���ڵ忡�� ���(�ǰ�, ��뺸���).
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
                                , HRM_PERSON_MASTER_V  PM
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
                                  ) TS1 
                            WHERE PW.PERSON_ID          = PM.PERSON_ID
                              AND PM.PERSON_ID          = TS1.PERSON_ID 
                              AND PW.YEAR_YYYY          = P_YEAR_YYYY
                              AND PM.CORP_ID            = A1.CORP_ID
                              /*--�ϳ��� ��������� ó�� ���� -- 
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
                      /*--�ϳ��� ��������� ó�� ���� -- 
                      AND T1.OPERATING_UNIT_ID  = A1.OPERATING_UNIT_ID*/
                      AND YA.YEAR_YYYY          = P_YEAR_YYYY
                      AND YA.CORP_ID            = A1.CORP_ID
                      AND YA.SOB_ID             = P_SOB_ID
                      AND YA.ORG_ID             = P_ORG_ID
                      AND YA.SUBMIT_DATE        BETWEEN P_START_DATE AND P_END_DATE
                      --AND YA.INCOME_TOT_AMT     != 0
                      AND YA.ADJUST_DATE_TO     BETWEEN P_START_DATE AND P_END_DATE
                      
                      -- ���������� ����� �ο��� ���� --
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
                      -- ���� ��� ��ȸ -- 
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
                            || LPAD(CASE
                                      WHEN NVL(PW.RD_SMALL_BUSINESS_AMT, 0) = 0 THEN '0'
                                      ELSE NVL(TO_CHAR(PW.JOIN_DATE, 'YYYYMMDD'), P_YEAR_YYYY || '0101')
                                    END, 8, '0') -- 13.����Ⱓ ���ۿ�����;
                            || LPAD(CASE
                                      WHEN NVL(PW.RD_SMALL_BUSINESS_AMT, 0) = 0 THEN '0'
                                      ELSE NVL(TO_CHAR(PW.RETR_DATE, 'YYYYMMDD'), TO_CHAR(C1.JOIN_DATE - 1, 'YYYYMMDD'))
                                    END, 8, '0') -- 14.����Ⱓ ���Ῥ����;
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
                            || LPAD(NVL(PW.RD_SMALL_BUSINESS_AMT, 0), 10, 0) -- 52.�����-�߼ұ�� ���û�� �ҵ漼 ����;
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
                                    NVL(PW.NT_SEA_RESOURCE_AMT, 0) + 
                                    NVL(PW.RD_SMALL_BUSINESS_AMT, 0), 10, 0)  -- 55.����ҵ� ��;
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
                            /* -- 2014 �������� ���� -- 
                            || DECODE(SF.CHILD_YN, 'Y', '1', ' ') -- 13.�ڳ���������;*/
                            
                            || DECODE( CASE
                                         WHEN NVL(C1.WOMAN_DED_AMT, 0) = 0 THEN 'N'
                                         ELSE SF.WOMAN_YN
                                       END, 'Y', '1', ' ') -- 13.�γ��ڰ���;
                            -- 2009�� �������� ����(MODIFIED BY YOUNG MIN).��ο�� ��70���̻����� ����;
                            || CASE
                                 --WHEN SF.OLD_YN = 'Y' THEN '1'
                                 WHEN SF.OLD1_YN = 'Y' THEN '1'
                                 ELSE ' '
                               END -- 14.��ο�����;
                            -- 2009�� �������� ����(MODIFIED BY YOUNG MIN).����Ծ��ڰ����߰�;
                            /*-- 2014 �������� ���� -- 
                            || DECODE(SF.BIRTH_YN, 'Y', '1', ' ') -- 16.����Ծ��ڰ���.*/
                            
                            || DECODE( CASE
                                         WHEN NVL(C1.SINGLE_PARENT_DED_AMT, 0) = 0 THEN 'N'
                                         ELSE SF.SINGLE_PARENT_DED_YN
                                       END, 'Y', '1', ' ') -- 15.�Ѻθ�1 
                            /*-- 2009�� �������� ����(MODIFIED BY YOUNG MIN).���ڳ��߰����� ����;
                            || CASE
                                 WHEN SF.BASE_YN = 'Y' AND C1.MANY_CHILD_DED_AMT <> 0 AND SF.RELATION_CODE = '4' THEN '1'
                                 ELSE ' '
                               END -- ���ڳ��߰�����;*/
                            || DECODE(SF.BIRTH_YN, 'Y', '1', ' ') -- 16.���/�Ծ�;
                            || DECODE(SF.CHILD_YN, 'Y', '1', ' ') -- 17.6������;
                            
                            --> ����û �ڷ�.
                            -- 2009�� �������� ����(MODIFIED BY YOUNG MIN).����û�ڷ� �����ݾ��� ������ ��� 0���� ǥ��;
                            || LPAD(CASE
                                       WHEN DECODE(SF.RELATION_CODE, 0, NVL(C1.MEDIC_INSUR_AMT, 0), 0) < 0 THEN 0
                                       ELSE NVL(SF.MEDIC_INSUR_AMT, 0) + NVL(SF.HIRE_INSUR_AMT, 0)
                                     END, 10, 0) -- 18.�����(������ �ǰ������ ����);
                            || LPAD(NVL(SF.INSURE_AMT, 0), 10, 0)            -- 19.���强�����;
                            || LPAD(NVL(SF.DISABILITY_INSURE_AMT, 0), 10, 0) -- 20.����� ���� ���强 �����;
                            || LPAD(NVL(SF.MEDICAL_AMT, 0), 10, 0) -- 21.�Ƿ��;
                            || LPAD(NVL(SF.EDUCATION_AMT, 0), 10, 0) -- 22.������;
                            || LPAD(NVL(SF.CREDIT_AMT, 0), 10, 0) -- 23.�ſ�ī���;
                            || LPAD(NVL(SF.CHECK_CREDIT_AMT , 0), 10, 0) -- 24.����ī��;
                            || LPAD(NVL(SF.CASH_AMT, 0) + NVL(SF.ACADE_GIRO_AMT, 0), 10, 0) -- 25.���ݿ�����;
                            --2012�� �������� �߰� START --
                            || LPAD(NVL(SF.TRAD_MARKET_AMT, 0), 10, 0) -- 26.����������;
                            || LPAD(NVL(SF.PUBLIC_TRANSIT_AMT, 0), 10, 0) -- 27.���߱����̿��1;
                            --2012�� �������� �߰� END --
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
                                    END, 13, 0)  -- 28.��α�(��ġ�ڱ� ��α��� 10���� ���� ���װ��� ��α� ����ݾ��� ����).
                            -->����û�ڷ� �̿�.
                            || LPAD((CASE
                                       WHEN DECODE(SF.RELATION_CODE, 0, NVL(C1.MEDIC_INSUR_AMT, 0), 0) < 0 THEN 0
                                       ELSE DECODE(SF.RELATION_CODE, 0, NVL(SF.ETC_MEDIC_INSUR_AMT, 0) + NVL(SF.ETC_HIRE_INSUR_AMT, 0) + 
                                                                        NVL(C1.MEDIC_INSUR_AMT, 0), 0) 
                                     END), 10, 0) -- 29.����û�������� �ǰ�/��뺸��;
                            || LPAD(NVL(SF.ETC_INSURE_AMT, 0), 10, 0) -- 30.����û�������� �����;
                            || LPAD(NVL(SF.ETC_DISABILITY_INSURE_AMT, 0), 10, 0) -- 31.����û�������� ����� �����;
                            
                            || LPAD(NVL(SF.ETC_MEDICAL_AMT, 0), 10, 0) -- 32.����û�������� �Ƿ��;
                            || LPAD(NVL(SF.ETC_EDUCATION_AMT, 0), 10, 0) -- 33.����û�������� ������;
                            || LPAD(NVL(SF.ETC_CREDIT_AMT, 0) + NVL(SF.ETC_ACADE_GIRO_AMT, 0), 10, 0) -- 34.����û�������� �ſ�ī��;
                            || LPAD(NVL(SF.ETC_CHECK_CREDIT_AMT, 0), 10, 0) -- 35.����û�������� ����ī��;
                            --2012�� �������� �߰� START --
                            || LPAD(NVL(SF.ETC_TRAD_MARKET_AMT, 0), 10, 0) -- 36.����������;
                            || LPAD(NVL(SF.ETC_PUBLIC_TRANSIT_AMT, 0), 10, 0)  -- 37. ���߱����̿��;
                            --2012�� �������� �߰� END --
                            || LPAD(/*NVL(SF.ETC_DONAT_ALL, 0) +
                                    NVL(SF.ETC_DONAT_50P, 0) +
                                    NVL(SF.ETC_DONAT_30P, 0) +
                                    NVL(SF.ETC_DONAT_10P, 0) +
                                    NVL(SF.ETC_DONAT_10P_RELIGION, 0)*/0, 13, 0) AS RECORD_LINE -- 38.����û�������� ��α�;
                         FROM HRA_SUPPORT_FAMILY_V SF
                            , ( SELECT DI.YEAR_YYYY
                                     , DI.SOB_ID
                                     , DI.ORG_ID
                                     , DI.PERSON_ID
                                     , DI.REPRE_NUM
                                     , CASE
                                         WHEN SUM(DI.DONA_AMT) < 100000 THEN SUM(DI.DONA_AMT)
                                         ELSE 100000
                                       END  AS DONA_AMT -- ��ġ�ڱ� ��α� 10���� ���� �ݾ��� ���� ���� -- 
                                  FROM HRA_DONATION_INFO_V DI
                                 WHERE DI.YEAR_YYYY            = P_YEAR_YYYY
                                   AND DI.SOB_ID               = P_SOB_ID
                                   AND DI.ORG_ID               = P_ORG_ID
                                   AND DI.PERSON_ID            = C1.PERSON_ID 
                                   AND DI.DONA_TYPE            = '20'  -- ��ġ�ڱ� ��α� 
                                   AND DI.RELATION_CODE        = '0'   -- ���� -- 
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
              --> �ξ簡���� 5�� �̻��� ���.
              IF V_E_REC_STD <= V_RECORD_COUNT THEN
                V_SEQ_NO := NVL(V_SEQ_NO, 0) + 1;  -- �ξ簡�� ���� �Ϸù�ȣ.
                V_RECORD_FILE := V_RECORD_FILE 
                                 || LPAD(NVL(V_SEQ_NO, 1), 2, 0)  -- �Ϸù�ȣ.
                                 || RPAD(' ', 253, ' ');   -- ����.
                                 
                
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
                              || RPAD(' ', 1, ' ')             -- 7.����;
                              || RPAD(' ', 1, ' ')             -- 8.��/�ܱ��� ���� �ڵ�;
                              || RPAD(' ', 20, ' ')            -- 9.����;
                              || RPAD(' ', 13, ' ')            -- 10.�ֹι�ȣ;
                              || ' '                           -- 11.�⺻����;
                              || ' '                           -- 12.����ΰ���;
                              || ' '                           -- 13.�γ��ڰ���;
                              || ' '                           -- 14.��ο�����;
                              || ' '                           -- 15.�Ѻθ�1 
                              || ' '                           -- 16.����Ծ�1
                              || ' '                           -- 17.6������1
                              --> ����û �ڷ� : ����û�ڷ� �����ݾ��� ������ ��� 0���� ǥ��;
                              || LPAD(0, 10, 0)                 -- 18.�����(������ �ǰ������ ����);
                              || LPAD(0, 10, 0)                 -- 19.���强�����;
                              || LPAD(0, 10, 0)                 -- 20.����� ���� ���强 �����;
                              || LPAD(0, 10, 0)                 -- 21.�Ƿ��;
                              || LPAD(0, 10, 0)                 -- 22.������;
                              || LPAD(0, 10, 0)                 -- 23.�ſ�ī���;
                              || LPAD(0, 10, 0)                 -- 24.����ī��;
                              || LPAD(0, 10, 0)                 -- 25.���ݿ�����;
                              || LPAD(0, 10, 0)                 -- 26.����������;
                              || LPAD(0, 10, 0)                 -- 27.���߱����̿��1;
                              || LPAD(0, 13, 0)                 -- 28.��α�(��ġ�ڱ� ��α��� 10���� ���� ���װ��� ��α� ����ݾ��� ����).
                              -->����û�ڷ� �̿�.
                              || LPAD(0, 10, 0)                 -- 29.����û�������� �ǰ�/��뺸��;
                              || LPAD(0, 10, 0)                 -- 30.����û�������� �����;
                              || LPAD(0, 10, 0)                 -- 31.����û�������� ����� �����;
                              || LPAD(0, 10, 0)                 -- 32.����û�������� �Ƿ��;
                              || LPAD(0, 10, 0)                 -- 33.����û�������� ������;
                              || LPAD(0, 10, 0)                 -- 34.����û�������� �ſ�ī��;
                              || LPAD(0, 10, 0)                 -- 35.����û�������� ����ī��;
                              || LPAD(0, 10, 0)                 -- 36.����������;
                              || LPAD(0, 10, 0)                 -- 37.���߱����̿��;
                              || LPAD(0, 13, 0);                -- 38.��αݿ�;
              END LOOP E1S;
              IF V_RECORD_FILE IS NOT NULL THEN
                V_SEQ_NO := NVL(V_SEQ_NO, 0) + 1;  -- �ξ簡�� ���� �Ϸù�ȣ.
                V_RECORD_FILE := V_RECORD_FILE 
                                 || LPAD(NVL(V_SEQ_NO, 1), 2, 0)  -- �Ϸù�ȣ.
                                 || RPAD(' ', 253, ' ');  -- ����.
                                 
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
                            || RPAD(YB.YEAR_BANK_NAME, 50, ' ') -- 9.������� ��ȣ����;
                            || RPAD(SI.ACCOUNT_NUM, 20, ' ') -- 10.���¹�ȣ;
                            /* -- 2014�⵵ �������� ���� 
                            || LPAD(DECODE(SI.SAVING_TYPE, '41', CASE WHEN 3 < SI.SAVING_COUNT THEN 3 ELSE SI.SAVING_COUNT END , '0'), 2, 0) -- 11.���Կ���-����ֽ������ุ �ش�;
                            */
                            || LPAD(NVL(SI.SAVING_AMOUNT, 0), 10, 0) -- 11.���Աݾ�;
                            || LPAD(NVL(CASE
                                          WHEN ST.TAX_DED_FLAG = 'Y' THEN SI.SAVING_REAL_DED_AMT
                                          ELSE SI.SAVING_DED_AMOUNT
                                        END, 0), 10, 0) AS RECORD_LINE               -- 12.�����ݾ�;
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
              --> ��������� ���� 15�� �̻��� ���.
              IF V_F_REC_STD <= V_RECORD_COUNT THEN
                V_SEQ_NO := NVL(V_SEQ_NO, 0) + 1;  -- �������� ���� �Ϸù�ȣ.
                V_RECORD_FILE := V_RECORD_FILE || RPAD(' ', 120, ' ');  -- ����.
                
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
                V_SEQ_NO := NVL(V_SEQ_NO, 0) + 1;  -- �������� ���� �Ϸù�ȣ.
                V_RECORD_FILE := V_RECORD_FILE || RPAD(' ', 120, ' ');  -- ��������  �ҵ������ ���� ���� => ����.
                
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
            V_REC_TEMP_1 := RPAD(' ', 20, ' ') ||  -- 7.�Ӵ��� ����
                            RPAD(' ', 13, ' ') || -- 8.�ֹε�Ϲ�ȣ(����ڹ�ȣ) 
                            RPAD(' ', 1, ' ') ||  -- 9.��������1 
                            LPAD(0, 5, 0) ||  -- 10.���ð����� 
                            RPAD(' ', 100, ' ') ||  -- 11.�Ӵ�����༭�� �ּ��� 
                            LPAD(0, 8, 0) ||  -- 12.�Ӵ������Ⱓ ���� 
                            LPAD(0, 8, 0) ||  -- 13.�Ӵ������Ⱓ ���� 
                            LPAD(0, 10, 0) ||  -- 14.������ 
                            LPAD(0, 10, 0);    -- 15.���װ����ݾ� 
            V_REC_TEMP_2 := RPAD(' ', 20, ' ') ||  -- 16.���ּ��� 
                            RPAD(' ', 13, ' ') || -- 17.���� �ֹι�ȣ 
                            LPAD(0, 8, 0) ||  -- 18.�����Һ���� ���Ⱓ ���� 
                            LPAD(0, 8, 0) ||  -- 19.�����Һ���� ���Ⱓ ���� 
                            LPAD(0, 4, 0) ||  -- 20.���Ա� ������ 
                            LPAD(0, 10, 0) ||  -- 21.������ ��ȯ�װ� 
                            LPAD(0, 10, 0) ||  -- 22.���� 
                            LPAD(0, 10, 0) ||  -- 23.���� 
                            LPAD(0, 10, 0) ||  -- 24.�����ݾ� 
                            RPAD(' ', 20, ' ') ||  -- 25.�Ӵ��� ����
                            RPAD(' ', 13, ' ') || -- 26.�ֹε�Ϲ�ȣ(����ڹ�ȣ) 
                            RPAD(' ', 1, ' ') ||  -- 27.�������� 
                            LPAD(0, 5, 0) ||      -- 28.���ð����� 
                            RPAD(' ', 100, ' ') ||  -- 29.�Ӵ�����༭�� �ּ��� 
                            LPAD(0, 8, 0) ||  -- 30.�Ӵ������Ⱓ ���� 
                            LPAD(0, 8, 0) ||  -- 31.�Ӵ������Ⱓ ����                             
                            LPAD(0, 10, 0);   -- 32.���������� 
            V_RECORD_FILE := NULL;
            V_SEQ_NO    := 0;
            V_RECORD_COUNT := 0;
            FOR G1 IN ( SELECT 'G' --1.RECORD_TYPE
                            || '20' --2. DATA_TYPE
                            || RPAD(NVL(B1.TAX_OFFICE_CODE, ' '), 3, ' ') -- 3.�������ڵ�.
                            || LPAD(C1.C_SEQ_NO, 6, 0) -- 4.C���ڵ��� �Ϸù�ȣ.
                            || RPAD(NVL(B1.VAT_NUMBER, ' '), 10, ' ') -- 5.����ڹ�ȣ.
                            || RPAD(NVL(C1.REPRE_NUM, ' '), 13, ' ') AS RECORD_HEADER -- 6.�ֹι�ȣ.
                            
                             , HL.HOUSE_LEASE_INFO_10 AS HOUSE_LEASE_INFO_10
                             , HL.HOUSE_LEASE_INFO_20 AS HOUSE_LEASE_INFO_20
                          FROM (SELECT ROWNUM AS ROW_NUM 
                                     , RPAD(NVL(HLI.LESSOR_NAME, ' '), 20, ' ') ||  -- 7.�Ӵ��� ����
                                       RPAD(NVL(REPLACE(HLI.LESSOR_REPRE_NUM, '-', ''), ' '), 13, ' ') || -- 8.�ֹε�Ϲ�ȣ(����ڹ�ȣ) 
                                       RPAD(NVL(HLI.HOUSE_TYPE, ' '), 1, ' ') ||  -- 9.�������� 
                                       LPAD(REPLACE(CASE
                                                       WHEN 999.99 < TRUNC(NVL(HLI.HOUSE_AREA, 0), 2) THEN 999.99
                                                       ELSE TRUNC(NVL(HLI.HOUSE_AREA, 0), 2) 
                                                     END, '.', ''), 5, 0) ||  -- 10.���ð����� 
                                       RPAD(NVL(HLI.LEASE_ADDR1, ' ') || ' ' || NVL(HLI.LEASE_ADDR2, ' '), 100, ' ') ||  --  11.�Ӵ�����༭�� �ּ��� 
                                       LPAD(NVL(TO_CHAR(HLI.LEASE_TERM_FR, 'YYYYMMDD'), '0'), 8, 0) ||  -- 12.�Ӵ������Ⱓ ���� 
                                       LPAD(NVL(TO_CHAR(HLI.LEASE_TERM_TO, 'YYYYMMDD'), '0'), 8, 0) ||  -- 13.�Ӵ������Ⱓ ���� 
                                       LPAD(NVL(HLI.MONTLY_LEASE_AMT, 0), 10, 0) ||  -- 14.������ 
                                       LPAD(NVL(HLI.HOUSE_DED_AMT, 0), 10, 0) AS HOUSE_LEASE_INFO_10  -- 15.���װ����ݾ� 
                                     , NULL AS HOUSE_LEASE_INFO_20
                                  FROM HRA_HOUSE_LEASE_INFO_V HLI
                                WHERE HLI.YEAR_YYYY         = P_YEAR_YYYY
                                  AND HLI.PERSON_ID         = C1.PERSON_ID
                                  AND HLI.SOB_ID            = P_SOB_ID
                                  AND HLI.ORG_ID            = P_ORG_ID
                                  AND HLI.HOUSE_LEASE_TYPE  = '10'  -- ����  
                                  AND HLI.HOUSE_DED_AMT     != 0    -- �����ݾ� �ִ°͸� ó�� 
                                UNION ALL
                                SELECT ROWNUM AS ROW_NUM 
                                     , NULL AS HOUSE_LEASE_INFO_10
                                     , RPAD(NVL(HLI.LOANER_NAME, ' '), 20, ' ') ||  -- 16.���ּ��� 
                                       RPAD(NVL(REPLACE(HLI.LOANER_REPRE_NUM, '-', ''), ' '), 13, ' ') || -- 17.���� �ֹι�ȣ 
                                       LPAD(NVL(TO_CHAR(HLI.LOAN_TERM_FR, 'YYYYMMDD'), '0'), 8, 0) ||  -- 18.�����Һ���� ���Ⱓ ���� 
                                       LPAD(NVL(TO_CHAR(HLI.LOAN_TERM_TO, 'YYYYMMDD'), '0'), 8, 0) ||  -- 19.�����Һ���� ���Ⱓ ���� 
                                       LPAD(NVL(TRUNC(HLI.LOAN_INTEREST_RATE, 2), 0), 4, 0) ||  -- 20.���Ա� ������ 
                                       LPAD((NVL(HLI.LOAN_AMT, 0) + NVL(HLI.LOAN_INTEREST_AMT, 0)), 10, 0) ||  -- 21.������ ��ȯ�װ� 
                                       LPAD(NVL(HLI.LOAN_AMT, 0), 10, 0) ||  -- 22.���� 
                                       LPAD(NVL(HLI.LOAN_INTEREST_AMT, 0), 10, 0) ||  -- 23.���� 
                                       LPAD(NVL(HLI.HOUSE_DED_AMT, 0), 10, 0) ||  -- 24.�����ݾ� 
                                       RPAD(NVL(HLI.LESSOR_NAME, ' '), 20, ' ') ||  -- 25.�Ӵ��� ����
                                       RPAD(NVL(REPLACE(HLI.LESSOR_REPRE_NUM, '-', ''), ' '), 13, ' ') || -- 26.�ֹε�Ϲ�ȣ(����ڹ�ȣ) 
                                       RPAD(NVL(HLI.HOUSE_TYPE, ' '), 1, ' ') ||  -- 27.�������� 
                                       LPAD(REPLACE(CASE
                                                       WHEN 999.99 < TRUNC(NVL(HLI.HOUSE_AREA, 0), 2) THEN 999.99
                                                       ELSE TRUNC(NVL(HLI.HOUSE_AREA, 0), 2) 
                                                     END, '.', ''), 5, 0) ||  -- 28.���ð����� 
                                       RPAD(NVL(HLI.LEASE_ADDR1, ' ') || ' ' || NVL(HLI.LEASE_ADDR2, ' '), 100, ' ') ||  --  ��29.������༭�� �ּ��� 
                                       LPAD(NVL(TO_CHAR(HLI.LEASE_TERM_FR, 'YYYYMMDD'), '0'), 8, 0) ||  -- 30.�Ӵ������Ⱓ ���� 
                                       LPAD(NVL(TO_CHAR(HLI.LEASE_TERM_TO, 'YYYYMMDD'), '0'), 8, 0) ||  -- 31.�Ӵ������Ⱓ ���� 
                                       LPAD(NVL(HLI.DEPOSIT_AMT, 0), 10, 0) AS HOUSE_LEASE_INFO_20  -- 32.����������            
                                  FROM HRA_HOUSE_LEASE_INFO_V HLI
                                WHERE HLI.YEAR_YYYY         = P_YEAR_YYYY
                                  AND HLI.PERSON_ID         = C1.PERSON_ID
                                  AND HLI.SOB_ID            = P_SOB_ID
                                  AND HLI.ORG_ID            = P_ORG_ID
                                  AND HLI.HOUSE_LEASE_TYPE  = '20'  -- ������ �����������Կ����� 
                               ) HL
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
                V_RECORD_FILE := V_RECORD_FILE || RPAD(' ', 244, ' ');  -- ����.
                
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
                V_RECORD_FILE := V_RECORD_FILE || RPAD(' ', 244, ' ');  -- ����.

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
  END SET_YEAR_ADJUST_FILE_2014;            

-------------------------------------------------------------------------------
-- 2013�⵵ �Ƿ�� ���ϻ���.
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
                  FROM HRA_MEDICAL_INFO_V MI
                    , HRM_PERSON_MASTER_V PM
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
                  /*--�ϳ��� ��������� ó�� ���� -- 
                  AND T1.OPERATING_UNIT_ID  = P_OPERATING_UNIT_ID */     
                  AND EXISTS
                        ( SELECT 'X'
                            FROM HRA_YEAR_ADJUSTMENT YA
                           WHERE YA.YEAR_YYYY         = MI.YEAR_YYYY
                             AND YA.PERSON_ID         = MI.PERSON_ID
                             AND YA.SOB_ID            = MI.SOB_ID
                             AND YA.ORG_ID            = MI.ORG_ID
                             AND YA.TD_MEDIC_DED_AMT  > 0            -- �Ƿ�� �����ݾ��� ���� �ϴ� �͸� ���� -- 
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
-- 2013�⵵ ��α� ���ϻ���.
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
                                    /*--�ϳ��� ��������� ó�� ���� -- 
                                    AND T1.OPERATING_UNIT_ID    = A1.OPERATING_UNIT_ID*/
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
                                    /*--�ϳ��� ��������� ó�� ���� -- 
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
                      /*--�ϳ��� ��������� ó�� ���� -- 
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
          FOR C2 IN ( -- ��α� ��������.
                      SELECT 'C' -- �ڷ������ȣ(���ڵ� ����);
                          || '27' -- �ڷᱸ��(���� 27);
                          || LPAD(A1.TAX_OFFICE_CODE, 3, '0') -- �������ڵ�;
                          || LPAD(C1.SEQ_NO, 6, '0')   -- �Ϸù�ȣ.
                              -- �Ϸù�ȣ;
  /*                              || LPAD(ROWNUM, 6, 0) --AS SEQ_NO    -- �Ϸù�ȣ;*/
                          || RPAD(A1.VAT_NUMBER, 10, ' ') -- ����ڵ�Ϲ�ȣ;
                          || RPAD(REPLACE(PM.REPRE_NUM, '-', ''), 13, ' ') -- �ҵ����� �ֹε�Ϲ�ȣ;
                          || RPAD(CASE
                                    WHEN SUBSTR(REPLACE(PM.REPRE_NUM, '-', ''), 7, 1) BETWEEN '5' AND '8' THEN '9'
                                    ELSE '1'
                                  END, 1, '0') -- ���ܱ��� �����ڵ�;
                          || RPAD(PM.NAME, 30, ' ') -- �ҵ����� ����;
                          || RPAD(NVL(DA.DONA_TYPE, ' '), 2, ' ') -- ����ڵ�;
                          || LPAD(DA.DONA_YYYY, 4, '0')           -- ��γ⵵;
                          || LPAD(NVL(DA.DONA_AMT, '0'), 13, '0') -- ��αݾ�(�����,���ó��,������ �ջ�);
                          || LPAD(NVL(DA.PRE_DONA_DED_AMT, 0), 13, '0') -- ������� ������ �ݾ�;
                          || LPAD(NVL(DA.TOTAL_DONA_AMT, 0), 13, '0') -- �������ݾ�;
                          || LPAD(NVL(DA.DONA_DED_AMT, 0), 13, '0')    -- �ش�⵵ �����ݾ�;
                          || LPAD(NVL(DA.LAPSE_DONA_AMT, 0), 13, '0')    -- �ش�⵵ �Ҹ�ݾ�;
                          || LPAD(NVL(DA.NEXT_DONA_AMT, 0), 13, '0')    -- �ش�⵵ �̿��ݾ�;
                          || LPAD(ROW_NUMBER() OVER(PARTITION BY PM.PERSON_NUM ORDER BY PM.PERSON_NUM, DA.YEAR_YYYY), 5, '0')         -- ��α������� �Ϸù�ȣ;
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
          FOR D1 IN ( -- ��α� ����.
                      SELECT 'D' -- �ڷ������ȣ(���ڵ� ����);
                          || '27' -- �ڷᱸ��(���� 27);
                          || LPAD(A1.TAX_OFFICE_CODE, 3, '0') -- �������ڵ�;
                          || LPAD(C1.SEQ_NO, 6, '0')    -- �Ϸù�ȣ;
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
                          || LPAD(NVL(DI.DONA_COUNT, 0), 5, '0') --���Ƚ��(�����,���ó��,������ �ջ�);
                          || LPAD(NVL(DI.DONA_AMT, 0), 13, '0') -- ��α�(�����,���ó��,������ �ջ�);/*|| LPAD(I_YEAR_YYYY || '0101', 8, 0) --AS TAX_PERIOD_START
                          || LPAD(ROW_NUMBER() OVER(PARTITION BY PM.PERSON_NUM ORDER BY PM.PERSON_NUM), 5, '0')
                          --|| LPAD(C1.SORT_NUM, 5, 0)         -- ��α������� �Ϸù�ȣ;
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
        
END HRA_YEAR_RE_ADJUSTMENT_G;
/
