/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRD_OT_LINE
/* Description  : 연장근무신청 라인 관리
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRD_OT_LINE              
( OT_LINE_ID                          NUMBER        NOT NULL,
  OT_HEADER_ID                        NUMBER        NOT NULL,
  REQ_NUM	                            VARCHAR2(50)  NOT NULL,
  LINE_SEQ                            NUMBER        ,	
  PERSON_ID	                          NUMBER        NOT NULL,
  WORK_DATE	                          DATE          NOT NULL,
  BEFORE_OT_START	                    DATE          ,
  BEFORE_OT_END	                      DATE          ,
  AFTER_OT_START	                    DATE          ,	
  AFTER_OT_END	                      DATE          ,
  LUNCH_YN	                          CHAR(1)       DEFAULT 'N',
  DINNER_YN	                          CHAR(1)       DEFAULT 'N',
  MIDNIGHT_YN	                        CHAR(1)       DEFAULT 'N',
  DANGJIK_YN	                        CHAR(1)       DEFAULT 'N',
  ALL_NIGHT_YN	                      CHAR(1)       DEFAULT 'N',
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
  REJECT_REMARK                       VARCHAR2(200) ,
  ATTRIBUTE1                          VARCHAR2(100) ,
  ATTRIBUTE2                          VARCHAR2(100) ,
  ATTRIBUTE3                          VARCHAR2(100) ,
  ATTRIBUTE4                          VARCHAR2(100) ,
  ATTRIBUTE5                          VARCHAR2(100) ,
  CREATION_DATE                       DATE          NOT NULL,
  CREATED_BY                          NUMBER        NOT NULL,
  LAST_UPDATE_DATE                    DATE          NOT NULL,
  LAST_UPDATED_BY                     NUMBER        NOT NULL
) TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON COLUMN HRD_OT_LINE.OT_LINE_ID IS '신청 LINE ID';
COMMENT ON COLUMN HRD_OT_LINE.OT_HEADER_ID IS '신청 HEADER ID';
COMMENT ON COLUMN HRD_OT_LINE.REQ_NUM IS '신청번호(년월-XXX)';
COMMENT ON COLUMN HRD_OT_LINE.LINE_SEQ IS '신청LINE 일련번호';
COMMENT ON COLUMN HRD_OT_LINE.PERSON_ID IS '사원번호';
COMMENT ON COLUMN HRD_OT_LINE.WORK_DATE IS '근무일자';
COMMENT ON COLUMN HRD_OT_LINE.BEFORE_OT_START IS '근무전 연장 시작시간';
COMMENT ON COLUMN HRD_OT_LINE.BEFORE_OT_END IS '근무전 연장 종료시간';
COMMENT ON COLUMN HRD_OT_LINE.AFTER_OT_START IS '근무후 연장 시작시간';
COMMENT ON COLUMN HRD_OT_LINE.AFTER_OT_END IS '근무후 연장 종료시간';
COMMENT ON COLUMN HRD_OT_LINE.LUNCH_YN IS '중식연장 여부';
COMMENT ON COLUMN HRD_OT_LINE.DINNER_YN IS '석식연장 여부';
COMMENT ON COLUMN HRD_OT_LINE.MIDNIGHT_YN IS '야식연장 여부';
COMMENT ON COLUMN HRD_OT_LINE.DANGJIK_YN IS '당직 여부';
COMMENT ON COLUMN HRD_OT_LINE.ALL_NIGHT_YN IS '철야 여부';
COMMENT ON COLUMN HRD_OT_LINE.APPROVED_YN IS '현업승인구분';
COMMENT ON COLUMN HRD_OT_LINE.APPROVED_DATE IS '현업 승인일시';
COMMENT ON COLUMN HRD_OT_LINE.APPROVED_PERSON_ID IS '현업 승인자';
COMMENT ON COLUMN HRD_OT_LINE.CONFIRMED_YN IS '확정승인구분-승인시 근무카렌다 반영';
COMMENT ON COLUMN HRD_OT_LINE.CONFIRMED_DATE IS '확정승인일시';
COMMENT ON COLUMN HRD_OT_LINE.CONFIRMED_PERSON_ID IS '확정승인자';
COMMENT ON COLUMN HRD_OT_LINE.APPROVE_STATUS IS '승인상태(N-승인미요청,A-미승인,B-현업승인,C-확정승인,R-반려)';
COMMENT ON COLUMN HRD_OT_LINE.EMAIL_STATUS IS 'EMAIL 발송여부(N-미발송,AR/BR-발송준비,AS/BS-발송완료)';
COMMENT ON COLUMN HRD_OT_LINE.CALENDAR_TRAN_YN IS '근무카렌다 전송 구분';
COMMENT ON COLUMN HRD_OT_LINE.DESCRIPTION IS '비고';
COMMENT ON COLUMN HRD_OT_LINE.REJECT_YN IS '반려 여부';
COMMENT ON COLUMN HRD_OT_LINE.REJECT_DATE IS '반려 일시';
COMMENT ON COLUMN HRD_OT_LINE.REJECT_PERSON_ID IS '반려 처리자'
COMMENT ON COLUMN HRD_OT_LINE.REJECT_REMARK IS '반려사유';
COMMENT ON COLUMN HRD_OT_LINE.CREATION_DATE  IS '생성일자';
COMMENT ON COLUMN HRD_OT_LINE.CREATION_DATE  IS '생성일자';
COMMENT ON COLUMN HRD_OT_LINE.CREATED_BY IS '생성자';
COMMENT ON COLUMN HRD_OT_LINE.LAST_UPDATE_DATE IS '최종수정일자';
COMMENT ON COLUMN HRD_OT_LINE.LAST_UPDATED_BY IS '최종수정자';

-- CREATE INDEX.
CREATE UNIQUE INDEX HRD_OT_LINE_U1 ON HRD_OT_LINE(OT_LINE_ID) TABLESPACE FCM_TS_IDX;
CREATE UNIQUE INDEX HRD_OT_LINE_U2 ON HRD_OT_LINE(REQ_NUM, PERSON_ID, WORK_DATE) TABLESPACE FCM_TS_IDX;
CREATE INDEX HRD_OT_LINE_N1 ON HRD_OT_LINE(PERSON_ID, WORK_DATE) TABLESPACE FCM_TS_IDX;

-- SEQUENCE.
DROP SEQUENCE HRD_OT_LINE_S1;
CREATE SEQUENCE HRD_OT_LINE_S1;

-- ANALYZE.
ANALYZE TABLE HRD_OT_LINE COMPUTE STATISTICS;
ANALYZE INDEX HRD_OT_LINE_U1 COMPUTE STATISTICS;
ANALYZE INDEX HRD_OT_LINE_N1 COMPUTE STATISTICS;
