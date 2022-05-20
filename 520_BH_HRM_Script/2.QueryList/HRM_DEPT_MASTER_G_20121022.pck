CREATE OR REPLACE PACKAGE HRM_DEPT_MASTER_G
AS
-- 부서마스터 조회.
  PROCEDURE DATA_SELECT
	          ( P_CURSOR             OUT TYPES.TCURSOR
						, W_CORP_ID            IN HRM_DEPT_MASTER.CORP_ID%TYPE
						, W_DEPT_ID            IN HRM_DEPT_MASTER.DEPT_ID%TYPE
						, W_SOB_ID             IN HRM_DEPT_MASTER.SOB_ID%TYPE
						, W_ORG_ID             IN HRM_DEPT_MASTER.ORG_ID%TYPE
						);

-- DEPARTMENT INSERT.
  PROCEDURE DATA_INSERT
           ( P_DEPT_ID            OUT HRM_DEPT_MASTER.DEPT_ID%TYPE
            , P_CORP_ID            IN HRM_DEPT_MASTER.CORP_ID%TYPE
      , P_DEPT_CODE          IN HRM_DEPT_MASTER.DEPT_CODE%TYPE
      , P_DEPT_NAME          IN HRM_DEPT_MASTER.DEPT_NAME%TYPE
      , P_DEPT_NAME_S        IN HRM_DEPT_MASTER.DEPT_NAME_S%TYPE
      , P_DEPT_LEVEL         IN HRM_DEPT_MASTER.DEPT_LEVEL%TYPE
      , P_UPPER_DEPT_ID      IN HRM_DEPT_MASTER.UPPER_DEPT_ID%TYPE
      , P_DEPT_SORT_NUM      IN HRM_DEPT_MASTER.DEPT_SORT_NUM%TYPE
      , P_T_O                IN HRM_DEPT_MASTER.T_O%TYPE
      , P_DEPT_GROUP         IN HRM_DEPT_MASTER.DEPT_GROUP%TYPE
      , P_VALUER_1           IN HRM_DEPT_MASTER.VALUER_1%TYPE
      , P_VALUER_2           IN HRM_DEPT_MASTER.VALUER_2%TYPE
      , P_DESCRIPTION        IN HRM_DEPT_MASTER.DESCRIPTION%TYPE
      , P_USABLE             IN HRM_DEPT_MASTER.USABLE%TYPE
      , P_START_DATE         IN HRM_DEPT_MASTER.START_DATE%TYPE
      , P_END_DATE           IN HRM_DEPT_MASTER.END_DATE%TYPE
      , P_SOB_ID             IN HRM_DEPT_MASTER.SOB_ID%TYPE
      , P_ORG_ID             IN HRM_DEPT_MASTER.ORG_ID%TYPE
      , P_USER_ID            IN HRM_DEPT_MASTER.CREATED_BY%TYPE
      );

-- DEPARTMENT UPDATE.
  PROCEDURE DATA_UPDATE
           ( W_DEPT_ID            IN HRM_DEPT_MASTER.DEPT_ID%TYPE
      , P_DEPT_CODE          IN HRM_DEPT_MASTER.DEPT_CODE%TYPE
      , P_DEPT_NAME          IN HRM_DEPT_MASTER.DEPT_NAME%TYPE
      , P_DEPT_NAME_S        IN HRM_DEPT_MASTER.DEPT_NAME_S%TYPE
      , P_DEPT_LEVEL         IN HRM_DEPT_MASTER.DEPT_LEVEL%TYPE
      , P_UPPER_DEPT_ID      IN HRM_DEPT_MASTER.UPPER_DEPT_ID%TYPE
      , P_DEPT_SORT_NUM      IN HRM_DEPT_MASTER.DEPT_SORT_NUM%TYPE
      , P_T_O                IN HRM_DEPT_MASTER.T_O%TYPE
      , P_DEPT_GROUP         IN HRM_DEPT_MASTER.DEPT_GROUP%TYPE
      , P_VALUER_1           IN HRM_DEPT_MASTER.VALUER_1%TYPE
      , P_VALUER_2           IN HRM_DEPT_MASTER.VALUER_2%TYPE
      , P_DESCRIPTION        IN HRM_DEPT_MASTER.DESCRIPTION%TYPE
      , P_USABLE             IN HRM_DEPT_MASTER.USABLE%TYPE
      , P_START_DATE         IN HRM_DEPT_MASTER.START_DATE%TYPE
      , P_END_DATE           IN HRM_DEPT_MASTER.END_DATE%TYPE
      , P_USER_ID            IN HRM_DEPT_MASTER.CREATED_BY%TYPE            
      ); 

---------------------------------------------------------------------------------------------------
-- DEPT_NAME_F : DEPT_ID를 가지고 명칭을 리턴함.
  FUNCTION DEPT_NAME_F
          ( W_DEPT_ID             IN HRM_DEPT_MASTER.DEPT_ID%TYPE
          ) RETURN VARCHAR2;
             
-- LOOKUP DEPT - LEVEL 별 조회.
  PROCEDURE LU_SELECT
           ( P_CURSOR            OUT TYPES.TCURSOR
      , W_CORP_ID           IN HRM_DEPT_MASTER.CORP_ID%TYPE
      , W_DEPT_LEVEL        IN HRM_DEPT_MASTER.DEPT_LEVEL%TYPE DEFAULT NULL
      , W_SOB_ID            IN HRM_DEPT_MASTER.SOB_ID%TYPE
      , W_ORG_ID            IN HRM_DEPT_MASTER.ORG_ID%TYPE
      , W_USABLE_CHECK_YN   IN HRM_DEPT_MASTER.USABLE%TYPE DEFAULT 'Y'
      );
                                             
-- LOOKUP DEPT LEVEL 조회.
  PROCEDURE LU_SELECT_LEVEL
           ( P_CURSOR1           OUT TYPES.TCURSOR1
      , W_CORP_ID           IN HRM_DEPT_MASTER.CORP_ID%TYPE
      , W_DEPT_LEVEL        IN HRM_DEPT_MASTER.DEPT_LEVEL%TYPE
      , W_SOB_ID            IN HRM_DEPT_MASTER.SOB_ID%TYPE
      , W_ORG_ID            IN HRM_DEPT_MASTER.ORG_ID%TYPE
      , W_USABLE_CHECK_YN   IN HRM_DEPT_MASTER.USABLE%TYPE DEFAULT 'Y'
      );
      
-- LOOKUP DEPT - 근태 CAPACITY 별 조회.
  PROCEDURE LU_SELECT_C
           ( P_CURSOR            OUT TYPES.TCURSOR
      , W_CORP_ID           IN HRM_DEPT_MASTER.CORP_ID%TYPE
      , W_STD_DATE          IN HRM_DEPT_MASTER.START_DATE%TYPE
      , W_CONNECT_PERSON_ID IN HRM_PERSON_MASTER.PERSON_ID%TYPE
      , W_SOB_ID            IN HRM_DEPT_MASTER.SOB_ID%TYPE
      , W_ORG_ID            IN HRM_DEPT_MASTER.ORG_ID%TYPE
      , W_USABLE_CHECK_YN   IN HRM_DEPT_MASTER.USABLE%TYPE DEFAULT 'Y'
      , W_CAP_CHECK_YN      IN VARCHAR2 DEFAULT 'Y'
      );

-- LOOKUP DEPT - 팀, 파트 부서조회
       PROCEDURE LU_SELECT_TEAMPART( P_CURSOR            OUT TYPES.TCURSOR
                                   , W_CORP_ID           IN  HRM_DEPT_MASTER.CORP_ID%TYPE
                                   , W_DEPT_LEVEL        IN  HRM_DEPT_MASTER.DEPT_LEVEL%TYPE DEFAULT NULL
                                   , W_SOB_ID            IN  HRM_DEPT_MASTER.SOB_ID%TYPE
                                   , W_ORG_ID            IN  HRM_DEPT_MASTER.ORG_ID%TYPE
                                   , W_USABLE_CHECK_YN   IN  HRM_DEPT_MASTER.USABLE%TYPE DEFAULT 'Y'
                                   );

END HRM_DEPT_MASTER_G;

 
/
CREATE OR REPLACE PACKAGE BODY HRM_DEPT_MASTER_G
AS
/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRM_DEPT_MASTER_G
/* Description  : 부서정보 관리 패키지
/*
/* Reference by : 부서정보 관리.
/* Program History :
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
-- 부서마스터 조회.
  PROCEDURE DATA_SELECT
	          ( P_CURSOR             OUT TYPES.TCURSOR
						, W_CORP_ID            IN HRM_DEPT_MASTER.CORP_ID%TYPE
						, W_DEPT_ID            IN HRM_DEPT_MASTER.DEPT_ID%TYPE
						, W_SOB_ID             IN HRM_DEPT_MASTER.SOB_ID%TYPE
						, W_ORG_ID             IN HRM_DEPT_MASTER.ORG_ID%TYPE
						)
  AS
  BEGIN
		OPEN P_CURSOR FOR
			SELECT DM.DEPT_ID
					, DM.CORP_ID
					, DM.DEPT_CODE
					, DM.DEPT_NAME
					, DM.DEPT_NAME_S
					, DM.DEPT_LEVEL
					, DM.UPPER_DEPT_ID
					, U_DM.DEPT_NAME UPPER_DEPT_NAME
					, DM.DEPT_SORT_NUM
					, DM.T_O
					, DM.DEPT_GROUP
					, DM.VALUER_1
					, PM1.NAME VALUER1_NAME
					, DM.VALUER_2
					, PM2.NAME VALUER2_NAME
					, DM.DESCRIPTION
          , DM.USABLE
					, DM.START_DATE
					, DM.END_DATE
			FROM HRM_DEPT_MASTER DM
				, HRM_DEPT_MASTER U_DM
				, HRM_PERSON_MASTER PM1
				, HRM_PERSON_MASTER PM2
			WHERE DECODE(DM.DEPT_LEVEL, 1, DM.DEPT_ID, DM.UPPER_DEPT_ID) = U_DM.DEPT_ID(+)
				AND DM.VALUER_1               = PM1.PERSON_ID(+)
				AND DM.VALUER_2               = PM2.PERSON_ID(+)
				AND DM.CORP_ID                = W_CORP_ID
				AND DM.DEPT_ID                = NVL(W_DEPT_ID, DM.DEPT_ID)
				AND DM.SOB_ID                 = W_SOB_ID
				AND DM.ORG_ID                 = W_ORG_ID
			;

  END DATA_SELECT;

-- DEPARTMENT INSERT.
  PROCEDURE DATA_INSERT
	          ( P_DEPT_ID            OUT HRM_DEPT_MASTER.DEPT_ID%TYPE
            , P_CORP_ID            IN HRM_DEPT_MASTER.CORP_ID%TYPE
						, P_DEPT_CODE          IN HRM_DEPT_MASTER.DEPT_CODE%TYPE
						, P_DEPT_NAME          IN HRM_DEPT_MASTER.DEPT_NAME%TYPE
						, P_DEPT_NAME_S        IN HRM_DEPT_MASTER.DEPT_NAME_S%TYPE
						, P_DEPT_LEVEL         IN HRM_DEPT_MASTER.DEPT_LEVEL%TYPE
						, P_UPPER_DEPT_ID      IN HRM_DEPT_MASTER.UPPER_DEPT_ID%TYPE
						, P_DEPT_SORT_NUM      IN HRM_DEPT_MASTER.DEPT_SORT_NUM%TYPE
						, P_T_O                IN HRM_DEPT_MASTER.T_O%TYPE
						, P_DEPT_GROUP         IN HRM_DEPT_MASTER.DEPT_GROUP%TYPE
						, P_VALUER_1           IN HRM_DEPT_MASTER.VALUER_1%TYPE
						, P_VALUER_2           IN HRM_DEPT_MASTER.VALUER_2%TYPE
						, P_DESCRIPTION        IN HRM_DEPT_MASTER.DESCRIPTION%TYPE
						, P_USABLE             IN HRM_DEPT_MASTER.USABLE%TYPE
						, P_START_DATE         IN HRM_DEPT_MASTER.START_DATE%TYPE
						, P_END_DATE           IN HRM_DEPT_MASTER.END_DATE%TYPE
						, P_SOB_ID             IN HRM_DEPT_MASTER.SOB_ID%TYPE
						, P_ORG_ID             IN HRM_DEPT_MASTER.ORG_ID%TYPE
						, P_USER_ID            IN HRM_DEPT_MASTER.CREATED_BY%TYPE
						)
  AS
	  D_SYSDATE                      DATE;
		
  BEGIN
	  D_SYSDATE := GET_LOCAL_DATE(P_SOB_ID);
		
    SELECT HRM_DEPT_MASTER_S1.NEXTVAL
      INTO P_DEPT_ID
      FROM DUAL;
      
		INSERT INTO HRM_DEPT_MASTER 
		( DEPT_ID, CORP_ID
    , DEPT_CODE, DEPT_NAME, DEPT_NAME_S
    , DEPT_LEVEL, UPPER_DEPT_ID, DEPT_SORT_NUM
    , T_O, DEPT_GROUP, VALUER_1, VALUER_2
    , DESCRIPTION
    , USABLE, START_DATE, END_DATE
    , SOB_ID, ORG_ID
    , CREATION_DATE, CREATED_BY
    , LAST_UPDATE_DATE, LAST_UPDATED_BY   
		) VALUES
		( P_DEPT_ID, P_CORP_ID
    , P_DEPT_CODE, P_DEPT_NAME, P_DEPT_NAME_S
    , P_DEPT_LEVEL, P_UPPER_DEPT_ID, P_DEPT_SORT_NUM
    , P_T_O, P_DEPT_GROUP, P_VALUER_1, P_VALUER_2
    , P_DESCRIPTION
    , P_USABLE, TRUNC(P_START_DATE), TRUNC(P_END_DATE)
    , P_SOB_ID, P_ORG_ID
    , D_SYSDATE, P_USER_ID, D_SYSDATE, P_USER_ID
		);
  
  END DATA_INSERT;  
  
-- DEPARTMENT UPDATE.
  PROCEDURE DATA_UPDATE
	          ( W_DEPT_ID            IN HRM_DEPT_MASTER.DEPT_ID%TYPE
						, P_DEPT_CODE          IN HRM_DEPT_MASTER.DEPT_CODE%TYPE
						, P_DEPT_NAME          IN HRM_DEPT_MASTER.DEPT_NAME%TYPE
						, P_DEPT_NAME_S        IN HRM_DEPT_MASTER.DEPT_NAME_S%TYPE
						, P_DEPT_LEVEL         IN HRM_DEPT_MASTER.DEPT_LEVEL%TYPE
						, P_UPPER_DEPT_ID      IN HRM_DEPT_MASTER.UPPER_DEPT_ID%TYPE
						, P_DEPT_SORT_NUM      IN HRM_DEPT_MASTER.DEPT_SORT_NUM%TYPE
						, P_T_O                IN HRM_DEPT_MASTER.T_O%TYPE
						, P_DEPT_GROUP         IN HRM_DEPT_MASTER.DEPT_GROUP%TYPE
						, P_VALUER_1           IN HRM_DEPT_MASTER.VALUER_1%TYPE
						, P_VALUER_2           IN HRM_DEPT_MASTER.VALUER_2%TYPE
						, P_DESCRIPTION        IN HRM_DEPT_MASTER.DESCRIPTION%TYPE
						, P_USABLE             IN HRM_DEPT_MASTER.USABLE%TYPE
						, P_START_DATE         IN HRM_DEPT_MASTER.START_DATE%TYPE
						, P_END_DATE           IN HRM_DEPT_MASTER.END_DATE%TYPE
						, P_USER_ID            IN HRM_DEPT_MASTER.CREATED_BY%TYPE            
						)
  AS
  BEGIN
    UPDATE HRM_DEPT_MASTER DM
      SET DM.DEPT_CODE             = P_DEPT_CODE
        , DM.DEPT_NAME             = P_DEPT_NAME
        , DM.DEPT_NAME_S           = P_DEPT_NAME_S
        , DM.DEPT_LEVEL            = P_DEPT_LEVEL
        , DM.UPPER_DEPT_ID         = P_UPPER_DEPT_ID
        , DM.DEPT_SORT_NUM         = P_DEPT_SORT_NUM
        , DM.T_O                   = P_T_O
        , DM.DEPT_GROUP            = P_DEPT_GROUP
        , DM.VALUER_1              = P_VALUER_1
        , DM.VALUER_2              = P_VALUER_2
        , DM.DESCRIPTION           = P_DESCRIPTION
        , DM.USABLE                = P_USABLE
        , DM.START_DATE            = TRUNC(P_START_DATE)
        , DM.END_DATE              = TRUNC(P_END_DATE)
        , DM.LAST_UPDATE_DATE      = GET_LOCAL_DATE(DM.SOB_ID)
        , DM.LAST_UPDATED_BY       = P_USER_ID
    WHERE DM.DEPT_ID               = W_DEPT_ID
    ;
  
  END DATA_UPDATE;  

---------------------------------------------------------------------------------------------------
-- DEPT_NAME_F : DEPT_ID를 가지고 명칭을 리턴함.
  FUNCTION DEPT_NAME_F
          ( W_DEPT_ID             IN HRM_DEPT_MASTER.DEPT_ID%TYPE
          ) RETURN VARCHAR2
  AS
	  V_DEPT_NAME                   HRM_DEPT_MASTER.DEPT_NAME%TYPE := NULL;
		
	BEGIN
	  BEGIN
			SELECT DM.DEPT_NAME
			  INTO V_DEPT_NAME
			FROM HRM_DEPT_MASTER DM
			WHERE DM.DEPT_ID            = W_DEPT_ID
   ;
   EXCEPTION WHEN OTHERS THEN
    V_DEPT_NAME := '';
  END;
   RETURN V_DEPT_NAME;
 
 END DEPT_NAME_F;
 
-- LOOKUP DEPT - LEVEL 별 조회.
  PROCEDURE LU_SELECT
           ( P_CURSOR            OUT TYPES.TCURSOR
          , W_CORP_ID           IN HRM_DEPT_MASTER.CORP_ID%TYPE
          , W_DEPT_LEVEL        IN HRM_DEPT_MASTER.DEPT_LEVEL%TYPE DEFAULT NULL
          , W_SOB_ID            IN HRM_DEPT_MASTER.SOB_ID%TYPE
          , W_ORG_ID            IN HRM_DEPT_MASTER.ORG_ID%TYPE
          , W_USABLE_CHECK_YN   IN HRM_DEPT_MASTER.USABLE%TYPE DEFAULT 'Y'
          )
  AS
    N_DEPT_LEVEL                  HRM_DEPT_MASTER.DEPT_LEVEL%TYPE := 1;
    V_STD_DATE                    HRM_DEPT_MASTER.START_DATE%TYPE;
    V_CORP_ID                     HRM_CORP_MASTER.CORP_ID%TYPE;
    
  BEGIN
  IF W_CORP_ID IS NULL THEN
      V_CORP_ID := HRM_CORP_MASTER_G.DEFAULT_CORP_ID_F( W_SOB_ID => W_SOB_ID
                                                      , W_ORG_ID => W_ORG_ID); 
    ELSE
      V_CORP_ID := W_CORP_ID;
    END IF;
    
    IF W_DEPT_LEVEL IS NULL OR W_DEPT_LEVEL = 0 THEN
   BEGIN
    SELECT NVL(CM.DEPT_CONTROL_LEVEL, 1) AS DEPT_CONTROL_LEVEL
     INTO N_DEPT_LEVEL
    FROM HRM_CORP_MASTER CM
    WHERE CM.CORP_ID              = V_CORP_ID
     AND CM.SOB_ID               = W_SOB_ID
     AND CM.ORG_ID               = W_ORG_ID      
    ;
   EXCEPTION WHEN OTHERS THEN
    N_DEPT_LEVEL := 1;
   END;
  ELSE
   N_DEPT_LEVEL := W_DEPT_LEVEL;
  END IF;
   
  -- 유효일자 체크 여부.
  IF W_USABLE_CHECK_YN = 'Y' THEN
    V_STD_DATE := TRUNC(GET_LOCAL_DATE(W_SOB_ID));
  ELSE
    V_STD_DATE := NULL;
  END IF;
  
  OPEN P_CURSOR FOR
   SELECT DM.DEPT_NAME
     , DM.DEPT_CODE
     , DM.DEPT_ID
   FROM HRM_DEPT_MASTER DM
   WHERE DM.CORP_ID               = V_CORP_ID
    AND DM.DEPT_LEVEL            = N_DEPT_LEVEL
    AND DM.SOB_ID                = W_SOB_ID
    AND DM.ORG_ID                = W_ORG_ID
    AND DM.USABLE                = DECODE(W_USABLE_CHECK_YN, 'Y', 'Y', DM.USABLE)
    AND DM.START_DATE            <= NVL(V_STD_DATE, DM.START_DATE)
    AND (DM.END_DATE IS NULL OR DM.END_DATE     >= NVL(V_STD_DATE, DM.END_DATE))
      ORDER BY DM.DEPT_CODE
   ;
  
  END LU_SELECT;

-- LOOKUP DEPT LEVEL 조회.
  PROCEDURE LU_SELECT_LEVEL
           ( P_CURSOR1           OUT TYPES.TCURSOR1
      , W_CORP_ID           IN HRM_DEPT_MASTER.CORP_ID%TYPE
      , W_DEPT_LEVEL        IN HRM_DEPT_MASTER.DEPT_LEVEL%TYPE
      , W_SOB_ID            IN HRM_DEPT_MASTER.SOB_ID%TYPE
      , W_ORG_ID            IN HRM_DEPT_MASTER.ORG_ID%TYPE
      , W_USABLE_CHECK_YN   IN HRM_DEPT_MASTER.USABLE%TYPE DEFAULT 'Y'
      )
  AS
    N_DEPT_LEVEL                  HRM_DEPT_MASTER.DEPT_LEVEL%TYPE := 1;
    V_STD_DATE                    HRM_DEPT_MASTER.START_DATE%TYPE;
  
  BEGIN
  N_DEPT_LEVEL := W_DEPT_LEVEL - 1;
  IF N_DEPT_LEVEL < 1 THEN
   N_DEPT_LEVEL := 1;
  END IF;
  
  -- 유효일자 체크 여부.
  IF W_USABLE_CHECK_YN = 'Y' THEN
    V_STD_DATE := TRUNC(GET_LOCAL_DATE(W_SOB_ID));
  ELSE
    V_STD_DATE := NULL;
  END IF;
  
  OPEN P_CURSOR1 FOR
   SELECT DM.DEPT_NAME
     , DM.DEPT_CODE
     , DM.DEPT_LEVEL
     , DM.DEPT_ID
   FROM HRM_DEPT_MASTER DM
   WHERE DM.CORP_ID               = W_CORP_ID
    AND DM.DEPT_LEVEL            = N_DEPT_LEVEL
    AND DM.SOB_ID                = W_SOB_ID
    AND DM.ORG_ID                = W_ORG_ID
    AND DM.USABLE                = DECODE(W_USABLE_CHECK_YN, 'Y', 'Y', DM.USABLE)
    AND DM.START_DATE            <= NVL(V_STD_DATE, DM.START_DATE)
    AND (DM.END_DATE IS NULL OR DM.END_DATE     >= NVL(V_STD_DATE, DM.END_DATE))
   ;
  
  END LU_SELECT_LEVEL;

-- LOOKUP DEPT - 근태 CAPACITY 별 조회.
  PROCEDURE LU_SELECT_C
           ( P_CURSOR            OUT TYPES.TCURSOR
      , W_CORP_ID           IN HRM_DEPT_MASTER.CORP_ID%TYPE
      , W_STD_DATE          IN HRM_DEPT_MASTER.START_DATE%TYPE
      , W_CONNECT_PERSON_ID IN HRM_PERSON_MASTER.PERSON_ID%TYPE
      , W_SOB_ID            IN HRM_DEPT_MASTER.SOB_ID%TYPE
      , W_ORG_ID            IN HRM_DEPT_MASTER.ORG_ID%TYPE
      , W_USABLE_CHECK_YN   IN HRM_DEPT_MASTER.USABLE%TYPE DEFAULT 'Y'
      , W_CAP_CHECK_YN      IN VARCHAR2 DEFAULT 'Y'
      )
  AS
   V_CONNECT_PERSON_ID           HRM_PERSON_MASTER.PERSON_ID%TYPE;
  V_STD_DATE                    HRM_DEPT_MASTER.START_DATE%TYPE;
  
 BEGIN
   -- 권한 체크 여부.
   IF W_CAP_CHECK_YN = 'Y' AND 
     HRM_MANAGER_G.USER_CAP_F( W_CORP_ID => W_CORP_ID 
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
  
  -- 유효일자 체크 여부.
  IF W_USABLE_CHECK_YN = 'Y' THEN
    V_STD_DATE := TRUNC(GET_LOCAL_DATE(W_SOB_ID));
  ELSE
    V_STD_DATE := NULL;
  END IF;
  
   OPEN P_CURSOR FOR
    SELECT DM.DEPT_NAME
     , DM.DEPT_CODE
     , DM.DEPT_ID
   FROM HRM_DEPT_MASTER DM
   WHERE DM.CORP_ID               = W_CORP_ID
    AND DM.SOB_ID                = W_SOB_ID
    AND DM.ORG_ID                = W_ORG_ID
    AND EXISTS( SELECT 'X'
                FROM HRD_DUTY_MANAGER HDM
          WHERE HDM.DUTY_CONTROL_ID       = DM.DEPT_ID
            AND NVL(V_CONNECT_PERSON_ID, HDM.MANAGER_ID1) IN (HDM.MANAGER_ID1, HDM.MANAGER_ID2, HDM.APPROVER_ID1, HDM.APPROVER_ID2)
           AND HDM.START_DATE           <= NVL(V_STD_DATE, HDM.START_DATE)
           AND (HDM.END_DATE IS NULL OR HDM.END_DATE >= NVL(V_STD_DATE, HDM.END_DATE))
         )
   ;
 
 END LU_SELECT_C;


-- LOOKUP DEPT - 팀, 파트 부서조회
       PROCEDURE LU_SELECT_TEAMPART( P_CURSOR            OUT TYPES.TCURSOR
                                   , W_CORP_ID           IN  HRM_DEPT_MASTER.CORP_ID%TYPE
                                   , W_DEPT_LEVEL        IN  HRM_DEPT_MASTER.DEPT_LEVEL%TYPE DEFAULT NULL
                                   , W_SOB_ID            IN  HRM_DEPT_MASTER.SOB_ID%TYPE
                                   , W_ORG_ID            IN  HRM_DEPT_MASTER.ORG_ID%TYPE
                                   , W_USABLE_CHECK_YN   IN  HRM_DEPT_MASTER.USABLE%TYPE DEFAULT 'Y'
                                   )

       AS

                 N_DEPT_LEVEL  HRM_DEPT_MASTER.DEPT_LEVEL%TYPE := 1;
                 V_STD_DATE    HRM_DEPT_MASTER.START_DATE%TYPE;
                 V_CORP_ID     HRM_CORP_MASTER.CORP_ID%TYPE;

       BEGIN
                 IF W_CORP_ID IS NULL THEN
                     V_CORP_ID := HRM_CORP_MASTER_G.DEFAULT_CORP_ID_F( W_SOB_ID => W_SOB_ID
                                                                     , W_ORG_ID => W_ORG_ID);
                 ELSE
                    V_CORP_ID := W_CORP_ID;
                 END IF;

                 IF W_DEPT_LEVEL IS NULL OR W_DEPT_LEVEL = 0 THEN
                    BEGIN
                         SELECT NVL(CM.DEPT_CONTROL_LEVEL, 1) AS DEPT_CONTROL_LEVEL
                           INTO N_DEPT_LEVEL
                           FROM HRM_CORP_MASTER CM
                          WHERE CM.CORP_ID              = V_CORP_ID
                            AND CM.SOB_ID               = W_SOB_ID
                            AND CM.ORG_ID               = W_ORG_ID
                              ;
                         EXCEPTION WHEN OTHERS THEN
                                   N_DEPT_LEVEL := 1;
                    END;
                 ELSE
                    N_DEPT_LEVEL := W_DEPT_LEVEL;
                 END IF;

                 -- 유효일자 체크 여부.
                 IF W_USABLE_CHECK_YN = 'Y' THEN
                    V_STD_DATE := TRUNC(GET_LOCAL_DATE(W_SOB_ID));
                 ELSE
                    V_STD_DATE := NULL;
                 END IF;

                 OPEN P_CURSOR FOR
                 SELECT DM_P.DEPT_NAME     AS TEAM_NAME
                      , DM_C.DEPT_NAME     AS PART_NAME
                      , DM_C.DEPT_CODE     AS DEPT_CODE
                      , DM_C.DEPT_ID       AS DEPT_ID
                   FROM HRM_DEPT_MASTER DM_P
                      , HRM_DEPT_MASTER DM_C
                  WHERE DM_P.DEPT_ID     = DM_C.UPPER_DEPT_ID
                    AND DM_P.SOB_ID      = W_SOB_ID
                    AND DM_P.ORG_ID      = W_ORG_ID
                    AND DM_P.CORP_ID     = V_CORP_ID
                    AND DM_C.DEPT_LEVEL  = N_DEPT_LEVEL
                    AND DM_C.USABLE      = DECODE(W_USABLE_CHECK_YN, 'Y', 'Y', DM_C.USABLE)
                    AND DM_C.START_DATE <= NVL(V_STD_DATE, DM_C.START_DATE)
                    AND (DM_C.END_DATE IS NULL OR DM_C.END_DATE >= NVL(V_STD_DATE, DM_C.END_DATE))
               ORDER BY DM_P.DEPT_NAME
                      , DM_C.DEPT_NAME
                      ;

       END LU_SELECT_TEAMPART;

END HRM_DEPT_MASTER_G;
/
