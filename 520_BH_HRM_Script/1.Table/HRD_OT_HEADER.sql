/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRD_OT_HEADER
/* Description  : 연장근무신청 헤더 관리
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRD_OT_HEADER              
( OT_HEADER_ID                        NUMBER        NOT NULL,
  REQ_NUM	                            VARCHAR2(10)  NOT NULL,
  REQ_TYPE	                          VARCHAR2(2)   NOT NULL,
  REQ_DATE	                          DATE          NOT NULL,	
  CORP_ID                             NUMBER        NOT NULL,
	REQ_MONTH	                          VARCHAR2(6)   ,
  REQ_SEQ	                            NUMBER        ,
	DUTY_MANAGER_ID                     NUMBER        NOT NULL, 
  REQ_PERSON_ID                       NUMBER        NOT NULL,
  APPROVED_YN	                        CHAR(1)       DEFAULT 'N',
  APPROVED_DATE	                      DATE          ,
  APPROVED_PERSON_ID                  NUMBER        ,
  CONFIRMED_YN	                      CHAR(1)       DEFAULT 'N',
  CONFIRMED_DATE	                    DATE          ,
  CONFIRMED_PERSON_ID	                NUMBER        ,
	APPROVE_STATUS                      VARCHAR2(2)   DEFAULT 'N',
  EMAIL_STATUS                        VARCHAR2(2)   DEFAULT 'N',
	CALENDAR_TRAN_YN                    CHAR(1)       DEFAULT 'N',
  DESCRIPTION                         VARCHAR2(100) ,
  REJECT_YN	                          CHAR(1)       DEFAULT 'N',
  REJECT_DATE	                        DATE          ,
  REJECT_PERSON_ID	                  NUMBER        ,
  REJECT_REMARK                       VARCHAR2(200),
  ATTRIBUTE1                          VARCHAR2(100),
  ATTRIBUTE2                          VARCHAR2(100),
  ATTRIBUTE3                          VARCHAR2(100),
  ATTRIBUTE4                          VARCHAR2(100),
  ATTRIBUTE5                          VARCHAR2(100),
	SOB_ID                              NUMBER NOT NULL,
	ORG_ID                              NUMBER NOT NULL,
  CREATION_DATE                       DATE NOT NULL,
  CREATED_BY                          NUMBER NOT NULL,
  LAST_UPDATE_DATE                    DATE NOT NULL,
  LAST_UPDATED_BY                     NUMBER NOT NULL
)
TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON COLUMN HRD_OT_HEADER.OT_HEADER_ID IS '신청 HEADER ID';
COMMENT ON COLUMN HRD_OT_HEADER.REQ_NUM IS '신청번호(년월-XXX)';
COMMENT ON COLUMN HRD_OT_HEADER.REQ_TYPE IS '신청구부(1-정상, 2-추가)';
COMMENT ON COLUMN HRD_OT_HEADER.REQ_DATE IS '신청일자';
COMMENT ON COLUMN HRD_OT_HEADER.CORP_ID IS '업체ID';
COMMENT ON COLUMN HRD_OT_HEADER.REQ_MONTH IS '신청년월(신청번호 조합위해)';
COMMENT ON COLUMN HRD_OT_HEADER.REQ_SEQ IS '신청순서(신청번호 조합위해)';
COMMENT ON COLUMN HRD_OT_HEADER.DUTY_MANAGER_ID IS '근태 관리 단위 ID';
COMMENT ON COLUMN HRD_OT_HEADER.REQ_PERSON_ID IS '신청자';
COMMENT ON COLUMN HRD_OT_HEADER.APPROVED_YN IS '현업승인구분';
COMMENT ON COLUMN HRD_OT_HEADER.APPROVED_DATE IS '현업 승인일시';
COMMENT ON COLUMN HRD_OT_HEADER.APPROVED_PERSON_ID IS '현업 승인자';
COMMENT ON COLUMN HRD_OT_HEADER.CONFIRMED_YN IS '확정승인구분-승인시 근무카렌다 반영';
COMMENT ON COLUMN HRD_OT_HEADER.CONFIRMED_DATE IS '확정승인일시';
COMMENT ON COLUMN HRD_OT_HEADER.CONFIRMED_PERSON_ID IS '확정승인자';
COMMENT ON COLUMN HRD_OT_HEADER.APPROVE_STATUS IS '승인상태(N-승인미요청,A-미승인,B-현업승인,C-확정승인,R-반려)';
COMMENT ON COLUMN HRD_OT_HEADER.EMAIL_STATUS IS 'EMAIL 발송여부(N-미발송,AR/BR-발송준비,AS/BS-발송완료)';
COMMENT ON COLUMN HRD_OT_HEADER.CALENDAR_TRAN_YN IS '근무카렌다 전송 구분';
COMMENT ON COLUMN HRD_OT_HEADER.DESCRIPTION IS '비고';
COMMENT ON COLUMN HRD_OT_HEADER.REJECT_YN IS '반려 여부';
COMMENT ON COLUMN HRD_OT_HEADER.REJECT_DATE IS '반려 일시';
COMMENT ON COLUMN HRD_OT_HEADER.REJECT_PERSON_ID IS '반려 처리자'
COMMENT ON COLUMN HRD_OT_HEADER.REJECT_REMARK IS '반려사유';
COMMENT ON COLUMN HRD_OT_HEADER.CREATION_DATE  IS '생성일자';
COMMENT ON COLUMN HRD_OT_HEADER.CREATED_BY IS '생성자';
COMMENT ON COLUMN HRD_OT_HEADER.LAST_UPDATE_DATE IS '최종수정일자';
COMMENT ON COLUMN HRD_OT_HEADER.LAST_UPDATED_BY IS '최종수정자';

-- CREATE INDEX.
CREATE UNIQUE INDEX HRD_OT_HEADER_U1 ON HRD_OT_HEADER(OT_HEADER_ID) TABLESPACE FCM_TS_IDX;
CREATE UNIQUE INDEX HRD_OT_HEADER_U2 ON HRD_OT_HEADER(REQ_NUM) TABLESPACE FCM_TS_IDX;
CREATE UNIQUE INDEX HRD_OT_HEADER_U3 ON HRD_OT_HEADER(CORP_ID, REQ_MONTH, REQ_SEQ, SOB_ID, ORG_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX HRD_OT_HEADER_N1 ON HRD_OT_HEADER(REQ_MONTH) TABLESPACE FCM_TS_IDX;
CREATE INDEX HRD_OT_HEADER_N2 ON HRD_OT_HEADER(OT_HEADER_ID, APPROVE_STATUS, SOB_ID, ORG_ID) TABLESPACE FCM_TS_IDX;

-- SEQUENCE.
DROP SEQUENCE HRD_OT_HEADER_S1; 
CREATE SEQUENCE HRD_OT_HEADER_S1;

-- ANALYZE.
ANALYZE TABLE HRD_OT_HEADER COMPUTE STATISTICS;
ANALYZE INDEX HRD_OT_HEADER_U1 COMPUTE STATISTICS;
ANALYZE INDEX HRD_OT_HEADER_U2 COMPUTE STATISTICS;
ANALYZE INDEX HRD_OT_HEADER_N1 COMPUTE STATISTICS;
