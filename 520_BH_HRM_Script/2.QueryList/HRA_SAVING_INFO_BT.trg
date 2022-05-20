CREATE OR REPLACE TRIGGER HRA_SAVING_INFO_BT
BEFORE INSERT OR UPDATE OR DELETE ON HRA_SAVING_INFO
FOR EACH ROW

DECLARE
  V_GB                            VARCHAR2(1);
BEGIN
  IF INSERTING THEN
  -- 신규.
    V_GB := 'I';
    HRA_SAVING_INFO_G.UPDATE_FOUNDATION
          ( W_GB                => V_GB
          , P_YEAR_YYYY         => :NEW.YEAR_YYYY
          , P_PERSON_ID         => :NEW.PERSON_ID
          , P_SOB_ID            => :NEW.SOB_ID
          , P_ORG_ID            => :NEW.ORG_ID
          , P_SAVING_TYPE       => :NEW.SAVING_TYPE
          , P_SAVING_COUNT      => :NEW.SAVING_COUNT
          , P_SAVING_AMOUNT     => :NEW.SAVING_AMOUNT
          , P_USER_ID           => :NEW.LAST_UPDATED_BY
          );
  ELSIF UPDATING THEN
  -- 업데이트.
    V_GB := 'D';
    HRA_SAVING_INFO_G.UPDATE_FOUNDATION
          ( W_GB                => V_GB
          , P_YEAR_YYYY         => :OLD.YEAR_YYYY
          , P_PERSON_ID         => :OLD.PERSON_ID
          , P_SOB_ID            => :OLD.SOB_ID
          , P_ORG_ID            => :OLD.ORG_ID
          , P_SAVING_TYPE       => :OLD.SAVING_TYPE
          , P_SAVING_COUNT      => :OLD.SAVING_COUNT
          , P_SAVING_AMOUNT     => NVL(:OLD.SAVING_AMOUNT, 0) * -1
          , P_USER_ID           => :OLD.LAST_UPDATED_BY
          );
    V_GB := 'I';
    HRA_SAVING_INFO_G.UPDATE_FOUNDATION
          ( W_GB                => V_GB
          , P_YEAR_YYYY         => :NEW.YEAR_YYYY
          , P_PERSON_ID         => :NEW.PERSON_ID
          , P_SOB_ID            => :NEW.SOB_ID
          , P_ORG_ID            => :NEW.ORG_ID
          , P_SAVING_TYPE       => :NEW.SAVING_TYPE
          , P_SAVING_COUNT      => :NEW.SAVING_COUNT
          , P_SAVING_AMOUNT     => :NEW.SAVING_AMOUNT
          , P_USER_ID           => :NEW.LAST_UPDATED_BY
          );
  ELSIF DELETING THEN
  -- 삭제.
    V_GB := 'D';
    HRA_SAVING_INFO_G.UPDATE_FOUNDATION
          ( W_GB                => V_GB
          , P_YEAR_YYYY         => :OLD.YEAR_YYYY
          , P_PERSON_ID         => :OLD.PERSON_ID
          , P_SOB_ID            => :OLD.SOB_ID
          , P_ORG_ID            => :OLD.ORG_ID
          , P_SAVING_TYPE       => :OLD.SAVING_TYPE
          , P_SAVING_COUNT      => :OLD.SAVING_COUNT
          , P_SAVING_AMOUNT     => NVL(:OLD.SAVING_AMOUNT, 0) * -1
          , P_USER_ID           => :OLD.LAST_UPDATED_BY
          );
  END IF;
END HRA_SAVING_INFO;
/
