/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_TR_DAILY_SUM
/* Description  : �����ڱ��Ϻ� ����.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_TR_DAILY_SUM
( TR_TYPE                           VARCHAR2(20)  NOT NULL,
  SOB_ID                            NUMBER        NOT NULL,
  GL_DATE                           DATE          ,
  ACCOUNT_CONTROL_ID                NUMBER        ,
  ACCOUNT_CODE                      VARCHAR2(20)  ,  
  CURRENCY_CODE                     VARCHAR2(10)  ,
  EXCHANGE_RATE                     NUMBER        ,
  BEGIN_CURR_AMOUNT                 NUMBER        DEFAULT 0,
  BEGIN_AMOUNT                      NUMBER        DEFAULT 0,
  DR_CURR_AMOUNT                    NUMBER        DEFAULT 0,
  CR_CURR_AMOUNT                    NUMBER        DEFAULT 0,
  DR_AMOUNT                         NUMBER        DEFAULT 0,
  CR_AMOUNT                         NUMBER        DEFAULT 0,
  REMAIN_CURR_AMOUNT                NUMBER        DEFAULT 0,
  REMAIN_AMOUNT                     NUMBER        DEFAULT 0,
  DESCRIPTION                       VARCHAR2(200) ,
  BANK_CODE                         VARCHAR2(20)  ,
  BANK_ACCOUNT_CODE                 VARCHAR2(20)  ,  
  LOAN_USE                          VARCHAR2(10)  ,
  LOAN_NUM                          VARCHAR2(10)  ,
  TR_CATEGORY                       VARCHAR2(10)  ,
  TR_CLASS                          VARCHAR2(10)  ,
  CLOSED_YN                         CHAR(1),
  CLOSED_DATE                       DATE,
  CLOSED_BY                         NUMBER
) TABLESPACE FCM_TS_DATA
;

COMMENT ON TABLE FI_TR_DAILY_SUM IS '�����ڱ��Ϻ� ����';
COMMENT ON TABLE FI_TR_DAILY_SUM IS '�����ڱ��Ϻ� ����';
COMMENT ON COLUMN FI_TR_DAILY_SUM.TR_TYPE IS '�ڱ��Ϻ� Ÿ��';
COMMENT ON COLUMN FI_TR_DAILY_SUM.GL_DATE IS '��ǥ����';
COMMENT ON COLUMN FI_TR_DAILY_SUM.ACCOUNT_CONTROL_ID IS '��������ID';
COMMENT ON COLUMN FI_TR_DAILY_SUM.ACCOUNT_CODE IS '�����ڵ�';
COMMENT ON COLUMN FI_TR_DAILY_SUM.CURRENCY_CODE IS '��ȭ';
COMMENT ON COLUMN FI_TR_DAILY_SUM.EXCHANGE_RATE IS 'ȯ��';
COMMENT ON COLUMN FI_TR_DAILY_SUM.BEGIN_CURR_AMOUNT IS '���ʱݾ�(��ȭ)';
COMMENT ON COLUMN FI_TR_DAILY_SUM.BEGIN_AMOUNT IS '���ʱݾ�';
COMMENT ON COLUMN FI_TR_DAILY_SUM.DR_CURR_AMOUNT IS '�����ݾ�(��ȭ)';
COMMENT ON COLUMN FI_TR_DAILY_SUM.CR_CURR_AMOUNT IS '�뺯�ݾ�(��ȭ)';
COMMENT ON COLUMN FI_TR_DAILY_SUM.DR_AMOUNT IS '�����ݾ�';
COMMENT ON COLUMN FI_TR_DAILY_SUM.CR_AMOUNT IS '�뺯�ݾ�';
COMMENT ON COLUMN FI_TR_DAILY_SUM.REMAIN_CURR_AMOUNT IS '�ܾ�(��ȭ)';
COMMENT ON COLUMN FI_TR_DAILY_SUM.REMAIN_AMOUNT IS '�ܾ�';
COMMENT ON COLUMN FI_TR_DAILY_SUM.DESCRIPTION IS '���';
COMMENT ON COLUMN FI_TR_DAILY_SUM.BANK_CODE IS '�����ڵ�';
COMMENT ON COLUMN FI_TR_DAILY_SUM.BANK_ACCOUNT_CODE IS '��������ڵ�';
COMMENT ON COLUMN FI_TR_DAILY_SUM.LOAN_USE IS '���Ա� �뵵';
COMMENT ON COLUMN FI_TR_DAILY_SUM.LOAN_NUM IS '���Ա� ��ȣ';
COMMENT ON COLUMN FI_TR_DAILY_SUM.TR_CATEGORY IS '�ڱ��Ϻ� ī�װ�';
COMMENT ON COLUMN FI_TR_DAILY_SUM.TR_CLASS IS '�ڱ��Ϻ� �з�';
COMMENT ON COLUMN FI_TR_DAILY_SUM.CLOSED_YN IS '����';
COMMENT ON COLUMN FI_TR_DAILY_SUM.CLOSED_DATE IS '��������';
COMMENT ON COLUMN FI_TR_DAILY_SUM.CLOSED_BY IS '������';
COMMENT ON COLUMN FI_TR_DAILY_SUM.TR_DAILY_SUM_ID IS '��ȹ�Է½� ä�� ID';
COMMENT ON COLUMN FI_TR_DAILY_SUM.FUND_MOVE IS '�ڱ��̵� CODE';

CREATE INDEX FI_TR_DAILY_SUM_N1 ON FI_TR_DAILY_SUM(GL_DATE, SOB_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_TR_DAILY_SUM_N2 ON FI_TR_DAILY_SUM(ACCOUNT_CONTROL_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_TR_DAILY_SUM_N3 ON FI_TR_DAILY_SUM(TR_TYPE, GL_DATE, SOB_ID) TABLESPACE FCM_TS_IDX;

