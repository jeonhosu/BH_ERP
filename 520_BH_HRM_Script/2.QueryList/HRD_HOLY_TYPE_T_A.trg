CREATE OR REPLACE TRIGGER HRD_HOLY_TYPE_T_A
AFTER INSERT OR UPDATE OR DELETE ON HRD_HOLY_TYPE
FOR EACH ROW

DECLARE

BEGIN
  IF INSERTING THEN
    IF :NEW.APPROVE_STATUS = 'C' THEN
      HRD_HOLY_TYPE_G.WORK_CALENDAR_UPDATE
              ( P_GB => 'I'
              , P_HOLY_TYPE_ID => :NEW.HOLY_TYPE_ID
              , P_PERSON_ID => :NEW.PERSON_ID
              , P_START_DATE => :NEW.START_DATE
              , P_END_DATE => :NEW.END_DATE
              , P_HOLY_TYPE => :NEW.HOLY_TYPE
              , P_SOB_ID => :NEW.SOB_ID
              , P_ORG_ID => :NEW.ORG_ID
              , P_USER_ID => :NEW.LAST_UPDATED_BY
              );
    END IF;
    
  ELSIF UPDATING THEN
    IF :OLD.APPROVE_STATUS = 'C' THEN
      HRD_HOLY_TYPE_G.WORK_CALENDAR_UPDATE
              ( P_GB => 'D'
              , P_HOLY_TYPE_ID => :OLD.HOLY_TYPE_ID
              , P_PERSON_ID => :OLD.PERSON_ID
              , P_START_DATE => :OLD.START_DATE
              , P_END_DATE => :OLD.END_DATE
              , P_HOLY_TYPE => :OLD.HOLY_TYPE
              , P_SOB_ID => :OLD.SOB_ID
              , P_ORG_ID => :OLD.ORG_ID
              , P_USER_ID => :OLD.LAST_UPDATED_BY
              );
    END IF;
    IF :NEW.APPROVE_STATUS = 'C' THEN
      HRD_HOLY_TYPE_G.WORK_CALENDAR_UPDATE
              ( P_GB => 'I'
              , P_HOLY_TYPE_ID => :NEW.HOLY_TYPE_ID
              , P_PERSON_ID => :NEW.PERSON_ID
              , P_START_DATE => :NEW.START_DATE
              , P_END_DATE => :NEW.END_DATE
              , P_HOLY_TYPE => :NEW.HOLY_TYPE
              , P_SOB_ID => :NEW.SOB_ID
              , P_ORG_ID => :NEW.ORG_ID
              , P_USER_ID => :NEW.LAST_UPDATED_BY
              );
    END IF;
  ELSIF DELETING THEN
    IF :OLD.APPROVE_STATUS = 'C' THEN
      HRD_HOLY_TYPE_G.WORK_CALENDAR_UPDATE
              ( P_GB => 'D'
              , P_HOLY_TYPE_ID => :OLD.HOLY_TYPE_ID
              , P_PERSON_ID => :OLD.PERSON_ID
              , P_START_DATE => :OLD.START_DATE
              , P_END_DATE => :OLD.END_DATE
              , P_HOLY_TYPE => :OLD.HOLY_TYPE
              , P_SOB_ID => :OLD.SOB_ID
              , P_ORG_ID => :OLD.ORG_ID
              , P_USER_ID => :OLD.LAST_UPDATED_BY
              );
    END IF;
  END IF;

END HRD_HOLY_TYPE_T_A;
/
