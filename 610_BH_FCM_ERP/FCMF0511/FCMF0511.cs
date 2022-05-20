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

        private string mCompany = string.Empty;

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

        #region ----- XL Print 1 Methods ----

        private void XLPrinting1(string pOutChoice)
        {
            string vMessageText = string.Empty;
            int vPageNumber = 0;

            int vCountRow = igrSLIP_LINE.RowCount;

            if (vCountRow < 1)
            {
                isAppInterfaceAdv1.OnAppMessage("No Data");
                System.Windows.Forms.Application.DoEvents();
                return;
            }

            XLPrinting xlPrinting = new XLPrinting(isAppInterfaceAdv1.AppInterface, isMessageAdapter1);

            try
            {
                //-------------------------------------------------------------------------
                xlPrinting.OpenFileNameExcel = "FCMF0511_001.xls";
                
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
                    string vPeriod = string.Format("기간 : {0}~{1}", vPeriodFrom, vPeriodTo);

                    object vSUPP_CUST_CODE = igrCUSTOMER_HEADER.GetCellValue("SUPP_CUST_CODE");
                    object vSUPP_CUST_NAME = igrCUSTOMER_HEADER.GetCellValue("SUPP_CUST_NAME");
                    string vSupplierCustomerName = string.Format("거래처 : [{0}] {1}", vSUPP_CUST_CODE, vSUPP_CUST_NAME);

                    vPageNumber = xlPrinting.LineWrite(igrSLIP_LINE, vPeriod, vSupplierCustomerName);

                    if (pOutChoice == "PRINT")
                    {
                        //xlPrinting.Printing(1, vPageNumber);
                        xlPrinting.PreviewPrinting(1, vPageNumber);
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
                    vMessageText = string.Format("Open Error[{0}]", "FCMF0511_001.xls");
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
                    XLPrinting1("PRINT");
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Export)
                {
                    XLPrinting1("FILE");
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
            CompanySearch();
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