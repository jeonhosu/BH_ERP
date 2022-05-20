CREATE OR REPLACE TRIGGER "FI_SLIP_LINE_T"
AFTER DELETE OR INSERT OR UPDATE
ON   APPS.FI_SLIP_LINE
REFERENCING NEW AS New OLD AS Old
FOR EACH ROW
DECLARE

  V_OLD_CUSTOMER_ID     NUMBER;         --변경전 거래처아이디
  V_OLD_BANK_ACCOUNT_ID NUMBER;         --변경전 계좌번호아이디
  V_OLD_LOAN_NUM        VARCHAR2(50);   --변경전 차입금 번호.
  
  V_CUSTOMER_ID         NUMBER;
  V_BANK_ACCOUNT_ID     NUMBER;
  V_LOAN_NUM            VARCHAR2(50);  -- 차입금 번호.
  
  V_MANAGEMENT_ID       VARCHAR2(100);
  V_MANAGEMENT_VALUE    VARCHAR2(100);  

BEGIN

--전체적으로 굳이 begin ~ end blcok을 감싸지 않아도 되는데, 감싸서 작업했다. 가독성만 떨어질 뿐이다.

---------------------------------------------------------------------------------------------------
--1번.기준이 되는 값 조회
IF INSERTING THEN
    NULL;
ELSE  --deleting 과 updating일 경우에만 수행.        
  
    --기존의 거래처아이디 조회, 이는 [새로운 거래처아이디 조회]와 흡사하다. [SLIP_LINE_ID]를 제외하곤.
    --굳이 아래 문장처럼 할 필요가 있을까. 너무 복잡하게 매입처아이디를 구한다.
    BEGIN
      SELECT SC.SUPP_CUST_ID
        INTO V_OLD_CUSTOMER_ID
        FROM FI_SUPP_CUST_V SC
      WHERE SC.SOB_ID               = :OLD.SOB_ID
        AND SC.SUPP_CUST_CODE       IN (SELECT MAX(SMI.MANAGEMENT_VALUE) AS MANAGEMENT_VALUE
                                          FROM FI_SLIP_MANAGEMENT_ITEM SMI
                                            , FI_MANAGEMENT_CODE_V FMC
                                        WHERE SMI.MANAGEMENT_ID        = FMC.MANAGEMENT_ID
                                          AND SMI.SLIP_LINE_ID         = :OLD.SLIP_LINE_ID  --unique하다.
                                          AND SMI.SOB_ID               = :OLD.SOB_ID
                                          AND FMC.LOOKUP_TYPE          = 'CUSTOMER'
                                        )
        AND ROWNUM                  <= 1    --불필요할듯하다.
      ;
    EXCEPTION WHEN OTHERS THEN
      V_OLD_CUSTOMER_ID := NULL;
    END;
    
    
    --기존의 계좌번호아이디 조회, 이는 [새로운 계좌번호아이디 조회]와 흡사하다. [SLIP_LINE_ID]를 제외하곤.
    BEGIN
      SELECT BA.BANK_ACCOUNT_ID
        INTO V_OLD_BANK_ACCOUNT_ID
        FROM FI_BANK_ACCOUNT BA
      WHERE BA.SOB_ID               = :OLD.SOB_ID
        AND BA.BANK_ACCOUNT_CODE    IN (SELECT MAX(SMI.MANAGEMENT_VALUE) AS MANAGEMENT_VALUE
                                          FROM FI_SLIP_MANAGEMENT_ITEM SMI
                                            , FI_MANAGEMENT_CODE_V FMC
                                        WHERE SMI.MANAGEMENT_ID        = FMC.MANAGEMENT_ID
                                          AND SMI.SLIP_LINE_ID         = :OLD.SLIP_LINE_ID
                                          AND SMI.SOB_ID               = :OLD.SOB_ID
                                          AND FMC.LOOKUP_TYPE          = 'BANK_ACCOUNT'
                                        )
        AND ROWNUM                  <= 1
      ;
    EXCEPTION WHEN OTHERS THEN
      V_OLD_BANK_ACCOUNT_ID := NULL;
    END;
    


    --기존의 차입금번호 조회.  'LOAN_NUM'은 BH에는 적용되지 않은 값이다.
    BEGIN
      SELECT SMI.MANAGEMENT_VALUE AS LOAN_NUM
        INTO V_OLD_LOAN_NUM
        FROM FI_SLIP_MANAGEMENT_ITEM SMI
          , FI_MANAGEMENT_CODE_V MC
      WHERE SMI.MANAGEMENT_ID           = MC.MANAGEMENT_ID
        AND SMI.SLIP_LINE_ID            = :OLD.SLIP_LINE_ID
        AND SMI.SOB_ID                  = :OLD.SOB_ID
        AND MC.LOOKUP_TYPE              = 'LOAN_NUM'
      ;
    EXCEPTION WHEN OTHERS THEN
      V_OLD_LOAN_NUM := NULL;
    END;
        
END IF;   --1번.기준이 되는 값 조회
  
  
  
  

---------------------------------------------------------------------------------------------------
--2번.관리항목 저장.

--2-1.FI_SLIP_MANAGEMENT_ITEM(전표관리항목내역) 테이블 자료 변경 
IF DELETING THEN
  
    BEGIN
      DELETE FROM FI_SLIP_MANAGEMENT_ITEM MI
      WHERE MI.SLIP_LINE_ID         = :OLD.SLIP_LINE_ID
        AND MI.SOB_ID               = :OLD.SOB_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10182', NULL));
      RETURN;
    END;
        
ELSE    --inserting or updating
    FOR C1 IN 1.. 10 LOOP
      V_MANAGEMENT_ID     := NULL;
      V_MANAGEMENT_VALUE  := NULL;
      BEGIN
        SELECT CASE C1
                 WHEN 1 THEN AC.REFER1_ID
                 WHEN 2 THEN AC.REFER2_ID
                 WHEN 3 THEN AC.REFER3_ID
                 WHEN 4 THEN AC.REFER4_ID
                 WHEN 5 THEN AC.REFER5_ID
                 WHEN 6 THEN AC.REFER6_ID
                 WHEN 7 THEN AC.REFER7_ID
                 WHEN 8 THEN AC.REFER8_ID
                 WHEN 9 THEN AC.REFER9_ID
                 WHEN 10 THEN AC.REFER10_ID
                 WHEN 11 THEN AC.REFER11_ID
                 WHEN 12 THEN AC.REFER12_ID
                 WHEN 13 THEN AC.REFER13_ID
                 WHEN 14 THEN AC.REFER14_ID
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
                 WHEN 11 THEN :NEW.REFER9
                 WHEN 12 THEN :NEW.REFER10
                 WHEN 13 THEN :NEW.REFER11
                 WHEN 14 THEN :NEW.REFER12
               END AS MANAGEMENT_VALUE
        INTO V_MANAGEMENT_ID, V_MANAGEMENT_VALUE
        FROM FI_ACCOUNT_CONTROL AC    --계정과목관리항목
        WHERE AC.ACCOUNT_CONTROL_ID   = :NEW.ACCOUNT_CONTROL_ID
          AND AC.SOB_ID               = :NEW.SOB_ID
        ;
      EXCEPTION WHEN OTHERS THEN  --의미없다.
        NULL;
      END;
      
      
      --아래 2개의 procedure call을 통해 
      --기존 FI_SLIP_MANAGEMENT_ITEM(전표관리항목내역) 테이블에 있는 관련 자료를 모두 삭제후 
      --새로운 자료로 insert하는 논리이다.
      
      --[전표관리항목내역] 자료삭제(delete)      
      FI_SLIP_G.DELETE_MANAGEMENT_ITEM( W_SLIP_LINE_ID => :NEW.SLIP_LINE_ID
                                      , W_SOB_ID => :NEW.SOB_ID
                                      , W_MANAGEMENT_SEQ => C1
                                      );
                                
                                
      --[전표관리항목내역] 자료추가(insert)
      IF V_MANAGEMENT_ID IS NOT NULL AND V_MANAGEMENT_VALUE IS NOT NULL THEN      
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
    
END IF;   --2-1.FI_SLIP_MANAGEMENT_ITEM(전표관리항목내역) 테이블 자료 변경 .
  
  
--[여기부터 ~ 여기까지]는 
/*
사실 [1번.기준이 되는 값 조회] block에 있어도 무관한 듯 보인다. 아래 문장을 제거하고...
    IF INSERTING THEN
        NULL;
    ELSE
*/


--여기부터

--새로운 거래처아이디 조회, 이는 [기존의 거래처아이디 조회]와 흡사하다. [SLIP_LINE_ID]를 제외하곤.
BEGIN
    SELECT SC.SUPP_CUST_ID
      INTO V_CUSTOMER_ID
      FROM FI_SUPP_CUST_V SC
    WHERE SC.SOB_ID               = :NEW.SOB_ID
      AND SC.SUPP_CUST_CODE       IN (SELECT MAX(SMI.MANAGEMENT_VALUE) AS MANAGEMENT_VALUE
                                        FROM FI_SLIP_MANAGEMENT_ITEM SMI    --전표관리항목내역
                                          , FI_MANAGEMENT_CODE_V FMC
                                      WHERE SMI.MANAGEMENT_ID        = FMC.MANAGEMENT_ID
                                        AND SMI.SLIP_LINE_ID         = :NEW.SLIP_LINE_ID
                                        AND SMI.SOB_ID               = :NEW.SOB_ID
                                        AND FMC.LOOKUP_TYPE          = 'CUSTOMER'
                                      )
      AND ROWNUM                  <= 1
    ;
  EXCEPTION WHEN OTHERS THEN
    V_CUSTOMER_ID := NULL;
END;
  
  
--새로운 계좌번호아이디 조회, 이는 [기존의 계좌번호아이디 조회]와 흡사하다. [SLIP_LINE_ID]를 제외하곤.
BEGIN
    SELECT BA.BANK_ACCOUNT_ID
      INTO V_BANK_ACCOUNT_ID
      FROM FI_BANK_ACCOUNT BA
    WHERE BA.SOB_ID               = :NEW.SOB_ID
      AND BA.BANK_ACCOUNT_CODE    IN (SELECT MAX(SMI.MANAGEMENT_VALUE) AS MANAGEMENT_VALUE
                                        FROM FI_SLIP_MANAGEMENT_ITEM SMI
                                          , FI_MANAGEMENT_CODE_V FMC
                                      WHERE SMI.MANAGEMENT_ID        = FMC.MANAGEMENT_ID
                                        AND SMI.SLIP_LINE_ID         = :NEW.SLIP_LINE_ID
                                        AND SMI.SOB_ID               = :NEW.SOB_ID
                                        AND FMC.LOOKUP_TYPE          = 'BANK_ACCOUNT'
                                      )
      AND ROWNUM                  <= 1
    ;
  EXCEPTION WHEN OTHERS THEN
    V_BANK_ACCOUNT_ID := NULL;
END;
  


--새로운 차입금번호 조회. 'LOAN_NUM'은 BH에는 적용되지 않은 값이다.
BEGIN
    SELECT SMI.MANAGEMENT_VALUE AS LOAN_NUM
      INTO V_LOAN_NUM
      FROM FI_SLIP_MANAGEMENT_ITEM SMI
        , FI_MANAGEMENT_CODE_V MC
    WHERE SMI.MANAGEMENT_ID           = MC.MANAGEMENT_ID
      AND SMI.SLIP_LINE_ID            = :NEW.SLIP_LINE_ID
      AND SMI.SOB_ID                  = :NEW.SOB_ID
      AND MC.LOOKUP_TYPE              = 'LOAN_NUM'
    ;
  EXCEPTION WHEN OTHERS THEN
    V_LOAN_NUM := NULL;
END;
---여기까지 




---------------------------------------------------------------------------------------------------

--3번.확정전표만 TRIGGER 발생, 틀린 것 같다. 왜냐면 이 trigger를 타는 것은 승인전표만이기 때문에
--굳이 이 주석은 무의미할 것 같다.

IF INSERTING THEN
    IF (:NEW.CONFIRM_YN = 'Y') AND (:NEW.GL_DATE IS NOT NULL) THEN
        FI_SLIP_LINE_P( 
              'II'  --처리를 위한 구분자인데, 넘기는 2자리중 1번째 문자만 procedure에서 사용한다.
            , :NEW.SLIP_LINE_ID
            , :NEW.SLIP_DATE
            , :NEW.SLIP_NUM
            , :NEW.SLIP_LINE_SEQ
            , :NEW.SLIP_HEADER_ID
            , :NEW.SOB_ID
            , :NEW.ORG_ID
            , :NEW.DEPT_ID
            , :NEW.PERSON_ID
            , :NEW.BUDGET_DEPT_ID
            , :NEW.ACCOUNT_BOOK_ID
            , :NEW.SLIP_TYPE
            , :NEW.PERIOD_NAME
            , :NEW.CONFIRM_YN
            , :NEW.CONFIRM_DATE
            , :NEW.CONFIRM_PERSON_ID
            , :NEW.GL_DATE
            , :NEW.GL_NUM
            , V_CUSTOMER_ID --새로운 거래처아이디
            , :NEW.ACCOUNT_CONTROL_ID
            , :NEW.ACCOUNT_CODE
            --, :NEW.COST_CENTER_ID*/
            , :NEW.ACCOUNT_DR_CR
            , :NEW.GL_AMOUNT
            , :NEW.CURRENCY_CODE
            , :NEW.EXCHANGE_RATE
            , :NEW.GL_CURRENCY_AMOUNT
            , V_BANK_ACCOUNT_ID --새로운 계좌번호아이디
            , :NEW.MANAGEMENT1
            , :NEW.MANAGEMENT2
            , :NEW.REFER1
            , :NEW.REFER2
            , :NEW.REFER3
            , :NEW.REFER4
            , :NEW.REFER5
            , :NEW.REFER6
            , :NEW.REFER7
            , :NEW.REFER8
            , :NEW.REFER9
            , :NEW.REFER10
            , :NEW.REFER11
            , :NEW.REFER12
            , :NEW.VOUCH_CODE
            , :NEW.REFER_RATE
            , :NEW.REFER_AMOUNT
            , :NEW.REFER_DATE1
            , :NEW.REFER_DATE2
            , :NEW.REMARK
            , :NEW.UNLIQUIDATE_SLIP_HEADER_ID
            , :NEW.UNLIQUIDATE_SLIP_LINE_ID
            , :NEW.FUND_CODE
            , :NEW.LINE_TYPE
            , :NEW.CLOSED_YN
            , :NEW.CLOSED_DATE
            , :NEW.CLOSED_PERSON_ID
            , :NEW.SOURCE_TABLE
            , :NEW.SOURCE_HEADER_ID
            , :NEW.SOURCE_LINE_ID
            , :NEW.CREATION_DATE
            , :NEW.CREATED_BY
            , :NEW.LAST_UPDATE_DATE
            , :NEW.LAST_UPDATED_BY
            , V_LOAN_NUM    --새로운 차입금번호  
        );

    END IF;

--[UPDATING THEN]에서는 기 승인자료가 수정되는 경우를 대비했다.
ELSIF UPDATING THEN
    IF (:OLD.CONFIRM_YN = 'Y') AND (:OLD.GL_DATE IS NOT NULL) THEN
        FI_SLIP_LINE_P( 
              'DU'
            , :OLD.SLIP_LINE_ID
            , :OLD.SLIP_DATE
            , :OLD.SLIP_NUM
            , :OLD.SLIP_LINE_SEQ
            , :OLD.SLIP_HEADER_ID
            , :OLD.SOB_ID
            , :OLD.ORG_ID
            , :OLD.DEPT_ID
            , :OLD.PERSON_ID
            , :OLD.BUDGET_DEPT_ID
            , :OLD.ACCOUNT_BOOK_ID
            , :OLD.SLIP_TYPE
            , :OLD.PERIOD_NAME
            , :OLD.CONFIRM_YN
            , :OLD.CONFIRM_DATE
            , :OLD.CONFIRM_PERSON_ID
            , :OLD.GL_DATE
            , :OLD.GL_NUM
            , V_OLD_CUSTOMER_ID
            , :OLD.ACCOUNT_CONTROL_ID
            , :OLD.ACCOUNT_CODE
            --, :OLD.COST_CENTER_ID
            , :OLD.ACCOUNT_DR_CR
            , :OLD.GL_AMOUNT
            , :OLD.CURRENCY_CODE
            , :OLD.EXCHANGE_RATE
            , :OLD.GL_CURRENCY_AMOUNT
            , V_OLD_BANK_ACCOUNT_ID
            , :OLD.MANAGEMENT1
            , :OLD.MANAGEMENT2
            , :OLD.REFER1
            , :OLD.REFER2
            , :OLD.REFER3
            , :OLD.REFER4
            , :OLD.REFER5
            , :OLD.REFER6
            , :OLD.REFER7
            , :OLD.REFER8
            , :OLD.REFER9
            , :OLD.REFER10
            , :OLD.REFER11
            , :OLD.REFER12
            , :OLD.VOUCH_CODE
            , :OLD.REFER_RATE
            , :OLD.REFER_AMOUNT
            , :OLD.REFER_DATE1
            , :OLD.REFER_DATE2
            , :OLD.REMARK
            , :OLD.UNLIQUIDATE_SLIP_HEADER_ID
            , :OLD.UNLIQUIDATE_SLIP_LINE_ID
            , :OLD.FUND_CODE
            , :OLD.LINE_TYPE
            , :OLD.CLOSED_YN
            , :OLD.CLOSED_DATE
            , :OLD.CLOSED_PERSON_ID
            , :OLD.SOURCE_TABLE
            , :OLD.SOURCE_HEADER_ID
            , :OLD.SOURCE_LINE_ID
            , :OLD.CREATION_DATE
            , :OLD.CREATED_BY
            , :OLD.LAST_UPDATE_DATE
            , :OLD.LAST_UPDATED_BY
            , V_OLD_LOAN_NUM );

    END IF;

    IF (:NEW.CONFIRM_YN = 'Y') AND (:NEW.GL_DATE IS NOT NULL) THEN
        FI_SLIP_LINE_P(
              'IU'
            , :NEW.SLIP_LINE_ID
            , :NEW.SLIP_DATE
            , :NEW.SLIP_NUM
            , :NEW.SLIP_LINE_SEQ
            , :NEW.SLIP_HEADER_ID
            , :NEW.SOB_ID
            , :NEW.ORG_ID
            , :NEW.DEPT_ID
            , :NEW.PERSON_ID
            , :NEW.BUDGET_DEPT_ID
            , :NEW.ACCOUNT_BOOK_ID
            , :NEW.SLIP_TYPE
            , :NEW.PERIOD_NAME
            , :NEW.CONFIRM_YN
            , :NEW.CONFIRM_DATE
            , :NEW.CONFIRM_PERSON_ID
            , :NEW.GL_DATE
            , :NEW.GL_NUM
            , V_CUSTOMER_ID
            , :NEW.ACCOUNT_CONTROL_ID
            , :NEW.ACCOUNT_CODE
            --, :NEW.COST_CENTER_ID
            , :NEW.ACCOUNT_DR_CR
            , :NEW.GL_AMOUNT
            , :NEW.CURRENCY_CODE
            , :NEW.EXCHANGE_RATE
            , :NEW.GL_CURRENCY_AMOUNT
            , V_BANK_ACCOUNT_ID
            , :NEW.MANAGEMENT1
            , :NEW.MANAGEMENT2
            , :NEW.REFER1
            , :NEW.REFER2
            , :NEW.REFER3
            , :NEW.REFER4
            , :NEW.REFER5
            , :NEW.REFER6
            , :NEW.REFER7
            , :NEW.REFER8
            , :NEW.REFER9
            , :NEW.REFER10
            , :NEW.REFER11
            , :NEW.REFER12
            , :NEW.VOUCH_CODE
            , :NEW.REFER_RATE
            , :NEW.REFER_AMOUNT
            , :NEW.REFER_DATE1
            , :NEW.REFER_DATE2
            , :NEW.REMARK
            , :NEW.UNLIQUIDATE_SLIP_HEADER_ID
            , :NEW.UNLIQUIDATE_SLIP_LINE_ID
            , :NEW.FUND_CODE
            , :NEW.LINE_TYPE
            , :NEW.CLOSED_YN
            , :NEW.CLOSED_DATE
            , :NEW.CLOSED_PERSON_ID
            , :NEW.SOURCE_TABLE
            , :NEW.SOURCE_HEADER_ID
            , :NEW.SOURCE_LINE_ID
            , :NEW.CREATION_DATE
            , :NEW.CREATED_BY
            , :NEW.LAST_UPDATE_DATE
            , :NEW.LAST_UPDATED_BY
            , V_LOAN_NUM  );

    END IF;

ELSIF DELETING THEN
    IF (:OLD.CONFIRM_YN = 'Y') AND (:OLD.GL_DATE IS NOT NULL) THEN
        FI_SLIP_LINE_P( 
              'DD'
            , :OLD.SLIP_LINE_ID
            , :OLD.SLIP_DATE
            , :OLD.SLIP_NUM
            , :OLD.SLIP_LINE_SEQ
            , :OLD.SLIP_HEADER_ID
            , :OLD.SOB_ID
            , :OLD.ORG_ID
            , :OLD.DEPT_ID
            , :OLD.PERSON_ID
            , :OLD.BUDGET_DEPT_ID
            , :OLD.ACCOUNT_BOOK_ID
            , :OLD.SLIP_TYPE
            , :OLD.PERIOD_NAME
            , :OLD.CONFIRM_YN
            , :OLD.CONFIRM_DATE
            , :OLD.CONFIRM_PERSON_ID
            , :OLD.GL_DATE
            , :OLD.GL_NUM
            , V_OLD_CUSTOMER_ID
            , :OLD.ACCOUNT_CONTROL_ID
            , :OLD.ACCOUNT_CODE
            --, :OLD.COST_CENTER_ID
            , :OLD.ACCOUNT_DR_CR
            , :OLD.GL_AMOUNT
            , :OLD.CURRENCY_CODE
            , :OLD.EXCHANGE_RATE
            , :OLD.GL_CURRENCY_AMOUNT
            , V_OLD_BANK_ACCOUNT_ID
            , :OLD.MANAGEMENT1
            , :OLD.MANAGEMENT2
            , :OLD.REFER1
            , :OLD.REFER2
            , :OLD.REFER3
            , :OLD.REFER4
            , :OLD.REFER5
            , :OLD.REFER6
            , :OLD.REFER7
            , :OLD.REFER8
            , :OLD.REFER9
            , :OLD.REFER10            
            , :OLD.REFER11
            , :OLD.REFER12
            , :OLD.VOUCH_CODE
            , :OLD.REFER_RATE
            , :OLD.REFER_AMOUNT
            , :OLD.REFER_DATE1
            , :OLD.REFER_DATE2
            , :OLD.REMARK
            , :OLD.UNLIQUIDATE_SLIP_HEADER_ID
            , :OLD.UNLIQUIDATE_SLIP_LINE_ID
            , :OLD.FUND_CODE
            , :OLD.LINE_TYPE
            , :OLD.CLOSED_YN
            , :OLD.CLOSED_DATE
            , :OLD.CLOSED_PERSON_ID
            , :OLD.SOURCE_TABLE
            , :OLD.SOURCE_HEADER_ID
            , :OLD.SOURCE_LINE_ID
            , :OLD.CREATION_DATE
            , :OLD.CREATED_BY
            , :OLD.LAST_UPDATE_DATE
            , :OLD.LAST_UPDATED_BY
            , V_OLD_LOAN_NUM  );

    END IF;

    -- 전표 삭제시 LOG TABLE에 저장
    -- Interface Table 에 CONFIRM_YN 를 'N', 회계일자, 회계번호를 NULL값으로 Update 해 준다
    BEGIN
        INSERT INTO  FI_SLIP_LINE_LOG( 
                  SLIP_LINE_ID
                , SLIP_DATE
                , SLIP_NUM
                , SLIP_LINE_SEQ
                , SLIP_HEADER_ID
                , SOB_ID
                , ORG_ID
                , DEPT_ID
                , PERSON_ID
                , BUDGET_DEPT_ID
                , ACCOUNT_BOOK_ID
                , SLIP_TYPE
                , PERIOD_NAME
                , CONFIRM_YN
                , CONFIRM_DATE
                , CONFIRM_PERSON_ID
                , GL_DATE
                , GL_NUM
                , CUSTOMER_ID
                , ACCOUNT_CONTROL_ID
                , ACCOUNT_CODE
                , COST_CENTER_ID
                , ACCOUNT_DR_CR
                , GL_AMOUNT
                , CURRENCY_CODE
                , EXCHANGE_RATE
                , GL_CURRENCY_AMOUNT
                , BANK_ACCOUNT_ID
                , MANAGEMENT1
                , MANAGEMENT2
                , REFER1
                , REFER2
                , REFER3
                , REFER4
                , REFER5
                , REFER6
                , REFER7
                , REFER8
                , REFER9
                , REFER10
                , REFER11
                , REFER12
                , REFER_RATE
                , REFER_AMOUNT
                , REFER_DATE1
                , REFER_DATE2
                , VOUCH_CODE
                , REMARK
                , UNLIQUIDATE_SLIP_HEADER_ID
                , UNLIQUIDATE_SLIP_LINE_ID
                , FUND_CODE
                , LINE_TYPE
                , SOURCE_TABLE
                , SOURCE_HEADER_ID
                , SOURCE_LINE_ID
                , CREATION_DATE
                , CREATED_BY
                , LAST_UPDATE_DATE
                , LAST_UPDATED_BY
            ) 
            VALUES( 
                  :OLD.SLIP_LINE_ID
                , :OLD.SLIP_DATE
                , :OLD.SLIP_NUM
                , :OLD.SLIP_LINE_SEQ
                , :OLD.SLIP_HEADER_ID
                , :OLD.SOB_ID
                , :OLD.ORG_ID
                , :OLD.DEPT_ID
                , :OLD.PERSON_ID
                , :OLD.BUDGET_DEPT_ID
                , :OLD.ACCOUNT_BOOK_ID
                , :OLD.SLIP_TYPE
                , :OLD.PERIOD_NAME
                , :OLD.CONFIRM_YN
                , :OLD.CONFIRM_DATE
                , :OLD.CONFIRM_PERSON_ID
                , :OLD.GL_DATE
                , :OLD.GL_NUM
                , :OLD.CUSTOMER_ID
                , :OLD.ACCOUNT_CONTROL_ID
                , :OLD.ACCOUNT_CODE
                , :OLD.COST_CENTER_ID
                , :OLD.ACCOUNT_DR_CR
                , :OLD.GL_AMOUNT
                , :OLD.CURRENCY_CODE
                , :OLD.EXCHANGE_RATE
                , :OLD.GL_CURRENCY_AMOUNT
                , :OLD.BANK_ACCOUNT_ID
                , :OLD.MANAGEMENT1
                , :OLD.MANAGEMENT2
                , :OLD.REFER1
                , :OLD.REFER2
                , :OLD.REFER3
                , :OLD.REFER4
                , :OLD.REFER5
                , :OLD.REFER6
                , :OLD.REFER7
                , :OLD.REFER8
                , :OLD.REFER9
                , :OLD.REFER10
                , :OLD.REFER11
                , :OLD.REFER12
                , :OLD.REFER_RATE
                , :OLD.REFER_AMOUNT
                , :OLD.REFER_DATE1
                , :OLD.REFER_DATE2
                , :OLD.VOUCH_CODE
                , :OLD.REMARK
                , :OLD.UNLIQUIDATE_SLIP_HEADER_ID
                , :OLD.UNLIQUIDATE_SLIP_LINE_ID
                , :OLD.FUND_CODE
                , :OLD.LINE_TYPE
                , :OLD.SOURCE_TABLE
                , :OLD.SOURCE_HEADER_ID
                , :OLD.SOURCE_LINE_ID
                , :OLD.CREATION_DATE
                , :OLD.CREATED_BY
                , :OLD.LAST_UPDATE_DATE
                , :OLD.LAST_UPDATED_BY
            );

    EXCEPTION WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20001, 'SLIP LINE LOG INSERT ERROR : ('||SQLERRM||')');
    END;

END IF; --IF INSERTING THEN

--EXCEPTION
--    WHEN OTHERS THEN
--        RAISE_APPLICATION_ERROR(-20005, 'TRIGGER FI_SLIP_LINE_T ERROR : '||SQLERRM);
END FI_SLIP_LINE_T;
/
