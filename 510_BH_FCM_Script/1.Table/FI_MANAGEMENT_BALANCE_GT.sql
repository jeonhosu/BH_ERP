/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_MANAGEMENT_BALANCE_GT
/* Description  : ������ �����׸� ���ں� �ݾ�.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE GLOBAL TEMPORARY TABLE FI_MANAGEMENT_BALANCE_GT
( GL_DATE                     DATE          NOT NULL,  -- ȸ������.
  GL_DATE_SEQ                 NUMBER        DEFAULT 1,  -- �����Ϸù�ȣ.
  SOB_ID                      NUMBER        NOT NULL,  -- ȸ���ڵ�.
  ACCOUNT_CONTROL_ID          NUMBER        NOT NULL,  -- ��������ID. 
  ACCOUNT_CODE                VARCHAR2(20)  ,
  MANAGEMENT_ID               NUMBER        NOT NULL,  -- �����׸� ID.    
  MANAGEMENT_CODE             VARCHAR2(10)  ,
  MANAGEMENT_VALUE            VARCHAR2(50)  NOT NULL,  -- �����׸� ��.
  DR_SUM                      NUMBER        DEFAULT 0, -- �����հ�.
  CR_SUM                      NUMBER        DEFAULT 0, -- �뺯�հ�.
  REMAIN_SUM                  NUMBER        DEFAULT 0, -- �ܾ�  
  CURRENCY_CODE               VARCHAR2(10)  ,          -- ��ȭ.
  DR_CURR_SUM                 NUMBER        DEFAULT 0, -- ����(��ȭ)�հ�.
  CR_CURR_SUM                 NUMBER        DEFAULT 0, -- �뺯(��ȭ)�հ�.
  REMAIN_CURR_SUM             NUMBER        DEFAULT 0, -- �ܾ�(��ȭ).
  REMARK                      VARCHAR2(200)
) ON COMMIT PRESERVE ROWS;

CREATE INDEX FI_MANAGEMENT_BALANCE_GT_N1 ON FI_MANAGEMENT_BALANCE_GT(GL_DATE, GL_DATE_SEQ, SOB_ID, ACCOUNT_CONTROL_ID, MANAGEMENT_ID);
