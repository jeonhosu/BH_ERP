CREATE VIEW INV_PHYSICAL_FG_LIST_V
AS
-- ��ǰ����ǻ縮��Ʈ : PAGE SKIP => â���ڵ�, �Ұ� => â��, LOC/ �˻� : â��, ������
SELECT IIO.SOB_ID
     , IIO.ORG_ID
     , IWH.WAREHOUSE_CODE -- â���ڵ�
     , IWH.WAREHOUSE_NAME -- â����
     , IWL.LOCATION_CODE -- LOC�ڵ�
     , IWL.LOCATION_NAME -- LOC��
     , IIM.ITEM_CODE -- ��ǰ�ڵ�
     , IIM.ITEM_DESCRIPTION -- ��ǰ��
     , IIO.UOM_CODE -- ����
     , SUM(IIO.ONHAND_QTY) AS ONHAND_QTY -- �����
     , 0 AS ACTUAL_ONHAND  -- �Ǽ���.
  FROM INV_ITEM_ONHAND    IIO
     , INV_WAREHOUSE      IWH
     , INV_WH_LOCATION    IWL
     , INV_ITEM_MASTER    IIM
 WHERE IIO.WAREHOUSE_ID      = IWH.WAREHOUSE_ID
   AND IIO.LOCATION_ID       = IWL.WH_LOCATION_ID
   AND IIO.INVENTORY_ITEM_ID = IIM.INVENTORY_ITEM_ID
/*   AND IIO.SOB_ID            = 20
   AND IIO.ORG_ID            = 201*/
   AND ((IWH.FG_WIP_WAREHOUSE     = 'Y') OR -- ��ǰ����â������
        (IWH.FG_MAIN_WAREHOUSE    = 'Y') OR -- ��ǰ��â������
        (IWH.FG_SURPLUS_WAREHOUSE = 'Y') OR -- ��ǰ�׿�â������
        (IWH.FG_SHIP_WAREHOUSE    = 'Y') OR -- ��ǰ����â������
        (IWH.FG_RETURN_WAREHOUSE  = 'Y') OR -- ��ǰ��ǰâ������
        (IWH.FG_SCRAP_WAREHOUSE   = 'Y'))   -- ��ǰ�ҿ�â������
 GROUP BY IIO.SOB_ID
        , IIO.ORG_ID
        , IWH.WAREHOUSE_CODE
        , IWH.WAREHOUSE_NAME
        , IWL.LOCATION_CODE
        , IWL.LOCATION_NAME
        , IIM.ITEM_CODE
        , IIM.ITEM_DESCRIPTION
        , IIO.UOM_CODE
 HAVING SUM(IIO.ONHAND_QTY) <> 0
/* ORDER BY IWH.WAREHOUSE_CODE
        , IWL.LOCATION_CODE
        , IIM.ITEM_CODE*/