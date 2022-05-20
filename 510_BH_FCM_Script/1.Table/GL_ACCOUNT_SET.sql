/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM - GL
/* Program Name : FI_ACCOUNT_SET
/* Description  : ȸ�� �����ڵ� ����
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
COMMENT ON TABLE FI_ACCOUNT_SET IS '�������� ��Ʈ';
COMMENT ON COLUMN FI_ACCOUNT_SET.ACCOUNT_SET_ID IS '�������� ID';
COMMENT ON COLUMN FI_ACCOUNT_SET.ACCOUNT_SET_CODE IS '�������� CODE';
COMMENT ON COLUMN FI_ACCOUNT_SET.ACCOUNT_SET_NAME IS '����������';
COMMENT ON COLUMN FI_ACCOUNT_SET.ACCOUNT_LEVEL IS '�������� LEVEL';
COMMENT ON COLUMN FI_ACCOUNT_SET.CREATION_DATE  IS '��������';
COMMENT ON COLUMN FI_ACCOUNT_SET.CREATED_BY IS '������';
COMMENT ON COLUMN FI_ACCOUNT_SET.LAST_UPDATE_DATE IS '������������';
COMMENT ON COLUMN FI_ACCOUNT_SET.LAST_UPDATED_BY IS '����������';

-- CREATE INDEX.
CREATE UNIQUE INDEX FI_ACCOUNT_SET_U1 ON FI_ACCOUNT_SET(ACCOUNT_SET_ID) TABLESPACE FCM_TS_IDX;
CREATE UNIQUE INDEX FI_ACCOUNT_SET_U2 ON FI_ACCOUNT_SET(ACCOUNT_SET_CODE) TABLESPACE FCM_TS_IDX;

-- ANALYZE.
ANALYZE TABLE FI_ACCOUNT_SET COMPUTE STATISTICS;
ANALYZE INDEX FI_ACCOUNT_SET_U1 COMPUTE STATISTICS;
ANALYZE INDEX FI_ACCOUNT_SET_U2 COMPUTE STATISTICS;
