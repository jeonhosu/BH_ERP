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

namespace FCMF0511
{
    public partial class FCMF0511 : Office2007Form
    {
        #region ----- Variables -----

        ISFunction.ISConvert iString = new ISFunction.ISConvert();
        ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        #endregion;

        #region ----- Constructor -----

        public FCMF0511()
        {
            InitializeComponent();
        }

        public FCMF0511(Form pMainForm, ISAppInterface pAppInterface)
        {
            InitializeComponent();
            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;
        }

        #endregion;

        #region ----- Private Methods ----

        private void SearchDB()
        {
            string vCUST_CODE = iString.ISNull(igrCUSTOMER_HEADER.GetCellValue("SUPP_CUST_CODE"));
            int vIDX_CUST_CODE = igrCUSTOMER_HEADER.GetColumnToIndex("SUPP_CUST_CODE");
            
            idaCUST_BALANCE_HEADER.Fill();
            if (iString.ISNull(vCUST_CODE) != string.Empty)
            {
                for (int i = 0; i < igrCUSTOMER_HEADER.RowCount; i++)
                {
                    if (vCUST_CODE == iString.ISNull(igrCUSTOMER_HEADER.GetCellValue(i, vIDX_CUST_CODE)))
                    {
                        igrCUSTOMER_HEADER.CurrentCellMoveTo(i, vIDX_CUST_CODE);
                        igrCUSTOMER_HEADER.CurrentCellActivate(i, vIDX_CUST_CODE);
                        return;
                    }
                }
            }            
        }

        private void SearchDB_Line()
        {
            idaSLIP_LINE.SetSelectParamValue("W_ACCOUNT_CODE_TO", ACCOUNT_CODE_TO_0.EditValue);
            idaSLIP_LINE.Fill();
        }

        private void Show_Slip_Detail(object pSLIP_HEADER_ID)
        {
            int mSLIP_HEADER_ID = iString.ISNumtoZero(pSLIP_HEADER_ID);
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

        #region ----- XL Export Methods ----

        private void ExportXL()
        {
            int vCountRow = idaCUST_BALANCE_HEADER.OraSelectData.Rows.Count;
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
                bool vXLSaveOK = xlExport.XLExport(idaCUST_BALANCE_HEADER.OraSelectData, vsSaveExcelFileName, vsSheetName);
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

                int vTerritory = GetTerritory(igrCUSTOMER_HEADER.TerritoryLanguage);
                string vPeriodFrom = iString.ISNull(GL_DATE_FR_0.EditValue);
                string vPeriodTo = iString.ISNull(GL_DATE_TO_0.EditValue);
                int vPageNumber = xlPrinting.XLWirte(igrCUSTOMER_HEADER, vTerritory, vPeriodFrom, vPeriodTo);

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

        private void isAppInterfaceAdv1_AppMainButtonClick(ISAppButtonEvents e)
        {
            if (this.IsActive)
            {
                if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Search)
                {
                    SearchDB();
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddOver)
                {
                    if (idaCUST_BALANCE_HEADER.IsFocused)
                    {

                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddUnder)
                {
                    if (idaCUST_BALANCE_HEADER.IsFocused)
                    {

                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Update)
                {
                    if (idaCUST_BALANCE_HEADER.IsFocused)
                    {

                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Cancel)
                {
                    if (idaCUST_BALANCE_HEADER.IsFocused)
                    {

                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {
                    if (idaCUST_BALANCE_HEADER.IsFocused)
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

        #region ----- Form Event -----


        private void FCMF0511_Load(object sender, EventArgs e)
        {
            GL_DATE_FR_0.EditValue = iDate.ISMonth_1st(DateTime.Today);
            GL_DATE_TO_0.EditValue = DateTime.Today;            
        }

        private void FCMF0511_Shown(object sender, EventArgs e)
        {
            
        }

        private void igrSLIP_LINE_CellDoubleClick(object pSender)
        {
            try
            {
                Show_Slip_Detail(igrSLIP_LINE.GetCellValue("SLIP_HEADER_ID"));
            }
            catch (System.Exception ex)
            {
                isAppInterfaceAdv1.AppInterface.OnAppMessageEvent(ex.Message);
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

        private void ilaCUSTOMER_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCUSTOMER.SetLookupParamValue("W_ENABLED_YN", "Y");
        }

        #endregion

        #region ----- Adapter Event -----

        private void idaCUST_BALANCE_HEADER_NewRowMoved(object pSender, ISBindingEventArgs pBindingManager)
        {            
            SearchDB_Line();
        }

        #endregion

    }
}