/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM - GL
/* Program Name : FI_ACCOUNT_CONTROL_ITEM
/* Description  : ȸ�� �����ڵ� �����׸�.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_ACCOUNT_CONTROL_ITEM              
( ACCOUNT_CONTROL_ID    NUMBER           NOT NULL,	/* �������� ID */
  ACCOUNT_CODE          VARCHAR2(20)     NOT NULL,	/* �����ڵ� */
  SOB_ID                NUMBER           NOT NULL,	/* ȸ������ */
  ORG_ID                NUMBER           NOT NULL,	/* �����ID */
  MANAGEMENT1_ID        NUMBER           ,	/* �ܾװ����׸��ڵ�1 */
  MANAGEMENT2_ID        NUMBER           ,	/* �ܾװ����׸��ڵ�2 */
  REFER1_ID             NUMBER           ,	/* �����׸��ڵ�1 */
  REFER2_ID             NUMBER           ,	/* �����׸��ڵ�2 */
  REFER3_ID             NUMBER           ,	/* �����׸��ڵ�3 */
  REFER4_ID             NUMBER           ,	/* �����׸��ڵ�4 */
  REFER5_ID             NUMBER           ,	/* �����׸��ڵ�5 */
  REFER6_ID             NUMBER           ,	/* �����׸��ڵ�6 */
  REFER7_ID             NUMBER           ,	/* �����׸��ڵ�7 */
  REFER8_ID             NUMBER           ,	/* �����׸��ڵ�8 */
  REFER9_ID             NUMBER           ,  /* �����׸��ڵ�9 */
  REFER_RATE_ID         NUMBER           ,  /* �������ڵ� */
  REFER_AMOUNT_ID       NUMBER           ,  /* �����ݾ��ڵ� */
  REFER_DATE1_ID        NUMBER           ,  /* ���������ڵ�1 */
  REFER_DATE2_ID        NUMBER           ,  /* ���������ڵ�2 */
  VOUCH_ID              NUMBER           ,	/* �������� ID */  
  MANAGEMENT1_YN        VARCHAR2(1)      DEFAULT 'N',  /* �ܾװ����׸��ʼ����� */
  MANAGEMENT2_YN        VARCHAR2(1)      DEFAULT 'N',  /* �ܾװ����׸��ʼ����� */  
  REFER1_YN             VARCHAR2(1)      DEFAULT 'N',  /* �����׸��ʼ�����1 */
  REFER2_YN             VARCHAR2(1)      DEFAULT 'N',  /* �����׸��ʼ�����2 */
  REFER3_YN             VARCHAR2(1)      DEFAULT 'N',  /* �����׸��ʼ�����3 */
  REFER4_YN             VARCHAR2(1)      DEFAULT 'N',  /* �����׸��ʼ�����4 */
  REFER5_YN             VARCHAR2(1)      DEFAULT 'N',  /* �����׸��ʼ�����5 */
  REFER6_YN             VARCHAR2(1)      DEFAULT 'N',  /* �����׸��ʼ�����6 */
  REFER7_YN             VARCHAR2(1)      DEFAULT 'N',  /* �����׸��ʼ�����7 */
  REFER8_YN             VARCHAR2(1)      DEFAULT 'N',  /* �����׸��ʼ�����8 */
  REFER9_YN             VARCHAR2(1)      DEFAULT 'N',  /* �����׸��ʼ�����9 */
  REFER_RATE_YN         VARCHAR2(1)      DEFAULT 'N',  /* �������ʼ����� */  
  REFER_AMOUNT_YN       VARCHAR2(1)      DEFAULT 'N',  /* �����ݾ��ʼ����� */
  REFER_DATE1_YN        VARCHAR2(1)      DEFAULT 'N',  /* ���������ʼ�����1 */
  REFER_DATE2_YN        VARCHAR2(1)      DEFAULT 'N',  /* ���������ʼ�����2 */
  VOUCH_YN              VARCHAR2(1)      DEFAULT 'N',	/* ������������ */  
  CREATION_DATE         DATE             NOT NULL,  /* �������� */
  CREATED_BY            NUMBER           NOT NULL,  /* ������ */
  LAST_UPDATE_DATE      DATE             NOT NULL,  /* ������������ */
  LAST_UPDATED_BY       NUMBER           NOT NULL   /* ���������� */
) TABLESPACE FCM_TS_DATA;

COMMENT ON TABLE FI_ACCOUNT_CONTROL_ITEM IS 'ȸ�� �����ڵ� �����׸�';
COMMENT ON COLUMN FI_ACCOUNT_CONTROL_ITEM.ACCOUNT_CONTROL_ID IS '�������� ID';
COMMENT ON COLUMN FI_ACCOUNT_CONTROL_ITEM.ACCOUNT_CODE IS '�����ڵ�';
COMMENT ON COLUMN FI_ACCOUNT_CONTROL_ITEM.SOB_ID IS 'ȸ������';
COMMENT ON COLUMN FI_ACCOUNT_CONTROL_ITEM.ORG_ID IS '�����ID';
COMMENT ON COLUMN FI_ACCOUNT_CONTROL_ITEM.MANAGEMENT1_ID IS '�ܾװ����׸�ID1';
COMMENT ON COLUMN FI_ACCOUNT_CONTROL_ITEM.MANAGEMENT2_ID IS '�ܾװ����׸�ID2';
COMMENT ON COLUMN FI_ACCOUNT_CONTROL_ITEM.REFER1_ID IS '�����׸�ID1';
COMMENT ON COLUMN FI_ACCOUNT_CONTROL_ITEM.REFER2_ID IS '�����׸�ID2';
COMMENT ON COLUMN FI_ACCOUNT_CONTROL_ITEM.REFER3_ID IS '�����׸�ID3';
COMMENT ON COLUMN FI_ACCOUNT_CONTROL_ITEM.REFER4_ID IS '�����׸�ID4';
COMMENT ON COLUMN FI_ACCOUNT_CONTROL_ITEM.REFER5_ID IS '�����׸�ID5';
COMMENT ON COLUMN FI_ACCOUNT_CONTROL_ITEM.REFER6_ID IS '�����׸�ID6';
COMMENT ON COLUMN FI_ACCOUNT_CONTROL_ITEM.REFER7_ID IS '�����׸�ID7';
COMMENT ON COLUMN FI_ACCOUNT_CONTROL_ITEM.REFER8_ID IS '�����׸�ID8';
COMMENT ON COLUMN FI_ACCOUNT_CONTROL_ITEM.REFER9_ID IS '�����׸�ID9';
COMMENT ON COLUMN FI_ACCOUNT_CONTROL_ITEM.REFER_RATE_ID IS '������ID';
COMMENT ON COLUMN FI_ACCOUNT_CONTROL_ITEM.REFER_AMOUNT_ID IS '�����ݾ�ID';
COMMENT ON COLUMN FI_ACCOUNT_CONTROL_ITEM.REFER_DATE1_ID IS '��������ID1';
COMMENT ON COLUMN FI_ACCOUNT_CONTROL_ITEM.REFER_DATE2_ID IS '��������ID2';
COMMENT ON COLUMN FI_ACCOUNT_CONTROL_ITEM.VOUCH_ID IS '��������ID';
COMMENT ON COLUMN FI_ACCOUNT_CONTROL_ITEM.MANAGEMENT1_YN IS '�ܾװ����׸��ʼ�����';
COMMENT ON COLUMN FI_ACCOUNT_CONTROL_ITEM.MANAGEMENT2_YN IS '�ܾװ����׸��ʼ�����';
COMMENT ON COLUMN FI_ACCOUNT_CONTROL_ITEM.REFER1_YN IS '�����׸��ʼ�����1';
COMMENT ON COLUMN FI_ACCOUNT_CONTROL_ITEM.REFER2_YN IS '�����׸��ʼ�����2';
COMMENT ON COLUMN FI_ACCOUNT_CONTROL_ITEM.REFER3_YN IS '�����׸��ʼ�����3';
COMMENT ON COLUMN FI_ACCOUNT_CONTROL_ITEM.REFER4_YN IS '�����׸��ʼ�����4';
COMMENT ON COLUMN FI_ACCOUNT_CONTROL_ITEM.REFER5_YN IS '�����׸��ʼ�����5';
COMMENT ON COLUMN FI_ACCOUNT_CONTROL_ITEM.REFER6_YN IS '�����׸��ʼ�����6';
COMMENT ON COLUMN FI_ACCOUNT_CONTROL_ITEM.REFER7_YN IS '�����׸��ʼ�����7';
COMMENT ON COLUMN FI_ACCOUNT_CONTROL_ITEM.REFER8_YN IS '�����׸��ʼ�����8';
COMMENT ON COLUMN FI_ACCOUNT_CONTROL_ITEM.REFER9_YN IS '�����׸��ʼ�����9';
COMMENT ON COLUMN FI_ACCOUNT_CONTROL_ITEM.REFER_RATE_YN IS '�������ʼ�����';
COMMENT ON COLUMN FI_ACCOUNT_CONTROL_ITEM.REFER_AMOUNT_YN IS '�����ݾ��ʼ�����';
COMMENT ON COLUMN FI_ACCOUNT_CONTROL_ITEM.REFER_DATE1_YN IS '���������ʼ�����1';
COMMENT ON COLUMN FI_ACCOUNT_CONTROL_ITEM.REFER_DATE2_YN IS '���������ʼ�����2';
COMMENT ON COLUMN FI_ACCOUNT_CONTROL_ITEM.VOUCH_YN IS '���������ʼ�����';

COMMENT ON COLUMN FI_ACCOUNT_CONTROL_ITEM.CREATION_DATE IS '��������';
COMMENT ON COLUMN FI_ACCOUNT_CONTROL_ITEM.CREATED_BY IS '������';
COMMENT ON COLUMN FI_ACCOUNT_CONTROL_ITEM.LAST_UPDATE_DATE IS '������������';
COMMENT ON COLUMN FI_ACCOUNT_CONTROL_ITEM.LAST_UPDATED_BY IS '����������';


CREATE UNIQUE INDEX FI_ACCOUNT_CONTROL_ITEM_U1 ON 
  FI_ACCOUNT_CONTROL_ITEM(ACCOUNT_CONTROL_ID, SOB_ID)
  TABLESPACE FCM_TS_IDX
  PCTFREE 10
  INITRANS 2
  MAXTRANS 255
  LOGGING
  STORAGE (
           INITIAL 64K
           MINEXTENTS 1
           MAXEXTENTS 2147483645
          );

ALTER TABLE FI_ACCOUNT_CONTROL_ITEM
  ADD CONSTRAINT FI_ACCOUNT_CONTROL_ITEM_PK PRIMARY KEY (ACCOUNT_CONTROL_ID, SOB_ID);
  
CREATE INDEX FI_ACCOUNT_CONTROL_ITEM_N1 ON 
  FI_ACCOUNT_CONTROL_ITEM(ACCOUNT_CODE, SOB_ID)
  TABLESPACE FCM_TS_IDX
  PCTFREE 10
  INITRANS 2
  MAXTRANS 255
  LOGGING
  STORAGE (
           INITIAL 64K
           MINEXTENTS 1
           MAXEXTENTS 2147483645
          );

-- ANALYZE.
ANALYZE TABLE FI_ACCOUNT_CONTROL_ITEM COMPUTE STATISTICS;
ANALYZE INDEX FI_ACCOUNT_CONTROL_ITEM_U1 COMPUTE STATISTICS;
ANALYZE INDEX FI_ACCOUNT_CONTROL_ITEM_N1 COMPUTE STATISTICS;
