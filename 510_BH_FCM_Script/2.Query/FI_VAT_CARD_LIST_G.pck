CREATE OR REPLACE PACKAGE FI_VAT_CARD_LIST_G
AS

  -- 신용카드매입전표 CheckList
  PROCEDURE VAT_CARD_LIST_SELECT
            ( P_CURSOR             OUT TYPES.TCURSOR
            , W_PERIOD_NAME        IN FI_VAT_MASTER.PERIOD_NAME%TYPE
            , W_CONSIGNEE_ID       IN FI_VAT_MASTER.CONSIGNEE_ID%TYPE
            , W_SOB_ID             IN FI_VAT_MASTER.SOB_ID%TYPE
            , W_ORG_ID             IN FI_VAT_MASTER.ORG_ID%TYPE
            );

END FI_VAT_CARD_LIST_G; 
/
CREATE OR REPLACE PACKAGE BODY FI_VAT_CARD_LIST_G
AS
/******************************************************************************/
/* Project      : FPCB ERP
/* Module       :
/* Program Name : FI_VAT_CARD_LIST_G
/* Description  : 신용카드매입전표 CheckList ( FCMF0804 )
/*
/* Reference by :
/* Program History :
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  G.T. Seong         Initialize
/******************************************************************************/
-- 매입처별 계산서합계표
  PROCEDURE VAT_CARD_LIST_SELECT
            ( P_CURSOR             OUT TYPES.TCURSOR
            , W_PERIOD_NAME        IN FI_VAT_MASTER.PERIOD_NAME%TYPE
            , W_CONSIGNEE_ID       IN FI_VAT_MASTER.CONSIGNEE_ID%TYPE
            , W_SOB_ID             IN FI_VAT_MASTER.SOB_ID%TYPE
            , W_ORG_ID             IN FI_VAT_MASTER.ORG_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR FOR
      SELECT C_CRD.CONSIGNEE_ID,
             FSV_C.TAX_REG_NO   CONSIGNEE_TAX_NUM,                   --사업자번호(Reg. Consignee Tax No.)
             ROW_NUMBER() OVER (PARTITION BY C_CRD.CONSIGNEE_ID
                                ORDER BY  C_CRD.GL_DATE, C_CRD.ISSUE_DATE, C_CRD.SLIP_DATE, C_CRD.SLIP_NUM)   ROW_NUM,
             C_CRD.GL_DATE,                                         --회계일자( Account date)
             C_CRD.GL_NUM,                                          --회계번호( Account number)
             C_CRD.CREDIT_CARD_NUM,                                 --카드번호(Card Number)
             C_CRD.SUPPLIER_ID,
             FSV_S.TAX_REG_NO      SUPPLIER_TAX_NUM,                --사업자번호(Reg. Supplier Tax No.)
             FSV_S.SUPP_CUST_NAME  SUPPLIER_CORP,                   --상호(Supplier name)
             FSV_S.PRESIDENT_NAME  SUPP_PRESIDENT_NAME,             --대표자명(President name)
             DECODE(NVL(FSV_S.ADDRESS_2,'1'), '1',FSV_S.ADDRESS_1,FSV_S.ADDRESS_1||' '||FSV_S.ADDRESS_2)  SUPP_ADDRESS,  --주소(Address)
             C_CRD.GL_AMOUNT,                                       --공급가액(Sale amount)
             C_CRD.VAT_AMOUNT,                                      --부가세(VAT amount)
             C_CRD.VOUCH_CODE,
             FCM.CODE_NAME       VOUCH_CODE_NAME,                   --증빙(Vouch name)
             C_CRD.SLIP_DATE,                                       --발의일자(Slip date)
             C_CRD.ISSUE_DATE,                                      --계산서일자(Issue date)
             C_CRD.SLIP_TYPE
        FROM ( SELECT
                      FVM.CONSIGNEE_ID         CONSIGNEE_ID,
                      CC.CARD_NUM              CREDIT_CARD_NUM,
                      FVM.GL_DATE              GL_DATE,
                      FVM.GL_NUM               GL_NUM,
                      FVM.SUPPLIER_ID          SUPPLIER_ID,
                      FVM.GL_AMOUNT            GL_AMOUNT,
                      FVM.VAT_AMOUNT           VAT_AMOUNT,
                      FVM.VOUCH_CODE           VOUCH_CODE,
                      FSL.SLIP_DATE            SLIP_DATE,
                      FSL.SLIP_NUM             SLIP_NUM,
                      FVM.VAT_ISSUE_DATE       ISSUE_DATE,
                      FSL.SLIP_TYPE            SLIP_TYPE
                 FROM FI_VAT_MASTER  FVM,
                      FI_SLIP_LINE   FSL,
                      FI_CREDIT_CARD CC
                WHERE FVM.CREDITCARD_CODE      = CC.CARD_CODE(+)
                  AND FVM.PERIOD_NAME   LIKE  W_PERIOD_NAME
                  AND FVM.VAT_GUBUN      = '1'
                  AND FVM.CONSIGNEE_ID  LIKE  W_CONSIGNEE_ID
                  AND FVM.SOB_ID         = W_SOB_ID
                  AND FSL.SLIP_LINE_ID   = FVM.SLIP_LINE_ID
                  AND FVM.SOB_ID         = FVM.SOB_ID
             )                C_CRD,
             FI_COMMON        FCM,
             FI_SUPP_CUST_V   FSV_C,
             FI_SUPP_CUST_V   FSV_S

       WHERE C_CRD.CONSIGNEE_ID  IN ( SELECT  OU.VAT_NUMBER
                                        FROM  HRM_OPERATING_UNIT OU
                                            , HRM_CORP_MASTER    CM
                                       WHERE  OU.CORP_ID       = CM.CORP_ID
                                         AND  OU.SOB_ID        = W_SOB_ID
                                         AND  OU.ORG_ID        = W_ORG_ID
                                         AND  CM.DEFAULT_FLAG  = 'Y'      )
         AND FCM.GROUP_CODE     = 'VOUCH_CODE'
         AND FCM.SOB_ID         = W_SOB_ID
         AND FCM.CODE           = C_CRD.VOUCH_CODE
         AND FSV_C.SUPP_CUST_ID = C_CRD.CONSIGNEE_ID
         AND FSV_C.SOB_ID       = W_SOB_ID
         AND FSV_S.SUPP_CUST_ID = C_CRD.SUPPLIER_ID
         AND FSV_S.SOB_ID       = W_SOB_ID ;



  END VAT_CARD_LIST_SELECT;

END FI_VAT_CARD_LIST_G; 
/
