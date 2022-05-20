CREATE OR REPLACE PACKAGE EAPP_CALENDAR_G
AS

-- 년도 조회 LOOK UP.
  PROCEDURE LU_CALENDAR_YEAR_NUM(P_CURSOR                   OUT TYPES.TCURSOR
															, W_START_YEAR                IN EAPP_CALENDAR_YEAR.YEAR%TYPE DEFAULT NULL
															, W_END_YEAR                  IN EAPP_CALENDAR_YEAR.YEAR%TYPE DEFAULT NULL);

-- 년도 조회 LOOK UP.
  PROCEDURE LU_CALENDAR_YEAR_STR(P_CURSOR1                  OUT TYPES.TCURSOR
															, W_START_YEAR                IN EAPP_CALENDAR_YEAR.YEAR_STRING%TYPE DEFAULT NULL
															, W_END_YEAR                  IN EAPP_CALENDAR_YEAR.YEAR_STRING%TYPE DEFAULT NULL);

-- 년도 조회 LOOK UP.
  PROCEDURE LU_CALENDAR_YEAR(P_CURSOR1                    OUT TYPES.TCURSOR
                            , W_START_YEAR                IN EAPP_CALENDAR_YEAR.YEAR_STRING%TYPE DEFAULT NULL
                            , W_END_YEAR                  IN EAPP_CALENDAR_YEAR.YEAR_STRING%TYPE DEFAULT NULL);
                            
                            
-- 월 조회 LOOK UP.
  PROCEDURE LU_CALENDAR_MONTH_NUM(P_CURSOR                  OUT TYPES.TCURSOR
																, W_LANG_CODE               IN EAPP_CALENDAR_MONTH.LANG_CODE%TYPE DEFAULT NULL
																, W_START_MONTH             IN EAPP_CALENDAR_MONTH.MONTH%TYPE DEFAULT NULL
																, W_END_MONTH               IN EAPP_CALENDAR_MONTH.MONTH%TYPE DEFAULT NULL);


-- 월 조회 LOOK UP.
  PROCEDURE LU_CALENDAR_MONTH_STR(P_CURSOR1                 OUT TYPES.TCURSOR
																, W_LANG_CODE               IN EAPP_CALENDAR_MONTH.LANG_CODE%TYPE DEFAULT NULL
																, W_START_MONTH             IN EAPP_CALENDAR_MONTH.MONTH_STRING%TYPE DEFAULT NULL
																, W_END_MONTH               IN EAPP_CALENDAR_MONTH.MONTH_STRING%TYPE DEFAULT NULL);


-- 년월 조회 LOOK UP.
  PROCEDURE LU_CALENDAR_YYYYMM(P_CURSOR                     OUT TYPES.TCURSOR
															, W_START_YYYYMM              IN EAPP_CALENDAR_YYYYMM_V.YYYYMM%TYPE DEFAULT NULL
															, W_END_YYYYMM                IN EAPP_CALENDAR_YYYYMM_V.YYYYMM%TYPE DEFAULT NULL);

-- 년월 조회 미래 3개월 LOOK UP.
  PROCEDURE LU_CALENDAR_YYYYMM_3
            ( P_CURSOR                    OUT TYPES.TCURSOR
            , W_START_YYYYMM              IN EAPP_CALENDAR_YYYYMM_V.YYYYMM%TYPE DEFAULT NULL
            , W_END_YYYYMM                IN EAPP_CALENDAR_YYYYMM_V.YYYYMM%TYPE DEFAULT NULL
            );

-- 년월 조회 미래 12개월 LOOK UP.
  PROCEDURE LU_CALENDAR_YYYYMM_12
            ( P_CURSOR                    OUT TYPES.TCURSOR
            , W_START_YYYYMM              IN EAPP_CALENDAR_YYYYMM_V.YYYYMM%TYPE DEFAULT NULL
            , W_END_YYYYMM                IN EAPP_CALENDAR_YYYYMM_V.YYYYMM%TYPE DEFAULT NULL
            );

-- 년 주차 및 시작일자 조회 LOOK UP.
  PROCEDURE LU_YEAR_WEEKLY( P_CURSOR3           OUT TYPES.TCURSOR3
                          , W_YEAR              IN  VARCHAR2);

-- 해당일자에 대해 년 주차 조회.
  PROCEDURE GET_YEAR_WEEKLY ( W_DATE        IN  DATE
                            , O_WEEKLY      OUT VARCHAR2);
                            
END EAPP_CALENDAR_G; 
/
CREATE OR REPLACE PACKAGE BODY EAPP_CALENDAR_G
AS
/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : EAPP_CALENDAR_YEAR_G
/* Description  : 년도 및 년월 관리 PACKAGE
/*
/* Reference by : 년도 및 년월을 관리.
/* Program History :
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
-- 년도 조회 LOOK UP.
  PROCEDURE LU_CALENDAR_YEAR_NUM(P_CURSOR                     OUT TYPES.TCURSOR
															, W_START_YEAR                  IN EAPP_CALENDAR_YEAR.YEAR%TYPE DEFAULT NULL
															, W_END_YEAR                    IN EAPP_CALENDAR_YEAR.YEAR%TYPE DEFAULT NULL)
  AS
	  N_YEAR                                                    NUMBER;

  BEGIN
	  N_YEAR := TO_CHAR(SYSDATE, 'YYYY');

    OPEN P_CURSOR FOR
			SELECT CY.YEAR
			FROM EAPP_CALENDAR_YEAR CY
			WHERE CY.YEAR                                            BETWEEN NVL(W_START_YEAR, CY.YEAR) AND NVL(W_END_YEAR, N_YEAR)
			ORDER BY CY.YEAR DESC
			;

  END LU_CALENDAR_YEAR_NUM;

-- 년도 조회 LOOK UP.
  PROCEDURE LU_CALENDAR_YEAR_STR(P_CURSOR1                     OUT TYPES.TCURSOR
															, W_START_YEAR                   IN EAPP_CALENDAR_YEAR.YEAR_STRING%TYPE DEFAULT NULL
															, W_END_YEAR                     IN EAPP_CALENDAR_YEAR.YEAR_STRING%TYPE DEFAULT NULL)
  AS
    V_YEAR                                                     VARCHAR2(4);

  BEGIN
	  V_YEAR := TO_CHAR(SYSDATE, 'YYYY');

    OPEN P_CURSOR1 FOR
			SELECT CY.YEAR
			FROM EAPP_CALENDAR_YEAR CY
			WHERE CY.YEAR_STRING                                     BETWEEN NVL(W_START_YEAR, CY.YEAR_STRING) AND NVL(W_END_YEAR, V_YEAR)
			ORDER BY CY.YEAR DESC
				;

  END LU_CALENDAR_YEAR_STR;

-- 년도 조회 LOOK UP.
  PROCEDURE LU_CALENDAR_YEAR(P_CURSOR1                    OUT TYPES.TCURSOR
                            , W_START_YEAR                IN EAPP_CALENDAR_YEAR.YEAR_STRING%TYPE DEFAULT NULL
                            , W_END_YEAR                  IN EAPP_CALENDAR_YEAR.YEAR_STRING%TYPE DEFAULT NULL)
  AS
    V_YEAR                                                     VARCHAR2(4);

  BEGIN
	  V_YEAR := TO_CHAR(SYSDATE, 'YYYY');

    OPEN P_CURSOR1 FOR
			SELECT CY.YEAR_STRING AS YEAR
           , TO_DATE(CY.YEAR || '-01-01', 'YYYY-MM-DD') AS START_DATE
           , TO_DATE(CY.YEAR || '-12-31', 'YYYY-MM-DD') AS END_DATE
			  FROM EAPP_CALENDAR_YEAR CY
			WHERE CY.YEAR_STRING                                     BETWEEN NVL(W_START_YEAR, CY.YEAR_STRING) AND NVL(W_END_YEAR, V_YEAR)
			ORDER BY CY.YEAR DESC
	    ;
  END LU_CALENDAR_YEAR;
  

-- 월 조회 LOOK UP.
  PROCEDURE LU_CALENDAR_MONTH_NUM(P_CURSOR                  OUT TYPES.TCURSOR
																, W_LANG_CODE               IN EAPP_CALENDAR_MONTH.LANG_CODE%TYPE DEFAULT NULL
																, W_START_MONTH             IN EAPP_CALENDAR_MONTH.MONTH%TYPE DEFAULT NULL
																, W_END_MONTH               IN EAPP_CALENDAR_MONTH.MONTH%TYPE DEFAULT NULL)
  AS
	  V_LANG_CODE                                             VARCHAR2(10);
		N_END_MONTH                                             NUMBER;

  BEGIN
	  V_LANG_CODE := USERENV_G.GET_TERRITORY_S_F;
		N_END_MONTH := TO_CHAR(SYSDATE, 'MM');

    OPEN P_CURSOR FOR
			SELECT CM.MONTH
					, CM.MONTH_STRING
					, CM.FULL_NAME
					, CM.SHORT_NAME
					, CM.LANG_CODE
			FROM EAPP_CALENDAR_MONTH CM
			WHERE CM.LANG_CODE                                    = NVL(W_LANG_CODE, V_LANG_CODE)
				AND CM.MONTH                                        BETWEEN NVL(W_START_MONTH, CM.MONTH) AND NVL(W_END_MONTH, N_END_MONTH)
			;

  END LU_CALENDAR_MONTH_NUM;

-- 월 조회 LOOK UP.
  PROCEDURE LU_CALENDAR_MONTH_STR(P_CURSOR1                 OUT TYPES.TCURSOR
																, W_LANG_CODE               IN EAPP_CALENDAR_MONTH.LANG_CODE%TYPE DEFAULT NULL
																, W_START_MONTH             IN EAPP_CALENDAR_MONTH.MONTH_STRING%TYPE DEFAULT NULL
																, W_END_MONTH               IN EAPP_CALENDAR_MONTH.MONTH_STRING%TYPE DEFAULT NULL)
  AS
	  V_LANG_CODE                                             VARCHAR2(10);
		V_END_MONTH                                             VARCHAR2(2);

  BEGIN
	  V_LANG_CODE := USERENV_G.GET_TERRITORY_S_F;
		V_END_MONTH := TO_CHAR(SYSDATE, 'MM');

		OPEN P_CURSOR1 FOR
			SELECT CM.MONTH
					, CM.MONTH_STRING
					, CM.FULL_NAME
					, CM.SHORT_NAME
					, CM.LANG_CODE
			FROM EAPP_CALENDAR_MONTH CM
			WHERE CM.LANG_CODE                                    = NVL(W_LANG_CODE, V_LANG_CODE)
				AND CM.MONTH_STRING                                 BETWEEN NVL(W_START_MONTH, CM.MONTH_STRING) AND NVL(W_END_MONTH, V_END_MONTH)
			;

  END LU_CALENDAR_MONTH_STR;


-- 년월 조회 LOOK UP.
  PROCEDURE LU_CALENDAR_YYYYMM(P_CURSOR                     OUT TYPES.TCURSOR
															, W_START_YYYYMM              IN EAPP_CALENDAR_YYYYMM_V.YYYYMM%TYPE DEFAULT NULL
															, W_END_YYYYMM                IN EAPP_CALENDAR_YYYYMM_V.YYYYMM%TYPE DEFAULT NULL)
  AS
	  V_END_YYYYMM                                            VARCHAR2(7);

  BEGIN
    V_END_YYYYMM := TO_CHAR(ADD_MONTHS(SYSDATE, 1), 'YYYY-MM');

		OPEN P_CURSOR FOR
			SELECT CY.YYYYMM
			FROM EAPP_CALENDAR_YYYYMM_V CY
			WHERE CY.YYYYMM                                       BETWEEN NVL(W_START_YYYYMM, CY.YYYYMM) AND NVL(W_END_YYYYMM, V_END_YYYYMM)
			ORDER BY CY.YYYYMM DESC
			;

  END LU_CALENDAR_YYYYMM;

-- 년월 조회 미래 3개월 LOOK UP.
  PROCEDURE LU_CALENDAR_YYYYMM_3
            ( P_CURSOR                    OUT TYPES.TCURSOR
            , W_START_YYYYMM              IN EAPP_CALENDAR_YYYYMM_V.YYYYMM%TYPE DEFAULT NULL
            , W_END_YYYYMM                IN EAPP_CALENDAR_YYYYMM_V.YYYYMM%TYPE DEFAULT NULL
            )
  AS
    V_END_YYYYMM                          VARCHAR2(7);

  BEGIN
    V_END_YYYYMM := TO_CHAR(ADD_MONTHS(SYSDATE, 3), 'YYYY-MM');
		OPEN P_CURSOR FOR
			SELECT CY.YYYYMM
			FROM EAPP_CALENDAR_YYYYMM_V CY
			WHERE CY.YYYYMM                BETWEEN NVL(W_START_YYYYMM, CY.YYYYMM) AND NVL(W_END_YYYYMM, V_END_YYYYMM)
			ORDER BY CY.YYYYMM DESC
			;
  END LU_CALENDAR_YYYYMM_3;

-- 년월 조회 미래 12개월 LOOK UP.
  PROCEDURE LU_CALENDAR_YYYYMM_12
            ( P_CURSOR                    OUT TYPES.TCURSOR
            , W_START_YYYYMM              IN EAPP_CALENDAR_YYYYMM_V.YYYYMM%TYPE DEFAULT NULL
            , W_END_YYYYMM                IN EAPP_CALENDAR_YYYYMM_V.YYYYMM%TYPE DEFAULT NULL
            )
  AS
    V_END_YYYYMM                          VARCHAR2(7);

  BEGIN
    V_END_YYYYMM := TO_CHAR(ADD_MONTHS(SYSDATE, 12), 'YYYY-MM');
		OPEN P_CURSOR FOR
			SELECT CY.YYYYMM
			FROM EAPP_CALENDAR_YYYYMM_V CY
			WHERE CY.YYYYMM                BETWEEN NVL(W_START_YYYYMM, CY.YYYYMM) AND NVL(W_END_YYYYMM, V_END_YYYYMM)
			ORDER BY CY.YYYYMM DESC
			;
  END LU_CALENDAR_YYYYMM_12;

-- 년 주차 및 시작일자 조회 LOOK UP.
  PROCEDURE LU_YEAR_WEEKLY( P_CURSOR3           OUT TYPES.TCURSOR3
                          , W_YEAR              IN  VARCHAR2)
  AS
  BEGIN
    OPEN P_CURSOR3 FOR
      SELECT DISTINCT 
             W_YEAR || TO_CHAR(TRUNC(SX.YEAR_DATE, 'IW'), 'WW') AS WEEKLY_CODE
           , TO_CHAR(TRUNC(SX.YEAR_DATE, 'IW'), 'YYYYMMDD') AS YEAR_MONDAY
        FROM ( SELECT TO_DATE(W_YEAR || '-01-01', 'YYYY-MM-DD') + LEVEL - DECODE(LEVEL, 1, 1, 0) AS YEAR_DATE
                 FROM DUAL
               CONNECT BY LEVEL <= (TO_DATE(W_YEAR || '-12-31', 'YYYY-MM-DD') - TO_DATE(W_YEAR || '-01-01', 'YYYY-MM-DD') + 1)
             ) SX
      WHERE SX.YEAR_DATE                BETWEEN TO_DATE(W_YEAR || '-01-01', 'YYYY-MM-DD') AND TO_DATE(W_YEAR || '-12-31', 'YYYY-MM-DD')
      ORDER BY WEEKLY_CODE
      ;
  END LU_YEAR_WEEKLY;


-- 해당일자에 대해 년 주차 조회.
  PROCEDURE GET_YEAR_WEEKLY ( W_DATE        IN  DATE
                            , O_WEEKLY      OUT VARCHAR2)
  AS
  BEGIN
    BEGIN
      SELECT TO_CHAR(W_DATE, 'YYYY') || TO_CHAR(W_DATE, 'WW')
        INTO O_WEEKLY
        FROM DUAL;
    EXCEPTION WHEN OTHERS THEN
      O_WEEKLY := NULL;    
    END;
  END GET_YEAR_WEEKLY;  
    
END EAPP_CALENDAR_G; 
/
