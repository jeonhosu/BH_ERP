using System;
using System.Data;
using System.Drawing;
using System.Windows.Forms;
using System.Collections.Generic;

using Syncfusion.Windows.Forms;
using Syncfusion.Windows.Forms.Tools;
using Syncfusion.Windows.Forms.Grid;
using InfoSummit.Win.ControlAdv;

namespace FCMF0254
{
    public partial class FCMF0254 : Office2007Form
    {
        #region ----- Variables -----



        #endregion;

        #region ----- Constructor -----

        public FCMF0254()
        {
            InitializeComponent();
        }

        public FCMF0254(Form pMainForm, ISAppInterface pAppInterface)
        {
            InitializeComponent();
            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;
        }

        #endregion;

        #region ----- Private Methods ----

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
            string vYearMonth = vDate.ISYearMonth(vGetDateTime);

            isEditAdv101.EditValue = vYearMonth;
        }

        private void DefaultSetDate2()
        {
            DateTime vGetDateTime = GetDate();

            ISCommonUtil.ISFunction.ISDateTime vDate = new ISCommonUtil.ISFunction.ISDateTime();
            string vYearMonth = vDate.ISYearMonth(vGetDateTime);
            DateTime vMonthFirstDay = vDate.ISMonth_1st(vGetDateTime);

            isEditAdv101.EditValue = vYearMonth;

            isEditAdv401.EditValue = vMonthFirstDay;
            isEditAdv402.EditValue = vGetDateTime;
        }

        #endregion;

        #region ----- XL Export Methods ----

        private void ExportXL()
        {
            int vCountRow = isDataAdapter1.OraSelectData.Rows.Count;
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
                bool vXLSaveOK = xlExport.XLExport(isDataAdapter1.OraSelectData, vsSaveExcelFileName, vsSheetName);
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

            XLPrinting xlPrinting = new XLPrinting();

            try
            {
                //mMainForm
                //string vPathReport = string.Empty;
                //object vObject = mMainForm.Tag;
                //if (vObject != null)
                //{
                //    vPathReport = mMainForm.Tag;
                //}
                //-------------------------------------------------------------------------
                xlPrinting.OpenFileNameExcel = @"K:\00_5_XL_Print\Ex_XL_Print\XL_Print_02.xls";
                xlPrinting.XLFileOpen();

                int vTerritory = GetTerritory(isGridAdvEx1.TerritoryLanguage);
                string vPeriodFrom = isEditAdv101.EditText;
                string vPeriodTo = isEditAdv101.EditText;
                int vPageNumber = xlPrinting.XLWirte(isGridAdvEx1, vTerritory, vPeriodFrom, vPeriodTo);

                //xlPrinting.Printing(1, vPageNumber); //시작 페이지 번호, 종료 페이지 번호
                ////xlPrinting.Printing(3, 4);


                xlPrinting.Save("t_XL_"); //저장 파일명
                //vMessageText = string.Format("Err : {0}", xlPrinting.ErrorMessage);
                //MessageGrid(vMessageText);

                //xlPrinting.PreView();

                xlPrinting.Dispose();
                //-------------------------------------------------------------------------

                vMessageText = string.Format("Print End! [Page : {0}]", vPageNumber);
                MessageBoxAdv.Show(vMessageText);
            }
            catch (System.Exception ex)
            {
                string vMessage = ex.Message;
                xlPrinting.Dispose();
            }
        }

        #endregion;

        #region ----- Events -----

        private void FCMF0254_Load(object sender, EventArgs e)
        {
            ildFiCommon.SetLookupParamValue("W_ENABLED_YN", "N");

            DefaultSetDate1();
            DefaultSetDate2();
        }

        private void FCMF0254_Shown(object sender, EventArgs e)
        {
            isTabAdv1.SelectedIndex = 0;
            isGridAdvEx1.Focus();
        }

        private void isTabAdv1_SelectedIndexChanged(object sender, EventArgs e)
        {
            int vIndexTab = isTabAdv1.SelectedIndex;
            if (vIndexTab == 0)
            {
                isGridAdvEx1.Focus();
                isDataAdapter3.IsFocused = false;
            }
            else if (vIndexTab == 1)
            {
                isGridAdvEx3.Focus();
                isDataAdapter1.IsFocused = false;
            }
        }

        private void isGridAdvEx3_CellDoubleClick(object pSender)
        {
            try
            {
                object pSLIP_HEADER_ID = isGridAdvEx3.GetCellValue("SLIP_HEADER_ID");
                if (pSLIP_HEADER_ID != null || pSLIP_HEADER_ID != System.DBNull.Value)
                {
                    this.Cursor = Cursors.WaitCursor;
                    System.Windows.Forms.Application.DoEvents();

                    SLIP_DETAIL vForm = new SLIP_DETAIL(isAppInterfaceAdv1.AppInterface, pSLIP_HEADER_ID);
                    vForm.WindowState = FormWindowState.Normal;
                    vForm.StartPosition = FormStartPosition.CenterScreen;
                    vForm.ShowDialog();

                    this.Cursor = Cursors.Default;
                    System.Windows.Forms.Application.DoEvents();
                }
            }
            catch (System.Exception ex)
            {
                isAppInterfaceAdv1.AppInterface.OnAppMessageEvent(ex.Message);
            }
        }

        private void isAppInterfaceAdv1_AppMainButtonClick(ISAppButtonEvents e)
        {
            if (this.IsActive)
            {
                if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Search)
                {
                    int vIndexTab = isTabAdv1.SelectedIndex;
                    if (vIndexTab == 0)
                    {
                        isDataAdapter1.Fill();
                    }
                    else if (vIndexTab == 1)
                    {
                        isDataAdapter3.SetSelectParamValue("W_PERIOD_NAME", isEditAdv401.EditValue.ToString().Substring(0, 7));
                        isDataAdapter3.Fill();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddOver)
                {
                    if (isDataAdapter1.IsFocused)
                    {

                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddUnder)
                {
                    if (isDataAdapter1.IsFocused)
                    {

                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Update)
                {
                    if (isDataAdapter1.IsFocused)
                    {

                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Cancel)
                {
                    if (isDataAdapter1.IsFocused)
                    {

                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {
                    if (isDataAdapter1.IsFocused)
                    {
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