create or replace package EAPP_COMMON_G
/******************************************************************************/
/* Project      : FLEX ERP
/* Module       : EAPP
/* Program Name : EAPP_COMMON_G
/* Description  : COMMON FUNCTION
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Shin Man Jae       Initialize
/******************************************************************************/
is

  ----------------------------------------
  -- Local Date Return                  --
  ----------------------------------------
   FUNCTION GET_TRX_CLOSE_STATUS_F  ( P_SOB_ID                    IN  NUMBER
                                    , P_ORG_ID                    IN  NUMBER
                                    , P_CLOSE_TYPE                IN  VARCHAR2
                                    , P_TRX_DATE                  IN  DATE) RETURN VARCHAR2;

  ----------------------------------------
  -- INVNETORY TRANSACTION CLOSE 여부   --
  ----------------------------------------
   PROCEDURE GET_TRX_CLOSE_STATUS_P  ( P_SOB_ID                    IN  NUMBER
                                     , P_ORG_ID                    IN  NUMBER
                                     , P_CLOSE_TYPE                IN  VARCHAR2
                                     , P_TRX_DATE                  IN  DATE
                                     , X_CLOSE_STATUS               OUT VARCHAR2) ;

  ----------------------------------------
  -- DEPARTMNET NAME                    --
  ----------------------------------------
   FUNCTION GET_DEPT_NAME ( P_DEPT_ID   IN VARCHAR2 ) RETURN VARCHAR2;

  ----------------------------------------
  -- GET_APPLY_EXCHANGE_RATE_F          --
  ----------------------------------------
   FUNCTION  GET_APPLY_EXCHANGE_RATE_F ( P_SOB_ID                    IN  NUMBER
                                       , P_ORG_ID                    IN  NUMBER
                                       , P_CURRENCY_CODE             IN  VARCHAR2
                                       , P_EXCHANGE_RATE_TYPE        IN  VARCHAR2
                                       , P_BASE_DATE                 IN  DATE) RETURN NUMBER;

  -------------------------------------------------
  -- ARRAY_QTY Convert from WORKING_UOM_QTY      --
  -------------------------------------------------
   FUNCTION GET_ARRAY_FROM_WORKING_UOM_F ( P_BOM_ITEM_ID               IN NUMBER
                                         , P_WORKING_UOM_CODE          IN VARCHAR2
                                         , P_WORKING_UOM_QTY           IN NUMBER) RETURN NUMBER;


  ----------------------------------------
  -- GET_EXCHANGE_RATE_F                --
  ----------------------------------------
   FUNCTION GET_EXCHANGE_RATE_F  ( P_SOB_ID                    IN  NUMBER
                                 , P_ORG_ID                    IN  NUMBER
                                 , P_CURRENCY_CODE             IN  VARCHAR2) RETURN NUMBER;

  ----------------------------------------
  -- GET_EXCHANGE_RATE_P                --
  ----------------------------------------
   PROCEDURE GET_EXCHANGE_RATE_P ( P_SOB_ID                    IN  NUMBER
                                 , P_ORG_ID                    IN  NUMBER
                                 , P_CURRENCY_CODE             IN  VARCHAR2
                                 , X_EXCHANGE_RATE             OUT NUMBER);

  ----------------------------------------
  -- GET_EXCHANGE_RATE_P                --
  ----------------------------------------
   PROCEDURE GET_EXCHANGE_RATE_DATE_P ( P_SOB_ID                 IN  NUMBER
                                 , P_ORG_ID                    IN  NUMBER
                                 , P_APPLY_DATE                IN  DATE
                                 , P_CURRENCY_CODE             IN  VARCHAR2
                                 , X_EXCHANGE_RATE             OUT NUMBER);
                                 
  ----------------------------------------
  -- GET_EXCHANGE_RATE_TRX_F            --
  ----------------------------------------
   FUNCTION  GET_EXCHANGE_RATE_TRX_F ( P_SOB_ID                    IN  NUMBER
                                     , P_ORG_ID                    IN  NUMBER
                                     , P_CURRENCY_CODE             IN  VARCHAR2
                                     , P_TRX_DATE                  IN  DATE) RETURN NUMBER;

  ----------------------------------------
  -- GET_EXCHANGE_RATE_MONTH_END_F      --
  -- >> 월말최초매매기준환율            --
  ----------------------------------------
   FUNCTION  GET_EXCHANGE_RATE_MONTH_END_F ( P_SOB_ID                    IN  NUMBER
                                           , P_ORG_ID                    IN  NUMBER
                                           , P_CURRENCY_CODE             IN  VARCHAR2
                                           , P_TRX_DATE                  IN  DATE) RETURN NUMBER;
                                           
  ----------------------------------------
  -- GET_EXCHANGE_RATE_F                --
  ----------------------------------------
   FUNCTION  GET_EXCHANGE_PLAN_RATE_F  ( P_SOB_ID                    IN  NUMBER
                                       , P_ORG_ID                    IN  NUMBER
                                       , P_BASE_DATE                 IN  DATE
                                       , P_CURRENCY_CODE             IN  VARCHAR2) RETURN NUMBER;

  ----------------------------------------
  -- EXTEND Date Return                  --
  ----------------------------------------
   PROCEDURE GET_EXTEND_DATE_P ( P_SOB_ID                    IN  NUMBER
                               , P_ORG_ID                    IN  NUMBER
                               , P_TRX_DATE                  IN  DATE
                               , X_EXTEND_CALENDAR_ID        OUT NUMBER
                               , X_EXTEND_DATE               OUT DATE);
  
  ----------------------------------------
  -- EXTEND CALENDAR_ID Return          --
  -- BY Y.G LEE 07/17/11                --
  ----------------------------------------
   FUNCTION GET_EXTEND_CALENDAR_ID_F 
            ( P_SOB_ID                    IN  NUMBER
            , P_ORG_ID                    IN  NUMBER
            , P_EXTEND_DATE               IN  DATE) RETURN NUMBER;
            
  -------------------------------------------------
  -- GET_MATERIAL_ITEM_CODE : MAT_ITEM_CODE 채번   --
  -------------------------------------------------
   FUNCTION GET_MATERIAL_ITEM_CODE_F ( P_SOB_ID             IN NUMBER
                                     , P_ORG_ID             IN NUMBER
                                     , P_ITEM_CATEGORY_CODE IN VARCHAR2
                                     , P_ITEM_SECTION_CODE  IN VARCHAR2) RETURN VARCHAR2;

  ----------------------------------------
  -- ITEM CATEGORY DESCRIPTION          --
  ----------------------------------------
   FUNCTION GET_ITEM_CATEGORY_F ( P_INVENTORY_ITEM_ID  IN  NUMBER) RETURN VARCHAR2;
   
  ----------------------------------------
  -- ITEM SECTION DESCRIPTION           --
  ----------------------------------------
   FUNCTION GET_ITEM_SECTION_F ( P_INVENTORY_ITEM_ID  IN  NUMBER) RETURN VARCHAR2;
   
  ----------------------------------------
  -- GET_ITEM_ONHAND : ITEM 현재고량    --
  ----------------------------------------
   FUNCTION GET_ITEM_ONHAND_F ( P_INVENTORY_ITEM_ID  IN NUMBER
                              , P_WAREHOUSE_ID       IN NUMBER
                              , P_LOCATION_ID        IN NUMBER ) RETURN NUMBER;

  ----------------------------------------
  -- GET_ITEM_ONHAND : ITEM 현재고량    --
  ----------------------------------------
   FUNCTION GET_ITEM_ONHAND_F ( P_SOB_ID               IN NUMBER
                              , P_ORG_ID               IN NUMBER
                              , P_INVENTORY_ITEM_CODE  IN VARCHAR2
                              , P_WAREHOUSE_CODE       IN VARCHAR2
                              , P_LOCATION_CODE        IN VARCHAR2 ) RETURN NUMBER;

  ----------------------------------------
  -- GET_ITEM_ONHAND : ITEM 현재고량    --
  ----------------------------------------
   PROCEDURE GET_ITEM_ONHAND_P ( P_INVENTORY_ITEM_ID  IN  NUMBER
                               , P_WAREHOUSE_ID       IN  NUMBER
                               , P_LOCATION_ID        IN  NUMBER
                               , X_ONHAND_QTY         OUT NUMBER);

  ----------------------------------------------------
  -- GET_ITEM_BOX_ONHAND_F : BOX별 ITEM 현재고량    --
  ----------------------------------------------------
   FUNCTION GET_ITEM_BOX_ONHAND_F ( P_INVENTORY_ITEM_ID  IN NUMBER
                                  , P_WAREHOUSE_ID       IN NUMBER
                                  , P_LOCATION_ID        IN NUMBER
                                  , P_PACKING_BOX_NO     IN VARCHAR2) RETURN NUMBER;

  --------------------------------------------------
  -- GET_LAST_ITEM_NET_REV_F : 순제품 최종 REV    --
  --------------------------------------------------
   FUNCTION GET_ITEM_NET_REV_F( P_SOB_ID              IN NUMBER
															, P_ORG_ID              IN NUMBER 
															, P_ITEM_NET_CODE       IN VARCHAR2 
															, P_ITEM_SECTION_FLAG   IN VARCHAR2 DEFAULT 'NORMAL') RETURN VARCHAR2;

  ----------------------------------------------------
  -- GET_LAST_ITEM_NET_REV_F : 순제품명 최종 REV    --
  ----------------------------------------------------
   FUNCTION GET_ITEM_NET_DESC_F ( P_SOB_ID              IN NUMBER
																, P_ORG_ID              IN NUMBER 
																, P_ITEM_NET_CODE       IN VARCHAR2 
																, P_ITEM_SECTION_FLAG   IN VARCHAR2 DEFAULT 'NORMAL') RETURN VARCHAR2;
																					
																		
  ------------------------------------------
  -- GET_ITEM_ONHAND : ITEM 정상재고량    --
  ------------------------------------------
   FUNCTION GET_ITEM_NORMAL_ONHAND_F  ( P_INVENTORY_ITEM_ID  IN NUMBER
                                      , P_WAREHOUSE_ID       IN NUMBER ) RETURN NUMBER;

  --------------------------------------------
  -- GET_ITEM_ONHAND : ITEM 과출고재고량    --
  --------------------------------------------
   FUNCTION GET_ITEM_OVER_ONHAND_F  ( P_INVENTORY_ITEM_ID  IN NUMBER
                                    , P_WAREHOUSE_ID       IN NUMBER ) RETURN NUMBER;

  -------------------------------------------
  -- GET_ITEM_PRIMARY_WH_P : ITEM 주창고   --
  -------------------------------------------
   PROCEDURE GET_ITEM_WAREHOUSE_P  ( P_INVENTORY_ITEM_ID  IN  NUMBER
                                   , X_WAREHOUSE_ID       OUT NUMBER
                                   , X_WAREHOUSE_CODE     OUT VARCHAR2
                                   , X_WAREHOUSE_NAME     OUT VARCHAR2
                                   , X_LOCATION_ID        OUT NUMBER
                                   , X_LOCATION_CODE      OUT VARCHAR2
                                   , X_LOCATION_NAME      OUT VARCHAR2);
                                   
                                                                       
  ----------------------------------------
  -- Local Date Return                  --
  ----------------------------------------
   PROCEDURE GET_LOCAL_DATE_P ( P_SOB_ID                    IN  NUMBER
                              , X_LOCAL_DATE                OUT DATE) ;

  ----------------------------------------
  -- Local Date Return                  --
  ----------------------------------------
   PROCEDURE GET_LOCAL_DATE_TIME_P ( P_SOB_ID                    IN  NUMBER
                                   , X_LOCAL_DATE                OUT DATE);
                                   
  ----------------------------------------
  -- Local Date Return                  --
  ----------------------------------------
   PROCEDURE GET_LOCAL_DATETIME_P ( P_SOB_ID                    IN  NUMBER
                                  , X_LOCAL_DATE                OUT DATE);

  ----------------------------------------
  -- LOOKUP Default Value Return        --
  ----------------------------------------
   PROCEDURE GET_LOOKUP_DEFAULT_VALUE ( P_SOB_ID            IN  NUMBER
                                      , P_ORG_ID            IN  NUMBER
                                      , P_LOOKUP_TYPE       IN  VARCHAR2
                                      , X_ENTRY_CODE        OUT VARCHAR2
                                      , X_ENTRY_DESCRIPTION OUT VARCHAR2
                                      , X_ENTRY_TAG         OUT VARCHAR2
                                      , X_SEGMENT1          OUT VARCHAR2
                                      , X_SEGMENT2          OUT VARCHAR2
                                      , X_SEGMENT3          OUT VARCHAR2
                                      , X_SEGMENT4          OUT VARCHAR2
                                      , X_SEGMENT5          OUT VARCHAR2
                                      , X_ENTRY_ID          OUT NUMBER);

  ----------------------------------------
  -- LOCATION 구분 (정상 / 과출고)      --
  ----------------------------------------
   FUNCTION GET_LOCATION_TYPE_F ( P_LOCATION_ID      IN  NUMBER) RETURN VARCHAR2;
   
  ----------------------------------------
  -- LOOKUP ENTRY Description Return    --
  ----------------------------------------
   FUNCTION GET_LOOKUP_DESC ( P_SOB_ID                    IN NUMBER
                            , P_ORG_ID                    IN NUMBER
                            , P_LOOKUP_TYPE               IN VARCHAR2
                            , P_ENTRY_CODE                IN VARCHAR2 ) RETURN VARCHAR2;

  ----------------------------------------
  -- LOOKUP ENTRY ftp 정보 Return       --
  ----------------------------------------
  PROCEDURE GET_FTP_INFO_P
            ( W_FTP_INFO_CODE      IN VARCHAR2
            , W_SOB_ID             IN NUMBER
            , W_ORG_ID             IN NUMBER
            , O_FTP_IP             OUT VARCHAR2
            , O_FTP_PORT           OUT VARCHAR2
            , O_FTP_USER_ID        OUT VARCHAR2
            , O_FTP_PASSWORD       OUT VARCHAR2
            , O_FTP_SOURCEPATH     OUT VARCHAR2
            , O_CLIENT_TARGETPATH  OUT VARCHAR2
            );
            
  ----------------------------------------
  -- Master No Making Function
  ----------------------------------------
   FUNCTION GET_MASTER_NO( P_SOB_ID         IN NUMBER
                         , P_ORG_ID         IN NUMBER
                         , P_MODULE_CODE    IN VARCHAR2
                         , P_MASTER_TYPE    IN VARCHAR2
                         , P_DATE           IN DATE     ) RETURN VARCHAR2;

  ----------------------------------------
  -- MM_QTY Convert from PCS_QTY        --
  ----------------------------------------
   FUNCTION GET_MM_FROM_PCS_F ( P_INVENTORY_ITEM_ID         IN NUMBER
                              , P_BOM_ITEM_ID               IN NUMBER
                              , P_PCS_QTY                   IN NUMBER) RETURN NUMBER;

  ----------------------------------------
  -- MM_QTY Convert from PCS_QTY        --
  ----------------------------------------
   PROCEDURE GET_MM_FROM_PCS_P ( P_INVENTORY_ITEM_ID         IN NUMBER
                              , P_BOM_ITEM_ID               IN NUMBER
                              , P_PCS_QTY                   IN NUMBER
                              , X_MM_QTY                    OUT NUMBER);

  ----------------------------------------
  -- MM_QTY Convert from UOM_QTY        --
  ----------------------------------------
   FUNCTION GET_MM_FROM_UOM_F ( P_INVENTORY_ITEM_ID         IN NUMBER
                              , P_BOM_ITEM_ID               IN NUMBER
                              , P_UOM_QTY                   IN NUMBER) RETURN NUMBER;

/*  ----------------------------------------
  -- PNL_QTY Convert from UOM_QTY        --
  ----------------------------------------
   FUNCTION GET_PNL_FROM_UOM_F ( P_INVENTORY_ITEM_ID         IN NUMBER
                               , P_BOM_ITEM_ID               IN NUMBER
                               , P_UOM_QTY                   IN NUMBER) RETURN NUMBER;
*/                               

  ----------------------------------------
  -- PCS_QTY Convert from UOM_QTY        --
  ----------------------------------------
   FUNCTION GET_PCS_FROM_UOM_F ( P_INVENTORY_ITEM_ID         IN NUMBER
                               , P_BOM_ITEM_ID               IN NUMBER
                               , P_UOM_QTY                   IN NUMBER) RETURN NUMBER;
                               
                                                              
  ----------------------------------------
  -- PERSON NAME from User_ID             --
  ----------------------------------------
   FUNCTION GET_PERSON_NAME_BY_USER ( P_USER_ID   IN NUMBER ) RETURN VARCHAR2;

  ----------------------------------------
  -- PERSON NAME from User_ID             --
  ----------------------------------------
   FUNCTION GET_PERSON_SNAME_BY_USER ( P_USER_ID   IN NUMBER ) RETURN VARCHAR2;
   
   
  ----------------------------------------
  -- PERSON ID from User_ID             --
  ----------------------------------------
  FUNCTION GET_PERSON_ID_BY_USER ( P_USER_ID   IN NUMBER ) RETURN NUMBER;

  ----------------------------------------
  -- PERSON Info from User_ID           --
  ----------------------------------------
   PROCEDURE GET_PERSON_BY_USER ( P_USER_ID      IN  NUMBER
                                , X_PERSON_ID    OUT NUMBER
                                , X_PERSON_NAME  OUT VARCHAR2
                                , X_PERSON_NO    OUT VARCHAR2
                                , X_DISPLAY_NAME OUT VARCHAR2
                                , X_DEPT_ID      OUT NUMBER
                                , X_DEPT_CODE    OUT VARCHAR2
                                , X_DEPT_NAME    OUT VARCHAR2);
  ----------------------------------------
  -- PERSON NAME                        --
  ----------------------------------------
   FUNCTION GET_PERSON_NAME ( P_PERSON_ID   IN NUMBER ) RETURN VARCHAR2;


  ----------------------------------------
  -- PCS_PER_PNL_QTY (합수)             --
  ----------------------------------------
   FUNCTION GET_PCS_PER_PNL_QTY_F ( P_BOM_ITEM_ID               IN NUMBER) RETURN NUMBER;

  ----------------------------------------
  -- PCS_PER_MM_QTY (산출수)            --
  ----------------------------------------
   FUNCTION GET_PCS_PER_MM_QTY_F ( P_BOM_ITEM_ID               IN NUMBER) RETURN NUMBER;

  -------------------------------------------------
  -- PCS_QTY Convert from WORKING_UOM_QTY        --
  -------------------------------------------------
   FUNCTION GET_PCS_FROM_WORKING_UOM_F ( P_BOM_ITEM_ID               IN NUMBER
                                       , P_WORKING_UOM_CODE          IN VARCHAR2
                                       , P_WORKING_UOM_QTY           IN NUMBER) RETURN NUMBER;

  ----------------------------------------
  -- PNL_QTY Convert from PCS_QTY       --
  ----------------------------------------
   FUNCTION GET_PNL_FROM_PCS_F ( P_INVENTORY_ITEM_ID         IN NUMBER
                               , P_BOM_ITEM_ID               IN NUMBER
                               , P_PCS_QTY                   IN NUMBER) RETURN NUMBER;

  ----------------------------------------
  -- PNL_QTY Convert from PCS_QTY       --
  ----------------------------------------
   PROCEDURE GET_PNL_FROM_PCS_P  ( P_INVENTORY_ITEM_ID       IN  NUMBER
                                 , P_BOM_ITEM_ID               IN  NUMBER
                                 , P_PCS_QTY                   IN  NUMBER
                                 , X_PNL_QTY                   OUT NUMBER);

  ----------------------------------------
  -- PNL_QTY Convert from UOM_QTY        --
  ----------------------------------------
   FUNCTION GET_PNL_FROM_UOM_F ( P_INVENTORY_ITEM_ID         IN NUMBER
                               , P_BOM_ITEM_ID               IN NUMBER
                               , P_UOM_QTY                   IN NUMBER) RETURN NUMBER;

  -------------------------------------------------
  -- PNL_QTY Convert from WORKING_UOM_QTY        --
  -------------------------------------------------
   FUNCTION GET_PNL_FROM_WORKING_UOM_F ( P_BOM_ITEM_ID               IN NUMBER
                                       , P_WORKING_UOM_CODE          IN VARCHAR2
                                       , P_WORKING_UOM_QTY           IN NUMBER) RETURN NUMBER;

  ----------------------------------------
  -- Reason Entry Description Return    --
  ----------------------------------------
   FUNCTION GET_REASON_DESC ( P_SOB_ID                    IN NUMBER
                            , P_ORG_ID                    IN NUMBER
                            , P_REASON_TYPE               IN VARCHAR2
                            , P_REASON_CODE               IN VARCHAR2
                            , P_REASON_ID                 IN NUMBER ) RETURN VARCHAR2;


  ----------------------------------------
  -- PROCESS STEP DESCRIPTION (STATUS)  --
  ----------------------------------------
   FUNCTION GET_STATUS_DESC ( P_SOB_ID        IN  NUMBER
                            , P_ORG_ID        IN  NUMBER
                            , P_PROCESS_TYPE  IN  VARCHAR2
                            , P_STEP_CODE     IN  VARCHAR2 ) RETURN VARCHAR2;

  ----------------------------------------
  -- Transaction Type ID Return         --
  ----------------------------------------
   FUNCTION GET_TRX_TYPE_ID_F ( P_SOB_ID        IN  NUMBER
                              , P_ORG_ID        IN  NUMBER
                              , P_TRX_TYPE      IN  VARCHAR2) RETURN NUMBER;


  ----------------------------------------
  -- Transaction Type  Return           --
  ----------------------------------------
   FUNCTION GET_TRX_TYPE_DESC_F ( P_TRX_TYPE_ID      IN  NUMBER) RETURN VARCHAR2;

  ----------------------------------------
  -- Transaction CLASS ID Return         --
  ----------------------------------------
   FUNCTION GET_TRX_CLASS_ID_F ( P_SOB_ID         IN  NUMBER
                               , P_ORG_ID         IN  NUMBER
                               , P_TRX_TYPE       IN  VARCHAR2) RETURN NUMBER;

  ----------------------------------------
  -- Transaction Type  Return           --
  ----------------------------------------
   FUNCTION GET_TRX_CLASS_DESC_F ( P_TRX_CLASS_ID      IN  NUMBER) RETURN VARCHAR2;

  ----------------------------------------
  -- GET_UOM_CONVERSION_QTY_F  Return   --
  -- UOM 환산량 산출                    --
  ----------------------------------------
   FUNCTION GET_UOM_CONVERT_QTY_F  ( P_INVENTORY_ITEM_ID IN  NUMBER
                                   , P_FROM_UOM_CODE     IN  VARCHAR2
                                   , P_TO_UOM_CODE       IN  VARCHAR2
                                   , P_QTY               IN  NUMBER) RETURN NUMBER;

  ----------------------------------------
  -- GET_WAREHOUSE_TYPE_F  Return        --
  ----------------------------------------
   FUNCTION GET_WAREHOUSE_TYPE_F ( P_WAREHOUSE_ID      IN  NUMBER) RETURN VARCHAR2;
   
  ----------------------------------------
  -- Default Location ID  Return        --
  ----------------------------------------
   FUNCTION GET_WH_DEFAULT_LOCATION_ID_F ( P_SOB_ID            IN  NUMBER
                                         , P_WAREHOUSE_ID      IN  NUMBER) RETURN NUMBER;

  ----------------------------------------
  -- Default Warehouse (생산창고)       --
  ----------------------------------------
   PROCEDURE GET_WH_DEFAULT_FG_WIP_P( P_SOB_ID            IN   NUMBER
                                    , P_ORG_ID            IN   NUMBER
                                    , X_WAREHOUSE_ID      OUT  NUMBER
                                    , X_WAREHOUSE_CODE    OUT  VARCHAR2
                                    , X_WAREHOUSE_NAME    OUT  VARCHAR2
                                    , X_LOCATION_ID       OUT  NUMBER
                                    , X_LOCATION_CODE     OUT  VARCHAR2
                                    , X_LOCATION_NAME     OUT  VARCHAR2);

  ----------------------------------------
  -- Default Warehouse (영업제품창고)   --
  ----------------------------------------
   PROCEDURE GET_WH_DEFAULT_FG_MAIN_P ( P_SOB_ID            IN   NUMBER
                                      , P_ORG_ID            IN   NUMBER
                                      , X_WAREHOUSE_ID      OUT  NUMBER
                                      , X_WAREHOUSE_CODE    OUT  VARCHAR2
                                      , X_WAREHOUSE_NAME    OUT  VARCHAR2
                                      , X_LOCATION_ID       OUT  NUMBER
                                      , X_LOCATION_CODE     OUT  VARCHAR2
                                      , X_LOCATION_NAME     OUT  VARCHAR2) ;

  ----------------------------------------
  -- Default Warehouse (잉여제품창고)   --
  ----------------------------------------
   PROCEDURE GET_WH_DEFAULT_FG_SURPLUS_P  ( P_SOB_ID            IN   NUMBER
                                          , P_ORG_ID            IN   NUMBER
                                          , X_WAREHOUSE_ID      OUT  NUMBER
                                          , X_WAREHOUSE_CODE    OUT  VARCHAR2
                                          , X_WAREHOUSE_NAME    OUT  VARCHAR2
                                          , X_LOCATION_ID       OUT  NUMBER
                                          , X_LOCATION_CODE     OUT  VARCHAR2
                                          , X_LOCATION_NAME     OUT  VARCHAR2);

  ----------------------------------------
  -- Default Warehouse (제품적송창고)   --
  ----------------------------------------
   PROCEDURE GET_WH_DEFAULT_FG_SHIP_P ( P_SOB_ID            IN   NUMBER
                                      , P_ORG_ID            IN   NUMBER
                                      , X_WAREHOUSE_ID      OUT  NUMBER
                                      , X_WAREHOUSE_CODE    OUT  VARCHAR2
                                      , X_WAREHOUSE_NAME    OUT  VARCHAR2
                                      , X_LOCATION_ID       OUT  NUMBER
                                      , X_LOCATION_CODE     OUT  VARCHAR2
                                      , X_LOCATION_NAME     OUT  VARCHAR2) ;

  ----------------------------------------
  -- Default Warehouse (제품반품창고)   --
  ----------------------------------------
   PROCEDURE GET_WH_DEFAULT_FG_RETURN_P ( P_SOB_ID            IN   NUMBER
                                        , P_ORG_ID            IN   NUMBER
                                        , X_WAREHOUSE_ID      OUT  NUMBER
                                        , X_WAREHOUSE_CODE    OUT  VARCHAR2
                                        , X_WAREHOUSE_NAME    OUT  VARCHAR2
                                        , X_LOCATION_ID       OUT  NUMBER
                                        , X_LOCATION_CODE     OUT  VARCHAR2
                                        , X_LOCATION_NAME     OUT  VARCHAR2) ;

  ----------------------------------------
  -- Default Warehouse (제품불용창고)   --
  ----------------------------------------
   PROCEDURE GET_WH_DEFAULT_FG_SCRAP_P  ( P_SOB_ID            IN   NUMBER
                                        , P_ORG_ID            IN   NUMBER
                                        , X_WAREHOUSE_ID      OUT  NUMBER
                                        , X_WAREHOUSE_CODE    OUT  VARCHAR2
                                        , X_WAREHOUSE_NAME    OUT  VARCHAR2
                                        , X_LOCATION_ID       OUT  NUMBER
                                        , X_LOCATION_CODE     OUT  VARCHAR2
                                        , X_LOCATION_NAME     OUT  VARCHAR2);

  ----------------------------------------
  -- Default Warehouse (자재 주창고)   --
  ----------------------------------------
   PROCEDURE GET_WH_DEFAULT_MAT_MAIN_P  ( P_SOB_ID            IN   NUMBER
                                        , P_ORG_ID            IN   NUMBER
                                        , X_WAREHOUSE_ID      OUT  NUMBER
                                        , X_WAREHOUSE_CODE    OUT  VARCHAR2
                                        , X_WAREHOUSE_NAME    OUT  VARCHAR2
                                        , X_LOCATION_ID       OUT  NUMBER
                                        , X_LOCATION_CODE     OUT  VARCHAR2
                                        , X_LOCATION_NAME     OUT  VARCHAR2) ;

  ----------------------------------------
  -- Default Warehouse (반제품주창고)   --
  ----------------------------------------
   PROCEDURE GET_WH_DEFAULT_SG_MAIN_P  ( P_SOB_ID            IN   NUMBER
                                        , P_ORG_ID            IN   NUMBER
                                        , X_WAREHOUSE_ID      OUT  NUMBER
                                        , X_WAREHOUSE_CODE    OUT  VARCHAR2
                                        , X_WAREHOUSE_NAME    OUT  VARCHAR2
                                        , X_LOCATION_ID       OUT  NUMBER
                                        , X_LOCATION_CODE     OUT  VARCHAR2
                                        , X_LOCATION_NAME     OUT  VARCHAR2) ;

  ----------------------------------------
  -- Over Location ID  Return           --
  ----------------------------------------
   FUNCTION GET_WH_OVER_LOCATION_ID_F ( P_SOB_ID            IN  NUMBER
                                      , P_WAREHOUSE_ID      IN  NUMBER) RETURN NUMBER;

  ----------------------------------------
  -- String to Table_Rows            --
  ----------------------------------------
   PROCEDURE SET_STR_SPLIT_ROWS ( P_STR      IN  VARCHAR2
                                , P_CHAR     IN  VARCHAR2);

  ----------------------------------------
  -- Get Column Value Fuction           --
  ----------------------------------------
   FUNCTION GET_COLUMN_VALUE_F ( P_TABLE_NAME       IN   VARCHAR2
                               , P_SELECT_COLUMN    IN   VARCHAR2
                               , P_WHERE_CLAUSE     IN   VARCHAR2 ) RETURN VARCHAR2;

  ----------------------------------------
  -- Get Column Value Procedure         --
  ----------------------------------------
   PROCEDURE GET_COLUMN_VALUE_P ( P_TABLE_NAME       IN   VARCHAR2
                                , P_SELECT_COLUMN    IN   VARCHAR2
                                , P_WHERE_CLAUSE     IN   VARCHAR2
                                , X_COLUMN_VALUE     OUT  VARCHAR2
                                , X_RESULT_STATUS    OUT  VARCHAR2
                                , X_RESULT_MSG       OUT  VARCHAR2 );

  ------------------------------------------
  -- Get Sales Order Line Charge Fuction  --
  ------------------------------------------
   FUNCTION GET_ORDER_LINE_CHARGE_F ( W_ORDER_LINE_ID       IN   NUMBER
                                    , P_VALUE_QTY           IN   NUMBER ) RETURN NUMBER;

  ------------------------------------------
  -- Get Workcenter_ID from Resource_ID   --
  ------------------------------------------
   FUNCTION GET_WORKCENTER_F ( W_RESOURCE_ID       IN   NUMBER) RETURN NUMBER;

  ----------------------------------------
  -- Get PNL Size X, Y Fuction          --
  ----------------------------------------
   FUNCTION GET_PNL_SIZE_F ( P_INVENTORY_ITEM_ID    IN NUMBER ) RETURN VARCHAR2;

  ----------------------------------------
  -- Get PCS PER PNL Qty Fuction        --
  ----------------------------------------
   FUNCTION GET_PCS_INVENTORY_ITEM_F ( P_INVENTORY_ITEM_ID    IN NUMBER ) RETURN NUMBER;

  ----------------------------------------
  -- 공정 체공시간 산출                 --
  ----------------------------------------
   FUNCTION GET_WIP_TRX_DELAY_TIME_F ( P_JOB_ID           IN NUMBER 
                                     , P_OPERATION_SEQ_NO IN NUMBER
                                     , P_OPERATION_ID     IN NUMBER) RETURN VARCHAR2;
                                     
  ----------------------------------------
  -- 서버 현재일시 기준 월 첫일        --
  ----------------------------------------
   FUNCTION GET_MONTH_FIRST_DAY_F (P_SOB_ID IN NUMBER) RETURN DATE;
  
  ----------------------------------------
  -- 서버 현재일시 기준 월 마지막일     --
  ----------------------------------------
   FUNCTION GET_MONTH_LAST_DAY_F (P_SOB_ID IN NUMBER) RETURN DATE;
   
  --------------------------------
  -- 당일 마지막일시 (long date)  --
  --------------------------------
   FUNCTION GET_END_OF_DAY_F
            ( P_DATE         IN  DATE) RETURN DATE;
                                     
end EAPP_COMMON_G; 
/
create or replace package body EAPP_COMMON_G
/******************************************************************************/
/* Project      : FLEX ERP
/* Module       : EAPP
/* Program Name : EAPP_COMMON_G
/* Description  : COMMON FUNCTION
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Shin Man Jae       Initialize
/******************************************************************************/
is

  ----------------------------------------
  -- INVNETORY TRANSACTION CLOSE 여부   --
  ----------------------------------------
   FUNCTION GET_TRX_CLOSE_STATUS_F  ( P_SOB_ID                    IN  NUMBER
                                    , P_ORG_ID                    IN  NUMBER
                                    , P_CLOSE_TYPE                IN  VARCHAR2
                                    , P_TRX_DATE                  IN  DATE) RETURN VARCHAR2
   AS
      X_CLOSE_STATUS    VARCHAR2(30);
      V_TRX_CLOSE_FLAG  VARCHAR2(10);
      V_COST_CLOSE_FLAG VARCHAR2(10);
      V_PERIOD_NAME     VARCHAR2(10);
      V_TRX_LOCK_FLAG   VARCHAR2(10); -- ADDED, 2012-09-17, BY MJSHIN
   BEGIN
        ----------------------------------------
        -- CLOSE_TYPE : MAT / WIP / FG        --
        ----------------------------------------

        V_PERIOD_NAME := TO_CHAR(P_TRX_DATE, 'YYYY-MM');

        BEGIN
             SELECT ITMC.TRX_CLOSE_FLAG
                  , ITMC.COST_CLOSE_FLAG
                  , ITMC.TRX_LOCK_FLAG
               INTO V_TRX_CLOSE_FLAG
                  , V_COST_CLOSE_FLAG
                  , V_TRX_LOCK_FLAG
               FROM INV_CLOSE_PERIOD   ITMC
              WHERE ITMC.SOB_ID             = P_SOB_ID
                AND ITMC.ORG_ID             = P_ORG_ID
                AND ITMC.CLOSE_TYPE         = P_CLOSE_TYPE
                AND ITMC.PERIOD_NAME        = V_PERIOD_NAME
                ;
        EXCEPTION WHEN OTHERS THEN
             V_TRX_CLOSE_FLAG := 'N';
             V_COST_CLOSE_FLAG := 'N';
        END;

        IF NVL(V_TRX_CLOSE_FLAG,'N') = 'Y' OR NVL(V_COST_CLOSE_FLAG,'N') = 'Y' OR NVL(V_TRX_CLOSE_FLAG,'N') = 'Y' THEN
            X_CLOSE_STATUS := 'CLOSE';
        ELSE
            X_CLOSE_STATUS := 'OPEN';
        END IF;

        RETURN X_CLOSE_STATUS;

   END GET_TRX_CLOSE_STATUS_F;

  ----------------------------------------
  -- INVNETORY TRANSACTION CLOSE 여부   --
  ----------------------------------------
   PROCEDURE GET_TRX_CLOSE_STATUS_P  ( P_SOB_ID                    IN  NUMBER
                                     , P_ORG_ID                    IN  NUMBER
                                     , P_CLOSE_TYPE                IN  VARCHAR2
                                     , P_TRX_DATE                  IN  DATE
                                     , X_CLOSE_STATUS               OUT VARCHAR2)
   AS
      V_PERIOD_NAME     VARCHAR2(10);
      V_TRX_CLOSE_FLAG  VARCHAR2(10);
      V_COST_CLOSE_FLAG VARCHAR2(10);
      V_TRX_LOCK_FLAG   VARCHAR2(10); -- ADDED, 2012-09-17, BY MJSHIN
   BEGIN
        ----------------------------------------
        -- CLOSE_TYPE : MAT / WIP / FG        --
        ----------------------------------------

        V_PERIOD_NAME := TO_CHAR(P_TRX_DATE, 'YYYY-MM');

        BEGIN
             SELECT ITMC.TRX_CLOSE_FLAG
                  , ITMC.COST_CLOSE_FLAG
                  , ITMC.TRX_LOCK_FLAG
               INTO V_TRX_CLOSE_FLAG
                  , V_COST_CLOSE_FLAG
                  , V_TRX_LOCK_FLAG
               FROM INV_CLOSE_PERIOD   ITMC
              WHERE ITMC.SOB_ID             = P_SOB_ID
                AND ITMC.ORG_ID             = P_ORG_ID
                AND ITMC.CLOSE_TYPE         = P_CLOSE_TYPE
                AND ITMC.PERIOD_NAME        = V_PERIOD_NAME
                ;
        EXCEPTION WHEN OTHERS THEN
             V_TRX_CLOSE_FLAG := 'N';
             V_COST_CLOSE_FLAG := 'N';
        END;

        IF NVL(V_TRX_CLOSE_FLAG,'N') = 'Y' OR NVL(V_COST_CLOSE_FLAG,'N') = 'Y' OR NVL(V_TRX_CLOSE_FLAG,'N') = 'Y' THEN
            X_CLOSE_STATUS := 'CLOSE';
        ELSE
            X_CLOSE_STATUS := 'OPEN';
        END IF;


   END GET_TRX_CLOSE_STATUS_P;


  ----------------------------------------
  -- DEPARTMENT NAME                    --
  ----------------------------------------
   FUNCTION GET_DEPT_NAME ( P_DEPT_ID   IN VARCHAR2 ) RETURN VARCHAR2
   AS
        X_DEPT_NAME     VARCHAR2(200) := NULL;
   BEGIN

         BEGIN
               SELECT HDM.DEPT_NAME
                 INTO X_DEPT_NAME
                 FROM HRM_DEPT_MASTER    HDM
                WHERE HDM.DEPT_ID        = P_DEPT_ID
                  ;
         EXCEPTION WHEN OTHERS THEN
                X_DEPT_NAME := NULL;
         END;


         RETURN X_DEPT_NAME;

   END GET_DEPT_NAME;

  ----------------------------------------
  -- GET_APPLY_EXCHANGE_RATE_F          --
  ----------------------------------------
   FUNCTION  GET_APPLY_EXCHANGE_RATE_F ( P_SOB_ID                    IN  NUMBER
                                       , P_ORG_ID                    IN  NUMBER
                                       , P_CURRENCY_CODE             IN  VARCHAR2
                                       , P_EXCHANGE_RATE_TYPE        IN  VARCHAR2
                                       , P_BASE_DATE                 IN  DATE) RETURN NUMBER
   AS
      X_BASIC_CURRENCY_CODE            VARCHAR2(10);
      X_EXCHANGE_RATE                  NUMBER;
   BEGIN
       X_BASIC_CURRENCY_CODE := FI_ACCOUNT_BOOK_G.BASE_CURRENCY_F(P_SOB_ID);

       IF NVL(P_CURRENCY_CODE, X_BASIC_CURRENCY_CODE) != X_BASIC_CURRENCY_CODE THEN
          IF P_EXCHANGE_RATE_TYPE = 'BASE' THEN

                BEGIN
                    SELECT EER.BASE_RATE
                      INTO X_EXCHANGE_RATE
                      FROM EAPP_EXCHANGE_RATE  EER
                     WHERE EER.SOB_ID          = P_SOB_ID
                       AND EER.ORG_ID          = P_ORG_ID
                       AND EER.FROM_CURRENCY   = P_CURRENCY_CODE
                       AND EER.TO_CURRENCY     = X_BASIC_CURRENCY_CODE
                       AND EER.APPLY_DATE      = (SELECT MAX(EE.APPLY_DATE)
                                                    FROM EAPP_EXCHANGE_RATE EE
                                                   WHERE EE.SOB_ID          = P_SOB_ID
                                                     AND EE.ORG_ID          = P_ORG_ID
                                                     AND EE.FROM_CURRENCY   = P_CURRENCY_CODE
                                                     AND EE.TO_CURRENCY     = X_BASIC_CURRENCY_CODE
                                                     AND EE.APPLY_DATE     <= P_BASE_DATE + 1)
                       AND ROWNUM                    = 1
                       ;
                EXCEPTION WHEN OTHERS THEN
                      X_EXCHANGE_RATE := 0;
                END;

          ELSIF P_EXCHANGE_RATE_TYPE = 'PLAN' THEN

                BEGIN
                    SELECT EER.STD_RATE
                      INTO X_EXCHANGE_RATE
                      FROM EAPP_PLAN_EXCHANGE_RATE  EER
                     WHERE EER.SOB_ID          = P_SOB_ID
                       AND EER.ORG_ID          = P_ORG_ID
                       AND EER.FROM_CURRENCY_CODE   = P_CURRENCY_CODE
                       AND EER.TO_CURRENCY_CODE     = X_BASIC_CURRENCY_CODE
                       AND TRUNC(P_BASE_DATE)  BETWEEN EER.APPLY_START_DATE
                                                   AND EER.APPLY_END_DATE
                       AND ROWNUM                  = 1
                      ;
                EXCEPTION WHEN OTHERS THEN
                      X_EXCHANGE_RATE := 0;
                END;
          ELSE
                X_EXCHANGE_RATE := -1;
          END IF;

       ELSE
             X_EXCHANGE_RATE := 1;
       END IF;

       RETURN X_EXCHANGE_RATE;


   END GET_APPLY_EXCHANGE_RATE_F;

  -------------------------------------------------
  -- ARRAY_QTY Convert from WORKING_UOM_QTY      --
  -------------------------------------------------
   FUNCTION GET_ARRAY_FROM_WORKING_UOM_F ( P_BOM_ITEM_ID               IN NUMBER
                                         , P_WORKING_UOM_CODE          IN VARCHAR2
                                         , P_WORKING_UOM_QTY           IN NUMBER) RETURN NUMBER
   AS
        V_ARRAY_PER_PNL_QTY NUMBER;
        V_PCS_PER_ARRAY_QTY NUMBER;
        X_ARRAY_QTY         NUMBER;
   BEGIN

        ---------------------
        -- GET PCS_PER_PNL --
        -- GET PNL_SIZE_X  --
        -- GET PNL_SIZE_Y  --
        ---------------------
        BEGIN
              SELECT SIS.ARRAY_PER_PNL_QTY
                   , SIS.PCS_PER_ARRAY_QTY
                INTO V_ARRAY_PER_PNL_QTY
                   , V_PCS_PER_ARRAY_QTY
                FROM SDM_ITEM_SPEC   SIS
               WHERE SIS.BOM_ITEM_ID = P_BOM_ITEM_ID;
         EXCEPTION WHEN OTHERS THEN
              V_ARRAY_PER_PNL_QTY := 0;
              V_PCS_PER_ARRAY_QTY := 0;
         END;

         ---------------------
         -- QTY CONVERT     --
         ---------------------
         IF    P_WORKING_UOM_CODE = 'PNL' THEN
                 X_ARRAY_QTY := P_WORKING_UOM_QTY * V_ARRAY_PER_PNL_QTY;
         ELSIF P_WORKING_UOM_CODE = 'ARRAY' THEN
                 X_ARRAY_QTY := P_WORKING_UOM_QTY;
         ELSIF P_WORKING_UOM_CODE = 'PCS' THEN
               IF V_PCS_PER_ARRAY_QTY != 0 THEN
                   X_ARRAY_QTY := P_WORKING_UOM_QTY / V_PCS_PER_ARRAY_QTY;
               ELSE
                   X_ARRAY_QTY := 0;
               END IF;
         ELSE
               X_ARRAY_QTY := 0;
         END IF;

         RETURN X_ARRAY_QTY;

   END GET_ARRAY_FROM_WORKING_UOM_F;

  ----------------------------------------
  -- GET_DESIGN_BOM_COMPONENT_F         --
  -- BOM구성품 표시                     --
  ----------------------------------------
   FUNCTION  GET_DESIGN_BOM_COMPONENT_F( P_BOM_ITEM_ID          IN  NUMBER
                                       , P_OPERATION_SEQ_NO     IN  NUMBER) RETURN VARCHAR2
   AS
      X_COMPONENT_LIST   VARCHAR2(2000);
      V_STD_ROUTING_ID   NUMBER;

   BEGIN

       BEGIN
            SELECT SSR.STD_ROUTING_ID
              INTO V_STD_ROUTING_ID
              FROM SDM_STANDARD_ROUTING  SSR
             WHERE SSR.BOM_ITEM_ID       = P_BOM_ITEM_ID
               AND SSR.OPERATION_SEQ_NO  = P_OPERATION_SEQ_NO
            ;
       EXCEPTION WHEN OTHERS THEN
           V_STD_ROUTING_ID := NULL;
       END;

       FOR REC IN (SELECT SSB.COMPONENT_INV_ITEM_ID
                        , IIM.ITEM_CODE
                        , IIM.ITEM_DESCRIPTION
                        , IIM.ITEM_SPECIFICATION
                     FROM SDM_STANDARD_BOM  SSB
                        , INV_ITEM_MASTER   IIM
                    WHERE IIM.INVENTORY_ITEM_ID = SSB.COMPONENT_INV_ITEM_ID
                      AND SSB.BOM_ITEM_ID       = P_BOM_ITEM_ID
                      AND SSB.STD_ROUTING_ID    = V_STD_ROUTING_ID
                    ORDER BY IIM.ITEM_CODE)
       LOOP
            X_COMPONENT_LIST := X_COMPONENT_LIST || CHR(10)
                                || '[' || REC.ITEM_CODE || '][' || REC.ITEM_DESCRIPTION || '][' || REC.ITEM_SPECIFICATION || ']' ;

       END LOOP;

       RETURN X_COMPONENT_LIST;


   END GET_DESIGN_BOM_COMPONENT_F;


  ----------------------------------------
  -- GET_EXCHANGE_RATE_F                --
  ----------------------------------------
   FUNCTION  GET_EXCHANGE_RATE_F ( P_SOB_ID                    IN  NUMBER
                                 , P_ORG_ID                    IN  NUMBER
                                 , P_CURRENCY_CODE             IN  VARCHAR2) RETURN NUMBER
   AS
      X_BASIC_CURRENCY_CODE            VARCHAR2(10);
      X_EXCHANGE_RATE   NUMBER;
   BEGIN
       X_BASIC_CURRENCY_CODE := FI_ACCOUNT_BOOK_G.BASE_CURRENCY_F(P_SOB_ID);

       IF NVL(P_CURRENCY_CODE, X_BASIC_CURRENCY_CODE) != X_BASIC_CURRENCY_CODE THEN
          BEGIN
              SELECT EER.BASE_RATE
                INTO X_EXCHANGE_RATE
                FROM EAPP_EXCHANGE_RATE  EER
               WHERE EER.SOB_ID          = P_SOB_ID
                 AND EER.ORG_ID          = P_ORG_ID
                 AND EER.FROM_CURRENCY   = P_CURRENCY_CODE
                 AND EER.TO_CURRENCY     = X_BASIC_CURRENCY_CODE
                 AND EER.APPLY_DATE      = (SELECT MAX(EE.APPLY_DATE)
                                              FROM EAPP_EXCHANGE_RATE EE
                                             WHERE EE.SOB_ID          = P_SOB_ID
                                               AND EE.ORG_ID          = P_ORG_ID
                                               AND EE.FROM_CURRENCY   = P_CURRENCY_CODE
                                               AND EE.TO_CURRENCY     = X_BASIC_CURRENCY_CODE
                                               AND EE.APPLY_DATE     <= SYSDATE + 1);
          EXCEPTION WHEN OTHERS THEN
                X_EXCHANGE_RATE := 0;
          END;

       ELSE
             X_EXCHANGE_RATE := 1;
       END IF;

       RETURN X_EXCHANGE_RATE;


   END GET_EXCHANGE_RATE_F;

  ----------------------------------------
  -- GET_EXCHANGE_RATE_P                --
  ----------------------------------------
   PROCEDURE GET_EXCHANGE_RATE_P ( P_SOB_ID                    IN  NUMBER
                                 , P_ORG_ID                    IN  NUMBER
                                 , P_CURRENCY_CODE             IN  VARCHAR2
                                 , X_EXCHANGE_RATE             OUT NUMBER)
   AS
     X_BASIC_CURRENCY_CODE            VARCHAR2(10);

   BEGIN
       X_BASIC_CURRENCY_CODE := FI_ACCOUNT_BOOK_G.BASE_CURRENCY_F(P_SOB_ID);

       IF NVL(P_CURRENCY_CODE, X_BASIC_CURRENCY_CODE) != X_BASIC_CURRENCY_CODE THEN
          BEGIN
              SELECT EER.BASE_RATE
                INTO X_EXCHANGE_RATE
                FROM EAPP_EXCHANGE_RATE  EER
               WHERE EER.SOB_ID          = P_SOB_ID
                 AND EER.ORG_ID          = P_ORG_ID
                 AND EER.FROM_CURRENCY   = P_CURRENCY_CODE
                 AND EER.TO_CURRENCY     = X_BASIC_CURRENCY_CODE
                 AND EER.APPLY_DATE      = (SELECT MAX(EE.APPLY_DATE)
                                              FROM EAPP_EXCHANGE_RATE EE
                                             WHERE EE.SOB_ID          = P_SOB_ID
                                               AND EE.ORG_ID          = P_ORG_ID
                                               AND EE.FROM_CURRENCY   = P_CURRENCY_CODE
                                               AND EE.TO_CURRENCY     = X_BASIC_CURRENCY_CODE
                                               AND EE.APPLY_DATE     <= SYSDATE + 1);
          EXCEPTION WHEN OTHERS THEN
                X_EXCHANGE_RATE := 0;
          END;

       ELSE
             X_EXCHANGE_RATE := 1;
       END IF;

   END GET_EXCHANGE_RATE_P;

  ----------------------------------------
  -- GET_EXCHANGE_RATE_P                --
  ----------------------------------------
   PROCEDURE GET_EXCHANGE_RATE_DATE_P ( P_SOB_ID                 IN  NUMBER
                                 , P_ORG_ID                    IN  NUMBER
                                 , P_APPLY_DATE                IN  DATE
                                 , P_CURRENCY_CODE             IN  VARCHAR2
                                 , X_EXCHANGE_RATE             OUT NUMBER)
   AS
     X_BASIC_CURRENCY_CODE            VARCHAR2(10);     
   BEGIN
     X_EXCHANGE_RATE := 0;
     X_BASIC_CURRENCY_CODE := FI_ACCOUNT_BOOK_G.BASE_CURRENCY_F(P_SOB_ID);
     IF NVL(P_CURRENCY_CODE, X_BASIC_CURRENCY_CODE) != X_BASIC_CURRENCY_CODE THEN
       BEGIN
         SELECT EER.BASE_RATE
           INTO X_EXCHANGE_RATE
           FROM EAPP_EXCHANGE_RATE  EER
          WHERE EER.SOB_ID           = P_SOB_ID
             AND EER.ORG_ID          = P_ORG_ID
             AND EER.APPLY_DATE      = P_APPLY_DATE
             AND EER.FROM_CURRENCY   = P_CURRENCY_CODE
             AND EER.TO_CURRENCY     = X_BASIC_CURRENCY_CODE
         ;
       EXCEPTION WHEN OTHERS THEN
         NULL;
       END;
     END IF;
        
   END GET_EXCHANGE_RATE_DATE_P;
      
  ----------------------------------------
  -- GET_EXCHANGE_RATE_TRX_F            --
  ----------------------------------------
   FUNCTION  GET_EXCHANGE_RATE_TRX_F ( P_SOB_ID                    IN  NUMBER
                                     , P_ORG_ID                    IN  NUMBER
                                     , P_CURRENCY_CODE             IN  VARCHAR2
                                     , P_TRX_DATE                  IN  DATE) RETURN NUMBER
   AS
      X_BASIC_CURRENCY_CODE   VARCHAR2(10);
      X_EXCHANGE_RATE         NUMBER;
      V_LOCAL_DATE            DATE := TRUNC(get_local_date(P_SOB_ID));
   BEGIN
       X_BASIC_CURRENCY_CODE := FI_ACCOUNT_BOOK_G.BASE_CURRENCY_F(P_SOB_ID);

       IF NVL(P_CURRENCY_CODE, X_BASIC_CURRENCY_CODE) != X_BASIC_CURRENCY_CODE THEN
          BEGIN
              SELECT EER.BASE_RATE
                INTO X_EXCHANGE_RATE
                FROM EAPP_EXCHANGE_RATE  EER
               WHERE EER.SOB_ID          = P_SOB_ID
                 AND EER.ORG_ID          = P_ORG_ID
                 AND EER.FROM_CURRENCY   = P_CURRENCY_CODE
                 AND EER.TO_CURRENCY     = X_BASIC_CURRENCY_CODE
                 AND EER.APPLY_DATE      = (SELECT MAX(EE.APPLY_DATE)
                                              FROM EAPP_EXCHANGE_RATE EE
                                             WHERE EE.SOB_ID          = P_SOB_ID
                                               AND EE.ORG_ID          = P_ORG_ID
                                               AND EE.FROM_CURRENCY   = P_CURRENCY_CODE
                                               AND EE.TO_CURRENCY     = X_BASIC_CURRENCY_CODE
                                               AND EE.APPLY_DATE     <= NVL(TRUNC(P_TRX_DATE),V_LOCAL_DATE));
          EXCEPTION WHEN OTHERS THEN
                X_EXCHANGE_RATE := 0;
          END;

       ELSE
             X_EXCHANGE_RATE := 1;
       END IF;

       RETURN X_EXCHANGE_RATE;


   END GET_EXCHANGE_RATE_TRX_F;

  ----------------------------------------
  -- GET_EXCHANGE_RATE_MONTH_END_F      --
  -- >> 월말최초매매기준환율            --
  ----------------------------------------
   FUNCTION  GET_EXCHANGE_RATE_MONTH_END_F ( P_SOB_ID                    IN  NUMBER
                                           , P_ORG_ID                    IN  NUMBER
                                           , P_CURRENCY_CODE             IN  VARCHAR2
                                           , P_TRX_DATE                  IN  DATE) RETURN NUMBER
   AS
      X_BASIC_CURRENCY_CODE   VARCHAR2(10);
      X_EXCHANGE_RATE         NUMBER;
      V_LOCAL_DATE            DATE := TRUNC(get_local_date(P_SOB_ID));
      V_MONTH_DAY_TO          DATE;
   BEGIN
       X_BASIC_CURRENCY_CODE := FI_ACCOUNT_BOOK_G.BASE_CURRENCY_F(P_SOB_ID);
       
       V_MONTH_DAY_TO := LAST_DAY(P_TRX_DATE);

       IF NVL(P_CURRENCY_CODE, X_BASIC_CURRENCY_CODE) != X_BASIC_CURRENCY_CODE THEN
          BEGIN
              SELECT EER.BASE_RATE
                INTO X_EXCHANGE_RATE
                FROM EAPP_EXCHANGE_RATE  EER
               WHERE EER.SOB_ID          = P_SOB_ID
                 AND EER.ORG_ID          = P_ORG_ID
                 AND EER.FROM_CURRENCY   = P_CURRENCY_CODE
                 AND EER.TO_CURRENCY     = X_BASIC_CURRENCY_CODE
                 AND EER.APPLY_DATE      = TRUNC(V_MONTH_DAY_TO);
          EXCEPTION WHEN OTHERS THEN
                X_EXCHANGE_RATE := 0;
          END;

       ELSE
             X_EXCHANGE_RATE := 1;
       END IF;

       RETURN X_EXCHANGE_RATE;


   END GET_EXCHANGE_RATE_MONTH_END_F;
   
  ----------------------------------------
  -- GET_EXCHANGE_RATE_F                --
  ----------------------------------------
   FUNCTION  GET_EXCHANGE_PLAN_RATE_F  ( P_SOB_ID                    IN  NUMBER
                                       , P_ORG_ID                    IN  NUMBER
                                       , P_BASE_DATE                 IN  DATE
                                       , P_CURRENCY_CODE             IN  VARCHAR2) RETURN NUMBER
   AS
      X_BASIC_CURRENCY_CODE            VARCHAR2(10);
      X_EXCHANGE_RATE   NUMBER;
   BEGIN
       X_BASIC_CURRENCY_CODE := FI_ACCOUNT_BOOK_G.BASE_CURRENCY_F(P_SOB_ID);

       IF NVL(P_CURRENCY_CODE, X_BASIC_CURRENCY_CODE) != X_BASIC_CURRENCY_CODE THEN
          BEGIN
              SELECT EER.STD_RATE
                INTO X_EXCHANGE_RATE
                FROM EAPP_PLAN_EXCHANGE_RATE  EER
               WHERE EER.SOB_ID          = P_SOB_ID
                 AND EER.ORG_ID          = P_ORG_ID
                 AND EER.FROM_CURRENCY_CODE   = P_CURRENCY_CODE
                 AND EER.TO_CURRENCY_CODE     = X_BASIC_CURRENCY_CODE
                 AND TRUNC(P_BASE_DATE)  BETWEEN EER.APPLY_START_DATE
                                             AND EER.APPLY_END_DATE
                ;
          EXCEPTION WHEN OTHERS THEN
                X_EXCHANGE_RATE := 0;
          END;

       ELSE
             X_EXCHANGE_RATE := 1;
       END IF;

       RETURN X_EXCHANGE_RATE;


   END GET_EXCHANGE_PLAN_RATE_F;

  ----------------------------------------
  -- EXTEND Date Return                  --
  ----------------------------------------
   PROCEDURE GET_EXTEND_DATE_P ( P_SOB_ID                    IN  NUMBER
                               , P_ORG_ID                    IN  NUMBER
                               , P_TRX_DATE                  IN  DATE
                               , X_EXTEND_CALENDAR_ID        OUT NUMBER
                               , X_EXTEND_DATE               OUT DATE)
   AS
      V_LOCAL_DATE             DATE := TRUNC(get_local_date(P_SOB_ID));
      V_TIME_INTERVAL_VALUE    NUMBER;
      V_TRUNC_DATE             DATE;
   BEGIN

      V_TRUNC_DATE := TRUNC(P_TRX_DATE);


      BEGIN
         SELECT EDR.TIME_INTERVAL_VALUE
           INTO V_TIME_INTERVAL_VALUE
           FROM EAPP_EXTEND_DATE_RULE  EDR
          WHERE EDR.SOB_ID             = P_SOB_ID
            AND EDR.ORG_ID             = P_ORG_ID
            AND V_LOCAL_DATE           BETWEEN NVL(EDR.FROM_DATE, V_LOCAL_DATE)
                                           AND NVL(EDR.TO_DATE,   V_LOCAL_DATE)
         ;
      EXCEPTION WHEN OTHERS THEN
           V_TIME_INTERVAL_VALUE := 0;
      END;

      IF P_TRX_DATE - V_TRUNC_DATE = 0 THEN
          X_EXTEND_DATE := TRUNC(P_TRX_DATE);
      ELSE
          X_EXTEND_DATE := TRUNC(P_TRX_DATE - (1/24 * V_TIME_INTERVAL_VALUE));
      END IF;

      BEGIN
        SELECT EEC.EXTEND_CALENDAR_ID
          INTO X_EXTEND_CALENDAR_ID
          FROM EAPP_EXTEND_CALENDAR  EEC
         WHERE EEC.SOB_ID            = P_SOB_ID
           AND EEC.ORG_ID            = P_ORG_ID
           AND EEC.EXTEND_DATE       = TRUNC(X_EXTEND_DATE)
           ;
      EXCEPTION WHEN OTHERS THEN
          X_EXTEND_CALENDAR_ID := 0;
      END;

   END GET_EXTEND_DATE_P;
   
    ----------------------------------------
  -- EXTEND CALENDAR_ID Return          --
  -- BY Y.G LEE 07/17/11                --
  ----------------------------------------
   FUNCTION GET_EXTEND_CALENDAR_ID_F 
            ( P_SOB_ID                    IN  NUMBER
            , P_ORG_ID                    IN  NUMBER
            , P_EXTEND_DATE               IN  DATE) RETURN NUMBER
   AS
      V_EXTEND_CALENDAR_ID NUMBER;
   BEGIN
         SELECT EEC.EXTEND_CALENDAR_ID
           INTO V_EXTEND_CALENDAR_ID
           FROM EAPP_EXTEND_CALENDAR EEC
          WHERE EEC.EXTEND_DATE = P_EXTEND_DATE
            AND EEC.SOB_ID      = P_SOB_ID
            AND EEC.ORG_ID      = P_ORG_ID
          ;
          
          RETURN V_EXTEND_CALENDAR_ID;
   EXCEPTION WHEN OTHERS THEN
          V_EXTEND_CALENDAR_ID := -1;
          RETURN V_EXTEND_CALENDAR_ID;
   END GET_EXTEND_CALENDAR_ID_F;
   
  -------------------------------------------------
  -- GET_MATERIAL_ITEM_CODE : MAT_ITEM_CODE 채번   --
  -------------------------------------------------
   FUNCTION GET_MATERIAL_ITEM_CODE_F ( P_SOB_ID             IN NUMBER
                                     , P_ORG_ID             IN NUMBER
                                     , P_ITEM_CATEGORY_CODE IN VARCHAR2
                                     , P_ITEM_SECTION_CODE  IN VARCHAR2) RETURN VARCHAR2
   AS
        V_CODE_SEQ            VARCHAR2(100);
        V_CODE_ATTRIBUTE      VARCHAR2(100);
        X_MATERIAL_ITEM_CODE  VARCHAR2(100) := NULL;
   BEGIN
         BEGIN
              SELECT IIC.ATTRIBUTE_A
                INTO V_CODE_ATTRIBUTE
                FROM INV_ITEM_CATEGORY  IIC
               WHERE IIC.SOB_ID         = P_SOB_ID
                 AND IIC.ORG_ID         = P_ORG_ID
                 AND IIC.ITEM_CATEGORY_CODE = P_ITEM_CATEGORY_CODE
                 ;
         EXCEPTION WHEN OTHERS THEN
             V_CODE_ATTRIBUTE := NULL;
         END;

         BEGIN
              SELECT NVL(TO_CHAR(MAX(TO_NUMBER(SUBSTR(IIM.ITEM_CODE,6,5))) + 1,'00000'),'00001')
                INTO V_CODE_SEQ
                FROM INV_ITEM_MASTER IIM
               WHERE IIM.SOB_ID             = P_SOB_ID
                 AND IIM.ORG_ID             = P_ORG_ID
                 AND IIM.ITEM_DIVISION_CODE = 'MATERIAL'
                 AND IIM.ITEM_CATEGORY_CODE = P_ITEM_CATEGORY_CODE
                 AND IIM.ITEM_SECTION_CODE  = P_ITEM_SECTION_CODE
                 ;
         EXCEPTION WHEN OTHERS THEN
              V_CODE_SEQ := NULL;
         END;

         IF V_CODE_ATTRIBUTE IS NULL OR V_CODE_SEQ IS NULL THEN
             X_MATERIAL_ITEM_CODE := 'ERROR';
         ELSE
             X_MATERIAL_ITEM_CODE := REPLACE(V_CODE_ATTRIBUTE || P_ITEM_SECTION_CODE || V_CODE_SEQ,' ','');
         END IF;


         RETURN X_MATERIAL_ITEM_CODE;

   END GET_MATERIAL_ITEM_CODE_F;

  ----------------------------------------
  -- ITEM CATEGORY DESCRIPTION          --
  ----------------------------------------
   FUNCTION GET_ITEM_CATEGORY_F ( P_INVENTORY_ITEM_ID  IN  NUMBER) RETURN VARCHAR2
   AS
        X_CATEGORY_DESC            VARCHAR2(100);
   BEGIN

         BEGIN
               SELECT IIC.DESCRIPTION
                 INTO X_CATEGORY_DESC
                 FROM INV_ITEM_MASTER    IIM
                    , INV_ITEM_CATEGORY  IIC
                WHERE IIC.SOB_ID             = IIM.SOB_ID
                  AND IIC.ORG_ID             = IIM.ORG_ID
                  AND IIC.ITEM_CATEGORY_CODE = IIM.ITEM_CATEGORY_CODE
                  AND IIM.INVENTORY_ITEM_ID  = P_INVENTORY_ITEM_ID
                ;
         EXCEPTION WHEN OTHERS THEN
               X_CATEGORY_DESC := NULL;
         END;
         
         RETURN X_CATEGORY_DESC;

   END GET_ITEM_CATEGORY_F;
   
  ----------------------------------------
  -- ITEM SECTION DESCRIPTION           --
  ----------------------------------------
   FUNCTION GET_ITEM_SECTION_F ( P_INVENTORY_ITEM_ID  IN  NUMBER) RETURN VARCHAR2
   AS
        X_SECTION_DESC            VARCHAR2(100);
   BEGIN

         BEGIN
               SELECT IIS.DESCRIPTION
                 INTO X_SECTION_DESC
                 FROM INV_ITEM_MASTER   IIM
                    , INV_ITEM_SECTION  IIS
                WHERE IIS.SOB_ID            = IIM.SOB_ID
                  AND IIS.ORG_ID            = IIM.ORG_ID
                  AND IIS.ITEM_SECTION_CODE = IIM.ITEM_SECTION_CODE
                  AND IIM.INVENTORY_ITEM_ID = P_INVENTORY_ITEM_ID
                ;
         EXCEPTION WHEN OTHERS THEN
               X_SECTION_DESC := NULL;
         END;
         
         RETURN X_SECTION_DESC;

   END GET_ITEM_SECTION_F;
   
  ----------------------------------------
  -- GET_ITEM_ONHAND : ITEM 현재고량    --
  ----------------------------------------
   FUNCTION GET_ITEM_ONHAND_F ( P_INVENTORY_ITEM_ID  IN NUMBER
                              , P_WAREHOUSE_ID       IN NUMBER
                              , P_LOCATION_ID        IN NUMBER ) RETURN NUMBER
   AS
        X_ONHAND_QTY   NUMBER := 0;
   BEGIN

         BEGIN
               SELECT SUM(IIO.ONHAND_QTY) ONHAND_QTY
                 INTO X_ONHAND_QTY
                 FROM INV_ITEM_ONHAND  IIO
                WHERE IIO.INVENTORY_ITEM_ID = P_INVENTORY_ITEM_ID
                  AND IIO.WAREHOUSE_ID      = NVL(P_WAREHOUSE_ID, IIO.WAREHOUSE_ID)
                  AND IIO.LOCATION_ID       = NVL(P_LOCATION_ID, IIO.LOCATION_ID)
                  ;
         EXCEPTION WHEN OTHERS THEN
                X_ONHAND_QTY := 0;
         END;


         RETURN X_ONHAND_QTY;

   END GET_ITEM_ONHAND_F;

  ----------------------------------------
  -- GET_ITEM_ONHAND : ITEM 현재고량    --
  ----------------------------------------
   FUNCTION GET_ITEM_ONHAND_F ( P_SOB_ID               IN NUMBER
                              , P_ORG_ID               IN NUMBER
                              , P_INVENTORY_ITEM_CODE  IN VARCHAR2
                              , P_WAREHOUSE_CODE       IN VARCHAR2
                              , P_LOCATION_CODE        IN VARCHAR2 ) RETURN NUMBER
   AS
        X_ONHAND_QTY          NUMBER := 0;
        V_INVENTORY_ITEM_ID   NUMBER;
        V_WAREHOUSE_ID        NUMBER;
        V_LOCATION_ID         NUMBER;
   BEGIN

         BEGIN
              SELECT IIM.INVENTORY_ITEM_ID
                INTO V_INVENTORY_ITEM_ID
                FROM INV_ITEM_MASTER  IIM
               WHERE IIM.SOB_ID       = P_SOB_ID
                 AND IIM.ORG_ID       = P_ORG_ID
                 AND IIM.ITEM_CODE    = P_INVENTORY_ITEM_CODE
                 ;
         EXCEPTION WHEN OTHERS THEN
               V_INVENTORY_ITEM_ID := 0;
         END;

         BEGIN
               SELECT IW.WAREHOUSE_ID
                 INTO V_WAREHOUSE_ID
                 FROM INV_WAREHOUSE  IW
                WHERE IW.SOB_ID      = P_SOB_ID
                  AND IW.ORG_ID      = P_ORG_ID
                  AND IW.WAREHOUSE_CODE = P_WAREHOUSE_CODE
                  ;
         EXCEPTION WHEN OTHERS THEN
               V_WAREHOUSE_ID := NULL;
         END;

         BEGIN
               SELECT WL.WH_LOCATION_ID
                 INTO V_LOCATION_ID
                 FROM INV_WH_LOCATION  WL
                WHERE WL.SOB_ID        = P_SOB_ID
                  AND WL.ORG_ID        = P_ORG_ID
                  AND WL.LOCATION_CODE = P_LOCATION_CODE
                  ;
         EXCEPTION WHEN OTHERS THEN
               V_LOCATION_ID := NULL;
         END;

         BEGIN
               SELECT SUM(IIO.ONHAND_QTY) ONHAND_QTY
                 INTO X_ONHAND_QTY
                 FROM INV_ITEM_ONHAND  IIO
                WHERE IIO.INVENTORY_ITEM_ID = V_INVENTORY_ITEM_ID
                  AND IIO.WAREHOUSE_ID      = NVL(V_WAREHOUSE_ID, IIO.WAREHOUSE_ID)
                  AND IIO.LOCATION_ID       = NVL(V_LOCATION_ID, IIO.LOCATION_ID)
                  ;
         EXCEPTION WHEN OTHERS THEN
                X_ONHAND_QTY := 0;
         END;


         RETURN X_ONHAND_QTY;

   END GET_ITEM_ONHAND_F;

  ----------------------------------------
  -- GET_ITEM_ONHAND : ITEM 현재고량    --
  ----------------------------------------
   PROCEDURE GET_ITEM_ONHAND_P ( P_INVENTORY_ITEM_ID  IN  NUMBER
                               , P_WAREHOUSE_ID       IN  NUMBER
                               , P_LOCATION_ID        IN  NUMBER
                               , X_ONHAND_QTY         OUT NUMBER)
   AS
   BEGIN

         BEGIN
               SELECT SUM(IIO.ONHAND_QTY) ONHAND_QTY
                 INTO X_ONHAND_QTY
                 FROM INV_ITEM_ONHAND  IIO
                WHERE IIO.INVENTORY_ITEM_ID = P_INVENTORY_ITEM_ID
                  AND IIO.WAREHOUSE_ID      = NVL(P_WAREHOUSE_ID, IIO.WAREHOUSE_ID)
                  AND IIO.LOCATION_ID       = NVL(P_LOCATION_ID, IIO.LOCATION_ID)
                  ;
         EXCEPTION WHEN OTHERS THEN
                X_ONHAND_QTY := 0;
         END;



   END GET_ITEM_ONHAND_P;

  ----------------------------------------------------
  -- GET_ITEM_BOX_ONHAND_F : BOX별 ITEM 현재고량    --
  ----------------------------------------------------
   FUNCTION GET_ITEM_BOX_ONHAND_F ( P_INVENTORY_ITEM_ID  IN NUMBER
                                  , P_WAREHOUSE_ID       IN NUMBER
                                  , P_LOCATION_ID        IN NUMBER
                                  , P_PACKING_BOX_NO     IN VARCHAR2) RETURN NUMBER
   AS
        X_ONHAND_QTY   NUMBER := 0;
   BEGIN

         BEGIN
               SELECT SUM(IIO.ONHAND_QTY) ONHAND_QTY
                 INTO X_ONHAND_QTY
                 FROM INV_ITEM_ONHAND  IIO
                WHERE IIO.INVENTORY_ITEM_ID = P_INVENTORY_ITEM_ID
                  AND IIO.WAREHOUSE_ID      = NVL(P_WAREHOUSE_ID, IIO.WAREHOUSE_ID)
                  AND IIO.LOCATION_ID       = NVL(P_LOCATION_ID, IIO.LOCATION_ID)
                  AND IIO.PACKING_BOX_NO    = NVL(P_PACKING_BOX_NO, IIO.PACKING_BOX_NO)
                  ;
         EXCEPTION WHEN OTHERS THEN
                X_ONHAND_QTY := 0;
         END;


         RETURN X_ONHAND_QTY;

   END GET_ITEM_BOX_ONHAND_F;


  ---------------------------------------------
  -- GET_ITEM_NET_REV_F : 순제품 최종 REV    --
  ---------------------------------------------
   FUNCTION GET_ITEM_NET_REV_F( P_SOB_ID              IN NUMBER
															, P_ORG_ID              IN NUMBER 
															, P_ITEM_NET_CODE       IN VARCHAR2 
															, P_ITEM_SECTION_FLAG   IN VARCHAR2 DEFAULT 'NORMAL') RETURN VARCHAR2
   AS
	   V_ITEM_NET_REV        VARCHAR2(10);
	 BEGIN
	   BEGIN
				SELECT MAX(IIM.ITEM_NET_REV) AS ITEM_NET_REV
				  INTO V_ITEM_NET_REV 
					FROM INV_ITEM_MASTER IIM
				WHERE IIM.ITEM_CATEGORY_CODE    = 'FG'
					AND IIM.ITEM_NET_CODE         = P_ITEM_NET_CODE
					AND IIM.SOB_ID                = P_SOB_ID
					AND IIM.ORG_ID                = P_ORG_ID
					AND ((P_ITEM_SECTION_FLAG     = 'ALL' AND 1 = 1)
					 OR  (P_ITEM_SECTION_FLAG     != 'ALL' AND IIM.ITEM_SECTION_CODE = P_ITEM_SECTION_FLAG))
        ;
		 EXCEPTION
		   WHEN OTHERS THEN
			   V_ITEM_NET_REV := 'AA';
	   END;
		 RETURN V_ITEM_NET_REV;
	 END GET_ITEM_NET_REV_F;
	 
  -----------------------------------------------
  -- GET_ITEM_NET_REV_F : 순제품명 최종 REV    --
  -----------------------------------------------
   FUNCTION GET_ITEM_NET_DESC_F ( P_SOB_ID              IN NUMBER
																, P_ORG_ID              IN NUMBER 
																, P_ITEM_NET_CODE       IN VARCHAR2 
																, P_ITEM_SECTION_FLAG   IN VARCHAR2 DEFAULT 'NORMAL') RETURN VARCHAR2
   AS
	   V_ITEM_NET_DESC       VARCHAR2(150);
	 BEGIN
	   BEGIN
				SELECT IIM.ITEM_DESCRIPTION AS ITEM_NET_DESC 
				  INTO V_ITEM_NET_DESC 
					FROM INV_ITEM_MASTER IIM
				WHERE IIM.ITEM_CATEGORY_CODE    = 'FG'
					AND IIM.ITEM_NET_CODE         = P_ITEM_NET_CODE
					AND IIM.SOB_ID                = P_SOB_ID
					AND IIM.ORG_ID                = P_ORG_ID
					AND IIM.ITEM_NET_REV          = EAPP_COMMON_G.GET_ITEM_NET_REV_F(P_SOB_ID, P_ORG_ID, P_ITEM_NET_CODE, P_ITEM_SECTION_FLAG)
        ;
		 EXCEPTION
		   WHEN OTHERS THEN
			   V_ITEM_NET_DESC := NULL;
	   END;
		 RETURN V_ITEM_NET_DESC;
	 END GET_ITEM_NET_DESC_F;
	 

  ------------------------------------------
  -- GET_ITEM_ONHAND : ITEM 정상재고량    --
  ------------------------------------------
   FUNCTION GET_ITEM_NORMAL_ONHAND_F  ( P_INVENTORY_ITEM_ID  IN NUMBER
                                      , P_WAREHOUSE_ID       IN NUMBER ) RETURN NUMBER
   AS
        X_ONHAND_QTY   NUMBER := 0;
   BEGIN

         BEGIN
               SELECT NVL(SUM(IIO.ONHAND_QTY),0) ONHAND_QTY
                 INTO X_ONHAND_QTY
                 FROM INV_ITEM_ONHAND  IIO
                    , INV_WH_LOCATION  WL
                WHERE IIO.INVENTORY_ITEM_ID = P_INVENTORY_ITEM_ID
                  AND IIO.WAREHOUSE_ID      = P_WAREHOUSE_ID
                  AND WL.WH_LOCATION_ID     = IIO.LOCATION_ID
                  AND NVL(WL.OVER_STOCK_FLAG,'N') = 'N'
                  ;
         EXCEPTION WHEN OTHERS THEN
                X_ONHAND_QTY := 0;
         END;


         RETURN X_ONHAND_QTY;

   END GET_ITEM_NORMAL_ONHAND_F;

  --------------------------------------------
  -- GET_ITEM_ONHAND : ITEM 과출고재고량    --
  --------------------------------------------
   FUNCTION GET_ITEM_OVER_ONHAND_F  ( P_INVENTORY_ITEM_ID  IN NUMBER
                                    , P_WAREHOUSE_ID       IN NUMBER ) RETURN NUMBER
   AS
        X_ONHAND_QTY   NUMBER := 0;
   BEGIN

         BEGIN
               SELECT NVL(SUM(IIO.ONHAND_QTY),0) ONHAND_QTY
                 INTO X_ONHAND_QTY
                 FROM INV_ITEM_ONHAND  IIO
                    , INV_WH_LOCATION  WL
                WHERE IIO.INVENTORY_ITEM_ID = P_INVENTORY_ITEM_ID
                  AND IIO.WAREHOUSE_ID      = P_WAREHOUSE_ID
                  AND WL.WH_LOCATION_ID     = IIO.LOCATION_ID
                  AND NVL(WL.OVER_STOCK_FLAG,'N') = 'Y'
                  ;
         EXCEPTION WHEN OTHERS THEN
                X_ONHAND_QTY := 0;
         END;


         RETURN X_ONHAND_QTY;

   END GET_ITEM_OVER_ONHAND_F;

  -------------------------------------------
  -- GET_ITEM_PRIMARY_WH_P : ITEM 주창고   --
  -------------------------------------------
   PROCEDURE GET_ITEM_WAREHOUSE_P  ( P_INVENTORY_ITEM_ID  IN  NUMBER
                                   , X_WAREHOUSE_ID       OUT NUMBER
                                   , X_WAREHOUSE_CODE     OUT VARCHAR2
                                   , X_WAREHOUSE_NAME     OUT VARCHAR2
                                   , X_LOCATION_ID        OUT NUMBER
                                   , X_LOCATION_CODE      OUT VARCHAR2
                                   , X_LOCATION_NAME      OUT VARCHAR2)
   AS
     V_SOB_ID   NUMBER;
     V_ORG_ID   NUMBER;
   BEGIN

         BEGIN
               SELECT IIM.SOB_ID
                    , IIM.ORG_ID
                    , IIM.STORE_WAREHOUSE_CODE
                 INTO V_SOB_ID
                    , V_ORG_ID
                    , X_WAREHOUSE_CODE
                 FROM INV_ITEM_MASTER  IIM
                WHERE IIM.INVENTORY_ITEM_ID = P_INVENTORY_ITEM_ID
                  ;
         EXCEPTION WHEN OTHERS THEN
                V_SOB_ID         := NULL;
                V_ORG_ID         := NULL;
                X_WAREHOUSE_CODE := NULL;
         END;
         
         IF X_WAREHOUSE_CODE IS NULL THEN
              X_WAREHOUSE_ID   := NULL;
              X_WAREHOUSE_NAME := NULL;
              X_LOCATION_ID    := NULL;
              X_LOCATION_CODE  := NULL;
              X_LOCATION_NAME  := NULL;
         ELSE
              BEGIN
                   SELECT IW.WAREHOUSE_ID
                        , IW.WAREHOUSE_NAME
                     INTO X_WAREHOUSE_ID
                        , X_WAREHOUSE_NAME
                     FROM INV_WAREHOUSE  IW
                    WHERE IW.SOB_ID         = V_SOB_ID
                      AND IW.ORG_ID         = V_ORG_ID
                      AND IW.WAREHOUSE_CODE = X_WAREHOUSE_CODE
                      ;
              EXCEPTION WHEN OTHERS THEN
                   X_WAREHOUSE_ID   := NULL;
                   X_WAREHOUSE_NAME := NULL;
              END;
              
              BEGIN
                   SELECT IL.WH_LOCATION_ID
                        , IL.LOCATION_CODE
                        , IL.LOCATION_NAME
                     INTO X_LOCATION_ID
                        , X_LOCATION_CODE
                        , X_LOCATION_NAME
                     FROM INV_WH_LOCATION  IL
                    WHERE IL.WAREHOUSE_ID  = X_WAREHOUSE_ID 
                      AND IL.PRIMARY_FLAG  = 'Y'
                      AND ROWNUM           = 1
                      ;
              EXCEPTION WHEN OTHERS THEN
                   X_LOCATION_ID    := NULL;
                   X_LOCATION_CODE  := NULL;
                   X_LOCATION_NAME  := NULL;
              END;
              
         END IF;             

   END GET_ITEM_WAREHOUSE_P;
   

  ----------------------------------------
  -- Local Date Return                  --
  ----------------------------------------
   PROCEDURE GET_LOCAL_DATE_P ( P_SOB_ID                    IN  NUMBER
                              , X_LOCAL_DATE                OUT DATE)
   AS
   BEGIN

         X_LOCAL_DATE := TRUNC(get_local_date(P_SOB_ID));

   END GET_LOCAL_DATE_P;
   
  ----------------------------------------
  -- Local Date Return                  --
  ----------------------------------------
   PROCEDURE GET_LOCAL_DATE_TIME_P ( P_SOB_ID                    IN  NUMBER
                                   , X_LOCAL_DATE                OUT DATE)
   AS
   BEGIN

         X_LOCAL_DATE := get_local_date(P_SOB_ID);

   END GET_LOCAL_DATE_TIME_P;   

  ----------------------------------------
  -- Local Date Return                  --
  ----------------------------------------
   PROCEDURE GET_LOCAL_DATETIME_P ( P_SOB_ID                    IN  NUMBER
                                  , X_LOCAL_DATE                OUT DATE)
   AS
   BEGIN

         X_LOCAL_DATE := get_local_date(P_SOB_ID);

   END GET_LOCAL_DATETIME_P;
  ----------------------------------------
  -- LOOKUP Default Value Return        --
  ----------------------------------------
   PROCEDURE GET_LOOKUP_DEFAULT_VALUE ( P_SOB_ID            IN  NUMBER
                                      , P_ORG_ID            IN  NUMBER
                                      , P_LOOKUP_TYPE       IN  VARCHAR2
                                      , X_ENTRY_CODE        OUT VARCHAR2
                                      , X_ENTRY_DESCRIPTION OUT VARCHAR2
                                      , X_ENTRY_TAG         OUT VARCHAR2
                                      , X_SEGMENT1          OUT VARCHAR2
                                      , X_SEGMENT2          OUT VARCHAR2
                                      , X_SEGMENT3          OUT VARCHAR2
                                      , X_SEGMENT4          OUT VARCHAR2
                                      , X_SEGMENT5          OUT VARCHAR2
                                      , X_ENTRY_ID          OUT NUMBER)
   AS
      V_LOCAL_DATE  DATE := TRUNC(get_local_date(P_SOB_ID));
   BEGIN

         BEGIN
               SELECT ELE.ENTRY_CODE
                    , ELE.ENTRY_DESCRIPTION
                    , ELE.ENTRY_TAG
                    , ELE.SEGMENT1
                    , ELE.SEGMENT2
                    , ELE.SEGMENT3
                    , ELE.SEGMENT4
                    , ELE.SEGMENT5
                    , ELE.LOOKUP_ENTRY_ID
                 INTO X_ENTRY_CODE
                    , X_ENTRY_DESCRIPTION
                    , X_ENTRY_TAG
                    , X_SEGMENT1
                    , X_SEGMENT2
                    , X_SEGMENT3
                    , X_SEGMENT4
                    , X_SEGMENT5
                    , X_ENTRY_ID
                 FROM EAPP_LOOKUP_ENTRY_TLV  ELE
                WHERE ELE.SOB_ID                = P_SOB_ID
                  AND ELE.ORG_ID                = P_ORG_ID
                  AND ELE.LOOKUP_TYPE           = P_LOOKUP_TYPE
                  AND NVL(ELE.DEFAULT_FLAG,'N') = 'Y'
                  AND V_LOCAL_DATE              BETWEEN ELE.EFFECTIVE_DATE_FR
                                                    AND NVL(ELE.EFFECTIVE_DATE_TO, V_LOCAL_DATE)
                  AND NVL(ELE.ENABLED_FLAG,'N') = 'Y'
                  AND ROWNUM                    = 1
                  ;
         EXCEPTION WHEN OTHERS THEN
               X_ENTRY_CODE         := NULL;
               X_ENTRY_DESCRIPTION  := NULL;
               X_ENTRY_TAG          := NULL;
               X_SEGMENT1           := NULL;
               X_SEGMENT2           := NULL;
               X_SEGMENT3           := NULL;
               X_SEGMENT4           := NULL;
               X_SEGMENT5           := NULL;
               X_ENTRY_ID           := NULL;
         END;

   END GET_LOOKUP_DEFAULT_VALUE;

  ----------------------------------------
  -- LOCATION 구분 (정상 / 과출고)      --
  ----------------------------------------
   FUNCTION GET_LOCATION_TYPE_F ( P_LOCATION_ID      IN  NUMBER) RETURN VARCHAR2
   AS
        X_LOCATION_TYPE            VARCHAR2(100);
        V_OVER_STOCK_FLAG          VARCHAR2(1);

   BEGIN

         BEGIN
               SELECT NVL(IL.OVER_STOCK_FLAG,'N')
                 INTO V_OVER_STOCK_FLAG
                 FROM INV_WH_LOCATION   IL
                WHERE IL.WH_LOCATION_ID = P_LOCATION_ID
                ;
         EXCEPTION WHEN OTHERS THEN
                V_OVER_STOCK_FLAG      :='N';
         END;
         
         IF V_OVER_STOCK_FLAG = 'Y' THEN
              X_LOCATION_TYPE := 'OVER';
         ELSE
              X_LOCATION_TYPE := 'NORMAL';
         END IF;
         
         RETURN X_LOCATION_TYPE;

   END GET_LOCATION_TYPE_F;
   
  ----------------------------------------
  -- LOOKUP ENTRY Description Return    --
  ----------------------------------------
   FUNCTION GET_LOOKUP_DESC ( P_SOB_ID                    IN NUMBER
                            , P_ORG_ID                    IN NUMBER
                            , P_LOOKUP_TYPE               IN VARCHAR2
                            , P_ENTRY_CODE                IN VARCHAR2 ) RETURN VARCHAR2
   AS
        X_ENTRY_DESC     VARCHAR2(200) := NULL;
   BEGIN

         BEGIN
               SELECT ELE.ENTRY_DESCRIPTION
                 INTO X_ENTRY_DESC
                 FROM EAPP_LOOKUP_ENTRY_TLV  ELE
                WHERE ELE.SOB_ID         = P_SOB_ID
                  AND ELE.ORG_ID         = P_ORG_ID
                  AND ELE.LOOKUP_TYPE    = P_LOOKUP_TYPE
                  AND ELE.ENTRY_CODE     = P_ENTRY_CODE
                  AND ROWNUM             = 1
                  ;
         EXCEPTION WHEN OTHERS THEN
                X_ENTRY_DESC := NULL;
         END;


         RETURN X_ENTRY_DESC;

   END GET_LOOKUP_DESC;

  ----------------------------------------
  -- LOOKUP ENTRY ftp 정보 Return       --
  ----------------------------------------
  PROCEDURE GET_FTP_INFO_P
            ( W_FTP_INFO_CODE      IN VARCHAR2
            , W_SOB_ID             IN NUMBER
            , W_ORG_ID             IN NUMBER
            , O_FTP_IP             OUT VARCHAR2
            , O_FTP_PORT           OUT VARCHAR2
            , O_FTP_USER_ID        OUT VARCHAR2
            , O_FTP_PASSWORD       OUT VARCHAR2
            , O_FTP_SOURCEPATH     OUT VARCHAR2
            , O_CLIENT_TARGETPATH  OUT VARCHAR2
            )
  AS
  BEGIN
    BEGIN
      SELECT LE.SEGMENT1 AS FTP_IP
           , LE.ENTRY_TAG AS FTP_PORT
           , LE.SEGMENT2 AS USER_ID
           , LE.SEGMENT3 AS PASSWORD
           , LE.SEGMENT4 AS SOURCEPATH
           , LE.SEGMENT5 AS TARGETPATH
        INTO O_FTP_IP
           , O_FTP_PORT
           , O_FTP_USER_ID
           , O_FTP_PASSWORD
           , O_FTP_SOURCEPATH
           , O_CLIENT_TARGETPATH
        FROM EAPP_LOOKUP_ENTRY LE
      WHERE LE.LOOKUP_TYPE        = 'FTP_INFO'
        AND LE.ENTRY_CODE         = W_FTP_INFO_CODE
        AND LE.SOB_ID             = W_SOB_ID
        AND LE.ORG_ID             = W_ORG_ID
        AND ROWNUM                <= 1
      ;
    EXCEPTION WHEN OTHERS THEN
      O_FTP_IP := NULL;
      O_FTP_PORT := NULL;
      O_FTP_USER_ID := NULL;
      O_FTP_PASSWORD := NULL;
      O_FTP_SOURCEPATH := NULL;
      O_CLIENT_TARGETPATH := NULL;
    END;
  END GET_FTP_INFO_P;
  
  ----------------------------------------
  -- Master No Making Function
  ----------------------------------------
   FUNCTION GET_MASTER_NO( P_SOB_ID         IN NUMBER
                         , P_ORG_ID         IN NUMBER
                         , P_MODULE_CODE    IN VARCHAR2
                         , P_MASTER_TYPE    IN VARCHAR2
                         , P_DATE           IN DATE     ) RETURN VARCHAR2
  AS
    X_RETURN_MASTER_NO   VARCHAR2(50) := NULL;
    V_PREFIX_CHAR        VARCHAR2(50) := NULL;
    V_PREFIX_SEPARATER   VARCHAR2(20) := NULL;
    V_DATE_TYPE          VARCHAR2(20) := NULL;
    V_SEQUENCE_SEPARATER VARCHAR2(20) := NULL;
    V_SEQUENCE_COUNT     NUMBER       := NULL;


    V_DATE_YEAR          VARCHAR2(4)  := NULL;
    V_DATE_MONTH         VARCHAR2(2)  := NULL;
    V_DATE_DAY           VARCHAR2(2)  := NULL;

    V_CURR_MAX_NO        VARCHAR2(50) := NULL;
    V_CURR_MAX_SEQ       NUMBER       := NULL;
    V_NEW_MAX_SEQ        NUMBER       := NULL;

    V_MAX_SEQ_CHAR       VARCHAR2(50) := NULL;
    V_CURR_ROW_ID        NUMBER;


  BEGIN
      -- MASTER NO MAKING RULE SEARCH
      BEGIN
          SELECT EMNR.PREFIX_CHAR
               , EMNR.PREFIX_SEPARATER
               , EMNR.DATE_TYPE
               , EMNR.SEQUENCE_SEPARATER
               , EMNR.SEQUENCE_COUNT
            INTO V_PREFIX_CHAR
               , V_PREFIX_SEPARATER
               , V_DATE_TYPE
               , V_SEQUENCE_SEPARATER
               , V_SEQUENCE_COUNT
            FROM EAPP_MASTER_NO_RULE EMNR
           WHERE EMNR.SOB_ID         = P_SOB_ID
             AND EMNR.ORG_ID         = P_ORG_ID
             AND EMNR.MODULE_LCODE   = P_MODULE_CODE
             AND EMNR.MASTER_TYPE    = P_MASTER_TYPE
             AND ROWNUM              = 1
             ;
      EXCEPTION WHEN OTHERS THEN
          V_PREFIX_CHAR        := NULL;
          V_PREFIX_SEPARATER   := NULL;
          V_DATE_TYPE          := NULL;
          V_SEQUENCE_SEPARATER := NULL;
          V_SEQUENCE_COUNT     := NULL;
      END;

      IF NVL(V_SEQUENCE_COUNT,0) <> 0 THEN
        SELECT SUBSTR(TO_CHAR(P_DATE,V_DATE_TYPE),1,4)
             , SUBSTR(TO_CHAR(P_DATE,V_DATE_TYPE),5,2)
             , SUBSTR(TO_CHAR(P_DATE,V_DATE_TYPE),7,2)
          INTO V_DATE_YEAR
             , V_DATE_MONTH
             , V_DATE_DAY
          FROM DUAL;

        BEGIN
            SELECT EMNM.MAX_MASTER_NO
                 , EMNM.MAX_MASTER_SEQ
                 , ROW_ID
              INTO V_CURR_MAX_NO
                 , V_CURR_MAX_SEQ
                 , V_CURR_ROW_ID
              FROM EAPP_MASTER_NO_MAX EMNM
             WHERE EMNM.SOB_ID        = P_SOB_ID
               AND EMNM.ORG_ID        = P_ORG_ID
               AND EMNM.MODULE_CODE   = P_MODULE_CODE
               AND EMNM.MASTER_TYPE   = P_MASTER_TYPE
               AND EMNM.DATE_TYPE     = V_DATE_TYPE
               AND DECODE(V_DATE_YEAR,NULL,-1,EMNM.YEAR_CHAR)   = DECODE(V_DATE_YEAR,NULL,-1,V_DATE_YEAR)
               AND DECODE(V_DATE_MONTH,NULL,-1,EMNM.MONTH_CHAR) = DECODE(V_DATE_MONTH,NULL,-1,V_DATE_MONTH)
               AND DECODE(V_DATE_DAY,NULL,-1,EMNM.DAY_CHAR)     = DECODE(V_DATE_DAY,NULL,-1,V_DATE_DAY)
               --FOR UPDATE
               ;
        EXCEPTION WHEN OTHERS THEN
            V_CURR_MAX_NO  := NULL;
            V_CURR_MAX_SEQ := 0;
        END;

        V_NEW_MAX_SEQ := V_CURR_MAX_SEQ + 1;

        FOR i IN 1..V_SEQUENCE_COUNT - TO_NUMBER(LENGTH(TO_CHAR(V_NEW_MAX_SEQ)))
        LOOP
            V_MAX_SEQ_CHAR := V_MAX_SEQ_CHAR || 0;
        END LOOP;

        V_MAX_SEQ_CHAR := V_MAX_SEQ_CHAR || TO_CHAR(V_NEW_MAX_SEQ);

        X_RETURN_MASTER_NO := V_PREFIX_CHAR || V_PREFIX_SEPARATER || TO_CHAR(P_DATE,V_DATE_TYPE) || V_SEQUENCE_SEPARATER || V_MAX_SEQ_CHAR;


        IF V_CURR_MAX_NO IS NULL THEN
             INSERT INTO EAPP_MASTER_NO_MAX
                         ( ROW_ID
                         , SOB_ID
                         , ORG_ID
                         , MODULE_CODE
                         , MASTER_TYPE
                         , DATE_TYPE
                         , YEAR_CHAR
                         , MONTH_CHAR
                         , DAY_CHAR
                         , MAX_MASTER_NO
                         , MAX_MASTER_SEQ
                         )
                   VALUES
                         ( EAPP_MASTER_NO_MAX_S1.NEXTVAL
                         , P_SOB_ID
                         , P_ORG_ID
                         , P_MODULE_CODE
                         , P_MASTER_TYPE
                         , V_DATE_TYPE
                         , V_DATE_YEAR
                         , V_DATE_MONTH
                         , V_DATE_DAY
                         , X_RETURN_MASTER_NO
                         , V_NEW_MAX_SEQ
                         );

        ELSE
            UPDATE EAPP_MASTER_NO_MAX  EMNM
               SET EMNM.MAX_MASTER_NO    = X_RETURN_MASTER_NO
                 , EMNM.MAX_MASTER_SEQ   = V_NEW_MAX_SEQ
             WHERE EMNM.ROW_ID         = V_CURR_ROW_ID
             ;
        END IF;

      ELSE
        X_RETURN_MASTER_NO := 'ERROR';
      END IF;

      RETURN X_RETURN_MASTER_NO;

  END GET_MASTER_NO;


  ----------------------------------------
  -- MM_QTY Convert from PCS_QTY        --
  ----------------------------------------
   FUNCTION GET_MM_FROM_PCS_F ( P_INVENTORY_ITEM_ID         IN NUMBER
                              , P_BOM_ITEM_ID               IN NUMBER
                              , P_PCS_QTY                   IN NUMBER) RETURN NUMBER
   AS
        V_BOM_ITEM_ID       NUMBER;
        V_PCS_PER_PNL_QTY   NUMBER;
        V_PNL_SIZE_X        NUMBER;
        V_PNL_SIZE_Y        NUMBER;
        X_MM_QTY           NUMBER;
   BEGIN

        IF NVL(P_BOM_ITEM_ID,0) = 0 THEN
           
            ---------------------
            -- GET BOM_ITEM_ID --
            ---------------------
            BEGIN
                SELECT SIR.BOM_ITEM_ID
                  INTO V_BOM_ITEM_ID
                  FROM SDM_ITEM_REVISION    SIR
                 WHERE SIR.INVENTORY_ITEM_ID  = P_INVENTORY_ITEM_ID
                   AND SIR.BOM_VERSION = ( SELECT MAX(SSIR.BOM_VERSION) BOM_VER
                                                        FROM SDM_ITEM_REVISION  SSIR
                                                           , SDM_ITEM_SPEC      SSIS
                                                       WHERE SSIS.BOM_ITEM_ID       = SSIR.BOM_ITEM_ID
                                                         AND SSIR.INVENTORY_ITEM_ID = P_INVENTORY_ITEM_ID
                                                         AND SSIR.BOM_STATUS_LCODE  = 'RELEASE'
                                                         AND SSIR.ENABLED_FLAG      = 'Y'
                                                         AND TRUNC(GET_LOCAL_DATE(SSIR.SOB_ID)) BETWEEN SSIR.EFFECTIVE_DATE_FR
                                                                                             AND NVL(SSIR.EFFECTIVE_DATE_TO,TRUNC(GET_LOCAL_DATE(SSIR.SOB_ID))));
            EXCEPTION WHEN OTHERS THEN
                V_BOM_ITEM_ID := NULL;  
            END;
        ELSE
            V_BOM_ITEM_ID := P_BOM_ITEM_ID;
        END IF;

        ---------------------
        -- GET PCS_PER_PNL --
        -- GET PNL_SIZE_X  --
        -- GET PNL_SIZE_Y  --
        ---------------------
        BEGIN
            SELECT SIS.PCS_PER_PNL_QTY
                 , SIS.PNL_SIZE_X
                 , SIS.PNL_SIZE_Y
              INTO V_PCS_PER_PNL_QTY
                 , V_PNL_SIZE_X
                 , V_PNL_SIZE_Y
              FROM SDM_ITEM_SPEC   SIS
             WHERE SIS.BOM_ITEM_ID = V_BOM_ITEM_ID;
        EXCEPTION WHEN OTHERS THEN
             V_PCS_PER_PNL_QTY := 0;
             V_PNL_SIZE_X      := 0;
             V_PNL_SIZE_Y      := 0;
        END;

         IF NVL(V_PCS_PER_PNL_QTY,0) <> 0 THEN
              X_MM_QTY := ROUND((((V_PNL_SIZE_X * V_PNL_SIZE_Y) / 1000000) / V_PCS_PER_PNL_QTY) * P_PCS_QTY,7);
         ELSE
              X_MM_QTY := -1;
         END IF;

         RETURN X_MM_QTY;



   END GET_MM_FROM_PCS_F;

  ----------------------------------------
  -- MM_QTY Convert from PCS_QTY        --
  ----------------------------------------
   PROCEDURE GET_MM_FROM_PCS_P ( P_INVENTORY_ITEM_ID         IN NUMBER
                              , P_BOM_ITEM_ID               IN NUMBER
                              , P_PCS_QTY                   IN NUMBER
                              , X_MM_QTY                    OUT NUMBER)
   AS
        V_BOM_ITEM_ID       NUMBER;
        V_PCS_PER_PNL_QTY   NUMBER;
        V_PNL_SIZE_X        NUMBER;
        V_PNL_SIZE_Y        NUMBER;

   BEGIN

        IF NVL(P_BOM_ITEM_ID,0) = 0 THEN
            ---------------------
            -- GET BOM_ITEM_ID --
            ---------------------
            BEGIN
                SELECT SIR.BOM_ITEM_ID
                  INTO V_BOM_ITEM_ID
                  FROM SDM_ITEM_REVISION    SIR
                 WHERE SIR.INVENTORY_ITEM_ID  = P_INVENTORY_ITEM_ID
                   AND SIR.BOM_VERSION = ( SELECT MAX(SSIR.BOM_VERSION) BOM_VER
                                                        FROM SDM_ITEM_REVISION  SSIR
                                                           , SDM_ITEM_SPEC      SSIS
                                                       WHERE SSIS.BOM_ITEM_ID       = SSIR.BOM_ITEM_ID
                                                         AND SSIR.INVENTORY_ITEM_ID = P_INVENTORY_ITEM_ID
                                                         AND SSIR.BOM_STATUS_LCODE  = 'RELEASE'
                                                         AND SSIR.ENABLED_FLAG      = 'Y'
                                                         AND TRUNC(GET_LOCAL_DATE(SSIR.SOB_ID)) BETWEEN SSIR.EFFECTIVE_DATE_FR
                                                                                             AND NVL(SSIR.EFFECTIVE_DATE_TO,TRUNC(GET_LOCAL_DATE(SSIR.SOB_ID))));
           EXCEPTION WHEN OTHERS THEN
               V_BOM_ITEM_ID := NULL;
           END;
        ELSE
            V_BOM_ITEM_ID := P_BOM_ITEM_ID;
        END IF;

        ---------------------
        -- GET PCS_PER_PNL --
        -- GET PNL_SIZE_X  --
        -- GET PNL_SIZE_Y  --
        ---------------------
        BEGIN
            SELECT SIS.PCS_PER_PNL_QTY
                 , SIS.PNL_SIZE_X
                 , SIS.PNL_SIZE_Y
              INTO V_PCS_PER_PNL_QTY
                 , V_PNL_SIZE_X
                 , V_PNL_SIZE_Y
              FROM SDM_ITEM_SPEC   SIS
             WHERE SIS.BOM_ITEM_ID = V_BOM_ITEM_ID;
        EXCEPTION WHEN OTHERS THEN
             V_PCS_PER_PNL_QTY := 0;
             V_PNL_SIZE_X      := 0;
             V_PNL_SIZE_Y      := 0;
        END;

         IF NVL(V_PCS_PER_PNL_QTY,0) <> 0 THEN
              X_MM_QTY := ROUND((((V_PNL_SIZE_X * V_PNL_SIZE_Y) / 1000000) / V_PCS_PER_PNL_QTY) * P_PCS_QTY,7);
         ELSE
              X_MM_QTY := -1;
         END IF;


   END GET_MM_FROM_PCS_P;


  ----------------------------------------
  -- MM_QTY Convert from UOM_QTY        --
  ----------------------------------------
   FUNCTION GET_MM_FROM_UOM_F ( P_INVENTORY_ITEM_ID         IN NUMBER
                              , P_BOM_ITEM_ID               IN NUMBER
                              , P_UOM_QTY                   IN NUMBER) RETURN NUMBER
   AS
        V_BOM_ITEM_ID       NUMBER;
        ---------------------------
        V_PCS_PER_PNL_QTY   NUMBER;
        V_PNL_SIZE_X        NUMBER;
        V_PNL_SIZE_Y        NUMBER;
        V_UOM_CODE          VARCHAR2(50); 
        --------------------------------
        X_MM_QTY              NUMBER;
        --V_MM_UOM_FACTOR       NUMBER;
        --------------------------------
        V_INVENTORY_ITEM_ID   NUMBER;
        V_ITEM_CATEGORY_CODE  VARCHAR2(100);
   BEGIN
        ---------------------
        -- GET BOM_ITEM_ID --
        ---------------------      
        IF P_BOM_ITEM_ID IS NULL THEN
            BEGIN
                SELECT SIR.BOM_ITEM_ID
                  INTO V_BOM_ITEM_ID
                  FROM SDM_ITEM_REVISION    SIR
                 WHERE SIR.INVENTORY_ITEM_ID  = P_INVENTORY_ITEM_ID
                   AND SIR.BOM_VERSION = ( SELECT MAX(SSIR.BOM_VERSION) BOM_VER
                                                        FROM SDM_ITEM_REVISION  SSIR
                                                           , SDM_ITEM_SPEC      SSIS
                                                       WHERE SSIS.BOM_ITEM_ID       = SSIR.BOM_ITEM_ID
                                                         AND SSIR.INVENTORY_ITEM_ID = P_INVENTORY_ITEM_ID
                                                         AND SSIR.BOM_STATUS_LCODE  = 'RELEASE'
                                                         /*AND SSIR.ENABLED_FLAG      = 'Y'
                                                         AND TRUNC(GET_LOCAL_DATE(SSIR.SOB_ID)) BETWEEN SSIR.EFFECTIVE_DATE_FR
                                                                                             AND NVL(SSIR.EFFECTIVE_DATE_TO,TRUNC(GET_LOCAL_DATE(SSIR.SOB_ID)))*/)
                   AND ROWNUM = 1
                   ;
            EXCEPTION WHEN OTHERS THEN
                 V_BOM_ITEM_ID := NULL;
            END;
        ELSE
            V_BOM_ITEM_ID := P_BOM_ITEM_ID;
        END IF;
        
        ------------------------------
        -- INVENTORY ITEM ID SELECT --
        ------------------------------
        IF P_INVENTORY_ITEM_ID IS NULL THEN
             BEGIN
                 SELECT SIR.INVENTORY_ITEM_ID
                   INTO V_INVENTORY_ITEM_ID
                   FROM SDM_ITEM_REVISION  SIR
                  WHERE SIR.BOM_ITEM_ID    = V_BOM_ITEM_ID
                    AND ROWNUM             = 1
                    ;
             EXCEPTION WHEN OTHERS THEN
                 V_INVENTORY_ITEM_ID  := NULL;
             END;
         ELSE
              V_INVENTORY_ITEM_ID := P_INVENTORY_ITEM_ID;
         END IF;

         ---------------------
         -- GET UOM CODE    --
         ---------------------
         BEGIN
             SELECT IIM.PRIMARY_UOM_CODE
               INTO V_UOM_CODE
               FROM INV_ITEM_MASTER   IIM
              WHERE IIM.INVENTORY_ITEM_ID = V_INVENTORY_ITEM_ID;
         EXCEPTION WHEN OTHERS THEN
              V_UOM_CODE := NULL; 
         END;
         
         -------------------------------         
         -- ITEM CATEGORY CODE SELECT --
         -------------------------------
         BEGIN
              SELECT IIM.ITEM_CATEGORY_CODE
                INTO V_ITEM_CATEGORY_CODE
                FROM INV_ITEM_MASTER  IIM
               WHERE IIM.INVENTORY_ITEM_ID = V_INVENTORY_ITEM_ID
               ;
         EXCEPTION WHEN OTHERS THEN
              V_ITEM_CATEGORY_CODE := NULL;
         END;
         
        ------------------------------------------------------ 
        -- 품목이 반제품이면  TOP_BOM_ITEM_ID 기준으로 산정 --
        ------------------------------------------------------
        IF V_ITEM_CATEGORY_CODE != 'FG' THEN
             BEGIN
                  SELECT SIS.BOM_ITEM_ID
                    INTO V_BOM_ITEM_ID
                    FROM SDM_ITEM_STRUCTURE  SIS
                   WHERE SIS.SG_BOM_ITEM_ID  = V_BOM_ITEM_ID
                     AND ROWNUM              = 1
                     ;
             EXCEPTION WHEN OTHERS THEN
                 V_BOM_ITEM_ID := NULL;
             END;
        END IF;
        
        ------------------------------------------------------
        -- GET PCS_PER_PNL, GET PNL_SIZE_X, GET PNL_SIZE_Y  --
        ------------------------------------------------------
        BEGIN
              SELECT SIS.PCS_PER_PNL_QTY
                   , SIS.PNL_SIZE_X
                   , SIS.PNL_SIZE_Y
                INTO V_PCS_PER_PNL_QTY
                   , V_PNL_SIZE_X
                   , V_PNL_SIZE_Y
                FROM SDM_ITEM_SPEC   SIS
               WHERE SIS.BOM_ITEM_ID = V_BOM_ITEM_ID
               ;
        EXCEPTION WHEN OTHERS THEN
            V_BOM_ITEM_ID := NULL;
        END;
        
         ----------------------------
         -- MM QTY 산정            --
         ----------------------------
         IF V_UOM_CODE IN ('PNL', 'ARRAY') THEN
                  X_MM_QTY := ROUND(((V_PNL_SIZE_X * V_PNL_SIZE_Y) / 1000000) * P_UOM_QTY,7);
         ELSIF V_UOM_CODE = 'PCS' THEN
             IF NVL(V_PCS_PER_PNL_QTY,0) <> 0 THEN
                  X_MM_QTY := ROUND((((V_PNL_SIZE_X * V_PNL_SIZE_Y) / 1000000) / V_PCS_PER_PNL_QTY) * P_UOM_QTY,7);
             ELSE
                  X_MM_QTY := 0;
             END IF;
         ELSIF V_UOM_CODE IS NULL THEN
               X_MM_QTY := 0;
         ELSE
               X_MM_QTY := ROUND(((V_PNL_SIZE_X * V_PNL_SIZE_Y) / 1000000) * P_UOM_QTY,7);
         END IF;  

         RETURN X_MM_QTY;


/*         ---------------------------
         -- MM_UOM_FACTOR SETTING --
         ---------------------------
         BEGIN
              SELECT IBE.MM_UOM_FACTOR
                INTO V_MM_UOM_FACTOR
                FROM SDM_INDENTED_BOM_EX IBE
               WHERE NVL(IBE.COMPONENT_BOM_ITEM_ID, IBE.ASSEMBLY_BOM_ITEM_ID) = V_BOM_ITEM_ID
                 AND ROWNUM   = 1
                 ;
         EXCEPTION WHEN OTHERS THEN
               V_MM_UOM_FACTOR := 0;
         END;

         X_MM_QTY := ROUND(P_UOM_QTY * NVL(V_MM_UOM_FACTOR,0),7);*/


   END GET_MM_FROM_UOM_F;


  ----------------------------------------
  -- PNL_QTY Convert from UOM_QTY        --
  ----------------------------------------
   FUNCTION GET_PNL_FROM_UOM_F ( P_INVENTORY_ITEM_ID         IN NUMBER
                               , P_BOM_ITEM_ID               IN NUMBER
                               , P_UOM_QTY                   IN NUMBER) RETURN NUMBER
   AS
        V_BOM_ITEM_ID        NUMBER;
        X_PNL_QTY            NUMBER;
        V_PNL_UOM_FACTOR     NUMBER;
   BEGIN

        IF NVL(P_BOM_ITEM_ID,0) = 0 THEN
            ---------------------
            -- GET BOM_ITEM_ID --
            ---------------------
            BEGIN
                SELECT SIR.BOM_ITEM_ID
                  INTO V_BOM_ITEM_ID
                  FROM SDM_ITEM_REVISION    SIR
                 WHERE SIR.INVENTORY_ITEM_ID  = P_INVENTORY_ITEM_ID
                   AND SIR.BOM_VERSION = ( SELECT MAX(SSIR.BOM_VERSION) BOM_VER
                                                        FROM SDM_ITEM_REVISION  SSIR
                                                           , SDM_ITEM_SPEC      SSIS
                                                       WHERE SSIS.BOM_ITEM_ID       = SSIR.BOM_ITEM_ID
                                                         AND SSIR.INVENTORY_ITEM_ID = P_INVENTORY_ITEM_ID
                                                         AND SSIR.BOM_STATUS_LCODE  = 'RELEASE'
                                                         AND SSIR.ENABLED_FLAG      = 'Y'
                                                         AND TRUNC(GET_LOCAL_DATE(SSIR.SOB_ID)) BETWEEN SSIR.EFFECTIVE_DATE_FR
                                                                                             AND NVL(SSIR.EFFECTIVE_DATE_TO,TRUNC(GET_LOCAL_DATE(SSIR.SOB_ID))))
                   AND ROWNUM = 1
                   ;
             EXCEPTION WHEN OTHERS THEN
                 V_BOM_ITEM_ID := NULL;
             END;
        ELSE
            V_BOM_ITEM_ID := P_BOM_ITEM_ID;
        END IF;

         ---------------------------
         -- MM_UOM_FACTOR SETTING --
         ---------------------------
         BEGIN
              SELECT IBE.PNL_UOM_FACTOR
                INTO V_PNL_UOM_FACTOR
                FROM SDM_INDENTED_BOM_EX IBE
               WHERE NVL(IBE.COMPONENT_BOM_ITEM_ID, IBE.ASSEMBLY_BOM_ITEM_ID) = V_BOM_ITEM_ID
                     /*(  (IBE.COMPONENT_BOM_ITEM_ID IS NOT NULL AND IBE.COMPONENT_BOM_ITEM_ID = V_BOM_ITEM_ID)
                     OR (IBE.COMPONENT_BOM_ITEM_ID IS NULL AND IBE.ASSEMBLY_BOM_ITEM_ID = V_BOM_ITEM_ID))*/
                 AND ROWNUM   = 1
                 ;
         EXCEPTION WHEN OTHERS THEN
               V_PNL_UOM_FACTOR := 0;
         END;

         X_PNL_QTY := ROUND(P_UOM_QTY * NVL(V_PNL_UOM_FACTOR,0),0);


         RETURN X_PNL_QTY;

   END GET_PNL_FROM_UOM_F;

  ----------------------------------------
  -- PCS_QTY Convert from UOM_QTY        --
  ----------------------------------------
   FUNCTION GET_PCS_FROM_UOM_F ( P_INVENTORY_ITEM_ID         IN NUMBER
                               , P_BOM_ITEM_ID               IN NUMBER
                               , P_UOM_QTY                   IN NUMBER) RETURN NUMBER
   AS
        V_BOM_ITEM_ID        NUMBER;
        X_PCS_QTY            NUMBER;
        V_PCS_UOM_FACTOR     NUMBER;
   BEGIN

        IF NVL(P_BOM_ITEM_ID,0) = 0 THEN
            ---------------------
            -- GET BOM_ITEM_ID --
            ---------------------
            BEGIN
                SELECT SIR.BOM_ITEM_ID
                  INTO V_BOM_ITEM_ID
                  FROM SDM_ITEM_REVISION    SIR
                 WHERE SIR.INVENTORY_ITEM_ID  = P_INVENTORY_ITEM_ID
                   AND SIR.BOM_VERSION = ( SELECT MAX(SSIR.BOM_VERSION) BOM_VER
                                                        FROM SDM_ITEM_REVISION  SSIR
                                                           , SDM_ITEM_SPEC      SSIS
                                                       WHERE SSIS.BOM_ITEM_ID       = SSIR.BOM_ITEM_ID
                                                         AND SSIR.INVENTORY_ITEM_ID = P_INVENTORY_ITEM_ID
                                                         AND SSIR.BOM_STATUS_LCODE  = 'RELEASE'
                                                         AND SSIR.ENABLED_FLAG      = 'Y'
                                                         AND TRUNC(GET_LOCAL_DATE(SSIR.SOB_ID)) BETWEEN SSIR.EFFECTIVE_DATE_FR
                                                                                             AND NVL(SSIR.EFFECTIVE_DATE_TO,TRUNC(GET_LOCAL_DATE(SSIR.SOB_ID))))
                   AND ROWNUM = 1
                   ;
            EXCEPTION WHEN OTHERS THEN
                V_BOM_ITEM_ID := NULL;
            END;
        ELSE
            V_BOM_ITEM_ID := P_BOM_ITEM_ID;
        END IF;

         ---------------------------
         -- MM_UOM_FACTOR SETTING --
         ---------------------------
         BEGIN
              SELECT IBE.PCS_UOM_FACTOR
                INTO V_PCS_UOM_FACTOR
                FROM SDM_INDENTED_BOM_EX IBE
               WHERE NVL(IBE.COMPONENT_BOM_ITEM_ID, IBE.ASSEMBLY_BOM_ITEM_ID) = V_BOM_ITEM_ID
                 AND ROWNUM   = 1
                 ;
         EXCEPTION WHEN OTHERS THEN
               V_PCS_UOM_FACTOR := 0;
         END;

         X_PCS_QTY := ROUND(P_UOM_QTY * NVL(V_PCS_UOM_FACTOR,0),0);


         RETURN X_PCS_QTY;

   END GET_PCS_FROM_UOM_F;

  ----------------------------------------
  -- PERSON ID from User_ID             --
  ----------------------------------------
   FUNCTION GET_PERSON_ID_BY_USER ( P_USER_ID   IN NUMBER ) RETURN NUMBER
   AS
        X_PERSON_ID     NUMBER := NULL;
   BEGIN

         BEGIN
               SELECT EU.PERSON_ID
                 INTO X_PERSON_ID
                 FROM EAPP_USER          EU
                WHERE EU.USER_ID         = P_USER_ID
                  ;
         EXCEPTION WHEN OTHERS THEN
                X_PERSON_ID := NULL;
         END;


         RETURN X_PERSON_ID;

   END GET_PERSON_ID_BY_USER;

  ----------------------------------------
  -- PERSON Info from User_ID           --
  ----------------------------------------
   PROCEDURE GET_PERSON_BY_USER ( P_USER_ID      IN  NUMBER
                                , X_PERSON_ID    OUT NUMBER
                                , X_PERSON_NAME  OUT VARCHAR2
                                , X_PERSON_NO    OUT VARCHAR2
                                , X_DISPLAY_NAME OUT VARCHAR2
                                , X_DEPT_ID      OUT NUMBER
                                , X_DEPT_CODE    OUT VARCHAR2
                                , X_DEPT_NAME    OUT VARCHAR2)
   AS

   BEGIN

         BEGIN
               SELECT EU.PERSON_ID
                    , HPM.NAME
                    , HPM.PERSON_NUM
                    , HPM.DISPLAY_NAME
                    , HPM.DEPT_ID
                    , HDM.DEPT_CODE
                    , HDM.DEPT_NAME
                 INTO X_PERSON_ID
                    , X_PERSON_NAME
                    , X_PERSON_NO
                    , X_DISPLAY_NAME
                    , X_DEPT_ID
                    , X_DEPT_CODE
                    , X_DEPT_NAME
                 FROM EAPP_USER          EU  LEFT OUTER JOIN
                      HRM_PERSON_MASTER  HPM ON HPM.PERSON_ID = EU.PERSON_ID LEFT OUTER JOIN
                      HRM_DEPT_MASTER    HDM ON HDM.DEPT_ID   = HPM.DEPT_ID
                WHERE EU.USER_ID         = P_USER_ID
                  ;
         EXCEPTION WHEN OTHERS THEN
                X_PERSON_ID     := NULL;
                X_PERSON_NAME   := NULL;
                X_PERSON_NO     := NULL;
                X_DISPLAY_NAME  := NULL;
                X_DEPT_ID       := NULL;
                X_DEPT_CODE     := NULL;
                X_DEPT_NAME     := NULL;
         END;



   END GET_PERSON_BY_USER;

  ----------------------------------------
  -- PERSON NAME from User_ID             --
  ----------------------------------------
   FUNCTION GET_PERSON_NAME_BY_USER ( P_USER_ID   IN NUMBER ) RETURN VARCHAR2
   AS
        X_PERSON_NAME     VARCHAR2(200) := NULL;
   BEGIN

         BEGIN
               SELECT NVL(HPM.DISPLAY_NAME, EU.DESCRIPTION) AS DISPLAY_NAME
                 INTO X_PERSON_NAME
                 FROM EAPP_USER          EU
                    , HRM_PERSON_MASTER  HPM
                WHERE HPM.PERSON_ID      = EU.PERSON_ID
                  AND EU.USER_ID         = P_USER_ID
                  AND ROWNUM             = 1
                  ;
         EXCEPTION WHEN OTHERS THEN
                X_PERSON_NAME := NULL;
         END;

         RETURN X_PERSON_NAME;

   END GET_PERSON_NAME_BY_USER;

  ----------------------------------------
  -- PERSON NAME from User_ID             --
  ----------------------------------------
   FUNCTION GET_PERSON_SNAME_BY_USER ( P_USER_ID   IN NUMBER ) RETURN VARCHAR2
   AS
        X_PERSON_NAME     VARCHAR2(200) := NULL;
   BEGIN

         BEGIN
               SELECT NVL(HPM.NAME, EU.DESCRIPTION) AS PERSON_NAME
                 INTO X_PERSON_NAME
                 FROM EAPP_USER          EU
                    , HRM_PERSON_MASTER  HPM
                WHERE HPM.PERSON_ID      = EU.PERSON_ID
                  AND EU.USER_ID         = P_USER_ID
                  AND ROWNUM             = 1
                  ;
         EXCEPTION WHEN OTHERS THEN
                X_PERSON_NAME := NULL;
         END;

         RETURN X_PERSON_NAME;

   END GET_PERSON_SNAME_BY_USER;
   
  ----------------------------------------
  -- PERSON NAME                        --
  ----------------------------------------
   FUNCTION GET_PERSON_NAME ( P_PERSON_ID   IN NUMBER ) RETURN VARCHAR2
   AS
        X_PERSON_NAME     VARCHAR2(200) := NULL;
   BEGIN

         BEGIN
               SELECT HPM.DISPLAY_NAME
                 INTO X_PERSON_NAME
                 FROM HRM_PERSON_MASTER  HPM
                WHERE HPM.PERSON_ID      = P_PERSON_ID
                  ;
         EXCEPTION WHEN OTHERS THEN
                X_PERSON_NAME := NULL;
         END;


         RETURN X_PERSON_NAME;

   END GET_PERSON_NAME;

  ----------------------------------------
  -- PCS_PER_PNL_QTY (합수)             --
  ----------------------------------------
   FUNCTION GET_PCS_PER_PNL_QTY_F ( P_BOM_ITEM_ID               IN NUMBER) RETURN NUMBER
   AS
        X_PCS_PER_PNL_QTY            NUMBER;
   BEGIN

        ---------------------
        -- GET PCS_PER_PNL --
        ---------------------
        BEGIN
            SELECT SIS.PCS_PER_PNL_QTY
              INTO X_PCS_PER_PNL_QTY
              FROM SDM_ITEM_SPEC   SIS
             WHERE SIS.BOM_ITEM_ID = P_BOM_ITEM_ID
             ;
        EXCEPTION WHEN OTHERS THEN
            X_PCS_PER_PNL_QTY := 0;
        END;

        IF NVL(X_PCS_PER_PNL_QTY,0) = 0 THEN
            BEGIN
                SELECT SIS.UOM_PER_PNL_QTY
                  INTO X_PCS_PER_PNL_QTY
                  FROM SDM_ITEM_STRUCTURE  SIS
                 WHERE SIS.SG_BOM_ITEM_ID  = P_BOM_ITEM_ID
                 ;
            EXCEPTION WHEN OTHERS THEN
                X_PCS_PER_PNL_QTY := 0;
            END;
        END IF;

        RETURN X_PCS_PER_PNL_QTY;



   END GET_PCS_PER_PNL_QTY_F;

  ----------------------------------------
  -- PCS_PER_MM_QTY (산출수)            --
  ----------------------------------------
   FUNCTION GET_PCS_PER_MM_QTY_F ( P_BOM_ITEM_ID               IN NUMBER) RETURN NUMBER
   AS
        X_PCS_PER_MM_QTY            NUMBER;
   BEGIN

        ---------------------
        -- GET PCS_PER_PNL --
        ---------------------
        BEGIN
            SELECT SIS.PCS_PER_MM_QTY
              INTO X_PCS_PER_MM_QTY
              FROM SDM_ITEM_SPEC   SIS
             WHERE SIS.BOM_ITEM_ID = P_BOM_ITEM_ID
             ;
        EXCEPTION WHEN OTHERS THEN
            X_PCS_PER_MM_QTY := 0;
        END;

        RETURN X_PCS_PER_MM_QTY;

   END GET_PCS_PER_MM_QTY_F;

  -------------------------------------------------
  -- PCS_QTY Convert from WORKING_UOM_QTY        --
  -------------------------------------------------
   FUNCTION GET_PCS_FROM_WORKING_UOM_F ( P_BOM_ITEM_ID               IN NUMBER
                                       , P_WORKING_UOM_CODE          IN VARCHAR2
                                       , P_WORKING_UOM_QTY           IN NUMBER) RETURN NUMBER
   AS
        V_PCS_PER_PNL_QTY   NUMBER;
        V_PCS_PER_ARRAY_QTY NUMBER;
        X_PCS_QTY           NUMBER;
   BEGIN

        ---------------------
        -- GET PCS_PER_PNL --
        -- GET PNL_SIZE_X  --
        -- GET PNL_SIZE_Y  --
        ---------------------
        BEGIN
              SELECT SIS.PCS_PER_PNL_QTY
                   , SIS.PCS_PER_ARRAY_QTY
                INTO V_PCS_PER_PNL_QTY
                   , V_PCS_PER_ARRAY_QTY
                FROM SDM_ITEM_SPEC   SIS
               WHERE SIS.BOM_ITEM_ID = P_BOM_ITEM_ID;
         EXCEPTION WHEN OTHERS THEN
              V_PCS_PER_PNL_QTY := 0;
              V_PCS_PER_ARRAY_QTY := 0;
         END;

         ---------------------
         -- QTY CONVERT     --
         ---------------------
         IF    P_WORKING_UOM_CODE = 'PNL' THEN
                 X_PCS_QTY := P_WORKING_UOM_QTY * V_PCS_PER_PNL_QTY;
         ELSIF P_WORKING_UOM_CODE = 'ARRAY' THEN
                 X_PCS_QTY := P_WORKING_UOM_QTY * V_PCS_PER_ARRAY_QTY;
         ELSIF P_WORKING_UOM_CODE = 'PCS' THEN
               X_PCS_QTY := P_WORKING_UOM_QTY;
         ELSE
               X_PCS_QTY := 0;
         END IF;

         RETURN X_PCS_QTY;

   END GET_PCS_FROM_WORKING_UOM_F;


  ----------------------------------------
  -- PNL_QTY Convert from PCS_QTY       --
  ----------------------------------------
   FUNCTION GET_PNL_FROM_PCS_F ( P_INVENTORY_ITEM_ID         IN NUMBER
                             , P_BOM_ITEM_ID               IN NUMBER
                             , P_PCS_QTY                   IN NUMBER) RETURN NUMBER
   AS
        V_BOM_ITEM_ID       NUMBER;
        V_PCS_PER_PNL_QTY   NUMBER;
        X_PNL_QTY            NUMBER;

   BEGIN

        IF NVL(P_BOM_ITEM_ID,0) = 0 THEN
            BEGIN
            ---------------------
            -- GET BOM_ITEM_ID --
            ---------------------
            SELECT SIR.BOM_ITEM_ID
              INTO V_BOM_ITEM_ID
              FROM SDM_ITEM_REVISION    SIR
             WHERE SIR.INVENTORY_ITEM_ID  = P_INVENTORY_ITEM_ID
               AND SIR.BOM_VERSION = ( SELECT MAX(SSIR.BOM_VERSION) BOM_VER
                                                    FROM SDM_ITEM_REVISION  SSIR
                                                       , SDM_ITEM_SPEC      SSIS
                                                   WHERE SSIS.BOM_ITEM_ID       = SSIR.BOM_ITEM_ID
                                                     AND SSIR.INVENTORY_ITEM_ID = P_INVENTORY_ITEM_ID
                                                     AND SSIR.BOM_STATUS_LCODE  = 'RELEASE'
                                                     AND SSIR.ENABLED_FLAG      = 'Y'
                                                     AND TRUNC(GET_LOCAL_DATE(SSIR.SOB_ID)) BETWEEN SSIR.EFFECTIVE_DATE_FR
                                                                                         AND NVL(SSIR.EFFECTIVE_DATE_TO,TRUNC(GET_LOCAL_DATE(SSIR.SOB_ID))) );
            EXCEPTION WHEN OTHERS THEN
                V_BOM_ITEM_ID := NULL;
            END;
        ELSE
            V_BOM_ITEM_ID := P_BOM_ITEM_ID;
        END IF;

        ---------------------
        -- GET PCS_PER_PNL --
        ---------------------
        BEGIN
            SELECT SIS.PCS_PER_PNL_QTY
              INTO V_PCS_PER_PNL_QTY
              FROM SDM_ITEM_SPEC   SIS
             WHERE SIS.BOM_ITEM_ID = V_BOM_ITEM_ID;
        EXCEPTION WHEN OTHERS THEN
            V_PCS_PER_PNL_QTY := 0;
        END;
         IF NVL(V_PCS_PER_PNL_QTY,0) <> 0 THEN
              X_PNL_QTY := CEIL(P_PCS_QTY / V_PCS_PER_PNL_QTY);
         ELSE
              X_PNL_QTY := -1;
         END IF;

         RETURN X_PNL_QTY;



   END GET_PNL_FROM_PCS_F;


  ----------------------------------------
  -- PNL_QTY Convert from PCS_QTY       --
  ----------------------------------------
   PROCEDURE GET_PNL_FROM_PCS_P ( P_INVENTORY_ITEM_ID       IN  NUMBER
                             , P_BOM_ITEM_ID               IN  NUMBER
                             , P_PCS_QTY                   IN  NUMBER
                             , X_PNL_QTY                   OUT NUMBER)
   AS
        V_BOM_ITEM_ID       NUMBER;
        V_PCS_PER_PNL_QTY   NUMBER;

   BEGIN

        IF NVL(P_BOM_ITEM_ID,0) = 0 THEN
            ---------------------
            -- GET BOM_ITEM_ID --
            ---------------------
            BEGIN
            SELECT SIR.BOM_ITEM_ID
              INTO V_BOM_ITEM_ID
              FROM SDM_ITEM_REVISION    SIR
             WHERE SIR.INVENTORY_ITEM_ID  = P_INVENTORY_ITEM_ID
               AND SIR.BOM_VERSION = ( SELECT MAX(SSIR.BOM_VERSION) BOM_VER
                                                    FROM SDM_ITEM_REVISION  SSIR
                                                       , SDM_ITEM_SPEC      SSIS
                                                   WHERE SSIS.BOM_ITEM_ID       = SSIR.BOM_ITEM_ID
                                                     AND SSIR.INVENTORY_ITEM_ID = P_INVENTORY_ITEM_ID
                                                     AND SSIR.BOM_STATUS_LCODE  = 'RELEASE'
                                                     AND SSIR.ENABLED_FLAG      = 'Y'
                                                     AND TRUNC(GET_LOCAL_DATE(SSIR.SOB_ID)) BETWEEN SSIR.EFFECTIVE_DATE_FR
                                                                                         AND NVL(SSIR.EFFECTIVE_DATE_TO,TRUNC(GET_LOCAL_DATE(SSIR.SOB_ID))));
           EXCEPTION WHEN OTHERS THEN
                V_BOM_ITEM_ID := NULL;
           END;
        ELSE
            V_BOM_ITEM_ID := P_BOM_ITEM_ID;
        END IF;

        ---------------------
        -- GET PCS_PER_PNL --
        ---------------------
        BEGIN
            SELECT SIS.PCS_PER_PNL_QTY
              INTO V_PCS_PER_PNL_QTY
              FROM SDM_ITEM_SPEC   SIS
             WHERE SIS.BOM_ITEM_ID = V_BOM_ITEM_ID;
        EXCEPTION WHEN OTHERS THEN
            V_PCS_PER_PNL_QTY := 0;
        END;
        
         IF NVL(V_PCS_PER_PNL_QTY,0) <> 0 THEN
              X_PNL_QTY := P_PCS_QTY / V_PCS_PER_PNL_QTY;
         ELSE
              X_PNL_QTY := -1;
         END IF;

   END GET_PNL_FROM_PCS_P;


  -------------------------------------------------
  -- PNL_QTY Convert from WORKING_UOM_QTY        --
  -------------------------------------------------
   FUNCTION GET_PNL_FROM_WORKING_UOM_F ( P_BOM_ITEM_ID               IN NUMBER
                                       , P_WORKING_UOM_CODE          IN VARCHAR2
                                       , P_WORKING_UOM_QTY           IN NUMBER) RETURN NUMBER
   AS
        V_PCS_PER_PNL_QTY   NUMBER;
        V_ARRAY_PER_PNL_QTY NUMBER;
        X_PNL_QTY           NUMBER;
   BEGIN

        ---------------------
        -- GET PCS_PER_PNL --
        -- GET PNL_SIZE_X  --
        -- GET PNL_SIZE_Y  --
        ---------------------
        BEGIN
              SELECT SIS.PCS_PER_PNL_QTY
                   , SIS.ARRAY_PER_PNL_QTY
                INTO V_PCS_PER_PNL_QTY
                   , V_ARRAY_PER_PNL_QTY
                FROM SDM_ITEM_SPEC   SIS
               WHERE SIS.BOM_ITEM_ID = P_BOM_ITEM_ID;
         EXCEPTION WHEN OTHERS THEN
              V_PCS_PER_PNL_QTY := 0;
              V_ARRAY_PER_PNL_QTY := 0;
         END;

         ---------------------
         -- QTY CONVERT     --
         ---------------------
         IF    P_WORKING_UOM_CODE = 'PNL' THEN
                 X_PNL_QTY := P_WORKING_UOM_QTY;
         ELSIF P_WORKING_UOM_CODE = 'ARRAY' THEN
               IF V_ARRAY_PER_PNL_QTY != 0 THEN
                   X_PNL_QTY := P_WORKING_UOM_QTY / V_ARRAY_PER_PNL_QTY;
               ELSE
                   X_PNL_QTY := 0;
               END IF;
         ELSIF P_WORKING_UOM_CODE = 'PCS' THEN
               IF V_PCS_PER_PNL_QTY != 0 THEN
                   X_PNL_QTY := P_WORKING_UOM_QTY / V_PCS_PER_PNL_QTY;
               ELSE
                   X_PNL_QTY := 0;
               END IF;
         ELSE
               X_PNL_QTY := 0;
         END IF;

         RETURN X_PNL_QTY;

   END GET_PNL_FROM_WORKING_UOM_F;

  ----------------------------------------
  -- Reason Entry Description Return    --
  ----------------------------------------
   FUNCTION GET_REASON_DESC ( P_SOB_ID                    IN NUMBER
                            , P_ORG_ID                    IN NUMBER
                            , P_REASON_TYPE               IN VARCHAR2
                            , P_REASON_CODE               IN VARCHAR2
                            , P_REASON_ID                 IN NUMBER ) RETURN VARCHAR2
   AS
        X_REASON_DESC     VARCHAR2(200) := NULL;
   BEGIN
         IF P_REASON_CODE IS NOT NULL THEN
               BEGIN
                     SELECT ERE.REASON_DESCRIPTION
                       INTO X_REASON_DESC
                       FROM EAPP_REASON_ENTRY_TLV  ERE
                      WHERE ERE.SOB_ID             = P_SOB_ID
                        AND ERE.ORG_ID             = P_ORG_ID
                        AND ERE.REASON_TYPE        = P_REASON_TYPE
                        AND ERE.REASON_CODE        = P_REASON_CODE
                        AND ROWNUM                 = 1
                      ;
               EXCEPTION WHEN OTHERS THEN
                      X_REASON_DESC := NULL;
               END;

         ELSIF P_REASON_ID IS NOT NULL THEN

               BEGIN
                     SELECT ERE.REASON_DESCRIPTION
                       INTO X_REASON_DESC
                       FROM EAPP_REASON_ENTRY_TLV  ERE
                      WHERE ERE.SOB_ID             = P_SOB_ID
                        AND ERE.ORG_ID             = P_ORG_ID
                        AND ERE.REASON_TYPE        = P_REASON_TYPE
                        AND ERE.REASON_ENTRY_ID    = P_REASON_ID
                        AND ROWNUM                 = 1
                      ;
               EXCEPTION WHEN OTHERS THEN
                      X_REASON_DESC := NULL;
               END;
         ELSE
               X_REASON_DESC := NULL;
         END IF;

         RETURN X_REASON_DESC;

   END GET_REASON_DESC;

  ----------------------------------------
  -- PROCESS STEP DESCRIPTION (STATUS)  --
  ----------------------------------------
   FUNCTION GET_STATUS_DESC ( P_SOB_ID        IN  NUMBER
                            , P_ORG_ID        IN  NUMBER
                            , P_PROCESS_TYPE  IN  VARCHAR2
                            , P_STEP_CODE     IN  VARCHAR2 ) RETURN VARCHAR2
   AS
        X_STATUS_DESC     VARCHAR2(200) := NULL;
   BEGIN

         BEGIN
               SELECT EPS.STEP_DESCRIPTION
                 INTO X_STATUS_DESC
                 FROM EAPP_PROCESS_STEP  EPS
                WHERE EPS.SOB_ID         = P_SOB_ID
                  AND EPS.ORG_ID         = P_ORG_ID
                  AND EPS.PROCESS_TYPE   = P_PROCESS_TYPE
                  AND EPS.STEP_CODE      = P_STEP_CODE
                ;
         EXCEPTION WHEN OTHERS THEN
                X_STATUS_DESC := NULL;
         END;


         RETURN X_STATUS_DESC;

   END GET_STATUS_DESC;

   
  ----------------------------------------
  -- Transaction Type ID Return         --
  ----------------------------------------
   FUNCTION GET_TRX_TYPE_ID_F ( P_SOB_ID        IN  NUMBER
                              , P_ORG_ID        IN  NUMBER
                              , P_TRX_TYPE      IN  VARCHAR2) RETURN NUMBER
   AS
        X_TRX_TYPE_ID     NUMBER;
   BEGIN

         BEGIN
               SELECT ITT.TRANSACTION_TYPE_ID
                 INTO X_TRX_TYPE_ID
                 FROM INV_TRANSACTION_TYPE   ITT
                WHERE ITT.SOB_ID             = P_SOB_ID
                  AND ITT.ORG_ID             = P_ORG_ID
                  AND ITT.TRANSACTION_TYPE   = P_TRX_TYPE
                ;
         EXCEPTION WHEN OTHERS THEN
                X_TRX_TYPE_ID := NULL;
         END;


         RETURN X_TRX_TYPE_ID;

   END GET_TRX_TYPE_ID_F;

  ----------------------------------------
  -- Transaction Type  Return           --
  ----------------------------------------
   FUNCTION GET_TRX_TYPE_DESC_F ( P_TRX_TYPE_ID      IN  NUMBER) RETURN VARCHAR2
   AS
        X_TRX_TYPE_DESC     NUMBER;
   BEGIN

         BEGIN
               SELECT ITT.TRANSACTION_TYPE
                 INTO X_TRX_TYPE_DESC
                 FROM INV_TRANSACTION_TYPE   ITT
                WHERE ITT.TRANSACTION_TYPE_ID  = P_TRX_TYPE_ID
                ;
         EXCEPTION WHEN OTHERS THEN
                X_TRX_TYPE_DESC := NULL;
         END;


         RETURN X_TRX_TYPE_DESC;

   END GET_TRX_TYPE_DESC_F;


  ----------------------------------------
  -- Transaction CLASS ID Return         --
  ----------------------------------------
   FUNCTION GET_TRX_CLASS_ID_F ( P_SOB_ID         IN  NUMBER
                               , P_ORG_ID         IN  NUMBER
                               , P_TRX_TYPE       IN  VARCHAR2) RETURN NUMBER
   AS
        X_TRX_CLASS_ID     NUMBER;
   BEGIN

         BEGIN
               SELECT ITT.TRANSACTION_CLASS_ID
                 INTO X_TRX_CLASS_ID
                 FROM INV_TRANSACTION_TYPE   ITT
                WHERE ITT.SOB_ID             = P_SOB_ID
                  AND ITT.ORG_ID             = P_ORG_ID
                  AND ITT.TRANSACTION_TYPE   = P_TRX_TYPE
                ;
         EXCEPTION WHEN OTHERS THEN
                X_TRX_CLASS_ID := NULL;
         END;


         RETURN X_TRX_CLASS_ID;

   END GET_TRX_CLASS_ID_F;

  ----------------------------------------
  -- Transaction Type  Return           --
  ----------------------------------------
   FUNCTION GET_TRX_CLASS_DESC_F ( P_TRX_CLASS_ID      IN  NUMBER) RETURN VARCHAR2
   AS
        X_TRX_CLASS_DESC     VARCHAR2(200);
   BEGIN

         BEGIN
               SELECT ITT.TRANSACTION_CLASS
                 INTO X_TRX_CLASS_DESC
                 FROM INV_TRANSACTION_CLASS   ITT
                WHERE ITT.TRANSACTION_CLASS_ID  = P_TRX_CLASS_ID
                ;
         EXCEPTION WHEN OTHERS THEN
                X_TRX_CLASS_DESC := NULL;
         END;


         RETURN X_TRX_CLASS_DESC;

   END GET_TRX_CLASS_DESC_F;

  ----------------------------------------
  -- GET_UOM_CONVERSION_QTY_F  Return   --
  -- UOM 환산량 산출                    --
  ----------------------------------------
   FUNCTION GET_UOM_CONVERT_QTY_F  ( P_INVENTORY_ITEM_ID IN  NUMBER
                                   , P_FROM_UOM_CODE     IN  VARCHAR2
                                   , P_TO_UOM_CODE       IN  VARCHAR2
                                   , P_QTY               IN  NUMBER) RETURN NUMBER
   AS
        V_CONVERT_RATE      NUMBER;
        X_CONVERT_QTY       NUMBER;
   BEGIN

         -- CONVERT RATE SELECT --
         BEGIN
              SELECT IIM.UOM_CONVERT_RATE
                INTO V_CONVERT_RATE
                FROM INV_ITEM_MASTER  IIM
               WHERE IIM.INVENTORY_ITEM_ID  = P_INVENTORY_ITEM_ID
                 AND IIM.PRIMARY_UOM_CODE   = P_TO_UOM_CODE
                 AND IIM.SECONDARY_UOM_CODE = P_FROM_UOM_CODE
                ;
         EXCEPTION WHEN OTHERS THEN
                V_CONVERT_RATE := 0;
         END;

         X_CONVERT_QTY := NVL(P_QTY,0) * NVL(V_CONVERT_RATE,0);


         RETURN X_CONVERT_QTY;

   END GET_UOM_CONVERT_QTY_F;

  ----------------------------------------
  -- GET_WAREHOUSE_TYPE_F  Return        --
  ----------------------------------------
   FUNCTION GET_WAREHOUSE_TYPE_F ( P_WAREHOUSE_ID      IN  NUMBER) RETURN VARCHAR2
   AS
        X_WAREHOUSE_TYPE            VARCHAR2(100);
        V_FG_WIP_WAREHOUSE          VARCHAR2(1);
        V_FG_MAIN_WAREHOUSE         VARCHAR2(1);
        V_FG_SURPLUS_WAREHOUSE      VARCHAR2(1);
        V_FG_SHIP_WAREHOUSE         VARCHAR2(1);
        V_FG_RETURN_WAREHOUSE       VARCHAR2(1);
        V_FG_SCRAP_WAREHOUSE        VARCHAR2(1);        
        V_MAT_MAIN_WAREHOUSE        VARCHAR2(1);
        V_MAT_WORKCENTER_WAREHOUSE  VARCHAR2(1);
   BEGIN

         BEGIN
               SELECT NVL(IW.FG_WIP_WAREHOUSE,'N')
                    , NVL(IW.FG_MAIN_WAREHOUSE,'N')
                    , NVL(IW.FG_SURPLUS_WAREHOUSE,'N')
                    , NVL(IW.FG_SHIP_WAREHOUSE,'N')
                    , NVL(IW.FG_RETURN_WAREHOUSE,'N')
                    , NVL(IW.FG_SCRAP_WAREHOUSE,'N')
                    , NVL(IW.MAT_MAIN_WAREHOUSE,'N')
                    , NVL(IW.WORKCENTER_WAREHOUSE,'N')
                 INTO V_FG_WIP_WAREHOUSE
                    , V_FG_MAIN_WAREHOUSE
                    , V_FG_SURPLUS_WAREHOUSE
                    , V_FG_SHIP_WAREHOUSE
                    , V_FG_RETURN_WAREHOUSE
                    , V_FG_SCRAP_WAREHOUSE 
                    , V_MAT_MAIN_WAREHOUSE
                    , V_MAT_WORKCENTER_WAREHOUSE
                 FROM INV_WAREHOUSE IW
                WHERE IW.WAREHOUSE_ID  = P_WAREHOUSE_ID
                ;
         EXCEPTION WHEN OTHERS THEN
                V_FG_WIP_WAREHOUSE      :='N';
                V_FG_MAIN_WAREHOUSE     :='N';
                V_FG_SURPLUS_WAREHOUSE  :='N';
                V_FG_SHIP_WAREHOUSE     :='N';
                V_FG_RETURN_WAREHOUSE   :='N';
                V_FG_SCRAP_WAREHOUSE    :='N';
         END;
         
         IF    V_FG_WIP_WAREHOUSE  = 'Y' OR V_MAT_MAIN_WAREHOUSE = 'Y' THEN
                 X_WAREHOUSE_TYPE := 'WIP';
         ELSIF V_FG_SHIP_WAREHOUSE = 'Y' THEN
                 X_WAREHOUSE_TYPE := 'SHIP';
         ELSE 
                 X_WAREHOUSE_TYPE := 'INV';
         END IF;
         
         RETURN X_WAREHOUSE_TYPE;

   END GET_WAREHOUSE_TYPE_F;
   
   
  ----------------------------------------
  -- Default Location ID  Return        --
  ----------------------------------------
   FUNCTION GET_WH_DEFAULT_LOCATION_ID_F ( P_SOB_ID            IN  NUMBER
                                         , P_WAREHOUSE_ID      IN  NUMBER) RETURN NUMBER
   AS
        V_LOCAL_DATE           DATE := TRUNC(get_local_date(P_SOB_ID));
        X_DEFAULT_LOCATION_ID     NUMBER;
   BEGIN

         BEGIN
               SELECT IWL.WH_LOCATION_ID
                 INTO X_DEFAULT_LOCATION_ID
                 FROM INV_WH_LOCATION     IWL
                WHERE IWL.WAREHOUSE_ID    = P_WAREHOUSE_ID
                  AND NVL(IWL.PRIMARY_FLAG,'N') = 'Y'
                  AND V_LOCAL_DATE        BETWEEN NVL(IWL.EFFECTIVE_DATE_FR, V_LOCAL_DATE)
                                              AND NVL(IWL.EFFECTIVE_DATE_TO, V_lOCAL_DATE)
                  AND NVL(IWL.ENABLED_FLAG, 'N') = 'Y'
                  AND ROWNUM                     = 1
                ;
         EXCEPTION WHEN OTHERS THEN
                X_DEFAULT_LOCATION_ID := NULL;
         END;


         RETURN X_DEFAULT_LOCATION_ID;

   END GET_WH_DEFAULT_LOCATION_ID_F;

  ----------------------------------------
  -- Default Warehouse (생산창고)       --
  ----------------------------------------
   PROCEDURE GET_WH_DEFAULT_FG_WIP_P( P_SOB_ID            IN   NUMBER
                                    , P_ORG_ID            IN   NUMBER
                                    , X_WAREHOUSE_ID      OUT  NUMBER
                                    , X_WAREHOUSE_CODE    OUT  VARCHAR2
                                    , X_WAREHOUSE_NAME    OUT  VARCHAR2
                                    , X_LOCATION_ID       OUT  NUMBER
                                    , X_LOCATION_CODE     OUT  VARCHAR2
                                    , X_LOCATION_NAME     OUT  VARCHAR2)

   AS
        V_LOCAL_DATE           DATE := TRUNC(get_local_date(P_SOB_ID));
   BEGIN

         BEGIN
             SELECT IW.WAREHOUSE_CODE
                  , IW.WAREHOUSE_NAME
                  , WL.LOCATION_CODE
                  , WL.LOCATION_NAME
                  , IW.WAREHOUSE_ID
                  , WL.WH_LOCATION_ID
               INTO X_WAREHOUSE_CODE
                  , X_WAREHOUSE_NAME
                  , X_LOCATION_CODE
                  , X_LOCATION_NAME
                  , X_WAREHOUSE_ID
                  , X_LOCATION_ID
               FROM INV_WAREHOUSE_TLV      IW
                  , INV_WH_LOCATION_TLV    WL
              WHERE IW.SOB_ID                    = P_SOB_ID
                AND IW.ORG_ID                    = P_ORG_ID
                AND NVL(IW.FG_WIP_WAREHOUSE,'N') = 'Y'
                AND WL.WAREHOUSE_ID              = IW.WAREHOUSE_ID
                AND V_LOCAL_DATE                 BETWEEN NVL(IW.EFFECTIVE_DATE_FR, V_LOCAL_DATE)
                                                 AND NVL(IW.EFFECTIVE_DATE_TO, V_LOCAL_DATE)
                AND NVL(IW.ENABLED_FLAG, 'N')    = 'Y'
                AND ROWNUM                       = 1
              ORDER BY IW.WAREHOUSE_CODE
                ;
         EXCEPTION WHEN OTHERS THEN
                X_WAREHOUSE_CODE  := NULL;
                X_WAREHOUSE_NAME  := NULL;
                X_LOCATION_CODE   := NULL;
                X_LOCATION_NAME   := NULL;
                X_WAREHOUSE_ID    := NULL;
                X_LOCATION_ID     := NULL;
         END;

   END GET_WH_DEFAULT_FG_WIP_P;

  ----------------------------------------
  -- Default Warehouse (영업제품창고)   --
  ----------------------------------------
   PROCEDURE GET_WH_DEFAULT_FG_MAIN_P ( P_SOB_ID            IN   NUMBER
                                      , P_ORG_ID            IN   NUMBER
                                      , X_WAREHOUSE_ID      OUT  NUMBER
                                      , X_WAREHOUSE_CODE    OUT  VARCHAR2
                                      , X_WAREHOUSE_NAME    OUT  VARCHAR2
                                      , X_LOCATION_ID       OUT  NUMBER
                                      , X_LOCATION_CODE     OUT  VARCHAR2
                                      , X_LOCATION_NAME     OUT  VARCHAR2)
   AS
        V_LOCAL_DATE           DATE := TRUNC(get_local_date(P_SOB_ID));
   BEGIN

         BEGIN
             SELECT IW.WAREHOUSE_CODE
                  , IW.WAREHOUSE_NAME
                  , WL.LOCATION_CODE
                  , WL.LOCATION_NAME
                  , IW.WAREHOUSE_ID
                  , WL.WH_LOCATION_ID
               INTO X_WAREHOUSE_CODE
                  , X_WAREHOUSE_NAME
                  , X_LOCATION_CODE
                  , X_LOCATION_NAME
                  , X_WAREHOUSE_ID
                  , X_LOCATION_ID
               FROM INV_WAREHOUSE_TLV      IW
                  , INV_WH_LOCATION_TLV    WL
              WHERE IW.SOB_ID                    = P_SOB_ID
                AND IW.ORG_ID                    = P_ORG_ID
                AND NVL(IW.FG_MAIN_WAREHOUSE,'N') = 'Y'
                AND WL.WAREHOUSE_ID              = IW.WAREHOUSE_ID
                AND V_LOCAL_DATE                 BETWEEN NVL(IW.EFFECTIVE_DATE_FR, V_LOCAL_DATE)
                                                 AND NVL(IW.EFFECTIVE_DATE_TO, V_LOCAL_DATE)
                AND NVL(IW.ENABLED_FLAG, 'N')    = 'Y'
                AND ROWNUM                       = 1
              ORDER BY IW.WAREHOUSE_CODE
                ;
         EXCEPTION WHEN OTHERS THEN
                X_WAREHOUSE_CODE  := NULL;
                X_WAREHOUSE_NAME  := NULL;
                X_LOCATION_CODE   := NULL;
                X_LOCATION_NAME   := NULL;
                X_WAREHOUSE_ID    := NULL;
                X_LOCATION_ID     := NULL;
         END;

   END GET_WH_DEFAULT_FG_MAIN_P;

  ----------------------------------------
  -- Default Warehouse (잉여제품창고)   --
  ----------------------------------------
   PROCEDURE GET_WH_DEFAULT_FG_SURPLUS_P  ( P_SOB_ID            IN   NUMBER
                                          , P_ORG_ID            IN   NUMBER
                                          , X_WAREHOUSE_ID      OUT  NUMBER
                                          , X_WAREHOUSE_CODE    OUT  VARCHAR2
                                          , X_WAREHOUSE_NAME    OUT  VARCHAR2
                                          , X_LOCATION_ID       OUT  NUMBER
                                          , X_LOCATION_CODE     OUT  VARCHAR2
                                          , X_LOCATION_NAME     OUT  VARCHAR2)
   AS
        V_LOCAL_DATE           DATE := TRUNC(get_local_date(P_SOB_ID));
   BEGIN

         BEGIN
             SELECT IW.WAREHOUSE_CODE
                  , IW.WAREHOUSE_NAME
                  , WL.LOCATION_CODE
                  , WL.LOCATION_NAME
                  , IW.WAREHOUSE_ID
                  , WL.WH_LOCATION_ID
               INTO X_WAREHOUSE_CODE
                  , X_WAREHOUSE_NAME
                  , X_LOCATION_CODE
                  , X_LOCATION_NAME
                  , X_WAREHOUSE_ID
                  , X_LOCATION_ID
               FROM INV_WAREHOUSE_TLV      IW
                  , INV_WH_LOCATION_TLV    WL
              WHERE IW.SOB_ID                    = P_SOB_ID
                AND IW.ORG_ID                    = P_ORG_ID
                AND NVL(IW.FG_SURPLUS_WAREHOUSE,'N') = 'Y'
                AND WL.WAREHOUSE_ID              = IW.WAREHOUSE_ID
                AND V_LOCAL_DATE                 BETWEEN NVL(IW.EFFECTIVE_DATE_FR, V_LOCAL_DATE)
                                                 AND NVL(IW.EFFECTIVE_DATE_TO, V_LOCAL_DATE)
                AND NVL(IW.ENABLED_FLAG, 'N')    = 'Y'
                AND ROWNUM                       = 1
              ORDER BY IW.WAREHOUSE_CODE
                ;
         EXCEPTION WHEN OTHERS THEN
                X_WAREHOUSE_CODE  := NULL;
                X_WAREHOUSE_NAME  := NULL;
                X_LOCATION_CODE   := NULL;
                X_LOCATION_NAME   := NULL;
                X_WAREHOUSE_ID    := NULL;
                X_LOCATION_ID     := NULL;
         END;

   END GET_WH_DEFAULT_FG_SURPLUS_P;

  ----------------------------------------
  -- Default Warehouse (제품적송창고)   --
  ----------------------------------------
   PROCEDURE GET_WH_DEFAULT_FG_SHIP_P ( P_SOB_ID            IN   NUMBER
                                      , P_ORG_ID            IN   NUMBER
                                      , X_WAREHOUSE_ID      OUT  NUMBER
                                      , X_WAREHOUSE_CODE    OUT  VARCHAR2
                                      , X_WAREHOUSE_NAME    OUT  VARCHAR2
                                      , X_LOCATION_ID       OUT  NUMBER
                                      , X_LOCATION_CODE     OUT  VARCHAR2
                                      , X_LOCATION_NAME     OUT  VARCHAR2)
   AS
        V_LOCAL_DATE           DATE := TRUNC(get_local_date(P_SOB_ID));
   BEGIN

         BEGIN
             SELECT IW.WAREHOUSE_CODE
                  , IW.WAREHOUSE_NAME
                  , WL.LOCATION_CODE
                  , WL.LOCATION_NAME
                  , IW.WAREHOUSE_ID
                  , WL.WH_LOCATION_ID
               INTO X_WAREHOUSE_CODE
                  , X_WAREHOUSE_NAME
                  , X_LOCATION_CODE
                  , X_LOCATION_NAME
                  , X_WAREHOUSE_ID
                  , X_LOCATION_ID
               FROM INV_WAREHOUSE_TLV      IW
                  , INV_WH_LOCATION_TLV    WL
              WHERE IW.SOB_ID                    = P_SOB_ID
                AND IW.ORG_ID                    = P_ORG_ID
                AND NVL(IW.FG_SHIP_WAREHOUSE,'N') = 'Y'
                AND WL.WAREHOUSE_ID              = IW.WAREHOUSE_ID
                AND V_LOCAL_DATE                 BETWEEN NVL(IW.EFFECTIVE_DATE_FR, V_LOCAL_DATE)
                                                 AND NVL(IW.EFFECTIVE_DATE_TO, V_LOCAL_DATE)
                AND NVL(IW.ENABLED_FLAG, 'N')    = 'Y'
                AND ROWNUM                       = 1
              ORDER BY IW.WAREHOUSE_CODE
                ;
         EXCEPTION WHEN OTHERS THEN
                X_WAREHOUSE_CODE  := NULL;
                X_WAREHOUSE_NAME  := NULL;
                X_LOCATION_CODE   := NULL;
                X_LOCATION_NAME   := NULL;
                X_WAREHOUSE_ID    := NULL;
                X_LOCATION_ID     := NULL;
         END;

   END GET_WH_DEFAULT_FG_SHIP_P;


  ----------------------------------------
  -- Default Warehouse (제품반품창고)   --
  ----------------------------------------
   PROCEDURE GET_WH_DEFAULT_FG_RETURN_P ( P_SOB_ID            IN   NUMBER
                                        , P_ORG_ID            IN   NUMBER
                                        , X_WAREHOUSE_ID      OUT  NUMBER
                                        , X_WAREHOUSE_CODE    OUT  VARCHAR2
                                        , X_WAREHOUSE_NAME    OUT  VARCHAR2
                                        , X_LOCATION_ID       OUT  NUMBER
                                        , X_LOCATION_CODE     OUT  VARCHAR2
                                        , X_LOCATION_NAME     OUT  VARCHAR2)
   AS
        V_LOCAL_DATE           DATE := TRUNC(get_local_date(P_SOB_ID));
   BEGIN

         BEGIN
             SELECT IW.WAREHOUSE_CODE
                  , IW.WAREHOUSE_NAME
                  , WL.LOCATION_CODE
                  , WL.LOCATION_NAME
                  , IW.WAREHOUSE_ID
                  , WL.WH_LOCATION_ID
               INTO X_WAREHOUSE_CODE
                  , X_WAREHOUSE_NAME
                  , X_LOCATION_CODE
                  , X_LOCATION_NAME
                  , X_WAREHOUSE_ID
                  , X_LOCATION_ID
               FROM INV_WAREHOUSE_TLV      IW
                  , INV_WH_LOCATION_TLV    WL
              WHERE IW.SOB_ID                    = P_SOB_ID
                AND IW.ORG_ID                    = P_ORG_ID
                AND NVL(IW.FG_RETURN_WAREHOUSE,'N') = 'Y'
                AND WL.WAREHOUSE_ID              = IW.WAREHOUSE_ID
                AND V_LOCAL_DATE                 BETWEEN NVL(IW.EFFECTIVE_DATE_FR, V_LOCAL_DATE)
                                                 AND NVL(IW.EFFECTIVE_DATE_TO, V_LOCAL_DATE)
                AND NVL(IW.ENABLED_FLAG, 'N')    = 'Y'
                AND ROWNUM                       = 1
              ORDER BY IW.WAREHOUSE_CODE
                ;
         EXCEPTION WHEN OTHERS THEN
                X_WAREHOUSE_CODE  := NULL;
                X_WAREHOUSE_NAME  := NULL;
                X_LOCATION_CODE   := NULL;
                X_LOCATION_NAME   := NULL;
                X_WAREHOUSE_ID    := NULL;
                X_LOCATION_ID     := NULL;
         END;

   END GET_WH_DEFAULT_FG_RETURN_P;

  ----------------------------------------
  -- Default Warehouse (제품불용창고)   --
  ----------------------------------------
   PROCEDURE GET_WH_DEFAULT_FG_SCRAP_P  ( P_SOB_ID            IN   NUMBER
                                        , P_ORG_ID            IN   NUMBER
                                        , X_WAREHOUSE_ID      OUT  NUMBER
                                        , X_WAREHOUSE_CODE    OUT  VARCHAR2
                                        , X_WAREHOUSE_NAME    OUT  VARCHAR2
                                        , X_LOCATION_ID       OUT  NUMBER
                                        , X_LOCATION_CODE     OUT  VARCHAR2
                                        , X_LOCATION_NAME     OUT  VARCHAR2)
   AS
        V_LOCAL_DATE           DATE := TRUNC(get_local_date(P_SOB_ID));
   BEGIN

         BEGIN
             SELECT IW.WAREHOUSE_CODE
                  , IW.WAREHOUSE_NAME
                  , WL.LOCATION_CODE
                  , WL.LOCATION_NAME
                  , IW.WAREHOUSE_ID
                  , WL.WH_LOCATION_ID
               INTO X_WAREHOUSE_CODE
                  , X_WAREHOUSE_NAME
                  , X_LOCATION_CODE
                  , X_LOCATION_NAME
                  , X_WAREHOUSE_ID
                  , X_LOCATION_ID
               FROM INV_WAREHOUSE_TLV      IW
                  , INV_WH_LOCATION_TLV    WL
              WHERE IW.SOB_ID                    = P_SOB_ID
                AND IW.ORG_ID                    = P_ORG_ID
                AND NVL(IW.FG_SCRAP_WAREHOUSE,'N') = 'Y'
                AND WL.WAREHOUSE_ID              = IW.WAREHOUSE_ID
                AND V_LOCAL_DATE                 BETWEEN NVL(IW.EFFECTIVE_DATE_FR, V_LOCAL_DATE)
                                                 AND NVL(IW.EFFECTIVE_DATE_TO, V_LOCAL_DATE)
                AND NVL(IW.ENABLED_FLAG, 'N')    = 'Y'
                AND ROWNUM                       = 1
              ORDER BY IW.WAREHOUSE_CODE
                ;
         EXCEPTION WHEN OTHERS THEN
                X_WAREHOUSE_CODE  := NULL;
                X_WAREHOUSE_NAME  := NULL;
                X_LOCATION_CODE   := NULL;
                X_LOCATION_NAME   := NULL;
                X_WAREHOUSE_ID    := NULL;
                X_LOCATION_ID     := NULL;
         END;

   END GET_WH_DEFAULT_FG_SCRAP_P;

  ----------------------------------------
  -- Default Warehouse (자재 주창고)   --
  ----------------------------------------
   PROCEDURE GET_WH_DEFAULT_MAT_MAIN_P  ( P_SOB_ID            IN   NUMBER
                                        , P_ORG_ID            IN   NUMBER
                                        , X_WAREHOUSE_ID      OUT  NUMBER
                                        , X_WAREHOUSE_CODE    OUT  VARCHAR2
                                        , X_WAREHOUSE_NAME    OUT  VARCHAR2
                                        , X_LOCATION_ID       OUT  NUMBER
                                        , X_LOCATION_CODE     OUT  VARCHAR2
                                        , X_LOCATION_NAME     OUT  VARCHAR2)
   AS
        V_LOCAL_DATE           DATE := TRUNC(get_local_date(P_SOB_ID));
   BEGIN

         BEGIN
             SELECT IW.WAREHOUSE_CODE
                  , IW.WAREHOUSE_NAME
                  , WL.LOCATION_CODE
                  , WL.LOCATION_NAME
                  , IW.WAREHOUSE_ID
                  , WL.WH_LOCATION_ID
               INTO X_WAREHOUSE_CODE
                  , X_WAREHOUSE_NAME
                  , X_LOCATION_CODE
                  , X_LOCATION_NAME
                  , X_WAREHOUSE_ID
                  , X_LOCATION_ID
               FROM INV_WAREHOUSE_TLV      IW
                  , INV_WH_LOCATION_TLV    WL
              WHERE IW.SOB_ID                    = P_SOB_ID
                AND IW.ORG_ID                    = P_ORG_ID
                AND NVL(IW.MATERIAL_STOCK_FLAG,'N') = 'Y'
                AND NVL(IW.MAT_MAIN_WAREHOUSE,'N') = 'Y'
                AND WL.WAREHOUSE_ID              = IW.WAREHOUSE_ID
                AND V_LOCAL_DATE                 BETWEEN NVL(IW.EFFECTIVE_DATE_FR, V_LOCAL_DATE)
                                                 AND NVL(IW.EFFECTIVE_DATE_TO, V_LOCAL_DATE)
                AND NVL(IW.ENABLED_FLAG, 'N')    = 'Y'
                AND ROWNUM                       = 1
              ORDER BY IW.WAREHOUSE_CODE
                ;
         EXCEPTION WHEN OTHERS THEN
                X_WAREHOUSE_CODE  := NULL;
                X_WAREHOUSE_NAME  := NULL;
                X_LOCATION_CODE   := NULL;
                X_LOCATION_NAME   := NULL;
                X_WAREHOUSE_ID    := NULL;
                X_LOCATION_ID     := NULL;
         END;

   END GET_WH_DEFAULT_MAT_MAIN_P;

  ----------------------------------------
  -- Default Warehouse (반제품주창고)   --
  ----------------------------------------
   PROCEDURE GET_WH_DEFAULT_SG_MAIN_P  ( P_SOB_ID            IN   NUMBER
                                        , P_ORG_ID            IN   NUMBER
                                        , X_WAREHOUSE_ID      OUT  NUMBER
                                        , X_WAREHOUSE_CODE    OUT  VARCHAR2
                                        , X_WAREHOUSE_NAME    OUT  VARCHAR2
                                        , X_LOCATION_ID       OUT  NUMBER
                                        , X_LOCATION_CODE     OUT  VARCHAR2
                                        , X_LOCATION_NAME     OUT  VARCHAR2)
   AS
        V_LOCAL_DATE           DATE := TRUNC(get_local_date(P_SOB_ID));
   BEGIN

         BEGIN
             SELECT IW.WAREHOUSE_CODE
                  , IW.WAREHOUSE_NAME
                  , WL.LOCATION_CODE
                  , WL.LOCATION_NAME
                  , IW.WAREHOUSE_ID
                  , WL.WH_LOCATION_ID
               INTO X_WAREHOUSE_CODE
                  , X_WAREHOUSE_NAME
                  , X_LOCATION_CODE
                  , X_LOCATION_NAME
                  , X_WAREHOUSE_ID
                  , X_LOCATION_ID
               FROM INV_WAREHOUSE_TLV      IW
                  , INV_WH_LOCATION_TLV    WL
              WHERE IW.SOB_ID                    = P_SOB_ID
                AND IW.ORG_ID                    = P_ORG_ID
                AND NVL(IW.SG_WIP_WAREHOUSE,'N') = 'Y'
                AND WL.WAREHOUSE_ID              = IW.WAREHOUSE_ID
                AND V_LOCAL_DATE                 BETWEEN NVL(IW.EFFECTIVE_DATE_FR, V_LOCAL_DATE)
                                                 AND NVL(IW.EFFECTIVE_DATE_TO, V_LOCAL_DATE)
                AND NVL(IW.ENABLED_FLAG, 'N')    = 'Y'
                AND ROWNUM                       = 1
              ORDER BY IW.WAREHOUSE_CODE
                ;
         EXCEPTION WHEN OTHERS THEN
                X_WAREHOUSE_CODE  := NULL;
                X_WAREHOUSE_NAME  := NULL;
                X_LOCATION_CODE   := NULL;
                X_LOCATION_NAME   := NULL;
                X_WAREHOUSE_ID    := NULL;
                X_LOCATION_ID     := NULL;
         END;

   END GET_WH_DEFAULT_SG_MAIN_P;

  ----------------------------------------
  -- Over Location ID  Return           --
  ----------------------------------------
   FUNCTION GET_WH_OVER_LOCATION_ID_F ( P_SOB_ID            IN  NUMBER
                                      , P_WAREHOUSE_ID      IN  NUMBER) RETURN NUMBER
   AS
        V_LOCAL_DATE           DATE := TRUNC(get_local_date(P_SOB_ID));
        X_OVER_LOCATION_ID     NUMBER;
   BEGIN

         BEGIN
               SELECT IWL.WH_LOCATION_ID
                 INTO X_OVER_LOCATION_ID
                 FROM INV_WH_LOCATION     IWL
                WHERE IWL.WAREHOUSE_ID    = P_WAREHOUSE_ID
                  AND NVL(IWL.OVER_STOCK_FLAG,'N') = 'Y'
                  AND V_LOCAL_DATE        BETWEEN NVL(IWL.EFFECTIVE_DATE_FR, V_LOCAL_DATE)
                                              AND NVL(IWL.EFFECTIVE_DATE_TO, V_lOCAL_DATE)
                  AND NVL(IWL.ENABLED_FLAG, 'N') = 'Y'
                  AND ROWNUM                     = 1
                ;
         EXCEPTION WHEN OTHERS THEN
                X_OVER_LOCATION_ID := NULL;
         END;


         RETURN X_OVER_LOCATION_ID;

   END GET_WH_OVER_LOCATION_ID_F;




  ----------------------------------------
  -- String to Table_Rows            --
  ----------------------------------------
   PROCEDURE SET_STR_SPLIT_ROWS ( P_STR      IN  VARCHAR2
                                , P_CHAR     IN  VARCHAR2)
   IS

   BEGIN
    /*=========================================================
           Temp table: STR_SPLIT_ROW_TEMP table
    ==========================================================*/
   /*DROP TABLE STR_SPLIT_ROW_TEMP;
    CREATE GLOBAL TEMPORARY TABLE STR_SPLIT_ROW_TEMP
    ( ROW_VALUE  VARCHAR2(200) )
    --ON COMMIT DELETE ROWS;
    ON COMMIT PRESERVE ROWS;*/

    DELETE STR_SPLIT_ROW_TEMP;

    -- SET TEMP TABLE Refresh
    INSERT INTO STR_SPLIT_ROW_TEMP
    ( ROW_VALUE )
    SELECT -- 2011.01.18 TRIM문 추가 Y.G LEE
     TRIM(SUBSTR(T1.COL,
            INSTR(T1.COL, P_CHAR, 1, CP.RN) + 1,
            INSTR(T1.COL, P_CHAR, 1, CP.RN+1) - INSTR(T1.COL, P_CHAR, 1, CP.RN) - 1)) AS COL
      FROM (SELECT P_CHAR || P_STR || P_CHAR AS COL FROM DUAL) T1
         , (SELECT LEVEL AS RN FROM DUAL CONNECT BY LEVEL <= LENGTH(P_STR)) CP
     WHERE CP.RN <= LENGTH(T1.COL) - LENGTH(REPLACE(T1.COL, P_CHAR)) - 1;

   END SET_STR_SPLIT_ROWS;


  ----------------------------------------
  -- Get Column Value Fuction           --
  ----------------------------------------
   FUNCTION GET_COLUMN_VALUE_F ( P_TABLE_NAME       IN   VARCHAR2
                               , P_SELECT_COLUMN    IN   VARCHAR2
                               , P_WHERE_CLAUSE     IN   VARCHAR2 ) RETURN VARCHAR2
   IS
        V_SQL                    VARCHAR2(4000);
        V_COLUMN_VALUE           VARCHAR2(4000);
   BEGIN
        V_SQL := 'SELECT ' || P_SELECT_COLUMN || ' FROM ' || P_TABLE_NAME || ' WHERE ' || P_WHERE_CLAUSE || ' AND ROWNUM = 1' ;

        BEGIN
            EXECUTE IMMEDIATE V_SQL INTO V_COLUMN_VALUE;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                V_COLUMN_VALUE := NULL;
                --RETURN NULL;

            WHEN OTHERS THEN
                 V_COLUMN_VALUE := NULL;
                --RAISE_APPLICATION_ERROR( -20001, SQLERRM );
                --RETURN NULL;
        END;

        RETURN V_COLUMN_VALUE;

   END GET_COLUMN_VALUE_F;


  ----------------------------------------
  -- Get Column Value Procedure         --
  ----------------------------------------
   PROCEDURE GET_COLUMN_VALUE_P ( P_TABLE_NAME       IN   VARCHAR2
                                , P_SELECT_COLUMN    IN   VARCHAR2
                                , P_WHERE_CLAUSE     IN   VARCHAR2
                                , X_COLUMN_VALUE     OUT  VARCHAR2
                                , X_RESULT_STATUS    OUT  VARCHAR2
                                , X_RESULT_MSG       OUT  VARCHAR2 )
   IS
        V_SQL                    VARCHAR2(4000);
   BEGIN
        X_RESULT_STATUS := 'F';

        V_SQL := 'SELECT ' || P_SELECT_COLUMN || ' FROM ' || P_TABLE_NAME || ' WHERE ' || P_WHERE_CLAUSE || ' AND ROWNUM = 1';

        BEGIN
            EXECUTE IMMEDIATE V_SQL INTO X_COLUMN_VALUE;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                X_COLUMN_VALUE := NULL;

            WHEN OTHERS THEN
                X_RESULT_MSG := SQLERRM;
                RETURN;
        END;

        X_RESULT_STATUS := 'S';

   END GET_COLUMN_VALUE_P;


  ------------------------------------------
  -- Get Sales Order Line Charge Fuction  --
  ------------------------------------------
   FUNCTION GET_ORDER_LINE_CHARGE_F ( W_ORDER_LINE_ID       IN   NUMBER
                                    , P_VALUE_QTY           IN   NUMBER ) RETURN NUMBER
   IS
        V_CHARGE_AMOUNT               NUMBER := 0;
   BEGIN
        FOR DATA_LIST IN ( SELECT PAYMENT_TYPE
                                , CHARGE_PRICE
                                , CHARGE_AMOUNT
                             FROM OE_SALES_ORDER_CHARGE
                            WHERE ORDER_LINE_ID          = W_ORDER_LINE_ID
                              AND SHIPMENT_COMPLETE_FLAG = 'N' )
        LOOP
            IF DATA_LIST.PAYMENT_TYPE = 'PRICE' THEN
                V_CHARGE_AMOUNT := V_CHARGE_AMOUNT + (P_VALUE_QTY * DATA_LIST.CHARGE_PRICE);
            ELSE
                V_CHARGE_AMOUNT := V_CHARGE_AMOUNT + DATA_LIST.CHARGE_AMOUNT;
            END IF;
        END LOOP;

        RETURN V_CHARGE_AMOUNT;

   EXCEPTION
       WHEN OTHERS THEN
           RAISE_APPLICATION_ERROR( -20001, SQLERRM );

   END GET_ORDER_LINE_CHARGE_F;


  ------------------------------------------
  -- Get Workcenter_ID from Resource_ID   --
  ------------------------------------------
   FUNCTION GET_WORKCENTER_F ( W_RESOURCE_ID       IN   NUMBER) RETURN NUMBER
   IS
        X_WORKCENTER_ID               NUMBER := 0;
   BEGIN

        BEGIN
             SELECT SSR.WORKCENTER_ID
               INTO X_WORKCENTER_ID
               FROM SDM_STANDARD_RESOURCE  SSR
              WHERE SSR.RESOURCE_ID        = W_RESOURCE_ID
              ;
        EXCEPTION WHEN OTHERS THEN
              X_WORKCENTER_ID := NULL;
        END;

        RETURN X_WORKCENTER_ID;

   EXCEPTION
       WHEN OTHERS THEN
           RAISE_APPLICATION_ERROR( -20001, SQLERRM );

   END GET_WORKCENTER_F;


  ----------------------------------------
  -- Get PNL Size X, Y Fuction          --
  ----------------------------------------
   FUNCTION GET_PNL_SIZE_F ( P_INVENTORY_ITEM_ID    IN NUMBER ) RETURN VARCHAR2
   IS
        V_PNL_SIZE           VARCHAR2(50);
   BEGIN
        BEGIN
            SELECT TO_CHAR(PNL_SIZE_X) || 'X' || TO_CHAR(PNL_SIZE_Y)
              INTO V_PNL_SIZE
              FROM SDM_ITEM_SPEC
             WHERE BOM_ITEM_ID = ( SELECT BOM_ITEM_ID
                                     FROM SDM_ITEM_REVISION
                                    WHERE INVENTORY_ITEM_ID      = P_INVENTORY_ITEM_ID
                                      AND BOM_VERSION = ( SELECT MAX(SSIR.BOM_VERSION) BOM_VER
                                                                       FROM SDM_ITEM_REVISION SSIR
                                                                          , SDM_ITEM_SPEC     SSIS
                                                                      WHERE SSIS.BOM_ITEM_ID       = SSIR.BOM_ITEM_ID
                                                                        AND SSIR.INVENTORY_ITEM_ID = P_INVENTORY_ITEM_ID
                                                                        AND SSIR.BOM_STATUS_LCODE  = 'RELEASE'
                                                                        AND SSIR.ENABLED_FLAG      = 'Y'
                                                                        AND TRUNC(GET_LOCAL_DATE(SSIR.SOB_ID)) BETWEEN SSIR.EFFECTIVE_DATE_FR
                                                                                                               AND NVL(SSIR.EFFECTIVE_DATE_TO,TRUNC(GET_LOCAL_DATE(SSIR.SOB_ID))) ) );
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                RETURN NULL;

            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR( -20001, SQLERRM );
                RETURN NULL;
        END;

        RETURN V_PNL_SIZE;

   END GET_PNL_SIZE_F;


  ----------------------------------------
  -- Get PCS PER PNL Qty Fuction        --
  ----------------------------------------
   FUNCTION GET_PCS_INVENTORY_ITEM_F ( P_INVENTORY_ITEM_ID    IN NUMBER ) RETURN NUMBER
   IS
        V_PCS_PER_PNL_QTY           NUMBER;
   BEGIN
        BEGIN
            SELECT PCS_PER_PNL_QTY
              INTO V_PCS_PER_PNL_QTY
              FROM SDM_ITEM_SPEC
             WHERE BOM_ITEM_ID = ( SELECT BOM_ITEM_ID
                                     FROM SDM_ITEM_REVISION
                                    WHERE INVENTORY_ITEM_ID      = P_INVENTORY_ITEM_ID
                                      AND BOM_VERSION = ( SELECT MAX(SSIR.BOM_VERSION) BOM_VER
                                                                       FROM SDM_ITEM_REVISION SSIR
                                                                          , SDM_ITEM_SPEC     SSIS
                                                                      WHERE SSIS.BOM_ITEM_ID       = SSIR.BOM_ITEM_ID
                                                                        AND SSIR.INVENTORY_ITEM_ID = P_INVENTORY_ITEM_ID
                                                                        AND SSIR.BOM_STATUS_LCODE  = 'RELEASE'
                                                                        AND SSIR.ENABLED_FLAG      = 'Y'
                                                                        AND TRUNC(GET_LOCAL_DATE(SSIR.SOB_ID)) BETWEEN SSIR.EFFECTIVE_DATE_FR
                                                                                                               AND NVL(SSIR.EFFECTIVE_DATE_TO,TRUNC(GET_LOCAL_DATE(SSIR.SOB_ID))) ) );
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                RETURN NULL;

            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR( -20001, SQLERRM );
                RETURN NULL;
        END;

        RETURN V_PCS_PER_PNL_QTY;

   END GET_PCS_INVENTORY_ITEM_F;

  ----------------------------------------
  -- 공정 체공시간 산출                 --
  ----------------------------------------
   FUNCTION GET_WIP_TRX_DELAY_TIME_F ( P_JOB_ID           IN NUMBER
                                     , P_OPERATION_SEQ_NO IN NUMBER
                                     , P_OPERATION_ID     IN NUMBER) RETURN VARCHAR2
   IS
        V_LOCAL_DATE      DATE;

        V_RECEIPT_TIME    DATE;
        V_TOMOVE_TIME     DATE;
        V_ONHAND_FLAG     VARCHAR2(1) := 'N';
        V_SOB_ID          NUMBER;

        V_DELAY_TIME      NUMBER;
        X_DELAY_TIME_CHAR VARCHAR2(200);
   BEGIN

        -- 재공 유무 체크   --
        BEGIN
             SELECT NVL(WOS.ONHAND_FLAG,'N')
                  , WOS.SOB_ID
               INTO V_ONHAND_FLAG
                  , V_SOB_ID
               FROM WIP_OPERATIONS WOS
              WHERE WOS.JOB_ID           = P_JOB_ID
                AND WOS.OPERATION_SEQ_NO = P_OPERATION_SEQ_NO
                AND WOS.OPERATION_ID     = P_OPERATION_ID
              ;
        EXCEPTION WHEN OTHERS THEN
             V_ONHAND_FLAG := 'N';
        END;

        V_LOCAL_DATE := GET_LOCAL_DATE(V_SOB_ID);

        -- RECEIPT TIME --
        BEGIN
             SELECT MAX(WMT.MOVE_TRX_DATE)
               INTO V_RECEIPT_TIME
               FROM WIP_MOVE_TRANSACTIONS  WMT
              WHERE WMT.JOB_ID             = P_JOB_ID
                AND WMT.TO_OP_SEQ_NO       = P_OPERATION_SEQ_NO
                AND WMT.TO_OPERATION_ID    = P_OPERATION_ID
                AND WMT.MOVE_TRX_TYPE      = 'RECEIPT'
              ;
        EXCEPTION WHEN OTHERS THEN
             V_RECEIPT_TIME := NULL;
        END;

        -- TOMOVE TIME --
        BEGIN
             SELECT MAX(WMT.MOVE_TRX_DATE)
               INTO V_TOMOVE_TIME
               FROM WIP_MOVE_TRANSACTIONS  WMT
              WHERE WMT.JOB_ID             = P_JOB_ID
                AND WMT.TO_OP_SEQ_NO       = P_OPERATION_SEQ_NO
                AND WMT.TO_OPERATION_ID    = P_OPERATION_ID
                AND WMT.MOVE_TRX_TYPE      = 'TOMOVE'
              ;
        EXCEPTION WHEN OTHERS THEN
             V_TOMOVE_TIME := NULL;
        END;

        IF V_RECEIPT_TIME IS NOT NULL THEN
            IF V_ONHAND_FLAG = 'Y' THEN
                V_DELAY_TIME := V_LOCAL_DATE - V_RECEIPT_TIME;
            ELSE
                V_DELAY_TIME := V_TOMOVE_TIME - V_RECEIPT_TIME;
            END IF;

            SELECT TRUNC(V_DELAY_TIME) || '일 ' ||
                    TRUNC(MOD(V_DELAY_TIME,1)*24)|| '시간 ' ||
                    TRUNC(MOD(V_DELAY_TIME*24,1)*60)|| '분'
              INTO X_DELAY_TIME_CHAR
              FROM DUAL ;
        ELSE
           X_DELAY_TIME_CHAR := NULL;
        END IF;

        RETURN X_DELAY_TIME_CHAR;

   END GET_WIP_TRX_DELAY_TIME_F;

  ----------------------------------------
  -- 서버 현재일시 기준 월 첫일        --
  ----------------------------------------
   FUNCTION GET_MONTH_FIRST_DAY_F (P_SOB_ID IN NUMBER) RETURN DATE
   IS
      V_FIRST_DAY      DATE;
   BEGIN
      SELECT TO_DATE(TO_CHAR(GET_LOCAL_DATE(P_SOB_ID), 'YYYY-MM') || '-01', 'YYYY-MM-DD')
        INTO V_FIRST_DAY
        FROM DUAL;

        RETURN V_FIRST_DAY;
   END GET_MONTH_FIRST_DAY_F;

  ----------------------------------------
  -- 서버 현재일시 기준 월 마지막일     --
  ----------------------------------------
   FUNCTION GET_MONTH_LAST_DAY_F (P_SOB_ID IN NUMBER) RETURN DATE
   IS

      V_LAST_DAY      DATE;
   BEGIN
      SELECT TO_DATE(LAST_DAY(GET_LOCAL_DATE(P_SOB_ID)), 'YYYY-MM-DD')
        INTO V_LAST_DAY
        FROM DUAL;

        RETURN V_LAST_DAY;
   END GET_MONTH_LAST_DAY_F;

   -----------------------------------------------------
  -- 서버 현재일시 기준 월 첫번째, 오늘, 마지막일     --
  ------------------------------------------------------
   PROCEDURE GET_MONTH_FILL_DAY_P
             ( P_SOB_ID       IN  NUMBER
             , X_FIRST_DAY    OUT DATE
             , X_LAST_DAY     OUT DATE
             , X_TODAY        OUT DATE)
   IS

   BEGIN

      X_FIRST_DAY := GET_MONTH_FIRST_DAY_F(P_SOB_ID);
      X_LAST_DAY  := GET_MONTH_LAST_DAY_F(P_SOB_ID);
      X_TODAY     := GET_LOCAL_DATE(P_SOB_ID);
   END GET_MONTH_FILL_DAY_P;
   
  --------------------------------
  -- 당일 마지막일시 (long date)  --
  --------------------------------
   FUNCTION GET_END_OF_DAY_F
            ( P_DATE         IN  DATE) RETURN DATE     
   IS
     
   BEGIN
   
      RETURN TRUNC(SYSDATE+1) - (1/24/60/60);
   END GET_END_OF_DAY_F; 
   
END EAPP_COMMON_G; 
/
