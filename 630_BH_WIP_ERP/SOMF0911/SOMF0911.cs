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

namespace SOMF0911
{
    public partial class SOMF0911 : Office2007Form
    {
        #region ----- Variables -----

        private ISCommonUtil.ISFunction.ISConvert iConvert = new ISFunction.ISConvert();
        private ISCommonUtil.ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        #endregion;

        #region ----- Constructor -----

        public SOMF0911(Form pMainForm, ISAppInterface pAppInterface)
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

            isGridAdvEx2.LastConfirmChanges();

            for (int vLoop = 0; vLoop < isGridAdvEx2.RowCount; vLoop++)
            {
                if (isGridAdvEx2.GetCellValue(vLoop, isGridAdvEx2.GetColumnToIndex("SELECT_FLAG")).ToString() == "Y")
                {
                    iedSLIP_AMOUNT.EditValue = Convert.ToDecimal(iedSLIP_AMOUNT.EditValue) +
                                                    Convert.ToDecimal(isGridAdvEx2.GetCellValue(vLoop, isGridAdvEx2.GetColumnToIndex("ADJUST_AMOUNT")));

                    iedTAX_AMOUNT.EditValue = Convert.ToDecimal(iedTAX_AMOUNT.EditValue) +
                                                    Convert.ToDecimal(isGridAdvEx2.GetCellValue(vLoop, isGridAdvEx2.GetColumnToIndex("ADJUST_TAX_AMOUNT")));

                    //if ((isGridAdvEx2.GetCellValue(vLoop, isGridAdvEx2.GetColumnToIndex("JOB_CATEGORY_CD")).ToString() == "SAL01") ||  (isGridAdvEx2.GetCellValue(vLoop, isGridAdvEx2.GetColumnToIndex("JOB_CATEGORY_CD")).ToString() == "SAL02"))
                    //{
                    //    iedTAX_AMOUNT.EditValue = System.Math.Truncate(Convert.ToDecimal(iedSLIP_AMOUNT.EditValue) / 10);
                    //}
                }
            }            
        }

        #endregion;

        #region ----- Events -----

        private void SOMF0911_Load(object sender, EventArgs e)
        {
            idaCUST.FillSchema();
            idaCUST_D.FillSchema();
            idaCANCEL.FillSchema();

            iedSLIP_DATE.EditValue = iDate.ISMonth_Last(DateTime.Today, -1);
            iedEXPECT_DATE.EditValue = iDate.ISMonth_Last(DateTime.Today);

        }

        // PERIOD LOOKUP 선택시 동작 //
        private void ilaPERIOD_SelectedRowData(object pSender)
        {
            if (isTabAdv1.SelectedTab.TabIndex == 1)
            {
                idaCUST.Fill();
            }
            else if (isTabAdv1.SelectedTab.TabIndex == 3)
            {
                idaCANCEL.Fill();
            }
        }

        private void ilaPERIOD_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildPERIOD.SetLookupParamValue("W_CLOSE_TYPE", Convert.ToString("SHIP_ADJ"));

        }

        private void icbSELECT_ALL_CheckedChange(object pSender, ISCheckEventArgs e)
        {
            for (int vLoop = 0; vLoop < isGridAdvEx1.RowCount; vLoop++)
            {
                isGridAdvEx1.SetCellValue(vLoop, 0, icbSELECT_ALL.CheckBoxValue.ToString());
                idaCUST.OraSelectData.AcceptChanges();
                idaCUST.Refillable = true;
            }
        }

        private void icbSELECT_ALL_P_CheckedChange(object pSender, ISCheckEventArgs e)
        {
            for (int vLoop = 0; vLoop < isGridAdvEx2.RowCount; vLoop++)
            {
                isGridAdvEx2.SetCellValue(vLoop, 0, icbSELECT_ALL_P.CheckBoxValue.ToString());
                idaCUST_D.OraSelectData.AcceptChanges();
                idaCUST_D.Refillable = true;
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

                        idcTARGET.SetCommandParamValue("W_BILL_TO_CUST_SITE_ID", isGridAdvEx1.GetCellValue(vLoop, isGridAdvEx1.GetColumnToIndex("BILL_TO_CUST_SITE_ID")));
                        idcTARGET.SetCommandParamValue("W_SHIPMENT_DATE", isGridAdvEx1.GetCellValue(vLoop, isGridAdvEx1.GetColumnToIndex("SHIPMENT_DATE")));
                        idcTARGET.SetCommandParamValue("W_JOB_CATEGORY_CD", isGridAdvEx1.GetCellValue(vLoop, isGridAdvEx1.GetColumnToIndex("JOB_CATEGORY_CD")));
                        idcTARGET.SetCommandParamValue("W_ADJUST_TRX_ID", null);
                        idcTARGET.ExecuteNonQuery();

                        X_RESULT_STATUS = iConvert.ISNull(idcTARGET.GetCommandParamValue("X_RESULT_STATUS"));
                        X_RESULT_MSG = iConvert.ISNull(idcTARGET.GetCommandParamValue("X_RESULT_MSG"));

                        if (idcTARGET.ExcuteError || (X_RESULT_STATUS != string.Empty && X_RESULT_STATUS == "F"))
                        {
                            isDataTransaction1.RollBack();
                            MessageBoxAdv.Show(X_RESULT_MSG, "ERROR", MessageBoxButtons.OK, MessageBoxIcon.Error);
                            return;
                        }

                        idcSEND.SetCommandParamValue("P_BILL_TO_CUST_SITE_ID", isGridAdvEx1.GetCellValue(vLoop, isGridAdvEx1.GetColumnToIndex("BILL_TO_CUST_SITE_ID")));
                        idcSEND.SetCommandParamValue("P_ADJUST_TAX_AMOUNT", isGridAdvEx1.GetCellValue(vLoop, isGridAdvEx1.GetColumnToIndex("TOTAL_SLIP_TAX_AMOUNT")));
                        idcSEND.SetCommandParamValue("P_EXPORT_REG_NO", isGridAdvEx1.GetCellValue(vLoop, isGridAdvEx1.GetColumnToIndex("EXPORT_REG_NO")));
                        idcSEND.SetCommandParamValue("P_SLIP_REMARKS", isGridAdvEx1.GetCellValue(vLoop, isGridAdvEx1.GetColumnToIndex("SLIP_REMARKS")));
                        idcSEND.SetCommandParamValue("P_JOB_CATEGORY_CD", isGridAdvEx1.GetCellValue(vLoop, isGridAdvEx1.GetColumnToIndex("JOB_CATEGORY_CD")));
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

                idaCUST.OraSelectData.AcceptChanges();
                idaCUST.Refillable = true;

                idaCUST.Fill();
            }
            else if (isTabAdv1.SelectedTab.TabIndex == 2)
            {
                isDataTransaction1.BeginTran();

                for (int vLoop = 0; vLoop < isGridAdvEx2.RowCount; vLoop++)
                {
                    if (isGridAdvEx2.GetCellValue(vLoop, isGridAdvEx2.GetColumnToIndex("SELECT_FLAG")).ToString() == "Y")
                    {
                        idcTARGET.SetCommandParamValue("W_BILL_TO_CUST_SITE_ID", isGridAdvEx2.GetCellValue(vLoop, isGridAdvEx2.GetColumnToIndex("BILL_TO_CUST_SITE_ID")));
                        idcTARGET.SetCommandParamValue("W_ADJUST_CUST_ID", isGridAdvEx2.GetCellValue(vLoop, isGridAdvEx2.GetColumnToIndex("ADJUST_CUST_ID")));
                        idcTARGET.SetCommandParamValue("W_JOB_CATEGORY_CD", isGridAdvEx2.GetCellValue(vLoop, isGridAdvEx2.GetColumnToIndex("JOB_CATEGORY_CD")));
                        idcTARGET.SetCommandParamValue("W_ADJUST_TRX_ID", isGridAdvEx2.GetCellValue(vLoop, isGridAdvEx2.GetColumnToIndex("ADJUST_TRX_ID")));
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

                idcSEND.SetCommandParamValue("P_BILL_TO_CUST_SITE_ID", isGridAdvEx1.GetCellValue("BILL_TO_CUST_SITE_ID"));
                idcSEND.SetCommandParamValue("P_ADJUST_TAX_AMOUNT", iedTAX_AMOUNT.EditValue);
                idcSEND.SetCommandParamValue("P_EXPORT_REG_NO", iedEXPORT_REG_NO.EditValue);
                idcSEND.SetCommandParamValue("P_SLIP_REMARKS", iedSLIP_REMARKS.EditValue);
                idcSEND.SetCommandParamValue("P_JOB_CATEGORY_CD", isGridAdvEx1.GetCellValue("JOB_CATEGORY_CD"));
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

                idaCUST_D.OraSelectData.AcceptChanges();
                idaCUST_D.Refillable = true;

                idaCUST_D.Fill();
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

            if (isGridAdvEx1.GetCellValue("JOB_CATEGORY_CD").ToString() == "SAL04")
            {
                iedEXPORT_REG_NO.EditValue = "";
                iedEXPORT_REG_NO.Visible = true;
            }
            else
            {
                iedEXPORT_REG_NO.EditValue = "";
                iedEXPORT_REG_NO.Visible = false;
            }

            iedSLIP_REMARKS.EditValue = "";

            Total_Computing_Amount();

            idaCUST_D.OraSelectData.AcceptChanges();
            idaCUST_D.Refillable = true;
        }

        private void isGridAdvEx2_CurrentCellChanged(object pSender, ISGridAdvExChangedEventArgs e)
        {
            Total_Computing_Amount();
        }

        private void ibtSEARCH_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            idaCUST_D.OraSelectData.AcceptChanges();
            idaCUST_D.Refillable = true;
            idaCUST_D.Fill();
        }

        private void isGridAdvEx1_CellMoved(object pSender, ISGridAdvExCellClickEventArgs e)
        {
            iedSLIP_DATE.EditValue = isGridAdvEx1.GetCellValue("SHIPMENT_DATE");
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
                        idaCUST.OraSelectData.AcceptChanges();
                        idaCUST.Refillable = true;
                        idaCUST.Fill();
                    }
                    else if (isTabAdv1.SelectedTab.TabIndex == 2)
                    {
                        idaCUST_D.OraSelectData.AcceptChanges();
                        idaCUST_D.Refillable = true;
                        idaCUST_D.Fill();
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

                object vSLIP_NUM = pGrid.GetCellValue("SLIP_NUM");
                object vHEADER_IF_ID = pGrid.GetCellValue("HEADER_INTERFACE_ID");
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
                                        xlPrinting.OpenFileNameExcel = "SOMF0911_001.xls";
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
                                            object vObject_SLIP_DATE = pGrid.GetCellValue("SLIP_DATE");

                                            //현업 결재라인//
                                            idaDOC_APPROVAL_LINE.SetSelectParamValue("W_STD_DATE", vObject_SLIP_DATE);
                                            idaDOC_APPROVAL_LINE.SetSelectParamValue("W_DEPT_ID", vObject_DEPT_ID);
                                            idaDOC_APPROVAL_LINE.Fill();

                                            //재경 결재라인//
                                            IDA_DOC_APPROVAL_LINE_FI.SetSelectParamValue("W_STD_DATE", vObject_SLIP_DATE);
                                            IDA_DOC_APPROVAL_LINE_FI.SetSelectParamValue("W_DEPT_ID", vObject_DEPT_ID);
                                            IDA_DOC_APPROVAL_LINE_FI.SetSelectParamValue("W_FI_DEPT_FLAG", "Y");
                                            IDA_DOC_APPROVAL_LINE_FI.Fill();

                                            vPageNumber = xlPrinting.LineWrite(idaSLIP_LINE_PRINT, idaDOC_APPROVAL_LINE.OraSelectData, IDA_DOC_APPROVAL_LINE_FI.OraSelectData);

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