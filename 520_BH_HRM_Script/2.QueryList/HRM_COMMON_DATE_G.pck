CREATE OR REPLACE PACKAGE HRM_COMMON_DATE_G
AS
-- ����� ���� �� ������ ��ȸ LOOK UP.
  PROCEDURE YYYYMM_TERM_P
						( W_YYYYMM                            IN EAPP_CALENDAR_YYYYMM_V.YYYYMM%TYPE
						, W_WORK_TERM_TYPE                    IN HRM_WORK_TERM_V.DUTY_TERM_TYPE%TYPE
						, W_JOB_CATEGORY_CODE                 IN HRM_COMMON.CODE%TYPE DEFAULT NULL
						, W_SOB_ID                            IN HRM_WORK_TERM_V.SOB_ID%TYPE
						, W_ORG_ID                            IN HRM_WORK_TERM_V.ORG_ID%TYPE
						, O_START_DATE                        OUT HRD_WORK_CALENDAR.WORK_DATE%TYPE
						, O_END_DATE                          OUT HRD_WORK_CALENDAR.WORK_DATE%TYPE
						);

-- �� ��¥ ������ �ϼ� ��ȯ.
  FUNCTION PERIOD_DAY_F
	          ( P_START_DATE                        IN DATE
						, P_END_DATE                          IN DATE
						, P_ADD_DAY                           IN NUMBER
						) RETURN NUMBER;

-- �� ��¥ ������ ���� ��ȯ.
  FUNCTION PERIOD_MONTH_F
	          ( P_START_DATE                        IN DATE
						, P_END_DATE                          IN DATE
            , P_ROUNDING_TYPE                     IN VARCHAR2 DEFAULT 'TRUNC'
						, P_START_ADD_DAY                     IN NUMBER DEFAULT 0
						, P_END_ADD_DAY                       IN NUMBER DEFAULT 0
						) RETURN NUMBER;

-- �ټӳ�� ���.
  FUNCTION PERIOD_YEAR_F
	          ( P_START_DATE                        IN DATE
            , P_END_DATE                          IN DATE
					  , P_ROUNDING_TYPE                     IN VARCHAR2 DEFAULT ''
						, P_START_ADD_DAY                     IN NUMBER DEFAULT 0
						, P_END_ADD_DAY                       IN NUMBER DEFAULT 0
					  ) RETURN NUMBER;

-- �ٹ��ϼ� ��ȸ(�� �� ��).
  FUNCTION PERIOD_YYYY_MM_DD_F
            ( P_START_DATE                        IN DATE
            , P_END_DATE                          IN DATE
						, P_START_ADD_DAY                     IN NUMBER DEFAULT 0
						, P_END_ADD_DAY                       IN NUMBER DEFAULT 0
					  ) RETURN VARCHAR2;
            
-- �ټӳ�� ���.
  FUNCTION YEAR_COUNT_F
	         ( P_START_DATE                         IN DATE
           , P_END_DATE                           IN DATE
					 , P_COUNT_TYPE                         IN VARCHAR2 DEFAULT ''
					 , P_ROUND_BIT_OVER                     IN NUMBER DEFAULT 0
					 ) RETURN NUMBER;

  PROCEDURE YEAR_COUNT_P
	          ( P_START_DATE                        IN DATE
						, P_END_DATE                          IN DATE
						, P_COUNT_TYPE                        IN VARCHAR2 DEFAULT ''
						, P_ROUND_BIT_OVER                    IN NUMBER DEFAULT 0
						, O_RETURN_VALUE                      OUT VARCHAR2
						);
						

---------------------------------------------------------------------------------------------------
-- �������� 3���� �ϼ� ���  
  FUNCTION RETIRE_DATE_3RD_DAY
            ( W_RETIRE_DATE       IN HRM_PERSON_MASTER.RETIRE_DATE%TYPE
            , W_SOB_ID            IN HRM_PERSON_MASTER.SOB_ID%TYPE
						, W_ORG_ID            IN HRM_PERSON_MASTER.ORG_ID%TYPE
            ) RETURN NUMBER;
                                                  
---------------------------------------------------------------------------------------------------
-- ��� �־ �������� 3���� �ϼ� ��� ..
  FUNCTION RETIRE_PERSON_3RD_DAY
            ( W_PERSON_ID         IN HRM_PERSON_MASTER.PERSON_ID%TYPE
            , W_SOB_ID            IN HRM_PERSON_MASTER.SOB_ID%TYPE
						, W_ORG_ID            IN HRM_PERSON_MASTER.ORG_ID%TYPE
            ) RETURN NUMBER;  
                                         
---------------------------------------------------------------------------------------------------
-- �������� 3���� �ϼ� ���                
  FUNCTION RETIRE_3RD_DAY
            ( W_PERSON_ID         IN HRM_PERSON_MASTER.PERSON_ID%TYPE
            , W_RETIRE_DATE       IN HRM_PERSON_MASTER.RETIRE_DATE%TYPE
            , W_SOB_ID            IN HRM_PERSON_MASTER.SOB_ID%TYPE
						, W_ORG_ID            IN HRM_PERSON_MASTER.ORG_ID%TYPE
            ) RETURN NUMBER;                                           

---------------------------------------------------------------------------------------------------
-- ��� ��ȸ LOOK UP.
  PROCEDURE LU_CALENDAR_YYYYMM
	          ( P_CURSOR                            OUT TYPES.TCURSOR
						, W_START_YYYYMM                      IN EAPP_CALENDAR_YYYYMM_V.YYYYMM%TYPE DEFAULT NULL
						, W_END_YYYYMM                        IN EAPP_CALENDAR_YYYYMM_V.YYYYMM%TYPE DEFAULT NULL
						, W_WORK_TERM_TYPE                    IN HRM_WORK_TERM_V.DUTY_TERM_TYPE%TYPE
						, W_JOB_CATEGORY_CODE                 IN HRM_COMMON.CODE%TYPE DEFAULT NULL
						, W_SOB_ID                            IN HRM_WORK_TERM_V.SOB_ID%TYPE
						, W_ORG_ID                            IN HRM_WORK_TERM_V.ORG_ID%TYPE
						);
						
END HRM_COMMON_DATE_G;


 
/
CREATE OR REPLACE PACKAGE BODY HRM_COMMON_DATE_G
AS
/******************************************************************************/
/* PROJECT      : FPCB ERP
/* MODULE       : EAPP
/* PROGRAM NAME : HRM_COMMON_DATE_G
/* DESCRIPTION  : ��¥���� ���� ��Ű��.
/* REFERENCE BY :
/* PROGRAM HISTORY : �ű� ����
/*------------------------------------------------------------------------------
/*   DATE       IN CHARGE          DESCRIPTION
/*------------------------------------------------------------------------------
/* 20-JUN-2010  JEON HO SU          INITIALIZE
/******************************************************************************/
-- ����� ���� �� ������ ��ȸ LOOK UP.
  PROCEDURE YYYYMM_TERM_P
            ( W_YYYYMM                            IN EAPP_CALENDAR_YYYYMM_V.YYYYMM%TYPE
						, W_WORK_TERM_TYPE                    IN HRM_WORK_TERM_V.DUTY_TERM_TYPE%TYPE
						, W_JOB_CATEGORY_CODE                 IN HRM_COMMON.CODE%TYPE DEFAULT NULL
            , W_SOB_ID                            IN HRM_WORK_TERM_V.SOB_ID%TYPE
            , W_ORG_ID                            IN HRM_WORK_TERM_V.ORG_ID%TYPE
            , O_START_DATE                        OUT HRD_WORK_CALENDAR.WORK_DATE%TYPE
            , O_END_DATE                          OUT HRD_WORK_CALENDAR.WORK_DATE%TYPE
            )
  AS
    D_START_DATE                                  DATE := NULL;
    D_END_DATE                                    DATE := NULL;
    
  BEGIN
    BEGIN
      SELECT ADD_MONTHS(TO_DATE(W_YYYYMM || '-' || WT.START_DAY, 'YYYY-MM-DD'), NVL(WT.START_ADD_MONTH, 0)) + NVL(WT.START_ADD_DAY, 0) START_DATE
           , ADD_MONTHS(TO_DATE(W_YYYYMM || '-' || WT.END_DAY, 'YYYY-MM-DD'), NVL(WT.END_ADD_MONTH, 0)) + NVL(WT.END_ADD_DAY, 0) END_DATE
        INTO D_START_DATE, D_END_DATE
        FROM HRM_WORK_TERM_V WT
     WHERE WT.DUTY_TERM_TYPE                = W_WORK_TERM_TYPE
			 AND WT.JOB_CATEGORY_CODE             = NVL(W_JOB_CATEGORY_CODE, WT.JOB_CATEGORY_CODE)
       AND WT.SOB_ID                        = W_SOB_ID
       AND WT.ORG_ID                        = W_ORG_ID
      ;  
    EXCEPTION WHEN OTHERS THEN
      D_START_DATE := TO_DATE(W_YYYYMM || '-01', 'YYYY-MM-DD');
      D_END_DATE := ADD_MONTHS(D_START_DATE, 1) - 1;
    END;
    O_START_DATE := D_START_DATE;
		O_END_DATE := D_END_DATE;
		
  END YYYYMM_TERM_P;  	
	
-- �� ��¥ ������ �ϼ� ��ȯ.
  FUNCTION PERIOD_DAY_F
	          ( P_START_DATE                        IN DATE
						, P_END_DATE                          IN DATE
						, P_ADD_DAY                           IN NUMBER
						) RETURN NUMBER
  AS
	  V_DAY                                         NUMBER := 0;

	BEGIN
	  BEGIN
	    V_DAY := (P_END_DATE - P_START_DATE) + P_ADD_DAY;
		EXCEPTION WHEN OTHERS THEN
		  DBMS_OUTPUT.PUT_LINE('PERIOD_DAY_CAL_ERROR : ' || SQLERRM);
		END;
	  RETURN V_DAY;

	END PERIOD_DAY_F;

-- �� ��¥ ������ ���� ��ȯ.
  FUNCTION PERIOD_MONTH_F
	          ( P_START_DATE                        IN DATE
						, P_END_DATE                          IN DATE
            , P_ROUNDING_TYPE                     IN VARCHAR2 DEFAULT 'TRUNC'
						, P_START_ADD_DAY                     IN NUMBER DEFAULT 0
						, P_END_ADD_DAY                       IN NUMBER DEFAULT 0
						) RETURN NUMBER
  AS
    V_LONG_MONTH                                  NUMBER := 0;
    V_ADD_DAY                                     NUMBER := 0;
    
  BEGIN
    IF P_START_DATE IS NULL OR P_END_DATE IS NULL THEN
			RETURN V_LONG_MONTH;
		END IF;
    
    -- ���� �� �ϰ�� 1�� ������.
    IF TO_CHAR(P_START_DATE, 'DD') = TO_CHAR(P_END_DATE, 'DD') THEN
      V_ADD_DAY := 1;
    END IF;
    
    V_LONG_MONTH  := MONTHS_BETWEEN((P_END_DATE + V_ADD_DAY + NVL(P_END_ADD_DAY, 0)), (P_START_DATE + NVL(P_START_ADD_DAY, 0)));
      
		-- ��� Ÿ�Ժ� ó��.
		IF P_ROUNDING_TYPE = 'CEIL' THEN
			V_LONG_MONTH := CEIL(V_LONG_MONTH);
		ELSIF P_ROUNDING_TYPE = 'ROUND' THEN
			V_LONG_MONTH := ROUND(V_LONG_MONTH);
		ELSE
			V_LONG_MONTH := TRUNC(V_LONG_MONTH);
		END IF;
		RETURN V_LONG_MONTH;
    
    RETURN V_LONG_MONTH;
    
  END PERIOD_MONTH_F;
  
-- �ټӳ�� ���.
  FUNCTION PERIOD_YEAR_F
	          ( P_START_DATE                        IN DATE
            , P_END_DATE                          IN DATE
					  , P_ROUNDING_TYPE                     IN VARCHAR2 DEFAULT ''
						, P_START_ADD_DAY                     IN NUMBER DEFAULT 0
						, P_END_ADD_DAY                       IN NUMBER DEFAULT 0
					  ) RETURN NUMBER
  AS
    N_YEAR_COUNT                                  NUMBER := 0;
    V_ADD_DAY                                     NUMBER := 0;
  BEGIN
		N_YEAR_COUNT := 0;
		IF P_START_DATE IS NULL OR P_END_DATE IS NULL THEN
			N_YEAR_COUNT := 0;
			RETURN N_YEAR_COUNT;
		END IF;
    
    -- ���� �� �ϰ�� 1�� ������.
    IF TO_CHAR(P_START_DATE, 'DD') = TO_CHAR(P_END_DATE, 'DD') THEN
      V_ADD_DAY := 1;
    END IF;
    
		-- ��� Ÿ�Ժ� ó��.
		IF P_ROUNDING_TYPE = 'CEIL' THEN
			N_YEAR_COUNT := CEIL(((P_END_DATE + V_ADD_DAY + NVL(P_END_ADD_DAY, 0)) - (P_START_DATE + NVL(P_START_ADD_DAY, 0))) / 365);
		ELSIF P_ROUNDING_TYPE = 'ROUND' THEN
			N_YEAR_COUNT := ROUND(((P_END_DATE + V_ADD_DAY + NVL(P_END_ADD_DAY, 0)) - (P_START_DATE + NVL(P_START_ADD_DAY, 0))) / 365);
		ELSIF P_ROUNDING_TYPE = 'TRUNC' THEN
			N_YEAR_COUNT := TRUNC(((P_END_DATE + V_ADD_DAY + NVL(P_END_ADD_DAY, 0)) - (P_START_DATE + NVL(P_START_ADD_DAY, 0))) / 365);
		ELSE
			N_YEAR_COUNT := ((P_END_DATE + V_ADD_DAY + NVL(P_END_ADD_DAY, 0)) - (P_START_DATE + NVL(P_START_ADD_DAY, 0))) / 365;
		END IF;
		RETURN N_YEAR_COUNT;  
  
  END PERIOD_YEAR_F;  

-- �ٹ��ϼ� ��ȸ(�� �� ��).
  FUNCTION PERIOD_YYYY_MM_DD_F
            ( P_START_DATE                        IN DATE
            , P_END_DATE                          IN DATE
						, P_START_ADD_DAY                     IN NUMBER DEFAULT 0
						, P_END_ADD_DAY                       IN NUMBER DEFAULT 0
					  ) RETURN VARCHAR2
  AS
    V_START_DATE                                  DATE;
    V_END_DATE                                    DATE;
    V_TEMP_DATE                                   DATE;
    V_YYYY_MM_DD                                  VARCHAR2(50);
    V_YEAR                                        NUMBER;
    V_MONTH                                       NUMBER;
    V_DAY                                         NUMBER;    
  BEGIN
    -- ��¥ ����.
    V_START_DATE := P_START_DATE + P_START_ADD_DAY;
    V_END_DATE := P_END_DATE + P_END_ADD_DAY;
    
    -- 1 �⵵.
    SELECT TRUNC(TRUNC(MONTHS_BETWEEN(V_END_DATE, V_START_DATE)) / 12)
      INTO V_YEAR
      FROM DUAL;
    
    -- 2 �⵵ ������ ���ο� ����.
    V_TEMP_DATE := ADD_MONTHS(V_START_DATE, V_YEAR * 12);
    -- 2.1 ����.
    SELECT TRUNC(MONTHS_BETWEEN(V_END_DATE, V_TEMP_DATE))
      INTO V_MONTH
      FROM DUAL;
    
    -- 3 �⵵, ������ ������ ���ο� ����.
    V_TEMP_DATE := ADD_MONTHS(V_START_DATE, (V_YEAR * 12) + V_MONTH);
    -- 2.1 �ϼ�.
    SELECT TRUNC(V_END_DATE - V_TEMP_DATE)
      INTO V_DAY
      FROM DUAL;
    
    -- �Ⱓ ����.
    SELECT DECODE(NVL(V_YEAR, 0), 0, NULL, TO_CHAR(V_YEAR)) || 
           DECODE(NVL(V_YEAR, 0), 0, NULL, '��  ') ||
           TO_CHAR(V_MONTH) || '����  ' || TO_CHAR(V_DAY) || '��'
      INTO V_YYYY_MM_DD
      FROM DUAL;
    RETURN V_YYYY_MM_DD;
  END PERIOD_YYYY_MM_DD_F;
  
-- �ټӳ�� ���.
  FUNCTION YEAR_COUNT_F
	         ( P_START_DATE                         IN DATE
           , P_END_DATE                           IN DATE
					 , P_COUNT_TYPE                         IN VARCHAR2 DEFAULT ''
					 , P_ROUND_BIT_OVER                     IN NUMBER DEFAULT 0
					 ) RETURN NUMBER
  AS
    N_YEAR_COUNT                                  NUMBER := 0;
  
  BEGIN
		N_YEAR_COUNT := 0;
		IF P_START_DATE IS NULL OR P_END_DATE IS NULL THEN
			N_YEAR_COUNT := 0;
			RETURN N_YEAR_COUNT;
		END IF;
      
		-- ��� Ÿ�Ժ� ó��.
		IF P_COUNT_TYPE = 'CEIL' THEN
			N_YEAR_COUNT := CEIL((P_END_DATE - P_START_DATE) / 365);
		ELSIF P_COUNT_TYPE = 'ROUND' THEN
			N_YEAR_COUNT := ROUND((P_END_DATE - P_START_DATE) / 365, P_ROUND_BIT_OVER);
		ELSIF P_COUNT_TYPE = 'TRUNC' THEN
			N_YEAR_COUNT := TRUNC((P_END_DATE - P_START_DATE) / 365);
		ELSE
			N_YEAR_COUNT := (P_END_DATE - P_START_DATE) / 365;
		END IF;
		RETURN N_YEAR_COUNT;
      
  END YEAR_COUNT_F;

	PROCEDURE YEAR_COUNT_P
	          ( P_START_DATE                        IN DATE
						, P_END_DATE                          IN DATE
						, P_COUNT_TYPE                        IN VARCHAR2 DEFAULT ''
						, P_ROUND_BIT_OVER                    IN NUMBER DEFAULT 0
						, O_RETURN_VALUE                      OUT VARCHAR2
						)
  AS
	  N_YEAR_COUNT                                          NUMBER := 0;
  
  BEGIN
		O_RETURN_VALUE := YEAR_COUNT_F( P_START_DATE => P_START_DATE 
                                  , P_END_DATE => P_END_DATE
                                  , P_COUNT_TYPE => P_COUNT_TYPE
                                  , P_ROUND_BIT_OVER => P_ROUND_BIT_OVER
                                  );
                                  
	END YEAR_COUNT_P;

---------------------------------------------------------------------------------------------------
-- �������� 3���� �ϼ� ���  
  FUNCTION RETIRE_DATE_3RD_DAY
            ( W_RETIRE_DATE       IN HRM_PERSON_MASTER.RETIRE_DATE%TYPE
            , W_SOB_ID            IN HRM_PERSON_MASTER.SOB_ID%TYPE
						, W_ORG_ID            IN HRM_PERSON_MASTER.ORG_ID%TYPE
            ) RETURN NUMBER
  AS
    V_START_DATE     DATE := NULL;
    V_3RD_DAY        NUMBER := 0;
    
    V_STD_MONTH      NUMBER := 3;
    
  BEGIN
    -- �ش� ������ �������� ��ȸ.
    BEGIN
      SELECT LAST_DAY(W_RETIRE_DATE) AS LAST_DAY
      INTO V_START_DATE
      FROM DUAL;    
    EXCEPTION WHEN OTHERS THEN
      V_START_DATE := W_RETIRE_DATE;
    END;
    
    -- ���� ���� .
    BEGIN
      SELECT RS.STD_MONTH 
        INTO V_STD_MONTH
        FROM HRR_RETIRE_STANDARD RS
       WHERE RS.STD_YYYY          = TO_CHAR(W_RETIRE_DATE, 'YYYY')
         AND RS.SOB_ID            = W_SOB_ID
         AND RS.ORG_ID            = W_ORG_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('3rd Standard Month Error =>' || SQLERRM);
      V_STD_MONTH := 3;
    END;
    
--> �������ڰ� ������ ������ ��� 3���� ���� ������ ���ں��� ���. �׿ܿ��� 3���� �������� ���.
    BEGIN
      IF V_START_DATE = W_RETIRE_DATE THEN
        SELECT LAST_DAY(ADD_MONTHS(W_RETIRE_DATE, -V_STD_MONTH)) AS PRE_3RD_MONTH
          INTO V_START_DATE
        FROM DUAL;
        
      ELSE
        SELECT ADD_MONTHS(W_RETIRE_DATE, -V_STD_MONTH) AS PRE_3RD_MONTH
          INTO V_START_DATE
        FROM DUAL;
        
      END IF;
    EXCEPTION WHEN OTHERS THEN
      V_START_DATE := W_RETIRE_DATE;
    END;
    
--> 3���� �ϼ� ���.
    BEGIN
      SELECT W_RETIRE_DATE - V_START_DATE AS V_3RD_DAY
      INTO V_3RD_DAY
      FROM DUAL;
    EXCEPTION WHEN OTHERS THEN
      V_3RD_DAY := 0;
    END;
    
    IF V_3RD_DAY < 0 THEN
        V_3RD_DAY := 0;
    END IF;
    RETURN V_3RD_DAY;
    
  EXCEPTION WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('3rd Calculate Error =>' || SQLERRM);
    RETURN 0;
  END RETIRE_DATE_3RD_DAY;
                                                  
---------------------------------------------------------------------------------------------------
-- ��� �־ �������� 3���� �ϼ� ��� ..
  FUNCTION RETIRE_PERSON_3RD_DAY
            ( W_PERSON_ID         IN HRM_PERSON_MASTER.PERSON_ID%TYPE
            , W_SOB_ID            IN HRM_PERSON_MASTER.SOB_ID%TYPE
						, W_ORG_ID            IN HRM_PERSON_MASTER.ORG_ID%TYPE
            ) RETURN NUMBER
  AS
    V_3RD_DAY        NUMBER := 0;
    V_RETIRE_DATE    DATE;
  BEGIN
    BEGIN  
    -- ������� ������� ��ȸ.
      SELECT PM.RETIRE_DATE
        INTO V_RETIRE_DATE
        FROM HRM_PERSON_MASTER PM
       WHERE PM.PERSON_ID         = W_PERSON_ID 
      ;
    EXCEPTION WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Person''s Retire Date Error =>' || SQLERRM);
      RETURN 0;
    END;
     
    V_3RD_DAY := RETIRE_3RD_DAY ( W_PERSON_ID => W_PERSON_ID
                                , W_RETIRE_DATE => V_RETIRE_DATE
                                , W_SOB_ID => W_SOB_ID
                                , W_ORG_ID => W_ORG_ID
                                );
    RETURN V_3RD_DAY;

  EXCEPTION WHEN OTHERS THEN 
    RETURN 0;
  END RETIRE_PERSON_3RD_DAY;
                                         
---------------------------------------------------------------------------------------------------
-- �������� 3���� �ϼ� ���                
  FUNCTION RETIRE_3RD_DAY
            ( W_PERSON_ID         IN HRM_PERSON_MASTER.PERSON_ID%TYPE
            , W_RETIRE_DATE       IN HRM_PERSON_MASTER.RETIRE_DATE%TYPE
            , W_SOB_ID            IN HRM_PERSON_MASTER.SOB_ID%TYPE
						, W_ORG_ID            IN HRM_PERSON_MASTER.ORG_ID%TYPE
            ) RETURN NUMBER
  AS
    V_START_DATE     DATE := NULL;
    V_3RD_DAY        NUMBER := 0;       -- 3���� �ϼ�.
    V_DED_3RD_DAY    NUMBER := 0;       -- 3���� ����ϼ� ���� �ϼ�.
    V_STD_MONTH      NUMBER := 3;       -- ���� ����.
    
  BEGIN
    -- �ش� ������ �������� ��ȸ.
    BEGIN
      SELECT LAST_DAY(W_RETIRE_DATE) AS LAST_DAY
      INTO V_START_DATE
      FROM DUAL;    
    EXCEPTION WHEN OTHERS THEN
      V_START_DATE := W_RETIRE_DATE;
    END;
    
    -- ���� ���� .
    BEGIN
      SELECT RS.STD_MONTH 
        INTO V_STD_MONTH
        FROM HRR_RETIRE_STANDARD RS
       WHERE RS.STD_YYYY          = TO_CHAR(W_RETIRE_DATE, 'YYYY')
         AND RS.SOB_ID            = W_SOB_ID
         AND RS.ORG_ID            = W_ORG_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('3rd Standard Month Error =>' || SQLERRM);
      V_STD_MONTH := 3;
    END;
    
--> �������ڰ� ������ ������ ��� 3���� ���� ������ ���ں��� ���. �׿ܿ��� 3���� �������� ���.
    BEGIN
      IF V_START_DATE = W_RETIRE_DATE THEN
        SELECT LAST_DAY(ADD_MONTHS(W_RETIRE_DATE, -V_STD_MONTH)) AS PRE_3RD_MONTH
          INTO V_START_DATE
        FROM DUAL;
        
      ELSE
        SELECT ADD_MONTHS(W_RETIRE_DATE, -V_STD_MONTH) AS PRE_3RD_MONTH
          INTO V_START_DATE
        FROM DUAL;
        
      END IF;
    EXCEPTION WHEN OTHERS THEN
      V_START_DATE := W_RETIRE_DATE;
    END;

-- 3���� ����ϼ� ���� �ϼ�;
    BEGIN      
      SELECT COUNT(WC.PERSON_ID) AS DED_3RD_DAY_COUNT
        INTO V_DED_3RD_DAY
        FROM HRD_WORK_CALENDAR WC
       WHERE WC.WORK_DATE BETWEEN V_START_DATE AND W_RETIRE_DATE
         AND WC.PERSON_ID      = W_PERSON_ID
         AND WC.SOB_ID         = W_SOB_ID
         AND WC.ORG_ID         = W_ORG_ID
         AND EXISTS ( SELECT 'X'
                        FROM HRM_DUTY_CODE_V DC
                       WHERE DC.DUTY_ID       = WC.C_DUTY_ID
                         AND DC.SOB_ID        = WC.SOB_ID
                         AND DC.ORG_ID        = WC.ORG_ID
                         AND DC.RETIRE_DED_3RD_YN  = 'Y'
                    )
     ;
    EXCEPTION WHEN OTHERS THEN
      V_DED_3RD_DAY := 0;    
    END;
    
--> 3���� �ϼ� ���.
    BEGIN
      SELECT W_RETIRE_DATE - V_START_DATE AS V_3RD_DAY
      INTO V_3RD_DAY
      FROM DUAL;
    EXCEPTION WHEN OTHERS THEN
      V_3RD_DAY := 0;
    END;

--> 3���� �ϼ� - ���� �ϼ� ���.
    V_3RD_DAY := NVL(V_3RD_DAY, 0) - NVL(V_DED_3RD_DAY, 0);
    IF V_3RD_DAY < 0 THEN
        V_3RD_DAY := 0;
    END IF;
    RETURN V_3RD_DAY;    
    
  EXCEPTION WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('3rd Day Error =>' || SQLERRM);
    RETURN 0;
  END RETIRE_3RD_DAY;

---------------------------------------------------------------------------------------------------
-- ��� ��ȸ LOOK UP.
  PROCEDURE LU_CALENDAR_YYYYMM
	          ( P_CURSOR                            OUT TYPES.TCURSOR
						, W_START_YYYYMM                      IN EAPP_CALENDAR_YYYYMM_V.YYYYMM%TYPE DEFAULT NULL
						, W_END_YYYYMM                        IN EAPP_CALENDAR_YYYYMM_V.YYYYMM%TYPE DEFAULT NULL
						, W_WORK_TERM_TYPE                    IN HRM_WORK_TERM_V.DUTY_TERM_TYPE%TYPE
						, W_JOB_CATEGORY_CODE                 IN HRM_COMMON.CODE%TYPE DEFAULT NULL
						, W_SOB_ID                            IN HRM_WORK_TERM_V.SOB_ID%TYPE
						, W_ORG_ID                            IN HRM_WORK_TERM_V.ORG_ID%TYPE
						)
  AS
	  V_END_YYYYMM                                  VARCHAR2(7);
		
  BEGIN
	  V_END_YYYYMM := TO_CHAR(GET_LOCAL_DATE(W_SOB_ID), 'YYYY-MM');
		
		OPEN P_CURSOR FOR
			SELECT CY.YYYYMM
           , ADD_MONTHS(TO_DATE(CY.YYYYMM || '-' || SX1.START_DAY, 'YYYY-MM-DD'), NVL(SX1.START_ADD_MONTH, 0)) + NVL(SX1.START_ADD_DAY, 0) START_DATE
           , ADD_MONTHS(TO_DATE(CY.YYYYMM || '-' || SX1.END_DAY, 'YYYY-MM-DD'), NVL(SX1.END_ADD_MONTH, 0)) + NVL(SX1.END_ADD_DAY, 0) END_DATE
      FROM EAPP_CALENDAR_YYYYMM_V CY
        , ( SELECT  WT.DUTY_TERM_TYPE
                  , WT.START_DAY
                  , WT.START_ADD_MONTH
                  , WT.START_ADD_DAY
                  , WT.END_DAY
                  , WT.END_ADD_MONTH
                  , WT.END_ADD_DAY
                  , WT.SOB_ID
                  , WT.ORG_ID
              FROM HRM_WORK_TERM_V WT
             WHERE WT.DUTY_TERM_TYPE                = W_WORK_TERM_TYPE
						   AND WT.JOB_CATEGORY_CODE             = NVL(W_JOB_CATEGORY_CODE, WT.JOB_CATEGORY_CODE)
               AND WT.SOB_ID                        = W_SOB_ID
               AND WT.ORG_ID                        = W_ORG_ID
             ) SX1
      WHERE CY.YYYYMM                               BETWEEN NVL(W_START_YYYYMM, CY.YYYYMM) AND NVL(W_END_YYYYMM, V_END_YYYYMM)
      ORDER BY CY.YYYYMM DESC
			;
			
  END LU_CALENDAR_YYYYMM;
		

END HRM_COMMON_DATE_G;
/
