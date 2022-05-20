/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRT_PERSON_PAYMENT_RULE
/* Description  : (파견직) 개인별 급상여 지급율 관리.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRT_PERSON_PAYMENT_RULE
( PERSON_RULE_ID                  NUMBER          NOT NULL,
  SOB_ID                          NUMBER          NOT NULL,
  ORG_ID                          NUMBER          NOT NULL,
  CORP_ID                         NUMBER          ,
  PERSON_ID                       NUMBER          NOT NULL,
  PAYMENT_RATE                    NUMBER          ,
  DESCRIPTION                     VARCHAR2(100)   ,
  ATTRIBUTE1                      VARCHAR2(100)   ,
  ATTRIBUTE2                      VARCHAR2(100)   ,
  ATTRIBUTE3                      VARCHAR2(100)   ,
  ATTRIBUTE4                      VARCHAR2(100)   ,
  ATTRIBUTE5                      VARCHAR2(100)   ,
  ENABLED_FLAG                    VARCHAR2(1)     DEFAULT 'Y',
  EFFECTIVE_YYYYMM_FR             VARCHAR2(7)     NOT NULL,
  EFFECTIVE_YYYYMM_TO             VARCHAR2(7)     ,  
  CREATION_DATE                   DATE            NOT NULL,
  CREATED_BY                      NUMBER          NOT NULL,
  LAST_UPDATE_DATE                DATE            NOT NULL,
  LAST_UPDATED_BY                 NUMBER          NOT NULL
) TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON TABLE HRT_PERSON_PAYMENT_RULE IS '(파견직) 개인별 급상여 지급율관리';
COMMENT ON COLUMN HRT_PERSON_PAYMENT_RULE.PERSON_RULE_ID IS '개인별 지급율 ID';
COMMENT ON COLUMN HRT_PERSON_PAYMENT_RULE.CORP_ID IS '업체 ID';
COMMENT ON COLUMN HRT_PERSON_PAYMENT_RULE.PERSON_ID IS '사원ID';
COMMENT ON COLUMN HRT_PERSON_PAYMENT_RULE.PAYMENT_RATE IS '지급율(%)';
COMMENT ON COLUMN HRT_PERSON_PAYMENT_RULE.DESCRIPTION IS '비고';
COMMENT ON COLUMN HRT_PERSON_PAYMENT_RULE.ENABLED_FLAG IS '사용 여부';
COMMENT ON COLUMN HRT_PERSON_PAYMENT_RULE.EFFECTIVE_YYYYMM_FR IS '적용 시작년월';
COMMENT ON COLUMN HRT_PERSON_PAYMENT_RULE.EFFECTIVE_YYYYMM_TO IS '적용 종료년월';
COMMENT ON COLUMN HRT_PERSON_PAYMENT_RULE.CREATION_DATE  IS '생성일자';
COMMENT ON COLUMN HRT_PERSON_PAYMENT_RULE.CREATED_BY IS '생성자';
COMMENT ON COLUMN HRT_PERSON_PAYMENT_RULE.LAST_UPDATE_DATE IS '최종수정일자';
COMMENT ON COLUMN HRT_PERSON_PAYMENT_RULE.LAST_UPDATED_BY IS '최종수정자';

-- CREATE INDEX.
CREATE UNIQUE INDEX HRT_PERSON_PAYMENT_RULE_U1 ON HRT_PERSON_PAYMENT_RULE(PERSON_RULE_ID) TABLESPACE FCM_TS_IDX;
CREATE UNIQUE INDEX HRT_PERSON_PAYMENT_RULE_U2 ON HRT_PERSON_PAYMENT_RULE(PERSON_ID, EFFECTIVE_YYYYMM_FR, EFFECTIVE_YYYYMM_TO, SOB_ID, ORG_ID) TABLESPACE FCM_TS_IDX;

-- SEQUENCE
CREATE SEQUENCE HRT_PERSON_PAYMENT_RULE_S1;

-- ANALYZE.
ANALYZE TABLE HRT_PERSON_PAYMENT_RULE COMPUTE STATISTICS;
ANALYZE INDEX HRT_PERSON_PAYMENT_RULE_U1 COMPUTE STATISTICS;
ANALYZE INDEX HRT_PERSON_PAYMENT_RULE_U2 COMPUTE STATISTICS;
