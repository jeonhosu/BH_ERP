/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRD_PERIOD_TOTAL_GT
/* Description  : �Ⱓ���� ����
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE GLOBAL TEMPORARY TABLE HRD_PERIOD_TOTAL_GT              
( PERSON_ID                         NUMBER        NOT NULL, 
  SOB_ID                            NUMBER        NOT NULL,
  ORG_ID                            NUMBER        NOT NULL,
  HOLIDAY_IN_COUNT                  NUMBER        DEFAULT 0,
  LATE_DED_COUNT                    NUMBER        DEFAULT 0,
  WEEKLY_DED_COUNT                  NUMBER        DEFAULT 0,
  CHANGE_DED_COUNT                  NUMBER        DEFAULT 0,
  HOLY_0_COUNT                      NUMBER        DEFAULT 0,
  HOLY_1_COUNT                      NUMBER        DEFAULT 0,
  HOLY_2_COUNT                      NUMBER        DEFAULT 0,
  HOLY_3_COUNT                      NUMBER        DEFAULT 0,
  TOTAL_DAY                         NUMBER        DEFAULT 0,
  TOTAL_ATT_DAY                     NUMBER        DEFAULT 0,
  TOTAL_DED_DAY                     NUMBER        DEFAULT 0,
  PAY_DAY                           NUMBER        DEFAULT 0,
  HOLY_0_DED_FLAG                   VARCHAR2(1)   DEFAULT 'N',
  STD_HOLY_0_COUNT                  NUMBER        DEFAULT 0,
  DESCRIPTION                       VARCHAR2(300) ,
  ATTRIBUTE_A                       VARCHAR2(150) ,
  ATTRIBUTE_B                       VARCHAR2(150) ,
  ATTRIBUTE_C                       VARCHAR2(150) ,
  ATTRIBUTE_D                       VARCHAR2(150) ,
  ATTRIBUTE_E                       VARCHAR2(150) 
) ON COMMIT PRESERVE ROWS;

-- Add comments to the columns 
COMMENT ON TABLE HRD_PERIOD_TOTAL_GT IS '�Ⱓ�� ���� ����';
COMMENT ON COLUMN HRD_PERIOD_TOTAL_GT.PERSON_ID IS '���ID';
COMMENT ON COLUMN HRD_PERIOD_TOTAL_GT.HOLIDAY_IN_COUNT IS '���ϱٹ�Ƚ��';
COMMENT ON COLUMN HRD_PERIOD_TOTAL_GT.LATE_DED_COUNT IS '��������Ƚ��';
COMMENT ON COLUMN HRD_PERIOD_TOTAL_GT.WEEKLY_DED_COUNT IS '���ް����ϼ�';
COMMENT ON COLUMN HRD_PERIOD_TOTAL_GT.CHANGE_DED_COUNT IS '�������ް����ϼ�-������ ���濡 ���� ���ް���';
COMMENT ON COLUMN HRD_PERIOD_TOTAL_GT.HOLY_0_COUNT IS '����Ƚ��';
COMMENT ON COLUMN HRD_PERIOD_TOTAL_GT.HOLY_1_COUNT IS '����Ƚ��';
COMMENT ON COLUMN HRD_PERIOD_TOTAL_GT.HOLY_2_COUNT IS '�ְ�Ƚ��';
COMMENT ON COLUMN HRD_PERIOD_TOTAL_GT.HOLY_3_COUNT IS '�߰�Ƚ��';
COMMENT ON COLUMN HRD_PERIOD_TOTAL_GT.TOTAL_DAY IS '�� ���ϼ�';
COMMENT ON COLUMN HRD_PERIOD_TOTAL_GT.TOTAL_ATT_DAY IS '����ϼ�';
COMMENT ON COLUMN HRD_PERIOD_TOTAL_GT.TOTAL_DED_DAY IS '�Ѱ����ϼ�';
COMMENT ON COLUMN HRD_PERIOD_TOTAL_GT.PAY_DAY IS '�޿��ϼ�';
COMMENT ON COLUMN HRD_PERIOD_TOTAL_GT.HOLY_0_DED_FLAG IS '�������� ���� ����';
COMMENT ON COLUMN HRD_PERIOD_TOTAL_GT.STD_HOLY_0_COUNT IS '���� �������ϼ�';
COMMENT ON COLUMN HRD_PERIOD_TOTAL_GT.DESCRIPTION IS '���';


