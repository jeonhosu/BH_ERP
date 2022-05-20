/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_VAT_REPORT_FILE_GT
/* Description  : 부가세 - 신고 파일 생성을 위한 임시 테이블.
/*
/* Reference by : 
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE GLOBAL TEMPORARY TABLE FI_VAT_REPORT_FILE_GT
( SEQ_NUM                         NUMBER          NOT NULL,
  SOURCE_FILE                     VARCHAR2(150)   NOT NULL,
  SOB_ID                          NUMBER          NOT NULL,
  REPORT_FILE                     VARCHAR2(3000)  
) ON COMMIT PRESERVE ROWS;

COMMENT ON TABLE FI_VAT_REPORT_FILE_GT IS '부가세 전자파일 생성 임시 테이블';
COMMENT ON COLUMN FI_VAT_REPORT_FILE_GT.SEQ_NUM IS '정렬순서 ID';
COMMENT ON COLUMN FI_VAT_REPORT_FILE_GT.SOURCE_FILE IS '원본 파일';
COMMENT ON COLUMN FI_VAT_REPORT_FILE_GT.REPORT_FILE IS '부가세파일자료';

-- INDEX.
CREATE INDEX FI_VAT_REPORT_FILE_GT_N1 ON FI_VAT_REPORT_FILE_GT(SEQ_NUM, SOB_ID):

