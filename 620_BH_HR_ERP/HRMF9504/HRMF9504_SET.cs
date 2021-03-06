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

namespace HRMF9504
{
    public partial class HRMF9504_SET : Office2007Form
    {
        
        #region ----- Variables -----

        ISFunction.ISConvert iString = new ISFunction.ISConvert();
        ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        object mCORP_ID;
        object mCORP_NAME;
        object mPAY_YYYYMM;
        object mWAGE_TYPE;
        object mWAGE_TYPE_NAME;

        #endregion;

        #region ----- Constructor -----

        public HRMF9504_SET(ISAppInterface pAppInterface, object pCorp_ID, object pCorp_NAME, object pPay_YYYYMM
                                    , object pWage_Type, object pWage_Type_NAME)
        {
            InitializeComponent();
            isAppInterfaceAdv1.AppInterface = pAppInterface;

            mCORP_ID = pCorp_ID;
            mCORP_NAME = pCorp_NAME;
            mPAY_YYYYMM = pPay_YYYYMM;
            mWAGE_TYPE = pWage_Type;
            mWAGE_TYPE_NAME = pWage_Type_NAME;
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

        private void HRMF9504_SET_PAYMENT_Load(object sender, EventArgs e)
        {
            
        }

        private void HRMF9504_SET_Shown(object sender, EventArgs e)
        {
            CORP_NAME.EditValue = mCORP_NAME;
            CORP_ID.EditValue = mCORP_ID;
            PAY_YYYYMM.EditValue = mPAY_YYYYMM;
            START_DATE.EditValue = iDate.ISMonth_1st(mPAY_YYYYMM.ToString());
            END_DATE.EditValue = iDate.ISMonth_Last(mPAY_YYYYMM.ToString());
            WAGE_TYPE.EditValue = mWAGE_TYPE;
            WAGE_TYPE_NAME.EditValue = mWAGE_TYPE_NAME;

            idcSUPPLY_DATE.ExecuteNonQuery();
            SUPPLY_DATE.EditValue = idcSUPPLY_DATE.GetCommandParamValue("O_SUPPLY_DATE");
            idcSTANDARD_DATE.ExecuteNonQuery();
            STANDARD_DATE.EditValue = idcSTANDARD_DATE.GetCommandParamValue("O_STANDARD_DATE");

            Application.UseWaitCursor = false;
            this.Cursor = Cursors.Default;
            Application.DoEvents();
        }
         
        private void ibtCREATE_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            if (iString.ISNull(PAY_YYYYMM.EditValue) == String.Empty)
            {// 급여년월
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10036"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                PAY_YYYYMM.Focus();
                return;
            }
            if (iString.ISNull(WAGE_TYPE.EditValue) == string.Empty)
            {// 급상여 구분
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10105"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                WAGE_TYPE_NAME.Focus();
                return;
            }
            if (iString.ISNull(STANDARD_DATE.EditValue) == string.Empty)
            {// 기준일자 구분
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10110"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                STANDARD_DATE.Focus();
                return;
            }
            if (iString.ISNull(SUPPLY_DATE.EditValue) == string.Empty)
            {// 지급일자 구분
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10111"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                SUPPLY_DATE.Focus();
                return;
            }

            Application.UseWaitCursor = true;
            this.Cursor = Cursors.WaitCursor;
            Application.DoEvents();

            string vSTATUS = "F";
            string vMESSAGE = null;

            idcSET_PAYMENT.ExecuteNonQuery();
            vSTATUS = iString.ISNull(idcSET_PAYMENT.GetCommandParamValue("O_STATUS"));
            vMESSAGE = iString.ISNull(idcSET_PAYMENT.GetCommandParamValue("O_MESSAGE"));

            Application.UseWaitCursor = false;
            this.Cursor = Cursors.Default;
            Application.DoEvents();

            if (idcSET_PAYMENT.ExcuteError || vSTATUS == "F")
            {
                if (vMESSAGE != string.Empty)
                {
                    MessageBoxAdv.Show(vMESSAGE, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
                return;
            }

            if (vMESSAGE != string.Empty)
            {
                MessageBoxAdv.Show(vMESSAGE, "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }

            DialogResult = DialogResult.OK;
            this.Close();
        }

        private void ibtCANCEL_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            DialogResult = DialogResult.None;
            this.Close();
        }

        #endregion              

        #region ----- Lookup Event -----

        private void ilaCORP_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCORP.SetLookupParamValue("W_ENABLED_FLAG_YN", "Y");
        }

        private void ilaWAGE_TYPE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCOMMON_W.SetLookupParamValue("W_GROUP_CODE", "CLOSING_TYPE");
            ildCOMMON_W.SetLookupParamValue("W_WHERE", "HC.VALUE1 = 'PAY' ");
            ildCOMMON_W.SetLookupParamValue("W_ENABLED_FLAG_YN", "N");
        }

        private void ilaPAY_TYPE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", "PAY_TYPE");
            ildCOMMON.SetLookupParamValue("W_ENABLED_FLAG", "N");
        }

        private void ilaDEPT_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildDEPT.SetLookupParamValue("W_USABLE_CHECK_YN", "N");
        }

        private void ilaYYYYMM_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildYYYYMM.SetLookupParamValue("W_START_YYYYMM", "2001-01");
            ildYYYYMM.SetLookupParamValue("W_END_YYYYMM", iDate.ISYearMonth(DateTime.Today));
        }

        private void ilaPERSON_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildPERSON.SetLookupParamValue("W_CORP_TYPE", "4");
        }

        #endregion

               
    }
}