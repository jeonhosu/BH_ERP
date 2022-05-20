/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRA_SAVING_INFO
/* Description  : 연말정산 저축 금액 및 공제 내역.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRA_SAVING_INFO
( SAVING_INFO_ID                  NUMBER        NOT NULL,
  YEAR_YYYY                       VARCHAR2(4)   NOT NULL,            
  SOB_ID                          NUMBER        NOT NULL,
  ORG_ID                          NUMBER        NOT NULL,
  PERSON_ID                       NUMBER        NOT NULL,                 
  SAVING_TYPE                     VARCHAR2(10)  NOT NULL,
  BANK_CODE                       VARCHAR2(10)  NOT NULL,
  ACCOUNT_NUM                     VARCHAR2(50)  NOT NULL,
  SAVING_COUNT                    NUMBER        DEFAULT 0,
  SAVING_AMOUNT                   NUMBER        DEFAULT 0,
  SAVING_DED_AMOUNT               NUMBER        DEFAULT 0,
  DESCRIPTION                     VARCHAR2(100) ,                   
  ATTRIBUTE1                      VARCHAR2(100) ,                   
  ATTRIBUTE2                      VARCHAR2(100) ,                   
  ATTRIBUTE3                      VARCHAR2(100) ,                   
  ATTRIBUTE4                      VARCHAR2(100) ,                   
  ATTRIBUTE5                      VARCHAR2(100) ,                   
  CREATION_DATE                   DATE          NOT NULL,                   
  CREATED_BY                      NUMBER        NOT NULL,                 
  LAST_UPDATE_DATE                DATE          NOT NULL,                   
  LAST_UPDATED_BY                 NUMBER        NOT NULL
) TABLESPACE FCM_TS_DATA;

--> COMMET 설정 
COMMENT ON TABLE HRA_SAVING_INFO IS '연말정산 저축공제 관리';
COMMENT ON COLUMN HRA_SAVING_INFO.SAVING_INFO_ID IS '저축공제 ID';
COMMENT ON COLUMN HRA_SAVING_INFO.YEAR_YYYY IS '정산년도';
COMMENT ON COLUMN HRA_SAVING_INFO.PERSON_ID IS '사원번호';  
COMMENT ON COLUMN HRA_SAVING_INFO.SAVING_TYPE IS '저축종류';
COMMENT ON COLUMN HRA_SAVING_INFO.BANK_CODE IS '은행코드';
COMMENT ON COLUMN HRA_SAVING_INFO.ACCOUNT_NUM IS '계좌번호';
COMMENT ON COLUMN HRA_SAVING_INFO.SAVING_COUNT IS '횟수';
COMMENT ON COLUMN HRA_SAVING_INFO.SAVING_AMOUNT IS '금액';
COMMENT ON COLUMN HRA_SAVING_INFO.SAVING_DED_AMOUNT IS '공제금액';
COMMENT ON COLUMN HRA_SAVING_INFO.DESCRIPTION IS '비고';
COMMENT ON COLUMN HRA_SAVING_INFO.CREATION_DATE IS '생성일자';
COMMENT ON COLUMN HRA_SAVING_INFO.CREATED_BY IS '생성자';
COMMENT ON COLUMN HRA_SAVING_INFO.LAST_UPDATE_DATE IS '최종 수정일시';
COMMENT ON COLUMN HRA_SAVING_INFO.LAST_UPDATED_BY IS '최종 수정자';

--> 인덱스 생성.
CREATE UNIQUE INDEX HRA_SAVING_INFO_U1 ON HRA_SAVING_INFO(SAVING_INFO_ID) TABLESPACE FCM_TS_IDX;
CREATE UNIQUE INDEX HRA_SAVING_INFO_U2 ON HRA_SAVING_INFO(YEAR_YYYY, SOB_ID, ORG_ID, PERSON_ID, SAVING_TYPE, BANK_CODE, ACCOUNT_NUM) TABLESPACE FCM_TS_IDX;
CREATE INDEX HRA_SAVING_INFO_N1 ON HRA_SAVING_INFO(YEAR_YYYY, SOB_ID, ORG_ID, PERSON_ID) TABLESPACE FCM_TS_IDX;

--> ANALYZE TABLE/INDEX;
ANALYZE TABLE HRA_SAVING_INFO COMPUTE STATISTICS;
ANALYZE INDEX HRA_SAVING_INFO_U1 COMPUTE STATISTICS;
ANALYZE INDEX HRA_SAVING_INFO_U2 COMPUTE STATISTICS;
ANALYZE INDEX HRA_SAVING_INFO_N1 COMPUTE STATISTICS;
