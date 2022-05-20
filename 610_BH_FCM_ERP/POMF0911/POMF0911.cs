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

namespace POMF0911
{
    public partial class POMF0911 : Office2007Form
    {
        #region ----- Variables -----

        private ISCommonUtil.ISFunction.ISConvert iConvert = new ISFunction.ISConvert();
        private ISCommonUtil.ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        #endregion;

        #region ----- Constructor -----

        public POMF0911(Form pMainForm, ISAppInterface pAppInterface)
        {
            InitializeComponent();
            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;
        }

        #endregion;

        #region ----- Private Methods ----

        private void Total_Computing_Amount()
        {
            iedSLIP_AMOUNT.EditValue = (int)0;
            iedTAX_AMOUNT.EditValue = (int)0;
            iedAMOUNT_1.EditValue = (int)0;
            iedAMOUNT_2.EditValue = (int)0;
            iedAMOUNT_3.EditValue = (int)0;
            iedAMOUNT_4.EditValue = (int)0;
            iedAMOUNT_5.EditValue = (int)0;

            isGridAdvEx2.LastConfirmChanges();

            for (int vLoop = 0; vLoop < isGridAdvEx2.RowCount; vLoop++)
            {
                if (isGridAdvEx2.GetCellValue(vLoop, isGridAdvEx2.GetColumnToIndex("SELECT_FLAG")).ToString() == "Y")
                {
                    iedSLIP_AMOUNT.EditValue = Convert.ToDecimal(iedSLIP_AMOUNT.EditValue) +
                                                    Convert.ToDecimal(isGridAdvEx2.GetCellValue(vLoop, isGridAdvEx2.GetColumnToIndex("ADJUST_AMOUNT")));

                    iedTAX_AMOUNT.EditValue = System.Math.Truncate(Convert.ToDecimal(iedSLIP_AMOUNT.EditValue) / 10);

                    if (isGridAdvEx2.GetCellValue(vLoop, isGridAdvEx2.GetColumnToIndex("ACCOUNT_CODE")).ToString() == "1120400")
                    {
                        iedAMOUNT_1.EditValue = Convert.ToDecimal(iedAMOUNT_1.EditValue) +
                                                    Convert.ToDecimal(isGridAdvEx2.GetCellValue(vLoop, isGridAdvEx2.GetColumnToIndex("ADJUST_AMOUNT")));
                    }
                    else if (isGridAdvEx2.GetCellValue(vLoop, isGridAdvEx2.GetColumnToIndex("ACCOUNT_CODE")).ToString() == "5132001")
                    {
                        iedAMOUNT_2.EditValue = Convert.ToDecimal(iedAMOUNT_2.EditValue) +
                                                    Convert.ToDecimal(isGridAdvEx2.GetCellValue(vLoop, isGridAdvEx2.GetColumnToIndex("ADJUST_AMOUNT")));
                    }
                    else if (isGridAdvEx2.GetCellValue(vLoop, isGridAdvEx2.GetColumnToIndex("ACCOUNT_CODE")).ToString() == "1220300")
                    {
                        iedAMOUNT_3.EditValue = Convert.ToDecimal(iedAMOUNT_3.EditValue) +
                                                    Convert.ToDecimal(isGridAdvEx2.GetCellValue(vLoop, isGridAdvEx2.GetColumnToIndex("ADJUST_AMOUNT")));
                    }
                    else if (isGridAdvEx2.GetCellValue(vLoop, isGridAdvEx2.GetColumnToIndex("ACCOUNT_CODE")).ToString() == "1120200")
                    {
                        iedAMOUNT_4.EditValue = Convert.ToDecimal(iedAMOUNT_4.EditValue) +
                                                    Convert.ToDecimal(isGridAdvEx2.GetCellValue(vLoop, isGridAdvEx2.GetColumnToIndex("ADJUST_AMOUNT")));
                    }
                    else if (isGridAdvEx2.GetCellValue(vLoop, isGridAdvEx2.GetColumnToIndex("ACCOUNT_CODE")).ToString() == "5131503")
                    {
                        iedAMOUNT_5.EditValue = Convert.ToDecimal(iedAMOUNT_5.EditValue) +
                                                    Convert.ToDecimal(isGridAdvEx2.GetCellValue(vLoop, isGridAdvEx2.GetColumnToIndex("ADJUST_AMOUNT")));
                    }
                }
            }            
        }

        #endregion;

        #region ----- Events -----

        private void POMF0911_Load(object sender, EventArgs e)
        {
            idaSUPPLIER.FillSchema();
            idaSUPPLIER_D.FillSchema();
            idaCANCEL.FillSchema();

            iedSLIP_DATE.EditValue = iDate.ISMonth_Last(DateTime.Today, -1);
            iedEXPECT_DATE.EditValue = iDate.ISMonth_Last(DateTime.Today, 1);

        }

        // PERIOD LOOKUP 선택시 동작 //
        private void ilaPERIOD_SelectedRowData(object pSender)
        {
            if (isTabAdv1.SelectedTab.TabIndex == 1)
            {
                idaSUPPLIER.Fill();
            }
            else if (isTabAdv1.SelectedTab.TabIndex == 3)
            {
                idaCANCEL.Fill();
            }
        }

        private void ilaPERIOD_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildPERIOD.SetLookupParamValue("W_CLOSE_TYPE", Convert.ToString("PO_ADJ"));

        }

        private void icbSELECT_ALL_CheckedChange(object pSender, ISCheckEventArgs e)
        {
            for (int vLoop = 0; vLoop < isGridAdvEx1.RowCount; vLoop++)
            {
                isGridAdvEx1.SetCellValue(vLoop, 0, icbSELECT_ALL.CheckBoxValue.ToString());
                idaSUPPLIER.OraSelectData.AcceptChanges();
                idaSUPPLIER.Refillable = true;
            }
        }

        private void icbSELECT_ALL_P_CheckedChange(object pSender, ISCheckEventArgs e)
        {
            for (int vLoop = 0; vLoop < isGridAdvEx2.RowCount; vLoop++)
            {
                isGridAdvEx2.SetCellValue(vLoop, 0, icbSELECT_ALL_P.CheckBoxValue.ToString());
                idaSUPPLIER_D.OraSelectData.AcceptChanges();
                idaSUPPLIER_D.Refillable = true;
            }

            Total_Computing_Amount();
        }

        private void icbSELECT_ALL_C_CheckedChange(object pSender, ISCheckEventArgs e)
        {
            for (int vLoop = 0; vLoop < isGridAdvEx3.RowCount; vLoop++)
            {
                isGridAdvEx3.SetCellValue(vLoop, 0, icbSELECT_ALL_C.CheckBoxValue.ToString());
                idaCANCEL.OraSelectData.AcceptChanges();
                idaCANCEL.Refillable = true;
            }
        }

        private void ibtSLIP_SEND_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            string X_RESULT_STATUS;
            string X_RESULT_MSG;

            if (isTabAdv1.SelectedTab.TabIndex == 1)
            {
                for (int vLoop = 0; vLoop < isGridAdvEx1.RowCount; vLoop++)
                {
                    if (isGridAdvEx1.GetCellValue(vLoop, isGridAdvEx1.GetColumnToIndex("SELECT_FLAG")).ToString() == "Y")
                    {
                        isDataTransaction1.BeginTran();

                        idcTARGET.SetCommandParamValue("W_SUPPLIER_ID", isGridAdvEx1.GetCellValue(vLoop, isGridAdvEx1.GetColumnToIndex("SUPPLIER_ID")));
                        idcTARGET.SetCommandParamValue("W_INVENTORY_ITEM_ID", null);
                        idcTARGET.SetCommandParamValue("W_ADJUST_TRX_ID", null);
                        idcTARGET.SetCommandParamValue("W_ACCOUNT_CODE", isGridAdvEx1.GetCellValue(vLoop, isGridAdvEx1.GetColumnToIndex("ACCOUNT_CODE")));
                        idcTARGET.ExecuteNonQuery();

                        X_RESULT_STATUS = iConvert.ISNull(idcTARGET.GetCommandParamValue("X_RESULT_STATUS"));
                        X_RESULT_MSG = iConvert.ISNull(idcTARGET.GetCommandParamValue("X_RESULT_MSG"));

                        if (idcTARGET.ExcuteError || (X_RESULT_STATUS != string.Empty && X_RESULT_STATUS == "F"))
                        {
                            isDataTransaction1.RollBack();
                            MessageBoxAdv.Show(X_RESULT_MSG, "ERROR", MessageBoxButtons.OK, MessageBoxIcon.Error);
                            return;
                        }

                        idcSEND.SetCommandParamValue("P_SUPPLIER_ID", isGridAdvEx1.GetCellValue(vLoop, isGridAdvEx1.GetColumnToIndex("SUPPLIER_ID")));
                        idcSEND.SetCommandParamValue("P_ADJUST_TAX_AMOUNT", isGridAdvEx1.GetCellValue(vLoop, isGridAdvEx1.GetColumnToIndex("TOTAL_SLIP_TAX_AMOUNT")));
                        idcSEND.ExecuteNonQuery();

                        X_RESULT_STATUS = iConvert.ISNull(idcSEND.GetCommandParamValue("X_RESULT_STATUS"));
                        X_RESULT_MSG = iConvert.ISNull(idcSEND.GetCommandParamValue("X_RESULT_MSG"));

                        if (idcSEND.ExcuteError || (X_RESULT_STATUS != string.Empty && X_RESULT_STATUS == "F"))
                        {
                            isDataTransaction1.RollBack();
                            MessageBoxAdv.Show(X_RESULT_MSG, "ERROR", MessageBoxButtons.OK, MessageBoxIcon.Error);
                            return;
                        }

                        isDataTransaction1.Commit();
                    }
                }

                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_10010", null), "SUCCESS", MessageBoxButtons.OK, MessageBoxIcon.Information);

                idaSUPPLIER.OraSelectData.AcceptChanges();
                idaSUPPLIER.Refillable = true;

                idaSUPPLIER.Fill();
            }
            else if (isTabAdv1.SelectedTab.TabIndex == 2)
            {
                isDataTransaction1.BeginTran();

                for (int vLoop = 0; vLoop < isGridAdvEx2.RowCount; vLoop++)
                {
                    if (isGridAdvEx2.GetCellValue(vLoop, isGridAdvEx2.GetColumnToIndex("SELECT_FLAG")).ToString() == "Y")
                    {
                        idcTARGET.SetCommandParamValue("W_SUPPLIER_ID", isGridAdvEx2.GetCellValue(vLoop, isGridAdvEx2.GetColumnToIndex("SUPPLIER_ID")));
                        idcTARGET.SetCommandParamValue("W_INVENTORY_ITEM_ID", isGridAdvEx2.GetCellValue(vLoop, isGridAdvEx2.GetColumnToIndex("INVENTORY_ITEM_ID")));
                        idcTARGET.SetCommandParamValue("W_ADJUST_TRX_ID", isGridAdvEx2.GetCellValue(vLoop, isGridAdvEx2.GetColumnToIndex("ADJUST_TRX_ID")));
                        idcTARGET.SetCommandParamValue("W_ACCOUNT_CODE", isGridAdvEx2.GetCellValue(vLoop, isGridAdvEx2.GetColumnToIndex("ACCOUNT_CODE")));
                        idcTARGET.ExecuteNonQuery();

                        X_RESULT_STATUS = iConvert.ISNull(idcTARGET.GetCommandParamValue("X_RESULT_STATUS"));
                        X_RESULT_MSG = iConvert.ISNull(idcTARGET.GetCommandParamValue("X_RESULT_MSG"));

                        if (idcTARGET.ExcuteError || (X_RESULT_STATUS != string.Empty && X_RESULT_STATUS == "F"))
                        {
                            isDataTransaction1.RollBack();
                            MessageBoxAdv.Show(X_RESULT_MSG, "ERROR", MessageBoxButtons.OK, MessageBoxIcon.Error);
                            return;
                        }
                    }
                }

                idcSEND.SetCommandParamValue("P_SUPPLIER_ID", isGridAdvEx1.GetCellValue("SUPPLIER_ID"));
                idcSEND.SetCommandParamValue("P_ADJUST_TAX_AMOUNT", iedTAX_AMOUNT.EditValue);
                idcSEND.ExecuteNonQuery();

                X_RESULT_STATUS = iConvert.ISNull(idcSEND.GetCommandParamValue("X_RESULT_STATUS"));
                X_RESULT_MSG = iConvert.ISNull(idcSEND.GetCommandParamValue("X_RESULT_MSG"));

                if (idcSEND.ExcuteError || (X_RESULT_STATUS != string.Empty && X_RESULT_STATUS == "F"))
                {
                    isDataTransaction1.RollBack();
                    MessageBoxAdv.Show(X_RESULT_MSG, "ERROR", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    return;
                }

                isDataTransaction1.Commit();

                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_10010", null), "SUCCESS", MessageBoxButtons.OK, MessageBoxIcon.Information);

                idaSUPPLIER_D.OraSelectData.AcceptChanges();
                idaSUPPLIER_D.Refillable = true;

                idaSUPPLIER_D.Fill();
            }
        }

        private void ibtSLIP_CANCEL_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            for (int vLoop = 0; vLoop < isGridAdvEx3.RowCount; vLoop++)
            {
                if (isGridAdvEx3.GetCellValue(vLoop, isGridAdvEx3.GetColumnToIndex("SELECT_FLAG")).ToString() == "Y")
                {
                    isDataTransaction1.BeginTran();

                    idcCANCEL.SetCommandParamValue("W_SLIP_NUM", isGridAdvEx3.GetCellValue(vLoop, isGridAdvEx3.GetColumnToIndex("SLIP_NUM")));
                    idcCANCEL.ExecuteNonQuery();

                    string X_RESULT_STATUS = iConvert.ISNull(idcCANCEL.GetCommandParamValue("X_RESULT_STATUS"));
                    string X_RESULT_MSG = iConvert.ISNull(idcCANCEL.GetCommandParamValue("X_RESULT_MSG"));

                    if (idcCANCEL.ExcuteError || (X_RESULT_STATUS != string.Empty && X_RESULT_STATUS == "F"))
                    {
                        isDataTransaction1.RollBack();
                        MessageBoxAdv.Show(X_RESULT_MSG, "ERROR", MessageBoxButtons.OK, MessageBoxIcon.Error);
                        return;
                    }

                    isDataTransaction1.Commit();
                }
            }

            MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_10010", null), "SUCCESS", MessageBoxButtons.OK, MessageBoxIcon.Information);

            idaCANCEL.OraSelectData.AcceptChanges();
            idaCANCEL.Refillable = true;

            idaCANCEL.Fill();          
        }
        
        private void isGridAdvEx1_CellDoubleClick(object pSender)
        {
            isTabAdv1.SelectedIndex = 1;
            isTabAdv1.SelectedTab.Focus();

            Total_Computing_Amount();

            idaSUPPLIER_D.OraSelectData.AcceptChanges();
            idaSUPPLIER_D.Refillable = true;
        }

        private void isGridAdvEx2_CurrentCellChanged(object pSender, ISGridAdvExChangedEventArgs e)
        {
            Total_Computing_Amount();
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
                        idaSUPPLIER.OraSelectData.AcceptChanges();
                        idaSUPPLIER.Refillable = true;
                        idaSUPPLIER.Fill();
                    }
                    else if (isTabAdv1.SelectedTab.TabIndex == 2)
                    {
                        idaSUPPLIER_D.OraSelectData.AcceptChanges();
                        idaSUPPLIER_D.Refillable = true;
                        idaSUPPLIER_D.Fill();
                    }
                    else if (isTabAdv1.SelectedTab.TabIndex == 3)
                    {
                        idaCANCEL.OraSelectData.AcceptChanges();
                        idaCANCEL.Refillable = true;
                        idaCANCEL.Fill();
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
                        XLPrinting1("PRINT", isGridAdvEx3);
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Export)
                {
                    int vIndexTAB = isTabAdv1.SelectedIndex;

                    if (vIndexTAB == 2)
                    {
                        XLPrinting1("FILE", isGridAdvEx3);
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


                int vIndexCheckBox = pGrid.GetColumnToIndex("SELECT_FLAG");
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
                                        xlPrinting.OpenFileNameExcel = "POMF0911_001.xls";
                                        xlPrinting.PrintingLineMAX = 57;         //엑셀에 출력될 총 라인
                                        xlPrinting.IncrementCopyMAX = 67;        //엑셀 쉬트에 복사될 총 라인수
                                        xlPrinting.PositionPrintLineSTART = 18;  //라인 출력시 엑셀 시작 행 위치 지정
                                        xlPrinting.CopySumPrintingLine = 1;      //엑셀의 선택된 쉬트의 복사되어질 시작 행 위치
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
                                                xlPrinting.Printing(1, vPageNumber); //시작 페이지 번호, 종료 페이지 번호
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

            idaCANCEL.OraSelectData.AcceptChanges();
            idaCANCEL.Refillable = true;
        }

        #endregion;
        
    }
}