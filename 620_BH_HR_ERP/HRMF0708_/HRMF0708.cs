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

namespace HRMF0708
{
    public partial class HRMF0708 : Office2007Form
    {
        #region ----- Variables -----
        ISCommonUtil.ISFunction.ISConvert iString = new ISFunction.ISConvert();
        ISCommonUtil.ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();


        #endregion;

        #region ----- Constructor -----

        public HRMF0708()
        {
            InitializeComponent();
        }

        public HRMF0708(Form pMainForm, ISAppInterface pAppInterface)
        {
            InitializeComponent();
            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;
        }

        #endregion;

        #region ----- Private Methods ----


        #endregion;

        #region ----- Events -----

        private void isAppInterfaceAdv1_AppMainButtonClick(ISAppButtonEvents e)
        {
            if (this.IsActive)
            {
                if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Search)
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
                    idaTAX_SUMMERY.Fill();
                    
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
            }
        }

        #endregion;

        #region ----- Form Event ------
        
        private void HRMF0708_Load(object sender, EventArgs e)
        {
            // Lookup SETTING
            ildCORP_0.SetLookupParamValue("W_PAY_CONTROL_YN", "Y");
            ildCORP_0.SetLookupParamValue("W_ENABLED_FLAG_YN", "N");

            // LOOKUP DEFAULT VALUE SETTING - CORP
            idcDEFAULT_CORP.SetCommandParamValue("W_PAY_CONTROL_YN", "Y");
            idcDEFAULT_CORP.SetCommandParamValue("W_ENABLED_FLAG_YN", "N");
            idcDEFAULT_CORP.ExecuteNonQuery();
            CORP_NAME_0.EditValue = idcDEFAULT_CORP.GetCommandParamValue("O_CORP_NAME");
            CORP_ID_0.EditValue = idcDEFAULT_CORP.GetCommandParamValue("O_CORP_ID");

            // Standard Date SETTING
            DateTime dLastYearMonthDay = new DateTime(DateTime.Today.Year, 12, 31);
            STANDARD_DATE_0.EditValue = dLastYearMonthDay;

            idaTAX_SUMMERY.FillSchema();

            CORP_NAME_0.Focus();
        }

        private void btnPayTransfer_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            if (STANDARD_DATE_0.EditValue == null)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10036"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                STANDARD_DATE_0.Focus();
                return;
            }

            object Year = STANDARD_DATE_0.DateTimeValue.Year.ToString();   //적용년도
            DateTime StartDate = new DateTime(STANDARD_DATE_0.DateTimeValue.Year, STANDARD_DATE_0.DateTimeValue.Month, 1); //적용 시작일자
            object EndDate = StartDate.AddMonths(1).AddDays(-1); //적용 종료일자

            Form vHRMF0708_PAYMENT_SEND = new HRMF0708_PAYMENT_SEND(this.MdiParent, isAppInterfaceAdv1.AppInterface,
                                                                    Year, (object)StartDate, EndDate, CORP_NAME_0.EditValue, CORP_ID_0.EditValue, DEPT_NAME_0.EditValue, DEPT_ID_0.EditValue,
                                                                    PERSON_NAME_0.EditValue, PERSON_NUM_0.EditValue, PERSON_ID_0.EditValue);
            vHRMF0708_PAYMENT_SEND.Show();
        }

        #endregion

        #region ----- Lookup Event -----

        private void ILA_W_FLOOR_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", "FLOOR");
            ildCOMMON.SetLookupParamValue("W_ENABLED_FLAG_YN", "Y");
        }

        private void ILA_JOB_CATEGORY_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", "JOB_CATEGORY");
            ildCOMMON.SetLookupParamValue("W_ENABLED_FLAG_YN", "Y");
        }

        private void ilaCORP_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCORP_0.SetLookupParamValue("W_PAY_CONTROL_YN", "Y");
        }

        #endregion


    }
}