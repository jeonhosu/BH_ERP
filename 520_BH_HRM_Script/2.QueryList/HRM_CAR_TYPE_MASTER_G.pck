CREATE OR REPLACE PACKAGE HRM_CAR_TYPE_MASTER_G
AS
/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRM_CAR_TYPE_MASTER_G
/* Description  : 차량 종류 관리 패키지
/*
/* Reference by : 
/* Program History :
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 10-Jul-2013  Shin sanghee       Initialize
/******************************************************************************/

-- 차량 종류 조회. 
  PROCEDURE SELECT_CAR_TYPE
            ( P_CURSOR             OUT TYPES.TCURSOR
            , W_CAR_TYPE_DESC      IN  VARCHAR2
            , W_ENABLED_FLAG       IN  VARCHAR2
            , W_SOB_ID             IN  NUMBER
            , W_ORG_ID             IN  NUMBER
            );

-- 차량 종류 INSERT.
  PROCEDURE INSERT_CAR_TYPE
            ( P_CAR_TYPE_ID         OUT NUMBER
            , P_CAR_TYPE_CODE       IN  VARCHAR2
            , P_CAR_TYPE_NAME       IN  VARCHAR2
            , P_SORT_NUM            IN  NUMBER
            , P_DESCRIPTION         IN  VARCHAR2
            , P_ENABLED_FLAG        IN  VARCHAR2
            , P_EFFECTIVE_DATE_FR   IN  DATE
            , P_EFFECTIVE_DATE_TO   IN  DATE
            , P_SOB_ID              IN  NUMBER
            , P_ORG_ID              IN  NUMBER
            , P_USER_ID             IN  NUMBER
            );

-- 차량 종류 UPDATE.
  PROCEDURE UPDATE_CAR_TYPE
            ( W_CAR_TYPE_ID         OUT NUMBER
            , P_CAR_TYPE_CODE       IN  VARCHAR2
            , P_CAR_TYPE_NAME       IN  VARCHAR2
            , P_SORT_NUM            IN  NUMBER
            , P_DESCRIPTION         IN  VARCHAR2
            , P_ENABLED_FLAG        IN  VARCHAR2
            , P_EFFECTIVE_DATE_FR   IN  DATE
            , P_EFFECTIVE_DATE_TO   IN  DATE
            , W_SOB_ID              IN  NUMBER
            , W_ORG_ID              IN  NUMBER
            , P_USER_ID             IN  NUMBER
            );


END HRM_CAR_TYPE_MASTER_G;
/
CREATE OR REPLACE PACKAGE BODY HRM_CAR_TYPE_MASTER_G
AS
/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRM_CAR_TYPE_MASTER_G
/* Description  : 차량 종류 관리 패키지
/*
/* Reference by : 
/* Program History :
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 10-Jul-2013  Shin sanghee       Initialize
/******************************************************************************/

-- 차량 종류 조회. 
  PROCEDURE SELECT_CAR_TYPE
            ( P_CURSOR             OUT TYPES.TCURSOR
            , W_CAR_TYPE_DESC      IN  VARCHAR2
            , W_ENABLED_FLAG       IN  VARCHAR2
            , W_SOB_ID             IN  NUMBER
            , W_ORG_ID             IN  NUMBER
            )
  AS
    V_STD_DATE          DATE := NULL;
  BEGIN
    IF W_ENABLED_FLAG = 'Y' THEN
      V_STD_DATE := TRUNC(GET_LOCAL_DATE(W_SOB_ID));
    END IF;
    
    OPEN P_CURSOR FOR
      SELECT HCT.CAR_TYPE_ID
           , HCT.CAR_TYPE_CODE
           , HCT.CAR_TYPE_NAME
           , HCT.SORT_NUM
           , HCT.ENABLED_FLAG
           , HCT.EFFECTIVE_DATE_FR
           , HCT.EFFECTIVE_DATE_TO
           , HCT.DESCRIPTION
      FROM HRM_CAR_TYPE_V    HCT
      WHERE HCT.SOB_ID                 = W_SOB_ID
        AND HCT.ORG_ID                 = W_ORG_ID
        AND HCT.CAR_TYPE_NAME          LIKE W_CAR_TYPE_DESC || '%'
        AND ((W_ENABLED_FLAG          != 'Y' AND 1 = 1)
        OR   (W_ENABLED_FLAG           = 'Y' AND HCT.ENABLED_FLAG = W_ENABLED_FLAG))
        AND ((W_ENABLED_FLAG          != 'Y' AND 1 = 1)
        OR   (W_ENABLED_FLAG           = 'Y' AND ((HCT.EFFECTIVE_DATE_FR <= V_STD_DATE)
                                             AND  (HCT.EFFECTIVE_DATE_TO >= V_STD_DATE OR HCT.EFFECTIVE_DATE_TO IS NULL))))
      ORDER BY HCT.SORT_NUM, HCT.CAR_TYPE_CODE
      ;
  END SELECT_CAR_TYPE;

-- 차량 종류 INSERT.
  PROCEDURE INSERT_CAR_TYPE
            ( P_CAR_TYPE_ID         OUT NUMBER
            , P_CAR_TYPE_CODE       IN  VARCHAR2
            , P_CAR_TYPE_NAME       IN  VARCHAR2
            , P_SORT_NUM            IN  NUMBER
            , P_DESCRIPTION         IN  VARCHAR2
            , P_ENABLED_FLAG        IN  VARCHAR2
            , P_EFFECTIVE_DATE_FR   IN  DATE
            , P_EFFECTIVE_DATE_TO   IN  DATE
            , P_SOB_ID              IN  NUMBER
            , P_ORG_ID              IN  NUMBER
            , P_USER_ID             IN  NUMBER
            )
  AS
    D_SYSDATE            DATE := GET_LOCAL_DATE(P_SOB_ID);
    V_GROUP_CODE         VARCHAR2(70) := 'CAR_TYPE';    
    V_RECORD_COUNT       NUMBER := 0;
  BEGIN
    -- Group Code check : if (yes -> skip) else (no -> New Insert) --
    MERGE INTO HRM_COMMON HC
    USING( SELECT '-'          AS GROUP_CODE
                , V_GROUP_CODE AS CODE
                , P_SOB_ID     AS SOB_ID
                , P_ORG_ID     AS ORG_ID
             FROM DUAL
         ) SX1
    ON   (HC.GROUP_CODE           = SX1.GROUP_CODE
      AND HC.CODE                 = SX1.CODE
      AND HC.SOB_ID               = SX1.SOB_ID
      AND HC.ORG_ID               = SX1.ORG_ID
         )
    WHEN NOT MATCHED THEN
      INSERT 
      ( COMMON_ID 
      , GROUP_CODE 
      , CODE 
      , CODE_NAME 
      , SYSTEM_FLAG
      , DESCRIPTION 
      , ENABLED_FLAG 
      , EFFECTIVE_DATE_FR 
      , SOB_ID 
      , ORG_ID 
      , CREATION_DATE 
      , CREATED_BY 
      , LAST_UPDATE_DATE 
      , LAST_UPDATED_BY 
      ) VALUES
      ( HRM_COMMON_S1.NEXTVAL
      , SX1.GROUP_CODE
      , SX1.CODE       -- CODE --
      , '차량 종류 관리'  -- CODE NAME --
      , 'E'      
      , '차량 종류 관리 헤더'
      , NVL(P_ENABLED_FLAG, 'Y')
      , TRUNC(SYSDATE, 'YEAR')
      , SX1.SOB_ID
      , SX1.ORG_ID
      , D_SYSDATE
      , P_USER_ID
      , D_SYSDATE
      , P_USER_ID
      )
    ;
    
    -- LINE 코드 체크 --
    BEGIN
      SELECT COUNT(HCT.CAR_TYPE_CODE) AS RECORD_COUNT
        INTO V_RECORD_COUNT
        FROM HRM_CAR_TYPE_V HCT
       WHERE HCT.CAR_TYPE_CODE   = P_CAR_TYPE_CODE
         AND HCT.SOB_ID          = P_SOB_ID
         AND HCT.ORG_ID          = P_ORG_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_RECORD_COUNT := 0;
    END;
    IF V_RECORD_COUNT > 0 THEN
      RAISE_APPLICATION_ERROR(ERRNUMS.Exist_Data_Code, ERRNUMS.Exist_Data_Desc);
      RETURN;
    END IF;

    SELECT HRM_COMMON_S1.NEXTVAL
      INTO P_CAR_TYPE_ID
      FROM DUAL;

    INSERT INTO HRM_COMMON
    ( COMMON_ID 
    , GROUP_CODE 
    , CODE 
    , CODE_NAME 
    , SYSTEM_FLAG
    , SORT_NUM
    , DESCRIPTION 
    , ENABLED_FLAG 
    , EFFECTIVE_DATE_FR 
    , EFFECTIVE_DATE_TO
    , SOB_ID 
    , ORG_ID 
    , CREATION_DATE 
    , CREATED_BY 
    , LAST_UPDATE_DATE 
    , LAST_UPDATED_BY 
    ) VALUES
    ( P_CAR_TYPE_ID 
    , V_GROUP_CODE 
    , P_CAR_TYPE_CODE 
    , P_CAR_TYPE_NAME 
    , 'E'
    , P_SORT_NUM
    , P_DESCRIPTION     
    , P_ENABLED_FLAG
    , TRUNC(P_EFFECTIVE_DATE_FR)
    , TRUNC(P_EFFECTIVE_DATE_TO)
    , P_SOB_ID 
    , P_ORG_ID 
    , D_SYSDATE
    , P_USER_ID
    , D_SYSDATE
    , P_USER_ID
    );
  END INSERT_CAR_TYPE;

-- 차량 종류 UPDATE.
  PROCEDURE UPDATE_CAR_TYPE
            ( W_CAR_TYPE_ID         OUT NUMBER
            , P_CAR_TYPE_CODE       IN  VARCHAR2
            , P_CAR_TYPE_NAME       IN  VARCHAR2
            , P_SORT_NUM            IN  NUMBER
            , P_DESCRIPTION         IN  VARCHAR2
            , P_ENABLED_FLAG        IN  VARCHAR2
            , P_EFFECTIVE_DATE_FR   IN  DATE
            , P_EFFECTIVE_DATE_TO   IN  DATE
            , W_SOB_ID              IN  NUMBER
            , W_ORG_ID              IN  NUMBER
            , P_USER_ID             IN  NUMBER
            )
  AS
    D_SYSDATE            DATE := GET_LOCAL_DATE(W_SOB_ID);
  BEGIN
    UPDATE HRM_COMMON HC
      SET /*HC.CODE               = P_CAR_TYPE_CODE
        , */HC.CODE_NAME          = P_CAR_TYPE_NAME
        , HC.SORT_NUM           = P_SORT_NUM
        , HC.DESCRIPTION        = P_DESCRIPTION
        , HC.ENABLED_FLAG       = NVL(P_ENABLED_FLAG, 'N')
        , HC.EFFECTIVE_DATE_FR  = TRUNC(P_EFFECTIVE_DATE_FR)
        , HC.EFFECTIVE_DATE_TO  = TRUNC(P_EFFECTIVE_DATE_TO)
        , HC.LAST_UPDATE_DATE   = D_SYSDATE
        , HC.LAST_UPDATED_BY    = P_USER_ID
    WHERE HC.COMMON_ID          = W_CAR_TYPE_ID
    ;
  END UPDATE_CAR_TYPE;

END HRM_CAR_TYPE_MASTER_G;
/
