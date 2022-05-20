CREATE OR REPLACE PACKAGE HRW_HOMETAX_INFO_G
AS

-- 홈택스 정보 조회.
  PROCEDURE SELECT_HOMETAX
            ( P_CURSOR            OUT TYPES.TCURSOR
            , P_CORP_ID           IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            );

-- 홈택스 정보 INSERT/UPDATE.
  PROCEDURE SAVE_HOMETAX
            ( P_CORP_ID      IN HRW_HOMETAX_INFO.CORP_ID%TYPE
            , P_SOB_ID       IN HRW_HOMETAX_INFO.SOB_ID%TYPE
            , P_ORG_ID       IN HRW_HOMETAX_INFO.ORG_ID%TYPE
            , P_HOMETAX_ID   IN HRW_HOMETAX_INFO.HOMETAX_ID%TYPE
            , P_ENCRYPT_PWD  IN HRW_HOMETAX_INFO.ENCRYPT_PWD%TYPE
            , P_USER_DEPT    IN HRW_HOMETAX_INFO.USER_DEPT%TYPE
            , P_USER_NAME    IN HRW_HOMETAX_INFO.USER_NAME%TYPE
            , P_USER_TEL_NUM IN HRW_HOMETAX_INFO.USER_TEL_NUM%TYPE
            , P_USER_ID      IN HRW_HOMETAX_INFO.CREATED_BY%TYPE
            );

END HRW_HOMETAX_INFO_G;
/
CREATE OR REPLACE PACKAGE BODY HRW_HOMETAX_INFO_G
AS
/******************************************************************************/
/* PROJECT      : FPCB ERP
/* MODULE       : EAPP
/* PROGRAM NAME : HRW_HOMETAX_INFO_G
/* DESCRIPTION  : 홈택스 정보 관리
/* REFERENCE BY :
/* PROGRAM HISTORY :
/*------------------------------------------------------------------------------
/*   DATE       IN CHARGE          DESCRIPTION
/*------------------------------------------------------------------------------
/* 20-JUN-2010  JEON HO SU          INITIALIZE
/******************************************************************************/
-- 홈택스 정보 조회.
  PROCEDURE SELECT_HOMETAX
            ( P_CURSOR            OUT TYPES.TCURSOR
            , P_CORP_ID           IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            )
  AS
  BEGIN
    OPEN P_CURSOR FOR
      SELECT HRM_CORP_MASTER_G.CORP_NAME_F(HI.CORP_ID) AS CORP_NAME
          , ( SELECT OU.VAT_NUMBER        
                FROM HRM_OPERATING_UNIT OU
              WHERE OU.CORP_ID        = HI.CORP_ID
                AND OU.SOB_ID         = HI.SOB_ID
                AND OU.ORG_ID         = HI.ORG_ID
                AND (OU.DEFAULT_FLAG  = 'Y'
                OR ROWNUM             <= 1)
             ) AS VAT_NUMBER
          , HI.HOMETAX_ID
          , HI.ENCRYPT_PWD
          , HI.ENCRYPT_PWD AS CHK_ENCRYPT_PWD
          , HI.USER_DEPT
          , HI.USER_NAME
          , HI.USER_TEL_NUM
        FROM HRW_HOMETAX_INFO HI
       WHERE HI.CORP_ID             = P_CORP_ID
         AND HI.SOB_ID              = P_SOB_ID
         AND HI.ORG_ID              = P_ORG_ID
      ;
  END SELECT_HOMETAX;

-- 홈택스 정보 INSERT/UPDATE.
  PROCEDURE SAVE_HOMETAX
            ( P_CORP_ID      IN HRW_HOMETAX_INFO.CORP_ID%TYPE
            , P_SOB_ID       IN HRW_HOMETAX_INFO.SOB_ID%TYPE
            , P_ORG_ID       IN HRW_HOMETAX_INFO.ORG_ID%TYPE
            , P_HOMETAX_ID   IN HRW_HOMETAX_INFO.HOMETAX_ID%TYPE
            , P_ENCRYPT_PWD  IN HRW_HOMETAX_INFO.ENCRYPT_PWD%TYPE
            , P_USER_DEPT    IN HRW_HOMETAX_INFO.USER_DEPT%TYPE
            , P_USER_NAME    IN HRW_HOMETAX_INFO.USER_NAME%TYPE
            , P_USER_TEL_NUM IN HRW_HOMETAX_INFO.USER_TEL_NUM%TYPE
            , P_USER_ID      IN HRW_HOMETAX_INFO.CREATED_BY%TYPE
            )
  AS
    V_SYSDATE       DATE := GET_LOCAL_DATE(P_SOB_ID);
  BEGIN
    UPDATE HRW_HOMETAX_INFO
      SET SOB_ID           = P_SOB_ID
        , ORG_ID           = P_ORG_ID
        , HOMETAX_ID       = P_HOMETAX_ID
        , ENCRYPT_PWD      = P_ENCRYPT_PWD
        , USER_DEPT        = P_USER_DEPT
        , USER_NAME        = P_USER_NAME
        , USER_TEL_NUM     = P_USER_TEL_NUM
        , LAST_UPDATE_DATE = V_SYSDATE
        , LAST_UPDATED_BY  = P_USER_ID
    WHERE CORP_ID          = P_CORP_ID
      AND SOB_ID           = P_SOB_ID
      AND ORG_ID           = P_ORG_ID
    ;
    IF SQL%ROWCOUNT = 0 THEN
      INSERT INTO HRW_HOMETAX_INFO
      ( CORP_ID
      , SOB_ID 
      , ORG_ID 
      , HOMETAX_ID 
      , ENCRYPT_PWD 
      , USER_DEPT 
      , USER_NAME 
      , USER_TEL_NUM 
      , CREATION_DATE 
      , CREATED_BY 
      , LAST_UPDATE_DATE 
      , LAST_UPDATED_BY )
      VALUES
      ( P_CORP_ID
      , P_SOB_ID
      , P_ORG_ID
      , P_HOMETAX_ID
      , P_ENCRYPT_PWD
      , P_USER_DEPT
      , P_USER_NAME
      , P_USER_TEL_NUM
      , V_SYSDATE
      , P_USER_ID
      , V_SYSDATE
      , P_USER_ID );
    END IF;
  END SAVE_HOMETAX;

END HRW_HOMETAX_INFO_G;
/
