create or replace package AR_CUSTOMER_SITE_G is
/******************************************************************************/
/* Project      : FLEX ERP
/* Module       : FCM
/* Program Name : AR_CUSTOMER_SITE_G
/* Description  : CUSTOMER SITE MASTER
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Shin Man Jae       Initialize
/******************************************************************************/

 PROCEDURE AR_CUST_SITE_SELECT ( P_CURSOR                OUT  TYPES.TCURSOR
                               , W_SOB_ID                IN   NUMBER
                               , W_ORG_ID                IN   NUMBER
                               , W_CUST_SITE_ID          IN   NUMBER
                               , W_CUST_PARTY_ID         IN   NUMBER
                               , X_ERR_MSG               OUT  VARCHAR2
                               ) ;

 PROCEDURE AR_CUST_SITE_INSERT( P_CUST_SITE_ID                OUT AR_CUSTOMER_SITE.CUST_SITE_ID%TYPE
                              ,  P_SOB_ID                     IN  AR_CUSTOMER_SITE.SOB_ID%TYPE
                              ,  P_ORG_ID                     IN  AR_CUSTOMER_SITE.ORG_ID%TYPE
                              ,  P_CUST_SITE_CODE             OUT AR_CUSTOMER_SITE.CUST_SITE_CODE%TYPE
                              ,  P_CUST_SITE_FULL_NAME        IN AR_CUSTOMER_SITE.CUST_SITE_FULL_NAME%TYPE
                              ,  P_CUST_SITE_SHORT_NAME       IN AR_CUSTOMER_SITE.CUST_SITE_SHORT_NAME%TYPE
                              ,  P_CUST_SITE_SHORT_CODE       IN AR_CUSTOMER_SITE.CUST_SITE_SHORT_CODE%TYPE
                              ,  P_CUST_PARTY_ID              IN AR_CUSTOMER_SITE.CUST_PARTY_ID%TYPE
                              ,  P_TAX_REG_NO                 IN AR_CUSTOMER_SITE.TAX_REG_NO%TYPE
                              ,  P_COUNTRY_CODE               IN AR_CUSTOMER_SITE.COUNTRY_CODE%TYPE
                              ,  P_ZIP_CODE                   IN AR_CUSTOMER_SITE.ZIP_CODE%TYPE
                              ,  P_ADDRESS_1                  IN AR_CUSTOMER_SITE.ADDRESS_1%TYPE
                              ,  P_ADDRESS_2                  IN AR_CUSTOMER_SITE.ADDRESS_2%TYPE
                              ,  P_PRESIDENT_NAME             IN AR_CUSTOMER_SITE.PRESIDENT_NAME%TYPE
                              ,  P_BUSINESS_TYPE_LCODE        IN AR_CUSTOMER_SITE.BUSINESS_TYPE_LCODE%TYPE
                              ,  P_BUSINESS_CONDITION         IN AR_CUSTOMER_SITE.BUSINESS_CONDITION%TYPE
                              ,  P_BUSINESS_ITEM              IN AR_CUSTOMER_SITE.BUSINESS_ITEM%TYPE
                              ,  P_TAX_BILL_TYPE_LCODE        IN AR_CUSTOMER_SITE.TAX_BILL_TYPE_LCODE%TYPE
                              ,  P_OE_ORDER_FLAG              IN AR_CUSTOMER_SITE.OE_ORDER_FLAG%TYPE
                              ,  P_WIP_PROCESS_FLAG           IN AR_CUSTOMER_SITE.WIP_PROCESS_FLAG%TYPE
                              ,  P_OE_DELIVERY_FLAG           IN AR_CUSTOMER_SITE.OE_DELIVERY_FLAG%TYPE
                              ,  P_SALES_PERSON_ID            IN AR_CUSTOMER_SITE.SALES_PERSON_ID%TYPE
                              ,  P_PRIMARY_CURRENCY_CODE      IN AR_CUSTOMER_SITE.PRIMARY_CURRENCY_CODE%TYPE
                              ,  P_SELL_LIMIT_AMOUNT          IN AR_CUSTOMER_SITE.SELL_LIMIT_AMOUNT%TYPE
                              ,  P_CREDIT_LIMIT_AMOUNT        IN AR_CUSTOMER_SITE.CREDIT_LIMIT_AMOUNT%TYPE
                              ,  P_PRICE_TERM_ID              IN AR_CUSTOMER_SITE.PRICE_TERM_ID%TYPE
                              ,  P_PAYMENT_METHOD_ID          IN AR_CUSTOMER_SITE.PAYMENT_METHOD_ID%TYPE
                              ,  P_PAYMENT_TERM_ID            IN AR_CUSTOMER_SITE.PAYMENT_TERM_ID%TYPE
                              ,  P_SHIPPING_METHOD_LCODE      IN AR_CUSTOMER_SITE.SHIPPING_METHOD_LCODE%TYPE
                              ,  P_LOADING_PORT_ID            IN AR_CUSTOMER_SITE.LOADING_PORT_ID%TYPE
                              ,  P_DESTINATION_PORT_ID        IN AR_CUSTOMER_SITE.DESTINATION_PORT_ID%TYPE
                              ,  P_EFFECTIVE_DATE_FR          IN AR_CUSTOMER_SITE.EFFECTIVE_DATE_FR%TYPE
                              ,  P_EFFECTIVE_DATE_TO          IN AR_CUSTOMER_SITE.EFFECTIVE_DATE_TO%TYPE
                              ,  P_ENABLED_FLAG               IN AR_CUSTOMER_SITE.ENABLED_FLAG%TYPE
                              ,  P_ATTRIBUTE_A                IN AR_CUSTOMER_SITE.ATTRIBUTE_A%TYPE
                              ,  P_ATTRIBUTE_B                IN AR_CUSTOMER_SITE.ATTRIBUTE_B%TYPE
                              ,  P_ATTRIBUTE_C                IN AR_CUSTOMER_SITE.ATTRIBUTE_C%TYPE
                              ,  P_ATTRIBUTE_D                IN AR_CUSTOMER_SITE.ATTRIBUTE_D%TYPE
                              ,  P_ATTRIBUTE_E                IN AR_CUSTOMER_SITE.ATTRIBUTE_E%TYPE
                              ,  P_ATTRIBUTE_F                IN AR_CUSTOMER_SITE.ATTRIBUTE_F%TYPE
                              ,  P_ATTRIBUTE_G                IN AR_CUSTOMER_SITE.ATTRIBUTE_G%TYPE
                              ,  P_ATTRIBUTE_H                IN AR_CUSTOMER_SITE.ATTRIBUTE_H%TYPE
                              ,  P_ATTRIBUTE_1                IN AR_CUSTOMER_SITE.ATTRIBUTE_1%TYPE
                              ,  P_ATTRIBUTE_2                IN AR_CUSTOMER_SITE.ATTRIBUTE_2%TYPE
                              ,  P_ATTRIBUTE_3                IN AR_CUSTOMER_SITE.ATTRIBUTE_3%TYPE
                              ,  P_ATTRIBUTE_4                IN AR_CUSTOMER_SITE.ATTRIBUTE_4%TYPE
                              ,  P_ATTRIBUTE_5                IN AR_CUSTOMER_SITE.ATTRIBUTE_5%TYPE
                              ,  P_ATTRIBUTE_6                IN AR_CUSTOMER_SITE.ATTRIBUTE_6%TYPE
                              ,  P_ATTRIBUTE_7                IN AR_CUSTOMER_SITE.ATTRIBUTE_7%TYPE
                              ,  P_USER_ID                    IN  NUMBER
                              );

PROCEDURE AR_CUST_SITE_UPDATE ( W_CUST_SITE_ID               IN AR_CUSTOMER_SITE.CUST_SITE_ID%TYPE
                              ,	P_SOB_ID                     IN AR_CUSTOMER_SITE.SOB_ID%TYPE
                              ,	P_ORG_ID                     IN AR_CUSTOMER_SITE.ORG_ID%TYPE
                              ,	P_CUST_SITE_FULL_NAME        IN AR_CUSTOMER_SITE.CUST_SITE_FULL_NAME%TYPE
                              ,	P_CUST_SITE_SHORT_NAME       IN AR_CUSTOMER_SITE.CUST_SITE_SHORT_NAME%TYPE
                              , P_CUST_SITE_SHORT_CODE       IN AR_CUSTOMER_SITE.CUST_SITE_SHORT_CODE%TYPE
                              ,	P_CUST_PARTY_ID              IN AR_CUSTOMER_SITE.CUST_PARTY_ID%TYPE
                              ,	P_TAX_REG_NO                 IN AR_CUSTOMER_SITE.TAX_REG_NO%TYPE
                              ,	P_COUNTRY_CODE               IN AR_CUSTOMER_SITE.COUNTRY_CODE%TYPE
                              ,	P_ZIP_CODE                   IN AR_CUSTOMER_SITE.ZIP_CODE%TYPE
                              ,	P_ADDRESS_1                  IN AR_CUSTOMER_SITE.ADDRESS_1%TYPE
                              ,	P_ADDRESS_2                  IN AR_CUSTOMER_SITE.ADDRESS_2%TYPE
                              ,	P_PRESIDENT_NAME             IN AR_CUSTOMER_SITE.PRESIDENT_NAME%TYPE
                              ,	P_BUSINESS_TYPE_LCODE        IN AR_CUSTOMER_SITE.BUSINESS_TYPE_LCODE%TYPE
                              ,	P_BUSINESS_CONDITION         IN AR_CUSTOMER_SITE.BUSINESS_CONDITION%TYPE
                              ,	P_BUSINESS_ITEM              IN AR_CUSTOMER_SITE.BUSINESS_ITEM%TYPE
                              ,	P_TAX_BILL_TYPE_LCODE        IN AR_CUSTOMER_SITE.TAX_BILL_TYPE_LCODE%TYPE
                              ,	P_OE_ORDER_FLAG              IN AR_CUSTOMER_SITE.OE_ORDER_FLAG%TYPE
                              ,	P_WIP_PROCESS_FLAG           IN AR_CUSTOMER_SITE.WIP_PROCESS_FLAG%TYPE
                              ,	P_OE_DELIVERY_FLAG           IN AR_CUSTOMER_SITE.OE_DELIVERY_FLAG%TYPE
                              ,	P_SALES_PERSON_ID            IN AR_CUSTOMER_SITE.SALES_PERSON_ID%TYPE
                              ,	P_PRIMARY_CURRENCY_CODE      IN AR_CUSTOMER_SITE.PRIMARY_CURRENCY_CODE%TYPE
                              ,	P_SELL_LIMIT_AMOUNT          IN AR_CUSTOMER_SITE.SELL_LIMIT_AMOUNT%TYPE
                              ,	P_CREDIT_LIMIT_AMOUNT        IN AR_CUSTOMER_SITE.CREDIT_LIMIT_AMOUNT%TYPE
                              ,	P_PRICE_TERM_ID              IN AR_CUSTOMER_SITE.PRICE_TERM_ID%TYPE
                              ,	P_PAYMENT_METHOD_ID          IN AR_CUSTOMER_SITE.PAYMENT_METHOD_ID%TYPE
                              ,	P_PAYMENT_TERM_ID            IN AR_CUSTOMER_SITE.PAYMENT_TERM_ID%TYPE
                              ,	P_SHIPPING_METHOD_LCODE      IN AR_CUSTOMER_SITE.SHIPPING_METHOD_LCODE%TYPE
                              ,	P_LOADING_PORT_ID            IN AR_CUSTOMER_SITE.LOADING_PORT_ID%TYPE
                              ,	P_DESTINATION_PORT_ID        IN AR_CUSTOMER_SITE.DESTINATION_PORT_ID%TYPE
                              ,	P_EFFECTIVE_DATE_FR          IN AR_CUSTOMER_SITE.EFFECTIVE_DATE_FR%TYPE
                              ,	P_EFFECTIVE_DATE_TO          IN AR_CUSTOMER_SITE.EFFECTIVE_DATE_TO%TYPE
                              ,	P_ENABLED_FLAG               IN AR_CUSTOMER_SITE.ENABLED_FLAG%TYPE
                              ,	P_ATTRIBUTE_A                IN AR_CUSTOMER_SITE.ATTRIBUTE_A%TYPE
                              ,	P_ATTRIBUTE_B                IN AR_CUSTOMER_SITE.ATTRIBUTE_B%TYPE
                              ,	P_ATTRIBUTE_C                IN AR_CUSTOMER_SITE.ATTRIBUTE_C%TYPE
                              ,	P_ATTRIBUTE_D                IN AR_CUSTOMER_SITE.ATTRIBUTE_D%TYPE
                              ,	P_ATTRIBUTE_E                IN AR_CUSTOMER_SITE.ATTRIBUTE_E%TYPE
                              ,	P_ATTRIBUTE_F                IN AR_CUSTOMER_SITE.ATTRIBUTE_F%TYPE
                              ,	P_ATTRIBUTE_G                IN AR_CUSTOMER_SITE.ATTRIBUTE_G%TYPE
                              ,	P_ATTRIBUTE_H                IN AR_CUSTOMER_SITE.ATTRIBUTE_H%TYPE
                              ,	P_ATTRIBUTE_1                IN AR_CUSTOMER_SITE.ATTRIBUTE_1%TYPE
                              ,	P_ATTRIBUTE_2                IN AR_CUSTOMER_SITE.ATTRIBUTE_2%TYPE
                              ,	P_ATTRIBUTE_3                IN AR_CUSTOMER_SITE.ATTRIBUTE_3%TYPE
                              ,	P_ATTRIBUTE_4                IN AR_CUSTOMER_SITE.ATTRIBUTE_4%TYPE
                              ,	P_ATTRIBUTE_5                IN AR_CUSTOMER_SITE.ATTRIBUTE_5%TYPE
                              ,	P_ATTRIBUTE_6                IN AR_CUSTOMER_SITE.ATTRIBUTE_6%TYPE
                              ,	P_ATTRIBUTE_7                IN AR_CUSTOMER_SITE.ATTRIBUTE_7%TYPE
                              , P_USER_ID                    IN NUMBER
                              );

 PROCEDURE AR_CUST_SITE_DELETE ( W_CUST_SITE_ID   IN   NUMBER
                               , X_ERR_MSG        OUT  VARCHAR2
                               ) ;

 ------------------------------
 -- 고객관련 계좌정보 SELECT --
 ------------------------------
 PROCEDURE AR_CUST_BANK_ACCT_INFO( P_CURSOR                OUT  TYPES.TCURSOR
                                 , W_CUST_SITE_ID          IN   NUMBER
                                 ) ;

-- 은행계좌 삽입.
  PROCEDURE AR_SUP_BANK_ACCT_INSERT
            ( P_BANK_ACCOUNT_ID      OUT   FI_BANK_ACCOUNT_VENDOR.BANK_ACCOUNT_ID%TYPE
            , P_SOB_ID               IN    FI_BANK_ACCOUNT_VENDOR.SOB_ID%TYPE
            , P_ORG_ID               IN    FI_BANK_ACCOUNT_VENDOR.ORG_ID%TYPE
            , P_VENDOR_ID            IN    FI_BANK_ACCOUNT_VENDOR.VENDOR_ID%TYPE
            , P_BANK_ACCOUNT_CODE    OUT   FI_BANK_ACCOUNT_VENDOR.BANK_ACCOUNT_CODE%TYPE
            , P_BANK_ACCOUNT_NAME    IN    FI_BANK_ACCOUNT_VENDOR.BANK_ACCOUNT_NAME%TYPE
            , P_BANK_ID              IN    FI_BANK_ACCOUNT_VENDOR.BANK_ID%TYPE
            , P_BANK_ACCOUNT_NUM     IN    FI_BANK_ACCOUNT_VENDOR.BANK_ACCOUNT_NUM%TYPE
            , P_OWNER_NAME           IN    FI_BANK_ACCOUNT_VENDOR.OWNER_NAME%TYPE
            , P_ACCOUNT_TYPE         IN    FI_BANK_ACCOUNT_VENDOR.ACCOUNT_TYPE%TYPE
            , P_CURRENCY_CODE        IN    FI_BANK_ACCOUNT_VENDOR.CURRENCY_CODE%TYPE            
            , P_REMARK               IN    FI_BANK_ACCOUNT_VENDOR.REMARK%TYPE
            , P_ENABLED_FLAG         IN    FI_BANK_ACCOUNT_VENDOR.ENABLED_FLAG%TYPE
            , P_EFFECTIVE_DATE_FR    IN    FI_BANK_ACCOUNT_VENDOR.EFFECTIVE_DATE_FR%TYPE
            , P_EFFECTIVE_DATE_TO    IN    FI_BANK_ACCOUNT_VENDOR.EFFECTIVE_DATE_TO%TYPE
            , P_USER_ID              IN    FI_BANK_ACCOUNT_VENDOR.CREATED_BY%TYPE
            );

-- 은행계좌 수정.
  PROCEDURE AR_SUP_BANK_ACCT_UPDATE
            ( W_BANK_ACCOUNT_ID      IN FI_BANK_ACCOUNT_VENDOR.BANK_ACCOUNT_ID%TYPE
            , P_SOB_ID               IN FI_BANK_ACCOUNT_VENDOR.SOB_ID%TYPE
            , P_ORG_ID               IN FI_BANK_ACCOUNT_VENDOR.ORG_ID%TYPE
            , P_BANK_ACCOUNT_NAME    IN FI_BANK_ACCOUNT_VENDOR.BANK_ACCOUNT_NAME%TYPE
            , P_BANK_ID              IN FI_BANK_ACCOUNT_VENDOR.BANK_ID%TYPE
            , P_BANK_ACCOUNT_NUM     IN FI_BANK_ACCOUNT_VENDOR.BANK_ACCOUNT_NUM%TYPE
            , P_OWNER_NAME           IN FI_BANK_ACCOUNT_VENDOR.OWNER_NAME%TYPE
            , P_ACCOUNT_TYPE         IN FI_BANK_ACCOUNT_VENDOR.ACCOUNT_TYPE%TYPE
            , P_CURRENCY_CODE        IN FI_BANK_ACCOUNT_VENDOR.CURRENCY_CODE%TYPE
            , P_REMARK               IN FI_BANK_ACCOUNT_VENDOR.REMARK%TYPE
            , P_ENABLED_FLAG         IN FI_BANK_ACCOUNT_VENDOR.ENABLED_FLAG%TYPE
            , P_EFFECTIVE_DATE_FR    IN FI_BANK_ACCOUNT_VENDOR.EFFECTIVE_DATE_FR%TYPE
            , P_EFFECTIVE_DATE_TO    IN FI_BANK_ACCOUNT_VENDOR.EFFECTIVE_DATE_TO%TYPE
            , P_USER_ID              IN FI_BANK_ACCOUNT_VENDOR.CREATED_BY%TYPE
            );

 --------------------------------------
 -- SUPPLIER_CODE Duplication check  --
 --------------------------------------
 PROCEDURE CHK_CUST_SITE_CODE_DUP( P_SOB_ID          IN   NUMBER
                                 , P_ORG_ID          IN   NUMBER
                                 , P_CUST_SITE_CODE  IN   AR_CUSTOMER_SITE.CUST_SITE_CODE%TYPE
                                 , X_CHECK_RESULT    OUT  VARCHAR2) ;

 --------------------------------------
 -- TAX_REG_NO Duplication check     --
 --------------------------------------
 PROCEDURE CHK_TAX_REG_NO_DUP ( P_SOB_ID          IN   NUMBER
                              , P_ORG_ID          IN   NUMBER
                              , P_TAX_REG_NO      IN   AP_SUPPLIER.TAX_REG_NO%TYPE
                              , X_CHECK_RESULT    OUT  VARCHAR2);

 -------------------------------------------------------------------
 -- TAX_REG_NO Duplication check  : 해당 고객사는 제외하고 체크   --
 -------------------------------------------------------------------
 PROCEDURE TAX_REG_NO_DUP_P   ( P_SOB_ID          IN   NUMBER
                              , P_ORG_ID          IN   NUMBER
                              , P_CUST_SITE_ID    IN   AR_CUSTOMER_SITE.CUST_SITE_ID%TYPE
                              , P_TAX_REG_NO      IN   AR_CUSTOMER_SITE.TAX_REG_NO%TYPE
                              , X_CHECK_RESULT    OUT  VARCHAR2);
                              
                              
 PROCEDURE FIND_MAX_CODE( P_SOB_ID          IN   NUMBER
                        , P_ORG_ID          IN   NUMBER
                        , X_CODE            IN   VARCHAR2
                        , X_CHECK_RESULT    OUT  VARCHAR2);
end AR_CUSTOMER_SITE_G; 
/
create or replace package body AR_CUSTOMER_SITE_G is
/******************************************************************************/
/* Project      : FLEX ERP
/* Module       : FCM
/* Program Name : AR_CUSTOMER_SITE_G
/* Description  : CUSTOMER SITE MASTER
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Shin Man Jae       Initialize
/* 31-DEC-2010  IN DAE IN          UPDATE -> AR_CUST_SITE_INSERT
/******************************************************************************/

 --------------
 -- SELECT   --
 --------------
 PROCEDURE AR_CUST_SITE_SELECT ( P_CURSOR                OUT  TYPES.TCURSOR
                               , W_SOB_ID                IN   NUMBER
                               , W_ORG_ID                IN   NUMBER
                               , W_CUST_SITE_ID          IN   NUMBER
                               , W_CUST_PARTY_ID         IN   NUMBER
                               , X_ERR_MSG               OUT  VARCHAR2
                               )
 IS
 BEGIN
       BEGIN
       OPEN P_CURSOR FOR
       SELECT ACS.CUST_SITE_ID
            ,  ACS.SOB_ID
            ,  ACS.ORG_ID
            ,  ACS.CUST_SITE_CODE
            ,  ACS.CUST_SITE_FULL_NAME
            ,  ACS.CUST_SITE_SHORT_NAME
            ,  ACS.CUST_PARTY_ID
            , ACP.CUST_PARTY_DESC
            ,  ACS.TAX_REG_NO
            ,  ACS.COUNTRY_CODE
            , EC.COUNTRY_SHORT_NAME
            ,  ACS.ZIP_CODE
            ,  ACS.ADDRESS_1
            ,  ACS.ADDRESS_2
            ,  ACS.PRESIDENT_NAME
            ,  ACS.BUSINESS_TYPE_LCODE
            , ELE_BT.ENTRY_DESCRIPTION       BUSINESS_TYPE_DESC
            ,  ACS.BUSINESS_CONDITION
            ,  ACS.BUSINESS_ITEM
            ,  ACS.TAX_BILL_TYPE_LCODE
            , ELE_ET.ENTRY_DESCRIPTION       TAX_BILL_TYPE_DESC
            ,  ACS.OE_ORDER_FLAG
            ,  ACS.WIP_PROCESS_FLAG
            ,  ACS.OE_DELIVERY_FLAG
            ,  ACS.SALES_PERSON_ID
            , HPM.DISPLAY_NAME               SALES_PERSON_NAME
            ,  ACS.PRIMARY_CURRENCY_CODE
            ,  ACS.SELL_LIMIT_AMOUNT
            ,  ACS.CREDIT_LIMIT_AMOUNT
            ,  ACS.PRICE_TERM_ID
            , EPT.PRICE_TERM_TYPE
            ,  ACS.PAYMENT_METHOD_ID
            , EPM.PAYMENT_METHOD_TYPE
            ,  ACS.PAYMENT_TERM_ID
            , EPA.PAYMENT_TERM_TYPE
            ,  ACS.SHIPPING_METHOD_LCODE
            , ELE_SM.ENTRY_DESCRIPTION       SHIPPING_METHOD_DESC
            ,  ACS.LOADING_PORT_ID
            , EPL.PORT_CODE                  LOADING_PORT_CODE
            , EPL.PORT_DESCRIPTION           LOADING_PORT_DESC
            ,  ACS.DESTINATION_PORT_ID
            , EPD.PORT_CODE                  DESTINATION_PORT_CODE
            , EPD.PORT_DESCRIPTION           DESTINATION_PORT_DESC
            ,  ACS.EFFECTIVE_DATE_FR
            ,  ACS.EFFECTIVE_DATE_TO
            ,  ACS.ENABLED_FLAG
            ,  ACS.ATTRIBUTE_A
            ,  ACS.ATTRIBUTE_B
            ,  ACS.ATTRIBUTE_C
            ,  ACS.ATTRIBUTE_D
            ,  ACS.ATTRIBUTE_E
            ,  ACS.ATTRIBUTE_F
            ,  ACS.ATTRIBUTE_G
            ,  ACS.ATTRIBUTE_H
            ,  ACS.ATTRIBUTE_1
            ,  ACS.ATTRIBUTE_2
            ,  ACS.ATTRIBUTE_3
            ,  ACS.ATTRIBUTE_4
            ,  ACS.ATTRIBUTE_5
            ,  ACS.ATTRIBUTE_6
            ,  ACS.ATTRIBUTE_7
            ,  ACS.CREATION_DATE
            ,  ACS.CREATED_BY
            ,  ACS.LAST_UPDATE_DATE
            ,  ACS.LAST_UPDATED_BY
            , ACS.CUST_SITE_SHORT_CODE
         FROM AR_CUSTOMER_SITE       ACS
            , AR_CUSTOMER_PARTY      ACP
            , EAPP_COUNTRY           EC
            , EAPP_LOOKUP_ENTRY_TLV  ELE_BT
            , EAPP_LOOKUP_ENTRY_TLV  ELE_ET
            , HRM_PERSON_MASTER      HPM
            , EAPP_PRICE_TERM        EPT
            , EAPP_PAYMENT_METHOD    EPM
            , EAPP_PAYMENT_TERM      EPA
            , EAPP_LOOKUP_ENTRY_TLV  ELE_SM
            , EAPP_PORT              EPL
            , EAPP_PORT              EPD
        WHERE ACP.CUST_PARTY_ID(+)   = ACS.CUST_PARTY_ID
          AND EC.SOB_ID(+)           = ACS.SOB_ID
          AND EC.ORG_ID(+)           = ACS.ORG_ID
          AND EC.COUNTRY_CODE(+)     = ACS.COUNTRY_CODE
          AND ELE_BT.SOB_ID(+)       = ACS.SOB_ID
          AND ELE_BT.ORG_ID(+)       = ACS.ORG_ID
          AND ELE_BT.LOOKUP_TYPE(+)  = 'BUSINESS_TYPE'
          AND ELE_BT.ENTRY_CODE(+)   = ACS.BUSINESS_TYPE_LCODE
          AND ELE_ET.SOB_ID(+)       = ACS.SOB_ID
          AND ELE_ET.ORG_ID(+)       = ACS.ORG_ID
          AND ELE_ET.LOOKUP_TYPE(+)  = 'TAX_BILL_TYPE'
          AND ELE_ET.ENTRY_CODE(+)   = ACS.TAX_BILL_TYPE_LCODE
          AND HPM.PERSON_ID(+)       = ACS.SALES_PERSON_ID
          AND EPT.PRICE_TERM_ID(+)   = ACS.PRICE_TERM_ID
          AND EPM.PAYMENT_METHOD_ID(+) = ACS.PAYMENT_METHOD_ID
          AND EPA.PAYMENT_TERM_ID(+)   = ACS.PAYMENT_TERM_ID
          AND ELE_SM.SOB_ID(+)         = ACS.SOB_ID
          AND ELE_SM.ORG_ID(+)         = ACS.ORG_ID
          AND ELE_SM.LOOKUP_TYPE(+)    = 'SHIPPING_METHOD'
          AND ELE_SM.ENTRY_CODE(+)     = ACS.SHIPPING_METHOD_LCODE
          AND EPL.PORT_ID(+)           = ACS.LOADING_PORT_ID
          AND EPD.PORT_ID(+)           = ACS.DESTINATION_PORT_ID
          AND ACS.SOB_ID               = W_SOB_ID
          AND ACS.ORG_ID               = W_ORG_ID
          AND ACS.CUST_SITE_ID         = NVL(W_CUST_SITE_ID, ACS.CUST_SITE_ID)
          AND ACS.CUST_PARTY_ID        = NVL(W_CUST_PARTY_ID, ACS.CUST_PARTY_ID)
        ORDER BY ACS.CUST_SITE_SHORT_NAME
       ;
       EXCEPTION WHEN NO_DATA_FOUND THEN
                     X_ERR_MSG := 'NO DATA FOUND';
                 WHEN OTHERS THEN
                     X_ERR_MSG := SQLERRM;
       END;


 END AR_CUST_SITE_SELECT;


 --------------
 -- INSERT   --
 --------------
 PROCEDURE AR_CUST_SITE_INSERT( P_CUST_SITE_ID                OUT AR_CUSTOMER_SITE.CUST_SITE_ID%TYPE
                              ,  P_SOB_ID                     IN  AR_CUSTOMER_SITE.SOB_ID%TYPE
                              ,  P_ORG_ID                     IN  AR_CUSTOMER_SITE.ORG_ID%TYPE
                              ,  P_CUST_SITE_CODE             OUT AR_CUSTOMER_SITE.CUST_SITE_CODE%TYPE
                              ,  P_CUST_SITE_FULL_NAME        IN AR_CUSTOMER_SITE.CUST_SITE_FULL_NAME%TYPE
                              ,  P_CUST_SITE_SHORT_NAME       IN AR_CUSTOMER_SITE.CUST_SITE_SHORT_NAME%TYPE
                              ,  P_CUST_SITE_SHORT_CODE       IN AR_CUSTOMER_SITE.CUST_SITE_SHORT_CODE%TYPE
                              ,  P_CUST_PARTY_ID              IN AR_CUSTOMER_SITE.CUST_PARTY_ID%TYPE
                              ,  P_TAX_REG_NO                 IN AR_CUSTOMER_SITE.TAX_REG_NO%TYPE
                              ,  P_COUNTRY_CODE               IN AR_CUSTOMER_SITE.COUNTRY_CODE%TYPE
                              ,  P_ZIP_CODE                   IN AR_CUSTOMER_SITE.ZIP_CODE%TYPE
                              ,  P_ADDRESS_1                  IN AR_CUSTOMER_SITE.ADDRESS_1%TYPE
                              ,  P_ADDRESS_2                  IN AR_CUSTOMER_SITE.ADDRESS_2%TYPE
                              ,  P_PRESIDENT_NAME             IN AR_CUSTOMER_SITE.PRESIDENT_NAME%TYPE
                              ,  P_BUSINESS_TYPE_LCODE        IN AR_CUSTOMER_SITE.BUSINESS_TYPE_LCODE%TYPE
                              ,  P_BUSINESS_CONDITION         IN AR_CUSTOMER_SITE.BUSINESS_CONDITION%TYPE
                              ,  P_BUSINESS_ITEM              IN AR_CUSTOMER_SITE.BUSINESS_ITEM%TYPE
                              ,  P_TAX_BILL_TYPE_LCODE        IN AR_CUSTOMER_SITE.TAX_BILL_TYPE_LCODE%TYPE
                              ,  P_OE_ORDER_FLAG              IN AR_CUSTOMER_SITE.OE_ORDER_FLAG%TYPE
                              ,  P_WIP_PROCESS_FLAG           IN AR_CUSTOMER_SITE.WIP_PROCESS_FLAG%TYPE
                              ,  P_OE_DELIVERY_FLAG           IN AR_CUSTOMER_SITE.OE_DELIVERY_FLAG%TYPE
                              ,  P_SALES_PERSON_ID            IN AR_CUSTOMER_SITE.SALES_PERSON_ID%TYPE
                              ,  P_PRIMARY_CURRENCY_CODE      IN AR_CUSTOMER_SITE.PRIMARY_CURRENCY_CODE%TYPE
                              ,  P_SELL_LIMIT_AMOUNT          IN AR_CUSTOMER_SITE.SELL_LIMIT_AMOUNT%TYPE
                              ,  P_CREDIT_LIMIT_AMOUNT        IN AR_CUSTOMER_SITE.CREDIT_LIMIT_AMOUNT%TYPE
                              ,  P_PRICE_TERM_ID              IN AR_CUSTOMER_SITE.PRICE_TERM_ID%TYPE
                              ,  P_PAYMENT_METHOD_ID          IN AR_CUSTOMER_SITE.PAYMENT_METHOD_ID%TYPE
                              ,  P_PAYMENT_TERM_ID            IN AR_CUSTOMER_SITE.PAYMENT_TERM_ID%TYPE
                              ,  P_SHIPPING_METHOD_LCODE      IN AR_CUSTOMER_SITE.SHIPPING_METHOD_LCODE%TYPE
                              ,  P_LOADING_PORT_ID            IN AR_CUSTOMER_SITE.LOADING_PORT_ID%TYPE
                              ,  P_DESTINATION_PORT_ID        IN AR_CUSTOMER_SITE.DESTINATION_PORT_ID%TYPE
                              ,  P_EFFECTIVE_DATE_FR          IN AR_CUSTOMER_SITE.EFFECTIVE_DATE_FR%TYPE
                              ,  P_EFFECTIVE_DATE_TO          IN AR_CUSTOMER_SITE.EFFECTIVE_DATE_TO%TYPE
                              ,  P_ENABLED_FLAG               IN AR_CUSTOMER_SITE.ENABLED_FLAG%TYPE
                              ,  P_ATTRIBUTE_A                IN AR_CUSTOMER_SITE.ATTRIBUTE_A%TYPE
                              ,  P_ATTRIBUTE_B                IN AR_CUSTOMER_SITE.ATTRIBUTE_B%TYPE
                              ,  P_ATTRIBUTE_C                IN AR_CUSTOMER_SITE.ATTRIBUTE_C%TYPE
                              ,  P_ATTRIBUTE_D                IN AR_CUSTOMER_SITE.ATTRIBUTE_D%TYPE
                              ,  P_ATTRIBUTE_E                IN AR_CUSTOMER_SITE.ATTRIBUTE_E%TYPE
                              ,  P_ATTRIBUTE_F                IN AR_CUSTOMER_SITE.ATTRIBUTE_F%TYPE
                              ,  P_ATTRIBUTE_G                IN AR_CUSTOMER_SITE.ATTRIBUTE_G%TYPE
                              ,  P_ATTRIBUTE_H                IN AR_CUSTOMER_SITE.ATTRIBUTE_H%TYPE
                              ,  P_ATTRIBUTE_1                IN AR_CUSTOMER_SITE.ATTRIBUTE_1%TYPE
                              ,  P_ATTRIBUTE_2                IN AR_CUSTOMER_SITE.ATTRIBUTE_2%TYPE
                              ,  P_ATTRIBUTE_3                IN AR_CUSTOMER_SITE.ATTRIBUTE_3%TYPE
                              ,  P_ATTRIBUTE_4                IN AR_CUSTOMER_SITE.ATTRIBUTE_4%TYPE
                              ,  P_ATTRIBUTE_5                IN AR_CUSTOMER_SITE.ATTRIBUTE_5%TYPE
                              ,  P_ATTRIBUTE_6                IN AR_CUSTOMER_SITE.ATTRIBUTE_6%TYPE
                              ,  P_ATTRIBUTE_7                IN AR_CUSTOMER_SITE.ATTRIBUTE_7%TYPE
                              ,  P_USER_ID                    IN  NUMBER
                              )
 IS

       V_LOCAL_DATE       DATE := GET_LOCAL_DATE(P_SOB_ID);
       V_QTY              NUMBER := 0;
       V_SOB_COUNTRY_CODE VARCHAR2(50);
       V_TAX_REG_NO       VARCHAR2(50);
 BEGIN
       FIND_MAX_CODE(P_SOB_ID, P_ORG_ID, 'C', P_CUST_SITE_CODE);
       
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
       IF P_COUNTRY_CODE = V_SOB_COUNTRY_CODE THEN
           /* -- 전호수 주석 : 프로그램에서 동일한 사업자번호 존재 체크해서 입력여부 확인후 저장하므로 프로시져에서는 체크 안함.
           -- 사업자번호 중복체크--
           BEGIN
                 SELECT COUNT(*)
                   INTO V_QTY
                   FROM FI_SUPP_CUST_V  V
                  WHERE V.SOB_ID         = P_SOB_ID
                    AND V.ORG_ID         = P_ORG_ID
                    AND V.SUPP_CUST_TYPE = 'C'
                    AND V.TAX_REG_NO     = P_TAX_REG_NO
                    AND V.SUPP_CUST_ID  != P_CUST_SITE_ID
                  ;
           EXCEPTION WHEN OTHERS THEN
                V_QTY := 0;
           END;
           IF NVL(V_QTY,0) > 0 THEN
               RAISE_APPLICATION_ERROR(-20011, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_90003', '&&FIELD_NAME:= ' || 'TAX REGISTER NO' ));
           END IF;*/
           
           V_TAX_REG_NO := P_TAX_REG_NO;
           IF P_BUSINESS_TYPE_LCODE = 'PERSON' THEN
             -- 주민번호 검증.
             IF REPLACE(V_TAX_REG_NO, '-', '') IS NOT NULL THEN
               IF EAPP_NUM_DIGIT_CHECKER_G.CHECK_REPRE_NUM_F(P_TAX_REG_NO) = 'N' THEN
                 RAISE_APPLICATION_ERROR(-20011, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10009', NULL));
               END IF;
               -- 사업자번호 FORMAT 적용.
               V_TAX_REG_NO := REPLACE(V_TAX_REG_NO, '-', '');
               V_TAX_REG_NO := SUBSTR(V_TAX_REG_NO, 1, 6) || '-' || SUBSTR(V_TAX_REG_NO, 7, 7);
             END IF;
           ELSE
             -- 사업자번호 검증.
             IF REPLACE(V_TAX_REG_NO, '-', '') IS NOT NULL THEN
               IF EAPP_NUM_DIGIT_CHECKER_G.CHECK_TAX_NUM_F(P_TAX_REG_NO) = 'N' THEN
                 RAISE_APPLICATION_ERROR(-20011, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10009', NULL));
               END IF;
               -- 사업자번호 FORMAT 적용.
               V_TAX_REG_NO := REPLACE(V_TAX_REG_NO, '-', '');
               V_TAX_REG_NO := SUBSTR(V_TAX_REG_NO, 1, 3) || '-' || SUBSTR(V_TAX_REG_NO, 4, 2) || '-' || SUBSTR(V_TAX_REG_NO, 6, 6);
             END IF;             
           END IF;
       END IF;
       
       -- SUPPLIER_ID SEQ Generate
       SELECT FI_CUST_SUPPLIER_S1.NEXTVAL
         INTO P_CUST_SITE_ID
         FROM DUAL;

       -- Insert
       INSERT INTO AR_CUSTOMER_SITE
                  (  CUST_SITE_ID
                  ,  SOB_ID
                  ,  ORG_ID
                  ,  CUST_SITE_CODE
                  ,  CUST_SITE_FULL_NAME
                  ,  CUST_SITE_SHORT_NAME
                  ,  CUST_SITE_SHORT_CODE
                  ,  CUST_PARTY_ID
                  ,  TAX_REG_NO
                  ,  COUNTRY_CODE
                  ,  ZIP_CODE
                  ,  ADDRESS_1
                  ,  ADDRESS_2
                  ,  PRESIDENT_NAME
                  ,  BUSINESS_TYPE_LCODE
                  ,  BUSINESS_CONDITION
                  ,  BUSINESS_ITEM
                  ,  TAX_BILL_TYPE_LCODE
                  ,  OE_ORDER_FLAG
                  ,  WIP_PROCESS_FLAG
                  ,  OE_DELIVERY_FLAG
                  ,  SALES_PERSON_ID
                  ,  PRIMARY_CURRENCY_CODE
                  ,  SELL_LIMIT_AMOUNT
                  ,  CREDIT_LIMIT_AMOUNT
                  ,  PRICE_TERM_ID
                  ,  PAYMENT_METHOD_ID
                  ,  PAYMENT_TERM_ID
                  ,  SHIPPING_METHOD_LCODE
                  ,  LOADING_PORT_ID
                  ,  DESTINATION_PORT_ID
                  ,  EFFECTIVE_DATE_FR
                  ,  EFFECTIVE_DATE_TO
                  ,  ENABLED_FLAG
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
                  (  P_CUST_SITE_ID
                  ,  P_SOB_ID
                  ,  P_ORG_ID
                  ,  P_CUST_SITE_CODE
                  ,  P_CUST_SITE_FULL_NAME
                  ,  P_CUST_SITE_SHORT_NAME
                  ,  P_CUST_SITE_SHORT_CODE
                  ,  P_CUST_PARTY_ID
                  ,  V_TAX_REG_NO
                  ,  P_COUNTRY_CODE
                  ,  P_ZIP_CODE
                  ,  P_ADDRESS_1
                  ,  P_ADDRESS_2
                  ,  P_PRESIDENT_NAME
                  ,  P_BUSINESS_TYPE_LCODE
                  ,  P_BUSINESS_CONDITION
                  ,  P_BUSINESS_ITEM
                  ,  P_TAX_BILL_TYPE_LCODE
                  ,  P_OE_ORDER_FLAG
                  ,  P_WIP_PROCESS_FLAG
                  ,  P_OE_DELIVERY_FLAG
                  ,  P_SALES_PERSON_ID
                  ,  P_PRIMARY_CURRENCY_CODE
                  ,  P_SELL_LIMIT_AMOUNT
                  ,  P_CREDIT_LIMIT_AMOUNT
                  ,  P_PRICE_TERM_ID
                  ,  P_PAYMENT_METHOD_ID
                  ,  P_PAYMENT_TERM_ID
                  ,  P_SHIPPING_METHOD_LCODE
                  ,  P_LOADING_PORT_ID
                  ,  P_DESTINATION_PORT_ID
                  ,  P_EFFECTIVE_DATE_FR
                  ,  P_EFFECTIVE_DATE_TO
                  ,  P_ENABLED_FLAG
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
 END AR_CUST_SITE_INSERT;


 --------------
 -- UPDATE   --
 --------------
PROCEDURE AR_CUST_SITE_UPDATE ( W_CUST_SITE_ID               IN AR_CUSTOMER_SITE.CUST_SITE_ID%TYPE
                              ,	P_SOB_ID                     IN AR_CUSTOMER_SITE.SOB_ID%TYPE
                              ,	P_ORG_ID                     IN AR_CUSTOMER_SITE.ORG_ID%TYPE
                              ,	P_CUST_SITE_FULL_NAME        IN AR_CUSTOMER_SITE.CUST_SITE_FULL_NAME%TYPE
                              ,	P_CUST_SITE_SHORT_NAME       IN AR_CUSTOMER_SITE.CUST_SITE_SHORT_NAME%TYPE
                              , P_CUST_SITE_SHORT_CODE       IN AR_CUSTOMER_SITE.CUST_SITE_SHORT_CODE%TYPE
                              ,	P_CUST_PARTY_ID              IN AR_CUSTOMER_SITE.CUST_PARTY_ID%TYPE
                              ,	P_TAX_REG_NO                 IN AR_CUSTOMER_SITE.TAX_REG_NO%TYPE
                              ,	P_COUNTRY_CODE               IN AR_CUSTOMER_SITE.COUNTRY_CODE%TYPE
                              ,	P_ZIP_CODE                   IN AR_CUSTOMER_SITE.ZIP_CODE%TYPE
                              ,	P_ADDRESS_1                  IN AR_CUSTOMER_SITE.ADDRESS_1%TYPE
                              ,	P_ADDRESS_2                  IN AR_CUSTOMER_SITE.ADDRESS_2%TYPE
                              ,	P_PRESIDENT_NAME             IN AR_CUSTOMER_SITE.PRESIDENT_NAME%TYPE
                              ,	P_BUSINESS_TYPE_LCODE        IN AR_CUSTOMER_SITE.BUSINESS_TYPE_LCODE%TYPE
                              ,	P_BUSINESS_CONDITION         IN AR_CUSTOMER_SITE.BUSINESS_CONDITION%TYPE
                              ,	P_BUSINESS_ITEM              IN AR_CUSTOMER_SITE.BUSINESS_ITEM%TYPE
                              ,	P_TAX_BILL_TYPE_LCODE        IN AR_CUSTOMER_SITE.TAX_BILL_TYPE_LCODE%TYPE
                              ,	P_OE_ORDER_FLAG              IN AR_CUSTOMER_SITE.OE_ORDER_FLAG%TYPE
                              ,	P_WIP_PROCESS_FLAG           IN AR_CUSTOMER_SITE.WIP_PROCESS_FLAG%TYPE
                              ,	P_OE_DELIVERY_FLAG           IN AR_CUSTOMER_SITE.OE_DELIVERY_FLAG%TYPE
                              ,	P_SALES_PERSON_ID            IN AR_CUSTOMER_SITE.SALES_PERSON_ID%TYPE
                              ,	P_PRIMARY_CURRENCY_CODE      IN AR_CUSTOMER_SITE.PRIMARY_CURRENCY_CODE%TYPE
                              ,	P_SELL_LIMIT_AMOUNT          IN AR_CUSTOMER_SITE.SELL_LIMIT_AMOUNT%TYPE
                              ,	P_CREDIT_LIMIT_AMOUNT        IN AR_CUSTOMER_SITE.CREDIT_LIMIT_AMOUNT%TYPE
                              ,	P_PRICE_TERM_ID              IN AR_CUSTOMER_SITE.PRICE_TERM_ID%TYPE
                              ,	P_PAYMENT_METHOD_ID          IN AR_CUSTOMER_SITE.PAYMENT_METHOD_ID%TYPE
                              ,	P_PAYMENT_TERM_ID            IN AR_CUSTOMER_SITE.PAYMENT_TERM_ID%TYPE
                              ,	P_SHIPPING_METHOD_LCODE      IN AR_CUSTOMER_SITE.SHIPPING_METHOD_LCODE%TYPE
                              ,	P_LOADING_PORT_ID            IN AR_CUSTOMER_SITE.LOADING_PORT_ID%TYPE
                              ,	P_DESTINATION_PORT_ID        IN AR_CUSTOMER_SITE.DESTINATION_PORT_ID%TYPE
                              ,	P_EFFECTIVE_DATE_FR          IN AR_CUSTOMER_SITE.EFFECTIVE_DATE_FR%TYPE
                              ,	P_EFFECTIVE_DATE_TO          IN AR_CUSTOMER_SITE.EFFECTIVE_DATE_TO%TYPE
                              ,	P_ENABLED_FLAG               IN AR_CUSTOMER_SITE.ENABLED_FLAG%TYPE
                              ,	P_ATTRIBUTE_A                IN AR_CUSTOMER_SITE.ATTRIBUTE_A%TYPE
                              ,	P_ATTRIBUTE_B                IN AR_CUSTOMER_SITE.ATTRIBUTE_B%TYPE
                              ,	P_ATTRIBUTE_C                IN AR_CUSTOMER_SITE.ATTRIBUTE_C%TYPE
                              ,	P_ATTRIBUTE_D                IN AR_CUSTOMER_SITE.ATTRIBUTE_D%TYPE
                              ,	P_ATTRIBUTE_E                IN AR_CUSTOMER_SITE.ATTRIBUTE_E%TYPE
                              ,	P_ATTRIBUTE_F                IN AR_CUSTOMER_SITE.ATTRIBUTE_F%TYPE
                              ,	P_ATTRIBUTE_G                IN AR_CUSTOMER_SITE.ATTRIBUTE_G%TYPE
                              ,	P_ATTRIBUTE_H                IN AR_CUSTOMER_SITE.ATTRIBUTE_H%TYPE
                              ,	P_ATTRIBUTE_1                IN AR_CUSTOMER_SITE.ATTRIBUTE_1%TYPE
                              ,	P_ATTRIBUTE_2                IN AR_CUSTOMER_SITE.ATTRIBUTE_2%TYPE
                              ,	P_ATTRIBUTE_3                IN AR_CUSTOMER_SITE.ATTRIBUTE_3%TYPE
                              ,	P_ATTRIBUTE_4                IN AR_CUSTOMER_SITE.ATTRIBUTE_4%TYPE
                              ,	P_ATTRIBUTE_5                IN AR_CUSTOMER_SITE.ATTRIBUTE_5%TYPE
                              ,	P_ATTRIBUTE_6                IN AR_CUSTOMER_SITE.ATTRIBUTE_6%TYPE
                              ,	P_ATTRIBUTE_7                IN AR_CUSTOMER_SITE.ATTRIBUTE_7%TYPE
                              , P_USER_ID                    IN NUMBER
                              )
 IS
       V_LOCAL_DATE       DATE := GET_LOCAL_DATE(P_SOB_ID);
       V_QTY              NUMBER := 0;
       V_SOB_COUNTRY_CODE VARCHAR2(50);
       V_TAX_REG_NO     VARCHAR2(50);
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
           /*-- 전호수 주석 : 프로그램에서 동일한 사업자번호 존재 체크해서 입력여부 확인후 저장하므로 프로시져에서는 체크 안함.
           BEGIN
                 SELECT COUNT(*)
                   INTO V_QTY
                   FROM FI_SUPP_CUST_V  V
                  WHERE V.SOB_ID         = P_SOB_ID
                    AND V.ORG_ID         = P_ORG_ID
                    AND V.SUPP_CUST_TYPE = 'C'
                    AND V.TAX_REG_NO     = P_TAX_REG_NO
                    AND V.SUPP_CUST_ID  != W_CUST_SITE_ID
                  ;
           EXCEPTION WHEN OTHERS THEN
                V_QTY := 0;
           END;
           IF NVL(V_QTY,0) > 0 THEN
               RAISE_APPLICATION_ERROR(-20011, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_90003', '&&FIELD_NAME:= ' || 'TAX REGISTER NO' ));
           END IF;*/
           V_TAX_REG_NO := P_TAX_REG_NO;
           IF P_BUSINESS_TYPE_LCODE = 'PERSON' THEN
             -- 주민번호 검증.
             IF REPLACE(V_TAX_REG_NO, '-', '') IS NOT NULL THEN
               IF EAPP_NUM_DIGIT_CHECKER_G.CHECK_REPRE_NUM_F(P_TAX_REG_NO) = 'N' THEN
                 RAISE_APPLICATION_ERROR(-20011, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10009', NULL));
               END IF;
               -- 사업자번호 FORMAT 적용.
               V_TAX_REG_NO := REPLACE(V_TAX_REG_NO, '-', '');
               V_TAX_REG_NO := SUBSTR(V_TAX_REG_NO, 1, 6) || '-' || SUBSTR(V_TAX_REG_NO, 7, 7);
             END IF;
           ELSE
             -- 사업자번호 검증.
             IF REPLACE(V_TAX_REG_NO, '-', '') IS NOT NULL THEN
               IF EAPP_NUM_DIGIT_CHECKER_G.CHECK_TAX_NUM_F(P_TAX_REG_NO) = 'N' THEN
                 RAISE_APPLICATION_ERROR(-20011, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10009', NULL));
               END IF;
               -- 사업자번호 FORMAT 적용.
               V_TAX_REG_NO := REPLACE(V_TAX_REG_NO, '-', '');
               V_TAX_REG_NO := SUBSTR(V_TAX_REG_NO, 1, 3) || '-' || SUBSTR(V_TAX_REG_NO, 4, 2) || '-' || SUBSTR(V_TAX_REG_NO, 6, 6);
             END IF;             
           END IF;
       END IF;

       UPDATE AR_CUSTOMER_SITE    ACS
          SET CUST_SITE_FULL_NAME       = P_CUST_SITE_FULL_NAME
            ,  CUST_SITE_SHORT_NAME     = P_CUST_SITE_SHORT_NAME
            ,  CUST_SITE_SHORT_CODE     = P_CUST_SITE_SHORT_CODE
            ,  CUST_PARTY_ID            = P_CUST_PARTY_ID
            ,  TAX_REG_NO               = V_TAX_REG_NO
            ,  COUNTRY_CODE             = P_COUNTRY_CODE
            ,  ZIP_CODE                 = P_ZIP_CODE
            ,  ADDRESS_1                = P_ADDRESS_1
            ,  ADDRESS_2                = P_ADDRESS_2
            ,  PRESIDENT_NAME           = P_PRESIDENT_NAME
            ,  BUSINESS_TYPE_LCODE      = P_BUSINESS_TYPE_LCODE
            ,  BUSINESS_CONDITION       = P_BUSINESS_CONDITION
            ,  BUSINESS_ITEM            = P_BUSINESS_ITEM
            ,  TAX_BILL_TYPE_LCODE      = P_TAX_BILL_TYPE_LCODE
            ,  OE_ORDER_FLAG            = P_OE_ORDER_FLAG
            ,  WIP_PROCESS_FLAG         = P_WIP_PROCESS_FLAG
            ,  OE_DELIVERY_FLAG         = P_OE_DELIVERY_FLAG
            ,  SALES_PERSON_ID          = P_SALES_PERSON_ID
            ,  PRIMARY_CURRENCY_CODE    = P_PRIMARY_CURRENCY_CODE
            ,  SELL_LIMIT_AMOUNT        = P_SELL_LIMIT_AMOUNT
            ,  CREDIT_LIMIT_AMOUNT      = P_CREDIT_LIMIT_AMOUNT
            ,  PRICE_TERM_ID            = P_PRICE_TERM_ID
            ,  PAYMENT_METHOD_ID        = P_PAYMENT_METHOD_ID
            ,  PAYMENT_TERM_ID          = P_PAYMENT_TERM_ID
            ,  SHIPPING_METHOD_LCODE    = P_SHIPPING_METHOD_LCODE
            ,  LOADING_PORT_ID          = P_LOADING_PORT_ID
            ,  DESTINATION_PORT_ID      = P_DESTINATION_PORT_ID
            ,  EFFECTIVE_DATE_FR        = P_EFFECTIVE_DATE_FR
            ,  EFFECTIVE_DATE_TO        = P_EFFECTIVE_DATE_TO
            ,  ENABLED_FLAG             = P_ENABLED_FLAG
            ,  ATTRIBUTE_A              = P_ATTRIBUTE_A
            ,  ATTRIBUTE_B              = P_ATTRIBUTE_B
            ,  ATTRIBUTE_C              = P_ATTRIBUTE_C
            ,  ATTRIBUTE_D              = P_ATTRIBUTE_D
            ,  ATTRIBUTE_E              = P_ATTRIBUTE_E
            ,  ATTRIBUTE_F              = P_ATTRIBUTE_F
            ,  ATTRIBUTE_G              = P_ATTRIBUTE_G
            ,  ATTRIBUTE_H              = P_ATTRIBUTE_H
            ,  ATTRIBUTE_1              = P_ATTRIBUTE_1
            ,  ATTRIBUTE_2              = P_ATTRIBUTE_2
            ,  ATTRIBUTE_3              = P_ATTRIBUTE_3
            ,  ATTRIBUTE_4              = P_ATTRIBUTE_4
            ,  ATTRIBUTE_5              = P_ATTRIBUTE_5
            ,  ATTRIBUTE_6              = P_ATTRIBUTE_6
            ,  ATTRIBUTE_7              = P_ATTRIBUTE_7
            ,  LAST_UPDATE_DATE         = V_LOCAL_DATE
            ,  LAST_UPDATED_BY          = P_USER_ID
        WHERE ACS.CUST_SITE_ID          = W_CUST_SITE_ID;
      
 END AR_CUST_SITE_UPDATE;


 --------------
 -- DELETE   --
 --------------
 PROCEDURE AR_CUST_SITE_DELETE ( W_CUST_SITE_ID   IN   NUMBER
                               , X_ERR_MSG        OUT  VARCHAR2)
 IS
 BEGIN
     DELETE AR_CUSTOMER_SITE     ACS
      WHERE ACS.CUST_SITE_ID     = W_CUST_SITE_ID;
      
 END AR_CUST_SITE_DELETE;


 ------------------------------
 -- 고객관련 계좌정보 SELECT --
 ------------------------------
 PROCEDURE AR_CUST_BANK_ACCT_INFO( P_CURSOR                OUT  TYPES.TCURSOR
                                 , W_CUST_SITE_ID          IN   NUMBER
                                 )
 IS
 BEGIN
     OPEN P_CURSOR FOR
       SELECT BA.BANK_ACCOUNT_ID
           , BA.BANK_ID
           , FI_COMMON_G.ID_NAME_F(BA.BANK_ID) AS BANK_NAME
           , BA.BANK_ACCOUNT_CODE
           , BA.BANK_ACCOUNT_NAME
           , BA.BANK_ACCOUNT_NUM
           , BA.OWNER_NAME
           , BA.ACCOUNT_TYPE
           , FI_COMMON_G.CODE_NAME_F('ACCOUNT_TYPE', BA.ACCOUNT_TYPE, BA.SOB_ID, BA.ORG_ID) AS ACCOUNT_TYPE_NAME
           , BA.CURRENCY_CODE AS DISPLAY_CURRENCY_CODE
           , BA.CURRENCY_CODE
           , BA.VENDOR_ID
           , BA.REMARK
           , BA.ENABLED_FLAG
           , BA.EFFECTIVE_DATE_FR
           , BA.EFFECTIVE_DATE_TO
        FROM FI_BANK_ACCOUNT_VENDOR BA
       WHERE BA.VENDOR_TYPE            = 'CUSTOMER'
         AND BA.VENDOR_ID              = W_CUST_SITE_ID
       ;
       
 END AR_CUST_BANK_ACCT_INFO;

-- 은행계좌 삽입.
  PROCEDURE AR_SUP_BANK_ACCT_INSERT
            ( P_BANK_ACCOUNT_ID      OUT   FI_BANK_ACCOUNT_VENDOR.BANK_ACCOUNT_ID%TYPE
            , P_SOB_ID               IN    FI_BANK_ACCOUNT_VENDOR.SOB_ID%TYPE
            , P_ORG_ID               IN    FI_BANK_ACCOUNT_VENDOR.ORG_ID%TYPE
            , P_VENDOR_ID            IN    FI_BANK_ACCOUNT_VENDOR.VENDOR_ID%TYPE
            , P_BANK_ACCOUNT_CODE    OUT   FI_BANK_ACCOUNT_VENDOR.BANK_ACCOUNT_CODE%TYPE
            , P_BANK_ACCOUNT_NAME    IN    FI_BANK_ACCOUNT_VENDOR.BANK_ACCOUNT_NAME%TYPE
            , P_BANK_ID              IN    FI_BANK_ACCOUNT_VENDOR.BANK_ID%TYPE
            , P_BANK_ACCOUNT_NUM     IN    FI_BANK_ACCOUNT_VENDOR.BANK_ACCOUNT_NUM%TYPE
            , P_OWNER_NAME           IN    FI_BANK_ACCOUNT_VENDOR.OWNER_NAME%TYPE
            , P_ACCOUNT_TYPE         IN    FI_BANK_ACCOUNT_VENDOR.ACCOUNT_TYPE%TYPE
            , P_CURRENCY_CODE        IN    FI_BANK_ACCOUNT_VENDOR.CURRENCY_CODE%TYPE            
            , P_REMARK               IN    FI_BANK_ACCOUNT_VENDOR.REMARK%TYPE
            , P_ENABLED_FLAG         IN    FI_BANK_ACCOUNT_VENDOR.ENABLED_FLAG%TYPE
            , P_EFFECTIVE_DATE_FR    IN    FI_BANK_ACCOUNT_VENDOR.EFFECTIVE_DATE_FR%TYPE
            , P_EFFECTIVE_DATE_TO    IN    FI_BANK_ACCOUNT_VENDOR.EFFECTIVE_DATE_TO%TYPE
            , P_USER_ID              IN    FI_BANK_ACCOUNT_VENDOR.CREATED_BY%TYPE
            )
  AS
    V_SYSDATE   DATE := GET_LOCAL_DATE(P_SOB_ID);
    V_VENDOR_CODE       VARCHAR2(50);
    V_RECORD_COUNT      NUMBER := 0;
  BEGIN
    -- 동일 은행, 동일계좌번호 존재 여부 체크.
    BEGIN
      SELECT COUNT(BA.BANK_ACCOUNT_ID) AS RECORD_COUNT
        INTO V_RECORD_COUNT
        FROM FI_BANK_ACCOUNT_VENDOR BA
      WHERE BA.SOB_ID             = P_SOB_ID
        AND BA.VENDOR_TYPE        = 'CUSTOMER'
        AND BA.BANK_ID            = P_BANK_ID
        AND BA.BANK_ACCOUNT_NUM   = P_BANK_ACCOUNT_NUM
      ;
    EXCEPTION WHEN OTHERS THEN
      V_RECORD_COUNT := 0;  
    END;
    IF V_RECORD_COUNT > 0 THEN
      RAISE_APPLICATION_ERROR(-20001, 'Customer Bank Account Number : ' || ERRNUMS.Exist_Data_Desc);  
    END IF;
    
    -- 계좌코드 생성. - 거래처코드-XX
    BEGIN
      SELECT ACS.CUST_SITE_CODE
        INTO V_VENDOR_CODE
        FROM AR_CUSTOMER_SITE ACS
       WHERE ACS.CUST_SITE_ID     = P_VENDOR_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20001, 'Insert error : Customer Code not found. Check Supplier...');
    END;
    
    -- 동일한 은행 그룹코드 존재 체크.
    BEGIN
      SELECT V_VENDOR_CODE || '-' || LPAD(NVL(COUNT(BA.BANK_ACCOUNT_ID), 0) + 1, 2, '0') AS RECORD_COUNT
        INTO P_BANK_ACCOUNT_CODE
        FROM FI_BANK_ACCOUNT_VENDOR BA
       WHERE BA.SOB_ID            = P_SOB_ID
         AND BA.VENDOR_TYPE       = 'CUSTOMER'
         AND BA.VENDOR_ID         = P_VENDOR_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      P_BANK_ACCOUNT_CODE := V_VENDOR_CODE || '-01';
    END;
    
    SELECT FI_BANK_ACCOUNT_VENDOR_S1.NEXTVAL
      INTO P_BANK_ACCOUNT_ID
      FROM DUAL;

    INSERT INTO FI_BANK_ACCOUNT_VENDOR
    ( BANK_ACCOUNT_ID
    , SOB_ID
    , ORG_ID
    , VENDOR_TYPE
    , VENDOR_ID 
    , BANK_ACCOUNT_CODE
    , BANK_ACCOUNT_NAME
    , BANK_ID
    , BANK_ACCOUNT_NUM
    , OWNER_NAME
    , ACCOUNT_TYPE
    , CURRENCY_CODE
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
    , 'CUSTOMER'     -- VENDOR_TYPE
    , P_VENDOR_ID
    , P_BANK_ACCOUNT_CODE
    , P_BANK_ACCOUNT_NAME
    , P_BANK_ID
    , P_BANK_ACCOUNT_NUM
    , P_OWNER_NAME
    , P_ACCOUNT_TYPE
    , P_CURRENCY_CODE
    , P_REMARK
    , P_ENABLED_FLAG
    , P_EFFECTIVE_DATE_FR
    , P_EFFECTIVE_DATE_TO
    , V_SYSDATE
    , P_USER_ID
    , V_SYSDATE
    , P_USER_ID );
  END AR_SUP_BANK_ACCT_INSERT;


-- 은행계좌 수정.
  PROCEDURE AR_SUP_BANK_ACCT_UPDATE
            ( W_BANK_ACCOUNT_ID      IN FI_BANK_ACCOUNT_VENDOR.BANK_ACCOUNT_ID%TYPE
            , P_SOB_ID               IN FI_BANK_ACCOUNT_VENDOR.SOB_ID%TYPE
            , P_ORG_ID               IN FI_BANK_ACCOUNT_VENDOR.ORG_ID%TYPE
            , P_BANK_ACCOUNT_NAME    IN FI_BANK_ACCOUNT_VENDOR.BANK_ACCOUNT_NAME%TYPE
            , P_BANK_ID              IN FI_BANK_ACCOUNT_VENDOR.BANK_ID%TYPE
            , P_BANK_ACCOUNT_NUM     IN FI_BANK_ACCOUNT_VENDOR.BANK_ACCOUNT_NUM%TYPE
            , P_OWNER_NAME           IN FI_BANK_ACCOUNT_VENDOR.OWNER_NAME%TYPE
            , P_ACCOUNT_TYPE         IN FI_BANK_ACCOUNT_VENDOR.ACCOUNT_TYPE%TYPE
            , P_CURRENCY_CODE        IN FI_BANK_ACCOUNT_VENDOR.CURRENCY_CODE%TYPE
            , P_REMARK               IN FI_BANK_ACCOUNT_VENDOR.REMARK%TYPE
            , P_ENABLED_FLAG         IN FI_BANK_ACCOUNT_VENDOR.ENABLED_FLAG%TYPE
            , P_EFFECTIVE_DATE_FR    IN FI_BANK_ACCOUNT_VENDOR.EFFECTIVE_DATE_FR%TYPE
            , P_EFFECTIVE_DATE_TO    IN FI_BANK_ACCOUNT_VENDOR.EFFECTIVE_DATE_TO%TYPE
            , P_USER_ID              IN FI_BANK_ACCOUNT_VENDOR.CREATED_BY%TYPE
            )
  AS
    V_SYSDATE           DATE := GET_LOCAL_DATE(P_SOB_ID);
    V_RECORD_COUNT      NUMBER := 0;
  BEGIN
    -- 동일 은행, 동일계좌번호 존재 여부 체크.
    BEGIN
      SELECT COUNT(BA.BANK_ACCOUNT_ID) AS RECORD_COUNT
        INTO V_RECORD_COUNT
        FROM FI_BANK_ACCOUNT_VENDOR BA
      WHERE BA.SOB_ID             = P_SOB_ID
        AND BA.VENDOR_TYPE        = 'CUSTOMER'
        AND BA.BANK_ID            = P_BANK_ID
        AND BA.BANK_ACCOUNT_NUM   = P_BANK_ACCOUNT_NUM
        AND BA.BANK_ACCOUNT_ID    != W_BANK_ACCOUNT_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_RECORD_COUNT := 0;  
    END;
    IF V_RECORD_COUNT > 0 THEN
      RAISE_APPLICATION_ERROR(-20001, 'Customer Bank Account Number : ' || ERRNUMS.Exist_Data_Desc);  
    END IF;
    
    UPDATE FI_BANK_ACCOUNT_VENDOR
      SET BANK_ACCOUNT_NAME    = P_BANK_ACCOUNT_NAME
        , BANK_ACCOUNT_NUM     = P_BANK_ACCOUNT_NUM
        , OWNER_NAME           = P_OWNER_NAME
        , ACCOUNT_TYPE         = P_ACCOUNT_TYPE
        , CURRENCY_CODE        = P_CURRENCY_CODE
        , REMARK               = P_REMARK
        , ENABLED_FLAG         = P_ENABLED_FLAG
        , EFFECTIVE_DATE_FR    = P_EFFECTIVE_DATE_FR
        , EFFECTIVE_DATE_TO    = P_EFFECTIVE_DATE_TO
        , LAST_UPDATE_DATE     = V_SYSDATE
        , LAST_UPDATED_BY      = P_USER_ID
    WHERE BANK_ACCOUNT_ID      = W_BANK_ACCOUNT_ID
    ;
  END AR_SUP_BANK_ACCT_UPDATE;

 --------------------------------------
 -- SUPPLIER_CODE Duplication check  --
 --------------------------------------
 PROCEDURE CHK_CUST_SITE_CODE_DUP( P_SOB_ID          IN   NUMBER
                                 , P_ORG_ID          IN   NUMBER
                                 , P_CUST_SITE_CODE  IN   AR_CUSTOMER_SITE.CUST_SITE_CODE%TYPE
                                 , X_CHECK_RESULT    OUT  VARCHAR2)
 IS
    V_CHK_COUNT  NUMBER := 0;
 BEGIN

    BEGIN
      SELECT COUNT(*)
        INTO V_CHK_COUNT
        FROM AR_CUSTOMER_SITE   ACS
       WHERE ACS.SOB_ID         = P_SOB_ID
         AND ACS.ORG_ID         = P_ORG_ID
         AND ACS.CUST_SITE_CODE = P_CUST_SITE_CODE
         ;
    EXCEPTION WHEN OTHERS THEN
        V_CHK_COUNT := 0;
    END;

    IF NVL(V_CHK_COUNT,0) = 0 THEN
       X_CHECK_RESULT := 'Y';
    ELSE
       X_CHECK_RESULT := 'N';
    END IF;

 END CHK_CUST_SITE_CODE_DUP;

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
        FROM AR_CUSTOMER_SITE  ACS
       WHERE ACS.SOB_ID        = P_SOB_ID
         AND ACS.ORG_ID        = P_ORG_ID
         AND ACS.TAX_REG_NO    = P_TAX_REG_NO
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

 -------------------------------------------------------------------
 -- TAX_REG_NO Duplication check  : 해당 고객사는 제외하고 체크   --
 -------------------------------------------------------------------
 PROCEDURE TAX_REG_NO_DUP_P   ( P_SOB_ID          IN   NUMBER
                              , P_ORG_ID          IN   NUMBER
                              , P_CUST_SITE_ID    IN   AR_CUSTOMER_SITE.CUST_SITE_ID%TYPE
                              , P_TAX_REG_NO      IN   AR_CUSTOMER_SITE.TAX_REG_NO%TYPE
                              , X_CHECK_RESULT    OUT  VARCHAR2)
  AS
    V_CHK_COUNT  NUMBER := 0;
 BEGIN

    BEGIN
      SELECT COUNT(*)
        INTO V_CHK_COUNT
        FROM AR_CUSTOMER_SITE   ACS
       WHERE ACS.SOB_ID         = P_SOB_ID
         AND ACS.ORG_ID         = P_ORG_ID
         AND ACS.TAX_REG_NO     = P_TAX_REG_NO
         AND ((P_CUST_SITE_ID   IS NULL AND 1 = 1)
         OR   (ACS.CUST_SITE_ID != P_CUST_SITE_ID))         
         ;
    EXCEPTION WHEN OTHERS THEN
        V_CHK_COUNT := 0;
    END;

    IF NVL(V_CHK_COUNT,0) = 0 THEN
       X_CHECK_RESULT := 'Y';  -- 동일자료 없음.
    ELSE
       X_CHECK_RESULT := 'N';  -- 동일자료 존재.
    END IF;
    
  END TAX_REG_NO_DUP_P;
  
 --------------------------------------
 -- FIND MAX SUPPLIER_CODE, CUSTOM_CODE
 --------------------------------------
 PROCEDURE FIND_MAX_CODE( P_SOB_ID          IN   NUMBER
                        , P_ORG_ID          IN   NUMBER
                        , X_CODE            IN   VARCHAR2
                        , X_CHECK_RESULT    OUT  VARCHAR2)
 IS
    V_CHK_CUS_MAX NUMBER := 0;
    V_CHK_SUP_MAX NUMBER := 0;
 BEGIN

      SELECT MAX(TO_NUMBER(SUBSTR(CUST_SITE_CODE,2,6)))+1
        INTO V_CHK_CUS_MAX
        FROM AR_CUSTOMER_SITE   ACS
       WHERE ACS.SOB_ID         = P_SOB_ID
         AND ACS.ORG_ID         = P_ORG_ID
         ;

      SELECT MAX(TO_NUMBER(SUBSTR(SUPPLIER_CODE,2,6)))+1
        INTO V_CHK_SUP_MAX
        FROM AP_SUPPLIER        ACS
       WHERE ACS.SOB_ID         = P_SOB_ID
         AND ACS.ORG_ID         = P_ORG_ID
         ;

      IF (V_CHK_CUS_MAX > V_CHK_SUP_MAX ) THEN
        X_CHECK_RESULT := X_CODE || LPAD(TO_CHAR(V_CHK_CUS_MAX),6,'0');
      ELSE
        X_CHECK_RESULT := X_CODE || LPAD(TO_CHAR(V_CHK_SUP_MAX),6,'0');
      END IF;

 END FIND_MAX_CODE;


end AR_CUSTOMER_SITE_G; 
/
