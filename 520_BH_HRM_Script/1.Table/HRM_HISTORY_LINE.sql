/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRM_HISTORY_LINE
/* Description  : �λ�߷ɻ��� LINE.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRM_HISTORY_LINE              
(HISTORY_LINE_ID                                  NUMBER NOT NULL,
  HISTORY_HEADER_ID                               NUMBER NOT NULL,
  HISTORY_NUM	                                    VARCHAR2(20) NOT NULL,
  PERSON_ID	                                      NUMBER NOT NULL,
  CHARGE_DATE	                                    DATE NOT NULL,
  CHARGE_ID	                                      NUMBER NOT NULL,
  RETIRE_ID	                                      NUMBER,
  OPERATING_UNIT_ID                               NUMBER,	
  DEPT_ID	                                        NUMBER,
  JOB_CLASS_ID	                                  NUMBER,
  JOB_ID	                                        NUMBER,
  POST_ID	                                        NUMBER,
  OCPT_ID	                                        NUMBER,
  ABIL_ID	                                        NUMBER,
  PAY_GRADE_ID	                                  NUMBER,
  JOB_CATEGORY_ID	                                NUMBER,
	FLOOR_ID                                        NUMBER,
  PRE_OPERATING_UNIT_ID                           NUMBER,	
  PRE_DEPT_ID	                                    NUMBER,
  PRE_JOB_CLASS_ID	                              NUMBER,
  PRE_JOB_ID	                                    NUMBER,
  PRE_POST_ID	                                    NUMBER,
  PRE_OCPT_ID	                                    NUMBER,
  PRE_ABIL_ID	                                    NUMBER,
  PRE_PAY_GRADE_ID	                              NUMBER,
  PRE_JOB_CATEGORY_ID	                            NUMBER,
	PRE_FLOOR_ID                                    NUMBER,
  PRINT_YN                                        VARCHAR2(1) DEFAULT 'Y',
  DESCRIPTION                                     VARCHAR2(100),
  ATTRIBUTE1                                      VARCHAR2(100),
  ATTRIBUTE2                                      VARCHAR2(100),
  ATTRIBUTE3                                      VARCHAR2(100),
  ATTRIBUTE4                                      VARCHAR2(100),
  ATTRIBUTE5                                      VARCHAR2(100),
  CREATION_DATE                                   DATE NOT NULL,
  CREATED_BY                                      NUMBER NOT NULL,
  LAST_UPDATE_DATE                                DATE NOT NULL,
  LAST_UPDATED_BY                                 NUMBER NOT NULL
)
TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON COLUMN HRM_HISTORY_LINE.HISTORY_LINE_ID IS '�߷ɻ��� LINE ID';
COMMENT ON COLUMN HRM_HISTORY_LINE.HISTORY_HEADER_ID IS '�߷ɻ��� HEADER ID';
COMMENT ON COLUMN HRM_HISTORY_LINE.HISTORY_NUM IS '�߷ɹ�ȣ';
COMMENT ON COLUMN HRM_HISTORY_LINE.PERSON_ID IS '���ID';
COMMENT ON COLUMN HRM_HISTORY_LINE.CHARGE_DATE IS '�߷�����';
COMMENT ON COLUMN HRM_HISTORY_LINE.CHARGE_ID IS '�߷ɻ���';
COMMENT ON COLUMN HRM_HISTORY_LINE.RETIRE_ID IS '��������';
COMMENT ON COLUMN HRM_HISTORY_LINE.OPERATING_UNIT_ID IS '�����ID';
COMMENT ON COLUMN HRM_HISTORY_LINE.DEPT_ID IS '�μ�ID';
COMMENT ON COLUMN HRM_HISTORY_LINE.JOB_CLASS_ID IS '����ID';
COMMENT ON COLUMN HRM_HISTORY_LINE.JOB_ID IS '����ID';
COMMENT ON COLUMN HRM_HISTORY_LINE.POST_ID IS '����ID';
COMMENT ON COLUMN HRM_HISTORY_LINE.OCPT_ID IS '����ID';
COMMENT ON COLUMN HRM_HISTORY_LINE.ABIL_ID IS '��åID';
COMMENT ON COLUMN HRM_HISTORY_LINE.PAY_GRADE_ID IS '����ID';
COMMENT ON COLUMN HRM_HISTORY_LINE.JOB_CATEGORY_ID IS '������ID';
COMMENT ON COLUMN HRM_HISTORY_LINE.FLOOR_ID IS '�۾���ID';
COMMENT ON COLUMN HRM_HISTORY_LINE.PRE_OPERATING_UNIT_ID IS '�� �����ID';
COMMENT ON COLUMN HRM_HISTORY_LINE.PRE_DEPT_ID IS '�� �μ�ID';
COMMENT ON COLUMN HRM_HISTORY_LINE.PRE_JOB_CLASS_ID IS '�� ����ID';
COMMENT ON COLUMN HRM_HISTORY_LINE.PRE_JOB_ID IS '�� ����ID';
COMMENT ON COLUMN HRM_HISTORY_LINE.PRE_POST_ID IS '�� ����ID';
COMMENT ON COLUMN HRM_HISTORY_LINE.PRE_OCPT_ID IS '�� ����ID';
COMMENT ON COLUMN HRM_HISTORY_LINE.PRE_ABIL_ID IS '�� ��åID';
COMMENT ON COLUMN HRM_HISTORY_LINE.PRE_PAY_GRADE_ID IS '�� ����ID';
COMMENT ON COLUMN HRM_HISTORY_LINE.PRE_JOB_CATEGORY_ID IS '�� ������ID';
COMMENT ON COLUMN HRM_HISTORY_LINE.PRE_FLOOR_ID IS '�� �۾���ID';
COMMENT ON COLUMN HRM_HISTORY_LINE.PRINT_YN IS '�μ� ����';
COMMENT ON COLUMN HRM_HISTORY_LINE.DESCRIPTION IS '���';
COMMENT ON COLUMN HRM_HISTORY_LINE.CREATION_DATE  IS '��������';
COMMENT ON COLUMN HRM_HISTORY_LINE.CREATED_BY IS '������';
COMMENT ON COLUMN HRM_HISTORY_LINE.LAST_UPDATE_DATE IS '������������';
COMMENT ON COLUMN HRM_HISTORY_LINE.LAST_UPDATED_BY IS '����������';

-- CREATE INDEX.
CREATE UNIQUE INDEX HRM_HISTORY_LINE_U1 ON HRM_HISTORY_LINE(HISTORY_LINE_ID) TABLESPACE FCM_TS_IDX;
CREATE UNIQUE INDEX HRM_HISTORY_LINE_U2 ON HRM_HISTORY_LINE(HISTORY_HEADER_ID, PERSON_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX HRM_HISTORY_LINE_N1 ON HRM_HISTORY_LINE(PERSON_ID) TABLESPACE FCM_TS_IDX;

-- SEQUENCE.
DROP SEQUENCE HRM_HISTORY_LINE_S1;
CREATE SEQUENCE HRM_HISTORY_LINE_S1;

-- ANALYZE.
ANALYZE TABLE HRM_HISTORY_LINE COMPUTE STATISTICS;
ANALYZE INDEX HRM_HISTORY_LINE_U1 COMPUTE STATISTICS;
ANALYZE INDEX HRM_HISTORY_LINE_U2 COMPUTE STATISTICS;
ANALYZE INDEX HRM_HISTORY_LINE_N1 COMPUTE STATISTICS;
