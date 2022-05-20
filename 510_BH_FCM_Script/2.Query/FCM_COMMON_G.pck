CREATE OR REPLACE PACKAGE FCM_COMMON_G
AS
-----------------------------------------------------------------------------------------
-- HEADER DATA 조회.
  PROCEDURE COMMON_SELECT_H
            ( P_CURSOR           OUT TYPES.TCURSOR
            , W_CODE             IN FCM_COMMON.CODE%TYPE
            , W_CODE_NAME        IN FCM_COMMON.CODE_NAME%TYPE
            , W_SOB_ID           IN FCM_COMMON.SOB_ID%TYPE
            , W_ORG_ID           IN FCM_COMMON.ORG_ID%TYPE
            );
                                                    
-- HEADER INSERT.
  PROCEDURE COMMON_INSERT_H
            ( P_COMMON_ID        OUT FCM_COMMON.COMMON_ID%TYPE
            , P_CODE             IN FCM_COMMON.CODE%TYPE
            , P_CODE_NAME        IN FCM_COMMON.CODE_NAME%TYPE
            , P_CODE_LENGHT      IN FCM_COMMON.CODE_LENGTH%TYPE
            , P_VALUE1           IN FCM_COMMON.VALUE1%TYPE
            , P_VALUE2           IN FCM_COMMON.VALUE2%TYPE
            , P_VALUE3           IN FCM_COMMON.VALUE3%TYPE
            , P_VALUE4           IN FCM_COMMON.VALUE4%TYPE
            , P_VALUE5           IN FCM_COMMON.VALUE5%TYPE
            , P_VALUE6           IN FCM_COMMON.VALUE6%TYPE
            , P_VALUE7           IN FCM_COMMON.VALUE7%TYPE
            , P_VALUE8           IN FCM_COMMON.VALUE8%TYPE
            , P_VALUE9           IN FCM_COMMON.VALUE9%TYPE
            , P_VALUE10          IN FCM_COMMON.VALUE10%TYPE  
            , P_SOB_ID           IN FCM_COMMON.SOB_ID%TYPE
            , P_ORG_ID           IN FCM_COMMON.ORG_ID%TYPE
            , P_USER_ID          IN FCM_COMMON.CREATED_BY%TYPE
            );

-- HEADER UPDATE.
  PROCEDURE COMMON_UPDATE_H
            ( W_COMMON_ID        IN FCM_COMMON.COMMON_ID%TYPE
            , P_CODE_NAME        IN FCM_COMMON.CODE_NAME%TYPE
            , P_CODE_LENGHT      IN FCM_COMMON.CODE_LENGTH%TYPE
            , P_VALUE1           IN FCM_COMMON.VALUE1%TYPE
            , P_VALUE2           IN FCM_COMMON.VALUE2%TYPE
            , P_VALUE3           IN FCM_COMMON.VALUE3%TYPE
            , P_VALUE4           IN FCM_COMMON.VALUE4%TYPE
            , P_VALUE5           IN FCM_COMMON.VALUE5%TYPE
            , P_VALUE6           IN FCM_COMMON.VALUE6%TYPE
            , P_VALUE7           IN FCM_COMMON.VALUE7%TYPE
            , P_VALUE8           IN FCM_COMMON.VALUE8%TYPE
            , P_VALUE9           IN FCM_COMMON.VALUE9%TYPE
            , P_VALUE10          IN FCM_COMMON.VALUE10%TYPE  
            , P_USER_ID          IN FCM_COMMON.CREATED_BY%TYPE            
            );
                                                            
-----------------------------------------------------------------------------------------
-- LINE DATA 조회.
  PROCEDURE COMMON_SELECT_L
            ( P_CURSOR1          OUT TYPES.TCURSOR1
            , W_GROUP_CODE       IN FCM_COMMON.GROUP_CODE%TYPE  
            , W_SOB_ID           IN FCM_COMMON.SOB_ID%TYPE  
            , W_ORG_ID           IN FCM_COMMON.ORG_ID%TYPE  
            );
                                                    
-- LINE INSERT.
  PROCEDURE COMMON_INSERT_L
            ( P_COMMON_ID          OUT FCM_COMMON.COMMON_ID%TYPE
            , P_GROUP_CODE         IN FCM_COMMON.GROUP_CODE%TYPE
            , P_CODE               IN FCM_COMMON.CODE%TYPE
            , P_CODE_NAME          IN FCM_COMMON.CODE_NAME%TYPE
            , P_VALUE1             IN FCM_COMMON.VALUE1%TYPE
            , P_VALUE2             IN FCM_COMMON.VALUE2%TYPE
            , P_VALUE3             IN FCM_COMMON.VALUE3%TYPE
            , P_VALUE4             IN FCM_COMMON.VALUE4%TYPE
            , P_VALUE5             IN FCM_COMMON.VALUE5%TYPE
            , P_VALUE6             IN FCM_COMMON.VALUE6%TYPE
            , P_VALUE7             IN FCM_COMMON.VALUE7%TYPE
            , P_VALUE8             IN FCM_COMMON.VALUE8%TYPE
            , P_VALUE9             IN FCM_COMMON.VALUE9%TYPE
            , P_VALUE10            IN FCM_COMMON.VALUE10%TYPE  
            , P_DEFAULT_FLAG       IN FCM_COMMON.DEFAULT_FLAG%TYPE
            , P_SORT_NUM           IN FCM_COMMON.SORT_NUM%TYPE
            , P_DESCRIPTION        IN FCM_COMMON.DESCRIPTION%TYPE
            , P_ENABLED_FLAG       IN FCM_COMMON.ENABLED_FLAG%TYPE
            , P_EFFECTIVE_DATE_FR  IN FCM_COMMON.EFFECTIVE_DATE_FR%TYPE
            , P_EFFECTIVE_DATE_TO  IN FCM_COMMON.EFFECTIVE_DATE_TO%TYPE
            , P_SOB_ID             IN FCM_COMMON.SOB_ID%TYPE
            , P_ORG_ID             IN FCM_COMMON.ORG_ID%TYPE
            , P_USER_ID            IN FCM_COMMON.CREATED_BY%TYPE
            );

-- LINE UPDATE.
  PROCEDURE COMMON_UPDATE_L
            ( W_COMMON_ID          IN FCM_COMMON.COMMON_ID%TYPE
            , P_CODE_NAME          IN FCM_COMMON.CODE_NAME%TYPE
            , P_VALUE1             IN FCM_COMMON.VALUE1%TYPE
            , P_VALUE2             IN FCM_COMMON.VALUE2%TYPE
            , P_VALUE3             IN FCM_COMMON.VALUE3%TYPE
            , P_VALUE4             IN FCM_COMMON.VALUE4%TYPE
            , P_VALUE5             IN FCM_COMMON.VALUE5%TYPE
            , P_VALUE6             IN FCM_COMMON.VALUE6%TYPE
            , P_VALUE7             IN FCM_COMMON.VALUE7%TYPE
            , P_VALUE8             IN FCM_COMMON.VALUE8%TYPE
            , P_VALUE9             IN FCM_COMMON.VALUE9%TYPE
            , P_VALUE10            IN FCM_COMMON.VALUE10%TYPE  
            , P_DEFAULT_FLAG       IN FCM_COMMON.DEFAULT_FLAG%TYPE
            , P_SORT_NUM           IN FCM_COMMON.SORT_NUM%TYPE
            , P_DESCRIPTION        IN FCM_COMMON.DESCRIPTION%TYPE
            , P_ENABLED_FLAG       IN FCM_COMMON.ENABLED_FLAG%TYPE
            , P_EFFECTIVE_DATE_FR  IN FCM_COMMON.EFFECTIVE_DATE_FR%TYPE
            , P_EFFECTIVE_DATE_TO  IN FCM_COMMON.EFFECTIVE_DATE_TO%TYPE
            , P_USER_ID            IN FCM_COMMON.CREATED_BY%TYPE           
            );

-----------------------------------------------------------------------------------------
-- 공통코드 명칭 리턴 FUNCTION.
  FUNCTION ID_NAME_F
            ( W_COMMON_ID          IN FCM_COMMON.COMMON_ID%TYPE
            ) RETURN VARCHAR2;
  
  PROCEDURE ID_NAME
            ( W_COMMON_ID          IN FCM_COMMON.COMMON_ID%TYPE
            , O_RETURN_VALUE       OUT VARCHAR2
            );              

  FUNCTION CODE_NAME_F
           ( W_GROUP_CODE          IN FCM_COMMON.GROUP_CODE%TYPE
           , W_CODE                IN FCM_COMMON.CODE%TYPE
           , W_SOB_ID              IN FCM_COMMON.SOB_ID%TYPE
           , W_ORG_ID              IN FCM_COMMON.ORG_ID%TYPE
           ) RETURN VARCHAR2;

  PROCEDURE CODE_NAME
            ( W_GROUP_CODE          IN FCM_COMMON.GROUP_CODE%TYPE
            , W_CODE                IN FCM_COMMON.CODE%TYPE
            , W_SOB_ID              IN FCM_COMMON.SOB_ID%TYPE
            , W_ORG_ID              IN FCM_COMMON.ORG_ID%TYPE
            , O_RETURN_VALUE        OUT VARCHAR2
            );  

-----------------------------------------------------------------------------------------
-- 공통코드 기본값 리턴 - GROUP CODE..
  PROCEDURE DEFAULT_VALUE_GROUP
            ( W_GROUP_CODE          IN FCM_COMMON.GROUP_CODE%TYPE
            , W_SOB_ID              IN FCM_COMMON.SOB_ID%TYPE
            , W_ORG_ID              IN FCM_COMMON.ORG_ID%TYPE
            , O_ID                  OUT FCM_COMMON.COMMON_ID%TYPE
            , O_CODE                OUT FCM_COMMON.CODE%TYPE
            , O_CODE_NAME           OUT FCM_COMMON.CODE_NAME%TYPE
            );                                  

-- 공통코드 기본값 리턴 - VALUE1을 조건 검색하여 : GROUP CODE..
  PROCEDURE DEFAULT_VALUE_GROUP_W
            ( W_GROUP_CODE         IN FCM_COMMON.GROUP_CODE%TYPE
            , W_WHERE              IN VARCHAR2
            , W_SOB_ID             IN FCM_COMMON.SOB_ID%TYPE
            , W_ORG_ID             IN FCM_COMMON.ORG_ID%TYPE
            , O_ID                 OUT FCM_COMMON.COMMON_ID%TYPE
            , O_CODE               OUT FCM_COMMON.CODE%TYPE
            , O_CODE_NAME          OUT FCM_COMMON.CODE_NAME%TYPE
            );
            
-----------------------------------------------------------------------------------------
-- 공통코드 조회 LOOKUP - GROUP CODE..
  PROCEDURE LU_SELECT_GROUP
            ( P_CURSOR3            OUT TYPES.TCURSOR3
            , W_GROUP_CODE         IN FCM_COMMON.GROUP_CODE%TYPE
            , W_CODE_NAME          IN FCM_COMMON.CODE_NAME%TYPE
            , W_SOB_ID             IN FCM_COMMON.SOB_ID%TYPE
            , W_ORG_ID             IN FCM_COMMON.ORG_ID%TYPE
            , W_ENABLED_FLAG_YN    IN FCM_COMMON.ENABLED_FLAG%TYPE DEFAULT 'Y'
            );

-- 공통코드 WHERE 조건으로 조회 LOOKUP.
  PROCEDURE LU_SELECT_GROUP_W
            ( P_CURSOR3            OUT TYPES.TCURSOR3
            , W_GROUP_CODE         IN FCM_COMMON.GROUP_CODE%TYPE
            , W_WHERE              IN VARCHAR2
            , W_SOB_ID             IN FCM_COMMON.SOB_ID%TYPE
            , W_ORG_ID             IN FCM_COMMON.ORG_ID%TYPE
            , W_ENABLED_FLAG_YN    IN FCM_COMMON.ENABLED_FLAG%TYPE DEFAULT 'Y'
            );

-- LOOKUP COST CENTER.
  PROCEDURE LU_COST_CENTER
            ( P_CURSOR3            OUT TYPES.TCURSOR3
            , W_SOB_ID             IN CST_COST_CENTER.SOB_ID%TYPE
            , W_ORG_ID             IN CST_COST_CENTER.ORG_ID%TYPE
            , W_ENABLED_FLAG_YN    IN CST_COST_CENTER.ENABLED_FLAG%TYPE DEFAULT 'Y'
            );

-- 원가코드 조회 FUNCTION.
  FUNCTION COST_CENTER_CODE_F
            ( W_COST_CENTER_ID     IN CST_COST_CENTER.COST_CENTER_ID%TYPE
            ) RETURN VARCHAR2;
            
-- 원가명 조회 FUNCTION.
  FUNCTION COST_CENTER_DESC_F
            ( W_COST_CENTER_ID     IN CST_COST_CENTER.COST_CENTER_ID%TYPE
            ) RETURN VARCHAR2;
            
END FCM_COMMON_G;
/
CREATE OR REPLACE PACKAGE BODY FCM_COMMON_G
AS
/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : FCM_COMMON_G
/* Description  : 공통코드 관리 패키지
/*
/* Reference by : 재무회계 시스템에서 공통으로 사용할 공통코드 관리.
/* Program History : 
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
-----------------------------------------------------------------------------------------
-- HEADER DATA 조회.
  PROCEDURE COMMON_SELECT_H
	          ( P_CURSOR           OUT TYPES.TCURSOR
						, W_CODE             IN FCM_COMMON.CODE%TYPE
						, W_CODE_NAME        IN FCM_COMMON.CODE_NAME%TYPE
						, W_SOB_ID           IN FCM_COMMON.SOB_ID%TYPE
						, W_ORG_ID           IN FCM_COMMON.ORG_ID%TYPE
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
          , HC.VALUE8
					, HC.VALUE9
					, HC.VALUE10
			FROM FCM_COMMON HC
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
	          ( P_COMMON_ID        OUT FCM_COMMON.COMMON_ID%TYPE
            , P_CODE             IN FCM_COMMON.CODE%TYPE
						, P_CODE_NAME        IN FCM_COMMON.CODE_NAME%TYPE
						, P_CODE_LENGHT      IN FCM_COMMON.CODE_LENGTH%TYPE
						, P_VALUE1           IN FCM_COMMON.VALUE1%TYPE
						, P_VALUE2           IN FCM_COMMON.VALUE2%TYPE
						, P_VALUE3           IN FCM_COMMON.VALUE3%TYPE
						, P_VALUE4           IN FCM_COMMON.VALUE4%TYPE
						, P_VALUE5           IN FCM_COMMON.VALUE5%TYPE
						, P_VALUE6           IN FCM_COMMON.VALUE6%TYPE
						, P_VALUE7           IN FCM_COMMON.VALUE7%TYPE
            , P_VALUE8           IN FCM_COMMON.VALUE8%TYPE
            , P_VALUE9           IN FCM_COMMON.VALUE9%TYPE
            , P_VALUE10          IN FCM_COMMON.VALUE10%TYPE  
						, P_SOB_ID           IN FCM_COMMON.SOB_ID%TYPE
						, P_ORG_ID           IN FCM_COMMON.ORG_ID%TYPE
						, P_USER_ID          IN FCM_COMMON.CREATED_BY%TYPE
						)
  AS
	  D_SYSDATE                    DATE;
		
  BEGIN
	  D_SYSDATE := GET_LOCAL_DATE(P_SOB_ID);
		SELECT FCM_COMMON_S1.NEXTVAL
      INTO P_COMMON_ID
      FROM DUAL;
      
		INSERT INTO FCM_COMMON 
		( COMMON_ID, GROUP_CODE, CODE, CODE_NAME, CODE_LENGTH
		, VALUE1, VALUE2, VALUE3, VALUE4, VALUE5, VALUE6, VALUE7, VALUE8, VALUE9, VALUE10
		, ENABLED_FLAG, EFFECTIVE_DATE_FR
		, SOB_ID, ORG_ID
		, CREATION_DATE, CREATED_BY, LAST_UPDATE_DATE, LAST_UPDATED_BY
		) VALUES
		( P_COMMON_ID, '-', P_CODE, P_CODE_NAME, P_CODE_LENGHT
		, P_VALUE1, P_VALUE2, P_VALUE3, P_VALUE4, P_VALUE5, P_VALUE6, P_VALUE7, P_VALUE8, P_VALUE9, P_VALUE10
		, 'Y', TRUNC(D_SYSDATE)
		, P_SOB_ID, P_ORG_ID
		, D_SYSDATE, P_USER_ID, D_SYSDATE, P_USER_ID
		);
  
  END COMMON_INSERT_H;

-- HEADER UPDATE.
  PROCEDURE COMMON_UPDATE_H
	          ( W_COMMON_ID        IN FCM_COMMON.COMMON_ID%TYPE
						, P_CODE_NAME        IN FCM_COMMON.CODE_NAME%TYPE
						, P_CODE_LENGHT      IN FCM_COMMON.CODE_LENGTH%TYPE
						, P_VALUE1           IN FCM_COMMON.VALUE1%TYPE
						, P_VALUE2           IN FCM_COMMON.VALUE2%TYPE
						, P_VALUE3           IN FCM_COMMON.VALUE3%TYPE
            , P_VALUE4           IN FCM_COMMON.VALUE4%TYPE
            , P_VALUE5           IN FCM_COMMON.VALUE5%TYPE
            , P_VALUE6           IN FCM_COMMON.VALUE6%TYPE
            , P_VALUE7           IN FCM_COMMON.VALUE7%TYPE
            , P_VALUE8           IN FCM_COMMON.VALUE8%TYPE
            , P_VALUE9           IN FCM_COMMON.VALUE9%TYPE
            , P_VALUE10          IN FCM_COMMON.VALUE10%TYPE  
            , P_USER_ID          IN FCM_COMMON.CREATED_BY%TYPE            
            )
  AS
  BEGIN
    UPDATE FCM_COMMON HC
      SET HC.CODE_NAME           = P_CODE_NAME
        , HC.CODE_LENGTH         = P_CODE_LENGHT
        , HC.VALUE1              = P_VALUE1
        , HC.VALUE2              = P_VALUE2
        , HC.VALUE3              = P_VALUE3
        , HC.VALUE4              = P_VALUE4
        , HC.VALUE5              = P_VALUE5
        , HC.VALUE6              = P_VALUE6
        , HC.VALUE7              = P_VALUE7
        , HC.VALUE8              = P_VALUE8
        , HC.VALUE9              = P_VALUE9
        , HC.VALUE10             = P_VALUE10
        , HC.LAST_UPDATE_DATE    = GET_LOCAL_DATE(HC.SOB_ID)
        , HC.LAST_UPDATED_BY     = P_USER_ID
    WHERE HC.COMMON_ID           = W_COMMON_ID
    ;
  
  END COMMON_UPDATE_H;
                                                         
-----------------------------------------------------------------------------------------
-- LINE DATA 조회.
  PROCEDURE COMMON_SELECT_L
            ( P_CURSOR1          OUT TYPES.TCURSOR1
            , W_GROUP_CODE       IN FCM_COMMON.GROUP_CODE%TYPE  
            , W_SOB_ID           IN FCM_COMMON.SOB_ID%TYPE  
            , W_ORG_ID           IN FCM_COMMON.ORG_ID%TYPE  
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
          , HC.VALUE8
          , HC.VALUE9
          , HC.VALUE10
          , HC.DEFAULT_FLAG
          , HC.SORT_NUM
          , HC.DESCRIPTION
          , HC.ENABLED_FLAG
          , HC.EFFECTIVE_DATE_FR
          , HC.EFFECTIVE_DATE_TO
          , HC.GROUP_CODE
      FROM FCM_COMMON HC
      WHERE HC.GROUP_CODE            = W_GROUP_CODE
        AND HC.SOB_ID                = W_SOB_ID
        AND HC.ORG_ID                = W_ORG_ID
      ORDER BY HC.SORT_NUM, HC.CODE
      ;
  
  END COMMON_SELECT_L;
                                                    
-- LINE INSERT.
  PROCEDURE COMMON_INSERT_L
            ( P_COMMON_ID          OUT FCM_COMMON.COMMON_ID%TYPE
            , P_GROUP_CODE         IN FCM_COMMON.GROUP_CODE%TYPE
            , P_CODE               IN FCM_COMMON.CODE%TYPE
            , P_CODE_NAME          IN FCM_COMMON.CODE_NAME%TYPE
            , P_VALUE1             IN FCM_COMMON.VALUE1%TYPE
            , P_VALUE2             IN FCM_COMMON.VALUE2%TYPE
            , P_VALUE3             IN FCM_COMMON.VALUE3%TYPE
            , P_VALUE4             IN FCM_COMMON.VALUE4%TYPE
            , P_VALUE5             IN FCM_COMMON.VALUE5%TYPE
            , P_VALUE6             IN FCM_COMMON.VALUE6%TYPE
            , P_VALUE7             IN FCM_COMMON.VALUE7%TYPE
            , P_VALUE8             IN FCM_COMMON.VALUE8%TYPE
            , P_VALUE9             IN FCM_COMMON.VALUE9%TYPE
            , P_VALUE10            IN FCM_COMMON.VALUE10%TYPE  
            , P_DEFAULT_FLAG       IN FCM_COMMON.DEFAULT_FLAG%TYPE
            , P_SORT_NUM           IN FCM_COMMON.SORT_NUM%TYPE
            , P_DESCRIPTION        IN FCM_COMMON.DESCRIPTION%TYPE
            , P_ENABLED_FLAG       IN FCM_COMMON.ENABLED_FLAG%TYPE
            , P_EFFECTIVE_DATE_FR  IN FCM_COMMON.EFFECTIVE_DATE_FR%TYPE
            , P_EFFECTIVE_DATE_TO  IN FCM_COMMON.EFFECTIVE_DATE_TO%TYPE
            , P_SOB_ID             IN FCM_COMMON.SOB_ID%TYPE
            , P_ORG_ID             IN FCM_COMMON.ORG_ID%TYPE
            , P_USER_ID            IN FCM_COMMON.CREATED_BY%TYPE
            )
  AS
    D_SYSDATE                      DATE;
    
  BEGIN
    D_SYSDATE := GET_LOCAL_DATE(P_SOB_ID);
    SELECT FCM_COMMON_S1.NEXTVAL
      INTO P_COMMON_ID
      FROM DUAL;
    
    INSERT INTO FCM_COMMON 
    ( COMMON_ID, GROUP_CODE, CODE, CODE_NAME
    , VALUE1, VALUE2, VALUE3, VALUE4, VALUE5, VALUE6, VALUE7, VALUE8, VALUE9, VALUE10
    , DEFAULT_FLAG
    , SORT_NUM, DESCRIPTION, ENABLED_FLAG, EFFECTIVE_DATE_FR, EFFECTIVE_DATE_TO
    , SOB_ID, ORG_ID
    , CREATION_DATE, CREATED_BY, LAST_UPDATE_DATE, LAST_UPDATED_BY
    ) VALUES
    ( P_COMMON_ID, P_GROUP_CODE, P_CODE, P_CODE_NAME
    , P_VALUE1, P_VALUE2, P_VALUE3, P_VALUE4, P_VALUE5, P_VALUE6, P_VALUE7, P_VALUE8, P_VALUE9, P_VALUE10
    , P_DEFAULT_FLAG
    , P_SORT_NUM, P_DESCRIPTION, P_ENABLED_FLAG, TRUNC(P_EFFECTIVE_DATE_FR), TRUNC(P_EFFECTIVE_DATE_TO)
    , P_SOB_ID, P_ORG_ID
    , D_SYSDATE, P_USER_ID, D_SYSDATE, P_USER_ID
    );
        
  END COMMON_INSERT_L;
  
-- LINE UPDATE.
  PROCEDURE COMMON_UPDATE_L
            ( W_COMMON_ID          IN FCM_COMMON.COMMON_ID%TYPE
            , P_CODE_NAME          IN FCM_COMMON.CODE_NAME%TYPE
            , P_VALUE1             IN FCM_COMMON.VALUE1%TYPE
            , P_VALUE2             IN FCM_COMMON.VALUE2%TYPE
            , P_VALUE3             IN FCM_COMMON.VALUE3%TYPE
            , P_VALUE4             IN FCM_COMMON.VALUE4%TYPE
            , P_VALUE5             IN FCM_COMMON.VALUE5%TYPE
            , P_VALUE6             IN FCM_COMMON.VALUE6%TYPE
            , P_VALUE7             IN FCM_COMMON.VALUE7%TYPE
            , P_VALUE8             IN FCM_COMMON.VALUE8%TYPE
            , P_VALUE9             IN FCM_COMMON.VALUE9%TYPE
            , P_VALUE10            IN FCM_COMMON.VALUE10%TYPE  
            , P_DEFAULT_FLAG       IN FCM_COMMON.DEFAULT_FLAG%TYPE
            , P_SORT_NUM           IN FCM_COMMON.SORT_NUM%TYPE
            , P_DESCRIPTION        IN FCM_COMMON.DESCRIPTION%TYPE
            , P_ENABLED_FLAG       IN FCM_COMMON.ENABLED_FLAG%TYPE
            , P_EFFECTIVE_DATE_FR  IN FCM_COMMON.EFFECTIVE_DATE_FR%TYPE
            , P_EFFECTIVE_DATE_TO  IN FCM_COMMON.EFFECTIVE_DATE_TO%TYPE
            , P_USER_ID            IN FCM_COMMON.CREATED_BY%TYPE           
            )
  AS
  BEGIN
    UPDATE FCM_COMMON HC
      SET HC.CODE_NAME             = P_CODE_NAME
        , HC.VALUE1                = P_VALUE1
        , HC.VALUE2                = P_VALUE2
        , HC.VALUE3                = P_VALUE3
        , HC.VALUE4                = P_VALUE4
        , HC.VALUE5                = P_VALUE5
        , HC.VALUE6                = P_VALUE6
        , HC.VALUE7                = P_VALUE7
        , HC.VALUE8                = P_VALUE8
        , HC.VALUE9                = P_VALUE9
        , HC.VALUE10               = P_VALUE10
        , HC.DEFAULT_FLAG          = P_DEFAULT_FLAG
        , HC.SORT_NUM              = P_SORT_NUM
        , HC.DESCRIPTION           = P_DESCRIPTION
        , HC.ENABLED_FLAG          = P_ENABLED_FLAG
        , HC.EFFECTIVE_DATE_FR     = TRUNC(P_EFFECTIVE_DATE_FR)
        , HC.EFFECTIVE_DATE_TO     = TRUNC(P_EFFECTIVE_DATE_TO)
        , HC.LAST_UPDATE_DATE      = GET_LOCAL_DATE(HC.SOB_ID)
        , HC.LAST_UPDATED_BY       = P_USER_ID
      WHERE HC.COMMON_ID           = W_COMMON_ID
      ;
      COMMIT;
      
  END COMMON_UPDATE_L;
  
  
-----------------------------------------------------------------------------------------
-- 공통코드 명칭 리턴 FUNCTION.
  FUNCTION ID_NAME_F
            ( W_COMMON_ID          IN FCM_COMMON.COMMON_ID%TYPE
            ) RETURN VARCHAR2
  AS
    V_RETURN_VALUE                 VARCHAR2(150) := NULL;
    
  BEGIN
    BEGIN
      SELECT  HC.CODE_NAME
        INTO V_RETURN_VALUE
      FROM FCM_COMMON HC
      WHERE HC.COMMON_ID           = W_COMMON_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_RETURN_VALUE := NULL;
    END;
    RETURN V_RETURN_VALUE;
        
  END ID_NAME_F;  

  PROCEDURE ID_NAME
            ( W_COMMON_ID          IN FCM_COMMON.COMMON_ID%TYPE
            , O_RETURN_VALUE       OUT VARCHAR2
            )
  AS
  BEGIN
    BEGIN
      SELECT  HC.CODE_NAME
        INTO O_RETURN_VALUE
      FROM FCM_COMMON HC
      WHERE HC.COMMON_ID           = W_COMMON_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      O_RETURN_VALUE := NULL;
    END;
    
  END ID_NAME;  
  
  FUNCTION CODE_NAME_F
           ( W_GROUP_CODE          IN FCM_COMMON.GROUP_CODE%TYPE
           , W_CODE                IN FCM_COMMON.CODE%TYPE
           , W_SOB_ID              IN FCM_COMMON.SOB_ID%TYPE
           , W_ORG_ID              IN FCM_COMMON.ORG_ID%TYPE
           ) RETURN VARCHAR2
  AS
    V_RETURN_VALUE                                        VARCHAR2(150) := NULL;
    
  BEGIN
    BEGIN
      SELECT HC.CODE_NAME
        INTO V_RETURN_VALUE
      FROM FCM_COMMON HC
      WHERE HC.GROUP_CODE          = W_GROUP_CODE
        AND HC.CODE                = W_CODE
        AND HC.SOB_ID              = W_SOB_ID
        AND HC.ORG_ID              = W_ORG_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_RETURN_VALUE := NULL;
    END;
    RETURN V_RETURN_VALUE;
  
  END CODE_NAME_F;                                                

  PROCEDURE CODE_NAME
            ( W_GROUP_CODE          IN FCM_COMMON.GROUP_CODE%TYPE
            , W_CODE                IN FCM_COMMON.CODE%TYPE
            , W_SOB_ID              IN FCM_COMMON.SOB_ID%TYPE
            , W_ORG_ID              IN FCM_COMMON.ORG_ID%TYPE
            , O_RETURN_VALUE        OUT VARCHAR2
            )
  AS
  BEGIN
    BEGIN
      SELECT HC.CODE_NAME
        INTO O_RETURN_VALUE
      FROM FCM_COMMON HC
      WHERE HC.GROUP_CODE          = W_GROUP_CODE
        AND HC.CODE                = W_CODE
        AND HC.SOB_ID              = W_SOB_ID
        AND HC.ORG_ID              = W_ORG_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      O_RETURN_VALUE := NULL;
    END;

  END CODE_NAME;

-----------------------------------------------------------------------------------------
-- 공통코드 기본값 리턴 - GROUP CODE..
  PROCEDURE DEFAULT_VALUE_GROUP
            ( W_GROUP_CODE          IN FCM_COMMON.GROUP_CODE%TYPE
            , W_SOB_ID              IN FCM_COMMON.SOB_ID%TYPE
            , W_ORG_ID              IN FCM_COMMON.ORG_ID%TYPE
            , O_ID                  OUT FCM_COMMON.COMMON_ID%TYPE
            , O_CODE                OUT FCM_COMMON.CODE%TYPE
            , O_CODE_NAME           OUT FCM_COMMON.CODE_NAME%TYPE
            )
  AS
  BEGIN
    BEGIN
      SELECT HC.CODE_NAME, HC.CODE, HC.COMMON_ID
        INTO O_CODE_NAME, O_CODE, O_ID
        FROM FCM_COMMON HC
      WHERE HC.GROUP_CODE            = W_GROUP_CODE
        AND HC.SOB_ID                = W_SOB_ID
        AND HC.ORG_ID                = W_ORG_ID
        AND HC.DEFAULT_FLAG          = 'Y'
        AND ROWNUM                   <= 1
        AND HC.ENABLED_FLAG          = 'Y'                 
        AND HC.EFFECTIVE_DATE_FR     <= GET_LOCAL_DATE(HC.SOB_ID)
        AND (HC.EFFECTIVE_DATE_TO IS NULL OR HC.EFFECTIVE_DATE_TO  >= GET_LOCAL_DATE(HC.SOB_ID))
      ;
    EXCEPTION WHEN OTHERS THEN
      O_ID := 0;
      O_CODE := NULL;
      O_CODE_NAME := NULL;
    END;
    
  END DEFAULT_VALUE_GROUP;

-- 공통코드 기본값 리턴 - VALUE1을 조건 검색하여 : GROUP CODE..
  PROCEDURE DEFAULT_VALUE_GROUP_W
            ( W_GROUP_CODE         IN FCM_COMMON.GROUP_CODE%TYPE
            , W_WHERE              IN VARCHAR2
            , W_SOB_ID             IN FCM_COMMON.SOB_ID%TYPE
            , W_ORG_ID             IN FCM_COMMON.ORG_ID%TYPE
            , O_ID                 OUT FCM_COMMON.COMMON_ID%TYPE
            , O_CODE               OUT FCM_COMMON.CODE%TYPE
            , O_CODE_NAME          OUT FCM_COMMON.CODE_NAME%TYPE
            )
  AS
    V_STRING                       VARCHAR2(1000);
    
  BEGIN
    BEGIN
      V_STRING := 'SELECT HC.CODE_NAME, HC.CODE, HC.COMMON_ID 
                     FROM FCM_COMMON HC 
                    WHERE HC.GROUP_CODE            = ''' || W_GROUP_CODE  || '''
                      AND HC.SOB_ID                = ' || W_SOB_ID || '
                      AND HC.ORG_ID                = ' || W_ORG_ID || '
                      AND ' || W_WHERE  || '
                      AND HC.DEFAULT_FLAG          =  ''Y''
                      AND ROWNUM                   <= 1
                      AND HC.ENABLED_FLAG          = ''Y''
                      AND HC.EFFECTIVE_DATE_FR     <= GET_LOCAL_DATE(HC.SOB_ID)
                      AND (HC.EFFECTIVE_DATE_TO IS NULL OR HC.EFFECTIVE_DATE_TO  >= GET_LOCAL_DATE(HC.SOB_ID)) ';
--      DBMS_OUTPUT.PUT_LINE(V_STRING);
      EXECUTE IMMEDIATE V_STRING   
      INTO O_CODE_NAME, O_CODE, O_ID;
  
    EXCEPTION WHEN OTHERS THEN
      O_ID := 0;
      O_CODE := NULL;
      O_CODE_NAME := NULL;
    END;
    
  END DEFAULT_VALUE_GROUP_W;                                  

-----------------------------------------------------------------------------------------
-- 공통코드 조회 LOOKUP - GROUP CODE..
  PROCEDURE LU_SELECT_GROUP
            ( P_CURSOR3            OUT TYPES.TCURSOR3
            , W_GROUP_CODE         IN FCM_COMMON.GROUP_CODE%TYPE
            , W_CODE_NAME          IN FCM_COMMON.CODE_NAME%TYPE
            , W_SOB_ID             IN FCM_COMMON.SOB_ID%TYPE
            , W_ORG_ID             IN FCM_COMMON.ORG_ID%TYPE
            , W_ENABLED_FLAG_YN    IN FCM_COMMON.ENABLED_FLAG%TYPE DEFAULT 'Y'
            )
  AS
    V_STD_DATE                     FCM_COMMON.EFFECTIVE_DATE_FR%TYPE := NULL;
    
  BEGIN
    IF W_ENABLED_FLAG_YN = 'Y' THEN
      V_STD_DATE := TRUNC(GET_LOCAL_DATE(W_SOB_ID));
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
          , HC.VALUE8
          , HC.VALUE9
          , HC.VALUE10
      FROM FCM_COMMON HC
      WHERE HC.GROUP_CODE          = W_GROUP_CODE
        AND HC.CODE_NAME           LIKE W_CODE_NAME || '%'
        AND HC.SOB_ID              = W_SOB_ID
        AND HC.ORG_ID              = W_ORG_ID
        AND HC.ENABLED_FLAG        = DECODE(W_ENABLED_FLAG_YN, 'Y', 'Y', HC.ENABLED_FLAG)
        AND HC.EFFECTIVE_DATE_FR   <= NVL(V_STD_DATE, HC.EFFECTIVE_DATE_FR)
        AND (HC.EFFECTIVE_DATE_TO IS NULL OR HC.EFFECTIVE_DATE_TO >= NVL(V_STD_DATE, HC.EFFECTIVE_DATE_TO))
      ORDER BY HC.SORT_NUM, HC.CODE
      ;
  
  END LU_SELECT_GROUP;
  
-- 공통코드 WHERE 조건으로 조회 LOOKUP.
  PROCEDURE LU_SELECT_GROUP_W
            ( P_CURSOR3            OUT TYPES.TCURSOR3
            , W_GROUP_CODE         IN FCM_COMMON.GROUP_CODE%TYPE
            , W_WHERE              IN VARCHAR2
            , W_SOB_ID             IN FCM_COMMON.SOB_ID%TYPE
            , W_ORG_ID             IN FCM_COMMON.ORG_ID%TYPE
            , W_ENABLED_FLAG_YN    IN FCM_COMMON.ENABLED_FLAG%TYPE DEFAULT 'Y'
            )
  AS
    V_STD_DATE                     VARCHAR2(10) := NULL;
    V_STRING                       VARCHAR2(2000);
    
  BEGIN
    IF W_ENABLED_FLAG_YN = 'Y' THEN
      V_STD_DATE := TO_CHAR(GET_LOCAL_DATE(W_SOB_ID), 'YYYY-MM-DD');
    ELSE
      V_STD_DATE := NULL;
    END IF;
    -- 임시테이블 삭제.
    DELETE FROM FCM_COMMON_GT;
    V_STRING := 'INSERT INTO FCM_COMMON_GT
                 ( CODE_NAME
                  , CODE
                  , COMMON_ID
                  , VALUE1
                  , VALUE2
                  , VALUE3
                  , VALUE4
                  , VALUE5
                  , VALUE6
                  , VALUE7
                  , VALUE8
                  , VALUE9
                  , VALUE10
                  )
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
                      , HC.VALUE8
                      , HC.VALUE9
                      , HC.VALUE10
                   FROM FCM_COMMON HC 
                  WHERE HC.GROUP_CODE            = ''' || W_GROUP_CODE  || '''
                    AND HC.SOB_ID                = ' || W_SOB_ID || '
                    AND HC.ORG_ID                = ' || W_ORG_ID  || '
                    AND ' || W_WHERE  || '
                    AND HC.ENABLED_FLAG       = DECODE(''' || W_ENABLED_FLAG_YN || ''', ''Y'', ''Y'', HC.ENABLED_FLAG)
                    AND HC.EFFECTIVE_DATE_FR  <= NVL(TO_DATE(''' || V_STD_DATE || ''', ''YYYY-MM-DD''), HC.EFFECTIVE_DATE_FR)
                    AND (HC.EFFECTIVE_DATE_TO IS NULL OR HC.EFFECTIVE_DATE_TO >= NVL(TO_DATE(''' || V_STD_DATE || ''', ''YYYY-MM-DD''), HC.EFFECTIVE_DATE_TO))
                  ORDER BY HC.SORT_NUM, HC.CODE ';
--    DBMS_OUTPUT.PUT_LINE(V_STRING);
    EXECUTE IMMEDIATE V_STRING;

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
          , HC.VALUE8
          , HC.VALUE9
          , HC.VALUE10
       FROM FCM_COMMON_GT HC ;

  END LU_SELECT_GROUP_W;  
  
-- LOOKUP COST CENTER.
  PROCEDURE LU_COST_CENTER
            ( P_CURSOR3            OUT TYPES.TCURSOR3
            , W_SOB_ID             IN CST_COST_CENTER.SOB_ID%TYPE
            , W_ORG_ID             IN CST_COST_CENTER.ORG_ID%TYPE
            , W_ENABLED_FLAG_YN    IN CST_COST_CENTER.ENABLED_FLAG%TYPE DEFAULT 'Y'
            )
  AS
    V_STD_DATE                     FCM_COMMON.EFFECTIVE_DATE_FR%TYPE := NULL;
    
  BEGIN
    IF W_ENABLED_FLAG_YN = 'Y' THEN
      V_STD_DATE := TRUNC(GET_LOCAL_DATE(W_SOB_ID));
    ELSE
      V_STD_DATE := NULL;
    END IF;
    
    OPEN P_CURSOR3 FOR
      SELECT CC.COST_CENTER_DESC
           , CC.COST_CENTER_CODE
           , CC.COST_CENTER_ID
        FROM CST_COST_CENTER CC
       WHERE CC.SOB_ID                  = W_SOB_ID
         AND CC.ORG_ID                  = W_ORG_ID
         AND CC.ENABLED_FLAG            = DECODE(W_ENABLED_FLAG_YN, 'Y', 'Y', CC.ENABLED_FLAG)
         AND CC.EFFECTIVE_DATE_FR       <= NVL(V_STD_DATE, CC.EFFECTIVE_DATE_FR)
         AND (CC.EFFECTIVE_DATE_TO IS NULL OR CC.EFFECTIVE_DATE_TO >= NVL(V_STD_DATE, CC.EFFECTIVE_DATE_TO))
     ;
  
  END LU_COST_CENTER;

-- 원가코드 조회 FUNCTION.
  FUNCTION COST_CENTER_CODE_F
            ( W_COST_CENTER_ID     IN CST_COST_CENTER.COST_CENTER_ID%TYPE
            ) RETURN VARCHAR2
  AS
    V_RETURN_VALUE                 CST_COST_CENTER.COST_CENTER_CODE%TYPE := NULL;
    
  BEGIN
    BEGIN
      SELECT CC.Cost_Center_Code
        INTO V_RETURN_VALUE
        FROM CST_COST_CENTER CC
       WHERE CC.COST_CENTER_ID    = W_COST_CENTER_ID
     ;
    EXCEPTION WHEN OTHERS THEN
      V_RETURN_VALUE := NULL;
    END;
    RETURN V_RETURN_VALUE;  
  
  END COST_CENTER_CODE_F;
  
-- 원가명 조회 FUNCTION.
  FUNCTION COST_CENTER_DESC_F
            ( W_COST_CENTER_ID     IN CST_COST_CENTER.COST_CENTER_ID%TYPE
            ) RETURN VARCHAR2
  AS
    V_RETURN_VALUE                 CST_COST_CENTER.COST_CENTER_DESC%TYPE := NULL;
    
  BEGIN
    BEGIN
      SELECT CC.COST_CENTER_DESC
        INTO V_RETURN_VALUE
        FROM CST_COST_CENTER CC
       WHERE CC.COST_CENTER_ID    = W_COST_CENTER_ID
     ;
    EXCEPTION WHEN OTHERS THEN
      V_RETURN_VALUE := NULL;
    END;
    RETURN V_RETURN_VALUE;
  
  END COST_CENTER_DESC_F;
  
END FCM_COMMON_G;
/
