CREATE OR REPLACE PACKAGE HRM_COMMON_G
AS
-----------------------------------------------------------------------------------------
-- HEADER DATA 조회.
  PROCEDURE COMMON_SELECT_H
            ( P_CURSOR           OUT TYPES.TCURSOR
            , W_CODE             IN HRM_COMMON.CODE%TYPE
            , W_CODE_NAME        IN HRM_COMMON.CODE_NAME%TYPE
            , W_ENABLED_FLAG     IN HRM_COMMON.ENABLED_FLAG%TYPE DEFAULT NULL
            , W_SOB_ID           IN HRM_COMMON.SOB_ID%TYPE
            , W_ORG_ID           IN HRM_COMMON.ORG_ID%TYPE
            );

-- HEADER INSERT.
  PROCEDURE COMMON_INSERT_H
            ( P_COMMON_ID        OUT HRM_COMMON.COMMON_ID%TYPE
            , P_CODE             IN HRM_COMMON.CODE%TYPE
            , P_CODE_NAME        IN HRM_COMMON.CODE_NAME%TYPE
            , P_CODE_LENGHT      IN HRM_COMMON.CODE_LENGTH%TYPE
            , P_VALUE1           IN HRM_COMMON.VALUE1%TYPE
            , P_VALUE2           IN HRM_COMMON.VALUE2%TYPE
            , P_VALUE3           IN HRM_COMMON.VALUE3%TYPE
            , P_VALUE4           IN HRM_COMMON.VALUE4%TYPE
            , P_VALUE5           IN HRM_COMMON.VALUE5%TYPE
            , P_VALUE6           IN HRM_COMMON.VALUE6%TYPE
            , P_VALUE7           IN HRM_COMMON.VALUE7%TYPE
            , P_VALUE8           IN HRM_COMMON.VALUE8%TYPE
            , P_VALUE9           IN HRM_COMMON.VALUE9%TYPE
            , P_VALUE10          IN HRM_COMMON.VALUE10%TYPE
            , P_SOB_ID           IN HRM_COMMON.SOB_ID%TYPE
            , P_ORG_ID           IN HRM_COMMON.ORG_ID%TYPE
            , P_USER_ID          IN HRM_COMMON.CREATED_BY%TYPE
            );

-- HEADER UPDATE.
  PROCEDURE COMMON_UPDATE_H
            ( W_COMMON_ID        IN HRM_COMMON.COMMON_ID%TYPE
            , P_CODE_NAME        IN HRM_COMMON.CODE_NAME%TYPE
            , P_CODE_LENGHT      IN HRM_COMMON.CODE_LENGTH%TYPE
            , P_VALUE1           IN HRM_COMMON.VALUE1%TYPE
            , P_VALUE2           IN HRM_COMMON.VALUE2%TYPE
            , P_VALUE3           IN HRM_COMMON.VALUE3%TYPE
            , P_VALUE4           IN HRM_COMMON.VALUE4%TYPE
            , P_VALUE5           IN HRM_COMMON.VALUE5%TYPE
            , P_VALUE6           IN HRM_COMMON.VALUE6%TYPE
            , P_VALUE7           IN HRM_COMMON.VALUE7%TYPE
            , P_VALUE8           IN HRM_COMMON.VALUE8%TYPE
            , P_VALUE9           IN HRM_COMMON.VALUE9%TYPE
            , P_VALUE10          IN HRM_COMMON.VALUE10%TYPE
            , P_USER_ID          IN HRM_COMMON.CREATED_BY%TYPE
            );

-----------------------------------------------------------------------------------------
-- LINE DATA 조회.
  PROCEDURE COMMON_SELECT_L
            ( P_CURSOR1          OUT TYPES.TCURSOR1
            , W_GROUP_CODE       IN HRM_COMMON.GROUP_CODE%TYPE
            , W_ENABLED_FLAG     IN HRM_COMMON.ENABLED_FLAG%TYPE DEFAULT NULL
            , W_SOB_ID           IN HRM_COMMON.SOB_ID%TYPE
            , W_ORG_ID           IN HRM_COMMON.ORG_ID%TYPE
            );

-- LINE INSERT.
  PROCEDURE COMMON_INSERT_L
            ( P_COMMON_ID          OUT HRM_COMMON.COMMON_ID%TYPE
            , P_GROUP_CODE         IN HRM_COMMON.GROUP_CODE%TYPE
            , P_CODE               IN HRM_COMMON.CODE%TYPE
            , P_CODE_NAME          IN HRM_COMMON.CODE_NAME%TYPE
            , P_VALUE1             IN HRM_COMMON.VALUE1%TYPE
            , P_VALUE2             IN HRM_COMMON.VALUE2%TYPE
            , P_VALUE3             IN HRM_COMMON.VALUE3%TYPE
            , P_VALUE4             IN HRM_COMMON.VALUE4%TYPE
            , P_VALUE5             IN HRM_COMMON.VALUE5%TYPE
            , P_VALUE6             IN HRM_COMMON.VALUE6%TYPE
            , P_VALUE7             IN HRM_COMMON.VALUE7%TYPE
            , P_VALUE8             IN HRM_COMMON.VALUE8%TYPE
            , P_VALUE9             IN HRM_COMMON.VALUE9%TYPE
            , P_VALUE10            IN HRM_COMMON.VALUE10%TYPE
            , P_DEFAULT_FLAG       IN HRM_COMMON.DEFAULT_FLAG%TYPE
            , P_SORT_NUM           IN HRM_COMMON.SORT_NUM%TYPE
            , P_DESCRIPTION        IN HRM_COMMON.DESCRIPTION%TYPE
            , P_ENABLED_FLAG       IN HRM_COMMON.ENABLED_FLAG%TYPE
            , P_EFFECTIVE_DATE_FR  IN HRM_COMMON.EFFECTIVE_DATE_FR%TYPE
            , P_EFFECTIVE_DATE_TO  IN HRM_COMMON.EFFECTIVE_DATE_TO%TYPE
            , P_SOB_ID             IN HRM_COMMON.SOB_ID%TYPE
            , P_ORG_ID             IN HRM_COMMON.ORG_ID%TYPE
            , P_USER_ID            IN HRM_COMMON.CREATED_BY%TYPE
            );

-- LINE UPDATE.
  PROCEDURE COMMON_UPDATE_L
            ( W_COMMON_ID          IN HRM_COMMON.COMMON_ID%TYPE
            , P_CODE_NAME          IN HRM_COMMON.CODE_NAME%TYPE
            , P_VALUE1             IN HRM_COMMON.VALUE1%TYPE
            , P_VALUE2             IN HRM_COMMON.VALUE2%TYPE
            , P_VALUE3             IN HRM_COMMON.VALUE3%TYPE
            , P_VALUE4             IN HRM_COMMON.VALUE4%TYPE
            , P_VALUE5             IN HRM_COMMON.VALUE5%TYPE
            , P_VALUE6             IN HRM_COMMON.VALUE6%TYPE
            , P_VALUE7             IN HRM_COMMON.VALUE7%TYPE
            , P_VALUE8             IN HRM_COMMON.VALUE8%TYPE
            , P_VALUE9             IN HRM_COMMON.VALUE9%TYPE
            , P_VALUE10            IN HRM_COMMON.VALUE10%TYPE
            , P_DEFAULT_FLAG       IN HRM_COMMON.DEFAULT_FLAG%TYPE
            , P_SORT_NUM           IN HRM_COMMON.SORT_NUM%TYPE
            , P_DESCRIPTION        IN HRM_COMMON.DESCRIPTION%TYPE
            , P_ENABLED_FLAG       IN HRM_COMMON.ENABLED_FLAG%TYPE
            , P_EFFECTIVE_DATE_FR  IN HRM_COMMON.EFFECTIVE_DATE_FR%TYPE
            , P_EFFECTIVE_DATE_TO  IN HRM_COMMON.EFFECTIVE_DATE_TO%TYPE
            , P_USER_ID            IN HRM_COMMON.CREATED_BY%TYPE
            );

-----------------------------------------------------------------------------------------
-- 공통코드 명칭 리턴 FUNCTION.
  FUNCTION ID_NAME_F
            ( W_COMMON_ID          IN HRM_COMMON.COMMON_ID%TYPE
            ) RETURN VARCHAR2;

  PROCEDURE ID_NAME
            ( W_COMMON_ID          IN HRM_COMMON.COMMON_ID%TYPE
            , O_RETURN_VALUE       OUT VARCHAR2
            );

  FUNCTION CODE_NAME_F
          ( W_GROUP_CODE          IN HRM_COMMON.GROUP_CODE%TYPE
          , W_CODE                IN HRM_COMMON.CODE%TYPE
          , W_SOB_ID              IN HRM_COMMON.SOB_ID%TYPE
          , W_ORG_ID              IN HRM_COMMON.ORG_ID%TYPE
          ) RETURN VARCHAR2;

  PROCEDURE CODE_NAME
            ( W_GROUP_CODE          IN HRM_COMMON.GROUP_CODE%TYPE
            , W_CODE                IN HRM_COMMON.CODE%TYPE
            , W_SOB_ID              IN HRM_COMMON.SOB_ID%TYPE
            , W_ORG_ID              IN HRM_COMMON.ORG_ID%TYPE
            , O_RETURN_VALUE        OUT VARCHAR2
            );

-- 공통코드 VALUE 리턴 FUNCTION.
  FUNCTION ID_VALUE_F
            ( W_COMMON_ID          IN HRM_COMMON.COMMON_ID%TYPE
            , W_VALUE_ID           IN HRM_COMMON.VALUE1%TYPE
            ) RETURN VARCHAR2;

  PROCEDURE ID_VALUE
            ( W_COMMON_ID          IN HRM_COMMON.COMMON_ID%TYPE
            , W_VALUE_ID           IN HRM_COMMON.VALUE1%TYPE
            , O_RETURN_VALUE       OUT VARCHAR2
            );

  FUNCTION CODE_VALUE_F
           ( W_GROUP_CODE          IN HRM_COMMON.GROUP_CODE%TYPE
           , W_CODE                IN HRM_COMMON.CODE%TYPE
           , W_VALUE_ID            IN HRM_COMMON.VALUE1%TYPE
           , W_SOB_ID              IN HRM_COMMON.SOB_ID%TYPE
           , W_ORG_ID              IN HRM_COMMON.ORG_ID%TYPE
           ) RETURN VARCHAR2;

  PROCEDURE CODE_VALUE
            ( W_GROUP_CODE          IN HRM_COMMON.GROUP_CODE%TYPE
            , W_CODE                IN HRM_COMMON.CODE%TYPE
            , W_VALUE_ID            IN HRM_COMMON.VALUE1%TYPE
            , W_SOB_ID              IN HRM_COMMON.SOB_ID%TYPE
            , W_ORG_ID              IN HRM_COMMON.ORG_ID%TYPE
            , O_RETURN_VALUE        OUT VARCHAR2
            );

-- ID값 코드값 반환.
  FUNCTION GET_ID_F
            ( W_GROUP_CODE          IN HRM_COMMON.GROUP_CODE%TYPE
            , W_WHERE               IN VARCHAR2
            , W_SOB_ID              IN HRM_COMMON.SOB_ID%TYPE
            , W_ORG_ID              IN HRM_COMMON.ORG_ID%TYPE
            ) RETURN NUMBER;

-- CODE값 반환.
  FUNCTION GET_CODE_F
            ( W_COMMON_ID           IN HRM_COMMON.COMMON_ID%TYPE
            , W_SOB_ID              IN HRM_COMMON.SOB_ID%TYPE
            , W_ORG_ID              IN HRM_COMMON.ORG_ID%TYPE
            ) RETURN VARCHAR2;

-- 공통코드 조건값에 맞는 값 리턴 GROUP CODE..
  PROCEDURE GET_VALUE_W
            ( W_GROUP_CODE         IN HRM_COMMON.GROUP_CODE%TYPE
            , W_WHERE              IN VARCHAR2
            , W_SOB_ID             IN HRM_COMMON.SOB_ID%TYPE
            , W_ORG_ID             IN HRM_COMMON.ORG_ID%TYPE
            , O_ID                 OUT HRM_COMMON.COMMON_ID%TYPE
            , O_CODE               OUT HRM_COMMON.CODE%TYPE
            , O_CODE_NAME          OUT HRM_COMMON.CODE_NAME%TYPE
            , O_VALUE1             OUT HRM_COMMON.VALUE1%TYPE
            , O_VALUE2             OUT HRM_COMMON.VALUE2%TYPE
            , O_VALUE3             OUT HRM_COMMON.VALUE3%TYPE
            , O_VALUE4             OUT HRM_COMMON.VALUE1%TYPE
            , O_VALUE5             OUT HRM_COMMON.VALUE2%TYPE
            , O_VALUE6             OUT HRM_COMMON.VALUE3%TYPE
            , O_VALUE7             OUT HRM_COMMON.VALUE1%TYPE
            , O_VALUE8             OUT HRM_COMMON.VALUE2%TYPE
            , O_VALUE9             OUT HRM_COMMON.VALUE3%TYPE
            , O_VALUE10            OUT HRM_COMMON.VALUE3%TYPE
            );
            
-----------------------------------------------------------------------------------------
-- 공통코드 기본값 리턴 - GROUP CODE..
  PROCEDURE DEFAULT_VALUE_GROUP
            ( W_GROUP_CODE          IN HRM_COMMON.GROUP_CODE%TYPE
            , W_SOB_ID              IN HRM_COMMON.SOB_ID%TYPE
            , W_ORG_ID              IN HRM_COMMON.ORG_ID%TYPE
            , O_ID                  OUT HRM_COMMON.COMMON_ID%TYPE
            , O_CODE                OUT HRM_COMMON.CODE%TYPE
            , O_CODE_NAME           OUT HRM_COMMON.CODE_NAME%TYPE
            );

-- 공통코드 기본값 리턴 - VALUE1을 조건 검색하여 : GROUP CODE..
  PROCEDURE DEFAULT_VALUE_GROUP_W
            ( W_GROUP_CODE         IN HRM_COMMON.GROUP_CODE%TYPE
            , W_WHERE              IN VARCHAR2
            , W_SOB_ID             IN HRM_COMMON.SOB_ID%TYPE
            , W_ORG_ID             IN HRM_COMMON.ORG_ID%TYPE
            , O_ID                 OUT HRM_COMMON.COMMON_ID%TYPE
            , O_CODE               OUT HRM_COMMON.CODE%TYPE
            , O_CODE_NAME          OUT HRM_COMMON.CODE_NAME%TYPE
            );

-- SECOM MDB 경로.
  PROCEDURE DV_SECOM_MDB_PATH
            ( W_SOB_ID             IN HRM_COMMON.SOB_ID%TYPE
            , W_ORG_ID             IN HRM_COMMON.ORG_ID%TYPE
            , O_PATH               OUT HRM_COMMON.VALUE1%TYPE
            , O_MDB_NAME           OUT HRM_COMMON.VALUE2%TYPE
            );

-----------------------------------------------------------------------------------------
-- 공통코드 조회 LOOKUP - GROUP CODE..
  PROCEDURE LU_SELECT_GROUP
            ( P_CURSOR3            OUT TYPES.TCURSOR3
            , W_GROUP_CODE         IN HRM_COMMON.GROUP_CODE%TYPE
            , W_CODE_NAME          IN HRM_COMMON.CODE_NAME%TYPE
            , W_SOB_ID             IN HRM_COMMON.SOB_ID%TYPE
            , W_ORG_ID             IN HRM_COMMON.ORG_ID%TYPE
            , W_ENABLED_FLAG_YN    IN HRM_COMMON.ENABLED_FLAG%TYPE DEFAULT 'Y'
            );

-- 공통코드 WHERE 조건으로 조회 LOOKUP.

  PROCEDURE LU_SELECT_GROUP_W
            ( P_CURSOR3            OUT TYPES.TCURSOR3
            , W_GROUP_CODE         IN HRM_COMMON.GROUP_CODE%TYPE
            , W_WHERE              IN VARCHAR2
            , W_SOB_ID             IN HRM_COMMON.SOB_ID%TYPE
            , W_ORG_ID             IN HRM_COMMON.ORG_ID%TYPE
            , W_ENABLED_FLAG_YN    IN HRM_COMMON.ENABLED_FLAG%TYPE DEFAULT 'Y'
            );

-----------------------------------------------------------------------------------------
-- 특정값 전용 Default Valeu
  PROCEDURE DV_MONTH_DUTY_TYPE
            ( W_SOB_ID             IN HRM_COMMON.SOB_ID%TYPE
            , W_ORG_ID             IN HRM_COMMON.ORG_ID%TYPE
            , O_ID                 OUT HRM_COMMON.COMMON_ID%TYPE
            , O_CODE               OUT HRM_COMMON.CODE%TYPE
            , O_CODE_NAME          OUT HRM_COMMON.CODE_NAME%TYPE
            );

-- 특정값 전용 LOOKUP.
  PROCEDURE LU_MONTH_DUTY_TYPE
            ( P_CURSOR3            OUT TYPES.TCURSOR3
            , W_SOB_ID             IN HRM_COMMON.SOB_ID%TYPE
            , W_ORG_ID             IN HRM_COMMON.ORG_ID%TYPE
            , W_ENABLED_FLAG_YN    IN HRM_COMMON.ENABLED_FLAG%TYPE DEFAULT 'Y'
            );

-- 식당명 조회.
  PROCEDURE LU_CAFETERIA
            ( P_CURSOR3            OUT TYPES.TCURSOR3
            , W_USER_ID            IN HRF_FOOD_MANAGER.USER_ID%TYPE
            , W_SOB_ID             IN HRF_FOOD_MANAGER.SOB_ID%TYPE
            , W_ORG_ID             IN HRF_FOOD_MANAGER.ORG_ID%TYPE
            , W_ENABLED_FLAG_YN    IN HRM_COMMON.ENABLED_FLAG%TYPE DEFAULT 'Y'
            );

-- LOOKUP COST CENTER.
  PROCEDURE LU_COST_CENTER
            ( P_CURSOR3            OUT TYPES.TCURSOR3
            , W_SOB_ID             IN CST_COST_CENTER.SOB_ID%TYPE
            , W_ORG_ID             IN CST_COST_CENTER.ORG_ID%TYPE
            , W_ENABLED_FLAG_YN    IN CST_COST_CENTER.ENABLED_FLAG%TYPE DEFAULT 'Y'
            );

-- 공통코드 조회 LOOKUP - 급상여 지급/공제 항목.
  PROCEDURE LU_PAY_ALLOWANCE
            ( P_CURSOR3            OUT TYPES.TCURSOR3
            , W_CODE_NAME          IN HRM_COMMON.CODE_NAME%TYPE
            , W_SOB_ID             IN HRM_COMMON.SOB_ID%TYPE
            , W_ORG_ID             IN HRM_COMMON.ORG_ID%TYPE
            , W_ENABLED_FLAG_YN    IN HRM_COMMON.ENABLED_FLAG%TYPE DEFAULT 'Y'
            );

-----------------------------------------------------------------------------------------            
-- 원가코드 조회 FUNCTION.
  FUNCTION COST_CENTER_CODE_F
            ( W_COST_CENTER_ID     IN CST_COST_CENTER.COST_CENTER_ID%TYPE
            ) RETURN VARCHAR2;

-- 원가명 조회 FUNCTION.
  FUNCTION COST_CENTER_DESC_F
            ( W_COST_CENTER_ID     IN CST_COST_CENTER.COST_CENTER_ID%TYPE
            ) RETURN VARCHAR2;

-----------------------------------------------------------------------------------------
-- FUNCTION : 처리 유형별 소숫점 처리.
  FUNCTION DECIMAL_F
            ( W_SOB_ID             IN HRM_COMMON.SOB_ID%TYPE
            , W_ORG_ID             IN HRM_COMMON.ORG_ID%TYPE
            , W_NUMBER             IN NUMBER
            , W_CAL_TYPE           IN VARCHAR2 DEFAULT NULL
            ) RETURN VARCHAR2;

-- 세율 반환.
  FUNCTION TAX_RATE_F
            ( W_TAX_CODE           IN HRM_COMMON.CODE%TYPE
            , W_SOB_ID             IN HRM_COMMON.SOB_ID%TYPE
            , W_ORG_ID             IN HRM_COMMON.ORG_ID%TYPE
            ) RETURN NUMBER;

-- FUNCTION - WEEK.
  FUNCTION WEEK_F
            ( W_WEEK_CODE          IN HRM_COMMON.CODE%TYPE
            , W_SOB_ID             IN HRM_COMMON.SOB_ID%TYPE
            , W_ORG_ID             IN HRM_COMMON.ORG_ID%TYPE
            ) RETURN VARCHAR2;

-----------------------------------------------------------------------------------------
-- 공통코드 ftp 정보.
  PROCEDURE FTP_INFO_P
            ( W_FTP_INFO_CODE      IN VARCHAR2
            , W_SOB_ID             IN NUMBER
            , W_ORG_ID             IN NUMBER
            , O_FTP_IP             OUT VARCHAR2
            , O_FTP_PORT           OUT VARCHAR2
            , O_FTP_USER_ID        OUT VARCHAR2
            , O_FTP_PASSWORD       OUT VARCHAR2
            , O_FTP_SOURCEPATH     OUT VARCHAR2
            , O_CLIENT_TARGETPATH  OUT VARCHAR2
            , O_FILE_EXTENSION     OUT VARCHAR2
            );

-----------------------------------------------------------------------------------------
-- 인쇄시 필요한 기본 사항 리턴.
  --> 날짜.
  PROCEDURE PRINTED_VALUE1
            ( P_CORP_ID           IN NUMBER
            , P_DATE_FR           IN DATE
            , P_DATE_TO           IN DATE
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , P_CONNECT_PERSON_ID IN NUMBER
            , O_CORP_NAME         OUT VARCHAR2
            , O_PERIOD_DATE       OUT VARCHAR2
            , O_PRINTED_DATE      OUT VARCHAR2
            , O_PRINTED_BY        OUT VARCHAR2
            );
            
  --> 년월.
  PROCEDURE PRINTED_VALUE2
            ( P_CORP_ID           IN NUMBER
            , P_PERIOD_FR         IN VARCHAR2
            , P_PERIOD_TO         IN VARCHAR2
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , P_CONNECT_PERSON_ID IN NUMBER
            , O_CORP_NAME         OUT VARCHAR2
            , O_PERIOD_NAME       OUT VARCHAR2
            , O_PRINTED_DATE      OUT VARCHAR2
            , O_PRINTED_BY        OUT VARCHAR2
            );
            
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
	          ( P_CURSOR           OUT TYPES.TCURSOR
						, W_CODE             IN HRM_COMMON.CODE%TYPE
						, W_CODE_NAME        IN HRM_COMMON.CODE_NAME%TYPE
            , W_ENABLED_FLAG     IN HRM_COMMON.ENABLED_FLAG%TYPE DEFAULT NULL
						, W_SOB_ID           IN HRM_COMMON.SOB_ID%TYPE
						, W_ORG_ID           IN HRM_COMMON.ORG_ID%TYPE
						)
  AS
    D_STD_DATE           DATE := NULL;
  BEGIN
    IF W_ENABLED_FLAG != 'N' THEN
      D_STD_DATE := TRUNC(GET_LOCAL_DATE(W_SOB_ID));
    END IF;
    
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
			FROM HRM_COMMON HC
			WHERE HC.GROUP_CODE             = '-'
				AND HC.CODE                   LIKE W_CODE || '%'
				AND HC.CODE_NAME              LIKE W_CODE_NAME || '%'
				AND HC.SOB_ID                 = W_SOB_ID
				AND HC.ORG_ID                 = W_ORG_ID
        AND NVL(HC.SYSTEM_FLAG, 'N')  != 'E'
        AND ((W_ENABLED_FLAG          = 'N' AND 1 = 1)
        OR   (W_ENABLED_FLAG          != 'N' AND HC.ENABLED_FLAG = W_ENABLED_FLAG))
        AND ((W_ENABLED_FLAG          = 'N' AND 1 = 1)
        OR   (W_ENABLED_FLAG          != 'N' AND ((HC.EFFECTIVE_DATE_FR <= D_STD_DATE)
                                             AND  (HC.EFFECTIVE_DATE_TO >= D_STD_DATE OR HC.EFFECTIVE_DATE_TO IS NULL))))
      ORDER BY HC.SORT_NUM, HC.CODE
      ;
  END COMMON_SELECT_H;

-- HEADER INSERT.
  PROCEDURE COMMON_INSERT_H
	          ( P_COMMON_ID        OUT HRM_COMMON.COMMON_ID%TYPE
            , P_CODE             IN HRM_COMMON.CODE%TYPE
						, P_CODE_NAME        IN HRM_COMMON.CODE_NAME%TYPE
						, P_CODE_LENGHT      IN HRM_COMMON.CODE_LENGTH%TYPE
						, P_VALUE1           IN HRM_COMMON.VALUE1%TYPE
						, P_VALUE2           IN HRM_COMMON.VALUE2%TYPE
						, P_VALUE3           IN HRM_COMMON.VALUE3%TYPE
						, P_VALUE4           IN HRM_COMMON.VALUE4%TYPE
						, P_VALUE5           IN HRM_COMMON.VALUE5%TYPE
						, P_VALUE6           IN HRM_COMMON.VALUE6%TYPE
						, P_VALUE7           IN HRM_COMMON.VALUE7%TYPE
            , P_VALUE8           IN HRM_COMMON.VALUE8%TYPE
            , P_VALUE9           IN HRM_COMMON.VALUE9%TYPE
            , P_VALUE10          IN HRM_COMMON.VALUE10%TYPE
						, P_SOB_ID           IN HRM_COMMON.SOB_ID%TYPE
						, P_ORG_ID           IN HRM_COMMON.ORG_ID%TYPE
						, P_USER_ID          IN HRM_COMMON.CREATED_BY%TYPE
						)
  AS
	  D_SYSDATE                    DATE;

  BEGIN
	  D_SYSDATE := GET_LOCAL_DATE(P_SOB_ID);
		SELECT HRM_COMMON_S1.NEXTVAL
      INTO P_COMMON_ID
      FROM DUAL;

		INSERT INTO HRM_COMMON
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
	          ( W_COMMON_ID        IN HRM_COMMON.COMMON_ID%TYPE
						, P_CODE_NAME        IN HRM_COMMON.CODE_NAME%TYPE
						, P_CODE_LENGHT      IN HRM_COMMON.CODE_LENGTH%TYPE
						, P_VALUE1           IN HRM_COMMON.VALUE1%TYPE
						, P_VALUE2           IN HRM_COMMON.VALUE2%TYPE
						, P_VALUE3           IN HRM_COMMON.VALUE3%TYPE
						, P_VALUE4           IN HRM_COMMON.VALUE4%TYPE
						, P_VALUE5           IN HRM_COMMON.VALUE5%TYPE
						, P_VALUE6           IN HRM_COMMON.VALUE6%TYPE
						, P_VALUE7           IN HRM_COMMON.VALUE7%TYPE
            , P_VALUE8           IN HRM_COMMON.VALUE8%TYPE
            , P_VALUE9           IN HRM_COMMON.VALUE9%TYPE
            , P_VALUE10          IN HRM_COMMON.VALUE10%TYPE
						, P_USER_ID          IN HRM_COMMON.CREATED_BY%TYPE
						)
  AS
  BEGIN
		UPDATE HRM_COMMON HC
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
						, W_GROUP_CODE       IN HRM_COMMON.GROUP_CODE%TYPE
            , W_ENABLED_FLAG     IN HRM_COMMON.ENABLED_FLAG%TYPE DEFAULT NULL
						, W_SOB_ID           IN HRM_COMMON.SOB_ID%TYPE
						, W_ORG_ID           IN HRM_COMMON.ORG_ID%TYPE
						)
  AS
    D_STD_DATE           DATE := NULL;
  BEGIN
    IF W_ENABLED_FLAG != 'N' THEN
      D_STD_DATE := TRUNC(GET_LOCAL_DATE(W_SOB_ID));
    END IF;
    
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
       FROM HRM_COMMON HC
     WHERE HC.GROUP_CODE            = W_GROUP_CODE
        AND HC.SOB_ID               = W_SOB_ID
        AND HC.ORG_ID               = W_ORG_ID
        AND ((W_ENABLED_FLAG        = 'N' AND 1 = 1)
        OR   (W_ENABLED_FLAG        != 'N' AND HC.ENABLED_FLAG = W_ENABLED_FLAG))
        AND ((W_ENABLED_FLAG        = 'N' AND 1 = 1)
        OR   (W_ENABLED_FLAG        != 'N' AND ((HC.EFFECTIVE_DATE_FR <= D_STD_DATE)
                                           AND  (HC.EFFECTIVE_DATE_TO >= D_STD_DATE OR HC.EFFECTIVE_DATE_TO IS NULL))))
     ORDER BY HC.SORT_NUM, HC.CODE
     ;
  END COMMON_SELECT_L;

-- LINE INSERT.
  PROCEDURE COMMON_INSERT_L
           ( P_COMMON_ID           OUT HRM_COMMON.COMMON_ID%TYPE
            , P_GROUP_CODE         IN HRM_COMMON.GROUP_CODE%TYPE
            , P_CODE               IN HRM_COMMON.CODE%TYPE
            , P_CODE_NAME          IN HRM_COMMON.CODE_NAME%TYPE
            , P_VALUE1             IN HRM_COMMON.VALUE1%TYPE
            , P_VALUE2             IN HRM_COMMON.VALUE2%TYPE
            , P_VALUE3             IN HRM_COMMON.VALUE3%TYPE
            , P_VALUE4             IN HRM_COMMON.VALUE4%TYPE
            , P_VALUE5             IN HRM_COMMON.VALUE5%TYPE
            , P_VALUE6             IN HRM_COMMON.VALUE6%TYPE
            , P_VALUE7             IN HRM_COMMON.VALUE7%TYPE
            , P_VALUE8             IN HRM_COMMON.VALUE8%TYPE
            , P_VALUE9             IN HRM_COMMON.VALUE9%TYPE
            , P_VALUE10            IN HRM_COMMON.VALUE10%TYPE
            , P_DEFAULT_FLAG       IN HRM_COMMON.DEFAULT_FLAG%TYPE
            , P_SORT_NUM           IN HRM_COMMON.SORT_NUM%TYPE
            , P_DESCRIPTION        IN HRM_COMMON.DESCRIPTION%TYPE
            , P_ENABLED_FLAG       IN HRM_COMMON.ENABLED_FLAG%TYPE
            , P_EFFECTIVE_DATE_FR  IN HRM_COMMON.EFFECTIVE_DATE_FR%TYPE
            , P_EFFECTIVE_DATE_TO  IN HRM_COMMON.EFFECTIVE_DATE_TO%TYPE
            , P_SOB_ID             IN HRM_COMMON.SOB_ID%TYPE
            , P_ORG_ID             IN HRM_COMMON.ORG_ID%TYPE
            , P_USER_ID            IN HRM_COMMON.CREATED_BY%TYPE
      )
  AS
    D_SYSDATE                      DATE;
  BEGIN
    D_SYSDATE := GET_LOCAL_DATE(P_SOB_ID);
    SELECT HRM_COMMON_S1.NEXTVAL
      INTO P_COMMON_ID
      FROM DUAL;

    INSERT INTO HRM_COMMON
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
    , NVL(P_SORT_NUM, 0), P_DESCRIPTION, P_ENABLED_FLAG, TRUNC(P_EFFECTIVE_DATE_FR), TRUNC(P_EFFECTIVE_DATE_TO)
    , P_SOB_ID, P_ORG_ID
    , D_SYSDATE, P_USER_ID, D_SYSDATE, P_USER_ID
    );
  END COMMON_INSERT_L;

-- LINE UPDATE.
  PROCEDURE COMMON_UPDATE_L
           ( W_COMMON_ID          IN HRM_COMMON.COMMON_ID%TYPE
            , P_CODE_NAME          IN HRM_COMMON.CODE_NAME%TYPE
            , P_VALUE1             IN HRM_COMMON.VALUE1%TYPE
            , P_VALUE2             IN HRM_COMMON.VALUE2%TYPE
            , P_VALUE3             IN HRM_COMMON.VALUE3%TYPE
            , P_VALUE4             IN HRM_COMMON.VALUE4%TYPE
            , P_VALUE5             IN HRM_COMMON.VALUE5%TYPE
            , P_VALUE6             IN HRM_COMMON.VALUE6%TYPE
            , P_VALUE7             IN HRM_COMMON.VALUE7%TYPE
            , P_VALUE8             IN HRM_COMMON.VALUE8%TYPE
            , P_VALUE9             IN HRM_COMMON.VALUE9%TYPE
            , P_VALUE10            IN HRM_COMMON.VALUE10%TYPE
            , P_DEFAULT_FLAG       IN HRM_COMMON.DEFAULT_FLAG%TYPE
            , P_SORT_NUM           IN HRM_COMMON.SORT_NUM%TYPE
            , P_DESCRIPTION        IN HRM_COMMON.DESCRIPTION%TYPE
            , P_ENABLED_FLAG       IN HRM_COMMON.ENABLED_FLAG%TYPE
            , P_EFFECTIVE_DATE_FR  IN HRM_COMMON.EFFECTIVE_DATE_FR%TYPE
            , P_EFFECTIVE_DATE_TO  IN HRM_COMMON.EFFECTIVE_DATE_TO%TYPE
            , P_USER_ID            IN HRM_COMMON.CREATED_BY%TYPE
      )
  AS
  BEGIN
    UPDATE HRM_COMMON HC
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
          , HC.SORT_NUM              = NVL(P_SORT_NUM, 0)
          , HC.DESCRIPTION           = P_DESCRIPTION
          , HC.ENABLED_FLAG          = P_ENABLED_FLAG
          , HC.EFFECTIVE_DATE_FR     = TRUNC(P_EFFECTIVE_DATE_FR)
          , HC.EFFECTIVE_DATE_TO     = TRUNC(P_EFFECTIVE_DATE_TO)
          , HC.LAST_UPDATE_DATE      = GET_LOCAL_DATE(HC.SOB_ID)
          , HC.LAST_UPDATED_BY       = P_USER_ID
     WHERE HC.COMMON_ID           = W_COMMON_ID
     ;
  END COMMON_UPDATE_L;


-----------------------------------------------------------------------------------------
-- 공통코드 명칭 리턴 FUNCTION.
  FUNCTION ID_NAME_F
            ( W_COMMON_ID          IN HRM_COMMON.COMMON_ID%TYPE
            ) RETURN VARCHAR2
  AS
    V_RETURN_VALUE                 VARCHAR2(150) := NULL;
  BEGIN
    BEGIN
      SELECT  HC.CODE_NAME
        INTO V_RETURN_VALUE
      FROM HRM_COMMON HC
      WHERE HC.COMMON_ID           = W_COMMON_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_RETURN_VALUE := NULL;
    END;
    RETURN V_RETURN_VALUE;

  END ID_NAME_F;

  PROCEDURE ID_NAME
           ( W_COMMON_ID          IN HRM_COMMON.COMMON_ID%TYPE
           , O_RETURN_VALUE       OUT VARCHAR2
           )
  AS
  BEGIN
    BEGIN
        SELECT  HC.CODE_NAME
          INTO O_RETURN_VALUE
        FROM HRM_COMMON HC
        WHERE HC.COMMON_ID           = W_COMMON_ID
        ;
    EXCEPTION WHEN OTHERS THEN
     O_RETURN_VALUE := NULL;
    END;
  END ID_NAME;

  FUNCTION CODE_NAME_F
          ( W_GROUP_CODE          IN HRM_COMMON.GROUP_CODE%TYPE
          , W_CODE                IN HRM_COMMON.CODE%TYPE
          , W_SOB_ID              IN HRM_COMMON.SOB_ID%TYPE
          , W_ORG_ID              IN HRM_COMMON.ORG_ID%TYPE
          ) RETURN VARCHAR2
  AS
    V_RETURN_VALUE                VARCHAR2(150) := NULL;
  BEGIN
    BEGIN
     SELECT HC.CODE_NAME
       INTO V_RETURN_VALUE
       FROM HRM_COMMON HC
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
           ( W_GROUP_CODE          IN HRM_COMMON.GROUP_CODE%TYPE
           , W_CODE                IN HRM_COMMON.CODE%TYPE
           , W_SOB_ID              IN HRM_COMMON.SOB_ID%TYPE
           , W_ORG_ID              IN HRM_COMMON.ORG_ID%TYPE
           , O_RETURN_VALUE        OUT VARCHAR2
           )
  AS
  BEGIN
    BEGIN
     SELECT HC.CODE_NAME
       INTO O_RETURN_VALUE
       FROM HRM_COMMON HC
     WHERE HC.GROUP_CODE          = W_GROUP_CODE
       AND HC.CODE                = W_CODE
       AND HC.SOB_ID              = W_SOB_ID
       AND HC.ORG_ID              = W_ORG_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      O_RETURN_VALUE := NULL;
    END;
 END CODE_NAME;

-- 공통코드 VALUE 리턴 FUNCTION.
  FUNCTION ID_VALUE_F
            ( W_COMMON_ID          IN HRM_COMMON.COMMON_ID%TYPE
            , W_VALUE_ID           IN HRM_COMMON.VALUE1%TYPE
            ) RETURN VARCHAR2
  AS
    V_RETURN_VALUE                 VARCHAR2(150) := NULL;
    V_STRING                       VARCHAR2(1000) := NULL;
  BEGIN
    BEGIN
      V_STRING := 'SELECT ' || W_VALUE_ID ||
                  '  FROM HRM_COMMON
                    WHERE COMMON_ID     = ' || W_COMMON_ID ;
      EXECUTE IMMEDIATE V_STRING
      INTO V_RETURN_VALUE;

    EXCEPTION WHEN OTHERS THEN
      V_RETURN_VALUE := NULL;
    END;
    RETURN V_RETURN_VALUE;
  END ID_VALUE_F;

  PROCEDURE ID_VALUE
            ( W_COMMON_ID          IN HRM_COMMON.COMMON_ID%TYPE
            , W_VALUE_ID           IN HRM_COMMON.VALUE1%TYPE
            , O_RETURN_VALUE       OUT VARCHAR2
            )
  AS
  BEGIN
    BEGIN
      O_RETURN_VALUE := ID_VALUE_F( W_COMMON_ID, W_VALUE_ID);
    EXCEPTION WHEN OTHERS THEN
      O_RETURN_VALUE := NULL;
    END;
  END ID_VALUE;

  FUNCTION CODE_VALUE_F
           ( W_GROUP_CODE          IN HRM_COMMON.GROUP_CODE%TYPE
           , W_CODE                IN HRM_COMMON.CODE%TYPE
           , W_VALUE_ID            IN HRM_COMMON.VALUE1%TYPE
           , W_SOB_ID              IN HRM_COMMON.SOB_ID%TYPE
           , W_ORG_ID              IN HRM_COMMON.ORG_ID%TYPE
           ) RETURN VARCHAR2
  AS
    V_RETURN_VALUE                 VARCHAR2(150) := NULL;
    V_STRING                       VARCHAR2(1000) := NULL;
  BEGIN
    BEGIN
      V_STRING := 'SELECT ' || W_VALUE_ID ||
                  '  FROM HRM_COMMON
                    WHERE GROUP_CODE     = ''' || W_GROUP_CODE || '''
                      AND CODE           = ''' || W_CODE || '''
                      AND SOB_ID         = ' || W_SOB_ID || '
                      AND ORG_ID         = ' || W_ORG_ID ;
      EXECUTE IMMEDIATE V_STRING
      INTO V_RETURN_VALUE;
    EXCEPTION WHEN OTHERS THEN
      V_RETURN_VALUE := NULL;
    END;
    RETURN V_RETURN_VALUE;
  END CODE_VALUE_F;

  PROCEDURE CODE_VALUE
            ( W_GROUP_CODE          IN HRM_COMMON.GROUP_CODE%TYPE
            , W_CODE                IN HRM_COMMON.CODE%TYPE
            , W_VALUE_ID            IN HRM_COMMON.VALUE1%TYPE
            , W_SOB_ID              IN HRM_COMMON.SOB_ID%TYPE
            , W_ORG_ID              IN HRM_COMMON.ORG_ID%TYPE
            , O_RETURN_VALUE        OUT VARCHAR2
            )
  AS
  BEGIN
    BEGIN
      O_RETURN_VALUE := CODE_VALUE_F( W_GROUP_CODE, W_CODE, W_VALUE_ID, W_SOB_ID, W_ORG_ID);
    EXCEPTION WHEN OTHERS THEN
      O_RETURN_VALUE := NULL;
    END;
  END CODE_VALUE;


-- ID값 코드값 반환.
  FUNCTION GET_ID_F
            ( W_GROUP_CODE          IN HRM_COMMON.GROUP_CODE%TYPE
            , W_WHERE               IN VARCHAR2
            , W_SOB_ID              IN HRM_COMMON.SOB_ID%TYPE
            , W_ORG_ID              IN HRM_COMMON.ORG_ID%TYPE
            ) RETURN NUMBER
  AS
    V_RETURN_ID                    NUMBER := NULL;
    V_STRING                       VARCHAR2(1000) := NULL;
  BEGIN
    BEGIN
      V_STRING := 'SELECT COMMON_ID 
                      FROM HRM_COMMON
                    WHERE GROUP_CODE     = ''' || W_GROUP_CODE || '''
                      AND ' || W_WHERE || '
                      AND SOB_ID         = ' || W_SOB_ID || '
                      AND ORG_ID         = ' || W_ORG_ID 
                      ;
      EXECUTE IMMEDIATE V_STRING
      INTO V_RETURN_ID;
    EXCEPTION WHEN OTHERS THEN
      V_RETURN_ID := NULL;
    END;
    RETURN V_RETURN_ID;
  END GET_ID_F;

-- CODE값 반환.
  FUNCTION GET_CODE_F
            ( W_COMMON_ID           IN HRM_COMMON.COMMON_ID%TYPE
            , W_SOB_ID              IN HRM_COMMON.SOB_ID%TYPE
            , W_ORG_ID              IN HRM_COMMON.ORG_ID%TYPE
            ) RETURN VARCHAR2
  AS
    V_CODE    VARCHAR2(20) := NULL;
  BEGIN
    BEGIN
      SELECT HC.CODE
        INTO V_CODE
        FROM HRM_COMMON HC
      WHERE HC.COMMON_ID          = W_COMMON_ID
        AND HC.SOB_ID             = W_SOB_ID
        AND HC.ORG_ID             = W_ORG_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      NULL;
    END;
    RETURN V_CODE;
  END GET_CODE_F;

-- 공통코드 조건값에 맞는 값 리턴 GROUP CODE..
  PROCEDURE GET_VALUE_W
            ( W_GROUP_CODE         IN HRM_COMMON.GROUP_CODE%TYPE
            , W_WHERE              IN VARCHAR2
            , W_SOB_ID             IN HRM_COMMON.SOB_ID%TYPE
            , W_ORG_ID             IN HRM_COMMON.ORG_ID%TYPE
            , O_ID                 OUT HRM_COMMON.COMMON_ID%TYPE
            , O_CODE               OUT HRM_COMMON.CODE%TYPE
            , O_CODE_NAME          OUT HRM_COMMON.CODE_NAME%TYPE
            , O_VALUE1             OUT HRM_COMMON.VALUE1%TYPE
            , O_VALUE2             OUT HRM_COMMON.VALUE2%TYPE
            , O_VALUE3             OUT HRM_COMMON.VALUE3%TYPE
            , O_VALUE4             OUT HRM_COMMON.VALUE1%TYPE
            , O_VALUE5             OUT HRM_COMMON.VALUE2%TYPE
            , O_VALUE6             OUT HRM_COMMON.VALUE3%TYPE
            , O_VALUE7             OUT HRM_COMMON.VALUE1%TYPE
            , O_VALUE8             OUT HRM_COMMON.VALUE2%TYPE
            , O_VALUE9             OUT HRM_COMMON.VALUE3%TYPE
            , O_VALUE10            OUT HRM_COMMON.VALUE3%TYPE
      )
  AS
    V_STRING                       VARCHAR2(1000);
  BEGIN
    BEGIN
      V_STRING := 'SELECT HC.CODE_NAME, HC.CODE, HC.COMMON_ID
                       , HC.VALUE1, HC.VALUE2, HC.VALUE3, HC.VALUE4, HC.VALUE5
                       , HC.VALUE6, HC.VALUE7, HC.VALUE8, HC.VALUE9, HC.VALUE10
                     FROM HRM_COMMON HC
                    WHERE HC.GROUP_CODE            = ''' || W_GROUP_CODE  || '''
                      AND HC.SOB_ID                = ' || W_SOB_ID || '
                      AND HC.ORG_ID                = ' || W_ORG_ID || '
                      AND ' || W_WHERE  || '
                      AND ROWNUM                   <= 1
                      AND HC.ENABLED_FLAG          = ''Y''
                      AND HC.EFFECTIVE_DATE_FR     <= GET_LOCAL_DATE(HC.SOB_ID)
                      AND (HC.EFFECTIVE_DATE_TO IS NULL OR HC.EFFECTIVE_DATE_TO  >= GET_LOCAL_DATE(HC.SOB_ID)) ';
--      DBMS_OUTPUT.PUT_LINE(V_STRING);
      EXECUTE IMMEDIATE V_STRING
      INTO O_CODE_NAME, O_CODE, O_ID
          , O_VALUE1, O_VALUE2, O_VALUE3, O_VALUE4, O_VALUE5
          , O_VALUE6, O_VALUE7, O_VALUE8, O_VALUE9, O_VALUE10
      ;
   EXCEPTION WHEN OTHERS THEN
      O_ID := 0;
      O_CODE := NULL;
      O_CODE_NAME := NULL;
      O_VALUE1 := NULL;
      O_VALUE2 := NULL;
      O_VALUE3 := NULL;
      O_VALUE4 := NULL;
      O_VALUE5 := NULL;
      O_VALUE6 := NULL;
      O_VALUE7 := NULL;
      O_VALUE8 := NULL;
      O_VALUE9 := NULL;
      O_VALUE10 := NULL;
   END;
  END GET_VALUE_W;

-----------------------------------------------------------------------------------------
-- 공통코드 기본값 리턴 - GROUP CODE..
  PROCEDURE DEFAULT_VALUE_GROUP
            ( W_GROUP_CODE          IN HRM_COMMON.GROUP_CODE%TYPE
            , W_SOB_ID              IN HRM_COMMON.SOB_ID%TYPE
            , W_ORG_ID              IN HRM_COMMON.ORG_ID%TYPE
            , O_ID                  OUT HRM_COMMON.COMMON_ID%TYPE
            , O_CODE                OUT HRM_COMMON.CODE%TYPE
            , O_CODE_NAME           OUT HRM_COMMON.CODE_NAME%TYPE
            )
  AS
  BEGIN
    BEGIN
			SELECT SX1.CODE_NAME, SX1.CODE, SX1.COMMON_ID
        INTO O_CODE_NAME, O_CODE, O_ID      
        FROM (SELECT HC.CODE_NAME, HC.CODE, HC.COMMON_ID
                FROM HRM_COMMON HC
              WHERE HC.GROUP_CODE            = W_GROUP_CODE
                AND HC.SOB_ID                = W_SOB_ID
                AND HC.ORG_ID                = W_ORG_ID
                AND HC.DEFAULT_FLAG          = 'Y'
                AND HC.ENABLED_FLAG          = 'Y'
                AND HC.EFFECTIVE_DATE_FR     <= GET_LOCAL_DATE(HC.SOB_ID)
                AND (HC.EFFECTIVE_DATE_TO IS NULL OR HC.EFFECTIVE_DATE_TO  >= GET_LOCAL_DATE(HC.SOB_ID))
              ORDER BY HC.CODE
              ) SX1
      WHERE ROWNUM                <= 1
      ;
	  EXCEPTION WHEN OTHERS THEN
		  O_ID := 0;
		  O_CODE := NULL;
		  O_CODE_NAME := NULL;
	  END;
  END DEFAULT_VALUE_GROUP;


-- 공통코드 기본값 리턴 - VALUE1을 조건 검색하여 : GROUP CODE..
  PROCEDURE DEFAULT_VALUE_GROUP_W
            ( W_GROUP_CODE         IN HRM_COMMON.GROUP_CODE%TYPE
            , W_WHERE              IN VARCHAR2
            , W_SOB_ID             IN HRM_COMMON.SOB_ID%TYPE
            , W_ORG_ID             IN HRM_COMMON.ORG_ID%TYPE
            , O_ID                 OUT HRM_COMMON.COMMON_ID%TYPE
            , O_CODE               OUT HRM_COMMON.CODE%TYPE
            , O_CODE_NAME          OUT HRM_COMMON.CODE_NAME%TYPE
            )
  AS
    V_STRING                       VARCHAR2(1000);
  BEGIN
    BEGIN
      V_STRING := 'SELECT SX1.CODE_NAME, SX1.CODE, SX1.COMMON_ID  
                     FROM (SELECT HC.CODE_NAME, HC.CODE, HC.COMMON_ID
                             FROM HRM_COMMON HC
                           WHERE HC.GROUP_CODE            = ''' || W_GROUP_CODE  || '''
                             AND HC.SOB_ID                = ' || W_SOB_ID || '
                             AND HC.ORG_ID                = ' || W_ORG_ID || '
                             AND ' || W_WHERE  || '
                             AND HC.DEFAULT_FLAG          = ''Y''
                             AND HC.ENABLED_FLAG          = ''Y''
                             AND HC.EFFECTIVE_DATE_FR     <= GET_LOCAL_DATE(HC.SOB_ID)
                             AND (HC.EFFECTIVE_DATE_TO IS NULL OR HC.EFFECTIVE_DATE_TO  >= GET_LOCAL_DATE(HC.SOB_ID)) 
                           ORDER BY HC.CODE
                          ) SX1
                   WHERE ROWNUM             <= 1';
--      DBMS_OUTPUT.PUT_LINE(V_STRING);
      EXECUTE IMMEDIATE V_STRING
      INTO O_CODE_NAME, O_CODE, O_ID;
   EXCEPTION WHEN OTHERS THEN
    O_ID := 0;
    O_CODE := NULL;
    O_CODE_NAME := NULL;
   END;
 END DEFAULT_VALUE_GROUP_W;

-- SECOM MDB 경로.
  PROCEDURE DV_SECOM_MDB_PATH
            ( W_SOB_ID             IN HRM_COMMON.SOB_ID%TYPE
            , W_ORG_ID             IN HRM_COMMON.ORG_ID%TYPE
            , O_PATH               OUT HRM_COMMON.VALUE1%TYPE
            , O_MDB_NAME           OUT HRM_COMMON.VALUE2%TYPE
            )
  AS
  BEGIN
    BEGIN
      SELECT HC.VALUE1 AS MDB_PATH, HC.VALUE2 AS MDB_NAME
        INTO O_PATH, O_MDB_NAME
        FROM HRM_COMMON HC
       WHERE HC.GROUP_CODE        = 'SECOM_DB_PATH'
         AND HC.SOB_ID            = W_SOB_ID
         AND HC.ORG_ID            = W_ORG_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      O_PATH := 'C:\';
      O_MDB_NAME := 'Alarm_YYYYMMDD.VMD';
    END;
  END DV_SECOM_MDB_PATH;

-----------------------------------------------------------------------------------------
-- 공통코드 조회 LOOKUP - GROUP CODE..
  PROCEDURE LU_SELECT_GROUP
            ( P_CURSOR3            OUT TYPES.TCURSOR3
            , W_GROUP_CODE         IN HRM_COMMON.GROUP_CODE%TYPE
            , W_CODE_NAME          IN HRM_COMMON.CODE_NAME%TYPE
            , W_SOB_ID             IN HRM_COMMON.SOB_ID%TYPE
            , W_ORG_ID             IN HRM_COMMON.ORG_ID%TYPE
            , W_ENABLED_FLAG_YN    IN HRM_COMMON.ENABLED_FLAG%TYPE DEFAULT 'Y'
            )
  AS
    V_STD_DATE                     HRM_COMMON.EFFECTIVE_DATE_FR%TYPE := NULL;
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
        FROM HRM_COMMON HC
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
            , W_GROUP_CODE         IN HRM_COMMON.GROUP_CODE%TYPE
            , W_WHERE              IN VARCHAR2
            , W_SOB_ID             IN HRM_COMMON.SOB_ID%TYPE
            , W_ORG_ID             IN HRM_COMMON.ORG_ID%TYPE
            , W_ENABLED_FLAG_YN    IN HRM_COMMON.ENABLED_FLAG%TYPE DEFAULT 'Y'
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
    DELETE FROM HRM_COMMON_GT;
    V_STRING := 'INSERT INTO HRM_COMMON_GT
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
                   FROM HRM_COMMON HC
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
       FROM HRM_COMMON_GT HC ;
  END LU_SELECT_GROUP_W;

-----------------------------------------------------------------------------------------
-- 특정값 전용 Default Valeu
  PROCEDURE DV_MONTH_DUTY_TYPE
            ( W_SOB_ID             IN HRM_COMMON.SOB_ID%TYPE
            , W_ORG_ID             IN HRM_COMMON.ORG_ID%TYPE
            , O_ID                 OUT HRM_COMMON.COMMON_ID%TYPE
            , O_CODE               OUT HRM_COMMON.CODE%TYPE
            , O_CODE_NAME          OUT HRM_COMMON.CODE_NAME%TYPE
            )
  AS
  BEGIN
    BEGIN
		  SELECT SX1.CLOSING_TYPE_NAME
           , SX1.CLOSING_TYPE
           , SX1.CLOSING_TYPE_ID
        INTO O_CODE_NAME, O_CODE, O_ID
        FROM (SELECT CT.CLOSING_TYPE_NAME
                  , CT.CLOSING_TYPE
                  , CT.CLOSING_TYPE_ID
              FROM HRM_CLOSING_TYPE_V CT
              WHERE CT.MODULE_TYPE           = 'DUTY'
                AND CT.MONTH_TOTAL_YN        = 'Y'
                AND CT.SOB_ID                = W_SOB_ID
                AND CT.ORG_ID                = W_ORG_ID
                AND CT.DEFAULT_FLAG          = 'Y'
                AND CT.ENABLED_FLAG          = 'Y'
                AND CT.EFFECTIVE_DATE_FR     <= GET_LOCAL_DATE(CT.SOB_ID)
                AND (CT.EFFECTIVE_DATE_TO IS NULL OR CT.EFFECTIVE_DATE_TO >= GET_LOCAL_DATE(CT.SOB_ID))
             ) SX1
      WHERE ROWNUM                <= 1
			;
    EXCEPTION WHEN OTHERS THEN
		  O_ID := 0;
		  O_CODE := NULL;
		  O_CODE_NAME := NULL;
	  END;
  END DV_MONTH_DUTY_TYPE;

-- 특정값 전용 LOOKUP.
  PROCEDURE LU_MONTH_DUTY_TYPE
            ( P_CURSOR3            OUT TYPES.TCURSOR3
            , W_SOB_ID             IN HRM_COMMON.SOB_ID%TYPE
            , W_ORG_ID             IN HRM_COMMON.ORG_ID%TYPE
            , W_ENABLED_FLAG_YN    IN HRM_COMMON.ENABLED_FLAG%TYPE DEFAULT 'Y'
            )
  AS
   V_STD_DATE                     HRM_COMMON.EFFECTIVE_DATE_FR%TYPE := NULL;

  BEGIN
    IF W_ENABLED_FLAG_YN = 'Y' THEN
     V_STD_DATE := TRUNC(GET_LOCAL_DATE(W_SOB_ID));
    ELSE
     V_STD_DATE := NULL;
    END IF;

    OPEN P_CURSOR3 FOR
      SELECT CT.CLOSING_TYPE_NAME
         , CT.CLOSING_TYPE
         , CT.CLOSING_TYPE_ID
       FROM HRM_CLOSING_TYPE_V CT
      WHERE CT.MODULE_TYPE           = 'DUTY'
       AND CT.MONTH_TOTAL_YN        = 'Y'
       AND CT.SOB_ID                = W_SOB_ID
       AND CT.ORG_ID                = W_ORG_ID
       AND CT.ENABLED_FLAG       = DECODE(W_ENABLED_FLAG_YN, 'Y', 'Y', CT.ENABLED_FLAG)
       AND CT.EFFECTIVE_DATE_FR  <= NVL(V_STD_DATE, CT.EFFECTIVE_DATE_FR)
       AND (CT.EFFECTIVE_DATE_TO IS NULL OR CT.EFFECTIVE_DATE_TO >= NVL(V_STD_DATE, CT.EFFECTIVE_DATE_TO))
      ORDER BY CT.SORT_NUM, CT.CLOSING_TYPE
      ;
  END LU_MONTH_DUTY_TYPE;

-- 식당명 조회.
  PROCEDURE LU_CAFETERIA
            ( P_CURSOR3            OUT TYPES.TCURSOR3
            , W_USER_ID            IN HRF_FOOD_MANAGER.USER_ID%TYPE
            , W_SOB_ID             IN HRF_FOOD_MANAGER.SOB_ID%TYPE
            , W_ORG_ID             IN HRF_FOOD_MANAGER.ORG_ID%TYPE
            , W_ENABLED_FLAG_YN    IN HRM_COMMON.ENABLED_FLAG%TYPE DEFAULT 'Y'
            )
  AS
    V_STD_DATE                     HRM_COMMON.EFFECTIVE_DATE_FR%TYPE := NULL;
  BEGIN
    IF W_ENABLED_FLAG_YN = 'Y' THEN
      V_STD_DATE := TRUNC(GET_LOCAL_DATE(W_SOB_ID));
    ELSE
      V_STD_DATE := NULL;
    END IF;

    OPEN P_CURSOR3 FOR
      SELECT HD.DEVICE_NAME
          , HD.DEVICE_CODE
          , HD.DEVICE_ID
          , HD.DEVICE_CODE AS SOURCE_DEVICE_CODE
          , HD.VALUE2
          , HD.MODULE_TYPE
          , HD.VALUE4
          , HD.VALUE5
          , HD.VALUE6
          , HD.VALUE7
          , HD.VALUE8
          , HD.VALUE9
          , HD.VALUE10
        FROM HRF_FOOD_MANAGER FM
          , HRM_DEVICE_V HD
      WHERE FM.DEVICE_ID             = HD.DEVICE_ID
        AND FM.USER_ID               = W_USER_ID
        AND FM.SOB_ID                = W_SOB_ID
        AND FM.ORG_ID                = W_ORG_ID
        AND FM.ENABLED_FLAG          = DECODE(W_ENABLED_FLAG_YN, 'Y', 'Y', FM.ENABLED_FLAG)
        AND FM.EFFECTIVE_DATE_FR     <= NVL(V_STD_DATE, FM.EFFECTIVE_DATE_FR)
        AND (FM.EFFECTIVE_DATE_TO IS NULL OR FM.EFFECTIVE_DATE_TO  >= NVL(V_STD_DATE, FM.EFFECTIVE_DATE_TO))
      ORDER BY HD.SORT_NUM
      ;
 END LU_CAFETERIA;

-- LOOKUP COST CENTER.
  PROCEDURE LU_COST_CENTER
            ( P_CURSOR3            OUT TYPES.TCURSOR3
            , W_SOB_ID             IN CST_COST_CENTER.SOB_ID%TYPE
            , W_ORG_ID             IN CST_COST_CENTER.ORG_ID%TYPE
            , W_ENABLED_FLAG_YN    IN CST_COST_CENTER.ENABLED_FLAG%TYPE DEFAULT 'Y'
            )
  AS
    V_STD_DATE                     HRM_COMMON.EFFECTIVE_DATE_FR%TYPE := NULL;
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

-- 공통코드 조회 LOOKUP - 급상여 지급/공제 항목.
  PROCEDURE LU_PAY_ALLOWANCE
            ( P_CURSOR3            OUT TYPES.TCURSOR3
            , W_CODE_NAME          IN HRM_COMMON.CODE_NAME%TYPE
            , W_SOB_ID             IN HRM_COMMON.SOB_ID%TYPE
            , W_ORG_ID             IN HRM_COMMON.ORG_ID%TYPE
            , W_ENABLED_FLAG_YN    IN HRM_COMMON.ENABLED_FLAG%TYPE DEFAULT 'Y'
            )
  AS
    V_STD_DATE                     HRM_COMMON.EFFECTIVE_DATE_FR%TYPE := NULL;
  BEGIN
    IF W_ENABLED_FLAG_YN = 'Y' THEN
      V_STD_DATE := TRUNC(GET_LOCAL_DATE(W_SOB_ID));
    ELSE
      V_STD_DATE := NULL;
    END IF;

    OPEN P_CURSOR3 FOR
      SELECT HC.CODE_NAME AS ALLOWANCE_NAME
          , HC.CODE AS ALLOWANCE_CODE
          , HC.COMMON_ID AS ALLOWANCE_ID
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
        FROM HRM_COMMON HC
      WHERE HC.GROUP_CODE          IN('ALLOWANCE', 'DEDUCTION')
        AND HC.CODE_NAME           LIKE W_CODE_NAME || '%'
        AND HC.SOB_ID              = W_SOB_ID
        AND HC.ORG_ID              = W_ORG_ID
        AND HC.ENABLED_FLAG        = DECODE(W_ENABLED_FLAG_YN, 'Y', 'Y', HC.ENABLED_FLAG)
        AND HC.EFFECTIVE_DATE_FR   <= NVL(V_STD_DATE, HC.EFFECTIVE_DATE_FR)
        AND (HC.EFFECTIVE_DATE_TO IS NULL OR HC.EFFECTIVE_DATE_TO >= NVL(V_STD_DATE, HC.EFFECTIVE_DATE_TO))
      ORDER BY HC.CODE, HC.SORT_NUM
      ;
  END LU_PAY_ALLOWANCE;
  
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

-----------------------------------------------------------------------------------------
-- FUNCTION : 처리 유형별 소숫점 처리.
  FUNCTION DECIMAL_F
            ( W_SOB_ID             IN HRM_COMMON.SOB_ID%TYPE
            , W_ORG_ID             IN HRM_COMMON.ORG_ID%TYPE
            , W_NUMBER             IN NUMBER
            , W_CAL_TYPE           IN VARCHAR2 DEFAULT NULL
            ) RETURN VARCHAR2
  AS
    V_STRING                       VARCHAR2(500);
    V_CAL_FUNCTION                 VARCHAR2(20);
    V_DIGIT_VALUE                  NUMBER;
    V_RETURN_VALUE                 NUMBER;
  BEGIN
    BEGIN
      SELECT DC.CAL_FUNCTION
           , DC.DIGIT_VALUE
        INTO V_CAL_FUNCTION
           , V_DIGIT_VALUE
        FROM HRM_DECIMAL_CAL_V DC
      WHERE DC.CAL_TYPE                 = W_CAL_TYPE
        AND DC.SOB_ID                   = W_SOB_ID
        AND DC.ORG_ID                   = W_ORG_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_CAL_FUNCTION := 'TRUNC';
      V_DIGIT_VALUE := 0;
    END;
    BEGIN
      V_STRING := 'SELECT CASE
                            WHEN ''' || V_CAL_FUNCTION || ''' = ''CEIL'' THEN CEIL(' || W_NUMBER || ')
                            WHEN ''' || V_CAL_FUNCTION || ''' IN (''TRUNC'', ''ROUND'') THEN '|| V_CAL_FUNCTION || '(' || W_NUMBER || ', ' || V_DIGIT_VALUE || ')
                            ELSE ' || W_NUMBER || '
                          END AS RETURN_VALUE
                    FROM DUAL ';
--      DBMS_OUTPUT.put_line(V_STRING);
      EXECUTE IMMEDIATE V_STRING
      INTO V_RETURN_VALUE;
    EXCEPTION WHEN OTHERS THEN
      V_RETURN_VALUE := 0;
    END;
    RETURN V_RETURN_VALUE;
  END DECIMAL_F;

-- 세율 반환.
  FUNCTION TAX_RATE_F
            ( W_TAX_CODE           IN HRM_COMMON.CODE%TYPE
            , W_SOB_ID             IN HRM_COMMON.SOB_ID%TYPE
            , W_ORG_ID             IN HRM_COMMON.ORG_ID%TYPE
            ) RETURN NUMBER
  AS
    V_TAX_RATE       NUMBER := 0;
  BEGIN
    BEGIN
      SELECT NVL(TO_NUMBER(HC.VALUE1), 0) AS TAX_RATE
        INTO V_TAX_RATE
        FROM HRM_COMMON HC
       WHERE HC.GROUP_CODE          = 'TAX_RATE'
         AND HC.CODE                = W_TAX_CODE
         AND HC.SOB_ID              = W_SOB_ID
         AND HC.ORG_ID              = W_ORG_ID
       ;
    EXCEPTION WHEN OTHERS THEN
      V_TAX_RATE := 0;
    END;
    RETURN V_TAX_RATE;
  END TAX_RATE_F;

-- FUNCTION - WEEK.
  FUNCTION WEEK_F
            ( W_WEEK_CODE          IN HRM_COMMON.CODE%TYPE
            , W_SOB_ID             IN HRM_COMMON.SOB_ID%TYPE
            , W_ORG_ID             IN HRM_COMMON.ORG_ID%TYPE
            ) RETURN VARCHAR2
  AS
   V_RETURN_VALUE                 HRM_COMMON.CODE%TYPE;

 BEGIN
   BEGIN
     SELECT HC.CODE_NAME WEEK
       INTO V_RETURN_VALUE
       FROM HRM_COMMON HC
      WHERE HC.GROUP_CODE         = 'WEEK'
        AND HC.CODE               = W_WEEK_CODE
        AND HC.SOB_ID             = W_SOB_ID
       AND HC.ORG_ID             = W_ORG_ID
     ;
    EXCEPTION WHEN OTHERS THEN
      V_RETURN_VALUE := '-';
     END;
    RETURN V_RETURN_VALUE;
 END WEEK_F;

-----------------------------------------------------------------------------------------
-- 공통코드 ftp 정보.
  PROCEDURE FTP_INFO_P
            ( W_FTP_INFO_CODE      IN VARCHAR2
            , W_SOB_ID             IN NUMBER
            , W_ORG_ID             IN NUMBER
            , O_FTP_IP             OUT VARCHAR2
            , O_FTP_PORT           OUT VARCHAR2
            , O_FTP_USER_ID        OUT VARCHAR2
            , O_FTP_PASSWORD       OUT VARCHAR2
            , O_FTP_SOURCEPATH     OUT VARCHAR2
            , O_CLIENT_TARGETPATH  OUT VARCHAR2
            , O_FILE_EXTENSION     OUT VARCHAR2
            )
  AS
  BEGIN
    BEGIN
      SELECT HC.VALUE1 AS FTP_ID
           , HC.VALUE2 AS FTP_PORT
           , HC.VALUE3 AS USER_ID
           , HC.VALUE4 AS PASSWORD
           , HC.VALUE5 AS SOURCEPATH
           , HC.VALUE6 AS TARGETPATH
           , HC.VALUE7 AS FILE_EXTENSION
        INTO O_FTP_IP
           , O_FTP_PORT
           , O_FTP_USER_ID
           , O_FTP_PASSWORD
           , O_FTP_SOURCEPATH
           , O_CLIENT_TARGETPATH
           , O_FILE_EXTENSION
        FROM HRM_COMMON HC
      WHERE HC.GROUP_CODE          = 'FTP_INFO'
        AND HC.CODE                = W_FTP_INFO_CODE
        AND HC.SOB_ID              = W_SOB_ID
        AND HC.ORG_ID              = W_ORG_ID
        AND HC.ENABLED_FLAG        = 'Y'
        AND HC.EFFECTIVE_DATE_FR   <= TRUNC(SYSDATE)
        AND (HC.EFFECTIVE_DATE_TO  >= TRUNC(SYSDATE) OR HC.EFFECTIVE_DATE_TO IS NULL)
      ;
    EXCEPTION WHEN OTHERS THEN
      O_FTP_IP := NULL;
      O_FTP_PORT := NULL;
      O_FTP_USER_ID := NULL;
      O_FTP_PASSWORD := NULL;
      O_FTP_SOURCEPATH := NULL;
      O_CLIENT_TARGETPATH := NULL;
      O_FILE_EXTENSION := NULL;
    END;

  END FTP_INFO_P;

-----------------------------------------------------------------------------------------
-- 인쇄시 필요한 기본 사항 리턴.
  --> 날짜.
  PROCEDURE PRINTED_VALUE1
            ( P_CORP_ID           IN NUMBER
            , P_DATE_FR           IN DATE
            , P_DATE_TO           IN DATE
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , P_CONNECT_PERSON_ID IN NUMBER
            , O_CORP_NAME         OUT VARCHAR2
            , O_PERIOD_DATE       OUT VARCHAR2
            , O_PRINTED_DATE      OUT VARCHAR2
            , O_PRINTED_BY        OUT VARCHAR2
            )
  AS
  BEGIN
    BEGIN
      SELECT '[' || CM.CORP_NAME || ']' AS CORP_NAME
        INTO O_CORP_NAME
        FROM HRM_CORP_MASTER CM
      WHERE CM.CORP_ID        = P_CORP_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      O_CORP_NAME := NULL;
    END;
    
    IF P_DATE_FR IS NOT NULL AND P_DATE_TO IS NOT NULL THEN
      O_PERIOD_DATE := '(' || TO_CHAR(P_DATE_FR, 'YYYY-MM-DD') || ' ~ ' || TO_CHAR(P_DATE_TO, 'YYYY-MM-DD') || ')';  
    ELSIF P_DATE_FR IS NOT NULL THEN
      O_PERIOD_DATE := '(' || TO_CHAR(P_DATE_FR, 'YYYY-MM-DD') || ')';
    ELSIF P_DATE_TO IS NOT NULL THEN
      O_PERIOD_DATE := '(' || TO_CHAR(P_DATE_TO, 'YYYY-MM-DD') || ')';
    END IF;
    
    O_PRINTED_DATE := '[' || TO_CHAR(GET_LOCAL_DATE(P_SOB_ID), 'YYYY-MM-DD HH24:MI:SS') || ']';
    
    O_PRINTED_BY := HRM_PERSON_MASTER_G.NAME_F(P_CONNECT_PERSON_ID);
    
  END PRINTED_VALUE1;

  --> 년월.
  PROCEDURE PRINTED_VALUE2
            ( P_CORP_ID           IN NUMBER
            , P_PERIOD_FR         IN VARCHAR2
            , P_PERIOD_TO         IN VARCHAR2
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , P_CONNECT_PERSON_ID IN NUMBER
            , O_CORP_NAME         OUT VARCHAR2
            , O_PERIOD_NAME       OUT VARCHAR2
            , O_PRINTED_DATE      OUT VARCHAR2
            , O_PRINTED_BY        OUT VARCHAR2
            )
  AS
  BEGIN
    BEGIN
      SELECT '[' || CM.CORP_NAME || ']' AS CORP_NAME
        INTO O_CORP_NAME
        FROM HRM_CORP_MASTER CM
      WHERE CM.CORP_ID        = P_CORP_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      O_CORP_NAME := NULL;
    END;
    
    IF P_PERIOD_FR IS NOT NULL AND P_PERIOD_TO IS NOT NULL THEN
      O_PERIOD_NAME := '(' || P_PERIOD_FR || ' ~ ' || P_PERIOD_TO || ')';  
    ELSIF P_PERIOD_FR IS NOT NULL THEN
      O_PERIOD_NAME := '(' || P_PERIOD_FR || ')';
    ELSIF P_PERIOD_TO IS NOT NULL THEN
      O_PERIOD_NAME := '(' || P_PERIOD_TO || ')';
    END IF;
    
    O_PRINTED_DATE := '[' || TO_CHAR(GET_LOCAL_DATE(P_SOB_ID), 'YYYY-MM-DD HH24:MI:SS') || ']';
    
    O_PRINTED_BY := HRM_PERSON_MASTER_G.NAME_F(P_CONNECT_PERSON_ID);
  END PRINTED_VALUE2;
  
END HRM_COMMON_G; 
/
