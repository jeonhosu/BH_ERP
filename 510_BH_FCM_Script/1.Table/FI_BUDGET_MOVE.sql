/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_BUDGET_MOVE
/* Description  : ���� ���� ���� ��û/���� ����(HISTORY ����).
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
--> CREATE TABLE.
CREATE TABLE FI_BUDGET_MOVE
( BUDGET_PERIOD                   VARCHAR2(10)  NOT NULL
, FROM_DEPT_ID                    NUMBER        NOT NULL
, FROM_ACCOUNT_CONTROL_ID         NUMBER        NOT NULL
, FROM_ACCOUNT_CODE               VARCHAR2(20)  NOT NULL
, TO_DEPT_ID                      NUMBER        NOT NULL
, TO_ACCOUNT_CONTROL_ID           NUMBER        NOT NULL
, TO_ACCOUNT_CODE                 VARCHAR2(20)  NOT NULL
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
COMMENT ON TABLE FI_BUDGET_MOVE IS '���� ���� ����';
COMMENT ON COLUMN FI_BUDGET_MOVE.BUDGET_PERIOD IS '����������';
COMMENT ON COLUMN FI_BUDGET_MOVE.FROM_DEPT_ID IS '���� ���Ǻμ�';
COMMENT ON COLUMN FI_BUDGET_MOVE.FROM_ACCOUNT_CONTROL_ID IS '���� ����(����)����ID';
COMMENT ON COLUMN FI_BUDGET_MOVE.FROM_ACCOUNT_CODE IS '���� ����(����) �ڵ�';
COMMENT ON COLUMN FI_BUDGET_MOVE.TO_DEPT_ID IS '���� ���Ǻμ�';
COMMENT ON COLUMN FI_BUDGET_MOVE.TO_ACCOUNT_CONTROL_ID IS '���� ����(����)����ID';
COMMENT ON COLUMN FI_BUDGET_MOVE.TO_ACCOUNT_CODE IS '���� ����(����) �ڵ�';
COMMENT ON COLUMN FI_BUDGET_MOVE.CREATE_SEQ IS '���� �Ϸù�ȣ';
COMMENT ON COLUMN FI_BUDGET_MOVE.BUDGET_PERIOD_FR IS '���� ���� ���۳��';
COMMENT ON COLUMN FI_BUDGET_MOVE.BUDGET_PERIOD_TO IS '���� ���� ������';
COMMENT ON COLUMN FI_BUDGET_MOVE.START_DATE IS '���� ��������-�������� ���۳���� 1��';
COMMENT ON COLUMN FI_BUDGET_MOVE.END_DATE IS '���� ��������->�������� �������� ����';
COMMENT ON COLUMN FI_BUDGET_MOVE.SAVE_SEQ IS '���� �Ϸù�ȣ';
COMMENT ON COLUMN FI_BUDGET_MOVE.AMOUNT IS '���� ����ݾ�';
COMMENT ON COLUMN FI_BUDGET_MOVE.CAUSE_ID IS '�����������(BUDGET_CAUSE)';
COMMENT ON COLUMN FI_BUDGET_MOVE.LAST_YN IS '�����ڷ� Y/N';
COMMENT ON COLUMN FI_BUDGET_MOVE.APPROVED_YN IS '���ο���';
COMMENT ON COLUMN FI_BUDGET_MOVE.APPROVED_DATE IS '��������';
COMMENT ON COLUMN FI_BUDGET_MOVE.APPROVED_PERSON_ID IS '���� ó����';
COMMENT ON COLUMN FI_BUDGET_MOVE.CONFIRMED_YN IS 'Ȯ������ ����';
COMMENT ON COLUMN FI_BUDGET_MOVE.CONFIRMED_DATE IS 'Ȯ������ ����';
COMMENT ON COLUMN FI_BUDGET_MOVE.CONFIRMED_PERSON_ID IS 'Ȯ������ ó����';
COMMENT ON COLUMN FI_BUDGET_MOVE.APPROVE_STATUS IS '�������λ���';
COMMENT ON COLUMN FI_BUDGET_MOVE.CLOSED_YN IS '��������';
COMMENT ON COLUMN FI_BUDGET_MOVE.CLOSED_DATE IS '��������';
COMMENT ON COLUMN FI_BUDGET_MOVE.CLOSED_PERSON_ID IS '����ó����';
COMMENT ON COLUMN FI_BUDGET_MOVE.EMAIL_STATUS IS 'EMAIL �߼ۿ���(N-�̹߼�,AR/BR-�߼��غ�,AS/BS-�߼ۿϷ�)';

--> CREATE INDEX.
ALTER TABLE FI_BUDGET_MOVE ADD CONSTRAINT FI_BUDGET_MOVE_PK PRIMARY KEY (BUDGET_PERIOD, FROM_DEPT_ID, FROM_ACCOUNT_CONTROL_ID, TO_DEPT_ID, TO_ACCOUNT_CONTROL_ID, SOB_ID, SAVE_SEQ);

CREATE INDEX FI_BUDGET_MOVE_N1 ON FI_BUDGET_MOVE(BUDGET_PERIOD, FROM_DEPT_ID, FROM_ACCOUNT_CONTROL_ID, SOB_ID)
  TABLESPACE FCM_TS_IDX;

CREATE INDEX FI_BUDGET_MOVE_N2 ON FI_BUDGET_MOVE(BUDGET_PERIOD, TO_DEPT_ID, TO_ACCOUNT_CONTROL_ID, SOB_ID)
  TABLESPACE FCM_TS_IDX;
  
CREATE INDEX FI_BUDGET_MOVE_N3 ON FI_BUDGET_MOVE(BUDGET_PERIOD, APPROVE_STATUS, SOB_ID)
  TABLESPACE FCM_TS_IDX;

CREATE INDEX FI_BUDGET_MOVE_N4 ON FI_BUDGET_MOVE(BUDGET_PERIOD, LAST_YN, SOB_ID)
  TABLESPACE FCM_TS_IDX;
  
CREATE INDEX FI_BUDGET_MOVE_N5 ON FI_BUDGET_MOVE(BUDGET_PERIOD, EMAIL_STATUS, SOB_ID)
  TABLESPACE FCM_TS_IDX;
    
