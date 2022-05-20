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

namespace FCMF0503
{
    public partial class FCMF0503 : Office2007Form
    {
        #region ----- Variables -----

        ISFunction.ISConvert iString = new ISFunction.ISConvert();
        ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        private string mRadioValue = string.Empty;

        private string mCompany = string.Empty;

        #endregion;

        #region ----- Constructor -----

        public FCMF0503()
        {
            InitializeComponent();
        }

        public FCMF0503(Form pMainForm, ISAppInterface pAppInterface)
        {
            InitializeComponent();
            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;
        }

        #endregion;

        #region ----- Private Methods ----

        private void SearchDB_List()
        {
            if (iString.ISNull(GL_DATE_FR_0.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10165"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                GL_DATE_FR_0.Focus();
                return;
            }
            if (iString.ISNull(GL_DATE_TO_0.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10011"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                GL_DATE_FR_0.Focus();
                return;
            }
            if (Convert.ToDateTime(GL_DATE_FR_0.EditValue) > Convert.ToDateTime(GL_DATE_TO_0.EditValue))
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10012"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                GL_DATE_FR_0.Focus();
                return;
            }

            if (iString.ISNull(ACCOUNT_CODE_FR_0.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10123"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                ACCOUNT_CODE_FR_0.Focus();
                return;
            }
            if (iString.ISNull(ACCOUNT_CODE_TO_0.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10123"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                ACCOUNT_CODE_TO_0.Focus();
                return;
            }
            idaSETTLEMENT_SUM_HEADER.Fill();
            igrSETTLEMENT_SUM_HEADER.Focus();
        }

        private void SearchDB_Sum()
        {
            if (iString.ISNull(GL_DATE_FR_0.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10010"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                GL_DATE_FR_0.Focus();
                return;
            }
            if (iString.ISNull(GL_DATE_TO_0.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10011"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                GL_DATE_FR_0.Focus();
                return;
            }
            if (Convert.ToDateTime(GL_DATE_FR_0.EditValue) > Convert.ToDateTime(GL_DATE_TO_0.EditValue))
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10012"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                GL_DATE_FR_0.Focus();
                return;
            }

            if (iString.ISNull(ACCOUNT_CODE_FR_0.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10123"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                ACCOUNT_CODE_FR_0.Focus();
                return;
            }
            if (iString.ISNull(ACCOUNT_CODE_TO_0.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10123"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                ACCOUNT_CODE_TO_0.Focus();
                return;
            }
            idaSETTLEMENT_SUM_LIST.Fill();
        }

        private void SearchDB_Print()
        {
            if (iString.ISNull(GL_DATE_FR_0.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10010"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                GL_DATE_FR_0.Focus();
                return;
            }
            if (iString.ISNull(GL_DATE_TO_0.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10011"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                GL_DATE_FR_0.Focus();
                return;
            }
            if (Convert.ToDateTime(GL_DATE_FR_0.EditValue) > Convert.ToDateTime(GL_DATE_TO_0.EditValue))
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10012"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                GL_DATE_FR_0.Focus();
                return;
            }

            if (iString.ISNull(ACCOUNT_CODE_FR_0.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10123"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                ACCOUNT_CODE_FR_0.Focus();
                return;
            }
            if (iString.ISNull(ACCOUNT_CODE_TO_0.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10123"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                ACCOUNT_CODE_TO_0.Focus();
                return;
            }
            idaSETTLEMENT_PRINT.Fill();
        }

        private void SearchFromDataAdapter3()
        {
            object vObject1 = igrSETTLEMENT_SUM_HEADER.GetCellValue("GL_DATE");
            object vObject2 = igrSETTLEMENT_SUM_HEADER.GetCellValue("ACCOUNT_CONTROL_ID");
            idaSLIP_LINE.SetSelectParamValue("W_GL_DATE", vObject1);
            idaSLIP_LINE.SetSelectParamValue("W_ACCOUNT_CONTROL_ID", vObject2);
            idaSLIP_LINE.Fill();
        }

        private void Show_Slip_Detail()
        {
            int mSLIP_HEADER_ID = iString.ISNumtoZero(igrSLIP_LINE_LIST.GetCellValue("SLIP_HEADER_ID"));            
            if (mSLIP_HEADER_ID != Convert.ToInt32(0))
            {
                Application.UseWaitCursor = true;
                this.Cursor = System.Windows.Forms.Cursors.WaitCursor;

                FCMF0204.FCMF0204 vFCMF0204 = new FCMF0204.FCMF0204(this.MdiParent, isAppInterfaceAdv1.AppInterface, mSLIP_HEADER_ID);
                vFCMF0204.Show();

                this.Cursor = System.Windows.Forms.Cursors.Default;
                Application.UseWaitCursor = false;
            }
        }

        #endregion;

        #region ----- Company Search Methods ----

        private void CompanySearch()
        {
            string vStartupPath = System.Windows.Forms.Application.StartupPath;
            //vStartupPath = "C:\\Program Files\\Flex_ERP_FC\\Kor";
            //vStartupPath = "C:\\Program Files\\Flex_ERP_BH\\Kor";

            int vCutStart = vStartupPath.LastIndexOf("\\");
            string vCutStringFiRST = vStartupPath.Substring(0, vCutStart);

            vCutStart = vCutStringFiRST.LastIndexOf("\\") + 1;
            int vCutLength = vCutStringFiRST.Length - vCutStart;
            mCompany = vCutStringFiRST.Substring(vCutStart, vCutLength);

            isAppInterfaceAdv1.OnAppMessage(mCompany);
            System.Windows.Forms.Application.DoEvents();
        }

        #endregion;

        #region ----- XL Export Methods ----

        private void ExportXL(ISGridAdvEx pGrid)
        {
            string vMessage = string.Empty;
            int vCountRows = pGrid.RowCount;

            if (vCountRows > 0)
            {
                saveFileDialog1.Title = "Excel_Save";
                saveFileDialog1.FileName = "Ex_00";
                saveFileDialog1.DefaultExt = "xls";
                System.IO.DirectoryInfo vSaveFolder = new System.IO.DirectoryInfo(System.Environment.GetFolderPath(Environment.SpecialFolder.Desktop));
                saveFileDialog1.InitialDirectory = vSaveFolder.FullName;
                saveFileDialog1.Filter = "Excel Files (*.xls)|*.xls";
                if (saveFileDialog1.ShowDialog() == System.Windows.Forms.DialogResult.OK)
                {
                    System.Windows.Forms.Application.UseWaitCursor = true;
                    this.Cursor = System.Windows.Forms.Cursors.WaitCursor;
                    System.Windows.Forms.Application.DoEvents();

                    string vOpenExcelFileName = "FCMF0503_002.xls";
                    string vSaveExcelFileName = saveFileDialog1.FileName;

                    XLExport mExport = new XLExport();
                    int vTerritory = GetTerritory(pGrid.TerritoryLanguage);
                    bool vbXLSaveOK = mExport.ExcelExport(pGrid, vTerritory, vOpenExcelFileName, vSaveExcelFileName, this.Text, this);
                    if (vbXLSaveOK == true)
                    {
                        vMessage = string.Format("Save OK [{0}]", vSaveExcelFileName);
                        isAppInterfaceAdv1.OnAppMessage(vMessage);
                        System.Windows.Forms.Application.DoEvents();
                    }
                    else
                    {
                        vMessage = string.Format("Save Err [{0}]", vSaveExcelFileName);
                        isAppInterfaceAdv1.OnAppMessage(vMessage);
                        System.Windows.Forms.Application.DoEvents();
                    }

                    System.Windows.Forms.Application.UseWaitCursor = false;
                    this.Cursor = System.Windows.Forms.Cursors.Default;
                    System.Windows.Forms.Application.DoEvents();
                }
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

        #region ----- FC XL Print 3 Methods ----

        private void XLPrinting3(string pOutChoice)
        {
            string vMessageText = string.Empty;
            int vPageNumber = 0;

            int vCountRow = igrPRINTER.RowCount;

            if (vCountRow < 1)
            {
                return;
            }

            XLPrinting03 xlPrinting = new XLPrinting03(isAppInterfaceAdv1, isMessageAdapter1);

            try
            {
                xlPrinting.OpenFileNameExcel = "FCMF0503_001.xls"; //가로
                bool IsOpen = xlPrinting.XLFileOpen();
                if (IsOpen == true)
                {
                    vMessageText = string.Format("[{0}] - Printing Start...", mCompany);
                    isAppInterfaceAdv1.OnAppMessage(vMessageText);
                    System.Windows.Forms.Application.DoEvents();

                    System.Windows.Forms.Application.UseWaitCursor = true;
                    this.Cursor = System.Windows.Forms.Cursors.WaitCursor;
                    System.Windows.Forms.Application.DoEvents();

                    string vPeriodFrom = GL_DATE_FR_0.DateTimeValue.ToShortDateString();
                    string vPeriodTo = GL_DATE_TO_0.DateTimeValue.ToShortDateString();
                    string vPeriod = string.Format("{0}~{1}", vPeriodFrom, vPeriodTo);

                    int vTerritory = GetTerritory(igrPRINTER.TerritoryLanguage);

                    string vUserName = string.Format("[{0}]{1}", isAppInterfaceAdv1.DEPT_NAME, isAppInterfaceAdv1.DISPLAY_NAME);

                    int viCutStart = this.Text.LastIndexOf("]") + 1;
                    string vCaption = this.Text.Substring(0, viCutStart);

                    vPageNumber = xlPrinting.XLWirte(igrPRINTER, vTerritory, vPeriod, vUserName, vCaption);

                    if (pOutChoice == "PRINT")
                    {
                        //xlPrinting.Printing(1, vPageNumber);
                        xlPrinting.PreView(1, vPageNumber);
                    }
                    else if (pOutChoice == "FILE")
                    {
                        xlPrinting.Save("OUT_");
                    }
                    //-------------------------------------------------------------------------

                    vMessageText = string.Format("Print End! [Page : {0}]", vPageNumber);
                    isAppInterfaceAdv1.OnAppMessage(vMessageText);
                    System.Windows.Forms.Application.DoEvents();
                }
                else
                {
                    vMessageText = string.Format("Open Error[{0}]", "FCMF0503_001.xls");
                    isAppInterfaceAdv1.OnAppMessage(vMessageText);
                    System.Windows.Forms.Application.DoEvents();

                    xlPrinting.Dispose();
                }
            }
            catch (System.Exception ex)
            {
                string vMessage = ex.Message;
                xlPrinting.Dispose();
            }

            xlPrinting.Dispose();

            System.Windows.Forms.Application.UseWaitCursor = false;
            this.Cursor = System.Windows.Forms.Cursors.Default;
            System.Windows.Forms.Application.DoEvents();
        }

        #endregion;

        #region ----- FC XL Print 4 Methods ----

        private void XLPrinting4(string pOutChoice)
        {
            string vMessageText = string.Empty;
            int vPageNumber = 0;

            int vCountRow = igrPRINTER.RowCount;

            if (vCountRow < 1)
            {
                return;
            }

            XLPrinting04 xlPrinting = new XLPrinting04(isAppInterfaceAdv1, isMessageAdapter1);

            try
            {
                xlPrinting.OpenFileNameExcel = "FCMF0503_003.xls"; //세로
                bool IsOpen = xlPrinting.XLFileOpen();
                if (IsOpen == true)
                {
                    vMessageText = string.Format("[{0}] - Printing Start...", mCompany);
                    isAppInterfaceAdv1.OnAppMessage(vMessageText);
                    System.Windows.Forms.Application.DoEvents();

                    System.Windows.Forms.Application.UseWaitCursor = true;
                    this.Cursor = System.Windows.Forms.Cursors.WaitCursor;
                    System.Windows.Forms.Application.DoEvents();

                    string vPeriodFrom = GL_DATE_FR_0.DateTimeValue.ToShortDateString();
                    string vPeriodTo = GL_DATE_TO_0.DateTimeValue.ToShortDateString();
                    string vPeriod = string.Format("{0}~{1}", vPeriodFrom, vPeriodTo);

                    int vTerritory = GetTerritory(igrPRINTER.TerritoryLanguage);

                    string vUserName = string.Format("[{0}]{1}", isAppInterfaceAdv1.DEPT_NAME, isAppInterfaceAdv1.DISPLAY_NAME);

                    int viCutStart = this.Text.LastIndexOf("]") + 1;
                    string vCaption = this.Text.Substring(0, viCutStart);

                    vPageNumber = xlPrinting.XLWirte(igrPRINTER, vTerritory, vPeriod, vUserName, vCaption);

                    if (pOutChoice == "PRINT")
                    {
                        //xlPrinting.Printing(1, vPageNumber);
                        xlPrinting.PreView(1, vPageNumber);
                    }
                    else if (pOutChoice == "FILE")
                    {
                        xlPrinting.Save("OUT_");
                    }
                    //-------------------------------------------------------------------------

                    vMessageText = string.Format("Print End! [Page : {0}]", vPageNumber);
                    isAppInterfaceAdv1.OnAppMessage(vMessageText);
                    System.Windows.Forms.Application.DoEvents();
                }
                else
                {
                    vMessageText = string.Format("Open Error[{0}]", "FCMF0503_003.xls");
                    isAppInterfaceAdv1.OnAppMessage(vMessageText);
                    System.Windows.Forms.Application.DoEvents();

                    xlPrinting.Dispose();
                }
            }
            catch (System.Exception ex)
            {
                string vMessage = ex.Message;
                xlPrinting.Dispose();
            }

            xlPrinting.Dispose();

            System.Windows.Forms.Application.UseWaitCursor = false;
            this.Cursor = System.Windows.Forms.Cursors.Default;
            System.Windows.Forms.Application.DoEvents();
        }

        #endregion;

        #region ----- Main Events -----

        private void isAppInterfaceAdv1_AppMainButtonClick(ISAppButtonEvents e)
        {
            if (this.IsActive)
            {
                if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Search)
                {

                    int vIndexTab = itbFINAL_SETTLE.SelectedIndex;
                    if (vIndexTab == 0)
                    {
                        SearchDB_List();
                    }
                    else if (vIndexTab == 1)
                    {
                        SearchDB_Sum();
                    }
                    else if (vIndexTab == 2)
                    {
                        SearchDB_Print();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddOver)
                {
                    if (idaSETTLEMENT_SUM_HEADER.IsFocused)
                    {

                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddUnder)
                {
                    if (idaSETTLEMENT_SUM_HEADER.IsFocused)
                    {

                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Update)
                {
                    if (idaSETTLEMENT_SUM_HEADER.IsFocused)
                    {

                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Cancel)
                {
                    if (idaSETTLEMENT_SUM_HEADER.IsFocused)
                    {

                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {
                    if (idaSETTLEMENT_SUM_HEADER.IsFocused)
                    {
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Print)
                {
                    
                    if (mRadioValue == "HORIZONTAL") //가로
                    {
                        XLPrinting3("PRINT");
                    }
                    else if (mRadioValue == "VERTICAL") //세로
                    {
                        XLPrinting4("PRINT");
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Export)
                {
                    if (mRadioValue == "HORIZONTAL") //가로
                    {
                        XLPrinting3("FILE");
                    }
                    else if (mRadioValue == "VERTICAL") //세로
                    {
                        XLPrinting4("FILE");
                    }
                }
            }
        }

        #endregion;

        #region ----- Form Event -----

        private void FCMF0503_Load(object sender, EventArgs e)
        {
            GL_DATE_FR_0.EditValue = iDate.ISMonth_1st(DateTime.Today);
            GL_DATE_TO_0.EditValue = DateTime.Today;
        }

        private void FCMF0503_Shown(object sender, EventArgs e)
        {
            igrSETTLEMENT_SUM_HEADER.Focus();

            isRadioButtonAdv1.Checked = true;

            CompanySearch();
        }

        private void igrSLIP_LINE_LIST_CellDoubleClick(object pSender)
        {
            Show_Slip_Detail();
        }

        private void isRadioButtonAdv_CheckChanged(object sender, EventArgs e)
        {
            ISRadioButtonAdv vRadio = sender as ISRadioButtonAdv;

            if (vRadio.Checked == true)
            {
                mRadioValue = vRadio.RadioCheckedString;
            }
        }

        #endregion

        #region ----- Lookup Event -----

        private void ilaACCOUNT_CODE_FR_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildACCOUNT_CONTROL_FR.SetLookupParamValue("W_ACCOUNT_CODE_FR", null);
            ildACCOUNT_CONTROL_FR.SetLookupParamValue("W_ENABLED_YN", "Y");
        }

        private void ilaACCOUNT_CODE_TO_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildACCOUNT_CONTROL_FR.SetLookupParamValue("W_ACCOUNT_CODE_FR", ACCOUNT_CODE_FR_0.EditValue);
            ildACCOUNT_CONTROL_FR.SetLookupParamValue("W_ENABLED_YN", "Y");
        }

        #endregion

        #region ---- Adapter Event -----
        
        private void idaSETTLEMENT_SUM_LIST_NewRowMoved(object pSender, ISBindingEventArgs pBindingManager)
        {
            idaSLIP_LINE.SetSelectParamValue("W_GL_DATE_TO", igrSETTLEMENT_SUM_HEADER.GetCellValue("GL_DATE"));
            idaSLIP_LINE.Fill();
        }

        #endregion

    }
}