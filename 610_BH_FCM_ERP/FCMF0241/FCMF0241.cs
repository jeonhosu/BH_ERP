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

namespace FCMF0241
{
    public partial class FCMF0241 : Office2007Form
    {
        #region ----- Variables -----

        ISFunction.ISConvert iString = new ISFunction.ISConvert();
        ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        #endregion;

        #region ----- Constructor -----

        public FCMF0241()
        {
            InitializeComponent();
        }

        public FCMF0241(Form pMainForm, ISAppInterface pAppInterface)
        {
            InitializeComponent();
            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;
        }

        #endregion;

        #region ----- Private Methods ----

        private void SearchDB()
        {
            if (iString.ISNull(GL_DATE_FR_0.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10010"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                GL_DATE_FR_0.Focus();
                return;
            }

            if (iString.ISNull(GL_DATE_TO_0.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10011"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                GL_DATE_TO_0.Focus();
                return;
            }

            if (Convert.ToDateTime(GL_DATE_FR_0.EditValue) > Convert.ToDateTime(GL_DATE_TO_0.EditValue))
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10012"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                GL_DATE_FR_0.Focus();
                return;
            }
            idaSLIP_LINE_JOURNALIZE.Fill();
            igrSLIP_LINE_JOURNALIZE.Focus();
        }
        
        private void Show_Slip_Detail()
        {
            try
            {
                int mSLIP_HEADER_ID = iString.ISNumtoZero(igrSLIP_LINE_JOURNALIZE.GetCellValue("SLIP_HEADER_ID"));
                if (mSLIP_HEADER_ID != Convert.ToInt32(0))
                {
                    Application.UseWaitCursor = true;
                    this.Cursor = System.Windows.Forms.Cursors.WaitCursor;

                    FCMF0204.FCMF0204 vFCMF0204 = new FCMF0204.FCMF0204(this.MdiParent, isAppInterfaceAdv1.AppInterface, mSLIP_HEADER_ID);
                    vFCMF0204.Show();

                    this.Cursor = System.Windows.Forms.Cursors.Default;
                    Application.UseWaitCursor = false;
                }
            }
            catch
            {
            }
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
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {
                }
            }
        }

        #endregion;

        #region ----- FORM EVENT -----

        private void FCMF0241_Load(object sender, EventArgs e)
        {
            idaSLIP_LINE_JOURNALIZE.FillSchema();
        }

        private void FCMF0241_Shown(object sender, EventArgs e)
        {
            GL_DATE_FR_0.EditValue = iDate.ISMonth_1st(DateTime.Today);
            GL_DATE_TO_0.EditValue = DateTime.Today;
        }

        private void igrSLIP_LINE_JOURNALIZE_CellDoubleClick(object pSender)
        {
            Show_Slip_Detail(); 
        }

        #endregion

        #region ----- Lookup Event ------
        
        private void ilaACCOUNT_CODE_FR_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildACCOUNT_CONTROL_FR.SetLookupParamValue("W_ACCOUNT_CODE_FR", null);
            ildACCOUNT_CONTROL_FR.SetLookupParamValue("W_ENABLED_YN", "Y");
        }

        private void ilaACCOUNT_CODE_TO_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildACCOUNT_CONTROL_FR.SetLookupParamValue("W_ACCOUNT_CODE_FR", ACCOUNT_CODE_FR_0.EditValue);
            ildACCOUNT_CONTROL_FR.SetLookupParamValue("W_ENABLED_YN", "Y");
        }

        #endregion

        #region ----- Adapter Event -----


        #endregion

    }
}