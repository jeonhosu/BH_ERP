CREATE OR REPLACE PACKAGE WIP_OPERATION_ONHAND_G
AS
-- ���������Ȳ.
  PROCEDURE PRINT_OPERATION_ONHAND
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_PERIOD_NAME       IN VARCHAR2
            , W_WORKCENTER_CODE   IN VARCHAR2
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
            
END WIP_OPERATION_ONHAND_G;
/
CREATE OR REPLACE PACKAGE BODY WIP_OPERATION_ONHAND_G
AS

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
  
END WIP_OPERATION_ONHAND_G;
/