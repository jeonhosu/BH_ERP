using System;
using System.Data;
using System.Drawing;
using System.Windows.Forms;
using System.Collections.Generic;

using Syncfusion.Windows.Forms;
using Syncfusion.Windows.Forms.Tools;
using Syncfusion.Windows.Forms.Grid;
using InfoSummit.Win.ControlAdv;
using ISCommonUtil;

namespace FCMF0219
{
    public partial class FCMF0219 : Office2007Form
    {
        #region ----- Variables -----

        ISFunction.ISConvert iString = new ISFunction.ISConvert();
        ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        #endregion;

        #region ----- Constructor -----

        public FCMF0219()
        {
            InitializeComponent();
        }

        public FCMF0219(Form pMainForm, ISAppInterface pAppInterface)
        {
            InitializeComponent();
            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;
        }

        #endregion;

        #region ----- Private Methods ----

        private void Search_DB()
        {
            idaSLIP_LIST_IF.Fill();
            igrSLIP_LIST_IF.Focus();
        }

        private void SetCommonParameter(string pGroup_Code, string pEnabled_YN)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", pGroup_Code);
            ildCOMMON.SetLookupParamValue("W_ENABLED_YN", pEnabled_YN);
        }

        private DateTime GetDate()
        {
            DateTime vDateTime = DateTime.Today;

            try
            {
                idcGetDate.ExecuteNonQuery();
                object vObject = idcGetDate.GetCommandParamValue("X_LOCAL_DATE");

                bool isConvert = vObject is DateTime;
                if (isConvert == true)
                {
                    vDateTime = (DateTime)vObject;
                }
            }
            catch (Exception ex)
            {
                string vMessage = ex.Message;
                vDateTime = new DateTime(9999, 12, 31, 23, 59, 59);
            }
            return vDateTime;
        }

        private void DefaultSetDate1()
        {
            DateTime vGetDateTime = GetDate();

            ISCommonUtil.ISFunction.ISDateTime vDate = new ISCommonUtil.ISFunction.ISDateTime();
            DateTime vMonthFirstDay = vDate.ISMonth_1st(vGetDateTime);

            SLIP_DATE_FR_0.EditValue = vMonthFirstDay;
            SLIP_DATE_TO_0.EditValue = vGetDateTime;
        }

        #endregion;

        #region ----- XL Print 1 Methods ----

        private void XLPrinting1(string pOutChoice)
        {
            string vMessageText = string.Empty;
            int vPageTotal = 0;
            int vPageNumber = 0;

            int vCountRowGrid = igrSLIP_LIST_IF.RowCount;
            if (vCountRowGrid > 0)
            {
                vMessageText = string.Format("Print Starting...");
                isAppInterfaceAdv1.AppInterface.OnAppMessageEvent(vMessageText);
                System.Windows.Forms.Application.DoEvents();


                System.Windows.Forms.Application.UseWaitCursor = true;
                this.Cursor = System.Windows.Forms.Cursors.WaitCursor;
                System.Windows.Forms.Application.DoEvents();


                int vIndexCheckBox = igrSLIP_LIST_IF.GetColumnToIndex("CHECK_BOX");
                string vCheckedString = igrSLIP_LIST_IF.GridAdvExColElement[vIndexCheckBox].CheckedString;
                //-------------------------------------------------------------------------------------
                for (int vRow = 0; vRow < vCountRowGrid; vRow++)
                {
                    igrSLIP_LIST_IF.CurrentCellMoveTo(vRow, vIndexCheckBox);
                    igrSLIP_LIST_IF.Focus();
                    igrSLIP_LIST_IF.CurrentCellActivate(vRow, vIndexCheckBox);

                    object vObject = igrSLIP_LIST_IF.GetCellValue(vRow, vIndexCheckBox);
                    if (vObject != null)
                    {
                        bool IsConvert = vObject is string;
                        if (IsConvert == true)
                        {
                            string vBoxCheck = vObject as string;
                            if (vBoxCheck == vCheckedString)
                            {
                                //-------------------------------------------------------------------------------------
                                XLPrinting xlPrinting = new XLPrinting(isAppInterfaceAdv1.AppInterface);

                                try
                                {
                                    //-------------------------------------------------------------------------------------
                                    xlPrinting.OpenFileNameExcel = "FCMF0219_001.xls";
                                    xlPrinting.PrintingLineMAX = 57;         //엑셀에 출력될 총 라인
                                    xlPrinting.IncrementCopyMAX = 67;        //엑셀 쉬트에 복사될 총 라인수
                                    xlPrinting.PositionPrintLineSTART = 18;  //라인 출력시 엑셀 시작 행 위치 지정
                                    xlPrinting.CopySumPrintingLine = 1;      //엑셀의 선택된 쉬트의 복사되어질 시작 행 위치
                                    //-------------------------------------------------------------------------------------

                                    vMessageText = string.Format("XL Opening...");
                                    isAppInterfaceAdv1.AppInterface.OnAppMessageEvent(vMessageText);
                                    System.Windows.Forms.Application.DoEvents();

                                    //-------------------------------------------------------------------------------------
                                    bool isOpen = xlPrinting.XLFileOpen();
                                    //-------------------------------------------------------------------------------------

                                    if (isOpen == true)
                                    {
                                        //-------------------------------------------------------------------------------------
                                        xlPrinting.HeaderWrite(igrSLIP_LIST_IF, vRow);

                                        object vObject_SLIP_DATE = igrSLIP_LIST_IF.GetCellValue("SLIP_DATE");
                                        object vObject_DEPT_ID = igrSLIP_LIST_IF.GetCellValue("DEPT_ID");

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
                                            xlPrinting.Printing(1, vPageNumber);
                                        }
                                        else if (pOutChoice == "FILE")
                                        {
                                            xlPrinting.Save("SLIP_");
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

                                vPageTotal = vPageTotal + vPageNumber;
                            }
                        }
                    }
                }
                //-------------------------------------------------------------------------------------
            }

            //-------------------------------------------------------------------------
            vMessageText = string.Format("Print End [Tatal Page : {0}]", vPageTotal);
            isAppInterfaceAdv1.AppInterface.OnAppMessageEvent(vMessageText);
            System.Windows.Forms.Application.DoEvents();


            System.Windows.Forms.Application.UseWaitCursor = false;
            this.Cursor = System.Windows.Forms.Cursors.Default;
            System.Windows.Forms.Application.DoEvents();

            idaSLIP_LIST_IF.OraSelectData.AcceptChanges();
            idaSLIP_LIST_IF.Refillable = true;
        }

        #endregion;

        #region ----- Initialize Event -----

        private void Init_GL_Amount()
        {
            GL_AMOUNT.EditValue = iString.ISDecimaltoZero(GL_CURRENCY_AMOUNT.EditValue) * iString.ISDecimaltoZero(EXCHANGE_RATE.EditValue);
        }

        private void Init_DR_CR_Amount()
        {
            SLIP_QUERY_STATUS.EditValue = "NON-QUERY";
            if (igrSLIP_LINE.RowCount > 0)
            {
            }
            Init_Total_GL_Amount();
        }

        private void Init_Total_GL_Amount()
        {
            SLIP_QUERY_STATUS.EditValue = "NON-QUERY";
            decimal vDR_Amount = Convert.ToDecimal(0);
            decimal vCR_Amount = Convert.ToDecimal(0);
            decimal vCurrency_DR_Amount = Convert.ToInt32(0);
            if (igrSLIP_LINE.RowCount > 0)
            {
                for (int r = 0; r < igrSLIP_LINE.RowCount; r++)
                {
                    if (iString.ISNull(igrSLIP_LINE.GetCellValue(r, igrSLIP_LINE.GetColumnToIndex("ACCOUNT_DR_CR")), "3") == "1".ToString())
                    {
                        vDR_Amount = vDR_Amount + iString.ISDecimaltoZero(igrSLIP_LINE.GetCellValue(r, igrSLIP_LINE.GetColumnToIndex("GL_AMOUNT")));
                        vCurrency_DR_Amount = vCurrency_DR_Amount + iString.ISDecimaltoZero(igrSLIP_LINE.GetCellValue(r, igrSLIP_LINE.GetColumnToIndex("GL_CURRENCY_AMOUNT")));
                    }
                    else if (iString.ISNull(igrSLIP_LINE.GetCellValue(r, igrSLIP_LINE.GetColumnToIndex("ACCOUNT_DR_CR")), "3") == "2".ToString())
                    {
                        vCR_Amount = vCR_Amount + iString.ISDecimaltoZero(igrSLIP_LINE.GetCellValue(r, igrSLIP_LINE.GetColumnToIndex("GL_AMOUNT")));
                    }
                }
            }       
            TOTAL_DR_AMOUNT.EditValue = iString.ISDecimaltoZero(vDR_Amount);
            TOTAL_CR_AMOUNT.EditValue = iString.ISDecimaltoZero(vCR_Amount);
            MARGIN_AMOUNT.EditValue = -(System.Math.Abs(iString.ISDecimaltoZero(vDR_Amount) - iString.ISDecimaltoZero(vCR_Amount))); ;
        }

        private void Init_Set_Item_Prompt(DataRow pDataRow)
        {// edit 데이터 형식, 사용여부 변경.
            if (pDataRow == null)
            {
                return;
            }
            ///////////////////////////////////////////////////////////////////////////////////////////////////
            //1
            MANAGEMENT1.EditAdvType = ISUtil.Enum.EditAdvType.TextEdit;
            MANAGEMENT1.NumberDecimalDigits = 0;
            MANAGEMENT1.Nullable = true;
            MANAGEMENT1.ReadOnly = true;
            MANAGEMENT1.Insertable = false;
            MANAGEMENT1.Updatable = false;
            MANAGEMENT1.TabStop = false;
            if (iString.ISNull(pDataRow["MANAGEMENT1_DATA_TYPE"]) == "NUMBER".ToString())
            {
                MANAGEMENT1.EditAdvType = ISUtil.Enum.EditAdvType.NumberEdit;
            }
            else if (iString.ISNull(pDataRow["MANAGEMENT1_DATA_TYPE"]) == "RATE".ToString())
            {
                MANAGEMENT1.EditAdvType = ISUtil.Enum.EditAdvType.NumberEdit;
                MANAGEMENT1.NumberDecimalDigits = 4;
            }
            else if (iString.ISNull(pDataRow["MANAGEMENT1_DATA_TYPE"]) == "DATE".ToString())
            {
                MANAGEMENT1.EditAdvType = ISUtil.Enum.EditAdvType.DateTimeEdit;
            }
            MANAGEMENT1.Refresh();
            //2
            MANAGEMENT2.EditAdvType = ISUtil.Enum.EditAdvType.TextEdit;
            MANAGEMENT2.NumberDecimalDigits = 0;
            MANAGEMENT2.Nullable = true;
            MANAGEMENT2.ReadOnly = true;
            MANAGEMENT2.Insertable = false;
            MANAGEMENT2.Updatable = false;
            MANAGEMENT2.TabStop = false;
            if (iString.ISNull(pDataRow["MANAGEMENT2_DATA_TYPE"]) == "NUMBER".ToString())
            {
                MANAGEMENT2.EditAdvType = ISUtil.Enum.EditAdvType.NumberEdit;
            }
            else if (iString.ISNull(pDataRow["MANAGEMENT2_DATA_TYPE"]) == "RATE".ToString())
            {
                MANAGEMENT2.EditAdvType = ISUtil.Enum.EditAdvType.NumberEdit;
                MANAGEMENT2.NumberDecimalDigits = 4;
            }
            else if (iString.ISNull(pDataRow["MANAGEMENT2_DATA_TYPE"]) == "DATE".ToString())
            {
                MANAGEMENT2.EditAdvType = ISUtil.Enum.EditAdvType.DateTimeEdit;
            }
            MANAGEMENT2.Refresh();
            //3
            REFER1.EditAdvType = ISUtil.Enum.EditAdvType.TextEdit;
            REFER1.NumberDecimalDigits = 0;
            REFER1.Nullable = true;
            REFER1.ReadOnly = true;
            REFER1.Insertable = false;
            REFER1.Updatable = false;
            REFER1.TabStop = false;
            if (iString.ISNull(pDataRow["REFER1_DATA_TYPE"]) == "NUMBER".ToString())
            {
                REFER1.EditAdvType = ISUtil.Enum.EditAdvType.NumberEdit;
            }
            else if (iString.ISNull(pDataRow["REFER1_DATA_TYPE"]) == "RATE".ToString())
            {
                REFER1.EditAdvType = ISUtil.Enum.EditAdvType.NumberEdit;
                REFER1.NumberDecimalDigits = 4;
            }
            else if (iString.ISNull(pDataRow["REFER1_DATA_TYPE"]) == "DATE".ToString())
            {
                REFER1.EditAdvType = ISUtil.Enum.EditAdvType.DateTimeEdit;
            }
            REFER1.Refresh();
            //4
            REFER2.EditAdvType = ISUtil.Enum.EditAdvType.TextEdit;
            REFER2.NumberDecimalDigits = 0;
            REFER2.Nullable = true;
            REFER2.ReadOnly = true;
            REFER2.Insertable = false;
            REFER2.Updatable = false;
            REFER2.TabStop = false;
            if (iString.ISNull(pDataRow["REFER2_DATA_TYPE"]) == "NUMBER".ToString())
            {
                REFER2.EditAdvType = ISUtil.Enum.EditAdvType.NumberEdit;
            }
            else if (iString.ISNull(pDataRow["REFER2_DATA_TYPE"]) == "RATE".ToString())
            {
                REFER2.EditAdvType = ISUtil.Enum.EditAdvType.NumberEdit;
                REFER2.NumberDecimalDigits = 4;
            }
            else if (iString.ISNull(pDataRow["REFER2_DATA_TYPE"]) == "DATE".ToString())
            {
                REFER2.EditAdvType = ISUtil.Enum.EditAdvType.DateTimeEdit;
            }
            REFER2.Refresh();
            //5
            REFER3.EditAdvType = ISUtil.Enum.EditAdvType.TextEdit;
            REFER3.NumberDecimalDigits = 0;
            REFER3.Nullable = true;
            REFER3.ReadOnly = true;
            REFER3.Insertable = false;
            REFER3.Updatable = false;
            REFER3.TabStop = false;
            if (iString.ISNull(pDataRow["REFER3_DATA_TYPE"]) == "NUMBER".ToString())
            {
                REFER3.EditAdvType = ISUtil.Enum.EditAdvType.NumberEdit;
            }
            else if (iString.ISNull(pDataRow["REFER3_DATA_TYPE"]) == "RATE".ToString())
            {
                REFER3.EditAdvType = ISUtil.Enum.EditAdvType.NumberEdit;
                REFER3.NumberDecimalDigits = 4;
            }
            else if (iString.ISNull(pDataRow["REFER3_DATA_TYPE"]) == "DATE".ToString())
            {
                REFER3.EditAdvType = ISUtil.Enum.EditAdvType.DateTimeEdit;
            }
            REFER3.Refresh();
            //6
            REFER4.EditAdvType = ISUtil.Enum.EditAdvType.TextEdit;
            REFER4.NumberDecimalDigits = 0;
            REFER4.Nullable = true;
            REFER4.ReadOnly = true;
            REFER4.Insertable = false;
            REFER4.Updatable = false;
            REFER4.TabStop = false;
            if (iString.ISNull(pDataRow["REFER4_DATA_TYPE"]) == "NUMBER".ToString())
            {
                REFER4.EditAdvType = ISUtil.Enum.EditAdvType.NumberEdit;
            }
            else if (iString.ISNull(pDataRow["REFER4_DATA_TYPE"]) == "RATE".ToString())
            {
                REFER4.EditAdvType = ISUtil.Enum.EditAdvType.NumberEdit;
                REFER4.NumberDecimalDigits = 4;
            }
            else if (iString.ISNull(pDataRow["REFER4_DATA_TYPE"]) == "DATE".ToString())
            {
                REFER4.EditAdvType = ISUtil.Enum.EditAdvType.DateTimeEdit;
            }
            REFER4.Refresh();
            //7
            REFER5.EditAdvType = ISUtil.Enum.EditAdvType.TextEdit;
            REFER5.NumberDecimalDigits = 0;
            REFER5.Nullable = true;
            REFER5.ReadOnly = true;
            REFER5.Insertable = false;
            REFER5.Updatable = false;
            REFER5.TabStop = false;
            if (iString.ISNull(pDataRow["REFER5_DATA_TYPE"]) == "NUMBER".ToString())
            {
                REFER5.EditAdvType = ISUtil.Enum.EditAdvType.NumberEdit;
            }
            else if (iString.ISNull(pDataRow["REFER5_DATA_TYPE"]) == "RATE".ToString())
            {
                REFER5.EditAdvType = ISUtil.Enum.EditAdvType.NumberEdit;
                REFER5.NumberDecimalDigits = 4;
            }
            else if (iString.ISNull(pDataRow["REFER5_DATA_TYPE"]) == "DATE".ToString())
            {
                REFER5.EditAdvType = ISUtil.Enum.EditAdvType.DateTimeEdit;
            }
            REFER5.Refresh();
            //8
            REFER6.EditAdvType = ISUtil.Enum.EditAdvType.TextEdit;
            REFER6.NumberDecimalDigits = 0;
            REFER6.Nullable = true;
            REFER6.ReadOnly = true;
            REFER6.Insertable = false;
            REFER6.Updatable = false;
            REFER6.TabStop = false;
            if (iString.ISNull(pDataRow["REFER6_DATA_TYPE"]) == "NUMBER".ToString())
            {
                REFER6.EditAdvType = ISUtil.Enum.EditAdvType.NumberEdit;
            }
            else if (iString.ISNull(pDataRow["REFER6_DATA_TYPE"]) == "RATE".ToString())
            {
                REFER6.EditAdvType = ISUtil.Enum.EditAdvType.NumberEdit;
                REFER6.NumberDecimalDigits = 4;
            }
            else if (iString.ISNull(pDataRow["REFER6_DATA_TYPE"]) == "DATE".ToString())
            {
                REFER6.EditAdvType = ISUtil.Enum.EditAdvType.DateTimeEdit;
            }
            REFER6.Refresh();
            //9
            REFER7.EditAdvType = ISUtil.Enum.EditAdvType.TextEdit;
            REFER7.NumberDecimalDigits = 0;
            REFER7.Nullable = true;
            REFER7.ReadOnly = true;
            REFER7.Insertable = false;
            REFER7.Updatable = false;
            REFER7.TabStop = false;
            if (iString.ISNull(pDataRow["REFER7_DATA_TYPE"]) == "NUMBER".ToString())
            {
                REFER7.EditAdvType = ISUtil.Enum.EditAdvType.NumberEdit;
            }
            else if (iString.ISNull(pDataRow["REFER7_DATA_TYPE"]) == "RATE".ToString())
            {
                REFER7.EditAdvType = ISUtil.Enum.EditAdvType.NumberEdit;
                REFER7.NumberDecimalDigits = 4;
            }
            else if (iString.ISNull(pDataRow["REFER7_DATA_TYPE"]) == "DATE".ToString())
            {
                REFER7.EditAdvType = ISUtil.Enum.EditAdvType.DateTimeEdit;
            }
            REFER7.Refresh();
            //10
            REFER8.EditAdvType = ISUtil.Enum.EditAdvType.TextEdit;
            REFER8.NumberDecimalDigits = 0;
            REFER8.Nullable = true;
            REFER8.ReadOnly = true;
            REFER8.Insertable = false;
            REFER8.Updatable = false;
            REFER8.TabStop = false;
            if (iString.ISNull(pDataRow["REFER8_DATA_TYPE"]) == "NUMBER".ToString())
            {
                REFER8.EditAdvType = ISUtil.Enum.EditAdvType.NumberEdit;
            }
            else if (iString.ISNull(pDataRow["REFER8_DATA_TYPE"]) == "RATE".ToString())
            {
                REFER8.EditAdvType = ISUtil.Enum.EditAdvType.NumberEdit;
                REFER8.NumberDecimalDigits = 4;
            }
            else if (iString.ISNull(pDataRow["REFER8_DATA_TYPE"]) == "DATE".ToString())
            {
                REFER8.EditAdvType = ISUtil.Enum.EditAdvType.DateTimeEdit;
            }
            REFER8.Refresh();
            //11
            REFER9.EditAdvType = ISUtil.Enum.EditAdvType.TextEdit;
            REFER9.NumberDecimalDigits = 0;
            REFER9.Nullable = true;
            REFER9.ReadOnly = true;
            REFER9.Insertable = false;
            REFER9.Updatable = false;
            REFER9.TabStop = false;
            if (iString.ISNull(pDataRow["REFER9_DATA_TYPE"]) == "NUMBER".ToString())
            {
                REFER9.EditAdvType = ISUtil.Enum.EditAdvType.NumberEdit;
            }
            else if (iString.ISNull(pDataRow["REFER9_DATA_TYPE"]) == "RATE".ToString())
            {
                REFER9.EditAdvType = ISUtil.Enum.EditAdvType.NumberEdit;
                REFER9.NumberDecimalDigits = 4;
            }
            else if (iString.ISNull(pDataRow["REFER9_DATA_TYPE"]) == "DATE".ToString())
            {
                REFER9.EditAdvType = ISUtil.Enum.EditAdvType.DateTimeEdit;
            }
            REFER9.Refresh();
            //12
            REFER10.EditAdvType = ISUtil.Enum.EditAdvType.TextEdit;
            REFER10.NumberDecimalDigits = 0;
            REFER10.Nullable = true;
            REFER10.ReadOnly = true;
            REFER10.Insertable = false;
            REFER10.Updatable = false;
            REFER10.TabStop = false;
            if (iString.ISNull(pDataRow["REFER10_DATA_TYPE"]) == "NUMBER".ToString())
            {
                REFER10.EditAdvType = ISUtil.Enum.EditAdvType.NumberEdit;
            }
            else if (iString.ISNull(pDataRow["REFER10_DATA_TYPE"]) == "RATE".ToString())
            {
                REFER10.EditAdvType = ISUtil.Enum.EditAdvType.NumberEdit;
                REFER10.NumberDecimalDigits = 4;
            }
            else if (iString.ISNull(pDataRow["REFER10_DATA_TYPE"]) == "DATE".ToString())
            {
                REFER10.EditAdvType = ISUtil.Enum.EditAdvType.DateTimeEdit;
            }
            REFER10.Refresh();
            //13
            REFER11.EditAdvType = ISUtil.Enum.EditAdvType.TextEdit;
            REFER11.NumberDecimalDigits = 0;
            REFER11.Nullable = true;
            REFER11.ReadOnly = true;
            REFER11.Insertable = false;
            REFER11.Updatable = false;
            REFER11.TabStop = false;
            if (iString.ISNull(pDataRow["REFER11_DATA_TYPE"]) == "NUMBER".ToString())
            {
                REFER11.EditAdvType = ISUtil.Enum.EditAdvType.NumberEdit;
            }
            else if (iString.ISNull(pDataRow["REFER11_DATA_TYPE"]) == "RATE".ToString())
            {
                REFER11.EditAdvType = ISUtil.Enum.EditAdvType.NumberEdit;
                REFER11.NumberDecimalDigits = 4;
            }
            else if (iString.ISNull(pDataRow["REFER11_DATA_TYPE"]) == "DATE".ToString())
            {
                REFER11.EditAdvType = ISUtil.Enum.EditAdvType.DateTimeEdit;
            }
            REFER11.Refresh();
            //14
            REFER12.EditAdvType = ISUtil.Enum.EditAdvType.TextEdit;
            REFER12.NumberDecimalDigits = 0;
            REFER12.Nullable = true;
            REFER12.ReadOnly = true;
            REFER12.Insertable = false;
            REFER12.Updatable = false;
            REFER12.TabStop = false;
            if (iString.ISNull(pDataRow["REFER12_DATA_TYPE"]) == "NUMBER".ToString())
            {
                REFER12.EditAdvType = ISUtil.Enum.EditAdvType.NumberEdit;
            }
            else if (iString.ISNull(pDataRow["REFER12_DATA_TYPE"]) == "RATE".ToString())
            {
                REFER12.EditAdvType = ISUtil.Enum.EditAdvType.NumberEdit;
                REFER12.NumberDecimalDigits = 4;
            }
            else if (iString.ISNull(pDataRow["REFER12_DATA_TYPE"]) == "DATE".ToString())
            {
                REFER12.EditAdvType = ISUtil.Enum.EditAdvType.DateTimeEdit;
            }
            REFER12.Refresh();

        }

        #endregion

        #region ----- Lookup Event -----

        private void ilaSLIP_NUM_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildSLIP_NUM.SetLookupParamValue("W_SLIP_TYPE_CLASS", null);
        }

        private void ilaSLIP_TYPE_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter("SLIP_TYPE", "Y");
        }

        private void ilaDEPT_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildDEPT.SetLookupParamValue("W_ENABLED_YN", "Y");
        }

        #endregion

        #region ----- Form Event -----

        private void FCMF0219_Load(object sender, EventArgs e)
        {
            idaSLIP_HEADER_IF.FillSchema();
            SLIP_QUERY_STATUS.EditValue = "NON-QUERY";
            //SLIP_DATE_FR_0.EditValue = iDate.ISDate_Add(DateTime.Today, -7);
            //SLIP_DATE_TO_0.EditValue = iDate.ISGetDate();

            DefaultSetDate1();
        }

        private void igrSLIP_LIST_CellDoubleClick(object pSender)
        {
            if (igrSLIP_LIST_IF.RowIndex > -1)
            {
                if (iString.ISNull(igrSLIP_LIST_IF.GetCellValue("HEADER_INTERFACE_ID")) != string.Empty)
                {
                    idaSLIP_LIST_IF.MoveFocus = true;

                    SLIP_QUERY_STATUS.EditValue = "QUERY";
                    itbSLIP.SelectedIndex = 1;
                    itbSLIP.SelectedTab.Focus();
                    idaSLIP_HEADER_IF.SetSelectParamValue("W_HEADER_INTERFACE_ID", igrSLIP_LIST_IF.GetCellValue("HEADER_INTERFACE_ID"));
                    idaSLIP_HEADER_IF.Fill();
                    SLIP_TYPE_NAME.Focus();
                }
            }
        }

        #endregion

        #region ----- Events -----

        private void isAppInterfaceAdv1_AppMainButtonClick(ISAppButtonEvents e)
        {
            if (this.IsActive)
            {
                if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Search)
                {
                    Search_DB();
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
                    if (idaSLIP_LIST_IF.IsFocused == true)
                    {
                        idaSLIP_LIST_IF.Cancel();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Print)
                {
                    XLPrinting1("PRINT");
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Export)
                {
                    XLPrinting1("FILE");
                }
            }
        }

        #endregion;

        #region ----- Adapter Events -----

        private void idaSLIP_LINE_NewRowMoved(object pSender, ISBindingEventArgs pBindingManager)
        {
            if (SLIP_QUERY_STATUS.EditValue.ToString() != "QUERY".ToString())
            {
                Init_DR_CR_Amount();
            }
            Init_Total_GL_Amount();
            idaSLIP_LINE_IF.OraSelectData.AcceptChanges();
            idaSLIP_LINE_IF.Refillable = true;
        }

        private void idaSLIP_LINE_IF_PreNewRowMoved(object pSender, ISBindingEventArgs pBindingManager)
        {
            Init_Set_Item_Prompt(pBindingManager.DataRow);
        }

        #endregion;
    }
}