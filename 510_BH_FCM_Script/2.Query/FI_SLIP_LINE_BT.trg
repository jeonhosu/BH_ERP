CREATE OR REPLACE TRIGGER FI_SLIP_LINE_BT
BEFORE INSERT OR UPDATE OR DELETE ON FI_SLIP_LINE
FOR EACH ROW

DECLARE 
  V_MANAGEMENT_ID       VARCHAR2(100);
  V_MANAGEMENT_VALUE    VARCHAR2(100);
  
BEGIN  

  IF INSERTING THEN
  -- INSERT.
    FOR C1 IN 1.. 10
    LOOP
      V_MANAGEMENT_ID     := NULL;
      V_MANAGEMENT_VALUE  := NULL;
      BEGIN 
        SELECT CASE C1
                 WHEN 1 THEN ACI.MANAGEMENT1_ID
                 WHEN 2 THEN ACI.MANAGEMENT2_ID
                 WHEN 3 THEN ACI.REFER1_ID
                 WHEN 4 THEN ACI.REFER2_ID
                 WHEN 5 THEN ACI.REFER3_ID
                 WHEN 6 THEN ACI.REFER4_ID
                 WHEN 7 THEN ACI.REFER5_ID
                 WHEN 8 THEN ACI.REFER6_ID
                 WHEN 9 THEN ACI.REFER7_ID
                 WHEN 10 THEN ACI.REFER8_ID       
               END AS MANAGEMENT_ID
             , CASE C1
                 WHEN 1 THEN :NEW.MANAGEMENT1
                 WHEN 2 THEN :NEW.MANAGEMENT2
                 WHEN 3 THEN :NEW.REFER1
                 WHEN 4 THEN :NEW.REFER2
                 WHEN 5 THEN :NEW.REFER3
                 WHEN 6 THEN :NEW.REFER4
                 WHEN 7 THEN :NEW.REFER5
                 WHEN 8 THEN :NEW.REFER6
                 WHEN 9 THEN :NEW.REFER7
                 WHEN 10 THEN :NEW.REFER8        
               END AS MANAGEMENT_VALUE
          INTO V_MANAGEMENT_ID, V_MANAGEMENT_VALUE
          FROM FI_ACCOUNT_CONTROL_ITEM ACI
        WHERE ACI.ACCOUNT_CONTROL_ID  = :NEW.ACCOUNT_CONTROL_ID
          AND ACI.ACCOUNT_DR_CR       = :NEW.ACCOUNT_DR_CR
          AND ACI.SOB_ID              = :NEW.SOB_ID
        ;
      EXCEPTION WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10189', NULL));
        RETURN;
      END;
      
      -- 전표 관리항목 내역 삭제.
      FI_SLIP_G.DELETE_MANAGEMENT_ITEM( W_SLIP_LINE_ID => :NEW.SLIP_LINE_ID
                                      , W_SOB_ID => :NEW.SOB_ID
                                      , W_MANAGEMENT_SEQ => C1
                                      );
      IF V_MANAGEMENT_VALUE IS NOT NULL THEN
      -- 전표 관리항목 내역 저장.
        FI_SLIP_G.INSERT_MANAGEMENT_ITEM( P_SLIP_LINE_ID => :NEW.SLIP_LINE_ID
                                        , P_SLIP_DATE => :NEW.SLIP_DATE
                                        , P_SLIP_NUM => :NEW.SLIP_NUM
                                        , P_SLIP_LINE_SEQ => :NEW.SLIP_LINE_SEQ
                                        , P_SLIP_HEADER_ID => :NEW.SLIP_HEADER_ID
                                        , P_SOB_ID => :NEW.SOB_ID
                                        , P_MANAGEMENT_SEQ => C1
                                        , P_MANAGEMENT_ID => V_MANAGEMENT_ID
                                        , P_MANAGEMENT_VALUE => V_MANAGEMENT_VALUE
                                        , P_USER_ID => :NEW.LAST_UPDATED_BY
                                        );
      END IF;
    END LOOP C1;
      
  ELSIF UPDATING THEN
  -- UPDATE.
    FOR C1 IN 1.. 10
    LOOP
      V_MANAGEMENT_ID     := NULL;
      V_MANAGEMENT_VALUE  := NULL;
      BEGIN 
        SELECT CASE C1
                 WHEN 1 THEN ACI.MANAGEMENT1_ID
                 WHEN 2 THEN ACI.MANAGEMENT2_ID
                 WHEN 3 THEN ACI.REFER1_ID
                 WHEN 4 THEN ACI.REFER2_ID
                 WHEN 5 THEN ACI.REFER3_ID
                 WHEN 6 THEN ACI.REFER4_ID
                 WHEN 7 THEN ACI.REFER5_ID
                 WHEN 8 THEN ACI.REFER6_ID
                 WHEN 9 THEN ACI.REFER7_ID
                 WHEN 10 THEN ACI.REFER8_ID       
               END AS MANAGEMENT_ID
             , CASE C1
                 WHEN 1 THEN :NEW.MANAGEMENT1
                 WHEN 2 THEN :NEW.MANAGEMENT2
                 WHEN 3 THEN :NEW.REFER1
                 WHEN 4 THEN :NEW.REFER2
                 WHEN 5 THEN :NEW.REFER3
                 WHEN 6 THEN :NEW.REFER4
                 WHEN 7 THEN :NEW.REFER5
                 WHEN 8 THEN :NEW.REFER6
                 WHEN 9 THEN :NEW.REFER7
                 WHEN 10 THEN :NEW.REFER8        
               END AS MANAGEMENT_VALUE
          INTO V_MANAGEMENT_ID, V_MANAGEMENT_VALUE
          FROM FI_ACCOUNT_CONTROL_ITEM ACI
        WHERE ACI.ACCOUNT_CONTROL_ID  = :NEW.ACCOUNT_CONTROL_ID
          AND ACI.ACCOUNT_DR_CR       = :NEW.ACCOUNT_DR_CR
          AND ACI.SOB_ID              = :NEW.SOB_ID
        ;
      EXCEPTION WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10189', NULL));
        RETURN;
      END;
      
      -- 전표 관리항목 내역 이전 전표 삭제.
      FI_SLIP_G.DELETE_MANAGEMENT_ITEM( W_SLIP_LINE_ID => :OLD.SLIP_LINE_ID
                                      , W_SOB_ID => :OLD.SOB_ID
                                      , W_MANAGEMENT_SEQ => C1
                                      );
                                      
      IF V_MANAGEMENT_VALUE IS NOT NULL THEN
      -- 전표 관리항목 내역 저장.
        FI_SLIP_G.INSERT_MANAGEMENT_ITEM( P_SLIP_LINE_ID => :NEW.SLIP_LINE_ID
                                        , P_SLIP_DATE => :NEW.SLIP_DATE
                                        , P_SLIP_NUM => :NEW.SLIP_NUM
                                        , P_SLIP_LINE_SEQ => :NEW.SLIP_LINE_SEQ
                                        , P_SLIP_HEADER_ID => :NEW.SLIP_HEADER_ID
                                        , P_SOB_ID => :NEW.SOB_ID
                                        , P_MANAGEMENT_SEQ => C1
                                        , P_MANAGEMENT_ID => V_MANAGEMENT_ID
                                        , P_MANAGEMENT_VALUE => V_MANAGEMENT_VALUE
                                        , P_USER_ID => :NEW.LAST_UPDATED_BY
                                        );
      END IF;
    END LOOP C1;
  
  ELSIF DELETING THEN
  -- DELETE.
    -- 전표 관리항목 내역 삭제.
    DELETE FROM FI_SLIP_MANAGEMENT_ITEM MI
    WHERE MI.SLIP_LINE_ID         = :OLD.SLIP_LINE_ID
      AND MI.SOB_ID               = :OLD.SOB_ID
    ;
          
  END IF;

END FI_SLIP_LINE_BT;
/
