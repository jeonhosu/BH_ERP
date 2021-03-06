CREATE OR REPLACE PACKAGE FI_ASSET_CLASS_G
AS

-- 고정자산 CLASS 관리.
  PROCEDURE SELECT_ASSET_CLASS
            ( P_CURSOR                OUT TYPES.TCURSOR
            , W_ASSET_CATEGORY_ID     IN FI_ASSET_CLASS.ASSET_CATEGORY_ID%TYPE
            , W_ASSET_CLASS_ID        IN FI_ASSET_CLASS.ASSET_CLASS_ID%TYPE
            , W_SOB_ID                IN FI_ASSET_CLASS.SOB_ID%TYPE
            );

-- 고정자산 CLASS 삽입.
  PROCEDURE INSERT_ASSET_CLASS
            ( P_ASSET_CLASS_ID    OUT FI_ASSET_CLASS.ASSET_CLASS_ID%TYPE
            , P_ASSET_CLASS_CODE  IN FI_ASSET_CLASS.ASSET_CLASS_CODE%TYPE
            , P_SOB_ID            IN FI_ASSET_CLASS.SOB_ID%TYPE
            , P_ASSET_CLASS_NAME  IN FI_ASSET_CLASS.ASSET_CLASS_NAME%TYPE
            , P_ASSET_CLASS_SPEC  IN FI_ASSET_CLASS.ASSET_CLASS_SPEC%TYPE
            , P_ASSET_CLASS_USE   IN FI_ASSET_CLASS.ASSET_CLASS_USE%TYPE
            , P_ASSET_CATEGORY_ID IN FI_ASSET_CLASS.ASSET_CATEGORY_ID%TYPE
            , P_REMARK            IN FI_ASSET_CLASS.REMARK%TYPE
            , P_ENABLED_FLAG      IN FI_ASSET_CLASS.ENABLED_FLAG%TYPE
            , P_EFFECTIVE_DATE_FR IN FI_ASSET_CLASS.EFFECTIVE_DATE_FR%TYPE
            , P_EFFECTIVE_DATE_TO IN FI_ASSET_CLASS.EFFECTIVE_DATE_TO%TYPE
            , P_USER_ID           IN FI_ASSET_CLASS.CREATED_BY%TYPE
            );

-- 고정자산 CLASS 수정.
  PROCEDURE UPDATE_ASSET_CLASS
            ( W_ASSET_CLASS_ID    IN FI_ASSET_CLASS.ASSET_CLASS_ID%TYPE
            , P_ASSET_CLASS_NAME  IN FI_ASSET_CLASS.ASSET_CLASS_NAME%TYPE
            , P_ASSET_CLASS_SPEC  IN FI_ASSET_CLASS.ASSET_CLASS_SPEC%TYPE
            , P_ASSET_CLASS_USE   IN FI_ASSET_CLASS.ASSET_CLASS_USE%TYPE
            , P_ASSET_CATEGORY_ID IN FI_ASSET_CLASS.ASSET_CATEGORY_ID%TYPE
            , P_REMARK            IN FI_ASSET_CLASS.REMARK%TYPE
            , P_ENABLED_FLAG      IN FI_ASSET_CLASS.ENABLED_FLAG%TYPE
            , P_EFFECTIVE_DATE_FR IN FI_ASSET_CLASS.EFFECTIVE_DATE_FR%TYPE
            , P_EFFECTIVE_DATE_TO IN FI_ASSET_CLASS.EFFECTIVE_DATE_TO%TYPE
            , P_USER_ID           IN FI_ASSET_CLASS.CREATED_BY%TYPE
            );

-- 자산클래스 LOOKUP 조회.
  PROCEDURE LU_ASSET_CLASS
            ( P_CURSOR3              OUT TYPES.TCURSOR3
            , W_SOB_ID               IN FI_BANK.SOB_ID%TYPE
            , W_ENABLED_YN           IN FI_BANK.ENABLED_FLAG%TYPE
            );
            
END FI_ASSET_CLASS_G;
/
CREATE OR REPLACE PACKAGE BODY FI_ASSET_CLASS_G
AS
/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_ASSET_CLASS_G
/* Description  : 고정자산 클래스 관리
/*
/* Reference by :
/* Program History :
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
-- 고정자산 CLASS 관리.
  PROCEDURE SELECT_ASSET_CLASS
            ( P_CURSOR                OUT TYPES.TCURSOR
            , W_ASSET_CATEGORY_ID     IN FI_ASSET_CLASS.ASSET_CATEGORY_ID%TYPE
            , W_ASSET_CLASS_ID        IN FI_ASSET_CLASS.ASSET_CLASS_ID%TYPE
            , W_SOB_ID                IN FI_ASSET_CLASS.SOB_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR FOR
      SELECT AC.ASSET_CLASS_ID
           , AC.ASSET_CLASS_CODE
           , AC.SOB_ID
           , AC.ASSET_CLASS_NAME
           , AC.ASSET_CLASS_SPEC
           , AC.ASSET_CLASS_USE
           , AC.ASSET_CATEGORY_ID
           , FAC.ASSET_CATEGORY_CODE
           , FAC.ASSET_CATEGORY_NAME
           , AC.REMARK
           , AC.ENABLED_FLAG
           , AC.EFFECTIVE_DATE_FR
           , AC.EFFECTIVE_DATE_TO    
        FROM FI_ASSET_CLASS AC
          , FI_ASSET_CATEGORY FAC
       WHERE AC.ASSET_CATEGORY_ID       = FAC.ASSET_CATEGORY_ID
         AND AC.ASSET_CLASS_ID          = NVL(W_ASSET_CLASS_ID, AC.ASSET_CLASS_ID)
         AND AC.SOB_ID                  = W_SOB_ID
         AND AC.ASSET_CATEGORY_ID       = NVL(W_ASSET_CATEGORY_ID, AC.ASSET_CATEGORY_ID)
     ;
     
  END SELECT_ASSET_CLASS;

-- 고정자산 CLASS 삽입.
  PROCEDURE INSERT_ASSET_CLASS
            ( P_ASSET_CLASS_ID    OUT FI_ASSET_CLASS.ASSET_CLASS_ID%TYPE
            , P_ASSET_CLASS_CODE  IN FI_ASSET_CLASS.ASSET_CLASS_CODE%TYPE
            , P_SOB_ID            IN FI_ASSET_CLASS.SOB_ID%TYPE
            , P_ASSET_CLASS_NAME  IN FI_ASSET_CLASS.ASSET_CLASS_NAME%TYPE
            , P_ASSET_CLASS_SPEC  IN FI_ASSET_CLASS.ASSET_CLASS_SPEC%TYPE
            , P_ASSET_CLASS_USE   IN FI_ASSET_CLASS.ASSET_CLASS_USE%TYPE
            , P_ASSET_CATEGORY_ID IN FI_ASSET_CLASS.ASSET_CATEGORY_ID%TYPE
            , P_REMARK            IN FI_ASSET_CLASS.REMARK%TYPE
            , P_ENABLED_FLAG      IN FI_ASSET_CLASS.ENABLED_FLAG%TYPE
            , P_EFFECTIVE_DATE_FR IN FI_ASSET_CLASS.EFFECTIVE_DATE_FR%TYPE
            , P_EFFECTIVE_DATE_TO IN FI_ASSET_CLASS.EFFECTIVE_DATE_TO%TYPE
            , P_USER_ID           IN FI_ASSET_CLASS.CREATED_BY%TYPE
            )
  AS
    V_SYSDATE                  GL_FISCAL_YEAR.CREATION_DATE%TYPE;
    V_RECORD_COUNT NUMBER := 0;

  BEGIN
    -- 동일한 은행 그룹코드 존재 체크.
    BEGIN
      SELECT COUNT(AC.ASSET_CLASS_CODE) AS RECORD_COUNT
        INTO V_RECORD_COUNT
        FROM FI_ASSET_CLASS AC
       WHERE AC.ASSET_CLASS_CODE = P_ASSET_CLASS_CODE
         AND AC.SOB_ID              = P_SOB_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_RECORD_COUNT := 0;
    END;
    IF V_RECORD_COUNT <> 0 THEN
      RAISE ERRNUMS.Exist_Data;
    END IF;
    
    V_SYSDATE := GET_LOCAL_DATE(P_SOB_ID);

    SELECT FI_ASSET_CLASS_S1.NEXTVAL
      INTO P_ASSET_CLASS_ID
      FROM DUAL;

    INSERT INTO FI_ASSET_CLASS
    ( ASSET_CLASS_ID
    , ASSET_CLASS_CODE 
    , SOB_ID 
    , ASSET_CLASS_NAME 
    , ASSET_CLASS_SPEC 
    , ASSET_CLASS_USE 
    , ASSET_CATEGORY_ID 
    , REMARK 
    , ENABLED_FLAG 
    , EFFECTIVE_DATE_FR 
    , EFFECTIVE_DATE_TO 
    , CREATION_DATE 
    , CREATED_BY 
    , LAST_UPDATE_DATE 
    , LAST_UPDATED_BY )
    VALUES
    ( P_ASSET_CLASS_ID
    , P_ASSET_CLASS_CODE
    , P_SOB_ID
    , P_ASSET_CLASS_NAME
    , P_ASSET_CLASS_SPEC
    , P_ASSET_CLASS_USE
    , P_ASSET_CATEGORY_ID
    , P_REMARK
    , P_ENABLED_FLAG
    , P_EFFECTIVE_DATE_FR
    , P_EFFECTIVE_DATE_TO
    , V_SYSDATE
    , P_USER_ID
    , V_SYSDATE
    , P_USER_ID );

  END INSERT_ASSET_CLASS;

-- 고정자산 CLASS 수정.
  PROCEDURE UPDATE_ASSET_CLASS
            ( W_ASSET_CLASS_ID    IN FI_ASSET_CLASS.ASSET_CLASS_ID%TYPE
            , P_ASSET_CLASS_NAME  IN FI_ASSET_CLASS.ASSET_CLASS_NAME%TYPE
            , P_ASSET_CLASS_SPEC  IN FI_ASSET_CLASS.ASSET_CLASS_SPEC%TYPE
            , P_ASSET_CLASS_USE   IN FI_ASSET_CLASS.ASSET_CLASS_USE%TYPE
            , P_ASSET_CATEGORY_ID IN FI_ASSET_CLASS.ASSET_CATEGORY_ID%TYPE
            , P_REMARK            IN FI_ASSET_CLASS.REMARK%TYPE
            , P_ENABLED_FLAG      IN FI_ASSET_CLASS.ENABLED_FLAG%TYPE
            , P_EFFECTIVE_DATE_FR IN FI_ASSET_CLASS.EFFECTIVE_DATE_FR%TYPE
            , P_EFFECTIVE_DATE_TO IN FI_ASSET_CLASS.EFFECTIVE_DATE_TO%TYPE
            , P_USER_ID           IN FI_ASSET_CLASS.CREATED_BY%TYPE
            )
  AS
  BEGIN
    UPDATE FI_ASSET_CLASS
      SET ASSET_CLASS_NAME  = P_ASSET_CLASS_NAME
        , ASSET_CLASS_SPEC  = P_ASSET_CLASS_SPEC
        , ASSET_CLASS_USE   = P_ASSET_CLASS_USE
        , ASSET_CATEGORY_ID = P_ASSET_CATEGORY_ID
        , REMARK            = P_REMARK
        , ENABLED_FLAG      = P_ENABLED_FLAG
        , EFFECTIVE_DATE_FR = P_EFFECTIVE_DATE_FR
        , EFFECTIVE_DATE_TO = P_EFFECTIVE_DATE_TO
        , LAST_UPDATE_DATE  = GET_LOCAL_DATE(SOB_ID)
        , LAST_UPDATED_BY   = P_USER_ID
    WHERE ASSET_CLASS_ID    = W_ASSET_CLASS_ID
    ;

  END UPDATE_ASSET_CLASS;

-- 자산클래스 LOOKUP 조회.
  PROCEDURE LU_ASSET_CLASS
            ( P_CURSOR3              OUT TYPES.TCURSOR3
            , W_SOB_ID               IN FI_BANK.SOB_ID%TYPE
            , W_ENABLED_YN           IN FI_BANK.ENABLED_FLAG%TYPE
            )
  AS
    V_STD_DATE                       DATE := NULL;

  BEGIN
    IF W_ENABLED_YN = 'Y' THEN
      V_STD_DATE := GET_LOCAL_DATE(W_SOB_ID);
    END IF;
    
    OPEN P_CURSOR3 FOR
      SELECT AC.ASSET_CLASS_NAME
           , AC.ASSET_CLASS_CODE
           , AC.ASSET_CLASS_ID
        FROM FI_ASSET_CLASS AC
       WHERE AC.SOB_ID              = W_SOB_ID
         AND AC.ENABLED_FLAG        = DECODE(W_ENABLED_YN, 'Y', 'Y', AC.ENABLED_FLAG)
         AND AC.EFFECTIVE_DATE_FR   <= NVL(V_STD_DATE, AC.EFFECTIVE_DATE_FR)
         AND (AC.EFFECTIVE_DATE_TO IS NULL OR AC.EFFECTIVE_DATE_TO >= NVL(V_STD_DATE, AC.EFFECTIVE_DATE_TO))         
     ORDER BY AC.ASSET_CLASS_CODE
     ;
     
  END LU_ASSET_CLASS;
  
END FI_ASSET_CLASS_G;
/
