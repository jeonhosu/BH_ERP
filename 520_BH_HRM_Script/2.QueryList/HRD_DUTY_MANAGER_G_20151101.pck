CREATE OR REPLACE PACKAGE HRD_DUTY_MANAGER_G
AS

-- DATA_SELECT.
  PROCEDURE DATA_SELECT
           ( P_CURSOR                            OUT TYPES.TCURSOR
      , W_CORP_ID                           IN HRD_DUTY_MANAGER.CORP_ID%TYPE
      , W_STD_DATE                          IN HRD_DUTY_MANAGER.START_DATE%TYPE
      , W_DUTY_CONTROL_ID                   IN HRD_DUTY_MANAGER.DUTY_CONTROL_ID%TYPE
      , W_WORK_TYPE_ID                      IN HRD_DUTY_MANAGER.WORK_TYPE_ID%TYPE
      , W_MANAGER_ID                        IN HRD_DUTY_MANAGER.MANAGER_ID1%TYPE
      , W_APPROVER_ID                       IN HRD_DUTY_MANAGER.APPROVER_ID1%TYPE
      , W_SOB_ID                            IN HRD_DUTY_MANAGER.SOB_ID%TYPE
      , W_ORG_ID                            IN HRD_DUTY_MANAGER.ORG_ID%TYPE
      );

-- DATA_INSERT.
  PROCEDURE DATA_INSERT
           ( P_CORP_ID                           IN HRD_DUTY_MANAGER.CORP_ID%TYPE
      , P_DUTY_CONTROL_ID                   IN HRD_DUTY_MANAGER.DUTY_CONTROL_ID%TYPE
      , P_WORK_TYPE_ID                      IN HRD_DUTY_MANAGER.WORK_TYPE_ID%TYPE
      , P_MANAGER_ID1                       IN HRD_DUTY_MANAGER.MANAGER_ID1%TYPE
      , P_MANAGER_ID2                       IN HRD_DUTY_MANAGER.MANAGER_ID2%TYPE
      , P_APPROVER_ID1                      IN HRD_DUTY_MANAGER.APPROVER_ID1%TYPE
      , P_APPROVER_ID2                      IN HRD_DUTY_MANAGER.APPROVER_ID2%TYPE
      , P_OT_YN                             IN HRD_DUTY_MANAGER.OT_YN%TYPE
      , P_DUTY_YN                           IN HRD_DUTY_MANAGER.DUTY_YN%TYPE
      , P_INOUT_YN                          IN HRD_DUTY_MANAGER.INOUT_YN%TYPE
      , P_LUNCH_YN                          IN HRD_DUTY_MANAGER.LUNCH_YN%TYPE
      , P_DINNER_YN                         IN HRD_DUTY_MANAGER.DINNER_YN%TYPE
      , P_MIDNIGHT_YN                       IN HRD_DUTY_MANAGER.MIDNIGHT_YN%TYPE
      , P_USABLE                            IN HRD_DUTY_MANAGER.USABLE%TYPE
      , P_START_DATE                        IN HRD_DUTY_MANAGER.START_DATE%TYPE
      , P_END_DATE                          IN HRD_DUTY_MANAGER.END_DATE%TYPE
      , P_DESCRIPTION                       IN HRD_DUTY_MANAGER.DESCRIPTION%TYPE
      , P_SOB_ID                            IN HRD_DUTY_MANAGER.SOB_ID%TYPE
      , P_ORG_ID                            IN HRD_DUTY_MANAGER.ORG_ID%TYPE
      , P_USER_ID                           IN HRD_DUTY_MANAGER.CREATED_BY%TYPE
      , O_DUTY_MANAGER_ID                   OUT HRD_DUTY_MANAGER.DUTY_MANAGER_ID%TYPE
      );

-- DATA_UPDATE.
  PROCEDURE DATA_UPDATE                           
           ( W_DUTY_MANAGER_ID                   IN HRD_DUTY_MANAGER.DUTY_MANAGER_ID%TYPE
      , P_DUTY_CONTROL_ID                   IN HRD_DUTY_MANAGER.DUTY_CONTROL_ID%TYPE
      , P_WORK_TYPE_ID                      IN HRD_DUTY_MANAGER.WORK_TYPE_ID%TYPE
      , P_MANAGER_ID1                       IN HRD_DUTY_MANAGER.MANAGER_ID1%TYPE
      , P_MANAGER_ID2                       IN HRD_DUTY_MANAGER.MANAGER_ID2%TYPE
      , P_APPROVER_ID1                      IN HRD_DUTY_MANAGER.APPROVER_ID1%TYPE
      , P_APPROVER_ID2                      IN HRD_DUTY_MANAGER.APPROVER_ID2%TYPE
      , P_OT_YN                             IN HRD_DUTY_MANAGER.OT_YN%TYPE
      , P_DUTY_YN                           IN HRD_DUTY_MANAGER.DUTY_YN%TYPE
      , P_INOUT_YN                          IN HRD_DUTY_MANAGER.INOUT_YN%TYPE
      , P_LUNCH_YN                          IN HRD_DUTY_MANAGER.LUNCH_YN%TYPE
      , P_DINNER_YN                         IN HRD_DUTY_MANAGER.DINNER_YN%TYPE
      , P_MIDNIGHT_YN                       IN HRD_DUTY_MANAGER.MIDNIGHT_YN%TYPE
      , P_USABLE                            IN HRD_DUTY_MANAGER.USABLE%TYPE
      , P_START_DATE                        IN HRD_DUTY_MANAGER.START_DATE%TYPE
      , P_END_DATE                          IN HRD_DUTY_MANAGER.END_DATE%TYPE
      , P_DESCRIPTION                       IN HRD_DUTY_MANAGER.DESCRIPTION%TYPE
      , P_USER_ID                           IN HRD_DUTY_MANAGER.CREATED_BY%TYPE
      );

-- DATA_DELETE..
  PROCEDURE DATA_DELETE
           ( W_DUTY_MANAGER_ID                   IN HRD_DUTY_MANAGER.DUTY_MANAGER_ID%TYPE
      );


-- LOOKUP DEPT.
  PROCEDURE LU_SELECT
           ( P_CURSOR                            OUT TYPES.TCURSOR
      , W_CORP_ID                           IN HRD_DUTY_MANAGER.CORP_ID%TYPE
      , W_START_DATE                        IN HRD_DUTY_MANAGER.START_DATE%TYPE
      , W_END_DATE                          IN HRD_DUTY_MANAGER.END_DATE%TYPE
      , W_SOB_ID                            IN HRD_DUTY_MANAGER.SOB_ID%TYPE
      , W_ORG_ID                            IN HRD_DUTY_MANAGER.ORG_ID%TYPE
      , W_USABLE_CHECK_YN                   IN VARCHAR2 DEFAULT 'Y'
      , W_CAP_CHECK_YN                      IN VARCHAR2 DEFAULT 'Y'
      );
            
-- LOOKUP DUTY_CONTROL - 근태 CAPACITY 별 조회.
  PROCEDURE LU_SELECT_C
           ( P_CURSOR                            OUT TYPES.TCURSOR
      , W_CORP_ID                           IN HRD_DUTY_MANAGER.CORP_ID%TYPE
      , W_START_DATE                        IN HRD_DUTY_MANAGER.START_DATE%TYPE
      , W_END_DATE                          IN HRD_DUTY_MANAGER.END_DATE%TYPE
      , W_CONNECT_PERSON_ID                 IN HRD_DUTY_MANAGER.MANAGER_ID1%TYPE
      , W_SOB_ID                            IN HRD_DUTY_MANAGER.SOB_ID%TYPE
      , W_ORG_ID                            IN HRD_DUTY_MANAGER.ORG_ID%TYPE
      , W_USABLE_CHECK_YN                   IN VARCHAR2 DEFAULT 'Y'
      , W_CAP_CHECK_YN                      IN VARCHAR2 DEFAULT 'Y'
      );
      
-- LOOKUP DEPT - 근태 CAPACITY 별 조회.
  PROCEDURE LU_SELECT_C2
           ( P_CURSOR                            OUT TYPES.TCURSOR
      , W_CORP_ID                           IN HRD_DUTY_MANAGER.CORP_ID%TYPE
      , W_START_DATE                        IN HRD_DUTY_MANAGER.START_DATE%TYPE
      , W_END_DATE                          IN HRD_DUTY_MANAGER.END_DATE%TYPE
      , W_CONNECT_PERSON_ID                 IN HRD_DUTY_MANAGER.MANAGER_ID1%TYPE
      , W_SOB_ID                            IN HRD_DUTY_MANAGER.SOB_ID%TYPE
      , W_ORG_ID                            IN HRD_DUTY_MANAGER.ORG_ID%TYPE
      );
   
  
-- LOOKUP MANAGER.
  PROCEDURE LU_MANAGER
           ( P_CURSOR                            OUT TYPES.TCURSOR
      , W_CORP_ID                           IN HRD_DUTY_MANAGER.CORP_ID%TYPE
      , W_START_DATE                        IN HRD_DUTY_MANAGER.START_DATE%TYPE
      , W_END_DATE                          IN HRD_DUTY_MANAGER.END_DATE%TYPE
      , W_SOB_ID                            IN HRD_DUTY_MANAGER.SOB_ID%TYPE
      , W_ORG_ID                            IN HRD_DUTY_MANAGER.ORG_ID%TYPE
      , W_USABLE_CHECK_YN                   IN VARCHAR2 DEFAULT 'Y'
      , W_CAP_CHECK_YN                      IN VARCHAR2 DEFAULT 'Y'
      );
            
-- LOOKUP MANAGER - 근태 CAPACITY 별 조회.
  PROCEDURE LU_MANAGER_C
           ( P_CURSOR                            OUT TYPES.TCURSOR
      , W_CORP_ID                           IN HRD_DUTY_MANAGER.CORP_ID%TYPE
      , W_START_DATE                        IN HRD_DUTY_MANAGER.START_DATE%TYPE
      , W_END_DATE                          IN HRD_DUTY_MANAGER.END_DATE%TYPE
      , W_CONNECT_PERSON_ID                 IN HRD_DUTY_MANAGER.MANAGER_ID1%TYPE
      , W_SOB_ID                            IN HRD_DUTY_MANAGER.SOB_ID%TYPE
      , W_ORG_ID                            IN HRD_DUTY_MANAGER.ORG_ID%TYPE
      , W_USABLE_CHECK_YN                   IN VARCHAR2 DEFAULT 'Y'
      , W_CAP_CHECK_YN                      IN VARCHAR2 DEFAULT 'Y'
      );            
                  
-- 근태관리 명
  FUNCTION MANAGER_NAME_F
          ( W_DUTY_MANAGER_ID                    IN HRD_DUTY_MANAGER.DUTY_MANAGER_ID%TYPE
      ) RETURN VARCHAR2;
      
-- 근태관리 권한 체크.
  FUNCTION APPROVER_CAP_F
          ( W_DUTY_CONTROL_ID                    IN HRD_DUTY_MANAGER.DUTY_CONTROL_ID%TYPE
           , W_PERSON_ID                          IN HRD_DUTY_MANAGER.DUTY_MANAGER_ID%TYPE
           , W_SOB_ID                             IN HRD_DUTY_MANAGER.SOB_ID%TYPE
       , W_ORG_ID                             IN HRD_DUTY_MANAGER.ORG_ID%TYPE
      ) RETURN VARCHAR2;
      
END HRD_DUTY_MANAGER_G;


 
/
CREATE OR REPLACE PACKAGE BODY HRD_DUTY_MANAGER_G
AS
/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRD_DUTY_MANAGER_G
/* Description  : 근태 담당자 관리 패키지
/*
/* Reference by : 근태 담당자 관리.
/* Program History :
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
-- DATA_SELECT.
  PROCEDURE DATA_SELECT
           ( P_CURSOR                            OUT TYPES.TCURSOR
      , W_CORP_ID                           IN HRD_DUTY_MANAGER.CORP_ID%TYPE
      , W_STD_DATE                          IN HRD_DUTY_MANAGER.START_DATE%TYPE
      , W_DUTY_CONTROL_ID                   IN HRD_DUTY_MANAGER.DUTY_CONTROL_ID%TYPE
      , W_WORK_TYPE_ID                      IN HRD_DUTY_MANAGER.WORK_TYPE_ID%TYPE
      , W_MANAGER_ID                        IN HRD_DUTY_MANAGER.MANAGER_ID1%TYPE
      , W_APPROVER_ID                       IN HRD_DUTY_MANAGER.APPROVER_ID1%TYPE
      , W_SOB_ID                            IN HRD_DUTY_MANAGER.SOB_ID%TYPE
      , W_ORG_ID                            IN HRD_DUTY_MANAGER.ORG_ID%TYPE
      )
  AS
  BEGIN
   -- 부서별 관리 기준 작성.
    OPEN P_CURSOR FOR
   SELECT DM.DUTY_MANAGER_ID
     , DM.CORP_ID
    , DM.DUTY_CONTROL_ID
    , HRM_COMMON_G.ID_NAME_F(DM.DUTY_CONTROL_ID) DUTY_CONTROL_NAME
    , DM.WORK_TYPE_ID
    , HRM_COMMON_G.ID_NAME_F(DM.WORK_TYPE_ID) WORK_TYPE_NAME
    , DM.MANAGER_ID1
    , HRM_PERSON_MASTER_G.NAME_F(DM.MANAGER_ID1) MANAGER_NAME1
    , DM.MANAGER_ID2
    , HRM_PERSON_MASTER_G.NAME_F(DM.MANAGER_ID2) MANAGER_NAME2
    , DM.APPROVER_ID1
    , HRM_PERSON_MASTER_G.NAME_F(DM.APPROVER_ID1) APPROVER_NAME1
    , DM.APPROVER_ID2
    , HRM_PERSON_MASTER_G.NAME_F(DM.APPROVER_ID2) APPROVER_NAME2
    , DM.OT_YN
    , DM.DUTY_YN
    , DM.INOUT_YN
    , DM.LUNCH_YN
    , DM.DINNER_YN
    , DM.MIDNIGHT_YN
    , DM.USABLE
    , DM.START_DATE
    , DM.END_DATE
    , DM.DESCRIPTION
  FROM HRD_DUTY_MANAGER DM
  WHERE DM.CORP_ID                                  = W_CORP_ID
    AND DM.DUTY_CONTROL_ID                          = NVL(W_DUTY_CONTROL_ID, DM.DUTY_CONTROL_ID)
   AND ((W_WORK_TYPE_ID                             IS NULL AND 1 = 1)
     OR (W_WORK_TYPE_ID                             IS NOT NULL AND DM.WORK_TYPE_ID = W_WORK_TYPE_ID))
   AND (DM.MANAGER_ID1                             = NVL(W_MANAGER_ID, DM.MANAGER_ID1)
     OR DM.MANAGER_ID2                           = NVL(W_MANAGER_ID, DM.MANAGER_ID2))
   AND (DM.APPROVER_ID1                            = NVL(W_APPROVER_ID, DM.APPROVER_ID1)
     OR DM.APPROVER_ID1                          = NVL(W_APPROVER_ID, DM.APPROVER_ID2))
   AND DM.SOB_ID                                   = W_SOB_ID
   AND DM.ORG_ID                                   = W_ORG_ID
   AND DM.START_DATE                               <= W_STD_DATE
   AND (DM.END_DATE IS NULL OR DM.END_DATE         >= W_STD_DATE)
  --ORDER BY DM.DUTY_CONTROL_ID, DM.WORK_TYPE_ID, DM.START_DATE
  ORDER BY HRM_COMMON_G.ID_NAME_F(DM.DUTY_CONTROL_ID)
         , HRM_PERSON_MASTER_G.NAME_F(DM.MANAGER_ID1)
    ;
  
  END DATA_SELECT;

-- DATA_INSERT.
  PROCEDURE DATA_INSERT
           ( P_CORP_ID                           IN HRD_DUTY_MANAGER.CORP_ID%TYPE
      , P_DUTY_CONTROL_ID                   IN HRD_DUTY_MANAGER.DUTY_CONTROL_ID%TYPE
      , P_WORK_TYPE_ID                      IN HRD_DUTY_MANAGER.WORK_TYPE_ID%TYPE
      , P_MANAGER_ID1                       IN HRD_DUTY_MANAGER.MANAGER_ID1%TYPE
      , P_MANAGER_ID2                       IN HRD_DUTY_MANAGER.MANAGER_ID2%TYPE
      , P_APPROVER_ID1                      IN HRD_DUTY_MANAGER.APPROVER_ID1%TYPE
      , P_APPROVER_ID2                      IN HRD_DUTY_MANAGER.APPROVER_ID2%TYPE
      , P_OT_YN                             IN HRD_DUTY_MANAGER.OT_YN%TYPE
      , P_DUTY_YN                           IN HRD_DUTY_MANAGER.DUTY_YN%TYPE
      , P_INOUT_YN                          IN HRD_DUTY_MANAGER.INOUT_YN%TYPE
      , P_LUNCH_YN                          IN HRD_DUTY_MANAGER.LUNCH_YN%TYPE
      , P_DINNER_YN                         IN HRD_DUTY_MANAGER.DINNER_YN%TYPE
      , P_MIDNIGHT_YN                       IN HRD_DUTY_MANAGER.MIDNIGHT_YN%TYPE
      , P_USABLE                            IN HRD_DUTY_MANAGER.USABLE%TYPE
      , P_START_DATE                        IN HRD_DUTY_MANAGER.START_DATE%TYPE
      , P_END_DATE                          IN HRD_DUTY_MANAGER.END_DATE%TYPE
      , P_DESCRIPTION                       IN HRD_DUTY_MANAGER.DESCRIPTION%TYPE
      , P_SOB_ID                            IN HRD_DUTY_MANAGER.SOB_ID%TYPE
      , P_ORG_ID                            IN HRD_DUTY_MANAGER.ORG_ID%TYPE
      , P_USER_ID                           IN HRD_DUTY_MANAGER.CREATED_BY%TYPE
      , O_DUTY_MANAGER_ID                   OUT HRD_DUTY_MANAGER.DUTY_MANAGER_ID%TYPE
      )
  AS
   D_SYSDATE                                              DATE;
  N_DUTY_MANAGER_ID                                      NUMBER := 0;
  
  BEGIN
   D_SYSDATE := GET_LOCAL_DATE(P_SOB_ID);
  
  SELECT HRD_DUTY_MANAGER_S1.NEXTVAL
    INTO N_DUTY_MANAGER_ID
  FROM DUAL; 
  
  INSERT INTO HRD_DUTY_MANAGER
  (DUTY_MANAGER_ID
  , CORP_ID, DUTY_CONTROL_ID, WORK_TYPE_ID
  , MANAGER_ID1, MANAGER_ID2
  , APPROVER_ID1, APPROVER_ID2
  , OT_YN, DUTY_YN, INOUT_YN
  , LUNCH_YN, DINNER_YN, MIDNIGHT_YN
  , USABLE, START_DATE, END_DATE
  , DESCRIPTION
  , SOB_ID, ORG_ID
  , CREATION_DATE, CREATED_BY, LAST_UPDATE_DATE, LAST_UPDATED_BY
  ) VALUES
  (N_DUTY_MANAGER_ID
  , P_CORP_ID, P_DUTY_CONTROL_ID, 0/*NVL(P_WORK_TYPE_ID, 0)*/
  , P_MANAGER_ID1, P_MANAGER_ID2
  , P_APPROVER_ID1, P_APPROVER_ID2
  , P_OT_YN, P_DUTY_YN, P_INOUT_YN
  , P_LUNCH_YN, P_DINNER_YN, P_MIDNIGHT_YN
  , P_USABLE, TRUNC(P_START_DATE), TRUNC(P_END_DATE)
  , P_DESCRIPTION
  , P_SOB_ID, P_ORG_ID
  , D_SYSDATE, P_USER_ID, D_SYSDATE, P_USER_ID
  );
    O_DUTY_MANAGER_ID := N_DUTY_MANAGER_ID;
  
  END DATA_INSERT;

-- DATA_UPDATE.
  PROCEDURE DATA_UPDATE
           ( W_DUTY_MANAGER_ID                   IN HRD_DUTY_MANAGER.DUTY_MANAGER_ID%TYPE
      , P_DUTY_CONTROL_ID                   IN HRD_DUTY_MANAGER.DUTY_CONTROL_ID%TYPE
      , P_WORK_TYPE_ID                      IN HRD_DUTY_MANAGER.WORK_TYPE_ID%TYPE
      , P_MANAGER_ID1                       IN HRD_DUTY_MANAGER.MANAGER_ID1%TYPE
      , P_MANAGER_ID2                       IN HRD_DUTY_MANAGER.MANAGER_ID2%TYPE
      , P_APPROVER_ID1                      IN HRD_DUTY_MANAGER.APPROVER_ID1%TYPE
      , P_APPROVER_ID2                      IN HRD_DUTY_MANAGER.APPROVER_ID2%TYPE
      , P_OT_YN                             IN HRD_DUTY_MANAGER.OT_YN%TYPE
      , P_DUTY_YN                           IN HRD_DUTY_MANAGER.DUTY_YN%TYPE
      , P_INOUT_YN                          IN HRD_DUTY_MANAGER.INOUT_YN%TYPE
      , P_LUNCH_YN                          IN HRD_DUTY_MANAGER.LUNCH_YN%TYPE
      , P_DINNER_YN                         IN HRD_DUTY_MANAGER.DINNER_YN%TYPE
      , P_MIDNIGHT_YN                       IN HRD_DUTY_MANAGER.MIDNIGHT_YN%TYPE
      , P_USABLE                            IN HRD_DUTY_MANAGER.USABLE%TYPE
      , P_START_DATE                        IN HRD_DUTY_MANAGER.START_DATE%TYPE
      , P_END_DATE                          IN HRD_DUTY_MANAGER.END_DATE%TYPE
      , P_DESCRIPTION                       IN HRD_DUTY_MANAGER.DESCRIPTION%TYPE
      , P_USER_ID                           IN HRD_DUTY_MANAGER.CREATED_BY%TYPE
      )
  AS
  BEGIN
    UPDATE HRD_DUTY_MANAGER DM
   SET DM.DUTY_CONTROL_ID                        = P_DUTY_CONTROL_ID
     , DM.WORK_TYPE_ID                           = 0 --P_WORK_TYPE_ID
     , DM.MANAGER_ID1                            = P_MANAGER_ID1
     , DM.MANAGER_ID2                            = P_MANAGER_ID2
      , DM.APPROVER_ID1                           = P_APPROVER_ID1
    , DM.APPROVER_ID2                           = P_APPROVER_ID2
      , DM.OT_YN                                  = P_OT_YN
    , DM.DUTY_YN                                = P_DUTY_YN
    , DM.INOUT_YN                               = P_INOUT_YN
      , DM.LUNCH_YN                               = P_LUNCH_YN
    , DM.DINNER_YN                              = P_DINNER_YN
    , DM.MIDNIGHT_YN                            = P_MIDNIGHT_YN
    , DM.USABLE                                 = P_USABLE
      , DM.START_DATE                             = TRUNC(P_START_DATE)
    , DM.END_DATE                               = TRUNC(P_END_DATE)
      , DM.DESCRIPTION                            = P_DESCRIPTION
      , DM.LAST_UPDATE_DATE                       = GET_LOCAL_DATE(DM.SOB_ID)
    , LAST_UPDATED_BY                           = P_USER_ID
   WHERE DM.DUTY_MANAGER_ID                        = W_DUTY_MANAGER_ID
  ;

  END DATA_UPDATE;

-- DATA_DELETE..
  PROCEDURE DATA_DELETE
           ( W_DUTY_MANAGER_ID                   IN HRD_DUTY_MANAGER.DUTY_MANAGER_ID%TYPE
      )
  AS
  BEGIN
    DELETE HRD_DUTY_MANAGER DM
   WHERE DM.DUTY_MANAGER_ID                      = W_DUTY_MANAGER_ID
  ;

  END DATA_DELETE;


-- LOOKUP DEPT.
  PROCEDURE LU_SELECT
           ( P_CURSOR                            OUT TYPES.TCURSOR
      , W_CORP_ID                           IN HRD_DUTY_MANAGER.CORP_ID%TYPE
      , W_START_DATE                        IN HRD_DUTY_MANAGER.START_DATE%TYPE
      , W_END_DATE                          IN HRD_DUTY_MANAGER.END_DATE%TYPE
      , W_SOB_ID                            IN HRD_DUTY_MANAGER.SOB_ID%TYPE
      , W_ORG_ID                            IN HRD_DUTY_MANAGER.ORG_ID%TYPE
      , W_USABLE_CHECK_YN                   IN VARCHAR2 DEFAULT 'Y'
      , W_CAP_CHECK_YN                      IN VARCHAR2 DEFAULT 'Y'
      )
  AS
  V_START_DATE                                  HRD_DUTY_MANAGER.START_DATE%TYPE;
  V_END_DATE                                    HRD_DUTY_MANAGER.END_DATE%TYPE;
  
 BEGIN   
  -- 유효일자 체크 여부.
  IF W_USABLE_CHECK_YN = 'Y' THEN
    V_START_DATE := W_START_DATE;
   V_END_DATE := W_END_DATE;
  ELSE
   V_START_DATE := NULL;
   V_END_DATE := NULL;
  END IF;
 
   OPEN P_CURSOR FOR
   SELECT HRM_COMMON_G.ID_NAME_F(DM.DUTY_CONTROL_ID) || 
          DECODE(DM.WORK_TYPE_ID, 0, NULL, '.') ||
       HRM_COMMON_G.ID_NAME_F(DM.WORK_TYPE_ID) DUTY_MANAGER_NAME
        , DM.DUTY_MANAGER_ID
     , DM.CORP_ID
     , DM.DUTY_CONTROL_ID
     , DM.WORK_TYPE_ID
     , DM.OT_YN
     , DM.DUTY_YN
     , DM.INOUT_YN
     , DM.LUNCH_YN
     , DM.DINNER_YN
     , DM.MIDNIGHT_YN
   FROM HRD_DUTY_MANAGER DM
   WHERE DM.CORP_ID                              = W_CORP_ID
    AND DM.SOB_ID                               = W_SOB_ID
    AND DM.ORG_ID                               = W_ORG_ID
    AND DM.USABLE                               = DECODE(W_USABLE_CHECK_YN, 'Y', 'Y', DM.USABLE)
    AND DM.START_DATE                           <= NVL(V_END_DATE, DM.START_DATE)
    AND (DM.END_DATE IS NULL OR DM.END_DATE     >= NVL(V_START_DATE, DM.END_DATE))
   ORDER BY DM.DUTY_MANAGER_ID 
     ;
   
 END LU_SELECT;

-- LOOKUP DEPT - 근태 CAPACITY 별 조회.
  PROCEDURE LU_SELECT_C
           ( P_CURSOR                            OUT TYPES.TCURSOR
      , W_CORP_ID                           IN HRD_DUTY_MANAGER.CORP_ID%TYPE
      , W_START_DATE                        IN HRD_DUTY_MANAGER.START_DATE%TYPE
      , W_END_DATE                          IN HRD_DUTY_MANAGER.END_DATE%TYPE
      , W_CONNECT_PERSON_ID                 IN HRD_DUTY_MANAGER.MANAGER_ID1%TYPE
      , W_SOB_ID                            IN HRD_DUTY_MANAGER.SOB_ID%TYPE
      , W_ORG_ID                            IN HRD_DUTY_MANAGER.ORG_ID%TYPE
      , W_USABLE_CHECK_YN                   IN VARCHAR2 DEFAULT 'Y'
      , W_CAP_CHECK_YN                      IN VARCHAR2 DEFAULT 'Y'
      )
  AS
   V_CONNECT_PERSON_ID                           HRD_DUTY_MANAGER.MANAGER_ID1%TYPE;
  V_START_DATE                                  HRD_DUTY_MANAGER.START_DATE%TYPE;
  V_END_DATE                                    HRD_DUTY_MANAGER.END_DATE%TYPE;
  
 BEGIN
   -- 권한 체크 여부.
   IF W_CAP_CHECK_YN = 'Y' AND 
     HRM_MANAGER_G.USER_CAP_F( W_CORP_ID => W_CORP_ID 
                             , W_START_DATE => W_START_DATE
                , W_END_DATE => NVL(W_END_DATE, W_START_DATE)
                , W_MODULE_CODE => '20'
                , W_PERSON_ID => W_CONNECT_PERSON_ID
                , W_SOB_ID => W_SOB_ID
                , W_ORG_ID => W_ORG_ID) = 'C' THEN
      V_CONNECT_PERSON_ID := NULL;
  ELSE
    V_CONNECT_PERSON_ID := W_CONNECT_PERSON_ID;
  END IF;
  
  -- 유효일자 체크 여부.
  IF W_USABLE_CHECK_YN = 'Y' THEN
    V_START_DATE := W_START_DATE;
   V_END_DATE := W_END_DATE;
  ELSE
   V_START_DATE := NULL;
   V_END_DATE := NULL;
  END IF;
 
   OPEN P_CURSOR FOR
   SELECT HRM_COMMON_G.ID_NAME_F(DM.DUTY_CONTROL_ID) || 
          DECODE(DM.WORK_TYPE_ID, 0, NULL, '.') ||
       HRM_COMMON_G.ID_NAME_F(DM.WORK_TYPE_ID) DUTY_MANAGER_NAME
        , DM.DUTY_MANAGER_ID
     , DM.CORP_ID
     , DM.DUTY_CONTROL_ID
     , DM.WORK_TYPE_ID
     , DM.OT_YN
     , DM.DUTY_YN
     , DM.INOUT_YN
     , DM.LUNCH_YN
     , DM.DINNER_YN
     , DM.MIDNIGHT_YN
   FROM HRD_DUTY_MANAGER DM
   WHERE DM.CORP_ID                              = W_CORP_ID
    AND NVL(V_CONNECT_PERSON_ID, DM.MANAGER_ID1)  IN(DM.MANAGER_ID1, DM.MANAGER_ID2, DM.APPROVER_ID1, DM.APPROVER_ID2)
    AND DM.SOB_ID                               = W_SOB_ID
    AND DM.ORG_ID                               = W_ORG_ID
    AND DM.USABLE                               = DECODE(W_USABLE_CHECK_YN, 'Y', 'Y', DM.USABLE)
    AND DM.START_DATE                           <= NVL(V_END_DATE, DM.START_DATE)
    AND (DM.END_DATE IS NULL OR DM.END_DATE     >= NVL(V_START_DATE, DM.END_DATE))
   ORDER BY DM.DUTY_MANAGER_ID 
     ;
   
 END LU_SELECT_C;


-- LOOKUP DEPT - 근태 CAPACITY 별 조회.
  PROCEDURE LU_SELECT_C2
           ( P_CURSOR                            OUT TYPES.TCURSOR
      , W_CORP_ID                           IN HRD_DUTY_MANAGER.CORP_ID%TYPE
      , W_START_DATE                        IN HRD_DUTY_MANAGER.START_DATE%TYPE
      , W_END_DATE                          IN HRD_DUTY_MANAGER.END_DATE%TYPE
      , W_CONNECT_PERSON_ID                 IN HRD_DUTY_MANAGER.MANAGER_ID1%TYPE
      , W_SOB_ID                            IN HRD_DUTY_MANAGER.SOB_ID%TYPE
      , W_ORG_ID                            IN HRD_DUTY_MANAGER.ORG_ID%TYPE
      )
  AS
   V_CONNECT_PERSON_ID                           HRD_DUTY_MANAGER.MANAGER_ID1%TYPE;
  V_START_DATE                                  HRD_DUTY_MANAGER.START_DATE%TYPE;
  V_END_DATE                                    HRD_DUTY_MANAGER.END_DATE%TYPE;
  
 BEGIN
   -- 권한 체크 여부.
  IF HRM_MANAGER_G.USER_CAP_F( W_CORP_ID     => W_CORP_ID 
                             , W_START_DATE  => W_START_DATE
                             , W_END_DATE    => NVL(W_END_DATE, W_START_DATE)
                             , W_MODULE_CODE => '20'
                             , W_PERSON_ID   => W_CONNECT_PERSON_ID
                             , W_SOB_ID      => W_SOB_ID
                             , W_ORG_ID      => W_ORG_ID) = 'C' THEN
      V_CONNECT_PERSON_ID := NULL;
  ELSE
    V_CONNECT_PERSON_ID := W_CONNECT_PERSON_ID;
  END IF;
  
  -- 유효일자 체크 여부.
  IF V_CONNECT_PERSON_ID IS NOT NULL THEN
    V_START_DATE := W_START_DATE;
   V_END_DATE := W_END_DATE;
  ELSE
   V_START_DATE := NULL;
   V_END_DATE := NULL;
  END IF;
 
   OPEN P_CURSOR FOR
   SELECT HRM_COMMON_G.ID_NAME_F(DM.DUTY_CONTROL_ID) || 
          /*DECODE(DM.WORK_TYPE_ID, 0, NULL, '.') ||*/
       HRM_COMMON_G.ID_NAME_F(DM.WORK_TYPE_ID) DUTY_MANAGER_NAME
        , DM.DUTY_MANAGER_ID
     , DM.CORP_ID
     , DM.DUTY_CONTROL_ID
     , DM.WORK_TYPE_ID
     , DM.OT_YN
     , DM.DUTY_YN
     , DM.INOUT_YN
     , DM.LUNCH_YN
     , DM.DINNER_YN
     , DM.MIDNIGHT_YN
   FROM HRD_DUTY_MANAGER DM
   WHERE DM.CORP_ID                             = W_CORP_ID
    AND ((V_CONNECT_PERSON_ID                   IS NULL AND 1 = 1)
      OR (V_CONNECT_PERSON_ID                   IS NOT NULL AND V_CONNECT_PERSON_ID IN(DM.MANAGER_ID1, DM.MANAGER_ID2, DM.APPROVER_ID1, DM.APPROVER_ID2)))
    AND DM.SOB_ID                               = W_SOB_ID
    AND DM.ORG_ID                               = W_ORG_ID
    AND DM.USABLE                               = 'Y'
    AND DM.START_DATE                           <= NVL(V_END_DATE, DM.START_DATE)
    AND (DM.END_DATE IS NULL OR DM.END_DATE     >= NVL(V_START_DATE, DM.END_DATE))
   ORDER BY HRM_COMMON_G.ID_NAME_F(DM.DUTY_CONTROL_ID)
     ;
   
 END LU_SELECT_C2;



-- LOOKUP MANAGER - 근태 CAPACITY 별 조회.
  PROCEDURE LU_MANAGER
           ( P_CURSOR                            OUT TYPES.TCURSOR
      , W_CORP_ID                           IN HRD_DUTY_MANAGER.CORP_ID%TYPE
      , W_START_DATE                        IN HRD_DUTY_MANAGER.START_DATE%TYPE
      , W_END_DATE                          IN HRD_DUTY_MANAGER.END_DATE%TYPE
      , W_SOB_ID                            IN HRD_DUTY_MANAGER.SOB_ID%TYPE
      , W_ORG_ID                            IN HRD_DUTY_MANAGER.ORG_ID%TYPE
      , W_USABLE_CHECK_YN                   IN VARCHAR2 DEFAULT 'Y'
      , W_CAP_CHECK_YN                      IN VARCHAR2 DEFAULT 'Y'
      )
  AS
  V_START_DATE                                  HRD_DUTY_MANAGER.START_DATE%TYPE;
  V_END_DATE                                    HRD_DUTY_MANAGER.END_DATE%TYPE;
  
 BEGIN   
  -- 유효일자 체크 여부.
  IF W_USABLE_CHECK_YN = 'Y' THEN
    V_START_DATE := W_START_DATE;
   V_END_DATE := W_END_DATE;
  ELSE
   V_START_DATE := NULL;
   V_END_DATE := NULL;
  END IF;
 
   OPEN P_CURSOR FOR
   SELECT DISTINCT 
       HRM_PERSON_MASTER_G.NAME_F(DM.MANAGER_ID1) AS MANAGER1
      , HRM_PERSON_MASTER_G.NAME_F(DM.MANAGER_ID2) AS MANAGER2
      , HRM_PERSON_MASTER_G.NAME_F(DM.APPROVER_ID1) AS APPROVER1
      , HRM_PERSON_MASTER_G.NAME_F(DM.APPROVER_ID2) AS APPROVER2
      , DM.MANAGER_ID1 
   FROM HRD_DUTY_MANAGER DM
   WHERE DM.CORP_ID                              = W_CORP_ID
    AND DM.SOB_ID                               = W_SOB_ID
    AND DM.ORG_ID                               = W_ORG_ID
    AND DM.USABLE                               = DECODE(W_USABLE_CHECK_YN, 'Y', 'Y', DM.USABLE)
    AND DM.START_DATE                           <= NVL(V_END_DATE, DM.START_DATE)
    AND (DM.END_DATE IS NULL OR DM.END_DATE     >= NVL(V_START_DATE, DM.END_DATE))
   ORDER BY DM.MANAGER_ID1 
     ;
 
 END LU_MANAGER;
  
-- LOOKUP MANAGER - 근태 CAPACITY 별 조회.
  PROCEDURE LU_MANAGER_C
           ( P_CURSOR                            OUT TYPES.TCURSOR
      , W_CORP_ID                           IN HRD_DUTY_MANAGER.CORP_ID%TYPE
      , W_START_DATE                        IN HRD_DUTY_MANAGER.START_DATE%TYPE
      , W_END_DATE                          IN HRD_DUTY_MANAGER.END_DATE%TYPE
      , W_CONNECT_PERSON_ID                 IN HRD_DUTY_MANAGER.MANAGER_ID1%TYPE
      , W_SOB_ID                            IN HRD_DUTY_MANAGER.SOB_ID%TYPE
      , W_ORG_ID                            IN HRD_DUTY_MANAGER.ORG_ID%TYPE
      , W_USABLE_CHECK_YN                   IN VARCHAR2 DEFAULT 'Y'
      , W_CAP_CHECK_YN                      IN VARCHAR2 DEFAULT 'Y'
      )
  AS
   V_CONNECT_PERSON_ID                           HRD_DUTY_MANAGER.MANAGER_ID1%TYPE;
  V_START_DATE                                  HRD_DUTY_MANAGER.START_DATE%TYPE;
  V_END_DATE                                    HRD_DUTY_MANAGER.END_DATE%TYPE;
  
 BEGIN
   -- 권한 체크 여부.
   IF W_CAP_CHECK_YN = 'Y' AND 
     HRM_MANAGER_G.USER_CAP_F( W_CORP_ID => W_CORP_ID 
                             , W_START_DATE => W_START_DATE
                , W_END_DATE => W_END_DATE
                , W_MODULE_CODE => '20'
                , W_PERSON_ID => W_CONNECT_PERSON_ID
                , W_SOB_ID => W_SOB_ID
                , W_ORG_ID => W_ORG_ID) = 'C' THEN
      V_CONNECT_PERSON_ID := NULL;
  ELSE
    V_CONNECT_PERSON_ID := W_CONNECT_PERSON_ID;
  END IF;
  
  -- 유효일자 체크 여부.
  IF W_USABLE_CHECK_YN = 'Y' THEN
    V_START_DATE := W_START_DATE;
   V_END_DATE := W_END_DATE;
  ELSE
   V_START_DATE := NULL;
   V_END_DATE := NULL;
  END IF;
 
   OPEN P_CURSOR FOR
   SELECT DISTINCT 
       HRM_PERSON_MASTER_G.NAME_F(DM.MANAGER_ID1) AS MANAGER1
      , HRM_PERSON_MASTER_G.NAME_F(DM.MANAGER_ID2) AS MANAGER2
      , HRM_PERSON_MASTER_G.NAME_F(DM.APPROVER_ID1) AS APPROVER1
      , HRM_PERSON_MASTER_G.NAME_F(DM.APPROVER_ID2) AS APPROVER2
      , DM.MANAGER_ID1 
   FROM HRD_DUTY_MANAGER DM
   WHERE DM.CORP_ID                              = W_CORP_ID
    AND NVL(V_CONNECT_PERSON_ID, DM.MANAGER_ID1)  IN(DM.MANAGER_ID1)
    AND DM.SOB_ID                               = W_SOB_ID
    AND DM.ORG_ID                               = W_ORG_ID
    AND DM.USABLE                               = DECODE(W_USABLE_CHECK_YN, 'Y', 'Y', DM.USABLE)
    AND DM.START_DATE                           <= NVL(V_END_DATE, DM.START_DATE)
    AND (DM.END_DATE IS NULL OR DM.END_DATE     >= NVL(V_START_DATE, DM.END_DATE))
   ORDER BY DM.MANAGER_ID1 
     ;
 
 END LU_MANAGER_C;
  
-- 근태관리 명
  FUNCTION MANAGER_NAME_F
          ( W_DUTY_MANAGER_ID                     IN HRD_DUTY_MANAGER.DUTY_MANAGER_ID%TYPE
      ) RETURN VARCHAR2
  AS
   V_MANAGER_NAME                                VARCHAR2(200);
  V_DUTY_CONTROL_NAME                           VARCHAR2(100);
  V_WORK_TYPE_NAME                              VARCHAR2(100);
  
 BEGIN
   BEGIN
    SELECT HRM_COMMON_G.ID_NAME_F(DM.DUTY_CONTROL_ID) DUTY_CONTROL_NAME
      , HRM_COMMON_G.ID_NAME_F(DM.WORK_TYPE_ID) WORK_TYPE_NAME
    INTO V_DUTY_CONTROL_NAME, V_WORK_TYPE_NAME
    FROM HRD_DUTY_MANAGER DM
   WHERE DM.DUTY_MANAGER_ID                       = W_DUTY_MANAGER_ID
   ;
  EXCEPTION WHEN OTHERS THEN
   V_DUTY_CONTROL_NAME := NULL;
    V_WORK_TYPE_NAME := NULL;
  END; 
  
  IF V_WORK_TYPE_NAME IS NULL THEN
    V_MANAGER_NAME := V_DUTY_CONTROL_NAME;
  ELSE
    V_MANAGER_NAME := V_DUTY_CONTROL_NAME || '.' || V_WORK_TYPE_NAME;
  END IF;
  RETURN V_MANAGER_NAME;
    
 END MANAGER_NAME_F;      

-- 근태관리 권한 체크.
  FUNCTION APPROVER_CAP_F
          ( W_DUTY_CONTROL_ID                    IN HRD_DUTY_MANAGER.DUTY_CONTROL_ID%TYPE
           , W_PERSON_ID                          IN HRD_DUTY_MANAGER.DUTY_MANAGER_ID%TYPE
           , W_SOB_ID                             IN HRD_DUTY_MANAGER.SOB_ID%TYPE
       , W_ORG_ID                             IN HRD_DUTY_MANAGER.ORG_ID%TYPE
      ) RETURN VARCHAR2
  AS
    V_CAP_YN        VARCHAR2(1) := 'N';
  BEGIN
    BEGIN
      SELECT DECODE(COUNT(DM.APPROVER_ID1), 0, 'N', 'Y') AS APPROVER_YN
        INTO V_CAP_YN
        FROM HRD_DUTY_MANAGER DM
      WHERE DM.DUTY_CONTROL_ID    = W_DUTY_CONTROL_ID
        AND W_PERSON_ID           IN (DM.APPROVER_ID1, DM.APPROVER_ID2)
        AND DM.SOB_ID             = W_SOB_ID
        AND DM.ORG_ID             = W_ORG_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_CAP_YN := 'N';
    END;
    RETURN V_CAP_YN;
    
  END APPROVER_CAP_F;
    
END HRD_DUTY_MANAGER_G;
/
