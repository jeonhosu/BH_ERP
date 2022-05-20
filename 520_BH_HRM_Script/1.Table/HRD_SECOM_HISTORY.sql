/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRD_SECOM_HISTORY
/* Description  : ���� ����� �ڷ� 
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRD_SECOM_HISTORY
( ATIME                           VARCHAR2(50)    NOT NULL, 
  ID_SEQ                          NUMBER          NOT NULL,
  EQCODE_A                        NUMBER          ,
  MASTER_A                        NUMBER          ,
  LOCAL_A                         NUMBER          ,
  POINT_A                         NUMBER          ,
  LOOP_A                          NUMBER          ,
  EQNAME                          VARCHAR2(100)   ,
  STATE                           VARCHAR2(50)    ,
  PARAM_A                         NUMBER          ,
  USER_A                          VARCHAR2(100)   ,
  CONTENT_A                       VARCHAR2(100)   ,
  ACK                             NUMBER          ,
  ACKUSER                         VARCHAR2(100)   ,
  ACKCONTENT                      VARCHAR2(100)   ,
  ACKTIME                         VARCHAR2(50)    ,
  TRANSFER                        NUMBER          ,
  MODE_A                          NUMBER          ,
  A_DATE                          VARCHAR2(10)    DEFAULT '-',
  A_TIME                          VARCHAR2(10)    DEFAULT '-',
  PERSON_NUM                      VARCHAR2(50)    DEFAULT '-',
  JUMIN_NUM                       VARCHAR2(50)    DEFAULT '-',
  SOB_ID                          NUMBER          NOT NULL,
  ORG_ID                          NUMBER          NOT NULL,
  CREATION_DATE                   DATE            ,
  CREATED_BY                      NUMBER          ,
  INTERFACE_STATUS                VARCHAR2(1)     DEFAULT 'N'
) TABLESPACE FCM_TS_DATA;

COMMENT ON TABLE HRD_SECOM_HISTORY IS '���� ����/�ļ� �ڷ� ����';
COMMENT ON COLUMN APPS.HRD_SECOM_HISTORY.ATIME IS 'üũ �Ͻ�';
COMMENT ON COLUMN APPS.HRD_SECOM_HISTORY.ID_SEQ IS 'üũ �Ͻ� ���ι�ȣ';
COMMENT ON COLUMN APPS.HRD_SECOM_HISTORY.PARAM_A IS '0:���¿�, 1:�ļ���';
COMMENT ON COLUMN APPS.HRD_SECOM_HISTORY.ACK IS '�ļ����� ���, ACK���� 3���ʵ� ���(ACK, ACKUSER, ACKTIME):0.�����̺�Ʈ, 1�����,2�����Է�,3����';
COMMENT ON COLUMN APPS.HRD_SECOM_HISTORY.ACKUSER IS '������ID';
COMMENT ON COLUMN APPS.HRD_SECOM_HISTORY.ACKTIME IS '�����ð�';
COMMENT ON COLUMN APPS.HRD_SECOM_HISTORY.MODE_A IS '0:�����̺�Ʈ,1:�����,2:�����Է�,3:����';
COMMENT ON COLUMN APPS.HRD_SECOM_HISTORY.A_DATE IS '����/�ļ� ����';
COMMENT ON COLUMN APPS.HRD_SECOM_HISTORY.A_TIME IS '����/�ļ� �ð�';
COMMENT ON COLUMN APPS.HRD_SECOM_HISTORY.PERSON_NUM IS '�����ȣ';
COMMENT ON COLUMN APPS.HRD_SECOM_HISTORY.JUMIN_NUM IS '�ֹι�ȣ';
COMMENT ON COLUMN APPS.HRD_SECOM_HISTORY.INTERFACE_STATUS IS 'INTERFACE ����(C-�Ϸ�, E-����, N-�������)';

-- PRIMARY KEY
CREATE UNIQUE INDEX HRD_SECOM_HISTORY_PK ON 
  HRD_SECOM_HISTORY(ATIME, ID_SEQ, SOB_ID, ORG_ID)
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

ALTER TABLE HRD_SECOM_HISTORY ADD ( 
  CONSTRAINT HRD_SECOM_HISTORY_PK PRIMARY KEY ( ATIME, ID_SEQ, SOB_ID, ORG_ID ) 
        );

CREATE INDEX HRD_SECOM_HISTORY_N1 ON HRD_SECOM_HISTORY(A_DATE, A_TIME) TABLESPACE FCM_TS_IDX;
CREATE INDEX HRD_SECOM_HISTORY_N2 ON HRD_SECOM_HISTORY(PERSON_NUM, SOB_ID, ORG_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX HRD_SECOM_HISTORY_N3 ON HRD_SECOM_HISTORY(JUMIN_NUM, SOB_ID, ORG_ID) TABLESPACE FCM_TS_IDX;   
CREATE INDEX HRD_SECOM_HISTORY_N4 ON HRD_SECOM_HISTORY(SUBSTR(ATIME, 1, 8)) TABLESPACE FCM_TS_IDX;
