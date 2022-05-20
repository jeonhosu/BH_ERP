using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using Syncfusion.Windows.Forms;
using Syncfusion.Windows.Forms.Tools;
using Syncfusion.Windows.Forms.Grid;
using InfoSummit.Win.ControlAdv;
using ISCommonUtil;

namespace INVF0101
{
    public partial class INVF0101 : Office2007Form
    {
        #region ----- Variables -----

        ISFunction.ISConvert iString = new ISFunction.ISConvert();
        ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();
        ISCommonUtil.ISFunction.ISConvert iConvert = new ISFunction.ISConvert();
          
        #endregion;

        #region ----- Constructor -----

        public INVF0101(Form pMainForm, ISAppInterface pAppInterface)
        {
            InitializeComponent();
            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface; 
        }

        #endregion;

        #region ----- Private Methods ----
        private void Header_Setting()
        {
            iedRECEIPT_PERSON_ID.EditValue = isAppInterfaceAdv1.PERSON_ID;
            iedRECEIPT_PERSON_NAME.EditValue = isAppInterfaceAdv1.DISPLAY_NAME;

            iedRECEIPT_DATE.EditValue = DateTime.Today;
        }
        
        private void Line_Add(ISGridAdvEx pGrid1, ISGridAdvEx pGrid2, ISGridAdvEx pGrid3, object vRow, object vPo_Qty)
        {
            int    vIndexLastRow = Convert.ToInt32(vRow);
            decimal vSum_Po_Qty = Convert.ToDecimal(vPo_Qty);
            int    vRow_Cnt      = pGrid1.RowCount; 

            object vObject       = "";

            pGrid1.CurrentCellMoveTo(pGrid1.RowCount - 1, 0);

            IDA_LINE.AddUnder();

            pGrid1.SetCellValue(vRow_Cnt, pGrid1.GetColumnToIndex("LINE_NO"), 1);

            vObject = pGrid3.GetCellValue(vIndexLastRow,pGrid3.GetColumnToIndex("INVENTORY_ITEM_ID")); 
            pGrid1.SetCellValue(vRow_Cnt,pGrid1.GetColumnToIndex("INVENTORY_ITEM_ID"), vObject);

            vObject = pGrid3.GetCellValue(vIndexLastRow, pGrid3.GetColumnToIndex("ITEM_CODE"));
            pGrid1.SetCellValue(vRow_Cnt, pGrid1.GetColumnToIndex("ITEM_CODE"), vObject);

            vObject = pGrid3.GetCellValue(vIndexLastRow, pGrid3.GetColumnToIndex("ITEM_DESCRIPTION")); 
            pGrid1.SetCellValue(vRow_Cnt, pGrid1.GetColumnToIndex("ITEM_DESCRIPTION"), vObject);

            vObject = pGrid3.GetCellValue(vIndexLastRow, pGrid3.GetColumnToIndex("ITEM_SPECIFICATION")); 
            pGrid1.SetCellValue(vRow_Cnt, pGrid1.GetColumnToIndex("ITEM_SPECIFICATION"),vObject);

            vObject = pGrid3.GetCellValue(vIndexLastRow, pGrid3.GetColumnToIndex("ITEM_UOM_CODE")); 
            pGrid1.SetCellValue(vRow_Cnt, pGrid1.GetColumnToIndex("ITEM_UOM_CODE"), vObject);

            //vObject = pGrid3.GetCellValue(vIndexLastRow, pGrid3.GetColumnToIndex("REMAIN_QTY"));
            //pGrid1.SetCellValue(vRow_Cnt, pGrid1.GetColumnToIndex("RECEIPT_QTY"), vObject);

            pGrid1.SetCellValue(vRow_Cnt, pGrid1.GetColumnToIndex("RECEIPT_QTY"), vSum_Po_Qty);

            //vObject = pGrid3.GetCellValue(vIndexLastRow, pGrid3.GetColumnToIndex("CURRENCY_CODE"));
            pGrid1.SetCellValue(vRow_Cnt, pGrid1.GetColumnToIndex("CURRENCY_CODE"), iedCURRENCY_CODE.EditValue);

            vObject = pGrid3.GetCellValue(vIndexLastRow, pGrid3.GetColumnToIndex("ITEM_PRICE"));
            pGrid1.SetCellValue(vRow_Cnt, pGrid1.GetColumnToIndex("ITEM_PRICE"), vObject);

            vObject = Convert.ToDecimal(pGrid3.GetCellValue(vIndexLastRow, pGrid3.GetColumnToIndex("ITEM_PRICE"))) * vSum_Po_Qty;
            pGrid1.SetCellValue(vRow_Cnt, pGrid1.GetColumnToIndex("ITEM_AMOUNT"), vObject);                                   // �ݾ�

            vObject = Convert.ToDecimal(pGrid1.GetCellValue(vRow_Cnt, pGrid1.GetColumnToIndex("ITEM_AMOUNT"))) * iedEXCHANGE_RATE.NumberValue;
            pGrid1.SetCellValue(vRow_Cnt, pGrid1.GetColumnToIndex("ITEM_AMOUNT_KRW"), vObject);                               // �ݾ�


            vObject = pGrid3.GetCellValue(vIndexLastRow, pGrid3.GetColumnToIndex("CATEGORY_DESCRIPTION"));
            pGrid1.SetCellValue(vRow_Cnt, pGrid1.GetColumnToIndex("CATEGORY_DESCRIPTION"), vObject);

            vObject = pGrid3.GetCellValue(vIndexLastRow, pGrid3.GetColumnToIndex("SECTION_DESCRIPTION"));
            pGrid1.SetCellValue(vRow_Cnt, pGrid1.GetColumnToIndex("SECTION_DESCRIPTION"), vObject);

            vObject = pGrid3.GetCellValue(vIndexLastRow, pGrid3.GetColumnToIndex("SUPPLIER_SHORT_NAME"));
            pGrid1.SetCellValue(vRow_Cnt, pGrid1.GetColumnToIndex("SUPPLIER_SHORT_NAME"), vObject);

            vObject = pGrid3.GetCellValue(vIndexLastRow, pGrid3.GetColumnToIndex("STORE_INSPECTION_FLAG"));
            pGrid1.SetCellValue(vRow_Cnt, pGrid1.GetColumnToIndex("ITEM_INSPECTION_FLAG"), vObject);
        }
        private void Detail_Add(ISGridAdvEx pGrid1, ISGridAdvEx pGrid2, ISGridAdvEx pGrid3, object vRow_Line, object vRow, object vRow_Detail)
        {
            int vRow_Cnt = Convert.ToInt32(vRow_Line);
            int vRow_Cnt2 = Convert.ToInt32(vRow_Detail);
            int i = Convert.ToInt32(vRow);

            object vObject = "";

            pGrid1.CurrentCellMoveTo(vRow_Cnt, 0);

            pGrid2.CurrentCellMoveTo(pGrid2.RowCount - 1, 0);

            IDA_DETAIL.AddUnder();

            if (iedPO_TYPE_TAG.EditText == "LC")
            {
                vObject = pGrid3.GetCellValue(i, pGrid3.GetColumnToIndex("CUSTOM_HEADER_ID"));
                pGrid2.SetCellValue(vRow_Cnt2, pGrid2.GetColumnToIndex("HEADER_ID"), vObject);

                //vObject = pGrid3.GetCellValue(i, pGrid3.GetColumnToIndex("CUSTOM_LINE_ID"));

                vObject = pGrid3.GetCellValue(i, pGrid3.GetColumnToIndex("LINE_ID"));
                pGrid2.SetCellValue(vRow_Cnt2, pGrid2.GetColumnToIndex("LINE_ID"), vObject);

                //vObject = pGrid3.GetCellValue(i, pGrid3.GetColumnToIndex("CUSTOM_DETAIL_ID"));

                vObject = pGrid3.GetCellValue(i, pGrid3.GetColumnToIndex("DETAIL_ID"));
                pGrid2.SetCellValue(vRow_Cnt2, pGrid2.GetColumnToIndex("DETAIL_ID"), vObject);

                vObject = pGrid3.GetCellValue(i, pGrid3.GetColumnToIndex("CUSTOM_HEADER_ID"));
                pGrid2.SetCellValue(vRow_Cnt2, pGrid2.GetColumnToIndex("CUSTOM_HEADER_ID"), vObject);

                vObject = pGrid3.GetCellValue(i, pGrid3.GetColumnToIndex("CUSTOM_LINE_ID"));
                pGrid2.SetCellValue(vRow_Cnt2, pGrid2.GetColumnToIndex("CUSTOM_LINE_ID"), vObject);

                vObject = pGrid3.GetCellValue(i, pGrid3.GetColumnToIndex("CUSTOM_DETAIL_ID"));
                pGrid2.SetCellValue(vRow_Cnt2, pGrid2.GetColumnToIndex("CUSTOM_DETAIL_ID"), vObject);

                vObject = pGrid3.GetCellValue(i, pGrid3.GetColumnToIndex("BANKING_DETAIL_ID"));
                pGrid2.SetCellValue(vRow_Cnt2, pGrid2.GetColumnToIndex("BANKING_DETAIL_ID"), vObject);

                vObject = pGrid3.GetCellValue(i, pGrid3.GetColumnToIndex("BL_DETAIL_ID"));
                pGrid2.SetCellValue(vRow_Cnt2, pGrid2.GetColumnToIndex("BL_DETAIL_ID"), vObject);

                vObject = pGrid3.GetCellValue(i, pGrid3.GetColumnToIndex("CUSTOM_LINE_NO"));
                pGrid2.SetCellValue(vRow_Cnt2, pGrid2.GetColumnToIndex("CUSTOM_LINE_NO"), vObject);
            }
            else
            {
                vObject = pGrid3.GetCellValue(i, pGrid3.GetColumnToIndex("PO_HEADER_ID"));
                pGrid2.SetCellValue(vRow_Cnt2, pGrid2.GetColumnToIndex("HEADER_ID"), vObject);

                vObject = pGrid3.GetCellValue(i, pGrid3.GetColumnToIndex("PO_LINE_ID"));
                pGrid2.SetCellValue(vRow_Cnt2, pGrid2.GetColumnToIndex("LINE_ID"), vObject);

                vObject = pGrid3.GetCellValue(i, pGrid3.GetColumnToIndex("DETAIL_ID"));
                pGrid2.SetCellValue(vRow_Cnt2, pGrid2.GetColumnToIndex("DETAIL_ID"), vObject);

            }

            vObject = pGrid3.GetCellValue(i, pGrid3.GetColumnToIndex("PO_NO"));
            pGrid2.SetCellValue(vRow_Cnt2, pGrid2.GetColumnToIndex("PO_NO"), vObject);

            vObject = pGrid3.GetCellValue(i, pGrid3.GetColumnToIndex("PO_LINE_NO"));
            pGrid2.SetCellValue(vRow_Cnt2, pGrid2.GetColumnToIndex("PO_LINE_NO"), vObject);

            vObject = pGrid3.GetCellValue(i, pGrid3.GetColumnToIndex("PO_HEADER_ID"));
            pGrid2.SetCellValue(vRow_Cnt2, pGrid2.GetColumnToIndex("PO_HEADER_ID"), vObject);

            vObject = pGrid3.GetCellValue(i, pGrid3.GetColumnToIndex("PO_LINE_ID"));
            pGrid2.SetCellValue(vRow_Cnt2, pGrid2.GetColumnToIndex("PO_LINE_ID"), vObject);

            vObject = pGrid3.GetCellValue(i, pGrid3.GetColumnToIndex("INVENTORY_ITEM_ID"));
            pGrid2.SetCellValue(vRow_Cnt2, pGrid2.GetColumnToIndex("INVENTORY_ITEM_ID"), vObject);

            vObject = pGrid3.GetCellValue(i, pGrid3.GetColumnToIndex("ITEM_UOM_CODE"));
            pGrid2.SetCellValue(vRow_Cnt2, pGrid2.GetColumnToIndex("ITEM_UOM_CODE"), vObject);

            vObject = pGrid3.GetCellValue(i, pGrid3.GetColumnToIndex("ITEM_CODE"));
            pGrid2.SetCellValue(vRow_Cnt2, pGrid2.GetColumnToIndex("ITEM_CODE"), vObject);

            vObject = pGrid3.GetCellValue(i, pGrid3.GetColumnToIndex("REMAIN_QTY"));
            pGrid2.SetCellValue(vRow_Cnt2, pGrid2.GetColumnToIndex("REMAIN_QTY"), vObject);

            vObject = pGrid3.GetCellValue(i, pGrid3.GetColumnToIndex("REMAIN_QTY"));
            pGrid2.SetCellValue(vRow_Cnt2, pGrid2.GetColumnToIndex("RECEIPT_QTY"), vObject);

            vObject = pGrid3.GetCellValue(i, pGrid3.GetColumnToIndex("ITEM_DESCRIPTION"));
            pGrid2.SetCellValue(vRow_Cnt2, pGrid2.GetColumnToIndex("ITEM_DESCRIPTION"), vObject);

            vObject = pGrid3.GetCellValue(i, pGrid3.GetColumnToIndex("SUPPLIER_SHORT_NAME"));
            pGrid2.SetCellValue(vRow_Cnt2, pGrid2.GetColumnToIndex("SUPPLIER_SHORT_NAME"), vObject);
        }
        //======================================================================================================
        // ���ο��� �����Ͽ� ���ų� �������� ���ַ��� 0 �̸� ���� �ϴ� ��ƾ
        //======================================================================================================
        private void Group_Del(ISGridAdvEx pGrid1, ISGridAdvEx pGrid2)
        {
            bool vCheck  = false;

            decimal vPO_Qty = 0;
            decimal vPO_Qty_Sum = 0;
            
            int  i = 0;
            int  j = 0;

            int    vIndexCurrent = IDA_LINE.OraSelectData.Rows.IndexOf(IDA_LINE.CurrentRow);
            long   vLine_Id1 = Convert.ToInt32(pGrid1.GetCellValue("INVENTORY_ITEM_ID"));
            string vLine_UOM1 = Convert.ToString(pGrid1.GetCellValue("ITEM_UOM_CODE"));

            //for ( i = 0; i < pGrid1.RowCount; i++)        // ���α׸��� ����
            //{
                //pGrid1.CurrentCellMoveTo(vIndexCurrent, 0);

                //int vLine_Id1 = Convert.ToInt32(pGrid1.GetCellValue(vIndexCurrent, pGrid1.GetColumnToIndex("INVENTORY_ITEM_ID")));
                //string vLine_UOM1 = Convert.ToString(pGrid1.GetCellValue(i, pGrid1.GetColumnToIndex("ITEM_UOM_CODE")));

                for ( j = 0; j < pGrid2.RowCount; j++)    // ������ �׸��� ��ȸ
                {
                    long vLine_Id2 = Convert.ToInt32(pGrid2.GetCellValue(j, pGrid2.GetColumnToIndex("INVENTORY_ITEM_ID")));
                    string vLine_UOM2 = Convert.ToString(pGrid2.GetCellValue(j, pGrid2.GetColumnToIndex("ITEM_UOM_CODE")));

                    int vIndexCurrent2 = IDA_DETAIL.OraSelectData.Rows.IndexOf(IDA_DETAIL.CurrentRow);

                    if ((vLine_Id1 == vLine_Id2) && (vLine_UOM1 == vLine_UOM2) && (IDA_DETAIL.OraSelectData.Rows[vIndexCurrent2].RowState != DataRowState.Deleted))
                    {
                        vCheck = true;

                        vPO_Qty = Convert.ToDecimal(pGrid2.GetCellValue(j, pGrid2.GetColumnToIndex("RECEIPT_QTY")));

                        vPO_Qty_Sum = vPO_Qty_Sum + vPO_Qty;
                    }
                }

                if ((vCheck = false) || (vPO_Qty_Sum == 0))
                {
                    pGrid1.CurrentCellMoveTo(vIndexCurrent, 0);
                    IDA_LINE.Delete();
                }

                vPO_Qty_Sum = 0;
                vCheck      = false;

            //}
        }
        //======================================================================================================
        // Request lIne ������ �����ؼ� ���ο� �ѷ��ִ� ��ƾ - INSERT
        //======================================================================================================
        private void Group_Add(ISGridAdvEx pGrid1, ISGridAdvEx pGrid2, ISGridAdvEx pGrid3)
        {
            Object vPo_Qty      = 0;

            decimal vSum_Po_Qty = 0;
            int vLastRow = 0;

            bool vCheck = false;

            long vObject1 = 0;
            long vObject2 = 0;

            long vLine_id = 0;
            long vLine_id2 = 0;

            long vDetail_id = 0;
            long vDetail_id2 = 0;

            string vUOM1 = "";
            string vUOM2 = "";

            int vRow = 0;

            for (vRow = 0; vRow < pGrid3.RowCount; vRow++)
            {
                if (pGrid3.GetCellValue(vRow, pGrid3.GetColumnToIndex("CHECK_SELECT")).ToString() == "Y")
                {
                    vObject1 = Convert.ToInt32(pGrid3.GetCellValue(vRow, pGrid3.GetColumnToIndex("INVENTORY_ITEM_ID")));
                    vObject2 = Convert.ToInt32(pGrid3.GetCellValue(vRow, pGrid3.GetColumnToIndex("INVENTORY_ITEM_ID")));

                    vLine_id = Convert.ToInt32(pGrid3.GetCellValue(vRow, pGrid3.GetColumnToIndex("LINE_ID")));
                    vDetail_id = Convert.ToInt32(pGrid3.GetCellValue(vRow, pGrid3.GetColumnToIndex("DETAIL_ID")));

                    // �δ��������� �����翬���� �Ǿ������� ���ȯ�� ����
                    if (iConvert.ISNumtoZero(pGrid3.GetCellValue(vRow, pGrid3.GetColumnToIndex("CUSTOM_DETAIL_ID"))) > 0)
                    {
                        idcEXCHANGE_RATE.SetCommandParamValue("W_CUSTOM_DETAIL_ID", pGrid3.GetCellValue(vRow, pGrid3.GetColumnToIndex("CUSTOM_DETAIL_ID")));
                        idcEXCHANGE_RATE.ExecuteNonQuery();
                    }

                    vUOM1 = Convert.ToString(pGrid3.GetCellValue(vRow, pGrid3.GetColumnToIndex("ITEM_UOM_CODE")));
                    vUOM2 = Convert.ToString(pGrid3.GetCellValue(vRow, pGrid3.GetColumnToIndex("ITEM_UOM_CODE")));

                    break;
                }
            }

            int vIndexLastRow = vRow;

            pGrid2.BeginUpdate();
            pGrid3.BeginUpdate();

            for ( vRow = 0; vRow < pGrid3.RowCount; vRow++)
            {
                if (pGrid3.GetCellValue(vRow, pGrid3.GetColumnToIndex("CHECK_SELECT")).ToString() == "Y")
                {
                    vLastRow = vRow;

                    vObject2 = Convert.ToInt32(pGrid3.GetCellValue(vRow, pGrid3.GetColumnToIndex("INVENTORY_ITEM_ID")));
                    vUOM2    = Convert.ToString(pGrid3.GetCellValue(vRow, pGrid3.GetColumnToIndex("ITEM_UOM_CODE")));

                    if ((vObject1 != vObject2) || (vUOM1 != vUOM2))
                    {
                        //=================================================================================================
                        // ������ ����Ÿ�� �ִ��� üũ - ���κκ�
                        //=================================================================================================
                        for (int i = 0; i < pGrid1.RowCount; i++)
                        {
                            long   vLine_Id2  = Convert.ToInt32(pGrid1.GetCellValue(i, pGrid1.GetColumnToIndex("INVENTORY_ITEM_ID")));
                            string vLine_UOM2 = Convert.ToString(pGrid1.GetCellValue(i, pGrid1.GetColumnToIndex("ITEM_UOM_CODE")));

                            if ((vObject1 == vLine_Id2) && (vUOM1 == vLine_UOM2) && (IDA_LINE.OraSelectData.Rows[i].RowState != DataRowState.Deleted))
                            {
                                vCheck = true;

                                // 2011-08-29, BY MJSHIN //
                                //pGrid1.SetCellValue(i, pGrid1.GetColumnToIndex("RECEIPT_QTY"), vSum_Po_Qty);                                    // ������

                                //decimal vAmount = Convert.ToDecimal(pGrid1.GetCellValue(i, pGrid1.GetColumnToIndex("ITEM_PRICE"))) * vSum_Po_Qty;  // �ݾ�
                                //pGrid1.SetCellValue(i, pGrid1.GetColumnToIndex("ITEM_AMOUNT"), vAmount);

                                vIndexLastRow = vRow;
                            }
                        }
                        //=================================================================================================
                        // ���κκп� �ش� ���簡 ���� ��� �ش� ���� �߰�
                        //=================================================================================================
                        int    vRow_Cnt = 0;
                        object vObject  = "";

                        if (vCheck == false)
                        {
                            Line_Add(pGrid1, pGrid2, pGrid3, vIndexLastRow, vSum_Po_Qty);                                                   // ���� �׸��� �߰� �Լ� ȣ��

                            vIndexLastRow = vRow;
                        }

                        vSum_Po_Qty = 0;

                        vPo_Qty = pGrid3.GetCellValue(vRow, pGrid3.GetColumnToIndex("REMAIN_QTY")); ;
                        vSum_Po_Qty = vSum_Po_Qty + Convert.ToDecimal(vPo_Qty);
                        vObject1    = vObject2;
                        vUOM1       = vUOM2;

                        vLine_id = vLine_id2;

                        vCheck      = false;
                    }
                    else
                    {
                        vPo_Qty = pGrid3.GetCellValue(vRow, pGrid3.GetColumnToIndex("REMAIN_QTY")); ;

                        vSum_Po_Qty = vSum_Po_Qty + Convert.ToDecimal(vPo_Qty);
                    }
                }

            }

            //=================================================================================================
            // ������ ����Ÿ�� �ִ��� üũ - ���κκ�
            //=================================================================================================
             long   vLine_Id5  = Convert.ToInt32(pGrid3.GetCellValue(vLastRow, pGrid3.GetColumnToIndex("INVENTORY_ITEM_ID")));
             string vLine_UOM5 = Convert.ToString(pGrid3.GetCellValue(vLastRow, pGrid3.GetColumnToIndex("ITEM_UOM_CODE")));

            for (int i = 0; i < pGrid1.RowCount; i++)
            {
                long   vLine_Id2  = Convert.ToInt32(pGrid1.GetCellValue(i, pGrid1.GetColumnToIndex("INVENTORY_ITEM_ID")));
                string vLine_UOM2 = Convert.ToString(pGrid1.GetCellValue(i, pGrid1.GetColumnToIndex("ITEM_UOM_CODE")));

                if ((vLine_Id5 == vLine_Id2) && (vLine_UOM5 == vLine_UOM2) && (IDA_LINE.OraSelectData.Rows[i].RowState != DataRowState.Deleted))
                {
                    vCheck = true;

                    // 2011-08-29, BY MJSHIN //
                    //pGrid1.SetCellValue(i, pGrid1.GetColumnToIndex("RECEIPT_QTY"), vSum_Po_Qty);                                 // ������

                    //decimal vAmount = Convert.ToDecimal(pGrid1.GetCellValue(i, pGrid1.GetColumnToIndex("ITEM_PRICE"))) * vSum_Po_Qty;  // �ݾ�
                    //pGrid1.SetCellValue(i, pGrid1.GetColumnToIndex("ITEM_AMOUNT"), vAmount);
                }
            }
            //=================================================================================================
            // ���κκп� �ش� ���簡 ���� ��� �ش� ���� �߰�
            //=================================================================================================
            int    vRow_Cnt2 = 0;
            object vObject3  = "";

            if (vCheck == false)
            {
                Line_Add(pGrid1, pGrid2, pGrid3, vLastRow, vSum_Po_Qty);                                                          // ���� �׸��� �߰� �Լ� ȣ��
            }

            vCheck = false;

            //=================================================================================================
            // ������ ����Ÿ�� �ִ��� üũ ������ �н� ���� �� �߰� �� - ������
            //=================================================================================================
            for (int i = 0; i < pGrid3.RowCount; i++)
            {
                if (pGrid3.GetCellValue(i, pGrid3.GetColumnToIndex("CHECK_SELECT")).ToString() == "Y")
                {
                    vLine_id = Convert.ToInt32(pGrid3.GetCellValue(i, pGrid3.GetColumnToIndex("LINE_ID")));
                    vDetail_id = Convert.ToInt32(pGrid3.GetCellValue(i, pGrid3.GetColumnToIndex("DETAIL_ID")));

                    vObject1 = Convert.ToInt32(pGrid3.GetCellValue(i, pGrid3.GetColumnToIndex("INVENTORY_ITEM_ID")));
                    vUOM1    = Convert.ToString(pGrid3.GetCellValue(i, pGrid3.GetColumnToIndex("ITEM_UOM_CODE")));

                    for (int j = 0; j < pGrid1.RowCount; j++)
                    {
                        long   vLine_Id4  = Convert.ToInt32(pGrid1.GetCellValue(j, pGrid1.GetColumnToIndex("INVENTORY_ITEM_ID")));
                        string vLine_UOM4 = Convert.ToString(pGrid1.GetCellValue(j, pGrid1.GetColumnToIndex("ITEM_UOM_CODE")));

                        if ((vObject1 == vLine_Id4) && (vUOM1 == vLine_UOM4) && (IDA_LINE.OraSelectData.Rows[j].RowState != DataRowState.Deleted))
                        {

                            pGrid1.CurrentCellMoveTo(j, 0);

                            break;
                        }
                    }


                    for (int j = 0; j < pGrid2.RowCount; j++)
                    {
                        long vLine_Id2 = Convert.ToInt32(pGrid2.GetCellValue(j, pGrid2.GetColumnToIndex("LINE_ID")));
                        long vDetail_Id2 = Convert.ToInt32(pGrid2.GetCellValue(j, pGrid2.GetColumnToIndex("DETAIL_ID")));

                        //long vLine_Id2 = Convert.ToInt32(pGrid2.GetCellValue(j, pGrid2.GetColumnToIndex("LINE_ID")));
                        //long vDetail_Id2 = Convert.ToInt32(pGrid2.GetCellValue(j, pGrid2.GetColumnToIndex("DETAIL_ID")));

                        if (vLine_id == vLine_Id2 && vDetail_id == vDetail_Id2)
                        {
                            vCheck = true;

                            break;
                        }
                    }

                    //=================================================================================================
                    // �� �ű��
                    //=================================================================================================
                    if (vCheck == false)
                    {

                        for (int j = 0; j < pGrid1.RowCount; j++)
                        {
                            long   vLine_Id4  = Convert.ToInt32(pGrid1.GetCellValue(j, pGrid1.GetColumnToIndex("INVENTORY_ITEM_ID")));
                            string vLine_UOM4 = Convert.ToString(pGrid1.GetCellValue(j, pGrid1.GetColumnToIndex("ITEM_UOM_CODE")));

                            if ((vObject1 == vLine_Id4) && (vUOM1 == vLine_UOM4))
                            {
                                vRow_Cnt2 = j;

                                break;
                            }

                            vRow_Cnt2 = j;
                        }

                        Detail_Add(pGrid1, pGrid2, pGrid3, vRow_Cnt2, i, pGrid2.RowCount);       // ������ �׸��� �߰� �Լ� ȣ��

                    }

                    vCheck = false;
                }
            }

            pGrid2.EndUpdate();
            pGrid3.EndUpdate();
        }
        //======================================================================================================
        // �������� ������ �����ؼ� ���ο� �ѷ��ִ� ��ƾ - UPDATE
        //======================================================================================================
        private void Group_Update(ISGridAdvEx pGrid1, ISGridAdvEx pGrid2)
        {
            Object vPo_Qty     = 0;
            decimal vSum_Po_Qty = 0;
            int    vLastRow    = 0;
            bool   vCheck      = false;

            System.Data.DataRow[] vRows = IDA_DETAIL.OraSelectData.Select(null, "INVENTORY_ITEM_ID, ITEM_UOM_CODE");     //  sort

           // System.Data.DataRow[] vRows = IDA_DETAIL.CurrentRows(null, "INVENTORY_ITEM_ID, ITEM_UOM_CODE");     //  sort

            int    vObject1 = Convert.ToInt32(vRows[0][pGrid1.GetColumnToIndex("INVENTORY_ITEM_ID")]);
            int    vObject2 = Convert.ToInt32(vRows[0][pGrid1.GetColumnToIndex("INVENTORY_ITEM_ID")]);

            string vUOM1    = Convert.ToString(vRows[0][pGrid1.GetColumnToIndex("ITEM_UOM_CODE")]);
            string vUOM2    = Convert.ToString(vRows[0][pGrid1.GetColumnToIndex("ITEM_UOM_CODE")]);

            int vIndexLastRow = vRows.Length - 1;

            for (int vRow = 0; vRow < vRows.Length; vRow++)
            {
                vObject2 = Convert.ToInt32(vRows[vRow][pGrid1.GetColumnToIndex("INVENTORY_ITEM_ID")]);
                vUOM2    = Convert.ToString(vRows[vRow][pGrid1.GetColumnToIndex("ITEM_UOM_CODE")]);

                if ((vObject1 != vObject2) || (vUOM1 != vUOM2))
                {
                    //=================================================================================================
                    // ������ ����Ÿ�� �ִ��� üũ
                    //=================================================================================================
                    int    vLine_Id1  = Convert.ToInt32(vRows[vRow - 1][pGrid1.GetColumnToIndex("INVENTORY_ITEM_ID")]);
                    string vLine_UOM1 = Convert.ToString(vRows[vRow - 1][pGrid1.GetColumnToIndex("ITEM_UOM_CODE")]);
                    if (pGrid2.RowCount > 0)
                    {

                        for (int i = 0; i < pGrid2.RowCount; i++)
                        {
                            int vLine_Id2 = Convert.ToInt32(pGrid2.GetCellValue(i, pGrid2.GetColumnToIndex("INVENTORY_ITEM_ID")));
                            string vLine_UOM2 = Convert.ToString(pGrid2.GetCellValue(i, pGrid2.GetColumnToIndex("ITEM_UOM_CODE")));

                            if ((vLine_Id1 == vLine_Id2) && (vLine_UOM1 == vLine_UOM2) && (IDA_LINE.OraSelectData.Rows[i].RowState != DataRowState.Deleted))
                            {
                                vCheck = true;

                                pGrid2.SetCellValue(i, pGrid2.GetColumnToIndex("RECEIPT_QTY"), vSum_Po_Qty);                                                   // ������

                                decimal vAmount = Convert.ToDecimal(pGrid2.GetCellValue(i, pGrid2.GetColumnToIndex("ITEM_PRICE"))) * vSum_Po_Qty;                 // �ݾ�

                                pGrid2.SetCellValue(i, pGrid2.GetColumnToIndex("ITEM_AMOUNT"), vAmount);
                            }
                        }
                    }

                    vSum_Po_Qty = 0;
                    vObject1    = vObject2;
                    vUOM1       = vUOM2;
                    vPo_Qty = vRows[vRow][pGrid1.GetColumnToIndex("RECEIPT_QTY")];
                    vSum_Po_Qty = vSum_Po_Qty + Convert.ToDecimal(vPo_Qty);
                }
                else
                {
                    vPo_Qty = vRows[vRow][pGrid1.GetColumnToIndex("RECEIPT_QTY")];
                    vSum_Po_Qty = vSum_Po_Qty + Convert.ToDecimal(vPo_Qty);
                }
            }

            vCheck = false;

            ////=================================================================================================
            //// ������ ����Ÿ�� �ִ��� üũ
            ////=================================================================================================
            int vLine_Id_Last1 = Convert.ToInt32(vRows[vIndexLastRow][pGrid1.GetColumnToIndex("INVENTORY_ITEM_ID")]);
            string vLine_UOM_Last1 = Convert.ToString(vRows[vIndexLastRow][pGrid1.GetColumnToIndex("ITEM_UOM_CODE")]);
            if (pGrid2.RowCount > 0)
            {
                for (int i = 0; i < pGrid2.RowCount; i++)
                {
                    int vLine_Id_Last2 = Convert.ToInt32(pGrid2.GetCellValue(i, pGrid2.GetColumnToIndex("INVENTORY_ITEM_ID")));
                    string vLine_UOM_Last2 = Convert.ToString(pGrid2.GetCellValue(i, pGrid2.GetColumnToIndex("ITEM_UOM_CODE")));

                    if ((vLine_Id_Last1 == vLine_Id_Last2) && (vLine_UOM_Last1 == vLine_UOM_Last2) && (IDA_LINE.OraSelectData.Rows[i].RowState != DataRowState.Deleted))
                    {
                        vCheck = true;

                        pGrid2.SetCellValue(i, pGrid2.GetColumnToIndex("RECEIPT_QTY"), vSum_Po_Qty);                                                 // ��û����

                        decimal vAmount = Convert.ToDecimal(pGrid2.GetCellValue(i, pGrid2.GetColumnToIndex("ITEM_PRICE"))) * vSum_Po_Qty;  // �ݾ�

                        pGrid2.SetCellValue(i, pGrid2.GetColumnToIndex("ITEM_AMOUNT"), vAmount);
                    }
                }
            }
            pGrid2.EndUpdate();
            pGrid1.EndUpdate();
        }
        //======================================================================================================
        // ������ ��ü ���ֱݾ� ���ϴ� ��ƾ
        //======================================================================================================
        private void Group_Total_Amount()
        {
            decimal vAmount = 0;
            decimal vAmount2 = 0;
            decimal vQTY = 0;

            for (int i = 0; i < ISG_LINE.RowCount; i++)
            {
                vAmount  += (Convert.ToDecimal(ISG_LINE.GetCellValue(i, ISG_LINE.GetColumnToIndex("ITEM_AMOUNT"))));
                vQTY += (Convert.ToDecimal(ISG_LINE.GetCellValue(i, ISG_LINE.GetColumnToIndex("RECEIPT_QTY"))));
            }

            iedTOTAL_AMOUNT.EditValue = vAmount;
            iedTOTAL_QTY.EditValue = vQTY;
        }
        //======================================================================================================
        private void CopyGrid_Left_To_Right(ISGridAdvEx pGrid1, ISGridAdvEx pGrid2)
        {
            int vIndexCurrent = IDA_DETAIL.OraSelectData.Rows.IndexOf(IDA_DETAIL.CurrentRow);
            long vLine_Id1 = Convert.ToInt32(pGrid1.GetCellValue("LINE_ID"));
            long vDetail_Id1 = Convert.ToInt32(pGrid1.GetCellValue("DETAIL_ID"));

            for (int j = 0; j < pGrid2.RowCount; j++)
            {
                long vLine_Id2 = Convert.ToInt32(pGrid2.GetCellValue(j, pGrid2.GetColumnToIndex("LINE_ID")));
                long vDetail_Id2 = Convert.ToInt32(pGrid2.GetCellValue(j, pGrid2.GetColumnToIndex("DETAIL_ID")));

                if (vLine_Id1 == vLine_Id2 && vDetail_Id1 == vDetail_Id2)
                {
                    pGrid2.SetCellValue(j, pGrid2.GetColumnToIndex("CHECK_SELECT"), "N");
                }
            }

            pGrid1.CurrentCellMoveTo(vIndexCurrent, 0);
            IDA_DETAIL.Delete();
        }

        #endregion;

        #region ----- Events -----

        private void isAppInterfaceAdv1_AppMainButtonClick(ISAppButtonEvents e)
        {
            if (this.IsActive)
            {
                if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Search)
                {
                    if (TAB_MAIN.SelectedIndex == 0)
                    {
                        IDA_HEADER.Fill();
                    }
                    else if (TAB_MAIN.SelectedIndex == 1)
                    {
                        IDA_RECEIPT_LIST.Fill();
                    }

                    
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddOver)
                {
                    IDA_HEADER.AddOver();
                    IDA_LINE.OraSelectData.Clear();
                    IDA_DETAIL.OraSelectData.Clear();
                    isPO_DA.OraSelectData.Clear();
                    IDA_LINE.Delete();
                    IDA_DETAIL.Delete();
                   // isPO_DA.Delete();
                    Header_Setting();
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddUnder)
                {
                    IDA_HEADER.AddUnder();
                    IDA_LINE.OraSelectData.Clear();
                    IDA_DETAIL.OraSelectData.Clear();
                    isPO_DA.OraSelectData.Clear();
                    IDA_LINE.Delete();
                    IDA_DETAIL.Delete();
                  //  isPO_DA.Delete();
                    Header_Setting();
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Update)
                {
                    //if ((iedHEADER_STATUS_CODE.EditValue.ToString() != "CRC") && (iedHEADER_STATUS_CODE.EditValue.ToString() != ""))
                    //{
                    //    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("SDM_10008"), "WARRING", MessageBoxButtons.OK, MessageBoxIcon.Warning);

                    //    return;
                    //}

                    //if (isLINE_DA.VisbleCurrentRowCount == 0)
                    //{
                    //    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("PO_10005"), "WARRING", MessageBoxButtons.OK, MessageBoxIcon.Warning);

                    //    return;
                    //}
                     
                    DataRow row = IDA_HEADER.CurrentRow;
                    isPO_DA.OraSelectData.AcceptChanges();
                    isPO_DA.Refillable = true;

                    IDA_HEADER.Update();
                    IDA_HEADER.Fill();

                    isPO_DA.Fill();

                    //isDataTransaction1.BeginTran();

                    IDC_DELIVERY_INSERT.ExecuteNonQuery();

                    IDA_HEADER.Fill();

                    //if (isDataCommand3.GetCommandParamValue("X_RESULT_STATUS").ToString() == "F")
                    //{
                    //    isDataTransaction1.RollBack();
                    //    MessageBoxAdv.Show(isDataCommand3.GetCommandParamValue("X_RESULT_MSG").ToString(), "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    //    return;
                    //}

                    //isDataTransaction1.Commit();
                    
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Cancel)
                {
                    if (IDA_HEADER.IsFocused)
                    {
                        IDA_HEADER.Cancel();
                    }
                    else if (IDA_LINE.IsFocused)
                    {
                        IDA_LINE.Cancel();
                    }
                    else if (IDA_DETAIL.IsFocused)
                    {
                        IDA_DETAIL.Cancel();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {                   
                    if (IDA_HEADER.IsFocused)
                    {
                        IDA_HEADER.Delete();
                    }
                    else if (IDA_LINE.IsFocused)
                    {
                        if (iConvert.ISNull(ISG_LINE.GetCellValue("LINE_STATUS_CODE")) == "CDL")
                        {
                            MessageBoxAdv.Show(isMessageAdapter1.ReturnText("SDM_10008"), "WARRING", MessageBoxButtons.OK, MessageBoxIcon.Warning);

                            return;
                        };


                        IDA_LINE.Delete();
                    }
                    else if (IDA_DETAIL.IsFocused)
                    {
                        IDA_DETAIL.Delete();
                    }
                }
            }
        }


        #endregion;

        private void INVF0101_Load(object sender, EventArgs e)
        {
            IDA_HEADER.FillSchema();

            V_DATE_FR.EditValue = iDate.ISMonth_1st(DateTime.Today);
            V_DATE_TO.EditValue = DateTime.Today;

            V_INSPECT_FLAG.EditValue = Convert.ToString("A");
            RD_ALL.Checked = true;
        }

        private void isButton1_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            
            Group_Add(ISG_LINE, ISG_DETAIL, ISG_TARGET);
            if (ISG_LINE.RowCount > 0)
            {
                Group_Update(ISG_DETAIL, ISG_LINE);
            }
            Group_Total_Amount();
        }
        private void isButton2_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            CopyGrid_Left_To_Right(ISG_DETAIL, ISG_TARGET);
            Group_Del(ISG_LINE, ISG_DETAIL);

            if (ISG_DETAIL.RowCount > 0)
            {
                if (IDA_DETAIL.VisbleCurrentRowCount > 0)
                {
                    if (ISG_LINE.RowCount > 0)
                    {
                        Group_Update(ISG_DETAIL, ISG_LINE);
                    }
                }
            }

            Group_Total_Amount();
        }
        private void isGridAdvEx2_CurrentCellValidating(object pSender, ISGridAdvExValidatingEventArgs e)
        {
            switch (ISG_DETAIL.GridAdvExColElement[e.ColIndex].DataColumn.ToString())
            {
                case "RECEIPT_QTY":
                    decimal vPO_Qty;
                    decimal vPO_Qty2;

                    int vObject2;

                    object vObject;

                    string vUOM2;

                    vPO_Qty = Convert.ToDecimal(ISG_DETAIL.GetCellValue(e.RowIndex, ISG_DETAIL.GetColumnToIndex("REMAIN_QTY")));

                    if (vPO_Qty < Convert.ToDecimal(e.NewValue))
                    {
                        MessageBoxAdv.Show(isMessageAdapter1.ReturnText("PO_10004"), "WARRING", MessageBoxButtons.OK, MessageBoxIcon.Warning);

                        e.Cancel = true;

                        return;
                    }

                    int vObject1 = Convert.ToInt32(ISG_DETAIL.GetCellValue(e.RowIndex, ISG_DETAIL.GetColumnToIndex("INVENTORY_ITEM_ID")));
                    string vUOM1 = Convert.ToString(ISG_DETAIL.GetCellValue(e.RowIndex, ISG_DETAIL.GetColumnToIndex("ITEM_UOM_CODE")));

                    vPO_Qty = Convert.ToDecimal(e.NewValue) - Convert.ToDecimal(e.OldValue);
                   // ISG_DETAIL.SetCellValue(e.RowIndex, ISG_DETAIL.GetColumnToIndex("REMAIN_QTY"), Convert.ToDecimal(e.OldValue) - Convert.ToDecimal(e.NewValue));

                    for (int i = 0; i < ISG_LINE.RowCount; i++)
                    {
                        vObject2 = Convert.ToInt32(ISG_LINE.GetCellValue(i, ISG_LINE.GetColumnToIndex("INVENTORY_ITEM_ID")));
                        vUOM2 = Convert.ToString(ISG_LINE.GetCellValue(i, ISG_LINE.GetColumnToIndex("ITEM_UOM_CODE")));
                        //=================================================================================================
                        // ������ ����Ÿ�� �ִ��� üũ
                        //=================================================================================================
                        if ((vObject1 == vObject2) && (vUOM1 == vUOM2))
                        {
                            vPO_Qty2 = Convert.ToDecimal(ISG_LINE.GetCellValue(i, ISG_LINE.GetColumnToIndex("RECEIPT_QTY")));

                           // vPO_Qty = Convert.ToDecimal(e.NewValue) - vPO_Qty2;

                            ISG_LINE.SetCellValue(i, ISG_LINE.GetColumnToIndex("RECEIPT_QTY"), vPO_Qty2 + vPO_Qty);                                     // ������

                            decimal vAmount = Convert.ToDecimal(ISG_LINE.GetCellValue(i, ISG_LINE.GetColumnToIndex("ITEM_PRICE"))) * (vPO_Qty2 + vPO_Qty );  // �ݾ�

                            ISG_LINE.SetCellValue(i, ISG_LINE.GetColumnToIndex("ITEM_AMOUNT"), vAmount);

                            vObject = vAmount * iedEXCHANGE_RATE.NumberValue;
                            ISG_LINE.SetCellValue(i, ISG_LINE.GetColumnToIndex("ITEM_AMOUNT_KRW"), vObject);                                            // �ݾ�

                            Group_Total_Amount();

                            break;
                        }
                    }


                    break;
                default:
                    break;
            }
        }

        private void isHEADER_DA_ExcuteKeySearch(object pSender)
        {
            isPO_DA.Fill();

            IDA_HEADER.Fill();
            Group_Total_Amount();
        }

        private void isCURRENCY_LA_SelectedRowData(object pSender)
        {
            IDC_EXCHANGE_RATE_H.ExecuteNonQuery();

            for (int j = 0; j < ISG_LINE.RowCount; j++)
            {
                object vObject = Convert.ToDecimal(ISG_LINE.GetCellValue(j, ISG_LINE.GetColumnToIndex("ITEM_AMOUNT"))) * iedEXCHANGE_RATE.NumberValue;
                ISG_LINE.SetCellValue(j, ISG_LINE.GetColumnToIndex("ITEM_AMOUNT_KRW"), vObject);                                   // �ݾ�

                ISG_LINE.SetCellValue(j, ISG_LINE.GetColumnToIndex("CURRENCY_CODE"), iedCURRENCY_CODE.EditValue);
            }
        }

        private void isCUSTOM_LA_SelectedRowData(object pSender)
        {
            
            isDataCommand2.ExecuteNonQuery();

            if (iedCURRENCY_CODE.EditValue.ToString() != "")
            {
                isPO_DA.Fill();

                IDC_EXCHANGE_RATE_H.ExecuteNonQuery();

                for (int j = 0; j < ISG_LINE.RowCount; j++)
                {
                    object vObject = Convert.ToDecimal(ISG_LINE.GetCellValue(j, ISG_LINE.GetColumnToIndex("ITEM_AMOUNT"))) * iedEXCHANGE_RATE.NumberValue;
                    ISG_LINE.SetCellValue(j, ISG_LINE.GetColumnToIndex("ITEM_AMOUNT_KRW"), vObject);                                   // �ݾ�

                    ISG_LINE.SetCellValue(j, ISG_LINE.GetColumnToIndex("CURRENCY_CODE"), iedCURRENCY_CODE.EditValue);
                }
            }
        }

        private void isPO_NO_LA_SelectedRowData(object pSender)
        {
            isDataCommand2.ExecuteNonQuery();

            if (iedCURRENCY_CODE.EditValue.ToString() != "")
            {
                isPO_DA.Fill();

                IDC_EXCHANGE_RATE_H.ExecuteNonQuery();

                for (int j = 0; j < ISG_LINE.RowCount; j++)
                {
                    object vObject = Convert.ToDecimal(ISG_LINE.GetCellValue(j,  ISG_LINE.GetColumnToIndex("ITEM_AMOUNT"))) * iedEXCHANGE_RATE.NumberValue;
                    ISG_LINE.SetCellValue(j, ISG_LINE.GetColumnToIndex("ITEM_AMOUNT_KRW"), vObject);                                   // �ݾ�

                    ISG_LINE.SetCellValue(j, ISG_LINE.GetColumnToIndex("CURRENCY_CODE"), iedCURRENCY_CODE.EditValue);
                }
            }
        }

        private void isPO_NO_LA_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            if (iedPO_TYPE_NAME.EditValue.ToString() == "")
            {
                e.Cancel = true;
            }

            if (IDA_LINE.VisbleCurrentRowCount > 0)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("PO_10003"), "WARRING", MessageBoxButtons.OK, MessageBoxIcon.Warning);

                e.Cancel = true;
            }
        }

        private void isCUSTOM_LA_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            if (iedPO_TYPE_NAME.EditValue.ToString() == "")
            {
                e.Cancel = true;
            }
            
            if (IDA_LINE.VisbleCurrentRowCount > 0)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("PO_10003"), "WARRING", MessageBoxButtons.OK, MessageBoxIcon.Warning);

                e.Cancel = true;
            }
        }

        private void isGridAdvEx1_CurrentCellValidating(object pSender, ISGridAdvExValidatingEventArgs e)
        {
            switch (ISG_LINE.GridAdvExColElement[e.ColIndex].DataColumn.ToString())
            {
                case "ITEM_PRICE":

                    ISG_LINE.SetCellValue("ITEM_AMOUNT", (Convert.ToDecimal(e.NewValue) * Convert.ToDecimal(ISG_LINE.GetCellValue("RECEIPT_QTY"))));

                    ISG_LINE.SetCellValue("ITEM_AMOUNT_KRW", (Convert.ToDecimal(iedEXCHANGE_RATE.EditValue) * Convert.ToDecimal(ISG_LINE.GetCellValue("ITEM_AMOUNT"))));
                    
                    break;

                default:
                    break;
            }
        }

        private void isCURRENCY_LA2_SelectedRowData(object pSender)
        {
            IDC_EXCHANGE_RATE_GRID.ExecuteNonQuery();

            object vObject = Convert.ToDecimal(ISG_LINE.GetCellValue("ITEM_AMOUNT")) * Convert.ToDecimal(ISG_LINE.GetCellValue("EXCHANGE_RATE"));
            ISG_LINE.SetCellValue("ITEM_AMOUNT_KRW", vObject);                                   // �ݾ�

        }

        private void isCURRENCY_LA_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            if (iedCURRENCY_CODE.EditValue.ToString() != "" )
            {
                if (IDA_LINE.VisbleCurrentRowCount > 0)
                {
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("PO_10003"), "WARRING", MessageBoxButtons.OK, MessageBoxIcon.Warning);

                    e.Cancel = true;
                }
            }
            
        }

        private void ILA_SUPPLIER_SelectedRowData(object pSender)
        {
            if (iedCURRENCY_CODE.EditValue != null)
            {
                IDC_EXCHANGE_RATE_H.ExecuteNonQuery();
                IDC_DEFAULT_WAREHOUSE.ExecuteNonQuery();

                isPO_DA.Fill();
                
            }
        }

        private void ILA_SUPPLIER_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            //if (isLINE_DA.Refillable == false)
            if (ISG_DETAIL.RowCount > 0)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("PO_10003"), "WARRING", MessageBoxButtons.OK, MessageBoxIcon.Warning);

                e.Cancel = true;
            }
            else
            {
                IDA_LINE.OraSelectData.AcceptChanges();
                IDA_LINE.Refillable = true;

                IDA_DETAIL.OraSelectData.AcceptChanges();
                IDA_DETAIL.Refillable = true;

                isPO_DA.OraSelectData.AcceptChanges();
                isPO_DA.Refillable = true;
            }
        }

        private void RD_NOT_INSPECT_CheckChanged(object sender, EventArgs e)
        {
            if (RD_NOT_INSPECT.Checked == true)
            {
                V_INSPECT_FLAG.EditValue = RD_NOT_INSPECT.CheckedString.ToString();
            }
        }

        private void RD_INSPECT_CheckChanged(object sender, EventArgs e)
        {
            if (RD_INSPECT.Checked == true)
            {
                V_INSPECT_FLAG.EditValue = RD_INSPECT.CheckedString.ToString();
            }
        }

        private void RD_ALL_CheckChanged(object sender, EventArgs e)
        {
            if (RD_ALL.Checked == true)
            {
                V_INSPECT_FLAG.EditValue = RD_ALL.CheckedString.ToString();
            }
        }

        private void ISG_RECEIPT_BY_RECP_CellDoubleClick(object pSender)
        {
            if (IDA_HEADER.Refillable == true && IDA_LINE.Refillable == true && IDA_DETAIL.Refillable == true)
            {
                H_RECEIPT_HEADER_ID.EditValue = ISG_RECEIPT_LIST.GetCellValue("RECEIPT_HEADER_ID");

                IDA_HEADER.OraSelectData.AcceptChanges();
                IDA_HEADER.Refillable = true;


                IDA_HEADER.Fill();
                Group_Total_Amount();

                isPO_DA.Fill();

                TAB_MAIN.SelectedIndex = 0;

            }
            else
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("PO_10014"), "WARRING", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            }
        }

        private void T_SELECT_ALL_CheckedChange(object pSender, ISCheckEventArgs e)
        {
            for (int vLoop = 0; vLoop < ISG_RECEIPT_LIST.RowCount; vLoop++)
            {
                ISG_RECEIPT_LIST.SetCellValue(vLoop, 0, T_SELECT_ALL.CheckBoxValue.ToString());
                IDA_RECEIPT_LIST.OraSelectData.AcceptChanges();
                IDA_RECEIPT_LIST.Refillable = true;
            }
        }

        // ���ϳ��� ������ư //
        private void BT_RECEIPT_DELETE_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            string V_RESULT_STATUS = "S";

            IDT_RECEIPT_LINE_DELETE.BeginTran();

            for (int vLoop = 0; vLoop < ISG_RECEIPT_LIST.RowCount; vLoop++)
            {
                if (ISG_RECEIPT_LIST.GetCellValue(vLoop, ISG_RECEIPT_LIST.GetColumnToIndex("SELECT_FLAG")).ToString() == "Y" )
                {
                    IDC_RECEIPT_LINE_DELETE.SetCommandParamValue("W_RECEIPT_HEADER_ID", ISG_RECEIPT_LIST.GetCellValue(vLoop, ISG_RECEIPT_LIST.GetColumnToIndex("RECEIPT_HEADER_ID")));
                    IDC_RECEIPT_LINE_DELETE.SetCommandParamValue("W_RECEIPT_LINE_ID",   ISG_RECEIPT_LIST.GetCellValue(vLoop, ISG_RECEIPT_LIST.GetColumnToIndex("RECEIPT_LINE_ID")));

                    IDC_RECEIPT_LINE_DELETE.ExecuteNonQuery();

                    string X_RESULT_STATUS = iConvert.ISNull(IDC_RECEIPT_LINE_DELETE.GetCommandParamValue("X_RESULT_STATUS"));
                    string X_RESULT_MSG = iConvert.ISNull(IDC_RECEIPT_LINE_DELETE.GetCommandParamValue("X_RESULT_MSG"));

                    if (IDC_RECEIPT_LINE_DELETE.ExcuteError || (X_RESULT_STATUS != string.Empty && X_RESULT_STATUS == "F"))
                    {
                        V_RESULT_STATUS = "F";
                        IDT_RECEIPT_LINE_DELETE.RollBack();
                        MessageBoxAdv.Show(X_RESULT_MSG, "ERROR", MessageBoxButtons.OK, MessageBoxIcon.Error);
                        return;
                    }
                }
            }
            if (V_RESULT_STATUS == "S")
            {
                IDT_RECEIPT_LINE_DELETE.Commit();
                //���ϳ��� ������ �Ϸ�Ǿ����ϴ�.//
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("INV_10049", null), "SUCCESS", MessageBoxButtons.OK, MessageBoxIcon.Information);
                IDA_RECEIPT_LIST.Fill();
            }
        }

        private void ISG_RECEIPT_LIST_CurrentCellChanged(object pSender, ISGridAdvExChangedEventArgs e)
        {
            IDA_RECEIPT_LIST.OraSelectData.AcceptChanges();
            IDA_RECEIPT_LIST.Refillable = true;
        }

        private void ISG_RECEIPT_LIST_CurrentCellEditingComplete(object pSender, ISGridAdvExCellEditingEventArgs e)
        {
            IDA_RECEIPT_LIST.OraSelectData.AcceptChanges();
            IDA_RECEIPT_LIST.Refillable = true;
        }

        private void BT_TARGET_SELECT_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            isPO_DA.Fill();
        }

    }
}