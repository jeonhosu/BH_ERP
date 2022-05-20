/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : EAPPS
/* Program Name : EAPP_MESSAGE
/* Description  : 메시지 테이블.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE EAPP_MESSAGE
(LANG_CODE                                            VARCHAR2(20) NOT NULL,
  MESSAGE_CODE                                     VARCHAR2(50) NOT NULL,
  MESSAGE_TEXT                                      VARCHAR2(250),
  MESSAGE_TYPE                                      VARCHAR2(50),
  CATEGORY                                            VARCHAR2(50),
  APPLICATION_CODE                                VARCHAR2(30),
  MESSAGE_NUM                                       NUMBER,
  CREATION_DATE                                    DATE NOT NULL,
  CREATED_BY                                          NUMBER NOT NULL,
  LAST_UPDATE_DATE                              DATE NOT NULL,
  LAST_UPDATED_BY                               NUMBER NOT NULL
)
  TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON COLUMN EAPP_MESSAGE.LANG_CODE IS 'LANGUAGE 코드(SYSTEM_LANGUAGE)';
COMMENT ON COLUMN EAPP_MESSAGE.MESSAGE_CODE IS '메세지 코드(모듈 + XXXXX)';
COMMENT ON COLUMN EAPP_MESSAGE.MESSAGE_TEXT IS '메세지 내용';
COMMENT ON COLUMN EAPP_MESSAGE.MESSAGE_TYPE IS '메세지 타입';
COMMENT ON COLUMN EAPP_MESSAGE.CATEGORY IS '카테고리';
COMMENT ON COLUMN EAPP_MESSAGE.APPLICATION_CODE IS '모듈 코드(SYSTEM_MODULE)';
COMMENT ON COLUMN EAPP_MESSAGE.MESSAGE_NUM IS '모듈별 일련번호';
COMMENT ON COLUMN EAPP_MESSAGE.CREATION_DATE  IS '생성일자';
COMMENT ON COLUMN EAPP_MESSAGE.CREATED_BY IS '생성자';
COMMENT ON COLUMN EAPP_MESSAGE.LAST_UPDATE_DATE IS '최종수정일자';
COMMENT ON COLUMN EAPP_MESSAGE.LAST_UPDATED_BY IS '최종수정자';

-- CREATE INDEX.
CREATE UNIQUE INDEX EAPP_MESSAGE_U1 ON EAPP_MESSAGE(LANG_CODE, MESSAGE_CODE) TABLESPACE FCM_TS_IDX;

-- ANALYZE.
ANALYZE TABLE EAPP_MESSAGE COMPUTE STATISTICS;
ANALYZE INDEX EAPP_MESSAGE_U1 COMPUTE STATISTICS;
