CREATE OR REPLACE PACKAGE HRM_CERTIFICATE_G
AS

-- DATA_SELECT.
  PROCEDURE DATA_SELECT(P_CURSOR                                          OUT TYPES.TCURSOR
           , W_CORP_ID                                         IN NUMBER
           , W_STD_DATE                                        IN DATE
           , W_PERSON_ID                                       IN NUMBER
           , W_CERT_TYPE_ID                                    IN NUMBER
           , W_SOB_ID                                          IN NUMBER
           , W_ORG_ID                                          IN NUMBER);

-- DATA_INSERT.
  PROCEDURE DATA_INSERT
            ( P_PRINT_NUM             OUT HRM_CERTIFICATE.PRINT_NUM%TYPE
            , P_CORP_ID               IN NUMBER
            , P_PRINT_DATE            IN DATE
            , P_PERSON_ID             IN NUMBER
            , P_CERT_TYPE_ID          IN NUMBER
            , P_PRINT_COUNT           IN NUMBER
            , P_SEND_ORG              IN VARCHAR2
            , P_DESCRIPTION           IN VARCHAR2
            , P_SOB_ID                IN NUMBER
            , P_ORG_ID                IN NUMBER
            , P_USER_ID               IN NUMBER);

-- DATA_UPDATE.
  PROCEDURE DATA_UPDATE
            ( W_PRINT_NUM             IN HRM_CERTIFICATE.PRINT_NUM%TYPE
            , W_CORP_ID               IN NUMBER
            , W_SOB_ID                IN NUMBER
            , W_ORG_ID                IN NUMBER
            , P_CERT_TYPE_ID          IN NUMBER
            , P_PRINT_COUNT           IN NUMBER
            , P_SEND_ORG              IN VARCHAR2
            , P_DESCRIPTION           IN VARCHAR2
            , P_USER_ID               IN NUMBER);

-- SELECT PRINT DATA..
  PROCEDURE SELECT_PRINT_DATA
            ( P_CURSOR2               OUT TYPES.TCURSOR2
            , W_PRINT_NUM             IN HRM_CERTIFICATE.PRINT_NUM%TYPE
            );



-- [2012-01-17]
   PROCEDURE SELECT_DATA_PRINT
           ( P_CURSOR2    OUT TYPES.TCURSOR2
           , W_PRINT_NUM  IN  HRM_CERTIFICATE.PRINT_NUM%TYPE
           , W_LANG_CODE  IN  VARCHAR2 DEFAULT 'KO' 
           );


END HRM_CERTIFICATE_G;


 
/
CREATE OR REPLACE PACKAGE BODY HRM_CERTIFICATE_G
AS

-- DATA_SELECT.
  PROCEDURE DATA_SELECT(P_CURSOR                                          OUT TYPES.TCURSOR
											, W_CORP_ID                                         IN NUMBER
											, W_STD_DATE                                        IN DATE
											, W_PERSON_ID                                       IN NUMBER
											, W_CERT_TYPE_ID                                    IN NUMBER
											, W_SOB_ID                                          IN NUMBER
											, W_ORG_ID                                          IN NUMBER)
  AS
  BEGIN
     OPEN P_CURSOR FOR
        SELECT HC.PRINT_NUM
				     , HC.CORP_ID
             , HC.PRINT_DATE
             , HC.PERSON_ID
             , PM.NAME
             , PM.JOIN_DATE
             , PM.RETIRE_DATE
             , HC.CERT_TYPE_ID
             , HRM_COMMON_G.ID_NAME_F(HC.CERT_TYPE_ID) CERT_TYPE_NAME
             , HC.DESCRIPTION
						 , HC.PRINT_COUNT
             , HC.SEND_ORG
             , HC.LAST_UPDATE_DATE AS LAST_PRINTED_DATE 
             , EAPP_USER_G.USER_NAME_F(HC.LAST_UPDATED_BY) AS LAST_PRINTED_BY
         FROM HRM_CERTIFICATE HC
            , HRM_PERSON_MASTER PM
         WHERE HC.PERSON_ID                            = PM.PERSON_ID
				   AND HC.CORP_ID                              = W_CORP_ID
           AND HC.PRINT_DATE                           <= W_STD_DATE
           AND HC.PERSON_ID                            = NVL(W_PERSON_ID, HC.PERSON_ID)
           AND HC.CERT_TYPE_ID                         = NVL(W_CERT_TYPE_ID, HC.CERT_TYPE_ID)
					 AND HC.SOB_ID                               = W_SOB_ID
					 AND HC.ORG_ID                               = W_ORG_ID
				ORDER BY HC.PRINT_NUM DESC	 
        ;

  END DATA_SELECT;

-- DATA_INSERT.
  PROCEDURE DATA_INSERT
            ( P_PRINT_NUM             OUT HRM_CERTIFICATE.PRINT_NUM%TYPE
            , P_CORP_ID               IN NUMBER
            , P_PRINT_DATE            IN DATE
            , P_PERSON_ID             IN NUMBER
            , P_CERT_TYPE_ID          IN NUMBER
            , P_PRINT_COUNT           IN NUMBER
            , P_SEND_ORG              IN VARCHAR2
            , P_DESCRIPTION           IN VARCHAR2
            , P_SOB_ID                IN NUMBER
            , P_ORG_ID                IN NUMBER
            , P_USER_ID               IN NUMBER)
  AS
    V_PRINT_YYYYMM                                                        VARCHAR2(6) := NULL;
    N_PRINT_SEQ                                                           NUMBER := 0;
    
  BEGIN
      V_PRINT_YYYYMM := TO_CHAR(SYSDATE, 'YYYYMM');
      BEGIN
        SELECT NVL(MAX(HC.PRINT_SEQ), 0) + 1 NEW_PRINT_SEQ
          INTO N_PRINT_SEQ
        FROM HRM_CERTIFICATE HC
        WHERE HC.PRINT_YYYYMM         = V_PRINT_YYYYMM
				  AND HC.CORP_ID              = P_CORP_ID
				  AND HC.SOB_ID               = P_SOB_ID
					AND HC.ORG_ID               = P_ORG_ID
        ;
      EXCEPTION WHEN OTHERS THEN
        N_PRINT_SEQ := 1;
      END;
      
      -- 발행번호 생성.
      P_PRINT_NUM := V_PRINT_YYYYMM || '-' || LPAD(N_PRINT_SEQ, 3, 0);
--      DBMS_OUTPUT.PUT_LINE('N_PRINT_SEQ : ' || N_PRINT_SEQ || ', V_PRINT_NUM : ' || V_PRINT_NUM);
      INSERT INTO HRM_CERTIFICATE
      (PRINT_NUM
      , CORP_ID, PRINT_DATE, PERSON_ID
      , CERT_TYPE_ID, PRINT_COUNT, SEND_ORG
      , DESCRIPTION
      , PRINT_YYYYMM, PRINT_SEQ
			, SOB_ID, ORG_ID
      , CREATION_DATE, CREATED_BY, LAST_UPDATE_DATE, LAST_UPDATED_BY
      ) VALUES
      (P_PRINT_NUM
      , P_CORP_ID, TRUNC(P_PRINT_DATE), P_PERSON_ID
      , P_CERT_TYPE_ID, P_PRINT_COUNT, P_SEND_ORG
      , P_DESCRIPTION
      , V_PRINT_YYYYMM, N_PRINT_SEQ
			, P_SOB_ID, P_ORG_ID
      , SYSDATE, P_USER_ID, SYSDATE, P_USER_ID
      );
			
  END DATA_INSERT;

-- DATA_UPDATE.
  PROCEDURE DATA_UPDATE
            ( W_PRINT_NUM             IN HRM_CERTIFICATE.PRINT_NUM%TYPE
            , W_CORP_ID               IN NUMBER
            , W_SOB_ID                IN NUMBER
            , W_ORG_ID                IN NUMBER
            , P_CERT_TYPE_ID          IN NUMBER
            , P_PRINT_COUNT           IN NUMBER
            , P_SEND_ORG              IN VARCHAR2
            , P_DESCRIPTION           IN VARCHAR2
            , P_USER_ID               IN NUMBER)
  AS
  BEGIN
      UPDATE HRM_CERTIFICATE HC
        SET HC.CERT_TYPE_ID                                               = P_CERT_TYPE_ID
              , HC.PRINT_COUNT                                            = P_PRINT_COUNT
              , HC.SEND_ORG                                               = P_SEND_ORG
              , HC.DESCRIPTION                                            = P_DESCRIPTION
              , HC.LAST_UPDATE_DATE                                       = SYSDATE
              , HC.LAST_UPDATED_BY                                        = P_USER_ID
      WHERE HC.PRINT_NUM                                                  = W_PRINT_NUM
			  AND HC.CORP_ID                                                    = W_CORP_ID
			  AND HC.SOB_ID                                                     = W_SOB_ID
				AND HC.ORG_ID                                                     = W_ORG_ID
      ;

  END DATA_UPDATE;

-- SELECT PRINT DATA..
  PROCEDURE SELECT_PRINT_DATA
            ( P_CURSOR2               OUT TYPES.TCURSOR2
            , W_PRINT_NUM             IN HRM_CERTIFICATE.PRINT_NUM%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR2 FOR
      SELECT HC.PRINT_NUM
           , HRM_COMMON_G.GET_CODE_F(HC.CERT_TYPE_ID, HC.SOB_ID, HC.ORG_ID) AS CERTIFICATE_TYPE
           , HRM_COMMON_G.ID_NAME_F(HC.CERT_TYPE_ID) AS CERTIFICATE_TYPE_NAME
           , PM.NAME
           , PM.NAME2 AS CHINESE_NAME
           , PM.REPRE_NUM
           , PM.LIVE_ADDR1 || ' ' || PM.LIVE_ADDR2 AS PERSON_ADDRESS
           , HRM_DEPT_MASTER_G.DEPT_NAME_F(PM.DEPT_ID) AS DEPT_NAME
           , HRM_COMMON_G.ID_NAME_F(PM.POST_ID) AS POST_NAME
           , CASE
               WHEN PM.ORI_JOIN_DATE IS NULL THEN TO_CHAR(NULL)
               ELSE TO_CHAR(PM.ORI_JOIN_DATE, 'YYYY') || '년 ' || TO_CHAR(PM.ORI_JOIN_DATE, 'MM') || '월 ' || TO_CHAR(PM.ORI_JOIN_DATE, 'DD') || '일 부터'
             END AS ORI_JOIN_DATE
           , CASE
               WHEN PM.RETIRE_DATE IS NULL THEN TO_CHAR(SYSDATE, 'YYYY') || '년 ' || TO_CHAR(SYSDATE, 'MM') || '월 ' || TO_CHAR(SYSDATE, 'DD') || '일'
               ELSE TO_CHAR(PM.RETIRE_DATE, 'YYYY') || '년 ' || TO_CHAR(PM.RETIRE_DATE, 'MM') || '월 ' || TO_CHAR(PM.RETIRE_DATE, 'DD') || '일'
             END || ' 까지' AS RETIRE_DATE
           , HC.DESCRIPTION
           , HC.SEND_ORG
           , NULL AS UNUSUAL_REARK
           , HC.PRINT_COUNT
           , TO_CHAR(HC.PRINT_DATE, 'YYYY-MM-DD') AS PRINT_DATE
           , CM.CORP_NAME
           , CM.PRESIDENT_NAME
           , CM.ADDR1 || ' ' || CM.ADDR2 AS CORP_ADDRESS 
           , HRM_COMMON_G.ID_NAME_F(PM.OCPT_ID) AS WORKING_NAME
       FROM HRM_CERTIFICATE HC
          , HRM_PERSON_MASTER PM
          , HRM_CORP_MASTER CM
       WHERE HC.PERSON_ID           = PM.PERSON_ID
         AND PM.CORP_ID             = CM.CORP_ID
         AND HC.PRINT_NUM           = W_PRINT_NUM
         AND ROWNUM                 = 1
     ;
  END SELECT_PRINT_DATA;




-- [2012-01-17]
   PROCEDURE SELECT_DATA_PRINT
           ( P_CURSOR2    OUT TYPES.TCURSOR2
           , W_PRINT_NUM  IN  HRM_CERTIFICATE.PRINT_NUM%TYPE
           , W_LANG_CODE  IN  VARCHAR2 DEFAULT 'KO' 
           )

   AS

   BEGIN
             OPEN P_CURSOR2 FOR
             SELECT HC.PRINT_NUM
                  , HRM_COMMON_G.GET_CODE_F(HC.CERT_TYPE_ID, HC.SOB_ID, HC.ORG_ID) AS CERTIFICATE_TYPE
                  , CASE
                      WHEN W_LANG_CODE = 'EN' THEN 'CERTIFICATE of EMPLOYMENT' 
                      ELSE  HRM_COMMON_G.ID_NAME_F(HC.CERT_TYPE_ID)                        
                    END AS CERTIFICATE_TYPE_NAME
                  , CASE
                      WHEN W_LANG_CODE = 'EN' THEN NVL(PM.NAME1, PM.NAME)  
                      ELSE PM.NAME
                    END AS PERSON_NAME
                  , PM.NAME2     AS CHINESE_NAME
                  , PM.REPRE_NUM AS RRN
                  , PM.PRSN_ADDR1 || ' ' || PM.PRSN_ADDR2     AS PERSON_ADDRESS
                  , HRM_DEPT_MASTER_G.DEPT_NAME_F(PM.DEPT_ID) AS DEPT_NAME
                  , HRM_COMMON_G.ID_NAME_F(PM.POST_ID)        AS POST_NAME
                  , CASE
                      WHEN PM.JOIN_DATE IS NULL THEN TO_CHAR(NULL)
                      ELSE TO_CHAR(PM.JOIN_DATE, 'YYYY') || '년 ' || TO_CHAR(PM.JOIN_DATE, 'MM') || '월 ' || TO_CHAR(PM.JOIN_DATE, 'DD') || '일 부터'
                    END  || '     ' || 
                    CASE
                      WHEN PM.RETIRE_DATE IS NULL THEN TO_CHAR(SYSDATE, 'YYYY') || '년 ' || TO_CHAR(SYSDATE, 'MM') || '월 ' || TO_CHAR(SYSDATE, 'DD') || '일  까지'
                      ELSE TO_CHAR(PM.RETIRE_DATE, 'YYYY') || '년 ' || TO_CHAR(PM.RETIRE_DATE, 'MM') || '월 ' || TO_CHAR(PM.RETIRE_DATE, 'DD') || '일  까지'
                    END AS EMPLOYMENT_PERIOD 
                  , HC.DESCRIPTION
                  , HC.SEND_ORG
                  , NULL AS UNUSUAL_REARK
                  , HC.PRINT_COUNT
                  , TO_CHAR(HC.PRINT_DATE, 'YYYY-MM-DD') AS PRINT_DATE
                  , CASE
                      WHEN W_LANG_CODE = 'EN' THEN 'BH Co., Ltd.' 
                      ELSE CM.CORP_NAME
                    END AS CORP_NAME 
                  , CASE 
                      WHEN W_LANG_CODE = 'EN' THEN 'Lee Kyung - hwan'
                      ELSE CM.PRESIDENT_NAME
                    END AS PRESIDENT_NAME 
                  , CASE
                      WHEN W_LANG_CODE = 'EN' THEN '422-1, Chung Chun Dong, Bu-Pyung Ku, Incheon City, Korea' 
                      ELSE CM.ADDR1 || ' ' || CM.ADDR2         
                    END AS CORP_ADDRESS
                  , HRM_COMMON_G.ID_NAME_F(PM.OCPT_ID)  AS WORKING_NAME
                  , TO_CHAR(PM.JOIN_DATE, 'YYYY-MM-DD') AS JOIN_DATE
                  , HRM_COMMON_DATE_G.PERIOD_YYYY_MM_DD_F(PM.JOIN_DATE, NVL(PM.RETIRE_DATE, GET_LOCAL_DATE(PM.SOB_ID)), 0, 1) AS CONTINUE_YEAR 
                  , CASE
                      WHEN W_LANG_CODE = 'EN' THEN 'BH Co., Ltd.' 
                      ELSE '(주)비에이치' 
                    END AS STAMP
               FROM HRM_CERTIFICATE   HC
                  , HRM_PERSON_MASTER PM
                  , HRM_CORP_MASTER   CM
              WHERE HC.PERSON_ID   =  PM.PERSON_ID
                AND PM.CORP_ID     =  CM.CORP_ID
                AND HC.PRINT_NUM   =  W_PRINT_NUM
                AND ROWNUM         =  1
                  ;

   END SELECT_DATA_PRINT;


END HRM_CERTIFICATE_G;
/
