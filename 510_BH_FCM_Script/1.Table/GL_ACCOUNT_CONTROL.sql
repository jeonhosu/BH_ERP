/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM - GL
/* Program Name : GL_ACCOUNT_CONTROL
/* Description  : ȸ�� ���� ���� ����
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE GL_ACCOUNT_CONTROL              
( ACCOUNT_CONTROL_ID    NUMBER          NOT NULL,	/* �������� ID */
  ACCOUNT_CODE          VARCHAR2(20)    NOT NULL,	/* �����ڵ� */
  ACCOUNT_DESC          VARCHAR2(100)   NOT NULL,	/* ������ */
  ACCOUNT_DESC_S        VARCHAR2(100)   ,	 /* ������ ��� */
  ACCOUNT_SET_ID        NUMBER          NOT NULL,	/* ��������ID */
  ACCOUNT_GROUP_ID      NUMBER          NOT NULL,	/* �����׷� ID */
  ACCOUNT_DR_CR      	  VARCHAR2(1)     NOT NULL,       /* ���� ���� (1-����, 2-�뺯) */
  ACCOUNT_GL_ID         NUMBER          ,  /* ����������� */
  ACCOUNT_FS_TYPE       VARCHAR2(10)    ,  /* �繫��ǥ�������� */
  CUSTOMER_ENABLED_FLAG VARCHAR2(1)     ,  /* �ŷ�ó �ܾװ���FLAG */  
  ACCOUNT_ENABLED_FLAG  VARCHAR2(1)     ,  /* �����ܾװ���FLAG */  
  BANK_ACCOUNT_FLAG     VARCHAR2(1)     ,  /* �����ܾװ��� FLAG */
  CURRENCY_ENABLED_FLAG VARCHAR2(1)     ,  /* ��ȭ����FLAG */  
  ACCOUNT_MICH_YN       VARCHAR2(1)     ,  /* �������� ��û�� ���� FLAG */
  VAT_ENABLED_FLAG      VARCHAR2(1)     ,  /* �ΰ�������FLAG */
  BUDGET_ENABLED_FLAG   VARCHAR2(1)     ,  /* ������FLAG */
  BUDGET_CONTROL_FLAG   VARCHAR2(1)     ,  /* ��������FLAG */
  BUDGET_BELONG_FLAG    VARCHAR2(1)     ,  /* ����ͼӺμ�FLAG */
  COST_CENTER_FLAG      VARCHAR2(1)     ,  /* �ڽ�Ʈ��ŸFLAG */  
  LIQUIDATE_METHOD_TYPE VARCHAR2(10)    ,  /* ����ó�� ��� */
  ACCOUNT_CLASS_ID      NUMBER          ,  /* �����з�ID */
  REMARK                VARCHAR2(200)   ,	 /* �������� */  
  ENABLED_FLAG          VARCHAR2(1)     DEFAULT 'Y',	 /* ��뿩�� */
  EFFECTIVE_DATE_FR     DATE            NOT NULL,	/* ���� �������� */
  EFFECTIVE_DATE_TO     DATE            ,	 /* ���� �������� */  
  CREATION_DATE         DATE            NOT NULL,	/* �������� */
  CREATED_BY            NUMBER          NOT NULL,	/* ������ */
  LAST_UPDATE_DATE      DATE            NOT NULL,	/* ������������ */
  LAST_UPDATED_BY       NUMBER          NOT NULL 	/* ���������� */
) TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON COLUMN GL_ACCOUNT_CONTROL.ACCOUNT_CONTROL_ID IS '�������� ID';
COMMENT ON COLUMN GL_ACCOUNT_CONTROL.ACCOUNT_CODE IS '�����ڵ�';
COMMENT ON COLUMN GL_ACCOUNT_CONTROL.ACCOUNT_DESC IS '������';
COMMENT ON COLUMN GL_ACCOUNT_CONTROL.ACCOUNT_DESC_S IS '������ ���';
COMMENT ON COLUMN GL_ACCOUNT_CONTROL.ACCOUNT_SET_ID IS '��������ID';
COMMENT ON COLUMN GL_ACCOUNT_CONTROL.ACCOUNT_GROUP_ID IS '�����׷� ID';
COMMENT ON COLUMN GL_ACCOUNT_CONTROL.ACCOUNT_DR_CR IS '���뱸��(1-����,2-�뺯)';
COMMENT ON COLUMN GL_ACCOUNT_CONTROL.ACCOUNT_GL_ID IS '�������';
COMMENT ON COLUMN GL_ACCOUNT_CONTROL.ACCOUNT_FS_TYPE IS '�繫��ǥ����';
COMMENT ON COLUMN GL_ACCOUNT_CONTROL.CUSTOMER_ENABLED_FLAG IS '�ŷ�ó����(Y/N)';
COMMENT ON COLUMN GL_ACCOUNT_CONTROL.ACCOUNT_ENABLED_FLAG IS '�����ܾװ���(Y/N)';
COMMENT ON COLUMN GL_ACCOUNT_CONTROL.BANK_ACCOUNT_FLAG IS '������� ����';
COMMENT ON COLUMN GL_ACCOUNT_CONTROL.CURRENCY_ENABLED_FLAG IS '��ȭ����(Y/N)';
COMMENT ON COLUMN GL_ACCOUNT_CONTROL.ACCOUNT_MICH_YN IS '���� ���� ��û�� ����(Y/N)';
COMMENT ON COLUMN GL_ACCOUNT_CONTROL.VAT_ENABLED_FLAG IS '�ΰ�������(Y/N)';
COMMENT ON COLUMN GL_ACCOUNT_CONTROL.BUDGET_ENABLED_FLAG IS '������(Y/N)';
COMMENT ON COLUMN GL_ACCOUNT_CONTROL.BUDGET_CONTROL_FLAG IS '��������(Y/N)';
COMMENT ON COLUMN GL_ACCOUNT_CONTROL.BUDGET_BELONG_FLAG IS '����ͼӺμ�(Y/N)';
COMMENT ON COLUMN GL_ACCOUNT_CONTROL.COST_CENTER_FLAG IS '�ڽ�Ʈ��ŸFLAG';
COMMENT ON COLUMN GL_ACCOUNT_CONTROL.LIQUIDATE_METHOD_TYPE IS '��üó�����';
COMMENT ON COLUMN GL_ACCOUNT_CONTROL.ACCOUNT_CLASS_ID IS '���� �з�ID';
COMMENT ON COLUMN GL_ACCOUNT_CONTROL.REMARK IS '���';
COMMENT ON COLUMN GL_ACCOUNT_CONTROL.ENABLED_FLAG IS '��뿩��';
COMMENT ON COLUMN GL_ACCOUNT_CONTROL.EFFECTIVE_DATE_FR IS '���� ��������';
COMMENT ON COLUMN GL_ACCOUNT_CONTROL.EFFECTIVE_DATE_TO IS '���� ��������';
COMMENT ON COLUMN GL_ACCOUNT_CONTROL.CREATION_DATE  IS '��������';
COMMENT ON COLUMN GL_ACCOUNT_CONTROL.CREATED_BY IS '������';
COMMENT ON COLUMN GL_ACCOUNT_CONTROL.LAST_UPDATE_DATE IS '������������';
COMMENT ON COLUMN GL_ACCOUNT_CONTROL.LAST_UPDATED_BY IS '����������';

-- CREATE INDEX.
CREATE UNIQUE INDEX GL_ACCOUNT_CONTROL_U1 ON GL_ACCOUNT_CONTROL(ACCOUNT_CONTROL_ID) TABLESPACE FCM_TS_IDX;
CREATE UNIQUE INDEX GL_ACCOUNT_CONTROL_U2 ON GL_ACCOUNT_CONTROL(ACCOUNT_CODE, ACCOUNT_SET_ID, ACCOUNT_GROUP_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX GL_ACCOUNT_CONTROL_N1 ON GL_ACCOUNT_CONTROL(ACCOUNT_GROUP_ID, EFFECTIVE_DATE_FR, EFFECTIVE_DATE_TO) TABLESPACE FCM_TS_IDX;
CREATE INDEX GL_ACCOUNT_CONTROL_N2 ON GL_ACCOUNT_CONTROL(ACCOUNT_SET_ID, EFFECTIVE_DATE_FR, EFFECTIVE_DATE_TO) TABLESPACE FCM_TS_IDX;

-- SEQUENCE.
DROP SEQUENCE GL_ACCOUNT_CONTROL_S1;
CREATE SEQUENCE GL_ACCOUNT_CONTROL_S1;

-- ANALYZE.
ANALYZE TABLE GL_ACCOUNT_CONTROL COMPUTE STATISTICS;
ANALYZE INDEX GL_ACCOUNT_CONTROL_U1 COMPUTE STATISTICS;
ANALYZE INDEX GL_ACCOUNT_CONTROL_U2 COMPUTE STATISTICS;
ANALYZE INDEX GL_ACCOUNT_CONTROL_N1 COMPUTE STATISTICS;
ANALYZE INDEX GL_ACCOUNT_CONTROL_N2 COMPUTE STATISTICS;