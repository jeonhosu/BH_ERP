CREATE OR REPLACE PACKAGE FI_AUTO_JOURNAL_G
AS

-- 자동분개유형 헤더 조회.
  PROCEDURE SELECT_AUTO_JOURNAL_H
            ( P_CURSOR               OUT TYPES.TCURSOR
            , W_SLIP_TYPE            IN FI_AUTO_JOURNAL_HEADER.SLIP_TYPE%TYPE
            , W_JOB_CATEGORY_CODE    IN FI_AUTO_JOURNAL_HEADER.JOB_CATEGORY_CODE%TYPE
            , W_JOB_CODE             IN FI_AUTO_JOURNAL_HEADER.JOB_CODE%TYPE
            , W_SOB_ID               IN FI_AUTO_JOURNAL_HEADER.SOB_ID%TYPE
            , W_ORG_ID               IN FI_AUTO_JOURNAL_HEADER.ORG_ID%TYPE
            );

-- 자동분개유형 헤더 삽입.
  PROCEDURE INSERT_AUTO_JOURNAL_H
            ( P_JOURNAL_HEADER_ID     OUT FI_AUTO_JOURNAL_HEADER.JOURNAL_HEADER_ID%TYPE
            , P_SOB_ID                IN FI_AUTO_JOURNAL_HEADER.SOB_ID%TYPE
            , P_ORG_ID                IN FI_AUTO_JOURNAL_HEADER.ORG_ID%TYPE
            , P_SLIP_TYPE             IN FI_AUTO_JOURNAL_HEADER.SLIP_TYPE%TYPE
            , P_JOB_CATEGORY_CODE     IN FI_AUTO_JOURNAL_HEADER.JOB_CATEGORY_CODE%TYPE
            , P_JOB_CODE              IN FI_AUTO_JOURNAL_HEADER.JOB_CODE%TYPE
            , P_JOB_NAME              IN FI_AUTO_JOURNAL_HEADER.JOB_NAME%TYPE
            , P_JOURNAL_TAG           IN FI_AUTO_JOURNAL_HEADER.JOURNAL_TAG%TYPE
            , P_DESCRIPTION           IN FI_AUTO_JOURNAL_HEADER.DESCRIPTION%TYPE
            , P_ENABLED_FLAG          IN FI_AUTO_JOURNAL_HEADER.ENABLED_FLAG%TYPE
            , P_EFFECTIVE_DATE_FR     IN FI_AUTO_JOURNAL_HEADER.EFFECTIVE_DATE_FR%TYPE
            , P_EFFECTIVE_DATE_TO     IN FI_AUTO_JOURNAL_HEADER.EFFECTIVE_DATE_TO%TYPE
            , P_USER_ID               IN FI_AUTO_JOURNAL_HEADER.CREATED_BY%TYPE
            );

-- 자동분개유형 헤더 수정.
  PROCEDURE UPDATE_AUTO_JOURNAL_H
            ( W_JOURNAL_HEADER_ID     IN FI_AUTO_JOURNAL_HEADER.JOURNAL_HEADER_ID%TYPE            
            , P_SOB_ID                IN FI_AUTO_JOURNAL_HEADER.SOB_ID%TYPE
            , P_JOB_NAME              IN FI_AUTO_JOURNAL_HEADER.JOB_NAME%TYPE
            , P_JOURNAL_TAG           IN FI_AUTO_JOURNAL_HEADER.JOURNAL_TAG%TYPE
            , P_DESCRIPTION           IN FI_AUTO_JOURNAL_HEADER.DESCRIPTION%TYPE
            , P_ENABLED_FLAG          IN FI_AUTO_JOURNAL_HEADER.ENABLED_FLAG%TYPE
            , P_EFFECTIVE_DATE_FR     IN FI_AUTO_JOURNAL_HEADER.EFFECTIVE_DATE_FR%TYPE
            , P_EFFECTIVE_DATE_TO     IN FI_AUTO_JOURNAL_HEADER.EFFECTIVE_DATE_TO%TYPE
            , P_USER_ID               IN FI_AUTO_JOURNAL_HEADER.CREATED_BY%TYPE
            );

---------------------------------------------------------------------------------------------------
-- 자동분개유형 라인 조회.
  PROCEDURE SELECT_AUTO_JOURNAL_L
            ( P_CURSOR1              OUT TYPES.TCURSOR1
            , W_JOURNAL_HEADER_ID    IN FI_AUTO_JOURNAL_HEADER.JOURNAL_HEADER_ID%TYPE
            , W_SOB_ID               IN FI_AUTO_JOURNAL_LINE.SOB_ID%TYPE
            , W_ORG_ID               IN FI_AUTO_JOURNAL_LINE.ORG_ID%TYPE
            );

-- 자동분개유형 라인 삽입.
  PROCEDURE INSERT_AUTO_JOURNAL_L
            ( P_JOURNAL_LINE_ID       OUT FI_AUTO_JOURNAL_LINE.JOURNAL_LINE_ID%TYPE
            , P_SOB_ID                IN FI_AUTO_JOURNAL_LINE.SOB_ID%TYPE
            , P_ORG_ID                IN FI_AUTO_JOURNAL_LINE.ORG_ID%TYPE
            , P_JOURNAL_HEADER_ID     IN FI_AUTO_JOURNAL_LINE.JOURNAL_HEADER_ID%TYPE
            , P_SEQ                   OUT FI_AUTO_JOURNAL_LINE.SEQ%TYPE
            , P_ACCOUNT_DR_CR         IN FI_AUTO_JOURNAL_LINE.ACCOUNT_DR_CR%TYPE
            , P_ACCOUNT_CONTROL_ID    IN FI_AUTO_JOURNAL_LINE.ACCOUNT_CONTROL_ID%TYPE
            , P_REMARK                IN FI_AUTO_JOURNAL_LINE.REMARK%TYPE
            , P_PER_CONTRA_ACCOUNT_YN IN FI_AUTO_JOURNAL_LINE.PER_CONTRA_ACCOUNT_YN%TYPE
            , P_DISPLAY_YN            IN FI_AUTO_JOURNAL_LINE.DISPLAY_YN%TYPE
            , P_ENABLED_FLAG          IN FI_AUTO_JOURNAL_LINE.ENABLED_FLAG%TYPE
            , P_EFFECTIVE_DATE_FR     IN FI_AUTO_JOURNAL_LINE.EFFECTIVE_DATE_FR%TYPE
            , P_EFFECTIVE_DATE_TO     IN FI_AUTO_JOURNAL_LINE.EFFECTIVE_DATE_TO%TYPE
            , P_USER_ID               IN FI_AUTO_JOURNAL_LINE.CREATED_BY%TYPE
            );

-- 자동분개유형 라인 수정.
  PROCEDURE UPDATE_AUTO_JOURNAL_L
            ( W_JOURNAL_LINE_ID       IN FI_AUTO_JOURNAL_LINE.JOURNAL_LINE_ID%TYPE
            , P_SOB_ID                IN FI_AUTO_JOURNAL_LINE.SOB_ID%TYPE
            , P_ACCOUNT_DR_CR         IN FI_AUTO_JOURNAL_LINE.ACCOUNT_DR_CR%TYPE
            , P_ACCOUNT_CONTROL_ID    IN FI_AUTO_JOURNAL_LINE.ACCOUNT_CONTROL_ID%TYPE
            , P_REMARK                IN FI_AUTO_JOURNAL_LINE.REMARK%TYPE
            , P_PER_CONTRA_ACCOUNT_YN IN FI_AUTO_JOURNAL_LINE.PER_CONTRA_ACCOUNT_YN%TYPE
            , P_DISPLAY_YN            IN FI_AUTO_JOURNAL_LINE.DISPLAY_YN%TYPE
            , P_ENABLED_FLAG          IN FI_AUTO_JOURNAL_LINE.ENABLED_FLAG%TYPE
            , P_EFFECTIVE_DATE_FR     IN FI_AUTO_JOURNAL_LINE.EFFECTIVE_DATE_FR%TYPE
            , P_EFFECTIVE_DATE_TO     IN FI_AUTO_JOURNAL_LINE.EFFECTIVE_DATE_TO%TYPE
            , P_USER_ID               IN FI_AUTO_JOURNAL_LINE.CREATED_BY%TYPE
            );

---------------------------------------------------------------------------------------------------
-- 자동분개유형 업무구분 조회.
  PROCEDURE LU_JOB_CODE
            ( P_CURSOR3              OUT TYPES.TCURSOR3
            , W_SOB_ID               IN FI_AUTO_JOURNAL_HEADER.SOB_ID%TYPE
            , W_SLIP_TYPE            IN FI_AUTO_JOURNAL_HEADER.SLIP_TYPE%TYPE
            , W_JOB_CATEGORY_CODE    IN FI_AUTO_JOURNAL_HEADER.JOB_CATEGORY_CODE%TYPE
            , W_JOURNAL_TAG          IN FI_AUTO_JOURNAL_HEADER.JOURNAL_TAG%TYPE
            , W_ENABLED_YN           IN FI_AUTO_JOURNAL_HEADER.ENABLED_FLAG%TYPE
            );

---------------------------------------------------------------------------------------------------
-- 자동분개유형 업무구분명 RETURN.
  FUNCTION JOURNAL_JOB_NAME_F
            ( W_JOURNAL_HEADER_ID    IN FI_AUTO_JOURNAL_HEADER.JOURNAL_HEADER_ID%TYPE
            , W_SOB_ID               IN FI_AUTO_JOURNAL_HEADER.SOB_ID%TYPE
            ) RETURN VARCHAR2;

END FI_AUTO_JOURNAL_G; 
 
/
CREATE OR REPLACE PACKAGE BODY FI_AUTO_JOURNAL_G
AS
/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : FI_AUTO_JOURNAL_G
/* Description  : 자동분개유형등록 관리.
/*
/* Reference by :
/* Program History :
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
-- 자동분개유형 조회.
  PROCEDURE SELECT_AUTO_JOURNAL_H
            ( P_CURSOR               OUT TYPES.TCURSOR
            , W_SLIP_TYPE            IN FI_AUTO_JOURNAL_HEADER.SLIP_TYPE%TYPE
            , W_JOB_CATEGORY_CODE    IN FI_AUTO_JOURNAL_HEADER.JOB_CATEGORY_CODE%TYPE
            , W_JOB_CODE             IN FI_AUTO_JOURNAL_HEADER.JOB_CODE%TYPE
            , W_SOB_ID               IN FI_AUTO_JOURNAL_HEADER.SOB_ID%TYPE
            , W_ORG_ID               IN FI_AUTO_JOURNAL_HEADER.ORG_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR FOR
      SELECT AJ.JOURNAL_HEADER_ID
           , FI_COMMON_G.CODE_NAME_F('SLIP_TYPE', AJ.SLIP_TYPE, AJ.SOB_ID) AS SLIP_TYPE_NAME
           , AJ.SLIP_TYPE
           , FI_COMMON_G.CODE_NAME_F('JOB_CATEGORY', AJ.JOB_CATEGORY_CODE, AJ.SOB_ID) AS JOB_CATEGORY_NAME
           , AJ.JOB_CATEGORY_CODE
           , AJ.JOB_CODE
           , AJ.JOB_NAME
           , AJ.JOURNAL_TAG
           , AJ.DESCRIPTION
           , AJ.ENABLED_FLAG
           , AJ.EFFECTIVE_DATE_FR
           , AJ.EFFECTIVE_DATE_TO
        FROM FI_AUTO_JOURNAL_HEADER AJ
       WHERE AJ.SOB_ID                  = W_SOB_ID
         AND AJ.SLIP_TYPE               = NVL(W_SLIP_TYPE, AJ.SLIP_TYPE)
         AND AJ.JOB_CATEGORY_CODE       = NVL(W_JOB_CATEGORY_CODE, AJ.JOB_CATEGORY_CODE)
         AND AJ.JOB_CODE                = NVL(W_JOB_CODE, AJ.JOB_CODE)
      ORDER BY AJ.SLIP_TYPE, AJ.JOB_CATEGORY_CODE, AJ.JOB_CODE
      ;

  END SELECT_AUTO_JOURNAL_H;

-- 자동분개유형 헤더 삽입.
  PROCEDURE INSERT_AUTO_JOURNAL_H
            ( P_JOURNAL_HEADER_ID     OUT FI_AUTO_JOURNAL_HEADER.JOURNAL_HEADER_ID%TYPE
            , P_SOB_ID                IN FI_AUTO_JOURNAL_HEADER.SOB_ID%TYPE
            , P_ORG_ID                IN FI_AUTO_JOURNAL_HEADER.ORG_ID%TYPE
            , P_SLIP_TYPE             IN FI_AUTO_JOURNAL_HEADER.SLIP_TYPE%TYPE
            , P_JOB_CATEGORY_CODE     IN FI_AUTO_JOURNAL_HEADER.JOB_CATEGORY_CODE%TYPE
            , P_JOB_CODE              IN FI_AUTO_JOURNAL_HEADER.JOB_CODE%TYPE
            , P_JOB_NAME              IN FI_AUTO_JOURNAL_HEADER.JOB_NAME%TYPE
            , P_JOURNAL_TAG           IN FI_AUTO_JOURNAL_HEADER.JOURNAL_TAG%TYPE
            , P_DESCRIPTION           IN FI_AUTO_JOURNAL_HEADER.DESCRIPTION%TYPE
            , P_ENABLED_FLAG          IN FI_AUTO_JOURNAL_HEADER.ENABLED_FLAG%TYPE
            , P_EFFECTIVE_DATE_FR     IN FI_AUTO_JOURNAL_HEADER.EFFECTIVE_DATE_FR%TYPE
            , P_EFFECTIVE_DATE_TO     IN FI_AUTO_JOURNAL_HEADER.EFFECTIVE_DATE_TO%TYPE
            , P_USER_ID               IN FI_AUTO_JOURNAL_HEADER.CREATED_BY%TYPE
            )
  AS
    V_SYSDATE   DATE := GET_LOCAL_DATE(P_SOB_ID);
    V_RECORD_COUNT NUMBER := 0;

  BEGIN
    -- 동일한 전표유형/업무분류코드,업무구분,차대,계정 ID존재 체크.
    BEGIN
      SELECT COUNT(AJ.JOURNAL_HEADER_ID) AS RECORD_COUNT
        INTO V_RECORD_COUNT
        FROM FI_AUTO_JOURNAL_HEADER AJ
       WHERE AJ.SOB_ID                  = P_SOB_ID
         AND AJ.SLIP_TYPE               = P_SLIP_TYPE
         AND AJ.JOB_CATEGORY_CODE       = P_JOB_CATEGORY_CODE
         AND AJ.JOB_CODE                = P_JOB_CODE
      ;
    EXCEPTION WHEN OTHERS THEN
      V_RECORD_COUNT := 0;
    END;
    IF V_RECORD_COUNT <> 0 THEN
      RAISE ERRNUMS.Exist_Data;
    END IF;

    SELECT FI_AUTO_JOURNAL_HEADER_S1.NEXTVAL
      INTO P_JOURNAL_HEADER_ID
      FROM DUAL;

    INSERT INTO FI_AUTO_JOURNAL_HEADER
    ( JOURNAL_HEADER_ID
    , SOB_ID
    , ORG_ID
    , SLIP_TYPE
    , JOB_CATEGORY_CODE
    , JOB_CODE
    , JOB_NAME
    , JOURNAL_TAG
    , DESCRIPTION
    , ENABLED_FLAG
    , EFFECTIVE_DATE_FR
    , EFFECTIVE_DATE_TO
    , CREATION_DATE
    , CREATED_BY
    , LAST_UPDATE_DATE
    , LAST_UPDATED_BY )
    VALUES
    ( P_JOURNAL_HEADER_ID
    , P_SOB_ID
    , P_ORG_ID
    , P_SLIP_TYPE
    , P_JOB_CATEGORY_CODE
    , P_JOB_CODE
    , P_JOB_NAME
    , P_JOURNAL_TAG
    , P_DESCRIPTION
    , P_ENABLED_FLAG
    , P_EFFECTIVE_DATE_FR
    , P_EFFECTIVE_DATE_TO
    , V_SYSDATE
    , P_USER_ID
    , V_SYSDATE
    , P_USER_ID );

  EXCEPTION
    WHEN ERRNUMS.Exist_Data THEN
      RAISE_APPLICATION_ERROR(ERRNUMS.Exist_Data_Code, ERRNUMS.Exist_Data_Desc);
  END INSERT_AUTO_JOURNAL_H;

-- 자동분개유형 헤더 수정.
  PROCEDURE UPDATE_AUTO_JOURNAL_H
            ( W_JOURNAL_HEADER_ID     IN FI_AUTO_JOURNAL_HEADER.JOURNAL_HEADER_ID%TYPE
            , P_SOB_ID                IN FI_AUTO_JOURNAL_HEADER.SOB_ID%TYPE
            , P_JOB_NAME              IN FI_AUTO_JOURNAL_HEADER.JOB_NAME%TYPE
            , P_JOURNAL_TAG           IN FI_AUTO_JOURNAL_HEADER.JOURNAL_TAG%TYPE
            , P_DESCRIPTION           IN FI_AUTO_JOURNAL_HEADER.DESCRIPTION%TYPE
            , P_ENABLED_FLAG          IN FI_AUTO_JOURNAL_HEADER.ENABLED_FLAG%TYPE
            , P_EFFECTIVE_DATE_FR     IN FI_AUTO_JOURNAL_HEADER.EFFECTIVE_DATE_FR%TYPE
            , P_EFFECTIVE_DATE_TO     IN FI_AUTO_JOURNAL_HEADER.EFFECTIVE_DATE_TO%TYPE
            , P_USER_ID               IN FI_AUTO_JOURNAL_HEADER.CREATED_BY%TYPE
            )
  AS
    V_SYSDATE DATE := GET_LOCAL_DATE(P_SOB_ID);
  BEGIN
    UPDATE FI_AUTO_JOURNAL_HEADER
      SET JOB_NAME              = P_JOB_NAME
        , JOURNAL_TAG           = P_JOURNAL_TAG
        , DESCRIPTION           = P_DESCRIPTION
        , ENABLED_FLAG          = P_ENABLED_FLAG
        , EFFECTIVE_DATE_FR     = P_EFFECTIVE_DATE_FR
        , EFFECTIVE_DATE_TO     = P_EFFECTIVE_DATE_TO
        , LAST_UPDATE_DATE      = V_SYSDATE
        , LAST_UPDATED_BY       = P_USER_ID
     WHERE JOURNAL_HEADER_ID    = W_JOURNAL_HEADER_ID
    ;

  END UPDATE_AUTO_JOURNAL_H;

---------------------------------------------------------------------------------------------------
-- 자동분개유형 라인 조회.
  PROCEDURE SELECT_AUTO_JOURNAL_L
            ( P_CURSOR1              OUT TYPES.TCURSOR1
            , W_JOURNAL_HEADER_ID    IN FI_AUTO_JOURNAL_HEADER.JOURNAL_HEADER_ID%TYPE
            , W_SOB_ID               IN FI_AUTO_JOURNAL_LINE.SOB_ID%TYPE
            , W_ORG_ID               IN FI_AUTO_JOURNAL_LINE.ORG_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR1 FOR
      SELECT AJ.JOURNAL_LINE_ID
           , AJ.JOURNAL_HEADER_ID
           , AJ.SEQ
           , FI_COMMON_G.CODE_NAME_F('ACCOUNT_DR_CR', AJ.ACCOUNT_DR_CR, AJ.SOB_ID) AS ACCOUNT_DR_CR_NAME
           , AJ.ACCOUNT_DR_CR
           , AC.ACCOUNT_CODE
           , AC.ACCOUNT_DESC
           , AJ.ACCOUNT_CONTROL_ID
           , AJ.REMARK
           , AJ.PER_CONTRA_ACCOUNT_YN
           , AJ.DISPLAY_YN
           , AJ.ENABLED_FLAG
           , AJ.EFFECTIVE_DATE_FR
           , AJ.EFFECTIVE_DATE_TO
        FROM FI_AUTO_JOURNAL_LINE AJ
          , FI_ACCOUNT_CONTROL AC
       WHERE AJ.ACCOUNT_CONTROL_ID      = AC.ACCOUNT_CONTROL_ID
         AND AJ.SOB_ID                  = W_SOB_ID
         AND AJ.JOURNAL_HEADER_ID       = W_JOURNAL_HEADER_ID
      ORDER BY AJ.SEQ
      ;

  END SELECT_AUTO_JOURNAL_L;

-- 자동분개유형 라인 삽입.
  PROCEDURE INSERT_AUTO_JOURNAL_L
            ( P_JOURNAL_LINE_ID       OUT FI_AUTO_JOURNAL_LINE.JOURNAL_LINE_ID%TYPE
            , P_SOB_ID                IN FI_AUTO_JOURNAL_LINE.SOB_ID%TYPE
            , P_ORG_ID                IN FI_AUTO_JOURNAL_LINE.ORG_ID%TYPE
            , P_JOURNAL_HEADER_ID     IN FI_AUTO_JOURNAL_LINE.JOURNAL_HEADER_ID%TYPE
            , P_SEQ                   OUT FI_AUTO_JOURNAL_LINE.SEQ%TYPE
            , P_ACCOUNT_DR_CR         IN FI_AUTO_JOURNAL_LINE.ACCOUNT_DR_CR%TYPE
            , P_ACCOUNT_CONTROL_ID    IN FI_AUTO_JOURNAL_LINE.ACCOUNT_CONTROL_ID%TYPE
            , P_REMARK                IN FI_AUTO_JOURNAL_LINE.REMARK%TYPE
            , P_PER_CONTRA_ACCOUNT_YN IN FI_AUTO_JOURNAL_LINE.PER_CONTRA_ACCOUNT_YN%TYPE
            , P_DISPLAY_YN            IN FI_AUTO_JOURNAL_LINE.DISPLAY_YN%TYPE
            , P_ENABLED_FLAG          IN FI_AUTO_JOURNAL_LINE.ENABLED_FLAG%TYPE
            , P_EFFECTIVE_DATE_FR     IN FI_AUTO_JOURNAL_LINE.EFFECTIVE_DATE_FR%TYPE
            , P_EFFECTIVE_DATE_TO     IN FI_AUTO_JOURNAL_LINE.EFFECTIVE_DATE_TO%TYPE
            , P_USER_ID               IN FI_AUTO_JOURNAL_LINE.CREATED_BY%TYPE
            )
  AS
    V_SYSDATE   DATE := GET_LOCAL_DATE(P_SOB_ID);
    V_RECORD_COUNT NUMBER := 0;

  BEGIN
    -- 동일한 전표유형/업무분류코드,업무구분,차대,계정 ID존재 체크.
    BEGIN
      SELECT COUNT(AJ.JOURNAL_LINE_ID) AS RECORD_COUNT
        INTO V_RECORD_COUNT
        FROM FI_AUTO_JOURNAL_LINE AJ
       WHERE AJ.SOB_ID                  = P_SOB_ID
         AND AJ.JOURNAL_HEADER_ID       = P_JOURNAL_HEADER_ID
         AND AJ.ACCOUNT_DR_CR           = P_ACCOUNT_DR_CR
         AND AJ.ACCOUNT_CONTROL_ID      = P_ACCOUNT_CONTROL_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_RECORD_COUNT := 0;
    END;
    IF V_RECORD_COUNT <> 0 THEN
      RAISE ERRNUMS.Exist_Data;
    END IF;

    SELECT FI_AUTO_JOURNAL_LINE_S1.NEXTVAL
      INTO P_JOURNAL_LINE_ID
      FROM DUAL;

    -- SEQ 생성.
    BEGIN
      SELECT NVL(MAX(AJ.SEQ), 0) + 1 AS NEXT_SEQ
        INTO P_SEQ
        FROM FI_AUTO_JOURNAL_LINE AJ
       WHERE AJ.SOB_ID                  = P_SOB_ID
         AND AJ.JOURNAL_HEADER_ID       = P_JOURNAL_HEADER_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      P_SEQ := 1;
    END;

    INSERT INTO FI_AUTO_JOURNAL_LINE
    ( JOURNAL_LINE_ID
    , SOB_ID
    , ORG_ID
    , JOURNAL_HEADER_ID
    , SEQ
    , ACCOUNT_DR_CR
    , ACCOUNT_CONTROL_ID
    , REMARK
    , PER_CONTRA_ACCOUNT_YN
    , DISPLAY_YN
    , ENABLED_FLAG
    , EFFECTIVE_DATE_FR
    , EFFECTIVE_DATE_TO
    , CREATION_DATE
    , CREATED_BY
    , LAST_UPDATE_DATE
    , LAST_UPDATED_BY )
    VALUES
    ( P_JOURNAL_LINE_ID
    , P_SOB_ID
    , P_ORG_ID
    , P_JOURNAL_HEADER_ID
    , P_SEQ
    , P_ACCOUNT_DR_CR
    , P_ACCOUNT_CONTROL_ID
    , P_REMARK
    , P_PER_CONTRA_ACCOUNT_YN
    , P_DISPLAY_YN
    , P_ENABLED_FLAG
    , P_EFFECTIVE_DATE_FR
    , P_EFFECTIVE_DATE_TO
    , V_SYSDATE
    , P_USER_ID
    , V_SYSDATE
    , P_USER_ID );

  EXCEPTION
    WHEN ERRNUMS.Exist_Data THEN
      RAISE_APPLICATION_ERROR(ERRNUMS.Exist_Data_Code, ERRNUMS.Exist_Data_Desc);
  END INSERT_AUTO_JOURNAL_L;

-- 자동분개유형 라인 수정.
  PROCEDURE UPDATE_AUTO_JOURNAL_L
            ( W_JOURNAL_LINE_ID       IN FI_AUTO_JOURNAL_LINE.JOURNAL_LINE_ID%TYPE
            , P_SOB_ID                IN FI_AUTO_JOURNAL_LINE.SOB_ID%TYPE
            , P_ACCOUNT_DR_CR         IN FI_AUTO_JOURNAL_LINE.ACCOUNT_DR_CR%TYPE
            , P_ACCOUNT_CONTROL_ID    IN FI_AUTO_JOURNAL_LINE.ACCOUNT_CONTROL_ID%TYPE
            , P_REMARK                IN FI_AUTO_JOURNAL_LINE.REMARK%TYPE
            , P_PER_CONTRA_ACCOUNT_YN IN FI_AUTO_JOURNAL_LINE.PER_CONTRA_ACCOUNT_YN%TYPE
            , P_DISPLAY_YN            IN FI_AUTO_JOURNAL_LINE.DISPLAY_YN%TYPE
            , P_ENABLED_FLAG          IN FI_AUTO_JOURNAL_LINE.ENABLED_FLAG%TYPE
            , P_EFFECTIVE_DATE_FR     IN FI_AUTO_JOURNAL_LINE.EFFECTIVE_DATE_FR%TYPE
            , P_EFFECTIVE_DATE_TO     IN FI_AUTO_JOURNAL_LINE.EFFECTIVE_DATE_TO%TYPE
            , P_USER_ID               IN FI_AUTO_JOURNAL_LINE.CREATED_BY%TYPE
            )
  AS
    V_SYSDATE DATE := GET_LOCAL_DATE(P_SOB_ID);
  BEGIN
    UPDATE FI_AUTO_JOURNAL_LINE
      SET ACCOUNT_DR_CR         = P_ACCOUNT_DR_CR
        , ACCOUNT_CONTROL_ID    = P_ACCOUNT_CONTROL_ID
        , REMARK                = P_REMARK
        , PER_CONTRA_ACCOUNT_YN = P_PER_CONTRA_ACCOUNT_YN
        , DISPLAY_YN            = P_DISPLAY_YN
        , ENABLED_FLAG          = P_ENABLED_FLAG
        , EFFECTIVE_DATE_FR     = P_EFFECTIVE_DATE_FR
        , EFFECTIVE_DATE_TO     = P_EFFECTIVE_DATE_TO
        , LAST_UPDATE_DATE      = V_SYSDATE
        , LAST_UPDATED_BY       = P_USER_ID
     WHERE JOURNAL_LINE_ID      = W_JOURNAL_LINE_ID
    ;

  END UPDATE_AUTO_JOURNAL_L;

---------------------------------------------------------------------------------------------------
-- 자동분개유형 업무구분 조회.
  PROCEDURE LU_JOB_CODE
            ( P_CURSOR3              OUT TYPES.TCURSOR3
            , W_SOB_ID               IN FI_AUTO_JOURNAL_HEADER.SOB_ID%TYPE
            , W_SLIP_TYPE            IN FI_AUTO_JOURNAL_HEADER.SLIP_TYPE%TYPE
            , W_JOB_CATEGORY_CODE    IN FI_AUTO_JOURNAL_HEADER.JOB_CATEGORY_CODE%TYPE
            , W_JOURNAL_TAG          IN FI_AUTO_JOURNAL_HEADER.JOURNAL_TAG%TYPE
            , W_ENABLED_YN           IN FI_AUTO_JOURNAL_HEADER.ENABLED_FLAG%TYPE
            )
  AS
    V_SYSDATE                        DATE := NULL;

  BEGIN
    IF W_ENABLED_YN = 'Y' THEN
      V_SYSDATE := NULL;
    ELSE
      V_SYSDATE := GET_LOCAL_DATE(W_SOB_ID);
    END IF;

    OPEN P_CURSOR3 FOR
      SELECT AJH.JOB_NAME
           , AJH.JOB_CODE
           , AJH.JOURNAL_HEADER_ID
        FROM FI_AUTO_JOURNAL_HEADER AJH
       WHERE AJH.SOB_ID           = W_SOB_ID
         AND AJH.SLIP_TYPE        = NVL(W_SLIP_TYPE, AJH.SLIP_TYPE)
         AND AJH.JOB_CATEGORY_CODE  = NVL(W_JOB_CATEGORY_CODE, AJH.JOB_CATEGORY_CODE)
         AND AJH.JOURNAL_TAG      = NVL(W_JOURNAL_TAG, AJH.JOURNAL_TAG)
         AND AJH.ENABLED_FLAG     = DECODE(W_ENABLED_YN, 'Y', 'Y', AJH.ENABLED_FLAG)
         AND AJH.EFFECTIVE_DATE_FR  <= NVL(V_SYSDATE, AJH.EFFECTIVE_DATE_FR)
         AND (AJH.EFFECTIVE_DATE_TO IS NULL OR AJH.EFFECTIVE_DATE_TO  >= NVL(V_SYSDATE, AJH.EFFECTIVE_DATE_TO))
     ORDER BY AJH.JOB_CODE
    ;

  END LU_JOB_CODE;

---------------------------------------------------------------------------------------------------
-- 자동분개유형 업무구분명 RETURN.
  FUNCTION JOURNAL_JOB_NAME_F
            ( W_JOURNAL_HEADER_ID    IN FI_AUTO_JOURNAL_HEADER.JOURNAL_HEADER_ID%TYPE
            , W_SOB_ID               IN FI_AUTO_JOURNAL_HEADER.SOB_ID%TYPE
            ) RETURN VARCHAR2
  AS
    V_RETURN_VALUE                   FI_AUTO_JOURNAL_HEADER.JOB_NAME%TYPE := NULL;

  BEGIN
    BEGIN
      SELECT AJH.JOB_NAME
        INTO V_RETURN_VALUE
        FROM FI_AUTO_JOURNAL_HEADER AJH
       WHERE AJH.JOURNAL_HEADER_ID  = W_JOURNAL_HEADER_ID
         AND AJH.SOB_ID             = W_SOB_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      NULL;
    END;
    RETURN V_RETURN_VALUE;

  END JOURNAL_JOB_NAME_F;

END FI_AUTO_JOURNAL_G; 
/
