/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRM_PERSON_PHOTO
/* Description  : 사원사진 관리
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRM_PERSON_PHOTO              
(PERSON_ID                                    NUMBER NOT NULL,
  PHOTO                                          BLOB,
  FILE_ID                                          NUMBER,
  FILE_NAME                                    VARCHAR2(200),
  FILE_CONTENT_TYPE                    VARCHAR2(200),
  DESCRIPTION                             VARCHAR2(100),
  ATTRIBUTE1                                  VARCHAR2(100),
  ATTRIBUTE2                                  VARCHAR2(100),
  ATTRIBUTE3                                  VARCHAR2(100),
  ATTRIBUTE4                                  VARCHAR2(100),
  ATTRIBUTE5                                  VARCHAR2(100),
  CREATION_DATE                            DATE NOT NULL,
  CREATED_BY                                  NUMBER NOT NULL,
  LAST_UPDATE_DATE                       DATE NOT NULL,
  LAST_UPDATED_BY                         NUMBER NOT NULL
)
TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON COLUMN HRM_PERSON_PHOTO.PERSON_ID IS '사원ID';
COMMENT ON COLUMN HRM_PERSON_PHOTO.PHOTO IS '이미지 자료';
COMMENT ON COLUMN HRM_PERSON_PHOTO.FILE_ID IS 'FILE ID';
COMMENT ON COLUMN HRM_PERSON_PHOTO.FILE_NAME IS '파일명';
COMMENT ON COLUMN HRM_PERSON_PHOTO.FILE_CONTENT_TYPE IS '파일 타입';
COMMENT ON COLUMN HRM_PERSON_PHOTO.DESCRIPTION IS '비고';
COMMENT ON COLUMN HRM_PERSON_PHOTO.CREATION_DATE  IS '생성일자';
COMMENT ON COLUMN HRM_PERSON_PHOTO.CREATED_BY IS '생성자';
COMMENT ON COLUMN HRM_PERSON_PHOTO.LAST_UPDATE_DATE IS '최종수정일자';
COMMENT ON COLUMN HRM_PERSON_PHOTO.LAST_UPDATED_BY IS '최종수정자';

-- CREATE INDEX.
CREATE UNIQUE INDEX HRM_PERSON_PHOTO_U1 ON HRM_PERSON_PHOTO(PERSON_ID) TABLESPACE FCM_TS_IDX;

-- ANALYZE.
ANALYZE TABLE HRM_PERSON_PHOTO COMPUTE STATISTICS;
ANALYZE INDEX HRM_PERSON_PHOTO_U1 COMPUTE STATISTICS;
