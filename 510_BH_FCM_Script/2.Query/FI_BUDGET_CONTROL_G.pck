CREATE OR REPLACE PACKAGE FI_BUDGET_CONTROL_G
AS

-- 예산사용자 조회.
  PROCEDURE SELECT_BUDGET_CONTROL
            ( P_CURSOR               OUT TYPES.TCURSOR
            , W_DEPT_ID              IN FI_BUDGET_CONTROL.DEPT_ID%TYPE
            , W_CAPACITY_LEVEL       IN FI_BUDGET_CONTROL.CAPACITY_LEVEL%TYPE
            , W_PERSON_ID            IN FI_BUDGET_CONTROL.PERSON_ID%TYPE
            , W_ENABLED_YN           IN VARCHAR2
            , W_SOB_ID               IN FI_BUDGET_CONTROL.SOB_ID%TYPE
            );

-- 예산사용자 삽입.
  PROCEDURE INSERT_BUDGET_CONTROL
            ( P_DEPT_ID           IN FI_BUDGET_CONTROL.DEPT_ID%TYPE
            , P_CAPACITY_LEVEL    IN FI_BUDGET_CONTROL.CAPACITY_LEVEL%TYPE
            , P_PERSON_ID         IN FI_BUDGET_CONTROL.PERSON_ID%TYPE
            , P_SOB_ID            IN FI_BUDGET_CONTROL.SOB_ID%TYPE
            , P_ORG_ID            IN FI_BUDGET_CONTROL.ORG_ID%TYPE
            , P_SLIP_YN           IN FI_BUDGET_CONTROL.SLIP_YN%TYPE
            , P_BASE_YN           IN FI_BUDGET_CONTROL.BASE_YN%TYPE
            , P_ADD_YN            IN FI_BUDGET_CONTROL.ADD_YN%TYPE
            , P_MOVE_YN           IN FI_BUDGET_CONTROL.MOVE_YN%TYPE
            , P_DESCRIPTION       IN FI_BUDGET_CONTROL.DESCRIPTION%TYPE
            , P_EFFECTIVE_DATE_FR IN FI_BUDGET_CONTROL.EFFECTIVE_DATE_FR%TYPE
            , P_EFFECTIVE_DATE_TO IN FI_BUDGET_CONTROL.EFFECTIVE_DATE_TO%TYPE
            , P_USER_ID           IN FI_BUDGET_CONTROL.CREATED_BY%TYPE 
            );

-- 예산사용자 수정.
  PROCEDURE UPDATE_BUDGET_CONTROL
            ( W_DEPT_ID           IN FI_BUDGET_CONTROL.DEPT_ID%TYPE
            , W_CAPACITY_LEVEL    IN FI_BUDGET_CONTROL.CAPACITY_LEVEL%TYPE
            , W_PERSON_ID         IN FI_BUDGET_CONTROL.PERSON_ID%TYPE
            , W_SOB_ID            IN FI_BUDGET_CONTROL.SOB_ID%TYPE
            , W_ORG_ID            IN FI_BUDGET_CONTROL.ORG_ID%TYPE
            , P_SLIP_YN           IN FI_BUDGET_CONTROL.SLIP_YN%TYPE
            , P_BASE_YN           IN FI_BUDGET_CONTROL.BASE_YN%TYPE
            , P_ADD_YN            IN FI_BUDGET_CONTROL.ADD_YN%TYPE
            , P_MOVE_YN           IN FI_BUDGET_CONTROL.MOVE_YN%TYPE
            , P_DESCRIPTION       IN FI_BUDGET_CONTROL.DESCRIPTION%TYPE
            , P_EFFECTIVE_DATE_FR IN FI_BUDGET_CONTROL.EFFECTIVE_DATE_FR%TYPE
            , P_EFFECTIVE_DATE_TO IN FI_BUDGET_CONTROL.EFFECTIVE_DATE_TO%TYPE
            , P_USER_ID           IN FI_BUDGET_CONTROL.CREATED_BY%TYPE 
            );

-- 예산관리자 권한 존재 체크.
  FUNCTION BUDGET_MANAGER_CAP_F
            ( P_CONNECT_PERSON_ID IN FI_BUDGET_CONTROL.PERSON_ID%TYPE
            , P_SOB_ID            IN FI_BUDGET_CONTROL.SOB_ID%TYPE            
            ) RETURN VARCHAR2;
            
END FI_BUDGET_CONTROL_G;
/
CREATE OR REPLACE PACKAGE BODY FI_BUDGET_CONTROL_G
AS
/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : FI_BUDGET_CONTROL_G
/* Description  : 예산 사용자 관리.
/*
/* Reference by :
/* Program History :
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
-- 예산사용자 조회.
  PROCEDURE SELECT_BUDGET_CONTROL
            ( P_CURSOR               OUT TYPES.TCURSOR
            , W_DEPT_ID              IN FI_BUDGET_CONTROL.DEPT_ID%TYPE
            , W_CAPACITY_LEVEL       IN FI_BUDGET_CONTROL.CAPACITY_LEVEL%TYPE
            , W_PERSON_ID            IN FI_BUDGET_CONTROL.PERSON_ID%TYPE
            , W_ENABLED_YN           IN VARCHAR2
            , W_SOB_ID               IN FI_BUDGET_CONTROL.SOB_ID%TYPE
            )
  AS
    V_STD_DATE                       DATE := NULL;    
  BEGIN
    IF W_ENABLED_YN = 'Y' THEN
      V_STD_DATE := TRUNC(GET_LOCAL_DATE(W_SOB_ID));
    END IF;    
    OPEN P_CURSOR FOR
      SELECT DM.DEPT_NAME
           , DM.DEPT_CODE
           , DM.DEPT_ID
           , FI_COMMON_G.CODE_NAME_F('APPROVE_STATUS', BC.CAPACITY_LEVEL, BC.SOB_ID) AS CAPACITY_NAME
           , BC.CAPACITY_LEVEL
           , PM.NAME
           , PM.PERSON_NUM
           , PM.PERSON_ID
           , BC.SLIP_YN
           , BC.BASE_YN
           , BC.ADD_YN
           , BC.MOVE_YN
           , BC.DESCRIPTION
           , BC.EFFECTIVE_DATE_FR
           , BC.EFFECTIVE_DATE_TO
        FROM FI_BUDGET_CONTROL BC
          , FI_DEPT_MASTER DM
          , HRM_PERSON_MASTER PM
      WHERE BC.DEPT_ID                  = DM.DEPT_ID
        AND BC.PERSON_ID                = PM.PERSON_ID
        AND BC.EFFECTIVE_DATE_FR        <= NVL(V_STD_DATE, BC.EFFECTIVE_DATE_FR)
        AND (BC.EFFECTIVE_DATE_TO IS NULL OR BC.EFFECTIVE_DATE_TO >= NVL(V_STD_DATE, BC.EFFECTIVE_DATE_TO))
        AND BC.DEPT_ID                  = NVL(W_DEPT_ID, BC.DEPT_ID)
        AND BC.CAPACITY_LEVEL           = NVL(W_CAPACITY_LEVEL, BC.CAPACITY_LEVEL)
        AND BC.PERSON_ID                = NVL(W_PERSON_ID, BC.PERSON_ID)
        AND BC.SOB_ID                   = W_SOB_ID
      ORDER BY DM.DEPT_CODE, PM.PERSON_NUM
      ;
  END SELECT_BUDGET_CONTROL;

-- 예산사용자 삽입.
  PROCEDURE INSERT_BUDGET_CONTROL
            ( P_DEPT_ID           IN FI_BUDGET_CONTROL.DEPT_ID%TYPE
            , P_CAPACITY_LEVEL    IN FI_BUDGET_CONTROL.CAPACITY_LEVEL%TYPE
            , P_PERSON_ID         IN FI_BUDGET_CONTROL.PERSON_ID%TYPE
            , P_SOB_ID            IN FI_BUDGET_CONTROL.SOB_ID%TYPE
            , P_ORG_ID            IN FI_BUDGET_CONTROL.ORG_ID%TYPE
            , P_SLIP_YN           IN FI_BUDGET_CONTROL.SLIP_YN%TYPE
            , P_BASE_YN           IN FI_BUDGET_CONTROL.BASE_YN%TYPE
            , P_ADD_YN            IN FI_BUDGET_CONTROL.ADD_YN%TYPE
            , P_MOVE_YN           IN FI_BUDGET_CONTROL.MOVE_YN%TYPE
            , P_DESCRIPTION       IN FI_BUDGET_CONTROL.DESCRIPTION%TYPE
            , P_EFFECTIVE_DATE_FR IN FI_BUDGET_CONTROL.EFFECTIVE_DATE_FR%TYPE
            , P_EFFECTIVE_DATE_TO IN FI_BUDGET_CONTROL.EFFECTIVE_DATE_TO%TYPE
            , P_USER_ID           IN FI_BUDGET_CONTROL.CREATED_BY%TYPE 
            )
  AS
    V_SYSDATE   DATE := GET_LOCAL_DATE(P_SOB_ID);
    V_RECORD_COUNT NUMBER := 0;
  BEGIN
    -- 동일한 부서/사원/권한 존재 체크.
    BEGIN
      SELECT COUNT(BC.DEPT_ID) AS RECORD_COUNT
        INTO V_RECORD_COUNT
        FROM FI_BUDGET_CONTROL BC
       WHERE BC.SOB_ID            = P_SOB_ID
         AND BC.DEPT_ID           = P_DEPT_ID
         AND BC.PERSON_ID         = P_PERSON_ID
         AND BC.CAPACITY_LEVEL    = P_CAPACITY_LEVEL
      ;
    EXCEPTION WHEN OTHERS THEN
      V_RECORD_COUNT := 0;
    END;
    IF V_RECORD_COUNT <> 0 THEN
      RAISE ERRNUMS.Exist_Data;
    END IF;

    INSERT INTO FI_BUDGET_CONTROL
    ( DEPT_ID
    , CAPACITY_LEVEL 
    , PERSON_ID 
    , SOB_ID 
    , ORG_ID 
    , SLIP_YN 
    , BASE_YN 
    , ADD_YN 
    , MOVE_YN 
    , DESCRIPTION 
    , EFFECTIVE_DATE_FR 
    , EFFECTIVE_DATE_TO 
    , CREATION_DATE 
    , CREATED_BY 
    , LAST_UPDATE_DATE 
    , LAST_UPDATED_BY )
    VALUES
    ( P_DEPT_ID
    , P_CAPACITY_LEVEL
    , P_PERSON_ID
    , P_SOB_ID
    , P_ORG_ID
    , P_SLIP_YN
    , P_BASE_YN
    , P_ADD_YN
    , P_MOVE_YN
    , P_DESCRIPTION
    , P_EFFECTIVE_DATE_FR
    , P_EFFECTIVE_DATE_TO
    , V_SYSDATE
    , P_USER_ID
    , V_SYSDATE
    , P_USER_ID );
  EXCEPTION
    WHEN ERRNUMS.Exist_Data THEN
    RAISE_APPLICATION_ERROR(ERRNUMS.Exist_Data_Code, ERRNUMS.Exist_Data_Desc);
  END INSERT_BUDGET_CONTROL;

-- 예산사용자 수정.
  PROCEDURE UPDATE_BUDGET_CONTROL
            ( W_DEPT_ID           IN FI_BUDGET_CONTROL.DEPT_ID%TYPE
            , W_CAPACITY_LEVEL    IN FI_BUDGET_CONTROL.CAPACITY_LEVEL%TYPE
            , W_PERSON_ID         IN FI_BUDGET_CONTROL.PERSON_ID%TYPE
            , W_SOB_ID            IN FI_BUDGET_CONTROL.SOB_ID%TYPE
            , W_ORG_ID            IN FI_BUDGET_CONTROL.ORG_ID%TYPE
            , P_SLIP_YN           IN FI_BUDGET_CONTROL.SLIP_YN%TYPE
            , P_BASE_YN           IN FI_BUDGET_CONTROL.BASE_YN%TYPE
            , P_ADD_YN            IN FI_BUDGET_CONTROL.ADD_YN%TYPE
            , P_MOVE_YN           IN FI_BUDGET_CONTROL.MOVE_YN%TYPE
            , P_DESCRIPTION       IN FI_BUDGET_CONTROL.DESCRIPTION%TYPE
            , P_EFFECTIVE_DATE_FR IN FI_BUDGET_CONTROL.EFFECTIVE_DATE_FR%TYPE
            , P_EFFECTIVE_DATE_TO IN FI_BUDGET_CONTROL.EFFECTIVE_DATE_TO%TYPE
            , P_USER_ID           IN FI_BUDGET_CONTROL.CREATED_BY%TYPE 
            )
  AS
    V_SYSDATE DATE := GET_LOCAL_DATE(W_SOB_ID);
  BEGIN
    UPDATE FI_BUDGET_CONTROL
      SET SLIP_YN           = P_SLIP_YN
        , BASE_YN           = P_BASE_YN
        , ADD_YN            = P_ADD_YN
        , MOVE_YN           = P_MOVE_YN
        , DESCRIPTION       = P_DESCRIPTION
        , EFFECTIVE_DATE_FR = P_EFFECTIVE_DATE_FR
        , EFFECTIVE_DATE_TO = P_EFFECTIVE_DATE_TO
        , LAST_UPDATE_DATE  = V_SYSDATE
        , LAST_UPDATED_BY   = P_USER_ID
    WHERE DEPT_ID           = W_DEPT_ID
      AND CAPACITY_LEVEL    = W_CAPACITY_LEVEL
      AND PERSON_ID         = W_PERSON_ID
      AND SOB_ID            = W_SOB_ID
      AND ORG_ID            = W_ORG_ID
    ;    
  END UPDATE_BUDGET_CONTROL;

-- 예산관리자 권한 존재 체크.
  FUNCTION BUDGET_MANAGER_CAP_F
            ( P_CONNECT_PERSON_ID IN FI_BUDGET_CONTROL.PERSON_ID%TYPE
            , P_SOB_ID            IN FI_BUDGET_CONTROL.SOB_ID%TYPE            
            ) RETURN VARCHAR2
  AS
    V_SYSDATE                     DATE := GET_LOCAL_DATE(P_SOB_ID);
    V_MANAGER_YN                  VARCHAR2(2) := 'N';
  BEGIN
    BEGIN
      SELECT DECODE(BM.PERSON_NUM, NULL, 'N', 'Y') AS MANAGER_YN
        INTO V_MANAGER_YN
        FROM FI_BUDGET_MANAGER_V BM
      WHERE BM.PERSON_ID          = P_CONNECT_PERSON_ID
        AND BM.SOB_ID             = P_SOB_ID
        AND BM.ENABLED_FLAG       = 'Y'
        AND BM.EFFECTIVE_DATE_FR  <= V_SYSDATE
        AND (BM.EFFECTIVE_DATE_TO IS NULL OR BM.EFFECTIVE_DATE_TO >= V_SYSDATE)
      ;
    EXCEPTION WHEN OTHERS THEN
      V_MANAGER_YN := 'N';
    END;
    RETURN V_MANAGER_YN;
  END BUDGET_MANAGER_CAP_F;
  
END FI_BUDGET_CONTROL_G;
/
