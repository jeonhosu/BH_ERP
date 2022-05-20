CREATE OR REPLACE PACKAGE HRM_RESULT_G
AS

-- DATA_SELECT.
  PROCEDURE DATA_SELECT(P_CURSOR                                          OUT TYPES.TCURSOR
                      , W_PERSON_ID                                       IN NUMBER);

-- DATA_INSERT.
  PROCEDURE DATA_INSERT(P_PERSON_ID                                       IN NUMBER
											, P_RESULT_YYYY                                     IN VARCHAR2
											, P_RES_1                                           IN VARCHAR2
											, P_RES_2                                           IN VARCHAR2
											, P_RES_3                                           IN VARCHAR2
											, P_RES_4                                           IN VARCHAR2
											, P_RES_5                                           IN VARCHAR2
											, P_RES_6                                           IN VARCHAR2
											, P_RES_7                                           IN VARCHAR2
											, P_RES_8                                           IN VARCHAR2
											, P_RES_9                                           IN VARCHAR2
											, P_RES_10                                          IN VARCHAR2
											, P_DESCRIPTION                                     IN VARCHAR2
											, P_USER_ID                                         IN NUMBER
											, W_SOB_ID                                          IN NUMBER
											, O_RESULT_SEQ                                      OUT NUMBER);

-- DATA_UPDATE.
  PROCEDURE DATA_UPDATE(W_PERSON_ID                                       IN NUMBER
											, W_RESULT_YYYY                                     IN VARCHAR2
											, W_RESULT_SEQ                                      IN NUMBER
											, P_RES_1                                           IN VARCHAR2
											, P_RES_2                                           IN VARCHAR2
											, P_RES_3                                           IN VARCHAR2
											, P_RES_4                                           IN VARCHAR2
											, P_RES_5                                           IN VARCHAR2
											, P_RES_6                                           IN VARCHAR2
											, P_RES_7                                           IN VARCHAR2
											, P_RES_8                                           IN VARCHAR2
											, P_RES_9                                           IN VARCHAR2
											, P_RES_10                                          IN VARCHAR2
											, P_DESCRIPTION                                     IN VARCHAR2
											, P_USER_ID                                         IN NUMBER
											, W_SOB_ID                                          IN NUMBER);

-- DATA_DELETE..
  PROCEDURE DATA_DELETE(W_PERSON_ID                                       IN NUMBER
											, W_RESULT_YYYY                                     IN VARCHAR2
											, W_RESULT_SEQ                                      IN NUMBER);

END HRM_RESULT_G;
/
CREATE OR REPLACE PACKAGE BODY HRM_RESULT_G
AS

-- DATA_SELECT.
  PROCEDURE DATA_SELECT(P_CURSOR                                          OUT TYPES.TCURSOR
                      , W_PERSON_ID                                       IN NUMBER)
  AS
  BEGIN
     OPEN P_CURSOR FOR
        SELECT HR.PERSON_ID
            , HR.RESULT_YYYY
            , HR.RESULT_SEQ
            , HR.RES_1
            , HR.RES_2                  -- 업적(상)
            , HR.RES_3
            , HR.RES_4                  -- 업적(하)
            , HR.RES_5
            , HR.RES_6                  -- 역량.
            , HR.RES_7
            , HR.RES_8                  
            , HR.RES_9
            , HR.RES_10                 -- 종합.  
            , HR.DESCRIPTION
        FROM HRM_RESULT HR
        WHERE HR.PERSON_ID                                = W_PERSON_ID
        ORDER BY HR.RESULT_YYYY DESC, HR.RESULT_SEQ
        ;

  END DATA_SELECT;


-- DATA_INSERT.
  PROCEDURE DATA_INSERT(P_PERSON_ID                                       IN NUMBER
											, P_RESULT_YYYY                                     IN VARCHAR2
											, P_RES_1                                           IN VARCHAR2
											, P_RES_2                                           IN VARCHAR2
											, P_RES_3                                           IN VARCHAR2
											, P_RES_4                                           IN VARCHAR2
											, P_RES_5                                           IN VARCHAR2
											, P_RES_6                                           IN VARCHAR2
											, P_RES_7                                           IN VARCHAR2
											, P_RES_8                                           IN VARCHAR2
											, P_RES_9                                           IN VARCHAR2
											, P_RES_10                                          IN VARCHAR2
											, P_DESCRIPTION                                     IN VARCHAR2
											, P_USER_ID                                         IN NUMBER
											, W_SOB_ID                                          IN NUMBER
											, O_RESULT_SEQ                                      OUT NUMBER)
  AS
	  D_SYSDATE                                                             DATE;
    N_RESULT_SEQ                                                          NUMBER := 0;
    
  BEGIN
	  D_SYSDATE := GET_LOCAL_DATE(W_SOB_ID);
		
		BEGIN
			SELECT NVL(COUNT(HR.PERSON_ID), 0) + 1 RESULT_SEQ
				INTO N_RESULT_SEQ
			FROM HRM_RESULT HR
			WHERE HR.PERSON_ID                                            = P_PERSON_ID
				AND HR.RESULT_YYYY                                          = P_RESULT_YYYY
			;
		EXCEPTION WHEN OTHERS THEN
			N_RESULT_SEQ := 1;      
		END;
  
		INSERT INTO HRM_RESULT
		(PERSON_ID, RESULT_YYYY, RESULT_SEQ
		, RES_1, RES_2, RES_3
		, RES_4, RES_5, RES_6
		, RES_7, RES_8, RES_9
		, RES_10
		, DESCRIPTION
		, CREATION_DATE, CREATED_BY, LAST_UPDATE_DATE, LAST_UPDATED_BY
		) VALUES
		(P_PERSON_ID, P_RESULT_YYYY, N_RESULT_SEQ
		, P_RES_1, P_RES_2, P_RES_3
		, P_RES_4, P_RES_5, P_RES_6
		, P_RES_7, P_RES_8, P_RES_9
		, P_RES_10
		, P_DESCRIPTION
		, D_SYSDATE, P_USER_ID, D_SYSDATE, P_USER_ID
		);
		O_RESULT_SEQ := N_RESULT_SEQ;
      
  END DATA_INSERT;

-- DATA_UPDATE.
  PROCEDURE DATA_UPDATE(W_PERSON_ID                                       IN NUMBER
											, W_RESULT_YYYY                                     IN VARCHAR2
											, W_RESULT_SEQ                                      IN NUMBER
											, P_RES_1                                           IN VARCHAR2
											, P_RES_2                                           IN VARCHAR2
											, P_RES_3                                           IN VARCHAR2
											, P_RES_4                                           IN VARCHAR2
											, P_RES_5                                           IN VARCHAR2
											, P_RES_6                                           IN VARCHAR2
											, P_RES_7                                           IN VARCHAR2
											, P_RES_8                                           IN VARCHAR2
											, P_RES_9                                           IN VARCHAR2
											, P_RES_10                                          IN VARCHAR2
											, P_DESCRIPTION                                     IN VARCHAR2
											, P_USER_ID                                         IN NUMBER
											, W_SOB_ID                                          IN NUMBER)
  AS
  BEGIN
		UPDATE HRM_RESULT HR
			SET HR.RES_1                                                      = P_RES_1
						, HR.RES_2                                                  = P_RES_2
						, HR.RES_3                                                  = P_RES_3
						, HR.RES_4                                                  = P_RES_4
						, HR.RES_5                                                  = P_RES_5
						, HR.RES_6                                                  = P_RES_6
						, HR.RES_7                                                  = P_RES_7
						, HR.RES_8                                                  = P_RES_8
						, HR.RES_9                                                  = P_RES_9
						, HR.RES_10                                                 = P_RES_10
						, HR.DESCRIPTION                                            = P_DESCRIPTION
						, HR.LAST_UPDATE_DATE                                       = GET_LOCAL_DATE(W_SOB_ID)
						, HR.LAST_UPDATED_BY                                        = P_USER_ID
		WHERE HR.PERSON_ID                                                  = W_PERSON_ID
			AND HR.RESULT_YYYY                                                = W_RESULT_YYYY
			AND HR.RESULT_SEQ                                                 = W_RESULT_SEQ
		;

  END DATA_UPDATE;

-- DATA_DELETE..
  PROCEDURE DATA_DELETE(W_PERSON_ID                                       IN NUMBER
											, W_RESULT_YYYY                                     IN VARCHAR2
											, W_RESULT_SEQ                                      IN NUMBER)
  AS
  BEGIN
      DELETE HRM_RESULT HR
      WHERE HR.PERSON_ID                                                  = W_PERSON_ID
        AND HR.RESULT_YYYY                                                = W_RESULT_YYYY
        AND HR.RESULT_SEQ                                                 = W_RESULT_SEQ
      ;

  END DATA_DELETE;
														

END HRM_RESULT_G;
/
