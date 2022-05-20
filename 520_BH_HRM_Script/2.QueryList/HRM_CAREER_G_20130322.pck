CREATE OR REPLACE PACKAGE HRM_CAREER_G
AS

-- DATA_SELECT.
  PROCEDURE DATA_SELECT(P_CURSOR                                    OUT TYPES.TCURSOR
                      , W_PERSON_ID                                 IN NUMBER);

-- DATA_INSERT.
  PROCEDURE DATA_INSERT(P_PERSON_ID                                 IN NUMBER
											, P_COMPANY_NAME                              IN VARCHAR2
											, P_DEPT_NAME                                 IN VARCHAR2
											, P_POST_NAME                                 IN VARCHAR2
											, P_JOB_NAME                                  IN VARCHAR2
											, P_START_DATE                                IN DATE
											, P_END_DATE                                  IN DATE
											, P_CAREER_START_DATE                         IN DATE
											, P_CAREER_END_DATE                           IN DATE
                      , P_CAREER_YEAR_COUNT                         IN NUMBER
											, P_RETIRE_DESCRIPTION                        IN VARCHAR2
											, P_ZIP_CODE                                  IN VARCHAR2
											, P_ADDR1                                     IN VARCHAR2
											, P_ADDR2                                     IN VARCHAR2
											, P_DESCRIPTION                               IN VARCHAR2
											, P_USER_ID                                   IN NUMBER
											, W_SOB_ID                                    IN NUMBER
											, O_CAREER_ID                                 OUT NUMBER
											, O_CAREER_YEAR_COUNT                         OUT NUMBER);

-- DATA_UPDATE.
  PROCEDURE DATA_UPDATE(W_CAREER_ID                                 IN NUMBER
											, P_COMPANY_NAME                              IN VARCHAR2
											, P_DEPT_NAME                                 IN VARCHAR2
											, P_POST_NAME                                 IN VARCHAR2
											, P_JOB_NAME                                  IN VARCHAR2
											, P_START_DATE                                IN DATE
											, P_END_DATE                                  IN DATE
											, P_CAREER_START_DATE                         IN DATE
											, P_CAREER_END_DATE                           IN DATE
                      , P_CAREER_YEAR_COUNT                         IN NUMBER
											, P_RETIRE_DESCRIPTION                        IN VARCHAR2
											, P_ZIP_CODE                                  IN VARCHAR2
											, P_ADDR1                                     IN VARCHAR2
											, P_ADDR2                                     IN VARCHAR2
											, P_DESCRIPTION                               IN VARCHAR2
											, P_USER_ID                                   IN NUMBER
											, W_SOB_ID                                    IN NUMBER
											, O_CAREER_YEAR_COUNT                         OUT NUMBER);

-- DATA_DELETE..
  PROCEDURE DATA_DELETE(W_CAREER_ID                                 IN NUMBER);


-- PRINT DATA_SELECT.
  PROCEDURE PRINT_CAREER
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_PERSON_ID         IN  NUMBER
            , W_SOB_ID            IN  NUMBER
            , W_ORG_ID            IN  NUMBER
            );
                      
                      
-- 경력조회
  PROCEDURE SELECT_CAREER(P_CURSOR                           OUT TYPES.TCURSOR
                        , W_PERSON_ID                        IN NUMBER
                        , W_CORP_ID                          IN  NUMBER
                        , W_DEPT_ID                          IN  NUMBER
                        , W_EMPLOYE_TYPE                     IN VARCHAR2
                        , W_SOB_ID                           IN NUMBER
                        , W_ORG_ID                           IN NUMBER);
                        
END HRM_CAREER_G;


 
/
CREATE OR REPLACE PACKAGE BODY HRM_CAREER_G
AS

-- DATA_SELECT.
  PROCEDURE DATA_SELECT(P_CURSOR                                    OUT TYPES.TCURSOR
                      , W_PERSON_ID                                 IN NUMBER)
  AS
  BEGIN
     OPEN P_CURSOR FOR
        SELECT HC.CAREER_ID
            , HC.PERSON_ID
            , HC.COMPANY_NAME
            , HC.DEPT_NAME
            , HC.POST_NAME
            , HC.JOB_NAME
            , HC.START_DATE
            , HC.END_DATE
            , HRM_COMMON_DATE_G.PERIOD_YYYY_MM_DD_F(HC.START_DATE, HC.END_DATE, 0, 1) AS YEAR_COUNT
            , HC.CAREER_START_DATE
            , HC.CAREER_END_DATE
            , HC.CAREER_YEAR_COUNT
            , HC.RETIRE_DESCRIPTION
            , HC.ZIP_CODE
            , HC.ADDR1
            , HC.ADDR2
            , HC.DESCRIPTION
        FROM HRM_CAREER HC
        WHERE HC.PERSON_ID                                = W_PERSON_ID
        ORDER BY HC.CAREER_ID
        ;

  END DATA_SELECT;


-- DATA_INSERT.
  PROCEDURE DATA_INSERT(P_PERSON_ID                                 IN NUMBER
											, P_COMPANY_NAME                              IN VARCHAR2
											, P_DEPT_NAME                                 IN VARCHAR2
											, P_POST_NAME                                 IN VARCHAR2
											, P_JOB_NAME                                  IN VARCHAR2
											, P_START_DATE                                IN DATE
											, P_END_DATE                                  IN DATE
											, P_CAREER_START_DATE                         IN DATE
											, P_CAREER_END_DATE                           IN DATE
                      , P_CAREER_YEAR_COUNT                         IN NUMBER
											, P_RETIRE_DESCRIPTION                        IN VARCHAR2
											, P_ZIP_CODE                                  IN VARCHAR2
											, P_ADDR1                                     IN VARCHAR2
											, P_ADDR2                                     IN VARCHAR2
											, P_DESCRIPTION                               IN VARCHAR2
											, P_USER_ID                                   IN NUMBER
											, W_SOB_ID                                    IN NUMBER
											, O_CAREER_ID                                 OUT NUMBER
											, O_CAREER_YEAR_COUNT                         OUT NUMBER)
  AS
	  D_SYSDATE            DATE := GET_LOCAL_DATE(W_SOB_ID);
  BEGIN
		-- 인정경력 적용 : 수기 입력 --
    --O_CAREER_YEAR_COUNT := HRM_COMMON_DATE_G.YEAR_COUNT_F(NVL(P_CAREER_START_DATE, P_START_DATE), NVL(P_CAREER_END_DATE, P_END_DATE), 'CEIL');
    O_CAREER_YEAR_COUNT := NVL(P_CAREER_YEAR_COUNT, 0);
    
		SELECT HRM_CAREER_S1.NEXTVAL
			INTO O_CAREER_ID
		FROM DUAL;
		
		INSERT INTO HRM_CAREER
		(CAREER_ID
		, PERSON_ID, COMPANY_NAME, DEPT_NAME
		, POST_NAME, JOB_NAME
		, START_DATE, END_DATE
		, CAREER_START_DATE, CAREER_END_DATE, CAREER_YEAR_COUNT
		, RETIRE_DESCRIPTION
		, ZIP_CODE, ADDR1, ADDR2
		, DESCRIPTION
		, CREATION_DATE, CREATED_BY, LAST_UPDATE_DATE, LAST_UPDATED_BY
		) VALUES
		( O_CAREER_ID
		, P_PERSON_ID, P_COMPANY_NAME, P_DEPT_NAME
		, P_POST_NAME, P_JOB_NAME
		, TRUNC(P_START_DATE), TRUNC(P_END_DATE)
		, TRUNC(NVL(P_CAREER_START_DATE, P_START_DATE)), TRUNC(NVL(P_CAREER_END_DATE, P_END_DATE)), O_CAREER_YEAR_COUNT
		, P_RETIRE_DESCRIPTION
		, P_ZIP_CODE, P_ADDR1, P_ADDR2
		, P_DESCRIPTION
		, D_SYSDATE, P_USER_ID, D_SYSDATE, P_USER_ID
		);
      
  END DATA_INSERT;

-- DATA_UPDATE.
  PROCEDURE DATA_UPDATE(W_CAREER_ID                                 IN NUMBER
											, P_COMPANY_NAME                              IN VARCHAR2
											, P_DEPT_NAME                                 IN VARCHAR2
											, P_POST_NAME                                 IN VARCHAR2
											, P_JOB_NAME                                  IN VARCHAR2
											, P_START_DATE                                IN DATE
											, P_END_DATE                                  IN DATE
											, P_CAREER_START_DATE                         IN DATE
											, P_CAREER_END_DATE                           IN DATE
                      , P_CAREER_YEAR_COUNT                         IN NUMBER
											, P_RETIRE_DESCRIPTION                        IN VARCHAR2
											, P_ZIP_CODE                                  IN VARCHAR2
											, P_ADDR1                                     IN VARCHAR2
											, P_ADDR2                                     IN VARCHAR2
											, P_DESCRIPTION                               IN VARCHAR2
											, P_USER_ID                                   IN NUMBER
											, W_SOB_ID                                    IN NUMBER
											, O_CAREER_YEAR_COUNT                         OUT NUMBER)
  AS
    D_SYSDATE            DATE := GET_LOCAL_DATE(W_SOB_ID);
  BEGIN
    -- 인정경력 적용 : 수기 입력 --
    --O_CAREER_YEAR_COUNT := HRM_COMMON_DATE_G.YEAR_COUNT_F(P_START_DATE, P_END_DATE, 'CEIL');
    O_CAREER_YEAR_COUNT := NVL(P_CAREER_YEAR_COUNT, 0);
    
		UPDATE HRM_CAREER HC
			SET HC.COMPANY_NAME                                         = P_COMPANY_NAME
						, HC.DEPT_NAME                                        = P_DEPT_NAME
						, HC.POST_NAME                                        = P_POST_NAME
						, HC.JOB_NAME                                         = P_JOB_NAME
						, HC.START_DATE                                       = TRUNC(P_START_DATE)
						, HC.END_DATE                                         = TRUNC(P_END_DATE)
            , HC.CAREER_START_DATE                                = TRUNC(P_START_DATE)
						, HC.CAREER_END_DATE                                  = TRUNC(P_END_DATE)
						/* -- 전호수 수정 : 경력인정 날짜 사용 안함으로 입사일자/퇴사일자 기준으로 적용.
            , HC.CAREER_START_DATE                                = TRUNC(NVL(P_CAREER_START_DATE, P_START_DATE))
						, HC.CAREER_END_DATE                                  = TRUNC(NVL(P_CAREER_END_DATE, P_END_DATE))*/
						, HC.CAREER_YEAR_COUNT                                = O_CAREER_YEAR_COUNT
						, HC.RETIRE_DESCRIPTION                               = P_RETIRE_DESCRIPTION
						, HC.ZIP_CODE                                         = P_ZIP_CODE
						, HC.ADDR1                                            = P_ADDR1
						, HC.ADDR2                                            = P_ADDR2
						, HC.DESCRIPTION                                      = P_DESCRIPTION
						, HC.LAST_UPDATE_DATE                                 = D_SYSDATE
						, HC.LAST_UPDATED_BY                                  = P_USER_ID
		WHERE HC.CAREER_ID                                            = W_CAREER_ID
		;
      
  END DATA_UPDATE;

-- DATA_DELETE..
  PROCEDURE DATA_DELETE(W_CAREER_ID                                 IN NUMBER)
  AS
  BEGIN
		DELETE HRM_CAREER HC
		WHERE HC.CAREER_ID                                            = W_CAREER_ID
		;
  
  END DATA_DELETE;


-- PRINT DATA_SELECT.
  PROCEDURE PRINT_CAREER
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_PERSON_ID         IN  NUMBER
            , W_SOB_ID            IN  NUMBER
            , W_ORG_ID            IN  NUMBER
            )
  AS
  BEGIN
    OPEN P_CURSOR FOR
      SELECT  SX1.PERSON_ID
            , SX1.COMPANY_NAME
            , SX1.DEPT_NAME
            , SX1.POST_NAME
            , SX1.JOB_NAME
            , TO_CHAR(SX1.START_DATE, 'YYYY-MM-DD') AS START_DATE
            , TO_CHAR(SX1.END_DATE, 'YYYY-MM-DD') AS END_DATE
            , TO_CHAR(SX1.START_DATE, 'YYYY-MM-DD') || '~' ||
                TO_CHAR(SX1.END_DATE, 'YYYY-MM-DD') AS WORK_PERIOD
            , SX1.YEAR_COUNT
            , TO_CHAR(SX1.CAREER_START_DATE, 'YYYY-MM-DD') AS CAREER_START_DATE
            , TO_CHAR(SX1.CAREER_END_DATE, 'YYYY-MM-DD') AS CAREER_END_DATE
            , TO_CHAR(SX1.CAREER_START_DATE, 'YYYY-MM-DD') || '~' ||
                TO_CHAR(SX1.CAREER_END_DATE, 'YYYY-MM-DD') AS CAREER_WORK_PERIOD
            , TO_CHAR(SX1.CAREER_YEAR_COUNT, 'FM999,999,999') AS CAREER_YEAR_COUNT
            , SX1.RETIRE_DESCRIPTION
            , SX1.ZIP_CODE
            , SX1.ADDR1
            , SX1.ADDR2
            , SX1.DESCRIPTION
        FROM ( SELECT HC.PERSON_ID
                    , HC.COMPANY_NAME
                    , HC.DEPT_NAME
                    , HC.POST_NAME
                    , HC.JOB_NAME
                    , HC.START_DATE
                    , HC.END_DATE
                    , HRM_COMMON_DATE_G.PERIOD_YYYY_MM_DD_F(HC.START_DATE, HC.END_DATE, 0, 1) AS YEAR_COUNT
                    , HC.CAREER_START_DATE
                    , HC.CAREER_END_DATE
                    , HC.CAREER_YEAR_COUNT
                    , HC.RETIRE_DESCRIPTION
                    , HC.ZIP_CODE
                    , HC.ADDR1
                    , HC.ADDR2
                    , HC.DESCRIPTION
                FROM HRM_CAREER HC
              WHERE HC.PERSON_ID                                = W_PERSON_ID
              ORDER BY HC.END_DATE DESC, HC.CAREER_ID DESC
            ) SX1
      WHERE ROWNUM                <= 4
      ;
  END PRINT_CAREER;
  
  
-- 경력조회
  PROCEDURE SELECT_CAREER(P_CURSOR                           OUT TYPES.TCURSOR
                         , W_PERSON_ID                        IN NUMBER
                         , W_CORP_ID                          IN  NUMBER
                         , W_DEPT_ID                          IN  NUMBER
                         , W_EMPLOYE_TYPE                     IN VARCHAR2
                         , W_SOB_ID                           IN NUMBER
                         , W_ORG_ID                           IN NUMBER
                          )
   AS
     V_CURR_DATE        DATE := TRUNC(GET_LOCAL_DATE(W_SOB_ID));
   BEGIN
     OPEN P_CURSOR FOR
       SELECT HPM.PERSON_NUM
            , HPM.NAME
            , HPM.PERSON_ID
            , HC.CAREER_ID
            , HC.COMPANY_NAME
            , HC.POST_NAME
            , HC.DEPT_NAME
            , HC.JOB_NAME
            , HC.START_DATE
            , HC.END_DATE
            , HRM_COMMON_DATE_G.PERIOD_YYYY_MM_DD_F(HC.START_DATE, HC.END_DATE, 0, 1) AS YEAR_COUNT
            , HC.CAREER_YEAR_COUNT
            , HC.RETIRE_DESCRIPTION
            , HC.ZIP_CODE
            , HC.ADDR1
            , HC.ADDR2
            , HC.DESCRIPTION
       FROM  HRM_PERSON_MASTER      HPM
            ,HRM_CAREER             HC
       WHERE HPM.PERSON_ID          = HC.PERSON_ID 
         AND HPM.PERSON_ID          = NVL(W_PERSON_ID, HPM.PERSON_ID)
         AND HPM.CORP_ID            = W_CORP_ID
         AND HPM.DEPT_ID            = NVL(W_DEPT_ID, HPM.DEPT_ID)
         AND ((W_EMPLOYE_TYPE       IS NULL AND 1 = 1)
         OR   (W_EMPLOYE_TYPE       != '2' AND HPM.EMPLOYE_TYPE = W_EMPLOYE_TYPE)
         OR   (W_EMPLOYE_TYPE       = '2' AND EXISTS
                                               ( SELECT 'X'
                                                    FROM HRM_ADMINISTRATIVE_LEAVE AL
                                                   WHERE AL.PERSON_ID     = HPM.PERSON_ID
                                                     AND AL.START_DATE    <= V_CURR_DATE
                                                     AND (AL.END_DATE      >= V_CURR_DATE OR AL.END_DATE IS NULL)
                                                )))
         AND HPM.SOB_ID             = W_SOB_ID
         AND HPM.ORG_ID             = W_ORG_ID
       ORDER BY HPM.PERSON_ID, HC.START_DATE;  
  END SELECT_CAREER;
  
END HRM_CAREER_G;
/
