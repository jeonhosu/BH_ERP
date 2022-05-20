/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRD_OT_MANAGER
/* Description  : �ܾ�/Ư�� ���� - ������ 
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2013  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRD_OT_MANAGER              
( WORK_DATE                       DATE            NOT NULL,
  PERSON_ID                       NUMBER          NOT NULL,
  SOB_ID                          NUMBER          NOT NULL,
  ORG_ID                          NUMBER          NOT NULL,
  OT_TYPE_ID                      NUMBER          NOT NULL,
  OT_DATE_FR                      DATE            NOT NULL,
  OT_DATE_TO                      DATE            NOT NULL,
  DESCRIPTION                     VARCHAR2(3000)  ,  
  STATUS_FLAG                     VARCHAR2(2)     DEFAULT 'N' NOT NULL,
  APPROVAL_YN                     VARCHAR2(2)     DEFAULT 'N' NOT NULL,
  APPROVAL_DATE                   DATE            ,
  APPROVAL_PERSON_ID              NUMBER          ,
  CONFIRMED_YN                    VARCHAR2(2)     DEFAULT 'N' NOT NULL,
  CONFIRMED_DATE                  DATE            ,
  CONFIRMED_PERSON_ID             NUMBER          ,
  TRANSFER_YN                     VARCHAR2(2)     DEFAULT 'N' NOT NULL,
  TRANSFER_DATE                   DATE            ,
  TRANSFER_PERSON_ID              NUMBER          ,
  REJECT_DESC	                    VARCHAR2(3000)  ,
  REJECT_YN		                    VARCHAR2(2)     DEFAULT 'N',
  REJECT_DATE	                    DATE	          ,
  REJECT_PERSON_ID	              NUMBER	        ,
  PAY_YYYYMM		                  VARCHAR2(7)	    , 
  WAGE_TYPE		                    VARCHAR2(4)     ,
  ADD_ALLOWANCE_ID		            NUMBER	        ,
  OT_AMOUNT		                    NUMBER	        ,
  AMT_CREATE_DATE		              DATE	          ,
  AMT_CREATE_PERSON_ID		        NUMBER	        ,
  DUTY_ID                         NUMBER          ,
  HOLY_TYPE                       VARCHAR2(4)     ,
  OPEN_TIME		                    DATE	          ,
  CLOSE_TIME		                  DATE	          ,
  REAL_OT_TIME		                NUMBER	        ,
  LEAVE_TIME                      NUMBER          ,
  ATTRIBUTE_A                     VARCHAR2(150)   ,
  ATTRIBUTE_B                     VARCHAR2(150)   ,
  ATTRIBUTE_C                     VARCHAR2(150)   ,
  ATTRIBUTE_D                     VARCHAR2(150)   ,
  ATTRIBUTE_E                     VARCHAR2(150)   ,
  ATTRIBUTE_1                     NUMBER          ,
  ATTRIBUTE_2                     NUMBER          ,
  ATTRIBUTE_3                     NUMBER          ,       
  ATTRIBUTE_4                     NUMBER          ,
  ATTRIBUTE_5                     NUMBER          ,
  CREATION_DATE                   DATE            NOT NULL,
  CREATED_BY                      NUMBER          NOT NULL,
  LAST_UPDATE_DATE                DATE            NOT NULL,
  LAST_UPDATED_BY                 NUMBER          NOT NULL
) TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON TABLE HRD_OT_MANAGER IS '������ �ܾ�/Ư�� ����';
COMMENT ON COLUMN HRD_OT_MANAGER.WORK_DATE IS '�ٹ�����';
COMMENT ON COLUMN HRD_OT_MANAGER.PERSON_ID IS '���ID';
COMMENT ON COLUMN HRD_OT_MANAGER.OT_TYPE_ID IS '�ܾ�/Ư�� ���� ID';
COMMENT ON COLUMN HRD_OT_MANAGER.OT_DATE_FR IS '�ܾ�/Ư�� �����Ͻ�';
COMMENT ON COLUMN HRD_OT_MANAGER.OT_DATE_TO IS '�ܾ�/Ư�� �����Ͻ�';
COMMENT ON COLUMN HRD_OT_MANAGER.DESCRIPTION IS '����';
COMMENT ON COLUMN HRD_OT_MANAGER.STATUS_FLAG IS '����(N-�̽���, C-Ȯ��, I-�޿�����)';
COMMENT ON COLUMN HRD_OT_MANAGER.APPROVAL_YN IS '���� ���ο���';
COMMENT ON COLUMN HRD_OT_MANAGER.APPROVAL_DATE IS '���� �����Ͻ�';
COMMENT ON COLUMN HRD_OT_MANAGER.APPROVAL_PERSON_ID IS '���� ����ó����';
COMMENT ON COLUMN HRD_OT_MANAGER.CONFIRMED_YN IS '���ο���';
COMMENT ON COLUMN HRD_OT_MANAGER.CONFIRMED_DATE IS '�����Ͻ�';
COMMENT ON COLUMN HRD_OT_MANAGER.CONFIRMED_PERSON_ID IS '����ó����';
COMMENT ON COLUMN HRD_OT_MANAGER.TRANSFER_YN IS '�޿����ۿ���';
COMMENT ON COLUMN HRD_OT_MANAGER.TRANSFER_DATE IS '�޿������Ͻ�';
COMMENT ON COLUMN HRD_OT_MANAGER.TRANSFER_PERSON_ID IS '�޿�����ó����';
COMMENT ON COLUMN HRD_OT_MANAGER.REJECT_DESC IS '�ݷ�����';
COMMENT ON COLUMN HRD_OT_MANAGER.REJECT_YN IS '�ݷ� ���ο���';
COMMENT ON COLUMN HRD_OT_MANAGER.REJECT_DATE IS '�ݷ� �����Ͻ�';
COMMENT ON COLUMN HRD_OT_MANAGER.REJECT_PERSON_ID IS '�ݷ� ����ó����';
COMMENT ON COLUMN HRD_OT_MANAGER.PAY_YYYYMM IS '�޻󿩳��';
COMMENT ON COLUMN HRD_OT_MANAGER.WAGE_TYPE IS '���ޱ���';
COMMENT ON COLUMN HRD_OT_MANAGER.ADD_ALLOWANCE_ID IS '�߰�����ID';
COMMENT ON COLUMN HRD_OT_MANAGER.OT_AMOUNT IS '�ܾ� �ݾ�';
COMMENT ON COLUMN HRD_OT_MANAGER.AMT_CREATE_DATE IS '�ܾ��ݾ� �����Ͻ�';
COMMENT ON COLUMN HRD_OT_MANAGER.AMT_CREATE_PERSON_ID IS '�ܾ��ݾ� ������';
COMMENT ON COLUMN HRD_OT_MANAGER.DUTY_ID IS '����ID';
COMMENT ON COLUMN HRD_OT_MANAGER.HOLY_TYPE IS '�ٹ�����';
COMMENT ON COLUMN HRD_OT_MANAGER.OPEN_TIME IS '��ٽð�';
COMMENT ON COLUMN HRD_OT_MANAGER.CLOSE_TIME IS '��ٽð�';
COMMENT ON COLUMN HRD_OT_MANAGER.REAL_OT_TIME IS '�ܾ��ð�';
COMMENT ON COLUMN HRD_OT_MANAGER.LEAVE_TIME IS '����ð�';
COMMENT ON COLUMN HRD_OT_MANAGER.CREATION_DATE  IS '��������';
COMMENT ON COLUMN HRD_OT_MANAGER.CREATED_BY IS '������';
COMMENT ON COLUMN HRD_OT_MANAGER.LAST_UPDATE_DATE IS '������������';
COMMENT ON COLUMN HRD_OT_MANAGER.LAST_UPDATED_BY IS '����������';

-- CREATE INDEX.
ALTER TABLE HRD_OT_MANAGER ADD CONSTRAINTS HRD_OT_MANAGER_PK PRIMARY KEY(WORK_DATE, PERSON_ID, SOB_ID, ORG_ID, OT_TYPE_ID);

-- ANALYZE.
ANALYZE TABLE HRD_OT_MANAGER COMPUTE STATISTICS;
ANALYZE INDEX HRD_OT_MANAGER_PK COMPUTE STATISTICS;
