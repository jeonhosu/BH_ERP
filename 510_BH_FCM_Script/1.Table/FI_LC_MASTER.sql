/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_LC_MASTER
/* Description  : L/C 정보 관리.
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

COMMENT ON TABLE FI_LC_MASTER IS 'L/C 관리 마스터';
COMMENT ON COLUMN APPS.FI_LC_MASTER.LC_NUM IS 'L/C번호';
COMMENT ON COLUMN APPS.FI_LC_MASTER.SOB_ID IS '회계조직';
COMMENT ON COLUMN APPS.FI_LC_MASTER.ORG_ID IS '사업부ID';
COMMENT ON COLUMN APPS.FI_LC_MASTER.BANK_ID IS '은행 ID';
COMMENT ON COLUMN APPS.FI_LC_MASTER.SUPPLIER_ID IS '거래처ID';
COMMENT ON COLUMN APPS.FI_LC_MASTER.OPEN_DATE IS 'L/C OPEN 일자';
COMMENT ON COLUMN APPS.FI_LC_MASTER.DUE_DATE IS 'L/C 만기일자';
COMMENT ON COLUMN APPS.FI_LC_MASTER.CURRENCY_CODE IS '통화';
COMMENT ON COLUMN APPS.FI_LC_MASTER.EXCHANGE_RATE IS '환율';
COMMENT ON COLUMN APPS.FI_LC_MASTER.OPEN_CURR_AMOUNT IS 'OPEN 외화 금액';
COMMENT ON COLUMN APPS.FI_LC_MASTER.OPEN_AMOUNT IS 'OPEN 금액';
COMMENT ON COLUMN APPS.FI_LC_MASTER.OPEN_EXPENSE_AMOUNT IS 'OPEN 비용';
COMMENT ON COLUMN APPS.FI_LC_MASTER.TRANS_STATUS IS '거래상태(TRANS_STATUS)';
COMMENT ON COLUMN APPS.FI_LC_MASTER.DESCRIPTION IS '비고';

CREATE UNIQUE INDEX FI_LC_MASTER_U1 ON FI_LC_MASTER(LC_NUM, SOB_ID, ORG_ID) TABLESPACE FCM_TS_IDX;
