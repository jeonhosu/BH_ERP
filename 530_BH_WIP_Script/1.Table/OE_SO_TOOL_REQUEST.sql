/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : SCM
/* Program Name : OE_SO_TOOL_REQUEST
/* Description  : 치공구수주 요청정보.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE OE_SO_TOOL_REQUEST
( ORDER_LINE_ID               NUMBER        NOT NULL,    -- 수주LINE ID.
  TOOL_CLASS_ID               NUMBER        NOT NULL,    -- 치공구유형 ID.
  SOB_ID                      NUMBER        NOT NULL,
  ORG_ID                      NUMBER        NOT NULL,
  REQUEST_FLAG                VARCHAR2(1)   DEFAULT 'N',
  TOOL_AMOUNT                 NUMBER        ,
  REMARK                      VARCHAR2(200) ,
  ATTRIBUTE_A                 VARCHAR2(250) ,    
  ATTRIBUTE_B                 VARCHAR2(250) ,    
  ATTRIBUTE_C                 VARCHAR2(250) ,    
  ATTRIBUTE_D                 VARCHAR2(250) ,    
  ATTRIBUTE_E                 VARCHAR2(250) ,    
  ATTRIBUTE_1                 NUMBER        ,    
  ATTRIBUTE_2                 NUMBER        ,    
  ATTRIBUTE_3                 NUMBER        ,    
  ATTRIBUTE_4                 NUMBER        ,
  ATTRIBUTE_5                 NUMBER        ,
  CREATION_DATE               DATE          NOT NULL,  -- 생성자.
  CREATED_BY                  NUMBER        NOT NULL,  -- 생성일.
  LAST_UPDATE_DATE            DATE          NOT NULL,  -- 수정자.
  LAST_UPDATED_BY             NUMBER        NOT NULL   -- 수정일.
) TABLESPACE SCM_TS_DATA;

COMMENT ON TABLE OE_SO_TOOL_REQUEST IS '치공구수주 요청정보';
COMMENT ON COLUMN OE_SO_TOOL_REQUEST.ORDER_LINE_ID IS '수주LINE ID';
COMMENT ON COLUMN OE_SO_TOOL_REQUEST.TOOL_CLASS_ID IS '치공구유형 ID(SDM_TOOL_CLASS)';
COMMENT ON COLUMN OE_SO_TOOL_REQUEST.REQUEST_FLAG IS '제작여부';
COMMENT ON COLUMN OE_SO_TOOL_REQUEST.TOOL_AMOUNT IS '금액';
COMMENT ON COLUMN OE_SO_TOOL_REQUEST.REMARK IS '적요';

-- INDEX.
ALTER TABLE OE_SO_TOOL_REQUEST ADD CONSTRAINT OE_SO_TOOL_REQUEST PRIMARY KEY(ORDER_LINE_ID, TOOL_CLASS_ID, SOB_ID, ORG_ID);
