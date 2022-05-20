CREATE OR REPLACE PACKAGE FI_DOCUMENT_NUM_G
AS

-- ��ǥ��ȣ ����.
  PROCEDURE SELECT_DOCUMENT_NUM
            ( P_CURSOR                OUT TYPES.TCURSOR
            , W_DOCUMENT_NUM_ID       IN FI_DOCUMENT_NUM.DOCUMENT_NUM_ID%TYPE
            , W_DOCUMENT_TYPE         IN FI_DOCUMENT_NUM.DOCUMENT_TYPE%TYPE
            , W_SOB_ID                IN FI_DOCUMENT_NUM.SOB_ID%TYPE
            );

-- ��ǥ��ȣ ����.
  PROCEDURE INSERT_DOCUMENT_NUM
            ( P_DOCUMENT_NUM_ID  OUT FI_DOCUMENT_NUM.DOCUMENT_NUM_ID%TYPE
            , P_SOB_ID           IN FI_DOCUMENT_NUM.SOB_ID%TYPE
            , P_DOCUMENT_TYPE    IN FI_DOCUMENT_NUM.DOCUMENT_TYPE%TYPE
            , P_DESCRIPTION      IN FI_DOCUMENT_NUM.DESCRIPTION%TYPE
            , P_PREFIX_CHAR      IN FI_DOCUMENT_NUM.PREFIX_CHAR%TYPE
            , P_PREFIX_SEPARATE  IN FI_DOCUMENT_NUM.PREFIX_SEPARATE%TYPE
            , P_DATE_TYPE        IN FI_DOCUMENT_NUM.DATE_TYPE%TYPE
            , P_SEQ_SEPARATE     IN FI_DOCUMENT_NUM.SEQ_SEPARATE%TYPE
            , P_SEQ_COUNT        IN FI_DOCUMENT_NUM.SEQ_COUNT%TYPE
            , P_USER_ID          IN FI_DOCUMENT_NUM.CREATED_BY%TYPE
            );

-- ��ǥ��ȣ ����.
  PROCEDURE UPDATE_DOCUMENT_NUM
            ( W_DOCUMENT_NUM_ID  IN FI_DOCUMENT_NUM.DOCUMENT_NUM_ID%TYPE
            , P_SOB_ID           IN FI_DOCUMENT_NUM.SOB_ID%TYPE
            , P_DESCRIPTION      IN FI_DOCUMENT_NUM.DESCRIPTION%TYPE
            , P_PREFIX_CHAR      IN FI_DOCUMENT_NUM.PREFIX_CHAR%TYPE
            , P_PREFIX_SEPARATE  IN FI_DOCUMENT_NUM.PREFIX_SEPARATE%TYPE
            , P_DATE_TYPE        IN FI_DOCUMENT_NUM.DATE_TYPE%TYPE
            , P_SEQ_SEPARATE     IN FI_DOCUMENT_NUM.SEQ_SEPARATE%TYPE
            , P_SEQ_COUNT        IN FI_DOCUMENT_NUM.SEQ_COUNT%TYPE
            , P_USER_ID          IN FI_DOCUMENT_NUM.CREATED_BY%TYPE
            );

-- ������ȣ LOOKUP ��ȸ.
  PROCEDURE LU_DOCUMENT_NUM
            ( P_CURSOR3              OUT TYPES.TCURSOR3
            , W_SOB_ID               IN FI_BANK.SOB_ID%TYPE
            );

-- ������ȣ ����.
  FUNCTION DOCUMENT_NUM_F
            ( W_DOCUMENT_TYPE         IN FI_DOCUMENT_NUM.DOCUMENT_TYPE%TYPE
            , W_SOB_ID                IN FI_DOCUMENT_NUM.SOB_ID%TYPE
            , P_STD_DATE              IN DATE
            , P_USER_ID               IN FI_DOCUMENT_NUM.CREATED_BY%TYPE
            ) RETURN VARCHAR2;

-- ������ȣ ����(���ν���).
  PROCEDURE DOCUMENT_NUM_P
            ( W_DOCUMENT_TYPE         IN FI_DOCUMENT_NUM.DOCUMENT_TYPE%TYPE
            , W_SOB_ID                IN FI_DOCUMENT_NUM.SOB_ID%TYPE
            , P_STD_DATE              IN DATE
            , P_USER_ID               IN FI_DOCUMENT_NUM.CREATED_BY%TYPE
            , O_DOCUMENT_NUM          OUT FI_DOCUMENT_NUM_HISTORY.DOCUMENT_NUM%TYPE
            );

END FI_DOCUMENT_NUM_G; 
/
CREATE OR REPLACE PACKAGE BODY FI_DOCUMENT_NUM_G
AS
/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_DOCUMENT_NUM_G
/* Description  : ��ǥ��ȣ ä�� ��
/*
/* Reference by :
/* Program History :
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
-- ��ǥ��ȣ ����.
  PROCEDURE SELECT_DOCUMENT_NUM
            ( P_CURSOR                OUT TYPES.TCURSOR
            , W_DOCUMENT_NUM_ID       IN FI_DOCUMENT_NUM.DOCUMENT_NUM_ID%TYPE
            , W_DOCUMENT_TYPE         IN FI_DOCUMENT_NUM.DOCUMENT_TYPE%TYPE
            , W_SOB_ID                IN FI_DOCUMENT_NUM.SOB_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR FOR
      SELECT FDN.DOCUMENT_NUM_ID
           , FDN.SOB_ID
           , FDN.DOCUMENT_TYPE
           , FDN.DESCRIPTION
           , FDN.PREFIX_CHAR
           , FDN.PREFIX_SEPARATE
           , FDN.DATE_TYPE
           , FDN.SEQ_SEPARATE
           , FDN.SEQ_COUNT
        FROM FI_DOCUMENT_NUM FDN
       WHERE FDN.DOCUMENT_NUM_ID        = NVL(W_DOCUMENT_NUM_ID, FDN.DOCUMENT_NUM_ID)
         AND FDN.SOB_ID                 = W_SOB_ID
         AND FDN.DOCUMENT_TYPE          = NVL(W_DOCUMENT_TYPE, FDN.DOCUMENT_TYPE)
      ORDER BY FDN.DOCUMENT_TYPE
     ;

  END SELECT_DOCUMENT_NUM;

-- ��ǥ��ȣ ����.
  PROCEDURE INSERT_DOCUMENT_NUM
            ( P_DOCUMENT_NUM_ID  OUT FI_DOCUMENT_NUM.DOCUMENT_NUM_ID%TYPE
            , P_SOB_ID           IN FI_DOCUMENT_NUM.SOB_ID%TYPE
            , P_DOCUMENT_TYPE    IN FI_DOCUMENT_NUM.DOCUMENT_TYPE%TYPE
            , P_DESCRIPTION      IN FI_DOCUMENT_NUM.DESCRIPTION%TYPE
            , P_PREFIX_CHAR      IN FI_DOCUMENT_NUM.PREFIX_CHAR%TYPE
            , P_PREFIX_SEPARATE  IN FI_DOCUMENT_NUM.PREFIX_SEPARATE%TYPE
            , P_DATE_TYPE        IN FI_DOCUMENT_NUM.DATE_TYPE%TYPE
            , P_SEQ_SEPARATE     IN FI_DOCUMENT_NUM.SEQ_SEPARATE%TYPE
            , P_SEQ_COUNT        IN FI_DOCUMENT_NUM.SEQ_COUNT%TYPE
            , P_USER_ID          IN FI_DOCUMENT_NUM.CREATED_BY%TYPE
            )
  AS
    V_SYSDATE                    FI_DOCUMENT_NUM.CREATION_DATE%TYPE;
    V_RECORD_COUNT NUMBER := 0;

  BEGIN
    -- ������ ����Ÿ�� ���� üũ.
    BEGIN
      SELECT COUNT(FDN.DOCUMENT_TYPE) AS RECORD_COUNT
        INTO V_RECORD_COUNT
        FROM FI_DOCUMENT_NUM FDN
       WHERE FDN.DOCUMENT_TYPE       = P_DOCUMENT_TYPE
         AND FDN.SOB_ID              = P_SOB_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_RECORD_COUNT := 0;
    END;
    IF V_RECORD_COUNT <> 0 THEN
      RAISE ERRNUMS.Exist_Data;
    END IF;

    V_SYSDATE := GET_LOCAL_DATE(P_SOB_ID);

    SELECT FI_DOCUMENT_NUM_S1.NEXTVAL
      INTO P_DOCUMENT_NUM_ID
      FROM DUAL;

    INSERT INTO FI_DOCUMENT_NUM
    ( DOCUMENT_NUM_ID
    , SOB_ID
    , DOCUMENT_TYPE
    , DESCRIPTION
    , PREFIX_CHAR
    , PREFIX_SEPARATE
    , DATE_TYPE
    , SEQ_SEPARATE
    , SEQ_COUNT
    , CREATION_DATE
    , CREATED_BY
    , LAST_UPDATE_DATE
    , LAST_UPDATED_BY )
    VALUES
    ( P_DOCUMENT_NUM_ID
    , P_SOB_ID
    , P_DOCUMENT_TYPE
    , P_DESCRIPTION
    , P_PREFIX_CHAR
    , P_PREFIX_SEPARATE
    , P_DATE_TYPE
    , P_SEQ_SEPARATE
    , P_SEQ_COUNT
    , V_SYSDATE
    , P_USER_ID
    , V_SYSDATE
    , P_USER_ID );

  END INSERT_DOCUMENT_NUM;

-- ��ǥ��ȣ ����.
  PROCEDURE UPDATE_DOCUMENT_NUM
            ( W_DOCUMENT_NUM_ID  IN FI_DOCUMENT_NUM.DOCUMENT_NUM_ID%TYPE
            , P_SOB_ID           IN FI_DOCUMENT_NUM.SOB_ID%TYPE
            , P_DESCRIPTION      IN FI_DOCUMENT_NUM.DESCRIPTION%TYPE
            , P_PREFIX_CHAR      IN FI_DOCUMENT_NUM.PREFIX_CHAR%TYPE
            , P_PREFIX_SEPARATE  IN FI_DOCUMENT_NUM.PREFIX_SEPARATE%TYPE
            , P_DATE_TYPE        IN FI_DOCUMENT_NUM.DATE_TYPE%TYPE
            , P_SEQ_SEPARATE     IN FI_DOCUMENT_NUM.SEQ_SEPARATE%TYPE
            , P_SEQ_COUNT        IN FI_DOCUMENT_NUM.SEQ_COUNT%TYPE
            , P_USER_ID          IN FI_DOCUMENT_NUM.CREATED_BY%TYPE
            )
  AS
    V_SYSDATE                    FI_DOCUMENT_NUM.CREATION_DATE%TYPE;

  BEGIN
    V_SYSDATE := GET_LOCAL_DATE(P_SOB_ID);

    UPDATE FI_DOCUMENT_NUM
      SET DESCRIPTION      = P_DESCRIPTION
        , PREFIX_CHAR      = P_PREFIX_CHAR
        , PREFIX_SEPARATE  = P_PREFIX_SEPARATE
        , DATE_TYPE        = P_DATE_TYPE
        , SEQ_SEPARATE     = P_SEQ_SEPARATE
        , SEQ_COUNT        = P_SEQ_COUNT
        , LAST_UPDATE_DATE = V_SYSDATE
        , LAST_UPDATED_BY  = P_USER_ID
    WHERE DOCUMENT_NUM_ID  = W_DOCUMENT_NUM_ID;

  END UPDATE_DOCUMENT_NUM;

-- ������ȣ LOOKUP ��ȸ.
  PROCEDURE LU_DOCUMENT_NUM
            ( P_CURSOR3              OUT TYPES.TCURSOR3
            , W_SOB_ID               IN FI_BANK.SOB_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR3 FOR
      SELECT FDN.DESCRIPTION
           , FDN.DOCUMENT_NUM_ID
        FROM FI_DOCUMENT_NUM FDN
       WHERE FDN.SOB_ID                 = W_SOB_ID
      ORDER BY FDN.DOCUMENT_TYPE
     ;

  END LU_DOCUMENT_NUM;

-- ������ȣ ����.
  FUNCTION DOCUMENT_NUM_F
            ( W_DOCUMENT_TYPE         IN FI_DOCUMENT_NUM.DOCUMENT_TYPE%TYPE
            , W_SOB_ID                IN FI_DOCUMENT_NUM.SOB_ID%TYPE
            , P_STD_DATE              IN DATE
            , P_USER_ID               IN FI_DOCUMENT_NUM.CREATED_BY%TYPE
            ) RETURN VARCHAR2
  AS
    V_SYSDATE                         DATE := GET_LOCAL_DATE(W_SOB_ID);
    V_DATE_TYPE_VALUE                 FI_DOCUMENT_NUM_HISTORY.DATE_TYPE_VALUE%TYPE := NULL;
    V_MAX_DOCUMENT_SEQ                NUMBER := 0;
    V_DOCUMENT_NUM                    FI_DOCUMENT_NUM_HISTORY.DOCUMENT_NUM%TYPE;

  BEGIN
    IF W_DOCUMENT_TYPE IS NULL THEN
      RETURN NULL;  
    END IF;
    
    BEGIN
      SELECT TO_CHAR(P_STD_DATE, DN.DATE_TYPE)
        INTO V_DATE_TYPE_VALUE
        FROM FI_DOCUMENT_NUM DN
      WHERE DN.DOCUMENT_TYPE          = W_DOCUMENT_TYPE
        AND DN.SOB_ID                 = W_SOB_ID
     ;
    EXCEPTION WHEN OTHERS THEN
      V_DATE_TYPE_VALUE := TO_CHAR(P_STD_DATE, 'YYYYMMDD');
    END;

    -- ���� ���� �Ϸù�ȣ --
    BEGIN
      SELECT NVL(MAX(NH.MAX_DOCUMENT_SEQ), 0) + 1 AS MAX_DOCUMENT_SEQ
        INTO V_MAX_DOCUMENT_SEQ
        FROM FI_DOCUMENT_NUM_HISTORY NH
      WHERE NH.DOCUMENT_TYPE        = W_DOCUMENT_TYPE
        AND NH.SOB_ID               = W_SOB_ID
        AND NH.DATE_TYPE_VALUE      = V_DATE_TYPE_VALUE
      ;
    EXCEPTION WHEN OTHERS THEN
      V_MAX_DOCUMENT_SEQ := 1;
    END;

-------------------------------------------------------------------------
-- ������ȣ ä��.
    BEGIN
      SELECT DECODE(DN.PREFIX_CHAR, NULL, NULL, DN.PREFIX_CHAR) ||
             DECODE(DN.PREFIX_SEPARATE, NULL, NULL, DN.PREFIX_SEPARATE) ||
             DECODE(DN.DATE_TYPE, NULL, NULL, V_DATE_TYPE_VALUE) ||
             DECODE(DN.SEQ_SEPARATE, NULL, NULL, DN.SEQ_SEPARATE) ||
             DECODE(DN.SEQ_COUNT, NULL, NULL, LPAD(V_MAX_DOCUMENT_SEQ, DN.SEQ_COUNT, '0')) AS DOCUMENT_NUM
        INTO V_DOCUMENT_NUM
        FROM FI_DOCUMENT_NUM DN
       WHERE DN.DOCUMENT_TYPE           = W_DOCUMENT_TYPE
         AND DN.SOB_ID                  = W_SOB_ID
       ;
    EXCEPTION WHEN OTHERS THEN
      NULL;
    END;
-------------------------------------------------------------------------

    BEGIN
      UPDATE FI_DOCUMENT_NUM_HISTORY DNH
        SET   DNH.YEAR_CHAR          = TO_CHAR(P_STD_DATE, 'YYYY')
            , DNH.MONTH_CHAR         = TO_CHAR(P_STD_DATE, 'MM')
            , DNH.DAY_CHAR           = TO_CHAR(P_STD_DATE, 'DD')
            , DNH.MAX_DOCUMENT_SEQ   = V_MAX_DOCUMENT_SEQ
            , DNH.DOCUMENT_NUM       = V_DOCUMENT_NUM
            , DNH.LAST_UPDATE_DATE   = V_SYSDATE
            , DNH.LAST_UPDATED_BY    = P_USER_ID
      WHERE DNH.DOCUMENT_TYPE        = W_DOCUMENT_TYPE
        AND DNH.SOB_ID               = W_SOB_ID
        AND DNH.DATE_TYPE_VALUE      = V_DATE_TYPE_VALUE
      ;
      IF (SQL%ROWCOUNT < 1) THEN
        INSERT INTO FI_DOCUMENT_NUM_HISTORY
        ( DOCUMENT_NUM_ID, SOB_ID
        , DOCUMENT_TYPE, DATE_TYPE_VALUE
        , YEAR_CHAR, MONTH_CHAR, DAY_CHAR
        , MAX_DOCUMENT_SEQ
        , DOCUMENT_NUM
        , CREATION_DATE, CREATED_BY
        , LAST_UPDATE_DATE, LAST_UPDATED_BY
        )
        SELECT DN.DOCUMENT_NUM_ID
             , W_SOB_ID
             , DN.DOCUMENT_TYPE
             , V_DATE_TYPE_VALUE
             , TO_CHAR(P_STD_DATE, 'YYYY') AS YEAR_CHAR
             , TO_CHAR(P_STD_DATE, 'MM') AS MONTH_CHAR
             , TO_CHAR(P_STD_DATE, 'DD') AS DAY_CHAR
             , V_MAX_DOCUMENT_SEQ AS MAX_DOCUMENT_SEQ
             , V_DOCUMENT_NUM AS DOCUMENT_NUM
             , V_SYSDATE AS CREATION_DATE
             , P_USER_ID AS CREATED_BY
             , V_SYSDATE AS LAST_UPDATE_DATE
             , P_USER_ID AS LAST_UPDATED_BY
          FROM FI_DOCUMENT_NUM DN
        WHERE DN.DOCUMENT_TYPE  = W_DOCUMENT_TYPE
          AND DN.SOB_ID         = W_SOB_ID
        ;
      END IF;
    EXCEPTION WHEN OTHERS THEN
      NULL;
    END;

    RETURN V_DOCUMENT_NUM;

  END DOCUMENT_NUM_F;

-- ������ȣ ����(���ν���).
  PROCEDURE DOCUMENT_NUM_P
            ( W_DOCUMENT_TYPE         IN FI_DOCUMENT_NUM.DOCUMENT_TYPE%TYPE
            , W_SOB_ID                IN FI_DOCUMENT_NUM.SOB_ID%TYPE
            , P_STD_DATE              IN DATE
            , P_USER_ID               IN FI_DOCUMENT_NUM.CREATED_BY%TYPE
            , O_DOCUMENT_NUM          OUT FI_DOCUMENT_NUM_HISTORY.DOCUMENT_NUM%TYPE
            )
  AS
  BEGIN
    O_DOCUMENT_NUM := DOCUMENT_NUM_F( W_DOCUMENT_TYPE => W_DOCUMENT_TYPE
                                    , W_SOB_ID => W_SOB_ID
                                    , P_STD_DATE => P_STD_DATE
                                    , P_USER_ID => P_USER_ID
                                    );
  END DOCUMENT_NUM_P;

END FI_DOCUMENT_NUM_G; 
/
