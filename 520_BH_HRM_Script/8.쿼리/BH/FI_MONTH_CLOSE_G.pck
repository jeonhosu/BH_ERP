CREATE OR REPLACE PACKAGE FI_MONTH_CLOSE_G
AS
  E_INSERT_ERR                  EXCEPTION;
  E_DELETE_ERR                  EXCEPTION;
  
  PROCEDURE MONTHLY_CLOSE
            ( P_PERIOD_NAME       IN VARCHAR2
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , P_USER_ID           IN NUMBER
            , O_MESSAGE           OUT VARCHAR2
            );

END FI_MONTH_CLOSE_G;
/
CREATE OR REPLACE PACKAGE BODY FI_MONTH_CLOSE_G
AS
/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_MONTH_CLOSE_G
/* Description  : 월마감 및 잔액 이월 처리.
/*
/* Reference by :    ** 거래처 및 예적금 월마감 **
                  거래처관리 계정(ACCOUNT_VNDR_YN = 'Y'),
                  예적금관리 계정(ACCOUNT_MANAGE  = '04')
                  의 월 발생집계를 익월 01일자에 GL_DATE_SEQ = 0 에 이월처리한다.
                  
                  1) 은행계좌별 일마감테이블 ( FI_DAILY_BANK_ACCOUNT_SUM )
                  2) 일계마감테이블 ( FI_DAILY_SUM )
                  3) 일자별 계정별거래처별잔액 ( FI_CUSTOMER_BALANCE_DAILY )
                  4) 계정별거래처별잔액 ( FI_CUSTOMER_BALANCE )
                  5) 계정별관리항목별 자액(FI_MANAGEMENT_BALANCE)
                  
                  -- 입력예)  2010-10 -> 2010-11로 이월시
                     입력을 2010-11 로 받는다  즉 이월하고자 하는 입력 년월을 받는다.
/* Program History :
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
  PROCEDURE MONTHLY_CLOSE
            ( P_PERIOD_NAME       IN VARCHAR2
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , P_USER_ID           IN NUMBER
            , O_MESSAGE           OUT VARCHAR2
            )
  AS
    V_SYSDATE                     DATE := GET_LOCAL_DATE(P_SOB_ID);
    V_MESSAGE                     VARCHAR2(300) := NULL;
    V_N_PERIOD_NAME               VARCHAR2(10);
    V_N_FIRST_DATE                DATE;
    V_FIRST_DATE                  DATE;
    V_LAST_DATE                   DATE;
    
    
  BEGIN
    ---------------------------------------------------------------------------
    -- 0. 날짜 정리.
    -- 1. 신규 생성월.
    V_N_PERIOD_NAME := TO_CHAR(ADD_MONTHS(TO_DATE(P_PERIOD_NAME, 'YYYY-MM'), 1), 'YYYY-MM');
    -- 1. 신규월 시작일자.
    V_N_FIRST_DATE := TRUNC(TO_DATE(V_N_PERIOD_NAME, 'YYYY-MM'), 'MONTH');
    
    -- 2. 전월 시작/종료일자.
    V_FIRST_DATE := TRUNC(TO_DATE(P_PERIOD_NAME, 'YYYY-MM'));
    V_LAST_DATE := LAST_DAY(V_FIRST_DATE);
    
    ---------------------------------------------------------------------------
    -- 1. 회계기간 마감.
    /*GL_FISCAL_PERIOD_G.CLOSE_FISCAL_PERIOD( W_PERIOD_NAME => P_PERIOD_NAME
                                          , W_SOB_ID => P_SOB_ID
                                          , W_ORG_ID => P_ORG_ID
                                          , P_USER_ID => P_USER_ID
                                          );*/
    
    ---------------------------------------------------------------------------
    -- 11) 은행계좌별 일마감테이블 >> 저장 전 삭제
    BEGIN
      DELETE FROM FI_DAILY_BANK_ACCOUNT_SUM
      WHERE GL_DATE      =  V_N_FIRST_DATE
        AND GL_DATE_SEQ  =  0
        AND SOB_ID       =  P_SOB_ID 
      ;
    EXCEPTION WHEN OTHERS THEN
      V_MESSAGE := '1.Daily Bank Account Delete : ' || SUBSTR(SQLERRM, 1, 200);
      RAISE E_DELETE_ERR;
    END;
    BEGIN
      INSERT INTO FI_DAILY_BANK_ACCOUNT_SUM
      ( GL_DATE                   , GL_DATE_SEQ
      , SOB_ID                    , ORG_ID
      , ACCOUNT_BOOK_ID           , ACCOUNT_CONTROL_ID
      , ACCOUNT_CODE              , BANK_ACCOUNT_ID
      , OLD_EXCHANGE_RATE         , EXCHANGE_RATE
      , DR_AMOUNT                 , CR_AMOUNT
      , DR_CURR_AMOUNT            , CR_CURR_AMOUNT
      , CREATION_DATE             , CREATED_BY
      , LAST_UPDATE_DATE          , LAST_UPDATED_BY )
      SELECT V_N_FIRST_DATE       , 0
           , P_SOB_ID             , P_ORG_ID
           , BAS.ACCOUNT_BOOK_ID  , BAS.ACCOUNT_CONTROL_ID
           , BAS.ACCOUNT_CODE     , BAS.BANK_ACCOUNT_ID
           , FCC.OLD_EXCHANGE_RATE, FCC.EXCHANGE_RATE
           , DECODE(FAC.ACCOUNT_DR_CR, '1', BAS.DR - BAS.CR, 0) AS B_DR
           , DECODE(FAC.ACCOUNT_DR_CR, '2', BAS.CR - BAS.DR, 0) AS B_CR
           , DECODE(FAC.ACCOUNT_DR_CR, '1', BAS.CURR_DR - BAS.CURR_CR, 0) AS B_CURR_DR
           , DECODE(FAC.ACCOUNT_DR_CR, '2', BAS.CURR_CR - BAS.CURR_DR, 0) AS B_CURR_CR
           /* -- 전호수 수정 
           , DECODE(SIGN(DECODE(FAC.ACCOUNT_DR_CR, '1', BAS.DR - BAS.CR,   BAS.CR - BAS.DR)), 1,
                         DECODE(FAC.ACCOUNT_DR_CR, '1', BAS.DR - BAS.CR,   BAS.CR - BAS.DR), 0) AS B_DR
           , DECODE(SIGN(DECODE(FAC.ACCOUNT_DR_CR, '1', BAS.DR - BAS.CR,   BAS.CR - BAS.DR)), -1,
                         DECODE(FAC.ACCOUNT_DR_CR, '1', BAS.DR - BAS.CR,   BAS.CR - BAS.DR) * -1, 0) AS B_CR
           , DECODE(SIGN(DECODE(FAC.ACCOUNT_DR_CR, '1', BAS.CURR_DR - BAS.CURR_CR, BAS.CURR_CR - BAS.CURR_DR)), 1,
                         DECODE(FAC.ACCOUNT_DR_CR, '1', BAS.CURR_DR - BAS.CURR_CR, BAS.CURR_CR - BAS.CURR_DR), 0) AS B_CURR_DR
           , DECODE(SIGN(DECODE(FAC.ACCOUNT_DR_CR, '1', BAS.CURR_DR - BAS.CURR_CR, BAS.CURR_CR - BAS.CURR_DR)), -1,
                         DECODE(FAC.ACCOUNT_DR_CR, '1', BAS.CURR_DR - BAS.CURR_CR, BAS.CURR_CR - BAS.CURR_DR) * -1, 0) AS B_CURR_CR*/
           , V_SYSDATE,  P_USER_ID,  V_SYSDATE,  P_USER_ID               
        FROM ( SELECT BA.SOB_ID
                    , BA.ACCOUNT_BOOK_ID
                    , BA.ACCOUNT_CONTROL_ID
                    , BA.ACCOUNT_CODE
                    , BA.BANK_ACCOUNT_ID
                    , MAX(BA.GL_DATE) AS GL_DATE
                    , SUM(BA.DR_AMOUNT) AS DR
                    , SUM(BA.CR_AMOUNT) AS CR
                    , SUM(BA.DR_CURR_AMOUNT) AS CURR_DR
                    , SUM(BA.CR_CURR_AMOUNT) AS CURR_CR
                 FROM  FI_DAILY_BANK_ACCOUNT_SUM BA
                WHERE  GL_DATE    BETWEEN V_FIRST_DATE AND V_LAST_DATE
                  AND  SOB_ID     = P_SOB_ID
                GROUP  BY BA.SOB_ID
                    , BA.ACCOUNT_BOOK_ID
                    , BA.ACCOUNT_CONTROL_ID
                    , BA.ACCOUNT_CODE
                    , BA.BANK_ACCOUNT_ID
             ) BAS,
             ( SELECT BA.SOB_ID
                    , BA.ACCOUNT_BOOK_ID
                    , BA.ACCOUNT_CONTROL_ID
                    , BA.ACCOUNT_CODE
                    , BA.BANK_ACCOUNT_ID
                    , BA.GL_DATE
                    , BA.OLD_EXCHANGE_RATE
                    , BA.EXCHANGE_RATE
                 FROM FI_DAILY_BANK_ACCOUNT_SUM BA
                WHERE SOB_ID       = P_SOB_ID
                  AND GL_DATE_SEQ  =  1
                  AND BA.GL_DATE BETWEEN V_FIRST_DATE AND V_LAST_DATE                 
             ) FCC,
             FI_ACCOUNT_CONTROL FAC
      WHERE (  BAS.DR  != 0
             OR BAS.CR  != 0
             OR BAS.CURR_DR != 0
             OR BAS.CURR_CR != 0 )
         AND BAS.ACCOUNT_CONTROL_ID = FAC.ACCOUNT_CONTROL_ID
         AND BAS.ACCOUNT_CONTROL_ID = FCC.ACCOUNT_CONTROL_ID(+)
         AND BAS.BANK_ACCOUNT_ID    = FCC.BANK_ACCOUNT_ID (+)
         AND BAS.GL_DATE            = FCC.GL_DATE(+) 
         AND FAC.SOB_ID             = P_SOB_ID         
      ;
    EXCEPTION WHEN OTHERS THEN
      V_MESSAGE := '1.Daily Bank Account Insert : ' || SUBSTR(SQLERRM, 1, 200);
      RAISE E_INSERT_ERR;
    END;
    -- 금액 없는 것은 삭제.    
    BEGIN
      DELETE FROM FI_DAILY_BANK_ACCOUNT_SUM BAS
      WHERE BAS.GL_DATE         = V_N_FIRST_DATE
        AND BAS.GL_DATE_SEQ     = 0
        AND BAS.SOB_ID          = P_SOB_ID
        AND BAS.DR_AMOUNT       = 0
        AND BAS.CR_AMOUNT       = 0
        AND BAS.DR_CURR_AMOUNT  = 0
        AND BAS.CR_CURR_AMOUNT  = 0            
      ;
    EXCEPTION WHEN OTHERS THEN
      V_MESSAGE := '2. Daily Bank Account Delete : ' || SUBSTR(SQLERRM, 1, 200);
      RAISE E_DELETE_ERR;
    END;
    
    ---------------------------------------------------------------------------
    -- 12) 일계마감테이블 >> 저장 전 삭제
    BEGIN
      DELETE FROM FI_DAILY_SUM
      WHERE GL_DATE      =  V_N_FIRST_DATE
        AND GL_DATE_SEQ  =  0
        AND SOB_ID       =  P_SOB_ID 
      ;
    EXCEPTION WHEN OTHERS THEN
      V_MESSAGE := '1. Daily Sum Delete : ' || SUBSTR(SQLERRM, 1, 200);
      RAISE E_DELETE_ERR;
    END;
    BEGIN
      INSERT INTO FI_DAILY_SUM
           (  GL_DATE             , GL_DATE_SEQ
            , SOB_ID              , ORG_ID
            , ACCOUNT_CONTROL_ID  , ACCOUNT_CODE        
            , DR_SUM              , CR_SUM
            , CURRENCY_CODE       
            , OLD_EXCHANGE_RATE   , EXCHANGE_RATE
            , DR_SUM_CURR         , CR_SUM_CURR
            , CREATION_DATE       , CREATED_BY
            , LAST_UPDATE_DATE    , LAST_UPDATED_BY)              
      SELECT V_N_FIRST_DATE       , 0
           , P_SOB_ID             , P_ORG_ID
           , DS.ACCOUNT_CONTROL_ID, DS.ACCOUNT_CODE      
           , DECODE(AC.ACCOUNT_DR_CR, '1', DS.DR_SUM - DS.CR_SUM, 0) AS DR_SUM
           , DECODE(AC.ACCOUNT_DR_CR, '2', DS.CR_SUM - DS.DR_SUM, 0) AS CR_SUM 
           , DS.CURRENCY_CODE
           , DSS.OLD_EXCHANGE_RATE , DSS.EXCHANGE_RATE
           , DECODE(AC.ACCOUNT_DR_CR, '1', DS.DR_SUM_CURR - DS.CR_SUM_CURR, 0) AS DR_SUM_CURR
           , DECODE(AC.ACCOUNT_DR_CR, '2', DS.CR_SUM_CURR - DS.DR_SUM_CURR, 0) AS CR_SUM_CURR
           /* -- 전호수 수정.
           , DECODE(SIGN(DECODE(AC.ACCOUNT_DR_CR, '1', DS.DR_SUM - DS.CR_SUM,   DS.CR_SUM - DS.DR_SUM)), 1,
                         DECODE(AC.ACCOUNT_DR_CR, '1', DS.DR_SUM - DS.CR_SUM,   DS.CR_SUM - DS.DR_SUM), 0) AS DR_SUM
           , DECODE(SIGN(DECODE(AC.ACCOUNT_DR_CR, '1', DS.DR_SUM - DS.CR_SUM,   DS.CR_SUM - DS.DR_SUM)), -1,
                         DECODE(AC.ACCOUNT_DR_CR, '1', DS.DR_SUM - DS.CR_SUM,   DS.CR_SUM - DS.DR_SUM) * -1, 0) AS CR_SUM 
           , DS.CURRENCY_CODE
           , DSS.OLD_EXCHANGE_RATE , DSS.EXCHANGE_RATE
           , DECODE(SIGN(DECODE(AC.ACCOUNT_DR_CR, '1', DS.DR_SUM_CURR - DS.CR_SUM_CURR, DS.CR_SUM_CURR - DS.DR_SUM_CURR)), 1,
                         DECODE(AC.ACCOUNT_DR_CR, '1', DS.DR_SUM_CURR - DS.CR_SUM_CURR, DS.CR_SUM_CURR - DS.DR_SUM_CURR), 0) AS DR_SUM_CURR
           , DECODE(SIGN(DECODE(AC.ACCOUNT_DR_CR, '1', DS.DR_SUM_CURR - DS.CR_SUM_CURR, DS.CR_SUM_CURR - DS.DR_SUM_CURR)), -1,
                         DECODE(AC.ACCOUNT_DR_CR, '1', DS.DR_SUM_CURR - DS.CR_SUM_CURR, DS.CR_SUM_CURR - DS.DR_SUM_CURR) * -1, 0) AS CR_SUM_CURR*/
           , V_SYSDATE,  P_USER_ID,  V_SYSDATE,  P_USER_ID               
        FROM ( SELECT FDS.SOB_ID
                    , FDS.ACCOUNT_CONTROL_ID
                    , FDS.ACCOUNT_CODE
                    , FDS.CURRENCY_CODE
                    , MAX(FDS.GL_DATE) AS GL_DATE
                    , SUM(FDS.DR_SUM) AS DR_SUM
                    , SUM(FDS.CR_SUM) AS CR_SUM
                    , SUM(FDS.DR_SUM_CURR) AS DR_SUM_CURR
                    , SUM(FDS.CR_SUM_CURR) AS CR_SUM_CURR
                 FROM  FI_DAILY_SUM FDS
                WHERE  FDS.GL_DATE    BETWEEN V_FIRST_DATE AND V_LAST_DATE
                  AND  FDS.SOB_ID     = P_SOB_ID
                GROUP  BY FDS.SOB_ID
                    , FDS.ACCOUNT_CONTROL_ID
                    , FDS.ACCOUNT_CODE
                    , FDS.CURRENCY_CODE
             ) DS,
             ( SELECT FDS.SOB_ID
                    , FDS.ACCOUNT_CONTROL_ID
                    , FDS.ACCOUNT_CODE
                    , FDS.GL_DATE
                    , FDS.CURRENCY_CODE
                    , FDS.OLD_EXCHANGE_RATE
                    , FDS.EXCHANGE_RATE
                 FROM FI_DAILY_SUM FDS
                WHERE FDS.SOB_ID       = P_SOB_ID
                  AND FDS.GL_DATE_SEQ  =  1
                  AND FDS.GL_DATE BETWEEN V_FIRST_DATE AND V_LAST_DATE
             ) DSS,
             FI_ACCOUNT_CONTROL    AC
      WHERE ( DS.DR_SUM  != 0
             OR DS.CR_SUM  != 0
             OR DS.DR_SUM_CURR != 0
             OR DS.CR_SUM_CURR != 0 )
         AND AC.ACCOUNT_CONTROL_ID  = DS.ACCOUNT_CONTROL_ID
         AND DS.ACCOUNT_CONTROL_ID  = DSS.ACCOUNT_CONTROL_ID(+)
         AND DS.GL_DATE             = DSS.GL_DATE(+)
         AND DS.CURRENCY_CODE       = DSS.CURRENCY_CODE(+)
         AND DS.SOB_ID              = P_SOB_ID         
      ;
    EXCEPTION WHEN OTHERS THEN
      V_MESSAGE := '1.Daily Sum Insert : ' || SUBSTR(SQLERRM, 1, 200);
      RAISE E_INSERT_ERR;
    END;
    -- 금액 0 삭제.
    BEGIN
      DELETE FROM FI_DAILY_SUM DS
      WHERE DS.GL_DATE          =  V_N_FIRST_DATE
        AND DS.GL_DATE_SEQ      =  0
        AND DS.SOB_ID           =  P_SOB_ID 
        AND DS.DR_SUM           = 0
        AND DS.CR_SUM           = 0
        AND DS.DR_SUM_CURR      = 0
        AND DS.CR_SUM_CURR      = 0
      ;
    EXCEPTION WHEN OTHERS THEN
      V_MESSAGE := '2.Daily Sum Delete : ' || SUBSTR(SQLERRM, 1, 200);
      RAISE E_DELETE_ERR;
    END;
    ---------------------------------------------------------------------------
    -- 13) 일별 거래처별 잔액 테이블 >> 저장 전 삭제
    BEGIN
      DELETE FROM FI_CUSTOMER_BALANCE_DAILY
      WHERE GL_DATE      =  V_N_FIRST_DATE
        AND GL_DATE_SEQ  =  0
        AND SOB_ID       =  P_SOB_ID 
      ;
    EXCEPTION WHEN OTHERS THEN
      V_MESSAGE := '2.Daily Customer Balance Daily Delete : ' || SUBSTR(SQLERRM, 1, 200);
      RAISE E_DELETE_ERR;
    END;
    
    FOR C1 IN ( SELECT BD.CUSTOMER_ID       , BD.ACCOUNT_BOOK_ID
                     , BD.ACCOUNT_CONTROL_ID, BD.ACCOUNT_CODE      
                     , BD.CURRENCY_CODE
                     , DECODE(AC.ACCOUNT_DR_CR, '1', BD.DR_SUM - BD.CR_SUM, 0) AS DR_SUM
                     , DECODE(AC.ACCOUNT_DR_CR, '2', BD.CR_SUM - BD.DR_SUM, 0) AS CR_SUM 
                     , DECODE(AC.ACCOUNT_DR_CR, '1', BD.DR_CURR_SUM - BD.CR_CURR_SUM, 0) AS DR_CURR_SUM
                     , DECODE(AC.ACCOUNT_DR_CR, '2', BD.CR_CURR_SUM - BD.DR_CURR_SUM, 0) AS CR_CURR_SUM           
                  FROM ( SELECT CBD.SOB_ID
                              , CBD.CUSTOMER_ID
                              , CBD.ACCOUNT_BOOK_ID
                              , CBD.ACCOUNT_CONTROL_ID
                              , CBD.ACCOUNT_CODE
                              , CBD.CURRENCY_CODE
                              , SUM(CBD.DR_AMOUNT) AS DR_SUM
                              , SUM(CBD.CR_AMOUNT) AS CR_SUM
                              , SUM(CBD.DR_CURR_AMOUNT) AS DR_CURR_SUM
                              , SUM(CBD.CR_CURR_AMOUNT) AS CR_CURR_SUM
                           FROM  FI_CUSTOMER_BALANCE_DAILY CBD
                          WHERE  CBD.GL_DATE    BETWEEN V_FIRST_DATE AND V_LAST_DATE
                            AND  CBD.SOB_ID     = P_SOB_ID
                          GROUP  BY CBD.SOB_ID
                              , CBD.CUSTOMER_ID
                              , CBD.ACCOUNT_BOOK_ID
                              , CBD.ACCOUNT_CONTROL_ID
                              , CBD.ACCOUNT_CODE
                              , CBD.CURRENCY_CODE
                       ) BD,
                       FI_ACCOUNT_CONTROL    AC
                WHERE ( BD.DR_SUM  != 0
                       OR BD.CR_SUM  != 0
                       OR BD.DR_CURR_SUM != 0
                       OR BD.CR_CURR_SUM != 0 )
                  AND BD.ACCOUNT_CONTROL_ID  = AC.ACCOUNT_CONTROL_ID
                  AND BD.SOB_ID              = P_SOB_ID         
                )
    LOOP 
      BEGIN
        INSERT INTO FI_CUSTOMER_BALANCE_DAILY
             (  GL_DATE             , GL_DATE_SEQ
              , SOB_ID              , ORG_ID
              , CUSTOMER_ID         , ACCOUNT_BOOK_ID
              , PERIOD_NAME
              , ACCOUNT_CONTROL_ID  , ACCOUNT_CODE        
              , CURRENCY_CODE       
              , DR_AMOUNT           , CR_AMOUNT
              , DR_CURR_AMOUNT      , CR_CURR_AMOUNT
              , CREATION_DATE       , CREATED_BY
              , LAST_UPDATE_DATE    , LAST_UPDATED_BY)              
        VALUES
             ( V_N_FIRST_DATE       , 0
             , P_SOB_ID             , P_ORG_ID
             , C1.CUSTOMER_ID       , C1.ACCOUNT_BOOK_ID
             , V_N_PERIOD_NAME
             , C1.ACCOUNT_CONTROL_ID, C1.ACCOUNT_CODE
             , C1.CURRENCY_CODE
             , C1.DR_SUM            , C1.CR_SUM
             , C1.DR_CURR_SUM       , C1.CR_CURR_SUM
             , V_SYSDATE            , P_USER_ID
             , V_SYSDATE            , P_USER_ID
             );
      EXCEPTION WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(C1.CUSTOMER_ID || ', ' || C1.ACCOUNT_CONTROL_ID || ', ' || C1.CURRENCY_CODE);
        V_MESSAGE := '2.Daily Customer Balance Daily Insert : ' || SUBSTR(SQLERRM, 1, 200);
        RAISE E_INSERT_ERR;
      END;
    END LOOP C1;
    /* -- jhs 수정 : pk 오류 발생.
    BEGIN
      INSERT INTO FI_CUSTOMER_BALANCE_DAILY
           (  GL_DATE             , GL_DATE_SEQ
            , SOB_ID              , ORG_ID
            , CUSTOMER_ID         , ACCOUNT_BOOK_ID
            , PERIOD_NAME
            , ACCOUNT_CONTROL_ID  , ACCOUNT_CODE        
            , CURRENCY_CODE       
            , DR_AMOUNT           , CR_AMOUNT
            , DR_CURR_AMOUNT      , CR_CURR_AMOUNT
            , CREATION_DATE       , CREATED_BY
            , LAST_UPDATE_DATE    , LAST_UPDATED_BY)              
      SELECT V_N_FIRST_DATE       , 0
           , P_SOB_ID             , P_ORG_ID
           , BD.CUSTOMER_ID       , BD.ACCOUNT_BOOK_ID
           , V_N_PERIOD_NAME           
           , BD.ACCOUNT_CONTROL_ID, BD.ACCOUNT_CODE      
           , BD.CURRENCY_CODE
           , DECODE(AC.ACCOUNT_DR_CR, '1', BD.DR_SUM - BD.CR_SUM, 0) AS DR_SUM
           , DECODE(AC.ACCOUNT_DR_CR, '2', BD.CR_SUM - BD.DR_SUM, 0) AS CR_SUM 
           , DECODE(AC.ACCOUNT_DR_CR, '1', BD.DR_CURR_SUM - BD.CR_CURR_SUM, 0) AS DR_CURR_SUM
           , DECODE(AC.ACCOUNT_DR_CR, '2', BD.CR_CURR_SUM - BD.DR_CURR_SUM, 0) AS CR_CURR_SUM           
           , V_SYSDATE,  P_USER_ID,  V_SYSDATE,  P_USER_ID               
        FROM ( SELECT CBD.SOB_ID
                    , CBD.CUSTOMER_ID
                    , CBD.ACCOUNT_BOOK_ID
                    , CBD.ACCOUNT_CONTROL_ID
                    , CBD.ACCOUNT_CODE
                    , CBD.CURRENCY_CODE
                    , SUM(CBD.DR_AMOUNT) AS DR_SUM
                    , SUM(CBD.CR_AMOUNT) AS CR_SUM
                    , SUM(CBD.DR_CURR_AMOUNT) AS DR_CURR_SUM
                    , SUM(CBD.CR_CURR_AMOUNT) AS CR_CURR_SUM
                 FROM  FI_CUSTOMER_BALANCE_DAILY CBD
                WHERE  CBD.GL_DATE    BETWEEN V_FIRST_DATE AND V_LAST_DATE
                  AND  CBD.SOB_ID     = P_SOB_ID
                GROUP  BY CBD.SOB_ID
                    , CBD.CUSTOMER_ID
                    , CBD.ACCOUNT_BOOK_ID
                    , CBD.ACCOUNT_CONTROL_ID
                    , CBD.ACCOUNT_CODE
                    , CBD.CURRENCY_CODE
             ) BD,
             FI_ACCOUNT_CONTROL    AC
      WHERE ( BD.DR_SUM  != 0
             OR BD.CR_SUM  != 0
             OR BD.DR_CURR_SUM != 0
             OR BD.CR_CURR_SUM != 0 )
         AND BD.ACCOUNT_CONTROL_ID  = AC.ACCOUNT_CONTROL_ID
         AND BD.SOB_ID              = P_SOB_ID         
      ;
    EXCEPTION WHEN OTHERS THEN
      V_MESSAGE := '2.Daily Customer Balance Daily Insert : ' || SUBSTR(SQLERRM, 1, 200);
      RAISE E_INSERT_ERR;
    END;*/
    -- 금액 0 인것 삭제.
    BEGIN
      DELETE FROM FI_CUSTOMER_BALANCE_DAILY CBD
      WHERE CBD.GL_DATE         = V_N_FIRST_DATE
        AND CBD.GL_DATE_SEQ     = 0
        AND CBD.SOB_ID          = P_SOB_ID 
        AND CBD.DR_AMOUNT       = 0
        AND CBD.CR_AMOUNT       = 0
        AND CBD.DR_CURR_AMOUNT  = 0
        AND CBD.CR_CURR_AMOUNT  = 0
      ;
    EXCEPTION WHEN OTHERS THEN
      V_MESSAGE := '2.Daily Customer Balance Daily Delete : ' || SUBSTR(SQLERRM, 1, 200);
      RAISE E_DELETE_ERR;
    END;
    ---------------------------------------------------------------------------
    -- 14) 월별 거래처별 잔액 테이블 >> 저장 전 삭제
    FOR C1 IN ( SELECT FCB.SOB_ID                 , FCB.CUSTOMER_ID
                     , FCB.ACCOUNT_BOOK_ID        , FCB.ACCOUNT_CONTROL_ID
                     , FCB.ACCOUNT_CODE           , FAC.ACCOUNT_DR_CR
                     , FCB.CURRENCY_CODE          
                     , FCB.MANAGEMENT1            , FCB.MANAGEMENT2
                     , SUM(DECODE(FAC.ACCOUNT_DR_CR,'1', (FCB.PRE_DR_AMOUNT + FCB.THIS_DR_AMOUNT) - (FCB.PRE_CR_AMOUNT + FCB.THIS_CR_AMOUNT))) AS DR_REMAIN
                     , SUM(DECODE(FAC.ACCOUNT_DR_CR,'2', (FCB.PRE_CR_AMOUNT + FCB.THIS_CR_AMOUNT) - (FCB.PRE_DR_AMOUNT + FCB.THIS_DR_AMOUNT))) AS CR_REMAIN
                     , SUM(DECODE(FAC.ACCOUNT_DR_CR,'1', (FCB.PRE_DR_CURR_AMOUNT + FCB.THIS_DR_CURR_AMOUNT) - (FCB.PRE_CR_CURR_AMOUNT + FCB.THIS_CR_CURR_AMOUNT))) AS DR_CURR_REMAIN
                     , SUM(DECODE(FAC.ACCOUNT_DR_CR,'2', (FCB.PRE_CR_CURR_AMOUNT + FCB.THIS_CR_CURR_AMOUNT) - (FCB.PRE_DR_CURR_AMOUNT + FCB.THIS_DR_CURR_AMOUNT))) AS CR_CURR_REMAIN
                  FROM FI_CUSTOMER_BALANCE   FCB
                     , FI_ACCOUNT_CONTROL    FAC
                 WHERE FAC.ACCOUNT_CONTROL_ID = FCB.ACCOUNT_CONTROL_ID
                   AND FAC.SOB_ID             = FCB.SOB_ID
                   AND FCB.PERIOD_NAME        = P_PERIOD_NAME
                   AND FCB.SOB_ID             = P_SOB_ID
                 GROUP BY FCB.SOB_ID                 , FCB.CUSTOMER_ID
                     , FCB.ACCOUNT_BOOK_ID        , FCB.ACCOUNT_CONTROL_ID
                     , FCB.ACCOUNT_CODE           , FAC.ACCOUNT_DR_CR
                     , FCB.CURRENCY_CODE          
                     , FCB.MANAGEMENT1            , FCB.MANAGEMENT2
              )
    LOOP
      IF NVL(C1.DR_REMAIN, 0) = 0 AND NVL(C1.CR_REMAIN, 0) = 0 AND NVL(C1.DR_CURR_REMAIN, 0) = 0 AND NVL(C1.CR_CURR_REMAIN, 0) = 0 THEN
        NULL;
      ELSE
        UPDATE FI_CUSTOMER_BALANCE
          SET PRE_DR_AMOUNT      = NVL(C1.DR_REMAIN, 0)
            , PRE_CR_AMOUNT      = NVL(C1.CR_REMAIN, 0)
            , PRE_DR_CURR_AMOUNT = NVL(C1.DR_CURR_REMAIN, 0)
            , PRE_CR_CURR_AMOUNT = NVL(C1.CR_CURR_REMAIN, 0)                             
        WHERE PERIOD_NAME         = V_N_PERIOD_NAME
          AND SOB_ID              = P_SOB_ID
          AND CUSTOMER_ID         = C1.CUSTOMER_ID
          AND ACCOUNT_CONTROL_ID  = C1.ACCOUNT_CONTROL_ID
          AND CURRENCY_CODE       = C1.CURRENCY_CODE     
        ;
        IF SQL%ROWCOUNT = 0 THEN
          BEGIN
            INSERT INTO FI_CUSTOMER_BALANCE
            ( PERIOD_NAME         
            , SOB_ID              , ORG_ID            
            , CUSTOMER_ID         , ACCOUNT_BOOK_ID
            , ACCOUNT_CONTROL_ID  , ACCOUNT_CODE
            , CURRENCY_CODE       
            , MANAGEMENT1         , MANAGEMENT2
            , PRE_DR_AMOUNT       , PRE_CR_AMOUNT
            , PRE_DR_CURR_AMOUNT  , PRE_CR_CURR_AMOUNT
            , CREATION_DATE       , CREATED_BY
            , LAST_UPDATE_DATE    , LAST_UPDATED_BY
            ) VALUES 
            ( V_N_PERIOD_NAME       
            , P_SOB_ID            , P_ORG_ID
            , C1.CUSTOMER_ID      , C1.ACCOUNT_BOOK_ID
            , C1.ACCOUNT_CONTROL_ID , C1.ACCOUNT_CODE
            , C1.CURRENCY_CODE
            , C1.MANAGEMENT1      , C1.MANAGEMENT2
            , C1.DR_REMAIN        , C1.CR_REMAIN
            , C1.DR_CURR_REMAIN   , C1.CR_CURR_REMAIN
            , V_SYSDATE           , P_USER_ID
            , V_SYSDATE           , P_USER_ID
            );              
          EXCEPTION WHEN DUP_VAL_ON_INDEX THEN
            V_MESSAGE := 'Customer Balance Insert Error : ' || SUBSTR(SQLERRM, 1, 200);
            RAISE E_INSERT_ERR;
          END;
        END IF;      
      END IF;
    
    END LOOP C1;
    
    ---------------------------------------------------------------------------
    -- 15) 일별 계정별 관리항목별 잔액 테이블 >> 저장 전 삭제
    BEGIN
      DELETE FROM FI_MANAGEMENT_BALANCE MB
      WHERE MB.GL_DATE      =  V_N_FIRST_DATE
        AND MB.GL_DATE_SEQ  =  0
        AND MB.SOB_ID       =  P_SOB_ID 
      ;
    EXCEPTION WHEN OTHERS THEN
      V_MESSAGE := '5.Management Balance Delete : ' || SUBSTR(SQLERRM, 1, 200);
      RAISE E_DELETE_ERR;
    END;
    BEGIN
      INSERT INTO FI_MANAGEMENT_BALANCE MB
           (  GL_DATE             , GL_DATE_SEQ
            , SOB_ID              , ORG_ID
            , ACCOUNT_CONTROL_ID  
            , MANAGEMENT_ID       , MANAGEMENT_VALUE
            , DR_SUM              , CR_SUM
            , CURRENCY_CODE       , EXCHANGE_RATE
            , DR_CURR_SUM         , CR_CURR_SUM
            , ACCOUNT_CODE        , MANAGEMENT_CODE
            , CREATION_DATE       , CREATED_BY
            , LAST_UPDATE_DATE    , LAST_UPDATED_BY)              
      SELECT V_N_FIRST_DATE       , 0
           , P_SOB_ID             , P_ORG_ID
           , BD.ACCOUNT_CONTROL_ID
           , BD.MANAGEMENT_ID     , MANAGEMENT_VALUE                 
           , DECODE(AC.ACCOUNT_DR_CR, '1', BD.DR_SUM - BD.CR_SUM, 0) AS DR_SUM
           , DECODE(AC.ACCOUNT_DR_CR, '2', BD.CR_SUM - BD.DR_SUM, 0) AS CR_SUM 
           , BD.CURRENCY_CODE     , BD.EXCHANGE_RATE
           , DECODE(AC.ACCOUNT_DR_CR, '1', BD.DR_CURR_SUM - BD.CR_CURR_SUM, 0) AS DR_CURR_SUM
           , DECODE(AC.ACCOUNT_DR_CR, '2', BD.CR_CURR_SUM - BD.DR_CURR_SUM, 0) AS CR_CURR_SUM
           /* -- 전호수 수정.
           , DECODE(SIGN(DECODE(AC.ACCOUNT_DR_CR, '1', BD.DR_SUM - BD.CR_SUM,   BD.CR_SUM - BD.DR_SUM)), 1,
                         DECODE(AC.ACCOUNT_DR_CR, '1', BD.DR_SUM - BD.CR_SUM,   BD.CR_SUM - BD.DR_SUM), 0) AS DR_SUM
           , DECODE(SIGN(DECODE(AC.ACCOUNT_DR_CR, '1', BD.DR_SUM - BD.CR_SUM,   BD.CR_SUM - BD.DR_SUM)), -1,
                         DECODE(AC.ACCOUNT_DR_CR, '1', BD.DR_SUM - BD.CR_SUM,   BD.CR_SUM - BD.DR_SUM) * -1, 0) AS CR_SUM 
           , BD.CURRENCY_CODE     , BD.EXCHANGE_RATE
           , DECODE(SIGN(DECODE(AC.ACCOUNT_DR_CR, '1', BD.DR_CURR_SUM - BD.CR_CURR_SUM, BD.CR_CURR_SUM - BD.DR_CURR_SUM)), 1,
                         DECODE(AC.ACCOUNT_DR_CR, '1', BD.DR_CURR_SUM - BD.CR_CURR_SUM, BD.CR_CURR_SUM - BD.DR_CURR_SUM), 0) AS DR_CURR_SUM
           , DECODE(SIGN(DECODE(AC.ACCOUNT_DR_CR, '1', BD.DR_CURR_SUM - BD.CR_CURR_SUM, BD.CR_CURR_SUM - BD.DR_CURR_SUM)), -1,
                         DECODE(AC.ACCOUNT_DR_CR, '1', BD.DR_CURR_SUM - BD.CR_CURR_SUM, BD.CR_CURR_SUM - BD.DR_CURR_SUM) * -1, 0) AS CR_CURR_SUM*/
           , BD.ACCOUNT_CODE      , BD.MANAGEMENT_CODE
           , V_SYSDATE,  P_USER_ID,  V_SYSDATE,  P_USER_ID               
        FROM ( SELECT MB.SOB_ID
                    , MB.ACCOUNT_CONTROL_ID
                    , MB.MANAGEMENT_ID
                    , MB.MANAGEMENT_VALUE
                    , MB.MANAGEMENT_CODE
                    , MB.ACCOUNT_CODE
                    , MB.CURRENCY_CODE
                    , MAX(MB.EXCHANGE_RATE) AS EXCHANGE_RATE
                    , SUM(MB.DR_SUM) AS DR_SUM
                    , SUM(MB.CR_SUM) AS CR_SUM
                    , SUM(MB.DR_CURR_SUM) AS DR_CURR_SUM
                    , SUM(MB.CR_CURR_SUM) AS CR_CURR_SUM
                 FROM  FI_MANAGEMENT_BALANCE MB
                WHERE  MB.GL_DATE     BETWEEN V_FIRST_DATE AND V_LAST_DATE
                  AND  MB.SOB_ID      = P_SOB_ID
                GROUP  BY MB.SOB_ID
                    , MB.ACCOUNT_CONTROL_ID
                    , MB.MANAGEMENT_ID
                    , MB.MANAGEMENT_VALUE
                    , MB.MANAGEMENT_CODE
                    , MB.ACCOUNT_CODE
                    , MB.CURRENCY_CODE
             ) BD,
             FI_ACCOUNT_CONTROL    AC
      WHERE ( BD.DR_SUM  != 0
             OR BD.CR_SUM  != 0
             OR BD.DR_CURR_SUM != 0
             OR BD.CR_CURR_SUM != 0 )
         AND BD.ACCOUNT_CONTROL_ID  = AC.ACCOUNT_CONTROL_ID
         AND BD.SOB_ID              = P_SOB_ID         
      ;
    EXCEPTION WHEN OTHERS THEN
      V_MESSAGE := '5.Management Balance Insert : ' || SUBSTR(SQLERRM, 1, 200);
      RAISE E_INSERT_ERR;
    END;
    -- 금액 0 인것 삭제.
    BEGIN
      DELETE FROM FI_MANAGEMENT_BALANCE MB
      WHERE MB.GL_DATE          = V_N_FIRST_DATE
        AND MB.GL_DATE_SEQ      = 0
        AND MB.SOB_ID           = P_SOB_ID 
        AND MB.DR_SUM           = 0
        AND MB.CR_SUM           = 0
        AND MB.DR_CURR_SUM      = 0
        AND MB.CR_CURR_SUM      = 0
      ;
    EXCEPTION WHEN OTHERS THEN
      V_MESSAGE := '5.Management Balance Delete : ' || SUBSTR(SQLERRM, 1, 200);
      RAISE E_DELETE_ERR;
    END;
    -- 처리 완료.
    COMMIT;
    
    O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_10024', NULL);
  EXCEPTION 
    WHEN E_INSERT_ERR THEN 
      ROLLBACK;
      RAISE_APPLICATION_ERROR(-20001, V_MESSAGE);
    WHEN E_DELETE_ERR THEN 
      ROLLBACK;
      RAISE_APPLICATION_ERROR(-20001, V_MESSAGE);
  END MONTHLY_CLOSE;

END FI_MONTH_CLOSE_G;
/
