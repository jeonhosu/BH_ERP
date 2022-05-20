CREATE OR REPLACE PACKAGE FI_ACCOUNT_GROUP_G
AS

-- 회계 계정그룹 조회.
  PROCEDURE SELECT_ACCOUNT_GROUP
            ( P_CURSOR               OUT TYPES.TCURSOR
            , W_ACCOUNT_SET_ID       IN FI_ACCOUNT_GROUP.ACCOUNT_SET_ID%TYPE
            , W_ACCOUNT_CODE         IN FI_ACCOUNT_GROUP.ACCOUNT_CODE%TYPE
            );

-- 회계 계정그룹 삽입.
  PROCEDURE INSERT_ACCOUNT_GROUP
            ( P_ACCOUNT_GROUP_ID  OUT FI_ACCOUNT_GROUP.ACCOUNT_GROUP_ID%TYPE
            , P_ACCOUNT_SET_ID    IN FI_ACCOUNT_GROUP.ACCOUNT_SET_ID%TYPE
            , P_ACCOUNT_CODE      IN FI_ACCOUNT_GROUP.ACCOUNT_CODE%TYPE
            , P_ACCOUNT_DESC      IN FI_ACCOUNT_GROUP.ACCOUNT_DESC%TYPE
            , P_SEGMENT1_CODE     IN FI_ACCOUNT_GROUP.SEGMENT1_CODE%TYPE
            , P_SEGMENT1_DESC     IN FI_ACCOUNT_GROUP.SEGMENT1_DESC%TYPE
            , P_SEGMENT2_CODE     IN FI_ACCOUNT_GROUP.SEGMENT2_CODE%TYPE
            , P_SEGMENT2_DESC     IN FI_ACCOUNT_GROUP.SEGMENT2_DESC%TYPE
            , P_SEGMENT3_CODE     IN FI_ACCOUNT_GROUP.SEGMENT3_CODE%TYPE
            , P_SEGMENT3_DESC     IN FI_ACCOUNT_GROUP.SEGMENT3_DESC%TYPE
            , P_SEGMENT4_CODE     IN FI_ACCOUNT_GROUP.SEGMENT4_CODE%TYPE
            , P_SEGMENT4_DESC     IN FI_ACCOUNT_GROUP.SEGMENT4_DESC%TYPE
            , P_SEGMENT5_CODE     IN FI_ACCOUNT_GROUP.SEGMENT5_CODE%TYPE
            , P_SEGMENT5_DESC     IN FI_ACCOUNT_GROUP.SEGMENT5_DESC%TYPE
            , P_SEGMENT6_CODE     IN FI_ACCOUNT_GROUP.SEGMENT6_CODE%TYPE
            , P_SEGMENT6_DESC     IN FI_ACCOUNT_GROUP.SEGMENT6_DESC%TYPE
            , P_SEGMENT7_CODE     IN FI_ACCOUNT_GROUP.SEGMENT7_CODE%TYPE
            , P_SEGMENT7_DESC     IN FI_ACCOUNT_GROUP.SEGMENT7_DESC%TYPE
            , P_SEGMENT8_CODE     IN FI_ACCOUNT_GROUP.SEGMENT8_CODE%TYPE
            , P_SEGMENT8_DESC     IN FI_ACCOUNT_GROUP.SEGMENT8_DESC%TYPE
            , P_SEGMENT9_CODE     IN FI_ACCOUNT_GROUP.SEGMENT9_CODE%TYPE
            , P_SEGMENT9_DESC     IN FI_ACCOUNT_GROUP.SEGMENT9_DESC%TYPE
            , P_SEGMENT10_CODE    IN FI_ACCOUNT_GROUP.SEGMENT10_CODE%TYPE
            , P_SEGMENT10_DESC    IN FI_ACCOUNT_GROUP.SEGMENT10_DESC%TYPE
            , P_ENABLED_FLAG      IN FI_ACCOUNT_GROUP.ENABLED_FLAG%TYPE
            , P_EFFECTIVE_DATE_FR IN FI_ACCOUNT_GROUP.EFFECTIVE_DATE_FR%TYPE
            , P_EFFECTIVE_DATE_TO IN FI_ACCOUNT_GROUP.EFFECTIVE_DATE_TO%TYPE
            , P_SOB_ID            IN NUMBER
            , P_USER_ID           IN FI_ACCOUNT_GROUP.CREATED_BY%TYPE
            );

-- 회계 계정그룹 수정.
  PROCEDURE UPDATE_ACCOUNT_GROUP
            ( W_ACCOUNT_GROUP_ID  IN FI_ACCOUNT_GROUP.ACCOUNT_GROUP_ID%TYPE
            , W_SOB_ID            IN NUMBER
            , P_ACCOUNT_DESC      IN FI_ACCOUNT_GROUP.ACCOUNT_DESC%TYPE
            , P_SEGMENT1_DESC     IN FI_ACCOUNT_GROUP.SEGMENT1_DESC%TYPE
            , P_SEGMENT2_DESC     IN FI_ACCOUNT_GROUP.SEGMENT2_DESC%TYPE
            , P_SEGMENT3_DESC     IN FI_ACCOUNT_GROUP.SEGMENT3_DESC%TYPE
            , P_SEGMENT4_DESC     IN FI_ACCOUNT_GROUP.SEGMENT4_DESC%TYPE
            , P_SEGMENT5_DESC     IN FI_ACCOUNT_GROUP.SEGMENT5_DESC%TYPE
            , P_SEGMENT6_DESC     IN FI_ACCOUNT_GROUP.SEGMENT6_DESC%TYPE
            , P_SEGMENT7_DESC     IN FI_ACCOUNT_GROUP.SEGMENT7_DESC%TYPE
            , P_SEGMENT8_DESC     IN FI_ACCOUNT_GROUP.SEGMENT8_DESC%TYPE
            , P_SEGMENT9_DESC     IN FI_ACCOUNT_GROUP.SEGMENT9_DESC%TYPE
            , P_SEGMENT10_DESC    IN FI_ACCOUNT_GROUP.SEGMENT10_DESC%TYPE
            , P_ENABLED_FLAG      IN FI_ACCOUNT_GROUP.ENABLED_FLAG%TYPE
            , P_EFFECTIVE_DATE_FR IN FI_ACCOUNT_GROUP.EFFECTIVE_DATE_FR%TYPE
            , P_EFFECTIVE_DATE_TO IN FI_ACCOUNT_GROUP.EFFECTIVE_DATE_TO%TYPE
            , P_USER_ID           IN FI_ACCOUNT_GROUP.CREATED_BY%TYPE
            );

-- Lookup : 회계계정그룹관리 조회.
  PROCEDURE LU_ACCOUNT_GROUP
            ( P_CURSOR3           OUT TYPES.TCURSOR3
            , W_ACCOUNT_SET_ID    IN FI_ACCOUNT_GROUP.ACCOUNT_SET_ID%TYPE
            , W_ENABLED_YN        IN VARCHAR2
            , W_SOB_ID            IN NUMBER
            );

END FI_ACCOUNT_GROUP_G; 

 
/
CREATE OR REPLACE PACKAGE BODY FI_ACCOUNT_GROUP_G
AS
/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : FI_ACCOUNT_GROUP_G
/* Description  : 회계 계정그룹 관리.
/*
/* Reference by :
/* Program History :
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
-- 회계 계정그룹 조회.
  PROCEDURE SELECT_ACCOUNT_GROUP
            ( P_CURSOR               OUT TYPES.TCURSOR
            , W_ACCOUNT_SET_ID       IN FI_ACCOUNT_GROUP.ACCOUNT_SET_ID%TYPE
            , W_ACCOUNT_CODE         IN FI_ACCOUNT_GROUP.ACCOUNT_CODE%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR FOR
      SELECT AG.ACCOUNT_GROUP_ID
           , AG.ACCOUNT_SET_ID
           , AG.SEGMENT1_CODE
           , AG.SEGMENT1_DESC
           , AG.SEGMENT2_CODE
           , AG.SEGMENT2_DESC
           , AG.SEGMENT3_CODE
           , AG.SEGMENT3_DESC
           , AG.SEGMENT4_CODE
           , AG.SEGMENT4_DESC
           , AG.SEGMENT5_CODE
           , AG.SEGMENT5_DESC
           , AG.SEGMENT6_CODE
           , AG.SEGMENT6_DESC
           , AG.SEGMENT7_CODE
           , AG.SEGMENT7_DESC
           , AG.SEGMENT8_CODE
           , AG.SEGMENT8_DESC
           , AG.SEGMENT9_CODE
           , AG.SEGMENT9_DESC
           , AG.SEGMENT10_CODE
           , AG.SEGMENT10_DESC
           , AG.ACCOUNT_CODE
           , AG.ACCOUNT_DESC
           , AG.ENABLED_FLAG
           , AG.EFFECTIVE_DATE_FR
           , AG.EFFECTIVE_DATE_TO
        FROM FI_ACCOUNT_GROUP AG
       WHERE AG.ACCOUNT_SET_ID          = W_ACCOUNT_SET_ID
         AND AG.ACCOUNT_CODE            = NVL(W_ACCOUNT_CODE, AG.ACCOUNT_CODE)
      ORDER BY AG.ACCOUNT_CODE
      ;

  END SELECT_ACCOUNT_GROUP;

-- 회계 계정그룹 삽입.
  PROCEDURE INSERT_ACCOUNT_GROUP
            ( P_ACCOUNT_GROUP_ID  OUT FI_ACCOUNT_GROUP.ACCOUNT_GROUP_ID%TYPE
            , P_ACCOUNT_SET_ID    IN FI_ACCOUNT_GROUP.ACCOUNT_SET_ID%TYPE
            , P_ACCOUNT_CODE      IN FI_ACCOUNT_GROUP.ACCOUNT_CODE%TYPE
            , P_ACCOUNT_DESC      IN FI_ACCOUNT_GROUP.ACCOUNT_DESC%TYPE
            , P_SEGMENT1_CODE     IN FI_ACCOUNT_GROUP.SEGMENT1_CODE%TYPE
            , P_SEGMENT1_DESC     IN FI_ACCOUNT_GROUP.SEGMENT1_DESC%TYPE
            , P_SEGMENT2_CODE     IN FI_ACCOUNT_GROUP.SEGMENT2_CODE%TYPE
            , P_SEGMENT2_DESC     IN FI_ACCOUNT_GROUP.SEGMENT2_DESC%TYPE
            , P_SEGMENT3_CODE     IN FI_ACCOUNT_GROUP.SEGMENT3_CODE%TYPE
            , P_SEGMENT3_DESC     IN FI_ACCOUNT_GROUP.SEGMENT3_DESC%TYPE
            , P_SEGMENT4_CODE     IN FI_ACCOUNT_GROUP.SEGMENT4_CODE%TYPE
            , P_SEGMENT4_DESC     IN FI_ACCOUNT_GROUP.SEGMENT4_DESC%TYPE
            , P_SEGMENT5_CODE     IN FI_ACCOUNT_GROUP.SEGMENT5_CODE%TYPE
            , P_SEGMENT5_DESC     IN FI_ACCOUNT_GROUP.SEGMENT5_DESC%TYPE
            , P_SEGMENT6_CODE     IN FI_ACCOUNT_GROUP.SEGMENT6_CODE%TYPE
            , P_SEGMENT6_DESC     IN FI_ACCOUNT_GROUP.SEGMENT6_DESC%TYPE
            , P_SEGMENT7_CODE     IN FI_ACCOUNT_GROUP.SEGMENT7_CODE%TYPE
            , P_SEGMENT7_DESC     IN FI_ACCOUNT_GROUP.SEGMENT7_DESC%TYPE
            , P_SEGMENT8_CODE     IN FI_ACCOUNT_GROUP.SEGMENT8_CODE%TYPE
            , P_SEGMENT8_DESC     IN FI_ACCOUNT_GROUP.SEGMENT8_DESC%TYPE
            , P_SEGMENT9_CODE     IN FI_ACCOUNT_GROUP.SEGMENT9_CODE%TYPE
            , P_SEGMENT9_DESC     IN FI_ACCOUNT_GROUP.SEGMENT9_DESC%TYPE
            , P_SEGMENT10_CODE    IN FI_ACCOUNT_GROUP.SEGMENT10_CODE%TYPE
            , P_SEGMENT10_DESC    IN FI_ACCOUNT_GROUP.SEGMENT10_DESC%TYPE
            , P_ENABLED_FLAG      IN FI_ACCOUNT_GROUP.ENABLED_FLAG%TYPE
            , P_EFFECTIVE_DATE_FR IN FI_ACCOUNT_GROUP.EFFECTIVE_DATE_FR%TYPE
            , P_EFFECTIVE_DATE_TO IN FI_ACCOUNT_GROUP.EFFECTIVE_DATE_TO%TYPE
            , P_SOB_ID            IN NUMBER
            , P_USER_ID           IN FI_ACCOUNT_GROUP.CREATED_BY%TYPE
            )
  AS
    V_SYSDATE                    FI_ACCOUNT_SET.CREATION_DATE%TYPE;
    V_RECORD_COUNT               NUMBER := 0;

  BEGIN
    V_SYSDATE := GET_LOCAL_DATE(P_SOB_ID);
    V_RECORD_COUNT := 0;
    BEGIN
      SELECT COUNT(AG.ACCOUNT_CODE) AS RECORD_COUNT
        INTO V_RECORD_COUNT
        FROM FI_ACCOUNT_GROUP AG
       WHERE AG.ACCOUNT_CODE      = P_ACCOUNT_CODE
         AND AG.ACCOUNT_SET_ID    = P_ACCOUNT_SET_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_RECORD_COUNT := 0;
    END;
    IF V_RECORD_COUNT > 0 THEN
      RAISE_APPLICATION_ERROR(ERRNUMS.Exist_Data_Code, '[' || P_ACCOUNT_CODE || '] ' || ERRNUMS.Exist_Data_Desc);
    END IF;

    SELECT FI_ACCOUNT_GROUP_S1.NEXTVAL
      INTO P_ACCOUNT_GROUP_ID
      FROM DUAL;

    INSERT INTO FI_ACCOUNT_GROUP
    ( ACCOUNT_GROUP_ID
    , ACCOUNT_SET_ID
    , ACCOUNT_CODE
    , ACCOUNT_DESC
    , SEGMENT1_CODE
    , SEGMENT1_DESC
    , SEGMENT2_CODE
    , SEGMENT2_DESC
    , SEGMENT3_CODE
    , SEGMENT3_DESC
    , SEGMENT4_CODE
    , SEGMENT4_DESC
    , SEGMENT5_CODE
    , SEGMENT5_DESC
    , SEGMENT6_CODE
    , SEGMENT6_DESC
    , SEGMENT7_CODE
    , SEGMENT7_DESC
    , SEGMENT8_CODE
    , SEGMENT8_DESC
    , SEGMENT9_CODE
    , SEGMENT9_DESC
    , SEGMENT10_CODE
    , SEGMENT10_DESC
    , ENABLED_FLAG
    , EFFECTIVE_DATE_FR
    , EFFECTIVE_DATE_TO
    , CREATION_DATE
    , CREATED_BY
    , LAST_UPDATE_DATE
    , LAST_UPDATED_BY )
    VALUES
    ( P_ACCOUNT_GROUP_ID
    , P_ACCOUNT_SET_ID
    , P_ACCOUNT_CODE
    , P_ACCOUNT_DESC
    , P_SEGMENT1_CODE
    , P_SEGMENT1_DESC
    , P_SEGMENT2_CODE
    , P_SEGMENT2_DESC
    , P_SEGMENT3_CODE
    , P_SEGMENT3_DESC
    , P_SEGMENT4_CODE
    , P_SEGMENT4_DESC
    , P_SEGMENT5_CODE
    , P_SEGMENT5_DESC
    , P_SEGMENT6_CODE
    , P_SEGMENT6_DESC
    , P_SEGMENT7_CODE
    , P_SEGMENT7_DESC
    , P_SEGMENT8_CODE
    , P_SEGMENT8_DESC
    , P_SEGMENT9_CODE
    , P_SEGMENT9_DESC
    , P_SEGMENT10_CODE
    , P_SEGMENT10_DESC
    , P_ENABLED_FLAG
    , P_EFFECTIVE_DATE_FR
    , P_EFFECTIVE_DATE_TO
    , V_SYSDATE
    , P_USER_ID
    , V_SYSDATE
    , P_USER_ID );
    
    
    BEGIN
      UPDATE FI_ACCOUNT_CONTROL AC
        SET AC.ACCOUNT_DESC = P_ACCOUNT_DESC
      WHERE AC.ACCOUNT_GROUP_ID   = P_ACCOUNT_GROUP_ID
        AND AC.SOB_ID             = P_SOB_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      NULL;
    END;
  END INSERT_ACCOUNT_GROUP;

-- 회계 계정그룹 수정.
  PROCEDURE UPDATE_ACCOUNT_GROUP
            ( W_ACCOUNT_GROUP_ID  IN FI_ACCOUNT_GROUP.ACCOUNT_GROUP_ID%TYPE
            , W_SOB_ID            IN NUMBER
            , P_ACCOUNT_DESC      IN FI_ACCOUNT_GROUP.ACCOUNT_DESC%TYPE
            , P_SEGMENT1_DESC     IN FI_ACCOUNT_GROUP.SEGMENT1_DESC%TYPE
            , P_SEGMENT2_DESC     IN FI_ACCOUNT_GROUP.SEGMENT2_DESC%TYPE
            , P_SEGMENT3_DESC     IN FI_ACCOUNT_GROUP.SEGMENT3_DESC%TYPE
            , P_SEGMENT4_DESC     IN FI_ACCOUNT_GROUP.SEGMENT4_DESC%TYPE
            , P_SEGMENT5_DESC     IN FI_ACCOUNT_GROUP.SEGMENT5_DESC%TYPE
            , P_SEGMENT6_DESC     IN FI_ACCOUNT_GROUP.SEGMENT6_DESC%TYPE
            , P_SEGMENT7_DESC     IN FI_ACCOUNT_GROUP.SEGMENT7_DESC%TYPE
            , P_SEGMENT8_DESC     IN FI_ACCOUNT_GROUP.SEGMENT8_DESC%TYPE
            , P_SEGMENT9_DESC     IN FI_ACCOUNT_GROUP.SEGMENT9_DESC%TYPE
            , P_SEGMENT10_DESC    IN FI_ACCOUNT_GROUP.SEGMENT10_DESC%TYPE
            , P_ENABLED_FLAG      IN FI_ACCOUNT_GROUP.ENABLED_FLAG%TYPE
            , P_EFFECTIVE_DATE_FR IN FI_ACCOUNT_GROUP.EFFECTIVE_DATE_FR%TYPE
            , P_EFFECTIVE_DATE_TO IN FI_ACCOUNT_GROUP.EFFECTIVE_DATE_TO%TYPE
            , P_USER_ID           IN FI_ACCOUNT_GROUP.CREATED_BY%TYPE
            )
  AS
  BEGIN
    UPDATE FI_ACCOUNT_GROUP
      SET ACCOUNT_DESC      = P_ACCOUNT_DESC
        , SEGMENT1_DESC     = P_SEGMENT1_DESC
        , SEGMENT2_DESC     = P_SEGMENT2_DESC
        , SEGMENT3_DESC     = P_SEGMENT3_DESC
        , SEGMENT4_DESC     = P_SEGMENT4_DESC
        , SEGMENT5_DESC     = P_SEGMENT5_DESC
        , SEGMENT6_DESC     = P_SEGMENT6_DESC
        , SEGMENT7_DESC     = P_SEGMENT7_DESC
        , SEGMENT8_DESC     = P_SEGMENT8_DESC
        , SEGMENT9_DESC     = P_SEGMENT9_DESC
        , SEGMENT10_DESC    = P_SEGMENT10_DESC
        , ENABLED_FLAG      = P_ENABLED_FLAG
        , EFFECTIVE_DATE_FR = P_EFFECTIVE_DATE_FR
        , EFFECTIVE_DATE_TO = P_EFFECTIVE_DATE_TO
        , LAST_UPDATE_DATE  = GET_LOCAL_DATE(W_SOB_ID)
        , LAST_UPDATED_BY   = P_USER_ID
    WHERE ACCOUNT_GROUP_ID  = W_ACCOUNT_GROUP_ID
    ;

    BEGIN
      UPDATE FI_ACCOUNT_CONTROL AC
        SET AC.ACCOUNT_DESC = P_ACCOUNT_DESC
      WHERE AC.ACCOUNT_GROUP_ID   = W_ACCOUNT_GROUP_ID
        AND AC.SOB_ID             = W_SOB_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      NULL;
    END;
  END UPDATE_ACCOUNT_GROUP;

-- Lookup : 회계계정그룹관리 조회.
  PROCEDURE LU_ACCOUNT_GROUP
            ( P_CURSOR3           OUT TYPES.TCURSOR3
            , W_ACCOUNT_SET_ID    IN FI_ACCOUNT_GROUP.ACCOUNT_SET_ID%TYPE
            , W_ENABLED_YN        IN VARCHAR2
            , W_SOB_ID            IN NUMBER
            )
  AS
    V_SYSDATE                     DATE := NULL;

  BEGIN
    IF W_ENABLED_YN = 'Y' THEN
      V_SYSDATE := GET_LOCAL_DATE(W_SOB_ID);
    END IF;

    OPEN P_CURSOR3 FOR
      SELECT AG.ACCOUNT_DESC
           , AG.ACCOUNT_CODE
           , AG.ACCOUNT_GROUP_ID
        FROM FI_ACCOUNT_GROUP AG
      WHERE AG.ACCOUNT_SET_ID          = W_ACCOUNT_SET_ID
        AND AG.ENABLED_FLAG            = DECODE(W_ENABLED_YN, 'Y', 'Y', AG.ENABLED_FLAG)
        AND AG.EFFECTIVE_DATE_FR       <= NVL(V_SYSDATE, AG.EFFECTIVE_DATE_FR)
        AND (AG.EFFECTIVE_DATE_TO IS NULL OR AG.EFFECTIVE_DATE_TO >= NVL(V_SYSDATE, AG.EFFECTIVE_DATE_TO))
      ORDER BY AG.ACCOUNT_CODE
      ;

  END LU_ACCOUNT_GROUP;

END FI_ACCOUNT_GROUP_G; 
/
