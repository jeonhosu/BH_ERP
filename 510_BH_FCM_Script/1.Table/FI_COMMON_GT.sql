/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : ���������� �̿��ؼ� ������ ��ȸ�� ���.
/* Description  : �ش� �Ⱓ�� ���� ���ڸ� ����
/*
/* Reference by : TEMPORARY TABLE�� �̿��Ͽ� ó��.
/* Program History :
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE GLOBAL TEMPORARY TABLE FI_COMMON_GT
( COMMON_ID                                     NUMBER,
  GROUP_CODE                                    VARCHAR2(70),
  CODE                                          VARCHAR2(70),
  CODE_NAME                                     VARCHAR2(150),
  SYSTEM_FLAG                                   VARCHAR2(1), 
  CODE_LENGTH                                   NUMBER,
  VALUE1                                        VARCHAR2(150),
  VALUE2                                        VARCHAR2(150),
  VALUE3                                        VARCHAR2(150), 
  VALUE4                                        VARCHAR2(150),
  VALUE5                                        VARCHAR2(150),
  VALUE6                                        VARCHAR2(150),
  VALUE7                                        VARCHAR2(150),
  VALUE8                                        VARCHAR2(150),
  VALUE9                                        VARCHAR2(150),
  VALUE10                                       VARCHAR2(150),
  DEFAULT_FLAG                                  VARCHAR2(1),
  SORT_NUM                                      NUMBER,
  DESCRIPTION                                   VARCHAR2(100),
  ENABLED_FLAG                                  VARCHAR2(1),
  EFFECTIVE_DATE_FR                             DATE,
  EFFECTIVE_DATE_TO                             DATE,
  SOB_ID                                        NUMBER,
  ORG_ID                                        NUMBER
) ON COMMIT PRESERVE ROWS;
