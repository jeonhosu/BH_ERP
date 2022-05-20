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

namespace FCMF0705
{
    public partial class FCMF0705 : Office2007Form
    {
        #region ----- Variables -----

        ISFunction.ISConvert iString = new ISFunction.ISConvert();
        ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        #endregion;

        #region ----- Constructor -----

        public FCMF0705()
        {
            InitializeComponent();
        }

        public FCMF0705(Form pMainForm, ISAppInterface pAppInterface)
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

            // 당기 기간/회계기수 설정
            idcPROMPT_YEAR_COUNT.SetCommandParamValue("W_PERIOD_NAME", PERIOD_NAME_0.EditValue);
            idcPROMPT_YEAR_COUNT.ExecuteNonQuery();
            mYear_Count = idcPROMPT_YEAR_COUNT.GetCommandParamValue("O_PROMPT");
            igrBALANCE_BS.GridAdvExColElement[2].HeaderElement[1].TL1_KR = iString.ISNull(mYear_Count);

            idcPROMPT_PERIOD_MONTH.SetCommandParamValue("W_PERIOD_NAME", PERIOD_NAME_0.EditValue);
            idcPROMPT_PERIOD_MONTH.ExecuteNonQuery();
            THIS_YEAR_PERIOD.EditValue = idcPROMPT_PERIOD_MONTH.GetCommandParamValue("O_PROMPT");

            // 전기 기간/회계기수 설정
            mCurrent_Date = Convert.ToDateTime(string.Format("{0}{1}", PERIOD_NAME_0.EditValue, "-01"));
            mPeriod_Year = iDate.ISYear(mCurrent_Date, -1);

            idcPROMPT_YEAR_COUNT.SetCommandParamValue("W_PERIOD_NAME", String.Format("{0}{1}", mPeriod_Year, "-12"));
            idcPROMPT_YEAR_COUNT.ExecuteNonQuery();
            mYear_Count = idcPROMPT_YEAR_COUNT.GetCommandParamValue("O_PROMPT");
            igrBALANCE_BS.GridAdvExColElement[4].HeaderElement[1].TL1_KR = iString.ISNull(mYear_Count);

            idcPROMPT_PERIOD_MONTH.SetCommandParamValue("W_PERIOD_NAME", String.Format("{0}{1}", mPeriod_Year, "-12"));
            idcPROMPT_PERIOD_MONTH.ExecuteNonQuery();
            PREVIOUS_YEAR_PERIOD.EditValue = idcPROMPT_PERIOD_MONTH.GetCommandParamValue("O_PROMPT");

            igrBALANCE_BS.ResetDraw = true;
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
        
        private void FCMF0705_Load(object sender, EventArgs e)
        {

        }

        private void FCMF0705_Shown(object sender, EventArgs e)
        {
            PERIOD_NAME_0.EditValue = iDate.ISYearMonth(DateTime.Today);
            SetGridPeriod();
        }

        #endregion

        #region ----- LOOKUP EVENT -----

        #endregion
        

    }
}