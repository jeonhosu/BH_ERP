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

namespace FCMF0210
{
    public partial class FCMF0210 : Office2007Form
    {
        #region ----- Variables -----

        ISFunction.ISConvert iString = new ISFunction.ISConvert();
        ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        #endregion;

        #region ----- Constructor -----

        public FCMF0210()
        {
            InitializeComponent();
        }

        public FCMF0210(Form pMainForm, ISAppInterface pAppInterface)
        {
            InitializeComponent();
            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;
        }

        #endregion;

        #region ----- Private Methods ----

        private void Search_DB()
        {
            idaSLIP_HEADER_LIST.Fill();
            igrSLIP_LIST.Focus();
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

        #region ----- XL Export Methods ----

        private void ExportXL()
        {
            int vCountRow = idaSLIP_HEADER_LIST.OraSelectData.Rows.Count;
            if (vCountRow < 1)
            {
                return;
            }

            string vsMessage = string.Empty;
            string vsSheetName = "Slip_Line";

            saveFileDialog1.Title = "Excel_Save";
            saveFileDialog1.FileName = "XL_00";
            saveFileDialog1.DefaultExt = "xls";
            System.IO.DirectoryInfo vSaveFolder = new System.IO.DirectoryInfo(System.Environment.GetFolderPath(Environment.SpecialFolder.Desktop));
            saveFileDialog1.InitialDirectory = vSaveFolder.FullName;
            saveFileDialog1.Filter = "Excel Files (*.xls)|*.xls";
            if (saveFileDialog1.ShowDialog() == System.Windows.Forms.DialogResult.OK)
            {
                string vsSaveExcelFileName = saveFileDialog1.FileName;
                XL.XLPrint xlExport = new XL.XLPrint();
                bool vXLSaveOK = xlExport.XLExport(idaSLIP_HEADER_LIST.OraSelectData, vsSaveExcelFileName, vsSheetName);
                if (vXLSaveOK == true)
                {
                    vsMessage = string.Format("Save OK [{0}]", vsSaveExcelFileName);
                    MessageBoxAdv.Show(vsMessage);
                }
                else
                {
                    vsMessage = string.Format("Save Err [{0}]", vsSaveExcelFileName);
                    MessageBoxAdv.Show(vsMessage);
                }
                xlExport.XLClose();
            }
        }

        #endregion;

        #region ----- Territory Get Methods ----

        private int GetTerritory(ISUtil.Enum.TerritoryLanguage pTerritoryEnum)
        {
            int vTerritory = 0;

            switch (pTerritoryEnum)
            {
                case ISUtil.Enum.TerritoryLanguage.Default:
                    vTerritory = 1;
                    break;
                case ISUtil.Enum.TerritoryLanguage.TL1_KR:
                    vTerritory = 2;
                    break;
                case ISUtil.Enum.TerritoryLanguage.TL2_CN:
                    vTerritory = 3;
                    break;
                case ISUtil.Enum.TerritoryLanguage.TL3_VN:
                    vTerritory = 4;
                    break;
                case ISUtil.Enum.TerritoryLanguage.TL4_JP:
                    vTerritory = 5;
                    break;
                case ISUtil.Enum.TerritoryLanguage.TL5_XAA:
                    vTerritory = 6;
                    break;
            }

            return vTerritory;
        }

        #endregion;

        #region ----- XL Print 1 Methods ----

        private void XLPrinting1()
        {
            string vMessageText = string.Empty;
            int vPageTotal = 0;
            int vPageNumber = 0;

            int vTerritory = GetTerritory(isAppInterfaceAdv1.AppInterface.OraConnectionInfo.TerritoryLanguage);

            int vCountRowGrid = igrSLIP_LIST.RowCount;
            if (vCountRowGrid > 0)
            {
                vMessageText = string.Format("Printing Start");
                isAppInterfaceAdv1.AppInterface.OnAppMessageEvent(vMessageText);


                System.Windows.Forms.Application.UseWaitCursor = true;
                this.Cursor = System.Windows.Forms.Cursors.WaitCursor;
                System.Windows.Forms.Application.DoEvents();


                int vIndexCheckBox = igrSLIP_LIST.GetColumnToIndex("CHECK_BOX");
                string vCheckedString = igrSLIP_LIST.GridAdvExColElement[vIndexCheckBox].CheckedString;
                //-------------------------------------------------------------------------------------
                for (int vRow = 0; vRow < vCountRowGrid; vRow++)
                {
                    igrSLIP_LIST.CurrentCellMoveTo(vRow, vIndexCheckBox);
                    igrSLIP_LIST.Focus();
                    igrSLIP_LIST.CurrentCellActivate(vRow, vIndexCheckBox);

                    object vObject = igrSLIP_LIST.GetCellValue(vRow, vIndexCheckBox);
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
                                    xlPrinting.OpenFileNameExcel = "FCMF0210_001.xls";
                                    //-------------------------------------------------------------------------------------

                                    //-------------------------------------------------------------------------------------
                                    bool isOpen = xlPrinting.XLFileOpen();
                                    //-------------------------------------------------------------------------------------

                                    if (isOpen == true)
                                    {
                                        //-------------------------------------------------------------------------------------
                                        xlPrinting.HeaderWrite(igrSLIP_LIST, vRow);

                                        vPageNumber = xlPrinting.LineWrite(ilaSLIP_LINE_PRINT);

                                        xlPrinting.Printing(1, vPageNumber); //시작 페이지 번호, 종료 페이지 번호
                                        ////xlPrinting.Printing(3, 4);

                                        //Check한 Lot, 하나 하나를 저장 및 인쇄한다. Excel Object가 Lot 갯수 만큼 메모리에 생성 된다.
                                        //xlPrinting.Save("SLIP_"); //저장 파일명
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
            vMessageText = string.Format("Print End ^.^ [Tatal Page : {0}]", vPageTotal);
            isAppInterfaceAdv1.AppInterface.OnAppMessageEvent(vMessageText);
            idaSLIP_HEADER_LIST.OraSelectData.AcceptChanges();
            idaSLIP_HEADER_LIST.Refillable = true;

            this.Cursor = System.Windows.Forms.Cursors.Default;
            System.Windows.Forms.Application.UseWaitCursor = false;
            System.Windows.Forms.Application.DoEvents();
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

        private void FCMF0210_Load(object sender, EventArgs e)
        {
            idaSLIP_HEADER.FillSchema();
            SLIP_QUERY_STATUS.EditValue = "NON-QUERY";
            //SLIP_DATE_FR_0.EditValue = iDate.ISDate_Add(DateTime.Today, -7);
            //SLIP_DATE_TO_0.EditValue = iDate.ISGetDate();

            DefaultSetDate1();
        }

        private void igrSLIP_LIST_CellDoubleClick(object pSender)
        {
            if (igrSLIP_LIST.RowIndex > -1)
            {
                if (iString.ISNull(igrSLIP_LIST.GetCellValue("SLIP_HEADER_ID")) != string.Empty)
                {
                    idaSLIP_HEADER_LIST.MoveFocus = true;

                    SLIP_QUERY_STATUS.EditValue = "QUERY";
                    itbSLIP.SelectedIndex = 1;
                    itbSLIP.SelectedTab.Focus();
                    idaSLIP_HEADER.SetSelectParamValue("W_SLIP_HEADER_ID", igrSLIP_LIST.GetCellValue("SLIP_HEADER_ID"));
                    idaSLIP_HEADER.Fill();

                    idaSLIP_LINE.OraSelectData.AcceptChanges();
                    idaSLIP_LINE.Refillable = true;
                }
            }
        }

        private void idaSLIP_LINE_NewRowMoved(object pSender, ISBindingEventArgs pBindingManager)
        {
            Search_Control_Item_Prompt();
            if (SLIP_QUERY_STATUS.EditValue.ToString() != "QUERY".ToString())
            {
                Init_DR_CR_Amount();
            }
            Init_Total_GL_Amount();
        }

        private void Search_Control_Item_Prompt()
        {
            Init_Control_Item_Value();

            idaCONTROL_ITEM_PROMPT.Fill();
        }

        private void Init_Control_Item_Value()
        {
            MANAGEMENT1_PROMPT.EditValue = null;
            MANAGEMENT2_PROMPT.EditValue = null;
            REFER1_PROMPT.EditValue = null;
            REFER2_PROMPT.EditValue = null;
            REFER3_PROMPT.EditValue = null;
            REFER4_PROMPT.EditValue = null;
            REFER5_PROMPT.EditValue = null;

            idaCONTROL_ITEM_PROMPT.Cancel();
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
                    if (idaSLIP_HEADER_LIST.IsFocused == true)
                    {
                        idaSLIP_HEADER_LIST.Cancel();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Print)
                {
                    XLPrinting1();
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Export)
                {
                    ExportXL();
                }
            }
        }

        #endregion;
    }
}