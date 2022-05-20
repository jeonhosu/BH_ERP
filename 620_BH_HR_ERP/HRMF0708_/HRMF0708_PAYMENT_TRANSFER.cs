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

namespace HRMF0708
{
    public partial class HRMF0708_PAYMENT_SEND : Office2007Form
    {
        ISFunction.ISConvert iString = new ISFunction.ISConvert();
        ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        object mYEAR;
        object mSTART_DATE;
        object mEND_DATE;
        object mCORP_NAME;
        object mCORP_ID;
        object mDEPT_NAME;
        object mDEPT_ID;
        object mNAME;
        object mPERSON_NUM;
        object mPERSON_ID;

        #region ----- Variables -----

        #endregion;

        #region ----- Constructor -----

        public HRMF0708_PAYMENT_SEND(Form pMainForm, ISAppInterface pAppInterface, object pYear, object pStartDate, object pEndDate,
                                     object pCorpName, object pCorpID, object pDeptName, object pDeptID, object pName, object pPersonNum, object pPersonID)
        {
            InitializeComponent();
            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;

            mYEAR = pYear;
            mSTART_DATE = pStartDate;
            mEND_DATE = pEndDate;
            mCORP_NAME = pCorpName;
            mCORP_ID = pCorpID;
            mDEPT_NAME = pDeptName;
            mDEPT_ID = pDeptID;
            mNAME = pName;
            mPERSON_NUM = pPersonNum;
            mPERSON_ID = pPersonID;
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

        #region ----- Form Event -----
        private void HRMF0708_SET_PAYMENT_Load(object sender, EventArgs e)
        {
            STD_YEAR.EditValue = mYEAR;
            START_DATE.EditValue = mSTART_DATE;
            END_DATE.EditValue = mEND_DATE;
            CORP_NAME.EditValue = mCORP_NAME;
            CORP_ID.EditValue = mCORP_ID;
            DEPT_NAME.EditValue = mDEPT_NAME;
            DEPT_ID.EditValue = mDEPT_ID;
            NAME.EditValue = mNAME;
            PERSON_NUM.EditValue = mPERSON_NUM;
            PERSON_ID.EditValue = mPERSON_ID;

            // 적용 급여 년월
            PAY_YYYYMM.EditValue = iDate.ISYearMonth(DateTime.Today);
            iedSTART_DATE.EditValue = iDate.ISMonth_1st(DateTime.Today);
            iedEND_DATE.EditValue = iDate.ISMonth_Last(DateTime.Today);

            //iedSTART_DATE.EditValue = iDate.ISMonth_1st(DateTime.Today.ToString("yyyy-MM-dd", null));
            //iedEND_DATE.EditValue = iDate.ISMonth_Last(DateTime.Today.ToString("yyyy-MM-dd", null));

            // 전송일자
            //SEND_DATE.EditValue = DateTime.Today.ToString("yyyy-MM-dd", null);

            // 전송자
            string sUserName = string.Format("{0}", isAppInterfaceAdv1.DISPLAY_NAME);
            SEND_FROM.EditValue = sUserName;
        }

        #endregion              

        private void ibtSEND_ButtonClick(object pSender, EventArgs pEventArgs)
        {// 연말정산내역 급여전송 내용            
            if (CORP_ID.EditValue == null)
            {//업체
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10001"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                CORP_NAME.Focus();
                return; 
            }
            if (STD_YEAR.EditValue == null)
            {//적용 년도
                STD_YEAR.Focus();
                return;
            }
            if (iString.ISNull(START_DATE.EditValue) == string.Empty)
            {//적용 시작일자
                START_DATE.Focus();
                return; 
            }
            if (iString.ISNull(END_DATE.EditValue) == string.Empty)
            {//적용 종료일자
                END_DATE.Focus();
                return;
            }
            if (iString.ISNull(WAGE_TYPE.EditValue) == string.Empty)
            {//급상여 구분
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10105"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                WAGE_TYPE_NAME.Focus();
                return;
            }
            if (iString.ISNull(PAY_YYYYMM.EditValue) == String.Empty)
            {// 적용 급여년월
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10036"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                PAY_YYYYMM.Focus();
                return;
            }
            string mSTATUS = "F";
            string mMESSAGE = String.Empty;
            idcTRANSFER_PAYMENT.ExecuteNonQuery();
            mSTATUS = iString.ISNull(idcTRANSFER_PAYMENT.GetCommandParamValue("O_STATUS"));
            mMESSAGE = iString.ISNull(idcTRANSFER_PAYMENT.GetCommandParamValue("O_MESSAGE"));
            if (idcTRANSFER_PAYMENT.ExcuteError || mSTATUS == "F")
            {
                if (mMESSAGE != string.Empty)
                {
                    MessageBoxAdv.Show(mMESSAGE, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
            }
            MessageBoxAdv.Show(mMESSAGE, "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);
        }

        private void ibtCLOSE_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            this.Close();
        }

        private void ilaWAGE_TYPE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCOMMON_W.SetLookupParamValue("W_GROUP_CODE", "CLOSING_TYPE");
            ildCOMMON_W.SetLookupParamValue("W_WHERE", "HC.VALUE1 = 'PAY' ");
            ildCOMMON_W.SetLookupParamValue("W_ENABLED_FLAG_YN", "Y");
        }

        private void ilaYYYYMM_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildYYYYMM.SetLookupParamValue("W_START_YYYYMM", "2001-01");
            ildYYYYMM.SetLookupParamValue("W_END_YYYYMM", iDate.ISYearMonth(DateTime.Today));
        }

        private void ilaYEAR_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildYEAR.SetLookupParamValue("W_START_YEAR", "2001");
            ildYEAR.SetLookupParamValue("W_END_YEAR", iDate.ISYear(DateTime.Today));
        }

        private void ilaDEPT_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildDEPT.SetLookupParamValue("W_USABLE_CHECK_YN", "Y");
        }

        #region ----- Lookup Event -----
        #endregion
                
    }
}