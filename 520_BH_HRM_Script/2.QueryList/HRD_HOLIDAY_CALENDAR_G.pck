CREATE OR REPLACE PACKAGE HRD_HOLIDAY_CALENDAR_G
AS

-- DATA_SELECT.
  PROCEDURE DATA_SELECT(P_CURSOR                           OUT TYPES.TCURSOR
                      , W_WORK_YYYY                        IN HRD_HOLIDAY_CALENDAR.WORK_YYYY%TYPE
                      , W_SOB_ID                           IN HRD_HOLIDAY_CALENDAR.SOB_ID%TYPE
                      , W_ORG_ID                           IN HRD_HOLIDAY_CALENDAR.ORG_ID%TYPE);

-- DATA_INSERT.
  PROCEDURE DATA_INSERT(P_WORK_YYYY                        IN HRD_HOLIDAY_CALENDAR.WORK_YYYY%TYPE
                      , P_WORK_DATE                        IN HRD_HOLIDAY_CALENDAR.WORK_DATE%TYPE
                      , P_HOLIDAY_NAME                     IN HRD_HOLIDAY_CALENDAR.HOLIDAY_NAME%TYPE
                      , P_ALL_CHECK                        IN HRD_HOLIDAY_CALENDAR.ALL_CHECK%TYPE
                      , P_DESCRIPTION                      IN HRD_HOLIDAY_CALENDAR.DESCRIPTION%TYPE
                      , P_SOB_ID                           IN HRD_HOLIDAY_CALENDAR.SOB_ID%TYPE
                      , P_ORG_ID                           IN HRD_HOLIDAY_CALENDAR.ORG_ID%TYPE
                      , P_USER_ID                          IN HRD_HOLIDAY_CALENDAR.CREATED_BY%TYPE
                      );

-- DATA_UPDATE.
  PROCEDURE DATA_UPDATE(W_WORK_DATE                        IN HRD_HOLIDAY_CALENDAR.WORK_DATE%TYPE
											, W_SOB_ID                           IN HRD_HOLIDAY_CALENDAR.SOB_ID%TYPE
                      , W_ORG_ID                           IN HRD_HOLIDAY_CALENDAR.ORG_ID%TYPE
                      , P_HOLIDAY_NAME                     IN HRD_HOLIDAY_CALENDAR.HOLIDAY_NAME%TYPE
                      , P_ALL_CHECK                        IN HRD_HOLIDAY_CALENDAR.ALL_CHECK%TYPE
                      , P_DESCRIPTION                      IN HRD_HOLIDAY_CALENDAR.DESCRIPTION%TYPE
                      , P_USER_ID                          IN HRD_HOLIDAY_CALENDAR.CREATED_BY%TYPE);

-- DATA_DELETE..
  PROCEDURE DATA_DELETE(W_WORK_DATE                        IN HRD_HOLIDAY_CALENDAR.WORK_DATE%TYPE
											, W_SOB_ID                           IN HRD_HOLIDAY_CALENDAR.SOB_ID%TYPE
                      , W_ORG_ID                           IN HRD_HOLIDAY_CALENDAR.ORG_ID%TYPE);

-- HOLYDAY_CHECK.
  FUNCTION HOLIDAY_CHECK(W_WORK_DATE                       IN HRD_HOLIDAY_CALENDAR.WORK_DATE%TYPE
	                     , W_SOB_ID                          IN HRD_HOLIDAY_CALENDAR.SOB_ID%TYPE
											 , W_ORG_ID                          IN HRD_HOLIDAY_CALENDAR.ORG_ID%TYPE) RETURN VARCHAR2;

-- 법정 유급휴일수.
  FUNCTION HOLIDAY_COUNT
            ( W_WORK_DATE_FR      IN HRD_HOLIDAY_CALENDAR.WORK_DATE%TYPE
            , W_WORK_DATE_TO      IN HRD_HOLIDAY_CALENDAR.WORK_DATE%TYPE
            , W_PERSON_ID         IN NUMBER
            , W_SOB_ID            IN NUMBER
            , W_ORG_ID            IN NUMBER
            ) RETURN NUMBER;
                                                           

END HRD_HOLIDAY_CALENDAR_G;


 
/
CREATE OR REPLACE PACKAGE BODY HRD_HOLIDAY_CALENDAR_G
AS
/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRD_HOLIDAY_CALENDAR_G
/* Description  : 휴일사항 관리 패키지
/*
/* Reference by : 년가 휴가 사항 입력 관리.
/* Program History : 
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
-- DATA_SELECT.
  PROCEDURE DATA_SELECT(P_CURSOR                           OUT TYPES.TCURSOR
                      , W_WORK_YYYY                        IN HRD_HOLIDAY_CALENDAR.WORK_YYYY%TYPE
                      , W_SOB_ID                           IN HRD_HOLIDAY_CALENDAR.SOB_ID%TYPE
                      , W_ORG_ID                           IN HRD_HOLIDAY_CALENDAR.ORG_ID%TYPE)
  AS
  BEGIN
     OPEN P_CURSOR FOR
        SELECT HC.WORK_YYYY
				    , HC.WORK_DATE
						, HC.HOLIDAY_NAME
						, HC.ALL_CHECK
						, HC.DESCRIPTION
         FROM HRD_HOLIDAY_CALENDAR HC
         WHERE HC.WORK_YYYY                            = W_WORK_YYYY
           AND HC.SOB_ID                               = W_SOB_ID
           AND HC.ORG_ID                               = W_ORG_ID
        ORDER BY HC.WORK_DATE
        ;

  END DATA_SELECT;

-- DATA_INSERT.
  PROCEDURE DATA_INSERT(P_WORK_YYYY                        IN HRD_HOLIDAY_CALENDAR.WORK_YYYY%TYPE
                      , P_WORK_DATE                        IN HRD_HOLIDAY_CALENDAR.WORK_DATE%TYPE
                      , P_HOLIDAY_NAME                     IN HRD_HOLIDAY_CALENDAR.HOLIDAY_NAME%TYPE
                      , P_ALL_CHECK                        IN HRD_HOLIDAY_CALENDAR.ALL_CHECK%TYPE
                      , P_DESCRIPTION                      IN HRD_HOLIDAY_CALENDAR.DESCRIPTION%TYPE
                      , P_SOB_ID                           IN HRD_HOLIDAY_CALENDAR.SOB_ID%TYPE
                      , P_ORG_ID                           IN HRD_HOLIDAY_CALENDAR.ORG_ID%TYPE
                      , P_USER_ID                          IN HRD_HOLIDAY_CALENDAR.CREATED_BY%TYPE
                      )
  AS
    V_RECORD_COUNT    NUMBER := 0;
    
  BEGIN   
    BEGIN
      SELECT COUNT(HC.WORK_DATE) AS RECORD_COUNT
        INTO V_RECORD_COUNT
        FROM HRD_HOLIDAY_CALENDAR HC
       WHERE HC.WORK_DATE                            = P_WORK_DATE
         AND HC.SOB_ID                               = P_SOB_ID
         AND HC.ORG_ID                               = P_ORG_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_RECORD_COUNT    := 0;
    END;
    IF V_RECORD_COUNT <> 0 THEN
      RAISE ERRNUMS.Exist_Data;
    END IF;
    
    INSERT INTO HRD_HOLIDAY_CALENDAR
    (WORK_YYYY, WORK_DATE, HOLIDAY_NAME, ALL_CHECK
    , DESCRIPTION
    , SOB_ID, ORG_ID
    , CREATION_DATE, CREATED_BY, LAST_UPDATE_DATE, LAST_UPDATED_BY
    ) VALUES
    (P_WORK_YYYY, TRUNC(P_WORK_DATE), P_HOLIDAY_NAME, P_ALL_CHECK
    , P_DESCRIPTION
    , P_SOB_ID, P_ORG_ID
    , SYSDATE, P_USER_ID, SYSDATE, P_USER_ID
    );

  EXCEPTION 
    WHEN ERRNUMS.Exist_Data THEN
      RAISE_APPLICATION_ERROR(ERRNUMS.Exist_Data_Code, ERRNUMS.Exist_Data_Desc);
  END DATA_INSERT;

-- DATA_UPDATE.
  PROCEDURE DATA_UPDATE(W_WORK_DATE                        IN HRD_HOLIDAY_CALENDAR.WORK_DATE%TYPE
											, W_SOB_ID                           IN HRD_HOLIDAY_CALENDAR.SOB_ID%TYPE
                      , W_ORG_ID                           IN HRD_HOLIDAY_CALENDAR.ORG_ID%TYPE
                      , P_HOLIDAY_NAME                     IN HRD_HOLIDAY_CALENDAR.HOLIDAY_NAME%TYPE
                      , P_ALL_CHECK                        IN HRD_HOLIDAY_CALENDAR.ALL_CHECK%TYPE
                      , P_DESCRIPTION                      IN HRD_HOLIDAY_CALENDAR.DESCRIPTION%TYPE
                      , P_USER_ID                          IN HRD_HOLIDAY_CALENDAR.CREATED_BY%TYPE)
  AS
  BEGIN
      UPDATE HRD_HOLIDAY_CALENDAR HC
        SET HC.HOLIDAY_NAME                                 = P_HOLIDAY_NAME
					, HC.ALL_CHECK                                    = P_ALL_CHECK
					, HC.DESCRIPTION                                  = P_DESCRIPTION
					, HC.LAST_UPDATE_DATE                             = SYSDATE
					, HC.LAST_UPDATED_BY                              = P_USER_ID
      WHERE HC.WORK_DATE                                    = W_WORK_DATE
        AND HC.SOB_ID                                       = W_SOB_ID
        AND HC.ORG_ID                                       = W_ORG_ID
      ;

  END DATA_UPDATE;

-- DATA_DELETE..
  PROCEDURE DATA_DELETE(W_WORK_DATE                        IN HRD_HOLIDAY_CALENDAR.WORK_DATE%TYPE
											, W_SOB_ID                           IN HRD_HOLIDAY_CALENDAR.SOB_ID%TYPE
                      , W_ORG_ID                           IN HRD_HOLIDAY_CALENDAR.ORG_ID%TYPE)
  AS
  BEGIN
      DELETE FROM HRD_HOLIDAY_CALENDAR HC
      WHERE HC.WORK_DATE                                   = W_WORK_DATE
        AND HC.SOB_ID                                      = W_SOB_ID
        AND HC.ORG_ID                                      = W_ORG_ID
      ;

  END DATA_DELETE;
	
-- HOLYDAY_CHECK.
  FUNCTION HOLIDAY_CHECK(W_WORK_DATE                       IN HRD_HOLIDAY_CALENDAR.WORK_DATE%TYPE
	                     , W_SOB_ID                          IN HRD_HOLIDAY_CALENDAR.SOB_ID%TYPE
											 , W_ORG_ID                          IN HRD_HOLIDAY_CALENDAR.ORG_ID%TYPE) RETURN VARCHAR2
  AS
	  V_RETURN_VALUE                                         VARCHAR2(2) := 'N';
		
	BEGIN
	  BEGIN
			SELECT DECODE(HC.ALL_CHECK, 'Y', 'A', 'Y')
			  INTO V_RETURN_VALUE
			  FROM HRD_HOLIDAY_CALENDAR HC
			 WHERE HC.WORK_DATE                   = W_WORK_DATE
			   AND HC.SOB_ID                      = W_SOB_ID
				 AND HC.ORG_ID                      = W_ORG_ID
	    ;
	  EXCEPTION WHEN OTHERS THEN
		  V_RETURN_VALUE := 'N';
	  END;
		
		RETURN V_RETURN_VALUE;
		
	END HOLIDAY_CHECK;	

-- 법정 유급휴일수.
  FUNCTION HOLIDAY_COUNT
            ( W_WORK_DATE_FR      IN HRD_HOLIDAY_CALENDAR.WORK_DATE%TYPE
            , W_WORK_DATE_TO      IN HRD_HOLIDAY_CALENDAR.WORK_DATE%TYPE
            , W_PERSON_ID         IN NUMBER
            , W_SOB_ID            IN NUMBER
            , W_ORG_ID            IN NUMBER
            ) RETURN NUMBER
  AS
    V_WORK_DATE_FR                DATE;
    V_WORK_DATE_TO                DATE;
    V_COUNT                       NUMBER := 0;
    V_WORK_TYPE_GROUP             VARCHAR2(10);
  BEGIN
    V_WORK_DATE_FR := W_WORK_DATE_FR;
    V_WORK_DATE_TO := W_WORK_DATE_TO;
    BEGIN
      SELECT WT.WORK_TYPE_GROUP
           , CASE 
               WHEN W_WORK_DATE_FR < PM.ORI_JOIN_DATE THEN PM.ORI_JOIN_DATE
               ELSE W_WORK_DATE_FR
             END AS WORK_DATE_FR
           , CASE 
               WHEN PM.RETIRE_DATE IS NULL THEN W_WORK_DATE_TO
               WHEN PM.RETIRE_DATE < W_WORK_DATE_TO THEN PM.RETIRE_DATE
               ELSE W_WORK_DATE_TO
             END AS WORK_DATE_FR
        INTO V_WORK_TYPE_GROUP
           , V_WORK_DATE_FR
           , V_WORK_DATE_TO
        FROM HRM_PERSON_MASTER PM
          , HRM_WORK_TYPE_V WT
      WHERE PM.WORK_TYPE_ID       = WT.WORK_TYPE_ID
        AND PM.PERSON_ID          = W_PERSON_ID
        AND PM.SOB_ID             = W_SOB_ID
        AND PM.ORG_ID             = W_ORG_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      RETURN V_COUNT;
    END;
    
    BEGIN
      SELECT COUNT(HC.WORK_DATE) AS COUNT
        INTO V_COUNT
        FROM HRD_HOLIDAY_CALENDAR HC
      WHERE HC.WORK_DATE          BETWEEN V_WORK_DATE_FR AND V_WORK_DATE_TO
        AND HC.ALL_CHECK          = CASE 
                                      WHEN V_WORK_TYPE_GROUP IN('32') THEN 'Y'
                                      ELSE HC.ALL_CHECK
                                    END
        AND HC.SOB_ID             = W_SOB_ID
        AND HC.ORG_ID             = W_ORG_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_COUNT := 0;
    END;
    RETURN V_COUNT;
  END HOLIDAY_COUNT;
  
END HRD_HOLIDAY_CALENDAR_G;
/
