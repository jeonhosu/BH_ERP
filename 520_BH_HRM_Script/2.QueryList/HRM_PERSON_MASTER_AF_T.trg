CREATE OR REPLACE TRIGGER HRM_PERSON_MASTER_AF_T
AFTER INSERT OR UPDATE OR DELETE ON APPS.HRM_PERSON_MASTER
FOR EACH ROW

DECLARE
  V_WORK_YYYYMM           VARCHAR2(7);
  V_DUTY_CONTROL_YN       VARCHAR2(2);
  V_WORK_DATE_FR          DATE;
  V_WORK_DATE_TO          DATE;
  V_MESSAGE               VARCHAR2(500);

BEGIN
/*--------------------------------------------------------------------------------------*/
  IF INSERTING THEN
    -- 근무계획 생성.(신규 입사). - 근태관리 업체 소속, 기존 생성 기록 있는 사람에 대해 적용.
    V_WORK_YYYYMM := TO_CHAR(:NEW.ORI_JOIN_DATE, 'YYYY-MM');
    V_DUTY_CONTROL_YN := 'N';
    V_WORK_DATE_FR := NULL;
    V_WORK_DATE_TO := NULL;

    BEGIN
      SELECT CM.DUTY_CONTROL_YN
        INTO V_DUTY_CONTROL_YN
        FROM HRM_CORP_MASTER CM
      WHERE CM.CORP_ID        = :NEW.WORK_CORP_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      NULL;
    END;

    BEGIN
      SELECT WC.WORK_DATE_FR, WC.WORK_DATE_TO
        INTO V_WORK_DATE_FR, V_WORK_DATE_TO
        FROM HRD_WORK_CALENDAR_SET WC
      WHERE WC.CORP_ID            = :NEW.WORK_CORP_ID
        AND WC.WORK_PERIOD        = V_WORK_YYYYMM
        AND WC.WORK_TYPE_ID       = :NEW.WORK_TYPE_ID
        AND WC.CREATED_METHOD     = 'A'
        AND WC.SOB_ID             = :NEW.SOB_ID
        AND WC.ORG_ID             = :NEW.ORG_ID
        AND ROWNUM                <= 1
      ;
    EXCEPTION WHEN OTHERS THEN
      NULL;
    END;
    IF V_DUTY_CONTROL_YN = 'Y' AND V_WORK_DATE_FR IS NOT NULL AND V_WORK_DATE_TO IS NOT NULL THEN
      BEGIN
        HRD_WORK_CALENDAR_G.WORKCAL_SET_TABLE
               ( P_CORP_ID => :NEW.WORK_CORP_ID
               , P_WORK_PERIOD => V_WORK_YYYYMM
               , P_PERSON_ID => :NEW.PERSON_ID
               , P_DEPT_ID => NULL
               , P_WORK_TYPE_ID => :NEW.WORK_TYPE_ID
               , P_WORK_DATE_FR => V_WORK_DATE_FR
               , P_WORK_DATE_TO => V_WORK_DATE_TO
               , P_USER_ID => :NEW.CREATED_BY
               , P_SOB_ID => :NEW.SOB_ID
               , P_ORG_ID => :NEW.ORG_ID
               , O_MESSAGE => V_MESSAGE
               , P_CREATE_TYPE => 'INSA'
               );
      EXCEPTION WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20001, SQLERRM);
      END;
    END IF;
  END IF;

END HRM_PERSON_MASTER_AF_T
;
/
