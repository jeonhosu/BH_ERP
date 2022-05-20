CREATE OR REPLACE TRIGGER FI_SLIP_HEADER_INTERFACE_T
AFTER INSERT OR UPDATE OR DELETE ON APPS.FI_SLIP_HEADER_INTERFACE FOR EACH ROW
DECLARE
  V_SLIP_HEADER_ID        NUMBER := 0;    -- SLIP_HEADER_INTERFACE.ATTRIBUTE_1에 저장.
  V_SLIP_LINE_ID          NUMBER := 0;    -- SLIP_LINE_INTERFACE.ATTRIBUTE_1에 저장.

BEGIN
  IF INSERTING THEN
  -- INSERT.
    IF :NEW.CONFIRM_YN = 'Y' THEN
    -- 승인 전표시 전표 생성.
      IF GL_FISCAL_PERIOD_G.PERIOD_STATUS_F(NULL, :NEW.GL_DATE, :NEW.SOB_ID, :NEW.ORG_ID) IN('C', 'N') THEN
        RAISE_APPLICATION_ERROR(ERRNUMS.Data_Not_opened_Code, ERRNUMS.Data_Not_Opened_Desc);
      END IF;

      BEGIN
        FI_SLIP_G.INSERT_SLIP_HEADER( P_SLIP_HEADER_ID => V_SLIP_HEADER_ID
                                    , P_SLIP_DATE => :NEW.SLIP_DATE
                                    , P_SLIP_NUM => :NEW.SLIP_NUM
                                    , P_SOB_ID => :NEW.SOB_ID
                                    , P_ORG_ID => :NEW.ORG_ID
                                    , P_DEPT_ID => :NEW.DEPT_ID
                                    , P_PERSON_ID => :NEW.PERSON_ID
                                    , P_BUDGET_DEPT_ID => :NEW.BUDGET_DEPT_ID
                                    , P_SLIP_TYPE => :NEW.SLIP_TYPE
                                    , P_GL_DATE => :NEW.GL_DATE     -- 기표일자와 동일하게 우선 처리.
                                    , P_GL_NUM => :NEW.GL_NUM       -- 기표번호와 동일하게 우선 처리.
                                    , P_REQ_BANK_ACCOUNT_ID => :NEW.REQ_BANK_ACCOUNT_ID
                                    , P_REQ_PAYABLE_TYPE => :NEW.REQ_PAYABLE_TYPE
                                    , P_REQ_PAYABLE_DATE => :NEW.REQ_PAYABLE_DATE
                                    , P_REMARK => :NEW.REMARK
                                    , P_USER_ID => :NEW.CREATED_BY
                                    , P_CREATED_TYPE => 'I'
                                    , P_SOURCE_TABLE => 'FI_SLIP_HEADER_INTERFACE'
                                    , P_SOURCE_HEADER_ID => :NEW.HEADER_INTERFACE_ID
                                    );        
        
        -- 라인 INSERT.
        FOR C1 IN ( SELECT SLI.LINE_INTERFACE_ID
                         , SLI.SLIP_DATE
                         , SLI.SLIP_NUM
                         , SLI.HEADER_INTERFACE_ID
                         , SLI.SOB_ID
                         , SLI.ORG_ID
                         , SLI.DEPT_ID
                         , SLI.PERSON_ID
                         , SLI.BUDGET_DEPT_ID
                         , SLI.ACCOUNT_CONTROL_ID
                         , SLI.ACCOUNT_CODE
                         , SLI.ACCOUNT_DR_CR
                         , SLI.GL_AMOUNT
                         , SLI.CURRENCY_CODE
                         , SLI.EXCHANGE_RATE
                         , SLI.GL_CURRENCY_AMOUNT
                         , SLI.MANAGEMENT1
                         , SLI.MANAGEMENT2
                         , SLI.REFER1
                         , SLI.REFER2
                         , SLI.REFER3
                         , SLI.REFER4
                         , SLI.REFER5
                         , SLI.REFER6
                         , SLI.REFER7
                         , SLI.REFER8
                         , SLI.REFER9
                         , SLI.REMARK
                      FROM FI_SLIP_LINE_INTERFACE SLI
                    WHERE SLI.HEADER_INTERFACE_ID     = :NEW.HEADER_INTERFACE_ID
                      AND SLI.SOB_ID                  = :NEW.SOB_ID
                    ORDER BY SLI.SLIP_LINE_SEQ
                   )
        LOOP
          FI_SLIP_G.INSERT_SLIP_LINE( P_SLIP_LINE_ID => V_SLIP_LINE_ID
                                    , P_SLIP_HEADER_ID => V_SLIP_HEADER_ID
                                    , P_SOB_ID => :NEW.SOB_ID
                                    , P_ORG_ID => :NEW.ORG_ID
                                    , P_ACCOUNT_CONTROL_ID => C1.ACCOUNT_CONTROL_ID
                                    , P_ACCOUNT_CODE => C1.ACCOUNT_CODE
                                    , P_ACCOUNT_DR_CR => C1.ACCOUNT_DR_CR
                                    , P_GL_AMOUNT => C1.GL_AMOUNT
                                    , P_CURRENCY_CODE => C1.CURRENCY_CODE
                                    , P_EXCHANGE_RATE => C1.EXCHANGE_RATE
                                    , P_GL_CURRENCY_AMOUNT => C1.GL_CURRENCY_AMOUNT
                                    , P_MANAGEMENT1 => C1.MANAGEMENT1
                                    , P_MANAGEMENT2 => C1.MANAGEMENT2
                                    , P_REFER1 => C1.REFER1
                                    , P_REFER2 => C1.REFER2
                                    , P_REFER3 => C1.REFER3
                                    , P_REFER4 => C1.REFER4
                                    , P_REFER5 => C1.REFER5
                                    , P_REFER6 => C1.REFER6
                                    , P_REFER7 => C1.REFER7
                                    , P_REFER8 => C1.REFER8
                                    , P_REFER9 => C1.REFER9
                                    , P_REMARK => C1.REMARK
                                    , P_UNLIQUIDATE_SLIP_HEADER_ID => TO_NUMBER(NULL)
                                    , P_UNLIQUIDATE_SLIP_LINE_ID => TO_NUMBER(NULL)
                                    , P_USER_ID => :NEW.CREATED_BY
                                    , P_LINE_TYPE => 'I'
                                    , P_SOURCE_TABLE => 'FI_SLIP_LINE_INTERFACE'
                                    , P_SOURCE_HEADER_ID => C1.HEADER_INTERFACE_ID
                                    , P_SOURCE_LINE_ID => C1.LINE_INTERFACE_ID
                                    );
        END LOOP C1;
        -- 전표 LINE UPDATE.
        UPDATE FI_SLIP_LINE_INTERFACE SLI
          SET SLI.CONFIRM_YN          = :NEW.CONFIRM_YN
            , SLI.CONFIRM_DATE        = :NEW.CONFIRM_DATE
            , SLI.CONFIRM_PERSON_ID   = :NEW.CONFIRM_PERSON_ID
        WHERE SLI.HEADER_INTERFACE_ID = :NEW.HEADER_INTERFACE_ID
        ;
        
        -- 예산전표 헤더 승인정보.
        UPDATE FI_SLIP_HEADER_BUDGET SH
          SET SH.GL_DATE            = :NEW.GL_DATE
            , SH.GL_NUM             = :NEW.GL_NUM
            , SH.CONFIRM_YN         = :NEW.CONFIRM_YN
            , SH.CONFIRM_DATE       = :NEW.CONFIRM_DATE
            , SH.CONFIRM_PERSON_ID  = :NEW.CONFIRM_PERSON_ID
        WHERE SH.SOURCE_HEADER_ID   = :NEW.HEADER_INTERFACE_ID
        ;
        
        -- 예산전표 라인 승인정보.
        UPDATE FI_SLIP_LINE_BUDGET SL
          SET SL.CONFIRM_YN        = :NEW.CONFIRM_YN
            , SL.CONFIRM_DATE      = :NEW.CONFIRM_DATE
            , SL.CONFIRM_PERSON_ID = :NEW.CONFIRM_PERSON_ID
        WHERE SL.SOURCE_HEADER_ID  = :NEW.HEADER_INTERFACE_ID
        ;
      EXCEPTION WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10182', NULL) || SQLERRM);
      END;      
    END IF;

  ELSIF UPDATING THEN
  -- UPDATE.
    IF :NEW.CONFIRM_YN = 'Y' THEN
    -- 승인 전표시 전표 생성.
      IF GL_FISCAL_PERIOD_G.PERIOD_STATUS_F(NULL, :NEW.GL_DATE, :NEW.SOB_ID, :NEW.ORG_ID) IN('C', 'N') THEN
        RAISE_APPLICATION_ERROR(ERRNUMS.Data_Not_opened_Code, ERRNUMS.Data_Not_Opened_Desc);
      END IF;

      BEGIN
        FI_SLIP_G.INSERT_SLIP_HEADER( P_SLIP_HEADER_ID => V_SLIP_HEADER_ID
                                    , P_SLIP_DATE => :NEW.SLIP_DATE
                                    , P_SLIP_NUM => :NEW.SLIP_NUM
                                    , P_SOB_ID => :NEW.SOB_ID
                                    , P_ORG_ID => :NEW.ORG_ID
                                    , P_DEPT_ID => :NEW.DEPT_ID
                                    , P_PERSON_ID => :NEW.PERSON_ID
                                    , P_BUDGET_DEPT_ID => :NEW.BUDGET_DEPT_ID
                                    , P_SLIP_TYPE => :NEW.SLIP_TYPE
                                    , P_GL_DATE => :NEW.GL_DATE     -- 기표일자와 동일하게 우선 처리.
                                    , P_GL_NUM => :NEW.GL_NUM       -- 기표번호와 동일하게 우선 처리.
                                    , P_REQ_BANK_ACCOUNT_ID => :NEW.REQ_BANK_ACCOUNT_ID
                                    , P_REQ_PAYABLE_TYPE => :NEW.REQ_PAYABLE_TYPE
                                    , P_REQ_PAYABLE_DATE => :NEW.REQ_PAYABLE_DATE
                                    , P_REMARK => :NEW.REMARK
                                    , P_USER_ID => :NEW.CREATED_BY
                                    , P_CREATED_TYPE => 'I'
                                    , P_SOURCE_TABLE => 'FI_SLIP_HEADER_INTERFACE'
                                    , P_SOURCE_HEADER_ID => :NEW.HEADER_INTERFACE_ID
                                    );
        
        -- 라인 INSERT.
        FOR C1 IN ( SELECT SLI.LINE_INTERFACE_ID
                         , SLI.SLIP_DATE
                         , SLI.SLIP_NUM
                         , SLI.SLIP_LINE_SEQ
                         , SLI.HEADER_INTERFACE_ID
                         , SLI.SOB_ID
                         , SLI.ORG_ID
                         , SLI.DEPT_ID
                         , SLI.PERSON_ID
                         , SLI.BUDGET_DEPT_ID
                         , SLI.ACCOUNT_BOOK_ID
                         , SLI.SLIP_TYPE
                         , SLI.JOURNAL_HEADER_ID
                         , SLI.CUSTOMER_ID
                         , SLI.ACCOUNT_CONTROL_ID
                         , SLI.ACCOUNT_CODE
                         , SLI.COST_CENTER_ID
                         , SLI.ACCOUNT_DR_CR
                         , SLI.GL_AMOUNT
                         , SLI.CURRENCY_CODE
                         , SLI.EXCHANGE_RATE
                         , SLI.GL_CURRENCY_AMOUNT
                         , SLI.BANK_ACCOUNT_ID
                         , SLI.MANAGEMENT1
                         , SLI.MANAGEMENT2
                         , SLI.REFER1
                         , SLI.REFER2
                         , SLI.REFER3
                         , SLI.REFER4
                         , SLI.REFER5
                         , SLI.REFER6
                         , SLI.REFER7
                         , SLI.REFER8
                         , SLI.REFER9
                         , SLI.REMARK
                      FROM FI_SLIP_LINE_INTERFACE SLI
                    WHERE SLI.HEADER_INTERFACE_ID     = :NEW.HEADER_INTERFACE_ID
                      AND SLI.SOB_ID                  = :NEW.SOB_ID
                   )
        LOOP
          FI_SLIP_G.INSERT_SLIP_LINE( P_SLIP_LINE_ID => V_SLIP_LINE_ID
                                    , P_SLIP_HEADER_ID => V_SLIP_HEADER_ID
                                    , P_SOB_ID => C1.SOB_ID
                                    , P_ORG_ID => C1.ORG_ID
                                    , P_ACCOUNT_CONTROL_ID => C1.ACCOUNT_CONTROL_ID
                                    , P_ACCOUNT_CODE => C1.ACCOUNT_CODE
                                    , P_ACCOUNT_DR_CR => C1.ACCOUNT_DR_CR
                                    , P_GL_AMOUNT => C1.GL_AMOUNT
                                    , P_CURRENCY_CODE => C1.CURRENCY_CODE
                                    , P_EXCHANGE_RATE => C1.EXCHANGE_RATE
                                    , P_GL_CURRENCY_AMOUNT => C1.GL_CURRENCY_AMOUNT
                                    , P_MANAGEMENT1 => C1.MANAGEMENT1
                                    , P_MANAGEMENT2 => C1.MANAGEMENT2
                                    , P_REFER1 => C1.REFER1
                                    , P_REFER2 => C1.REFER2
                                    , P_REFER3 => C1.REFER3
                                    , P_REFER4 => C1.REFER4
                                    , P_REFER5 => C1.REFER5
                                    , P_REFER6 => C1.REFER6
                                    , P_REFER7 => C1.REFER7
                                    , P_REFER8 => C1.REFER8
                                    , P_REFER9 => C1.REFER9
                                    , P_REMARK => C1.REMARK
                                    , P_UNLIQUIDATE_SLIP_HEADER_ID => NULL
                                    , P_UNLIQUIDATE_SLIP_LINE_ID => NULL
                                    , P_USER_ID => :NEW.CREATED_BY
                                    , P_LINE_TYPE => 'I'
                                    , P_SOURCE_TABLE => 'FI_SLIP_LINE_INTERFACE'
                                    , P_SOURCE_HEADER_ID => :NEW.HEADER_INTERFACE_ID
                                    , P_SOURCE_LINE_ID => C1.LINE_INTERFACE_ID
                                    );
        END LOOP C1;
        -- 전표 LINE UPDATE.
        UPDATE FI_SLIP_LINE_INTERFACE SLI
          SET SLI.CONFIRM_YN          = :NEW.CONFIRM_YN
            , SLI.CONFIRM_DATE        = :NEW.CONFIRM_DATE
            , SLI.CONFIRM_PERSON_ID   = :NEW.CONFIRM_PERSON_ID
        WHERE SLI.HEADER_INTERFACE_ID = :NEW.HEADER_INTERFACE_ID
        ;
        
        -- 예산전표 헤더 승인정보.
        UPDATE FI_SLIP_HEADER_BUDGET SH
          SET SH.GL_DATE            = :NEW.GL_DATE
            , SH.GL_NUM             = :NEW.GL_NUM
            , SH.CONFIRM_YN         = :NEW.CONFIRM_YN
            , SH.CONFIRM_DATE       = :NEW.CONFIRM_DATE
            , SH.CONFIRM_PERSON_ID  = :NEW.CONFIRM_PERSON_ID
        WHERE SH.SOURCE_HEADER_ID   = :NEW.HEADER_INTERFACE_ID
        ;
        
        -- 예산전표 라인 승인정보.
        UPDATE FI_SLIP_LINE_BUDGET SL
          SET SL.CONFIRM_YN        = :NEW.CONFIRM_YN
            , SL.CONFIRM_DATE      = :NEW.CONFIRM_DATE
            , SL.CONFIRM_PERSON_ID = :NEW.CONFIRM_PERSON_ID
        WHERE SL.SOURCE_HEADER_ID  = :NEW.HEADER_INTERFACE_ID
        ;
      EXCEPTION WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10182', NULL) || SQLERRM);
        RETURN;
      END;
    ELSIF :OLD.CONFIRM_YN = 'Y' AND :NEW.CONFIRM_YN = 'N' THEN
    -- 승인취소시 전표 삭제 생성.
      BEGIN
        -- 전표 ID UPDATE.
        SELECT  SH.SLIP_HEADER_ID
          INTO V_SLIP_HEADER_ID
          FROM FI_SLIP_HEADER SH
        WHERE SH.SOURCE_TABLE     = 'FI_SLIP_HEADER_INTERFACE'
          AND SH.SOURCE_HEADER_ID = :NEW.HEADER_INTERFACE_ID
        ;
      EXCEPTION WHEN OTHERS THEN
        V_SLIP_HEADER_ID := -1;
      END;
      BEGIN
        -- 전표 마감여부 체크.
        IF FI_SLIP_G.SLIP_CLOSE_YN_F(V_SLIP_HEADER_ID) <> 'N' THEN
          RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10115', NULL));
        END IF;
        -- 전표 LINE 삭제.
        DELETE FROM FI_SLIP_LINE SL
        WHERE SL.SLIP_HEADER_ID         = V_SLIP_HEADER_ID
        ;
        -- 전표 HEADER 삭제.
        DELETE FROM FI_SLIP_HEADER SH
        WHERE SH.SLIP_HEADER_ID         = V_SLIP_HEADER_ID
        ;

        -- 전표 LINE UPDATE.
        UPDATE FI_SLIP_LINE_INTERFACE SLI
          SET SLI.CONFIRM_YN        = :NEW.CONFIRM_YN
            , SLI.CONFIRM_DATE      = :NEW.CONFIRM_DATE
            , SLI.CONFIRM_PERSON_ID = :NEW.CONFIRM_PERSON_ID
        WHERE SLI.HEADER_INTERFACE_ID = :NEW.HEADER_INTERFACE_ID
        ;
        
        -- 예산전표 헤더 승인정보.
        UPDATE FI_SLIP_HEADER_BUDGET SH
          SET SH.GL_DATE            = :NEW.GL_DATE
            , SH.GL_NUM             = :NEW.GL_NUM
            , SH.CONFIRM_YN         = :NEW.CONFIRM_YN
            , SH.CONFIRM_DATE       = :NEW.CONFIRM_DATE
            , SH.CONFIRM_PERSON_ID  = :NEW.CONFIRM_PERSON_ID
        WHERE SH.SOURCE_HEADER_ID   = :NEW.HEADER_INTERFACE_ID
        ;
        
        -- 예산전표 라인 승인정보.
        UPDATE FI_SLIP_LINE_BUDGET SL
          SET SL.CONFIRM_YN        = :NEW.CONFIRM_YN
            , SL.CONFIRM_DATE      = :NEW.CONFIRM_DATE
            , SL.CONFIRM_PERSON_ID = :NEW.CONFIRM_PERSON_ID
        WHERE SL.SOURCE_HEADER_ID  = :NEW.HEADER_INTERFACE_ID
        ;
      EXCEPTION WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10182', NULL) || SQLERRM);
      END;
    END IF;

  ELSIF DELETING THEN
  -- DELETE.
    BEGIN
    -- 삭제시 로그 남김.
      INSERT INTO FI_SLIP_HEADER_INTERFACE_LOG
      ( HEADER_INTERFACE_ID
      , SLIP_DATE
      , SLIP_NUM
      , SOB_ID
      , ORG_ID
      , DEPT_ID
      , PERSON_ID
      , BUDGET_DEPT_ID
      , ACCOUNT_BOOK_ID
      , SLIP_TYPE
      , JOURNAL_HEADER_ID
      , GL_DATE
      , GL_NUM
      , GL_AMOUNT
      , CURRENCY_CODE
      , EXCHANGE_RATE
      , GL_CURRENCY_AMOUNT
      , REQ_BANK_ACCOUNT_ID
      , REQ_PAYABLE_TYPE
      , REQ_PAYABLE_DATE
      , REMARK
      , SUB_REMARK
      , SUBSTANCE
      , TRANSFER_YN
      , TRANSFER_DATE
      , TRANSFER_PERSON_ID
      , CONFIRM_YN
      , CONFIRM_DATE
      , CONFIRM_PERSON_ID
      , SOURCE_TABLE
      , SOURCE_HEADER_ID
      , ATTRIUTE_A
      , ATTRIUTE_B
      , ATTRIUTE_C
      , ATTRIUTE_D
      , ATTRIUTE_E
      , ATTRIUTE_1
      , ATTRIUTE_2
      , ATTRIUTE_3
      , ATTRIUTE_4
      , ATTRIUTE_5
      , CREATION_DATE
      , CREATED_BY
      , LAST_UPDATE_DATE
      , LAST_UPDATED_BY
      ) VALUES
      ( :OLD.HEADER_INTERFACE_ID
      , :OLD.SLIP_DATE
      , :OLD.SLIP_NUM
      , :OLD.SOB_ID
      , :OLD.ORG_ID
      , :OLD.DEPT_ID
      , :OLD.PERSON_ID
      , :OLD.BUDGET_DEPT_ID
      , :OLD.ACCOUNT_BOOK_ID
      , :OLD.SLIP_TYPE
      , :OLD.JOURNAL_HEADER_ID
      , :OLD.GL_DATE
      , :OLD.GL_NUM
      , :OLD.GL_AMOUNT
      , :OLD.CURRENCY_CODE
      , :OLD.EXCHANGE_RATE
      , :OLD.GL_CURRENCY_AMOUNT
      , :OLD.REQ_BANK_ACCOUNT_ID
      , :OLD.REQ_PAYABLE_TYPE
      , :OLD.REQ_PAYABLE_DATE
      , :OLD.REMARK
      , :OLD.SUB_REMARK
      , :OLD.SUBSTANCE
      , :OLD.TRANSFER_YN
      , :OLD.TRANSFER_DATE
      , :OLD.TRANSFER_PERSON_ID
      , :OLD.CONFIRM_YN
      , :OLD.CONFIRM_DATE
      , :OLD.CONFIRM_PERSON_ID
      , :OLD.SOURCE_TABLE
      , :OLD.SOURCE_HEADER_ID
      , :OLD.ATTRIUTE_A
      , :OLD.ATTRIUTE_B
      , :OLD.ATTRIUTE_C
      , :OLD.ATTRIUTE_D
      , :OLD.ATTRIUTE_E
      , :OLD.ATTRIUTE_1
      , :OLD.ATTRIUTE_2
      , :OLD.ATTRIUTE_3
      , :OLD.ATTRIUTE_4
      , :OLD.ATTRIUTE_5
      , :OLD.CREATION_DATE
      , :OLD.CREATED_BY
      , :OLD.LAST_UPDATE_DATE
      , :OLD.LAST_UPDATED_BY
      );

    END;

  END IF;

END FI_SLIP_HEADER_INTERFACE_T;
/
