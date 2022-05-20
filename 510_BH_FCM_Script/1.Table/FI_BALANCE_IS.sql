/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FI_BALANCE_IS
/* Program Name : 손익계산서 생성.
/* Description  : 
/*
/* Reference by : 
/* Program History :
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE GLOBAL TEMPORARY TABLE FI_BALANCE_IS
( HEADER_ID                 NUMBER
, HEADER_CODE               VARCHAR2(20)
, HEADER_NAME               VARCHAR2(100)
, ITEM_LEVEL                NUMBER
, SORT_SEQ                  NUMBER
, LAST_LEVEL_YN             CHAR(1) DEFAULT 'N'
, SOB_ID                    NUMBER
, ORG_ID                    NUMBER
, THIS_L_AMOUNT             NUMBER DEFAULT 0
, THIS_R_AMOUNT             NUMBER DEFAULT 0
, PREV_L_AMOUNT             NUMBER DEFAULT 0
, PREV_R_AMOUNT             NUMBER DEFAULT 0
, ITEM_TYPE                 VARCHAR2(10)
, ITEM_CLASS                VARCHAR2(10)
, CREATION_DATE             DATE
, CREATED_BY                NUMBER
) ON COMMIT PRESERVE ROWS;

CREATE INDEX FI_BALANCE_IS_N1 ON FI_BALANCE_IS(HEADER_ID);
CREATE INDEX FI_BALANCE_IS_N2 ON FI_BALANCE_IS(HEADER_CODE, SOB_ID, ORG_ID);
CREATE INDEX FI_BALANCE_IS_N3 ON FI_BALANCE_IS(SORT_SEQ);
