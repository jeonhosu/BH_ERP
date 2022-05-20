/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRT_PAY_MST_COMMON_HEADER
/* Description  : �޿������� ���� HEADER ����
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRT_PAY_MST_COMMON_HEADER              
( COMMON_HEADER_ID                NUMBER          NOT NULL,
  START_YYYYMM                    VARCHAR2(7)     NOT NULL,
  END_YYYYMM                      VARCHAR2(7)     DEFAULT '9999-12',
  SOB_ID                          NUMBER          NOT NULL,
  ORG_ID                          NUMBER          NOT NULL,
  CORP_ID                         NUMBER          ,
  PRINT_TYPE                      VARCHAR2(1)     ,
  PAY_TYPE                        VARCHAR2(2)     ,
  PAY_PROVIDE_YN                  VARCHAR2(1)     DEFAULT 'Y',
  BONUS_PROVIDE_YN                VARCHAR2(1)     DEFAULT 'Y',
  YEAR_PROVIDE_YN                 VARCHAR2(1)     DEFAULT 'Y',
  INSUR_YN                        VARCHAR2(1)     DEFAULT 'Y',
  LAST_YN                         VARCHAR2(1)     ,
  DESCRIPTION                     VARCHAR2(150)   ,
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
COMMENT ON TABLE HRT_PAY_MST_COMMON_HEADER IS '�޿������� ���� HEADER ����';
COMMENT ON COLUMN HRT_PAY_MST_COMMON_HEADER.COMMON_HEADER_ID IS '�޿������� ��� ID';
COMMENT ON COLUMN HRT_PAY_MST_COMMON_HEADER.START_YYYYMM IS '���۳��';
COMMENT ON COLUMN HRT_PAY_MST_COMMON_HEADER.END_YYYYMM IS '������';
COMMENT ON COLUMN HRT_PAY_MST_COMMON_HEADER.CORP_ID IS '��üID';
COMMENT ON COLUMN HRT_PAY_MST_COMMON_HEADER.PRINT_TYPE IS '�μ�Ÿ��';
COMMENT ON COLUMN HRT_PAY_MST_COMMON_HEADER.PAY_TYPE IS '�޿��� Ÿ��';
COMMENT ON COLUMN HRT_PAY_MST_COMMON_HEADER.PAY_PROVIDE_YN IS '�޿� ����';
COMMENT ON COLUMN HRT_PAY_MST_COMMON_HEADER.BONUS_PROVIDE_YN IS '�󿩱� ����';
COMMENT ON COLUMN HRT_PAY_MST_COMMON_HEADER.YEAR_PROVIDE_YN IS '�������� ����';
COMMENT ON COLUMN HRT_PAY_MST_COMMON_HEADER.INSUR_YN IS '��뺸�� ����';
COMMENT ON COLUMN HRT_PAY_MST_COMMON_HEADER.LAST_YN IS '��������';
COMMENT ON COLUMN HRT_PAY_MST_COMMON_HEADER.DESCRIPTION IS '���';
COMMENT ON COLUMN HRT_PAY_MST_COMMON_HEADER.CREATION_DATE  IS '��������';
COMMENT ON COLUMN HRT_PAY_MST_COMMON_HEADER.CREATED_BY IS '������';
COMMENT ON COLUMN HRT_PAY_MST_COMMON_HEADER.LAST_UPDATE_DATE IS '������������';
COMMENT ON COLUMN HRT_PAY_MST_COMMON_HEADER.LAST_UPDATED_BY IS '����������';

-- CREATE INDEX.
CREATE UNIQUE INDEX HRT_PAY_MST_COMMON_HEADER_U1 ON HRT_PAY_MST_COMMON_HEADER(COMMON_HEADER_ID) TABLESPACE FCM_TS_IDX;

-- SEQUENCE.
CREATE SEQUENCE HRT_PAY_MST_COMMON_HEADER_S1;

-- ANALYZE.
ANALYZE TABLE HRT_PAY_MST_COMMON_HEADER COMPUTE STATISTICS;
ANALYZE INDEX HRT_PAY_MST_COMMON_HEADER_U1 COMPUTE STATISTICS;
