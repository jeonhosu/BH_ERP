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

namespace FCMF0502
{
    public partial class FCMF0502 : Office2007Form
    {
        #region ----- Variables -----
        ISFunction.ISConvert iString = new ISFunction.ISConvert();
        ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        object mAccount_Book_ID;
        object mAccount_Set_ID;
        object mFiscal_Calendar_ID;
        object mDept_Level;
        object mAccount_Book_Name;
        object mCurrency_Code;
        object mBudget_Control_YN;
        #endregion;

        #region ----- Constructor -----

        public FCMF0502()
        {
            InitializeComponent();
        }

        public FCMF0502(Form pMainForm, ISAppInterface pAppInterface)
        {
            InitializeComponent();
            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;
        }

        #endregion;

        #region ----- Private Methods ----

        private void GetAccountBook()
        {
            idcACCOUNT_BOOK.ExecuteNonQuery();
            mAccount_Book_ID = idcACCOUNT_BOOK.GetCommandParamValue("O_ACCOUNT_BOOK_ID");
            mAccount_Book_Name = idcACCOUNT_BOOK.GetCommandParamValue("O_ACCOUNT_BOOK_NAME");
            mAccount_Set_ID = idcACCOUNT_BOOK.GetCommandParamValue("O_ACCOUNT_SET_ID");
            mFiscal_Calendar_ID = idcACCOUNT_BOOK.GetCommandParamValue("O_FISCAL_CALENDAR_ID");
            mDept_Level = idcACCOUNT_BOOK.GetCommandParamValue("O_DEPT_LEVEL");
            mCurrency_Code = idcACCOUNT_BOOK.GetCommandParamValue("O_CURRENCY_CODE");
            mBudget_Control_YN = idcACCOUNT_BOOK.GetCommandParamValue("O_BUDGET_CONTROL_YN");
        }

        private void Search_DB()
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
            idaCASHBOOK.Fill();
            igrCASHBOOK.Focus();
        }

        #endregion;

        #region ----- Events -----

        private void isAppInterfaceAdv1_AppMainButtonClick(ISAppButtonEvents e)
        {
            if (this.IsActive)
            {
                if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Search)
                {
                    Search_DB();
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

        private void FCMF0502_Load(object sender, EventArgs e)
        {
            GL_DATE_FR_0.EditValue = iDate.ISMonth_1st(DateTime.Today);
            GL_DATE_TO_0.EditValue = iDate.ISGetDate();

            // 회계장부 정보 설정.
            GetAccountBook();
        }

        private void igrCASHBOOK_CellDoubleClick(object pSender)
        {
            UseWaitCursor = true;
            this.Cursor = System.Windows.Forms.Cursors.WaitCursor;
            Application.DoEvents();
            System.Windows.Forms.DialogResult vdlgResultValue;
            if (iString.ISNumtoZero(igrCASHBOOK.GetCellValue("SLIP_HEADER_ID"), 0) != Convert.ToInt32(0))
            {                
                Application.DoEvents();
                Form vSLIP_DETAIL = new SLIP_DETAIL(isAppInterfaceAdv1.AppInterface, igrCASHBOOK.GetCellValue("SLIP_HEADER_ID"));
                vdlgResultValue = vSLIP_DETAIL.ShowDialog();
                if (vdlgResultValue == DialogResult.OK)
                {
                }
                else
                {
                }
                vSLIP_DETAIL.Dispose();
            }
            Application.DoEvents();            
            this.Cursor = System.Windows.Forms.Cursors.Default;
            UseWaitCursor = false;
        }

        #endregion

    }
}