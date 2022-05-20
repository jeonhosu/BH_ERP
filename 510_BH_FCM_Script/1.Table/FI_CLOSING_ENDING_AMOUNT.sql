/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM - GL
/* Program Name : FI_CLOSING_ENDING_AMOUNT
/* Description  : ȸ�� ��� �⸻�ݾ� ����.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_CLOSING_ENDING_AMOUNT              
( PERIOD_NAME           VARCHAR2(10)    NOT NULL,  /* ȸ���� */
  ACCOUNT_CONTROL_ID    NUMBER          NOT NULL,  /* �������� ID */
  SOB_ID                NUMBER          NOT NULL,
  ORG_ID                NUMBER          NOT NULL,
  ENDING_AMOUNT         NUMBER          DEFAULT 0,
  REMARK                VARCHAR2(200)   ,          /* �������� */  
  CREATION_DATE         DATE            NOT NULL,  /* �������� */
  CREATED_BY            NUMBER          NOT NULL,  /* ������ */
  LAST_UPDATE_DATE      DATE            NOT NULL,  /* ������������ */
  LAST_UPDATED_BY       NUMBER          NOT NULL   /* ���������� */
) TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON TABLE FI_CLOSING_ENDING_AMOUNT IS '��� �⸻�ݾ� ����';
COMMENT ON COLUMN FI_CLOSING_ENDING_AMOUNT.PERIOD_NAME IS 'ȸ����';
COMMENT ON COLUMN FI_CLOSING_ENDING_AMOUNT.ACCOUNT_CONTROL_ID IS '�������� ID';
COMMENT ON COLUMN FI_CLOSING_ENDING_AMOUNT.ENDING_AMOUNT IS '�⸻�ݾ�';
COMMENT ON COLUMN FI_CLOSING_ENDING_AMOUNT.REMARK IS '���';
COMMENT ON COLUMN FI_CLOSING_ENDING_AMOUNT.CREATION_DATE  IS '��������';
COMMENT ON COLUMN FI_CLOSING_ENDING_AMOUNT.CREATED_BY IS '������';
COMMENT ON COLUMN FI_CLOSING_ENDING_AMOUNT.LAST_UPDATE_DATE IS '������������';
COMMENT ON COLUMN FI_CLOSING_ENDING_AMOUNT.LAST_UPDATED_BY IS '����������';

-- CREATE INDEX.
CREATE UNIQUE INDEX FI_CLOSING_ENDING_AMOUNT_U1 ON FI_CLOSING_ENDING_AMOUNT(PERIOD_NAME, ACCOUNT_CONTROL_ID, SOB_ID) TABLESPACE FCM_TS_IDX;

-- ANALYZE.
ANALYZE TABLE FI_CLOSING_ENDING_AMOUNT COMPUTE STATISTICS;
ANALYZE INDEX FI_CLOSING_ENDING_AMOUNT_U1 COMPUTE STATISTICS;
