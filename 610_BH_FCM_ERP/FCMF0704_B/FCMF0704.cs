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

namespace FCMF0704
{
    public partial class FCMF0704 : Office2007Form
    {
        #region ----- Variables -----

        ISFunction.ISConvert iString = new ISFunction.ISConvert();
        ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        #endregion;

        #region ----- Constructor -----

        public FCMF0704()
        {
            InitializeComponent();
        }

        public FCMF0704(Form pMainForm, ISAppInterface pAppInterface)
        {
            InitializeComponent();
            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;
        }

        #endregion;

        #region ----- Private Methods ----

        private void SearchDB()
        {
            if (iString.ISNull(PERIOD_NAME_0.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10036"), "Waring", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                PERIOD_NAME_0.Focus();
                return;
            }
            SetGridPeriod();

            idaBALANCE_BS.Fill();
            igrBALANCE_BS.Focus();
        }

        //private void SetCommonParameter(object pGroup_Code, object pEnabled_YN)
        //{
        //    ildCOMMON.SetLookupParamValue("W_GROUP_CODE", pGroup_Code);
        //    ildCOMMON.SetLookupParamValue("W_ENABLED_YN", pEnabled_YN);
        //}

        private void SetGridPeriod()
        {
            if (iString.ISNull(PERIOD_NAME_0.EditValue) == string.Empty)
            {
                return;
            }
            DateTime mCurrent_Date;
            object mPeriod_Year;
            object mYear_Count;
            //당기
            mCurrent_Date = iDate.ISMonth_Last(Convert.ToDateTime(string.Format("{0}{1}", PERIOD_NAME_0.EditValue, "-01")));
            mPeriod_Year = PERIOD_NAME_0.EditValue.ToString().Substring(0, 4);
            idcYEAR_COUNT.SetCommandParamValue("W_PERIOD_YEAR", mPeriod_Year);
            idcYEAR_COUNT.ExecuteNonQuery();
            mYear_Count = idcYEAR_COUNT.GetCommandParamValue("O_YEAR_COUNT");
            mPeriod_Year = isMessageAdapter1.ReturnText("FCM_10246", "&&VALUE:=" + mYear_Count);
            igrBALANCE_BS.GridAdvExColElement[2].HeaderElement[1].TL1_KR = iString.ISNull(mPeriod_Year);
            THIS_YEAR_PERIOD.EditValue = isMessageAdapter1.ReturnText("FCM_10248", "&&VALUE:=" + mYear_Count + "&&YEAR:=" + mCurrent_Date.Year + "&&MONTH:=" + mCurrent_Date.Month + "&&DAY:=" + mCurrent_Date.Day);

            //전기.
            mCurrent_Date = Convert.ToDateTime(string.Format("{0}{1}", PERIOD_NAME_0.EditValue, "-01"));
            mPeriod_Year = iDate.ISYear(mCurrent_Date, -1);
            mCurrent_Date = Convert.ToDateTime(string.Format("{0}{1}", mPeriod_Year, "-12-31"));
            idcYEAR_COUNT.SetCommandParamValue("W_PERIOD_YEAR", mPeriod_Year);
            idcYEAR_COUNT.ExecuteNonQuery();
            mYear_Count = idcYEAR_COUNT.GetCommandParamValue("O_YEAR_COUNT");
            mPeriod_Year = isMessageAdapter1.ReturnText("FCM_10247", "&&VALUE:=" + mYear_Count);
            igrBALANCE_BS.GridAdvExColElement[4].HeaderElement[1].TL1_KR = iString.ISNull(mPeriod_Year);
            PREVIOUS_YEAR_PERIOD.EditValue = isMessageAdapter1.ReturnText("FCM_10248", "&&VALUE:=" + mYear_Count + "&&YEAR:=" + mCurrent_Date.Year + "&&MONTH:=" + mCurrent_Date.Month + "&&DAY:=" + mCurrent_Date.Day);            
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
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddUnder)
                {
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Update)
                {
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Cancel)
                {
                    if (idaBALANCE_BS.IsFocused)
                    {
                        idaBALANCE_BS.Cancel();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {
                }
            }
        }

        #endregion;

        #region ----- FORM EVENT -----
        
        private void FCMF0704_Load(object sender, EventArgs e)
        {

        }

        private void FCMF0704_Shown(object sender, EventArgs e)
        {
            PERIOD_NAME_0.EditValue = iDate.ISYearMonth(DateTime.Today);
            SetGridPeriod();
        }

        #endregion

        #region ----- LOOKUP EVENT -----

        #endregion
        

    }
}