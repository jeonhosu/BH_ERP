CREATE OR REPLACE PACKAGE HRM_OPERATING_UNIT_G
AS

-- CORP SELECT.
  PROCEDURE DATA_SELECT
	          ( P_CURSOR                            OUT TYPES.TCURSOR
						, W_CORP_ID                           IN NUMBER
						, W_SOB_ID                            IN NUMBER
						, W_ORG_ID                            IN NUMBER
						);

-- CORP INSERT..
  PROCEDURE DATA_INSERT
           ( P_CORP_ID                           IN NUMBER
            , P_OPERATING_UNIT_NAME               IN VARCHAR2
            , P_PRESIDENT_NAME                    IN VARCHAR2
            , P_ZIP_CODE                          IN VARCHAR2
            , P_ADDR1                             IN VARCHAR2
            , P_ADDR2                             IN VARCHAR2
            , P_VAT_NUMBER                        IN VARCHAR2
            , P_TAX_OFFICE_CODE                   IN VARCHAR2
            , P_TAX_OFFICE_NAME                   IN VARCHAR2
            , P_BUSINESS_TYPE                     IN VARCHAR2
            , P_BUSINESS_ITEM                     IN VARCHAR2
            , P_ORG_SORT_NUM                      IN NUMBER
            , P_TEL_NUMBER                        IN VARCHAR2
            , P_FAX_NUMBER                        IN VARCHAR2
            , P_HOMEPAGE_URL                      IN VARCHAR2
            , P_DEFAULT_FLAG                      IN VARCHAR2
            , P_USABLE                            IN VARCHAR2
            , P_START_DATE                        IN DATE
            , P_END_DATE                          IN DATE
            , P_SOB_ID                            IN NUMBER
            , P_ORG_ID                            IN NUMBER
            , P_USER_ID                           IN NUMBER
            , P_BUSINESS_CODE                     IN VARCHAR2
            , P_GENERALLY_TAX_CODE                IN VARCHAR2
            );

-- CORP INSERT..
  PROCEDURE DATA_UPDATE
           ( W_OPERATING_UNIT_ID                 IN NUMBER
            , P_OPERATING_UNIT_NAME               IN VARCHAR2
            , P_PRESIDENT_NAME                    IN VARCHAR2
            , P_ZIP_CODE                          IN VARCHAR2
            , P_ADDR1                             IN VARCHAR2
            , P_ADDR2                             IN VARCHAR2
            , P_VAT_NUMBER                        IN VARCHAR2
            , P_TAX_OFFICE_CODE                   IN VARCHAR2
            , P_TAX_OFFICE_NAME                   IN VARCHAR2
            , P_BUSINESS_TYPE                     IN VARCHAR2
            , P_BUSINESS_ITEM                     IN VARCHAR2
            , P_ORG_SORT_NUM                      IN NUMBER
            , P_TEL_NUMBER                        IN VARCHAR2
            , P_FAX_NUMBER                        IN VARCHAR2
            , P_HOMEPAGE_URL                      IN VARCHAR2
            , P_DEFAULT_FLAG                      IN VARCHAR2
            , P_USABLE                            IN VARCHAR2
            , P_START_DATE                        IN DATE
            , P_END_DATE                          IN DATE
            , P_USER_ID                           IN NUMBER
            , P_BUSINESS_CODE                     IN VARCHAR2
            , P_GENERALLY_TAX_CODE                IN VARCHAR2
            );

-- FUNCTION - 사업장 ID에 따른 사업장명 리턴.
  FUNCTION OPERATING_UNIT_NAME_F
          ( W_OPERATING_UNIT_ID                  IN NUMBER
          ) RETURN VARCHAR2;


-- LOOK UP : CORP_ID 에 따른 사업장 조회.
  PROCEDURE LU_SELECT
           ( P_CURSOR3                           OUT TYPES.TCURSOR3
            , W_CORP_ID                           IN NUMBER
            , W_OPERATING_UNIT_NAME               IN VARCHAR2
            , W_SOB_ID                            IN NUMBER
            , W_ORG_ID                            IN NUMBER
            , W_USABLE_CHECK_YN                   IN VARCHAR2 DEFAULT 'Y'
            );

---------------------------------------------------------------------------------------------------
-- 전산매체 생성 기본 정보.
---------------------------------------------------------------------------------------------------
  PROCEDURE SELECT_REPORT_FILE_INFO
	          ( P_CURSOR1                           OUT TYPES.TCURSOR1
						, P_CORP_ID                           IN NUMBER
						, P_SOB_ID                            IN NUMBER
						, P_ORG_ID                            IN NUMBER
            , P_CONNECT_PERSON_ID                 IN NUMBER
						);

-- 기본사항 저장 반영.
  PROCEDURE UPDATE_REPORT_FILE_INFO
	          ( W_CORP_ID                           IN NUMBER
            , W_OPERATING_UNIT_ID                 IN NUMBER
						, P_SOB_ID                            IN NUMBER
						, P_ORG_ID                            IN NUMBER
            , P_CORP_NAME                         IN VARCHAR2
            , P_PRESIDENT_NAME                    IN VARCHAR2
            , P_VAT_NUMBER                        IN VARCHAR2
            , P_TAX_OFFICE_CODE                   IN VARCHAR2
            , P_TAX_OFFICE_NAME                   IN VARCHAR2
            , P_TEL_NUMBER                        IN VARCHAR2
						);
            
END HRM_OPERATING_UNIT_G; 
/
CREATE OR REPLACE PACKAGE BODY HRM_OPERATING_UNIT_G
AS
/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRM_OPERATING_UNIT_G
/* Description  : 인사시스템의 사업장 정보 관리 패키지
/*
/* Reference by : 사업장 정보 관리.
/* Program History :
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
-- CORP SELECT.
  PROCEDURE DATA_SELECT
           ( P_CURSOR                            OUT TYPES.TCURSOR
      , W_CORP_ID                           IN NUMBER
      , W_SOB_ID                            IN NUMBER
      , W_ORG_ID                            IN NUMBER
      )
  AS
  BEGIN
  OPEN P_CURSOR FOR
   SELECT OU.CORP_ID
     , OU.OPERATING_UNIT_ID
     , OU.OPERATING_UNIT_NAME
     , OU.PRESIDENT_NAME
     , OU.VAT_NUMBER
     , OU.ZIP_CODE
     , OU.ADDR1
     , OU.ADDR2
     , OU.TAX_OFFICE_CODE
     , OU.TAX_OFFICE_NAME
     , OU.BUSINESS_TYPE
     , OU.BUSINESS_ITEM
     , OU.ORG_SORT_NUM
     , OU.ATTRIBUTE1 AS BUSINESS_CODE
     , OU.GENERALLY_TAX_CODE   -- 추가 : 전호수 - 총괄납부승인번호 -- 
     , OU.TEL_NUMBER
     , OU.FAX_NUMBER
     , OU.HOMEPAGE_URL
     , OU.DEFAULT_FLAG
     , OU.USABLE
     , OU.START_DATE
     , OU.END_DATE
   FROM HRM_OPERATING_UNIT OU
     , HRM_CORP_MASTER CM
   WHERE OU.CORP_ID                                                  = CM.CORP_ID
    AND OU.CORP_ID                                                  = W_CORP_ID
    AND OU.SOB_ID                                                   = W_SOB_ID
    AND OU.ORG_ID                                                   = W_ORG_ID
   ;

  END DATA_SELECT;


-- CORP INSERT..
  PROCEDURE DATA_INSERT
           ( P_CORP_ID                           IN NUMBER
            , P_OPERATING_UNIT_NAME               IN VARCHAR2
            , P_PRESIDENT_NAME                    IN VARCHAR2
            , P_ZIP_CODE                          IN VARCHAR2
            , P_ADDR1                             IN VARCHAR2
            , P_ADDR2                             IN VARCHAR2
            , P_VAT_NUMBER                        IN VARCHAR2
            , P_TAX_OFFICE_CODE                   IN VARCHAR2
            , P_TAX_OFFICE_NAME                   IN VARCHAR2
            , P_BUSINESS_TYPE                     IN VARCHAR2
            , P_BUSINESS_ITEM                     IN VARCHAR2
            , P_ORG_SORT_NUM                      IN NUMBER
            , P_TEL_NUMBER                        IN VARCHAR2
            , P_FAX_NUMBER                        IN VARCHAR2
            , P_HOMEPAGE_URL                      IN VARCHAR2
            , P_DEFAULT_FLAG                      IN VARCHAR2
            , P_USABLE                            IN VARCHAR2
            , P_START_DATE                        IN DATE
            , P_END_DATE                          IN DATE
            , P_SOB_ID                            IN NUMBER
            , P_ORG_ID                            IN NUMBER
            , P_USER_ID                           IN NUMBER
            , P_BUSINESS_CODE                     IN VARCHAR2
            , P_GENERALLY_TAX_CODE                IN VARCHAR2
            )
  AS
    D_SYSDATE                                                             DATE;

  BEGIN
   D_SYSDATE := GET_LOCAL_DATE(P_SOB_ID);

  INSERT INTO HRM_OPERATING_UNIT
  ( CORP_ID
  , OPERATING_UNIT_ID, OPERATING_UNIT_NAME
  , PRESIDENT_NAME, ZIP_CODE, ADDR1, ADDR2
  , VAT_NUMBER, TAX_OFFICE_CODE, TAX_OFFICE_NAME
  , BUSINESS_TYPE, BUSINESS_ITEM, ORG_SORT_NUM
  , TEL_NUMBER, FAX_NUMBER, HOMEPAGE_URL
  , DEFAULT_FLAG
  , USABLE, START_DATE, END_DATE
  , SOB_ID, ORG_ID
  , CREATION_DATE, CREATED_BY, LAST_UPDATE_DATE, LAST_UPDATED_BY
  , ATTRIBUTE1
  , GENERALLY_TAX_CODE
  ) VALUES
  (P_CORP_ID
  , HRM_OPERATING_UNIT_S1.NEXTVAL, P_OPERATING_UNIT_NAME
  , P_PRESIDENT_NAME, P_ZIP_CODE, P_ADDR1, P_ADDR2
  , P_VAT_NUMBER, P_TAX_OFFICE_CODE, P_TAX_OFFICE_NAME
  , P_BUSINESS_TYPE, P_BUSINESS_ITEM, P_ORG_SORT_NUM
  , P_TEL_NUMBER, P_FAX_NUMBER, P_HOMEPAGE_URL
  , P_DEFAULT_FLAG
  , P_USABLE, P_START_DATE, P_END_DATE
  , P_SOB_ID, P_ORG_ID
  , D_SYSDATE, P_USER_ID, D_SYSDATE, P_USER_ID
  , P_BUSINESS_CODE
  , P_GENERALLY_TAX_CODE
  );
  END DATA_INSERT;

-- CORP INSERT..
  PROCEDURE DATA_UPDATE
           ( W_OPERATING_UNIT_ID                 IN NUMBER
            , P_OPERATING_UNIT_NAME               IN VARCHAR2
            , P_PRESIDENT_NAME                    IN VARCHAR2
            , P_ZIP_CODE                          IN VARCHAR2
            , P_ADDR1                             IN VARCHAR2
            , P_ADDR2                             IN VARCHAR2
            , P_VAT_NUMBER                        IN VARCHAR2
            , P_TAX_OFFICE_CODE                   IN VARCHAR2
            , P_TAX_OFFICE_NAME                   IN VARCHAR2
            , P_BUSINESS_TYPE                     IN VARCHAR2
            , P_BUSINESS_ITEM                     IN VARCHAR2
            , P_ORG_SORT_NUM                      IN NUMBER
            , P_TEL_NUMBER                        IN VARCHAR2
            , P_FAX_NUMBER                        IN VARCHAR2
            , P_HOMEPAGE_URL                      IN VARCHAR2
            , P_DEFAULT_FLAG                      IN VARCHAR2
            , P_USABLE                            IN VARCHAR2
            , P_START_DATE                        IN DATE
            , P_END_DATE                          IN DATE
            , P_USER_ID                           IN NUMBER
            , P_BUSINESS_CODE                     IN VARCHAR2
            , P_GENERALLY_TAX_CODE                IN VARCHAR2
            )
  AS
  BEGIN

    UPDATE HRM_OPERATING_UNIT OU
      SET OU.OPERATING_UNIT_NAME                                = P_OPERATING_UNIT_NAME
        , OU.PRESIDENT_NAME                                     = P_PRESIDENT_NAME
        , OU.ZIP_CODE                                           = P_ZIP_CODE
        , OU.ADDR1                                              = P_ADDR1
        , OU.ADDR2                                              = P_ADDR2
        , OU.VAT_NUMBER                                         = P_VAT_NUMBER
        , OU.TAX_OFFICE_CODE                                    = P_TAX_OFFICE_CODE
        , OU.TAX_OFFICE_NAME                                    = P_TAX_OFFICE_NAME
        , OU.BUSINESS_TYPE                                      = P_BUSINESS_TYPE
        , OU.BUSINESS_ITEM                                      = P_BUSINESS_ITEM
        , OU.ORG_SORT_NUM                                       = P_ORG_SORT_NUM
        , OU.TEL_NUMBER                                         = P_TEL_NUMBER
        , OU.FAX_NUMBER                                         = P_FAX_NUMBER
        , OU.HOMEPAGE_URL                                       = P_HOMEPAGE_URL
        , OU.DEFAULT_FLAG                                       = P_DEFAULT_FLAG
        , OU.USABLE                                             = P_USABLE
        , OU.START_DATE                                         = P_START_DATE
        , OU.END_DATE                                           = P_END_DATE
        , OU.LAST_UPDATE_DATE                                   = GET_LOCAL_DATE(OU.SOB_ID)
        , OU.LAST_UPDATED_BY                                    = P_USER_ID
        , OU.ATTRIBUTE1                                         = P_BUSINESS_CODE
        , OU.GENERALLY_TAX_CODE                                 = P_GENERALLY_TAX_CODE
     WHERE OU.OPERATING_UNIT_ID                                 = W_OPERATING_UNIT_ID
     ;
  END DATA_UPDATE;


-- FUNCTION - 사업장 ID에 따른 사업장명 리턴.
  FUNCTION OPERATING_UNIT_NAME_F
          ( W_OPERATING_UNIT_ID                  IN NUMBER
      ) RETURN VARCHAR2
 AS
   V_OPERATING_UNIT_NAME                                                 HRM_OPERATING_UNIT.OPERATING_UNIT_NAME%TYPE := NULL;
 BEGIN
   BEGIN
    SELECT OU.OPERATING_UNIT_NAME
        INTO V_OPERATING_UNIT_NAME
   FROM HRM_OPERATING_UNIT OU
   WHERE OU.OPERATING_UNIT_ID                                          = W_OPERATING_UNIT_ID
   ;
  EXCEPTION WHEN OTHERS THEN
    V_OPERATING_UNIT_NAME := '-';
  END;
  RETURN V_OPERATING_UNIT_NAME;

 END OPERATING_UNIT_NAME_F;

-- LOOK UP : CORP_ID 에 따른 사업장 조회.
  PROCEDURE LU_SELECT
           ( P_CURSOR3                           OUT TYPES.TCURSOR3
      , W_CORP_ID                           IN NUMBER
      , W_OPERATING_UNIT_NAME               IN VARCHAR2
      , W_SOB_ID                            IN NUMBER
      , W_ORG_ID                            IN NUMBER
      , W_USABLE_CHECK_YN                   IN VARCHAR2 DEFAULT 'Y'
      )
  AS
    V_STD_DATE                                    HRM_OPERATING_UNIT.START_DATE%TYPE := NULL;

  BEGIN
   IF W_USABLE_CHECK_YN = 'Y' THEN
    V_STD_DATE := GET_LOCAL_DATE(W_SOB_ID);
  ELSE
    V_STD_DATE := NULL;
  END IF;

  OPEN P_CURSOR3 FOR
   SELECT OU.OPERATING_UNIT_NAME
     , OU.OPERATING_UNIT_ID
     FROM HRM_OPERATING_UNIT OU
    WHERE OU.CORP_ID                                              = W_CORP_ID
      AND OU.SOB_ID                                               = W_SOB_ID
     AND OU.ORG_ID                                               = W_ORG_ID
     AND OU.OPERATING_UNIT_NAME                                  LIKE W_OPERATING_UNIT_NAME || '%'
     AND OU.USABLE                                               = DECODE(W_USABLE_CHECK_YN, 'Y', 'Y', OU.USABLE)
     AND OU.START_DATE                                           <= NVL(V_STD_DATE, OU.START_DATE)
     AND (OU.END_DATE IS NULL OR OU.END_DATE                     >= NVL(V_STD_DATE, OU.END_DATE))
   ;

  END LU_SELECT;

---------------------------------------------------------------------------------------------------
-- 전산매체 생성 기본 정보.
---------------------------------------------------------------------------------------------------
  PROCEDURE SELECT_REPORT_FILE_INFO
	          ( P_CURSOR1                           OUT TYPES.TCURSOR1
						, P_CORP_ID                           IN NUMBER
						, P_SOB_ID                            IN NUMBER
						, P_ORG_ID                            IN NUMBER
            , P_CONNECT_PERSON_ID                 IN NUMBER
						)
  AS
  BEGIN
    OPEN P_CURSOR1 FOR
      SELECT CM.CORP_NAME       -- 법인.
          , CM.PRESIDENT_NAME   -- 대표자.
          , OU.VAT_NUMBER       -- 사업자번호.
          , OU.TAX_OFFICE_CODE  -- 관할세무서.
          , OU.TAX_OFFICE_NAME  -- 관할세무서명.
          , S_PM.NAME           -- 담당자명.
          , S_PM.DEPT_NAME      -- 담당자부서.
          , OU.TEL_NUMBER       -- 전화번호.
          , NULL AS TAX_AGENT             -- 세무대리인 관리번호.
          , '9000' AS TAX_PROGRAM_CODE    -- 세무프로그램코드.
          , '101' AS USE_LANGUAGE_CODE    -- 사용한글코드.
          , CM.CORP_ID
          , OU.OPERATING_UNIT_ID
      FROM HRM_OPERATING_UNIT OU
          , HRM_CORP_MASTER CM
          , ( SELECT PM.PERSON_ID
                  , PM.NAME
                  , PM.DEPT_NAME
                FROM HRM_PERSON_MASTER_V1 PM
              WHERE PM.PERSON_ID  = P_CONNECT_PERSON_ID
            ) S_PM
      WHERE OU.CORP_ID            = CM.CORP_ID
        AND P_CONNECT_PERSON_ID   = S_PM.PERSON_ID
        AND OU.CORP_ID            = P_CORP_ID
        AND OU.SOB_ID             = P_SOB_ID
        AND OU.ORG_ID             = P_ORG_ID
      ;
  END SELECT_REPORT_FILE_INFO;

-- 기본사항 저장 반영.
  PROCEDURE UPDATE_REPORT_FILE_INFO
	          ( W_CORP_ID                           IN NUMBER
            , W_OPERATING_UNIT_ID                 IN NUMBER
						, P_SOB_ID                            IN NUMBER
						, P_ORG_ID                            IN NUMBER
            , P_CORP_NAME                         IN VARCHAR2
            , P_PRESIDENT_NAME                    IN VARCHAR2
            , P_VAT_NUMBER                        IN VARCHAR2
            , P_TAX_OFFICE_CODE                   IN VARCHAR2
            , P_TAX_OFFICE_NAME                   IN VARCHAR2
            , P_TEL_NUMBER                        IN VARCHAR2
						)
  AS
    V_TAX_REG_NO          VARCHAR2(15);
  BEGIN
    -- 사업자번호 검증.
    V_TAX_REG_NO := P_VAT_NUMBER;
    IF REPLACE(V_TAX_REG_NO, '-', '') IS NOT NULL THEN
      IF EAPP_NUM_DIGIT_CHECKER_G.CHECK_TAX_NUM_F(V_TAX_REG_NO) = 'N' THEN
        RAISE_APPLICATION_ERROR(-20011, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10009', NULL));
        RETURN;
      END IF;
      -- 사업자번호 FORMAT 적용.
      V_TAX_REG_NO := REPLACE(V_TAX_REG_NO, '-', '');
      V_TAX_REG_NO := SUBSTR(V_TAX_REG_NO, 1, 3) || '-' || SUBSTR(V_TAX_REG_NO, 4, 2) || '-' || SUBSTR(V_TAX_REG_NO, 6, 6);
    END IF;
    
    UPDATE HRM_CORP_MASTER CM
      SET CM.CORP_NAME          = P_CORP_NAME
        , CM.PRESIDENT_NAME     = P_PRESIDENT_NAME
    WHERE CM.CORP_ID            = W_CORP_ID
    ;
    
    UPDATE HRM_OPERATING_UNIT OU
      SET OU.PRESIDENT_NAME     = P_PRESIDENT_NAME
        , OU.VAT_NUMBER         = V_TAX_REG_NO
        , OU.TAX_OFFICE_CODE    = P_TAX_OFFICE_CODE
        , OU.TAX_OFFICE_NAME    = P_TAX_OFFICE_NAME
        , OU.TEL_NUMBER         = P_TEL_NUMBER
    WHERE OU.OPERATING_UNIT_ID  = W_OPERATING_UNIT_ID
    ;
  END UPDATE_REPORT_FILE_INFO;
  
END HRM_OPERATING_UNIT_G; 
/
