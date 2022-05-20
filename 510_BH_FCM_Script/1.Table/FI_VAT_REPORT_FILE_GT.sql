/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_VAT_REPORT_FILE_GT
/* Description  : �ΰ��� - �Ű� ���� ������ ���� �ӽ� ���̺�.
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

COMMENT ON TABLE FI_VAT_REPORT_FILE_GT IS '�ΰ��� �������� ���� �ӽ� ���̺�';
COMMENT ON COLUMN FI_VAT_REPORT_FILE_GT.SEQ_NUM IS '���ļ��� ID';
COMMENT ON COLUMN FI_VAT_REPORT_FILE_GT.SOURCE_FILE IS '���� ����';
COMMENT ON COLUMN FI_VAT_REPORT_FILE_GT.REPORT_FILE IS '�ΰ��������ڷ�';

-- INDEX.
CREATE INDEX FI_VAT_REPORT_FILE_GT_N1 ON FI_VAT_REPORT_FILE_GT(SEQ_NUM, SOB_ID):

