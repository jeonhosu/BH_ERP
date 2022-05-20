-- ���̺��: APPS.FI_UNLIQUIDATE_SUMMARY
-- ���̺���: 

/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_UNLIQUIDATE_SUMMARY
/* Description  : ��û����� �̿����賻��
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_UNLIQUIDATE_SUMMARY
( PERIOD_NAME              VARCHAR2(10)     NOT NULL,  -- ȸ����.
  SLIP_LINE_ID             NUMBER           NOT NULL,  -- ��ǥ ���� ID.
  SOB_ID                   NUMBER           NOT NULL,
  ORG_ID                   NUMBER           NOT NULL,
  GL_DATE                  DATE             NOT NULL,  -- ȸ������. 
  ACCOUNT_BOOK_ID          NUMBER           NOT NULL,  -- ȸ�����.
  ACCOUNT_CONTROL_ID       NUMBER           NOT NULL,  -- ��������ID.
  ACCOUNT_CODE             VARCHAR2(20)     NOT NULL,  -- �����ڵ�.
  CURRENCY_CODE            VARCHAR2(10)     NOT NULL,  -- ��ȭ.
  CUSTOMER_ID              NUMBER           ,              -- �ŷ�ó�ڵ�.
  MANAGEMENT1              VARCHAR2(50)     ,              -- �����׸�1.
  MANAGEMENT2              VARCHAR2(50)     ,              -- �����׸�2.
  REMAIN_AMOUNT            NUMBER           DEFAULT 0,  -- �ܾ�(��ȭ).
  REMAIN_CURR_AMOUNT       NUMBER           DEFAULT 0,  -- �ܾ�(��ȭ).
  CREATION_DATE            DATE             NOT NULL, /* ������ */
  CREATED_BY               NUMBER           NOT NULL, /* ������ */
  LAST_UPDATE_DATE         DATE             NOT NULL, /* ������ */
  LAST_UPDATED_BY          NUMBER           NOT NULL  /* ������ */
) TABLESPACE FCM_TS_DATA;
);
COMMENT ON TABLE FI_UNLIQUIDATE_SUMMARY IS '��û����� �̿����賻��';
COMMENT ON COLUMN APPS.FI_UNLIQUIDATE_SUMMARY.PERIOD_NAME IS 'ȸ����';
COMMENT ON COLUMN APPS.FI_UNLIQUIDATE_SUMMARY.SLIP_LINE_ID IS '��ǥ ���� ID.';
COMMENT ON COLUMN APPS.FI_UNLIQUIDATE_SUMMARY.GL_DATE IS 'ȸ������';
COMMENT ON COLUMN APPS.FI_UNLIQUIDATE_SUMMARY.ACCOUNT_BOOK_ID IS 'ȸ�����';
COMMENT ON COLUMN APPS.FI_UNLIQUIDATE_SUMMARY.ACCOUNT_CONTROL_ID IS '��������ID';
COMMENT ON COLUMN APPS.FI_UNLIQUIDATE_SUMMARY.ACCOUNT_CODE IS '�����ڵ�';
COMMENT ON COLUMN APPS.FI_UNLIQUIDATE_SUMMARY.CURRENCY_CODE IS '��ȭ';
COMMENT ON COLUMN APPS.FI_UNLIQUIDATE_SUMMARY.CUSTOMER_ID IS '�ŷ�ó�ڵ�';
COMMENT ON COLUMN APPS.FI_UNLIQUIDATE_SUMMARY.MANAGEMENT1 IS '�����׸�1';
COMMENT ON COLUMN APPS.FI_UNLIQUIDATE_SUMMARY.MANAGEMENT2 IS '�����׸�2';
COMMENT ON COLUMN APPS.FI_UNLIQUIDATE_SUMMARY.REMAIN_AMOUNT IS '�ܾ׿�ȭ';
COMMENT ON COLUMN APPS.FI_UNLIQUIDATE_SUMMARY.REMAIN_CURR_AMOUNT IS '�ܾ׿�ȭ';

CREATE UNIQUE INDEX FI_UNLIQUIDATE_SUMMARY_PK ON 
  FI_UNLIQUIDATE_SUMMARY(ACCOUNT_BOOK_ID, PERIOD_NAME, SLIP_LINE_ID, GL_DATE, SOB_ID)
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

ALTER TABLE FI_UNLIQUIDATE_SUMMARY ADD ( 
  CONSTRAINT FI_UNLIQUIDATE_SUMMARY_PK PRIMARY KEY ( ACCOUNT_BOOK_ID, PERIOD_NAME, SLIP_LINE_ID, GL_DATE, SOB_ID)
        );
