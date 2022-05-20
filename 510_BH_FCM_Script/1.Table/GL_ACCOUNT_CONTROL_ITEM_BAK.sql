/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM - GL
/* Program Name : GL_ACCOUNT_CONTROL_ITEM_ITEM
/* Description  : ȸ�� �����ڵ� �����׸�.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE GL_ACCOUNT_CONTROL_ITEM              
( ACCOUNT_CONTROL_ID    NUMBER          NOT NULL,  /* �������� ID */
  ACCOUNT_CODE          VARCHAR2(20)    NOT NULL,  /* �����ڵ� */
  SOB_ID                NUMBER          NOT NULL,  /* ȸ������ */
  ORG_ID                NUMBER          NOT NULL,  /* �����ID */
  ACCOUNT_DR_CR         VARCHAR2(1)     NOT NULL,  /* ���� ���� (1-����, 2-�뺯) */
  MANAGEMENT_ID         NUMBER          NOT NULL,  /* �����׸� ID */
  MANAGEMENT_SEQ        NUMBER          ,  /* �����׸� ���� */
  MANAGEMENT_FLAG       VARCHAR2(1)     ,  /* �������� �׸� �ʼ� FLAG */
  BALANCE_FLAG          VARCHAR2(1)     ,  /* �ܾ� ���� FLAG */
  ENABLED_FLAG          VARCHAR2(1)     DEFAULT 'Y',   /* ��뿩�� */
  EFFECTIVE_DATE_FR     DATE            NOT NULL,  /* ���� �������� */
  EFFECTIVE_DATE_TO     DATE            ,   /* ���� �������� */  
  CREATION_DATE         DATE            NOT NULL,  /* �������� */
  CREATED_BY            NUMBER          NOT NULL,  /* ������ */
  LAST_UPDATE_DATE      DATE            NOT NULL,  /* ������������ */
  LAST_UPDATED_BY       NUMBER          NOT NULL   /* ���������� */
) TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON TABLE GL_ACCOUNT_CONTROL_ITEM IS '��������';
COMMENT ON COLUMN GL_ACCOUNT_CONTROL_ITEM.ACCOUNT_CONTROL_ID IS '�������� ID';
COMMENT ON COLUMN GL_ACCOUNT_CONTROL_ITEM.ACCOUNT_CODE IS '�����ڵ�';
COMMENT ON COLUMN GL_ACCOUNT_CONTROL_ITEM.SOB_ID IS 'ȸ������';
COMMENT ON COLUMN GL_ACCOUNT_CONTROL_ITEM.ORG_ID IS '�����ID';
COMMENT ON COLUMN GL_ACCOUNT_CONTROL_ITEM.ACCOUNT_DR_CR IS '���뱸��(1-����,2-�뺯)';
COMMENT ON COLUMN GL_ACCOUNT_CONTROL_ITEM.MANAGEMENT_ID IS '�����׸�ID(�����ڵ�)';
COMMENT ON COLUMN GL_ACCOUNT_CONTROL_ITEM.MANAGEMENT_SEQ IS '�����׸� ����';
COMMENT ON COLUMN GL_ACCOUNT_CONTROL_ITEM.MANAGEMENT_FLAG IS '�����׸� �ʼ�FLAG';
COMMENT ON COLUMN GL_ACCOUNT_CONTROL_ITEM.BALANCE_FLAG IS '�ܾװ���FLAG';
COMMENT ON COLUMN GL_ACCOUNT_CONTROL_ITEM.ENABLED_FLAG IS '��뿩��';
COMMENT ON COLUMN GL_ACCOUNT_CONTROL_ITEM.EFFECTIVE_DATE_FR IS '���� ��������';
COMMENT ON COLUMN GL_ACCOUNT_CONTROL_ITEM.EFFECTIVE_DATE_TO IS '���� ��������';
COMMENT ON COLUMN GL_ACCOUNT_CONTROL_ITEM.CREATION_DATE  IS '��������';
COMMENT ON COLUMN GL_ACCOUNT_CONTROL_ITEM.CREATED_BY IS '������';
COMMENT ON COLUMN GL_ACCOUNT_CONTROL_ITEM.LAST_UPDATE_DATE IS '������������';
COMMENT ON COLUMN GL_ACCOUNT_CONTROL_ITEM.LAST_UPDATED_BY IS '����������';

-- CREATE INDEX.
CREATE UNIQUE INDEX GL_ACCOUNT_CONTROL_ITEM_U1 ON GL_ACCOUNT_CONTROL_ITEM(ACCOUNT_CONTROL_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX GL_ACCOUNT_CONTROL_ITEM_N1 ON GL_ACCOUNT_CONTROL_ITEM(SOB_ID, ORG_ID, ACCOUNT_CODE, ENABLED_FLAG, EFFECTIVE_DATE_FR, EFFECTIVE_DATE_TO) TABLESPACE FCM_TS_IDX;

-- ANALYZE.
ANALYZE TABLE GL_ACCOUNT_CONTROL_ITEM COMPUTE STATISTICS;
ANALYZE INDEX GL_ACCOUNT_CONTROL_ITEM_U1 COMPUTE STATISTICS;
ANALYZE INDEX GL_ACCOUNT_CONTROL_ITEM_N1 COMPUTE STATISTICS;
