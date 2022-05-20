CREATE OR REPLACE PACKAGE FI_BALANCE_STATEMENT_SET_G
AS

-- �����ܾ׸� �ܾ� ����.
  PROCEDURE MAIN_BALANCE_STATEMENT
            ( W_GL_DATE_FR           IN FI_BALANCE_STATEMENT.GL_DATE%TYPE
            , W_GL_DATE_TO           IN FI_BALANCE_STATEMENT.GL_DATE%TYPE
            , W_ACCOUNT_CONTROL_ID   IN FI_BALANCE_STATEMENT.ACCOUNT_CONTROL_ID%TYPE
            , W_SOB_ID               IN FI_BALANCE_STATEMENT.SOB_ID%TYPE
            , P_USER_ID              IN FI_BALANCE_STATEMENT.CREATED_BY%TYPE
            , O_MESSAGE              OUT VARCHAR2
            );

-----------------------------------------------------------------------------------------
-- �����ܾ׸� : ȯ�� ���� ó��.
  PROCEDURE SET_CURRENCY_ESTIMATE
            ( W_GL_DATE              IN FI_BALANCE_STATEMENT.GL_DATE%TYPE
            , W_SOB_ID               IN FI_BALANCE_STATEMENT.SOB_ID%TYPE
            , P_CONNECT_PERSON_ID    IN FI_BALANCE_STATEMENT.CLOSED_PERSON_ID%TYPE
            , P_USER_ID              IN FI_BALANCE_STATEMENT.CREATED_BY%TYPE
            , O_MESSAGE              OUT VARCHAR2
            );

-- �����ܾ׸� : ȯ�� ���� ó�� ���.
  PROCEDURE SET_CURRENCY_ESTIMATE_CANCEL
            ( W_GL_DATE              IN FI_BALANCE_STATEMENT.GL_DATE%TYPE
            , W_SOB_ID               IN FI_BALANCE_STATEMENT.SOB_ID%TYPE
            , P_CONNECT_PERSON_ID    IN FI_BALANCE_STATEMENT.CLOSED_PERSON_ID%TYPE
            , P_USER_ID              IN FI_BALANCE_STATEMENT.CREATED_BY%TYPE
            , O_MESSAGE              OUT VARCHAR2
            );

-----------------------------------------------------------------------------------------
-- �����ܾ׸� �̿� ó��(GL_DATE_SEQ = 0).
  PROCEDURE SET_CARRY_FORWARD
            ( W_GL_DATE              IN FI_BALANCE_STATEMENT.GL_DATE%TYPE
            , W_SOB_ID               IN FI_BALANCE_STATEMENT.SOB_ID%TYPE
            , P_CONNECT_PERSON_ID    IN FI_BALANCE_STATEMENT.CLOSED_PERSON_ID%TYPE
            , P_USER_ID              IN FI_BALANCE_STATEMENT.CREATED_BY%TYPE
            , O_MESSAGE              OUT VARCHAR2
            );

-- �����ܾ׸� �̿� ó��(GL_DATE_SEQ = 0) ���.
  PROCEDURE SET_CARRY_FORWARD_CANCEL
            ( W_GL_DATE              IN FI_BALANCE_STATEMENT.GL_DATE%TYPE
            , W_SOB_ID               IN FI_BALANCE_STATEMENT.SOB_ID%TYPE
            , P_CONNECT_PERSON_ID    IN FI_BALANCE_STATEMENT.CLOSED_PERSON_ID%TYPE
            , P_USER_ID              IN FI_BALANCE_STATEMENT.CREATED_BY%TYPE
            , O_MESSAGE              OUT VARCHAR2
            );
            
END FI_BALANCE_STATEMENT_SET_G;
/
CREATE OR REPLACE PACKAGE BODY FI_BALANCE_STATEMENT_SET_G
AS
/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : FI_BALANCE_STATEMENT_SET_G
/* Description  : �����ܾ׸� �ܾ� ����.
/*
/* Reference by :
/* Program History :
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
-- �����ܾ׸� �ܾ� ����.
  PROCEDURE MAIN_BALANCE_STATEMENT
            ( W_GL_DATE_FR           IN FI_BALANCE_STATEMENT.GL_DATE%TYPE
            , W_GL_DATE_TO           IN FI_BALANCE_STATEMENT.GL_DATE%TYPE
            , W_ACCOUNT_CONTROL_ID   IN FI_BALANCE_STATEMENT.ACCOUNT_CONTROL_ID%TYPE
            , W_SOB_ID               IN FI_BALANCE_STATEMENT.SOB_ID%TYPE
            , P_USER_ID              IN FI_BALANCE_STATEMENT.CREATED_BY%TYPE
            , O_MESSAGE              OUT VARCHAR2
            )
  AS
    V_SYSDATE                   DATE := GET_LOCAL_DATE(W_SOB_ID);
    V_DAY_COUNT                 NUMBER := 0;    -- ����ó�� �Ⱓ(����).
    V_GL_DATE                   DATE := W_GL_DATE_FR;  -- ó������.
    V_ITEM_GROUP_ID             NUMBER := 0;    -- �����׸� �׷� ID.
    V_BASE_CURRENCY_CODE        VARCHAR2(10);   -- �⺻��ȭ.
    
    V_FORWARD_AMOUNT            NUMBER := 0;    -- ���� �ܾ�.
    V_INCREASE_AMOUNT           NUMBER := 0;    -- ���� ����.
    V_DECREASE_AMOUNT           NUMBER := 0;    -- ���� ����.
    V_REMAIN_AMOUNT             NUMBER := 0;    -- ���� �ܾ�.
    
    V_CURR_FORWARD_AMOUNT       NUMBER := 0;    -- ��ȭ ���� �ܾ�.
    V_CURR_INCREASE_AMOUNT      NUMBER := 0;    -- ��ȭ ���� ����.
    V_CURR_DECREASE_AMOUNT      NUMBER := 0;    -- ��ȭ ���� ����.
    V_CURR_REMAIN_AMOUNT        NUMBER := 0;    -- ��ȭ ���� �ܾ�.
  BEGIN
    V_BASE_CURRENCY_CODE := FI_ACCOUNT_BOOK_G.BASE_CURRENCY_F(W_SOB_ID);      
    BEGIN
      V_DAY_COUNT := W_GL_DATE_TO - W_GL_DATE_FR;
      IF V_DAY_COUNT < 0 THEN
        RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10012', NULL));
      END IF;
    EXCEPTION WHEN OTHERS THEN
      V_DAY_COUNT := 0;
    END;
    FOR B1 IN 0 .. V_DAY_COUNT
    LOOP 
      V_GL_DATE := W_GL_DATE_FR + B1;
      
      FOR C1 IN ( -- �����ܾ׸� ���� ��ȸ.
                  SELECT BA.ACCOUNT_CONTROL_ID
                       , BA.ACCOUNT_CODE
                       , AC.ACCOUNT_DR_CR
                       , BA.SOB_ID
                       , BA.ESTIMATE_YN
                    FROM FI_BALANCE_ACCOUNTS BA
                      , FI_ACCOUNT_CONTROL AC
                  WHERE BA.ACCOUNT_CONTROL_ID     = AC.ACCOUNT_CONTROL_ID
                    AND BA.SOB_ID                 = W_SOB_ID
                    AND BA.ACCOUNT_CONTROL_ID     = NVL(W_ACCOUNT_CONTROL_ID, BA.ACCOUNT_CONTROL_ID)
                    AND BA.ENABLED_FLAG           = 'Y'
                    AND BA.EFFECTIVE_DATE_FR      <= V_GL_DATE
                    AND (BA.EFFECTIVE_DATE_TO IS NULL OR BA.EFFECTIVE_DATE_TO >= V_GL_DATE)
                  )
      LOOP
  ---------------------------------------------------------------------------------------------------
        -- ���� �ݾ� �ʱ�ȭ.
        UPDATE FI_BALANCE_STATEMENT BS
         SET BS.FORWARD_AMOUNT        = 0
           , BS.INCREASE_AMOUNT       = 0
           , BS.DECREASE_AMOUNT       = 0
           , BS.REMAIN_AMOUNT         = 0
           , BS.CURR_FORWARD_AMOUNT   = 0
           , BS.CURR_INCREASE_AMOUNT  = 0
           , BS.CURR_DECREASE_AMOUNT  = 0
           , BS.CURR_REMAIN_AMOUNT    = 0
           , BS.CARRY_FORWARD_YN      = 'N'
        WHERE BS.GL_DATE            = V_GL_DATE
          AND BS.GL_DATE_SEQ        = 1
          AND BS.ACCOUNT_CONTROL_ID = C1.ACCOUNT_CONTROL_ID
          AND BS.SOB_ID             = C1.SOB_ID
        ;
        -- ���� ���� ��ǥ ���� �ʱ�ȭ.
        DELETE FROM FI_BALANCE_STATEMENT_SLIP BSS
        WHERE BSS.GL_DATE             = V_GL_DATE
          AND BSS.ACCOUNT_CONTROL_ID  = C1.ACCOUNT_CONTROL_ID
          AND BSS.SOB_ID              = C1.SOB_ID
        ;       
  ---------------------------------------------------------------------------------------------------
        -- �����ڷ� �̿�.
        FOR C2 IN ( SELECT BS.ACCOUNT_CONTROL_ID
                         , BS.ACCOUNT_CODE
                         , BS.CURRENCY_CODE
                         , BS.ITEM_GROUP_ID
                         , BS.SOB_ID
                         , BS.REMAIN_AMOUNT
                         , BS.NEW_REMAIN_AMOUNT
                         , BS.CURR_REMAIN_AMOUNT
                      FROM FI_BALANCE_STATEMENT BS
                    WHERE BS.GL_DATE            = V_GL_DATE - 1
                      AND BS.GL_DATE_SEQ        = 1
                      AND BS.ACCOUNT_CONTROL_ID = C1.ACCOUNT_CONTROL_ID
                      AND BS.SOB_ID             = C1.SOB_ID
                  )
        LOOP
          V_FORWARD_AMOUNT            := NVL(C2.REMAIN_AMOUNT, 0);         -- ���� �ܾ�.
          V_CURR_FORWARD_AMOUNT       := NVL(C2.CURR_REMAIN_AMOUNT, 0);    -- ��ȭ ���� �ܾ�.
          -- �̿��� �̿��� �ݾ� ���� --
          BEGIN
            SELECT NVL(BS.NEW_REMAIN_AMOUNT, BS.REMAIN_AMOUNT) AS REMAIN_AMOUNT
                 , NVL(BS.CURR_REMAIN_AMOUNT, 0) AS CURR_REMAIN_AMOUNT
              INTO V_FORWARD_AMOUNT
                 , V_CURR_FORWARD_AMOUNT
              FROM FI_BALANCE_STATEMENT BS
            WHERE BS.GL_DATE            = V_GL_DATE
              AND BS.GL_DATE_SEQ        = 0
              AND BS.ACCOUNT_CONTROL_ID = C2.ACCOUNT_CONTROL_ID
              AND BS.CURRENCY_CODE      = C2.CURRENCY_CODE
              AND BS.ITEM_GROUP_ID      = C2.ITEM_GROUP_ID
              AND BS.SOB_ID             = C2.SOB_ID
            ;
          EXCEPTION WHEN OTHERS THEN
            NULL;
          END;
          -- ���� �ݾ� UPDATE/INSERT --
          UPDATE FI_BALANCE_STATEMENT BS
           SET BS.FORWARD_AMOUNT      = NVL(V_FORWARD_AMOUNT, 0)
             , BS.REMAIN_AMOUNT       = NVL(V_FORWARD_AMOUNT, 0)
             , BS.CURR_FORWARD_AMOUNT = NVL(V_CURR_FORWARD_AMOUNT, 0)
             , BS.CURR_REMAIN_AMOUNT  = NVL(V_CURR_FORWARD_AMOUNT, 0)
          WHERE BS.GL_DATE            = V_GL_DATE
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
            ( V_GL_DATE
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
            , P_USER_ID
            , V_SYSDATE
            , P_USER_ID
            );
         END IF;
        END LOOP C2;
  ---------------------------------------------------------------------------------------------------
        FOR C2 IN ( -- ��ǥ���� ��ȸ
                    SELECT SL.SLIP_LINE_ID
                         , SL.SLIP_HEADER_ID
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
                         , SMI.BALANCE1_VALUE
                         , SMI.BALANCE2_VALUE
                         , SMI.BALANCE3_VALUE
                         , SMI.BALANCE4_VALUE
                         , SMI.BALANCE5_VALUE
                         , SMI.BALANCE6_VALUE
                         , SMI.BALANCE7_VALUE
                         , SMI.BALANCE8_VALUE
                         , SMI.BALANCE9_VALUE
                         , SMI.BALANCE10_VALUE
                         , SMI.BALANCE11_VALUE
                         , SMI.BALANCE12_VALUE
                         , SMI.BALANCE13_VALUE
                         , SMI.BALANCE14_VALUE
                         , SMI.BALANCE15_VALUE
                      FROM FI_SLIP_HEADER SH
                        , FI_SLIP_LINE SL
                        , FI_SLIP_MANAGEMENT_ITEM_V9 SMI
                    WHERE SH.SLIP_HEADER_ID           = SL.SLIP_HEADER_ID
                      AND SL.SLIP_LINE_ID             = SMI.SLIP_LINE_ID
                      AND SH.GL_DATE                  = V_GL_DATE
                      AND SH.SOB_ID                   = C1.SOB_ID
                      AND SL.ACCOUNT_CONTROL_ID       = C1.ACCOUNT_CONTROL_ID
                      AND SL.SOB_ID                   = C1.SOB_ID
                      AND SL.CONFIRM_YN               = 'Y'
                    )
        LOOP
  ------> �ݾ� ����.    
          V_INCREASE_AMOUNT           := 0;    -- ���� ����.
          V_DECREASE_AMOUNT           := 0;    -- ���� ����.
          V_REMAIN_AMOUNT             := 0;    -- ���� �ܾ�.
          
          V_CURR_INCREASE_AMOUNT      := 0;    -- ��ȭ ���� ����.
          V_CURR_DECREASE_AMOUNT      := 0;    -- ��ȭ ���� ����.
          V_CURR_REMAIN_AMOUNT        := 0;    -- ��ȭ ���� �ܾ�.
          
          IF C1.ACCOUNT_DR_CR = '1' THEN  -- ���� ���� : �����ݾ� ����, �뺯�ݾ� ����.
            V_INCREASE_AMOUNT := NVL(C2.DR_AMOUNT, 0);    
            V_DECREASE_AMOUNT := NVL(C2.CR_AMOUNT, 0);
            IF C2.CURRENCY_CODE <> V_BASE_CURRENCY_CODE THEN
              V_CURR_INCREASE_AMOUNT := NVL(C2.DR_CURR_AMOUNT, 0);    
              V_CURR_DECREASE_AMOUNT := NVL(C2.CR_CURR_AMOUNT, 0);
            END IF;
          ELSIF C1.ACCOUNT_DR_CR = '2' THEN  -- �뺯 ���� : �뺯�ݾ� ����, �����ݾ� ����.
            V_INCREASE_AMOUNT := NVL(C2.CR_AMOUNT, 0);
            V_DECREASE_AMOUNT := NVL(C2.DR_AMOUNT, 0);
            IF C2.CURRENCY_CODE <> V_BASE_CURRENCY_CODE THEN
              V_CURR_INCREASE_AMOUNT := NVL(C2.CR_CURR_AMOUNT, 0);    
              V_CURR_DECREASE_AMOUNT := NVL(C2.DR_CURR_AMOUNT, 0);
            END IF;
          END IF;
  ------> �ݾ� ���� �Ϸ�.
  ------> ������ �߻�����.
          BEGIN
            SELECT DISTINCT BSI.ITEM_GROUP_ID
              INTO V_ITEM_GROUP_ID
              FROM FI_BALANCE_STATEMENT_ITEM_V9 BSI
            WHERE BSI.ACCOUNT_CONTROL_ID    = C2.ACCOUNT_CONTROL_ID
              AND BSI.CURRENCY_CODE         = C2.CURRENCY_CODE
              AND BSI.SOB_ID                = C2.SOB_ID
              AND BSI.BALANCE1_VALUE     = C2.BALANCE1_VALUE 
              AND BSI.BALANCE2_VALUE     = C2.BALANCE2_VALUE 
              AND BSI.BALANCE3_VALUE     = C2.BALANCE3_VALUE 
              AND BSI.BALANCE4_VALUE     = C2.BALANCE4_VALUE 
              AND BSI.BALANCE5_VALUE     = C2.BALANCE5_VALUE 
              AND BSI.BALANCE6_VALUE     = C2.BALANCE6_VALUE 
              AND BSI.BALANCE7_VALUE     = C2.BALANCE7_VALUE 
              AND BSI.BALANCE8_VALUE     = C2.BALANCE8_VALUE 
              AND BSI.BALANCE9_VALUE     = C2.BALANCE9_VALUE 
              AND BSI.BALANCE10_VALUE    = C2.BALANCE10_VALUE
              AND BSI.BALANCE11_VALUE    = C2.BALANCE11_VALUE
              AND BSI.BALANCE12_VALUE    = C2.BALANCE12_VALUE
              AND BSI.BALANCE13_VALUE    = C2.BALANCE13_VALUE
              AND BSI.BALANCE14_VALUE    = C2.BALANCE14_VALUE
              AND BSI.BALANCE15_VALUE    = C2.BALANCE15_VALUE
            ;
          EXCEPTION WHEN OTHERS THEN
            V_ITEM_GROUP_ID := 0;
          END;
          
  ------> ���� �ܾ� ��ȸ(�̿��ݾ�).
          BEGIN
            SELECT BS.REMAIN_AMOUNT
                 , BS.CURR_REMAIN_AMOUNT
              INTO V_FORWARD_AMOUNT
                 , V_CURR_FORWARD_AMOUNT
              FROM FI_BALANCE_STATEMENT BS
            WHERE BS.GL_DATE            = (V_GL_DATE - 1)
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
        
  ------> �����ܾ׸� �����׸� INSERT.
          IF V_ITEM_GROUP_ID = 0 THEN
            -- ITEM_GROUP_ID ä��.
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
              , P_USER_ID
              , V_SYSDATE
              , P_USER_ID
              );
            END LOOP R1;
          END IF;
  ------> �����ܾ׸� �����׸� INSERT ����.
  ------> �����ܾ׸� �ܾױݾ� UPDATE/INSERT.
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
              , BS.LAST_UPDATED_BY       = P_USER_ID
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
            , NVL(V_INCREASE_AMOUNT, 0) - NVL(V_DECREASE_AMOUNT, 0)  -- �ܾ�.
            , NVL(V_CURR_INCREASE_AMOUNT, 0)
            , NVL(V_CURR_DECREASE_AMOUNT, 0)
            , NVL(V_CURR_INCREASE_AMOUNT, 0) - NVL(V_CURR_DECREASE_AMOUNT, 0)  -- ��ȭ�ܾ�.
            , V_SYSDATE
            , P_USER_ID
            , V_SYSDATE
            , P_USER_ID
            );
          END IF;
          
  ------> ���� ��ǥ ����.
          INSERT INTO FI_BALANCE_STATEMENT_SLIP
          ( GL_DATE
          , ACCOUNT_CONTROL_ID
          , ACCOUNT_CODE
          , CURRENCY_CODE
          , ITEM_GROUP_ID
          , SOB_ID
          , DR_AMOUNT
          , CR_AMOUNT
          , DR_CURR_AMOUNT
          , CR_CURR_AMOUNT
          , SLIP_LINE_ID
          , SLIP_HEADER_ID
          , CREATION_DATE
          , CREATED_BY
          , LAST_UPDATE_DATE
          , LAST_UPDATED_BY
          ) VALUES
          ( C2.GL_DATE
          , C2.ACCOUNT_CONTROL_ID
          , C2.ACCOUNT_CODE
          , C2.CURRENCY_CODE
          , V_ITEM_GROUP_ID
          , C2.SOB_ID
          , NVL(C2.DR_AMOUNT, 0)
          , NVL(C2.CR_AMOUNT, 0)
          , NVL(C2.DR_CURR_AMOUNT, 0)
          , NVL(C2.CR_CURR_AMOUNT, 0)
          , C2.SLIP_LINE_ID
          , C2.SLIP_HEADER_ID
          , V_SYSDATE
          , P_USER_ID
          , V_SYSDATE
          , P_USER_ID        
          );
        END LOOP C2;
      END LOOP C1;
    END LOOP B1;
    O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10112', NULL);
  EXCEPTION WHEN OTHERS THEN
    O_MESSAGE := SUBSTR(SQLERRM, 1, 150);
  END MAIN_BALANCE_STATEMENT;

-----------------------------------------------------------------------------------------
-- �����ܾ׸� : ȯ�� ���� ó��.
  PROCEDURE SET_CURRENCY_ESTIMATE
            ( W_GL_DATE              IN FI_BALANCE_STATEMENT.GL_DATE%TYPE
            , W_SOB_ID               IN FI_BALANCE_STATEMENT.SOB_ID%TYPE
            , P_CONNECT_PERSON_ID    IN FI_BALANCE_STATEMENT.CLOSED_PERSON_ID%TYPE
            , P_USER_ID              IN FI_BALANCE_STATEMENT.CREATED_BY%TYPE
            , O_MESSAGE              OUT VARCHAR2
            )
  AS
    V_SYSDATE                        DATE := GET_LOCAL_DATE(W_SOB_ID);
    V_RECORD_COUNT                   NUMBER := 0;    -- �ڷ� �Ǽ�.
    V_BASE_CURRENCY_CODE             VARCHAR2(10);   -- �⺻��ȭ.
    V_NEW_REMAIN_AMOUNT              NUMBER := 0;    -- ȯ�� �� �ݾ�.
  BEGIN
    -- �ش����� ȯ�� ���� ���� üũ.
    BEGIN
      SELECT COUNT(BSE.CURRENCY_CODE) AS RECORD_COUNT
        INTO V_RECORD_COUNT
        FROM FI_BALANCE_STATEMENT_EXCHANGE BSE
      WHERE BSE.GL_DATE       = W_GL_DATE
        AND BSE.SOB_ID        = W_SOB_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_RECORD_COUNT := 0;
    END;
    IF V_RECORD_COUNT = 0 THEN
      O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10268', NULL);
      RETURN;
    END IF;
    
    V_BASE_CURRENCY_CODE := FI_ACCOUNT_BOOK_G.BASE_CURRENCY_F(W_SOB_ID);
    FOR C1 IN ( SELECT BS.GL_DATE
                     , BS.ACCOUNT_CONTROL_ID
                     , BS.ACCOUNT_CODE
                     , BS.CURRENCY_CODE
                     , BS.ITEM_GROUP_ID
                     , BS.SOB_ID
                     , BS.CURR_REMAIN_AMOUNT
                     , NVL(( SELECT BSE.EXCHANGE_RATE
                               FROM FI_BALANCE_STATEMENT_EXCHANGE BSE
                             WHERE BSE.GL_DATE        = BS.GL_DATE
                               AND BSE.CURRENCY_CODE  = BS.CURRENCY_CODE
                               AND BSE.SOB_ID         = BS.SOB_ID
                            ), 0) AS NEW_EXCHANGE_RATE
                  FROM FI_BALANCE_STATEMENT BS
                    , FI_BALANCE_ACCOUNTS BA
                WHERE BS.ACCOUNT_CONTROL_ID = BA.ACCOUNT_CONTROL_ID
                  AND BS.SOB_ID             = BA.SOB_ID
                  AND BS.GL_DATE            = W_GL_DATE
                  AND BS.GL_DATE_SEQ        = 1
                  AND BS.SOB_ID             = W_SOB_ID
                  AND BA.ESTIMATE_YN        = 'Y'
                  AND (BS.REMAIN_AMOUNT      <> 0
                    OR BS.CURR_REMAIN_AMOUNT <> 0)
              )
    LOOP
      V_NEW_REMAIN_AMOUNT := 0;
      V_NEW_REMAIN_AMOUNT := NVL(C1.CURR_REMAIN_AMOUNT, 0) * NVL(C1.NEW_EXCHANGE_RATE, 0);
      V_NEW_REMAIN_AMOUNT := FI_COMMON_G.CONVERSION_BASE_AMOUNT_F(V_BASE_CURRENCY_CODE, C1.SOB_ID, V_NEW_REMAIN_AMOUNT);
      
      -- ���� �ݾ� �� �ܾ� UPDATE/INSERT --
      UPDATE FI_BALANCE_STATEMENT BS
       SET BS.NEW_EXCHANGE_RATE   = NVL(C1.NEW_EXCHANGE_RATE, 0)
         , BS.NEW_REMAIN_AMOUNT   = NVL(V_NEW_REMAIN_AMOUNT, 0)
         , BS.ESTIMATE_DATE       = V_SYSDATE
         , BS.ESTIMATE_PERSON_ID  = P_CONNECT_PERSON_ID
      WHERE BS.GL_DATE            = C1.GL_DATE
        AND BS.GL_DATE_SEQ        = 1
        AND BS.ACCOUNT_CONTROL_ID = C1.ACCOUNT_CONTROL_ID
        AND BS.CURRENCY_CODE      = C1.CURRENCY_CODE
        AND BS.ITEM_GROUP_ID      = C1.ITEM_GROUP_ID
        AND BS.SOB_ID             = C1.SOB_ID
      ;
    END LOOP C1;
    O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10112', NULL);
  EXCEPTION WHEN OTHERS THEN
    O_MESSAGE := SUBSTR(SQLERRM, 1, 150);
  END SET_CURRENCY_ESTIMATE;

-- �����ܾ׸� : ȯ�� ���� ó�� ���.
  PROCEDURE SET_CURRENCY_ESTIMATE_CANCEL
            ( W_GL_DATE              IN FI_BALANCE_STATEMENT.GL_DATE%TYPE
            , W_SOB_ID               IN FI_BALANCE_STATEMENT.SOB_ID%TYPE
            , P_CONNECT_PERSON_ID    IN FI_BALANCE_STATEMENT.CLOSED_PERSON_ID%TYPE
            , P_USER_ID              IN FI_BALANCE_STATEMENT.CREATED_BY%TYPE
            , O_MESSAGE              OUT VARCHAR2
            )
  AS
    V_BASE_CURRENCY_CODE             VARCHAR2(10);   -- �⺻��ȭ.
  BEGIN
    V_BASE_CURRENCY_CODE := FI_ACCOUNT_BOOK_G.BASE_CURRENCY_F(W_SOB_ID);
    FOR C1 IN ( SELECT BS.GL_DATE
                     , BS.ACCOUNT_CONTROL_ID
                     , BS.ACCOUNT_CODE
                     , BS.CURRENCY_CODE
                     , BS.ITEM_GROUP_ID
                     , BS.SOB_ID
                     , BS.CURR_REMAIN_AMOUNT
                     , NVL(( SELECT BSE.EXCHANGE_RATE
                               FROM FI_BALANCE_STATEMENT_EXCHANGE BSE
                             WHERE BSE.GL_DATE        = BS.GL_DATE
                               AND BSE.CURRENCY_CODE  = BS.CURRENCY_CODE
                               AND BSE.SOB_ID         = BS.SOB_ID
                            ), 0) AS NEW_EXCHANGE_RATE
                  FROM FI_BALANCE_STATEMENT BS
                    , FI_BALANCE_ACCOUNTS BA
                WHERE BS.ACCOUNT_CONTROL_ID = BA.ACCOUNT_CONTROL_ID
                  AND BS.SOB_ID             = BA.SOB_ID
                  AND BS.GL_DATE            = W_GL_DATE
                  AND BS.GL_DATE_SEQ        = 1
                  AND BS.SOB_ID             = W_SOB_ID
                  AND BA.ESTIMATE_YN        = 'Y'
                  AND (BS.REMAIN_AMOUNT      <> 0
                    OR BS.CURR_REMAIN_AMOUNT <> 0)
              )
    LOOP
      -- ���� �ݾ� �� �ܾ� UPDATE/INSERT --
      UPDATE FI_BALANCE_STATEMENT BS
       SET BS.NEW_EXCHANGE_RATE   = 0
         , BS.NEW_REMAIN_AMOUNT   = 0
         , BS.ESTIMATE_DATE       = NULL
         , BS.ESTIMATE_PERSON_ID  = NULL
      WHERE BS.GL_DATE            = C1.GL_DATE
        AND BS.GL_DATE_SEQ        = 1
        AND BS.ACCOUNT_CONTROL_ID = C1.ACCOUNT_CONTROL_ID
        AND BS.CURRENCY_CODE      = C1.CURRENCY_CODE
        AND BS.ITEM_GROUP_ID      = C1.ITEM_GROUP_ID
        AND BS.SOB_ID             = C1.SOB_ID
      ;
    END LOOP C1;
    O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10112', NULL);
  EXCEPTION WHEN OTHERS THEN
    O_MESSAGE := SUBSTR(SQLERRM, 1, 150);
  END SET_CURRENCY_ESTIMATE_CANCEL;
  
-----------------------------------------------------------------------------------------
-- �����ܾ׸� �̿� ó��(GL_DATE_SEQ = 0).
  PROCEDURE SET_CARRY_FORWARD
            ( W_GL_DATE              IN FI_BALANCE_STATEMENT.GL_DATE%TYPE
            , W_SOB_ID               IN FI_BALANCE_STATEMENT.SOB_ID%TYPE
            , P_CONNECT_PERSON_ID    IN FI_BALANCE_STATEMENT.CLOSED_PERSON_ID%TYPE
            , P_USER_ID              IN FI_BALANCE_STATEMENT.CREATED_BY%TYPE
            , O_MESSAGE              OUT VARCHAR2
            )
  AS
    V_SYSDATE                        DATE := GET_LOCAL_DATE(W_SOB_ID);
    V_NEW_GL_DATE                    DATE;
    
    V_FORWARD_AMOUNT            NUMBER := 0;    -- �ܾ�.
    V_CURR_FORWARD_AMOUNT       NUMBER := 0;    -- ��ȭ �ܾ�.
  BEGIN
    V_NEW_GL_DATE := W_GL_DATE + 1;
    FOR C1 IN ( SELECT BS.ACCOUNT_CONTROL_ID
                     , BS.ACCOUNT_CODE
                     , BS.CURRENCY_CODE
                     , BS.ITEM_GROUP_ID
                     , BS.SOB_ID
                     , BS.REMAIN_AMOUNT
                     , BS.NEW_REMAIN_AMOUNT
                     , BS.CURR_REMAIN_AMOUNT
                  FROM FI_BALANCE_STATEMENT BS
                WHERE BS.GL_DATE            = W_GL_DATE
                  AND BS.GL_DATE_SEQ        = 1
                  AND BS.SOB_ID             = W_SOB_ID
                  AND (BS.REMAIN_AMOUNT      <> 0
                    OR BS.CURR_REMAIN_AMOUNT <> 0
                    OR BS.NEW_REMAIN_AMOUNT  <> 0)
              )
    LOOP
      V_CURR_FORWARD_AMOUNT       := NVL(C1.CURR_REMAIN_AMOUNT, 0);    -- ��ȭ �ܾ�.
      IF NVL(C1.NEW_REMAIN_AMOUNT, 0) <> 0 THEN
        V_FORWARD_AMOUNT          := NVL(C1.NEW_REMAIN_AMOUNT, 0);     -- ȯ��ݾ� ����.
      ELSE
        V_FORWARD_AMOUNT          := NVL(C1.REMAIN_AMOUNT, 0);         -- �ܾ�.
      END IF;      
      
      -- ���� �ݾ� �� �ܾ� UPDATE/INSERT --
      UPDATE FI_BALANCE_STATEMENT BS
       SET BS.FORWARD_AMOUNT        = NVL(V_FORWARD_AMOUNT, 0)
         , BS.INCREASE_AMOUNT       = 0
         , BS.DECREASE_AMOUNT       = 0
         , BS.REMAIN_AMOUNT         = NVL(V_FORWARD_AMOUNT, 0)
         , BS.CURR_FORWARD_AMOUNT   = NVL(V_CURR_FORWARD_AMOUNT, 0)
         , BS.CURR_INCREASE_AMOUNT  = 0
         , BS.CURR_DECREASE_AMOUNT  = 0
         , BS.CURR_REMAIN_AMOUNT    = NVL(V_CURR_FORWARD_AMOUNT, 0)
      WHERE BS.GL_DATE            = V_NEW_GL_DATE
        AND BS.GL_DATE_SEQ        = 0
        AND BS.ACCOUNT_CONTROL_ID = C1.ACCOUNT_CONTROL_ID
        AND BS.CURRENCY_CODE      = C1.CURRENCY_CODE
        AND BS.ITEM_GROUP_ID      = C1.ITEM_GROUP_ID
        AND BS.SOB_ID             = C1.SOB_ID
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
        ( V_NEW_GL_DATE
        , 0    -- GL_DATE_SEQ : �ܾ� �̿�.
        , C1.ACCOUNT_CONTROL_ID
        , C1.ACCOUNT_CODE
        , C1.CURRENCY_CODE
        , C1.ITEM_GROUP_ID
        , C1.SOB_ID
        , NVL(V_FORWARD_AMOUNT, 0)  -- FORWARD_AMOUNT
        , NVL(V_FORWARD_AMOUNT, 0)  -- REMAIN_AMOUNT
        , NVL(V_CURR_FORWARD_AMOUNT, 0)  -- CURR_FORWARD_AMOUNT
        , NVL(V_CURR_FORWARD_AMOUNT, 0)  -- CURR_REMAIN_AMOUNT
        , V_SYSDATE
        , P_USER_ID
        , V_SYSDATE
        , P_USER_ID
        );
     END IF;
     
     -- �ܾ� �̿� �� FLAG ���� --
      UPDATE FI_BALANCE_STATEMENT BS
       SET BS.CARRY_FORWARD_YN    = 'Y'
         , BS.CLOSED_YN           = 'Y'
         , BS.CLOSED_DATE         = SYSDATE
         , BS.CLOSED_PERSON_ID    = P_CONNECT_PERSON_ID
      WHERE BS.GL_DATE            = W_GL_DATE
        AND BS.GL_DATE_SEQ        = 1
        AND BS.ACCOUNT_CONTROL_ID = C1.ACCOUNT_CONTROL_ID
        AND BS.CURRENCY_CODE      = C1.CURRENCY_CODE
        AND BS.ITEM_GROUP_ID      = C1.ITEM_GROUP_ID
        AND BS.SOB_ID             = C1.SOB_ID
      ;
    END LOOP C1;
    O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10112', NULL);
  EXCEPTION WHEN OTHERS THEN
    O_MESSAGE := SUBSTR(SQLERRM, 1, 150);
  END SET_CARRY_FORWARD;

-- �����ܾ׸� �̿� ó��(GL_DATE_SEQ = 0) ���.
  PROCEDURE SET_CARRY_FORWARD_CANCEL
            ( W_GL_DATE              IN FI_BALANCE_STATEMENT.GL_DATE%TYPE
            , W_SOB_ID               IN FI_BALANCE_STATEMENT.SOB_ID%TYPE
            , P_CONNECT_PERSON_ID    IN FI_BALANCE_STATEMENT.CLOSED_PERSON_ID%TYPE
            , P_USER_ID              IN FI_BALANCE_STATEMENT.CREATED_BY%TYPE
            , O_MESSAGE              OUT VARCHAR2
            )
  AS
    V_NEW_GL_DATE                    DATE;
  BEGIN
    V_NEW_GL_DATE := W_GL_DATE + 1;
    FOR C1 IN ( SELECT BS.ACCOUNT_CONTROL_ID
                     , BS.ACCOUNT_CODE
                     , BS.CURRENCY_CODE
                     , BS.ITEM_GROUP_ID
                     , BS.SOB_ID
                     , BS.REMAIN_AMOUNT
                     , BS.NEW_REMAIN_AMOUNT
                     , BS.CURR_REMAIN_AMOUNT
                  FROM FI_BALANCE_STATEMENT BS
                WHERE BS.GL_DATE            = V_NEW_GL_DATE
                  AND BS.GL_DATE_SEQ        = 0
                  AND BS.SOB_ID             = W_SOB_ID
              )
    LOOP
      
      -- �̿� �ݾ� ���� --
      DELETE FROM FI_BALANCE_STATEMENT BS
      WHERE BS.GL_DATE            = V_NEW_GL_DATE
        AND BS.GL_DATE_SEQ        = 0
        AND BS.ACCOUNT_CONTROL_ID = C1.ACCOUNT_CONTROL_ID
        AND BS.CURRENCY_CODE      = C1.CURRENCY_CODE
        AND BS.ITEM_GROUP_ID      = C1.ITEM_GROUP_ID
        AND BS.SOB_ID             = C1.SOB_ID
      ;     
     -- �ܾ� �̿� �� FLAG ���� --
      UPDATE FI_BALANCE_STATEMENT BS
       SET BS.CARRY_FORWARD_YN    = 'N'
         , BS.CLOSED_YN           = 'N'
         , BS.CLOSED_DATE         = NULL
         , BS.CLOSED_PERSON_ID    = NULL
      WHERE BS.GL_DATE            = W_GL_DATE
        AND BS.GL_DATE_SEQ        = 1
        AND BS.ACCOUNT_CONTROL_ID = C1.ACCOUNT_CONTROL_ID
        AND BS.CURRENCY_CODE      = C1.CURRENCY_CODE
        AND BS.ITEM_GROUP_ID      = C1.ITEM_GROUP_ID
        AND BS.SOB_ID             = C1.SOB_ID
      ;
    END LOOP C1;
    O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10112', NULL);
  EXCEPTION WHEN OTHERS THEN
    O_MESSAGE := SUBSTR(SQLERRM, 1, 150);
  END SET_CARRY_FORWARD_CANCEL;
  
END FI_BALANCE_STATEMENT_SET_G;
/
