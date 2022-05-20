CREATE OR REPLACE PROCEDURE IFC_TAX_VAT_FILE_2010_1
(  ERRBUF                    OUT VARCHAR2,
   RETCODE                  OUT NUMBER,
   P_HR_LOCATION          VARCHAR2,          -- ���
   P_START_DATE         VARCHAR2,                  -- ��������
   P_END_DATE             VARCHAR2                   -- ��������
) IS
  V_LOCATION_REG_NUM                          VARCHAR2(20) := TO_CHAR(NULL);
  
BEGIN


     /*====================================================*/
     /** ���ݰ�꼭 �հ�ǥ ǥ��                                                                    **/
     /*====================================================*/
     FOR N1 IN (
                        SELECT
                               ('7' ||                                                                                                -- �ڷᱸ��.(7)
                               RPAD(REPLACE(HRL.GLOBAL_ATTRIBUTE1, '-', ''), 10, ' ') ||          -- �����ڻ���ڵ�Ϲ�ȣ.
                               RPAD(HRL.LOCATION_CODE, 30, ' ') ||                                              -- ������ ��ȣ.
                               RPAD(HRL.GLOBAL_ATTRIBUTE4, 15, ' ') ||                                        -- ������ ����.
                               RPAD(HRL.ADDRESS_LINE_1, 45, ' ') ||                                               -- �����ڼ�����.
                               RPAD(HRL.GLOBAL_ATTRIBUTE6, 17, ' ') ||                                        -- ������ ����.
                               RPAD(HRL.GLOBAL_ATTRIBUTE5, 25, ' ') ||                                        -- ������ ����.
                               RPAD(TO_CHAR(TO_DATE(P_START_DATE, 'YYYY-MM-DD HH24:MI:SS'), 'YYMMDD') || TO_CHAR(TO_DATE(P_END_DATE, 'YYYY-MM-DD HH24:MI:SS'), 'YYMMDD'), 12, ' ') ||   -- �ŷ��Ⱓ.
                               RPAD(TO_CHAR(TO_DATE(P_END_DATE, 'YYYY-MM-DD HH24:MI:SS'), 'YYMMDD'), 6, ' ') ||   -- �ۼ�����.
                               RPAD(' ', 9, ' ')) AS OUTPUT                                                               -- ����.
                             , REPLACE(HRL.GLOBAL_ATTRIBUTE1, '-', '') LOCATION_REG_NUM   -- ����ڵ�Ϲ�ȣ.
                        FROM HR_LOCATIONS_ALL HRL
                        WHERE HRL.LOCATION_ID = P_HR_LOCATION
                      )
     LOOP
          V_LOCATION_REG_NUM := N1.LOCATION_REG_NUM;
          FND_FILE.PUT_LINE(FND_FILE.OUTPUT, N1.OUTPUT);
     END LOOP N1;

/*************************************************************************************************/
/******        ���� ���ݰ�꼭 �̿ܺ� - ���� �� / ���� ����                                                                          ******/
/*************************************************************************************************/
     /*====================================================*/
     /**       �����ڷ� -- ���ڼ��ݰ�꼭 �̿ܺ�.                                       **/
     /*====================================================*/
     FOR N2 IN (
                      SELECT
                               ('1' ||                                                                                -- �ڷᱸ��.
                             RPAD(REPLACE(O.O_TAX_REG, '-', ''), 10, ' ') ||              -- ������ ����ڵ�Ϲ�ȣ.
                             LPAD(ROWNUM, 4, '0') ||                                                    -- �Ϸù�ȣ.
                             RPAD(REPLACE(O.TAX_REG, '-', ''), 10, ' ') ||                    -- �ŷ�ó ����ڵ�Ϲ�ȣ.
                             RPAD(O.O_CUSTOMER_NAME, 30, ' ') ||                              -- �ŷ�ó ��ȣ.
                             RPAD(' ', 17, ' ') ||                                                                -- �ŷ�ó ����.
                             RPAD(' ', 25, ' ') ||                                                                -- �ŷ�ó ����.
                             LPAD(O_TAX_CNT, 7, '0') ||                                                   -- ���ݰ�꼭 �ż�.
                             RPAD('0', 2, '0') ||                                                                 --  ������.
                             LPAD(CASE
                                        WHEN NVL(O.O_REV_AMOUNT, 0) >= 0 THEN NVL(TO_CHAR(O.O_REV_AMOUNT), 0)
                                        ELSE SUBSTRB(REPLACE(TO_CHAR(O.O_REV_AMOUNT), '-', ''), 1, LENGTH(TO_CHAR(O.O_REV_AMOUNT)) - 2) ||
                                                  CASE SUBSTR(TO_CHAR(O.O_REV_AMOUNT), -1, 1)
                                                    WHEN '1' THEN 'J'
                                                    WHEN '2' THEN 'K'
                                                    WHEN '3' THEN 'L'
                                                    WHEN '4' THEN 'M'
                                                    WHEN '5' THEN 'N'
                                                    WHEN '6' THEN 'O'
                                                    WHEN '7' THEN 'P'
                                                    WHEN '8' THEN 'Q'
                                                    WHEN '9' THEN 'R'
                                                    WHEN '0' THEN '}'
                                                  END
                                      END, 14, '0') ||                                                              -- ���ް���.
                             LPAD(CASE
                                        WHEN NVL(O.O_TAX_AMOUNT, 0) >= 0 THEN NVL(TO_CHAR(O.O_TAX_AMOUNT), 0)
                                        ELSE SUBSTRB(REPLACE(TO_CHAR(O.O_TAX_AMOUNT), '-', ''), 1, LENGTH(TO_CHAR(O.O_TAX_AMOUNT)) - 2) ||
                                                  CASE SUBSTR(TO_CHAR(O.O_TAX_AMOUNT), -1, 1)
                                                    WHEN '1' THEN 'J'
                                                    WHEN '2' THEN 'K'
                                                    WHEN '3' THEN 'L'
                                                    WHEN '4' THEN 'M'
                                                    WHEN '5' THEN 'N'
                                                    WHEN '6' THEN 'O'
                                                    WHEN '7' THEN 'P'
                                                    WHEN '8' THEN 'Q'
                                                    WHEN '9' THEN 'R'
                                                    WHEN '0' THEN '}'
                                                  END
                                      END, 13, '0') ||                                                            -- ����.
                             RPAD(0, 1, '0') ||
                             RPAD(0, 1, '0') ||
                             RPAD(TO_CHAR('7501'), 4, ' ') ||                                         -- �ǹ�ȣ.
                             RPAD(SUBSTRB(O.O_TAX_REG, 1, 3), 3, ' ') ||
                             RPAD(' ', 28, ' ')) OUTPUT
                      FROM
                         (-- ��ü
                            SELECT
                                     HLA.GLOBAL_ATTRIBUTE1  O_TAX_REG
                                   , HLA.LOCATION_CODE O_LOCATION_CODE
                                   , HLA.GLOBAL_ATTRIBUTE4 O_GLOBAL_ATTRIBUTE4
                                   , HLA.ADDRESS_LINE_1 || ' ' || HLA.ADDRESS_LINE_2 O_ADDRESS
                                   , RC.TAX_REFERENCE TAX_REG
                                   , NVL(RC.CUSTOMER_NAME_PHONETIC, RC.CUSTOMER_NAME) AS O_CUSTOMER_NAME
                                   , COUNT(DISTINCT RCT.GLOBAL_ATTRIBUTE27) O_TAX_CNT
                                   , SUM(DECODE(DIST.ACCOUNT_CLASS,'REV',ACCTD_AMOUNT)) O_REV_AMOUNT
                                   , SUM(DECODE(DIST.ACCOUNT_CLASS,'TAX',ACCTD_AMOUNT)) O_TAX_AMOUNT
                              FROM GL_CODE_COMBINATIONS CC,
                                   RA_CUSTOMER_TRX_LINES_ALL RCTL,
                                   RA_CUSTOMER_TRX_ALL RCT,
                                   RA_CUST_TRX_LINE_GL_DIST_ALL DIST,
                                   AR_VAT_TAX_ALL AVT,
                                   RA_CUSTOMERS RC,
                                   HR_LOCATIONS_ALL HLA
                             WHERE DIST.CUSTOMER_TRX_ID   = RCT.CUSTOMER_TRX_ID
                               AND DIST.CUSTOMER_TRX_LINE_ID = RCTL.CUSTOMER_TRX_LINE_ID(+)
                               AND DIST.CODE_COMBINATION_ID = CC.CODE_COMBINATION_ID
                               AND RCTL.VAT_TAX_ID = AVT.VAT_TAX_ID(+)
                               AND RC.CUSTOMER_ID = RCT.BILL_TO_CUSTOMER_ID
                               AND AVT.GLOBAL_ATTRIBUTE1 = HLA.LOCATION_ID(+)
                               AND DIST.ACCOUNT_CLASS <> 'REC'
                               AND RCT.COMPLETE_FLAG = 'Y'
                               AND RCTL.VAT_TAX_ID IS NOT NULL
                               AND RCT.GLOBAL_ATTRIBUTE27 IS NOT NULL
                               AND RC.PARTY_TYPE = 'ORGANIZATION'
                               AND AVT.VAT_TRANSACTION_TYPE IN ('OUTPUT_VAT','OUTPUT_EXEMPT')
                               AND TO_DATE(RCT.GLOBAL_ATTRIBUTE29, 'YYYY-MM-DD HH24:MI:SS') BETWEEN TO_DATE(P_START_DATE, 'YYYY-MM-DD HH24:MI:SS') AND TO_DATE(P_END_DATE, 'YYYY-MM-DD HH24:MI:SS')
                               AND HLA.LOCATION_ID = P_HR_LOCATION
                               AND EXISTS (SELECT 'X'
                                                      FROM HZ_CUST_ACCOUNTS CA    -- ATTRIBUTE12 AS TAX_ISSUE_TYPE
                                                      WHERE CA.CUST_ACCOUNT_ID = RCT.BILL_TO_CUSTOMER_ID
                                                        AND NVL(CA.ATTRIBUTE12, '30') IN ('30', '40'))                              -- ���� or ���� ����.
/*-- ��ȣ�� ����.                                                        
                               AND EXISTS (SELECT 'X'
                                                      FROM RA_CUSTOMER_TRX_ALL RCT1
                                                      WHERE RCT1.CUSTOMER_TRX_ID = RCT.CUSTOMER_TRX_ID
                                                        AND NVL(RCT1.GLOBAL_ATTRIBUTE23, '40') IN ('30', '40'))*/                                                        
                            GROUP BY HLA.GLOBAL_ATTRIBUTE1
                                   , HLA.LOCATION_CODE
                                   , HLA.GLOBAL_ATTRIBUTE4
                                   , HLA.ADDRESS_LINE_1 || ' ' || HLA.ADDRESS_LINE_2
                                   , RC.TAX_REFERENCE
                                   , NVL(RC.CUSTOMER_NAME_PHONETIC, RC.CUSTOMER_NAME)
                          ) O,
                          (-- ����
                            SELECT
                                     HLA.GLOBAL_ATTRIBUTE1 P_TAX_REG
                                   , COUNT(DISTINCT RC.customer_name) P_REG_CNT
                                   , COUNT(DISTINCT RCT.GLOBAL_ATTRIBUTE27) P_TAX_CNT
                                   , SUM(DECODE(DIST.ACCOUNT_CLASS,'REV',ACCTD_AMOUNT)) P_REV_AMOUNT
                            	     , SUM(DECODE(DIST.ACCOUNT_CLASS,'TAX',ACCTD_AMOUNT)) P_TAX_AMOUNT
                              FROM GL_CODE_COMBINATIONS CC,
                                   RA_CUSTOMER_TRX_LINES_ALL RCTL,
                                   RA_CUSTOMER_TRX_ALL RCT,
                                   RA_CUST_TRX_LINE_GL_DIST_ALL DIST,
                                   AR_VAT_TAX_ALL AVT,
                                   RA_CUSTOMERS RC,
                                   HR_LOCATIONS_ALL HLA
                             WHERE DIST.CUSTOMER_TRX_ID   = RCT.CUSTOMER_TRX_ID
                               AND DIST.CUSTOMER_TRX_LINE_ID = RCTL.CUSTOMER_TRX_LINE_ID(+)
                               AND DIST.CODE_COMBINATION_ID = CC.CODE_COMBINATION_ID
                               AND RCTL.VAT_TAX_ID = AVT.VAT_TAX_ID(+)
                               AND RC.CUSTOMER_ID = RCT.BILL_TO_CUSTOMER_ID
                               AND AVT.GLOBAL_ATTRIBUTE1 = HLA.LOCATION_ID(+)
                               AND DIST.ACCOUNT_CLASS <> 'REC'
                               AND RCT.COMPLETE_FLAG = 'Y'
                               AND RCTL.VAT_TAX_ID IS NOT NULL
                               AND RCT.GLOBAL_ATTRIBUTE27 IS NOT NULL
                               AND RC.PARTY_TYPE = 'PERSON'
                               AND AVT.VAT_TRANSACTION_TYPE IN ('OUTPUT_VAT','OUTPUT_EXEMPT')
                               AND TO_DATE(RCT.GLOBAL_ATTRIBUTE29, 'YYYY-MM-DD HH24:MI:SS') BETWEEN TO_DATE(P_START_DATE, 'YYYY-MM-DD HH24:MI:SS') AND TO_DATE(P_END_DATE, 'YYYY-MM-DD HH24:MI:SS')
                               AND HLA.LOCATION_ID = P_HR_LOCATION
                               AND EXISTS (SELECT 'X'
                                                      FROM HZ_CUST_ACCOUNTS CA    -- ATTRIBUTE12 AS TAX_ISSUE_TYPE
                                                      WHERE CA.CUST_ACCOUNT_ID = RCT.BILL_TO_CUSTOMER_ID
                                                        AND NVL(CA.ATTRIBUTE12, '30') IN ('30', '40'))                              -- ���� or ���� ����.
/*-- ��ȣ�� ����.                                                        
                               AND EXISTS (SELECT 'X'
                                                      FROM RA_CUSTOMER_TRX_ALL RCT1
                                                      WHERE RCT1.CUSTOMER_TRX_ID = RCT.CUSTOMER_TRX_ID
                                                        AND NVL(RCT1.GLOBAL_ATTRIBUTE23, '40') IN ('30', '40'))*/
                            GROUP BY HLA.GLOBAL_ATTRIBUTE1
                          ) P
                      WHERE O.O_TAX_REG= P.P_TAX_REG(+)
                     )
     LOOP
         FND_FILE.PUT_LINE(FND_FILE.OUTPUT, N2.OUTPUT);
     END LOOP N2;

     /*====================================================*/
     /**       �����հ� - ���ڼ��ݰ�꼭 �̿ܺ�.                                          **/
     /*====================================================*/
     FOR N1 IN (
                       SELECT
                              ('3' ||
                               RPAD(REPLACE(O.O_TAX_REG, '-', ''), 10, ' ')  ||
                               -- �հ�
                               LPAD(COUNT(O.TAX_REG) + COUNT(P.P_REG_CNT), 7, '0')  ||
                               LPAD(SUM(NVL(O_TAX_CNT, 0) + NVL(P.P_TAX_CNT, 0)), 7, '0')  ||
                               LPAD(SUM(NVL(O.O_REV_AMOUNT, 0) + NVL(P.P_REV_AMOUNT, 0)), 15, '0')  ||
                               LPAD(SUM(NVL(O.O_TAX_AMOUNT, 0) + NVL(P.P_TAX_AMOUNT, 0)), 14, '0')  ||
                               -- ����ڹ�ȣ �����.
                               LPAD(COUNT(O.TAX_REG), 7, '0')  ||
                               LPAD(SUM(NVL(O_TAX_CNT, 0)), 7, '0')  ||
                               LPAD(CASE
                                        WHEN SUM(NVL(O.O_REV_AMOUNT, 0)) >= 0 THEN NVL(TO_CHAR(SUM(NVL(O.O_REV_AMOUNT, 0))), 0)
                                        ELSE SUBSTRB(REPLACE(TO_CHAR(SUM(NVL(O.O_REV_AMOUNT, 0))), '-', ''), 1, LENGTH(TO_CHAR(SUM(NVL(O.O_REV_AMOUNT, 0)))) - 2) ||
                                                  CASE SUBSTR(TO_CHAR(SUM(NVL(O.O_REV_AMOUNT, 0))), -1, 1)
                                                    WHEN '1' THEN 'J'
                                                    WHEN '2' THEN 'K'
                                                    WHEN '3' THEN 'L'
                                                    WHEN '4' THEN 'M'
                                                    WHEN '5' THEN 'N'
                                                    WHEN '6' THEN 'O'
                                                    WHEN '7' THEN 'P'
                                                    WHEN '8' THEN 'Q'
                                                    WHEN '9' THEN 'R'
                                                    WHEN '0' THEN '}'
                                                  END
                                      END, 15, '0') ||
                             LPAD(CASE
                                        WHEN SUM(NVL(O.O_TAX_AMOUNT, 0)) >= 0 THEN NVL(TO_CHAR(SUM(NVL(O.O_TAX_AMOUNT, 0))), 0)
                                        ELSE SUBSTRB(REPLACE(TO_CHAR(SUM(NVL(O.O_TAX_AMOUNT, 0))), '-', ''), 1, LENGTH(TO_CHAR(SUM(NVL(O.O_TAX_AMOUNT, 0)))) - 2) ||
                                                  CASE SUBSTR(TO_CHAR(SUM(NVL(O.O_TAX_AMOUNT, 0))), -1, 1)
                                                    WHEN '1' THEN 'J'
                                                    WHEN '2' THEN 'K'
                                                    WHEN '3' THEN 'L'
                                                    WHEN '4' THEN 'M'
                                                    WHEN '5' THEN 'N'
                                                    WHEN '6' THEN 'O'
                                                    WHEN '7' THEN 'P'
                                                    WHEN '8' THEN 'Q'
                                                    WHEN '9' THEN 'R'
                                                    WHEN '0' THEN '}'
                                                  END
                                      END, 14, '0') ||
/*                               LPAD(SUM(NVL(O.O_REV_AMOUNT, 0)), 15, '0')  ||
                               LPAD(SUM(NVL(O.O_TAX_AMOUNT, 0)), 14, '0')  ||*/
                               -- �ֹι�ȣ �����.
                               LPAD(COUNT(P.P_REG_CNT), 7, '0')  ||
                               LPAD(SUM(NVL(P.P_TAX_CNT, 0)), 7, '0')  ||
                               LPAD(CASE
                                        WHEN SUM(NVL(P.P_REV_AMOUNT, 0)) >= 0 THEN NVL(TO_CHAR(SUM(NVL(P.P_REV_AMOUNT, 0))), 0)
                                        ELSE SUBSTRB(REPLACE(TO_CHAR(SUM(NVL(P.P_REV_AMOUNT, 0))), '-', ''), 1, LENGTH(TO_CHAR(SUM(NVL(P.P_REV_AMOUNT, 0)))) - 2) ||
                                                  CASE SUBSTR(TO_CHAR(SUM(NVL(P.P_REV_AMOUNT, 0))), -1, 1)
                                                    WHEN '1' THEN 'J'
                                                    WHEN '2' THEN 'K'
                                                    WHEN '3' THEN 'L'
                                                    WHEN '4' THEN 'M'
                                                    WHEN '5' THEN 'N'
                                                    WHEN '6' THEN 'O'
                                                    WHEN '7' THEN 'P'
                                                    WHEN '8' THEN 'Q'
                                                    WHEN '9' THEN 'R'
                                                    WHEN '0' THEN '}'
                                                  END
                                      END, 15, '0') ||
                             LPAD(CASE
                                        WHEN SUM(NVL(P.P_TAX_AMOUNT, 0)) >= 0 THEN NVL(TO_CHAR(SUM(NVL(P.P_TAX_AMOUNT, 0))), 0)
                                        ELSE SUBSTRB(REPLACE(TO_CHAR(SUM(NVL(P.P_TAX_AMOUNT, 0))), '-', ''), 1, LENGTH(TO_CHAR(SUM(NVL(P.P_TAX_AMOUNT, 0)))) - 2) ||
                                                  CASE SUBSTR(TO_CHAR(SUM(NVL(P.P_TAX_AMOUNT, 0))), -1, 1)
                                                    WHEN '1' THEN 'J'
                                                    WHEN '2' THEN 'K'
                                                    WHEN '3' THEN 'L'
                                                    WHEN '4' THEN 'M'
                                                    WHEN '5' THEN 'N'
                                                    WHEN '6' THEN 'O'
                                                    WHEN '7' THEN 'P'
                                                    WHEN '8' THEN 'Q'
                                                    WHEN '9' THEN 'R'
                                                    WHEN '0' THEN '}'
                                                  END
                                      END, 14, '0') ||
/*                               LPAD(SUM(NVL(P.P_REV_AMOUNT, 0)), 15, '0')  ||
                               LPAD(SUM(NVL(P.P_TAX_AMOUNT, 0)), 14, '0')  ||*/
                               RPAD(' ', 30, ' ')) AS OUTPUT
                      FROM
                         (-- ��ü
                            SELECT
                                     HLA.GLOBAL_ATTRIBUTE1  O_TAX_REG
                                   , HLA.LOCATION_CODE O_LOCATION_CODE
                                   , HLA.GLOBAL_ATTRIBUTE4 O_GLOBAL_ATTRIBUTE4
                                   , HLA.ADDRESS_LINE_1 || ' ' || HLA.ADDRESS_LINE_2 O_ADDRESS
                                   , RC.TAX_REFERENCE TAX_REG
                                   , NVL(RC.CUSTOMER_NAME_PHONETIC, RC.CUSTOMER_NAME) AS O_CUSTOMER_NAME
                                   , COUNT(DISTINCT RCT.GLOBAL_ATTRIBUTE27) O_TAX_CNT
                                   , SUM(DECODE(DIST.ACCOUNT_CLASS,'REV',ACCTD_AMOUNT)) O_REV_AMOUNT
                                  , SUM(DECODE(DIST.ACCOUNT_CLASS,'TAX',ACCTD_AMOUNT)) O_TAX_AMOUNT
                              FROM GL_CODE_COMBINATIONS CC,
                                   RA_CUSTOMER_TRX_LINES_ALL RCTL,
                                   RA_CUSTOMER_TRX_ALL RCT,
                                   RA_CUST_TRX_LINE_GL_DIST_ALL DIST,
                                AR_VAT_TAX_ALL AVT,
                                RA_CUSTOMERS RC,
                                HR_LOCATIONS_ALL HLA
                             WHERE DIST.CUSTOMER_TRX_ID   = RCT.CUSTOMER_TRX_ID
                               AND DIST.CUSTOMER_TRX_LINE_ID = RCTL.CUSTOMER_TRX_LINE_ID(+)
                               AND DIST.CODE_COMBINATION_ID = CC.CODE_COMBINATION_ID
                               AND RCTL.VAT_TAX_ID = AVT.VAT_TAX_ID(+)
                               AND RC.CUSTOMER_ID = RCT.BILL_TO_CUSTOMER_ID
                               AND AVT.GLOBAL_ATTRIBUTE1 = HLA.LOCATION_ID(+)
                               AND DIST.ACCOUNT_CLASS <> 'REC'
                               AND RCT.COMPLETE_FLAG = 'Y'
                               AND RCTL.VAT_TAX_ID IS NOT NULL
                               AND RCT.GLOBAL_ATTRIBUTE27 IS NOT NULL
                               AND RC.PARTY_TYPE = 'ORGANIZATION'
                               AND AVT.VAT_TRANSACTION_TYPE IN ('OUTPUT_VAT','OUTPUT_EXEMPT')
                               AND TO_DATE(RCT.GLOBAL_ATTRIBUTE29, 'YYYY-MM-DD HH24:MI:SS') BETWEEN TO_DATE(P_START_DATE, 'YYYY-MM-DD HH24:MI:SS') AND TO_DATE(P_END_DATE, 'YYYY-MM-DD HH24:MI:SS')
                               AND HLA.LOCATION_ID = P_HR_LOCATION
                               AND EXISTS (SELECT 'X'
                                                      FROM HZ_CUST_ACCOUNTS CA    -- ATTRIBUTE12 AS TAX_ISSUE_TYPE
                                                      WHERE CA.CUST_ACCOUNT_ID = RCT.BILL_TO_CUSTOMER_ID
                                                        AND NVL(CA.ATTRIBUTE12, '30') IN ('30', '40'))                              -- ���� or ���� ����.
/*-- ��ȣ�� ����.                                                        
                               AND EXISTS (SELECT 'X'
                                                      FROM RA_CUSTOMER_TRX_ALL RCT1
                                                      WHERE RCT1.CUSTOMER_TRX_ID = RCT.CUSTOMER_TRX_ID
                                                        AND NVL(RCT1.GLOBAL_ATTRIBUTE23, '40') IN ('30', '40'))*/
                            GROUP BY HLA.GLOBAL_ATTRIBUTE1
                                   , HLA.LOCATION_CODE
                                   , HLA.GLOBAL_ATTRIBUTE4
                                   , HLA.ADDRESS_LINE_1 || ' ' || HLA.ADDRESS_LINE_2
                                   , RC.TAX_REFERENCE
                                   , NVL(RC.CUSTOMER_NAME_PHONETIC, RC.CUSTOMER_NAME)
                          ) O,
                          (-- ����
                            SELECT
                                     HLA.GLOBAL_ATTRIBUTE1 P_TAX_REG
                                   , COUNT(DISTINCT RC.customer_name) P_REG_CNT
                                   , COUNT(DISTINCT RCT.GLOBAL_ATTRIBUTE27) P_TAX_CNT
                                   , SUM(DECODE(DIST.ACCOUNT_CLASS,'REV',ACCTD_AMOUNT)) P_REV_AMOUNT
                            	     , SUM(DECODE(DIST.ACCOUNT_CLASS,'TAX',ACCTD_AMOUNT)) P_TAX_AMOUNT
                              FROM GL_CODE_COMBINATIONS CC,
                                   RA_CUSTOMER_TRX_LINES_ALL RCTL,
                                   RA_CUSTOMER_TRX_ALL RCT,
                                   RA_CUST_TRX_LINE_GL_DIST_ALL DIST,
                            	   AR_VAT_TAX_ALL AVT,
                            	   RA_CUSTOMERS RC,
                            	   HR_LOCATIONS_ALL HLA
                             WHERE DIST.CUSTOMER_TRX_ID   = RCT.CUSTOMER_TRX_ID
                               AND DIST.CUSTOMER_TRX_LINE_ID = RCTL.CUSTOMER_TRX_LINE_ID(+)
                               AND DIST.CODE_COMBINATION_ID = CC.CODE_COMBINATION_ID
                               AND RCTL.VAT_TAX_ID = AVT.VAT_TAX_ID(+)
                               AND RC.CUSTOMER_ID = RCT.BILL_TO_CUSTOMER_ID
                               AND AVT.GLOBAL_ATTRIBUTE1 = HLA.LOCATION_ID(+)
                               AND DIST.ACCOUNT_CLASS <> 'REC'
                               AND RCT.COMPLETE_FLAG = 'Y'
                               AND RCTL.VAT_TAX_ID IS NOT NULL
                               AND RCT.GLOBAL_ATTRIBUTE27 IS NOT NULL
                               AND RC.PARTY_TYPE = 'PERSON'
                               AND AVT.VAT_TRANSACTION_TYPE IN ('OUTPUT_VAT','OUTPUT_EXEMPT')
                               AND TO_DATE(RCT.GLOBAL_ATTRIBUTE29, 'YYYY-MM-DD HH24:MI:SS') BETWEEN TO_DATE(P_START_DATE, 'YYYY-MM-DD HH24:MI:SS') AND TO_DATE(P_END_DATE, 'YYYY-MM-DD HH24:MI:SS')
                               AND HLA.LOCATION_ID = P_HR_LOCATION
                               AND EXISTS (SELECT 'X'
                                                      FROM HZ_CUST_ACCOUNTS CA    -- ATTRIBUTE12 AS TAX_ISSUE_TYPE
                                                      WHERE CA.CUST_ACCOUNT_ID = RCT.BILL_TO_CUSTOMER_ID
                                                        AND NVL(CA.ATTRIBUTE12, '30') IN ('30', '40'))                              -- ���� or ���� ����.
/*-- ��ȣ�� ����.                                                        
                               AND EXISTS (SELECT 'X'
                                                      FROM RA_CUSTOMER_TRX_ALL RCT1
                                                      WHERE RCT1.CUSTOMER_TRX_ID = RCT.CUSTOMER_TRX_ID
                                                        AND NVL(RCT1.GLOBAL_ATTRIBUTE23, '40') IN ('30', '40'))*/
                            GROUP BY HLA.GLOBAL_ATTRIBUTE1
                          ) P
                      WHERE O.O_TAX_REG= P.P_TAX_REG(+)
                      GROUP BY O.O_TAX_REG
                      )
     LOOP
         FND_FILE.PUT_LINE(FND_FILE.OUTPUT, N1.OUTPUT);
     END LOOP N1;

/*************************************************************************************************/
/******        ���� �� / ���� ����                                                                                            ******/
/*************************************************************************************************/
    /*====================================================*/
     /**       �����ڷ�  - ���ڼ��ݰ�꼭 �̿ܺ�.                                         **/
     /*====================================================*/
     FOR N1 IN (
                        SELECT
                                   ('2' ||
                                   RPAD(REPLACE(A.H_REGISTRATION_NUM, '-', ''), 10, ' ') ||
                                   LPAD(ROWNUM, 4, '0') ||
                                   RPAD(REPLACE(A.VAT_REGISTRATION_NUM, '-', ''), 10, ' ') ||
                                   RPAD(A.VENDOR_NAME, 30, ' ') ||
                                   RPAD(' ', 17, ' ') ||
                                   RPAD(' ', 25, ' ') ||
                                   LPAD(NVL(A.VAT_CNT, 0), 7, '0') ||
                                   RPAD('0', 2, '0') ||
                                   LPAD(CASE
                                        WHEN NVL(A.SUPPLY_AMOUNT, 0) >= 0 THEN NVL(TO_CHAR(A.SUPPLY_AMOUNT), 0)
                                        ELSE SUBSTRB(REPLACE(TO_CHAR(A.SUPPLY_AMOUNT), '-', ''), 1, LENGTH(TO_CHAR(A.SUPPLY_AMOUNT)) - 2) ||
                                                  CASE SUBSTR(TO_CHAR(A.SUPPLY_AMOUNT), -1, 1)
                                                    WHEN '1' THEN 'J'
                                                    WHEN '2' THEN 'K'
                                                    WHEN '3' THEN 'L'
                                                    WHEN '4' THEN 'M'
                                                    WHEN '5' THEN 'N'
                                                    WHEN '6' THEN 'O'
                                                    WHEN '7' THEN 'P'
                                                    WHEN '8' THEN 'Q'
                                                    WHEN '9' THEN 'R'
                                                    WHEN '0' THEN '}'
                                                  END
                                      END, 14, '0') ||
                             LPAD(CASE
                                        WHEN NVL(A.TAX_AMOUNT, 0) >= 0 THEN NVL(TO_CHAR(A.TAX_AMOUNT), 0)
                                        ELSE SUBSTRB(REPLACE(TO_CHAR(A.TAX_AMOUNT), '-', ''), 1, LENGTH(TO_CHAR(A.TAX_AMOUNT)) - 2) ||
                                                  CASE SUBSTR(TO_CHAR(A.TAX_AMOUNT), -1, 1)
                                                    WHEN '1' THEN 'J'
                                                    WHEN '2' THEN 'K'
                                                    WHEN '3' THEN 'L'
                                                    WHEN '4' THEN 'M'
                                                    WHEN '5' THEN 'N'
                                                    WHEN '6' THEN 'O'
                                                    WHEN '7' THEN 'P'
                                                    WHEN '8' THEN 'Q'
                                                    WHEN '9' THEN 'R'
                                                    WHEN '0' THEN '}'
                                                  END
                                      END, 13, '0') ||
/*                                   LPAD(NVL(A.SUPPLY_AMOUNT, 0), 14, '0') ||
                                   LPAD(NVL(A.TAX_AMOUNT, 0), 13, '0') ||*/
                                   RPAD('0', 1, '0') ||
                                   RPAD('0', 1, '0') ||
                                   RPAD('8501', 4, ' ') ||
                                   RPAD(SUBSTRB(A.H_REGISTRATION_NUM, 1, 3), 3, ' ') ||
                                   RPAD(' ', 28, ' ')) AS OUTPUT
                            FROM
                                (
                                  SELECT PX1.H_REGISTRATION_NUM
                                         , PX1.H_CORP_NAME
                                         , PX1.H_NAME
                                         , PX1.H_ADDRESS
                                         , PX1.VAT_REGISTRATION_NUM
                                         , PX1.VENDOR_NAME
                                         , COUNT(AIA.INVOICE_ID) AS VAT_CNT
                                         , SUM(PX1.SUPPLY_AMOUNT) AS SUPPLY_AMOUNT
                                         , SUM(PX1.TAX_AMOUNT) AS TAX_AMOUNT
                                  FROM AP_INVOICES_ALL AIA,
                                       (
                                        SELECT
                                               HLA.GLOBAL_ATTRIBUTE1  H_REGISTRATION_NUM,
                                               HLA.LOCATION_CODE H_CORP_NAME,
                                               HLA.GLOBAL_ATTRIBUTE4 H_NAME,
                                               HLA.ADDRESS_LINE_1 H_ADDRESS,
                                               PV.VAT_REGISTRATION_NUM,
                                               NVL(PV.VENDOR_NAME_ALT, PV.VENDOR_NAME) VENDOR_NAME,
                                               AIA.INVOICE_ID,
                                               SUM(CASE
                                                  WHEN AID.LINE_TYPE_LOOKUP_CODE IN('ITEM','FREIGHT') THEN NVL(AID.BASE_AMOUNT,AID.AMOUNT)
                                                  ELSE 0
                                               END) AS SUPPLY_AMOUNT,
                                               --SUM(DECODE(AID.LINE_TYPE_LOOKUP_CODE,'ITEM',NVL(AID.BASE_AMOUNT,AID.AMOUNT))) AS SUPPLY_AMOUNT,
                                               SUM(DECODE(AID.LINE_TYPE_LOOKUP_CODE,'TAX' ,NVL(AID.BASE_AMOUNT,AID.AMOUNT))) AS TAX_AMOUNT
                                          FROM AP_INVOICES_ALL AIA,
                                            AP_INVOICE_DISTRIBUTIONS_ALL AID,
                                            AP_TAX_CODES_ALL ATC,
                                            PO_VENDORS PV,
                                            HR_LOCATIONS_ALL HLA
                                         WHERE AID.INVOICE_ID = AIA.INVOICE_ID
                                           AND AID.TAX_CODE_ID = ATC.TAX_ID
                                           AND PV.VENDOR_ID    = NVL(AIA.GLOBAL_ATTRIBUTE4,AIA.VENDOR_ID)
                                           AND HLA.LOCATION_ID = ATC.GLOBAL_ATTRIBUTE1
                                           AND ATC.VAT_TRANSACTION_TYPE IN ('INPUT_VAT','INPUT_OTHER')
                                           AND AIA.INVOICE_TYPE_LOOKUP_CODE <> 'PREPAYMENT'
                                           AND AID.LINE_TYPE_LOOKUP_CODE IN ('ITEM','TAX', 'FREIGHT')
                                           AND ATC.NAME NOT IN('���ݾ���')
                                           AND AID.TAX_CODE_ID IS NOT NULL
                                           AND AID.ACCOUNTING_EVENT_ID IS NOT NULL
                                           --AND AID.REVERSAL_FLAG IS NULL
                                           AND AIA.GLOBAL_ATTRIBUTE1 = 1
                                           AND PV.VAT_REGISTRATION_NUM IS NOT NULL
                                           AND AIA.CANCELLED_DATE IS NULL
                                           AND NVL(TO_DATE(AIA.GLOBAL_ATTRIBUTE3,'YYYY-MM-DD HH24:MI:SS'),AIA.GL_DATE) BETWEEN TO_DATE(P_START_DATE, 'YYYY-MM-DD HH24:MI:SS') AND TO_DATE(P_END_DATE, 'YYYY-MM-DD HH24:MI:SS')
                                           AND HLA.LOCATION_ID = P_HR_LOCATION
                                           AND EXISTS( SELECT 'X'
                                                                  FROM PO_VENDOR_SITES_ALL VS
                                                                  WHERE VS.VENDOR_SITE_ID = AIA.VENDOR_SITE_ID
                                                                  AND NVL(VS.GLOBAL_ATTRIBUTE12, '40') IN ('30', '40'))       -- ���� OR ���ݾ���.
                                        GROUP BY HLA.GLOBAL_ATTRIBUTE1,
                                               HLA.LOCATION_CODE,
                                               HLA.GLOBAL_ATTRIBUTE4,
                                               HLA.ADDRESS_LINE_1,
                                               PV.VAT_REGISTRATION_NUM,
                                               NVL(PV.VENDOR_NAME_ALT, PV.VENDOR_NAME),
                                               AIA.INVOICE_ID
                                       ) PX1
                                  WHERE AIA.INVOICE_ID = PX1.INVOICE_ID
                                  GROUP BY PX1.H_REGISTRATION_NUM
                                         , PX1.H_CORP_NAME
                                         , PX1.H_NAME
                                         , PX1.H_ADDRESS
                                         , PX1.VAT_REGISTRATION_NUM
                                         , PX1.VENDOR_NAME
                                ) A
                )
     LOOP
       FND_FILE.PUT_LINE(FND_FILE.OUTPUT, N1.OUTPUT);
     END LOOP N1;


    /*====================================================*/
     /**       �����հ� - ���ڼ��ݰ�꼭 �̿ܺ�.                                          **/
     /*====================================================*/
     FOR N1 IN (
                        SELECT
                                ('4'  ||
                                RPAD(REPLACE(A.H_REGISTRATION_NUM, '-', ''), 10, ' ') ||
                                --> �հ��.
                                LPAD(COUNT(A.VAT_REGISTRATION_NUM), 7, '0')  ||                            -- �ŷ�ó��.
                                LPAD(SUM(NVL(A.VAT_CNT, 0)), 7, '0')  ||                                               -- ���ݰ�꼭 �ż�.
                                LPAD(CASE
                                            WHEN SUM(NVL(A.SUPPLY_AMOUNT, 0)) >= 0 THEN NVL(TO_CHAR(SUM(NVL(A.SUPPLY_AMOUNT, 0))), 0)
                                            ELSE SUBSTRB(REPLACE(TO_CHAR(SUM(NVL(A.SUPPLY_AMOUNT, 0))), '-', ''), 1, LENGTH(TO_CHAR(SUM(NVL(A.SUPPLY_AMOUNT, 0)))) - 2) ||
                                                      CASE SUBSTR(TO_CHAR(SUM(NVL(A.SUPPLY_AMOUNT, 0))), -1, 1)
                                                        WHEN '1' THEN 'J'
                                                        WHEN '2' THEN 'K'
                                                        WHEN '3' THEN 'L'
                                                        WHEN '4' THEN 'M'
                                                        WHEN '5' THEN 'N'
                                                        WHEN '6' THEN 'O'
                                                        WHEN '7' THEN 'P'
                                                        WHEN '8' THEN 'Q'
                                                        WHEN '9' THEN 'R'
                                                        WHEN '0' THEN '}'
                                                      END
                                          END, 15, '0') ||                                                                                  -- ���ް��� �հ�.
                                LPAD(CASE
                                          WHEN SUM(NVL(A.TAX_AMOUNT, 0)) >= 0 THEN NVL(TO_CHAR(SUM(NVL(A.TAX_AMOUNT, 0))), 0)
                                          ELSE SUBSTRB(REPLACE(TO_CHAR(SUM(NVL(A.TAX_AMOUNT, 0))), '-', ''), 1, LENGTH(TO_CHAR(SUM(NVL(A.TAX_AMOUNT, 0)))) - 2) ||
                                                    CASE SUBSTR(TO_CHAR(SUM(NVL(A.TAX_AMOUNT, 0))), -1, 1)
                                                      WHEN '1' THEN 'J'
                                                      WHEN '2' THEN 'K'
                                                      WHEN '3' THEN 'L'
                                                      WHEN '4' THEN 'M'
                                                      WHEN '5' THEN 'N'
                                                      WHEN '6' THEN 'O'
                                                      WHEN '7' THEN 'P'
                                                      WHEN '8' THEN 'Q'
                                                      WHEN '9' THEN 'R'
                                                      WHEN '0' THEN '}'
                                                    END
                                        END, 14, '0') ||                                                                                -- ���� �հ�.
                                --> ����ڵ�Ϲ�ȣ �����.
                                LPAD(COUNT(A.VAT_REGISTRATION_NUM), 7, '0')  ||                            -- �ŷ�ó��.
                                LPAD(SUM(NVL(A.VAT_CNT, 0)), 7, '0')  ||                                               -- ���ݰ�꼭 �ż�.
                                LPAD(CASE
                                            WHEN SUM(NVL(A.SUPPLY_AMOUNT, 0)) >= 0 THEN NVL(TO_CHAR(SUM(NVL(A.SUPPLY_AMOUNT, 0))), 0)
                                            ELSE SUBSTRB(REPLACE(TO_CHAR(SUM(NVL(A.SUPPLY_AMOUNT, 0))), '-', ''), 1, LENGTH(TO_CHAR(SUM(NVL(A.SUPPLY_AMOUNT, 0)))) - 2) ||
                                                      CASE SUBSTR(TO_CHAR(SUM(NVL(A.SUPPLY_AMOUNT, 0))), -1, 1)
                                                        WHEN '1' THEN 'J'
                                                        WHEN '2' THEN 'K'
                                                        WHEN '3' THEN 'L'
                                                        WHEN '4' THEN 'M'
                                                        WHEN '5' THEN 'N'
                                                        WHEN '6' THEN 'O'
                                                        WHEN '7' THEN 'P'
                                                        WHEN '8' THEN 'Q'
                                                        WHEN '9' THEN 'R'
                                                        WHEN '0' THEN '}'
                                                      END
                                          END, 15, '0') ||                                                                                  -- ���ް��� �հ�.
                              LPAD(CASE
                                          WHEN SUM(NVL(A.TAX_AMOUNT, 0)) >= 0 THEN NVL(TO_CHAR(SUM(NVL(A.TAX_AMOUNT, 0))), 0)
                                          ELSE SUBSTRB(REPLACE(TO_CHAR(SUM(NVL(A.TAX_AMOUNT, 0))), '-', ''), 1, LENGTH(TO_CHAR(SUM(NVL(A.TAX_AMOUNT, 0)))) - 2) ||
                                                    CASE SUBSTR(TO_CHAR(SUM(NVL(A.TAX_AMOUNT, 0))), -1, 1)
                                                      WHEN '1' THEN 'J'
                                                      WHEN '2' THEN 'K'
                                                      WHEN '3' THEN 'L'
                                                      WHEN '4' THEN 'M'
                                                      WHEN '5' THEN 'N'
                                                      WHEN '6' THEN 'O'
                                                      WHEN '7' THEN 'P'
                                                      WHEN '8' THEN 'Q'
                                                      WHEN '9' THEN 'R'
                                                      WHEN '0' THEN '}'
                                                    END
                                        END, 14, '0') ||                                                                                -- ���� �հ�.
                                --> �ֹε�Ϲ�ȣ �����.
                                LPAD(0, 7, '0')  ||                                                                                     -- �ŷ�ó��.
                                LPAD(0, 7, '0')  ||                                                                                     -- ���ݰ�꼭 �ż�.
                                LPAD(0, 15, '0') ||                                                                                     -- ���ް��� �հ�.
                                LPAD(0, 14, '0') ||                                                                                     -- ���� �հ�.
                                RPAD(' ', 30, ' ')) OUTPUT
                        FROM
                            (
                              SELECT PX1.H_REGISTRATION_NUM
                                     , PX1.H_CORP_NAME
                                     , PX1.H_NAME
                                     , PX1.H_ADDRESS
                                     , PX1.VAT_REGISTRATION_NUM
                                     , PX1.VENDOR_NAME
                                     , COUNT(AIA.INVOICE_ID) AS VAT_CNT
                                     , SUM(PX1.SUPPLY_AMOUNT) AS SUPPLY_AMOUNT
                                     , SUM(PX1.TAX_AMOUNT) AS TAX_AMOUNT
                              FROM AP_INVOICES_ALL AIA,
                                   (
                                    SELECT
                                           HLA.GLOBAL_ATTRIBUTE1  H_REGISTRATION_NUM,
                                           HLA.LOCATION_CODE H_CORP_NAME,
                                           HLA.GLOBAL_ATTRIBUTE4 H_NAME,
                                           HLA.ADDRESS_LINE_1 H_ADDRESS,
                                           PV.VAT_REGISTRATION_NUM,
                                           NVL(PV.VENDOR_NAME_ALT, PV.VENDOR_NAME) VENDOR_NAME,
                                           AIA.INVOICE_ID,
                                           SUM(CASE
                                              WHEN AID.LINE_TYPE_LOOKUP_CODE IN('ITEM','FREIGHT') THEN NVL(AID.BASE_AMOUNT,AID.AMOUNT)
                                              ELSE 0
                                           END) AS SUPPLY_AMOUNT,
--                                           SUM(DECODE(AID.LINE_TYPE_LOOKUP_CODE,'ITEM',NVL(AID.BASE_AMOUNT,AID.AMOUNT))) AS SUPPLY_AMOUNT,
                                           SUM(DECODE(AID.LINE_TYPE_LOOKUP_CODE,'TAX' ,NVL(AID.BASE_AMOUNT,AID.AMOUNT))) AS TAX_AMOUNT
                                      FROM AP_INVOICES_ALL AIA,
                                        AP_INVOICE_DISTRIBUTIONS_ALL AID,
                                        AP_TAX_CODES_ALL ATC,
                                        PO_VENDORS PV,
                                        HR_LOCATIONS_ALL HLA
                                     WHERE AID.INVOICE_ID = AIA.INVOICE_ID
                                       AND AID.TAX_CODE_ID = ATC.TAX_ID
                                       AND PV.VENDOR_ID    = NVL(AIA.GLOBAL_ATTRIBUTE4,AIA.VENDOR_ID)
                                       AND HLA.LOCATION_ID = ATC.GLOBAL_ATTRIBUTE1
                                       AND ATC.VAT_TRANSACTION_TYPE IN ('INPUT_VAT','INPUT_OTHER')
                                       AND AIA.INVOICE_TYPE_LOOKUP_CODE <> 'PREPAYMENT'
                                       AND AID.LINE_TYPE_LOOKUP_CODE IN ('ITEM','TAX','FREIGHT')
                                       AND ATC.NAME NOT IN('���ݾ���')
                                       AND AID.TAX_CODE_ID IS NOT NULL
                                       AND AID.ACCOUNTING_EVENT_ID IS NOT NULL
                                       --AND AID.REVERSAL_FLAG IS NULL
                                       AND AIA.GLOBAL_ATTRIBUTE1 = 1
                                       AND PV.VAT_REGISTRATION_NUM IS NOT NULL
                                       AND AIA.CANCELLED_DATE IS NULL
                                       AND NVL(TO_DATE(AIA.GLOBAL_ATTRIBUTE3,'YYYY-MM-DD HH24:MI:SS'),AIA.GL_DATE) BETWEEN TO_DATE(P_START_DATE, 'YYYY-MM-DD HH24:MI:SS') AND TO_DATE(P_END_DATE, 'YYYY-MM-DD HH24:MI:SS')
                                       AND HLA.LOCATION_ID = P_HR_LOCATION
                                       AND EXISTS( SELECT 'X'
                                                                  FROM PO_VENDOR_SITES_ALL VS
                                                                  WHERE VS.VENDOR_SITE_ID = AIA.VENDOR_SITE_ID
                                                                  AND NVL(VS.GLOBAL_ATTRIBUTE12, '40') IN ('30', '40'))       -- ���� OR ���ݾ���.
                                    GROUP BY HLA.GLOBAL_ATTRIBUTE1,
                                           HLA.LOCATION_CODE,
                                           HLA.GLOBAL_ATTRIBUTE4,
                                           HLA.ADDRESS_LINE_1,
                                           PV.VAT_REGISTRATION_NUM,
                                           NVL(PV.VENDOR_NAME_ALT, PV.VENDOR_NAME),
                                           AIA.INVOICE_ID
                                   ) PX1
                              WHERE AIA.INVOICE_ID = PX1.INVOICE_ID
                              GROUP BY PX1.H_REGISTRATION_NUM
                                     , PX1.H_CORP_NAME
                                     , PX1.H_NAME
                                     , PX1.H_ADDRESS
                                     , PX1.VAT_REGISTRATION_NUM
                                     , PX1.VENDOR_NAME
                            ) A
                        GROUP BY REPLACE(A.H_REGISTRATION_NUM, '-', '')
                )
     LOOP
        FND_FILE.PUT_LINE(FND_FILE.OUTPUT, N1.OUTPUT);
     END LOOP N1;

/*************************************************************************************************/
/******        ���� ���ݰ�꼭 �̿ܺ� - ���� �� / ���� ����                                                                          ******/
/******        ���� ���ݰ�꼭 �� - ���� �� / ���� ����                                                                                ******/
/*************************************************************************************************/
/*====================================================*/
     /**       �����հ� - ���ڼ��ݰ�꼭 ��.                                          **/
     /*====================================================*/
     FOR N1 IN (
                       SELECT
                              ('5' ||
                              RPAD(REPLACE(O.O_TAX_REG, '-', ''), 10, ' ')  ||                                                     -- ������ �����ȣ.
                              -- �հ�
                              LPAD(COUNT(O.TAX_REG) + COUNT(P.P_REG_CNT), 7, '0')  ||                              -- �ŷ�ó ��.
                              LPAD(SUM(NVL(O_TAX_CNT, 0) + NVL(P.P_TAX_CNT, 0)), 7, '0')  ||                         -- ���ݰ�꼭 �ż�.
                              LPAD(SUM(NVL(O.O_REV_AMOUNT, 0) + NVL(P.P_REV_AMOUNT, 0)), 15, '0')  ||    -- ���ް���.
                              LPAD(SUM(NVL(O.O_TAX_AMOUNT, 0) + NVL(P.P_TAX_AMOUNT, 0)), 14, '0')  ||    -- ����.
                              -- ����ڹ�ȣ �����.
                              LPAD(COUNT(O.TAX_REG), 7, '0')  ||
                              LPAD(SUM(NVL(O_TAX_CNT, 0)), 7, '0')  ||
                              LPAD(CASE
                                          WHEN SUM(NVL(O.O_REV_AMOUNT, 0)) >= 0 THEN NVL(TO_CHAR(SUM(NVL(O.O_REV_AMOUNT, 0))), 0)
                                          ELSE SUBSTRB(REPLACE(TO_CHAR(SUM(NVL(O.O_REV_AMOUNT, 0))), '-', ''), 1, LENGTH(TO_CHAR(SUM(NVL(O.O_REV_AMOUNT, 0)))) - 2) ||
                                                    CASE SUBSTR(TO_CHAR(SUM(NVL(O.O_REV_AMOUNT, 0))), -1, 1)
                                                      WHEN '1' THEN 'J'
                                                      WHEN '2' THEN 'K'
                                                      WHEN '3' THEN 'L'
                                                      WHEN '4' THEN 'M'
                                                      WHEN '5' THEN 'N'
                                                      WHEN '6' THEN 'O'
                                                      WHEN '7' THEN 'P'
                                                      WHEN '8' THEN 'Q'
                                                      WHEN '9' THEN 'R'
                                                      WHEN '0' THEN '}'
                                                    END
                                       END, 15, '0') ||
                              LPAD(CASE
                                          WHEN SUM(NVL(O.O_TAX_AMOUNT, 0)) >= 0 THEN NVL(TO_CHAR(SUM(NVL(O.O_TAX_AMOUNT, 0))), 0)
                                          ELSE SUBSTRB(REPLACE(TO_CHAR(SUM(NVL(O.O_TAX_AMOUNT, 0))), '-', ''), 1, LENGTH(TO_CHAR(SUM(NVL(O.O_TAX_AMOUNT, 0)))) - 2) ||
                                                    CASE SUBSTR(TO_CHAR(SUM(NVL(O.O_TAX_AMOUNT, 0))), -1, 1)
                                                      WHEN '1' THEN 'J'
                                                      WHEN '2' THEN 'K'
                                                      WHEN '3' THEN 'L'
                                                      WHEN '4' THEN 'M'
                                                      WHEN '5' THEN 'N'
                                                      WHEN '6' THEN 'O'
                                                      WHEN '7' THEN 'P'
                                                      WHEN '8' THEN 'Q'
                                                      WHEN '9' THEN 'R'
                                                      WHEN '0' THEN '}'
                                                    END
                                      END, 14, '0') ||
                              -- �ֹι�ȣ �����.
                              LPAD(COUNT(P.P_REG_CNT), 7, '0')  ||
                              LPAD(SUM(NVL(P.P_TAX_CNT, 0)), 7, '0')  ||
                              LPAD(CASE
                                        WHEN SUM(NVL(P.P_REV_AMOUNT, 0)) >= 0 THEN NVL(TO_CHAR(SUM(NVL(P.P_REV_AMOUNT, 0))), 0)
                                        ELSE SUBSTRB(REPLACE(TO_CHAR(SUM(NVL(P.P_REV_AMOUNT, 0))), '-', ''), 1, LENGTH(TO_CHAR(SUM(NVL(P.P_REV_AMOUNT, 0)))) - 2) ||
                                                  CASE SUBSTR(TO_CHAR(SUM(NVL(P.P_REV_AMOUNT, 0))), -1, 1)
                                                    WHEN '1' THEN 'J'
                                                    WHEN '2' THEN 'K'
                                                    WHEN '3' THEN 'L'
                                                    WHEN '4' THEN 'M'
                                                    WHEN '5' THEN 'N'
                                                    WHEN '6' THEN 'O'
                                                    WHEN '7' THEN 'P'
                                                    WHEN '8' THEN 'Q'
                                                    WHEN '9' THEN 'R'
                                                    WHEN '0' THEN '}'
                                                  END
                                      END, 15, '0') ||
                              LPAD(CASE
                                        WHEN SUM(NVL(P.P_TAX_AMOUNT, 0)) >= 0 THEN NVL(TO_CHAR(SUM(NVL(P.P_TAX_AMOUNT, 0))), 0)
                                        ELSE SUBSTRB(REPLACE(TO_CHAR(SUM(NVL(P.P_TAX_AMOUNT, 0))), '-', ''), 1, LENGTH(TO_CHAR(SUM(NVL(P.P_TAX_AMOUNT, 0)))) - 2) ||
                                                  CASE SUBSTR(TO_CHAR(SUM(NVL(P.P_TAX_AMOUNT, 0))), -1, 1)
                                                    WHEN '1' THEN 'J'
                                                    WHEN '2' THEN 'K'
                                                    WHEN '3' THEN 'L'
                                                    WHEN '4' THEN 'M'
                                                    WHEN '5' THEN 'N'
                                                    WHEN '6' THEN 'O'
                                                    WHEN '7' THEN 'P'
                                                    WHEN '8' THEN 'Q'
                                                    WHEN '9' THEN 'R'
                                                    WHEN '0' THEN '}'
                                                  END
                                      END, 14, '0') ||
                              RPAD(' ', 30, ' ')) AS OUTPUT
                      FROM
                         (-- ��ü
                            SELECT
                                     HLA.GLOBAL_ATTRIBUTE1  O_TAX_REG
                                   , HLA.LOCATION_CODE O_LOCATION_CODE
                                   , HLA.GLOBAL_ATTRIBUTE4 O_GLOBAL_ATTRIBUTE4
                                   , HLA.ADDRESS_LINE_1 || ' ' || HLA.ADDRESS_LINE_2 O_ADDRESS
                                   , RC.TAX_REFERENCE TAX_REG
                                   , NVL(RC.CUSTOMER_NAME_PHONETIC, RC.CUSTOMER_NAME) AS O_CUSTOMER_NAME
                                   , COUNT(DISTINCT RCT.GLOBAL_ATTRIBUTE27) O_TAX_CNT
                                   , SUM(DECODE(DIST.ACCOUNT_CLASS,'REV',ACCTD_AMOUNT)) O_REV_AMOUNT
                                  , SUM(DECODE(DIST.ACCOUNT_CLASS,'TAX',ACCTD_AMOUNT)) O_TAX_AMOUNT
                              FROM GL_CODE_COMBINATIONS CC,
                                   RA_CUSTOMER_TRX_LINES_ALL RCTL,
                                   RA_CUSTOMER_TRX_ALL RCT,
                                   RA_CUST_TRX_LINE_GL_DIST_ALL DIST,
                                AR_VAT_TAX_ALL AVT,
                                RA_CUSTOMERS RC,
                                HR_LOCATIONS_ALL HLA
                             WHERE DIST.CUSTOMER_TRX_ID   = RCT.CUSTOMER_TRX_ID
                               AND DIST.CUSTOMER_TRX_LINE_ID = RCTL.CUSTOMER_TRX_LINE_ID(+)
                               AND DIST.CODE_COMBINATION_ID = CC.CODE_COMBINATION_ID
                               AND RCTL.VAT_TAX_ID = AVT.VAT_TAX_ID(+)
                               AND RC.CUSTOMER_ID = RCT.BILL_TO_CUSTOMER_ID
                               AND AVT.GLOBAL_ATTRIBUTE1 = HLA.LOCATION_ID(+)
                               AND DIST.ACCOUNT_CLASS <> 'REC'
                               AND RCT.COMPLETE_FLAG = 'Y'
                               AND RCTL.VAT_TAX_ID IS NOT NULL
                               AND RCT.GLOBAL_ATTRIBUTE27 IS NOT NULL
                               AND RC.PARTY_TYPE = 'ORGANIZATION'
                               AND AVT.VAT_TRANSACTION_TYPE IN ('OUTPUT_VAT','OUTPUT_EXEMPT')
                               AND TO_DATE(RCT.GLOBAL_ATTRIBUTE29, 'YYYY-MM-DD HH24:MI:SS') BETWEEN TO_DATE(P_START_DATE, 'YYYY-MM-DD HH24:MI:SS') AND TO_DATE(P_END_DATE, 'YYYY-MM-DD HH24:MI:SS')
                               AND HLA.LOCATION_ID = P_HR_LOCATION
                               AND EXISTS (SELECT 'X'
                                                      FROM HZ_CUST_ACCOUNTS CA    -- ATTRIBUTE12 AS TAX_ISSUE_TYPE
                                                      WHERE CA.CUST_ACCOUNT_ID = RCT.BILL_TO_CUSTOMER_ID
                                                        AND NVL(CA.ATTRIBUTE12, '30') IN ('10', '20'))                              -- ���� or ���� ����.
/*-- ��ȣ�� ����.                                                        
                               AND EXISTS (SELECT 'X'
                                                      FROM RA_CUSTOMER_TRX_ALL RCT1
                                                      WHERE RCT1.CUSTOMER_TRX_ID = RCT.CUSTOMER_TRX_ID
                                                        AND NVL(RCT1.GLOBAL_ATTRIBUTE23, '40') IN ('10', '20'))*/
                            GROUP BY HLA.GLOBAL_ATTRIBUTE1
                                   , HLA.LOCATION_CODE
                                   , HLA.GLOBAL_ATTRIBUTE4
                                   , HLA.ADDRESS_LINE_1 || ' ' || HLA.ADDRESS_LINE_2
                                   , RC.TAX_REFERENCE
                                   , NVL(RC.CUSTOMER_NAME_PHONETIC, RC.CUSTOMER_NAME)
                          ) O,
                          (-- ����
                            SELECT
                                     HLA.GLOBAL_ATTRIBUTE1 P_TAX_REG
                                   , COUNT(DISTINCT RC.customer_name) P_REG_CNT
                                   , COUNT(DISTINCT RCT.GLOBAL_ATTRIBUTE27) P_TAX_CNT
                                   , SUM(DECODE(DIST.ACCOUNT_CLASS,'REV',ACCTD_AMOUNT)) P_REV_AMOUNT
                            	     , SUM(DECODE(DIST.ACCOUNT_CLASS,'TAX',ACCTD_AMOUNT)) P_TAX_AMOUNT
                              FROM GL_CODE_COMBINATIONS CC,
                                   RA_CUSTOMER_TRX_LINES_ALL RCTL,
                                   RA_CUSTOMER_TRX_ALL RCT,
                                   RA_CUST_TRX_LINE_GL_DIST_ALL DIST,
                            	   AR_VAT_TAX_ALL AVT,
                            	   RA_CUSTOMERS RC,
                            	   HR_LOCATIONS_ALL HLA
                             WHERE DIST.CUSTOMER_TRX_ID   = RCT.CUSTOMER_TRX_ID
                               AND DIST.CUSTOMER_TRX_LINE_ID = RCTL.CUSTOMER_TRX_LINE_ID(+)
                               AND DIST.CODE_COMBINATION_ID = CC.CODE_COMBINATION_ID
                               AND RCTL.VAT_TAX_ID = AVT.VAT_TAX_ID(+)
                               AND RC.CUSTOMER_ID = RCT.BILL_TO_CUSTOMER_ID
                               AND AVT.GLOBAL_ATTRIBUTE1 = HLA.LOCATION_ID(+)
                               AND DIST.ACCOUNT_CLASS <> 'REC'
                               AND RCT.COMPLETE_FLAG = 'Y'
                               AND RCTL.VAT_TAX_ID IS NOT NULL
                               AND RCT.GLOBAL_ATTRIBUTE27 IS NOT NULL
                               AND RC.PARTY_TYPE = 'PERSON'
                               AND AVT.VAT_TRANSACTION_TYPE IN ('OUTPUT_VAT','OUTPUT_EXEMPT')
                               AND TO_DATE(RCT.GLOBAL_ATTRIBUTE29, 'YYYY-MM-DD HH24:MI:SS') BETWEEN TO_DATE(P_START_DATE, 'YYYY-MM-DD HH24:MI:SS') AND TO_DATE(P_END_DATE, 'YYYY-MM-DD HH24:MI:SS')
                               AND HLA.LOCATION_ID = P_HR_LOCATION
                               AND EXISTS (SELECT 'X'
                                                      FROM HZ_CUST_ACCOUNTS CA    -- ATTRIBUTE12 AS TAX_ISSUE_TYPE
                                                      WHERE CA.CUST_ACCOUNT_ID = RCT.BILL_TO_CUSTOMER_ID
                                                        AND NVL(CA.ATTRIBUTE12, '30') IN ('10', '20'))                              -- ���� or ���� ����.
/*-- ��ȣ�� ����.                                                        
                               AND EXISTS (SELECT 'X'
                                                      FROM RA_CUSTOMER_TRX_ALL RCT1
                                                      WHERE RCT1.CUSTOMER_TRX_ID = RCT.CUSTOMER_TRX_ID
                                                        AND NVL(RCT1.GLOBAL_ATTRIBUTE23, '40') IN ('10', '20'))*/
                            GROUP BY HLA.GLOBAL_ATTRIBUTE1
                          ) P
                      WHERE O.O_TAX_REG= P.P_TAX_REG(+)
                      GROUP BY O.O_TAX_REG
                      )
     LOOP
         FND_FILE.PUT_LINE(FND_FILE.OUTPUT, N1.OUTPUT);
     END LOOP N1;
    
      /*====================================================*/
     /**       �����հ� - ���ڼ��ݰ�꼭 ��.                                                **/
     /*====================================================*/
     FOR N1 IN (
                        SELECT
                                ('6'  ||
                                RPAD(REPLACE(A.H_REGISTRATION_NUM, '-', ''), 10, ' ') ||
                                --> �հ��.
                                LPAD(COUNT(A.VAT_REGISTRATION_NUM), 7, '0')  ||                            -- �ŷ�ó��.
                                LPAD(SUM(NVL(A.VAT_CNT, 0)), 7, '0')  ||                                               -- ���ݰ�꼭 �ż�.
                                LPAD(CASE
                                            WHEN SUM(NVL(A.SUPPLY_AMOUNT, 0)) >= 0 THEN NVL(TO_CHAR(SUM(NVL(A.SUPPLY_AMOUNT, 0))), 0)
                                            ELSE SUBSTRB(REPLACE(TO_CHAR(SUM(NVL(A.SUPPLY_AMOUNT, 0))), '-', ''), 1, LENGTH(TO_CHAR(SUM(NVL(A.SUPPLY_AMOUNT, 0)))) - 2) ||
                                                      CASE SUBSTR(TO_CHAR(SUM(NVL(A.SUPPLY_AMOUNT, 0))), -1, 1)
                                                        WHEN '1' THEN 'J'
                                                        WHEN '2' THEN 'K'
                                                        WHEN '3' THEN 'L'
                                                        WHEN '4' THEN 'M'
                                                        WHEN '5' THEN 'N'
                                                        WHEN '6' THEN 'O'
                                                        WHEN '7' THEN 'P'
                                                        WHEN '8' THEN 'Q'
                                                        WHEN '9' THEN 'R'
                                                        WHEN '0' THEN '}'
                                                      END
                                          END, 15, '0') ||                                                                                  -- ���ް��� �հ�.
                                LPAD(CASE
                                          WHEN SUM(NVL(A.TAX_AMOUNT, 0)) >= 0 THEN NVL(TO_CHAR(SUM(NVL(A.TAX_AMOUNT, 0))), 0)
                                          ELSE SUBSTRB(REPLACE(TO_CHAR(SUM(NVL(A.TAX_AMOUNT, 0))), '-', ''), 1, LENGTH(TO_CHAR(SUM(NVL(A.TAX_AMOUNT, 0)))) - 2) ||
                                                    CASE SUBSTR(TO_CHAR(SUM(NVL(A.TAX_AMOUNT, 0))), -1, 1)
                                                      WHEN '1' THEN 'J'
                                                      WHEN '2' THEN 'K'
                                                      WHEN '3' THEN 'L'
                                                      WHEN '4' THEN 'M'
                                                      WHEN '5' THEN 'N'
                                                      WHEN '6' THEN 'O'
                                                      WHEN '7' THEN 'P'
                                                      WHEN '8' THEN 'Q'
                                                      WHEN '9' THEN 'R'
                                                      WHEN '0' THEN '}'
                                                    END
                                        END, 14, '0') ||                                                                                -- ���� �հ�.
                                --> ����ڵ�Ϲ�ȣ �����.
                                LPAD(COUNT(A.VAT_REGISTRATION_NUM), 7, '0')  ||                            -- �ŷ�ó��.
                                LPAD(SUM(NVL(A.VAT_CNT, 0)), 7, '0')  ||                                               -- ���ݰ�꼭 �ż�.
                                LPAD(CASE
                                            WHEN SUM(NVL(A.SUPPLY_AMOUNT, 0)) >= 0 THEN NVL(TO_CHAR(SUM(NVL(A.SUPPLY_AMOUNT, 0))), 0)
                                            ELSE SUBSTRB(REPLACE(TO_CHAR(SUM(NVL(A.SUPPLY_AMOUNT, 0))), '-', ''), 1, LENGTH(TO_CHAR(SUM(NVL(A.SUPPLY_AMOUNT, 0)))) - 2) ||
                                                      CASE SUBSTR(TO_CHAR(SUM(NVL(A.SUPPLY_AMOUNT, 0))), -1, 1)
                                                        WHEN '1' THEN 'J'
                                                        WHEN '2' THEN 'K'
                                                        WHEN '3' THEN 'L'
                                                        WHEN '4' THEN 'M'
                                                        WHEN '5' THEN 'N'
                                                        WHEN '6' THEN 'O'
                                                        WHEN '7' THEN 'P'
                                                        WHEN '8' THEN 'Q'
                                                        WHEN '9' THEN 'R'
                                                        WHEN '0' THEN '}'
                                                      END
                                          END, 15, '0') ||                                                                                  -- ���ް��� �հ�.
                              LPAD(CASE
                                          WHEN SUM(NVL(A.TAX_AMOUNT, 0)) >= 0 THEN NVL(TO_CHAR(SUM(NVL(A.TAX_AMOUNT, 0))), 0)
                                          ELSE SUBSTRB(REPLACE(TO_CHAR(SUM(NVL(A.TAX_AMOUNT, 0))), '-', ''), 1, LENGTH(TO_CHAR(SUM(NVL(A.TAX_AMOUNT, 0)))) - 2) ||
                                                    CASE SUBSTR(TO_CHAR(SUM(NVL(A.TAX_AMOUNT, 0))), -1, 1)
                                                      WHEN '1' THEN 'J'
                                                      WHEN '2' THEN 'K'
                                                      WHEN '3' THEN 'L'
                                                      WHEN '4' THEN 'M'
                                                      WHEN '5' THEN 'N'
                                                      WHEN '6' THEN 'O'
                                                      WHEN '7' THEN 'P'
                                                      WHEN '8' THEN 'Q'
                                                      WHEN '9' THEN 'R'
                                                      WHEN '0' THEN '}'
                                                    END
                                        END, 14, '0') ||                                                                                -- ���� �հ�.
                                --> �ֹε�Ϲ�ȣ �����.
                                LPAD(0, 7, '0')  ||                                                                                     -- �ŷ�ó��.
                                LPAD(0, 7, '0')  ||                                                                                     -- ���ݰ�꼭 �ż�.
                                LPAD(0, 15, '0') ||                                                                                     -- ���ް��� �հ�.
                                LPAD(0, 14, '0') ||                                                                                     -- ���� �հ�.
                                RPAD(' ', 30, ' ')) OUTPUT
                        FROM
                            (
                              SELECT PX1.H_REGISTRATION_NUM
                                     , PX1.H_CORP_NAME
                                     , PX1.H_NAME
                                     , PX1.H_ADDRESS
                                     , PX1.VAT_REGISTRATION_NUM
                                     , PX1.VENDOR_NAME
                                     , COUNT(AIA.INVOICE_ID) AS VAT_CNT
                                     , SUM(PX1.SUPPLY_AMOUNT) AS SUPPLY_AMOUNT
                                     , SUM(PX1.TAX_AMOUNT) AS TAX_AMOUNT
                              FROM AP_INVOICES_ALL AIA,
                                   (
                                    SELECT
                                           HLA.GLOBAL_ATTRIBUTE1  H_REGISTRATION_NUM,
                                           HLA.LOCATION_CODE H_CORP_NAME,
                                           HLA.GLOBAL_ATTRIBUTE4 H_NAME,
                                           HLA.ADDRESS_LINE_1 H_ADDRESS,
                                           PV.VAT_REGISTRATION_NUM,
                                           NVL(PV.VENDOR_NAME_ALT, PV.VENDOR_NAME) VENDOR_NAME,
                                           AIA.INVOICE_ID,
                                           SUM(CASE
                                              WHEN AID.LINE_TYPE_LOOKUP_CODE IN('ITEM','FREIGHT') THEN NVL(AID.BASE_AMOUNT,AID.AMOUNT)
                                              ELSE 0
                                           END) AS SUPPLY_AMOUNT,
--                                           SUM(DECODE(AID.LINE_TYPE_LOOKUP_CODE,'ITEM',NVL(AID.BASE_AMOUNT,AID.AMOUNT))) AS SUPPLY_AMOUNT,
                                           SUM(DECODE(AID.LINE_TYPE_LOOKUP_CODE,'TAX' ,NVL(AID.BASE_AMOUNT,AID.AMOUNT))) AS TAX_AMOUNT
                                      FROM AP_INVOICES_ALL AIA,
                                        AP_INVOICE_DISTRIBUTIONS_ALL AID,
                                        AP_TAX_CODES_ALL ATC,
                                        PO_VENDORS PV,
                                        HR_LOCATIONS_ALL HLA
                                     WHERE AID.INVOICE_ID = AIA.INVOICE_ID
                                       AND AID.TAX_CODE_ID = ATC.TAX_ID
                                       AND PV.VENDOR_ID    = NVL(AIA.GLOBAL_ATTRIBUTE4,AIA.VENDOR_ID)
                                       AND HLA.LOCATION_ID = ATC.GLOBAL_ATTRIBUTE1
                                       AND ATC.VAT_TRANSACTION_TYPE IN ('INPUT_VAT','INPUT_OTHER')
                                       AND AIA.INVOICE_TYPE_LOOKUP_CODE <> 'PREPAYMENT'
                                       AND AID.LINE_TYPE_LOOKUP_CODE IN ('ITEM','TAX','FREIGHT')
                                       AND ATC.NAME NOT IN('���ݾ���')
                                       AND AID.TAX_CODE_ID IS NOT NULL
                                       AND AID.ACCOUNTING_EVENT_ID IS NOT NULL
                                       --AND AID.REVERSAL_FLAG IS NULL
                                       AND AIA.GLOBAL_ATTRIBUTE1 = 1
                                       AND PV.VAT_REGISTRATION_NUM IS NOT NULL
                                       AND AIA.CANCELLED_DATE IS NULL
                                       AND NVL(TO_DATE(AIA.GLOBAL_ATTRIBUTE3,'YYYY-MM-DD HH24:MI:SS'),AIA.GL_DATE) BETWEEN TO_DATE(P_START_DATE, 'YYYY-MM-DD HH24:MI:SS') AND TO_DATE(P_END_DATE, 'YYYY-MM-DD HH24:MI:SS')
                                       AND HLA.LOCATION_ID = P_HR_LOCATION
                                       AND EXISTS( SELECT 'X'
                                                                  FROM PO_VENDOR_SITES_ALL VS
                                                                  WHERE VS.VENDOR_SITE_ID = AIA.VENDOR_SITE_ID
                                                                  AND NVL(VS.GLOBAL_ATTRIBUTE12, '40') IN ('10', '20'))       -- ���ڼ��ݰ�꼭..
                                    GROUP BY HLA.GLOBAL_ATTRIBUTE1,
                                           HLA.LOCATION_CODE,
                                           HLA.GLOBAL_ATTRIBUTE4,
                                           HLA.ADDRESS_LINE_1,
                                           PV.VAT_REGISTRATION_NUM,
                                           NVL(PV.VENDOR_NAME_ALT, PV.VENDOR_NAME),
                                           AIA.INVOICE_ID
                                   ) PX1
                              WHERE AIA.INVOICE_ID = PX1.INVOICE_ID
                              GROUP BY PX1.H_REGISTRATION_NUM
                                     , PX1.H_CORP_NAME
                                     , PX1.H_NAME
                                     , PX1.H_ADDRESS
                                     , PX1.VAT_REGISTRATION_NUM
                                     , PX1.VENDOR_NAME
                            ) A
                        GROUP BY REPLACE(A.H_REGISTRATION_NUM, '-', '')
                )
     LOOP
        FND_FILE.PUT_LINE(FND_FILE.OUTPUT, N1.OUTPUT);
     END LOOP N1;
/*************************************************************************************************/
/******        ���ڼ��ݰ�꼭 ����� �հ� ����                                                                                           ******/
/*************************************************************************************************/

FND_FILE.PUT_LINE(FND_FILE.OUTPUT, '*************************************************************************************************');
FND_FILE.PUT_LINE(FND_FILE.OUTPUT, '****** �޸��忡 ���� ������ �Ʒ� ���ϸ����� ������ �Ű��ϼ���') ;
FND_FILE.PUT_LINE(FND_FILE.OUTPUT, '****** FILE �� :[ K' || SUBSTR(V_LOCATION_REG_NUM, 1, 7) || '.' || SUBSTR(V_LOCATION_REG_NUM, 8, 3)  || ' ] ') ;
FND_FILE.PUT_LINE(FND_FILE.OUTPUT, '*************************************************************************************************');

END IFC_TAX_VAT_FILE_2010_1;
/
