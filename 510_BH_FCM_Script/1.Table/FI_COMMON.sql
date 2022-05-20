/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_COMMON
/* Description  : �����ڵ� ����
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_COMMON      
( COMMON_ID                                     NUMBER NOT NULL,
  GROUP_CODE                                    VARCHAR2(70) NOT NULL,
  CODE                                          VARCHAR2(70) NOT NULL,
  CODE_NAME                                     VARCHAR2(150) NOT NULL,
  SYSTEM_FLAG                                   VARCHAR2(1), 
  CODE_LENGTH                                   NUMBER,
  VALUE1                                        VARCHAR2(150),
  VALUE2                                        VARCHAR2(150),
  VALUE3                                        VARCHAR2(150), 
  VALUE4                                        VARCHAR2(150),
  VALUE5                                        VARCHAR2(150),
  VALUE6                                        VARCHAR2(150),
  VALUE7                                        VARCHAR2(150),
  VALUE8                                        VARCHAR2(150),
  VALUE9                                        VARCHAR2(150),
  VALUE10                                       VARCHAR2(150),
  DEFAULT_FLAG                                  VARCHAR2(1) DEFAULT 'N',
  SORT_NUM                                      NUMBER DEFAULT 0,
  DESCRIPTION                                   VARCHAR2(100),
  ENABLED_FLAG                                  VARCHAR2(1) NOT NULL,
  EFFECTIVE_DATE_FR                             DATE NOT NULL,
  EFFECTIVE_DATE_TO                             DATE,
  SOB_ID                                        NUMBER NOT NULL,
  CREATION_DATE                                 DATE NOT NULL,
  CREATED_BY                                    NUMBER NOT NULL,
  LAST_UPDATE_DATE                              DATE NOT NULL,
  LAST_UPDATED_BY                               NUMBER  NOT NULL
) TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON COLUMN FI_COMMON.COMMON_ID IS '�����ڵ� ID';
COMMENT ON COLUMN FI_COMMON.GROUP_CODE IS '�׷��� �ڵ�';
COMMENT ON COLUMN FI_COMMON.CODE IS '�����ڵ�';
COMMENT ON COLUMN FI_COMMON.CODE_NAME IS '�����ڵ��';
COMMENT ON COLUMN FI_COMMON.CODE_LENGTH IS '�����ڵ� ����';
COMMENT ON COLUMN FI_COMMON.VALUE1 IS '���� ��-VALUE1~10';
COMMENT ON COLUMN FI_COMMON.DEFAULT_FLAG IS '�⺻��';
COMMENT ON COLUMN FI_COMMON.SORT_NUM IS '���ļ���';
COMMENT ON COLUMN FI_COMMON.DESCRIPTION IS '���';
COMMENT ON COLUMN FI_COMMON.ENABLED_FLAG IS '��뿩��';
COMMENT ON COLUMN FI_COMMON.EFFECTIVE_DATE_FR IS '���� ��������';
COMMENT ON COLUMN FI_COMMON.EFFECTIVE_DATE_TO IS '���� ��������';
COMMENT ON COLUMN FI_COMMON.CREATION_DATE  IS '��������';
COMMENT ON COLUMN FI_COMMON.CREATED_BY IS '������';
COMMENT ON COLUMN FI_COMMON.LAST_UPDATE_DATE IS '������������';
COMMENT ON COLUMN FI_COMMON.LAST_UPDATED_BY IS '����������';

-- CREATE INDEX.
CREATE UNIQUE INDEX FI_COMMON_U1 ON FI_COMMON(COMMON_ID) TABLESPACE FCM_TS_IDX;
CREATE UNIQUE INDEX FI_COMMON_U2 ON FI_COMMON(GROUP_CODE, CODE, SOB_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_COMMON_N1 ON FI_COMMON(GROUP_CODE, CODE, ENABLED_FLAG, EFFECTIVE_DATE_FR, EFFECTIVE_DATE_TO, SOB_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_COMMON_N2 ON FI_COMMON(GROUP_CODE, CODE, VALUE1, ENABLED_FLAG, EFFECTIVE_DATE_FR, EFFECTIVE_DATE_TO, SOB_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_COMMON_N3 ON FI_COMMON(GROUP_CODE, CODE, VALUE2, ENABLED_FLAG, EFFECTIVE_DATE_FR, EFFECTIVE_DATE_TO, SOB_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_COMMON_N4 ON FI_COMMON(GROUP_CODE, CODE, VALUE3, ENABLED_FLAG, EFFECTIVE_DATE_FR, EFFECTIVE_DATE_TO, SOB_ID) TABLESPACE FCM_TS_IDX;

-- SEQUENCE.
DROP SEQUENCE FI_COMMON_S1;
CREATE SEQUENCE FI_COMMON_S1;

-- ANALYZE.
ANALYZE TABLE FI_COMMON COMPUTE STATISTICS;
ANALYZE INDEX FI_COMMON_U1 COMPUTE STATISTICS;
ANALYZE INDEX FI_COMMON_U2 COMPUTE STATISTICS;
ANALYZE INDEX FI_COMMON_N1 COMPUTE STATISTICS;
ANALYZE INDEX FI_COMMON_N2 COMPUTE STATISTICS;
ANALYZE INDEX FI_COMMON_N3 COMPUTE STATISTICS;
ANALYZE INDEX FI_COMMON_N4 COMPUTE STATISTICS;
