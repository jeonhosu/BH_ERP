-----------------------------------------------------------------------------------------
-- FUNCTION : 처리 유형별 소숫점 처리.
  CREATE OR REPLACE FUNCTION DECIMAL_F
              ( W_SOB_ID             IN HRM_COMMON.SOB_ID%TYPE
              , W_ORG_ID             IN HRM_COMMON.ORG_ID%TYPE            
              , W_NUMBER             IN NUMBER
              , W_CAL_TYPE           IN VARCHAR2 DEFAULT NULL
              ) RETURN VARCHAR2
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
