CREATE OR REPLACE PACKAGE FI_DEPT_MASTER_G
AS

-- ????? ??.
  PROCEDURE DATA_SELECT
            ( P_CURSOR             OUT TYPES.TCURSOR
            , W_SOB_ID             IN FI_DEPT_MASTER.SOB_ID%TYPE
            , W_DEPT_ID            IN FI_DEPT_MASTER.DEPT_ID%TYPE
            );

-- DEPARTMENT INSERT.
  PROCEDURE DATA_INSERT
            ( P_DEPT_ID            OUT FI_DEPT_MASTER.DEPT_ID%TYPE
            , P_SOB_ID             IN FI_DEPT_MASTER.SOB_ID%TYPE
            , P_DEPT_CODE          IN FI_DEPT_MASTER.DEPT_CODE%TYPE
            , P_DEPT_NAME          IN FI_DEPT_MASTER.DEPT_NAME%TYPE
            , P_DEPT_NAME_S        IN FI_DEPT_MASTER.DEPT_NAME_S%TYPE
            , P_DEPT_LEVEL         IN FI_DEPT_MASTER.DEPT_LEVEL%TYPE
            , P_UPPER_DEPT_ID      IN FI_DEPT_MASTER.UPPER_DEPT_ID%TYPE
            , P_SORT_NUM           IN FI_DEPT_MASTER.SORT_NUM%TYPE
            , P_DEPT_GROUP         IN FI_DEPT_MASTER.DEPT_GROUP%TYPE
            , P_DESCRIPTION        IN FI_DEPT_MASTER.DESCRIPTION%TYPE
            , P_ENABLED_FLAG       IN FI_DEPT_MASTER.ENABLED_FLAG%TYPE
            , P_EFFECTIVE_DATE_FR  IN FI_DEPT_MASTER.EFFECTIVE_DATE_FR%TYPE
            , P_EFFECTIVE_DATE_TO  IN FI_DEPT_MASTER.EFFECTIVE_DATE_TO%TYPE
            , P_USER_ID            IN FI_DEPT_MASTER.CREATED_BY%TYPE
            );

-- DEPARTMENT UPDATE.
  PROCEDURE DATA_UPDATE
            ( W_DEPT_ID            IN FI_DEPT_MASTER.DEPT_ID%TYPE
            , P_DEPT_CODE          IN FI_DEPT_MASTER.DEPT_CODE%TYPE
            , P_DEPT_NAME          IN FI_DEPT_MASTER.DEPT_NAME%TYPE
            , P_DEPT_NAME_S        IN FI_DEPT_MASTER.DEPT_NAME_S%TYPE
            , P_DEPT_LEVEL         IN FI_DEPT_MASTER.DEPT_LEVEL%TYPE
            , P_UPPER_DEPT_ID      IN FI_DEPT_MASTER.UPPER_DEPT_ID%TYPE
            , P_SORT_NUM           IN FI_DEPT_MASTER.SORT_NUM%TYPE
            , P_DEPT_GROUP         IN FI_DEPT_MASTER.DEPT_GROUP%TYPE
            , P_DESCRIPTION        IN FI_DEPT_MASTER.DESCRIPTION%TYPE
            , P_ENABLED_FLAG       IN FI_DEPT_MASTER.ENABLED_FLAG%TYPE
            , P_EFFECTIVE_DATE_FR  IN FI_DEPT_MASTER.EFFECTIVE_DATE_FR%TYPE
            , P_EFFECTIVE_DATE_TO  IN FI_DEPT_MASTER.EFFECTIVE_DATE_TO%TYPE
            , P_USER_ID            IN FI_DEPT_MASTER.CREATED_BY%TYPE
            );

---------------------------------------------------------------------------------------------------
-- DEPT_NAME_F : DEPT_ID? ??? ??? ???.
  FUNCTION DEPT_NAME_F
          ( W_DEPT_ID             IN FI_DEPT_MASTER.DEPT_ID%TYPE
          ) RETURN VARCHAR2;

-- LOOKUP DEPT - LEVEL ? ??.
  PROCEDURE LU_SELECT
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_SOB_ID            IN FI_DEPT_MASTER.SOB_ID%TYPE
            , W_DEPT_LEVEL        IN FI_DEPT_MASTER.DEPT_LEVEL%TYPE DEFAULT NULL
            , W_ENABLED_YN        IN FI_DEPT_MASTER.ENABLED_FLAG%TYPE DEFAULT 'Y'
            );

-- LOOKUP DEPT LEVEL ??.
  PROCEDURE LU_SELECT_LEVEL
            ( P_CURSOR1           OUT TYPES.TCURSOR1
            , W_SOB_ID            IN FI_DEPT_MASTER.SOB_ID%TYPE
            , W_DEPT_LEVEL        IN FI_DEPT_MASTER.DEPT_LEVEL%TYPE DEFAULT NULL
            , W_ENABLED_YN        IN FI_DEPT_MASTER.ENABLED_FLAG%TYPE DEFAULT 'Y'
            );

-- LOOKUP DEPT - ??? ??? ??.
  PROCEDURE LU_SELECT_C
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_SOB_ID            IN FI_DEPT_MASTER.SOB_ID%TYPE
            , W_ENABLED_YN        IN FI_DEPT_MASTER.ENABLED_FLAG%TYPE DEFAULT 'Y'
            , W_CONNECT_PERSON_ID IN NUMBER
            );

-- LOOKUP DEPT - 접속자의 예산부서 조회.
  PROCEDURE LU_SELECT_BUDGET_DEPT
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_BUDGET_TYPE       IN FI_BUDGET_ADD.BUDGET_TYPE%TYPE
            , W_SOB_ID            IN FI_DEPT_MASTER.SOB_ID%TYPE
            , W_ENABLED_YN        IN FI_DEPT_MASTER.ENABLED_FLAG%TYPE DEFAULT 'Y'
            , W_CONNECT_PERSON_ID IN NUMBER
            );
            
END FI_DEPT_MASTER_G; 

 
/
CREATE OR REPLACE PACKAGE BODY FI_DEPT_MASTER_G
AS
/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : FI_DEPT_MASTER_G
/* Description  : ???? ?? ???
/*
/* Reference by : ???? ??.
/* Program History :
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
-- ????? ??.
  PROCEDURE DATA_SELECT
            ( P_CURSOR             OUT TYPES.TCURSOR
            , W_SOB_ID             IN FI_DEPT_MASTER.SOB_ID%TYPE
            , W_DEPT_ID            IN FI_DEPT_MASTER.DEPT_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR FOR
      SELECT DM.DEPT_ID
          , DM.SOB_ID
          , DM.DEPT_CODE
          , DM.DEPT_NAME
          , DM.DEPT_NAME_S
          , DM.DEPT_LEVEL
          , DM.UPPER_DEPT_ID
          , U_DM.DEPT_NAME UPPER_DEPT_NAME
          , DM.SORT_NUM
          , DM.DEPT_GROUP
          , DM.DESCRIPTION
          , DM.ENABLED_FLAG
          , DM.EFFECTIVE_DATE_FR
          , DM.EFFECTIVE_DATE_TO
      FROM FI_DEPT_MASTER DM
        , FI_DEPT_MASTER U_DM
      WHERE DECODE(DM.DEPT_LEVEL, 1, DM.DEPT_ID, DM.UPPER_DEPT_ID) = U_DM.DEPT_ID(+)
        AND DM.SOB_ID                 = W_SOB_ID
        AND DM.DEPT_ID                = NVL(W_DEPT_ID, DM.DEPT_ID)
     ORDER BY DM.SORT_NUM, DM.DEPT_LEVEL, DM.DEPT_CODE
      ;

  END DATA_SELECT;

-- DEPARTMENT INSERT.
  PROCEDURE DATA_INSERT
            ( P_DEPT_ID            OUT FI_DEPT_MASTER.DEPT_ID%TYPE
            , P_SOB_ID             IN FI_DEPT_MASTER.SOB_ID%TYPE
            , P_DEPT_CODE          IN FI_DEPT_MASTER.DEPT_CODE%TYPE
            , P_DEPT_NAME          IN FI_DEPT_MASTER.DEPT_NAME%TYPE
            , P_DEPT_NAME_S        IN FI_DEPT_MASTER.DEPT_NAME_S%TYPE
            , P_DEPT_LEVEL         IN FI_DEPT_MASTER.DEPT_LEVEL%TYPE
            , P_UPPER_DEPT_ID      IN FI_DEPT_MASTER.UPPER_DEPT_ID%TYPE
            , P_SORT_NUM           IN FI_DEPT_MASTER.SORT_NUM%TYPE
            , P_DEPT_GROUP         IN FI_DEPT_MASTER.DEPT_GROUP%TYPE
            , P_DESCRIPTION        IN FI_DEPT_MASTER.DESCRIPTION%TYPE
            , P_ENABLED_FLAG       IN FI_DEPT_MASTER.ENABLED_FLAG%TYPE
            , P_EFFECTIVE_DATE_FR  IN FI_DEPT_MASTER.EFFECTIVE_DATE_FR%TYPE
            , P_EFFECTIVE_DATE_TO  IN FI_DEPT_MASTER.EFFECTIVE_DATE_TO%TYPE
            , P_USER_ID            IN FI_DEPT_MASTER.CREATED_BY%TYPE
            )
  AS
    V_SYSDATE                      DATE;

  BEGIN
    V_SYSDATE := GET_LOCAL_DATE(P_SOB_ID);

    SELECT FI_DEPT_MASTER_S1.NEXTVAL
      INTO P_DEPT_ID
      FROM DUAL;

    INSERT INTO FI_DEPT_MASTER
    ( DEPT_ID, SOB_ID
    , DEPT_CODE, DEPT_NAME, DEPT_NAME_S
    , DEPT_LEVEL, UPPER_DEPT_ID, SORT_NUM
    , DEPT_GROUP
    , DESCRIPTION
    , ENABLED_FLAG, EFFECTIVE_DATE_FR, EFFECTIVE_DATE_TO
    , CREATION_DATE, CREATED_BY
    , LAST_UPDATE_DATE, LAST_UPDATED_BY
    ) VALUES
    ( P_DEPT_ID, P_SOB_ID
    , P_DEPT_CODE, P_DEPT_NAME, P_DEPT_NAME_S
    , P_DEPT_LEVEL, P_UPPER_DEPT_ID, P_SORT_NUM
    , P_DEPT_GROUP
    , P_DESCRIPTION
    , P_ENABLED_FLAG, TRUNC(P_EFFECTIVE_DATE_FR), TRUNC(P_EFFECTIVE_DATE_TO)
    , V_SYSDATE, P_USER_ID, V_SYSDATE, P_USER_ID
    );

  END DATA_INSERT;

-- DEPARTMENT UPDATE.
  PROCEDURE DATA_UPDATE
            ( W_DEPT_ID            IN FI_DEPT_MASTER.DEPT_ID%TYPE
            , P_DEPT_CODE          IN FI_DEPT_MASTER.DEPT_CODE%TYPE
            , P_DEPT_NAME          IN FI_DEPT_MASTER.DEPT_NAME%TYPE
            , P_DEPT_NAME_S        IN FI_DEPT_MASTER.DEPT_NAME_S%TYPE
            , P_DEPT_LEVEL         IN FI_DEPT_MASTER.DEPT_LEVEL%TYPE
            , P_UPPER_DEPT_ID      IN FI_DEPT_MASTER.UPPER_DEPT_ID%TYPE
            , P_SORT_NUM           IN FI_DEPT_MASTER.SORT_NUM%TYPE
            , P_DEPT_GROUP         IN FI_DEPT_MASTER.DEPT_GROUP%TYPE
            , P_DESCRIPTION        IN FI_DEPT_MASTER.DESCRIPTION%TYPE
            , P_ENABLED_FLAG       IN FI_DEPT_MASTER.ENABLED_FLAG%TYPE
            , P_EFFECTIVE_DATE_FR  IN FI_DEPT_MASTER.EFFECTIVE_DATE_FR%TYPE
            , P_EFFECTIVE_DATE_TO  IN FI_DEPT_MASTER.EFFECTIVE_DATE_TO%TYPE
            , P_USER_ID            IN FI_DEPT_MASTER.CREATED_BY%TYPE
            )
  AS
  BEGIN
    UPDATE FI_DEPT_MASTER DM
      SET DM.DEPT_CODE             = P_DEPT_CODE
        , DM.DEPT_NAME             = P_DEPT_NAME
        , DM.DEPT_NAME_S           = P_DEPT_NAME_S
        , DM.DEPT_LEVEL            = P_DEPT_LEVEL
        , DM.UPPER_DEPT_ID         = P_UPPER_DEPT_ID
        , DM.SORT_NUM              = P_SORT_NUM
        , DM.DEPT_GROUP            = P_DEPT_GROUP
        , DM.DESCRIPTION           = P_DESCRIPTION
        , DM.ENABLED_FLAG          = P_ENABLED_FLAG
        , DM.EFFECTIVE_DATE_FR     = TRUNC(P_EFFECTIVE_DATE_FR)
        , DM.EFFECTIVE_DATE_TO     = TRUNC(P_EFFECTIVE_DATE_TO)
        , DM.LAST_UPDATE_DATE      = GET_LOCAL_DATE(DM.SOB_ID)
        , DM.LAST_UPDATED_BY       = P_USER_ID
    WHERE DM.DEPT_ID               = W_DEPT_ID
    ;

  END DATA_UPDATE;

---------------------------------------------------------------------------------------------------
-- DEPT_NAME_F : DEPT_ID? ??? ??? ???.
  FUNCTION DEPT_NAME_F
          ( W_DEPT_ID             IN FI_DEPT_MASTER.DEPT_ID%TYPE
          ) RETURN VARCHAR2
  AS
    V_DEPT_NAME                   FI_DEPT_MASTER.DEPT_NAME%TYPE := NULL;

  BEGIN
    BEGIN
      SELECT DM.DEPT_NAME
        INTO V_DEPT_NAME
      FROM FI_DEPT_MASTER DM
      WHERE DM.DEPT_ID            = W_DEPT_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_DEPT_NAME := '';
    END;
    RETURN V_DEPT_NAME;

  END DEPT_NAME_F;

-- LOOKUP DEPT - LEVEL ? ??.
  PROCEDURE LU_SELECT
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_SOB_ID            IN FI_DEPT_MASTER.SOB_ID%TYPE
            , W_DEPT_LEVEL        IN FI_DEPT_MASTER.DEPT_LEVEL%TYPE
            , W_ENABLED_YN        IN FI_DEPT_MASTER.ENABLED_FLAG%TYPE DEFAULT 'Y'
            )
  AS
    N_DEPT_LEVEL                  FI_DEPT_MASTER.DEPT_LEVEL%TYPE := 1;
    V_STD_DATE                    FI_DEPT_MASTER.EFFECTIVE_DATE_FR%TYPE;

  BEGIN
    IF W_DEPT_LEVEL IS NULL OR W_DEPT_LEVEL = 0 THEN
      BEGIN
        SELECT NVL(AB.DEPT_LEVEL, 1) AS DEPT_CONTROL_LEVEL
          INTO N_DEPT_LEVEL
          FROM FI_ACCOUNT_BOOK AB
         WHERE AB.SOB_ID                  = W_SOB_ID
           AND AB.OPERATING_FLAG          = 'Y'
           AND ROWNUM                     <= 1
        ;
      EXCEPTION WHEN OTHERS THEN
        N_DEPT_LEVEL := 1;
      END;
    ELSE
      N_DEPT_LEVEL := W_DEPT_LEVEL;
    END IF;

    -- ???? ?? ??.
    IF W_ENABLED_YN = 'Y' THEN
      V_STD_DATE := TRUNC(GET_LOCAL_DATE(W_SOB_ID));
    ELSE
      V_STD_DATE := NULL;
    END IF;

    OPEN P_CURSOR FOR
      SELECT DM.DEPT_NAME
          , DM.DEPT_CODE
          , DM.DEPT_ID
      FROM FI_DEPT_MASTER DM
      WHERE DM.SOB_ID                = W_SOB_ID
        AND DM.DEPT_LEVEL            = N_DEPT_LEVEL
        AND DM.ENABLED_FLAG          = DECODE(W_ENABLED_YN, 'Y', 'Y', DM.ENABLED_FLAG)
        AND DM.EFFECTIVE_DATE_FR     <= NVL(V_STD_DATE, DM.EFFECTIVE_DATE_FR)
        AND (DM.EFFECTIVE_DATE_TO IS NULL OR DM.EFFECTIVE_DATE_TO >= NVL(V_STD_DATE, DM.EFFECTIVE_DATE_TO))
      ;

  END LU_SELECT;

-- LOOKUP DEPT LEVEL ??.
  PROCEDURE LU_SELECT_LEVEL
            ( P_CURSOR1           OUT TYPES.TCURSOR1
            , W_SOB_ID            IN FI_DEPT_MASTER.SOB_ID%TYPE
            , W_DEPT_LEVEL        IN FI_DEPT_MASTER.DEPT_LEVEL%TYPE
            , W_ENABLED_YN        IN FI_DEPT_MASTER.ENABLED_FLAG%TYPE DEFAULT 'Y'
            )
  AS
    N_DEPT_LEVEL                  FI_DEPT_MASTER.DEPT_LEVEL%TYPE := 1;
    V_STD_DATE                    FI_DEPT_MASTER.EFFECTIVE_DATE_FR%TYPE;

  BEGIN
    N_DEPT_LEVEL := W_DEPT_LEVEL - 1;
    IF N_DEPT_LEVEL < 1 THEN
      N_DEPT_LEVEL := 1;
    END IF;

    -- ???? ?? ??.
    IF W_ENABLED_YN = 'Y' THEN
      V_STD_DATE := TRUNC(GET_LOCAL_DATE(W_SOB_ID));
    ELSE
      V_STD_DATE := NULL;
    END IF;

    OPEN P_CURSOR1 FOR
      SELECT DM.DEPT_NAME
          , DM.DEPT_CODE
          , DM.DEPT_LEVEL
          , DM.DEPT_ID
      FROM FI_DEPT_MASTER DM
      WHERE DM.SOB_ID                = W_SOB_ID
        AND DM.DEPT_LEVEL            = N_DEPT_LEVEL
        AND DM.ENABLED_FLAG          = DECODE(W_ENABLED_YN, 'Y', 'Y', DM.ENABLED_FLAG)
        AND DM.EFFECTIVE_DATE_FR     <= NVL(V_STD_DATE, DM.EFFECTIVE_DATE_FR)
        AND (DM.EFFECTIVE_DATE_TO IS NULL OR DM.EFFECTIVE_DATE_TO >= NVL(V_STD_DATE, DM.EFFECTIVE_DATE_TO))
      ;

  END LU_SELECT_LEVEL;

-- LOOKUP DEPT - ??? ??? ??.
  PROCEDURE LU_SELECT_C
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_SOB_ID            IN FI_DEPT_MASTER.SOB_ID%TYPE
            , W_ENABLED_YN        IN FI_DEPT_MASTER.ENABLED_FLAG%TYPE DEFAULT 'Y'
            , W_CONNECT_PERSON_ID IN NUMBER
            )
  AS
    N_DEPT_LEVEL                  FI_DEPT_MASTER.DEPT_LEVEL%TYPE := 1;
    V_STD_DATE                    FI_DEPT_MASTER.EFFECTIVE_DATE_FR%TYPE;

  BEGIN
    BEGIN
      SELECT NVL(AB.DEPT_LEVEL, 1) AS DEPT_CONTROL_LEVEL
        INTO N_DEPT_LEVEL
        FROM FI_ACCOUNT_BOOK AB
       WHERE AB.SOB_ID                  = W_SOB_ID
         AND AB.OPERATING_FLAG          = 'Y'
         AND ROWNUM                     <= 1
      ;
    EXCEPTION WHEN OTHERS THEN
      N_DEPT_LEVEL := 1;
    END;

    -- ???? ?? ??.
    IF W_ENABLED_YN = 'Y' THEN
      V_STD_DATE := TRUNC(GET_LOCAL_DATE(W_SOB_ID));
    ELSE
      V_STD_DATE := NULL;
    END IF;

    OPEN P_CURSOR FOR
      SELECT DM.DEPT_NAME
          , DM.DEPT_CODE
          , DM.DEPT_ID
      FROM FI_DEPT_MASTER DM
      WHERE DM.SOB_ID                = W_SOB_ID
        AND DM.DEPT_LEVEL            = N_DEPT_LEVEL
        AND DM.ENABLED_FLAG          = DECODE(W_ENABLED_YN, 'Y', 'Y', DM.ENABLED_FLAG)
        AND DM.EFFECTIVE_DATE_FR     <= NVL(V_STD_DATE, DM.EFFECTIVE_DATE_FR)
        AND (DM.EFFECTIVE_DATE_TO IS NULL OR DM.EFFECTIVE_DATE_TO >= NVL(V_STD_DATE, DM.EFFECTIVE_DATE_TO))
        AND EXISTS (SELECT 'X'
                      FROM HRM_PERSON_MASTER PM
                        , HRM_DEPT_MAPPING DM1
                    WHERE PM.DEPT_ID        = DM1.HR_DEPT_ID
                      AND PM.SOB_ID         = DM1.SOB_ID
                      AND DM1.M_DEPT_ID     = DM.DEPT_ID
                      AND PM.PERSON_ID      = W_CONNECT_PERSON_ID
                   )
      ;
  
  END LU_SELECT_C;

-- LOOKUP DEPT - 접속자의 예산부서 조회.
  PROCEDURE LU_SELECT_BUDGET_DEPT
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_BUDGET_TYPE       IN FI_BUDGET_ADD.BUDGET_TYPE%TYPE
            , W_SOB_ID            IN FI_DEPT_MASTER.SOB_ID%TYPE
            , W_ENABLED_YN        IN FI_DEPT_MASTER.ENABLED_FLAG%TYPE DEFAULT 'Y'
            , W_CONNECT_PERSON_ID IN NUMBER
            )
  AS
    N_DEPT_LEVEL                  FI_DEPT_MASTER.DEPT_LEVEL%TYPE := 1;
    V_STD_DATE                    FI_DEPT_MASTER.EFFECTIVE_DATE_FR%TYPE;
    
    V_BASE_YN                     VARCHAR2(2) := '-';  -- 편성예산.
    V_ADD_YN                      VARCHAR2(2) := '-';  -- 증액/감액 예산.
    V_MOVE_YN                     VARCHAR2(2) := '-';  -- 예산전용.
  BEGIN
    -- 예산구분에 따른 권한 설정.
    IF W_BUDGET_TYPE IN ('11') THEN
      V_BASE_YN := 'Y';  
    ELSIF W_BUDGET_TYPE IN ('21', '22') THEN
      V_ADD_YN := 'Y';
    ELSIF W_BUDGET_TYPE IN ('31') THEN
      V_MOVE_YN := 'Y';
    ELSIF W_BUDGET_TYPE IS NULL THEN
      V_BASE_YN := 'Y';  
      V_ADD_YN := 'Y';
      V_MOVE_YN := 'Y';
    END IF;
    
    -- 발의부서 레벨.
    BEGIN
      SELECT NVL(AB.DEPT_LEVEL, 1) AS DEPT_CONTROL_LEVEL
        INTO N_DEPT_LEVEL
        FROM FI_ACCOUNT_BOOK AB
       WHERE AB.SOB_ID                  = W_SOB_ID
         AND AB.OPERATING_FLAG          = 'Y'
         AND ROWNUM                     <= 1
      ;
    EXCEPTION WHEN OTHERS THEN
      N_DEPT_LEVEL := 1;
    END;

    -- 사용구분.
    IF W_ENABLED_YN = 'Y' THEN
      V_STD_DATE := TRUNC(GET_LOCAL_DATE(W_SOB_ID));
    ELSE
      V_STD_DATE := NULL;
    END IF;

    OPEN P_CURSOR FOR
      SELECT DM.DEPT_NAME
          , DM.DEPT_CODE
          , DM.DEPT_ID
      FROM FI_DEPT_MASTER DM
      WHERE DM.SOB_ID                = W_SOB_ID
        AND DM.DEPT_LEVEL            = N_DEPT_LEVEL
        AND DM.ENABLED_FLAG          = DECODE(W_ENABLED_YN, 'Y', 'Y', DM.ENABLED_FLAG)
        AND DM.EFFECTIVE_DATE_FR     <= NVL(V_STD_DATE, DM.EFFECTIVE_DATE_FR)
        AND (DM.EFFECTIVE_DATE_TO IS NULL OR DM.EFFECTIVE_DATE_TO >= NVL(V_STD_DATE, DM.EFFECTIVE_DATE_TO))
        AND EXISTS ( SELECT 'X'
                       FROM FI_BUDGET_CONTROL BC
                     WHERE BC.DEPT_ID   = DM.DEPT_ID
                       AND BC.SOB_ID    = DM.SOB_ID
                       AND (BC.BASE_YN  = V_BASE_YN
                         OR BC.ADD_YN   = V_ADD_YN
                         OR BC.MOVE_YN  = V_MOVE_YN
                           )
                       AND BC.PERSON_ID = W_CONNECT_PERSON_ID
                    )
      ;
  END LU_SELECT_BUDGET_DEPT;
  
END FI_DEPT_MASTER_G; 
/
