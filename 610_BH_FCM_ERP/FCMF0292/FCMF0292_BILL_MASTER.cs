using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using Syncfusion.Windows.Forms;
using Syncfusion.Windows.Forms.Tools;
using Syncfusion.Windows.Forms.Grid;
using InfoSummit.Win.ControlAdv;
using ISCommonUtil;

namespace FCMF0292
{
    public partial class FCMF0292_BILL_MASTER : Office2007Form
    {
        ISFunction.ISConvert iString = new ISFunction.ISConvert();
        ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();
        private ISGridAdvEx mGrid_BILL = null;
        
        #region ----- Variables -----
     

        #endregion;

        #region ----- Constructor -----

        public FCMF0292_BILL_MASTER(ISAppInterface pAppInterface, ISGridAdvEx pGrid)
        {
            InitializeComponent();            
            isAppInterfaceAdv1.AppInterface = pAppInterface;

            mGrid_BILL = pGrid;
        }

        #endregion;

        #region ----- Private Methods ----
        private void Init_Set_Edit()
        {
            BILL_NUM.EditValue = mGrid_BILL.GetCellValue("BILL_NUM");
            BILL_TYPE.EditValue = mGrid_BILL.GetCellValue("BILL_TYPE");
            BILL_TYPE_NAME.EditValue = mGrid_BILL.GetCellValue("BILL_TYPE_NAME");
            CUSTOMER_ID.EditValue = mGrid_BILL.GetCellValue("CUSTOMER_ID");
            CUSTOMER_NAME.EditValue = mGrid_BILL.GetCellValue("CUSTOMER_NAME");
            TAX_REG_NO.EditValue = mGrid_BILL.GetCellValue("TAX_REG_NO");
            ISSUE_DATE.EditValue = mGrid_BILL.GetCellValue("ISSUE_DATE");
            DUE_DATE.EditValue = mGrid_BILL.GetCellValue("DUE_DATE");
            BILL_STATUS.EditValue = mGrid_BILL.GetCellValue("BILL_STATUS");
            BILL_STATUS_NAME.EditValue = mGrid_BILL.GetCellValue("BILL_STATUS_NAME");
            BILL_AMOUNT.EditValue = mGrid_BILL.GetCellValue("BILL_AMOUNT");
            BANK_NAME.EditValue = mGrid_BILL.GetCellValue("BANK_NAME");
            ISSUE_NAME.EditValue = mGrid_BILL.GetCellValue("ISSUE_NAME");
            RECEIPT_DEPT_ID.EditValue = mGrid_BILL.GetCellValue("RECEIPT_DEPT_ID");
            RECEIPT_DEPT_NAME.EditValue = mGrid_BILL.GetCellValue("RECEIPT_DEPT_NAME");
            KEEP_DEPT_ID.EditValue = mGrid_BILL.GetCellValue("KEEP_DEPT_ID");
            KEEP_DEPT_NAME.EditValue = mGrid_BILL.GetCellValue("KEEP_DEPT_NAME");
            RECEIPT_DATE.EditValue = mGrid_BILL.GetCellValue("RECEIPT_DATE");
        }

        private void Init_Set_Grid()
        {
            mGrid_BILL.SetCellValue("BILL_NUM", BILL_NUM.EditValue);
            mGrid_BILL.SetCellValue("BILL_TYPE", BILL_TYPE.EditValue);
            mGrid_BILL.SetCellValue("BILL_TYPE_NAME", BILL_TYPE_NAME.EditValue);
            mGrid_BILL.SetCellValue("CUSTOMER_ID", CUSTOMER_ID.EditValue);
            mGrid_BILL.SetCellValue("CUSTOMER_NAME", CUSTOMER_NAME.EditValue);
            mGrid_BILL.SetCellValue("TAX_REG_NO", TAX_REG_NO.EditValue);
            mGrid_BILL.SetCellValue("ISSUE_DATE", ISSUE_DATE.EditValue);
            mGrid_BILL.SetCellValue("DUE_DATE", DUE_DATE.EditValue);
            mGrid_BILL.SetCellValue("BILL_STATUS", BILL_STATUS.EditValue);
            mGrid_BILL.SetCellValue("BILL_STATUS_NAME", BILL_STATUS_NAME.EditValue);
            mGrid_BILL.SetCellValue("BILL_AMOUNT", BILL_AMOUNT.EditValue);
            mGrid_BILL.SetCellValue("BANK_NAME", BANK_NAME.EditValue);
            mGrid_BILL.SetCellValue("ISSUE_NAME", ISSUE_NAME.EditValue);
            mGrid_BILL.SetCellValue("RECEIPT_DEPT_ID", RECEIPT_DEPT_ID.EditValue);
            mGrid_BILL.SetCellValue("RECEIPT_DEPT_NAME", RECEIPT_DEPT_NAME.EditValue);
            mGrid_BILL.SetCellValue("KEEP_DEPT_ID", KEEP_DEPT_ID.EditValue);
            mGrid_BILL.SetCellValue("KEEP_DEPT_NAME", KEEP_DEPT_NAME.EditValue);
            mGrid_BILL.SetCellValue("RECEIPT_DATE", RECEIPT_DATE.EditValue);
        }

        private void CheckData()
        {
            if (iString.ISNull(BILL_NUM.EditValue) == string.Empty)
            {// 어음번호
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10142"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                BILL_NUM.Focus();
                return;
            }
            if (iString.ISNull(BILL_TYPE.EditValue) == string.Empty)
            {// 어음종류
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10143"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                BILL_TYPE_NAME.Focus();
                return;
            }
            if (iString.ISNull(CUSTOMER_ID.EditValue) == string.Empty)
            {// 고객정보
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10135"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                CUSTOMER_NAME.Focus();                
                return;
            }
            if (iString.ISNull(ISSUE_DATE.EditValue) == string.Empty)
            {// 발행일자
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10144"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                ISSUE_DATE.Focus();
                return;
            }
            if (iString.ISNull(DUE_DATE.EditValue) == string.Empty)
            {// 만기일자
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10145"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                ISSUE_DATE.Focus();
                return;
            }
            if (iString.ISNumtoZero(BILL_AMOUNT.EditValue) == 0)
            {// 어음금액
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10146"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                BILL_AMOUNT.Focus();
                return;
            }
            if (iString.ISNull(RECEIPT_DATE.EditValue) == string.Empty)
            {// 입금일자
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10147"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                ISSUE_DATE.Focus();
                return;
            }
        }

        private void SetCommonParameter(string pGroup_Code, string pEnabled_YN)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", pGroup_Code);
            ildCOMMON.SetLookupParamValue("W_ENABLED_YN", pEnabled_YN);
        }

        private void SetDefault_Bill_Status()
        {
            SetCommonParameter("BILL_STATUS", "Y");

            idcDV_COMMON.SetCommandParamValue("W_GROUP_CODE", "BILL_STATUS");
            idcDV_COMMON.ExecuteNonQuery();
            BILL_STATUS_NAME.EditValue = idcDV_COMMON.GetCommandParamValue("O_CODE_NAME");
            BILL_STATUS.EditValue = idcDV_COMMON.GetCommandParamValue("O_CODE");
        }
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


        #region ----- From Event -----
        private void FCMF0206_BILL_MASTER_Load(object sender, EventArgs e)
        {
            Init_Set_Edit();
            SetDefault_Bill_Status();
        }

        private void ibtnOK_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            CheckData();
            Init_Set_Grid();
            this.DialogResult = System.Windows.Forms.DialogResult.OK;
        }

        private void ibtnCLOSE_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            this.DialogResult = System.Windows.Forms.DialogResult.Cancel;
            this.Close();
        }

        #endregion
        
        #region ----- Lookup Event -----
        private void ilaBILL_TYPE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter("BILL_TYPE", "Y");
        }

        private void ilaBILL_STATUS_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter("BILL_STATUS", "Y");
        }

        private void ilaRECEIPT_DEPT_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildDEPT.SetLookupParamValue("W_ENABLED_YN", "Y");
        }

        private void ilaKEEP_DEPT_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildDEPT.SetLookupParamValue("W_ENABLED_YN", "Y");
        }
        
        #endregion

    }
}