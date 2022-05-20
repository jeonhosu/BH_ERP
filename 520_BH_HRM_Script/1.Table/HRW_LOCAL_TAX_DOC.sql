/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRW_LOCAL_TAX_DOC
/* Description  : �ֹμ�Ư��¡����/���Լ�.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRW_LOCAL_TAX_DOC
( LOCAL_TAX_ID                    NUMBER          NOT NULL,
  LOCAL_TAX_NO                    VARCHAR2(20)    NOT NULL,
  CORP_ID                         NUMBER          NOT NULL,
  SOB_ID                          NUMBER          NOT NULL,
  ORG_ID                          NUMBER          NOT NULL,
  LOCAL_TAX_TYPE                  VARCHAR2(10)    NOT NULL,
  STD_YYYYMM                      VARCHAR2(8)     NOT NULL,
  PAY_YYYYMM                      VARCHAR2(8)     NOT NULL,
  SUBMIT_DATE                     DATE            ,
  PRE_LOCAL_TAX_NO                VARCHAR2(20)    ,
  PAY_SUPPLY_DATE                 DATE            ,
  TAX_OFFICER                     VARCHAR2(100)   ,
  CLOSED_YN                       VARCHAR2(2)     DEFAULT 'N',
  CLOSED_DATE                     DATE            ,
  CLOSED_PERSON_ID                NUMBER          ,
  A01_PERSON_CNT                  NUMBER          ,
  A01_STD_TAX_AMT                 NUMBER          ,
  A01_LOCAL_TAX_AMT               NUMBER          ,
  A02_PERSON_CNT                  NUMBER          ,
  A02_STD_TAX_AMT                 NUMBER          ,
  A02_LOCAL_TAX_AMT               NUMBER          ,
  A03_PERSON_CNT                  NUMBER          ,
  A03_STD_TAX_AMT                 NUMBER          ,
  A03_LOCAL_TAX_AMT               NUMBER          ,
  A04_PERSON_CNT                  NUMBER          ,
  A04_STD_TAX_AMT                 NUMBER          ,
  A04_LOCAL_TAX_AMT               NUMBER          ,
  A05_PERSON_CNT                  NUMBER          ,
  A05_STD_TAX_AMT                 NUMBER          ,
  A05_LOCAL_TAX_AMT               NUMBER          ,
  A06_PERSON_CNT                  NUMBER          ,
  A06_STD_TAX_AMT                 NUMBER          ,
  A06_LOCAL_TAX_AMT               NUMBER          ,
  A07_PERSON_CNT                  NUMBER          ,
  A07_STD_TAX_AMT                 NUMBER          ,
  A07_LOCAL_TAX_AMT               NUMBER          ,
  A08_PERSON_CNT                  NUMBER          ,
  A08_STD_TAX_AMT                 NUMBER          ,
  A08_LOCAL_TAX_AMT               NUMBER          ,
  A09_PERSON_CNT                  NUMBER          ,
  A09_STD_TAX_AMT                 NUMBER          ,
  A09_LOCAL_TAX_AMT               NUMBER          ,
  A10_PERSON_CNT                  NUMBER          ,
  A10_STD_TAX_AMT                 NUMBER          ,
  A10_LOCAL_TAX_AMT               NUMBER          ,
  A90_PERSON_CNT                  NUMBER          ,
  A90_STD_TAX_AMT                 NUMBER          ,
  A90_LOCAL_TAX_AMT               NUMBER          ,
  TOTAL_ADJUST_TAX_AMT            NUMBER          ,
  PAY_LOCAL_TAX_AMT               NUMBER          ,
  K10_TAX_AMT                     NUMBER          ,
  K20_TAX_AMT                     NUMBER          ,
  K30_TAX_AMT                     NUMBER          ,
  K40_TAX_AMT                     NUMBER          ,
  R10_TAX_AMT                     NUMBER          ,
  R20_TAX_AMT                     NUMBER          ,
  R30_TAX_AMT                     NUMBER          ,
  R40_TAX_AMT                     NUMBER          ,
  DESCRIPTION                     VARCHAR2(100)   ,
  ATTRIBUTE_1                     NUMBER          ,
  ATTRIBUTE_2                     NUMBER          ,
  ATTRIBUTE_3                     NUMBER          ,
  ATTRIBUTE_4                     NUMBER          ,
  ATTRIBUTE_5                     NUMBER          ,
  ATTRIBUTE_A                     NUMBER          ,
  ATTRIBUTE_B                     VARCHAR2(100)   ,
  ATTRIBUTE_C                     VARCHAR2(100)   ,
  ATTRIBUTE_D                     VARCHAR2(100)   ,
  ATTRIBUTE_E                     VARCHAR2(100)   ,
  CREATION_DATE                   DATE            NOT NULL,
  CREATED_BY                      NUMBER          NOT NULL,
  LAST_UPDATE_DATE                DATE            NOT NULL,
  LAST_UPDATED_BY                 NUMBER          NOT NULL
) TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON TABLE HRW_LOCAL_TAX_DOC IS '�ֹμ�����';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.LOCAL_TAX_ID IS '�Ű� ID';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.LOCAL_TAX_NO IS '������ȣ';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.CORP_ID IS '��üID';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.LOCAL_TAX_TYPE IS '�Ű���';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.STD_YYYYMM IS '�ͼӳ��';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.PAY_YYYYMM IS '���޳��';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.SUBMIT_DATE IS '��������';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.PRE_LOCAL_TAX_NO IS '��������';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.PAY_SUPPLY_DATE IS '�޿���������';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.TAX_OFFICER IS '����ó';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.CLOSED_YN IS '��������';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.CLOSED_DATE IS '��������';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.CLOSED_PERSON_ID IS '����ó����';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.A01_PERSON_CNT IS '���ڼҵ� �ο���';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.A01_STD_TAX_AMT IS '���ڼҵ� ����ǥ��';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.A01_LOCAL_TAX_AMT IS '���ڼҵ� ����ҵ漼';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.A02_PERSON_CNT IS '���ҵ� �ο���';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.A02_STD_TAX_AMT IS '���ҵ� ����ǥ��';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.A02_LOCAL_TAX_AMT IS '���ҵ� ����ҵ漼';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.A03_PERSON_CNT IS '����ҵ� �ο���';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.A03_STD_TAX_AMT IS '����ҵ� ����ǥ��';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.A03_LOCAL_TAX_AMT IS '����ҵ� ����ҵ漼';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.A04_PERSON_CNT IS '�ٷμҵ� �ο���';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.A04_STD_TAX_AMT IS '�ٷμҵ� ����ǥ��';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.A04_LOCAL_TAX_AMT IS '�ٷμҵ� ����ҵ漼';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.A05_PERSON_CNT IS '���ݼҵ� �ο���';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.A05_STD_TAX_AMT IS '���ݼҵ� ����ǥ��';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.A05_LOCAL_TAX_AMT IS '���ݼҵ� ����ҵ漼';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.A06_PERSON_CNT IS '��Ÿ�ҵ� �ο���';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.A06_STD_TAX_AMT IS '��Ÿ�ҵ� ����ǥ��';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.A06_LOCAL_TAX_AMT IS '��Ÿ�ҵ� ����ҵ漼';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.A07_PERSON_CNT IS '�����ҵ� �ο���';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.A07_STD_TAX_AMT IS '�����ҵ� ����ǥ��';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.A07_LOCAL_TAX_AMT IS '�����ҵ� ����ҵ漼';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.A08_PERSON_CNT IS '�ܱ������κ��͹����ҵ� �ο���';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.A08_STD_TAX_AMT IS '�ܱ������κ��͹����ҵ� ����ǥ��';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.A08_LOCAL_TAX_AMT IS '�ܱ������κ��͹����ҵ� ����ҵ漼';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.A09_PERSON_CNT IS '���μ��� ��98�� ���� �ο���';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.A09_STD_TAX_AMT IS '���μ��� ��98�� ���� ����ǥ��';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.A09_LOCAL_TAX_AMT IS '���μ��� ��98�� ���� ����ҵ�';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.A10_PERSON_CNT IS '�ҵ漼�� ��119�� �絵�ҵ� �ο���';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.A10_STD_TAX_AMT IS '�ҵ漼�� ��119�� �絵�ҵ� ����ǥ��';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.A10_LOCAL_TAX_AMT IS '�ҵ漼�� ��119�� �絵�ҵ� ����ҵ漼';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.A90_PERSON_CNT IS '�հ� �ο���';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.A90_STD_TAX_AMT IS '�հ� ����ǥ��';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.A90_LOCAL_TAX_AMT IS '�հ� ����ҵ漼';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.TOTAL_ADJUST_TAX_AMT IS '��������(������)';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.PAY_LOCAL_TAX_AMT IS '���μ���';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.K10_TAX_AMT IS '��ӱٹ���-������ȯ�޼���';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.K20_TAX_AMT IS '��ӱٹ���-����߻�ȯ�޾�';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.K30_TAX_AMT IS '��ӱٹ���-�������ȯ�޼���';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.K40_TAX_AMT IS '��ӱٹ���-�����̿�ȯ�޾�';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.R10_TAX_AMT IS '�ߵ���翬������ȯ�޾�-������ȯ�޾�';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.R20_TAX_AMT IS '�ߵ���翬������ȯ�޾�-����߻�ȯ�޾�';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.R30_TAX_AMT IS '�ߵ���翬������ȯ�޾�-�������ȯ�޾�';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.R40_TAX_AMT IS '�ߵ���翬������ȯ�޾�-�����̿�ȯ�޾�';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.DESCRIPTION IS '���';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.CREATION_DATE  IS '��������';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.CREATED_BY IS '������';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.LAST_UPDATE_DATE IS '������������';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.LAST_UPDATED_BY IS '����������';

-- PK.
ALTER TABLE HRW_LOCAL_TAX_DOC ADD CONSTRAINTS HRW_LOCAL_TAX_DOC_PK PRIMARY KEY(LOCAL_TAX_ID);

CREATE UNIQUE INDEX HRW_LOCAL_TAX_DOC_U1 ON HRW_LOCAL_TAX_DOC(LOCAL_TAX_NO, CORP_ID, SOB_ID, ORG_ID) TABLESPACE FCM_TS_IDX;

-- SEQUENCE
CREATE SEQUENCE HRW_LOCAL_TAX_DOC_S1;
-- ANALYZE.
ANALYZE TABLE HRW_LOCAL_TAX_DOC COMPUTE STATISTICS;
ANALYZE INDEX HRW_LOCAL_TAX_DOC_U1 COMPUTE STATISTICS;
