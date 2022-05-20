/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRD_PERIOD_TOTAL_DUTY_GT
/* Description  : ������ ���� ���� ����.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE GLOBAL TEMPORARY TABLE HRD_PERIOD_TOTAL_DUTY_GT              
( PERSON_ID                         NUMBER        NOT NULL,
  SOB_ID                            NUMBER        NOT NULL,
  ORG_ID                            NUMBER        NOT NULL,
  DUTY_ID                           NUMBER        NOT NULL,
  DUTY_COUNT                        NUMBER        DEFAULT 0,  
  NON_PAY_YN                        VARCHAR2(1)   DEFAULT 'N',
  DESCRIPTION                       VARCHAR2(100) ,
  ATTRIBUTE1                        VARCHAR2(100) ,
  ATTRIBUTE2                        VARCHAR2(100) ,
  ATTRIBUTE3                        VARCHAR2(100) ,
  ATTRIBUTE4                        VARCHAR2(100) ,
  ATTRIBUTE5                        VARCHAR2(100)
) ON COMMIT PRESERVE ROWS;

-- Add comments to the columns 
COMMENT ON TABLE HRD_PERIOD_TOTAL_DUTY_GT IS '�Ⱓ ���� ���� - ���°�';
COMMENT ON COLUMN HRD_PERIOD_TOTAL_DUTY_GT.PERSON_ID IS '���ID';
COMMENT ON COLUMN HRD_PERIOD_TOTAL_DUTY_GT.DUTY_ID IS '����ID';
COMMENT ON COLUMN HRD_PERIOD_TOTAL_DUTY_GT.DUTY_COUNT IS '���� �����';
COMMENT ON COLUMN HRD_PERIOD_TOTAL_DUTY_GT.NON_PAY_YN IS '�ٿ����� Y/N';
COMMENT ON COLUMN HRD_PERIOD_TOTAL_DUTY_GT.DESCRIPTION IS '���';




