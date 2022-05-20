/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRT_INSURANCE_MASTER
/* Description  : ����(���� �ҵ����,�ǰ� ��������)�� ����
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRT_INSURANCE_MASTER
( PERSON_ID                       NUMBER          NOT NULL,
  CORP_ID                         NUMBER          NOT NULL,
  INSUR_TYPE                      VARCHAR2(2)     NOT NULL,
  INSUR_YN                        VARCHAR2(1)     DEFAULT 'N',
  INSUR_GRADE_STEP                VARCHAR2(5)     ,
  INSUR_AMOUNT                    NUMBER          DEFAULT 0,
  CARE_INSUR_REDUCE_YN            VARCHAR2(2)     DEFAULT 'N' NOT NULL,
  GET_DATE                        DATE            ,
  LOSS_DATE                       DATE            ,
  INSUR_NO                        VARCHAR2(50)    ,
  DESCRIPTION                     VARCHAR2(100)   ,
  ATTRIBUTE_A                     VARCHAR2(100)   ,
  ATTRIBUTE_B                     VARCHAR2(100)   ,
  ATTRIBUTE_C                     VARCHAR2(100)   ,
  ATTRIBUTE_D                     VARCHAR2(100)   ,
  ATTRIBUTE_E                     VARCHAR2(100)   ,
  ATTRIBUTE_1                     NUMBER          ,
  ATTRIBUTE_2                     NUMBER          ,
  ATTRIBUTE_3                     NUMBER          ,
  ATTRIBUTE_4                     NUMBER          ,
  ATTRIBUTE_5                     NUMBER          ,
  SOB_ID                          NUMBER          NOT NULL,
  ORG_ID                          NUMBER          NOT NULL,
  CREATION_DATE                   DATE            NOT NULL,
  CREATED_BY                      NUMBER          NOT NULL,
  LAST_UPDATE_DATE                DATE            NOT NULL,
  LAST_UPDATED_BY                 NUMBER          NOT NULL
) TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON COLUMN HRT_INSURANCE_MASTER.PERSON_ID IS '���ID';
COMMENT ON COLUMN HRT_INSURANCE_MASTER.CORP_ID IS '��ü ID';
COMMENT ON COLUMN HRT_INSURANCE_MASTER.INSUR_TYPE IS '���� ����(P-���ο���, M-�ǰ�����)';
COMMENT ON COLUMN HRT_INSURANCE_MASTER.INSUR_YN IS '���� ���뱸��';
COMMENT ON COLUMN HRT_INSURANCE_MASTER.INSUR_GRADE_STEP IS '���� ���';
COMMENT ON COLUMN HRT_INSURANCE_MASTER.INSUR_AMOUNT IS '��������/�ҵ����';
COMMENT ON COLUMN HRT_INSURANCE_MASTER.CARE_INSUR_REDUCE_YN IS '��纸��氨(����ε� ����纸����� 30% �氨)';
COMMENT ON COLUMN HRT_INSURANCE_MASTER.GET_DATE IS '�������';
COMMENT ON COLUMN HRT_INSURANCE_MASTER.LOSS_DATE IS '�������';
COMMENT ON COLUMN HRT_INSURANCE_MASTER.INSUR_NO IS '���� ��ȣ';
COMMENT ON COLUMN HRT_INSURANCE_MASTER.DESCRIPTION IS '���';
COMMENT ON COLUMN HRT_INSURANCE_MASTER.CREATION_DATE  IS '��������';
COMMENT ON COLUMN HRT_INSURANCE_MASTER.CREATED_BY IS '������';
COMMENT ON COLUMN HRT_INSURANCE_MASTER.LAST_UPDATE_DATE IS '������������';
COMMENT ON COLUMN HRT_INSURANCE_MASTER.LAST_UPDATED_BY IS '����������';

-- CREATE INDEX.
CREATE UNIQUE INDEX HRT_INSURANCE_MASTER_U1 ON HRT_INSURANCE_MASTER(PERSON_ID, CORP_ID, INSUR_TYPE, SOB_ID, ORG_ID) TABLESPACE FCM_TS_IDX;

-- ANALYZE.
ANALYZE TABLE HRT_INSURANCE_MASTER COMPUTE STATISTICS;
ANALYZE INDEX HRT_INSURANCE_MASTER_U1 COMPUTE STATISTICS;
