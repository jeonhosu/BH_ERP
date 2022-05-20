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

namespace HRMF0538
{
    public partial class HRMF0538 : Office2007Form
    {
        #region ----- Variables -----

        private ISFunction.ISConvert iString = new ISFunction.ISConvert();
        private ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        #endregion;

        #region ----- Constructor -----

        public HRMF0538()
        {
            InitializeComponent();
        }

        public HRMF0538(Form pMainForm, ISAppInterface pAppInterface)
        {
            InitializeComponent();
            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;
        }

        #endregion;

        #region ----- Form Event -----

        private void HRMF0537_Load(object sender, EventArgs e)
        {
            PAY_YYYYMM_FR_0.EditValue = iDate.ISYearMonth(DateTime.Today);
            PAY_YYYYMM_TO_0.EditValue = iDate.ISYearMonth(DateTime.Today);
            START_DATE_0.EditValue = iDate.ISMonth_1st(DateTime.Today);
            END_DATE_0.EditValue = iDate.ISMonth_Last(DateTime.Today);

            DefaultCorporation();              //Default Corp.
        }

        #endregion

        #region ----- MDi ToolBar Button Events -----

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

                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {

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

        #region ----- Private Methods ----

        private void DefaultCorporation()
        {
            // Lookup SETTING
            ildCORP.SetLookupParamValue("W_PAY_CONTROL_YN", "Y");
            ildCORP.SetLookupParamValue("W_ENABLED_FLAG_YN", "N");

            // LOOKUP DEFAULT VALUE SETTING - CORP
            idcDEFAULT_CORP.SetCommandParamValue("W_PAY_CONTROL_YN", "Y");
            idcDEFAULT_CORP.SetCommandParamValue("W_ENABLED_FLAG_YN", "N");
            idcDEFAULT_CORP.ExecuteNonQuery();
            CORP_NAME_0.EditValue = idcDEFAULT_CORP.GetCommandParamValue("O_CORP_NAME");
            CORP_ID_0.EditValue = idcDEFAULT_CORP.GetCommandParamValue("O_CORP_ID");
        }

        private void Search_DB()
        {
            try
            {
                if (CORP_ID_0.EditValue == null)
                {
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10001"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    CORP_NAME_0.Focus();
                    return;
                }
                if (iString.ISNull(PAY_YYYYMM_FR_0.EditValue) == String.Empty)
                {// 급여년월
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10036"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    PAY_YYYYMM_FR_0.Focus();
                    return;
                }
                if (iString.ISNull(PAY_YYYYMM_TO_0.EditValue) == String.Empty)
                {// 급여년월
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10036"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    PAY_YYYYMM_TO_0.Focus();
                    return;
                }

                idaMONTH_PAYMENT_SPREAD.Fill();
                igrMONTH_PAYMENT.Focus();
            }
            catch (System.Exception ex)
            {
                isAppInterfaceAdv1.OnAppMessage(ex.Message);
                System.Windows.Forms.Application.DoEvents();
            }
        }

        private void Set_Common_Parameter(string pGroup_Code, string pEnabled_Flag_YN)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", pGroup_Code);
            ildCOMMON.SetLookupParamValue("W_ENABLED_FLAG_YN", pEnabled_Flag_YN);
        }

        #endregion;

        #region ----- Lookup Event -----

        private void ilaPAY_GRADE_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            Set_Common_Parameter("PAY_TYPE", "N");
        }

        private void ilaWAGE_TYPE_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCOMMON_W.SetLookupParamValue("W_GROUP_CODE", "CLOSING_TYPE");
            ildCOMMON_W.SetLookupParamValue("W_WHERE", "HC.VALUE1 = 'PAY' ");
            ildCOMMON_W.SetLookupParamValue("W_ENABLED_FLAG_YN", "N");
        }

        private void ilaDEPT_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildDEPT.SetLookupParamValue("W_USABLE_CHECK_YN", "N");
        }

        private void ilaYYYYMM_FR_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildYYYYMM.SetLookupParamValue("W_START_YYYYMM", "2001-01");
            ildYYYYMM.SetLookupParamValue("W_END_YYYYMM", iDate.ISYearMonth(DateTime.Today));
        }

        private void ilaYYYYMM_TO_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildYYYYMM.SetLookupParamValue("W_START_YYYYMM", PAY_YYYYMM_FR_0.EditValue);
            ildYYYYMM.SetLookupParamValue("W_END_YYYYMM", iDate.ISYearMonth(DateTime.Today));
        }

        private void ilaPERSON_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            string vYYYYMM = iString.ISNull(PAY_YYYYMM_TO_0.EditValue);
            string vYYYY = vYYYYMM.Substring(0, 4);
            string vMM = vYYYYMM.Substring(5, 2);
            int vYYYY_Integer = int.Parse(vYYYY);
            int vMM_Integer = int.Parse(vMM);
            System.DateTime vDateTime = iDate.ISMonth_Last(new System.DateTime(vYYYY_Integer, vMM_Integer, 1));
            ildPERSON_0.SetLookupParamValue("W_WORK_DATE_TO", vDateTime);
        }

        #endregion

        #region ----- XL Print 1 Methods ----

        private void XLPrinting1(string pOutChoice)
        {
            string vMessageText = string.Empty;
            int vPageNumber = 0;

            System.DateTime vTimeStart = new System.DateTime();
            System.DateTime vTimeEnd = new System.DateTime();

            int vCountRowGrid = igrMONTH_PAYMENT.RowCount;

            if (vCountRowGrid < 1)
            {
                return;
            }

            XLPrinting xlPrinting = new XLPrinting(isAppInterfaceAdv1.AppInterface, isMessageAdapter1);

            try
            {
                xlPrinting.OpenFileNameExcel = "HRMF0538_001.xls";
                
                //-------------------------------------------------------------------------------------
                bool IsOpen = xlPrinting.XLFileOpen();
                if (IsOpen == true)
                {
                    isAppInterfaceAdv1.OnAppMessage("Printing Start...");
                    vTimeStart = System.DateTime.Now;

                    System.Windows.Forms.Application.UseWaitCursor = true;
                    this.Cursor = System.Windows.Forms.Cursors.WaitCursor;
                    System.Windows.Forms.Application.DoEvents();

                    string vUserName = isAppInterfaceAdv1.AppInterface.LoginDescription;

                    string vCORP_NAME = CORP_NAME_0.EditValue as string;
                    string vYYYYMM_FROM = PAY_YYYYMM_FR_0.EditValue as string;
                    string vYYYYMM_TO = PAY_YYYYMM_TO_0.EditValue as string;
                    vPageNumber = xlPrinting.LineWrite(igrMONTH_PAYMENT, vUserName, vCORP_NAME, vYYYYMM_FROM, vYYYYMM_TO);

                    string vSaveFile = string.Format("BH_PAY_{0}~{1}_", vYYYYMM_FROM, vYYYYMM_TO);
                    if (pOutChoice == "PRINT")
                    {
                        xlPrinting.SAVE(vSaveFile); //저장 파일명
                        xlPrinting.Printing(1, vPageNumber); //시작 페이지 번호, 종료 페이지 번호
                    }
                    else if (pOutChoice == "FILE")
                    {
                        xlPrinting.SAVE(vSaveFile); //저장 파일명
                    }
                    //-------------------------------------------------------------------------
                }
                else
                {
                    xlPrinting.Dispose();
                }
            }
            catch (System.Exception ex)
            {
                string vMessage = ex.Message;
                xlPrinting.Dispose();
            }

            xlPrinting.Dispose();

            vTimeEnd = System.DateTime.Now;
            System.TimeSpan vTimeSpan = vTimeEnd - vTimeStart;

            vMessageText = string.Format("Print End! [Page : {0}] - {1}", vPageNumber, vTimeSpan.ToString());
            isAppInterfaceAdv1.OnAppMessage(vMessageText);

            System.Windows.Forms.Application.UseWaitCursor = false;
            this.Cursor = System.Windows.Forms.Cursors.Default;
            System.Windows.Forms.Application.DoEvents();
        }

        #endregion;
    }
}