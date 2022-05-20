/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_LC_MASTER
/* Description  : L/C ���� ����.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_LC_MASTER 
( LC_NUM                          VARCHAR2(50)    NOT NULL
, SOB_ID                          NUMBER          NOT NULL
, ORG_ID                          NUMBER          NOT NULL
, BANK_ID                         NUMBER          
, SUPPLIER_ID                     NUMBER
, OPEN_DATE                       DATE
, DUE_DATE                        DATE
, CURRENCY_CODE                   VARCHAR2(10)
, EXCHANGE_RATE                   NUMBER
, OPEN_CURR_AMOUNT                NUMBER          DEFAULT 0
, OPEN_AMOUNT                     NUMBER          DEFAULT 0
, OPEN_EXPENSE_AMOUNT             NUMBER          DEFAULT 0
, TRANS_STATUS                    VARCHAR2(10)
, DESCRIPTION                     VARCHAR2(200)
, CREATION_DATE                   DATE            NOT NULL
, CREATED_BY                      NUMBER          NOT NULL
, LAST_UPDATE_DATE                DATE            NOT NULL
, LAST_UPDATED_BY                 NUMBER          NOT NULL
)TABLESPACE FCM_TS_DATA;

COMMENT ON TABLE FI_LC_MASTER IS 'L/C ���� ������';
COMMENT ON COLUMN APPS.FI_LC_MASTER.LC_NUM IS 'L/C��ȣ';
COMMENT ON COLUMN APPS.FI_LC_MASTER.SOB_ID IS 'ȸ������';
COMMENT ON COLUMN APPS.FI_LC_MASTER.ORG_ID IS '�����ID';
COMMENT ON COLUMN APPS.FI_LC_MASTER.BANK_ID IS '���� ID';
COMMENT ON COLUMN APPS.FI_LC_MASTER.SUPPLIER_ID IS '�ŷ�óID';
COMMENT ON COLUMN APPS.FI_LC_MASTER.OPEN_DATE IS 'L/C OPEN ����';
COMMENT ON COLUMN APPS.FI_LC_MASTER.DUE_DATE IS 'L/C ��������';
COMMENT ON COLUMN APPS.FI_LC_MASTER.CURRENCY_CODE IS '��ȭ';
COMMENT ON COLUMN APPS.FI_LC_MASTER.EXCHANGE_RATE IS 'ȯ��';
COMMENT ON COLUMN APPS.FI_LC_MASTER.OPEN_CURR_AMOUNT IS 'OPEN ��ȭ �ݾ�';
COMMENT ON COLUMN APPS.FI_LC_MASTER.OPEN_AMOUNT IS 'OPEN �ݾ�';
COMMENT ON COLUMN APPS.FI_LC_MASTER.OPEN_EXPENSE_AMOUNT IS 'OPEN ���';
COMMENT ON COLUMN APPS.FI_LC_MASTER.TRANS_STATUS IS '�ŷ�����(TRANS_STATUS)';
COMMENT ON COLUMN APPS.FI_LC_MASTER.DESCRIPTION IS '���';

CREATE UNIQUE INDEX FI_LC_MASTER_U1 ON FI_LC_MASTER(LC_NUM, SOB_ID, ORG_ID) TABLESPACE FCM_TS_IDX;
