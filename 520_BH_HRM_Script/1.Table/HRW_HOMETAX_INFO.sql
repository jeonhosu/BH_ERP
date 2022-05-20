/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRW_HOMETAX_INFO
/* Description  : ���ڽŰ� ���� Ȩ�ý� ��������.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRW_HOMETAX_INFO
( CORP_ID                         NUMBER          NOT NULL,
  SOB_ID                          NUMBER          NOT NULL,
  ORG_ID                          NUMBER          NOT NULL,
  HOMETAX_ID                      VARCHAR2(100)   ,
  ENCRYPT_PWD                     VARCHAR2(50)    ,
  USER_DEPT                       VARCHAR2(100)   ,
  USER_NAME                       VARCHAR2(100)   ,
  USER_TEL_NUM                    VARCHAR2(20)    ,
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
COMMENT ON TABLE HRW_HOMETAX_INFO IS 'Ȩ�ý� �� ��ȣȭ ��й�ȣ ��������';
COMMENT ON COLUMN HRW_HOMETAX_INFO.CORP_ID IS '��üID';
COMMENT ON COLUMN HRW_HOMETAX_INFO.HOMETAX_ID IS 'Ȩ�ý�ID';
COMMENT ON COLUMN HRW_HOMETAX_INFO.ENCRYPT_PWD IS '��ȣȭ ��й�ȣ';
COMMENT ON COLUMN HRW_HOMETAX_INFO.USER_DEPT IS '���μ�';
COMMENT ON COLUMN HRW_HOMETAX_INFO.USER_NAME IS '����ڸ�';
COMMENT ON COLUMN HRW_HOMETAX_INFO.USER_TEL_NUM IS '����� ��ȭ��ȣ';
COMMENT ON COLUMN HRW_HOMETAX_INFO.DESCRIPTION IS '���';
COMMENT ON COLUMN HRW_HOMETAX_INFO.CREATION_DATE  IS '��������';
COMMENT ON COLUMN HRW_HOMETAX_INFO.CREATED_BY IS '������';
COMMENT ON COLUMN HRW_HOMETAX_INFO.LAST_UPDATE_DATE IS '������������';
COMMENT ON COLUMN HRW_HOMETAX_INFO.LAST_UPDATED_BY IS '����������';

-- PK.
ALTER TABLE HRW_HOMETAX_INFO ADD CONSTRAINTS HRW_HOMETAX_INFO_PK PRIMARY KEY(CORP_ID, SOB_ID);

-- ANALYZE.
ANALYZE TABLE HRW_HOMETAX_INFO COMPUTE STATISTICS;

