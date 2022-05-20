create or replace package FI_SLIP_PRINT_G is
--==============================================================================
-- Project      : FLEX ERP
-- Module       : FCMF
-- Program Name : FI_SLIP_PRINT_G
-- Description  : Packing Box Define
--
-- Reference by :
-- Program History
--------------------------------------------------------------------------------
--   Date       In Charge          Description
--------------------------------------------------------------------------------
-- 01-DEC-2010  Sung Kil Te        Initialize
--==============================================================================

       PROCEDURE SELECT_SLIP_HEADER_LIST( P_CURSOR               OUT TYPES.TCURSOR
                                        , W_SLIP_DATE_FR         IN FI_SLIP_HEADER.SLIP_DATE%TYPE
                                        , W_SLIP_DATE_TO         IN FI_SLIP_HEADER.SLIP_DATE%TYPE
                                        , W_SLIP_HEADER_ID       IN FI_SLIP_HEADER.SLIP_HEADER_ID%TYPE
                                        , W_DEPT_ID              IN FI_SLIP_HEADER.DEPT_ID%TYPE
                                        , W_PERSON_ID            IN FI_SLIP_HEADER.PERSON_ID%TYPE
                                        , W_SLIP_TYPE            IN FI_SLIP_HEADER.SLIP_TYPE%TYPE
                                        , W_SOB_ID               IN FI_SLIP_HEADER.SOB_ID%TYPE
                                        , W_ORG_ID               IN FI_SLIP_HEADER.ORG_ID%TYPE
                                        );

       PROCEDURE SELECT_SLIP_LINE_PRINT( P_CURSOR                OUT TYPES.TCURSOR
                                       , W_SOB_ID                IN  FI_SLIP_LINE.SOB_ID%TYPE
                                       , W_ORG_ID                IN  FI_SLIP_LINE.ORG_ID%TYPE
                                       , W_SLIP_HEADER_ID        IN  FI_SLIP_LINE.SLIP_HEADER_ID%TYPE
                                       );

       PROCEDURE SELECT_SLIP_LINE_PRINT_2( P_CURSOR                OUT TYPES.TCURSOR
                                         , W_SOB_ID                IN  FI_SLIP_LINE.SOB_ID%TYPE
                                         , W_ORG_ID                IN  FI_SLIP_LINE.ORG_ID%TYPE
                                         , W_SLIP_HEADER_ID        IN  FI_SLIP_LINE.SLIP_HEADER_ID%TYPE
                                         );

       PROCEDURE SELECT_SLIP_LINE_PRINT_3( P_CURSOR                OUT TYPES.TCURSOR
                                         , W_SOB_ID                IN  FI_SLIP_LINE.SOB_ID%TYPE
                                         , W_ORG_ID                IN  FI_SLIP_LINE.ORG_ID%TYPE
                                         , W_SLIP_HEADER_ID        IN  FI_SLIP_LINE.SLIP_HEADER_ID%TYPE
                                         );

       PROCEDURE SELECT_SLIP_LINE_PRINT_4( P_CURSOR                   OUT TYPES.TCURSOR
                                         , W_SOB_ID                   IN  FI_SLIP_LINE.SOB_ID%TYPE
                                         , W_ORG_ID                   IN  FI_SLIP_LINE.ORG_ID%TYPE
                                         , W_SLIP_HEADER_INTERFACE_ID IN  FI_SLIP_HEADER_INTERFACE.HEADER_INTERFACE_ID%TYPE
                                         );

       PROCEDURE SELECT_SLIP_LINE_PRINT_5( P_CURSOR                   OUT TYPES.TCURSOR
                                         , W_SOB_ID                   IN  FI_SLIP_LINE.SOB_ID%TYPE
                                         , W_ORG_ID                   IN  FI_SLIP_LINE.ORG_ID%TYPE
                                         , W_SLIP_HEADER_INTERFACE_ID IN  FI_SLIP_HEADER_INTERFACE.HEADER_INTERFACE_ID%TYPE
                                         );

       PROCEDURE SELECT_SLIP_LINE_PRINT_6( P_CURSOR                   OUT TYPES.TCURSOR
                                         , W_SOB_ID                   IN  FI_SLIP_LINE.SOB_ID%TYPE
                                         , W_ORG_ID                   IN  FI_SLIP_LINE.ORG_ID%TYPE
                                         , W_SLIP_HEADER_INTERFACE_ID IN  FI_SLIP_HEADER_INTERFACE.HEADER_INTERFACE_ID%TYPE
                                         );

-- 관리항목 값에 대한 데이터 타입별 형식 지정.
  FUNCTION MANAGEMENT_VALUE_F
          ( P_SLIP_LINE_ID        IN FI_SLIP_LINE.SLIP_LINE_ID%TYPE
          , P_MANAGEMENT_SEQ      IN NUMBER
          , P_MANAGEMENT_VAULE    IN FI_SLIP_MANAGEMENT_ITEM.MANAGEMENT_VALUE%TYPE
          , P_SOB_ID              IN FI_SLIP_LINE.SOB_ID%TYPE
          ) RETURN VARCHAR2;
          
end FI_SLIP_PRINT_G; 
/
create or replace package body FI_SLIP_PRINT_G is
--==============================================================================
-- Project      : FLEX ERP
-- Module       : FCMF
-- Program Name : FI_SLIP_PRINT_G
-- Description  : Packing Box Define
--
-- Reference by :
-- Program History
--------------------------------------------------------------------------------
--   Date       In Charge          Description
--------------------------------------------------------------------------------
-- 01-DEC-2010  Sung Kil Te        Initialize
--==============================================================================


       PROCEDURE SELECT_SLIP_HEADER_LIST( P_CURSOR               OUT TYPES.TCURSOR
                                        , W_SLIP_DATE_FR         IN FI_SLIP_HEADER.SLIP_DATE%TYPE
                                        , W_SLIP_DATE_TO         IN FI_SLIP_HEADER.SLIP_DATE%TYPE
                                        , W_SLIP_HEADER_ID       IN FI_SLIP_HEADER.SLIP_HEADER_ID%TYPE
                                        , W_DEPT_ID              IN FI_SLIP_HEADER.DEPT_ID%TYPE
                                        , W_PERSON_ID            IN FI_SLIP_HEADER.PERSON_ID%TYPE
                                        , W_SLIP_TYPE            IN FI_SLIP_HEADER.SLIP_TYPE%TYPE
                                        , W_SOB_ID               IN FI_SLIP_HEADER.SOB_ID%TYPE
                                        , W_ORG_ID               IN FI_SLIP_HEADER.ORG_ID%TYPE
                                        )
       AS
       BEGIN
                 OPEN P_CURSOR FOR
                 SELECT 'N'  AS CHECK_BOX
                      , SH.SLIP_DATE
                      , SH.SLIP_NUM
                      , FI_DEPT_MASTER_G.DEPT_NAME_F(SH.DEPT_ID) AS DEPT_NAME
                      , HRM_PERSON_MASTER_G.NAME_F(SH.PERSON_ID) AS PERSON_NAME
                      , FI_DEPT_MASTER_G.DEPT_NAME_F(SH.BUDGET_DEPT_ID) AS BUDGET_DEPT_NAME
                      , SH.SLIP_TYPE
                      , FI_COMMON_G.CODE_NAME_F('SLIP_TYPE', SH.SLIP_TYPE, SH.SOB_ID) AS SLIP_TYPE_NAME
                      , SH.CONFIRM_YN
                      , SH.CONFIRM_DATE
                      , HRM_PERSON_MASTER_G.NAME_F(SH.CONFIRM_PERSON_ID) AS CONFIRM_PERSON_NAME
                      , SH.CHANGE_COUNT
                      , SH.GL_DATE
                      , SH.GL_NUM
                      , SH.GL_AMOUNT
                      , SH.CURRENCY_CODE
                      , SH.CURRENCY_CODE AS CURRENCY_DESC
                      , SH.EXCHANGE_RATE
                      , SH.GL_CURRENCY_AMOUNT
                      , S_BA.BANK_ACCOUNT_NAME AS REQ_BANK_ACCOUNT_NAME
                      , S_BA.BANK_ACCOUNT_NUM AS REQ_BANK_ACCOUNT_NUM
                      , SH.REQ_PAYABLE_TYPE
                      , FI_COMMON_G.CODE_NAME_F('PAYABLE_TYPE', SH.REQ_PAYABLE_TYPE, SH.SOB_ID) AS REQ_PAYABLE_TYPE_NAME
                      , SH.REQ_PAYABLE_DATE
                      , SH.REMARK
                      , SH.CLOSED_YN
                      , SH.SOB_ID
                      , SH.ORG_ID
                      , SH.REQ_BANK_ACCOUNT_ID
                      , SH.BUDGET_DEPT_ID
                      , SH.ACCOUNT_BOOK_ID
                      , SH.PERSON_ID
                      , SH.DEPT_ID
                      , SH.SLIP_HEADER_ID
                      ,(SELECT DM.DEPT_CODE  FROM  FI_DEPT_MASTER DM
                         WHERE DM.DEPT_ID = SH.DEPT_ID AND DM.SOB_ID = SH.SOB_ID) AS DEPT_CODE
                      ,(SELECT PM.PERSON_NUM  FROM HRM_PERSON_MASTER PM
                         WHERE PM.PERSON_ID = SH.PERSON_ID AND PM.SOB_ID = SH.SOB_ID ) AS PERSON_NUM
                   FROM FI_SLIP_HEADER SH
                     , (SELECT BA.BANK_ACCOUNT_ID
                             , FB.BANK_NAME
                             , BA.BANK_ACCOUNT_NAME
                             , BA.BANK_ACCOUNT_NUM
                          FROM FI_BANK_ACCOUNT BA
                             , FI_BANK FB
                         WHERE BA.BANK_ID      = FB.BANK_ID
                       ) S_BA
                  WHERE SH.REQ_BANK_ACCOUNT_ID     = S_BA.BANK_ACCOUNT_ID(+)
                    AND SH.SLIP_DATE               BETWEEN W_SLIP_DATE_FR AND W_SLIP_DATE_TO
                    AND SH.SLIP_HEADER_ID          = NVL(W_SLIP_HEADER_ID, SH.SLIP_HEADER_ID)
                    AND SH.SLIP_TYPE               = NVL(W_SLIP_TYPE, SH.SLIP_TYPE)
                    AND SH.DEPT_ID                 = NVL(W_DEPT_ID, SH.DEPT_ID)
                    AND SH.PERSON_ID               = NVL(W_PERSON_ID, SH.PERSON_ID)
                    AND SH.SOB_ID                  = W_SOB_ID
               ORDER BY SH.SLIP_DATE, SH.GL_DATE DESC
                      ;

       END;


       PROCEDURE SELECT_SLIP_LINE_PRINT( P_CURSOR                OUT TYPES.TCURSOR
                                       , W_SOB_ID                IN  FI_SLIP_LINE.SOB_ID%TYPE
                                       , W_ORG_ID                IN  FI_SLIP_LINE.ORG_ID%TYPE
                                       , W_SLIP_HEADER_ID        IN  FI_SLIP_LINE.SLIP_HEADER_ID%TYPE
                                       )

       IS

       BEGIN

                OPEN P_CURSOR FOR
                SELECT SL.SLIP_LINE_ID
                     , SL.SLIP_LINE_SEQ
                     , SL.SLIP_HEADER_ID
                     , SL.SOB_ID
                     , SL.DEPT_ID
                     ,(SELECT DM.DEPT_CODE  FROM  FI_DEPT_MASTER DM
                        WHERE DM.DEPT_ID = SL.DEPT_ID AND DM.SOB_ID = SL.SOB_ID) AS DEPT_CODE
                     , FI_DEPT_MASTER_G.DEPT_NAME_F(SL.DEPT_ID) AS DEPT_NAME
                     , SL.PERSON_ID
                     ,(SELECT PM.PERSON_NUM  FROM HRM_PERSON_MASTER PM
                        WHERE PM.PERSON_ID = SL.PERSON_ID AND PM.SOB_ID = SL.SOB_ID ) AS PERSON_NUM
                     , HRM_PERSON_MASTER_G.NAME_F(SL.PERSON_ID) AS PERSON_NAME
                     , SL.ACCOUNT_BOOK_ID
                     , SL.ACCOUNT_DR_CR
                     , FI_COMMON_G.CODE_NAME_F('ACCOUNT_DR_CR', SL.ACCOUNT_DR_CR, SL.SOB_ID, SL.ORG_ID) AS ACCOUNT_DR_CR_NAME
                     , SL.ACCOUNT_CONTROL_ID
                     , SL.ACCOUNT_CODE
                     , AC.ACCOUNT_DESC
                     , SL.CURRENCY_CODE
                     , SL.CURRENCY_CODE AS CURRENCY_DESC
                     , decode(SL.EXCHANGE_RATE, 0, NULL, SL.EXCHANGE_RATE) AS EXCHANGE_RATE
                     , decode(SL.GL_CURRENCY_AMOUNT, 0, NULL, SL.GL_CURRENCY_AMOUNT) AS GL_CURRENCY_AMOUNT
                     , SL.GL_AMOUNT
                     , EAPP_CURRENCY_G.DISPLAY_AMOUNT_F(SL.CURRENCY_CODE, DECODE(SL.ACCOUNT_DR_CR, '1', SL.GL_AMOUNT, NULL), W_SOB_ID, W_ORG_ID) AS DR_AMOUNT
                     , EAPP_CURRENCY_G.DISPLAY_AMOUNT_F(SL.CURRENCY_CODE, DECODE(SL.ACCOUNT_DR_CR, '2', SL.GL_AMOUNT, NULL), W_SOB_ID, W_ORG_ID) AS CR_AMOUNT
                     , SL.CUSTOMER_ID
                     , SCV.SUPP_CUST_NAME AS CUSTOMER_NAME
                     , SCV.TAX_REG_NO
                     , SL.BANK_ACCOUNT_ID
                     , BAT.BANK_ACCOUNT_NAME
                     , BAT.BANK_ACCOUNT_NUM
                     , SL.BUDGET_DEPT_ID
                     , FI_DEPT_MASTER_G.DEPT_NAME_F(SL.BUDGET_DEPT_ID) AS BUDGET_DEPT_NAME
                     , SL.COST_CENTER_ID
                     , FI_COMMON_G.COST_CENTER_CODE_F(SL.COST_CENTER_ID) AS COST_CENTER_CODE
                     , FI_COMMON_G.COST_CENTER_DESC_F(SL.COST_CENTER_ID) AS COST_CENTER_DESC
                     , SL.MANAGEMENT1
                     , FI_ACCOUNT_CONTROL_ITEM_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                                    , SL.ACCOUNT_DR_CR
                                                                    , 'MANAGEMENT1_ID'
                                                                    , SL.MANAGEMENT1
                                                                    , SL.SOB_ID) AS MANAGEMENT1_DESC
                     , SL.MANAGEMENT2
                     , FI_ACCOUNT_CONTROL_ITEM_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                                    , SL.ACCOUNT_DR_CR
                                                                    , 'MANAGEMENT2_ID'
                                                                    , SL.MANAGEMENT2
                                                                    , SL.SOB_ID) AS MANAGEMENT2_DESC
                     , SL.REFER1
                     , FI_ACCOUNT_CONTROL_ITEM_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                                    , SL.ACCOUNT_DR_CR
                                                                    , 'REFER1_ID'
                                                                    , SL.REFER1
                                                                    , SL.SOB_ID) AS REFER1_DESC
                     , SL.REFER2
                     , FI_ACCOUNT_CONTROL_ITEM_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                                    , SL.ACCOUNT_DR_CR
                                                                    , 'REFER2_ID'
                                                                    , SL.REFER2
                                                                    , SL.SOB_ID) AS REFER2_DESC
                     , SL.REFER3
                     , FI_ACCOUNT_CONTROL_ITEM_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                                    , SL.ACCOUNT_DR_CR
                                                                    , 'REFER3_ID'
                                                                    , SL.REFER3
                                                                    , SL.SOB_ID) AS REFER3_DESC
                     , SL.REFER4
                     , FI_ACCOUNT_CONTROL_ITEM_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                                    , SL.ACCOUNT_DR_CR
                                                                    , 'REFER4_ID'
                                                                    , SL.REFER4
                                                                    , SL.SOB_ID) AS REFER4_DESC
                     , SL.REFER5
                     , FI_ACCOUNT_CONTROL_ITEM_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                                    , SL.ACCOUNT_DR_CR
                                                                    , 'REFER5_ID'
                                                                    , SL.REFER5
                                                                    , SL.SOB_ID) AS REFER5_DESC
                     , SL.VOUCH_CODE
                     , FI_COMMON_G.CODE_NAME_F('VOUCH_CODE', SL.VOUCH_CODE, SL.SOB_ID, SL.ORG_ID) AS VOUCH_NAME
                     , SL.REFER_RATE
                     , SL.REFER_AMOUNT
                     , SL.REFER_DATE1
                     , SL.REFER_DATE2
                     , SL.REMARK
                     , SL.CLOSED_YN
                     , DECODE(ACI.MANAGEMENT1_ID, NULL, 'F', NVL(ACI.MANAGEMENT1_YN, 'N')) AS MANAGEMENT1_YN
                     , DECODE(ACI.MANAGEMENT2_ID, NULL, 'F', NVL(ACI.MANAGEMENT2_YN, 'N')) AS MANAGEMENT2_YN
                     , DECODE(ACI.REFER1_ID, NULL, 'F', NVL(ACI.REFER1_YN, 'N')) AS REFER1_YN
                     , DECODE(ACI.REFER2_ID, NULL, 'F', NVL(ACI.REFER2_YN, 'N')) AS REFER2_YN
                     , DECODE(ACI.REFER3_ID, NULL, 'F', NVL(ACI.REFER3_YN, 'N')) AS REFER3_YN
                     , DECODE(ACI.REFER4_ID, NULL, 'F', NVL(ACI.REFER4_YN, 'N')) AS REFER4_YN
                     , DECODE(ACI.REFER5_ID, NULL, 'F', NVL(ACI.REFER5_YN, 'N')) AS REFER5_YN
                     , DECODE(ACI.REFER_RATE_ID, NULL, 'F', NVL(ACI.REFER_RATE_YN, 'N'))     AS REFER_RATE_YN
                     , DECODE(ACI.REFER_AMOUNT_ID, NULL, 'F', NVL(ACI.REFER_AMOUNT_YN, 'N')) AS REFER_AMOUNT_YN
                     , DECODE(ACI.REFER_DATE1_ID, NULL, 'F', NVL(ACI.REFER_DATE1_YN, 'N'))   AS REFER_DATE1_YN
                     , DECODE(ACI.REFER_DATE2_ID, NULL, 'F', NVL(ACI.REFER_DATE2_YN, 'N'))   AS REFER_DATE2_YN
                     , NVL(ACI.VOUCH_YN, 'F')             AS VOUCH_YN
                     , NVL(AC.ACCOUNT_DR_CR, '1')         AS CONTROL_ACCOUNT_DR_CR
                     , NVL(AC.CUSTOMER_ENABLED_FLAG, 'N') AS CUSTOMER_ENABLED_FLAG
                     , NVL(AC.BANK_ACCOUNT_FLAG, 'N')     AS BANK_ACCOUNT_FLAG
                     , NVL(AC.CURRENCY_ENABLED_FLAG, 'N') AS CURRENCY_ENABLED_FLAG
                     , NVL(AC.VAT_ENABLED_FLAG, 'N')      AS VAT_ENABLED_FLAG
                     , NVL(AC.ACCOUNT_MICH_YN, 'N')       AS ACCOUNT_MICH_YN
                     , NVL(AC.BUDGET_ENABLED_FLAG, 'N')   AS BUDGET_ENABLED_FLAG
                     , NVL(AC.BUDGET_CONTROL_FLAG, 'N')   AS BUDGET_CONTROL_FLAG
                     , NVL(AC.BUDGET_BELONG_FLAG, 'N')    AS BUDGET_BELONG_FLAG
                     , NVL(AC.COST_CENTER_FLAG, 'N')      AS COST_CENTER_FLAG
                  FROM FI_SLIP_LINE                          SL
                     , FI_SUPP_CUST_V                        SCV
                     , FI_ACCOUNT_CONTROL                    AC
                     , FI_ACCOUNT_CONTROL_ITEM               ACI
                     , FI_BANK_ACCOUNT_TLV                   BAT
                 WHERE SL.CUSTOMER_ID                      = SCV.SUPP_CUST_ID(+)
                   AND SL.ACCOUNT_CONTROL_ID               = AC.ACCOUNT_CONTROL_ID(+)
                   AND SL.ACCOUNT_CONTROL_ID               = ACI.ACCOUNT_CONTROL_ID(+)
                   AND SL.ACCOUNT_DR_CR                    = ACI.ACCOUNT_DR_CR(+)
                   AND SL.SOB_ID                           = ACI.SOB_ID(+)
                   AND SL.BANK_ACCOUNT_ID                  = BAT.BANK_ACCOUNT_ID(+)
                   AND SL.SOB_ID                           = W_SOB_ID
                   AND SL.SLIP_HEADER_ID                   = W_SLIP_HEADER_ID
              ORDER BY SL.SLIP_LINE_SEQ
                     ;

       END;


       PROCEDURE SELECT_SLIP_LINE_PRINT_2( P_CURSOR                OUT TYPES.TCURSOR
                                         , W_SOB_ID                IN  FI_SLIP_LINE.SOB_ID%TYPE
                                         , W_ORG_ID                IN  FI_SLIP_LINE.ORG_ID%TYPE
                                         , W_SLIP_HEADER_ID        IN  FI_SLIP_LINE.SLIP_HEADER_ID%TYPE
                                         )

       IS

       BEGIN

                OPEN P_CURSOR FOR
                SELECT SL.SLIP_LINE_SEQ
                     , FI_COMMON_G.CODE_NAME_F('ACCOUNT_DR_CR', SL.ACCOUNT_DR_CR, SL.SOB_ID, SL.ORG_ID) AS ACCOUNT_DR_CR_NAME
                     , SL.ACCOUNT_CODE
                     , AC.ACCOUNT_DESC
                     , EAPP_CURRENCY_G.DISPLAY_AMOUNT_F(SL.CURRENCY_CODE, DECODE(SL.ACCOUNT_DR_CR, '1', SL.GL_AMOUNT, NULL), W_SOB_ID, W_ORG_ID) AS DR_AMOUNT
                     , EAPP_CURRENCY_G.DISPLAY_AMOUNT_F(SL.CURRENCY_CODE, DECODE(SL.ACCOUNT_DR_CR, '2', SL.GL_AMOUNT, NULL), W_SOB_ID, W_ORG_ID) AS CR_AMOUNT
                     , NVL(FI_ACCOUNT_CONTROL_ITEM_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                                        , SL.ACCOUNT_DR_CR
                                                                        , 'MANAGEMENT1_ID'
                                                                        , SL.MANAGEMENT1
                                                                        , SL.SOB_ID), SL.MANAGEMENT1)
                    || DECODE(SL.MANAGEMENT2, NULL, '', ' ')
                    || NVL(FI_ACCOUNT_CONTROL_ITEM_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                                        , SL.ACCOUNT_DR_CR
                                                                        , 'MANAGEMENT2_ID'
                                                                        , SL.MANAGEMENT2
                                                                        , SL.SOB_ID), SL.MANAGEMENT2)
                    || DECODE(SL.REFER1, NULL, '', ' ')
                    || NVL(FI_ACCOUNT_CONTROL_ITEM_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                                        , SL.ACCOUNT_DR_CR
                                                                        , 'REFER1_ID'
                                                                        , SL.REFER1
                                                                        , SL.SOB_ID), SL.REFER1)
                    || DECODE(SL.REFER2, NULL, '', ' ')
                    || NVL(FI_ACCOUNT_CONTROL_ITEM_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                                        , SL.ACCOUNT_DR_CR
                                                                        , 'REFER2_ID'
                                                                        , SL.REFER2
                                                                        , SL.SOB_ID), SL.REFER2)
                    || DECODE(SL.REFER3, NULL, '', ' ')
                    || NVL(FI_ACCOUNT_CONTROL_ITEM_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                                        , SL.ACCOUNT_DR_CR
                                                                        , 'REFER3_ID'
                                                                        , SL.REFER3
                                                                        , SL.SOB_ID), SL.REFER3)
                    || DECODE(SL.REFER4, NULL, '', ' ')
                    || NVL(FI_ACCOUNT_CONTROL_ITEM_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                                        , SL.ACCOUNT_DR_CR
                                                                        , 'REFER4_ID'
                                                                        , SL.REFER4
                                                                        , SL.SOB_ID), SL.REFER4)
                    || DECODE(SL.REFER5, NULL, '', ' ')
                    || NVL(FI_ACCOUNT_CONTROL_ITEM_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                                        , SL.ACCOUNT_DR_CR
                                                                        , 'REFER5_ID'
                                                                        , SL.REFER5
                                                                        , SL.SOB_ID), SL.REFER5)
                    || DECODE(SL.REFER6, NULL, '', ' ')
                    || NVL(FI_ACCOUNT_CONTROL_ITEM_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                                        , SL.ACCOUNT_DR_CR
                                                                        , 'REFER6_ID'
                                                                        , SL.REFER6
                                                                        , SL.SOB_ID), SL.REFER6)
                    || DECODE(SL.REFER7, NULL, '', ' ')
                    || NVL(FI_ACCOUNT_CONTROL_ITEM_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                                        , SL.ACCOUNT_DR_CR
                                                                        , 'REFER7_ID'
                                                                        , SL.REFER7
                                                                        , SL.SOB_ID), SL.REFER7)
                    || DECODE(SL.REFER8, NULL, '', ' ')
                    || NVL(FI_ACCOUNT_CONTROL_ITEM_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                                        , SL.ACCOUNT_DR_CR
                                                                        , 'REFER8_ID'
                                                                        , SL.REFER8
                                                                        , SL.SOB_ID), SL.REFER8)
                       AS M_REFERENCE
                     , SL.REMARK
                     , SL.SLIP_HEADER_ID
                     , SL.SLIP_LINE_ID
                  FROM FI_SLIP_LINE                          SL
                     , FI_SUPP_CUST_V                        SCV
                     , FI_ACCOUNT_CONTROL                    AC
                     , FI_ACCOUNT_CONTROL_ITEM               ACI
                     , FI_BANK_ACCOUNT_TLV                   BAT
                 WHERE SL.CUSTOMER_ID                      = SCV.SUPP_CUST_ID(+)
                   AND SL.ACCOUNT_CONTROL_ID               = AC.ACCOUNT_CONTROL_ID(+)
                   AND SL.ACCOUNT_CONTROL_ID               = ACI.ACCOUNT_CONTROL_ID(+)
                   AND SL.ACCOUNT_DR_CR                    = ACI.ACCOUNT_DR_CR(+)
                   AND SL.SOB_ID                           = ACI.SOB_ID(+)
                   AND SL.BANK_ACCOUNT_ID                  = BAT.BANK_ACCOUNT_ID(+)
                   AND SL.SOB_ID                           = W_SOB_ID
                   AND SL.SLIP_HEADER_ID                   = W_SLIP_HEADER_ID
              ORDER BY SL.SLIP_LINE_SEQ
                     ;

       END;


       PROCEDURE SELECT_SLIP_LINE_PRINT_3( P_CURSOR                OUT TYPES.TCURSOR
                                         , W_SOB_ID                IN  FI_SLIP_LINE.SOB_ID%TYPE
                                         , W_ORG_ID                IN  FI_SLIP_LINE.ORG_ID%TYPE
                                         , W_SLIP_HEADER_ID        IN  FI_SLIP_LINE.SLIP_HEADER_ID%TYPE
                                         )

       IS

       BEGIN

                OPEN P_CURSOR FOR
                SELECT SL.SLIP_LINE_ID
                     , SL.SLIP_LINE_SEQ
                     , SL.SLIP_HEADER_ID
                     , SL.SOB_ID
                     , SL.DEPT_ID
                     ,(SELECT DM.DEPT_CODE  FROM  FI_DEPT_MASTER DM
                        WHERE DM.DEPT_ID = SL.DEPT_ID AND DM.SOB_ID = SL.SOB_ID) AS DEPT_CODE
                     , FI_DEPT_MASTER_G.DEPT_NAME_F(SL.DEPT_ID) AS DEPT_NAME
                     , SL.PERSON_ID
                     ,(SELECT PM.PERSON_NUM  FROM HRM_PERSON_MASTER PM
                        WHERE PM.PERSON_ID = SL.PERSON_ID AND PM.SOB_ID = SL.SOB_ID ) AS PERSON_NUM
                     , HRM_PERSON_MASTER_G.NAME_F(SL.PERSON_ID) AS PERSON_NAME
                     , SL.ACCOUNT_BOOK_ID
                     , SL.ACCOUNT_DR_CR
                     , FI_COMMON_G.CODE_NAME_F('ACCOUNT_DR_CR', SL.ACCOUNT_DR_CR, SL.SOB_ID, SL.ORG_ID) AS ACCOUNT_DR_CR_NAME
                     , SL.ACCOUNT_CONTROL_ID
                     , SL.ACCOUNT_CODE
                     , AC.ACCOUNT_DESC
                     , SL.CURRENCY_CODE
                     , SL.CURRENCY_CODE AS CURRENCY_DESC
                     , decode(SL.EXCHANGE_RATE, 0, NULL, SL.EXCHANGE_RATE) AS EXCHANGE_RATE
                     , decode(SL.GL_CURRENCY_AMOUNT, 0, NULL, SL.GL_CURRENCY_AMOUNT) AS GL_CURRENCY_AMOUNT
                     , SL.GL_AMOUNT
                     , EAPP_CURRENCY_G.DISPLAY_AMOUNT_F(SL.CURRENCY_CODE, DECODE(SL.ACCOUNT_DR_CR, '1', SL.GL_AMOUNT, NULL), W_SOB_ID, W_ORG_ID) AS DR_AMOUNT
                     , EAPP_CURRENCY_G.DISPLAY_AMOUNT_F(SL.CURRENCY_CODE, DECODE(SL.ACCOUNT_DR_CR, '2', SL.GL_AMOUNT, NULL), W_SOB_ID, W_ORG_ID) AS CR_AMOUNT
                     , SL.CUSTOMER_ID
                     , SCV.SUPP_CUST_NAME AS CUSTOMER_NAME
                     , SCV.TAX_REG_NO
                     , SL.BANK_ACCOUNT_ID
                     , BAT.BANK_ACCOUNT_NAME
                     , BAT.BANK_ACCOUNT_NUM
                     , SL.BUDGET_DEPT_ID
                     , FI_DEPT_MASTER_G.DEPT_NAME_F(SL.BUDGET_DEPT_ID) AS BUDGET_DEPT_NAME
                     , SL.COST_CENTER_ID
                     , FI_COMMON_G.COST_CENTER_CODE_F(SL.COST_CENTER_ID) AS COST_CENTER_CODE
                     , FI_COMMON_G.COST_CENTER_DESC_F(SL.COST_CENTER_ID) AS COST_CENTER_DESC
                     , NVL(FI_ACCOUNT_CONTROL_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                              , 'REFER1_ID'
                                                              , SL.MANAGEMENT1
                                                              , SL.SOB_ID), SL.MANAGEMENT1) AS MANAGEMENT1_DESC
                     , NVL(FI_ACCOUNT_CONTROL_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                              , 'REFER2_ID'
                                                              , SL.MANAGEMENT2
                                                              , SL.SOB_ID), SL.MANAGEMENT2) AS MANAGEMENT2_DESC
                     , NVL(FI_ACCOUNT_CONTROL_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                              , 'REFER3_ID'
                                                              , SL.REFER1
                                                              , SL.SOB_ID), SL.REFER1) AS REFER1_DESC
                     , NVL(FI_ACCOUNT_CONTROL_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                              , 'REFER4_ID'
                                                              , SL.REFER2
                                                              , SL.SOB_ID), SL.REFER2) AS REFER2_DESC
                     , NVL(FI_ACCOUNT_CONTROL_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                              , 'REFER5_ID'
                                                              , SL.REFER3
                                                              , SL.SOB_ID), SL.REFER3) AS REFER3_DESC
                     , NVL(FI_ACCOUNT_CONTROL_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                              , 'REFER6_ID'
                                                              , SL.REFER4
                                                              , SL.SOB_ID), SL.REFER4) AS REFER4_DESC
                     , NVL(FI_ACCOUNT_CONTROL_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                              , 'REFER7_ID'
                                                              , SL.REFER5
                                                              , SL.SOB_ID), SL.REFER5) AS REFER5_DESC
                     , NVL(FI_ACCOUNT_CONTROL_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                              , 'REFER8_ID'
                                                              , SL.REFER6
                                                              , SL.SOB_ID), SL.REFER6) AS REFER6_DESC
                     , NVL(FI_ACCOUNT_CONTROL_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                              , 'REFER9_ID'
                                                              , SL.REFER7
                                                              , SL.SOB_ID), SL.REFER7) AS REFER7_DESC
                     , NVL(FI_ACCOUNT_CONTROL_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                              , 'REFER10_ID'
                                                              , SL.REFER8
                                                              , SL.SOB_ID), SL.REFER8) AS REFER8_DESC
                     , NVL(FI_ACCOUNT_CONTROL_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                              , 'REFER11_ID'
                                                              , SL.REFER9
                                                              , SL.SOB_ID), SL.REFER9) AS REFER9_DESC
                     , NVL(FI_ACCOUNT_CONTROL_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                              , 'REFER12_ID'
                                                              , SL.REFER10
                                                              , SL.SOB_ID), SL.REFER10) AS REFER10_DESC
                     , NVL(FI_ACCOUNT_CONTROL_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                              , 'REFER13_ID'
                                                              , SL.REFER11
                                                              , SL.SOB_ID), SL.REFER11) AS REFER11_DESC
                     , NVL(FI_ACCOUNT_CONTROL_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                              , 'REFER14_ID'
                                                              , SL.REFER12
                                                              , SL.SOB_ID), SL.REFER12) AS REFER12_DESC
                     , SL.VOUCH_CODE
                     , FI_COMMON_G.CODE_NAME_F('VOUCH_CODE', SL.VOUCH_CODE, SL.SOB_ID, SL.ORG_ID) AS VOUCH_NAME
                     , SL.REFER_RATE
                     , SL.REFER_AMOUNT
                     , SL.REFER_DATE1
                     , SL.REFER_DATE2
                     , SL.REMARK
                  FROM FI_SLIP_LINE                          SL
                     , FI_SUPP_CUST_V                        SCV
                     , FI_ACCOUNT_CONTROL                    AC
                     , FI_ACCOUNT_CONTROL_ITEM               ACI
                     , FI_BANK_ACCOUNT_TLV                   BAT
                 WHERE SL.CUSTOMER_ID                      = SCV.SUPP_CUST_ID(+)
                   AND SL.ACCOUNT_CONTROL_ID               = AC.ACCOUNT_CONTROL_ID(+)
                   AND SL.ACCOUNT_CONTROL_ID               = ACI.ACCOUNT_CONTROL_ID(+)
                   AND SL.ACCOUNT_DR_CR                    = ACI.ACCOUNT_DR_CR(+)
                   AND SL.SOB_ID                           = ACI.SOB_ID(+)
                   AND SL.BANK_ACCOUNT_ID                  = BAT.BANK_ACCOUNT_ID(+)
                   AND SL.SOB_ID                           = W_SOB_ID
                   AND SL.SLIP_HEADER_ID                   = W_SLIP_HEADER_ID
              ORDER BY SL.SLIP_LINE_SEQ
                     ;

       END;


       PROCEDURE SELECT_SLIP_LINE_PRINT_4( P_CURSOR                   OUT TYPES.TCURSOR
                                         , W_SOB_ID                   IN  FI_SLIP_LINE.SOB_ID%TYPE
                                         , W_ORG_ID                   IN  FI_SLIP_LINE.ORG_ID%TYPE
                                         , W_SLIP_HEADER_INTERFACE_ID IN  FI_SLIP_HEADER_INTERFACE.HEADER_INTERFACE_ID%TYPE
                                         )

       IS

       BEGIN

                OPEN P_CURSOR FOR
                SELECT SL.SLIP_LINE_ID
                     , SL.SLIP_LINE_SEQ
                     , SL.SLIP_HEADER_ID
                     , SL.SOB_ID
                     , SL.DEPT_ID
                     ,(SELECT DM.DEPT_CODE  FROM  FI_DEPT_MASTER DM
                        WHERE DM.DEPT_ID = SL.DEPT_ID AND DM.SOB_ID = SL.SOB_ID) AS DEPT_CODE
                     , FI_DEPT_MASTER_G.DEPT_NAME_F(SL.DEPT_ID) AS DEPT_NAME
                     , SL.PERSON_ID
                     ,(SELECT PM.PERSON_NUM  FROM HRM_PERSON_MASTER PM
                        WHERE PM.PERSON_ID = SL.PERSON_ID AND PM.SOB_ID = SL.SOB_ID ) AS PERSON_NUM
                     , HRM_PERSON_MASTER_G.NAME_F(SL.PERSON_ID) AS PERSON_NAME
                     , SL.ACCOUNT_BOOK_ID
                     , SL.ACCOUNT_DR_CR
                     , FI_COMMON_G.CODE_NAME_F('ACCOUNT_DR_CR', SL.ACCOUNT_DR_CR, SL.SOB_ID, SL.ORG_ID) AS ACCOUNT_DR_CR_NAME
                     , SL.ACCOUNT_CONTROL_ID
                     , SL.ACCOUNT_CODE
                     , AC.ACCOUNT_DESC
                     , SL.CURRENCY_CODE
                     , SL.CURRENCY_CODE AS CURRENCY_DESC
                     , decode(SL.EXCHANGE_RATE, 0, NULL, SL.EXCHANGE_RATE) AS EXCHANGE_RATE
                     , decode(SL.GL_CURRENCY_AMOUNT, 0, NULL, SL.GL_CURRENCY_AMOUNT) AS GL_CURRENCY_AMOUNT
                     , SL.GL_AMOUNT
                     , EAPP_CURRENCY_G.DISPLAY_AMOUNT_F(SL.CURRENCY_CODE, DECODE(SL.ACCOUNT_DR_CR, '1', SL.GL_AMOUNT, NULL), W_SOB_ID, W_ORG_ID) AS DR_AMOUNT
                     , EAPP_CURRENCY_G.DISPLAY_AMOUNT_F(SL.CURRENCY_CODE, DECODE(SL.ACCOUNT_DR_CR, '2', SL.GL_AMOUNT, NULL), W_SOB_ID, W_ORG_ID) AS CR_AMOUNT
                     , SL.CUSTOMER_ID
                     , SCV.SUPP_CUST_NAME AS CUSTOMER_NAME
                     , SCV.TAX_REG_NO
                     , SL.BANK_ACCOUNT_ID
                     , BAT.BANK_ACCOUNT_NAME
                     , BAT.BANK_ACCOUNT_NUM
                     , SL.BUDGET_DEPT_ID
                     , FI_DEPT_MASTER_G.DEPT_NAME_F(SL.BUDGET_DEPT_ID) AS BUDGET_DEPT_NAME
                     , SL.COST_CENTER_ID
                     , FI_COMMON_G.COST_CENTER_CODE_F(SL.COST_CENTER_ID) AS COST_CENTER_CODE
                     , FI_COMMON_G.COST_CENTER_DESC_F(SL.COST_CENTER_ID) AS COST_CENTER_DESC
                     , NVL(FI_ACCOUNT_CONTROL_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                              , 'REFER1_ID'
                                                              , SL.MANAGEMENT1
                                                              , SL.SOB_ID), SL.MANAGEMENT1) AS MANAGEMENT1_DESC
                     , NVL(FI_ACCOUNT_CONTROL_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                              , 'REFER2_ID'
                                                              , SL.MANAGEMENT2
                                                              , SL.SOB_ID), SL.MANAGEMENT2) AS MANAGEMENT2_DESC
                     , NVL(FI_ACCOUNT_CONTROL_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                              , 'REFER3_ID'
                                                              , SL.REFER1
                                                              , SL.SOB_ID), SL.REFER1) AS REFER1_DESC
                     , NVL(FI_ACCOUNT_CONTROL_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                              , 'REFER4_ID'
                                                              , SL.REFER2
                                                              , SL.SOB_ID), SL.REFER2) AS REFER2_DESC
                     , NVL(FI_ACCOUNT_CONTROL_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                              , 'REFER5_ID'
                                                              , SL.REFER3
                                                              , SL.SOB_ID), SL.REFER3) AS REFER3_DESC
                     , NVL(FI_ACCOUNT_CONTROL_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                              , 'REFER6_ID'
                                                              , SL.REFER4
                                                              , SL.SOB_ID), SL.REFER4) AS REFER4_DESC
                     , NVL(FI_ACCOUNT_CONTROL_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                              , 'REFER7_ID'
                                                              , SL.REFER5
                                                              , SL.SOB_ID), SL.REFER5) AS REFER5_DESC
                     , NVL(FI_ACCOUNT_CONTROL_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                              , 'REFER8_ID'
                                                              , SL.REFER6
                                                              , SL.SOB_ID), SL.REFER6) AS REFER6_DESC
                     , NVL(FI_ACCOUNT_CONTROL_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                              , 'REFER9_ID'
                                                              , SL.REFER7
                                                              , SL.SOB_ID), SL.REFER7) AS REFER7_DESC
                     , NVL(FI_ACCOUNT_CONTROL_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                              , 'REFER10_ID'
                                                              , SL.REFER8
                                                              , SL.SOB_ID), SL.REFER8) AS REFER8_DESC
                     , NVL(FI_ACCOUNT_CONTROL_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                              , 'REFER11_ID'
                                                              , SL.REFER9
                                                              , SL.SOB_ID), SL.REFER9) AS REFER9_DESC
                     , NVL(FI_ACCOUNT_CONTROL_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                              , 'REFER12_ID'
                                                              , SL.REFER10
                                                              , SL.SOB_ID), SL.REFER10) AS REFER10_DESC
                     , NVL(FI_ACCOUNT_CONTROL_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                              , 'REFER13_ID'
                                                              , SL.REFER11
                                                              , SL.SOB_ID), SL.REFER11) AS REFER11_DESC
                     , NVL(FI_ACCOUNT_CONTROL_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                              , 'REFER14_ID'
                                                              , SL.REFER12
                                                              , SL.SOB_ID), SL.REFER12) AS REFER12_DESC
                     , SL.VOUCH_CODE
                     , FI_COMMON_G.CODE_NAME_F('VOUCH_CODE', SL.VOUCH_CODE, SL.SOB_ID, SL.ORG_ID) AS VOUCH_NAME
                     , SL.REFER_RATE
                     , SL.REFER_AMOUNT
                     , SL.REFER_DATE1
                     , SL.REFER_DATE2
                     , SL.REMARK
                  FROM FI_SLIP_LINE                          SL
                     , FI_SUPP_CUST_V                        SCV
                     , FI_ACCOUNT_CONTROL                    AC
                     , FI_ACCOUNT_CONTROL_ITEM               ACI
                     , FI_BANK_ACCOUNT_TLV                   BAT
                 WHERE SL.CUSTOMER_ID                      = SCV.SUPP_CUST_ID(+)
                   AND SL.ACCOUNT_CONTROL_ID               = AC.ACCOUNT_CONTROL_ID(+)
                   AND SL.ACCOUNT_CONTROL_ID               = ACI.ACCOUNT_CONTROL_ID(+)
                   AND SL.ACCOUNT_DR_CR                    = ACI.ACCOUNT_DR_CR(+)
                   AND SL.SOB_ID                           = ACI.SOB_ID(+)
                   AND SL.BANK_ACCOUNT_ID                  = BAT.BANK_ACCOUNT_ID(+)
                   AND SL.SOB_ID                           = W_SOB_ID
                   AND SL.SOURCE_TABLE                     = 'FI_SLIP_LINE_INTERFACE'
                   AND SL.SOURCE_HEADER_ID                 = W_SLIP_HEADER_INTERFACE_ID
              ORDER BY SL.SLIP_LINE_SEQ
                     ;

       END;



       PROCEDURE SELECT_SLIP_LINE_PRINT_5( P_CURSOR                   OUT TYPES.TCURSOR
                                         , W_SOB_ID                   IN  FI_SLIP_LINE.SOB_ID%TYPE
                                         , W_ORG_ID                   IN  FI_SLIP_LINE.ORG_ID%TYPE
                                         , W_SLIP_HEADER_INTERFACE_ID IN  FI_SLIP_HEADER_INTERFACE.HEADER_INTERFACE_ID%TYPE
                                         )

       IS

       BEGIN

                OPEN P_CURSOR FOR
                SELECT SL.LINE_INTERFACE_ID
                     , SL.SLIP_LINE_SEQ
                     , SL.HEADER_INTERFACE_ID
                     , SL.SOB_ID
                     , SL.ACCOUNT_BOOK_ID
                     , SL.ACCOUNT_DR_CR
                     , FI_COMMON_G.CODE_NAME_F('ACCOUNT_DR_CR', SL.ACCOUNT_DR_CR, SL.SOB_ID, SL.ORG_ID) AS ACCOUNT_DR_CR_NAME
                     , SL.ACCOUNT_CONTROL_ID
                     , SL.ACCOUNT_CODE
                     , AC.ACCOUNT_DESC
                     , SL.CURRENCY_CODE
                     , SL.CURRENCY_CODE AS CURRENCY_DESC
                     , decode(SL.EXCHANGE_RATE, 0, NULL, SL.EXCHANGE_RATE) AS EXCHANGE_RATE
                     , decode(SL.GL_CURRENCY_AMOUNT, 0, NULL, SL.GL_CURRENCY_AMOUNT) AS GL_CURRENCY_AMOUNT
                     , EAPP_CURRENCY_G.DISPLAY_AMOUNT_F(SL.CURRENCY_CODE, DECODE(SL.ACCOUNT_DR_CR, '1', SL.GL_AMOUNT, NULL), W_SOB_ID, W_ORG_ID) AS DR_AMOUNT
                     , EAPP_CURRENCY_G.DISPLAY_AMOUNT_F(SL.CURRENCY_CODE, DECODE(SL.ACCOUNT_DR_CR, '2', SL.GL_AMOUNT, NULL), W_SOB_ID, W_ORG_ID) AS CR_AMOUNT
                     , SL.GL_AMOUNT
                     , SL.CUSTOMER_ID
                     , SCV.SUPP_CUST_NAME AS CUSTOMER_NAME
                     , SCV.TAX_REG_NO
                     , SL.BANK_ACCOUNT_ID
                     , BAT.BANK_ACCOUNT_NAME
                     , BAT.BANK_ACCOUNT_NUM
                     , SL.BUDGET_DEPT_ID
                     , FI_DEPT_MASTER_G.DEPT_NAME_F(SL.BUDGET_DEPT_ID) AS BUDGET_DEPT_NAME
                     , SL.COST_CENTER_ID
                     , FI_COMMON_G.COST_CENTER_CODE_F(SL.COST_CENTER_ID) AS COST_CENTER_CODE
                     , FI_COMMON_G.COST_CENTER_DESC_F(SL.COST_CENTER_ID) AS COST_CENTER_DESC
                     , NVL(FI_ACCOUNT_CONTROL_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                              , 'REFER1_ID'
                                                              , SL.MANAGEMENT1
                                                              , SL.SOB_ID), SL.MANAGEMENT1) AS MANAGEMENT1_DESC
                     , NVL(FI_ACCOUNT_CONTROL_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                              , 'REFER2_ID'
                                                              , SL.MANAGEMENT2
                                                              , SL.SOB_ID), SL.MANAGEMENT2) AS MANAGEMENT2_DESC
                     , NVL(FI_ACCOUNT_CONTROL_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                              , 'REFER3_ID'
                                                              , SL.REFER1
                                                              , SL.SOB_ID), SL.REFER1) AS REFER1_DESC
                     , NVL(FI_ACCOUNT_CONTROL_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                              , 'REFER4_ID'
                                                              , SL.REFER2
                                                              , SL.SOB_ID), SL.REFER2) AS REFER2_DESC
                     , NVL(FI_ACCOUNT_CONTROL_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                              , 'REFER5_ID'
                                                              , SL.REFER3
                                                              , SL.SOB_ID), SL.REFER3) AS REFER3_DESC
                     , NVL(FI_ACCOUNT_CONTROL_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                              , 'REFER6_ID'
                                                              , SL.REFER4
                                                              , SL.SOB_ID), SL.REFER4) AS REFER4_DESC
                     , NVL(FI_ACCOUNT_CONTROL_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                              , 'REFER7_ID'
                                                              , SL.REFER5
                                                              , SL.SOB_ID), SL.REFER5) AS REFER5_DESC
                     , NVL(FI_ACCOUNT_CONTROL_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                              , 'REFER8_ID'
                                                              , SL.REFER6
                                                              , SL.SOB_ID), SL.REFER6) AS REFER6_DESC
                     , NVL(FI_ACCOUNT_CONTROL_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                              , 'REFER9_ID'
                                                              , SL.REFER7
                                                              , SL.SOB_ID), SL.REFER7) AS REFER7_DESC
                     , NVL(FI_ACCOUNT_CONTROL_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                              , 'REFER10_ID'
                                                              , SL.REFER8
                                                              , SL.SOB_ID), SL.REFER8) AS REFER8_DESC
                     , NVL(FI_ACCOUNT_CONTROL_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                              , 'REFER11_ID'
                                                              , SL.REFER9
                                                              , SL.SOB_ID), SL.REFER9) AS REFER9_DESC
                     , NVL(FI_ACCOUNT_CONTROL_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                              , 'REFER12_ID'
                                                              , SL.REFER10
                                                              , SL.SOB_ID), SL.REFER10) AS REFER10_DESC
                     , NVL(FI_ACCOUNT_CONTROL_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                              , 'REFER13_ID'
                                                              , SL.REFER11
                                                              , SL.SOB_ID), SL.REFER11) AS REFER11_DESC
                     , NVL(FI_ACCOUNT_CONTROL_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                              , 'REFER14_ID'
                                                              , SL.REFER12
                                                              , SL.SOB_ID), SL.REFER12) AS REFER12_DESC
                     , SL.VOUCH_CODE
                     , FI_COMMON_G.CODE_NAME_F('VOUCH_CODE', SL.VOUCH_CODE, SL.SOB_ID, SL.ORG_ID) AS VOUCH_NAME
                     , SL.REFER_RATE
                     , SL.REFER_AMOUNT
                     , SL.REFER_DATE1
                     , SL.REFER_DATE2
                     , SL.REMARK
                  FROM FI_SLIP_LINE_INTERFACE SL
                    , FI_AUTO_JOURNAL_LINE AJL
                    , FI_SUPP_CUST_V SCV
                    , FI_ACCOUNT_CONTROL AC
                    , FI_ACCOUNT_CONTROL_ITEM ACI
                    , FI_BANK_ACCOUNT_TLV BAT
                 WHERE SL.JOURNAL_HEADER_ID       = AJL.JOURNAL_HEADER_ID(+)
                   AND SL.ACCOUNT_CONTROL_ID      = AJL.ACCOUNT_CONTROL_ID(+)
                   AND SL.ACCOUNT_DR_CR           = AJL.ACCOUNT_DR_CR(+)
                   AND SL.CUSTOMER_ID             = SCV.SUPP_CUST_ID(+)
                   AND SL.ACCOUNT_CONTROL_ID      = AC.ACCOUNT_CONTROL_ID
                   AND SL.ACCOUNT_CONTROL_ID      = ACI.ACCOUNT_CONTROL_ID(+)
                   AND SL.ACCOUNT_DR_CR           = ACI.ACCOUNT_DR_CR(+)
                   AND SL.SOB_ID                  = ACI.SOB_ID(+)
                   AND SL.BANK_ACCOUNT_ID         = BAT.BANK_ACCOUNT_ID(+)
                   AND SL.HEADER_INTERFACE_ID     = W_SLIP_HEADER_INTERFACE_ID
                   AND SL.SOB_ID                  = W_SOB_ID
                ORDER BY SL.SLIP_LINE_SEQ
                ;

       END;


       PROCEDURE SELECT_SLIP_LINE_PRINT_6( P_CURSOR                   OUT TYPES.TCURSOR
                                         , W_SOB_ID                   IN  FI_SLIP_LINE.SOB_ID%TYPE
                                         , W_ORG_ID                   IN  FI_SLIP_LINE.ORG_ID%TYPE
                                         , W_SLIP_HEADER_INTERFACE_ID IN  FI_SLIP_HEADER_INTERFACE.HEADER_INTERFACE_ID%TYPE
                                         )

       IS

       BEGIN

                OPEN P_CURSOR FOR
                SELECT SL.SLIP_LINE_SEQ
                     , FI_COMMON_G.CODE_NAME_F('ACCOUNT_DR_CR', SL.ACCOUNT_DR_CR, SL.SOB_ID, SL.ORG_ID) AS ACCOUNT_DR_CR_NAME
                     , SL.ACCOUNT_CODE
                     , AC.ACCOUNT_DESC
                     , EAPP_CURRENCY_G.DISPLAY_AMOUNT_F(SL.CURRENCY_CODE, DECODE(SL.ACCOUNT_DR_CR, '1', SL.GL_AMOUNT, NULL), W_SOB_ID, W_ORG_ID) AS DR_AMOUNT
                     , EAPP_CURRENCY_G.DISPLAY_AMOUNT_F(SL.CURRENCY_CODE, DECODE(SL.ACCOUNT_DR_CR, '2', SL.GL_AMOUNT, NULL), W_SOB_ID, W_ORG_ID) AS CR_AMOUNT
                     , NVL(FI_ACCOUNT_CONTROL_ITEM_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                                        , SL.ACCOUNT_DR_CR
                                                                        , 'MANAGEMENT1_ID'
                                                                        , SL.MANAGEMENT1
                                                                        , SL.SOB_ID), SL.MANAGEMENT1)
                    || DECODE(SL.MANAGEMENT2, NULL, '', ' ')
                    || NVL(FI_ACCOUNT_CONTROL_ITEM_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                                        , SL.ACCOUNT_DR_CR
                                                                        , 'MANAGEMENT2_ID'
                                                                        , SL.MANAGEMENT2
                                                                        , SL.SOB_ID), SL.MANAGEMENT2)
                    || DECODE(SL.REFER1, NULL, '', ' ')
                    || NVL(FI_ACCOUNT_CONTROL_ITEM_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                                        , SL.ACCOUNT_DR_CR
                                                                        , 'REFER1_ID'
                                                                        , SL.REFER1
                                                                        , SL.SOB_ID), SL.REFER1)
                    || DECODE(SL.REFER2, NULL, '', ' ')
                    || NVL(FI_ACCOUNT_CONTROL_ITEM_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                                        , SL.ACCOUNT_DR_CR
                                                                        , 'REFER2_ID'
                                                                        , SL.REFER2
                                                                        , SL.SOB_ID), SL.REFER2)
                    || DECODE(SL.REFER3, NULL, '', ' ')
                    || NVL(FI_ACCOUNT_CONTROL_ITEM_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                                        , SL.ACCOUNT_DR_CR
                                                                        , 'REFER3_ID'
                                                                        , SL.REFER3
                                                                        , SL.SOB_ID), SL.REFER3)
                    || DECODE(SL.REFER4, NULL, '', ' ')
                    || NVL(FI_ACCOUNT_CONTROL_ITEM_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                                        , SL.ACCOUNT_DR_CR
                                                                        , 'REFER4_ID'
                                                                        , SL.REFER4
                                                                        , SL.SOB_ID), SL.REFER4)
                    || DECODE(SL.REFER5, NULL, '', ' ')
                    || NVL(FI_ACCOUNT_CONTROL_ITEM_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                                        , SL.ACCOUNT_DR_CR
                                                                        , 'REFER5_ID'
                                                                        , SL.REFER5
                                                                        , SL.SOB_ID), SL.REFER5)
                    || DECODE(SL.REFER6, NULL, '', ' ')
                    || NVL(FI_ACCOUNT_CONTROL_ITEM_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                                        , SL.ACCOUNT_DR_CR
                                                                        , 'REFER6_ID'
                                                                        , SL.REFER6
                                                                        , SL.SOB_ID), SL.REFER6)
                    || DECODE(SL.REFER7, NULL, '', ' ')
                    || NVL(FI_ACCOUNT_CONTROL_ITEM_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                                        , SL.ACCOUNT_DR_CR
                                                                        , 'REFER7_ID'
                                                                        , SL.REFER7
                                                                        , SL.SOB_ID), SL.REFER7)
                    || DECODE(SL.REFER8, NULL, '', ' ')
                    || NVL(FI_ACCOUNT_CONTROL_ITEM_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                                        , SL.ACCOUNT_DR_CR
                                                                        , 'REFER8_ID'
                                                                        , SL.REFER8
                                                                        , SL.SOB_ID), SL.REFER8)
                       AS M_REFERENCE
                     , SL.REMARK
                     , SL.SLIP_HEADER_ID
                     , SL.SLIP_LINE_ID
                  FROM FI_SLIP_LINE                          SL
                     , FI_SUPP_CUST_V                        SCV
                     , FI_ACCOUNT_CONTROL                    AC
                     , FI_ACCOUNT_CONTROL_ITEM               ACI
                     , FI_BANK_ACCOUNT_TLV                   BAT
                 WHERE SL.CUSTOMER_ID                      = SCV.SUPP_CUST_ID(+)
                   AND SL.ACCOUNT_CONTROL_ID               = AC.ACCOUNT_CONTROL_ID(+)
                   AND SL.ACCOUNT_CONTROL_ID               = ACI.ACCOUNT_CONTROL_ID(+)
                   AND SL.ACCOUNT_DR_CR                    = ACI.ACCOUNT_DR_CR(+)
                   AND SL.SOB_ID                           = ACI.SOB_ID(+)
                   AND SL.BANK_ACCOUNT_ID                  = BAT.BANK_ACCOUNT_ID(+)
                   AND SL.SOB_ID                           = W_SOB_ID
                   AND SL.SOURCE_TABLE                     = 'FI_SLIP_LINE_INTERFACE'
                   AND SL.SOURCE_HEADER_ID                 = W_SLIP_HEADER_INTERFACE_ID
              ORDER BY SL.SLIP_LINE_SEQ
                     ;

       END;

-- 관리항목 값에 대한 데이터 타입별 형식 지정.
  FUNCTION MANAGEMENT_VALUE_F
          ( P_SLIP_LINE_ID        IN FI_SLIP_LINE.SLIP_LINE_ID%TYPE
          , P_MANAGEMENT_SEQ      IN NUMBER
          , P_MANAGEMENT_VAULE    IN FI_SLIP_MANAGEMENT_ITEM.MANAGEMENT_VALUE%TYPE
          , P_SOB_ID              IN FI_SLIP_LINE.SOB_ID%TYPE
          ) RETURN VARCHAR2
  AS    
    V_ITEM_VALUE                  VARCHAR2(100);
    V_DATA_TYPE                   VARCHAR2(50);
    V_AMOUNT                      NUMBER := 0;
  BEGIN
    BEGIN
      SELECT MC.DATA_TYPE
        INTO V_DATA_TYPE
        FROM FI_SLIP_MANAGEMENT_ITEM SMI
          , FI_MANAGEMENT_CODE_V MC
      WHERE SMI.MANAGEMENT_ID         = MC.MANAGEMENT_ID
        AND SMI.SLIP_LINE_ID          = P_SLIP_LINE_ID
        AND SMI.MANAGEMENT_SEQ        = P_MANAGEMENT_SEQ
        AND SMI.SOB_ID                = P_SOB_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_DATA_TYPE := 'VARCHAR2';
    END;
    BEGIN
      IF V_DATA_TYPE = 'NUMBER' THEN
        V_ITEM_VALUE := TO_CHAR(TO_NUMBER(P_MANAGEMENT_VAULE), 'FM999,999,999,999,999,999');
      ELSIF V_DATA_TYPE = 'RATE' THEN
        V_AMOUNT := TO_NUMBER(P_MANAGEMENT_VAULE);
        IF V_AMOUNT - FLOOR(V_AMOUNT) = 0 THEN
          V_ITEM_VALUE := TO_CHAR(V_AMOUNT, 'FM999,999,999,999,999,999');
        ELSE
          V_ITEM_VALUE := TO_CHAR(V_AMOUNT, 'FM999,999,999,999,999,999.9999');
        END IF;
      ELSE
        V_ITEM_VALUE := P_MANAGEMENT_VAULE;
      END IF; 
    EXCEPTION WHEN OTHERS THEN
      V_ITEM_VALUE := P_MANAGEMENT_VAULE;
    END;
    RETURN V_ITEM_VALUE;
  END MANAGEMENT_VALUE_F;
  
end FI_SLIP_PRINT_G; 
/
