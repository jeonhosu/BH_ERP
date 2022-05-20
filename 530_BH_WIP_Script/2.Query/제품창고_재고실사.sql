-- 제품재고실사리스트 : PAGE SKIP => 창고코드, 소계 => 창고, LOC/ 검색 : 창고, 고객사
SELECT IWH.WAREHOUSE_CODE -- 창고코드
     , IWH.WAREHOUSE_NAME -- 창고명
     , IWL.LOCATION_CODE -- LOC코드
     , IWL.LOCATION_NAME -- LOC명
     , IIM.ITEM_CODE -- 제품코드
     , IIM.ITEM_DESCRIPTION -- 제품명
     , IIO.UOM_CODE -- 단위
     , SUM(IIO.ONHAND_QTY) AS ONHAND_QTY -- 재고량
  FROM INV_ITEM_ONHAND    IIO
     , INV_WAREHOUSE      IWH
     , INV_WH_LOCATION    IWL
     , INV_ITEM_MASTER    IIM
 WHERE IIO.WAREHOUSE_ID      = IWH.WAREHOUSE_ID
   AND IIO.LOCATION_ID       = IWL.WH_LOCATION_ID
   AND IIO.INVENTORY_ITEM_ID = IIM.INVENTORY_ITEM_ID
   AND IIO.SOB_ID            = 20
   AND IIO.ORG_ID            = 201
   AND ((IWH.FG_WIP_WAREHOUSE     = 'Y') OR -- 제품생산창고여부
        (IWH.FG_MAIN_WAREHOUSE    = 'Y') OR -- 제품주창고여부
        (IWH.FG_SURPLUS_WAREHOUSE = 'Y') OR -- 제품잉여창고여부
        (IWH.FG_SHIP_WAREHOUSE    = 'Y') OR -- 제품적송창고여부
        (IWH.FG_RETURN_WAREHOUSE  = 'Y') OR -- 제품반품창고여부
        (IWH.FG_SCRAP_WAREHOUSE   = 'Y'))   -- 제품불용창고여부
 GROUP BY IWH.WAREHOUSE_CODE
        , IWH.WAREHOUSE_NAME
        , IWL.LOCATION_CODE
        , IWL.LOCATION_NAME
        , IIM.ITEM_CODE
        , IIM.ITEM_DESCRIPTION
        , IIO.UOM_CODE
 HAVING SUM(IIO.ONHAND_QTY) <> 0
 ORDER BY IWH.WAREHOUSE_CODE
        , IWL.LOCATION_CODE
        , IIM.ITEM_CODE
        
        
