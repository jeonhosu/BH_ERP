CREATE OR REPLACE PACKAGE HRM_CLOSING_G
AS

-- HRM_CLOSING SELECT.
  PROCEDURE DATA_SELECT(P_CURSOR                                      OUT TYPES.TCURSOR
											, W_CORP_ID                                     IN NUMBER
											, W_CLOSING_YYYYMM                              IN VARCHAR2
											, W_CLOSING_TYPE_ID                             IN NUMBER
											, W_SOB_ID                                      IN NUMBER
											, W_ORG_ID                                      IN NUMBER);

-- HRM_CLOSING INSERT..
  PROCEDURE DATA_INSERT(P_CORP_ID                                     IN NUMBER
											, P_CLOSING_YYYYMM                              IN VARCHAR2
											, P_CLOSING_TYPE_ID                             IN NUMBER
											, P_CLOSING_YN                                  IN VARCHAR2
											, P_OPEN_DATE                                   IN DATE
											, P_DESCRIPTION                                 IN VARCHAR2
											, P_SOB_ID                                      IN NUMBER
											, P_ORG_ID                                      IN NUMBER
											, P_USER_ID                                     IN NUMBER);

-- HRM_CLOSING UPDATE..
  PROCEDURE DATA_UPDATE(W_CORP_ID                                     IN NUMBER
											, W_CLOSING_YYYYMM                              IN VARCHAR2
											, W_CLOSING_TYPE_ID                             IN NUMBER
											, P_CLOSING_YN                                  IN VARCHAR2
											, P_OPEN_DATE                                   IN DATE
											, P_DESCRIPTION                                 IN VARCHAR2
											, P_USER_ID                                     IN NUMBER);

-- HRM_CLOSING DELETE..
  PROCEDURE DATA_DELETE(W_CORP_ID                                     IN NUMBER
											, W_CLOSING_YYYYMM                              IN VARCHAR2
											, W_CLOSING_TYPE_ID                             IN NUMBER);
										
-- HRM_CLOSING CREATE..
  PROCEDURE CLOSING_CREATE(P_CORP_ID                                  IN NUMBER
											   , P_CLOSING_YYYYMM                           IN VARCHAR2
												 , P_SOB_ID                                   IN NUMBER
												 , P_ORG_ID                                   IN NUMBER
											   , P_USER_ID                                  IN NUMBER
												 , O_MESSAGE                                  OUT VARCHAR2);


-- CLOSING CHECK.
  FUNCTION CLOSING_CHECK
	         ( W_CORP_ID                          IN HRM_CLOSING.CORP_ID%TYPE
					 , W_CLOSING_YYYYMM                   IN HRM_CLOSING.CLOSING_YYYYMM%TYPE
					 , W_CLOSING_TYPE_ID                  IN HRM_CLOSING.CLOSING_TYPE_ID%TYPE DEFAULT 0
					 , W_CLOSING_TYPE                     IN HRM_CLOSING_TYPE_V.CLOSING_TYPE%TYPE DEFAULT NULL
					 , W_SOB_ID                           IN HRM_CLOSING.SOB_ID%TYPE
					 , W_ORG_ID                           IN HRM_CLOSING.ORG_ID%TYPE
					 ) RETURN VARCHAR2;

-- CLOSING CHECK : CLOSING_TYPE.
  FUNCTION CLOSING_CHECK_W
	         ( W_CORP_ID                             IN HRM_CLOSING.CORP_ID%TYPE
					 , W_CLOSING_YYYYMM                      IN HRM_CLOSING.CLOSING_YYYYMM%TYPE
					 , W_CLOSING_TYPE                        IN HRM_CLOSING_TYPE_V.CLOSING_TYPE%TYPE
					 , W_SOB_ID                              IN HRM_CLOSING.SOB_ID%TYPE
					 , W_ORG_ID                              IN HRM_CLOSING.ORG_ID%TYPE
					 ) RETURN VARCHAR2;
           
-- CLOSING CHECK : VALUE2.
  FUNCTION CLOSING_CHECK_W2
	         ( W_CORP_ID                             IN HRM_CLOSING.CORP_ID%TYPE
					 , W_CLOSING_YYYYMM                      IN HRM_CLOSING.CLOSING_YYYYMM%TYPE
					 , W_PERIOD_TYPE                         IN HRM_COMMON.VALUE2%TYPE
					 , W_SOB_ID                              IN HRM_CLOSING.SOB_ID%TYPE
					 , W_ORG_ID                              IN HRM_CLOSING.ORG_ID%TYPE
					 ) RETURN VARCHAR2;
           
END HRM_CLOSING_G;
/
CREATE OR REPLACE PACKAGE BODY HRM_CLOSING_G
AS

-- HRM_CLOSING SELECT.
  PROCEDURE DATA_SELECT(P_CURSOR                                      OUT TYPES.TCURSOR
											, W_CORP_ID                                     IN NUMBER
											, W_CLOSING_YYYYMM                              IN VARCHAR2
											, W_CLOSING_TYPE_ID                             IN NUMBER
											, W_SOB_ID                                      IN NUMBER
											, W_ORG_ID                                      IN NUMBER)
  AS
  BEGIN
		OPEN P_CURSOR FOR
			SELECT HC.CORP_ID
					, CM.CORP_NAME
					, HC.CLOSING_YYYYMM
					, HC.CLOSING_TYPE_ID
					, HRM_COMMON_G.ID_NAME_F(HC.CLOSING_TYPE_ID) CLOSING_TYPE_NAME
					, HC.CLOSING_YN
					, HC.OPEN_DATE
					, HC.DESCRIPTION
			FROM HRM_CLOSING HC
				, HRM_CORP_MASTER CM
			WHERE HC.CORP_ID                                 = CM.CORP_ID
				AND HC.CORP_ID                                 = W_CORP_ID
				AND HC.CLOSING_YYYYMM                          = W_CLOSING_YYYYMM
				AND HC.CLOSING_TYPE_ID                         = NVL(W_CLOSING_TYPE_ID, HC.CLOSING_TYPE_ID)
				AND HC.SOB_ID                                  = W_SOB_ID
				AND HC.ORG_ID                                  = W_ORG_ID                                     
			;

  END DATA_SELECT;


-- HRM_CLOSING INSERT.
  PROCEDURE DATA_INSERT(P_CORP_ID                                     IN NUMBER
											, P_CLOSING_YYYYMM                              IN VARCHAR2
											, P_CLOSING_TYPE_ID                             IN NUMBER
											, P_CLOSING_YN                                  IN VARCHAR2
											, P_OPEN_DATE                                   IN DATE
											, P_DESCRIPTION                                 IN VARCHAR2
											, P_SOB_ID                                      IN NUMBER
											, P_ORG_ID                                      IN NUMBER
											, P_USER_ID                                     IN NUMBER)
  AS
    D_SYSDATE                                                         DATE;
		
  BEGIN
	  D_SYSDATE := GET_LOCAL_DATE(P_SOB_ID);
				
		INSERT INTO HRM_CLOSING
		(CORP_ID, CLOSING_YYYYMM, CLOSING_TYPE_ID
		, CLOSING_YN, OPEN_DATE, DESCRIPTION
		, SOB_ID, ORG_ID
		, CREATION_DATE, CREATED_BY, LAST_UPDATE_DATE, LAST_UPDATED_BY
		) VALUES
		(P_CORP_ID, P_CLOSING_YYYYMM, P_CLOSING_TYPE_ID
		, P_CLOSING_YN, P_OPEN_DATE, P_DESCRIPTION
		, P_SOB_ID, P_ORG_ID
		, D_SYSDATE, P_USER_ID, D_SYSDATE, P_USER_ID
		);
		COMMIT;

  END DATA_INSERT;

-- HRM_CLOSING UPDATE.
  PROCEDURE DATA_UPDATE(W_CORP_ID                                     IN NUMBER
											, W_CLOSING_YYYYMM                              IN VARCHAR2
											, W_CLOSING_TYPE_ID                             IN NUMBER
											, P_CLOSING_YN                                  IN VARCHAR2
											, P_OPEN_DATE                                   IN DATE
											, P_DESCRIPTION                                 IN VARCHAR2
											, P_USER_ID                                     IN NUMBER)
  AS
	  V_PERIOD_TYPE                HRM_CLOSING_TYPE_V.PERIOD_TYPE%TYPE;
		V_DUTY_TYPE                  HRD_MONTH_TOTAL.DUTY_TYPE%TYPE;
		V_SOB_ID                     HRD_MONTH_TOTAL.SOB_ID%TYPE;
		V_ORG_ID                     HRD_MONTH_TOTAL.ORG_ID%TYPE;
		V_CLOSED_PERSON_ID           HRD_MONTH_TOTAL.CLOSED_PERSON_ID%TYPE;
		
  BEGIN

      UPDATE HRM_CLOSING HC
        SET HC.CLOSING_YN                                             = P_CLOSING_YN
              , HC.OPEN_DATE                                          = P_OPEN_DATE
              , HC.DESCRIPTION                                        = P_DESCRIPTION
              , HC.LAST_UPDATE_DATE                                   = GET_LOCAL_DATE(HC.SOB_ID)
              , HC.LAST_UPDATED_BY                                    = P_USER_ID
      WHERE HC.CORP_ID                                                = W_CORP_ID
        AND HC.CLOSING_YYYYMM                                         = W_CLOSING_YYYYMM
        AND HC.CLOSING_TYPE_ID                                        = W_CLOSING_TYPE_ID
      ;
			
			-- 마감 정보.
			BEGIN
			  SELECT CT.MODULE_TYPE || '.' || CT.PERIOD_TYPE AS MODULT_PERIOD_TYPE
				     , CT.CLOSING_TYPE, CT.SOB_ID, CT.ORG_ID
				  INTO V_PERIOD_TYPE
					   , V_DUTY_TYPE, V_SOB_ID, V_ORG_ID
				  FROM HRM_CLOSING_TYPE_V CT
				 WHERE CT.CLOSING_TYPE_ID       = W_CLOSING_TYPE_ID
				;
			EXCEPTION WHEN OTHERS THEN
			  ROLLBACK;
			  RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10062', NULL));
			END;
			-- 현재 접속자.
			BEGIN
			  SELECT EU.PERSON_ID
				  INTO V_CLOSED_PERSON_ID
					FROM EAPP_USER EU
				 WHERE EU.USER_ID               = P_USER_ID
				;
			EXCEPTION WHEN OTHERS THEN
			  ROLLBACK;
			  RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10061', NULL));
			END;
			--// 마감 처리시 해당 모듈의 TABLE의 값 변경 적용. //--
			IF V_PERIOD_TYPE = 'DUTY.MONTH' THEN
			  IF P_CLOSING_YN = 'Y' THEN
				  HRD_MONTH_TOTAL_G.DATA_CLOSE_PROC( W_DUTY_TYPE => V_DUTY_TYPE
					                                 , W_DUTY_YYYYMM => W_CLOSING_YYYYMM
																					 , W_CORP_ID => W_CORP_ID
																					 , W_CONNECT_PERSON_ID => V_CLOSED_PERSON_ID 
																					 , W_SOB_ID => V_SOB_ID
																					 , W_ORG_ID => V_ORG_ID
																					 );
				ELSE
				  HRD_MONTH_TOTAL_G.DATA_CLOSE_CANCEL( W_DUTY_TYPE => V_DUTY_TYPE
					                                   , W_DUTY_YYYYMM => W_CLOSING_YYYYMM
																						 , W_CORP_ID => W_CORP_ID
																						 , W_SOB_ID => V_SOB_ID
																						 , W_ORG_ID => V_ORG_ID
																						 );
				END IF;
			ELSE
			  NULL;
			END IF;
      COMMIT;
			
  END DATA_UPDATE;

-- HRM_CLOSING DELETE..
  PROCEDURE DATA_DELETE(W_CORP_ID                                     IN NUMBER
											, W_CLOSING_YYYYMM                              IN VARCHAR2
											, W_CLOSING_TYPE_ID                             IN NUMBER)
  AS
	BEGIN
	  DELETE HRM_CLOSING HC
     WHERE HC.CORP_ID                                                 = W_CORP_ID
       AND HC.CLOSING_YYYYMM                                          = W_CLOSING_YYYYMM
       AND HC.CLOSING_TYPE_ID                                         = W_CLOSING_TYPE_ID
    ;
    COMMIT;
	
	END DATA_DELETE;
											
-- HRM_CLOSING CREATE..
  PROCEDURE CLOSING_CREATE(P_CORP_ID                                     IN NUMBER
											   , P_CLOSING_YYYYMM                              IN VARCHAR2
												 , P_SOB_ID                                      IN NUMBER
												 , P_ORG_ID                                      IN NUMBER
											   , P_USER_ID                                     IN NUMBER
												 , O_MESSAGE                                     OUT VARCHAR2)
  AS
    V_MESSAGE                                                            VARCHAR2(250);
		
	BEGIN
	  -- 기존 자료 삭제.
	  BEGIN
			DELETE HRM_CLOSING HC
			 WHERE HC.CORP_ID                                                 = P_CORP_ID
				 AND HC.CLOSING_YYYYMM                                          = P_CLOSING_YYYYMM
			;
		EXCEPTION WHEN OTHERS THEN
		  V_MESSAGE := 'CLOSING CREATE ERROR : ' || TO_CHAR(SQLCODE) || SUBSTR(SQLERRM, 1, 150);
			O_MESSAGE := V_MESSAGE;
			RETURN;
		END;
		
		-- 생성.
	  BEGIN
			INSERT INTO HRM_CLOSING
			(CORP_ID, CLOSING_YYYYMM
			, CLOSING_TYPE_ID
			, CLOSING_YN, OPEN_DATE
			, SOB_ID, ORG_ID
			, CREATION_DATE, CREATED_BY, LAST_UPDATE_DATE, LAST_UPDATED_BY)
			SELECT P_CORP_ID, P_CLOSING_YYYYMM
					, HC.COMMON_ID CLOSING_TYPE_ID
					, 'N' CLOSING_YN, NULL OPEN_DATE
					, P_SOB_ID, P_ORG_ID
					, GET_LOCAL_DATE(P_SOB_ID), P_USER_ID, GET_LOCAL_DATE(P_SOB_ID), P_USER_ID
			FROM HRM_COMMON HC
			WHERE HC.GROUP_CODE            = 'CLOSING_TYPE'
        AND HC.SOB_ID                = P_SOB_ID
				AND HC.ORG_ID                = P_ORG_ID
        AND HC.ENABLED_FLAG          = 'Y'
				AND HC.EFFECTIVE_DATE_FR     <= GET_LOCAL_DATE(P_SOB_ID)
				AND (HC.EFFECTIVE_DATE_TO IS NULL OR HC.EFFECTIVE_DATE_TO >= GET_LOCAL_DATE(P_SOB_ID))
			ORDER BY HC.SORT_NUM, HC.CODE
			;
	  EXCEPTION WHEN OTHERS THEN
		  V_MESSAGE := 'CLOSING CREATE ERROR : ' || TO_CHAR(SQLCODE) || SUBSTR(SQLERRM, 1, 150);
			O_MESSAGE := V_MESSAGE;
			RETURN;
		END;		
		V_MESSAGE := 'CLOSING CREATE COMPLETE !';
  	O_MESSAGE := V_MESSAGE;
	  COMMIT;
		
	END CLOSING_CREATE;
	
-- CLOSING CHECK.
  FUNCTION CLOSING_CHECK
	         ( W_CORP_ID                          IN HRM_CLOSING.CORP_ID%TYPE
					 , W_CLOSING_YYYYMM                   IN HRM_CLOSING.CLOSING_YYYYMM%TYPE
					 , W_CLOSING_TYPE_ID                  IN HRM_CLOSING.CLOSING_TYPE_ID%TYPE DEFAULT 0
					 , W_CLOSING_TYPE                     IN HRM_CLOSING_TYPE_V.CLOSING_TYPE%TYPE DEFAULT NULL
					 , W_SOB_ID                           IN HRM_CLOSING.SOB_ID%TYPE
					 , W_ORG_ID                           IN HRM_CLOSING.ORG_ID%TYPE
					 ) RETURN VARCHAR2
  AS
	  V_CLOSING_CHECK                             VARCHAR2(10) := NULL;
		V_CLOSING_TYPE_ID                           HRM_CLOSING.CLOSING_TYPE_ID%TYPE;
		
	BEGIN
	  IF W_CLOSING_TYPE_ID = 0 AND W_CLOSING_TYPE IS NOT NULL THEN
			BEGIN
				SELECT CT.CLOSING_TYPE_ID
					INTO V_CLOSING_TYPE_ID
					FROM HRM_CLOSING_TYPE_V CT
				 WHERE CT.CLOSING_TYPE       = W_CLOSING_TYPE
					 AND CT.SOB_ID             = W_SOB_ID
					 AND CT.ORG_ID             = W_ORG_ID
				;
			EXCEPTION WHEN OTHERS THEN
				V_CLOSING_CHECK := 'F';
				RETURN V_CLOSING_CHECK;
			END;
		ELSE
		  V_CLOSING_TYPE_ID := W_CLOSING_TYPE_ID;
		END IF;
		
	  BEGIN
			SELECT HC.CLOSING_YN
			  INTO V_CLOSING_CHECK
				FROM HRM_CLOSING HC
				WHERE HC.CORP_ID                                 = W_CORP_ID
					AND HC.CLOSING_YYYYMM                          = W_CLOSING_YYYYMM
					AND HC.CLOSING_TYPE_ID                         = V_CLOSING_TYPE_ID
					AND HC.SOB_ID                                  = W_SOB_ID
					AND HC.ORG_ID                                  = W_ORG_ID                                     
				;
	  EXCEPTION WHEN OTHERS THEN
		  V_CLOSING_CHECK := 'F';
    END;
	  RETURN V_CLOSING_CHECK;
	
	END CLOSING_CHECK;	

-- CLOSING CHECK : CLOSING_TYPE.
  FUNCTION CLOSING_CHECK_W
	         ( W_CORP_ID                             IN HRM_CLOSING.CORP_ID%TYPE
					 , W_CLOSING_YYYYMM                      IN HRM_CLOSING.CLOSING_YYYYMM%TYPE
					 , W_CLOSING_TYPE                        IN HRM_CLOSING_TYPE_V.CLOSING_TYPE%TYPE
					 , W_SOB_ID                              IN HRM_CLOSING.SOB_ID%TYPE
					 , W_ORG_ID                              IN HRM_CLOSING.ORG_ID%TYPE
					 ) RETURN VARCHAR2
  AS
    V_CLOSING_CHECK                                         VARCHAR2(10) := NULL;
		
	BEGIN
	  BEGIN
			SELECT HC.CLOSING_YN
				INTO V_CLOSING_CHECK
			FROM HRM_CLOSING HC 
				, HRM_CLOSING_TYPE_V CT
			WHERE HC.CLOSING_TYPE_ID                  = CT.CLOSING_TYPE_ID
				AND HC.CORP_ID                          = W_CORP_ID
				AND HC.CLOSING_YYYYMM                   = W_CLOSING_YYYYMM
				AND HC.SOB_ID                           = W_SOB_ID
				AND HC.ORG_ID                           = W_ORG_ID
				AND CT.CLOSING_TYPE                     = W_CLOSING_TYPE                
			;
	  EXCEPTION WHEN OTHERS THEN
		  V_CLOSING_CHECK := 'F';
    END;
	  RETURN V_CLOSING_CHECK;	
  
  END CLOSING_CHECK_W;
  
-- CLOSING CHECK : VALUE2.
  FUNCTION CLOSING_CHECK_W2
	         ( W_CORP_ID                             IN HRM_CLOSING.CORP_ID%TYPE
					 , W_CLOSING_YYYYMM                      IN HRM_CLOSING.CLOSING_YYYYMM%TYPE
					 , W_PERIOD_TYPE                         IN HRM_COMMON.VALUE2%TYPE
					 , W_SOB_ID                              IN HRM_CLOSING.SOB_ID%TYPE
					 , W_ORG_ID                              IN HRM_CLOSING.ORG_ID%TYPE
					 ) RETURN VARCHAR2
  AS
	  V_CLOSING_CHECK                                         VARCHAR2(10) := NULL;
		
	BEGIN
	  BEGIN
			SELECT HC.CLOSING_YN
				INTO V_CLOSING_CHECK
			FROM HRM_CLOSING HC 
				, HRM_CLOSING_TYPE_V CT
			WHERE HC.CLOSING_TYPE_ID                  = CT.CLOSING_TYPE_ID
				AND HC.CORP_ID                          = W_CORP_ID
				AND HC.CLOSING_YYYYMM                   = W_CLOSING_YYYYMM
				AND HC.SOB_ID                           = W_SOB_ID
				AND HC.ORG_ID                           = W_ORG_ID
				AND CT.PERIOD_TYPE                      = W_PERIOD_TYPE                
			;
	  EXCEPTION WHEN OTHERS THEN
		  V_CLOSING_CHECK := 'F';
    END;
	  RETURN V_CLOSING_CHECK;	
	
	END CLOSING_CHECK_W2;
	
END HRM_CLOSING_G;
/
