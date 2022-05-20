CREATE OR REPLACE TRIGGER "HRD_DUTY_PERIOD_INTERFACE_T" 
AFTER INSERT OR UPDATE OR DELETE ON HRD_DUTY_PERIOD_INTERFACE
FOR EACH ROW
DECLARE
  V_PERSON_ID                   NUMBER;
  V_APPORVERD_PERSON_ID         NUMBER;
  V_CONFIRMED_PERSON_ID         NUMBER;
  V_DUTY_ID                     NUMBER;  -- 근태계 ID --
  V_OT_TYPE_ID                  NUMBER;  -- 관리직 잔업/특근 신청ID --
  
  V_STATUS                      VARCHAR2(2);
  V_MESSAGE                     VARCHAR2(200);
  V_APPROVE_STATUS              VARCHAR2(10);
  V_APPROVE_STATUS_NAME         VARCHAR2(100); 
BEGIN
  IF INSERTING THEN
    -- 사원정보.
    BEGIN
      SELECT MAX(DECODE(PM.PERSON_NUM, :NEW.PERSON_NUM, PM.PERSON_ID, NULL))
           , MAX(DECODE(PM.PERSON_NUM, :NEW.APPROVED_PERSON_NUM, PM.PERSON_ID, NULL))
           , MAX(DECODE(PM.PERSON_NUM, :NEW.CONFIRMED_PERSON_NUM, PM.PERSON_ID, NULL))
        INTO V_PERSON_ID, V_APPORVERD_PERSON_ID, V_CONFIRMED_PERSON_ID
        FROM HRM_PERSON_MASTER PM
      WHERE PM.PERSON_NUM       IN(:NEW.PERSON_NUM, :NEW.APPROVED_PERSON_NUM, :NEW.CONFIRMED_PERSON_NUM)
        AND PM.SOB_ID           = :NEW.SOB_ID
        AND PM.ORG_ID           = :NEW.ORG_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10028', NULL));
    END;
    IF (:NEW.PERSON_NUM IS NOT NULL AND V_PERSON_ID IS NULL) OR 
       (:NEW.APPROVED_PERSON_NUM IS NOT NULL AND V_APPORVERD_PERSON_ID IS NULL) OR
       (:NEW.CONFIRMED_PERSON_NUM IS NOT NULL AND V_CONFIRMED_PERSON_ID IS NULL) THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10028', NULL));
    END IF;
    -- 근태코드 변환.
    BEGIN
      SELECT DC.DUTY_ID
        INTO V_DUTY_ID
        FROM HRM_DUTY_CODE_V DC
          , HRM_DUTY_GW_CODE_V DGC
      WHERE DC.DUTY_CODE        = DGC.DUTY_CODE
        AND DC.SOB_ID           = DGC.SOB_ID
        AND DC.ORG_ID           = DGC.ORG_ID
        AND DGC.DUTY_GW_CODE    = :NEW.GW_DUTY_CODE
        AND DGC.SOB_ID          = :NEW.SOB_ID
        AND DGC.ORG_ID          = :NEW.ORG_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE(EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10175', NULL));
    END;

    -- Inser
    IF V_DUTY_ID IS NOT NULL THEN
      HRD_DUTY_PERIOD_G.DATA_INSERT1( P_CORP_ID => :NEW.CORP_ID
                                    , P_PERSON_ID => V_PERSON_ID
                                    , P_DUTY_ID => V_DUTY_ID
                                    , P_START_DATE => TRUNC(:NEW.START_DATE)
                                    , P_START_TIME => TO_CHAR(:NEW.START_DATE, 'HH24:MI')
                                    , P_END_DATE => TRUNC(:NEW.END_DATE)
                                    , P_END_TIME => TO_CHAR(:NEW.END_DATE, 'HH24:MI')
                                    , P_APPROVED_YN => :NEW.APPROVED_YN
                                    , P_APPROVED_DATE => :NEW.APPROVED_DATE
                                    , P_APPROVED_PERSON_ID => V_APPORVERD_PERSON_ID
                                    , P_APPROVE_STATUS => 'B'
                                    , P_DESCRIPTION => :NEW.DESCRIPTION
                                    , P_SOB_ID => :NEW.SOB_ID
                                    , P_ORG_ID => :NEW.ORG_ID
                                    , P_USER_ID => -1
                                    );
    END IF;
    
    -- 2013-08-01 전호수 추가 : 관리직 잔업/특근 신청을 G/W상에서 진행하여 ERP로 INTERFACE 함 --
    -- 관리직 잔업/특근 신청 ID 변환.
    BEGIN
      SELECT OTG.OT_TYPE_ID
        INTO V_OT_TYPE_ID
        FROM HRM_OT_TYPE_GW_V  OTG
          , HRM_DUTY_GW_CODE_V DGC
      WHERE OTG.OT_TYPE_CODE    = DGC.OT_TYPE_GW
        AND OTG.SOB_ID          = DGC.SOB_ID
        AND OTG.ORG_ID          = DGC.ORG_ID
        AND DGC.DUTY_GW_CODE    = :NEW.GW_DUTY_CODE
        AND DGC.SOB_ID          = :NEW.SOB_ID
        AND DGC.ORG_ID          = :NEW.ORG_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE(EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10175', NULL));
    END;
    -- Insert
    IF V_OT_TYPE_ID IS NOT NULL THEN
      HRD_OT_MANAGER_G.INTERFACE_OT_MANAGER
        ( P_PERSON_ID             => V_PERSON_ID
        , P_SOB_ID                => :NEW.SOB_ID 
        , P_ORG_ID                => :NEW.ORG_ID 
        , P_OT_TYPE_ID            => V_OT_TYPE_ID 
        , P_OT_DATE_FR            => :NEW.START_DATE
        , P_OT_DATE_TO            => :NEW.END_DATE
        , P_DESCRIPTION           => :NEW.DESCRIPTION 
        , P_STATUS_FLAG           => 'B'  -- 현업승인 -- 
        , P_APPROVAL_YN           => :NEW.APPROVED_YN
        , P_APPROVAL_DATE         => :NEW.APPROVED_DATE
        , P_APPROVAL_PERSON_ID    => V_APPORVERD_PERSON_ID
        , P_USER_ID               => -2
        , O_STATUS                => V_STATUS
        , O_MESSAGE               => V_MESSAGE
        );
      IF V_STATUS = 'F' THEN
        RAISE_APPLICATION_ERROR(-20001, '2. OT Manager Error : ' || V_MESSAGE);
      END IF;
    END IF;
  END IF;

END HRD_DUTY_PERIOD_INTERFACE_T;
/
