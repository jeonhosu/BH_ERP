/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRD_WEEKLY_DED_GT
/* Description  : �ϱ��� ���� - ���ް��� ����.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRD_WEEKLY_DED_GT
( PERSON_ID                       NUMBER          NOT NULL,
  SOB_ID                          NUMBER          NOT NULL,
  ORG_ID                          NUMBER          NOT NULL,
  WORK_DATE                       DATE            NOT NULL,
  DED_DATE                        DATE            NOT NULL,
  DESCRIPTION                     VARCHAR2(100)   ,
  ATTRIBUTE_A                     VARCHAR2(250)   ,    
  ATTRIBUTE_B                     VARCHAR2(250)   ,    
  ATTRIBUTE_C                     VARCHAR2(250)   ,    
  ATTRIBUTE_D                     VARCHAR2(250)   ,    
  ATTRIBUTE_E                     VARCHAR2(250)   ,    
  ATTRIBUTE_1                     NUMBER          ,    
  ATTRIBUTE_2                     NUMBER          ,    
  ATTRIBUTE_3                     NUMBER          ,    
  ATTRIBUTE_4                     NUMBER          ,
  ATTRIBUTE_5                     NUMBER          
) TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON TABLE HRD_WEEKLY_DED_GT IS '�ϱ���-���ް�������';
COMMENT ON COLUMN HRD_WEEKLY_DED_GT.PERSON_ID IS '���ID';
COMMENT ON COLUMN HRD_WEEKLY_DED_GT.WORK_DATE IS '�ٹ�����';
COMMENT ON COLUMN HRD_WEEKLY_DED_GT.DED_DATE IS '��������';
COMMENT ON COLUMN HRD_WEEKLY_DED_GT.DESCRIPTION IS '���';
