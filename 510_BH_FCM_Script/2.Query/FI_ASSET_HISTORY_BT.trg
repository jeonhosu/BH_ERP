CREATE OR REPLACE TRIGGER FI_ASSET_HISTORY_BT
BEFORE INSERT OR UPDATE OR DELETE ON FI_ASSET_HISTORY
FOR EACH ROW

DECLARE
  V_GB                            VARCHAR2(1);
  V_CHARGE_CODE                   VARCHAR2(10);
    
BEGIN
  IF INSERTING THEN
    V_GB := 'I';
    V_CHARGE_CODE := FI_COMMON_G.GET_CODE_F(:NEW.CHARGE_ID, :NEW.SOB_ID);
    FI_ASSET_HISTORY_G.ASSET_MASTER_UPDATE
        ( V_GB
        , :NEW.ASSET_ID
        , :NEW.SOB_ID
        , :NEW.ORG_ID
        , :NEW.HISTORY_NUM
        , :NEW.CHARGE_DATE
        , :NEW.CHARGE_ID
        , V_CHARGE_CODE
        , :NEW.CURR_AMOUNT
        , :NEW.AMOUNT
        , :NEW.DPR_SUM_DC_AMOUNT
        , :NEW.IFRS_DPR_SUM_DC_AMOUNT
        , :NEW.LOCATION_ID
        , :NEW.USE_DEPT_ID
        , :NEW.FIRST_USER
        , :NEW.SECOND_USER
        , :NEW.COST_CENTER_ID
        , :NEW.CREATED_BY         
        );

  ELSIF UPDATING THEN
    V_GB := 'D';
    V_CHARGE_CODE := FI_COMMON_G.GET_CODE_F(:OLD.CHARGE_ID, :OLD.SOB_ID);
    FI_ASSET_HISTORY_G.ASSET_MASTER_UPDATE
        ( V_GB
        , :OLD.ASSET_ID
        , :OLD.SOB_ID
        , :OLD.ORG_ID
        , :OLD.HISTORY_NUM
        , :OLD.CHARGE_DATE
        , :OLD.CHARGE_ID
        , V_CHARGE_CODE
        , 0
        , 0
        , 0
        , 0
        , :OLD.BF_LOCATION_ID
        , :OLD.BF_USE_DEPT_ID
        , :OLD.FIRST_USER
        , :OLD.SECOND_USER
        , :OLD.BF_COST_CENTER_ID
        , :OLD.CREATED_BY
        );

    V_GB := 'U';    
    V_CHARGE_CODE := FI_COMMON_G.GET_CODE_F(:NEW.CHARGE_ID, :NEW.SOB_ID);
    FI_ASSET_HISTORY_G.ASSET_MASTER_UPDATE
        ( V_GB
        , :NEW.ASSET_ID
        , :NEW.SOB_ID
        , :NEW.ORG_ID
        , :NEW.HISTORY_NUM
        , :NEW.CHARGE_DATE
        , :NEW.CHARGE_ID
        , V_CHARGE_CODE
        , :NEW.CURR_AMOUNT
        , :NEW.AMOUNT
        , :NEW.DPR_SUM_DC_AMOUNT
        , :NEW.IFRS_DPR_SUM_DC_AMOUNT
        , :NEW.LOCATION_ID
        , :NEW.USE_DEPT_ID
        , :NEW.FIRST_USER
        , :NEW.SECOND_USER
        , :NEW.COST_CENTER_ID
        , :NEW.CREATED_BY         
        );
  ELSIF DELETING THEN
    V_GB := 'D';
    V_CHARGE_CODE := FI_COMMON_G.GET_CODE_F(:OLD.CHARGE_ID, :OLD.SOB_ID);
    FI_ASSET_HISTORY_G.ASSET_MASTER_UPDATE
        ( V_GB
        , :OLD.ASSET_ID
        , :OLD.SOB_ID
        , :OLD.ORG_ID
        , :OLD.HISTORY_NUM
        , :OLD.CHARGE_DATE
        , :OLD.CHARGE_ID
        , V_CHARGE_CODE
        , 0
        , 0
        , 0
        , 0
        , :OLD.BF_LOCATION_ID
        , :OLD.BF_USE_DEPT_ID
        , :OLD.BF_FIRST_USER
        , :OLD.BF_SECOND_USER
        , :OLD.BF_COST_CENTER_ID
        , :OLD.CREATED_BY         
        );
  END IF;
  
END FI_ASSET_HISTORY_BT;
/
