CREATE OR REPLACE PACKAGE INV_PHYSICAL_INVENTORY_LIST_G
AS
-- ���������Ȳ.
  PROCEDURE PRINT_OPERATION_ONHAND
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_PERIOD_NAME       IN VARCHAR2
            , W_WORKCENTER_CODE   IN VARCHAR2
            , W_SOB_ID            IN NUMBER
            , W_ORG_ID            IN NUMBER
            );

-- ��â�� ���ǻ縮��Ʈ.
  PROCEDURE MAJOR_WAREHOUSE_ONHAND
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_PERIOD_NAME       IN VARCHAR2
            , W_MAKER_CODE        IN VARCHAR2
            , W_SOB_ID            IN NUMBER
            , W_ORG_ID            IN NUMBER            
            );

-- ����â�� ���ǻ縮��Ʈ.
  PROCEDURE FIELD_WAREHOUSE_ONHAND
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_PERIOD_NAME       IN VARCHAR2
            , W_WAREHOUSE_CODE    IN VARCHAR2
            , W_SOB_ID            IN NUMBER
            , W_ORG_ID            IN NUMBER            
            );
            
-- �μ�����.
  PROCEDURE PRINTED_PERSON
            ( P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , O_PERSON_NAME       OUT VARCHAR2
            , O_PRINTED_DATE      OUT VARCHAR2
            );
                        
END INV_PHYSICAL_INVENTORY_LIST_G;
/
CREATE OR REPLACE PACKAGE BODY INV_PHYSICAL_INVENTORY_LIST_G
AS
/******************************************************************************/
/* PROJECT      : FPCB ERP
/* MODULE       : EAPP
/* PROGRAM NAME : INV_ACTUAL_ONHAND_LIST_G
/* DESCRIPTION  : ���ǻ���� ��Ű����.
/* REFERENCE BY :
/* PROGRAM HISTORY : �ű� ����
/*------------------------------------------------------------------------------
/*   DATE       IN CHARGE          DESCRIPTION
/*------------------------------------------------------------------------------
/* 20-JUN-2010  JEON HO SU          INITIALIZE
/******************************************************************************/
  PROCEDURE PRINT_OPERATION_ONHAND
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_PERIOD_NAME       IN VARCHAR2
            , W_WORKCENTER_CODE   IN VARCHAR2
            , W_SOB_ID            IN NUMBER
            , W_ORG_ID            IN NUMBER
            )
  AS
  BEGIN
    OPEN P_CURSOR FOR
      SELECT CASE
               WHEN GROUPING(WOO.OPERATION_DESCRIPTION) = 1 THEN TO_CHAR(NULL)
               WHEN GROUPING(WOO.BOM_ITEM_CODE) = 1 THEN TO_CHAR(NULL)
               ELSE WOO.WORKCENTER_DESCRIPTION
             END AS WORKCENTER_DESCRIPTION
           , WOO.OP_TYPE_DESCRIPTION
           , CASE
               WHEN GROUPING(WOO.OPERATION_DESCRIPTION) = 1 THEN TO_CHAR(NULL)
               WHEN GROUPING(WOO.BOM_ITEM_CODE) = 1 THEN TO_CHAR(NULL)
               ELSE TO_CHAR(WOO.OPERATION_SEQ_NO)
             END AS OPERATION_SEQ_NO
           , CASE
               WHEN GROUPING(WOO.OPERATION_DESCRIPTION) = 1 THEN WOO.WORKCENTER_DESCRIPTION || ' ' || EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_10062', NULL)
               WHEN GROUPING(WOO.BOM_ITEM_CODE) = 1 THEN WOO.OPERATION_DESCRIPTION || ' '|| EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_10063', NULL)
               ELSE WOO.OPERATION_DESCRIPTION
             END AS OPERATION_DESCRIPTION
           , WOO.DESCRIPTION
           , WOO.BOM_ITEM_CODE AS ITEM_CODE
           , WOO.BOM_ITEM_DESCRIPTION AS ITEM_DESC
           , WOO.WORKING_SIZE
           , WOO.STORE_LOCATION
           , WOO.JOB_NO
           , WOO.ITEM_UOM_CODE
           , SUM(WOO.TOTAL_ONHAND_QTY) AS TOTAL_ONHAND_QTY
           , WOO.MTX_UOM_CODE
           , SUM(WOO.FACTOR_VALUE1) AS FACTOR_VALUE1
           , SUM(WOO.MTX_UOM_QTY1) AS MTX_UOM_QTY1
           , SUM(WOO.ACTUAL_ONHAND_QTY1) AS ACTUAL_ONHAND_QTY1
           , SUM(WOO.FACTOR_VALUE2) AS FACTOR_VALUE2
           , SUM(WOO.MTX_UOM_QTY2) AS MTX_UOM_QTY2
           , SUM(WOO.ACTUAL_ONHAND_QTY2) AS ACTUAL_ONHAND_QTY2
           , WOO.WORKCENTER_CODE
           , CASE
               WHEN GROUPING(WOO.WORKCENTER_DESCRIPTION) = 1 THEN 'T'
               WHEN GROUPING(WOO.OPERATION_DESCRIPTION) = 1 THEN 'W'
               WHEN GROUPING(WOO.BOM_ITEM_CODE) = 1 THEN 'O'
               ELSE 'L'
             END AS LINE_TYPE
        FROM WIP_OPERATION_ONHAND_V1 WOO
      WHERE WOO.WORKCENTER_CODE         = NVL(W_WORKCENTER_CODE, WOO.WORKCENTER_CODE)
        AND WOO.SOB_ID                  = W_SOB_ID
        AND WOO.ORG_ID                  = W_ORG_ID
--        AND WOO.WORKCENTER_CODE         IN ('WF0006', 'WF0010', 'WF0017', 'WF0024')
      GROUP BY ROLLUP((WOO.WORKCENTER_CODE
           , WOO.WORKCENTER_DESCRIPTION)
           , (WOO.OPERATION_DESCRIPTION)
           , (WOO.OPERATION_SEQ_NO
           , WOO.OP_TYPE_DESCRIPTION
           , WOO.DESCRIPTION
           , WOO.BOM_ITEM_CODE
           , WOO.BOM_ITEM_DESCRIPTION
           , WOO.WORKING_SIZE
           , WOO.STORE_LOCATION
           , WOO.JOB_NO
           , WOO.ITEM_UOM_CODE
           , WOO.MTX_UOM_CODE))
      HAVING GROUPING(WOO.WORKCENTER_DESCRIPTION) <> 1
      ;
  END PRINT_OPERATION_ONHAND;

-- ��â�� ���ǻ縮��Ʈ.
  PROCEDURE MAJOR_WAREHOUSE_ONHAND
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_PERIOD_NAME       IN VARCHAR2
            , W_MAKER_CODE        IN VARCHAR2
            , W_SOB_ID            IN NUMBER
            , W_ORG_ID            IN NUMBER            
            )
  AS
  BEGIN
    OPEN P_CURSOR FOR
      SELECT MWO.WAREHOUSE_NAME -- â���
           , MWO.LOCATION_CODE -- LOC�ڵ�
           , MWO.LOCATION_NAME -- LOC��
           , MWO.CATEGORY_DESC -- ����
           , MWO.SUMMARY_GROUP -- �ߺз�
           , MWO.DESCRIPTION -- �Һз�
           , MWO.MAKER_CODE -- �������ڵ�
           , CASE
               WHEN GROUPING (MWO.WAREHOUSE_CODE) = 1 THEN '�Ѱ�'
               WHEN GROUPING (MWO.ITEM_CODE) = 1 THEN MWO.MAKER_DESCRIPTION || ' '|| EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_10063', NULL)
               ELSE MWO.MAKER_DESCRIPTION 
             END AS MAKER_DESCRIPTION  -- �������
           , MWO.ITEM_CODE -- ǰ���ڵ�
           , MWO.ITEM_DESCRIPTION AS ITEM_DESCRIPTION-- ǰ��� 
           , MWO.UOM_CODE -- ����
           , SUM(MWO.ONHAND_QTY) AS ONHAND_QTY --���
           , NULL AS ACTUAL_QTY -- �ǻ緮
           , MWO.WAREHOUSE_CODE -- â���ڵ�
           , CASE
               WHEN GROUPING (MWO.WAREHOUSE_CODE) = 1 THEN 'T'
               WHEN GROUPING (MWO.ITEM_CODE) = 1 THEN 'S'
               ELSE 'L' 
             END AS LINE_TYPE
        FROM INV_MAJOR_WAREHOUSE_ONHAND_V MWO
      WHERE MWO.SOB_ID                  = W_SOB_ID
        AND MWO.ORG_ID                  = W_ORG_ID
        AND MWO.MAKER_CODE              = NVL(W_MAKER_CODE, MWO.MAKER_CODE)
      GROUP BY ROLLUP((MWO.WAREHOUSE_CODE
                     , MWO.WAREHOUSE_NAME)
                     , (MWO.MAKER_CODE
                     , MWO.MAKER_DESCRIPTION)
                     , (MWO.LOCATION_CODE
                     , MWO.LOCATION_NAME
                     , MWO.CATEGORY_DESC
                     , MWO.SUMMARY_GROUP
                     , MWO.DESCRIPTION
                     , MWO.ITEM_CODE
                     , MWO.ITEM_DESCRIPTION
                     , MWO.UOM_CODE))
      HAVING GROUPING(MWO.WAREHOUSE_CODE) <> 1
      ;
  END MAJOR_WAREHOUSE_ONHAND;
  
-- ����â�� ���ǻ縮��Ʈ.
  PROCEDURE FIELD_WAREHOUSE_ONHAND
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_PERIOD_NAME       IN VARCHAR2
            , W_WAREHOUSE_CODE    IN VARCHAR2
            , W_SOB_ID            IN NUMBER
            , W_ORG_ID            IN NUMBER            
            )
  AS
  BEGIN
    -- ������ ����â�� ���ǻ� : PAGE SKIP => â���ڵ�
    OPEN P_CURSOR FOR             
      SELECT FWO.WAREHOUSE_NAME AS WAREHOUSE_NAME  -- â���
           , FWO.CATEGORY_DESC -- ����
           , FWO.SUMMARY_GROUP --�ߺз�
           , FWO.DESCRIPTION -- �Һз�
           , FWO.ITEM_CODE -- ǰ���ڵ�
           , CASE
               WHEN GROUPING (FWO.WAREHOUSE_CODE) = 1 THEN '�Ѱ�'
               WHEN GROUPING (FWO.ITEM_CODE) = 1 THEN FWO.WAREHOUSE_NAME || ' '|| EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_10063', NULL)
               ELSE FWO.ITEM_DESCRIPTION 
             END AS ITEM_DESCRIPTION-- ǰ���
           , FWO.MAKER_CODE -- �������ڵ�
           , FWO.MAKER_DESCRIPTION -- �������
           , FWO.UOM_CODE -- ����
           , SUM(FWO.PRIMARY_QTY) AS PRIMARY_QTY -- �������
           , NULL AS ACTUAL_PRIMARY_QTY -- �ǻ緮(����)
           , SUM(FWO.OVER_STOCK_QTY) AS OVER_STOCK_QTY -- �������
           , NULL AS ACTUAL_OVER_QTY -- �ǻ緮(�����)
           , SUM(FWO.ONHAND_QTY) AS ONHAND_QTY  -- ���
           , NULL AS ACTUAL_QTY -- �ǻ緮
           , FWO.WAREHOUSE_CODE -- â���ڵ�
        FROM INV_FIELD_WAREHOUSE_ONHAND_V FWO
      WHERE FWO.SOB_ID                  = W_SOB_ID
        AND FWO.ORG_ID                  = W_ORG_ID
        AND FWO.WAREHOUSE_CODE          = NVL(W_WAREHOUSE_CODE, FWO.WAREHOUSE_CODE)
      GROUP BY ROLLUP((FWO.WAREHOUSE_CODE
           , FWO.WAREHOUSE_NAME)
           , (FWO.ENTRY_CODE
           , FWO.MAKER_CODE
           , FWO.ITEM_CODE
           , FWO.DESCRIPTION
           , FWO.CATEGORY_DESC
           , FWO.SUMMARY_GROUP
           , FWO.ITEM_DESCRIPTION
           , FWO.MAKER_DESCRIPTION
           , FWO.UOM_CODE))
      HAVING GROUPING (FWO.WAREHOUSE_CODE) <> 1
      ;
  END FIELD_WAREHOUSE_ONHAND;
  
-- �μ�����.
  PROCEDURE PRINTED_PERSON
            ( P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , O_PERSON_NAME       OUT VARCHAR2
            , O_PRINTED_DATE      OUT VARCHAR2
            )
  AS
    V_SYSDATE       DATE;
  BEGIN
    O_PERSON_NAME := HRM_PERSON_MASTER_G.NAME_F(P_PERSON_ID);
    V_SYSDATE := GET_LOCAL_DATE(P_SOB_ID);
    O_PRINTED_DATE := TO_CHAR(V_SYSDATE, 'YYYY') || '��  ' || TO_CHAR(V_SYSDATE, 'MM') || '��  ' || TO_CHAR(V_SYSDATE, 'DD') || '�� ';
  END PRINTED_PERSON;
  
END INV_PHYSICAL_INVENTORY_LIST_G;
/
