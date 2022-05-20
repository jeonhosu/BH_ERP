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

namespace FCMF0309
{
    public partial class FCMF0309 : Office2007Form
    {
        #region ----- Variables -----

        ISFunction.ISConvert iString = new ISFunction.ISConvert();
        ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        #endregion;

        #region ----- Constructor -----

        public FCMF0309()
        {
            InitializeComponent();
        }

        public FCMF0309(Form pMainForm, ISAppInterface pAppInterface)
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

        private void FCMF0309_Load(object sender, EventArgs e)
        {

        }

        private void FCMF0309_Shown(object sender, EventArgs e)
        {
            DPR_PERIOD.EditValue = iDate.ISYearMonth(DateTime.Today);
        }

        private void ibtSET_DPR_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            if (iString.ISNull(DPR_PERIOD.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10231"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                DPR_PERIOD.Focus();
                return;
            }

            idcDEPRECIATION_SET.ExecuteNonQuery();

        }

        private void ibtCANCEL_DPR_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            if (iString.ISNull(DPR_PERIOD.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10231"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                DPR_PERIOD.Focus();
                return;
            }

            idcDEPRECIATION_SET_CANCEL.ExecuteNonQuery();
        }

        #endregion

        #region ----- Lookup Event -----

        private void ilaPERIOD_NAME_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildPERIOD_NAME.SetLookupParamValue("W_END_YYYYMM", iDate.ISYearMonth(DateTime.Today));
        }

        #endregion


    }
}