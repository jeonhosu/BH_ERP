/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_FORM_HEADER
/* Description  : 재무제표 보고서 양식 Master.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_FORM_HEADER 
( FORM_HEADER_ID                  NUMBER          NOT NULL,
  FORM_TYPE_ID                    NUMBER          NOT NULL,     -- 보고서 양식 ID
  SOB_ID                          NUMBER          NOT NULL, 
  ORG_ID                          NUMBER          NOT NULL, 
  FORM_ITEM_CODE                  VARCHAR2(30)    NOT NULL,     -- 양식 항목 코드.
  FORM_ITEM_NAME                  VARCHAR2(100)   ,             -- 양식 항목명.
  SORT_SEQ                        NUMBER          ,             -- 정렬순서.
  ITEM_LEVEL                      NUMBER          ,             -- 양식 LEVEL.
  LAST_LEVEL_YN                   CHAR(1)         DEFAULT 'N',  -- 최종 레벨.
  COLUMN_POSITION_NUM             NUMBER          ,             -- 항목 인쇄시 위치(1, 2)
  ACCOUNT_DR_CR                   CHAR(1)         ,             -- 인쇄시 차대.
  MINUS_SIGN_DISPLAY              VARCHAR2(10)    ,             -- 음수시 표시 항목.
  DISPLAY_YN                      CHAR(1)         DEFAULT 'Y',  -- 항목명 화면 표시.
  AMOUNT_PRINT_YN                 CHAR(1)         DEFAULT 'Y',  -- 금액 출력.
  UNDER_LINE_YN                   CHAR(1)         DEFAULT 'N',  -- 언더라인.
  FORM_ITEM_TYPE                  VARCHAR2(10)    ,             
  FORM_ITEM_CLASS                 VARCHAR2(10)    ,
  RELATE_HEADER_ID                NUMBER          ,
  ENABLED_FLAG                    CHAR(1)         DEFAULT 'Y',  -- 사용여부.
  EFFECTIVE_DATE_FR               DATE            NOT NULL,     -- 유효시작일자.
  EFFECTIVE_DATE_TO               DATE            ,             -- 유효종료일자.
  CREATION_DATE                   DATE            NOT NULL,
  CREATED_BY                      NUMBER          NOT NULL,
  LAST_UPDATE_DATE                DATE            NOT NULL,
  LAST_UPDATED_BY                 NUMBER          NOT NULL 
)TABLESPACE FCM_TS_DATA;

COMMENT ON TABLE FI_FORM_HEADER IS '재무제표 보고서 양식 및 계산식';
COMMENT ON COLUMN APPS.FI_FORM_HEADER.FORM_HEADER_ID IS '재무제표 보고서 ID';
COMMENT ON COLUMN APPS.FI_FORM_HEADER.FORM_TYPE_ID IS '보고서양식ID(공통코드)';
COMMENT ON COLUMN APPS.FI_FORM_HEADER.SOB_ID IS '회계조직';
COMMENT ON COLUMN APPS.FI_FORM_HEADER.ORG_ID IS '사업부ID';
COMMENT ON COLUMN APPS.FI_FORM_HEADER.FORM_ITEM_CODE IS '항목코드';
COMMENT ON COLUMN APPS.FI_FORM_HEADER.FORM_ITEM_NAME IS '항목명';
COMMENT ON COLUMN APPS.FI_FORM_HEADER.SORT_SEQ IS '정렬 순서';
COMMENT ON COLUMN APPS.FI_FORM_HEADER.ITEM_LEVEL IS '항목 레벨';
COMMENT ON COLUMN APPS.FI_FORM_HEADER.LAST_LEVEL_YN IS '최종 레벨';
COMMENT ON COLUMN APPS.FI_FORM_HEADER.COLUMN_POSITION_NUM IS '인쇄 병렬위치(1,2)';
COMMENT ON COLUMN APPS.FI_FORM_HEADER.ACCOUNT_DR_CR IS '인쇄시 차대';
COMMENT ON COLUMN APPS.FI_FORM_HEADER.MINUS_SIGN_DISPLAY IS '(-)에 대한 표시 문자';
COMMENT ON COLUMN APPS.FI_FORM_HEADER.DISPLAY_YN IS '화면 표시';
COMMENT ON COLUMN APPS.FI_FORM_HEADER.AMOUNT_PRINT_YN IS '금액 표시';
COMMENT ON COLUMN APPS.FI_FORM_HEADER.UNDER_LINE_YN IS '언더라인';
COMMENT ON COLUMN APPS.FI_FORM_HEADER.FORM_ITEM_TYPE IS '항목 타입';
COMMENT ON COLUMN APPS.FI_FORM_HEADER.FORM_ITEM_CLASS IS '항목 분류';
COMMENT ON COLUMN APPS.FI_FORM_HEADER.RELATE_HEADER_ID IS '관련 항목 헤더 ID';
COMMENT ON COLUMN APPS.FI_FORM_HEADER.ENABLED_FLAG IS '사용여부';
COMMENT ON COLUMN APPS.FI_FORM_HEADER.EFFECTIVE_DATE_FR IS '유효 시작일';
COMMENT ON COLUMN APPS.FI_FORM_HEADER.EFFECTIVE_DATE_TO IS '유효 종료일';

CREATE UNIQUE INDEX FI_FORM_HEADER_PK ON
  FI_FORM_HEADER(FORM_TYPE_ID, SOB_ID, FORM_ITEM_CODE)
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

ALTER TABLE FI_FORM_HEADER ADD ( 
  CONSTRAINT FI_FORM_HEADER_PK PRIMARY KEY (FORM_TYPE_ID, SOB_ID, FORM_ITEM_CODE)
        );
        
CREATE UNIQUE INDEX FI_FORM_HEADER_U1 ON FI_FORM_HEADER(FORM_HEADER_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_FORM_HEADER_N1 ON FI_FORM_HEADER(FORM_TYPE_ID, SOB_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_FORM_HEADER_N2 ON FI_FORM_HEADER(ENABLED_FLAG, EFFECTIVE_DATE_FR, EFFECTIVE_DATE_TO) TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_FORM_HEADER_N3 ON FI_FORM_HEADER(FORM_HEADER_ID, SORT_SEQ) TABLESPACE FCM_TS_IDX;

-- SEQUNCE.
DROP SEQUENCE FI_FORM_HEADER_S1;
CREATE SEQUENCE FI_FORM_HEADER_S1;
