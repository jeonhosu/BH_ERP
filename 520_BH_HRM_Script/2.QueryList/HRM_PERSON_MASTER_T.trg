CREATE OR REPLACE TRIGGER HRM_PERSON_MASTER_T
BEFORE INSERT OR UPDATE OR DELETE ON APPS.HRM_PERSON_MASTER FOR EACH ROW
DECLARE
  V_CHARGE_DATE           DATE := NULL;         -- 발령일자.
  V_CHARGE_ID             NUMBER := NULL;       -- 발령ID.
  V_HISTORY_HEADER_ID     NUMBER := NULL;
  V_HISTORY_NUM           VARCHAR2(30) := NULL;
  V_CORP_ID               NUMBER := NULL;
  V_HISTORY_LINE_ID       NUMBER := NULL;

BEGIN
  IF INSERTING THEN
    -- 재직구분.
    IF :NEW.RETIRE_DATE IS NOT NULL OR :NEW.RETIRE_ID IS NOT NULL THEN
      :NEW.EMPLOYE_TYPE := '3';
    ELSIF :NEW.EMPLOYE_TYPE = '3' THEN
      :NEW.EMPLOYE_TYPE := '1';
    END IF;
    
    -- display name 변경.
    IF :NEW.PERSON_NUM IS NULL THEN
      :NEW.DISPLAY_NAME := :NEW.NAME;
    ELSE
      :NEW.DISPLAY_NAME := :NEW.NAME || '(' || :NEW.PERSON_NUM || ')';
    END IF;
    
/*--------------------------------------------------------------------------------------*/
-- (신규 입사) - 인사발령 사항 저장.
    V_CHARGE_DATE := TRUNC(:NEW.JOIN_DATE);
    BEGIN
      SELECT CC.COMMON_ID
        INTO V_CHARGE_ID
      FROM HRM_CHARGE_CODE_V CC
       WHERE CC.NEWCOMER_YN           = 'Y'
         AND CC.SOB_ID                = :NEW.SOB_ID
         AND CC.ORG_ID                = :NEW.ORG_ID
         AND ROWNUM                   <= 1
      ;
    EXCEPTION WHEN OTHERS THEN
      V_CHARGE_ID := 1;
    END;
    HRM_HISTORY_HEADER_G.DATA_INSERT(:NEW.CORP_ID, V_CHARGE_DATE, V_CHARGE_ID, '신규입사', 'N', :NEW.SOB_ID, :NEW.ORG_ID, :NEW.CREATED_BY
                                    , V_HISTORY_HEADER_ID, V_HISTORY_NUM, V_CORP_ID);

    HRM_HISTORY_LINE_G.DATA_INSERT( P_HISTORY_HEADER_ID => V_HISTORY_HEADER_ID
                                  , P_HISTORY_NUM => V_HISTORY_NUM
                                  , P_PERSON_ID => :NEW.PERSON_ID
                                  , P_CHARGE_DATE => V_CHARGE_DATE
                                  , P_CHARGE_ID => V_CHARGE_ID
                                  , P_RETIRE_ID => NULL
                                  , P_OPERATING_UNIT_ID => :NEW.OPERATING_UNIT_ID
                                  , P_DEPT_ID => :NEW.DEPT_ID
                                  , P_JOB_CLASS_ID => :NEW.JOB_CLASS_ID
                                  , P_JOB_ID => :NEW.JOB_ID
                                  , P_POST_ID => :NEW.POST_ID
                                  , P_OCPT_ID => :NEW.OCPT_ID
                                  , P_ABIL_ID => :NEW.ABIL_ID
                                  , P_PAY_GRADE_ID => :NEW.PAY_GRADE_ID
                                  , P_JOB_CATEGORY_ID => :NEW.JOB_CATEGORY_ID
                                  , P_FLOOR_ID => :NEW.FLOOR_ID
                                  , P_PRE_OPERATING_UNIT_ID => :NEW.OPERATING_UNIT_ID
                                  , P_PRE_DEPT_ID => :NEW.DEPT_ID
                                  , P_PRE_JOB_CLASS_ID => :NEW.JOB_CLASS_ID
                                  , P_PRE_JOB_ID => :NEW.JOB_ID
                                  , P_PRE_POST_ID => :NEW.POST_ID
                                  , P_PRE_OCPT_ID => :NEW.OCPT_ID
                                  , P_PRE_ABIL_ID => :NEW.ABIL_ID
                                  , P_PRE_PAY_GRADE_ID => :NEW.PAY_GRADE_ID
                                  , P_PRE_JOB_CATEGORY_ID => :NEW.JOB_CATEGORY_ID
                                  , P_PRE_FLOOR_ID => :NEW.FLOOR_ID
                                  , P_PRINT_YN => 'Y'
                                  , P_DESCRIPTION => NULL
                                  , P_USER_ID => :NEW.CREATED_BY
                                  , O_HISTORY_LINE_ID => V_HISTORY_LINE_ID
                                  );

    -- HRD_PERSON_HISTORY 신규 추가[2011-07-19]
    HRD_PERSON_HISTORY_G.INSERT_PERSON_HISTORY
                             ( :NEW.WORK_CORP_ID  -- 근무업체 ID -- 
                             , :NEW.PERSON_ID
                             , :NEW.JOIN_DATE
                             , :NEW.FLOOR_ID
                             , :NEW.WORK_TYPE_ID
                             , :NEW.FLOOR_ID
                             , :NEW.WORK_TYPE_ID
                             , 'NEW'
                             , :NEW.SOB_ID
                             , :NEW.ORG_ID
                             , :NEW.CREATED_BY  -- P_USER_ID
                             , :NEW.DEPT_ID
                             , :NEW.DEPT_ID
                             , 'NEW'            -- MODIFY_TYPE -- 
                             , V_HISTORY_LINE_ID  -- 2013-08-29 추가 -- 
                             );
                             
  ELSIF UPDATING THEN
    -- 재직구분.
    IF :NEW.RETIRE_DATE IS NOT NULL OR :NEW.RETIRE_ID IS NOT NULL THEN
      :NEW.EMPLOYE_TYPE := '3';
    ELSIF :NEW.EMPLOYE_TYPE = '3' THEN
      :NEW.EMPLOYE_TYPE := '1';
    END IF;
    
    -- display name 변경.
    IF :NEW.PERSON_NUM IS NULL THEN
      :NEW.DISPLAY_NAME := :NEW.NAME;
    ELSE
      :NEW.DISPLAY_NAME := :NEW.NAME || '(' || :NEW.PERSON_NUM || ')';
    END IF;
    
    /*-- 퇴사처리시 관련된 테이블 사용기간 만료 시키기.
    HRM_PERSON_RETIRE_G.UPDATE_RETIRE_DATE
      ( W_PERSON_ID       => :NEW.PERSON_ID
      , W_EMPLOYE_TYPE    => :NEW.EMPLOYE_TYPE
      , W_RETIRE_DATE     => :NEW.RETIRE_DATE
      , P_SOB_ID          => :NEW.SOB_ID
      , P_ORG_ID          => :NEW.ORG_ID
      , P_USER_ID         => :NEW.LAST_UPDATED_BY
      );
      */
  ELSIF DELETING THEN
    BEGIN
      -- 해당 사원의 발령정보 삭제.
      DELETE HRM_HISTORY_LINE HL
      WHERE HL.PERSON_ID      = :OLD.PERSON_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10179', NULL));
    END;
    BEGIN
      -- 라인 없는 발령 헤더 삭제.
      DELETE FROM HRM_HISTORY_HEADER HH
      WHERE HH.SOB_ID           = :OLD.SOB_ID
        AND HH.ORG_ID           = :OLD.ORG_ID
        AND HH.CORP_ID          = :OLD.CORP_ID
        AND NOT EXISTS( SELECT 'X'
                          FROM HRM_HISTORY_LINE HL
                        WHERE HL.HISTORY_HEADER_ID    = HH.HISTORY_HEADER_ID
                       )
     ;
   EXCEPTION WHEN OTHERS THEN
     RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10179', NULL));
   END;
  END IF;

END HRM_PERSON_MASTER_T
;
/
