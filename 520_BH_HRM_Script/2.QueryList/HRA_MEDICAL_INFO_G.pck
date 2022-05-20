CREATE OR REPLACE PACKAGE HRA_MEDICAL_INFO_G AS

  /*======================================================================/
       ++ 의료비 명세서 작성 대상자 조회 ++
  /======================================================================*/
  PROCEDURE SELECT_PERSON
            ( P_CURSOR            OUT TYPES.TCURSOR3
            , W_CORP_ID           IN NUMBER
            , W_PERSON_ID         IN NUMBER
            , W_DEPT_ID           IN NUMBER
            , W_FLOOR_ID          IN NUMBER
            , W_YEAR_YYYY         IN VARCHAR2
            , W_SOB_ID            IN NUMBER
            , W_ORG_ID            IN NUMBER
            );
            
  /*======================================================================/
       ++ 의료비 명세서 관리 ++
  /======================================================================*/
  PROCEDURE SELECT_MEDICAL_INFO
            ( P_CURSOR            OUT TYPES.TCURSOR
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN VARCHAR2
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            );
            
  /*======================================================================/
       ++ 의료비 명세서 관리 : 합계 금액 RETURN ++
  /======================================================================*/
  PROCEDURE MEDICAL_INFO_SUM_P
            ( W_YEAR_YYYY         IN  VARCHAR2
            , W_PERSON_ID         IN  VARCHAR2
            , W_SOB_ID            IN  NUMBER
            , W_ORG_ID            IN  NUMBER
            , O_CREDIT_COUNT      OUT NUMBER
            , O_CREDIT_AMT        OUT NUMBER
            , O_ETC_COUNT         OUT NUMBER
            , O_ETC_AMT           OUT NUMBER 
            );

-- 삽입 : 의료비명세서.
  PROCEDURE INSERT_MEDICAL_INFO
            ( P_MEDICAL_INFO_ID OUT HRA_MEDICAL_INFO.MEDICAL_INFO_ID%TYPE
            , P_YEAR_YYYY       IN HRA_MEDICAL_INFO.YEAR_YYYY%TYPE
            , P_PERSON_ID       IN HRA_MEDICAL_INFO.PERSON_ID%TYPE
            , P_SOB_ID          IN HRA_MEDICAL_INFO.SOB_ID%TYPE
            , P_ORG_ID          IN HRA_MEDICAL_INFO.ORG_ID%TYPE
            , P_RELATION_CODE   IN HRA_MEDICAL_INFO.RELATION_CODE%TYPE
            , P_FAMILY_NAME     IN HRA_MEDICAL_INFO.FAMILY_NAME%TYPE
            , P_REPRE_NUM       IN HRA_MEDICAL_INFO.REPRE_NUM%TYPE
            , P_DISABILITY_YN   IN HRA_MEDICAL_INFO.DISABILITY_YN%TYPE
            , P_OLD_YN          IN HRA_MEDICAL_INFO.OLD_YN%TYPE
            , P_EVIDENCE_CODE   IN HRA_MEDICAL_INFO.EVIDENCE_CODE%TYPE
            , P_MEDIC_TYPE      IN HRA_MEDICAL_INFO.MEDIC_TYPE%TYPE
            , P_CORP_NAME       IN HRA_MEDICAL_INFO.CORP_NAME%TYPE
            , P_CORP_TAX_REG_NO IN HRA_MEDICAL_INFO.CORP_TAX_REG_NO%TYPE
            , P_CREDIT_COUNT    IN HRA_MEDICAL_INFO.CREDIT_COUNT%TYPE
            , P_CREDIT_AMT      IN HRA_MEDICAL_INFO.CREDIT_AMT%TYPE
            , P_ETC_COUNT       IN HRA_MEDICAL_INFO.ETC_COUNT%TYPE
            , P_ETC_AMT         IN HRA_MEDICAL_INFO.ETC_AMT%TYPE
            , P_DESCRIPTION     IN HRA_MEDICAL_INFO.DESCRIPTION%TYPE
            , P_USER_ID         IN HRA_MEDICAL_INFO.CREATED_BY%TYPE
            );

-- 수정 : 의료비 명세서.
  PROCEDURE UPDATE_MEDICAL_INFO
            ( W_MEDICAL_INFO_ID IN HRA_MEDICAL_INFO.MEDICAL_INFO_ID%TYPE
            , P_SOB_ID          IN HRA_MEDICAL_INFO.SOB_ID%TYPE
            , P_ORG_ID          IN HRA_MEDICAL_INFO.ORG_ID%TYPE
            , P_RELATION_CODE   IN HRA_MEDICAL_INFO.RELATION_CODE%TYPE
            , P_FAMILY_NAME     IN HRA_MEDICAL_INFO.FAMILY_NAME%TYPE
            , P_REPRE_NUM       IN HRA_MEDICAL_INFO.REPRE_NUM%TYPE
            , P_DISABILITY_YN   IN HRA_MEDICAL_INFO.DISABILITY_YN%TYPE
            , P_OLD_YN          IN HRA_MEDICAL_INFO.OLD_YN%TYPE
            , P_EVIDENCE_CODE   IN HRA_MEDICAL_INFO.EVIDENCE_CODE%TYPE
            , P_MEDIC_TYPE      IN HRA_MEDICAL_INFO.MEDIC_TYPE%TYPE
            , P_CORP_NAME       IN HRA_MEDICAL_INFO.CORP_NAME%TYPE
            , P_CORP_TAX_REG_NO IN HRA_MEDICAL_INFO.CORP_TAX_REG_NO%TYPE
            , P_CREDIT_COUNT    IN HRA_MEDICAL_INFO.CREDIT_COUNT%TYPE
            , P_CREDIT_AMT      IN HRA_MEDICAL_INFO.CREDIT_AMT%TYPE
            , P_ETC_COUNT       IN HRA_MEDICAL_INFO.ETC_COUNT%TYPE
            , P_ETC_AMT         IN HRA_MEDICAL_INFO.ETC_AMT%TYPE
            , P_DESCRIPTION     IN HRA_MEDICAL_INFO.DESCRIPTION%TYPE
            , P_USER_ID         IN HRA_MEDICAL_INFO.CREATED_BY%TYPE
            );

-- 삭제 : 의료비 명세서.
  PROCEDURE DELETE_MEDICAL_INFO
            ( W_MEDICAL_INFO_ID IN HRA_MEDICAL_INFO.MEDICAL_INFO_ID%TYPE
            );

END HRA_MEDICAL_INFO_G;
/
CREATE OR REPLACE PACKAGE BODY HRA_MEDICAL_INFO_G
AS
/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRA_MEDICAL_INFO_G
/* Description  : 연말정산 의료비 관리 패키지
/*
/* Reference by :
/* Program History :
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
  /*======================================================================/
       ++ 의료비 명세서 작성 대상자 조회 ++
  /======================================================================*/
  PROCEDURE SELECT_PERSON
            ( P_CURSOR            OUT TYPES.TCURSOR3
            , W_CORP_ID           IN NUMBER
            , W_PERSON_ID         IN NUMBER
            , W_DEPT_ID           IN NUMBER
            , W_FLOOR_ID          IN NUMBER
            , W_YEAR_YYYY         IN VARCHAR2
            , W_SOB_ID            IN NUMBER
            , W_ORG_ID            IN NUMBER
            )
  AS
    V_START_DATE        DATE;
    V_END_DATE          DATE;
  BEGIN
    V_START_DATE := TO_DATE(W_YEAR_YYYY || '-01-01', 'YYYY-MM-DD');
    V_END_DATE := TO_DATE(W_YEAR_YYYY || '-12-31', 'YYYY-MM-DD');
    
    OPEN P_CURSOR FOR
      SELECT PM.NAME AS NAME
          , PM.PERSON_NUM
          , HRM_CORP_MASTER_G.CORP_NAME_F(PM.CORP_ID) AS CORP_NAME
          , HRM_DEPT_MASTER_G.DEPT_NAME_F(T1.DEPT_ID) AS DEPT_NAME
          , HRM_COMMON_G.ID_NAME_F(T1.FLOOR_ID) AS FLOOR_NAME
          , HRM_COMMON_G.ID_NAME_F(T1.POST_ID) AS POST_NAME
          , HRM_COMMON_G.ID_NAME_F(T1.PAY_GRADE_ID) AS PAY_GRADE_NAME  
          , HRM_COMMON_G.CODE_NAME_F('EMPLOYE_TYPE', PM.EMPLOYE_TYPE, W_SOB_ID, W_ORG_ID) AS EMPLOYE_TYPE_NAME
          , PM.ORI_JOIN_DATE
          , PM.JOIN_DATE
          , PM.RETIRE_DATE
          , PM.REPRE_NUM
          , EAPP_REGISTER_AGE_F(PM.REPRE_NUM, V_END_DATE, 0) AS AGE
          , PM.PERSON_ID
          , PM.CORP_ID
          , T1.DEPT_ID
          , T1.FLOOR_ID
          , T1.POST_ID
          , T1.PAY_GRADE_ID
      FROM HRM_PERSON_MASTER PM
        , (-- 시점 인사내역.
            SELECT HL.PERSON_ID
                  , HL.DEPT_ID
                  , HL.POST_ID
                  , HL.PAY_GRADE_ID
                  , HL.JOB_CATEGORY_ID
                  , HL.FLOOR_ID    
              FROM HRM_HISTORY_LINE HL  
            WHERE ((W_DEPT_ID         IS NULL AND 1 = 1)
              OR   (W_DEPT_ID         IS NOT NULL AND HL.DEPT_ID = W_DEPT_ID))
              AND ((W_FLOOR_ID         IS NULL AND 1 = 1)
              OR   (W_FLOOR_ID         IS NOT NULL AND HL.FLOOR_ID = W_FLOOR_ID))
              AND HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                            FROM HRM_HISTORY_LINE S_HL
                                           WHERE S_HL.CHARGE_DATE            <= V_END_DATE
                                             AND S_HL.PERSON_ID              = HL.PERSON_ID
                                           GROUP BY S_HL.PERSON_ID
                                         )
          ) T1
      WHERE PM.PERSON_ID            = T1.PERSON_ID
        AND PM.CORP_ID              = NVL(W_CORP_ID, PM.CORP_ID)
        AND PM.PERSON_ID            = NVL(W_PERSON_ID, PM.PERSON_ID)
        AND PM.JOIN_DATE            <= V_END_DATE
        AND (PM.RETIRE_DATE         >= V_START_DATE OR PM.RETIRE_DATE IS NULL)
        AND PM.SOB_ID               = W_SOB_ID
        AND PM.ORG_ID               = W_ORG_ID
        AND EXISTS
              ( SELECT 'X'
                  FROM HRA_YEAR_ADJUSTMENT YA
                 WHERE YA.PERSON_ID   = PM.PERSON_ID
                   AND YA.YEAR_YYYY   = W_YEAR_YYYY
                   AND YA.MEDIC_AMT   >= 2000000  -- 의료비 입력대상자 --
              )
      ORDER BY PM.PERSON_NUM
      ;
  END SELECT_PERSON;
  
  
  /*======================================================================/
       ++ 의료비 명세서 관리 ++
  /======================================================================*/
  PROCEDURE SELECT_MEDICAL_INFO
            ( P_CURSOR            OUT TYPES.TCURSOR
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN VARCHAR2
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            )
  AS
  BEGIN
    OPEN P_CURSOR FOR
      SELECT MI.CORP_NAME
          , MI.CORP_TAX_REG_NO
          , MI.EVIDENCE_CODE
          , HRM_COMMON_G.CODE_NAME_F('MEDIC_EVIDENCE', MI.EVIDENCE_CODE, MI.SOB_ID, MI.ORG_ID) AS EVIDENCE_DESC
          , MI.ETC_COUNT  -- 지급건수.
          , MI.ETC_AMT    -- 지급금액.
          , MI.RELATION_CODE
          , HRM_COMMON_G.CODE_NAME_F('YEAR_RELATION', MI.RELATION_CODE, MI.SOB_ID, MI.ORG_ID) AS RELATION_DESC
          , MI.FAMILY_NAME
          , MI.REPRE_NUM
          , MI.DISABILITY_YN
          , MI.OLD_YN
          , MI.MEDIC_TYPE
          , HRM_COMMON_G.CODE_NAME_F('MEDIC_TYPE', MI.MEDIC_TYPE, MI.SOB_ID, MI.ORG_ID) AS MEDIC_TYPE_DESC
          , MI.CREDIT_COUNT
          , MI.CREDIT_AMT
          , MI.YEAR_YYYY
          , MI.PERSON_ID          
          , MI.MEDICAL_INFO_ID
        FROM HRA_MEDICAL_INFO MI
      WHERE MI.YEAR_YYYY          = P_YEAR_YYYY
        AND MI.PERSON_ID          = P_PERSON_ID
        AND MI.SOB_ID             = P_SOB_ID
        AND MI.ORG_ID             = P_ORG_ID
      ORDER BY MI.RELATION_CODE
            , MI.CORP_TAX_REG_NO
       ;
  END SELECT_MEDICAL_INFO;
  
  /*======================================================================/
       ++ 의료비 명세서 관리 : 합계 금액 RETURN ++
  /======================================================================*/
  PROCEDURE MEDICAL_INFO_SUM_P
            ( W_YEAR_YYYY         IN  VARCHAR2
            , W_PERSON_ID         IN  VARCHAR2
            , W_SOB_ID            IN  NUMBER
            , W_ORG_ID            IN  NUMBER
            , O_CREDIT_COUNT      OUT NUMBER
            , O_CREDIT_AMT        OUT NUMBER
            , O_ETC_COUNT         OUT NUMBER
            , O_ETC_AMT           OUT NUMBER 
            )
  AS
  BEGIN
    BEGIN
      SELECT SUM(MI.CREDIT_COUNT) AS CREDIT_COUNT
           , SUM(MI.CREDIT_AMT) AS CREDIT_AMT
           , SUM(MI.ETC_COUNT) AS ETC_COUNT  -- 지급건수.
           , SUM(MI.ETC_AMT) AS ETC_AMT      -- 지급금액.
        INTO O_CREDIT_COUNT
           , O_CREDIT_AMT
           , O_ETC_COUNT
           , O_ETC_AMT
        FROM HRA_MEDICAL_INFO MI
      WHERE MI.YEAR_YYYY          = W_YEAR_YYYY
        AND MI.PERSON_ID          = W_PERSON_ID
        AND MI.SOB_ID             = W_SOB_ID
        AND MI.ORG_ID             = W_ORG_ID
       ;
    EXCEPTION WHEN OTHERS THEN
      O_CREDIT_COUNT      := 0;
      O_CREDIT_AMT        := 0;
      O_ETC_COUNT         := 0;
      O_ETC_AMT           := 0; 
    END;
  END MEDICAL_INFO_SUM_P;

-- 삽입 : 의료비명세서.
  PROCEDURE INSERT_MEDICAL_INFO
            ( P_MEDICAL_INFO_ID OUT HRA_MEDICAL_INFO.MEDICAL_INFO_ID%TYPE
            , P_YEAR_YYYY       IN HRA_MEDICAL_INFO.YEAR_YYYY%TYPE
            , P_PERSON_ID       IN HRA_MEDICAL_INFO.PERSON_ID%TYPE
            , P_SOB_ID          IN HRA_MEDICAL_INFO.SOB_ID%TYPE
            , P_ORG_ID          IN HRA_MEDICAL_INFO.ORG_ID%TYPE
            , P_RELATION_CODE   IN HRA_MEDICAL_INFO.RELATION_CODE%TYPE
            , P_FAMILY_NAME     IN HRA_MEDICAL_INFO.FAMILY_NAME%TYPE
            , P_REPRE_NUM       IN HRA_MEDICAL_INFO.REPRE_NUM%TYPE
            , P_DISABILITY_YN   IN HRA_MEDICAL_INFO.DISABILITY_YN%TYPE
            , P_OLD_YN          IN HRA_MEDICAL_INFO.OLD_YN%TYPE
            , P_EVIDENCE_CODE   IN HRA_MEDICAL_INFO.EVIDENCE_CODE%TYPE
            , P_MEDIC_TYPE      IN HRA_MEDICAL_INFO.MEDIC_TYPE%TYPE
            , P_CORP_NAME       IN HRA_MEDICAL_INFO.CORP_NAME%TYPE
            , P_CORP_TAX_REG_NO IN HRA_MEDICAL_INFO.CORP_TAX_REG_NO%TYPE
            , P_CREDIT_COUNT    IN HRA_MEDICAL_INFO.CREDIT_COUNT%TYPE
            , P_CREDIT_AMT      IN HRA_MEDICAL_INFO.CREDIT_AMT%TYPE
            , P_ETC_COUNT       IN HRA_MEDICAL_INFO.ETC_COUNT%TYPE
            , P_ETC_AMT         IN HRA_MEDICAL_INFO.ETC_AMT%TYPE
            , P_DESCRIPTION     IN HRA_MEDICAL_INFO.DESCRIPTION%TYPE
            , P_USER_ID         IN HRA_MEDICAL_INFO.CREATED_BY%TYPE
            )
  AS
    V_SYSDATE             DATE  := GET_LOCAL_DATE(P_SOB_ID);
    V_RECORD_COUNT        NUMBER := 0;
    V_REPRE_NUM           VARCHAR2(15);
  BEGIN
    /*-- 사업자번호 검증. : 검증 안함 BY JEON HO SU
    V_TAX_REG_NO := P_CORP_TAX_REG_NO;
    IF REPLACE(V_TAX_REG_NO, '-', '') IS NOT NULL THEN
      IF EAPP_NUM_DIGIT_CHECKER_G.CHECK_TAX_NUM_F(V_TAX_REG_NO) = 'N' THEN
        RAISE_APPLICATION_ERROR(-20011, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10009', NULL));
        RETURN;
      END IF;
      -- 사업자번호 FORMAT 적용.
      V_TAX_REG_NO := REPLACE(V_TAX_REG_NO, '-', '');
      V_TAX_REG_NO := SUBSTR(V_TAX_REG_NO, 1, 3) || '-' || SUBSTR(V_TAX_REG_NO, 4, 2) || '-' || SUBSTR(V_TAX_REG_NO, 6, 6);
    END IF;*/
    
    -- 주민번호 --
    IF P_REPRE_NUM IS NULL THEN
      V_REPRE_NUM := NULL;
    ELSE
      -- 주민번호 검증.
      IF EAPP_NUM_DIGIT_CHECKER_G.CHECK_REPRE_NUM_F(P_REPRE_NUM) = 'N' THEN
        RAISE_APPLICATION_ERROR(-20011, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10026', NULL));
        RETURN;
      END IF;
      -- 주민번호 형식 적용.
      V_REPRE_NUM := SUBSTR(RPAD(REPLACE(P_REPRE_NUM, '-', ''), 13, '*'), 1, 6) || '-' || SUBSTR(RPAD(REPLACE(P_REPRE_NUM, '-', ''), 13, '*'), 7, 13);
    END IF;
    
    BEGIN
      SELECT COUNT(MI.PERSON_ID) AS RECORD_COUNT
        INTO V_RECORD_COUNT
        FROM HRA_MEDICAL_INFO MI
      WHERE MI.YEAR_YYYY        = P_YEAR_YYYY
        AND MI.PERSON_ID        = P_PERSON_ID
        AND MI.REPRE_NUM        = V_REPRE_NUM
        AND MI.CORP_TAX_REG_NO  = P_CORP_TAX_REG_NO
        AND MI.SOB_ID           = P_SOB_ID
        AND MI.ORG_ID           = P_ORG_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_RECORD_COUNT := 0;
    END;
    IF V_RECORD_COUNT <> 0 THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_MSG_F('EAPP_90003', '&&FIELD_NAME:=의료비 지출자에 대한 사업자'));
      RETURN;
    END IF;
    
    SELECT HRA_MEDICAL_INFO_S1.NEXTVAL
      INTO P_MEDICAL_INFO_ID
      FROM DUAL;

    INSERT INTO HRA_MEDICAL_INFO
    ( MEDICAL_INFO_ID
    , YEAR_YYYY 
    , PERSON_ID 
    , SOB_ID 
    , ORG_ID 
    , RELATION_CODE 
    , FAMILY_NAME 
    , REPRE_NUM 
    , DISABILITY_YN 
    , OLD_YN 
    , EVIDENCE_CODE 
    , MEDIC_TYPE 
    , CORP_NAME 
    , CORP_TAX_REG_NO 
    , CREDIT_COUNT 
    , CREDIT_AMT 
    , ETC_COUNT 
    , ETC_AMT 
    , DESCRIPTION 
    , CREATION_DATE 
    , CREATED_BY 
    , LAST_UPDATE_DATE 
    , LAST_UPDATED_BY )
    VALUES
    ( P_MEDICAL_INFO_ID
    , P_YEAR_YYYY
    , P_PERSON_ID
    , P_SOB_ID
    , P_ORG_ID
    , P_RELATION_CODE
    , P_FAMILY_NAME
    , V_REPRE_NUM
    , NVL(P_DISABILITY_YN, 'N')
    , NVL(P_OLD_YN, 'N')
    , P_EVIDENCE_CODE
    , P_MEDIC_TYPE
    , P_CORP_NAME
    , P_CORP_TAX_REG_NO
    , NVL(P_CREDIT_COUNT, 0)
    , NVL(P_CREDIT_AMT, 0)
    , NVL(P_ETC_COUNT, 0)
    , NVL(P_ETC_AMT, 0)
    , P_DESCRIPTION
    , V_SYSDATE
    , P_USER_ID
    , V_SYSDATE
    , P_USER_ID );
  END INSERT_MEDICAL_INFO;

-- 수정 : 의료비 명세서.
  PROCEDURE UPDATE_MEDICAL_INFO
            ( W_MEDICAL_INFO_ID IN HRA_MEDICAL_INFO.MEDICAL_INFO_ID%TYPE
            , P_SOB_ID          IN HRA_MEDICAL_INFO.SOB_ID%TYPE
            , P_ORG_ID          IN HRA_MEDICAL_INFO.ORG_ID%TYPE
            , P_RELATION_CODE   IN HRA_MEDICAL_INFO.RELATION_CODE%TYPE
            , P_FAMILY_NAME     IN HRA_MEDICAL_INFO.FAMILY_NAME%TYPE
            , P_REPRE_NUM       IN HRA_MEDICAL_INFO.REPRE_NUM%TYPE
            , P_DISABILITY_YN   IN HRA_MEDICAL_INFO.DISABILITY_YN%TYPE
            , P_OLD_YN          IN HRA_MEDICAL_INFO.OLD_YN%TYPE
            , P_EVIDENCE_CODE   IN HRA_MEDICAL_INFO.EVIDENCE_CODE%TYPE
            , P_MEDIC_TYPE      IN HRA_MEDICAL_INFO.MEDIC_TYPE%TYPE
            , P_CORP_NAME       IN HRA_MEDICAL_INFO.CORP_NAME%TYPE
            , P_CORP_TAX_REG_NO IN HRA_MEDICAL_INFO.CORP_TAX_REG_NO%TYPE
            , P_CREDIT_COUNT    IN HRA_MEDICAL_INFO.CREDIT_COUNT%TYPE
            , P_CREDIT_AMT      IN HRA_MEDICAL_INFO.CREDIT_AMT%TYPE
            , P_ETC_COUNT       IN HRA_MEDICAL_INFO.ETC_COUNT%TYPE
            , P_ETC_AMT         IN HRA_MEDICAL_INFO.ETC_AMT%TYPE
            , P_DESCRIPTION     IN HRA_MEDICAL_INFO.DESCRIPTION%TYPE
            , P_USER_ID         IN HRA_MEDICAL_INFO.CREATED_BY%TYPE
            )
  IS
    V_SYSDATE             DATE  := GET_LOCAL_DATE(P_SOB_ID);
    V_RECORD_COUNT        NUMBER := 0;
    V_YEAR_YYYY           VARCHAR2(4);
    V_PERSON_ID           NUMBER;
    /*V_TAX_REG_NO          VARCHAR2(15);*/
    V_REPRE_NUM           VARCHAR2(15);
  BEGIN
    /*-- 사업자번호 검증. : 검증 안함 BY JEON HO SU
    V_TAX_REG_NO := P_CORP_TAX_REG_NO;
    IF REPLACE(V_TAX_REG_NO, '-', '') IS NOT NULL THEN
      IF EAPP_NUM_DIGIT_CHECKER_G.CHECK_TAX_NUM_F(V_TAX_REG_NO) = 'N' THEN
         RAISE_APPLICATION_ERROR(-20011, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10009', NULL));
         RETURN;
      END IF;
      -- 사업자번호 FORMAT 적용.
      V_TAX_REG_NO := REPLACE(V_TAX_REG_NO, '-', '');
      V_TAX_REG_NO := SUBSTR(V_TAX_REG_NO, 1, 3) || '-' || SUBSTR(V_TAX_REG_NO, 4, 2) || '-' || SUBSTR(V_TAX_REG_NO, 6, 6);
    END IF;*/
    
    -- 주민번호 --
    IF P_REPRE_NUM IS NULL THEN
      V_REPRE_NUM := NULL;
    ELSE
      -- 주민번호 검증.
      IF EAPP_NUM_DIGIT_CHECKER_G.CHECK_REPRE_NUM_F(P_REPRE_NUM) = 'N' THEN
        RAISE_APPLICATION_ERROR(-20011, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10026', NULL));
        RETURN;
      END IF;
      -- 주민번호 형식 적용.
      V_REPRE_NUM := SUBSTR(RPAD(REPLACE(P_REPRE_NUM, '-', ''), 13, '*'), 1, 6) || '-' || SUBSTR(RPAD(REPLACE(P_REPRE_NUM, '-', ''), 13, '*'), 7, 13);
    END IF;
    
    BEGIN
      SELECT MI.YEAR_YYYY
          , MI.PERSON_ID
        INTO V_YEAR_YYYY
          , V_PERSON_ID
        FROM HRA_MEDICAL_INFO MI
      WHERE MI.MEDICAL_INFO_ID  = W_MEDICAL_INFO_ID
      ;
      
      SELECT COUNT(MI.PERSON_ID) AS RECORD_COUNT
        INTO V_RECORD_COUNT
        FROM HRA_MEDICAL_INFO MI
      WHERE MI.YEAR_YYYY        = V_YEAR_YYYY
        AND MI.PERSON_ID        = V_PERSON_ID
        AND MI.REPRE_NUM        = V_REPRE_NUM
        AND MI.CORP_TAX_REG_NO  = P_CORP_TAX_REG_NO
        AND MI.SOB_ID           = P_SOB_ID
        AND MI.ORG_ID           = P_ORG_ID
        AND MI.MEDICAL_INFO_ID  <> W_MEDICAL_INFO_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_RECORD_COUNT := 0;
    END;
    IF V_RECORD_COUNT <> 0 THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_MSG_F('EAPP_90003', '&&FIELD_NAME:=의료비 지출자에 대한 사업자'));
      RETURN;
    END IF;
    
    UPDATE HRA_MEDICAL_INFO
      SET RELATION_CODE    = P_RELATION_CODE
        , FAMILY_NAME      = P_FAMILY_NAME
        , REPRE_NUM        = V_REPRE_NUM
        , DISABILITY_YN    = NVL(P_DISABILITY_YN, 'N')
        , OLD_YN           = NVL(P_OLD_YN, 'N')
        , EVIDENCE_CODE    = P_EVIDENCE_CODE
        , MEDIC_TYPE       = P_MEDIC_TYPE
        , CORP_NAME        = P_CORP_NAME
        , CORP_TAX_REG_NO  = P_CORP_TAX_REG_NO
        , CREDIT_COUNT     = NVL(P_CREDIT_COUNT, 0)
        , CREDIT_AMT       = NVL(P_CREDIT_AMT, 0)
        , ETC_COUNT        = NVL(P_ETC_COUNT, 0)
        , ETC_AMT          = NVL(P_ETC_AMT, 0)
        , DESCRIPTION      = P_DESCRIPTION
        , LAST_UPDATE_DATE = V_SYSDATE
        , LAST_UPDATED_BY  = P_USER_ID
    WHERE MEDICAL_INFO_ID  = W_MEDICAL_INFO_ID;
  END UPDATE_MEDICAL_INFO;

-- 삭제 : 의료비 명세서.
  PROCEDURE DELETE_MEDICAL_INFO
            ( W_MEDICAL_INFO_ID IN HRA_MEDICAL_INFO.MEDICAL_INFO_ID%TYPE
            )
  AS
  BEGIN
    DELETE FROM HRA_MEDICAL_INFO
    WHERE MEDICAL_INFO_ID  = W_MEDICAL_INFO_ID;
  END DELETE_MEDICAL_INFO;


END HRA_MEDICAL_INFO_G;
/
