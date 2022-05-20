CREATE OR REPLACE PACKAGE HRD_PERSON_HISTORY_G
AS
-- 작업장 및 교대유형 조회
  PROCEDURE SELECT_PERSON_HISTORY
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_CORP_ID           IN HRD_PERSON_HISTORY.CORP_ID%TYPE
            , W_STD_DATE          IN HRD_PERSON_HISTORY.EFFECTIVE_DATE_FR%TYPE            
            , W_FLOOR_ID          IN HRD_PERSON_HISTORY.FLOOR_ID%TYPE
            , W_WORK_TYPE_ID      IN HRD_PERSON_HISTORY.WORK_TYPE_ID%TYPE
            , W_PERSON_ID         IN HRD_PERSON_HISTORY.PERSON_ID%TYPE
            , W_CONNECT_PERSON_ID IN HRD_PERSON_HISTORY.PERSON_ID%TYPE
            , W_SOB_ID            IN HRD_PERSON_HISTORY.SOB_ID%TYPE
            , W_ORG_ID            IN HRD_PERSON_HISTORY.ORG_ID%TYPE
            );

-- 작업장 및 교대유형 저장.
  PROCEDURE SAVE_PERSON_HISTORY
            ( P_STD_DATE          IN HRD_PERSON_HISTORY.EFFECTIVE_DATE_FR%TYPE
            , P_CORP_ID           IN HRD_PERSON_HISTORY.CORP_ID%TYPE
            , P_PERSON_ID         IN HRD_PERSON_HISTORY.PERSON_ID%TYPE
            , P_FLOOR_ID          IN HRD_PERSON_HISTORY.FLOOR_ID%TYPE
            , P_WORK_TYPE_ID      IN HRD_PERSON_HISTORY.WORK_TYPE_ID%TYPE
            , P_DESCRIPTION       IN HRD_PERSON_HISTORY.DESCRIPTION%TYPE
            , P_SOB_ID            IN HRD_PERSON_HISTORY.SOB_ID%TYPE
            , P_ORG_ID            IN HRD_PERSON_HISTORY.ORG_ID%TYPE
            , P_USER_ID           IN HRD_PERSON_HISTORY.CREATED_BY%TYPE
            );

-- 작업장 및 교대유형 신규INSERT.
  PROCEDURE INSERT_PERSON_HISTORY
            ( P_CORP_ID           IN HRD_PERSON_HISTORY.CORP_ID%TYPE
            , P_PERSON_ID         IN HRD_PERSON_HISTORY.PERSON_ID%TYPE
            , P_EFFECTIVE_DATE_FR IN HRD_PERSON_HISTORY.EFFECTIVE_DATE_FR%TYPE
            , P_FLOOR_ID          IN HRD_PERSON_HISTORY.FLOOR_ID%TYPE
            , P_WORK_TYPE_ID      IN HRD_PERSON_HISTORY.WORK_TYPE_ID%TYPE
            , P_DESCRIPTION       IN HRD_PERSON_HISTORY.DESCRIPTION%TYPE
            , P_SOB_ID            IN HRD_PERSON_HISTORY.SOB_ID%TYPE
            , P_ORG_ID            IN HRD_PERSON_HISTORY.ORG_ID%TYPE
            , P_USER_ID           IN HRD_PERSON_HISTORY.CREATED_BY%TYPE
            );
            
END HRD_PERSON_HISTORY_G;
/
CREATE OR REPLACE PACKAGE BODY HRD_PERSON_HISTORY_G
AS
/******************************************************************************/
/* PROJECT      : FPCB ERP
/* MODULE       : EAPP
/* PROGRAM NAME : HRD_PERSON_HISTORY_G
/* DESCRIPTION  : 근태 작업장 및 교대유형 관리.
/* REFERENCE BY :
/* PROGRAM HISTORY : 신규 생성
/*------------------------------------------------------------------------------
/*   DATE       IN CHARGE          DESCRIPTION
/*------------------------------------------------------------------------------
/* 20-JUN-2010  JEON HO SU          INITIALIZE
/******************************************************************************/
-- 작업장 및 교대유형 조회
  PROCEDURE SELECT_PERSON_HISTORY
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_CORP_ID           IN HRD_PERSON_HISTORY.CORP_ID%TYPE
            , W_STD_DATE          IN HRD_PERSON_HISTORY.EFFECTIVE_DATE_FR%TYPE            
            , W_FLOOR_ID          IN HRD_PERSON_HISTORY.FLOOR_ID%TYPE
            , W_WORK_TYPE_ID      IN HRD_PERSON_HISTORY.WORK_TYPE_ID%TYPE
            , W_PERSON_ID         IN HRD_PERSON_HISTORY.PERSON_ID%TYPE
            , W_CONNECT_PERSON_ID IN HRD_PERSON_HISTORY.PERSON_ID%TYPE
            , W_SOB_ID            IN HRD_PERSON_HISTORY.SOB_ID%TYPE
            , W_ORG_ID            IN HRD_PERSON_HISTORY.ORG_ID%TYPE
            )
  AS
	  V_CONNECT_PERSON_ID                               HRM_PERSON_MASTER.PERSON_ID%TYPE := NULL;
  BEGIN
	  -- 근태권한 설정.
		IF HRM_MANAGER_G.USER_CAP_F( W_CORP_ID => W_CORP_ID
		                           , W_START_DATE => W_STD_DATE
															 , W_END_DATE => W_STD_DATE
															 , W_MODULE_CODE => '20'
															 , W_PERSON_ID => W_CONNECT_PERSON_ID
															 , W_SOB_ID => W_SOB_ID
															 , W_ORG_ID => W_ORG_ID) = 'C' THEN
		  V_CONNECT_PERSON_ID := NULL;
		ELSE
		  V_CONNECT_PERSON_ID := W_CONNECT_PERSON_ID;
		END IF;
    OPEN P_CURSOR FOR
      SELECT PH.PERSON_ID
           , PM.PERSON_NUM
           , PM.NAME
           , HRM_COMMON_G.ID_NAME_F(PM.JOB_CLASS_ID) AS JOB_CLASS_DESC
           , HRM_COMMON_G.CODE_NAME_F('SEX_TYPE', PM.SEX_TYPE, PM.SOB_ID, PM.ORG_ID) AS SEX_TYPE_DESC
           , PM.JOIN_DATE
           , PM.RETIRE_DATE
           , HRM_COMMON_G.ID_NAME_F(PH.FLOOR_ID) AS FLOOR_DESC
           , PH.FLOOR_ID
           , HRM_COMMON_G.ID_NAME_F(PH.WORK_TYPE_ID) AS WORK_TYPE_DESC
           , PH.WORK_TYPE_ID
           , PH.DESCRIPTION
           , PH.EFFECTIVE_DATE_FR
           , PH.EFFECTIVE_DATE_TO
        FROM HRD_PERSON_HISTORY PH
          , HRM_PERSON_MASTER PM
      WHERE PH.PERSON_ID(+)                = PM.PERSON_ID
        AND PH.SOB_ID(+)                   = PM.SOB_ID
        AND PH.ORG_ID(+)                   = PM.ORG_ID
        AND PM.CORP_ID                     = W_CORP_ID
        AND PH.FLOOR_ID                    = NVL(W_FLOOR_ID, PH.FLOOR_ID)
        AND PH.WORK_TYPE_ID                = NVL(W_WORK_TYPE_ID, PH.WORK_TYPE_ID)
        AND PH.PERSON_ID                   = NVL(W_PERSON_ID, PH.PERSON_ID)
        AND PM.ORI_JOIN_DATE               <= W_STD_DATE
        AND (PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE >= W_STD_DATE)
        AND EXISTS (SELECT 'X'
                      FROM HRD_DUTY_MANAGER DM
                    WHERE DM.CORP_ID              = PH.CORP_ID
                      AND DM.DUTY_CONTROL_ID      = PH.FLOOR_ID
                      AND DM.WORK_TYPE_ID         = DECODE(DM.WORK_TYPE_ID, 0, DM.WORK_TYPE_ID, PH.WORK_TYPE_ID)
                      AND NVL(V_CONNECT_PERSON_ID, DM.MANAGER_ID1)  IN(DM.MANAGER_ID1, DM.MANAGER_ID2, DM.APPROVER_ID1, DM.APPROVER_ID2)
                      AND DM.SOB_ID               = PH.SOB_ID
                      AND DM.ORG_ID               = PH.ORG_ID
                    )
      ;
  END SELECT_PERSON_HISTORY;

-- 작업장 및 교대유형 저장.
  PROCEDURE SAVE_PERSON_HISTORY
            ( P_STD_DATE          IN HRD_PERSON_HISTORY.EFFECTIVE_DATE_FR%TYPE
            , P_CORP_ID           IN HRD_PERSON_HISTORY.CORP_ID%TYPE
            , P_PERSON_ID         IN HRD_PERSON_HISTORY.PERSON_ID%TYPE
            , P_FLOOR_ID          IN HRD_PERSON_HISTORY.FLOOR_ID%TYPE
            , P_WORK_TYPE_ID      IN HRD_PERSON_HISTORY.WORK_TYPE_ID%TYPE
            , P_DESCRIPTION       IN HRD_PERSON_HISTORY.DESCRIPTION%TYPE
            , P_SOB_ID            IN HRD_PERSON_HISTORY.SOB_ID%TYPE
            , P_ORG_ID            IN HRD_PERSON_HISTORY.ORG_ID%TYPE
            , P_USER_ID           IN HRD_PERSON_HISTORY.CREATED_BY%TYPE
            )
  AS
    V_RECORD_COUNT      NUMBER;
    V_SYSDATE           DATE := GET_LOCAL_DATE(P_SOB_ID);
    V_SAVE_MODE         VARCHAR2(20);
    V_EFFECTIVE_DATE_FR HRD_PERSON_HISTORY.EFFECTIVE_DATE_FR%TYPE := NULL;
    V_EFFECTIVE_DATE_TO HRD_PERSON_HISTORY.EFFECTIVE_DATE_TO%TYPE := NULL;
    V_LAST_YN           HRD_PERSON_HISTORY.LAST_YN%TYPE;
  BEGIN
    BEGIN
      SELECT PH.EFFECTIVE_DATE_FR, PH.EFFECTIVE_DATE_TO, PH.LAST_YN
        INTO V_EFFECTIVE_DATE_FR, V_EFFECTIVE_DATE_TO, V_LAST_YN
        FROM HRD_PERSON_HISTORY PH
      WHERE PH.CORP_ID            = P_CORP_ID
        AND PH.PERSON_ID          = P_PERSON_ID
        AND PH.EFFECTIVE_DATE_FR  <= P_STD_DATE
        AND PH.EFFECTIVE_DATE_TO  >= P_STD_DATE
        AND PH.SOB_ID             = P_SOB_ID
        AND PH.ORG_ID             = P_ORG_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_EFFECTIVE_DATE_FR := P_STD_DATE;
      V_EFFECTIVE_DATE_TO := TO_DATE('3000-12-31', 'YYYY-MM-DD');
      V_LAST_YN := 'Y';
      V_SAVE_MODE := 'NEW';
    END;
    -- 최종자료가 아니면 변경 불가 --
    IF V_LAST_YN <> 'Y' THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10293', NULL));
    END IF;    
    IF V_EFFECTIVE_DATE_FR = P_STD_DATE THEN
    -- 기존에 입력된 최종값하고 기준일하고 동일하면 수정.
      V_SAVE_MODE := 'UPDATE';
    ELSIF V_EFFECTIVE_DATE_FR < P_STD_DATE THEN
    -- 기존에 입력된 최종값보다 기준일이 크면 백업후 INSERT.
      V_SAVE_MODE := 'UPDATE/INSERT';
    END IF;
    IF V_SAVE_MODE = 'NEW' THEN
      INSERT_PERSON_HISTORY
        ( P_CORP_ID
        , P_PERSON_ID
        , V_EFFECTIVE_DATE_FR
        , P_FLOOR_ID
        , P_WORK_TYPE_ID
        , P_DESCRIPTION
        , P_SOB_ID
        , P_ORG_ID
        , P_USER_ID        
        );
    ELSIF V_SAVE_MODE = 'UPDATE' THEN
      UPDATE HRD_PERSON_HISTORY PH
        SET  PH.FLOOR_ID          = P_FLOOR_ID
           , PH.WORK_TYPE_ID      = P_WORK_TYPE_ID
           , PH.DESCRIPTION       = P_DESCRIPTION
           , PH.LAST_UPDATE_DATE  = V_SYSDATE
           , PH.LAST_UPDATED_BY   = P_USER_ID
      WHERE PH.CORP_ID              = P_CORP_ID
        AND PH.PERSON_ID            = P_PERSON_ID
        AND PH.EFFECTIVE_DATE_FR    = V_EFFECTIVE_DATE_FR
        AND PH.EFFECTIVE_DATE_TO    = V_EFFECTIVE_DATE_TO
        AND PH.SOB_ID               = P_SOB_ID
        AND PH.ORG_ID               = P_ORG_ID
      ;
    ELSIF V_SAVE_MODE = 'UPDATE/INSERT' THEN
      UPDATE HRD_PERSON_HISTORY PH
        SET  PH.EFFECTIVE_DATE_TO = P_STD_DATE - 1
      WHERE PH.CORP_ID              = P_CORP_ID
        AND PH.PERSON_ID            = P_PERSON_ID
        AND PH.EFFECTIVE_DATE_FR    = V_EFFECTIVE_DATE_FR
        AND PH.EFFECTIVE_DATE_TO    = V_EFFECTIVE_DATE_TO
        AND PH.SOB_ID               = P_SOB_ID
        AND PH.ORG_ID               = P_ORG_ID
      ;
      INSERT_PERSON_HISTORY
        ( P_CORP_ID
        , P_PERSON_ID
        , P_STD_DATE
        , P_FLOOR_ID
        , P_WORK_TYPE_ID
        , P_DESCRIPTION
        , P_SOB_ID
        , P_ORG_ID
        , P_USER_ID        
        );
    END IF;
    
  END SAVE_PERSON_HISTORY;

-- 작업장 및 교대유형 신규INSERT.
  PROCEDURE INSERT_PERSON_HISTORY
            ( P_CORP_ID           IN HRD_PERSON_HISTORY.CORP_ID%TYPE
            , P_PERSON_ID         IN HRD_PERSON_HISTORY.PERSON_ID%TYPE
            , P_EFFECTIVE_DATE_FR IN HRD_PERSON_HISTORY.EFFECTIVE_DATE_FR%TYPE
            , P_FLOOR_ID          IN HRD_PERSON_HISTORY.FLOOR_ID%TYPE
            , P_WORK_TYPE_ID      IN HRD_PERSON_HISTORY.WORK_TYPE_ID%TYPE
            , P_DESCRIPTION       IN HRD_PERSON_HISTORY.DESCRIPTION%TYPE
            , P_SOB_ID            IN HRD_PERSON_HISTORY.SOB_ID%TYPE
            , P_ORG_ID            IN HRD_PERSON_HISTORY.ORG_ID%TYPE
            , P_USER_ID           IN HRD_PERSON_HISTORY.CREATED_BY%TYPE
            )
  AS
    V_SYSDATE           DATE := GET_LOCAL_DATE(P_SOB_ID);
  BEGIN
    INSERT INTO HRD_PERSON_HISTORY 
    ( CORP_ID
    , PERSON_ID
    , EFFECTIVE_DATE_FR
    , EFFECTIVE_DATE_TO
    , SOB_ID
    , ORG_ID
    , FLOOR_ID
    , WORK_TYPE_ID
    , PRE_FLOOR_ID
    , PRE_WORK_TYPE_ID
    , LAST_YN
    , CREATION_DATE
    , CREATED_BY
    , LAST_UPDATE_DATE
    , LAST_UPDATED_BY
    ) VALUES
    ( P_CORP_ID
    , P_PERSON_ID
    , P_EFFECTIVE_DATE_FR
    , TO_DATE('3000-12-31', 'YYYY-MM-DD')
    , P_SOB_ID
    , P_ORG_ID
    , P_FLOOR_ID
    , P_WORK_TYPE_ID
    , P_FLOOR_ID
    , P_WORK_TYPE_ID
    , 'Y'
    , V_SYSDATE
    , P_USER_ID
    , V_SYSDATE
    , P_USER_ID
    );
  END INSERT_PERSON_HISTORY;
  
END HRD_PERSON_HISTORY_G;
/
