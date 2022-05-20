/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRD_DAY_LEAVE_OT
/* Description  : �ϱ��� �ܾ� ���� ����.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRD_DAY_LEAVE_OT              
( DAY_LEAVE_ID                                  NUMBER NOT NULL, 
  OT_TYPE                                       VARCHAR2(10) NOT NULL,
  OT_TIME                                       NUMBER DEFAULT 0,  
  DESCRIPTION                                   VARCHAR2(100),
  ATTRIBUTE1                                    VARCHAR2(100),
  ATTRIBUTE2                                    VARCHAR2(100),
  ATTRIBUTE3                                    VARCHAR2(100),
  ATTRIBUTE4                                    VARCHAR2(100),
  ATTRIBUTE5                                    VARCHAR2(100),
  PERSON_ID                                     NUMBER NOT NULL,
  WORK_DATE                                     DATE NOT NULL,
  CORP_ID                                       NUMBER NOT NULL,  
  SOB_ID                                        NUMBER NOT NULL,
  ORG_ID                                        NUMBER NOT NULL,
  CREATION_DATE                                 DATE NOT NULL,
  CREATED_BY                                    NUMBER NOT NULL,
  LAST_UPDATE_DATE                              DATE NOT NULL,
  LAST_UPDATED_BY                               NUMBER NOT NULL
) TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON COLUMN HRD_DAY_LEAVE_OT.DAY_LEAVE_ID IS '�ϱ��� ID';
COMMENT ON COLUMN HRD_DAY_LEAVE_OT.OT_TYPE IS '�ܾ� Ÿ��';
COMMENT ON COLUMN HRD_DAY_LEAVE_OT.OT_TIME IS '�ܾ� �ð�';
COMMENT ON COLUMN HRD_DAY_LEAVE_OT.DESCRIPTION IS '���';
COMMENT ON COLUMN HRD_DAY_LEAVE_OT.PERSON_ID IS '���ID';
COMMENT ON COLUMN HRD_DAY_LEAVE_OT.WORK_DATE IS '�ٹ�����';
COMMENT ON COLUMN HRD_DAY_LEAVE_OT.CORP_ID IS '��üID';
COMMENT ON COLUMN HRD_DAY_LEAVE_OT.CREATION_DATE  IS '��������';
COMMENT ON COLUMN HRD_DAY_LEAVE_OT.CREATED_BY IS '������';
COMMENT ON COLUMN HRD_DAY_LEAVE_OT.LAST_UPDATE_DATE IS '������������';
COMMENT ON COLUMN HRD_DAY_LEAVE_OT.LAST_UPDATED_BY IS '����������';

-- CREATE INDEX.
CREATE UNIQUE INDEX HRD_DAY_LEAVE_OT_U1 ON HRD_DAY_LEAVE_OT(DAY_LEAVE_ID, OT_TYPE) TABLESPACE FCM_TS_IDX;
CREATE INDEX HRD_DAY_LEAVE_OT_N1 ON HRD_DAY_LEAVE_OT(PERSON_ID, CORP_ID, WORK_DATE, SOB_ID, ORG_ID) TABLESPACE FCM_TS_IDX;

-- SEQUENCE.
/*DROP SEQUENCE HRD_DAY_LEAVE_OT_S1;
CREATE SEQUENCE HRD_DAY_LEAVE_OT_S1;*/

-- ANALYZE.
ANALYZE TABLE HRD_DAY_LEAVE_OT COMPUTE STATISTICS;
ANALYZE INDEX HRD_DAY_LEAVE_OT_U1 COMPUTE STATISTICS;
ANALYZE INDEX HRD_DAY_LEAVE_OT_N1 COMPUTE STATISTICS;
