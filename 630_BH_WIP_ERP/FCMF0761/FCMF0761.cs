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

namespace FCMF0761
{
    public partial class FCMF0761 : Office2007Form
    {
        #region ----- Variables -----

        private ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();
        private ISFunction.ISConvert iString = new ISFunction.ISConvert();

        #endregion;

        #region ----- Constructor -----

        public FCMF0761()
        {
            InitializeComponent();
        }

        public FCMF0761(Form pMainForm, ISAppInterface pAppInterface)
        {
            InitializeComponent();
            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;
        }

        #endregion;

        #region ----- Private Methods ----

        private void SetCommonParameter(string pGroup_Code, string pEnabled_YN)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", pGroup_Code);
            ildCOMMON.SetLookupParamValue("W_ENABLED_YN", pEnabled_YN);
        }

        private void DBSearch()
        {
            object vObject1 = FS_SET_ID_0.EditValue;
            object vObject2 = PERIOD_YEAR.EditValue;
            object vObject3 = QUARTER_NAME_0.EditValue;
            if (iString.ISNull(vObject1) == string.Empty || iString.ISNull(vObject2) == string.Empty || iString.ISNull(vObject3) == string.Empty)
            {
                //재무제표양식세트, 결산년도, 결산분기를 입력하세요!
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10308"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                FS_SET_NAME_0.Focus();
                return;
            }

            idaFS_FACTORY_COST.Fill();

            SetGridPeriod();
        }

        private void SetGridPeriod()
        {
            object vObject_NAME = QUARTER_NAME_0.EditValue;
            object vValue = igrFS_FACTORY_COST.GridAdvExColElement[1].HeaderElement[1].TL1_KR;
            igrFS_FACTORY_COST.GridAdvExColElement[1].HeaderElement[1].TL1_KR = iString.ISNull(vObject_NAME);
            igrFS_FACTORY_COST.GridAdvExColElement[3].HeaderElement[1].TL1_KR = iString.ISNull("AAA");
            igrFS_FACTORY_COST.ResetDraw = true;

            //DateTime mCurrent_Date;
            //object mMonth;

            //// 당기 기간/회계기수 설정
            //idcPROMPT_MONTH.SetCommandParamValue("W_PERIOD_NAME", PERIOD_NAME_0.EditValue);
            //idcPROMPT_MONTH.ExecuteNonQuery();
            //mMonth = idcPROMPT_MONTH.GetCommandParamValue("O_PROMPT");
            //idaFS_FACTORY_COST.GridAdvExColElement[2].HeaderElement[1].TL1_KR = iString.ISNull(mMonth);

            //idcPROMPT_PERIOD_MONTH.SetCommandParamValue("W_PERIOD_NAME", PERIOD_NAME_0.EditValue);
            //idcPROMPT_PERIOD_MONTH.ExecuteNonQuery();
            //THIS_YEAR_PERIOD.EditValue = idcPROMPT_PERIOD_MONTH.GetCommandParamValue("O_PROMPT");

            //// 전기 기간/회계기수 설정
            //mCurrent_Date = Convert.ToDateTime(string.Format("{0}{1}", PERIOD_NAME_0.EditValue, "-01"));
            //mCurrent_Date = iDate.ISDate_Add(mCurrent_Date, -1);

            //idcPROMPT_MONTH.SetCommandParamValue("W_PERIOD_NAME", iDate.ISYearMonth(mCurrent_Date));
            //idcPROMPT_MONTH.ExecuteNonQuery();
            //mMonth = idcPROMPT_MONTH.GetCommandParamValue("O_PROMPT");
            //igrBALANCE_MS.GridAdvExColElement[4].HeaderElement[1].TL1_KR = iString.ISNull(mMonth);

            //idcPROMPT_PERIOD_MONTH.SetCommandParamValue("W_PERIOD_NAME", iDate.ISYearMonth(mCurrent_Date));
            //idcPROMPT_PERIOD_MONTH.ExecuteNonQuery();
            //PREVIOUS_YEAR_PERIOD.EditValue = idcPROMPT_PERIOD_MONTH.GetCommandParamValue("O_PROMPT");


        }

        #endregion;

        #region ----- MDi Main ToolBar Button Event -----

        private void isAppInterfaceAdv1_AppMainButtonClick(ISAppButtonEvents e)
        {
            if (this.IsActive)
            {
                if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Search)
                {
                    DBSearch();
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
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Export)
                {
                }
            }
        }

        #endregion;

        #region ----- Form Event -----

        private void FCMF0761_Load(object sender, EventArgs e)
        {
            PERIOD_YEAR.EditValue = iDate.ISYear(System.DateTime.Today);
        }

        private void FCMF0761_Shown(object sender, EventArgs e)
        {
            FS_SET_NAME_0.Focus();
        }

        #endregion

        #region ----- Lookup Event -----

        private void ilaFS_SET_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter("FS_SET", "Y");
        }

        private void ilaQUARTER_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter("QUARTER", "Y");
        }

        #endregion
    }
}