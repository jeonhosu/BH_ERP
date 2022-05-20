CREATE OR REPLACE PACKAGE AP_SUPPLIER_G IS
/******************************************************************************/
/* Project      : FLEX ERP
/* Module       : FCM
/* Program Name : AP_SUPPLIER_G
/* Description  : SUPPLIER MASTER
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Shin Man Jae       Initialize
/******************************************************************************/

 PROCEDURE AP_SUPPLIER_SELECT ( P_CURSOR                OUT  TYPES.TCURSOR
                              , W_SOB_ID                IN   NUMBER
                              , W_ORG_ID                IN   NUMBER
                              , W_SUPPLIER_ID           IN   NUMBER
                              , W_SUPPLIER_CLASS_CODE  IN EAPP_LOOKUP_ENTRY.ENTRY_CODE%TYPE
                              , W_SUPPLIER_TYPE_CODE   IN EAPP_LOOKUP_ENTRY.ENTRY_CODE%TYPE
                              )  ;

 PROCEDURE AP_SUPPLIER_INSERT ( P_SUPPLIER_ID              OUT NUMBER
                              ,  P_SOB_ID                   IN  NUMBER
                              ,  P_ORG_ID                   IN  NUMBER
                              ,  P_SUPPLIER_CODE            IN  AP_SUPPLIER.SUPPLIER_CODE%TYPE
                              ,  P_SUPPLIER_FULL_NAME       IN  AP_SUPPLIER.SUPPLIER_FULL_NAME%TYPE
                              ,  P_SUPPLIER_SHORT_NAME      IN  AP_SUPPLIER.SUPPLIER_SHORT_NAME%TYPE
                              ,  P_SUPPLIER_CLASS_CODE      IN  AP_SUPPLIER.SUPPLIER_CLASS_CODE%TYPE
                              ,  P_SUPPLIER_TYPE_CODE       IN  AP_SUPPLIER.SUPPLIER_TYPE_CODE%TYPE
                              ,  P_TAX_REG_NO               IN  AP_SUPPLIER.TAX_REG_NO%TYPE
                              ,  P_COUNTRY_CODE             IN  AP_SUPPLIER.COUNTRY_CODE%TYPE
                              ,  P_ZIP_CODE                 IN  AP_SUPPLIER.ZIP_CODE%TYPE
                              ,  P_ADDRESS_1                IN  AP_SUPPLIER.ADDRESS_1%TYPE
                              ,  P_ADDRESS_2                IN  AP_SUPPLIER.ADDRESS_2%TYPE
                              ,  P_PRESIDENT_NAME           IN  AP_SUPPLIER.PRESIDENT_NAME%TYPE
                              ,  P_BUSINESS_TYPE_LCODE      IN  AP_SUPPLIER.BUSINESS_TYPE_LCODE%TYPE
                              ,  P_BUSINESS_CONDITION       IN  AP_SUPPLIER.BUSINESS_CONDITION%TYPE
                              ,  P_BUSINESS_ITEM            IN  AP_SUPPLIER.BUSINESS_ITEM%TYPE
                              ,  P_PO_ENABLED_FLAG          IN  AP_SUPPLIER.PO_ENABLED_FLAG%TYPE
                              ,  P_PO_PERSON_ID             IN  AP_SUPPLIER.PO_PERSON_ID%TYPE
                              ,  P_PRIMARY_CURRENCY_CODE    IN  AP_SUPPLIER.PRIMARY_CURRENCY_CODE%TYPE
                              ,  P_PO_LIMIT_AMOUNT          IN  AP_SUPPLIER.PO_LIMIT_AMOUNT%TYPE
                              ,  P_CREDIT_LIMIT_AMOUNT      IN  AP_SUPPLIER.CREDIT_LIMIT_AMOUNT%TYPE
                              ,  P_PRICE_TERM_ID            IN  AP_SUPPLIER.PRICE_TERM_ID%TYPE
                              ,  P_PAYMENT_METHOD_ID        IN  AP_SUPPLIER.PAYMENT_METHOD_ID%TYPE
                              ,  P_PAYMENT_TERM_ID          IN  AP_SUPPLIER.PAYMENT_TERM_ID%TYPE
                              ,  P_SHIPPING_METHOD_LCODE    IN  AP_SUPPLIER.SHIPPING_METHOD_LCODE%TYPE
                              ,  P_LOADING_PORT_ID          IN  AP_SUPPLIER.LOADING_PORT_ID%TYPE
                              ,  P_DESTINATION_PORT_ID      IN  AP_SUPPLIER.DESTINATION_PORT_ID%TYPE
                              ,  P_FORWARDER_ID             IN  AP_SUPPLIER.FORWARDER_ID%TYPE
                              , P_EFFECTIVE_DATE_FR        IN  AP_SUPPLIER.EFFECTIVE_DATE_FR%TYPE
                              , P_EFFECTIVE_DATE_TO        IN  AP_SUPPLIER.EFFECTIVE_DATE_TO%TYPE
                              , P_ENABLED_FLAG             IN  AP_SUPPLIER.ENABLED_FLAG%TYPE
                              ,  P_ATTRIBUTE_A              IN  AP_SUPPLIER.ATTRIBUTE_A%TYPE
                              ,  P_ATTRIBUTE_B              IN  AP_SUPPLIER.ATTRIBUTE_B%TYPE
                              ,  P_ATTRIBUTE_C              IN  AP_SUPPLIER.ATTRIBUTE_C%TYPE
                              ,  P_ATTRIBUTE_D              IN  AP_SUPPLIER.ATTRIBUTE_D%TYPE
                              ,  P_ATTRIBUTE_E              IN  AP_SUPPLIER.ATTRIBUTE_E%TYPE
                              ,  P_ATTRIBUTE_F              IN  AP_SUPPLIER.ATTRIBUTE_F%TYPE
                              ,  P_ATTRIBUTE_G              IN  AP_SUPPLIER.ATTRIBUTE_G%TYPE
                              ,  P_ATTRIBUTE_H              IN  AP_SUPPLIER.ATTRIBUTE_H%TYPE
                              ,  P_ATTRIBUTE_1              IN  AP_SUPPLIER.ATTRIBUTE_1%TYPE
                              ,  P_ATTRIBUTE_2              IN  AP_SUPPLIER.ATTRIBUTE_2%TYPE
                              ,  P_ATTRIBUTE_3              IN  AP_SUPPLIER.ATTRIBUTE_3%TYPE
                              ,  P_ATTRIBUTE_4              IN  AP_SUPPLIER.ATTRIBUTE_4%TYPE
                              ,  P_ATTRIBUTE_5              IN  AP_SUPPLIER.ATTRIBUTE_5%TYPE
                              ,  P_ATTRIBUTE_6              IN  AP_SUPPLIER.ATTRIBUTE_6%TYPE
                              ,  P_ATTRIBUTE_7              IN  AP_SUPPLIER.ATTRIBUTE_7%TYPE
                              , P_USER_ID                  IN  NUMBER
                              ,  O_SUPPLIER_CODE            OUT AP_SUPPLIER.SUPPLIER_CODE%TYPE
                              );

 PROCEDURE AP_SUPPLIER_UPDATE ( W_SUPPLIER_ID              IN NUMBER
                              ,  P_SOB_ID                   IN  NUMBER
                              ,  P_SUPPLIER_FULL_NAME       IN  AP_SUPPLIER.SUPPLIER_FULL_NAME%TYPE
                              ,  P_SUPPLIER_SHORT_NAME      IN  AP_SUPPLIER.SUPPLIER_SHORT_NAME%TYPE
                              ,  P_SUPPLIER_CLASS_CODE      IN  AP_SUPPLIER.SUPPLIER_CLASS_CODE%TYPE
                              ,  P_SUPPLIER_TYPE_CODE       IN  AP_SUPPLIER.SUPPLIER_TYPE_CODE%TYPE
                              ,  P_TAX_REG_NO               IN  AP_SUPPLIER.TAX_REG_NO%TYPE
                              ,  P_COUNTRY_CODE             IN  AP_SUPPLIER.COUNTRY_CODE%TYPE
                              ,  P_ZIP_CODE                 IN  AP_SUPPLIER.ZIP_CODE%TYPE
                              ,  P_ADDRESS_1                IN  AP_SUPPLIER.ADDRESS_1%TYPE
                              ,  P_ADDRESS_2                IN  AP_SUPPLIER.ADDRESS_2%TYPE
                              ,  P_PRESIDENT_NAME           IN  AP_SUPPLIER.PRESIDENT_NAME%TYPE
                              ,  P_BUSINESS_TYPE_LCODE      IN  AP_SUPPLIER.BUSINESS_TYPE_LCODE%TYPE
                              ,  P_BUSINESS_CONDITION       IN  AP_SUPPLIER.BUSINESS_CONDITION%TYPE
                              ,  P_BUSINESS_ITEM            IN  AP_SUPPLIER.BUSINESS_ITEM%TYPE
                              ,  P_PO_ENABLED_FLAG          IN  AP_SUPPLIER.PO_ENABLED_FLAG%TYPE
                              ,  P_PO_PERSON_ID             IN  AP_SUPPLIER.PO_PERSON_ID%TYPE
                              ,  P_PRIMARY_CURRENCY_CODE    IN  AP_SUPPLIER.PRIMARY_CURRENCY_CODE%TYPE
                              ,  P_PO_LIMIT_AMOUNT          IN  AP_SUPPLIER.PO_LIMIT_AMOUNT%TYPE
                              ,  P_CREDIT_LIMIT_AMOUNT      IN  AP_SUPPLIER.CREDIT_LIMIT_AMOUNT%TYPE
                              ,  P_PRICE_TERM_ID            IN  AP_SUPPLIER.PRICE_TERM_ID%TYPE
                              ,  P_PAYMENT_METHOD_ID        IN  AP_SUPPLIER.PAYMENT_METHOD_ID%TYPE
                              ,  P_PAYMENT_TERM_ID          IN  AP_SUPPLIER.PAYMENT_TERM_ID%TYPE
                              ,  P_SHIPPING_METHOD_LCODE    IN  AP_SUPPLIER.SHIPPING_METHOD_LCODE%TYPE
                              ,  P_LOADING_PORT_ID          IN  AP_SUPPLIER.LOADING_PORT_ID%TYPE
                              ,  P_DESTINATION_PORT_ID      IN  AP_SUPPLIER.DESTINATION_PORT_ID%TYPE
                              ,  P_FORWARDER_ID             IN  AP_SUPPLIER.FORWARDER_ID%TYPE
                              , P_EFFECTIVE_DATE_FR        IN  AP_SUPPLIER.EFFECTIVE_DATE_FR%TYPE
                              , P_EFFECTIVE_DATE_TO        IN  AP_SUPPLIER.EFFECTIVE_DATE_TO%TYPE
                              , P_ENABLED_FLAG             IN  AP_SUPPLIER.ENABLED_FLAG%TYPE
                              ,  P_ATTRIBUTE_A              IN  AP_SUPPLIER.ATTRIBUTE_A%TYPE
                              ,  P_ATTRIBUTE_B              IN  AP_SUPPLIER.ATTRIBUTE_B%TYPE
                              ,  P_ATTRIBUTE_C              IN  AP_SUPPLIER.ATTRIBUTE_C%TYPE
                              ,  P_ATTRIBUTE_D              IN  AP_SUPPLIER.ATTRIBUTE_D%TYPE
                              ,  P_ATTRIBUTE_E              IN  AP_SUPPLIER.ATTRIBUTE_E%TYPE
                              ,  P_ATTRIBUTE_F              IN  AP_SUPPLIER.ATTRIBUTE_F%TYPE
                              ,  P_ATTRIBUTE_G              IN  AP_SUPPLIER.ATTRIBUTE_G%TYPE
                              ,  P_ATTRIBUTE_H              IN  AP_SUPPLIER.ATTRIBUTE_H%TYPE
                              ,  P_ATTRIBUTE_1              IN  AP_SUPPLIER.ATTRIBUTE_1%TYPE
                              ,  P_ATTRIBUTE_2              IN  AP_SUPPLIER.ATTRIBUTE_2%TYPE
                              ,  P_ATTRIBUTE_3              IN  AP_SUPPLIER.ATTRIBUTE_3%TYPE
                              ,  P_ATTRIBUTE_4              IN  AP_SUPPLIER.ATTRIBUTE_4%TYPE
                              ,  P_ATTRIBUTE_5              IN  AP_SUPPLIER.ATTRIBUTE_5%TYPE
                              ,  P_ATTRIBUTE_6              IN  AP_SUPPLIER.ATTRIBUTE_6%TYPE
                              ,  P_ATTRIBUTE_7              IN  AP_SUPPLIER.ATTRIBUTE_7%TYPE
                              , P_USER_ID                  IN  NUMBER
                              );

 PROCEDURE AP_SUPPLIER_DELETE ( W_SUPPLIER_ID   IN   NUMBER);


 ------------------------------
 -- 구매처 계좌정보 SELECT   --
 ------------------------------
 PROCEDURE AP_SUP_BANK_ACCT_INFO( P_CURSOR                OUT  TYPES.TCURSOR
                                 , W_SUPPLIER_ID          IN   NUMBER
                                 );

-- 은행계좌 삽입.
  PROCEDURE AP_SUP_BANK_ACCT_INSERT
            ( P_BANK_ACCOUNT_ID      OUT FI_BANK_ACCOUNT.BANK_ACCOUNT_ID%TYPE
            , P_SOB_ID               IN FI_BANK_ACCOUNT.SOB_ID%TYPE
            , P_ORG_ID               IN FI_BANK_ACCOUNT.ORG_ID%TYPE
            , P_BANK_ACCOUNT_CODE    IN FI_BANK_ACCOUNT.BANK_ACCOUNT_CODE%TYPE
            , P_BANK_ACCOUNT_NAME    IN FI_BANK_ACCOUNT.BANK_ACCOUNT_NAME%TYPE
            , P_BANK_ID              IN FI_BANK_ACCOUNT.BANK_ID%TYPE
            , P_BANK_ACCOUNT_NUM     IN FI_BANK_ACCOUNT.BANK_ACCOUNT_NUM%TYPE
            , P_OWNER_NAME           IN FI_BANK_ACCOUNT.OWNER_NAME%TYPE
            , P_ACCOUNT_TYPE         IN FI_BANK_ACCOUNT.ACCOUNT_TYPE%TYPE
            , P_CURRENCY_CODE        IN FI_BANK_ACCOUNT.CURRENCY_CODE%TYPE
            , P_SUPPLIER_CUSTOMER_ID IN FI_BANK_ACCOUNT.SUPPLIER_CUSTOMER_ID%TYPE
            , P_REMARK               IN FI_BANK_ACCOUNT.REMARK%TYPE
            , P_ENABLED_FLAG         IN FI_BANK_ACCOUNT.ENABLED_FLAG%TYPE
            , P_EFFECTIVE_DATE_FR    IN FI_BANK_ACCOUNT.EFFECTIVE_DATE_FR%TYPE
            , P_EFFECTIVE_DATE_TO    IN FI_BANK_ACCOUNT.EFFECTIVE_DATE_TO%TYPE
            , P_USER_ID              IN FI_BANK_ACCOUNT.CREATED_BY%TYPE
            );

-- 은행계좌 수정.
  PROCEDURE AP_SUP_BANK_ACCT_UPDATE
            ( W_BANK_ACCOUNT_ID      IN FI_BANK_ACCOUNT.BANK_ACCOUNT_ID%TYPE
            , P_BANK_ACCOUNT_NAME    IN FI_BANK_ACCOUNT.BANK_ACCOUNT_NAME%TYPE
            , P_BANK_ACCOUNT_NUM     IN FI_BANK_ACCOUNT.BANK_ACCOUNT_NUM%TYPE
            , P_OWNER_NAME           IN FI_BANK_ACCOUNT.OWNER_NAME%TYPE
            , P_ACCOUNT_TYPE         IN FI_BANK_ACCOUNT.ACCOUNT_TYPE%TYPE
            , P_CURRENCY_CODE        IN FI_BANK_ACCOUNT.CURRENCY_CODE%TYPE
            , P_REMARK               IN FI_BANK_ACCOUNT.REMARK%TYPE
            , P_ENABLED_FLAG         IN FI_BANK_ACCOUNT.ENABLED_FLAG%TYPE
            , P_EFFECTIVE_DATE_FR    IN FI_BANK_ACCOUNT.EFFECTIVE_DATE_FR%TYPE
            , P_EFFECTIVE_DATE_TO    IN FI_BANK_ACCOUNT.EFFECTIVE_DATE_TO%TYPE
            , P_USER_ID              IN FI_BANK_ACCOUNT.CREATED_BY%TYPE
            );


 --------------------------------------
 -- SUPPLIER_CODE Duplication check  --
 --------------------------------------
 PROCEDURE CHK_SUPPLIER_CODE_DUP ( P_SOB_ID          IN   NUMBER
                                 , P_ORG_ID          IN   NUMBER
                                 , P_SUPPLIER_CODE   IN   AP_SUPPLIER.SUPPLIER_CODE%TYPE
                                 , X_CHECK_RESULT    OUT  VARCHAR2) ;

 --------------------------------------
 -- TAX_REG_NO Duplication check     --
 --------------------------------------
 PROCEDURE CHK_TAX_REG_NO_DUP ( P_SOB_ID          IN   NUMBER
                              , P_ORG_ID          IN   NUMBER
                              , P_TAX_REG_NO      IN   AP_SUPPLIER.TAX_REG_NO%TYPE
                              , X_CHECK_RESULT    OUT  VARCHAR2);


END AP_SUPPLIER_G; 
/
CREATE OR REPLACE PACKAGE BODY AP_SUPPLIER_G IS
/******************************************************************************/
/* Project      : FLEX ERP
/* Module       : FCM
/* Program Name : AP_SUPPLIER_G
/* Description  : SUPPLIER MASTER
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Shin Man Jae       Initialize
/******************************************************************************/

 --------------
 -- SELECT   --
 --------------
 PROCEDURE AP_SUPPLIER_SELECT ( P_CURSOR                OUT  TYPES.TCURSOR
                              , W_SOB_ID                IN   NUMBER
                              , W_ORG_ID                IN   NUMBER
                              , W_SUPPLIER_ID           IN   NUMBER
                              , W_SUPPLIER_CLASS_CODE  IN EAPP_LOOKUP_ENTRY.ENTRY_CODE%TYPE
                              , W_SUPPLIER_TYPE_CODE   IN EAPP_LOOKUP_ENTRY.ENTRY_CODE%TYPE
                              )
 IS
 BEGIN

       OPEN P_CURSOR FOR
       SELECT APS.SUPPLIER_ID
            ,	APS.SOB_ID
            ,	APS.ORG_ID
            ,	APS.SUPPLIER_CODE
            ,	APS.SUPPLIER_FULL_NAME
            ,	APS.SUPPLIER_SHORT_NAME
            ,	APS.SUPPLIER_CLASS_CODE
            , (SELECT ASCL.DESCRIPTION
                 FROM AP_SUPPLIER_CLASS  ASCL
                WHERE ASCL.SOB_ID        = APS.SOB_ID
                  AND ASCL.ORG_ID        = APS.ORG_ID
                  AND ASCL.SUPPLIER_CLASS_CODE = APS.SUPPLIER_CLASS_CODE)  AS SUPPLIER_CLASS_DESC
            ,	APS.SUPPLIER_TYPE_CODE
            , (SELECT AST.DESCRIPTION
                 FROM AP_SUPPLIER_TYPE  AST
                WHERE AST.SOB_ID        = APS.SOB_ID
                  AND AST.ORG_ID        = APS.ORG_ID
                  AND AST.SUPPLIER_TYPE_CODE = APS.SUPPLIER_TYPE_CODE)     AS SUPPLIER_TYPE_DESC
            ,	APS.TAX_REG_NO
            ,	APS.COUNTRY_CODE
            , EC.COUNTRY_SHORT_NAME
            ,	APS.ZIP_CODE
            ,	APS.ADDRESS_1
            ,	APS.ADDRESS_2
            ,	APS.PRESIDENT_NAME
            ,	APS.BUSINESS_TYPE_LCODE
            , ELE_BT.ENTRY_DESCRIPTION   BUSINESS_TYPE_DESC
            ,	APS.BUSINESS_CONDITION
            ,	APS.BUSINESS_ITEM
            ,	APS.PO_ENABLED_FLAG
            ,	APS.PO_PERSON_ID
            , HPM.DISPLAY_NAME           PERSON_NAME
            ,	APS.PRIMARY_CURRENCY_CODE
            ,	APS.PO_LIMIT_AMOUNT
            ,	APS.CREDIT_LIMIT_AMOUNT
            ,	APS.PRICE_TERM_ID
            , EPT.PRICE_TERM_TYPE
            ,	APS.PAYMENT_METHOD_ID
            , EPM.PAYMENT_METHOD_TYPE
            ,	APS.PAYMENT_TERM_ID
            , EPA.PAYMENT_TERM_TYPE
            ,	APS.SHIPPING_METHOD_LCODE
            , ELE_SM.ENTRY_DESCRIPTION   SHIPPING_METHOD_DESC
            ,	APS.LOADING_PORT_ID
            , EPL.PORT_CODE              LOADING_PORT_CODE
            , EPL.PORT_DESCRIPTION       LOADING_PORT_DESC
            ,	APS.DESTINATION_PORT_ID
            , EPD.PORT_CODE              DESTINATION_PORT_CODE
            , EPD.PORT_DESCRIPTION       DESTINATION_PORT_DESC
            ,	APS.FORWARDER_ID
            , ASF.SUPPLIER_CODE          FORWARDER_CODE
            , ASF.SUPPLIER_SHORT_NAME    FORWARDER_NAME
            , APS.EFFECTIVE_DATE_FR
            , APS.EFFECTIVE_DATE_TO
            , APS.ENABLED_FLAG
            ,	APS.ATTRIBUTE_A
            ,	APS.ATTRIBUTE_B
            ,	APS.ATTRIBUTE_C
            ,	APS.ATTRIBUTE_D
            ,	APS.ATTRIBUTE_E
            ,	APS.ATTRIBUTE_F
            ,	APS.ATTRIBUTE_G
            ,	APS.ATTRIBUTE_H
            ,	APS.ATTRIBUTE_1
            ,	APS.ATTRIBUTE_2
            ,	APS.ATTRIBUTE_3
            ,	APS.ATTRIBUTE_4
            ,	APS.ATTRIBUTE_5
            ,	APS.ATTRIBUTE_6
            ,	APS.ATTRIBUTE_7
            ,	APS.CREATION_DATE
            ,	APS.CREATED_BY
            ,	APS.LAST_UPDATE_DATE
            ,	APS.LAST_UPDATED_BY
         FROM AP_SUPPLIER            APS
            , EAPP_COUNTRY           EC
            , HRM_PERSON_MASTER      HPM
            , EAPP_PRICE_TERM        EPT
            , EAPP_PAYMENT_METHOD    EPM
            , EAPP_PAYMENT_TERM      EPA
            , EAPP_PORT              EPL
            , EAPP_PORT              EPD
            , AP_SUPPLIER            ASF
            , EAPP_LOOKUP_ENTRY_TLV  ELE_SM
            , EAPP_LOOKUP_ENTRY_TLV  ELE_BT
        WHERE EC.SOB_ID(+)             = APS.SOB_ID
          AND EC.ORG_ID(+)             = APS.ORG_ID
          AND EC.COUNTRY_CODE(+)       = APS.COUNTRY_CODE
          AND HPM.PERSON_ID(+)         = APS.PO_PERSON_ID
          AND EPT.PRICE_TERM_ID(+)     = APS.PRICE_TERM_ID
          AND EPM.PAYMENT_METHOD_ID(+) = APS.PAYMENT_METHOD_ID
          AND EPA.PAYMENT_TERM_ID(+)   = APS.PAYMENT_TERM_ID
          AND EPL.PORT_ID(+)           = APS.LOADING_PORT_ID
          AND EPD.PORT_ID(+)           = APS.DESTINATION_PORT_ID
          AND ASF.SUPPLIER_ID(+)       = APS.FORWARDER_ID
          AND ELE_SM.SOB_ID(+)         = APS.SOB_ID
          AND ELE_SM.ORG_ID(+)         = APS.ORG_ID
          AND ELE_SM.LOOKUP_TYPE(+)    = 'SHIPPING_METHOD'
          AND ELE_SM.ENTRY_CODE(+)     = APS.SHIPPING_METHOD_LCODE
          AND ELE_BT.SOB_ID(+)         = APS.SOB_ID
          AND ELE_BT.ORG_ID(+)         = APS.ORG_ID
          AND ELE_BT.LOOKUP_TYPE(+)    = 'BUSINESS_TYPE'
          AND ELE_BT.ENTRY_CODE(+)     = APS.BUSINESS_TYPE_LCODE
          AND APS.SOB_ID               = W_SOB_ID
          AND APS.ORG_ID               = W_ORG_ID
          AND APS.SUPPLIER_CLASS_CODE = NVL(W_SUPPLIER_CLASS_CODE, APS.SUPPLIER_CLASS_CODE)
          AND APS.SUPPLIER_TYPE_CODE  = NVL(W_SUPPLIER_TYPE_CODE, APS.SUPPLIER_TYPE_CODE)
          AND APS.SUPPLIER_ID          = NVL(W_SUPPLIER_ID, APS.SUPPLIER_ID)
        ORDER BY APS.SUPPLIER_SHORT_NAME
       ;


 END AP_SUPPLIER_SELECT;


 --------------
 -- INSERT   --
 --------------
 PROCEDURE AP_SUPPLIER_INSERT ( P_SUPPLIER_ID              OUT NUMBER
                              ,	P_SOB_ID                   IN  NUMBER
                              ,	P_ORG_ID                   IN  NUMBER
                              ,	P_SUPPLIER_CODE            IN  AP_SUPPLIER.SUPPLIER_CODE%TYPE
                              ,	P_SUPPLIER_FULL_NAME       IN  AP_SUPPLIER.SUPPLIER_FULL_NAME%TYPE
                              ,	P_SUPPLIER_SHORT_NAME      IN  AP_SUPPLIER.SUPPLIER_SHORT_NAME%TYPE
                              ,	P_SUPPLIER_CLASS_CODE      IN  AP_SUPPLIER.SUPPLIER_CLASS_CODE%TYPE
                              ,	P_SUPPLIER_TYPE_CODE       IN  AP_SUPPLIER.SUPPLIER_TYPE_CODE%TYPE
                              ,	P_TAX_REG_NO               IN  AP_SUPPLIER.TAX_REG_NO%TYPE
                              ,	P_COUNTRY_CODE             IN  AP_SUPPLIER.COUNTRY_CODE%TYPE
                              ,	P_ZIP_CODE                 IN  AP_SUPPLIER.ZIP_CODE%TYPE
                              ,	P_ADDRESS_1                IN  AP_SUPPLIER.ADDRESS_1%TYPE
                              ,	P_ADDRESS_2                IN  AP_SUPPLIER.ADDRESS_2%TYPE
                              ,	P_PRESIDENT_NAME           IN  AP_SUPPLIER.PRESIDENT_NAME%TYPE
                              ,	P_BUSINESS_TYPE_LCODE      IN  AP_SUPPLIER.BUSINESS_TYPE_LCODE%TYPE
                              ,	P_BUSINESS_CONDITION       IN  AP_SUPPLIER.BUSINESS_CONDITION%TYPE
                              ,	P_BUSINESS_ITEM            IN  AP_SUPPLIER.BUSINESS_ITEM%TYPE
                              ,	P_PO_ENABLED_FLAG          IN  AP_SUPPLIER.PO_ENABLED_FLAG%TYPE
                              ,	P_PO_PERSON_ID             IN  AP_SUPPLIER.PO_PERSON_ID%TYPE
                              ,	P_PRIMARY_CURRENCY_CODE    IN  AP_SUPPLIER.PRIMARY_CURRENCY_CODE%TYPE
                              ,	P_PO_LIMIT_AMOUNT          IN  AP_SUPPLIER.PO_LIMIT_AMOUNT%TYPE
                              ,	P_CREDIT_LIMIT_AMOUNT      IN  AP_SUPPLIER.CREDIT_LIMIT_AMOUNT%TYPE
                              ,	P_PRICE_TERM_ID            IN  AP_SUPPLIER.PRICE_TERM_ID%TYPE
                              ,	P_PAYMENT_METHOD_ID        IN  AP_SUPPLIER.PAYMENT_METHOD_ID%TYPE
                              ,	P_PAYMENT_TERM_ID          IN  AP_SUPPLIER.PAYMENT_TERM_ID%TYPE
                              ,	P_SHIPPING_METHOD_LCODE    IN  AP_SUPPLIER.SHIPPING_METHOD_LCODE%TYPE
                              ,	P_LOADING_PORT_ID          IN  AP_SUPPLIER.LOADING_PORT_ID%TYPE
                              ,	P_DESTINATION_PORT_ID      IN  AP_SUPPLIER.DESTINATION_PORT_ID%TYPE
                              ,	P_FORWARDER_ID             IN  AP_SUPPLIER.FORWARDER_ID%TYPE
                              , P_EFFECTIVE_DATE_FR        IN  AP_SUPPLIER.EFFECTIVE_DATE_FR%TYPE
                              , P_EFFECTIVE_DATE_TO        IN  AP_SUPPLIER.EFFECTIVE_DATE_TO%TYPE
                              , P_ENABLED_FLAG             IN  AP_SUPPLIER.ENABLED_FLAG%TYPE
                              ,	P_ATTRIBUTE_A              IN  AP_SUPPLIER.ATTRIBUTE_A%TYPE
                              ,	P_ATTRIBUTE_B              IN  AP_SUPPLIER.ATTRIBUTE_B%TYPE
                              ,	P_ATTRIBUTE_C              IN  AP_SUPPLIER.ATTRIBUTE_C%TYPE
                              ,	P_ATTRIBUTE_D              IN  AP_SUPPLIER.ATTRIBUTE_D%TYPE
                              ,	P_ATTRIBUTE_E              IN  AP_SUPPLIER.ATTRIBUTE_E%TYPE
                              ,	P_ATTRIBUTE_F              IN  AP_SUPPLIER.ATTRIBUTE_F%TYPE
                              ,	P_ATTRIBUTE_G              IN  AP_SUPPLIER.ATTRIBUTE_G%TYPE
                              ,	P_ATTRIBUTE_H              IN  AP_SUPPLIER.ATTRIBUTE_H%TYPE
                              ,	P_ATTRIBUTE_1              IN  AP_SUPPLIER.ATTRIBUTE_1%TYPE
                              ,	P_ATTRIBUTE_2              IN  AP_SUPPLIER.ATTRIBUTE_2%TYPE
                              ,	P_ATTRIBUTE_3              IN  AP_SUPPLIER.ATTRIBUTE_3%TYPE
                              ,	P_ATTRIBUTE_4              IN  AP_SUPPLIER.ATTRIBUTE_4%TYPE
                              ,	P_ATTRIBUTE_5              IN  AP_SUPPLIER.ATTRIBUTE_5%TYPE
                              ,	P_ATTRIBUTE_6              IN  AP_SUPPLIER.ATTRIBUTE_6%TYPE
                              ,	P_ATTRIBUTE_7              IN  AP_SUPPLIER.ATTRIBUTE_7%TYPE
                              , P_USER_ID                  IN  NUMBER
                              ,	O_SUPPLIER_CODE            OUT AP_SUPPLIER.SUPPLIER_CODE%TYPE
                              )
 IS

       V_LOCAL_DATE        DATE := GET_LOCAL_DATE(P_SOB_ID);
       V_QTY               NUMBER := 0;
       V_SOB_COUNTRY_CODE  VARCHAR2(50);
 BEGIN
       -- 사업자번호 중복체크--
       -- 국내일 경우에만 처리 --
       BEGIN
            SELECT SOB.COUNTRY_CODE
              INTO V_SOB_COUNTRY_CODE
              FROM EAPP_SET_OF_BOOKS SOB
             WHERE SOB.SOB_ID        = P_SOB_ID
               AND ROWNUM            = 1
               ;
       EXCEPTION WHEN OTHERS THEN
           V_SOB_COUNTRY_CODE := NULL;
       END;
       
       IF V_SOB_COUNTRY_CODE = P_COUNTRY_CODE THEN
           BEGIN
                 SELECT COUNT(*)
                   INTO V_QTY
                   FROM FI_SUPP_CUST_V  V
                  WHERE V.SOB_ID         = P_SOB_ID
                    AND V.ORG_ID         = P_ORG_ID
                    AND V.SUPP_CUST_TYPE = 'S'
                    AND REPLACE(V.TAX_REG_NO, '-', '')  = P_TAX_REG_NO
                  ;
           EXCEPTION WHEN OTHERS THEN
                V_QTY := 0;
           END;
           IF NVL(V_QTY,0) > 0 THEN
               RAISE_APPLICATION_ERROR(-20011, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_90003', '&&FIELD_NAME:= ' || 'TAX REGISTER NO' ));
           END IF;
           
           -- 사업자번호 검증.
           IF REPLACE(P_TAX_REG_NO, '-', '') IS NOT NULL THEN
             IF EAPP_NUM_DIGIT_CHECKER_G.CHECK_TAX_NUM_F(P_TAX_REG_NO) = 'N' THEN
               RAISE_APPLICATION_ERROR(-20011, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10009', NULL));
             END IF;
           END IF;
       END IF;
       
       IF P_SUPPLIER_CODE IS NULL THEN
           AR_CUSTOMER_SITE_G.FIND_MAX_CODE(P_SOB_ID, P_ORG_ID, 'S', O_SUPPLIER_CODE);  
       ELSE
           O_SUPPLIER_CODE := P_SUPPLIER_CODE;
       END IF;
       
       -- CODE 중복체크 --
       BEGIN
             SELECT COUNT(*)
               INTO V_QTY
               FROM FI_SUPP_CUST_V  V
              WHERE V.SOB_ID         = P_SOB_ID
                AND V.ORG_ID         = P_ORG_ID
                AND V.SUPP_CUST_CODE = O_SUPPLIER_CODE
              ;
       EXCEPTION WHEN OTHERS THEN
            V_QTY := 0;
       END;
       
       IF NVL(V_QTY,0) > 0 THEN
           RAISE_APPLICATION_ERROR(-20011, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_90003', '&&FIELD_NAME:= ' || P_SUPPLIER_CODE ));
       END IF;


       IF O_SUPPLIER_CODE IS NULL THEN
          RAISE_APPLICATION_ERROR(-20011, 'SAVE ERROR : SUPPLIER CODE EMPTY');
       END IF;  
       
       -- SUPPLIER_ID SEQ Generate
       SELECT FI_CUST_SUPPLIER_S1.NEXTVAL
         INTO P_SUPPLIER_ID
         FROM DUAL;

       -- Insert
       INSERT INTO AP_SUPPLIER
                  (  SUPPLIER_ID
                  ,  SOB_ID
                  ,  ORG_ID
                  ,  SUPPLIER_CODE
                  ,  SUPPLIER_FULL_NAME
                  ,  SUPPLIER_SHORT_NAME
                  ,  SUPPLIER_CLASS_CODE
                  ,  SUPPLIER_TYPE_CODE
                  ,  TAX_REG_NO
                  ,  COUNTRY_CODE
                  ,  ZIP_CODE
                  ,  ADDRESS_1
                  ,  ADDRESS_2
                  ,  PRESIDENT_NAME
                  ,  BUSINESS_TYPE_LCODE
                  ,  BUSINESS_CONDITION
                  ,  BUSINESS_ITEM
                  ,  PO_ENABLED_FLAG
                  ,  PO_PERSON_ID
                  ,  PRIMARY_CURRENCY_CODE
                  ,  PO_LIMIT_AMOUNT
                  ,  CREDIT_LIMIT_AMOUNT
                  ,  PRICE_TERM_ID
                  ,  PAYMENT_METHOD_ID
                  ,  PAYMENT_TERM_ID
                  ,  SHIPPING_METHOD_LCODE
                  ,  LOADING_PORT_ID
                  ,  DESTINATION_PORT_ID
                  ,  FORWARDER_ID
                  , EFFECTIVE_DATE_FR
                  , EFFECTIVE_DATE_TO
                  , ENABLED_FLAG
                  ,  ATTRIBUTE_A
                  ,  ATTRIBUTE_B
                  ,  ATTRIBUTE_C
                  ,  ATTRIBUTE_D
                  ,  ATTRIBUTE_E
                  ,  ATTRIBUTE_F
                  ,  ATTRIBUTE_G
                  ,  ATTRIBUTE_H
                  ,  ATTRIBUTE_1
                  ,  ATTRIBUTE_2
                  ,  ATTRIBUTE_3
                  ,  ATTRIBUTE_4
                  ,  ATTRIBUTE_5
                  ,  ATTRIBUTE_6
                  ,  ATTRIBUTE_7
                  ,  CREATION_DATE
                  ,  CREATED_BY
                  ,  LAST_UPDATE_DATE
                  ,  LAST_UPDATED_BY
                  )
       VALUES
                  (  P_SUPPLIER_ID
                  ,  P_SOB_ID
                  ,  P_ORG_ID
                  ,  O_SUPPLIER_CODE
                  ,  P_SUPPLIER_FULL_NAME
                  ,  P_SUPPLIER_SHORT_NAME
                  ,  P_SUPPLIER_CLASS_CODE
                  ,  P_SUPPLIER_TYPE_CODE
                  ,  P_TAX_REG_NO
                  ,  P_COUNTRY_CODE
                  ,  P_ZIP_CODE
                  ,  P_ADDRESS_1
                  ,  P_ADDRESS_2
                  ,  P_PRESIDENT_NAME
                  ,  P_BUSINESS_TYPE_LCODE
                  ,  P_BUSINESS_CONDITION
                  ,  P_BUSINESS_ITEM
                  ,  P_PO_ENABLED_FLAG
                  ,  P_PO_PERSON_ID
                  ,  P_PRIMARY_CURRENCY_CODE
                  ,  P_PO_LIMIT_AMOUNT
                  ,  P_CREDIT_LIMIT_AMOUNT
                  ,  P_PRICE_TERM_ID
                  ,  P_PAYMENT_METHOD_ID
                  ,  P_PAYMENT_TERM_ID
                  ,  P_SHIPPING_METHOD_LCODE
                  ,  P_LOADING_PORT_ID
                  ,  P_DESTINATION_PORT_ID
                  ,  P_FORWARDER_ID
                  , P_EFFECTIVE_DATE_FR
                  , P_EFFECTIVE_DATE_TO
                  , P_ENABLED_FLAG
                  ,  P_ATTRIBUTE_A
                  ,  P_ATTRIBUTE_B
                  ,  P_ATTRIBUTE_C
                  ,  P_ATTRIBUTE_D
                  ,  P_ATTRIBUTE_E
                  ,  P_ATTRIBUTE_F
                  ,  P_ATTRIBUTE_G
                  ,  P_ATTRIBUTE_H
                  ,  P_ATTRIBUTE_1
                  ,  P_ATTRIBUTE_2
                  ,  P_ATTRIBUTE_3
                  ,  P_ATTRIBUTE_4
                  ,  P_ATTRIBUTE_5
                  ,  P_ATTRIBUTE_6
                  ,  P_ATTRIBUTE_7
                  ,  V_LOCAL_DATE
                  ,  P_USER_ID
                  ,  V_LOCAL_DATE
                  ,  P_USER_ID
                  );


 END AP_SUPPLIER_INSERT;


 --------------
 -- UPDATE   --
 --------------
PROCEDURE AP_SUPPLIER_UPDATE (  W_SUPPLIER_ID              IN  NUMBER
                              ,  P_SOB_ID                   IN  NUMBER
                              ,  P_SUPPLIER_FULL_NAME       IN  AP_SUPPLIER.SUPPLIER_FULL_NAME%TYPE
                              ,  P_SUPPLIER_SHORT_NAME      IN  AP_SUPPLIER.SUPPLIER_SHORT_NAME%TYPE
                              ,  P_SUPPLIER_CLASS_CODE      IN  AP_SUPPLIER.SUPPLIER_CLASS_CODE%TYPE
                              ,  P_SUPPLIER_TYPE_CODE       IN  AP_SUPPLIER.SUPPLIER_TYPE_CODE%TYPE
                              ,  P_TAX_REG_NO               IN  AP_SUPPLIER.TAX_REG_NO%TYPE
                              ,  P_COUNTRY_CODE             IN  AP_SUPPLIER.COUNTRY_CODE%TYPE
                              ,  P_ZIP_CODE                 IN  AP_SUPPLIER.ZIP_CODE%TYPE
                              ,  P_ADDRESS_1                IN  AP_SUPPLIER.ADDRESS_1%TYPE
                              ,  P_ADDRESS_2                IN  AP_SUPPLIER.ADDRESS_2%TYPE
                              ,  P_PRESIDENT_NAME           IN  AP_SUPPLIER.PRESIDENT_NAME%TYPE
                              ,  P_BUSINESS_TYPE_LCODE      IN  AP_SUPPLIER.BUSINESS_TYPE_LCODE%TYPE
                              ,  P_BUSINESS_CONDITION       IN  AP_SUPPLIER.BUSINESS_CONDITION%TYPE
                              ,  P_BUSINESS_ITEM            IN  AP_SUPPLIER.BUSINESS_ITEM%TYPE
                              ,  P_PO_ENABLED_FLAG          IN  AP_SUPPLIER.PO_ENABLED_FLAG%TYPE
                              ,  P_PO_PERSON_ID             IN  AP_SUPPLIER.PO_PERSON_ID%TYPE
                              ,  P_PRIMARY_CURRENCY_CODE    IN  AP_SUPPLIER.PRIMARY_CURRENCY_CODE%TYPE
                              ,  P_PO_LIMIT_AMOUNT          IN  AP_SUPPLIER.PO_LIMIT_AMOUNT%TYPE
                              ,  P_CREDIT_LIMIT_AMOUNT      IN  AP_SUPPLIER.CREDIT_LIMIT_AMOUNT%TYPE
                              ,  P_PRICE_TERM_ID            IN  AP_SUPPLIER.PRICE_TERM_ID%TYPE
                              ,  P_PAYMENT_METHOD_ID        IN  AP_SUPPLIER.PAYMENT_METHOD_ID%TYPE
                              ,  P_PAYMENT_TERM_ID          IN  AP_SUPPLIER.PAYMENT_TERM_ID%TYPE
                              ,  P_SHIPPING_METHOD_LCODE    IN  AP_SUPPLIER.SHIPPING_METHOD_LCODE%TYPE
                              ,  P_LOADING_PORT_ID          IN  AP_SUPPLIER.LOADING_PORT_ID%TYPE
                              ,  P_DESTINATION_PORT_ID      IN  AP_SUPPLIER.DESTINATION_PORT_ID%TYPE
                              ,  P_FORWARDER_ID             IN  AP_SUPPLIER.FORWARDER_ID%TYPE
                              , P_EFFECTIVE_DATE_FR        IN  AP_SUPPLIER.EFFECTIVE_DATE_FR%TYPE
                              , P_EFFECTIVE_DATE_TO        IN  AP_SUPPLIER.EFFECTIVE_DATE_TO%TYPE
                              , P_ENABLED_FLAG             IN  AP_SUPPLIER.ENABLED_FLAG%TYPE
                              ,  P_ATTRIBUTE_A              IN  AP_SUPPLIER.ATTRIBUTE_A%TYPE
                              ,  P_ATTRIBUTE_B              IN  AP_SUPPLIER.ATTRIBUTE_B%TYPE
                              ,  P_ATTRIBUTE_C              IN  AP_SUPPLIER.ATTRIBUTE_C%TYPE
                              ,  P_ATTRIBUTE_D              IN  AP_SUPPLIER.ATTRIBUTE_D%TYPE
                              ,  P_ATTRIBUTE_E              IN  AP_SUPPLIER.ATTRIBUTE_E%TYPE
                              ,  P_ATTRIBUTE_F              IN  AP_SUPPLIER.ATTRIBUTE_F%TYPE
                              ,  P_ATTRIBUTE_G              IN  AP_SUPPLIER.ATTRIBUTE_G%TYPE
                              ,  P_ATTRIBUTE_H              IN  AP_SUPPLIER.ATTRIBUTE_H%TYPE
                              ,  P_ATTRIBUTE_1              IN  AP_SUPPLIER.ATTRIBUTE_1%TYPE
                              ,  P_ATTRIBUTE_2              IN  AP_SUPPLIER.ATTRIBUTE_2%TYPE
                              ,  P_ATTRIBUTE_3              IN  AP_SUPPLIER.ATTRIBUTE_3%TYPE
                              ,  P_ATTRIBUTE_4              IN  AP_SUPPLIER.ATTRIBUTE_4%TYPE
                              ,  P_ATTRIBUTE_5              IN  AP_SUPPLIER.ATTRIBUTE_5%TYPE
                              ,  P_ATTRIBUTE_6              IN  AP_SUPPLIER.ATTRIBUTE_6%TYPE
                              ,  P_ATTRIBUTE_7              IN  AP_SUPPLIER.ATTRIBUTE_7%TYPE
                              , P_USER_ID                  IN  NUMBER )
 IS
       V_LOCAL_DATE     DATE := GET_LOCAL_DATE(P_SOB_ID);
       V_ORG_ID         NUMBER;
       V_QTY            NUMBER := 0;
       V_SOB_COUNTRY_CODE  VARCHAR2(50);
 BEGIN
       -- 사업자번호 중복체크--
       -- 국내일 경우에만 처리 --
       BEGIN
            SELECT SOB.COUNTRY_CODE
              INTO V_SOB_COUNTRY_CODE
              FROM EAPP_SET_OF_BOOKS SOB
             WHERE SOB.SOB_ID        = P_SOB_ID
               AND ROWNUM            = 1
               ;
       EXCEPTION WHEN OTHERS THEN
           V_SOB_COUNTRY_CODE := NULL;
       END;
       IF V_SOB_COUNTRY_CODE = P_COUNTRY_CODE THEN
           SELECT SC.ORG_ID
             INTO V_ORG_ID
           FROM FI_SUPP_CUST_V SC
           WHERE SC.SUPP_CUST_ID  = W_SUPPLIER_ID
           ;
           
           BEGIN
                 SELECT COUNT(*)
                   INTO V_QTY
                   FROM FI_SUPP_CUST_V  V
                  WHERE V.SOB_ID         = P_SOB_ID
                    AND V.ORG_ID         = V_ORG_ID
                    AND V.SUPP_CUST_TYPE = 'S'
                    AND REPLACE(V.TAX_REG_NO, '-', '')  = P_TAX_REG_NO
                    AND V.SUPP_CUST_ID   <> W_SUPPLIER_ID
                  ;
           EXCEPTION WHEN OTHERS THEN
                V_QTY := 0;
           END;
           IF NVL(V_QTY,0) > 0 THEN
               RAISE_APPLICATION_ERROR(-20011, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_90003', '&&FIELD_NAME:= ' || 'TAX REGISTER NO' ));
           END IF;
           
           -- 사업자번호 검증.
           IF REPLACE(P_TAX_REG_NO, '-', '') IS NOT NULL THEN
             IF EAPP_NUM_DIGIT_CHECKER_G.CHECK_TAX_NUM_F(P_TAX_REG_NO) = 'N' THEN
               RAISE_APPLICATION_ERROR(-20011, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10009', NULL));
             END IF;
           END IF;
       END IF;

       UPDATE AP_SUPPLIER     ASP
          SET SUPPLIER_FULL_NAME      = P_SUPPLIER_FULL_NAME
            ,  SUPPLIER_SHORT_NAME     = P_SUPPLIER_SHORT_NAME
            ,  SUPPLIER_CLASS_CODE     = P_SUPPLIER_CLASS_CODE
            ,  SUPPLIER_TYPE_CODE      = P_SUPPLIER_TYPE_CODE
            ,  TAX_REG_NO              = P_TAX_REG_NO
            ,  COUNTRY_CODE            = P_COUNTRY_CODE
            ,  ZIP_CODE                = P_ZIP_CODE
            ,  ADDRESS_1               = P_ADDRESS_1
            ,  ADDRESS_2               = P_ADDRESS_2
            ,  PRESIDENT_NAME          = P_PRESIDENT_NAME
            ,  BUSINESS_TYPE_LCODE     = P_BUSINESS_TYPE_LCODE
            ,  BUSINESS_CONDITION      = P_BUSINESS_CONDITION
            ,  BUSINESS_ITEM           = P_BUSINESS_ITEM
            ,  PO_ENABLED_FLAG         = P_PO_ENABLED_FLAG
            ,  PO_PERSON_ID            = P_PO_PERSON_ID
            ,  PRIMARY_CURRENCY_CODE   = P_PRIMARY_CURRENCY_CODE
            ,  PO_LIMIT_AMOUNT         = P_PO_LIMIT_AMOUNT
            ,  CREDIT_LIMIT_AMOUNT     = P_CREDIT_LIMIT_AMOUNT
            ,  PRICE_TERM_ID           = P_PRICE_TERM_ID
            ,  PAYMENT_METHOD_ID       = P_PAYMENT_METHOD_ID
            ,  PAYMENT_TERM_ID         = P_PAYMENT_TERM_ID
            ,  SHIPPING_METHOD_LCODE   = P_SHIPPING_METHOD_LCODE
            ,  LOADING_PORT_ID         = P_LOADING_PORT_ID
            ,  DESTINATION_PORT_ID     = P_DESTINATION_PORT_ID
            ,  FORWARDER_ID            = P_FORWARDER_ID
            , EFFECTIVE_DATE_FR       = P_EFFECTIVE_DATE_FR
            , EFFECTIVE_DATE_TO       = P_EFFECTIVE_DATE_TO
            , ENABLED_FLAG            = P_ENABLED_FLAG
            ,  ATTRIBUTE_A             = P_ATTRIBUTE_A
            ,  ATTRIBUTE_B             = P_ATTRIBUTE_B
            ,  ATTRIBUTE_C             = P_ATTRIBUTE_C
            ,  ATTRIBUTE_D             = P_ATTRIBUTE_D
            ,  ATTRIBUTE_E             = P_ATTRIBUTE_E
            ,  ATTRIBUTE_F             = P_ATTRIBUTE_F
            ,  ATTRIBUTE_G             = P_ATTRIBUTE_G
            ,  ATTRIBUTE_H             = P_ATTRIBUTE_H
            ,  ATTRIBUTE_1             = P_ATTRIBUTE_1
            ,  ATTRIBUTE_2             = P_ATTRIBUTE_2
            ,  ATTRIBUTE_3             = P_ATTRIBUTE_3
            ,  ATTRIBUTE_4             = P_ATTRIBUTE_4
            ,  ATTRIBUTE_5             = P_ATTRIBUTE_5
            ,  ATTRIBUTE_6             = P_ATTRIBUTE_6
            ,  ATTRIBUTE_7             = P_ATTRIBUTE_7
            ,  LAST_UPDATE_DATE        = V_LOCAL_DATE
            ,  LAST_UPDATED_BY         = P_USER_ID
        WHERE ASP.SUPPLIER_ID         = W_SUPPLIER_ID;





 END AP_SUPPLIER_UPDATE;


 --------------
 -- DELETE   --
 --------------
 PROCEDURE AP_SUPPLIER_DELETE ( W_SUPPLIER_ID   IN   NUMBER)
 IS
 BEGIN

   DELETE AP_SUPPLIER  ASP
    WHERE ASP.SUPPLIER_ID = W_SUPPLIER_ID;



 END AP_SUPPLIER_DELETE;

 ------------------------------
 -- 구매처 계좌정보 SELECT   --
 ------------------------------
 PROCEDURE AP_SUP_BANK_ACCT_INFO( P_CURSOR                OUT  TYPES.TCURSOR
                                 , W_SUPPLIER_ID          IN   NUMBER
                                 )
 IS
 BEGIN
       BEGIN
       OPEN P_CURSOR FOR
       SELECT BA.BANK_ACCOUNT_ID
           , BA.BANK_ID
           , FI_BANK_G.ID_NAME_F(BA.BANK_ID) AS BANK_NAME
           , BA.BANK_ACCOUNT_CODE
           , BA.BANK_ACCOUNT_NAME
           , BA.BANK_ACCOUNT_NUM
           , BA.OWNER_NAME
           , BA.ACCOUNT_TYPE
           , FI_COMMON_G.CODE_NAME_F('ACCOUNT_TYPE', BA.ACCOUNT_TYPE, BA.SOB_ID, BA.ORG_ID) AS ACCOUNT_TYPE_NAME
           , BA.CURRENCY_CODE AS DISPLAY_CURRENCY_CODE
           , BA.CURRENCY_CODE
           , BA.SUPPLIER_CUSTOMER_ID AS SUPPLIER_ID
           , BA.REMARK
           , BA.ENABLED_FLAG
           , BA.EFFECTIVE_DATE_FR
           , BA.EFFECTIVE_DATE_TO
        FROM FI_BANK_ACCOUNT_TLV BA
       WHERE BA.ACCOUNT_OWNER_TYPE     = 'SUPPLIER'
         AND BA.SUPPLIER_CUSTOMER_ID   = W_SUPPLIER_ID
/*         AND BA.ORG_ID                  = W_ORG_ID*/
         AND BA.ACCOUNT_OWNER_TYPE     <> 'OWNER'

       ;
       EXCEPTION WHEN NO_DATA_FOUND THEN
          NULL;
       END;


 END AP_SUP_BANK_ACCT_INFO;


-- 은행계좌 삽입.
  PROCEDURE AP_SUP_BANK_ACCT_INSERT
            ( P_BANK_ACCOUNT_ID      OUT FI_BANK_ACCOUNT.BANK_ACCOUNT_ID%TYPE
            , P_SOB_ID               IN FI_BANK_ACCOUNT.SOB_ID%TYPE
            , P_ORG_ID               IN FI_BANK_ACCOUNT.ORG_ID%TYPE
            , P_BANK_ACCOUNT_CODE    IN FI_BANK_ACCOUNT.BANK_ACCOUNT_CODE%TYPE
            , P_BANK_ACCOUNT_NAME    IN FI_BANK_ACCOUNT.BANK_ACCOUNT_NAME%TYPE
            , P_BANK_ID              IN FI_BANK_ACCOUNT.BANK_ID%TYPE
            , P_BANK_ACCOUNT_NUM     IN FI_BANK_ACCOUNT.BANK_ACCOUNT_NUM%TYPE
            , P_OWNER_NAME           IN FI_BANK_ACCOUNT.OWNER_NAME%TYPE
            , P_ACCOUNT_TYPE         IN FI_BANK_ACCOUNT.ACCOUNT_TYPE%TYPE
            , P_CURRENCY_CODE        IN FI_BANK_ACCOUNT.CURRENCY_CODE%TYPE
            , P_SUPPLIER_CUSTOMER_ID IN FI_BANK_ACCOUNT.SUPPLIER_CUSTOMER_ID%TYPE
            , P_REMARK               IN FI_BANK_ACCOUNT.REMARK%TYPE
            , P_ENABLED_FLAG         IN FI_BANK_ACCOUNT.ENABLED_FLAG%TYPE
            , P_EFFECTIVE_DATE_FR    IN FI_BANK_ACCOUNT.EFFECTIVE_DATE_FR%TYPE
            , P_EFFECTIVE_DATE_TO    IN FI_BANK_ACCOUNT.EFFECTIVE_DATE_TO%TYPE
            , P_USER_ID              IN FI_BANK_ACCOUNT.CREATED_BY%TYPE
            )
  AS
    V_SYSDATE   DATE := GET_LOCAL_DATE(P_SOB_ID);
    V_RECORD_COUNT NUMBER := 0;

  BEGIN
    -- 동일한 은행 그룹코드 존재 체크.
    BEGIN
      SELECT COUNT(BA.BANK_ACCOUNT_NUM) AS RECORD_COUNT
        INTO V_RECORD_COUNT
        FROM FI_BANK_ACCOUNT BA
       WHERE BA.SOB_ID            = P_SOB_ID
         AND BA.BANK_ACCOUNT_CODE = P_BANK_ACCOUNT_CODE
      ;
    EXCEPTION WHEN OTHERS THEN
      V_RECORD_COUNT := 0;
    END;
    IF V_RECORD_COUNT <> 0 THEN
      RAISE ERRNUMS.Exist_Data;
    END IF;

    -- 동일한 은행 그룹코드 존재 체크.
    BEGIN
      SELECT COUNT(BA.BANK_ACCOUNT_NUM) AS RECORD_COUNT
        INTO V_RECORD_COUNT
        FROM FI_BANK_ACCOUNT BA
       WHERE BA.SOB_ID            = P_SOB_ID
         AND BA.BANK_ACCOUNT_NUM  = P_BANK_ACCOUNT_NUM
      ;
    EXCEPTION WHEN OTHERS THEN
      V_RECORD_COUNT := 0;
    END;
    IF V_RECORD_COUNT <> 0 THEN
      RAISE ERRNUMS.Exist_Data;
    END IF;

    SELECT FI_BANK_ACCOUNT_S1.NEXTVAL
      INTO P_BANK_ACCOUNT_ID
      FROM DUAL;

    INSERT INTO FI_BANK_ACCOUNT
    ( BANK_ACCOUNT_ID
    , SOB_ID
    , ORG_ID
    , BANK_ACCOUNT_CODE
    , BANK_ACCOUNT_NAME
    , BANK_ID
    , BANK_ACCOUNT_NUM
    , OWNER_NAME
    , ACCOUNT_TYPE
    , CURRENCY_CODE
    , ACCOUNT_OWNER_TYPE
    , SUPPLIER_CUSTOMER_ID
    , REMARK
    , ENABLED_FLAG
    , EFFECTIVE_DATE_FR
    , EFFECTIVE_DATE_TO
    , CREATION_DATE
    , CREATED_BY
    , LAST_UPDATE_DATE
    , LAST_UPDATED_BY )
    VALUES
    ( P_BANK_ACCOUNT_ID
    , P_SOB_ID
    , P_ORG_ID
    , P_BANK_ACCOUNT_CODE
    , P_BANK_ACCOUNT_NAME
    , P_BANK_ID
    , P_BANK_ACCOUNT_NUM
    , P_OWNER_NAME
    , P_ACCOUNT_TYPE
    , P_CURRENCY_CODE
    , 'SUPPLIER'     -- ACCOUNT_OWNER_TYPE
    , P_SUPPLIER_CUSTOMER_ID
    , P_REMARK
    , P_ENABLED_FLAG
    , P_EFFECTIVE_DATE_FR
    , P_EFFECTIVE_DATE_TO
    , V_SYSDATE
    , P_USER_ID
    , V_SYSDATE
    , P_USER_ID );

  EXCEPTION
    WHEN ERRNUMS.Exist_Data THEN
    RAISE_APPLICATION_ERROR(ERRNUMS.Exist_Data_Code, ERRNUMS.Exist_Data_Desc);
  END AP_SUP_BANK_ACCT_INSERT;


-- 은행계좌 수정.
  PROCEDURE AP_SUP_BANK_ACCT_UPDATE
            ( W_BANK_ACCOUNT_ID      IN FI_BANK_ACCOUNT.BANK_ACCOUNT_ID%TYPE
            , P_BANK_ACCOUNT_NAME    IN FI_BANK_ACCOUNT.BANK_ACCOUNT_NAME%TYPE
            , P_BANK_ACCOUNT_NUM     IN FI_BANK_ACCOUNT.BANK_ACCOUNT_NUM%TYPE
            , P_OWNER_NAME           IN FI_BANK_ACCOUNT.OWNER_NAME%TYPE
            , P_ACCOUNT_TYPE         IN FI_BANK_ACCOUNT.ACCOUNT_TYPE%TYPE
            , P_CURRENCY_CODE        IN FI_BANK_ACCOUNT.CURRENCY_CODE%TYPE
            , P_REMARK               IN FI_BANK_ACCOUNT.REMARK%TYPE
            , P_ENABLED_FLAG         IN FI_BANK_ACCOUNT.ENABLED_FLAG%TYPE
            , P_EFFECTIVE_DATE_FR    IN FI_BANK_ACCOUNT.EFFECTIVE_DATE_FR%TYPE
            , P_EFFECTIVE_DATE_TO    IN FI_BANK_ACCOUNT.EFFECTIVE_DATE_TO%TYPE
            , P_USER_ID              IN FI_BANK_ACCOUNT.CREATED_BY%TYPE
            )
  AS
  BEGIN
    UPDATE FI_BANK_ACCOUNT
      SET BANK_ACCOUNT_NAME    = P_BANK_ACCOUNT_NAME
        , BANK_ACCOUNT_NUM     = P_BANK_ACCOUNT_NUM
        , OWNER_NAME           = P_OWNER_NAME
        , ACCOUNT_TYPE         = P_ACCOUNT_TYPE
        , CURRENCY_CODE        = P_CURRENCY_CODE
        , REMARK               = P_REMARK
        , ENABLED_FLAG         = P_ENABLED_FLAG
        , EFFECTIVE_DATE_FR    = P_EFFECTIVE_DATE_FR
        , EFFECTIVE_DATE_TO    = P_EFFECTIVE_DATE_TO
        , LAST_UPDATE_DATE     = GET_LOCAL_DATE(SOB_ID)
        , LAST_UPDATED_BY      = P_USER_ID
    WHERE BANK_ACCOUNT_ID      = W_BANK_ACCOUNT_ID
    ;

  END AP_SUP_BANK_ACCT_UPDATE;

 --------------------------------------
 -- SUPPLIER_CODE Duplication check  --
 --------------------------------------
 PROCEDURE CHK_SUPPLIER_CODE_DUP ( P_SOB_ID          IN   NUMBER
                                 , P_ORG_ID          IN   NUMBER
                                 , P_SUPPLIER_CODE   IN   AP_SUPPLIER.SUPPLIER_CODE%TYPE
                                 , X_CHECK_RESULT    OUT  VARCHAR2)
 IS
    V_CHK_COUNT  NUMBER := 0;
 BEGIN

    BEGIN
      SELECT COUNT(*)
        INTO V_CHK_COUNT
        FROM AP_SUPPLIER  APS
       WHERE APS.SOB_ID        = P_SOB_ID
         AND APS.ORG_ID        = P_ORG_ID
         AND APS.SUPPLIER_CODE = P_SUPPLIER_CODE
         ;
    EXCEPTION WHEN OTHERS THEN
        V_CHK_COUNT := 0;
    END;

    IF NVL(V_CHK_COUNT,0) = 0 THEN
       X_CHECK_RESULT := 'Y';
    ELSE
       X_CHECK_RESULT := 'N';
    END IF;

 END CHK_SUPPLIER_CODE_DUP;

 --------------------------------------
 -- TAX_REG_NO Duplication check     --
 --------------------------------------
 PROCEDURE CHK_TAX_REG_NO_DUP ( P_SOB_ID          IN   NUMBER
                              , P_ORG_ID          IN   NUMBER
                              , P_TAX_REG_NO      IN   AP_SUPPLIER.TAX_REG_NO%TYPE
                              , X_CHECK_RESULT    OUT  VARCHAR2)
 IS
    V_CHK_COUNT  NUMBER := 0;
 BEGIN

    BEGIN
      SELECT COUNT(*)
        INTO V_CHK_COUNT
        FROM AP_SUPPLIER  APS
       WHERE APS.SOB_ID        = P_SOB_ID
         AND APS.ORG_ID        = P_ORG_ID
         AND APS.TAX_REG_NO    = P_TAX_REG_NO
         ;
    EXCEPTION WHEN OTHERS THEN
        V_CHK_COUNT := 0;
    END;

    IF NVL(V_CHK_COUNT,0) = 0 THEN
       X_CHECK_RESULT := 'Y';
    ELSE
       X_CHECK_RESULT := 'N';
    END IF;

 END CHK_TAX_REG_NO_DUP;



END AP_SUPPLIER_G; 
/
