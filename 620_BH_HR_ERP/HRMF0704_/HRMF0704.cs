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

namespace HRMF0704
{
    public partial class HRMF0704 : Office2007Form
    {
        #region ----- Variables -----
        ISCommonUtil.ISFunction.ISConvert iString = new ISFunction.ISConvert();
        ISCommonUtil.ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();


        #endregion;

        #region ----- Constructor -----

        public HRMF0704()
        {
            InitializeComponent();
        }

        public HRMF0704(Form pMainForm, ISAppInterface pAppInterface)
        {
            InitializeComponent();
            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;
        }

        #endregion;

        #region ----- Private Methods -----

        private void SearchDB()
        {
            if (iString.ISNull(CORP_ID_0.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10001"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                CORP_NAME_0.Focus();
                return;
            }
            if (iString.ISNull(STANDARD_DATE_0.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10015"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                STANDARD_DATE_0.Focus();
                return;
            }

            YEAR_YYYY_0.EditValue = STANDARD_DATE_0.DateTimeValue.Year.ToString();
            if (iString.ISNull(YEAR_YYYY_0.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10022"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                STANDARD_DATE_0.Focus();
                return;
            }

            string vMessage = string.Empty;
            try
            {
                idaPERSON.Fill();
            }
            catch (System.Exception ex)
            {
                vMessage = string.Format("Adapter Fill Error\n{0}", ex.Message);
                MessageBoxAdv.Show(vMessage, "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            }        
        }

        //// Person Info 그리드를 선택 시, Person ID 및 Year 정보를 체크한 후 idaFOUNDATION에 정보를 출력해주는 함수
        //private void SearchDB_YearAdjustment()
        //{
        //    if (iString.ISNull(igrPERSON_INFO.GetCellValue("PERSON_ID")) == string.Empty)
        //    {
        //        MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10016"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
        //        STANDARD_DATE_0.Focus();
        //        return;
        //    }
        //    YEAR_YYYY_0.EditValue = STANDARD_DATE_0.DateTimeValue.Year.ToString();
        //    if (iString.ISNull(YEAR_YYYY_0.EditValue) == string.Empty)
        //    {
        //        MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10022"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
        //        STANDARD_DATE_0.Focus();
        //        return;
        //    }
        //    idaYEAR_ADJUSTMENT.Fill();
        //}

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
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddUnder)
                {                    
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Update)
                {
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Cancel)
                {
                    if (idaYEAR_ADJUSTMENT.IsFocused)
                    {
                        idaYEAR_ADJUSTMENT.Cancel();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {                    
                }
            }
        }

        #endregion;

        #region ----- Form event -----

        private void HRMF0704_Load(object sender, EventArgs e)
        {
            
        }

        private void HRMF0704_Shown(object sender, EventArgs e)
        {
            // Lookup SETTING
            ildCORP_0.SetLookupParamValue("W_PAY_CONTROL_YN", "Y");
            ildCORP_0.SetLookupParamValue("W_ENABLED_FLAG_YN", "Y");

            // LOOKUP DEFAULT VALUE SETTING - CORP
            idcDEFAULT_CORP.SetCommandParamValue("W_PAY_CONTROL_YN", "Y");
            idcDEFAULT_CORP.SetCommandParamValue("W_ENABLED_FLAG_YN", "Y");
            idcDEFAULT_CORP.ExecuteNonQuery();
            CORP_NAME_0.EditValue = idcDEFAULT_CORP.GetCommandParamValue("O_CORP_NAME");
            CORP_ID_0.EditValue = idcDEFAULT_CORP.GetCommandParamValue("O_CORP_ID");

            // Standard Date SETTING
            if (DateTime.Today.Month <= 2)
            {
                DateTime dLastYearMonthDay = new DateTime(DateTime.Today.AddYears(-1).Year, 12, 31);
                STANDARD_DATE_0.EditValue = dLastYearMonthDay;
            }
            else
            {
                DateTime dLastYearMonthDay = new DateTime(DateTime.Today.Year, 12, 31);
                STANDARD_DATE_0.EditValue = dLastYearMonthDay;
            }

            YEAR_YYYY_0.EditValue = STANDARD_DATE_0.DateTimeValue.Year.ToString();

            PERSON_NAME_0.Focus();
        }
        
        private void btnCalculation_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            if (iString.ISNull(CORP_ID_0.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10001"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                CORP_NAME_0.Focus();
                return;
            }
            if (iString.ISNull(STANDARD_DATE_0.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10015"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                STANDARD_DATE_0.Focus();
                return;
            }

            YEAR_YYYY_0.EditValue = STANDARD_DATE_0.DateTimeValue.Year.ToString();
            if (iString.ISNull(YEAR_YYYY_0.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10022"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                STANDARD_DATE_0.Focus();
                return;
            }

            Application.UseWaitCursor = true;
            this.Cursor = Cursors.WaitCursor;
            Application.DoEvents();
            string vSTATUS = "F";
            string vMESSAGE = string.Empty;
            isDataTransaction1.BeginTran();

            idcYEAR_ADJUST_SET.ExecuteNonQuery();
            vSTATUS = iString.ISNull(idcYEAR_ADJUST_SET.GetCommandParamValue("O_STATUS"));
            vMESSAGE = iString.ISNull(idcYEAR_ADJUST_SET.GetCommandParamValue("O_MESSAGE"));
            Application.UseWaitCursor = false;
            this.Cursor = Cursors.Default;
            Application.DoEvents();
            if (idcYEAR_ADJUST_SET.ExcuteError || vSTATUS == "F")
            {
                isDataTransaction1.RollBack();
                MessageBoxAdv.Show(vMESSAGE, "", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }
            isDataTransaction1.Commit();
            isAppInterfaceAdv1.AppInterface.OnAppMessageEvent(vMESSAGE);
        }

        #endregion

        private void ilaDEPT_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildDEPT.SetLookupParamValue("W_USABLE_CHECK_YN", "Y");
        }

    }
}