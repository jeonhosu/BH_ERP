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

namespace HRMF0315
{
    public partial class HRMF0315_TRAN_PAYMENT : Office2007Form
    {
        # region    ----- Variables -----
        ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();
        ISFunction.ISConvert iString = new ISFunction.ISConvert();
        
        object mCorp_ID;
        object mCorp_Name;
        object mDept_ID;
        object mDept_Name;
        object mDuty_Year;
        object mPerson_ID;
        object mPerson_Name;
        object mSTD_Date;

        #endregion
 
        public HRMF0315_TRAN_PAYMENT(ISAppInterface pAppInterface
            , object pCorp_id, object pCorp_Name, object pDept_ID, object pDept_Name
            , object pPerson_ID, object pPerson_Name, object pSTD_Date)
        {
            InitializeComponent();
            isAppInterfaceAdv1.AppInterface = pAppInterface;

            mCorp_ID = pCorp_id;
            mCorp_Name = pCorp_Name;
            mDept_ID = pDept_ID;
            mDept_Name = pDept_Name;
            mDuty_Year = iDate.ISYear(Convert.ToDateTime(pSTD_Date));
            mPerson_ID = pPerson_ID;
            mPerson_Name = pPerson_Name;
            mSTD_Date = pSTD_Date;
        }

        #region ----- Form Event -----

        private void HRMF0315_TRAN_PAYMENT_Load(object sender, EventArgs e)
        {
            CORP_ID.EditValue = mCorp_ID;
            CORP_NAME.EditValue = mCorp_Name;
            DEPT_ID.EditValue = mDept_ID;
            DEPT_NAME.EditValue = mDept_Name;
            DUTY_YEAR.EditValue = mDuty_Year;
            PERSON_ID.EditValue = mPerson_ID;
            NAME.EditValue = mPerson_Name;
            STD_DATE.EditValue = mSTD_Date;
        }

        private void ibtCANCEL_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            this.Close();
        }

        private void ibtCREATE_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            string sMessage = null;
            if (iString.ISNull(DUTY_YEAR.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Duty Year(적용년도)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }
            if (STD_DATE.EditValue == null)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10010"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }
            if (CORP_ID.EditValue == null)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Corporation(업체)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }

           
            if (sMessage != null)
            {
                MessageBoxAdv.Show(sMessage, "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            }
        }
        #endregion

        #region ----- Lookup Event -----
        private void ilaPERSON_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            DateTime mSTD_DATE = Convert.ToDateTime(STD_DATE.EditValue);
            ildPERSON.SetLookupParamValue("W_START_DATE", iDate.ISMonth_1st(mSTD_DATE));
            ildPERSON.SetLookupParamValue("W_END_DATE", iDate.ISMonth_Last(mSTD_DATE));
        }

        private void ilaDEPT_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildDEPT.SetLookupParamValue("W_USABLE_CHECK_YN", "Y");
        }

        private void ilaWAGE_TYPE_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCOMMON_W.SetLookupParamValue("W_GROUP_CODE", "CLOSING_TYPE");
            ildCOMMON_W.SetLookupParamValue("W_WHERE", "HC.VALUE1 = 'PAY' ");
            ildCOMMON_W.SetLookupParamValue("W_ENABLED_FLAG_YN", "N");
        }

        private void ilaYYYYMM_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildYYYYMM.SetLookupParamValue("W_START_YYYYMM", "2001-01");
            ildYYYYMM.SetLookupParamValue("W_END_YYYYMM", iDate.ISYearMonth(DateTime.Today));
        }

        #endregion

    }
}