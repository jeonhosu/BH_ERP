CREATE OR REPLACE PACKAGE FI_COMMON_G
AS
-----------------------------------------------------------------------------------------
-- HEADER DATA 조회.
  PROCEDURE COMMON_SELECT_H
            ( P_CURSOR           OUT TYPES.TCURSOR
            , W_CODE             IN FI_COMMON.CODE%TYPE
            , W_CODE_NAME        IN FI_COMMON.CODE_NAME%TYPE
            , W_SOB_ID           IN FI_COMMON.SOB_ID%TYPE
            , W_ORG_ID           IN FI_COMMON.ORG_ID%TYPE
            );

-- HEADER INSERT.
  PROCEDURE COMMON_INSERT_H
            ( P_COMMON_ID        OUT FI_COMMON.COMMON_ID%TYPE
            , P_CODE             IN FI_COMMON.CODE%TYPE
            , P_CODE_NAME        IN FI_COMMON.CODE_NAME%TYPE
            , P_CODE_LENGHT      IN FI_COMMON.CODE_LENGTH%TYPE
            , P_VALUE1           IN FI_COMMON.VALUE1%TYPE
            , P_VALUE2           IN FI_COMMON.VALUE2%TYPE
            , P_VALUE3           IN FI_COMMON.VALUE3%TYPE
            , P_VALUE4           IN FI_COMMON.VALUE4%TYPE
            , P_VALUE5           IN FI_COMMON.VALUE5%TYPE
            , P_VALUE6           IN FI_COMMON.VALUE6%TYPE
            , P_VALUE7           IN FI_COMMON.VALUE7%TYPE
            , P_VALUE8           IN FI_COMMON.VALUE8%TYPE
            , P_VALUE9           IN FI_COMMON.VALUE9%TYPE
            , P_VALUE10          IN FI_COMMON.VALUE10%TYPE
            , P_SOB_ID           IN FI_COMMON.SOB_ID%TYPE
            , P_ORG_ID           IN FI_COMMON.ORG_ID%TYPE
            , P_USER_ID          IN FI_COMMON.CREATED_BY%TYPE
            );

-- HEADER UPDATE.
  PROCEDURE COMMON_UPDATE_H
            ( W_COMMON_ID        IN FI_COMMON.COMMON_ID%TYPE
            , P_CODE_NAME        IN FI_COMMON.CODE_NAME%TYPE
            , P_CODE_LENGHT      IN FI_COMMON.CODE_LENGTH%TYPE
            , P_VALUE1           IN FI_COMMON.VALUE1%TYPE
            , P_VALUE2           IN FI_COMMON.VALUE2%TYPE
            , P_VALUE3           IN FI_COMMON.VALUE3%TYPE
            , P_VALUE4           IN FI_COMMON.VALUE4%TYPE
            , P_VALUE5           IN FI_COMMON.VALUE5%TYPE
            , P_VALUE6           IN FI_COMMON.VALUE6%TYPE
            , P_VALUE7           IN FI_COMMON.VALUE7%TYPE
            , P_VALUE8           IN FI_COMMON.VALUE8%TYPE
            , P_VALUE9           IN FI_COMMON.VALUE9%TYPE
            , P_VALUE10          IN FI_COMMON.VALUE10%TYPE
            , P_USER_ID          IN FI_COMMON.CREATED_BY%TYPE
            );

-----------------------------------------------------------------------------------------
-- LINE DATA 조회.
  PROCEDURE COMMON_SELECT_L
            ( P_CURSOR1          OUT TYPES.TCURSOR1
            , W_GROUP_CODE       IN FI_COMMON.GROUP_CODE%TYPE
            , W_SOB_ID           IN FI_COMMON.SOB_ID%TYPE
            , W_ORG_ID           IN FI_COMMON.ORG_ID%TYPE
            );

-- LINE INSERT.
  PROCEDURE COMMON_INSERT_L
            ( P_COMMON_ID          OUT FI_COMMON.COMMON_ID%TYPE
            , P_GROUP_CODE         IN FI_COMMON.GROUP_CODE%TYPE
            , P_CODE               IN FI_COMMON.CODE%TYPE
            , P_CODE_NAME          IN FI_COMMON.CODE_NAME%TYPE
            , P_VALUE1             IN FI_COMMON.VALUE1%TYPE
            , P_VALUE2             IN FI_COMMON.VALUE2%TYPE
            , P_VALUE3             IN FI_COMMON.VALUE3%TYPE
            , P_VALUE4             IN FI_COMMON.VALUE4%TYPE
            , P_VALUE5             IN FI_COMMON.VALUE5%TYPE
            , P_VALUE6             IN FI_COMMON.VALUE6%TYPE
            , P_VALUE7             IN FI_COMMON.VALUE7%TYPE
            , P_VALUE8             IN FI_COMMON.VALUE8%TYPE
            , P_VALUE9             IN FI_COMMON.VALUE9%TYPE
            , P_VALUE10            IN FI_COMMON.VALUE10%TYPE
            , P_DEFAULT_FLAG       IN FI_COMMON.DEFAULT_FLAG%TYPE
            , P_SORT_NUM           IN FI_COMMON.SORT_NUM%TYPE
            , P_DESCRIPTION        IN FI_COMMON.DESCRIPTION%TYPE
            , P_ENABLED_FLAG       IN FI_COMMON.ENABLED_FLAG%TYPE
            , P_EFFECTIVE_DATE_FR  IN FI_COMMON.EFFECTIVE_DATE_FR%TYPE
            , P_EFFECTIVE_DATE_TO  IN FI_COMMON.EFFECTIVE_DATE_TO%TYPE
            , P_SOB_ID             IN FI_COMMON.SOB_ID%TYPE
            , P_ORG_ID             IN FI_COMMON.ORG_ID%TYPE
            , P_USER_ID            IN FI_COMMON.CREATED_BY%TYPE
            );

-- LINE UPDATE.
  PROCEDURE COMMON_UPDATE_L
            ( W_COMMON_ID          IN FI_COMMON.COMMON_ID%TYPE
            , P_CODE_NAME          IN FI_COMMON.CODE_NAME%TYPE
            , P_VALUE1             IN FI_COMMON.VALUE1%TYPE
            , P_VALUE2             IN FI_COMMON.VALUE2%TYPE
            , P_VALUE3             IN FI_COMMON.VALUE3%TYPE
            , P_VALUE4             IN FI_COMMON.VALUE4%TYPE
            , P_VALUE5             IN FI_COMMON.VALUE5%TYPE
            , P_VALUE6             IN FI_COMMON.VALUE6%TYPE
            , P_VALUE7             IN FI_COMMON.VALUE7%TYPE
            , P_VALUE8             IN FI_COMMON.VALUE8%TYPE
            , P_VALUE9             IN FI_COMMON.VALUE9%TYPE
            , P_VALUE10            IN FI_COMMON.VALUE10%TYPE
            , P_DEFAULT_FLAG       IN FI_COMMON.DEFAULT_FLAG%TYPE
            , P_SORT_NUM           IN FI_COMMON.SORT_NUM%TYPE
            , P_DESCRIPTION        IN FI_COMMON.DESCRIPTION%TYPE
            , P_ENABLED_FLAG       IN FI_COMMON.ENABLED_FLAG%TYPE
            , P_EFFECTIVE_DATE_FR  IN FI_COMMON.EFFECTIVE_DATE_FR%TYPE
            , P_EFFECTIVE_DATE_TO  IN FI_COMMON.EFFECTIVE_DATE_TO%TYPE
            , P_USER_ID            IN FI_COMMON.CREATED_BY%TYPE
            );

-----------------------------------------------------------------------------------------
-- 공통코드 명칭 리턴 FUNCTION.
  FUNCTION ID_NAME_F
            ( W_COMMON_ID          IN FI_COMMON.COMMON_ID%TYPE
            ) RETURN VARCHAR2;

  PROCEDURE ID_NAME
            ( W_COMMON_ID          IN FI_COMMON.COMMON_ID%TYPE
            , O_RETURN_VALUE       OUT VARCHAR2
            );

  FUNCTION CODE_NAME_F
           ( W_GROUP_CODE          IN FI_COMMON.GROUP_CODE%TYPE
           , W_CODE                IN FI_COMMON.CODE%TYPE
           , W_SOB_ID              IN FI_COMMON.SOB_ID%TYPE
           , W_ORG_ID              IN FI_COMMON.ORG_ID%TYPE DEFAULT NULL
           ) RETURN VARCHAR2;

  PROCEDURE CODE_NAME
            ( W_GROUP_CODE          IN FI_COMMON.GROUP_CODE%TYPE
            , W_CODE                IN FI_COMMON.CODE%TYPE
            , W_SOB_ID              IN FI_COMMON.SOB_ID%TYPE
            , W_ORG_ID              IN FI_COMMON.ORG_ID%TYPE DEFAULT NULL
            , O_RETURN_VALUE        OUT VARCHAR2
            );

-- 공통코드 VALUE 리턴 FUNCTION.
  FUNCTION ID_VALUE_F
            ( W_COMMON_ID          IN FI_COMMON.COMMON_ID%TYPE
            , W_VALUE_ID           IN FI_COMMON.VALUE1%TYPE
            ) RETURN VARCHAR2;

  PROCEDURE ID_VALUE
            ( W_COMMON_ID          IN FI_COMMON.COMMON_ID%TYPE
            , W_VALUE_ID           IN FI_COMMON.VALUE1%TYPE
            , O_RETURN_VALUE       OUT VARCHAR2
            );

  FUNCTION CODE_VALUE_F
           ( W_GROUP_CODE          IN FI_COMMON.GROUP_CODE%TYPE
           , W_CODE                IN FI_COMMON.CODE%TYPE
           , W_VALUE_ID            IN FI_COMMON.VALUE1%TYPE
           , W_SOB_ID              IN FI_COMMON.SOB_ID%TYPE
           , W_ORG_ID              IN FI_COMMON.ORG_ID%TYPE DEFAULT NULL
           ) RETURN VARCHAR2;

  PROCEDURE CODE_VALUE
            ( W_GROUP_CODE          IN FI_COMMON.GROUP_CODE%TYPE
            , W_CODE                IN FI_COMMON.CODE%TYPE
            , W_VALUE_ID            IN FI_COMMON.VALUE1%TYPE
            , W_SOB_ID              IN FI_COMMON.SOB_ID%TYPE
            , W_ORG_ID              IN FI_COMMON.ORG_ID%TYPE DEFAULT NULL
            , O_RETURN_VALUE        OUT VARCHAR2
            );

-- ID값 코드값 반환.
  FUNCTION GET_ID_F
            ( W_GROUP_CODE          IN FI_COMMON.GROUP_CODE%TYPE
            , W_WHERE               IN VARCHAR2
            , W_SOB_ID              IN FI_COMMON.SOB_ID%TYPE
            , W_ORG_ID              IN FI_COMMON.ORG_ID%TYPE DEFAULT NULL
            ) RETURN NUMBER;

-- CODE값 반환.
  FUNCTION GET_CODE_F
            ( W_COMMON_ID           IN FI_COMMON.COMMON_ID%TYPE
            , W_SOB_ID              IN FI_COMMON.SOB_ID%TYPE
            , W_ORG_ID              IN FI_COMMON.ORG_ID%TYPE DEFAULT NULL
            ) RETURN VARCHAR2;

-----------------------------------------------------------------------------------------
-- 공통코드 기본값 리턴 - GROUP CODE..
  PROCEDURE DEFAULT_VALUE_GROUP
            ( W_GROUP_CODE          IN FI_COMMON.GROUP_CODE%TYPE
            , W_SOB_ID              IN FI_COMMON.SOB_ID%TYPE
            , W_ORG_ID              IN FI_COMMON.ORG_ID%TYPE
            , O_ID                  OUT FI_COMMON.COMMON_ID%TYPE
            , O_CODE                OUT FI_COMMON.CODE%TYPE
            , O_CODE_NAME           OUT FI_COMMON.CODE_NAME%TYPE
            );

-- 공통코드 기본값 리턴 - VALUE1을 조건 검색하여 : GROUP CODE..
  PROCEDURE DEFAULT_VALUE_GROUP_W
            ( W_GROUP_CODE         IN FI_COMMON.GROUP_CODE%TYPE
            , W_WHERE              IN VARCHAR2
            , W_SOB_ID             IN FI_COMMON.SOB_ID%TYPE
            , W_ORG_ID             IN FI_COMMON.ORG_ID%TYPE
            , O_ID                 OUT FI_COMMON.COMMON_ID%TYPE
            , O_CODE               OUT FI_COMMON.CODE%TYPE
            , O_CODE_NAME          OUT FI_COMMON.CODE_NAME%TYPE
            );

-- 공통코드 기본값 리턴 - GROUP CODE value2..
  PROCEDURE DEFAULT_VALUE2_GROUP
            ( W_GROUP_CODE          IN FI_COMMON.GROUP_CODE%TYPE
            , W_SOB_ID              IN FI_COMMON.SOB_ID%TYPE
            , W_ORG_ID              IN FI_COMMON.ORG_ID%TYPE
            , O_ID                  OUT FI_COMMON.COMMON_ID%TYPE
            , O_CODE                OUT FI_COMMON.CODE%TYPE
            , O_CODE_NAME           OUT FI_COMMON.CODE_NAME%TYPE
            , O_VALUE1              OUT FI_COMMON.VALUE1%TYPE
            , O_VALUE2              OUT FI_COMMON.VALUE2%TYPE
            );

-- 공통코드 기본값 리턴 - VALUE2까지 조건 검색하여 : GROUP CODE..
  PROCEDURE DEFAULT_VALUE2_W
            ( W_WHERE              IN VARCHAR2
            , W_SOB_ID             IN FI_COMMON.SOB_ID%TYPE
            , W_ORG_ID             IN FI_COMMON.ORG_ID%TYPE
            , O_ID                 OUT FI_COMMON.COMMON_ID%TYPE
            , O_CODE               OUT FI_COMMON.CODE%TYPE
            , O_CODE_NAME          OUT FI_COMMON.CODE_NAME%TYPE
            , O_VALUE1              OUT FI_COMMON.VALUE1%TYPE
            , O_VALUE2              OUT FI_COMMON.VALUE2%TYPE
            );

-----------------------------------------------------------------------------------------
-- 공통코드 조회 LOOKUP - GROUP CODE..
  PROCEDURE LU_SELECT_GROUP
            ( P_CURSOR3            OUT TYPES.TCURSOR3
            , W_GROUP_CODE         IN FI_COMMON.GROUP_CODE%TYPE
            , W_CODE_NAME          IN FI_COMMON.CODE_NAME%TYPE
            , W_SOB_ID             IN FI_COMMON.SOB_ID%TYPE
            , W_ORG_ID             IN FI_COMMON.ORG_ID%TYPE
            , W_ENABLED_YN         IN FI_COMMON.ENABLED_FLAG%TYPE DEFAULT 'Y'
            );

-- 공통코드 WHERE 조건으로 조회 LOOKUP.
  PROCEDURE LU_SELECT_GROUP_W
            ( P_CURSOR3            OUT TYPES.TCURSOR3
            , W_GROUP_CODE         IN FI_COMMON.GROUP_CODE%TYPE
            , W_WHERE              IN VARCHAR2
            , W_SOB_ID             IN FI_COMMON.SOB_ID%TYPE
            , W_ORG_ID             IN FI_COMMON.ORG_ID%TYPE
            , W_ENABLED_YN         IN FI_COMMON.ENABLED_FLAG%TYPE DEFAULT 'Y'
            );

-- LOOKUP COST CENTER.
  PROCEDURE LU_COST_CENTER
            ( P_CURSOR3            OUT TYPES.TCURSOR3
            , W_SOB_ID             IN CST_COST_CENTER.SOB_ID%TYPE
            , W_ORG_ID             IN CST_COST_CENTER.ORG_ID%TYPE
            , W_ENABLED_YN         IN CST_COST_CENTER.ENABLED_FLAG%TYPE DEFAULT 'Y'
            );

-- 원가코드 조회 FUNCTION.
  FUNCTION COST_CENTER_CODE_F
            ( W_COST_CENTER_ID     IN CST_COST_CENTER.COST_CENTER_ID%TYPE
            ) RETURN VARCHAR2;

-- 원가명 조회 FUNCTION.
  FUNCTION COST_CENTER_DESC_F
            ( W_COST_CENTER_ID     IN CST_COST_CENTER.COST_CENTER_ID%TYPE
            ) RETURN VARCHAR2;

--------------------------------------------
-- Main Org ID Return                     --
--------------------------------------------
  FUNCTION OPERATING_ORG_F
           ( W_SOB_ID             IN NUMBER
           ) RETURN NUMBER;

--------------------------------------------
-- SUPPLIER/CUSTOMER 조회                 --
--------------------------------------------
  PROCEDURE LU_SUPP_CUST
            ( P_CURSOR3           OUT TYPES.TCURSOR3
            , W_SOB_ID            IN NUMBER
            , W_SUPP_CUST_TYPE    IN VARCHAR2
            , W_ENABLED_YN        IN VARCHAR2 DEFAULT 'Y'
            );

  FUNCTION  SUPP_CUST_ID_NAME_F
            ( W_SUPP_CUST_ID      IN NUMBER
            ) RETURN VARCHAR2;

  FUNCTION  SUPP_CUST_CODE_NAME_F
            ( W_SUPP_CUST_CODE    IN VARCHAR2
            , W_SOB_ID            IN NUMBER
            ) RETURN VARCHAR2;
            
  FUNCTION  SUPP_CUST_TAX_NAME_F
            ( W_SOB_ID            IN NUMBER
            , W_TAX_REG_NO        IN VARCHAR2
            ) RETURN VARCHAR2;

--------------------------------------------
-- LOOKUP TYPE 조회                       --
--------------------------------------------
  FUNCTION GET_LOOKUP_ENTRY_ID_F
           ( W_LOOKUP_ENTRY_ID    IN NUMBER
           ) RETURN VARCHAR2;

  FUNCTION GET_LOOKUP_ENTRY_TYPE_F
           ( W_SOB_ID             IN NUMBER
           , W_LOOKUP_MODULE      IN VARCHAR2
           , W_LOOKUP_TYPE        IN VARCHAR2
           ) RETURN VARCHAR2;

  PROCEDURE LU_LOOKUP_ENTRY
            ( P_CURSOR3           OUT TYPES.TCURSOR3
            , W_LOOKUP_MODULE     IN VARCHAR2
            , W_LOOKUP_TYPE       IN VARCHAR2
            , W_SOB_ID            IN NUMBER
            , W_ORG_ID            IN NUMBER
            , W_ENABLED_YN        IN VARCHAR2 DEFAULT 'Y'
            );

--------------------------------------------
-- CURRENCY : 통화                        --
--------------------------------------------
  PROCEDURE LU_CURRENCY
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_SOB_ID            IN NUMBER
            , W_ORG_ID            IN NUMBER
            , W_ENABLED_YN        IN VARCHAR2 DEFAULT 'Y'
            );

-- 외화 금액을 입력 통화로 환산.
  FUNCTION  CONVERSION_BASE_AMOUNT_F
            ( W_BASE_CURRENCY_CODE  IN VARCHAR2
            , W_SOB_ID              IN NUMBER
            , W_CONVERSION_AMOUNT   IN NUMBER
            ) RETURN NUMBER;

  PROCEDURE CONVERSION_BASE_AMOUNT_P
            ( W_BASE_CURRENCY_CODE  IN VARCHAR2
            , W_SOB_ID              IN NUMBER
            , W_CONVERSION_AMOUNT   IN NUMBER
            , O_BASE_AMOUNT         OUT NUMBER
            );

-----------------------------------------------------------------------
-- 접속자에 대한 성명/사원id/사원번호/부서코드, 부서명, 부서id 리턴. --
-----------------------------------------------------------------------
  PROCEDURE USER_INFO_P
            ( W_PERSON_ID           IN HRM_PERSON_MASTER.PERSON_ID%TYPE
            , W_SOB_ID              IN NUMBER
            , O_PERSON_NUM          OUT HRM_PERSON_MASTER.PERSON_NUM%TYPE
            , O_PERSON_NAME         OUT HRM_PERSON_MASTER.NAME%TYPE
            , O_DEPT_ID             OUT FI_DEPT_MASTER.DEPT_ID%TYPE
            , O_DEPT_CODE           OUT FI_DEPT_MASTER.DEPT_CODE%TYPE
            , O_DEPT_NAME           OUT FI_DEPT_MASTER.DEPT_NAME%TYPE
            , O_COST_CENTER_ID      OUT CST_COST_CENTER.COST_CENTER_ID%TYPE
            , O_COST_CENTER_CODE    OUT CST_COST_CENTER.COST_CENTER_CODE%TYPE
            , O_COST_CENTER_DESC    OUT CST_COST_CENTER.COST_CENTER_DESC%TYPE
            );

END FI_COMMON_G; 

 
/
CREATE OR REPLACE PACKAGE BODY FI_COMMON_G
AS
/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : FI_COMMON_G
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
						, W_CODE             IN FI_COMMON.CODE%TYPE
						, W_CODE_NAME        IN FI_COMMON.CODE_NAME%TYPE
						, W_SOB_ID           IN FI_COMMON.SOB_ID%TYPE
						, W_ORG_ID           IN FI_COMMON.ORG_ID%TYPE
						)
  AS
  BEGIN
		OPEN P_CURSOR FOR
			SELECT FI.COMMON_ID
					, FI.CODE
					, FI.CODE_NAME
					, FI.CODE_LENGTH
					, FI.VALUE1
					, FI.VALUE2
					, FI.VALUE3
					, FI.VALUE4
					, FI.VALUE5
					, FI.VALUE6
					, FI.VALUE7
          , FI.VALUE8
					, FI.VALUE9
					, FI.VALUE10
			FROM FI_COMMON FI
			WHERE FI.GROUP_CODE                               = '-'
				AND FI.CODE                                     LIKE W_CODE || '%'
				AND FI.CODE_NAME                                LIKE W_CODE_NAME || '%'
				AND FI.SOB_ID                                   = W_SOB_ID
			ORDER BY FI.SORT_NUM, FI.CODE
			;

  END COMMON_SELECT_H;

-- HEADER INSERT.
  PROCEDURE COMMON_INSERT_H
	          ( P_COMMON_ID        OUT FI_COMMON.COMMON_ID%TYPE
            , P_CODE             IN FI_COMMON.CODE%TYPE
						, P_CODE_NAME        IN FI_COMMON.CODE_NAME%TYPE
						, P_CODE_LENGHT      IN FI_COMMON.CODE_LENGTH%TYPE
						, P_VALUE1           IN FI_COMMON.VALUE1%TYPE
						, P_VALUE2           IN FI_COMMON.VALUE2%TYPE
						, P_VALUE3           IN FI_COMMON.VALUE3%TYPE
						, P_VALUE4           IN FI_COMMON.VALUE4%TYPE
						, P_VALUE5           IN FI_COMMON.VALUE5%TYPE
						, P_VALUE6           IN FI_COMMON.VALUE6%TYPE
						, P_VALUE7           IN FI_COMMON.VALUE7%TYPE
            , P_VALUE8           IN FI_COMMON.VALUE8%TYPE
            , P_VALUE9           IN FI_COMMON.VALUE9%TYPE
            , P_VALUE10          IN FI_COMMON.VALUE10%TYPE
						, P_SOB_ID           IN FI_COMMON.SOB_ID%TYPE
						, P_ORG_ID           IN FI_COMMON.ORG_ID%TYPE
						, P_USER_ID          IN FI_COMMON.CREATED_BY%TYPE
						)
  AS
	  D_SYSDATE                    DATE;

  BEGIN
	  D_SYSDATE := GET_LOCAL_DATE(P_SOB_ID);
		SELECT FI_COMMON_S1.NEXTVAL
      INTO P_COMMON_ID
      FROM DUAL;

		INSERT INTO FI_COMMON
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
	          ( W_COMMON_ID        IN FI_COMMON.COMMON_ID%TYPE
						, P_CODE_NAME        IN FI_COMMON.CODE_NAME%TYPE
						, P_CODE_LENGHT      IN FI_COMMON.CODE_LENGTH%TYPE
						, P_VALUE1           IN FI_COMMON.VALUE1%TYPE
						, P_VALUE2           IN FI_COMMON.VALUE2%TYPE
						, P_VALUE3           IN FI_COMMON.VALUE3%TYPE
            , P_VALUE4           IN FI_COMMON.VALUE4%TYPE
            , P_VALUE5           IN FI_COMMON.VALUE5%TYPE
            , P_VALUE6           IN FI_COMMON.VALUE6%TYPE
            , P_VALUE7           IN FI_COMMON.VALUE7%TYPE
            , P_VALUE8           IN FI_COMMON.VALUE8%TYPE
            , P_VALUE9           IN FI_COMMON.VALUE9%TYPE
            , P_VALUE10          IN FI_COMMON.VALUE10%TYPE
            , P_USER_ID          IN FI_COMMON.CREATED_BY%TYPE
            )
  AS
  BEGIN
    UPDATE FI_COMMON HC
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
            , W_GROUP_CODE       IN FI_COMMON.GROUP_CODE%TYPE
            , W_SOB_ID           IN FI_COMMON.SOB_ID%TYPE
            , W_ORG_ID           IN FI_COMMON.ORG_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR1 FOR
      SELECT FI.COMMON_ID
          , FI.CODE
          , FI.CODE_NAME
          , FI.VALUE1
          , FI.VALUE2
          , FI.VALUE3
          , FI.VALUE4
          , FI.VALUE5
          , FI.VALUE6
          , FI.VALUE7
          , FI.VALUE8
          , FI.VALUE9
          , FI.VALUE10
          , FI.DEFAULT_FLAG
          , FI.SORT_NUM
          , FI.DESCRIPTION
          , FI.ENABLED_FLAG
          , FI.EFFECTIVE_DATE_FR
          , FI.EFFECTIVE_DATE_TO
          , FI.GROUP_CODE
      FROM FI_COMMON FI
      WHERE FI.GROUP_CODE            = W_GROUP_CODE
        AND FI.SOB_ID                = W_SOB_ID
      ORDER BY FI.SORT_NUM, FI.CODE
      ;

  END COMMON_SELECT_L;

-- LINE INSERT.
  PROCEDURE COMMON_INSERT_L
            ( P_COMMON_ID          OUT FI_COMMON.COMMON_ID%TYPE
            , P_GROUP_CODE         IN FI_COMMON.GROUP_CODE%TYPE
            , P_CODE               IN FI_COMMON.CODE%TYPE
            , P_CODE_NAME          IN FI_COMMON.CODE_NAME%TYPE
            , P_VALUE1             IN FI_COMMON.VALUE1%TYPE
            , P_VALUE2             IN FI_COMMON.VALUE2%TYPE
            , P_VALUE3             IN FI_COMMON.VALUE3%TYPE
            , P_VALUE4             IN FI_COMMON.VALUE4%TYPE
            , P_VALUE5             IN FI_COMMON.VALUE5%TYPE
            , P_VALUE6             IN FI_COMMON.VALUE6%TYPE
            , P_VALUE7             IN FI_COMMON.VALUE7%TYPE
            , P_VALUE8             IN FI_COMMON.VALUE8%TYPE
            , P_VALUE9             IN FI_COMMON.VALUE9%TYPE
            , P_VALUE10            IN FI_COMMON.VALUE10%TYPE
            , P_DEFAULT_FLAG       IN FI_COMMON.DEFAULT_FLAG%TYPE
            , P_SORT_NUM           IN FI_COMMON.SORT_NUM%TYPE
            , P_DESCRIPTION        IN FI_COMMON.DESCRIPTION%TYPE
            , P_ENABLED_FLAG       IN FI_COMMON.ENABLED_FLAG%TYPE
            , P_EFFECTIVE_DATE_FR  IN FI_COMMON.EFFECTIVE_DATE_FR%TYPE
            , P_EFFECTIVE_DATE_TO  IN FI_COMMON.EFFECTIVE_DATE_TO%TYPE
            , P_SOB_ID             IN FI_COMMON.SOB_ID%TYPE
            , P_ORG_ID             IN FI_COMMON.ORG_ID%TYPE
            , P_USER_ID            IN FI_COMMON.CREATED_BY%TYPE
            )
  AS
    D_SYSDATE                      DATE;

  BEGIN
    D_SYSDATE := GET_LOCAL_DATE(P_SOB_ID);
    SELECT FI_COMMON_S1.NEXTVAL
      INTO P_COMMON_ID
      FROM DUAL;

    INSERT INTO FI_COMMON
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
            ( W_COMMON_ID          IN FI_COMMON.COMMON_ID%TYPE
            , P_CODE_NAME          IN FI_COMMON.CODE_NAME%TYPE
            , P_VALUE1             IN FI_COMMON.VALUE1%TYPE
            , P_VALUE2             IN FI_COMMON.VALUE2%TYPE
            , P_VALUE3             IN FI_COMMON.VALUE3%TYPE
            , P_VALUE4             IN FI_COMMON.VALUE4%TYPE
            , P_VALUE5             IN FI_COMMON.VALUE5%TYPE
            , P_VALUE6             IN FI_COMMON.VALUE6%TYPE
            , P_VALUE7             IN FI_COMMON.VALUE7%TYPE
            , P_VALUE8             IN FI_COMMON.VALUE8%TYPE
            , P_VALUE9             IN FI_COMMON.VALUE9%TYPE
            , P_VALUE10            IN FI_COMMON.VALUE10%TYPE
            , P_DEFAULT_FLAG       IN FI_COMMON.DEFAULT_FLAG%TYPE
            , P_SORT_NUM           IN FI_COMMON.SORT_NUM%TYPE
            , P_DESCRIPTION        IN FI_COMMON.DESCRIPTION%TYPE
            , P_ENABLED_FLAG       IN FI_COMMON.ENABLED_FLAG%TYPE
            , P_EFFECTIVE_DATE_FR  IN FI_COMMON.EFFECTIVE_DATE_FR%TYPE
            , P_EFFECTIVE_DATE_TO  IN FI_COMMON.EFFECTIVE_DATE_TO%TYPE
            , P_USER_ID            IN FI_COMMON.CREATED_BY%TYPE
            )
  AS
  BEGIN
    UPDATE FI_COMMON FI
      SET FI.CODE_NAME             = P_CODE_NAME
        , FI.VALUE1                = P_VALUE1
        , FI.VALUE2                = P_VALUE2
        , FI.VALUE3                = P_VALUE3
        , FI.VALUE4                = P_VALUE4
        , FI.VALUE5                = P_VALUE5
        , FI.VALUE6                = P_VALUE6
        , FI.VALUE7                = P_VALUE7
        , FI.VALUE8                = P_VALUE8
        , FI.VALUE9                = P_VALUE9
        , FI.VALUE10               = P_VALUE10
        , FI.DEFAULT_FLAG          = P_DEFAULT_FLAG
        , FI.SORT_NUM              = P_SORT_NUM
        , FI.DESCRIPTION           = P_DESCRIPTION
        , FI.ENABLED_FLAG          = P_ENABLED_FLAG
        , FI.EFFECTIVE_DATE_FR     = TRUNC(P_EFFECTIVE_DATE_FR)
        , FI.EFFECTIVE_DATE_TO     = TRUNC(P_EFFECTIVE_DATE_TO)
        , FI.LAST_UPDATE_DATE      = GET_LOCAL_DATE(FI.SOB_ID)
        , FI.LAST_UPDATED_BY       = P_USER_ID
      WHERE FI.COMMON_ID           = W_COMMON_ID
      ;
      COMMIT;

  END COMMON_UPDATE_L;


-----------------------------------------------------------------------------------------
-- 공통코드 명칭 리턴 FUNCTION.
  FUNCTION ID_NAME_F
            ( W_COMMON_ID          IN FI_COMMON.COMMON_ID%TYPE
            ) RETURN VARCHAR2
  AS
    V_RETURN_VALUE                 VARCHAR2(150) := NULL;

  BEGIN
    BEGIN
      SELECT  FI.CODE_NAME
        INTO V_RETURN_VALUE
      FROM FI_COMMON FI
      WHERE FI.COMMON_ID           = W_COMMON_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_RETURN_VALUE := NULL;
    END;
    RETURN V_RETURN_VALUE;

  END ID_NAME_F;

  PROCEDURE ID_NAME
            ( W_COMMON_ID          IN FI_COMMON.COMMON_ID%TYPE
            , O_RETURN_VALUE       OUT VARCHAR2
            )
  AS
  BEGIN
    BEGIN
      SELECT  FI.CODE_NAME
        INTO O_RETURN_VALUE
      FROM FI_COMMON FI
      WHERE FI.COMMON_ID           = W_COMMON_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      O_RETURN_VALUE := NULL;
    END;

  END ID_NAME;

  FUNCTION CODE_NAME_F
           ( W_GROUP_CODE          IN FI_COMMON.GROUP_CODE%TYPE
           , W_CODE                IN FI_COMMON.CODE%TYPE
           , W_SOB_ID              IN FI_COMMON.SOB_ID%TYPE
           , W_ORG_ID              IN FI_COMMON.ORG_ID%TYPE DEFAULT NULL
           ) RETURN VARCHAR2
  AS
    V_RETURN_VALUE                                        VARCHAR2(150) := NULL;

  BEGIN
    BEGIN
      SELECT FI.CODE_NAME
        INTO V_RETURN_VALUE
      FROM FI_COMMON FI
      WHERE FI.GROUP_CODE          = W_GROUP_CODE
        AND FI.CODE                = W_CODE
        AND FI.SOB_ID              = W_SOB_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_RETURN_VALUE := NULL;
    END;
    RETURN V_RETURN_VALUE;

  END CODE_NAME_F;

  PROCEDURE CODE_NAME
            ( W_GROUP_CODE          IN FI_COMMON.GROUP_CODE%TYPE
            , W_CODE                IN FI_COMMON.CODE%TYPE
            , W_SOB_ID              IN FI_COMMON.SOB_ID%TYPE
            , W_ORG_ID              IN FI_COMMON.ORG_ID%TYPE DEFAULT NULL
            , O_RETURN_VALUE        OUT VARCHAR2
            )
  AS
  BEGIN
    BEGIN
      SELECT FI.CODE_NAME
        INTO O_RETURN_VALUE
      FROM FI_COMMON FI
      WHERE FI.GROUP_CODE          = W_GROUP_CODE
        AND FI.CODE                = W_CODE
        AND FI.SOB_ID              = W_SOB_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      O_RETURN_VALUE := NULL;
    END;

  END CODE_NAME;

-- 공통코드 VALUE 리턴 FUNCTION.
  FUNCTION ID_VALUE_F
            ( W_COMMON_ID          IN FI_COMMON.COMMON_ID%TYPE
            , W_VALUE_ID           IN FI_COMMON.VALUE1%TYPE
            ) RETURN VARCHAR2
  AS
    V_RETURN_VALUE                 VARCHAR2(150) := NULL;
  BEGIN
    BEGIN
      SELECT CASE W_VALUE_ID
               WHEN 'VALUE1' THEN FC.VALUE1
               WHEN 'VALUE2' THEN FC.VALUE2
               WHEN 'VALUE3' THEN FC.VALUE3
               WHEN 'VALUE4' THEN FC.VALUE4
               WHEN 'VALUE5' THEN FC.VALUE5
               WHEN 'VALUE6' THEN FC.VALUE6
               WHEN 'VALUE7' THEN FC.VALUE7
               WHEN 'VALUE8' THEN FC.VALUE8
               WHEN 'VALUE9' THEN FC.VALUE9
               WHEN 'VALUE10' THEN FC.VALUE10
               ELSE NULL
             END AS VALUE_ID
        INTO V_RETURN_VALUE
        FROM FI_COMMON FC
      WHERE FC.COMMON_ID          = W_COMMON_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_RETURN_VALUE := NULL;
    END;
    RETURN V_RETURN_VALUE;

  END ID_VALUE_F;

  PROCEDURE ID_VALUE
            ( W_COMMON_ID          IN FI_COMMON.COMMON_ID%TYPE
            , W_VALUE_ID           IN FI_COMMON.VALUE1%TYPE
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
           ( W_GROUP_CODE          IN FI_COMMON.GROUP_CODE%TYPE
           , W_CODE                IN FI_COMMON.CODE%TYPE
           , W_VALUE_ID            IN FI_COMMON.VALUE1%TYPE
           , W_SOB_ID              IN FI_COMMON.SOB_ID%TYPE
           , W_ORG_ID              IN FI_COMMON.ORG_ID%TYPE DEFAULT NULL
           ) RETURN VARCHAR2
  AS
    V_RETURN_VALUE                 VARCHAR2(150) := NULL;
  BEGIN
    BEGIN
      SELECT CASE W_VALUE_ID
               WHEN 'VALUE1' THEN FC.VALUE1
               WHEN 'VALUE2' THEN FC.VALUE2
               WHEN 'VALUE3' THEN FC.VALUE3
               WHEN 'VALUE4' THEN FC.VALUE4
               WHEN 'VALUE5' THEN FC.VALUE5
               WHEN 'VALUE6' THEN FC.VALUE6
               WHEN 'VALUE7' THEN FC.VALUE7
               WHEN 'VALUE8' THEN FC.VALUE8
               WHEN 'VALUE9' THEN FC.VALUE9
               WHEN 'VALUE10' THEN FC.VALUE10
               ELSE NULL
             END AS VALUE_ID
        INTO V_RETURN_VALUE
        FROM FI_COMMON FC
      WHERE FC.GROUP_CODE         = W_GROUP_CODE
        AND FC.CODE               = W_CODE
        AND FC.SOB_ID             = W_SOB_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_RETURN_VALUE := NULL;
    END;    
    RETURN V_RETURN_VALUE;
  END CODE_VALUE_F;

  PROCEDURE CODE_VALUE
            ( W_GROUP_CODE          IN FI_COMMON.GROUP_CODE%TYPE
            , W_CODE                IN FI_COMMON.CODE%TYPE
            , W_VALUE_ID            IN FI_COMMON.VALUE1%TYPE
            , W_SOB_ID              IN FI_COMMON.SOB_ID%TYPE
            , W_ORG_ID              IN FI_COMMON.ORG_ID%TYPE DEFAULT NULL
            , O_RETURN_VALUE        OUT VARCHAR2
            )
  AS
  BEGIN
    BEGIN
      O_RETURN_VALUE := CODE_VALUE_F
                         ( W_GROUP_CODE
                         , W_CODE
                         , W_VALUE_ID
                         , W_SOB_ID
                         );
    EXCEPTION WHEN OTHERS THEN
      O_RETURN_VALUE := NULL;
    END;
  END CODE_VALUE;

-- ID값 코드값 반환.
  FUNCTION GET_ID_F
            ( W_GROUP_CODE          IN FI_COMMON.GROUP_CODE%TYPE
            , W_WHERE               IN VARCHAR2
            , W_SOB_ID              IN FI_COMMON.SOB_ID%TYPE
            , W_ORG_ID              IN FI_COMMON.ORG_ID%TYPE DEFAULT NULL
            ) RETURN NUMBER
  AS
    V_RETURN_ID                    NUMBER := NULL;
    V_STRING                       VARCHAR2(1000) := NULL;

  BEGIN
    BEGIN
      V_STRING := 'SELECT COMMON_ID 
                      FROM FI_COMMON
                    WHERE GROUP_CODE     = ''' || W_GROUP_CODE || '''
                      AND ' || W_WHERE || '
                      AND SOB_ID         = ' || W_SOB_ID ;
      EXECUTE IMMEDIATE V_STRING
      INTO V_RETURN_ID;

    EXCEPTION WHEN OTHERS THEN
      V_RETURN_ID := NULL;
    END;
    RETURN V_RETURN_ID;
        
  END GET_ID_F;

-- CODE값 반환.
  FUNCTION GET_CODE_F
            ( W_COMMON_ID           IN FI_COMMON.COMMON_ID%TYPE
            , W_SOB_ID              IN FI_COMMON.SOB_ID%TYPE
            , W_ORG_ID              IN FI_COMMON.ORG_ID%TYPE DEFAULT NULL
            ) RETURN VARCHAR2
  AS
    V_CODE    VARCHAR2(20) := NULL;
  BEGIN
    BEGIN
      SELECT HC.CODE
        INTO V_CODE
        FROM FI_COMMON HC
      WHERE HC.COMMON_ID          = W_COMMON_ID
        AND HC.SOB_ID             = W_SOB_ID
        --AND HC.ORG_ID             = W_ORG_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      NULL;
    END;
    RETURN V_CODE;
      
  END GET_CODE_F;
              
-----------------------------------------------------------------------------------------
-- 공통코드 기본값 리턴 - GROUP CODE..
  PROCEDURE DEFAULT_VALUE_GROUP
            ( W_GROUP_CODE          IN FI_COMMON.GROUP_CODE%TYPE
            , W_SOB_ID              IN FI_COMMON.SOB_ID%TYPE
            , W_ORG_ID              IN FI_COMMON.ORG_ID%TYPE
            , O_ID                  OUT FI_COMMON.COMMON_ID%TYPE
            , O_CODE                OUT FI_COMMON.CODE%TYPE
            , O_CODE_NAME           OUT FI_COMMON.CODE_NAME%TYPE
            )
  AS
  BEGIN
    BEGIN
      SELECT FI.CODE_NAME, FI.CODE, FI.COMMON_ID
        INTO O_CODE_NAME, O_CODE, O_ID
        FROM FI_COMMON FI
      WHERE FI.GROUP_CODE            = W_GROUP_CODE
        AND FI.SOB_ID                = W_SOB_ID
        AND FI.DEFAULT_FLAG          = 'Y'
        AND ROWNUM                   <= 1
        AND FI.ENABLED_FLAG          = 'Y'
        AND FI.EFFECTIVE_DATE_FR     <= GET_LOCAL_DATE(FI.SOB_ID)
        AND (FI.EFFECTIVE_DATE_TO IS NULL OR FI.EFFECTIVE_DATE_TO  >= GET_LOCAL_DATE(FI.SOB_ID))
      ;
    EXCEPTION WHEN OTHERS THEN
      O_ID := 0;
      O_CODE := NULL;
      O_CODE_NAME := NULL;
    END;

  END DEFAULT_VALUE_GROUP;

-- 공통코드 기본값 리턴 - VALUE1을 조건 검색하여 : GROUP CODE..
  PROCEDURE DEFAULT_VALUE_GROUP_W
            ( W_GROUP_CODE         IN FI_COMMON.GROUP_CODE%TYPE
            , W_WHERE              IN VARCHAR2
            , W_SOB_ID             IN FI_COMMON.SOB_ID%TYPE
            , W_ORG_ID             IN FI_COMMON.ORG_ID%TYPE
            , O_ID                 OUT FI_COMMON.COMMON_ID%TYPE
            , O_CODE               OUT FI_COMMON.CODE%TYPE
            , O_CODE_NAME          OUT FI_COMMON.CODE_NAME%TYPE
            )
  AS
    V_STRING                       VARCHAR2(1000);

  BEGIN
    BEGIN
      V_STRING := 'SELECT FI.CODE_NAME, FI.CODE, FI.COMMON_ID
                     FROM FI_COMMON FI
                    WHERE FI.GROUP_CODE            = ''' || W_GROUP_CODE  || '''
                      AND FI.SOB_ID                = ' || W_SOB_ID || '
                      AND ' || W_WHERE  || '
                      AND FI.DEFAULT_FLAG          =  ''Y''
                      AND ROWNUM                   <= 1
                      AND FI.ENABLED_FLAG          = ''Y''
                      AND FI.EFFECTIVE_DATE_FR     <= GET_LOCAL_DATE(FI.SOB_ID)
                      AND (FI.EFFECTIVE_DATE_TO IS NULL OR FI.EFFECTIVE_DATE_TO  >= GET_LOCAL_DATE(FI.SOB_ID)) ';
--      DBMS_OUTPUT.PUT_LINE(V_STRING);
      EXECUTE IMMEDIATE V_STRING
      INTO O_CODE_NAME, O_CODE, O_ID;

    EXCEPTION WHEN OTHERS THEN
      O_ID := 0;
      O_CODE := NULL;
      O_CODE_NAME := NULL;
    END;

  END DEFAULT_VALUE_GROUP_W;

-- 공통코드 기본값 리턴 - GROUP CODE value2..
  PROCEDURE DEFAULT_VALUE2_GROUP
            ( W_GROUP_CODE          IN FI_COMMON.GROUP_CODE%TYPE
            , W_SOB_ID              IN FI_COMMON.SOB_ID%TYPE
            , W_ORG_ID              IN FI_COMMON.ORG_ID%TYPE
            , O_ID                  OUT FI_COMMON.COMMON_ID%TYPE
            , O_CODE                OUT FI_COMMON.CODE%TYPE
            , O_CODE_NAME           OUT FI_COMMON.CODE_NAME%TYPE
            , O_VALUE1              OUT FI_COMMON.VALUE1%TYPE
            , O_VALUE2              OUT FI_COMMON.VALUE2%TYPE
            )
  AS
  BEGIN
    BEGIN
      SELECT FI.CODE_NAME, FI.CODE, FI.COMMON_ID, FI.VALUE1, FI.VALUE2
        INTO O_CODE_NAME, O_CODE, O_ID, O_VALUE1, O_VALUE2
        FROM FI_COMMON FI
      WHERE FI.GROUP_CODE            = W_GROUP_CODE
        AND FI.SOB_ID                = W_SOB_ID
        AND FI.DEFAULT_FLAG          = 'Y'
        AND ROWNUM                   <= 1
        AND FI.ENABLED_FLAG          = 'Y'
        AND FI.EFFECTIVE_DATE_FR     <= GET_LOCAL_DATE(FI.SOB_ID)
        AND (FI.EFFECTIVE_DATE_TO IS NULL OR FI.EFFECTIVE_DATE_TO  >= GET_LOCAL_DATE(FI.SOB_ID))
      ;
    EXCEPTION WHEN OTHERS THEN
      O_ID := 0;
      O_CODE := NULL;
      O_CODE_NAME := NULL;
      O_VALUE1 := NULL;
      O_VALUE2 := NULL;
    END;
  END DEFAULT_VALUE2_GROUP;
  
  -- 공통코드 기본값 리턴 - VALUE2까지 조건 검색하여 : GROUP CODE..
  PROCEDURE DEFAULT_VALUE2_W
            ( W_WHERE              IN VARCHAR2
            , W_SOB_ID             IN FI_COMMON.SOB_ID%TYPE
            , W_ORG_ID             IN FI_COMMON.ORG_ID%TYPE
            , O_ID                 OUT FI_COMMON.COMMON_ID%TYPE
            , O_CODE               OUT FI_COMMON.CODE%TYPE
            , O_CODE_NAME          OUT FI_COMMON.CODE_NAME%TYPE
            , O_VALUE1              OUT FI_COMMON.VALUE1%TYPE
            , O_VALUE2              OUT FI_COMMON.VALUE2%TYPE
            )
  AS
    V_STRING                       VARCHAR2(1000);

  BEGIN
    BEGIN
      V_STRING := 'SELECT FI.CODE_NAME, FI.CODE, FI.COMMON_ID, FI.VALUE1, FI.VALUE2
                     FROM FI_COMMON FI
                    WHERE FI.SOB_ID                = ' || W_SOB_ID || '
                      AND ' || W_WHERE  || '
                      AND ROWNUM                   <= 1
                      AND FI.ENABLED_FLAG          = ''Y''
                      AND FI.EFFECTIVE_DATE_FR     <= GET_LOCAL_DATE(FI.SOB_ID)
                      AND (FI.EFFECTIVE_DATE_TO IS NULL OR FI.EFFECTIVE_DATE_TO  >= GET_LOCAL_DATE(FI.SOB_ID)) ';
--      DBMS_OUTPUT.PUT_LINE(V_STRING);
      EXECUTE IMMEDIATE V_STRING
      INTO O_CODE_NAME, O_CODE, O_ID, O_VALUE1, O_VALUE2;

    EXCEPTION WHEN OTHERS THEN
      O_ID := 0;
      O_CODE := NULL;
      O_CODE_NAME := NULL;
      O_VALUE1 := NULL;
      O_VALUE2 := NULL;
    END;
  END DEFAULT_VALUE2_W;

-----------------------------------------------------------------------------------------
-- 공통코드 조회 LOOKUP - GROUP CODE..
  PROCEDURE LU_SELECT_GROUP
            ( P_CURSOR3            OUT TYPES.TCURSOR3
            , W_GROUP_CODE         IN FI_COMMON.GROUP_CODE%TYPE
            , W_CODE_NAME          IN FI_COMMON.CODE_NAME%TYPE
            , W_SOB_ID             IN FI_COMMON.SOB_ID%TYPE
            , W_ORG_ID             IN FI_COMMON.ORG_ID%TYPE
            , W_ENABLED_YN         IN FI_COMMON.ENABLED_FLAG%TYPE DEFAULT 'Y'
            )
  AS
    V_STD_DATE                     FI_COMMON.EFFECTIVE_DATE_FR%TYPE := NULL;

  BEGIN
    IF W_ENABLED_YN = 'Y' THEN
      V_STD_DATE := TRUNC(GET_LOCAL_DATE(W_SOB_ID));
    ELSE
      V_STD_DATE := NULL;
    END IF;

    OPEN P_CURSOR3 FOR
      SELECT FI.CODE_NAME
          , FI.CODE
          , FI.COMMON_ID
          , FI.VALUE1
          , FI.VALUE2
          , FI.VALUE3
          , FI.VALUE4
          , FI.VALUE5
          , FI.VALUE6
          , FI.VALUE7
          , FI.VALUE8
          , FI.VALUE9
          , FI.VALUE10
      FROM FI_COMMON FI
      WHERE FI.GROUP_CODE          = W_GROUP_CODE
        AND FI.CODE_NAME           LIKE W_CODE_NAME || '%'
        AND FI.SOB_ID              = W_SOB_ID
        AND FI.ENABLED_FLAG        = DECODE(W_ENABLED_YN, 'Y', 'Y', FI.ENABLED_FLAG)
        AND FI.EFFECTIVE_DATE_FR   <= NVL(V_STD_DATE, FI.EFFECTIVE_DATE_FR)
        AND (FI.EFFECTIVE_DATE_TO IS NULL OR FI.EFFECTIVE_DATE_TO >= NVL(V_STD_DATE, FI.EFFECTIVE_DATE_TO))
      ORDER BY FI.SORT_NUM, FI.CODE
      ;

  END LU_SELECT_GROUP;

-- 공통코드 WHERE 조건으로 조회 LOOKUP.
  PROCEDURE LU_SELECT_GROUP_W
            ( P_CURSOR3            OUT TYPES.TCURSOR3
            , W_GROUP_CODE         IN FI_COMMON.GROUP_CODE%TYPE
            , W_WHERE              IN VARCHAR2
            , W_SOB_ID             IN FI_COMMON.SOB_ID%TYPE
            , W_ORG_ID             IN FI_COMMON.ORG_ID%TYPE
            , W_ENABLED_YN         IN FI_COMMON.ENABLED_FLAG%TYPE DEFAULT 'Y'
            )
  AS
    V_STD_DATE                     VARCHAR2(10) := NULL;
    V_STRING                       VARCHAR2(2000);

  BEGIN
    IF W_ENABLED_YN = 'Y' THEN
      V_STD_DATE := TO_CHAR(GET_LOCAL_DATE(W_SOB_ID), 'YYYY-MM-DD');
    ELSE
      V_STD_DATE := NULL;
    END IF;
    -- 임시테이블 삭제.
    DELETE FROM FI_COMMON_GT;
    V_STRING := 'INSERT INTO FI_COMMON_GT
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
                  SELECT FI.CODE_NAME
                      , FI.CODE
                      , FI.COMMON_ID
                      , FI.VALUE1
                      , FI.VALUE2
                      , FI.VALUE3
                      , FI.VALUE4
                      , FI.VALUE5
                      , FI.VALUE6
                      , FI.VALUE7
                      , FI.VALUE8
                      , FI.VALUE9
                      , FI.VALUE10
                   FROM FI_COMMON FI
                  WHERE FI.GROUP_CODE            = ''' || W_GROUP_CODE  || '''
                    AND FI.SOB_ID                = ' || W_SOB_ID || '
                    AND ' || W_WHERE  || '
                    AND FI.ENABLED_FLAG       = DECODE(''' || W_ENABLED_YN || ''', ''Y'', ''Y'', FI.ENABLED_FLAG)
                    AND FI.EFFECTIVE_DATE_FR  <= NVL(TO_DATE(''' || V_STD_DATE || ''', ''YYYY-MM-DD''), FI.EFFECTIVE_DATE_FR)
                    AND (FI.EFFECTIVE_DATE_TO IS NULL OR FI.EFFECTIVE_DATE_TO >= NVL(TO_DATE(''' || V_STD_DATE || ''', ''YYYY-MM-DD''), FI.EFFECTIVE_DATE_TO))
                  ORDER BY FI.SORT_NUM, FI.CODE ';
--    DBMS_OUTPUT.PUT_LINE(V_STRING);
    EXECUTE IMMEDIATE V_STRING;

    OPEN P_CURSOR3 FOR
      SELECT FI.CODE_NAME
          , FI.CODE
          , FI.COMMON_ID
          , FI.VALUE1
          , FI.VALUE2
          , FI.VALUE3
          , FI.VALUE4
          , FI.VALUE5
          , FI.VALUE6
          , FI.VALUE7
          , FI.VALUE8
          , FI.VALUE9
          , FI.VALUE10
       FROM FI_COMMON_GT FI ;

  END LU_SELECT_GROUP_W;

-- LOOKUP COST CENTER.
  PROCEDURE LU_COST_CENTER
            ( P_CURSOR3            OUT TYPES.TCURSOR3
            , W_SOB_ID             IN CST_COST_CENTER.SOB_ID%TYPE
            , W_ORG_ID             IN CST_COST_CENTER.ORG_ID%TYPE
            , W_ENABLED_YN         IN CST_COST_CENTER.ENABLED_FLAG%TYPE DEFAULT 'Y'
            )
  AS
    V_STD_DATE                     FI_COMMON.EFFECTIVE_DATE_FR%TYPE := NULL;

  BEGIN
    IF W_ENABLED_YN = 'Y' THEN
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
         AND CC.ENABLED_FLAG            = DECODE(W_ENABLED_YN, 'Y', 'Y', CC.ENABLED_FLAG)
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

--------------------------------------------
-- Main Org ID Return                     --
--------------------------------------------
  FUNCTION OPERATING_ORG_F
           ( W_SOB_ID             IN NUMBER
           ) RETURN NUMBER
  AS
    V_ORG_ID        NUMBER := 0;
  BEGIN
    BEGIN
      SELECT OO.ORG_ID
        INTO V_ORG_ID
        FROM FI_OPERATING_ORG OO
       WHERE OO.SOB_ID        = W_SOB_ID
         AND OO.OPERATING_FLAG  = 'Y'
         AND OO.ENABLED_FLAG    = 'Y'
         AND OO.EFFECTIVE_DATE_FR <= TRUNC(SYSDATE)
         AND (OO.EFFECTIVE_DATE_TO IS NULL OR OO.EFFECTIVE_DATE_TO >= TRUNC(SYSDATE))
         AND ROWNUM <= 1
      ;
    EXCEPTION WHEN OTHERS THEN
      V_ORG_ID := 0;
    END;
    RETURN V_ORG_ID;

  END OPERATING_ORG_F;

--------------------------------------------
-- SUPPLIER/CUSTOMER 조회                 --
--------------------------------------------
  PROCEDURE LU_SUPP_CUST
            ( P_CURSOR3           OUT TYPES.TCURSOR3
            , W_SOB_ID            IN NUMBER
            , W_SUPP_CUST_TYPE    IN VARCHAR2
            , W_ENABLED_YN        IN VARCHAR2 DEFAULT 'Y'
            )
  AS
    V_STD_DATE                     FI_COMMON.EFFECTIVE_DATE_FR%TYPE := NULL;

  BEGIN
    IF W_ENABLED_YN = 'Y' THEN
      V_STD_DATE := TRUNC(GET_LOCAL_DATE(W_SOB_ID));
    ELSE
      V_STD_DATE := NULL;
    END IF;

    OPEN P_CURSOR3 FOR
      SELECT SCV.SUPP_CUST_NAME
           , SCV.TAX_REG_NO
           , SCV.SUPP_CUST_TYPE_NAME
           , SCV.SUPP_CUST_CODE
           , SCV.SUPP_CUST_ID
        FROM FI_SUPP_CUST_V SCV
       WHERE SCV.SOB_ID                 = W_SOB_ID
         AND SCV.SUPP_CUST_TYPE         = NVL(W_SUPP_CUST_TYPE, SCV.SUPP_CUST_TYPE)
         AND SCV.ENABLED_FLAG           = DECODE(W_ENABLED_YN, 'Y', 'Y', SCV.ENABLED_FLAG)
         AND TRUNC(SCV.EFFECTIVE_DATE_FR) <= NVL(V_STD_DATE, TRUNC(SCV.EFFECTIVE_DATE_FR))
         AND (TRUNC(SCV.EFFECTIVE_DATE_TO) IS NULL OR TRUNC(SCV.EFFECTIVE_DATE_TO) >= NVL(V_STD_DATE, TRUNC(SCV.EFFECTIVE_DATE_TO)))
      ;

  END LU_SUPP_CUST;

  FUNCTION  SUPP_CUST_ID_NAME_F
            ( W_SUPP_CUST_ID      IN NUMBER
            ) RETURN VARCHAR2
  AS
    V_RETURN_VALUE                VARCHAR2(150);
  BEGIN
    BEGIN
      SELECT SCV.SUPP_CUST_NAME
        INTO V_RETURN_VALUE
        FROM FI_SUPP_CUST_V SCV
       WHERE SCV.SUPP_CUST_ID           = W_SUPP_CUST_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_RETURN_VALUE := NULL;
    END;
    RETURN V_RETURN_VALUE;

  END;

  FUNCTION  SUPP_CUST_CODE_NAME_F
            ( W_SUPP_CUST_CODE    IN VARCHAR2
            , W_SOB_ID            IN NUMBER
            ) RETURN VARCHAR2
  AS
    V_RETURN_VALUE                VARCHAR2(150);
  BEGIN
    BEGIN
      SELECT SCV.SUPP_CUST_NAME
        INTO V_RETURN_VALUE
        FROM FI_SUPP_CUST_V SCV
       WHERE SCV.SUPP_CUST_CODE   = W_SUPP_CUST_CODE
         AND SCV.SOB_ID           = W_SOB_ID
         AND ROWNUM               <= 1
      ;
    EXCEPTION WHEN OTHERS THEN
      V_RETURN_VALUE := NULL;
    END;
    RETURN V_RETURN_VALUE;
  
  END SUPP_CUST_CODE_NAME_F;
  
  FUNCTION  SUPP_CUST_TAX_NAME_F
            ( W_SOB_ID            IN NUMBER
            , W_TAX_REG_NO        IN VARCHAR2
            ) RETURN VARCHAR2
  AS
    V_RETURN_VALUE                VARCHAR2(150);
  BEGIN
    BEGIN
      SELECT SCV.SUPP_CUST_NAME
        INTO V_RETURN_VALUE
        FROM FI_SUPP_CUST_V SCV
       WHERE SCV.SOB_ID                 = W_SOB_ID
         AND SCV.TAX_REG_NO             = W_TAX_REG_NO
      ;
    EXCEPTION WHEN OTHERS THEN
      V_RETURN_VALUE := NULL;
    END;
    RETURN V_RETURN_VALUE;

  END SUPP_CUST_TAX_NAME_F;

--------------------------------------------
-- LOOKUP TYPE 조회                       --
--------------------------------------------
  FUNCTION GET_LOOKUP_ENTRY_ID_F
           ( W_LOOKUP_ENTRY_ID    IN NUMBER
           ) RETURN VARCHAR2
  AS
    V_RETURN_VALUE  VARCHAR2(200) := NULL;

  BEGIN
    BEGIN
      SELECT LE.ENTRY_DESCRIPTION
        INTO V_RETURN_VALUE
        FROM EAPP_LOOKUP_ENTRY_TLV LE
       WHERE LE.LOOKUP_ENTRY_ID   = W_LOOKUP_ENTRY_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_RETURN_VALUE := NULL;
    END;
    RETURN V_RETURN_VALUE;

  END GET_LOOKUP_ENTRY_ID_F;

  FUNCTION GET_LOOKUP_ENTRY_TYPE_F
           ( W_SOB_ID             IN NUMBER
           , W_LOOKUP_MODULE      IN VARCHAR2
           , W_LOOKUP_TYPE        IN VARCHAR2
           ) RETURN VARCHAR2
  AS
    V_RETURN_VALUE  VARCHAR2(200) := NULL;

  BEGIN
    BEGIN
      SELECT LE.ENTRY_DESCRIPTION
        INTO V_RETURN_VALUE
        FROM EAPP_LOOKUP_ENTRY_TLV LE
       WHERE LE.LOOKUP_MODULE           = W_LOOKUP_MODULE
         AND LE.LOOKUP_TYPE             = W_LOOKUP_TYPE
         AND LE.SOB_ID                  = W_SOB_ID
         AND LE.ORG_ID                  = OPERATING_ORG_F(W_SOB_ID)
      ;
    EXCEPTION WHEN OTHERS THEN
      V_RETURN_VALUE := NULL;
    END;
    RETURN V_RETURN_VALUE;

  END GET_LOOKUP_ENTRY_TYPE_F;

  PROCEDURE LU_LOOKUP_ENTRY
            ( P_CURSOR3           OUT TYPES.TCURSOR3
            , W_LOOKUP_MODULE     IN VARCHAR2
            , W_LOOKUP_TYPE       IN VARCHAR2
            , W_SOB_ID            IN  NUMBER
            , W_ORG_ID            IN  NUMBER
            , W_ENABLED_YN        IN VARCHAR2 DEFAULT 'Y'
            )
  AS
    V_STD_DATE                     FI_COMMON.EFFECTIVE_DATE_FR%TYPE := NULL;

  BEGIN
    IF W_ENABLED_YN = 'Y' THEN
      V_STD_DATE := TRUNC(GET_LOCAL_DATE(W_SOB_ID));
    ELSE
      V_STD_DATE := NULL;
    END IF;

    OPEN P_CURSOR3 FOR
      SELECT LE.ENTRY_DESCRIPTION
           , LE.ENTRY_CODE
           , LE.LOOKUP_ENTRY_ID
           , LE.ENTRY_TAG
           , LE.SEGMENT1
           , LE.SEGMENT2
           , LE.SEGMENT3
           , LE.SEGMENT4
           , LE.SEGMENT5
           , LE.EFFECTIVE_DATE_FR
           , LE.EFFECTIVE_DATE_TO
        FROM EAPP_LOOKUP_ENTRY_TLV LE
       WHERE LE.LOOKUP_MODULE           = W_LOOKUP_MODULE
         AND LE.LOOKUP_TYPE             = W_LOOKUP_TYPE
         AND LE.SOB_ID                  = W_SOB_ID
         AND LE.ORG_ID                  = OPERATING_ORG_F(W_SOB_ID)
         AND LE.ENABLED_FLAG            = DECODE(W_ENABLED_YN, 'Y', 'Y', LE.ENABLED_FLAG)
         AND TRUNC(LE.EFFECTIVE_DATE_FR) <= NVL(V_STD_DATE, TRUNC(LE.EFFECTIVE_DATE_FR))
         AND (TRUNC(LE.EFFECTIVE_DATE_TO) IS NULL OR TRUNC(LE.EFFECTIVE_DATE_TO) >= NVL(V_STD_DATE, TRUNC(LE.EFFECTIVE_DATE_TO)))
      ORDER BY LE.SORT_NO
      ;

  END LU_LOOKUP_ENTRY;

--------------------------------------------
-- CURRENCY : 통화                        --
--------------------------------------------
  PROCEDURE LU_CURRENCY
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_SOB_ID            IN NUMBER
            , W_ORG_ID            IN NUMBER
            , W_ENABLED_YN        IN VARCHAR2 DEFAULT 'Y'
            )
  AS
    V_STD_DATE                     FI_COMMON.EFFECTIVE_DATE_FR%TYPE := NULL;

  BEGIN
    IF W_ENABLED_YN = 'Y' THEN
      V_STD_DATE := TRUNC(GET_LOCAL_DATE(W_SOB_ID));
    ELSE
      V_STD_DATE := NULL;
    END IF;

    OPEN P_CURSOR FOR
      SELECT EC.CURRENCY_CODE AS DISPLAY_CURRENCY_CODE
          , EC.CURRENCY_CODE
       FROM EAPP_CURRENCY     EC
      WHERE EC.SOB_ID             = W_SOB_ID
        AND EC.ORG_ID             = OPERATING_ORG_F(W_SOB_ID)
        AND TRUNC(EC.EFFECTIVE_DATE_FR)  <= NVL(V_STD_DATE, TRUNC(EC.EFFECTIVE_DATE_FR))
        AND (TRUNC(EC.EFFECTIVE_DATE_TO) IS NULL OR TRUNC(EC.EFFECTIVE_DATE_TO) >= NVL(V_STD_DATE, TRUNC(EC.EFFECTIVE_DATE_TO)))
        AND EC.ENABLED_FLAG       = DECODE(W_ENABLED_YN, 'Y', 'Y', EC.ENABLED_FLAG)
      ORDER BY EC.CURRENCY_CODE
      ;

  END LU_CURRENCY;

-- 외화 금액을 입력 통화로 환산.
  FUNCTION  CONVERSION_BASE_AMOUNT_F
            ( W_BASE_CURRENCY_CODE  IN VARCHAR2
            , W_SOB_ID              IN NUMBER
            , W_CONVERSION_AMOUNT   IN NUMBER
            ) RETURN NUMBER
  AS
    V_BASE_AMOUNT                   NUMBER := 0;
    V_ROUND_TYPE                    VARCHAR2(30) := NULL;
    V_DECIMAL_POINT                 NUMBER := 0;
  BEGIN
    BEGIN
      SELECT EC.ROUNDING_RULE_LCODE
           , NVL(EC.AMOUNT_DECIMAL_POINT, 0) AS AMOUNT_DECIMAL_POINT
        INTO V_ROUND_TYPE
           , V_DECIMAL_POINT
        FROM EAPP_CURRENCY EC
       WHERE EC.CURRENCY_CODE           = W_BASE_CURRENCY_CODE
         AND EC.SOB_ID                  = W_SOB_ID
         AND EC.ORG_ID                  = FI_COMMON_G.OPERATING_ORG_F(W_SOB_ID)
      ;
    EXCEPTION WHEN OTHERS THEN
      V_ROUND_TYPE := 'ROUND';
      V_DECIMAL_POINT := -1;
    END;

    -- 라운드 타입에 따른 소숫점 처리.
    SELECT CASE V_ROUND_TYPE
             WHEN 'ROUND' THEN ROUND(W_CONVERSION_AMOUNT, V_DECIMAL_POINT)
             WHEN 'UP' THEN CEIL(W_CONVERSION_AMOUNT)
             WHEN 'DOWN' THEN TRUNC(W_CONVERSION_AMOUNT, V_DECIMAL_POINT)
             ELSE TRUNC(W_CONVERSION_AMOUNT)

           END AS BASE_AMOUNT
      INTO V_BASE_AMOUNT
      FROM DUAL;

    RETURN V_BASE_AMOUNT;

  END CONVERSION_BASE_AMOUNT_F;

  PROCEDURE CONVERSION_BASE_AMOUNT_P
            ( W_BASE_CURRENCY_CODE  IN VARCHAR2
            , W_SOB_ID              IN NUMBER
            , W_CONVERSION_AMOUNT   IN NUMBER
            , O_BASE_AMOUNT         OUT NUMBER
            )
  AS
  BEGIN
    O_BASE_AMOUNT := CONVERSION_BASE_AMOUNT_F ( W_BASE_CURRENCY_CODE => W_BASE_CURRENCY_CODE
                                              , W_SOB_ID => W_SOB_ID
                                              , W_CONVERSION_AMOUNT => W_CONVERSION_AMOUNT
                                              );

  END CONVERSION_BASE_AMOUNT_P;

-----------------------------------------------------------------------
-- 접속자에 대한 성명/사원id/사원번호/부서코드, 부서명, 부서id 리턴. --
-----------------------------------------------------------------------
  PROCEDURE USER_INFO_P
            ( W_PERSON_ID           IN HRM_PERSON_MASTER.PERSON_ID%TYPE
            , W_SOB_ID              IN NUMBER
            , O_PERSON_NUM          OUT HRM_PERSON_MASTER.PERSON_NUM%TYPE
            , O_PERSON_NAME         OUT HRM_PERSON_MASTER.NAME%TYPE
            , O_DEPT_ID             OUT FI_DEPT_MASTER.DEPT_ID%TYPE
            , O_DEPT_CODE           OUT FI_DEPT_MASTER.DEPT_CODE%TYPE
            , O_DEPT_NAME           OUT FI_DEPT_MASTER.DEPT_NAME%TYPE
            , O_COST_CENTER_ID      OUT CST_COST_CENTER.COST_CENTER_ID%TYPE
            , O_COST_CENTER_CODE    OUT CST_COST_CENTER.COST_CENTER_CODE%TYPE
            , O_COST_CENTER_DESC    OUT CST_COST_CENTER.COST_CENTER_DESC%TYPE
            )
  AS
  BEGIN
    BEGIN
      SELECT PM.PERSON_NUM
           , PM.NAME
           , FDM.DEPT_ID
           , FDM.DEPT_CODE
           , FDM.DEPT_NAME
           , CC.COST_CENTER_ID
           , CC.COST_CENTER_CODE
           , CC.COST_CENTER_DESC
        INTO O_PERSON_NUM
           , O_PERSON_NAME
           , O_DEPT_ID
           , O_DEPT_CODE
           , O_DEPT_NAME
           , O_COST_CENTER_ID
           , O_COST_CENTER_CODE
           , O_COST_CENTER_DESC
        FROM HRM_PERSON_MASTER PM
          , HRM_DEPT_MASTER HDM
          , FI_DEPT_MASTER_MAPPING_V FDM
          , CST_COST_CENTER CC
       WHERE PM.DEPT_ID                 = HDM.DEPT_ID
         AND HDM.DEPT_ID                = FDM.HR_DEPT_ID(+)
         AND HDM.CORP_ID                = FDM.HR_CORP_ID(+)
         AND HDM.SOB_ID                 = FDM.SOB_ID(+)
         AND PM.CORP_ID                 = CC.COST_CENTER_ID(+)
         AND PM.PERSON_ID               = W_PERSON_ID
         AND PM.SOB_ID                  = W_SOB_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      O_PERSON_NUM := NULL;
      O_PERSON_NAME := NULL;
      O_DEPT_ID := NULL;
      O_DEPT_CODE := NULL;
      O_DEPT_NAME := NULL;
      O_COST_CENTER_ID := NULL;
      O_COST_CENTER_CODE := NULL;
      O_COST_CENTER_DESC := NULL;
    END;

  END USER_INFO_P;

END FI_COMMON_G; 
/
