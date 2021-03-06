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

namespace FCMF0295
{
    public partial class FCMF0295 : Office2007Form
    {
        #region ----- Variables -----

        ISFunction.ISConvert iString = new ISFunction.ISConvert();
        ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        object mFORM_TYPE_NAME;
        object mFORM_TYPE_ID;
        object mFS_SET_NAME;        
        object mFS_SET_ID;
        object mFS_ITEM_NAME;
        object mFS_ITEM_CODE; 
        object mGL_DATE_FR;
        object mGL_DATE_TO;
        object mFS_TYPE;
        object mFS_ITEM_ID;

        #endregion;

        #region ----- Constructor -----

        public FCMF0295()
        {
            InitializeComponent();
        }

        public FCMF0295(Form pMainForm, ISAppInterface pAppInterface)
        {
            InitializeComponent();
            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;
        }

        public FCMF0295(Form pMainForm, ISAppInterface pAppInterface, 
                        object pFORM_TYPE_NAME, object pFORM_TYPE_ID,
                        object pFS_SET_NAME, object pFS_SET_ID,
                        object pFS_ITEM_NAME, object pFS_ITEM_CODE, 
                        object pGL_DATE_FR, object pGL_DATE_TO)
        {
            InitializeComponent();
            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;

            mFORM_TYPE_NAME = pFORM_TYPE_NAME;
            mFORM_TYPE_ID = pFORM_TYPE_ID;
            mFS_SET_NAME = pFS_SET_NAME;
            mFS_SET_ID = pFS_SET_ID;
            mFS_ITEM_NAME = pFS_ITEM_NAME;
            mFS_ITEM_CODE = pFS_ITEM_CODE;
            mGL_DATE_FR = pGL_DATE_FR;
            mGL_DATE_TO= pGL_DATE_TO;
        }

        public FCMF0295(Form pMainForm, ISAppInterface pAppInterface,
                        object pFORM_TYPE_NAME, object pFORM_TYPE_ID, 
                        object pFS_SET_NAME, object pFS_SET_ID,
                        object pFS_ITEM_NAME, object pFS_ITEM_CODE, 
                        object pGL_DATE_FR, object pGL_DATE_TO, 
                        object pFS_TYPE, object pFS_ITEM_ID)
        {
            InitializeComponent();
            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;

            mFORM_TYPE_NAME = pFORM_TYPE_NAME;
            mFORM_TYPE_ID = pFORM_TYPE_ID;
            mFS_SET_NAME = pFS_SET_NAME;
            mFS_SET_ID = pFS_SET_ID;
            mFS_ITEM_NAME = pFS_ITEM_NAME;
            mFS_ITEM_CODE = pFS_ITEM_CODE;
            mGL_DATE_FR = pGL_DATE_FR;
            mGL_DATE_TO = pGL_DATE_TO;
            mFS_TYPE = pFS_TYPE;
            mFS_ITEM_ID = pFS_ITEM_ID;
        }

        #endregion;

        #region ----- Private Methods ----

        private void SearchDB()
        {
            if (iString.ISNull(P_GL_DATE_FR.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10010"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                P_GL_DATE_FR.Focus();
                return;
            }

            if (iString.ISNull(P_GL_DATE_TO.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10011"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                P_GL_DATE_TO.Focus();
                return;
            }

            if (Convert.ToDateTime(P_GL_DATE_FR.EditValue) > Convert.ToDateTime(P_GL_DATE_TO.EditValue))
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10012"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                P_GL_DATE_FR.Focus();
                return;
            }
            IDA_FS_LIST.Fill();
            IGR_FS_LIST.Focus();
        }
        
        private void Show_Slip_Detail()
        {
            try
            {
                int mSLIP_HEADER_ID = iString.ISNumtoZero(IGR_FS_LIST.GetCellValue("SLIP_HEADER_ID"));
                if (mSLIP_HEADER_ID != Convert.ToInt32(0))
                {
                    Application.UseWaitCursor = true;
                    this.Cursor = System.Windows.Forms.Cursors.WaitCursor;

                    FCMF0205.FCMF0205 vFCMF0205 = new FCMF0205.FCMF0205(this.MdiParent, isAppInterfaceAdv1.AppInterface, mSLIP_HEADER_ID);
                    vFCMF0205.Show();

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

        private void FCMF0295_Load(object sender, EventArgs e)
        {
            IDA_FS_LIST.FillSchema();
        }

        private void FCMF0295_Shown(object sender, EventArgs e)
        {
            P_FORM_TYPE_ID.EditValue = mFORM_TYPE_ID;
            P_FORM_TYPE_NAME.EditValue = mFORM_TYPE_NAME;
            P_FS_SET_ID.EditValue = mFS_SET_ID;
            P_FS_SET_NAME.EditValue = mFS_SET_NAME;
            P_FS_ITEM_CODE.EditValue = mFS_ITEM_CODE;
            P_FS_ITEM_NAME.EditValue = mFS_ITEM_NAME;
            P_GL_DATE_FR.EditValue = mGL_DATE_FR;
            P_GL_DATE_TO.EditValue = mGL_DATE_TO;

            P_FS_TYPE.EditValue = mFS_TYPE;
            P_FS_ITEM_ID.EditValue = mFS_ITEM_ID;

            Application.DoEvents();

            SearchDB();
        }

        private void IGR_FS_LIST_CellDoubleClick(object pSender)
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
            ildACCOUNT_CONTROL_FR.SetLookupParamValue("W_ACCOUNT_CODE_FR", P_FORM_TYPE_NAME.EditValue);
            ildACCOUNT_CONTROL_FR.SetLookupParamValue("W_ENABLED_YN", "Y");
        }

        #endregion


        #region ----- Adapter Event -----


        #endregion

    }
}