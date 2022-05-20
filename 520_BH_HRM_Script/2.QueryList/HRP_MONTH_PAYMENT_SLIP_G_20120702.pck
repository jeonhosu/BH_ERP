CREATE OR REPLACE PACKAGE HRP_MONTH_PAYMENT_SLIP_G
AS

-- �޻� �ڷ�  �հ� SELECT
  PROCEDURE SELECT_PAYMENT_SUM
            ( P_CURSOR            OUT TYPES.TCURSOR
            , P_CORP_ID           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
            , P_PAY_YYYYMM        IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE         IN HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , P_SOB_ID            IN HRP_MONTH_PAYMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRP_MONTH_PAYMENT.ORG_ID%TYPE
            );
            
-- �޻� �ڷ� ��ǥ ����.
  PROCEDURE SET_PAYMENT_SLIP
            ( P_CORP_ID           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
            , P_PAY_YYYYMM        IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE         IN HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , P_SOB_ID            IN HRP_MONTH_PAYMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRP_MONTH_PAYMENT.ORG_ID%TYPE
            , P_CONNECT_PERSON_ID IN NUMBER
            , P_USER_ID           IN NUMBER
            , O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            );

-- �޻� �ڷ� ��ǥ ���.
  PROCEDURE CANCEL_PAYMENT_SLIP
            ( P_CORP_ID           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
            , P_PAY_YYYYMM        IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE         IN HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , P_SOB_ID            IN HRP_MONTH_PAYMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRP_MONTH_PAYMENT.ORG_ID%TYPE
            , P_CONNECT_PERSON_ID IN NUMBER
            , P_USER_ID           IN NUMBER
            , O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            );

---------------------------------------------------------------------------------------------------
-- �޻� ����� �����ڵ� �����ڼ� ����.
  FUNCTION CC_NONREGISTERED_COUNT_F
            ( P_CORP_ID           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
            , P_PAY_YYYYMM        IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE         IN HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , P_SOB_ID            IN HRP_MONTH_PAYMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRP_MONTH_PAYMENT.ORG_ID%TYPE
            ) RETURN NUMBER;
            
END HRP_MONTH_PAYMENT_SLIP_G;
/
CREATE OR REPLACE PACKAGE BODY HRP_MONTH_PAYMENT_SLIP_G
AS
/******************************************************************************/
/* PROJECT      : FPCB ERP
/* MODULE       : EAPP
/* PROGRAM NAME : HRP_MONTH_PAYMENT_SLIP_G
/* DESCRIPTION  : �޻� ���� �ڵ���ǥ ����.
/* REFERENCE BY :
/* PROGRAM HISTORY : �ű� ����
/*------------------------------------------------------------------------------
/*   DATE       IN CHARGE          DESCRIPTION
/*------------------------------------------------------------------------------
/* 20-JUN-2010  JEON HO SU          INITIALIZE
/******************************************************************************/
-- �޻� �ڷ� SELECT
  PROCEDURE SELECT_PAYMENT_SUM
            ( P_CURSOR            OUT TYPES.TCURSOR
            , P_CORP_ID           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
            , P_PAY_YYYYMM        IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE         IN HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , P_SOB_ID            IN HRP_MONTH_PAYMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRP_MONTH_PAYMENT.ORG_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR FOR
      -- �޿��ǰ�/�޿�����/��󿬱����ߺ�.
      SELECT AJM.SLIP_TYPE_CD
           , AJM.JOB_CATEGORY_CD
           , AJM.SLIP_REMARKS AS HEADER_REMARK
           , AJD.AUTO_JOURNAL_SEQ
           , AJD.ACCOUNT_CONTROL_ID
           , AJD.ACCOUNT_CODE
           , AC.ACCOUNT_DESC
           , NVL(PAY_AL.ACCOUNT_DR_CR, AJD.ACCOUNT_DR_CR) AS ACCOUNT_DR_CR
           , FI_COMMON_G.CODE_NAME_F('ACCOUNT_DR_CR', NVL(PAY_AL.ACCOUNT_DR_CR, AJD.ACCOUNT_DR_CR), AJD.SOB_ID) AS ACCOUNT_DR_CR_DESC
           , DECODE( NVL(PAY_AL.ACCOUNT_DR_CR, AJD.ACCOUNT_DR_CR), '1', NVL(PAY_AL.AMOUNT, 0)) AS DR_AMOUNT
           , DECODE(NVL(PAY_AL.ACCOUNT_DR_CR, AJD.ACCOUNT_DR_CR), '2', NVL(PAY_AL.AMOUNT, 0)) AS CR_AMOUNT
           , PAY_AL.VENDOR_CODE
           , FI_COMMON_G.SUPP_CUST_CODE_NAME_F(PAY_AL.VENDOR_CODE, P_SOB_ID) AS VENDOR_NAME
           , AJD.SLIP_REMARKS
           , ( SELECT MAX(MP.INTERFACE_NUM) AS INTERFACE_NUM
                 FROM HRP_MONTH_PAYMENT MP
               WHERE MP.PAY_YYYYMM    = P_PAY_YYYYMM
                AND MP.WAGE_TYPE      = P_WAGE_TYPE  -- �޿�.
                AND MP.CORP_ID        = P_CORP_ID
                AND MP.SOB_ID         = P_SOB_ID
                AND MP.ORG_ID         = P_ORG_ID
              ) AS SLIP_NUM
        FROM FI_AUTO_JOURNAL_MST AJM
          , FI_AUTO_JOURNAL_DET AJD
          , FI_ACCOUNT_CONTROL AC
          , ( -- ����.
              SELECT PM.SOB_ID
                   , PM.ORG_ID
                   , NULL AS ACCOUNT_DR_CR
                   , CASE 
                       WHEN P_WAGE_TYPE = 'P1' THEN 
                         CASE
                           WHEN PM.DIR_INDIR_TYPE = '10' THEN '5200100'  -- �޿��ǰ�.
                           WHEN PM.DIR_INDIR_TYPE IN('20', '30') THEN '5120100'  -- �޿�����.
                           WHEN PM.DIR_INDIR_TYPE = '40' THEN '5131501'  -- �޿���󿬱����ߺ�.
                         END 
                       WHEN P_WAGE_TYPE IN ('P2', 'P3', 'P5') THEN 
                         CASE
                           WHEN PM.DIR_INDIR_TYPE = '10' THEN '5200200'  -- ���ǰ�.
                           WHEN PM.DIR_INDIR_TYPE IN('20', '30') THEN '5120200'  -- ������.
                           WHEN PM.DIR_INDIR_TYPE = '40' THEN '5131501'  -- �޿���󿬱����ߺ�.
                         END
                     END AS ACCOUNT_CODE
                   , 'S000632' AS VENDOR_CODE
                   , SUM(MA.ALLOWANCE_AMOUNT) AS AMOUNT
                FROM HRM_PERSON_MASTER PM
                  , HRP_MONTH_PAYMENT MP
                  , HRP_MONTH_ALLOWANCE MA
              WHERE PM.PERSON_ID          = MP.PERSON_ID
                AND MP.MONTH_PAYMENT_ID   = MA.MONTH_PAYMENT_ID
                AND MP.PERSON_ID          = MA.PERSON_ID
                AND MP.PAY_YYYYMM         = P_PAY_YYYYMM
                AND MP.WAGE_TYPE          = P_WAGE_TYPE  -- �޿�.
                AND MP.CORP_ID            = P_CORP_ID
                AND MP.SOB_ID             = P_SOB_ID
                AND MP.ORG_ID             = P_ORG_ID
                -- �ߵ� ����� ���� ���� �Ǵ�.
              GROUP BY MP.PAY_YYYYMM
                   , MP.WAGE_TYPE
                   , PM.SOB_ID
                   , PM.ORG_ID
                   , CASE 
                       WHEN P_WAGE_TYPE = 'P1' THEN 
                         CASE
                           WHEN PM.DIR_INDIR_TYPE = '10' THEN '5200100'  -- �޿��ǰ�.
                           WHEN PM.DIR_INDIR_TYPE IN('20', '30') THEN '5120100'  -- �޿�����.
                           WHEN PM.DIR_INDIR_TYPE = '40' THEN '5131501'  -- �޿���󿬱����ߺ�.
                         END 
                       WHEN P_WAGE_TYPE IN ('P2', 'P3', 'P5') THEN 
                         CASE
                           WHEN PM.DIR_INDIR_TYPE = '10' THEN '5200200'  -- ���ǰ�.
                           WHEN PM.DIR_INDIR_TYPE IN('20', '30') THEN '5120200'  -- ������.
                           WHEN PM.DIR_INDIR_TYPE = '40' THEN '5131501'  -- �޿���󿬱����ߺ�.
                         END
                     END
              UNION ALL
              -- �Ǻ���.
              SELECT PM.SOB_ID
                   , PM.ORG_ID
                   , NULL AS ACCOUNT_DR_CR
                   , CASE 
                       WHEN P_WAGE_TYPE = 'P1' THEN 
                         CASE
                           WHEN PM.DIR_INDIR_TYPE IN('20', '30') THEN '5130401'  -- �޿�����.
                           WHEN PM.DIR_INDIR_TYPE = '40' THEN '5200401'  -- ������.
                         END 
                       WHEN P_WAGE_TYPE IN ('P2', 'P3', 'P5') THEN 
                         CASE
                           WHEN PM.DIR_INDIR_TYPE IN('20', '30') THEN '5130401'  -- �޿�����.
                           WHEN PM.DIR_INDIR_TYPE = '40' THEN '5200401'  -- ������.
                         END
                     END AS ACCOUNT_CODE
                   , 'S000632' AS VENDOR_CODE
                   , SUM(MD.DEDUCTION_AMOUNT) * -1 AS AMOUNT
                FROM HRM_PERSON_MASTER PM
                  , HRP_MONTH_PAYMENT MP
                  , HRP_MONTH_DEDUCTION MD
                  , HRM_DEDUCTION_V HD
              WHERE PM.PERSON_ID          = MP.PERSON_ID
                AND MP.MONTH_PAYMENT_ID   = MD.MONTH_PAYMENT_ID
                AND MP.PERSON_ID          = MD.PERSON_ID
                AND MD.DEDUCTION_ID       = HD.DEDUCTION_ID
                AND MP.PAY_YYYYMM         = P_PAY_YYYYMM
                AND MP.WAGE_TYPE          = P_WAGE_TYPE  -- �޿�.
                AND MP.CORP_ID            = P_CORP_ID
                AND MP.SOB_ID             = P_SOB_ID
                AND MP.ORG_ID             = P_ORG_ID
                AND HD.DEDUCTION_CODE     IN ('D11')
                -- �ߵ� ����� ���� ���� �Ǵ�.
              GROUP BY MP.PAY_YYYYMM
                   , MP.WAGE_TYPE
                   , PM.SOB_ID
                   , PM.ORG_ID
                   , CASE 
                       WHEN P_WAGE_TYPE = 'P1' THEN 
                         CASE
                           WHEN PM.DIR_INDIR_TYPE IN('20', '30') THEN '5130401'  -- �޿�����.
                           WHEN PM.DIR_INDIR_TYPE = '40' THEN '5200401'  -- ������.
                         END 
                       WHEN P_WAGE_TYPE IN ('P2', 'P3', 'P5') THEN 
                         CASE
                           WHEN PM.DIR_INDIR_TYPE IN('20', '30') THEN '5130401'  -- �޿�����.
                           WHEN PM.DIR_INDIR_TYPE = '40' THEN '5200401'  -- ������.
                         END
                     END
              UNION ALL
              -- ������.
              SELECT PM.SOB_ID
                   , PM.ORG_ID
                   , NULL AS ACCOUNT_DR_CR
                   , '2100600' AS ACCOUNT_CODE
                   , CASE 
                       WHEN HD.DEDUCTION_CODE = 'D01' THEN 'S000194'  -- �ҵ漼(����õ������).
                       WHEN HD.DEDUCTION_CODE = 'D02' THEN 'S000046'  -- �ֹμ�(����û).
                       WHEN HD.DEDUCTION_CODE IN('D03', 'D08') THEN 'S000043'  -- ���ο���(���ο��ݰ�������).
                       WHEN HD.DEDUCTION_CODE = 'D04' THEN 'S000042'  -- ��뺸��(�ٷκ�������).
                       WHEN HD.DEDUCTION_CODE IN('D05', 'D07') THEN 'S000045'  -- �ǰ�����(�ǰ������������).
                       WHEN HD.DEDUCTION_CODE IN('D06', 'D09') THEN 'S000045'  -- ��纸��(�ǰ������������).
                     END AS VENDOR_CODE
                   , SUM(MD.DEDUCTION_AMOUNT) AS AMOUNT
                FROM HRM_PERSON_MASTER PM
                  , HRP_MONTH_PAYMENT MP
                  , HRP_MONTH_DEDUCTION MD
                  , HRM_DEDUCTION_V HD
              WHERE PM.PERSON_ID          = MP.PERSON_ID
                AND MP.MONTH_PAYMENT_ID   = MD.MONTH_PAYMENT_ID
                AND MP.PERSON_ID          = MD.PERSON_ID
                AND MD.DEDUCTION_ID       = HD.DEDUCTION_ID
                AND MP.PAY_YYYYMM         = P_PAY_YYYYMM
                AND MP.WAGE_TYPE          = P_WAGE_TYPE  -- �޿�.
                AND MP.CORP_ID            = P_CORP_ID
                AND MP.SOB_ID             = P_SOB_ID
                AND MP.ORG_ID             = P_ORG_ID
                AND HD.DEDUCTION_CODE     BETWEEN 'D01' AND 'D09'
                -- �ߵ� ����� ���� ���� �Ǵ�.
              GROUP BY MP.PAY_YYYYMM
                   , MP.WAGE_TYPE
                   , PM.SOB_ID
                   , PM.ORG_ID
                   , CASE 
                       WHEN HD.DEDUCTION_CODE = 'D01' THEN 'S000194'  -- �ҵ漼(����õ������).
                       WHEN HD.DEDUCTION_CODE = 'D02' THEN 'S000046'  -- �ֹμ�(����û).
                       WHEN HD.DEDUCTION_CODE IN('D03', 'D08') THEN 'S000043'  -- ���ο���(���ο��ݰ�������).
                       WHEN HD.DEDUCTION_CODE = 'D04' THEN 'S000042'  -- ��뺸��(�ٷκ�������).
                       WHEN HD.DEDUCTION_CODE IN('D05', 'D07') THEN 'S000045'  -- �ǰ�����(�ǰ������������).
                       WHEN HD.DEDUCTION_CODE IN('D06', 'D09') THEN 'S000045'  -- ��纸��(�ǰ������������).
                     END
              UNION ALL
              -- ��Ÿ(�ҵ漼/���� �ֹμ�/���������) ������.
              SELECT PM.SOB_ID
                   , PM.ORG_ID
                   , NULL AS ACCOUNT_DR_CR
                   , '2100600' AS ACCOUNT_CODE
                   , CASE 
                       WHEN HD.DEDUCTION_CODE = 'D15' THEN 'S000194'  -- �ҵ漼(����õ������).
                       WHEN HD.DEDUCTION_CODE = 'D16' THEN 'S000046'  -- �ֹμ�(����û).
                       WHEN HD.DEDUCTION_CODE = 'D21' THEN 'S001815'  -- ���ﺸ������(��).
                     END AS VENDOR_CODE
                   , SUM(MD.DEDUCTION_AMOUNT) AS AMOUNT
                FROM HRM_PERSON_MASTER PM
                  , HRP_MONTH_PAYMENT MP
                  , HRP_MONTH_DEDUCTION MD
                  , HRM_DEDUCTION_V HD
              WHERE PM.PERSON_ID          = MP.PERSON_ID
                AND MP.MONTH_PAYMENT_ID   = MD.MONTH_PAYMENT_ID
                AND MP.PERSON_ID          = MD.PERSON_ID
                AND MD.DEDUCTION_ID       = HD.DEDUCTION_ID
                AND MP.PAY_YYYYMM         = P_PAY_YYYYMM
                AND MP.WAGE_TYPE          = P_WAGE_TYPE  -- �޿�.
                AND MP.CORP_ID            = P_CORP_ID
                AND MP.SOB_ID             = P_SOB_ID
                AND MP.ORG_ID             = P_ORG_ID
                AND HD.DEDUCTION_CODE     IN('D15', 'D16', 'D21')
                -- �ߵ� ����� ���� ���� �Ǵ�.
              GROUP BY MP.PAY_YYYYMM
                   , MP.WAGE_TYPE
                   , PM.SOB_ID
                   , PM.ORG_ID
                   , CASE 
                       WHEN HD.DEDUCTION_CODE = 'D15' THEN 'S000194'  -- �ҵ漼(����õ������).
                       WHEN HD.DEDUCTION_CODE = 'D16' THEN 'S000046'  -- �ֹμ�(����û).
                       WHEN HD.DEDUCTION_CODE = 'D21' THEN 'S001815'  -- ���ﺸ������(��).
                     END              
              UNION ALL
              -- ������.
              SELECT PM.SOB_ID
                   , PM.ORG_ID
                   , NULL AS ACCOUNT_DR_CR
                   , '1111600' AS ACCOUNT_CODE
                   , 'S001571' AS VENDOR_CODE  -- �ܱ��αٷ���.
                   , SUM(MD.DEDUCTION_AMOUNT) AS AMOUNT
                FROM HRM_PERSON_MASTER PM
                  , HRP_MONTH_PAYMENT MP
                  , HRP_MONTH_DEDUCTION MD
                  , HRM_DEDUCTION_V HD
              WHERE PM.PERSON_ID          = MP.PERSON_ID
                AND MP.MONTH_PAYMENT_ID   = MD.MONTH_PAYMENT_ID
                AND MP.PERSON_ID          = MD.PERSON_ID
                AND MD.DEDUCTION_ID       = HD.DEDUCTION_ID
                AND MP.PAY_YYYYMM         = P_PAY_YYYYMM
                AND MP.WAGE_TYPE          = P_WAGE_TYPE  -- �޿�.
                AND MP.CORP_ID            = P_CORP_ID
                AND MP.SOB_ID             = P_SOB_ID
                AND MP.ORG_ID             = P_ORG_ID
                AND HD.DEDUCTION_CODE     = 'D13'
                -- �ߵ� ����� ���� ���� �Ǵ�.
              GROUP BY MP.PAY_YYYYMM
                   , MP.WAGE_TYPE
                   , PM.SOB_ID
                   , PM.ORG_ID
              UNION ALL
              -- ������.
              SELECT PM.SOB_ID
                   , PM.ORG_ID
                   , NULL AS ACCOUNT_DR_CR
                   , '2101500' AS ACCOUNT_CODE
                   , 'S000632' AS VENDOR_CODE
                   , SUM(MD.DEDUCTION_AMOUNT) AS AMOUNT
                FROM HRM_PERSON_MASTER PM
                  , HRP_MONTH_PAYMENT MP
                  , HRP_MONTH_DEDUCTION MD
                  , HRM_DEDUCTION_V HD
              WHERE PM.PERSON_ID          = MP.PERSON_ID
                AND MP.MONTH_PAYMENT_ID   = MD.MONTH_PAYMENT_ID
                AND MP.PERSON_ID          = MD.PERSON_ID
                AND MD.DEDUCTION_ID       = HD.DEDUCTION_ID
                AND MP.PAY_YYYYMM         = P_PAY_YYYYMM
                AND MP.WAGE_TYPE          = P_WAGE_TYPE  -- �޿�.
                AND MP.CORP_ID            = P_CORP_ID
                AND MP.SOB_ID             = P_SOB_ID
                AND MP.ORG_ID             = P_ORG_ID
                AND HD.DEDUCTION_CODE     IN('D12')
                -- �ߵ� ����� ���� ���� �Ǵ�.
              GROUP BY MP.PAY_YYYYMM
                   , MP.WAGE_TYPE
                   , PM.SOB_ID
                   , PM.ORG_ID
              UNION ALL
              -- ��Ÿ������ä.
              SELECT PM.SOB_ID
                   , PM.ORG_ID
                   , NULL AS ACCOUNT_DR_CR
                   , '2101800' AS ACCOUNT_CODE  -- ��Ÿ������ä.
                   , 'S000632' AS VENDOR_CODE
                   , SUM(MP.REAL_AMOUNT) AS AMOUNT
                FROM HRM_PERSON_MASTER PM
                  , HRP_MONTH_PAYMENT MP
              WHERE PM.PERSON_ID          = MP.PERSON_ID
                AND MP.PAY_YYYYMM         = P_PAY_YYYYMM
                AND MP.WAGE_TYPE          = P_WAGE_TYPE  -- �޿�.
                AND MP.CORP_ID            = P_CORP_ID
                AND MP.SOB_ID             = P_SOB_ID
                AND MP.ORG_ID             = P_ORG_ID
                AND NVL(MP.REAL_AMOUNT, 0)  >= 0
                -- �ߵ� ����� ���� ���� �Ǵ�.
              GROUP BY MP.PAY_YYYYMM
                   , MP.WAGE_TYPE
                   , PM.SOB_ID
                   , PM.ORG_ID
              UNION ALL
              -- ��Ÿ������ä(-�ݾ�).
              SELECT PM.SOB_ID
                   , PM.ORG_ID
                   , '1' AS ACCOUNT_DR_CR
                   , '2101800' AS ACCOUNT_CODE  -- ��Ÿ������ä.
                   , 'S000632' AS VENDOR_CODE
                   , SUM(MP.REAL_AMOUNT) * -1 AS AMOUNT
                FROM HRM_PERSON_MASTER PM
                  , HRP_MONTH_PAYMENT MP
              WHERE PM.PERSON_ID          = MP.PERSON_ID
                AND MP.PAY_YYYYMM         = P_PAY_YYYYMM
                AND MP.WAGE_TYPE          = P_WAGE_TYPE  -- �޿�.
                AND MP.CORP_ID            = P_CORP_ID
                AND MP.SOB_ID             = P_SOB_ID
                AND MP.ORG_ID             = P_ORG_ID
                AND NVL(MP.REAL_AMOUNT, 0)  < 0
                -- �ߵ� ����� ���� ���� �Ǵ�.
              GROUP BY MP.PAY_YYYYMM
                   , MP.WAGE_TYPE
                   , PM.SOB_ID
                   , PM.ORG_ID                   
              -- 2011-10 ����ó��.(�������� => ���޿��� (-) ó����.
              UNION ALL
              SELECT PM.SOB_ID
                   , PM.ORG_ID
                   , NULL AS ACCOUNT_DR_CR
                   , CASE 
                       WHEN P_WAGE_TYPE = 'P1' THEN 
                         CASE
                           WHEN PM.DIR_INDIR_TYPE = '10' THEN '5200100'  -- �޿��ǰ�.
                           WHEN PM.DIR_INDIR_TYPE IN('20', '30') THEN '5120100'  -- �޿�����.
                           WHEN PM.DIR_INDIR_TYPE = '40' THEN '5131501'  -- �޿���󿬱����ߺ�.
                         END 
                       WHEN P_WAGE_TYPE IN ('P2', 'P5') THEN 
                         CASE
                           WHEN PM.DIR_INDIR_TYPE = '10' THEN '5200200'  -- ���ǰ�.
                           WHEN PM.DIR_INDIR_TYPE IN('20', '30') THEN '5120200'  -- ������.
                           WHEN PM.DIR_INDIR_TYPE = '40' THEN '5131501'  -- �޿���󿬱����ߺ�.
                         END
                     END AS ACCOUNT_CODE
                   , 'S000632' AS VENDOR_CODE
                   , SUM(MD.DEDUCTION_AMOUNT) * -1 AS AMOUNT
                FROM HRM_PERSON_MASTER PM
                  , HRP_MONTH_PAYMENT MP
                  , HRP_MONTH_DEDUCTION MD
                  , HRM_DEDUCTION_V HD
              WHERE PM.PERSON_ID          = MP.PERSON_ID
                AND MP.MONTH_PAYMENT_ID   = MD.MONTH_PAYMENT_ID
                AND MP.PERSON_ID          = MD.PERSON_ID
                AND MD.DEDUCTION_ID       = HD.DEDUCTION_ID
                AND MP.PAY_YYYYMM         = P_PAY_YYYYMM
                AND MP.WAGE_TYPE          = P_WAGE_TYPE  -- �޿�.
                AND MP.CORP_ID            = P_CORP_ID
                AND MP.SOB_ID             = P_SOB_ID
                AND MP.ORG_ID             = P_ORG_ID
                AND HD.DEDUCTION_CODE     IN('D14')
                AND (MP.PAY_YYYYMM        = '2012-02'
                AND PM.PERSON_NUM         NOT IN('B11002', 'B10113', 'B12002', 'B10114'))
                -- �ߵ� ����� ���� ���� �Ǵ�.
              GROUP BY MP.PAY_YYYYMM
                   , MP.WAGE_TYPE
                   , PM.SOB_ID
                   , PM.ORG_ID
                   , CASE 
                       WHEN P_WAGE_TYPE = 'P1' THEN 
                         CASE
                           WHEN PM.DIR_INDIR_TYPE = '10' THEN '5200100'  -- �޿��ǰ�.
                           WHEN PM.DIR_INDIR_TYPE IN('20', '30') THEN '5120100'  -- �޿�����.
                           WHEN PM.DIR_INDIR_TYPE = '40' THEN '5131501'  -- �޿���󿬱����ߺ�.
                         END 
                       WHEN P_WAGE_TYPE IN ('P2', 'P5') THEN 
                         CASE
                           WHEN PM.DIR_INDIR_TYPE = '10' THEN '5200200'  -- ���ǰ�.
                           WHEN PM.DIR_INDIR_TYPE IN('20', '30') THEN '5120200'  -- ������.
                           WHEN PM.DIR_INDIR_TYPE = '40' THEN '5131501'  -- �޿���󿬱����ߺ�.
                         END
                     END
              UNION ALL
              -- ������ : ����ó��<�ڹμ�> : ��Ÿ���� -> �ǰ������ ���� 
              SELECT PM.SOB_ID
                   , PM.ORG_ID
                   , NULL AS ACCOUNT_DR_CR
                   , '2100600' AS ACCOUNT_CODE
                   , 'S000045' AS VENDOR_CODE  -- �ǰ�����(�ǰ������������).
                   , SUM(MD.DEDUCTION_AMOUNT) AS AMOUNT
                FROM HRM_PERSON_MASTER PM
                  , HRP_MONTH_PAYMENT MP
                  , HRP_MONTH_DEDUCTION MD
                  , HRM_DEDUCTION_V HD
              WHERE PM.PERSON_ID          = MP.PERSON_ID
                AND MP.MONTH_PAYMENT_ID   = MD.MONTH_PAYMENT_ID
                AND MP.PERSON_ID          = MD.PERSON_ID
                AND MD.DEDUCTION_ID       = HD.DEDUCTION_ID
                AND MP.PAY_YYYYMM         = P_PAY_YYYYMM
                AND MP.PAY_YYYYMM         = '2012-02'
                AND PM.PERSON_NUM         = 'B11002'  -- �ڹμ�.
                AND MP.WAGE_TYPE          = P_WAGE_TYPE  -- �޿�.
                AND MP.CORP_ID            = P_CORP_ID
                AND MP.SOB_ID             = P_SOB_ID
                AND MP.ORG_ID             = P_ORG_ID
                AND HD.DEDUCTION_CODE     = 'D14'
                -- �ߵ� ����� ���� ���� �Ǵ�.
              GROUP BY MP.PAY_YYYYMM
                   , MP.WAGE_TYPE
                   , PM.SOB_ID
                   , PM.ORG_ID
              UNION ALL
              -- �����޺�� : ����ó��<�ڳ�ī, ���ٶ�, �ھ߹̴�> : ��Ÿ���� -> �����޺�� 
              SELECT PM.SOB_ID
                   , PM.ORG_ID
                   , NULL AS ACCOUNT_DR_CR
                   , '2100500' AS ACCOUNT_CODE
                   , 'S001571' AS VENDOR_CODE
                   , SUM(MD.DEDUCTION_AMOUNT) AS AMOUNT
                FROM HRM_PERSON_MASTER PM
                  , HRP_MONTH_PAYMENT MP
                  , HRP_MONTH_DEDUCTION MD
                  , HRM_DEDUCTION_V HD
              WHERE PM.PERSON_ID          = MP.PERSON_ID
                AND MP.MONTH_PAYMENT_ID   = MD.MONTH_PAYMENT_ID
                AND MP.PERSON_ID          = MD.PERSON_ID
                AND MD.DEDUCTION_ID       = HD.DEDUCTION_ID
                AND MP.PAY_YYYYMM         = P_PAY_YYYYMM
                AND MP.WAGE_TYPE          = P_WAGE_TYPE  -- �޿�.
                AND MP.CORP_ID            = P_CORP_ID
                AND MP.SOB_ID             = P_SOB_ID
                AND MP.ORG_ID             = P_ORG_ID
                AND HD.DEDUCTION_CODE     = 'D14'
                AND 1                     = 2
                -- �ߵ� ����� ���� ���� �Ǵ�.
              GROUP BY MP.PAY_YYYYMM
                   , MP.WAGE_TYPE
                   , PM.SOB_ID
                   , PM.ORG_ID
              UNION ALL
              -- �����޺�� : ��Ÿ���� -> ���ޱ�.
              SELECT PM.SOB_ID
                   , PM.ORG_ID
                   , NULL AS ACCOUNT_DR_CR
                   , '1111100' AS ACCOUNT_CODE
                   , 'S001571' AS VENDOR_CODE
                   , SUM(MD.DEDUCTION_AMOUNT) AS AMOUNT
                FROM HRM_PERSON_MASTER PM
                  , HRP_MONTH_PAYMENT MP
                  , HRP_MONTH_DEDUCTION MD
                  , HRM_DEDUCTION_V HD
              WHERE PM.PERSON_ID          = MP.PERSON_ID
                AND MP.MONTH_PAYMENT_ID   = MD.MONTH_PAYMENT_ID
                AND MP.PERSON_ID          = MD.PERSON_ID
                AND MD.DEDUCTION_ID       = HD.DEDUCTION_ID
                AND MP.PAY_YYYYMM         = P_PAY_YYYYMM
                AND MP.WAGE_TYPE          = P_WAGE_TYPE  -- �޿�.
                AND MP.CORP_ID            = P_CORP_ID
                AND MP.SOB_ID             = P_SOB_ID
                AND MP.ORG_ID             = P_ORG_ID
                AND HD.DEDUCTION_CODE     = 'D14'
                AND (MP.PAY_YYYYMM        = '2012-05'
                AND PM.PERSON_NUM         NOT IN('B03066', 'B10039', 'B11105'))  -- ������, �����, ����� : ����������� ó��.
                -- �ߵ� ����� ���� ���� �Ǵ�.
              GROUP BY MP.PAY_YYYYMM
                   , MP.WAGE_TYPE
                   , PM.SOB_ID
                   , PM.ORG_ID
              UNION ALL
              -- ����ó��<��Ÿ���� => ����������� ó��.>
              SELECT PM.SOB_ID
                   , PM.ORG_ID
                   , NULL AS ACCOUNT_DR_CR
                   , '5131701' AS ACCOUNT_CODE
                   , 'S000632' AS VENDOR_CODE  -- ������.
                   , SUM(MD.DEDUCTION_AMOUNT) * -1 AS AMOUNT
                FROM HRM_PERSON_MASTER PM
                  , HRP_MONTH_PAYMENT MP
                  , HRP_MONTH_DEDUCTION MD
                  , HRM_DEDUCTION_V HD
              WHERE PM.PERSON_ID          = MP.PERSON_ID
                AND MP.MONTH_PAYMENT_ID   = MD.MONTH_PAYMENT_ID
                AND MP.PERSON_ID          = MD.PERSON_ID
                AND MD.DEDUCTION_ID       = HD.DEDUCTION_ID
                AND MP.PAY_YYYYMM         = P_PAY_YYYYMM
                AND MP.PAY_YYYYMM         = '2012-06'
                --AND PM.PERSON_NUM         IN('B03066', 'B10039', 'B11105')  -- ������, �����, ����� : ����������� ó��.
                AND MP.WAGE_TYPE          = P_WAGE_TYPE  -- �޿�.
                AND MP.CORP_ID            = P_CORP_ID
                AND MP.SOB_ID             = P_SOB_ID
                AND MP.ORG_ID             = P_ORG_ID
                AND HD.DEDUCTION_CODE     = 'D14'
                -- �ߵ� ����� ���� ���� �Ǵ�.
              GROUP BY MP.PAY_YYYYMM
                   , MP.WAGE_TYPE
                   , PM.SOB_ID
                   , PM.ORG_ID
            ) PAY_AL
      WHERE AJM.SOB_ID              = AJD.SOB_ID
        AND AJM.SLIP_TYPE_CD        = AJD.SLIP_TYPE_CD
        AND AJM.JOB_CATEGORY_CD     = AJD.JOB_CATEGORY_CD
        AND AJD.ACCOUNT_CONTROL_ID  = AC.ACCOUNT_CONTROL_ID
        AND AJD.SOB_ID              = AC.SOB_ID
        AND AC.ACCOUNT_CODE         = PAY_AL.ACCOUNT_CODE(+)
        AND AC.SOB_ID               = PAY_AL.SOB_ID(+)
        AND AJD.SOB_ID              = P_SOB_ID
        AND AJD.SLIP_TYPE_CD        = 'PAY'
        AND AJD.JOB_CATEGORY_CD     = CASE P_WAGE_TYPE
                                        WHEN 'P1' THEN 'PAY01'  -- �޿�.
                                        WHEN 'P2' THEN 'PAY02'  -- ��.
                                        WHEN 'P3' THEN 'PAY02'  -- ������.
                                        WHEN 'P5' THEN 'PAY05'  -- Ư����.
                                      END
        AND AJM.ENABLED_FLAG        = 'Y'
        AND AJD.ENABLED_FLAG        = 'Y'
      ORDER BY AJD.AUTO_JOURNAL_SEQ  
      ;
  END SELECT_PAYMENT_SUM;

-- �޻� �ڷ� ��ǥ ����.
  PROCEDURE SET_PAYMENT_SLIP
            ( P_CORP_ID           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
            , P_PAY_YYYYMM        IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE         IN HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , P_SOB_ID            IN HRP_MONTH_PAYMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRP_MONTH_PAYMENT.ORG_ID%TYPE
            , P_CONNECT_PERSON_ID IN NUMBER
            , P_USER_ID           IN NUMBER
            , O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            )
  AS
    V_SYSDATE          DATE := GET_LOCAL_DATE(P_SOB_ID);
    V_RECORD_COUNT     NUMBER := 0;
    V_MODULE_TYPE      VARCHAR2(10) := 'PAY';
    V_HEADER_ID        NUMBER;
    V_SLIP_NUM         VARCHAR2(30);
    V_STATUS           VARCHAR2(4);
    V_MESSAGE          VARCHAR2(300);      
    V_SLIP_DATE        DATE := LAST_DAY(TO_DATE(P_PAY_YYYYMM, 'YYYY-MM'));
    V_DEPT_CODE        VARCHAR2(20);  -- ���Ǻμ��ڵ�.
    V_CURRENCY_CODE    VARCHAR2(10);
  BEGIN
    O_STATUS := 'F';
    BEGIN
      IF P_WAGE_TYPE = 'P3' THEN
        -- ������.
        SELECT MAX(MP.SUPPLY_DATE) AS SLIP_DATE
            , COUNT(MP.PAY_YYYYMM) AS RECORD_COUNT
          INTO V_SLIP_DATE
            , V_RECORD_COUNT
          FROM HRM_PERSON_MASTER PM
            , HRP_MONTH_PAYMENT MP
        WHERE PM.PERSON_ID          = MP.PERSON_ID
          AND MP.PAY_YYYYMM         = P_PAY_YYYYMM
          AND MP.WAGE_TYPE          = P_WAGE_TYPE  -- �޿�.
          AND MP.CORP_ID            = P_CORP_ID
          AND MP.SOB_ID             = P_SOB_ID
          AND MP.ORG_ID             = P_ORG_ID
          AND NVL(MP.INTERFACE_YN, 'N')       = 'N'
          -- �ߵ� ����� ���� ���� �Ǵ�.
        ;
      ELSE
        -- �Ϲ� �޻�.
        SELECT COUNT(MP.PAY_YYYYMM) AS RECORD_COUNT
          INTO V_RECORD_COUNT
          FROM HRM_PERSON_MASTER PM
            , HRP_MONTH_PAYMENT MP
        WHERE PM.PERSON_ID          = MP.PERSON_ID
          AND MP.PAY_YYYYMM         = P_PAY_YYYYMM
          AND MP.WAGE_TYPE          = P_WAGE_TYPE  -- �޿�.
          AND MP.CORP_ID            = P_CORP_ID
          AND MP.SOB_ID             = P_SOB_ID
          AND MP.ORG_ID             = P_ORG_ID
          AND NVL(MP.INTERFACE_YN, 'N')       = 'N'
          -- �ߵ� ����� ���� ���� �Ǵ�.
        ;
      END IF;
    EXCEPTION WHEN OTHERS THEN
      V_RECORD_COUNT := 0;
    END;
    IF V_RECORD_COUNT = 0 THEN
      O_STATUS := 'F';
      O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10381', NULL);
      RETURN;
    END IF;
    
    -- �����ڵ� �̵���� ����.
    V_RECORD_COUNT := 0;
    V_RECORD_COUNT := CC_NONREGISTERED_COUNT_F
                        ( P_CORP_ID           => P_CORP_ID
                        , P_PAY_YYYYMM        => P_PAY_YYYYMM
                        , P_WAGE_TYPE         => P_WAGE_TYPE
                        , P_SOB_ID            => P_SOB_ID
                        , P_ORG_ID            => P_ORG_ID
                        );                       
    IF V_RECORD_COUNT > 0 THEN
      O_STATUS := 'F';
      O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'CST_10008', NULL);
      RETURN;
    END IF;
    
    -- �⺻������ ��ȸ.
    BEGIN
      SELECT FDM.DEPT_CODE
        INTO V_DEPT_CODE
        FROM HRM_PERSON_MASTER PM
          , HRM_DEPT_MAPPING DM
          , FI_DEPT_MASTER FDM
      WHERE PM.DEPT_ID          = DM.HR_DEPT_ID
        AND DM.M_DEPT_ID        = FDM.DEPT_ID
        AND DM.MODULE_TYPE      = 'FCM'
        AND PM.PERSON_ID        = P_CONNECT_PERSON_ID
        AND PM.SOB_ID           = P_SOB_ID
        AND PM.ORG_ID           = P_ORG_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_DEPT_CODE := NULL;
    END;
    IF V_DEPT_CODE IS NULL THEN
      O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10183', NULL);
      RETURN;
    END IF;
    V_CURRENCY_CODE := FI_ACCOUNT_BOOK_G.BASE_CURRENCY_F(P_SOB_ID);
    
---------------------------------------------------------------------------------------------------    
    -- �ӽ����̺� �����ڷ� ����.
    FI_SLIP_AUTO_INTERFACE_G.DELETE_SLIP_AUTO_INTERFACE;
      
    -- �޿�(��), �޿�(��), ��󿬱����ߺ� - ��ǥ ���� ���� ����.
    FOR C1 IN ( SELECT AJM.SLIP_TYPE_CD
                     , AJM.JOB_CATEGORY_CD
                     , P_SOB_ID AS SOB_ID
                     , P_ORG_ID AS ORG_ID
                     , P_PAY_YYYYMM || ' ' || AJM.SLIP_REMARKS AS HEADER_REMARK
                     , AJD.AUTO_JOURNAL_SEQ
                     , AJD.ACCOUNT_CONTROL_ID
                     , AJD.ACCOUNT_CODE
                     , AC.ACCOUNT_DESC
                     , AJD.ACCOUNT_DR_CR
                     , FI_COMMON_G.CODE_NAME_F('ACCOUNT_DR_CR', AJD.ACCOUNT_DR_CR, AJD.SOB_ID) AS ACCOUNT_DR_CR_DESC
                     , NVL(PAY_AL.AMOUNT, 0) AS GL_AMOUNT
                     , PAY_AL.VENDOR_CODE
                     , FI_COMMON_G.SUPP_CUST_CODE_NAME_F(PAY_AL.VENDOR_CODE, P_SOB_ID) AS VENDOR_NAME
                     , V_DEPT_CODE AS DEPT_CODE
                     , HRM_PERSON_MASTER_G.PERSON_NUMBER_F(P_CONNECT_PERSON_ID) AS PERSON_NUM
                     , PAY_AL.CC_CODE
                     , AJD.SLIP_REMARKS AS LINE_REMARK
                  FROM FI_AUTO_JOURNAL_MST AJM
                    , FI_AUTO_JOURNAL_DET AJD
                    , FI_ACCOUNT_CONTROL AC
                    , ( -- ����.
                        SELECT PM.SOB_ID
                             , PM.ORG_ID
                             , CASE 
                                 WHEN P_WAGE_TYPE = 'P1' THEN 
                                   CASE
                                     WHEN PM.DIR_INDIR_TYPE = '10' THEN '5200100'  -- �޿��ǰ�.
                                     WHEN PM.DIR_INDIR_TYPE IN('20', '30') THEN '5120100'  -- �޿�����.
                                     WHEN PM.DIR_INDIR_TYPE = '40' THEN '5131501'  -- �޿���󿬱����ߺ�.
                                   END 
                                 WHEN P_WAGE_TYPE IN ('P2', 'P3', 'P5') THEN 
                                   CASE
                                     WHEN PM.DIR_INDIR_TYPE = '10' THEN '5200200'  -- ���ǰ�.
                                     WHEN PM.DIR_INDIR_TYPE IN('20', '30') THEN '5120200'  -- ������.
                                     WHEN PM.DIR_INDIR_TYPE = '40' THEN '5131501'  -- �޿���󿬱����ߺ�.
                                   END
                               END AS ACCOUNT_CODE
                             , 'S000632' AS VENDOR_CODE
                             , SUM(MA.ALLOWANCE_AMOUNT) AS AMOUNT
                             , CC.COST_CENTER_CODE AS CC_CODE
                          FROM HRM_PERSON_MASTER PM
                            , HRP_MONTH_PAYMENT MP
                            , HRP_MONTH_ALLOWANCE MA
                            , CST_COST_CENTER CC
                        WHERE PM.PERSON_ID          = MP.PERSON_ID
                          AND MP.MONTH_PAYMENT_ID   = MA.MONTH_PAYMENT_ID
                          AND MP.PERSON_ID          = MA.PERSON_ID
                          AND PM.COST_CENTER_ID     = CC.COST_CENTER_ID
                          AND MP.PAY_YYYYMM         = P_PAY_YYYYMM
                          AND MP.WAGE_TYPE          = P_WAGE_TYPE  -- �޿�.
                          AND MP.CORP_ID            = P_CORP_ID
                          AND MP.SOB_ID             = P_SOB_ID
                          AND MP.ORG_ID             = P_ORG_ID
                          AND NVL(MP.INTERFACE_YN, 'N')       = 'N'
                          -- �ߵ� ����� ���� ���� �Ǵ�.
                        GROUP BY MP.PAY_YYYYMM
                             , MP.WAGE_TYPE
                             , PM.SOB_ID
                             , PM.ORG_ID
                             , CASE 
                                 WHEN P_WAGE_TYPE = 'P1' THEN 
                                   CASE
                                     WHEN PM.DIR_INDIR_TYPE = '10' THEN '5200100'  -- �޿��ǰ�.
                                     WHEN PM.DIR_INDIR_TYPE IN('20', '30') THEN '5120100'  -- �޿�����.
                                     WHEN PM.DIR_INDIR_TYPE = '40' THEN '5131501'  -- �޿���󿬱����ߺ�.
                                   END 
                                 WHEN P_WAGE_TYPE IN ('P2', 'P3', 'P5') THEN 
                                   CASE
                                     WHEN PM.DIR_INDIR_TYPE = '10' THEN '5200200'  -- ���ǰ�.
                                     WHEN PM.DIR_INDIR_TYPE IN('20', '30') THEN '5120200'  -- ������.
                                     WHEN PM.DIR_INDIR_TYPE = '40' THEN '5131501'  -- �޿���󿬱����ߺ�.
                                   END
                               END
                             , CC.COST_CENTER_CODE
                        -- 2011-10 ����ó��.(�������� => ���޿��� (-) ó����.
                        UNION ALL
                        SELECT PM.SOB_ID
                             , PM.ORG_ID
                             , CASE 
                                 WHEN P_WAGE_TYPE = 'P1' THEN 
                                   CASE
                                     WHEN PM.DIR_INDIR_TYPE = '10' THEN '5200100'  -- �޿��ǰ�.
                                     WHEN PM.DIR_INDIR_TYPE IN('20', '30') THEN '5120100'  -- �޿�����.
                                     WHEN PM.DIR_INDIR_TYPE = '40' THEN '5131501'  -- �޿���󿬱����ߺ�.
                                   END 
                                 WHEN P_WAGE_TYPE IN ('P2', 'P3', 'P5') THEN 
                                   CASE
                                     WHEN PM.DIR_INDIR_TYPE = '10' THEN '5200200'  -- ���ǰ�.
                                     WHEN PM.DIR_INDIR_TYPE IN('20', '30') THEN '5120200'  -- ������.
                                     WHEN PM.DIR_INDIR_TYPE = '40' THEN '5131501'  -- �޿���󿬱����ߺ�.
                                   END
                               END AS ACCOUNT_CODE
                             , 'S000632' AS VENDOR_CODE  -- ������.
                             , SUM(MD.DEDUCTION_AMOUNT) * -1 AS AMOUNT
                             , CC.COST_CENTER_CODE AS CC_CODE
                          FROM HRM_PERSON_MASTER PM
                            , HRP_MONTH_PAYMENT MP
                            , HRP_MONTH_DEDUCTION MD
                            , HRM_DEDUCTION_V HD
                            , CST_COST_CENTER CC
                        WHERE PM.PERSON_ID          = MP.PERSON_ID
                          AND MP.MONTH_PAYMENT_ID   = MD.MONTH_PAYMENT_ID
                          AND MP.PERSON_ID          = MD.PERSON_ID
                          AND MD.DEDUCTION_ID       = HD.DEDUCTION_ID
                          AND PM.COST_CENTER_ID     = CC.COST_CENTER_ID
                          AND MP.PAY_YYYYMM         = P_PAY_YYYYMM
                          AND MP.WAGE_TYPE          = P_WAGE_TYPE  -- �޿�.
                          AND MP.CORP_ID            = P_CORP_ID
                          AND MP.SOB_ID             = P_SOB_ID
                          AND MP.ORG_ID             = P_ORG_ID
                          AND HD.DEDUCTION_CODE     IN('D14')
                          AND (MP.PAY_YYYYMM        = '2012-02'
                          AND PM.PERSON_NUM         NOT IN('B11002', 'B10113', 'B12002', 'B10114'))
                          -- �ߵ� ����� ���� ���� �Ǵ�.
                        GROUP BY MP.PAY_YYYYMM
                             , MP.WAGE_TYPE
                             , PM.SOB_ID
                             , PM.ORG_ID
                             , CASE 
                                 WHEN P_WAGE_TYPE = 'P1' THEN 
                                   CASE
                                     WHEN PM.DIR_INDIR_TYPE = '10' THEN '5200100'  -- �޿��ǰ�.
                                     WHEN PM.DIR_INDIR_TYPE IN('20', '30') THEN '5120100'  -- �޿�����.
                                     WHEN PM.DIR_INDIR_TYPE = '40' THEN '5131501'  -- �޿���󿬱����ߺ�.
                                   END 
                                 WHEN P_WAGE_TYPE IN ('P2', 'P3', 'P5') THEN 
                                   CASE
                                     WHEN PM.DIR_INDIR_TYPE = '10' THEN '5200200'  -- ���ǰ�.
                                     WHEN PM.DIR_INDIR_TYPE IN('20', '30') THEN '5120200'  -- ������.
                                     WHEN PM.DIR_INDIR_TYPE = '40' THEN '5131501'  -- �޿���󿬱����ߺ�.
                                   END
                               END
                             , CC.COST_CENTER_CODE
                        UNION ALL
                        -- �Ǻ���.
                        SELECT PM.SOB_ID
                             , PM.ORG_ID
                             , CASE 
                                 WHEN P_WAGE_TYPE = 'P1' THEN 
                                   CASE
                                     WHEN PM.DIR_INDIR_TYPE IN('20', '30') THEN '5130401'  -- �޿�����.
                                     WHEN PM.DIR_INDIR_TYPE = '40' THEN '5200401'  -- ������.
                                   END 
                                 WHEN P_WAGE_TYPE IN ('P2', 'P3', 'P5') THEN 
                                   CASE
                                     WHEN PM.DIR_INDIR_TYPE IN('20', '30') THEN '5130401'  -- �޿�����.
                                     WHEN PM.DIR_INDIR_TYPE = '40' THEN '5200401'  -- ������.
                                   END
                               END AS ACCOUNT_CODE
                             , 'S000632' AS VENDOR_CODE                            -- ������.
                             , SUM(MD.DEDUCTION_AMOUNT) * -1 AS AMOUNT
                             , CC.COST_CENTER_CODE AS CC_CODE
                          FROM HRM_PERSON_MASTER PM
                            , HRP_MONTH_PAYMENT MP
                            , HRP_MONTH_DEDUCTION MD
                            , HRM_DEDUCTION_V HD
                            , CST_COST_CENTER CC
                        WHERE PM.PERSON_ID          = MP.PERSON_ID
                          AND MP.MONTH_PAYMENT_ID   = MD.MONTH_PAYMENT_ID
                          AND MP.PERSON_ID          = MD.PERSON_ID
                          AND MD.DEDUCTION_ID       = HD.DEDUCTION_ID
                          AND PM.COST_CENTER_ID     = CC.COST_CENTER_ID
                          AND MP.PAY_YYYYMM         = P_PAY_YYYYMM
                          AND MP.WAGE_TYPE          = P_WAGE_TYPE  -- �޿�.
                          AND MP.CORP_ID            = P_CORP_ID
                          AND MP.SOB_ID             = P_SOB_ID
                          AND MP.ORG_ID             = P_ORG_ID
                          AND HD.DEDUCTION_CODE     IN ('D11')
                          -- �ߵ� ����� ���� ���� �Ǵ�.
                        GROUP BY MP.PAY_YYYYMM
                             , MP.WAGE_TYPE
                             , PM.SOB_ID
                             , PM.ORG_ID
                             , CASE 
                                 WHEN P_WAGE_TYPE = 'P1' THEN 
                                   CASE
                                     WHEN PM.DIR_INDIR_TYPE IN('20', '30') THEN '5130401'  -- �޿�����.
                                     WHEN PM.DIR_INDIR_TYPE = '40' THEN '5200401'  -- ������.
                                   END 
                                 WHEN P_WAGE_TYPE IN ('P2', 'P3', 'P5') THEN 
                                   CASE
                                     WHEN PM.DIR_INDIR_TYPE IN('20', '30') THEN '5130401'  -- �޿�����.
                                     WHEN PM.DIR_INDIR_TYPE = '40' THEN '5200401'  -- ������.
                                   END
                               END
                             , CC.COST_CENTER_CODE
                        UNION ALL
                        -- ����ó��<��Ÿ���� => ����������� ó��.> : 
                        SELECT PM.SOB_ID
                             , PM.ORG_ID
                             , '5131701' AS ACCOUNT_CODE
                             , 'S000632' AS VENDOR_CODE  -- ������.
                             , SUM(MD.DEDUCTION_AMOUNT) * -1 AS AMOUNT
                             , CC.COST_CENTER_CODE
                          FROM HRM_PERSON_MASTER PM
                            , HRP_MONTH_PAYMENT MP
                            , HRP_MONTH_DEDUCTION MD
                            , HRM_DEDUCTION_V HD
                            , CST_COST_CENTER CC
                        WHERE PM.PERSON_ID          = MP.PERSON_ID
                          AND MP.MONTH_PAYMENT_ID   = MD.MONTH_PAYMENT_ID
                          AND MP.PERSON_ID          = MD.PERSON_ID
                          AND MD.DEDUCTION_ID       = HD.DEDUCTION_ID
                          AND MP.COST_CENTER_ID     = CC.COST_CENTER_ID(+)
                          AND MP.PAY_YYYYMM         = P_PAY_YYYYMM
                          AND MP.PAY_YYYYMM         = '2012-06'
                          --AND PM.PERSON_NUM         IN('B03066', 'B10039', 'B11105')  -- ������, �����, ����� : ����������� ó��.
                          AND MP.WAGE_TYPE          = P_WAGE_TYPE  -- �޿�.
                          AND MP.CORP_ID            = P_CORP_ID
                          AND MP.SOB_ID             = P_SOB_ID
                          AND MP.ORG_ID             = P_ORG_ID
                          AND HD.DEDUCTION_CODE     = 'D14'
                          -- �ߵ� ����� ���� ���� �Ǵ�.
                        GROUP BY MP.PAY_YYYYMM
                             , MP.WAGE_TYPE
                             , PM.SOB_ID
                             , PM.ORG_ID
                             , CC.COST_CENTER_CODE
                      ) PAY_AL
                WHERE AJM.SOB_ID              = AJD.SOB_ID
                  AND AJM.SLIP_TYPE_CD        = AJD.SLIP_TYPE_CD
                  AND AJM.JOB_CATEGORY_CD     = AJD.JOB_CATEGORY_CD
                  AND AJD.ACCOUNT_CONTROL_ID  = AC.ACCOUNT_CONTROL_ID
                  AND AJD.SOB_ID              = AC.SOB_ID
                  AND AC.ACCOUNT_CODE         = PAY_AL.ACCOUNT_CODE(+)
                  AND AC.SOB_ID               = PAY_AL.SOB_ID(+)
                  AND AJD.SOB_ID              = P_SOB_ID
                  AND AJD.SLIP_TYPE_CD        = V_MODULE_TYPE
                  AND AJD.JOB_CATEGORY_CD     = CASE P_WAGE_TYPE
                                                  WHEN 'P1' THEN 'PAY01'  -- �޿�.
                                                  WHEN 'P2' THEN 'PAY02'  -- ��.
                                                  WHEN 'P3' THEN 'PAY02'  -- ������.
                                                  WHEN 'P5' THEN 'PAY05'  -- Ư����.
                                                END
                  AND AJM.ENABLED_FLAG        = 'Y'
                  AND AJD.ENABLED_FLAG        = 'Y'
                ORDER BY AJD.AUTO_JOURNAL_SEQ  
                )
    LOOP
      IF NVL(C1.GL_AMOUNT, 0) <> 0 THEN
        FI_SLIP_AUTO_INTERFACE_G.INSERT_SLIP_AUTO_INTERFACE
          ( P_MODULE_TYPE         => V_MODULE_TYPE
          , P_SLIP_DATE           => V_SLIP_DATE
          , P_SOB_ID              => C1.SOB_ID
          , P_ORG_ID              => C1.ORG_ID
          , P_DEPT_ID             => NULL
          , P_PERSON_ID           => P_CONNECT_PERSON_ID
          , P_BUDGET_DEPT_ID      => NULL
          , P_HEADER_REMARK       => C1.HEADER_REMARK
          , P_ACCOUNT_CODE        => C1.ACCOUNT_CODE
          , P_ACCOUNT_DR_CR       => C1.ACCOUNT_DR_CR
          , P_GL_AMOUNT           => C1.GL_AMOUNT
          , P_CURRENCY_CODE       => V_CURRENCY_CODE
          , P_EXCHANGE_RATE       => NULL
          , P_GL_CURRENCY_AMOUNT  => NULL
          , P_MANAGEMENT1         => C1.VENDOR_CODE
          , P_MANAGEMENT2         => C1.DEPT_CODE
          , P_REFER1              => C1.PERSON_NUM
          , P_REFER2              => C1.CC_CODE
          , P_REFER3              => NULL
          , P_REFER4              => NULL
          , P_REFER5              => NULL
          , P_REFER6              => NULL
          , P_REFER7              => NULL
          , P_REFER8              => NULL
          , P_REFER9              => NULL
          , P_REFER10             => NULL
          , P_REFER11             => NULL
          , P_REFER12             => NULL
          , P_VOUCH_CODE          => NULL
          , P_REFER_RATE          => NULL
          , P_REFER_AMOUNT        => NULL
          , P_REFER_DATE1         => NULL
          , P_REFER_DATE2         => NULL
          , P_REMARK              => C1.LINE_REMARK
          , P_FUND_CODE           => NULL
          , P_UNIT_PRICE          => NULL
          , P_UOM_CODE            => NULL
          , P_QUANTITY            => NULL
          , P_WEIGHT              => NULL
          , P_USER_ID             => P_USER_ID
          , O_STATUS              => O_STATUS
          , O_MESSAGE             => O_MESSAGE
          );
      END IF;
      IF O_STATUS = 'F' THEN
        ROLLBACK;
        RETURN;
      END IF;
    END LOOP C1;
    
    -- ������/������ - ��ǥ ���� ���� ����.
    FOR C1 IN ( SELECT AJM.SLIP_TYPE_CD
                     , AJM.JOB_CATEGORY_CD
                     , P_SOB_ID AS SOB_ID
                     , P_ORG_ID AS ORG_ID
                     , AJM.SLIP_REMARKS AS HEADER_REMARK
                     , AJD.AUTO_JOURNAL_SEQ
                     , AJD.ACCOUNT_CONTROL_ID
                     , AJD.ACCOUNT_CODE
                     , AC.ACCOUNT_DESC
                     , AJD.ACCOUNT_DR_CR
                     , FI_COMMON_G.CODE_NAME_F('ACCOUNT_DR_CR', AJD.ACCOUNT_DR_CR, AJD.SOB_ID) AS ACCOUNT_DR_CR_DESC
                     , NVL(PAY_AL.AMOUNT, 0) AS GL_AMOUNT
                     , PAY_AL.VENDOR_CODE
                     , FI_COMMON_G.SUPP_CUST_CODE_NAME_F(PAY_AL.VENDOR_CODE, P_SOB_ID) AS VENDOR_NAME
                     , HRM_PERSON_MASTER_G.PERSON_NUMBER_F(P_CONNECT_PERSON_ID) AS PERSON_NUM
                     , AJD.SLIP_REMARKS AS LINE_REMARK
                  FROM FI_AUTO_JOURNAL_MST AJM
                    , FI_AUTO_JOURNAL_DET AJD
                    , FI_ACCOUNT_CONTROL AC
                    , ( -- ������.
                        SELECT PM.SOB_ID
                             , PM.ORG_ID
                             , '2100600' AS ACCOUNT_CODE
                             , CASE 
                                 WHEN HD.DEDUCTION_CODE = 'D01' THEN 'S000194'  -- �ҵ漼(����õ������).
                                 WHEN HD.DEDUCTION_CODE = 'D02' THEN 'S000046'  -- �ֹμ�(����û).
                                 WHEN HD.DEDUCTION_CODE IN('D03', 'D08') THEN 'S000043'  -- ���ο���(���ο��ݰ�������).
                                 WHEN HD.DEDUCTION_CODE = 'D04' THEN 'S000042'  -- ��뺸��(�ٷκ�������).
                                 WHEN HD.DEDUCTION_CODE IN('D05', 'D07') THEN 'S000045'  -- �ǰ�����(�ǰ������������).
                                 WHEN HD.DEDUCTION_CODE IN('D06', 'D09') THEN 'S000045'  -- ��纸��(�ǰ������������).
                               END AS VENDOR_CODE
                             , SUM(MD.DEDUCTION_AMOUNT) AS AMOUNT
                          FROM HRM_PERSON_MASTER PM
                            , HRP_MONTH_PAYMENT MP
                            , HRP_MONTH_DEDUCTION MD
                            , HRM_DEDUCTION_V HD
                        WHERE PM.PERSON_ID          = MP.PERSON_ID
                          AND MP.MONTH_PAYMENT_ID   = MD.MONTH_PAYMENT_ID
                          AND MP.PERSON_ID          = MD.PERSON_ID
                          AND MD.DEDUCTION_ID       = HD.DEDUCTION_ID
                          AND MP.PAY_YYYYMM         = P_PAY_YYYYMM
                          AND MP.WAGE_TYPE          = P_WAGE_TYPE  -- �޿�.
                          AND MP.CORP_ID            = P_CORP_ID
                          AND MP.SOB_ID             = P_SOB_ID
                          AND MP.ORG_ID             = P_ORG_ID
                          AND NVL(MP.INTERFACE_YN, 'N')       = 'N'
                          AND HD.DEDUCTION_CODE     BETWEEN 'D01' AND 'D09'
                          -- �ߵ� ����� ���� ���� �Ǵ�.
                        GROUP BY MP.PAY_YYYYMM
                             , MP.WAGE_TYPE
                             , PM.SOB_ID
                             , PM.ORG_ID
                             , HD.DEDUCTION_CODE
                             , CASE 
                                 WHEN HD.DEDUCTION_CODE = 'D01' THEN 'S000194'  -- �ҵ漼(����õ������).
                                 WHEN HD.DEDUCTION_CODE = 'D02' THEN 'S000046'  -- �ֹμ�(����û).
                                 WHEN HD.DEDUCTION_CODE IN('D03', 'D08') THEN 'S000043'  -- ���ο���(���ο��ݰ�������).
                                 WHEN HD.DEDUCTION_CODE = 'D04' THEN 'S000042'  -- ��뺸��(�ٷκ�������).
                                 WHEN HD.DEDUCTION_CODE IN('D05', 'D07') THEN 'S000045'  -- �ǰ�����(�ǰ������������).
                                 WHEN HD.DEDUCTION_CODE IN('D06', 'D09') THEN 'S000045'  -- ��纸��(�ǰ������������).
                               END
                        UNION ALL
                        -- ��Ÿ(�ҵ漼/���� �ֹμ�/���������) ������.
                        SELECT PM.SOB_ID
                             , PM.ORG_ID
                             , '2100600' AS ACCOUNT_CODE
                             , CASE 
                                 WHEN HD.DEDUCTION_CODE = 'D15' THEN 'S000194'  -- �ҵ漼(����õ������).
                                 WHEN HD.DEDUCTION_CODE = 'D16' THEN 'S000046'  -- �ֹμ�(����û).
                                 WHEN HD.DEDUCTION_CODE = 'D21' THEN 'S001815'  -- ���ﺸ������(��).
                               END AS VENDOR_CODE
                             , SUM(MD.DEDUCTION_AMOUNT) AS AMOUNT
                          FROM HRM_PERSON_MASTER PM
                            , HRP_MONTH_PAYMENT MP
                            , HRP_MONTH_DEDUCTION MD
                            , HRM_DEDUCTION_V HD
                        WHERE PM.PERSON_ID          = MP.PERSON_ID
                          AND MP.MONTH_PAYMENT_ID   = MD.MONTH_PAYMENT_ID
                          AND MP.PERSON_ID          = MD.PERSON_ID
                          AND MD.DEDUCTION_ID       = HD.DEDUCTION_ID
                          AND MP.PAY_YYYYMM         = P_PAY_YYYYMM
                          AND MP.WAGE_TYPE          = P_WAGE_TYPE  -- �޿�.
                          AND MP.CORP_ID            = P_CORP_ID
                          AND MP.SOB_ID             = P_SOB_ID
                          AND MP.ORG_ID             = P_ORG_ID
                          AND HD.DEDUCTION_CODE     IN('D15', 'D16', 'D21')
                          -- �ߵ� ����� ���� ���� �Ǵ�.
                        GROUP BY MP.PAY_YYYYMM
                             , MP.WAGE_TYPE
                             , PM.SOB_ID
                             , PM.ORG_ID
                             , HD.DEDUCTION_CODE
                             , CASE 
                                 WHEN HD.DEDUCTION_CODE = 'D15' THEN 'S000194'  -- �ҵ漼(����õ������).
                                 WHEN HD.DEDUCTION_CODE = 'D16' THEN 'S000046'  -- �ֹμ�(����û).
                                 WHEN HD.DEDUCTION_CODE = 'D21' THEN 'S001815'  -- ���ﺸ������(��).
                               END
                        UNION ALL
                        -- ������.
                        SELECT PM.SOB_ID
                             , PM.ORG_ID
                             , '2101500' AS ACCOUNT_CODE
                             , 'S000632' AS VENDOR_CODE
                             , SUM(MD.DEDUCTION_AMOUNT) AS AMOUNT
                          FROM HRM_PERSON_MASTER PM
                            , HRP_MONTH_PAYMENT MP
                            , HRP_MONTH_DEDUCTION MD
                            , HRM_DEDUCTION_V HD
                        WHERE PM.PERSON_ID          = MP.PERSON_ID
                          AND MP.MONTH_PAYMENT_ID   = MD.MONTH_PAYMENT_ID
                          AND MP.PERSON_ID          = MD.PERSON_ID
                          AND MD.DEDUCTION_ID       = HD.DEDUCTION_ID
                          AND MP.PAY_YYYYMM         = P_PAY_YYYYMM
                          AND MP.WAGE_TYPE          = P_WAGE_TYPE  -- �޿�.
                          AND MP.CORP_ID            = P_CORP_ID
                          AND MP.SOB_ID             = P_SOB_ID
                          AND MP.ORG_ID             = P_ORG_ID
                          AND HD.DEDUCTION_CODE     IN('D12')
                          -- �ߵ� ����� ���� ���� �Ǵ�.
                        GROUP BY MP.PAY_YYYYMM
                             , MP.WAGE_TYPE
                             , PM.SOB_ID
                             , PM.ORG_ID
                        UNION ALL
                        -- ������ : ����ó��<�ڹμ�> : ��Ÿ���� -> �ǰ������ ���� 
                        SELECT PM.SOB_ID
                             , PM.ORG_ID
                             , '2100600' AS ACCOUNT_CODE
                             , 'S000045' AS VENDOR_CODE  -- �ǰ�����(�ǰ������������).
                             , SUM(MD.DEDUCTION_AMOUNT) AS AMOUNT
                          FROM HRM_PERSON_MASTER PM
                            , HRP_MONTH_PAYMENT MP
                            , HRP_MONTH_DEDUCTION MD
                            , HRM_DEDUCTION_V HD
                        WHERE PM.PERSON_ID          = MP.PERSON_ID
                          AND MP.MONTH_PAYMENT_ID   = MD.MONTH_PAYMENT_ID
                          AND MP.PERSON_ID          = MD.PERSON_ID
                          AND MD.DEDUCTION_ID       = HD.DEDUCTION_ID
                          AND MP.PAY_YYYYMM         = P_PAY_YYYYMM
                          AND MP.PAY_YYYYMM         = '2012-02'
                          AND PM.PERSON_NUM         = 'B11002'  -- �ڹμ�.
                          AND MP.WAGE_TYPE          = P_WAGE_TYPE  -- �޿�.
                          AND MP.CORP_ID            = P_CORP_ID
                          AND MP.SOB_ID             = P_SOB_ID
                          AND MP.ORG_ID             = P_ORG_ID
                          AND HD.DEDUCTION_CODE     = 'D14'
                          -- �ߵ� ����� ���� ���� �Ǵ�.
                        GROUP BY MP.PAY_YYYYMM
                             , MP.WAGE_TYPE
                             , PM.SOB_ID
                             , PM.ORG_ID
                        UNION ALL
                        -- �����޺�� : ��Ÿ���� -> �����޺�� 
                        SELECT PM.SOB_ID
                             , PM.ORG_ID
                             , '2100500' AS ACCOUNT_CODE
                             , 'S001571' AS VENDOR_CODE  -- �ܱ��� �ٷ���;
                             , SUM(MD.DEDUCTION_AMOUNT) AS AMOUNT
                          FROM HRM_PERSON_MASTER PM
                            , HRP_MONTH_PAYMENT MP
                            , HRP_MONTH_DEDUCTION MD
                            , HRM_DEDUCTION_V HD
                        WHERE PM.PERSON_ID          = MP.PERSON_ID
                          AND MP.MONTH_PAYMENT_ID   = MD.MONTH_PAYMENT_ID
                          AND MP.PERSON_ID          = MD.PERSON_ID
                          AND MD.DEDUCTION_ID       = HD.DEDUCTION_ID
                          AND MP.PAY_YYYYMM         = P_PAY_YYYYMM
                          AND MP.WAGE_TYPE          = P_WAGE_TYPE  -- �޿�.
                          AND MP.CORP_ID            = P_CORP_ID
                          AND MP.SOB_ID             = P_SOB_ID
                          AND MP.ORG_ID             = P_ORG_ID
                          AND HD.DEDUCTION_CODE     = 'D14'
                          AND 1                     = 2
                          -- �ߵ� ����� ���� ���� �Ǵ�.
                        GROUP BY MP.PAY_YYYYMM
                             , MP.WAGE_TYPE
                             , PM.SOB_ID
                             , PM.ORG_ID
                        UNION ALL
                        -- �����޺�� : ��Ÿ���� -> ���ޱ�.
                        SELECT PM.SOB_ID
                             , PM.ORG_ID
                             , '1111100' AS ACCOUNT_CODE
                             , 'S001571' AS VENDOR_CODE
                             , SUM(MD.DEDUCTION_AMOUNT) AS AMOUNT
                          FROM HRM_PERSON_MASTER PM
                            , HRP_MONTH_PAYMENT MP
                            , HRP_MONTH_DEDUCTION MD
                            , HRM_DEDUCTION_V HD
                        WHERE PM.PERSON_ID          = MP.PERSON_ID
                          AND MP.MONTH_PAYMENT_ID   = MD.MONTH_PAYMENT_ID
                          AND MP.PERSON_ID          = MD.PERSON_ID
                          AND MD.DEDUCTION_ID       = HD.DEDUCTION_ID
                          AND MP.PAY_YYYYMM         = P_PAY_YYYYMM
                          AND MP.WAGE_TYPE          = P_WAGE_TYPE  -- �޿�.
                          AND MP.CORP_ID            = P_CORP_ID
                          AND MP.SOB_ID             = P_SOB_ID
                          AND MP.ORG_ID             = P_ORG_ID
                          AND HD.DEDUCTION_CODE     = 'D14'
                          AND (MP.PAY_YYYYMM        = '2012-05'
                          AND PM.PERSON_NUM         NOT IN('B03066', 'B10039', 'B11105'))  -- ������, �����, ����� : ����������� ó��.
                          -- �ߵ� ����� ���� ���� �Ǵ�.
                        GROUP BY MP.PAY_YYYYMM
                             , MP.WAGE_TYPE
                             , PM.SOB_ID
                             , PM.ORG_ID
                      ) PAY_AL
                WHERE AJM.SOB_ID              = AJD.SOB_ID
                  AND AJM.SLIP_TYPE_CD        = AJD.SLIP_TYPE_CD
                  AND AJM.JOB_CATEGORY_CD     = AJD.JOB_CATEGORY_CD
                  AND AJD.ACCOUNT_CONTROL_ID  = AC.ACCOUNT_CONTROL_ID
                  AND AJD.SOB_ID              = AC.SOB_ID
                  AND AC.ACCOUNT_CODE         = PAY_AL.ACCOUNT_CODE(+)
                  AND AC.SOB_ID               = PAY_AL.SOB_ID(+)
                  AND AJD.SOB_ID              = P_SOB_ID
                  AND AJD.SLIP_TYPE_CD        = V_MODULE_TYPE
                  AND AJD.JOB_CATEGORY_CD     = CASE P_WAGE_TYPE
                                                  WHEN 'P1' THEN 'PAY01'  -- �޿�.
                                                  WHEN 'P2' THEN 'PAY02'  -- ��.
                                                  WHEN 'P3' THEN 'PAY02'  -- ������.
                                                  WHEN 'P5' THEN 'PAY05'  -- Ư����.
                                                END
                  AND AJM.ENABLED_FLAG        = 'Y'
                  AND AJD.ENABLED_FLAG        = 'Y'
                ORDER BY AJD.AUTO_JOURNAL_SEQ  
                )
    LOOP
      IF NVL(C1.GL_AMOUNT, 0) <> 0 THEN
        FI_SLIP_AUTO_INTERFACE_G.INSERT_SLIP_AUTO_INTERFACE
          ( P_MODULE_TYPE         => V_MODULE_TYPE
          , P_SLIP_DATE           => V_SLIP_DATE
          , P_SOB_ID              => C1.SOB_ID
          , P_ORG_ID              => C1.ORG_ID
          , P_DEPT_ID             => NULL
          , P_PERSON_ID           => P_CONNECT_PERSON_ID
          , P_BUDGET_DEPT_ID      => NULL
          , P_HEADER_REMARK       => C1.HEADER_REMARK
          , P_ACCOUNT_CODE        => C1.ACCOUNT_CODE
          , P_ACCOUNT_DR_CR       => C1.ACCOUNT_DR_CR
          , P_GL_AMOUNT           => C1.GL_AMOUNT
          , P_CURRENCY_CODE       => V_CURRENCY_CODE
          , P_EXCHANGE_RATE       => NULL
          , P_GL_CURRENCY_AMOUNT  => NULL
          , P_MANAGEMENT1         => C1.VENDOR_CODE
          , P_MANAGEMENT2         => NULL
          , P_REFER1              => NULL
          , P_REFER2              => NULL
          , P_REFER3              => NULL
          , P_REFER4              => NULL
          , P_REFER5              => NULL
          , P_REFER6              => NULL
          , P_REFER7              => NULL
          , P_REFER8              => NULL
          , P_REFER9              => NULL
          , P_REFER10             => NULL
          , P_REFER11             => NULL
          , P_REFER12             => NULL
          , P_VOUCH_CODE          => NULL
          , P_REFER_RATE          => NULL
          , P_REFER_AMOUNT        => NULL
          , P_REFER_DATE1         => NULL
          , P_REFER_DATE2         => NULL
          , P_REMARK              => C1.LINE_REMARK
          , P_FUND_CODE           => NULL
          , P_UNIT_PRICE          => NULL
          , P_UOM_CODE            => NULL
          , P_QUANTITY            => NULL
          , P_WEIGHT              => NULL
          , P_USER_ID             => P_USER_ID
          , O_STATUS              => O_STATUS
          , O_MESSAGE             => O_MESSAGE
          );
      END IF;
      IF O_STATUS = 'F' THEN
        ROLLBACK;
        RETURN;
      END IF;
    END LOOP C1;
    
    -- ������ - ��ǥ ���� ���� ����.
    FOR C1 IN ( SELECT AJM.SLIP_TYPE_CD
                     , AJM.JOB_CATEGORY_CD
                     , P_SOB_ID AS SOB_ID
                     , P_ORG_ID AS ORG_ID
                     , AJM.SLIP_REMARKS AS HEADER_REMARK
                     , AJD.AUTO_JOURNAL_SEQ
                     , AJD.ACCOUNT_CONTROL_ID
                     , AJD.ACCOUNT_CODE
                     , AC.ACCOUNT_DESC
                     , AJD.ACCOUNT_DR_CR
                     , FI_COMMON_G.CODE_NAME_F('ACCOUNT_DR_CR', AJD.ACCOUNT_DR_CR, AJD.SOB_ID) AS ACCOUNT_DR_CR_DESC
                     , NVL(PAY_AL.AMOUNT, 0) AS GL_AMOUNT
                     , PAY_AL.VENDOR_CODE
                     , FI_COMMON_G.SUPP_CUST_CODE_NAME_F(PAY_AL.VENDOR_CODE, P_SOB_ID) AS VENDOR_NAME
                     , HRM_PERSON_MASTER_G.PERSON_NUMBER_F(P_CONNECT_PERSON_ID) AS PERSON_NUM
                     , AJD.SLIP_REMARKS AS LINE_REMARK
                  FROM FI_AUTO_JOURNAL_MST AJM
                    , FI_AUTO_JOURNAL_DET AJD
                    , FI_ACCOUNT_CONTROL AC
                    , ( -- ������.
                        SELECT PM.SOB_ID
                             , PM.ORG_ID
                             , '1111600' AS ACCOUNT_CODE
                             , 'S001571' AS VENDOR_CODE  -- �ܱ��αٷ���.
                             , SUM(MD.DEDUCTION_AMOUNT) AS AMOUNT
                          FROM HRM_PERSON_MASTER PM
                            , HRP_MONTH_PAYMENT MP
                            , HRP_MONTH_DEDUCTION MD
                            , HRM_DEDUCTION_V HD
                        WHERE PM.PERSON_ID          = MP.PERSON_ID
                          AND MP.MONTH_PAYMENT_ID   = MD.MONTH_PAYMENT_ID
                          AND MP.PERSON_ID          = MD.PERSON_ID
                          AND MD.DEDUCTION_ID       = HD.DEDUCTION_ID
                          AND MP.PAY_YYYYMM         = P_PAY_YYYYMM
                          AND MP.WAGE_TYPE          = P_WAGE_TYPE  -- �޿�.
                          AND MP.CORP_ID            = P_CORP_ID
                          AND MP.SOB_ID             = P_SOB_ID
                          AND MP.ORG_ID             = P_ORG_ID
                          AND HD.DEDUCTION_CODE     = 'D13'
                          -- �ߵ� ����� ���� ���� �Ǵ�.
                        GROUP BY MP.PAY_YYYYMM
                             , MP.WAGE_TYPE
                             , PM.SOB_ID
                             , PM.ORG_ID
                      ) PAY_AL
                WHERE AJM.SOB_ID              = AJD.SOB_ID
                  AND AJM.SLIP_TYPE_CD        = AJD.SLIP_TYPE_CD
                  AND AJM.JOB_CATEGORY_CD     = AJD.JOB_CATEGORY_CD
                  AND AJD.ACCOUNT_CONTROL_ID  = AC.ACCOUNT_CONTROL_ID
                  AND AJD.SOB_ID              = AC.SOB_ID
                  AND AC.ACCOUNT_CODE         = PAY_AL.ACCOUNT_CODE(+)
                  AND AC.SOB_ID               = PAY_AL.SOB_ID(+)
                  AND AJD.SOB_ID              = P_SOB_ID
                  AND AJD.SLIP_TYPE_CD        = V_MODULE_TYPE
                  AND AJD.JOB_CATEGORY_CD     = CASE P_WAGE_TYPE
                                                  WHEN 'P1' THEN 'PAY01'  -- �޿�.
                                                  WHEN 'P2' THEN 'PAY02'  -- ��.
                                                  WHEN 'P5' THEN 'PAY05'  -- Ư����.
                                                END
                  AND AJM.ENABLED_FLAG        = 'Y'
                  AND AJD.ENABLED_FLAG        = 'Y'
                ORDER BY AJD.AUTO_JOURNAL_SEQ  
                )
    LOOP
      IF NVL(C1.GL_AMOUNT, 0) <> 0 THEN
        FI_SLIP_AUTO_INTERFACE_G.INSERT_SLIP_AUTO_INTERFACE
          ( P_MODULE_TYPE         => V_MODULE_TYPE
          , P_SLIP_DATE           => V_SLIP_DATE
          , P_SOB_ID              => C1.SOB_ID
          , P_ORG_ID              => C1.ORG_ID
          , P_DEPT_ID             => NULL
          , P_PERSON_ID           => P_CONNECT_PERSON_ID
          , P_BUDGET_DEPT_ID      => NULL
          , P_HEADER_REMARK       => C1.HEADER_REMARK
          , P_ACCOUNT_CODE        => C1.ACCOUNT_CODE
          , P_ACCOUNT_DR_CR       => C1.ACCOUNT_DR_CR
          , P_GL_AMOUNT           => C1.GL_AMOUNT
          , P_CURRENCY_CODE       => V_CURRENCY_CODE
          , P_EXCHANGE_RATE       => NULL
          , P_GL_CURRENCY_AMOUNT  => NULL
          , P_MANAGEMENT1         => C1.VENDOR_CODE
          , P_MANAGEMENT2         => C1.PERSON_NUM
          , P_REFER1              => NULL
          , P_REFER2              => NULL
          , P_REFER3              => NULL
          , P_REFER4              => NULL
          , P_REFER5              => NULL
          , P_REFER6              => NULL
          , P_REFER7              => NULL
          , P_REFER8              => NULL
          , P_REFER9              => NULL
          , P_REFER10             => NULL
          , P_REFER11             => NULL
          , P_REFER12             => NULL
          , P_VOUCH_CODE          => NULL
          , P_REFER_RATE          => NULL
          , P_REFER_AMOUNT        => NULL
          , P_REFER_DATE1         => NULL
          , P_REFER_DATE2         => NULL
          , P_REMARK              => C1.LINE_REMARK
          , P_FUND_CODE           => NULL
          , P_UNIT_PRICE          => NULL
          , P_UOM_CODE            => NULL
          , P_QUANTITY            => NULL
          , P_WEIGHT              => NULL
          , P_USER_ID             => P_USER_ID
          , O_STATUS              => O_STATUS
          , O_MESSAGE             => O_MESSAGE
          );
      END IF;
      IF O_STATUS = 'F' THEN
        ROLLBACK;
        RETURN;
      END IF;
    END LOOP C1;
    
    -- ��Ÿ������ä - ��ǥ ���� ���� ����.
    FOR C1 IN ( SELECT AJM.SLIP_TYPE_CD
                     , AJM.JOB_CATEGORY_CD
                     , P_SOB_ID AS SOB_ID
                     , P_ORG_ID AS ORG_ID
                     , AJM.SLIP_REMARKS AS HEADER_REMARK
                     , AJD.AUTO_JOURNAL_SEQ
                     , AJD.ACCOUNT_CONTROL_ID
                     , AJD.ACCOUNT_CODE
                     , AC.ACCOUNT_DESC
                     , NVL(PAY_AL.ACCOUNT_DR_CR, AJD.ACCOUNT_DR_CR) AS ACCOUNT_DR_CR
                     , FI_COMMON_G.CODE_NAME_F('ACCOUNT_DR_CR', NVL(PAY_AL.ACCOUNT_DR_CR, AJD.ACCOUNT_DR_CR), AJD.SOB_ID) AS ACCOUNT_DR_CR_DESC
                     , NVL(PAY_AL.AMOUNT, 0) AS GL_AMOUNT
                     , PAY_AL.VENDOR_CODE
                     , FI_COMMON_G.SUPP_CUST_CODE_NAME_F(PAY_AL.VENDOR_CODE, P_SOB_ID) AS VENDOR_NAME
                     , AJD.SLIP_REMARKS AS LINE_REMARK
                  FROM FI_AUTO_JOURNAL_MST AJM
                    , FI_AUTO_JOURNAL_DET AJD
                    , FI_ACCOUNT_CONTROL AC
                    , ( -- �����޾�.
                        SELECT PM.SOB_ID
                             , PM.ORG_ID
                             , NULL AS ACCOUNT_DR_CR
                             , '2101800' AS ACCOUNT_CODE  -- ��Ÿ������ä.
                             , 'S000632' AS VENDOR_CODE
                             , SUM(MP.REAL_AMOUNT) AS AMOUNT
                          FROM HRM_PERSON_MASTER PM
                            , HRP_MONTH_PAYMENT MP
                        WHERE PM.PERSON_ID          = MP.PERSON_ID
                          AND MP.PAY_YYYYMM         = P_PAY_YYYYMM
                          AND MP.WAGE_TYPE          = P_WAGE_TYPE  -- �޿�.
                          AND MP.CORP_ID            = P_CORP_ID
                          AND MP.SOB_ID             = P_SOB_ID
                          AND MP.ORG_ID             = P_ORG_ID
                          AND NVL(MP.INTERFACE_YN, 'N')       = 'N'
                          AND NVL(MP.REAL_AMOUNT, 0) >= 0
                          -- �ߵ� ����� ���� ���� �Ǵ�.
                        GROUP BY MP.PAY_YYYYMM
                             , MP.WAGE_TYPE
                             , PM.SOB_ID
                             , PM.ORG_ID
                        UNION ALL
                        -- �����޾�(-) �ݾ�.
                        SELECT PM.SOB_ID
                             , PM.ORG_ID
                             , '1' AS ACCOUNT_DR_CR
                             , '2101800' AS ACCOUNT_CODE  -- ��Ÿ������ä.
                             , 'S000632' AS VENDOR_CODE
                             , SUM(MP.REAL_AMOUNT) * -1 AS AMOUNT
                          FROM HRM_PERSON_MASTER PM
                            , HRP_MONTH_PAYMENT MP
                        WHERE PM.PERSON_ID          = MP.PERSON_ID
                          AND MP.PAY_YYYYMM         = P_PAY_YYYYMM
                          AND MP.WAGE_TYPE          = P_WAGE_TYPE  -- �޿�.
                          AND MP.CORP_ID            = P_CORP_ID
                          AND MP.SOB_ID             = P_SOB_ID
                          AND MP.ORG_ID             = P_ORG_ID
                          AND NVL(MP.INTERFACE_YN, 'N')       = 'N'
                          AND NVL(MP.REAL_AMOUNT, 0) < 0
                          -- �ߵ� ����� ���� ���� �Ǵ�.
                        GROUP BY MP.PAY_YYYYMM
                             , MP.WAGE_TYPE
                             , PM.SOB_ID
                             , PM.ORG_ID
                      ) PAY_AL
                WHERE AJM.SOB_ID              = AJD.SOB_ID
                  AND AJM.SLIP_TYPE_CD        = AJD.SLIP_TYPE_CD
                  AND AJM.JOB_CATEGORY_CD     = AJD.JOB_CATEGORY_CD
                  AND AJD.ACCOUNT_CONTROL_ID  = AC.ACCOUNT_CONTROL_ID
                  AND AJD.SOB_ID              = AC.SOB_ID
                  AND AC.ACCOUNT_CODE         = PAY_AL.ACCOUNT_CODE(+)
                  AND AC.SOB_ID               = PAY_AL.SOB_ID(+)
                  AND AJD.SOB_ID              = P_SOB_ID
                  AND AJD.SLIP_TYPE_CD        = V_MODULE_TYPE
                  AND AJD.JOB_CATEGORY_CD     = CASE P_WAGE_TYPE
                                                  WHEN 'P1' THEN 'PAY01'  -- �޿�.
                                                  WHEN 'P2' THEN 'PAY02'  -- ��.
                                                  WHEN 'P3' THEN 'PAY02'  -- ��.
                                                  WHEN 'P5' THEN 'PAY05'  -- Ư����.
                                                END
                  AND AJM.ENABLED_FLAG        = 'Y'
                  AND AJD.ENABLED_FLAG        = 'Y'
                ORDER BY AJD.AUTO_JOURNAL_SEQ  
                )
    LOOP
      IF NVL(C1.GL_AMOUNT, 0) <> 0 THEN
        FI_SLIP_AUTO_INTERFACE_G.INSERT_SLIP_AUTO_INTERFACE
          ( P_MODULE_TYPE         => V_MODULE_TYPE
          , P_SLIP_DATE           => V_SLIP_DATE
          , P_SOB_ID              => C1.SOB_ID
          , P_ORG_ID              => C1.ORG_ID
          , P_DEPT_ID             => NULL
          , P_PERSON_ID           => P_CONNECT_PERSON_ID
          , P_BUDGET_DEPT_ID      => NULL
          , P_HEADER_REMARK       => C1.HEADER_REMARK
          , P_ACCOUNT_CODE        => C1.ACCOUNT_CODE
          , P_ACCOUNT_DR_CR       => C1.ACCOUNT_DR_CR
          , P_GL_AMOUNT           => C1.GL_AMOUNT
          , P_CURRENCY_CODE       => V_CURRENCY_CODE
          , P_EXCHANGE_RATE       => NULL
          , P_GL_CURRENCY_AMOUNT  => NULL
          , P_MANAGEMENT1         => C1.VENDOR_CODE
          , P_MANAGEMENT2         => NULL
          , P_REFER1              => NULL
          , P_REFER2              => NULL
          , P_REFER3              => NULL
          , P_REFER4              => NULL
          , P_REFER5              => NULL
          , P_REFER6              => NULL
          , P_REFER7              => NULL
          , P_REFER8              => NULL
          , P_REFER9              => NULL
          , P_REFER10             => NULL
          , P_REFER11             => NULL
          , P_REFER12             => NULL
          , P_VOUCH_CODE          => NULL
          , P_REFER_RATE          => NULL
          , P_REFER_AMOUNT        => NULL
          , P_REFER_DATE1         => NULL
          , P_REFER_DATE2         => NULL
          , P_REMARK              => C1.LINE_REMARK
          , P_FUND_CODE           => NULL
          , P_UNIT_PRICE          => NULL
          , P_UOM_CODE            => NULL
          , P_QUANTITY            => NULL
          , P_WEIGHT              => NULL
          , P_USER_ID             => P_USER_ID
          , O_STATUS              => O_STATUS
          , O_MESSAGE             => O_MESSAGE
          );
      END IF;
      IF O_STATUS = 'F' THEN
        ROLLBACK;
        RETURN;
      END IF;
    END LOOP C1;
    
    -- ���� ��ǥ ����.
    FI_SLIP_AUTO_INTERFACE_G.SET_SLIP_AUTO_INTERFACE
      ( P_MODULE_TYPE         => V_MODULE_TYPE
      , P_SLIP_DATE           => V_SLIP_DATE
      , P_SOB_ID              => P_SOB_ID
      , P_ORG_ID              => P_ORG_ID
      , P_USER_ID             => P_USER_ID
      , O_HEADER_ID           => V_HEADER_ID
      , O_SLIP_NUM            => V_SLIP_NUM
      , O_STATUS              => V_STATUS
      , O_MESSAGE             => V_MESSAGE
      );
    IF V_STATUS = 'F' THEN
      O_STATUS := V_STATUS;
      O_MESSAGE := V_MESSAGE;
      RETURN;  
    END IF;
    
    -- �޿������� ��ǥ���� UPDATE.
    BEGIN
      UPDATE HRP_MONTH_PAYMENT MP
        SET MP.INTERFACE_YN = 'Y'
          , MP.INTERFACE_HEADER_ID = V_HEADER_ID
          , MP.INTERFACE_NUM = V_SLIP_NUM
          , MP.INTERFACE_PERSON_ID = P_CONNECT_PERSON_ID
          , MP.INTERFACE_DATE = V_SYSDATE
      WHERE MP.PAY_YYYYMM         = P_PAY_YYYYMM
        AND MP.WAGE_TYPE          = P_WAGE_TYPE  -- �޿�.
        AND MP.CORP_ID            = P_CORP_ID
        AND MP.SOB_ID             = P_SOB_ID
        AND MP.ORG_ID             = P_ORG_ID
        AND NVL(MP.INTERFACE_YN, 'N')       = 'N'
      ;
    EXCEPTION WHEN OTHERS THEN
      O_STATUS := 'F';
      O_MESSAGE := SUBSTR(SQLERRM, 1, 200);
      RETURN;
    END;
    O_STATUS := 'S';
    O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10334');
  END SET_PAYMENT_SLIP;

-- �޻� �ڷ� ��ǥ ���.
  PROCEDURE CANCEL_PAYMENT_SLIP
            ( P_CORP_ID           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
            , P_PAY_YYYYMM        IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE         IN HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , P_SOB_ID            IN HRP_MONTH_PAYMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRP_MONTH_PAYMENT.ORG_ID%TYPE
            , P_CONNECT_PERSON_ID IN NUMBER
            , P_USER_ID           IN NUMBER
            , O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            )
  AS
    V_SYSDATE                     DATE := GET_LOCAL_DATE(P_SOB_ID);
    V_HEADER_ID                   NUMBER;
    V_SLIP_NUM                    VARCHAR2(30);
  BEGIN
    O_STATUS := 'F';
    BEGIN
      SELECT DISTINCT MP.INTERFACE_HEADER_ID
           , MP.INTERFACE_NUM
        INTO V_HEADER_ID, V_SLIP_NUM
        FROM HRP_MONTH_PAYMENT MP
      WHERE MP.PAY_YYYYMM         = P_PAY_YYYYMM
        AND MP.WAGE_TYPE          = P_WAGE_TYPE  -- �޿�.
        AND MP.CORP_ID            = P_CORP_ID
        AND MP.SOB_ID             = P_SOB_ID
        AND MP.ORG_ID             = P_ORG_ID
        AND NVL(MP.INTERFACE_YN, 'N')       = 'Y'
      ;
    EXCEPTION WHEN OTHERS THEN
      O_MESSAGE := '[' || V_SLIP_NUM || '] - ' || EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_F, 'FCM_10128');
      RETURN;
    END;
    
    -- ��ǥ ����.
    FI_SLIP_AUTO_INTERFACE_G.DELETE_SLIP_INTERFACE
      ( W_HEADER_ID           => V_HEADER_ID
      , O_STATUS              => O_STATUS
      , O_MESSAGE             => O_MESSAGE
      );
    IF O_STATUS = 'F' THEN
       RETURN;  
    END IF;
    
    UPDATE HRP_MONTH_PAYMENT MP
      SET MP.INTERFACE_YN = 'N'
        , MP.INTERFACE_HEADER_ID = NULL
        , MP.INTERFACE_NUM = NULL
        , MP.INTERFACE_PERSON_ID = P_CONNECT_PERSON_ID
        , MP.INTERFACE_DATE = V_SYSDATE
    WHERE MP.PAY_YYYYMM         = P_PAY_YYYYMM
      AND MP.WAGE_TYPE          = P_WAGE_TYPE  -- �޿�.
      AND MP.CORP_ID            = P_CORP_ID
      AND MP.SOB_ID             = P_SOB_ID
      AND MP.ORG_ID             = P_ORG_ID
      AND MP.INTERFACE_YN       = 'Y'
    ;
  END CANCEL_PAYMENT_SLIP;

---------------------------------------------------------------------------------------------------
-- �޻� ����� �����ڵ� �����ڼ� ����.
  FUNCTION CC_NONREGISTERED_COUNT_F
            ( P_CORP_ID           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
            , P_PAY_YYYYMM        IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE         IN HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , P_SOB_ID            IN HRP_MONTH_PAYMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRP_MONTH_PAYMENT.ORG_ID%TYPE
            ) RETURN NUMBER
  AS
    V_RETURN_VALUE      NUMBER := 0;
  BEGIN
    BEGIN
      SELECT COUNT(PM.PERSON_ID) AS NONREGISTERED_COUNT
        INTO V_RETURN_VALUE
        FROM HRM_PERSON_MASTER PM
          , HRP_MONTH_PAYMENT MP
      WHERE PM.PERSON_ID          = MP.PERSON_ID
        AND MP.PAY_YYYYMM         = P_PAY_YYYYMM
        AND MP.WAGE_TYPE          = P_WAGE_TYPE  -- �޿�.
        AND MP.CORP_ID            = P_CORP_ID
        AND MP.SOB_ID             = P_SOB_ID
        AND MP.ORG_ID             = P_ORG_ID
        AND PM.COST_CENTER_ID     IS NULL
      ;
    EXCEPTION WHEN OTHERS THEN
      V_RETURN_VALUE := 0;
    END;
    RETURN V_RETURN_VALUE;
  END CC_NONREGISTERED_COUNT_F;
  
END HRP_MONTH_PAYMENT_SLIP_G;
/
