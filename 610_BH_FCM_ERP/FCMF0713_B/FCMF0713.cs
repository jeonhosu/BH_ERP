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

namespace FCMF0713
{
    public partial class FCMF0713 : Office2007Form
    {
        #region ----- Variables -----

        ISFunction.ISConvert iString = new ISFunction.ISConvert();
        ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        #endregion;

        #region ----- Constructor -----

        public FCMF0713()
        {
            InitializeComponent();
        }

        public FCMF0713(Form pMainForm, ISAppInterface pAppInterface)
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

            idaBALANCE_IS.Fill();
            igrBALANCE_IS.Focus();
        }

        private void SetGridPeriod()
        {
            if (iString.ISNull(PERIOD_NAME_0.EditValue) == string.Empty)
            {
                return;
            }
            DateTime mCurrent_Date;
            object mYEAR_COUNT;

            // 당기 기간/회계기수 설정
            idcPROMPT_YEAR.SetCommandParamValue("W_PERIOD_NAME", PERIOD_NAME_0.EditValue);
            idcPROMPT_YEAR.ExecuteNonQuery();
            mYEAR_COUNT = idcPROMPT_YEAR.GetCommandParamValue("O_PROMPT");
            igrBALANCE_IS.GridAdvExColElement[2].HeaderElement[1].TL1_KR = iString.ISNull(mYEAR_COUNT);

            idcPROMPT_PERIOD_YEAR.SetCommandParamValue("W_PERIOD_NAME", PERIOD_NAME_0.EditValue);
            idcPROMPT_PERIOD_YEAR.ExecuteNonQuery();
            THIS_YEAR_PERIOD.EditValue = idcPROMPT_PERIOD_YEAR.GetCommandParamValue("O_PROMPT");

            // 전기 기간/회계기수 설정
            mCurrent_Date = Convert.ToDateTime(string.Format("{0}{1}", PERIOD_NAME_0.EditValue, "-01"));
            mCurrent_Date = Convert.ToDateTime(string.Format("{0}-{1}-{2}", mCurrent_Date.Year - 1, mCurrent_Date.Month, "01"));
            idcPROMPT_YEAR.SetCommandParamValue("W_PERIOD_NAME", iDate.ISYearMonth(mCurrent_Date));
            idcPROMPT_YEAR.ExecuteNonQuery();
            mYEAR_COUNT = idcPROMPT_YEAR.GetCommandParamValue("O_PROMPT");
            igrBALANCE_IS.GridAdvExColElement[4].HeaderElement[1].TL1_KR = iString.ISNull(mYEAR_COUNT);

            idcPROMPT_PERIOD_YEAR.SetCommandParamValue("W_PERIOD_NAME", iDate.ISYearMonth(mCurrent_Date));
            idcPROMPT_PERIOD_YEAR.ExecuteNonQuery();
            PREVIOUS_YEAR_PERIOD.EditValue = idcPROMPT_PERIOD_YEAR.GetCommandParamValue("O_PROMPT");

            igrBALANCE_IS.ResetDraw = true;
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
                    if (idaBALANCE_IS.IsFocused)
                    {
                        idaBALANCE_IS.Cancel();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {
                    if (idaBALANCE_IS.IsFocused)
                    {
                        idaBALANCE_IS.Delete();
                    }
                }
            }
        }

        #endregion;

        #region ----- Form Event -----

        private void FCMF0713_Load(object sender, EventArgs e)
        {

        }

        private void FCMF0713_Shown(object sender, EventArgs e)
        {
            PERIOD_NAME_0.EditValue = iDate.ISYearMonth(DateTime.Today);
            SetGridPeriod();
        }

        #endregion
        
        #region ----- Lookup Event -----

        private void ilaPERIOD_NAME_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {

        }

        #endregion

    }
}