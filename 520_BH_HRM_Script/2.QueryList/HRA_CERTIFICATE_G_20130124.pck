CREATE OR REPLACE PACKAGE HRA_CERTIFICATE_G
AS

-------------------------------------------------------------------------------------------
-- �ٷμҵ��õ¡�������� Main - Grid
-------------------------------------------------------------------------------------------

-- DATA_SELECT.
  PROCEDURE DATA_SELECT(P_CURSOR                                          OUT TYPES.TCURSOR
                      , W_CORP_ID                                         IN NUMBER
                      , W_STD_DATE                                        IN DATE
                      , W_PERSON_ID                                       IN NUMBER
                      , W_CERT_TYPE_ID                                    IN NUMBER
                      , W_SOB_ID                                          IN NUMBER
                      , W_ORG_ID                                          IN NUMBER);

-- DATA_INSERT.
  PROCEDURE DATA_INSERT
            ( P_PRINT_NUM             OUT HRA_CERTIFICATE.PRINT_NUM%TYPE
            , P_CORP_ID               IN NUMBER
            , P_PRINT_DATE            IN DATE
            , P_PERSON_ID             IN NUMBER
            , P_PRINT_YEAR            IN VARCHAR2
            , P_CERT_TYPE_ID          IN NUMBER
            , P_PRINT_COUNT           IN NUMBER
            , P_SEND_ORG              IN VARCHAR2
            , P_DESCRIPTION           IN VARCHAR2
            , P_SOB_ID                IN NUMBER
            , P_ORG_ID                IN NUMBER
            , P_USER_ID               IN NUMBER);

-- DATA_UPDATE.
  PROCEDURE DATA_UPDATE
            ( W_PRINT_NUM             IN HRA_CERTIFICATE.PRINT_NUM%TYPE
            , W_CORP_ID               IN NUMBER
            , W_SOB_ID                IN NUMBER
            , W_ORG_ID                IN NUMBER
            , P_CERT_TYPE_ID          IN NUMBER
            , P_PRINT_COUNT           IN NUMBER
            , P_SEND_ORG              IN VARCHAR2
            , P_DESCRIPTION           IN VARCHAR2
            , P_USER_ID               IN NUMBER);

-- SELECT PRINT DATA..
  PROCEDURE SELECT_PRINT_DATA
            ( P_CURSOR2               OUT TYPES.TCURSOR2
            , W_PRINT_NUM             IN HRA_CERTIFICATE.PRINT_NUM%TYPE
            );
            
-------------------------------------------------------------------------------------------
-- �ٷμҵ��õ¡�������� Report - Grid
-------------------------------------------------------------------------------------------

-- �ٷμҵ��õ¡��������/�ٷμҵ� ���޸���
  PROCEDURE SELECT_WITHHOLDING_TAX
            ( P_CURSOR                OUT TYPES.TCURSOR
            , W_CORP_ID               IN NUMBER
            , W_PERSON_ID             IN NUMBER
            , W_YEAR_YYYY             IN VARCHAR2
            , W_DEPT_ID               IN NUMBER
            , W_SOB_ID                IN NUMBER
            , W_ORG_ID                IN NUMBER
            , W_JOB_CATEGORY_ID       IN NUMBER
            , W_EMPLOYE_3_YN          IN VARCHAR2
            );

-- �ξ簡������
  PROCEDURE SELECT_SUPPORT_FAMILY
            ( P_CURSOR               OUT TYPES.TCURSOR
            , W_PERSON_ID             IN NUMBER
            , W_YEAR_YYYY             IN VARCHAR2
            , W_SOB_ID                IN NUMBER
            , W_ORG_ID                IN NUMBER
            ); 

/*        
-- ����*���� �� �ҵ���� ����
  PROCEDURE SELECT_SAVING_INFO

            
*/

-------------------------------------------------------------------------------------------
-- �����ٷμҵ濡���Ѽҵ漼��õ¡������ �μ�--
-------------------------------------------------------------------------------------------
  PROCEDURE PRINT_INCOME_TAX
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_PERSON_ID         IN NUMBER
            , W_START_DATE        IN VARCHAR2
            , W_END_DATE          IN VARCHAR2
            , W_SOB_ID            IN NUMBER
            , W_ORG_ID            IN NUMBER
            );
            
-------------------------------------------------------------------------------------------
-- �ҵ��ں� �ٷμҵ��õ¡���� --
-------------------------------------------------------------------------------------------
  PROCEDURE PRINT_IN_EARNER_DED_TAX
            ( P_CURSOR            OUT TYPES.TCURSOR
            , P_CORP_ID           IN NUMBER
            , P_PERSON_ID         IN NUMBER
            , P_YEAR_YYYY         IN VARCHAR2
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            );

            
END HRA_CERTIFICATE_G;
/
CREATE OR REPLACE PACKAGE BODY HRA_CERTIFICATE_G
AS
/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRA_CERTIFICATE_G
/* Description  : �ٷμҵ��õ¡��������
/*
/* Reference by : �ٷμҵ��õ¡��������
/* Program History : 
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 2-MAY-2011  Lee Sun Hee        Initialize
/******************************************************************************/

-- DATA_SELECT.
  PROCEDURE DATA_SELECT(P_CURSOR                                         OUT TYPES.TCURSOR
                      , W_CORP_ID                                         IN NUMBER
                      , W_STD_DATE                                        IN DATE
                      , W_PERSON_ID                                       IN NUMBER
                      , W_CERT_TYPE_ID                                    IN NUMBER
                      , W_SOB_ID                                          IN NUMBER
                      , W_ORG_ID                                          IN NUMBER)
  AS
  BEGIN
     OPEN P_CURSOR FOR
        SELECT HC.PRINT_NUM
             , HC.CORP_ID
             , HC.PRINT_DATE
             , HC.PERSON_ID
             , HC.PRINT_YEAR
             , DECODE(HC.PERSON_ID, 0, '��ü', PM.NAME) AS PERSON_NAME
             , PM.JOIN_DATE
             , PM.RETIRE_DATE
             , HC.CERT_TYPE_ID
             , HRM_COMMON_G.ID_NAME_F(HC.CERT_TYPE_ID) CERT_TYPE_NAME
             , HRM_COMMON_G.GET_CODE_F(HC.CERT_TYPE_ID, W_SOB_ID, W_ORG_ID) AS CERT_TYPE_CODE
             , HC.DESCRIPTION
             , HC.PRINT_COUNT
             , HC.SEND_ORG
         FROM HRA_CERTIFICATE HC
            , HRM_PERSON_MASTER PM
         WHERE HC.PERSON_ID                            = PM.PERSON_ID(+)
           AND HC.CORP_ID                              = W_CORP_ID
           AND HC.PRINT_DATE                           <= W_STD_DATE
           AND HC.PERSON_ID                            = NVL(W_PERSON_ID, HC.PERSON_ID)
           AND HC.CERT_TYPE_ID                         = NVL(W_CERT_TYPE_ID, HC.CERT_TYPE_ID)
           AND HC.SOB_ID                               = W_SOB_ID
           AND HC.ORG_ID                               = W_ORG_ID
        ORDER BY HC.PRINT_NUM DESC   
        ;

  END DATA_SELECT;

-- DATA_INSERT.
  PROCEDURE DATA_INSERT
            ( P_PRINT_NUM             OUT HRA_CERTIFICATE.PRINT_NUM%TYPE
            , P_CORP_ID               IN NUMBER
            , P_PRINT_DATE            IN DATE
            , P_PERSON_ID             IN NUMBER
            , P_PRINT_YEAR            IN VARCHAR2
            , P_CERT_TYPE_ID          IN NUMBER
            , P_PRINT_COUNT           IN NUMBER
            , P_SEND_ORG              IN VARCHAR2
            , P_DESCRIPTION           IN VARCHAR2
            , P_SOB_ID                IN NUMBER
            , P_ORG_ID                IN NUMBER
            , P_USER_ID               IN NUMBER)
  AS
    V_CHECK_MONTH                                                         VARCHAR2(6) := NULL;
    N_CHECK_SEQ                                                           NUMBER := 0;
    
  BEGIN
      V_CHECK_MONTH := TO_CHAR(SYSDATE, 'YYYYMM');
      BEGIN
        SELECT NVL(MAX(HC.CHECK_SEQ), 0) + 1 NEW_CHECK_SEQ
          INTO N_CHECK_SEQ
        FROM HRA_CERTIFICATE HC
        WHERE HC.CHECK_MONTH          = V_CHECK_MONTH
          AND HC.CORP_ID              = P_CORP_ID
          AND HC.SOB_ID               = P_SOB_ID
          AND HC.ORG_ID               = P_ORG_ID
        ;
      EXCEPTION WHEN OTHERS THEN
        N_CHECK_SEQ := 1;
      END;
--      RAISE_APPLICATION_ERROR(-20001, V_CHECK_MONTH || '/' || N_CHECK_SEQ || '/' || P_CORP_ID);
      -- �����ȣ ����.
      P_PRINT_NUM := V_CHECK_MONTH || '-' || LPAD(N_CHECK_SEQ, 3, 0);
--      DBMS_OUTPUT.PUT_LINE('N_PRINT_SEQ : ' || N_PRINT_SEQ || ', V_PRINT_NUM : ' || V_PRINT_NUM);
      INSERT INTO HRA_CERTIFICATE
      ( PRINT_NUM
      , CORP_ID, PRINT_DATE, PERSON_ID, PRINT_YEAR
      , CERT_TYPE_ID, PRINT_COUNT, SEND_ORG
      , DESCRIPTION
      , CHECK_MONTH, CHECK_SEQ
      , SOB_ID, ORG_ID
      , CREATION_DATE, CREATED_BY, LAST_UPDATE_DATE, LAST_UPDATED_BY
      ) VALUES
      ( P_PRINT_NUM
      , P_CORP_ID, TRUNC(P_PRINT_DATE), NVL(P_PERSON_ID, 0), P_PRINT_YEAR
      , P_CERT_TYPE_ID, P_PRINT_COUNT, P_SEND_ORG
      , P_DESCRIPTION
      , V_CHECK_MONTH, N_CHECK_SEQ
      , P_SOB_ID, P_ORG_ID
      , SYSDATE, P_USER_ID, SYSDATE, P_USER_ID
      );
      
  END DATA_INSERT;

-- DATA_UPDATE.
  PROCEDURE DATA_UPDATE
            ( W_PRINT_NUM             IN HRA_CERTIFICATE.PRINT_NUM%TYPE
            , W_CORP_ID               IN NUMBER
            , W_SOB_ID                IN NUMBER
            , W_ORG_ID                IN NUMBER
            , P_CERT_TYPE_ID          IN NUMBER
            , P_PRINT_COUNT           IN NUMBER
            , P_SEND_ORG              IN VARCHAR2
            , P_DESCRIPTION           IN VARCHAR2
            , P_USER_ID               IN NUMBER)
  AS
  BEGIN
      UPDATE HRA_CERTIFICATE HC
        SET HC.CERT_TYPE_ID                                               = P_CERT_TYPE_ID
              , HC.PRINT_COUNT                                            = P_PRINT_COUNT
              , HC.SEND_ORG                                               = P_SEND_ORG
              , HC.DESCRIPTION                                            = P_DESCRIPTION
              , HC.LAST_UPDATE_DATE                                       = SYSDATE
              , HC.LAST_UPDATED_BY                                        = P_USER_ID
      WHERE HC.PRINT_NUM                                                  = W_PRINT_NUM
        AND HC.CORP_ID                                                    = W_CORP_ID
        AND HC.SOB_ID                                                     = W_SOB_ID
        AND HC.ORG_ID                                                     = W_ORG_ID
      ;

  END DATA_UPDATE;

-- SELECT PRINT DATA..
  PROCEDURE SELECT_PRINT_DATA
            ( P_CURSOR2               OUT TYPES.TCURSOR2
            , W_PRINT_NUM             IN HRA_CERTIFICATE.PRINT_NUM%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR2 FOR
      SELECT HC.PRINT_NUM
           , HRM_COMMON_G.ID_NAME_F(HC.CERT_TYPE_ID) AS CERTIFICATE_TYPE_NAME
           , PM.NAME
           , PM.NAME2 AS CHINESE_NAME
           , PM.REPRE_NUM
           , PM.LIVE_ADDR1 || ' ' || PM.LEGAL_ADDR2 AS PERSON_ADDRESS
           , HRM_DEPT_MASTER_G.DEPT_NAME_F(PM.DEPT_ID) AS DEPT_NAME
           , HRM_COMMON_G.ID_NAME_F(PM.POST_ID) AS POST_NAME
           , TO_CHAR(PM.ORI_JOIN_DATE, 'YYYY-MM-DD') AS ORI_JOIN_DATE
           , TO_CHAR(PM.RETIRE_DATE, 'YYYY-MM-DD') AS RETIRE_DATE
           , HC.DESCRIPTION
           , HC.SEND_ORG
           , NULL AS UNUSUAL_REARK
           , HC.PRINT_COUNT
           , TO_CHAR(HC.PRINT_DATE, 'YYYY-MM-DD') AS PRINT_DATE
           , CM.ADDR1 || ' ' || CM.ADDR2 || '(TEL:' || CM.TEL_NUMBER || '), FAX:' || CM.FAX_NUMBER|| ')' AS CORP_ADDRESS
           , HRM_COMMON_G.ID_NAME_F(PM.OCPT_ID) AS WORKING_NAME
       FROM HRA_CERTIFICATE HC
          , HRM_PERSON_MASTER PM
          , HRM_CORP_MASTER CM
       WHERE HC.PERSON_ID           = PM.PERSON_ID
         AND PM.CORP_ID             = CM.CORP_ID
         AND HC.PRINT_NUM           = W_PRINT_NUM
         AND ROWNUM                 = 1
     ;
  END SELECT_PRINT_DATA;
  
  
-------------------------------------------------------------------------------------------
-- �ٷμҵ��õ¡�������� Report - Grid
-------------------------------------------------------------------------------------------

-- �ٷμҵ��õ¡��������/�ٷμҵ� ���޸���
  PROCEDURE SELECT_WITHHOLDING_TAX
            ( P_CURSOR                OUT TYPES.TCURSOR
            , W_CORP_ID               IN NUMBER
            , W_PERSON_ID             IN NUMBER
            , W_YEAR_YYYY             IN VARCHAR2
            , W_DEPT_ID               IN NUMBER
            , W_SOB_ID                IN NUMBER
            , W_ORG_ID                IN NUMBER
            , W_JOB_CATEGORY_ID       IN NUMBER
            , W_EMPLOYE_3_YN          IN VARCHAR2
            )
  AS
  BEGIN
--    raise_application_error(-20001, W_CORP_ID || '/' || W_PERSON_ID || ' / ' || W_YEAR_YYYY);
     OPEN P_CURSOR FOR
        SELECT YA.YEAR_YYYY
             , PM.NAME                -- �ѱ� ����.
             , PM.PERSON_ID           -- ���ID.
             , PM.RESIDENT_TYPE       -- ���� ����(������1/������2).
             , PM.NATIONALITY_TYPE    -- ���ܱ��� ����(������1/�ܱ���9).
             , PM.HOUSEHOLD_TYPE      -- ������ ����(������1/�����2).
             , PM.FOREIGN_TAX_YN      -- �ܱ��δ��ϼ�������.
             , CASE
                 WHEN PM.RETIRE_DATE IS NULL THEN '��ӱٷ�'
                 ELSE '�ߵ����'
               END AS WORK_KEEP_TYPE  -- �������걸�� : ��ӱٷ�1, �ߵ����2.
             , PM.REPRE_NUM           -- �ֹι�ȣ.
             , PM.PRSN_ADDR1 || ' ' || PM.PRSN_ADDR2 AS PERSON_ADDRESS -- �ּ�.
             , CM.CORP_NAME           -- ���θ�(��ȣ).
             , CM.PRESIDENT_NAME      -- ��ǥ��(����).
             , HOU.VAT_NUMBER         -- ����ڵ�Ϲ�ȣ.
             , HOU.ORG_ADDRESS        -- ������(�ּ�).
             -----------------------------------------------------------------------------------------------------------------------------------
             -- I. �ٹ�ó�� �ҵ�� : ��(��).
             -----------------------------------------------------------------------------------------------------------------------------------
             , CM.CORP_NAME AS WORK_CORP_NAME                                                        -- �ٹ�ó��.
             , HOU.VAT_NUMBER AS WORK_VAT_NUMBER                                                     -- ����ڵ�Ϲ�ȣ.
             , YA.ADJUST_DATE_FR || '~' || YA.ADJUST_DATE_TO AS ADJUST_DATE                          -- �ٹ��Ⱓ.
             , NULL AS REDUCE_DATE                                                                  -- ����Ⱓ.
             , DECODE(YA.NOW_PAY_TOT_AMT, 0, NULL, YA.NOW_PAY_TOT_AMT) AS NOW_PAY_TOT_AMT           -- ��    ��. 
             , DECODE(YA.NOW_BONUS_TOT_AMT, 0, NULL, YA.NOW_BONUS_TOT_AMT) AS NOW_BONUS_TOT_AMT     -- ��    ��.
             , DECODE(YA.NOW_ADD_BONUS_AMT, 0, NULL, YA.NOW_ADD_BONUS_AMT) AS NOW_ADD_BONUS_AMT     -- ������.
             , DECODE(YA.NOW_STOCK_BENE_AMT, 0, NULL, YA.NOW_STOCK_BENE_AMT) AS NOW_STOCK_BENE_AMT  -- �ֽĸż����ñ� �������.
             , NULL AS OWNERSHIP_AMT                                                                -- �츮�������������.
             , DECODE((NVL(YA.NOW_PAY_TOT_AMT, 0) + NVL(YA.NOW_BONUS_TOT_AMT, 0) + NVL(YA.NOW_ADD_BONUS_AMT, 0) + NVL(YA.NOW_STOCK_BENE_AMT, 0)), 0, NULL,
               (NVL(YA.NOW_PAY_TOT_AMT, 0) + NVL(YA.NOW_BONUS_TOT_AMT, 0) + NVL(YA.NOW_ADD_BONUS_AMT, 0) + NVL(YA.NOW_STOCK_BENE_AMT, 0))) AS NOW_TOTAL_AMOUNT
                                                                                                     -- ��.
             -----------------------------------------------------------------------------------------------------------------------------------
             -- I. �ٹ�ó�� �ҵ�� : ��(��)1 �ٹ���.
             -----------------------------------------------------------------------------------------------------------------------------------
             , PW1.COMPANY_NAME AS PW_COMPANY_NAME1                                                 -- �ٹ�ó��.
             , PW1.COMPANY_NUM AS PW_COMPANY_NUM1                                                   -- ����ڵ�Ϲ�ȣ.
             , PW1.JOIN_DATE || '~' || PW1.RETR_DATE AS ADJUST_DATE1                                -- �ٹ��Ⱓ.
             , NULL AS REDUCE_DATE1                                                                -- ����Ⱓ.
             , DECODE(PW1.PAY_TOTAL_AMT, 0, NULL, PW1.PAY_TOTAL_AMT)  AS PAY_TOTAL_AMT1            -- ��    ��.
             , DECODE(PW1.BONUS_TOTAL_AMT, 0, NULL, PW1.BONUS_TOTAL_AMT) AS BONUS_TOTAL_AMT1       -- ��    ��.
             , DECODE(PW1.ADD_BONUS_AMT, 0, NULL, PW1.ADD_BONUS_AMT) AS ADD_BONUS_AMT1             -- ������.
             , DECODE(PW1.STOCK_BENE_AMT, 0, NULL, PW1.STOCK_BENE_AMT) AS STOCK_BENE_AMT1          -- �ֽĸż����ñ� �������.
             , NULL AS OWNERSHIP_AMT1                                                              -- �츮�������������.
             , DECODE((NVL(PW1.PAY_TOTAL_AMT, 0) + NVL(PW1.BONUS_TOTAL_AMT, 0) + NVL(PW1.ADD_BONUS_AMT, 0) + NVL(PW1.STOCK_BENE_AMT, 0)), 0, NULL,
               (NVL(PW1.PAY_TOTAL_AMT, 0) + NVL(PW1.BONUS_TOTAL_AMT, 0) + NVL(PW1.ADD_BONUS_AMT, 0) + NVL(PW1.STOCK_BENE_AMT, 0))) AS TOTAL_AMOUNT1
                                                                                                    -- ��.
             
             -----------------------------------------------------------------------------------------------------------------------------------
             -- I. �ٹ�ó�� �ҵ�� : ��(��)2 �ٹ���.
             -----------------------------------------------------------------------------------------------------------------------------------
             , PW2.COMPANY_NAME AS PW_COMPANY_NAME2                                                 -- �ٹ�ó��.
             , PW2.COMPANY_NUM AS PW_COMPANY_NUM2                                                   -- ����ڵ�Ϲ�ȣ.
             , PW2.JOIN_DATE || '~' || PW2.RETR_DATE AS ADJUST_DATE2                                -- �ٹ��Ⱓ.
             , NULL AS REDUCE_DATE2                                                                 -- ����Ⱓ.
             , DECODE(PW2.PAY_TOTAL_AMT, 0, NULL, PW2.PAY_TOTAL_AMT) AS PAY_TOTAL_AMT2              -- ��    ��.
             , DECODE(PW2.BONUS_TOTAL_AMT, 0, NULL, PW2.BONUS_TOTAL_AMT) AS BONUS_TOTAL_AMT2        -- ��    ��.
             , DECODE(PW2.ADD_BONUS_AMT, 0, NULL, PW2.ADD_BONUS_AMT) AS ADD_BONUS_AMT2              -- ������.
             , DECODE(PW2.STOCK_BENE_AMT, 0, NULL, PW2.STOCK_BENE_AMT) AS STOCK_BENE_AMT2           -- �ֽĸż����ñ� �������.
             , NULL AS OWNERSHIP_AMT2                                                               -- �츮�������������.
             , DECODE((NVL(PW2.PAY_TOTAL_AMT, 0) + NVL(PW2.BONUS_TOTAL_AMT, 0) + NVL(PW2.ADD_BONUS_AMT, 0) + NVL(PW2.STOCK_BENE_AMT, 0)), 0, NULL,
               (NVL(PW2.PAY_TOTAL_AMT, 0) + NVL(PW2.BONUS_TOTAL_AMT, 0) + NVL(PW2.ADD_BONUS_AMT, 0) + NVL(PW2.STOCK_BENE_AMT, 0))) AS TOTAL_AMOUNT2
                                                                                                     -- ��.
             
             -----------------------------------------------------------------------------------------------------------------------------------
             -- II. ����� �� ����ҵ� �� : ��(��).
             -----------------------------------------------------------------------------------------------------------------------------------
             , DECODE(YA.NONTAX_OUTSIDE_AMT,0,NULL,YA.NONTAX_OUTSIDE_AMT) AS NONTAX_OUTSIDE_AMT       -- ���ܱٷ�.
             , DECODE(YA.NONTAX_OT_AMT,0,NULL,YA.NONTAX_OT_AMT) AS NONTAX_OT_AMT                      -- �߰��ٷμ���.
             , DECODE(YA.NONTAX_BIRTH_AMT,0,NULL,YA.NONTAX_BIRTH_AMT) AS NONTAX_BIRTH_AMT             -- ���/��������.
             , DECODE(YA.NONTAX_FOREIGNER_AMT,0,NULL,YA.NONTAX_FOREIGNER_AMT) AS NONTAX_FOREIGNER_AMT -- �ܱ��� �ٷ���.
             , DECODE((NVL(YA.NONTAX_OUTSIDE_AMT, 0) + NVL(YA.NONTAX_OT_AMT, 0) + NVL(YA.NONTAX_BIRTH_AMT, 0) + NVL(YA.NONTAX_FOREIGNER_AMT, 0)),0,NULL,
               (NVL(YA.NONTAX_OUTSIDE_AMT, 0) + NVL(YA.NONTAX_OT_AMT, 0) + NVL(YA.NONTAX_BIRTH_AMT, 0) + NVL(YA.NONTAX_FOREIGNER_AMT, 0))) AS NONTAX_TOTAL_AMOUNT
                                                                                                       -- ������ҵ� ��.
             , NULL AS REDUCE_TOTAL_AMOUNT                                                            -- ����ҵ� ��.
             
             -----------------------------------------------------------------------------------------------------------------------------------
             -- II. ����� �� ����ҵ� �� : ��(��)1.
             -----------------------------------------------------------------------------------------------------------------------------------
             , DECODE(PW1.NT_OUTSIDE_AMT,0,NULL,PW1.NT_OUTSIDE_AMT) AS NT_OUTSIDE_AMT1                   -- ���ܱٷ�.
             , DECODE(PW1.NT_OT_AMT,0,NULL,PW1.NT_OT_AMT) AS NT_OT_AMT1                                  -- �߰��ٷ�.
             , DECODE(PW1.NT_BIRTH_AMT,0,NULL,PW1.NT_BIRTH_AMT) AS NT_BIRTH_AMT1                         -- ���/��������.
             , DECODE(PW1.NT_FOREIGNER_AMT,0,NULL,PW1.NT_FOREIGNER_AMT) AS NT_FOREIGNER_AMT1             -- �ܱ��� �ٷ���.
             , DECODE((NVL(PW1.NT_OUTSIDE_AMT, 0) + NVL(PW1.NT_OT_AMT, 0) + NVL(PW1.NT_BIRTH_AMT, 0) + NVL(PW1.NT_FOREIGNER_AMT, 0)),0,NULL,
               (NVL(PW1.NT_OUTSIDE_AMT, 0) + NVL(PW1.NT_OT_AMT, 0) + NVL(PW1.NT_BIRTH_AMT, 0) + NVL(PW1.NT_FOREIGNER_AMT, 0))) AS NT_TOTAL_AMOUNT1
                                                                                                          -- ������ҵ� ��.
             , NULL AS REDUCE_TOTAL_AMOUNT1                                                              -- ����ҵ� ��.
            
             -----------------------------------------------------------------------------------------------------------------------------------
             -- II. ����� �� ����ҵ� �� : ��(��)2.
             -----------------------------------------------------------------------------------------------------------------------------------
             , DECODE(PW2.NT_OUTSIDE_AMT,0,NULL,PW2.NT_OUTSIDE_AMT) AS NT_OUTSIDE_AMT2                   -- ���ܱٷ�.
             , DECODE(PW2.NT_OT_AMT,0,NULL,PW2.NT_OT_AMT) AS NT_OT_AMT2                                  -- �߰��ٷ�.
             , DECODE(PW2.NT_BIRTH_AMT,0,NULL,PW2.NT_BIRTH_AMT) AS NT_BIRTH_AMT2                         -- ���/��������.
             , DECODE(PW2.NT_FOREIGNER_AMT,0,NULL,PW2.NT_FOREIGNER_AMT) AS NT_FOREIGNER_AMT2             -- �ܱ��� �ٷ���.
             , DECODE((NVL(PW2.NT_OUTSIDE_AMT, 0) + NVL(PW2.NT_OT_AMT, 0) + NVL(PW2.NT_BIRTH_AMT, 0) + NVL(PW2.NT_FOREIGNER_AMT, 0)),0,NULL,
               (NVL(PW2.NT_OUTSIDE_AMT, 0) + NVL(PW2.NT_OT_AMT, 0) + NVL(PW2.NT_BIRTH_AMT, 0) + NVL(PW2.NT_FOREIGNER_AMT, 0))) AS NT_TOTAL_AMOUNT2
                                                                                                          -- ������ҵ� ��.
             , NULL AS REDUCE_TOTAL_AMOUNT2                                                              -- ����ҵ� ��.
             
             -----------------------------------------------------------------------------------------------------------------------------------
             -- III. ���׸� : ��������
             -----------------------------------------------------------------------------------------------------------------------------------
             , DECODE(YA.FIX_IN_TAX_AMT,0,NULL,YA.FIX_IN_TAX_AMT) AS FIX_IN_TAX_AMT                                       -- �ҵ漼.
             , DECODE(YA.FIX_LOCAL_TAX_AMT,0,NULL,YA.FIX_LOCAL_TAX_AMT) AS FIX_LOCAL_TAX_AMT                              -- �ֹμ�.
             , DECODE(YA.FIX_SP_TAX_AMT,0,NULL,YA.FIX_SP_TAX_AMT) AS FIX_SP_TAX_AMT                                       -- ��Ư��.
             , DECODE((NVL(YA.FIX_IN_TAX_AMT, 0) + NVL(YA.FIX_LOCAL_TAX_AMT, 0) + NVL(YA.FIX_SP_TAX_AMT, 0)),0,NULL,
               (NVL(YA.FIX_IN_TAX_AMT, 0) + NVL(YA.FIX_LOCAL_TAX_AMT, 0) + NVL(YA.FIX_SP_TAX_AMT, 0))) AS FIX_TAX_AMOUNT -- ��.
             -----------------------------------------------------------------------------------------------------------------------------------
             -- III. ���׸� : �ⳳ�� ���� - ��(��)1 �ٹ���.
             -----------------------------------------------------------------------------------------------------------------------------------
             , PW1.COMPANY_NUM AS PW1_COMPANY_NUM1                                                                        -- ����ڵ�Ϲ�ȣ.
             , DECODE(PW1.IN_TAX_AMT,0,NULL,PW1.IN_TAX_AMT) AS PW1_IN_TAX_AMT1                                           -- �ҵ漼.
             , DECODE(PW1.LOCAL_TAX_AMT,0,NULL,PW1.LOCAL_TAX_AMT) AS PW1_LOCAL_TAX_AMT1                                  -- �ֹμ�.
             , DECODE(PW1.SP_TAX_AMT,0,NULL,PW1.SP_TAX_AMT) AS PW1_SP_TAX_AMT1                                           -- ��Ư��.
             , DECODE((NVL(PW1.IN_TAX_AMT, 0) + NVL(PW1.LOCAL_TAX_AMT, 0) + NVL(PW1.SP_TAX_AMT, 0)),0,NULL,
               (NVL(PW1.IN_TAX_AMT, 0) + NVL(PW1.LOCAL_TAX_AMT, 0) + NVL(PW1.SP_TAX_AMT, 0))) AS PW1_TOTAL_TAX_AMT1      -- ��.
             -----------------------------------------------------------------------------------------------------------------------------------
             -- III. ���׸� : �ⳳ�� ���� - ��(��)2 �ٹ���.
             -----------------------------------------------------------------------------------------------------------------------------------
             , PW2.COMPANY_NUM AS PW2_COMPANY_NUM2                                                                       -- ����ڵ�Ϲ�ȣ.
             , DECODE(PW2.IN_TAX_AMT,0,NULL,PW2.IN_TAX_AMT) AS PW2_IN_TAX_AMT2                                           -- �ҵ漼.
             , DECODE(PW2.LOCAL_TAX_AMT,0,NULL,PW2.LOCAL_TAX_AMT) AS PW2_LOCAL_TAX_AMT2                                  -- �ֹμ�.
             , DECODE(PW2.SP_TAX_AMT,0,NULL,PW2.SP_TAX_AMT) AS PW2_SP_TAX_AMT2                                           -- ��Ư��.
             , DECODE((NVL(PW2.IN_TAX_AMT, 0) + NVL(PW2.LOCAL_TAX_AMT, 0) + NVL(PW2.SP_TAX_AMT, 0)),0,NULL,
               (NVL(PW2.IN_TAX_AMT, 0) + NVL(PW2.LOCAL_TAX_AMT, 0) + NVL(PW2.SP_TAX_AMT, 0))) AS PW2_TOTAL_TAX_AMT2     -- ��.
             -----------------------------------------------------------------------------------------------------------------------------------
             -- III. ���׸� : �ⳳ�� ���� - ��(��)�ٹ���.
             -----------------------------------------------------------------------------------------------------------------------------------
             , DECODE((NVL(YA.PRE_IN_TAX_AMT, 0) -  NVL(PW1.IN_TAX_AMT, 0) -  NVL(PW2.IN_TAX_AMT, 0)),0,NULL,
               (NVL(YA.PRE_IN_TAX_AMT, 0) -  NVL(PW1.IN_TAX_AMT, 0) -  NVL(PW2.IN_TAX_AMT, 0))) AS PRE_IN_TAX_AMT           -- �ҵ漼.
             , DECODE((NVL(YA.PRE_LOCAL_TAX_AMT, 0) - NVL(PW1.LOCAL_TAX_AMT, 0) - NVL(PW2.LOCAL_TAX_AMT, 0)),0,NULL,
               (NVL(YA.PRE_LOCAL_TAX_AMT, 0) - NVL(PW1.LOCAL_TAX_AMT, 0) - NVL(PW2.LOCAL_TAX_AMT, 0))) AS PRE_LOCAL_TAX_AMT -- �ֹμ�.
             , DECODE((NVL(YA.PRE_SP_TAX_AMT, 0) - NVL(PW1.SP_TAX_AMT, 0) - NVL(PW2.SP_TAX_AMT, 0)),0,NULL,
               (NVL(YA.PRE_SP_TAX_AMT, 0) - NVL(PW1.SP_TAX_AMT, 0) - NVL(PW2.SP_TAX_AMT, 0))) AS PRE_SP_TAX_AMT             -- ��Ư��.
             , DECODE((NVL(YA.PRE_IN_TAX_AMT, 0) + NVL(YA.PRE_LOCAL_TAX_AMT, 0) + NVL(YA.PRE_SP_TAX_AMT, 0)
               - NVL(PW1.IN_TAX_AMT, 0) + NVL(PW1.LOCAL_TAX_AMT, 0) + NVL(PW1.SP_TAX_AMT, 0)
               - NVL(PW2.IN_TAX_AMT, 0) + NVL(PW2.LOCAL_TAX_AMT, 0) + NVL(PW2.SP_TAX_AMT, 0)),0,NULL,
               (NVL(YA.PRE_IN_TAX_AMT, 0) + NVL(YA.PRE_LOCAL_TAX_AMT, 0) + NVL(YA.PRE_SP_TAX_AMT, 0)
               - NVL(PW1.IN_TAX_AMT, 0) + NVL(PW1.LOCAL_TAX_AMT, 0) + NVL(PW1.SP_TAX_AMT, 0)
               - NVL(PW2.IN_TAX_AMT, 0) + NVL(PW2.LOCAL_TAX_AMT, 0) + NVL(PW2.SP_TAX_AMT, 0))) AS PRE_TAX_AMOUNT            -- ��.
             -----------------------------------------------------------------------------------------------------------------------------------
             -- III. ���׸� : ����¡������.
             -----------------------------------------------------------------------------------------------------------------------------------
             , DECODE(YA.SUBT_IN_TAX_AMT,0,NULL,YA.SUBT_IN_TAX_AMT) AS SUBT_IN_TAX_AMT                                       -- �ҵ漼.
             , DECODE(YA.SUBT_LOCAL_TAX_AMT,0,NULL,YA.SUBT_LOCAL_TAX_AMT) AS SUBT_LOCAL_TAX_AMT                              -- �ֹμ�.
             , DECODE(YA.SUBT_SP_TAX_AMT,0,NULL,YA.SUBT_SP_TAX_AMT) AS SUBT_SP_TAX_AMT                                       -- ��Ư��.
             , DECODE((NVL(YA.SUBT_IN_TAX_AMT, 0) + NVL(YA.SUBT_LOCAL_TAX_AMT, 0) + NVL(YA.SUBT_SP_TAX_AMT, 0)),0,NULL,
               (NVL(YA.SUBT_IN_TAX_AMT, 0) + NVL(YA.SUBT_LOCAL_TAX_AMT, 0) + NVL(YA.SUBT_SP_TAX_AMT, 0))) AS SUBT_TAX_AMOUNT -- ��
                         
             -----------------------------------------------------------------------------------------------------------------------------------
             
             ------------------------------------------******* ���� ���� �� ���� ��ȸ *******-------------------------------------------------
             
             -----------------------------------------------------------------------------------------------------------------------------------
             , DECODE(YA.INCOME_TOT_AMT, 0, NULL, YA.INCOME_TOT_AMT) AS INCOME_TOT_AMT,                                     -- �ѱ޿�
             DECODE(YA.INCOME_DED_AMT, 0, NULL, YA.INCOME_DED_AMT) AS INCOME_DED_AMT,                                       -- �ٷμҵ����
             DECODE((NVL(YA.INCOME_TOT_AMT, 0) - NVL(YA.INCOME_DED_AMT, 0)), 0, NULL,
             (NVL(YA.INCOME_TOT_AMT, 0) - NVL(YA.INCOME_DED_AMT, 0))) AS INCOME_AMT,                                        -- �ٷμҵ�ݾ�
             -----------------------------------------------------------------------------------------------------------------------------------
             -- �⺻ ����
             -----------------------------------------------------------------------------------------------------------------------------------
             DECODE(YA.PER_DED_AMT, 0, NULL, YA.PER_DED_AMT) AS PER_DED_AMT,                                                -- �⺻(����)
             DECODE(YA.SPOUSE_DED_AMT, 0, NULL, YA.SPOUSE_DED_AMT) AS SPOUSE_DED_AMT,                                       -- �⺻(�����)
             DECODE(YA.SUPP_DED_COUNT, 0, NULL, YA.SUPP_DED_COUNT) AS SUPP_DED_COUNT,                                       -- �⺻(�ξ��ο� - �ο�)
             DECODE(YA.SUPP_DED_AMT, 0, NULL, YA.SUPP_DED_AMT) AS SUPP_DED_AMT,                                             -- �⺻(�ξ��ο� - �ݾ�)   
             -----------------------------------------------------------------------------------------------------------------------------------
             -- �߰� ����
             -----------------------------------------------------------------------------------------------------------------------------------         
             DECODE((NVL(YA.OLD_DED_COUNT, 0) + NVL(YA.OLD_DED_COUNT1, 0)), 0, NULL, (NVL(YA.OLD_DED_COUNT, 0) + 
             NVL(YA.OLD_DED_COUNT1, 0))) AS OLD_DED_COUNT,                                                                  -- �߰�����(��μ�1+��μ�2 - �� �ο�)
             DECODE((NVL(YA.OLD_DED_AMT, 0) + NVL(YA.OLD_DED_AMT1, 0)), 0, NULL, (NVL(YA.OLD_DED_AMT, 0) + NVL(YA.OLD_DED_AMT1, 0))) 
             AS OLD_DED_AMT,                                                                                                -- �߰�����(��μ�1+��μ�2 - �� �ݾ�)             
             DECODE(YA.DISABILITY_DED_COUNT, 0, NULL, YA.DISABILITY_DED_COUNT) AS DISABILITY_DED_COUNT,                     -- �߰�����(����� - �ο�)
             DECODE(YA.DISABILITY_DED_AMT, 0, NULL, YA.DISABILITY_DED_AMT) AS DISABILITY_DED_AMT,                           -- �߰�����(����� - �ݾ�)
             DECODE(YA.WOMAN_DED_AMT, 0, NULL, YA.WOMAN_DED_AMT) AS WOMAN_DED_AMT,                                          -- �߰�����(�γ༼��)
             DECODE(YA.CHILD_DED_COUNT, 0, NULL, YA.CHILD_DED_COUNT) AS CHILD_DED_COUNT,                                    -- �߰�����(�ڳ���� - �ο�)
             DECODE(YA.CHILD_DED_AMT, 0, NULL, YA.CHILD_DED_AMT) AS CHILD_DED_AMT,                                          -- �߰�����(�ڳ���� - �ݾ�)
             DECODE(YA.BIRTH_DED_COUNT, 0, NULL, YA.BIRTH_DED_COUNT) AS BIRTH_DED_COUNT,                                    -- �߰�����(���/�Ծ��� ��)
             DECODE(YA.BIRTH_DED_AMT, 0, NULL, YA.BIRTH_DED_AMT) AS BIRTH_DED_AMT,                                          -- �߰�����(���/�Ծ��� �����ݾ�)
             --NVL(YA.PER_ADD_DED_AMT, 0) PER_ADD_DED_AMT,
             DECODE(YA.MANY_CHILD_DED_COUNT, 0, NULL, YA.MANY_CHILD_DED_COUNT) AS MANY_CHILD_DED_COUNT,                     -- ���ڳ����(�ο�)
             DECODE(YA.MANY_CHILD_DED_AMT, 0, NULL, YA.MANY_CHILD_DED_AMT) AS MANY_CHILD_DED_AMT,                           -- ���ڳ����(�ݾ�)      
             -----------------------------------------------------------------------------------------------------------------------------------
             -- ���� ����� ����
             -----------------------------------------------------------------------------------------------------------------------------------
             DECODE(YA.NATI_ANNU_AMT, 0, NULL, YA.NATI_ANNU_AMT) AS NATI_ANNU_AMT,                                          -- ���ο��� ����� ����
             DECODE(YA.ANNU_INSUR_AMT, 0, NULL, YA.ANNU_INSUR_AMT) AS ANNU_INSUR_AMT,                                       -- ���� ����� ����
             DECODE(YA.RETR_ANNU_AMT, 0, NULL, YA.RETR_ANNU_AMT) AS RETR_ANNU_AMT,                                          -- �������ݼҵ� ����
             -----------------------------------------------------------------------------------------------------------------------------------
             -- Ư�� ����
             -----------------------------------------------------------------------------------------------------------------------------------
             -- ����� �ݾ��� ������ ��쿡�� 0 �� ���(�������� �����ä ��Ŀ� -���� ���� ����);
             /*(CASE
               WHEN NVL(YA.MEDIC_INSUR_AMT, 0) + NVL(YA.HIRE_INSUR_AMT, 0) +
                    NVL(YA.GUAR_INSUR_AMT, 0) + NVL(YA.DISABILITY_INSUR_AMT, 0) < 0 THEN
                0
               ELSE
                NVL(YA.MEDIC_INSUR_AMT, 0) + NVL(YA.HIRE_INSUR_AMT, 0) +
                NVL(YA.GUAR_INSUR_AMT, 0) + NVL(YA.DISABILITY_INSUR_AMT, 0)
             END) ETC_INSURE_AMT,                                     -- Ư������(�����)*/
                          
             DECODE(YA.MEDIC_INSUR_AMT, 0, NULL, YA.MEDIC_INSUR_AMT) AS MEDIC_INSUR_AMT,                                    -- �ǰ������(MEDIC_INSUR_AMT)
             DECODE(YA.HIRE_INSUR_AMT, 0, NULL, YA.HIRE_INSUR_AMT) AS HIRE_INSUR_AMT,                                       -- ��뺸���(HIRE_INSUR_AMT)
             DECODE(YA.GUAR_INSUR_AMT, 0, NULL, YA.GUAR_INSUR_AMT) AS GUAR_INSUR_AMT,                                       -- ���强����(GUAR_INSUR_AMT)
             DECODE(YA.DISABILITY_INSUR_AMT, 0, NULL, YA.DISABILITY_INSUR_AMT) AS DISABILITY_INSUR_AMT,                                 -- ���������(DISABILITY_INSUR_AMT)
             
             DECODE(YA.MEDIC_AMT, 0, NULL, YA.MEDIC_AMT) AS MEDIC_AMT,                                                      -- Ư������(�Ƿ��)
             DECODE(YA.EDUCATION_AMT, 0, NULL, YA.EDUCATION_AMT) AS EDUCATION_AMT,                                          -- Ư������(������)
             DECODE(YA.HOUSE_INTER_AMT, 0, NULL, YA.HOUSE_INTER_AMT) AS HOUSE_INTER_AMT,                                    -- Ư������(�����������Ա�)
             DECODE(YA.HOUSE_MONTHLY_AMT, 0, NULL, YA.HOUSE_MONTHLY_AMT) AS HOUSE_MONTHLY_AMT,                              -- Ư������(����)
             DECODE(NVL(YA.LONG_HOUSE_PROF_AMT, 0) + NVL(YA.LONG_HOUSE_PROF_AMT_1, 0) + NVL(YA.LONG_HOUSE_PROF_AMT_2, 0) +
                    NVL(YA.LONG_HOUSE_PROF_AMT_3_FIX, 0) + NVL(YA.LONG_HOUSE_PROF_AMT_3_ETC, 0), 0, NULL, 
                    NVL(YA.LONG_HOUSE_PROF_AMT, 0) + NVL(YA.LONG_HOUSE_PROF_AMT_1, 0) + NVL(YA.LONG_HOUSE_PROF_AMT_2, 0) +
                    NVL(YA.LONG_HOUSE_PROF_AMT_3_FIX, 0) + NVL(YA.LONG_HOUSE_PROF_AMT_3_ETC, 0)) AS LONG_HOUSE_PROF_AMT,                        -- Ư������(����������Ա�)             
             --NVL(YA.HOUSE_INTER_AMT, 0) + NVL(YA.LONG_HOUSE_PROF_AMT, 0) HOUSE_FUND_AMT,
             DECODE(YA.DONAT_AMT, 0, NULL, YA.DONAT_AMT) AS DONAT_AMT,                                                      -- Ư������(��α�)
             --NVL(YA.MARRY_ETC_AMT, 0) MARRY_ETC_AMT,
             DECODE(((CASE
               WHEN NVL(YA.MEDIC_INSUR_AMT, 0) + NVL(YA.HIRE_INSUR_AMT, 0) +
                    NVL(YA.GUAR_INSUR_AMT, 0) + NVL(YA.DISABILITY_INSUR_AMT, 0) < 0 THEN
                0
               ELSE
                NVL(YA.MEDIC_INSUR_AMT, 0) + NVL(YA.HIRE_INSUR_AMT, 0) +
                NVL(YA.GUAR_INSUR_AMT, 0) + NVL(YA.DISABILITY_INSUR_AMT, 0)
             END) + NVL(YA.MEDIC_AMT, 0) + NVL(YA.EDUCATION_AMT, 0) +
             NVL(YA.HOUSE_INTER_AMT, 0) + NVL(YA.LONG_HOUSE_PROF_AMT, 0) +
             NVL(YA.DONAT_AMT, 0) + NVL(YA.MARRY_ETC_AMT, 0)), 0, NULL, 
             ((CASE
               WHEN NVL(YA.MEDIC_INSUR_AMT, 0) + NVL(YA.HIRE_INSUR_AMT, 0) +
                    NVL(YA.GUAR_INSUR_AMT, 0) + NVL(YA.DISABILITY_INSUR_AMT, 0) < 0 THEN
                0
               ELSE
                NVL(YA.MEDIC_INSUR_AMT, 0) + NVL(YA.HIRE_INSUR_AMT, 0) +
                NVL(YA.GUAR_INSUR_AMT, 0) + NVL(YA.DISABILITY_INSUR_AMT, 0)
             END) + NVL(YA.MEDIC_AMT, 0) + NVL(YA.EDUCATION_AMT, 0) + NVL(YA.HOUSE_INTER_AMT, 0) + 
             NVL(YA.LONG_HOUSE_PROF_AMT, 0) + NVL(YA.LONG_HOUSE_PROF_AMT_1, 0) + NVL(YA.LONG_HOUSE_PROF_AMT_2, 0) +
             NVL(YA.LONG_HOUSE_PROF_AMT_3_FIX, 0) + NVL(YA.LONG_HOUSE_PROF_AMT_3_ETC, 0) +
             NVL(YA.DONAT_AMT, 0) + NVL(YA.MARRY_ETC_AMT, 0))) AS  SP_DED_SUM,                                              -- ��
             DECODE(YA.STAND_DED_AMT, 0, NULL, YA.STAND_DED_AMT) AS STAND_DED_AMT,                                          -- ǥ�ذ���
             DECODE(YA.SUBT_DED_AMT, 0, NULL, YA.SUBT_DED_AMT) AS SUBT_DED_AMT,                                             -- �����ҵ�ݾ�
             -----------------------------------------------------------------------------------------------------------------------------------
             -- �� ���� �ҵ� ����
             -----------------------------------------------------------------------------------------------------------------------------------             
             DECODE(YA.PERS_ANNU_BANK_AMT, 0, NULL, YA.PERS_ANNU_BANK_AMT) AS PERS_ANNU_BANK_AMT,                           -- ���ο�������ҵ����
             DECODE(YA.ANNU_BANK_AMT, 0, NULL, YA.ANNU_BANK_AMT) AS ANNU_BANK_AMT,                                          -- ��������ҵ����
             DECODE(YA.SMALL_CORPOR_DED_AMT, 0, NULL, YA.SMALL_CORPOR_DED_AMT) AS SMALL_CORPOR_DED_AMT,                     -- �ұ��/�һ���� �����α� �ҵ����
             
             DECODE(YA.HOUSE_APP_DEPOSIT_AMT, 0, NULL, YA.HOUSE_APP_DEPOSIT_AMT) AS HOUSE_APP_SAVE_AMT,                     -- û������
             DECODE(YA.HOUSE_APP_SAVE_AMT, 0, NULL, YA.HOUSE_APP_SAVE_AMT) AS HOUSE_APP_DEPOSIT_AMT,                        -- ����û����������
             DECODE(YA.HOUSE_SAVE_AMT, 0, NULL, YA.HOUSE_SAVE_AMT) AS HOUSE_SAVE_AMT,                                       -- ������ø�������
             DECODE(YA.WORKER_HOUSE_SAVE_AMT, 0, NULL, YA.WORKER_HOUSE_SAVE_AMT) AS WORKER_HOUSE_SAVE_AMT,                  -- �ٷ������ø�������
             
             DECODE(YA.INVES_AMT, 0, NULL, YA.INVES_AMT) AS INVES_AMT,                                                      -- �����������ڵ� �ҵ����
             --NVL(YA.FORE_INCOME_AMT, 0) FORE_INCOME_AMT,                                                                   -- �ܱ��ٷ��ڼҵ�
             DECODE(YA.CREDIT_AMT, 0, NULL, YA.CREDIT_AMT) AS CREDIT_AMT,                                                   -- �ſ�ī���ҵ����
             DECODE(YA.EMPL_STOCK_AMT, 0, NULL, YA.EMPL_STOCK_AMT) AS EMPL_STOCK_AMT,                                       -- �츮��������
             DECODE(YA.LONG_STOCK_SAVING_AMT, 0, NULL, YA.LONG_STOCK_SAVING_AMT) AS LONG_STOCK_SAVING_AMT,                  -- ����ֽ�������
             DECODE(YA.HIRE_KEEP_EMPLOY_AMT, 0, NULL, YA.HIRE_KEEP_EMPLOY_AMT) AS HIRE_KEEP_EMPLOY_AMT,                     -- ��������߼ұ���ҵ����
             
             DECODE((NVL(YA.PERS_ANNU_BANK_AMT, 0) + NVL(YA.ANNU_BANK_AMT, 0) + NVL(YA.SMALL_CORPOR_DED_AMT, 0) + 
             NVL(YA.HOUSE_APP_SAVE_AMT, 0) + NVL(YA.HOUSE_APP_DEPOSIT_AMT, 0) + NVL(YA.HOUSE_SAVE_AMT, 0) + NVL(YA.WORKER_HOUSE_SAVE_AMT, 0) + 
             NVL(YA.INVES_AMT, 0) + NVL(YA.CREDIT_AMT, 0) + NVL(YA.EMPL_STOCK_AMT, 0) + NVL(YA.LONG_STOCK_SAVING_AMT, 0) + NVL(YA.HIRE_KEEP_EMPLOY_AMT, 0)), 0, NULL,
             (NVL(YA.PERS_ANNU_BANK_AMT, 0) + NVL(YA.ANNU_BANK_AMT, 0) + NVL(YA.SMALL_CORPOR_DED_AMT, 0) + 
             NVL(YA.HOUSE_APP_SAVE_AMT, 0) + NVL(YA.HOUSE_APP_DEPOSIT_AMT, 0) + NVL(YA.HOUSE_SAVE_AMT, 0) + NVL(YA.WORKER_HOUSE_SAVE_AMT, 0) + 
             NVL(YA.INVES_AMT, 0) + NVL(YA.CREDIT_AMT, 0) + NVL(YA.EMPL_STOCK_AMT, 0) + NVL(YA.LONG_STOCK_SAVING_AMT, 0) + NVL(YA.HIRE_KEEP_EMPLOY_AMT, 0))             
             ) AS ETC_DED_SUM,                                                                                               -- �� ���� �ҵ���� ��             
             DECODE(YA.TAX_STD_AMT, 0, NULL, YA.TAX_STD_AMT) AS TAX_STD_AMT,                                                -- ���հ���ǥ��
             DECODE(YA.COMP_TAX_AMT, 0, NULL, YA.COMP_TAX_AMT) AS COMP_TAX_AMT,                                             -- ���⼼��
             -----------------------------------------------------------------------------------------------------------------------------------
             -- ���� ����
             -----------------------------------------------------------------------------------------------------------------------------------    
             DECODE(YA.TAX_REDU_IN_LAW_AMT, 0, NULL, YA.TAX_REDU_IN_LAW_AMT) AS TAX_REDU_IN_LAW_AMT,                        -- �ҵ漼��
             DECODE(YA.TAX_REDU_SP_LAW_AMT, 0, NULL, YA.TAX_REDU_SP_LAW_AMT) AS TAX_REDU_SP_LAW_AMT,                        -- ����Ư�����ѹ�
             DECODE((NVL(YA.TAX_REDU_IN_LAW_AMT, 0) + NVL(YA.TAX_REDU_SP_LAW_AMT, 0)), 0, NULL, 
             (NVL(YA.TAX_REDU_IN_LAW_AMT, 0) + NVL(YA.TAX_REDU_SP_LAW_AMT, 0))) AS TAX_REDU_SUM,                            -- ���װ��� ��
             -----------------------------------------------------------------------------------------------------------------------------------
             -- ���� ����
             -----------------------------------------------------------------------------------------------------------------------------------             
             DECODE(YA.TAX_DED_INCOME_AMT, 0, NULL, YA.TAX_DED_INCOME_AMT) AS TAX_DED_INCOME_AMT,                           -- �ٷμҵ�
             DECODE(YA.TAX_DED_TAXGROUP_AMT, 0, NULL, YA.TAX_DED_TAXGROUP_AMT) AS TAX_DED_TAXGROUP_AMT,                     -- �������հ���
             DECODE(YA.TAX_DED_HOUSE_DEBT_AMT, 0, NULL, YA.TAX_DED_HOUSE_DEBT_AMT) AS TAX_DED_HOUSE_DEBT_AMT,               -- �������Ա�
             --NVL(YA.TAX_DED_LONG_STOCK_AMT, 0) TAX_DED_LONG_STOCK_AMT,
             DECODE(YA.TAX_DED_DONAT_POLI_AMT, 0, NULL, YA.TAX_DED_DONAT_POLI_AMT) AS TAX_DED_DONAT_POLI_AMT,               -- ��� ��ġ�ڱ�
             DECODE(YA.TAX_DED_OUTSIDE_PAY_AMT, 0, NULL, YA.TAX_DED_OUTSIDE_PAY_AMT) AS TAX_DED_OUTSIDE_PAY_AMT,            -- �ܱ� ����
             DECODE((NVL(YA.TAX_DED_INCOME_AMT, 0) + NVL(YA.TAX_DED_TAXGROUP_AMT, 0) + NVL(YA.TAX_DED_HOUSE_DEBT_AMT, 0) 
             + NVL(YA.TAX_DED_LONG_STOCK_AMT, 0) + NVL(YA.TAX_DED_DONAT_POLI_AMT, 0) + NVL(YA.TAX_DED_OUTSIDE_PAY_AMT, 0)), 0, NULL, 
             (NVL(YA.TAX_DED_INCOME_AMT, 0) + NVL(YA.TAX_DED_TAXGROUP_AMT, 0) + NVL(YA.TAX_DED_HOUSE_DEBT_AMT, 0) 
             + NVL(YA.TAX_DED_LONG_STOCK_AMT, 0) + NVL(YA.TAX_DED_DONAT_POLI_AMT, 0) + NVL(YA.TAX_DED_OUTSIDE_PAY_AMT, 0))) AS TAX_DED_SUM,
                                                                                                                             -- ���װ��� ��     
             DECODE((NVL(YA.COMP_TAX_AMT, 0) - (NVL(YA.TAX_REDU_IN_LAW_AMT, 0) + NVL(YA.TAX_REDU_SP_LAW_AMT, 0))  - 
             (NVL(YA.TAX_DED_INCOME_AMT, 0) + NVL(YA.TAX_DED_TAXGROUP_AMT, 0) + NVL(YA.TAX_DED_HOUSE_DEBT_AMT, 0) +
              NVL(YA.TAX_DED_LONG_STOCK_AMT, 0) + NVL(YA.TAX_DED_DONAT_POLI_AMT, 0) + NVL(YA.TAX_DED_OUTSIDE_PAY_AMT, 0))), 0, NULL,
              (NVL(YA.COMP_TAX_AMT, 0) - (NVL(YA.TAX_REDU_IN_LAW_AMT, 0) + NVL(YA.TAX_REDU_SP_LAW_AMT, 0))  - 
             (NVL(YA.TAX_DED_INCOME_AMT, 0) + NVL(YA.TAX_DED_TAXGROUP_AMT, 0) + NVL(YA.TAX_DED_HOUSE_DEBT_AMT, 0) +
              NVL(YA.TAX_DED_LONG_STOCK_AMT, 0) + NVL(YA.TAX_DED_DONAT_POLI_AMT, 0) + NVL(YA.TAX_DED_OUTSIDE_PAY_AMT, 0))))
             AS SET_TAX_SUM                                                                                                 -- ��������(���⼼�� - ���װ���� - ���װ�����)
             --NVL(YA.NONTAX_FOREIGNER_AMT, 0) NONTAX_FOREIGNER_AMT,
             , PM.TELEPHON_NO
             , CM.TEL_NUMBER
          FROM HRM_PERSON_MASTER PM
            , HRM_DEPT_MASTER DM
            , HRM_POST_CODE_V PC
            , HRA_YEAR_ADJUSTMENT YA
            , HRM_CORP_MASTER CM
            , ( SELECT OU.CORP_ID
                     , OU.PRESIDENT_NAME
                     , OU.VAT_NUMBER
                     , OU.ADDR1 || OU.ADDR2 AS ORG_ADDRESS
                     , OU.SOB_ID
                     , OU.ORG_ID
                  FROM HRM_OPERATING_UNIT OU
                WHERE OU.SOB_ID           = W_SOB_ID
                  AND OU.ORG_ID           = W_ORG_ID
                  AND OU.DEFAULT_FLAG     = 'Y'
              ) HOU
            , ------------------------------------------------------------------ 
               -- ��(��) �ٹ���1 --
              ------------------------------------------------------------------
              ( SELECT PW.YEAR_YYYY
                     , PW.SOB_ID
                     , PW.ORG_ID
                     , PW.PERSON_ID
                     , PW.COMPANY_NAME
                     , PW.COMPANY_NUM
                     , PW.JOIN_DATE
                     , PW.RETR_DATE
                     , PW.PAY_TOTAL_AMT
                     , PW.BONUS_TOTAL_AMT
                     , PW.ADD_BONUS_AMT
                     , PW.STOCK_BENE_AMT
                     , PW.NT_OUTSIDE_AMT                      -- ���ܱٷ�.
                     , PW.NT_OT_AMT                           -- �߰��ٷ�.
                     , PW.NT_BIRTH_AMT                        -- ���/��������.
                     , PW.NT_FOREIGNER_AMT                    -- �ܱ��� �ٷ���.
                     , PW.IN_TAX_AMT
                     , PW.LOCAL_TAX_AMT
                     , PW.SP_TAX_AMT
                  FROM HRA_PREVIOUS_WORK PW
                WHERE PW.YEAR_YYYY        = W_YEAR_YYYY
                  AND PW.SOB_ID           = W_SOB_ID
                  AND PW.ORG_ID           = W_ORG_ID
                  AND PW.PERSON_ID        = NVL(W_PERSON_ID, PW.PERSON_ID)
                  AND PW.SEQ_NUM          = 1
              ) PW1
            , ------------------------------------------------------------------
                -- ��(��) �ٹ���2 --
              ------------------------------------------------------------------
              ( SELECT PW.YEAR_YYYY
                     , PW.SOB_ID
                     , PW.ORG_ID
                     , PW.PERSON_ID
                     , PW.COMPANY_NAME
                     , PW.COMPANY_NUM
                     , PW.JOIN_DATE
                     , PW.RETR_DATE
                     , PW.PAY_TOTAL_AMT
                     , PW.BONUS_TOTAL_AMT
                     , PW.ADD_BONUS_AMT
                     , PW.STOCK_BENE_AMT
                     , PW.NT_OUTSIDE_AMT                      -- ���ܱٷ�.
                     , PW.NT_OT_AMT                           -- �߰��ٷ�.
                     , PW.NT_BIRTH_AMT                        -- ���/��������.
                     , PW.NT_FOREIGNER_AMT                    -- �ܱ��� �ٷ���.
                     , PW.IN_TAX_AMT
                     , PW.LOCAL_TAX_AMT
                     , PW.SP_TAX_AMT
                  FROM HRA_PREVIOUS_WORK PW
                WHERE PW.YEAR_YYYY        = W_YEAR_YYYY
                  AND PW.SOB_ID           = W_SOB_ID
                  AND PW.ORG_ID           = W_ORG_ID
                  AND PW.PERSON_ID        = NVL(W_PERSON_ID, PW.PERSON_ID)
                  AND PW.SEQ_NUM          = 2
              ) PW2
        WHERE PM.DEPT_ID                  = DM.DEPT_ID
          AND PM.POST_ID                  = PC.POST_ID
          AND PM.PERSON_ID                = YA.PERSON_ID
          AND PM.CORP_ID                  = CM.CORP_ID
          AND CM.CORP_ID                  = HOU.CORP_ID(+)
          AND YA.YEAR_YYYY                = PW1.YEAR_YYYY(+)
          AND YA.PERSON_ID                = PW1.PERSON_ID(+)
          AND YA.YEAR_YYYY                = PW2.YEAR_YYYY(+)
          AND YA.PERSON_ID                = PW2.PERSON_ID(+)
          AND PM.CORP_ID                  = W_CORP_ID
          AND PM.PERSON_ID                = NVL(W_PERSON_ID, PM.PERSON_ID)
          AND PM.DEPT_ID                  = NVL(W_DEPT_ID, PM.DEPT_ID)
          AND PM.SOB_ID                   = W_SOB_ID
          AND PM.ORG_ID                   = W_ORG_ID
          AND YA.CORP_ID                  = W_CORP_ID
          AND YA.YEAR_YYYY                = W_YEAR_YYYY
          AND YA.SOB_ID                   = W_SOB_ID
          AND YA.ORG_ID                   = W_ORG_ID
          AND ((W_JOB_CATEGORY_ID         IS NULL
          AND   1                         = 1)
          OR   (W_JOB_CATEGORY_ID         IS NOT NULL
          AND   PM.JOB_CATEGORY_ID        = W_JOB_CATEGORY_ID))
          AND ((W_EMPLOYE_3_YN            = 'Y'  -- ����� ����.
          AND   PM.JOIN_DATE              <= TRUNC(LAST_DAY(SYSDATE))
          AND   (PM.RETIRE_DATE           >= TRUNC(SYSDATE, 'MONTH') OR PM.RETIRE_DATE IS NULL))
          OR  ( W_EMPLOYE_3_YN            = 'N'  -- ����� ���� ����.
          AND   1                         = 1))
        ORDER BY DM.DEPT_CODE, PC.SORT_NUM, PM.PERSON_NUM
        ;        
  END SELECT_WITHHOLDING_TAX;


-- �ξ簡������
  PROCEDURE SELECT_SUPPORT_FAMILY
            ( P_CURSOR               OUT TYPES.TCURSOR
            , W_PERSON_ID             IN NUMBER
            , W_YEAR_YYYY             IN VARCHAR2
            , W_SOB_ID                IN NUMBER
            , W_ORG_ID                IN NUMBER
            )
  AS  
  BEGIN
    OPEN P_CURSOR FOR
      SELECT HSF1.YEAR_YYYY,
              PM.PERSON_ID,
              EAPP_REGISTER_AGE_F(HSF1.REPRE_NUM, YA.SUBMIT_DATE, 0) AS AGE,                       -- ����.
              
              HSF1.RELATION_CODE AS RELATION_CODE,                                                 -- �����ڵ�.
              HSF1.FAMILY_NAME AS FAMILY_NAME,                                                     -- ����.  
              CASE 
                WHEN NVL(HSF1.BASE_YN, 'N') = 'Y' THEN '��' 
                ELSE NULL
              END BASE_YN,                                                                        -- �⺻����.             
              CASE
                WHEN NVL(HSF1.OLD1_YN, 'N') = 'Y' THEN '��'
                WHEN NVL(HSF1.OLD_YN, 'N') = 'Y' THEN '��'
                ELSE NULL
              END OLD_YN,                                                                         -- ��ο��.             
              CASE
                WHEN NVL(HSF1.BIRTH_YN, 'N') = 'Y' THEN '��'
                ELSE NULL
              END BIRTH_YN,                                                                       -- ���/�Ծ����.             
              CASE 
                WHEN NVL(HSF1.DISABILITY_YN, 'N') = 'Y' THEN '��'
                ELSE NULL
              END DISABILITY_YN,                                                                      -- �����.             
              CASE 
                WHEN NVL(HSF1.CHILD_YN, 'N') = 'Y' THEN '��'
                ELSE NULL
              END CHILD_YN,                                                                       -- �ڳ����(6������). 
                          
              DECODE((NVL(HSF1.INSURE_AMT, 0) + NVL(HSF1.DISABILITY_INSURE_AMT, 0)), 0, NULL, 
              (NVL(HSF1.INSURE_AMT, 0) + NVL(HSF1.DISABILITY_INSURE_AMT, 0))) AS INSURE_AMT,         -- ����û-����� 
                          
              DECODE(HSF1.MEDICAL_AMT, 0, NULL, HSF1.MEDICAL_AMT) AS MEDICAL_AMT,                -- ����û-�Ƿ��             
              DECODE(HSF1.EDUCATION_AMT, 0, NULL, HSF1.EDUCATION_AMT) AS EDU_AMT,                -- ����û-������             
              DECODE(HSF1.CREDIT_AMT, 0, NULL, HSF1.CREDIT_AMT) AS CREDIT_AMT,                   -- ����û-�ſ�ī��             
              DECODE(HSF1.CHECK_CREDIT_AMT, 0, NULL, HSF1.CHECK_CREDIT_AMT) AS CHECK_CREDIT_AMT, -- ����û-����ī��             
              DECODE((NVL(HSF1.CASH_AMT, 0) + NVL(HSF1.ACADE_GIRO_AMT, 0)), 0, NULL, 
              (NVL(HSF1.CASH_AMT, 0) + NVL(HSF1.ACADE_GIRO_AMT, 0))) AS CASH_AMT,                -- ����û-����             
              DECODE((NVL(HSF1.DONAT_POLI, 0) + NVL(HSF1.DONAT_ALL, 0) + NVL(HSF1.DONAT_50P, 0) + NVL(HSF1.DONAT_30P, 0) 
              + NVL(HSF1.DONAT_10P, 0) + NVL(HSF1.DONAT_10P_RELIGION, 0)), 0, NULL, 
              (NVL(HSF1.DONAT_POLI, 0) + NVL(HSF1.DONAT_ALL, 0) + NVL(HSF1.DONAT_50P, 0) + NVL(HSF1.DONAT_30P, 0) 
              + NVL(HSF1.DONAT_10P, 0) + NVL(HSF1.DONAT_10P_RELIGION, 0))) AS DONAT_AMT,         -- ����û-��α�
              
              NVL(SX1.MANY_CHILD_DED_COUNT, 0) AS MANY_CHILD_DED_COUNT,                          -- ���ڳ� �ο���.
              
              PM.NATIONALITY_TYPE,                                                                -- ���� Ÿ��           
              HSF1.REPRE_NUM AS REPRE_NUM,                                                        -- �ֹι�ȣ.
             
              CASE 
                WHEN NVL(HSF1.WOMAN_YN, 'N') = 'Y' THEN '��'
                ELSE NULL
              END WOMAN_YN,                                                                                   -- �γ���.             
              DECODE((NVL(HSF1.ETC_INSURE_AMT, 0) + NVL(HSF1.ETC_DISABILITY_INSURE_AMT, 0)), 0, NULL,
              (NVL(HSF1.ETC_INSURE_AMT, 0) + NVL(HSF1.ETC_DISABILITY_INSURE_AMT, 0))) AS ETC_INSURE_AMT,      -- ��Ÿ-����� 
                          
              DECODE(HSF1.ETC_MEDICAL_AMT, 0, NULL, HSF1.ETC_MEDICAL_AMT) AS ETC_MEDICAL_AMT,                -- ��Ÿ-�Ƿ��             
              DECODE(HSF1.ETC_EDUCATION_AMT, 0, NULL, HSF1.ETC_EDUCATION_AMT) AS ETC_EDU_AMT,                -- ��Ÿ-������             
              DECODE(HSF1.ETC_CREDIT_AMT, 0, NULL, HSF1.ETC_CREDIT_AMT) AS ETC_CREDIT_AMT,                   -- ��Ÿ-�ſ�ī��             
              DECODE(HSF1.ETC_CHECK_CREDIT_AMT, 0, NULL, HSF1.ETC_CHECK_CREDIT_AMT) AS CHECK_ETC_CREDIT_AMT, -- ��Ÿ-����ī��             
              DECODE((NVL(HSF1.ETC_CASH_AMT, 0) + NVL(HSF1.ETC_ACADE_GIRO_AMT, 0)), 0, NULL,
              (NVL(HSF1.ETC_CASH_AMT, 0) + NVL(HSF1.ETC_ACADE_GIRO_AMT, 0))) AS ETC_CASH_AMT,                -- ��Ÿ-����             
              DECODE((NVL(HSF1.ETC_DONAT_POLI, 0) + NVL(HSF1.ETC_DONAT_ALL, 0) + NVL(HSF1.ETC_DONAT_50P, 0) 
              + NVL(HSF1.ETC_DONAT_30P, 0) + NVL(HSF1.ETC_DONAT_10P, 0) + NVL(HSF1.ETC_DONAT_10P_RELIGION, 0)), 0, NULL,
              (NVL(HSF1.ETC_DONAT_POLI, 0) + NVL(HSF1.ETC_DONAT_ALL, 0) + NVL(HSF1.ETC_DONAT_50P, 0) 
              + NVL(HSF1.ETC_DONAT_30P, 0) + NVL(HSF1.ETC_DONAT_10P, 0) + NVL(HSF1.ETC_DONAT_10P_RELIGION, 0))) AS ETC_DONAT_AMT, --��Ÿ-��α�
          
              NVL(HSF1.SUPPORT_YN, 'N') SUPPORT_YN,
              NVL(HSF1.SPOUSE_YN, 'N') SPOUSE_YN
              
         FROM HRM_PERSON_MASTER PM
            , HRA_YEAR_ADJUSTMENT YA
            , HRA_SUPPORT_FAMILY HSF1          
            , HRM_YEAR_RELATION_V HYR
            , ( SELECT HSF.YEAR_YYYY
                      , HSF.PERSON_ID
                      , HSF.SOB_ID
                      , HSF.ORG_ID
                      , SUM(CASE
                               WHEN HSF.BASE_YN = 'Y' AND HSF.RELATION_CODE = '4' AND
                                    EAPP_REGISTER_AGE_F(HSF.REPRE_NUM, YA.SUBMIT_DATE, 0) <= 20 THEN 1
                               ELSE 0
                             END) MANY_CHILD_DED_COUNT
                   FROM HRA_SUPPORT_FAMILY HSF
                       , HRA_YEAR_ADJUSTMENT YA
                  WHERE YA.YEAR_YYYY       = HSF.YEAR_YYYY
                    AND YA.PERSON_ID       = HSF.PERSON_ID
                    AND YA.SOB_ID          = HSF.SOB_ID
                    AND YA.ORG_ID          = HSF.ORG_ID
                    AND HSF.YEAR_YYYY      = W_YEAR_YYYY
                    AND HSF.PERSON_ID      = W_PERSON_ID
                    AND HSF.SOB_ID         = W_SOB_ID
                    AND HSF.ORG_ID         = W_ORG_ID
                    AND HSF.REPRE_NUM      IS NOT NULL
              GROUP BY HSF.YEAR_YYYY
                      , HSF.PERSON_ID
                      , HSF.SOB_ID
                      , HSF.ORG_ID
              ) SX1
       WHERE PM.PERSON_ID         = YA.PERSON_ID
         AND YA.YEAR_YYYY         = HSF1.YEAR_YYYY
         AND YA.PERSON_ID         = HSF1.PERSON_ID
         AND YA.SOB_ID            = HSF1.SOB_ID
         AND YA.ORG_ID            = HSF1.ORG_ID
         AND HSF1.RELATION_CODE   = HYR.YEAR_RELATION_CODE
         AND HSF1.SOB_ID          = HYR.SOB_ID
         AND HSF1.ORG_ID          = HYR.ORG_ID
         AND HSF1.YEAR_YYYY       = SX1.YEAR_YYYY(+)
         AND HSF1.PERSON_ID       = SX1.PERSON_ID(+)
         AND HSF1.SOB_ID          = SX1.SOB_ID(+)
         AND HSF1.ORG_ID          = SX1.ORG_ID(+)
         AND HSF1.YEAR_YYYY       = W_YEAR_YYYY
         AND HSF1.PERSON_ID       = W_PERSON_ID
         AND HSF1.SOB_ID          = W_SOB_ID
         AND HSF1.ORG_ID          = W_ORG_ID
       ORDER BY HYR.SORT_NUM, HSF1.REPRE_NUM
       ;
  END SELECT_SUPPORT_FAMILY;
     
  

/*                  
-- ����*���� �� �ҵ���� ����
  PROCEDURE SELECT_SAVING_INFO
      
  END SELECT_SAVING_INFO; 
*/ 
-------------------------------------------------------------------------------------------
-- �����ٷμҵ濡���Ѽҵ漼��õ¡������ �μ� --
-------------------------------------------------------------------------------------------
  PROCEDURE PRINT_INCOME_TAX
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_PERSON_ID         IN NUMBER
            , W_START_DATE        IN VARCHAR2
            , W_END_DATE          IN VARCHAR2
            , W_SOB_ID            IN NUMBER
            , W_ORG_ID            IN NUMBER
            )
  AS
    V_PAY_YYYYMM_FR               VARCHAR2(7);
    V_PAY_YYYYMM_TO               VARCHAR2(7);
  BEGIN
    V_PAY_YYYYMM_FR := W_START_DATE;
    V_PAY_YYYYMM_TO := W_END_DATE;
    
    OPEN P_CURSOR FOR
    
    ----------------------------------------------------------------------------------------------------------------------------
    -- ��ȸ���ǿ� ���� �� �� ������ ���
    ----------------------------------------------------------------------------------------------------------------------------
    SELECT PM.NAME                                                                     -- ����.
           , PM.REPRE_NUM                                                               -- �ֹι�ȣ.
           , PM.PRSN_ADDR1 || ' ' || PM.PRSN_ADDR2 AS ADDRESS                           -- �ּ�.
           , CM.CORP_NAME AS CORP_NAME                                                  -- ��ü��ȣ.
           , OU.VAT_NUMBER                                                              -- ������ȣ.
           , OU.CORP_ADDRESS                                                            -- ��ü�ּ�1,2
           , CM.TEL_NUMBER                                                              -- ��ȭ��ȣ.
           , CM.PRESIDENT_NAME                                                          -- ��ǥ�ڼ���.
           , CM.LEGAL_NUMBER                                                            -- ���ι�ȣ.
           , REPLACE(HMP.PAY_YYYYMM_01, '-', '.') AS PAY_YYYYMM_01
           , DECODE(HMP.SUPPLY_AMOUNT_01, 0, NULL, HMP.SUPPLY_AMOUNT_01) AS SUPPLY_AMOUNT_01
           , DECODE(HMP.TAX_AMOUNT_01, 0, NULL, HMP.TAX_AMOUNT_01) AS TAX_AMOUNT_01
           , TO_CHAR(HMP.SUPPLY_DATE_01, 'YYYY.MM.DD') AS SUPPLY_DATE_01
           , REPLACE(HMP.PAY_YYYYMM_02, '-', '.') AS PAY_YYYYMM_02
           , DECODE(HMP.SUPPLY_AMOUNT_02, 0, NULL, HMP.SUPPLY_AMOUNT_02) AS SUPPLY_AMOUNT_02
           , DECODE(HMP.TAX_AMOUNT_02, 0, NULL, HMP.TAX_AMOUNT_02) AS TAX_AMOUNT_02
           , TO_CHAR(HMP.SUPPLY_DATE_02, 'YYYY.MM.DD') AS SUPPLY_DATE_02
           , REPLACE(HMP.PAY_YYYYMM_03, '-', '.') AS PAY_YYYYMM_03
           , DECODE(HMP.SUPPLY_AMOUNT_03, 0, NULL, HMP.SUPPLY_AMOUNT_03) AS SUPPLY_AMOUNT_03
           , DECODE(HMP.TAX_AMOUNT_03, 0, NULL, HMP.TAX_AMOUNT_03) AS TAX_AMOUNT_03
           , TO_CHAR(HMP.SUPPLY_DATE_03, 'YYYY.MM.DD') AS SUPPLY_DATE_03
           , REPLACE(HMP.PAY_YYYYMM_04, '-', '.') AS PAY_YYYYMM_04
           , DECODE(HMP.SUPPLY_AMOUNT_04, 0, NULL, HMP.SUPPLY_AMOUNT_04) AS SUPPLY_AMOUNT_04
           , DECODE(HMP.TAX_AMOUNT_04, 0, NULL, HMP.TAX_AMOUNT_04) AS TAX_AMOUNT_04
           , TO_CHAR(HMP.SUPPLY_DATE_04, 'YYYY.MM.DD') AS SUPPLY_DATE_04
           , REPLACE(HMP.PAY_YYYYMM_05, '-', '.') AS PAY_YYYYMM_05
           , DECODE(HMP.SUPPLY_AMOUNT_05, 0, NULL, HMP.SUPPLY_AMOUNT_05) AS SUPPLY_AMOUNT_05
           , DECODE(HMP.TAX_AMOUNT_05, 0, NULL, HMP.TAX_AMOUNT_05) AS TAX_AMOUNT_05
           , TO_CHAR(HMP.SUPPLY_DATE_05, 'YYYY.MM.DD') AS SUPPLY_DATE_05
           , REPLACE(HMP.PAY_YYYYMM_06, '-', '.') AS PAY_YYYYMM_06
           , DECODE(HMP.SUPPLY_AMOUNT_06, 0, NULL, HMP.SUPPLY_AMOUNT_06) AS SUPPLY_AMOUNT_06
           , DECODE(HMP.TAX_AMOUNT_06, 0, NULL, HMP.TAX_AMOUNT_06) AS TAX_AMOUNT_06
           , TO_CHAR(HMP.SUPPLY_DATE_06, 'YYYY.MM.DD') AS SUPPLY_DATE_06
           , REPLACE(HMP.PAY_YYYYMM_07, '-', '.') AS PAY_YYYYMM_07
           , DECODE(HMP.SUPPLY_AMOUNT_07, 0, NULL, HMP.SUPPLY_AMOUNT_07) AS SUPPLY_AMOUNT_07
           , DECODE(HMP.TAX_AMOUNT_07, 0, NULL, HMP.TAX_AMOUNT_07) AS TAX_AMOUNT_07
           , TO_CHAR(HMP.SUPPLY_DATE_07, 'YYYY.MM.DD') AS SUPPLY_DATE_07
           , REPLACE(HMP.PAY_YYYYMM_08, '-', '.') AS PAY_YYYYMM_08
           , DECODE(HMP.SUPPLY_AMOUNT_08, 0, NULL, HMP.SUPPLY_AMOUNT_08) AS SUPPLY_AMOUNT_08
           , DECODE(HMP.TAX_AMOUNT_08, 0, NULL, HMP.TAX_AMOUNT_08) AS TAX_AMOUNT_08
           , TO_CHAR(HMP.SUPPLY_DATE_08, 'YYYY.MM.DD') AS SUPPLY_DATE_08
           , REPLACE(HMP.PAY_YYYYMM_09, '-', '.') AS PAY_YYYYMM_09
           , DECODE(HMP.SUPPLY_AMOUNT_09, 0, NULL, HMP.SUPPLY_AMOUNT_09) AS SUPPLY_AMOUNT_09
           , DECODE(HMP.TAX_AMOUNT_09, 0, NULL, HMP.TAX_AMOUNT_09) AS TAX_AMOUNT_09
           , TO_CHAR(HMP.SUPPLY_DATE_09, 'YYYY.MM.DD') AS SUPPLY_DATE_09
           , REPLACE(HMP.PAY_YYYYMM_10, '-', '.') AS PAY_YYYYMM_10
           , DECODE(HMP.SUPPLY_AMOUNT_10, 0, NULL, HMP.SUPPLY_AMOUNT_10) AS SUPPLY_AMOUNT_10
           , DECODE(HMP.TAX_AMOUNT_10, 0, NULL, HMP.TAX_AMOUNT_10) AS TAX_AMOUNT_10
           , TO_CHAR(HMP.SUPPLY_DATE_10, 'YYYY.MM.DD') AS SUPPLY_DATE_10
           , REPLACE(HMP.PAY_YYYYMM_11, '-', '.') AS PAY_YYYYMM_11
           , DECODE(HMP.SUPPLY_AMOUNT_11, 0, NULL, HMP.SUPPLY_AMOUNT_11) AS SUPPLY_AMOUNT_11
           , DECODE(HMP.TAX_AMOUNT_11, 0, NULL, HMP.TAX_AMOUNT_11) AS TAX_AMOUNT_11
           , TO_CHAR(HMP.SUPPLY_DATE_11, 'YYYY.MM.DD') AS SUPPLY_DATE_11
           , REPLACE(HMP.PAY_YYYYMM_12, '-', '.') AS PAY_YYYYMM_12
           , DECODE(HMP.SUPPLY_AMOUNT_12, 0, NULL, HMP.SUPPLY_AMOUNT_12) AS SUPPLY_AMOUNT_12
           , DECODE(HMP.TAX_AMOUNT_12, 0, NULL, HMP.TAX_AMOUNT_12) AS TAX_AMOUNT_12
           , TO_CHAR(HMP.SUPPLY_DATE_12, 'YYYY.MM.DD') AS SUPPLY_DATE_12
           , DECODE(HMP.TOTAL_SUPPLY_AMOUNT, 0, NULL, HMP.TOTAL_SUPPLY_AMOUNT) AS TOTAL_SUPPLY_AMOUNT
           , DECODE(HMP.TOTAL_TAX_AMOUNT, 0, NULL, HMP.TOTAL_TAX_AMOUNT) AS TOTAL_TAX_AMOUNT
        FROM HRM_PERSON_MASTER PM
          , HRM_CORP_MASTER CM
          , ( SELECT HOU.CORP_ID
                   , HOU.VAT_NUMBER 
                   , HOU.ADDR1 || ' ' || HOU.ADDR2 AS CORP_ADDRESS
                FROM HRM_OPERATING_UNIT HOU
              WHERE HOU.SOB_ID          = W_SOB_ID
                AND HOU.ORG_ID          = W_ORG_ID
                AND HOU.DEFAULT_FLAG    = 'Y'
            ) OU
          , ( SELECT MP.PERSON_ID
                    , MAX(DECODE(MP.PAY_YYYYMM, TO_CHAR(ADD_MONTHS(TO_DATE(V_PAY_YYYYMM_FR, 'YYYY-MM'), 0), 'YYYY-MM'), MP.PAY_YYYYMM, NULL)) AS PAY_YYYYMM_01
                    , SUM(DECODE(MP.PAY_YYYYMM, TO_CHAR(ADD_MONTHS(TO_DATE(V_PAY_YYYYMM_FR, 'YYYY-MM'), 0), 'YYYY-MM'), MP.TOT_SUPPLY_AMOUNT, 0)) AS SUPPLY_AMOUNT_01
                    , SUM(DECODE(MP.PAY_YYYYMM, TO_CHAR(ADD_MONTHS(TO_DATE(V_PAY_YYYYMM_FR, 'YYYY-MM'), 0), 'YYYY-MM'), MD.TAX_AMOUNT, 0)) AS TAX_AMOUNT_01                 
                    , MAX(CASE
                              WHEN MP.PAY_YYYYMM = TO_CHAR(ADD_MONTHS(TO_DATE(V_PAY_YYYYMM_FR, 'YYYY-MM'), 0), 'YYYY-MM') THEN NVL(DECODE(MP.WAGE_TYPE, 'P1', MP.SUPPLY_DATE, NULL), MP.SUPPLY_DATE)
                              ELSE NULL
                          END) AS SUPPLY_DATE_01
                    
                    , MAX(DECODE(MP.PAY_YYYYMM, TO_CHAR(ADD_MONTHS(TO_DATE(V_PAY_YYYYMM_FR, 'YYYY-MM'), 1), 'YYYY-MM'), MP.PAY_YYYYMM, NULL)) AS PAY_YYYYMM_02
                    , SUM(DECODE(MP.PAY_YYYYMM, TO_CHAR(ADD_MONTHS(TO_DATE(V_PAY_YYYYMM_FR, 'YYYY-MM'), 1), 'YYYY-MM'), MP.TOT_SUPPLY_AMOUNT, 0)) AS SUPPLY_AMOUNT_02
                    , SUM(DECODE(MP.PAY_YYYYMM, TO_CHAR(ADD_MONTHS(TO_DATE(V_PAY_YYYYMM_FR, 'YYYY-MM'), 1), 'YYYY-MM'), MD.TAX_AMOUNT, 0)) AS TAX_AMOUNT_02
                    , MAX(CASE
                              WHEN MP.PAY_YYYYMM = TO_CHAR(ADD_MONTHS(TO_DATE(V_PAY_YYYYMM_FR, 'YYYY-MM'), 1), 'YYYY-MM') THEN NVL(DECODE(MP.WAGE_TYPE, 'P1', MP.SUPPLY_DATE, NULL), MP.SUPPLY_DATE)
                              ELSE NULL
                          END) AS SUPPLY_DATE_02                          
                         
                    , MAX(DECODE(MP.PAY_YYYYMM, TO_CHAR(ADD_MONTHS(TO_DATE(V_PAY_YYYYMM_FR, 'YYYY-MM'), 2), 'YYYY-MM'), MP.PAY_YYYYMM, NULL)) AS PAY_YYYYMM_03
                    , SUM(DECODE(MP.PAY_YYYYMM, TO_CHAR(ADD_MONTHS(TO_DATE(V_PAY_YYYYMM_FR, 'YYYY-MM'), 2), 'YYYY-MM'), MP.TOT_SUPPLY_AMOUNT, 0)) AS SUPPLY_AMOUNT_03
                    , SUM(DECODE(MP.PAY_YYYYMM, TO_CHAR(ADD_MONTHS(TO_DATE(V_PAY_YYYYMM_FR, 'YYYY-MM'), 2), 'YYYY-MM'), MD.TAX_AMOUNT, 0)) AS TAX_AMOUNT_03
                    , MAX(CASE
                              WHEN MP.PAY_YYYYMM = TO_CHAR(ADD_MONTHS(TO_DATE(V_PAY_YYYYMM_FR, 'YYYY-MM'), 2), 'YYYY-MM') THEN NVL(DECODE(MP.WAGE_TYPE, 'P1', MP.SUPPLY_DATE, NULL), MP.SUPPLY_DATE)
                              ELSE NULL
                          END) AS SUPPLY_DATE_03
                          
                    , MAX(DECODE(MP.PAY_YYYYMM, TO_CHAR(ADD_MONTHS(TO_DATE(V_PAY_YYYYMM_FR, 'YYYY-MM'), 3), 'YYYY-MM'), MP.PAY_YYYYMM, NULL)) AS PAY_YYYYMM_04
                    , SUM(DECODE(MP.PAY_YYYYMM, TO_CHAR(ADD_MONTHS(TO_DATE(V_PAY_YYYYMM_FR, 'YYYY-MM'), 3), 'YYYY-MM'), MP.TOT_SUPPLY_AMOUNT, 0)) AS SUPPLY_AMOUNT_04
                    , SUM(DECODE(MP.PAY_YYYYMM, TO_CHAR(ADD_MONTHS(TO_DATE(V_PAY_YYYYMM_FR, 'YYYY-MM'), 3), 'YYYY-MM'), MD.TAX_AMOUNT, 0)) AS TAX_AMOUNT_04
                    , MAX(CASE
                              WHEN MP.PAY_YYYYMM = TO_CHAR(ADD_MONTHS(TO_DATE(V_PAY_YYYYMM_FR, 'YYYY-MM'), 3), 'YYYY-MM') THEN NVL(DECODE(MP.WAGE_TYPE, 'P1', MP.SUPPLY_DATE, NULL), MP.SUPPLY_DATE)
                              ELSE NULL
                          END) AS SUPPLY_DATE_04
                          
                    , MAX(DECODE(MP.PAY_YYYYMM, TO_CHAR(ADD_MONTHS(TO_DATE(V_PAY_YYYYMM_FR, 'YYYY-MM'), 4), 'YYYY-MM'), MP.PAY_YYYYMM, NULL)) AS PAY_YYYYMM_05
                    , SUM(DECODE(MP.PAY_YYYYMM, TO_CHAR(ADD_MONTHS(TO_DATE(V_PAY_YYYYMM_FR, 'YYYY-MM'), 4), 'YYYY-MM'), MP.TOT_SUPPLY_AMOUNT, 0)) AS SUPPLY_AMOUNT_05
                    , SUM(DECODE(MP.PAY_YYYYMM, TO_CHAR(ADD_MONTHS(TO_DATE(V_PAY_YYYYMM_FR, 'YYYY-MM'), 4), 'YYYY-MM'), MD.TAX_AMOUNT, 0)) AS TAX_AMOUNT_05
                    , MAX(CASE
                              WHEN MP.PAY_YYYYMM = TO_CHAR(ADD_MONTHS(TO_DATE(V_PAY_YYYYMM_FR, 'YYYY-MM'), 4), 'YYYY-MM') THEN NVL(DECODE(MP.WAGE_TYPE, 'P1', MP.SUPPLY_DATE, NULL), MP.SUPPLY_DATE)
                              ELSE NULL
                          END) AS SUPPLY_DATE_05
                          
                    , MAX(DECODE(MP.PAY_YYYYMM, TO_CHAR(ADD_MONTHS(TO_DATE(V_PAY_YYYYMM_FR, 'YYYY-MM'), 5), 'YYYY-MM'), MP.PAY_YYYYMM, NULL)) AS PAY_YYYYMM_06
                    , SUM(DECODE(MP.PAY_YYYYMM, TO_CHAR(ADD_MONTHS(TO_DATE(V_PAY_YYYYMM_FR, 'YYYY-MM'), 5), 'YYYY-MM'), MP.TOT_SUPPLY_AMOUNT, 0)) AS SUPPLY_AMOUNT_06
                    , SUM(DECODE(MP.PAY_YYYYMM, TO_CHAR(ADD_MONTHS(TO_DATE(V_PAY_YYYYMM_FR, 'YYYY-MM'), 5), 'YYYY-MM'), MD.TAX_AMOUNT, 0)) AS TAX_AMOUNT_06
                    , MAX(CASE
                              WHEN MP.PAY_YYYYMM = TO_CHAR(ADD_MONTHS(TO_DATE(V_PAY_YYYYMM_FR, 'YYYY-MM'), 5), 'YYYY-MM') THEN NVL(DECODE(MP.WAGE_TYPE, 'P1', MP.SUPPLY_DATE, NULL), MP.SUPPLY_DATE)
                              ELSE NULL
                          END) AS SUPPLY_DATE_06
                          
                    , MAX(DECODE(MP.PAY_YYYYMM, TO_CHAR(ADD_MONTHS(TO_DATE(V_PAY_YYYYMM_FR, 'YYYY-MM'), 6), 'YYYY-MM'), MP.PAY_YYYYMM, NULL)) AS PAY_YYYYMM_07
                    , SUM(DECODE(MP.PAY_YYYYMM, TO_CHAR(ADD_MONTHS(TO_DATE(V_PAY_YYYYMM_FR, 'YYYY-MM'), 6), 'YYYY-MM'), MP.TOT_SUPPLY_AMOUNT, 0)) AS SUPPLY_AMOUNT_07
                    , SUM(DECODE(MP.PAY_YYYYMM, TO_CHAR(ADD_MONTHS(TO_DATE(V_PAY_YYYYMM_FR, 'YYYY-MM'), 6), 'YYYY-MM'), MD.TAX_AMOUNT, 0)) AS TAX_AMOUNT_07
                    , MAX(CASE
                              WHEN MP.PAY_YYYYMM = TO_CHAR(ADD_MONTHS(TO_DATE(V_PAY_YYYYMM_FR, 'YYYY-MM'), 6), 'YYYY-MM') THEN NVL(DECODE(MP.WAGE_TYPE, 'P1', MP.SUPPLY_DATE, NULL), MP.SUPPLY_DATE)
                              ELSE NULL
                          END) AS SUPPLY_DATE_07
                          
                    , MAX(DECODE(MP.PAY_YYYYMM, TO_CHAR(ADD_MONTHS(TO_DATE(V_PAY_YYYYMM_FR, 'YYYY-MM'), 7), 'YYYY-MM'), MP.PAY_YYYYMM, NULL)) AS PAY_YYYYMM_08
                    , SUM(DECODE(MP.PAY_YYYYMM, TO_CHAR(ADD_MONTHS(TO_DATE(V_PAY_YYYYMM_FR, 'YYYY-MM'), 7), 'YYYY-MM'), MP.TOT_SUPPLY_AMOUNT, 0)) AS SUPPLY_AMOUNT_08
                    , SUM(DECODE(MP.PAY_YYYYMM, TO_CHAR(ADD_MONTHS(TO_DATE(V_PAY_YYYYMM_FR, 'YYYY-MM'), 7), 'YYYY-MM'), MD.TAX_AMOUNT, 0)) AS TAX_AMOUNT_08
                    , MAX(CASE
                              WHEN MP.PAY_YYYYMM = TO_CHAR(ADD_MONTHS(TO_DATE(V_PAY_YYYYMM_FR, 'YYYY-MM'), 7), 'YYYY-MM') THEN NVL(DECODE(MP.WAGE_TYPE, 'P1', MP.SUPPLY_DATE, NULL), MP.SUPPLY_DATE)
                              ELSE NULL
                          END) AS SUPPLY_DATE_08
                          
                    , MAX(DECODE(MP.PAY_YYYYMM, TO_CHAR(ADD_MONTHS(TO_DATE(V_PAY_YYYYMM_FR, 'YYYY-MM'), 8), 'YYYY-MM'), MP.PAY_YYYYMM, NULL)) AS PAY_YYYYMM_09
                    , SUM(DECODE(MP.PAY_YYYYMM, TO_CHAR(ADD_MONTHS(TO_DATE(V_PAY_YYYYMM_FR, 'YYYY-MM'), 8), 'YYYY-MM'), MP.TOT_SUPPLY_AMOUNT, 0)) AS SUPPLY_AMOUNT_09
                    , SUM(DECODE(MP.PAY_YYYYMM, TO_CHAR(ADD_MONTHS(TO_DATE(V_PAY_YYYYMM_FR, 'YYYY-MM'), 8), 'YYYY-MM'), MD.TAX_AMOUNT, 0)) AS TAX_AMOUNT_09
                    , MAX(CASE
                              WHEN MP.PAY_YYYYMM = TO_CHAR(ADD_MONTHS(TO_DATE(V_PAY_YYYYMM_FR, 'YYYY-MM'), 8), 'YYYY-MM') THEN NVL(DECODE(MP.WAGE_TYPE, 'P1', MP.SUPPLY_DATE, NULL), MP.SUPPLY_DATE)
                              ELSE NULL
                          END) AS SUPPLY_DATE_09
                          
                    , MAX(DECODE(MP.PAY_YYYYMM, TO_CHAR(ADD_MONTHS(TO_DATE(V_PAY_YYYYMM_FR, 'YYYY-MM'), 9), 'YYYY-MM'), MP.PAY_YYYYMM, NULL)) AS PAY_YYYYMM_10
                    , SUM(DECODE(MP.PAY_YYYYMM, TO_CHAR(ADD_MONTHS(TO_DATE(V_PAY_YYYYMM_FR, 'YYYY-MM'), 9), 'YYYY-MM'), MP.TOT_SUPPLY_AMOUNT, 0)) AS SUPPLY_AMOUNT_10
                    , SUM(DECODE(MP.PAY_YYYYMM, TO_CHAR(ADD_MONTHS(TO_DATE(V_PAY_YYYYMM_FR, 'YYYY-MM'), 9), 'YYYY-MM'), MD.TAX_AMOUNT, 0)) AS TAX_AMOUNT_10
                    , MAX(CASE
                              WHEN MP.PAY_YYYYMM = TO_CHAR(ADD_MONTHS(TO_DATE(V_PAY_YYYYMM_FR, 'YYYY-MM'), 9), 'YYYY-MM') THEN NVL(DECODE(MP.WAGE_TYPE, 'P1', MP.SUPPLY_DATE, NULL), MP.SUPPLY_DATE)
                              ELSE NULL
                          END) AS SUPPLY_DATE_10
                          
                    , MAX(DECODE(MP.PAY_YYYYMM, TO_CHAR(ADD_MONTHS(TO_DATE(V_PAY_YYYYMM_FR, 'YYYY-MM'), 10), 'YYYY-MM'), MP.PAY_YYYYMM, NULL)) AS PAY_YYYYMM_11
                    , SUM(DECODE(MP.PAY_YYYYMM, TO_CHAR(ADD_MONTHS(TO_DATE(V_PAY_YYYYMM_FR, 'YYYY-MM'), 10), 'YYYY-MM'), MP.TOT_SUPPLY_AMOUNT, 0)) AS SUPPLY_AMOUNT_11
                    , SUM(DECODE(MP.PAY_YYYYMM, TO_CHAR(ADD_MONTHS(TO_DATE(V_PAY_YYYYMM_FR, 'YYYY-MM'), 10), 'YYYY-MM'), MD.TAX_AMOUNT, 0)) AS TAX_AMOUNT_11
                    , MAX(CASE
                              WHEN MP.PAY_YYYYMM = TO_CHAR(ADD_MONTHS(TO_DATE(V_PAY_YYYYMM_FR, 'YYYY-MM'), 10), 'YYYY-MM') THEN NVL(DECODE(MP.WAGE_TYPE, 'P1', MP.SUPPLY_DATE, NULL), MP.SUPPLY_DATE)
                              ELSE NULL
                          END) AS SUPPLY_DATE_11
                          
                    , MAX(DECODE(MP.PAY_YYYYMM, TO_CHAR(ADD_MONTHS(TO_DATE(V_PAY_YYYYMM_FR, 'YYYY-MM'), 11), 'YYYY-MM'), MP.PAY_YYYYMM, NULL)) AS PAY_YYYYMM_12
                    , SUM(DECODE(MP.PAY_YYYYMM, TO_CHAR(ADD_MONTHS(TO_DATE(V_PAY_YYYYMM_FR, 'YYYY-MM'), 11), 'YYYY-MM'), MP.TOT_SUPPLY_AMOUNT, 0)) AS SUPPLY_AMOUNT_12
                    , SUM(DECODE(MP.PAY_YYYYMM, TO_CHAR(ADD_MONTHS(TO_DATE(V_PAY_YYYYMM_FR, 'YYYY-MM'), 11), 'YYYY-MM'), MD.TAX_AMOUNT, 0)) AS TAX_AMOUNT_12
                    , MAX(CASE
                              WHEN MP.PAY_YYYYMM = TO_CHAR(ADD_MONTHS(TO_DATE(V_PAY_YYYYMM_FR, 'YYYY-MM'), 11), 'YYYY-MM') THEN NVL(DECODE(MP.WAGE_TYPE, 'P1', MP.SUPPLY_DATE, NULL), MP.SUPPLY_DATE)
                              ELSE NULL
                          END) AS SUPPLY_DATE_12   
                   , SUM(MP.TOT_SUPPLY_AMOUNT) AS TOTAL_SUPPLY_AMOUNT
                   , SUM(MD.TAX_AMOUNT) AS TOTAL_TAX_AMOUNT
                FROM HRP_MONTH_PAYMENT MP
                  , ( SELECT HMD.MONTH_PAYMENT_ID
                           , SUM(HMD.DEDUCTION_AMOUNT) AS TAX_AMOUNT
                        FROM HRP_MONTH_DEDUCTION HMD
                          , HRM_DEDUCTION_V HD
                      WHERE HMD.DEDUCTION_ID  = HD.DEDUCTION_ID
                        AND HMD.PAY_YYYYMM    BETWEEN V_PAY_YYYYMM_FR AND V_PAY_YYYYMM_TO
                        AND HMD.PERSON_ID     = NVL(W_PERSON_ID, HMD.PERSON_ID)
                        AND HMD.SOB_ID        = W_SOB_ID
                        AND HMD.ORG_ID        = W_ORG_ID
                        AND HD.DEDUCTION_CODE = 'D01' -- �ҵ漼.
                      GROUP BY HMD.MONTH_PAYMENT_ID
                    ) MD
              WHERE MP.MONTH_PAYMENT_ID       = MD.MONTH_PAYMENT_ID(+)
                AND MP.PAY_YYYYMM             BETWEEN V_PAY_YYYYMM_FR AND V_PAY_YYYYMM_TO
                AND MP.PERSON_ID              = NVL(W_PERSON_ID,MP.PERSON_ID)
                AND MP.SOB_ID                 = W_SOB_ID
                AND MP.ORG_ID                 = W_ORG_ID
              GROUP BY MP.PERSON_ID
              ) HMP
      WHERE PM.CORP_ID                = CM.CORP_ID
        AND CM.CORP_ID                = OU.CORP_ID(+)
        AND PM.PERSON_ID              = HMP.PERSON_ID(+)
        AND PM.PERSON_ID              = NVL(W_PERSON_ID, PM.PERSON_ID)
      ;
      
    ----------------------------------------------------------------------------------------------------------------------------
    -- �ش�⵵�� ���� ��(1 �� ~ 12 ��) ���� ���
    ----------------------------------------------------------------------------------------------------------------------------
    /*
      SELECT PM.NAME                                                                   -- ����.
           , PM.REPRE_NUM                                                               -- �ֹι�ȣ.
           , PM.PRSN_ADDR1 || ' ' || PM.PRSN_ADDR2 AS ADDRESS                           -- �ּ�.
           , CM.CORP_NAME AS CORP_NAME                                                  -- ��ü��ȣ.
           , OU.VAT_NUMBER                                                              -- ������ȣ.
           , OU.CORP_ADDRESS                                                            -- ��ü�ּ�1,2
           , CM.TEL_NUMBER                                                              -- ��ȭ��ȣ.
           , CM.PRESIDENT_NAME                                                          -- ��ǥ�ڼ���.
           , CM.LEGAL_NUMBER                                                            -- ���ι�ȣ.
           , REPLACE(HMP.PAY_YYYYMM_01, '-', '.') AS PAY_YYYYMM_01
           , DECODE(HMP.SUPPLY_AMOUNT_01, 0, NULL, HMP.SUPPLY_AMOUNT_01) AS SUPPLY_AMOUNT_01
           , DECODE(HMP.TAX_AMOUNT_01, 0, NULL, HMP.TAX_AMOUNT_01) AS TAX_AMOUNT_01
           , TO_CHAR(HMP.SUPPLY_DATE_01, 'YYYY.MM.DD') AS SUPPLY_DATE_01
           , REPLACE(HMP.PAY_YYYYMM_02, '-', '.') AS PAY_YYYYMM_02
           , DECODE(HMP.SUPPLY_AMOUNT_02, 0, NULL, HMP.SUPPLY_AMOUNT_02) AS SUPPLY_AMOUNT_02
           , DECODE(HMP.TAX_AMOUNT_02, 0, NULL, HMP.TAX_AMOUNT_02) AS TAX_AMOUNT_02
           , TO_CHAR(HMP.SUPPLY_DATE_02, 'YYYY.MM.DD') AS SUPPLY_DATE_02
           , REPLACE(HMP.PAY_YYYYMM_03, '-', '.') AS PAY_YYYYMM_03
           , DECODE(HMP.SUPPLY_AMOUNT_03, 0, NULL, HMP.SUPPLY_AMOUNT_03) AS SUPPLY_AMOUNT_03
           , DECODE(HMP.TAX_AMOUNT_03, 0, NULL, HMP.TAX_AMOUNT_03) AS TAX_AMOUNT_03
           , TO_CHAR(HMP.SUPPLY_DATE_03, 'YYYY.MM.DD') AS SUPPLY_DATE_03
           , REPLACE(HMP.PAY_YYYYMM_04, '-', '.') AS PAY_YYYYMM_04
           , DECODE(HMP.SUPPLY_AMOUNT_04, 0, NULL, HMP.SUPPLY_AMOUNT_04) AS SUPPLY_AMOUNT_04
           , DECODE(HMP.TAX_AMOUNT_04, 0, NULL, HMP.TAX_AMOUNT_04) AS TAX_AMOUNT_04
           , TO_CHAR(HMP.SUPPLY_DATE_04, 'YYYY.MM.DD') AS SUPPLY_DATE_04
           , REPLACE(HMP.PAY_YYYYMM_05, '-', '.') AS PAY_YYYYMM_05
           , DECODE(HMP.SUPPLY_AMOUNT_05, 0, NULL, HMP.SUPPLY_AMOUNT_05) AS SUPPLY_AMOUNT_05
           , DECODE(HMP.TAX_AMOUNT_05, 0, NULL, HMP.TAX_AMOUNT_05) AS TAX_AMOUNT_05
           , TO_CHAR(HMP.SUPPLY_DATE_05, 'YYYY.MM.DD') AS SUPPLY_DATE_05
           , REPLACE(HMP.PAY_YYYYMM_06, '-', '.') AS PAY_YYYYMM_06
           , DECODE(HMP.SUPPLY_AMOUNT_06, 0, NULL, HMP.SUPPLY_AMOUNT_06) AS SUPPLY_AMOUNT_06
           , DECODE(HMP.TAX_AMOUNT_06, 0, NULL, HMP.TAX_AMOUNT_06) AS TAX_AMOUNT_06
           , TO_CHAR(HMP.SUPPLY_DATE_06, 'YYYY.MM.DD') AS SUPPLY_DATE_06
           , REPLACE(HMP.PAY_YYYYMM_07, '-', '.') AS PAY_YYYYMM_07
           , DECODE(HMP.SUPPLY_AMOUNT_07, 0, NULL, HMP.SUPPLY_AMOUNT_07) AS SUPPLY_AMOUNT_07
           , DECODE(HMP.TAX_AMOUNT_07, 0, NULL, HMP.TAX_AMOUNT_07) AS TAX_AMOUNT_07
           , TO_CHAR(HMP.SUPPLY_DATE_07, 'YYYY.MM.DD') AS SUPPLY_DATE_07
           , REPLACE(HMP.PAY_YYYYMM_08, '-', '.') AS PAY_YYYYMM_08
           , DECODE(HMP.SUPPLY_AMOUNT_08, 0, NULL, HMP.SUPPLY_AMOUNT_08) AS SUPPLY_AMOUNT_08
           , DECODE(HMP.TAX_AMOUNT_08, 0, NULL, HMP.TAX_AMOUNT_08) AS TAX_AMOUNT_08
           , TO_CHAR(HMP.SUPPLY_DATE_08, 'YYYY.MM.DD') AS SUPPLY_DATE_08
           , REPLACE(HMP.PAY_YYYYMM_09, '-', '.') AS PAY_YYYYMM_09
           , DECODE(HMP.SUPPLY_AMOUNT_09, 0, NULL, HMP.SUPPLY_AMOUNT_09) AS SUPPLY_AMOUNT_09
           , DECODE(HMP.TAX_AMOUNT_09, 0, NULL, HMP.TAX_AMOUNT_09) AS TAX_AMOUNT_09
           , TO_CHAR(HMP.SUPPLY_DATE_09, 'YYYY.MM.DD') AS SUPPLY_DATE_09
           , REPLACE(HMP.PAY_YYYYMM_10, '-', '.') AS PAY_YYYYMM_10
           , DECODE(HMP.SUPPLY_AMOUNT_10, 0, NULL, HMP.SUPPLY_AMOUNT_10) AS SUPPLY_AMOUNT_10
           , DECODE(HMP.TAX_AMOUNT_10, 0, NULL, HMP.TAX_AMOUNT_10) AS TAX_AMOUNT_10
           , TO_CHAR(HMP.SUPPLY_DATE_10, 'YYYY.MM.DD') AS SUPPLY_DATE_10
           , REPLACE(HMP.PAY_YYYYMM_11, '-', '.') AS PAY_YYYYMM_11
           , DECODE(HMP.SUPPLY_AMOUNT_11, 0, NULL, HMP.SUPPLY_AMOUNT_11) AS SUPPLY_AMOUNT_11
           , DECODE(HMP.TAX_AMOUNT_11, 0, NULL, HMP.TAX_AMOUNT_11) AS TAX_AMOUNT_11
           , TO_CHAR(HMP.SUPPLY_DATE_11, 'YYYY.MM.DD') AS SUPPLY_DATE_11
           , REPLACE(HMP.PAY_YYYYMM_12, '-', '.') AS PAY_YYYYMM_12
           , DECODE(HMP.SUPPLY_AMOUNT_12, 0, NULL, HMP.SUPPLY_AMOUNT_12) AS SUPPLY_AMOUNT_12
           , DECODE(HMP.TAX_AMOUNT_12, 0, NULL, HMP.TAX_AMOUNT_12) AS TAX_AMOUNT_12
           , TO_CHAR(HMP.SUPPLY_DATE_12, 'YYYY.MM.DD') AS SUPPLY_DATE_12
           , DECODE(HMP.TOTAL_SUPPLY_AMOUNT, 0, NULL, HMP.TOTAL_SUPPLY_AMOUNT) AS TOTAL_SUPPLY_AMOUNT
           , DECODE(HMP.TOTAL_TAX_AMOUNT, 0, NULL, HMP.TOTAL_TAX_AMOUNT) AS TOTAL_TAX_AMOUNT
        FROM HRM_PERSON_MASTER PM
          , HRM_CORP_MASTER CM
          , ( SELECT HOU.CORP_ID
                   , HOU.VAT_NUMBER 
                   , HOU.ADDR1 || ' ' || HOU.ADDR2 AS CORP_ADDRESS
                FROM HRM_OPERATING_UNIT HOU
              WHERE HOU.SOB_ID          = W_SOB_ID
                AND HOU.ORG_ID          = W_ORG_ID
                AND HOU.DEFAULT_FLAG    = 'Y'
            ) OU
          , ( SELECT MP.PERSON_ID
                   
                   , MAX(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '01', MP.PAY_YYYYMM, NULL)) AS PAY_YYYYMM_01
                   , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '01', MP.TOT_SUPPLY_AMOUNT, 0)) AS SUPPLY_AMOUNT_01
                   , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '01', MD.TAX_AMOUNT, 0)) AS TAX_AMOUNT_01
                 
                   , MAX(CASE
                           WHEN SUBSTR(MP.PAY_YYYYMM, 6, 2) = '01' THEN NVL(DECODE(MP.WAGE_TYPE, 'P1', MP.SUPPLY_DATE, NULL), MP.SUPPLY_DATE)
                           ELSE NULL
                         END) AS SUPPLY_DATE_01
                   , MAX(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '02', MP.PAY_YYYYMM, NULL)) AS PAY_YYYYMM_02
                   , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '02', MP.TOT_SUPPLY_AMOUNT, 0)) AS SUPPLY_AMOUNT_02
                   , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '02', MD.TAX_AMOUNT, 0)) AS TAX_AMOUNT_02
                   , MAX(CASE
                           WHEN SUBSTR(MP.PAY_YYYYMM, 6, 2) = '02' THEN NVL(DECODE(MP.WAGE_TYPE, 'P1', MP.SUPPLY_DATE, NULL), MP.SUPPLY_DATE)
                           ELSE NULL
                         END) AS SUPPLY_DATE_02
                   , MAX(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '03', MP.PAY_YYYYMM, NULL)) AS PAY_YYYYMM_03
                   , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '03', MP.TOT_SUPPLY_AMOUNT, 0)) AS SUPPLY_AMOUNT_03
                   , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '03', MD.TAX_AMOUNT, 0)) AS TAX_AMOUNT_03
                   , MAX(CASE
                           WHEN SUBSTR(MP.PAY_YYYYMM, 6, 2) = '03' THEN NVL(DECODE(MP.WAGE_TYPE, 'P1', MP.SUPPLY_DATE, NULL), MP.SUPPLY_DATE)
                           ELSE NULL
                         END) AS SUPPLY_DATE_03
                   , MAX(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '04', MP.PAY_YYYYMM, NULL)) AS PAY_YYYYMM_04
                   , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '04', MP.TOT_SUPPLY_AMOUNT, 0)) AS SUPPLY_AMOUNT_04
                   , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '04', MD.TAX_AMOUNT, 0)) AS TAX_AMOUNT_04
                   , MAX(CASE
                           WHEN SUBSTR(MP.PAY_YYYYMM, 6, 2) = '04' THEN NVL(DECODE(MP.WAGE_TYPE, 'P1', MP.SUPPLY_DATE, NULL), MP.SUPPLY_DATE)
                           ELSE NULL
                         END) AS SUPPLY_DATE_04
                   , MAX(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '05', MP.PAY_YYYYMM, NULL)) AS PAY_YYYYMM_05
                   , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '05', MP.TOT_SUPPLY_AMOUNT, 0)) AS SUPPLY_AMOUNT_05
                   , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '05', MD.TAX_AMOUNT, 0)) AS TAX_AMOUNT_05
                   , MAX(CASE
                           WHEN SUBSTR(MP.PAY_YYYYMM, 6, 2) = '05' THEN NVL(DECODE(MP.WAGE_TYPE, 'P1', MP.SUPPLY_DATE, NULL), MP.SUPPLY_DATE)
                           ELSE NULL
                         END) AS SUPPLY_DATE_05
                   , MAX(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '06', MP.PAY_YYYYMM, NULL)) AS PAY_YYYYMM_06
                   , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '06', MP.TOT_SUPPLY_AMOUNT, 0)) AS SUPPLY_AMOUNT_06
                   , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '06', MD.TAX_AMOUNT, 0)) AS TAX_AMOUNT_06
                   , MAX(CASE
                           WHEN SUBSTR(MP.PAY_YYYYMM, 6, 2) = '06' THEN NVL(DECODE(MP.WAGE_TYPE, 'P1', MP.SUPPLY_DATE, NULL), MP.SUPPLY_DATE)
                           ELSE NULL
                         END) AS SUPPLY_DATE_06
                   , MAX(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '07', MP.PAY_YYYYMM, NULL)) AS PAY_YYYYMM_07
                   , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '07', MP.TOT_SUPPLY_AMOUNT, 0)) AS SUPPLY_AMOUNT_07
                   , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '07', MD.TAX_AMOUNT, 0)) AS TAX_AMOUNT_07
                   , MAX(CASE
                           WHEN SUBSTR(MP.PAY_YYYYMM, 6, 2) = '07' THEN NVL(DECODE(MP.WAGE_TYPE, 'P1', MP.SUPPLY_DATE, NULL), MP.SUPPLY_DATE)
                           ELSE NULL
                         END) AS SUPPLY_DATE_07
                   , MAX(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '08', MP.PAY_YYYYMM, NULL)) AS PAY_YYYYMM_08
                   , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '08', MP.TOT_SUPPLY_AMOUNT, 0)) AS SUPPLY_AMOUNT_08
                   , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '08', MD.TAX_AMOUNT, 0)) AS TAX_AMOUNT_08
                   , MAX(CASE
                           WHEN SUBSTR(MP.PAY_YYYYMM, 6, 2) = '08' THEN NVL(DECODE(MP.WAGE_TYPE, 'P1', MP.SUPPLY_DATE, NULL), MP.SUPPLY_DATE)
                           ELSE NULL
                         END) AS SUPPLY_DATE_08
                         
                   , MAX(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '09', MP.PAY_YYYYMM, NULL)) AS PAY_YYYYMM_09
                   , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '09', MP.TOT_SUPPLY_AMOUNT, 0)) AS SUPPLY_AMOUNT_09
                   , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '09', MD.TAX_AMOUNT, 0)) AS TAX_AMOUNT_09
                   , MAX(CASE
                           WHEN SUBSTR(MP.PAY_YYYYMM, 6, 2) = '09' THEN NVL(DECODE(MP.WAGE_TYPE, 'P1', MP.SUPPLY_DATE, NULL), MP.SUPPLY_DATE)
                           ELSE NULL
                         END) AS SUPPLY_DATE_09
                   , MAX(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '10', MP.PAY_YYYYMM, NULL)) AS PAY_YYYYMM_10
                   , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '10', MP.TOT_SUPPLY_AMOUNT, 0)) AS SUPPLY_AMOUNT_10
                   , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '10', MD.TAX_AMOUNT, 0)) AS TAX_AMOUNT_10
                   , MAX(CASE
                           WHEN SUBSTR(MP.PAY_YYYYMM, 6, 2) = '10' THEN NVL(DECODE(MP.WAGE_TYPE, 'P1', MP.SUPPLY_DATE, NULL), MP.SUPPLY_DATE)
                           ELSE NULL
                         END) AS SUPPLY_DATE_10
                   , MAX(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '11', MP.PAY_YYYYMM, NULL)) AS PAY_YYYYMM_11
                   , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '11', MP.TOT_SUPPLY_AMOUNT, 0)) AS SUPPLY_AMOUNT_11
                   , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '11', MD.TAX_AMOUNT, 0)) AS TAX_AMOUNT_11
                   , MAX(CASE
                           WHEN SUBSTR(MP.PAY_YYYYMM, 6, 2) = '11' THEN NVL(DECODE(MP.WAGE_TYPE, 'P1', MP.SUPPLY_DATE, NULL), MP.SUPPLY_DATE)
                           ELSE NULL
                         END) AS SUPPLY_DATE_11
                   , MAX(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '12', MP.PAY_YYYYMM, NULL)) AS PAY_YYYYMM_12
                   , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '12', MP.TOT_SUPPLY_AMOUNT, 0)) AS SUPPLY_AMOUNT_12
                   , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '12', MD.TAX_AMOUNT, 0)) AS TAX_AMOUNT_12
                   , MAX(CASE
                           WHEN SUBSTR(MP.PAY_YYYYMM, 6, 2) = '12' THEN NVL(DECODE(MP.WAGE_TYPE, 'P1', MP.SUPPLY_DATE, NULL), MP.SUPPLY_DATE)
                           ELSE NULL
                         END) AS SUPPLY_DATE_12
                   , SUM(MP.TOT_SUPPLY_AMOUNT) AS TOTAL_SUPPLY_AMOUNT
                   , SUM(MD.TAX_AMOUNT) AS TOTAL_TAX_AMOUNT
                FROM HRP_MONTH_PAYMENT MP
                  , ( SELECT HMD.MONTH_PAYMENT_ID
                           , SUM(HMD.DEDUCTION_AMOUNT) AS TAX_AMOUNT
                        FROM HRP_MONTH_DEDUCTION HMD
                          , HRM_DEDUCTION_V HD
                      WHERE HMD.DEDUCTION_ID  = HD.DEDUCTION_ID
                        AND HMD.PAY_YYYYMM    BETWEEN V_PAY_YYYYMM_FR AND V_PAY_YYYYMM_TO
                        AND HMD.PERSON_ID     = NVL(W_PERSON_ID, HMD.PERSON_ID)
                        AND HMD.SOB_ID        = W_SOB_ID
                        AND HMD.ORG_ID        = W_ORG_ID
                        AND HD.DEDUCTION_CODE = 'D01' -- �ҵ漼.
                      GROUP BY HMD.MONTH_PAYMENT_ID
                    ) MD
              WHERE MP.MONTH_PAYMENT_ID       = MD.MONTH_PAYMENT_ID(+)
                AND MP.PAY_YYYYMM             BETWEEN V_PAY_YYYYMM_FR AND V_PAY_YYYYMM_TO
                AND MP.PERSON_ID              = NVL(W_PERSON_ID,MP.PERSON_ID)
                AND MP.SOB_ID                 = W_SOB_ID
                AND MP.ORG_ID                 = W_ORG_ID
              GROUP BY MP.PERSON_ID
              ) HMP
      WHERE PM.CORP_ID                = CM.CORP_ID
        AND CM.CORP_ID                = OU.CORP_ID(+)
        AND PM.PERSON_ID              = HMP.PERSON_ID(+)
        AND PM.PERSON_ID              = NVL(W_PERSON_ID, PM.PERSON_ID)
      ;
      */
  
  END PRINT_INCOME_TAX;
  
-------------------------------------------------------------------------------------------
-- �ҵ��ں� �ٷμҵ��õ¡���� --
-------------------------------------------------------------------------------------------
  PROCEDURE PRINT_IN_EARNER_DED_TAX
            ( P_CURSOR            OUT TYPES.TCURSOR
            , P_CORP_ID           IN NUMBER
            , P_PERSON_ID         IN NUMBER
            , P_YEAR_YYYY         IN VARCHAR2
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            )
  AS
    V_PAY_YYYYMM_FR               VARCHAR2(7);
    V_PAY_YYYYMM_TO               VARCHAR2(7);
  BEGIN
    V_PAY_YYYYMM_FR := P_YEAR_YYYY || '-01';
    V_PAY_YYYYMM_TO := P_YEAR_YYYY || '-12';
    
    OPEN P_CURSOR FOR
      SELECT P_YEAR_YYYY AS YEAR_YYYY                                                  -- �ͼӿ���
           , S_CM.CORP_NAME                                                             -- ���θ�(��ȣ).
           , S_CM.VAT_NUMBER                                                            -- ����ڹ�ȣ.
           , S_CM.CORP_ADDRESS                                                          -- �ٹ�ó.
           , PM.NAME                                                                    -- ����.
           , PM.REPRE_NUM                                                               -- �ֹι�ȣ.
           , CASE
               WHEN PM.JOIN_DATE IS NULL THEN TO_CHAR(NULL)
               ELSE HRM_COMMON_DATE_G.DATE_YYYYMMDD_F(PM.JOIN_DATE) 
             END AS JOIN_DATE               -- �Ի���.
           , CASE
               WHEN PM.RETIRE_DATE IS NULL THEN TO_CHAR(NULL)
               ELSE HRM_COMMON_DATE_G.DATE_YYYYMMDD_F(PM.RETIRE_DATE) 
             END AS RETIRE_DATE           -- �����.
           , HRM_COMMON_G.CODE_NAME_F('NATIONALITY_TYPE', PM.NATIONALITY_TYPE, PM.SOB_ID, PM.ORG_ID) AS NATIONALITY_TYPE_DESC
           , S_HN.NATION_NAME                                                           -- ����.
           , S_HN.ISO_NATION_CODE                                                       -- �����ڵ�.
           , 1 + NVL(S_HF.DED_FAMILY_COUNT, 0) AS DED_FAMILY_COUNT
           , S_HF.DED_CHILD_COUNT
           , '��' AS DECREASE_YN
           , NULL AS DECREASE_REASON
           , NULL AS DECREASE_PERIOD
           -- �ٷμҵ����޸�.
           -- 1��.
           , REPLACE(HMP.PAY_YYYYMM_01, '-', '.') AS PAY_YYYYMM_01                          -- ���޿���.
           , HMP.PAY_AMOUNT_01
           , HMP.BONUS_AMOUNT_01
           , HMP.SUM_AMOUNT_01
           , NULL AS TEMP_TAX_SECTION_01
           , NULL AS TEMP_TAX_AMOUNT_01
           , NULL AS ETC_TAX_AMOUNT_01
           , HMP.SUBT_IN_TAX_AMT_01 AS INCOME_TAX_AMOUNT_01
           , HMP.SUBT_LOCAL_TAX_AMT_01 AS LOCAL_TAX_AMOUNT_01
           -- 2��.
           , REPLACE(HMP.PAY_YYYYMM_02, '-', '.') AS PAY_YYYYMM_02                          -- ���޿���.
           , HMP.PAY_AMOUNT_02
           , HMP.BONUS_AMOUNT_02
           , HMP.SUM_AMOUNT_02
           , NULL AS TEMP_TAX_SECTION_02
           , NULL AS TEMP_TAX_AMOUNT_02
           , NULL AS ETC_TAX_AMOUNT_02
           , HMP.SUBT_IN_TAX_AMT_02 AS INCOME_TAX_AMOUNT_02
           , HMP.SUBT_LOCAL_TAX_AMT_02 AS LOCAL_TAX_AMOUNT_02
           -- 3��.
           , REPLACE(HMP.PAY_YYYYMM_03, '-', '.') AS PAY_YYYYMM_03                          -- ���޿���.
           , HMP.PAY_AMOUNT_03
           , HMP.BONUS_AMOUNT_03
           , HMP.SUM_AMOUNT_03
           , NULL AS TEMP_TAX_SECTION_03
           , NULL AS TEMP_TAX_AMOUNT_03
           , NULL AS ETC_TAX_AMOUNT_03
           , HMP.SUBT_IN_TAX_AMT_03 AS INCOME_TAX_AMOUNT_03
           , HMP.SUBT_LOCAL_TAX_AMT_03 AS LOCAL_TAX_AMOUNT_03
           -- 4��.
           , REPLACE(HMP.PAY_YYYYMM_04, '-', '.') AS PAY_YYYYMM_04                          -- ���޿���.
           , HMP.PAY_AMOUNT_04
           , HMP.BONUS_AMOUNT_04
           , HMP.SUM_AMOUNT_04
           , NULL AS TEMP_TAX_SECTION_04
           , NULL AS TEMP_TAX_AMOUNT_04
           , NULL AS ETC_TAX_AMOUNT_04
           , HMP.SUBT_IN_TAX_AMT_04 AS INCOME_TAX_AMOUNT_04
           , HMP.SUBT_LOCAL_TAX_AMT_04 AS LOCAL_TAX_AMOUNT_04
           -- 5��.
           , REPLACE(HMP.PAY_YYYYMM_05, '-', '.') AS PAY_YYYYMM_05                          -- ���޿���.
           , HMP.PAY_AMOUNT_05
           , HMP.BONUS_AMOUNT_05
           , HMP.SUM_AMOUNT_05 
           , NULL AS TEMP_TAX_SECTION_05
           , NULL AS TEMP_TAX_AMOUNT_05
           , NULL AS ETC_TAX_AMOUNT_05
           , HMP.SUBT_IN_TAX_AMT_05 AS INCOME_TAX_AMOUNT_05
           , HMP.SUBT_LOCAL_TAX_AMT_05 AS LOCAL_TAX_AMOUNT_05
           -- 6��.
           , REPLACE(HMP.PAY_YYYYMM_06, '-', '.') AS PAY_YYYYMM_06                          -- ���޿���.
           , HMP.PAY_AMOUNT_06
           , HMP.BONUS_AMOUNT_06
           , HMP.SUM_AMOUNT_06  
           , NULL AS TEMP_TAX_SECTION_06
           , NULL AS TEMP_TAX_AMOUNT_06
           , NULL AS ETC_TAX_AMOUNT_06
           , HMP.SUBT_IN_TAX_AMT_06 AS INCOME_TAX_AMOUNT_06
           , HMP.SUBT_LOCAL_TAX_AMT_06 AS LOCAL_TAX_AMOUNT_06
           -- 7��.
           , REPLACE(HMP.PAY_YYYYMM_07, '-', '.') AS PAY_YYYYMM_07                          -- ���޿���.
           , HMP.PAY_AMOUNT_07
           , HMP.BONUS_AMOUNT_07
           , HMP.SUM_AMOUNT_07
           , NULL AS TEMP_TAX_SECTION_07
           , NULL AS TEMP_TAX_AMOUNT_07
           , NULL AS ETC_TAX_AMOUNT_07
           , HMP.SUBT_IN_TAX_AMT_07 AS INCOME_TAX_AMOUNT_07
           , HMP.SUBT_LOCAL_TAX_AMT_07 AS LOCAL_TAX_AMOUNT_07
           -- 8��.
           , REPLACE(HMP.PAY_YYYYMM_08, '-', '.') AS PAY_YYYYMM_08                          -- ���޿���.
           , HMP.PAY_AMOUNT_08
           , HMP.BONUS_AMOUNT_08
           , HMP.SUM_AMOUNT_08
           , NULL AS TEMP_TAX_SECTION_08
           , NULL AS TEMP_TAX_AMOUNT_08
           , NULL AS ETC_TAX_AMOUNT_08
           , HMP.SUBT_IN_TAX_AMT_08 AS INCOME_TAX_AMOUNT_08
           , HMP.SUBT_LOCAL_TAX_AMT_08 AS LOCAL_TAX_AMOUNT_08
           -- 9��.
           , REPLACE(HMP.PAY_YYYYMM_09, '-', '.') AS PAY_YYYYMM_09                          -- ���޿���.
           , HMP.PAY_AMOUNT_09
           , HMP.BONUS_AMOUNT_09
           , HMP.SUM_AMOUNT_09
           , NULL AS TEMP_TAX_SECTION_09
           , NULL AS TEMP_TAX_AMOUNT_09
           , NULL AS ETC_TAX_AMOUNT_09
           , HMP.SUBT_IN_TAX_AMT_09 AS INCOME_TAX_AMOUNT_09
           , HMP.SUBT_LOCAL_TAX_AMT_09 AS LOCAL_TAX_AMOUNT_09
           -- 10��.
           , REPLACE(HMP.PAY_YYYYMM_10, '-', '.') AS PAY_YYYYMM_10                          -- ���޿���.
           , HMP.PAY_AMOUNT_10
           , HMP.BONUS_AMOUNT_10
           , HMP.SUM_AMOUNT_10
           , NULL AS TEMP_TAX_SECTION_10
           , NULL AS TEMP_TAX_AMOUNT_10
           , NULL AS ETC_TAX_AMOUNT_10
           , HMP.SUBT_IN_TAX_AMT_10 AS INCOME_TAX_AMOUNT_10
           , HMP.SUBT_LOCAL_TAX_AMT_10 AS LOCAL_TAX_AMOUNT_10
           -- 11��.
           , REPLACE(HMP.PAY_YYYYMM_11, '-', '.') AS PAY_YYYYMM_11                          -- ���޿���.
           , HMP.PAY_AMOUNT_11
           , HMP.BONUS_AMOUNT_11
           , HMP.SUM_AMOUNT_11
           , NULL AS TEMP_TAX_SECTION_11
           , NULL AS TEMP_TAX_AMOUNT_11
           , NULL AS ETC_TAX_AMOUNT_11
           , HMP.SUBT_IN_TAX_AMT_11 AS INCOME_TAX_AMOUNT_11
           , HMP.SUBT_LOCAL_TAX_AMT_11 AS LOCAL_TAX_AMOUNT_11
           -- 12��.
           , REPLACE(HMP.PAY_YYYYMM_12, '-', '.') AS PAY_YYYYMM_12                          -- ���޿���.
           , HMP.PAY_AMOUNT_12
           , HMP.BONUS_AMOUNT_12
           , HMP.SUM_AMOUNT_12
           , NULL AS TEMP_TAX_SECTION_12
           , NULL AS TEMP_TAX_AMOUNT_12
           , NULL AS ETC_TAX_AMOUNT_12
           , HMP.SUBT_IN_TAX_AMT_12 AS INCOME_TAX_AMOUNT_12
           , HMP.SUBT_LOCAL_TAX_AMT_12 AS LOCAL_TAX_AMOUNT_12
           -- ��.
           , HMP.TOTAL_PAY_AMOUNT
           , HMP.TOTAL_BONUS_AMOUNT
           , HMP.TOTAL_SUM_AMOUNT
           , NULL AS TOTAL_TEMP_TAX_SECTION
           , NULL AS TOTAL_TEMP_TAX_AMOUNT
           , NULL AS TOTAL_ETC_TAX_AMOUNT
           , HMP.TOTAL_SUBT_IN_TAX_AMT AS TOTAL_INCOME_TAX_AMOUNT
           , HMP.TOTAL_SUBT_LOCAL_TAX_AMT AS TOTAL_LOCAL_TAX_AMOUNT
           -- II.�� �� �� �� ��.
           -- 1��.
           , HMP.TAX_FREE_OUTSIDE_01
           , HMP.TAX_FREE_OT_01
           , HMP.TAX_FREE_BABY_01
           , NVL(HMP.TAX_FREE_OT_01, 0) + NVL(HMP.TAX_FREE_OUTSIDE_01, 0) + NVL(HMP.TAX_FREE_BABY_01, 0) AS TAX_FREE_PART_01
           , NVL(HMP.TAX_FREE_OT_01, 0) + NVL(HMP.TAX_FREE_OUTSIDE_01, 0) + NVL(HMP.TAX_FREE_BABY_01, 0) AS TAX_FREE_SUM_1_01
           , HMP.TAX_FREE_CAR_01
           , HMP.TAX_FREE_ETC_01
           , NVL(HMP.TAX_FREE_CAR_01, 0) + NVL(HMP.TAX_FREE_ETC_01, 0) AS TAX_FREE_SUM_2_01
           -- 2��.
           , HMP.TAX_FREE_OUTSIDE_02
           , HMP.TAX_FREE_OT_02
           , HMP.TAX_FREE_BABY_02
           , NVL(HMP.TAX_FREE_OT_02, 0) + NVL(HMP.TAX_FREE_OUTSIDE_02, 0) + NVL(HMP.TAX_FREE_BABY_02, 0) AS TAX_FREE_PART_02
           , NVL(HMP.TAX_FREE_OT_02, 0) + NVL(HMP.TAX_FREE_OUTSIDE_02, 0) + NVL(HMP.TAX_FREE_BABY_02, 0) AS TAX_FREE_SUM_1_02
           , HMP.TAX_FREE_CAR_02
           , HMP.TAX_FREE_ETC_02
           , NVL(HMP.TAX_FREE_CAR_02, 0) + NVL(HMP.TAX_FREE_ETC_02, 0) AS TAX_FREE_SUM_2_02
           -- 3��.
           , HMP.TAX_FREE_OUTSIDE_03
           , HMP.TAX_FREE_OT_03           
           , HMP.TAX_FREE_BABY_03
           , NVL(HMP.TAX_FREE_OT_03, 0) + NVL(HMP.TAX_FREE_OUTSIDE_03, 0) + NVL(HMP.TAX_FREE_BABY_03, 0) AS TAX_FREE_PART_03
           , NVL(HMP.TAX_FREE_OT_03, 0) + NVL(HMP.TAX_FREE_OUTSIDE_03, 0) + NVL(HMP.TAX_FREE_BABY_03, 0) AS TAX_FREE_SUM_1_03
           , HMP.TAX_FREE_CAR_03
           , HMP.TAX_FREE_ETC_03
           , NVL(HMP.TAX_FREE_CAR_03, 0) + NVL(HMP.TAX_FREE_ETC_03, 0) AS TAX_FREE_SUM_2_03
           -- 4 ��.
           , HMP.TAX_FREE_OUTSIDE_04
           , HMP.TAX_FREE_OT_04           
           , HMP.TAX_FREE_BABY_04
           , NVL(HMP.TAX_FREE_OT_04, 0) + NVL(HMP.TAX_FREE_OUTSIDE_04, 0) + NVL(HMP.TAX_FREE_BABY_04, 0) AS TAX_FREE_PART_04
           , NVL(HMP.TAX_FREE_OT_04, 0) + NVL(HMP.TAX_FREE_OUTSIDE_04, 0) + NVL(HMP.TAX_FREE_BABY_04, 0) AS TAX_FREE_SUM_1_04
           , HMP.TAX_FREE_CAR_04
           , HMP.TAX_FREE_ETC_04
           , NVL(HMP.TAX_FREE_CAR_04, 0) + NVL(HMP.TAX_FREE_ETC_04, 0) AS TAX_FREE_SUM_2_04
           -- 5��.
           , HMP.TAX_FREE_OUTSIDE_05
           , HMP.TAX_FREE_OT_05           
           , HMP.TAX_FREE_BABY_05
           , NVL(HMP.TAX_FREE_OT_05, 0) + NVL(HMP.TAX_FREE_OUTSIDE_05, 0) + NVL(HMP.TAX_FREE_BABY_05, 0) AS TAX_FREE_PART_05
           , NVL(HMP.TAX_FREE_OT_05, 0) + NVL(HMP.TAX_FREE_OUTSIDE_05, 0) + NVL(HMP.TAX_FREE_BABY_05, 0) AS TAX_FREE_SUM_1_05
           , HMP.TAX_FREE_CAR_05
           , HMP.TAX_FREE_ETC_05
           , NVL(HMP.TAX_FREE_CAR_05, 0) + NVL(HMP.TAX_FREE_ETC_05, 0) AS TAX_FREE_SUM_2_05
           -- 6��.
           , HMP.TAX_FREE_OUTSIDE_06
           , HMP.TAX_FREE_OT_06           
           , HMP.TAX_FREE_BABY_06
           , NVL(HMP.TAX_FREE_OT_06, 0) + NVL(HMP.TAX_FREE_OUTSIDE_06, 0) + NVL(HMP.TAX_FREE_BABY_06, 0) AS TAX_FREE_PART_06
           , NVL(HMP.TAX_FREE_OT_06, 0) + NVL(HMP.TAX_FREE_OUTSIDE_06, 0) + NVL(HMP.TAX_FREE_BABY_06, 0) AS TAX_FREE_SUM_1_06
           , HMP.TAX_FREE_CAR_06
           , HMP.TAX_FREE_ETC_06
           , NVL(HMP.TAX_FREE_CAR_06, 0) + NVL(HMP.TAX_FREE_ETC_06, 0) AS TAX_FREE_SUM_2_06
           -- 7��.
           , HMP.TAX_FREE_OUTSIDE_07
           , HMP.TAX_FREE_OT_07           
           , HMP.TAX_FREE_BABY_07
           , NVL(HMP.TAX_FREE_OT_07, 0) + NVL(HMP.TAX_FREE_OUTSIDE_07, 0) + NVL(HMP.TAX_FREE_BABY_07, 0) AS TAX_FREE_PART_07
           , NVL(HMP.TAX_FREE_OT_07, 0) + NVL(HMP.TAX_FREE_OUTSIDE_07, 0) + NVL(HMP.TAX_FREE_BABY_07, 0) AS TAX_FREE_SUM_1_07
           , HMP.TAX_FREE_CAR_07
           , HMP.TAX_FREE_ETC_07
           , NVL(HMP.TAX_FREE_CAR_07, 0) + NVL(HMP.TAX_FREE_ETC_07, 0) AS TAX_FREE_SUM_2_07
           -- 8��.
           , HMP.TAX_FREE_OUTSIDE_08
           , HMP.TAX_FREE_OT_08           
           , HMP.TAX_FREE_BABY_08
           , NVL(HMP.TAX_FREE_OT_08, 0) + NVL(HMP.TAX_FREE_OUTSIDE_08, 0) + NVL(HMP.TAX_FREE_BABY_08, 0) AS TAX_FREE_PART_08
           , NVL(HMP.TAX_FREE_OT_08, 0) + NVL(HMP.TAX_FREE_OUTSIDE_08, 0) + NVL(HMP.TAX_FREE_BABY_08, 0) AS TAX_FREE_SUM_1_08
           , HMP.TAX_FREE_CAR_08
           , HMP.TAX_FREE_ETC_08
           , NVL(HMP.TAX_FREE_CAR_08, 0) + NVL(HMP.TAX_FREE_ETC_08, 0) AS TAX_FREE_SUM_2_08
           -- 9��.
           , HMP.TAX_FREE_OUTSIDE_09
           , HMP.TAX_FREE_OT_09           
           , HMP.TAX_FREE_BABY_09
           , NVL(HMP.TAX_FREE_OT_09, 0) + NVL(HMP.TAX_FREE_OUTSIDE_09, 0) + NVL(HMP.TAX_FREE_BABY_09, 0) AS TAX_FREE_PART_09
           , NVL(HMP.TAX_FREE_OT_09, 0) + NVL(HMP.TAX_FREE_OUTSIDE_09, 0) + NVL(HMP.TAX_FREE_BABY_09, 0) AS TAX_FREE_SUM_1_09
           , HMP.TAX_FREE_CAR_09
           , HMP.TAX_FREE_ETC_09
           , NVL(HMP.TAX_FREE_CAR_09, 0) + NVL(HMP.TAX_FREE_ETC_09, 0) AS TAX_FREE_SUM_2_09
           -- 10 ��.
           , HMP.TAX_FREE_OUTSIDE_10
           , HMP.TAX_FREE_OT_10           
           , HMP.TAX_FREE_BABY_10
           , NVL(HMP.TAX_FREE_OT_10, 0) + NVL(HMP.TAX_FREE_OUTSIDE_10, 0) + NVL(HMP.TAX_FREE_BABY_10, 0) AS TAX_FREE_PART_10
           , NVL(HMP.TAX_FREE_OT_10, 0) + NVL(HMP.TAX_FREE_OUTSIDE_10, 0) + NVL(HMP.TAX_FREE_BABY_10, 0) AS TAX_FREE_SUM_1_10
           , HMP.TAX_FREE_CAR_10
           , HMP.TAX_FREE_ETC_10
           , NVL(HMP.TAX_FREE_CAR_10, 0) + NVL(HMP.TAX_FREE_ETC_10, 0) AS TAX_FREE_SUM_2_10
           -- 11 ��.
           , HMP.TAX_FREE_OUTSIDE_11
           , HMP.TAX_FREE_OT_11           
           , HMP.TAX_FREE_BABY_11
           , NVL(HMP.TAX_FREE_OT_11, 0) + NVL(HMP.TAX_FREE_OUTSIDE_11, 0) + NVL(HMP.TAX_FREE_BABY_11, 0) AS TAX_FREE_PART_11
           , NVL(HMP.TAX_FREE_OT_11, 0) + NVL(HMP.TAX_FREE_OUTSIDE_11, 0) + NVL(HMP.TAX_FREE_BABY_11, 0) AS TAX_FREE_SUM_1_11
           , HMP.TAX_FREE_CAR_11
           , HMP.TAX_FREE_ETC_11
           , NVL(HMP.TAX_FREE_CAR_11, 0) + NVL(HMP.TAX_FREE_ETC_11, 0) AS TAX_FREE_SUM_2_11
           -- 12 ��.
           , HMP.TAX_FREE_OUTSIDE_12
           , HMP.TAX_FREE_OT_12           
           , HMP.TAX_FREE_BABY_12
           , NVL(HMP.TAX_FREE_OT_12, 0) + NVL(HMP.TAX_FREE_OUTSIDE_12, 0) + NVL(HMP.TAX_FREE_BABY_12, 0) AS TAX_FREE_PART_12
           , NVL(HMP.TAX_FREE_OT_12, 0) + NVL(HMP.TAX_FREE_OUTSIDE_12, 0) + NVL(HMP.TAX_FREE_BABY_12, 0) AS TAX_FREE_SUM_1_12
           , HMP.TAX_FREE_CAR_12
           , HMP.TAX_FREE_ETC_12
           , NVL(HMP.TAX_FREE_CAR_12, 0) + NVL(HMP.TAX_FREE_ETC_12, 0) AS TAX_FREE_SUM_2_12
           -- �����:���ܱٷ�.
           , NVL(HMP.TAX_FREE_OUTSIDE_01, 0) + NVL(HMP.TAX_FREE_OUTSIDE_02, 0) + NVL(HMP.TAX_FREE_OUTSIDE_03, 0) +
             NVL(HMP.TAX_FREE_OUTSIDE_04, 0) + NVL(HMP.TAX_FREE_OUTSIDE_05, 0) + NVL(HMP.TAX_FREE_OUTSIDE_06, 0) +
             NVL(HMP.TAX_FREE_OUTSIDE_07, 0) + NVL(HMP.TAX_FREE_OUTSIDE_08, 0) + NVL(HMP.TAX_FREE_OUTSIDE_09, 0) +
             NVL(HMP.TAX_FREE_OUTSIDE_10, 0) + NVL(HMP.TAX_FREE_OUTSIDE_11, 0) + NVL(HMP.TAX_FREE_OUTSIDE_12, 0) AS TOTAL_TAX_FREE_OUTSIDE
           -- �����:�߰�.
           , NVL(HMP.TAX_FREE_OT_01, 0) + NVL(HMP.TAX_FREE_OT_02, 0) + NVL(HMP.TAX_FREE_OT_03, 0) +
             NVL(HMP.TAX_FREE_OT_04, 0) + NVL(HMP.TAX_FREE_OT_05, 0) + NVL(HMP.TAX_FREE_OT_06, 0) +
             NVL(HMP.TAX_FREE_OT_07, 0) + NVL(HMP.TAX_FREE_OT_08, 0) + NVL(HMP.TAX_FREE_OT_09, 0) +
             NVL(HMP.TAX_FREE_OT_10, 0) + NVL(HMP.TAX_FREE_OT_11, 0) + NVL(HMP.TAX_FREE_OT_12, 0) AS TOTAL_TAX_FREE_OT           
           -- �����:��������.
           , NVL(HMP.TAX_FREE_BABY_01, 0) + NVL(HMP.TAX_FREE_BABY_02, 0) + NVL(HMP.TAX_FREE_BABY_03, 0) +
             NVL(HMP.TAX_FREE_BABY_04, 0) + NVL(HMP.TAX_FREE_BABY_05, 0) + NVL(HMP.TAX_FREE_BABY_06, 0) +
             NVL(HMP.TAX_FREE_BABY_07, 0) + NVL(HMP.TAX_FREE_BABY_08, 0) + NVL(HMP.TAX_FREE_BABY_09, 0) +
             NVL(HMP.TAX_FREE_BABY_10, 0) + NVL(HMP.TAX_FREE_BABY_11, 0) + NVL(HMP.TAX_FREE_BABY_12, 0) AS TOTAL_TAX_FREE_BABY
           -- �����:�Ұ�.
           , NVL(HMP.TAX_FREE_OT_01, 0) + NVL(HMP.TAX_FREE_OT_02, 0) + NVL(HMP.TAX_FREE_OT_03, 0) +
             NVL(HMP.TAX_FREE_OT_04, 0) + NVL(HMP.TAX_FREE_OT_05, 0) + NVL(HMP.TAX_FREE_OT_06, 0) +
             NVL(HMP.TAX_FREE_OT_07, 0) + NVL(HMP.TAX_FREE_OT_08, 0) + NVL(HMP.TAX_FREE_OT_09, 0) +
             NVL(HMP.TAX_FREE_OT_10, 0) + NVL(HMP.TAX_FREE_OT_11, 0) + NVL(HMP.TAX_FREE_OT_12, 0) +
             NVL(HMP.TAX_FREE_OUTSIDE_01, 0) + NVL(HMP.TAX_FREE_OUTSIDE_02, 0) + NVL(HMP.TAX_FREE_OUTSIDE_03, 0) +
             NVL(HMP.TAX_FREE_OUTSIDE_04, 0) + NVL(HMP.TAX_FREE_OUTSIDE_05, 0) + NVL(HMP.TAX_FREE_OUTSIDE_06, 0) +
             NVL(HMP.TAX_FREE_OUTSIDE_07, 0) + NVL(HMP.TAX_FREE_OUTSIDE_08, 0) + NVL(HMP.TAX_FREE_OUTSIDE_09, 0) +
             NVL(HMP.TAX_FREE_OUTSIDE_10, 0) + NVL(HMP.TAX_FREE_OUTSIDE_11, 0) + NVL(HMP.TAX_FREE_OUTSIDE_12, 0) +
             NVL(HMP.TAX_FREE_BABY_01, 0) + NVL(HMP.TAX_FREE_BABY_02, 0) + NVL(HMP.TAX_FREE_BABY_03, 0) +
             NVL(HMP.TAX_FREE_BABY_04, 0) + NVL(HMP.TAX_FREE_BABY_05, 0) + NVL(HMP.TAX_FREE_BABY_06, 0) +
             NVL(HMP.TAX_FREE_BABY_07, 0) + NVL(HMP.TAX_FREE_BABY_08, 0) + NVL(HMP.TAX_FREE_BABY_09, 0) +
             NVL(HMP.TAX_FREE_BABY_10, 0) + NVL(HMP.TAX_FREE_BABY_11, 0) + NVL(HMP.TAX_FREE_BABY_12, 0) AS TOTAL_TAX_FREE_PART
           -- �����:�հ�.
           , NVL(HMP.TAX_FREE_OT_01, 0) + NVL(HMP.TAX_FREE_OT_02, 0) + NVL(HMP.TAX_FREE_OT_03, 0) +
             NVL(HMP.TAX_FREE_OT_04, 0) + NVL(HMP.TAX_FREE_OT_05, 0) + NVL(HMP.TAX_FREE_OT_06, 0) +
             NVL(HMP.TAX_FREE_OT_07, 0) + NVL(HMP.TAX_FREE_OT_08, 0) + NVL(HMP.TAX_FREE_OT_09, 0) +
             NVL(HMP.TAX_FREE_OT_10, 0) + NVL(HMP.TAX_FREE_OT_11, 0) + NVL(HMP.TAX_FREE_OT_12, 0) +
             NVL(HMP.TAX_FREE_OUTSIDE_01, 0) + NVL(HMP.TAX_FREE_OUTSIDE_02, 0) + NVL(HMP.TAX_FREE_OUTSIDE_03, 0) +
             NVL(HMP.TAX_FREE_OUTSIDE_04, 0) + NVL(HMP.TAX_FREE_OUTSIDE_05, 0) + NVL(HMP.TAX_FREE_OUTSIDE_06, 0) +
             NVL(HMP.TAX_FREE_OUTSIDE_07, 0) + NVL(HMP.TAX_FREE_OUTSIDE_08, 0) + NVL(HMP.TAX_FREE_OUTSIDE_09, 0) +
             NVL(HMP.TAX_FREE_OUTSIDE_10, 0) + NVL(HMP.TAX_FREE_OUTSIDE_11, 0) + NVL(HMP.TAX_FREE_OUTSIDE_12, 0) +
             NVL(HMP.TAX_FREE_BABY_01, 0) + NVL(HMP.TAX_FREE_BABY_02, 0) + NVL(HMP.TAX_FREE_BABY_03, 0) +
             NVL(HMP.TAX_FREE_BABY_04, 0) + NVL(HMP.TAX_FREE_BABY_05, 0) + NVL(HMP.TAX_FREE_BABY_06, 0) +
             NVL(HMP.TAX_FREE_BABY_07, 0) + NVL(HMP.TAX_FREE_BABY_08, 0) + NVL(HMP.TAX_FREE_BABY_09, 0) +
             NVL(HMP.TAX_FREE_BABY_10, 0) + NVL(HMP.TAX_FREE_BABY_11, 0) + NVL(HMP.TAX_FREE_BABY_12, 0) AS TOTAL_TAX_FREE_SUM_1  
           -- �����:�ڰ�����������.
           , NVL(HMP.TAX_FREE_CAR_01, 0) + NVL(HMP.TAX_FREE_CAR_02, 0) + NVL(HMP.TAX_FREE_CAR_03, 0) +
             NVL(HMP.TAX_FREE_CAR_04, 0) + NVL(HMP.TAX_FREE_CAR_05, 0) + NVL(HMP.TAX_FREE_CAR_06, 0) +
             NVL(HMP.TAX_FREE_CAR_07, 0) + NVL(HMP.TAX_FREE_CAR_08, 0) + NVL(HMP.TAX_FREE_CAR_09, 0) +
             NVL(HMP.TAX_FREE_CAR_10, 0) + NVL(HMP.TAX_FREE_CAR_11, 0) + NVL(HMP.TAX_FREE_CAR_12, 0) AS TOTAL_TAX_FREE_CAR
           -- ��Ÿ.
           , NVL(HMP.TAX_FREE_ETC_01, 0) + NVL(HMP.TAX_FREE_ETC_02, 0) + NVL(HMP.TAX_FREE_ETC_03, 0) +
             NVL(HMP.TAX_FREE_ETC_04, 0) + NVL(HMP.TAX_FREE_ETC_05, 0) + NVL(HMP.TAX_FREE_ETC_06, 0) +
             NVL(HMP.TAX_FREE_ETC_07, 0) + NVL(HMP.TAX_FREE_ETC_08, 0) + NVL(HMP.TAX_FREE_ETC_09, 0) +
             NVL(HMP.TAX_FREE_ETC_10, 0) + NVL(HMP.TAX_FREE_ETC_11, 0) + NVL(HMP.TAX_FREE_ETC_12, 0) AS TOTAL_TAX_FREE_ETC
           -- �����:�հ�2.
           , NVL(HMP.TAX_FREE_CAR_01, 0) + NVL(HMP.TAX_FREE_CAR_02, 0) + NVL(HMP.TAX_FREE_CAR_03, 0) +
             NVL(HMP.TAX_FREE_CAR_04, 0) + NVL(HMP.TAX_FREE_CAR_05, 0) + NVL(HMP.TAX_FREE_CAR_06, 0) +
             NVL(HMP.TAX_FREE_CAR_07, 0) + NVL(HMP.TAX_FREE_CAR_08, 0) + NVL(HMP.TAX_FREE_CAR_09, 0) +
             NVL(HMP.TAX_FREE_CAR_10, 0) + NVL(HMP.TAX_FREE_CAR_11, 0) + NVL(HMP.TAX_FREE_CAR_12, 0) +
             NVL(HMP.TAX_FREE_ETC_01, 0) + NVL(HMP.TAX_FREE_ETC_02, 0) + NVL(HMP.TAX_FREE_ETC_03, 0) +
             NVL(HMP.TAX_FREE_ETC_04, 0) + NVL(HMP.TAX_FREE_ETC_05, 0) + NVL(HMP.TAX_FREE_ETC_06, 0) +
             NVL(HMP.TAX_FREE_ETC_07, 0) + NVL(HMP.TAX_FREE_ETC_08, 0) + NVL(HMP.TAX_FREE_ETC_09, 0) +
             NVL(HMP.TAX_FREE_ETC_10, 0) + NVL(HMP.TAX_FREE_ETC_11, 0) + NVL(HMP.TAX_FREE_ETC_12, 0) AS TOTAL_TAX_FREE_SUM_2
           -- III�ٷμҵ��õ¡�����׵�.     
           -- 1 ��.
           , HMP.SUBT_IN_TAX_AMT_01
           , HMP.SUBT_LOCAL_TAX_AMT_01 
           , HMP.ANNUITY_IN_AMT_01
           , HMP.HEALTH_IN_AMT_01
           , HMP.UMP_IN_AMT_01
           -- 2 ��.
           , HMP.SUBT_IN_TAX_AMT_02
           , HMP.SUBT_LOCAL_TAX_AMT_02
           , HMP.ANNUITY_IN_AMT_02
           , HMP.HEALTH_IN_AMT_02
           , HMP.UMP_IN_AMT_02
           -- 3 ��.
           , HMP.SUBT_IN_TAX_AMT_03 
           , HMP.SUBT_LOCAL_TAX_AMT_03
           , HMP.ANNUITY_IN_AMT_03
           , HMP.HEALTH_IN_AMT_03
           , HMP.UMP_IN_AMT_03
           -- 4��.
           , HMP.SUBT_IN_TAX_AMT_04
           , HMP.SUBT_LOCAL_TAX_AMT_04
           , HMP.ANNUITY_IN_AMT_04
           , HMP.HEALTH_IN_AMT_04
           , HMP.UMP_IN_AMT_04
           -- 5��.
           , HMP.SUBT_IN_TAX_AMT_05
           , HMP.SUBT_LOCAL_TAX_AMT_05
           , HMP.ANNUITY_IN_AMT_05
           , HMP.HEALTH_IN_AMT_05
           , HMP.UMP_IN_AMT_05
           -- 6��.
           , HMP.SUBT_IN_TAX_AMT_06
           , HMP.SUBT_LOCAL_TAX_AMT_06
           , HMP.ANNUITY_IN_AMT_06
           , HMP.HEALTH_IN_AMT_06
           , HMP.UMP_IN_AMT_06
           -- 7��.
           , HMP.SUBT_IN_TAX_AMT_07
           , HMP.SUBT_LOCAL_TAX_AMT_07
           , HMP.ANNUITY_IN_AMT_07
           , HMP.HEALTH_IN_AMT_07
           , HMP.UMP_IN_AMT_07
           -- 8��.
           , HMP.SUBT_IN_TAX_AMT_08
           , HMP.SUBT_LOCAL_TAX_AMT_08
           , HMP.ANNUITY_IN_AMT_08
           , HMP.HEALTH_IN_AMT_08
           , HMP.UMP_IN_AMT_08
           -- 9��.
           , HMP.SUBT_IN_TAX_AMT_09
           , HMP.SUBT_LOCAL_TAX_AMT_09
           , HMP.ANNUITY_IN_AMT_09
           , HMP.HEALTH_IN_AMT_09
           , HMP.UMP_IN_AMT_09
           -- 10��.
           , HMP.SUBT_IN_TAX_AMT_10
           , HMP.SUBT_LOCAL_TAX_AMT_10
           , HMP.ANNUITY_IN_AMT_10
           , HMP.HEALTH_IN_AMT_10
           , HMP.UMP_IN_AMT_10
           -- 11��.
           , HMP.SUBT_IN_TAX_AMT_11
           , HMP.SUBT_LOCAL_TAX_AMT_11
           , HMP.ANNUITY_IN_AMT_11
           , HMP.HEALTH_IN_AMT_11
           , HMP.UMP_IN_AMT_11
           -- 12��.
           , HMP.SUBT_IN_TAX_AMT_12
           , HMP.SUBT_LOCAL_TAX_AMT_12
           , HMP.ANNUITY_IN_AMT_12
           , HMP.HEALTH_IN_AMT_12
           , HMP.UMP_IN_AMT_12
           -- ��.
           , HMP.TOTAL_SUBT_IN_TAX_AMT
           , HMP.TOTAL_SUBT_LOCAL_TAX_AMT
           , HMP.TOTAL_ANNUITY_IN_AMT
           , HMP.TOTAL_HEALTH_IN_AMT
           , HMP.TOTAL_UMP_IN_AMT
           , HRM_COMMON_DATE_G.DATE_YYYYMMDD_F(TRUNC(SYSDATE)) AS PRINT_DATE
           , S_CM.CORP_NAME AS AGENT_NAME
        FROM HRM_PERSON_MASTER PM
          , ( SELECT CM.CORP_ID
                   , CM.CORP_NAME
                   , OU.VAT_NUMBER
                   , OU.CORP_ADDRESS
                FROM HRM_CORP_MASTER CM
                , ( SELECT HOU.CORP_ID
                         , HOU.VAT_NUMBER 
                         , HOU.ADDR1 || ' ' || HOU.ADDR2 AS CORP_ADDRESS
                      FROM HRM_OPERATING_UNIT HOU
                    WHERE HOU.CORP_ID         = P_CORP_ID
                      AND HOU.SOB_ID          = P_SOB_ID
                      AND HOU.ORG_ID          = P_ORG_ID
                      AND ((HOU.DEFAULT_FLAG   = 'Y')
                      OR  ROWNUM              <= 1)
                  ) OU
              WHERE CM.CORP_ID              = OU.CORP_ID
                AND CM.CORP_ID              = P_CORP_ID
                AND CM.SOB_ID               = P_SOB_ID
                AND CM.ORG_ID               = P_ORG_ID
            ) S_CM
          , ( SELECT HC.COMMON_ID AS NATION_ID
                   , HC.CODE AS NATION_CODE
                   , HC.CODE_NAME AS NATION_NAME
                   , HC.VALUE1 AS ISO_NATION_CODE
                FROM HRM_COMMON HC
              WHERE HC.GROUP_CODE     = 'NATION'
                AND HC.SOB_ID         = P_SOB_ID
                AND HC.ORG_ID         = P_ORG_ID
            ) S_HN
          , ( SELECT HF.PERSON_ID
                   , COUNT(HF.PERSON_ID) AS DED_FAMILY_COUNT  -- ������ �⺻ ����.
                   , SUM(CASE 
                           WHEN HF.BIRTHDAY IS NULL THEN 0
                           WHEN EAPP_BIRTH_AGE_F(HF.BIRTHDAY, LAST_DAY(TO_DATE(V_PAY_YYYYMM_TO, 'YYYY-MM')), 0) BETWEEN 0 AND 20 THEN 1
                           ELSE 0
                         END) AS DED_CHILD_COUNT
                FROM HRM_FAMILY HF
              WHERE HF.PERSON_ID      = NVL(P_PERSON_ID, HF.PERSON_ID)                        
                AND HF.TAX_YN         = 'Y'
              GROUP BY HF.PERSON_ID
            ) S_HF       
          , ( SELECT MP.PERSON_ID
                     , MAX(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '01', MP.PAY_YYYYMM, NULL)) AS PAY_YYYYMM_01
                     , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '01', MP.PAY_AMOUNT, 0)) AS PAY_AMOUNT_01
                     , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '01', MP.BONUS_AMOUNT, 0)) AS BONUS_AMOUNT_01
                     , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '01', MP.TOT_SUPPLY_AMOUNT, 0)) AS SUM_AMOUNT_01                 
                     ------------------------------------------------------------------------------------------------------------------------------                           
                     , MAX(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '02', MP.PAY_YYYYMM, NULL)) AS PAY_YYYYMM_02
                     , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '02', MP.PAY_AMOUNT, 0)) AS PAY_AMOUNT_02
                     , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '02', MP.BONUS_AMOUNT, 0)) AS BONUS_AMOUNT_02
                     , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '02', MP.TOT_SUPPLY_AMOUNT, 0)) AS SUM_AMOUNT_02
                     ------------------------------------------------------------------------------------------------------------------------------
                     , MAX(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '03', MP.PAY_YYYYMM, NULL)) AS PAY_YYYYMM_03
                     , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '03', MP.PAY_AMOUNT, 0)) AS PAY_AMOUNT_03
                     , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '03', MP.BONUS_AMOUNT, 0)) AS BONUS_AMOUNT_03
                     , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '03', MP.TOT_SUPPLY_AMOUNT, 0)) AS SUM_AMOUNT_03
                     ------------------------------------------------------------------------------------------------------------------------------
                     , MAX(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '04', MP.PAY_YYYYMM, NULL)) AS PAY_YYYYMM_04
                     , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '04', MP.PAY_AMOUNT, 0)) AS PAY_AMOUNT_04
                     , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '04', MP.BONUS_AMOUNT, 0)) AS BONUS_AMOUNT_04
                     , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '04', MP.TOT_SUPPLY_AMOUNT, 0)) AS SUM_AMOUNT_04
                     ------------------------------------------------------------------------------------------------------------------------------
                     , MAX(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '05', MP.PAY_YYYYMM, NULL)) AS PAY_YYYYMM_05
                     , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '05', MP.PAY_AMOUNT, 0)) AS PAY_AMOUNT_05
                     , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '05', MP.BONUS_AMOUNT, 0)) AS BONUS_AMOUNT_05
                     , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '05', MP.TOT_SUPPLY_AMOUNT, 0)) AS SUM_AMOUNT_05
                     ------------------------------------------------------------------------------------------------------------------------------
                     , MAX(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '06', MP.PAY_YYYYMM, NULL)) AS PAY_YYYYMM_06
                     , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '06', MP.PAY_AMOUNT, 0)) AS PAY_AMOUNT_06
                     , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '06', MP.BONUS_AMOUNT, 0)) AS BONUS_AMOUNT_06
                     , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '06', MP.TOT_SUPPLY_AMOUNT, 0)) AS SUM_AMOUNT_06
                     ------------------------------------------------------------------------------------------------------------------------------
                     , MAX(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '07', MP.PAY_YYYYMM, NULL)) AS PAY_YYYYMM_07
                     , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '07', MP.PAY_AMOUNT, 0)) AS PAY_AMOUNT_07
                     , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '07', MP.BONUS_AMOUNT, 0)) AS BONUS_AMOUNT_07
                     , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '07', MP.TOT_SUPPLY_AMOUNT, 0)) AS SUM_AMOUNT_07
                     ------------------------------------------------------------------------------------------------------------------------------
                     , MAX(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '08', MP.PAY_YYYYMM, NULL)) AS PAY_YYYYMM_08
                     , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '08', MP.PAY_AMOUNT, 0)) AS PAY_AMOUNT_08
                     , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '08', MP.BONUS_AMOUNT, 0)) AS BONUS_AMOUNT_08
                     , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '08', MP.TOT_SUPPLY_AMOUNT, 0)) AS SUM_AMOUNT_08
                     ------------------------------------------------------------------------------------------------------------------------------      
                     , MAX(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '09', MP.PAY_YYYYMM, NULL)) AS PAY_YYYYMM_09
                     , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '09', MP.PAY_AMOUNT, 0)) AS PAY_AMOUNT_09
                     , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '09', MP.BONUS_AMOUNT, 0)) AS BONUS_AMOUNT_09
                     , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '09', MP.TOT_SUPPLY_AMOUNT, 0)) AS SUM_AMOUNT_09
                     ------------------------------------------------------------------------------------------------------------------------------
                     , MAX(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '10', MP.PAY_YYYYMM, NULL)) AS PAY_YYYYMM_10
                     , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '10', MP.PAY_AMOUNT, 0)) AS PAY_AMOUNT_10
                     , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '10', MP.BONUS_AMOUNT, 0)) AS BONUS_AMOUNT_10
                     , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '10', MP.TOT_SUPPLY_AMOUNT, 0)) AS SUM_AMOUNT_10
                     ------------------------------------------------------------------------------------------------------------------------------
                     , MAX(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '11', MP.PAY_YYYYMM, NULL)) AS PAY_YYYYMM_11
                     , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '11', MP.PAY_AMOUNT, 0)) AS PAY_AMOUNT_11
                     , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '11', MP.BONUS_AMOUNT, 0)) AS BONUS_AMOUNT_11
                     , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '11', MP.TOT_SUPPLY_AMOUNT, 0)) AS SUM_AMOUNT_11
                     ------------------------------------------------------------------------------------------------------------------------------
                     , MAX(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '12', MP.PAY_YYYYMM, NULL)) AS PAY_YYYYMM_12
                     , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '12', MP.PAY_AMOUNT, 0)) AS PAY_AMOUNT_12
                     , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '12', MP.BONUS_AMOUNT, 0)) AS BONUS_AMOUNT_12
                     , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '12', MP.TOT_SUPPLY_AMOUNT, 0)) AS SUM_AMOUNT_12
                     ------------------------------------------------------------------------------------------------------------------------------      
                     , SUM(MP.PAY_AMOUNT) AS TOTAL_PAY_AMOUNT
                     , SUM(MP.BONUS_AMOUNT) AS TOTAL_BONUS_AMOUNT
                     , SUM(MP.TOT_SUPPLY_AMOUNT) AS TOTAL_SUM_AMOUNT
                     -- ����� �ҵ�.
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '01', CASE
                                                                       WHEN MP.PAY_TYPE IN('2', '4') AND MP.TOT_SUPPLY_AMOUNT <= 1000000 THEN MA.TAX_FREE_OT
                                                                       ELSE 0
                                                                    END, 0)) AS TAX_FREE_OT_01
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '01', MA.TAX_FREE_OUTSIDE, 0)) AS TAX_FREE_OUTSIDE_01
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '01', MA.TAX_FREE_BABY, 0)) AS TAX_FREE_BABY_01
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '01', MA.TAX_FREE_CAR, 0)) AS TAX_FREE_CAR_01
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '01', 0, 0)) AS TAX_FREE_ETC_01
                    --------------------------------------------------------------------------------------------------------------------------- 2 ��.
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '02', CASE
                                                                       WHEN MP.PAY_TYPE IN('2', '4') AND MP.TOT_SUPPLY_AMOUNT <= 1000000 THEN MA.TAX_FREE_OT
                                                                       ELSE 0
                                                                    END, 0)) AS TAX_FREE_OT_02
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '02', MA.TAX_FREE_OUTSIDE, 0)) AS TAX_FREE_OUTSIDE_02
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '02', MA.TAX_FREE_BABY, 0)) AS TAX_FREE_BABY_02
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '02', MA.TAX_FREE_CAR, 0)) AS TAX_FREE_CAR_02
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '02', 0, 0)) AS TAX_FREE_ETC_02
                    --------------------------------------------------------------------------------------------------------------------------- 3 ��.
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '03', CASE
                                                                       WHEN MP.PAY_TYPE IN('2', '4') AND MP.TOT_SUPPLY_AMOUNT <= 1000000 THEN MA.TAX_FREE_OT
                                                                       ELSE 0
                                                                    END, 0)) AS TAX_FREE_OT_03
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '03', MA.TAX_FREE_OUTSIDE, 0)) AS TAX_FREE_OUTSIDE_03
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '03', MA.TAX_FREE_BABY, 0)) AS TAX_FREE_BABY_03
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '03', MA.TAX_FREE_CAR, 0)) AS TAX_FREE_CAR_03
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '03', 0, 0)) AS TAX_FREE_ETC_03
                    --------------------------------------------------------------------------------------------------------------------------- 4 ��.
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '04', CASE
                                                                       WHEN MP.PAY_TYPE IN('2', '4') AND MP.TOT_SUPPLY_AMOUNT <= 1000000 THEN MA.TAX_FREE_OT
                                                                       ELSE 0
                                                                    END, 0)) AS TAX_FREE_OT_04
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '04', MA.TAX_FREE_OUTSIDE, 0)) AS TAX_FREE_OUTSIDE_04
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '04', MA.TAX_FREE_BABY, 0)) AS TAX_FREE_BABY_04
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '04', MA.TAX_FREE_CAR, 0)) AS TAX_FREE_CAR_04
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '04', 0, 0)) AS TAX_FREE_ETC_04
                    --------------------------------------------------------------------------------------------------------------------------- 5 ��.
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '05', CASE
                                                                       WHEN MP.PAY_TYPE IN('2', '4') AND MP.TOT_SUPPLY_AMOUNT <= 1000000 THEN MA.TAX_FREE_OT
                                                                       ELSE 0
                                                                    END, 0)) AS TAX_FREE_OT_05
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '05', MA.TAX_FREE_OUTSIDE, 0)) AS TAX_FREE_OUTSIDE_05
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '05', MA.TAX_FREE_BABY, 0)) AS TAX_FREE_BABY_05
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '05', MA.TAX_FREE_CAR, 0)) AS TAX_FREE_CAR_05
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '05', 0, 0)) AS TAX_FREE_ETC_05
                    --------------------------------------------------------------------------------------------------------------------------- 6 ��.
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '06', CASE
                                                                       WHEN MP.PAY_TYPE IN('2', '4') AND MP.TOT_SUPPLY_AMOUNT <= 1000000 THEN MA.TAX_FREE_OT
                                                                       ELSE 0
                                                                    END, 0)) AS TAX_FREE_OT_06
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '06', MA.TAX_FREE_OUTSIDE, 0)) AS TAX_FREE_OUTSIDE_06
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '06', MA.TAX_FREE_BABY, 0)) AS TAX_FREE_BABY_06
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '06', MA.TAX_FREE_CAR, 0)) AS TAX_FREE_CAR_06
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '06', 0, 0)) AS TAX_FREE_ETC_06
                    --------------------------------------------------------------------------------------------------------------------------- 7 ��.
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '07', CASE
                                                                       WHEN MP.PAY_TYPE IN('2', '4') AND MP.TOT_SUPPLY_AMOUNT <= 1000000 THEN MA.TAX_FREE_OT
                                                                       ELSE 0
                                                                    END, 0)) AS TAX_FREE_OT_07
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '07', MA.TAX_FREE_OUTSIDE, 0)) AS TAX_FREE_OUTSIDE_07
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '07', MA.TAX_FREE_BABY, 0)) AS TAX_FREE_BABY_07
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '07', MA.TAX_FREE_CAR, 0)) AS TAX_FREE_CAR_07
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '07', 0, 0)) AS TAX_FREE_ETC_07
                    --------------------------------------------------------------------------------------------------------------------------- 8 ��.
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '08', CASE
                                                                       WHEN MP.PAY_TYPE IN('2', '4') AND MP.TOT_SUPPLY_AMOUNT <= 1000000 THEN MA.TAX_FREE_OT
                                                                       ELSE 0
                                                                    END, 0)) AS TAX_FREE_OT_08
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '08', MA.TAX_FREE_OUTSIDE, 0)) AS TAX_FREE_OUTSIDE_08
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '08', MA.TAX_FREE_BABY, 0)) AS TAX_FREE_BABY_08
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '08', MA.TAX_FREE_CAR, 0)) AS TAX_FREE_CAR_08
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '08', 0, 0)) AS TAX_FREE_ETC_08
                    --------------------------------------------------------------------------------------------------------------------------- 9 ��.
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '09', CASE
                                                                       WHEN MP.PAY_TYPE IN('2', '4') AND MP.TOT_SUPPLY_AMOUNT <= 1000000 THEN MA.TAX_FREE_OT
                                                                       ELSE 0
                                                                    END, 0)) AS TAX_FREE_OT_09
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '09', MA.TAX_FREE_OUTSIDE, 0)) AS TAX_FREE_OUTSIDE_09
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '09', MA.TAX_FREE_BABY, 0)) AS TAX_FREE_BABY_09
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '09', MA.TAX_FREE_CAR, 0)) AS TAX_FREE_CAR_09
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '09', 0, 0)) AS TAX_FREE_ETC_09
                    --------------------------------------------------------------------------------------------------------------------------- 10 ��.
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '10', CASE
                                                                       WHEN MP.PAY_TYPE IN('2', '4') AND MP.TOT_SUPPLY_AMOUNT <= 1000000 THEN MA.TAX_FREE_OT
                                                                       ELSE 0
                                                                    END, 0)) AS TAX_FREE_OT_10
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '10', MA.TAX_FREE_OUTSIDE, 0)) AS TAX_FREE_OUTSIDE_10
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '10', MA.TAX_FREE_BABY, 0)) AS TAX_FREE_BABY_10
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '10', MA.TAX_FREE_CAR, 0)) AS TAX_FREE_CAR_10
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '10', 0, 0)) AS TAX_FREE_ETC_10
                    --------------------------------------------------------------------------------------------------------------------------- 11 ��.
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '11', CASE
                                                                       WHEN MP.PAY_TYPE IN('2', '4') AND MP.TOT_SUPPLY_AMOUNT <= 1000000 THEN MA.TAX_FREE_OT
                                                                       ELSE 0
                                                                    END, 0)) AS TAX_FREE_OT_11
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '11', MA.TAX_FREE_OUTSIDE, 0)) AS TAX_FREE_OUTSIDE_11
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '11', MA.TAX_FREE_BABY, 0)) AS TAX_FREE_BABY_11
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '11', MA.TAX_FREE_CAR, 0)) AS TAX_FREE_CAR_11
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '11', 0, 0)) AS TAX_FREE_ETC_11
                    --------------------------------------------------------------------------------------------------------------------------- 12 ��.
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '12', CASE
                                                                       WHEN MP.PAY_TYPE IN('2', '4') AND MP.TOT_SUPPLY_AMOUNT <= 1000000 THEN MA.TAX_FREE_OT
                                                                       ELSE 0
                                                                    END, 0)) AS TAX_FREE_OT_12
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '12', MA.TAX_FREE_OUTSIDE, 0)) AS TAX_FREE_OUTSIDE_12
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '12', MA.TAX_FREE_BABY, 0)) AS TAX_FREE_BABY_12
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '12', MA.TAX_FREE_CAR, 0)) AS TAX_FREE_CAR_12
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '12', 0, 0)) AS TAX_FREE_ETC_12
                    -- �ٷμҵ��õ¡����.
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '01', MD.D01, 0)) AS SUBT_IN_TAX_AMT_01                                -- �ҵ漼.
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '01', MD.D02, 0)) AS SUBT_LOCAL_TAX_AMT_01                             -- �ֹμ�.
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '01', MD.D03, 0)) AS ANNUITY_IN_AMT_01                                 -- ���ݺ���.
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '01', MD.D05, 0)) AS HEALTH_IN_AMT_01                                  -- �ǰ�����.
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '01', MD.D04, 0)) AS UMP_IN_AMT_01                                     -- ��뺸��.
                    --------------------------------------------------------------------------------------------------------------------------- 2 ��.
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '02', MD.D01, 0)) AS SUBT_IN_TAX_AMT_02                                -- �ҵ漼.
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '02', MD.D02, 0)) AS SUBT_LOCAL_TAX_AMT_02                             -- �ֹμ�.
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '02', MD.D03, 0)) AS ANNUITY_IN_AMT_02                                 -- ���ݺ���.
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '02', MD.D05, 0)) AS HEALTH_IN_AMT_02                                  -- �ǰ�����.
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '02', MD.D04, 0)) AS UMP_IN_AMT_02                                     -- ��뺸��.
                    --------------------------------------------------------------------------------------------------------------------------- 3 ��.
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '03', MD.D01, 0)) AS SUBT_IN_TAX_AMT_03                                -- �ҵ漼.
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '03', MD.D02, 0)) AS SUBT_LOCAL_TAX_AMT_03                             -- �ֹμ�.
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '03', MD.D03, 0)) AS ANNUITY_IN_AMT_03                                 -- ���ݺ���.
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '03', MD.D05, 0)) AS HEALTH_IN_AMT_03                                  -- �ǰ�����.
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '03', MD.D04, 0)) AS UMP_IN_AMT_03                                     -- ��뺸��.   
                    --------------------------------------------------------------------------------------------------------------------------- 4 ��.
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '04', MD.D01, 0)) AS SUBT_IN_TAX_AMT_04                                -- �ҵ漼.
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '04', MD.D02, 0)) AS SUBT_LOCAL_TAX_AMT_04                             -- �ֹμ�.
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '04', MD.D03, 0)) AS ANNUITY_IN_AMT_04                                 -- ���ݺ���.
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '04', MD.D05, 0)) AS HEALTH_IN_AMT_04                                  -- �ǰ�����.
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '04', MD.D04, 0)) AS UMP_IN_AMT_04                                     -- ��뺸��. 
                    --------------------------------------------------------------------------------------------------------------------------- 5 ��.
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '05', MD.D01, 0)) AS SUBT_IN_TAX_AMT_05                                -- �ҵ漼.
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '05', MD.D02, 0)) AS SUBT_LOCAL_TAX_AMT_05                             -- �ֹμ�.
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '05', MD.D03, 0)) AS ANNUITY_IN_AMT_05                                 -- ���ݺ���.
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '05', MD.D05, 0)) AS HEALTH_IN_AMT_05                                  -- �ǰ�����.
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '05', MD.D04, 0)) AS UMP_IN_AMT_05                                     -- ��뺸��.
                    --------------------------------------------------------------------------------------------------------------------------- 6 ��.
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '06', MD.D01, 0)) AS SUBT_IN_TAX_AMT_06                                -- �ҵ漼.
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '06', MD.D02, 0)) AS SUBT_LOCAL_TAX_AMT_06                             -- �ֹμ�.
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '06', MD.D03, 0)) AS ANNUITY_IN_AMT_06                                 -- ���ݺ���.
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '06', MD.D05, 0)) AS HEALTH_IN_AMT_06                                  -- �ǰ�����.
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '06', MD.D04, 0)) AS UMP_IN_AMT_06                                     -- ��뺸��.
                    --------------------------------------------------------------------------------------------------------------------------- 7 ��.
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '07', MD.D01, 0)) AS SUBT_IN_TAX_AMT_07                                -- �ҵ漼.
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '07', MD.D02, 0)) AS SUBT_LOCAL_TAX_AMT_07                             -- �ֹμ�.
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '07', MD.D03, 0)) AS ANNUITY_IN_AMT_07                                 -- ���ݺ���.
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '07', MD.D05, 0)) AS HEALTH_IN_AMT_07                                  -- �ǰ�����.
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '07', MD.D04, 0)) AS UMP_IN_AMT_07                                     -- ��뺸��.
                    --------------------------------------------------------------------------------------------------------------------------- 8 ��.
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '08', MD.D01, 0)) AS SUBT_IN_TAX_AMT_08                                -- �ҵ漼.
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '08', MD.D02, 0)) AS SUBT_LOCAL_TAX_AMT_08                             -- �ֹμ�.
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '08', MD.D03, 0)) AS ANNUITY_IN_AMT_08                                 -- ���ݺ���.
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '08', MD.D05, 0)) AS HEALTH_IN_AMT_08                                  -- �ǰ�����.
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '08', MD.D04, 0)) AS UMP_IN_AMT_08                                     -- ��뺸��.
                    --------------------------------------------------------------------------------------------------------------------------- 9 ��.
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '09', MD.D01, 0)) AS SUBT_IN_TAX_AMT_09                                -- �ҵ漼.
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '09', MD.D02, 0)) AS SUBT_LOCAL_TAX_AMT_09                             -- �ֹμ�.
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '09', MD.D03, 0)) AS ANNUITY_IN_AMT_09                                 -- ���ݺ���.
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '09', MD.D05, 0)) AS HEALTH_IN_AMT_09                                  -- �ǰ�����.
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '09', MD.D04, 0)) AS UMP_IN_AMT_09                                     -- ��뺸��.
                    --------------------------------------------------------------------------------------------------------------------------- 10 ��.
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '10', MD.D01, 0)) AS SUBT_IN_TAX_AMT_10                                -- �ҵ漼.
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '10', MD.D02, 0)) AS SUBT_LOCAL_TAX_AMT_10                             -- �ֹμ�.
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '10', MD.D03, 0)) AS ANNUITY_IN_AMT_10                                 -- ���ݺ���.
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '10', MD.D05, 0)) AS HEALTH_IN_AMT_10                                  -- �ǰ�����.
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '10', MD.D04, 0)) AS UMP_IN_AMT_10                                     -- ��뺸��.
                    --------------------------------------------------------------------------------------------------------------------------- 11 ��.
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '11', MD.D01, 0)) AS SUBT_IN_TAX_AMT_11                                -- �ҵ漼.
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '11', MD.D02, 0)) AS SUBT_LOCAL_TAX_AMT_11                             -- �ֹμ�.
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '11', MD.D03, 0)) AS ANNUITY_IN_AMT_11                                 -- ���ݺ���.
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '11', MD.D05, 0)) AS HEALTH_IN_AMT_11                                  -- �ǰ�����.
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '11', MD.D04, 0)) AS UMP_IN_AMT_11                                     -- ��뺸��.
                    --------------------------------------------------------------------------------------------------------------------------- 12 ��.
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '12', MD.D01, 0)) AS SUBT_IN_TAX_AMT_12                                -- �ҵ漼.
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '12', MD.D02, 0)) AS SUBT_LOCAL_TAX_AMT_12                             -- �ֹμ�.
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '12', MD.D03, 0)) AS ANNUITY_IN_AMT_12                                 -- ���ݺ���.
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '12', MD.D05, 0)) AS HEALTH_IN_AMT_12                                  -- �ǰ�����.
                    , SUM(DECODE(SUBSTR(MP.PAY_YYYYMM, 6, 2), '12', MD.D04, 0)) AS UMP_IN_AMT_12                                     -- ��뺸��.
                    ---------------------------------------------------------------------------------------------------------------------------
                    , SUM(MD.D01) AS TOTAL_SUBT_IN_TAX_AMT                                                                             -- �ҵ漼 ��.
                    , SUM(MD.D02) AS TOTAL_SUBT_LOCAL_TAX_AMT                                                                          -- �ֹμ� ��.
                    , SUM(MD.D03) AS TOTAL_ANNUITY_IN_AMT                                                                              -- ���ݺ��� ��.
                    , SUM(MD.D05) AS TOTAL_HEALTH_IN_AMT                                                                               -- �ǰ����� ��.
                    , SUM(MD.D04) AS TOTAL_UMP_IN_AMT                                                                                  -- ��뺸�� ��.
                  FROM HRP_MONTH_PAYMENT MP
                    , HRP_MONTH_ALLOWANCE_V MA
                    , HRP_MONTH_DEDUCTION_V MD
                WHERE MP.MONTH_PAYMENT_ID       = MA.MONTH_PAYMENT_ID(+)
                  AND MP.MONTH_PAYMENT_ID       = MD.MONTH_PAYMENT_ID(+)
                  AND MP.PAY_YYYYMM             BETWEEN V_PAY_YYYYMM_FR AND V_PAY_YYYYMM_TO
                  AND MP.CORP_ID                = P_CORP_ID
                  AND MP.PERSON_ID              = NVL(P_PERSON_ID, MP.PERSON_ID)
                  AND MP.SOB_ID                 = P_SOB_ID
                  AND MP.ORG_ID                 = P_ORG_ID
                GROUP BY MP.PERSON_ID
               ) HMP
       WHERE PM.CORP_ID               = S_CM.CORP_ID
         AND PM.NATION_ID             = S_HN.NATION_ID(+)
         AND PM.PERSON_ID             = S_HF.PERSON_ID(+)
         AND PM.PERSON_ID             = HMP.PERSON_ID(+)
         AND PM.PERSON_ID             = NVL(P_PERSON_ID, PM.PERSON_ID)
         AND PM.CORP_ID               = P_CORP_ID
         AND PM.SOB_ID                = P_SOB_ID
         AND PM.ORG_ID                = P_ORG_ID
        ; 
  END PRINT_IN_EARNER_DED_TAX;
  
END HRA_CERTIFICATE_G;
/
