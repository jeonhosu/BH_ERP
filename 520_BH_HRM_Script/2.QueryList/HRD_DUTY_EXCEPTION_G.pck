CREATE OR REPLACE PACKAGE "HRD_DUTY_EXCEPTION_G"
AS
    
  PROCEDURE SELECT_DUTY_EXCEPTION
            ( P_CURSOR                            OUT TYPES.TCURSOR
            , W_CORP_ID                           IN HRD_DUTY_EXCEPTION.CORP_ID%TYPE
            , W_STD_DATE                          IN DATE
            , W_FLOOR_ID                          IN HRM_FLOOR_V.FLOOR_ID%TYPE
            , W_POST_ID                           IN HRM_POST_CODE_V.POST_ID%TYPE
            , W_PERSON_ID                         IN HRM_PERSON_MASTER.PERSON_ID%TYPE         
            , W_ENABLED_FLAG                      IN HRD_DUTY_EXCEPTION.ENABLED_FLAG%TYPE
            , W_SOB_ID                            IN HRD_DUTY_EXCEPTION.SOB_ID%TYPE
            , W_ORG_ID                            IN HRD_DUTY_EXCEPTION.ORG_ID%TYPE
            );
            
            
  PROCEDURE INSERT_DUTY_EXCEPTION
            ( P_PERSON_ID         IN HRD_DUTY_EXCEPTION.PERSON_ID%TYPE
            , P_SOB_ID            IN HRD_DUTY_EXCEPTION.SOB_ID%TYPE
            , P_ORG_ID            IN HRD_DUTY_EXCEPTION.ORG_ID%TYPE
            , P_AUTO_WORKTIME_YN  IN HRD_DUTY_EXCEPTION.AUTO_WORKTIME_YN%TYPE
            , P_OT_APPLY_YN       IN HRD_DUTY_EXCEPTION.OT_APPLY_YN%TYPE
            , P_OT_EXCEPT_YN      IN HRD_DUTY_EXCEPTION.OT_EXCEPT_YN%TYPE
            , P_ADJUST_TIME_YN    IN HRD_DUTY_EXCEPTION.ADJUST_TIME_YN%TYPE
            , P_IN_TIME           IN HRD_DUTY_EXCEPTION.IN_TIME%TYPE
            , P_OUT_TIME          IN HRD_DUTY_EXCEPTION.OUT_TIME%TYPE
            , P_DESCRIPTION       IN HRD_DUTY_EXCEPTION.DESCRIPTION%TYPE
            , P_ENABLED_FLAG      IN HRD_DUTY_EXCEPTION.ENABLED_FLAG%TYPE
            , P_EFFECTIVE_DATE_FR IN HRD_DUTY_EXCEPTION.EFFECTIVE_DATE_FR%TYPE
            , P_EFFECTIVE_DATE_TO IN HRD_DUTY_EXCEPTION.EFFECTIVE_DATE_TO%TYPE
            , P_USER_ID           IN HRD_DUTY_EXCEPTION.CREATED_BY%TYPE 
            );
                                        
    
  PROCEDURE UPDATE_DUTY_EXCEPTION
            ( W_PERSON_ID         IN HRD_DUTY_EXCEPTION.PERSON_ID%TYPE
            , P_SOB_ID            IN HRD_DUTY_EXCEPTION.SOB_ID%TYPE
            , P_ORG_ID            IN HRD_DUTY_EXCEPTION.ORG_ID%TYPE
            , P_AUTO_WORKTIME_YN  IN HRD_DUTY_EXCEPTION.AUTO_WORKTIME_YN%TYPE
            , P_OT_APPLY_YN       IN HRD_DUTY_EXCEPTION.OT_APPLY_YN%TYPE
            , P_OT_EXCEPT_YN      IN HRD_DUTY_EXCEPTION.OT_EXCEPT_YN%TYPE
            , P_ADJUST_TIME_YN    IN HRD_DUTY_EXCEPTION.ADJUST_TIME_YN%TYPE
            , P_IN_TIME           IN HRD_DUTY_EXCEPTION.IN_TIME%TYPE
            , P_OUT_TIME          IN HRD_DUTY_EXCEPTION.OUT_TIME%TYPE
            , P_DESCRIPTION       IN HRD_DUTY_EXCEPTION.DESCRIPTION%TYPE
            , P_ENABLED_FLAG      IN HRD_DUTY_EXCEPTION.ENABLED_FLAG%TYPE
            , P_EFFECTIVE_DATE_FR IN HRD_DUTY_EXCEPTION.EFFECTIVE_DATE_FR%TYPE
            , P_EFFECTIVE_DATE_TO IN HRD_DUTY_EXCEPTION.EFFECTIVE_DATE_TO%TYPE
            , P_USER_ID           IN HRD_DUTY_EXCEPTION.CREATED_BY%TYPE 
            );
                                          
END HRD_DUTY_EXCEPTION_G;

 
/
CREATE OR REPLACE PACKAGE BODY "HRD_DUTY_EXCEPTION_G"
AS
/******************************************************************************/
/* PROJECT      : FPCB ERP
/* MODULE       : HRD
/* PROGRAM NAME : HRD_DUTY_EXCEPTION_G
/* DESCRIPTION  : 근태 예외 처리자 관리 패키지.

/* REFERENCE BY : 근태 예외 처리자 관리.
/* PROGRAM HISTORY : 
/*------------------------------------------------------------------------------
/*     DATE         IN CHARGE        DESCRIPTION
/*------------------------------------------------------------------------------
/* 2011-08-17      LEE SUN HEE       INITIALIZE
/******************************************************************************/

-------------------------------------------------------------------------------------------------------------
---- SELECT_DUTY_EXCEPTION
-------------------------------------------------------------------------------------------------------------
  PROCEDURE SELECT_DUTY_EXCEPTION
            ( P_CURSOR                            OUT TYPES.TCURSOR
            , W_CORP_ID                           IN HRD_DUTY_EXCEPTION.CORP_ID%TYPE
            , W_STD_DATE                          IN DATE
            , W_FLOOR_ID                          IN HRM_FLOOR_V.FLOOR_ID%TYPE
            , W_POST_ID                           IN HRM_POST_CODE_V.POST_ID%TYPE
            , W_PERSON_ID                         IN HRM_PERSON_MASTER.PERSON_ID%TYPE         
            , W_ENABLED_FLAG                      IN HRD_DUTY_EXCEPTION.ENABLED_FLAG%TYPE
            , W_SOB_ID                            IN HRD_DUTY_EXCEPTION.SOB_ID%TYPE
            , W_ORG_ID                            IN HRD_DUTY_EXCEPTION.ORG_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR   FOR
      SELECT PM.PERSON_ID   -- 사원ID.
            , PM.NAME        -- 사원명.
            , PM.PERSON_NUM  -- 사원번호.
            , HRM_COMMON_G.ID_NAME_F(PM.FLOOR_ID) AS FLOOR_NAME -- 작업장명.
            , PC.POST_NAME AS POST_NAME   -- 직위명.
            , DE.AUTO_WORKTIME_YN  -- 자동 근태 시간 여부.
            , DE.OT_APPLY_YN
            , DE.OT_EXCEPT_YN
            , DE.ADJUST_TIME_YN
            , DE.IN_TIME
            , DE.OUT_TIME
            , DE.ENABLED_FLAG      -- 사용.
            , DE.EFFECTIVE_DATE_FR -- 적용 시작일.
            , DE.EFFECTIVE_DATE_TO -- 적용 종료일.
            , DE.DESCRIPTION       -- 비고.
            , PM.JOIN_DATE         -- 입사일.
            , PM.RETIRE_DATE       -- 퇴사일.
        FROM HRD_DUTY_EXCEPTION DE
            , HRM_PERSON_MASTER PM
            , HRM_POST_CODE_V PC
       WHERE DE.PERSON_ID     = PM.PERSON_ID
         AND PM.POST_ID       = PC.POST_ID
         AND DE.CORP_ID       = W_CORP_ID
         AND DE.SOB_ID        = W_SOB_ID
         AND DE.ORG_ID        = W_ORG_ID
         AND PM.PERSON_ID     = NVL(W_PERSON_ID, PM.PERSON_ID)
         AND PM.JOIN_DATE    <= W_STD_DATE
         AND (PM.RETIRE_DATE  IS NULL OR PM.RETIRE_DATE  >= W_STD_DATE)
         AND ((W_FLOOR_ID     IS NULL
           AND 1              = 1)
         OR  (W_FLOOR_ID      IS NOT NULL
           AND PM.FLOOR_ID    = W_FLOOR_ID))
         AND PM.POST_ID       = NVL(W_POST_ID, PM.POST_ID)
         AND DE.ENABLED_FLAG  = DECODE(W_ENABLED_FLAG, 'Y', 'Y', DE.ENABLED_FLAG)
      ORDER BY PM.DEPT_ID, PC.SORT_NUM, PC.POST_CODE;
  
  END SELECT_DUTY_EXCEPTION;
  
-------------------------------------------------------------------------------------------------------------
---- INSERT_DUTY_EXCEPTION
-------------------------------------------------------------------------------------------------------------
  PROCEDURE INSERT_DUTY_EXCEPTION
            ( P_PERSON_ID         IN HRD_DUTY_EXCEPTION.PERSON_ID%TYPE
            , P_SOB_ID            IN HRD_DUTY_EXCEPTION.SOB_ID%TYPE
            , P_ORG_ID            IN HRD_DUTY_EXCEPTION.ORG_ID%TYPE
            , P_AUTO_WORKTIME_YN  IN HRD_DUTY_EXCEPTION.AUTO_WORKTIME_YN%TYPE
            , P_OT_APPLY_YN       IN HRD_DUTY_EXCEPTION.OT_APPLY_YN%TYPE
            , P_OT_EXCEPT_YN      IN HRD_DUTY_EXCEPTION.OT_EXCEPT_YN%TYPE
            , P_ADJUST_TIME_YN    IN HRD_DUTY_EXCEPTION.ADJUST_TIME_YN%TYPE
            , P_IN_TIME           IN HRD_DUTY_EXCEPTION.IN_TIME%TYPE
            , P_OUT_TIME          IN HRD_DUTY_EXCEPTION.OUT_TIME%TYPE
            , P_DESCRIPTION       IN HRD_DUTY_EXCEPTION.DESCRIPTION%TYPE
            , P_ENABLED_FLAG      IN HRD_DUTY_EXCEPTION.ENABLED_FLAG%TYPE
            , P_EFFECTIVE_DATE_FR IN HRD_DUTY_EXCEPTION.EFFECTIVE_DATE_FR%TYPE
            , P_EFFECTIVE_DATE_TO IN HRD_DUTY_EXCEPTION.EFFECTIVE_DATE_TO%TYPE
            , P_USER_ID           IN HRD_DUTY_EXCEPTION.CREATED_BY%TYPE 
            )
  IS
    V_SYSDATE DATE := GET_LOCAL_DATE(P_SOB_ID);
    V_CORP_ID           HRD_DUTY_EXCEPTION.CORP_ID%TYPE;
  BEGIN
    BEGIN
      SELECT PM.CORP_ID
        INTO V_CORP_ID
        FROM HRM_PERSON_MASTER PM 
      WHERE PM.PERSON_ID      = P_PERSON_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20001, 'Don''t found [Corporation], Check Person Infomation');
      RETURN;
    END;
    INSERT INTO HRD_DUTY_EXCEPTION
    ( CORP_ID
    , PERSON_ID 
    , SOB_ID 
    , ORG_ID 
    , AUTO_WORKTIME_YN 
    , OT_APPLY_YN
    , OT_EXCEPT_YN
    , ADJUST_TIME_YN
    , IN_TIME
    , OUT_TIME
    , DESCRIPTION 
    , ENABLED_FLAG 
    , EFFECTIVE_DATE_FR 
    , EFFECTIVE_DATE_TO 
    , CREATION_DATE 
    , CREATED_BY 
    , LAST_UPDATE_DATE 
    , LAST_UPDATED_BY )
    VALUES
    ( V_CORP_ID
    , P_PERSON_ID
    , P_SOB_ID
    , P_ORG_ID
    , NVL(P_AUTO_WORKTIME_YN, 'N')
    , NVL(P_OT_APPLY_YN, 'N')
    , NVL(P_OT_EXCEPT_YN, 'N')
    , NVL(P_ADJUST_TIME_YN, 'N')
    , NVL(P_IN_TIME, 0)
    , NVL(P_OUT_TIME, 0)
    , P_DESCRIPTION
    , NVL(P_ENABLED_FLAG, 'N')
    , TRUNC(P_EFFECTIVE_DATE_FR)
    , TRUNC(P_EFFECTIVE_DATE_TO)
    , V_SYSDATE
    , P_USER_ID
    , V_SYSDATE
    , P_USER_ID );     

  END INSERT_DUTY_EXCEPTION;

-------------------------------------------------------------------------------------------------------------
---- UPDATE_DUTY_EXCEPTION
-------------------------------------------------------------------------------------------------------------

  PROCEDURE UPDATE_DUTY_EXCEPTION
            ( W_PERSON_ID         IN HRD_DUTY_EXCEPTION.PERSON_ID%TYPE
            , P_SOB_ID            IN HRD_DUTY_EXCEPTION.SOB_ID%TYPE
            , P_ORG_ID            IN HRD_DUTY_EXCEPTION.ORG_ID%TYPE
            , P_AUTO_WORKTIME_YN  IN HRD_DUTY_EXCEPTION.AUTO_WORKTIME_YN%TYPE
            , P_OT_APPLY_YN       IN HRD_DUTY_EXCEPTION.OT_APPLY_YN%TYPE
            , P_OT_EXCEPT_YN      IN HRD_DUTY_EXCEPTION.OT_EXCEPT_YN%TYPE
            , P_ADJUST_TIME_YN    IN HRD_DUTY_EXCEPTION.ADJUST_TIME_YN%TYPE
            , P_IN_TIME           IN HRD_DUTY_EXCEPTION.IN_TIME%TYPE
            , P_OUT_TIME          IN HRD_DUTY_EXCEPTION.OUT_TIME%TYPE
            , P_DESCRIPTION       IN HRD_DUTY_EXCEPTION.DESCRIPTION%TYPE
            , P_ENABLED_FLAG      IN HRD_DUTY_EXCEPTION.ENABLED_FLAG%TYPE
            , P_EFFECTIVE_DATE_FR IN HRD_DUTY_EXCEPTION.EFFECTIVE_DATE_FR%TYPE
            , P_EFFECTIVE_DATE_TO IN HRD_DUTY_EXCEPTION.EFFECTIVE_DATE_TO%TYPE
            , P_USER_ID           IN HRD_DUTY_EXCEPTION.CREATED_BY%TYPE 
            )
  IS
    V_SYSDATE DATE := GET_LOCAL_DATE(P_SOB_ID);
  BEGIN
    UPDATE HRD_DUTY_EXCEPTION
      SET AUTO_WORKTIME_YN  = NVL(P_AUTO_WORKTIME_YN, 'N')
        , OT_APPLY_YN       = NVL(P_OT_APPLY_YN, 'N')
        , OT_EXCEPT_YN      = NVL(P_OT_EXCEPT_YN, 'N')
        , ADJUST_TIME_YN    = NVL(P_ADJUST_TIME_YN, 'N')
        , IN_TIME           = NVL(P_IN_TIME, 0)
        , OUT_TIME          = NVL(P_OUT_TIME, 0)
        , DESCRIPTION       = P_DESCRIPTION
        , ENABLED_FLAG      = NVL(P_ENABLED_FLAG, 'N')
        , EFFECTIVE_DATE_FR = TRUNC(P_EFFECTIVE_DATE_FR)
        , EFFECTIVE_DATE_TO = TRUNC(P_EFFECTIVE_DATE_TO)
        , LAST_UPDATE_DATE  = V_SYSDATE
        , LAST_UPDATED_BY   = P_USER_ID
    WHERE PERSON_ID         = W_PERSON_ID
    ;
  END UPDATE_DUTY_EXCEPTION;
  
END HRD_DUTY_EXCEPTION_G;
/
