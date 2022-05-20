/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRD_DUTY_PERIOD_INTERFACE
/* Description  : 고정근태 관리 INTERFACE TABLE
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRD_DUTY_PERIOD_INTERFACE
( PERSON_NUM                                      VARCHAR2(20) NOT NULL,
  GW_DUTY_CODE                                    VARCHAR2(20) NOT NULL,
  START_DATE                                      DATE NOT NULL,  
  END_DATE                                        DATE NOT NULL,    
  CORP_ID                                         NUMBER NOT NULL,
  APPROVED_YN                                     CHAR(1) DEFAULT 'N',
  APPROVED_DATE                                   DATE, 
  APPROVED_PERSON_NUM                             VARCHAR2(20),
  CONFIRMED_YN                                    CHAR(1) DEFAULT 'N',
  CONFIRMED_DATE                                  DATE,
  CONFIRMED_PERSON_NUM                            VARCHAR2(20),
  APPROVE_STATUS                                  CHAR(1) DEFAULT 'A',
  TRAN_YN                                         CHAR(1) DEFAULT 'N',
  DESCRIPTION                                     VARCHAR2(100),
  ATTRIBUTE1                                      VARCHAR2(100),
  ATTRIBUTE2                                      VARCHAR2(100),
  ATTRIBUTE3                                      VARCHAR2(100),
  ATTRIBUTE4                                      VARCHAR2(100),
  ATTRIBUTE5                                      VARCHAR2(100),
  SOB_ID                                          NUMBER,
  ORG_ID                                          NUMBER,
  CREATION_DATE                                   DATE NOT NULL,
  CREATED_BY                                      NUMBER NOT NULL,
  LAST_UPDATE_DATE                                DATE NOT NULL,
  LAST_UPDATED_BY                                 NUMBER NOT NULL
) TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON TABLE HRD_DUTY_PERIOD_INTERFACE IS '고정근태 그룹웨어 INTERFACE';
COMMENT ON COLUMN HRD_DUTY_PERIOD_INTERFACE.PERSON_NUM IS '사원번호';
COMMENT ON COLUMN HRD_DUTY_PERIOD_INTERFACE.GW_DUTY_CODE IS '그룹웨어 근태 CODE';
COMMENT ON COLUMN HRD_DUTY_PERIOD_INTERFACE.START_DATE IS '시작일자';
COMMENT ON COLUMN HRD_DUTY_PERIOD_INTERFACE.END_DATE IS '종료일자';
COMMENT ON COLUMN HRD_DUTY_PERIOD_INTERFACE.APPROVED_YN IS '1차 승인구분';
COMMENT ON COLUMN HRD_DUTY_PERIOD_INTERFACE.APPROVED_DATE IS '1차 승인일시';
COMMENT ON COLUMN HRD_DUTY_PERIOD_INTERFACE.APPROVED_PERSON_NUM IS '1차 승인자';
COMMENT ON COLUMN HRD_DUTY_PERIOD_INTERFACE.CONFIRMED_YN IS '확정승인구분-승인시 근무카렌다 반영';
COMMENT ON COLUMN HRD_DUTY_PERIOD_INTERFACE.CONFIRMED_DATE IS '확정승인일시';
COMMENT ON COLUMN HRD_DUTY_PERIOD_INTERFACE.CONFIRMED_PERSON_NUM IS '확정승인자';
COMMENT ON COLUMN HRD_DUTY_PERIOD_INTERFACE.APPROVE_STATUS IS '승인 상태(A-미승인,B-1차승인, C-확정승인)';
COMMENT ON COLUMN HRD_DUTY_PERIOD_INTERFACE.TRAN_YN IS '고정근태 반영 구분';
COMMENT ON COLUMN HRD_DUTY_PERIOD_INTERFACE.DESCRIPTION IS '비고(사유)';
COMMENT ON COLUMN HRD_DUTY_PERIOD_INTERFACE.ATTRIBUTE5 IS '근태코드';
COMMENT ON COLUMN HRD_DUTY_PERIOD_INTERFACE.CREATION_DATE  IS '생성일자';
COMMENT ON COLUMN HRD_DUTY_PERIOD_INTERFACE.CREATED_BY IS '생성자';
COMMENT ON COLUMN HRD_DUTY_PERIOD_INTERFACE.LAST_UPDATE_DATE IS '최종수정일자';
COMMENT ON COLUMN HRD_DUTY_PERIOD_INTERFACE.LAST_UPDATED_BY IS '최종수정자';

-- CREATE INDEX.
CREATE UNIQUE INDEX HRD_DUTY_PERIOD_INTERFACE_U1 ON HRD_DUTY_PERIOD_INTERFACE(PERSON_NUM, GW_DUTY_CODE, START_DATE, END_DATE, CORP_ID, SOB_ID, ORG_ID) TABLESPACE FCM_TS_IDX;

-- ANALYZE.
ANALYZE TABLE HRD_DUTY_PERIOD_INTERFACE COMPUTE STATISTICS;
ANALYZE INDEX HRD_DUTY_PERIOD_INTERFACE_U1 COMPUTE STATISTICS;
