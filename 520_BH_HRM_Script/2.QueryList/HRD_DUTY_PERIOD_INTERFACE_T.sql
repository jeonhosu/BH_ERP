CREATE OR REPLACE TRIGGER HRD_DUTY_PERIOD_INTERFACE_T
AFTER INSERT OR UPDATE OR DELETE ON HRD_DUTY_PERIOD_INTERFACE
FOR EACH ROW
DECLARE
  V_PERSON_ID          NUMBER;
  V_DUTY_ID            NUMBER;
  V_START_DATETIME     DATE;
  V_END_DATETIME       DATE;
  V_SOB_ID             NUMBER;
  V_ORG_ID             NUMBER;
  
BEGIN
  IF INSERTING THEN
    
    /*HRD_DUTY_PERIOD_G.DATA_INSERT ( P_CORP_ID => :NEW.CORP_ID
                                  , P_PERSON_ID => :NEW.
                                  , P_DUTY_ID => 
                                  , P_START_DATE => 
                                  , P_START_TIME => 
                                  , P_END_DATE => 
                                  , P_END_TIME => 
                                  , P_DESCRIPTION => 
                                  , P_SOB_ID => 
                                  , P_ORG_ID => 
                                  , P_USER_ID => 
                                  , O_DUTY_PERIOD_ID => 
                                  );*/
  ELSIF UPDATING THEN
    NULL;
  ELSIF DELETING THEN
    NULL;
  END IF; 

END HRD_DUTY_PERIOD_INTERFACE_T;
