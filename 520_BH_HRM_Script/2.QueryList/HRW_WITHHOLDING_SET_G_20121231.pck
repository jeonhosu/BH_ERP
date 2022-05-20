CREATE OR REPLACE PACKAGE HRW_WITHHOLDING_SET_G
AS

-- ��õ¡�������Ȳ�Ű� �ۼ� ����.
  PROCEDURE MAIN_WITHHOLDING
            ( P_WITHHOLDING_DOC_ID    IN HRW_WITHHOLDING_DOC.WITHHOLDING_DOC_ID%TYPE
            , P_SET_TYPE              IN VARCHAR2
            , P_SOB_ID                IN HRW_WITHHOLDING_DOC.SOB_ID%TYPE
            , P_ORG_ID                IN HRW_WITHHOLDING_DOC.ORG_ID%TYPE
            , P_USER_ID               IN NUMBER
            , O_STATUS                OUT VARCHAR2
            , O_MESSAGE               OUT VARCHAR2
            );

-- ���̼��� ���.
  PROCEDURE SET_A01
            ( P_WITHHOLDING_DOC_ID    IN HRW_WITHHOLDING_DOC.WITHHOLDING_DOC_ID%TYPE
            , P_CORP_ID               IN HRW_WITHHOLDING_DOC.CORP_ID%TYPE
            , P_STD_YYYYMM            IN HRW_WITHHOLDING_DOC.STD_YYYYMM%TYPE
            , P_PAY_YYYYMM            IN HRW_WITHHOLDING_DOC.PAY_YYYYMM%TYPE
            , P_SOB_ID                IN HRW_WITHHOLDING_DOC.SOB_ID%TYPE
            , P_ORG_ID                IN HRW_WITHHOLDING_DOC.ORG_ID%TYPE
            , P_USER_ID               IN NUMBER
            , O_STATUS                OUT VARCHAR2
            , O_MESSAGE               OUT VARCHAR2
            );

-- �ߵ���� ���.
  PROCEDURE SET_A02
            ( P_WITHHOLDING_DOC_ID    IN HRW_WITHHOLDING_DOC.WITHHOLDING_DOC_ID%TYPE
            , P_CORP_ID               IN HRW_WITHHOLDING_DOC.CORP_ID%TYPE
            , P_STD_YYYYMM            IN HRW_WITHHOLDING_DOC.STD_YYYYMM%TYPE
            , P_PAY_YYYYMM            IN HRW_WITHHOLDING_DOC.PAY_YYYYMM%TYPE
            , P_SOB_ID                IN HRW_WITHHOLDING_DOC.SOB_ID%TYPE
            , P_ORG_ID                IN HRW_WITHHOLDING_DOC.ORG_ID%TYPE
            , P_USER_ID               IN NUMBER
            , O_STATUS                OUT VARCHAR2
            , O_MESSAGE               OUT VARCHAR2
            );

-- �������� ���.
  PROCEDURE SET_A04
            ( P_WITHHOLDING_DOC_ID    IN HRW_WITHHOLDING_DOC.WITHHOLDING_DOC_ID%TYPE
            , P_CORP_ID               IN HRW_WITHHOLDING_DOC.CORP_ID%TYPE
            , P_STD_YYYYMM            IN HRW_WITHHOLDING_DOC.STD_YYYYMM%TYPE
            , P_PAY_YYYYMM            IN HRW_WITHHOLDING_DOC.PAY_YYYYMM%TYPE
            , P_SOB_ID                IN HRW_WITHHOLDING_DOC.SOB_ID%TYPE
            , P_ORG_ID                IN HRW_WITHHOLDING_DOC.ORG_ID%TYPE
            , P_USER_ID               IN NUMBER
            , O_STATUS                OUT VARCHAR2
            , O_MESSAGE               OUT VARCHAR2
            );

-- �����ҵ� ���.
  PROCEDURE SET_A20
            ( P_WITHHOLDING_DOC_ID    IN HRW_WITHHOLDING_DOC.WITHHOLDING_DOC_ID%TYPE
            , P_CORP_ID               IN HRW_WITHHOLDING_DOC.CORP_ID%TYPE
            , P_STD_YYYYMM            IN HRW_WITHHOLDING_DOC.STD_YYYYMM%TYPE
            , P_PAY_YYYYMM            IN HRW_WITHHOLDING_DOC.PAY_YYYYMM%TYPE
            , P_SOB_ID                IN HRW_WITHHOLDING_DOC.SOB_ID%TYPE
            , P_ORG_ID                IN HRW_WITHHOLDING_DOC.ORG_ID%TYPE
            , P_USER_ID               IN NUMBER
            , O_STATUS                OUT VARCHAR2
            , O_MESSAGE               OUT VARCHAR2
            );

-- ����ҵ� ���.
  PROCEDURE SET_A25
            ( P_WITHHOLDING_DOC_ID    IN HRW_WITHHOLDING_DOC.WITHHOLDING_DOC_ID%TYPE
            , P_CORP_ID               IN HRW_WITHHOLDING_DOC.CORP_ID%TYPE
            , P_STD_YYYYMM            IN HRW_WITHHOLDING_DOC.STD_YYYYMM%TYPE
            , P_PAY_YYYYMM            IN HRW_WITHHOLDING_DOC.PAY_YYYYMM%TYPE
            , P_SOB_ID                IN HRW_WITHHOLDING_DOC.SOB_ID%TYPE
            , P_ORG_ID                IN HRW_WITHHOLDING_DOC.ORG_ID%TYPE
            , P_USER_ID               IN NUMBER
            , O_STATUS                OUT VARCHAR2
            , O_MESSAGE               OUT VARCHAR2
            );

-- ��õ¡�� ���� ����.
  FUNCTION CLOSED_WITHHOLDING_YN
            ( P_WITHHOLDING_DOC_ID    IN HRW_WITHHOLDING_DOC.WITHHOLDING_DOC_ID%TYPE
            ) RETURN VARCHAR2;

-- ��õ¡�� ������ ����.
  PROCEDURE CLOSED_WITHHOLDING
            ( P_WITHHOLDING_DOC_ID    IN HRW_WITHHOLDING_DOC.WITHHOLDING_DOC_ID%TYPE
            , P_CONNECT_PERSON_ID     IN NUMBER
            , P_SOB_ID                IN NUMBER
            , P_ORG_ID                IN NUMBER            
            );
            
-- ��õ¡�� ������ ���� ���.
  PROCEDURE CLOSED_CANCEL_WITHHOLDING
            ( P_WITHHOLDING_DOC_ID    IN HRW_WITHHOLDING_DOC.WITHHOLDING_DOC_ID%TYPE
            , P_CONNECT_PERSON_ID     IN NUMBER
            , P_SOB_ID                IN NUMBER
            , P_ORG_ID                IN NUMBER            
            );
            
END HRW_WITHHOLDING_SET_G;
/
CREATE OR REPLACE PACKAGE BODY HRW_WITHHOLDING_SET_G
AS
/******************************************************************************/
/* PROJECT      : FPCB ERP
/* MODULE       : EAPP
/* PROGRAM NAME : HRW_WITHHOLDING_SET_G
/* DESCRIPTION  : ��õ¡�������Ȳ�Ű� ���� �� ���� ����
/* REFERENCE BY :
/* PROGRAM HISTORY :
/*------------------------------------------------------------------------------
/*   DATE       IN CHARGE          DESCRIPTION
/*------------------------------------------------------------------------------
/* 20-JUN-2010  JEON HO SU          INITIALIZE
/******************************************************************************/
-- ��õ¡�������Ȳ�Ű� �ۼ� ����.
-- ��õ¡�������Ȳ�Ű� �ۼ� ����.
  PROCEDURE MAIN_WITHHOLDING
            ( P_WITHHOLDING_DOC_ID    IN HRW_WITHHOLDING_DOC.WITHHOLDING_DOC_ID%TYPE
            , P_SET_TYPE              IN VARCHAR2
            , P_SOB_ID                IN HRW_WITHHOLDING_DOC.SOB_ID%TYPE
            , P_ORG_ID                IN HRW_WITHHOLDING_DOC.ORG_ID%TYPE
            , P_USER_ID               IN NUMBER
            , O_STATUS                OUT VARCHAR2
            , O_MESSAGE               OUT VARCHAR2
            )
  AS
    V_SYSDATE                 DATE := GET_LOCAL_DATE(P_SOB_ID);
    V_CORP_ID                 NUMBER;
    V_STD_YYYYMM              VARCHAR2(8);
    V_PAY_YYYYMM              VARCHAR2(8);
    
    V_RECEIVE_REFUND_TAX_AMT  NUMBER := 0;  
  BEGIN
    O_STATUS := 'F';
    -- ���� ���� üũ.
    IF CLOSED_WITHHOLDING_YN(P_WITHHOLDING_DOC_ID) = 'Y' THEN
      -- �̹� ����ó����.
      O_MESSAGE := EAPP_MESSAGE_G.RETURN_MSG_F('FCM_10052');
      RETURN;
    END IF;
    
    BEGIN
      SELECT WD.CORP_ID
          , WD.STD_YYYYMM
          , WD.PAY_YYYYMM
        INTO V_CORP_ID
          , V_STD_YYYYMM
          , V_PAY_YYYYMM
        FROM HRW_WITHHOLDING_DOC WD
      WHERE WD.WITHHOLDING_DOC_ID     = P_WITHHOLDING_DOC_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      O_MESSAGE := EAPP_MESSAGE_G.RETURN_MSG_F('FCM_10239');
      RETURN;
    END;
    
    -- ������ȯ�� ���� ����.
    BEGIN
      SELECT NVL(WD.NEXT_REFUND_TAX_AMT, 0) AS NEXT_REFUND_TAX_AMT
        INTO V_RECEIVE_REFUND_TAX_AMT
        FROM HRW_WITHHOLDING_DOC WD
      WHERE EXISTS
              ( SELECT 'X'
                  FROM HRW_WITHHOLDING_DOC HWD
                WHERE HWD.PRE_WITHHOLDING_NO  = WD.WITHHOLDING_NO
                  AND HWD.CORP_ID             = WD.CORP_ID
                  AND HWD.SOB_ID              = WD.SOB_ID
                  AND HWD.ORG_ID              = WD.ORG_ID
                  AND HWD.WITHHOLDING_DOC_ID  = P_WITHHOLDING_DOC_ID
              )
      ;
    EXCEPTION WHEN OTHERS THEN
      V_RECEIVE_REFUND_TAX_AMT := 0;
    END;
    
    -- ���� ������ �ʱ�ȭ.
    UPDATE HRW_WITHHOLDING_DOC
      SET A01_PERSON_CNT             = 0
        , A01_PAYMENT_AMT            = 0
        , A01_INCOME_TAX_AMT         = 0
        , A01_SP_TAX_AMT             = 0
        , A01_ADD_TAX_AMT            = 0
        , A02_PERSON_CNT             = 0
        , A02_PAYMENT_AMT            = 0
        , A02_INCOME_TAX_AMT         = 0
        , A02_SP_TAX_AMT             = 0
        , A02_ADD_TAX_AMT            = 0
        , A03_PERSON_CNT             = 0
        , A03_PAYMENT_AMT            = 0
        , A03_INCOME_TAX_AMT         = 0
        , A03_ADD_TAX_AMT            = 0
        , A04_PERSON_CNT             = 0
        , A04_PAYMENT_AMT            = 0
        , A04_INCOME_TAX_AMT         = 0
        , A04_SP_TAX_AMT             = 0
        , A04_ADD_TAX_AMT            = 0
        , A10_PERSON_CNT             = 0
        , A10_PAYMENT_AMT            = 0
        , A10_INCOME_TAX_AMT         = 0
        , A10_SP_TAX_AMT             = 0
        , A10_ADD_TAX_AMT            = 0
        , A10_THIS_REFUND_TAX_AMT    = 0
        , A10_PAY_INCOME_TAX_AMT     = 0
        , A10_PAY_SP_TAX_AMT         = 0
        , A20_PERSON_CNT             = 0
        , A20_PAYMENT_AMT            = 0
        , A20_INCOME_TAX_AMT         = 0
        , A20_ADD_TAX_AMT            = 0
        , A20_THIS_REFUND_TAX_AMT    = 0
        , A20_PAY_INCOME_TAX_AMT     = 0
        , A25_PERSON_CNT             = 0
        , A25_PAYMENT_AMT            = 0
        , A25_INCOME_TAX_AMT         = 0
        , A25_ADD_TAX_AMT            = 0
        , A26_PERSON_CNT             = 0
        , A26_PAYMENT_AMT            = 0
        , A26_INCOME_TAX_AMT         = 0
        , A26_SP_TAX_AMT             = 0
        , A26_ADD_TAX_AMT            = 0
        , A30_PERSON_CNT             = 0
        , A30_PAYMENT_AMT            = 0
        , A30_INCOME_TAX_AMT         = 0
        , A30_SP_TAX_AMT             = 0
        , A30_ADD_TAX_AMT            = 0
        , A30_THIS_REFUND_TAX_AMT    = 0
        , A30_PAY_INCOME_TAX_AMT     = 0
        , A30_PAY_SP_TAX_AMT         = 0
        , A40_PERSON_CNT             = 0
        , A40_PAYMENT_AMT            = 0
        , A40_INCOME_TAX_AMT         = 0
        , A40_ADD_TAX_AMT            = 0
        , A40_THIS_REFUND_TAX_AMT    = 0
        , A40_PAY_INCOME_TAX_AMT     = 0
        , A45_PERSON_CNT             = 0
        , A45_PAYMENT_AMT            = 0
        , A45_INCOME_TAX_AMT         = 0
        , A45_ADD_TAX_AMT            = 0
        , A46_PERSON_CNT             = 0
        , A46_PAYMENT_AMT            = 0
        , A46_INCOME_TAX_AMT         = 0
        , A46_ADD_TAX_AMT            = 0
        , A47_PERSON_CNT             = 0
        , A47_PAYMENT_AMT            = 0
        , A47_INCOME_TAX_AMT         = 0
        , A47_ADD_TAX_AMT            = 0
        , A47_THIS_REFUND_TAX_AMT    = 0
        , A47_PAY_INCOME_TAX_AMT     = 0
        , A50_PERSON_CNT             = 0
        , A50_PAYMENT_AMT            = 0
        , A50_INCOME_TAX_AMT         = 0
        , A50_SP_TAX_AMT             = 0
        , A50_ADD_TAX_AMT            = 0
        , A50_THIS_REFUND_TAX_AMT    = 0
        , A50_PAY_INCOME_TAX_AMT     = 0
        , A50_PAY_SP_TAX_AMT         = 0
        , A60_PERSON_CNT             = 0
        , A60_PAYMENT_AMT            = 0
        , A60_INCOME_TAX_AMT         = 0
        , A60_SP_TAX_AMT             = 0
        , A60_ADD_TAX_AMT            = 0
        , A60_THIS_REFUND_TAX_AMT    = 0
        , A60_PAY_INCOME_TAX_AMT     = 0
        , A60_PAY_SP_TAX_AMT         = 0
        , A69_PERSON_CNT             = 0
        , A69_INCOME_TAX_AMT         = 0
        , A69_ADD_TAX_AMT            = 0
        , A69_THIS_REFUND_TAX_AMT    = 0
        , A69_PAY_INCOME_TAX_AMT     = 0
        , A70_PERSON_CNT             = 0
        , A70_PAYMENT_AMT            = 0
        , A70_INCOME_TAX_AMT         = 0
        , A70_ADD_TAX_AMT            = 0
        , A70_THIS_REFUND_TAX_AMT    = 0
        , A70_PAY_INCOME_TAX_AMT     = 0
        , A80_PERSON_CNT             = 0
        , A80_PAYMENT_AMT            = 0
        , A80_INCOME_TAX_AMT         = 0
        , A80_ADD_TAX_AMT            = 0
        , A80_THIS_REFUND_TAX_AMT    = 0
        , A80_PAY_INCOME_TAX_AMT     = 0
        , A90_INCOME_TAX_AMT         = 0
        , A90_SP_TAX_AMT             = 0
        , A90_ADD_TAX_AMT            = 0
        , A90_THIS_REFUND_TAX_AMT    = 0
        , A90_PAY_INCOME_TAX_AMT     = 0
        , A90_PAY_SP_TAX_AMT         = 0
        , A99_PERSON_CNT             = 0
        , A99_PAYMENT_AMT            = 0
        , A99_INCOME_TAX_AMT         = 0
        , A99_SP_TAX_AMT             = 0
        , A99_ADD_TAX_AMT            = 0
        , A99_THIS_REFUND_TAX_AMT    = 0
        , A99_PAY_INCOME_TAX_AMT     = 0
        , A99_PAY_SP_TAX_AMT         = 0
        , RECEIVE_REFUND_TAX_AMT     = NVL(V_RECEIVE_REFUND_TAX_AMT, 0)
        , ALREADY_REFUND_TAX_AMT     = 0
        , REFUND_BALANCE_AMT         = NVL(V_RECEIVE_REFUND_TAX_AMT, 0)
        , GENERAL_REFUND_AMT         = 0
        , FINANCIAL_AMT              = 0
        , ETC_REFUND_FINANCIAL_AMT   = 0
        , ETC_REFUND_MERGER_AMT      = 0
        , ADJUST_REFUND_TAX_AMT      = NVL(V_RECEIVE_REFUND_TAX_AMT, 0)
        , THIS_ADJUST_REFUND_TAX_AMT = 0
        , NEXT_REFUND_TAX_AMT        = NVL(V_RECEIVE_REFUND_TAX_AMT, 0)
        , REQUEST_REFUND_TAX_AMT     = 0
        , LAST_UPDATE_DATE           = V_SYSDATE
        , LAST_UPDATED_BY            = P_USER_ID
    WHERE WITHHOLDING_DOC_ID         = P_WITHHOLDING_DOC_ID
    ;
    
    IF P_SET_TYPE IN('2', '3') THEN
      -- ���̼��� ���.
      SET_A01
        ( P_WITHHOLDING_DOC_ID    => P_WITHHOLDING_DOC_ID
        , P_CORP_ID               => V_CORP_ID
        , P_STD_YYYYMM            => V_STD_YYYYMM
        , P_PAY_YYYYMM            => V_PAY_YYYYMM
        , P_SOB_ID                => P_SOB_ID
        , P_ORG_ID                => P_ORG_ID
        , P_USER_ID               => P_USER_ID
        , O_STATUS                => O_STATUS
        , O_MESSAGE               => O_MESSAGE
        );
      IF O_STATUS = 'F' THEN
        RETURN;
      END IF;
      
      -- �ߵ����.
      SET_A02
        ( P_WITHHOLDING_DOC_ID    => P_WITHHOLDING_DOC_ID
        , P_CORP_ID               => V_CORP_ID
        , P_STD_YYYYMM            => V_STD_YYYYMM
        , P_PAY_YYYYMM            => V_PAY_YYYYMM
        , P_SOB_ID                => P_SOB_ID
        , P_ORG_ID                => P_ORG_ID
        , P_USER_ID               => P_USER_ID
        , O_STATUS                => O_STATUS
        , O_MESSAGE               => O_MESSAGE
        );
      IF O_STATUS = 'F' THEN
        RETURN;
      END IF;
    END IF;
    -- ��������.
    IF P_SET_TYPE IN ('1', '2') THEN
      SET_A04
        ( P_WITHHOLDING_DOC_ID    => P_WITHHOLDING_DOC_ID
        , P_CORP_ID               => V_CORP_ID
        , P_STD_YYYYMM            => V_STD_YYYYMM
        , P_PAY_YYYYMM            => V_PAY_YYYYMM
        , P_SOB_ID                => P_SOB_ID
        , P_ORG_ID                => P_ORG_ID
        , P_USER_ID               => P_USER_ID
        , O_STATUS                => O_STATUS
        , O_MESSAGE               => O_MESSAGE
        );
      IF O_STATUS = 'F' THEN
        RETURN;
      END IF;
    END IF;
    
    -- �ٷμҵ� �հ�.
    UPDATE HRW_WITHHOLDING_DOC WD
      SET WD.A10_PERSON_CNT         = NVL(WD.A01_PERSON_CNT, 0) + NVL(WD.A02_PERSON_CNT, 0) + 
                                      NVL(WD.A03_PERSON_CNT, 0) + NVL(WD.A04_PERSON_CNT, 0)
        , WD.A10_PAYMENT_AMT        = NVL(WD.A01_PAYMENT_AMT, 0) + NVL(WD.A02_PAYMENT_AMT, 0) + 
                                      NVL(WD.A03_PAYMENT_AMT, 0) + NVL(WD.A04_PAYMENT_AMT, 0)
        , WD.A10_INCOME_TAX_AMT     = NVL(WD.A01_INCOME_TAX_AMT, 0) + NVL(WD.A02_INCOME_TAX_AMT, 0) + 
                                      NVL(WD.A03_INCOME_TAX_AMT, 0) + NVL(WD.A04_INCOME_TAX_AMT, 0)
        , WD.A10_SP_TAX_AMT         = NVL(WD.A01_SP_TAX_AMT, 0) + NVL(WD.A02_SP_TAX_AMT, 0) + 
                                      NVL(WD.A04_SP_TAX_AMT, 0)
    WHERE WD.WITHHOLDING_DOC_ID     = P_WITHHOLDING_DOC_ID
    ;
    -- �ҵ漼���� ������ ��� �Ϲ�ȯ�� ����.
    UPDATE HRW_WITHHOLDING_DOC WD
      SET WD.GENERAL_REFUND_AMT     = CASE
                                        WHEN NVL(WD.A10_INCOME_TAX_AMT, 0) >= 0 THEN 0
                                        ELSE ABS(NVL(WD.A10_INCOME_TAX_AMT, 0))
                                      END
    WHERE WD.WITHHOLDING_DOC_ID     = P_WITHHOLDING_DOC_ID
    ;
    -- �������ȯ�޼���.
    UPDATE HRW_WITHHOLDING_DOC WD
      SET WD.ADJUST_REFUND_TAX_AMT  = NVL(WD.REFUND_BALANCE_AMT, 0) +
                                      NVL(WD.GENERAL_REFUND_AMT, 0)
    WHERE WD.WITHHOLDING_DOC_ID     = P_WITHHOLDING_DOC_ID
    ;
    -- �����̿� ȯ�޼��� ���1.
    UPDATE HRW_WITHHOLDING_DOC WD
      SET WD.NEXT_REFUND_TAX_AMT    = NVL(WD.ADJUST_REFUND_TAX_AMT, 0) -
                                      NVL(WD.THIS_ADJUST_REFUND_TAX_AMT, 0)
    WHERE WD.WITHHOLDING_DOC_ID     = P_WITHHOLDING_DOC_ID
    ;
    -- �������ȯ�޼��� ���.
    UPDATE HRW_WITHHOLDING_DOC WD
      SET WD.A10_THIS_REFUND_TAX_AMT  = CASE
                                          WHEN NVL(WD.ADJUST_REFUND_TAX_AMT, 0) <= 0 THEN 0
                                          WHEN NVL(WD.A10_INCOME_TAX_AMT, 0) <= 0 THEN 0
                                          WHEN NVL(WD.NEXT_REFUND_TAX_AMT, 0) <= NVL(WD.A10_INCOME_TAX_AMT, 0) THEN NVL(WD.NEXT_REFUND_TAX_AMT, 0)
                                          WHEN NVL(WD.NEXT_REFUND_TAX_AMT, 0) > NVL(WD.A10_INCOME_TAX_AMT, 0) THEN NVL(WD.A10_INCOME_TAX_AMT, 0)
                                          ELSE 0
                                        END
    WHERE WD.WITHHOLDING_DOC_ID     = P_WITHHOLDING_DOC_ID
    ;
    -- 19.�������ȯ�޼��װ�.
    UPDATE HRW_WITHHOLDING_DOC WD
      SET WD.THIS_ADJUST_REFUND_TAX_AMT = NVL(WD.THIS_ADJUST_REFUND_TAX_AMT, 0) +
                                          NVL(WD.A10_THIS_REFUND_TAX_AMT, 0)
    WHERE WD.WITHHOLDING_DOC_ID     = P_WITHHOLDING_DOC_ID
    ;
    -- �����̿� ȯ�޼��� ���2.
    UPDATE HRW_WITHHOLDING_DOC WD
      SET WD.NEXT_REFUND_TAX_AMT    = NVL(WD.ADJUST_REFUND_TAX_AMT, 0) -
                                      NVL(WD.THIS_ADJUST_REFUND_TAX_AMT, 0)
    WHERE WD.WITHHOLDING_DOC_ID     = P_WITHHOLDING_DOC_ID
    ;
    -- ���μ��� ���.
    UPDATE HRW_WITHHOLDING_DOC WD
      SET WD.A10_PAY_INCOME_TAX_AMT = CASE
                                        WHEN NVL(WD.A10_INCOME_TAX_AMT, 0) <= 0 THEN 0
                                        ELSE NVL(WD.A10_INCOME_TAX_AMT, 0) - NVL(WD.A10_THIS_REFUND_TAX_AMT, 0)
                                      END
    WHERE WD.WITHHOLDING_DOC_ID     = P_WITHHOLDING_DOC_ID
    ;
    -- A99(���հ�).
    UPDATE HRW_WITHHOLDING_DOC WD
      SET WD.A99_PERSON_CNT         = NVL(WD.A10_PERSON_CNT, 0)
        , WD.A99_PAYMENT_AMT        = NVL(WD.A10_PAYMENT_AMT, 0)
        , WD.A99_INCOME_TAX_AMT     = CASE
                                        WHEN NVL(WD.A10_INCOME_TAX_AMT, 0) < 0 THEN 0
                                        ELSE NVL(WD.A10_INCOME_TAX_AMT, 0)
                                      END
        , WD.A99_SP_TAX_AMT         = NVL(WD.A10_SP_TAX_AMT, 0)
        , WD.A99_ADD_TAX_AMT        = NVL(WD.A10_ADD_TAX_AMT, 0)
        , WD.A99_THIS_REFUND_TAX_AMT= NVL(WD.A10_THIS_REFUND_TAX_AMT, 0)
        , WD.A99_PAY_INCOME_TAX_AMT = NVL(WD.A10_PAY_INCOME_TAX_AMT, 0)
        , WD.A99_PAY_SP_TAX_AMT     = NVL(WD.A10_PAY_SP_TAX_AMT, 0)
    WHERE WD.WITHHOLDING_DOC_ID     = P_WITHHOLDING_DOC_ID
    ;
    
    IF P_SET_TYPE IN('2', '3') THEN
      -- ��������.
      SET_A20
        ( P_WITHHOLDING_DOC_ID    => P_WITHHOLDING_DOC_ID
        , P_CORP_ID               => V_CORP_ID
        , P_STD_YYYYMM            => V_STD_YYYYMM
        , P_PAY_YYYYMM            => V_PAY_YYYYMM
        , P_SOB_ID                => P_SOB_ID
        , P_ORG_ID                => P_ORG_ID
        , P_USER_ID               => P_USER_ID
        , O_STATUS                => O_STATUS
        , O_MESSAGE               => O_MESSAGE
        );
      IF O_STATUS = 'F' THEN
        RETURN;
      END IF;
    END IF;
    -- �ҵ漼���� ������ ��� �Ϲ�ȯ�� ����.
    UPDATE HRW_WITHHOLDING_DOC WD
      SET WD.GENERAL_REFUND_AMT     = NVL(WD.GENERAL_REFUND_AMT, 0) +
                                      CASE
                                        WHEN NVL(WD.A20_INCOME_TAX_AMT, 0) >= 0 THEN 0
                                        ELSE ABS(NVL(WD.A20_INCOME_TAX_AMT, 0))
                                      END
    WHERE WD.WITHHOLDING_DOC_ID     = P_WITHHOLDING_DOC_ID
    ;
    -- �������ȯ�޼���.
    UPDATE HRW_WITHHOLDING_DOC WD
      SET WD.ADJUST_REFUND_TAX_AMT  = NVL(WD.REFUND_BALANCE_AMT, 0) +
                                      NVL(WD.GENERAL_REFUND_AMT, 0)
    WHERE WD.WITHHOLDING_DOC_ID     = P_WITHHOLDING_DOC_ID
    ;
    -- �����̿� ȯ�޼��� ���1.
    UPDATE HRW_WITHHOLDING_DOC WD
      SET WD.NEXT_REFUND_TAX_AMT    = NVL(WD.ADJUST_REFUND_TAX_AMT, 0) -
                                      NVL(WD.THIS_ADJUST_REFUND_TAX_AMT, 0)
    WHERE WD.WITHHOLDING_DOC_ID     = P_WITHHOLDING_DOC_ID
    ;
    -- �������ȯ�޼��� ���.
    UPDATE HRW_WITHHOLDING_DOC WD
      SET WD.A20_THIS_REFUND_TAX_AMT  = CASE
                                          WHEN NVL(WD.ADJUST_REFUND_TAX_AMT, 0) <= 0 THEN 0
                                          WHEN NVL(WD.A20_INCOME_TAX_AMT, 0) <= 0 THEN 0
                                          WHEN NVL(WD.NEXT_REFUND_TAX_AMT, 0) <= NVL(WD.A20_INCOME_TAX_AMT, 0) THEN NVL(WD.NEXT_REFUND_TAX_AMT, 0)
                                          WHEN NVL(WD.NEXT_REFUND_TAX_AMT, 0) > NVL(WD.A20_INCOME_TAX_AMT, 0) THEN NVL(WD.A20_INCOME_TAX_AMT, 0)
                                          ELSE 0
                                        END
    WHERE WD.WITHHOLDING_DOC_ID     = P_WITHHOLDING_DOC_ID
    ;
    -- 19.�������ȯ�޼��װ�.
    UPDATE HRW_WITHHOLDING_DOC WD
      SET WD.THIS_ADJUST_REFUND_TAX_AMT = NVL(WD.THIS_ADJUST_REFUND_TAX_AMT, 0) +
                                          NVL(WD.A20_THIS_REFUND_TAX_AMT, 0)
    WHERE WD.WITHHOLDING_DOC_ID     = P_WITHHOLDING_DOC_ID
    ;
    -- 20.�����̿� ȯ�޼��� ���2.
    UPDATE HRW_WITHHOLDING_DOC WD
      SET WD.NEXT_REFUND_TAX_AMT    = NVL(WD.ADJUST_REFUND_TAX_AMT, 0) -
                                      NVL(WD.THIS_ADJUST_REFUND_TAX_AMT, 0)
    WHERE WD.WITHHOLDING_DOC_ID     = P_WITHHOLDING_DOC_ID
    ;
    -- ���μ��� ���.
    UPDATE HRW_WITHHOLDING_DOC WD
      SET WD.A20_PAY_INCOME_TAX_AMT = CASE
                                        WHEN NVL(WD.A20_INCOME_TAX_AMT, 0) <= 0 THEN 0
                                        ELSE NVL(WD.A20_INCOME_TAX_AMT, 0) - NVL(WD.A20_THIS_REFUND_TAX_AMT, 0)
                                      END
    WHERE WD.WITHHOLDING_DOC_ID     = P_WITHHOLDING_DOC_ID
    ;
    -- A99(���հ�).
    UPDATE HRW_WITHHOLDING_DOC WD
      SET WD.A99_PERSON_CNT         = NVL(WD.A99_PERSON_CNT, 0) + NVL(WD.A20_PERSON_CNT, 0)
        , WD.A99_PAYMENT_AMT        = NVL(WD.A99_PAYMENT_AMT, 0) + NVL(WD.A20_PAYMENT_AMT, 0)
        , WD.A99_INCOME_TAX_AMT     = NVL(WD.A99_INCOME_TAX_AMT, 0) + CASE
                                                                        WHEN NVL(WD.A20_INCOME_TAX_AMT, 0) < 0 THEN 0
                                                                        ELSE NVL(WD.A20_INCOME_TAX_AMT, 0)
                                                                      END
        , WD.A99_ADD_TAX_AMT        = NVL(WD.A99_ADD_TAX_AMT, 0) + NVL(WD.A20_ADD_TAX_AMT, 0)
        , WD.A99_THIS_REFUND_TAX_AMT= NVL(WD.A99_THIS_REFUND_TAX_AMT, 0) + NVL(WD.A20_THIS_REFUND_TAX_AMT, 0)
        , WD.A99_PAY_INCOME_TAX_AMT = NVL(WD.A99_PAY_INCOME_TAX_AMT, 0) + NVL(WD.A20_PAY_INCOME_TAX_AMT, 0)
    WHERE WD.WITHHOLDING_DOC_ID     = P_WITHHOLDING_DOC_ID
    ;
    
    IF P_SET_TYPE IN('2', '3') THEN
      -- ����ҵ�.
      SET_A25
        ( P_WITHHOLDING_DOC_ID    => P_WITHHOLDING_DOC_ID
        , P_CORP_ID               => V_CORP_ID
        , P_STD_YYYYMM            => V_STD_YYYYMM
        , P_PAY_YYYYMM            => V_PAY_YYYYMM
        , P_SOB_ID                => P_SOB_ID
        , P_ORG_ID                => P_ORG_ID
        , P_USER_ID               => P_USER_ID
        , O_STATUS                => O_STATUS
        , O_MESSAGE               => O_MESSAGE
        );
      IF O_STATUS = 'F' THEN
        RETURN;
      END IF;
    END IF;
    -- ����ҵ� �հ�.
    UPDATE HRW_WITHHOLDING_DOC WD
      SET WD.A30_PERSON_CNT         = NVL(WD.A25_PERSON_CNT, 0) + NVL(WD.A26_PERSON_CNT, 0)
        , WD.A30_PAYMENT_AMT        = NVL(WD.A25_PAYMENT_AMT, 0) + NVL(WD.A26_PAYMENT_AMT, 0)
        , WD.A30_INCOME_TAX_AMT     = NVL(WD.A25_INCOME_TAX_AMT, 0) + NVL(WD.A26_INCOME_TAX_AMT, 0)
        , WD.A30_SP_TAX_AMT         = NVL(WD.A01_SP_TAX_AMT, 0) + NVL(WD.A02_SP_TAX_AMT, 0) + 
                                      NVL(WD.A04_SP_TAX_AMT, 0)
    WHERE WD.WITHHOLDING_DOC_ID     = P_WITHHOLDING_DOC_ID
    ;
    -- �ҵ漼���� ������ ��� �Ϲ�ȯ�� ����.
    UPDATE HRW_WITHHOLDING_DOC WD
      SET WD.GENERAL_REFUND_AMT     = NVL(WD.GENERAL_REFUND_AMT, 0) +
                                      CASE
                                        WHEN NVL(WD.A30_INCOME_TAX_AMT, 0) >= 0 THEN 0
                                        ELSE ABS(NVL(WD.A30_INCOME_TAX_AMT, 0))
                                      END
    WHERE WD.WITHHOLDING_DOC_ID     = P_WITHHOLDING_DOC_ID
    ;
    -- �������ȯ�޼���.
    UPDATE HRW_WITHHOLDING_DOC WD
      SET WD.ADJUST_REFUND_TAX_AMT  = NVL(WD.REFUND_BALANCE_AMT, 0) +
                                      NVL(WD.GENERAL_REFUND_AMT, 0)
    WHERE WD.WITHHOLDING_DOC_ID     = P_WITHHOLDING_DOC_ID
    ;
    -- �����̿� ȯ�޼��� ���1.
    UPDATE HRW_WITHHOLDING_DOC WD
      SET WD.NEXT_REFUND_TAX_AMT    = NVL(WD.ADJUST_REFUND_TAX_AMT, 0) -
                                      NVL(WD.THIS_ADJUST_REFUND_TAX_AMT, 0)
    WHERE WD.WITHHOLDING_DOC_ID     = P_WITHHOLDING_DOC_ID
    ;
    -- �������ȯ�޼��� ���.
    UPDATE HRW_WITHHOLDING_DOC WD
      SET WD.A30_THIS_REFUND_TAX_AMT  = CASE
                                          WHEN NVL(WD.ADJUST_REFUND_TAX_AMT, 0) <= 0 THEN 0
                                          WHEN NVL(WD.A30_INCOME_TAX_AMT, 0) <= 0 THEN 0
                                          WHEN NVL(WD.NEXT_REFUND_TAX_AMT, 0) <= NVL(WD.A30_INCOME_TAX_AMT, 0) THEN NVL(WD.NEXT_REFUND_TAX_AMT, 0)
                                          WHEN NVL(WD.NEXT_REFUND_TAX_AMT, 0) > NVL(WD.A30_INCOME_TAX_AMT, 0) THEN NVL(WD.A30_INCOME_TAX_AMT, 0)
                                          ELSE 0
                                        END
    WHERE WD.WITHHOLDING_DOC_ID     = P_WITHHOLDING_DOC_ID
    ;
    -- 19.�������ȯ�޼��װ�.
    UPDATE HRW_WITHHOLDING_DOC WD
      SET WD.THIS_ADJUST_REFUND_TAX_AMT = NVL(WD.THIS_ADJUST_REFUND_TAX_AMT, 0) +
                                          NVL(WD.A30_THIS_REFUND_TAX_AMT, 0)
    WHERE WD.WITHHOLDING_DOC_ID     = P_WITHHOLDING_DOC_ID
    ;
    -- 20.�����̿� ȯ�޼��� ���2.
    UPDATE HRW_WITHHOLDING_DOC WD
      SET WD.NEXT_REFUND_TAX_AMT    = NVL(WD.ADJUST_REFUND_TAX_AMT, 0) -
                                      NVL(WD.THIS_ADJUST_REFUND_TAX_AMT, 0)
    WHERE WD.WITHHOLDING_DOC_ID     = P_WITHHOLDING_DOC_ID
    ;
    -- ���μ��� ���.
    UPDATE HRW_WITHHOLDING_DOC WD
      SET WD.A30_PAY_INCOME_TAX_AMT = CASE
                                        WHEN NVL(WD.A30_INCOME_TAX_AMT, 0) <= 0 THEN 0
                                        ELSE NVL(WD.A30_INCOME_TAX_AMT, 0) - NVL(WD.A30_THIS_REFUND_TAX_AMT, 0)
                                      END
    WHERE WD.WITHHOLDING_DOC_ID     = P_WITHHOLDING_DOC_ID
    ;
    -- A99(���հ�).
    UPDATE HRW_WITHHOLDING_DOC WD
      SET WD.A99_PERSON_CNT         = NVL(WD.A99_PERSON_CNT, 0) + NVL(WD.A30_PERSON_CNT, 0)
        , WD.A99_PAYMENT_AMT        = NVL(WD.A99_PAYMENT_AMT, 0) + NVL(WD.A30_PAYMENT_AMT, 0)
        , WD.A99_INCOME_TAX_AMT     = NVL(WD.A99_INCOME_TAX_AMT, 0) + CASE
                                                                        WHEN NVL(WD.A30_INCOME_TAX_AMT, 0) < 0 THEN 0
                                                                        ELSE NVL(WD.A30_INCOME_TAX_AMT, 0)
                                                                      END
        , WD.A99_SP_TAX_AMT         = NVL(WD.A99_SP_TAX_AMT, 0) + NVL(WD.A30_SP_TAX_AMT, 0)
        , WD.A99_ADD_TAX_AMT        = NVL(WD.A99_ADD_TAX_AMT, 0) + NVL(WD.A30_ADD_TAX_AMT, 0)
        , WD.A99_THIS_REFUND_TAX_AMT= NVL(WD.A99_THIS_REFUND_TAX_AMT, 0) + NVL(WD.A30_THIS_REFUND_TAX_AMT, 0)
        , WD.A99_PAY_INCOME_TAX_AMT = NVL(WD.A99_PAY_INCOME_TAX_AMT, 0) + NVL(WD.A30_PAY_INCOME_TAX_AMT, 0)
        , WD.A99_PAY_SP_TAX_AMT     = NVL(WD.A99_PAY_SP_TAX_AMT, 0) + NVL(WD.A30_PAY_SP_TAX_AMT, 0)
    WHERE WD.WITHHOLDING_DOC_ID     = P_WITHHOLDING_DOC_ID
    ;
  END MAIN_WITHHOLDING;

-- ���̼��� ���.
  PROCEDURE SET_A01
            ( P_WITHHOLDING_DOC_ID    IN HRW_WITHHOLDING_DOC.WITHHOLDING_DOC_ID%TYPE
            , P_CORP_ID               IN HRW_WITHHOLDING_DOC.CORP_ID%TYPE
            , P_STD_YYYYMM            IN HRW_WITHHOLDING_DOC.STD_YYYYMM%TYPE
            , P_PAY_YYYYMM            IN HRW_WITHHOLDING_DOC.PAY_YYYYMM%TYPE
            , P_SOB_ID                IN HRW_WITHHOLDING_DOC.SOB_ID%TYPE
            , P_ORG_ID                IN HRW_WITHHOLDING_DOC.ORG_ID%TYPE
            , P_USER_ID               IN NUMBER
            , O_STATUS                OUT VARCHAR2
            , O_MESSAGE               OUT VARCHAR2
            )
  AS
    V_PERSON_COUNT                    NUMBER := 0;
    V_PAYMENT_AMOUNT                  NUMBER := 0;
    V_INCOME_TAX_AMOUNT               NUMBER := 0;
  BEGIN
    O_STATUS := 'F';
    BEGIN
      SELECT COUNT(MP.PERSON_ID) AS PERSON_COUNT
           , SUM(HMA.ALLOWANCE_AMOUNT) AS ALLOWANCE_AMOUNT  -- �����޾�.
           , SUM(HMD.D01) AS INCOME_TAX_AMOUNT  -- �ҵ漼.
        INTO V_PERSON_COUNT
           , V_PAYMENT_AMOUNT
           , V_INCOME_TAX_AMOUNT
        FROM HRM_PERSON_MASTER PM
          , HRP_MONTH_PAYMENT MP
          , ( SELECT MA.MONTH_PAYMENT_ID
                  , SUM(MA.ALLOWANCE_AMOUNT)  AS ALLOWANCE_AMOUNT
                FROM HRP_MONTH_ALLOWANCE MA
              WHERE MA.PAY_YYYYMM       = P_STD_YYYYMM  -- �ͼӳ��.
                AND MA.CORP_ID          = P_CORP_ID
                AND MA.SOB_ID           = P_SOB_ID
                AND MA.ORG_ID           = P_ORG_ID
              GROUP BY MA.MONTH_PAYMENT_ID
             ) HMA
          , ( SELECT MD.MONTH_PAYMENT_ID
                  , SUM(MD.D01) AS D01
                FROM HRP_MONTH_DEDUCTION_V MD
              WHERE MD.PAY_YYYYMM       = P_STD_YYYYMM  -- �ͼӳ��.
                AND MD.CORP_ID          = P_CORP_ID
                AND MD.SOB_ID           = P_SOB_ID
                AND MD.ORG_ID           = P_ORG_ID
              GROUP BY MD.MONTH_PAYMENT_ID
             ) HMD
      WHERE PM.PERSON_ID                = MP.PERSON_ID
        AND MP.MONTH_PAYMENT_ID         = HMA.MONTH_PAYMENT_ID
        AND MP.MONTH_PAYMENT_ID         = HMD.MONTH_PAYMENT_ID(+)
        AND MP.PAY_YYYYMM               = P_STD_YYYYMM  -- �ͼӳ��.
        AND MP.CORP_ID                  = P_CORP_ID
        AND MP.SOB_ID                   = P_SOB_ID
        AND MP.ORG_ID                   = P_ORG_ID
        AND TO_CHAR(MP.SUPPLY_DATE, 'YYYY-MM')  = P_PAY_YYYYMM  -- ���޳��.
      ;
    EXCEPTION WHEN OTHERS THEN
      V_PERSON_COUNT      := 0;
      V_PAYMENT_AMOUNT    := 0;
      V_INCOME_TAX_AMOUNT := 0;
    END;
    
    BEGIN
      UPDATE HRW_WITHHOLDING_DOC WD
        SET WD.A01_PERSON_CNT       = NVL(V_PERSON_COUNT, 0)
          , WD.A01_PAYMENT_AMT      = NVL(V_PAYMENT_AMOUNT, 0)
          , WD.A01_INCOME_TAX_AMT   = NVL(V_INCOME_TAX_AMOUNT, 0)
      WHERE WD.WITHHOLDING_DOC_ID   = P_WITHHOLDING_DOC_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      O_STATUS := 'F';
      O_MESSAGE := SQLERRM;
    END;
    O_STATUS := 'S';
  END SET_A01;

-- �ߵ���� ���.
  PROCEDURE SET_A02
            ( P_WITHHOLDING_DOC_ID    IN HRW_WITHHOLDING_DOC.WITHHOLDING_DOC_ID%TYPE
            , P_CORP_ID               IN HRW_WITHHOLDING_DOC.CORP_ID%TYPE
            , P_STD_YYYYMM            IN HRW_WITHHOLDING_DOC.STD_YYYYMM%TYPE
            , P_PAY_YYYYMM            IN HRW_WITHHOLDING_DOC.PAY_YYYYMM%TYPE
            , P_SOB_ID                IN HRW_WITHHOLDING_DOC.SOB_ID%TYPE
            , P_ORG_ID                IN HRW_WITHHOLDING_DOC.ORG_ID%TYPE
            , P_USER_ID               IN NUMBER
            , O_STATUS                OUT VARCHAR2
            , O_MESSAGE               OUT VARCHAR2
            )
  AS
    V_PERSON_COUNT                    NUMBER := 0;
    V_PAYMENT_AMOUNT                  NUMBER := 0;
    V_INCOME_TAX_AMOUNT               NUMBER := 0;
  BEGIN
    O_STATUS := 'F';
    BEGIN
      SELECT COUNT(DISTINCT MP.PERSON_ID) AS PERSON_COUNT
           , SUM(HYA1.ALLOWANCE_AMOUNT) AS ALLOWANCE_AMOUNT  -- �����޾�.
           , SUM(HYA2.SUBT_IN_TAX_AMT) AS INCOME_TAX_AMOUNT  -- ����ҵ漼.
        INTO V_PERSON_COUNT
          , V_PAYMENT_AMOUNT
          , V_INCOME_TAX_AMOUNT
        FROM HRM_PERSON_MASTER PM
          , HRP_MONTH_PAYMENT MP
          , ( SELECT YA.PERSON_ID
                   , YA.INCOME_TOT_AMT AS ALLOWANCE_AMOUNT    -- �����޾�.
                   , TRUNC(YA.SUBT_IN_TAX_AMT, -1) AS INCOME_TAX_AMOUNT  -- ����ҵ漼.
                FROM HRM_PERSON_MASTER PM
                  , HRA_YEAR_ADJUSTMENT YA
              WHERE PM.PERSON_ID                = YA.PERSON_ID
                AND YA.YEAR_YYYY                = SUBSTR(P_STD_YYYYMM, 1, 4)
                AND YA.ADJUST_DATE_TO           BETWEEN TRUNC(TO_DATE(P_STD_YYYYMM, 'YYYY-MM'), 'MONTH') AND LAST_DAY(TO_DATE(P_STD_YYYYMM, 'YYYY-MM'))
                AND PM.CORP_ID                  = P_CORP_ID
                AND PM.SOB_ID                   = P_SOB_ID
                AND PM.ORG_ID                   = P_ORG_ID
                AND (PM.RETIRE_DATE             >= TRUNC(TO_DATE(P_STD_YYYYMM, 'YYYY-MM'), 'YEAR') - 1 OR PM.RETIRE_DATE IS NULL)
              /*; 
      SELECT MA.MONTH_PAYMENT_ID
                  , SUM(MA.ALLOWANCE_AMOUNT)  AS ALLOWANCE_AMOUNT
                FROM HRP_MONTH_ALLOWANCE MA
              WHERE MA.PAY_YYYYMM       = P_STD_YYYYMM  -- �ͼӳ��.
                AND MA.CORP_ID          = P_CORP_ID
                AND MA.SOB_ID           = P_SOB_ID
                AND MA.ORG_ID           = P_ORG_ID
              GROUP BY MA.MONTH_PAYMENT_ID*/
             ) HYA1
          , ( SELECT YA.PERSON_ID
                   , TRUNC(YA.SUBT_IN_TAX_AMT, -1) AS SUBT_IN_TAX_AMT
                FROM HRA_YEAR_ADJUSTMENT YA
              WHERE YA.YEAR_YYYY        = SUBSTR(P_STD_YYYYMM, 1, 4)
                AND YA.CORP_ID          = P_CORP_ID
                AND YA.ADJUST_DATE_TO   BETWEEN TRUNC(TO_DATE(P_STD_YYYYMM, 'YYYY-MM'), 'MONTH') AND LAST_DAY(TO_DATE(P_STD_YYYYMM, 'YYYY-MM'))
             ) HYA2
      WHERE PM.PERSON_ID                = MP.PERSON_ID
        AND MP.PERSON_ID                = HYA1.PERSON_ID(+)
        AND MP.PERSON_ID                = HYA2.PERSON_ID(+)
        AND MP.PAY_YYYYMM               = P_STD_YYYYMM  -- �ͼӳ��.
        AND MP.CORP_ID                  = P_CORP_ID
        AND MP.SOB_ID                   = P_SOB_ID
        AND MP.ORG_ID                   = P_ORG_ID
        AND PM.RETIRE_DATE              BETWEEN TRUNC(TO_DATE(P_STD_YYYYMM, 'YYYY-MM'), 'MONTH') AND LAST_DAY(TO_DATE(P_STD_YYYYMM, 'YYYY-MM'))
        AND TO_CHAR(MP.SUPPLY_DATE, 'YYYY-MM')  = P_PAY_YYYYMM  -- ���޳��.
      ;
    EXCEPTION WHEN OTHERS THEN
      V_PERSON_COUNT      := 0;
      V_PAYMENT_AMOUNT    := 0;
      V_INCOME_TAX_AMOUNT := 0;
    END;
    
    BEGIN
      UPDATE HRW_WITHHOLDING_DOC WD
        SET WD.A02_PERSON_CNT        = NVL(V_PERSON_COUNT, 0)
          , WD.A02_PAYMENT_AMT       = NVL(V_PAYMENT_AMOUNT, 0)
          , WD.A02_INCOME_TAX_AMT    = NVL(V_INCOME_TAX_AMOUNT, 0)
      WHERE WD.WITHHOLDING_DOC_ID    = P_WITHHOLDING_DOC_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      O_STATUS := 'F';
      O_MESSAGE := SQLERRM;
    END;
    O_STATUS := 'S';
  END SET_A02;

-- �������� ���.
  PROCEDURE SET_A04
            ( P_WITHHOLDING_DOC_ID    IN HRW_WITHHOLDING_DOC.WITHHOLDING_DOC_ID%TYPE
            , P_CORP_ID               IN HRW_WITHHOLDING_DOC.CORP_ID%TYPE
            , P_STD_YYYYMM            IN HRW_WITHHOLDING_DOC.STD_YYYYMM%TYPE
            , P_PAY_YYYYMM            IN HRW_WITHHOLDING_DOC.PAY_YYYYMM%TYPE
            , P_SOB_ID                IN HRW_WITHHOLDING_DOC.SOB_ID%TYPE
            , P_ORG_ID                IN HRW_WITHHOLDING_DOC.ORG_ID%TYPE
            , P_USER_ID               IN NUMBER
            , O_STATUS                OUT VARCHAR2
            , O_MESSAGE               OUT VARCHAR2
            )
  AS
    V_PERSON_COUNT                    NUMBER := 0;
    V_PAYMENT_AMOUNT                  NUMBER := 0;
    V_INCOME_TAX_AMOUNT               NUMBER := 0;
  BEGIN
    O_STATUS := 'F';
    BEGIN
      SELECT COUNT(YA.PERSON_ID) AS PERSON_COUNT
           , SUM(YA.INCOME_TOT_AMT) AS ALLOWANCE_AMOUNT  -- �����޾�.
           , SUM(YA.SUBT_IN_TAX_AMT) AS INCOME_TAX_AMOUNT  -- ����ҵ漼.
        INTO V_PERSON_COUNT
          , V_PAYMENT_AMOUNT
          , V_INCOME_TAX_AMOUNT
        FROM HRM_PERSON_MASTER PM
          , HRA_YEAR_ADJUSTMENT YA
      WHERE PM.PERSON_ID                = YA.PERSON_ID
        AND YA.YEAR_YYYY                = TO_CHAR(TRUNC(TO_DATE(P_STD_YYYYMM, 'YYYY-MM'), 'YEAR') - 1, 'YYYY')
        AND YA.ADJUST_DATE_TO           = TRUNC(TO_DATE(P_STD_YYYYMM, 'YYYY-MM'), 'YEAR') - 1
        AND PM.CORP_ID                  = P_CORP_ID
        AND PM.SOB_ID                   = P_SOB_ID
        AND PM.ORG_ID                   = P_ORG_ID
        AND (PM.RETIRE_DATE             >= TRUNC(TO_DATE(P_STD_YYYYMM, 'YYYY-MM'), 'YEAR') - 1 OR PM.RETIRE_DATE IS NULL)
      ; 
    EXCEPTION WHEN OTHERS THEN
      V_PERSON_COUNT      := 0;
      V_PAYMENT_AMOUNT    := 0;
      V_INCOME_TAX_AMOUNT := 0;
    END;
    
    BEGIN
      UPDATE HRW_WITHHOLDING_DOC WD
        SET WD.A04_PERSON_CNT        = NVL(V_PERSON_COUNT, 0)
          , WD.A04_PAYMENT_AMT       = NVL(V_PAYMENT_AMOUNT, 0)
          , WD.A04_INCOME_TAX_AMT    = NVL(V_INCOME_TAX_AMOUNT, 0)
      WHERE WD.WITHHOLDING_DOC_ID    = P_WITHHOLDING_DOC_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      O_STATUS := 'F';
      O_MESSAGE := SQLERRM;
    END;
    O_STATUS := 'S';
  END SET_A04;

-- �����ҵ� ���.
  PROCEDURE SET_A20
            ( P_WITHHOLDING_DOC_ID    IN HRW_WITHHOLDING_DOC.WITHHOLDING_DOC_ID%TYPE
            , P_CORP_ID               IN HRW_WITHHOLDING_DOC.CORP_ID%TYPE
            , P_STD_YYYYMM            IN HRW_WITHHOLDING_DOC.STD_YYYYMM%TYPE
            , P_PAY_YYYYMM            IN HRW_WITHHOLDING_DOC.PAY_YYYYMM%TYPE
            , P_SOB_ID                IN HRW_WITHHOLDING_DOC.SOB_ID%TYPE
            , P_ORG_ID                IN HRW_WITHHOLDING_DOC.ORG_ID%TYPE
            , P_USER_ID               IN NUMBER
            , O_STATUS                OUT VARCHAR2
            , O_MESSAGE               OUT VARCHAR2
            )
  AS
    V_PERSON_COUNT                    NUMBER := 0;
    V_PAYMENT_AMOUNT                  NUMBER := 0;
    V_INCOME_TAX_AMOUNT               NUMBER := 0;
  BEGIN
    O_STATUS := 'F';
    BEGIN
      SELECT COUNT(RA.PERSON_ID) AS PERSON_COUNT
           , SUM(RA.RETIRE_TOTAL_AMOUNT) AS RETIRE_TOTAL_AMOUNT
           , SUM(NVL(RA.INCOME_TAX_AMOUNT, 0) + NVL(RA.H_INCOME_TAX_AMOUNT, 0)) AS INCOME_TAX_AMOUNT
        INTO V_PERSON_COUNT
           , V_PAYMENT_AMOUNT
           , V_INCOME_TAX_AMOUNT
        FROM HRR_RETIRE_ADJUSTMENT RA
      WHERE RA.CORP_ID                  = P_CORP_ID
        AND RA.SOB_ID                   = P_SOB_ID
        AND RA.ORG_ID                   = P_ORG_ID
        AND TO_CHAR(RA.CLOSED_DATE, 'YYYY-MM')    = P_STD_YYYYMM  -- ���޿��� ����.
        AND TO_CHAR(RA.CLOSED_DATE, 'YYYY-MM')    = P_PAY_YYYYMM  -- �ͼӿ��� ����.
        AND RA.CLOSED_YN                = 'Y'
      ;
    EXCEPTION WHEN OTHERS THEN
      V_PERSON_COUNT      := 0;
      V_PAYMENT_AMOUNT    := 0;
      V_INCOME_TAX_AMOUNT := 0;
    END;
    
    BEGIN
      UPDATE HRW_WITHHOLDING_DOC WD
        SET WD.A20_PERSON_CNT      = NVL(V_PERSON_COUNT, 0)
          , WD.A20_PAYMENT_AMT     = NVL(V_PAYMENT_AMOUNT, 0)
          , WD.A20_INCOME_TAX_AMT  = NVL(V_INCOME_TAX_AMOUNT, 0)
      WHERE WD.WITHHOLDING_DOC_ID  = P_WITHHOLDING_DOC_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      O_STATUS := 'F';
      O_MESSAGE := SQLERRM;
    END;
    O_STATUS := 'S';
  END SET_A20;

-- ����ҵ� ���.
  PROCEDURE SET_A25
            ( P_WITHHOLDING_DOC_ID    IN HRW_WITHHOLDING_DOC.WITHHOLDING_DOC_ID%TYPE
            , P_CORP_ID               IN HRW_WITHHOLDING_DOC.CORP_ID%TYPE
            , P_STD_YYYYMM            IN HRW_WITHHOLDING_DOC.STD_YYYYMM%TYPE
            , P_PAY_YYYYMM            IN HRW_WITHHOLDING_DOC.PAY_YYYYMM%TYPE
            , P_SOB_ID                IN HRW_WITHHOLDING_DOC.SOB_ID%TYPE
            , P_ORG_ID                IN HRW_WITHHOLDING_DOC.ORG_ID%TYPE
            , P_USER_ID               IN NUMBER
            , O_STATUS                OUT VARCHAR2
            , O_MESSAGE               OUT VARCHAR2
            )
  AS
    V_PERSON_COUNT                    NUMBER := 0;
    V_PAYMENT_AMOUNT                  NUMBER := 0;
    V_INCOME_TAX_AMOUNT               NUMBER := 0;
  BEGIN
    O_STATUS := 'F';
    BEGIN
      SELECT COUNT(IRB.EARNER_ID) AS PERSON_COUNT
           , SUM(IRB.PAYMENT_AMOUNT) AS RETIRE_TOTAL_AMOUNT
           , SUM(IRB.INCOME_TAX_AMT) AS INCOME_TAX_AMOUNT
        INTO V_PERSON_COUNT
           , V_PAYMENT_AMOUNT
           , V_INCOME_TAX_AMOUNT
        FROM HRW_INCOME_RESIDENT_BSN IRB
      WHERE IRB.CORP_ID                 = P_CORP_ID
        AND IRB.SOB_ID                  = P_SOB_ID
        AND IRB.ORG_ID                  = P_ORG_ID
        AND TO_CHAR(IRB.PAY_DATE, 'YYYY-MM')     = P_STD_YYYYMM     -- �ͼӿ���.
        AND TO_CHAR(IRB.RECEIPT_DATE, 'YYYY-MM') = P_PAY_YYYYMM  -- ���޿���.
      ;
    EXCEPTION WHEN OTHERS THEN
      V_PERSON_COUNT      := 0;
      V_PAYMENT_AMOUNT    := 0;
      V_INCOME_TAX_AMOUNT := 0;
    END;
    
    BEGIN
      UPDATE HRW_WITHHOLDING_DOC WD
        SET WD.A25_PERSON_CNT        = NVL(V_PERSON_COUNT, 0)
          , WD.A25_PAYMENT_AMT       = NVL(V_PAYMENT_AMOUNT, 0)
          , WD.A25_INCOME_TAX_AMT    = NVL(V_INCOME_TAX_AMOUNT, 0)
      WHERE WD.WITHHOLDING_DOC_ID    = P_WITHHOLDING_DOC_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      O_STATUS := 'F';
      O_MESSAGE := SQLERRM;
    END;
    O_STATUS := 'S';
  END SET_A25;

-- ��õ¡�� ���� ����.
  FUNCTION CLOSED_WITHHOLDING_YN
            ( P_WITHHOLDING_DOC_ID    IN HRW_WITHHOLDING_DOC.WITHHOLDING_DOC_ID%TYPE
            ) RETURN VARCHAR2
  AS
    V_COUNT                     NUMBER := 0;
  BEGIN
    -- ���� ���� üũ.
    BEGIN
      SELECT SUM(DECODE(WD.CLOSED_YN, 'Y', 1, 0)) AS CLOSED_COUNT
        INTO V_COUNT
        FROM HRW_WITHHOLDING_DOC WD
      WHERE WD.WITHHOLDING_DOC_ID     = P_WITHHOLDING_DOC_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_COUNT := 0;
    END;
    IF V_COUNT > 0 THEN
      RETURN 'Y';
    END IF;
    RETURN 'N';
  END CLOSED_WITHHOLDING_YN;
  
-- ��õ¡�� ������ ����.
  PROCEDURE CLOSED_WITHHOLDING
            ( P_WITHHOLDING_DOC_ID    IN HRW_WITHHOLDING_DOC.WITHHOLDING_DOC_ID%TYPE
            , P_CONNECT_PERSON_ID     IN NUMBER
            , P_SOB_ID                IN NUMBER
            , P_ORG_ID                IN NUMBER            
            )
  AS
  BEGIN
    UPDATE HRW_WITHHOLDING_DOC WD
      SET WD.CLOSED_YN            = 'Y'
        , WD.CLOSED_DATE          = GET_LOCAL_DATE(P_SOB_ID)
        , WD.CLOSED_PERSON_ID     = P_CONNECT_PERSON_ID
    WHERE WD.WITHHOLDING_DOC_ID   = P_WITHHOLDING_DOC_ID
    ;
  END CLOSED_WITHHOLDING;
            
-- ��õ¡�� ������ ���� ���.
  PROCEDURE CLOSED_CANCEL_WITHHOLDING
            ( P_WITHHOLDING_DOC_ID    IN HRW_WITHHOLDING_DOC.WITHHOLDING_DOC_ID%TYPE
            , P_CONNECT_PERSON_ID     IN NUMBER
            , P_SOB_ID                IN NUMBER
            , P_ORG_ID                IN NUMBER            
            )
  AS
  BEGIN
    UPDATE HRW_WITHHOLDING_DOC WD
      SET WD.CLOSED_YN            = 'N'
        , WD.CLOSED_DATE          = GET_LOCAL_DATE(P_SOB_ID)
        , WD.CLOSED_PERSON_ID     = P_CONNECT_PERSON_ID
    WHERE WD.WITHHOLDING_DOC_ID   = P_WITHHOLDING_DOC_ID
    ;    
  END CLOSED_CANCEL_WITHHOLDING;

END HRW_WITHHOLDING_SET_G;
/
