/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRP_PAYMENT_RULE
/* Description  : 급상여 지급율 관리.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRP_PAYMENT_RULE
( RULE_ID                                         NUMBER NOT NULL,
  CORP_ID                                         NUMBER NOT NULL,
  WAGE_TYPE                                       VARCHAR2(5) NOT NULL,
  JOIN_ID                                         NUMBER NOT NULL,
  PAY_TYPE                                        VARCHAR2(2) NOT NULL,
  STD_START_DATE                                  VARCHAR2(100) NOT NULL,
  STD_END_DATE                                    VARCHAR2(100) NOT NULL,
  START_MONTH                                     NUMBER,
  END_MONTH                                       NUMBER,
  PAYMENT_RATE                                    NUMBER,
  DESCRIPTION                                     VARCHAR2(100),
  ATTRIBUTE1                                      VARCHAR2(100),
  ATTRIBUTE2                                      VARCHAR2(100),
  ATTRIBUTE3                                      VARCHAR2(100),
  ATTRIBUTE4                                      VARCHAR2(100),
  ATTRIBUTE5                                      VARCHAR2(100),
  ENABLED_FLAG                                    VARCHAR2(1) DEFAULT 'Y',
  EFFECTIVE_YYYYMM_FR                             VARCHAR2(7) NOT NULL,
  EFFECTIVE_YYYYMM_TO                             VARCHAR2(7),
  SOB_ID                                          NUMBER NOT NULL,
  ORG_ID                                          NUMBER NOT NULL,
  CREATION_DATE                                   DATE NOT NULL,
  CREATED_BY                                      NUMBER NOT NULL,
  LAST_UPDATE_DATE                                DATE NOT NULL,
  LAST_UPDATED_BY                                 NUMBER NOT NULL
) TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON COLUMN HRP_PAYMENT_RULE.RULE_ID IS '지급율 ID';
COMMENT ON COLUMN HRP_PAYMENT_RULE.CORP_ID IS '업체 ID';
COMMENT ON COLUMN HRP_PAYMENT_RULE.WAGE_TYPE IS '급상여 구분';
COMMENT ON COLUMN HRP_PAYMENT_RULE.JOIN_ID IS '입사구분';
COMMENT ON COLUMN HRP_PAYMENT_RULE.PAY_TYPE IS '급여제';
COMMENT ON COLUMN HRP_PAYMENT_RULE.STD_START_DATE IS '기준 적용 시작일자(그룹, 수습 입사일등)';
COMMENT ON COLUMN HRP_PAYMENT_RULE.STD_END_DATE IS '기준 적용 종료일자(종료일자, 처리기준일자등)';
COMMENT ON COLUMN HRP_PAYMENT_RULE.START_MONTH IS '적용 시작 월수';
COMMENT ON COLUMN HRP_PAYMENT_RULE.END_MONTH IS '적용 종료 월수';
COMMENT ON COLUMN HRP_PAYMENT_RULE.PAYMENT_RATE IS '지급율(%)';
COMMENT ON COLUMN HRP_PAYMENT_RULE.DESCRIPTION IS '비고';
COMMENT ON COLUMN HRP_PAYMENT_RULE.ENABLED_FLAG IS '사용 여부';
COMMENT ON COLUMN HRP_PAYMENT_RULE.EFFECTIVE_YYYYMM_FR IS '적용 시작년월';
COMMENT ON COLUMN HRP_PAYMENT_RULE.EFFECTIVE_YYYYMM_TO IS '적용 종료년월';
COMMENT ON COLUMN HRP_PAYMENT_RULE.CREATION_DATE  IS '생성일자';
COMMENT ON COLUMN HRP_PAYMENT_RULE.CREATED_BY IS '생성자';
COMMENT ON COLUMN HRP_PAYMENT_RULE.LAST_UPDATE_DATE IS '최종수정일자';
COMMENT ON COLUMN HRP_PAYMENT_RULE.LAST_UPDATED_BY IS '최종수정자';

-- CREATE INDEX.
CREATE UNIQUE INDEX HRP_PAYMENT_RULE_U1 ON HRP_PAYMENT_RULE(RULE_ID) TABLESPACE FCM_TS_IDX;
CREATE UNIQUE INDEX HRP_PAYMENT_RULE_U2 ON HRP_PAYMENT_RULE(CORP_ID, WAGE_TYPE, JOIN_ID, PAY_TYPE, EFFECTIVE_YYYYMM_FR, EFFECTIVE_YYYYMM_TO, SOB_ID, ORG_ID) TABLESPACE FCM_TS_IDX;

-- SEQUENCE
DROP SEQUENCE HRP_PAYMENT_RULE_S1;
CREATE SEQUENCE HRP_PAYMENT_RULE_S1;

-- ANALYZE.
ANALYZE TABLE HRP_PAYMENT_RULE COMPUTE STATISTICS;
ANALYZE INDEX HRP_PAYMENT_RULE_U1 COMPUTE STATISTICS;
ANALYZE INDEX HRP_PAYMENT_RULE_U2 COMPUTE STATISTICS;
