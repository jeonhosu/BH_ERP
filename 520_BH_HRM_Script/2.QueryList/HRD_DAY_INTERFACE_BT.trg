CREATE OR REPLACE TRIGGER HRD_DAY_INTERFACE_BT
BEFORE INSERT OR UPDATE OR DELETE ON HRD_DAY_INTERFACE
FOR EACH ROW

DECLARE

BEGIN
  IF INSERTING THEN
    UPDATE HRD_WORK_CALENDAR WC
        SET WC.DANGJIK_YN         = :NEW.DANGJIK_YN
          , WC.ALL_NIGHT_YN       = :NEW.ALL_NIGHT_YN
      WHERE WC.WORK_DATE          = :NEW.WORK_DATE
        AND WC.PERSON_ID          = :NEW.PERSON_ID
        AND WC.SOB_ID             = :NEW.SOB_ID
        AND WC.ORG_ID             = :NEW.ORG_ID
      ;
      
  ELSIF UPDATING THEN
    UPDATE HRD_WORK_CALENDAR WC
        SET WC.DANGJIK_YN         = :NEW.DANGJIK_YN
          , WC.ALL_NIGHT_YN       = :NEW.ALL_NIGHT_YN
      WHERE WC.WORK_DATE          = :NEW.WORK_DATE
        AND WC.PERSON_ID          = :NEW.PERSON_ID
        AND WC.SOB_ID             = :NEW.SOB_ID
        AND WC.ORG_ID             = :NEW.ORG_ID
      ;  
  END IF;
END HRD_DAY_INTERFACE_BT;
/
