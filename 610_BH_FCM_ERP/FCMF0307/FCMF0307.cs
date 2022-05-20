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

namespace FCMF0307
{
    public partial class FCMF0307 : Office2007Form
    {
        #region ----- Variables -----

        ISFunction.ISConvert iString = new ISFunction.ISConvert();
        ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        #endregion;

        #region ----- Constructor -----

        public FCMF0307()
        {
            InitializeComponent();
        }

        public FCMF0307(Form pMainForm, ISAppInterface pAppInterface)
        {
            InitializeComponent();
            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;
        }

        #endregion;

        #region ----- Private Methods ----

        private void SearchDB()
        {
            if (iString.ISNull(DATE_FR_0.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10010"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                DATE_FR_0.Focus();
                return;
            }
            if (iString.ISNull(DATE_TO_0.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10011"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                DATE_TO_0.Focus();
                return;
            }
            idaASSET_HISTORY.Fill();
            igrASSET_HISTORY.Focus();
        }

        //private void SetCommon_Lookup_Parameter(string pGroup_Code, string pEnabled_YN)
        //{
        //    ildCOMMON.SetLookupParamValue("W_GROUP_CODE", pGroup_Code);
        //    ildCOMMON.SetLookupParamValue("W_ENABLED_YN", pEnabled_YN);
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
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {
                }
            }
        }

        #endregion;

        #region ----- Form Event -----

        private void FCMF0307_Load(object sender, EventArgs e)
        {

        }

        private void FCMF0307_Shown(object sender, EventArgs e)
        {
            DATE_FR_0.EditValue = iDate.ISMonth_1st(DateTime.Today);
            DATE_TO_0.EditValue = DateTime.Today;
        }

        #endregion

        #region ----- Lookup Event -----
        
        private void ilaASSET_CATEGORY_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildASSET_CATEGORY.SetLookupParamValue("W_ENABLED_YN", "N");
        }
                
        private void ilaASSET_CODE_FR_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildASSET_CODE_FR_TO_0.SetLookupParamValue("W_ASSET_CODE", null);
        }

        private void ilaASSET_CODE_TO_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildASSET_CODE_FR_TO_0.SetLookupParamValue("W_ASSET_CODE", ASSET_CODE_FR_0.EditValue);
        }

        #endregion

    }
}