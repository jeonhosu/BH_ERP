CREATE OR REPLACE PACKAGE INV_PHYSICAL_INVENTORY_LIST_G
AS
-- ���ǰ�ǻ縮��Ʈ.
  PROCEDURE PRINT_WIP_LIST
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_PERIOD_NAME       IN VARCHAR2
            , W_WORKCENTER_CODE   IN VARCHAR2
            , W_SOB_ID            IN NUMBER
            , W_ORG_ID            IN NUMBER
            );

-- ����ǰ���ǻ縮��Ʈ.
  PROCEDURE PRINT_SFG_LIST
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_PERIOD_NAME       IN VARCHAR2
            , W_WAREHOUSE_CODE    IN VARCHAR2
            , W_SOB_ID            IN NUMBER
            , W_ORG_ID            IN NUMBER            
            );
            
-- ��ǰ���ǻ縮��Ʈ.
  PROCEDURE PRINT_FG_LIST
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_PERIOD_NAME       IN VARCHAR2
            , W_WAREHOUSE_CODE    IN VARCHAR2
            , W_SOB_ID            IN NUMBER
            , W_ORG_ID            IN NUMBER            
            );
            
-- �������ǻ縮��Ʈ.
  PROCEDURE PRINT_MAT_LIST
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_PERIOD_NAME       IN VARCHAR2
            , W_MAKER_CODE        IN VARCHAR2
            , W_SOB_ID            IN NUMBER
            , W_ORG_ID            IN NUMBER            
            );

-- �����������ǻ縮��Ʈ.
  PROCEDURE PRINT_WC_MAT_LIST
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
-- ���ǰ�ǻ縮��Ʈ.
  PROCEDURE PRINT_WIP_LIST
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
           , ROUND(SUM(WOO.TOTAL_ONHAND_QTY), 0) AS TOTAL_ONHAND_QTY
           , WOO.MTX_UOM_CODE
           , ROUND(SUM(WOO.FACTOR_VALUE1), 0) AS FACTOR_VALUE1
           , ROUND(SUM(WOO.MTX_UOM_QTY1), 0) AS MTX_UOM_QTY1
           , ROUND(SUM(WOO.ACTUAL_ONHAND_QTY1), 0) AS ACTUAL_ONHAND_QTY1
           , ROUND(SUM(WOO.FACTOR_VALUE2), 0) AS FACTOR_VALUE2
           , ROUND(SUM(WOO.MTX_UOM_QTY2), 0) AS MTX_UOM_QTY2
           , ROUND(SUM(WOO.ACTUAL_ONHAND_QTY2), 0) AS ACTUAL_ONHAND_QTY2
           , WOO.WORKCENTER_CODE
           , CASE
               WHEN GROUPING(WOO.WORKCENTER_DESCRIPTION) = 1 THEN 'T'
               WHEN GROUPING(WOO.OPERATION_DESCRIPTION) = 1 THEN 'W'
               WHEN GROUPING(WOO.BOM_ITEM_CODE) = 1 THEN 'O'
               ELSE 'L'
             END AS LINE_TYPE
        FROM INV_PHYSICAL_WIP_LIST_V WOO
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
  END PRINT_WIP_LIST;

-- ����ǰ���ǻ縮��Ʈ.
  PROCEDURE PRINT_SFG_LIST
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_PERIOD_NAME       IN VARCHAR2
            , W_WAREHOUSE_CODE    IN VARCHAR2
            , W_SOB_ID            IN NUMBER
            , W_ORG_ID            IN NUMBER            
            )
  AS
  BEGIN
    -- ����ǰ���ǻ縮��Ʈ : PAGE SKIP => â��, LOC �Ұ�
    OPEN P_CURSOR FOR      
      SELECT PSL.WAREHOUSE_NAME -- â���
           , PSL.LOCATION_CODE -- LOC�ڵ�
           , CASE
               WHEN GROUPING(PSL.LOCATION_CODE) = 1 THEN PSL.WAREHOUSE_NAME || ' ' || EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_10062', NULL)
               WHEN GROUPING(PSL.ITEM_CODE) = 1 THEN PSL.LOCATION_NAME || ' '|| EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_10063', NULL)
               ELSE PSL.LOCATION_NAME
             END AS LOCATION_NAME --LOC��
           , PSL.ITEM_CODE -- ǰ���ڵ�
           , PSL.ITEM_DESCRIPTION -- ǰ���
           , PSL.UOM_CODE -- ����
           , ROUND(SUM(PSL.ONHAND_QTY), 0) AS ONHAND_QTY -- ���
           , SUM(PSL.ACTUAL_ONHAND) AS ACTUAL_ONHAND  -- �Ǽ���.
           , PSL.WAREHOUSE_CODE -- â���ڵ�
        FROM INV_PHYSICAL_SFG_LIST_V PSL
       WHERE PSL.SOB_ID            = W_SOB_ID
         AND PSL.ORG_ID            = W_ORG_ID
         AND PSL.WAREHOUSE_CODE    = NVL(W_WAREHOUSE_CODE, PSL.WAREHOUSE_CODE)
      GROUP BY ROLLUP((PSL.WAREHOUSE_CODE -- â���ڵ�
           , PSL.WAREHOUSE_NAME)
           , (PSL.LOCATION_CODE
           , PSL.LOCATION_NAME)
           , (PSL.ITEM_CODE -- ǰ���ڵ�
           , PSL.UOM_CODE
           , PSL.ITEM_DESCRIPTION))
      HAVING GROUPING(PSL.WAREHOUSE_CODE) <> 1
      ;   

  END PRINT_SFG_LIST;

-- ��ǰ���ǻ縮��Ʈ.
  PROCEDURE PRINT_FG_LIST
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_PERIOD_NAME       IN VARCHAR2
            , W_WAREHOUSE_CODE    IN VARCHAR2
            , W_SOB_ID            IN NUMBER
            , W_ORG_ID            IN NUMBER            
            )
  AS
  BEGIN
    -- ��ǰ���ǻ縮��Ʈ : PAGE SKIP => â���ڵ�, �Ұ� => â��, LOC/ �˻� : â��, ����
    OPEN P_CURSOR FOR      
      SELECT PFL.WAREHOUSE_NAME -- â���
           , PFL.LOCATION_CODE -- LOC�ڵ�
           , CASE
               WHEN GROUPING(PFL.LOCATION_CODE) = 1 THEN PFL.WAREHOUSE_NAME || ' ' || EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_10062', NULL)
               WHEN GROUPING(PFL.ITEM_CODE) = 1 THEN PFL.LOCATION_NAME || ' '|| EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_10063', NULL)
               ELSE PFL.LOCATION_NAME
             END AS LOCATION_NAME --LOC��
           , PFL.ITEM_CODE -- ǰ���ڵ�
           , PFL.ITEM_DESCRIPTION -- ǰ���
           , PFL.UOM_CODE -- ����
           , ROUND(SUM(PFL.ONHAND_QTY), 0) AS ONHAND_QTY -- ���
           , SUM(PFL.ACTUAL_ONHAND)AS ACTUAL_ONHAND  -- �Ǽ���.
           , PFL.WAREHOUSE_CODE -- â���ڵ�
        FROM INV_PHYSICAL_FG_LIST_V PFL
       WHERE PFL.SOB_ID            = W_SOB_ID
         AND PFL.ORG_ID            = W_ORG_ID
         AND PFL.WAREHOUSE_CODE    = NVL(W_WAREHOUSE_CODE, PFL.WAREHOUSE_CODE)
      GROUP BY ROLLUP((PFL.WAREHOUSE_CODE -- â���ڵ�
           , PFL.WAREHOUSE_NAME)
           , (PFL.LOCATION_CODE
           , PFL.LOCATION_NAME)
           , (PFL.ITEM_CODE -- ǰ���ڵ�
           , PFL.ITEM_DESCRIPTION -- ǰ���
           , PFL.UOM_CODE))
      HAVING GROUPING(PFL.WAREHOUSE_CODE) <> 1
      ;
  END PRINT_FG_LIST;
  
-- �������ǻ縮��Ʈ.
  PROCEDURE PRINT_MAT_LIST
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
           , CASE
               WHEN GROUPING (MWO.WAREHOUSE_CODE) = 1 THEN TO_CHAR(NULL)
               WHEN GROUPING (MWO.ITEM_CODE) = 1 THEN TO_CHAR(NULL)
               ELSE MWO.MAKER_CODE  
             END AS MAKER_CODE -- �������ڵ�
           , CASE
               WHEN GROUPING (MWO.WAREHOUSE_CODE) = 1 THEN TO_CHAR(NULL)
               WHEN GROUPING (MWO.ITEM_CODE) = 1 THEN TO_CHAR(NULL)
               ELSE MWO.MAKER_DESCRIPTION
             END AS MAKER_DESCRIPTION  -- �������
           , MWO.ITEM_CODE -- ǰ���ڵ�
           , CASE
               WHEN GROUPING (MWO.WAREHOUSE_CODE) = 1 THEN '�Ѱ�'
               WHEN GROUPING (MWO.ITEM_CODE) = 1 THEN MWO.MAKER_DESCRIPTION || ' '|| EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_10063', NULL)
               ELSE MWO.ITEM_DESCRIPTION 
             END AS ITEM_DESCRIPTION-- ǰ��� 
           , MWO.UOM_CODE -- ����
           , ROUND(SUM(MWO.ONHAND_QTY), 2) AS ONHAND_QTY --���
           , 0 AS ACTUAL_QTY -- �ǻ緮
           , MWO.WAREHOUSE_CODE -- â���ڵ�
           , CASE
               WHEN GROUPING (MWO.WAREHOUSE_CODE) = 1 THEN 'T'
               WHEN GROUPING (MWO.ITEM_CODE) = 1 THEN 'S'
               ELSE 'L' 
             END AS LINE_TYPE
        FROM INV_PHYSICAL_MAT_LIST_V MWO
      WHERE MWO.SOB_ID                  = W_SOB_ID
        AND MWO.ORG_ID                  = W_ORG_ID
        AND MWO.MAKER_CODE              = NVL(W_MAKER_CODE, MWO.MAKER_CODE)
        --AND MWO.MAKER_CODE              IN ('B003', 'B043', 'B044')
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
  END PRINT_MAT_LIST;
  
-- �����������ǻ縮��Ʈ.
  PROCEDURE PRINT_WC_MAT_LIST
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
           , ROUND(SUM(FWO.PRIMARY_QTY), 2) AS PRIMARY_QTY -- �������
           , 0 AS ACTUAL_PRIMARY_QTY -- �ǻ緮(����)
           , ROUND(SUM(FWO.OVER_STOCK_QTY), 2) AS OVER_STOCK_QTY -- �������
           , 0 AS ACTUAL_OVER_QTY -- �ǻ緮(�����)
           , ROUND(SUM(FWO.ONHAND_QTY), 2) AS ONHAND_QTY  -- ���
           , 0 AS ACTUAL_QTY -- �ǻ緮
           , FWO.WAREHOUSE_CODE -- â���ڵ�
        FROM INV_PHYSICAL_WC_MAT_LIST_V FWO
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
  END PRINT_WC_MAT_LIST;
  
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
