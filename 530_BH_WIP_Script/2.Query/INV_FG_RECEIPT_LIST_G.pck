CREATE OR REPLACE PACKAGE INV_FG_RECEIPT_LIST_G IS
/******************************************************************************/
/* Project      : FLEX ERP
/* Module       : SCM
/* Program Name : 제품 입고 현황
/* Description  : 제품 입고 관련 현황
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUL-2011  Shin Man Jae       유형별 입고현황 (MAT_RECEIPT_BY_TYPE)
/******************************************************************************/


 -----------------------
 -- 유형별 입고현황   --
 -----------------------
 PROCEDURE FG_RECEIPT_BY_TYPE ( P_CURSOR                   OUT  TYPES.TCURSOR
                              , W_SOB_ID                   IN   NUMBER
                              , W_ORG_ID                   IN   NUMBER
                              , W_RECEIPT_DATE_FR            IN   DATE
                              , W_RECEIPT_DATE_TO            IN   DATE
                              , W_WAREHOUSE_ID             IN   NUMBER
                              , W_RECEIPT_TYPE_CODE          IN   VARCHAR2
                              , W_ITEM_SECTION_CODE        IN   VARCHAR2
                              , W_ITEM_NET_CODE            IN   INV_ITEM_MASTER.ITEM_NET_CODE%TYPE
                              , W_INVENTORY_ITEM_ID        IN   NUMBER
                              );
 

END INV_FG_RECEIPT_LIST_G; 
 
/
CREATE OR REPLACE PACKAGE BODY INV_FG_RECEIPT_LIST_G IS
/******************************************************************************/
/* Project      : FLEX ERP
/* Module       : SCM
/* Program Name : 제품 입고 현황
/* Description  : 제품 입고 관련 현황
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUL-2011  Shin Man Jae       유형별 입고현황 (FG_RECEIPT_BY_TYPE)
/******************************************************************************/

 -----------------------
 -- 유형별 입고현황   --
 -----------------------
 PROCEDURE FG_RECEIPT_BY_TYPE ( P_CURSOR                   OUT  TYPES.TCURSOR
                              , W_SOB_ID                   IN   NUMBER
                              , W_ORG_ID                   IN   NUMBER
                              , W_RECEIPT_DATE_FR            IN   DATE
                              , W_RECEIPT_DATE_TO            IN   DATE
                              , W_WAREHOUSE_ID             IN   NUMBER
                              , W_RECEIPT_TYPE_CODE          IN   VARCHAR2
                              , W_ITEM_SECTION_CODE        IN   VARCHAR2
                              , W_ITEM_NET_CODE            IN   INV_ITEM_MASTER.ITEM_NET_CODE%TYPE
                              , W_INVENTORY_ITEM_ID        IN   NUMBER
                              )
 IS
 BEGIN

       OPEN P_CURSOR FOR
        SELECT IIM.ITEM_CODE
             , IIM.ITEM_DESCRIPTION
             , IIS.DESCRIPTION       AS ITEM_SECTION_DESC
             --, ITC.DESCRIPTION       AS RECEIPT_CLASS
             , CASE WHEN ITS.TRANSACTION_ALIAS = 'OP PULL'    THEN MTH.DESCRIPTION
                    WHEN ITS.TRANSACTION_ALIAS = 'FG_RECEIPT' THEN ITT.DESCRIPTION
                    ELSE MRU.ATTRIBUTE_A
               END  AS RECEIPT_CLASS  
             , ITT.DESCRIPTION  AS RECEIPT_SUB_TYPE
             , ITS.TRANSACTION_DATE            AS RECEIPT_DATE
             , CASE WHEN ITC.TRANSACTION_CLASS = 'STORE' 
                    THEN ROUND(ITS.TRANSACTION_QTY,0)
                    ELSE ROUND(ITS.TRANSACTION_QTY,0) * (-1)
               END                 AS ISSUE_QTY
             , CASE WHEN ITS.TRANSACTION_ALIAS = 'FG_RECEIPT' THEN (SELECT WJE.JOB_NO FROM WIP_JOB_ENTITIES WJE WHERE WJE.JOB_ID = ITS.WIP_JOB_ID)
                    ELSE ITS.SOURCE_HEADER_NO
               END                AS SOURCE_HEADER_NO
             , EAPP_COMMON_G.GET_PERSON_SNAME_BY_USER(ITS.LAST_UPDATED_BY) AS PERSON_NAME
             , IW.WAREHOUSE_NAME  AS WAREHOUSE_NAME
             , IL.LOCATION_NAME   AS LOCATION_NAME
             , (SELECT W.WAREHOUSE_NAME
                  FROM INV_WAREHOUSE  W
                 WHERE W.WAREHOUSE_ID = TTS.WAREHOUSE_ID)  AS REF_WAREHOUSE_NAME
             , (SELECT L.LOCATION_NAME
                  FROM INV_WH_LOCATION L
                 WHERE L.WH_LOCATION_ID = TTS.LOCATION_ID) AS REF_LOCATION_NAME
                 
             , IW.WAREHOUSE_CODE  AS WAREHOUSE_CODE
             , IL.LOCATION_CODE   AS LOCATION_CODE
             , SUBSTR(ITS.SOURCE_HEADER_NO,1,2) AS RECEIPT_TYPE
             , ITS.SOURCE_HEADER_ID
             , ITS.SOURCE_LINE_ID
          FROM INV_TRANSACTIONS       ITS
             , INV_TRANSACTION_CLASS  ITC
             , INV_TRANSACTION_TYPE   ITT
             , INV_ITEM_MASTER        IIM
             , INV_ITEM_SECTION       IIS
             , INV_WAREHOUSE          IW
             , INV_WH_LOCATION        IL
             , INV_ITEM_ISSUE_METHOD  MTH
             , EAPP_MASTER_NO_RULE    MRU
             , INV_TRANSACTIONS       TTS  -- 출고 창고 검색용
         WHERE ITC.TRANSACTION_CLASS_ID   = ITS.TRANSACTION_CLASS_ID
           AND ITC.TRANSACTION_CLASS      IN ('STORE', 'STORE_RETURN')
           AND ITT.TRANSACTION_TYPE_ID    = ITS.TRANSACTION_TYPE_ID
           AND IIM.INVENTORY_ITEM_ID      = ITS.INVENTORY_ITEM_ID
--           AND IIM.ITEM_DIVISION_CODE     = 'GOODS'  -- 제품류만 해당 --
           AND IIM.ITEM_CATEGORY_CODE     = 'FG'  -- 제품류만 해당 --
           AND IIS.SOB_ID                 = IIM.SOB_ID
           AND IIS.ORG_ID                 = IIM.ORG_ID
           AND IIS.ITEM_SECTION_CODE      = IIM.ITEM_SECTION_CODE
           AND IW.WAREHOUSE_ID            = ITS.WAREHOUSE_ID
           AND IL.WH_LOCATION_ID          = ITS.LOCATION_ID
           AND MTH.SOB_ID(+)              = ITS.SOB_ID
           AND MTH.ORG_ID(+)              = ITS.ORG_ID
           AND MTH.ISSUE_METHOD_CODE(+)   = 'OP PULL'
           AND MRU.SOB_ID(+)              = ITS.SOB_ID
           AND MRU.ORG_ID(+)              = ITS.ORG_ID
           AND MRU.ATTRIBUTE_B(+)         = 'FG'
           AND MRU.PREFIX_CHAR(+)         = SUBSTR(ITS.SOURCE_HEADER_NO,1,2)
           AND TTS.TRANSACTION_GROUP_ID(+) = ITS.TRANSACTION_GROUP_ID
           AND TTS.TRANSACTION_ID(+)      != ITS.TRANSACTION_ID
           AND ITS.SOB_ID                 = W_SOB_ID
           AND ITS.ORG_ID                 = W_ORG_ID
           AND ITS.INVENTORY_ITEM_ID      = NVL(W_INVENTORY_ITEM_ID, ITS.INVENTORY_ITEM_ID)
           AND TRUNC(ITS.TRANSACTION_DATE) BETWEEN NVL(W_RECEIPT_DATE_FR, TRUNC(ITS.TRANSACTION_DATE)) 
                                               AND NVL(W_RECEIPT_DATE_TO, TRUNC(ITS.TRANSACTION_DATE))
           AND ITS.WAREHOUSE_ID           = NVL(W_WAREHOUSE_ID, ITS.WAREHOUSE_ID)
           AND IIS.ITEM_SECTION_CODE      = NVL(W_ITEM_SECTION_CODE, IIS.ITEM_SECTION_CODE)
           AND IIM.ITEM_NET_CODE          = NVL(W_ITEM_NET_CODE, IIM.ITEM_NET_CODE)
           AND (  (W_RECEIPT_TYPE_CODE IS     NULL AND 1 = 1)
               OR (W_RECEIPT_TYPE_CODE IS NOT NULL AND ITS.SOURCE_HEADER_NO LIKE W_RECEIPT_TYPE_CODE || '%' ))
         ORDER BY ITEM_CODE
                , ITS.TRANSACTION_DATE
                , ITS.SOURCE_HEADER_NO
           
;   


 END FG_RECEIPT_BY_TYPE;



END INV_FG_RECEIPT_LIST_G; 
/
