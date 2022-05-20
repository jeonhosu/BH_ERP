/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_BUDGET_ADD
/* Description  : ���� ���� ��û ����.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_BUDGET_ADD
( BUDGET_TYPE                     VARCHAR2(5)   NOT NULL
, BUDGET_PERIOD                   VARCHAR2(10)  NOT NULL
, DEPT_ID                         NUMBER        NOT NULL
, ACCOUNT_CONTROL_ID              NUMBER        NOT NULL
, ACCOUNT_CODE                    VARCHAR2(20)  NOT NULL
, SOB_ID                          NUMBER        NOT NULL
, ORG_ID                          NUMBER        NOT NULL
, CREATE_SEQ                      NUMBER        NOT NULL
, BUDGET_PERIOD_FR                VARCHAR2(10)  NOT NULL
, BUDGET_PERIOD_TO                VARCHAR2(10)  NOT NULL
, START_DATE                      DATE          NOT NULL
, END_DATE                        DATE          NOT NULL
, SAVE_SEQ                        NUMBER        DEFAULT 1
, AMOUNT                          NUMBER        DEFAULT 0
, CAUSE_ID                        NUMBER        NOT NULL
, LAST_YN                         CHAR(1)       DEFAULT 'Y'
, APPROVED_YN                     CHAR(1)       DEFAULT 'N'
, APPROVED_DATE                   DATE
, APPROVED_PERSON_ID              NUMBER
, CONFIRMED_YN                    CHAR(1)       DEFAULT 'N'
, CONFIRMED_DATE                  DATE
, CONFIRMED_PERSON_ID             NUMBER
, CLOSED_YN                       CHAR(1)       DEFAULT 'N'
, CLOSED_DATE                     DATE
, CLOSED_PERSON_ID                NUMBER
, APPROVE_STATUS                  VARCHAR2(5)   DEFAULT 'N'
, EMAIL_STATUS                    VARCHAR2(5)
, DESCRIPTION                     VARCHAR2(100)
, REJECT_REMARK                   VARCHAR2(100)
, ATTRIBUTE_A                     VARCHAR2(100)
, ATTRIBUTE_B                     VARCHAR2(100)
, ATTRIBUTE_C                     VARCHAR2(100)
, ATTRIBUTE_D                     VARCHAR2(100)
, ATTRIBUTE_E                     VARCHAR2(100)
, ATTRIBUTE_1                     NUMBER
, ATTRIBUTE_2                     NUMBER
, ATTRIBUTE_3                     NUMBER
, ATTRIBUTE_4                     NUMBER
, ATTRIBUTE_5                     NUMBER
, CREATION_DATE                   DATE          NOT NULL
, CREATED_BY                      NUMBER        NOT NULL
, LAST_UPDATE_DATE                DATE          NOT NULL
, LAST_UPDATED_BY                 NUMBER        NOT NULL
) TABLESPACE FCM_TS_DATA;

--> COMMENT.
COMMENT ON TABLE FI_BUDGET_ADD IS '���� ��û(����/����/�߰�) ����';
COMMENT ON COLUMN FI_BUDGET_ADD.BUDGET_TYPE IS '�߰�����Ÿ��(BUDGET_TYPE):1-���ʿ���, 2-��������,3-���׿���';
COMMENT ON COLUMN FI_BUDGET_ADD.BUDGET_PERIOD IS '����������';
COMMENT ON COLUMN FI_BUDGET_ADD.DEPT_ID IS '���Ǻμ�';
COMMENT ON COLUMN FI_BUDGET_ADD.ACCOUNT_CONTROL_ID IS '����(����)���� ID';
COMMENT ON COLUMN FI_BUDGET_ADD.ACCOUNT_CODE IS '����(����) �ڵ�';
COMMENT ON COLUMN FI_BUDGET_ADD.CREATE_SEQ IS '���� �Ϸù�ȣ';
COMMENT ON COLUMN FI_BUDGET_ADD.BUDGET_PERIOD_FR IS '���� ���� ���۳��';
COMMENT ON COLUMN FI_BUDGET_ADD.BUDGET_PERIOD_TO IS '���� ���� ������';
COMMENT ON COLUMN FI_BUDGET_ADD.START_DATE IS '���� ��������-�������� ���۳���� 1��';
COMMENT ON COLUMN FI_BUDGET_ADD.END_DATE IS '���� ��������->�������� �������� ����';
COMMENT ON COLUMN FI_BUDGET_ADD.SAVE_SEQ IS '���� �Ϸù�ȣ';
COMMENT ON COLUMN FI_BUDGET_ADD.AMOUNT IS '����ݾ�';
COMMENT ON COLUMN FI_BUDGET_ADD.CAUSE_ID IS '�����߰�����(BUDGET_CAUSE)';
COMMENT ON COLUMN FI_BUDGET_ADD.LAST_YN IS '�����ڷ� Y/N';
COMMENT ON COLUMN FI_BUDGET_ADD.APPROVED_YN IS '���ο���';
COMMENT ON COLUMN FI_BUDGET_ADD.APPROVED_DATE IS '��������';
COMMENT ON COLUMN FI_BUDGET_ADD.APPROVED_PERSON_ID IS '���� ó����';
COMMENT ON COLUMN FI_BUDGET_ADD.CONFIRMED_YN IS 'Ȯ������ ����';
COMMENT ON COLUMN FI_BUDGET_ADD.CONFIRMED_DATE IS 'Ȯ������ ����';
COMMENT ON COLUMN FI_BUDGET_ADD.CONFIRMED_PERSON_ID IS 'Ȯ������ ó����';
COMMENT ON COLUMN FI_BUDGET_ADD.APPROVE_STATUS IS '�������λ���';
COMMENT ON COLUMN FI_BUDGET_ADD.CLOSED_YN IS '��������';
COMMENT ON COLUMN FI_BUDGET_ADD.CLOSED_DATE IS '��������';
COMMENT ON COLUMN FI_BUDGET_ADD.CLOSED_PERSON_ID IS '����ó����';
COMMENT ON COLUMN FI_BUDGET_ADD.EMAIL_STATUS IS 'EMAIL �߼ۿ���(N-�̹߼�,AR/BR-�߼��غ�,AS/BS-�߼ۿϷ�)';

--> CREATE INDEX.
ALTER TABLE FI_BUDGET_ADD ADD CONSTRAINT FI_BUDGET_ADD_PK PRIMARY KEY (BUDGET_TYPE, BUDGET_PERIOD, DEPT_ID, ACCOUNT_CONTROL_ID, SOB_ID, SAVE_SEQ);
CREATE INDEX FI_BUDGET_ADD_N1 ON FI_BUDGET_ADD(BUDGET_TYPE, BUDGET_PERIOD, DEPT_ID, ACCOUNT_CONTROL_ID, LAST_YN, SOB_ID)
  TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_BUDGET_ADD_N2 ON FI_BUDGET_ADD(BUDGET_TYPE, BUDGET_PERIOD, DEPT_ID, ACCOUNT_CONTROL_ID, APPROVE_STATUS, LAST_YN, SOB_ID)
  TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_BUDGET_ADD_N3 ON FI_BUDGET_ADD(BUDGET_TYPE, BUDGET_PERIOD, DEPT_ID, ACCOUNT_CONTROL_ID, APPROVE_STATUS, EMAIL_STATUS, LAST_YN, SOB_ID)
  TABLESPACE FCM_TS_IDX;
