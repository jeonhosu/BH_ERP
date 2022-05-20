/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRD_DUTY_EXCEPTION
/* Description  : 근태 예외처리자 관리.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRD_DUTY_EXCEPTION
( CORP_ID                         NUMBER        NOT NULL,
  PERSON_ID                       NUMBER        NOT NULL,
  SOB_ID                          NUMBER        NOT NULL,
  ORG_ID                          NUMBER        NOT NULL,
  EXCEPTION_YN                    CHAR(1)       DEFAULT 'N',
  AUTO_WORKTIME_YN                CHAR(1)       DEFAULT 'N',
  DESCRIPTION                     VARCHAR2(100) ,
  ATTRIBUTE_A                     VARCHAR2(100) ,
  ATTRIBUTE_B                     VARCHAR2(100) ,
  ATTRIBUTE_C                     VARCHAR2(100) ,
  ATTRIBUTE_D                     VARCHAR2(100) ,
  ATTRIBUTE_E                     VARCHAR2(100) ,
  ATTRIBUTE_1                     NUMBER        ,
  ATTRIBUTE_2                     NUMBER        ,
  ATTRIBUTE_3                     NUMBER        ,
  ATTRIBUTE_4                     NUMBER        ,
  ATTRIBUTE_5                     NUMBER        ,
  ENABLED_FLAG                    CHAR(1)       DEFAULT 'Y',
  EFFECTIVE_DATE_FR               DATE          NOT NULL,
  EFFECTIVE_DATE_TO               DATE          ,
  CREATION_DATE                   DATE          NOT NULL,
  CREATED_BY                      NUMBER        NOT NULL,
  LAST_UPDATE_DATE                DATE          NOT NULL,
  LAST_UPDATED_BY                 NUMBER        NOT NULL
) TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON TABLE HRD_DUTY_EXCEPTION IS '근태 예외처리자 관리';
COMMENT ON COLUMN HRD_DUTY_EXCEPTION.CORP_ID IS '업체 ID';
COMMENT ON COLUMN HRD_DUTY_EXCEPTION.PERSON_ID IS '사원ID';
COMMENT ON COLUMN HRD_DUTY_EXCEPTION.EXCEPTION_YN IS '근태예외처리 여부(Y/N)';
COMMENT ON COLUMN HRD_DUTY_EXCEPTION.AUTO_WORKTIME_YN IS '자동 근태시간 생성여부(Y/N)';
COMMENT ON COLUMN HRD_DUTY_EXCEPTION.DESCRIPTION IS '비고';
COMMENT ON COLUMN HRD_DUTY_EXCEPTION.ENABLED_FLAG IS '사용 여부';
COMMENT ON COLUMN HRD_DUTY_EXCEPTION.EFFECTIVE_DATE_FR IS '적용 시작년월';
COMMENT ON COLUMN HRD_DUTY_EXCEPTION.EFFECTIVE_DATE_TO IS '적용 종료년월';
COMMENT ON COLUMN HRD_DUTY_EXCEPTION.CREATION_DATE  IS '생성일자';
COMMENT ON COLUMN HRD_DUTY_EXCEPTION.CREATED_BY IS '생성자';
COMMENT ON COLUMN HRD_DUTY_EXCEPTION.LAST_UPDATE_DATE IS '최종수정일자';
COMMENT ON COLUMN HRD_DUTY_EXCEPTION.LAST_UPDATED_BY IS '최종수정자';

-- PK.
ALTER TABLE HRD_DUTY_EXCEPTION ADD CONSTRAINT HRD_DUTY_EXCEPTION_PK PRIMARY KEY(CORP_ID, PERSON_ID, SOB_ID, ORG_ID);
-- CREATE INDEX.
CREATE INDEX HRD_DUTY_EXCEPTION_N1 ON HRD_DUTY_EXCEPTION(CORP_ID, PERSON_ID, SOB_ID, ORG_ID, ENABLED_FLAG, EFFECTIVE_DATE_FR, EFFECTIVE_DATE_TO) TABLESPACE FCM_TS_IDX;

-- ANALYZE.
ANALYZE TABLE HRD_DUTY_EXCEPTION COMPUTE STATISTICS;
ANALYZE INDEX HRD_DUTY_EXCEPTION_N1 COMPUTE STATISTICS;
