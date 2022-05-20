CREATE OR REPLACE PACKAGE HRA_DONATION_TYPE_G AS

/*======================================================================/
     ++ 기부구분 조회  ++
/======================================================================*/
  PROCEDURE SELECT_DONATION_TYPE 
            ( P_CURSOR              OUT TYPES.TCURSOR
            , P_SOB_ID              IN NUMBER
            , P_ORG_ID              IN NUMBER           
            , P_DONATION_TYPE_NAME  IN VARCHAR2  
            , P_ENABLED_FLAG        IN VARCHAR2 
            );

-- 삽입 : 기부 구분.
  PROCEDURE INSERT_DONATION_TYPE 
            ( P_DONATION_TYPE_ID    OUT HRM_COMMON.COMMON_ID%TYPE  
            , P_SOB_ID              IN  HRM_COMMON.SOB_ID%TYPE 
            , P_ORG_ID              IN  HRM_COMMON.ORG_ID%TYPE 
            , P_DONATION_TYPE       IN  HRM_COMMON.CODE%TYPE 
            , P_DONATION_TYPE_NAME  IN  HRM_COMMON.CODE_NAME%TYPE 
            , P_SORT_NUM            IN  HRM_COMMON.SORT_NUM%TYPE 
            , P_DESCRIPTION         IN  HRM_COMMON.DESCRIPTION%TYPE 
            , P_ENABLED_FLAG        IN  HRM_COMMON.ENABLED_FLAG%TYPE 
            , P_EFFECTIVE_DATE_FR   IN  HRM_COMMON.EFFECTIVE_DATE_FR%TYPE 
            , P_EFFECTIVE_DATE_TO   IN  HRM_COMMON.EFFECTIVE_DATE_TO%TYPE             
            , P_USER_ID             IN  HRM_COMMON.CREATED_BY%TYPE  
            );

-- 수정 : 기부 구분.
  PROCEDURE UPDATE_DONATION_TYPE 
            ( W_DONATION_TYPE_ID    IN  HRM_COMMON.COMMON_ID%TYPE  
            , W_SOB_ID              IN  HRM_COMMON.SOB_ID%TYPE 
            , W_ORG_ID              IN  HRM_COMMON.ORG_ID%TYPE 
            , P_DONATION_TYPE_NAME  IN  HRM_COMMON.CODE_NAME%TYPE 
            , P_SORT_NUM            IN  HRM_COMMON.SORT_NUM%TYPE 
            , P_DESCRIPTION         IN  HRM_COMMON.DESCRIPTION%TYPE 
            , P_ENABLED_FLAG        IN  HRM_COMMON.ENABLED_FLAG%TYPE 
            , P_EFFECTIVE_DATE_FR   IN  HRM_COMMON.EFFECTIVE_DATE_FR%TYPE 
            , P_EFFECTIVE_DATE_TO   IN  HRM_COMMON.EFFECTIVE_DATE_TO%TYPE             
            , P_USER_ID             IN  HRM_COMMON.CREATED_BY%TYPE  
            );

 /*======================================================================/
     ++ 기부구분의 이월한도 조회  ++
/======================================================================*/
  PROCEDURE SELECT_DONATION_CARRIED_OVER 
            ( P_CURSOR1             OUT TYPES.TCURSOR1
            , P_SOB_ID              IN NUMBER
            , P_ORG_ID              IN NUMBER           
            , P_DONATION_TYPE_ID    IN NUMBER 
            );

-- 삽입 : 기부구분의 이월한도.
  PROCEDURE INSERT_DONATION_CARRIED_OVER 
            ( P_DONATION_CARRIED_OVER_ID  OUT HRA_DONATION_CARRIED_OVER.DONATION_CARRIED_OVER_ID%TYPE
            , P_DONATION_TYPE_ID          IN HRA_DONATION_CARRIED_OVER.DONATION_TYPE_ID%TYPE
            , P_PERIOD_YYYY_FR            IN HRA_DONATION_CARRIED_OVER.PERIOD_YYYY_FR%TYPE
            , P_PERIOD_YYYY_TO            IN HRA_DONATION_CARRIED_OVER.PERIOD_YYYY_TO%TYPE 
            , P_SOB_ID                    IN HRA_DONATION_CARRIED_OVER.SOB_ID%TYPE
            , P_ORG_ID                    IN HRA_DONATION_CARRIED_OVER.ORG_ID%TYPE
            , P_CARRIED_OVER_YEAR         IN HRA_DONATION_CARRIED_OVER.CARRIED_OVER_YEAR%TYPE
            , P_DESCRIPTION               IN HRA_DONATION_CARRIED_OVER.DESCRIPTION%TYPE
            , P_USER_ID                   IN HRA_DONATION_CARRIED_OVER.CREATED_BY%TYPE
            );

-- 수정 : 기부구분의 이월한도.
  PROCEDURE UPDATE_DONATION_CARRIED_OVER 
            ( W_DONATION_CARRIED_OVER_ID  IN HRA_DONATION_CARRIED_OVER.DONATION_CARRIED_OVER_ID%TYPE
            , W_DONATION_TYPE_ID          IN HRA_DONATION_CARRIED_OVER.DONATION_TYPE_ID%TYPE
            , P_PERIOD_YYYY_FR            IN HRA_DONATION_CARRIED_OVER.PERIOD_YYYY_FR%TYPE
            , P_PERIOD_YYYY_TO            IN HRA_DONATION_CARRIED_OVER.PERIOD_YYYY_TO%TYPE 
            , P_SOB_ID                    IN HRA_DONATION_CARRIED_OVER.SOB_ID%TYPE
            , P_ORG_ID                    IN HRA_DONATION_CARRIED_OVER.ORG_ID%TYPE
            , P_CARRIED_OVER_YEAR         IN HRA_DONATION_CARRIED_OVER.CARRIED_OVER_YEAR%TYPE
            , P_DESCRIPTION               IN HRA_DONATION_CARRIED_OVER.DESCRIPTION%TYPE
            , P_USER_ID                   IN HRA_DONATION_CARRIED_OVER.CREATED_BY%TYPE
            );

-- 삭제 : 기부구분의 이월한도.
  PROCEDURE DELETE_DONATION_CARRIED_OVER 
            ( W_DONATION_CARRIED_OVER_ID  IN HRA_DONATION_CARRIED_OVER.DONATION_CARRIED_OVER_ID%TYPE
            );
                        
END HRA_DONATION_TYPE_G;
/
CREATE OR REPLACE PACKAGE BODY HRA_DONATION_TYPE_G
AS
/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRA_SUPPORT_FAMILY_G
/* Description  : 연말정산 기부금 관리 패키지
/*
/* Reference by :
/* Program History :
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
  /*======================================================================/
       ++ 기부구분 조회 ++
  /======================================================================*/
  PROCEDURE SELECT_DONATION_TYPE 
            ( P_CURSOR              OUT TYPES.TCURSOR
            , P_SOB_ID              IN NUMBER
            , P_ORG_ID              IN NUMBER           
            , P_DONATION_TYPE_NAME  IN VARCHAR2  
            , P_ENABLED_FLAG        IN VARCHAR2 
            )
  AS
    V_LOCAL_DATE        DATE := TRUNC(GET_LOCAL_DATE(P_SOB_ID));
  BEGIN
    OPEN P_CURSOR FOR
      SELECT DT.DONATION_TYPE_ID
           , DT.DONATION_TYPE
           , DT.DONATION_TYPE_NAME
           , DT.SORT_NUM
           , DT.DESCRIPTION
           , DT.ENABLED_FLAG
           , DT.EFFECTIVE_DATE_FR
           , DT.EFFECTIVE_DATE_TO
        FROM HRM_DONATION_TYPE_V DT 
      WHERE DT.SOB_ID             = P_SOB_ID
        AND DT.ORG_ID             = P_ORG_ID
        AND DT.DONATION_TYPE_NAME LIKE P_DONATION_TYPE_NAME || '%'
        AND ((P_ENABLED_FLAG      != 'Y' AND 1 = 1)
         OR  (P_ENABLED_FLAG      = 'Y' AND DT.ENABLED_FLAG = P_ENABLED_FLAG))
        AND ((P_ENABLED_FLAG      != 'Y' AND 1 = 1)
         OR  (P_ENABLED_FLAG      = 'Y' AND DT.EFFECTIVE_DATE_FR <= V_LOCAL_DATE))
        AND ((P_ENABLED_FLAG      != 'Y' AND 1 = 1)
         OR  (P_ENABLED_FLAG      = 'Y' AND (DT.EFFECTIVE_DATE_TO >= V_LOCAL_DATE OR DT.EFFECTIVE_DATE_TO IS NULL)))
      ORDER BY DT.SORT_NUM, DT.DONATION_TYPE 
       ;
  END SELECT_DONATION_TYPE;

-- 삽입 : 기부 구분.
  PROCEDURE INSERT_DONATION_TYPE 
            ( P_DONATION_TYPE_ID    OUT HRM_COMMON.COMMON_ID%TYPE  
            , P_SOB_ID              IN  HRM_COMMON.SOB_ID%TYPE 
            , P_ORG_ID              IN  HRM_COMMON.ORG_ID%TYPE 
            , P_DONATION_TYPE       IN  HRM_COMMON.CODE%TYPE 
            , P_DONATION_TYPE_NAME  IN  HRM_COMMON.CODE_NAME%TYPE 
            , P_SORT_NUM            IN  HRM_COMMON.SORT_NUM%TYPE 
            , P_DESCRIPTION         IN  HRM_COMMON.DESCRIPTION%TYPE 
            , P_ENABLED_FLAG        IN  HRM_COMMON.ENABLED_FLAG%TYPE 
            , P_EFFECTIVE_DATE_FR   IN  HRM_COMMON.EFFECTIVE_DATE_FR%TYPE 
            , P_EFFECTIVE_DATE_TO   IN  HRM_COMMON.EFFECTIVE_DATE_TO%TYPE             
            , P_USER_ID             IN  HRM_COMMON.CREATED_BY%TYPE  
            )
  AS
    V_GROUP_ID             NUMBER;    
    V_GROUP_CODE           VARCHAR2(30) := 'DONATION_TYPE';
    V_RECORD_COUNT         NUMBER;
  BEGIN
    -- 코드 중복 체크 --
    V_RECORD_COUNT := 0;
    BEGIN
      SELECT COUNT(HC.CODE) AS RECORD_COUNT
        INTO V_RECORD_COUNT
        FROM HRM_COMMON HC
       WHERE HC.GROUP_CODE        = '-'
         AND HC.CODE              = V_GROUP_CODE
         AND HC.SOB_ID            = P_SOB_ID
         AND HC.ORG_ID            = P_ORG_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_RECORD_COUNT := 0;
    END;
    IF V_RECORD_COUNT < 1 THEN
      SELECT HRM_COMMON_S1.NEXTVAL
        INTO V_GROUP_ID
        FROM DUAL;

      INSERT INTO HRM_COMMON
      ( COMMON_ID
      , GROUP_CODE
      , CODE
      , CODE_NAME
      , SYSTEM_FLAG
      , ENABLED_FLAG
      , EFFECTIVE_DATE_FR
      , SOB_ID
      , ORG_ID
      , CREATION_DATE
      , CREATED_BY
      , LAST_UPDATE_DATE
      , LAST_UPDATED_BY
      ) VALUES
      ( V_GROUP_ID
      , '-'
      , V_GROUP_CODE
      , '기부금 구분'      -- P_CODE_NAME
      , 'E'                -- 별도 관리 
      , 'Y'             
      , TRUNC(P_EFFECTIVE_DATE_FR, 'MONTH')
      , P_SOB_ID
      , P_ORG_ID
      , SYSDATE
      , P_USER_ID
      , SYSDATE
      , P_USER_ID
      );
    END IF;
    
    -- 코드 중복 체크 --
    V_RECORD_COUNT := 0;
    BEGIN
      SELECT COUNT(HC.CODE) AS RECORD_COUNT
        INTO V_RECORD_COUNT
        FROM HRM_COMMON HC
       WHERE HC.GROUP_CODE        = V_GROUP_CODE
         AND HC.CODE              = P_DONATION_TYPE
         AND HC.SOB_ID            = P_SOB_ID
         AND HC.ORG_ID            = P_ORG_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_RECORD_COUNT := 0;
    END;
    IF V_RECORD_COUNT > 0 THEN
      RAISE_APPLICATION_ERROR(ERRNUMS.Exist_Data_Code, ERRNUMS.Exist_Data_Desc);
      RETURN;
    END IF;
    
		SELECT HRM_COMMON_S1.NEXTVAL
      INTO P_DONATION_TYPE_ID
      FROM DUAL;

		INSERT INTO HRM_COMMON
		( COMMON_ID
    , GROUP_CODE
    , CODE
    , CODE_NAME
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
		( P_DONATION_TYPE_ID
    , V_GROUP_CODE
    , P_DONATION_TYPE
    , P_DONATION_TYPE_NAME
		, NVL(P_SORT_NUM, 0)
    , P_DESCRIPTION
    , NVL(P_ENABLED_FLAG, 'Y') 
    , TRUNC(P_EFFECTIVE_DATE_FR)
    , TRUNC(P_EFFECTIVE_DATE_TO)
		, P_SOB_ID
    , P_ORG_ID
		, SYSDATE
    , P_USER_ID
    , SYSDATE
    , P_USER_ID
		);
  END INSERT_DONATION_TYPE;

-- 수정 : 기부 구분.
  PROCEDURE UPDATE_DONATION_TYPE 
            ( W_DONATION_TYPE_ID    IN  HRM_COMMON.COMMON_ID%TYPE  
            , W_SOB_ID              IN  HRM_COMMON.SOB_ID%TYPE 
            , W_ORG_ID              IN  HRM_COMMON.ORG_ID%TYPE 
            , P_DONATION_TYPE_NAME  IN  HRM_COMMON.CODE_NAME%TYPE 
            , P_SORT_NUM            IN  HRM_COMMON.SORT_NUM%TYPE 
            , P_DESCRIPTION         IN  HRM_COMMON.DESCRIPTION%TYPE 
            , P_ENABLED_FLAG        IN  HRM_COMMON.ENABLED_FLAG%TYPE 
            , P_EFFECTIVE_DATE_FR   IN  HRM_COMMON.EFFECTIVE_DATE_FR%TYPE 
            , P_EFFECTIVE_DATE_TO   IN  HRM_COMMON.EFFECTIVE_DATE_TO%TYPE             
            , P_USER_ID             IN  HRM_COMMON.CREATED_BY%TYPE  
            )
  IS
  BEGIN
    UPDATE HRM_COMMON HC
      SET HC.CODE_NAME          = P_DONATION_TYPE_NAME 
        , HC.SORT_NUM           = NVL(P_SORT_NUM, 0)
        , HC.DESCRIPTION        = P_DESCRIPTION
        , HC.ENABLED_FLAG       = NVL(P_ENABLED_FLAG, 'Y')
        , HC.EFFECTIVE_DATE_FR  = TRUNC(P_EFFECTIVE_DATE_FR)
        , HC.EFFECTIVE_DATE_TO  = TRUNC(P_EFFECTIVE_DATE_TO) 
        , HC.LAST_UPDATE_DATE   = SYSDATE
        , HC.LAST_UPDATED_BY    = P_USER_ID
    WHERE HC.COMMON_ID          = W_DONATION_TYPE_ID;
  END UPDATE_DONATION_TYPE;

 /*======================================================================/
     ++ 기부구분의 이월한도 조회  ++
/======================================================================*/
  PROCEDURE SELECT_DONATION_CARRIED_OVER 
            ( P_CURSOR1             OUT TYPES.TCURSOR1
            , P_SOB_ID              IN NUMBER
            , P_ORG_ID              IN NUMBER           
            , P_DONATION_TYPE_ID    IN NUMBER 
            )
  AS
  BEGIN
    OPEN P_CURSOR1 FOR
      SELECT CO.DONATION_CARRIED_OVER_ID
           , CO.DONATION_TYPE_ID
           , CO.PERIOD_YYYY_FR
           , CO.PERIOD_YYYY_TO
           , CO.CARRIED_OVER_YEAR
           , CO.DESCRIPTION 
        FROM HRA_DONATION_CARRIED_OVER CO
      WHERE CO.DONATION_TYPE_ID     = P_DONATION_TYPE_ID
        AND CO.SOB_ID               = P_SOB_ID
        AND CO.ORG_ID               = P_ORG_ID 
      ORDER BY CO.PERIOD_YYYY_FR DESC 
      ;
  END SELECT_DONATION_CARRIED_OVER;

-- 삽입 : 기부구분의 이월한도.
  PROCEDURE INSERT_DONATION_CARRIED_OVER 
            ( P_DONATION_CARRIED_OVER_ID  OUT HRA_DONATION_CARRIED_OVER.DONATION_CARRIED_OVER_ID%TYPE
            , P_DONATION_TYPE_ID          IN HRA_DONATION_CARRIED_OVER.DONATION_TYPE_ID%TYPE
            , P_PERIOD_YYYY_FR            IN HRA_DONATION_CARRIED_OVER.PERIOD_YYYY_FR%TYPE
            , P_PERIOD_YYYY_TO            IN HRA_DONATION_CARRIED_OVER.PERIOD_YYYY_TO%TYPE 
            , P_SOB_ID                    IN HRA_DONATION_CARRIED_OVER.SOB_ID%TYPE
            , P_ORG_ID                    IN HRA_DONATION_CARRIED_OVER.ORG_ID%TYPE
            , P_CARRIED_OVER_YEAR         IN HRA_DONATION_CARRIED_OVER.CARRIED_OVER_YEAR%TYPE
            , P_DESCRIPTION               IN HRA_DONATION_CARRIED_OVER.DESCRIPTION%TYPE
            , P_USER_ID                   IN HRA_DONATION_CARRIED_OVER.CREATED_BY%TYPE
            )
  AS
    V_SYSDATE                   DATE := GET_LOCAL_DATE(P_SOB_ID); 
    V_REC_CNT                   NUMBER;
  BEGIN
    -- 적용 기간 검증 -- 
    BEGIN
      SELECT COUNT(CO.DONATION_CARRIED_OVER_ID) AS REC_CNT 
        INTO V_REC_CNT
        FROM HRA_DONATION_CARRIED_OVER CO
       WHERE CO.DONATION_TYPE_ID      = P_DONATION_TYPE_ID
         AND CO.SOB_ID                = P_SOB_ID
         AND CO.ORG_ID                = P_ORG_ID
         AND (P_PERIOD_YYYY_FR        BETWEEN CO.PERIOD_YYYY_FR        
                                          AND CO.PERIOD_YYYY_TO
          OR  P_PERIOD_YYYY_TO        BETWEEN CO.PERIOD_YYYY_FR
                                          AND CO.PERIOD_YYYY_TO) 
      ;
    EXCEPTION
      WHEN OTHERS THEN
        V_REC_CNT := 0;
    END;
    IF V_REC_CNT > 0 THEN
      RAISE_APPLICATION_ERROR(-20001, '기부금 이월한도 적용 기간이 중복되었습니다. 확인바랍니다.');
      RETURN; 
    END IF;
    
    SELECT HRA_DONATION_CARRIED_OVER_S1.NEXTVAL
      INTO P_DONATION_CARRIED_OVER_ID
      FROM DUAL;

    INSERT INTO HRA_DONATION_CARRIED_OVER
    ( DONATION_CARRIED_OVER_ID 
    , DONATION_TYPE_ID 
    , PERIOD_YYYY_FR 
    , PERIOD_YYYY_TO 
    , SOB_ID 
    , ORG_ID 
    , CARRIED_OVER_YEAR 
    , DESCRIPTION 
    , CREATION_DATE 
    , CREATED_BY 
    , LAST_UPDATE_DATE 
    , LAST_UPDATED_BY )
    VALUES
    ( P_DONATION_CARRIED_OVER_ID 
    , P_DONATION_TYPE_ID 
    , P_PERIOD_YYYY_FR 
    , P_PERIOD_YYYY_TO 
    , P_SOB_ID
    , P_ORG_ID
    , NVL(P_CARRIED_OVER_YEAR, 0)
    , P_DESCRIPTION
    , V_SYSDATE
    , P_USER_ID
    , V_SYSDATE
    , P_USER_ID );
  END INSERT_DONATION_CARRIED_OVER;

-- 수정 : 기부구분의 이월한도.
  PROCEDURE UPDATE_DONATION_CARRIED_OVER 
            ( W_DONATION_CARRIED_OVER_ID  IN HRA_DONATION_CARRIED_OVER.DONATION_CARRIED_OVER_ID%TYPE
            , W_DONATION_TYPE_ID          IN HRA_DONATION_CARRIED_OVER.DONATION_TYPE_ID%TYPE
            , P_PERIOD_YYYY_FR            IN HRA_DONATION_CARRIED_OVER.PERIOD_YYYY_FR%TYPE
            , P_PERIOD_YYYY_TO            IN HRA_DONATION_CARRIED_OVER.PERIOD_YYYY_TO%TYPE 
            , P_SOB_ID                    IN HRA_DONATION_CARRIED_OVER.SOB_ID%TYPE
            , P_ORG_ID                    IN HRA_DONATION_CARRIED_OVER.ORG_ID%TYPE
            , P_CARRIED_OVER_YEAR         IN HRA_DONATION_CARRIED_OVER.CARRIED_OVER_YEAR%TYPE
            , P_DESCRIPTION               IN HRA_DONATION_CARRIED_OVER.DESCRIPTION%TYPE
            , P_USER_ID                   IN HRA_DONATION_CARRIED_OVER.CREATED_BY%TYPE
            )
  AS
    V_SYSDATE DATE := GET_LOCAL_DATE(P_SOB_ID);
    
    V_REC_CNT                   NUMBER;
  BEGIN
    -- 적용 기간 검증 -- 
    BEGIN
      SELECT COUNT(CO.DONATION_CARRIED_OVER_ID) AS REC_CNT 
        INTO V_REC_CNT
        FROM HRA_DONATION_CARRIED_OVER CO
       WHERE CO.DONATION_CARRIED_OVER_ID != W_DONATION_CARRIED_OVER_ID
         AND CO.DONATION_TYPE_ID      = W_DONATION_TYPE_ID
         AND CO.SOB_ID                = P_SOB_ID
         AND CO.ORG_ID                = P_ORG_ID
         AND (P_PERIOD_YYYY_FR        BETWEEN CO.PERIOD_YYYY_FR        
                                          AND CO.PERIOD_YYYY_TO
          OR  P_PERIOD_YYYY_TO        BETWEEN CO.PERIOD_YYYY_FR
                                          AND CO.PERIOD_YYYY_TO) 
      ;
    EXCEPTION
      WHEN OTHERS THEN
        V_REC_CNT := 0;
    END;
    IF V_REC_CNT > 0 THEN
      RAISE_APPLICATION_ERROR(-20001, '기부금 이월한도 적용 기간이 중복되었습니다. 확인바랍니다.');
      RETURN; 
    END IF;
    
    UPDATE HRA_DONATION_CARRIED_OVER CO
      SET CO.PERIOD_YYYY_FR           = P_PERIOD_YYYY_FR 
        , CO.PERIOD_YYYY_TO           = P_PERIOD_YYYY_TO 
        , CO.CARRIED_OVER_YEAR        = NVL(P_CARRIED_OVER_YEAR, 0)
        , CO.DESCRIPTION              = P_DESCRIPTION
        , CO.LAST_UPDATE_DATE         = V_SYSDATE
        , CO.LAST_UPDATED_BY          = P_USER_ID
    WHERE CO.DONATION_CARRIED_OVER_ID = W_DONATION_CARRIED_OVER_ID;
  END UPDATE_DONATION_CARRIED_OVER;

-- 삭제 : 기부구분의 이월한도.
  PROCEDURE DELETE_DONATION_CARRIED_OVER 
            ( W_DONATION_CARRIED_OVER_ID  IN HRA_DONATION_CARRIED_OVER.DONATION_CARRIED_OVER_ID%TYPE
            )
  AS
  BEGIN
    DELETE FROM HRA_DONATION_CARRIED_OVER CO 
    WHERE CO.DONATION_CARRIED_OVER_ID = W_DONATION_CARRIED_OVER_ID;
  END DELETE_DONATION_CARRIED_OVER;
  
END HRA_DONATION_TYPE_G;
/
