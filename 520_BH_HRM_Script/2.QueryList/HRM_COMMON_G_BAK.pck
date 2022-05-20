CREATE OR REPLACE PACKAGE HRM_COMMON_G
AS
-----------------------------------------------------------------------------------------
-- HEADER DATA 조회.
  PROCEDURE COMMON_SELECT_H
	          ( P_CURSOR                            OUT TYPES.TCURSOR
						, W_CODE                              IN VARCHAR2
						, W_CODE_NAME                         IN VARCHAR2
						, W_SOB_ID                            IN NUMBER
						, W_ORG_ID                            IN NUMBER
						);
                                                    
-- HEADER INSERT.
  PROCEDURE COMMON_INSERT_H
	          ( P_CODE                              IN VARCHAR2
						, P_CODE_NAME                         IN VARCHAR2
						, P_CODE_LENGHT                       IN NUMBER
						, P_VALUE1                            IN VARCHAR2
						, P_VALUE2                            IN VARCHAR2
						, P_VALUE3                            IN VARCHAR2
						, P_VALUE4                            IN VARCHAR2
						, P_VALUE5                            IN VARCHAR2
						, P_VALUE6                            IN VARCHAR2
						, P_VALUE7                            IN VARCHAR2
						, P_SOB_ID                            IN NUMBER
						, P_ORG_ID                            IN NUMBER
						, P_USER_ID                           IN NUMBER
						);

-- HEADER UPDATE.
  PROCEDURE COMMON_UPDATE_H
	          ( W_COMMON_ID                         IN NUMBER
						, P_CODE_NAME                         IN VARCHAR2
						, P_CODE_LENGHT                       IN NUMBER
						, P_VALUE1                            IN VARCHAR2
						, P_VALUE2                            IN VARCHAR2
						, P_VALUE3                            IN VARCHAR2
						, P_VALUE4                            IN VARCHAR2
						, P_VALUE5                            IN VARCHAR2
						, P_VALUE6                            IN VARCHAR2
						, P_VALUE7                            IN VARCHAR2
						, P_USER_ID                           IN NUMBER
						);
                                                            
-----------------------------------------------------------------------------------------
-- LINE DATA 조회.
  PROCEDURE COMMON_SELECT_L
	          ( P_CURSOR1                           OUT TYPES.TCURSOR1
						, W_GROUP_CODE                        IN VARCHAR2
						, W_SOB_ID                            IN NUMBER
						, W_ORG_ID                            IN NUMBER
						);
                                                    
-- LINE INSERT.
  PROCEDURE COMMON_INSERT_L
	          ( P_GROUP_CODE                        IN VARCHAR2
						, P_CODE                              IN VARCHAR2
						, P_CODE_NAME                         IN VARCHAR2
						, P_VALUE1                            IN VARCHAR2
						, P_VALUE2                            IN VARCHAR2
						, P_VALUE3                            IN VARCHAR2
						, P_VALUE4                            IN VARCHAR2
						, P_VALUE5                            IN VARCHAR2
						, P_VALUE6                            IN VARCHAR2
						, P_VALUE7                            IN VARCHAR2
						, P_DEFAULT_FLAG                      IN VARCHAR2
						, P_SORT_NUM                          IN NUMBER
						, P_DESCRIPTION                       IN VARCHAR2
						, P_USABLE                            IN VARCHAR2
						, P_START_DATE                        IN DATE
						, P_END_DATE                          IN DATE
						, P_SOB_ID                            IN NUMBER
						, P_ORG_ID                            IN NUMBER
						, P_USER_ID                           IN NUMBER
						);

-- LINE UPDATE.
  PROCEDURE COMMON_UPDATE_L
	          ( W_COMMON_ID                         IN VARCHAR2
						, P_CODE_NAME                         IN VARCHAR2
						, P_VALUE1                            IN VARCHAR2
						, P_VALUE2                            IN VARCHAR2
						, P_VALUE3                            IN VARCHAR2
						, P_VALUE4                            IN VARCHAR2
						, P_VALUE5                            IN VARCHAR2
						, P_VALUE6                            IN VARCHAR2
						, P_VALUE7                            IN VARCHAR2
						, P_DEFAULT_FLAG                      IN VARCHAR2
						, P_SORT_NUM                          IN NUMBER
						, P_DESCRIPTION                       IN VARCHAR2
						, P_USABLE                            IN VARCHAR2
						, P_START_DATE                        IN DATE
						, P_END_DATE                          IN DATE
						, P_USER_ID                           IN NUMBER
						);

-----------------------------------------------------------------------------------------
-- 공통코드 명칭 리턴 FUNCTION.
  FUNCTION ID_NAME_F
	         ( W_COMMON_ID                          IN NUMBER
					 ) RETURN VARCHAR2;
  
  PROCEDURE ID_NAME
	          ( W_COMMON_ID                         IN NUMBER
	          , O_RETURN_VALUE                      OUT VARCHAR2
						);							

  FUNCTION CODE_NAME_F
	         ( W_FIELD_NAME                         IN VARCHAR2
					 , W_CODE                               IN VARCHAR2
					 , W_SOB_ID                             IN NUMBER
					 , W_ORG_ID                             IN NUMBER
					 ) RETURN VARCHAR2;

  PROCEDURE CODE_NAME
	          ( W_FIELD_NAME                        IN VARCHAR2
						, W_CODE                              IN VARCHAR2
						, W_SOB_ID                            IN NUMBER
						, W_ORG_ID                            IN NUMBER
						, O_RETURN_VALUE                      OUT VARCHAR2
						);  
											                                             
-- 근속년수 계산.
  FUNCTION YEAR_COUNT_F
	         ( P_START_DATE                         IN DATE
           , P_END_DATE                           IN DATE
					 , P_COUNT_TYPE                         IN VARCHAR2
					 , P_ROUND_BIT_OVER                     IN NUMBER DEFAULT 0
					 ) RETURN NUMBER;

  PROCEDURE YEAR_COUNT
	          ( P_START_DATE                        IN DATE
						, P_END_DATE                          IN DATE
						, P_COUNT_TYPE                        IN VARCHAR2
						, P_ROUND_BIT_OVER                    IN NUMBER DEFAULT 0
						, O_RETURN_VALUE                      OUT VARCHAR2
						);
						
-----------------------------------------------------------------------------------------
-- 공통코드 기본값 리턴 - GROUP CODE..
  PROCEDURE DEFAULT_VALUE_GROUP
	          ( W_GROUP_CODE                        IN HRM_COMMON.GROUP_CODE%TYPE
						, W_SOB_ID                            IN HRM_COMMON.SOB_ID%TYPE
						, W_ORG_ID                            IN HRM_COMMON.ORG_ID%TYPE
						, O_ID                                OUT HRM_COMMON.COMMON_ID%TYPE
						, O_CODE                              OUT HRM_COMMON.CODE%TYPE
						, O_CODE_NAME                         OUT HRM_COMMON.CODE_NAME%TYPE
						);                                  
                                            
-- 공통코드 기본값 리턴 - FIELD..
  PROCEDURE DEFAULT_VALUE_FIELD
	          ( W_FIELD_NAME                        IN HRM_COMMON.VALUE1%TYPE
						, W_SOB_ID                            IN HRM_COMMON.SOB_ID%TYPE
						, W_ORG_ID                            IN HRM_COMMON.ORG_ID%TYPE
						, O_ID                                OUT HRM_COMMON.COMMON_ID%TYPE
						, O_CODE                              OUT HRM_COMMON.CODE%TYPE
						, O_CODE_NAME                         OUT HRM_COMMON.CODE_NAME%TYPE
						);

-- 공통코드 기본값 리턴 - VALUE1을 조건 검색하여 : GROUP CODE..
  PROCEDURE DEFAULT_VALUE_GROUP_W
	          ( W_GROUP_CODE                        IN HRM_COMMON.GROUP_CODE%TYPE
						, W_VALUE1                            IN HRM_COMMON.VALUE1%TYPE
						, W_SOB_ID                            IN HRM_COMMON.SOB_ID%TYPE
						, W_ORG_ID                            IN HRM_COMMON.ORG_ID%TYPE
						, O_ID                                OUT HRM_COMMON.COMMON_ID%TYPE
						, O_CODE                              OUT HRM_COMMON.CODE%TYPE
						, O_CODE_NAME                         OUT HRM_COMMON.CODE_NAME%TYPE
						);                                  
                                            
-- 공통코드 기본값 리턴 - VALUE1을 조건 검색하여 : FIELD..
  PROCEDURE DEFAULT_VALUE_FIELD_W
	          ( W_FIELD_NAME                        IN HRM_COMMON.VALUE1%TYPE
						, W_VALUE1                            IN HRM_COMMON.VALUE1%TYPE
						, W_SOB_ID                            IN HRM_COMMON.SOB_ID%TYPE
						, W_ORG_ID                            IN HRM_COMMON.ORG_ID%TYPE
						, O_ID                                OUT HRM_COMMON.COMMON_ID%TYPE
						, O_CODE                              OUT HRM_COMMON.CODE%TYPE
						, O_CODE_NAME                         OUT HRM_COMMON.CODE_NAME%TYPE
						);

-- 공통코드 기본값 리턴 - VALUE1과 VLAUE2을 조건 검색하여 : FIELD..
  PROCEDURE DEFAULT_VALUE_FIELD_W2
	          ( W_FIELD_NAME                        IN HRM_COMMON.VALUE1%TYPE
						, W_VALUE1                            IN HRM_COMMON.VALUE1%TYPE
						, W_VALUE2                            IN HRM_COMMON.VALUE2%TYPE
						, W_SOB_ID                            IN HRM_COMMON.SOB_ID%TYPE
						, W_ORG_ID                            IN HRM_COMMON.ORG_ID%TYPE
						, O_ID                                OUT HRM_COMMON.COMMON_ID%TYPE
						, O_CODE                              OUT HRM_COMMON.CODE%TYPE
						, O_CODE_NAME                         OUT HRM_COMMON.CODE_NAME%TYPE
						);						

-----------------------------------------------------------------------------------------
-- 공통코드 조회 LOOKUP - GROUP CODE..
  PROCEDURE LU_SELECT_GROUP
	          ( P_CURSOR3                           OUT TYPES.TCURSOR3
						, W_GROUP_CODE                        IN HRM_COMMON.GROUP_CODE%TYPE
						, W_CODE_NAME                         IN HRM_COMMON.CODE_NAME%TYPE
						, W_SOB_ID                            IN HRM_COMMON.SOB_ID%TYPE
						, W_ORG_ID                            IN HRM_COMMON.ORG_ID%TYPE
						, W_USABLE_CHECK_YN                   IN HRM_COMMON.USABLE%TYPE DEFAULT 'Y'
						);

-- 공통코드 조회 LOOKUP - GROUP CODE..
  PROCEDURE LU_SELECT_GROUP_7
	          ( P_CURSOR3                           OUT TYPES.TCURSOR3
						, W_GROUP_CODE                        IN HRM_COMMON.GROUP_CODE%TYPE
						, W_VALUE1                            IN HRM_COMMON.VALUE1%TYPE
            , W_VALUE2                            IN HRM_COMMON.VALUE2%TYPE
            , W_VALUE3                            IN HRM_COMMON.VALUE3%TYPE
            , W_VALUE4                            IN HRM_COMMON.VALUE4%TYPE
            , W_VALUE5                            IN HRM_COMMON.VALUE5%TYPE
            , W_VALUE6                            IN HRM_COMMON.VALUE6%TYPE
            , W_VALUE7                            IN HRM_COMMON.VALUE7%TYPE
						, W_SOB_ID                            IN HRM_COMMON.SOB_ID%TYPE
						, W_ORG_ID                            IN HRM_COMMON.ORG_ID%TYPE
						, W_USABLE_CHECK_YN                   IN HRM_COMMON.USABLE%TYPE DEFAULT 'Y'
						);            
                                            
-- 공통코드 조회 LOOKUP - FIELD..
  PROCEDURE LU_SELECT_FIELD
	          ( P_CURSOR3                           OUT TYPES.TCURSOR3
						, W_FIELD_NAME                        IN HRM_COMMON.VALUE1%TYPE
						, W_CODE_NAME                         IN HRM_COMMON.CODE_NAME%TYPE
						, W_SOB_ID                            IN HRM_COMMON.SOB_ID%TYPE
						, W_ORG_ID                            IN HRM_COMMON.ORG_ID%TYPE
						, W_USABLE_CHECK_YN                   IN HRM_COMMON.USABLE%TYPE DEFAULT 'Y'
						);
            
-- 공통코드 조회 LOOKUP - FIELD..
  PROCEDURE LU_SELECT_FIELD_7
	          ( P_CURSOR3                           OUT TYPES.TCURSOR3
						, W_FIELD_NAME                        IN HRM_COMMON.VALUE1%TYPE
						, W_VALUE1                            IN HRM_COMMON.VALUE1%TYPE
            , W_VALUE2                            IN HRM_COMMON.VALUE2%TYPE
            , W_VALUE3                            IN HRM_COMMON.VALUE3%TYPE
            , W_VALUE4                            IN HRM_COMMON.VALUE4%TYPE
            , W_VALUE5                            IN HRM_COMMON.VALUE5%TYPE
            , W_VALUE6                            IN HRM_COMMON.VALUE6%TYPE
            , W_VALUE7                            IN HRM_COMMON.VALUE7%TYPE
						, W_SOB_ID                            IN HRM_COMMON.SOB_ID%TYPE
						, W_ORG_ID                            IN HRM_COMMON.ORG_ID%TYPE
						, W_USABLE_CHECK_YN                   IN HRM_COMMON.USABLE%TYPE DEFAULT 'Y'
						);            

-- 공통코드 value1을 조건으로 조회 LOOKUP - FIELD..
  PROCEDURE LU_SELECT_VALUE_GROUP
	          ( P_CURSOR3                           OUT TYPES.TCURSOR3
						, W_GROUP_CODE                        IN HRM_COMMON.GROUP_CODE%TYPE
						, W_CODE_NAME                         IN HRM_COMMON.CODE_NAME%TYPE
						, W_VALUE1                            IN HRM_COMMON.VALUE1%TYPE
						, W_SOB_ID                            IN HRM_COMMON.SOB_ID%TYPE
						, W_ORG_ID                            IN HRM_COMMON.ORG_ID%TYPE
						, W_USABLE_CHECK_YN                   IN HRM_COMMON.USABLE%TYPE DEFAULT 'Y'
						);
						
  PROCEDURE LU_SELECT_VALUE_FIELD
	          ( P_CURSOR3                           OUT TYPES.TCURSOR3
						, W_FIELD_NAME                        IN HRM_COMMON.VALUE1%TYPE
						, W_CODE_NAME                         IN HRM_COMMON.CODE_NAME%TYPE
						, W_VALUE1                            IN HRM_COMMON.VALUE1%TYPE
						, W_SOB_ID                            IN HRM_COMMON.SOB_ID%TYPE
						, W_ORG_ID                            IN HRM_COMMON.ORG_ID%TYPE
						, W_USABLE_CHECK_YN                   IN HRM_COMMON.USABLE%TYPE DEFAULT 'Y'
						);

-----------------------------------------------------------------------------------------
-- 특정값 전용 Default Valeu
  PROCEDURE DV_MONTH_DUTY_TYPE
	          ( W_SOB_ID                            IN HRM_COMMON.SOB_ID%TYPE
						, W_ORG_ID                            IN HRM_COMMON.ORG_ID%TYPE
						, O_ID                                OUT HRM_COMMON.COMMON_ID%TYPE
						, O_CODE                              OUT HRM_COMMON.CODE%TYPE
						, O_CODE_NAME                         OUT HRM_COMMON.CODE_NAME%TYPE
						);						

-- 특정값 전용 LOOKUP.
  PROCEDURE LU_MONTH_DUTY_TYPE
	          ( P_CURSOR3                           OUT TYPES.TCURSOR3
						, W_SOB_ID                            IN HRM_COMMON.SOB_ID%TYPE
						, W_ORG_ID                            IN HRM_COMMON.ORG_ID%TYPE
						, W_USABLE_CHECK_YN                   IN HRM_COMMON.USABLE%TYPE DEFAULT 'Y'
						);

-- 장치ID 조회.
  PROCEDURE LU_CAFETERIA
	          ( P_CURSOR3                           OUT TYPES.TCURSOR3
						, W_USER_ID                           IN HRF_FOOD_MANAGER.USER_ID%TYPE
						, W_SOB_ID                            IN HRF_FOOD_MANAGER.SOB_ID%TYPE
						, W_ORG_ID                            IN HRF_FOOD_MANAGER.ORG_ID%TYPE
						, W_USABLE_CHECK_YN                   IN HRF_FOOD_MANAGER.ENABLED_FLAG%TYPE DEFAULT 'Y'
						);
	
-----------------------------------------------------------------------------------------
-- FUNCTION - WEEK.
  FUNCTION WEEK_F
	         ( W_WEEK_CODE                          IN HRM_COMMON.CODE%TYPE
					 , W_SOB_ID                             IN HRM_COMMON.SOB_ID%TYPE
					 , W_ORG_ID                             IN HRM_COMMON.ORG_ID%TYPE
					 ) RETURN VARCHAR2;												 
	
END HRM_COMMON_G;
/
CREATE OR REPLACE PACKAGE BODY HRM_COMMON_G
AS
/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRM_COMMON_G
/* Description  : 공통코드 관리 패키지
/*
/* Reference by : 인사시스템에서 공통으로 사용하는 마스터 관리.
/* Program History : 
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
-----------------------------------------------------------------------------------------
-- HEADER DATA 조회.
  PROCEDURE COMMON_SELECT_H
	          ( P_CURSOR                            OUT TYPES.TCURSOR
						, W_CODE                              IN VARCHAR2
						, W_CODE_NAME                         IN VARCHAR2
						, W_SOB_ID                            IN NUMBER
						, W_ORG_ID                            IN NUMBER
						)
  AS
  BEGIN
		OPEN P_CURSOR FOR
			SELECT HC.COMMON_ID
					, HC.CODE
					, HC.CODE_NAME
					, HC.CODE_LENGTH
					, HC.VALUE1
					, HC.VALUE2
					, HC.VALUE3
					, HC.VALUE4
					, HC.VALUE5
					, HC.VALUE6
					, HC.VALUE7
			FROM HRM_COMMON HC
			WHERE HC.GROUP_CODE                               = '-'
				AND HC.CODE                                     LIKE W_CODE || '%'
				AND HC.CODE_NAME                                LIKE W_CODE_NAME || '%'
				AND HC.SOB_ID                                   = W_SOB_ID
				AND HC.ORG_ID                                   = W_ORG_ID
			ORDER BY HC.SORT_NUM, HC.CODE
			;

  END COMMON_SELECT_H;
  
-- HEADER INSERT.
  PROCEDURE COMMON_INSERT_H
	          ( P_CODE                              IN VARCHAR2
						, P_CODE_NAME                         IN VARCHAR2
						, P_CODE_LENGHT                       IN NUMBER
						, P_VALUE1                            IN VARCHAR2
						, P_VALUE2                            IN VARCHAR2
						, P_VALUE3                            IN VARCHAR2
						, P_VALUE4                            IN VARCHAR2
						, P_VALUE5                            IN VARCHAR2
						, P_VALUE6                            IN VARCHAR2
						, P_VALUE7                            IN VARCHAR2
						, P_SOB_ID                            IN NUMBER
						, P_ORG_ID                            IN NUMBER
						, P_USER_ID                           IN NUMBER
						)
  AS
	  D_SYSDATE                                             DATE;
		
  BEGIN
	  D_SYSDATE := GET_LOCAL_DATE(P_SOB_ID);
		
		INSERT INTO HRM_COMMON 
		(COMMON_ID, GROUP_CODE, CODE, CODE_NAME, CODE_LENGTH
		, VALUE1, VALUE2, VALUE3, VALUE4, VALUE5, VALUE6, VALUE7
		, USABLE, START_DATE
		, SOB_ID, ORG_ID
		, CREATION_DATE, CREATED_BY, LAST_UPDATE_DATE, LAST_UPDATED_BY
		) VALUES
		(HRM_COMMON_S1.NEXTVAL, '-', P_CODE, P_CODE_NAME, P_CODE_LENGHT
		, P_VALUE1, P_VALUE2, P_VALUE3, P_VALUE4, P_VALUE5, P_VALUE6, P_VALUE7
		, 'Y', TRUNC(SYSDATE)
		, P_SOB_ID, P_ORG_ID
		, D_SYSDATE, P_USER_ID, D_SYSDATE, P_USER_ID
		);
		COMMIT;
  
  END COMMON_INSERT_H;

-- HEADER UPDATE.
  PROCEDURE COMMON_UPDATE_H
	          ( W_COMMON_ID                         IN NUMBER
						, P_CODE_NAME                         IN VARCHAR2
						, P_CODE_LENGHT                       IN NUMBER
						, P_VALUE1                            IN VARCHAR2
						, P_VALUE2                            IN VARCHAR2
						, P_VALUE3                            IN VARCHAR2
						, P_VALUE4                            IN VARCHAR2
						, P_VALUE5                            IN VARCHAR2
						, P_VALUE6                            IN VARCHAR2
						, P_VALUE7                            IN VARCHAR2
						, P_USER_ID                           IN NUMBER
						)
  AS
  BEGIN
		UPDATE HRM_COMMON HC
			SET HC.CODE_NAME                                  = P_CODE_NAME
						, HC.CODE_LENGTH                            = P_CODE_LENGHT
						, HC.VALUE1                                 = P_VALUE1
						, HC.VALUE2                                 = P_VALUE2
						, HC.VALUE3                                 = P_VALUE3
						, HC.VALUE4                                 = P_VALUE4
						, HC.VALUE5                                 = P_VALUE5
						, HC.VALUE6                                 = P_VALUE6
						, HC.VALUE7                                 = P_VALUE7
						, HC.LAST_UPDATE_DATE                       = GET_LOCAL_DATE(HC.SOB_ID)
						, HC.LAST_UPDATED_BY                        = P_USER_ID
		WHERE HC.COMMON_ID                                  = W_COMMON_ID
		;
		COMMIT;
  
  END COMMON_UPDATE_H;
                                                         
-----------------------------------------------------------------------------------------
-- LINE DATA 조회.
  PROCEDURE COMMON_SELECT_L
	          ( P_CURSOR1                           OUT TYPES.TCURSOR1
						, W_GROUP_CODE                        IN VARCHAR2
						, W_SOB_ID                            IN NUMBER
						, W_ORG_ID                            IN NUMBER
						)
  AS
  BEGIN
		OPEN P_CURSOR1 FOR
			SELECT HC.COMMON_ID
					, HC.CODE
					, HC.CODE_NAME
					, HC.VALUE1
					, HC.VALUE2
					, HC.VALUE3
					, HC.VALUE4
					, HC.VALUE5
					, HC.VALUE6
					, HC.VALUE7
					, HC.DEFAULT_FLAG
					, HC.SORT_NUM
					, HC.DESCRIPTION
					, HC.USABLE
					, HC.START_DATE
					, HC.END_DATE            
			FROM HRM_COMMON HC
			WHERE HC.GROUP_CODE                               = W_GROUP_CODE
				AND HC.SOB_ID                                   = W_SOB_ID
				AND HC.ORG_ID                                   = W_ORG_ID
			ORDER BY HC.SORT_NUM, HC.CODE
			;
  
  END COMMON_SELECT_L;
                                                    
-- LINE INSERT.
  PROCEDURE COMMON_INSERT_L
	          ( P_GROUP_CODE                        IN VARCHAR2
						, P_CODE                              IN VARCHAR2
						, P_CODE_NAME                         IN VARCHAR2
						, P_VALUE1                            IN VARCHAR2
						, P_VALUE2                            IN VARCHAR2
						, P_VALUE3                            IN VARCHAR2
						, P_VALUE4                            IN VARCHAR2
						, P_VALUE5                            IN VARCHAR2
						, P_VALUE6                            IN VARCHAR2
						, P_VALUE7                            IN VARCHAR2
						, P_DEFAULT_FLAG                      IN VARCHAR2
						, P_SORT_NUM                          IN NUMBER
						, P_DESCRIPTION                       IN VARCHAR2
						, P_USABLE                            IN VARCHAR2
						, P_START_DATE                        IN DATE
						, P_END_DATE                          IN DATE
						, P_SOB_ID                            IN NUMBER
						, P_ORG_ID                            IN NUMBER
						, P_USER_ID                           IN NUMBER
						)
  AS
	  D_SYSDATE                                             DATE;
		
  BEGIN
	  D_SYSDATE := GET_LOCAL_DATE(P_SOB_ID);
		
		INSERT INTO HRM_COMMON 
		(COMMON_ID, GROUP_CODE, CODE, CODE_NAME
		, VALUE1, VALUE2, VALUE3, VALUE4, VALUE5, VALUE6, VALUE7
		, DEFAULT_FLAG
		, SORT_NUM, DESCRIPTION, USABLE, START_DATE, END_DATE
		, SOB_ID, ORG_ID
		, CREATION_DATE, CREATED_BY, LAST_UPDATE_DATE, LAST_UPDATED_BY
		) VALUES
		(HRM_COMMON_S1.NEXTVAL, P_GROUP_CODE, P_CODE, P_CODE_NAME
		, P_VALUE1, P_VALUE2, P_VALUE3, P_VALUE4, P_VALUE5, P_VALUE6, P_VALUE7
		, P_DEFAULT_FLAG
		, P_SORT_NUM, P_DESCRIPTION, P_USABLE, P_START_DATE, P_END_DATE
		, P_SOB_ID, P_ORG_ID
		, D_SYSDATE, P_USER_ID, D_SYSDATE, P_USER_ID
		);
		COMMIT;
        
  END COMMON_INSERT_L;
  
-- LINE UPDATE.
  PROCEDURE COMMON_UPDATE_L
	          ( W_COMMON_ID                         IN VARCHAR2
						, P_CODE_NAME                         IN VARCHAR2
						, P_VALUE1                            IN VARCHAR2
						, P_VALUE2                            IN VARCHAR2
						, P_VALUE3                            IN VARCHAR2
						, P_VALUE4                            IN VARCHAR2
						, P_VALUE5                            IN VARCHAR2
						, P_VALUE6                            IN VARCHAR2
						, P_VALUE7                            IN VARCHAR2
						, P_DEFAULT_FLAG                      IN VARCHAR2
						, P_SORT_NUM                          IN NUMBER
						, P_DESCRIPTION                       IN VARCHAR2
						, P_USABLE                            IN VARCHAR2
						, P_START_DATE                        IN DATE
						, P_END_DATE                          IN DATE
						, P_USER_ID                           IN NUMBER
						)
  AS
  BEGIN
		UPDATE HRM_COMMON HC
			SET HC.CODE_NAME                              = P_CODE_NAME
						, HC.VALUE1                                 = P_VALUE1
						, HC.VALUE2                                 = P_VALUE2
						, HC.VALUE3                                 = P_VALUE3
						, HC.VALUE4                                 = P_VALUE4
						, HC.VALUE5                                 = P_VALUE5
						, HC.VALUE6                                 = P_VALUE6
						, HC.VALUE7                                 = P_VALUE7
						, HC.DEFAULT_FLAG                           = P_DEFAULT_FLAG
						, HC.SORT_NUM                               = P_SORT_NUM
						, HC.DESCRIPTION                            = P_DESCRIPTION
						, HC.USABLE                                 = P_USABLE
						, HC.START_DATE                             = P_START_DATE
						, HC.END_DATE                               = P_END_DATE
						, HC.LAST_UPDATE_DATE                       = GET_LOCAL_DATE(HC.SOB_ID)
						, HC.LAST_UPDATED_BY                        = P_USER_ID
			WHERE HC.COMMON_ID                                = W_COMMON_ID
			;
			COMMIT;
      
  END COMMON_UPDATE_L;
  
  
-----------------------------------------------------------------------------------------
-- 공통코드 명칭 리턴 FUNCTION.
  FUNCTION ID_NAME_F
	         ( W_COMMON_ID                          IN NUMBER
					 ) RETURN VARCHAR2
  AS
    V_RETURN_VALUE                                        VARCHAR2(150) := NULL;
    
  BEGIN
      BEGIN
          SELECT  HC.CODE_NAME
            INTO V_RETURN_VALUE
          FROM HRM_COMMON HC
          WHERE HC.COMMON_ID                              = W_COMMON_ID
          ;
      EXCEPTION WHEN OTHERS THEN
        V_RETURN_VALUE := NULL;
      END;
      RETURN V_RETURN_VALUE;
      
  END ID_NAME_F;  

  PROCEDURE ID_NAME
	          ( W_COMMON_ID                         IN NUMBER
	          , O_RETURN_VALUE                      OUT VARCHAR2
						)
  AS
	  V_RETURN_VALUE                                       VARCHAR2(150) := NULL;
    
  BEGIN
		BEGIN
				SELECT  HC.CODE_NAME
					INTO V_RETURN_VALUE
				FROM HRM_COMMON HC
				WHERE HC.COMMON_ID                              = W_COMMON_ID
				;
		EXCEPTION WHEN OTHERS THEN
			V_RETURN_VALUE := NULL;
		END;
		O_RETURN_VALUE := V_RETURN_VALUE;

	END ID_NAME;	
  
  FUNCTION CODE_NAME_F
	         ( W_FIELD_NAME                         IN VARCHAR2
					 , W_CODE                               IN VARCHAR2
					 , W_SOB_ID                             IN NUMBER
					 , W_ORG_ID                             IN NUMBER
					 ) RETURN VARCHAR2
  AS
    V_RETURN_VALUE                                        VARCHAR2(150) := NULL;
    
  BEGIN
		BEGIN
			SELECT HC.CODE_NAME
				INTO V_RETURN_VALUE
			FROM HRM_COMMON HC
			WHERE HC.CODE                 = W_CODE
				AND HC.SOB_ID               = W_SOB_ID
				AND HC.ORG_ID               = W_ORG_ID
				AND EXISTS (SELECT 'X'
										FROM HRM_COMMON S_HC
										WHERE S_HC.GROUP_CODE                           = 'HM001'
											AND S_HC.CODE                                 = HC.GROUP_CODE
											AND S_HC.SOB_ID                               = HC.SOB_ID
											AND S_HC.ORG_ID                               = HC.ORG_ID
											AND S_HC.VALUE1                               = W_FIELD_NAME
											AND S_HC.USABLE                               = 'Y'
											AND S_HC.START_DATE                           <= GET_LOCAL_DATE(HC.SOB_ID)
											AND (S_HC.END_DATE IS NULL OR S_HC.END_DATE   >= GET_LOCAL_DATE(HC.SOB_ID))
									 )
			;
		EXCEPTION WHEN OTHERS THEN
			V_RETURN_VALUE := NULL;
		END;
		RETURN V_RETURN_VALUE;
  
  END CODE_NAME_F;                                                

  PROCEDURE CODE_NAME
	          ( W_FIELD_NAME                        IN VARCHAR2
						, W_CODE                              IN VARCHAR2
						, W_SOB_ID                            IN NUMBER
						, W_ORG_ID                            IN NUMBER
						, O_RETURN_VALUE                      OUT VARCHAR2
						)
  AS
	  V_RETURN_VALUE                                        VARCHAR2(150) := NULL;
    
  BEGIN
		BEGIN
			SELECT HC.CODE_NAME
				INTO V_RETURN_VALUE
			FROM HRM_COMMON HC
			WHERE HC.CODE                 = W_CODE
				AND HC.SOB_ID               = W_SOB_ID
				AND HC.ORG_ID               = W_ORG_ID
				AND EXISTS (SELECT 'X'
										FROM HRM_COMMON S_HC
										WHERE S_HC.GROUP_CODE                           = 'HM001'
											AND S_HC.CODE                                 = HC.GROUP_CODE
											AND S_HC.SOB_ID                               = HC.SOB_ID
											AND S_HC.ORG_ID                               = HC.ORG_ID
											AND S_HC.VALUE1                               = W_FIELD_NAME
											AND S_HC.USABLE                               = 'Y'
											AND S_HC.START_DATE                           <= GET_LOCAL_DATE(HC.SOB_ID)
											AND (S_HC.END_DATE IS NULL OR S_HC.END_DATE   >= GET_LOCAL_DATE(HC.SOB_ID))
									 )
			;
		EXCEPTION WHEN OTHERS THEN
			V_RETURN_VALUE := NULL;
		END;
		O_RETURN_VALUE := V_RETURN_VALUE;
	
	
	END CODE_NAME;

-- 근속년수 계산.
  FUNCTION YEAR_COUNT_F
	         ( P_START_DATE                         IN DATE
           , P_END_DATE                           IN DATE
					 , P_COUNT_TYPE                         IN VARCHAR2
					 , P_ROUND_BIT_OVER                     IN NUMBER DEFAULT 0
					 ) RETURN NUMBER
  AS
    N_YEAR_COUNT                                          NUMBER := 0;
  
  BEGIN
		N_YEAR_COUNT := 0;
		IF P_START_DATE IS NULL OR P_END_DATE IS NULL THEN
			N_YEAR_COUNT := 0;
			RETURN N_YEAR_COUNT;
		END IF;
      
		-- 계산 타입별 처리.
		IF P_COUNT_TYPE = 'CEIL' THEN
			N_YEAR_COUNT := CEIL((P_END_DATE - P_START_DATE) / 365);
		ELSIF P_COUNT_TYPE = 'ROUND' THEN
			N_YEAR_COUNT := ROUND((P_END_DATE - P_START_DATE) / 365, P_ROUND_BIT_OVER);
		ELSIF P_COUNT_TYPE = 'TRUNC' THEN
			N_YEAR_COUNT := TRUNC((P_END_DATE - P_START_DATE) / 365);
		ELSE
			N_YEAR_COUNT := (P_END_DATE - P_START_DATE) / 365;
		END IF;
		RETURN N_YEAR_COUNT;
      
  END YEAR_COUNT_F;

	PROCEDURE YEAR_COUNT
	          ( P_START_DATE                        IN DATE
						, P_END_DATE                          IN DATE
						, P_COUNT_TYPE                        IN VARCHAR2
						, P_ROUND_BIT_OVER                    IN NUMBER DEFAULT 0
						, O_RETURN_VALUE                      OUT VARCHAR2
						)
  AS
	  N_YEAR_COUNT                                          NUMBER := 0;
  
  BEGIN
		N_YEAR_COUNT := 0;
		IF P_START_DATE IS NULL OR P_END_DATE IS NULL THEN
			N_YEAR_COUNT := 0;
			O_RETURN_VALUE := N_YEAR_COUNT;
			RETURN;
		END IF;
      
		-- 계산 타입별 처리.
		IF P_COUNT_TYPE = 'CEIL' THEN
			N_YEAR_COUNT := CEIL((P_END_DATE - P_START_DATE) / 365);
		ELSIF P_COUNT_TYPE = 'ROUND' THEN
			N_YEAR_COUNT := ROUND((P_END_DATE - P_START_DATE) / 365, P_ROUND_BIT_OVER);
		ELSIF P_COUNT_TYPE = 'TRUNC' THEN
			N_YEAR_COUNT := TRUNC((P_END_DATE - P_START_DATE) / 365);
		ELSE
			N_YEAR_COUNT := (P_END_DATE - P_START_DATE) / 365;
		END IF;
		O_RETURN_VALUE := N_YEAR_COUNT;
	
	END YEAR_COUNT;


-----------------------------------------------------------------------------------------
-- 공통코드 기본값 리턴 - GROUP CODE..
  PROCEDURE DEFAULT_VALUE_GROUP
	          ( W_GROUP_CODE                        IN HRM_COMMON.GROUP_CODE%TYPE
						, W_SOB_ID                            IN HRM_COMMON.SOB_ID%TYPE
						, W_ORG_ID                            IN HRM_COMMON.ORG_ID%TYPE
						, O_ID                                OUT HRM_COMMON.COMMON_ID%TYPE
						, O_CODE                              OUT HRM_COMMON.CODE%TYPE
						, O_CODE_NAME                         OUT HRM_COMMON.CODE_NAME%TYPE
						)
  AS
	  V_ID                                                  HRM_COMMON.COMMON_ID%TYPE := 0;
		V_CODE                                                HRM_COMMON.CODE%TYPE := NULL;
		V_CODE_NAME                                           HRM_COMMON.CODE_NAME%TYPE := NULL;
		
  BEGIN
    BEGIN
			SELECT HC.CODE_NAME, HC.CODE, HC.COMMON_ID
				INTO V_CODE_NAME, V_CODE, V_ID
				FROM HRM_COMMON HC
			WHERE HC.GROUP_CODE                             = W_GROUP_CODE
				AND HC.SOB_ID                                 = W_SOB_ID
				AND HC.ORG_ID                                 = W_ORG_ID
				AND HC.DEFAULT_FLAG                           = 'Y'
				AND ROWNUM                                    <= 1
				AND HC.START_DATE                             <= GET_LOCAL_DATE(HC.SOB_ID)
				AND (HC.END_DATE IS NULL OR HC.END_DATE       >= GET_LOCAL_DATE(HC.SOB_ID))
			;
	  EXCEPTION WHEN OTHERS THEN
		  V_ID := 0;
		  V_CODE := NULL;
		  V_CODE_NAME := NULL;
	  END;
    O_ID := V_ID;
		O_CODE := V_CODE;
		O_CODE_NAME := V_CODE_NAME;
		
  END DEFAULT_VALUE_GROUP;
                                            
-- 공통코드 기본값 리턴 - FIELD..
  PROCEDURE DEFAULT_VALUE_FIELD
	          ( W_FIELD_NAME                        IN HRM_COMMON.VALUE1%TYPE
						, W_SOB_ID                            IN HRM_COMMON.SOB_ID%TYPE
						, W_ORG_ID                            IN HRM_COMMON.ORG_ID%TYPE
						, O_ID                                OUT HRM_COMMON.COMMON_ID%TYPE
						, O_CODE                              OUT HRM_COMMON.CODE%TYPE
						, O_CODE_NAME                         OUT HRM_COMMON.CODE_NAME%TYPE
						)
  AS
	  V_ID                                                  HRM_COMMON.COMMON_ID%TYPE := 0;
		V_CODE                                                HRM_COMMON.CODE%TYPE := NULL;
		V_CODE_NAME                                           HRM_COMMON.CODE_NAME%TYPE := NULL;
		
  BEGIN
	  BEGIN
			SELECT HC.CODE_NAME, HC.CODE, HC.COMMON_ID
		    INTO V_CODE_NAME, V_CODE, V_ID
			  FROM HRM_COMMON HC
			WHERE HC.SOB_ID                                 = W_SOB_ID
				AND HC.ORG_ID                                 = W_ORG_ID
				AND HC.DEFAULT_FLAG                           = 'Y'
				AND ROWNUM                                    <= 1
				AND HC.START_DATE                             <= GET_LOCAL_DATE(HC.SOB_ID)
				AND (HC.END_DATE IS NULL OR HC.END_DATE       >= GET_LOCAL_DATE(HC.SOB_ID))
				AND EXISTS (SELECT 'X'
										  FROM HRM_COMMON S_HC
										WHERE S_HC.GROUP_CODE                   = 'HM001'
											AND S_HC.CODE                         = HC.GROUP_CODE
											AND S_HC.SOB_ID                       = HC.SOB_ID
											AND S_HC.ORG_ID                       = HC.ORG_ID
											AND S_HC.VALUE1                       = W_FIELD_NAME
											AND S_HC.USABLE                       = 'Y'
											AND S_HC.START_DATE                   <= GET_LOCAL_DATE(S_HC.SOB_ID)
											AND (S_HC.END_DATE IS NULL OR S_HC.END_DATE >= GET_LOCAL_DATE(S_HC.SOB_ID))
										)
			;
    EXCEPTION WHEN OTHERS THEN
		  V_ID := 0;
		  V_CODE := NULL;
		  V_CODE_NAME := NULL;
	  END;
    O_ID := V_ID;
		O_CODE := V_CODE;
		O_CODE_NAME := V_CODE_NAME;
		
  END DEFAULT_VALUE_FIELD;
	

-- 공통코드 기본값 리턴 - VALUE1을 조건 검색하여 : GROUP CODE..
  PROCEDURE DEFAULT_VALUE_GROUP_W
	          ( W_GROUP_CODE                        IN HRM_COMMON.GROUP_CODE%TYPE
						, W_VALUE1                            IN HRM_COMMON.VALUE1%TYPE
						, W_SOB_ID                            IN HRM_COMMON.SOB_ID%TYPE
						, W_ORG_ID                            IN HRM_COMMON.ORG_ID%TYPE
						, O_ID                                OUT HRM_COMMON.COMMON_ID%TYPE
						, O_CODE                              OUT HRM_COMMON.CODE%TYPE
						, O_CODE_NAME                         OUT HRM_COMMON.CODE_NAME%TYPE
						)
  AS
	  V_ID                                          HRM_COMMON.COMMON_ID%TYPE := 0;
		V_CODE                                        HRM_COMMON.CODE%TYPE := NULL;
		V_CODE_NAME                                   HRM_COMMON.CODE_NAME%TYPE := NULL;
		
  BEGIN
    BEGIN
			SELECT HC.CODE_NAME, HC.CODE, HC.COMMON_ID
				INTO V_CODE_NAME, V_CODE, V_ID
				FROM HRM_COMMON HC
			WHERE HC.GROUP_CODE                             = W_GROUP_CODE
			  AND HC.VALUE1                                 = W_VALUE1
				AND HC.SOB_ID                                 = W_SOB_ID
				AND HC.ORG_ID                                 = W_ORG_ID
				AND HC.DEFAULT_FLAG                           = 'Y'
				AND ROWNUM                                    <= 1
				AND HC.START_DATE                             <= GET_LOCAL_DATE(HC.SOB_ID)
				AND (HC.END_DATE IS NULL OR HC.END_DATE       >= GET_LOCAL_DATE(HC.SOB_ID))
			;
	  EXCEPTION WHEN OTHERS THEN
		  V_ID := 0;
		  V_CODE := NULL;
		  V_CODE_NAME := NULL;
	  END;
    O_ID := V_ID;
		O_CODE := V_CODE;
		O_CODE_NAME := V_CODE_NAME;	
	
	END DEFAULT_VALUE_GROUP_W;                                  
                                            
-- 공통코드 기본값 리턴 - VALUE1을 조건 검색하여 : FIELD..
  PROCEDURE DEFAULT_VALUE_FIELD_W
	          ( W_FIELD_NAME                        IN HRM_COMMON.VALUE1%TYPE
						, W_VALUE1                            IN HRM_COMMON.VALUE1%TYPE
						, W_SOB_ID                            IN HRM_COMMON.SOB_ID%TYPE
						, W_ORG_ID                            IN HRM_COMMON.ORG_ID%TYPE
						, O_ID                                OUT HRM_COMMON.COMMON_ID%TYPE
						, O_CODE                              OUT HRM_COMMON.CODE%TYPE
						, O_CODE_NAME                         OUT HRM_COMMON.CODE_NAME%TYPE
						)
  AS
	  V_ID                                          HRM_COMMON.COMMON_ID%TYPE := 0;
		V_CODE                                        HRM_COMMON.CODE%TYPE := NULL;
		V_CODE_NAME                                   HRM_COMMON.CODE_NAME%TYPE := NULL;
		
  BEGIN
	  BEGIN
			SELECT HC.CODE_NAME, HC.CODE, HC.COMMON_ID
		    INTO V_CODE_NAME, V_CODE, V_ID
			  FROM HRM_COMMON HC
			WHERE HC.SOB_ID                                 = W_SOB_ID
				AND HC.ORG_ID                                 = W_ORG_ID
				AND HC.VALUE1                                 = W_VALUE1
				AND HC.DEFAULT_FLAG                           = 'Y'
				AND ROWNUM                                    <= 1
				AND HC.START_DATE                             <= GET_LOCAL_DATE(HC.SOB_ID)
				AND (HC.END_DATE IS NULL OR HC.END_DATE       >= GET_LOCAL_DATE(HC.SOB_ID))
				AND EXISTS (SELECT 'X'
										  FROM HRM_COMMON S_HC
										WHERE S_HC.GROUP_CODE                   = 'HM001'
											AND S_HC.CODE                         = HC.GROUP_CODE
											AND S_HC.SOB_ID                       = HC.SOB_ID
											AND S_HC.ORG_ID                       = HC.ORG_ID
											AND S_HC.VALUE1                       = W_FIELD_NAME
											AND S_HC.USABLE                       = 'Y'
											AND S_HC.START_DATE                   <= GET_LOCAL_DATE(S_HC.SOB_ID)
											AND (S_HC.END_DATE IS NULL OR S_HC.END_DATE >= GET_LOCAL_DATE(S_HC.SOB_ID))
										)
			;
    EXCEPTION WHEN OTHERS THEN
		  V_ID := 0;
		  V_CODE := NULL;
		  V_CODE_NAME := NULL;
	  END;
    O_ID := V_ID;
		O_CODE := V_CODE;
		O_CODE_NAME := V_CODE_NAME;	
	
	END DEFAULT_VALUE_FIELD_W;

-- 공통코드 기본값 리턴 - VALUE1과 VLAUE2을 조건 검색하여 : FIELD..
  PROCEDURE DEFAULT_VALUE_FIELD_W2
	          ( W_FIELD_NAME                        IN HRM_COMMON.VALUE1%TYPE
						, W_VALUE1                            IN HRM_COMMON.VALUE1%TYPE
						, W_VALUE2                            IN HRM_COMMON.VALUE2%TYPE
						, W_SOB_ID                            IN HRM_COMMON.SOB_ID%TYPE
						, W_ORG_ID                            IN HRM_COMMON.ORG_ID%TYPE
						, O_ID                                OUT HRM_COMMON.COMMON_ID%TYPE
						, O_CODE                              OUT HRM_COMMON.CODE%TYPE
						, O_CODE_NAME                         OUT HRM_COMMON.CODE_NAME%TYPE
						)
  AS
	  V_ID                                          HRM_COMMON.COMMON_ID%TYPE := 0;
		V_CODE                                        HRM_COMMON.CODE%TYPE := NULL;
		V_CODE_NAME                                   HRM_COMMON.CODE_NAME%TYPE := NULL;
		
  BEGIN
	  BEGIN
			SELECT HC.CODE_NAME, HC.CODE, HC.COMMON_ID
		    INTO V_CODE_NAME, V_CODE, V_ID
			  FROM HRM_COMMON HC
			WHERE HC.SOB_ID                                 = W_SOB_ID
				AND HC.ORG_ID                                 = W_ORG_ID
				AND HC.VALUE1                                 = W_VALUE1
				AND HC.VALUE2                                 = W_VALUE2
				AND HC.DEFAULT_FLAG                           = 'Y'
				AND ROWNUM                                    <= 1
				AND HC.START_DATE                             <= GET_LOCAL_DATE(HC.SOB_ID)
				AND (HC.END_DATE IS NULL OR HC.END_DATE       >= GET_LOCAL_DATE(HC.SOB_ID))
				AND EXISTS (SELECT 'X'
										  FROM HRM_COMMON S_HC
										WHERE S_HC.GROUP_CODE                   = 'HM001'
											AND S_HC.CODE                         = HC.GROUP_CODE
											AND S_HC.SOB_ID                       = HC.SOB_ID
											AND S_HC.ORG_ID                       = HC.ORG_ID
											AND S_HC.VALUE1                       = W_FIELD_NAME
											AND S_HC.USABLE                       = 'Y'
											AND S_HC.START_DATE                   <= GET_LOCAL_DATE(S_HC.SOB_ID)
											AND (S_HC.END_DATE IS NULL OR S_HC.END_DATE >= GET_LOCAL_DATE(S_HC.SOB_ID))
										)
			;
    EXCEPTION WHEN OTHERS THEN
		  V_ID := 0;
		  V_CODE := NULL;
		  V_CODE_NAME := NULL;
	  END;
    O_ID := V_ID;
		O_CODE := V_CODE;
		O_CODE_NAME := V_CODE_NAME;	
	
	END DEFAULT_VALUE_FIELD_W2;
	
-----------------------------------------------------------------------------------------
-- 공통코드 조회 LOOKUP - GROUP CODE.
  PROCEDURE LU_SELECT_GROUP
	          ( P_CURSOR3                           OUT TYPES.TCURSOR3
						, W_GROUP_CODE                        IN HRM_COMMON.GROUP_CODE%TYPE
						, W_CODE_NAME                         IN HRM_COMMON.CODE_NAME%TYPE
						, W_SOB_ID                            IN HRM_COMMON.SOB_ID%TYPE
						, W_ORG_ID                            IN HRM_COMMON.ORG_ID%TYPE
						, W_USABLE_CHECK_YN                   IN HRM_COMMON.USABLE%TYPE DEFAULT 'Y'
						)
  AS
	  V_STD_DATE                                    HRM_COMMON.START_DATE%TYPE := NULL;
		
  BEGIN
	  IF W_USABLE_CHECK_YN = 'Y' THEN
		  V_STD_DATE := GET_LOCAL_DATE(W_SOB_ID);
		ELSE
		  V_STD_DATE := NULL;
		END IF;
		
		OPEN P_CURSOR3 FOR
			SELECT HC.CODE_NAME
					, HC.CODE
					, HC.COMMON_ID
					, HC.VALUE1
					, HC.VALUE2
					, HC.VALUE3
					, HC.VALUE4
					, HC.VALUE5
					, HC.VALUE6
					, HC.VALUE7
			FROM HRM_COMMON HC
			WHERE HC.GROUP_CODE                             = W_GROUP_CODE
				AND HC.CODE_NAME                              LIKE W_CODE_NAME || '%'
				AND HC.SOB_ID                                 = W_SOB_ID
				AND HC.ORG_ID                                 = W_ORG_ID
				AND HC.USABLE                                 = DECODE(W_USABLE_CHECK_YN, 'Y', 'Y', HC.USABLE)
				AND HC.START_DATE                             <= NVL(V_STD_DATE, HC.START_DATE)
				AND (HC.END_DATE IS NULL OR HC.END_DATE       >= NVL(V_STD_DATE, HC.END_DATE))
			ORDER BY HC.SORT_NUM, HC.CODE
			;
  
  END LU_SELECT_GROUP;
  
-- 공통코드 조회 LOOKUP - GROUP CODE..
  PROCEDURE LU_SELECT_GROUP_7
	          ( P_CURSOR3                           OUT TYPES.TCURSOR3
						, W_GROUP_CODE                        IN HRM_COMMON.GROUP_CODE%TYPE
						, W_VALUE1                            IN HRM_COMMON.VALUE1%TYPE
            , W_VALUE2                            IN HRM_COMMON.VALUE2%TYPE
            , W_VALUE3                            IN HRM_COMMON.VALUE3%TYPE
            , W_VALUE4                            IN HRM_COMMON.VALUE4%TYPE
            , W_VALUE5                            IN HRM_COMMON.VALUE5%TYPE
            , W_VALUE6                            IN HRM_COMMON.VALUE6%TYPE
            , W_VALUE7                            IN HRM_COMMON.VALUE7%TYPE
						, W_SOB_ID                            IN HRM_COMMON.SOB_ID%TYPE
						, W_ORG_ID                            IN HRM_COMMON.ORG_ID%TYPE
						, W_USABLE_CHECK_YN                   IN HRM_COMMON.USABLE%TYPE DEFAULT 'Y'
						)
  AS
    V_STD_DATE                                    HRM_COMMON.START_DATE%TYPE := NULL;
		
  BEGIN
	  IF W_USABLE_CHECK_YN = 'Y' THEN
		  V_STD_DATE := GET_LOCAL_DATE(W_SOB_ID);
		ELSE
		  V_STD_DATE := NULL;
		END IF;
		
		OPEN P_CURSOR3 FOR
			SELECT HC.CODE_NAME
          , HC.CODE
          , HC.COMMON_ID
          , HC.VALUE1
          , HC.VALUE2
          , HC.VALUE3
          , HC.VALUE4
          , HC.VALUE5
          , HC.VALUE6
          , HC.VALUE7
      FROM HRM_COMMON HC
      WHERE HC.GROUP_CODE                             = W_GROUP_CODE
        AND NVL(HC.VALUE1, '-')                       = NVL(W_VALUE1, NVL(HC.VALUE1, '-'))
        AND NVL(HC.VALUE2, '-')                       = NVL(W_VALUE2, NVL(HC.VALUE2, '-'))
        AND NVL(HC.VALUE3, '-')                       = NVL(W_VALUE3, NVL(HC.VALUE3, '-'))
        AND NVL(HC.VALUE4, '-')                       = NVL(W_VALUE4, NVL(HC.VALUE4, '-'))
        AND NVL(HC.VALUE5, '-')                       = NVL(W_VALUE5, NVL(HC.VALUE5, '-'))
        AND NVL(HC.VALUE6, '-')                       = NVL(W_VALUE6, NVL(HC.VALUE6, '-'))
        AND NVL(HC.VALUE7, '-')                       = NVL(W_VALUE7, NVL(HC.VALUE7, '-'))
        AND HC.SOB_ID                                 = W_SOB_ID
        AND HC.ORG_ID                                 = W_ORG_ID
        AND HC.USABLE                                 = DECODE(W_USABLE_CHECK_YN, 'Y', 'Y', HC.USABLE)
        AND HC.START_DATE                             <= NVL(V_STD_DATE, HC.START_DATE)
        AND (HC.END_DATE IS NULL OR HC.END_DATE       >= NVL(V_STD_DATE, HC.END_DATE))
      ORDER BY HC.SORT_NUM, HC.CODE
			;  
  
  END LU_SELECT_GROUP_7;  
  
-- 공통코드 조회 LOOKUP - FIELD.
  PROCEDURE LU_SELECT_FIELD
	          ( P_CURSOR3                           OUT TYPES.TCURSOR3
						, W_FIELD_NAME                        IN HRM_COMMON.VALUE1%TYPE
						, W_CODE_NAME                         IN HRM_COMMON.CODE_NAME%TYPE
						, W_SOB_ID                            IN HRM_COMMON.SOB_ID%TYPE
						, W_ORG_ID                            IN HRM_COMMON.ORG_ID%TYPE
						, W_USABLE_CHECK_YN                   IN HRM_COMMON.USABLE%TYPE DEFAULT 'Y'
						)
  AS
	  V_STD_DATE                                    HRM_COMMON.START_DATE%TYPE := NULL;
		
  BEGIN
	  IF W_USABLE_CHECK_YN = 'Y' THEN
		  V_STD_DATE := GET_LOCAL_DATE(W_SOB_ID);
		ELSE
		  V_STD_DATE := NULL;
		END IF;
		
		OPEN P_CURSOR3 FOR
			SELECT HC.CODE_NAME
					, HC.CODE
					, HC.COMMON_ID
					, HC.VALUE1
					, HC.VALUE2
					, HC.VALUE3
					, HC.VALUE4
					, HC.VALUE5
					, HC.VALUE6
					, HC.VALUE7
			FROM HRM_COMMON HC
			WHERE HC.CODE_NAME                              LIKE W_CODE_NAME || '%'
				AND HC.SOB_ID                                 = W_SOB_ID
				AND HC.ORG_ID                                 = W_ORG_ID
				AND HC.USABLE                                 = DECODE(W_USABLE_CHECK_YN, 'Y', 'Y', HC.USABLE)
				AND HC.START_DATE                             <= NVL(V_STD_DATE, HC.START_DATE)
				AND (HC.END_DATE IS NULL OR HC.END_DATE       >= NVL(V_STD_DATE, HC.END_DATE))
				AND EXISTS ( SELECT 'X'
																		FROM HRM_COMMON S_HC
																		WHERE S_HC.GROUP_CODE                   = 'HM001'
																			AND S_HC.CODE                         = HC.GROUP_CODE
																			AND S_HC.SOB_ID                       = HC.SOB_ID
																			AND S_HC.ORG_ID                       = HC.ORG_ID
																			AND S_HC.VALUE1                       = W_FIELD_NAME
																			AND S_HC.USABLE                       = DECODE(W_USABLE_CHECK_YN, 'Y', 'Y', S_HC.USABLE)
																			AND S_HC.START_DATE                   <= NVL(V_STD_DATE, S_HC.START_DATE)
																			AND (S_HC.END_DATE IS NULL OR S_HC.END_DATE >= NVL(V_STD_DATE, S_HC.START_DATE))
																		)
			ORDER BY HC.SORT_NUM, HC.CODE
			;
  
  END LU_SELECT_FIELD;
  
-- 공통코드 조회 LOOKUP - FIELD..
  PROCEDURE LU_SELECT_FIELD_7
	          ( P_CURSOR3                           OUT TYPES.TCURSOR3
						, W_FIELD_NAME                        IN HRM_COMMON.VALUE1%TYPE
						, W_VALUE1                            IN HRM_COMMON.VALUE1%TYPE
            , W_VALUE2                            IN HRM_COMMON.VALUE2%TYPE
            , W_VALUE3                            IN HRM_COMMON.VALUE3%TYPE
            , W_VALUE4                            IN HRM_COMMON.VALUE4%TYPE
            , W_VALUE5                            IN HRM_COMMON.VALUE5%TYPE
            , W_VALUE6                            IN HRM_COMMON.VALUE6%TYPE
            , W_VALUE7                            IN HRM_COMMON.VALUE7%TYPE
						, W_SOB_ID                            IN HRM_COMMON.SOB_ID%TYPE
						, W_ORG_ID                            IN HRM_COMMON.ORG_ID%TYPE
						, W_USABLE_CHECK_YN                   IN HRM_COMMON.USABLE%TYPE DEFAULT 'Y'
						)
  AS
    V_STD_DATE                                    HRM_COMMON.START_DATE%TYPE := NULL;
		
  BEGIN
	  IF W_USABLE_CHECK_YN = 'Y' THEN
		  V_STD_DATE := GET_LOCAL_DATE(W_SOB_ID);
		ELSE
		  V_STD_DATE := NULL;
		END IF;
		
		OPEN P_CURSOR3 FOR
			SELECT HC.CODE_NAME
					, HC.CODE
					, HC.COMMON_ID
					, HC.VALUE1
					, HC.VALUE2
					, HC.VALUE3
					, HC.VALUE4
					, HC.VALUE5
					, HC.VALUE6
					, HC.VALUE7
			FROM HRM_COMMON HC
			WHERE NVL(HC.VALUE1, '-')                       = NVL(W_VALUE1, NVL(HC.VALUE1, '-'))
        AND NVL(HC.VALUE2, '-')                       = NVL(W_VALUE2, NVL(HC.VALUE2, '-'))
        AND NVL(HC.VALUE3, '-')                       = NVL(W_VALUE3, NVL(HC.VALUE3, '-'))
        AND NVL(HC.VALUE4, '-')                       = NVL(W_VALUE4, NVL(HC.VALUE4, '-'))
        AND NVL(HC.VALUE5, '-')                       = NVL(W_VALUE5, NVL(HC.VALUE5, '-'))
        AND NVL(HC.VALUE6, '-')                       = NVL(W_VALUE6, NVL(HC.VALUE6, '-'))
        AND NVL(HC.VALUE7, '-')                       = NVL(W_VALUE7, NVL(HC.VALUE7, '-'))
        AND HC.SOB_ID                                 = W_SOB_ID
				AND HC.ORG_ID                                 = W_ORG_ID
				AND HC.USABLE                                 = DECODE(W_USABLE_CHECK_YN, 'Y', 'Y', HC.USABLE)
				AND HC.START_DATE                             <= NVL(V_STD_DATE, HC.START_DATE)
				AND (HC.END_DATE IS NULL OR HC.END_DATE       >= NVL(V_STD_DATE, HC.END_DATE))
				AND EXISTS ( SELECT 'X'
																		FROM HRM_COMMON S_HC
																		WHERE S_HC.GROUP_CODE                   = 'HM001'
																			AND S_HC.CODE                         = HC.GROUP_CODE
																			AND S_HC.SOB_ID                       = HC.SOB_ID
																			AND S_HC.ORG_ID                       = HC.ORG_ID
																			AND S_HC.VALUE1                       = W_FIELD_NAME
																			AND S_HC.USABLE                       = DECODE(W_USABLE_CHECK_YN, 'Y', 'Y', S_HC.USABLE)
																			AND S_HC.START_DATE                   <= NVL(V_STD_DATE, S_HC.START_DATE)
																			AND (S_HC.END_DATE IS NULL OR S_HC.END_DATE >= NVL(V_STD_DATE, S_HC.START_DATE))
																		)
			ORDER BY HC.SORT_NUM, HC.CODE
			;  
  
  END LU_SELECT_FIELD_7;

-- 공통코드 value1을 조건으로 조회 LOOKUP - FIELD..
  PROCEDURE LU_SELECT_VALUE_GROUP
	          ( P_CURSOR3                           OUT TYPES.TCURSOR3
						, W_GROUP_CODE                        IN HRM_COMMON.GROUP_CODE%TYPE
						, W_CODE_NAME                         IN HRM_COMMON.CODE_NAME%TYPE
						, W_VALUE1                            IN HRM_COMMON.VALUE1%TYPE
						, W_SOB_ID                            IN HRM_COMMON.SOB_ID%TYPE
						, W_ORG_ID                            IN HRM_COMMON.ORG_ID%TYPE
						, W_USABLE_CHECK_YN                   IN HRM_COMMON.USABLE%TYPE DEFAULT 'Y'
						)
  AS
	  V_STD_DATE                                    HRM_COMMON.START_DATE%TYPE := NULL;
		
  BEGIN
	  IF W_USABLE_CHECK_YN = 'Y' THEN
		  V_STD_DATE := GET_LOCAL_DATE(W_SOB_ID);
		ELSE
		  V_STD_DATE := NULL;
		END IF;
		
		OPEN P_CURSOR3 FOR
			SELECT HC.CODE_NAME
					, HC.CODE
					, HC.COMMON_ID
					, HC.VALUE1
					, HC.VALUE2
					, HC.VALUE3
					, HC.VALUE4
					, HC.VALUE5
					, HC.VALUE6
					, HC.VALUE7
			FROM HRM_COMMON HC
			WHERE HC.GROUP_CODE                             = W_GROUP_CODE
			  AND HC.CODE_NAME                              LIKE W_CODE_NAME || '%'
				AND HC.VALUE1                                 = NVL(W_VALUE1, HC.VALUE1)
				AND HC.SOB_ID                                 = W_SOB_ID
				AND HC.ORG_ID                                 = W_ORG_ID
				AND HC.USABLE                                 = DECODE(W_USABLE_CHECK_YN, 'Y', 'Y', HC.USABLE)
				AND HC.START_DATE                             <= NVL(V_STD_DATE, HC.START_DATE)
				AND (HC.END_DATE IS NULL OR HC.END_DATE       >= NVL(V_STD_DATE, HC.END_DATE))
			ORDER BY HC.SORT_NUM, HC.CODE
			;	
	
	END LU_SELECT_VALUE_GROUP;
	
	
  PROCEDURE LU_SELECT_VALUE_FIELD
	          ( P_CURSOR3                           OUT TYPES.TCURSOR3
						, W_FIELD_NAME                        IN HRM_COMMON.VALUE1%TYPE
						, W_CODE_NAME                         IN HRM_COMMON.CODE_NAME%TYPE
						, W_VALUE1                            IN HRM_COMMON.VALUE1%TYPE
						, W_SOB_ID                            IN HRM_COMMON.SOB_ID%TYPE
						, W_ORG_ID                            IN HRM_COMMON.ORG_ID%TYPE
						, W_USABLE_CHECK_YN                   IN HRM_COMMON.USABLE%TYPE DEFAULT 'Y'
						)
  AS
    V_STD_DATE                                    HRM_COMMON.START_DATE%TYPE := NULL;
		
  BEGIN
	  IF W_USABLE_CHECK_YN = 'Y' THEN
		  V_STD_DATE := GET_LOCAL_DATE(W_SOB_ID);
		ELSE
		  V_STD_DATE := NULL;
		END IF;
		
		OPEN P_CURSOR3 FOR
			SELECT HC.CODE_NAME
					, HC.CODE
					, HC.COMMON_ID
					, HC.VALUE1
					, HC.VALUE2
					, HC.VALUE3
					, HC.VALUE4
					, HC.VALUE5
					, HC.VALUE6
					, HC.VALUE7
			FROM HRM_COMMON HC
			WHERE HC.CODE_NAME                              LIKE W_CODE_NAME || '%'
				AND HC.VALUE1                                 = NVL(W_VALUE1, HC.VALUE1)
				AND HC.SOB_ID                                 = W_SOB_ID
				AND HC.ORG_ID                                 = W_ORG_ID
				AND HC.USABLE                                 = DECODE(W_USABLE_CHECK_YN, 'Y', 'Y', HC.USABLE)
				AND HC.START_DATE                             <= NVL(V_STD_DATE, HC.START_DATE)
				AND (HC.END_DATE IS NULL OR HC.END_DATE       >= NVL(V_STD_DATE, HC.END_DATE))
				AND EXISTS ( SELECT 'X'
																		FROM HRM_COMMON S_HC
																		WHERE S_HC.GROUP_CODE                   = 'HM001'
																			AND S_HC.CODE                         = HC.GROUP_CODE
																			AND S_HC.SOB_ID                       = HC.SOB_ID
																			AND S_HC.ORG_ID                       = HC.ORG_ID
																			AND S_HC.VALUE1                       = W_FIELD_NAME
																			AND S_HC.USABLE                       = DECODE(W_USABLE_CHECK_YN, 'Y', 'Y', S_HC.USABLE)
																			AND S_HC.START_DATE                   <= NVL(V_STD_DATE, S_HC.START_DATE)
																			AND (S_HC.END_DATE IS NULL OR S_HC.END_DATE >= NVL(V_STD_DATE, S_HC.END_DATE))
																		)
			ORDER BY HC.SORT_NUM, HC.CODE
			;
  
  END LU_SELECT_VALUE_FIELD;

-----------------------------------------------------------------------------------------
-- 특정값 전용 Default Valeu
  PROCEDURE DV_MONTH_DUTY_TYPE
	          ( W_SOB_ID                            IN HRM_COMMON.SOB_ID%TYPE
						, W_ORG_ID                            IN HRM_COMMON.ORG_ID%TYPE
						, O_ID                                OUT HRM_COMMON.COMMON_ID%TYPE
						, O_CODE                              OUT HRM_COMMON.CODE%TYPE
						, O_CODE_NAME                         OUT HRM_COMMON.CODE_NAME%TYPE
						)
  AS
	  V_ID                                          HRM_COMMON.COMMON_ID%TYPE := 0;
		V_CODE                                        HRM_COMMON.CODE%TYPE := NULL;
		V_CODE_NAME                                   HRM_COMMON.CODE_NAME%TYPE := NULL;
		
  BEGIN
	  BEGIN
		  SELECT CT.CLOSING_TYPE_NAME
					, CT.CLOSING_TYPE
					, CT.CLOSING_TYPE_ID
		  INTO V_CODE_NAME, V_CODE, V_ID
			FROM HRM_CLOSING_TYPE_V CT
			WHERE CT.MODULE_TYPE                            = 'DUTY'
			  AND CT.MONTH_TOTAL_YN                         = 'Y'
				AND CT.SOB_ID                                 = W_SOB_ID
				AND CT.ORG_ID                                 = W_ORG_ID
				AND CT.DEFAULT_FLAG                           = 'Y'
				AND ROWNUM                                    <= 1
				AND CT.USABLE                                 = 'Y'
				AND CT.START_DATE                             <= GET_LOCAL_DATE(CT.SOB_ID)
				AND (CT.END_DATE IS NULL OR CT.END_DATE       >= GET_LOCAL_DATE(CT.SOB_ID))
			;
    EXCEPTION WHEN OTHERS THEN
		  V_ID := 0;
		  V_CODE := NULL;
		  V_CODE_NAME := NULL;
	  END;
    O_ID := V_ID;
		O_CODE := V_CODE;
		O_CODE_NAME := V_CODE_NAME;		
	
	
	END DV_MONTH_DUTY_TYPE;
	
-- 특정값 전용 LOOKUP.
  PROCEDURE LU_MONTH_DUTY_TYPE
	          ( P_CURSOR3                           OUT TYPES.TCURSOR3
						, W_SOB_ID                            IN HRM_COMMON.SOB_ID%TYPE
						, W_ORG_ID                            IN HRM_COMMON.ORG_ID%TYPE
						, W_USABLE_CHECK_YN                   IN HRM_COMMON.USABLE%TYPE DEFAULT 'Y'
						)
  AS
	  V_STD_DATE                                    HRM_COMMON.START_DATE%TYPE := NULL;
		
	BEGIN
	  IF W_USABLE_CHECK_YN = 'Y' THEN
		  V_STD_DATE := GET_LOCAL_DATE(W_SOB_ID);
		ELSE
		  V_STD_DATE := NULL;
		END IF;
		
		OPEN P_CURSOR3 FOR
			SELECT CT.CLOSING_TYPE_NAME
					, CT.CLOSING_TYPE
					, CT.CLOSING_TYPE_ID
			FROM HRM_CLOSING_TYPE_V CT
			WHERE CT.MODULE_TYPE                            = 'DUTY'
			  AND CT.MONTH_TOTAL_YN                         = 'Y'
				AND CT.SOB_ID                                 = W_SOB_ID
				AND CT.ORG_ID                                 = W_ORG_ID
				AND CT.USABLE                                 = DECODE(W_USABLE_CHECK_YN, 'Y', 'Y', CT.USABLE)
				AND CT.START_DATE                             <= NVL(V_STD_DATE, CT.START_DATE)
				AND (CT.END_DATE IS NULL OR CT.END_DATE       >= NVL(V_STD_DATE, CT.END_DATE))
			ORDER BY CT.SORT_NUM, CT.CLOSING_TYPE
			;
			
	END LU_MONTH_DUTY_TYPE;

-- 식당명 조회.
  PROCEDURE LU_CAFETERIA
	          ( P_CURSOR3                           OUT TYPES.TCURSOR3
						, W_USER_ID                           IN HRF_FOOD_MANAGER.USER_ID%TYPE
						, W_SOB_ID                            IN HRF_FOOD_MANAGER.SOB_ID%TYPE
						, W_ORG_ID                            IN HRF_FOOD_MANAGER.ORG_ID%TYPE
						, W_USABLE_CHECK_YN                   IN HRF_FOOD_MANAGER.ENABLED_FLAG%TYPE DEFAULT 'Y'
						)
  AS
	  V_STD_DATE                                    HRM_COMMON.START_DATE%TYPE := NULL;
		
	BEGIN
	  IF W_USABLE_CHECK_YN = 'Y' THEN
		  V_STD_DATE := GET_LOCAL_DATE(W_SOB_ID);
		ELSE
		  V_STD_DATE := NULL;
		END IF;
		
	  OPEN P_CURSOR3 FOR
		  SELECT HD.DEVICE_NAME
			     , HD.DEVICE_CODE
					 , HD.DEVICE_ID
					 , HD.SOURCE_DEVICE_CODE
					 , HD.VALUE2
					 , HD.MODULE_TYPE
					 , HD.VALUE4
					 , HD.VALUE5
					 , HD.VALUE6
					 , HD.VALUE7
				FROM HRF_FOOD_MANAGER FM
					 , HRM_DEVICE_V HD
			 WHERE FM.DEVICE_ID             = HD.DEVICE_ID
				 AND FM.USER_ID               = W_USER_ID
				 AND FM.SOB_ID                = W_SOB_ID
				 AND FM.ORG_ID                = W_ORG_ID
				 AND FM.ENABLED_FLAG          = DECODE(W_USABLE_CHECK_YN, 'Y', 'Y', FM.ENABLED_FLAG)
				 AND FM.EFFECTIVE_DATE_FR     <= NVL(V_STD_DATE, FM.EFFECTIVE_DATE_FR)
				 AND (FM.EFFECTIVE_DATE_TO IS NULL OR FM.EFFECTIVE_DATE_TO  >= NVL(V_STD_DATE, FM.EFFECTIVE_DATE_TO))
		  ORDER BY HD.SORT_NUM
			;

	END LU_CAFETERIA;
	
-----------------------------------------------------------------------------------------
-- FUNCTION - WEEK.
  FUNCTION WEEK_F
	         ( W_WEEK_CODE                          IN HRM_COMMON.CODE%TYPE
					 , W_SOB_ID                             IN HRM_COMMON.SOB_ID%TYPE
					 , W_ORG_ID                             IN HRM_COMMON.ORG_ID%TYPE
					 ) RETURN VARCHAR2
  AS
	  V_GROUP_CODE                                  VARCHAR2(50);
	  V_RETURN_VALUE                                VARCHAR2(50);
	
	BEGIN
	  BEGIN
		  SELECT HC.CODE
			  INTO V_GROUP_CODE
        FROM HRM_COMMON HC
       WHERE HC.GROUP_CODE                   = 'HM001'
				 AND HC.SOB_ID                       = W_SOB_ID
				 AND HC.ORG_ID                       = W_ORG_ID
				 AND HC.VALUE1                       = 'WEEK'
				 AND HC.USABLE                       = 'Y'
				 AND HC.START_DATE                   <= GET_LOCAL_DATE(W_SOB_ID)
				 AND (HC.END_DATE IS NULL OR HC.END_DATE >= GET_LOCAL_DATE(W_SOB_ID))
				;
		EXCEPTION WHEN OTHERS THEN
		  V_RETURN_VALUE := '-';
			DBMS_OUTPUT.PUT_LINE('V_GROUP_CODE : ' || V_GROUP_CODE || ', V_RETURN_VALUE : ' || V_RETURN_VALUE);
			RETURN V_RETURN_VALUE;
		END;
		
	  BEGIN
			SELECT HC.CODE_NAME WEEK
			  INTO V_RETURN_VALUE
			  FROM HRM_COMMON HC
			 WHERE HC.GROUP_CODE                           = V_GROUP_CODE
			   AND HC.CODE                                 = W_WEEK_CODE
			   AND HC.SOB_ID                               = W_SOB_ID
				 AND HC.ORG_ID                               = W_ORG_ID
			;
		EXCEPTION WHEN OTHERS THEN
		  V_RETURN_VALUE := '-';
			RETURN V_RETURN_VALUE;
	  END;
		RETURN V_RETURN_VALUE;
		
	END WEEK_F;

END HRM_COMMON_G;
/
