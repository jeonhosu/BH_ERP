CREATE OR REPLACE PACKAGE HRW_WITHHOLDING_FILE_G
AS

-- ��õ¡�������Ȳ�Ű� �����ü �ۼ� ����.
  PROCEDURE MAIN_WITHHOLDING
            ( P_CURSOR1               OUT TYPES.TCURSOR1
            , P_WITHHOLDING_DOC_ID    IN HRW_WITHHOLDING_DOC.WITHHOLDING_DOC_ID%TYPE
            , P_SOB_ID                IN HRW_WITHHOLDING_DOC.SOB_ID%TYPE
            , P_ORG_ID                IN HRW_WITHHOLDING_DOC.ORG_ID%TYPE
            );

-- �����ü �ۼ�.
  PROCEDURE SET_FILE1
            ( P_WITHHOLDING_DOC_ID    IN HRW_WITHHOLDING_DOC.WITHHOLDING_DOC_ID%TYPE
            , P_SOB_ID                IN HRW_WITHHOLDING_DOC.SOB_ID%TYPE
            , P_ORG_ID                IN HRW_WITHHOLDING_DOC.ORG_ID%TYPE
            , O_STATUS                OUT VARCHAR2
            , O_MESSAGE               OUT VARCHAR2
            );

-------------------------------------------------------------------------------
-- ���� DATA INSERT.
-------------------------------------------------------------------------------
  PROCEDURE INSERT_REPORT_FILE
            ( P_SEQ_NUM           IN NUMBER
            , P_SOURCE_FILE       IN VARCHAR2
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , P_REPORT_FILE       IN VARCHAR2
            , P_SORT_NUM          IN NUMBER
            );

-------------------------------------------------------------------------------
-- ���� ��ȣȭ ��й�ȣ ��ȸ
-------------------------------------------------------------------------------
  PROCEDURE GET_ENCRYPT_PWD
            ( P_CORP_ID           IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , O_ENCRYPT_PWD       OUT VARCHAR2
            );
                        
END HRW_WITHHOLDING_FILE_G;
/
CREATE OR REPLACE PACKAGE BODY HRW_WITHHOLDING_FILE_G
AS
/******************************************************************************/
/* PROJECT      : FPCB ERP
/* MODULE       : EAPP
/* PROGRAM NAME : HRW_WITHHOLDING_FILE_G
/* DESCRIPTION  : ��õ¡�������Ȳ�Ű� �����ü ����.
/* REFERENCE BY :
/* PROGRAM HISTORY :
/*------------------------------------------------------------------------------
/*   DATE       IN CHARGE          DESCRIPTION
/*------------------------------------------------------------------------------
/* 20-JUN-2010  JEON HO SU          INITIALIZE
/******************************************************************************/
-- ��õ¡�������Ȳ�Ű� �����ü �ۼ� ����.
  PROCEDURE MAIN_WITHHOLDING
            ( P_CURSOR1               OUT TYPES.TCURSOR1
            , P_WITHHOLDING_DOC_ID    IN HRW_WITHHOLDING_DOC.WITHHOLDING_DOC_ID%TYPE
            , P_SOB_ID                IN HRW_WITHHOLDING_DOC.SOB_ID%TYPE
            , P_ORG_ID                IN HRW_WITHHOLDING_DOC.ORG_ID%TYPE
            )
  AS
    V_SYSDATE                 DATE := GET_LOCAL_DATE(P_SOB_ID);
    V_STATUS                  VARCHAR2(2) := 'F';
    V_MESSAGE                 VARCHAR2(300);
  BEGIN
/*    -- ���� ���� üũ.
    IF HRW_WITHHOLDING_SET_G.CLOSED_WITHHOLDING_YN(P_WITHHOLDING_DOC_ID) <> 'Y' THEN
      -- ����ó�� ���� ���� �ڷ�� FILE ���� ����.
      RAISE_APPLICATION_ERROR(-20001, '�ش� ��õ¡�������Ȳ�Ű��� �������� �ʾҽ��ϴ�. ���� �� �ٽ� �����ϼ���');
      RETURN;
    END IF;*/
    
    -- �����ڷ� ����;
    DELETE FROM HRM_REPORT_FILE_GT;
    
    -- �ڷ� ����;
    SET_FILE1
      ( P_WITHHOLDING_DOC_ID    => P_WITHHOLDING_DOC_ID
      , P_SOB_ID                => P_SOB_ID
      , P_ORG_ID                => P_ORG_ID
      , O_STATUS                => V_STATUS
      , O_MESSAGE               => V_MESSAGE
      );
      
    OPEN P_CURSOR1 FOR
      SELECT RF.REPORT_FILE
        FROM HRM_REPORT_FILE_GT RF
      WHERE RF.SOB_ID             = P_SOB_ID
        AND RF.ORG_ID             = P_ORG_ID
        AND RF.SEQ_NUM            IS NOT NULL
      ORDER BY RF.SEQ_NUM, RF.SORT_NUM
      ;
      
  END MAIN_WITHHOLDING;

-- �����ü �ۼ�.
  PROCEDURE SET_FILE1
            ( P_WITHHOLDING_DOC_ID    IN HRW_WITHHOLDING_DOC.WITHHOLDING_DOC_ID%TYPE
            , P_SOB_ID                IN HRW_WITHHOLDING_DOC.SOB_ID%TYPE
            , P_ORG_ID                IN HRW_WITHHOLDING_DOC.ORG_ID%TYPE
            , O_STATUS                OUT VARCHAR2
            , O_MESSAGE               OUT VARCHAR2
            )
  AS
    V_SEQ_NUM                   NUMBER := 0;
    V_SOURCE_FILE               VARCHAR2(400); 
    
    V_VAT_NUMBER                VARCHAR2(20);     -- ����ڹ�ȣ.                     
  BEGIN
    O_STATUS := 'F';
    BEGIN
      SELECT REPLACE(OU.VAT_NUMBER, '-', '') AS VAT_NUMBER
        INTO V_VAT_NUMBER
        FROM HRM_OPERATING_UNIT OU
      WHERE OU.SOB_ID             = P_SOB_ID
        AND OU.ORG_ID             = P_ORG_ID
        AND EXISTS
              ( SELECT 'X'
                  FROM HRW_WITHHOLDING_DOC WD
                WHERE WD.CORP_ID            = OU.CORP_ID
                  AND WD.WITHHOLDING_DOC_ID = P_WITHHOLDING_DOC_ID
              )
        AND (OU.DEFAULT_FLAG      = 'Y'
          OR (OU.DEFAULT_FLAG     = 'N'
          AND ROWNUM              <= 1))
      ;
    EXCEPTION WHEN OTHERS THEN
      O_MESSAGE := '����ڹ�ȣ ��ȸ �����Դϴ�. Ȯ���ϼ���';
      RETURN;
    END;
    FOR C1 IN ( SELECT  --> HEADER <--
                        '21'                             -- �ڷᱸ��;
                     || 'O201'                          -- �����ڵ�;
                     || RPAD(V_VAT_NUMBER, 13, ' ')     -- ������ID;
                     || '14'                            -- ���񱸺�;
                     || CASE
                          WHEN WD.WITHHOLDING_TYPE = '1' THEN '1'
                          WHEN WD.WITHHOLDING_TYPE = '2' THEN '2'
                          WHEN WD.WITHHOLDING_TYPE = '3' THEN '5'
                        END                             -- �Ű���;
                     || '8'                             -- �����ڱ���;
                     || RPAD(TO_CHAR(WD.SUBMIT_DATE, 'YYYYMM'), 6, ' ')   -- ���⿬��;
                     || RPAD(REPLACE(WD.PAY_YYYYMM, '-', ''), 6, ' ')     -- ���޿���;
                     || RPAD(REPLACE(WD.STD_YYYYMM, '-', ''), 6, ' ')     -- �ͼӿ���;
                     || RPAD(HI.HOMETAX_ID, 20, ' ')                      -- �����ID;
                     || RPAD(' ', 30 ,' ')                                -- �����븮�μ���;
                     || RPAD(' ', 6, ' ')                                 -- �����븮�ΰ�����ȣ;
                     || RPAD(' ', 14, ' ')                                -- �����븮����ȭ��ȣ;
                     || RPAD(CM.CORP_NAME, 30, ' ')                       -- ���θ�(��ȣ);
                     || RPAD(CM.ADDR1 || ' ' || CM.ADDR2, 70, ' ')        -- ����������;
                     || RPAD(CM.TEL_NUMBER, 14, ' ')                      -- �������ȭ��ȣ;
                     || RPAD(CM.PRESIDENT_NAME, 30, ' ')                  -- ����(��ǥ�ڸ�);
                     || CASE
                          WHEN WD.MONTHLY_YN = 'Y' THEN '1'
                          WHEN WD.HALF_YEARLY_YN = 'Y' THEN '2'
                        END                                               -- ��õ�Ű���.
                     || RPAD(' ', 10, ' ')                                -- �����븮�λ���ڹ�ȣ;
                     || RPAD(' ', 4, ' ')                                 -- �ͼӳ⵵(��ǥ÷�νø� �ۼ�);
                     || RPAD(' ', 1, ' ')                                 -- �Ű���ǥ����;
                     || CASE
                          WHEN NVL(WD.A04_PERSON_CNT, 0) > 0 THEN 'Y'
                          WHEN NVL(WD.A26_PERSON_CNT, 0) > 0 THEN 'Y'
                          WHEN NVL(WD.A46_PERSON_CNT, 0) > 0 THEN 'Y'
                          ELSE 'N'
                        END                                               -- �������꿩��;
                     || TO_CHAR(SYSDATE, 'YYYYMMDD')                      -- �ۼ�����;
                     || '9000'                                            -- �������α׷��ڵ�;
                     || RPAD(NVL(CM.EMAIL, ' '), 50, ' ')                 -- �̸���;
                     || RPAD(WD.INCOME_DISPOSED_YN, 1, 'N')               -- �ҵ�ó�п���;
                     || 'N'                                               -- ȯ�޽�û����;
                     || RPAD(' ', 3, ' ')                                 -- ����ó;
                     || RPAD(' ', 20, ' ')                                -- ���¹�ȣ;
                     || 'N'                                               -- �����̿�ȯ�޼��׽°������;
                     || 'N'                                               -- �ⳳ�μ��׸������⿩��;
                     || RPAD(' ', 19, ' ')                                -- ����;
                        AS H_RECORD_FILE
                        
                     --> ��õ¡�������Ȳ�Ű� <--
                     ,  '27'                                              -- �ڷᱸ��.
                     || 'O201'                                            -- �����ڵ�.
                     || LPAD(NVL(WD.RECEIVE_REFUND_TAX_AMT, 0), 15, '0')  -- ������ȯ�޼���.
                     || LPAD(NVL(WD.ALREADY_REFUND_TAX_AMT, 0), 15, '0')  -- ��ȯ�޼���û����.
                     || LPAD(NVL(WD.REFUND_BALANCE_AMT, 0), 15, '0')      -- �������ܾ�(��õ).
                     || LPAD(NVL(WD.GENERAL_REFUND_AMT, 0), 15, '0')      -- �Ϲ�ȯ�޼���.
                     || LPAD(NVL(WD.FINANCIAL_AMT, 0), 15, '0')           -- ��Ź��꼼��.
                     || LPAD(NVL(WD.ADJUST_REFUND_TAX_AMT, 0), 15, '0')   -- �������ȯ�޼���.
                     || LPAD(NVL(WD.THIS_ADJUST_REFUND_TAX_AMT ,0), 15, '0') -- �������ȯ�޼���.
                     || LPAD(NVL(WD.NEXT_REFUND_TAX_AMT, 0), 15, '0')     -- �����̿�ȯ�޼���.
                     || 'N'                                               -- �ϰ����ο���.
                     || LPAD(NVL(WD.ETC_REFUND_FINANCIAL_AMT, 0), 15, '0')   -- �׹��� ȯ�޼��� ����ȸ���.
                     || LPAD(NVL(WD.REQUEST_REFUND_TAX_AMT, 0), 15, '0')  -- ȯ�޽�û��.
                     || 'N'                                               -- ����ڴ�����������.
                     || LPAD(NVL(WD.ETC_REFUND_MERGER_AMT, 0), 15, '0')   -- �׹��� ȯ�޼��� �պ���.
                     || RPAD(' ', 7, ' ')                                 -- ����.
                        AS B_RECORD_FILE
                        
                     --> ��õ¡�������Ȳ�Ű�-����<--
                     ,  '28'                                              -- �ڷᱸ��.
                     || 'O201'                                            -- �����ڵ�.
                     || 'A01'                                             -- ��õ�����ڵ�.
                     || LPAD(NVL(WD.A01_PERSON_CNT, 0), 15, '0')          -- �ο�.
                     || LPAD(NVL(WD.A01_PAYMENT_AMT, 0), 15, '0')         -- �����޾�.
                     || LPAD(NVL(WD.A01_INCOME_TAX_AMT, 0), 15, '0')      -- ¡������(�ҵ漼��).
                     || LPAD(NVL(WD.A01_SP_TAX_AMT, 0), 15, '0')          -- ¡������(��Ư��).
                     || LPAD(NVL(WD.A01_ADD_TAX_AMT, 0), 15, '0')         -- ���꼼.
                     || LPAD(0, 15, '0')                                  -- �������ȯ�޼���.
                     || LPAD(0, 15, '0')                                  -- ���μ���(�ҵ漼��).
                     || LPAD(0, 15, '0')                                  -- ���μ���(��Ư��).
                     || RPAD(' ', 21, ' ')                                -- ����.
                       AS A01_RECORD_FILE
                       
                     ,  '28'                                              -- �ڷᱸ��.
                     || 'O201'                                            -- �����ڵ�.
                     || 'A02'                                             -- ��õ�����ڵ�.
                     || LPAD(NVL(WD.A02_PERSON_CNT, 0), 15, '0')          -- �ο�.
                     || LPAD(NVL(WD.A02_PAYMENT_AMT, 0), 15, '0')         -- �����޾�.
                     || CASE
                          WHEN NVL(WD.A02_INCOME_TAX_AMT, 0) < 0 THEN
                            '-' || LPAD(ABS(NVL(WD.A02_INCOME_TAX_AMT, 0)), 14, '0')
                          ELSE LPAD(NVL(WD.A02_INCOME_TAX_AMT, 0), 15, '0')
                        END                                               -- ¡������(�ҵ漼��).                          
                     || CASE
                          WHEN NVL(WD.A02_SP_TAX_AMT, 0) < 0 THEN
                            '-' || LPAD(ABS(NVL(WD.A02_SP_TAX_AMT, 0)), 14, '0')
                          ELSE LPAD(NVL(WD.A02_SP_TAX_AMT, 0), 15, '0')
                        END                                               -- ¡������(��Ư��).
                     || LPAD(NVL(WD.A02_ADD_TAX_AMT, 0), 15, '0')         -- ���꼼.
                     || LPAD(0, 15, '0')                                  -- �������ȯ�޼���.
                     || LPAD(0, 15, '0')                                  -- ���μ���(�ҵ漼��).
                     || LPAD(0, 15, '0')                                  -- ���μ���(��Ư��).
                     || RPAD(' ', 21, ' ')                                -- ����.
                       AS A02_RECORD_FILE
                       
                     ,  '28'                                              -- �ڷᱸ��.
                     || 'O201'                                            -- �����ڵ�.
                     || 'A03'                                             -- ��õ�����ڵ�.
                     || LPAD(NVL(WD.A03_PERSON_CNT, 0), 15, '0')          -- �ο�.
                     || LPAD(NVL(WD.A03_PAYMENT_AMT, 0), 15, '0')         -- �����޾�.
                     || LPAD(NVL(WD.A03_INCOME_TAX_AMT, 0), 15, '0')      -- ¡������(�ҵ漼��).
                     || LPAD(0, 15, '0')                                  -- ¡������(��Ư��).
                     || LPAD(NVL(WD.A03_ADD_TAX_AMT, 0), 15, '0')         -- ���꼼.
                     || LPAD(0, 15, '0')                                  -- �������ȯ�޼���.
                     || LPAD(0, 15, '0')                                  -- ���μ���(�ҵ漼��).
                     || LPAD(0, 15, '0')                                  -- ���μ���(��Ư��).
                     || RPAD(' ', 21, ' ')                                -- ����.
                       AS A03_RECORD_FILE
                       
                     ,  '28'                                              -- �ڷᱸ��.
                     || 'O201'                                            -- �����ڵ�.
                     || 'A04'                                             -- ��õ�����ڵ�.
                     || LPAD(NVL(WD.A04_PERSON_CNT, 0), 15, '0')          -- �ο�.
                     || LPAD(NVL(WD.A04_PAYMENT_AMT, 0), 15, '0')         -- �����޾�.
                     || CASE
                          WHEN NVL(WD.A04_INCOME_TAX_AMT, 0) < 0 THEN
                            '-' || LPAD(ABS(NVL(WD.A04_INCOME_TAX_AMT, 0)), 14, '0')
                          ELSE LPAD(NVL(WD.A04_INCOME_TAX_AMT, 0), 15, '0')
                        END                                               -- ¡������(�ҵ漼��).
                     || CASE
                          WHEN NVL(WD.A04_SP_TAX_AMT, 0) < 0 THEN
                            '-' || LPAD(ABS(NVL(WD.A04_SP_TAX_AMT, 0)), 14, '0')
                          ELSE LPAD(NVL(WD.A04_SP_TAX_AMT, 0), 15, '0')
                        END                                               -- ¡������(��Ư��).
                     || LPAD(NVL(WD.A04_ADD_TAX_AMT, 0), 15, '0')         -- ���꼼.
                     || LPAD(0, 15, '0')                                  -- �������ȯ�޼���.
                     || LPAD(0, 15, '0')                                  -- ���μ���(�ҵ漼��).
                     || LPAD(0, 15, '0')                                  -- ���μ���(��Ư��).
                     || RPAD(' ', 21, ' ')                                -- ����.
                       AS A04_RECORD_FILE
                       
                     ,  '28'                                              -- �ڷᱸ��.
                     || 'O201'                                            -- �����ڵ�.
                     || 'A10'                                             -- ��õ�����ڵ�.
                     || LPAD(NVL(WD.A10_PERSON_CNT, 0), 15, '0')          -- �ο�.
                     || LPAD(NVL(WD.A10_PAYMENT_AMT, 0), 15, '0')         -- �����޾�.
                     || CASE
                          WHEN NVL(WD.A10_INCOME_TAX_AMT, 0) < 0 THEN
                            '-' || LPAD(ABS(NVL(WD.A10_INCOME_TAX_AMT, 0)), 14, '0')
                          ELSE LPAD(NVL(WD.A10_INCOME_TAX_AMT, 0), 15, '0')
                        END                                               -- ¡������(�ҵ漼��).                      
                     || CASE
                          WHEN NVL(WD.A10_SP_TAX_AMT, 0) < 0 THEN
                            '-' || LPAD(ABS(NVL(WD.A10_SP_TAX_AMT, 0)), 14, '0')
                          ELSE LPAD(NVL(WD.A10_SP_TAX_AMT, 0), 15, '0')
                        END                                               -- ¡������(��Ư��).
                     || CASE
                          WHEN NVL(WD.A10_ADD_TAX_AMT, 0) < 0 THEN
                            '-' || LPAD(ABS(NVL(WD.A10_ADD_TAX_AMT, 0)), 14, '0')
                          ELSE LPAD(NVL(WD.A10_ADD_TAX_AMT, 0), 15, '0')
                        END                                               -- ���꼼.
                     || CASE
                          WHEN NVL(WD.A10_THIS_REFUND_TAX_AMT, 0) < 0 THEN 
                            '-' || LPAD(ABS(NVL(WD.A10_THIS_REFUND_TAX_AMT, 0)), 14, '0')     
                          ELSE LPAD(NVL(WD.A10_THIS_REFUND_TAX_AMT, 0), 15, '0')
                        END                                               -- �������ȯ�޼���.
                     || CASE
                          WHEN NVL(WD.A10_PAY_INCOME_TAX_AMT, 0) < 0 THEN 
                            '-' || LPAD(ABS(NVL(WD.A10_PAY_INCOME_TAX_AMT, 0)), 14, '0')     
                          ELSE LPAD(NVL(WD.A10_PAY_INCOME_TAX_AMT, 0), 15, '0')
                        END                                               -- ���μ���(�ҵ漼��).
                     || CASE
                          WHEN NVL(WD.A10_PAY_SP_TAX_AMT, 0) < 0 THEN 
                            '-' || LPAD(ABS(NVL(WD.A10_PAY_SP_TAX_AMT, 0)), 14, '0')     
                          ELSE LPAD(NVL(WD.A10_PAY_SP_TAX_AMT, 0), 15, '0')
                        END                                               -- ���μ���(��Ư��).
                     || RPAD(' ', 21, ' ')                                -- ����.
                       AS A10_RECORD_FILE
                       
                     ,  '28'                                              -- �ڷᱸ��.
                     || 'O201'                                            -- �����ڵ�.
                     || 'A20'                                             -- ��õ�����ڵ�.
                     || LPAD(NVL(WD.A20_PERSON_CNT, 0), 15, '0')          -- �ο�.
                     || LPAD(NVL(WD.A20_PAYMENT_AMT, 0), 15, '0')         -- �����޾�.
                     || CASE
                          WHEN NVL(WD.A20_INCOME_TAX_AMT, 0) < 0 THEN
                            '-' || LPAD(ABS(NVL(WD.A20_INCOME_TAX_AMT, 0)), 14, '0')
                          ELSE LPAD(NVL(WD.A20_INCOME_TAX_AMT, 0), 15, '0')
                        END                                               -- ¡������(�ҵ漼��).
                     || LPAD(0, 15, '0')                                  -- ¡������(��Ư��).
                     || LPAD(NVL(WD.A20_ADD_TAX_AMT, 0), 15, '0')         -- ���꼼.
                     || LPAD(NVL(WD.A20_THIS_REFUND_TAX_AMT, 0), 15, '0') -- �������ȯ�޼���.
                     || LPAD(NVL(WD.A20_PAY_INCOME_TAX_AMT, 0), 15, '0')  -- ���μ���(�ҵ漼��).
                     || LPAD(0, 15, '0')                                  -- ���μ���(��Ư��).
                     || RPAD(' ', 21, ' ')                                -- ����.
                       AS A20_RECORD_FILE
                       
                     ,  '28'                                              -- �ڷᱸ��.
                     || 'O201'                                            -- �����ڵ�.
                     || 'A21'                                             -- ��õ�����ڵ�(�����ҵ濬�ݰ���).
                     || LPAD(NVL(WD.A21_PERSON_CNT, 0), 15, '0')          -- �ο�.
                     || LPAD(NVL(WD.A21_PAYMENT_AMT, 0), 15, '0')         -- �����޾�.
                     || CASE
                          WHEN NVL(WD.A21_INCOME_TAX_AMT, 0) < 0 THEN
                            '-' || LPAD(ABS(NVL(WD.A21_INCOME_TAX_AMT, 0)), 14, '0')
                          ELSE LPAD(NVL(WD.A21_INCOME_TAX_AMT, 0), 15, '0')
                        END                                               -- ¡������(�ҵ漼��).
                     || LPAD(0, 15, '0')                                  -- ¡������(��Ư��).
                     || LPAD(NVL(WD.A21_ADD_TAX_AMT, 0), 15, '0')         -- ���꼼.
                     || LPAD(NVL(WD.A21_THIS_REFUND_TAX_AMT, 0), 15, '0') -- �������ȯ�޼���.
                     || LPAD(NVL(WD.A21_PAY_INCOME_TAX_AMT, 0), 15, '0')  -- ���μ���(�ҵ漼��).
                     || LPAD(0, 15, '0')                                  -- ���μ���(��Ư��).
                     || RPAD(' ', 21, ' ')                                -- ����.
                       AS A21_RECORD_FILE
                       
                     ,  '28'                                              -- �ڷᱸ��.
                     || 'O201'                                            -- �����ڵ�.
                     || 'A22'                                             -- ��õ�����ڵ�(�����ҵ濬�ݰ��� �̿�).
                     || LPAD(NVL(WD.A22_PERSON_CNT, 0), 15, '0')          -- �ο�.
                     || LPAD(NVL(WD.A22_PAYMENT_AMT, 0), 15, '0')         -- �����޾�.
                     || CASE
                          WHEN NVL(WD.A22_INCOME_TAX_AMT, 0) < 0 THEN
                            '-' || LPAD(ABS(NVL(WD.A22_INCOME_TAX_AMT, 0)), 14, '0')
                          ELSE LPAD(NVL(WD.A22_INCOME_TAX_AMT, 0), 15, '0')
                        END                                               -- ¡������(�ҵ漼��).
                     || LPAD(0, 15, '0')                                  -- ¡������(��Ư��).
                     || LPAD(NVL(WD.A22_ADD_TAX_AMT, 0), 15, '0')         -- ���꼼.
                     || LPAD(NVL(WD.A22_THIS_REFUND_TAX_AMT, 0), 15, '0') -- �������ȯ�޼���.
                     || LPAD(NVL(WD.A22_PAY_INCOME_TAX_AMT, 0), 15, '0')  -- ���μ���(�ҵ漼��).
                     || LPAD(0, 15, '0')                                  -- ���μ���(��Ư��).
                     || RPAD(' ', 21, ' ')                                -- ����.
                       AS A22_RECORD_FILE  
                       
                     ,  '28'                                              -- �ڷᱸ��.
                     || 'O201'                                            -- �����ڵ�.
                     || 'A25'                                             -- ��õ�����ڵ�.
                     || LPAD(NVL(WD.A25_PERSON_CNT, 0), 15, '0')          -- �ο�.
                     || LPAD(NVL(WD.A25_PAYMENT_AMT, 0), 15, '0')         -- �����޾�.
                     || LPAD(NVL(WD.A25_INCOME_TAX_AMT, 0), 15, '0')      -- ¡������(�ҵ漼��).
                     || LPAD(0, 15, '0')                                  -- ¡������(��Ư��).
                     || LPAD(NVL(WD.A25_ADD_TAX_AMT, 0), 15, '0')         -- ���꼼.
                     || LPAD(0, 15, '0')                                  -- �������ȯ�޼���.
                     || LPAD(0, 15, '0')                                  -- ���μ���(�ҵ漼��).
                     || LPAD(0, 15, '0')                                  -- ���μ���(��Ư��).
                     || RPAD(' ', 21, ' ')                                -- ����.
                       AS A25_RECORD_FILE
                       
                     ,  '28'                                              -- �ڷᱸ��.
                     || 'O201'                                            -- �����ڵ�.
                     || 'A26'                                             -- ��õ�����ڵ�.
                     || LPAD(NVL(WD.A26_PERSON_CNT, 0), 15, '0')          -- �ο�.
                     || LPAD(NVL(WD.A26_PAYMENT_AMT, 0), 15, '0')         -- �����޾�.
                     || CASE
                          WHEN NVL(WD.A26_INCOME_TAX_AMT, 0) < 0 THEN
                            '-' || LPAD(ABS(NVL(WD.A26_INCOME_TAX_AMT, 0)), 14, '0')
                          ELSE LPAD(NVL(WD.A26_INCOME_TAX_AMT, 0), 15, '0')
                        END                                               -- ¡������(�ҵ漼��).
                     || CASE
                          WHEN NVL(WD.A26_SP_TAX_AMT, 0) < 0 THEN
                            '-' || LPAD(ABS(NVL(WD.A26_SP_TAX_AMT, 0)), 14, '0')
                          ELSE LPAD(NVL(WD.A26_SP_TAX_AMT, 0), 15, '0')
                        END                                               -- ¡������(��Ư��).
                     || LPAD(NVL(WD.A26_ADD_TAX_AMT, 0), 15, '0')         -- ���꼼.
                     || LPAD(0, 15, '0')                                  -- �������ȯ�޼���.
                     || LPAD(0, 15, '0')                                  -- ���μ���(�ҵ漼��).
                     || LPAD(0, 15, '0')                                  -- ���μ���(��Ư��).
                     || RPAD(' ', 21, ' ')                                -- ����.
                       AS A26_RECORD_FILE
                       
                     ,  '28'                                              -- �ڷᱸ��.
                     || 'O201'                                            -- �����ڵ�.
                     || 'A30'                                             -- ��õ�����ڵ�.
                     || LPAD(NVL(WD.A30_PERSON_CNT, 0), 15, '0')          -- �ο�.
                     || LPAD(NVL(WD.A30_PAYMENT_AMT, 0), 15, '0')         -- �����޾�.
                     || LPAD(NVL(WD.A30_INCOME_TAX_AMT, 0), 15, '0')      -- ¡������(�ҵ漼��).
                     || LPAD(NVL(WD.A30_SP_TAX_AMT, 0), 15, '0')          -- ¡������(��Ư��).
                     || LPAD(NVL(WD.A30_ADD_TAX_AMT, 0), 15, '0')         -- ���꼼.
                     || LPAD(NVL(WD.A30_THIS_REFUND_TAX_AMT, 0), 15, '0') -- �������ȯ�޼���.
                     || LPAD(NVL(WD.A30_PAY_INCOME_TAX_AMT, 0), 15, '0')  -- ���μ���(�ҵ漼��).
                     || LPAD(NVL(WD.A30_PAY_SP_TAX_AMT, 0), 15, '0')      -- ���μ���(��Ư��).
                     || RPAD(' ', 21, ' ')                                -- ����.
                       AS A30_RECORD_FILE
                       
                     ,  '28'                                              -- �ڷᱸ��.
                     || 'O201'                                            -- �����ڵ�.
                     || 'A41'                                             -- ��õ�����ڵ�.
                     || LPAD(NVL(WD.A41_PERSON_CNT, 0), 15, '0')          -- �ο�(��Ÿ�ҵ� ���ݰ���).
                     || LPAD(NVL(WD.A41_PAYMENT_AMT, 0), 15, '0')         -- �����޾�(��Ÿ�ҵ� ���ݰ���).
                     || LPAD(NVL(WD.A41_INCOME_TAX_AMT, 0), 15, '0')      -- ¡������(�ҵ漼��)(��Ÿ�ҵ� ���ݰ���).
                     || LPAD(0, 15, '0')          -- ¡������(��Ư��)(��Ÿ�ҵ� ���ݰ���).
                     || LPAD(NVL(WD.A41_ADD_TAX_AMT, 0), 15, '0')         -- ���꼼(��Ÿ�ҵ� ���ݰ���).
                     || LPAD(NVL(WD.A41_THIS_REFUND_TAX_AMT, 0), 15, '0') -- �������ȯ�޼���(��Ÿ�ҵ� ���ݰ���).
                     || LPAD(NVL(WD.A41_PAY_INCOME_TAX_AMT, 0), 15, '0')  -- ���μ���(�ҵ漼��)(��Ÿ�ҵ� ���ݰ���).
                     || LPAD(0, 15, '0')      -- ���μ���(��Ư��).
                     || RPAD(' ', 21, ' ')                                -- ����.
                       AS A41_RECORD_FILE  
                       
                     ,  '28'                                              -- �ڷᱸ��(��Ÿ�ҵ� �׿�).
                     || 'O201'                                            -- �����ڵ�(��Ÿ�ҵ� �׿�).
                     || 'A42'                                             -- ��õ�����ڵ�(��Ÿ�ҵ� �׿�).
                     || LPAD(NVL(WD.A42_PERSON_CNT, 0), 15, '0')          -- �ο�(��Ÿ�ҵ� �׿�).
                     || LPAD(NVL(WD.A42_PAYMENT_AMT, 0), 15, '0')         -- �����޾�(��Ÿ�ҵ� �׿�).
                     || LPAD(NVL(WD.A42_INCOME_TAX_AMT, 0), 15, '0')      -- ¡������(�ҵ漼��)(��Ÿ�ҵ� �׿�).
                     || LPAD(0, 15, '0')          -- ¡������(��Ư��)(��Ÿ�ҵ� �׿�).
                     || LPAD(NVL(WD.A42_ADD_TAX_AMT, 0), 15, '0')         -- ���꼼(��Ÿ�ҵ� �׿�).
                     || LPAD(NVL(WD.A42_THIS_REFUND_TAX_AMT, 0), 15, '0') -- �������ȯ�޼���(��Ÿ�ҵ� �׿�).
                     || LPAD(NVL(WD.A42_PAY_INCOME_TAX_AMT, 0), 15, '0')  -- ���μ���(�ҵ漼��)(��Ÿ�ҵ� �׿�).
                     || LPAD(0, 15, '0')      -- ���μ���(��Ư��)(��Ÿ�ҵ� �׿�).
                     || RPAD(' ', 21, ' ')                                -- ����.
                       AS A42_RECORD_FILE  
                       
                     ,  '28'                                              -- �ڷᱸ��.
                     || 'O201'                                            -- �����ڵ�.
                     || 'A40'                                             -- ��õ�����ڵ�.
                     || LPAD(NVL(WD.A40_PERSON_CNT, 0), 15, '0')          -- �ο�.
                     || LPAD(NVL(WD.A40_PAYMENT_AMT, 0), 15, '0')         -- �����޾�.
                     || LPAD(NVL(WD.A40_INCOME_TAX_AMT, 0), 15, '0')      -- ¡������(�ҵ漼��).
                     || LPAD(0, 15, '0')          -- ¡������(��Ư��).
                     || LPAD(NVL(WD.A40_ADD_TAX_AMT, 0), 15, '0')         -- ���꼼.
                     || LPAD(NVL(WD.A40_THIS_REFUND_TAX_AMT, 0), 15, '0') -- �������ȯ�޼���.
                     || LPAD(NVL(WD.A40_PAY_INCOME_TAX_AMT, 0), 15, '0')  -- ���μ���(�ҵ漼��).
                     || LPAD(0, 15, '0')      -- ���μ���(��Ư��).
                     || RPAD(' ', 21, ' ')                                -- ����.
                       AS A40_RECORD_FILE  
                       
                     ,  '28'                                              -- �ڷᱸ��.
                     || 'O201'                                            -- �����ڵ�.
                     || 'A48'                                             -- ��õ�����ڵ�.
                     || LPAD(NVL(WD.A48_PERSON_CNT, 0), 15, '0')          -- �ο�(���ݼҵ� ���ݰ���).
                     || LPAD(NVL(WD.A48_PAYMENT_AMT, 0), 15, '0')         -- �����޾�(���ݼҵ� ���ݰ���).
                     || LPAD(NVL(WD.A48_INCOME_TAX_AMT, 0), 15, '0')      -- ¡������(�ҵ漼��)(���ݼҵ� ���ݰ���).
                     || LPAD(0, 15, '0')                                  -- ¡������(��Ư��)(���ݼҵ� ���ݰ���).
                     || LPAD(NVL(WD.A48_ADD_TAX_AMT, 0), 15, '0')         -- ���꼼(���ݼҵ� ���ݰ���).
                     || LPAD(0, 15, '0')                                  -- �������ȯ�޼���(���ݼҵ� ���ݰ���).
                     || LPAD(0, 15, '0')                                  -- ���μ���(�ҵ漼��)(���ݼҵ� ���ݰ���).
                     || LPAD(0, 15, '0')                                  -- ���μ���(��Ư��(���ݼҵ� ���ݰ���)).
                     || RPAD(' ', 21, ' ')                                -- ����.
                       AS A48_RECORD_FILE
                       
                     ,  '28'                                              -- �ڷᱸ��.
                     || 'O201'                                            -- �����ڵ�.
                     || 'A45'                                             -- ��õ�����ڵ�.
                     || LPAD(NVL(WD.A45_PERSON_CNT, 0), 15, '0')          -- �ο�.
                     || LPAD(NVL(WD.A45_PAYMENT_AMT, 0), 15, '0')         -- �����޾�.
                     || LPAD(NVL(WD.A45_INCOME_TAX_AMT, 0), 15, '0')      -- ¡������(�ҵ漼��).
                     || LPAD(0, 15, '0')                                  -- ¡������(��Ư��).
                     || LPAD(NVL(WD.A45_ADD_TAX_AMT, 0), 15, '0')         -- ���꼼.
                     || LPAD(0, 15, '0')                                  -- �������ȯ�޼���.
                     || LPAD(0, 15, '0')                                  -- ���μ���(�ҵ漼��).
                     || LPAD(0, 15, '0')                                  -- ���μ���(��Ư��).
                     || RPAD(' ', 21, ' ')                                -- ����.
                       AS A45_RECORD_FILE
                       
                     ,  '28'                                              -- �ڷᱸ��.
                     || 'O201'                                            -- �����ڵ�.
                     || 'A46'                                             -- ��õ�����ڵ�.
                     || LPAD(NVL(WD.A46_PERSON_CNT, 0), 15, '0')          -- �ο�.
                     || LPAD(NVL(WD.A46_PAYMENT_AMT, 0), 15, '0')         -- �����޾�.
                     || CASE
                          WHEN NVL(WD.A46_INCOME_TAX_AMT, 0) < 0 THEN
                            '-' || LPAD(ABS(NVL(WD.A46_INCOME_TAX_AMT, 0)), 14, '0')
                          ELSE LPAD(NVL(WD.A46_INCOME_TAX_AMT, 0), 15, '0')
                        END                                               -- ¡������(�ҵ漼��).
                     || LPAD(0, 15, '0')                                  -- ¡������(��Ư��).
                     || LPAD(NVL(WD.A46_ADD_TAX_AMT, 0), 15, '0')         -- ���꼼.
                     || LPAD(0, 15, '0')                                  -- �������ȯ�޼���.
                     || LPAD(0, 15, '0')                                  -- ���μ���(�ҵ漼��).
                     || LPAD(0, 15, '0')                                  -- ���μ���(��Ư��).
                     || RPAD(' ', 21, ' ')                                -- ����.
                       AS A46_RECORD_FILE
                       
                     ,  '28'                                              -- �ڷᱸ��.
                     || 'O201'                                            -- �����ڵ�.
                     || 'A47'                                             -- ��õ�����ڵ�.
                     || LPAD(NVL(WD.A47_PERSON_CNT, 0), 15, '0')          -- �ο�.
                     || LPAD(NVL(WD.A47_PAYMENT_AMT, 0), 15, '0')         -- �����޾�.
                     || LPAD(NVL(WD.A47_INCOME_TAX_AMT, 0), 15, '0')      -- ¡������(�ҵ漼��).
                     || LPAD(0, 15, '0')          -- ¡������(��Ư��).
                     || LPAD(NVL(WD.A47_ADD_TAX_AMT, 0), 15, '0')         -- ���꼼.
                     || LPAD(NVL(WD.A47_THIS_REFUND_TAX_AMT, 0), 15, '0') -- �������ȯ�޼���.
                     || LPAD(NVL(WD.A47_PAY_INCOME_TAX_AMT, 0), 15, '0')  -- ���μ���(�ҵ漼��).
                     || LPAD(0, 15, '0')      -- ���μ���(��Ư��).
                     || RPAD(' ', 21, ' ')                                -- ����.
                       AS A47_RECORD_FILE
                       
                     ,  '28'                                              -- �ڷᱸ��.
                     || 'O201'                                            -- �����ڵ�.
                     || 'A50'                                             -- ��õ�����ڵ�.
                     || LPAD(NVL(WD.A50_PERSON_CNT, 0), 15, '0')          -- �ο�.
                     || LPAD(NVL(WD.A50_PAYMENT_AMT, 0), 15, '0')         -- �����޾�.
                     || LPAD(NVL(WD.A50_INCOME_TAX_AMT, 0), 15, '0')      -- ¡������(�ҵ漼��).
                     || LPAD(NVL(WD.A50_SP_TAX_AMT, 0), 15, '0')          -- ¡������(��Ư��).
                     || LPAD(NVL(WD.A50_ADD_TAX_AMT, 0), 15, '0')         -- ���꼼.
                     || LPAD(NVL(WD.A50_THIS_REFUND_TAX_AMT, 0), 15, '0') -- �������ȯ�޼���.
                     || LPAD(NVL(WD.A50_PAY_INCOME_TAX_AMT, 0), 15, '0')  -- ���μ���(�ҵ漼��).
                     || LPAD(NVL(WD.A50_PAY_SP_TAX_AMT, 0), 15, '0')      -- ���μ���(��Ư��).
                     || RPAD(' ', 21, ' ')                                -- ����.
                       AS A50_RECORD_FILE
                       
                     ,  '28'                                              -- �ڷᱸ��.
                     || 'O201'                                            -- �����ڵ�.
                     || 'A60'                                             -- ��õ�����ڵ�.
                     || LPAD(NVL(WD.A60_PERSON_CNT, 0), 15, '0')          -- �ο�.
                     || LPAD(NVL(WD.A60_PAYMENT_AMT, 0), 15, '0')         -- �����޾�.
                     || LPAD(NVL(WD.A60_INCOME_TAX_AMT, 0), 15, '0')      -- ¡������(�ҵ漼��).
                     || LPAD(NVL(WD.A60_SP_TAX_AMT, 0), 15, '0')          -- ¡������(��Ư��).
                     || LPAD(NVL(WD.A60_ADD_TAX_AMT, 0), 15, '0')         -- ���꼼.
                     || LPAD(NVL(WD.A60_THIS_REFUND_TAX_AMT, 0), 15, '0') -- �������ȯ�޼���.
                     || LPAD(NVL(WD.A60_PAY_INCOME_TAX_AMT, 0), 15, '0')  -- ���μ���(�ҵ漼��).
                     || LPAD(NVL(WD.A60_PAY_SP_TAX_AMT, 0), 15, '0')      -- ���μ���(��Ư��).
                     || RPAD(' ', 21, ' ')                                -- ����.
                       AS A60_RECORD_FILE
                       
                     ,  '28'                                              -- �ڷᱸ��.
                     || 'O201'                                            -- �����ڵ�.
                     || 'A69'                                             -- ��õ�����ڵ�.
                     || LPAD(NVL(WD.A69_PERSON_CNT, 0), 15, '0')          -- �ο�.
                     || LPAD(0, 15, '0')                                  -- �����޾�.
                     || LPAD(NVL(WD.A69_INCOME_TAX_AMT, 0), 15, '0')      -- ¡������(�ҵ漼��).
                     || LPAD(0, 15, '0')                                  -- ¡������(��Ư��).
                     || LPAD(NVL(WD.A69_ADD_TAX_AMT, 0), 15, '0')         -- ���꼼.
                     || LPAD(NVL(WD.A69_THIS_REFUND_TAX_AMT, 0), 15, '0') -- �������ȯ�޼���.
                     || LPAD(NVL(WD.A69_PAY_INCOME_TAX_AMT, 0), 15, '0')  -- ���μ���(�ҵ漼��).
                     || LPAD(0, 15, '0')                                  -- ���μ���(��Ư��).
                     || RPAD(' ', 21, ' ')                                -- ����.
                       AS A69_RECORD_FILE
                       
                     ,  '28'                                              -- �ڷᱸ��.
                     || 'O201'                                            -- �����ڵ�.
                     || 'A70'                                             -- ��õ�����ڵ�.
                     || LPAD(NVL(WD.A70_PERSON_CNT, 0), 15, '0')          -- �ο�.
                     || LPAD(NVL(WD.A70_PAYMENT_AMT, 0), 15, '0')         -- �����޾�.
                     || LPAD(NVL(WD.A70_INCOME_TAX_AMT, 0), 15, '0')      -- ¡������(�ҵ漼��).
                     || LPAD(0, 15, '0')                                  -- ¡������(��Ư��).
                     || LPAD(NVL(WD.A70_ADD_TAX_AMT, 0), 15, '0')         -- ���꼼.
                     || LPAD(NVL(WD.A70_THIS_REFUND_TAX_AMT, 0), 15, '0') -- �������ȯ�޼���.
                     || LPAD(NVL(WD.A70_PAY_INCOME_TAX_AMT, 0), 15, '0')  -- ���μ���(�ҵ漼��).
                     || LPAD(0, 15, '0')                                  -- ���μ���(��Ư��).
                     || RPAD(' ', 21, ' ')                                -- ����.
                       AS A70_RECORD_FILE
                       
                     ,  '28'                                              -- �ڷᱸ��.
                     || 'O201'                                            -- �����ڵ�.
                     || 'A80'                                             -- ��õ�����ڵ�.
                     || LPAD(NVL(WD.A80_PERSON_CNT, 0), 15, '0')          -- �ο�.
                     || LPAD(NVL(WD.A80_PAYMENT_AMT, 0), 15, '0')         -- �����޾�.
                     || LPAD(NVL(WD.A80_INCOME_TAX_AMT, 0), 15, '0')      -- ¡������(�ҵ漼��).
                     || LPAD(0, 15, '0')                                  -- ¡������(��Ư��).
                     || LPAD(NVL(WD.A80_ADD_TAX_AMT, 0), 15, '0')         -- ���꼼.
                     || LPAD(NVL(WD.A80_THIS_REFUND_TAX_AMT, 0), 15, '0') -- �������ȯ�޼���.
                     || LPAD(NVL(WD.A80_PAY_INCOME_TAX_AMT, 0), 15, '0')  -- ���μ���(�ҵ漼��).
                     || LPAD(0, 15, '0')                                  -- ���μ���(��Ư��).
                     || RPAD(' ', 21, ' ')                                -- ����.
                       AS A80_RECORD_FILE
                       
                     ,  '28'                                              -- �ڷᱸ��.
                     || 'O201'                                            -- �����ڵ�.
                     || 'A90'                                             -- ��õ�����ڵ�.
                     || LPAD(0, 15, '0')                                  -- �ο�.
                     || LPAD(0, 15, '0')                                  -- �����޾�.
                     || CASE
                          WHEN NVL(WD.A90_INCOME_TAX_AMT, 0) < 0 THEN
                            '-' || LPAD(ABS(NVL(WD.A90_INCOME_TAX_AMT, 0)), 14, '0')
                          ELSE LPAD(NVL(WD.A90_INCOME_TAX_AMT, 0), 15, '0')
                        END                                               -- ¡������(�ҵ漼��).
                     || CASE
                          WHEN NVL(WD.A90_SP_TAX_AMT, 0) < 0 THEN
                            '-' || LPAD(ABS(NVL(WD.A90_SP_TAX_AMT, 0)), 14, '0')
                          ELSE LPAD(NVL(WD.A90_SP_TAX_AMT, 0), 15, '0')
                        END                                               -- ¡������(��Ư��).
                     || LPAD(NVL(WD.A90_ADD_TAX_AMT, 0), 15, '0')         -- ���꼼.
                     || LPAD(NVL(WD.A90_THIS_REFUND_TAX_AMT, 0), 15, '0') -- �������ȯ�޼���.
                     || LPAD(NVL(WD.A90_PAY_INCOME_TAX_AMT, 0), 15, '0')  -- ���μ���(�ҵ漼��).
                     || LPAD(NVL(WD.A90_PAY_SP_TAX_AMT, 0), 15, '0')      -- ���μ���(��Ư��).
                     || RPAD(' ', 21, ' ')                                -- ����.
                       AS A90_RECORD_FILE
                       
                     ,  '28'                                              -- �ڷᱸ��.
                     || 'O201'                                            -- �����ڵ�.
                     || 'A99'                                             -- ��õ�����ڵ�.
                     || LPAD(NVL(WD.A99_PERSON_CNT, 0), 15, '0')          -- �ο�.
                     || LPAD(NVL(WD.A99_PAYMENT_AMT, 0), 15, '0')         -- �����޾�.
                     || LPAD(NVL(WD.A99_INCOME_TAX_AMT, 0), 15, '0')      -- ¡������(�ҵ漼��).
                     || LPAD(NVL(WD.A99_SP_TAX_AMT, 0), 15, '0')          -- ¡������(��Ư��).
                     || LPAD(NVL(WD.A99_ADD_TAX_AMT, 0), 15, '0')         -- ���꼼.
                     || CASE
                          WHEN WD.WITHHOLDING_TYPE = '2' AND NVL(WD.A99_THIS_REFUND_TAX_AMT, 0) < 0 THEN
                            '-' || LPAD(ABS(NVL(WD.A99_THIS_REFUND_TAX_AMT, 0)), 14, '0')
                          ELSE LPAD(NVL(WD.A99_THIS_REFUND_TAX_AMT, 0), 15, '0') 
                        END                                               -- �������ȯ�޼���.
                     || LPAD(NVL(WD.A99_PAY_INCOME_TAX_AMT, 0), 15, '0')  -- ���μ���(�ҵ漼��).
                     || LPAD(NVL(WD.A99_PAY_SP_TAX_AMT, 0), 15, '0')      -- ���μ���(��Ư��).
                     || RPAD(' ', 21, ' ')                                -- ����.
                       AS A99_RECORD_FILE
                       
                     ,  CASE
                          WHEN WD.WITHHOLDING_TYPE = '1' THEN '1'         -- ����;
                          WHEN WD.WITHHOLDING_TYPE = '2' THEN '2'         -- ����;
                          WHEN WD.WITHHOLDING_TYPE = '3' THEN '5'         -- �ⳳ��;
                        END AS WITHHOLDING_TYPE                           -- �Ű���;
                     , WD.SOURCE_WITHHOLDING_NO                           -- ������������ȣ;
                  FROM HRW_WITHHOLDING_DOC WD
                    , HRM_CORP_MASTER CM
                    , HRW_HOMETAX_INFO HI
                WHERE WD.CORP_ID            = CM.CORP_ID
                  AND WD.CORP_ID            = HI.CORP_ID
                  AND WD.WITHHOLDING_DOC_ID = P_WITHHOLDING_DOC_ID
              )
    LOOP
      V_SEQ_NUM := 10;
      V_SOURCE_FILE := 'HEADER';
      INSERT_REPORT_FILE
        ( P_SEQ_NUM           => V_SEQ_NUM
        , P_SOURCE_FILE       => V_SOURCE_FILE
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , P_REPORT_FILE       => C1.H_RECORD_FILE
        , P_SORT_NUM          => 1
        );
      -- ��õ¡�������Ȳ�Ű�.
      V_SEQ_NUM := 100;
      V_SOURCE_FILE := 'B_RECORD';
      INSERT_REPORT_FILE
        ( P_SEQ_NUM           => V_SEQ_NUM
        , P_SOURCE_FILE       => V_SOURCE_FILE
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , P_REPORT_FILE       => C1.B_RECORD_FILE
        , P_SORT_NUM          => 1
        );      
      -- ��õ¡�������Ȳ�Ű�-����(A01).
      V_SEQ_NUM := 101;
      V_SOURCE_FILE := 'A01_RECORD';
      INSERT_REPORT_FILE
        ( P_SEQ_NUM           => V_SEQ_NUM
        , P_SOURCE_FILE       => V_SOURCE_FILE
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , P_REPORT_FILE       => C1.A01_RECORD_FILE
        , P_SORT_NUM          => 1
        );
      V_SEQ_NUM := 102;
      V_SOURCE_FILE := 'A02_RECORD';
      INSERT_REPORT_FILE
        ( P_SEQ_NUM           => V_SEQ_NUM
        , P_SOURCE_FILE       => V_SOURCE_FILE
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , P_REPORT_FILE       => C1.A02_RECORD_FILE
        , P_SORT_NUM          => 1
        );
      V_SEQ_NUM := 103;
      V_SOURCE_FILE := 'A03_RECORD';
      INSERT_REPORT_FILE
        ( P_SEQ_NUM           => V_SEQ_NUM
        , P_SOURCE_FILE       => V_SOURCE_FILE
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , P_REPORT_FILE       => C1.A03_RECORD_FILE
        , P_SORT_NUM          => 1
        );  
      V_SEQ_NUM := 104;
      V_SOURCE_FILE := 'A04_RECORD';
      INSERT_REPORT_FILE
        ( P_SEQ_NUM           => V_SEQ_NUM
        , P_SOURCE_FILE       => V_SOURCE_FILE
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , P_REPORT_FILE       => C1.A04_RECORD_FILE
        , P_SORT_NUM          => 1
        );
      V_SEQ_NUM := 110;
      V_SOURCE_FILE := 'A10_RECORD';
      INSERT_REPORT_FILE
        ( P_SEQ_NUM           => V_SEQ_NUM
        , P_SOURCE_FILE       => V_SOURCE_FILE
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , P_REPORT_FILE       => C1.A10_RECORD_FILE
        , P_SORT_NUM          => 1
        );      
      V_SEQ_NUM := 121;
      V_SOURCE_FILE := 'A21_RECORD';
      INSERT_REPORT_FILE
        ( P_SEQ_NUM           => V_SEQ_NUM
        , P_SOURCE_FILE       => V_SOURCE_FILE
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , P_REPORT_FILE       => C1.A21_RECORD_FILE
        , P_SORT_NUM          => 1
        );        
      V_SEQ_NUM := 122;
      V_SOURCE_FILE := 'A22_RECORD';
      INSERT_REPORT_FILE
        ( P_SEQ_NUM           => V_SEQ_NUM
        , P_SOURCE_FILE       => V_SOURCE_FILE
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , P_REPORT_FILE       => C1.A22_RECORD_FILE
        , P_SORT_NUM          => 1
        );
      V_SEQ_NUM := 124;
      V_SOURCE_FILE := 'A20_RECORD';
      INSERT_REPORT_FILE
        ( P_SEQ_NUM           => V_SEQ_NUM
        , P_SOURCE_FILE       => V_SOURCE_FILE
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , P_REPORT_FILE       => C1.A20_RECORD_FILE
        , P_SORT_NUM          => 1
        );                
      V_SEQ_NUM := 125;
      V_SOURCE_FILE := 'A25_RECORD';
      INSERT_REPORT_FILE
        ( P_SEQ_NUM           => V_SEQ_NUM
        , P_SOURCE_FILE       => V_SOURCE_FILE
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , P_REPORT_FILE       => C1.A25_RECORD_FILE
        , P_SORT_NUM          => 1
        );
      V_SEQ_NUM := 126;
      V_SOURCE_FILE := 'A26_RECORD';
      INSERT_REPORT_FILE
        ( P_SEQ_NUM           => V_SEQ_NUM
        , P_SOURCE_FILE       => V_SOURCE_FILE
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , P_REPORT_FILE       => C1.A26_RECORD_FILE
        , P_SORT_NUM          => 1
        );  
      V_SEQ_NUM := 130;
      V_SOURCE_FILE := 'A30_RECORD';
      INSERT_REPORT_FILE
        ( P_SEQ_NUM           => V_SEQ_NUM
        , P_SOURCE_FILE       => V_SOURCE_FILE
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , P_REPORT_FILE       => C1.A30_RECORD_FILE
        , P_SORT_NUM          => 1
        );  
      V_SEQ_NUM := 141;
      V_SOURCE_FILE := 'A41_RECORD';
      INSERT_REPORT_FILE
        ( P_SEQ_NUM           => V_SEQ_NUM
        , P_SOURCE_FILE       => V_SOURCE_FILE
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , P_REPORT_FILE       => C1.A41_RECORD_FILE
        , P_SORT_NUM          => 1
        );  
      V_SEQ_NUM := 142;
      V_SOURCE_FILE := 'A42_RECORD';
      INSERT_REPORT_FILE
        ( P_SEQ_NUM           => V_SEQ_NUM
        , P_SOURCE_FILE       => V_SOURCE_FILE
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , P_REPORT_FILE       => C1.A42_RECORD_FILE
        , P_SORT_NUM          => 1
        );    
      V_SEQ_NUM := 144;
      V_SOURCE_FILE := 'A40_RECORD';
      INSERT_REPORT_FILE
        ( P_SEQ_NUM           => V_SEQ_NUM
        , P_SOURCE_FILE       => V_SOURCE_FILE
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , P_REPORT_FILE       => C1.A40_RECORD_FILE
        , P_SORT_NUM          => 1
        );
      V_SEQ_NUM := 145;
      V_SOURCE_FILE := 'A48_RECORD';
      INSERT_REPORT_FILE
        ( P_SEQ_NUM           => V_SEQ_NUM
        , P_SOURCE_FILE       => V_SOURCE_FILE
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , P_REPORT_FILE       => C1.A48_RECORD_FILE
        , P_SORT_NUM          => 1
        );  
      V_SEQ_NUM := 145.5;
      V_SOURCE_FILE := 'A45_RECORD';
      INSERT_REPORT_FILE
        ( P_SEQ_NUM           => V_SEQ_NUM
        , P_SOURCE_FILE       => V_SOURCE_FILE
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , P_REPORT_FILE       => C1.A45_RECORD_FILE
        , P_SORT_NUM          => 1
        );
      V_SEQ_NUM := 146;
      V_SOURCE_FILE := 'A46_RECORD';
      INSERT_REPORT_FILE
        ( P_SEQ_NUM           => V_SEQ_NUM
        , P_SOURCE_FILE       => V_SOURCE_FILE
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , P_REPORT_FILE       => C1.A46_RECORD_FILE
        , P_SORT_NUM          => 1
        );
      V_SEQ_NUM := 147;
      V_SOURCE_FILE := 'A47_RECORD';
      INSERT_REPORT_FILE
        ( P_SEQ_NUM           => V_SEQ_NUM
        , P_SOURCE_FILE       => V_SOURCE_FILE
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , P_REPORT_FILE       => C1.A47_RECORD_FILE
        , P_SORT_NUM          => 1
        );
      V_SEQ_NUM := 150;
      V_SOURCE_FILE := 'A50_RECORD';
      INSERT_REPORT_FILE
        ( P_SEQ_NUM           => V_SEQ_NUM
        , P_SOURCE_FILE       => V_SOURCE_FILE
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , P_REPORT_FILE       => C1.A50_RECORD_FILE
        , P_SORT_NUM          => 1
        );
      V_SEQ_NUM := 160;
      V_SOURCE_FILE := 'A60_RECORD';
      INSERT_REPORT_FILE
        ( P_SEQ_NUM           => V_SEQ_NUM
        , P_SOURCE_FILE       => V_SOURCE_FILE
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , P_REPORT_FILE       => C1.A60_RECORD_FILE
        , P_SORT_NUM          => 1
        );
      V_SEQ_NUM := 169;
      V_SOURCE_FILE := 'A69_RECORD';
      INSERT_REPORT_FILE
        ( P_SEQ_NUM           => V_SEQ_NUM
        , P_SOURCE_FILE       => V_SOURCE_FILE
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , P_REPORT_FILE       => C1.A69_RECORD_FILE
        , P_SORT_NUM          => 1
        );
      V_SEQ_NUM := 170;
      V_SOURCE_FILE := 'A70_RECORD';
      INSERT_REPORT_FILE
        ( P_SEQ_NUM           => V_SEQ_NUM
        , P_SOURCE_FILE       => V_SOURCE_FILE
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , P_REPORT_FILE       => C1.A70_RECORD_FILE
        , P_SORT_NUM          => 1
        );
      V_SEQ_NUM := 180;
      V_SOURCE_FILE := 'A80_RECORD';
      INSERT_REPORT_FILE
        ( P_SEQ_NUM           => V_SEQ_NUM
        , P_SOURCE_FILE       => V_SOURCE_FILE
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , P_REPORT_FILE       => C1.A80_RECORD_FILE
        , P_SORT_NUM          => 1
        );
      V_SEQ_NUM := 190;
      V_SOURCE_FILE := 'A90_RECORD';
      INSERT_REPORT_FILE
        ( P_SEQ_NUM           => V_SEQ_NUM
        , P_SOURCE_FILE       => V_SOURCE_FILE
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , P_REPORT_FILE       => C1.A90_RECORD_FILE
        , P_SORT_NUM          => 1
        );
      V_SEQ_NUM := 199;
      V_SOURCE_FILE := 'A99_RECORD';
      INSERT_REPORT_FILE
        ( P_SEQ_NUM           => V_SEQ_NUM
        , P_SOURCE_FILE       => V_SOURCE_FILE
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , P_REPORT_FILE       => C1.A99_RECORD_FILE
        , P_SORT_NUM          => 1
        );
      -- <�����ó�� ���ʺ� ��õ¡�������Ȳ�Ű� �ڷ�> --
      FOR C2 IN ( SELECT  --> ��õ¡�������Ȳ�Ű� <--
                          '37'                                              -- �ڷᱸ��.
                       || 'O201'                                            -- �����ڵ�.
                       || LPAD(NVL(WD.RECEIVE_REFUND_TAX_AMT, 0), 15, '0')  -- ������ȯ�޼���.
                       || LPAD(NVL(WD.ALREADY_REFUND_TAX_AMT, 0), 15, '0')  -- ��ȯ�޼���û����.
                       || LPAD(NVL(WD.REFUND_BALANCE_AMT, 0), 15, '0')      -- �������ܾ�(��õ).
                       || LPAD(NVL(WD.GENERAL_REFUND_AMT, 0), 15, '0')      -- �Ϲ�ȯ�޼���.
                       || LPAD(NVL(WD.FINANCIAL_AMT, 0), 15, '0')           -- ��Ź��꼼��.
                       || LPAD(NVL(WD.ADJUST_REFUND_TAX_AMT, 0), 15, '0')   -- �������ȯ�޼���.
                       || LPAD(NVL(WD.THIS_ADJUST_REFUND_TAX_AMT ,0), 15, '0') -- �������ȯ�޼���.
                       || LPAD(NVL(WD.NEXT_REFUND_TAX_AMT, 0), 15, '0')     -- �����̿�ȯ�޼���.
                       || 'N'                                               -- �ϰ����ο���.
                       || LPAD(NVL(WD.ETC_REFUND_FINANCIAL_AMT, 0), 15, '0')   -- �׹��� ȯ�޼��� ����ȸ���.
                       || LPAD(NVL(WD.REQUEST_REFUND_TAX_AMT, 0), 15, '0')  -- ȯ�޽�û��.
                       || 'N'                                               -- ����ڴ�����������.
                       || LPAD(NVL(WD.ETC_REFUND_MERGER_AMT, 0), 15, '0')   -- �׹��� ȯ�޼��� �պ���.
                       || RPAD(' ', 7, ' ')                                 -- ����.
                          AS B_RECORD_FILE
                       --> ��õ¡�������Ȳ�Ű�-����<--
                       ,  '28'                                              -- �ڷᱸ��.
                       || 'O201'                                            -- �����ڵ�.
                       || 'A01'                                             -- ��õ�����ڵ�.
                       || LPAD(NVL(WD.A01_PERSON_CNT, 0), 15, '0')          -- �ο�.
                       || LPAD(NVL(WD.A01_PAYMENT_AMT, 0), 15, '0')         -- �����޾�.
                       || LPAD(NVL(WD.A01_INCOME_TAX_AMT, 0), 15, '0')      -- ¡������(�ҵ漼��).
                       || LPAD(NVL(WD.A01_SP_TAX_AMT, 0), 15, '0')          -- ¡������(��Ư��).
                       || LPAD(NVL(WD.A01_ADD_TAX_AMT, 0), 15, '0')         -- ���꼼.
                       || LPAD(0, 15, '0')                                  -- �������ȯ�޼���.
                       || LPAD(0, 15, '0')                                  -- ���μ���(�ҵ漼��).
                       || LPAD(0, 15, '0')                                  -- ���μ���(��Ư��).
                       || RPAD(' ', 21, ' ')                                -- ����.
                         AS A01_RECORD_FILE
                       ,  '28'                                              -- �ڷᱸ��.
                       || 'O201'                                            -- �����ڵ�.
                       || 'A02'                                             -- ��õ�����ڵ�.
                       || LPAD(NVL(WD.A02_PERSON_CNT, 0), 15, '0')          -- �ο�.
                       || LPAD(NVL(WD.A02_PAYMENT_AMT, 0), 15, '0')         -- �����޾�.
                       || CASE
                            WHEN NVL(WD.A02_INCOME_TAX_AMT, 0) < 0 THEN
                              '-' || LPAD(ABS(NVL(WD.A02_INCOME_TAX_AMT, 0)), 14, '0')
                            ELSE LPAD(NVL(WD.A02_INCOME_TAX_AMT, 0), 15, '0')
                          END                                               -- ¡������(�ҵ漼��).                          
                       || CASE
                            WHEN NVL(WD.A02_SP_TAX_AMT, 0) < 0 THEN
                              '-' || LPAD(ABS(NVL(WD.A02_SP_TAX_AMT, 0)), 14, '0')
                            ELSE LPAD(NVL(WD.A02_SP_TAX_AMT, 0), 15, '0')
                          END                                               -- ¡������(��Ư��).
                       || LPAD(NVL(WD.A02_ADD_TAX_AMT, 0), 15, '0')         -- ���꼼.
                       || LPAD(0, 15, '0')                                  -- �������ȯ�޼���.
                       || LPAD(0, 15, '0')                                  -- ���μ���(�ҵ漼��).
                       || LPAD(0, 15, '0')                                  -- ���μ���(��Ư��).
                       || RPAD(' ', 21, ' ')                                -- ����.
                         AS A02_RECORD_FILE
                       ,  '28'                                              -- �ڷᱸ��.
                       || 'O201'                                            -- �����ڵ�.
                       || 'A03'                                             -- ��õ�����ڵ�.
                       || LPAD(NVL(WD.A03_PERSON_CNT, 0), 15, '0')          -- �ο�.
                       || LPAD(NVL(WD.A03_PAYMENT_AMT, 0), 15, '0')         -- �����޾�.
                       || LPAD(NVL(WD.A03_INCOME_TAX_AMT, 0), 15, '0')      -- ¡������(�ҵ漼��).
                       || LPAD(0, 15, '0')                                  -- ¡������(��Ư��).
                       || LPAD(NVL(WD.A03_ADD_TAX_AMT, 0), 15, '0')         -- ���꼼.
                       || LPAD(0, 15, '0')                                  -- �������ȯ�޼���.
                       || LPAD(0, 15, '0')                                  -- ���μ���(�ҵ漼��).
                       || LPAD(0, 15, '0')                                  -- ���μ���(��Ư��).
                       || RPAD(' ', 21, ' ')                                -- ����.
                         AS A03_RECORD_FILE
                       ,  '28'                                              -- �ڷᱸ��.
                       || 'O201'                                            -- �����ڵ�.
                       || 'A04'                                             -- ��õ�����ڵ�.
                       || LPAD(NVL(WD.A04_PERSON_CNT, 0), 15, '0')          -- �ο�.
                       || LPAD(NVL(WD.A04_PAYMENT_AMT, 0), 15, '0')         -- �����޾�.
                       || CASE
                            WHEN NVL(WD.A04_INCOME_TAX_AMT, 0) < 0 THEN
                              '-' || LPAD(ABS(NVL(WD.A04_INCOME_TAX_AMT, 0)), 14, '0')
                            ELSE LPAD(NVL(WD.A04_INCOME_TAX_AMT, 0), 15, '0')
                          END                                               -- ¡������(�ҵ漼��).
                       || CASE
                            WHEN NVL(WD.A04_SP_TAX_AMT, 0) < 0 THEN
                              '-' || LPAD(ABS(NVL(WD.A04_SP_TAX_AMT, 0)), 14, '0')
                            ELSE LPAD(NVL(WD.A04_SP_TAX_AMT, 0), 15, '0')
                          END                                               -- ¡������(��Ư��).
                       || LPAD(NVL(WD.A04_ADD_TAX_AMT, 0), 15, '0')         -- ���꼼.
                       || LPAD(0, 15, '0')                                  -- �������ȯ�޼���.
                       || LPAD(0, 15, '0')                                  -- ���μ���(�ҵ漼��).
                       || LPAD(0, 15, '0')                                  -- ���μ���(��Ư��).
                       || RPAD(' ', 21, ' ')                                -- ����.
                         AS A04_RECORD_FILE
                       ,  '28'                                              -- �ڷᱸ��.
                       || 'O201'                                            -- �����ڵ�.
                       || 'A10'                                             -- ��õ�����ڵ�.
                       || LPAD(NVL(WD.A10_PERSON_CNT, 0), 15, '0')          -- �ο�.
                       || LPAD(NVL(WD.A10_PAYMENT_AMT, 0), 15, '0')         -- �����޾�.
                       || LPAD(NVL(WD.A10_INCOME_TAX_AMT, 0), 15, '0')      -- ¡������(�ҵ漼��).
                       || LPAD(NVL(WD.A10_SP_TAX_AMT, 0), 15, '0')          -- ¡������(��Ư��).
                       || LPAD(NVL(WD.A10_ADD_TAX_AMT, 0), 15, '0')         -- ���꼼.
                       || LPAD(NVL(WD.A10_THIS_REFUND_TAX_AMT, 0), 15, '0') -- �������ȯ�޼���.
                       || LPAD(NVL(WD.A10_PAY_INCOME_TAX_AMT, 0), 15, '0')  -- ���μ���(�ҵ漼��).
                       || LPAD(NVL(WD.A10_PAY_SP_TAX_AMT, 0), 15, '0')      -- ���μ���(��Ư��).
                       || RPAD(' ', 21, ' ')                                -- ����.
                         AS A10_RECORD_FILE
                       ,  '28'                                              -- �ڷᱸ��.
                       || 'O201'                                            -- �����ڵ�.
                       || 'A20'                                             -- ��õ�����ڵ�.
                       || LPAD(NVL(WD.A20_PERSON_CNT, 0), 15, '0')          -- �ο�.
                       || LPAD(NVL(WD.A20_PAYMENT_AMT, 0), 15, '0')         -- �����޾�.
                       || CASE
                            WHEN NVL(WD.A20_INCOME_TAX_AMT, 0) < 0 THEN
                              '-' || LPAD(ABS(NVL(WD.A20_INCOME_TAX_AMT, 0)), 14, '0')
                            ELSE LPAD(NVL(WD.A20_INCOME_TAX_AMT, 0), 15, '0')
                          END                                               -- ¡������(�ҵ漼��).
                       || LPAD(0, 15, '0')                                  -- ¡������(��Ư��).
                       || LPAD(NVL(WD.A20_ADD_TAX_AMT, 0), 15, '0')         -- ���꼼.
                       || LPAD(NVL(WD.A20_THIS_REFUND_TAX_AMT, 0), 15, '0') -- �������ȯ�޼���.
                       || LPAD(NVL(WD.A20_PAY_INCOME_TAX_AMT, 0), 15, '0')  -- ���μ���(�ҵ漼��).
                       || LPAD(0, 15, '0')                                  -- ���μ���(��Ư��).
                       || RPAD(' ', 21, ' ')                                -- ����.
                         AS A20_RECORD_FILE
                       ,  '28'                                              -- �ڷᱸ��.
                       || 'O201'                                            -- �����ڵ�.
                       || 'A21'                                             -- ��õ�����ڵ�.
                       || LPAD(NVL(WD.A21_PERSON_CNT, 0), 15, '0')          -- �ο�.
                       || LPAD(NVL(WD.A21_PAYMENT_AMT, 0), 15, '0')         -- �����޾�.
                       || CASE
                            WHEN NVL(WD.A21_INCOME_TAX_AMT, 0) < 0 THEN
                              '-' || LPAD(ABS(NVL(WD.A21_INCOME_TAX_AMT, 0)), 14, '0')
                            ELSE LPAD(NVL(WD.A21_INCOME_TAX_AMT, 0), 15, '0')
                          END                                               -- ¡������(�ҵ漼��).
                       || LPAD(0, 15, '0')                                  -- ¡������(��Ư��).
                       || LPAD(NVL(WD.A21_ADD_TAX_AMT, 0), 15, '0')         -- ���꼼.
                       || LPAD(NVL(WD.A21_THIS_REFUND_TAX_AMT, 0), 15, '0') -- �������ȯ�޼���.
                       || LPAD(NVL(WD.A21_PAY_INCOME_TAX_AMT, 0), 15, '0')  -- ���μ���(�ҵ漼��).
                       || LPAD(0, 15, '0')                                  -- ���μ���(��Ư��).
                       || RPAD(' ', 21, ' ')                                -- ����.
                         AS A21_RECORD_FILE
                       ,  '28'                                              -- �ڷᱸ��.
                       || 'O201'                                            -- �����ڵ�.
                       || 'A22'                                             -- ��õ�����ڵ�.
                       || LPAD(NVL(WD.A22_PERSON_CNT, 0), 15, '0')          -- �ο�.
                       || LPAD(NVL(WD.A22_PAYMENT_AMT, 0), 15, '0')         -- �����޾�.
                       || CASE
                            WHEN NVL(WD.A22_INCOME_TAX_AMT, 0) < 0 THEN
                              '-' || LPAD(ABS(NVL(WD.A22_INCOME_TAX_AMT, 0)), 14, '0')
                            ELSE LPAD(NVL(WD.A22_INCOME_TAX_AMT, 0), 15, '0')
                          END                                               -- ¡������(�ҵ漼��).
                       || LPAD(0, 15, '0')                                  -- ¡������(��Ư��).
                       || LPAD(NVL(WD.A22_ADD_TAX_AMT, 0), 15, '0')         -- ���꼼.
                       || LPAD(NVL(WD.A22_THIS_REFUND_TAX_AMT, 0), 15, '0') -- �������ȯ�޼���.
                       || LPAD(NVL(WD.A22_PAY_INCOME_TAX_AMT, 0), 15, '0')  -- ���μ���(�ҵ漼��).
                       || LPAD(0, 15, '0')                                  -- ���μ���(��Ư��).
                       || RPAD(' ', 21, ' ')                                -- ����.
                         AS A22_RECORD_FILE  
                       ,  '28'                                              -- �ڷᱸ��.
                       || 'O201'                                            -- �����ڵ�.
                       || 'A25'                                             -- ��õ�����ڵ�.
                       || LPAD(NVL(WD.A25_PERSON_CNT, 0), 15, '0')          -- �ο�.
                       || LPAD(NVL(WD.A25_PAYMENT_AMT, 0), 15, '0')         -- �����޾�.
                       || LPAD(NVL(WD.A25_INCOME_TAX_AMT, 0), 15, '0')      -- ¡������(�ҵ漼��).
                       || LPAD(0, 15, '0')                                  -- ¡������(��Ư��).
                       || LPAD(NVL(WD.A25_ADD_TAX_AMT, 0), 15, '0')         -- ���꼼.
                       || LPAD(0, 15, '0')                                  -- �������ȯ�޼���.
                       || LPAD(0, 15, '0')                                  -- ���μ���(�ҵ漼��).
                       || LPAD(0, 15, '0')                                  -- ���μ���(��Ư��).
                       || RPAD(' ', 21, ' ')                                -- ����.
                         AS A25_RECORD_FILE
                       ,  '28'                                              -- �ڷᱸ��.
                       || 'O201'                                            -- �����ڵ�.
                       || 'A26'                                             -- ��õ�����ڵ�.
                       || LPAD(NVL(WD.A26_PERSON_CNT, 0), 15, '0')          -- �ο�.
                       || LPAD(NVL(WD.A26_PAYMENT_AMT, 0), 15, '0')         -- �����޾�.
                       || CASE
                            WHEN NVL(WD.A26_INCOME_TAX_AMT, 0) < 0 THEN
                              '-' || LPAD(ABS(NVL(WD.A26_INCOME_TAX_AMT, 0)), 14, '0')
                            ELSE LPAD(NVL(WD.A26_INCOME_TAX_AMT, 0), 15, '0')
                          END                                               -- ¡������(�ҵ漼��).
                       || CASE
                            WHEN NVL(WD.A26_SP_TAX_AMT, 0) < 0 THEN
                              '-' || LPAD(ABS(NVL(WD.A26_SP_TAX_AMT, 0)), 14, '0')
                            ELSE LPAD(NVL(WD.A26_SP_TAX_AMT, 0), 15, '0')
                          END                                               -- ¡������(��Ư��).
                       || LPAD(NVL(WD.A26_ADD_TAX_AMT, 0), 15, '0')         -- ���꼼.
                       || LPAD(0, 15, '0')                                  -- �������ȯ�޼���.
                       || LPAD(0, 15, '0')                                  -- ���μ���(�ҵ漼��).
                       || LPAD(0, 15, '0')                                  -- ���μ���(��Ư��).
                       || RPAD(' ', 21, ' ')                                -- ����.
                         AS A26_RECORD_FILE
                       ,  '28'                                              -- �ڷᱸ��.
                       || 'O201'                                            -- �����ڵ�.
                       || 'A30'                                             -- ��õ�����ڵ�.
                       || LPAD(NVL(WD.A30_PERSON_CNT, 0), 15, '0')          -- �ο�.
                       || LPAD(NVL(WD.A30_PAYMENT_AMT, 0), 15, '0')         -- �����޾�.
                       || LPAD(NVL(WD.A30_INCOME_TAX_AMT, 0), 15, '0')      -- ¡������(�ҵ漼��).
                       || LPAD(NVL(WD.A30_SP_TAX_AMT, 0), 15, '0')          -- ¡������(��Ư��).
                       || LPAD(NVL(WD.A30_ADD_TAX_AMT, 0), 15, '0')         -- ���꼼.
                       || LPAD(NVL(WD.A30_THIS_REFUND_TAX_AMT, 0), 15, '0') -- �������ȯ�޼���.
                       || LPAD(NVL(WD.A30_PAY_INCOME_TAX_AMT, 0), 15, '0')  -- ���μ���(�ҵ漼��).
                       || LPAD(NVL(WD.A30_PAY_SP_TAX_AMT, 0), 15, '0')      -- ���μ���(��Ư��).
                       || RPAD(' ', 21, ' ')                                -- ����.
                         AS A30_RECORD_FILE
                       ,  '28'                                              -- �ڷᱸ��.
                       || 'O201'                                            -- �����ڵ�.
                       || 'A40'                                             -- ��õ�����ڵ�.
                       || LPAD(NVL(WD.A40_PERSON_CNT, 0), 15, '0')          -- �ο�.
                       || LPAD(NVL(WD.A40_PAYMENT_AMT, 0), 15, '0')         -- �����޾�.
                       || LPAD(NVL(WD.A40_INCOME_TAX_AMT, 0), 15, '0')      -- ¡������(�ҵ漼��).
                       || LPAD(0, 15, '0')          -- ¡������(��Ư��).
                       || LPAD(NVL(WD.A40_ADD_TAX_AMT, 0), 15, '0')         -- ���꼼.
                       || LPAD(NVL(WD.A40_THIS_REFUND_TAX_AMT, 0), 15, '0') -- �������ȯ�޼���.
                       || LPAD(NVL(WD.A40_PAY_INCOME_TAX_AMT, 0), 15, '0')  -- ���μ���(�ҵ漼��).
                       || LPAD(0, 15, '0')      -- ���μ���(��Ư��).
                       || RPAD(' ', 21, ' ')                                -- ����.
                         AS A40_RECORD_FILE  
                       ,  '28'                                              -- �ڷᱸ��.
                       || 'O201'                                            -- �����ڵ�.
                       || 'A41'                                             -- ��õ�����ڵ�.
                       || LPAD(NVL(WD.A41_PERSON_CNT, 0), 15, '0')          -- �ο�.
                       || LPAD(NVL(WD.A41_PAYMENT_AMT, 0), 15, '0')         -- �����޾�.
                       || LPAD(NVL(WD.A41_INCOME_TAX_AMT, 0), 15, '0')      -- ¡������(�ҵ漼��).
                       || LPAD(0, 15, '0')          -- ¡������(��Ư��).
                       || LPAD(NVL(WD.A41_ADD_TAX_AMT, 0), 15, '0')         -- ���꼼.
                       || LPAD(NVL(WD.A41_THIS_REFUND_TAX_AMT, 0), 15, '0') -- �������ȯ�޼���.
                       || LPAD(NVL(WD.A41_PAY_INCOME_TAX_AMT, 0), 15, '0')  -- ���μ���(�ҵ漼��).
                       || LPAD(0, 15, '0')      -- ���μ���(��Ư��).
                       || RPAD(' ', 21, ' ')                                -- ����.
                         AS A41_RECORD_FILE  
                       ,  '28'                                              -- �ڷᱸ��.
                       || 'O201'                                            -- �����ڵ�.
                       || 'A42'                                             -- ��õ�����ڵ�.
                       || LPAD(NVL(WD.A42_PERSON_CNT, 0), 15, '0')          -- �ο�.
                       || LPAD(NVL(WD.A42_PAYMENT_AMT, 0), 15, '0')         -- �����޾�.
                       || LPAD(NVL(WD.A42_INCOME_TAX_AMT, 0), 15, '0')      -- ¡������(�ҵ漼��).
                       || LPAD(0, 15, '0')          -- ¡������(��Ư��).
                       || LPAD(NVL(WD.A42_ADD_TAX_AMT, 0), 15, '0')         -- ���꼼.
                       || LPAD(NVL(WD.A42_THIS_REFUND_TAX_AMT, 0), 15, '0') -- �������ȯ�޼���.
                       || LPAD(NVL(WD.A42_PAY_INCOME_TAX_AMT, 0), 15, '0')  -- ���μ���(�ҵ漼��).
                       || LPAD(0, 15, '0')      -- ���μ���(��Ư��).
                       || RPAD(' ', 21, ' ')                                -- ����.
                         AS A42_RECORD_FILE    
                       ,  '28'                                              -- �ڷᱸ��.
                       || 'O201'                                            -- �����ڵ�.
                       || 'A45'                                             -- ��õ�����ڵ�.
                       || LPAD(NVL(WD.A45_PERSON_CNT, 0), 15, '0')          -- �ο�.
                       || LPAD(NVL(WD.A45_PAYMENT_AMT, 0), 15, '0')         -- �����޾�.
                       || LPAD(NVL(WD.A45_INCOME_TAX_AMT, 0), 15, '0')      -- ¡������(�ҵ漼��).
                       || LPAD(0, 15, '0')                                  -- ¡������(��Ư��).
                       || LPAD(NVL(WD.A45_ADD_TAX_AMT, 0), 15, '0')         -- ���꼼.
                       || LPAD(0, 15, '0')                                  -- �������ȯ�޼���.
                       || LPAD(0, 15, '0')                                  -- ���μ���(�ҵ漼��).
                       || LPAD(0, 15, '0')                                  -- ���μ���(��Ư��).
                       || RPAD(' ', 21, ' ')                                -- ����.
                         AS A45_RECORD_FILE
                       ,  '28'                                              -- �ڷᱸ��.
                       || 'O201'                                            -- �����ڵ�.
                       || 'A46'                                             -- ��õ�����ڵ�.
                       || LPAD(NVL(WD.A46_PERSON_CNT, 0), 15, '0')          -- �ο�.
                       || LPAD(NVL(WD.A46_PAYMENT_AMT, 0), 15, '0')         -- �����޾�.
                       || CASE
                            WHEN NVL(WD.A46_INCOME_TAX_AMT, 0) < 0 THEN
                              '-' || LPAD(ABS(NVL(WD.A46_INCOME_TAX_AMT, 0)), 14, '0')
                            ELSE LPAD(NVL(WD.A46_INCOME_TAX_AMT, 0), 15, '0')
                          END                                               -- ¡������(�ҵ漼��).
                       || LPAD(0, 15, '0')                                  -- ¡������(��Ư��).
                       || LPAD(NVL(WD.A46_ADD_TAX_AMT, 0), 15, '0')         -- ���꼼.
                       || LPAD(0, 15, '0')                                  -- �������ȯ�޼���.
                       || LPAD(0, 15, '0')                                  -- ���μ���(�ҵ漼��).
                       || LPAD(0, 15, '0')                                  -- ���μ���(��Ư��).
                       || RPAD(' ', 21, ' ')                                -- ����.
                         AS A46_RECORD_FILE
                       ,  '28'                                              -- �ڷᱸ��.
                       || 'O201'                                            -- �����ڵ�.
                       || 'A47'                                             -- ��õ�����ڵ�.
                       || LPAD(NVL(WD.A47_PERSON_CNT, 0), 15, '0')          -- �ο�.
                       || LPAD(NVL(WD.A47_PAYMENT_AMT, 0), 15, '0')         -- �����޾�.
                       || LPAD(NVL(WD.A47_INCOME_TAX_AMT, 0), 15, '0')      -- ¡������(�ҵ漼��).
                       || LPAD(0, 15, '0')          -- ¡������(��Ư��).
                       || LPAD(NVL(WD.A47_ADD_TAX_AMT, 0), 15, '0')         -- ���꼼.
                       || LPAD(NVL(WD.A47_THIS_REFUND_TAX_AMT, 0), 15, '0') -- �������ȯ�޼���.
                       || LPAD(NVL(WD.A47_PAY_INCOME_TAX_AMT, 0), 15, '0')  -- ���μ���(�ҵ漼��).
                       || LPAD(0, 15, '0')      -- ���μ���(��Ư��).
                       || RPAD(' ', 21, ' ')                                -- ����.
                         AS A47_RECORD_FILE
                       ,  '28'                                              -- �ڷᱸ��.
                       || 'O201'                                            -- �����ڵ�.
                       || 'A48'                                             -- ��õ�����ڵ�.
                       || LPAD(NVL(WD.A48_PERSON_CNT, 0), 15, '0')          -- �ο�.
                       || LPAD(NVL(WD.A48_PAYMENT_AMT, 0), 15, '0')         -- �����޾�.
                       || LPAD(NVL(WD.A48_INCOME_TAX_AMT, 0), 15, '0')      -- ¡������(�ҵ漼��).
                       || LPAD(0, 15, '0')                                  -- ¡������(��Ư��).
                       || LPAD(NVL(WD.A48_ADD_TAX_AMT, 0), 15, '0')         -- ���꼼.
                       || LPAD(0, 15, '0')                                  -- �������ȯ�޼���.
                       || LPAD(0, 15, '0')                                  -- ���μ���(�ҵ漼��).
                       || LPAD(0, 15, '0')                                  -- ���μ���(��Ư��).
                       || RPAD(' ', 21, ' ')                                -- ����.
                         AS A48_RECORD_FILE
                       ,  '28'                                              -- �ڷᱸ��.
                       || 'O201'                                            -- �����ڵ�.
                       || 'A50'                                             -- ��õ�����ڵ�.
                       || LPAD(NVL(WD.A50_PERSON_CNT, 0), 15, '0')          -- �ο�.
                       || LPAD(NVL(WD.A50_PAYMENT_AMT, 0), 15, '0')         -- �����޾�.
                       || LPAD(NVL(WD.A50_INCOME_TAX_AMT, 0), 15, '0')      -- ¡������(�ҵ漼��).
                       || LPAD(NVL(WD.A50_SP_TAX_AMT, 0), 15, '0')          -- ¡������(��Ư��).
                       || LPAD(NVL(WD.A50_ADD_TAX_AMT, 0), 15, '0')         -- ���꼼.
                       || LPAD(NVL(WD.A50_THIS_REFUND_TAX_AMT, 0), 15, '0') -- �������ȯ�޼���.
                       || LPAD(NVL(WD.A50_PAY_INCOME_TAX_AMT, 0), 15, '0')  -- ���μ���(�ҵ漼��).
                       || LPAD(NVL(WD.A50_PAY_SP_TAX_AMT, 0), 15, '0')      -- ���μ���(��Ư��).
                       || RPAD(' ', 21, ' ')                                -- ����.
                         AS A50_RECORD_FILE
                       ,  '28'                                              -- �ڷᱸ��.
                       || 'O201'                                            -- �����ڵ�.
                       || 'A60'                                             -- ��õ�����ڵ�.
                       || LPAD(NVL(WD.A60_PERSON_CNT, 0), 15, '0')          -- �ο�.
                       || LPAD(NVL(WD.A60_PAYMENT_AMT, 0), 15, '0')         -- �����޾�.
                       || LPAD(NVL(WD.A60_INCOME_TAX_AMT, 0), 15, '0')      -- ¡������(�ҵ漼��).
                       || LPAD(NVL(WD.A60_SP_TAX_AMT, 0), 15, '0')          -- ¡������(��Ư��).
                       || LPAD(NVL(WD.A60_ADD_TAX_AMT, 0), 15, '0')         -- ���꼼.
                       || LPAD(NVL(WD.A60_THIS_REFUND_TAX_AMT, 0), 15, '0') -- �������ȯ�޼���.
                       || LPAD(NVL(WD.A60_PAY_INCOME_TAX_AMT, 0), 15, '0')  -- ���μ���(�ҵ漼��).
                       || LPAD(NVL(WD.A60_PAY_SP_TAX_AMT, 0), 15, '0')      -- ���μ���(��Ư��).
                       || RPAD(' ', 21, ' ')                                -- ����.
                         AS A60_RECORD_FILE
                       ,  '28'                                              -- �ڷᱸ��.
                       || 'O201'                                            -- �����ڵ�.
                       || 'A69'                                             -- ��õ�����ڵ�.
                       || LPAD(NVL(WD.A69_PERSON_CNT, 0), 15, '0')          -- �ο�.
                       || LPAD(0, 15, '0')                                  -- �����޾�.
                       || LPAD(NVL(WD.A69_INCOME_TAX_AMT, 0), 15, '0')      -- ¡������(�ҵ漼��).
                       || LPAD(0, 15, '0')                                  -- ¡������(��Ư��).
                       || LPAD(NVL(WD.A69_ADD_TAX_AMT, 0), 15, '0')         -- ���꼼.
                       || LPAD(NVL(WD.A69_THIS_REFUND_TAX_AMT, 0), 15, '0') -- �������ȯ�޼���.
                       || LPAD(NVL(WD.A69_PAY_INCOME_TAX_AMT, 0), 15, '0')  -- ���μ���(�ҵ漼��).
                       || LPAD(0, 15, '0')                                  -- ���μ���(��Ư��).
                       || RPAD(' ', 21, ' ')                                -- ����.
                         AS A69_RECORD_FILE
                       ,  '28'                                              -- �ڷᱸ��.
                       || 'O201'                                            -- �����ڵ�.
                       || 'A70'                                             -- ��õ�����ڵ�.
                       || LPAD(NVL(WD.A70_PERSON_CNT, 0), 15, '0')          -- �ο�.
                       || LPAD(NVL(WD.A70_PAYMENT_AMT, 0), 15, '0')         -- �����޾�.
                       || LPAD(NVL(WD.A70_INCOME_TAX_AMT, 0), 15, '0')      -- ¡������(�ҵ漼��).
                       || LPAD(0, 15, '0')                                  -- ¡������(��Ư��).
                       || LPAD(NVL(WD.A70_ADD_TAX_AMT, 0), 15, '0')         -- ���꼼.
                       || LPAD(NVL(WD.A70_THIS_REFUND_TAX_AMT, 0), 15, '0') -- �������ȯ�޼���.
                       || LPAD(NVL(WD.A70_PAY_INCOME_TAX_AMT, 0), 15, '0')  -- ���μ���(�ҵ漼��).
                       || LPAD(0, 15, '0')                                  -- ���μ���(��Ư��).
                       || RPAD(' ', 21, ' ')                                -- ����.
                         AS A70_RECORD_FILE
                       ,  '28'                                              -- �ڷᱸ��.
                       || 'O201'                                            -- �����ڵ�.
                       || 'A80'                                             -- ��õ�����ڵ�.
                       || LPAD(NVL(WD.A80_PERSON_CNT, 0), 15, '0')          -- �ο�.
                       || LPAD(NVL(WD.A80_PAYMENT_AMT, 0), 15, '0')         -- �����޾�.
                       || LPAD(NVL(WD.A80_INCOME_TAX_AMT, 0), 15, '0')      -- ¡������(�ҵ漼��).
                       || LPAD(0, 15, '0')                                  -- ¡������(��Ư��).
                       || LPAD(NVL(WD.A80_ADD_TAX_AMT, 0), 15, '0')         -- ���꼼.
                       || LPAD(NVL(WD.A80_THIS_REFUND_TAX_AMT, 0), 15, '0') -- �������ȯ�޼���.
                       || LPAD(NVL(WD.A80_PAY_INCOME_TAX_AMT, 0), 15, '0')  -- ���μ���(�ҵ漼��).
                       || LPAD(0, 15, '0')                                  -- ���μ���(��Ư��).
                       || RPAD(' ', 21, ' ')                                -- ����.
                         AS A80_RECORD_FILE
                       ,  '28'                                              -- �ڷᱸ��.
                       || 'O201'                                            -- �����ڵ�.
                       || 'A90'                                             -- ��õ�����ڵ�.
                       || LPAD(0, 15, '0')                                  -- �ο�.
                       || LPAD(0, 15, '0')                                  -- �����޾�.
                       || CASE
                            WHEN NVL(WD.A90_INCOME_TAX_AMT, 0) < 0 THEN
                              '-' || LPAD(ABS(NVL(WD.A90_INCOME_TAX_AMT, 0)), 14, '0')
                            ELSE LPAD(NVL(WD.A90_INCOME_TAX_AMT, 0), 15, '0')
                          END                                               -- ¡������(�ҵ漼��).
                       || CASE
                            WHEN NVL(WD.A90_SP_TAX_AMT, 0) < 0 THEN
                              '-' || LPAD(ABS(NVL(WD.A90_SP_TAX_AMT, 0)), 14, '0')
                            ELSE LPAD(NVL(WD.A90_SP_TAX_AMT, 0), 15, '0')
                          END                                               -- ¡������(��Ư��).
                       || LPAD(NVL(WD.A90_ADD_TAX_AMT, 0), 15, '0')         -- ���꼼.
                       || LPAD(NVL(WD.A90_THIS_REFUND_TAX_AMT, 0), 15, '0') -- �������ȯ�޼���.
                       || LPAD(NVL(WD.A90_PAY_INCOME_TAX_AMT, 0), 15, '0')  -- ���μ���(�ҵ漼��).
                       || LPAD(NVL(WD.A90_PAY_SP_TAX_AMT, 0), 15, '0')      -- ���μ���(��Ư��).
                       || RPAD(' ', 21, ' ')                                -- ����.
                         AS A90_RECORD_FILE
                       ,  '28'                                              -- �ڷᱸ��.
                       || 'O201'                                            -- �����ڵ�.
                       || 'A99'                                             -- ��õ�����ڵ�.
                       || LPAD(NVL(WD.A99_PERSON_CNT, 0), 15, '0')          -- �ο�.
                       || LPAD(NVL(WD.A99_PAYMENT_AMT, 0), 15, '0')         -- �����޾�.
                       || LPAD(NVL(WD.A99_INCOME_TAX_AMT, 0), 15, '0')      -- ¡������(�ҵ漼��).
                       || LPAD(NVL(WD.A99_SP_TAX_AMT, 0), 15, '0')          -- ¡������(��Ư��).
                       || LPAD(NVL(WD.A99_ADD_TAX_AMT, 0), 15, '0')         -- ���꼼.
                       || CASE
                            WHEN WD.WITHHOLDING_TYPE = '2' AND NVL(WD.A99_THIS_REFUND_TAX_AMT, 0) < 0 THEN
                              '-' || LPAD(ABS(NVL(WD.A99_THIS_REFUND_TAX_AMT, 0)), 14, '0')
                            ELSE LPAD(NVL(WD.A99_THIS_REFUND_TAX_AMT, 0), 15, '0') 
                          END                                               -- �������ȯ�޼���.
                       || LPAD(NVL(WD.A99_PAY_INCOME_TAX_AMT, 0), 15, '0')  -- ���μ���(�ҵ漼��).
                       || LPAD(NVL(WD.A99_PAY_SP_TAX_AMT, 0), 15, '0')      -- ���μ���(��Ư��).
                       || RPAD(' ', 21, ' ')                                -- ����.
                         AS A99_RECORD_FILE
                    FROM HRW_WITHHOLDING_DOC WD
                      , HRM_CORP_MASTER CM
                      , HRW_HOMETAX_INFO HI
                  WHERE WD.CORP_ID            = CM.CORP_ID
                    AND WD.CORP_ID            = HI.CORP_ID
                    AND WD.WITHHOLDING_NO     = C1.SOURCE_WITHHOLDING_NO
                    AND WD.SOB_ID             = P_SOB_ID
                    AND WD.ORG_ID             = P_ORG_ID
                    AND '2'                   = C1.WITHHOLDING_TYPE
                )
      LOOP
        -- ��õ¡�������Ȳ�Ű�.
        V_SEQ_NUM := 20;
        V_SOURCE_FILE := 'HEADER';
        INSERT_REPORT_FILE
          ( P_SEQ_NUM           => V_SEQ_NUM
          , P_SOURCE_FILE       => V_SOURCE_FILE
          , P_SOB_ID            => P_SOB_ID
          , P_ORG_ID            => P_ORG_ID
          , P_REPORT_FILE       => C1.H_RECORD_FILE
          , P_SORT_NUM          => 2
          );
        -- ��õ¡�������Ȳ�Ű�-����(A01).
      V_SEQ_NUM := 201;
      V_SOURCE_FILE := 'A01_RECORD';
      INSERT_REPORT_FILE
        ( P_SEQ_NUM           => V_SEQ_NUM
        , P_SOURCE_FILE       => V_SOURCE_FILE
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , P_REPORT_FILE       => C1.A01_RECORD_FILE
        , P_SORT_NUM          => 1
        );
      V_SEQ_NUM := 202;
      V_SOURCE_FILE := 'A02_RECORD';
      INSERT_REPORT_FILE
        ( P_SEQ_NUM           => V_SEQ_NUM
        , P_SOURCE_FILE       => V_SOURCE_FILE
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , P_REPORT_FILE       => C1.A02_RECORD_FILE
        , P_SORT_NUM          => 1
        );
      V_SEQ_NUM := 203;
      V_SOURCE_FILE := 'A03_RECORD';
      INSERT_REPORT_FILE
        ( P_SEQ_NUM           => V_SEQ_NUM
        , P_SOURCE_FILE       => V_SOURCE_FILE
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , P_REPORT_FILE       => C1.A03_RECORD_FILE
        , P_SORT_NUM          => 1
        );  
      V_SEQ_NUM := 204;
      V_SOURCE_FILE := 'A04_RECORD';
      INSERT_REPORT_FILE
        ( P_SEQ_NUM           => V_SEQ_NUM
        , P_SOURCE_FILE       => V_SOURCE_FILE
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , P_REPORT_FILE       => C1.A04_RECORD_FILE
        , P_SORT_NUM          => 1
        );
      V_SEQ_NUM := 210;
      V_SOURCE_FILE := 'A10_RECORD';
      INSERT_REPORT_FILE
        ( P_SEQ_NUM           => V_SEQ_NUM
        , P_SOURCE_FILE       => V_SOURCE_FILE
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , P_REPORT_FILE       => C1.A10_RECORD_FILE
        , P_SORT_NUM          => 1  
        );   
      V_SEQ_NUM := 221;
      V_SOURCE_FILE := 'A21_RECORD';
      INSERT_REPORT_FILE
        ( P_SEQ_NUM           => V_SEQ_NUM
        , P_SOURCE_FILE       => V_SOURCE_FILE
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , P_REPORT_FILE       => C1.A21_RECORD_FILE
        , P_SORT_NUM          => 1
        );        
      V_SEQ_NUM := 222;
      V_SOURCE_FILE := 'A22_RECORD';
      INSERT_REPORT_FILE
        ( P_SEQ_NUM           => V_SEQ_NUM
        , P_SOURCE_FILE       => V_SOURCE_FILE
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , P_REPORT_FILE       => C1.A22_RECORD_FILE
        , P_SORT_NUM          => 1
        );                   
      V_SEQ_NUM := 224;
      V_SOURCE_FILE := 'A20_RECORD';
      INSERT_REPORT_FILE
        ( P_SEQ_NUM           => V_SEQ_NUM
        , P_SOURCE_FILE       => V_SOURCE_FILE
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , P_REPORT_FILE       => C1.A20_RECORD_FILE
        , P_SORT_NUM          => 1
        );        
      V_SEQ_NUM := 225;
      V_SOURCE_FILE := 'A25_RECORD';
      INSERT_REPORT_FILE
        ( P_SEQ_NUM           => V_SEQ_NUM
        , P_SOURCE_FILE       => V_SOURCE_FILE
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , P_REPORT_FILE       => C1.A25_RECORD_FILE
        , P_SORT_NUM          => 1
        );
      V_SEQ_NUM := 226;
      V_SOURCE_FILE := 'A26_RECORD';
      INSERT_REPORT_FILE
        ( P_SEQ_NUM           => V_SEQ_NUM
        , P_SOURCE_FILE       => V_SOURCE_FILE
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , P_REPORT_FILE       => C1.A26_RECORD_FILE
        , P_SORT_NUM          => 1
        );  
      V_SEQ_NUM := 230;
      V_SOURCE_FILE := 'A30_RECORD';
      INSERT_REPORT_FILE
        ( P_SEQ_NUM           => V_SEQ_NUM
        , P_SOURCE_FILE       => V_SOURCE_FILE
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , P_REPORT_FILE       => C1.A30_RECORD_FILE
        , P_SORT_NUM          => 1
        );  
      V_SEQ_NUM := 241;
      V_SOURCE_FILE := 'A41_RECORD';
      INSERT_REPORT_FILE
        ( P_SEQ_NUM           => V_SEQ_NUM
        , P_SOURCE_FILE       => V_SOURCE_FILE
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , P_REPORT_FILE       => C1.A41_RECORD_FILE
        , P_SORT_NUM          => 1
        );  
      V_SEQ_NUM := 242;
      V_SOURCE_FILE := 'A42_RECORD';
      INSERT_REPORT_FILE
        ( P_SEQ_NUM           => V_SEQ_NUM
        , P_SOURCE_FILE       => V_SOURCE_FILE
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , P_REPORT_FILE       => C1.A42_RECORD_FILE
        , P_SORT_NUM          => 1
        );  
      V_SEQ_NUM := 244;
      V_SOURCE_FILE := 'A40_RECORD';
      INSERT_REPORT_FILE
        ( P_SEQ_NUM           => V_SEQ_NUM
        , P_SOURCE_FILE       => V_SOURCE_FILE
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , P_REPORT_FILE       => C1.A40_RECORD_FILE
        , P_SORT_NUM          => 1
        );  
      V_SEQ_NUM := 245;
      V_SOURCE_FILE := 'A48_RECORD';
      INSERT_REPORT_FILE
        ( P_SEQ_NUM           => V_SEQ_NUM
        , P_SOURCE_FILE       => V_SOURCE_FILE
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , P_REPORT_FILE       => C1.A48_RECORD_FILE
        , P_SORT_NUM          => 1
        );
      V_SEQ_NUM := 245.5;
      V_SOURCE_FILE := 'A45_RECORD';
      INSERT_REPORT_FILE
        ( P_SEQ_NUM           => V_SEQ_NUM
        , P_SOURCE_FILE       => V_SOURCE_FILE
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , P_REPORT_FILE       => C1.A45_RECORD_FILE
        , P_SORT_NUM          => 1
        );
      V_SEQ_NUM := 246;
      V_SOURCE_FILE := 'A46_RECORD';
      INSERT_REPORT_FILE
        ( P_SEQ_NUM           => V_SEQ_NUM
        , P_SOURCE_FILE       => V_SOURCE_FILE
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , P_REPORT_FILE       => C1.A46_RECORD_FILE
        , P_SORT_NUM          => 1
        );
      V_SEQ_NUM := 247;
      V_SOURCE_FILE := 'A47_RECORD';
      INSERT_REPORT_FILE
        ( P_SEQ_NUM           => V_SEQ_NUM
        , P_SOURCE_FILE       => V_SOURCE_FILE
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , P_REPORT_FILE       => C1.A47_RECORD_FILE
        , P_SORT_NUM          => 1
        );
      V_SEQ_NUM := 250;
      V_SOURCE_FILE := 'A50_RECORD';
      INSERT_REPORT_FILE
        ( P_SEQ_NUM           => V_SEQ_NUM
        , P_SOURCE_FILE       => V_SOURCE_FILE
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , P_REPORT_FILE       => C1.A50_RECORD_FILE
        , P_SORT_NUM          => 1
        );
      V_SEQ_NUM := 260;
      V_SOURCE_FILE := 'A60_RECORD';
      INSERT_REPORT_FILE
        ( P_SEQ_NUM           => V_SEQ_NUM
        , P_SOURCE_FILE       => V_SOURCE_FILE
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , P_REPORT_FILE       => C1.A60_RECORD_FILE
        , P_SORT_NUM          => 1
        );
      V_SEQ_NUM := 269;
      V_SOURCE_FILE := 'A69_RECORD';
      INSERT_REPORT_FILE
        ( P_SEQ_NUM           => V_SEQ_NUM
        , P_SOURCE_FILE       => V_SOURCE_FILE
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , P_REPORT_FILE       => C1.A69_RECORD_FILE
        , P_SORT_NUM          => 1
        );
      V_SEQ_NUM := 270;
      V_SOURCE_FILE := 'A70_RECORD';
      INSERT_REPORT_FILE
        ( P_SEQ_NUM           => V_SEQ_NUM
        , P_SOURCE_FILE       => V_SOURCE_FILE
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , P_REPORT_FILE       => C1.A70_RECORD_FILE
        , P_SORT_NUM          => 1
        );
      V_SEQ_NUM := 280;
      V_SOURCE_FILE := 'A80_RECORD';
      INSERT_REPORT_FILE
        ( P_SEQ_NUM           => V_SEQ_NUM
        , P_SOURCE_FILE       => V_SOURCE_FILE
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , P_REPORT_FILE       => C1.A80_RECORD_FILE
        , P_SORT_NUM          => 1
        );
      V_SEQ_NUM := 290;
      V_SOURCE_FILE := 'A90_RECORD';
      INSERT_REPORT_FILE
        ( P_SEQ_NUM           => V_SEQ_NUM
        , P_SOURCE_FILE       => V_SOURCE_FILE
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , P_REPORT_FILE       => C1.A90_RECORD_FILE
        , P_SORT_NUM          => 1
        );
      V_SEQ_NUM := 299;
      V_SOURCE_FILE := 'A99_RECORD';
      INSERT_REPORT_FILE
        ( P_SEQ_NUM           => V_SEQ_NUM
        , P_SOURCE_FILE       => V_SOURCE_FILE
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , P_REPORT_FILE       => C1.A99_RECORD_FILE
        , P_SORT_NUM          => 1
        );
      END LOOP C2;      
    END LOOP C1;
    O_STATUS := 'S';
  END SET_FILE1;

-------------------------------------------------------------------------------
-- ���� DATA INSERT.
-------------------------------------------------------------------------------
  PROCEDURE INSERT_REPORT_FILE
            ( P_SEQ_NUM           IN NUMBER
            , P_SOURCE_FILE       IN VARCHAR2
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , P_REPORT_FILE       IN VARCHAR2
            , P_SORT_NUM          IN NUMBER
            )
  AS
  BEGIN
    INSERT INTO HRM_REPORT_FILE_GT
    ( SEQ_NUM
    , SOURCE_FILE
    , SOB_ID
    , ORG_ID
    , REPORT_FILE
    , SORT_NUM
    ) VALUES
    ( P_SEQ_NUM
    , P_SOURCE_FILE
    , P_SOB_ID
    , P_ORG_ID
    , P_REPORT_FILE
    , P_SORT_NUM
    );  
  END INSERT_REPORT_FILE;

-------------------------------------------------------------------------------
-- ���� ��ȣȭ ��й�ȣ ��ȸ
-------------------------------------------------------------------------------
  PROCEDURE GET_ENCRYPT_PWD
            ( P_CORP_ID           IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , O_ENCRYPT_PWD       OUT VARCHAR2
            )
  AS
  BEGIN
    BEGIN
      SELECT HI.ENCRYPT_PWD
        INTO O_ENCRYPT_PWD      
        FROM HRW_HOMETAX_INFO HI
      WHERE HI.CORP_ID            = P_CORP_ID
        AND HI.SOB_ID             = P_SOB_ID
        AND HI.ORG_ID             = P_ORG_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      O_ENCRYPT_PWD := NULL;  
    END;
  END GET_ENCRYPT_PWD;
  
END HRW_WITHHOLDING_FILE_G;
/
