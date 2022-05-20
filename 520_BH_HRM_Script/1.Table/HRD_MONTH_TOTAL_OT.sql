/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRD_MONTH_TOTAL_OT
/* Description  : ������ �ܾ� ���� ����.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRD_MONTH_TOTAL_OT              
( MONTH_TOTAL_ID                                NUMBER NOT NULL, 
  OT_TYPE                                       VARCHAR2(10) NOT NULL,
  OT_TIME                                       NUMBER DEFAULT 0,  
  DESCRIPTION                                   VARCHAR2(100),
  ATTRIBUTE1                                    VARCHAR2(100),
  ATTRIBUTE2                                    VARCHAR2(100),
  ATTRIBUTE3                                    VARCHAR2(100),
  ATTRIBUTE4                                    VARCHAR2(100),
  ATTRIBUTE5                                    VARCHAR2(100),
  PERSON_ID                                     NUMBER NOT NULL,
  DUTY_TYPE                                     VARCHAR2(2) NOT NULL,
  DUTY_YYYYMM                                   VARCHAR2(7) NOT NULL,
  WORK_CORP_ID                                  NUMBER NOT NULL,
  CORP_ID                                       NUMBER NOT NULL,  
  SOB_ID                                        NUMBER NOT NULL,
  ORG_ID                                        NUMBER NOT NULL,
  CREATION_DATE                                 DATE NOT NULL,
  CREATED_BY                                    NUMBER NOT NULL,
  LAST_UPDATE_DATE                              DATE NOT NULL,
  LAST_UPDATED_BY                               NUMBER NOT NULL
) TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON COLUMN HRD_MONTH_TOTAL_OT.MONTH_TOTAL_ID IS '������ ID';
COMMENT ON COLUMN HRD_MONTH_TOTAL_OT.OT_TYPE IS '�ܾ� Ÿ��';
COMMENT ON COLUMN HRD_MONTH_TOTAL_OT.OT_TIME IS '�ܾ� �ð�';
COMMENT ON COLUMN HRD_MONTH_TOTAL_OT.DESCRIPTION IS '���';
COMMENT ON COLUMN HRD_MONTH_TOTAL_OT.PERSON_ID IS '���ID';
COMMENT ON COLUMN HRD_MONTH_TOTAL_OT.DUTY_TYPE IS '���±���';
COMMENT ON COLUMN HRD_MONTH_TOTAL_OT.DUTY_YYYYMM IS '���³��';
COMMENT ON COLUMN HRD_MONTH_TOTAL_OT.CORP_ID IS '��üID';
COMMENT ON COLUMN HRD_MONTH_TOTAL_OT.CREATION_DATE  IS '��������';
COMMENT ON COLUMN HRD_MONTH_TOTAL_OT.CREATED_BY IS '������';
COMMENT ON COLUMN HRD_MONTH_TOTAL_OT.LAST_UPDATE_DATE IS '������������';
COMMENT ON COLUMN HRD_MONTH_TOTAL_OT.LAST_UPDATED_BY IS '����������';

-- CREATE INDEX.
CREATE UNIQUE INDEX HRD_MONTH_TOTAL_OT_U1 ON HRD_MONTH_TOTAL_OT(MONTH_TOTAL_ID, OT_TYPE) TABLESPACE FCM_TS_IDX;
CREATE INDEX HRD_MONTH_TOTAL_OT_N1 ON HRD_MONTH_TOTAL_OT(PERSON_ID, DUTY_TYPE, DUTY_YYYYMM, CORP_ID, SOB_ID, ORG_ID) TABLESPACE FCM_TS_IDX;

-- SEQUENCE.
CREATE SEQUENCE HRD_MONTH_TOTAL_OT_S1;

-- ANALYZE.
ANALYZE TABLE HRD_MONTH_TOTAL_OT COMPUTE STATISTICS;
ANALYZE INDEX HRD_MONTH_TOTAL_OT_U1 COMPUTE STATISTICS;
ANALYZE INDEX HRD_MONTH_TOTAL_OT_N1 COMPUTE STATISTICS;
