/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM - GL
/* Program Name : FI_ACCOUNT_GROUP
/* Description  : 회계 계정코드 그룹 관리
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_ACCOUNT_GROUP              
( ACCOUNT_GROUP_ID                                NUMBER NOT NULL,
  ACCOUNT_SET_ID                                  NUMBER NOT NULL,
  ACCOUNT_CODE                                    VARCHAR2(20) NOT NULL,
  ACCOUNT_DESC                                    VARCHAR2(100) NOT NULL,
  SEGMENT1_CODE                                   VARCHAR2(20),
  SEGMENT1_DESC                                   VARCHAR2(100),
  SEGMENT2_CODE                                   VARCHAR2(20),
  SEGMENT2_DESC                                   VARCHAR2(100),
  SEGMENT3_CODE                                   VARCHAR2(20),
  SEGMENT3_DESC                                   VARCHAR2(100),
  SEGMENT4_CODE                                   VARCHAR2(20),
  SEGMENT4_DESC                                   VARCHAR2(100),
  SEGMENT5_CODE                                   VARCHAR2(20),
  SEGMENT5_DESC                                   VARCHAR2(100),
  SEGMENT6_CODE                                   VARCHAR2(20),
  SEGMENT6_DESC                                   VARCHAR2(100),
  SEGMENT7_CODE                                   VARCHAR2(20),
  SEGMENT7_DESC                                   VARCHAR2(100),
  SEGMENT8_CODE                                   VARCHAR2(20),
  SEGMENT8_DESC                                   VARCHAR2(100),
  SEGMENT9_CODE                                   VARCHAR2(20),
  SEGMENT9_DESC                                   VARCHAR2(100),
  SEGMENT10_CODE                                  VARCHAR2(20),
  SEGMENT10_DESC                                  VARCHAR2(100),  
  ENABLED_FLAG                                    VARCHAR2(1) DEFAULT 'Y',
  EFFECTIVE_DATE_FR                               DATE NOT NULL,
  EFFECTIVE_DATE_TO                               DATE,
  CREATION_DATE                                   DATE NOT NULL,
  CREATED_BY                                      NUMBER NOT NULL,
  LAST_UPDATE_DATE                                DATE NOT NULL,
  LAST_UPDATED_BY                                 NUMBER NOT NULL
) TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON TABLE FI_ACCOUNT_GROUP IS '계정그룹';
COMMENT ON COLUMN FI_ACCOUNT_GROUP.ACCOUNT_GROUP_ID IS '계정그룹ID';
COMMENT ON COLUMN FI_ACCOUNT_GROUP.ACCOUNT_SET_ID IS '계정관리 ID';
COMMENT ON COLUMN FI_ACCOUNT_GROUP.ACCOUNT_CODE IS '계정코드(최하위 LEVEL)';
COMMENT ON COLUMN FI_ACCOUNT_GROUP.ACCOUNT_DESC IS '계정명(최하위 LEVEL)';
COMMENT ON COLUMN FI_ACCOUNT_GROUP.SEGMENT1_CODE IS '계정그룹코드(1~10)';
COMMENT ON COLUMN FI_ACCOUNT_GROUP.SEGMENT1_DESC IS '계정그룹명(1~10)';
COMMENT ON COLUMN FI_ACCOUNT_GROUP.ENABLED_FLAG IS '사용여부';
COMMENT ON COLUMN FI_ACCOUNT_GROUP.EFFECTIVE_DATE_FR IS '적용 시작일자';
COMMENT ON COLUMN FI_ACCOUNT_GROUP.EFFECTIVE_DATE_TO IS '적용 종료일자';
COMMENT ON COLUMN FI_ACCOUNT_GROUP.CREATION_DATE  IS '생성일자';
COMMENT ON COLUMN FI_ACCOUNT_GROUP.CREATED_BY IS '생성자';
COMMENT ON COLUMN FI_ACCOUNT_GROUP.LAST_UPDATE_DATE IS '최종수정일자';
COMMENT ON COLUMN FI_ACCOUNT_GROUP.LAST_UPDATED_BY IS '최종수정자';

-- CREATE INDEX.
CREATE UNIQUE INDEX FI_ACCOUNT_GROUP_U1 ON FI_ACCOUNT_GROUP(ACCOUNT_GROUP_ID) TABLESPACE FCM_TS_IDX;
CREATE UNIQUE INDEX FI_ACCOUNT_GROUP_U2 ON FI_ACCOUNT_GROUP(ACCOUNT_SET_ID, ACCOUNT_CODE) TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_ACCOUNT_GROUP_N1 ON FI_ACCOUNT_GROUP(ACCOUNT_SET_ID, ACCOUNT_CODE, EFFECTIVE_DATE_FR, EFFECTIVE_DATE_TO) TABLESPACE FCM_TS_IDX;

-- SEQUENCT.
DROP SEQUENCE FI_ACCOUNT_GROUP_S1;
CREATE SEQUENCE FI_ACCOUNT_GROUP_S1;

-- ANALYZE.
ANALYZE TABLE FI_ACCOUNT_GROUP COMPUTE STATISTICS;
ANALYZE INDEX FI_ACCOUNT_GROUP_U1 COMPUTE STATISTICS;
ANALYZE INDEX FI_ACCOUNT_GROUP_U2 COMPUTE STATISTICS;
ANALYZE INDEX FI_ACCOUNT_GROUP_N1 COMPUTE STATISTICS;
