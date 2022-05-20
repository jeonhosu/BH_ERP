CREATE OR REPLACE PACKAGE FI_BALANCE_ACCOUNTS_G
AS

-- 계정잔액명세 계정 조회.
  PROCEDURE SELECT_ACCOUNTS
            ( P_CURSOR               OUT TYPES.TCURSOR
            , W_ACCOUNT_CONTROL_ID   IN FI_BALANCE_ACCOUNTS.ACCOUNT_CONTROL_ID%TYPE
            , W_ESTIMATE_YN          IN FI_BALANCE_ACCOUNTS.ESTIMATE_YN%TYPE
            , W_ENABLED_FLAG         IN FI_BALANCE_ACCOUNTS.ENABLED_FLAG%TYPE
            , W_SOB_ID               IN FI_BALANCE_ACCOUNTS.SOB_ID%TYPE
            );

-- 계정잔액명세 계정 삽입.
  PROCEDURE INSERT_ACCOUNTS
            ( P_ACCOUNT_CONTROL_ID  IN FI_BALANCE_ACCOUNTS.ACCOUNT_CONTROL_ID%TYPE
            , P_ACCOUNT_CODE        IN FI_BALANCE_ACCOUNTS.ACCOUNT_CODE%TYPE
            , P_SOB_ID              IN FI_BALANCE_ACCOUNTS.SOB_ID%TYPE
            , P_CONTROL_CURRENCY_YN IN FI_BALANCE_ACCOUNTS.CONTROL_CURRENCY_YN%TYPE
            , P_ESTIMATE_YN         IN FI_BALANCE_ACCOUNTS.ESTIMATE_YN%TYPE
            , P_DESCRIPTION         IN FI_BALANCE_ACCOUNTS.DESCRIPTION%TYPE
            , P_ENABLED_FLAG        IN FI_BALANCE_ACCOUNTS.ENABLED_FLAG%TYPE
            , P_EFFECTIVE_DATE_FR   IN FI_BALANCE_ACCOUNTS.EFFECTIVE_DATE_FR%TYPE
            , P_EFFECTIVE_DATE_TO   IN FI_BALANCE_ACCOUNTS.EFFECTIVE_DATE_TO%TYPE
            , P_MANAGEMENT1_ID      IN FI_BALANCE_ACCOUNTS_ITEM.MANAGEMENT_ID%TYPE
            , P_MANAGEMENT1_CODE    IN FI_BALANCE_ACCOUNTS_ITEM.MANAGEMENT_CODE%TYPE
            , P_BALANCE1_YN         IN FI_BALANCE_ACCOUNTS_ITEM.BALANCE_YN%TYPE
            , P_ENABLED1_FLAG       IN FI_BALANCE_ACCOUNTS_ITEM.ENABLED_FLAG%TYPE
            , P_MANAGEMENT2_ID      IN FI_BALANCE_ACCOUNTS_ITEM.MANAGEMENT_ID%TYPE
            , P_MANAGEMENT2_CODE    IN FI_BALANCE_ACCOUNTS_ITEM.MANAGEMENT_CODE%TYPE
            , P_BALANCE2_YN         IN FI_BALANCE_ACCOUNTS_ITEM.BALANCE_YN%TYPE
            , P_ENABLED2_FLAG       IN FI_BALANCE_ACCOUNTS_ITEM.ENABLED_FLAG%TYPE
            , P_MANAGEMENT3_ID      IN FI_BALANCE_ACCOUNTS_ITEM.MANAGEMENT_ID%TYPE
            , P_MANAGEMENT3_CODE    IN FI_BALANCE_ACCOUNTS_ITEM.MANAGEMENT_CODE%TYPE
            , P_BALANCE3_YN         IN FI_BALANCE_ACCOUNTS_ITEM.BALANCE_YN%TYPE
            , P_ENABLED3_FLAG       IN FI_BALANCE_ACCOUNTS_ITEM.ENABLED_FLAG%TYPE
            , P_MANAGEMENT4_ID      IN FI_BALANCE_ACCOUNTS_ITEM.MANAGEMENT_ID%TYPE
            , P_MANAGEMENT4_CODE    IN FI_BALANCE_ACCOUNTS_ITEM.MANAGEMENT_CODE%TYPE
            , P_BALANCE4_YN         IN FI_BALANCE_ACCOUNTS_ITEM.BALANCE_YN%TYPE
            , P_ENABLED4_FLAG       IN FI_BALANCE_ACCOUNTS_ITEM.ENABLED_FLAG%TYPE
            , P_MANAGEMENT5_ID      IN FI_BALANCE_ACCOUNTS_ITEM.MANAGEMENT_ID%TYPE
            , P_MANAGEMENT5_CODE    IN FI_BALANCE_ACCOUNTS_ITEM.MANAGEMENT_CODE%TYPE
            , P_BALANCE5_YN         IN FI_BALANCE_ACCOUNTS_ITEM.BALANCE_YN%TYPE
            , P_ENABLED5_FLAG       IN FI_BALANCE_ACCOUNTS_ITEM.ENABLED_FLAG%TYPE
            , P_MANAGEMENT6_ID      IN FI_BALANCE_ACCOUNTS_ITEM.MANAGEMENT_ID%TYPE
            , P_MANAGEMENT6_CODE    IN FI_BALANCE_ACCOUNTS_ITEM.MANAGEMENT_CODE%TYPE
            , P_BALANCE6_YN         IN FI_BALANCE_ACCOUNTS_ITEM.BALANCE_YN%TYPE
            , P_ENABLED6_FLAG       IN FI_BALANCE_ACCOUNTS_ITEM.ENABLED_FLAG%TYPE
            , P_MANAGEMENT7_ID      IN FI_BALANCE_ACCOUNTS_ITEM.MANAGEMENT_ID%TYPE
            , P_MANAGEMENT7_CODE    IN FI_BALANCE_ACCOUNTS_ITEM.MANAGEMENT_CODE%TYPE
            , P_BALANCE7_YN         IN FI_BALANCE_ACCOUNTS_ITEM.BALANCE_YN%TYPE
            , P_ENABLED7_FLAG       IN FI_BALANCE_ACCOUNTS_ITEM.ENABLED_FLAG%TYPE
            , P_MANAGEMENT8_ID      IN FI_BALANCE_ACCOUNTS_ITEM.MANAGEMENT_ID%TYPE
            , P_MANAGEMENT8_CODE    IN FI_BALANCE_ACCOUNTS_ITEM.MANAGEMENT_CODE%TYPE
            , P_BALANCE8_YN         IN FI_BALANCE_ACCOUNTS_ITEM.BALANCE_YN%TYPE
            , P_ENABLED8_FLAG       IN FI_BALANCE_ACCOUNTS_ITEM.ENABLED_FLAG%TYPE
            , P_MANAGEMENT9_ID      IN FI_BALANCE_ACCOUNTS_ITEM.MANAGEMENT_ID%TYPE
            , P_MANAGEMENT9_CODE    IN FI_BALANCE_ACCOUNTS_ITEM.MANAGEMENT_CODE%TYPE
            , P_BALANCE9_YN         IN FI_BALANCE_ACCOUNTS_ITEM.BALANCE_YN%TYPE
            , P_ENABLED9_FLAG       IN FI_BALANCE_ACCOUNTS_ITEM.ENABLED_FLAG%TYPE
            , P_MANAGEMENT10_ID     IN FI_BALANCE_ACCOUNTS_ITEM.MANAGEMENT_ID%TYPE
            , P_MANAGEMENT10_CODE   IN FI_BALANCE_ACCOUNTS_ITEM.MANAGEMENT_CODE%TYPE
            , P_BALANCE10_YN        IN FI_BALANCE_ACCOUNTS_ITEM.BALANCE_YN%TYPE
            , P_ENABLED10_FLAG      IN FI_BALANCE_ACCOUNTS_ITEM.ENABLED_FLAG%TYPE
            , P_USER_ID             IN FI_BALANCE_ACCOUNTS.CREATED_BY%TYPE 
            );
                       
-- 계정잔액명세 계정 수정.
  PROCEDURE UPDATE_ACCOUNTS
            ( W_ACCOUNT_CONTROL_ID  IN FI_BALANCE_ACCOUNTS.ACCOUNT_CONTROL_ID%TYPE
            , W_ACCOUNT_CODE        IN FI_BALANCE_ACCOUNTS.ACCOUNT_CODE%TYPE
            , W_SOB_ID              IN FI_BALANCE_ACCOUNTS.SOB_ID%TYPE
            , P_CONTROL_CURRENCY_YN IN FI_BALANCE_ACCOUNTS.CONTROL_CURRENCY_YN%TYPE
            , P_ESTIMATE_YN         IN FI_BALANCE_ACCOUNTS.ESTIMATE_YN%TYPE
            , P_DESCRIPTION         IN FI_BALANCE_ACCOUNTS.DESCRIPTION%TYPE
            , P_ENABLED_FLAG        IN FI_BALANCE_ACCOUNTS.ENABLED_FLAG%TYPE
            , P_EFFECTIVE_DATE_FR   IN FI_BALANCE_ACCOUNTS.EFFECTIVE_DATE_FR%TYPE
            , P_EFFECTIVE_DATE_TO   IN FI_BALANCE_ACCOUNTS.EFFECTIVE_DATE_TO%TYPE
            , P_MANAGEMENT1_ID      IN FI_BALANCE_ACCOUNTS_ITEM.MANAGEMENT_ID%TYPE
            , P_MANAGEMENT1_CODE    IN FI_BALANCE_ACCOUNTS_ITEM.MANAGEMENT_CODE%TYPE
            , P_BALANCE1_YN         IN FI_BALANCE_ACCOUNTS_ITEM.BALANCE_YN%TYPE
            , P_ENABLED1_FLAG       IN FI_BALANCE_ACCOUNTS_ITEM.ENABLED_FLAG%TYPE
            , P_MANAGEMENT2_ID      IN FI_BALANCE_ACCOUNTS_ITEM.MANAGEMENT_ID%TYPE
            , P_MANAGEMENT2_CODE    IN FI_BALANCE_ACCOUNTS_ITEM.MANAGEMENT_CODE%TYPE
            , P_BALANCE2_YN         IN FI_BALANCE_ACCOUNTS_ITEM.BALANCE_YN%TYPE
            , P_ENABLED2_FLAG       IN FI_BALANCE_ACCOUNTS_ITEM.ENABLED_FLAG%TYPE
            , P_MANAGEMENT3_ID      IN FI_BALANCE_ACCOUNTS_ITEM.MANAGEMENT_ID%TYPE
            , P_MANAGEMENT3_CODE    IN FI_BALANCE_ACCOUNTS_ITEM.MANAGEMENT_CODE%TYPE
            , P_BALANCE3_YN         IN FI_BALANCE_ACCOUNTS_ITEM.BALANCE_YN%TYPE
            , P_ENABLED3_FLAG       IN FI_BALANCE_ACCOUNTS_ITEM.ENABLED_FLAG%TYPE
            , P_MANAGEMENT4_ID      IN FI_BALANCE_ACCOUNTS_ITEM.MANAGEMENT_ID%TYPE
            , P_MANAGEMENT4_CODE    IN FI_BALANCE_ACCOUNTS_ITEM.MANAGEMENT_CODE%TYPE
            , P_BALANCE4_YN         IN FI_BALANCE_ACCOUNTS_ITEM.BALANCE_YN%TYPE
            , P_ENABLED4_FLAG       IN FI_BALANCE_ACCOUNTS_ITEM.ENABLED_FLAG%TYPE
            , P_MANAGEMENT5_ID      IN FI_BALANCE_ACCOUNTS_ITEM.MANAGEMENT_ID%TYPE
            , P_MANAGEMENT5_CODE    IN FI_BALANCE_ACCOUNTS_ITEM.MANAGEMENT_CODE%TYPE
            , P_BALANCE5_YN         IN FI_BALANCE_ACCOUNTS_ITEM.BALANCE_YN%TYPE
            , P_ENABLED5_FLAG       IN FI_BALANCE_ACCOUNTS_ITEM.ENABLED_FLAG%TYPE
            , P_MANAGEMENT6_ID      IN FI_BALANCE_ACCOUNTS_ITEM.MANAGEMENT_ID%TYPE
            , P_MANAGEMENT6_CODE    IN FI_BALANCE_ACCOUNTS_ITEM.MANAGEMENT_CODE%TYPE
            , P_BALANCE6_YN         IN FI_BALANCE_ACCOUNTS_ITEM.BALANCE_YN%TYPE
            , P_ENABLED6_FLAG       IN FI_BALANCE_ACCOUNTS_ITEM.ENABLED_FLAG%TYPE
            , P_MANAGEMENT7_ID      IN FI_BALANCE_ACCOUNTS_ITEM.MANAGEMENT_ID%TYPE
            , P_MANAGEMENT7_CODE    IN FI_BALANCE_ACCOUNTS_ITEM.MANAGEMENT_CODE%TYPE
            , P_BALANCE7_YN         IN FI_BALANCE_ACCOUNTS_ITEM.BALANCE_YN%TYPE
            , P_ENABLED7_FLAG       IN FI_BALANCE_ACCOUNTS_ITEM.ENABLED_FLAG%TYPE
            , P_MANAGEMENT8_ID      IN FI_BALANCE_ACCOUNTS_ITEM.MANAGEMENT_ID%TYPE
            , P_MANAGEMENT8_CODE    IN FI_BALANCE_ACCOUNTS_ITEM.MANAGEMENT_CODE%TYPE
            , P_BALANCE8_YN         IN FI_BALANCE_ACCOUNTS_ITEM.BALANCE_YN%TYPE
            , P_ENABLED8_FLAG       IN FI_BALANCE_ACCOUNTS_ITEM.ENABLED_FLAG%TYPE
            , P_MANAGEMENT9_ID      IN FI_BALANCE_ACCOUNTS_ITEM.MANAGEMENT_ID%TYPE
            , P_MANAGEMENT9_CODE    IN FI_BALANCE_ACCOUNTS_ITEM.MANAGEMENT_CODE%TYPE
            , P_BALANCE9_YN         IN FI_BALANCE_ACCOUNTS_ITEM.BALANCE_YN%TYPE
            , P_ENABLED9_FLAG       IN FI_BALANCE_ACCOUNTS_ITEM.ENABLED_FLAG%TYPE
            , P_MANAGEMENT10_ID     IN FI_BALANCE_ACCOUNTS_ITEM.MANAGEMENT_ID%TYPE
            , P_MANAGEMENT10_CODE   IN FI_BALANCE_ACCOUNTS_ITEM.MANAGEMENT_CODE%TYPE
            , P_BALANCE10_YN        IN FI_BALANCE_ACCOUNTS_ITEM.BALANCE_YN%TYPE
            , P_ENABLED10_FLAG      IN FI_BALANCE_ACCOUNTS_ITEM.ENABLED_FLAG%TYPE
            , P_USER_ID             IN FI_BALANCE_ACCOUNTS.CREATED_BY%TYPE 
            );

-----------------------------------------------------------------------------------------
-- 계정잔액명세 계정별 관리항목 삽입/저장.
  PROCEDURE SAVE_ACCOUNTS_ITEM
            ( P_ACCOUNT_CONTROL_ID  IN FI_BALANCE_ACCOUNTS_ITEM.ACCOUNT_CONTROL_ID%TYPE
            , P_ACCOUNT_CODE       	IN FI_BALANCE_ACCOUNTS_ITEM.ACCOUNT_CODE%TYPE
            , P_SOB_ID             	IN FI_BALANCE_ACCOUNTS_ITEM.SOB_ID%TYPE
            , P_MANAGEMENT_SEQ     	IN FI_BALANCE_ACCOUNTS_ITEM.MANAGEMENT_SEQ%TYPE
            , P_MANAGEMENT_ID      	IN FI_BALANCE_ACCOUNTS_ITEM.MANAGEMENT_ID%TYPE
            , P_MANAGEMENT_CODE    	IN FI_BALANCE_ACCOUNTS_ITEM.MANAGEMENT_CODE%TYPE
            , P_BALANCE_YN          IN FI_BALANCE_ACCOUNTS_ITEM.BALANCE_YN%TYPE
            , P_DESCRIPTION        	IN FI_BALANCE_ACCOUNTS_ITEM.DESCRIPTION%TYPE
            , P_ENABLED_FLAG       	IN FI_BALANCE_ACCOUNTS_ITEM.ENABLED_FLAG%TYPE
            , P_EFFECTIVE_DATE_FR  	IN FI_BALANCE_ACCOUNTS_ITEM.EFFECTIVE_DATE_FR%TYPE
            , P_EFFECTIVE_DATE_TO  	IN FI_BALANCE_ACCOUNTS_ITEM.EFFECTIVE_DATE_TO%TYPE
            , P_USER_ID            	IN FI_BALANCE_ACCOUNTS_ITEM.CREATED_BY%TYPE 
            );

-----------------------------------------------------------------------------------------
-- 계정잔액명세서 관리 계정.
  PROCEDURE LU_ACCOUNT_CODE_FR_TO
            ( P_CURSOR3              OUT TYPES.TCURSOR3
            , W_ACCOUNT_CODE_FR      IN FI_BALANCE_ACCOUNTS.ACCOUNT_CODE%TYPE
            , W_SOB_ID               IN FI_BALANCE_ACCOUNTS.SOB_ID%TYPE
            , W_ENABLED_YN           IN FI_BALANCE_ACCOUNTS.ENABLED_FLAG%TYPE
            );
            
END FI_BALANCE_ACCOUNTS_G;
/
CREATE OR REPLACE PACKAGE BODY FI_BALANCE_ACCOUNTS_G
AS
/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : FI_BALANCE_ACCOUNTS_G
/* Description  : 계정잔액명세 계정관리.
/*
/* Reference by :
/* Program History :
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
-- 계정잔액명세 계정 조회.
  PROCEDURE SELECT_ACCOUNTS
            ( P_CURSOR               OUT TYPES.TCURSOR
            , W_ACCOUNT_CONTROL_ID   IN FI_BALANCE_ACCOUNTS.ACCOUNT_CONTROL_ID%TYPE
            , W_ESTIMATE_YN          IN FI_BALANCE_ACCOUNTS.ESTIMATE_YN%TYPE
            , W_ENABLED_FLAG         IN FI_BALANCE_ACCOUNTS.ENABLED_FLAG%TYPE
            , W_SOB_ID               IN FI_BALANCE_ACCOUNTS.SOB_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR FOR
      SELECT BA.ACCOUNT_CONTROL_ID
           , BA.ACCOUNT_CODE
           , AC.ACCOUNT_DESC
           , BA.CONTROL_CURRENCY_YN
           , BA.ESTIMATE_YN
           , BA.DESCRIPTION
           , BA.ENABLED_FLAG
           , BA.EFFECTIVE_DATE_FR
           , BA.EFFECTIVE_DATE_TO
           , BAI.MANAGEMENT1_ID
           , BAI.MANAGEMENT1_CODE
           , BAI.MANAGEMENT1_DESC
           , NVL(BAI.BALANCE1_YN, 'N') AS BALANCE1_YN
           , NVL(BAI.ENABLED1_FLAG, 'N') AS ENABLED1_FLAG
           , BAI.MANAGEMENT2_ID
           , BAI.MANAGEMENT2_CODE
           , BAI.MANAGEMENT2_DESC
           , NVL(BAI.BALANCE2_YN, 'N') AS BALANCE2_YN
           , NVL(BAI.ENABLED2_FLAG, 'N') AS ENABLED2_FLAG
           , BAI.MANAGEMENT3_ID
           , BAI.MANAGEMENT3_CODE
           , BAI.MANAGEMENT3_DESC
           , NVL(BAI.BALANCE3_YN, 'N') AS BALANCE3_YN
           , NVL(BAI.ENABLED3_FLAG, 'N') AS ENABLED3_FLAG
           , BAI.MANAGEMENT4_ID
           , BAI.MANAGEMENT4_CODE
           , BAI.MANAGEMENT4_DESC
           , NVL(BAI.BALANCE4_YN, 'N') AS BALANCE4_YN
           , NVL(BAI.ENABLED4_FLAG, 'N') AS ENABLED4_FLAG
           , BAI.MANAGEMENT5_ID
           , BAI.MANAGEMENT5_CODE
           , BAI.MANAGEMENT5_DESC
           , NVL(BAI.BALANCE5_YN, 'N') AS BALANCE5_YN
           , NVL(BAI.ENABLED5_FLAG, 'N') AS ENABLED5_FLAG
           , BAI.MANAGEMENT6_ID
           , BAI.MANAGEMENT6_CODE
           , BAI.MANAGEMENT6_DESC
           , NVL(BAI.BALANCE6_YN, 'N') AS BALANCE6_YN
           , NVL(BAI.ENABLED6_FLAG, 'N') AS ENABLED6_FLAG
           , BAI.MANAGEMENT7_ID
           , BAI.MANAGEMENT7_CODE
           , BAI.MANAGEMENT7_DESC
           , NVL(BAI.BALANCE7_YN, 'N') AS BALANCE7_YN
           , NVL(BAI.ENABLED7_FLAG, 'N') AS ENABLED7_FLAG
           , BAI.MANAGEMENT8_ID
           , BAI.MANAGEMENT8_CODE
           , BAI.MANAGEMENT8_DESC
           , NVL(BAI.BALANCE8_YN, 'N') AS BALANCE8_YN
           , NVL(BAI.ENABLED8_FLAG, 'N') AS ENABLED8_FLAG
           , BAI.MANAGEMENT9_ID
           , BAI.MANAGEMENT9_CODE
           , BAI.MANAGEMENT9_DESC
           , NVL(BAI.BALANCE9_YN, 'N') AS BALANCE9_YN
           , NVL(BAI.ENABLED9_FLAG, 'N') AS ENABLED9_FLAG
           , BAI.MANAGEMENT10_ID
           , BAI.MANAGEMENT10_CODE
           , BAI.MANAGEMENT10_DESC
           , NVL(BAI.BALANCE10_YN, 'N') AS BALANCE10_YN
           , NVL(BAI.ENABLED10_FLAG, 'N') AS ENABLED10_FLAG
        FROM FI_BALANCE_ACCOUNTS BA
          , FI_ACCOUNT_CONTROL AC
          , FI_BALANCE_ACCOUNTS_ITEM_V BAI
       WHERE BA.ACCOUNT_CONTROL_ID  = AC.ACCOUNT_CONTROL_ID
         AND BA.ACCOUNT_CONTROL_ID  = BAI.ACCOUNT_CONTROL_ID(+)
         AND BA.SOB_ID              = BAI.SOB_ID(+)
         AND BA.ACCOUNT_CONTROL_ID  = NVL(W_ACCOUNT_CONTROL_ID, BA.ACCOUNT_CONTROL_ID)
         AND BA.ESTIMATE_YN         = DECODE(W_ESTIMATE_YN, 'Y', 'Y', BA.ESTIMATE_YN)
         AND BA.ENABLED_FLAG        = DECODE(W_ENABLED_FLAG, 'Y', 'Y', BA.ENABLED_FLAG)
         AND BA.SOB_ID              = W_SOB_ID
      ORDER BY BA.ACCOUNT_CODE
      ;
  END SELECT_ACCOUNTS;

-- 계정잔액명세 계정 삽입.
  PROCEDURE INSERT_ACCOUNTS
            ( P_ACCOUNT_CONTROL_ID  IN FI_BALANCE_ACCOUNTS.ACCOUNT_CONTROL_ID%TYPE
            , P_ACCOUNT_CODE        IN FI_BALANCE_ACCOUNTS.ACCOUNT_CODE%TYPE
            , P_SOB_ID              IN FI_BALANCE_ACCOUNTS.SOB_ID%TYPE
            , P_CONTROL_CURRENCY_YN IN FI_BALANCE_ACCOUNTS.CONTROL_CURRENCY_YN%TYPE
            , P_ESTIMATE_YN         IN FI_BALANCE_ACCOUNTS.ESTIMATE_YN%TYPE
            , P_DESCRIPTION         IN FI_BALANCE_ACCOUNTS.DESCRIPTION%TYPE
            , P_ENABLED_FLAG        IN FI_BALANCE_ACCOUNTS.ENABLED_FLAG%TYPE
            , P_EFFECTIVE_DATE_FR   IN FI_BALANCE_ACCOUNTS.EFFECTIVE_DATE_FR%TYPE
            , P_EFFECTIVE_DATE_TO   IN FI_BALANCE_ACCOUNTS.EFFECTIVE_DATE_TO%TYPE
            , P_MANAGEMENT1_ID      IN FI_BALANCE_ACCOUNTS_ITEM.MANAGEMENT_ID%TYPE
            , P_MANAGEMENT1_CODE    IN FI_BALANCE_ACCOUNTS_ITEM.MANAGEMENT_CODE%TYPE
            , P_BALANCE1_YN         IN FI_BALANCE_ACCOUNTS_ITEM.BALANCE_YN%TYPE
            , P_ENABLED1_FLAG       IN FI_BALANCE_ACCOUNTS_ITEM.ENABLED_FLAG%TYPE
            , P_MANAGEMENT2_ID      IN FI_BALANCE_ACCOUNTS_ITEM.MANAGEMENT_ID%TYPE
            , P_MANAGEMENT2_CODE    IN FI_BALANCE_ACCOUNTS_ITEM.MANAGEMENT_CODE%TYPE
            , P_BALANCE2_YN         IN FI_BALANCE_ACCOUNTS_ITEM.BALANCE_YN%TYPE
            , P_ENABLED2_FLAG       IN FI_BALANCE_ACCOUNTS_ITEM.ENABLED_FLAG%TYPE
            , P_MANAGEMENT3_ID      IN FI_BALANCE_ACCOUNTS_ITEM.MANAGEMENT_ID%TYPE
            , P_MANAGEMENT3_CODE    IN FI_BALANCE_ACCOUNTS_ITEM.MANAGEMENT_CODE%TYPE
            , P_BALANCE3_YN         IN FI_BALANCE_ACCOUNTS_ITEM.BALANCE_YN%TYPE
            , P_ENABLED3_FLAG       IN FI_BALANCE_ACCOUNTS_ITEM.ENABLED_FLAG%TYPE
            , P_MANAGEMENT4_ID      IN FI_BALANCE_ACCOUNTS_ITEM.MANAGEMENT_ID%TYPE
            , P_MANAGEMENT4_CODE    IN FI_BALANCE_ACCOUNTS_ITEM.MANAGEMENT_CODE%TYPE
            , P_BALANCE4_YN         IN FI_BALANCE_ACCOUNTS_ITEM.BALANCE_YN%TYPE
            , P_ENABLED4_FLAG       IN FI_BALANCE_ACCOUNTS_ITEM.ENABLED_FLAG%TYPE
            , P_MANAGEMENT5_ID      IN FI_BALANCE_ACCOUNTS_ITEM.MANAGEMENT_ID%TYPE
            , P_MANAGEMENT5_CODE    IN FI_BALANCE_ACCOUNTS_ITEM.MANAGEMENT_CODE%TYPE
            , P_BALANCE5_YN         IN FI_BALANCE_ACCOUNTS_ITEM.BALANCE_YN%TYPE
            , P_ENABLED5_FLAG       IN FI_BALANCE_ACCOUNTS_ITEM.ENABLED_FLAG%TYPE
            , P_MANAGEMENT6_ID      IN FI_BALANCE_ACCOUNTS_ITEM.MANAGEMENT_ID%TYPE
            , P_MANAGEMENT6_CODE    IN FI_BALANCE_ACCOUNTS_ITEM.MANAGEMENT_CODE%TYPE
            , P_BALANCE6_YN         IN FI_BALANCE_ACCOUNTS_ITEM.BALANCE_YN%TYPE
            , P_ENABLED6_FLAG       IN FI_BALANCE_ACCOUNTS_ITEM.ENABLED_FLAG%TYPE
            , P_MANAGEMENT7_ID      IN FI_BALANCE_ACCOUNTS_ITEM.MANAGEMENT_ID%TYPE
            , P_MANAGEMENT7_CODE    IN FI_BALANCE_ACCOUNTS_ITEM.MANAGEMENT_CODE%TYPE
            , P_BALANCE7_YN         IN FI_BALANCE_ACCOUNTS_ITEM.BALANCE_YN%TYPE
            , P_ENABLED7_FLAG       IN FI_BALANCE_ACCOUNTS_ITEM.ENABLED_FLAG%TYPE
            , P_MANAGEMENT8_ID      IN FI_BALANCE_ACCOUNTS_ITEM.MANAGEMENT_ID%TYPE
            , P_MANAGEMENT8_CODE    IN FI_BALANCE_ACCOUNTS_ITEM.MANAGEMENT_CODE%TYPE
            , P_BALANCE8_YN         IN FI_BALANCE_ACCOUNTS_ITEM.BALANCE_YN%TYPE
            , P_ENABLED8_FLAG       IN FI_BALANCE_ACCOUNTS_ITEM.ENABLED_FLAG%TYPE
            , P_MANAGEMENT9_ID      IN FI_BALANCE_ACCOUNTS_ITEM.MANAGEMENT_ID%TYPE
            , P_MANAGEMENT9_CODE    IN FI_BALANCE_ACCOUNTS_ITEM.MANAGEMENT_CODE%TYPE
            , P_BALANCE9_YN         IN FI_BALANCE_ACCOUNTS_ITEM.BALANCE_YN%TYPE
            , P_ENABLED9_FLAG       IN FI_BALANCE_ACCOUNTS_ITEM.ENABLED_FLAG%TYPE
            , P_MANAGEMENT10_ID     IN FI_BALANCE_ACCOUNTS_ITEM.MANAGEMENT_ID%TYPE
            , P_MANAGEMENT10_CODE   IN FI_BALANCE_ACCOUNTS_ITEM.MANAGEMENT_CODE%TYPE
            , P_BALANCE10_YN        IN FI_BALANCE_ACCOUNTS_ITEM.BALANCE_YN%TYPE
            , P_ENABLED10_FLAG      IN FI_BALANCE_ACCOUNTS_ITEM.ENABLED_FLAG%TYPE
            , P_USER_ID             IN FI_BALANCE_ACCOUNTS.CREATED_BY%TYPE 
            )
  AS
    V_SYSDATE                 DATE := GET_LOCAL_DATE(P_SOB_ID);
    V_MANAGEMENT_ID           NUMBER;
    V_MANAGEMENT_CODE         VARCHAR2(20);
    V_BALANCE_YN              VARCHAR2(1);
    V_ENABLED_FLAG            VARCHAR2(1);
    V_RECORD_COUNT            NUMBER := 0;
  BEGIN
    -- 동일한 코드 존재 체크.
    BEGIN
      SELECT COUNT(BA.ACCOUNT_CONTROL_ID) AS RECORD_COUNT
        INTO V_RECORD_COUNT
        FROM FI_BALANCE_ACCOUNTS BA
       WHERE BA.ACCOUNT_CONTROL_ID  = P_ACCOUNT_CONTROL_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_RECORD_COUNT := 0;
    END;
    IF V_RECORD_COUNT <> 0 THEN
      RAISE ERRNUMS.Exist_Data;
    END IF;

    INSERT INTO FI_BALANCE_ACCOUNTS
    ( ACCOUNT_CONTROL_ID
    , ACCOUNT_CODE 
    , SOB_ID 
    , CONTROL_CURRENCY_YN
    , ESTIMATE_YN 
    , DESCRIPTION 
    , ENABLED_FLAG 
    , EFFECTIVE_DATE_FR 
    , EFFECTIVE_DATE_TO 
    , CREATION_DATE 
    , CREATED_BY 
    , LAST_UPDATE_DATE 
    , LAST_UPDATED_BY )
    VALUES
    ( P_ACCOUNT_CONTROL_ID
    , P_ACCOUNT_CODE
    , P_SOB_ID
    , NVL(P_CONTROL_CURRENCY_YN, 'N')
    , NVL(P_ESTIMATE_YN, 'N')
    , P_DESCRIPTION
    , NVL(P_ENABLED_FLAG, 'N')
    , P_EFFECTIVE_DATE_FR
    , P_EFFECTIVE_DATE_TO
    , V_SYSDATE
    , P_USER_ID
    , V_SYSDATE
    , P_USER_ID );
    
    -- 계정관리항목 저장.--
    FOR C1 IN 1.. 10
    LOOP
      V_MANAGEMENT_ID     := NULL;
      V_MANAGEMENT_CODE   := NULL;
      V_ENABLED_FLAG      := 'N';
      BEGIN 
        SELECT CASE C1
                 WHEN 1 THEN P_MANAGEMENT1_ID
                 WHEN 2 THEN P_MANAGEMENT2_ID
                 WHEN 3 THEN P_MANAGEMENT3_ID
                 WHEN 4 THEN P_MANAGEMENT4_ID
                 WHEN 5 THEN P_MANAGEMENT5_ID
                 WHEN 6 THEN P_MANAGEMENT6_ID
                 WHEN 7 THEN P_MANAGEMENT7_ID
                 WHEN 8 THEN P_MANAGEMENT8_ID
                 WHEN 9 THEN P_MANAGEMENT9_ID
                 WHEN 10 THEN P_MANAGEMENT10_ID
               END AS MANAGEMENT_ID
             , CASE C1
                 WHEN 1 THEN P_MANAGEMENT1_CODE
                 WHEN 2 THEN P_MANAGEMENT2_CODE
                 WHEN 3 THEN P_MANAGEMENT3_CODE
                 WHEN 4 THEN P_MANAGEMENT4_CODE
                 WHEN 5 THEN P_MANAGEMENT5_CODE
                 WHEN 6 THEN P_MANAGEMENT6_CODE
                 WHEN 7 THEN P_MANAGEMENT7_CODE
                 WHEN 8 THEN P_MANAGEMENT8_CODE
                 WHEN 9 THEN P_MANAGEMENT9_CODE
                 WHEN 10 THEN P_MANAGEMENT10_CODE
               END AS MANAGEMENT_CODE
             , CASE C1
                 WHEN 1 THEN P_BALANCE1_YN
                 WHEN 2 THEN P_BALANCE2_YN
                 WHEN 3 THEN P_BALANCE3_YN
                 WHEN 4 THEN P_BALANCE4_YN
                 WHEN 5 THEN P_BALANCE5_YN
                 WHEN 6 THEN P_BALANCE6_YN
                 WHEN 7 THEN P_BALANCE7_YN
                 WHEN 8 THEN P_BALANCE8_YN
                 WHEN 9 THEN P_BALANCE9_YN
                 WHEN 10 THEN P_BALANCE10_YN
                 ELSE 'N'
               END AS BALANCE_YN
             , CASE C1
                 WHEN 1 THEN P_ENABLED1_FLAG
                 WHEN 2 THEN P_ENABLED2_FLAG
                 WHEN 3 THEN P_ENABLED3_FLAG
                 WHEN 4 THEN P_ENABLED4_FLAG
                 WHEN 5 THEN P_ENABLED5_FLAG
                 WHEN 6 THEN P_ENABLED6_FLAG
                 WHEN 7 THEN P_ENABLED7_FLAG
                 WHEN 8 THEN P_ENABLED8_FLAG
                 WHEN 9 THEN P_ENABLED9_FLAG
                 WHEN 10 THEN P_ENABLED10_FLAG
                 ELSE 'N'
               END AS ENABLED_FLAG
          INTO V_MANAGEMENT_ID, V_MANAGEMENT_CODE, V_BALANCE_YN, V_ENABLED_FLAG
          FROM DUAL
        ;
      EXCEPTION WHEN OTHERS THEN
        NULL;
      END;
      -- 기존 자료 삭제.
      DELETE FROM FI_BALANCE_ACCOUNTS_ITEM BAI
      WHERE BAI.ACCOUNT_CONTROL_ID  = P_ACCOUNT_CONTROL_ID
        AND BAI.SOB_ID              = P_SOB_ID
        AND BAI.MANAGEMENT_SEQ      = C1
      ;
      IF V_MANAGEMENT_ID IS NOT NULL THEN
      -- 계정 잔액관리항목 저장.
        SAVE_ACCOUNTS_ITEM
          ( P_ACCOUNT_CONTROL_ID => P_ACCOUNT_CONTROL_ID
          , P_ACCOUNT_CODE       => P_ACCOUNT_CODE
          , P_SOB_ID             => P_SOB_ID
          , P_MANAGEMENT_SEQ     => C1
          , P_MANAGEMENT_ID      => V_MANAGEMENT_ID
          , P_MANAGEMENT_CODE    => V_MANAGEMENT_CODE
          , P_BALANCE_YN         => NVL(V_BALANCE_YN, 'N')
          , P_DESCRIPTION        => P_DESCRIPTION
          , P_ENABLED_FLAG       => NVL(V_ENABLED_FLAG, 'N')
          , P_EFFECTIVE_DATE_FR  => P_EFFECTIVE_DATE_FR
          , P_EFFECTIVE_DATE_TO  => P_EFFECTIVE_DATE_TO
          , P_USER_ID            => P_USER_ID 
          );        
      END IF;
    END LOOP C1;
  EXCEPTION
    WHEN ERRNUMS.Exist_Data THEN
    RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_90003', '&&FIELD_NAME:=Account Code(계정코드)'));
  END INSERT_ACCOUNTS;

-- 계정잔액명세 계정 수정.
  PROCEDURE UPDATE_ACCOUNTS
            ( W_ACCOUNT_CONTROL_ID  IN FI_BALANCE_ACCOUNTS.ACCOUNT_CONTROL_ID%TYPE
            , W_ACCOUNT_CODE        IN FI_BALANCE_ACCOUNTS.ACCOUNT_CODE%TYPE
            , W_SOB_ID              IN FI_BALANCE_ACCOUNTS.SOB_ID%TYPE
            , P_CONTROL_CURRENCY_YN IN FI_BALANCE_ACCOUNTS.CONTROL_CURRENCY_YN%TYPE
            , P_ESTIMATE_YN         IN FI_BALANCE_ACCOUNTS.ESTIMATE_YN%TYPE
            , P_DESCRIPTION         IN FI_BALANCE_ACCOUNTS.DESCRIPTION%TYPE
            , P_ENABLED_FLAG        IN FI_BALANCE_ACCOUNTS.ENABLED_FLAG%TYPE
            , P_EFFECTIVE_DATE_FR   IN FI_BALANCE_ACCOUNTS.EFFECTIVE_DATE_FR%TYPE
            , P_EFFECTIVE_DATE_TO   IN FI_BALANCE_ACCOUNTS.EFFECTIVE_DATE_TO%TYPE
            , P_MANAGEMENT1_ID      IN FI_BALANCE_ACCOUNTS_ITEM.MANAGEMENT_ID%TYPE
            , P_MANAGEMENT1_CODE    IN FI_BALANCE_ACCOUNTS_ITEM.MANAGEMENT_CODE%TYPE
            , P_BALANCE1_YN         IN FI_BALANCE_ACCOUNTS_ITEM.BALANCE_YN%TYPE
            , P_ENABLED1_FLAG       IN FI_BALANCE_ACCOUNTS_ITEM.ENABLED_FLAG%TYPE
            , P_MANAGEMENT2_ID      IN FI_BALANCE_ACCOUNTS_ITEM.MANAGEMENT_ID%TYPE
            , P_MANAGEMENT2_CODE    IN FI_BALANCE_ACCOUNTS_ITEM.MANAGEMENT_CODE%TYPE
            , P_BALANCE2_YN         IN FI_BALANCE_ACCOUNTS_ITEM.BALANCE_YN%TYPE
            , P_ENABLED2_FLAG       IN FI_BALANCE_ACCOUNTS_ITEM.ENABLED_FLAG%TYPE
            , P_MANAGEMENT3_ID      IN FI_BALANCE_ACCOUNTS_ITEM.MANAGEMENT_ID%TYPE
            , P_MANAGEMENT3_CODE    IN FI_BALANCE_ACCOUNTS_ITEM.MANAGEMENT_CODE%TYPE
            , P_BALANCE3_YN         IN FI_BALANCE_ACCOUNTS_ITEM.BALANCE_YN%TYPE
            , P_ENABLED3_FLAG       IN FI_BALANCE_ACCOUNTS_ITEM.ENABLED_FLAG%TYPE
            , P_MANAGEMENT4_ID      IN FI_BALANCE_ACCOUNTS_ITEM.MANAGEMENT_ID%TYPE
            , P_MANAGEMENT4_CODE    IN FI_BALANCE_ACCOUNTS_ITEM.MANAGEMENT_CODE%TYPE
            , P_BALANCE4_YN         IN FI_BALANCE_ACCOUNTS_ITEM.BALANCE_YN%TYPE
            , P_ENABLED4_FLAG       IN FI_BALANCE_ACCOUNTS_ITEM.ENABLED_FLAG%TYPE
            , P_MANAGEMENT5_ID      IN FI_BALANCE_ACCOUNTS_ITEM.MANAGEMENT_ID%TYPE
            , P_MANAGEMENT5_CODE    IN FI_BALANCE_ACCOUNTS_ITEM.MANAGEMENT_CODE%TYPE
            , P_BALANCE5_YN         IN FI_BALANCE_ACCOUNTS_ITEM.BALANCE_YN%TYPE
            , P_ENABLED5_FLAG       IN FI_BALANCE_ACCOUNTS_ITEM.ENABLED_FLAG%TYPE
            , P_MANAGEMENT6_ID      IN FI_BALANCE_ACCOUNTS_ITEM.MANAGEMENT_ID%TYPE
            , P_MANAGEMENT6_CODE    IN FI_BALANCE_ACCOUNTS_ITEM.MANAGEMENT_CODE%TYPE
            , P_BALANCE6_YN         IN FI_BALANCE_ACCOUNTS_ITEM.BALANCE_YN%TYPE
            , P_ENABLED6_FLAG       IN FI_BALANCE_ACCOUNTS_ITEM.ENABLED_FLAG%TYPE
            , P_MANAGEMENT7_ID      IN FI_BALANCE_ACCOUNTS_ITEM.MANAGEMENT_ID%TYPE
            , P_MANAGEMENT7_CODE    IN FI_BALANCE_ACCOUNTS_ITEM.MANAGEMENT_CODE%TYPE
            , P_BALANCE7_YN         IN FI_BALANCE_ACCOUNTS_ITEM.BALANCE_YN%TYPE
            , P_ENABLED7_FLAG       IN FI_BALANCE_ACCOUNTS_ITEM.ENABLED_FLAG%TYPE
            , P_MANAGEMENT8_ID      IN FI_BALANCE_ACCOUNTS_ITEM.MANAGEMENT_ID%TYPE
            , P_MANAGEMENT8_CODE    IN FI_BALANCE_ACCOUNTS_ITEM.MANAGEMENT_CODE%TYPE
            , P_BALANCE8_YN         IN FI_BALANCE_ACCOUNTS_ITEM.BALANCE_YN%TYPE
            , P_ENABLED8_FLAG       IN FI_BALANCE_ACCOUNTS_ITEM.ENABLED_FLAG%TYPE
            , P_MANAGEMENT9_ID      IN FI_BALANCE_ACCOUNTS_ITEM.MANAGEMENT_ID%TYPE
            , P_MANAGEMENT9_CODE    IN FI_BALANCE_ACCOUNTS_ITEM.MANAGEMENT_CODE%TYPE
            , P_BALANCE9_YN         IN FI_BALANCE_ACCOUNTS_ITEM.BALANCE_YN%TYPE
            , P_ENABLED9_FLAG       IN FI_BALANCE_ACCOUNTS_ITEM.ENABLED_FLAG%TYPE
            , P_MANAGEMENT10_ID     IN FI_BALANCE_ACCOUNTS_ITEM.MANAGEMENT_ID%TYPE
            , P_MANAGEMENT10_CODE   IN FI_BALANCE_ACCOUNTS_ITEM.MANAGEMENT_CODE%TYPE
            , P_BALANCE10_YN        IN FI_BALANCE_ACCOUNTS_ITEM.BALANCE_YN%TYPE
            , P_ENABLED10_FLAG      IN FI_BALANCE_ACCOUNTS_ITEM.ENABLED_FLAG%TYPE
            , P_USER_ID             IN FI_BALANCE_ACCOUNTS.CREATED_BY%TYPE 
            )
  AS
    V_SYSDATE DATE := GET_LOCAL_DATE(W_SOB_ID);
    V_MANAGEMENT_ID           NUMBER;
    V_MANAGEMENT_CODE         VARCHAR2(20);
    V_BALANCE_YN              VARCHAR2(1);
    V_ENABLED_FLAG            VARCHAR2(1);
  BEGIN
    UPDATE FI_BALANCE_ACCOUNTS
      SET CONTROL_CURRENCY_YN = NVL(P_CONTROL_CURRENCY_YN, 'N')
        , ESTIMATE_YN         = NVL(P_ESTIMATE_YN, 'N')
        , DESCRIPTION         = P_DESCRIPTION
        , ENABLED_FLAG        = NVL(P_ENABLED_FLAG, 'N')
        , EFFECTIVE_DATE_FR   = P_EFFECTIVE_DATE_FR
        , EFFECTIVE_DATE_TO   = P_EFFECTIVE_DATE_TO
        , LAST_UPDATE_DATE    = V_SYSDATE
        , LAST_UPDATED_BY     = P_USER_ID
    WHERE ACCOUNT_CONTROL_ID  = W_ACCOUNT_CONTROL_ID
    ;
    
    -- 계정관리항목 저장.--
    FOR C1 IN 1.. 10
    LOOP
      V_MANAGEMENT_ID     := NULL;
      V_MANAGEMENT_CODE   := NULL;
      V_ENABLED_FLAG      := 'N';
      BEGIN 
        SELECT CASE C1
                 WHEN 1 THEN P_MANAGEMENT1_ID
                 WHEN 2 THEN P_MANAGEMENT2_ID
                 WHEN 3 THEN P_MANAGEMENT3_ID
                 WHEN 4 THEN P_MANAGEMENT4_ID
                 WHEN 5 THEN P_MANAGEMENT5_ID
                 WHEN 6 THEN P_MANAGEMENT6_ID
                 WHEN 7 THEN P_MANAGEMENT7_ID
                 WHEN 8 THEN P_MANAGEMENT8_ID
                 WHEN 9 THEN P_MANAGEMENT9_ID
                 WHEN 10 THEN P_MANAGEMENT10_ID
               END AS MANAGEMENT_ID
             , CASE C1
                 WHEN 1 THEN P_MANAGEMENT1_CODE
                 WHEN 2 THEN P_MANAGEMENT2_CODE
                 WHEN 3 THEN P_MANAGEMENT3_CODE
                 WHEN 4 THEN P_MANAGEMENT4_CODE
                 WHEN 5 THEN P_MANAGEMENT5_CODE
                 WHEN 6 THEN P_MANAGEMENT6_CODE
                 WHEN 7 THEN P_MANAGEMENT7_CODE
                 WHEN 8 THEN P_MANAGEMENT8_CODE
                 WHEN 9 THEN P_MANAGEMENT9_CODE
                 WHEN 10 THEN P_MANAGEMENT10_CODE
               END AS MANAGEMENT_CODE
             , CASE C1
                 WHEN 1 THEN P_BALANCE1_YN
                 WHEN 2 THEN P_BALANCE2_YN
                 WHEN 3 THEN P_BALANCE3_YN
                 WHEN 4 THEN P_BALANCE4_YN
                 WHEN 5 THEN P_BALANCE5_YN
                 WHEN 6 THEN P_BALANCE6_YN
                 WHEN 7 THEN P_BALANCE7_YN
                 WHEN 8 THEN P_BALANCE8_YN
                 WHEN 9 THEN P_BALANCE9_YN
                 WHEN 10 THEN P_BALANCE10_YN
                 ELSE 'N'
               END AS BALANCE_YN
             , CASE C1
                 WHEN 1 THEN P_ENABLED1_FLAG
                 WHEN 2 THEN P_ENABLED2_FLAG
                 WHEN 3 THEN P_ENABLED3_FLAG
                 WHEN 4 THEN P_ENABLED4_FLAG
                 WHEN 5 THEN P_ENABLED5_FLAG
                 WHEN 6 THEN P_ENABLED6_FLAG
                 WHEN 7 THEN P_ENABLED7_FLAG
                 WHEN 8 THEN P_ENABLED8_FLAG
                 WHEN 9 THEN P_ENABLED9_FLAG
                 WHEN 10 THEN P_ENABLED10_FLAG
                 ELSE 'N'
               END AS ENABLED_FLAG
          INTO V_MANAGEMENT_ID, V_MANAGEMENT_CODE, V_BALANCE_YN, V_ENABLED_FLAG
          FROM DUAL
        ;
      EXCEPTION WHEN OTHERS THEN
        NULL;
      END;
      -- 기존 자료 삭제.
      DELETE FROM FI_BALANCE_ACCOUNTS_ITEM BAI
      WHERE BAI.ACCOUNT_CONTROL_ID  = W_ACCOUNT_CONTROL_ID
        AND BAI.SOB_ID              = W_SOB_ID
        AND BAI.MANAGEMENT_SEQ      = C1
      ;
      IF V_MANAGEMENT_ID IS NOT NULL THEN
      -- 계정 잔액관리항목 저장.
        SAVE_ACCOUNTS_ITEM
          ( P_ACCOUNT_CONTROL_ID => W_ACCOUNT_CONTROL_ID
          , P_ACCOUNT_CODE       => W_ACCOUNT_CODE
          , P_SOB_ID             => W_SOB_ID
          , P_MANAGEMENT_SEQ     => C1
          , P_MANAGEMENT_ID      => V_MANAGEMENT_ID
          , P_MANAGEMENT_CODE    => V_MANAGEMENT_CODE
          , P_BALANCE_YN         => NVL(V_BALANCE_YN, 'N')
          , P_DESCRIPTION        => P_DESCRIPTION
          , P_ENABLED_FLAG       => NVL(V_ENABLED_FLAG, 'N')
          , P_EFFECTIVE_DATE_FR  => P_EFFECTIVE_DATE_FR
          , P_EFFECTIVE_DATE_TO  => P_EFFECTIVE_DATE_TO
          , P_USER_ID            => P_USER_ID 
          );        
      END IF;
    END LOOP C1;
  END UPDATE_ACCOUNTS;

-----------------------------------------------------------------------------------------
-- 계정잔액명세 계정별 관리항목 삽입/저장.
  PROCEDURE SAVE_ACCOUNTS_ITEM
            ( P_ACCOUNT_CONTROL_ID  IN FI_BALANCE_ACCOUNTS_ITEM.ACCOUNT_CONTROL_ID%TYPE
            , P_ACCOUNT_CODE       	IN FI_BALANCE_ACCOUNTS_ITEM.ACCOUNT_CODE%TYPE
            , P_SOB_ID             	IN FI_BALANCE_ACCOUNTS_ITEM.SOB_ID%TYPE
            , P_MANAGEMENT_SEQ     	IN FI_BALANCE_ACCOUNTS_ITEM.MANAGEMENT_SEQ%TYPE
            , P_MANAGEMENT_ID      	IN FI_BALANCE_ACCOUNTS_ITEM.MANAGEMENT_ID%TYPE
            , P_MANAGEMENT_CODE    	IN FI_BALANCE_ACCOUNTS_ITEM.MANAGEMENT_CODE%TYPE
            , P_BALANCE_YN          IN FI_BALANCE_ACCOUNTS_ITEM.BALANCE_YN%TYPE
            , P_DESCRIPTION        	IN FI_BALANCE_ACCOUNTS_ITEM.DESCRIPTION%TYPE
            , P_ENABLED_FLAG       	IN FI_BALANCE_ACCOUNTS_ITEM.ENABLED_FLAG%TYPE
            , P_EFFECTIVE_DATE_FR  	IN FI_BALANCE_ACCOUNTS_ITEM.EFFECTIVE_DATE_FR%TYPE
            , P_EFFECTIVE_DATE_TO  	IN FI_BALANCE_ACCOUNTS_ITEM.EFFECTIVE_DATE_TO%TYPE
            , P_USER_ID            	IN FI_BALANCE_ACCOUNTS_ITEM.CREATED_BY%TYPE 
            )
  AS
    V_SYSDATE DATE := GET_LOCAL_DATE(P_SOB_ID);
    V_RECORD_COUNT NUMBER := 0;
  BEGIN
    -- 동일한 계정에 대한 관리항목 존재 체크.
    BEGIN
      SELECT COUNT(BAI.MANAGEMENT_ID) AS RECORD_COUNT
        INTO V_RECORD_COUNT
        FROM FI_BALANCE_ACCOUNTS_ITEM BAI
       WHERE BAI.ACCOUNT_CONTROL_ID = P_ACCOUNT_CONTROL_ID
         AND BAI.SOB_ID             = P_SOB_ID
         AND BAI.MANAGEMENT_ID      = P_MANAGEMENT_ID         
      ;
    EXCEPTION WHEN OTHERS THEN
      V_RECORD_COUNT := 0;
    END;
    IF V_RECORD_COUNT <> 0 THEN
      RAISE ERRNUMS.Exist_Data;
    END IF;
    
    INSERT INTO FI_BALANCE_ACCOUNTS_ITEM
    ( ACCOUNT_CONTROL_ID
    , ACCOUNT_CODE 
    , SOB_ID 
    , MANAGEMENT_SEQ 
    , MANAGEMENT_ID 
    , MANAGEMENT_CODE 
    , BALANCE_YN
    , DESCRIPTION 
    , ENABLED_FLAG 
    , EFFECTIVE_DATE_FR 
    , EFFECTIVE_DATE_TO 
    , CREATION_DATE 
    , CREATED_BY 
    , LAST_UPDATE_DATE 
    , LAST_UPDATED_BY )
    VALUES
    ( P_ACCOUNT_CONTROL_ID
    , P_ACCOUNT_CODE
    , P_SOB_ID
    , P_MANAGEMENT_SEQ
    , P_MANAGEMENT_ID
    , P_MANAGEMENT_CODE
    , P_BALANCE_YN
    , P_DESCRIPTION
    , P_ENABLED_FLAG
    , P_EFFECTIVE_DATE_FR
    , P_EFFECTIVE_DATE_TO
    , V_SYSDATE
    , P_USER_ID
    , V_SYSDATE
    , P_USER_ID );
  EXCEPTION
    WHEN ERRNUMS.Exist_Data THEN
    RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_90003', '&&FIELD_NAME:=Management Item(관리항목)'));
  END SAVE_ACCOUNTS_ITEM;

-----------------------------------------------------------------------------------------
-- 계정잔액명세서 관리 계정.
  PROCEDURE LU_ACCOUNT_CODE_FR_TO
            ( P_CURSOR3              OUT TYPES.TCURSOR3
            , W_ACCOUNT_CODE_FR      IN FI_BALANCE_ACCOUNTS.ACCOUNT_CODE%TYPE
            , W_SOB_ID               IN FI_BALANCE_ACCOUNTS.SOB_ID%TYPE
            , W_ENABLED_YN           IN FI_BALANCE_ACCOUNTS.ENABLED_FLAG%TYPE
            )
  AS
    V_STD_DATE                       DATE := NULL;
  BEGIN
    IF W_ENABLED_YN = 'Y' THEN
      V_STD_DATE := GET_LOCAL_DATE(W_SOB_ID);
    END IF;

    OPEN P_CURSOR3 FOR
      SELECT BA.ACCOUNT_CODE
           , AC.ACCOUNT_DESC
           , BA.ACCOUNT_CONTROL_ID
           , BA.CONTROL_CURRENCY_YN
           , BA.ESTIMATE_YN
        FROM FI_ACCOUNT_CONTROL AC
          , FI_BALANCE_ACCOUNTS BA
       WHERE AC.ACCOUNT_CONTROL_ID      = BA.ACCOUNT_CONTROL_ID
         AND BA.ACCOUNT_CODE            >= NVL(W_ACCOUNT_CODE_FR, BA.ACCOUNT_CODE)
         AND BA.SOB_ID                  = W_SOB_ID
         AND BA.ENABLED_FLAG            = DECODE(W_ENABLED_YN, 'Y', 'Y', BA.ENABLED_FLAG)
         AND BA.EFFECTIVE_DATE_FR       <= NVL(V_STD_DATE, BA.EFFECTIVE_DATE_FR)
         AND (BA.EFFECTIVE_DATE_TO IS NULL OR BA.EFFECTIVE_DATE_TO >= NVL(V_STD_DATE, BA.EFFECTIVE_DATE_TO))
      ORDER BY BA.ACCOUNT_CODE
      ;
  END LU_ACCOUNT_CODE_FR_TO;
  
END FI_BALANCE_ACCOUNTS_G;
/
