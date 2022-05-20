CREATE OR REPLACE VIEW INV_PHYSICAL_WIP_LIST_V AS
SELECT WOS.SOB_ID
     , WOS.ORG_ID
     , SSW.WORKCENTER_CODE
     , SSW.WORKCENTER_DESCRIPTION -- �۾���
     , SOT.OP_TYPE_DESCRIPTION    -- �߰���
     , WOS.OPERATION_SEQ_NO       -- ��������
     , SSO.OPERATION_DESCRIPTION  -- ����
     , IIC.DESCRIPTION            -- ǰ�񱸺�
     , SIR.BOM_ITEM_CODE          -- ǰ���ڵ�
     , SIR.BOM_ITEM_DESCRIPTION   -- ǰ���
     , SIS.ITEM_SIZE_X || 'X' || SIS.ITEM_SIZE_Y AS WORKING_SIZE
     , SSW.WORKCENTER_DESCRIPTION || ' ' || (SELECT CASE WHEN WORJ.RECEIPT_ID IS NULL THEN '����â��'
                                                        WHEN WORJ.INSPECT_REQ_FLAG = 'Y' THEN '���԰˻�'
                                                        ELSE NULL END
                                              FROM WIP_OUT_ORDER_JOB   WOOJ
                                                 , WIP_OUT_RECEIPT_JOB WORJ
                                             WHERE WOOJ.OUT_ORDER_ID = WORJ.OUT_ORDER_ID(+)
                                               AND WOOJ.OUT_ORDER_ID IN(SELECT MAX(WOOJ.OUT_ORDER_ID)
                                                                          FROM WIP_OUT_ORDER_JOB WOOJ
                                                                         WHERE WOOJ.JOB_ID = WOS.JOB_ID
                                                                           AND WOOJ.START_OPERATION_SEQ_NO = WOS.OPERATION_SEQ_NO)) AS STORE_LOCATION -- ����ó
     , WOS.JOB_NO                 -- LOT NO
     , WOS.ITEM_UOM_CODE -- ǰ�����(UOM)
     , ROUND(WOS.TOTAL_ONHAND_QTY) AS TOTAL_ONHAND_QTY -- ����(ǰ�����)
     , CASE WHEN WOS.QUEUE_QTY > 0 THEN WOS.QUEUE_MTX_UOM_CODE
            WHEN WOS.RUN_QTY   > 0 THEN WOS.RUN_MTX_UOM_CODE END AS MTX_UOM_CODE -- �۾�����
     , CASE WHEN WOS.QUEUE_QTY > 0 THEN WOS.QUEUE_FACTOR_VALUE1
            WHEN WOS.RUN_QTY   > 0 THEN WOS.RUN_FACTOR_VALUE1 END AS FACTOR_VALUE1 --�迭��1
     , ROUND(CASE WHEN WOS.QUEUE_QTY > 0 THEN WOS.QUEUE_MTX_UOM_QTY1
                  WHEN WOS.RUN_QTY   > 0 THEN WOS.RUN_MTX_UOM_QTY1 END) AS MTX_UOM_QTY1 -- ����1(�۾�����)
     , NULL AS ACTUAL_ONHAND_QTY1 -- �ǻ����1(�۾�����)
     , CASE WHEN WOS.QUEUE_QTY > 0 THEN WOS.QUEUE_FACTOR_VALUE2
                  WHEN WOS.RUN_QTY   > 0 THEN WOS.RUN_FACTOR_VALUE2 END AS FACTOR_VALUE2 -- �迭��2
     , ROUND(CASE WHEN WOS.QUEUE_QTY > 0 THEN WOS.QUEUE_MTX_UOM_QTY2
                  WHEN WOS.RUN_QTY   > 0 THEN WOS.RUN_MTX_UOM_QTY2 END) AS MTX_UOM_QTY2 -- ����2(�۾�����)
     , NULL AS ACTUAL_ONHAND_QTY2 -- �ǻ����2(�۾�����)
  FROM WIP_OPERATIONS          WOS
     , SDM_ITEM_REVISION       SIR
     , INV_ITEM_MASTER         IIM
     , INV_ITEM_CATEGORY       IIC
     , SDM_STANDARD_OPERATION  SSO
     , SDM_STANDARD_WORKCENTER SSW
     , SDM_OPERATION_TYPE      SOT
     , WIP_JOB_ENTITIES        WJE
     , SDM_ITEM_STRUCTURE      SIS
 WHERE WOS.BOM_ITEM_ID        = SIR.BOM_ITEM_ID
   AND SIR.INVENTORY_ITEM_ID  = IIM.INVENTORY_ITEM_ID
   AND IIM.ITEM_CATEGORY_CODE = IIC.ITEM_CATEGORY_CODE
   AND IIM.SOB_ID             = IIC.SOB_ID
   AND IIM.ORG_ID             = IIC.ORG_ID
   AND WOS.OPERATION_ID       = SSO.OPERATION_ID
   AND WOS.WORKCENTER_ID      = SSW.WORKCENTER_ID
   AND SSO.OPERATION_TYPE_ID  = SOT.OP_TYPE_ID
   AND WOS.JOB_ID             = WJE.JOB_ID
   AND SIR.BOM_ITEM_ID        = SIS.SG_BOM_ITEM_ID(+)
   AND WOS.ONHAND_FLAG        = 'Y'
/*ORDER BY SSW.WORKCENTER_CODE
       , CASE WHEN IIC.ITEM_CATEGORY_CODE = 'FG' THEN 0 ELSE 1 END
       , CASE WHEN SIS.STRUCT_LAYER_CODE = 'BA'  THEN 0
              WHEN SIS.STRUCT_LAYER_CODE = 'DBA' THEN 1
              WHEN SIS.STRUCT_LAYER_CODE = 'SBA' THEN 2
              WHEN SIS.STRUCT_LAYER_CODE = 'CU'  THEN 3
              WHEN SIS.STRUCT_LAYER_CODE = 'FR4' THEN 4
              WHEN SIS.STRUCT_LAYER_CODE = 'CL'  THEN 5
              WHEN SIS.STRUCT_LAYER_CODE = 'BS'  THEN 6
              WHEN SIS.STRUCT_LAYER_CODE = 'EPOXY' THEN 7
              WHEN SIS.STRUCT_LAYER_CODE = 'KT'    THEN 8
              WHEN SIS.STRUCT_LAYER_CODE = 'PET'   THEN 9
              WHEN SIS.STRUCT_LAYER_CODE = 'PI'    THEN 10
              WHEN SIS.STRUCT_LAYER_CODE = 'RE'    THEN 11
              WHEN SIS.STRUCT_LAYER_CODE = 'SH'    THEN 12
              WHEN SIS.STRUCT_LAYER_CODE = 'SUS'   THEN 13
              WHEN SIS.STRUCT_LAYER_CODE = 'PP'    THEN 14
              WHEN SIS.STRUCT_LAYER_CODE = 'CEM3'  THEN 15
              ELSE 16 END
       , SOT.OP_TYPE_CODE
       , SSO.OPERATION_CODE
       , SIR.BOM_ITEM_CODE
       , WOS.JOB_NO;*/
