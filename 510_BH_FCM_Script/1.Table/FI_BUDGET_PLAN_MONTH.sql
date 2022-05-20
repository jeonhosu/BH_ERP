/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_BUDGET_PLAN_MONTH_PLAN_MONTH
/* Description  : (��) ���� �� --> ���� ���� Ȯ��.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_BUDGET_PLAN_MONTH
( BUDGET_PERIOD                   VARCHAR2(10)  NOT NULL
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
, BASE_AMOUNT                     NUMBER        DEFAULT 0
, BASE_MONTH_YN                   CHAR(1)       DEFAULT 'N'
, ENABLED_YN                      CHAR(1)       DEFAULT 'Y'
, LAST_YN                         CHAR(1)       DEFAULT 'Y'
, CONFIRMED_YN                    CHAR(1)       DEFAULT 'N'
, CONFIRMED_DATE                  DATE
, CONFIRMED_PERSON_ID             NUMBER
, CLOSED_YN                       CHAR(1)       DEFAULT 'N'
, CLOSED_DATE                     DATE
, CLOSED_PERSON_ID                NUMBER
, APPROVE_STATUS                  VARCHAR2(5)   DEFAULT 'N'
, EMAIL_STATUS                    VARCHAR2(5)
, DESCRIPTION                     VARCHAR2(100)
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
COMMENT ON TABLE FI_BUDGET_PLAN_MONTH IS '(��) ���� ��->���� ���� ���� �� ����';
COMMENT ON COLUMN FI_BUDGET_PLAN_MONTH.BUDGET_PERIOD IS '������';
COMMENT ON COLUMN FI_BUDGET_PLAN_MONTH.DEPT_ID IS '���Ǻμ�';
COMMENT ON COLUMN FI_BUDGET_PLAN_MONTH.ACCOUNT_CONTROL_ID IS '�������� ID';
COMMENT ON COLUMN FI_BUDGET_PLAN_MONTH.ACCOUNT_CODE IS '���� �ڵ�';
COMMENT ON COLUMN FI_BUDGET_PLAN_MONTH.CREATE_SEQ IS '���� �Ϸù�ȣ';
COMMENT ON COLUMN FI_BUDGET_PLAN_MONTH.BUDGET_PERIOD_FR IS '���� ���� ���۳��';
COMMENT ON COLUMN FI_BUDGET_PLAN_MONTH.BUDGET_PERIOD_TO IS '���� ���� ������';
COMMENT ON COLUMN FI_BUDGET_PLAN_MONTH.START_DATE IS '���� ��������-�������� ���۳���� 1��';
COMMENT ON COLUMN FI_BUDGET_PLAN_MONTH.END_DATE IS '���� ��������->�������� �������� ����';
COMMENT ON COLUMN FI_BUDGET_PLAN_MONTH.SAVE_SEQ IS '���� �Ϸù�ȣ';
COMMENT ON COLUMN FI_BUDGET_PLAN_MONTH.BASE_AMOUNT IS '���ݾ�';
COMMENT ON COLUMN FI_BUDGET_PLAN_MONTH.BASE_MONTH_YN IS '�� ������ ����';
COMMENT ON COLUMN FI_BUDGET_PLAN_MONTH.ENABLED_YN IS '��뿩��';
COMMENT ON COLUMN FI_BUDGET_PLAN_MONTH.LAST_YN IS '��������';
COMMENT ON COLUMN FI_BUDGET_PLAN_MONTH.CONFIRMED_YN IS 'Ȯ�����ο���';
COMMENT ON COLUMN FI_BUDGET_PLAN_MONTH.CONFIRMED_DATE IS 'Ȯ�������Ͻ�';
COMMENT ON COLUMN FI_BUDGET_PLAN_MONTH.CONFIRMED_PERSON_ID IS 'Ȯ��������';
COMMENT ON COLUMN FI_BUDGET_PLAN_MONTH.APPROVE_STATUS IS '���λ���';
COMMENT ON COLUMN FI_BUDGET_PLAN_MONTH.EMAIL_STATUS IS 'EMAIL �߼ۿ���(N-�̹߼�,AR/BR-�߼��غ�,AS/BS-�߼ۿϷ�)';
COMMENT ON COLUMN FI_BUDGET_PLAN_MONTH.CLOSED_YN IS '��������';
COMMENT ON COLUMN FI_BUDGET_PLAN_MONTH.CLOSED_DATE IS '�����Ͻ�';
COMMENT ON COLUMN FI_BUDGET_PLAN_MONTH.CLOSED_PERSON_ID IS '����ó����';
COMMENT ON COLUMN FI_BUDGET_PLAN_MONTH.DESCRIPTION IS '���';


--> CREATE INDEX.
ALTER TABLE FI_BUDGET_PLAN_MONTH ADD CONSTRAINT FI_BUDGET_PLAN_MONTH_PK PRIMARY KEY (BUDGET_PERIOD, DEPT_ID, ACCOUNT_CONTROL_ID, SOB_ID, SAVE_SEQ);

CREATE INDEX FI_BUDGET_PLAN_MONTH_N1 ON FI_BUDGET_PLAN_MONTH(ACCOUNT_CONTROL_ID, SOB_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_BUDGET_PLAN_MONTH_N2 ON FI_BUDGET_PLAN_MONTH(DEPT_ID, ACCOUNT_CONTROL_ID, SOB_ID, CREATE_SEQ) TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_BUDGET_PLAN_MONTH_N3 ON FI_BUDGET_PLAN_MONTH(BUDGET_PERIOD, ACCOUNT_CONTROL_ID, DEPT_ID, SOB_ID, LAST_YN) TABLESPACE FCM_TS_IDX;
