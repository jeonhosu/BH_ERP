/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM - GL
/* Program Name : FI_CLOSING_AMOUNT
/* Description  : ȸ�� ��� ��ü �ݾ� ����
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_CLOSING_AMOUNT              
( PERIOD_NAME           VARCHAR2(10)    NOT NULL,  /* ���� ��� */
  CLOSING_GROUP         VARCHAR2(20)    ,          /* �����׷� */
  ACCOUNT_CONTROL_ID    NUMBER          ,          /* �������� ID */
  ACCOUNT_CODE          VARCHAR2(20)    ,          /* �����ڵ� */
  ACCOUNT_DR_CR         VARCHAR2(1)     ,          /* ���뱸�� */
  SOB_ID                NUMBER          NOT NULL,
  ORG_ID                NUMBER          NOT NULL,
  AMOUNT                NUMBER          DEFAULT 0,  
  REMARK                VARCHAR2(200)   ,          /* �������� */  
  CREATION_DATE         DATE            NOT NULL,  /* �������� */
  CREATED_BY            NUMBER          NOT NULL,  /* ������ */
  LAST_UPDATE_DATE      DATE            NOT NULL,  /* ������������ */
  LAST_UPDATED_BY       NUMBER          NOT NULL   /* ���������� */
) TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON TABLE FI_CLOSING_AMOUNT IS '��� ��ü �ݾ� ����';
COMMENT ON COLUMN FI_CLOSING_AMOUNT.PERIOD_NAME IS '�������';
COMMENT ON COLUMN FI_CLOSING_AMOUNT.CLOSING_GROUP IS '������ �׷�';
COMMENT ON COLUMN FI_CLOSING_AMOUNT.ACCOUNT_CONTROL_ID IS '�������� ID';
COMMENT ON COLUMN FI_CLOSING_AMOUNT.ACCOUNT_CODE IS '�����ڵ�';
COMMENT ON COLUMN FI_CLOSING_AMOUNT.AMOUNT IS '�ݾ�';
COMMENT ON COLUMN FI_CLOSING_AMOUNT.REMARK IS '���';
COMMENT ON COLUMN FI_CLOSING_AMOUNT.CREATION_DATE  IS '��������';
COMMENT ON COLUMN FI_CLOSING_AMOUNT.CREATED_BY IS '������';
COMMENT ON COLUMN FI_CLOSING_AMOUNT.LAST_UPDATE_DATE IS '������������';
COMMENT ON COLUMN FI_CLOSING_AMOUNT.LAST_UPDATED_BY IS '����������';

-- CREATE INDEX.
CREATE INDEX FI_CLOSING_AMOUNT_N1 ON FI_CLOSING_AMOUNT(ACCOUNT_CONTROL_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_CLOSING_AMOUNT_N2 ON FI_CLOSING_AMOUNT(ACCOUNT_CODE, SOB_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_CLOSING_AMOUNT_N3 ON FI_CLOSING_AMOUNT(PERIOD_NAME, SOB_ID) TABLESPACE FCM_TS_IDX;

-- ANALYZE.
ANALYZE TABLE FI_CLOSING_AMOUNT COMPUTE STATISTICS;
ANALYZE INDEX FI_CLOSING_AMOUNT_N1 COMPUTE STATISTICS;
ANALYZE INDEX FI_CLOSING_AMOUNT_N2 COMPUTE STATISTICS;
ANALYZE INDEX FI_CLOSING_AMOUNT_N3 COMPUTE STATISTICS;
