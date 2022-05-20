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

namespace PPMF0918
{
    public partial class PPMF0918 : Office2007Form
    {
        #region ----- Variables -----

        private ISCommonUtil.ISFunction.ISConvert iConvert = new ISFunction.ISConvert();
        private ISCommonUtil.ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        #endregion;

        #region ----- Constructor -----

        public PPMF0918(Form pMainForm, ISAppInterface pAppInterface)
        {
            InitializeComponent();
            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;
        }

        #endregion;

        #region ----- Private Methods ----

        //private void Total_Computing_Amount()
        //{
        //    iedSLIP_AMOUNT.EditValue = (int)0;
        //    iedTAX_AMOUNT.EditValue = (int)0;
        //    iedAMOUNT_1.EditValue = (int)0;
        //    iedAMOUNT_2.EditValue = (int)0;
        //    iedAMOUNT_3.EditValue = (int)0;
        //    iedAMOUNT_4.EditValue = (int)0;
        //    iedAMOUNT_5.EditValue = (int)0;

        //    isGridAdvEx2.LastConfirmChanges();

        //    for (int vLoop = 0; vLoop < isGridAdvEx2.RowCount; vLoop++)
        //    {
        //        if (isGridAdvEx2.GetCellValue(vLoop, isGridAdvEx2.GetColumnToIndex("SELECT_FLAG")).ToString() == "Y")
        //        {
        //            iedSLIP_AMOUNT.EditValue = Convert.ToDecimal(iedSLIP_AMOUNT.EditValue) +
        //                                            Convert.ToDecimal(isGridAdvEx2.GetCellValue(vLoop, isGridAdvEx2.GetColumnToIndex("ADJUST_AMOUNT")));

        //            iedTAX_AMOUNT.EditValue = System.Math.Truncate(Convert.ToDecimal(iedSLIP_AMOUNT.EditValue) / 10);

        //            if (isGridAdvEx2.GetCellValue(vLoop, isGridAdvEx2.GetColumnToIndex("ACCOUNT_CODE")).ToString() == "1120400")
        //            {
        //                iedAMOUNT_1.EditValue = Convert.ToDecimal(iedAMOUNT_1.EditValue) +
        //                                            Convert.ToDecimal(isGridAdvEx2.GetCellValue(vLoop, isGridAdvEx2.GetColumnToIndex("ADJUST_AMOUNT")));
        //            }
        //            else if (isGridAdvEx2.GetCellValue(vLoop, isGridAdvEx2.GetColumnToIndex("ACCOUNT_CODE")).ToString() == "5132001")
        //            {
        //                iedAMOUNT_2.EditValue = Convert.ToDecimal(iedAMOUNT_2.EditValue) +
        //                                            Convert.ToDecimal(isGridAdvEx2.GetCellValue(vLoop, isGridAdvEx2.GetColumnToIndex("ADJUST_AMOUNT")));
        //            }
        //            else if (isGridAdvEx2.GetCellValue(vLoop, isGridAdvEx2.GetColumnToIndex("ACCOUNT_CODE")).ToString() == "1220300")
        //            {
        //                iedAMOUNT_3.EditValue = Convert.ToDecimal(iedAMOUNT_3.EditValue) +
        //                                            Convert.ToDecimal(isGridAdvEx2.GetCellValue(vLoop, isGridAdvEx2.GetColumnToIndex("ADJUST_AMOUNT")));
        //            }
        //            else if (isGridAdvEx2.GetCellValue(vLoop, isGridAdvEx2.GetColumnToIndex("ACCOUNT_CODE")).ToString() == "1120200")
        //            {
        //                iedAMOUNT_4.EditValue = Convert.ToDecimal(iedAMOUNT_4.EditValue) +
        //                                            Convert.ToDecimal(isGridAdvEx2.GetCellValue(vLoop, isGridAdvEx2.GetColumnToIndex("ADJUST_AMOUNT")));
        //            }
        //            else if (isGridAdvEx2.GetCellValue(vLoop, isGridAdvEx2.GetColumnToIndex("ACCOUNT_CODE")).ToString() == "5131503")
        //            {
        //                iedAMOUNT_5.EditValue = Convert.ToDecimal(iedAMOUNT_5.EditValue) +
        //                                            Convert.ToDecimal(isGridAdvEx2.GetCellValue(vLoop, isGridAdvEx2.GetColumnToIndex("ADJUST_AMOUNT")));
        //            }
        //        }
        //    }            
        //}

        private void Show_Detail(object pINVOICE_NO, object pEXPORT_DOC_NUM, object pSHIP_DATE, object pBILL_TO_CUST_SITE_ID)
        {

            isTabAdv1.SelectedIndex = 1;
            isTabAdv1.SelectedTab.Focus();

            Application.DoEvents();

            IDA_ONHAND_DISPOSAL_DTL.SetSelectParamValue("W_INVOICE_NO", pINVOICE_NO);
            IDA_ONHAND_DISPOSAL_DTL.SetSelectParamValue("W_EXPORT_DOC_NUM", pEXPORT_DOC_NUM);
            IDA_ONHAND_DISPOSAL_DTL.SetSelectParamValue("W_SHIP_DATE", pSHIP_DATE);
            IDA_ONHAND_DISPOSAL_DTL.SetSelectParamValue("W_BILL_TO_CUST_SITE_ID", pBILL_TO_CUST_SITE_ID);
            IDA_ONHAND_DISPOSAL_DTL.OraSelectData.AcceptChanges();
            IDA_ONHAND_DISPOSAL_DTL.Refillable = true;

            IDA_ONHAND_DISPOSAL_DTL.Fill();
        }

        #endregion;

        #region ----- Events -----

        private void PPMF0918_Load(object sender, EventArgs e)
        {
            IDA_ONHAND_DISPOSAL_SLIP_N.FillSchema();
            IDA_ONHAND_DISPOSAL_DTL.FillSchema();
            IDA_ONHAND_DISPOSAL_SLIP_Y.FillSchema();


            W_VAT_ISSUE_DATE.EditValue = iDate.ISMonth_Last(DateTime.Today, -1);
            W_PAYMENT_DATE.EditValue = iDate.ISMonth_Last(DateTime.Today, 1);

        }

        // PERIOD LOOKUP ���ý� ���� //
        private void ilaPERIOD_SelectedRowData(object pSender)
        {
            if (isTabAdv1.SelectedTab.TabIndex == 1)
            {
                IDA_ONHAND_DISPOSAL_SLIP_N.Fill();
            }
            else if (isTabAdv1.SelectedTab.TabIndex == 3)
            {
                IDA_ONHAND_DISPOSAL_SLIP_Y.Fill();
            }
        }

        private void ilaPERIOD_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildPERIOD.SetLookupParamValue("W_CLOSE_TYPE", "SHIP_ADJ");

        }

        private void icbSELECT_ALL_CheckedChange(object pSender, ISCheckEventArgs e)
        {
            for (int vLoop = 0; vLoop < IGR_ONHAND_DISPOSAL_SLIP_N.RowCount; vLoop++)
            {
                IGR_ONHAND_DISPOSAL_SLIP_N.SetCellValue(vLoop, 0, icbSELECT_ALL.CheckBoxValue.ToString());
                IDA_ONHAND_DISPOSAL_SLIP_N.OraSelectData.AcceptChanges();
                IDA_ONHAND_DISPOSAL_SLIP_N.Refillable = true;
            }
        }

        //private void icbSELECT_ALL_P_CheckedChange(object pSender, ISCheckEventArgs e)
        //{
        //    for (int vLoop = 0; vLoop < isGridAdvEx2.RowCount; vLoop++)
        //    {
        //        isGridAdvEx2.SetCellValue(vLoop, 0, icbSELECT_ALL_P.CheckBoxValue.ToString());
        //        IDA_ONHAND_PURCHASE_DTL.OraSelectData.AcceptChanges();
        //        IDA_ONHAND_PURCHASE_DTL.Refillable = true;
        //    }

        //    Total_Computing_Amount();
        //}

        private void icbSELECT_ALL_C_CheckedChange(object pSender, ISCheckEventArgs e)
        {
            for (int vLoop = 0; vLoop < IGR_ONHAND_DISPOSAL_SLIP_Y.RowCount; vLoop++)
            {
                IGR_ONHAND_DISPOSAL_SLIP_Y.SetCellValue(vLoop, 0, icbSELECT_ALL_C.CheckBoxValue.ToString());
                IDA_ONHAND_DISPOSAL_SLIP_Y.OraSelectData.AcceptChanges();
                IDA_ONHAND_DISPOSAL_SLIP_Y.Refillable = true;
            }
        }

        private void ibtSLIP_SEND_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            string X_RESULT_STATUS;
            string X_RESULT_MSG;

            int vIDX_CHECK_YN = IGR_ONHAND_DISPOSAL_SLIP_N.GetColumnToIndex("CHECK_YN");
            int vIDX_INVOICE_NO = IGR_ONHAND_DISPOSAL_SLIP_N.GetColumnToIndex("INVOICE_NO");
            int vIDX_EXPORT_DOC_NUM = IGR_ONHAND_DISPOSAL_SLIP_N.GetColumnToIndex("EXPORT_DOC_NUM");
            int vIDX_SHIP_DATE = IGR_ONHAND_DISPOSAL_SLIP_N.GetColumnToIndex("SHIP_DATE");
            int vIDX_SUPPLIER_ID = IGR_ONHAND_DISPOSAL_SLIP_N.GetColumnToIndex("CUSTOMER_ID");


            if (isTabAdv1.SelectedTab.TabIndex == 1)
            {
                for (int vLoop = 0; vLoop < IGR_ONHAND_DISPOSAL_SLIP_N.RowCount; vLoop++)
                {
                    if (IGR_ONHAND_DISPOSAL_SLIP_N.GetCellValue(vLoop, vIDX_CHECK_YN).ToString() == "Y")
                    {
                        isDataTransaction1.BeginTran();
                         
                        IDC_SEND_SLIP.SetCommandParamValue("W_SHIP_DATE", IGR_ONHAND_DISPOSAL_SLIP_N.GetCellValue(vLoop, vIDX_SHIP_DATE));
                        IDC_SEND_SLIP.SetCommandParamValue("W_INVOICE_NO", IGR_ONHAND_DISPOSAL_SLIP_N.GetCellValue(vLoop, vIDX_INVOICE_NO));
                        IDC_SEND_SLIP.SetCommandParamValue("W_EXPORT_DOC_NUM", IGR_ONHAND_DISPOSAL_SLIP_N.GetCellValue(vLoop, vIDX_EXPORT_DOC_NUM));
                        IDC_SEND_SLIP.SetCommandParamValue("W_VENDOR_ID", IGR_ONHAND_DISPOSAL_SLIP_N.GetCellValue(vLoop, vIDX_SUPPLIER_ID));
                        IDC_SEND_SLIP.SetCommandParamValue("W_VAT_ISSUE_DATE", W_VAT_ISSUE_DATE.EditValue);
                        IDC_SEND_SLIP.SetCommandParamValue("W_PAYMENT_DATEv", W_PAYMENT_DATE.EditValue);
                        IDC_SEND_SLIP.ExecuteNonQuery();

                        X_RESULT_STATUS = iConvert.ISNull(IDC_SEND_SLIP.GetCommandParamValue("O_STATUS"));
                        X_RESULT_MSG = iConvert.ISNull(IDC_SEND_SLIP.GetCommandParamValue("O_MESSAGE"));

                        if (IDC_SEND_SLIP.ExcuteError || (X_RESULT_STATUS != string.Empty && X_RESULT_STATUS == "F"))
                        {
                            isDataTransaction1.RollBack();
                            MessageBoxAdv.Show(X_RESULT_MSG, "ERROR", MessageBoxButtons.OK, MessageBoxIcon.Error);
                            return;
                        } 

                        isDataTransaction1.Commit();
                    }
                }

                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_10010", null), "SUCCESS", MessageBoxButtons.OK, MessageBoxIcon.Information);

                IGR_ONHAND_DISPOSAL_SLIP_N.LastConfirmChanges();
                IDA_ONHAND_DISPOSAL_SLIP_N.OraSelectData.AcceptChanges();
                IDA_ONHAND_DISPOSAL_SLIP_N.Refillable = true;

                IDA_ONHAND_DISPOSAL_SLIP_N.Fill();
            }
            else if (isTabAdv1.SelectedTab.TabIndex == 2)
            {
                //isDataTransaction1.BeginTran();

                //for (int vLoop = 0; vLoop < isGridAdvEx2.RowCount; vLoop++)
                //{
                //    if (isGridAdvEx2.GetCellValue(vLoop, isGridAdvEx2.GetColumnToIndex("SELECT_FLAG")).ToString() == "Y")
                //    {
                //        idcTARGET.SetCommandParamValue("W_SUPPLIER_ID", isGridAdvEx2.GetCellValue(vLoop, isGridAdvEx2.GetColumnToIndex("SUPPLIER_ID")));
                //        idcTARGET.SetCommandParamValue("W_INVENTORY_ITEM_ID", isGridAdvEx2.GetCellValue(vLoop, isGridAdvEx2.GetColumnToIndex("INVENTORY_ITEM_ID")));
                //        idcTARGET.SetCommandParamValue("W_ADJUST_TRX_ID", isGridAdvEx2.GetCellValue(vLoop, isGridAdvEx2.GetColumnToIndex("ADJUST_TRX_ID")));
                //        idcTARGET.SetCommandParamValue("W_ACCOUNT_CODE", isGridAdvEx2.GetCellValue(vLoop, isGridAdvEx2.GetColumnToIndex("ACCOUNT_CODE")));
                //        idcTARGET.ExecuteNonQuery();

                //        X_RESULT_STATUS = iConvert.ISNull(idcTARGET.GetCommandParamValue("X_RESULT_STATUS"));
                //        X_RESULT_MSG = iConvert.ISNull(idcTARGET.GetCommandParamValue("X_RESULT_MSG"));

                //        if (idcTARGET.ExcuteError || (X_RESULT_STATUS != string.Empty && X_RESULT_STATUS == "F"))
                //        {
                //            isDataTransaction1.RollBack();
                //            MessageBoxAdv.Show(X_RESULT_MSG, "ERROR", MessageBoxButtons.OK, MessageBoxIcon.Error);
                //            return;
                //        }
                //    }
                //}

                //idcSEND.SetCommandParamValue("P_SUPPLIER_ID", IGR_ONHAND_PURCHASE_SLIP_N.GetCellValue("SUPPLIER_ID"));
                //idcSEND.SetCommandParamValue("P_ADJUST_TAX_AMOUNT", iedTAX_AMOUNT.EditValue);
                //idcSEND.ExecuteNonQuery();

                //X_RESULT_STATUS = iConvert.ISNull(idcSEND.GetCommandParamValue("X_RESULT_STATUS"));
                //X_RESULT_MSG = iConvert.ISNull(idcSEND.GetCommandParamValue("X_RESULT_MSG"));

                //if (idcSEND.ExcuteError || (X_RESULT_STATUS != string.Empty && X_RESULT_STATUS == "F"))
                //{
                //    isDataTransaction1.RollBack();
                //    MessageBoxAdv.Show(X_RESULT_MSG, "ERROR", MessageBoxButtons.OK, MessageBoxIcon.Error);
                //    return;
                //}

                //isDataTransaction1.Commit();

                //MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_10010", null), "SUCCESS", MessageBoxButtons.OK, MessageBoxIcon.Information);

                //IDA_ONHAND_PURCHASE_DTL.OraSelectData.AcceptChanges();
                //IDA_ONHAND_PURCHASE_DTL.Refillable = true;

                //IDA_ONHAND_PURCHASE_DTL.Fill();
            }
        }

        private void ibtSLIP_CANCEL_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            int vIDX_CHECK_YN = IGR_ONHAND_DISPOSAL_SLIP_Y.GetColumnToIndex("CHECK_YN");
            int vIDX_SLIP_INTERFACE_HEADER_ID = IGR_ONHAND_DISPOSAL_SLIP_Y.GetColumnToIndex("SLIP_INTERFACE_HEADER_ID"); 

            for (int vLoop = 0; vLoop < IGR_ONHAND_DISPOSAL_SLIP_Y.RowCount; vLoop++)
            {
                if (IGR_ONHAND_DISPOSAL_SLIP_Y.GetCellValue(vLoop, vIDX_CHECK_YN).ToString() == "Y")
                {
                    isDataTransaction1.BeginTran();

                    IDC_CANCEL_SLIP.SetCommandParamValue("W_SLIP_INTERFACE_HEADER_ID", IGR_ONHAND_DISPOSAL_SLIP_Y.GetCellValue(vLoop, vIDX_SLIP_INTERFACE_HEADER_ID));
                    IDC_CANCEL_SLIP.ExecuteNonQuery();

                    string X_RESULT_STATUS = iConvert.ISNull(IDC_CANCEL_SLIP.GetCommandParamValue("O_STATUS"));
                    string X_RESULT_MSG = iConvert.ISNull(IDC_CANCEL_SLIP.GetCommandParamValue("O_MESSAGE"));

                    if (IDC_CANCEL_SLIP.ExcuteError || (X_RESULT_STATUS != string.Empty && X_RESULT_STATUS == "F"))
                    {
                        isDataTransaction1.RollBack();
                        MessageBoxAdv.Show(X_RESULT_MSG, "ERROR", MessageBoxButtons.OK, MessageBoxIcon.Error);
                        return;
                    }

                    isDataTransaction1.Commit();
                }
            }

            MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_10010", null), "SUCCESS", MessageBoxButtons.OK, MessageBoxIcon.Information);

            IGR_ONHAND_DISPOSAL_SLIP_Y.LastConfirmChanges();
            IDA_ONHAND_DISPOSAL_SLIP_Y.OraSelectData.AcceptChanges();
            IDA_ONHAND_DISPOSAL_SLIP_Y.Refillable = true;

            IDA_ONHAND_DISPOSAL_SLIP_Y.Fill();          
        }
        
        private void isGridAdvEx1_CellDoubleClick(object pSender)
        {
            Show_Detail(IGR_ONHAND_DISPOSAL_SLIP_N.GetCellValue("INVOICE_NO")
                        , IGR_ONHAND_DISPOSAL_SLIP_N.GetCellValue("EXPORT_DOC_NUM")
                        , IGR_ONHAND_DISPOSAL_SLIP_N.GetCellValue("SHIP_DATE")
                        , IGR_ONHAND_DISPOSAL_SLIP_N.GetCellValue("BILL_TO_CUST_SITE_ID")); 
        }
         
        private void isGridAdvEx2_CurrentCellChanged(object pSender, ISGridAdvExChangedEventArgs e)
        {
            //Total_Computing_Amount();
        }

        private void isGridAdvEx3_CellDoubleClick(object pSender)
        {
            Show_Detail(IGR_ONHAND_DISPOSAL_SLIP_Y.GetCellValue("INVOICE_NO")
                        , IGR_ONHAND_DISPOSAL_SLIP_Y.GetCellValue("EXPORT_DOC_NUM")
                        , IGR_ONHAND_DISPOSAL_SLIP_Y.GetCellValue("SHIP_DATE")
                        , IGR_ONHAND_DISPOSAL_SLIP_Y.GetCellValue("CUSTOMER_ID")); 
        }
        
        #endregion;

        #region ----- MDi ToolBar Button Event ----

        private void isAppInterfaceAdv1_AppMainButtonClick(ISAppButtonEvents e)
        {
            if (this.IsActive)
            {
                if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Search)
                {
                    if (isTabAdv1.SelectedTab.TabIndex == 1)
                    {
                        IGR_ONHAND_DISPOSAL_SLIP_N.LastConfirmChanges();
                        IDA_ONHAND_DISPOSAL_SLIP_N.OraSelectData.AcceptChanges();
                        IDA_ONHAND_DISPOSAL_SLIP_N.Refillable = true;
                        
                        IDA_ONHAND_DISPOSAL_SLIP_N.Fill();
                    }
                    else if (isTabAdv1.SelectedTab.TabIndex == 2)
                    {
                        IGR_ONHAND_DISPOSAL_DTL.LastConfirmChanges();
                        IDA_ONHAND_DISPOSAL_DTL.OraSelectData.AcceptChanges();
                        IDA_ONHAND_DISPOSAL_DTL.Refillable = true;
                        
                        IDA_ONHAND_DISPOSAL_DTL.Fill();
                    }
                    else if (isTabAdv1.SelectedTab.TabIndex == 3)
                    {
                        IDA_ONHAND_DISPOSAL_SLIP_Y.OraSelectData.AcceptChanges();
                        IDA_ONHAND_DISPOSAL_SLIP_Y.Refillable = true;
                        IDA_ONHAND_DISPOSAL_SLIP_Y.Fill();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddOver)
                {
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddUnder)
                {
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Update)
                {
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Cancel)
                {
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Print)
                {
                    int vIndexTAB = isTabAdv1.SelectedIndex;

                    if (vIndexTAB == 2)
                    {
                        XLPrinting1("PRINT", IGR_ONHAND_DISPOSAL_SLIP_Y);
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Export)
                {
                    int vIndexTAB = isTabAdv1.SelectedIndex;

                    if (vIndexTAB == 2)
                    {
                        XLPrinting1("FILE", IGR_ONHAND_DISPOSAL_SLIP_Y);
                    }
                }
            }
        }

        #endregion;

        #region ----- XL Print 1 Methods ----

        private void XLPrinting1(string pOutChoice, InfoSummit.Win.ControlAdv.ISGridAdvEx pGrid)
        {
            string vMessageText = string.Empty;
            int vPageTotal = 0;
            int vPageNumber = 0;

            int vCountRowGrid = pGrid.RowCount;
            if (vCountRowGrid > 0)
            {
                vMessageText = string.Format("Printing Start");
                isAppInterfaceAdv1.AppInterface.OnAppMessageEvent(vMessageText);
                System.Windows.Forms.Application.DoEvents();


                System.Windows.Forms.Application.UseWaitCursor = true;
                this.Cursor = System.Windows.Forms.Cursors.WaitCursor;
                System.Windows.Forms.Application.DoEvents();


                int vIndexCheckBox = pGrid.GetColumnToIndex("CHECK_YN");
                string vCheckedString = pGrid.GridAdvExColElement[vIndexCheckBox].CheckedString;
                //-------------------------------------------------------------------------------------
                for (int vRow = 0; vRow < vCountRowGrid; vRow++)
                {
                    pGrid.CurrentCellMoveTo(vRow, vIndexCheckBox);
                    pGrid.Focus();
                    pGrid.CurrentCellActivate(vRow, vIndexCheckBox);

                    object vObject = pGrid.GetCellValue(vRow, vIndexCheckBox);
                    if (vObject != null)
                    {
                        bool IsConvert = vObject is string;
                        if (IsConvert == true)
                        {
                            string vBoxCheck = vObject as string;
                            if (vBoxCheck == vCheckedString)
                            {
                                int vCountRowTable = idaSLIP_LINE_PRINT.OraSelectData.Rows.Count;

                                if (vCountRowTable > 0)
                                {
                                    //-------------------------------------------------------------------------------------
                                    XLPrinting xlPrinting = new XLPrinting(isAppInterfaceAdv1.AppInterface);

                                    try
                                    {
                                        //-------------------------------------------------------------------------------------
                                        xlPrinting.OpenFileNameExcel = "PPMF0918_001.xls";
                                        xlPrinting.PrintingLineMAX = 57;         //������ ��µ� �� ����
                                        xlPrinting.IncrementCopyMAX = 67;        //���� ��Ʈ�� ����� �� ���μ�
                                        xlPrinting.PositionPrintLineSTART = 18;  //���� ��½� ���� ���� �� ��ġ ����
                                        xlPrinting.CopySumPrintingLine = 1;      //������ ���õ� ��Ʈ�� ����Ǿ��� ���� �� ��ġ
                                        //-------------------------------------------------------------------------------------

                                        //-------------------------------------------------------------------------------------
                                        bool isOpen = xlPrinting.XLFileOpen();
                                        //-------------------------------------------------------------------------------------

                                        if (isOpen == true)
                                        {
                                            //-------------------------------------------------------------------------------------
                                            xlPrinting.HeaderWrite(pGrid, vRow);

                                            object vObject_DEPT_ID = pGrid.GetCellValue("DEPT_ID");
                                            idaDOC_APPROVAL_LINE.SetSelectParamValue("W_DEPT_ID", vObject_DEPT_ID);
                                            idaDOC_APPROVAL_LINE.Fill();

                                            vPageNumber = xlPrinting.LineWrite(idaSLIP_LINE_PRINT, idaDOC_APPROVAL_LINE.OraSelectData);

                                            if (pOutChoice == "PRINT")
                                            {
                                                xlPrinting.Printing(1, vPageNumber); //���� ������ ��ȣ, ���� ������ ��ȣ
                                            }
                                            else if (pOutChoice == "FILE")
                                            {
                                                xlPrinting.Save("FL_");
                                            }
                                            //-------------------------------------------------------------------------------------
                                        }

                                        //-------------------------------------------------------------------------------------
                                        xlPrinting.Dispose();
                                        //-------------------------------------------------------------------------------------
                                    }
                                    catch (System.Exception ex)
                                    {
                                        string vMessage = ex.Message;
                                        xlPrinting.Dispose();
                                    }
                                    //-------------------------------------------------------------------------------------
                                }

                                vPageTotal = vPageTotal + vPageNumber;
                            }
                        }
                    }
                }
                //-------------------------------------------------------------------------------------
            }

            //-------------------------------------------------------------------------
            vMessageText = string.Format("Printing End [Total Page : {0}]", vPageTotal);
            isAppInterfaceAdv1.AppInterface.OnAppMessageEvent(vMessageText);
            System.Windows.Forms.Application.DoEvents();


            System.Windows.Forms.Application.UseWaitCursor = false;
            this.Cursor = System.Windows.Forms.Cursors.Default;
            System.Windows.Forms.Application.DoEvents();

            IDA_ONHAND_DISPOSAL_SLIP_Y.OraSelectData.AcceptChanges();
            IDA_ONHAND_DISPOSAL_SLIP_Y.Refillable = true;
        }

        #endregion;

    }
}