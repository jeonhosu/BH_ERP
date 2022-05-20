CREATE OR REPLACE PACKAGE HRF_FOOD_DAY_SUMMARY_G_SET
AS

-- 식수 현황 집계 MAIN.
  PROCEDURE SET_MAIN
            ( P_START_DATE                        IN HRF_FOOD_PERSON.FOOD_DATE%TYPE
						, P_END_DATE                          IN HRF_FOOD_PERSON.FOOD_DATE%TYPE
						, P_DEVICE_ID                         IN HRF_FOOD_PERSON_TIME.DEVICE_ID%TYPE
            , P_SOB_ID                            IN HRF_FOOD_PERSON.SOB_ID%TYPE
            , P_ORG_ID                            IN HRF_FOOD_PERSON.ORG_ID%TYPE
            , P_USER_ID                           IN HRF_FOOD_PERSON.CREATED_BY%TYPE
            , O_MESSAGE                           OUT VARCHAR2
            );

-- 식수 현황 집계 : 사원 처리.
  PROCEDURE FOOD_PERSON_GO
            ( P_START_DATE                        IN HRF_FOOD_PERSON.FOOD_DATE%TYPE
						, P_END_DATE                          IN HRF_FOOD_PERSON.FOOD_DATE%TYPE
						, P_DEVICE_ID                         IN HRF_FOOD_PERSON_TIME.DEVICE_ID%TYPE
            , P_SOB_ID                            IN HRF_FOOD_PERSON.SOB_ID%TYPE
            , P_ORG_ID                            IN HRF_FOOD_PERSON.ORG_ID%TYPE
            , P_USER_ID                           IN HRF_FOOD_PERSON.CREATED_BY%TYPE
            );
						
-- 식수 현황 집계 : 방문 처리.
  PROCEDURE FOOD_VISITOR_GO
            ( P_START_DATE                        IN HRF_FOOD_VISITOR.FOOD_DATE%TYPE
						, P_END_DATE                          IN HRF_FOOD_VISITOR.FOOD_DATE%TYPE
						, P_DEVICE_ID                         IN HRF_FOOD_VISITOR_TIME.DEVICE_ID%TYPE
            , P_SOB_ID                            IN HRF_FOOD_VISITOR.SOB_ID%TYPE
            , P_ORG_ID                            IN HRF_FOOD_VISITOR.ORG_ID%TYPE
            , P_USER_ID                           IN HRF_FOOD_VISITOR.CREATED_BY%TYPE
            );						

-- 식수 현황 마감 여부 체크.
  FUNCTION FOOD_CLOSED_FLAG_F
	          ( W_START_DATE                        IN HRF_FOOD_PERSON.FOOD_DATE%TYPE
						, W_END_DATE                          IN HRF_FOOD_PERSON.FOOD_DATE%TYPE
						, W_DEVICE_ID                         IN HRF_FOOD_PERSON_TIME.DEVICE_ID%TYPE
            , W_SOB_ID                            IN HRF_FOOD_PERSON.SOB_ID%TYPE
            , W_ORG_ID                            IN HRF_FOOD_PERSON.ORG_ID%TYPE
            , W_USER_ID                           IN HRF_FOOD_PERSON.CREATED_BY%TYPE
						) RETURN VARCHAR2;
						
END HRF_FOOD_DAY_SUMMARY_G_SET;
/
CREATE OR REPLACE PACKAGE BODY HRF_FOOD_DAY_SUMMARY_G_SET
AS
/******************************************************************************/
/* PROJECT      : FPCB ERP
/* MODULE       : EAPP
/* PROGRAM NAME : HRF_FOOD_DAY_G_SET
/* DESCRIPTION  : 식사현황 집계 관리.  : 
/*                장치 ID : HRM_DEVICE_V
/* REFERENCE BY :
/* PROGRAM HISTORY : 신규 생성
/*------------------------------------------------------------------------------
/*   DATE       IN CHARGE          DESCRIPTION
/*------------------------------------------------------------------------------
/* 20-JUN-2010  JEON HO SU          INITIALIZE
/******************************************************************************/
-- 식수 현황 집계 MAIN.
  PROCEDURE SET_MAIN
            ( P_START_DATE                        IN HRF_FOOD_PERSON.FOOD_DATE%TYPE
						, P_END_DATE                          IN HRF_FOOD_PERSON.FOOD_DATE%TYPE
						, P_DEVICE_ID                         IN HRF_FOOD_PERSON_TIME.DEVICE_ID%TYPE
            , P_SOB_ID                            IN HRF_FOOD_PERSON.SOB_ID%TYPE
            , P_ORG_ID                            IN HRF_FOOD_PERSON.ORG_ID%TYPE
            , P_USER_ID                           IN HRF_FOOD_PERSON.CREATED_BY%TYPE
            , O_MESSAGE                           OUT VARCHAR2
            )
  AS
    V_RECORD_COUNT                                NUMBER := 0;

  BEGIN
    -- 마감 여부 체크하여 마감(Trans_yn = 'y')된 자료이면 집계 안함.
    V_RECORD_COUNT := 0;
    BEGIN
      V_RECORD_COUNT := FOOD_CLOSED_FLAG_F( W_START_DATE => P_START_DATE
			                                    , W_END_DATE => P_END_DATE
																					, W_DEVICE_ID => P_DEVICE_ID
																					, W_SOB_ID => P_SOB_ID
																					, W_ORG_ID => P_ORG_ID
																					, W_USER_ID => P_USER_ID
																					);
    EXCEPTION WHEN OTHERS THEN
      V_RECORD_COUNT := 0;
    END;
    IF V_RECORD_COUNT > 0 THEN
      O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10052', NULL);
      RETURN;
    END IF;
		
    
    -- 사원 식수 집계 처리 프로시져 호출.
    FOOD_PERSON_GO( P_START_DATE => P_START_DATE
									, P_END_DATE => P_END_DATE
									, P_DEVICE_ID => P_DEVICE_ID
									, P_SOB_ID => P_SOB_ID
									, P_ORG_ID => P_ORG_ID
									, P_USER_ID => P_USER_ID
									);
									
    -- 사원 식수 집계 처리 프로시져 호출.
    FOOD_VISITOR_GO ( P_START_DATE => P_START_DATE
										, P_END_DATE => P_END_DATE
										, P_DEVICE_ID => P_DEVICE_ID
										, P_SOB_ID => P_SOB_ID
										, P_ORG_ID => P_ORG_ID
										, P_USER_ID => P_USER_ID
										);
										
    -- REFRESH.
		DBMS_MVIEW.REFRESH('HRF_FOOD_DAY_COUNT_V');
    O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10063', NULL);
		
  END SET_MAIN;

-- 출퇴근 정리 및 집계 처리.
  PROCEDURE FOOD_PERSON_GO
            ( P_START_DATE                        IN HRF_FOOD_PERSON.FOOD_DATE%TYPE
						, P_END_DATE                          IN HRF_FOOD_PERSON.FOOD_DATE%TYPE
						, P_DEVICE_ID                         IN HRF_FOOD_PERSON_TIME.DEVICE_ID%TYPE
            , P_SOB_ID                            IN HRF_FOOD_PERSON.SOB_ID%TYPE
            , P_ORG_ID                            IN HRF_FOOD_PERSON.ORG_ID%TYPE
            , P_USER_ID                           IN HRF_FOOD_PERSON.CREATED_BY%TYPE
            )
  AS
    V_SYSDATE                                     HRF_FOOD_PERSON.CREATION_DATE%TYPE;
    V_FOOD_PERSON_ID                              HRF_FOOD_PERSON.FOOD_PERSON_ID%TYPE;

  BEGIN
	  V_SYSDATE := GET_LOCAL_DATE(P_SOB_ID);
		
		-- 식수 합계 저장 --
	  BEGIN
		  FOR C1 IN ( SELECT PM.PERSON_ID
											 , FI.FOOD_DATE
											 , PM.CORP_ID
											 , COUNT(FI.FOOD_DATETIME) AS FOOD_COUNT
											 , NVL(SUM(DECODE(FI.FOOD_FLAG, '1', 1, 0)), 0) AS FOOD_1_COUNT
											 , NVL(SUM(DECODE(FI.FOOD_FLAG, '2', 1, 0)), 0) AS FOOD_2_COUNT
											 , NVL(SUM(DECODE(FI.FOOD_FLAG, '3', 1, 0)), 0) AS FOOD_3_COUNT
											 , NVL(SUM(DECODE(FI.FOOD_FLAG, '4', 1, 0)), 0) AS FOOD_4_COUNT
											 , NVL(SUM(DECODE(FI.FOOD_FLAG, '5', 1, 0)), 0) AS SNACK_1_COUNT
											 , NVL(SUM(DECODE(FI.FOOD_FLAG, '6', 1, 0)), 0) AS SNACK_2_COUNT
											 , NVL(SUM(DECODE(FI.FOOD_FLAG, '7', 1, 0)), 0) AS SNACK_3_COUNT
											 , NVL(SUM(DECODE(FI.FOOD_FLAG, '8', 1, 0)), 0) AS SNACK_4_COUNT
										FROM HRF_FOOD_INTERFACE FI
											 , HRM_PERSON_MASTER PM
									 WHERE FI.PERSON_ID             = PM.PERSON_ID
										 AND FI.FOOD_DATE             BETWEEN P_START_DATE AND P_END_DATE
										 AND FI.DEVICE_ID             = NVL(P_DEVICE_ID, FI.DEVICE_ID)
										 AND FI.CARD_TYPE             = 'P'
										 AND PM.SOB_ID                = P_SOB_ID
										 AND PM.ORG_ID                = P_ORG_ID
									GROUP BY PM.PERSON_ID
											 , FI.FOOD_DATE
											 , PM.CORP_ID
											 , PM.SOB_ID
											 , PM.ORG_ID
								)
      LOOP 
			  BEGIN
				  SELECT FP.FOOD_PERSON_ID
					  INTO V_FOOD_PERSON_ID
					  FROM HRF_FOOD_PERSON FP
					 WHERE FP.FOOD_DATE        = C1.FOOD_DATE
					   AND FP.PERSON_ID        = C1.PERSON_ID
						 AND FP.CORP_ID          = C1.CORP_ID
						 AND FP.SOB_ID           = P_SOB_ID
						 AND FP.ORG_ID           = P_ORG_ID
					;
				EXCEPTION WHEN OTHERS THEN
				  V_FOOD_PERSON_ID := 0;
				END;
		    -- 식수 ID --
				IF V_FOOD_PERSON_ID = 0 THEN
					BEGIN
						SELECT HRF_FOOD_PERSON_S1.NEXTVAL
							INTO V_FOOD_PERSON_ID
							FROM DUAL
							;
					EXCEPTION WHEN OTHERS THEN
						RAISE ERRNUMS.Invalid_Sequence_ID;
					END;
         
					-- INSERT --
					INSERT INTO HRF_FOOD_PERSON
					( FOOD_PERSON_ID
					, PERSON_ID, FOOD_DATE, CORP_ID
					, FOOD_COUNT
					, FOOD_1_COUNT, FOOD_2_COUNT, FOOD_3_COUNT, FOOD_4_COUNT
					, SNACK_1_COUNT, SNACK_2_COUNT, SNACK_3_COUNT, SNACK_4_COUNT
					, SOB_ID, ORG_ID
					, CREATION_DATE, CREATED_BY, LAST_UPDATE_DATE, LAST_UPDATED_BY
					) VALUES
					( V_FOOD_PERSON_ID
					, C1.PERSON_ID, C1.FOOD_DATE, C1.CORP_ID
					, C1.FOOD_COUNT
					, C1.FOOD_1_COUNT, C1.FOOD_2_COUNT, C1.FOOD_3_COUNT, C1.FOOD_4_COUNT
					, C1.SNACK_1_COUNT, C1.SNACK_2_COUNT, C1.SNACK_3_COUNT, C1.SNACK_4_COUNT
					, P_SOB_ID, P_ORG_ID
					, V_SYSDATE, P_USER_ID, V_SYSDATE, P_USER_ID
					);
		    
					-- 식사시간 저장 --
					INSERT INTO HRF_FOOD_PERSON_TIME
					( PERSON_ID, FOOD_DATE
					, FOOD_PERSON_ID
					, FOOD_FLAG, DEVICE_ID, FOOD_DATETIME, CREATED_FLAG
					, CREATION_DATE, CREATED_BY, LAST_UPDATE_DATE, LAST_UPDATED_BY
					) 
					(SELECT C1.PERSON_ID
							 , FI.FOOD_DATE
							 , V_FOOD_PERSON_ID
							 , FI.FOOD_FLAG, FI.DEVICE_ID, FI.FOOD_DATETIME, FI.CREATED_FLAG
							 , V_SYSDATE, P_USER_ID, V_SYSDATE, P_USER_ID
						FROM HRF_FOOD_INTERFACE FI
					 WHERE FI.FOOD_DATE             = C1.FOOD_DATE
						 AND FI.DEVICE_ID             = NVL(P_DEVICE_ID, FI.DEVICE_ID)
						 AND FI.PERSON_ID             = C1.PERSON_ID
						 AND FI.CARD_TYPE             = 'P'
					);
				ELSE
				  -- UPDATE --
					UPDATE HRF_FOOD_PERSON FP
					  SET FP.FOOD_COUNT        = C1.FOOD_COUNT
						  , FP.FOOD_1_COUNT      = C1.FOOD_1_COUNT
							, FP.FOOD_2_COUNT      = C1.FOOD_2_COUNT
							, FP.FOOD_3_COUNT      = C1.FOOD_3_COUNT
							, FP.FOOD_4_COUNT      = C1.FOOD_4_COUNT
					    , FP.SNACK_1_COUNT     = C1.SNACK_1_COUNT
							, FP.SNACK_2_COUNT     = C1.SNACK_2_COUNT
							, FP.SNACK_3_COUNT     = C1.SNACK_3_COUNT
							, FP.SNACK_4_COUNT     = C1.SNACK_4_COUNT
							, FP.LAST_UPDATE_DATE  = V_SYSDATE
							, LAST_UPDATED_BY      = P_USER_ID
					WHERE FP.FOOD_PERSON_ID    = V_FOOD_PERSON_ID
					;
							    
					-- 식사시간 저장 --
					DELETE FROM HRF_FOOD_PERSON_TIME FPT
					WHERE FPT.PERSON_ID        = C1.PERSON_ID
					  AND FPT.FOOD_DATE        = C1.FOOD_DATE
						AND FPT.FOOD_PERSON_ID   = V_FOOD_PERSON_ID
						AND FPT.DEVICE_ID        = NVL(P_DEVICE_ID, FPT.DEVICE_ID)
          ;
					-- 식사시간 저장 --
					INSERT INTO HRF_FOOD_PERSON_TIME
					( PERSON_ID, FOOD_DATE
					, FOOD_PERSON_ID
					, FOOD_FLAG, DEVICE_ID, FOOD_DATETIME, CREATED_FLAG
					, CREATION_DATE, CREATED_BY, LAST_UPDATE_DATE, LAST_UPDATED_BY
					) 
					(SELECT C1.PERSON_ID
							 , FI.FOOD_DATE
							 , V_FOOD_PERSON_ID
							 , FI.FOOD_FLAG, FI.DEVICE_ID, FI.FOOD_DATETIME, FI.CREATED_FLAG
							 , V_SYSDATE, P_USER_ID, V_SYSDATE, P_USER_ID
						FROM HRF_FOOD_INTERFACE FI
					 WHERE FI.FOOD_DATE             = C1.FOOD_DATE
						 AND FI.DEVICE_ID             = NVL(P_DEVICE_ID, FI.DEVICE_ID)
						 AND FI.PERSON_ID             = C1.PERSON_ID
						 AND FI.CARD_TYPE             = 'P'
					);
					
				END IF;				
			END LOOP C1;
		END;
    COMMIT;
  
  EXCEPTION 
	  WHEN ERRNUMS.Invalid_Sequence_ID THEN
		RAISE_APPLICATION_ERROR(ERRNUMS.Invalid_Sequence_Code, ERRNUMS.Invalid_Sequence_Desc);
  END FOOD_PERSON_GO;
	
-- 식수 현황 집계 : 방문 처리.
  PROCEDURE FOOD_VISITOR_GO
            ( P_START_DATE                        IN HRF_FOOD_VISITOR.FOOD_DATE%TYPE
						, P_END_DATE                          IN HRF_FOOD_VISITOR.FOOD_DATE%TYPE
						, P_DEVICE_ID                         IN HRF_FOOD_VISITOR_TIME.DEVICE_ID%TYPE
            , P_SOB_ID                            IN HRF_FOOD_VISITOR.SOB_ID%TYPE
            , P_ORG_ID                            IN HRF_FOOD_VISITOR.ORG_ID%TYPE
            , P_USER_ID                           IN HRF_FOOD_VISITOR.CREATED_BY%TYPE
            )
  AS
	  V_SYSDATE                                     HRF_FOOD_VISITOR.CREATION_DATE%TYPE;
    V_FOOD_VISITOR_ID                             HRF_FOOD_VISITOR.FOOD_VISITOR_ID%TYPE;

  BEGIN
	  V_SYSDATE := GET_LOCAL_DATE(P_SOB_ID);
		
		-- 식수 합계 저장 --
	  BEGIN
		  FOR C1 IN ( SELECT VC.VISITOR_CARD_ID
											 , FI.FOOD_DATE
											 , VC.CORP_ID
											 , COUNT(FI.FOOD_DATETIME) AS FOOD_COUNT
											 , NVL(SUM(DECODE(FI.FOOD_FLAG, '1', 1, 0)), 0) AS FOOD_1_COUNT
											 , NVL(SUM(DECODE(FI.FOOD_FLAG, '2', 1, 0)), 0) AS FOOD_2_COUNT
											 , NVL(SUM(DECODE(FI.FOOD_FLAG, '3', 1, 0)), 0) AS FOOD_3_COUNT
											 , NVL(SUM(DECODE(FI.FOOD_FLAG, '4', 1, 0)), 0) AS FOOD_4_COUNT
											 , NVL(SUM(DECODE(FI.FOOD_FLAG, '5', 1, 0)), 0) AS SNACK_1_COUNT
											 , NVL(SUM(DECODE(FI.FOOD_FLAG, '6', 1, 0)), 0) AS SNACK_2_COUNT
											 , NVL(SUM(DECODE(FI.FOOD_FLAG, '7', 1, 0)), 0) AS SNACK_3_COUNT
											 , NVL(SUM(DECODE(FI.FOOD_FLAG, '8', 1, 0)), 0) AS SNACK_4_COUNT
										FROM HRF_FOOD_INTERFACE FI
										    ,HRM_VISITOR_CARD VC
									 WHERE FI.PERSON_ID             = VC.VISITOR_CARD_ID
										 AND FI.FOOD_DATE             BETWEEN P_START_DATE AND P_END_DATE
										 AND FI.DEVICE_ID             = NVL(P_DEVICE_ID, FI.DEVICE_ID)
										 AND FI.CARD_TYPE             = 'V'
										 AND VC.SOB_ID                = P_SOB_ID
										 AND VC.ORG_ID                = P_ORG_ID
									GROUP BY VC.VISITOR_CARD_ID
											 , FI.FOOD_DATE
											 , VC.CORP_ID
											 , VC.SOB_ID
											 , VC.ORG_ID
								)
      LOOP 
			  BEGIN
				  SELECT FV.FOOD_VISITOR_ID
					  INTO V_FOOD_VISITOR_ID
					  FROM HRF_FOOD_VISITOR FV
					 WHERE FV.FOOD_DATE        = C1.FOOD_DATE
					   AND FV.VISITOR_ID       = C1.VISITOR_CARD_ID
						 AND FV.CORP_ID          = C1.CORP_ID
						 AND FV.SOB_ID           = P_SOB_ID
						 AND FV.ORG_ID           = P_ORG_ID
					;
				EXCEPTION WHEN OTHERS THEN
				  V_FOOD_VISITOR_ID := 0;
				END;
				
				IF V_FOOD_VISITOR_ID = 0 THEN
				-- INSERT.
					-- 식수 ID --
					BEGIN
						SELECT HRF_FOOD_VISITOR_S1.NEXTVAL
							INTO V_FOOD_VISITOR_ID
							FROM DUAL
							;
					EXCEPTION WHEN OTHERS THEN
						RAISE ERRNUMS.Invalid_Sequence_ID;
					END;
					
					-- INSERT --
					INSERT INTO HRF_FOOD_VISITOR
					( FOOD_VISITOR_ID
					, VISITOR_ID, FOOD_DATE, CORP_ID
					, FOOD_COUNT
					, FOOD_1_COUNT, FOOD_2_COUNT, FOOD_3_COUNT, FOOD_4_COUNT
					, SNACK_1_COUNT, SNACK_2_COUNT, SNACK_3_COUNT, SNACK_4_COUNT
					, SOB_ID, ORG_ID
					, CREATION_DATE, CREATED_BY, LAST_UPDATE_DATE, LAST_UPDATED_BY
					) VALUES
					( V_FOOD_VISITOR_ID
					, C1.VISITOR_CARD_ID, C1.FOOD_DATE, C1.CORP_ID
					, C1.FOOD_COUNT
					, C1.FOOD_1_COUNT, C1.FOOD_2_COUNT, C1.FOOD_3_COUNT, C1.FOOD_4_COUNT
					, C1.SNACK_1_COUNT, C1.SNACK_2_COUNT, C1.SNACK_3_COUNT, C1.SNACK_4_COUNT
					, P_SOB_ID, P_ORG_ID
					, V_SYSDATE, P_USER_ID, V_SYSDATE, P_USER_ID
					);
			    
					-- 식사시간 저장 --
					INSERT INTO HRF_FOOD_VISITOR_TIME
					( VISITOR_ID, FOOD_DATE
					, FOOD_VISITOR_ID
					, FOOD_FLAG, DEVICE_ID, FOOD_DATETIME, CREATED_FLAG
					, CREATION_DATE, CREATED_BY, LAST_UPDATE_DATE, LAST_UPDATED_BY
					) 
					(SELECT C1.VISITOR_CARD_ID
							 , FI.FOOD_DATE
							 , V_FOOD_VISITOR_ID
							 , FI.FOOD_FLAG, FI.DEVICE_ID, FI.FOOD_DATETIME, FI.CREATED_FLAG
							 , V_SYSDATE, P_USER_ID, V_SYSDATE, P_USER_ID
						FROM HRF_FOOD_INTERFACE FI
					 WHERE FI.FOOD_DATE             = C1.FOOD_DATE
						 AND FI.DEVICE_ID             = NVL(P_DEVICE_ID, FI.DEVICE_ID)
						 AND FI.PERSON_ID             = C1.VISITOR_CARD_ID
						 AND FI.CARD_TYPE             = 'V'
					);
				
				ELSE
				  -- UPDATE --
					UPDATE HRF_FOOD_VISITOR FV
					  SET FV.FOOD_COUNT        = C1.FOOD_COUNT
						  , FV.FOOD_1_COUNT      = C1.FOOD_1_COUNT
							, FV.FOOD_2_COUNT      = C1.FOOD_2_COUNT
							, FV.FOOD_3_COUNT      = C1.FOOD_3_COUNT
							, FV.FOOD_4_COUNT      = C1.FOOD_4_COUNT
					    , FV.SNACK_1_COUNT     = C1.SNACK_1_COUNT
							, FV.SNACK_2_COUNT     = C1.SNACK_2_COUNT
							, FV.SNACK_3_COUNT     = C1.SNACK_3_COUNT
							, FV.SNACK_4_COUNT     = C1.SNACK_4_COUNT
							, FV.LAST_UPDATE_DATE  = V_SYSDATE
							, FV.LAST_UPDATED_BY   = P_USER_ID
					WHERE FV.FOOD_VISITOR_ID   = V_FOOD_VISITOR_ID
					;
							    
					-- 식사시간 저장 --
					DELETE FROM HRF_FOOD_VISITOR_TIME FVT
					WHERE FVT.VISITOR_ID       = C1.VISITOR_CARD_ID
					  AND FVT.FOOD_DATE        = C1.FOOD_DATE
						AND FVT.FOOD_VISITOR_ID  = V_FOOD_VISITOR_ID
						AND FVT.DEVICE_ID        = NVL(P_DEVICE_ID, FVT.DEVICE_ID)
          ;
					-- 식사시간 저장 --
					INSERT INTO HRF_FOOD_VISITOR_TIME
					( VISITOR_ID, FOOD_DATE
					, FOOD_VISITOR_ID
					, FOOD_FLAG, DEVICE_ID, FOOD_DATETIME, CREATED_FLAG
					, CREATION_DATE, CREATED_BY, LAST_UPDATE_DATE, LAST_UPDATED_BY
					) 
					(SELECT C1.VISITOR_CARD_ID
							 , FI.FOOD_DATE
							 , V_FOOD_VISITOR_ID
							 , FI.FOOD_FLAG, FI.DEVICE_ID, FI.FOOD_DATETIME, FI.CREATED_FLAG
							 , V_SYSDATE, P_USER_ID, V_SYSDATE, P_USER_ID
						FROM HRF_FOOD_INTERFACE FI
					 WHERE FI.FOOD_DATE             = C1.FOOD_DATE
						 AND FI.DEVICE_ID             = NVL(P_DEVICE_ID, FI.DEVICE_ID)
						 AND FI.PERSON_ID             = C1.VISITOR_CARD_ID
						 AND FI.CARD_TYPE             = 'V'
					);
					
				END IF;
				
			END LOOP C1;
		END;
    COMMIT;
  
  EXCEPTION 
	  WHEN ERRNUMS.Invalid_Sequence_ID THEN
		RAISE_APPLICATION_ERROR(ERRNUMS.Invalid_Sequence_Code, ERRNUMS.Invalid_Sequence_Desc);
	END FOOD_VISITOR_GO;	

-- 식수 현황 마감 여부 체크.
  FUNCTION FOOD_CLOSED_FLAG_F
	          ( W_START_DATE                        IN HRF_FOOD_PERSON.FOOD_DATE%TYPE
						, W_END_DATE                          IN HRF_FOOD_PERSON.FOOD_DATE%TYPE
						, W_DEVICE_ID                         IN HRF_FOOD_PERSON_TIME.DEVICE_ID%TYPE
            , W_SOB_ID                            IN HRF_FOOD_PERSON.SOB_ID%TYPE
            , W_ORG_ID                            IN HRF_FOOD_PERSON.ORG_ID%TYPE
            , W_USER_ID                           IN HRF_FOOD_PERSON.CREATED_BY%TYPE
						) RETURN VARCHAR2
  AS
	  V_RECORD_COUNT                                NUMBER := 0;
		
	BEGIN
	  /*IF P_CLOSED_CHECK_TYPE = 'V' THEN
		
		
		ELSE
		  BEGIN
				SELECT
					FROM HRF_FOOD_PERSON FP
				 WHERE FP.FOOD_DATE         BETWEEN W_
	    
			EXCEPTION WHEN OTHERS THEN
			  V_RECORD_COUNT := 0;
      END;
	  END IF;*/
		RETURN V_RECORD_COUNT;
		
	END FOOD_CLOSED_FLAG_F;
	
END HRF_FOOD_DAY_SUMMARY_G_SET;
/
