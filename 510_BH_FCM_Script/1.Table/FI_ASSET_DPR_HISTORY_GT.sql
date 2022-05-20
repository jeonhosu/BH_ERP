/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FI_ASSET_DPR_HISTORY_GT
/* Program Name : �ڻ�κ� �Ű��� ��� ���Ҿ� ���.
/* Description  : 
/*
/* Reference by : TEMPORARY TABLE�� �̿��Ͽ� ó��.
/* Program History :
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE GLOBAL TEMPORARY TABLE FI_ASSET_DPR_HISTORY_GT
( HISTORY_NUM_SEQ           NUMBER
, ASSET_ID                  NUMBER
, SOB_ID                    NUMBER
, ASSET_CATEGORY_ID         NUMBER
, PERIOD_NAME               VARCHAR2(10)
, DPR_AMOUNT                NUMBER
, THIS_SEQ                  NUMBER
, PREVIOUS_SEQ              NUMBER
) ON COMMIT PRESERVE ROWS;


CREATE INDEX FI_ASSET_DPR_HISTORY_GT_N1 ON FI_ASSET_DPR_HISTORY_GT(HISTORY_NUM_SEQ, ASSET_ID, SOB_ID, ASSET_CATEGORY_ID, PERIOD_NAME);
