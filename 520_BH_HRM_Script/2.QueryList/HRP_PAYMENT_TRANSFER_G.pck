CREATE OR REPLACE PACKAGE HRP_PAYMENT_TRANSFER_G
IS

--  �޻� ���� ��ü ����.
  PROCEDURE PAYMENT_TRANSFER_SELECT
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_CORP_ID            IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
            , W_PAY_YYYYMM         IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , W_WAGE_TYPE          IN HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , W_DEPT_ID            IN HRP_MONTH_PAYMENT.DEPT_ID%TYPE
            , W_PAY_GRADE_ID       IN HRP_MONTH_PAYMENT.PAY_GRADE_ID%TYPE
            , W_PERSON_ID          IN HRP_MONTH_PAYMENT.PERSON_ID%TYPE
            , W_SOB_ID             IN NUMBER
            , W_ORG_ID             IN NUMBER
            );

END HRP_PAYMENT_TRANSFER_G;

 
/
CREATE OR REPLACE PACKAGE BODY HRP_PAYMENT_TRANSFER_G
IS
/******************************************************************************/
/* Project      : FLEX ERP
/* Module       : HRMF
/* Program Name : HRP_PAYMENT_TRANSFER_G
/* Description  : �޻� ���� ��ü ���� PACKAGE.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 5-NOV-2010  Lee sun hee      Initialize
/******************************************************************************/

   
-- �޻� ���� ��ü ����
  PROCEDURE PAYMENT_TRANSFER_SELECT
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_CORP_ID            IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
            , W_PAY_YYYYMM         IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , W_WAGE_TYPE          IN HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , W_DEPT_ID            IN HRP_MONTH_PAYMENT.DEPT_ID%TYPE
            , W_PAY_GRADE_ID       IN HRP_MONTH_PAYMENT.PAY_GRADE_ID%TYPE
            , W_PERSON_ID          IN HRP_MONTH_PAYMENT.PERSON_ID%TYPE
            , W_SOB_ID             IN NUMBER
            , W_ORG_ID             IN NUMBER
            )
  AS
  BEGIN
    OPEN P_CURSOR FOR
      SELECT MP.PERSON_ID
           , PM.NAME
           , PM.PERSON_NUM
           , PM.DEPT_CODE
           , PM.DEPT_NAME
           , PG.PAY_GRADE
           , PG.PAY_GRADE_NAME
           , SX1.BANK_NAME
           , SX1.BANK_ACCOUNTS
           , MP.REAL_AMOUNT     -- �����޾�.
        FROM HRP_MONTH_PAYMENT MP --���޿�.
          , HRM_PERSON_MASTER_TLV PM  --�λ�����.
          , HRM_PAY_GRADE_V PG  -- ����.
          , (-- �޿� ������.
              SELECT PMH.PERSON_ID
                   , PMH.PAY_GRADE_ID
                   , PMH.BANK_ID
                   , HRM_COMMON_G.ID_NAME_F(PMH.BANK_ID) AS BANK_NAME
                   , PMH.BANK_ACCOUNTS     
                FROM HRP_PAY_MASTER_HEADER PMH
               WHERE PMH.CORP_ID                = W_CORP_ID
                 AND PMH.SOB_ID                 = W_SOB_ID
                 AND PMH.ORG_ID                 = W_ORG_ID
                 AND PMH.START_YYYYMM           <= W_PAY_YYYYMM
                 AND PMH.END_YYYYMM             >= W_PAY_YYYYMM
             ) SX1
       WHERE MP.PERSON_ID               = PM.PERSON_ID
         AND MP.PAY_GRADE_ID            = PG.PAY_GRADE_ID
         AND MP.PERSON_ID               = SX1.PERSON_ID
         AND MP.PAY_YYYYMM              = W_PAY_YYYYMM
         AND MP.WAGE_TYPE               = W_WAGE_TYPE --��/�� ����.
         AND MP.CORP_ID                 = W_CORP_ID   --ȸ��ID.
         AND MP.DEPT_ID                 = NVL(W_DEPT_ID, MP.DEPT_ID) --�μ�ID.
         AND MP.PAY_GRADE_ID            = NVL(W_PAY_GRADE_ID, MP.PAY_GRADE_ID) --����ID.
         AND MP.PERSON_ID               = NVL(W_PERSON_ID, MP.PERSON_ID)
         AND MP.SOB_ID                  = W_SOB_ID
         AND MP.ORG_ID                  = W_ORG_ID
      ORDER BY PM.DEPT_CODE, PG.PAY_GRADE, PM.PERSON_NUM
      ;
  
  END PAYMENT_TRANSFER_SELECT;
  
END HRP_PAYMENT_TRANSFER_G;
/
