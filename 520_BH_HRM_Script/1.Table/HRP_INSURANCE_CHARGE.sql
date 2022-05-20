/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRP_INSURANCE_CHARGE
/* Description  : 보험(국민,건강)료 관리
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRP_INSURANCE_CHARGE              
( PERSON_ID                                       NUMBER NOT NULL,
  CORP_ID                                         NUMBER NOT NULL,
  INSUR_TYPE                                      VARCHAR2(2) NOT NULL,
  INSUR_YN                                        VARCHAR2(1) DEFAULT 'N',
  INSUR_NO                                        VARCHAR2(50),
  INSUR_GRADE_STEP                                VARCHAR2(5),
  CORP_INSUR_AMOUNT                               NUMBER DEFAULT 0,
  CORP_INSUR_ADD_AMOUNT                           NUMBER DEFAULT 0,
  PERSON_INSUR_AMOUNT                             NUMBER DEFAULT 0,
  PERSON_INSUR_ADD_AMOUNT                         NUMBER DEFAULT 0,
  DESCRIPTION                                     VARCHAR2(100),
  ATTRIBUTE1                                      VARCHAR2(100),
  ATTRIBUTE2                                      VARCHAR2(100),
  ATTRIBUTE3                                      VARCHAR2(100),
  ATTRIBUTE4                                      VARCHAR2(100),
  ATTRIBUTE5                                      VARCHAR2(100),
  GET_DATE                                        DATE,
  LOSS_DATE                                       DATE,
  SOB_ID                                          NUMBER NOT NULL,
  ORG_ID                                          NUMBER NOT NULL,
  CREATION_DATE                                   DATE NOT NULL,
  CREATED_BY                                      NUMBER NOT NULL,
  LAST_UPDATE_DATE                                DATE NOT NULL,
  LAST_UPDATED_BY                                 NUMBER NOT NULL
) TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON COLUMN HRP_INSURANCE_CHARGE.PERSON_ID IS '사원ID';
COMMENT ON COLUMN HRP_INSURANCE_CHARGE.CORP_ID IS '업체 ID';
COMMENT ON COLUMN HRP_INSURANCE_CHARGE.INSUR_TYPE IS '보험 유형(P-국민연금, M-건강보험)';
COMMENT ON COLUMN HRP_INSURANCE_CHARGE.INSUR_YN IS '보험 적용구분';
COMMENT ON COLUMN HRP_INSURANCE_CHARGE.INSUR_NO IS '보험 번호';
COMMENT ON COLUMN HRP_INSURANCE_CHARGE.INSUR_GRADE_STEP IS '보험 등급';
COMMENT ON COLUMN HRP_INSURANCE_CHARGE.CORP_INSUR_AMOUNT IS '회사 부담 보험료';
COMMENT ON COLUMN HRP_INSURANCE_CHARGE.CORP_INSUR_ADD_AMOUNT IS '회사 부담 추가금액';
COMMENT ON COLUMN HRP_INSURANCE_CHARGE.PERSON_INSUR_AMOUNT IS '개인 부담 보험료';
COMMENT ON COLUMN HRP_INSURANCE_CHARGE.PERSON_INSUR_ADD_AMOUNT IS '개인 부담 추가금액';
COMMENT ON COLUMN HRP_INSURANCE_CHARGE.DESCRIPTION IS '비고';
COMMENT ON COLUMN HRP_INSURANCE_CHARGE.GET_DATE IS '취득일자';
COMMENT ON COLUMN HRP_INSURANCE_CHARGE.LOSS_DATE IS '상실일자';
COMMENT ON COLUMN HRP_INSURANCE_CHARGE.CREATION_DATE  IS '생성일자';
COMMENT ON COLUMN HRP_INSURANCE_CHARGE.CREATED_BY IS '생성자';
COMMENT ON COLUMN HRP_INSURANCE_CHARGE.LAST_UPDATE_DATE IS '최종수정일자';
COMMENT ON COLUMN HRP_INSURANCE_CHARGE.LAST_UPDATED_BY IS '최종수정자';

-- CREATE INDEX.
CREATE UNIQUE INDEX HRP_INSURANCE_CHARGE_U1 ON HRP_INSURANCE_CHARGE(PERSON_ID, CORP_ID, INSUR_TYPE, SOB_ID, ORG_ID) TABLESPACE FCM_TS_IDX;

-- ANALYZE.
ANALYZE TABLE HRP_INSURANCE_CHARGE COMPUTE STATISTICS;
ANALYZE INDEX HRP_INSURANCE_CHARGE_U1 COMPUTE STATISTICS;
