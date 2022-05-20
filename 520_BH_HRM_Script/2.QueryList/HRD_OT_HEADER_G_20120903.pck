CREATE OR REPLACE PACKAGE HRD_OT_HEADER_G
AS
-- WORK OT HEADER SELECT
  PROCEDURE DATA_SELECT
            ( P_CURSOR                                OUT TYPES.TCURSOR
            , W_CORP_ID                               IN HRD_OT_HEADER.CORP_ID%TYPE
            , W_STD_DATE                              IN HRD_OT_HEADER.REQ_DATE%TYPE
            , W_OT_HEADER_ID                          IN HRD_OT_HEADER.OT_HEADER_ID%TYPE
						, W_DUTY_MANAGER_ID                       IN HRD_OT_HEADER.DUTY_MANAGER_ID%TYPE
            , W_CONNECT_PERSON_ID                     IN HRM_PERSON_MASTER.PERSON_ID%TYPE
						);

-- DATA INSERT.
  PROCEDURE DATA_INSERT
            ( P_REQ_TYPE                              IN HRD_OT_HEADER.REQ_TYPE%TYPE
						, P_CORP_ID                               IN HRD_OT_HEADER.CORP_ID%TYPE
						, P_DUTY_MANAGER_ID                       IN HRD_OT_HEADER.DUTY_MANAGER_ID%TYPE
            , P_REQ_PERSON_ID                         IN HRD_OT_HEADER.REQ_PERSON_ID%TYPE
            , P_DESCRIPTION                           IN HRD_OT_HEADER.DESCRIPTION%TYPE
            , P_SOB_ID                                IN HRD_OT_HEADER.SOB_ID%TYPE
            , P_ORG_ID                                IN HRD_OT_HEADER.ORG_ID%TYPE
            , P_USER_ID                               IN HRD_OT_HEADER.CREATED_BY%TYPE
						, O_OT_HEADER_ID                          OUT HRD_OT_HEADER.OT_HEADER_ID%TYPE
            , O_REQ_NUM                               OUT HRD_OT_HEADER.REQ_NUM%TYPE
						, O_REQ_PERSON_NAME                       OUT HRM_PERSON_MASTER.NAME%TYPE
            );

-- DATA UPDATE.
  PROCEDURE DATA_UPDATE
            ( W_OT_HEADER_ID                          IN HRD_OT_HEADER.OT_HEADER_ID%TYPE
            , P_DESCRIPTION                           IN HRD_OT_HEADER.DESCRIPTION%TYPE
            , P_USER_ID                               IN HRD_OT_HEADER.CREATED_BY%TYPE
            );

-- DATA DELETE.
  PROCEDURE DATA_DELETE
            ( W_OT_HEADER_ID                          IN HRD_OT_HEADER.OT_HEADER_ID%TYPE
            );

-- DATA UPDATE REQUEST.
  PROCEDURE DATA_UPDATE_REQUEST
            ( W_OT_HEADER_ID                          IN HRD_OT_HEADER.OT_HEADER_ID%TYPE
            );
            
-----------------------------------------------------------------------------------------
-- WORK OT HEADER APPROVE SELECT.
  PROCEDURE DATA_SELECT_APPROVE
            ( P_CURSOR                                OUT TYPES.TCURSOR
            , W_CORP_ID                               IN HRD_OT_HEADER.CORP_ID%TYPE
            , W_START_DATE                            IN HRD_OT_HEADER.REQ_DATE%TYPE
						, W_END_DATE                              IN HRD_OT_HEADER.REQ_DATE%TYPE
						, W_APPROVE_STATUS                        IN HRD_OT_HEADER.APPROVE_STATUS%TYPE
            , W_OT_HEADER_ID                          IN HRD_OT_HEADER.OT_HEADER_ID%TYPE
						, W_DUTY_MANAGER_ID                       IN HRD_OT_HEADER.DUTY_MANAGER_ID%TYPE
            , W_CONNECT_PERSON_ID                     IN HRM_PERSON_MASTER.PERSON_ID%TYPE
            , W_SOB_ID                                IN HRD_OT_HEADER.SOB_ID%TYPE
						, W_ORG_ID                                IN HRD_OT_HEADER.ORG_ID%TYPE   
						);
						
-- DATA UPDATE - STEP APPROVE.
  PROCEDURE DATA_UPDATE_APPROVE
	          ( W_OT_HEADER_ID                          IN HRD_OT_HEADER.OT_HEADER_ID%TYPE
            , P_APPROVE_STATUS                        IN HRD_OT_HEADER.APPROVE_STATUS%TYPE
						, P_CHECK_YN                              IN VARCHAR2
						, P_CONNECT_PERSON_ID                     IN HRM_PERSON_MASTER.PERSON_ID%TYPE
						, P_APPROVE_FLAG                          IN VARCHAR2
						, P_SOB_ID                                IN HRD_OT_HEADER.SOB_ID%TYPE
						, P_ORG_ID                                IN HRD_OT_HEADER.ORG_ID%TYPE   
						, P_USER_ID                               IN HRD_OT_HEADER.CREATED_BY%TYPE
						);								

-- DATA APPRVE_STATUS.
  PROCEDURE DATA_APPROVE_STATUS
	          ( W_OT_HEADER_ID                          IN HRD_OT_HEADER.OT_HEADER_ID%TYPE
						, O_APPROVE_STATUS                        OUT HRD_OT_HEADER.APPROVE_STATUS%TYPE
						);
						
-- DATA APPRVE_STATUS CHECK.
  FUNCTION DATA_STATUS_CHECK
	         ( W_OT_HEADER_ID                          IN HRD_OT_HEADER.OT_HEADER_ID%TYPE
					 ) RETURN VARCHAR2;

---------------------------------------------------------------------------------------------------
-- PROCEDURE REQ NUM SEARCH.
  PROCEDURE LU_REQ_NUM
						( P_CURSOR1                  OUT TYPES.TCURSOR1
						, W_CORP_ID                  IN HRD_OT_HEADER.CORP_ID%TYPE
						, W_STD_DATE                 IN HRD_OT_HEADER.REQ_DATE%TYPE
						, W_CONNECT_PERSON_ID        IN HRD_OT_HEADER.REQ_PERSON_ID%TYPE
						, W_SOB_ID                   IN HRD_OT_HEADER.SOB_ID%TYPE
						, W_ORG_ID                   IN HRD_OT_HEADER.ORG_ID%TYPE
						);
-- PROCEDURE REQ NUM SEARCH.
  PROCEDURE LU_REQ_NUM2
						( P_CURSOR1                  OUT TYPES.TCURSOR1
						, W_CORP_ID                  IN HRD_OT_HEADER.CORP_ID%TYPE
						, W_STD_DATE                 IN HRD_OT_HEADER.REQ_DATE%TYPE
						, W_CONNECT_PERSON_ID        IN HRD_OT_HEADER.REQ_PERSON_ID%TYPE
						, W_SOB_ID                   IN HRD_OT_HEADER.SOB_ID%TYPE
						, W_ORG_ID                   IN HRD_OT_HEADER.ORG_ID%TYPE
      , W_FLOOR_ID                 IN HRM_PERSON_MASTER.FLOOR_ID%TYPE
						);



-----------------------------------------------------------------------------------------
-- [2011-10-31]
-- 연장근무 반려 처리를 위한 조회.
  PROCEDURE OT_HEADER_RETURN_SELECT
            ( P_CURSOR1                               OUT TYPES.TCURSOR1
            , W_CORP_ID                               IN HRD_OT_HEADER.CORP_ID%TYPE
            , W_START_DATE                            IN HRD_OT_HEADER.REQ_DATE%TYPE
            , W_END_DATE                              IN HRD_OT_HEADER.REQ_DATE%TYPE
            , W_APPROVE_STATUS                        IN HRD_OT_HEADER.APPROVE_STATUS%TYPE
            , W_OT_HEADER_ID                          IN HRD_OT_HEADER.OT_HEADER_ID%TYPE
			       		, W_DUTY_MANAGER_ID                       IN HRD_OT_HEADER.DUTY_MANAGER_ID%TYPE
            , W_CONNECT_PERSON_ID                     IN HRM_PERSON_MASTER.PERSON_ID%TYPE
            , W_SOB_ID                                IN HRD_OT_HEADER.SOB_ID%TYPE
				      		, W_ORG_ID                                IN HRD_OT_HEADER.ORG_ID%TYPE   
				      		);

-- 연장근무 반려 처리.
  PROCEDURE OT_HEADER_RETURN_UPDATE
	          ( W_OT_HEADER_ID                          IN HRD_OT_HEADER.OT_HEADER_ID%TYPE
            , P_REJECT_REMARK                         IN HRD_OT_HEADER.REJECT_REMARK%TYPE
            , P_APPROVE_STATUS                        IN HRD_OT_HEADER.APPROVE_STATUS%TYPE
            , P_CONNECT_PERSON_ID                     IN HRM_PERSON_MASTER.PERSON_ID%TYPE
            , P_SOB_ID                                IN HRD_OT_HEADER.SOB_ID%TYPE
            , P_ORG_ID                                IN HRD_OT_HEADER.ORG_ID%TYPE   
            );	

-----------------------------------------------------------------------------------------

   PROCEDURE SELECT_OT_HEADER_APPROVE
           ( P_CURSOR              OUT  TYPES.TCURSOR
           , W_CORP_ID             IN   HRD_OT_HEADER.CORP_ID%TYPE
           , W_WORK_DATE_FR        IN   HRD_OT_HEADER.REQ_DATE%TYPE
           , W_WORK_DATE_TO        IN   HRD_OT_HEADER.REQ_DATE%TYPE
           , W_APPROVE_STATUS      IN   HRD_OT_HEADER.APPROVE_STATUS%TYPE
           , W_OT_HEADER_ID        IN   HRD_OT_HEADER.OT_HEADER_ID%TYPE
           , W_DUTY_MANAGER_ID     IN   HRD_OT_HEADER.DUTY_MANAGER_ID%TYPE
           , W_CONNECT_PERSON_ID   IN   HRM_PERSON_MASTER.PERSON_ID%TYPE
           , W_SOB_ID              IN   HRD_OT_HEADER.SOB_ID%TYPE
           , W_ORG_ID              IN   HRD_OT_HEADER.ORG_ID%TYPE
           );

--CAPACITY GET[2011-12-12]
  PROCEDURE GET_CAPACITY
          ( O_CAPACITY_C         OUT VARCHAR2
          , W_SOB_ID             IN  HRM_PERSON_MASTER.SOB_ID%TYPE
          , W_ORG_ID             IN  HRM_PERSON_MASTER.ORG_ID%TYPE
          , W_CORP_ID            IN  HRM_PERSON_MASTER.CORP_ID%TYPE
          , W_CONNECT_PERSON_ID  IN  HRM_PERSON_MASTER.PERSON_ID%TYPE
          );


--CAPACITY GET[2011-12-12]
  PROCEDURE GET_REQUEST_LIMIT
          ( O_REQUEST_LIMIT_COUNT  OUT HRM_COMMON.VALUE1%TYPE
          , W_SOB_ID               IN  HRM_COMMON.SOB_ID%TYPE
          , W_ORG_ID               IN  HRM_COMMON.ORG_ID%TYPE
          , W_CODE                 IN  HRM_COMMON.CODE%TYPE
          );


END HRD_OT_HEADER_G;


 
/
CREATE OR REPLACE PACKAGE BODY HRD_OT_HEADER_G
AS
/******************************************************************************/
/* PROJECT      : FPCB ERP
/* MODULE       : EAPP
/* PROGRAM NAME : HRD_OT_HEADER_G
/* DESCRIPTION  : 연장근무 HEADER 신청 승인 관리.
/* REFERENCE BY :
/* PROGRAM HISTORY : 신규 생성
/*------------------------------------------------------------------------------
/*   DATE       IN CHARGE          DESCRIPTION
/*------------------------------------------------------------------------------
/* 20-JUN-2010  JEON HO SU          INITIALIZE
/******************************************************************************/
-- PERIOD SELECT
  PROCEDURE DATA_SELECT
	          ( P_CURSOR                                OUT TYPES.TCURSOR
						, W_CORP_ID                               IN HRD_OT_HEADER.CORP_ID%TYPE
						, W_STD_DATE                              IN HRD_OT_HEADER.REQ_DATE%TYPE
            , W_OT_HEADER_ID                          IN HRD_OT_HEADER.OT_HEADER_ID%TYPE
						, W_DUTY_MANAGER_ID                       IN HRD_OT_HEADER.DUTY_MANAGER_ID%TYPE
            , W_CONNECT_PERSON_ID                     IN HRM_PERSON_MASTER.PERSON_ID%TYPE
						)
  AS
		V_STD_DATE                                        HRD_OT_HEADER.REQ_DATE%TYPE := NULL;
		V_DUTY_MANAGER_ID                                 HRD_OT_HEADER.DUTY_MANAGER_ID%TYPE := NULL;
						
  BEGIN
	  IF W_OT_HEADER_ID IS NULL THEN
			V_STD_DATE := W_STD_DATE;
			V_DUTY_MANAGER_ID := W_DUTY_MANAGER_ID;			
		END IF;
		
    OPEN P_CURSOR FOR
      SELECT  OH.REQ_NUM
						, OH.REQ_TYPE
						, RT.REQ_TYPE_NAME AS REQ_TYPE_NAME
						, TO_NUMBER(RT.REQ_STD_ADD_DAY) AS REQ_STD_ADD_DAY
						, OH.REQ_DATE
						, OH.CORP_ID
						, OH.DUTY_MANAGER_ID
						, HRD_DUTY_MANAGER_G.MANAGER_NAME_F(OH.DUTY_MANAGER_ID) AS DUTY_MANAGER_NAME
						, OH.REQ_PERSON_ID
						, HRM_PERSON_MASTER_G.NAME_F(OH.REQ_PERSON_ID) AS REQ_PERSON_NAME
						, OH.APPROVED_YN
						, OH.APPROVED_PERSON_ID
						, HRM_PERSON_MASTER_G.NAME_F(OH.APPROVED_PERSON_ID) AS APPROVED_PERSON_NAME
						, OH.CONFIRMED_YN
						, OH.CONFIRMED_PERSON_ID
						, HRM_PERSON_MASTER_G.NAME_F(OH.CONFIRMED_PERSON_ID) AS CONFIRMED_PERSON_NAME
						, OH.APPROVE_STATUS
						, HRM_COMMON_G.CODE_NAME_F('DUTY_APPROVE_STATUS', OH.APPROVE_STATUS, OH.SOB_ID, OH.ORG_ID) AS APPROVE_STATUS_NAME
						, OH.CALENDAR_TRAN_YN
						, OH.DESCRIPTION
						, 'N' AS APPROVE_YN
      , OH.REJECT_YN
      , OH.REJECT_DATE
      , HRM_PERSON_MASTER_G.NAME_F(OH.REJECT_PERSON_ID) AS REJECT_PERSON_NAME
      , OH.REJECT_REMARK
						, OH.OT_HEADER_ID
				FROM  HRD_OT_HEADER OH
				    , HRM_REQ_TYPE_V RT  
			 WHERE  OH.REQ_TYPE                           = RT.REQ_TYPE
			   AND  OH.OT_HEADER_ID                       = NVL(W_OT_HEADER_ID, OH.OT_HEADER_ID)
			   AND  OH.CORP_ID                            = W_CORP_ID
				 AND  OH.REQ_DATE                           = NVL(V_STD_DATE, OH.REQ_DATE)
				 AND  OH.DUTY_MANAGER_ID                    = NVL(V_DUTY_MANAGER_ID, OH.DUTY_MANAGER_ID)
         AND  EXISTS (SELECT 'X'
                      FROM HRD_DUTY_MANAGER DM
                      WHERE DM.CORP_ID                                = OH.CORP_ID
                       AND DM.DUTY_MANAGER_ID                         = OH.DUTY_MANAGER_ID
                       AND (NVL(W_CONNECT_PERSON_ID, DM.APPROVER_ID1) IN(DM.MANAGER_ID1, DM.MANAGER_ID2, DM.APPROVER_ID1, DM.APPROVER_ID2))
                       AND DM.START_DATE                              <= OH.REQ_DATE
                       AND (DM.END_DATE IS NULL OR DM.END_DATE        >= OH.REQ_DATE)
                       AND DM.SOB_ID                                  = OH.SOB_ID
                       AND DM.ORG_ID                                  = OH.ORG_ID
                   )
         ORDER BY OH.REQ_NUM
       ;

  END DATA_SELECT;

-- DATA INSERT.
  PROCEDURE DATA_INSERT
            ( P_REQ_TYPE                              IN HRD_OT_HEADER.REQ_TYPE%TYPE
						, P_CORP_ID                               IN HRD_OT_HEADER.CORP_ID%TYPE
						, P_DUTY_MANAGER_ID                       IN HRD_OT_HEADER.DUTY_MANAGER_ID%TYPE
            , P_REQ_PERSON_ID                         IN HRD_OT_HEADER.REQ_PERSON_ID%TYPE
            , P_DESCRIPTION                           IN HRD_OT_HEADER.DESCRIPTION%TYPE
            , P_SOB_ID                                IN HRD_OT_HEADER.SOB_ID%TYPE
            , P_ORG_ID                                IN HRD_OT_HEADER.ORG_ID%TYPE
            , P_USER_ID                               IN HRD_OT_HEADER.CREATED_BY%TYPE
						, O_OT_HEADER_ID                          OUT HRD_OT_HEADER.OT_HEADER_ID%TYPE
            , O_REQ_NUM                               OUT HRD_OT_HEADER.REQ_NUM%TYPE
						, O_REQ_PERSON_NAME                       OUT HRM_PERSON_MASTER.NAME%TYPE
            )
  AS
	  D_SYSDATE                                         HRD_OT_HEADER.CREATION_DATE%TYPE;
    
    V_RECORD_COUNT                                    NUMBER := 0;
		V_OT_HEADER_ID                                    HRD_OT_HEADER.OT_HEADER_ID%TYPE;
    V_REQ_NUM                                         HRD_OT_HEADER.REQ_NUM%TYPE;
		V_REQ_MONTH                                       HRD_OT_HEADER.REQ_MONTH%TYPE;
		V_REQ_SEQ                                         HRD_OT_HEADER.REQ_SEQ%TYPE;
		
  BEGIN
    D_SYSDATE := GET_LOCAL_DATE(P_SOB_ID);
    V_REQ_MONTH := TO_CHAR(D_SYSDATE, 'YYYYMM');
		
    BEGIN
      SELECT MAX(OH.REQ_NUM) AS REQ_NUM
           , COUNT(*) AS RECORD_COUNT
        INTO V_REQ_NUM
           , V_RECORD_COUNT
        FROM HRD_OT_HEADER OH
      WHERE OH.DUTY_MANAGER_ID    = P_DUTY_MANAGER_ID
        AND OH.SOB_ID             = P_SOB_ID
        AND OH.ORG_ID             = P_ORG_ID
        AND OH.APPROVE_STATUS     = 'R'
        AND NVL(TO_DATE(OH.ATTRIBUTE1, 'YYYY-MM-DD'), OH.REQ_DATE)  BETWEEN TRUNC(D_SYSDATE, 'MONTH') AND LAST_DAY(D_SYSDATE)  -- 실제 근무일자를 ATTRIBUTE1에 저장함.
      ;
    EXCEPTION WHEN OTHERS THEN
      V_RECORD_COUNT := 0;
    END;
    IF V_RECORD_COUNT != 0 THEN
      RAISE_APPLICATION_ERROR(-20001, '[' || V_REQ_NUM || '] ' || EAPP_MESSAGE_G.RETURN_MSG_F('FCM_10466'));
      RETURN;
    END IF;
    
		-- 신청번호 생성.
		BEGIN
		  SELECT HRD_OT_HEADER_S1.NEXTVAL
			  INTO V_OT_HEADER_ID				
			  FROM DUAL;
			
		  SELECT NVL(MAX(OH.REQ_SEQ), 0) + 1 REQ_SEQ
			  INTO V_REQ_SEQ
			  FROM HRD_OT_HEADER OH
			 WHERE OH.REQ_MONTH              = V_REQ_MONTH
			;		
		EXCEPTION WHEN OTHERS THEN
		  V_REQ_SEQ := 1;
		END;
		V_REQ_NUM := V_REQ_MONTH || '-' || LPAD(V_REQ_SEQ, 4, 0);
		
    INSERT INTO HRD_OT_HEADER
    ( OT_HEADER_ID, REQ_NUM
    , REQ_TYPE, REQ_DATE
    , CORP_ID, REQ_MONTH, REQ_SEQ
    , DUTY_MANAGER_ID, REQ_PERSON_ID
    , DESCRIPTION
    , SOB_ID, ORG_ID
    , CREATION_DATE, CREATED_BY, LAST_UPDATE_DATE, LAST_UPDATED_BY
    ) VALUES
    ( V_OT_HEADER_ID, V_REQ_NUM
    , P_REQ_TYPE, TRUNC(D_SYSDATE)
    , P_CORP_ID, V_REQ_MONTH, V_REQ_SEQ
    , P_DUTY_MANAGER_ID, P_REQ_PERSON_ID
    , P_DESCRIPTION
    , P_SOB_ID, P_ORG_ID
    , D_SYSDATE, P_USER_ID, D_SYSDATE, P_USER_ID
    );
    
		O_OT_HEADER_ID := V_OT_HEADER_ID;
    O_REQ_NUM := V_REQ_NUM;
    O_REQ_PERSON_NAME := HRM_PERSON_MASTER_G.NAME_F(P_REQ_PERSON_ID);
		
  END DATA_INSERT;

-- DATA UPDATE.
  PROCEDURE DATA_UPDATE
            ( W_OT_HEADER_ID                          IN HRD_OT_HEADER.OT_HEADER_ID%TYPE
            , P_DESCRIPTION                           IN HRD_OT_HEADER.DESCRIPTION%TYPE
            , P_USER_ID                               IN HRD_OT_HEADER.CREATED_BY%TYPE
            )
  AS
  BEGIN
	  IF DATA_STATUS_CHECK(W_OT_HEADER_ID) = 'Y' THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10042', '&&VALUE:=수정'));
    END IF;
		
    UPDATE HRD_OT_HEADER OH
      SET OH.DESCRIPTION                      = P_DESCRIPTION
        , OH.LAST_UPDATE_DATE                 = GET_LOCAL_DATE(OH.SOB_ID)
        , OH.LAST_UPDATED_BY                  = P_USER_ID
    WHERE OH.OT_HEADER_ID                     = W_OT_HEADER_ID
    ;
  END DATA_UPDATE;

-- DATA DELETE.
  PROCEDURE DATA_DELETE
            ( W_OT_HEADER_ID                          IN HRD_OT_HEADER.OT_HEADER_ID%TYPE
            )
  AS
	  --V_RECORD_COUNT                                    NUMBER := 0;
		
  BEGIN
    IF DATA_STATUS_CHECK(W_OT_HEADER_ID) = 'Y' THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10042', '&&VALUE:=삭제'));
    END IF;
    
/*		HRD_OT_LINE_G.DATA_LINE_COUNT(W_OT_HEADER_ID, V_RECORD_COUNT);
		IF V_RECORD_COUNT > 0 THEN
		    RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_10016', NULL));
		END IF;*/
		
    DELETE HRD_OT_HEADER OH
    WHERE OH.OT_HEADER_ID                         = W_OT_HEADER_ID
    ;

  END DATA_DELETE;

-- DATA UPDATE REQUEST.
  PROCEDURE DATA_UPDATE_REQUEST
            ( W_OT_HEADER_ID                          IN HRD_OT_HEADER.OT_HEADER_ID%TYPE
            )
  AS
  BEGIN
    IF DATA_STATUS_CHECK(W_OT_HEADER_ID) = 'Y' THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10042', '&&VALUE:=Approval Request(승인요청)'));
    END IF;
		   
    UPDATE HRD_OT_HEADER OH
      SET OH.APPROVE_STATUS                   = 'A'
        , OH.EMAIL_STATUS                     = 'AR'
        , OH.REJECT_YN                        = 'N'
    WHERE OH.OT_HEADER_ID                     = W_OT_HEADER_ID
    ;
    
  END DATA_UPDATE_REQUEST;
  	
-----------------------------------------------------------------------------------------
-- WORK OT HEADER APPROVE SELECT.
  PROCEDURE DATA_SELECT_APPROVE
            ( P_CURSOR                                OUT TYPES.TCURSOR
            , W_CORP_ID                               IN HRD_OT_HEADER.CORP_ID%TYPE
            , W_START_DATE                            IN HRD_OT_HEADER.REQ_DATE%TYPE
						, W_END_DATE                              IN HRD_OT_HEADER.REQ_DATE%TYPE
						, W_APPROVE_STATUS                        IN HRD_OT_HEADER.APPROVE_STATUS%TYPE
            , W_OT_HEADER_ID                          IN HRD_OT_HEADER.OT_HEADER_ID%TYPE
						, W_DUTY_MANAGER_ID                       IN HRD_OT_HEADER.DUTY_MANAGER_ID%TYPE
            , W_CONNECT_PERSON_ID                     IN HRM_PERSON_MASTER.PERSON_ID%TYPE
            , W_SOB_ID                                IN HRD_OT_HEADER.SOB_ID%TYPE
						, W_ORG_ID                                IN HRD_OT_HEADER.ORG_ID%TYPE   
						)
  AS
    V_CONNECT_PERSON_ID                           HRM_PERSON_MASTER.PERSON_ID%TYPE := NULL;
    
	BEGIN
    -- 근태권한 설정.
		IF HRM_MANAGER_G.USER_CAP_F( W_CORP_ID => W_CORP_ID 
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
    IF W_APPROVE_STATUS IN('A') THEN
      V_CONNECT_PERSON_ID := W_CONNECT_PERSON_ID;
    END IF;
    
	  OPEN P_CURSOR FOR
      SELECT  OH.REQ_NUM
						, OH.REQ_TYPE
						, HRM_COMMON_G.CODE_NAME_F('REQ_TYPE', OH.REQ_TYPE, OH.SOB_ID, OH.ORG_ID) AS REQ_TYPE_NAME
						, OH.REQ_DATE
						, OH.CORP_ID
						, OH.DUTY_MANAGER_ID
						, HRD_DUTY_MANAGER_G.MANAGER_NAME_F(OH.DUTY_MANAGER_ID) AS DUTY_MANAGER_NAME
						, OH.REQ_PERSON_ID
						, HRM_PERSON_MASTER_G.NAME_F(OH.REQ_PERSON_ID) AS REQ_PERSON_NAME
						, OH.APPROVED_YN
						, OH.APPROVED_PERSON_ID
						, HRM_PERSON_MASTER_G.NAME_F(OH.APPROVED_PERSON_ID) AS APPROVED_PERSON_NAME
						, OH.CONFIRMED_YN
						, OH.CONFIRMED_PERSON_ID
						, HRM_PERSON_MASTER_G.NAME_F(OH.CONFIRMED_PERSON_ID) AS CONFIRMED_PERSON_NAME
						, OH.APPROVE_STATUS
						, HRM_COMMON_G.CODE_NAME_F('DUTY_APPROVE_STATUS', OH.APPROVE_STATUS, OH.SOB_ID, OH.ORG_ID) AS APPROVE_STATUS_NAME
						, OH.CALENDAR_TRAN_YN
						, OH.DESCRIPTION
						, 'N' AS APPROVE_YN
						, OH.OT_HEADER_ID
				FROM  HRD_OT_HEADER OH
			 WHERE  OH.OT_HEADER_ID                       = NVL(W_OT_HEADER_ID, OH.OT_HEADER_ID)
			   AND  OH.CORP_ID                            = W_CORP_ID
				 AND  OH.REQ_DATE                           BETWEEN W_START_DATE AND W_END_DATE
				 AND  OH.DUTY_MANAGER_ID                    = NVL(W_DUTY_MANAGER_ID, OH.DUTY_MANAGER_ID)
				 AND  OH.APPROVE_STATUS                     = NVL(W_APPROVE_STATUS, OH.APPROVE_STATUS)
         AND EXISTS (SELECT 'X'
                      FROM HRD_DUTY_MANAGER DM
                      WHERE DM.CORP_ID                                = OH.CORP_ID
                       AND DM.DUTY_MANAGER_ID                         = OH.DUTY_MANAGER_ID
                       AND (NVL(V_CONNECT_PERSON_ID, DM.APPROVER_ID1) IN(DM.MANAGER_ID1, DM.MANAGER_ID2, DM.APPROVER_ID1, DM.APPROVER_ID2))
                       AND DM.START_DATE                              <= W_END_DATE
                       AND (DM.END_DATE IS NULL OR DM.END_DATE        >= W_START_DATE)
                       AND DM.SOB_ID                                  = OH.SOB_ID
                       AND DM.ORG_ID                                  = OH.ORG_ID
                   )
       ;
	
	END DATA_SELECT_APPROVE;	

-- DATA UPDATE - STEP APPROVE.
  PROCEDURE DATA_UPDATE_APPROVE
            ( W_OT_HEADER_ID                          IN HRD_OT_HEADER.OT_HEADER_ID%TYPE
            , P_APPROVE_STATUS                        IN HRD_OT_HEADER.APPROVE_STATUS%TYPE
						, P_CHECK_YN                              IN VARCHAR2
						, P_CONNECT_PERSON_ID                     IN HRM_PERSON_MASTER.PERSON_ID%TYPE
						, P_APPROVE_FLAG                          IN VARCHAR2
						, P_SOB_ID                                IN HRD_OT_HEADER.SOB_ID%TYPE
						, P_ORG_ID                                IN HRD_OT_HEADER.ORG_ID%TYPE   
						, P_USER_ID                               IN HRD_OT_HEADER.CREATED_BY%TYPE
            )
  AS
    V_APPROVE_STATUS                                  HRD_OT_HEADER.APPROVE_STATUS%TYPE := 'N';
    V_CAP_B                                           VARCHAR2(1) := 'N';
    V_CAP_C                                           VARCHAR2(1) := 'N';
  BEGIN
    BEGIN
      SELECT HRM_MANAGER_G.USER_CAP_F
                             (OH.CORP_ID 
                             , OH.REQ_DATE
                             , OH.REQ_DATE
                             , '20'
                             , P_CONNECT_PERSON_ID
                             , OH.SOB_ID
                             , OH.ORG_ID) AS CAP_C
           , HRD_DUTY_MANAGER_G.APPROVER_CAP_F
                             ( DM.DUTY_CONTROL_ID
                             , P_CONNECT_PERSON_ID
                             , P_SOB_ID
                             , P_ORG_ID) AS CAP_B
        INTO V_CAP_C, V_CAP_B
        FROM HRD_OT_HEADER OH
          , HRD_DUTY_MANAGER DM          
      WHERE OH.DUTY_MANAGER_ID    = DM.DUTY_MANAGER_ID
        AND OH.OT_HEADER_ID       = W_OT_HEADER_ID
      ;    
    EXCEPTION WHEN OTHERS THEN
      V_CAP_B := 'N';
      V_CAP_C := 'N';
    END;
    
    IF P_CHECK_YN = 'N' THEN
      NULL;
		ELSIF P_APPROVE_STATUS = 'A' AND P_APPROVE_FLAG = 'OK' THEN
		-- 미승인 --> 1차 승인 : 승인.
      IF V_CAP_B <> 'Y' THEN
        RAISE ERRNUMS.Approval_Nothing;
      END IF;
			UPDATE HRD_OT_HEADER OH
				SET OH.APPROVED_YN                      = DECODE(P_CHECK_YN, 'Y', 'Y', OH.APPROVED_YN)
					, OH.APPROVED_DATE                    = DECODE(P_CHECK_YN, 'Y', GET_LOCAL_DATE(OH.SOB_ID), OH.APPROVED_DATE)
					--, OH.APPROVED_PERSON_ID               = DECODE(P_CHECK_YN, 'Y', P_CONNECT_PERSON_ID, OH.APPROVED_PERSON_ID)
          , OH.APPROVED_PERSON_ID               = P_CONNECT_PERSON_ID
					, OH.APPROVE_STATUS                   = DECODE(P_CHECK_YN, 'Y', 'B', OH.APPROVE_STATUS)
          , OH.EMAIL_STATUS                     = 'AR'
					, OH.LAST_UPDATE_DATE                 = GET_LOCAL_DATE(OH.SOB_ID)
					, OH.LAST_UPDATED_BY                  = P_USER_ID
     , OH.ATTRIBUTE2                       = P_CONNECT_PERSON_ID
			WHERE OH.OT_HEADER_ID                     = W_OT_HEADER_ID
			;
		
		ELSIF P_APPROVE_STATUS = 'B' AND P_APPROVE_FLAG = 'CANCEL' THEN
		-- 1차 승인 --> 미승인 : 승인 취소.
      IF V_CAP_B <> 'Y' THEN
        RAISE ERRNUMS.Approval_Nothing;
      END IF;
		  BEGIN
			-- 현재 상태.
			  SELECT OH.APPROVE_STATUS
				  INTO V_APPROVE_STATUS
				FROM HRD_OT_HEADER OH
				WHERE OH.OT_HEADER_ID                   = W_OT_HEADER_ID
				;
			EXCEPTION WHEN OTHERS THEN
			  V_APPROVE_STATUS := 'N';
			END;
			IF V_APPROVE_STATUS <> 'B' THEN
			-- 1ST 승인단계가 아니면 오류 발생.
				RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10042', '&&VALUE:=취소'));
				RETURN;
			END IF;
			
			UPDATE HRD_OT_HEADER OH
				SET OH.APPROVED_YN                      = DECODE(P_CHECK_YN, 'Y', 'N', OH.APPROVED_YN)
					, OH.APPROVED_DATE                    = DECODE(P_CHECK_YN, 'Y', NULL, OH.APPROVED_DATE)
					--, OH.APPROVED_PERSON_ID               = DECODE(P_CHECK_YN, 'Y', NULL, OH.APPROVED_PERSON_ID)
					, OH.APPROVE_STATUS                   = DECODE(P_CHECK_YN, 'Y', 'A', OH.APPROVE_STATUS)
          , OH.EMAIL_STATUS                     = 'BR'
					, OH.LAST_UPDATE_DATE                 = GET_LOCAL_DATE(OH.SOB_ID)
					, OH.LAST_UPDATED_BY                  = P_USER_ID
     , OH.ATTRIBUTE2                       = OH.APPROVED_PERSON_ID
			WHERE OH.OT_HEADER_ID                     = W_OT_HEADER_ID
			;
		
		ELSIF P_APPROVE_STATUS = 'B' AND P_APPROVE_FLAG = 'OK' AND V_CAP_C = 'C' THEN
		-- 1차 승인  --> 인사 승인: 승인.
      IF V_CAP_C <> 'C' THEN
        RAISE ERRNUMS.Approval_Nothing;
      END IF;
			UPDATE HRD_OT_HEADER OH
				SET OH.CONFIRMED_YN                     = DECODE(P_CHECK_YN, 'Y', 'Y', OH.CONFIRMED_YN)
					, OH.CONFIRMED_DATE                   = DECODE(P_CHECK_YN, 'Y', GET_LOCAL_DATE(OH.SOB_ID), OH.CONFIRMED_DATE)
					--, OH.CONFIRMED_PERSON_ID              = DECODE(P_CHECK_YN, 'Y', P_CONNECT_PERSON_ID, OH.CONFIRMED_PERSON_ID)
     , OH.CONFIRMED_PERSON_ID              = P_CONNECT_PERSON_ID
					, OH.APPROVE_STATUS                   = DECODE(P_CHECK_YN, 'Y', 'C', OH.APPROVE_STATUS)
					, OH.LAST_UPDATE_DATE                 = GET_LOCAL_DATE(OH.SOB_ID)
					, OH.LAST_UPDATED_BY                  = P_USER_ID
     , OH.ATTRIBUTE3                       = P_CONNECT_PERSON_ID
			WHERE OH.OT_HEADER_ID                     = W_OT_HEADER_ID
			;
			
			/*-- 근무 카렌다 반영 START. --*/
      UPDATE HRD_WORK_CALENDAR WC
			   SET (WC.BEFORE_OT_START
	  			   , WC.BEFORE_OT_END
   					 , WC.AFTER_OT_START
   					 , WC.AFTER_OT_END
         , WC.BREAKFAST_YN
   					 , WC.LUNCH_YN
   					 , WC.DINNER_YN
   					 , WC.MIDNIGHT_YN
   					 , WC.DANGJIK_YN
   					 , WC.ALL_NIGHT_YN
   					 , WC.LAST_UPDATE_DATE
   					 , WC.LAST_UPDATED_BY)
					 =
					 ( SELECT OL.BEFORE_OT_START
					        , OL.BEFORE_OT_END
             , OL.AFTER_OT_START
             , OL.AFTER_OT_END
             , OL.BREAKFAST_YN
             , OL.LUNCH_YN
             , OL.DINNER_YN
             , OL.MIDNIGHT_YN
             , OL.DANGJIK_YN
             , OL.ALL_NIGHT_YN
             , GET_LOCAL_DATE(OH.SOB_ID)
             , P_USER_ID
						 FROM HRD_OT_HEADER OH
						    , HRD_OT_LINE   OL
						 WHERE OH.OT_HEADER_ID       = OL.OT_HEADER_ID
						   AND OH.CORP_ID            = WC.WORK_CORP_ID
			 				 AND OH.SOB_ID             = WC.SOB_ID
				 			 AND OH.ORG_ID             = WC.ORG_ID
						   AND OH.OT_HEADER_ID       = W_OT_HEADER_ID
					 		 AND OL.WORK_DATE          = WC.WORK_DATE
						 	 AND OL.PERSON_ID          = WC.PERSON_ID
					 )
			WHERE EXISTS ( SELECT 'X'
										 FROM HRD_OT_HEADER OH
											 , HRD_OT_LINE OL
										 WHERE OH.OT_HEADER_ID       = OL.OT_HEADER_ID
											 AND OH.CORP_ID            = WC.WORK_CORP_ID
											 AND OH.SOB_ID             = WC.SOB_ID
											 AND OH.ORG_ID             = WC.ORG_ID
											 AND OL.WORK_DATE          = WC.WORK_DATE
											 AND OL.PERSON_ID          = WC.PERSON_ID
											 AND OH.OT_HEADER_ID       = W_OT_HEADER_ID											 
									 )
      ;
		  /*-- 근무 카렌다 반영 END. --*/
			
		ELSIF P_APPROVE_STATUS = 'C' AND P_APPROVE_FLAG = 'CANCEL' AND V_CAP_C = 'C' THEN
		-- 확정 승인 --> 1차 승인 : 승인 취소.
      IF V_CAP_C <> 'C' THEN
        RAISE ERRNUMS.Approval_Nothing;
      END IF;
		  BEGIN
			-- 현재 상태.
			  SELECT OH.APPROVE_STATUS
				  INTO V_APPROVE_STATUS
				FROM HRD_OT_HEADER OH
				WHERE OH.OT_HEADER_ID                     = W_OT_HEADER_ID
				;
			EXCEPTION WHEN OTHERS THEN
			  V_APPROVE_STATUS := 'N';
			END;
			IF V_APPROVE_STATUS <> 'C' THEN
			-- 1ST 승인단계가 아니면 오류 발생.
				RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10042', '&&VALUE:=취소'));
				RETURN;
			END IF;
			
			UPDATE HRD_OT_HEADER OH
				SET OH.CONFIRMED_YN                     = DECODE(P_CHECK_YN, 'Y', 'N', OH.CONFIRMED_YN)
					, OH.CONFIRMED_DATE                   = DECODE(P_CHECK_YN, 'Y', NULL, OH.CONFIRMED_DATE)
					--, OH.CONFIRMED_PERSON_ID              = DECODE(P_CHECK_YN, 'Y', NULL, OH.CONFIRMED_PERSON_ID)
					, OH.APPROVE_STATUS                   = 'B'
					, OH.LAST_UPDATE_DATE                 = GET_LOCAL_DATE(OH.SOB_ID)
					, OH.LAST_UPDATED_BY                  = P_USER_ID
     , OH.ATTRIBUTE3                       = OH.CONFIRMED_PERSON_ID
			WHERE OH.OT_HEADER_ID                     = W_OT_HEADER_ID
			;
      
			/*-- 근무 카렌다 반영 START. --*/
      UPDATE HRD_WORK_CALENDAR WC
			   SET WC.BEFORE_OT_START                 = NULL
		 		   , WC.BEFORE_OT_END                   = NULL
	 	 			 , WC.AFTER_OT_START                  = NULL
  					 , WC.AFTER_OT_END                    = NULL
        , WC.BREAKFAST_YN                    = 'N'
  					 , WC.LUNCH_YN                        = 'N'
		  			 , WC.DINNER_YN                       = 'N'
  					 , WC.MIDNIGHT_YN                     = 'N'
		  			 , WC.DANGJIK_YN                      = 'N'
				  	 , WC.ALL_NIGHT_YN                    = 'N'
					   , WC.LAST_UPDATE_DATE                = GET_LOCAL_DATE(WC.SOB_ID)
					   , WC.LAST_UPDATED_BY                 = P_USER_ID
			WHERE EXISTS ( SELECT 'X'
										 FROM HRD_OT_HEADER OH
											 , HRD_OT_LINE OL
										 WHERE OH.OT_HEADER_ID       = OL.OT_HEADER_ID
											 --AND OH.CORP_ID            = WC.CORP_ID
            AND OH.CORP_ID            = WC.WORK_CORP_ID --[2011-12-05]
											 AND OH.SOB_ID             = WC.SOB_ID
											 AND OH.ORG_ID             = WC.ORG_ID
											 AND OL.WORK_DATE          = WC.WORK_DATE
											 AND OL.PERSON_ID          = WC.PERSON_ID
											 AND OH.OT_HEADER_ID       = W_OT_HEADER_ID
									 )
      ;
		  /*-- 근무 카렌다 반영 END. --*/
		ELSE
		-- 승인단계 선택 안함.
			RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10043', '&&VALUE:=승인상태&&TEXT:=승인상태를 선택후 다시 처리하세요'));
			RETURN;
		END IF;
		COMMIT;
  EXCEPTION WHEN ERRNUMS.Approval_Nothing THEN
    RAISE_APPLICATION_ERROR(ERRNUMS.Approval_Nothing_Code, ERRNUMS.Approval_Nothing_Desc);
	END DATA_UPDATE_APPROVE;
	
		
-- DATA APPRVE_STATUS.
  PROCEDURE DATA_APPROVE_STATUS
	          ( W_OT_HEADER_ID                          IN HRD_OT_HEADER.OT_HEADER_ID%TYPE
						, O_APPROVE_STATUS                        OUT HRD_OT_HEADER.APPROVE_STATUS%TYPE
						)
  AS
	  V_APPROVE_STATUS                                  HRD_OT_HEADER.APPROVE_STATUS%TYPE := 'N';
	BEGIN
	  BEGIN
		  SELECT NVL(OH.APPROVE_STATUS, 'N') APPROVE_STATUS
			  INTO V_APPROVE_STATUS
			  FROM HRD_OT_HEADER OH
			 WHERE OH.OT_HEADER_ID                          = W_OT_HEADER_ID
			;
		EXCEPTION WHEN OTHERS THEN
		  V_APPROVE_STATUS := 'N';
		END;
	  O_APPROVE_STATUS := V_APPROVE_STATUS;
	END;	

-- DATA APPRVE_STATUS CHECK.
  FUNCTION DATA_STATUS_CHECK
	         ( W_OT_HEADER_ID                          IN HRD_OT_HEADER.OT_HEADER_ID%TYPE
					 ) RETURN VARCHAR2
  AS
	  V_APPROVE_STATUS                                  HRD_OT_HEADER.APPROVE_STATUS%TYPE := 'N';
	BEGIN
	  BEGIN
      SELECT NVL(OH.APPROVE_STATUS, 'N') AS APPROVE_STATUS
        INTO V_APPROVE_STATUS
      FROM HRD_OT_HEADER OH
      WHERE OH.OT_HEADER_ID                       = W_OT_HEADER_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_APPROVE_STATUS := 'N';
    END;
		IF V_APPROVE_STATUS IN('N', 'A', 'R') THEN
		  V_APPROVE_STATUS := 'N';
		ELSE
		  V_APPROVE_STATUS := 'Y';
		END IF;
		RETURN V_APPROVE_STATUS;
	END DATA_STATUS_CHECK;
	
					 
---------------------------------------------------------------------------------------------------
-- PROCEDURE REQ NUM SEARCH.
  PROCEDURE LU_REQ_NUM
						( P_CURSOR1                  OUT TYPES.TCURSOR1
						, W_CORP_ID                  IN HRD_OT_HEADER.CORP_ID%TYPE
						, W_STD_DATE                 IN HRD_OT_HEADER.REQ_DATE%TYPE
						, W_CONNECT_PERSON_ID        IN HRD_OT_HEADER.REQ_PERSON_ID%TYPE
						, W_SOB_ID                   IN HRD_OT_HEADER.SOB_ID%TYPE
						, W_ORG_ID                   IN HRD_OT_HEADER.ORG_ID%TYPE
						)
  AS
  BEGIN
    
    OPEN P_CURSOR1 FOR
      SELECT OH.REQ_NUM
					, OH.REQ_TYPE
					, HRM_COMMON_G.CODE_NAME_F('REQ_TYPE', OH.REQ_TYPE, OH.SOB_ID, OH.ORG_ID) REQ_TYPE_NAME
					, OH.REQ_DATE
					, OH.DUTY_MANAGER_ID
					, HRD_DUTY_MANAGER_G.MANAGER_NAME_F(OH.DUTY_MANAGER_ID) AS DUTY_MANAGER_NAME
					, OH.OT_HEADER_ID
			FROM HRD_OT_HEADER OH
			--WHERE OH.REQ_DATE                                 <= GET_LOCAL_DATE(W_SOB_ID) --W_STD_DATE
  WHERE OH.REQ_DATE                                 <= W_STD_DATE
--				AND OH.CORP_ID                                  = W_CORP_ID
				AND OH.SOB_ID                                   = W_SOB_ID
				AND OH.ORG_ID                                   = W_ORG_ID
				--AND OH.REQ_PERSON_ID                            = W_CONNECT_PERSON_ID
        AND EXISTS
              ( SELECT 'X'
                  FROM HRD_DUTY_MANAGER  DM
                WHERE DM.DUTY_MANAGER_ID    = OH.DUTY_MANAGER_ID
                  AND W_CONNECT_PERSON_ID   IN(DM.MANAGER_ID1, DM.MANAGER_ID2, DM.APPROVER_ID1, DM.APPROVER_ID2)
                  AND DM.USABLE             = 'Y'
                  AND DM.START_DATE         <= W_STD_DATE
                  AND (DM.END_DATE          >= W_STD_DATE OR DM.END_DATE IS NULL)
              )
      ORDER BY OH.OT_HEADER_ID DESC
      ;
  END LU_REQ_NUM;

-- PROCEDURE REQ NUM SEARCH.
   PROCEDURE LU_REQ_NUM2
           ( P_CURSOR1            OUT TYPES.TCURSOR1
           , W_CORP_ID            IN  HRD_OT_HEADER.CORP_ID%TYPE
           , W_STD_DATE           IN  HRD_OT_HEADER.REQ_DATE%TYPE
           , W_CONNECT_PERSON_ID  IN  HRD_OT_HEADER.REQ_PERSON_ID%TYPE
           , W_SOB_ID             IN  HRD_OT_HEADER.SOB_ID%TYPE
           , W_ORG_ID             IN  HRD_OT_HEADER.ORG_ID%TYPE
           , W_FLOOR_ID           IN  HRM_PERSON_MASTER.FLOOR_ID%TYPE
           )
   AS

           V_CONNECT_PERSON_ID        HRD_DUTY_MANAGER.MANAGER_ID1%TYPE;
           V_REQUEST_DATE_FR          HRD_OT_HEADER.REQ_DATE%TYPE;
           V_REQUEST_DATE_TO          HRD_OT_HEADER.REQ_DATE%TYPE;

   BEGIN
           -- 권한 체크 여부.
           IF HRM_MANAGER_G.USER_CAP_F( W_CORP_ID     => W_CORP_ID
                                      , W_START_DATE  => W_STD_DATE
                                      , W_END_DATE    => W_STD_DATE
                                      , W_MODULE_CODE => '20'
                                      , W_PERSON_ID   => W_CONNECT_PERSON_ID
                                      , W_SOB_ID      => W_SOB_ID
                                      , W_ORG_ID      => W_ORG_ID) = 'C' THEN
               V_CONNECT_PERSON_ID := NULL;
           ELSE
               V_CONNECT_PERSON_ID := W_CONNECT_PERSON_ID;
           END IF;
--RAISE_APPLICATION_ERROR(-20001, W_CORP_ID || '/' || W_STD_DATE || ',' || W_CONNECT_PERSON_ID || '/' || V_CONNECT_PERSON_ID || '/' || W_SOB_ID || '/' || W_ORG_ID);
    
           V_REQUEST_DATE_FR := TRUNC(W_STD_DATE, 'MONTH');
           V_REQUEST_DATE_TO := LAST_DAY(W_STD_DATE);

/*
           OPEN P_CURSOR1 FOR
           SELECT R_NUM.REQ_NUM
                , R_NUM.REQ_TYPE
                , R_NUM.REQ_TYPE_NAME
                , R_NUM.REQ_DATE
                , R_NUM.WORK_DATE
                , R_NUM.DUTY_MANAGER_ID
                , R_NUM.DUTY_MANAGER_NAME
                , R_NUM.OT_HEADER_ID
             FROM (SELECT OH.REQ_NUM
                        , OH.REQ_TYPE
                        , HRM_COMMON_G.CODE_NAME_F('REQ_TYPE', OH.REQ_TYPE, OH.SOB_ID, OH.ORG_ID) REQ_TYPE_NAME
                        , OH.REQ_DATE
                        , (SELECT OL.WORK_DATE
                             FROM HRD_OT_LINE OL
                            WHERE OL.OT_HEADER_ID = OH.OT_HEADER_ID
                              AND ROWNUM = 1
                          ) AS WORK_DATE
                        , OH.DUTY_MANAGER_ID
                        , HRD_DUTY_MANAGER_G.MANAGER_NAME_F(OH.DUTY_MANAGER_ID) AS DUTY_MANAGER_NAME
                        , OH.OT_HEADER_ID
                     FROM HRD_OT_HEADER     OH
                        , HRD_DUTY_MANAGER  DM
                    WHERE OH.DUTY_MANAGER_ID    =  DM.DUTY_MANAGER_ID
                      --AND OH.REQ_DATE          <= GET_LOCAL_DATE(W_SOB_ID) --W_STD_DATE
                      --AND OH.REQ_DATE             BETWEEN V_REQUEST_DATE_FR AND V_REQUEST_DATE_TO
                      AND OH.CORP_ID            = W_CORP_ID
                      AND DM.DUTY_CONTROL_ID    =  NVL(W_FLOOR_ID, DM.DUTY_CONTROL_ID)
                      AND OH.SOB_ID             = W_SOB_ID
                      AND OH.ORG_ID             = W_ORG_ID
                      AND OH.REQ_PERSON_ID      = NVL(V_CONNECT_PERSON_ID, OH.REQ_PERSON_ID)
                  ) R_NUM
            WHERE R_NUM.WORK_DATE    BETWEEN V_REQUEST_DATE_FR AND V_REQUEST_DATE_TO
         ORDER BY R_NUM.OT_HEADER_ID DESC
                ;
*/


--[2011-10-26]
           OPEN P_CURSOR1 FOR
           SELECT R_NUM.REQ_NUM
                , R_NUM.REQ_TYPE
                , R_NUM.REQ_TYPE_NAME
                , R_NUM.REQ_DATE
                , R_NUM.WORK_DATE
                , R_NUM.DUTY_MANAGER_ID
                , R_NUM.DUTY_MANAGER_NAME
                , R_NUM.APPROVE_STATUS_NAME
                , R_NUM.OT_HEADER_ID
             FROM (SELECT OH.REQ_NUM
                        , OH.REQ_TYPE
                        , HRM_COMMON_G.CODE_NAME_F('REQ_TYPE', OH.REQ_TYPE, OH.SOB_ID, OH.ORG_ID) REQ_TYPE_NAME
                        , OH.REQ_DATE
                        , NVL(TO_DATE(OH.ATTRIBUTE1, 'YYYY-MM-DD'), OH.REQ_DATE) AS WORK_DATE
                        , OH.DUTY_MANAGER_ID
                        , HRD_DUTY_MANAGER_G.MANAGER_NAME_F(OH.DUTY_MANAGER_ID) AS DUTY_MANAGER_NAME
					              , HRM_COMMON_G.CODE_NAME_F('DUTY_APPROVE_STATUS', OH.APPROVE_STATUS, OH.SOB_ID, OH.ORG_ID) AS APPROVE_STATUS_NAME
                        , OH.OT_HEADER_ID
                     FROM HRD_OT_HEADER     OH
                        , HRD_DUTY_MANAGER  DM
                    WHERE OH.DUTY_MANAGER_ID    =  DM.DUTY_MANAGER_ID
--                      AND OH.CORP_ID            = W_CORP_ID
                      AND DM.DUTY_CONTROL_ID    =  NVL(W_FLOOR_ID, DM.DUTY_CONTROL_ID)
                      AND OH.SOB_ID             = W_SOB_ID
                      AND OH.ORG_ID             = W_ORG_ID
                      AND NVL(V_CONNECT_PERSON_ID, DM.MANAGER_ID1) IN (DM.MANAGER_ID1, DM.MANAGER_ID2, DM.APPROVER_ID1, DM.APPROVER_ID2)
--                      AND OH.REQ_PERSON_ID      = NVL(V_CONNECT_PERSON_ID, OH.REQ_PERSON_ID)
                  ) R_NUM
            WHERE R_NUM.WORK_DATE    BETWEEN V_REQUEST_DATE_FR AND V_REQUEST_DATE_TO
         ORDER BY R_NUM.OT_HEADER_ID DESC
                ;


   END LU_REQ_NUM2;



-----------------------------------------------------------------------------------------
-- [2011-10-31]
-- 연장근무 반려 처리를 위한 조회.
   PROCEDURE OT_HEADER_RETURN_SELECT
           ( P_CURSOR1            OUT TYPES.TCURSOR1
           , W_CORP_ID            IN HRD_OT_HEADER.CORP_ID%TYPE
           , W_START_DATE         IN HRD_OT_HEADER.REQ_DATE%TYPE
					     	, W_END_DATE           IN HRD_OT_HEADER.REQ_DATE%TYPE
				     		, W_APPROVE_STATUS     IN HRD_OT_HEADER.APPROVE_STATUS%TYPE
           , W_OT_HEADER_ID       IN HRD_OT_HEADER.OT_HEADER_ID%TYPE
					     	, W_DUTY_MANAGER_ID    IN HRD_OT_HEADER.DUTY_MANAGER_ID%TYPE
           , W_CONNECT_PERSON_ID  IN HRM_PERSON_MASTER.PERSON_ID%TYPE
           , W_SOB_ID             IN HRD_OT_HEADER.SOB_ID%TYPE
		     				, W_ORG_ID             IN HRD_OT_HEADER.ORG_ID%TYPE   
						)
  AS
           V_CONNECT_PERSON_ID       HRM_PERSON_MASTER.PERSON_ID%TYPE := NULL;
	BEGIN
    -- 근태권한 설정.
  		IF HRM_MANAGER_G.USER_CAP_F( W_CORP_ID => W_CORP_ID 
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

    IF W_APPROVE_STATUS IN('A') THEN
       V_CONNECT_PERSON_ID := W_CONNECT_PERSON_ID;
    END IF;
    
	   OPEN P_CURSOR1 FOR
      SELECT  'N' AS SELECT_YN
            , OH.REJECT_REMARK
            , OH.REQ_NUM
						, HRM_COMMON_G.CODE_NAME_F('REQ_TYPE', OH.REQ_TYPE, OH.SOB_ID, OH.ORG_ID) AS REQ_TYPE_NAME
						, OH.REQ_DATE
						, HRD_DUTY_MANAGER_G.MANAGER_NAME_F(OH.DUTY_MANAGER_ID) AS DUTY_MANAGER_NAME
						, HRM_PERSON_MASTER_G.NAME_F(OH.REQ_PERSON_ID) AS REQ_PERSON_NAME
						, HRM_COMMON_G.CODE_NAME_F('DUTY_APPROVE_STATUS', OH.APPROVE_STATUS, OH.SOB_ID, OH.ORG_ID) AS APPROVE_STATUS_NAME
            , OH.APPROVED_YN
            , HRM_PERSON_MASTER_G.NAME_F(OH.APPROVED_PERSON_ID) AS APPROVED_PERSON_NAME
						, HRM_PERSON_MASTER_G.NAME_F(OH.CONFIRMED_PERSON_ID) AS CONFIRMED_PERSON_NAME						
						, OH.DESCRIPTION
						, OH.OT_HEADER_ID
				FROM  HRD_OT_HEADER OH
			 WHERE  OH.OT_HEADER_ID                       = NVL(W_OT_HEADER_ID, OH.OT_HEADER_ID)
			   AND  OH.CORP_ID                            = W_CORP_ID
				 --AND  OH.REQ_DATE                           BETWEEN W_START_DATE AND W_END_DATE
     AND OH.ATTRIBUTE1          BETWEEN TO_CHAR(W_START_DATE, 'YYYY-MM-DD') AND TO_CHAR(W_END_DATE, 'YYYY-MM-DD')
				 AND  OH.DUTY_MANAGER_ID                    = NVL(W_DUTY_MANAGER_ID, OH.DUTY_MANAGER_ID)
				 AND  OH.APPROVE_STATUS                     = NVL(W_APPROVE_STATUS, OH.APPROVE_STATUS)
         AND EXISTS (SELECT 'X'
                      FROM HRD_DUTY_MANAGER DM
                      WHERE DM.CORP_ID                                = OH.CORP_ID
                       AND DM.DUTY_MANAGER_ID                         = OH.DUTY_MANAGER_ID
                       AND (NVL(V_CONNECT_PERSON_ID, DM.APPROVER_ID1) IN(DM.MANAGER_ID1, DM.MANAGER_ID2, DM.APPROVER_ID1, DM.APPROVER_ID2))
                       AND DM.START_DATE                              <= W_END_DATE
                       AND (DM.END_DATE IS NULL OR DM.END_DATE        >= W_START_DATE)
                       AND DM.SOB_ID                                  = OH.SOB_ID
                       AND DM.ORG_ID                                  = OH.ORG_ID
                   )
       ORDER BY OH.REQ_NUM
       ;
  END OT_HEADER_RETURN_SELECT;

-- 연장근무 반려 처리.
  PROCEDURE OT_HEADER_RETURN_UPDATE
	          ( W_OT_HEADER_ID                          IN HRD_OT_HEADER.OT_HEADER_ID%TYPE
            , P_REJECT_REMARK                         IN HRD_OT_HEADER.REJECT_REMARK%TYPE
            , P_APPROVE_STATUS                        IN HRD_OT_HEADER.APPROVE_STATUS%TYPE
						, P_CONNECT_PERSON_ID                     IN HRM_PERSON_MASTER.PERSON_ID%TYPE
						, P_SOB_ID                                IN HRD_OT_HEADER.SOB_ID%TYPE
						, P_ORG_ID                                IN HRD_OT_HEADER.ORG_ID%TYPE   
						)
  AS

    V_CAP_B                                           VARCHAR2(1) := 'N';
    V_CAP_C                                           VARCHAR2(1) := 'N';

  BEGIN
    BEGIN
      SELECT HRM_MANAGER_G.USER_CAP_F
                             (OH.CORP_ID 
                             , OH.REQ_DATE
                             , OH.REQ_DATE
                             , '20'
                             , P_CONNECT_PERSON_ID
                             , OH.SOB_ID
                             , OH.ORG_ID) AS CAP_C
           , HRD_DUTY_MANAGER_G.APPROVER_CAP_F
                             ( DM.DUTY_CONTROL_ID
                             , P_CONNECT_PERSON_ID
                             , P_SOB_ID
                             , P_ORG_ID) AS CAP_B
        INTO V_CAP_C, V_CAP_B
        FROM HRD_OT_HEADER OH
          , HRD_DUTY_MANAGER DM          
      WHERE OH.DUTY_MANAGER_ID    = DM.DUTY_MANAGER_ID
        AND OH.OT_HEADER_ID       = W_OT_HEADER_ID
      ;    
    EXCEPTION WHEN OTHERS THEN
      V_CAP_B := 'N';
      V_CAP_C := 'N';
    END;
    
    IF P_APPROVE_STATUS IN('A', 'B') THEN
		-- 미승인 --> 1차 승인 : 승인.
      IF V_CAP_B <> 'Y' THEN
        RAISE ERRNUMS.Approval_Nothing;
      END IF;
		ELSIF P_APPROVE_STATUS IN('B', 'C') THEN
		-- 1차 승인  --> 인사 승인: 승인.
      IF V_CAP_C <> 'C' THEN
        RAISE ERRNUMS.Approval_Nothing;
      END IF;
		ELSE
		-- 승인단계 선택 안함.
			RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10043', '&&VALUE:=승인상태&&TEXT:=승인상태를 선택후 다시 처리하세요'));
			RETURN;
		END IF;
    
    UPDATE HRD_OT_HEADER OH
      SET OH.REJECT_REMARK                    = P_REJECT_REMARK
        , OH.REJECT_YN                        = 'Y'
        , OH.REJECT_DATE                      = GET_LOCAL_DATE(OH.SOB_ID)
        , OH.REJECT_PERSON_ID                 = P_CONNECT_PERSON_ID
        , OH.APPROVE_STATUS                   = 'R'
        , OH.EMAIL_STATUS                     = 'RR'
        , OH.ATTRIBUTE4                       = P_CONNECT_PERSON_ID
    WHERE OH.OT_HEADER_ID                     = W_OT_HEADER_ID
    ;
		COMMIT;
  EXCEPTION WHEN ERRNUMS.Approval_Nothing THEN
    RAISE_APPLICATION_ERROR(ERRNUMS.Approval_Nothing_Code, ERRNUMS.Approval_Nothing_Desc);
  END OT_HEADER_RETURN_UPDATE;

-----------------------------------------------------------------------------------------


   PROCEDURE SELECT_OT_HEADER_APPROVE
           ( P_CURSOR              OUT  TYPES.TCURSOR
           , W_CORP_ID             IN   HRD_OT_HEADER.CORP_ID%TYPE
           , W_WORK_DATE_FR        IN   HRD_OT_HEADER.REQ_DATE%TYPE
           , W_WORK_DATE_TO        IN   HRD_OT_HEADER.REQ_DATE%TYPE
           , W_APPROVE_STATUS      IN   HRD_OT_HEADER.APPROVE_STATUS%TYPE
           , W_OT_HEADER_ID        IN   HRD_OT_HEADER.OT_HEADER_ID%TYPE
           , W_DUTY_MANAGER_ID     IN   HRD_OT_HEADER.DUTY_MANAGER_ID%TYPE
           , W_CONNECT_PERSON_ID   IN   HRM_PERSON_MASTER.PERSON_ID%TYPE
           , W_SOB_ID              IN   HRD_OT_HEADER.SOB_ID%TYPE
           , W_ORG_ID              IN   HRD_OT_HEADER.ORG_ID%TYPE
           )

   AS

           V_CONNECT_PERSON_ID          HRM_PERSON_MASTER.PERSON_ID%TYPE := NULL;

   BEGIN
          -- 근태권한 설정.
          IF HRM_MANAGER_G.USER_CAP_F( W_CORP_ID     => W_CORP_ID
                                     , W_START_DATE  => W_WORK_DATE_FR
                                     , W_END_DATE    => W_WORK_DATE_TO
                                     , W_MODULE_CODE => '20'
                                     , W_PERSON_ID   => W_CONNECT_PERSON_ID
                                     , W_SOB_ID      => W_SOB_ID
                                     , W_ORG_ID      => W_ORG_ID) = 'C' THEN
             V_CONNECT_PERSON_ID := NULL;
          ELSE
             V_CONNECT_PERSON_ID := W_CONNECT_PERSON_ID;
          END IF;

          IF W_APPROVE_STATUS IN('A') THEN
             V_CONNECT_PERSON_ID := W_CONNECT_PERSON_ID;
          END IF;

           OPEN P_CURSOR FOR
           SELECT 'N' AS APPROVE_YN
                , OH.REQ_NUM
                , OH.REQ_TYPE
                , HRM_COMMON_G.CODE_NAME_F('REQ_TYPE', OH.REQ_TYPE, OH.SOB_ID, OH.ORG_ID) AS REQ_TYPE_NAME
                , OH.REQ_DATE
                , OH.CORP_ID
                , OH.DUTY_MANAGER_ID
                , HRD_DUTY_MANAGER_G.MANAGER_NAME_F(OH.DUTY_MANAGER_ID) AS DUTY_MANAGER_NAME
                , OH.REQ_PERSON_ID
                , HRM_PERSON_MASTER_G.NAME_F(OH.REQ_PERSON_ID)          AS REQ_PERSON_NAME
                , OH.APPROVED_YN
                , OH.APPROVED_PERSON_ID
                , HRM_PERSON_MASTER_G.NAME_F(OH.APPROVED_PERSON_ID)     AS APPROVED_PERSON_NAME
                , OH.CONFIRMED_YN
                , OH.CONFIRMED_PERSON_ID
                , HRM_PERSON_MASTER_G.NAME_F(OH.CONFIRMED_PERSON_ID)    AS CONFIRMED_PERSON_NAME
                , OH.APPROVE_STATUS
                , HRM_COMMON_G.CODE_NAME_F('DUTY_APPROVE_STATUS', OH.APPROVE_STATUS, OH.SOB_ID, OH.ORG_ID) AS APPROVE_STATUS_NAME
                , OH.CALENDAR_TRAN_YN
                , OH.REJECT_REMARK
                , OH.DESCRIPTION
                , OH.OT_HEADER_ID
                , OH.REJECT_YN
                , DECODE(OH.REJECT_YN, 'Y', OH.REJECT_DATE, NULL) ASREJECT_DATE
                , DECODE(OH.REJECT_YN, 'Y', HRM_PERSON_MASTER_G.NAME_F(OH.REJECT_PERSON_ID), NULL) AS REJECT_PERSON_NAME
            FROM  HRD_OT_HEADER          OH
            WHERE OH.OT_HEADER_ID     =  NVL(W_OT_HEADER_ID, OH.OT_HEADER_ID)
              AND OH.CORP_ID          =  W_CORP_ID
              --AND OH.REQ_DATE            BETWEEN W_WORK_DATE_FR AND W_END_DATE
              AND OH.ATTRIBUTE1          BETWEEN TO_CHAR(W_WORK_DATE_FR, 'YYYY-MM-DD') AND TO_CHAR(W_WORK_DATE_TO, 'YYYY-MM-DD')
              AND OH.DUTY_MANAGER_ID  =  NVL(W_DUTY_MANAGER_ID, OH.DUTY_MANAGER_ID)
              AND OH.APPROVE_STATUS   =  NVL(W_APPROVE_STATUS, OH.APPROVE_STATUS)
              AND EXISTS (SELECT 'X'
                            FROM HRD_DUTY_MANAGER DM
                            WHERE DM.CORP_ID                                  = OH.CORP_ID
                              AND DM.DUTY_MANAGER_ID                          = OH.DUTY_MANAGER_ID
                              AND (NVL(V_CONNECT_PERSON_ID, DM.APPROVER_ID1) IN(DM.MANAGER_ID1, DM.MANAGER_ID2, DM.APPROVER_ID1, DM.APPROVER_ID2))
                              AND DM.START_DATE                              <= W_WORK_DATE_TO
                              AND (DM.END_DATE IS NULL OR DM.END_DATE        >= W_WORK_DATE_FR)
                              AND DM.SOB_ID                                   = OH.SOB_ID
                              AND DM.ORG_ID                                   = OH.ORG_ID
                         )
         ORDER BY OH.REQ_NUM
                ;

   END SELECT_OT_HEADER_APPROVE;



--CAPACITY GET[2011-12-12]
  PROCEDURE GET_CAPACITY
          ( O_CAPACITY_C         OUT VARCHAR2
          , W_SOB_ID             IN  HRM_PERSON_MASTER.SOB_ID%TYPE
          , W_ORG_ID             IN  HRM_PERSON_MASTER.ORG_ID%TYPE
          , W_CORP_ID            IN  HRM_PERSON_MASTER.CORP_ID%TYPE
          , W_CONNECT_PERSON_ID  IN  HRM_PERSON_MASTER.PERSON_ID%TYPE
          )
  AS

  BEGIN

            SELECT HM.CAPACITY_LEVEL
              INTO O_CAPACITY_C
              FROM HRM_MANAGER HM
             WHERE HM.USABLE       = 'Y'
               AND HM.MODULE_CODE  =  '20'
               AND HM.SOB_ID       =  W_SOB_ID
               AND HM.ORG_ID       =  W_ORG_ID
               AND HM.CORP_ID      =  W_CORP_ID
               AND HM.PERSON_ID    =  W_CONNECT_PERSON_ID
                 ;

  EXCEPTION
       WHEN OTHERS
       THEN
            O_CAPACITY_C := 'N';

  END GET_CAPACITY;


--REQUEST_LIMIT GET[2011-12-12]
  PROCEDURE GET_REQUEST_LIMIT
          ( O_REQUEST_LIMIT_COUNT  OUT HRM_COMMON.VALUE1%TYPE
          , W_SOB_ID               IN  HRM_COMMON.SOB_ID%TYPE
          , W_ORG_ID               IN  HRM_COMMON.ORG_ID%TYPE
          , W_CODE                 IN  HRM_COMMON.CODE%TYPE
          )
  AS

  BEGIN
            SELECT C.VALUE1
              INTO O_REQUEST_LIMIT_COUNT
              FROM HRM_COMMON C
             WHERE C.SOB_ID     = W_SOB_ID
               AND C.ORG_ID     = W_ORG_ID
               AND C.GROUP_CODE = 'REQUEST_LIMIT'
               AND C.CODE       = W_CODE
                 ;

  EXCEPTION
       WHEN OTHERS
       THEN
            O_REQUEST_LIMIT_COUNT := NULL;

  END GET_REQUEST_LIMIT;



END HRD_OT_HEADER_G;
/
