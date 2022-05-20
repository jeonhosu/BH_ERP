/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_DPR_RATE
/* Description  : �����ڻ� ��������(����)
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_DPR_RATE 
( DPR_TYPE                        VARCHAR2(10)    NOT NULL,
  SOB_ID                          NUMBER          NOT NULL,
  ORG_ID                          NUMBER          NOT NULL,
  PROGRESS_YEAR                   NUMBER          NOT NULL,
  DPR_RATE                        NUMBER          NOT NULL,
  REMARK                          VARCHAR2(200)   ,
  ATTRIBUTE_A                     VARCHAR2(200)   ,
  ATTRIBUTE_B                     VARCHAR2(200)   ,
  ATTRIBUTE_C                     VARCHAR2(200)   ,
  ATTRIBUTE_D                     VARCHAR2(200)   ,
  ATTRIBUTE_E                     VARCHAR2(200)   ,
  ATTRIBUTE_1                     NUMBER          ,
  ATTRIBUTE_2                     NUMBER          ,
  ATTRIBUTE_3                     NUMBER          ,
  ATTRIBUTE_4                     NUMBER          ,
  ATTRIBUTE_5                     NUMBER          ,
  ENABLED_FLAG                    CHAR(1)         DEFAULT 'Y',
  EFFECTIVE_DATE_FR               DATE            NOT NULL,
  EFFECTIVE_DATE_TO               DATE            ,
  CREATION_DATE                   DATE            NOT NULL,
  CREATED_BY                      NUMBER          NOT NULL,
  LAST_UPDATE_DATE                DATE            NOT NULL,
  LAST_UPDATED_BY                 NUMBER          NOT NULL   
)TABLESPACE FCM_TS_DATA;

COMMENT ON TABLE FI_DPR_RATE  IS '�������� ����';
COMMENT ON COLUMN FI_DPR_RATE.DPR_TYPE IS '�� Ÿ��';
COMMENT ON COLUMN FI_DPR_RATE.SOB_ID IS 'ȸ������';
COMMENT ON COLUMN FI_DPR_RATE.PROGRESS_YEAR IS '������';
COMMENT ON COLUMN FI_DPR_RATE.DPR_RATE IS '����';
COMMENT ON COLUMN FI_DPR_RATE.REMARK IS '���';
COMMENT ON COLUMN FI_DPR_RATE.ENABLED_FLAG IS '��뿩��';
COMMENT ON COLUMN FI_DPR_RATE.EFFECTIVE_DATE_FR IS '���� ��������';
COMMENT ON COLUMN FI_DPR_RATE.EFFECTIVE_DATE_TO IS '���� ��������';
COMMENT ON COLUMN FI_DPR_RATE.CREATION_DATE IS '��������';
COMMENT ON COLUMN FI_DPR_RATE.CREATED_BY IS '������';
COMMENT ON COLUMN FI_DPR_RATE.LAST_UPDATE_DATE IS '������������';
COMMENT ON COLUMN FI_DPR_RATE.LAST_UPDATED_BY IS '����������';

CREATE UNIQUE INDEX FI_DPR_RATE_PK ON 
  FI_DPR_RATE(DPR_TYPE, PROGRESS_YEAR, SOB_ID)
  TABLESPACE FCM_TS_IDX
  PCTFREE 10
  INITRANS 2
  MAXTRANS 255
  LOGGING
  STORAGE (
           INITIAL 64K
           MINEXTENTS 1
           MAXEXTENTS 2147483645
          );
          
 ALTER TABLE FI_DPR_RATE ADD (                                  
  CONSTRAINT FI_DPR_RATE_PK PRIMARY KEY (DPR_TYPE, PROGRESS_YEAR, SOB_ID));

-- ANALYZE.
ANALYZE TABLE FI_DPR_RATE COMPUTE STATISTICS;
