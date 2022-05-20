/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRD_SECOM_HISTORY
/* Description  : 세콤 출퇴근 자료 
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

COMMENT ON TABLE HRD_SECOM_HISTORY IS '세콤 근태/식수 자료 내역';
COMMENT ON COLUMN APPS.HRD_SECOM_HISTORY.ATIME IS '체크 일시';
COMMENT ON COLUMN APPS.HRD_SECOM_HISTORY.ID_SEQ IS '체크 일시 라인번호';
COMMENT ON COLUMN APPS.HRD_SECOM_HISTORY.PARAM_A IS '0:근태용, 1:식수용';
COMMENT ON COLUMN APPS.HRD_SECOM_HISTORY.ACK IS '식수용인 경우, ACK관련 3개필드 사용(ACK, ACKUSER, ACKTIME):0.기초이벤트, 1재생성,2수기입력,3수정';
COMMENT ON COLUMN APPS.HRD_SECOM_HISTORY.ACKUSER IS '수정자ID';
COMMENT ON COLUMN APPS.HRD_SECOM_HISTORY.ACKTIME IS '수정시간';
COMMENT ON COLUMN APPS.HRD_SECOM_HISTORY.MODE_A IS '0:기초이벤트,1:재생성,2:수기입력,3:수정';
COMMENT ON COLUMN APPS.HRD_SECOM_HISTORY.A_DATE IS '근태/식수 일자';
COMMENT ON COLUMN APPS.HRD_SECOM_HISTORY.A_TIME IS '근태/식수 시간';
COMMENT ON COLUMN APPS.HRD_SECOM_HISTORY.PERSON_NUM IS '사원번호';
COMMENT ON COLUMN APPS.HRD_SECOM_HISTORY.JUMIN_NUM IS '주민번호';
COMMENT ON COLUMN APPS.HRD_SECOM_HISTORY.INTERFACE_STATUS IS 'INTERFACE 상태(C-완료, E-오류, N-변경없음)';

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
