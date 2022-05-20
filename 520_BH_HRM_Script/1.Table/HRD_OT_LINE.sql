/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRD_OT_LINE
/* Description  : ����ٹ���û ���� ����
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRD_OT_LINE              
( OT_LINE_ID                          NUMBER        NOT NULL,
  OT_HEADER_ID                        NUMBER        NOT NULL,
  REQ_NUM	                            VARCHAR2(50)  NOT NULL,
  LINE_SEQ                            NUMBER        ,	
  PERSON_ID	                          NUMBER        NOT NULL,
  WORK_DATE	                          DATE          NOT NULL,
  BEFORE_OT_START	                    DATE          ,
  BEFORE_OT_END	                      DATE          ,
  AFTER_OT_START	                    DATE          ,	
  AFTER_OT_END	                      DATE          ,
  LUNCH_YN	                          CHAR(1)       DEFAULT 'N',
  DINNER_YN	                          CHAR(1)       DEFAULT 'N',
  MIDNIGHT_YN	                        CHAR(1)       DEFAULT 'N',
  DANGJIK_YN	                        CHAR(1)       DEFAULT 'N',
  ALL_NIGHT_YN	                      CHAR(1)       DEFAULT 'N',
  APPROVED_YN	                        CHAR(1)       DEFAULT 'N',
  APPROVED_DATE	                      DATE          ,
  APPROVED_PERSON_ID                  NUMBER        ,
  CONFIRMED_YN	                      CHAR(1)       DEFAULT 'N',
  CONFIRMED_DATE	                    DATE          ,
  CONFIRMED_PERSON_ID	                NUMBER        ,
	APPROVE_STATUS                      VARCHAR2(2)   DEFAULT 'N',
  EMAIL_STATUS                        VARCHAR2(2)   DEFAULT 'N',
	CALENDAR_TRAN_YN                    CHAR(1)       DEFAULT 'N',
  DESCRIPTION                         VARCHAR2(100) ,
  REJECT_YN	                          CHAR(1)       DEFAULT 'N',
  REJECT_DATE	                        DATE          ,
  REJECT_PERSON_ID	                  NUMBER        ,
  REJECT_REMARK                       VARCHAR2(200) ,
  ATTRIBUTE1                          VARCHAR2(100) ,
  ATTRIBUTE2                          VARCHAR2(100) ,
  ATTRIBUTE3                          VARCHAR2(100) ,
  ATTRIBUTE4                          VARCHAR2(100) ,
  ATTRIBUTE5                          VARCHAR2(100) ,
  CREATION_DATE                       DATE          NOT NULL,
  CREATED_BY                          NUMBER        NOT NULL,
  LAST_UPDATE_DATE                    DATE          NOT NULL,
  LAST_UPDATED_BY                     NUMBER        NOT NULL
) TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON COLUMN HRD_OT_LINE.OT_LINE_ID IS '��û LINE ID';
COMMENT ON COLUMN HRD_OT_LINE.OT_HEADER_ID IS '��û HEADER ID';
COMMENT ON COLUMN HRD_OT_LINE.REQ_NUM IS '��û��ȣ(���-XXX)';
COMMENT ON COLUMN HRD_OT_LINE.LINE_SEQ IS '��ûLINE �Ϸù�ȣ';
COMMENT ON COLUMN HRD_OT_LINE.PERSON_ID IS '�����ȣ';
COMMENT ON COLUMN HRD_OT_LINE.WORK_DATE IS '�ٹ�����';
COMMENT ON COLUMN HRD_OT_LINE.BEFORE_OT_START IS '�ٹ��� ���� ���۽ð�';
COMMENT ON COLUMN HRD_OT_LINE.BEFORE_OT_END IS '�ٹ��� ���� ����ð�';
COMMENT ON COLUMN HRD_OT_LINE.AFTER_OT_START IS '�ٹ��� ���� ���۽ð�';
COMMENT ON COLUMN HRD_OT_LINE.AFTER_OT_END IS '�ٹ��� ���� ����ð�';
COMMENT ON COLUMN HRD_OT_LINE.LUNCH_YN IS '�߽Ŀ��� ����';
COMMENT ON COLUMN HRD_OT_LINE.DINNER_YN IS '���Ŀ��� ����';
COMMENT ON COLUMN HRD_OT_LINE.MIDNIGHT_YN IS '�߽Ŀ��� ����';
COMMENT ON COLUMN HRD_OT_LINE.DANGJIK_YN IS '���� ����';
COMMENT ON COLUMN HRD_OT_LINE.ALL_NIGHT_YN IS 'ö�� ����';
COMMENT ON COLUMN HRD_OT_LINE.APPROVED_YN IS '�������α���';
COMMENT ON COLUMN HRD_OT_LINE.APPROVED_DATE IS '���� �����Ͻ�';
COMMENT ON COLUMN HRD_OT_LINE.APPROVED_PERSON_ID IS '���� ������';
COMMENT ON COLUMN HRD_OT_LINE.CONFIRMED_YN IS 'Ȯ�����α���-���ν� �ٹ�ī���� �ݿ�';
COMMENT ON COLUMN HRD_OT_LINE.CONFIRMED_DATE IS 'Ȯ�������Ͻ�';
COMMENT ON COLUMN HRD_OT_LINE.CONFIRMED_PERSON_ID IS 'Ȯ��������';
COMMENT ON COLUMN HRD_OT_LINE.APPROVE_STATUS IS '���λ���(N-���ι̿�û,A-�̽���,B-��������,C-Ȯ������,R-�ݷ�)';
COMMENT ON COLUMN HRD_OT_LINE.EMAIL_STATUS IS 'EMAIL �߼ۿ���(N-�̹߼�,AR/BR-�߼��غ�,AS/BS-�߼ۿϷ�)';
COMMENT ON COLUMN HRD_OT_LINE.CALENDAR_TRAN_YN IS '�ٹ�ī���� ���� ����';
COMMENT ON COLUMN HRD_OT_LINE.DESCRIPTION IS '���';
COMMENT ON COLUMN HRD_OT_LINE.REJECT_YN IS '�ݷ� ����';
COMMENT ON COLUMN HRD_OT_LINE.REJECT_DATE IS '�ݷ� �Ͻ�';
COMMENT ON COLUMN HRD_OT_LINE.REJECT_PERSON_ID IS '�ݷ� ó����'
COMMENT ON COLUMN HRD_OT_LINE.REJECT_REMARK IS '�ݷ�����';
COMMENT ON COLUMN HRD_OT_LINE.CREATION_DATE  IS '��������';
COMMENT ON COLUMN HRD_OT_LINE.CREATION_DATE  IS '��������';
COMMENT ON COLUMN HRD_OT_LINE.CREATED_BY IS '������';
COMMENT ON COLUMN HRD_OT_LINE.LAST_UPDATE_DATE IS '������������';
COMMENT ON COLUMN HRD_OT_LINE.LAST_UPDATED_BY IS '����������';

-- CREATE INDEX.
CREATE UNIQUE INDEX HRD_OT_LINE_U1 ON HRD_OT_LINE(OT_LINE_ID) TABLESPACE FCM_TS_IDX;
CREATE UNIQUE INDEX HRD_OT_LINE_U2 ON HRD_OT_LINE(REQ_NUM, PERSON_ID, WORK_DATE) TABLESPACE FCM_TS_IDX;
CREATE INDEX HRD_OT_LINE_N1 ON HRD_OT_LINE(PERSON_ID, WORK_DATE) TABLESPACE FCM_TS_IDX;

-- SEQUENCE.
DROP SEQUENCE HRD_OT_LINE_S1;
CREATE SEQUENCE HRD_OT_LINE_S1;

-- ANALYZE.
ANALYZE TABLE HRD_OT_LINE COMPUTE STATISTICS;
ANALYZE INDEX HRD_OT_LINE_U1 COMPUTE STATISTICS;
ANALYZE INDEX HRD_OT_LINE_N1 COMPUTE STATISTICS;
