/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_FORM_LINE
/* Description  : 재무제표 보고서 양식 LINE.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_FORM_LINE 
( FORM_LINE_ID                    NUMBER          NOT NULL,     -- 양식 LINE ID.
  SOB_ID                          NUMBER          NOT NULL, 
  ORG_ID                          NUMBER          NOT NULL,
  FORM_HEADER_ID                  NUMBER          NOT NULL,
  JOIN_LINE_CONTROL_ID            NUMBER          NOT NULL,     -- (상/하)레벨 HEADER ID./ 계정 관리 ID    
  ITEM_SIGN_SHOW                  VARCHAR(10)     DEFAULT '+',  -- 가감 구분.
  ITEM_SIGN                       NUMBER(2)       DEFAULT 1,    -- 가감.
  ITEM_LEVEL                      NUMBER          ,             -- 양식 LEVEL.
  LAST_LEVEL_YN                   CHAR(1)         DEFAULT 'N',  -- 최종 레벨.
  JOIN_ACCOUNT_CONTROL_ID         NUMBER          DEFAULT -1,   -- 계정ID.
  JOIN_FORM_HEADER_ID             NUMBER          DEFAULT -1,   -- 상/하 레벨의 HEADER ID.
  ENABLED_FLAG                    CHAR(1)         DEFAULT 'Y',  -- 사용여부.
  EFFECTIVE_DATE_FR               DATE            NOT NULL,     -- 유효시작일자.
  EFFECTIVE_DATE_TO               DATE            ,             -- 유효종료일자.
  CREATION_DATE                   DATE            NOT NULL,
  CREATED_BY                      NUMBER          NOT NULL,
  LAST_UPDATE_DATE                DATE            NOT NULL,
  LAST_UPDATED_BY                 NUMBER          NOT NULL 
)TABLESPACE FCM_TS_DATA;

COMMENT ON TABLE FI_FORM_LINE IS '재무제표 보고서 양식 및 계산식';
COMMENT ON COLUMN APPS.FI_FORM_LINE.FORM_LINE_ID IS '재무제표 보고서 LINE ID';
COMMENT ON COLUMN APPS.FI_FORM_LINE.SOB_ID IS '회계조직';
COMMENT ON COLUMN APPS.FI_FORM_LINE.ORG_ID IS '사업부ID';
COMMENT ON COLUMN APPS.FI_FORM_LINE.FORM_HEADER_ID IS '보고서양식 HEADER ID';
COMMENT ON COLUMN APPS.FI_FORM_LINE.JOIN_LINE_CONTROL_ID IS '(상/하)레벨 HEADER ID./ 계정 관리 ID';
COMMENT ON COLUMN APPS.FI_FORM_LINE.ITEM_SIGN_SHOW IS '가감기호 DISPLAY';
COMMENT ON COLUMN APPS.FI_FORM_LINE.ITEM_SIGN IS '가감 적용';
COMMENT ON COLUMN APPS.FI_FORM_LINE.ITEM_LEVEL IS '항목 레벨';
COMMENT ON COLUMN APPS.FI_FORM_LINE.LAST_LEVEL_YN IS '최종 레벨';
COMMENT ON COLUMN APPS.FI_FORM_LINE.JOIN_ACCOUNT_CONTROL_ID IS '연결된 계정관리 ID';
COMMENT ON COLUMN APPS.FI_FORM_LINE.JOIN_FORM_HEADER_ID IS '연결된 보고서 헤더 ID';
COMMENT ON COLUMN APPS.FI_FORM_LINE.ENABLED_FLAG IS '사용여부';
COMMENT ON COLUMN APPS.FI_FORM_LINE.EFFECTIVE_DATE_FR IS '유효 시작일';
COMMENT ON COLUMN APPS.FI_FORM_LINE.EFFECTIVE_DATE_TO IS '유효 종료일';

CREATE UNIQUE INDEX FI_FORM_LINE_PK ON
  FI_FORM_LINE(FORM_HEADER_ID, JOIN_LINE_CONTROL_ID, SOB_ID)
  TABLESPACE FCM_TS_IDX
  PCTFREE 10
  INITRANS 2
  MAXTRANS 255
  LOGGING
  STORAGE (
           INITIAL 64K
           MINEXTENTS 1
           MAXEXTENTS 2147483645
          );

ALTER TABLE FI_FORM_LINE ADD ( 
  CONSTRAINT FI_FORM_LINE_PK PRIMARY KEY (FORM_HEADER_ID, JOIN_LINE_CONTROL_ID, SOB_ID)
        );
        
CREATE UNIQUE INDEX FI_FORM_LINE_U1 ON FI_FORM_LINE(FORM_LINE_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_FORM_LINE_N1 ON FI_FORM_LINE(ENABLED_FLAG, EFFECTIVE_DATE_FR, EFFECTIVE_DATE_TO) TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_FORM_LINE_N2 ON FI_FORM_LINE(JOIN_ACCOUNT_CONTROL_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_FORM_LINE_N3 ON FI_FORM_LINE(JOIN_FORM_HEADER_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_FORM_LINE_N4 ON FI_FORM_LINE(FORM_HEADER_ID) TABLESPACE FCM_TS_IDX;

-- SEQUNCE.
DROP SEQUENCE FI_FORM_LINE_S1;
CREATE SEQUENCE FI_FORM_LINE_S1;
