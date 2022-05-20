CREATE OR REPLACE PACKAGE HRM_CORP_MASTER_G
AS

-- CORP SELECT.
  PROCEDURE DATA_SELECT
	          ( P_CURSOR             OUT TYPES.TCURSOR
						, W_CORP_ID            IN HRM_CORP_MASTER.CORP_ID%TYPE
						, W_SOB_ID             IN HRM_CORP_MASTER.SOB_ID%TYPE
						, W_ORG_ID             IN HRM_CORP_MASTER.ORG_ID%TYPE
            , W_ENABLED_FLAG       IN HRM_CORP_MASTER.ENABLED_FLAG%TYPE
						);

-- CORP INSERT..
  PROCEDURE DATA_INSERT
            ( P_CORP_ID                     OUT HRM_CORP_MASTER.CORP_ID%TYPE
            , P_SOB_ID                      IN HRM_CORP_MASTER.SOB_ID%TYPE
						, P_ORG_ID                      IN HRM_CORP_MASTER.ORG_ID%TYPE
						, P_CORP_CODE                   OUT HRM_CORP_MASTER.CORP_CODE%TYPE 
            , P_CORP_NAME                   IN HRM_CORP_MASTER.CORP_NAME%TYPE
						, P_CORP_NAME_S                 IN HRM_CORP_MASTER.CORP_NAME_S%TYPE
						, P_LEGAL_NUMBER                IN HRM_CORP_MASTER.LEGAL_NUMBER%TYPE
						, P_PRESIDENT_NAME              IN HRM_CORP_MASTER.PRESIDENT_NAME%TYPE
						, P_ZIP_CODE                    IN HRM_CORP_MASTER.ZIP_CODE%TYPE
						, P_ADDR1                       IN HRM_CORP_MASTER.ADDR1%TYPE
						, P_ADDR2                       IN HRM_CORP_MASTER.ADDR2%TYPE
						, P_CORP_CATEGORY               IN HRM_CORP_MASTER.CORP_CATEGORY%TYPE
						, P_CORP_TYPE                   IN HRM_CORP_MASTER.CORP_TYPE%TYPE
						, P_CORP_SORT_NUM               IN HRM_CORP_MASTER.CORP_SORT_NUM%TYPE
						, P_PERSON_CHARGE_NAME          IN HRM_CORP_MASTER.PERSON_CHARGE_NAME%TYPE
						, P_TEL_NUMBER                  IN HRM_CORP_MASTER.TEL_NUMBER%TYPE
						, P_FAX_NUMBER                  IN HRM_CORP_MASTER.FAX_NUMBER%TYPE
						, P_EMAIL                       IN HRM_CORP_MASTER.EMAIL%TYPE
						, P_HOMEPAGE_URL                IN HRM_CORP_MASTER.HOMEPAGE_URL%TYPE
						, P_DEPT_CONTROL_YN             IN HRM_CORP_MASTER.DEPT_CONTROL_YN%TYPE
						, P_DUTY_CONTROL_YN             IN HRM_CORP_MASTER.DUTY_CONTROL_YN%TYPE
						, P_PAY_CONTROL_YN              IN HRM_CORP_MASTER.PAY_CONTROL_YN%TYPE
						, P_DEFAULT_FLAG                IN HRM_CORP_MASTER.DEFAULT_FLAG%TYPE
						, P_VENDOR_ID                   IN HRM_CORP_MASTER.VENDOR_ID%TYPE
            , P_BENEFIT_RATE                IN HRM_CORP_MASTER.BENEFIT_RATE%TYPE
            , P_RETIREMENT_PENSION_BANK     IN HRM_CORP_MASTER.RETIREMENT_PENSION_BANK%TYPE
            , P_RETIREMENT_PENSION_ACCOUNT  IN HRM_CORP_MASTER.RETIREMENT_PENSION_ACCOUNT%TYPE
            , P_ENABLED_FLAG                IN HRM_CORP_MASTER.ENABLED_FLAG%TYPE
						, P_EFFECTIVE_DATE_FR           IN HRM_CORP_MASTER.EFFECTIVE_DATE_FR%TYPE
						, P_EFFECTIVE_DATE_TO           IN HRM_CORP_MASTER.EFFECTIVE_DATE_TO%TYPE
            , P_DESCRIPTION                 IN HRM_CORP_MASTER.DESCRIPTION%TYPE 
						, P_USER_ID                     IN HRM_CORP_MASTER.CREATED_BY%TYPE
						);
                                              
-- CORP UPDATE.
  PROCEDURE DATA_UPDATE
            ( W_CORP_ID                     IN HRM_CORP_MASTER.CORP_ID%TYPE
            , P_SOB_ID                      IN HRM_CORP_MASTER.SOB_ID%TYPE
						, P_ORG_ID                      IN HRM_CORP_MASTER.ORG_ID%TYPE
            , P_CORP_NAME                   IN HRM_CORP_MASTER.CORP_NAME%TYPE
            , P_CORP_NAME_S                 IN HRM_CORP_MASTER.CORP_NAME_S%TYPE
            , P_LEGAL_NUMBER                IN HRM_CORP_MASTER.LEGAL_NUMBER%TYPE
            , P_PRESIDENT_NAME              IN HRM_CORP_MASTER.PRESIDENT_NAME%TYPE
            , P_ZIP_CODE                    IN HRM_CORP_MASTER.ZIP_CODE%TYPE
            , P_ADDR1                       IN HRM_CORP_MASTER.ADDR1%TYPE
            , P_ADDR2                       IN HRM_CORP_MASTER.ADDR2%TYPE
            , P_CORP_CATEGORY               IN HRM_CORP_MASTER.CORP_CATEGORY%TYPE
            , P_CORP_TYPE                   IN HRM_CORP_MASTER.CORP_TYPE%TYPE
            , P_CORP_SORT_NUM               IN HRM_CORP_MASTER.CORP_SORT_NUM%TYPE
            , P_PERSON_CHARGE_NAME          IN HRM_CORP_MASTER.PERSON_CHARGE_NAME%TYPE
            , P_TEL_NUMBER                  IN HRM_CORP_MASTER.TEL_NUMBER%TYPE
            , P_FAX_NUMBER                  IN HRM_CORP_MASTER.FAX_NUMBER%TYPE
            , P_EMAIL                       IN HRM_CORP_MASTER.EMAIL%TYPE
            , P_HOMEPAGE_URL                IN HRM_CORP_MASTER.HOMEPAGE_URL%TYPE
            , P_DEPT_CONTROL_YN             IN HRM_CORP_MASTER.DEPT_CONTROL_YN%TYPE
            , P_DUTY_CONTROL_YN             IN HRM_CORP_MASTER.DUTY_CONTROL_YN%TYPE
            , P_PAY_CONTROL_YN              IN HRM_CORP_MASTER.PAY_CONTROL_YN%TYPE
            , P_DEFAULT_FLAG                IN HRM_CORP_MASTER.DEFAULT_FLAG%TYPE
            , P_VENDOR_ID                   IN HRM_CORP_MASTER.VENDOR_ID%TYPE
            , P_BENEFIT_RATE                IN HRM_CORP_MASTER.BENEFIT_RATE%TYPE
            , P_RETIREMENT_PENSION_BANK     IN HRM_CORP_MASTER.RETIREMENT_PENSION_BANK%TYPE
            , P_RETIREMENT_PENSION_ACCOUNT  IN HRM_CORP_MASTER.RETIREMENT_PENSION_ACCOUNT%TYPE
            , P_ENABLED_FLAG                IN HRM_CORP_MASTER.ENABLED_FLAG%TYPE
            , P_EFFECTIVE_DATE_FR           IN HRM_CORP_MASTER.EFFECTIVE_DATE_FR%TYPE
            , P_EFFECTIVE_DATE_TO           IN HRM_CORP_MASTER.EFFECTIVE_DATE_TO%TYPE
            , P_DESCRIPTION                 IN HRM_CORP_MASTER.DESCRIPTION%TYPE 
            , P_USER_ID                     IN HRM_CORP_MASTER.LAST_UPDATED_BY%TYPE
            );

---------------------------------------------------------------------------------------------------
-- 업체 및 사업장 기본 정보.
---------------------------------------------------------------------------------------------------
  PROCEDURE SELECT_CORP_INFO
	          ( P_CURSOR1                           OUT TYPES.TCURSOR1
						, P_CORP_ID                           IN NUMBER
						, P_SOB_ID                            IN NUMBER
						, P_ORG_ID                            IN NUMBER
						);
            
---------------------------------------------------------------------------------------------------
-- 전산매체 생성 기본 정보.
---------------------------------------------------------------------------------------------------
  PROCEDURE SELECT_REPORT_FILE_INFO
	          ( P_CURSOR1                           OUT TYPES.TCURSOR1
						, P_CORP_ID                           IN NUMBER
						, P_SOB_ID                            IN NUMBER
						, P_ORG_ID                            IN NUMBER
            , P_CONNECT_PERSON_ID                 IN NUMBER
						);

-- 기본사항 저장 반영.
  PROCEDURE UPDATE_REPORT_FILE_INFO
	          ( W_CORP_ID                           IN NUMBER
						, P_SOB_ID                            IN NUMBER
						, P_ORG_ID                            IN NUMBER
            , P_CORP_NAME                         IN VARCHAR2
            , P_PRESIDENT_NAME                    IN VARCHAR2
            , P_LEGAL_NUMBER                      IN VARCHAR2 
						);
            
            
            
-- 업체명 RETURN.
  FUNCTION CORP_NAME_F
            ( W_CORP_ID              IN HRM_CORP_MASTER.CORP_ID%TYPE
            ) RETURN VARCHAR2;

-----------------------------------------------------------------------------------------
-- 업체 기본 ID값 리턴.
  FUNCTION DEFAULT_CORP_ID_F
            ( W_SOB_ID             IN HRM_CORP_MASTER.SOB_ID%TYPE
            , W_ORG_ID             IN HRM_CORP_MASTER.ORG_ID%TYPE
            ) RETURN NUMBER;
            
-- 업체 기본값 리턴 - GROUP CODE..
  PROCEDURE DEFAULT_CORP
            ( W_DEPT_CONTROL_YN    IN HRM_CORP_MASTER.DEPT_CONTROL_YN%TYPE DEFAULT NULL
            , W_DUTY_CONTROL_YN    IN HRM_CORP_MASTER.DUTY_CONTROL_YN%TYPE DEFAULT NULL
            , W_PAY_CONTROL_YN     IN HRM_CORP_MASTER.PAY_CONTROL_YN%TYPE DEFAULT NULL
            , W_ENABLED_FLAG_YN    IN HRM_CORP_MASTER.ENABLED_FLAG%TYPE DEFAULT 'Y'
            , W_SOB_ID             IN HRM_CORP_MASTER.SOB_ID%TYPE
            , W_ORG_ID             IN HRM_CORP_MASTER.ORG_ID%TYPE            
            , O_CORP_ID            OUT HRM_CORP_MASTER.CORP_ID%TYPE
            , O_CORP_NAME          OUT HRM_CORP_MASTER.CORP_NAME%TYPE
            , O_DEPT_CONTROL_LEVEL OUT HRM_CORP_MASTER.DEPT_CONTROL_LEVEL%TYPE
            );

-- 업체 기본값 리턴 - GROUP CODE..
  PROCEDURE DEFAULT_CORP_1
	          ( W_DEPT_CONTROL_YN    IN HRM_CORP_MASTER.DEPT_CONTROL_YN%TYPE DEFAULT NULL
						, W_DUTY_CONTROL_YN    IN HRM_CORP_MASTER.DUTY_CONTROL_YN%TYPE DEFAULT NULL
						, W_PAY_CONTROL_YN     IN HRM_CORP_MASTER.PAY_CONTROL_YN%TYPE DEFAULT NULL
						, W_ENABLED_FLAG_YN    IN HRM_CORP_MASTER.ENABLED_FLAG%TYPE DEFAULT 'Y'
            , W_SOB_ID             IN HRM_CORP_MASTER.SOB_ID%TYPE
						, W_ORG_ID             IN HRM_CORP_MASTER.ORG_ID%TYPE            
						, O_CORP_ID            OUT HRM_CORP_MASTER.CORP_ID%TYPE
						, O_CORP_NAME          OUT HRM_CORP_MASTER.CORP_NAME%TYPE
						, O_DEPT_CONTROL_LEVEL OUT NUMBER 
            , O_CORP_TYPE          OUT HRM_CORP_MASTER.CORP_TYPE%TYPE
						);
                        
-- 업체 기본값 리턴 - GROUP CODE..
  PROCEDURE DV_CORP_NAME_P
            ( W_DEPT_CONTROL_YN    IN HRM_CORP_MASTER.DEPT_CONTROL_YN%TYPE DEFAULT NULL
            , W_DUTY_CONTROL_YN    IN HRM_CORP_MASTER.DUTY_CONTROL_YN%TYPE DEFAULT NULL
            , W_PAY_CONTROL_YN     IN HRM_CORP_MASTER.PAY_CONTROL_YN%TYPE DEFAULT NULL
            , W_ENABLED_FLAG_YN    IN HRM_CORP_MASTER.ENABLED_FLAG%TYPE DEFAULT 'Y'
            , W_SOB_ID             IN HRM_CORP_MASTER.SOB_ID%TYPE
            , W_ORG_ID             IN HRM_CORP_MASTER.ORG_ID%TYPE            
            , O_CORP_ID            OUT HRM_CORP_MASTER.CORP_ID%TYPE
            , O_CORP_NAME          OUT HRM_CORP_MASTER.CORP_NAME%TYPE
            , O_CORP_TYPE          OUT HRM_CORP_MASTER.CORP_TYPE%TYPE
            );


---------------------------------------------------------------------------------------------------
-- LOOK UP CORP SELECT.
  PROCEDURE LU_CORP  
	          ( P_CURSOR3            OUT TYPES.TCURSOR3
						, W_DEPT_CONTROL_YN    IN HRM_CORP_MASTER.DEPT_CONTROL_YN%TYPE DEFAULT NULL
						, W_DUTY_CONTROL_YN    IN HRM_CORP_MASTER.DUTY_CONTROL_YN%TYPE DEFAULT NULL
						, W_PAY_CONTROL_YN     IN HRM_CORP_MASTER.PAY_CONTROL_YN%TYPE DEFAULT NULL
						, W_ENABLED_FLAG       IN HRM_CORP_MASTER.ENABLED_FLAG%TYPE DEFAULT 'Y'
						, W_SOB_ID             IN HRM_CORP_MASTER.SOB_ID%TYPE
						, W_ORG_ID             IN HRM_CORP_MASTER.ORG_ID%TYPE
						);   
            
-- LOOK UP CORP SELECT.
  PROCEDURE LU_CORP_ALL  
	          ( P_CURSOR3            OUT TYPES.TCURSOR3
						, W_ENABLED_FLAG       IN HRM_CORP_MASTER.ENABLED_FLAG%TYPE DEFAULT 'Y'
						, W_SOB_ID             IN HRM_CORP_MASTER.SOB_ID%TYPE
						, W_ORG_ID             IN HRM_CORP_MASTER.ORG_ID%TYPE
						);   
            
-- LOOK UP CORP SELECT.
  PROCEDURE LU_CORP_ETC 
	          ( P_CURSOR3            OUT TYPES.TCURSOR3
						, W_ENABLED_FLAG       IN HRM_CORP_MASTER.ENABLED_FLAG%TYPE DEFAULT 'Y'
						, W_SOB_ID             IN HRM_CORP_MASTER.SOB_ID%TYPE
						, W_ORG_ID             IN HRM_CORP_MASTER.ORG_ID%TYPE
						);               
                        
                        
-- LOOK UP CORP SELECT.
  PROCEDURE LU_SELECT
            ( P_CURSOR3            OUT TYPES.TCURSOR3
            , W_CORP_ID            IN HRM_CORP_MASTER.CORP_ID%TYPE
            , W_DEPT_CONTROL_YN    IN HRM_CORP_MASTER.DEPT_CONTROL_YN%TYPE DEFAULT NULL
            , W_DUTY_CONTROL_YN    IN HRM_CORP_MASTER.DUTY_CONTROL_YN%TYPE DEFAULT NULL
            , W_PAY_CONTROL_YN     IN HRM_CORP_MASTER.PAY_CONTROL_YN%TYPE DEFAULT NULL
            , W_ENABLED_FLAG_YN    IN HRM_CORP_MASTER.ENABLED_FLAG%TYPE DEFAULT 'Y'
            , W_SOB_ID             IN HRM_CORP_MASTER.SOB_ID%TYPE
            , W_ORG_ID             IN HRM_CORP_MASTER.ORG_ID%TYPE
            );


-- 룩업 : 인사마스터 등록 - 사업장까지 포함해서 조회.
  PROCEDURE LU_SELECT_1
	          ( P_CURSOR3            OUT TYPES.TCURSOR3
						, W_CORP_ID            IN HRM_CORP_MASTER.CORP_ID%TYPE
						, W_DEPT_CONTROL_YN    IN HRM_CORP_MASTER.DEPT_CONTROL_YN%TYPE DEFAULT NULL
						, W_DUTY_CONTROL_YN    IN HRM_CORP_MASTER.DUTY_CONTROL_YN%TYPE DEFAULT NULL
						, W_PAY_CONTROL_YN     IN HRM_CORP_MASTER.PAY_CONTROL_YN%TYPE DEFAULT NULL
						, W_ENABLED_FLAG_YN    IN HRM_CORP_MASTER.ENABLED_FLAG%TYPE DEFAULT 'Y'
						, W_SOB_ID             IN HRM_CORP_MASTER.SOB_ID%TYPE
						, W_ORG_ID             IN HRM_CORP_MASTER.ORG_ID%TYPE
						);

-- 룩업 : 자사이외 업체 조회 룩업.
  PROCEDURE LU_SELECT_5
	          ( P_CURSOR3            OUT TYPES.TCURSOR3
						, W_CORP_ID            IN HRM_CORP_MASTER.CORP_ID%TYPE
						, W_DEPT_CONTROL_YN    IN HRM_CORP_MASTER.DEPT_CONTROL_YN%TYPE DEFAULT NULL
						, W_DUTY_CONTROL_YN    IN HRM_CORP_MASTER.DUTY_CONTROL_YN%TYPE DEFAULT NULL
						, W_PAY_CONTROL_YN     IN HRM_CORP_MASTER.PAY_CONTROL_YN%TYPE DEFAULT NULL
						, W_ENABLED_FLAG_YN    IN HRM_CORP_MASTER.ENABLED_FLAG%TYPE DEFAULT 'Y'
						, W_SOB_ID             IN HRM_CORP_MASTER.SOB_ID%TYPE
						, W_ORG_ID             IN HRM_CORP_MASTER.ORG_ID%TYPE
						);

-- LOOK UP CORP SELECT.
  PROCEDURE LU_CORP_TYPE_4
            ( P_CURSOR3            OUT TYPES.TCURSOR3
            , W_ENABLED_FLAG_YN    IN HRM_CORP_MASTER.ENABLED_FLAG%TYPE DEFAULT 'Y'
            , W_SOB_ID             IN HRM_CORP_MASTER.SOB_ID%TYPE
            , W_ORG_ID             IN HRM_CORP_MASTER.ORG_ID%TYPE
            );
            

-- LOOK UP CORP SELECT[2011-11-11]
   PROCEDURE LU_CORP_ALL_SELECT
           ( P_CURSOR3  OUT TYPES.TCURSOR3
           , W_SOB_ID   IN  HRM_CORP_MASTER.SOB_ID%TYPE
           , W_ORG_ID   IN  HRM_CORP_MASTER.ORG_ID%TYPE
           );

-- LOOK UP 업체타입에 따른 업체리스트.
  PROCEDURE LU_CORPORATION_CORP_TYPE
            ( P_CURSOR3            OUT TYPES.TCURSOR3
            , W_CORP_TYPE          IN HRM_CORP_MASTER.CORP_TYPE%TYPE
            , W_DEPT_CONTROL_YN    IN HRM_CORP_MASTER.DEPT_CONTROL_YN%TYPE DEFAULT NULL
            , W_DUTY_CONTROL_YN    IN HRM_CORP_MASTER.DUTY_CONTROL_YN%TYPE DEFAULT NULL
            , W_PAY_CONTROL_YN     IN HRM_CORP_MASTER.PAY_CONTROL_YN%TYPE DEFAULT NULL
            , W_ENABLED_FLAG_YN    IN HRM_CORP_MASTER.ENABLED_FLAG%TYPE DEFAULT 'Y'
            , W_SOB_ID             IN HRM_CORP_MASTER.SOB_ID%TYPE
            , W_ORG_ID             IN HRM_CORP_MASTER.ORG_ID%TYPE
            ); 
                                                          
END HRM_CORP_MASTER_G;


 
/
CREATE OR REPLACE PACKAGE BODY HRM_CORP_MASTER_G
AS
/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRM_CORP_MASTER_G
/* Description  : 인사시스템의 업체정보 관리 패키지
/*
/* Reference by : 업체정보 관리.
/* Program History :
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
-- CORP SELECT.
  PROCEDURE DATA_SELECT
	          ( P_CURSOR             OUT TYPES.TCURSOR
						, W_CORP_ID            IN HRM_CORP_MASTER.CORP_ID%TYPE
						, W_SOB_ID             IN HRM_CORP_MASTER.SOB_ID%TYPE
						, W_ORG_ID             IN HRM_CORP_MASTER.ORG_ID%TYPE
            , W_ENABLED_FLAG       IN HRM_CORP_MASTER.ENABLED_FLAG%TYPE
						)
  AS
  BEGIN
		OPEN P_CURSOR FOR
			SELECT CM.CORP_ID
          , CM.CORP_CODE 
					, CM.CORP_NAME
					, CM.CORP_NAME_S
					, CM.LEGAL_NUMBER
					, CM.PRESIDENT_NAME
					, CM.ZIP_CODE
					, CM.ADDR1
					, CM.ADDR2
					, CM.CORP_CATEGORY
					, HRM_COMMON_G.CODE_NAME_F('CORP_CATEGORY', CM.CORP_CATEGORY, W_SOB_ID, W_ORG_ID) CORP_CATEGORY_NAME
					, CM.CORP_TYPE
					, HRM_COMMON_G.CODE_NAME_F('CORP_TYPE', CM.CORP_TYPE, W_SOB_ID, W_ORG_ID) CORP_TYPE_NAME
					, CM.CORP_SORT_NUM
					, CM.PERSON_CHARGE_NAME
					, CM.TEL_NUMBER
					, CM.FAX_NUMBER
					, CM.EMAIL
					, CM.HOMEPAGE_URL
					, CM.DEPT_CONTROL_YN
					, CM.DEPT_CONTROL_LEVEL
					, CM.DUTY_CONTROL_YN
					, CM.PAY_CONTROL_YN
					, CM.DEFAULT_FLAG
					, CM.ENABLED_FLAG
					, CM.EFFECTIVE_DATE_FR
					, CM.EFFECTIVE_DATE_TO
					, CM.VENDOR_ID
          , SC.SUPP_CUST_NAME AS VENDOR_NAME
          , CM.BENEFIT_RATE
          , CM.RETIREMENT_PENSION_BANK
          , CM.RETIREMENT_PENSION_ACCOUNT          
			FROM HRM_CORP_MASTER CM
         , FI_SUPP_CUST_V SC
			WHERE CM.VENDOR_ID             = SC.SUPP_CUST_ID(+)
        AND CM.CORP_ID               = NVL(W_CORP_ID, CM.CORP_ID)
				AND CM.SOB_ID                = W_SOB_ID
				AND CM.ORG_ID                = W_ORG_ID
        AND ((W_ENABLED_FLAG         != 'Y' AND 1 = 1)
        OR   (W_ENABLED_FLAG         = 'Y' AND CM.ENABLED_FLAG = W_ENABLED_FLAG))
      ORDER BY CM.CORP_SORT_NUM
			;

  END DATA_SELECT;

-- CORP INSERT..
  PROCEDURE DATA_INSERT
	          ( P_CORP_ID                     OUT HRM_CORP_MASTER.CORP_ID%TYPE
            , P_SOB_ID                      IN HRM_CORP_MASTER.SOB_ID%TYPE
						, P_ORG_ID                      IN HRM_CORP_MASTER.ORG_ID%TYPE
						, P_CORP_CODE                   OUT HRM_CORP_MASTER.CORP_CODE%TYPE 
            , P_CORP_NAME                   IN HRM_CORP_MASTER.CORP_NAME%TYPE
						, P_CORP_NAME_S                 IN HRM_CORP_MASTER.CORP_NAME_S%TYPE
						, P_LEGAL_NUMBER                IN HRM_CORP_MASTER.LEGAL_NUMBER%TYPE
						, P_PRESIDENT_NAME              IN HRM_CORP_MASTER.PRESIDENT_NAME%TYPE
						, P_ZIP_CODE                    IN HRM_CORP_MASTER.ZIP_CODE%TYPE
						, P_ADDR1                       IN HRM_CORP_MASTER.ADDR1%TYPE
						, P_ADDR2                       IN HRM_CORP_MASTER.ADDR2%TYPE
						, P_CORP_CATEGORY               IN HRM_CORP_MASTER.CORP_CATEGORY%TYPE
						, P_CORP_TYPE                   IN HRM_CORP_MASTER.CORP_TYPE%TYPE
						, P_CORP_SORT_NUM               IN HRM_CORP_MASTER.CORP_SORT_NUM%TYPE
						, P_PERSON_CHARGE_NAME          IN HRM_CORP_MASTER.PERSON_CHARGE_NAME%TYPE
						, P_TEL_NUMBER                  IN HRM_CORP_MASTER.TEL_NUMBER%TYPE
						, P_FAX_NUMBER                  IN HRM_CORP_MASTER.FAX_NUMBER%TYPE
						, P_EMAIL                       IN HRM_CORP_MASTER.EMAIL%TYPE
						, P_HOMEPAGE_URL                IN HRM_CORP_MASTER.HOMEPAGE_URL%TYPE
						, P_DEPT_CONTROL_YN             IN HRM_CORP_MASTER.DEPT_CONTROL_YN%TYPE
						, P_DUTY_CONTROL_YN             IN HRM_CORP_MASTER.DUTY_CONTROL_YN%TYPE
						, P_PAY_CONTROL_YN              IN HRM_CORP_MASTER.PAY_CONTROL_YN%TYPE
						, P_DEFAULT_FLAG                IN HRM_CORP_MASTER.DEFAULT_FLAG%TYPE
						, P_VENDOR_ID                   IN HRM_CORP_MASTER.VENDOR_ID%TYPE
            , P_BENEFIT_RATE                IN HRM_CORP_MASTER.BENEFIT_RATE%TYPE
            , P_RETIREMENT_PENSION_BANK     IN HRM_CORP_MASTER.RETIREMENT_PENSION_BANK%TYPE
            , P_RETIREMENT_PENSION_ACCOUNT  IN HRM_CORP_MASTER.RETIREMENT_PENSION_ACCOUNT%TYPE
            , P_ENABLED_FLAG                IN HRM_CORP_MASTER.ENABLED_FLAG%TYPE
						, P_EFFECTIVE_DATE_FR           IN HRM_CORP_MASTER.EFFECTIVE_DATE_FR%TYPE
						, P_EFFECTIVE_DATE_TO           IN HRM_CORP_MASTER.EFFECTIVE_DATE_TO%TYPE
            , P_DESCRIPTION                 IN HRM_CORP_MASTER.DESCRIPTION%TYPE 
						, P_USER_ID                     IN HRM_CORP_MASTER.CREATED_BY%TYPE
						)
  AS
	  D_SYSDATE                      DATE;
  BEGIN
	  D_SYSDATE := GET_LOCAL_DATE(P_SOB_ID);
	  
    -- 업체코드 -- 
    P_CORP_CODE := HRM_MASTER_NUM_G.MASTER_NUM_F
                      ( W_MASTER_TYPE   => 'CORP_CODE' 
                      , W_SOB_ID        => P_SOB_ID 
                      , W_ORG_ID        => P_ORG_ID  
                      , P_STD_DATE      => TRUNC(D_SYSDATE) 
                      , P_USER_ID       => P_USER_ID 
                      );
                      
    SELECT HRM_CORP_MASTER_S1.NEXTVAL
      INTO P_CORP_ID
      FROM DUAL;
    
		INSERT INTO HRM_CORP_MASTER
		( CORP_ID
    , SOB_ID
    , ORG_ID
		, CORP_CODE 
    , CORP_NAME
    , CORP_NAME_S
		, LEGAL_NUMBER
    , PRESIDENT_NAME
		, ZIP_CODE
    , ADDR1
    , ADDR2
		, CORP_CATEGORY
    , CORP_TYPE
		, CORP_SORT_NUM
		, PERSON_CHARGE_NAME
    , TEL_NUMBER
    , FAX_NUMBER
    , EMAIL
    , HOMEPAGE_URL
		, DEPT_CONTROL_YN
    , DUTY_CONTROL_YN
    , PAY_CONTROL_YN
		, DEFAULT_FLAG
		, VENDOR_ID
    , BENEFIT_RATE
    , RETIREMENT_PENSION_BANK 
    , RETIREMENT_PENSION_ACCOUNT
		, ENABLED_FLAG
    , EFFECTIVE_DATE_FR
    , EFFECTIVE_DATE_TO 
    , DESCRIPTION 
		, CREATION_DATE
    , CREATED_BY
    , LAST_UPDATE_DATE
    , LAST_UPDATED_BY
    ) VALUES
		( P_CORP_ID
    , P_SOB_ID
    , P_ORG_ID
		, P_CORP_CODE
    , P_CORP_NAME
    , P_CORP_NAME_S
		, P_LEGAL_NUMBER
    , P_PRESIDENT_NAME
		, P_ZIP_CODE
    , P_ADDR1
    , P_ADDR2
		, P_CORP_CATEGORY
    , P_CORP_TYPE
		, P_CORP_SORT_NUM
		, P_PERSON_CHARGE_NAME
    , P_TEL_NUMBER
    , P_FAX_NUMBER
    , P_EMAIL
    , P_HOMEPAGE_URL
		, NVL(P_DEPT_CONTROL_YN, 'N')
    , NVL(P_DUTY_CONTROL_YN, 'N')
    , NVL(P_PAY_CONTROL_YN, 'N')
		, NVL(P_DEFAULT_FLAG, 'N')
		, P_VENDOR_ID
    , P_BENEFIT_RATE
    , P_RETIREMENT_PENSION_BANK
    , P_RETIREMENT_PENSION_ACCOUNT
		, NVL(P_ENABLED_FLAG, 'N')
    , TRUNC(P_EFFECTIVE_DATE_FR)
    , TRUNC(P_EFFECTIVE_DATE_TO)
    , P_DESCRIPTION 
		, D_SYSDATE
    , P_USER_ID
    , D_SYSDATE
    , P_USER_ID     
    );
  END DATA_INSERT;

-- CORP UPDATE.
  PROCEDURE DATA_UPDATE
            ( W_CORP_ID                     IN HRM_CORP_MASTER.CORP_ID%TYPE
            , P_SOB_ID                      IN HRM_CORP_MASTER.SOB_ID%TYPE
						, P_ORG_ID                      IN HRM_CORP_MASTER.ORG_ID%TYPE
            , P_CORP_NAME                   IN HRM_CORP_MASTER.CORP_NAME%TYPE
            , P_CORP_NAME_S                 IN HRM_CORP_MASTER.CORP_NAME_S%TYPE
            , P_LEGAL_NUMBER                IN HRM_CORP_MASTER.LEGAL_NUMBER%TYPE
            , P_PRESIDENT_NAME              IN HRM_CORP_MASTER.PRESIDENT_NAME%TYPE
            , P_ZIP_CODE                    IN HRM_CORP_MASTER.ZIP_CODE%TYPE
            , P_ADDR1                       IN HRM_CORP_MASTER.ADDR1%TYPE
            , P_ADDR2                       IN HRM_CORP_MASTER.ADDR2%TYPE
            , P_CORP_CATEGORY               IN HRM_CORP_MASTER.CORP_CATEGORY%TYPE
            , P_CORP_TYPE                   IN HRM_CORP_MASTER.CORP_TYPE%TYPE
            , P_CORP_SORT_NUM               IN HRM_CORP_MASTER.CORP_SORT_NUM%TYPE
            , P_PERSON_CHARGE_NAME          IN HRM_CORP_MASTER.PERSON_CHARGE_NAME%TYPE
            , P_TEL_NUMBER                  IN HRM_CORP_MASTER.TEL_NUMBER%TYPE
            , P_FAX_NUMBER                  IN HRM_CORP_MASTER.FAX_NUMBER%TYPE
            , P_EMAIL                       IN HRM_CORP_MASTER.EMAIL%TYPE
            , P_HOMEPAGE_URL                IN HRM_CORP_MASTER.HOMEPAGE_URL%TYPE
            , P_DEPT_CONTROL_YN             IN HRM_CORP_MASTER.DEPT_CONTROL_YN%TYPE
            , P_DUTY_CONTROL_YN             IN HRM_CORP_MASTER.DUTY_CONTROL_YN%TYPE
            , P_PAY_CONTROL_YN              IN HRM_CORP_MASTER.PAY_CONTROL_YN%TYPE
            , P_DEFAULT_FLAG                IN HRM_CORP_MASTER.DEFAULT_FLAG%TYPE
            , P_VENDOR_ID                   IN HRM_CORP_MASTER.VENDOR_ID%TYPE
            , P_BENEFIT_RATE                IN HRM_CORP_MASTER.BENEFIT_RATE%TYPE
            , P_RETIREMENT_PENSION_BANK     IN HRM_CORP_MASTER.RETIREMENT_PENSION_BANK%TYPE
            , P_RETIREMENT_PENSION_ACCOUNT  IN HRM_CORP_MASTER.RETIREMENT_PENSION_ACCOUNT%TYPE
            , P_ENABLED_FLAG                IN HRM_CORP_MASTER.ENABLED_FLAG%TYPE
            , P_EFFECTIVE_DATE_FR           IN HRM_CORP_MASTER.EFFECTIVE_DATE_FR%TYPE
            , P_EFFECTIVE_DATE_TO           IN HRM_CORP_MASTER.EFFECTIVE_DATE_TO%TYPE
            , P_DESCRIPTION                 IN HRM_CORP_MASTER.DESCRIPTION%TYPE 
            , P_USER_ID                     IN HRM_CORP_MASTER.LAST_UPDATED_BY%TYPE
            )
  AS
  BEGIN
    UPDATE HRM_CORP_MASTER CM
      SET CM.CORP_NAME                  = P_CORP_NAME
        , CM.CORP_NAME_S                = P_CORP_NAME_S
        , CM.LEGAL_NUMBER               = P_LEGAL_NUMBER
        , CM.PRESIDENT_NAME             = P_PRESIDENT_NAME
        , CM.ZIP_CODE                   = P_ZIP_CODE
        , CM.ADDR1                      = P_ADDR1
        , CM.ADDR2                      = P_ADDR2
        , CM.CORP_CATEGORY              = P_CORP_CATEGORY
        , CM.CORP_TYPE                  = P_CORP_TYPE
        , CM.CORP_SORT_NUM              = P_CORP_SORT_NUM
        , CM.PERSON_CHARGE_NAME         = P_PERSON_CHARGE_NAME
        , CM.TEL_NUMBER                 = P_TEL_NUMBER
        , CM.FAX_NUMBER                 = P_FAX_NUMBER
        , CM.EMAIL                      = P_EMAIL
        , CM.HOMEPAGE_URL               = P_HOMEPAGE_URL
        , CM.DEPT_CONTROL_YN            = NVL(P_DEPT_CONTROL_YN, 'N')
        , CM.DUTY_CONTROL_YN            = NVL(P_DUTY_CONTROL_YN, 'N')
        , CM.PAY_CONTROL_YN             = NVL(P_PAY_CONTROL_YN, 'N')
        , CM.DEFAULT_FLAG               = NVL(P_DEFAULT_FLAG, 'N')
        , CM.VENDOR_ID                  = P_VENDOR_ID
        , CM.BENEFIT_RATE               = P_BENEFIT_RATE
        , CM.RETIREMENT_PENSION_BANK    = P_RETIREMENT_PENSION_BANK
        , CM.RETIREMENT_PENSION_ACCOUNT = P_RETIREMENT_PENSION_ACCOUNT
        , CM.ENABLED_FLAG               = NVL(P_ENABLED_FLAG, 'N')
        , CM.EFFECTIVE_DATE_FR          = TRUNC(P_EFFECTIVE_DATE_FR)
        , CM.EFFECTIVE_DATE_TO          = TRUNC(P_EFFECTIVE_DATE_TO)
        , CM.DESCRIPTION                = P_DESCRIPTION 
        , CM.LAST_UPDATE_DATE           = GET_LOCAL_DATE(CM.SOB_ID)
        , CM.LAST_UPDATED_BY            = P_USER_ID
        
    WHERE CM.CORP_ID                    = W_CORP_ID
    ;
  END DATA_UPDATE;


---------------------------------------------------------------------------------------------------
-- 업체 및 사업장 기본 정보.
---------------------------------------------------------------------------------------------------
  PROCEDURE SELECT_CORP_INFO
	          ( P_CURSOR1                           OUT TYPES.TCURSOR1
						, P_CORP_ID                           IN NUMBER
						, P_SOB_ID                            IN NUMBER
						, P_ORG_ID                            IN NUMBER
						)
  AS
  BEGIN
    OPEN P_CURSOR1 FOR
      SELECT CM.CORP_NAME       -- 법인.
          , CM.PRESIDENT_NAME   -- 대표자.
          , CM.LEGAL_NUMBER
          , HOU.VAT_NUMBER       -- 사업자번호.
          , CM.ADDR1 || ' ' || CM.ADDR2 AS ADDRESS
          , HOU.TAX_OFFICE_CODE  -- 관할세무서.
          , HOU.TAX_OFFICE_NAME  -- 관할세무서명.
          , CM.TEL_NUMBER       -- 전화번호.
          , CM.FAX_NUMBER
          , CM.EMAIL
          , CM.CORP_ID
      FROM HRM_CORP_MASTER CM
          , ( SELECT OU.CORP_ID
                   , OU.VAT_NUMBER        
                   , OU.TAX_OFFICE_CODE
                   , OU.TAX_OFFICE_NAME
                   , OU.TEL_NUMBER  
                FROM HRM_OPERATING_UNIT OU
              WHERE OU.CORP_ID        = P_CORP_ID
                AND OU.SOB_ID         = P_SOB_ID
                AND OU.ORG_ID         = P_ORG_ID
                AND (OU.DEFAULT_FLAG  = 'Y'
                OR ROWNUM             <= 1)
             ) HOU
      WHERE CM.CORP_ID            = HOU.CORP_ID(+)
        AND CM.CORP_ID            = P_CORP_ID
        AND CM.SOB_ID             = P_SOB_ID
        AND CM.ORG_ID             = P_ORG_ID
     ;
  END SELECT_CORP_INFO;

---------------------------------------------------------------------------------------------------
-- 전산매체 생성 기본 정보.
---------------------------------------------------------------------------------------------------
  PROCEDURE SELECT_REPORT_FILE_INFO
	          ( P_CURSOR1                           OUT TYPES.TCURSOR1
						, P_CORP_ID                           IN NUMBER
						, P_SOB_ID                            IN NUMBER
						, P_ORG_ID                            IN NUMBER
            , P_CONNECT_PERSON_ID                 IN NUMBER
						)
  AS
  BEGIN
    OPEN P_CURSOR1 FOR
      SELECT CM.CORP_NAME       -- 법인.
          , CM.PRESIDENT_NAME   -- 대표자.
          , CM.LEGAL_NUMBER
          , CM.TEL_NUMBER
          , CM.ZIP_CODE
          , CM.ADDR1 || ' '  || CM.ADDR2 AS ADDRESS 
          , NULL AS TAX_AGENT             -- 세무대리인 관리번호.
          , '9000' AS TAX_PROGRAM_CODE    -- 세무프로그램코드.
          , '101' AS USE_LANGUAGE_CODE    -- 사용한글코드.
          , S_PM.NAME           -- 담당자명.
          , S_PM.DEPT_NAME      -- 담당자부서.          
          , CM.CORP_ID
      FROM HRM_CORP_MASTER CM
        , ( SELECT PM.PERSON_ID
                , PM.NAME
                , PM.DEPT_NAME
              FROM HRM_PERSON_MASTER_V1 PM
            WHERE PM.PERSON_ID  = P_CONNECT_PERSON_ID
          ) S_PM
      WHERE P_CONNECT_PERSON_ID   = S_PM.PERSON_ID
        AND CM.CORP_ID            = P_CORP_ID
        AND CM.SOB_ID             = P_SOB_ID
        AND CM.ORG_ID             = P_ORG_ID
      ;
  END SELECT_REPORT_FILE_INFO;

-- 기본사항 저장 반영.
  PROCEDURE UPDATE_REPORT_FILE_INFO
	          ( W_CORP_ID                           IN NUMBER
						, P_SOB_ID                            IN NUMBER
						, P_ORG_ID                            IN NUMBER
            , P_CORP_NAME                         IN VARCHAR2
            , P_PRESIDENT_NAME                    IN VARCHAR2
            , P_LEGAL_NUMBER                      IN VARCHAR2 
						)
  AS
    V_TAX_REG_NO          VARCHAR2(15);
  BEGIN
    UPDATE HRM_CORP_MASTER CM
      SET CM.CORP_NAME          = P_CORP_NAME
        , CM.PRESIDENT_NAME     = P_PRESIDENT_NAME
        , CM.LEGAL_NUMBER       = P_LEGAL_NUMBER 
    WHERE CM.CORP_ID            = W_CORP_ID
    ;
  END UPDATE_REPORT_FILE_INFO;
  
    
              

-- 업체명 RETURN.
  FUNCTION CORP_NAME_F
          ( W_CORP_ID              IN HRM_CORP_MASTER.CORP_ID%TYPE
          ) RETURN VARCHAR2
  AS
    V_CORP_NAME                    HRM_CORP_MASTER.CORP_NAME%TYPE;
  BEGIN
     BEGIN
       SELECT CM.CORP_NAME
         INTO V_CORP_NAME
         FROM HRM_CORP_MASTER CM
       WHERE CM.CORP_ID             = W_CORP_ID
       ;
    EXCEPTION WHEN OTHERS THEN
       V_CORP_NAME := NULL;
    END;
    RETURN V_CORP_NAME;
  END CORP_NAME_F;
 
-----------------------------------------------------------------------------------------
-- 업체 기본 ID값 리턴.
  FUNCTION DEFAULT_CORP_ID_F
            ( W_SOB_ID             IN HRM_CORP_MASTER.SOB_ID%TYPE
            , W_ORG_ID             IN HRM_CORP_MASTER.ORG_ID%TYPE
            ) RETURN NUMBER
  AS
    V_CORP_ID                      NUMBER := NULL;
  BEGIN
    BEGIN
      SELECT SX1.CORP_ID    
        INTO V_CORP_ID
        FROM (SELECT CM.CORP_ID  
                   , CM.CORP_NAME  
                FROM HRM_CORP_MASTER CM
              WHERE CM.SOB_ID                 = W_SOB_ID
                AND CM.ORG_ID                 = W_ORG_ID
                AND CM.DEFAULT_FLAG           = 'Y'    
                AND CM.ENABLED_FLAG           = 'Y'
                AND CM.EFFECTIVE_DATE_FR      <= TRUNC(GET_LOCAL_DATE(W_SOB_ID))
                AND (CM.EFFECTIVE_DATE_TO IS NULL OR CM.EFFECTIVE_DATE_TO >= TRUNC(GET_LOCAL_DATE(W_SOB_ID)))
              ORDER BY CM.CORP_SORT_NUM
             ) SX1
      WHERE ROWNUM                      <= 1
      ;
    EXCEPTION WHEN OTHERS THEN
      V_CORP_ID := NULL;
    END;
    RETURN V_CORP_ID;
  END DEFAULT_CORP_ID_F;
  
-- 업체 기본값 리턴 - GROUP CODE..
  PROCEDURE DEFAULT_CORP
            ( W_DEPT_CONTROL_YN    IN HRM_CORP_MASTER.DEPT_CONTROL_YN%TYPE DEFAULT NULL
            , W_DUTY_CONTROL_YN    IN HRM_CORP_MASTER.DUTY_CONTROL_YN%TYPE DEFAULT NULL
            , W_PAY_CONTROL_YN     IN HRM_CORP_MASTER.PAY_CONTROL_YN%TYPE DEFAULT NULL
            , W_ENABLED_FLAG_YN    IN HRM_CORP_MASTER.ENABLED_FLAG%TYPE DEFAULT 'Y'
            , W_SOB_ID             IN HRM_CORP_MASTER.SOB_ID%TYPE
            , W_ORG_ID             IN HRM_CORP_MASTER.ORG_ID%TYPE
            , O_CORP_ID            OUT HRM_CORP_MASTER.CORP_ID%TYPE
            , O_CORP_NAME          OUT HRM_CORP_MASTER.CORP_NAME%TYPE
            , O_DEPT_CONTROL_LEVEL OUT HRM_CORP_MASTER.DEPT_CONTROL_LEVEL%TYPE
            )
  AS
    V_STD_DATE                     HRM_CORP_MASTER.EFFECTIVE_DATE_FR%TYPE := NULL;
  
  BEGIN
    IF W_ENABLED_FLAG_YN = 'Y' THEN
      V_STD_DATE := GET_LOCAL_DATE(W_SOB_ID);
    ELSE
      V_STD_DATE := NULL;
    END IF;
    
    BEGIN
      SELECT CM.CORP_ID
           , CM.CORP_NAME
           , CM.DEPT_CONTROL_LEVEL
        INTO O_CORP_ID, O_CORP_NAME, O_DEPT_CONTROL_LEVEL   
        FROM (SELECT CM.CORP_ID
                  , CM.CORP_NAME
                  , CM.DEPT_CONTROL_LEVEL      
                FROM HRM_CORP_MASTER CM
              WHERE CM.DEPT_CONTROL_YN        = NVL(W_DEPT_CONTROL_YN, CM.DEPT_CONTROL_YN)
                AND CM.DUTY_CONTROL_YN        = NVL(W_DUTY_CONTROL_YN, CM.DUTY_CONTROL_YN)
                AND CM.PAY_CONTROL_YN         = NVL(W_PAY_CONTROL_YN, CM.PAY_CONTROL_YN)
                AND CM.SOB_ID                 = W_SOB_ID
                AND CM.ORG_ID                 = W_ORG_ID
                AND CM.DEFAULT_FLAG           = 'Y'
                AND CM.ENABLED_FLAG           = DECODE(W_ENABLED_FLAG_YN, 'Y', 'Y', CM.ENABLED_FLAG)
                AND CM.EFFECTIVE_DATE_FR      <= NVL(V_STD_DATE, CM.EFFECTIVE_DATE_FR)
                AND (CM.EFFECTIVE_DATE_TO IS NULL OR CM.EFFECTIVE_DATE_TO >= NVL(V_STD_DATE, CM.EFFECTIVE_DATE_TO))
              ORDER BY CM.CORP_ID
             ) CM      
      WHERE ROWNUM                    <= 1  
      ;
    EXCEPTION WHEN OTHERS THEN
      O_CORP_ID := NULL;
      O_CORP_NAME := NULL;
      O_DEPT_CONTROL_LEVEL := NULL;
    END;
  END DEFAULT_CORP;

-- 업체 기본값 리턴 - GROUP CODE..
  PROCEDURE DEFAULT_CORP_1
	          ( W_DEPT_CONTROL_YN    IN HRM_CORP_MASTER.DEPT_CONTROL_YN%TYPE DEFAULT NULL
						, W_DUTY_CONTROL_YN    IN HRM_CORP_MASTER.DUTY_CONTROL_YN%TYPE DEFAULT NULL
						, W_PAY_CONTROL_YN     IN HRM_CORP_MASTER.PAY_CONTROL_YN%TYPE DEFAULT NULL
						, W_ENABLED_FLAG_YN    IN HRM_CORP_MASTER.ENABLED_FLAG%TYPE DEFAULT 'Y'
            , W_SOB_ID             IN HRM_CORP_MASTER.SOB_ID%TYPE
						, W_ORG_ID             IN HRM_CORP_MASTER.ORG_ID%TYPE            
						, O_CORP_ID            OUT HRM_CORP_MASTER.CORP_ID%TYPE
						, O_CORP_NAME          OUT HRM_CORP_MASTER.CORP_NAME%TYPE
						, O_DEPT_CONTROL_LEVEL OUT NUMBER 
            , O_CORP_TYPE          OUT HRM_CORP_MASTER.CORP_TYPE%TYPE
						)
  AS
    V_STD_DATE                     HRM_CORP_MASTER.EFFECTIVE_DATE_FR%TYPE := NULL;
  BEGIN
	  IF W_ENABLED_FLAG_YN = 'Y' THEN
		  V_STD_DATE := GET_LOCAL_DATE(W_SOB_ID);
		ELSE
		  V_STD_DATE := NULL;
		END IF;
    
    BEGIN
      SELECT SX1.CORP_ID
           , SX1.CORP_NAME
           , NULL AS DEPT_CONTROL_LEVEL
           , SX1.CORP_TYPE
        INTO O_CORP_ID
           , O_CORP_NAME
           , O_DEPT_CONTROL_LEVEL
           , O_CORP_TYPE
        FROM (SELECT CM.CORP_ID
                  , CM.CORP_NAME
                  , CM.CORP_TYPE 
                FROM HRM_CORP_MASTER CM
              WHERE CM.DEPT_CONTROL_YN        = NVL(W_DEPT_CONTROL_YN, CM.DEPT_CONTROL_YN)
                AND CM.DUTY_CONTROL_YN        = NVL(W_DUTY_CONTROL_YN, CM.DUTY_CONTROL_YN)
                AND CM.PAY_CONTROL_YN         = NVL(W_PAY_CONTROL_YN, CM.PAY_CONTROL_YN)
                AND CM.SOB_ID                 = W_SOB_ID
                AND CM.ORG_ID                 = W_ORG_ID
                AND CM.DEFAULT_FLAG           = 'Y'
                AND CM.ENABLED_FLAG           = DECODE(W_ENABLED_FLAG_YN, 'Y', 'Y', CM.ENABLED_FLAG)
                AND CM.EFFECTIVE_DATE_FR      <= NVL(V_STD_DATE, CM.EFFECTIVE_DATE_FR)
                AND (CM.EFFECTIVE_DATE_TO IS NULL OR CM.EFFECTIVE_DATE_TO >= NVL(V_STD_DATE, CM.EFFECTIVE_DATE_TO))
              ORDER BY CM.CORP_ID
             ) SX1      
      WHERE ROWNUM                    <= 1  
      ;
    EXCEPTION WHEN OTHERS THEN
      O_CORP_ID := NULL;
      O_CORP_NAME := NULL;
      O_CORP_TYPE := NULL;
    END;
  END DEFAULT_CORP_1;
  
  
-- 업체 기본값 리턴 - GROUP CODE..
  PROCEDURE DV_CORP_NAME_P
            ( W_DEPT_CONTROL_YN    IN HRM_CORP_MASTER.DEPT_CONTROL_YN%TYPE DEFAULT NULL
            , W_DUTY_CONTROL_YN    IN HRM_CORP_MASTER.DUTY_CONTROL_YN%TYPE DEFAULT NULL
            , W_PAY_CONTROL_YN     IN HRM_CORP_MASTER.PAY_CONTROL_YN%TYPE DEFAULT NULL
            , W_ENABLED_FLAG_YN    IN HRM_CORP_MASTER.ENABLED_FLAG%TYPE DEFAULT 'Y'
            , W_SOB_ID             IN HRM_CORP_MASTER.SOB_ID%TYPE
            , W_ORG_ID             IN HRM_CORP_MASTER.ORG_ID%TYPE            
            , O_CORP_ID            OUT HRM_CORP_MASTER.CORP_ID%TYPE
            , O_CORP_NAME          OUT HRM_CORP_MASTER.CORP_NAME%TYPE
            , O_CORP_TYPE          OUT HRM_CORP_MASTER.CORP_TYPE%TYPE
            )
  AS
    V_STD_DATE                     HRM_CORP_MASTER.EFFECTIVE_DATE_FR%TYPE := NULL;
  BEGIN
    IF W_ENABLED_FLAG_YN = 'Y' THEN
      V_STD_DATE := GET_LOCAL_DATE(W_SOB_ID);
    ELSE
      V_STD_DATE := NULL;
    END IF;
    
    BEGIN
      SELECT CM.CORP_ID
           , CM.CORP_NAME
           , CM.CORP_TYPE
        INTO O_CORP_ID, O_CORP_NAME, O_CORP_TYPE   
        FROM (SELECT CM.CORP_ID
                  , CM.CORP_NAME
                  , CM.CORP_TYPE      
                FROM HRM_CORP_MASTER CM
              WHERE CM.DEPT_CONTROL_YN        = NVL(W_DEPT_CONTROL_YN, CM.DEPT_CONTROL_YN)
                AND CM.DUTY_CONTROL_YN        = NVL(W_DUTY_CONTROL_YN, CM.DUTY_CONTROL_YN)
                AND CM.PAY_CONTROL_YN         = NVL(W_PAY_CONTROL_YN, CM.PAY_CONTROL_YN)
                AND CM.SOB_ID                 = W_SOB_ID
                AND CM.ORG_ID                 = W_ORG_ID
                AND CM.DEFAULT_FLAG           = 'Y'
                AND CM.ENABLED_FLAG           = DECODE(W_ENABLED_FLAG_YN, 'Y', 'Y', CM.ENABLED_FLAG)
                AND CM.EFFECTIVE_DATE_FR      <= NVL(V_STD_DATE, CM.EFFECTIVE_DATE_FR)
                AND (CM.EFFECTIVE_DATE_TO IS NULL OR CM.EFFECTIVE_DATE_TO >= NVL(V_STD_DATE, CM.EFFECTIVE_DATE_TO))
              ORDER BY CM.CORP_ID
             ) CM      
      WHERE ROWNUM                    <= 1  
      ;
    EXCEPTION WHEN OTHERS THEN
      O_CORP_ID := NULL;
      O_CORP_NAME := NULL;
      O_CORP_TYPE := NULL;
    END;
  END DV_CORP_NAME_P;
  
  
---------------------------------------------------------------------------------------------------
-- LOOK UP CORP SELECT.
  PROCEDURE LU_CORP  
	          ( P_CURSOR3            OUT TYPES.TCURSOR3
						, W_DEPT_CONTROL_YN    IN HRM_CORP_MASTER.DEPT_CONTROL_YN%TYPE DEFAULT NULL
						, W_DUTY_CONTROL_YN    IN HRM_CORP_MASTER.DUTY_CONTROL_YN%TYPE DEFAULT NULL
						, W_PAY_CONTROL_YN     IN HRM_CORP_MASTER.PAY_CONTROL_YN%TYPE DEFAULT NULL
						, W_ENABLED_FLAG       IN HRM_CORP_MASTER.ENABLED_FLAG%TYPE DEFAULT 'Y'
						, W_SOB_ID             IN HRM_CORP_MASTER.SOB_ID%TYPE
						, W_ORG_ID             IN HRM_CORP_MASTER.ORG_ID%TYPE
						)
  AS
    V_STD_DATE            DATE := NULL;
  BEGIN
	  IF W_ENABLED_FLAG = 'Y' THEN
		  V_STD_DATE := TRUNC(GET_LOCAL_DATE(W_SOB_ID));
		ELSE
		  V_STD_DATE := NULL;
		END IF;
		
		OPEN P_CURSOR3 FOR
			SELECT CM.CORP_NAME 
           , CM.CORP_CODE 
					 , CM.CORP_ID
					 , CM.CORP_TYPE 
			FROM HRM_CORP_MASTER CM
			WHERE CM.DEPT_CONTROL_YN       = NVL(W_DEPT_CONTROL_YN, CM.DEPT_CONTROL_YN)
				AND CM.DUTY_CONTROL_YN       = NVL(W_DUTY_CONTROL_YN, CM.DUTY_CONTROL_YN)
				AND CM.PAY_CONTROL_YN        = NVL(W_PAY_CONTROL_YN, CM.PAY_CONTROL_YN)
				AND CM.SOB_ID                = W_SOB_ID
				AND CM.ORG_ID                = W_ORG_ID
				AND CM.ENABLED_FLAG          = DECODE(W_ENABLED_FLAG, 'Y', 'Y', CM.ENABLED_FLAG)
				AND CM.EFFECTIVE_DATE_FR     <= NVL(V_STD_DATE, CM.EFFECTIVE_DATE_FR)
				AND (CM.EFFECTIVE_DATE_TO IS NULL OR CM.EFFECTIVE_DATE_TO >= NVL(V_STD_DATE, CM.EFFECTIVE_DATE_TO))
      ORDER BY CM.CORP_SORT_NUM
		 ;
  END LU_CORP;   
  
-- LOOK UP CORP SELECT.
  PROCEDURE LU_CORP_ALL  
	          ( P_CURSOR3            OUT TYPES.TCURSOR3
						, W_ENABLED_FLAG       IN HRM_CORP_MASTER.ENABLED_FLAG%TYPE DEFAULT 'Y'
						, W_SOB_ID             IN HRM_CORP_MASTER.SOB_ID%TYPE
						, W_ORG_ID             IN HRM_CORP_MASTER.ORG_ID%TYPE
						)
  AS
    V_STD_DATE            DATE := NULL;
  BEGIN
	  IF W_ENABLED_FLAG = 'Y' THEN
		  V_STD_DATE := TRUNC(GET_LOCAL_DATE(W_SOB_ID));
		ELSE
		  V_STD_DATE := NULL;
		END IF;
    
    OPEN P_CURSOR3 FOR
      SELECT CM.CORP_NAME
          , CM.CORP_CODE 
          , CM.CORP_TYPE 
          , CM.CORP_ID
        FROM HRM_CORP_MASTER CM
      WHERE CM.SOB_ID                =  W_SOB_ID
        AND CM.ORG_ID                =  W_ORG_ID
        AND CM.ENABLED_FLAG          = DECODE(W_ENABLED_FLAG, 'Y', 'Y', CM.ENABLED_FLAG)
				AND CM.EFFECTIVE_DATE_FR     <= NVL(V_STD_DATE, CM.EFFECTIVE_DATE_FR)
				AND (CM.EFFECTIVE_DATE_TO IS NULL OR CM.EFFECTIVE_DATE_TO >= NVL(V_STD_DATE, CM.EFFECTIVE_DATE_TO))
      ORDER BY CM.CORP_SORT_NUM
      ;
  END LU_CORP_ALL;

            
-- LOOK UP CORP SELECT.
  PROCEDURE LU_CORP_ETC 
	          ( P_CURSOR3            OUT TYPES.TCURSOR3
						, W_ENABLED_FLAG       IN HRM_CORP_MASTER.ENABLED_FLAG%TYPE DEFAULT 'Y'
						, W_SOB_ID             IN HRM_CORP_MASTER.SOB_ID%TYPE
						, W_ORG_ID             IN HRM_CORP_MASTER.ORG_ID%TYPE
						)
  AS
    V_STD_DATE            DATE := NULL;
  BEGIN
	  IF W_ENABLED_FLAG = 'Y' THEN
		  V_STD_DATE := TRUNC(GET_LOCAL_DATE(W_SOB_ID));
		ELSE
		  V_STD_DATE := NULL;
		END IF;
    
    OPEN P_CURSOR3 FOR
      SELECT CM.CORP_NAME
          , CM.CORP_CODE 
          , CM.CORP_TYPE 
          , CM.CORP_ID
        FROM HRM_CORP_MASTER CM
      WHERE CM.SOB_ID                =  W_SOB_ID
        AND CM.ORG_ID                =  W_ORG_ID
        AND CM.CORP_TYPE             != '1' 
        AND CM.ENABLED_FLAG          = DECODE(W_ENABLED_FLAG, 'Y', 'Y', CM.ENABLED_FLAG)
				AND CM.EFFECTIVE_DATE_FR     <= NVL(V_STD_DATE, CM.EFFECTIVE_DATE_FR)
				AND (CM.EFFECTIVE_DATE_TO IS NULL OR CM.EFFECTIVE_DATE_TO >= NVL(V_STD_DATE, CM.EFFECTIVE_DATE_TO))
      ORDER BY CM.CORP_SORT_NUM
      ;
  END LU_CORP_ETC;
     
-- LOOK UP CORP SELECT.
  PROCEDURE LU_SELECT
            ( P_CURSOR3            OUT TYPES.TCURSOR3
            , W_CORP_ID            IN HRM_CORP_MASTER.CORP_ID%TYPE
            , W_DEPT_CONTROL_YN    IN HRM_CORP_MASTER.DEPT_CONTROL_YN%TYPE DEFAULT NULL
            , W_DUTY_CONTROL_YN    IN HRM_CORP_MASTER.DUTY_CONTROL_YN%TYPE DEFAULT NULL
            , W_PAY_CONTROL_YN     IN HRM_CORP_MASTER.PAY_CONTROL_YN%TYPE DEFAULT NULL
            , W_ENABLED_FLAG_YN    IN HRM_CORP_MASTER.ENABLED_FLAG%TYPE DEFAULT 'Y'
            , W_SOB_ID             IN HRM_CORP_MASTER.SOB_ID%TYPE
            , W_ORG_ID             IN HRM_CORP_MASTER.ORG_ID%TYPE
            )
  AS
    V_STD_DATE                     HRM_CORP_MASTER.EFFECTIVE_DATE_FR%TYPE := NULL;
  
  BEGIN
    IF W_ENABLED_FLAG_YN = 'Y' THEN
      V_STD_DATE := GET_LOCAL_DATE(W_SOB_ID);
    ELSE
      V_STD_DATE := NULL;
    END IF;
  
    OPEN P_CURSOR3 FOR
      SELECT CM.CORP_NAME
          , CM.CORP_ID
          , CM.CORP_TYPE
          , CM.DEPT_CONTROL_LEVEL
        FROM HRM_CORP_MASTER CM
      WHERE CM.CORP_ID               = NVL(W_CORP_ID, CM.CORP_ID)
        AND CM.DEPT_CONTROL_YN       = NVL(W_DEPT_CONTROL_YN, CM.DEPT_CONTROL_YN)
        AND CM.DUTY_CONTROL_YN       = NVL(W_DUTY_CONTROL_YN, CM.DUTY_CONTROL_YN)
        AND CM.PAY_CONTROL_YN        = NVL(W_PAY_CONTROL_YN, CM.PAY_CONTROL_YN)
        AND CM.SOB_ID                = W_SOB_ID
        AND CM.ORG_ID                = W_ORG_ID
        AND CM.ENABLED_FLAG          = DECODE(W_ENABLED_FLAG_YN, 'Y', 'Y', CM.ENABLED_FLAG)
        AND CM.EFFECTIVE_DATE_FR     <= NVL(V_STD_DATE, CM.EFFECTIVE_DATE_FR)
        AND (CM.EFFECTIVE_DATE_TO IS NULL OR CM.EFFECTIVE_DATE_TO >= NVL(V_STD_DATE, CM.EFFECTIVE_DATE_TO))
      ORDER BY CM.CORP_SORT_NUM
      ;
  END LU_SELECT;                                           

-- 룩업 : 인사마스터 등록 - 사업장까지 포함해서 조회.
  PROCEDURE LU_SELECT_1
	          ( P_CURSOR3            OUT TYPES.TCURSOR3
						, W_CORP_ID            IN HRM_CORP_MASTER.CORP_ID%TYPE
						, W_DEPT_CONTROL_YN    IN HRM_CORP_MASTER.DEPT_CONTROL_YN%TYPE DEFAULT NULL
						, W_DUTY_CONTROL_YN    IN HRM_CORP_MASTER.DUTY_CONTROL_YN%TYPE DEFAULT NULL
						, W_PAY_CONTROL_YN     IN HRM_CORP_MASTER.PAY_CONTROL_YN%TYPE DEFAULT NULL
						, W_ENABLED_FLAG_YN    IN HRM_CORP_MASTER.ENABLED_FLAG%TYPE DEFAULT 'Y'
						, W_SOB_ID             IN HRM_CORP_MASTER.SOB_ID%TYPE
						, W_ORG_ID             IN HRM_CORP_MASTER.ORG_ID%TYPE
						)
  AS
    V_STD_DATE                     HRM_CORP_MASTER.EFFECTIVE_DATE_FR%TYPE := NULL;
  BEGIN
	  IF W_ENABLED_FLAG_YN = 'Y' THEN
		  V_STD_DATE := GET_LOCAL_DATE(W_SOB_ID);
		ELSE
		  V_STD_DATE := NULL;
		END IF;
		
		OPEN P_CURSOR3 FOR
			SELECT CM.CORP_NAME
					 , CM.CORP_ID
					 , CM.CORP_TYPE
					 , NULL AS DEPT_CONTROL_LEVEL
           , (SELECT OU.OPERATING_UNIT_ID
                FROM HRM_OPERATING_UNIT OU
              WHERE OU.CORP_ID         = CM.CORP_ID
                AND OU.SOB_ID          = CM.SOB_ID
                AND OU.ORG_ID          = CM.ORG_ID
                AND OU.ENABLED_FLAG         = DECODE(W_ENABLED_FLAG_YN, 'Y', 'Y', OU.ENABLED_FLAG)
                AND OU.EFFECTIVE_DATE_FR    <= NVL(V_STD_DATE, OU.EFFECTIVE_DATE_FR)
                AND (OU.EFFECTIVE_DATE_TO   >= NVL(V_STD_DATE, OU.EFFECTIVE_DATE_TO) OR OU.EFFECTIVE_DATE_TO IS NULL)
                AND (OU.DEFAULT_FLAG        = 'Y'
                OR  ROWNUM                  <= 1)) AS OPERATING_UNIT_ID
           , (SELECT OU.OPERATING_UNIT_NAME
                FROM HRM_OPERATING_UNIT OU
              WHERE OU.CORP_ID         = CM.CORP_ID
                AND OU.SOB_ID          = CM.SOB_ID
                AND OU.ORG_ID          = CM.ORG_ID
                AND OU.ENABLED_FLAG         = DECODE(W_ENABLED_FLAG_YN, 'Y', 'Y', OU.ENABLED_FLAG)
                AND OU.EFFECTIVE_DATE_FR    <= NVL(V_STD_DATE, OU.EFFECTIVE_DATE_FR)
                AND (OU.EFFECTIVE_DATE_TO   >= NVL(V_STD_DATE, OU.EFFECTIVE_DATE_TO) OR OU.EFFECTIVE_DATE_TO IS NULL)
                AND (OU.DEFAULT_FLAG        = 'Y'
                OR  ROWNUM                  <= 1)) AS OPERATING_UNIT_NAME
			FROM HRM_CORP_MASTER CM
			WHERE CM.CORP_ID               = NVL(W_CORP_ID, CM.CORP_ID)
				AND CM.DEPT_CONTROL_YN       = NVL(W_DEPT_CONTROL_YN, CM.DEPT_CONTROL_YN)
				AND CM.DUTY_CONTROL_YN       = NVL(W_DUTY_CONTROL_YN, CM.DUTY_CONTROL_YN)
				AND CM.PAY_CONTROL_YN        = NVL(W_PAY_CONTROL_YN, CM.PAY_CONTROL_YN)
				AND CM.SOB_ID                = W_SOB_ID
				AND CM.ORG_ID                = W_ORG_ID
				AND CM.ENABLED_FLAG          = DECODE(W_ENABLED_FLAG_YN, 'Y', 'Y', CM.ENABLED_FLAG)
				AND CM.EFFECTIVE_DATE_FR     <= NVL(V_STD_DATE, CM.EFFECTIVE_DATE_FR)
				AND (CM.EFFECTIVE_DATE_TO IS NULL OR CM.EFFECTIVE_DATE_TO >= NVL(V_STD_DATE, CM.EFFECTIVE_DATE_TO))
     ORDER BY CM.CORP_SORT_NUM
		 ;
  END LU_SELECT_1;

-- 룩업 : 자사이외 업체 조회 룩업.
  PROCEDURE LU_SELECT_5
	          ( P_CURSOR3            OUT TYPES.TCURSOR3
						, W_CORP_ID            IN HRM_CORP_MASTER.CORP_ID%TYPE
						, W_DEPT_CONTROL_YN    IN HRM_CORP_MASTER.DEPT_CONTROL_YN%TYPE DEFAULT NULL
						, W_DUTY_CONTROL_YN    IN HRM_CORP_MASTER.DUTY_CONTROL_YN%TYPE DEFAULT NULL
						, W_PAY_CONTROL_YN     IN HRM_CORP_MASTER.PAY_CONTROL_YN%TYPE DEFAULT NULL
						, W_ENABLED_FLAG_YN    IN HRM_CORP_MASTER.ENABLED_FLAG%TYPE DEFAULT 'Y'
						, W_SOB_ID             IN HRM_CORP_MASTER.SOB_ID%TYPE
						, W_ORG_ID             IN HRM_CORP_MASTER.ORG_ID%TYPE
						)
  AS
    V_STD_DATE                     HRM_CORP_MASTER.EFFECTIVE_DATE_FR%TYPE := NULL;
  BEGIN
	  IF W_ENABLED_FLAG_YN = 'Y' THEN
		  V_STD_DATE := GET_LOCAL_DATE(W_SOB_ID);
		ELSE
		  V_STD_DATE := NULL;
		END IF;
    
    OPEN P_CURSOR3 FOR
      SELECT CM.CORP_NAME
					 , CM.CORP_ID
					 , CM.CORP_TYPE
					 , NULL AS DEPT_CONTROL_LEVEL
           , (SELECT OU.OPERATING_UNIT_ID
                FROM HRM_OPERATING_UNIT OU
              WHERE OU.CORP_ID         = CM.CORP_ID
                AND OU.SOB_ID          = CM.SOB_ID
                AND OU.ORG_ID          = CM.ORG_ID
                AND OU.ENABLED_FLAG         = DECODE(W_ENABLED_FLAG_YN, 'Y', 'Y', OU.ENABLED_FLAG)
                AND OU.EFFECTIVE_DATE_FR    <= NVL(V_STD_DATE, OU.EFFECTIVE_DATE_FR)
                AND (OU.EFFECTIVE_DATE_TO   >= NVL(V_STD_DATE, OU.EFFECTIVE_DATE_TO) OR OU.EFFECTIVE_DATE_TO IS NULL)
                AND (OU.DEFAULT_FLAG        = 'Y'
                OR  ROWNUM                  <= 1)) AS OPERATING_UNIT_ID
           , (SELECT OU.OPERATING_UNIT_NAME
                FROM HRM_OPERATING_UNIT OU
              WHERE OU.CORP_ID         = CM.CORP_ID
                AND OU.SOB_ID          = CM.SOB_ID
                AND OU.ORG_ID          = CM.ORG_ID
                AND OU.ENABLED_FLAG         = DECODE(W_ENABLED_FLAG_YN, 'Y', 'Y', OU.ENABLED_FLAG)
                AND OU.EFFECTIVE_DATE_FR    <= NVL(V_STD_DATE, OU.EFFECTIVE_DATE_FR)
                AND (OU.EFFECTIVE_DATE_TO   >= NVL(V_STD_DATE, OU.EFFECTIVE_DATE_TO) OR OU.EFFECTIVE_DATE_TO IS NULL)
                AND (OU.DEFAULT_FLAG        = 'Y'
                OR  ROWNUM                  <= 1)) AS OPERATING_UNIT_NAME
			FROM HRM_CORP_MASTER CM
			WHERE CM.CORP_ID               = NVL(W_CORP_ID, CM.CORP_ID)
        AND CM.CORP_TYPE             != '1'
				AND CM.DEPT_CONTROL_YN       = NVL(W_DEPT_CONTROL_YN, CM.DEPT_CONTROL_YN)
				AND CM.DUTY_CONTROL_YN       = NVL(W_DUTY_CONTROL_YN, CM.DUTY_CONTROL_YN)
				AND CM.PAY_CONTROL_YN        = NVL(W_PAY_CONTROL_YN, CM.PAY_CONTROL_YN)
				AND CM.SOB_ID                = W_SOB_ID
				AND CM.ORG_ID                = W_ORG_ID
				AND CM.ENABLED_FLAG          = DECODE(W_ENABLED_FLAG_YN, 'Y', 'Y', CM.ENABLED_FLAG)
				AND CM.EFFECTIVE_DATE_FR     <= NVL(V_STD_DATE, CM.EFFECTIVE_DATE_FR)
				AND (CM.EFFECTIVE_DATE_TO IS NULL OR CM.EFFECTIVE_DATE_TO >= NVL(V_STD_DATE, CM.EFFECTIVE_DATE_TO))
     ORDER BY CM.CORP_SORT_NUM
		 ;
  END LU_SELECT_5;

-- LOOK UP CORP SELECT.
  PROCEDURE LU_CORP_TYPE_4
            ( P_CURSOR3            OUT TYPES.TCURSOR3
            , W_ENABLED_FLAG_YN    IN HRM_CORP_MASTER.ENABLED_FLAG%TYPE DEFAULT 'Y'
            , W_SOB_ID             IN HRM_CORP_MASTER.SOB_ID%TYPE
            , W_ORG_ID             IN HRM_CORP_MASTER.ORG_ID%TYPE
            )
  AS
    V_STD_DATE                     HRM_CORP_MASTER.EFFECTIVE_DATE_FR%TYPE := NULL;
  BEGIN
    IF W_ENABLED_FLAG_YN = 'Y' THEN
      V_STD_DATE := GET_LOCAL_DATE(W_SOB_ID);
    ELSE
      V_STD_DATE := NULL;
    END IF;
  
    OPEN P_CURSOR3 FOR
      SELECT CM.CORP_NAME
          , CM.CORP_ID
          , CM.DEPT_CONTROL_LEVEL
        FROM HRM_CORP_MASTER CM
      WHERE CM.SOB_ID                = W_SOB_ID
        AND CM.ORG_ID                = W_ORG_ID
        AND CM.CORP_TYPE             <> '1'
        AND CM.ENABLED_FLAG          = DECODE(W_ENABLED_FLAG_YN, 'Y', 'Y', CM.ENABLED_FLAG)
        AND CM.EFFECTIVE_DATE_FR     <= NVL(V_STD_DATE, CM.EFFECTIVE_DATE_FR)
        AND (CM.EFFECTIVE_DATE_TO IS NULL OR CM.EFFECTIVE_DATE_TO >= NVL(V_STD_DATE, CM.EFFECTIVE_DATE_TO))
      ORDER BY CM.CORP_SORT_NUM
      ;
    
  END LU_CORP_TYPE_4;
  
-- LOOK UP CORP SELECT[2011-11-11]
  PROCEDURE LU_CORP_ALL_SELECT
           ( P_CURSOR3  OUT TYPES.TCURSOR3
           , W_SOB_ID   IN  HRM_CORP_MASTER.SOB_ID%TYPE
           , W_ORG_ID   IN  HRM_CORP_MASTER.ORG_ID%TYPE
           )
  AS
  BEGIN
    OPEN P_CURSOR3 FOR
      SELECT CM.CORP_NAME
          , CM.CORP_TYPE
          , CM.DEPT_CONTROL_LEVEL
          , CM.CORP_ID
        FROM HRM_CORP_MASTER CM
      WHERE CM.SOB_ID    =  W_SOB_ID
        AND CM.ORG_ID    =  W_ORG_ID
      ORDER BY CM.CORP_SORT_NUM
      ;
  END LU_CORP_ALL_SELECT;

-- LOOK UP 업체타입에 따른 업체리스트.
  PROCEDURE LU_CORPORATION_CORP_TYPE
            ( P_CURSOR3            OUT TYPES.TCURSOR3
            , W_CORP_TYPE          IN HRM_CORP_MASTER.CORP_TYPE%TYPE
            , W_DEPT_CONTROL_YN    IN HRM_CORP_MASTER.DEPT_CONTROL_YN%TYPE DEFAULT NULL
            , W_DUTY_CONTROL_YN    IN HRM_CORP_MASTER.DUTY_CONTROL_YN%TYPE DEFAULT NULL
            , W_PAY_CONTROL_YN     IN HRM_CORP_MASTER.PAY_CONTROL_YN%TYPE DEFAULT NULL
            , W_ENABLED_FLAG_YN    IN HRM_CORP_MASTER.ENABLED_FLAG%TYPE DEFAULT 'Y'
            , W_SOB_ID             IN HRM_CORP_MASTER.SOB_ID%TYPE
            , W_ORG_ID             IN HRM_CORP_MASTER.ORG_ID%TYPE
            )
  AS
    V_STD_DATE                     HRM_CORP_MASTER.EFFECTIVE_DATE_FR%TYPE := NULL;
  BEGIN
    IF W_ENABLED_FLAG_YN = 'Y' THEN
      V_STD_DATE := GET_LOCAL_DATE(W_SOB_ID);
    ELSE
      V_STD_DATE := NULL;
    END IF;
  
    OPEN P_CURSOR3 FOR
      SELECT CM.CORP_NAME
          , CM.CORP_ID
          , CM.CORP_TYPE
          , CM.DEPT_CONTROL_LEVEL
        FROM HRM_CORP_MASTER CM
      WHERE CM.CORP_TYPE             = W_CORP_TYPE
        AND CM.DEPT_CONTROL_YN       = NVL(W_DEPT_CONTROL_YN, CM.DEPT_CONTROL_YN)
        AND CM.DUTY_CONTROL_YN       = NVL(W_DUTY_CONTROL_YN, CM.DUTY_CONTROL_YN)
        AND CM.PAY_CONTROL_YN        = NVL(W_PAY_CONTROL_YN, CM.PAY_CONTROL_YN)
        AND CM.SOB_ID                = W_SOB_ID
        AND CM.ORG_ID                = W_ORG_ID
        AND CM.ENABLED_FLAG          = DECODE(W_ENABLED_FLAG_YN, 'Y', 'Y', CM.ENABLED_FLAG)
        AND CM.EFFECTIVE_DATE_FR     <= NVL(V_STD_DATE, CM.EFFECTIVE_DATE_FR)
        AND (CM.EFFECTIVE_DATE_TO IS NULL OR CM.EFFECTIVE_DATE_TO >= NVL(V_STD_DATE, CM.EFFECTIVE_DATE_TO))
      ORDER BY CM.CORP_SORT_NUM
      ;   
  END LU_CORPORATION_CORP_TYPE;
    
END HRM_CORP_MASTER_G;
/
