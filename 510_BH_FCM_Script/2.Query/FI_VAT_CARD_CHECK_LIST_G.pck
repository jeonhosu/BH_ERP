create or replace package FI_VAT_CARD_CHECK_LIST_G is
--==============================================================================
-- Project      : FLEX ERP
-- Module       : FCMF
-- Program Name : FI_VAT_CARD_CHECK_LIST_G
-- Description  : Packing Box Define
--
-- Reference by :
-- Program History
--------------------------------------------------------------------------------
--   Date       In Charge          Description
--------------------------------------------------------------------------------
-- 03-DEC-2010  Sung Kil Te        Initialize
--==============================================================================

       PROCEDURE LU_CONSIGNEE_SELECT1( P_CURSOR                    OUT TYPES.TCURSOR
                                     , W_SOB_ID                    IN  FI_VAT_MASTER.SOB_ID%TYPE
                                     , W_ORG_ID                    IN  FI_VAT_MASTER.ORG_ID%TYPE
                                     );

       PROCEDURE VAT_CARD_CHECK_SELECT1( P_CURSOR                  OUT TYPES.TCURSOR
                                       , W_SOB_ID                  IN  FI_VAT_MASTER.SOB_ID%TYPE
                                       , W_ORG_ID                  IN  FI_VAT_MASTER.ORG_ID%TYPE
                                       , W_PERIOD_NAME             IN  FI_VAT_MASTER.PERIOD_NAME%TYPE
                                       , W_CONSIGNEE_ID            IN  FI_VAT_MASTER.CONSIGNEE_ID%TYPE
                                       );

end FI_VAT_CARD_CHECK_LIST_G;

 
/
create or replace package body FI_VAT_CARD_CHECK_LIST_G is
--==============================================================================
-- Project      : FLEX ERP
-- Module       : FCMF
-- Program Name : FI_VAT_CARD_CHECK_LIST_G
-- Description  : Packing Box Define
--
-- Reference by :
-- Program History
--------------------------------------------------------------------------------
--   Date       In Charge          Description
--------------------------------------------------------------------------------
-- 03-DEC-2010  Sung Kil Te        Initialize
--==============================================================================


       PROCEDURE LU_CONSIGNEE_SELECT1( P_CURSOR                    OUT TYPES.TCURSOR
                                     , W_SOB_ID                    IN  FI_VAT_MASTER.SOB_ID%TYPE
                                     , W_ORG_ID                    IN  FI_VAT_MASTER.ORG_ID%TYPE
                                     )

       IS

       BEGIN

                 OPEN P_CURSOR FOR
                 SELECT OU.VAT_NUMBER
                      , CM.CORP_NAME
                      , OU.CORP_ID
                   FROM HRM_OPERATING_UNIT   OU
                      , HRM_CORP_MASTER      CM
                  WHERE OU.CORP_ID        =  CM.CORP_ID
                    AND CM.DEFAULT_FLAG   = 'Y'
                    AND OU.SOB_ID         =  W_SOB_ID
                    AND OU.ORG_ID         =  W_ORG_ID
               ORDER BY CM.CORP_NAME
                      ;

       END;


       PROCEDURE VAT_CARD_CHECK_SELECT1( P_CURSOR                  OUT TYPES.TCURSOR
                                       , W_SOB_ID                  IN  FI_VAT_MASTER.SOB_ID%TYPE
                                       , W_ORG_ID                  IN  FI_VAT_MASTER.ORG_ID%TYPE
                                       , W_PERIOD_NAME             IN  FI_VAT_MASTER.PERIOD_NAME%TYPE
                                       , W_CONSIGNEE_ID            IN  FI_VAT_MASTER.CONSIGNEE_ID%TYPE
                                       )

       IS

       BEGIN

                 OPEN P_CURSOR FOR
                 SELECT FSV_C.TAX_REG_NO                 AS  CONSIGNEE_TAX_NUM     --사업자번호(Reg. Consignee TAX number)
                      , ROW_NUMBER() OVER (PARTITION BY C_CRD.CONSIGNEE_ID ORDER BY  C_CRD.GL_DATE, C_CRD.ISSUE_DATE, C_CRD.SLIP_DATE, C_CRD.SLIP_NUM)  AS  ROW_NUM
                      , C_CRD.GL_DATE                    AS  GL_DATE               --회계일자(Acc. date)
                      , C_CRD.CREDIT_CARD_NUM            AS  CREDIT_CARD_NUM       --카드번호(Credit card number)
                      , FSV_S.SUPP_CUST_NAME             AS  SUPPLIER_CORP         --공급자명(Supplier name)
                      , FSV_S.PRESIDENT_NAME             AS  SUPP_PRESIDENT_NAME   --대표자명(Owner)
                      , DECODE(NVL(FSV_S.ADDRESS_2, '1'), '1', FSV_S.ADDRESS_1, FSV_S.ADDRESS_1 || ' ' || FSV_S.ADDRESS_2)  AS  SUPP_ADDRESS  --주소(Address)
                      , C_CRD.GL_AMOUNT                  AS  GL_AMOUNT             --공급가액(Sale amount)
                      , C_CRD.VAT_AMOUNT                 AS  VAT_AMOUNT            --부가세(Tax amount)
                      , C_CRD.VOUCH_CODE                 AS  VOUCH_CODE
                      , FCM.CODE_NAME                    AS  VOUCH_CODE_NAME       --증빙(Vouch name)
                      , C_CRD.SLIP_NUM                   AS  SLIP_NUM              --건수(Slip count)
                      , C_CRD.ISSUE_DATE                 AS  ISSUE_DATE            --계산서일자(Issue date)
                      , C_CRD.SLIP_TYPE                  AS  SLIP_TYPE
                      , C_CRD.CONSIGNEE_ID               AS  CONSIGNEE_ID
                      , C_CRD.SUPPLIER_ID                AS  SUPPLIER_ID
                   FROM (SELECT FVM.CONSIGNEE_ID         AS  CONSIGNEE_ID
                              , CC.CARD_NUM              AS  CREDIT_CARD_NUM
                              , FVM.GL_DATE              AS  GL_DATE
                              , FVM.SUPPLIER_ID          AS  SUPPLIER_ID
                              , FVM.GL_AMOUNT            AS  GL_AMOUNT
                              , FVM.VAT_AMOUNT           AS  VAT_AMOUNT
                              , FVM.VOUCH_CODE           AS  VOUCH_CODE
                              , FSL.SLIP_DATE            AS  SLIP_DATE
                              , FSL.SLIP_NUM             AS  SLIP_NUM
                              , FVM.VAT_ISSUE_DATE       AS  ISSUE_DATE
                              , FSL.SLIP_TYPE            AS  SLIP_TYPE
                           FROM FI_VAT_MASTER                FVM
                              , FI_SLIP_LINE                 FSL
                              , FI_CREDIT_CARD               CC
                          WHERE FSL.SLIP_LINE_ID          =  FVM.SLIP_LINE_ID
                            AND FVM.SOB_ID                =  FVM.SOB_ID                            
                            AND FVM.VAT_GUBUN             = '1'
                            AND FVM.CREDITCARD_CODE       = CC.CARD_CODE(+)
                            AND FVM.SOB_ID                = CC.SOB_ID(+)
                            AND FVM.SOB_ID                =  W_SOB_ID
                            AND FVM.PERIOD_NAME           =  NVL(W_PERIOD_NAME, FVM.PERIOD_NAME)
                            AND FVM.CONSIGNEE_ID          =  NVL(W_CONSIGNEE_ID, FVM.CONSIGNEE_ID)
                        )                                    C_CRD
                      , FI_COMMON                            FCM
                      , FI_SUPP_CUST_V                       FSV_C
                      , FI_SUPP_CUST_V                       FSV_S
                  WHERE C_CRD.CONSIGNEE_ID  IN (SELECT OU.VAT_NUMBER
                                                  FROM HRM_OPERATING_UNIT   OU
                                                     , HRM_CORP_MASTER      CM
                                                 WHERE OU.CORP_ID        =  CM.CORP_ID
                                                   AND CM.DEFAULT_FLAG   = 'Y'
                                                   AND OU.SOB_ID         =  W_SOB_ID
                                                   AND OU.ORG_ID         =  W_ORG_ID
                                               )
                    AND FCM.CODE            =  C_CRD.VOUCH_CODE
                    AND FSV_C.SUPP_CUST_ID  =  C_CRD.CONSIGNEE_ID
                    AND FSV_S.SUPP_CUST_ID  =  C_CRD.SUPPLIER_ID
                    AND FCM.GROUP_CODE      = 'VOUCH_CODE'
                    AND FCM.SOB_ID          =  W_SOB_ID
                    AND FSV_C.SOB_ID        =  W_SOB_ID
                    AND FSV_S.SOB_ID        =  W_SOB_ID
                      ;

       END;


END FI_VAT_CARD_CHECK_LIST_G;
/
