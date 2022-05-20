CREATE OR REPLACE PACKAGE WIP_OUT_ADJUST_G IS
/******************************************************************************/
/* Project      : FLEX ERP
/* Module       : MFG
/* Program Name : WIP_OUT_ADJUST_G
/* Description  : 외주 가공비 마감
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 17-MAR-2011  Shin Man Jae       Initialize
/******************************************************************************/


-------------------------------
-- PERIOD_SELECT             --
-------------------------------
PROCEDURE PERIOD_SELECT ( P_CURSOR                OUT  TYPES.TCURSOR
                        , W_SOB_ID                IN   NUMBER
                        , W_ORG_ID                IN   NUMBER
                        , W_PERIOD_NAME           IN   VARCHAR2);
                        
                        
-----------------------
-- SUPPLIER_CREATE   --
-----------------------
PROCEDURE SUPPLIER_CREATE( P_SOB_ID              IN  NUMBER
                         , P_ORG_ID              IN  NUMBER
                         , P_PERIOD_NAME         IN  VARCHAR2
                         , P_DATE_FR             IN  DATE
                         , P_DATE_TO             IN  DATE
                         , P_USER_ID             IN  NUMBER
                         , X_RESULT_STATUS       OUT VARCHAR2
                         , X_RESULT_MSG          OUT VARCHAR2
                         );


------------------------
-- SUPPLIER_CONFIRM   --
------------------------
PROCEDURE SUPPLIER_CONFIRM ( P_SOB_ID              IN  NUMBER
                           , P_ORG_ID              IN  NUMBER
                           , P_ADJUST_SUPPLIER_ID  IN  NUMBER
                           , P_USER_ID             IN  NUMBER
                           , X_RESULT_STATUS       OUT VARCHAR2
                           , X_RESULT_MSG          OUT VARCHAR2
                           );
                           
-------------------------------
-- SUPPLIER_CONFIRM_CANCEL   --
-------------------------------
PROCEDURE SUPPLIER_CONFIRM_CANCEL( P_SOB_ID              IN  NUMBER
                                 , P_ORG_ID              IN  NUMBER
                                 , P_ADJUST_SUPPLIER_ID  IN  NUMBER
                                 , P_USER_ID             IN  NUMBER
                                 , X_RESULT_STATUS       OUT VARCHAR2
                                 , X_RESULT_MSG          OUT VARCHAR2
                                 );
                                 


------------------------
-- TRX_CONFIRM        --
------------------------
PROCEDURE TRX_CONFIRM  ( P_SOB_ID              IN  NUMBER
                       , P_ORG_ID              IN  NUMBER
                       , P_ADJUST_SUPPLIER_ID  IN  NUMBER
                       , P_ADJUST_TRX_ID       IN  NUMBER
                       , P_USER_ID             IN  NUMBER
                       , X_RESULT_STATUS       OUT VARCHAR2
                       , X_RESULT_MSG          OUT VARCHAR2
                       );


-------------------------------
-- SUPPLIER_CONFIRM_CANCEL   --
-------------------------------
PROCEDURE TRX_CONFIRM_CANCEL ( P_SOB_ID              IN  NUMBER
                             , P_ORG_ID              IN  NUMBER
                             , P_ADJUST_SUPPLIER_ID  IN  NUMBER
                             , P_ADJUST_TRX_ID       IN  NUMBER
                             , P_USER_ID             IN  NUMBER
                             , X_RESULT_STATUS       OUT VARCHAR2
                             , X_RESULT_MSG          OUT VARCHAR2
                             );                       
                                                                                   
-----------------------
-- SUPPLIER_SELECT   --
-----------------------
PROCEDURE SUPPLIER_SELECT ( P_CURSOR             OUT  TYPES.TCURSOR
                          , W_SOB_ID             IN   NUMBER
                          , W_ORG_ID             IN   NUMBER
                          , W_PERIOD_NAME        IN   VARCHAR2
                          , W_SUPPLIER_ID        IN   NUMBER
                          );
                                                  
-----------------------
-- SUPPLIER_UPDATE   --
-----------------------
PROCEDURE SUPPLIER_UPDATE( W_ADJUST_SUPPLIER_ID       IN WIP_OUT_ADJUST_SUPPLIER.ADJUST_SUPPLIER_ID%TYPE
                         , P_ACCOUNT_CONTROL_ID       IN WIP_OUT_ADJUST_SUPPLIER.ACCOUNT_CONTROL_ID%TYPE );
                         

--------------------------
-- 정산 TRX 대상 산출   --
--------------------------
PROCEDURE TRX_TARGET_SELECT ( P_CURSOR             OUT  TYPES.TCURSOR
                            , W_SOB_ID             IN   NUMBER
                            , W_ORG_ID             IN   NUMBER
                            , W_PERIOD_NAME        IN   VARCHAR2
                            , W_WORKCENTER_ID      IN   NUMBER
                            , W_DATE_FR            IN   DATE
                            , W_DATE_TO            IN   DATE
                            );
                            
                                                                              
------------------
-- TRX_CREATE   --
------------------
PROCEDURE TRX_ADJUST ( P_SOB_ID                 IN  NUMBER
                     , P_ORG_ID                 IN  NUMBER
                     , P_ADJUST_SUPPLIER_ID     IN  NUMBER
                     , P_PERIOD_NAME            IN  VARCHAR2
                     , P_SUPPLIER_ID            IN  NUMBER
                     , P_WORKCENTER_ID          IN  NUMBER
                     , P_JOB_ID                 IN  NUMBER
                     , P_OPERATION_SEQ_NO       IN  NUMBER
                     , P_OPERATION_ID           IN  NUMBER
                     , P_ORIGINAL_OPERATION_ID  IN  NUMBER
                     , P_USER_ID                IN  NUMBER
                     , X_RESULT_STATUS          OUT VARCHAR2
                     , X_RESULT_MSG             OUT VARCHAR2
                     );

------------------
-- SPEC_ADJUST  --
------------------
PROCEDURE SPEC_ADJUST  ( P_SOB_ID              IN  NUMBER
                       , P_ADJUST_TRX_ID       IN  NUMBER
                       , P_USER_ID             IN  NUMBER
                       , X_RESULT_STATUS       OUT VARCHAR2
                       , X_RESULT_MSG          OUT VARCHAR2
                       );
                       
----------------------
-- GET_SPEC_AMOUNT  --
----------------------
PROCEDURE GET_SPEC_AMOUNT  ( P_SOB_ID                   IN  NUMBER
                           , P_ORG_ID                   IN  NUMBER
                           , P_OP_WORK_ID               IN  NUMBER
                           , P_OP_SPEC_ID               IN  NUMBER
                           , P_OP_SPEC_UOM_CODE         IN  VARCHAR2
                           , P_OP_SPEC_VALUE            IN  NUMBER
                           , P_ADJUST_TRX_ID            IN  NUMBER
                           , X_OUT_PRICE_ID             OUT NUMBER
                           , X_PRICE_CLASS              OUT VARCHAR2
                           , X_PRICE_TYPE_LCODE         OUT VARCHAR2
                           , X_PRICE_TYPE_DESC          OUT VARCHAR2
                           , X_CURRENCY_CODE            OUT VARCHAR2
                           , X_BASIC_PRICE              OUT NUMBER
                           , X_BASIC_AMOUNT             OUT NUMBER
                           , X_OUT_PRICE                OUT NUMBER
                           , X_OUT_AMOUNT               OUT NUMBER
                           , X_LOW_LIMIT_AMOUNT         OUT NUMBER
                           , X_HIGH_LIMIT_AMOUNT        OUT NUMBER
                           , X_LOW_LIMIT_PRICE_UOM      OUT VARCHAR2
                           , X_LOW_LIMIT_PRICE          OUT NUMBER
                           , X_SETTING_FEE_AMOUNT       OUT NUMBER
                           , X_SETTING_LIMIT_HOUR       OUT NUMBER
                           , X_PRICE_APPLY_TYPE_LCODE   OUT VARCHAR2
                           , X_PRICE_APPLY_TYPE_DESC    OUT VARCHAR2
                           , X_RESULT_STATUS            OUT VARCHAR2
                           , X_RESULT_MSG               OUT VARCHAR2
                           );
                                              
------------------------
-- OUT_PRICE_SELECT   --
------------------------
PROCEDURE GET_OUT_PRICE  ( P_SOB_ID              IN  NUMBER
                         , P_ORG_ID              IN  NUMBER
                         , P_OP_WORK_ID          IN  NUMBER
                         , P_OP_SPEC_ID          IN  NUMBER
                         , P_SUPPLIER_ID         IN  NUMBER
                         , P_WORKCENTER_ID       IN  NUMBER
                         , P_OPERATION_ID        IN  NUMBER
                         , P_BOM_ITEM_ID         IN  NUMBER
                         , P_TRX_DATE            IN  DATE
                         , P_QTY_VALUE           IN  NUMBER
                         , X_PRICE_CLASS         OUT VARCHAR2
                         , X_PRICE_TYPE_LCODE    OUT VARCHAR2
                         , X_OUT_PRICE           OUT NUMBER
                         , X_OUT_PRICE_ID        OUT NUMBER
                         , X_LOW_LIMIT_AMOUNT    OUT NUMBER   
                         , X_HIGH_LIMIT_AMOUNT   OUT NUMBER
                         , X_LOW_LIMIT_PRICE_UOM OUT VARCHAR2
                         , X_LOW_LIMIT_PRICE     OUT NUMBER
                         , X_SETTING_FEE_AMOUNT  OUT NUMBER
                         , X_SETTING_LIMIT_HOUR  OUT NUMBER
                         );

--------------------------
-- GET_ITEM_SPEC_INFO   --
--------------------------
PROCEDURE GET_ITEM_SPEC_INFO ( P_SOB_ID              IN  NUMBER
                             , P_ORG_ID              IN  NUMBER
                             , P_INVENTORY_ITEM_ID   IN  NUMBER
                             , P_BOM_ITEM_ID         IN  NUMBER
                             , X_PNL_SIZE_X          OUT NUMBER
                             , X_PNL_SIZE_Y          OUT NUMBER
                             , X_PCS_PER_PNL_QTY     OUT NUMBER   
                             , X_PCS_PER_MM_QTY      OUT NUMBER
                             , X_PCS_PER_ARRAY_QTY   OUT NUMBER
                             , X_ARRAY_PER_PNL_QTY   OUT NUMBER
                             );
                             
                                                                             
-----------------------
-- TRX_SELECT        --
-----------------------
PROCEDURE TRX_SELECT ( P_CURSOR             OUT  TYPES.TCURSOR
                     , W_SOB_ID             IN   NUMBER
                     , W_ORG_ID             IN   NUMBER
                     , W_PERIOD_NAME        IN   VARCHAR2
                     , W_SUPPLIER_ID        IN   NUMBER
                     , W_WORKCENTER_ID      IN   NUMBER
                     , W_FG_ITEM_ID         IN   NUMBER
                     , W_JOB_NO             IN   VARCHAR2
                     , W_RESULT_TYPE        IN   VARCHAR2
                     , W_ADJUST_DATE_FR     IN   DATE
                     , W_ADJUST_DATE_TO     IN   DATE
                     , W_HOLDING_APPLY_FLAG IN   VARCHAR2
                     , W_SORT_TYPE          IN   VARCHAR2
                     , W_CONFIRM_FLAG       IN   VARCHAR2
                     , W_OPERATION_ID       IN   NUMBER
                     );

---------------------------------------------------------------------
-- TRX의 OPERATION과 수량을 변경할 수 있도록 함, (FXC 김진영요청)  --
-- 2012-10-23, BY MJSHIN                                           --
---------------------------------------------------------------------
PROCEDURE TRX_UPDATE( P_ADJUST_TRX_ID             IN WIP_OUT_ADJUST_TRX.ADJUST_TRX_ID%TYPE
                    , P_SOB_ID                    IN WIP_OUT_ADJUST_TRX.SOB_ID%TYPE
                    , P_OPERATION_ID              IN WIP_OUT_ADJUST_TRX.OPERATION_ID%TYPE
                    , P_ADJUST_PNL_QTY            IN WIP_OUT_ADJUST_TRX.ADJUST_PNL_QTY%TYPE
                    , P_ADJUST_ARRAY_QTY          IN WIP_OUT_ADJUST_TRX.ADJUST_ARRAY_QTY%TYPE
                    , P_ADJUST_PCS_QTY            IN WIP_OUT_ADJUST_TRX.ADJUST_PCS_QTY%TYPE
                    , P_ADJUST_MM_QTY             IN WIP_OUT_ADJUST_TRX.ADJUST_MM_QTY%TYPE
                    , P_USER_ID                   IN  NUMBER
                    , X_RESULT_STATUS             OUT VARCHAR2
                    , X_RESULT_MSG                OUT VARCHAR2
                    );
                    
                    
-----------------------
-- SPEC_SELECT       --
-----------------------
PROCEDURE SPEC_SELECT  ( P_CURSOR             OUT  TYPES.TCURSOR
                       , W_SOB_ID             IN   NUMBER
                       , W_ORG_ID             IN   NUMBER
                       , W_PERIOD_NAME        IN   VARCHAR2
                       , W_ADJUST_TRX_ID      IN   NUMBER
                       );

---------------------------
-- SPEC INSERT           --
---------------------------
PROCEDURE SPEC_INSERT( P_ADJUST_SPEC_ID         OUT WIP_OUT_ADJUST_SPEC.ADJUST_SPEC_ID%TYPE
                     , P_SOB_ID                 IN WIP_OUT_ADJUST_SPEC.SOB_ID%TYPE
                     , P_ORG_ID                 IN WIP_OUT_ADJUST_SPEC.ORG_ID%TYPE
                     , P_ADJUST_SUPPLIER_ID     IN WIP_OUT_ADJUST_SPEC.ADJUST_SUPPLIER_ID%TYPE
                     , P_ADJUST_TRX_ID          IN WIP_OUT_ADJUST_SPEC.ADJUST_TRX_ID%TYPE
                     , P_PERIOD_NAME            IN WIP_OUT_ADJUST_SPEC.PERIOD_NAME%TYPE
                     , P_OP_WORK_ID             IN WIP_OUT_ADJUST_SPEC.OP_WORK_ID%TYPE
                     , P_OP_SPEC_ID             IN WIP_OUT_ADJUST_SPEC.OP_SPEC_ID%TYPE
                     , P_OP_SPEC_VALUE          IN WIP_OUT_ADJUST_SPEC.OP_SPEC_VALUE%TYPE
                     , P_OP_SPEC_UOM_CODE       IN WIP_OUT_ADJUST_SPEC.OP_SPEC_UOM_CODE%TYPE
                     , P_OUT_PRICE_ID           IN WIP_OUT_ADJUST_SPEC.OUT_PRICE_ID%TYPE
                     , P_PRICE_CLASS            IN WIP_OUT_ADJUST_SPEC.PRICE_CLASS%TYPE
                     , P_PRICE_TYPE_LCODE       IN WIP_OUT_ADJUST_SPEC.PRICE_TYPE_LCODE%TYPE
                     , P_CURRENCY_CODE          IN WIP_OUT_ADJUST_SPEC.CURRENCY_CODE%TYPE
                     , P_BASIC_PRICE            IN WIP_OUT_ADJUST_SPEC.BASIC_PRICE%TYPE
                     , P_BASIC_AMOUNT           IN WIP_OUT_ADJUST_SPEC.BASIC_AMOUNT%TYPE
                     , P_OUT_PRICE              IN WIP_OUT_ADJUST_SPEC.OUT_PRICE%TYPE
                     , P_OUT_AMOUNT             IN WIP_OUT_ADJUST_SPEC.OUT_AMOUNT%TYPE
                     , P_LOW_LIMIT_AMOUNT       IN WIP_OUT_ADJUST_SPEC.LOW_LIMIT_AMOUNT%TYPE
                     , P_HIGH_LIMIT_AMOUNT      IN WIP_OUT_ADJUST_SPEC.HIGH_LIMIT_AMOUNT%TYPE
                     , P_LOW_LIMIT_PRICE_UOM    IN WIP_OUT_ADJUST_SPEC.LOW_LIMIT_PRICE_UOM%TYPE
                     , P_LOW_LIMIT_PRICE        IN WIP_OUT_ADJUST_SPEC.LOW_LIMIT_PRICE%TYPE
                     , P_SETTING_FEE_AMOUNT     IN WIP_OUT_ADJUST_SPEC.SETTING_FEE_AMOUNT%TYPE
                     , P_SETTING_LIMIT_HOUR     IN WIP_OUT_ADJUST_SPEC.SETTING_LIMIT_HOUR%TYPE
                     , P_PRICE_APPLY_TYPE_LCODE IN WIP_OUT_ADJUST_SPEC.PRICE_APPLY_TYPE_LCODE%TYPE
                     , P_USER_ID                IN WIP_OUT_ADJUST_SPEC.CREATED_BY%TYPE );
                     

------------------------
-- SPEC_UPDATE        --
------------------------
PROCEDURE SPEC_UPDATE( W_ADJUST_SPEC_ID         IN WIP_OUT_ADJUST_SPEC.ADJUST_SPEC_ID%TYPE
                     , P_SOB_ID                 IN WIP_OUT_ADJUST_SPEC.SOB_ID%TYPE
                     , P_ORG_ID                 IN WIP_OUT_ADJUST_SPEC.ORG_ID%TYPE
                     , P_ADJUST_SUPPLIER_ID     IN WIP_OUT_ADJUST_SPEC.ADJUST_SUPPLIER_ID%TYPE
                     , P_ADJUST_TRX_ID          IN WIP_OUT_ADJUST_SPEC.ADJUST_TRX_ID%TYPE
                     , P_PERIOD_NAME            IN WIP_OUT_ADJUST_SPEC.PERIOD_NAME%TYPE
                     , P_OP_WORK_ID             IN WIP_OUT_ADJUST_SPEC.OP_WORK_ID%TYPE
                     , P_OP_SPEC_ID             IN WIP_OUT_ADJUST_SPEC.OP_SPEC_ID%TYPE
                     , P_OP_SPEC_VALUE          IN WIP_OUT_ADJUST_SPEC.OP_SPEC_VALUE%TYPE
                     , P_OP_SPEC_UOM_CODE       IN WIP_OUT_ADJUST_SPEC.OP_SPEC_UOM_CODE%TYPE
                     , P_OUT_PRICE_ID           IN WIP_OUT_ADJUST_SPEC.OUT_PRICE_ID%TYPE
                     , P_PRICE_CLASS            IN WIP_OUT_ADJUST_SPEC.PRICE_CLASS%TYPE
                     , P_PRICE_TYPE_LCODE       IN WIP_OUT_ADJUST_SPEC.PRICE_TYPE_LCODE%TYPE
                     , P_CURRENCY_CODE          IN WIP_OUT_ADJUST_SPEC.CURRENCY_CODE%TYPE
                     , P_BASIC_PRICE            IN WIP_OUT_ADJUST_SPEC.BASIC_PRICE%TYPE
                     , P_BASIC_AMOUNT           IN WIP_OUT_ADJUST_SPEC.BASIC_AMOUNT%TYPE
                     , P_OUT_PRICE              IN WIP_OUT_ADJUST_SPEC.OUT_PRICE%TYPE
                     , P_OUT_AMOUNT             IN WIP_OUT_ADJUST_SPEC.OUT_AMOUNT%TYPE
                     , P_LOW_LIMIT_AMOUNT       IN WIP_OUT_ADJUST_SPEC.LOW_LIMIT_AMOUNT%TYPE
                     , P_HIGH_LIMIT_AMOUNT      IN WIP_OUT_ADJUST_SPEC.HIGH_LIMIT_AMOUNT%TYPE
                     , P_LOW_LIMIT_PRICE_UOM    IN WIP_OUT_ADJUST_SPEC.LOW_LIMIT_PRICE_UOM%TYPE
                     , P_LOW_LIMIT_PRICE        IN WIP_OUT_ADJUST_SPEC.LOW_LIMIT_PRICE%TYPE
                     , P_SETTING_FEE_AMOUNT     IN WIP_OUT_ADJUST_SPEC.SETTING_FEE_AMOUNT%TYPE
                     , P_SETTING_LIMIT_HOUR     IN WIP_OUT_ADJUST_SPEC.SETTING_LIMIT_HOUR%TYPE
                     , P_PRICE_APPLY_TYPE_LCODE IN WIP_OUT_ADJUST_SPEC.PRICE_APPLY_TYPE_LCODE%TYPE
                     , P_USER_ID                IN WIP_OUT_ADJUST_SPEC.CREATED_BY%TYPE );
                     

------------------------
-- SPEC_DELETE        --
------------------------
PROCEDURE SPEC_DELETE( W_ADJUST_SPEC_ID IN WIP_OUT_ADJUST_SPEC.ADJUST_SPEC_ID%TYPE );

                                                                 
------------------------
-- CLAIM비용 저장     --
------------------------
PROCEDURE CLAIM_SAVE ( P_SOB_ID              IN  NUMBER
                     , P_ORG_ID              IN  NUMBER
                     , P_PERIOD_NAME         IN  VARCHAR2
                     , P_ADJUST_SUPPLIER_ID  IN  NUMBER
                     , P_CLAIM_AMOUNT        IN  NUMBER
                     , P_USER_ID             IN  NUMBER
                     , X_RESULT_STATUS       OUT VARCHAR2
                     , X_RESULT_MSG          OUT VARCHAR2
                     );
                     
                       
------------------------
-- 정산마감           --
------------------------
PROCEDURE ADJUST_CLOSE ( P_SOB_ID              IN  NUMBER
                       , P_ORG_ID              IN  NUMBER
                       , P_PERIOD_NAME         IN  VARCHAR2
                       , P_USER_ID             IN  NUMBER
                       , X_RESULT_STATUS       OUT VARCHAR2
                       , X_RESULT_MSG          OUT VARCHAR2
                       );
                       
------------------------
-- 정산마감취소       --
------------------------
PROCEDURE ADJUST_CLOSE_CANCEL  ( P_SOB_ID              IN  NUMBER
                               , P_ORG_ID              IN  NUMBER
                               , P_PERIOD_NAME         IN  VARCHAR2
                               , X_RESULT_STATUS       OUT VARCHAR2
                               , X_RESULT_MSG          OUT VARCHAR2
                               );  
                               
------------------------
-- 회계전송           --
------------------------
PROCEDURE SLIP_TRANSFER  ( P_SOB_ID              IN  NUMBER
                         , P_ORG_ID              IN  NUMBER
                         , P_PERIOD_NAME         IN  NUMBER
                         , X_RESULT_STATUS       OUT VARCHAR2
                         , X_RESULT_MSG          OUT VARCHAR2
                         );
                         
------------------------
-- 회계전송 취소      --
------------------------
PROCEDURE SLIP_TRANSFER_CANCEL ( P_SOB_ID              IN  NUMBER
                               , P_ORG_ID              IN  NUMBER
                               , P_PERIOD_NAME         IN  NUMBER
                               , X_RESULT_STATUS       OUT VARCHAR2
                               , X_RESULT_MSG          OUT VARCHAR2
                               );      
                               

------------------------
-- TRX_SUMMARY_SELECT --
------------------------
------------------------
-- TRX_SUMMARY_SELECT --
------------------------
PROCEDURE TRX_SUMMARY_SELECT ( P_SOB_ID                 IN  NUMBER
                             , P_ORG_ID                 IN  NUMBER
                             , P_PERIOD_NAME            IN  VARCHAR2
                             , P_SUPPLIER_ID            IN  NUMBER
                             , P_WORKCENTER_ID          IN  NUMBER
                             , P_ADJUST_DATE_FR         IN  DATE
                             , P_ADJUST_DATE_TO         IN  DATE
                             , X_ADJUST_AMOUNT          OUT NUMBER
                             , X_RESULT_STATUS          OUT VARCHAR2
                             , X_RESULT_MSG             OUT VARCHAR2
                             );                                                                                                                           

----------------------------------
-- TRX_HOLDING  (이월처리)      --
----------------------------------
PROCEDURE TRX_ADJUST_HOLDING ( P_SOB_ID              IN  NUMBER
                             , P_ORG_ID              IN  NUMBER
                             , P_PERIOD_NAME         IN  VARCHAR2
                             , P_ADJUST_SUPPLIER_ID  IN  NUMBER
                             , P_ADJUST_TRX_ID       IN  NUMBER
                             , P_USER_ID             IN  NUMBER
                             , X_RESULT_STATUS       OUT VARCHAR2
                             , X_RESULT_MSG          OUT VARCHAR2
                             );      

-----------------------------------------------------------
-- SPEC_AMT_APPLY_TO_TRX (SPEC내역을 TRX에 반영)         --
-----------------------------------------------------------
PROCEDURE SPEC_AMT_APPLY_TO_TRX  ( P_ADJUST_TRX_ID       IN  NUMBER
                                 , X_RESULT_STATUS       OUT VARCHAR2
                                 , X_RESULT_MSG          OUT VARCHAR2
                                 );
                                                              
-----------------------------------------------------------
-- SUPPLIER_ADJUST_COUNT (외주처별 집계내역 생성)        --
-----------------------------------------------------------
PROCEDURE SUPPLIER_ADJUST_COUNT  ( P_PERIOD_NAME         IN  VARCHAR2
                                 , P_ADJUST_SUPPLIER_ID  IN  NUMBER
                                 , X_RESULT_STATUS       OUT VARCHAR2
                                 , X_RESULT_MSG          OUT VARCHAR2
                                 );    
                                 
-----------------------------------------------------------
-- ADJUST_DATE_SELECT (마감년월 정산일자 범위)           --
-----------------------------------------------------------
PROCEDURE ADJUST_DATE_SELECT ( P_PERIOD_NAME         IN  VARCHAR2
                             , P_SOB_ID              IN  NUMBER
                             , P_ORG_ID              IN  NUMBER
                             , X_ADJUST_DATE_FR      OUT DATE
                             , X_ADJUST_DATE_TO      OUT DATE
                             , X_INQUIRY_DATE_FR     OUT DATE
                             , X_INQUIRY_DATE_TO     OUT DATE
                             ); 

-----------------------------------------------------------
-- SPEC_BATCH_COPY (SPEC내역 일괄복사)                   --
-----------------------------------------------------------
PROCEDURE SPEC_BATCH_COPY ( P_FROM_ADJUST_TRX_ID  IN  NUMBER
                          , P_TO_ADJUST_TRX_ID    IN  NUMBER
                          , X_RESULT_STATUS       OUT VARCHAR2
                          , X_RESULT_MSG          OUT VARCHAR2
                          );          
                          
--------------------------------------------
-- LU_CLOSE_PERIOD : PERIOD SELECT        --
--------------------------------------------
PROCEDURE LU_CLOSE_PERIOD  ( P_CURSOR                    OUT TYPES.TCURSOR
                           , W_SOB_ID                    IN  NUMBER
                           , W_ORG_ID                    IN  NUMBER
                           , W_CLOSE_TYPE                IN  VARCHAR2
                           , W_START_PERIOD              IN  EAPP_CALENDAR_YYYYMM_V.YYYYMM%TYPE DEFAULT NULL
                           , W_END_PERIOD                IN  EAPP_CALENDAR_YYYYMM_V.YYYYMM%TYPE DEFAULT NULL);  
                           
-----------------------------------------------------------
-- 일일 정산 자동 실행 (Job Schedule)                    --
-----------------------------------------------------------
PROCEDURE ADJUST_DAILY_AUTO_RUN;


---------------------------
-- GET_OPERATION_AMOUNT  --
---------------------------
PROCEDURE GET_OP_AMOUNT  ( P_SOB_ID                     IN  NUMBER
                         , P_ORG_ID                     IN  NUMBER
                         , P_OPERATION_ID               IN  NUMBER
                         , P_ADJUST_TRX_ID              IN  NUMBER
                         , P_SPEC_CAL_AMOUNT            IN  NUMBER
                         , P_SPEC_ADJUST_AMOUNT         IN  NUMBER
                         , X_CURRENCY_CODE              OUT VARCHAR2
                         , X_OUT_PRICE                  OUT NUMBER
                         , X_OUT_AMOUNT                 OUT NUMBER
                         , X_LOW_LIMIT_AMOUNT           OUT NUMBER
                         , X_HIGH_LIMIT_AMOUNT          OUT NUMBER
                         , X_LOW_LIMIT_PRICE_UOM        OUT VARCHAR2
                         , X_LOW_LIMIT_PRICE            OUT NUMBER
                         , X_SETTING_FEE_AMOUNT         OUT NUMBER
                         , X_SETTING_LIMIT_HOUR         OUT NUMBER
                         , X_ADJUST_PRICE_TYPE_LCODE    OUT VARCHAR2
                         , X_OP_PRICE_APPLY_TYPE_LCODE  OUT VARCHAR2
                         );
                         
                         
------------------------
-- OUT_PRICE_SELECT   --
------------------------
PROCEDURE GET_OP_OUT_PRICE ( P_SOB_ID              IN  NUMBER
                           , P_ORG_ID              IN  NUMBER
                           , P_SUPPLIER_ID         IN  NUMBER
                           , P_WORKCENTER_ID       IN  NUMBER
                           , P_OPERATION_ID        IN  NUMBER
                           , P_BOM_ITEM_ID         IN  NUMBER
                           , P_ADJUST_TRX_ID       IN  NUMBER
                           , P_TRX_DATE            IN  DATE
                           , P_TRX_UOM_CODE        IN  VARCHAR2
                           , P_TRX_QTY             IN  NUMBER
                           , X_PRICE_CLASS         OUT VARCHAR2
                           , X_PRICE_TYPE_LCODE    OUT VARCHAR2
                           , X_OUT_PRICE           OUT NUMBER
                           , X_LOW_LIMIT_AMOUNT    OUT NUMBER   
                           , X_HIGH_LIMIT_AMOUNT   OUT NUMBER
                           , X_LOW_LIMIT_PRICE_UOM OUT VARCHAR2
                           , X_LOW_LIMIT_PRICE     OUT NUMBER
                           , X_SETTING_FEE_AMOUNT  OUT NUMBER
                           , X_SETTING_LIMIT_HOUR  OUT NUMBER
                           , X_LOW_LIMIT_SPEC_VALUE  OUT NUMBER  -- 2012-10-23, BY MJSHIN --
                           , X_LOW_LIMIT_SPEC_PRICE  OUT NUMBER  -- 2012-10-23, BY MJSHIN --
                           );                                                                                                                                              
END WIP_OUT_ADJUST_G; 

 
/
CREATE OR REPLACE PACKAGE BODY WIP_OUT_ADJUST_G IS
/******************************************************************************/
/* Project      : FLEX ERP
/* Module       : MFG
/* Program Name : WIP_OUT_ADJUST_G
/* Description  : 외주 가공비 마감
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 17-MAR-2011  Shin Man Jae       Initialize
/* 2011.08.30   Chun Woong Ho      필드 조정
/* 2012-10-23   Shin Man Jae       TRX의 작업공정과 수량을 변경할 수 있도록 함.
/******************************************************************************/


-------------------------------
-- PERIOD_SELECT             --
-------------------------------
PROCEDURE PERIOD_SELECT ( P_CURSOR                OUT  TYPES.TCURSOR
                        , W_SOB_ID                IN   NUMBER
                        , W_ORG_ID                IN   NUMBER
                        , W_PERIOD_NAME           IN   VARCHAR2)
IS
BEGIN

       OPEN P_CURSOR FOR
        SELECT NVL(CP.ADJUST_CLOSE_FLAG,'N')                             AS ADJUST_CLOSE_FLAG
             , TO_CHAR(CP.ADJUST_CLOSE_DATE, 'YYYY-MM-DD HH24:MI:SS')    AS ADJUST_CLOSE_DATE
             , EAPP_COMMON_G.GET_PERSON_NAME(CP.ADJUST_CLOSE_PERSON_ID)  AS ADJUST_CLOSE_PERSON_NAME
             , NVL(CP.SLIP_TRANSFER_FLAG,'N')                            AS SLIP_TRANSFER_FLAG
             , TO_CHAR(CP.SLIP_TRANSFER_DATE, 'YYYY-MM-DD HH24:MI:SS')   AS SLIP_TRANSFER_DATE
             , EAPP_COMMON_G.GET_PERSON_NAME(CP.SLIP_TRANSFER_PERSON_ID) AS SLIP_TRANSFER_PERSON_NAME
             , NVL(CP.SLIP_APPROVAL_FLAG,'N')                            AS SLIP_APPROVAL_FLAG
             , TO_CHAR(CP.SLIP_APPROVAL_DATE, 'YYYY-MM-DD HH24:MI:SS')   AS SLIP_APPROVAL_DATE
             , EAPP_COMMON_G.GET_PERSON_NAME(CP.SLIP_APPROVAL_PERSON_ID) AS SLIP_APPROVAL_PERSON_NAME
          FROM INV_CLOSE_PERIOD  CP
         WHERE CP.SOB_ID            = W_SOB_ID
           AND CP.ORG_ID            = W_ORG_ID
           AND CP.PERIOD_NAME       = W_PERIOD_NAME
           AND CP.CLOSE_TYPE        = 'WIP_OUT_ADJ'
           AND ROWNUM               = 1
       ;


END PERIOD_SELECT;


-----------------------
-- SUPPLIER_CREATE   --
-----------------------
PROCEDURE SUPPLIER_CREATE( P_SOB_ID              IN  NUMBER
                         , P_ORG_ID              IN  NUMBER
                         , P_PERIOD_NAME         IN  VARCHAR2
                         , P_DATE_FR             IN  DATE
                         , P_DATE_TO             IN  DATE
                         , P_USER_ID             IN  NUMBER
                         , X_RESULT_STATUS       OUT VARCHAR2
                         , X_RESULT_MSG          OUT VARCHAR2
                         )
IS
  V_LOCAL_DATE            DATE := GET_LOCAL_DATE(P_SOB_ID);  
  V_START_DATE            DATE;
  V_END_DATE              DATE;

  V_COUNTRY_CODE          VARCHAR2(50);
  V_CNT                   NUMBER := 0;  
  V_SUP_CNT               NUMBER := 0;
  
  V_SYSTEM_CURRENCY_CODE  VARCHAR2(50);
BEGIN
       X_RESULT_STATUS := 'F';
       
       ------------------------------------------
       -- DATE RANGE SELECT                    --
       ------------------------------------------
       BEGIN
            SELECT CP.PERIOD_START_DATE
                 , CP.PERIOD_END_DATE
              INTO V_START_DATE
                 , V_END_DATE
              FROM INV_CLOSE_PERIOD   CP
             WHERE CP.SOB_ID          = P_SOB_ID
               AND CP.ORG_ID          = P_ORG_ID
               AND CP.PERIOD_NAME     = P_PERIOD_NAME
               AND CP.CLOSE_TYPE      = 'WIP_OUT_ADJ';
               
       EXCEPTION WHEN OTHERS THEN
            V_START_DATE := P_DATE_FR;
            V_END_DATE   := P_DATE_TO;
       END;
       
       -----------------------------
       -- 시스템 기준 통화 SELECT --
       -----------------------------
       V_SYSTEM_CURRENCY_CODE := FI_ACCOUNT_BOOK_G.BASE_CURRENCY_F(P_SOB_ID);
       
       
       ------------------------------------------
       -- 입고 구매처 생성                     --
       ------------------------------------------
       FOR SUP IN ( SELECT DISTINCT
                           SSW.SUPPLIER_ID
                         , SSW.WORKCENTER_ID
                         , SSW.OWNER_TYPE_LCODE
                      FROM WIP_MOVE_TRANSACTIONS    WMT
                         , SDM_STANDARD_RESOURCE    SSR
                         , SDM_STANDARD_WORKCENTER  SSW  
                         , WIP_MOVE_STEP            WMS
                     WHERE SSR.RESOURCE_ID          = WMT.FROM_RESOURCE_ID
                       AND SSW.WORKCENTER_ID        = SSR.WORKCENTER_ID
                       AND WMS.MOVE_STEP_ID         = WMT.FROM_STEP_ID
                       AND WMT.SOB_ID               = P_SOB_ID
                       AND WMT.ORG_ID               = P_ORG_ID
                       AND SSW.OWNER_TYPE_LCODE     IN ('NEAR_OUTSIDE','FAR_OUTSIDE')   
                       AND WMS.MOVE_STEP            = 'WAIT_MOVE'
                       AND WMT.MOVE_TRX_TYPE        = 'TOMOVE'
                       AND SSW.SUPPLIER_ID          IS NOT NULL  -- 2012-03-17, BY MJSHIN --
                       AND SSW.OUT_SLIP_SUPPLIER_ID IS NOT NULL  -- 2012-03-17, BY MJSHIN --
                       AND WMT.MOVE_TRX_DATE        BETWEEN V_START_DATE
                                                        AND V_END_DATE
                       AND NOT EXISTS (SELECT 'N'
                                         FROM WIP_OUT_ADJUST_SUPPLIER  T
                                        WHERE T.SOB_ID        = P_SOB_ID
                                          AND T.ORG_ID        = P_ORG_ID
                                          AND T.PERIOD_NAME   = P_PERIOD_NAME
                                          AND T.SUPPLIER_ID   = SSW.SUPPLIER_ID
                                          AND T.WORKCENTER_ID = SSW.WORKCENTER_ID)
                  )
       LOOP
           
           -- SUPPLIER 존재유무 체크 --
           BEGIN
                SELECT COUNT(*)
                  INTO V_CNT
                  FROM WIP_OUT_ADJUST_SUPPLIER  PAS
                 WHERE PAS.PERIOD_NAME         = P_PERIOD_NAME
                   AND PAS.SUPPLIER_ID         = SUP.SUPPLIER_ID
                   AND PAS.WORKCENTER_ID       = SUP.WORKCENTER_ID
                   ;
           EXCEPTION WHEN OTHERS THEN
                V_CNT := 0;
           END;
           
           -- SUPPLIER 내역이 없을 경우에만 INSERT --
           IF NVL(V_CNT,0) = 0 THEN
             
               -- SUPPLIER Country Code --
               BEGIN
                    SELECT S.COUNTRY_CODE
                      INTO V_COUNTRY_CODE
                      FROM AP_SUPPLIER  S
                     WHERE S.SUPPLIER_ID = SUP.SUPPLIER_ID
                     ;
               EXCEPTION WHEN OTHERS THEN
                    V_COUNTRY_CODE := NULL;
               END;
               
               BEGIN
                  INSERT INTO WIP_OUT_ADJUST_SUPPLIER
                            ( ADJUST_SUPPLIER_ID
                            ,  SOB_ID
                            ,  ORG_ID
                            ,  PERIOD_NAME
                            ,  SUPPLIER_ID
                            ,  COUNTRY_CODE
                            ,  WORKCENTER_ID
                            ,  OWN_TYPE_LCODE
                            ,  TARGET_COUNT
                            ,  ADJUST_COUNT
                            ,  REMAIN_COUNT
                            ,  CURRENCY_CODE
                            ,  ADJUST_AMOUNT
                            ,  MISC_AMOUNT
                            ,  CLAIM_AMOUNT
                            ,  SLIP_AMOUNT
                            ,  ADJUST_CLOSE_FLAG
                            ,  ADJUST_CLOSE_DATE
                            ,  ADJUST_CLOSE_PERSON_ID

                            , CONFIRM_FLAG
                            ,  ATTRIBUTE_A
                            ,  ATTRIBUTE_B
                            ,  ATTRIBUTE_C
                            ,  ATTRIBUTE_D
                            ,  ATTRIBUTE_E
                            ,  ATTRIBUTE_1
                            ,  ATTRIBUTE_2
                            ,  ATTRIBUTE_3
                            ,  ATTRIBUTE_4
                            ,  ATTRIBUTE_5
                            ,  CREATION_DATE
                            ,  CREATED_BY
                            ,  LAST_UPDATE_DATE
                            ,  LAST_UPDATED_BY
                            )
                       VALUES
                            ( WIP_OUT_ADJUST_SUPPLIER_S1.NEXTVAL   --  ADJUST_SUPPLIER_ID
                            , P_SOB_ID                            --  SOB_ID
                            , P_ORG_ID                            --  ORG_ID
                            , P_PERIOD_NAME                       --  PERIOD_NAME
                            , SUP.SUPPLIER_ID                     --  SUPPLIER_ID
                            , V_COUNTRY_CODE                      --  COUNTRY_CODE
                            , SUP.WORKCENTER_ID                   -- WORKCENTER_ID
                            , SUP.OWNER_TYPE_LCODE                -- OWN_TYPE_LCODE
                            , 0                                   --  TARGET_COUNT
                            , 0                                   --  ADJUST_COUNT
                            , 0                                   --  REMAIN_COUNT
                            , V_SYSTEM_CURRENCY_CODE              --  CURRENCY_CODE
                            , 0                                   --  ADJUST_AMOUNT
                            , 0                                    -- MISC_AMOUNT
                            , 0                                    -- CLAIM_AMOUNT
                            , 0                                    -- SLIP_AMOUNT
                            ,  'N'                                 --  ADJUST_CLOSE_FLAG
                            ,  NULL                                --  ADJUST_CLOSE_DATE
                            ,  NULL                                --  ADJUST_CLOSE_PERSON_ID

                            , 'N'                                 -- CONFIRM_FLAG
                            ,  NULL                                --  ATTRIBUTE_A
                            ,  NULL                                --  ATTRIBUTE_B
                            ,  NULL                                --  ATTRIBUTE_C
                            ,  NULL                                --  ATTRIBUTE_D
                            ,  NULL                                --  ATTRIBUTE_E
                            ,  NULL                                --  ATTRIBUTE_1
                            ,  NULL                                --  ATTRIBUTE_2
                            ,  NULL                                --  ATTRIBUTE_3
                            ,  NULL                                --  ATTRIBUTE_4
                            ,  NULL                                --  ATTRIBUTE_5
                            , V_LOCAL_DATE                        --  CREATION_DATE
                            , P_USER_ID                           --  CREATED_BY
                            , V_LOCAL_DATE                        --  LAST_UPDATE_DATE
                            , P_USER_ID                           --  LAST_UPDATED_BY
                            );
               EXCEPTION WHEN OTHERS THEN
                  X_RESULT_MSG := 'WIP_OUT_ADJUST_SUPPLIER Insert Error : ' || SQLERRM;
                  RETURN;
               END;
               
               V_SUP_CNT := NVL(V_SUP_CNT,0) + 1;
           
           END IF; -- IF NVL(V_CNT,0) = 0 THEN --
           
       END LOOP;  
       
       -------------------------------
       -- 외주비 지급 외주처 UPDATE --
       -------------------------------
       BEGIN
           UPDATE WIP_OUT_ADJUST_SUPPLIER  OAS
              SET OAS.SLIP_SUPPLIER_ID     = (SELECT SSW.OUT_SLIP_SUPPLIER_ID
                                                FROM SDM_STANDARD_WORKCENTER  SSW
                                               WHERE SSW.WORKCENTER_ID        = OAS.WORKCENTER_ID)
            WHERE OAS.SOB_ID         = P_SOB_ID
              AND OAS.ORG_ID         = P_ORG_ID
              AND OAS.PERIOD_NAME    = P_PERIOD_NAME
            ;
       EXCEPTION WHEN OTHERS THEN
           NULL;
       END; 
                                           
      
                          -- &&CNT 건의 외주처 내역이 산출되었습니다. --
       X_RESULT_MSG    := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F,'WIP_10193', '&&CNT:=' || V_SUP_CNT);
       X_RESULT_STATUS := 'S';

EXCEPTION WHEN OTHERS THEN
    X_RESULT_STATUS := 'F';
END SUPPLIER_CREATE;


------------------------
-- SUPPLIER_CONFIRM   --
------------------------
PROCEDURE SUPPLIER_CONFIRM ( P_SOB_ID              IN  NUMBER
                           , P_ORG_ID              IN  NUMBER
                           , P_ADJUST_SUPPLIER_ID  IN  NUMBER
                           , P_USER_ID             IN  NUMBER
                           , X_RESULT_STATUS       OUT VARCHAR2
                           , X_RESULT_MSG          OUT VARCHAR2
                           )
IS
  V_LOCAL_DATE            DATE := GET_LOCAL_DATE(P_SOB_ID);  
  
  V_TARGET_COUNT          NUMBER := 0;
  V_REMAIN_COUNT          NUMBER := 0;
  V_SLIP_AMOUNT           NUMBER := 0;
  V_SUPPLIER_ID           NUMBER;
  V_SUPPLIER_CODE         VARCHAR2(50);
  V_SUPPLIER_NAME         VARCHAR2(200);
  V_SUPPLIER              VARCHAR2(250);
BEGIN
   X_RESULT_STATUS := 'F';
   
   ----------------------------
   -- Validation             --
   ----------------------------
   BEGIN
        SELECT NVL(PAS.TARGET_COUNT,0) 
             , NVL(PAS.REMAIN_COUNT,0) 
             , PAS.SUPPLIER_ID
             , NVL(PAS.SLIP_AMOUNT,0) + NVL(PAS.SAMPLE_SLIP_AMOUNT,0)
          INTO V_TARGET_COUNT
             , V_REMAIN_COUNT
             , V_SUPPLIER_ID
             , V_SLIP_AMOUNT
          FROM WIP_OUT_ADJUST_SUPPLIER  PAS
         WHERE PAS.SOB_ID              = P_SOB_ID
           AND PAS.ORG_ID              = P_ORG_ID
           AND PAS.ADJUST_SUPPLIER_ID  = P_ADJUST_SUPPLIER_ID
         ;        
   EXCEPTION WHEN OTHERS THEN
        V_TARGET_COUNT := 0;
        V_REMAIN_COUNT := 0;
        V_SLIP_AMOUNT  := 0;
   END;
   
   -- 거래처 조회 --
   BEGIN
        SELECT SUP.SUPPLIER_CODE
             , SUP.SUPPLIER_SHORT_NAME
          INTO V_SUPPLIER_CODE
             , V_SUPPLIER_NAME
          FROM AP_SUPPLIER      SUP
         WHERE SUP.SUPPLIER_ID  = V_SUPPLIER_ID
         ;   
   EXCEPTION WHEN OTHERS THEN
        V_SUPPLIER_CODE := NULL;
        V_SUPPLIER_NAME := NULL;     
   END;
   
   V_SUPPLIER := '[' || V_SUPPLIER_CODE || '][' || V_SUPPLIER_NAME || ']';
   
   IF V_TARGET_COUNT = 0 AND V_SLIP_AMOUNT = 0 THEN
                           -- &&SUPPLIER 는 정산 대상내역이 없으므로 확정할 수 없습니다. --
        X_RESULT_MSG    := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F,'INV_10025', '&&SUPPLIER:=' || V_SUPPLIER);
        RETURN;
   END IF;
   
   IF V_REMAIN_COUNT != 0 THEN
                           -- &&SUPPLIER 는 미정산내역이 존재하므로 확정할 수 없습니다. --
        X_RESULT_MSG    := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F,'INV_10026', '&&SUPPLIER:=' || V_SUPPLIER);
        RETURN;
   END IF;
   
   ---------------------
   -- 확정처리        --
   ---------------------
   IF V_REMAIN_COUNT = 0 THEN  --AND NVL(V_SLIP_AMOUNT,0) != 0 THEN
       
       -- ADJUST SUPPLIER UPDATE --
       BEGIN
             UPDATE WIP_OUT_ADJUST_SUPPLIER   PAS
                SET PAS.CONFIRM_FLAG         = 'Y'
                  , PAS.LAST_UPDATE_DATE     = V_LOCAL_DATE
                  , PAS.LAST_UPDATED_BY      = P_USER_ID
              WHERE PAS.SOB_ID               = P_SOB_ID
                AND PAS.ORG_ID               = P_ORG_ID
                AND PAS.ADJUST_SUPPLIER_ID   = P_ADJUST_SUPPLIER_ID;
       EXCEPTION WHEN OTHERS THEN
            X_RESULT_MSG := 'Supplier Confirm Error : ' || SQLERRM;
            RETURN;
       END;
       
/*       -- ADJUST TRX UPDATE --   -- 외주처 확정시에는 라인에 반영되지 않도록 변경, 김진영사원 요청, 2011-11-18, BY MJSHIN --
       BEGIN
             UPDATE WIP_OUT_ADJUST_TRX  PAT
                SET PAT.CONFIRM_FLAG   = 'Y'
              WHERE PAT.SOB_ID              = P_SOB_ID
                AND PAT.ORG_ID              = P_ORG_ID
                AND PAT.ADJUST_SUPPLIER_ID  = P_ADJUST_SUPPLIER_ID
                ;
       EXCEPTION WHEN OTHERS THEN
            X_RESULT_MSG := 'Transaction Confirm Error : ' || SQLERRM;
            RETURN;
       END;*/

   END IF;
   
   X_RESULT_STATUS := 'S';
                      -- 외주처별 확정처리가 완료되었습니다. --
   X_RESULT_MSG    := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F,'WIP_10190', NULL);

EXCEPTION WHEN OTHERS THEN
    X_RESULT_STATUS := 'F';          
END SUPPLIER_CONFIRM;


-------------------------------
-- SUPPLIER_CONFIRM_CANCEL   --
-------------------------------
PROCEDURE SUPPLIER_CONFIRM_CANCEL( P_SOB_ID              IN  NUMBER
                                 , P_ORG_ID              IN  NUMBER
                                 , P_ADJUST_SUPPLIER_ID  IN  NUMBER
                                 , P_USER_ID             IN  NUMBER
                                 , X_RESULT_STATUS       OUT VARCHAR2
                                 , X_RESULT_MSG          OUT VARCHAR2
                                 )
IS
  V_LOCAL_DATE            DATE := GET_LOCAL_DATE(P_SOB_ID);  
BEGIN
   X_RESULT_STATUS := 'F';
   
   ---------------------
   -- 확정취소처리    --
   ---------------------
   -- Supplier UPDATE --
   BEGIN
         UPDATE WIP_OUT_ADJUST_SUPPLIER   PAS
            SET PAS.CONFIRM_FLAG         = 'N'
              , PAS.LAST_UPDATE_DATE     = V_LOCAL_DATE
              , PAS.LAST_UPDATED_BY      = P_USER_ID
          WHERE PAS.SOB_ID               = P_SOB_ID
            AND PAS.ORG_ID               = P_ORG_ID
            AND PAS.ADJUST_SUPPLIER_ID   = P_ADJUST_SUPPLIER_ID;
   EXCEPTION WHEN OTHERS THEN
        X_RESULT_MSG := 'Supplier Confirm-Cancel Error : ' || SQLERRM;
        RETURN;
   END;
   
   
/*   -- TRX UPDATE --    -- 외주처 확정 취소시에는 라인에 반영되지 않도록 변경, 김진영사원 요청, 2011-11-18, BY MJSHIN --
   BEGIN
         UPDATE WIP_OUT_ADJUST_TRX  PAT
            SET PAT.CONFIRM_FLAG   = 'N'
          WHERE PAT.SOB_ID              = P_SOB_ID
            AND PAT.ORG_ID              = P_ORG_ID
            AND PAT.ADJUST_SUPPLIER_ID  = P_ADJUST_SUPPLIER_ID
            ;
   EXCEPTION WHEN OTHERS THEN
        X_RESULT_MSG := 'Transaction Confirm-Cancel Error : ' || SQLERRM;
        RETURN;
   END;*/
       
   X_RESULT_STATUS := 'S';
                      -- 외주처별 확정취소 처리가 완료되었습니다. --
   X_RESULT_MSG    := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F,'WIP_10191', NULL);

EXCEPTION WHEN OTHERS THEN
    X_RESULT_STATUS := 'F';          
END SUPPLIER_CONFIRM_CANCEL;

------------------------
-- TRX_CONFIRM        --
------------------------
PROCEDURE TRX_CONFIRM  ( P_SOB_ID              IN  NUMBER
                       , P_ORG_ID              IN  NUMBER
                       , P_ADJUST_SUPPLIER_ID  IN  NUMBER
                       , P_ADJUST_TRX_ID       IN  NUMBER
                       , P_USER_ID             IN  NUMBER
                       , X_RESULT_STATUS       OUT VARCHAR2
                       , X_RESULT_MSG          OUT VARCHAR2
                       )
IS
  V_LOCAL_DATE            DATE := GET_LOCAL_DATE(P_SOB_ID);  
  
  V_RESULT_FLAG           VARCHAR2(50);
  V_ADJUST_AMOUNT         NUMBER := 0;

BEGIN
  
   X_RESULT_STATUS := 'F';
   
   ----------------------------
   -- Validation             --
   ----------------------------
   BEGIN
        SELECT OAT.RESULT_FLAG
             , OAT.ADJUST_AMOUNT
          INTO V_RESULT_FLAG
             , V_ADJUST_AMOUNT
          FROM WIP_OUT_ADJUST_TRX      OAT
         WHERE OAT.SOB_ID              = P_SOB_ID
           AND OAT.ORG_ID              = P_ORG_ID
           AND OAT.ADJUST_SUPPLIER_ID  = P_ADJUST_SUPPLIER_ID
           AND OAT.ADJUST_TRX_ID       = P_ADJUST_TRX_ID
         ;        
   EXCEPTION WHEN OTHERS THEN
        V_RESULT_FLAG   := NULL;
        V_ADJUST_AMOUNT := 0;
   END;
   

   ---------------------
   -- 확정처리        --
   ---------------------
   IF V_RESULT_FLAG = 'NORMAL' THEN  --AND NVL(V_ADJUST_AMOUNT,0) != 0 THEN

       -- ADJUST TRX UPDATE --
       BEGIN
             UPDATE WIP_OUT_ADJUST_TRX  PAT
                SET PAT.CONFIRM_FLAG     = 'Y'
                  , PAT.LAST_UPDATE_DATE = V_LOCAL_DATE
                  , PAT.LAST_UPDATED_BY  = P_USER_ID
              WHERE PAT.SOB_ID              = P_SOB_ID
                AND PAT.ORG_ID              = P_ORG_ID
                AND PAT.ADJUST_SUPPLIER_ID  = P_ADJUST_SUPPLIER_ID
                AND PAT.ADJUST_TRX_ID       = P_ADJUST_TRX_ID
                ;
       EXCEPTION WHEN OTHERS THEN
            X_RESULT_MSG := 'Transaction Confirm Error : ' || SQLERRM;
            RETURN;
       END;
   
   END IF;
   
   X_RESULT_STATUS := 'S';
                      -- 외주 TRX 라인별 확정처리가 완료되었습니다. --
   X_RESULT_MSG    := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F,'WIP_10196', NULL);

EXCEPTION WHEN OTHERS THEN
    X_RESULT_STATUS := 'F';          
END TRX_CONFIRM;


-------------------------------
-- SUPPLIER_CONFIRM_CANCEL   --
-------------------------------
PROCEDURE TRX_CONFIRM_CANCEL ( P_SOB_ID              IN  NUMBER
                             , P_ORG_ID              IN  NUMBER
                             , P_ADJUST_SUPPLIER_ID  IN  NUMBER
                             , P_ADJUST_TRX_ID       IN  NUMBER
                             , P_USER_ID             IN  NUMBER
                             , X_RESULT_STATUS       OUT VARCHAR2
                             , X_RESULT_MSG          OUT VARCHAR2
                             )
IS
  V_LOCAL_DATE            DATE := GET_LOCAL_DATE(P_SOB_ID);  
BEGIN
   X_RESULT_STATUS := 'F';
   
   ---------------------
   -- 확정취소처리    --
   ---------------------
   -- TRX UPDATE --
   BEGIN
         UPDATE WIP_OUT_ADJUST_TRX  PAT
            SET PAT.CONFIRM_FLAG      = 'N'
              , PAT.LAST_UPDATE_DATE  = V_LOCAL_DATE
              , PAT.LAST_UPDATED_BY   = P_USER_ID
          WHERE PAT.SOB_ID              = P_SOB_ID
            AND PAT.ORG_ID              = P_ORG_ID
            AND PAT.ADJUST_SUPPLIER_ID  = P_ADJUST_SUPPLIER_ID
            AND PAT.ADJUST_TRX_ID       = P_ADJUST_TRX_ID
            ;
   EXCEPTION WHEN OTHERS THEN
        X_RESULT_MSG := 'Transaction Confirm-Cancel Error : ' || SQLERRM;
        RETURN;
   END;
   
   -- Supplier UPDATE --
   BEGIN
         UPDATE WIP_OUT_ADJUST_SUPPLIER   PAS
            SET PAS.CONFIRM_FLAG         = 'N'
              , PAS.LAST_UPDATE_DATE     = V_LOCAL_DATE
              , PAS.LAST_UPDATED_BY      = P_USER_ID
          WHERE PAS.SOB_ID               = P_SOB_ID
            AND PAS.ORG_ID               = P_ORG_ID
            AND PAS.ADJUST_SUPPLIER_ID   = P_ADJUST_SUPPLIER_ID;
   EXCEPTION WHEN OTHERS THEN
        X_RESULT_MSG := 'Supplier Confirm-Cancel Error : ' || SQLERRM;
        RETURN;
   END;
       
   X_RESULT_STATUS := 'S';
                      -- 외주 TRX 라인별 확정 취소 처리가 완료되었습니다. --
   X_RESULT_MSG    := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F,'WIP_10197', NULL);

EXCEPTION WHEN OTHERS THEN
    X_RESULT_STATUS := 'F';          
END TRX_CONFIRM_CANCEL;

-----------------------
-- SUPPLIER_SELECT   --
-----------------------
PROCEDURE SUPPLIER_SELECT ( P_CURSOR             OUT  TYPES.TCURSOR
                          , W_SOB_ID             IN   NUMBER
                          , W_ORG_ID             IN   NUMBER
                          , W_PERIOD_NAME        IN   VARCHAR2
                          , W_SUPPLIER_ID        IN   NUMBER
                          )
IS
BEGIN
        
        OPEN P_CURSOR FOR
        SELECT 'N' AS SELECT_FLAG
             , SUP.SUPPLIER_CODE
             , SUP.SUPPLIER_SHORT_NAME
             , SSW.WORKCENTER_DESCRIPTION
             , EAPP_COMMON_G.GET_LOOKUP_DESC(SSW.SOB_ID, SSW.ORG_ID, 'RESOURCE_OWNER', SSW.OWNER_TYPE_LCODE) AS OWNER_TYPE_DESC  
             , PAS.CONFIRM_FLAG
             , PAS.SLIP_INTERFACE_FLAG
             , PAS.TARGET_COUNT
             , PAS.ADJUST_COUNT
             , PAS.HOLDING_IN_COUNT
             , PAS.HOLDING_OUT_COUNT
             , PAS.REMAIN_COUNT
               
             -- TOTAL 외주비 --
             , NVL(PAS.SLIP_AMOUNT,0) + NVL(PAS.SAMPLE_SLIP_AMOUNT,0) AS TOTAL_SLIP_AMOUNT
             
               -- 양산 외주비 --
             , PAS.ADJUST_AMOUNT
             , PAS.MISC_AMOUNT
             , PAS.CLAIM_AMOUNT
             , PAS.SLIP_AMOUNT
               -- 샘플 외주비 --
             , PAS.SAMPLE_ADJUST_AMOUNT
             , PAS.SAMPLE_MISC_AMOUNT
             , PAS.SAMPLE_CLAIM_AMOUNT
             , PAS.SAMPLE_SLIP_AMOUNT
                              
             , APS.SUPPLIER_CODE        AS SLIP_SUPPLIER_CODE
             , APS.SUPPLIER_SHORT_NAME  AS SLIP_SUPPLIER_DESC
             
             , PAS.CURRENCY_CODE
             , FAC.ACCOUNT_CODE
             , FAC.ACCOUNT_DESC
             , PAS.SLIP_INTERFACE_DATE
             , PAS.SLIP_INTERFACE_PERSON_ID
             , EAPP_COMMON_G.GET_PERSON_NAME(PAS.SLIP_INTERFACE_PERSON_ID) AS SLIP_INTERFACE_PERSON_NAME
             , NULL AS SLIP_APPROVE_FLAG
             , NULL AS SLIP_APPROVE_DATE
             , NULL AS SLIP_APPROVE_PERSON_ID
             , NULL AS SLIP_APPROVE_PERSON_NAME  --EAPP_COMMON_G.GET_PERSON_NAME(PAS.SLIP_APPROVE_PERSON_ID) AS SLIP_APPROVE_PERSON_NAME
             , PAS.PERIOD_NAME
             , PAS.SUPPLIER_ID
             , PAS.WORKCENTER_ID
             , PAS.ADJUST_SUPPLIER_ID
             , SSW.OWNER_TYPE_LCODE
             , 'N' AS CLAIM_CHANGE_FLAG
             , PAS.ACCOUNT_CONTROL_ID
             , SSW.WORKCENTER_CODE
          FROM WIP_OUT_ADJUST_SUPPLIER  PAS
             , AP_SUPPLIER              SUP  -- 외주 작업 외주처   --
             , AP_SUPPLIER              APS  -- 외주비 지급 외주처 --
             , SDM_STANDARD_WORKCENTER  SSW
             , FI_ACCOUNT_CONTROL       FAC
         WHERE SUP.SUPPLIER_ID(+)        = PAS.SUPPLIER_ID
           AND APS.SUPPLIER_ID(+)        = PAS.SLIP_SUPPLIER_ID
           AND SSW.WORKCENTER_ID         = PAS.WORKCENTER_ID
           AND FAC.ACCOUNT_CONTROL_ID(+) = PAS.ACCOUNT_CONTROL_ID
           AND PAS.SOB_ID                = W_SOB_ID
           AND PAS.ORG_ID                = W_ORG_ID
           AND PAS.PERIOD_NAME           = W_PERIOD_NAME
           AND PAS.SUPPLIER_ID           = NVL(W_SUPPLIER_ID, PAS.SUPPLIER_ID)
         ORDER BY SUP.SUPPLIER_SHORT_NAME
                , SUP.SUPPLIER_CODE
         ;

END SUPPLIER_SELECT;


-----------------------
-- SUPPLIER_UPDATE   --
-----------------------
PROCEDURE SUPPLIER_UPDATE( W_ADJUST_SUPPLIER_ID       IN WIP_OUT_ADJUST_SUPPLIER.ADJUST_SUPPLIER_ID%TYPE
                         , P_ACCOUNT_CONTROL_ID       IN WIP_OUT_ADJUST_SUPPLIER.ACCOUNT_CONTROL_ID%TYPE )
IS

BEGIN

 UPDATE WIP_OUT_ADJUST_SUPPLIER
    SET ACCOUNT_CONTROL_ID       = P_ACCOUNT_CONTROL_ID
  WHERE ADJUST_SUPPLIER_ID       = W_ADJUST_SUPPLIER_ID;
 

EXCEPTION WHEN OTHERS THEN
  RAISE_APPLICATION_ERROR(-20001, SQLERRM);
END SUPPLIER_UPDATE;


--------------------------
-- 정산 TRX 대상 산출   --
--------------------------
PROCEDURE TRX_TARGET_SELECT ( P_CURSOR             OUT  TYPES.TCURSOR
                            , W_SOB_ID             IN   NUMBER
                            , W_ORG_ID             IN   NUMBER
                            , W_PERIOD_NAME        IN   VARCHAR2
                            , W_WORKCENTER_ID      IN   NUMBER
                            , W_DATE_FR            IN   DATE
                            , W_DATE_TO            IN   DATE
                            )
IS
   V_DATETIME_FR   DATE;
   V_DATETIME_TO   DATE;
   V_START_TIME    VARCHAR2(20);
   V_END_TIME      VARCHAR2(20);
BEGIN
  
       -----------------------
       -- DATE VALIDATION   --
       -----------------------
       IF TO_CHAR(W_DATE_FR,'YYYY-MM') != W_PERIOD_NAME   OR
          TO_CHAR(W_DATE_TO,'YYYY-MM') != W_PERIOD_NAME   THEN
          
                                              --정산년월과 지정일자가 일치하지 않습니다. 확인 후 재처리 바랍니다.--
              RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F,'WIP_10199', NULL));
              RETURN;
              
       END IF;
       
       BEGIN
            SELECT ELE.ENTRY_TAG
              INTO V_START_TIME
              FROM EAPP_LOOKUP_ENTRY  ELE
             WHERE ELE.SOB_ID         = W_SOB_ID
               AND ELE.ORG_ID         = W_ORG_ID
               AND ELE.LOOKUP_TYPE    = 'COST_PERIOD_TIME_ZONE'
               AND ELE.ENTRY_CODE     = 'START'
            ;
       EXCEPTION WHEN OTHERS THEN
            V_START_TIME := '08:30:00';         
       END;
       
       BEGIN
            SELECT ELE.ENTRY_TAG
              INTO V_END_TIME
              FROM EAPP_LOOKUP_ENTRY  ELE
             WHERE ELE.SOB_ID         = W_SOB_ID
               AND ELE.ORG_ID         = W_ORG_ID
               AND ELE.LOOKUP_TYPE    = 'COST_PERIOD_TIME_ZONE'
               AND ELE.ENTRY_CODE     = 'END'
            ;
       EXCEPTION WHEN OTHERS THEN
            V_START_TIME := '08:29:59';         
       END;
       

       V_DATETIME_FR := TO_DATE(TO_CHAR(W_DATE_FR,'YYYY-MM-DD') || ' ' || V_START_TIME , 'YYYY-MM-DD HH24:MI:SS');
       V_DATETIME_TO := TO_DATE(TO_CHAR(W_DATE_TO + 1,'YYYY-MM-DD') || ' ' || V_END_TIME , 'YYYY-MM-DD HH24:MI:SS');
        
        OPEN P_CURSOR FOR
        SELECT DISTINCT
               D.JOB_ID
             , D.JOB_NO
             , D.OPERATION_SEQ_NO
             , D.OPERATION_ID
             , SSO.OPERATION_CODE
             , SSO.OPERATION_DESCRIPTION
          FROM (SELECT WMT.JOB_ID
                     , WMT.JOB_NO
                     , CASE WHEN WMT.MOVE_TRX_TYPE = 'TOMOVE' THEN WMT.FROM_OP_SEQ_NO    ELSE WMT.TO_OP_SEQ_NO     END AS OPERATION_SEQ_NO
                     , CASE WHEN WMT.MOVE_TRX_TYPE = 'TOMOVE' THEN WMT.FROM_OPERATION_ID ELSE WMT.TO_OPERATION_ID  END AS OPERATION_ID
                     , WMT.ITEM_UOM_CODE
                  FROM WIP_MOVE_TRANSACTIONS    WMT
                     , SDM_STANDARD_RESOURCE    SSR
                     , WIP_MOVE_STEP            WMS
                     , SDM_STANDARD_RESOURCE    CSR  -- CANCEL_TOMOVE 정보 JOIN --
                 WHERE SSR.RESOURCE_ID          = WMT.FROM_RESOURCE_ID
                   AND WMS.MOVE_STEP_ID         = WMT.FROM_STEP_ID
                   AND CSR.RESOURCE_ID          = WMT.TO_RESOURCE_ID
                   AND WMT.SOB_ID               = W_SOB_ID
                   AND WMT.ORG_ID               = W_ORG_ID
                   AND (  (WMT.MOVE_TRX_TYPE = 'TOMOVE'        AND SSR.WORKCENTER_ID = W_WORKCENTER_ID)
                      OR (WMT.MOVE_TRX_TYPE = 'CANCEL_TOMOVE'  AND CSR.WORKCENTER_ID = W_WORKCENTER_ID))
                   AND WMT.MOVE_TRX_DATE        BETWEEN V_DATETIME_FR
                                                    AND V_DATETIME_TO
                   AND NOT EXISTS (SELECT 'N'                             -- 정산내역에 확정되지 않은 TRX만 생성 --
                                     FROM WIP_OUT_ADJUST_TRX  T
                                    WHERE T.SOB_ID           = W_SOB_ID
                                      AND T.ORG_ID           = W_ORG_ID
                                      --AND T.PERIOD_NAME      = P_PERIOD_NAME
                                      AND T.JOB_ID           = WMT.JOB_ID
                                      AND T.OPERATION_SEQ_NO = WMT.FROM_OP_SEQ_NO
                                      AND T.OPERATION_ID     = WMT.FROM_OPERATION_ID
                                      AND T.CONFIRM_FLAG     = 'Y')
                   AND NOT EXISTS (SELECT 'N'
                                     FROM WIP_OUT_ADJ_HOLDING_TRX H        -- 이월 (보류) 내역에 없는 TRX만 생성 --
                                    WHERE H.JOB_ID           = WMT.JOB_ID
                                      AND H.OPERATION_SEQ_NO = WMT.FROM_OP_SEQ_NO
                                      AND H.OPERATION_ID     = WMT.FROM_OPERATION_ID)
                                            
               ) D
               , SDM_STANDARD_OPERATION  SSO
           WHERE SSO.OPERATION_ID        = D.OPERATION_ID
               ;

END TRX_TARGET_SELECT;

------------------
-- TRX_CREATE   --
------------------
PROCEDURE TRX_ADJUST ( P_SOB_ID                 IN  NUMBER
                     , P_ORG_ID                 IN  NUMBER
                     , P_ADJUST_SUPPLIER_ID     IN  NUMBER
                     , P_PERIOD_NAME            IN  VARCHAR2
                     , P_SUPPLIER_ID            IN  NUMBER
                     , P_WORKCENTER_ID          IN  NUMBER
                     , P_JOB_ID                 IN  NUMBER
                     , P_OPERATION_SEQ_NO       IN  NUMBER
                     , P_OPERATION_ID           IN  NUMBER
                     , P_ORIGINAL_OPERATION_ID  IN  NUMBER
                     , P_USER_ID                IN  NUMBER
                     , X_RESULT_STATUS          OUT VARCHAR2
                     , X_RESULT_MSG             OUT VARCHAR2
                     )
IS
  V_LOCAL_DATE            DATE := GET_LOCAL_DATE(P_SOB_ID);  

  V_ADJUST_SUPPLIER_ID    NUMBER;
  V_ADJUST_TRX_ID         NUMBER;
  V_COUNTRY_CODE          VARCHAR2(50);
  
  V_DATETIME_FR           DATE;
  V_DATETIME_TO           DATE;
  
  V_PERIOD_DATE_FR        DATE;
  V_PERIOD_DATE_TO        DATE;
  
  -- ITEM SPEC 변수 --------------
  V_PNL_SIZE_X            NUMBER;
  V_PNL_SIZE_Y            NUMBER;
  V_PCS_PER_PNL_QTY       NUMBER;
  V_PCS_PER_MM_QTY        NUMBER;
  V_PCS_PER_ARRAY_QTY     NUMBER;
  V_ARRAY_PER_PNL_QTY     NUMBER;
  
  -- 인수량,작업량,불량,SPLIT_OUT량 ---
  V_RECEIPT_UOM_QTY       NUMBER := 0;
  V_RECEIPT_PNL_QTY       NUMBER := 0;
  V_RECEIPT_ARRAY_QTY     NUMBER := 0;
  V_RECEIPT_PCS_QTY       NUMBER := 0;
  
  V_RUN_END_UOM_QTY       NUMBER := 0;
  V_RUN_END_PNL_QTY       NUMBER := 0;
  V_RUN_END_ARRAY_QTY     NUMBER := 0;
  V_RUN_END_PCS_QTY       NUMBER := 0;

  V_TOMOVE_UOM_QTY        NUMBER := 0;
  V_TOMOVE_PNL_QTY        NUMBER := 0;
  V_TOMOVE_ARRAY_QTY      NUMBER := 0;
  V_TOMOVE_PCS_QTY        NUMBER := 0;
  V_TOMOVE_MM_QTY         NUMBER := 0;
    
  V_REJECT_UOM_QTY        NUMBER := 0;
  V_REJECT_PNL_QTY        NUMBER := 0;
  V_REJECT_ARRAY_QTY      NUMBER := 0;
  V_REJECT_PCS_QTY        NUMBER := 0;
  V_REJECT_MM_QTY         NUMBER := 0;
  
  V_ADJUST_UOM_QTY        NUMBER := 0;
  V_ADJUST_PNL_QTY        NUMBER := 0;
  V_ADJUST_ARRAY_QTY      NUMBER := 0;
  V_ADJUST_PCS_QTY        NUMBER := 0;
  V_ADJUST_MM_QTY         NUMBER := 0;
  
  -- LAST TOMOVE, REJECT INFO ---------
  V_TOMOVE_TRX_ID         NUMBER;
  V_TOMOVE_TRX_DATE       DATE;
  V_REJECT_TRX_ID         NUMBER;
  V_REJECT_TRX_DATE       DATE;
  
  -- 불량수량 포함 여부 ---------------
  V_REJECT_CONTAIN_FLAG   VARCHAR2(1) := 'N';
  
  -- MES PNL/ARRAY QTY (BH) -------------
  V_MES_GOOD_PNL              NUMBER := 0;
  V_MES_BAD_PNL               NUMBER := 0;
  V_MES_GOOD_ARRAY            NUMBER := 0;
  V_MES_BAD_ARRAY             NUMBER := 0;
  
  V_TRX_CONFIRM_FLAG          VARCHAR2(1);  -- TRX 확정여부 --
  V_HOLDING_IN_FLAG           VARCHAR2(1);  -- HOLDING 반영여부 --
  
  V_DEL_ADJUST_TRX_ID         NUMBER;       -- 삭제되는 TRX 정산 ID    --
  V_DEL_TRX_ADJUST_SUP_ID     NUMBER;       -- 삭제되는 TRX 정산외주처 --
  
  V_DEL_HOLDING_ADJUST_SUP_ID NUMBER;       -- 삭제되는 HOLDING 정산외주처 --
  V_DEL_ADJUST_HOLDING_ID     NUMBER;       -- 삭제되는 HOLDING 정산 ID    --
  
  V_EXTEND_CALENDAR_ID        NUMBER;
  V_EXTEND_DATE               DATE;
  
  
BEGIN
       X_RESULT_STATUS := 'F';
       
       -----------------------
       -- PERIOD DATE RANGE --
       -----------------------
       BEGIN
            SELECT ICP.PERIOD_START_DATE
                 , ICP.PERIOD_END_DATE
              INTO V_PERIOD_DATE_FR
                 , V_PERIOD_DATE_TO
              FROM INV_CLOSE_PERIOD  ICP
             WHERE ICP.SOB_ID        = P_SOB_ID
               AND ICP.ORG_ID        = P_ORG_ID
               AND ICP.PERIOD_NAME   = P_PERIOD_NAME
               AND ICP.CLOSE_TYPE    = 'WIP_OUT_ADJ'
               ;
       EXCEPTION WHEN OTHERS THEN
            V_PERIOD_DATE_FR := NULL;
            V_PERIOD_DATE_TO := NULL;
       END;
       
       V_DATETIME_FR := V_PERIOD_DATE_FR;
       V_DATETIME_TO := V_PERIOD_DATE_TO;
       
       
       -----------------------
       -- ADJUST SUPPLIER   --
       -----------------------
       IF P_ADJUST_SUPPLIER_ID IS NULL THEN
           BEGIN
                SELECT PAS.ADJUST_SUPPLIER_ID 
                  INTO V_ADJUST_SUPPLIER_ID
                  FROM WIP_OUT_ADJUST_SUPPLIER  PAS
                 WHERE PAS.SOB_ID              = P_SOB_ID
                   AND PAS.ORG_ID              = P_ORG_ID
                   AND PAS.PERIOD_NAME         = P_PERIOD_NAME
                   AND PAS.SUPPLIER_ID         = P_SUPPLIER_ID
                   AND PAS.WORKCENTER_ID       = P_WORKCENTER_ID
                   ;
           EXCEPTION WHEN OTHERS THEN
               V_ADJUST_SUPPLIER_ID := NULL;
           END; 
           
           IF V_ADJUST_SUPPLIER_ID IS NULL THEN
                X_RESULT_MSG := 'ADJUST_SUPPLIER_ID Select Error : ' || SQLERRM;
                RETURN; 
           END IF;
       ELSE
           V_ADJUST_SUPPLIER_ID := P_ADJUST_SUPPLIER_ID;
       END IF;
                  
      

       
       ---------------------------------------------------
       -- 공정별 수량 기준 SELECT  (불량수량 포함여부)  --
       ---------------------------------------------------
       BEGIN
            SELECT NVL(R.REJECT_FLAG,'N') 
              INTO V_REJECT_CONTAIN_FLAG 
              FROM WIP_OUT_ADJUST_QTY_RULE R
             WHERE R.SOB_ID                = P_SOB_ID
               AND R.ORG_ID                = P_ORG_ID
               AND R.OPERATION_ID          = P_OPERATION_ID
               AND ROWNUM                  = 1
               ;
       EXCEPTION WHEN OTHERS THEN
            V_REJECT_CONTAIN_FLAG := 'N';
       END;
       
       ------------------------------------------
       -- 외주처별 입고 TRX 생성               --
       ------------------------------------------
       FOR TRX IN ( SELECT D.SUPPLIER_ID
                         , D.WORKCENTER_ID
                         , D.RESOURCE_ID
                         , D.OWNER_TYPE_LCODE
                         , D.JOB_ID
                         , D.JOB_NO
                         , D.INVENTORY_ITEM_ID
                         , D.BOM_ITEM_ID
                         , D.OPERATION_SEQ_NO
                         , D.OPERATION_ID
                         , D.ITEM_UOM_CODE
                         , SUM(D.TOMOVE_UOM_QTY)   - SUM(D.CANCEL_TOMOVE_UOM_QTY)    AS TOMOVE_UOM_QTY
                         , SUM(D.TOMOVE_PNL_QTY)   - SUM(D.CANCEL_TOMOVE_PNL_QTY)    AS TOMOVE_PNL_QTY
                         , SUM(D.TOMOVE_ARRAY_QTY) - SUM(D.CANCEL_TOMOVE_ARRAY_QTY)  AS TOMOVE_ARRAY_QTY
                         , SUM(D.TOMOVE_PCS_QTY)   - SUM(D.CANCEL_TOMOVE_PCS_QTY)    AS TOMOVE_PCS_QTY
                      FROM (SELECT CASE WHEN WMT.MOVE_TRX_TYPE = 'TOMOVE' THEN SSW.SUPPLIER_ID      ELSE CSW.SUPPLIER_ID      END AS SUPPLIER_ID
                                 , CASE WHEN WMT.MOVE_TRX_TYPE = 'TOMOVE' THEN SSW.WORKCENTER_ID    ELSE CSW.WORKCENTER_ID    END AS WORKCENTER_ID
                                 , CASE WHEN WMT.MOVE_TRX_TYPE = 'TOMOVE' THEN WMT.FROM_RESOURCE_ID ELSE WMT.TO_RESOURCE_ID   END AS RESOURCE_ID
                                 , CASE WHEN WMT.MOVE_TRX_TYPE = 'TOMOVE' THEN SSW.OWNER_TYPE_LCODE ELSE CSW.OWNER_TYPE_LCODE END AS OWNER_TYPE_LCODE
                                 , WMT.JOB_ID
                                 , WMT.JOB_NO
                                 , WMT.INVENTORY_ITEM_ID
                                 , WMT.BOM_ITEM_ID
                                 , CASE WHEN WMT.MOVE_TRX_TYPE = 'TOMOVE' THEN WMT.FROM_OP_SEQ_NO    ELSE WMT.TO_OP_SEQ_NO     END AS OPERATION_SEQ_NO
                                 , CASE WHEN WMT.MOVE_TRX_TYPE = 'TOMOVE' THEN WMT.FROM_OPERATION_ID ELSE WMT.TO_OPERATION_ID  END AS OPERATION_ID
                                 , WMT.ITEM_UOM_CODE
                                 -- ITEM UOM QTY --
                                 , SUM(CASE WHEN WMS.MOVE_STEP = 'WAIT_MOVE' AND WMT.MOVE_TRX_TYPE = 'TOMOVE'         THEN WMT.UOM_QTY ELSE 0 END) AS TOMOVE_UOM_QTY
                                 , SUM(CASE WHEN WMS.MOVE_STEP = 'TOMOVE'    AND WMT.MOVE_TRX_TYPE = 'CANCEL_TOMOVE'  THEN WMT.UOM_QTY ELSE 0 END) AS CANCEL_TOMOVE_UOM_QTY
                                 -- PNL_QTY --
                                 , SUM(CASE WHEN WMT.MTX_UOM_CODE IN ('PNL','PNL_SFG') AND WMS.MOVE_STEP = 'WAIT_MOVE' AND WMT.MOVE_TRX_TYPE = 'TOMOVE'         
                                            THEN NVL(WMT.MTX_UOM_QTY1,0) + NVL(WMT.MTX_UOM_QTY2,0) + NVL(WMT.MTX_UOM_QTY3,0) + NVL(WMT.MTX_UOM_QTY4,0) ELSE 0 END) AS TOMOVE_PNL_QTY
                                 , SUM(CASE WHEN WMT.MTX_UOM_CODE IN ('PNL','PNL_SFG') AND WMS.MOVE_STEP = 'TOMOVE'    AND WMT.MOVE_TRX_TYPE = 'CANCEL_TOMOVE'  
                                            THEN NVL(WMT.MTX_UOM_QTY1,0) + NVL(WMT.MTX_UOM_QTY2,0) + NVL(WMT.MTX_UOM_QTY3,0) + NVL(WMT.MTX_UOM_QTY4,0) ELSE 0 END) AS CANCEL_TOMOVE_PNL_QTY
                                 -- ARRAY_QTY --
                                 , SUM(CASE WHEN WMT.MTX_UOM_CODE IN ('ARRAY','ARRAY_SFG') AND WMS.MOVE_STEP = 'WAIT_MOVE' AND WMT.MOVE_TRX_TYPE = 'TOMOVE'         
                                            THEN NVL(WMT.MTX_UOM_QTY1,0) + NVL(WMT.MTX_UOM_QTY2,0) + NVL(WMT.MTX_UOM_QTY3,0) + NVL(WMT.MTX_UOM_QTY4,0) ELSE 0 END) AS TOMOVE_ARRAY_QTY
                                 , SUM(CASE WHEN WMT.MTX_UOM_CODE IN ('ARRAY','ARRAY_SFG') AND WMS.MOVE_STEP = 'TOMOVE'    AND WMT.MOVE_TRX_TYPE = 'CANCEL_TOMOVE'  
                                            THEN NVL(WMT.MTX_UOM_QTY1,0) + NVL(WMT.MTX_UOM_QTY2,0) + NVL(WMT.MTX_UOM_QTY3,0) + NVL(WMT.MTX_UOM_QTY4,0) ELSE 0 END) AS CANCEL_TOMOVE_ARRAY_QTY    
                                 -- PCS_QTY --
                                 , SUM(CASE WHEN WMT.MTX_UOM_CODE = 'PCS' AND WMS.MOVE_STEP = 'WAIT_MOVE' AND WMT.MOVE_TRX_TYPE = 'TOMOVE'         
                                            THEN NVL(WMT.MTX_UOM_QTY1,0) + NVL(WMT.MTX_UOM_QTY2,0) + NVL(WMT.MTX_UOM_QTY3,0) + NVL(WMT.MTX_UOM_QTY4,0) ELSE 0 END) AS TOMOVE_PCS_QTY
                                 , SUM(CASE WHEN WMT.MTX_UOM_CODE = 'PCS' AND WMS.MOVE_STEP = 'TOMOVE'    AND WMT.MOVE_TRX_TYPE = 'CANCEL_TOMOVE'  
                                            THEN NVL(WMT.MTX_UOM_QTY1,0) + NVL(WMT.MTX_UOM_QTY2,0) + NVL(WMT.MTX_UOM_QTY3,0) + NVL(WMT.MTX_UOM_QTY4,0) ELSE 0 END) AS CANCEL_TOMOVE_PCS_QTY                                  

                              FROM WIP_MOVE_TRANSACTIONS    WMT
                                 , SDM_STANDARD_RESOURCE    SSR
                                 , SDM_STANDARD_WORKCENTER  SSW  
                                 , WIP_MOVE_STEP            WMS
                                 , SDM_STANDARD_RESOURCE    CSR  -- CANCEL_TOMOVE 정보 JOIN --
                                 , SDM_STANDARD_WORKCENTER  CSW  -- CANCEL_TOMOVE 정보 JOIN --
                             WHERE SSR.RESOURCE_ID          = WMT.FROM_RESOURCE_ID
                               AND SSW.WORKCENTER_ID        = SSR.WORKCENTER_ID
                               AND WMS.MOVE_STEP_ID         = WMT.FROM_STEP_ID
                               AND CSR.RESOURCE_ID          = WMT.TO_RESOURCE_ID
                               AND CSW.WORKCENTER_ID        = CSR.WORKCENTER_ID
                               AND WMT.SOB_ID               = P_SOB_ID
                               AND WMT.ORG_ID               = P_ORG_ID                               
                               AND WMT.JOB_ID               = P_JOB_ID
                               AND (  (WMT.MOVE_TRX_TYPE = 'TOMOVE'        AND WMS.MOVE_STEP         = 'WAIT_MOVE'
                                                                           AND WMT.FROM_OP_SEQ_NO    = P_OPERATION_SEQ_NO
                                                                           AND WMT.FROM_OPERATION_ID = P_ORIGINAL_OPERATION_ID  -- P_OPERATION_ID  --2012-10-23
                                                                           AND SSW.WORKCENTER_ID     = P_WORKCENTER_ID)
                                   OR (WMT.MOVE_TRX_TYPE = 'CANCEL_TOMOVE' AND WMS.MOVE_STEP         = 'TOMOVE'
                                                                           AND WMT.TO_OP_SEQ_NO      = P_OPERATION_SEQ_NO
                                                                           AND WMT.TO_OPERATION_ID   = P_ORIGINAL_OPERATION_ID  -- P_OPERATION_ID  --2012-10-23
                                                                           AND CSW.WORKCENTER_ID     = P_WORKCENTER_ID))

                                                              
                               AND WMT.MOVE_TRX_DATE        BETWEEN V_PERIOD_DATE_FR
                                                                AND V_PERIOD_DATE_TO
/*                               AND NOT EXISTS (SELECT 'N'                             -- 정산내역에 없는 TRX만 생성 --
                                                 FROM WIP_OUT_ADJUST_TRX  T
                                                WHERE T.SOB_ID           = P_SOB_ID
                                                  AND T.ORG_ID           = P_ORG_ID
                                                  --AND T.PERIOD_NAME      = P_PERIOD_NAME
                                                  AND T.JOB_ID           = WMT.JOB_ID
                                                  AND T.OPERATION_SEQ_NO = WMT.FROM_OP_SEQ_NO
                                                  \*AND T.OPERATION_ID     = WMT.FROM_OPERATION_ID*\)*/
                               AND NOT EXISTS (SELECT 'N'
                                                 FROM WIP_OUT_ADJ_HOLDING_TRX H        -- 이월 (보류) 내역에 없는 TRX만 생성 --
                                                WHERE H.JOB_ID           = WMT.JOB_ID
                                                  AND H.OPERATION_SEQ_NO = WMT.FROM_OP_SEQ_NO
                                                  AND H.OPERATION_ID     = WMT.FROM_OPERATION_ID)
                               
                             GROUP BY SSW.SUPPLIER_ID
                                    , SSW.WORKCENTER_ID
                                    , WMT.FROM_RESOURCE_ID   
                                    , SSW.OWNER_TYPE_LCODE
                                    , WMT.JOB_ID
                                    , WMT.JOB_NO
                                    , WMT.INVENTORY_ITEM_ID
                                    , WMT.BOM_ITEM_ID
                                    , WMT.FROM_OP_SEQ_NO     
                                    , WMT.FROM_OPERATION_ID  
                                    , WMT.ITEM_UOM_CODE
                                    
                                    , CSW.SUPPLIER_ID
                                    , CSW.WORKCENTER_ID
                                    , CSW.OWNER_TYPE_LCODE
                                    , WMT.TO_OP_SEQ_NO
                                    , WMT.TO_OPERATION_ID
                                    , WMT.TO_RESOURCE_ID
                                    , WMT.MOVE_TRX_TYPE
                                    
                           ) D
                    GROUP BY D.SUPPLIER_ID
                           , D.WORKCENTER_ID
                           , D.RESOURCE_ID
                           , D.OWNER_TYPE_LCODE
                           , D.JOB_ID
                           , D.JOB_NO
                           , D.INVENTORY_ITEM_ID
                           , D.BOM_ITEM_ID
                           , D.OPERATION_SEQ_NO
                           , D.OPERATION_ID
                           , D.ITEM_UOM_CODE
                  )
       LOOP
           
           -------------------------------------------------
           -- 기정산내역 CHECK , HOLDING 반영여부 CHECK   --
           -- 확  정 : 계산하지 않음 (기존데이터 유지)    --
           -- 미확정 : 삭제 후 재계산                     --
           -- 없  음 : 재계산                             --
           -------------------------------------------------
           
           FOR DEL_REC IN ( SELECT NVL(T.CONFIRM_FLAG,'N')     AS CONFIRM_FLAG
                                 , NVL(T.HOLDING_IN_FLAG,'N')  AS HOLDING_IN_FLAG
                                 , T.ADJUST_SUPPLIER_ID
                                 , T.ADJUST_TRX_ID
                              FROM WIP_OUT_ADJUST_TRX  T
                             WHERE T.JOB_ID            = P_JOB_ID
                               AND T.OPERATION_SEQ_NO  = P_OPERATION_SEQ_NO
                               AND T.OPERATION_ID      = P_ORIGINAL_OPERATION_ID -- P_OPERATION_ID --2012-10-23
                          )
           LOOP

                 IF DEL_REC.CONFIRM_FLAG != 'Y' THEN 
                   
                     ------------------------------------------
                     -- 확정하지 않은 기존데이터 삭제        --
                     ------------------------------------------
                     -- SPEC 데이터 삭제 --
                     BEGIN
                           DELETE WIP_OUT_ADJUST_SPEC  OSP
                            WHERE OSP.ADJUST_TRX_ID = DEL_REC.ADJUST_TRX_ID
                           ;  
                     EXCEPTION WHEN OTHERS THEN
                          X_RESULT_MSG := 'WIP_OUT_ADJUST_SPEC Delete Error : ' || SQLERRM;
                          RETURN;
                     END;
                           
                     -- TRX 데이터 삭제 --
                     BEGIN
                          DELETE WIP_OUT_ADJUST_TRX   PAT
                           WHERE PAT.ADJUST_TRX_ID    = DEL_REC.ADJUST_TRX_ID
                             ;
                     EXCEPTION WHEN OTHERS THEN
                          X_RESULT_MSG := 'WIP_OUT_ADJUST_TRX Delete Error : ' || SQLERRM;
                          RETURN;     
                     END;
                     ---------------------------------------------------------------------
                     -- 삭제한 데이터가 다른 외주처이면 삭제외주처 COUNT 재계산         --                     
                     ---------------------------------------------------------------------
                     IF DEL_REC.ADJUST_SUPPLIER_ID != V_ADJUST_SUPPLIER_ID THEN

                           BEGIN
                               SUPPLIER_ADJUST_COUNT ( P_PERIOD_NAME         => P_PERIOD_NAME
                                                     , P_ADJUST_SUPPLIER_ID  => DEL_REC.ADJUST_SUPPLIER_ID
                                                     , X_RESULT_STATUS       => X_RESULT_STATUS
                                                     , X_RESULT_MSG          => X_RESULT_MSG
                                                     );
                           EXCEPTION WHEN OTHERS THEN
                                X_RESULT_MSG := ' Delete Supplier Trx Count Update Error : ' || SQLERRM;
                                RETURN;
                           END;       
                                                         
                     END IF;

                 END IF;   -- IF V_TRX_CONFIRM_FLAG != 'Y' THEN
                                      
           END LOOP;
                                
                     
           ------------------------------
           -- HOLDING 데이터 CHECK     --
           ------------------------------
           FOR HOLD_REC IN (SELECT AHT.ADJUST_TRX_ID       AS ADJUST_TRX_ID
                                 , AHT.ADJUST_SUPPLIER_ID  AS ADJUST_SUPPLIER_ID
                              FROM WIP_OUT_ADJ_HOLDING_TRX AHT
                             WHERE AHT.JOB_ID              = P_JOB_ID
                               AND AHT.OPERATION_SEQ_NO    = P_OPERATION_SEQ_NO
                               AND AHT.OPERATION_ID        = P_ORIGINAL_OPERATION_ID  -- P_OPERATION_ID  --2012-10-23
                               AND NOT EXISTS (SELECT 'N'
                                                 FROM WIP_OUT_ADJUST_TRX  T
                                                WHERE T.ADJUST_TRX_ID   = AHT.ADJUST_TRX_ID)
                           )
           LOOP
                           
                 -- HOLDING SPEC 데이터 삭제 --
                 BEGIN
                       DELETE WIP_OUT_ADJ_HOLDING_SPEC  AHS
                        WHERE AHS.ADJUST_TRX_ID         = HOLD_REC.ADJUST_TRX_ID
                       ;  
                 EXCEPTION WHEN OTHERS THEN
                      X_RESULT_MSG := 'WIP_OUT_ADJ_HOLDING_SPEC Delete Error : ' || SQLERRM;
                      RETURN;
                 END;
                               
                 -- HOLDING TRX 데이터 삭제 --
                 BEGIN
                       DELETE WIP_OUT_ADJ_HOLDING_TRX  AHT
                        WHERE AHT.ADJUST_TRX_ID        = HOLD_REC.ADJUST_TRX_ID                           
                       ;  
                 EXCEPTION WHEN OTHERS THEN
                      X_RESULT_MSG := 'WIP_OUT_ADJ_HOLDING_TRX Delete Error : ' || SQLERRM;
                      RETURN;
                 END;

                 ---------------------------------------------------------------------
                 -- HOLDING 삭제한 데이터가 다른 외주처이면 삭제외주처 COUNT 재계산 --                     
                 ---------------------------------------------------------------------
                 IF V_DEL_HOLDING_ADJUST_SUP_ID != V_ADJUST_SUPPLIER_ID THEN

                       BEGIN
                           SUPPLIER_ADJUST_COUNT ( P_PERIOD_NAME         => P_PERIOD_NAME
                                                 , P_ADJUST_SUPPLIER_ID  => HOLD_REC.ADJUST_TRX_ID
                                                 , X_RESULT_STATUS       => X_RESULT_STATUS
                                                 , X_RESULT_MSG          => X_RESULT_MSG
                                                 );
                       EXCEPTION WHEN OTHERS THEN
                            X_RESULT_MSG := 'Holding Delete Supplier Trx Count Update Error : ' || SQLERRM;
                            RETURN;
                       END;       
                                                         
                 END IF;
                                              
           END LOOP;

           BEGIN
                SELECT NVL(T.CONFIRM_FLAG,'N')     AS CONFIRM_FLAG
                  INTO V_TRX_CONFIRM_FLAG
                  FROM WIP_OUT_ADJUST_TRX  T
                 WHERE T.JOB_ID            = P_JOB_ID
                   AND T.OPERATION_SEQ_NO  = P_OPERATION_SEQ_NO
                   AND T.OPERATION_ID      = P_ORIGINAL_OPERATION_ID  -- P_OPERATION_ID --2012-10-23
                   ;
           EXCEPTION WHEN OTHERS THEN
                 V_TRX_CONFIRM_FLAG := 'N';
           END;
           
           IF NVL(TRX.TOMOVE_UOM_QTY,0) != 0 AND V_TRX_CONFIRM_FLAG = 'N' THEN    
                        
               V_TOMOVE_UOM_QTY   := TRX.TOMOVE_UOM_QTY;
               V_TOMOVE_PNL_QTY   := TRX.TOMOVE_PNL_QTY;
               V_TOMOVE_ARRAY_QTY := TRX.TOMOVE_ARRAY_QTY;
               V_TOMOVE_PCS_QTY   := TRX.TOMOVE_PCS_QTY;
               
               V_MES_GOOD_PNL   := 0;
               V_MES_BAD_PNL    := 0;
               V_MES_GOOD_ARRAY := 0;
               V_MES_BAD_ARRAY  := 0;
                       
/*               -------------------------------------
               -- (BH) MES PNL/ARRAY QTY SELECT   --
               -------------------------------------
               IF P_SOB_ID = 10 THEN
                   BEGIN
                        SELECT MES.GOOD_PNL
                             , MES.BAD_PNL
                             , MES.GOOD_KIT
                             , MES.BAD_KIT
                          INTO V_MES_GOOD_PNL
                             , V_MES_BAD_PNL
                             , V_MES_GOOD_ARRAY
                             , V_MES_BAD_ARRAY
                          FROM MESPRO.TB_MES_210  MES
                         WHERE MES.PLANT_CODE = '100'
                           AND MES.LOT_NO     = MESPRO.FU_DB_LOT_NO(TRX.JOB_NO)
                           AND MES.PROC_CODE  = ( SELECT SSO.OPERATION_CODE
                                                    FROM APPS.SDM_STANDARD_OPERATION SSO
                                                   WHERE SSO.OPERATION_ID = TRX.OPERATION_ID )
                           AND ROWNUM         = 1; 
                   EXCEPTION WHEN OTHERS THEN
                       V_MES_GOOD_PNL   := 0;
                       V_MES_BAD_PNL    := 0;
                       V_MES_GOOD_ARRAY := 0;
                       V_MES_BAD_ARRAY  := 0;
                   END;
               END IF;*/
               
               -------------------------------------
               -- WIP_OUT_ADJUST_TRX INSERT       --
               -------------------------------------
               
               -- SUPPLIER Country Code --
               BEGIN
                    SELECT SUP.COUNTRY_CODE
                      INTO V_COUNTRY_CODE
                      FROM AP_SUPPLIER  SUP
                     WHERE SUP.SUPPLIER_ID = TRX.SUPPLIER_ID
                     ;
               EXCEPTION WHEN OTHERS THEN
                    V_COUNTRY_CODE := NULL;
               END;
               
               ----------------------------------------
               -- PNL_SIZE_X /PNL_SIZE_Y             --
               --	PCS_PER_PNL_QTY /	PCS_PER_MM_QTY   --
               ----------------------------------------
               BEGIN
                   GET_ITEM_SPEC_INFO  ( P_SOB_ID              => P_SOB_ID
                                       , P_ORG_ID              => P_ORG_ID
                                       , P_INVENTORY_ITEM_ID   => TRX.INVENTORY_ITEM_ID
                                       , P_BOM_ITEM_ID         => TRX.BOM_ITEM_ID
                                       , X_PNL_SIZE_X          => V_PNL_SIZE_X
                                       , X_PNL_SIZE_Y          => V_PNL_SIZE_Y
                                       , X_PCS_PER_PNL_QTY     => V_PCS_PER_PNL_QTY
                                       , X_PCS_PER_MM_QTY      => V_PCS_PER_MM_QTY
                                       , X_PCS_PER_ARRAY_QTY   => V_PCS_PER_ARRAY_QTY
                                       , X_ARRAY_PER_PNL_QTY   => V_ARRAY_PER_PNL_QTY
                                       );
               EXCEPTION WHEN OTHERS THEN
                     X_RESULT_MSG := 'ITEM_SPEC_INFO Select Error : ' || SQLERRM;
                     RETURN;
               END;
               
              
               -----------------------------------------------
               -- TOMOVE PNL / ARRAY / PCS / MM QTY         --
               -----------------------------------------------

               -- TOMOVE PCS QTY --
               IF    TRX.ITEM_UOM_CODE = 'PCS' THEN
                     V_TOMOVE_PCS_QTY := TRX.TOMOVE_UOM_QTY;
                     
               ELSIF NVL(TRX.TOMOVE_PCS_QTY,0) != 0 THEN
                     V_TOMOVE_PCS_QTY := TRX.TOMOVE_PCS_QTY;

               ELSIF NVL(TRX.TOMOVE_PNL_QTY,0) != 0 THEN
                     V_TOMOVE_PCS_QTY := TRX.TOMOVE_PNL_QTY * V_PCS_PER_PNL_QTY;
                     
               ELSIF NVL(TRX.TOMOVE_ARRAY_QTY,0) != 0 THEN
                     V_TOMOVE_PCS_QTY := TRX.TOMOVE_ARRAY_QTY * V_PCS_PER_ARRAY_QTY;
               
               END IF;      
                              
               -- TOMOVE PNL QTY --
               IF    TRX.ITEM_UOM_CODE = 'PNL' THEN
                     V_TOMOVE_PNL_QTY := TRX.TOMOVE_UOM_QTY;
               
               ELSIF TRX.ITEM_UOM_CODE = 'PCS' AND NVL(V_PCS_PER_PNL_QTY,0) != 0 THEN
                     V_TOMOVE_PNL_QTY := TRX.TOMOVE_UOM_QTY / V_PCS_PER_PNL_QTY;
                     
               ELSIF TRX.ITEM_UOM_CODE = 'ARRAY' AND NVL(V_ARRAY_PER_PNL_QTY,0) != 0 THEN
                     V_TOMOVE_PNL_QTY := TRX.TOMOVE_UOM_QTY / V_ARRAY_PER_PNL_QTY;
                     
               ELSIF NVL(TRX.TOMOVE_PNL_QTY,0) != 0 THEN
                     V_TOMOVE_PNL_QTY := TRX.TOMOVE_PNL_QTY;
               
               ELSIF P_SOB_ID = 10 AND V_MES_GOOD_PNL != 0 THEN
                     V_TOMOVE_PNL_QTY := V_MES_GOOD_PNL;
                     
               ELSIF NVL(TRX.TOMOVE_ARRAY_QTY,0) != 0 AND NVL(V_PCS_PER_PNL_QTY,0) != 0 THEN
                     V_TOMOVE_PNL_QTY := TRX.TOMOVE_ARRAY_QTY * V_PCS_PER_ARRAY_QTY / V_PCS_PER_PNL_QTY;
               
               ELSIF NVL(TRX.TOMOVE_PCS_QTY,0) != 0 AND NVL(V_PCS_PER_PNL_QTY,0) != 0 THEN
                     V_TOMOVE_PNL_QTY := TRX.TOMOVE_PCS_QTY / V_PCS_PER_PNL_QTY;
               
               END IF;      
               
               -- TOMOVE ARRAY QTY --
               IF    TRX.ITEM_UOM_CODE = 'ARRAY' THEN
                     V_TOMOVE_ARRAY_QTY := TRX.TOMOVE_UOM_QTY;

               ELSIF NVL(TRX.TOMOVE_ARRAY_QTY,0) != 0 THEN
                     V_TOMOVE_ARRAY_QTY := TRX.TOMOVE_ARRAY_QTY;
               
               ELSIF P_SOB_ID = 10 AND V_MES_GOOD_ARRAY != 0 THEN
                     V_TOMOVE_ARRAY_QTY := V_MES_GOOD_ARRAY;               
                     
               ELSIF NVL(TRX.TOMOVE_PNL_QTY,0) != 0 AND NVL(V_PCS_PER_ARRAY_QTY,0) != 0 THEN
                     V_TOMOVE_ARRAY_QTY := TRX.TOMOVE_PNL_QTY * V_PCS_PER_PNL_QTY / V_PCS_PER_ARRAY_QTY;

               ELSIF NVL(TRX.TOMOVE_PCS_QTY,0) != 0 AND NVL(V_PCS_PER_ARRAY_QTY,0) != 0 THEN
                     V_TOMOVE_ARRAY_QTY := TRX.TOMOVE_PCS_QTY / V_PCS_PER_ARRAY_QTY;
               
               END IF;      


               
               -- TOMOVE MM_QTY --
               IF    NVL(V_PNL_SIZE_X,0) != 0 AND NVL(V_PNL_SIZE_Y,0) != 0 THEN
                    IF TRX.ITEM_UOM_CODE = 'ARRAY' THEN
                         V_TOMOVE_MM_QTY := TRUNC(((V_PNL_SIZE_X * V_PNL_SIZE_Y) / 1000000) * CEIL(V_TOMOVE_ARRAY_QTY),2);
                    ELSE
                         V_TOMOVE_MM_QTY := TRUNC(((V_PNL_SIZE_X * V_PNL_SIZE_Y) / 1000000) * CEIL(V_TOMOVE_PNL_QTY),2);
                    END IF;  
               ELSIF NVL(V_PCS_PER_MM_QTY,0) != 0 THEN 
                      V_TOMOVE_MM_QTY := TRUNC(V_TOMOVE_PCS_QTY / V_PCS_PER_MM_QTY,2);
                      
               END IF;
               
               V_ADJUST_UOM_QTY   := NVL(V_TOMOVE_UOM_QTY,0);
               V_ADJUST_PNL_QTY   := NVL(V_TOMOVE_PNL_QTY,0);
               V_ADJUST_ARRAY_QTY := NVL(V_TOMOVE_ARRAY_QTY,0);
               V_ADJUST_PCS_QTY   := NVL(V_TOMOVE_PCS_QTY,0);
               V_ADJUST_MM_QTY    := NVL(V_TOMOVE_MM_QTY,0);
               

               ------------------------------------------
               -- 최종 TOMOVE 정보                     --
               ------------------------------------------
               BEGIN
                    SELECT MAX(WMT.MOVE_TRX_ID)
                         , MAX(WMT.MOVE_TRX_DATE)
                      INTO V_TOMOVE_TRX_ID
                         , V_TOMOVE_TRX_DATE
                      FROM WIP_MOVE_TRANSACTIONS WMT
                         , WIP_MOVE_STEP         WMS
                     WHERE WMS.MOVE_STEP_ID      = WMT.FROM_STEP_ID
                       AND WMT.JOB_ID            = TRX.JOB_ID
                       AND WMT.FROM_OP_SEQ_NO    = TRX.OPERATION_SEQ_NO
                       AND WMT.FROM_OPERATION_ID = TRX.OPERATION_ID
                       AND (  (WMT.MOVE_TRX_TYPE = 'TOMOVE' AND WMS.MOVE_STEP = 'WAIT_MOVE')
                           OR (WMT.MOVE_TRX_TYPE = 'CANCEL_TOMOVE' AND WMS.MOVE_STEP = 'TOMOVE'))
                       AND WMT.MOVE_TRX_DATE     BETWEEN V_DATETIME_FR
                                                     AND V_DATETIME_TO
                       ;
               EXCEPTION WHEN OTHERS THEN
                   V_TOMOVE_TRX_ID   := NULL;
                   V_TOMOVE_TRX_DATE := NULL;
               END; 
               
               
   

               ---------------------
               -- 불량 SELECT     --
               ---------------------
               BEGIN
                    SELECT NVL(D.REJECT_UOM_QTY,0)    - NVL(D.CANCEL_REJECT_UOM_QTY,0)     AS REJECT_UOM_QTY
                         , NVL(D.REJECT_PNL_QTY,0)    - NVL(D.CANCEL_REJECT_PNL_QTY,0)     AS REJECT_PNL_QTY
                         , NVL(D.REJECT_ARRAY_QTY,0)  - NVL(D.CANCEL_REJECT_ARRAY_QTY,0)   AS REJECT_ARRAY_QTY
                         , NVL(D.REJECT_PCS_QTY,0)    - NVL(D.CANCEL_REJECT_PCS_QTY,0)     AS REJECT_PCS_QTY
                      INTO V_REJECT_UOM_QTY
                         , V_REJECT_PNL_QTY
                         , V_REJECT_ARRAY_QTY
                         , V_REJECT_PCS_QTY
                      FROM (SELECT -- ITEM UOM QTY --
                                   SUM(CASE WHEN WMS.MOVE_STEP = 'WAIT_MOVE' AND WMT.MOVE_TRX_TYPE = 'REJECT'         THEN WMT.UOM_QTY ELSE 0 END) AS REJECT_UOM_QTY
                                 , SUM(CASE WHEN WMS.MOVE_STEP = 'REJECT'    AND WMT.MOVE_TRX_TYPE = 'CANCEL_REJECT'  THEN WMT.UOM_QTY ELSE 0 END) AS CANCEL_REJECT_UOM_QTY
                                   -- PNL_QTY --
                                 , SUM(CASE WHEN WMT.MTX_UOM_CODE IN ('PNL','PNL_SFG') AND WMS.MOVE_STEP = 'WAIT_MOVE' AND WMT.MOVE_TRX_TYPE = 'REJECT'         
                                            THEN NVL(WMT.MTX_UOM_QTY1,0) + NVL(WMT.MTX_UOM_QTY2,0) + NVL(WMT.MTX_UOM_QTY3,0) + NVL(WMT.MTX_UOM_QTY4,0) ELSE 0 END) AS REJECT_PNL_QTY
                                 , SUM(CASE WHEN WMT.MTX_UOM_CODE IN ('PNL','PNL_SFG') AND WMS.MOVE_STEP = 'REJECT'    AND WMT.MOVE_TRX_TYPE = 'CANCEL_REJECT'  
                                            THEN NVL(WMT.MTX_UOM_QTY1,0) + NVL(WMT.MTX_UOM_QTY2,0) + NVL(WMT.MTX_UOM_QTY3,0) + NVL(WMT.MTX_UOM_QTY4,0) ELSE 0 END) AS CANCEL_REJECT_PNL_QTY
                                   -- ARRAY_QTY --
                                 , SUM(CASE WHEN WMT.MTX_UOM_CODE IN ('ARRAY','ARRAY_SFG') AND WMS.MOVE_STEP = 'WAIT_MOVE' AND WMT.MOVE_TRX_TYPE = 'REJECT'         
                                            THEN NVL(WMT.MTX_UOM_QTY1,0) + NVL(WMT.MTX_UOM_QTY2,0) + NVL(WMT.MTX_UOM_QTY3,0) + NVL(WMT.MTX_UOM_QTY4,0) ELSE 0 END) AS REJECT_ARRAY_QTY
                                 , SUM(CASE WHEN WMT.MTX_UOM_CODE IN ('ARRAY','ARRAY_SFG') AND WMS.MOVE_STEP = 'REJECT'    AND WMT.MOVE_TRX_TYPE = 'CANCEL_REJECT'  
                                            THEN NVL(WMT.MTX_UOM_QTY1,0) + NVL(WMT.MTX_UOM_QTY2,0) + NVL(WMT.MTX_UOM_QTY3,0) + NVL(WMT.MTX_UOM_QTY4,0) ELSE 0 END) AS CANCEL_REJECT_ARRAY_QTY
                                   -- PCS_QTY --
                                 , SUM(CASE WHEN WMT.MTX_UOM_CODE = 'PCS' AND WMS.MOVE_STEP = 'WAIT_MOVE' AND WMT.MOVE_TRX_TYPE = 'REJECT'         
                                            THEN NVL(WMT.MTX_UOM_QTY1,0) + NVL(WMT.MTX_UOM_QTY2,0) + NVL(WMT.MTX_UOM_QTY3,0) + NVL(WMT.MTX_UOM_QTY4,0) ELSE 0 END) AS REJECT_PCS_QTY
                                 , SUM(CASE WHEN WMT.MTX_UOM_CODE = 'PCS' AND WMS.MOVE_STEP = 'REJECT'    AND WMT.MOVE_TRX_TYPE = 'CANCEL_REJECT'  
                                            THEN NVL(WMT.MTX_UOM_QTY1,0) + NVL(WMT.MTX_UOM_QTY2,0) + NVL(WMT.MTX_UOM_QTY3,0) + NVL(WMT.MTX_UOM_QTY4,0) ELSE 0 END) AS CANCEL_REJECT_PCS_QTY

                              FROM WIP_MOVE_TRANSACTIONS    WMT
                                 , SDM_STANDARD_RESOURCE    SSR
                                 , SDM_STANDARD_WORKCENTER  SSW  
                                 , WIP_MOVE_STEP            WMS
                             WHERE SSR.RESOURCE_ID          = WMT.FROM_RESOURCE_ID
                               AND SSW.WORKCENTER_ID        = SSR.WORKCENTER_ID
                               AND WMS.MOVE_STEP_ID         = WMT.FROM_STEP_ID
                               AND WMT.JOB_ID               = TRX.JOB_ID
                               AND WMT.FROM_OP_SEQ_NO       = TRX.OPERATION_SEQ_NO
                               AND WMT.FROM_OPERATION_ID    = TRX.OPERATION_ID
                               AND WMT.FROM_RESOURCE_ID     = TRX.RESOURCE_ID
                               AND WMT.SOB_ID               = P_SOB_ID
                               AND WMT.ORG_ID               = P_ORG_ID
                               AND (  (WMT.MOVE_TRX_TYPE = 'REJECT'        AND WMS.MOVE_STEP = 'WAIT_MOVE')
                                   OR (WMT.MOVE_TRX_TYPE = 'CANCEL_REJECT' AND WMS.MOVE_STEP = 'REJECT'))
                               AND WMT.MOVE_TRX_DATE        BETWEEN V_PERIOD_DATE_FR
                                                                AND V_PERIOD_DATE_TO                               
                           ) D;           
               EXCEPTION WHEN OTHERS THEN
                    V_REJECT_UOM_QTY    := 0;
                    V_REJECT_PNL_QTY    := 0;
                    V_REJECT_ARRAY_QTY  := 0;
                    V_REJECT_PCS_QTY    := 0;
               END;   
                                   
               -----------------------------------------------
               -- REJECT PNL / ARRAY / PCS / MM QTY         --
               -----------------------------------------------
               -- REJECT PNL QTY --
               IF NVL(V_REJECT_PNL_QTY,0) = 0 THEN
                   IF    TRX.ITEM_UOM_CODE = 'PNL' THEN
                         V_REJECT_PNL_QTY := V_REJECT_UOM_QTY;
                             
                   ELSIF TRX.ITEM_UOM_CODE = 'PCS' AND NVL(V_PCS_PER_PNL_QTY,0) != 0 THEN
                         V_REJECT_PNL_QTY := V_REJECT_UOM_QTY / V_PCS_PER_PNL_QTY;
                           
                   ELSIF P_SOB_ID = 10 AND V_MES_BAD_PNL != 0 THEN
                         V_REJECT_PNL_QTY := V_MES_BAD_PNL;
                        
                   ELSIF NVL(V_REJECT_ARRAY_QTY,0) != 0 AND NVL(V_PCS_PER_PNL_QTY,0) != 0 THEN
                         V_REJECT_PNL_QTY := V_REJECT_ARRAY_QTY * V_PCS_PER_ARRAY_QTY / V_PCS_PER_PNL_QTY;
                           
                   ELSIF NVL(V_REJECT_PCS_QTY,0) != 0 AND NVL(V_PCS_PER_PNL_QTY,0) != 0 THEN
                         V_REJECT_PNL_QTY := V_REJECT_PCS_QTY / V_PCS_PER_PNL_QTY;
                           
                   END IF;      
               END IF;
                       
               -- REJECT ARRAY QTY --
               IF NVL(V_REJECT_ARRAY_QTY,0) = 0 THEN
                   IF    TRX.ITEM_UOM_CODE = 'ARRAY' THEN
                         V_REJECT_ARRAY_QTY := V_REJECT_UOM_QTY;

                   ELSIF P_SOB_ID = 10 AND V_MES_BAD_ARRAY != 0 THEN
                         V_REJECT_ARRAY_QTY := V_MES_BAD_ARRAY;      
                       
                   ELSIF NVL(V_REJECT_PNL_QTY,0) != 0 AND NVL(V_PCS_PER_ARRAY_QTY,0) != 0 THEN
                         V_REJECT_ARRAY_QTY := V_REJECT_PNL_QTY * V_PCS_PER_PNL_QTY / V_PCS_PER_ARRAY_QTY;

                   ELSIF NVL(V_REJECT_PCS_QTY,0) != 0 AND NVL(V_PCS_PER_ARRAY_QTY,0) != 0 THEN
                         V_REJECT_ARRAY_QTY := V_REJECT_PCS_QTY / V_PCS_PER_ARRAY_QTY;
                           
                   END IF;      
               END IF;
                   
               -- REJECT PCS QTY --
               IF NVL(V_REJECT_PCS_QTY,0) = 0 THEN
                   IF    TRX.ITEM_UOM_CODE = 'PCS' THEN
                         V_REJECT_PCS_QTY := V_REJECT_UOM_QTY;
                                 
                   ELSIF NVL(V_REJECT_PNL_QTY,0) != 0 THEN
                         V_REJECT_PCS_QTY := V_REJECT_PNL_QTY * V_PCS_PER_PNL_QTY;
                                 
                   ELSIF NVL(V_REJECT_ARRAY_QTY,0) != 0 THEN
                         V_REJECT_PCS_QTY := V_REJECT_ARRAY_QTY * V_PCS_PER_ARRAY_QTY;
                           
                   END IF;      
               END IF;
                       
               -- REJECT MM_QTY --
               IF    NVL(V_PNL_SIZE_X,0) != 0 AND NVL(V_PNL_SIZE_Y,0) != 0 THEN
                      V_REJECT_MM_QTY := TRUNC(((V_PNL_SIZE_X * V_PNL_SIZE_Y) / 1000000) * V_REJECT_PNL_QTY,2);
                              
               ELSIF NVL(V_PCS_PER_MM_QTY,0) != 0 THEN 
                      V_REJECT_MM_QTY := TRUNC(V_REJECT_PCS_QTY / V_PCS_PER_MM_QTY,2);
                              
               END IF;

               ------------------------------------------
               -- 최종 REJECT 정보                     --
               ------------------------------------------
               BEGIN
                    SELECT MAX(WMT.MOVE_TRX_ID)
                         , MAX(WMT.MOVE_TRX_DATE)
                      INTO V_REJECT_TRX_ID
                         , V_REJECT_TRX_DATE
                      FROM WIP_MOVE_TRANSACTIONS WMT
                         , WIP_MOVE_STEP         WMS
                     WHERE WMS.MOVE_STEP_ID      = WMT.FROM_STEP_ID
                       AND WMT.JOB_ID            = TRX.JOB_ID
                       AND WMT.FROM_OP_SEQ_NO    = TRX.OPERATION_SEQ_NO
                       AND WMT.FROM_OPERATION_ID = TRX.OPERATION_ID
                       AND WMT.MOVE_TRX_TYPE     = 'REJECT'
                       AND WMS.MOVE_STEP         = 'WAIT_MOVE'
                       AND WMT.MOVE_TRX_DATE     BETWEEN V_DATETIME_FR
                                                     AND V_DATETIME_TO
                       ;
               EXCEPTION WHEN OTHERS THEN
                   V_REJECT_TRX_ID   := NULL;
                   V_REJECT_TRX_DATE := NULL;
               END; 
                   
               -----------------------------------------------
               -- 외주비 정산 수량에 불량수량이 포함될 경우 --
               -----------------------------------------------
               IF V_REJECT_CONTAIN_FLAG = 'Y' THEN
            
                   V_ADJUST_UOM_QTY   := CEIL(NVL(V_ADJUST_UOM_QTY,0)   + NVL(V_REJECT_UOM_QTY,0));
                   V_ADJUST_PNL_QTY   := CEIL(NVL(V_ADJUST_PNL_QTY,0)   + NVL(V_REJECT_PNL_QTY,0));
                   V_ADJUST_ARRAY_QTY := CEIL(NVL(V_ADJUST_ARRAY_QTY,0) + NVL(V_REJECT_ARRAY_QTY,0));
                   V_ADJUST_PCS_QTY   := CEIL(NVL(V_ADJUST_PCS_QTY,0)   + NVL(V_REJECT_PCS_QTY,0));
                   V_ADJUST_MM_QTY    := TRUNC(NVL(V_ADJUST_MM_QTY,0)   + NVL(V_REJECT_MM_QTY,0),2);
               
               ELSE
                   V_ADJUST_UOM_QTY   := CEIL(NVL(V_ADJUST_UOM_QTY,0));
                   V_ADJUST_PNL_QTY   := CEIL(NVL(V_ADJUST_PNL_QTY,0));
                   V_ADJUST_ARRAY_QTY := CEIL(NVL(V_ADJUST_ARRAY_QTY,0));
                   V_ADJUST_PCS_QTY   := CEIL(NVL(V_ADJUST_PCS_QTY,0));
                   V_ADJUST_MM_QTY    := TRUNC(NVL(V_ADJUST_MM_QTY,0),2);                              
                              
               END IF;  -- IF V_REJECT_CONTAIN_FLAG = 'Y' THEN --  
               
               
               -------------------------------------------
               -- EXTEND DATE                           --
               -------------------------------------------
               EAPP_COMMON_G.GET_EXTEND_DATE_P( P_SOB_ID             => P_SOB_ID
                                              , P_ORG_ID             => P_ORG_ID
                                              , P_TRX_DATE           => V_TOMOVE_TRX_DATE
                                              , X_EXTEND_CALENDAR_ID => V_EXTEND_CALENDAR_ID
                                              , X_EXTEND_DATE        => V_EXTEND_DATE
                                              ); 

               -------------------------------------------
               -- TABLE INSERT                          --
               -------------------------------------------
               -- SEQUENCE --      
               BEGIN
                    SELECT WIP_OUT_ADJUST_TRX_S1.NEXTVAL
                      INTO V_ADJUST_TRX_ID
                      FROM DUAL;
               EXCEPTION WHEN OTHERS THEN
                     X_RESULT_MSG := 'WIP_OUT_ADJUST_TRX_S1 Select Error : ' || SQLERRM;
                     RETURN;
               END;
               
               BEGIN
                    INSERT INTO WIP_OUT_ADJUST_TRX
                              (	ADJUST_TRX_ID
                              ,	SOB_ID
                              ,	ORG_ID
                              ,	ADJUST_SUPPLIER_ID
                              ,	PERIOD_NAME
                              ,	SUPPLIER_ID
                              ,	COUNTRY_CODE
                              ,	WORKCENTER_ID
                              ,	RESOURCE_ID
                              ,	OWNER_TYPE_LCODE
                              ,	JOB_ID
                              ,	JOB_NO
                              ,	INVENTORY_ITEM_ID
                              ,	BOM_ITEM_ID
                              ,	PNL_SIZE_X
                              ,	PNL_SIZE_Y
                              ,	PCS_PER_PNL_QTY
                              ,	PCS_PER_MM_QTY
                              , PCS_PER_ARRAY_QTY
                              ,	OPERATION_SEQ_NO
                              ,	OPERATION_ID
                              , ORIGINAL_OPERATION_ID
                              ,	ITEM_UOM_CODE
                              ,	RECEIPT_UOM_QTY
                              ,	RECEIPT_PNL_QTY
                              ,	RECEIPT_ARRAY_QTY
                              ,	RECEIPT_PCS_QTY
                              ,	RUN_END_UOM_QTY
                              ,	RUN_END_PNL_QTY
                              ,	RUN_END_ARRAY_QTY
                              ,	RUN_END_PCS_QTY
                              ,	TOMOVE_UOM_QTY
                              ,	TOMOVE_PNL_QTY
                              ,	TOMOVE_ARRAY_QTY
                              ,	TOMOVE_PCS_QTY
                              , TOMOVE_MM_QTY
                              ,	REJECT_UOM_QTY
                              ,	REJECT_PNL_QTY
                              ,	REJECT_ARRAY_QTY
                              ,	REJECT_PCS_QTY
                              , REJECT_MM_QTY
                              ,	ADJUST_UOM_QTY
                              ,	ADJUST_PNL_QTY
                              ,	ADJUST_ARRAY_QTY
                              ,	ADJUST_PCS_QTY
                              , ADJUST_MM_QTY
                              ,	TOMOVE_TRX_ID
                              ,	TOMOVE_TRX_DATE
                              , EXTEND_CALENDAR_ID
                              , EXTEND_DATE
                              ,	REJECT_TRX_ID
                              ,	REJECT_TRX_DATE
                              ,	CAL_CURRENCY_CODE
                              ,	CAL_PRICE
                              ,	CAL_AMOUNT
                              ,	LOW_LIMIT_AMOUNT
                              ,	HIGH_LIMIT_AMOUNT
                              ,	LOW_LIMIT_PRICE_UOM
                              ,	LOW_LIMIT_PRICE
                              ,	SETTING_FEE_AMOUNT
                              ,	SETTING_LIMIT_HOUR
                              ,	ADJUST_CURRENCY_CODE
                              ,	ADJUST_EXCHANGE_RATE
                              ,	ADJUST_PRICE
                              ,	ADJUST_AMOUNT
                              ,	RESULT_FLAG
                              ,	CONFIRM_FLAG
                              ,	CREATION_DATE
                              ,	CREATED_BY
                              ,	LAST_UPDATE_DATE
                              ,	LAST_UPDATED_BY
                              )
                         VALUES
                              (	V_ADJUST_TRX_ID             -- ADJUST_TRX_ID
                              , P_SOB_ID                    --	SOB_ID
                              , P_ORG_ID                    --	ORG_ID
                              , V_ADJUST_SUPPLIER_ID        --	ADJUST_SUPPLIER_ID
                              , P_PERIOD_NAME               --	PERIOD_NAME
                              , TRX.SUPPLIER_ID             --	SUPPLIER_ID
                              , V_COUNTRY_CODE              --	COUNTRY_CODE
                              , TRX.WORKCENTER_ID           --	WORKCENTER_ID
                              , TRX.RESOURCE_ID             --	RESOURCE_ID
                              , TRX.OWNER_TYPE_LCODE        --	OWNER_TYPE_LCODE
                              , TRX.JOB_ID                  --	JOB_ID
                              , TRX.JOB_NO                  --	JOB_NO
                              , TRX.INVENTORY_ITEM_ID       --	INVENTORY_ITEM_ID
                              , TRX.BOM_ITEM_ID             --	BOM_ITEM_ID
                              , V_PNL_SIZE_X                --	PNL_SIZE_X
                              , V_PNL_SIZE_Y                --	PNL_SIZE_Y
                              , V_PCS_PER_PNL_QTY           --	PCS_PER_PNL_QTY
                              , V_PCS_PER_MM_QTY            --	PCS_PER_MM_QTY
                              , V_PCS_PER_ARRAY_QTY         --  PCS_PER_ARRAY_QTY
                              , TRX.OPERATION_SEQ_NO        --	OPERATOIN_SEQ_NO
                              , TRX.OPERATION_ID            --	OPERATION_ID
                              , TRX.OPERATION_ID            --  ORIGINAL_OPERATION_ID
                              , TRX.ITEM_UOM_CODE           --	ITEM_UOM_CODE
                              , V_RECEIPT_UOM_QTY           --	RECEIPT_UOM_QTY
                              , V_RECEIPT_PNL_QTY           --	RECEIPT_PNL_QTY
                              , V_RECEIPT_ARRAY_QTY         --	RECEIPT_ARRAY_QTY
                              , V_RECEIPT_PCS_QTY           --	RECEIPT_PCS_QTY
                              , V_RUN_END_UOM_QTY           --	RUN_END_UOM_QTY
                              , V_RUN_END_PNL_QTY           --	RUN_END_PNL_QTY
                              , V_RUN_END_ARRAY_QTY         --	RUN_END_ARRAY_QTY
                              , V_RUN_END_PCS_QTY           --	RUN_END_PCS_QTY
                              , TRX.TOMOVE_UOM_QTY          --	TOMOVE_UOM_QTY
                              , CEIL(V_TOMOVE_PNL_QTY)            --	TOMOVE_PNL_QTY
                              , CEIL(V_TOMOVE_ARRAY_QTY)          --	TOMOVE_ARRAY_QTY
                              , V_TOMOVE_PCS_QTY            --	TOMOVE_PCS_QTY
                              , V_TOMOVE_MM_QTY             --  TOMOVE_MM_QTY
                              , V_REJECT_UOM_QTY            --	REJECT_UOM_QTY
                              , CEIL(V_REJECT_PNL_QTY)            --	REJECT_PNL_QTY
                              , CEIL(V_REJECT_ARRAY_QTY)          --	REJECT_ARRAY_QTY
                              , V_REJECT_PCS_QTY            --	REJECT_PCS_QTY
                              , V_REJECT_MM_QTY             --  REJECT_MM_QTY
                              , V_ADJUST_UOM_QTY            --	ADJUST_UOM_QTY
                              , CEIL(V_ADJUST_PNL_QTY)            --	ADJUST_PNL_QTY
                              , CEIL(V_ADJUST_ARRAY_QTY)          --	ADJUST_ARRAY_QTY
                              , V_ADJUST_PCS_QTY            --	ADJUST_PCS_QTY
                              , V_ADJUST_MM_QTY             --  ADJUST_MM_QTY
                              , V_TOMOVE_TRX_ID             --	TOMOVE_TRX_ID
                              , V_TOMOVE_TRX_DATE           --	TOMOVE_TRX_DATE
                              , V_EXTEND_CALENDAR_ID        --  EXTEND_CALENDAR_ID
                              , V_EXTEND_DATE               --  EXTEND_DATE                              
                              , V_REJECT_TRX_ID             --	REJECT_TRX_ID
                              , V_REJECT_TRX_DATE           --	REJECT_TRX_DATE
                              ,	NULL                        -- CAL_CURRENCY_CODE
                              ,	0                           -- CAL_PRICE
                              ,	0                           -- CAL_AMOUNT
                              , 0                           --	LOW_LIMIT_AMOUNT
                              , 0                           --	HIGH_LIMIT_AMOUNT
                              , NULL                        --	LOW_LIMIT_PRICE_UOM
                              , 0                           --	LOW_LIMIT_PRICE
                              , 0                           --	SETTING_FEE_AMOUNT
                              , 0                           --	SETTING_LIMIT_HOUR
                              , NULL                        --	ADJUST_CURRENCY_CODE
                              ,	0                           --	ADJUST_EXCHANGE_RATE
                              ,	0                           --	ADJUST_PRICE
                              ,	0                           --	ADJUST_AMOUNT
                              ,	NULL                        -- RESULT_FLAG
                              ,	'N'                         -- CONFIRM_FLAG
                              , V_LOCAL_DATE                --	CREATION_DATE
                              , P_USER_ID                   --	CREATED_BY
                              , V_LOCAL_DATE                --	LAST_UPDATE_DATE
                              , P_USER_ID                   --	LAST_UPDATED_BY
                              );
               EXCEPTION WHEN OTHERS THEN
                     X_RESULT_MSG := 'WIP_OUT_ADJUST_TRX Insert Error : ' || SQLERRM;
                     RETURN;
               END;
               
               COMMIT;
               
               -------------------
               -- 외주비 계산   --
               -------------------
               SPEC_ADJUST ( P_SOB_ID              => P_SOB_ID
                           , P_ADJUST_TRX_ID       => V_ADJUST_TRX_ID
                           , P_USER_ID             => P_USER_ID
                           , X_RESULT_STATUS       => X_RESULT_STATUS
                           , X_RESULT_MSG          => X_RESULT_MSG
                           );                           
               
           END IF; --IF NVL(TRX.TOMOVE_UOM_QTY,0) != 0 THEN--           
           
           COMMIT;
           
       END LOOP;  -- TRX --      
       
       -----------------------------
       -- 구매처별 집계내역 생성  --
       -----------------------------
       BEGIN
           SUPPLIER_ADJUST_COUNT ( P_PERIOD_NAME         => P_PERIOD_NAME
                                 , P_ADJUST_SUPPLIER_ID  => V_ADJUST_SUPPLIER_ID
                                 , X_RESULT_STATUS       => X_RESULT_STATUS
                                 , X_RESULT_MSG          => X_RESULT_MSG
                                 );
       EXCEPTION WHEN OTHERS THEN
            X_RESULT_MSG := 'Supplier Trx Count Update Error : ' || SQLERRM;
            RETURN;
       END;
        
       X_RESULT_STATUS := 'S';
       
EXCEPTION WHEN OTHERS THEN
    X_RESULT_STATUS := 'F';  
    X_RESULT_MSG    := SQLERRM;        
END TRX_ADJUST;



------------------
-- SPEC_ADJUST  --
------------------
PROCEDURE SPEC_ADJUST  ( P_SOB_ID              IN  NUMBER
                       , P_ADJUST_TRX_ID       IN  NUMBER
                       , P_USER_ID             IN  NUMBER
                       , X_RESULT_STATUS       OUT VARCHAR2
                       , X_RESULT_MSG          OUT VARCHAR2
                       )
IS
  V_LOCAL_DATE            DATE := GET_LOCAL_DATE(P_SOB_ID);  

  V_PERIOD_NAME           VARCHAR2(50);
  V_ADJUST_SUPPLIER_ID    NUMBER;
  V_SYSTEM_CURRENCY_CODE  VARCHAR2(50);
  
  -- 외주단가 변수 -------------------
  V_PRICE_CLASS           VARCHAR2(50);
  V_PRICE_TYPE_LCODE      VARCHAR2(50);
  V_PRICE_TYPE_DESC       VARCHAR2(200);
  V_OUT_PRICE             NUMBER := 0;
  V_OUT_PRICE_ID          NUMBER;
  V_OUT_AMOUNT            NUMBER := 0;
  V_LOW_LIMIT_AMOUNT      NUMBER := 0;   
  V_HIGH_LIMIT_AMOUNT     NUMBER := 0;
  V_LOW_LIMIT_PRICE_UOM   VARCHAR2(50);
  V_LOW_LIMIT_PRICE       NUMBER := 0;
  V_SETTING_FEE_AMOUNT    NUMBER := 0;
  V_SETTING_LIMIT_HOUR    NUMBER;
  
  V_BASIC_PRICE            NUMBER := 0;
  V_BASIC_AMOUNT           NUMBER := 0;
  --V_TRX_OUT_AMOUT          NUMBER;
  V_PRICE_APPLY_TYPE_LCODE VARCHAR2(50);
  V_PRICE_APPLY_TYPE_DESC  VARCHAR2(200);
  
  V_EXCEPT_CNT             NUMBER := 0;
  
  -- 하한단가 산정용 변수 -------------
  V_MM_PRICE               NUMBER := 0;
  V_PNL_PRICE              NUMBER := 0;
  V_ARRAY_PRICE            NUMBER := 0;
  V_PCS_PRICE              NUMBER := 0;

  -- SPEC기준 -------------------------
  V_DESIGN_SPEC_CNT       NUMBER := 0;
  V_WIP_SPEC_CNT          NUMBER := 0;
  
/*  -- SPEC SUMMARY 변수 ----------------
  V_SUM_CAL_CURRENCY_CODE     VARCHAR2(50);
  V_SUM_CAL_PRICE             NUMBER;
  V_SUM_CAL_AMOUNT            NUMBER;
  V_SUM_ADJUST_CURRENCY_CODE  VARCHAR2(50);
  V_SUM_ADJUST_EXCHANGE_RATE  NUMBER;
  V_SUM_ADJUST_PRICE          NUMBER;
  V_SUM_ADJUST_AMOUNT         NUMBER;   */ 
  
  -- 연속공정 미지급 변수 ---------------
  V_CNT                       NUMBER := 0;
  V_APPLY_FLAG                VARCHAR2(1);
  
  V_RESULT_FLAG               VARCHAR2(50);     
  V_BOM_ASSIGN_FLAG           VARCHAR2(1);  -- BOM 적용여부 --
  

  
BEGIN
       X_RESULT_STATUS := 'F';
       
       ------------------------------------------
       -- 기존 SPEC 데이터 삭제                --
       ------------------------------------------
       BEGIN
             DELETE WIP_OUT_ADJUST_SPEC  OSP
              WHERE OSP.ADJUST_TRX_ID = P_ADJUST_TRX_ID
             ;  
       EXCEPTION WHEN OTHERS THEN
            X_RESULT_MSG := 'WIP_OUT_ADJUST_SPEC Delete Error : ' || SQLERRM;
            RETURN;
       END;   
       
       
       -- 시스템 기준 통화 SELECT --
       V_SYSTEM_CURRENCY_CODE := FI_ACCOUNT_BOOK_G.BASE_CURRENCY_F(P_SOB_ID);
                  
       
       ------------------------------------------
       -- 입고 TRX SELECT                      --
       ------------------------------------------
       FOR TRX IN ( SELECT *
                      FROM WIP_OUT_ADJUST_TRX  OAT
                     WHERE OAT.ADJUST_TRX_ID   = P_ADJUST_TRX_ID
                       AND OAT.CONFIRM_FLAG    = 'N'    
                  )
       LOOP
         
           IF NVL(TRX.TOMOVE_UOM_QTY,0) != 0 THEN    
           
               -------------------------------------------------------------
               -- BOM 적용여부                                            --
               -- BOM_ASSIGN_FLAG = 'Y' >> BOM기준으로 산출               --
               -- BOM_ASSIGN_FLAG = 'N' >> 작업공정 vs 규격 MAP 으로 산출 --
               -------------------------------------------------------------
               BEGIN
                    SELECT M.BOM_ASSIGN_FLAG
                      INTO V_BOM_ASSIGN_FLAG
                      FROM SDM_OPERATION_SPEC_MAP M
                     WHERE M.OPERATION_ID         = TRX.OPERATION_ID
                       AND M.ENABLED_FLAG         = 'Y'
                       AND EXISTS (SELECT 'Y'
                                     FROM SDM_STANDARD_OP_SPEC  T
                                    WHERE T.OP_SPEC_ID          = M.OP_SPEC_ID
                                      AND T.ENABLED_FLAG        = 'Y')
                       AND ROWNUM                 = 1
                     ;
               EXCEPTION WHEN OTHERS THEN
                    V_BOM_ASSIGN_FLAG := 'N';
               END;

               ------------------------------------------------------------- 
               -- 작업기준/SPEC 조회                                      --
               -- 1. 설계BOM 기준으로 적용                                --
               -- 2. 설계BOM에 적용되지 않았을 경우 제조BOM 기준으로 적용 --
               -- 3. 작업공정별 MAPPING된 작업규격 적용                   --
               -------------------------------------------------------------
                   
               V_DESIGN_SPEC_CNT := 0;
               V_WIP_SPEC_CNT    := 0;
                   
               FOR D_SPEC IN (SELECT D.BOM_TYPE
                                   , D.OP_WORK_ID
                                   , D.OP_SPEC_ID
                                   , D.OP_SPEC_UOM_CODE
                                   , D.OP_SPEC_VALUE
                                FROM (SELECT 'DESIGN_BOM'            AS BOM_TYPE
                                           , S.OP_WORK_ID
                                           , S.OP_SPEC_ID
                                           , O.OP_SPEC_UOM_CODE
                                           , S.OP_SPEC_VALUE
                                        FROM SDM_BOM_OPERATION_SPEC  S
                                           , SDM_STANDARD_ROUTING    R
                                           , SDM_STANDARD_OP_SPEC    O
                                       WHERE R.STD_ROUTING_ID        = S.STD_ROUTING_ID
                                         AND O.OP_SPEC_ID            = S.OP_SPEC_ID
                                         AND NVL(S.OP_SPEC_VALUE,0)  > 0
                                         AND R.BOM_ITEM_ID           = TRX.BOM_ITEM_ID
                                         --AND R.OPERATION_SEQ_NO      = TRX.OPERATION_SEQ_NO
                                         AND R.OPERATION_ID          = TRX.OPERATION_ID
                                         --AND V_TOMOVE_TRX_DATE       BETWEEN S.EFFECTIVE_DATE_FR
                                         --                                AND NVL(S.EFFECTIVE_DATE_TO, V_TOMOVE_TRX_DATE)
                                         AND S.ENABLED_FLAG          = 'Y'
                                         AND V_BOM_ASSIGN_FLAG       = 'Y'
                                       ---------
                                       UNION ALL  
                                       ---------  
                                       SELECT 'WIP_BOM'            AS BOM_TYPE
                                           , OPS.OP_WORK_ID
                                           , OPS.OP_SPEC_ID
                                           , SOS.OP_SPEC_UOM_CODE
                                           , OPS.OP_SPEC_VALUE
                                        FROM WIP_OPERATION_SPEC      OPS
                                           , WIP_OPERATIONS          WOS
                                           , SDM_STANDARD_OP_SPEC    SOS
                                       WHERE WOS.WIP_OPERATION_ID    = OPS.WIP_OPERATION_ID
                                         AND SOS.OP_SPEC_ID          = OPS.OP_SPEC_ID
                                         AND NVL(OPS.OP_SPEC_VALUE,0)  > 0
                                         AND WOS.JOB_ID              = TRX.JOB_ID
                                         AND WOS.OPERATION_SEQ_NO    = TRX.OPERATION_SEQ_NO
                                         AND WOS.OPERATION_ID        = TRX.OPERATION_ID
                                         --AND V_TOMOVE_TRX_DATE       BETWEEN OPS.EFFECTIVE_DATE_FR
                                         --                                AND NVL(OPS.EFFECTIVE_DATE_TO, V_TOMOVE_TRX_DATE)
                                         AND OPS.ENABLED_FLAG        = 'Y'
                                         AND V_BOM_ASSIGN_FLAG       = 'Y'
                                       ---------
                                       UNION ALL
                                       ---------
                                       SELECT 'OP_MAP'        AS BOM_TYPE
                                             , SSM.OP_WORK_ID
                                             , SSM.OP_SPEC_ID
                                             , SPC.OP_SPEC_UOM_CODE
                                             , SSM.OP_SPEC_DEFAULT_VALUE   AS OP_SPEC_VALUE
                                          FROM SDM_OPERATION_SPEC_MAP  SSM
                                             , SDM_STANDARD_OP_SPEC    SPC
                                         WHERE SPC.OP_SPEC_ID          = SSM.OP_SPEC_ID
                                           AND SSM.OPERATION_ID        = TRX.OPERATION_ID
                                           AND TRX.TOMOVE_TRX_DATE       BETWEEN SSM.EFFECTIVE_DATE_FR
                                                                           AND NVL(SSM.EFFECTIVE_DATE_TO, TRX.TOMOVE_TRX_DATE) 
                                           AND SSM.ENABLED_FLAG        = 'Y'
                                           AND V_BOM_ASSIGN_FLAG       = 'N'
                                      ) D
                               ORDER BY CASE WHEN BOM_TYPE = 'DESIGN_BOM' THEN 1 
                                             WHEN BOM_TYPE = 'WIP_BOM'    THEN 2 
                                                                          ELSE 3 END
                                      , OP_WORK_ID
                             )
               LOOP
                     ------------------------------------------------------------------------------
                     -- 설계BOM에 WORK_SPEC 정보가 없을 경우에만 WIP_BOM 기준으로 외주비 정산    --
                     ------------------------------------------------------------------------------
                     IF D_SPEC.BOM_TYPE = 'DESIGN_BOM' THEN
                          V_DESIGN_SPEC_CNT := NVL(V_DESIGN_SPEC_CNT,0) + 1;
                     END IF;    
                         
                     IF D_SPEC.BOM_TYPE = 'WIP_BOM' THEN
                          V_WIP_SPEC_CNT := NVL(V_WIP_SPEC_CNT,0) + 1;
                     END IF; 
                         
                     EXIT WHEN (V_DESIGN_SPEC_CNT > 0 AND D_SPEC.BOM_TYPE IN  ('WIP_BOM','OP_MAP')) OR
                               (V_WIP_SPEC_CNT > 0    AND D_SPEC.BOM_TYPE = 'OP_MAP');
                     ------------------------------------------------------------------------------
                     BEGIN
                         GET_SPEC_AMOUNT ( P_SOB_ID                   => TRX.SOB_ID
                                         , P_ORG_ID                   => TRX.ORG_ID
                                         , P_OP_WORK_ID               => D_SPEC.OP_WORK_ID
                                         , P_OP_SPEC_ID               => D_SPEC.OP_SPEC_ID
                                         , P_OP_SPEC_UOM_CODE         => D_SPEC.OP_SPEC_UOM_CODE
                                         , P_OP_SPEC_VALUE            => D_SPEC.OP_SPEC_VALUE
                                         , P_ADJUST_TRX_ID            => TRX.ADJUST_TRX_ID
                                         , X_OUT_PRICE_ID             => V_OUT_PRICE_ID
                                         , X_PRICE_CLASS              => V_PRICE_CLASS
                                         , X_PRICE_TYPE_LCODE         => V_PRICE_TYPE_LCODE
                                         , X_PRICE_TYPE_DESC          => V_PRICE_TYPE_DESC
                                         , X_CURRENCY_CODE            => V_SYSTEM_CURRENCY_CODE
                                         , X_BASIC_PRICE              => V_BASIC_PRICE
                                         , X_BASIC_AMOUNT             => V_BASIC_AMOUNT
                                         , X_OUT_PRICE                => V_OUT_PRICE
                                         , X_OUT_AMOUNT               => V_OUT_AMOUNT
                                         , X_LOW_LIMIT_AMOUNT         => V_LOW_LIMIT_AMOUNT
                                         , X_HIGH_LIMIT_AMOUNT        => V_HIGH_LIMIT_AMOUNT
                                         , X_LOW_LIMIT_PRICE_UOM      => V_LOW_LIMIT_PRICE_UOM
                                         , X_LOW_LIMIT_PRICE          => V_LOW_LIMIT_PRICE
                                         , X_SETTING_FEE_AMOUNT       => V_SETTING_FEE_AMOUNT
                                         , X_SETTING_LIMIT_HOUR       => V_SETTING_LIMIT_HOUR
                                         , X_PRICE_APPLY_TYPE_LCODE   => V_PRICE_APPLY_TYPE_LCODE
                                         , X_PRICE_APPLY_TYPE_DESC    => V_PRICE_APPLY_TYPE_DESC
                                         , X_RESULT_STATUS            => X_RESULT_STATUS
                                         , X_RESULT_MSG               => X_RESULT_MSG
                                         );
                    EXCEPTION WHEN OTHERS THEN
                           X_RESULT_MSG := 'Spec Amount Select Error : ' || SQLERRM;
                           RETURN;
                    END; 
                     -------------------
                     -- 테이블 INSERT --
                     -------------------
                     INSERT INTO WIP_OUT_ADJUST_SPEC
                                (	ADJUST_SPEC_ID
                                ,	SOB_ID
                                ,	ORG_ID
                                ,	ADJUST_SUPPLIER_ID
                                ,	ADJUST_TRX_ID
                                ,	PERIOD_NAME
                                ,	OP_WORK_ID
                                ,	OP_SPEC_ID
                                ,	OP_SPEC_VALUE
                                ,	OP_SPEC_UOM_CODE
                                , OUT_PRICE_ID
                                ,	PRICE_CLASS
                                ,	PRICE_TYPE_LCODE
                                ,	CURRENCY_CODE
                                , BASIC_PRICE
                                , BASIC_AMOUNT
                                ,	OUT_PRICE
                                , OUT_AMOUNT
                                ,	LOW_LIMIT_AMOUNT
                                ,	HIGH_LIMIT_AMOUNT
                                ,	LOW_LIMIT_PRICE_UOM
                                ,	LOW_LIMIT_PRICE
                                ,	SETTING_FEE_AMOUNT
                                ,	SETTING_LIMIT_HOUR
                                , PRICE_APPLY_TYPE_LCODE
                                ,	ATTRIBUTE_A
                                ,	ATTRIBUTE_B
                                ,	ATTRIBUTE_C
                                ,	ATTRIBUTE_D
                                ,	ATTRIBUTE_E
                                ,	ATTRIBUTE_1
                                ,	ATTRIBUTE_2
                                ,	ATTRIBUTE_3
                                ,	ATTRIBUTE_4
                                ,	ATTRIBUTE_5
                                ,	CREATION_DATE
                                ,	CREATED_BY
                                ,	LAST_UPDATE_DATE
                                ,	LAST_UPDATED_BY
                                )
                           VALUES
                                ( WIP_OUT_ADJUST_SPEC_S1.NEXTVAL    --	ADJUST_SPEC_ID
                                , TRX.SOB_ID                          --	SOB_ID
                                , TRX.ORG_ID                          --	ORG_ID
                                , TRX.ADJUST_SUPPLIER_ID              --	ADJUST_SUPPLIER_ID
                                , TRX.ADJUST_TRX_ID                   --	ADJUST_TRX_ID
                                , TRX.PERIOD_NAME                     --	PERIOD_NAME
                                , D_SPEC.OP_WORK_ID                 --	OP_WORK_ID
                                , D_SPEC.OP_SPEC_ID                 --	OP_SPEC_ID
                                , D_SPEC.OP_SPEC_VALUE              --	OP_SPEC_VALUE
                                , D_SPEC.OP_SPEC_UOM_CODE           --	OP_SPEC_UOM_CODE
                                , V_OUT_PRICE_ID                    --  OUT_PRICE_ID
                                , V_PRICE_CLASS                     --	PRICE_CLASS
                                , V_PRICE_TYPE_LCODE                --	PRICE_TYPE_LCODE
                                , V_SYSTEM_CURRENCY_CODE            --	CURRENCY_CODE
                                , V_BASIC_PRICE                     --  BASIC_PRICE
                                , V_BASIC_AMOUNT                    --  BASIC_AMOUNT
                                , V_OUT_PRICE                       --	OUT_PRICE
                                , V_OUT_AMOUNT                      --  OUT_AMOUNT
                                , V_LOW_LIMIT_AMOUNT                --	LOW_LIMIT_AMOUNT
                                , V_HIGH_LIMIT_AMOUNT               --	HIGH_LIMIT_AMOUNT
                                , V_LOW_LIMIT_PRICE_UOM             --	LOW_LIMIT_PRICE_UOM
                                , V_LOW_LIMIT_PRICE                 --	LOW_LIMIT_PRICE
                                , V_SETTING_FEE_AMOUNT              --	SETTING_FEE_AMOUNT
                                , V_SETTING_LIMIT_HOUR              --	SETTING_LIMIT_HOUR
                                , V_PRICE_APPLY_TYPE_LCODE          --  PRICE_APPLY_TYPE_LCODE            
                                , NULL                              --	ATTRIBUTE_A
                                ,	NULL                              --	ATTRIBUTE_B
                                ,	NULL                              --	ATTRIBUTE_C
                                ,	NULL                              --	ATTRIBUTE_D
                                ,	NULL                              --	ATTRIBUTE_E
                                ,	NULL                              --	ATTRIBUTE_1
                                ,	NULL                              --	ATTRIBUTE_2
                                ,	NULL                              --	ATTRIBUTE_3
                                ,	NULL                              --	ATTRIBUTE_4
                                ,	NULL                              --	ATTRIBUTE_5
                                , V_LOCAL_DATE                      --	CREATION_DATE
                                , P_USER_ID                         --	CREATED_BY
                                , V_LOCAL_DATE                      --	LAST_UPDATE_DATE
                                , P_USER_ID                         --	LAST_UPDATED_BY
                                );
                         
                                          
               END LOOP;   -- D_SPEC --

               ----------------------------------------------------------------------
               -- 외주공정 지급 기준(연속공정 지급기준)에 따라 미지급 대상은 제외  --
               ----------------------------------------------------------------------
               V_APPLY_FLAG := 'N';
                   
               FOR  RULE IN (SELECT AOE.OP_RULE_TYPE_ID
                                  , AOE.OPERATION_ID
                                  , AOE.ADJUST_FLAG
                               FROM WIP_OUT_ADJUST_OP_ENTRY  AOE
                                  , WIP_OUT_ADJUST_OP_TYPE   AOT
                              WHERE AOT.OP_RULE_TYPE_ID      = AOE.OP_RULE_TYPE_ID
                                AND AOT.ENABLED_FLAG         = 'Y'
                                AND AOE.OPERATION_ID         = TRX.OPERATION_ID
                                AND AOE.ADJUST_FLAG          = 'N') 
               LOOP
                              
                    V_APPLY_FLAG := 'Y';
                              
                    FOR OP_CHK IN (SELECT E.OPERATION_ID 
                                     FROM WIP_OUT_ADJUST_OP_ENTRY E
                                    WHERE E.OP_RULE_TYPE_ID       = RULE.OP_RULE_TYPE_ID
                                      AND E.OPERATION_ID         != RULE.OPERATION_ID)
                    LOOP
                          BEGIN
                               SELECT COUNT(*)
                                 INTO V_CNT
                                 FROM WIP_OPERATIONS  WOS
                                WHERE WOS.JOB_ID        = TRX.JOB_ID
                                  AND WOS.OPERATION_ID  = OP_CHK.OPERATION_ID
                                  AND WOS.WORKCENTER_ID = TRX.WORKCENTER_ID    -- 연속공정 기준은 동일 업체일 경우만 해당 --
                                  ;
                          EXCEPTION WHEN OTHERS THEN
                              V_CNT := 0;
                          END;
                                    
                          IF NVL(V_CNT,0) != 0 AND V_APPLY_FLAG = 'Y' THEN
                                V_APPLY_FLAG := 'Y';
                          ELSE
                                V_APPLY_FLAG := 'N';        
                          END IF;
                                    
                    END LOOP;
                              
                              
               END LOOP;
                              
               IF V_APPLY_FLAG = 'Y' THEN
                   
                   BEGIN
                         UPDATE WIP_OUT_ADJUST_SPEC  OAS
                            SET OAS.OUT_AMOUNT       = 0
                              , OAS.PRICE_APPLY_TYPE_LCODE = 'EXCEPT_OPERATION'
                          WHERE OAS.ADJUST_TRX_ID    = TRX.ADJUST_TRX_ID
                          ;
                   EXCEPTION WHEN OTHERS THEN
                         X_RESULT_MSG := 'WIP_OUT_ADJUST_SPEC Except Operation Update Error : ' || SQLERRM;
                         RETURN;
                   END;
                       
               END IF;        
                                       
               ---------------------------------------------
               -- SPEC별 집계 내역을 TRX테이블에 UPDATE   --
               ---------------------------------------------
               BEGIN
                    SPEC_AMT_APPLY_TO_TRX  ( P_ADJUST_TRX_ID   => TRX.ADJUST_TRX_ID
                                           , X_RESULT_STATUS   => X_RESULT_STATUS
                                           , X_RESULT_MSG      => X_RESULT_MSG
                                           );
               EXCEPTION WHEN OTHERS THEN
                    X_RESULT_MSG := 'SPEC Amount Apply to TRX Error : ' || SQLERRM;
                    RETURN;
               END;
               


           END IF; --IF NVL(TRX.TOMOVE_UOM_QTY,0) != 0 THEN--           
           
           V_PERIOD_NAME        := TRX.PERIOD_NAME;
           V_ADJUST_SUPPLIER_ID := TRX.ADJUST_SUPPLIER_ID;

           
       END LOOP;  -- TRX --      
      
       
       -----------------------------
       -- 구매처별 집계내역 생성  --
       -----------------------------
       BEGIN
           SUPPLIER_ADJUST_COUNT ( P_PERIOD_NAME         => V_PERIOD_NAME
                                 , P_ADJUST_SUPPLIER_ID  => V_ADJUST_SUPPLIER_ID
                                 , X_RESULT_STATUS       => X_RESULT_STATUS
                                 , X_RESULT_MSG          => X_RESULT_MSG
                                 );
       EXCEPTION WHEN OTHERS THEN
            X_RESULT_MSG := 'Supplier Trx Count Update Error : ' || SQLERRM;
            RETURN;
       END;

        
       X_RESULT_STATUS := 'S';
       
EXCEPTION WHEN OTHERS THEN
    X_RESULT_STATUS := 'F';  
    X_RESULT_MSG    := SQLERRM;        
END SPEC_ADJUST;

----------------------
-- GET_SPEC_AMOUNT  --
----------------------
PROCEDURE GET_SPEC_AMOUNT  ( P_SOB_ID                   IN  NUMBER
                           , P_ORG_ID                   IN  NUMBER
                           , P_OP_WORK_ID               IN  NUMBER
                           , P_OP_SPEC_ID               IN  NUMBER
                           , P_OP_SPEC_UOM_CODE         IN  VARCHAR2
                           , P_OP_SPEC_VALUE            IN  NUMBER
                           , P_ADJUST_TRX_ID            IN  NUMBER
                           , X_OUT_PRICE_ID             OUT NUMBER
                           , X_PRICE_CLASS              OUT VARCHAR2
                           , X_PRICE_TYPE_LCODE         OUT VARCHAR2
                           , X_PRICE_TYPE_DESC          OUT VARCHAR2
                           , X_CURRENCY_CODE            OUT VARCHAR2
                           , X_BASIC_PRICE              OUT NUMBER
                           , X_BASIC_AMOUNT             OUT NUMBER
                           , X_OUT_PRICE                OUT NUMBER
                           , X_OUT_AMOUNT               OUT NUMBER
                           , X_LOW_LIMIT_AMOUNT         OUT NUMBER
                           , X_HIGH_LIMIT_AMOUNT        OUT NUMBER
                           , X_LOW_LIMIT_PRICE_UOM      OUT VARCHAR2
                           , X_LOW_LIMIT_PRICE          OUT NUMBER
                           , X_SETTING_FEE_AMOUNT       OUT NUMBER
                           , X_SETTING_LIMIT_HOUR       OUT NUMBER
                           , X_PRICE_APPLY_TYPE_LCODE   OUT VARCHAR2
                           , X_PRICE_APPLY_TYPE_DESC    OUT VARCHAR2
                           , X_RESULT_STATUS            OUT VARCHAR2
                           , X_RESULT_MSG               OUT VARCHAR2
                           )
IS

  V_LOCAL_DATE            DATE := GET_LOCAL_DATE(P_SOB_ID);  

  V_PERIOD_NAME           VARCHAR2(50);
  V_ADJUST_SUPPLIER_ID    NUMBER;
  V_SYSTEM_CURRENCY_CODE  VARCHAR2(50);
  
  -- 외주단가 변수 -------------------
  V_PRICE_CLASS           VARCHAR2(50);
  V_PRICE_TYPE_LCODE      VARCHAR2(50);
  V_PRICE_TYPE_DESC       VARCHAR2(200);
  V_OUT_PRICE             NUMBER := 0;
  V_OUT_PRICE_ID          NUMBER;
  V_OUT_AMOUNT            NUMBER := 0;
  V_LOW_LIMIT_AMOUNT      NUMBER := 0;   
  V_HIGH_LIMIT_AMOUNT     NUMBER := 0;
  V_LOW_LIMIT_PRICE_UOM   VARCHAR2(50);
  V_LOW_LIMIT_PRICE       NUMBER := 0;
  V_SETTING_FEE_AMOUNT    NUMBER := 0;
  V_SETTING_LIMIT_HOUR    NUMBER;
  
  V_BASIC_PRICE            NUMBER := 0;
  V_BASIC_AMOUNT           NUMBER := 0;
  --V_TRX_OUT_AMOUT          NUMBER;
  V_PRICE_APPLY_TYPE_LCODE VARCHAR2(50);
  V_PRICE_APPLY_TYPE_DESC  VARCHAR2(200);
  
  V_EXCEPT_CNT             NUMBER := 0;
  
  -- 하한단가 산정용 변수 -------------
  V_MM_PRICE               NUMBER := 0;
  V_PNL_PRICE              NUMBER := 0;
  V_ARRAY_PRICE            NUMBER := 0;
  V_PCS_PRICE              NUMBER := 0;

  -- SPEC기준 -------------------------
  V_DESIGN_SPEC_CNT       NUMBER := 0;
  V_WIP_SPEC_CNT          NUMBER := 0;
  
  -- SPEC SUMMARY 변수 ----------------
  V_SUM_CAL_CURRENCY_CODE     VARCHAR2(50);
  V_SUM_CAL_PRICE             NUMBER;
  V_SUM_CAL_AMOUNT            NUMBER;
  V_SUM_ADJUST_CURRENCY_CODE  VARCHAR2(50);
  V_SUM_ADJUST_EXCHANGE_RATE  NUMBER;
  V_SUM_ADJUST_PRICE          NUMBER;
  V_SUM_ADJUST_AMOUNT         NUMBER;    
  
  -- 연속공정 미지급 변수 ---------------
  V_CNT                       NUMBER := 0;
  V_APPLY_FLAG                VARCHAR2(1);
  
  V_RESULT_FLAG               VARCHAR2(50);     
  
  
BEGIN
       X_RESULT_STATUS := 'F';
       
       -- 시스템 기준 통화 SELECT --
       V_SYSTEM_CURRENCY_CODE := FI_ACCOUNT_BOOK_G.BASE_CURRENCY_F(P_SOB_ID);
       
       -- TRX 기준의 외주금액 산정 --       
       FOR TRX IN (SELECT *
                     FROM WIP_OUT_ADJUST_TRX  OAT
                    WHERE OAT.ADJUST_TRX_ID   = P_ADJUST_TRX_ID
                      AND OAT.CONFIRM_FLAG    = 'N')
       LOOP
                     
               -- 외주 단가 SELECT --
               BEGIN
                   GET_OUT_PRICE ( P_SOB_ID               => P_SOB_ID
                                 , P_ORG_ID               => P_ORG_ID
                                 , P_OP_WORK_ID           => P_OP_WORK_ID
                                 , P_OP_SPEC_ID           => P_OP_SPEC_ID
                                 , P_SUPPLIER_ID          => TRX.SUPPLIER_ID
                                 , P_WORKCENTER_ID        => TRX.WORKCENTER_ID
                                 , P_OPERATION_ID         => TRX.OPERATION_ID
                                 , P_BOM_ITEM_ID          => TRX.BOM_ITEM_ID
                                 , P_TRX_DATE             => TRX.TOMOVE_TRX_DATE
                                 , P_QTY_VALUE            => CASE WHEN P_OP_SPEC_UOM_CODE = '㎡'             THEN TRX.ADJUST_MM_QTY
                                                                  WHEN P_OP_SPEC_UOM_CODE IN ('ARRAY','KIT') THEN TRX.ADJUST_ARRAY_QTY
                                                                  WHEN P_OP_SPEC_UOM_CODE = 'PCS'            THEN TRX.ADJUST_PCS_QTY
                                                                  ELSE TRX.ADJUST_PNL_QTY
                                                             END
                                 , X_PRICE_CLASS          => V_PRICE_CLASS
                                 , X_PRICE_TYPE_LCODE     => V_PRICE_TYPE_LCODE
                                 , X_OUT_PRICE            => V_OUT_PRICE
                                 , X_OUT_PRICE_ID         => V_OUT_PRICE_ID
                                 , X_LOW_LIMIT_AMOUNT     => V_LOW_LIMIT_AMOUNT   
                                 , X_HIGH_LIMIT_AMOUNT    => V_HIGH_LIMIT_AMOUNT
                                 , X_LOW_LIMIT_PRICE_UOM  => V_LOW_LIMIT_PRICE_UOM
                                 , X_LOW_LIMIT_PRICE      => V_LOW_LIMIT_PRICE
                                 , X_SETTING_FEE_AMOUNT   => V_SETTING_FEE_AMOUNT
                                 , X_SETTING_LIMIT_HOUR   => V_SETTING_LIMIT_HOUR
                                 );
               EXCEPTION WHEN OTHERS THEN
                    X_RESULT_MSG := 'Out Price List Select Error : ' || SQLERRM;
                    RETURN;
               END;                     
                       
               V_BASIC_PRICE   := V_OUT_PRICE;
               V_PRICE_APPLY_TYPE_LCODE := 'BASIC';
                       
               -------------------
               -- 하한단가 적용 --
               -------------------
               IF NVL(V_LOW_LIMIT_PRICE,0) > 0 THEN
                   IF    P_OP_SPEC_UOM_CODE = '㎡' THEN
                                
                           V_MM_PRICE    := V_BASIC_PRICE;
                                   
                           IF NVL(TRX.PCS_PER_MM_QTY,0) != 0 THEN
                                V_PNL_PRICE   := TRUNC(V_BASIC_PRICE / TRX.PCS_PER_MM_QTY * TRX.PCS_PER_PNL_QTY,3);
                                V_ARRAY_PRICE := TRUNC(V_BASIC_PRICE / TRX.PCS_PER_MM_QTY * TRX.PCS_PER_ARRAY_QTY,3);
                                V_PCS_PRICE   := TRUNC(V_BASIC_PRICE / TRX.PCS_PER_MM_QTY,3); 
                           ELSE
                                V_PNL_PRICE   := 0;
                                V_ARRAY_PRICE := 0;
                                V_PCS_PRICE   := 0;
                           END IF;
                                   
                   ELSIF P_OP_SPEC_UOM_CODE IN ('PNL','HOLE','STROCK') THEN
                           
                           V_PNL_PRICE := V_BASIC_PRICE;
                                   
                           IF NVL(TRX.PCS_PER_PNL_QTY,0) != 0 THEN
                                V_MM_PRICE    := TRUNC(V_BASIC_PRICE / TRX.PCS_PER_PNL_QTY * TRX.PCS_PER_MM_QTY,3);
                                V_ARRAY_PRICE := TRUNC(V_BASIC_PRICE / TRX.PCS_PER_PNL_QTY * TRX.PCS_PER_ARRAY_QTY,3);
                                V_PCS_PRICE   := TRUNC(V_BASIC_PRICE / TRX.PCS_PER_PNL_QTY,3); 
                           ELSE
                                V_MM_PRICE    := 0;
                                V_ARRAY_PRICE := 0;
                                V_PCS_PRICE   := 0;
                           END IF;
                                   
                   ELSIF P_OP_SPEC_UOM_CODE IN ('ARRAY','KIT') THEN
                                   
                           V_ARRAY_PRICE := V_BASIC_PRICE;
                                   
                           IF NVL(TRX.PCS_PER_ARRAY_QTY,0) != 0 THEN
                                V_MM_PRICE    := TRUNC(V_BASIC_PRICE / TRX.PCS_PER_ARRAY_QTY * TRX.PCS_PER_MM_QTY,3);
                                V_PNL_PRICE   := TRUNC(V_BASIC_PRICE / TRX.PCS_PER_ARRAY_QTY * TRX.PCS_PER_PNL_QTY,3);
                                V_PCS_PRICE   := TRUNC(V_BASIC_PRICE / TRX.PCS_PER_ARRAY_QTY,3); 
                           ELSE
                                V_MM_PRICE    := 0;
                                V_PNL_PRICE   := 0;
                                V_PCS_PRICE   := 0;
                           END IF;
                                   
                   ELSIF P_OP_SPEC_UOM_CODE = 'PCS' THEN
                                 
                           V_PCS_PRICE   := V_BASIC_PRICE;
                           V_MM_PRICE    := TRUNC(V_BASIC_PRICE * TRX.PCS_PER_MM_QTY,3);
                           V_ARRAY_PRICE := TRUNC(V_BASIC_PRICE * TRX.PCS_PER_ARRAY_QTY,3);
                           V_PNL_PRICE   := TRUNC(V_BASIC_PRICE * TRX.PCS_PER_PNL_QTY,3); 
                                   
                   ELSE  
                           V_PNL_PRICE := V_BASIC_PRICE;
                                   
                           IF NVL(TRX.PCS_PER_PNL_QTY,0) != 0 THEN
                                V_MM_PRICE    := TRUNC(V_BASIC_PRICE / TRX.PCS_PER_PNL_QTY * TRX.PCS_PER_MM_QTY,3);
                                V_ARRAY_PRICE := TRUNC(V_BASIC_PRICE / TRX.PCS_PER_PNL_QTY * TRX.PCS_PER_ARRAY_QTY,3);
                                V_PCS_PRICE   := TRUNC(V_BASIC_PRICE / TRX.PCS_PER_PNL_QTY,3); 
                           ELSE
                                V_MM_PRICE    := 0;
                                V_ARRAY_PRICE := 0;
                                V_PCS_PRICE   := 0;
                           END IF;
                           
                   END IF;
                           
                   IF    V_LOW_LIMIT_PRICE_UOM = '㎡' AND V_LOW_LIMIT_PRICE > V_MM_PRICE * NVL(P_OP_SPEC_VALUE,0) THEN
                                    
                             V_OUT_PRICE              := V_LOW_LIMIT_PRICE;
                             V_PRICE_APPLY_TYPE_LCODE := 'LOW_LIMIT_PRICE';
                                     
                   ELSIF V_LOW_LIMIT_PRICE_UOM = 'PNL' AND V_LOW_LIMIT_PRICE > V_PNL_PRICE * NVL(P_OP_SPEC_VALUE,0) THEN
                           
                             V_OUT_PRICE              := V_LOW_LIMIT_PRICE;
                             V_PRICE_APPLY_TYPE_LCODE := 'LOW_LIMIT_PRICE';
                                     
                   ELSIF V_LOW_LIMIT_PRICE_UOM = 'ARRAY' AND V_LOW_LIMIT_PRICE > V_ARRAY_PRICE * NVL(P_OP_SPEC_VALUE,0) THEN
                           
                             V_OUT_PRICE              := V_LOW_LIMIT_PRICE;
                             V_PRICE_APPLY_TYPE_LCODE := 'LOW_LIMIT_PRICE';
                                     
                   ELSIF V_LOW_LIMIT_PRICE_UOM = 'PCS' AND V_LOW_LIMIT_PRICE > V_PCS_PRICE * NVL(P_OP_SPEC_VALUE,0) THEN
                           
                             V_OUT_PRICE              := V_LOW_LIMIT_PRICE;
                             V_PRICE_APPLY_TYPE_LCODE := 'LOW_LIMIT_PRICE';
                                     
                   ELSIF V_LOW_LIMIT_PRICE > V_PNL_PRICE * NVL(P_OP_SPEC_VALUE,0) THEN
                                     
                             V_OUT_PRICE              := V_LOW_LIMIT_PRICE;
                             V_PRICE_APPLY_TYPE_LCODE := 'LOW_LIMIT_PRICE';
                   END IF;
               END IF;
                       
               --------------------------
               -- 기본 외주비 계산     --
               --------------------------
               IF    P_OP_SPEC_UOM_CODE = '㎡' THEN
                            
                       V_BASIC_AMOUNT := TRUNC(V_BASIC_PRICE * TRX.ADJUST_MM_QTY * P_OP_SPEC_VALUE);
                               
                       IF V_PRICE_APPLY_TYPE_LCODE = 'LOW_LIMIT_PRICE' THEN  
                           V_OUT_AMOUNT   := TRUNC(V_OUT_PRICE   * TRX.ADJUST_MM_QTY);  -- 하한단가 적용시에는 SPEC값을 곱하지 않음.
                       ELSE
                           V_OUT_AMOUNT   := TRUNC(V_OUT_PRICE   * TRX.ADJUST_MM_QTY * P_OP_SPEC_VALUE);
                       END IF;
                               
               ELSIF P_OP_SPEC_UOM_CODE IN ('PNL','HOLE','STROCK') THEN
                       
                       V_BASIC_AMOUNT := TRUNC(V_BASIC_PRICE * TRX.ADJUST_PNL_QTY * P_OP_SPEC_VALUE);
                               
                       IF V_PRICE_APPLY_TYPE_LCODE = 'LOW_LIMIT_PRICE' THEN
                            V_OUT_AMOUNT   := TRUNC(V_OUT_PRICE   * TRX.ADJUST_PNL_QTY);  -- 하한단가 적용시에는 SPEC값을 곱하지 않음.
                       ELSE
                            V_OUT_AMOUNT   := TRUNC(V_OUT_PRICE   * TRX.ADJUST_PNL_QTY *P_OP_SPEC_VALUE);
                       END IF;
                               
               ELSIF P_OP_SPEC_UOM_CODE IN ('ARRAY','KIT') THEN
                               
                       V_BASIC_AMOUNT := TRUNC(V_BASIC_PRICE * TRX.ADJUST_ARRAY_QTY * P_OP_SPEC_VALUE);
                               
                       IF V_PRICE_APPLY_TYPE_LCODE = 'LOW_LIMIT_PRICE' THEN
                            V_OUT_AMOUNT   := TRUNC(V_OUT_PRICE   * TRX.ADJUST_ARRAY_QTY);   -- 하한단가 적용시에는 SPEC값을 곱하지 않음.
                       ELSE
                            V_OUT_AMOUNT   := TRUNC(V_OUT_PRICE   * TRX.ADJUST_ARRAY_QTY * P_OP_SPEC_VALUE);
                       END IF;
                               
               ELSIF P_OP_SPEC_UOM_CODE = 'PCS' THEN
                             
                       V_BASIC_AMOUNT := TRUNC(V_BASIC_PRICE * TRX.ADJUST_PCS_QTY * P_OP_SPEC_VALUE);
                               
                       IF V_PRICE_APPLY_TYPE_LCODE = 'LOW_LIMIT_PRICE' THEN
                            V_OUT_AMOUNT   := TRUNC(V_OUT_PRICE   * TRX.ADJUST_PCS_QTY);   -- 하한단가 적용시에는 SPEC값을 곱하지 않음.
                       ELSE
                            V_OUT_AMOUNT   := TRUNC(V_OUT_PRICE   * TRX.ADJUST_PCS_QTY * P_OP_SPEC_VALUE);
                       END IF;
                               
               ELSE  
                       V_BASIC_AMOUNT := TRUNC(V_BASIC_PRICE * TRX.ADJUST_PNL_QTY * P_OP_SPEC_VALUE);
                               
                       IF V_PRICE_APPLY_TYPE_LCODE = 'LOW_LIMIT_PRICE' THEN
                            V_OUT_AMOUNT   := TRUNC(V_OUT_PRICE   * TRX.ADJUST_PNL_QTY);   -- 하한단가 적용시에는 SPEC값을 곱하지 않음.
                       ELSE
                            V_OUT_AMOUNT   := TRUNC(V_OUT_PRICE   * TRX.ADJUST_PNL_QTY * P_OP_SPEC_VALUE);
                       END IF;
                               
               END IF;
                       
               --------------------
               -- 하한 금액 적용 --
               --------------------
               IF NVL(V_LOW_LIMIT_AMOUNT,0) != 0 THEN
                   IF V_OUT_AMOUNT < NVL(V_LOW_LIMIT_AMOUNT,0) THEN
                        V_OUT_AMOUNT := V_LOW_LIMIT_AMOUNT;
                        V_PRICE_APPLY_TYPE_LCODE := 'LOW_LIMIT_AMOUNT';
                   END IF;
               END IF;
                       
               --------------------
               -- 상한금액 적용  --
               --------------------
               IF NVL(V_HIGH_LIMIT_AMOUNT,0) != 0 THEN
                   IF NVL(V_HIGH_LIMIT_AMOUNT,0) > 0 AND  V_OUT_AMOUNT > NVL(V_HIGH_LIMIT_AMOUNT,0) THEN
                        V_OUT_AMOUNT := V_HIGH_LIMIT_AMOUNT;
                        V_PRICE_APPLY_TYPE_LCODE := 'HIGH_LIMIT_AMOUNT';
                   END IF;
               END IF;
                     

               ---------------------------------------------------
               -- 외주공정 지급 기준에 따라 미지급 대상은 제외  --
               ---------------------------------------------------
               V_APPLY_FLAG := 'N';
               
               FOR  RULE IN (SELECT AOE.OP_RULE_TYPE_ID
                                  , AOE.OPERATION_ID
                                  , AOE.ADJUST_FLAG
                               FROM WIP_OUT_ADJUST_OP_ENTRY  AOE
                                  , WIP_OUT_ADJUST_OP_TYPE   AOT
                              WHERE AOT.OP_RULE_TYPE_ID      = AOE.OP_RULE_TYPE_ID
                                AND AOT.ENABLED_FLAG         = 'Y'
                                AND AOE.SOB_ID               = TRX.SOB_ID
                                AND AOE.ORG_ID               = TRX.ORG_ID
                                AND AOE.OPERATION_ID         = TRX.OPERATION_ID
                                AND AOE.ADJUST_FLAG          = 'N') 
               LOOP
                          
                    V_APPLY_FLAG := 'Y';
                          
                    FOR OP_CHK IN (SELECT E.OPERATION_ID 
                                     FROM WIP_OUT_ADJUST_OP_ENTRY E
                                    WHERE E.OP_RULE_TYPE_ID       = RULE.OP_RULE_TYPE_ID
                                      AND E.OPERATION_ID         != RULE.OPERATION_ID)
                    LOOP
                          BEGIN
                               SELECT COUNT(*)
                                 INTO V_CNT
                                 FROM WIP_OPERATIONS  WOS
                                WHERE WOS.JOB_ID        = TRX.JOB_ID
                                  AND WOS.OPERATION_ID  = OP_CHK.OPERATION_ID
                                  AND WOS.WORKCENTER_ID = TRX.WORKCENTER_ID
                                  ;
                          EXCEPTION WHEN OTHERS THEN
                              V_CNT := 0;
                          END;
                                
                          IF NVL(V_CNT,0) != 0 AND V_APPLY_FLAG = 'Y' THEN
                                V_APPLY_FLAG := 'Y';
                          ELSE
                                V_APPLY_FLAG := 'N';        
                          END IF;
                             
                    END LOOP;
                    
                    EXIT WHEN V_APPLY_FLAG = 'Y';
                          
                          
               END LOOP;
                          
               IF V_APPLY_FLAG = 'Y' THEN
                   
                   V_PRICE_APPLY_TYPE_LCODE := 'EXCEPT_OPERATION';
                   V_OUT_AMOUNT             := 0;
                   
               END IF;  
               
               BEGIN
                    SELECT ELE.ENTRY_DESCRIPTION
                      INTO V_PRICE_TYPE_DESC
                      FROM EAPP_LOOKUP_ENTRY  ELE
                     WHERE ELE.SOB_ID         = P_SOB_ID
                       AND ELE.ORG_ID         = P_ORG_ID
                       AND ELE.LOOKUP_TYPE    = 'WIP_OUT_PRICE_TYPE'
                       AND ELE.ENTRY_CODE     = V_PRICE_TYPE_LCODE
                       AND ELE.ENABLED_FLAG   = 'Y'
                       AND ROWNUM             = 1
                       ;
               EXCEPTION WHEN OTHERS THEN
                    V_PRICE_TYPE_DESC := NULL;
               END;      

               BEGIN
                    SELECT ELE.ENTRY_DESCRIPTION
                      INTO V_PRICE_APPLY_TYPE_DESC
                      FROM EAPP_LOOKUP_ENTRY  ELE
                     WHERE ELE.SOB_ID         = P_SOB_ID
                       AND ELE.ORG_ID         = P_ORG_ID
                       AND ELE.LOOKUP_TYPE    = 'OUT_PRICE_APPLY_TYPE'
                       AND ELE.ENTRY_CODE     = V_PRICE_APPLY_TYPE_LCODE
                       AND ELE.ENABLED_FLAG   = 'Y'
                       AND ROWNUM             = 1
                       ;
               EXCEPTION WHEN OTHERS THEN
                    V_PRICE_APPLY_TYPE_DESC := NULL;
               END;
               
               
               X_OUT_PRICE_ID             := V_OUT_PRICE_ID;
               X_PRICE_CLASS              := V_PRICE_CLASS;
               X_PRICE_TYPE_LCODE         := V_PRICE_TYPE_LCODE;
               X_PRICE_TYPE_DESC          := V_PRICE_TYPE_DESC;
               X_CURRENCY_CODE            := V_SYSTEM_CURRENCY_CODE;
               X_BASIC_PRICE              := V_BASIC_PRICE;
               X_BASIC_AMOUNT             := V_BASIC_AMOUNT;
               X_OUT_PRICE                := V_OUT_PRICE;
               X_OUT_AMOUNT               := V_OUT_AMOUNT;
               X_LOW_LIMIT_AMOUNT         := V_LOW_LIMIT_AMOUNT;
               X_HIGH_LIMIT_AMOUNT        := V_HIGH_LIMIT_AMOUNT;
               X_LOW_LIMIT_PRICE_UOM      := V_LOW_LIMIT_PRICE_UOM;
               X_LOW_LIMIT_PRICE          := V_LOW_LIMIT_PRICE;
               X_SETTING_FEE_AMOUNT       := V_SETTING_FEE_AMOUNT;
               X_SETTING_LIMIT_HOUR       := V_SETTING_LIMIT_HOUR;
               X_PRICE_APPLY_TYPE_LCODE   := V_PRICE_APPLY_TYPE_LCODE;
               X_PRICE_APPLY_TYPE_DESC    := V_PRICE_APPLY_TYPE_DESC;
                                                  
       END LOOP;  -- TRX --      

       X_RESULT_STATUS := 'S';
       
EXCEPTION WHEN OTHERS THEN
    X_RESULT_STATUS := 'F';  
    X_RESULT_MSG    := SQLERRM;        
END GET_SPEC_AMOUNT;


------------------------
-- OUT_PRICE_SELECT   --
------------------------
PROCEDURE GET_OUT_PRICE  ( P_SOB_ID              IN  NUMBER
                         , P_ORG_ID              IN  NUMBER
                         , P_OP_WORK_ID          IN  NUMBER
                         , P_OP_SPEC_ID          IN  NUMBER
                         , P_SUPPLIER_ID         IN  NUMBER
                         , P_WORKCENTER_ID       IN  NUMBER
                         , P_OPERATION_ID        IN  NUMBER
                         , P_BOM_ITEM_ID         IN  NUMBER
                         , P_TRX_DATE            IN  DATE
                         , P_QTY_VALUE           IN  NUMBER
                         , X_PRICE_CLASS         OUT VARCHAR2
                         , X_PRICE_TYPE_LCODE    OUT VARCHAR2
                         , X_OUT_PRICE           OUT NUMBER
                         , X_OUT_PRICE_ID        OUT NUMBER
                         , X_LOW_LIMIT_AMOUNT    OUT NUMBER   
                         , X_HIGH_LIMIT_AMOUNT   OUT NUMBER
                         , X_LOW_LIMIT_PRICE_UOM OUT VARCHAR2
                         , X_LOW_LIMIT_PRICE     OUT NUMBER
                         , X_SETTING_FEE_AMOUNT  OUT NUMBER
                         , X_SETTING_LIMIT_HOUR  OUT NUMBER
                         )
IS
    V_PRICE_TYPE_1    VARCHAR2(50);
    V_PRICE_TYPE_2    VARCHAR2(50);
    V_PRICE_TYPE_3    VARCHAR2(50);
    V_PRICE_TYPE_4    VARCHAR2(50);
    V_QTY_LIMIT_FLAG  VARCHAR2(1);
    V_MODEL_PRICE_FLAG VARCHAR2(1) := 'N';
    V_ITEM_NET_CODE    VARCHAR2(50);
BEGIN
           -- 수량별 단가적용여부 체크 --
           BEGIN
                 SELECT L.QTY_LIMIT_UOM_FLAG
                   INTO V_QTY_LIMIT_FLAG
                   FROM WIP_OUT_PRICE_LIST L
                  WHERE L.OP_WORK_ID          = P_OP_WORK_ID
                    AND L.OP_SPEC_ID          = P_OP_SPEC_ID
                    AND L.QTY_LIMIT_UOM_FLAG  = 'Y'           
                    AND ROWNUM                = 1
                  ;
           EXCEPTION WHEN OTHERS THEN
                V_QTY_LIMIT_FLAG := 'N';
           END;
           
           IF V_QTY_LIMIT_FLAG != 'Y' THEN
                V_QTY_LIMIT_FLAG := 'N';
           END IF;
           
           ---------------------------------------------------------------
           -- 모델단가를 적용했던 제품은 반드시 모델단가를 사용해야함.  --
           -- 순제품 기준으로 적용, 라해성주임 요청사항                 --
           -- 2011-10-17, BY MJSHIN                                     --
           ---------------------------------------------------------------
           BEGIN
                SELECT IIM.ITEM_NET_CODE
                  INTO V_ITEM_NET_CODE 
                  FROM SDM_ITEM_REVISION  SIR
                     , INV_ITEM_MASTER    IIM
                 WHERE IIM.INVENTORY_ITEM_ID  = SIR.INVENTORY_ITEM_ID
                   AND SIR.BOM_ITEM_ID        = P_BOM_ITEM_ID
                 ;
           EXCEPTION WHEN OTHERS THEN
                V_ITEM_NET_CODE := NULL;
           END;
           
           BEGIN
                SELECT 'Y'
                  INTO V_MODEL_PRICE_FLAG
                  FROM WIP_OUT_PRICE_LIST  WPL
                     , SDM_ITEM_REVISION   SIR
                     , INV_ITEM_MASTER     IIM
                 WHERE WPL.PRICE_CLASS        = 'NORMAL'
                   AND WPL.PRICE_TYPE_LCODE   = 'MODEL'
                   AND WPL.OP_WORK_ID         = P_OP_WORK_ID
                   AND WPL.OP_SPEC_ID         = P_OP_SPEC_ID
                   AND SIR.BOM_ITEM_ID        = WPL.BOM_ITEM_ID
                   AND IIM.INVENTORY_ITEM_ID  = SIR.INVENTORY_ITEM_ID
                   AND IIM.ITEM_NET_CODE      = V_ITEM_NET_CODE
                   AND ROWNUM                 = 1
                   ;
           EXCEPTION WHEN OTHERS THEN
               V_MODEL_PRICE_FLAG := 'N';
           END;
           
           
           -------------------------------------------------
           -- 외주단가기준 SELECT                         --
           -------------------------------------------------
           -- 1. 외주처 + 공정기준 + 모델기준 --
           BEGIN
                SELECT R.PRICE_TYPE_CODE_1
                     , R.PRICE_TYPE_CODE_2
                     , R.PRICE_TYPE_CODE_3
                     , R.PRICE_TYPE_CODE_4
                  INTO V_PRICE_TYPE_1
                     , V_PRICE_TYPE_2
                     , V_PRICE_TYPE_3
                     , V_PRICE_TYPE_4
                  FROM WIP_OUT_ADJUST_PRICE_RULE R
                 WHERE R.SUPPLIER_ID        = P_SUPPLIER_ID
                   AND R.WORKCENTER_ID      = P_WORKCENTER_ID
                   AND R.OPERATION_ID       = P_OPERATION_ID
                   AND R.BOM_ITEM_ID        = P_BOM_ITEM_ID
                   AND P_TRX_DATE           BETWEEN R.EFFECTIVE_DATE_FR + (1/24*8.5)
                                                AND NVL(R.EFFECTIVE_DATE_TO + (1 + (1/24*8.5)), P_TRX_DATE) 
                   AND R.ENABLED_FLAG       = 'Y'
                 ;
           EXCEPTION WHEN OTHERS THEN
                 V_PRICE_TYPE_1 := NULL;
                 V_PRICE_TYPE_2 := NULL;
                 V_PRICE_TYPE_3 := NULL;
                 V_PRICE_TYPE_4 := NULL;
           END;
                      
           -- 2. 모델단가 적용기준 --
           IF V_PRICE_TYPE_1 IS NULL THEN

               ---------------------------------------------------------------
               -- 모델단가를 적용했던 제품은 반드시 모델단가를 사용해야함.  --
               -- 순제품 기준으로 적용, 라해성주임 요청사항                 --
               -- 2011-10-17, BY MJSHIN                                     --
               ---------------------------------------------------------------
               BEGIN
                    SELECT IIM.ITEM_NET_CODE
                      INTO V_ITEM_NET_CODE 
                      FROM SDM_ITEM_REVISION  SIR
                         , INV_ITEM_MASTER    IIM
                     WHERE IIM.INVENTORY_ITEM_ID  = SIR.INVENTORY_ITEM_ID
                       AND SIR.BOM_ITEM_ID        = P_BOM_ITEM_ID
                     ;
               EXCEPTION WHEN OTHERS THEN
                    V_ITEM_NET_CODE := NULL;
               END;
               
               BEGIN
                    SELECT 'Y'
                      INTO V_MODEL_PRICE_FLAG
                      FROM WIP_OUT_PRICE_LIST  WPL
                         , SDM_ITEM_REVISION   SIR
                         , INV_ITEM_MASTER     IIM
                     WHERE WPL.PRICE_CLASS        = 'NORMAL'
                       AND WPL.PRICE_TYPE_LCODE   = 'MODEL'
                       AND WPL.OP_WORK_ID         = P_OP_WORK_ID
                       AND WPL.OP_SPEC_ID         = P_OP_SPEC_ID
                       AND SIR.BOM_ITEM_ID        = WPL.BOM_ITEM_ID
                       AND IIM.INVENTORY_ITEM_ID  = SIR.INVENTORY_ITEM_ID
                       AND IIM.ITEM_NET_CODE      = V_ITEM_NET_CODE
                       AND WPL.ENABLED_FLAG       = 'Y'
                       AND ROWNUM                 = 1
                       ;
               EXCEPTION WHEN OTHERS THEN
                   V_MODEL_PRICE_FLAG := 'N';
               END;
                        
               IF V_MODEL_PRICE_FLAG = 'Y' THEN
                    V_PRICE_TYPE_1 := 'MODEL';
               ELSE
                    V_PRICE_TYPE_1 := NULL;
               END IF;

           END IF;
     
           -- 3. 외주처 + 공정기준 --
           IF V_PRICE_TYPE_1 IS NULL THEN
               BEGIN
                    SELECT R.PRICE_TYPE_CODE_1
                         , R.PRICE_TYPE_CODE_2
                         , R.PRICE_TYPE_CODE_3
                         , R.PRICE_TYPE_CODE_4
                      INTO V_PRICE_TYPE_1
                         , V_PRICE_TYPE_2
                         , V_PRICE_TYPE_3
                         , V_PRICE_TYPE_4
                      FROM WIP_OUT_ADJUST_PRICE_RULE R
                     WHERE R.SUPPLIER_ID        = P_SUPPLIER_ID
                       AND R.WORKCENTER_ID      = P_WORKCENTER_ID
                       AND R.OPERATION_ID       = P_OPERATION_ID
                       AND P_TRX_DATE           BETWEEN R.EFFECTIVE_DATE_FR + (1/24*8.5)
                                                    AND NVL(R.EFFECTIVE_DATE_TO + (1 + (1/24*8.5)), P_TRX_DATE) 
                       AND R.ENABLED_FLAG       = 'Y'
                     ;
               EXCEPTION WHEN OTHERS THEN
                     V_PRICE_TYPE_1 := NULL;
                     V_PRICE_TYPE_2 := NULL;
                     V_PRICE_TYPE_3 := NULL;
                     V_PRICE_TYPE_4 := NULL;
               END;
           END IF;
                      
           -- 4. 모델 + 공정기준 --
           IF V_PRICE_TYPE_1 IS NULL THEN
               
               BEGIN
                    SELECT R.PRICE_TYPE_CODE_1
                         , R.PRICE_TYPE_CODE_2
                         , R.PRICE_TYPE_CODE_3
                         , R.PRICE_TYPE_CODE_4
                      INTO V_PRICE_TYPE_1
                         , V_PRICE_TYPE_2
                         , V_PRICE_TYPE_3
                         , V_PRICE_TYPE_4
                      FROM WIP_OUT_ADJUST_PRICE_RULE R
                     WHERE R.OPERATION_ID       = P_OPERATION_ID
                       AND R.BOM_ITEM_ID        = P_BOM_ITEM_ID
                       AND P_TRX_DATE           BETWEEN R.EFFECTIVE_DATE_FR + (1/24*8.5)
                                                    AND NVL(R.EFFECTIVE_DATE_TO + (1 + (1/24*8.5)), P_TRX_DATE) 
                       AND R.ENABLED_FLAG       = 'Y'
                     ;
               EXCEPTION WHEN OTHERS THEN
                     V_PRICE_TYPE_1 := NULL;
                     V_PRICE_TYPE_2 := NULL;
                     V_PRICE_TYPE_3 := NULL;
                     V_PRICE_TYPE_4 := NULL;
               END;             
           END IF;
           
           IF V_PRICE_TYPE_1 IS NOT NULL THEN
           
               -------------------------------------------------
               -- 외주 단가 SELECT (단가 우선순위 지정)       --
               -------------------------------------------------
               
               -- 1. PRICE_TYPE_1 --
               BEGIN
                    SELECT OPL.PRICE_CLASS
                         , OPL.PRICE_TYPE_LCODE
                         , OPL.OUT_PRICE
                         , OPL.OUT_PRICE_ID
                         , OPL.LOW_LIMIT_AMOUNT
                         , OPL.HIGH_LIMIT_AMOUNT
                         , OPL.LOW_LIMIT_PRICE_UOM
                         , OPL.LOW_LIMIT_PRICE
                         , OPL.SETTING_FEE_AMOUNT
                         , OPL.SETTING_LIMIT_HOUR
                      INTO X_PRICE_CLASS
                         , X_PRICE_TYPE_LCODE
                         , X_OUT_PRICE
                         , X_OUT_PRICE_ID
                         , X_LOW_LIMIT_AMOUNT
                         , X_HIGH_LIMIT_AMOUNT
                         , X_LOW_LIMIT_PRICE_UOM
                         , X_LOW_LIMIT_PRICE
                         , X_SETTING_FEE_AMOUNT
                         , X_SETTING_LIMIT_HOUR
                      FROM WIP_OUT_PRICE_LIST   OPL
                     WHERE OPL.SOB_ID           = P_SOB_ID
                       AND OPL.ORG_ID           = P_ORG_ID
                       AND OPL.OP_WORK_ID       = P_OP_WORK_ID
                       AND OPL.OP_SPEC_ID       = P_OP_SPEC_ID
                       AND OPL.PRICE_TYPE_LCODE = V_PRICE_TYPE_1
                       AND (  (V_PRICE_TYPE_1 NOT IN ('COMPLEX','VENDOR') AND 1 = 1)
                           OR (V_PRICE_TYPE_1     IN ('COMPLEX','VENDOR') AND OPL.SUPPLIER_ID = P_SUPPLIER_ID))
                       AND (  (V_PRICE_TYPE_1 NOT IN ('COMPLEX','MODEL')  AND 1 = 1)
                           OR (V_PRICE_TYPE_1     IN ('COMPLEX','MODEL')  AND OPL.BOM_ITEM_ID = P_BOM_ITEM_ID))
                       AND P_TRX_DATE           BETWEEN OPL.EFFECTIVE_DATE_FR + (1/24*8.5)
                                                    AND NVL(OPL.EFFECTIVE_DATE_TO + (1 + (1/24*8.5)), P_TRX_DATE)
                       AND OPL.ENABLED_FLAG     = 'Y'
                       AND (  (NVL(V_QTY_LIMIT_FLAG,'N') = 'N' AND 1 = 1)  -- 수량범위별 단가적용, 2011-10-15, BY MJSHIN --
                           OR (NVL(V_QTY_LIMIT_FLAG,'N') = 'Y' AND OPL.QTY_LIMIT_UOM_FLAG = 'Y'
                                                               AND NVL(OPL.QTY_LIMIT_RANGE_FR,0) <= P_QTY_VALUE
                                                               AND NVL(OPL.QTY_LIMIT_RANGE_TO,9999999999999) >= P_QTY_VALUE)
                           )
                       ;
               EXCEPTION WHEN OTHERS THEN
                    X_PRICE_CLASS         := NULL;
                    X_PRICE_TYPE_LCODE    := NULL;
                    X_OUT_PRICE           := NULL;
                    X_OUT_PRICE_ID        := NULL;
                    X_LOW_LIMIT_AMOUNT    := NULL;
                    X_HIGH_LIMIT_AMOUNT   := NULL;
                    X_LOW_LIMIT_PRICE_UOM := NULL;
                    X_LOW_LIMIT_PRICE     := NULL;
                    X_SETTING_FEE_AMOUNT  := NULL;
                    X_SETTING_LIMIT_HOUR  := NULL;
               END;
                     
               -- 2. PRICE_TYPE_2 --
               IF X_OUT_PRICE IS NULL THEN
                         
                   BEGIN
                        SELECT OPL.PRICE_CLASS
                         , OPL.PRICE_TYPE_LCODE
                         , OPL.OUT_PRICE
                         , OPL.OUT_PRICE_ID
                         , OPL.LOW_LIMIT_AMOUNT
                         , OPL.HIGH_LIMIT_AMOUNT
                         , OPL.LOW_LIMIT_PRICE_UOM
                         , OPL.LOW_LIMIT_PRICE
                         , OPL.SETTING_FEE_AMOUNT
                         , OPL.SETTING_LIMIT_HOUR
                      INTO X_PRICE_CLASS
                         , X_PRICE_TYPE_LCODE
                         , X_OUT_PRICE
                         , X_OUT_PRICE_ID
                         , X_LOW_LIMIT_AMOUNT
                         , X_HIGH_LIMIT_AMOUNT
                         , X_LOW_LIMIT_PRICE_UOM
                         , X_LOW_LIMIT_PRICE
                         , X_SETTING_FEE_AMOUNT
                         , X_SETTING_LIMIT_HOUR
                      FROM WIP_OUT_PRICE_LIST   OPL
                     WHERE OPL.SOB_ID           = P_SOB_ID
                       AND OPL.ORG_ID           = P_ORG_ID
                       AND OPL.OP_WORK_ID       = P_OP_WORK_ID
                       AND OPL.OP_SPEC_ID       = P_OP_SPEC_ID
                       AND OPL.PRICE_TYPE_LCODE = V_PRICE_TYPE_2
                       AND (  (V_PRICE_TYPE_2 NOT IN ('COMPLEX','VENDOR') AND 1 = 1)
                           OR (V_PRICE_TYPE_2     IN ('COMPLEX','VENDOR') AND OPL.SUPPLIER_ID = P_SUPPLIER_ID))
                       AND (  (V_PRICE_TYPE_2 NOT IN ('COMPLEX','MODEL')  AND 1 = 1)
                           OR (V_PRICE_TYPE_2     IN ('COMPLEX','MODEL')  AND OPL.BOM_ITEM_ID = P_BOM_ITEM_ID))
                       AND P_TRX_DATE           BETWEEN OPL.EFFECTIVE_DATE_FR + (1/24*8.5)
                                                    AND NVL(OPL.EFFECTIVE_DATE_TO + (1 + (1/24*8.5)), P_TRX_DATE)
                       AND OPL.ENABLED_FLAG     = 'Y'
                       AND (  (NVL(V_QTY_LIMIT_FLAG,'N') = 'N' AND 1 = 1)  -- 수량범위별 단가적용, 2011-10-15, BY MJSHIN --
                           OR (NVL(V_QTY_LIMIT_FLAG,'N') = 'Y' AND OPL.QTY_LIMIT_UOM_FLAG = 'Y'
                                                               AND NVL(OPL.QTY_LIMIT_RANGE_FR,0) <= P_QTY_VALUE
                                                               AND NVL(OPL.QTY_LIMIT_RANGE_TO,9999999999999) >= P_QTY_VALUE)
                           )
                       ;
                   EXCEPTION WHEN OTHERS THEN
                        X_PRICE_CLASS         := NULL;
                        X_PRICE_TYPE_LCODE    := NULL;
                        X_OUT_PRICE           := NULL;
                        X_OUT_PRICE_ID        := NULL;
                        X_LOW_LIMIT_AMOUNT    := NULL;
                        X_HIGH_LIMIT_AMOUNT   := NULL;
                        X_LOW_LIMIT_PRICE_UOM := NULL;
                        X_LOW_LIMIT_PRICE     := NULL;
                        X_SETTING_FEE_AMOUNT  := NULL;
                        X_SETTING_LIMIT_HOUR  := NULL;
                   END;                   
               END IF;

               -- 3. PRICE_TYPE_3 --
               IF X_OUT_PRICE IS NULL THEN
                         
                   BEGIN
                        SELECT OPL.PRICE_CLASS
                         , OPL.PRICE_TYPE_LCODE
                         , OPL.OUT_PRICE
                         , OPL.OUT_PRICE_ID
                         , OPL.LOW_LIMIT_AMOUNT
                         , OPL.HIGH_LIMIT_AMOUNT
                         , OPL.LOW_LIMIT_PRICE_UOM
                         , OPL.LOW_LIMIT_PRICE
                         , OPL.SETTING_FEE_AMOUNT
                         , OPL.SETTING_LIMIT_HOUR
                      INTO X_PRICE_CLASS
                         , X_PRICE_TYPE_LCODE
                         , X_OUT_PRICE
                         , X_OUT_PRICE_ID
                         , X_LOW_LIMIT_AMOUNT
                         , X_HIGH_LIMIT_AMOUNT
                         , X_LOW_LIMIT_PRICE_UOM
                         , X_LOW_LIMIT_PRICE
                         , X_SETTING_FEE_AMOUNT
                         , X_SETTING_LIMIT_HOUR
                      FROM WIP_OUT_PRICE_LIST   OPL
                     WHERE OPL.SOB_ID           = P_SOB_ID
                       AND OPL.ORG_ID           = P_ORG_ID
                       AND OPL.OP_WORK_ID       = P_OP_WORK_ID
                       AND OPL.OP_SPEC_ID       = P_OP_SPEC_ID
                       AND OPL.PRICE_TYPE_LCODE = V_PRICE_TYPE_3
                       AND (  (V_PRICE_TYPE_3 NOT IN ('COMPLEX','VENDOR') AND 1 = 1)
                           OR (V_PRICE_TYPE_3     IN ('COMPLEX','VENDOR') AND OPL.SUPPLIER_ID = P_SUPPLIER_ID))
                       AND (  (V_PRICE_TYPE_3 NOT IN ('COMPLEX','MODEL')  AND 1 = 1)
                           OR (V_PRICE_TYPE_3     IN ('COMPLEX','MODEL')  AND OPL.BOM_ITEM_ID = P_BOM_ITEM_ID))
                       AND P_TRX_DATE           BETWEEN OPL.EFFECTIVE_DATE_FR + (1/24*8.5)
                                                    AND NVL(OPL.EFFECTIVE_DATE_TO + (1 + (1/24*8.5)), P_TRX_DATE)
                       AND OPL.ENABLED_FLAG     = 'Y'
                       AND (  (NVL(V_QTY_LIMIT_FLAG,'N') = 'N' AND 1 = 1)  -- 수량범위별 단가적용, 2011-10-15, BY MJSHIN --
                           OR (NVL(V_QTY_LIMIT_FLAG,'N') = 'Y' AND OPL.QTY_LIMIT_UOM_FLAG = 'Y'
                                                               AND NVL(OPL.QTY_LIMIT_RANGE_FR,0) <= P_QTY_VALUE
                                                               AND NVL(OPL.QTY_LIMIT_RANGE_TO,9999999999999) >= P_QTY_VALUE)
                           )
                       ;
                   EXCEPTION WHEN OTHERS THEN
                        X_PRICE_CLASS         := NULL;
                        X_PRICE_TYPE_LCODE    := NULL;
                        X_OUT_PRICE           := NULL;
                        X_OUT_PRICE_ID        := NULL;
                        X_LOW_LIMIT_AMOUNT    := NULL;
                        X_HIGH_LIMIT_AMOUNT   := NULL;
                        X_LOW_LIMIT_PRICE_UOM := NULL;
                        X_LOW_LIMIT_PRICE     := NULL;
                        X_SETTING_FEE_AMOUNT  := NULL;
                        X_SETTING_LIMIT_HOUR  := NULL;
                   END;                   
               END IF;

               -- 4. PRICE_TYPE_4 --
               IF X_OUT_PRICE IS NULL THEN
                         
                   BEGIN
                        SELECT OPL.PRICE_CLASS
                         , OPL.PRICE_TYPE_LCODE
                         , OPL.OUT_PRICE
                         , OPL.OUT_PRICE_ID
                         , OPL.LOW_LIMIT_AMOUNT
                         , OPL.HIGH_LIMIT_AMOUNT
                         , OPL.LOW_LIMIT_PRICE_UOM
                         , OPL.LOW_LIMIT_PRICE
                         , OPL.SETTING_FEE_AMOUNT
                         , OPL.SETTING_LIMIT_HOUR
                      INTO X_PRICE_CLASS
                         , X_PRICE_TYPE_LCODE
                         , X_OUT_PRICE
                         , X_OUT_PRICE_ID
                         , X_LOW_LIMIT_AMOUNT
                         , X_HIGH_LIMIT_AMOUNT
                         , X_LOW_LIMIT_PRICE_UOM
                         , X_LOW_LIMIT_PRICE
                         , X_SETTING_FEE_AMOUNT
                         , X_SETTING_LIMIT_HOUR
                      FROM WIP_OUT_PRICE_LIST   OPL
                     WHERE OPL.SOB_ID           = P_SOB_ID
                       AND OPL.ORG_ID           = P_ORG_ID
                       AND OPL.OP_WORK_ID       = P_OP_WORK_ID
                       AND OPL.OP_SPEC_ID       = P_OP_SPEC_ID
                       AND OPL.PRICE_TYPE_LCODE = V_PRICE_TYPE_4
                       AND (  (V_PRICE_TYPE_4 NOT IN ('COMPLEX','VENDOR') AND 1 = 1)
                           OR (V_PRICE_TYPE_4     IN ('COMPLEX','VENDOR') AND OPL.SUPPLIER_ID = P_SUPPLIER_ID))
                       AND (  (V_PRICE_TYPE_4 NOT IN ('COMPLEX','MODEL')  AND 1 = 1)
                           OR (V_PRICE_TYPE_4     IN ('COMPLEX','MODEL')  AND OPL.BOM_ITEM_ID = P_BOM_ITEM_ID))
                       AND P_TRX_DATE           BETWEEN OPL.EFFECTIVE_DATE_FR + (1/24*8.5)
                                                    AND NVL(OPL.EFFECTIVE_DATE_TO + (1 + (1/24*8.5)), P_TRX_DATE)
                       AND OPL.ENABLED_FLAG     = 'Y'
                       AND (  (NVL(V_QTY_LIMIT_FLAG,'N') = 'N' AND 1 = 1)  -- 수량범위별 단가적용, 2011-10-15, BY MJSHIN --
                           OR (NVL(V_QTY_LIMIT_FLAG,'N') = 'Y' AND OPL.QTY_LIMIT_UOM_FLAG = 'Y'
                                                               AND NVL(OPL.QTY_LIMIT_RANGE_FR,0) <= P_QTY_VALUE
                                                               AND NVL(OPL.QTY_LIMIT_RANGE_TO,9999999999999) >= P_QTY_VALUE)
                           )
                       ;
                   EXCEPTION WHEN OTHERS THEN
                        X_PRICE_CLASS         := NULL;
                        X_PRICE_TYPE_LCODE    := NULL;
                        X_OUT_PRICE           := NULL;
                        X_OUT_PRICE_ID        := NULL;
                        X_LOW_LIMIT_AMOUNT    := NULL;
                        X_HIGH_LIMIT_AMOUNT   := NULL;
                        X_LOW_LIMIT_PRICE_UOM := NULL;
                        X_LOW_LIMIT_PRICE     := NULL;
                        X_SETTING_FEE_AMOUNT  := NULL;
                        X_SETTING_LIMIT_HOUR  := NULL;
                   END;                   
               END IF;

           ELSE  -- IF V_PRICE_TYPE_1 IS NOT NULL THEN --
             
               -------------------------------------------------
               -- 외주 단가 SELECT (우선순위별)               --
               -- 1.COMPLEX > 2.VENDOR > 3.MODEL > 4.STANDARD --
               -------------------------------------------------
               
               -- 1. COMPLEX 단가 (MODEL + VENDOR) --
               BEGIN
                    SELECT OPL.PRICE_CLASS
                         , OPL.PRICE_TYPE_LCODE
                         , OPL.OUT_PRICE
                         , OPL.OUT_PRICE_ID
                         , OPL.LOW_LIMIT_AMOUNT
                         , OPL.HIGH_LIMIT_AMOUNT
                         , OPL.LOW_LIMIT_PRICE_UOM
                         , OPL.LOW_LIMIT_PRICE
                         , OPL.SETTING_FEE_AMOUNT
                         , OPL.SETTING_LIMIT_HOUR
                      INTO X_PRICE_CLASS
                         , X_PRICE_TYPE_LCODE
                         , X_OUT_PRICE
                         , X_OUT_PRICE_ID
                         , X_LOW_LIMIT_AMOUNT
                         , X_HIGH_LIMIT_AMOUNT
                         , X_LOW_LIMIT_PRICE_UOM
                         , X_LOW_LIMIT_PRICE
                         , X_SETTING_FEE_AMOUNT
                         , X_SETTING_LIMIT_HOUR
                      FROM WIP_OUT_PRICE_LIST   OPL
                     WHERE OPL.SOB_ID           = P_SOB_ID
                       AND OPL.ORG_ID           = P_ORG_ID
                       AND OPL.OP_WORK_ID       = P_OP_WORK_ID
                       AND OPL.OP_SPEC_ID       = P_OP_SPEC_ID
                       AND OPL.PRICE_TYPE_LCODE = 'COMPLEX'
                       AND OPL.SUPPLIER_ID      = P_SUPPLIER_ID
                       AND OPL.BOM_ITEM_ID      = P_BOM_ITEM_ID
                       AND P_TRX_DATE           BETWEEN OPL.EFFECTIVE_DATE_FR + (1/24*8.5)
                                                    AND NVL(OPL.EFFECTIVE_DATE_TO + (1 + (1/24*8.5)), P_TRX_DATE)
                       AND OPL.ENABLED_FLAG     = 'Y'
                       AND (  (NVL(V_QTY_LIMIT_FLAG,'N') = 'N' AND 1 = 1)  -- 수량범위별 단가적용, 2011-10-15, BY MJSHIN --
                           OR (NVL(V_QTY_LIMIT_FLAG,'N') = 'Y' AND OPL.QTY_LIMIT_UOM_FLAG = 'Y'
                                                               AND NVL(OPL.QTY_LIMIT_RANGE_FR,0) <= P_QTY_VALUE
                                                               AND NVL(OPL.QTY_LIMIT_RANGE_TO,9999999999999) >= P_QTY_VALUE)
                               )
                       ;
               EXCEPTION WHEN OTHERS THEN
                    X_PRICE_CLASS         := NULL;
                    X_PRICE_TYPE_LCODE    := NULL;
                    X_OUT_PRICE           := NULL;
                    X_OUT_PRICE_ID        := NULL;
                    X_LOW_LIMIT_AMOUNT    := NULL;
                    X_HIGH_LIMIT_AMOUNT   := NULL;
                    X_LOW_LIMIT_PRICE_UOM := NULL;
                    X_LOW_LIMIT_PRICE     := NULL;
                    X_SETTING_FEE_AMOUNT  := NULL;
                    X_SETTING_LIMIT_HOUR  := NULL;
               END;
                     
               -- 2. VENDOR기준 단가 --
               IF X_OUT_PRICE IS NULL THEN
                         
                   BEGIN
                        SELECT OPL.PRICE_CLASS
                             , OPL.PRICE_TYPE_LCODE
                             , OPL.OUT_PRICE
                             , OPL.OUT_PRICE_ID
                             , OPL.LOW_LIMIT_AMOUNT
                             , OPL.HIGH_LIMIT_AMOUNT
                             , OPL.LOW_LIMIT_PRICE_UOM
                             , OPL.LOW_LIMIT_PRICE
                             , OPL.SETTING_FEE_AMOUNT
                             , OPL.SETTING_LIMIT_HOUR
                          INTO X_PRICE_CLASS
                             , X_PRICE_TYPE_LCODE
                             , X_OUT_PRICE
                             , X_OUT_PRICE_ID
                             , X_LOW_LIMIT_AMOUNT
                             , X_HIGH_LIMIT_AMOUNT
                             , X_LOW_LIMIT_PRICE_UOM
                             , X_LOW_LIMIT_PRICE
                             , X_SETTING_FEE_AMOUNT
                             , X_SETTING_LIMIT_HOUR
                          FROM WIP_OUT_PRICE_LIST   OPL
                         WHERE OPL.OP_WORK_ID       = P_OP_WORK_ID
                           AND OPL.OP_SPEC_ID       = P_OP_SPEC_ID
                           AND OPL.SUPPLIER_ID      = P_SUPPLIER_ID
                           AND OPL.PRICE_TYPE_LCODE = 'VENDOR'
                           AND P_TRX_DATE           BETWEEN OPL.EFFECTIVE_DATE_FR + (1/24*8.5)
                                                    AND NVL(OPL.EFFECTIVE_DATE_TO + (1 + (1/24*8.5)), P_TRX_DATE)
                           AND OPL.ENABLED_FLAG     = 'Y'
                           AND (  (NVL(V_QTY_LIMIT_FLAG,'N') = 'N' AND 1 = 1) -- 수량범위별 단가적용, 2011-10-15, BY MJSHIN --
                               OR (NVL(V_QTY_LIMIT_FLAG,'N') = 'Y' AND OPL.QTY_LIMIT_UOM_FLAG = 'Y'
                                                                   AND NVL(OPL.QTY_LIMIT_RANGE_FR,0) <= P_QTY_VALUE
                                                                   AND NVL(OPL.QTY_LIMIT_RANGE_TO,9999999999999) >= P_QTY_VALUE)
                               )
                           ;
                   EXCEPTION WHEN OTHERS THEN
                        X_PRICE_CLASS         := NULL;
                        X_PRICE_TYPE_LCODE    := NULL;
                        X_OUT_PRICE           := NULL;
                        X_OUT_PRICE_ID        := NULL;
                        X_LOW_LIMIT_AMOUNT    := NULL;
                        X_HIGH_LIMIT_AMOUNT   := NULL;
                        X_LOW_LIMIT_PRICE_UOM := NULL;
                        X_LOW_LIMIT_PRICE     := NULL;
                        X_SETTING_FEE_AMOUNT  := NULL;
                        X_SETTING_LIMIT_HOUR  := NULL;
                   END;                   
               END IF;

               -- 3. MODEL 기준 단가 --
               IF X_OUT_PRICE IS NULL THEN
                         
                   BEGIN
                        SELECT OPL.PRICE_CLASS
                             , OPL.PRICE_TYPE_LCODE
                             , OPL.OUT_PRICE
                             , OPL.OUT_PRICE_ID
                             , OPL.LOW_LIMIT_AMOUNT
                             , OPL.HIGH_LIMIT_AMOUNT
                             , OPL.LOW_LIMIT_PRICE_UOM
                             , OPL.LOW_LIMIT_PRICE
                             , OPL.SETTING_FEE_AMOUNT
                             , OPL.SETTING_LIMIT_HOUR
                          INTO X_PRICE_CLASS
                             , X_PRICE_TYPE_LCODE
                             , X_OUT_PRICE
                             , X_OUT_PRICE_ID
                             , X_LOW_LIMIT_AMOUNT
                             , X_HIGH_LIMIT_AMOUNT
                             , X_LOW_LIMIT_PRICE_UOM
                             , X_LOW_LIMIT_PRICE
                             , X_SETTING_FEE_AMOUNT
                             , X_SETTING_LIMIT_HOUR
                          FROM WIP_OUT_PRICE_LIST   OPL
                         WHERE OPL.OP_WORK_ID       = P_OP_WORK_ID
                           AND OPL.OP_SPEC_ID       = P_OP_SPEC_ID
                           AND OPL.PRICE_TYPE_LCODE = 'MODEL'
                           AND OPL.BOM_ITEM_ID      = P_BOM_ITEM_ID
                          AND P_TRX_DATE           BETWEEN OPL.EFFECTIVE_DATE_FR + (1/24*8.5)
                                                    AND NVL(OPL.EFFECTIVE_DATE_TO + (1 + (1/24*8.5)), P_TRX_DATE)
                           AND OPL.ENABLED_FLAG     = 'Y'
                           AND (  (NVL(V_QTY_LIMIT_FLAG,'N') = 'N' AND 1 = 1)  -- 수량범위별 단가적용, 2011-10-15, BY MJSHIN --
                               OR (NVL(V_QTY_LIMIT_FLAG,'N') = 'Y' AND OPL.QTY_LIMIT_UOM_FLAG = 'Y'
                                                                   AND NVL(OPL.QTY_LIMIT_RANGE_FR,0) <= P_QTY_VALUE
                                                                   AND NVL(OPL.QTY_LIMIT_RANGE_TO,9999999999999) >= P_QTY_VALUE)
                               )
                           ;
                   EXCEPTION WHEN OTHERS THEN
                        X_PRICE_CLASS         := NULL;
                        X_PRICE_TYPE_LCODE    := NULL;
                        X_OUT_PRICE           := NULL;
                        X_OUT_PRICE_ID        := NULL;
                        X_LOW_LIMIT_AMOUNT    := NULL;
                        X_HIGH_LIMIT_AMOUNT   := NULL;
                        X_LOW_LIMIT_PRICE_UOM := NULL;
                        X_LOW_LIMIT_PRICE     := NULL;
                        X_SETTING_FEE_AMOUNT  := NULL;
                        X_SETTING_LIMIT_HOUR  := NULL;
                   END;                   
               END IF;

               -- 4. STANARD 기준 단가 --
               IF X_OUT_PRICE IS NULL THEN
                         
                   BEGIN
                        SELECT OPL.PRICE_CLASS
                             , OPL.PRICE_TYPE_LCODE
                             , OPL.OUT_PRICE
                             , OPL.OUT_PRICE_ID
                             , OPL.LOW_LIMIT_AMOUNT
                             , OPL.HIGH_LIMIT_AMOUNT
                             , OPL.LOW_LIMIT_PRICE_UOM
                             , OPL.LOW_LIMIT_PRICE
                             , OPL.SETTING_FEE_AMOUNT
                             , OPL.SETTING_LIMIT_HOUR
                          INTO X_PRICE_CLASS
                             , X_PRICE_TYPE_LCODE
                             , X_OUT_PRICE
                             , X_OUT_PRICE_ID
                             , X_LOW_LIMIT_AMOUNT
                             , X_HIGH_LIMIT_AMOUNT
                             , X_LOW_LIMIT_PRICE_UOM
                             , X_LOW_LIMIT_PRICE
                             , X_SETTING_FEE_AMOUNT
                             , X_SETTING_LIMIT_HOUR
                          FROM WIP_OUT_PRICE_LIST   OPL
                         WHERE OPL.OP_WORK_ID       = P_OP_WORK_ID
                           AND OPL.OP_SPEC_ID       = P_OP_SPEC_ID
                           AND OPL.PRICE_TYPE_LCODE = 'STANDARD'
                           AND P_TRX_DATE           BETWEEN OPL.EFFECTIVE_DATE_FR + (1/24*8.5)
                                                    AND NVL(OPL.EFFECTIVE_DATE_TO + (1 + (1/24*8.5)), P_TRX_DATE)
                           AND OPL.ENABLED_FLAG     = 'Y'
                           AND (  (NVL(V_QTY_LIMIT_FLAG,'N') = 'N' AND 1 = 1) -- 수량범위별 단가적용, 2011-10-15, BY MJSHIN --
                               OR (NVL(V_QTY_LIMIT_FLAG,'N') = 'Y' AND OPL.QTY_LIMIT_UOM_FLAG = 'Y'
                                                                   AND NVL(OPL.QTY_LIMIT_RANGE_FR,0) <= P_QTY_VALUE
                                                                   AND NVL(OPL.QTY_LIMIT_RANGE_TO,9999999999999) >= P_QTY_VALUE)
                               )
                           ;
                   EXCEPTION WHEN OTHERS THEN
                        X_PRICE_CLASS         := NULL;
                        X_PRICE_TYPE_LCODE    := NULL;
                        X_OUT_PRICE           := NULL;
                        X_OUT_PRICE_ID        := NULL;
                        X_LOW_LIMIT_AMOUNT    := NULL;
                        X_HIGH_LIMIT_AMOUNT   := NULL;
                        X_LOW_LIMIT_PRICE_UOM := NULL;
                        X_LOW_LIMIT_PRICE     := NULL;
                        X_SETTING_FEE_AMOUNT  := NULL;
                        X_SETTING_LIMIT_HOUR  := NULL;
                   END;                   
               END IF;
           
           
           END IF;  
EXCEPTION WHEN OTHERS THEN
     NULL;
END GET_OUT_PRICE;


--------------------------
-- GET_ITEM_SPEC_INFO   --
--------------------------
PROCEDURE GET_ITEM_SPEC_INFO ( P_SOB_ID              IN  NUMBER
                             , P_ORG_ID              IN  NUMBER
                             , P_INVENTORY_ITEM_ID   IN  NUMBER
                             , P_BOM_ITEM_ID         IN  NUMBER
                             , X_PNL_SIZE_X          OUT NUMBER
                             , X_PNL_SIZE_Y          OUT NUMBER
                             , X_PCS_PER_PNL_QTY     OUT NUMBER   
                             , X_PCS_PER_MM_QTY      OUT NUMBER
                             , X_PCS_PER_ARRAY_QTY   OUT NUMBER
                             , X_ARRAY_PER_PNL_QTY   OUT NUMBER
                             )
IS
  V_ITEM_CATEGORY_CODE  VARCHAR2(50);
  V_TOP_BOM_ITEM_ID     NUMBER;
  V_PNL_SIZE_X          NUMBER;
  V_PNL_SIZE_Y          NUMBER;
BEGIN


           -------------------------------------------------
           -- ITEM SPEC SELECT                            --
           -------------------------------------------------
           BEGIN
                SELECT IIM.ITEM_CATEGORY_CODE
                  INTO V_ITEM_CATEGORY_CODE
                  FROM INV_ITEM_MASTER       IIM
                 WHERE IIM.INVENTORY_ITEM_ID = P_INVENTORY_ITEM_ID
                 ;
           EXCEPTION WHEN OTHERS THEN
                V_ITEM_CATEGORY_CODE := NULL;
           END;
           
           IF V_ITEM_CATEGORY_CODE = 'FG' THEN
                V_TOP_BOM_ITEM_ID  := P_BOM_ITEM_ID;
           ELSE
                BEGIN
                     SELECT STR.BOM_ITEM_ID
                          , STR.ITEM_SIZE_X
                          , STR.ITEM_SIZE_Y
                          , NVL(STR.JOK_JAN_PER_PNL,0)
                       INTO V_TOP_BOM_ITEM_ID
                          , V_PNL_SIZE_X
                          , V_PNL_SIZE_Y
                          , X_ARRAY_PER_PNL_QTY
                       FROM SDM_ITEM_STRUCTURE  STR
                      WHERE STR.SG_BOM_ITEM_ID  = P_BOM_ITEM_ID
                      ;
                EXCEPTION WHEN OTHERS THEN
                     V_TOP_BOM_ITEM_ID := NULL;
                END;
           END IF;
           
           
           
           -- 1. ITEM_SPEC --
           BEGIN
                SELECT SIS.PNL_SIZE_X
                     , SIS.PNL_SIZE_Y
                     , SIS.PCS_PER_PNL_QTY
                     , SIS.PCS_PER_MM_QTY
                     , SIS.PCS_PER_ARRAY_QTY
                  INTO X_PNL_SIZE_X
                     , X_PNL_SIZE_Y
                     , X_PCS_PER_PNL_QTY
                     , X_PCS_PER_MM_QTY
                     , X_PCS_PER_ARRAY_QTY
                  FROM SDM_ITEM_SPEC   SIS
                 WHERE SIS.SOB_ID      = P_SOB_ID
                   AND SIS.ORG_ID      = P_ORG_ID
                   AND SIS.BOM_ITEM_ID = V_TOP_BOM_ITEM_ID
                   ;
           EXCEPTION WHEN OTHERS THEN
                X_PNL_SIZE_X        := NULL;
                X_PNL_SIZE_Y       := NULL;
                X_PCS_PER_PNL_QTY   := NULL;
                X_PCS_PER_MM_QTY    := NULL;
                X_PCS_PER_ARRAY_QTY := NULL;
           END;
                 
           IF V_PNL_SIZE_X IS NOT NULL THEN
                 X_PNL_SIZE_X := V_PNL_SIZE_X;
                 X_PNL_SIZE_Y := V_PNL_SIZE_Y;
           END IF;
                               

  
EXCEPTION WHEN OTHERS THEN
     NULL;
END GET_ITEM_SPEC_INFO;

 

-----------------------
-- TRX_SELECT        --
-----------------------
PROCEDURE TRX_SELECT ( P_CURSOR             OUT  TYPES.TCURSOR
                     , W_SOB_ID             IN   NUMBER
                     , W_ORG_ID             IN   NUMBER
                     , W_PERIOD_NAME        IN   VARCHAR2
                     , W_SUPPLIER_ID        IN   NUMBER
                     , W_WORKCENTER_ID      IN   NUMBER
                     , W_FG_ITEM_ID         IN   NUMBER
                     , W_JOB_NO             IN   VARCHAR2
                     , W_RESULT_TYPE        IN   VARCHAR2
                     , W_ADJUST_DATE_FR     IN   DATE
                     , W_ADJUST_DATE_TO     IN   DATE
                     , W_HOLDING_APPLY_FLAG IN   VARCHAR2
                     , W_SORT_TYPE          IN   VARCHAR2
                     , W_CONFIRM_FLAG       IN   VARCHAR2
                     , W_OPERATION_ID       IN   NUMBER
                     )
IS
   V_ADJUST_DATE_FR   DATE;
   V_ADJUST_DATE_TO   DATE;
   V_START_TIME       VARCHAR2(20);
   V_END_TIME         VARCHAR2(20);    
BEGIN
/*
   BEGIN
        SELECT ELE.ENTRY_TAG
          INTO V_START_TIME
          FROM EAPP_LOOKUP_ENTRY  ELE
         WHERE ELE.SOB_ID         = W_SOB_ID
           AND ELE.ORG_ID         = W_ORG_ID
           AND ELE.LOOKUP_TYPE    = 'COST_PERIOD_TIME_ZONE'
           AND ELE.ENTRY_CODE     = 'START'
        ;
   EXCEPTION WHEN OTHERS THEN
        V_START_TIME := '08:30:00';         
   END;
       
   BEGIN
        SELECT ELE.ENTRY_TAG
          INTO V_END_TIME
          FROM EAPP_LOOKUP_ENTRY  ELE
         WHERE ELE.SOB_ID         = W_SOB_ID
           AND ELE.ORG_ID         = W_ORG_ID
           AND ELE.LOOKUP_TYPE    = 'COST_PERIOD_TIME_ZONE'
           AND ELE.ENTRY_CODE     = 'END'
        ;
   EXCEPTION WHEN OTHERS THEN
        V_START_TIME := '08:29:59';         
   END;
       

   V_ADJUST_DATE_FR := TO_DATE(TO_CHAR(W_ADJUST_DATE_FR,'YYYY-MM-DD') || ' ' || V_START_TIME , 'YYYY-MM-DD HH24:MI:SS');
   V_ADJUST_DATE_TO := TO_DATE(TO_CHAR(W_ADJUST_DATE_TO + 1,'YYYY-MM-DD') || ' ' || V_END_TIME , 'YYYY-MM-DD HH24:MI:SS');
 */

   IF NVL(W_SORT_TYPE,'MODEL') = 'MODEL' THEN  -- SORT BY MODEL --
      OPEN P_CURSOR FOR
      SELECT 'N' AS SELECT_FLAG
           , TRX.CONFIRM_FLAG
           , TRX.RESULT_FLAG 
           
           , SIR.BOM_ITEM_CODE
           , SIR.BOM_ITEM_DESCRIPTION
           , TRX.JOB_NO
           , TRX.OPERATION_SEQ_NO
           , SSO.OPERATION_CODE
           , SSO.OPERATION_DESCRIPTION
             -- 정산 수량 -- 
           , TRX.ADJUST_UOM_QTY
           , TRX.ITEM_UOM_CODE
           , TRX.ADJUST_PNL_QTY
           , TRX.ADJUST_ARRAY_QTY
           , TRX.ADJUST_PCS_QTY
           , TRX.ADJUST_MM_QTY
             -- 정산 금액 --
           , EAPP_COMMON_G.GET_LOOKUP_DESC(TRX.SOB_ID, TRX.ORG_ID, 'WIP_OUT_ADJUST_PRICE_TYPE',TRX.ADJUST_PRICE_TYPE_LCODE) AS ADJUST_PRICE_TYPE
           , TRX.ADJUST_CURRENCY_CODE
           , TRX.ADJUST_EXCHANGE_RATE
           , TRX.ADJUST_PRICE
           , TRX.ADJUST_AMOUNT
             -- TRX 정보 --
           , TRX.TOMOVE_TRX_DATE
           , TRX.REJECT_TRX_DATE
             --계산 내역 --
           , TRX.CAL_CURRENCY_CODE
           , TRX.CAL_PRICE
           , TRX.CAL_AMOUNT
           , TRX.LOW_LIMIT_AMOUNT
           , TRX.HIGH_LIMIT_AMOUNT
           , TRX.LOW_LIMIT_PRICE_UOM
           , TRX.LOW_LIMIT_PRICE
           , TRX.SETTING_FEE_AMOUNT
           , TRX.SETTING_LIMIT_HOUR
             -- 모델 정보 --
           , TRX.PNL_SIZE_X
           , TRX.PNL_SIZE_Y
           , TRX.PCS_PER_PNL_QTY
           , TRX.PCS_PER_MM_QTY
             -- UOM 수량 --
           , TRX.RECEIPT_UOM_QTY
           , TRX.RUN_END_UOM_QTY
           , TRX.TOMOVE_UOM_QTY
           , TRX.REJECT_UOM_QTY
             -- PNL 수량 --
           , TRX.RECEIPT_PNL_QTY
           , TRX.RUN_END_PNL_QTY
           , TRX.TOMOVE_PNL_QTY
           , TRX.REJECT_PNL_QTY
             -- ARRAY 수량 --
           , TRX.RECEIPT_ARRAY_QTY
           , TRX.RUN_END_ARRAY_QTY
           , TRX.TOMOVE_ARRAY_QTY
           , TRX.REJECT_ARRAY_QTY
             -- PCS 수량 --
           , TRX.RECEIPT_PCS_QTY
           , TRX.RUN_END_PCS_QTY
           , TRX.TOMOVE_PCS_QTY
           , TRX.REJECT_PCS_QTY
             -- MM 수량 --
           , TRX.TOMOVE_MM_QTY
           , TRX.REJECT_MM_QTY
             -- SUPPLIER 정보 --
           , SUP.SUPPLIER_CODE
           , SUP.SUPPLIER_SHORT_NAME
           , SSW.WORKCENTER_CODE
           , SSW.WORKCENTER_DESCRIPTION
           , EAPP_COMMON_G.GET_LOOKUP_DESC(TRX.SOB_ID, TRX.ORG_ID, 'RESOURCE_OWNER', TRX.OWNER_TYPE_LCODE) AS RESOURCE_OWNER_DESC
             -- ID , CODE -----
           , TRX.ADJUST_TRX_ID
           , TRX.SOB_ID
           , TRX.ORG_ID
           , TRX.ADJUST_SUPPLIER_ID
           , TRX.PERIOD_NAME
           , TRX.SUPPLIER_ID
           , TRX.WORKCENTER_ID
           , TRX.RESOURCE_ID
           , TRX.COUNTRY_CODE
           , TRX.OWNER_TYPE_LCODE
           , TRX.JOB_ID
           , TRX.INVENTORY_ITEM_ID
           , TRX.BOM_ITEM_ID
           , TRX.OPERATION_ID
           , TRX.TOMOVE_TRX_ID
           , TRX.REJECT_TRX_ID
           , 'N' AS UPDATE_FLAG
           , TRX.ORIGINAL_OPERATION_ID
           
        FROM WIP_OUT_ADJUST_TRX       TRX
           , AP_SUPPLIER              SUP
           , SDM_STANDARD_WORKCENTER  SSW
           , SDM_STANDARD_RESOURCE    SSR
           , SDM_ITEM_REVISION        SIR
           , SDM_STANDARD_OPERATION   SSO
       WHERE SUP.SUPPLIER_ID     = TRX.SUPPLIER_ID
         AND SSW.WORKCENTER_ID   = TRX.WORKCENTER_ID
         AND SSR.RESOURCE_ID     = TRX.RESOURCE_ID
         AND SIR.BOM_ITEM_ID     = TRX.BOM_ITEM_ID
         AND SSO.OPERATION_ID    = TRX.OPERATION_ID
         AND TRX.SOB_ID          = W_SOB_ID
         AND TRX.ORG_ID          = W_ORG_ID
         AND TRX.PERIOD_NAME     = W_PERIOD_NAME
         AND TRX.SUPPLIER_ID     = NVL(W_SUPPLIER_ID, TRX.SUPPLIER_ID)
         AND TRX.WORKCENTER_ID   = NVL(W_WORKCENTER_ID, TRX.WORKCENTER_ID)
         AND TRX.INVENTORY_ITEM_ID = NVL(W_FG_ITEM_ID, TRX.INVENTORY_ITEM_ID)
         AND TRX.OPERATION_ID      = NVL(W_OPERATION_ID, TRX.OPERATION_ID)
--         AND TRX.BOM_ITEM_ID     = NVL(W_BOM_ITEM_ID, TRX.BOM_ITEM_ID)
         AND TRX.JOB_NO          LIKE '%' || W_JOB_NO || '%'
         AND (  (W_HOLDING_APPLY_FLAG = 'Y' AND TRX.HOLDING_IN_FLAG = 'Y') 
             OR (TRX.HOLDING_IN_FLAG  = 'N' AND TRX.TOMOVE_TRX_DATE BETWEEN V_ADJUST_DATE_FR AND V_ADJUST_DATE_TO))
         AND (  (NVL(W_RESULT_TYPE,'ALL')  = 'ALL' AND 1 = 1)
             OR (NVL(W_RESULT_TYPE,'ALL') != 'ALL' AND TRX.RESULT_FLAG = W_RESULT_TYPE))  
         AND (  (NVL(W_CONFIRM_FLAG,'A')  = 'A' AND 1 = 1)
             OR (NVL(W_CONFIRM_FLAG,'A') != 'A' AND NVL(TRX.CONFIRM_FLAG,'N') = NVL(W_CONFIRM_FLAG,'A')))    
       ORDER BY SIR.BOM_ITEM_DESCRIPTION
              , SIR.BOM_ITEM_CODE
              , TRX.TOMOVE_TRX_DATE
       ;
       
   ELSIF NVL(W_SORT_TYPE,'MODEL') = 'JOB' THEN   -- SORT BY JOB --
     
      OPEN P_CURSOR FOR
      SELECT 'N' AS SELECT_FLAG
           , TRX.CONFIRM_FLAG
           , TRX.RESULT_FLAG 
           
           , SIR.BOM_ITEM_CODE
           , SIR.BOM_ITEM_DESCRIPTION
           , TRX.JOB_NO
           , TRX.OPERATION_SEQ_NO
           , SSO.OPERATION_CODE
           , SSO.OPERATION_DESCRIPTION
             -- 정산 수량 -- 
           , TRX.ADJUST_UOM_QTY
           , TRX.ITEM_UOM_CODE
           , TRX.ADJUST_PNL_QTY
           , TRX.ADJUST_ARRAY_QTY
           , TRX.ADJUST_PCS_QTY
           , TRX.ADJUST_MM_QTY
             -- 정산 금액 --
           , TRX.ADJUST_CURRENCY_CODE
           , TRX.ADJUST_EXCHANGE_RATE
           , TRX.ADJUST_PRICE
           , TRX.ADJUST_AMOUNT
             -- TRX 정보 --
           , TRX.TOMOVE_TRX_DATE
           , TRX.REJECT_TRX_DATE
             --계산 내역 --
           , TRX.CAL_CURRENCY_CODE
           , TRX.CAL_PRICE
           , TRX.CAL_AMOUNT
           , TRX.LOW_LIMIT_AMOUNT
           , TRX.HIGH_LIMIT_AMOUNT
           , TRX.LOW_LIMIT_PRICE_UOM
           , TRX.LOW_LIMIT_PRICE
           , TRX.SETTING_FEE_AMOUNT
           , TRX.SETTING_LIMIT_HOUR
             -- 모델 정보 --
           , TRX.PNL_SIZE_X
           , TRX.PNL_SIZE_Y
           , TRX.PCS_PER_PNL_QTY
           , TRX.PCS_PER_MM_QTY
             -- UOM 수량 --
           , TRX.RECEIPT_UOM_QTY
           , TRX.RUN_END_UOM_QTY
           , TRX.TOMOVE_UOM_QTY
           , TRX.REJECT_UOM_QTY
             -- PNL 수량 --
           , TRX.RECEIPT_PNL_QTY
           , TRX.RUN_END_PNL_QTY
           , TRX.TOMOVE_PNL_QTY
           , TRX.REJECT_PNL_QTY
             -- ARRAY 수량 --
           , TRX.RECEIPT_ARRAY_QTY
           , TRX.RUN_END_ARRAY_QTY
           , TRX.TOMOVE_ARRAY_QTY
           , TRX.REJECT_ARRAY_QTY
             -- PCS 수량 --
           , TRX.RECEIPT_PCS_QTY
           , TRX.RUN_END_PCS_QTY
           , TRX.TOMOVE_PCS_QTY
           , TRX.REJECT_PCS_QTY
             -- MM 수량 --
           , TRX.TOMOVE_MM_QTY
           , TRX.REJECT_MM_QTY
             -- SUPPLIER 정보 --
           , SUP.SUPPLIER_CODE
           , SUP.SUPPLIER_SHORT_NAME
           , SSW.WORKCENTER_CODE
           , SSW.WORKCENTER_DESCRIPTION
           , EAPP_COMMON_G.GET_LOOKUP_DESC(TRX.SOB_ID, TRX.ORG_ID, 'RESOURCE_OWNER', TRX.OWNER_TYPE_LCODE) AS RESOURCE_OWNER_DESC           
             -- ID , CODE -----
           , TRX.ADJUST_TRX_ID
           , TRX.SOB_ID
           , TRX.ORG_ID
           , TRX.ADJUST_SUPPLIER_ID
           , TRX.PERIOD_NAME
           , TRX.SUPPLIER_ID
           , TRX.WORKCENTER_ID
           , TRX.RESOURCE_ID
           , TRX.COUNTRY_CODE
           , TRX.OWNER_TYPE_LCODE
           , TRX.JOB_ID
           , TRX.INVENTORY_ITEM_ID
           , TRX.BOM_ITEM_ID
           , TRX.OPERATION_ID
           , TRX.TOMOVE_TRX_ID
           , TRX.REJECT_TRX_ID
           , 'N' AS UPDATE_FLAG
           , TRX.ORIGINAL_OPERATION_ID
           
        FROM WIP_OUT_ADJUST_TRX       TRX
           , AP_SUPPLIER              SUP
           , SDM_STANDARD_WORKCENTER  SSW
           , SDM_STANDARD_RESOURCE    SSR
           , SDM_ITEM_REVISION        SIR
           , SDM_STANDARD_OPERATION   SSO
       WHERE SUP.SUPPLIER_ID     = TRX.SUPPLIER_ID
         AND SSW.WORKCENTER_ID   = TRX.WORKCENTER_ID
         AND SSR.RESOURCE_ID     = TRX.RESOURCE_ID
         AND SIR.BOM_ITEM_ID     = TRX.BOM_ITEM_ID
         AND SSO.OPERATION_ID    = TRX.OPERATION_ID
         AND TRX.SOB_ID          = W_SOB_ID
         AND TRX.ORG_ID          = W_ORG_ID
         AND TRX.PERIOD_NAME     = W_PERIOD_NAME
         AND TRX.SUPPLIER_ID     = NVL(W_SUPPLIER_ID, TRX.SUPPLIER_ID)
         AND TRX.WORKCENTER_ID   = NVL(W_WORKCENTER_ID, TRX.WORKCENTER_ID)
         AND TRX.INVENTORY_ITEM_ID = NVL(W_FG_ITEM_ID, TRX.INVENTORY_ITEM_ID)
         AND TRX.OPERATION_ID      = NVL(W_OPERATION_ID, TRX.OPERATION_ID)
--         AND TRX.BOM_ITEM_ID     = NVL(W_BOM_ITEM_ID, TRX.BOM_ITEM_ID)
         AND TRX.JOB_NO          LIKE '%' || W_JOB_NO || '%'
         AND (  (W_HOLDING_APPLY_FLAG = 'Y' AND TRX.HOLDING_IN_FLAG = 'Y') 
             OR (TRX.HOLDING_IN_FLAG  = 'N' AND TRX.TOMOVE_TRX_DATE BETWEEN V_ADJUST_DATE_FR AND V_ADJUST_DATE_TO))
         AND (  (NVL(W_RESULT_TYPE,'ALL')  = 'ALL' AND 1 = 1)
             OR (NVL(W_RESULT_TYPE,'ALL') != 'ALL' AND TRX.RESULT_FLAG = W_RESULT_TYPE))     
         AND (  (NVL(W_CONFIRM_FLAG,'A')  = 'A' AND 1 = 1)
             OR (NVL(W_CONFIRM_FLAG,'A') != 'A' AND NVL(TRX.CONFIRM_FLAG,'N') = NVL(W_CONFIRM_FLAG,'A')))
       ORDER BY TRX.JOB_NO
              , TRX.TOMOVE_TRX_DATE               
       ;   

   ELSE   -- SORT BY OPERAION --
     
      OPEN P_CURSOR FOR
      SELECT 'N' AS SELECT_FLAG
           , TRX.CONFIRM_FLAG
           , TRX.RESULT_FLAG 
           
           , SIR.BOM_ITEM_CODE
           , SIR.BOM_ITEM_DESCRIPTION
           , TRX.JOB_NO
           , TRX.OPERATION_SEQ_NO
           , SSO.OPERATION_CODE
           , SSO.OPERATION_DESCRIPTION
             -- 정산 수량 -- 
           , TRX.ADJUST_UOM_QTY
           , TRX.ITEM_UOM_CODE
           , TRX.ADJUST_PNL_QTY
           , TRX.ADJUST_ARRAY_QTY
           , TRX.ADJUST_PCS_QTY
           , TRX.ADJUST_MM_QTY
             -- 정산 금액 --
           , TRX.ADJUST_CURRENCY_CODE
           , TRX.ADJUST_EXCHANGE_RATE
           , TRX.ADJUST_PRICE
           , TRX.ADJUST_AMOUNT
             -- TRX 정보 --
           , TRX.TOMOVE_TRX_DATE
           , TRX.REJECT_TRX_DATE
             --계산 내역 --
           , TRX.CAL_CURRENCY_CODE
           , TRX.CAL_PRICE
           , TRX.CAL_AMOUNT
           , TRX.LOW_LIMIT_AMOUNT
           , TRX.HIGH_LIMIT_AMOUNT
           , TRX.LOW_LIMIT_PRICE_UOM
           , TRX.LOW_LIMIT_PRICE
           , TRX.SETTING_FEE_AMOUNT
           , TRX.SETTING_LIMIT_HOUR
             -- 모델 정보 --
           , TRX.PNL_SIZE_X
           , TRX.PNL_SIZE_Y
           , TRX.PCS_PER_PNL_QTY
           , TRX.PCS_PER_MM_QTY
             -- UOM 수량 --
           , TRX.RECEIPT_UOM_QTY
           , TRX.RUN_END_UOM_QTY
           , TRX.TOMOVE_UOM_QTY
           , TRX.REJECT_UOM_QTY
             -- PNL 수량 --
           , TRX.RECEIPT_PNL_QTY
           , TRX.RUN_END_PNL_QTY
           , TRX.TOMOVE_PNL_QTY
           , TRX.REJECT_PNL_QTY
             -- ARRAY 수량 --
           , TRX.RECEIPT_ARRAY_QTY
           , TRX.RUN_END_ARRAY_QTY
           , TRX.TOMOVE_ARRAY_QTY
           , TRX.REJECT_ARRAY_QTY
             -- PCS 수량 --
           , TRX.RECEIPT_PCS_QTY
           , TRX.RUN_END_PCS_QTY
           , TRX.TOMOVE_PCS_QTY
           , TRX.REJECT_PCS_QTY
             -- MM 수량 --
           , TRX.TOMOVE_MM_QTY
           , TRX.REJECT_MM_QTY
             -- SUPPLIER 정보 --
           , SUP.SUPPLIER_CODE
           , SUP.SUPPLIER_SHORT_NAME
           , SSW.WORKCENTER_CODE
           , SSW.WORKCENTER_DESCRIPTION
           , EAPP_COMMON_G.GET_LOOKUP_DESC(TRX.SOB_ID, TRX.ORG_ID, 'RESOURCE_OWNER', TRX.OWNER_TYPE_LCODE) AS RESOURCE_OWNER_DESC           
             -- ID , CODE -----
           , TRX.ADJUST_TRX_ID
           , TRX.SOB_ID
           , TRX.ORG_ID
           , TRX.ADJUST_SUPPLIER_ID
           , TRX.PERIOD_NAME
           , TRX.SUPPLIER_ID
           , TRX.WORKCENTER_ID
           , TRX.RESOURCE_ID
           , TRX.COUNTRY_CODE
           , TRX.OWNER_TYPE_LCODE
           , TRX.JOB_ID
           , TRX.INVENTORY_ITEM_ID
           , TRX.BOM_ITEM_ID
           , TRX.OPERATION_ID
           , TRX.TOMOVE_TRX_ID
           , TRX.REJECT_TRX_ID
           , 'N' AS UPDATE_FLAG
           , TRX.ORIGINAL_OPERATION_ID
           
        FROM WIP_OUT_ADJUST_TRX       TRX
           , AP_SUPPLIER              SUP
           , SDM_STANDARD_WORKCENTER  SSW
           , SDM_STANDARD_RESOURCE    SSR
           , SDM_ITEM_REVISION        SIR
           , SDM_STANDARD_OPERATION   SSO
       WHERE SUP.SUPPLIER_ID     = TRX.SUPPLIER_ID
         AND SSW.WORKCENTER_ID   = TRX.WORKCENTER_ID
         AND SSR.RESOURCE_ID     = TRX.RESOURCE_ID
         AND SIR.BOM_ITEM_ID     = TRX.BOM_ITEM_ID
         AND SSO.OPERATION_ID    = TRX.OPERATION_ID
         AND TRX.SOB_ID          = W_SOB_ID
         AND TRX.ORG_ID          = W_ORG_ID
         AND TRX.PERIOD_NAME     = W_PERIOD_NAME
         AND TRX.SUPPLIER_ID     = NVL(W_SUPPLIER_ID, TRX.SUPPLIER_ID)
         AND TRX.WORKCENTER_ID   = NVL(W_WORKCENTER_ID, TRX.WORKCENTER_ID)
         AND TRX.INVENTORY_ITEM_ID = NVL(W_FG_ITEM_ID, TRX.INVENTORY_ITEM_ID)
         AND TRX.OPERATION_ID      = NVL(W_OPERATION_ID, TRX.OPERATION_ID)
--         AND TRX.BOM_ITEM_ID     = NVL(W_BOM_ITEM_ID, TRX.BOM_ITEM_ID)
         AND TRX.JOB_NO          LIKE '%' || W_JOB_NO || '%'
         AND (  (W_HOLDING_APPLY_FLAG = 'Y' AND TRX.HOLDING_IN_FLAG = 'Y') 
             OR (TRX.HOLDING_IN_FLAG  = 'N' AND TRX.TOMOVE_TRX_DATE BETWEEN V_ADJUST_DATE_FR AND V_ADJUST_DATE_TO))
         AND (  (NVL(W_RESULT_TYPE,'ALL')  = 'ALL' AND 1 = 1)
             OR (NVL(W_RESULT_TYPE,'ALL') != 'ALL' AND TRX.RESULT_FLAG = W_RESULT_TYPE))  
         AND (  (NVL(W_CONFIRM_FLAG,'A')  = 'A' AND 1 = 1)
             OR (NVL(W_CONFIRM_FLAG,'A') != 'A' AND NVL(TRX.CONFIRM_FLAG,'N') = NVL(W_CONFIRM_FLAG,'A')))   
       ORDER BY SSO.OPERATION_DESCRIPTION
              , SIR.BOM_ITEM_DESCRIPTION 
              , TRX.JOB_NO
              , TRX.TOMOVE_TRX_DATE
       ;      
   END IF;       

END TRX_SELECT; 

---------------------------------------------------------------------
-- TRX의 OPERATION과 수량을 변경할 수 있도록 함, (FXC 김진영요청)  --
-- 2012-10-23, BY MJSHIN                                           --
---------------------------------------------------------------------
PROCEDURE TRX_UPDATE( P_ADJUST_TRX_ID             IN WIP_OUT_ADJUST_TRX.ADJUST_TRX_ID%TYPE
                    , P_SOB_ID                    IN WIP_OUT_ADJUST_TRX.SOB_ID%TYPE
                    , P_OPERATION_ID              IN WIP_OUT_ADJUST_TRX.OPERATION_ID%TYPE
                    , P_ADJUST_PNL_QTY            IN WIP_OUT_ADJUST_TRX.ADJUST_PNL_QTY%TYPE
                    , P_ADJUST_ARRAY_QTY          IN WIP_OUT_ADJUST_TRX.ADJUST_ARRAY_QTY%TYPE
                    , P_ADJUST_PCS_QTY            IN WIP_OUT_ADJUST_TRX.ADJUST_PCS_QTY%TYPE
                    , P_ADJUST_MM_QTY             IN WIP_OUT_ADJUST_TRX.ADJUST_MM_QTY%TYPE
                    , P_USER_ID                   IN  NUMBER
                    , X_RESULT_STATUS             OUT VARCHAR2
                    , X_RESULT_MSG                OUT VARCHAR2
                    )
IS

 V_SYSDATE DATE := GET_LOCAL_DATE(P_SOB_ID);
BEGIN
  
   X_RESULT_STATUS := 'F'; 

   UPDATE WIP_OUT_ADJUST_TRX
      SET OPERATION_ID              = P_OPERATION_ID
        , ADJUST_PNL_QTY            = P_ADJUST_PNL_QTY
        , ADJUST_ARRAY_QTY          = P_ADJUST_ARRAY_QTY
        , ADJUST_PCS_QTY            = P_ADJUST_PCS_QTY
        , ADJUST_MM_QTY             = P_ADJUST_MM_QTY
        , LAST_UPDATE_DATE          = V_SYSDATE
        , LAST_UPDATED_BY           = P_USER_ID
    WHERE ADJUST_TRX_ID             = P_ADJUST_TRX_ID;
 

   X_RESULT_STATUS := 'S';
       
EXCEPTION WHEN OTHERS THEN
    X_RESULT_STATUS := 'F';  
    X_RESULT_MSG    := SQLERRM;
END TRX_UPDATE;


-----------------------
-- SPEC_SELECT       --
-----------------------
PROCEDURE SPEC_SELECT  ( P_CURSOR             OUT  TYPES.TCURSOR
                       , W_SOB_ID             IN   NUMBER
                       , W_ORG_ID             IN   NUMBER
                       , W_PERIOD_NAME        IN   VARCHAR2
                       , W_ADJUST_TRX_ID      IN   NUMBER
                       )
IS
BEGIN

        OPEN P_CURSOR FOR
        SELECT SOW.OP_WORK_CODE
             , SOW.OP_WORK_DESCRIPTION
             , SOS.OP_SPEC_CODE
             , SOS.OP_SPEC_DESCRIPTION
             , OSP.OP_SPEC_UOM_CODE
             , OSP.OP_SPEC_VALUE
             
             , OSP.PRICE_CLASS
             , EAPP_COMMON_G.GET_LOOKUP_DESC(OSP.SOB_ID, OSP.ORG_ID, 'WIP_OUT_PRICE_TYPE', OSP.PRICE_TYPE_LCODE) AS PRICE_TYPE_DESC 
             , OSP.CURRENCY_CODE
             , OSP.OUT_PRICE
             , OSP.OUT_AMOUNT 
             , EAPP_COMMON_G.GET_LOOKUP_DESC(OSP.SOB_ID, OSP.ORG_ID, 'OUT_PRICE_APPLY_TYPE', OSP.PRICE_APPLY_TYPE_LCODE) AS PRICE_APPLY_TYPE_DESC
             , OSP.LOW_LIMIT_AMOUNT
             , OSP.HIGH_LIMIT_AMOUNT
             , OSP.LOW_LIMIT_PRICE_UOM
             , OSP.LOW_LIMIT_PRICE
             , OSP.SETTING_FEE_AMOUNT
             , OSP.SETTING_LIMIT_HOUR
             , OSP.BASIC_PRICE
             , OSP.BASIC_AMOUNT
             , OSP.PRICE_TYPE_LCODE
             , OSP.PRICE_APPLY_TYPE_LCODE
             , OSP.ADJUST_SPEC_ID
             , OSP.ADJUST_SUPPLIER_ID
             , OSP.ADJUST_TRX_ID
             , OSP.OP_WORK_ID
             , OSP.OP_SPEC_ID
             , OSP.OUT_PRICE_ID
             , OSP.PERIOD_NAME
             , OSP.SOB_ID
             , OSP.ORG_ID
          FROM WIP_OUT_ADJUST_SPEC   OSP
             , SDM_STANDARD_OP_WORK  SOW
             , SDM_STANDARD_OP_SPEC  SOS
         WHERE SOW.OP_WORK_ID        = OSP.OP_WORK_ID
           AND SOS.OP_SPEC_ID        = OSP.OP_SPEC_ID
           AND SOS.SOB_ID            = W_SOB_ID
           AND SOS.ORG_ID            = W_ORG_ID
           AND OSP.PERIOD_NAME       = W_PERIOD_NAME
           AND OSP.ADJUST_TRX_ID     = W_ADJUST_TRX_ID
           ORDER BY SOW.OP_WORK_DESCRIPTION
                  , SOS.OP_SPEC_DESCRIPTION
           ;

END SPEC_SELECT; 

---------------------------
-- SPEC INSERT           --
---------------------------
PROCEDURE SPEC_INSERT( P_ADJUST_SPEC_ID         OUT WIP_OUT_ADJUST_SPEC.ADJUST_SPEC_ID%TYPE
                     , P_SOB_ID                 IN WIP_OUT_ADJUST_SPEC.SOB_ID%TYPE
                     , P_ORG_ID                 IN WIP_OUT_ADJUST_SPEC.ORG_ID%TYPE
                     , P_ADJUST_SUPPLIER_ID     IN WIP_OUT_ADJUST_SPEC.ADJUST_SUPPLIER_ID%TYPE
                     , P_ADJUST_TRX_ID          IN WIP_OUT_ADJUST_SPEC.ADJUST_TRX_ID%TYPE
                     , P_PERIOD_NAME            IN WIP_OUT_ADJUST_SPEC.PERIOD_NAME%TYPE
                     , P_OP_WORK_ID             IN WIP_OUT_ADJUST_SPEC.OP_WORK_ID%TYPE
                     , P_OP_SPEC_ID             IN WIP_OUT_ADJUST_SPEC.OP_SPEC_ID%TYPE
                     , P_OP_SPEC_VALUE          IN WIP_OUT_ADJUST_SPEC.OP_SPEC_VALUE%TYPE
                     , P_OP_SPEC_UOM_CODE       IN WIP_OUT_ADJUST_SPEC.OP_SPEC_UOM_CODE%TYPE
                     , P_OUT_PRICE_ID           IN WIP_OUT_ADJUST_SPEC.OUT_PRICE_ID%TYPE
                     , P_PRICE_CLASS            IN WIP_OUT_ADJUST_SPEC.PRICE_CLASS%TYPE
                     , P_PRICE_TYPE_LCODE       IN WIP_OUT_ADJUST_SPEC.PRICE_TYPE_LCODE%TYPE
                     , P_CURRENCY_CODE          IN WIP_OUT_ADJUST_SPEC.CURRENCY_CODE%TYPE
                     , P_BASIC_PRICE            IN WIP_OUT_ADJUST_SPEC.BASIC_PRICE%TYPE
                     , P_BASIC_AMOUNT           IN WIP_OUT_ADJUST_SPEC.BASIC_AMOUNT%TYPE
                     , P_OUT_PRICE              IN WIP_OUT_ADJUST_SPEC.OUT_PRICE%TYPE
                     , P_OUT_AMOUNT             IN WIP_OUT_ADJUST_SPEC.OUT_AMOUNT%TYPE
                     , P_LOW_LIMIT_AMOUNT       IN WIP_OUT_ADJUST_SPEC.LOW_LIMIT_AMOUNT%TYPE
                     , P_HIGH_LIMIT_AMOUNT      IN WIP_OUT_ADJUST_SPEC.HIGH_LIMIT_AMOUNT%TYPE
                     , P_LOW_LIMIT_PRICE_UOM    IN WIP_OUT_ADJUST_SPEC.LOW_LIMIT_PRICE_UOM%TYPE
                     , P_LOW_LIMIT_PRICE        IN WIP_OUT_ADJUST_SPEC.LOW_LIMIT_PRICE%TYPE
                     , P_SETTING_FEE_AMOUNT     IN WIP_OUT_ADJUST_SPEC.SETTING_FEE_AMOUNT%TYPE
                     , P_SETTING_LIMIT_HOUR     IN WIP_OUT_ADJUST_SPEC.SETTING_LIMIT_HOUR%TYPE
                     , P_PRICE_APPLY_TYPE_LCODE IN WIP_OUT_ADJUST_SPEC.PRICE_APPLY_TYPE_LCODE%TYPE
                     , P_USER_ID                IN WIP_OUT_ADJUST_SPEC.CREATED_BY%TYPE )
IS

 V_SYSDATE            DATE := GET_LOCAL_DATE(P_SOB_ID);
 V_DUMMY              VARCHAR2(200);
 V_LINE_CONFIRM_FLAG  VARCHAR2(1);
BEGIN

 ------------------------------------
 -- 라인확정상태이면 수정 불가     --
 -- 2012-04-20, BY MJSHIN          --
 ------------------------------------
 BEGIN
      SELECT WAT.CONFIRM_FLAG
        INTO V_LINE_CONFIRM_FLAG
        FROM WIP_OUT_ADJUST_TRX  WAT
       WHERE WAT.ADJUST_TRX_ID   = P_ADJUST_TRX_ID
       ;
 EXCEPTION WHEN OTHERS THEN
     V_LINE_CONFIRM_FLAG := 'N';
 END;
 
 IF NVL(V_LINE_CONFIRM_FLAG,'N') = 'Y' THEN
                                     -- 해당 JOB/공정 라인이 이미 확정되어 수정이나 이월처리가 불가능합니다.. 라인확정 취소후 작업하시기 바랍니다. --
     RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F,'WIP_10262', NULL));
 END IF;
 
 SELECT WIP_OUT_ADJUST_SPEC_S1.NEXTVAL
   INTO P_ADJUST_SPEC_ID
   FROM DUAL;

 INSERT INTO WIP_OUT_ADJUST_SPEC
 ( ADJUST_SPEC_ID
 , SOB_ID 
 , ORG_ID 
 , ADJUST_SUPPLIER_ID 
 , ADJUST_TRX_ID 
 , PERIOD_NAME 
 , OP_WORK_ID 
 , OP_SPEC_ID 
 , OP_SPEC_VALUE 
 , OP_SPEC_UOM_CODE 
 , OUT_PRICE_ID 
 , PRICE_CLASS 
 , PRICE_TYPE_LCODE 
 , CURRENCY_CODE 
 , BASIC_PRICE 
 , BASIC_AMOUNT 
 , OUT_PRICE 
 , OUT_AMOUNT 
 , LOW_LIMIT_AMOUNT 
 , HIGH_LIMIT_AMOUNT 
 , LOW_LIMIT_PRICE_UOM 
 , LOW_LIMIT_PRICE 
 , SETTING_FEE_AMOUNT 
 , SETTING_LIMIT_HOUR 
 , PRICE_APPLY_TYPE_LCODE 
 , CREATION_DATE 
 , CREATED_BY 
 , LAST_UPDATE_DATE 
 , LAST_UPDATED_BY )
 VALUES
 ( P_ADJUST_SPEC_ID
 , P_SOB_ID
 , P_ORG_ID
 , P_ADJUST_SUPPLIER_ID
 , P_ADJUST_TRX_ID
 , P_PERIOD_NAME
 , P_OP_WORK_ID
 , P_OP_SPEC_ID
 , P_OP_SPEC_VALUE
 , P_OP_SPEC_UOM_CODE
 , P_OUT_PRICE_ID
 , P_PRICE_CLASS
 , P_PRICE_TYPE_LCODE
 , P_CURRENCY_CODE
 , P_BASIC_PRICE
 , P_BASIC_AMOUNT
 , P_OUT_PRICE
 , P_OUT_AMOUNT
 , P_LOW_LIMIT_AMOUNT
 , P_HIGH_LIMIT_AMOUNT
 , P_LOW_LIMIT_PRICE_UOM
 , P_LOW_LIMIT_PRICE
 , P_SETTING_FEE_AMOUNT
 , P_SETTING_LIMIT_HOUR
 , P_PRICE_APPLY_TYPE_LCODE
 , V_SYSDATE
 , P_USER_ID
 , V_SYSDATE
 , P_USER_ID );

 ---------------------------------------------
 -- SPEC별 집계 내역을 TRX테이블에 UPDATE   --
 ---------------------------------------------
 BEGIN
      SPEC_AMT_APPLY_TO_TRX  ( P_ADJUST_TRX_ID   => P_ADJUST_TRX_ID
                             , X_RESULT_STATUS   => V_DUMMY
                             , X_RESULT_MSG      => V_DUMMY
                             );
 EXCEPTION WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20001, 'SPEC Amount Apply to TRX Error');
 END;

EXCEPTION WHEN OTHERS THEN
 BEGIN
  RAISE_APPLICATION_ERROR(-20001, SQLERRM);
 END;

END SPEC_INSERT;

------------------------
-- SPEC_UPDATE        --
------------------------
PROCEDURE SPEC_UPDATE( W_ADJUST_SPEC_ID         IN WIP_OUT_ADJUST_SPEC.ADJUST_SPEC_ID%TYPE
                     , P_SOB_ID                 IN WIP_OUT_ADJUST_SPEC.SOB_ID%TYPE
                     , P_ORG_ID                 IN WIP_OUT_ADJUST_SPEC.ORG_ID%TYPE
                     , P_ADJUST_SUPPLIER_ID     IN WIP_OUT_ADJUST_SPEC.ADJUST_SUPPLIER_ID%TYPE
                     , P_ADJUST_TRX_ID          IN WIP_OUT_ADJUST_SPEC.ADJUST_TRX_ID%TYPE
                     , P_PERIOD_NAME            IN WIP_OUT_ADJUST_SPEC.PERIOD_NAME%TYPE
                     , P_OP_WORK_ID             IN WIP_OUT_ADJUST_SPEC.OP_WORK_ID%TYPE
                     , P_OP_SPEC_ID             IN WIP_OUT_ADJUST_SPEC.OP_SPEC_ID%TYPE
                     , P_OP_SPEC_VALUE          IN WIP_OUT_ADJUST_SPEC.OP_SPEC_VALUE%TYPE
                     , P_OP_SPEC_UOM_CODE       IN WIP_OUT_ADJUST_SPEC.OP_SPEC_UOM_CODE%TYPE
                     , P_OUT_PRICE_ID           IN WIP_OUT_ADJUST_SPEC.OUT_PRICE_ID%TYPE
                     , P_PRICE_CLASS            IN WIP_OUT_ADJUST_SPEC.PRICE_CLASS%TYPE
                     , P_PRICE_TYPE_LCODE       IN WIP_OUT_ADJUST_SPEC.PRICE_TYPE_LCODE%TYPE
                     , P_CURRENCY_CODE          IN WIP_OUT_ADJUST_SPEC.CURRENCY_CODE%TYPE
                     , P_BASIC_PRICE            IN WIP_OUT_ADJUST_SPEC.BASIC_PRICE%TYPE
                     , P_BASIC_AMOUNT           IN WIP_OUT_ADJUST_SPEC.BASIC_AMOUNT%TYPE
                     , P_OUT_PRICE              IN WIP_OUT_ADJUST_SPEC.OUT_PRICE%TYPE
                     , P_OUT_AMOUNT             IN WIP_OUT_ADJUST_SPEC.OUT_AMOUNT%TYPE
                     , P_LOW_LIMIT_AMOUNT       IN WIP_OUT_ADJUST_SPEC.LOW_LIMIT_AMOUNT%TYPE
                     , P_HIGH_LIMIT_AMOUNT      IN WIP_OUT_ADJUST_SPEC.HIGH_LIMIT_AMOUNT%TYPE
                     , P_LOW_LIMIT_PRICE_UOM    IN WIP_OUT_ADJUST_SPEC.LOW_LIMIT_PRICE_UOM%TYPE
                     , P_LOW_LIMIT_PRICE        IN WIP_OUT_ADJUST_SPEC.LOW_LIMIT_PRICE%TYPE
                     , P_SETTING_FEE_AMOUNT     IN WIP_OUT_ADJUST_SPEC.SETTING_FEE_AMOUNT%TYPE
                     , P_SETTING_LIMIT_HOUR     IN WIP_OUT_ADJUST_SPEC.SETTING_LIMIT_HOUR%TYPE
                     , P_PRICE_APPLY_TYPE_LCODE IN WIP_OUT_ADJUST_SPEC.PRICE_APPLY_TYPE_LCODE%TYPE
                     , P_USER_ID                IN WIP_OUT_ADJUST_SPEC.CREATED_BY%TYPE )
IS

 V_SYSDATE            DATE := GET_LOCAL_DATE(P_SOB_ID);
 V_DUMMY              VARCHAR2(200);
 V_LINE_CONFIRM_FLAG  VARCHAR2(1) := 'N';
BEGIN

 ------------------------------------
 -- 라인확정상태이면 수정 불가     --
 -- 2012-04-20, BY MJSHIN          --
 ------------------------------------
 BEGIN
      SELECT WAT.CONFIRM_FLAG
        INTO V_LINE_CONFIRM_FLAG
        FROM WIP_OUT_ADJUST_TRX  WAT
       WHERE WAT.ADJUST_TRX_ID   = P_ADJUST_TRX_ID
       ;
 EXCEPTION WHEN OTHERS THEN
     V_LINE_CONFIRM_FLAG := 'N';
 END;
 
 IF NVL(V_LINE_CONFIRM_FLAG,'N') = 'Y' THEN
                                     -- 해당 JOB/공정 라인이 이미 확정되어 수정이나 이월처리가 불가능합니다.. 라인확정 취소후 작업하시기 바랍니다. --
     RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F,'WIP_10262', NULL));
 END IF;
 
 UPDATE WIP_OUT_ADJUST_SPEC
    SET SOB_ID                 = P_SOB_ID
      , ORG_ID                 = P_ORG_ID
      , ADJUST_SUPPLIER_ID     = P_ADJUST_SUPPLIER_ID
      , ADJUST_TRX_ID          = P_ADJUST_TRX_ID
      , PERIOD_NAME            = P_PERIOD_NAME
      , OP_WORK_ID             = P_OP_WORK_ID
      , OP_SPEC_ID             = P_OP_SPEC_ID
      , OP_SPEC_VALUE          = P_OP_SPEC_VALUE
      , OP_SPEC_UOM_CODE       = P_OP_SPEC_UOM_CODE
      , OUT_PRICE_ID           = P_OUT_PRICE_ID
      , PRICE_CLASS            = P_PRICE_CLASS
      , PRICE_TYPE_LCODE       = P_PRICE_TYPE_LCODE
      , CURRENCY_CODE          = P_CURRENCY_CODE
      , BASIC_PRICE            = P_BASIC_PRICE
      , BASIC_AMOUNT           = P_BASIC_AMOUNT
      , OUT_PRICE              = P_OUT_PRICE
      , OUT_AMOUNT             = P_OUT_AMOUNT
      , LOW_LIMIT_AMOUNT       = P_LOW_LIMIT_AMOUNT
      , HIGH_LIMIT_AMOUNT      = P_HIGH_LIMIT_AMOUNT
      , LOW_LIMIT_PRICE_UOM    = P_LOW_LIMIT_PRICE_UOM
      , LOW_LIMIT_PRICE        = P_LOW_LIMIT_PRICE
      , SETTING_FEE_AMOUNT     = P_SETTING_FEE_AMOUNT
      , SETTING_LIMIT_HOUR     = P_SETTING_LIMIT_HOUR
      , PRICE_APPLY_TYPE_LCODE = P_PRICE_APPLY_TYPE_LCODE
      , LAST_UPDATE_DATE       = V_SYSDATE
      , LAST_UPDATED_BY        = P_USER_ID
  WHERE ADJUST_SPEC_ID         = W_ADJUST_SPEC_ID;

 ---------------------------------------------
 -- SPEC별 집계 내역을 TRX테이블에 UPDATE   --
 ---------------------------------------------
 BEGIN
      SPEC_AMT_APPLY_TO_TRX  ( P_ADJUST_TRX_ID   => P_ADJUST_TRX_ID
                             , X_RESULT_STATUS   => V_DUMMY
                             , X_RESULT_MSG      => V_DUMMY
                             );
 EXCEPTION WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20001, 'SPEC Amount Apply to TRX Error');
 END; 

EXCEPTION WHEN OTHERS THEN
 BEGIN
  RAISE_APPLICATION_ERROR(-20001, SQLERRM);
 END;

END SPEC_UPDATE;


------------------------
-- SPEC_DELETE        --
------------------------
PROCEDURE SPEC_DELETE( W_ADJUST_SPEC_ID IN WIP_OUT_ADJUST_SPEC.ADJUST_SPEC_ID%TYPE )
IS
  V_DUMMY             VARCHAR2(200);
  V_ADJUST_TRX_ID     NUMBER;
  V_LINE_CONFIRM_FLAG VARCHAR2(1) := 'N';  
BEGIN
 
 BEGIN
      SELECT SPC.ADJUST_TRX_ID 
        INTO V_ADJUST_TRX_ID
        FROM WIP_OUT_ADJUST_SPEC SPC
       WHERE SPC.ADJUST_SPEC_ID  = W_ADJUST_SPEC_ID
         AND ROWNUM              = 1
         ;
 EXCEPTION WHEN OTHERS THEN
     V_ADJUST_TRX_ID := -1;
 END;

 ------------------------------------
 -- 라인확정상태이면 수정 불가     --
 -- 2012-04-20, BY MJSHIN          --
 ------------------------------------
 BEGIN
      SELECT WAT.CONFIRM_FLAG
        INTO V_LINE_CONFIRM_FLAG
        FROM WIP_OUT_ADJUST_TRX  WAT
       WHERE WAT.ADJUST_TRX_ID   = V_ADJUST_TRX_ID
       ;
 EXCEPTION WHEN OTHERS THEN
     V_LINE_CONFIRM_FLAG := 'N';
 END;
 
 IF NVL(V_LINE_CONFIRM_FLAG,'N') = 'Y' THEN
                                     -- 해당 JOB/공정 라인이 이미 확정되어 수정이나 이월처리가 불가능합니다.. 라인확정 취소후 작업하시기 바랍니다. --
     RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F,'WIP_10262', NULL));
 END IF;
 
 
 DELETE WIP_OUT_ADJUST_SPEC
  WHERE ADJUST_SPEC_ID = W_ADJUST_SPEC_ID;

 ---------------------------------------------
 -- SPEC별 집계 내역을 TRX테이블에 UPDATE   --
 ---------------------------------------------
 BEGIN
      SPEC_AMT_APPLY_TO_TRX  ( P_ADJUST_TRX_ID   => V_ADJUST_TRX_ID
                             , X_RESULT_STATUS   => V_DUMMY
                             , X_RESULT_MSG      => V_DUMMY
                             );
 EXCEPTION WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20001, 'SPEC Amount Apply to TRX Error');
 END; 

EXCEPTION WHEN OTHERS THEN
 BEGIN
  RAISE_APPLICATION_ERROR(-20001, SQLERRM);
 END;

END SPEC_DELETE;


------------------------
-- CLAIM비용 저장     --
------------------------
PROCEDURE CLAIM_SAVE ( P_SOB_ID              IN  NUMBER
                     , P_ORG_ID              IN  NUMBER
                     , P_PERIOD_NAME         IN  VARCHAR2
                     , P_ADJUST_SUPPLIER_ID  IN  NUMBER
                     , P_CLAIM_AMOUNT        IN  NUMBER
                     , P_USER_ID             IN  NUMBER
                     , X_RESULT_STATUS       OUT VARCHAR2
                     , X_RESULT_MSG          OUT VARCHAR2
                     )
IS
  V_LOCAL_DATE            DATE := GET_LOCAL_DATE(P_SOB_ID);  
  
  V_CONFIRM_FLAG          VARCHAR2(1);
  V_PRE_CLAIM_AMOUNT      NUMBER;

BEGIN
    X_RESULT_STATUS := 'F';
    

    --------------------------------
    -- 확정 여부 CHECK            --
    -- 미확정 일 경우에만 저장    --
    --------------------------------
    BEGIN
          SELECT NVL(S.CONFIRM_FLAG,'N')
               , NVL(S.CLAIM_AMOUNT,0)
            INTO V_CONFIRM_FLAG
               , V_PRE_CLAIM_AMOUNT
            FROM WIP_OUT_ADJUST_SUPPLIER S
           WHERE S.ADJUST_SUPPLIER_ID   = P_ADJUST_SUPPLIER_ID
             ;  
    EXCEPTION WHEN OTHERS THEN
        V_CONFIRM_FLAG     := 'N';
        V_PRE_CLAIM_AMOUNT := 0;
    END;
    
            
    IF V_CONFIRM_FLAG = 'N' AND V_PRE_CLAIM_AMOUNT != P_CLAIM_AMOUNT THEN
       BEGIN
            UPDATE WIP_OUT_ADJUST_SUPPLIER P
               SET P.CLAIM_AMOUNT          = P_CLAIM_AMOUNT
                 , P.SLIP_AMOUNT           = NVL(P.ADJUST_AMOUNT,0) + NVL(P.MISC_AMOUNT,0) - NVL(P_CLAIM_AMOUNT,0)
                 , P.LAST_UPDATE_DATE      = V_LOCAL_DATE
                 , P.LAST_UPDATED_BY       = P_USER_ID
             WHERE P.ADJUST_SUPPLIER_ID    = P_ADJUST_SUPPLIER_ID
             ;
       EXCEPTION WHEN OTHERS THEN
            X_RESULT_MSG := 'WIP_OUT_ADJUST_SUPPLIER Claim Amount Update Error : ' || SQLERRM;
            RETURN;
       END;    
           
    END IF;
        

   
   X_RESULT_STATUS := 'S';

EXCEPTION WHEN OTHERS THEN
    X_RESULT_STATUS := 'F';          
END CLAIM_SAVE;



------------------------
-- 정산마감           --
------------------------
PROCEDURE ADJUST_CLOSE ( P_SOB_ID              IN  NUMBER
                       , P_ORG_ID              IN  NUMBER
                       , P_PERIOD_NAME         IN  VARCHAR2
                       , P_USER_ID             IN  NUMBER
                       , X_RESULT_STATUS       OUT VARCHAR2
                       , X_RESULT_MSG          OUT VARCHAR2
                       )
IS
  V_LOCAL_DATE            DATE := GET_LOCAL_DATE(P_SOB_ID);  
  
  V_CONFIRM_FLAG          VARCHAR2(1);
  V_CLOSE_FLAG            VARCHAR2(1);
  V_SUPPLIER              VARCHAR2(250);
BEGIN
   X_RESULT_STATUS := 'F';
   
   --------------------------------
   -- 구매처별 미확정 내역 CHECK --
   --------------------------------
   FOR REC IN (SELECT PAS.ADJUST_SUPPLIER_ID
                    , PAS.SUPPLIER_ID
                    , SUP.SUPPLIER_CODE
                    , SUP.SUPPLIER_SHORT_NAME
                    , PAS.WORKCENTER_ID
                    , SSW.WORKCENTER_CODE
                    , SSW.WORKCENTER_DESCRIPTION
                 FROM WIP_OUT_ADJUST_SUPPLIER  PAS
                    , AP_SUPPLIER              SUP
                    , SDM_STANDARD_WORKCENTER  SSW
                WHERE PAS.SOB_ID              = P_SOB_ID
                  AND PAS.ORG_ID              = P_ORG_ID
                  AND SUP.SUPPLIER_ID         = PAS.SUPPLIER_ID
                  AND SSW.WORKCENTER_ID       = PAS.WORKCENTER_ID
                  AND PAS.PERIOD_NAME         = P_PERIOD_NAME)
   LOOP
     
        BEGIN
              SELECT NVL(S.CONFIRM_FLAG,'N')
                INTO V_CONFIRM_FLAG
                FROM WIP_OUT_ADJUST_SUPPLIER S
               WHERE S.ADJUST_SUPPLIER_ID   = REC.ADJUST_SUPPLIER_ID
                 ;  
        EXCEPTION WHEN OTHERS THEN
            V_CONFIRM_FLAG := 'N';
        END;
        
        IF V_CONFIRM_FLAG = 'N' THEN
            V_SUPPLIER := '[' || REC.SUPPLIER_CODE || '][' || REC.SUPPLIER_SHORT_NAME || '][' || REC.WORKCENTER_CODE || '][' || REC.WORKCENTER_DESCRIPTION || ']';
                               -- &&SUPPLIER 이(가) 확정처리가 되지 않아 정산마감을 진행할 수 없습니다. 확인 후 재처리 바랍니다. --
            X_RESULT_MSG    := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F,'INV_10029', '&&SUPPLIER:=' || V_SUPPLIER);
            RETURN;
        END IF;
   END LOOP;
   
   ----------------------
   -- 기마감내역 CHECK --
   ----------------------
   BEGIN
        SELECT NVL(P.ADJUST_CLOSE_FLAG,'N') 
          INTO V_CLOSE_FLAG
          FROM INV_CLOSE_PERIOD  P
         WHERE P.SOB_ID          = P_SOB_ID  
           AND P.ORG_ID          = P_ORG_ID
           AND P.PERIOD_NAME     = P_PERIOD_NAME
           AND P.CLOSE_TYPE      = 'WIP_OUT_ADJ'
           ;
   EXCEPTION WHEN OTHERS THEN
        V_CLOSE_FLAG := 'N';
   END;
   
   IF V_CLOSE_FLAG = 'Y' THEN
                          -- &&PERIOD 은(는) 이미 마감되어 마감처리를 진행할 수 없습니다. 확인 후 재처리 바랍니다. --
       X_RESULT_MSG    := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F,'INV_10030', '&&PERIOD:=' || P_PERIOD_NAME);
       RETURN;
   END IF;
   
   ---------------------
   -- 마감처리        --
   ---------------------
   BEGIN
         UPDATE INV_CLOSE_PERIOD  P
            SET P.ADJUST_CLOSE_FLAG      = 'Y'
              , P.ADJUST_CLOSE_DATE      = V_LOCAL_DATE
              , P.ADJUST_CLOSE_PERSON_ID = EAPP_COMMON_G.GET_PERSON_ID_BY_USER(P_USER_ID)
          WHERE P.SOB_ID             = P_SOB_ID
            AND P.ORG_ID             = P_ORG_ID
            AND P.PERIOD_NAME        = P_PERIOD_NAME
            AND P.CLOSE_TYPE         = 'WIP_OUT_ADJ'
          ;
   EXCEPTION WHEN OTHERS THEN
        X_RESULT_MSG := 'WIP OUT Adjustment close Error : ' || SQLERRM;
        RETURN;
   END;
   
   X_RESULT_STATUS := 'S';
                      -- 마감처리가 완료되었습니다. --
   X_RESULT_MSG    := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F,'INV_10031', NULL);

EXCEPTION WHEN OTHERS THEN
    X_RESULT_STATUS := 'F';          
END ADJUST_CLOSE;


------------------------
-- 정산마감취소       --
------------------------
PROCEDURE ADJUST_CLOSE_CANCEL  ( P_SOB_ID              IN  NUMBER
                               , P_ORG_ID              IN  NUMBER
                               , P_PERIOD_NAME         IN  VARCHAR2
                               , X_RESULT_STATUS       OUT VARCHAR2
                               , X_RESULT_MSG          OUT VARCHAR2
                               )
IS
  
  V_CLOSE_FLAG            VARCHAR2(1);
  V_SLIP_TRANSFER_FLAG    VARCHAR2(1);
  V_TRX_LOCK_FLAG         VARCHAR2(1); -- ADDED, 2012-09-17, BY MJSHIN --
BEGIN
   X_RESULT_STATUS := 'F';
   
   ------------------------------------
   -- 기마감여부, 회계전송여부 CHECK --
   ------------------------------------
   BEGIN
        SELECT NVL(P.ADJUST_CLOSE_FLAG,'N') 
             , NVL(P.SLIP_TRANSFER_FLAG,'N')
             , NVL(P.TRX_LOCK_FLAG,'N')
          INTO V_CLOSE_FLAG
             , V_SLIP_TRANSFER_FLAG
             , V_TRX_LOCK_FLAG
          FROM INV_CLOSE_PERIOD  P
         WHERE P.SOB_ID          = P_SOB_ID  
           AND P.ORG_ID          = P_ORG_ID
           AND P.PERIOD_NAME     = P_PERIOD_NAME
           AND P.CLOSE_TYPE      = 'WIP_OUT_ADJ'
           ;
   EXCEPTION WHEN OTHERS THEN
        V_CLOSE_FLAG         := 'N';
        V_SLIP_TRANSFER_FLAG := 'N';
        V_TRX_LOCK_FLAG      := 'N';
   END;
   
   IF V_CLOSE_FLAG = 'N' THEN
                          -- &&PERIOD 은(는) 아직 마감되지 않아 마감취소처리를 진행할 수 없습니다. 확인 후 재처리 바랍니다. --
       X_RESULT_MSG    := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F,'INV_10032', '&&PERIOD:=' || P_PERIOD_NAME);
       RETURN;
   END IF;

   IF V_SLIP_TRANSFER_FLAG = 'Y' THEN
                          -- &&PERIOD 은(는) 이미 회계전송되어 마감취소처리를 진행할 수 없습니다. 확인 후 재처리 바랍니다. --
       X_RESULT_MSG    := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F,'INV_10033', '&&PERIOD:=' || P_PERIOD_NAME);
       RETURN;     
   END IF;   
   
   IF V_TRX_LOCK_FLAG = 'Y' THEN  -- ADDED, 2012-09-17, BY MJSHIN --
                          -- &&PERIOD 은(는) 수불 LOCK이 설정되어 마감취소처리를 진행할 수 없습니다. 재경팀에 확인 후 재처리 바랍니다. --
       X_RESULT_MSG    := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F,'INV_10069', '&&PERIOD:=' || P_PERIOD_NAME);
       RETURN;     
   END IF;   
      
   ---------------------
   -- 마감취소처리    --
   ---------------------
   BEGIN
         UPDATE INV_CLOSE_PERIOD  P
            SET P.ADJUST_CLOSE_FLAG      = 'N'
              , P.ADJUST_CLOSE_DATE      = NULL
              , P.ADJUST_CLOSE_PERSON_ID = NULL
          WHERE P.SOB_ID             = P_SOB_ID
            AND P.ORG_ID             = P_ORG_ID
            AND P.PERIOD_NAME        = P_PERIOD_NAME
            AND P.CLOSE_TYPE         = 'WIP_OUT_ADJ'
          ;
   EXCEPTION WHEN OTHERS THEN
        X_RESULT_MSG := 'WIP OUT Adjustment close Error : ' || SQLERRM;
        RETURN;
   END;
   
   X_RESULT_STATUS := 'S';
                       -- 마감 취소 처리가 완료되었습니다. --
   X_RESULT_MSG    := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F,'INV_10050', NULL);

EXCEPTION WHEN OTHERS THEN
    X_RESULT_STATUS := 'F';          
END ADJUST_CLOSE_CANCEL;



------------------------
-- 회계전송           --
------------------------
PROCEDURE SLIP_TRANSFER  ( P_SOB_ID              IN  NUMBER
                         , P_ORG_ID              IN  NUMBER
                         , P_PERIOD_NAME         IN  NUMBER
                         , X_RESULT_STATUS       OUT VARCHAR2
                         , X_RESULT_MSG          OUT VARCHAR2
                         )
IS
  
  V_CLOSE_FLAG            VARCHAR2(1);
  V_SLIP_TRANSFER_FLAG    VARCHAR2(1);
BEGIN
   X_RESULT_STATUS := 'F';
   
   
   
   X_RESULT_STATUS := 'S';
   X_RESULT_MSG    := 'Not Defined';  --EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F,'INV_10031', NULL);

EXCEPTION WHEN OTHERS THEN
    X_RESULT_STATUS := 'F';          
END SLIP_TRANSFER;


------------------------
-- 회계전송 취소      --
------------------------
PROCEDURE SLIP_TRANSFER_CANCEL ( P_SOB_ID              IN  NUMBER
                               , P_ORG_ID              IN  NUMBER
                               , P_PERIOD_NAME         IN  NUMBER
                               , X_RESULT_STATUS       OUT VARCHAR2
                               , X_RESULT_MSG          OUT VARCHAR2
                               )
IS
  
  V_CLOSE_FLAG            VARCHAR2(1);
  V_SLIP_TRANSFER_FLAG    VARCHAR2(1);
BEGIN
   X_RESULT_STATUS := 'F';
   
   
   
   X_RESULT_STATUS := 'S';
   X_RESULT_MSG    := 'Not Defined';  --EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F,'INV_10031', NULL);

EXCEPTION WHEN OTHERS THEN
    X_RESULT_STATUS := 'F';          
END SLIP_TRANSFER_CANCEL;


------------------------
-- TRX_SUMMARY_SELECT --
------------------------
PROCEDURE TRX_SUMMARY_SELECT ( P_SOB_ID                 IN  NUMBER
                             , P_ORG_ID                 IN  NUMBER
                             , P_PERIOD_NAME            IN  VARCHAR2
                             , P_SUPPLIER_ID            IN  NUMBER
                             , P_WORKCENTER_ID          IN  NUMBER
                             , P_ADJUST_DATE_FR         IN  DATE
                             , P_ADJUST_DATE_TO         IN  DATE
                             , X_ADJUST_AMOUNT          OUT NUMBER
                             , X_RESULT_STATUS          OUT VARCHAR2
                             , X_RESULT_MSG             OUT VARCHAR2
                             )
IS
   V_ADJUST_DATE_FR   DATE;
   V_ADJUST_DATE_TO   DATE;
   V_START_TIME       VARCHAR2(20);
   V_END_TIME         VARCHAR2(20);   
BEGIN
  
     BEGIN
          SELECT ELE.ENTRY_TAG
            INTO V_START_TIME
            FROM EAPP_LOOKUP_ENTRY  ELE
           WHERE ELE.SOB_ID         = P_SOB_ID
             AND ELE.ORG_ID         = P_ORG_ID
             AND ELE.LOOKUP_TYPE    = 'COST_PERIOD_TIME_ZONE'
             AND ELE.ENTRY_CODE     = 'START'
          ;
     EXCEPTION WHEN OTHERS THEN
          V_START_TIME := '08:30:00';         
     END;
       
     BEGIN
          SELECT ELE.ENTRY_TAG
            INTO V_END_TIME
            FROM EAPP_LOOKUP_ENTRY  ELE
           WHERE ELE.SOB_ID         = P_SOB_ID
             AND ELE.ORG_ID         = P_ORG_ID
             AND ELE.LOOKUP_TYPE    = 'COST_PERIOD_TIME_ZONE'
             AND ELE.ENTRY_CODE     = 'END'
          ;
     EXCEPTION WHEN OTHERS THEN
          V_START_TIME := '08:29:59';         
     END;
       

     V_ADJUST_DATE_FR := TO_DATE(TO_CHAR(P_ADJUST_DATE_FR,'YYYY-MM-DD') || ' ' || V_START_TIME , 'YYYY-MM-DD HH24:MI:SS');
     V_ADJUST_DATE_TO := TO_DATE(TO_CHAR(P_ADJUST_DATE_TO + 1,'YYYY-MM-DD') || ' ' || V_END_TIME , 'YYYY-MM-DD HH24:MI:SS');
       
     
     BEGIN
         SELECT SUM(PAT.ADJUST_AMOUNT)
           INTO X_ADJUST_AMOUNT 
           FROM WIP_OUT_ADJUST_TRX  PAT
          WHERE PAT.SOB_ID         = P_SOB_ID
            AND PAT.ORG_ID         = P_ORG_ID
            AND PAT.PERIOD_NAME    = P_PERIOD_NAME
            AND PAT.SUPPLIER_ID    = P_SUPPLIER_ID
            AND PAT.WORKCENTER_ID  = P_WORKCENTER_ID
            AND PAT.TOMOVE_TRX_DATE  BETWEEN V_ADJUST_DATE_FR
                                         AND V_ADJUST_DATE_TO
            ; 
     EXCEPTION WHEN OTHERS THEN
          X_ADJUST_AMOUNT := 0;
     END;

EXCEPTION WHEN OTHERS THEN
    X_RESULT_STATUS := 'F'; 
     
END TRX_SUMMARY_SELECT;  
                          
----------------------------------
-- TRX_HOLDING  (이월처리)      --
----------------------------------
PROCEDURE TRX_ADJUST_HOLDING ( P_SOB_ID              IN  NUMBER
                             , P_ORG_ID              IN  NUMBER
                             , P_PERIOD_NAME         IN  VARCHAR2
                             , P_ADJUST_SUPPLIER_ID  IN  NUMBER
                             , P_ADJUST_TRX_ID       IN  NUMBER
                             , P_USER_ID             IN  NUMBER
                             , X_RESULT_STATUS       OUT VARCHAR2
                             , X_RESULT_MSG          OUT VARCHAR2
                             )
IS
  V_LOCAL_DATE            DATE := GET_LOCAL_DATE(P_SOB_ID);  
  V_HOLDING_TRX_ID        NUMBER;
  V_LINE_CONFIRM_FLAG     VARCHAR2(1) := 'N';
BEGIN
  
   X_RESULT_STATUS := 'F';
   
   ------------------------------------
   -- 라인확정상태이면 이월 불가     --
   -- 2012-04-20, BY MJSHIN          --
   ------------------------------------
   BEGIN
        SELECT WAT.CONFIRM_FLAG
          INTO V_LINE_CONFIRM_FLAG
          FROM WIP_OUT_ADJUST_TRX  WAT
         WHERE WAT.ADJUST_TRX_ID   = P_ADJUST_TRX_ID
         ;
   EXCEPTION WHEN OTHERS THEN
       V_LINE_CONFIRM_FLAG := 'N';
   END;
     
   IF NVL(V_LINE_CONFIRM_FLAG,'N') = 'Y' THEN
                       -- 해당 JOB/공정 라인이 이미 확정되어 수정이나 이월처리가 불가능합니다.. 라인확정 취소후 작업하시기 바랍니다. --
       X_RESULT_MSG := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F,'WIP_10262', NULL);
       RETURN;
   END IF;   

   ---------------------
   -- 이월처리        --
   ---------------------
   FOR TRX IN (SELECT *
                 FROM WIP_OUT_ADJUST_TRX  T
                WHERE T.ADJUST_SUPPLIER_ID = P_ADJUST_SUPPLIER_ID
                  AND T.ADJUST_TRX_ID      = P_ADJUST_TRX_ID)
   LOOP
         -- ADJUST TRX TRANSFER --
         BEGIN
                DELETE WIP_OUT_ADJ_HOLDING_TRX  AHT
                 WHERE AHT.ADJUST_TRX_ID        = P_ADJUST_TRX_ID
                 ;
         EXCEPTION WHEN OTHERS THEN
              NULL;
         END;
         
         SELECT WIP_OUT_ADJ_HOLDING_TRX_S1.NEXTVAL
           INTO V_HOLDING_TRX_ID
           FROM DUAL;
         
         BEGIN
                INSERT INTO WIP_OUT_ADJ_HOLDING_TRX
                          ( HOLDING_TRX_ID
                          ,	SOB_ID
                          ,	ORG_ID
                          ,	ADJUST_SUPPLIER_ID
                          ,	ADJUST_TRX_ID
                          ,	HOLDING_PERIOD_NAME
                          ,	APPLY_PERIOD_NAME
                          ,	APPLY_FLAG
                          ,	SUPPLIER_ID
                          ,	COUNTRY_CODE
                          ,	WORKCENTER_ID
                          ,	RESOURCE_ID
                          ,	OWNER_TYPE_LCODE
                          ,	JOB_ID
                          ,	JOB_NO
                          ,	INVENTORY_ITEM_ID
                          ,	BOM_ITEM_ID
                          ,	ITEM_SECTION_CODE
                          ,	PNL_SIZE_X
                          ,	PNL_SIZE_Y
                          ,	PCS_PER_PNL_QTY
                          ,	PCS_PER_MM_QTY
                          , PCS_PER_ARRAY_QTY
                          ,	OPERATION_SEQ_NO
                          ,	OPERATION_ID
                          ,	ITEM_UOM_CODE
                          ,	RECEIPT_UOM_QTY
                          ,	RECEIPT_PNL_QTY
                          ,	RECEIPT_ARRAY_QTY
                          ,	RECEIPT_PCS_QTY
                          ,	RUN_END_UOM_QTY
                          ,	RUN_END_PNL_QTY
                          ,	RUN_END_ARRAY_QTY
                          ,	RUN_END_PCS_QTY
                          ,	TOMOVE_UOM_QTY
                          ,	TOMOVE_PNL_QTY
                          ,	TOMOVE_ARRAY_QTY
                          ,	TOMOVE_PCS_QTY
                          ,	TOMOVE_MM_QTY
                          ,	REJECT_UOM_QTY
                          ,	REJECT_PNL_QTY
                          ,	REJECT_ARRAY_QTY
                          ,	REJECT_PCS_QTY
                          ,	REJECT_MM_QTY
                          ,	ADJUST_UOM_QTY
                          ,	ADJUST_PNL_QTY
                          ,	ADJUST_ARRAY_QTY
                          ,	ADJUST_PCS_QTY
                          ,	ADJUST_MM_QTY
                          ,	TOMOVE_TRX_ID
                          ,	TOMOVE_TRX_DATE
                          ,	REJECT_TRX_ID
                          ,	REJECT_TRX_DATE
                          ,	CAL_CURRENCY_CODE
                          ,	CAL_PRICE
                          ,	CAL_AMOUNT
                          ,	LOW_LIMIT_AMOUNT
                          ,	HIGH_LIMIT_AMOUNT
                          ,	LOW_LIMIT_PRICE_UOM
                          ,	LOW_LIMIT_PRICE
                          ,	SETTING_FEE_AMOUNT
                          ,	SETTING_LIMIT_HOUR
                          ,	ADJUST_CURRENCY_CODE
                          ,	ADJUST_EXCHANGE_RATE
                          ,	ADJUST_PRICE
                          ,	ADJUST_AMOUNT
                          ,	RESULT_FLAG
                          ,	CREATION_DATE
                          ,	CREATED_BY
                          ,	LAST_UPDATE_DATE
                          ,	LAST_UPDATED_BY
                          )
                     VALUES
                          ( V_HOLDING_TRX_ID  -- HOLDING_ADJUST_ID
                          ,	P_SOB_ID
                          ,	P_ORG_ID
                          ,	TRX.ADJUST_SUPPLIER_ID
                          ,	TRX.ADJUST_TRX_ID
                          ,	TRX.PERIOD_NAME                    -- HOLDING_PERIOD_NAME
                          ,	NULL                               -- APPLY_PERIOD_NAME
                          ,	'N'                                -- TRX.APPLY_FLAG
                          ,	TRX.SUPPLIER_ID
                          ,	TRX.COUNTRY_CODE
                          ,	TRX.WORKCENTER_ID
                          ,	TRX.RESOURCE_ID
                          ,	TRX.OWNER_TYPE_LCODE
                          ,	TRX.JOB_ID
                          ,	TRX.JOB_NO
                          ,	TRX.INVENTORY_ITEM_ID
                          ,	TRX.BOM_ITEM_ID
                          ,	TRX.ITEM_SECTION_CODE
                          ,	TRX.PNL_SIZE_X
                          ,	TRX.PNL_SIZE_Y
                          ,	TRX.PCS_PER_PNL_QTY
                          ,	TRX.PCS_PER_MM_QTY
                          , TRX.PCS_PER_ARRAY_QTY
                          ,	TRX.OPERATION_SEQ_NO
                          , TRX.ORIGINAL_OPERATION_ID  --	TRX.OPERATION_ID
                          ,	TRX.ITEM_UOM_CODE
                          ,	TRX.RECEIPT_UOM_QTY
                          ,	TRX.RECEIPT_PNL_QTY
                          ,	TRX.RECEIPT_ARRAY_QTY
                          ,	TRX.RECEIPT_PCS_QTY
                          ,	TRX.RUN_END_UOM_QTY
                          ,	TRX.RUN_END_PNL_QTY
                          ,	TRX.RUN_END_ARRAY_QTY
                          ,	TRX.RUN_END_PCS_QTY
                          ,	TRX.TOMOVE_UOM_QTY
                          ,	TRX.TOMOVE_PNL_QTY
                          ,	TRX.TOMOVE_ARRAY_QTY
                          ,	TRX.TOMOVE_PCS_QTY
                          ,	TRX.TOMOVE_MM_QTY
                          ,	TRX.REJECT_UOM_QTY
                          ,	TRX.REJECT_PNL_QTY
                          ,	TRX.REJECT_ARRAY_QTY
                          ,	TRX.REJECT_PCS_QTY
                          ,	TRX.REJECT_MM_QTY
                          ,	TRX.ADJUST_UOM_QTY
                          ,	TRX.ADJUST_PNL_QTY
                          ,	TRX.ADJUST_ARRAY_QTY
                          ,	TRX.ADJUST_PCS_QTY
                          ,	TRX.ADJUST_MM_QTY
                          ,	TRX.TOMOVE_TRX_ID
                          ,	TRX.TOMOVE_TRX_DATE
                          ,	TRX.REJECT_TRX_ID
                          ,	TRX.REJECT_TRX_DATE
                          ,	TRX.CAL_CURRENCY_CODE
                          ,	TRX.CAL_PRICE
                          ,	TRX.CAL_AMOUNT
                          ,	TRX.LOW_LIMIT_AMOUNT
                          ,	TRX.HIGH_LIMIT_AMOUNT
                          ,	TRX.LOW_LIMIT_PRICE_UOM
                          ,	TRX.LOW_LIMIT_PRICE
                          ,	TRX.SETTING_FEE_AMOUNT
                          ,	TRX.SETTING_LIMIT_HOUR
                          ,	TRX.ADJUST_CURRENCY_CODE
                          ,	TRX.ADJUST_EXCHANGE_RATE
                          ,	TRX.ADJUST_PRICE
                          ,	TRX.ADJUST_AMOUNT
                          ,	TRX.RESULT_FLAG
                          , V_LOCAL_DATE                       --	CREATION_DATE
                          , P_USER_ID                          --	CREATED_BY
                          , V_LOCAL_DATE                       --	LAST_UPDATE_DATE
                          , P_USER_ID                          --	LAST_UPDATED_BY
                          );
         EXCEPTION WHEN OTHERS THEN
              X_RESULT_MSG := 'Transaction Holding Transfer Error : ' || SQLERRM;
              RETURN;
         END;
         
         
         -- ADJUST SPEC TRANSFER --
         BEGIN
              DELETE WIP_OUT_ADJ_HOLDING_SPEC AHS
               WHERE AHS.ADJUST_TRX_ID        = P_ADJUST_TRX_ID
               ;
         EXCEPTION WHEN OTHERS THEN
              NULL;
         END;
         
         FOR SPEC IN (SELECT *
                        FROM WIP_OUT_ADJUST_SPEC  S
                       WHERE S.ADJUST_TRX_ID           = P_ADJUST_TRX_ID)
         LOOP
               BEGIN
                    INSERT INTO WIP_OUT_ADJ_HOLDING_SPEC
                              ( HOLDING_SPEC_ID
                              ,	SOB_ID
                              ,	ORG_ID
                              , HOLDING_TRX_ID
                              ,	ADJUST_SUPPLIER_ID
                              ,	ADJUST_TRX_ID
                              ,	ADJUST_SPEC_ID
                              ,	HOLDING_PERIOD_NAME
                              ,	OP_WORK_ID
                              ,	OP_SPEC_ID
                              ,	OP_SPEC_VALUE
                              ,	OP_SPEC_UOM_CODE
                              ,	OUT_PRICE_ID
                              ,	PRICE_CLASS
                              ,	PRICE_TYPE_LCODE
                              ,	CURRENCY_CODE
                              ,	BASIC_PRICE
                              ,	BASIC_AMOUNT
                              ,	OUT_PRICE
                              ,	OUT_AMOUNT
                              ,	LOW_LIMIT_AMOUNT
                              ,	HIGH_LIMIT_AMOUNT
                              ,	LOW_LIMIT_PRICE_UOM
                              ,	LOW_LIMIT_PRICE
                              ,	SETTING_FEE_AMOUNT
                              ,	SETTING_LIMIT_HOUR
                              ,	PRICE_APPLY_TYPE_LCODE
                              ,	CREATION_DATE
                              ,	CREATED_BY
                              ,	LAST_UPDATE_DATE
                              ,	LAST_UPDATED_BY
                              )           
                              VALUES
                              ( WIP_OUT_ADJ_HOLDING_SPEC_S1.NEXTVAL   -- HOLDING_SPEC_ID
                              , SPEC.SOB_ID                            --	SOB_ID
                              , SPEC.ORG_ID                            --	ORG_ID
                              , V_HOLDING_TRX_ID                       -- HOLDING_TRX_ID
                              , SPEC.ADJUST_SUPPLIER_ID                --	ADJUST_SUPPLIER_ID
                              ,	SPEC.ADJUST_TRX_ID
                              ,	SPEC.ADJUST_SPEC_ID
                              ,	SPEC.PERIOD_NAME                       -- HOLDING_PERIOD_NAME
                              ,	SPEC.OP_WORK_ID
                              ,	SPEC.OP_SPEC_ID
                              ,	SPEC.OP_SPEC_VALUE
                              ,	SPEC.OP_SPEC_UOM_CODE
                              ,	SPEC.OUT_PRICE_ID
                              ,	SPEC.PRICE_CLASS
                              ,	SPEC.PRICE_TYPE_LCODE
                              ,	SPEC.CURRENCY_CODE
                              ,	SPEC.BASIC_PRICE
                              ,	SPEC.BASIC_AMOUNT
                              ,	SPEC.OUT_PRICE
                              ,	SPEC.OUT_AMOUNT
                              ,	SPEC.LOW_LIMIT_AMOUNT
                              ,	SPEC.HIGH_LIMIT_AMOUNT
                              ,	SPEC.LOW_LIMIT_PRICE_UOM
                              ,	SPEC.LOW_LIMIT_PRICE
                              ,	SPEC.SETTING_FEE_AMOUNT
                              ,	SPEC.SETTING_LIMIT_HOUR
                              ,	SPEC.PRICE_APPLY_TYPE_LCODE
                              , V_LOCAL_DATE                           --	CREATION_DATE
                              , P_USER_ID                              --	CREATED_BY
                              , V_LOCAL_DATE                           --	LAST_UPDATE_DATE
                              , P_USER_ID                              --	LAST_UPDATED_BY
                              );
                    
               EXCEPTION WHEN OTHERS THEN
                    X_RESULT_MSG := 'SPEC Holding Transfer Error : ' || SQLERRM;
                    RETURN;
               END;
         
         END LOOP;  -- SPEC --
         
         
         --------------------------------
         -- 정산내역에서 해당 TRX 삭제 --
         --------------------------------
         -- SPEC DELETE --
         BEGIN
              DELETE WIP_OUT_ADJUST_SPEC  SPEC
               WHERE SPEC.ADJUST_TRX_ID   = TRX.ADJUST_TRX_ID
               ;
         EXCEPTION WHEN OTHERS THEN
              X_RESULT_MSG := 'Transaction Spec Delete Error : ' || SQLERRM;
              RETURN;
         END;
         
         -- TRX DELETE --
         BEGIN
              DELETE WIP_OUT_ADJUST_TRX  OAT
               WHERE OAT.ADJUST_TRX_ID   = TRX.ADJUST_TRX_ID
               ;
         EXCEPTION WHEN OTHERS THEN
              X_RESULT_MSG := 'Transaction Line Delete Error : ' || SQLERRM;
              RETURN;
         END;
         
   END LOOP;

   -----------------------------
   -- 구매처별 집계내역 생성  --
   -----------------------------
   BEGIN
       SUPPLIER_ADJUST_COUNT ( P_PERIOD_NAME         => P_PERIOD_NAME
                             , P_ADJUST_SUPPLIER_ID  => P_ADJUST_SUPPLIER_ID
                             , X_RESULT_STATUS       => X_RESULT_STATUS
                             , X_RESULT_MSG          => X_RESULT_MSG
                             );
   EXCEPTION WHEN OTHERS THEN
        X_RESULT_MSG := 'Supplier Trx Count Update Error : ' || SQLERRM;
        RETURN;
   END;
   
   X_RESULT_STATUS := 'S';
                      -- 외주 TRX 라인별 이월처리가 완료되었습니다. --
   X_RESULT_MSG    := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F,'WIP_10198', NULL);

EXCEPTION WHEN OTHERS THEN
    X_RESULT_STATUS := 'F';          
END TRX_ADJUST_HOLDING;


-----------------------------------------------------------
-- SPEC_AMT_APPLY_TO_TRX (SPEC내역을 TRX에 반영)         --
-- 공정별 단가 반영 (2011-11-15, BY MJSHIN)              --
-----------------------------------------------------------
PROCEDURE SPEC_AMT_APPLY_TO_TRX  ( P_ADJUST_TRX_ID       IN  NUMBER
                                 , X_RESULT_STATUS       OUT VARCHAR2
                                 , X_RESULT_MSG          OUT VARCHAR2
                                 )
IS
  V_SYSTEM_CURRENCY_CODE  VARCHAR2(50);
  
  -- SPEC SUMMARY 변수 ----------------
  V_SUM_CAL_CURRENCY_CODE     VARCHAR2(50);
  V_SUM_CAL_PRICE             NUMBER;
  V_SUM_CAL_AMOUNT            NUMBER;
  V_SUM_ADJUST_CURRENCY_CODE  VARCHAR2(50);
  V_SUM_ADJUST_EXCHANGE_RATE  NUMBER;
  V_SUM_ADJUST_PRICE          NUMBER;
  V_SUM_ADJUST_AMOUNT         NUMBER;    
  
  -- 연속공정 미지급 변수 ---------------
  V_CNT                       NUMBER := 0;
  V_APPLY_FLAG                VARCHAR2(1);
  V_EXCEPT_CNT                NUMBER := 0;
  
  V_RESULT_FLAG               VARCHAR2(50);     
  V_ADJUST_UOM_QTY            NUMBER;
  V_SOB_ID                    NUMBER;
  V_ORG_ID                    NUMBER;  
  
  V_PERIOD_NAME               VARCHAR2(50);
  V_ADJUST_SUPPLIER_ID        NUMBER;
  
  -- 공정단가 적용 변수 -----------------
  V_OPERATION_ID              NUMBER;
  V_OP_PRICE_APPLY_FLAG       VARCHAR2(1);
/*  V_OP_PRICE                  NUMBER;
  V_OP_LOW_LIMIT_AMT          NUMBER;
  V_OP_HIGH_LIMIT_AMT         NUMBER;
  V_OP_LOW_LIMIT_PRICE        NUMBER;
  V_OP_LOW_LIMIT_PRICE_UOM    VARCHAR2(50);*/


  -- 외주단가 변수 -------------------
  V_PRICE_CLASS           VARCHAR2(50);
  V_PRICE_TYPE_LCODE      VARCHAR2(50);
  V_PRICE_TYPE_DESC       VARCHAR2(200);
  
  V_CURRENCY_CODE         VARCHAR2(50);
  V_OUT_PRICE_UOM         VARCHAR2(50);
  V_OUT_PRICE             NUMBER := 0;
  V_OP_PRICE_ID           NUMBER;
  V_OUT_AMOUNT            NUMBER := 0;
  V_LOW_LIMIT_AMOUNT      NUMBER := 0;   
  V_HIGH_LIMIT_AMOUNT     NUMBER := 0;
  V_LOW_LIMIT_PRICE_UOM   VARCHAR2(50);
  V_LOW_LIMIT_PRICE       NUMBER := 0;
  V_SETTING_FEE_AMOUNT    NUMBER := 0;
  V_SETTING_LIMIT_HOUR    NUMBER;  

  V_ADJUST_PRICE_TYPE_LCODE    VARCHAR2(50);
  V_OP_PRICE_APPLY_TYPE_LCODE  VARCHAR2(50);
     
  V_OP_PRICE_CNT          NUMBER := 0;
  
  V_ARRAY_PER_PNL_QTY     NUMBER := 0;
  V_MAX_ARRAY_QTY         NUMBER := 0;
  
BEGIN
  
   X_RESULT_STATUS := 'F';
   
   
   
   -- ADJUST UOM QTY --
   BEGIN
        SELECT OAT.ADJUST_UOM_QTY
             , OAT.SOB_ID
             , OAT.PERIOD_NAME
             , OAT.ADJUST_SUPPLIER_ID
             , OAT.OPERATION_ID
             , OAT.ORG_ID
          INTO V_ADJUST_UOM_QTY
             , V_SOB_ID
             , V_PERIOD_NAME
             , V_ADJUST_SUPPLIER_ID
             , V_OPERATION_ID
             , V_ORG_ID
          FROM WIP_OUT_ADJUST_TRX OAT
         WHERE OAT.ADJUST_TRX_ID  = P_ADJUST_TRX_ID
         ;
   EXCEPTION WHEN OTHERS THEN
       V_ADJUST_UOM_QTY := 0;
   END;

   -- 시스템 기준 통화 SELECT --
   V_SYSTEM_CURRENCY_CODE := FI_ACCOUNT_BOOK_G.BASE_CURRENCY_F(V_SOB_ID);
   
   IF V_SYSTEM_CURRENCY_CODE IS NULL THEN
        V_SYSTEM_CURRENCY_CODE := 'KRW';
   END IF;
   
          
   ---------------------------------------------
   -- SPEC별 집계 내역 SELECT                 --
   ---------------------------------------------
   BEGIN
        SELECT SUM(OSP.BASIC_AMOUNT)
             , SUM(OSP.OUT_AMOUNT)
          INTO V_SUM_CAL_AMOUNT
             , V_SUM_ADJUST_AMOUNT
          FROM WIP_OUT_ADJUST_SPEC  OSP
         WHERE OSP.ADJUST_TRX_ID    = P_ADJUST_TRX_ID
         ;
   EXCEPTION WHEN OTHERS THEN
        V_SUM_CAL_AMOUNT           := 0;
        V_SUM_ADJUST_AMOUNT        := 0;
   END;

   V_SUM_ADJUST_CURRENCY_CODE := V_SYSTEM_CURRENCY_CODE;           
   V_SUM_CAL_CURRENCY_CODE    := V_SUM_ADJUST_CURRENCY_CODE;
   V_SUM_ADJUST_EXCHANGE_RATE := 1;
   
   ------------------------------
   -- 연속공정 여부 CHECK      --
   ------------------------------
   IF V_SUM_CAL_PRICE IS NULL THEN
       BEGIN
            SELECT COUNT(*)
              INTO V_EXCEPT_CNT
              FROM WIP_OUT_ADJUST_SPEC OSP
             WHERE OSP.ADJUST_TRX_ID   = P_ADJUST_TRX_ID
               AND OSP.PRICE_APPLY_TYPE_LCODE = 'EXCEPT_OPERATION'
               ;
       EXCEPTION WHEN OTHERS THEN
           V_EXCEPT_CNT := 0;
       END;
   END IF;
                  
   -------------------------------------
   -- OPERATION 단가 여부 체크        --
   -------------------------------------
   BEGIN
        SELECT COUNT(*)
          INTO V_OP_PRICE_CNT
          FROM WIP_OUT_OP_PRICE_LIST  OPL
         WHERE OPL.OPERATION_ID       = V_OPERATION_ID
         ;
   EXCEPTION WHEN OTHERS THEN
        V_OP_PRICE_CNT := 0;
   END;

   ------------------------------------------------------------
   -- 연속공정 제외공정이 아니고, 공정단가가 존재할 경우     --
   -- 공정단가 산출                                          --
   ------------------------------------------------------------
   IF NVL(V_OP_PRICE_CNT,0) > 0 AND NVL(V_EXCEPT_CNT,0) = 0 THEN
     
          GET_OP_AMOUNT  ( P_SOB_ID                     => V_SOB_ID
                         , P_ORG_ID                     => V_ORG_ID
                         , P_OPERATION_ID               => V_OPERATION_ID
                         , P_ADJUST_TRX_ID              => P_ADJUST_TRX_ID
                         , P_SPEC_CAL_AMOUNT            => V_SUM_CAL_AMOUNT
                         , P_SPEC_ADJUST_AMOUNT         => V_SUM_ADJUST_AMOUNT
                         , X_CURRENCY_CODE              => V_CURRENCY_CODE
                         , X_OUT_PRICE                  => V_OUT_PRICE
                         , X_OUT_AMOUNT                 => V_OUT_AMOUNT
                         , X_LOW_LIMIT_AMOUNT           => V_LOW_LIMIT_AMOUNT
                         , X_HIGH_LIMIT_AMOUNT          => V_HIGH_LIMIT_AMOUNT
                         , X_LOW_LIMIT_PRICE_UOM        => V_LOW_LIMIT_PRICE_UOM
                         , X_LOW_LIMIT_PRICE            => V_LOW_LIMIT_PRICE
                         , X_SETTING_FEE_AMOUNT         => V_SETTING_FEE_AMOUNT
                         , X_SETTING_LIMIT_HOUR         => V_SETTING_LIMIT_HOUR
                         , X_ADJUST_PRICE_TYPE_LCODE    => V_ADJUST_PRICE_TYPE_LCODE
                         , X_OP_PRICE_APPLY_TYPE_LCODE  => V_OP_PRICE_APPLY_TYPE_LCODE
                         );
   ELSE
        V_OUT_AMOUNT := V_SUM_ADJUST_AMOUNT;                         
   END IF;
   

   IF NVL(V_ADJUST_UOM_QTY,0) != 0 THEN
       V_SUM_CAL_PRICE         := TRUNC(V_SUM_CAL_AMOUNT    / V_ADJUST_UOM_QTY,3);
       V_SUM_ADJUST_PRICE      := TRUNC(V_OUT_AMOUNT / V_ADJUST_UOM_QTY,3);
   ELSE
       V_SUM_CAL_PRICE         := 0;
       V_SUM_ADJUST_PRICE      := 0;             
   END IF;
                  

   -------------------------------------------------------
   -- 연속공정 미지급이 경우에는 상태를 'NORMAL'로 표시 --
   -------------------------------------------------------
                  
   IF V_SUM_CAL_PRICE IS NULL AND V_EXCEPT_CNT = 0 THEN
       V_RESULT_FLAG := 'ERROR';
   ELSE
       V_RESULT_FLAG := 'NORMAL';
   END IF;

   -----------------------------------------------------------------
   -- ARRAY수가 기준정보의 PNL당 ARRAY수를 초과할경우 ERROR 표시  --
   -- MAIN BASE 에만 해당, 김진영님 요청                          --
   -- 2012-10-23, BY MJSHIN                                       --
   -----------------------------------------------------------------
   FOR CHK_REC IN (SELECT *
                     FROM WIP_OUT_ADJUST_TRX T
                    WHERE T.ADJUST_TRX_ID    = P_ADJUST_TRX_ID
                      AND EXISTS (SELECT 'Y'
                                    FROM WIP_OUT_ADJUST_SPEC S
                                   WHERE S.ADJUST_TRX_ID     = T.ADJUST_TRX_ID
                                     AND S.OP_SPEC_UOM_CODE  IN ('ARRAY','BLOCK','KIT')
                                  )
                  )
   LOOP
        BEGIN -- ITEM SPEC은 MAIN BASE에만 해당됨 --
             SELECT SIS.ARRAY_PER_PNL_QTY
               INTO V_ARRAY_PER_PNL_QTY
               FROM SDM_ITEM_SPEC  SIS
              WHERE SIS.BOM_ITEM_ID = CHK_REC.BOM_ITEM_ID
             ;  
        EXCEPTION WHEN OTHERS THEN
            V_ARRAY_PER_PNL_QTY := 0;
        END;
        
        IF NVL(V_ARRAY_PER_PNL_QTY,0) != 0 AND NVL(CHK_REC.ADJUST_PNL_QTY,0) != 0 AND NVL(CHK_REC.ADJUST_ARRAY_QTY,0) != 0 THEN -- 값이 없는것은 SUB BASE로 간주함 --
            
            V_MAX_ARRAY_QTY := NVL(V_ARRAY_PER_PNL_QTY,0) * NVL(CHK_REC.ADJUST_PNL_QTY,0);
            
            IF NVL(CHK_REC.ADJUST_ARRAY_QTY,0) > V_MAX_ARRAY_QTY THEN
                 V_RESULT_FLAG := 'ERROR';
            END IF;
            
        END IF; 
   END LOOP;
   
   
   -------------------------
   -- TRX 테이블 UPDATE   --
   -------------------------               
   BEGIN
        UPDATE WIP_OUT_ADJUST_TRX  OTR
           SET OTR.CAL_CURRENCY_CODE         = V_SUM_CAL_CURRENCY_CODE
             , OTR.CAL_PRICE                 = V_SUM_CAL_PRICE
             , OTR.CAL_AMOUNT                = V_SUM_CAL_AMOUNT
             , OTR.ADJUST_CURRENCY_CODE      = V_SUM_ADJUST_CURRENCY_CODE
             , OTR.ADJUST_EXCHANGE_RATE      = V_SUM_ADJUST_EXCHANGE_RATE
             , OTR.ADJUST_PRICE              = V_SUM_ADJUST_PRICE
             , OTR.ADJUST_AMOUNT             = V_OUT_AMOUNT
             , OTR.RESULT_FLAG               = V_RESULT_FLAG
             , OTR.LOW_LIMIT_AMOUNT          = V_LOW_LIMIT_AMOUNT
             , OTR.HIGH_LIMIT_AMOUNT         = V_HIGH_LIMIT_AMOUNT
             , OTR.LOW_LIMIT_PRICE_UOM       = V_LOW_LIMIT_PRICE_UOM
             , OTR.LOW_LIMIT_PRICE           = V_LOW_LIMIT_PRICE
             , OTR.SETTING_FEE_AMOUNT        = V_SETTING_FEE_AMOUNT
             , OTR.SETTING_LIMIT_HOUR        = V_SETTING_LIMIT_HOUR
             , OTR.ADJUST_PRICE_TYPE_LCODE   = V_ADJUST_PRICE_TYPE_LCODE
             , OTR.OP_PRICE_APPLY_TYPE_LCODE = V_OP_PRICE_APPLY_TYPE_LCODE
         WHERE OTR.ADJUST_TRX_ID    = P_ADJUST_TRX_ID
         ;
   EXCEPTION WHEN OTHERS THEN
        X_RESULT_MSG := 'WIP_OUT_ADJUST_TRX Out_Amount Update Error : ' || SQLERRM;
        RETURN;
   END;
   


   -----------------------------
   -- 구매처별 집계내역 생성  --
   -----------------------------
   BEGIN
       SUPPLIER_ADJUST_COUNT ( P_PERIOD_NAME         => V_PERIOD_NAME
                             , P_ADJUST_SUPPLIER_ID  => V_ADJUST_SUPPLIER_ID
                             , X_RESULT_STATUS       => X_RESULT_STATUS
                             , X_RESULT_MSG          => X_RESULT_MSG
                             );
   EXCEPTION WHEN OTHERS THEN
        X_RESULT_MSG := 'Supplier Trx Count Update Error : ' || SQLERRM;
        RETURN;
   END;
      
   X_RESULT_STATUS := 'S';

EXCEPTION WHEN OTHERS THEN
    X_RESULT_STATUS := 'F';          
END SPEC_AMT_APPLY_TO_TRX;


-----------------------------------------------------------
-- SUPPLIER_ADJUST_COUNT (외주처별 집계내역 생성)        --
-----------------------------------------------------------
PROCEDURE SUPPLIER_ADJUST_COUNT  ( P_PERIOD_NAME         IN  VARCHAR2
                                 , P_ADJUST_SUPPLIER_ID  IN  NUMBER
                                 , X_RESULT_STATUS       OUT VARCHAR2
                                 , X_RESULT_MSG          OUT VARCHAR2
                                 )
IS
 
  V_TARGET_COUNT          NUMBER := 0;
  V_ADJUST_COUNT          NUMBER := 0;
  V_REMAIN_COUNT          NUMBER := 0;
  
  V_NORMAL_TRX_COUNT      NUMBER := 0;
  V_HOLDING_IN_COUNT      NUMBER := 0;
  V_HOLDING_OUT_COUNT     NUMBER := 0;
  V_ADJUST_AMOUNT         NUMBER := 0;
BEGIN
  
   X_RESULT_STATUS := 'F';
   
   -----------------------------
   -- 외주처별 집계내역 생성  --
   -----------------------------
   -- NORMAL_TRX_COUNT / HOLDING_IN_COUNT
   BEGIN
        SELECT SUM(CASE WHEN NVL(OAT.HOLDING_IN_FLAG,'N') = 'N' THEN 1 ELSE 0 END) AS NORMAL_TRX_CNT
             , SUM(CASE WHEN NVL(OAT.HOLDING_IN_FLAG,'N') = 'Y' THEN 1 ELSE 0 END) AS HOLDING_IN_CNT
          INTO V_NORMAL_TRX_COUNT
             , V_HOLDING_IN_COUNT 
          FROM WIP_OUT_ADJUST_TRX  OAT
         WHERE OAT.ADJUST_SUPPLIER_ID = P_ADJUST_SUPPLIER_ID
           ;
   EXCEPTION WHEN OTHERS THEN
        V_NORMAL_TRX_COUNT := 0;
        V_HOLDING_IN_COUNT := 0;
   END;
       
   -- HOLDING_OUT_COUNT
   BEGIN
        SELECT COUNT(*)
          INTO V_HOLDING_OUT_COUNT 
          FROM WIP_OUT_ADJ_HOLDING_TRX  OAH
         WHERE OAH.ADJUST_SUPPLIER_ID  = P_ADJUST_SUPPLIER_ID 
           AND OAH.HOLDING_PERIOD_NAME = P_PERIOD_NAME
         ;
   EXCEPTION WHEN OTHERS THEN
        V_HOLDING_OUT_COUNT := 0;
   END;
   
   -- ADJUST_COUNT / ADJUST_AMOUNT
   BEGIN
        SELECT COUNT(*)
             , SUM(PAT.ADJUST_AMOUNT)
          INTO V_ADJUST_COUNT
             , V_ADJUST_AMOUNT
          FROM WIP_OUT_ADJUST_TRX PAT
         WHERE PAT.ADJUST_SUPPLIER_ID = P_ADJUST_SUPPLIER_ID
           AND NVL(PAT.ADJUST_PRICE, -1) > -1
           ;
   EXCEPTION WHEN OTHERS THEN
       V_ADJUST_COUNT := 0;
   END;
   
   V_TARGET_COUNT := NVL(V_NORMAL_TRX_COUNT,0) + NVL(V_HOLDING_IN_COUNT,0) + NVL(V_HOLDING_OUT_COUNT,0);
   V_REMAIN_COUNT := NVL(V_TARGET_COUNT,0) - NVL(V_ADJUST_COUNT,0) - NVL(V_HOLDING_OUT_COUNT,0);
       
   BEGIN
         UPDATE WIP_OUT_ADJUST_SUPPLIER  PAS
            SET PAS.TARGET_COUNT         = V_TARGET_COUNT
              , PAS.ADJUST_COUNT         = V_ADJUST_COUNT
              , PAS.REMAIN_COUNT         = V_REMAIN_COUNT
              , PAS.HOLDING_IN_COUNT     = V_HOLDING_IN_COUNT
              , PAS.HOLDING_OUT_COUNT    = V_HOLDING_OUT_COUNT
              , PAS.ADJUST_AMOUNT        = V_ADJUST_AMOUNT
              --, PAS.SLIP_AMOUNT          = V_ADJUST_AMOUNT + PAS.MISC_AMOUNT - PAS.CLAIM_AMOUNT
              , PAS.SLIP_AMOUNT          = NVL(V_ADJUST_AMOUNT,0) + NVL(PAS.MISC_AMOUNT,0) - NVL(PAS.CLAIM_AMOUNT,0)
          WHERE PAS.ADJUST_SUPPLIER_ID   = P_ADJUST_SUPPLIER_ID
            ;
   EXCEPTION WHEN OTHERS THEN
        X_RESULT_MSG := 'WIP_OUT_ADJUST_SUPPLIER Receipt Count Update Error : ' || SQLERRM;
        RETURN;
   END;
       
   -------------------------------------------------------
   -- 입고건이 없거나 기타정산내역이 없는 외주처는 삭제 --
   -------------------------------------------------------
   BEGIN
        DELETE WIP_OUT_ADJUST_SUPPLIER  PAS
         WHERE PAS.ADJUST_SUPPLIER_ID        = P_ADJUST_SUPPLIER_ID
           AND NVL(PAS.SLIP_AMOUNT,0)        = 0       
           AND NVL(PAS.SAMPLE_SLIP_AMOUNT,0) = 0
           AND NVL(PAS.TARGET_COUNT,0)       = 0
       ;
   EXCEPTION WHEN OTHERS THEN
        X_RESULT_MSG := 'WIP_OUT_ADJUST_SUPPLIER  Not Receipt Supplier Delete Error : ' || SQLERRM;
        RETURN;
   END;
   
   X_RESULT_STATUS := 'S';

EXCEPTION WHEN OTHERS THEN
    X_RESULT_STATUS := 'F';          
END SUPPLIER_ADJUST_COUNT;

-----------------------------------------------------------
-- ADJUST_DATE_SELECT (마감년월 정산일자 범위)           --
-----------------------------------------------------------
PROCEDURE ADJUST_DATE_SELECT ( P_PERIOD_NAME         IN  VARCHAR2
                             , P_SOB_ID              IN  NUMBER
                             , P_ORG_ID              IN  NUMBER
                             , X_ADJUST_DATE_FR      OUT DATE
                             , X_ADJUST_DATE_TO      OUT DATE
                             , X_INQUIRY_DATE_FR     OUT DATE
                             , X_INQUIRY_DATE_TO     OUT DATE
                             )
IS
BEGIN 
       ------------------------------------------
       -- DATE RANGE SELECT                    --
       ------------------------------------------
       BEGIN
            SELECT CP.PERIOD_START_DATE
                 , CP.PERIOD_END_DATE - 1
              INTO X_ADJUST_DATE_FR
                 , X_ADJUST_DATE_TO 
              FROM INV_CLOSE_PERIOD   CP
             WHERE CP.SOB_ID          = P_SOB_ID
               AND CP.ORG_ID          = P_ORG_ID
               AND CP.PERIOD_NAME     = P_PERIOD_NAME
               AND CP.CLOSE_TYPE      = 'WIP_OUT_ADJ';
               
       EXCEPTION WHEN OTHERS THEN
            X_ADJUST_DATE_FR := NULL;
            X_ADJUST_DATE_TO := NULL;
       END;
       
       IF X_ADJUST_DATE_TO > GET_LOCAL_DATE(P_SOB_ID) THEN
            X_ADJUST_DATE_TO := GET_LOCAL_DATE(P_SOB_ID);
       END IF;
         
       X_INQUIRY_DATE_FR := X_ADJUST_DATE_FR;
       X_INQUIRY_DATE_TO := X_ADJUST_DATE_TO;
       
EXCEPTION WHEN OTHERS THEN
    NULL;          
END ADJUST_DATE_SELECT;


-----------------------------------------------------------
-- SPEC_BATCH_COPY (SPEC내역 일괄복사)                   --
-----------------------------------------------------------
PROCEDURE SPEC_BATCH_COPY ( P_FROM_ADJUST_TRX_ID  IN  NUMBER
                          , P_TO_ADJUST_TRX_ID    IN  NUMBER
                          , X_RESULT_STATUS       OUT VARCHAR2
                          , X_RESULT_MSG          OUT VARCHAR2
                          )
IS

  V_OUT_PRICE_ID             NUMBER;
  V_PRICE_CLASS              VARCHAR2(200);
  V_PRICE_TYPE_LCODE         VARCHAR2(200);
  V_PRICE_TYPE_DESC          VARCHAR2(200);
  V_CURRENCY_CODE            VARCHAR2(200);
  V_BASIC_PRICE              VARCHAR2(200);
  V_BASIC_AMOUNT             NUMBER;
  V_OUT_PRICE                NUMBER;
  V_OUT_AMOUNT               NUMBER;
  V_LOW_LIMIT_AMOUNT         NUMBER;
  V_HIGH_LIMIT_AMOUNT        NUMBER;
  V_LOW_LIMIT_PRICE_UOM      VARCHAR2(200);
  V_LOW_LIMIT_PRICE          NUMBER;
  V_SETTING_FEE_AMOUNT       NUMBER;
  V_SETTING_LIMIT_HOUR       NUMBER;
  V_PRICE_APPLY_TYPE_LCODE   VARCHAR2(200);
  V_PRICE_APPLY_TYPE_DESC    VARCHAR2(200);
                           
BEGIN
  
   X_RESULT_STATUS := 'F';

    -- 기등록 SPEC내역 DELETE --
    BEGIN
         DELETE WIP_OUT_ADJUST_SPEC S
          WHERE S.ADJUST_TRX_ID     = P_TO_ADJUST_TRX_ID
                    
         ;
    EXCEPTION WHEN OTHERS THEN
         X_RESULT_MSG := 'WIP_OUT_ADJUST_SPEC Previous Data Delete Error : ' || SQLERRM;
         RETURN;
    END;
           
   
   -- 복사할 SPEC SELECT --
   FOR F_SPEC IN (SELECT *
                    FROM WIP_OUT_ADJUST_SPEC  OAS
                   WHERE OAS.ADJUST_TRX_ID    = P_FROM_ADJUST_TRX_ID
                 )
   LOOP


        -- 복사될 SPEC의 금액 산출 --
        BEGIN
          GET_SPEC_AMOUNT  ( P_SOB_ID                   => F_SPEC.SOB_ID
                           , P_ORG_ID                   => F_SPEC.ORG_ID
                           , P_OP_WORK_ID               => F_SPEC.OP_WORK_ID
                           , P_OP_SPEC_ID               => F_SPEC.OP_SPEC_ID
                           , P_OP_SPEC_UOM_CODE         => F_SPEC.OP_SPEC_UOM_CODE
                           , P_OP_SPEC_VALUE            => F_SPEC.OP_SPEC_VALUE
                           , P_ADJUST_TRX_ID            => P_TO_ADJUST_TRX_ID
                           , X_OUT_PRICE_ID             => V_OUT_PRICE_ID
                           , X_PRICE_CLASS              => V_PRICE_CLASS
                           , X_PRICE_TYPE_LCODE         => V_PRICE_TYPE_LCODE
                           , X_PRICE_TYPE_DESC          => V_PRICE_TYPE_DESC
                           , X_CURRENCY_CODE            => V_CURRENCY_CODE
                           , X_BASIC_PRICE              => V_BASIC_PRICE
                           , X_BASIC_AMOUNT             => V_BASIC_AMOUNT
                           , X_OUT_PRICE                => V_OUT_PRICE
                           , X_OUT_AMOUNT               => V_OUT_AMOUNT
                           , X_LOW_LIMIT_AMOUNT         => V_LOW_LIMIT_AMOUNT
                           , X_HIGH_LIMIT_AMOUNT        => V_HIGH_LIMIT_AMOUNT
                           , X_LOW_LIMIT_PRICE_UOM      => V_LOW_LIMIT_PRICE_UOM
                           , X_LOW_LIMIT_PRICE          => V_LOW_LIMIT_PRICE
                           , X_SETTING_FEE_AMOUNT       => V_SETTING_FEE_AMOUNT
                           , X_SETTING_LIMIT_HOUR       => V_SETTING_LIMIT_HOUR
                           , X_PRICE_APPLY_TYPE_LCODE   => V_PRICE_APPLY_TYPE_LCODE
                           , X_PRICE_APPLY_TYPE_DESC    => V_PRICE_APPLY_TYPE_DESC
                           , X_RESULT_STATUS            => X_RESULT_STATUS
                           , X_RESULT_MSG               => X_RESULT_MSG
                           );
        EXCEPTION WHEN OTHERS THEN
            RETURN;
        END;       
        -- SPEC 내역 INSERT --
        BEGIN
             INSERT INTO WIP_OUT_ADJUST_SPEC
                       ( ADJUST_SPEC_ID
                       , SOB_ID 
                       , ORG_ID 
                       , ADJUST_SUPPLIER_ID 
                       , ADJUST_TRX_ID 
                       , PERIOD_NAME 
                       , OP_WORK_ID 
                       , OP_SPEC_ID 
                       , OP_SPEC_VALUE 
                       , OP_SPEC_UOM_CODE 
                       , OUT_PRICE_ID 
                       , PRICE_CLASS 
                       , PRICE_TYPE_LCODE 
                       , CURRENCY_CODE 
                       , BASIC_PRICE 
                       , BASIC_AMOUNT 
                       , OUT_PRICE 
                       , OUT_AMOUNT 
                       , LOW_LIMIT_AMOUNT 
                       , HIGH_LIMIT_AMOUNT 
                       , LOW_LIMIT_PRICE_UOM 
                       , LOW_LIMIT_PRICE 
                       , SETTING_FEE_AMOUNT 
                       , SETTING_LIMIT_HOUR 
                       , PRICE_APPLY_TYPE_LCODE 
                       , CREATION_DATE 
                       , CREATED_BY 
                       , LAST_UPDATE_DATE 
                       , LAST_UPDATED_BY 
                       )
                  VALUES
                       ( WIP_OUT_ADJUST_SPEC_S1.NEXTVAL  -- ADJUST_SPEC_ID
                       , F_SPEC.SOB_ID 
                       , F_SPEC.ORG_ID 
                       , F_SPEC.ADJUST_SUPPLIER_ID 
                       , P_TO_ADJUST_TRX_ID 
                       , F_SPEC.PERIOD_NAME 
                       , F_SPEC.OP_WORK_ID 
                       , F_SPEC.OP_SPEC_ID 
                       , F_SPEC.OP_SPEC_VALUE 
                       , F_SPEC.OP_SPEC_UOM_CODE 
                       , V_OUT_PRICE_ID                  -- F_SPEC.OUT_PRICE_ID 
                       , V_PRICE_CLASS                   -- F_SPEC.PRICE_CLASS 
                       , V_PRICE_TYPE_LCODE              -- F_SPEC.PRICE_TYPE_LCODE 
                       , V_CURRENCY_CODE                 -- F_SPEC.CURRENCY_CODE 
                       , V_BASIC_PRICE                   -- F_SPEC.BASIC_PRICE 
                       , V_BASIC_AMOUNT                  -- F_SPEC.BASIC_AMOUNT 
                       , V_OUT_PRICE                     -- F_SPEC.OUT_PRICE 
                       , V_OUT_AMOUNT                    -- F_SPEC.OUT_AMOUNT 
                       , V_LOW_LIMIT_AMOUNT              -- F_SPEC.LOW_LIMIT_AMOUNT 
                       , V_HIGH_LIMIT_AMOUNT             -- F_SPEC.HIGH_LIMIT_AMOUNT 
                       , V_LOW_LIMIT_PRICE_UOM           -- F_SPEC.LOW_LIMIT_PRICE_UOM 
                       , V_LOW_LIMIT_PRICE               -- F_SPEC.LOW_LIMIT_PRICE 
                       , V_SETTING_FEE_AMOUNT            -- F_SPEC.SETTING_FEE_AMOUNT 
                       , V_SETTING_LIMIT_HOUR            -- F_SPEC.SETTING_LIMIT_HOUR 
                       , V_PRICE_APPLY_TYPE_LCODE        -- F_SPEC.PRICE_APPLY_TYPE_LCODE 
                       , F_SPEC.CREATION_DATE 
                       , F_SPEC.CREATED_BY 
                       , F_SPEC.LAST_UPDATE_DATE 
                       , F_SPEC.LAST_UPDATED_BY 
                       );
        EXCEPTION WHEN OTHERS THEN
             X_RESULT_MSG := 'WIP_OUT_ADJUST_SPEC Apply Data Insert Error : ' || SQLERRM;
             RETURN;
        END;  
                      
   END LOOP;   
   
   -- SPEC 데이터 TRX반영 --
   BEGIN
        SPEC_AMT_APPLY_TO_TRX  ( P_ADJUST_TRX_ID  => P_TO_ADJUST_TRX_ID
                               , X_RESULT_STATUS  => X_RESULT_STATUS
                               , X_RESULT_MSG     => X_RESULT_MSG
                               );
   EXCEPTION WHEN OTHERS THEN
        RETURN;
   END;
   
   X_RESULT_STATUS := 'S';

EXCEPTION WHEN OTHERS THEN
    X_RESULT_STATUS := 'F';          
END SPEC_BATCH_COPY;


--------------------------------------------
-- LU_CLOSE_PERIOD : PERIOD SELECT        --
--------------------------------------------
PROCEDURE LU_CLOSE_PERIOD  ( P_CURSOR                    OUT TYPES.TCURSOR
                           , W_SOB_ID                    IN  NUMBER
                           , W_ORG_ID                    IN  NUMBER
                           , W_CLOSE_TYPE                IN  VARCHAR2
                           , W_START_PERIOD              IN  EAPP_CALENDAR_YYYYMM_V.YYYYMM%TYPE DEFAULT NULL
                           , W_END_PERIOD                IN  EAPP_CALENDAR_YYYYMM_V.YYYYMM%TYPE DEFAULT NULL)
AS
  V_END_YYYYMM  VARCHAR2(7);
		
BEGIN
  V_END_YYYYMM := TO_CHAR(SYSDATE, 'YYYY-MM');
		
  OPEN P_CURSOR FOR
    SELECT CY.YYYYMM    AS PERIOD_NAME
         , TO_CHAR(ICP.PERIOD_START_DATE, 'YYYY-MM-DD HH24:MI:SS') AS PERIOD_START_DATE
         , TO_CHAR(ICP.PERIOD_END_DATE, 'YYYY-MM-DD HH24:MI:SS')   AS PERIOD_END_DATE
         , NVL(ICP.ADJUST_CLOSE_FLAG,'N')  AS ADJUST_CLOSE_FLAG
         , NVL(ICP.COST_TRANSFER_FLAG,'N') AS COST_TRANSFER_FLAG
         , NVL(ICP.COST_CLOSE_FLAG, 'N')   AS COST_CLOSE_FLAG
      FROM EAPP_CALENDAR_YYYYMM_V CY
         , INV_CLOSE_PERIOD       ICP
     WHERE ICP.SOB_ID         = W_SOB_ID
       AND ICP.ORG_ID         = W_ORG_ID
       AND ICP.CLOSE_TYPE     = NVL(W_CLOSE_TYPE, 'WIP')
       AND ICP.PERIOD_NAME    = CY.YYYYMM 
       AND CY.YYYYMM          BETWEEN NVL(W_START_PERIOD, CY.YYYYMM) 
                                  AND NVL(W_END_PERIOD, V_END_YYYYMM)
    ORDER BY CY.YYYYMM DESC
    ;                  
  
END LU_CLOSE_PERIOD;


-----------------------------------------------------------
-- 일일 정산 자동 실행 (Job Schedule)                    --
-----------------------------------------------------------
PROCEDURE ADJUST_DAILY_AUTO_RUN
IS
   V_SOB_ID        NUMBER := 25;
   V_ORG_ID        NUMBER := 251;
   
   V_PERIOD_NAME   VARCHAR2(50);
   
   V_DATETIME_FR   DATE;
   V_DATETIME_TO   DATE;
   V_START_TIME    VARCHAR2(20);
   V_END_TIME      VARCHAR2(20);
   
      
   V_RESULT_STATUS VARCHAR2(100);
   V_RESULT_MSG    VARCHAR2(4000);
BEGIN
   -- 매일 08시 40분에 자동 실행 (매월 1일은 전월 계산처리)
   IF TO_CHAR(GET_LOCAL_DATE(V_SOB_ID), 'DD') = '01' THEN
       V_PERIOD_NAME := TO_CHAR(GET_LOCAL_DATE(V_SOB_ID) - 1, 'YYYY-MM');
   ELSE
       V_PERIOD_NAME := TO_CHAR(GET_LOCAL_DATE(V_SOB_ID), 'YYYY-MM');    
   END IF;

   BEGIN
        SELECT ELE.ENTRY_TAG
          INTO V_START_TIME
          FROM EAPP_LOOKUP_ENTRY  ELE
         WHERE ELE.SOB_ID         = V_SOB_ID
           AND ELE.ORG_ID         = V_ORG_ID
           AND ELE.LOOKUP_TYPE    = 'COST_PERIOD_TIME_ZONE'
           AND ELE.ENTRY_CODE     = 'START'
        ;
   EXCEPTION WHEN OTHERS THEN
        V_START_TIME := '08:30:00';         
   END;
       
   BEGIN
        SELECT ELE.ENTRY_TAG
          INTO V_END_TIME
          FROM EAPP_LOOKUP_ENTRY  ELE
         WHERE ELE.SOB_ID         = V_SOB_ID
           AND ELE.ORG_ID         = V_ORG_ID
           AND ELE.LOOKUP_TYPE    = 'COST_PERIOD_TIME_ZONE'
           AND ELE.ENTRY_CODE     = 'END'
        ;
   EXCEPTION WHEN OTHERS THEN
        V_START_TIME := '08:29:59';         
   END;
             
   -- 전일 생산 시간 셋팅 (안정화까지 매월 1일부터 처리)
   V_DATETIME_FR := TO_DATE(V_PERIOD_NAME || '-01' || ' ' || V_START_TIME, 'YYYY-MM-DD HH24:MI:SS');
   V_DATETIME_TO := TO_DATE(TO_CHAR(GET_LOCAL_DATE(V_SOB_ID),'YYYY-MM-DD') || ' ' || V_END_TIME, 'YYYY-MM-DD HH24:MI:SS');

   SUPPLIER_CREATE( P_SOB_ID        => V_SOB_ID
                  , P_ORG_ID        => V_ORG_ID
                  , P_PERIOD_NAME   => V_PERIOD_NAME
                  , P_DATE_FR       => V_DATETIME_FR
                  , P_DATE_TO       => V_DATETIME_TO
                  , P_USER_ID       => -1
                  , X_RESULT_STATUS => V_RESULT_STATUS
                  , X_RESULT_MSG    => V_RESULT_MSG
                  );
                  
   ------------------------------------------
   -- 일자별 입고 TRX 처리                 --
   ------------------------------------------
   FOR TRX IN ( SELECT DISTINCT
                       D.JOB_ID
                     , D.OPERATION_SEQ_NO
                     , D.OPERATION_ID
                     , D.WORKCENTER_ID
                     , S.ADJUST_SUPPLIER_ID
                     , S.SUPPLIER_ID
                  FROM ( SELECT WMT.JOB_ID
                              , CASE WHEN WMT.MOVE_TRX_TYPE = 'TOMOVE' THEN WMT.FROM_OP_SEQ_NO    ELSE WMT.TO_OP_SEQ_NO     END AS OPERATION_SEQ_NO
                              , CASE WHEN WMT.MOVE_TRX_TYPE = 'TOMOVE' THEN WMT.FROM_OPERATION_ID ELSE WMT.TO_OPERATION_ID  END AS OPERATION_ID
                              , CASE WHEN WMT.MOVE_TRX_TYPE = 'TOMOVE' THEN SSR.WORKCENTER_ID     ELSE CSR.WORKCENTER_ID    END AS WORKCENTER_ID
                           FROM WIP_MOVE_TRANSACTIONS    WMT
                              , SDM_STANDARD_RESOURCE    SSR
                              , SDM_STANDARD_RESOURCE    CSR  -- CANCEL_TOMOVE 정보 JOIN --
                          WHERE SSR.RESOURCE_ID          = WMT.FROM_RESOURCE_ID
                            AND CSR.RESOURCE_ID          = WMT.TO_RESOURCE_ID
                            AND WMT.SOB_ID               = V_SOB_ID
                            AND WMT.ORG_ID               = V_ORG_ID
                            AND ( WMT.MOVE_TRX_TYPE = 'TOMOVE' OR WMT.MOVE_TRX_TYPE = 'CANCEL_TOMOVE')
                            AND WMT.MOVE_TRX_DATE   BETWEEN V_DATETIME_FR
                                                        AND V_DATETIME_TO
                            AND NOT EXISTS ( SELECT 'N'                             -- 정산내역에 없는 TRX만 생성 --
                                               FROM WIP_OUT_ADJUST_TRX  T
                                              WHERE T.SOB_ID           = V_SOB_ID
                                                AND T.ORG_ID           = V_ORG_ID
                                                AND T.JOB_ID           = WMT.JOB_ID
                                                AND T.OPERATION_SEQ_NO = WMT.FROM_OP_SEQ_NO
                                                AND T.OPERATION_ID     = WMT.FROM_OPERATION_ID
                                                AND T.CONFIRM_FLAG     = 'Y' )
                            AND NOT EXISTS ( SELECT 'N'
                                               FROM WIP_OUT_ADJ_HOLDING_TRX H        -- 이월 (보류) 내역에 없는 TRX만 생성 --
                                              WHERE H.JOB_ID           = WMT.JOB_ID
                                                AND H.OPERATION_SEQ_NO = WMT.FROM_OP_SEQ_NO
                                                AND H.OPERATION_ID     = WMT.FROM_OPERATION_ID)
                                            
                        ) D
                      , WIP_OUT_ADJUST_SUPPLIER S
                  WHERE S.WORKCENTER_ID         = D.WORKCENTER_ID
                    AND S.SOB_ID                = V_SOB_ID
                    AND S.ORG_ID                = V_ORG_ID
                    AND S.PERIOD_NAME           = V_PERIOD_NAME )
   LOOP
       TRX_ADJUST ( P_SOB_ID                => V_SOB_ID
                  , P_ORG_ID                => V_ORG_ID
                  , P_ADJUST_SUPPLIER_ID    => TRX.ADJUST_SUPPLIER_ID
                  , P_PERIOD_NAME           => V_PERIOD_NAME
                  , P_SUPPLIER_ID           => TRX.SUPPLIER_ID
                  , P_WORKCENTER_ID         => TRX.WORKCENTER_ID
                  , P_JOB_ID                => TRX.JOB_ID
                  , P_OPERATION_SEQ_NO      => TRX.OPERATION_SEQ_NO
                  , P_OPERATION_ID          => TRX.OPERATION_ID
                  , P_ORIGINAL_OPERATION_ID => TRX.OPERATION_ID
                  , P_USER_ID               => -1
                  , X_RESULT_STATUS         => V_RESULT_STATUS
                  , X_RESULT_MSG            => V_RESULT_MSG
                  );                   
   
   END LOOP;   
   
END ADJUST_DAILY_AUTO_RUN;



---------------------------
-- GET_OPERATION_AMOUNT  --
---------------------------
PROCEDURE GET_OP_AMOUNT  ( P_SOB_ID                     IN  NUMBER
                         , P_ORG_ID                     IN  NUMBER
                         , P_OPERATION_ID               IN  NUMBER
                         , P_ADJUST_TRX_ID              IN  NUMBER
                         , P_SPEC_CAL_AMOUNT            IN  NUMBER
                         , P_SPEC_ADJUST_AMOUNT         IN  NUMBER
                         , X_CURRENCY_CODE              OUT VARCHAR2
                         , X_OUT_PRICE                  OUT NUMBER
                         , X_OUT_AMOUNT                 OUT NUMBER
                         , X_LOW_LIMIT_AMOUNT           OUT NUMBER
                         , X_HIGH_LIMIT_AMOUNT          OUT NUMBER
                         , X_LOW_LIMIT_PRICE_UOM        OUT VARCHAR2
                         , X_LOW_LIMIT_PRICE            OUT NUMBER
                         , X_SETTING_FEE_AMOUNT         OUT NUMBER
                         , X_SETTING_LIMIT_HOUR         OUT NUMBER
                         , X_ADJUST_PRICE_TYPE_LCODE    OUT VARCHAR2
                         , X_OP_PRICE_APPLY_TYPE_LCODE  OUT VARCHAR2
                         )
IS

  V_LOCAL_DATE            DATE := GET_LOCAL_DATE(P_SOB_ID);  

  V_PERIOD_NAME           VARCHAR2(50);
  V_ADJUST_SUPPLIER_ID    NUMBER;
  V_SYSTEM_CURRENCY_CODE  VARCHAR2(50);
  
  -- 외주단가 변수 -------------------
  V_CURRENCY_CODE             VARCHAR2(50) := 'KRW';

  V_OP_PRICE                  NUMBER := 0;
  V_OP_AMOUNT                 NUMBER := 0;
  V_OP_PRICE_UOM_CODE         VARCHAR2(50);
  V_OP_LOW_LIMIT_AMOUNT          NUMBER;
  V_OP_HIGH_LIMIT_AMOUNT         NUMBER;
  V_OP_LOW_LIMIT_PRICE_UOM       VARCHAR2(50);
  V_OP_LOW_LIMIT_PRICE           NUMBER;
  V_OP_SETTING_FEE_AMOUNT        NUMBER;
  V_OP_SETTING_LIMIT_HOUR        NUMBER;

  
  V_MTX_UOM_CODE              VARCHAR2(50);
  V_MTX_UOM_QTY               NUMBER;
  
  V_SPEC_PRICE                NUMBER := 0;
  V_SPEC_AMOUNT               NUMBER := 0;

  V_OUT_PRICE                 NUMBER;
  V_OUT_AMOUNT                NUMBER;
  V_ADJUST_PRICE_TYPE         VARCHAR2(50);

    
  -- 하한단가 산정용 변수 -------------
  V_MM_PRICE               NUMBER := 0;
  V_PNL_PRICE              NUMBER := 0;
  V_ARRAY_PRICE            NUMBER := 0;
  V_PCS_PRICE              NUMBER := 0;

  V_PRICE_APPLY_TYPE_LCODE   VARCHAR2(50);
  V_PRICE_CLASS              VARCHAR2(50);
  V_PRICE_TYPE_LCODE         VARCHAR2(50);
  
  -- 하한 BOM값 산정용 변수, 2012-10-23, BY MJSHIN --
  V_TOTAL_SPEC_VALUE       NUMBER := 0;
  V_LOW_LIMIT_SPEC_VALUE   NUMBER := 0;
  V_LOW_LIMIT_SPEC_PRICE   NUMBER := 0;
  
BEGIN
       
       -- 시스템 기준 통화 SELECT --
       V_SYSTEM_CURRENCY_CODE := FI_ACCOUNT_BOOK_G.BASE_CURRENCY_F(P_SOB_ID);
       

       
       -- TRX 기준의 외주금액 산정 --       
       FOR TRX IN (SELECT *
                     FROM WIP_OUT_ADJUST_TRX  OAT
                    WHERE OAT.ADJUST_TRX_ID   = P_ADJUST_TRX_ID
                      AND OAT.CONFIRM_FLAG    = 'N')
       LOOP


               --------------------------------------
               -- 인계처리된 실적의 작업UOM SELECT --
               -- 공정별 단가는 작업UOM별로 구분됨 --
               --------------------------------------
               BEGIN
                     SELECT WMT.MTX_UOM_CODE
                          , NVL(WMT.MTX_UOM_QTY1,0) + NVL(WMT.MTX_UOM_QTY2,0) + NVL(WMT.MTX_UOM_QTY3,0) + NVL(WMT.MTX_UOM_QTY4,0)
                       INTO V_MTX_UOM_CODE
                          , V_MTX_UOM_QTY
                       FROM WIP_MOVE_TRANSACTIONS  WMT
                      WHERE WMT.MOVE_TRX_ID        = TRX.TOMOVE_TRX_ID
                      ;
               EXCEPTION WHEN OTHERS THEN
                    V_MTX_UOM_CODE := NULL;
               END;
               
               -- SPEC별 게산 금액 --
               V_SPEC_AMOUNT := P_SPEC_ADJUST_AMOUNT;
               IF NVL(V_MTX_UOM_QTY,0) != 0 THEN
                   V_SPEC_PRICE := ROUND(V_SPEC_AMOUNT / V_MTX_UOM_QTY,4);
               END IF; 
               V_ADJUST_PRICE_TYPE := 'SPEC';
               V_OUT_PRICE         := V_SPEC_PRICE;
               V_OUT_AMOUNT        := V_SPEC_AMOUNT;
               
                                
               -- 외주 단가 SELECT --
               BEGIN
                   GET_OP_OUT_PRICE  ( P_SOB_ID               => P_SOB_ID
                                     , P_ORG_ID               => P_ORG_ID
                                     , P_SUPPLIER_ID          => TRX.SUPPLIER_ID
                                     , P_WORKCENTER_ID        => TRX.WORKCENTER_ID
                                     , P_OPERATION_ID         => TRX.OPERATION_ID
                                     , P_BOM_ITEM_ID          => TRX.BOM_ITEM_ID
                                     , P_ADJUST_TRX_ID        => P_ADJUST_TRX_ID
                                     , P_TRX_DATE             => TRX.EXTEND_DATE
                                     , P_TRX_UOM_CODE         => V_MTX_UOM_CODE
                                     , P_TRX_QTY              => V_MTX_UOM_QTY
                                     , X_PRICE_CLASS          => V_PRICE_CLASS
                                     , X_PRICE_TYPE_LCODE     => V_PRICE_TYPE_LCODE
                                     , X_OUT_PRICE            => V_OP_PRICE
                                     , X_LOW_LIMIT_AMOUNT     => V_OP_LOW_LIMIT_AMOUNT   
                                     , X_HIGH_LIMIT_AMOUNT    => V_OP_HIGH_LIMIT_AMOUNT
                                     , X_LOW_LIMIT_PRICE_UOM  => V_OP_LOW_LIMIT_PRICE_UOM
                                     , X_LOW_LIMIT_PRICE      => V_OP_LOW_LIMIT_PRICE
                                     , X_SETTING_FEE_AMOUNT   => V_OP_SETTING_FEE_AMOUNT
                                     , X_SETTING_LIMIT_HOUR   => V_OP_SETTING_LIMIT_HOUR
                                     , X_LOW_LIMIT_SPEC_VALUE => V_LOW_LIMIT_SPEC_VALUE  -- 2012-10-23, BY MJSHIN --
                                     , X_LOW_LIMIT_SPEC_PRICE => V_LOW_LIMIT_SPEC_PRICE  -- 2012-10-23, BY MJSHIN --
                                     );
                                     
                                   
               EXCEPTION WHEN OTHERS THEN
                    RAISE_APPLICATION_ERROR(-20001, 'Operation Price List Select Error : ' || SQLERRM);
               END;                     
               
               IF NVL(V_OP_PRICE,0) > 0 THEN 
                    V_OP_AMOUNT         := V_OP_PRICE * V_MTX_UOM_QTY;

                    V_ADJUST_PRICE_TYPE := 'OP_STD_PRICE';
                    V_OUT_PRICE         := V_OP_PRICE;
                    V_OUT_AMOUNT        := V_OP_AMOUNT;
               END IF;
                       
               -------------------
               -- 하한단가 적용 --
               -------------------START
               IF NVL(V_OP_LOW_LIMIT_PRICE,0) > 0 THEN
                 
                   IF    V_MTX_UOM_CODE = '㎡' THEN
                                
                           V_MM_PRICE    := V_OUT_PRICE;
                                   
                           IF NVL(TRX.PCS_PER_MM_QTY,0) != 0 THEN
                                V_PNL_PRICE   := TRUNC(V_OUT_PRICE / TRX.PCS_PER_MM_QTY * TRX.PCS_PER_PNL_QTY,3);
                                V_ARRAY_PRICE := TRUNC(V_OUT_PRICE / TRX.PCS_PER_MM_QTY * TRX.PCS_PER_ARRAY_QTY,3);
                                V_PCS_PRICE   := TRUNC(V_OUT_PRICE / TRX.PCS_PER_MM_QTY,3); 
                           ELSE
                                V_PNL_PRICE   := 0;
                                V_ARRAY_PRICE := 0;
                                V_PCS_PRICE   := 0;
                           END IF;
                                   
                   ELSIF V_MTX_UOM_CODE IN ('PNL','HOLE','STROCK') THEN
                           
                           V_PNL_PRICE := V_OUT_PRICE;
                                   
                           IF NVL(TRX.PCS_PER_PNL_QTY,0) != 0 THEN
                                V_MM_PRICE    := TRUNC(V_OUT_PRICE / TRX.PCS_PER_PNL_QTY * TRX.PCS_PER_MM_QTY,3);
                                V_ARRAY_PRICE := TRUNC(V_OUT_PRICE / TRX.PCS_PER_PNL_QTY * TRX.PCS_PER_ARRAY_QTY,3);
                                V_PCS_PRICE   := TRUNC(V_OUT_PRICE / TRX.PCS_PER_PNL_QTY,3); 
                           ELSE
                                V_MM_PRICE    := 0;
                                V_ARRAY_PRICE := 0;
                                V_PCS_PRICE   := 0;
                           END IF;
                                   
                   ELSIF V_MTX_UOM_CODE IN ('ARRAY','KIT') THEN
                                   
                           V_ARRAY_PRICE := V_OUT_PRICE;
                                   
                           IF NVL(TRX.PCS_PER_ARRAY_QTY,0) != 0 THEN
                                V_MM_PRICE    := TRUNC(V_OUT_PRICE / TRX.PCS_PER_ARRAY_QTY * TRX.PCS_PER_MM_QTY,3);
                                V_PNL_PRICE   := TRUNC(V_OUT_PRICE / TRX.PCS_PER_ARRAY_QTY * TRX.PCS_PER_PNL_QTY,3);
                                V_PCS_PRICE   := TRUNC(V_OUT_PRICE / TRX.PCS_PER_ARRAY_QTY,3); 
                           ELSE
                                V_MM_PRICE    := 0;
                                V_PNL_PRICE   := 0;
                                V_PCS_PRICE   := 0;
                           END IF;
                                   
                   ELSIF V_MTX_UOM_CODE = 'PCS' THEN
                                 
                           V_PCS_PRICE   := V_OUT_PRICE;
                           V_MM_PRICE    := TRUNC(V_OUT_PRICE * TRX.PCS_PER_MM_QTY,3);
                           V_ARRAY_PRICE := TRUNC(V_OUT_PRICE * TRX.PCS_PER_ARRAY_QTY,3);
                           V_PNL_PRICE   := TRUNC(V_OUT_PRICE * TRX.PCS_PER_PNL_QTY,3); 
                                   
                   ELSE  
                           V_PNL_PRICE := V_OUT_PRICE;
                                   
                           IF NVL(TRX.PCS_PER_PNL_QTY,0) != 0 THEN
                                V_MM_PRICE    := TRUNC(V_OUT_PRICE / TRX.PCS_PER_PNL_QTY * TRX.PCS_PER_MM_QTY,3);
                                V_ARRAY_PRICE := TRUNC(V_OUT_PRICE / TRX.PCS_PER_PNL_QTY * TRX.PCS_PER_ARRAY_QTY,3);
                                V_PCS_PRICE   := TRUNC(V_OUT_PRICE / TRX.PCS_PER_PNL_QTY,3); 
                           ELSE
                                V_MM_PRICE    := 0;
                                V_ARRAY_PRICE := 0;
                                V_PCS_PRICE   := 0;
                           END IF;
                           
                   END IF;
                           
                   IF    V_OP_LOW_LIMIT_PRICE_UOM = '㎡' AND V_OP_LOW_LIMIT_PRICE > V_MM_PRICE  THEN
                                    
                             V_OUT_PRICE              := V_OP_LOW_LIMIT_PRICE;
                             V_ADJUST_PRICE_TYPE      := 'OP_LOW_PRICE';
                             V_PRICE_APPLY_TYPE_LCODE := 'LOW_LIMIT_PRICE';
                                     
                   ELSIF V_OP_LOW_LIMIT_PRICE_UOM = 'PNL' AND V_OP_LOW_LIMIT_PRICE > V_PNL_PRICE THEN
                           
                             V_OUT_PRICE              := V_OP_LOW_LIMIT_PRICE;
                             V_ADJUST_PRICE_TYPE      := 'OP_LOW_PRICE';
                             V_PRICE_APPLY_TYPE_LCODE := 'LOW_LIMIT_PRICE';
                                     
                   ELSIF V_OP_LOW_LIMIT_PRICE_UOM = 'ARRAY' AND V_OP_LOW_LIMIT_PRICE > V_ARRAY_PRICE THEN
                           
                             V_OUT_PRICE              := V_OP_LOW_LIMIT_PRICE;
                             V_ADJUST_PRICE_TYPE      := 'OP_LOW_PRICE';
                             V_PRICE_APPLY_TYPE_LCODE := 'LOW_LIMIT_PRICE';
                                     
                   ELSIF V_OP_LOW_LIMIT_PRICE_UOM = 'PCS' AND V_OP_LOW_LIMIT_PRICE > V_PCS_PRICE THEN
                           
                             V_OUT_PRICE              := V_OP_LOW_LIMIT_PRICE;
                             V_ADJUST_PRICE_TYPE      := 'OP_LOW_PRICE';
                             V_PRICE_APPLY_TYPE_LCODE := 'LOW_LIMIT_PRICE';
                                     
                   ELSIF V_OP_LOW_LIMIT_PRICE > V_PNL_PRICE THEN
                                     
                             V_OUT_PRICE              := V_OP_LOW_LIMIT_PRICE;
                             V_ADJUST_PRICE_TYPE      := 'OP_LOW_PRICE';
                             V_PRICE_APPLY_TYPE_LCODE := 'LOW_LIMIT_PRICE';
                   
                   END IF;
                   
               END IF;

               --------------------------
               -- 기본 외주비 계산     --
               --------------------------
               IF    V_PRICE_APPLY_TYPE_LCODE = 'LOW_LIMIT_PRICE' THEN
                 
                     IF    V_OP_LOW_LIMIT_PRICE_UOM = '㎡' THEN

                             V_OUT_AMOUNT   := TRUNC(V_OUT_PRICE   * TRX.ADJUST_MM_QTY); 
                                     
                     ELSIF V_OP_LOW_LIMIT_PRICE_UOM IN ('PNL','HOLE','STROCK') THEN
                             
                             V_OUT_AMOUNT   := TRUNC(V_OUT_PRICE   * TRX.ADJUST_PNL_QTY);
                                     
                     ELSIF V_OP_LOW_LIMIT_PRICE_UOM IN ('ARRAY','KIT') THEN
                                     
                             V_OUT_AMOUNT   := TRUNC(V_OUT_PRICE   * TRX.ADJUST_ARRAY_QTY);
                                     
                     ELSIF V_OP_LOW_LIMIT_PRICE_UOM = 'PCS' THEN
                                   
                             V_OUT_AMOUNT   := TRUNC(V_OUT_PRICE   * TRX.ADJUST_PCS_QTY);
                                     
                     ELSE  
                             V_OUT_AMOUNT   := TRUNC(V_OUT_PRICE   * TRX.ADJUST_PNL_QTY);
                                     
                     END IF;
                     
               END IF;
               -------------------
               -- 하한단가 적용 --
               -------------------END

               ---------------------------
               -- 하한 BOM값 적용       --
               -- 2012-10-23, BY MJSHIN --
               --------------------------- START
               IF NVL(V_LOW_LIMIT_SPEC_VALUE,0) != 0 AND NVL(V_LOW_LIMIT_SPEC_PRICE,0) != 0 THEN 
                   
                   -- SPEC VALUE의 총합 --
                   BEGIN
                        SELECT SUM(S.OP_SPEC_VALUE)
                          INTO V_TOTAL_SPEC_VALUE
                          FROM WIP_OUT_ADJUST_SPEC S
                         WHERE S.ADJUST_TRX_ID     = TRX.ADJUST_TRX_ID
                         ;  
                   EXCEPTION WHEN OTHERS THEN
                       V_TOTAL_SPEC_VALUE := 0;
                   END;
                   
                   IF NVL(V_LOW_LIMIT_SPEC_VALUE,0) > NVL(V_TOTAL_SPEC_VALUE,0) THEN 

                       
                       IF    V_OP_LOW_LIMIT_PRICE_UOM = '㎡' THEN

                               V_OUT_AMOUNT   := TRUNC(V_LOW_LIMIT_SPEC_PRICE * V_LOW_LIMIT_SPEC_VALUE * TRX.ADJUST_MM_QTY); 
                                         
                       ELSIF V_OP_LOW_LIMIT_PRICE_UOM IN ('PNL','HOLE','STROCK') THEN
                                 
                               V_OUT_AMOUNT   := TRUNC(V_LOW_LIMIT_SPEC_PRICE * V_LOW_LIMIT_SPEC_VALUE * TRX.ADJUST_PNL_QTY);
                                         
                       ELSIF V_OP_LOW_LIMIT_PRICE_UOM IN ('ARRAY','KIT') THEN
                                         
                               V_OUT_AMOUNT   := TRUNC(V_LOW_LIMIT_SPEC_PRICE * V_LOW_LIMIT_SPEC_VALUE * TRX.ADJUST_ARRAY_QTY);
                                         
                       ELSIF V_OP_LOW_LIMIT_PRICE_UOM = 'PCS' THEN
                                       
                               V_OUT_AMOUNT   := TRUNC(V_LOW_LIMIT_SPEC_PRICE * V_LOW_LIMIT_SPEC_VALUE * TRX.ADJUST_PCS_QTY);
                                         
                       ELSE  
                               V_OUT_AMOUNT   := TRUNC(V_LOW_LIMIT_SPEC_PRICE * V_LOW_LIMIT_SPEC_VALUE * TRX.ADJUST_PNL_QTY);
                                         
                       END IF;
                       
                       V_MM_PRICE               := TRUNC(V_OUT_AMOUNT / TRX.ADJUST_MM_QTY,3);
                       V_PNL_PRICE              := TRUNC(V_OUT_AMOUNT / TRX.ADJUST_PNL_QTY,3);
                       V_ARRAY_PRICE            := TRUNC(V_OUT_AMOUNT / TRX.ADJUST_ARRAY_QTY,3);
                       V_PCS_PRICE              := TRUNC(V_OUT_AMOUNT / TRX.ADJUST_PCS_QTY,3);
                       V_OUT_PRICE              := V_LOW_LIMIT_SPEC_PRICE;
                       V_ADJUST_PRICE_TYPE      := 'OP_LOW_SPEC_PRICE';
                       V_PRICE_APPLY_TYPE_LCODE := 'LOW_SPEC_PRICE';
                                            
                   END IF;


               END IF;
               ---------------------------
               -- 하한 BOM값 적용       --
               -- 2012-10-23, BY MJSHIN --
               --------------------------- END               
                              
               --------------------
               -- 하한 금액 적용 --
               --------------------
               IF NVL(V_OP_LOW_LIMIT_AMOUNT,0) != 0 THEN
                   IF V_OUT_AMOUNT < NVL(V_OP_LOW_LIMIT_AMOUNT,0) THEN
                        V_OUT_AMOUNT             := V_OP_LOW_LIMIT_AMOUNT;
                        V_ADJUST_PRICE_TYPE      := 'OP_LOW_AMOUNT';
                        V_PRICE_APPLY_TYPE_LCODE := 'OP_LOW_AMOUNT';
                   END IF;
               END IF;
                       
               --------------------
               -- 상한금액 적용  --
               --------------------
               IF NVL(V_OP_HIGH_LIMIT_AMOUNT,0) != 0 THEN
                   IF NVL(V_OP_HIGH_LIMIT_AMOUNT,0) > 0 AND  V_OUT_AMOUNT > NVL(V_OP_HIGH_LIMIT_AMOUNT,0) THEN
                        V_OUT_AMOUNT             := V_OP_HIGH_LIMIT_AMOUNT;
                        V_ADJUST_PRICE_TYPE      := 'OP_HIGH_AMOUNT';
                        V_PRICE_APPLY_TYPE_LCODE := 'OP_HIGH_AMOUNT';
                   END IF;
               END IF;
               

               
               X_CURRENCY_CODE              := V_SYSTEM_CURRENCY_CODE;
               X_OUT_PRICE                  := V_OUT_PRICE;
               X_OUT_AMOUNT                 := V_OUT_AMOUNT;
               X_LOW_LIMIT_AMOUNT           := V_OP_LOW_LIMIT_AMOUNT;
               X_HIGH_LIMIT_AMOUNT          := V_OP_HIGH_LIMIT_AMOUNT;
               X_LOW_LIMIT_PRICE_UOM        := V_OP_LOW_LIMIT_PRICE_UOM;
               X_LOW_LIMIT_PRICE            := V_OP_LOW_LIMIT_PRICE;
               X_SETTING_FEE_AMOUNT         := V_OP_SETTING_FEE_AMOUNT;
               X_SETTING_LIMIT_HOUR         := V_OP_SETTING_LIMIT_HOUR;
               X_ADJUST_PRICE_TYPE_LCODE    := V_ADJUST_PRICE_TYPE;
               X_OP_PRICE_APPLY_TYPE_LCODE  := V_PRICE_APPLY_TYPE_LCODE;
               
       END LOOP;  -- TRX --      

       
END GET_OP_AMOUNT;


------------------------
-- OUT_PRICE_SELECT   --
------------------------
PROCEDURE GET_OP_OUT_PRICE ( P_SOB_ID                IN  NUMBER
                           , P_ORG_ID                IN  NUMBER
                           , P_SUPPLIER_ID           IN  NUMBER
                           , P_WORKCENTER_ID         IN  NUMBER
                           , P_OPERATION_ID          IN  NUMBER
                           , P_BOM_ITEM_ID           IN  NUMBER
                           , P_ADJUST_TRX_ID         IN  NUMBER
                           , P_TRX_DATE              IN  DATE
                           , P_TRX_UOM_CODE          IN  VARCHAR2
                           , P_TRX_QTY               IN  NUMBER
                           , X_PRICE_CLASS           OUT VARCHAR2
                           , X_PRICE_TYPE_LCODE      OUT VARCHAR2
                           , X_OUT_PRICE             OUT NUMBER
                           , X_LOW_LIMIT_AMOUNT      OUT NUMBER   
                           , X_HIGH_LIMIT_AMOUNT     OUT NUMBER
                           , X_LOW_LIMIT_PRICE_UOM   OUT VARCHAR2
                           , X_LOW_LIMIT_PRICE       OUT NUMBER
                           , X_SETTING_FEE_AMOUNT    OUT NUMBER
                           , X_SETTING_LIMIT_HOUR    OUT NUMBER
                           , X_LOW_LIMIT_SPEC_VALUE  OUT NUMBER  -- 2012-10-23, BY MJSHIN --
                           , X_LOW_LIMIT_SPEC_PRICE  OUT NUMBER  -- 2012-10-23, BY MJSHIN --
                           )
IS
    V_PRICE_TYPE_1    VARCHAR2(50);
    V_PRICE_TYPE_2    VARCHAR2(50);
    V_PRICE_TYPE_3    VARCHAR2(50);
    V_PRICE_TYPE_4    VARCHAR2(50);
    V_QTY_LIMIT_FLAG  VARCHAR2(1);
--    V_MODEL_PRICE_FLAG VARCHAR2(1) := 'N';
--    V_ITEM_NET_CODE    VARCHAR2(50);
    
    V_MTX_UOM_CODE     VARCHAR2(50);
    V_MTX_UOM_QTY      NUMBER;
    
BEGIN
           
           V_MTX_UOM_CODE := P_TRX_UOM_CODE;
           V_MTX_UOM_QTY  := P_TRX_QTY;

           -- 수량별 단가적용여부 체크 --
           BEGIN
                 SELECT NVL(L.QTY_LIMIT_UOM_FLAG,'N')
                   INTO V_QTY_LIMIT_FLAG
                   FROM WIP_OUT_OP_PRICE_LIST L
                  WHERE L.OPERATION_ID        = P_OPERATION_ID
                    AND L.QTY_LIMIT_UOM_FLAG  = 'Y'           
                    AND ROWNUM                = 1
                  ;
           EXCEPTION WHEN OTHERS THEN
                V_QTY_LIMIT_FLAG := 'N';
           END;
 /*          
           ---------------------------------------------------------------
           -- 모델단가를 적용했던 제품은 반드시 모델단가를 사용해야함.  --
           -- 순제품 기준으로 적용, 라해성주임 요청사항                 --
           -- 2011-10-17, BY MJSHIN                                     --
           ---------------------------------------------------------------
           BEGIN
                SELECT IIM.ITEM_NET_CODE
                  INTO V_ITEM_NET_CODE 
                  FROM SDM_ITEM_REVISION  SIR
                     , INV_ITEM_MASTER    IIM
                 WHERE IIM.INVENTORY_ITEM_ID  = SIR.INVENTORY_ITEM_ID
                   AND SIR.BOM_ITEM_ID        = P_BOM_ITEM_ID
                 ;
           EXCEPTION WHEN OTHERS THEN
                V_ITEM_NET_CODE := NULL;
           END;
           
           BEGIN
                SELECT 'Y'
                  INTO V_MODEL_PRICE_FLAG
                  FROM WIP_OUT_OP_PRICE_LIST  WPL
                     , SDM_ITEM_REVISION      SIR
                     , INV_ITEM_MASTER        IIM
                 WHERE WPL.PRICE_CLASS        = 'NORMAL'
                   AND WPL.PRICE_TYPE_LCODE   = 'MODEL'
                   AND WPL.OPERATION_ID       = P_OPERATION_ID
                   AND SIR.BOM_ITEM_ID        = WPL.BOM_ITEM_ID
                   AND IIM.INVENTORY_ITEM_ID  = SIR.INVENTORY_ITEM_ID
                   AND IIM.ITEM_NET_CODE      = V_ITEM_NET_CODE
                   AND ROWNUM                 = 1
                   ;
           EXCEPTION WHEN OTHERS THEN
               V_MODEL_PRICE_FLAG := 'N';
           END;
           */
           
           -------------------------------------------------
           -- 외주단가기준 SELECT                         --
           -------------------------------------------------
           -- 1. 외주처 + 공정기준 + 모델기준 --
           BEGIN
                SELECT R.PRICE_TYPE_CODE_1
                     , R.PRICE_TYPE_CODE_2
                     , R.PRICE_TYPE_CODE_3
                     , R.PRICE_TYPE_CODE_4
                  INTO V_PRICE_TYPE_1
                     , V_PRICE_TYPE_2
                     , V_PRICE_TYPE_3
                     , V_PRICE_TYPE_4
                  FROM WIP_OUT_ADJUST_PRICE_RULE R
                 WHERE R.SUPPLIER_ID        = P_SUPPLIER_ID
                   AND R.WORKCENTER_ID      = P_WORKCENTER_ID
                   AND R.OPERATION_ID       = P_OPERATION_ID
                   AND R.BOM_ITEM_ID        = P_BOM_ITEM_ID
                   AND P_TRX_DATE           BETWEEN R.EFFECTIVE_DATE_FR + (1/24*8.5)
                                                AND NVL(R.EFFECTIVE_DATE_TO + (1 + (1/24*8.5)), P_TRX_DATE) 
                   AND R.ENABLED_FLAG       = 'Y'
                 ;
           EXCEPTION WHEN OTHERS THEN
                 V_PRICE_TYPE_1 := NULL;
                 V_PRICE_TYPE_2 := NULL;
                 V_PRICE_TYPE_3 := NULL;
                 V_PRICE_TYPE_4 := NULL;
           END;
                      
/*           -- 2. 모델단가 적용기준 --
           IF V_PRICE_TYPE_1 IS NULL THEN

               ---------------------------------------------------------------
               -- 모델단가를 적용했던 제품은 반드시 모델단가를 사용해야함.  --
               -- 순제품 기준으로 적용, 라해성주임 요청사항                 --
               -- 2011-10-17, BY MJSHIN                                     --
               ---------------------------------------------------------------
               BEGIN
                    SELECT IIM.ITEM_NET_CODE
                      INTO V_ITEM_NET_CODE 
                      FROM SDM_ITEM_REVISION  SIR
                         , INV_ITEM_MASTER    IIM
                     WHERE IIM.INVENTORY_ITEM_ID  = SIR.INVENTORY_ITEM_ID
                       AND SIR.BOM_ITEM_ID        = P_BOM_ITEM_ID
                     ;
               EXCEPTION WHEN OTHERS THEN
                    V_ITEM_NET_CODE := NULL;
               END;
               
               BEGIN
                    SELECT 'Y'
                      INTO V_MODEL_PRICE_FLAG
                      FROM WIP_OUT_OP_PRICE_LIST  WPL
                         , SDM_ITEM_REVISION      SIR
                         , INV_ITEM_MASTER        IIM
                     WHERE WPL.PRICE_CLASS        = 'NORMAL'
                       AND WPL.PRICE_TYPE_LCODE   = 'MODEL'
                       AND WPL.OPERATION_ID       = P_OPERATION_ID
                       AND SIR.BOM_ITEM_ID        = WPL.BOM_ITEM_ID
                       AND IIM.INVENTORY_ITEM_ID  = SIR.INVENTORY_ITEM_ID
                       AND IIM.ITEM_NET_CODE      = V_ITEM_NET_CODE
                       AND WPL.ENABLED_FLAG       = 'Y'
                       AND ROWNUM                 = 1
                       ;
               EXCEPTION WHEN OTHERS THEN
                   V_MODEL_PRICE_FLAG := 'N';
               END;
                        
               IF V_MODEL_PRICE_FLAG = 'Y' THEN
                    V_PRICE_TYPE_1 := 'MODEL';
               ELSE
                    V_PRICE_TYPE_1 := NULL;
               END IF;

           END IF;*/
     
           -- 3. 외주처 + 공정기준 --
           IF V_PRICE_TYPE_1 IS NULL THEN
               BEGIN
                    SELECT R.PRICE_TYPE_CODE_1
                         , R.PRICE_TYPE_CODE_2
                         , R.PRICE_TYPE_CODE_3
                         , R.PRICE_TYPE_CODE_4
                      INTO V_PRICE_TYPE_1
                         , V_PRICE_TYPE_2
                         , V_PRICE_TYPE_3
                         , V_PRICE_TYPE_4
                      FROM WIP_OUT_ADJUST_PRICE_RULE R
                     WHERE R.SUPPLIER_ID        = P_SUPPLIER_ID
                       AND R.WORKCENTER_ID      = P_WORKCENTER_ID
                       AND R.OPERATION_ID       = P_OPERATION_ID
                       AND P_TRX_DATE           BETWEEN R.EFFECTIVE_DATE_FR + (1/24*8.5)
                                                    AND NVL(R.EFFECTIVE_DATE_TO + (1 + (1/24*8.5)), P_TRX_DATE) 
                       AND R.ENABLED_FLAG       = 'Y'
                     ;
               EXCEPTION WHEN OTHERS THEN
                     V_PRICE_TYPE_1 := NULL;
                     V_PRICE_TYPE_2 := NULL;
                     V_PRICE_TYPE_3 := NULL;
                     V_PRICE_TYPE_4 := NULL;
               END;
           END IF;
                      
           -- 4. 모델 + 공정기준 --
           IF V_PRICE_TYPE_1 IS NULL THEN
               
               BEGIN
                    SELECT R.PRICE_TYPE_CODE_1
                         , R.PRICE_TYPE_CODE_2
                         , R.PRICE_TYPE_CODE_3
                         , R.PRICE_TYPE_CODE_4
                      INTO V_PRICE_TYPE_1
                         , V_PRICE_TYPE_2
                         , V_PRICE_TYPE_3
                         , V_PRICE_TYPE_4
                      FROM WIP_OUT_ADJUST_PRICE_RULE R
                     WHERE R.OPERATION_ID       = P_OPERATION_ID
                       AND R.BOM_ITEM_ID        = P_BOM_ITEM_ID
                       AND P_TRX_DATE           BETWEEN R.EFFECTIVE_DATE_FR + (1/24*8.5)
                                                    AND NVL(R.EFFECTIVE_DATE_TO + (1 + (1/24*8.5)), P_TRX_DATE) 
                       AND R.ENABLED_FLAG       = 'Y'
                     ;
               EXCEPTION WHEN OTHERS THEN
                     V_PRICE_TYPE_1 := NULL;
                     V_PRICE_TYPE_2 := NULL;
                     V_PRICE_TYPE_3 := NULL;
                     V_PRICE_TYPE_4 := NULL;
               END;             
           END IF;
           
           IF V_PRICE_TYPE_1 IS NOT NULL THEN
           
               -------------------------------------------------
               -- 외주 단가 SELECT (단가 우선순위 지정)       --
               -------------------------------------------------
               
               -- 1. PRICE_TYPE_1 --
               BEGIN
                    SELECT OPL.PRICE_CLASS
                         , OPL.PRICE_TYPE_LCODE
                         , OPL.OUT_PRICE
                         , OPL.LOW_LIMIT_AMOUNT
                         , OPL.HIGH_LIMIT_AMOUNT
                         , OPL.LOW_LIMIT_PRICE_UOM
                         , OPL.LOW_LIMIT_PRICE
                         , OPL.SETTING_FEE_AMOUNT
                         , OPL.SETTING_LIMIT_HOUR
                         , OPL.LOW_LIMIT_SPEC_VALUE
                         , OPL.LOW_LIMIT_SPEC_PRICE
                      INTO X_PRICE_CLASS
                         , X_PRICE_TYPE_LCODE
                         , X_OUT_PRICE
                         , X_LOW_LIMIT_AMOUNT
                         , X_HIGH_LIMIT_AMOUNT
                         , X_LOW_LIMIT_PRICE_UOM
                         , X_LOW_LIMIT_PRICE
                         , X_SETTING_FEE_AMOUNT
                         , X_SETTING_LIMIT_HOUR
                         , X_LOW_LIMIT_SPEC_VALUE
                         , X_LOW_LIMIT_SPEC_PRICE
                      FROM WIP_OUT_OP_PRICE_LIST   OPL
                     WHERE OPL.SOB_ID           = P_SOB_ID
                       AND OPL.ORG_ID           = P_ORG_ID
                       AND OPL.OPERATION_ID     = P_OPERATION_ID
                       AND (  (NVL(OPL.OUT_PRICE,0) > 0 AND OPL.PRICE_UOM_CODE   = V_MTX_UOM_CODE)  -- 작업UOM별 단가 SELECT --
                           OR (NVL(OPL.OUT_PRICE,0) = 0 AND 1 = 1))
                       AND OPL.PRICE_TYPE_LCODE = V_PRICE_TYPE_1
                       AND (  (V_PRICE_TYPE_1 NOT IN ('COMPLEX','VENDOR') AND 1 = 1)
                           OR (V_PRICE_TYPE_1     IN ('COMPLEX','VENDOR') AND OPL.SUPPLIER_ID = P_SUPPLIER_ID))
                       AND (  (V_PRICE_TYPE_1 NOT IN ('COMPLEX','MODEL')  AND 1 = 1)
                           OR (V_PRICE_TYPE_1     IN ('COMPLEX','MODEL')  AND OPL.BOM_ITEM_ID = P_BOM_ITEM_ID))
                       AND P_TRX_DATE           BETWEEN OPL.EFFECTIVE_DATE_FR + (1/24*8.5)
                                                    AND NVL(OPL.EFFECTIVE_DATE_TO + (1 + (1/24*8.5)), P_TRX_DATE)
                       AND OPL.ENABLED_FLAG     = 'Y'
                       AND (  (NVL(V_QTY_LIMIT_FLAG,'N') = 'N' AND 1 = 1)  -- 수량범위별 단가적용, 2011-10-15, BY MJSHIN --
                           OR (NVL(V_QTY_LIMIT_FLAG,'N') = 'Y' AND OPL.QTY_LIMIT_UOM_FLAG = 'Y'
                                                               AND NVL(OPL.QTY_LIMIT_RANGE_FR,0) <= V_MTX_UOM_QTY
                                                               AND NVL(OPL.QTY_LIMIT_RANGE_TO,9999999999999) >= V_MTX_UOM_QTY)
                           )
                       
                       ;
               EXCEPTION WHEN OTHERS THEN
                    X_PRICE_CLASS         := NULL;
                    X_PRICE_TYPE_LCODE    := NULL;
                    X_OUT_PRICE           := NULL;
                    X_LOW_LIMIT_AMOUNT    := NULL;
                    X_HIGH_LIMIT_AMOUNT   := NULL;
                    X_LOW_LIMIT_PRICE_UOM := NULL;
                    X_LOW_LIMIT_PRICE     := NULL;
                    X_SETTING_FEE_AMOUNT  := NULL;
                    X_SETTING_LIMIT_HOUR  := NULL;
                    X_LOW_LIMIT_SPEC_VALUE := NULL;
                    X_LOW_LIMIT_SPEC_PRICE := NULL;
               END;
                     
               -- 2. PRICE_TYPE_2 --
               IF X_OUT_PRICE IS NULL THEN
                         
                   BEGIN
                        SELECT OPL.PRICE_CLASS
                         , OPL.PRICE_TYPE_LCODE
                         , OPL.OUT_PRICE
                         , OPL.LOW_LIMIT_AMOUNT
                         , OPL.HIGH_LIMIT_AMOUNT
                         , OPL.LOW_LIMIT_PRICE_UOM
                         , OPL.LOW_LIMIT_PRICE
                         , OPL.SETTING_FEE_AMOUNT
                         , OPL.SETTING_LIMIT_HOUR
                         , OPL.LOW_LIMIT_SPEC_VALUE
                         , OPL.LOW_LIMIT_SPEC_PRICE
                      INTO X_PRICE_CLASS
                         , X_PRICE_TYPE_LCODE
                         , X_OUT_PRICE
                         , X_LOW_LIMIT_AMOUNT
                         , X_HIGH_LIMIT_AMOUNT
                         , X_LOW_LIMIT_PRICE_UOM
                         , X_LOW_LIMIT_PRICE
                         , X_SETTING_FEE_AMOUNT
                         , X_SETTING_LIMIT_HOUR
                         , X_LOW_LIMIT_SPEC_VALUE
                         , X_LOW_LIMIT_SPEC_PRICE
                         
                      FROM WIP_OUT_OP_PRICE_LIST   OPL
                     WHERE OPL.SOB_ID           = P_SOB_ID
                       AND OPL.ORG_ID           = P_ORG_ID
                       AND OPL.OPERATION_ID     = P_OPERATION_ID
                       AND (  (NVL(OPL.OUT_PRICE,0) > 0 AND OPL.PRICE_UOM_CODE   = V_MTX_UOM_CODE)  -- 작업UOM별 단가 SELECT --
                           OR (NVL(OPL.OUT_PRICE,0) = 0 AND 1 = 1))
                       AND OPL.PRICE_TYPE_LCODE = V_PRICE_TYPE_2
                       AND (  (V_PRICE_TYPE_2 NOT IN ('COMPLEX','VENDOR') AND 1 = 1)
                           OR (V_PRICE_TYPE_2     IN ('COMPLEX','VENDOR') AND OPL.SUPPLIER_ID = P_SUPPLIER_ID))
                       AND (  (V_PRICE_TYPE_2 NOT IN ('COMPLEX','MODEL')  AND 1 = 1)
                           OR (V_PRICE_TYPE_2     IN ('COMPLEX','MODEL')  AND OPL.BOM_ITEM_ID = P_BOM_ITEM_ID))
                       AND P_TRX_DATE           BETWEEN OPL.EFFECTIVE_DATE_FR + (1/24*8.5)
                                                    AND NVL(OPL.EFFECTIVE_DATE_TO + (1 + (1/24*8.5)), P_TRX_DATE)
                       AND OPL.ENABLED_FLAG     = 'Y'
                       AND (  (NVL(V_QTY_LIMIT_FLAG,'N') = 'N' AND 1 = 1)  -- 수량범위별 단가적용, 2011-10-15, BY MJSHIN --
                           OR (NVL(V_QTY_LIMIT_FLAG,'N') = 'Y' AND OPL.QTY_LIMIT_UOM_FLAG = 'Y'
                                                               AND NVL(OPL.QTY_LIMIT_RANGE_FR,0) <= V_MTX_UOM_QTY
                                                               AND NVL(OPL.QTY_LIMIT_RANGE_TO,9999999999999) >= V_MTX_UOM_QTY)
                           )
                       ;
                   EXCEPTION WHEN OTHERS THEN
                        X_PRICE_CLASS         := NULL;
                        X_PRICE_TYPE_LCODE    := NULL;
                        X_OUT_PRICE           := NULL;
                        X_LOW_LIMIT_AMOUNT    := NULL;
                        X_HIGH_LIMIT_AMOUNT   := NULL;
                        X_LOW_LIMIT_PRICE_UOM := NULL;
                        X_LOW_LIMIT_PRICE     := NULL;
                        X_SETTING_FEE_AMOUNT  := NULL;
                        X_SETTING_LIMIT_HOUR  := NULL;
                        X_LOW_LIMIT_SPEC_VALUE := NULL;
                        X_LOW_LIMIT_SPEC_PRICE := NULL;
                   END;                   
               END IF;

               -- 3. PRICE_TYPE_3 --
               IF X_OUT_PRICE IS NULL THEN
                         
                   BEGIN
                        SELECT OPL.PRICE_CLASS
                         , OPL.PRICE_TYPE_LCODE
                         , OPL.OUT_PRICE
                         , OPL.LOW_LIMIT_AMOUNT
                         , OPL.HIGH_LIMIT_AMOUNT
                         , OPL.LOW_LIMIT_PRICE_UOM
                         , OPL.LOW_LIMIT_PRICE
                         , OPL.SETTING_FEE_AMOUNT
                         , OPL.SETTING_LIMIT_HOUR
                         , OPL.LOW_LIMIT_SPEC_VALUE
                         , OPL.LOW_LIMIT_SPEC_PRICE
                      INTO X_PRICE_CLASS
                         , X_PRICE_TYPE_LCODE
                         , X_OUT_PRICE
                         , X_LOW_LIMIT_AMOUNT
                         , X_HIGH_LIMIT_AMOUNT
                         , X_LOW_LIMIT_PRICE_UOM
                         , X_LOW_LIMIT_PRICE
                         , X_SETTING_FEE_AMOUNT
                         , X_SETTING_LIMIT_HOUR
                         , X_LOW_LIMIT_SPEC_VALUE
                         , X_LOW_LIMIT_SPEC_PRICE
                      FROM WIP_OUT_OP_PRICE_LIST   OPL
                     WHERE OPL.SOB_ID           = P_SOB_ID
                       AND OPL.ORG_ID           = P_ORG_ID
                       AND OPL.OPERATION_ID     = P_OPERATION_ID
                       AND (  (NVL(OPL.OUT_PRICE,0) > 0 AND OPL.PRICE_UOM_CODE   = V_MTX_UOM_CODE)  -- 작업UOM별 단가 SELECT --
                           OR (NVL(OPL.OUT_PRICE,0) = 0 AND 1 = 1))
                       AND OPL.PRICE_TYPE_LCODE = V_PRICE_TYPE_3
                       AND (  (V_PRICE_TYPE_3 NOT IN ('COMPLEX','VENDOR') AND 1 = 1)
                           OR (V_PRICE_TYPE_3     IN ('COMPLEX','VENDOR') AND OPL.SUPPLIER_ID = P_SUPPLIER_ID))
                       AND (  (V_PRICE_TYPE_3 NOT IN ('COMPLEX','MODEL')  AND 1 = 1)
                           OR (V_PRICE_TYPE_3     IN ('COMPLEX','MODEL')  AND OPL.BOM_ITEM_ID = P_BOM_ITEM_ID))
                       AND P_TRX_DATE           BETWEEN OPL.EFFECTIVE_DATE_FR + (1/24*8.5)
                                                    AND NVL(OPL.EFFECTIVE_DATE_TO + (1 + (1/24*8.5)), P_TRX_DATE)
                       AND OPL.ENABLED_FLAG     = 'Y'
                       AND (  (NVL(V_QTY_LIMIT_FLAG,'N') = 'N' AND 1 = 1)  -- 수량범위별 단가적용, 2011-10-15, BY MJSHIN --
                           OR (NVL(V_QTY_LIMIT_FLAG,'N') = 'Y' AND OPL.QTY_LIMIT_UOM_FLAG = 'Y'
                                                               AND NVL(OPL.QTY_LIMIT_RANGE_FR,0) <= V_MTX_UOM_QTY
                                                               AND NVL(OPL.QTY_LIMIT_RANGE_TO,9999999999999) >= V_MTX_UOM_QTY)
                           )
                       ;
                   EXCEPTION WHEN OTHERS THEN
                        X_PRICE_CLASS         := NULL;
                        X_PRICE_TYPE_LCODE    := NULL;
                        X_OUT_PRICE           := NULL;
                        X_LOW_LIMIT_AMOUNT    := NULL;
                        X_HIGH_LIMIT_AMOUNT   := NULL;
                        X_LOW_LIMIT_PRICE_UOM := NULL;
                        X_LOW_LIMIT_PRICE     := NULL;
                        X_SETTING_FEE_AMOUNT  := NULL;
                        X_SETTING_LIMIT_HOUR  := NULL;
                        X_LOW_LIMIT_SPEC_VALUE := NULL;
                        X_LOW_LIMIT_SPEC_PRICE := NULL;
                   END;                   
               END IF;

               -- 4. PRICE_TYPE_4 --
               IF X_OUT_PRICE IS NULL THEN
                         
                   BEGIN
                        SELECT OPL.PRICE_CLASS
                         , OPL.PRICE_TYPE_LCODE
                         , OPL.OUT_PRICE
                         , OPL.LOW_LIMIT_AMOUNT
                         , OPL.HIGH_LIMIT_AMOUNT
                         , OPL.LOW_LIMIT_PRICE_UOM
                         , OPL.LOW_LIMIT_PRICE
                         , OPL.SETTING_FEE_AMOUNT
                         , OPL.SETTING_LIMIT_HOUR
                         , OPL.LOW_LIMIT_SPEC_VALUE
                         , OPL.LOW_LIMIT_SPEC_PRICE
                      INTO X_PRICE_CLASS
                         , X_PRICE_TYPE_LCODE
                         , X_OUT_PRICE
                         , X_LOW_LIMIT_AMOUNT
                         , X_HIGH_LIMIT_AMOUNT
                         , X_LOW_LIMIT_PRICE_UOM
                         , X_LOW_LIMIT_PRICE
                         , X_SETTING_FEE_AMOUNT
                         , X_SETTING_LIMIT_HOUR
                         , X_LOW_LIMIT_SPEC_VALUE
                         , X_LOW_LIMIT_SPEC_PRICE
                      FROM WIP_OUT_OP_PRICE_LIST   OPL
                     WHERE OPL.SOB_ID           = P_SOB_ID
                       AND OPL.ORG_ID           = P_ORG_ID
                       AND OPL.OPERATION_ID     = P_OPERATION_ID
                       AND (  (NVL(OPL.OUT_PRICE,0) > 0 AND OPL.PRICE_UOM_CODE   = V_MTX_UOM_CODE)  -- 작업UOM별 단가 SELECT --
                           OR (NVL(OPL.OUT_PRICE,0) = 0 AND 1 = 1))
                       AND OPL.PRICE_TYPE_LCODE = V_PRICE_TYPE_4
                       AND (  (V_PRICE_TYPE_4 NOT IN ('COMPLEX','VENDOR') AND 1 = 1)
                           OR (V_PRICE_TYPE_4     IN ('COMPLEX','VENDOR') AND OPL.SUPPLIER_ID = P_SUPPLIER_ID))
                       AND (  (V_PRICE_TYPE_4 NOT IN ('COMPLEX','MODEL')  AND 1 = 1)
                           OR (V_PRICE_TYPE_4     IN ('COMPLEX','MODEL')  AND OPL.BOM_ITEM_ID = P_BOM_ITEM_ID))
                       AND P_TRX_DATE           BETWEEN OPL.EFFECTIVE_DATE_FR + (1/24*8.5)
                                                    AND NVL(OPL.EFFECTIVE_DATE_TO + (1 + (1/24*8.5)), P_TRX_DATE)
                       AND OPL.ENABLED_FLAG     = 'Y'
                       AND (  (NVL(V_QTY_LIMIT_FLAG,'N') = 'N' AND 1 = 1)  -- 수량범위별 단가적용, 2011-10-15, BY MJSHIN --
                           OR (NVL(V_QTY_LIMIT_FLAG,'N') = 'Y' AND OPL.QTY_LIMIT_UOM_FLAG = 'Y'
                                                               AND NVL(OPL.QTY_LIMIT_RANGE_FR,0) <= V_MTX_UOM_QTY
                                                               AND NVL(OPL.QTY_LIMIT_RANGE_TO,9999999999999) >= V_MTX_UOM_QTY)
                           )
                       ;
                   EXCEPTION WHEN OTHERS THEN
                        X_PRICE_CLASS         := NULL;
                        X_PRICE_TYPE_LCODE    := NULL;
                        X_OUT_PRICE           := NULL;
                        X_LOW_LIMIT_AMOUNT    := NULL;
                        X_HIGH_LIMIT_AMOUNT   := NULL;
                        X_LOW_LIMIT_PRICE_UOM := NULL;
                        X_LOW_LIMIT_PRICE     := NULL;
                        X_SETTING_FEE_AMOUNT  := NULL;
                        X_SETTING_LIMIT_HOUR  := NULL;
                        X_LOW_LIMIT_SPEC_VALUE := NULL;
                        X_LOW_LIMIT_SPEC_PRICE := NULL;
                   END;                   
               END IF;

           ELSE  -- IF V_PRICE_TYPE_1 IS NOT NULL THEN --
             
               -------------------------------------------------
               -- 외주 단가 SELECT (우선순위별)               --
               -- 1.COMPLEX > 2.VENDOR > 3.MODEL > 4.STANDARD --
               -------------------------------------------------
               
               -- 1. COMPLEX 단가 (MODEL + VENDOR) --
               BEGIN
                    SELECT OPL.PRICE_CLASS
                         , OPL.PRICE_TYPE_LCODE
                         , OPL.OUT_PRICE
                         , OPL.LOW_LIMIT_AMOUNT
                         , OPL.HIGH_LIMIT_AMOUNT
                         , OPL.LOW_LIMIT_PRICE_UOM
                         , OPL.LOW_LIMIT_PRICE
                         , OPL.SETTING_FEE_AMOUNT
                         , OPL.SETTING_LIMIT_HOUR
                         , OPL.LOW_LIMIT_SPEC_VALUE
                         , OPL.LOW_LIMIT_SPEC_PRICE
                      INTO X_PRICE_CLASS
                         , X_PRICE_TYPE_LCODE
                         , X_OUT_PRICE
                         , X_LOW_LIMIT_AMOUNT
                         , X_HIGH_LIMIT_AMOUNT
                         , X_LOW_LIMIT_PRICE_UOM
                         , X_LOW_LIMIT_PRICE
                         , X_SETTING_FEE_AMOUNT
                         , X_SETTING_LIMIT_HOUR
                         , X_LOW_LIMIT_SPEC_VALUE
                         , X_LOW_LIMIT_SPEC_PRICE
                      FROM WIP_OUT_OP_PRICE_LIST   OPL
                     WHERE OPL.SOB_ID           = P_SOB_ID
                       AND OPL.ORG_ID           = P_ORG_ID
                       AND OPL.OPERATION_ID     = P_OPERATION_ID
                       AND (  (NVL(OPL.OUT_PRICE,0) > 0 AND OPL.PRICE_UOM_CODE   = V_MTX_UOM_CODE)  -- 작업UOM별 단가 SELECT --
                           OR (NVL(OPL.OUT_PRICE,0) = 0 AND 1 = 1))
                       AND OPL.PRICE_TYPE_LCODE = 'COMPLEX'
                       AND OPL.SUPPLIER_ID      = P_SUPPLIER_ID
                       AND OPL.BOM_ITEM_ID      = P_BOM_ITEM_ID
                       AND P_TRX_DATE           BETWEEN OPL.EFFECTIVE_DATE_FR + (1/24*8.5)
                                                    AND NVL(OPL.EFFECTIVE_DATE_TO + (1 + (1/24*8.5)), P_TRX_DATE)
                       AND OPL.ENABLED_FLAG     = 'Y'
                       AND (  (NVL(V_QTY_LIMIT_FLAG,'N') = 'N' AND 1 = 1)  -- 수량범위별 단가적용, 2011-10-15, BY MJSHIN --
                           OR (NVL(V_QTY_LIMIT_FLAG,'N') = 'Y' AND OPL.QTY_LIMIT_UOM_FLAG = 'Y'
                                                               AND NVL(OPL.QTY_LIMIT_RANGE_FR,0) <= V_MTX_UOM_QTY
                                                               AND NVL(OPL.QTY_LIMIT_RANGE_TO,9999999999999) >= V_MTX_UOM_QTY)
                               )
                       ;
               EXCEPTION WHEN OTHERS THEN
                    X_PRICE_CLASS         := NULL;
                    X_PRICE_TYPE_LCODE    := NULL;
                    X_OUT_PRICE           := NULL;
                    X_LOW_LIMIT_AMOUNT    := NULL;
                    X_HIGH_LIMIT_AMOUNT   := NULL;
                    X_LOW_LIMIT_PRICE_UOM := NULL;
                    X_LOW_LIMIT_PRICE     := NULL;
                    X_SETTING_FEE_AMOUNT  := NULL;
                    X_SETTING_LIMIT_HOUR  := NULL;
                    X_LOW_LIMIT_SPEC_VALUE := NULL;
                    X_LOW_LIMIT_SPEC_PRICE := NULL;
               END;
                     
               -- 2. VENDOR기준 단가 --
               IF X_OUT_PRICE IS NULL THEN
                         
                   BEGIN
                        SELECT OPL.PRICE_CLASS
                             , OPL.PRICE_TYPE_LCODE
                             , OPL.OUT_PRICE
                             , OPL.LOW_LIMIT_AMOUNT
                             , OPL.HIGH_LIMIT_AMOUNT
                             , OPL.LOW_LIMIT_PRICE_UOM
                             , OPL.LOW_LIMIT_PRICE
                             , OPL.SETTING_FEE_AMOUNT
                             , OPL.SETTING_LIMIT_HOUR
                             , OPL.LOW_LIMIT_SPEC_VALUE
                         , OPL.LOW_LIMIT_SPEC_PRICE
                          INTO X_PRICE_CLASS
                             , X_PRICE_TYPE_LCODE
                             , X_OUT_PRICE
                             , X_LOW_LIMIT_AMOUNT
                             , X_HIGH_LIMIT_AMOUNT
                             , X_LOW_LIMIT_PRICE_UOM
                             , X_LOW_LIMIT_PRICE
                             , X_SETTING_FEE_AMOUNT
                             , X_SETTING_LIMIT_HOUR
                             , X_LOW_LIMIT_SPEC_VALUE
                             , X_LOW_LIMIT_SPEC_PRICE
                          FROM WIP_OUT_OP_PRICE_LIST   OPL
                         WHERE OPL.OPERATION_ID     = P_OPERATION_ID
                           AND OPL.SUPPLIER_ID      = P_SUPPLIER_ID
                           AND (  (NVL(OPL.OUT_PRICE,0) > 0 AND OPL.PRICE_UOM_CODE   = V_MTX_UOM_CODE)  -- 작업UOM별 단가 SELECT --
                               OR (NVL(OPL.OUT_PRICE,0) = 0 AND 1 = 1))
                           AND OPL.PRICE_TYPE_LCODE = 'VENDOR'
                           AND P_TRX_DATE           BETWEEN OPL.EFFECTIVE_DATE_FR + (1/24*8.5)
                                                    AND NVL(OPL.EFFECTIVE_DATE_TO + (1 + (1/24*8.5)), P_TRX_DATE)
                           AND OPL.ENABLED_FLAG     = 'Y'
                           AND (  (NVL(V_QTY_LIMIT_FLAG,'N') = 'N' AND 1 = 1) -- 수량범위별 단가적용, 2011-10-15, BY MJSHIN --
                               OR (NVL(V_QTY_LIMIT_FLAG,'N') = 'Y' AND OPL.QTY_LIMIT_UOM_FLAG = 'Y'
                                                                   AND NVL(OPL.QTY_LIMIT_RANGE_FR,0) <= V_MTX_UOM_QTY
                                                                   AND NVL(OPL.QTY_LIMIT_RANGE_TO,9999999999999) >= V_MTX_UOM_QTY)
                               )
                           ;
                   EXCEPTION WHEN OTHERS THEN
                        X_PRICE_CLASS         := NULL;
                        X_PRICE_TYPE_LCODE    := NULL;
                        X_OUT_PRICE           := NULL;
                        X_LOW_LIMIT_AMOUNT    := NULL;
                        X_HIGH_LIMIT_AMOUNT   := NULL;
                        X_LOW_LIMIT_PRICE_UOM := NULL;
                        X_LOW_LIMIT_PRICE     := NULL;
                        X_SETTING_FEE_AMOUNT  := NULL;
                        X_SETTING_LIMIT_HOUR  := NULL;
                        X_LOW_LIMIT_SPEC_VALUE := NULL;
                        X_LOW_LIMIT_SPEC_PRICE := NULL;
                   END;                   
               END IF;

               -- 3. MODEL 기준 단가 --
               IF X_OUT_PRICE IS NULL THEN
                         
                   BEGIN
                        SELECT OPL.PRICE_CLASS
                             , OPL.PRICE_TYPE_LCODE
                             , OPL.OUT_PRICE
                             , OPL.LOW_LIMIT_AMOUNT
                             , OPL.HIGH_LIMIT_AMOUNT
                             , OPL.LOW_LIMIT_PRICE_UOM
                             , OPL.LOW_LIMIT_PRICE
                             , OPL.SETTING_FEE_AMOUNT
                             , OPL.SETTING_LIMIT_HOUR
                             , OPL.LOW_LIMIT_SPEC_VALUE
                             , OPL.LOW_LIMIT_SPEC_PRICE
                          INTO X_PRICE_CLASS
                             , X_PRICE_TYPE_LCODE
                             , X_OUT_PRICE
                             , X_LOW_LIMIT_AMOUNT
                             , X_HIGH_LIMIT_AMOUNT
                             , X_LOW_LIMIT_PRICE_UOM
                             , X_LOW_LIMIT_PRICE
                             , X_SETTING_FEE_AMOUNT
                             , X_SETTING_LIMIT_HOUR
                             , X_LOW_LIMIT_SPEC_VALUE
                             , X_LOW_LIMIT_SPEC_PRICE
                          FROM WIP_OUT_OP_PRICE_LIST   OPL
                         WHERE OPL.OPERATION_ID     = P_OPERATION_ID
                           AND OPL.PRICE_TYPE_LCODE = 'MODEL'
                           AND OPL.BOM_ITEM_ID      = P_BOM_ITEM_ID
                           AND (  (NVL(OPL.OUT_PRICE,0) > 0 AND OPL.PRICE_UOM_CODE   = V_MTX_UOM_CODE)  -- 작업UOM별 단가 SELECT --
                               OR (NVL(OPL.OUT_PRICE,0) = 0 AND 1 = 1))
                           AND P_TRX_DATE           BETWEEN OPL.EFFECTIVE_DATE_FR + (1/24*8.5)
                                                    AND NVL(OPL.EFFECTIVE_DATE_TO + (1 + (1/24*8.5)), P_TRX_DATE)
                           AND OPL.ENABLED_FLAG     = 'Y'
                           AND (  (NVL(V_QTY_LIMIT_FLAG,'N') = 'N' AND 1 = 1)  -- 수량범위별 단가적용, 2011-10-15, BY MJSHIN --
                               OR (NVL(V_QTY_LIMIT_FLAG,'N') = 'Y' AND OPL.QTY_LIMIT_UOM_FLAG = 'Y'
                                                                   AND NVL(OPL.QTY_LIMIT_RANGE_FR,0) <= V_MTX_UOM_QTY
                                                                   AND NVL(OPL.QTY_LIMIT_RANGE_TO,9999999999999) >= V_MTX_UOM_QTY)
                               )
                           ;
                   EXCEPTION WHEN OTHERS THEN
                        X_PRICE_CLASS         := NULL;
                        X_PRICE_TYPE_LCODE    := NULL;
                        X_OUT_PRICE           := NULL;
                        X_LOW_LIMIT_AMOUNT    := NULL;
                        X_HIGH_LIMIT_AMOUNT   := NULL;
                        X_LOW_LIMIT_PRICE_UOM := NULL;
                        X_LOW_LIMIT_PRICE     := NULL;
                        X_SETTING_FEE_AMOUNT  := NULL;
                        X_SETTING_LIMIT_HOUR  := NULL;
                        X_LOW_LIMIT_SPEC_VALUE := NULL;
                        X_LOW_LIMIT_SPEC_PRICE := NULL;
                   END;                   
               END IF;

               -- 4. STANARD 기준 단가 --
               IF X_OUT_PRICE IS NULL THEN
                         
                   BEGIN
                        SELECT OPL.PRICE_CLASS
                             , OPL.PRICE_TYPE_LCODE
                             , OPL.OUT_PRICE
                             , OPL.LOW_LIMIT_AMOUNT
                             , OPL.HIGH_LIMIT_AMOUNT
                             , OPL.LOW_LIMIT_PRICE_UOM
                             , OPL.LOW_LIMIT_PRICE
                             , OPL.SETTING_FEE_AMOUNT
                             , OPL.SETTING_LIMIT_HOUR
                             , OPL.LOW_LIMIT_SPEC_VALUE
                             , OPL.LOW_LIMIT_SPEC_PRICE
                          INTO X_PRICE_CLASS
                             , X_PRICE_TYPE_LCODE
                             , X_OUT_PRICE
                             , X_LOW_LIMIT_AMOUNT
                             , X_HIGH_LIMIT_AMOUNT
                             , X_LOW_LIMIT_PRICE_UOM
                             , X_LOW_LIMIT_PRICE
                             , X_SETTING_FEE_AMOUNT
                             , X_SETTING_LIMIT_HOUR
                             , X_LOW_LIMIT_SPEC_VALUE
                             , X_LOW_LIMIT_SPEC_PRICE
                          FROM WIP_OUT_OP_PRICE_LIST   OPL
                         WHERE OPL.OPERATION_ID     = P_OPERATION_ID
                           AND (  (NVL(OPL.OUT_PRICE,0) > 0 AND OPL.PRICE_UOM_CODE   = V_MTX_UOM_CODE)  -- 작업UOM별 단가 SELECT --
                               OR (NVL(OPL.OUT_PRICE,0) = 0 AND 1 = 1))
                           /*AND OPL.PRICE_UOM_CODE   = V_MTX_UOM_CODE  -- 작업UOM별 단가 SELECT --*/
                           AND OPL.PRICE_TYPE_LCODE = 'STANDARD'
                           AND P_TRX_DATE           BETWEEN OPL.EFFECTIVE_DATE_FR + (1/24*8.5)
                                                    AND NVL(OPL.EFFECTIVE_DATE_TO + (1 + (1/24*8.5)), P_TRX_DATE)
                           AND OPL.ENABLED_FLAG     = 'Y'
                           AND (  (NVL(V_QTY_LIMIT_FLAG,'N') = 'N' AND 1 = 1) -- 수량범위별 단가적용, 2011-10-15, BY MJSHIN --
                               OR (NVL(V_QTY_LIMIT_FLAG,'N') = 'Y' AND OPL.QTY_LIMIT_UOM_FLAG = 'Y'
                                                                   AND NVL(OPL.QTY_LIMIT_RANGE_FR,0) <= V_MTX_UOM_QTY
                                                                   AND NVL(OPL.QTY_LIMIT_RANGE_TO,9999999999999) >= V_MTX_UOM_QTY)
                               )
                           ;
                   EXCEPTION WHEN OTHERS THEN
                        X_PRICE_CLASS         := NULL;
                        X_PRICE_TYPE_LCODE    := NULL;
                        X_OUT_PRICE           := NULL;
                        X_LOW_LIMIT_AMOUNT    := NULL;
                        X_HIGH_LIMIT_AMOUNT   := NULL;
                        X_LOW_LIMIT_PRICE_UOM := NULL;
                        X_LOW_LIMIT_PRICE     := NULL;
                        X_SETTING_FEE_AMOUNT  := NULL;
                        X_SETTING_LIMIT_HOUR  := NULL;
                        X_LOW_LIMIT_SPEC_VALUE := NULL;
                        X_LOW_LIMIT_SPEC_PRICE := NULL;
                   END;                   
               END IF;
           
           
           END IF;  
EXCEPTION WHEN OTHERS THEN
     NULL;
END GET_OP_OUT_PRICE;

END WIP_OUT_ADJUST_G;
/
