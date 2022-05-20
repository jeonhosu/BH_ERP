-/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_MANAGEMENT_LEDGER_DETAIL
/* Description  : �����׸񺰿���-��ü��ȸ.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_MANAGEMENT_LEDGER_DETAIL
( RET_SEQ                         NUMBER          NOT NULL,
  GL_DATE                         DATE            ,
  REMARKS                         VARCHAR2(200)   ,
  DR_AMT                          NUMBER          ,
  CR_AMT                          NUMBER          ,
  REMAIN_AMT                      NUMBER          ,
  ACCOUNT_CODE                    VARCHAR2(20)    ,
  ACCOUNT_DESC                    VARCHAR2(200)   ,
  MANAGEMENT_CD                   VARCHAR2(50)    ,
  MANAGEMENT_NM                   VARCHAR2(200)   ,
  SLIP_HEADER_ID                  NUMBER          ,
  SLIP_LINE_ID                    NUMBER          ,
  GL_NUM                          VARCHAR2(30)
)
TABLESPACE FCM_TS_DATA;
  
-- ADD COMMENTS TO THE TABLE 
COMMENT ON TABLE FI_MANAGEMENT_LEDGER_DETAIL IS '������ȸ_��(��ü)';
-- ADD COMMENTS TO THE COLUMNS 
COMMENT ON COLUMN FI_MANAGEMENT_LEDGER_DETAIL.RET_SEQ IS '��ȸ�Ϸù�ȣ';
COMMENT ON COLUMN FI_MANAGEMENT_LEDGER_DETAIL.GL_DATE IS 'ȸ������';
COMMENT ON COLUMN FI_MANAGEMENT_LEDGER_DETAIL.REMARKS IS '����';
COMMENT ON COLUMN FI_MANAGEMENT_LEDGER_DETAIL.DR_AMT IS '����(�ݾ�)';
COMMENT ON COLUMN FI_MANAGEMENT_LEDGER_DETAIL.CR_AMT IS '�뺯(�ݾ�)';
COMMENT ON COLUMN FI_MANAGEMENT_LEDGER_DETAIL.REMAIN_AMT IS '�ܾ�';
COMMENT ON COLUMN FI_MANAGEMENT_LEDGER_DETAIL.ACCOUNT_CODE IS '�����ڵ�';
COMMENT ON COLUMN FI_MANAGEMENT_LEDGER_DETAIL.ACCOUNT_DESC IS '������';
COMMENT ON COLUMN FI_MANAGEMENT_LEDGER_DETAIL.MANAGEMENT_CD IS '�����׸��ڵ�';
COMMENT ON COLUMN FI_MANAGEMENT_LEDGER_DETAIL.MANAGEMENT_NM IS '�����׸��';
COMMENT ON COLUMN FI_MANAGEMENT_LEDGER_DETAIL.SLIP_HEADER_ID IS '��ǥ������̵�';
COMMENT ON COLUMN FI_MANAGEMENT_LEDGER_DETAIL.SLIP_LINE_ID IS '��ǥ���ξ��̵�';
COMMENT ON COLUMN FI_MANAGEMENT_LEDGER_DETAIL.GL_NUM IS '��ǥ��ȣ';

-- CREATE/RECREATE PRIMARY, UNIQUE AND FOREIGN KEY CONSTRAINTS 
ALTER TABLE FI_MANAGEMENT_LEDGER_DETAIL
  ADD CONSTRAINT FI_MANAGEMENT_LEDGER_DETAIL_PK PRIMARY KEY (RET_SEQ)
  USING INDEX 
  TABLESPACE FCM_TS_IDX;
