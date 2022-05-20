/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM - GL
/* Program Name : FI_ACCOUNT_SET
/* Description  : 회계 계정코드 관리
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_ACCOUNT_SET              
( ACCOUNT_SET_ID                                  NUMBER NOT NULL,
  ACCOUNT_SET_CODE                                VARCHAR2(50) NOT NULL,
  ACCOUNT_SET_NAME                                VARCHAR2(100) NOT NULL,
  ACCOUNT_LEVEL                                   NUMBER NOT NULL,
  CREATION_DATE                                   DATE NOT NULL,
  CREATED_BY                                      NUMBER NOT NULL,
  LAST_UPDATE_DATE                                DATE NOT NULL,
  LAST_UPDATED_BY                                 NUMBER NOT NULL
) TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON TABLE FI_ACCOUNT_SET IS '계정관리 세트';
COMMENT ON COLUMN FI_ACCOUNT_SET.ACCOUNT_SET_ID IS '계정관리 ID';
COMMENT ON COLUMN FI_ACCOUNT_SET.ACCOUNT_SET_CODE IS '계정관리 CODE';
COMMENT ON COLUMN FI_ACCOUNT_SET.ACCOUNT_SET_NAME IS '계정관리명';
COMMENT ON COLUMN FI_ACCOUNT_SET.ACCOUNT_LEVEL IS '계정관리 LEVEL';
COMMENT ON COLUMN FI_ACCOUNT_SET.CREATION_DATE  IS '생성일자';
COMMENT ON COLUMN FI_ACCOUNT_SET.CREATED_BY IS '생성자';
COMMENT ON COLUMN FI_ACCOUNT_SET.LAST_UPDATE_DATE IS '최종수정일자';
COMMENT ON COLUMN FI_ACCOUNT_SET.LAST_UPDATED_BY IS '최종수정자';

-- CREATE INDEX.
CREATE UNIQUE INDEX FI_ACCOUNT_SET_U1 ON FI_ACCOUNT_SET(ACCOUNT_SET_ID) TABLESPACE FCM_TS_IDX;
CREATE UNIQUE INDEX FI_ACCOUNT_SET_U2 ON FI_ACCOUNT_SET(ACCOUNT_SET_CODE) TABLESPACE FCM_TS_IDX;

-- ANALYZE.
ANALYZE TABLE FI_ACCOUNT_SET COMPUTE STATISTICS;
ANALYZE INDEX FI_ACCOUNT_SET_U1 COMPUTE STATISTICS;
ANALYZE INDEX FI_ACCOUNT_SET_U2 COMPUTE STATISTICS;
