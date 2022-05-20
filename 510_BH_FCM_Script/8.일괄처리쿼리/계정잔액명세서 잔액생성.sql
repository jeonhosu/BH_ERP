
DECLARE
  V_SYSDATE                   DATE := GET_LOCAL_DATE(&W_SOB_ID);
  V_ITEM_GROUP_ID             NUMBER := 0;    -- 관리항목 그룹 ID.
  V_BASE_CURRENCY_CODE        VARCHAR2(10);   -- 기본통화.
  
  V_FORWARD_AMOUNT            NUMBER := 0;    -- 전일 잔액.
  V_INCREASE_AMOUNT           NUMBER := 0;    -- 당일 증가.
  V_DECREASE_AMOUNT           NUMBER := 0;    -- 당일 감소.
  V_REMAIN_AMOUNT             NUMBER := 0;    -- 당일 잔액.
  
  V_CURR_FORWARD_AMOUNT       NUMBER := 0;    -- 외화 전일 잔액.
  V_CURR_INCREASE_AMOUNT      NUMBER := 0;    -- 외화 당일 증가.
  V_CURR_DECREASE_AMOUNT      NUMBER := 0;    -- 외화 당일 감소.
  V_CURR_REMAIN_AMOUNT        NUMBER := 0;    -- 외화 당일 잔액.
BEGIN
  V_BASE_CURRENCY_CODE := FI_ACCOUNT_BOOK_G.BASE_CURRENCY_F(&W_SOB_ID);
  FOR C1 IN ( -- 계정잔액명세 계정 조회.
              SELECT BA.ACCOUNT_CONTROL_ID
                   , BA.ACCOUNT_CODE
                   , AC.ACCOUNT_DR_CR
                   , BA.SOB_ID
                   , BA.ESTIMATE_YN
                FROM FI_BALANCE_ACCOUNTS BA
                  , FI_ACCOUNT_CONTROL AC
              WHERE BA.ACCOUNT_CONTROL_ID     = AC.ACCOUNT_CONTROL_ID
                AND BA.SOB_ID                 = &W_SOB_ID
                AND BA.ENABLED_FLAG           = 'Y'
                AND BA.EFFECTIVE_DATE_FR      <= &W_GL_DATE
                AND (BA.EFFECTIVE_DATE_TO IS NULL OR BA.EFFECTIVE_DATE_TO >= &W_GL_DATE)
              )
  LOOP
    DBMS_OUTPUT.PUT_LINE('C1 : ACCOUNT CODE : ' || C1.ACCOUNT_CODE || '(' || C1.ACCOUNT_CONTROL_ID || ')/잔액구분 : ' || C1.ACCOUNT_DR_CR);
---------------------------------------------------------------------------------------------------
    -- 기초자료 이월 및 기존 자료 당일 금액 초기화.
    FOR C2 IN ( SELECT BS.ACCOUNT_CONTROL_ID
                     , BS.ACCOUNT_CODE
                     , BS.CURRENCY_CODE
                     , BS.ITEM_GROUP_ID
                     , BS.SOB_ID
                     , BS.REMAIN_AMOUNT
                     , BS.NEW_REMAIN_AMOUNT
                     , BS.CURR_REMAIN_AMOUNT
                  FROM FI_BALANCE_STATEMENT BS
                WHERE BS.GL_DATE            = &W_GL_DATE - 1
                  AND BS.GL_DATE_SEQ        = 1
                  AND BS.ACCOUNT_CONTROL_ID = C1.ACCOUNT_CONTROL_ID
                  AND BS.SOB_ID             = C1.SOB_ID
              )
    LOOP
      V_FORWARD_AMOUNT            := NVL(C2.REMAIN_AMOUNT, 0);         -- 전일 잔액.
      V_CURR_FORWARD_AMOUNT       := NVL(C2.CURR_REMAIN_AMOUNT, 0);    -- 외화 전일 잔액.
      -- 이월시 이월된 금액 적용 --
      BEGIN
        SELECT NVL(BS.NEW_REMAIN_AMOUNT, BS.REMAIN_AMOUNT) AS REMAIN_AMOUNT
             , NVL(BS.CURR_REMAIN_AMOUNT, 0) AS CURR_REMAIN_AMOUNT
          INTO V_FORWARD_AMOUNT
             , V_CURR_FORWARD_AMOUNT
          FROM FI_BALANCE_STATEMENT BS
        WHERE BS.GL_DATE            = &W_GL_DATE
          AND BS.GL_DATE_SEQ        = 0
          AND BS.ACCOUNT_CONTROL_ID = C2.ACCOUNT_CONTROL_ID
          AND BS.CURRENCY_CODE      = C2.CURRENCY_CODE
          AND BS.ITEM_GROUP_ID      = C2.ITEM_GROUP_ID
          AND BS.SOB_ID             = C2.SOB_ID
        ;
      EXCEPTION WHEN OTHERS THEN
        NULL;
      END;
      -- 기초 금액 UPDATE/INSERT --
      UPDATE FI_BALANCE_STATEMENT BS
       SET BS.FORWARD_AMOUNT        = NVL(V_FORWARD_AMOUNT, 0)
         , BS.INCREASE_AMOUNT       = 0
         , BS.DECREASE_AMOUNT       = 0
         , BS.REMAIN_AMOUNT         = NVL(V_FORWARD_AMOUNT, 0)
         , BS.CURR_FORWARD_AMOUNT   = NVL(V_CURR_FORWARD_AMOUNT, 0)
         , BS.CURR_INCREASE_AMOUNT  = 0
         , BS.CURR_DECREASE_AMOUNT  = 0
         , BS.CURR_REMAIN_AMOUNT    = NVL(V_CURR_FORWARD_AMOUNT, 0)
      WHERE BS.GL_DATE            = &W_GL_DATE
        AND BS.GL_DATE_SEQ        = 1
        AND BS.ACCOUNT_CONTROL_ID = C2.ACCOUNT_CONTROL_ID
        AND BS.CURRENCY_CODE      = C2.CURRENCY_CODE
        AND BS.ITEM_GROUP_ID      = C2.ITEM_GROUP_ID
        AND BS.SOB_ID             = C2.SOB_ID
      ;
      IF SQL%ROWCOUNT = 0 THEN
        INSERT INTO FI_BALANCE_STATEMENT
        ( GL_DATE
        , GL_DATE_SEQ
        , ACCOUNT_CONTROL_ID
        , ACCOUNT_CODE
        , CURRENCY_CODE
        , ITEM_GROUP_ID
        , SOB_ID
        , FORWARD_AMOUNT
        , REMAIN_AMOUNT
        , CURR_FORWARD_AMOUNT
        , CURR_REMAIN_AMOUNT
        , CREATION_DATE
        , CREATED_BY
        , LAST_UPDATE_DATE
        , LAST_UPDATED_BY
        ) VALUES
        ( &W_GL_DATE
        , 1    -- GL_DATE_SEQ
        , C2.ACCOUNT_CONTROL_ID
        , C2.ACCOUNT_CODE
        , C2.CURRENCY_CODE
        , C2.ITEM_GROUP_ID
        , C2.SOB_ID
        , NVL(V_FORWARD_AMOUNT, 0)  -- FORWARD_AMOUNT
        , NVL(V_FORWARD_AMOUNT, 0)  -- REMAIN_AMOUNT
        , NVL(V_CURR_FORWARD_AMOUNT, 0)  -- CURR_FORWARD_AMOUNT
        , NVL(V_CURR_FORWARD_AMOUNT, 0)  -- CURR_REMAIN_AMOUNT
        , V_SYSDATE
        , &P_USER_ID
        , V_SYSDATE
        , &P_USER_ID
        );
     END IF;
    END LOOP C2;
---------------------------------------------------------------------------------------------------
    FOR C2 IN ( -- 전표내역 조회
                SELECT SL.SLIP_LINE_ID
                     , SL.ACCOUNT_CONTROL_ID
                     , SL.ACCOUNT_CODE
                     , SL.GL_DATE
                     , SL.SOB_ID
                     , SL.CURRENCY_CODE
                     , DECODE(SL.ACCOUNT_DR_CR, '1', SL.GL_AMOUNT, 0) AS DR_AMOUNT
                     , DECODE(SL.ACCOUNT_DR_CR, '2', SL.GL_AMOUNT, 0) AS CR_AMOUNT
                     , DECODE(SL.ACCOUNT_DR_CR, '1', SL.GL_CURRENCY_AMOUNT, 0) AS DR_CURR_AMOUNT
                     , DECODE(SL.ACCOUNT_DR_CR, '2', SL.GL_CURRENCY_AMOUNT, 0) AS CR_CURR_AMOUNT
                     , SMI.MANAGEMENT1_VALUE
                     , SMI.MANAGEMENT2_VALUE
                     , SMI.MANAGEMENT3_VALUE
                     , SMI.MANAGEMENT4_VALUE
                     , SMI.MANAGEMENT5_VALUE
                     , SMI.MANAGEMENT6_VALUE
                     , SMI.MANAGEMENT7_VALUE
                     , SMI.MANAGEMENT8_VALUE
                     , SMI.MANAGEMENT9_VALUE
                     , SMI.MANAGEMENT10_VALUE
                     , SMI.MANAGEMENT11_VALUE
                     , SMI.MANAGEMENT12_VALUE
                     , SMI.MANAGEMENT13_VALUE
                     , SMI.MANAGEMENT14_VALUE
                     , SMI.MANAGEMENT15_VALUE
                  FROM FI_SLIP_HEADER SH
                    , FI_SLIP_LINE SL
                    , FI_SLIP_MANAGEMENT_ITEM_V9 SMI
                WHERE SH.SLIP_HEADER_ID           = SL.SLIP_HEADER_ID
                  AND SL.SLIP_LINE_ID             = SMI.SLIP_LINE_ID
                  AND SH.GL_DATE                  = &W_GL_DATE
                  AND SH.SOB_ID                   = C1.SOB_ID
                  AND SL.ACCOUNT_CONTROL_ID       = C1.ACCOUNT_CONTROL_ID
                  AND SL.SOB_ID                   = C1.SOB_ID
                  AND SL.CONFIRM_YN               = 'Y'
                )
    LOOP
---> 금액 정리.    
      V_INCREASE_AMOUNT           := 0;    -- 당일 증가.
      V_DECREASE_AMOUNT           := 0;    -- 당일 감소.
      V_REMAIN_AMOUNT             := 0;    -- 당일 잔액.
      
      V_CURR_INCREASE_AMOUNT      := 0;    -- 외화 당일 증가.
      V_CURR_DECREASE_AMOUNT      := 0;    -- 외화 당일 감소.
      V_CURR_REMAIN_AMOUNT        := 0;    -- 외화 당일 잔액.
      
      IF C1.ACCOUNT_DR_CR = '1' THEN  -- 차변 계정 : 차변금액 증가, 대변금액 감소.
        V_INCREASE_AMOUNT := NVL(C2.DR_AMOUNT, 0);    
        V_DECREASE_AMOUNT := NVL(C2.CR_AMOUNT, 0);
        IF C2.CURRENCY_CODE <> V_BASE_CURRENCY_CODE THEN
          V_CURR_INCREASE_AMOUNT := NVL(C2.DR_CURR_AMOUNT, 0);    
          V_CURR_DECREASE_AMOUNT := NVL(C2.CR_CURR_AMOUNT, 0);
        END IF;
      ELSIF C1.ACCOUNT_DR_CR = '2' THEN  -- 대변 계정 : 대변금액 증가, 차변금액 감소.
        V_INCREASE_AMOUNT := NVL(C2.CR_AMOUNT, 0);
        V_DECREASE_AMOUNT := NVL(C2.DR_AMOUNT, 0);
        IF C2.CURRENCY_CODE <> V_BASE_CURRENCY_CODE THEN
          V_CURR_INCREASE_AMOUNT := NVL(C2.CR_CURR_AMOUNT, 0);    
          V_CURR_DECREASE_AMOUNT := NVL(C2.DR_CURR_AMOUNT, 0);
        END IF;
      END IF;
---> 금액 정리 완료.
---> 계정별 발생구분.
      BEGIN
        SELECT DISTINCT BSI.ITEM_GROUP_ID
          INTO V_ITEM_GROUP_ID
          FROM FI_BALANCE_STATEMENT_ITEM_V9 BSI
        WHERE BSI.ACCOUNT_CONTROL_ID    = C2.ACCOUNT_CONTROL_ID
          AND BSI.CURRENCY_CODE         = C2.CURRENCY_CODE
          AND BSI.SOB_ID                = C2.SOB_ID
          AND BSI.MANAGEMENT1_VALUE     = C2.MANAGEMENT1_VALUE 
          AND BSI.MANAGEMENT2_VALUE     = C2.MANAGEMENT2_VALUE 
          AND BSI.MANAGEMENT3_VALUE     = C2.MANAGEMENT3_VALUE 
          AND BSI.MANAGEMENT4_VALUE     = C2.MANAGEMENT4_VALUE 
          AND BSI.MANAGEMENT5_VALUE     = C2.MANAGEMENT5_VALUE 
          AND BSI.MANAGEMENT6_VALUE     = C2.MANAGEMENT6_VALUE 
          AND BSI.MANAGEMENT7_VALUE     = C2.MANAGEMENT7_VALUE 
          AND BSI.MANAGEMENT8_VALUE     = C2.MANAGEMENT8_VALUE 
          AND BSI.MANAGEMENT9_VALUE     = C2.MANAGEMENT9_VALUE 
          AND BSI.MANAGEMENT10_VALUE    = C2.MANAGEMENT10_VALUE
          AND BSI.MANAGEMENT11_VALUE    = C2.MANAGEMENT11_VALUE
          AND BSI.MANAGEMENT12_VALUE    = C2.MANAGEMENT12_VALUE
          AND BSI.MANAGEMENT13_VALUE    = C2.MANAGEMENT13_VALUE
          AND BSI.MANAGEMENT14_VALUE    = C2.MANAGEMENT14_VALUE
          AND BSI.MANAGEMENT15_VALUE    = C2.MANAGEMENT15_VALUE          
        ;
      EXCEPTION WHEN OTHERS THEN
        V_ITEM_GROUP_ID := 0;
      END;
      DBMS_OUTPUT.PUT_LINE('ACCOUNT CODE : ' || C2.ACCOUNT_CODE || '(' || C2.ACCOUNT_CONTROL_ID || '), ITEM GROUP : ' || V_ITEM_GROUP_ID || ', LINE ID : ' || C2.SLIP_LINE_ID || ', 차변 : ' || C2.DR_AMOUNT || ', 대변 : ' || C2.CR_AMOUNT ||', 증가 : ' || V_INCREASE_AMOUNT || ', 감소 : ' || V_DECREASE_AMOUNT );
      
---> 전일 잔액 조회(이월금액).
      BEGIN
        SELECT BS.REMAIN_AMOUNT
             , BS.CURR_REMAIN_AMOUNT
          INTO V_FORWARD_AMOUNT
             , V_CURR_FORWARD_AMOUNT
          FROM FI_BALANCE_STATEMENT BS
        WHERE BS.GL_DATE            = (&W_GL_DATE - 1)
          AND BS.GL_DATE_SEQ        = 1
          AND BS.ACCOUNT_CONTROL_ID = C2.ACCOUNT_CONTROL_ID
          AND BS.CURRENCY_CODE      = C2.CURRENCY_CODE
          AND BS.ITEM_GROUP_ID      = V_ITEM_GROUP_ID
          AND BS.SOB_ID             = C2.SOB_ID
        ;
      EXCEPTION WHEN OTHERS THEN
        V_FORWARD_AMOUNT := 0;
        V_CURR_FORWARD_AMOUNT := 0;
      END;
    
---> 계정잔액명세 관리항목 INSERT.
      IF V_ITEM_GROUP_ID = 0 THEN
        -- ITEM_GROUP_ID 채번.
        BEGIN
          SELECT NVL(MAX(BSI.ITEM_GROUP_ID), 0) + 1 AS NEXT_ITEM_GROUP_ID          
            INTO V_ITEM_GROUP_ID
            FROM FI_BALANCE_STATEMENT_ITEM_V9 BSI
          WHERE BSI.ACCOUNT_CONTROL_ID    = C2.ACCOUNT_CONTROL_ID
            AND BSI.CURRENCY_CODE         = C2.CURRENCY_CODE
            AND BSI.SOB_ID                = C2.SOB_ID
          ;
        EXCEPTION WHEN OTHERS THEN
          V_ITEM_GROUP_ID := 1;
        END;
        FOR R1 IN ( SELECT BAI.ACCOUNT_CONTROL_ID
                         , BAI.ACCOUNT_CODE
                         , BAI.SOB_ID
                         , BAI.MANAGEMENT_SEQ
                         , BAI.MANAGEMENT_ID
                         , BAI.MANAGEMENT_CODE
                      FROM FI_BALANCE_ACCOUNTS_ITEM BAI
                    WHERE BAI.ACCOUNT_CONTROL_ID  = C2.ACCOUNT_CONTROL_ID
                      AND BAI.SOB_ID              = C2.SOB_ID
                      AND BAI.ENABLED_FLAG        = 'Y'
                    ORDER BY BAI.MANAGEMENT_SEQ
                   )
        LOOP
          DBMS_OUTPUT.PUT_LINE('ACCOUNT CODE : ' || R1.ACCOUNT_CODE || ', SEQ : ' || R1.MANAGEMENT_SEQ || ', CODE : ' || R1.MANAGEMENT_CODE );
          INSERT INTO FI_BALANCE_STATEMENT_ITEM BS
          ( ACCOUNT_CONTROL_ID
          , ACCOUNT_CODE
          , CURRENCY_CODE
          , ITEM_GROUP_ID
          , SOB_ID
          , MANAGEMENT_SEQ
          , MANAGEMENT_ID
          , MANAGEMENT_CODE
          , MANAGEMENT_VALUE
          , CREATION_DATE
          , CREATED_BY
          , LAST_UPDATE_DATE
          , LAST_UPDATED_BY
          ) VALUES
          ( C2.ACCOUNT_CONTROL_ID
          , C2.ACCOUNT_CODE
          , C2.CURRENCY_CODE
          , V_ITEM_GROUP_ID
          , C2.SOB_ID
          , R1.MANAGEMENT_SEQ
          , R1.MANAGEMENT_ID
          , R1.MANAGEMENT_CODE
          , CASE
              WHEN R1.MANAGEMENT_SEQ = 1 THEN DECODE(C2.MANAGEMENT1_VALUE, ')', NULL, C2.MANAGEMENT1_VALUE)
              WHEN R1.MANAGEMENT_SEQ = 2 THEN DECODE(C2.MANAGEMENT2_VALUE, ')', NULL, C2.MANAGEMENT2_VALUE)
              WHEN R1.MANAGEMENT_SEQ = 3 THEN DECODE(C2.MANAGEMENT3_VALUE, ')', NULL, C2.MANAGEMENT3_VALUE)
              WHEN R1.MANAGEMENT_SEQ = 4 THEN DECODE(C2.MANAGEMENT4_VALUE, ')', NULL, C2.MANAGEMENT4_VALUE)
              WHEN R1.MANAGEMENT_SEQ = 5 THEN DECODE(C2.MANAGEMENT5_VALUE, ')', NULL, C2.MANAGEMENT5_VALUE)
              WHEN R1.MANAGEMENT_SEQ = 6 THEN DECODE(C2.MANAGEMENT6_VALUE, ')', NULL, C2.MANAGEMENT6_VALUE)
              WHEN R1.MANAGEMENT_SEQ = 7 THEN DECODE(C2.MANAGEMENT7_VALUE, ')', NULL, C2.MANAGEMENT7_VALUE)
              WHEN R1.MANAGEMENT_SEQ = 8 THEN DECODE(C2.MANAGEMENT8_VALUE, ')', NULL, C2.MANAGEMENT8_VALUE)
              WHEN R1.MANAGEMENT_SEQ = 9 THEN DECODE(C2.MANAGEMENT9_VALUE, ')', NULL, C2.MANAGEMENT9_VALUE)
              WHEN R1.MANAGEMENT_SEQ = 10 THEN DECODE(C2.MANAGEMENT10_VALUE, ')', NULL, C2.MANAGEMENT10_VALUE)
              WHEN R1.MANAGEMENT_SEQ = 11 THEN DECODE(C2.MANAGEMENT11_VALUE, ')', NULL, C2.MANAGEMENT11_VALUE)
              WHEN R1.MANAGEMENT_SEQ = 12 THEN DECODE(C2.MANAGEMENT12_VALUE, ')', NULL, C2.MANAGEMENT12_VALUE)
              WHEN R1.MANAGEMENT_SEQ = 13 THEN DECODE(C2.MANAGEMENT13_VALUE, ')', NULL, C2.MANAGEMENT13_VALUE)
              WHEN R1.MANAGEMENT_SEQ = 14 THEN DECODE(C2.MANAGEMENT14_VALUE, ')', NULL, C2.MANAGEMENT14_VALUE)
              WHEN R1.MANAGEMENT_SEQ = 15 THEN DECODE(C2.MANAGEMENT15_VALUE, ')', NULL, C2.MANAGEMENT15_VALUE)
            END
          , V_SYSDATE
          , &P_USER_ID
          , V_SYSDATE
          , &P_USER_ID
          );
        END LOOP R1;
      END IF;
---> 계정잔액명세 관리항목 INSERT 종료.
---> 계정잔액명세 잔액금액 UPDATE/INSERT.
     UPDATE FI_BALANCE_STATEMENT BS
       SET BS.INCREASE_AMOUNT       = NVL(BS.INCREASE_AMOUNT, 0) + NVL(V_INCREASE_AMOUNT, 0)
         , BS.DECREASE_AMOUNT       = NVL(BS.DECREASE_AMOUNT, 0) + NVL(V_DECREASE_AMOUNT, 0)
         , BS.REMAIN_AMOUNT         = (NVL(BS.FORWARD_AMOUNT, 0) + NVL(BS.INCREASE_AMOUNT, 0) + NVL(V_INCREASE_AMOUNT, 0))
                                      - (NVL(BS.DECREASE_AMOUNT, 0) + NVL(V_DECREASE_AMOUNT, 0))
         , BS.CURR_INCREASE_AMOUNT  = NVL(BS.CURR_INCREASE_AMOUNT, 0) + NVL(V_CURR_INCREASE_AMOUNT, 0)
         , BS.CURR_DECREASE_AMOUNT  = NVL(BS.CURR_DECREASE_AMOUNT, 0) + NVL(V_CURR_DECREASE_AMOUNT, 0)
         , BS.CURR_REMAIN_AMOUNT    = (NVL(BS.CURR_FORWARD_AMOUNT, 0) + NVL(BS.CURR_INCREASE_AMOUNT, 0) + NVL(V_CURR_INCREASE_AMOUNT, 0))
                                      - (NVL(BS.CURR_DECREASE_AMOUNT, 0) + NVL(V_CURR_DECREASE_AMOUNT, 0))
         , BS.LAST_UPDATE_DATE      = V_SYSDATE
         , BS.LAST_UPDATED_BY       = &P_USER_ID
     WHERE BS.GL_DATE               = C2.GL_DATE
       AND BS.GL_DATE_SEQ           = 1
       AND BS.ACCOUNT_CONTROL_ID    = C2.ACCOUNT_CONTROL_ID
       AND BS.CURRENCY_CODE         = C2.CURRENCY_CODE
       AND BS.ITEM_GROUP_ID         = V_ITEM_GROUP_ID
       AND BS.SOB_ID                = C2.SOB_ID
     ;
     IF SQL%ROWCOUNT = 0 THEN
       INSERT INTO FI_BALANCE_STATEMENT
       ( GL_DATE
       , GL_DATE_SEQ
       , ACCOUNT_CONTROL_ID
       , ACCOUNT_CODE
       , CURRENCY_CODE
       , ITEM_GROUP_ID
       , SOB_ID
       , INCREASE_AMOUNT
       , DECREASE_AMOUNT
       , REMAIN_AMOUNT
       , CURR_INCREASE_AMOUNT
       , CURR_DECREASE_AMOUNT
       , CURR_REMAIN_AMOUNT
       , CREATION_DATE
       , CREATED_BY
       , LAST_UPDATE_DATE
       , LAST_UPDATED_BY
       ) VALUES
       ( C2.GL_DATE
       , 1    -- GL_DATE_SEQ
       , C2.ACCOUNT_CONTROL_ID
       , C2.ACCOUNT_CODE
       , C2.CURRENCY_CODE
       , V_ITEM_GROUP_ID
       , C2.SOB_ID
       , NVL(V_INCREASE_AMOUNT, 0)
       , NVL(V_DECREASE_AMOUNT, 0)
       , NVL(V_INCREASE_AMOUNT, 0) - NVL(V_DECREASE_AMOUNT, 0)  -- 잔액.
       , NVL(V_CURR_INCREASE_AMOUNT, 0)
       , NVL(V_CURR_DECREASE_AMOUNT, 0)
       , NVL(V_CURR_INCREASE_AMOUNT, 0) - NVL(V_CURR_DECREASE_AMOUNT, 0)  -- 외화잔액.
       , V_SYSDATE
       , &P_USER_ID
       , V_SYSDATE
       , &P_USER_ID
       );
     END IF;
    END LOOP C2;
  END LOOP C1;
END;
