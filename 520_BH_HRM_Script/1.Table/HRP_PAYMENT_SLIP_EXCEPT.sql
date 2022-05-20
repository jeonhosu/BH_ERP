/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRP_PAYMENT_SLIP_EXCEPT
/* Description  : ���޻� ���޳��� ����
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRP_PAYMENT_SLIP_EXCEPT
( PAY_YYYYMM                      VARCHAR2(7)     NOT NULL,
  WAGE_TYPE                       VARCHAR2(5)     NOT NULL,
  EXCEPT_TYPE                     VARCHAR2(50)    NOT NULL,
  PERSON_NUM                      VARCHAR2(30)    NOT NULL,
  NAME                            VARCHAR2(100)   ,
  IN_TAX_AMT                      NUMBER          ,
  LOCAL_TAX_AMT                   NUMBER          ,
  SP_TAX_AMT                      NUMBER          ,
  SUM_TAX_AMT                     NUMBER
) TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON TABLE HRP_PAYMENT_SLIP_EXCEPT IS '�޻� ��ǥ ���� ó���� ����';
COMMENT ON COLUMN HRP_PAYMENT_SLIP_EXCEPT.PAY_YYYYMM IS '�޻� ���';
COMMENT ON COLUMN HRP_PAYMENT_SLIP_EXCEPT.WAGE_TYPE IS '�޻� ����';
COMMENT ON COLUMN HRP_PAYMENT_SLIP_EXCEPT.EXCEPT_TYPE IS '����ó�� ����';
COMMENT ON COLUMN HRP_PAYMENT_SLIP_EXCEPT.PERSON_NUM IS '��� ��ȣ';
COMMENT ON COLUMN HRP_PAYMENT_SLIP_EXCEPT.NAME IS '����';
COMMENT ON COLUMN HRP_PAYMENT_SLIP_EXCEPT.IN_TAX_AMT IS '�ҵ漼';
COMMENT ON COLUMN HRP_PAYMENT_SLIP_EXCEPT.LOCAL_TAX_AMT IS '�ֹμ�';
COMMENT ON COLUMN HRP_PAYMENT_SLIP_EXCEPT.SP_TAX_AMT IS '��Ư��';
COMMENT ON COLUMN HRP_PAYMENT_SLIP_EXCEPT.SUM_TAX_AMT  IS '�հ�';
