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

namespace HRMF0719
{
    public partial class HRMF0719 : Office2007Form
    {
        #region ----- Variables -----
        ISCommonUtil.ISFunction.ISConvert iString = new ISFunction.ISConvert();
        ISCommonUtil.ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();


        #endregion;

        #region ----- Constructor -----

        public HRMF0719()
        {
            InitializeComponent();
        }

        public HRMF0719(Form pMainForm, ISAppInterface pAppInterface)
        {
            InitializeComponent();
            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;
        }

        #endregion;

        #region ----- Private Methods -----

        private void SearchDB()
        {
            if (iString.ISNull(W_CORP_ID.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10001"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                W_CORP_NAME.Focus();
                return;
            }
            if (iString.ISNull(W_STD_YYYYMM.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10015"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                W_STD_YYYYMM.Focus();
                return;
            }

            string vPERSON_NUM = iString.ISNull(IGR_PERSON.GetCellValue("PERSON_NUM"));
            int vIDX_PERSON_NUM = IGR_PERSON.GetColumnToIndex("PERSON_NUM");
            int vIDX_NAME = IGR_PERSON.GetColumnToIndex("NAME");
            try
            {
                IDA_PERSON.Fill();
            }
            catch (System.Exception ex)
            {
                MessageBoxAdv.Show(string.Format("Adapter Fill Error\n{0}", ex.Message), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }
            if (IGR_PERSON.RowCount > 0)
            {
                for (int vRow = 0; vRow < IGR_PERSON.RowCount; vRow++)
                {
                    if (vPERSON_NUM == iString.ISNull(IGR_PERSON.GetCellValue(vRow, vIDX_PERSON_NUM)))
                    {
                        IGR_PERSON.CurrentCellMoveTo(vRow, vIDX_NAME);
                    }
                }
            }
            IGR_PERSON.Focus();
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
                    IDA_YEAR_ADJUSTMENT.Update();
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Cancel)
                {
                    if (IDA_YEAR_ADJUSTMENT.IsFocused)
                    {
                        IDA_YEAR_ADJUSTMENT.Cancel();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {
                    if (IDA_YEAR_ADJUSTMENT.IsFocused)
                    {
                        IDA_YEAR_ADJUSTMENT.Delete();
                    }
                }
            }
        }

        #endregion;

        #region ----- Form event -----

        private void HRMF0719_Load(object sender, EventArgs e)
        {

        }

        private void HRMF0719_Shown(object sender, EventArgs e)
        {
            // Lookup SETTING
            ildCORP_0.SetLookupParamValue("W_PAY_CONTROL_YN", "Y");
            ildCORP_0.SetLookupParamValue("W_ENABLED_FLAG_YN", "Y");

            // LOOKUP DEFAULT VALUE SETTING - CORP
            idcDEFAULT_CORP.SetCommandParamValue("W_PAY_CONTROL_YN", "Y");
            idcDEFAULT_CORP.SetCommandParamValue("W_ENABLED_FLAG_YN", "Y");
            idcDEFAULT_CORP.ExecuteNonQuery();
            W_CORP_NAME.EditValue = idcDEFAULT_CORP.GetCommandParamValue("O_CORP_NAME");
            W_CORP_ID.EditValue = idcDEFAULT_CORP.GetCommandParamValue("O_CORP_ID");

            // Standard Date SETTING
            // Standard Date SETTING
            //if (DateTime.Today.Month <= 2)
            //{
            //    DateTime dLastYearMonthDay = new DateTime(DateTime.Today.AddYears(-1).Year, 12, 31);
            //    STANDARD_DATE_0.EditValue = dLastYearMonthDay;
            //}
            //else
            //{
            //    DateTime dLastYearMonthDay = new DateTime(DateTime.Today.Year, 12, 31);
            //    STANDARD_DATE_0.EditValue = dLastYearMonthDay;
            //}
            if (DateTime.Today.Month <= 2)
            {
                W_STD_YYYYMM.EditValue = iDate.ISYearMonth(iDate.ISDate_Add(string.Format("{0}-01-01", DateTime.Today.Year), -1));
            }
            else
            {
                W_STD_YYYYMM.EditValue = iDate.ISYearMonth(DateTime.Today);
            }
            YEAR_YYYY.EditValue = W_STD_YYYYMM.DateTimeValue.Year.ToString();

            W_PERSON_NAME.Focus();
        }

        private void btnCalculation_ButtonClick(object pSender, EventArgs pEventArgs)
        {
             
        }
         
        #endregion

        #region ----- Lookup Event -----

        private void ilaYYYYMM_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildYYYYMM.SetLookupParamValue("W_END_YYYYMM", iDate.ISYearMonth(iDate.ISDate_Month_Add(DateTime.Today, 3)));
        }


        private void ilaDEPT_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildDEPT.SetLookupParamValue("W_USABLE_CHECK_YN", "Y");
        }

        private void ILA_W_FLOOR_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", "FLOOR");
            ildCOMMON.SetLookupParamValue("W_ENABLED_FLAG_YN", "Y");
        }

        private void ILA_W_EMPLOYE_TYPE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", "YEAR_EMPLOYE_TYPE");
            ildCOMMON.SetLookupParamValue("W_ENABLED_FLAG_YN", "Y");
        }

        #endregion

    }
}