/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_BUDGET
/* Description  : ���� ���� Ȯ�� ����.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_BUDGET
( BUDGET_PERIOD                   VARCHAR2(10)  NOT NULL
, DEPT_ID                         NUMBER        NOT NULL
, ACCOUNT_CONTROL_ID              NUMBER        NOT NULL
, ACCOUNT_CODE                    VARCHAR2(20)  NOT NULL
, SOB_ID                          NUMBER        NOT NULL
, ORG_ID                          NUMBER        NOT NULL
, BUDGET_PERIOD_FR                VARCHAR2(10)  NOT NULL
, BUDGET_PERIOD_TO                VARCHAR2(10)  NOT NULL
, START_DATE                      DATE          NOT NULL
, END_DATE                        DATE          NOT NULL
, PRE_NEXT_AMOUNT                 NUMBER        DEFAULT 0
, BASE_AMOUNT                     NUMBER        DEFAULT 0
, ADD_AMOUNT                      NUMBER        DEFAULT 0
, MOVE_AMOUNT                     NUMBER        DEFAULT 0
, NEXT_AMOUNT                     NUMBER        DEFAULT 0
, BASE_MONTH_YN                   CHAR(1)       DEFAULT 'N'
, MOVE_YN                         CHAR(1)       DEFAULT 'N'
, NEXT_YN                         CHAR(1)       DEFAULT 'N'
, ENABLED_YN                      CHAR(1)       DEFAULT 'Y'
, CLOSED_YN                       CHAR(1)       DEFAULT 'N'
, CLOSED_DATE                     DATE
, CLOSED_PERSON_ID                NUMBER
, USE_AMOUNT                      NUMBER        DEFAULT 0
, REMAIN_AMOUNT                   NUMBER        DEFAULT 0
, DESCRIPTION                     VARCHAR2(100)
, CREATE_SEQ                      NUMBER        NOT NULL
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
COMMENT ON TABLE FI_BUDGET IS '�����������';
COMMENT ON COLUMN FI_BUDGET.BUDGET_PERIOD IS '����������';
COMMENT ON COLUMN FI_BUDGET.DEPT_ID IS '���Ǻμ�';
COMMENT ON COLUMN FI_BUDGET.ACCOUNT_CONTROL_ID IS '�������� ID';
COMMENT ON COLUMN FI_BUDGET.ACCOUNT_CODE IS '���� �ڵ�';
COMMENT ON COLUMN FI_BUDGET.BUDGET_PERIOD_FR IS '���� ���� ���۳��';
COMMENT ON COLUMN FI_BUDGET.BUDGET_PERIOD_TO IS '���� ���� ������';
COMMENT ON COLUMN FI_BUDGET.START_DATE IS '���� ��������-�������� ���۳���� 1��';
COMMENT ON COLUMN FI_BUDGET.END_DATE IS '���� ��������->�������� �������� ����';
COMMENT ON COLUMN FI_BUDGET.PRE_NEXT_AMOUNT IS '�̿� ���� ����ݾ�';
COMMENT ON COLUMN FI_BUDGET.BASE_AMOUNT IS '�ʱ⿹��ݾ�';
COMMENT ON COLUMN FI_BUDGET.ADD_AMOUNT IS '�߰�����ݾ�';
COMMENT ON COLUMN FI_BUDGET.MOVE_AMOUNT IS '���뿹��ݾ�';
COMMENT ON COLUMN FI_BUDGET.NEXT_AMOUNT IS '�̿��� ����ݾ�';
COMMENT ON COLUMN FI_BUDGET.BASE_MONTH_YN IS '�� ������ ����';
COMMENT ON COLUMN FI_BUDGET.MOVE_YN IS '�������� Y/N';
COMMENT ON COLUMN FI_BUDGET.NEXT_YN IS '�ܾ� �̿����� Y/N';
COMMENT ON COLUMN FI_BUDGET.ENABLED_YN IS '��뿩��';
COMMENT ON COLUMN FI_BUDGET.CLOSED_YN IS '�������� Y/N';
COMMENT ON COLUMN FI_BUDGET.CLOSED_DATE IS '��������';
COMMENT ON COLUMN FI_BUDGET.CLOSED_PERSON_ID IS '����ó����';
COMMENT ON COLUMN FI_BUDGET.USE_AMOUNT IS '��� �ݾ�';
COMMENT ON COLUMN FI_BUDGET.REMAIN_AMOUNT IS '�ܾ�';
COMMENT ON COLUMN FI_BUDGET.DESCRIPTION IS '���';
COMMENT ON COLUMN FI_BUDGET.CREATE_SEQ IS '���� �Ϸù�ȣ'

--> CREATE INDEX.
ALTER TABLE FI_BUDGET ADD CONSTRAINT FI_BUDGET_PK PRIMARY KEY (BUDGET_PERIOD, DEPT_ID, ACCOUNT_CONTROL_ID, SOB_ID);
CREATE INDEX FI_BUDGET_N1 ON FI_BUDGET(DEPT_ID, ACCOUNT_CONTROL_ID, START_DATE, END_DATE, ENABLED_YN, SOB_ID)
  TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_BUDGET_N2 ON FI_BUDGET(BUDGET_PERIOD_FR, BUDGET_PERIOD_TO, DEPT_ID, ACCOUNT_CONTROL_ID, ENABLED_YN, SOB_ID)
  TABLESPACE FCM_TS_IDX;  
CREATE INDEX FI_BUDGET_N3 ON FI_BUDGET(BUDGET_PERIOD, DEPT_ID, ACCOUNT_CONTROL_ID, ENABLED_YN, MOVE_YN, SOB_ID)
  TABLESPACE FCM_TS_IDX;  
CREATE INDEX FI_BUDGET_N4 ON FI_BUDGET(BUDGET_PERIOD, DEPT_ID, ACCOUNT_CONTROL_ID, ENABLED_YN, NEXT_YN, SOB_ID)
  TABLESPACE FCM_TS_IDX;
  

