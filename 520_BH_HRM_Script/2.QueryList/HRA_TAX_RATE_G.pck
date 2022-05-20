CREATE OR REPLACE PACKAGE HRA_TAX_RATE_G
AS

-- SELECT.
  PROCEDURE DATA_SELECT(P_CURSOR                            OUT TYPES.TCURSOR
											, W_TAX_YYYY                          IN HRA_TAX_RATE.TAX_YYYY%TYPE
											, W_TAX_TYPE_ID                       IN HRA_TAX_RATE.TAX_TYPE_ID%TYPE
											, W_SOB_ID                            IN HRA_TAX_RATE.SOB_ID%TYPE
											, W_ORG_ID                            IN HRA_TAX_RATE.ORG_ID%TYPE);

-- INSERT..
  PROCEDURE DATA_INSERT(P_TAX_YYYY                          IN VARCHAR2
											, P_TAX_TYPE_ID                       IN NUMBER
											, P_START_AMOUNT                      IN NUMBER
											, P_END_AMOUNT                        IN NUMBER
                      , P_TAX_RATE                          IN NUMBER
											, P_ACCUM_SUB_AMOUNT                  IN NUMBER
											, P_DESCRIPTION                       IN VARCHAR2
											, P_SOB_ID                            IN NUMBER
											, P_ORG_ID                            IN NUMBER
											, P_USER_ID                           IN NUMBER);

-- UDPATE.
  PROCEDURE DATA_UPDATE(W_TAX_RATE_ID                       IN NUMBER
											, P_START_AMOUNT                      IN NUMBER
											, P_END_AMOUNT                        IN NUMBER
                      , P_TAX_RATE                          IN NUMBER
											, P_ACCUM_SUB_AMOUNT                  IN NUMBER
											, P_DESCRIPTION                       IN VARCHAR2
											, P_USER_ID                           IN NUMBER);

-- DELETE.
  PROCEDURE DATA_DELETE(W_TAX_RATE_ID                       IN NUMBER);
  
---------------------------------------------------------------------------------------------------
-- 해당 년도 기준 정보 존재 여부 체크.
  PROCEDURE CHECK_TAX_RATE_YN
            ( W_TAX_YYYY              IN HRA_TAX_RATE.TAX_YYYY%TYPE
            , W_TAX_TYPE_ID           IN HRA_TAX_RATE.TAX_TYPE_ID%TYPE
            , W_SOB_ID                IN HRA_TAX_RATE.SOB_ID%TYPE
            , W_ORG_ID                IN HRA_TAX_RATE.ORG_ID%TYPE
            , O_CHECK_YN              OUT VARCHAR2
            );

-- 전년도 기준 정보 COPY
  PROCEDURE COPY_TAX_RATE
            ( W_TAX_YYYY              IN HRA_TAX_RATE.TAX_YYYY%TYPE
            , W_TAX_TYPE_ID           IN HRA_TAX_RATE.TAX_TYPE_ID%TYPE
            , W_SOB_ID                IN HRA_TAX_RATE.SOB_ID%TYPE
            , W_ORG_ID                IN HRA_TAX_RATE.ORG_ID%TYPE
            , P_USER_ID               IN HRA_TAX_RATE.CREATED_BY%TYPE
            , O_MESSAGE               OUT VARCHAR2
            );  
  
END HRA_TAX_RATE_G;
/
CREATE OR REPLACE PACKAGE BODY HRA_TAX_RATE_G
AS

-- SELECT.
  PROCEDURE DATA_SELECT(P_CURSOR                            OUT TYPES.TCURSOR
											, W_TAX_YYYY                          IN HRA_TAX_RATE.TAX_YYYY%TYPE
											, W_TAX_TYPE_ID                       IN HRA_TAX_RATE.TAX_TYPE_ID%TYPE
											, W_SOB_ID                            IN HRA_TAX_RATE.SOB_ID%TYPE
											, W_ORG_ID                            IN HRA_TAX_RATE.ORG_ID%TYPE)
  AS
  BEGIN
     OPEN P_CURSOR FOR
        SELECT TR.TAX_YYYY
            , TR.TAX_TYPE_ID
            , HRM_COMMON_G.ID_NAME_F(TR.TAX_TYPE_ID) TAX_TYPE_NAME
            , TR.START_AMOUNT
            , TR.END_AMOUNT
            , TR.TAX_RATE
            , TR.ACCUM_SUB_AMOUNT
            , TR.DESCRIPTION
            , TR.TAX_RATE_ID
        FROM HRA_TAX_RATE TR
        WHERE TR.TAX_YYYY                                   = W_TAX_YYYY
          AND TR.TAX_TYPE_ID                                = NVL(W_TAX_TYPE_ID, TR.TAX_TYPE_ID)
					AND TR.SOB_ID                                     = W_SOB_ID
					AND TR.ORG_ID                                     = W_ORG_ID					
        ;

  END DATA_SELECT;


-- INSERT..
  PROCEDURE DATA_INSERT(P_TAX_YYYY                          IN VARCHAR2
											, P_TAX_TYPE_ID                       IN NUMBER
											, P_START_AMOUNT                      IN NUMBER
											, P_END_AMOUNT                        IN NUMBER
                      , P_TAX_RATE                          IN NUMBER
											, P_ACCUM_SUB_AMOUNT                  IN NUMBER
											, P_DESCRIPTION                       IN VARCHAR2
											, P_SOB_ID                            IN NUMBER
											, P_ORG_ID                            IN NUMBER
											, P_USER_ID                           IN NUMBER)
  AS
    D_SYSDATE                                               DATE;
		 
  BEGIN
	  D_SYSDATE := GET_LOCAL_DATE(P_SOB_ID);
				
		INSERT INTO HRA_TAX_RATE
		(TAX_RATE_ID, TAX_YYYY, TAX_TYPE_ID
		, START_AMOUNT, END_AMOUNT, TAX_RATE, ACCUM_SUB_AMOUNT
		, DESCRIPTION
		, SOB_ID, ORG_ID
		, CREATION_DATE, CREATED_BY, LAST_UPDATE_DATE, LAST_UPDATED_BY
		) VALUES
		(HRA_TAX_RATE_S1.NEXTVAL, P_TAX_YYYY, P_TAX_TYPE_ID
		, P_START_AMOUNT, P_END_AMOUNT, P_TAX_RATE, P_ACCUM_SUB_AMOUNT
		, P_DESCRIPTION
		, P_SOB_ID, P_ORG_ID
		, D_SYSDATE, P_USER_ID, D_SYSDATE, P_USER_ID
		);
		COMMIT;

  END DATA_INSERT;

-- UPDATE.
    PROCEDURE DATA_UPDATE(W_TAX_RATE_ID                     IN NUMBER
											, P_START_AMOUNT                      IN NUMBER
											, P_END_AMOUNT                        IN NUMBER
                      , P_TAX_RATE                          IN NUMBER
											, P_ACCUM_SUB_AMOUNT                  IN NUMBER
											, P_DESCRIPTION                       IN VARCHAR2
											, P_USER_ID                           IN NUMBER)
  AS
  BEGIN
		UPDATE HRA_TAX_RATE TR
			SET TR.START_AMOUNT                                   = P_START_AMOUNT
						, TR.END_AMOUNT                                 = P_END_AMOUNT
            , TR.TAX_RATE                                   = P_TAX_RATE
						, TR.ACCUM_SUB_AMOUNT                           = P_ACCUM_SUB_AMOUNT
						, TR.DESCRIPTION                                = P_DESCRIPTION
						, TR.LAST_UPDATE_DATE                           = GET_LOCAL_DATE(TR.SOB_ID)
						, TR.LAST_UPDATED_BY                            = P_USER_ID
		WHERE TR.TAX_RATE_ID                                    = W_TAX_RATE_ID
		;
		COMMIT;
      
  END DATA_UPDATE;

-- DELETE.
  PROCEDURE DATA_DELETE(W_TAX_RATE_ID                       IN NUMBER)
  AS
  BEGIN
		DELETE HRA_TAX_RATE TR
		WHERE TR.TAX_RATE_ID                                    = W_TAX_RATE_ID
		;
		COMMIT;
  
  END DATA_DELETE;
  
---------------------------------------------------------------------------------------------------
-- 해당 년도 기준 정보 존재 여부 체크.
  PROCEDURE CHECK_TAX_RATE_YN
            ( W_TAX_YYYY              IN HRA_TAX_RATE.TAX_YYYY%TYPE
            , W_TAX_TYPE_ID           IN HRA_TAX_RATE.TAX_TYPE_ID%TYPE
            , W_SOB_ID                IN HRA_TAX_RATE.SOB_ID%TYPE
            , W_ORG_ID                IN HRA_TAX_RATE.ORG_ID%TYPE
            , O_CHECK_YN              OUT VARCHAR2
            )
  AS
  BEGIN
    SELECT DECODE(COUNT(TR.TAX_YYYY), 0, 'N', 'Y') AS RECORD_COUNT
      INTO O_CHECK_YN
      FROM HRA_TAX_RATE TR
    WHERE TR.TAX_YYYY       = W_TAX_YYYY
      AND TR.TAX_TYPE_ID    = W_TAX_TYPE_ID
      AND TR.SOB_ID         = W_SOB_ID
      AND TR.ORG_ID         = W_ORG_ID
    ;
  EXCEPTION WHEN OTHERS THEN
    O_CHECK_YN := 'N';
  END CHECK_TAX_RATE_YN;

-- 전년도 기준 정보 COPY
  PROCEDURE COPY_TAX_RATE
            ( W_TAX_YYYY              IN HRA_TAX_RATE.TAX_YYYY%TYPE
            , W_TAX_TYPE_ID           IN HRA_TAX_RATE.TAX_TYPE_ID%TYPE
            , W_SOB_ID                IN HRA_TAX_RATE.SOB_ID%TYPE
            , W_ORG_ID                IN HRA_TAX_RATE.ORG_ID%TYPE
            , P_USER_ID               IN HRA_TAX_RATE.CREATED_BY%TYPE
            , O_MESSAGE               OUT VARCHAR2
            )
  AS
    V_SYSDATE                     DATE := GET_LOCAL_DATE(W_SOB_ID);
    V_PRE_TAX_YYYY                HRA_TAX_RATE.TAX_YYYY%TYPE;

  BEGIN
    V_PRE_TAX_YYYY := W_TAX_YYYY - 1;
    
    -- 데이터 삭제.
    BEGIN
      DELETE HRA_TAX_RATE TR
		  WHERE TR.TAX_YYYY       = W_TAX_YYYY
        AND TR.TAX_TYPE_ID    = W_TAX_TYPE_ID
        AND TR.SOB_ID         = W_SOB_ID
        AND TR.ORG_ID         = W_ORG_ID
      ;
    END;

    INSERT INTO HRA_TAX_RATE
		(TAX_RATE_ID, TAX_YYYY, TAX_TYPE_ID
		, START_AMOUNT, END_AMOUNT, TAX_RATE, ACCUM_SUB_AMOUNT
		, DESCRIPTION
		, SOB_ID, ORG_ID
		, CREATION_DATE, CREATED_BY, LAST_UPDATE_DATE, LAST_UPDATED_BY
		)
    SELECT HRA_TAX_RATE_S1.NEXTVAL
        , W_TAX_YYYY
        , TR.TAX_TYPE_ID
        , TR.START_AMOUNT
        , TR.END_AMOUNT
        , TR.TAX_RATE
        , TR.ACCUM_SUB_AMOUNT
        , TR.DESCRIPTION
        , TR.SOB_ID
        , TR.ORG_ID
        , V_SYSDATE, P_USER_ID, V_SYSDATE, P_USER_ID
    FROM HRA_TAX_RATE TR
    WHERE TR.TAX_YYYY             = V_PRE_TAX_YYYY
      AND TR.TAX_TYPE_ID          = W_TAX_TYPE_ID
      AND TR.SOB_ID               = W_SOB_ID
      AND TR.ORG_ID               = W_ORG_ID					
    ;
    O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'SDM_10027', NULL);
    
  EXCEPTION
    WHEN ERRNUMS.Exist_Data THEN
      O_MESSAGE := ERRNUMS.Exist_Data_Desc;
  
  
  END COPY_TAX_RATE;

END HRA_TAX_RATE_G;
/
