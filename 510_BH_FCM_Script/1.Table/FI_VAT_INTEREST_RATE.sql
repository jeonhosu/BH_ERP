/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_VAT_INTEREST_RATE
/* Description  : �ε��� �Ӵ� ������ ����.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_VAT_INTEREST_RATE
( EFFECTIVE_DATE_FR               DATE          NOT NULL,   -- ��ȿ ��������.
  EFFECTIVE_DATE_TO               DATE          NOT NULL,   -- ��ȿ ��������.
  SOB_ID                          NUMBER        NOT NULL,
  ORG_ID                          NUMBER        NOT NULL,
  INTEREST_RATE                   NUMBER        DEFAULT 0,  -- ������.
  LAST_FLAG                       CHAR(1)       DEFAULT 'Y',-- ��������(Y/N).
  ATTRIBUTE_A                     VARCHAR2(100) ,
  ATTRIBUTE_B                     VARCHAR2(100) ,
  ATTRIBUTE_C                     VARCHAR2(100) ,
  ATTRIBUTE_D                     VARCHAR2(100) ,
  ATTRIBUTE_E                     VARCHAR2(100) ,
  ATTRIBUTE_1                     NUMBER        ,
  ATTRIBUTE_2                     NUMBER        ,
  ATTRIBUTE_3                     NUMBER        ,
  ATTRIBUTE_4                     NUMBER        ,
  ATTRIBUTE_5                     NUMBER        ,
  CREATION_DATE                   DATE          NOT NULL,
  CREATED_BY                      NUMBER        NOT NULL,
  LAST_UPDATE_DATE                DATE          NOT NULL,
  LAST_UPDATED_BY                 NUMBER        NOT NULL
)TABLESPACE FCM_TS_DATA;

COMMENT ON TABLE FI_VAT_INTEREST_RATE IS '�ε����Ӵ� ����������';
COMMENT ON COLUMN FI_VAT_INTEREST_RATE.EFFECTIVE_DATE_FR IS '��ȿ ��������';
COMMENT ON COLUMN FI_VAT_INTEREST_RATE.EFFECTIVE_DATE_TO IS '��ȿ ��������';
COMMENT ON COLUMN FI_VAT_INTEREST_RATE.INTEREST_RATE IS '������';
COMMENT ON COLUMN FI_VAT_INTEREST_RATE.LAST_FLAG IS '��������(Y/N)';

ALTER TABLE FI_VAT_INTEREST_RATE ADD CONSTRAINT FI_VAT_INTEREST_RATE PRIMARY KEY (EFFECTIVE_DATE_FR, EFFECTIVE_DATE_TO, SOB_ID);
