CREATE OR REPLACE PACKAGE OE_SO_TOOL_REQUEST_G
AS

-- 치공구요청 상세 조회.
  PROCEDURE SELECT_TOOL_REQUEST
            ( P_CURSOR            OUT TYPES.TCURSOR
            , P_ORDER_LINE_ID     IN OE_SO_TOOL_REQUEST.ORDER_LINE_ID%TYPE
            , P_SOB_ID            IN OE_SO_TOOL_REQUEST.SOB_ID%TYPE
            , P_ORG_ID            IN OE_SO_TOOL_REQUEST.ORG_ID%TYPE
            );
            
-- 치공구요청 저장.
  PROCEDURE SAVE_TOOL_REQUEST
            ( P_ORDER_LINE_ID IN OE_SO_TOOL_REQUEST.ORDER_LINE_ID%TYPE
            , P_TOOL_CLASS_ID IN OE_SO_TOOL_REQUEST.TOOL_CLASS_ID%TYPE
            , P_SOB_ID        IN OE_SO_TOOL_REQUEST.SOB_ID%TYPE
            , P_ORG_ID        IN OE_SO_TOOL_REQUEST.ORG_ID%TYPE
            , P_REQUEST_FLAG  IN OE_SO_TOOL_REQUEST.REQUEST_FLAG%TYPE
            , P_TOOL_AMOUNT   IN OE_SO_TOOL_REQUEST.TOOL_AMOUNT%TYPE
            , P_REMARK        IN OE_SO_TOOL_REQUEST.REMARK%TYPE
            , P_USER_ID       IN OE_SO_TOOL_REQUEST.CREATED_BY%TYPE 
            );

-- 치공구요청 삭제.
  PROCEDURE DELETE_TOOL_REQUEST
            ( P_ORDER_LINE_ID IN OE_SO_TOOL_REQUEST.ORDER_LINE_ID%TYPE
            , P_TOOL_CLASS_ID IN OE_SO_TOOL_REQUEST.TOOL_CLASS_ID%TYPE
            , P_SOB_ID        IN OE_SO_TOOL_REQUEST.SOB_ID%TYPE
            , P_ORG_ID        IN OE_SO_TOOL_REQUEST.ORG_ID%TYPE
            );

-- 수주라인 치공구 제작의뢰 동기화.
  PROCEDURE SET_ORDER_LINE_TOOL_MAKE
            ( P_ORDER_LINE_ID IN OE_SO_TOOL_REQUEST.ORDER_LINE_ID%TYPE
            , P_SOB_ID        IN OE_SO_TOOL_REQUEST.SOB_ID%TYPE
            , P_ORG_ID        IN OE_SO_TOOL_REQUEST.ORG_ID%TYPE
            );
            
END OE_SO_TOOL_REQUEST_G;
/
CREATE OR REPLACE PACKAGE BODY OE_SO_TOOL_REQUEST_G
AS
/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : SCM
/* Program Name : OE_SO_TOOL_REQUEST_G
/* Description  : 치공구수주 - 요청사항
/*
/* Reference by :
/* Program History :
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
-- 치공구요청 상세 조회.
  PROCEDURE SELECT_TOOL_REQUEST
            ( P_CURSOR            OUT TYPES.TCURSOR
            , P_ORDER_LINE_ID     IN OE_SO_TOOL_REQUEST.ORDER_LINE_ID%TYPE
            , P_SOB_ID            IN OE_SO_TOOL_REQUEST.SOB_ID%TYPE
            , P_ORG_ID            IN OE_SO_TOOL_REQUEST.ORG_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR FOR
      SELECT TC.TOOL_CLASS_ID
           , TC.TOOL_CLASS_CODE
           , TC.TOOL_CLASS_DESCRIPTION
           , NVL(STR.REQUEST_FLAG, 'N') AS REQUEST_FLAG
           , STR.TOOL_AMOUNT
           , STR.REMARK
           , NVL(STR.ORDER_LINE_ID, P_ORDER_LINE_ID) AS ORDER_LINE_ID
        FROM SDM_TOOL_CLASS TC
          , ( SELECT TR.ORDER_LINE_ID
                   , TR.TOOL_CLASS_ID
                   , TR.SOB_ID
                   , TR.ORG_ID
                   , TR.REQUEST_FLAG
                   , TR.TOOL_AMOUNT
                   , TR.REMARK
                FROM OE_SO_TOOL_REQUEST TR
              WHERE TR.ORDER_LINE_ID    = P_ORDER_LINE_ID
                AND TR.SOB_ID           = P_SOB_ID
                AND TR.ORG_ID           = P_ORG_ID
            ) STR
      WHERE TC.TOOL_CLASS_ID            = STR.TOOL_CLASS_ID(+)
        AND TC.SOB_ID                   = STR.SOB_ID(+)
        AND TC.ORG_ID                   = STR.ORG_ID(+)
        AND TC.ENABLED_FLAG             = 'Y'
        AND TC.SOB_ID                   = P_SOB_ID
        AND TC.ORG_ID                   = P_ORG_ID
      ORDER BY TC.ATTRIBUTE_1
      ;
  END SELECT_TOOL_REQUEST;

-- 치공구요청 저장.
  PROCEDURE SAVE_TOOL_REQUEST
            ( P_ORDER_LINE_ID IN OE_SO_TOOL_REQUEST.ORDER_LINE_ID%TYPE
            , P_TOOL_CLASS_ID IN OE_SO_TOOL_REQUEST.TOOL_CLASS_ID%TYPE
            , P_SOB_ID        IN OE_SO_TOOL_REQUEST.SOB_ID%TYPE
            , P_ORG_ID        IN OE_SO_TOOL_REQUEST.ORG_ID%TYPE
            , P_REQUEST_FLAG  IN OE_SO_TOOL_REQUEST.REQUEST_FLAG%TYPE
            , P_TOOL_AMOUNT   IN OE_SO_TOOL_REQUEST.TOOL_AMOUNT%TYPE
            , P_REMARK        IN OE_SO_TOOL_REQUEST.REMARK%TYPE
            , P_USER_ID       IN OE_SO_TOOL_REQUEST.CREATED_BY%TYPE 
            )
  AS
    V_SYSDATE           DATE := GET_LOCAL_DATE(P_SOB_ID);
  BEGIN
    UPDATE OE_SO_TOOL_REQUEST TR
      SET REQUEST_FLAG     = NVL(P_REQUEST_FLAG, 'N')
        , TOOL_AMOUNT      = NVL(P_TOOL_AMOUNT, 0)
        , REMARK           = P_REMARK
        , LAST_UPDATE_DATE = V_SYSDATE
        , LAST_UPDATED_BY  = P_USER_ID
    WHERE TR.ORDER_LINE_ID = P_ORDER_LINE_ID
      AND TR.TOOL_CLASS_ID = P_TOOL_CLASS_ID
      AND TR.SOB_ID        = P_SOB_ID
      AND TR.ORG_ID        = P_ORG_ID
    ;    
    IF SQL%ROWCOUNT = 0 THEN
      INSERT INTO OE_SO_TOOL_REQUEST
      ( ORDER_LINE_ID
      , TOOL_CLASS_ID 
      , SOB_ID 
      , ORG_ID 
      , REQUEST_FLAG 
      , TOOL_AMOUNT 
      , REMARK 
      , CREATION_DATE 
      , CREATED_BY 
      , LAST_UPDATE_DATE 
      , LAST_UPDATED_BY )
      VALUES
      ( P_ORDER_LINE_ID
      , P_TOOL_CLASS_ID
      , P_SOB_ID
      , P_ORG_ID
      , NVL(P_REQUEST_FLAG, 'N')
      , NVL(P_TOOL_AMOUNT, 0)
      , P_REMARK
      , V_SYSDATE
      , P_USER_ID
      , V_SYSDATE
      , P_USER_ID );
    END IF;
    
    -- 수주라인 치공구 제작의뢰 UPDATE.
    SET_ORDER_LINE_TOOL_MAKE
      ( P_ORDER_LINE_ID
      , P_SOB_ID
      , P_ORG_ID     
      );
  END SAVE_TOOL_REQUEST;

-- 치공구요청 삭제.
  PROCEDURE DELETE_TOOL_REQUEST
            ( P_ORDER_LINE_ID IN OE_SO_TOOL_REQUEST.ORDER_LINE_ID%TYPE
            , P_TOOL_CLASS_ID IN OE_SO_TOOL_REQUEST.TOOL_CLASS_ID%TYPE
            , P_SOB_ID        IN OE_SO_TOOL_REQUEST.SOB_ID%TYPE
            , P_ORG_ID        IN OE_SO_TOOL_REQUEST.ORG_ID%TYPE
            )
  AS
  BEGIN
    DELETE FROM OE_SO_TOOL_REQUEST TR
    WHERE TR.ORDER_LINE_ID = P_ORDER_LINE_ID
      AND TR.TOOL_CLASS_ID = P_TOOL_CLASS_ID
      AND TR.SOB_ID        = P_SOB_ID
      AND TR.ORG_ID        = P_ORG_ID
    ;
    -- 수주라인 치공구 제작의뢰 UPDATE.
    SET_ORDER_LINE_TOOL_MAKE
      ( P_ORDER_LINE_ID
      , P_SOB_ID
      , P_ORG_ID     
      );
  END DELETE_TOOL_REQUEST;

-- 수주라인 치공구 제작의뢰 동기화.
  PROCEDURE SET_ORDER_LINE_TOOL_MAKE
            ( P_ORDER_LINE_ID IN OE_SO_TOOL_REQUEST.ORDER_LINE_ID%TYPE
            , P_SOB_ID        IN OE_SO_TOOL_REQUEST.SOB_ID%TYPE
            , P_ORG_ID        IN OE_SO_TOOL_REQUEST.ORG_ID%TYPE
            )
  AS
    V_RECORD_COUNT            NUMBER := 0;
    V_TOOL_MAKE_YN            OE_SALES_ORDER_LINE.TOOL_MAKING_FLAG%TYPE;
  BEGIN
    BEGIN
      SELECT COUNT(TR.ORDER_LINE_ID) AS MAKING_COUNT
        INTO V_RECORD_COUNT
        FROM OE_SO_TOOL_REQUEST TR
      WHERE TR.ORDER_LINE_ID        = P_ORDER_LINE_ID
        AND TR.SOB_ID               = P_SOB_ID
        AND TR.ORG_ID               = P_ORG_ID
        AND TR.REQUEST_FLAG         = 'Y'
      ;
    EXCEPTION WHEN OTHERS THEN
      V_RECORD_COUNT := 0;
    END;
    V_TOOL_MAKE_YN := 'N';
    IF V_RECORD_COUNT <> 0 THEN
      V_TOOL_MAKE_YN := 'Y';
    END IF;
    -- 수주라인 UPDATE.
    UPDATE OE_SALES_ORDER_LINE SOL
      SET SOL.TOOL_MAKING_FLAG    = NVL(V_TOOL_MAKE_YN, 'N')
    WHERE SOL.ORDER_LINE_ID       = P_ORDER_LINE_ID
      AND SOL.SOB_ID              = P_SOB_ID
      AND SOL.ORG_ID              = P_ORG_ID
    ;
  END SET_ORDER_LINE_TOOL_MAKE;
  
END OE_SO_TOOL_REQUEST_G;
/
