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

namespace FCMF0221
{
    public partial class FCMF0221 : Office2007Form
    {
        #region ----- Variables -----

        ISFunction.ISConvert iString = new ISFunction.ISConvert();
        ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        int mAccount_Book_ID;
        string mCurrency_Code;

        #endregion;

        #region ----- Constructor -----

        public FCMF0221()
        {
            InitializeComponent();
        }

        public FCMF0221(Form pMainForm, ISAppInterface pAppInterface)
        {
            InitializeComponent();
            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;
        }

        #endregion;

        #region ----- Private Methods ----

        private void SearchDB()
        {
            idaLONE_MASTER.Fill();
            igrLOAN_LIST.Focus();
        }

        private void Insert_Loan_Master()
        {
            
            LOAN_NUM.Focus();
        }

        private void SetCommonParameter(string pGroup_Code, string pEnabled_YN)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", pGroup_Code);
            ildCOMMON.SetLookupParamValue("W_ENABLED_YN", pEnabled_YN);
        }

        private void Init_Item(object pLoan_Kind)
        {
            if (iString.ISNull(pLoan_Kind) == "2".ToString() || iString.ISNull(pLoan_Kind) == "3".ToString())
            {
                L_ISSUE_DATE.ReadOnly = false;
                L_ISSUE_DATE.Insertable = true;
                L_ISSUE_DATE.Updatable = true;
                L_ISSUE_DATE.TabStop = true;

                L_DUE_DATE.ReadOnly = false;
                L_DUE_DATE.Insertable = true;
                L_DUE_DATE.Updatable = true;
                L_DUE_DATE.TabStop = true;

                L_CURRENCY_CODE.ReadOnly = false;
                L_CURRENCY_CODE.Insertable = true;
                L_CURRENCY_CODE.Updatable = true;
                L_CURRENCY_CODE.TabStop = true;

                L_EXCHANGE_RATE.ReadOnly = false;
                L_EXCHANGE_RATE.Insertable = true;
                L_EXCHANGE_RATE.Updatable = true;
                L_EXCHANGE_RATE.TabStop = true;

                LIMIT_CURR_AMOUNT.ReadOnly = false;
                LIMIT_CURR_AMOUNT.Insertable = true;
                LIMIT_CURR_AMOUNT.Updatable = true;
                LIMIT_CURR_AMOUNT.TabStop = true;

                LIMIT_AMOUNT.ReadOnly = false;
                LIMIT_AMOUNT.Insertable = true;
                LIMIT_AMOUNT.Updatable = true;
                LIMIT_AMOUNT.TabStop = true;

                ISSUE_DATE.ReadOnly = true;
                ISSUE_DATE.Insertable = false;
                ISSUE_DATE.Updatable = false;
                ISSUE_DATE.TabStop = false;

                DUE_DATE.ReadOnly = true;
                DUE_DATE.Insertable = false;
                DUE_DATE.Updatable = false;
                DUE_DATE.TabStop = false;

                CURRENCY_CODE.ReadOnly = true;
                CURRENCY_CODE.Insertable = false;
                CURRENCY_CODE.Updatable = false;
                CURRENCY_CODE.TabStop = false;

                EXCHANGE_RATE.ReadOnly = true;
                EXCHANGE_RATE.Insertable = false;
                EXCHANGE_RATE.Updatable = false;
                EXCHANGE_RATE.TabStop = false;

                LOAN_CURR_AMOUNT.ReadOnly = true;
                LOAN_CURR_AMOUNT.Insertable = false;
                LOAN_CURR_AMOUNT.Updatable = false;
                LOAN_CURR_AMOUNT.TabStop = false;

                LOAN_AMOUNT.ReadOnly = true;
                LOAN_AMOUNT.Insertable = false;
                LOAN_AMOUNT.Updatable = false;
                LOAN_AMOUNT.TabStop = false;

                Init_Limit_Currency_Amount();
            }
            else
            {
                L_ISSUE_DATE.ReadOnly = true;
                L_ISSUE_DATE.Insertable = false;
                L_ISSUE_DATE.Updatable = false;
                L_ISSUE_DATE.TabStop = false;

                L_DUE_DATE.ReadOnly = true;
                L_DUE_DATE.Insertable = false;
                L_DUE_DATE.Updatable = false;
                L_DUE_DATE.TabStop = false;

                L_CURRENCY_CODE.ReadOnly = true;
                L_CURRENCY_CODE.Insertable = false;
                L_CURRENCY_CODE.Updatable = false;
                L_CURRENCY_CODE.TabStop = false;

                L_EXCHANGE_RATE.ReadOnly = true;
                L_EXCHANGE_RATE.Insertable = false;
                L_EXCHANGE_RATE.Updatable = false;
                L_EXCHANGE_RATE.TabStop = false;

                LIMIT_CURR_AMOUNT.ReadOnly = true;
                LIMIT_CURR_AMOUNT.Insertable = false;
                LIMIT_CURR_AMOUNT.Updatable = false;
                LIMIT_CURR_AMOUNT.TabStop = false;

                LIMIT_AMOUNT.ReadOnly = true;
                LIMIT_AMOUNT.Insertable = false;
                LIMIT_AMOUNT.Updatable = false;
                LIMIT_AMOUNT.TabStop = false;

                ISSUE_DATE.ReadOnly = false;
                ISSUE_DATE.Insertable = true;
                ISSUE_DATE.Updatable = true;
                ISSUE_DATE.TabStop = true;

                DUE_DATE.ReadOnly = false;
                DUE_DATE.Insertable = true;
                DUE_DATE.Updatable = true;
                DUE_DATE.TabStop = true;

                CURRENCY_CODE.ReadOnly = false;
                CURRENCY_CODE.Insertable = true;
                CURRENCY_CODE.Updatable = true;
                CURRENCY_CODE.TabStop = true;

                EXCHANGE_RATE.ReadOnly = false;
                EXCHANGE_RATE.Insertable = true;
                EXCHANGE_RATE.Updatable = true;
                EXCHANGE_RATE.TabStop = true;

                LOAN_CURR_AMOUNT.ReadOnly = false;
                LOAN_CURR_AMOUNT.Insertable = true;
                LOAN_CURR_AMOUNT.Updatable = true;
                LOAN_CURR_AMOUNT.TabStop = true;

                LOAN_AMOUNT.ReadOnly = false;
                LOAN_AMOUNT.Insertable = true;
                LOAN_AMOUNT.Updatable = true;
                LOAN_AMOUNT.TabStop = true;

                Init_Currency_Amount();
            }
        }

        private void Init_Limit_Currency_Amount()
        {
            if (iString.ISNull(L_CURRENCY_CODE.EditValue) == string.Empty || L_CURRENCY_CODE.EditValue.ToString() == mCurrency_Code)
            {
                L_EXCHANGE_RATE.EditValue = DBNull.Value;

                if (iString.ISDecimaltoZero(LIMIT_CURR_AMOUNT.EditValue) != Convert.ToDecimal(0))
                {
                    LIMIT_CURR_AMOUNT.EditValue = 0;
                }
                L_EXCHANGE_RATE.ReadOnly = true;
                L_EXCHANGE_RATE.Insertable = false;
                L_EXCHANGE_RATE.Updatable = false;

                LIMIT_CURR_AMOUNT.ReadOnly = true;
                LIMIT_CURR_AMOUNT.Insertable = false;
                LIMIT_CURR_AMOUNT.Updatable = false;

                L_EXCHANGE_RATE.TabStop = false;
                LIMIT_CURR_AMOUNT.TabStop = false;
            }
            else
            {
                L_EXCHANGE_RATE.ReadOnly = false;
                L_EXCHANGE_RATE.Insertable = true;
                L_EXCHANGE_RATE.Updatable = true;

                LIMIT_CURR_AMOUNT.ReadOnly = false;
                LIMIT_CURR_AMOUNT.Insertable = true;
                LIMIT_CURR_AMOUNT.Updatable = true;

                L_EXCHANGE_RATE.TabStop = true;
                LIMIT_CURR_AMOUNT.TabStop = true;
            }
        }

        private void Init_Limit_Amount()
        {
            if (iString.ISNull(L_CURRENCY_CODE.EditValue) != mCurrency_Code)
            {
                LIMIT_AMOUNT.EditValue = iString.ISDecimaltoZero(LIMIT_CURR_AMOUNT.EditValue) * iString.ISDecimaltoZero(L_EXCHANGE_RATE.EditValue);
            }
        }

        private void Init_Currency_Amount()
        {
            if (iString.ISNull(CURRENCY_CODE.EditValue) == string.Empty || CURRENCY_CODE.EditValue.ToString() == mCurrency_Code)
            {
                EXCHANGE_RATE.EditValue = DBNull.Value;

                if (iString.ISDecimaltoZero(LOAN_CURR_AMOUNT.EditValue) != Convert.ToDecimal(0))
                {
                    LOAN_CURR_AMOUNT.EditValue = 0;
                }
                EXCHANGE_RATE.ReadOnly = true;
                EXCHANGE_RATE.Insertable = false;
                EXCHANGE_RATE.Updatable = false;

                LOAN_CURR_AMOUNT.ReadOnly = true;
                LOAN_CURR_AMOUNT.Insertable = false;
                LOAN_CURR_AMOUNT.Updatable = false;

                EXCHANGE_RATE.TabStop = false;
                LOAN_CURR_AMOUNT.TabStop = false;
            }
            else
            {
                EXCHANGE_RATE.ReadOnly = false;
                EXCHANGE_RATE.Insertable = true;
                EXCHANGE_RATE.Updatable = true;

                LOAN_CURR_AMOUNT.ReadOnly = false;
                LOAN_CURR_AMOUNT.Insertable = true;
                LOAN_CURR_AMOUNT.Updatable = true;

                EXCHANGE_RATE.TabStop = true;
                LOAN_CURR_AMOUNT.TabStop = true;
            }
        }

        private void Init_Loan_Amount()
        {
            if (iString.ISNull(CURRENCY_CODE.EditValue) != mCurrency_Code)
            {
                LOAN_AMOUNT.EditValue = iString.ISDecimaltoZero(LOAN_CURR_AMOUNT.EditValue) * iString.ISDecimaltoZero(EXCHANGE_RATE.EditValue);
            }
        }

        private void Init_Limit_Loan_Amount()
        {
            if (iString.ISNull(L_CURRENCY_CODE.EditValue) != mCurrency_Code)
            {
                LIMIT_AMOUNT.EditValue = iString.ISDecimaltoZero(LIMIT_CURR_AMOUNT.EditValue) * iString.ISDecimaltoZero(L_EXCHANGE_RATE.EditValue);
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
                    if (idaLONE_MASTER.IsFocused)
                    {
                        idaLONE_MASTER.AddOver();
                        Insert_Loan_Master();
                     }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddUnder)
                {
                    if (idaLONE_MASTER.IsFocused)
                    {                        
                        idaLONE_MASTER.AddUnder();
                        Insert_Loan_Master();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Update)
                {
                    idaLONE_MASTER.Update();
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Cancel)
                {
                    if (idaLONE_MASTER.IsFocused)
                    {
                        idaLONE_MASTER.Cancel();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {
                    if (idaLONE_MASTER.IsFocused)
                    {
                        idaLONE_MASTER.Delete();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Print)
                {
                    if (idaLONE_MASTER.IsFocused)
                    {
                    } 
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Export)
                {
                    if (idaLONE_MASTER.IsFocused)
                    {
                    }
                }
            }
        }

        #endregion;

        #region ----- Form Event -----
        
        private void FCMF0221_Load(object sender, EventArgs e)
        {
            idaLONE_MASTER.FillSchema();
        }
        
        private void FCMF0221_Shown(object sender, EventArgs e)
        {
            idcDV_ACCOUNT_BOOK.ExecuteNonQuery();
            mAccount_Book_ID = iString.ISNumtoZero(idcDV_ACCOUNT_BOOK.GetCommandParamValue("O_ACCOUNT_BOOK_ID"));
            mCurrency_Code = iString.ISNull(idcDV_ACCOUNT_BOOK.GetCommandParamValue("O_CURRENCY_CODE"));
        }

        private void EXCHANGE_RATE_CurrentEditValidated(object pSender, ISEditAdvValidatedEventArgs e)
        {
            Init_Loan_Amount();
        }

        private void LOAN_CURR_AMOUNT_CurrentEditValidated(object pSender, ISEditAdvValidatedEventArgs e)
        {
            Init_Loan_Amount();
        }

        private void L_EXCHANGE_RATE_CurrentEditValidated(object pSender, ISEditAdvValidatedEventArgs e)
        {
            Init_Limit_Loan_Amount();
        }

        private void LIMIT_CURR_AMOUNT_CurrentEditValidated(object pSender, ISEditAdvValidatedEventArgs e)
        {
            Init_Limit_Loan_Amount();
        }
        #endregion

        #region ----- Lookup Event -----

        private void ilaLOAN_KIND_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter("LOAN_KIND", "Y");
        }

        private void ilaLOAN_KIND_SelectedRowData(object pSender)
        {
            Init_Item(LOAN_KIND.EditValue);
            if (iString.ISNull(LOAN_KIND.EditValue) == "2".ToString() || iString.ISNull(LOAN_KIND.EditValue) == "3".ToString())
            {
                if (iString.ISNull(L_ISSUE_DATE.EditValue) == string.Empty)
                {
                    L_ISSUE_DATE.EditValue = DateTime.Today;
                }
                if (iString.ISNull(L_DUE_DATE.EditValue) == string.Empty)
                {
                    L_DUE_DATE.EditValue = DateTime.Today;
                }
                if (iString.ISNull(L_CURRENCY_CODE.EditValue) == string.Empty)
                {
                    L_CURRENCY_CODE.EditValue = mCurrency_Code;
                }
            }
            else
            {
                if (iString.ISNull(ISSUE_DATE.EditValue) == string.Empty)
                {
                    ISSUE_DATE.EditValue = DateTime.Today;
                }
                if (iString.ISNull(DUE_DATE.EditValue) == string.Empty)
                {
                    DUE_DATE.EditValue = DateTime.Today;
                }
                if (iString.ISNull(CURRENCY_CODE.EditValue) == string.Empty)
                {
                    CURRENCY_CODE.EditValue = mCurrency_Code;
                }         
            }
        }

        private void ilaLOAN_TYPE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter("LOAN_TYPE", "Y");
        }

        private void ilaLOAN_USE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter("LOAN_USE", "Y");
        }

        private void ilaLOAN_BANK_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildBANK.SetLookupParamValue("W_ENABLED_YN", "Y");
        }

        private void ilaL_CURRENCY_CODE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCURRENCY_CODE.SetLookupParamValue("W_ENABLED_YN", "Y");
        }

        private void ilaL_CURRENCY_CODE_SelectedRowData(object pSender)
        {
            Init_Limit_Currency_Amount();
        }

        private void ilaCURRENCY_CODE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCURRENCY_CODE.SetLookupParamValue("W_ENABLED_YN", "Y");
        }

        private void ilaCURRENCY_CODE_SelectedRowData(object pSender)
        {
            Init_Currency_Amount();
        }

        private void ilaENSURE_TYPE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter("ENSURE_TYPE", "Y");
        }

        private void ilaREPAY_CONDITION_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter("REPAY_CONDITION", "Y");
        }

        private void ilaRCV_BANK_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildBANK.SetLookupParamValue("W_ENABLED_YN", "Y");
        }

        private void ilaRCV_ACCOUNT_CODE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildACCOUNT_CONTROL.SetLookupParamValue("W_ENABLED_YN", "Y");
        }

        private void ilaINTEREST_ACCOUNT_CODE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildACCOUNT_CONTROL.SetLookupParamValue("W_ENABLED_YN", "Y");
        }

        private void ilaICOMMISSION_ACCOUNT_CODE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildACCOUNT_CONTROL.SetLookupParamValue("W_ENABLED_YN", "Y");
        }

        private void ilaINTEREST_TYPE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter("INTEREST_TYPE", "Y");
        }
        
        private void ilaINTEREST_PAYMENT_TYPE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter("INTEREST_PAYMENT_TYPE", "Y");
        }

        private void ilaLOAN_BANK_ACCOUNT_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildBANK_ACCOUNT.SetLookupParamValue("W_ENABLED_YN", "Y");
        }

        private void ilaCOST_CENTER_PrePopupShow_1(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCOST_CENTER.SetLookupParamValue("W_ENABLED_YN", "Y");
        }

        private void ilaCOST_CENTER_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCOMMON.SetLookupParamValue("W_SOB_ID", isAppInterfaceAdv1.SOB_ID);
            ildCOMMON.SetLookupParamValue("W_ORG_ID", isAppInterfaceAdv1.ORG_ID);
        }

        #endregion

        #region ----- Adapter Event -----

        private void idaLONE_MASTER_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {
            if (iString.ISNull(e.Row["LOAN_NUM"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10192"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                LOAN_NUM.Focus();
                return;
            }
            if (iString.ISNull(e.Row["LOAN_KIND"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10193"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                LOAN_KIND_NAME.Focus();
                return;
            }
            if (iString.ISNull(e.Row["LOAN_TYPE"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10194"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                LOAN_TYPE_NAME.Focus();
                return;
            }
            if (iString.ISNull(e.Row["LOAN_USE"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10195"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                LOAN_USE_NAME.Focus();
                return;
            }
            if (iString.ISNull(e.Row["LOAN_KIND"]) == "2".ToString() || iString.ISNull(e.Row["LOAN_KIND"]) == "3".ToString())
            {
                if (iString.ISNull(e.Row["L_ISSUE_DATE"]) == string.Empty)
                {
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10196"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    e.Cancel = true;
                    L_ISSUE_DATE.Focus();
                    return;
                }
                if (iString.ISNull(e.Row["L_DUE_DATE"]) == string.Empty)
                {
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10145"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    e.Cancel = true;
                    L_DUE_DATE.Focus();
                    return;
                }
                if (iString.ISNull(e.Row["L_CURRENCY_CODE"]) == string.Empty)
                {
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10124"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    e.Cancel = true;
                    L_CURRENCY_CODE.Focus();
                    return;
                }
                if (mCurrency_Code != iString.ISNull(e.Row["L_CURRENCY_CODE"]))
                {
                    if (iString.ISNull(e.Row["L_EXCHANGE_RATE"]) == string.Empty)
                    {
                        MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10125"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                        e.Cancel = true;
                        L_EXCHANGE_RATE.Focus();
                        return;
                    }
                    if (iString.ISNull(e.Row["LIMIT_CURR_AMOUNT"]) == string.Empty)
                    {
                        MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10127"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                        e.Cancel = true;
                        LIMIT_CURR_AMOUNT.Focus();
                        return;
                    }
                }
                if (iString.ISNull(e.Row["LIMIT_AMOUNT"]) == string.Empty)
                {
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10197"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    e.Cancel = true;
                    LIMIT_AMOUNT.Focus();
                    return;
                }
            }
            else
            {
                if (iString.ISNull(e.Row["ISSUE_DATE"]) == string.Empty)
                {
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10196"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    e.Cancel = true;
                    ISSUE_DATE.Focus();
                    return;
                }
                if (iString.ISNull(e.Row["DUE_DATE"]) == string.Empty)
                {
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10145"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    e.Cancel = true;
                    DUE_DATE.Focus();
                    return;
                }
                if (iString.ISNull(e.Row["CURRENCY_CODE"]) == string.Empty)
                {
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10124"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    e.Cancel = true;
                    CURRENCY_CODE.Focus();
                    return;
                }
                if (mCurrency_Code != iString.ISNull(e.Row["CURRENCY_CODE"]))
                {
                    if (iString.ISNull(e.Row["EXCHANGE_RATE"]) == string.Empty)
                    {
                        MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10125"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                        e.Cancel = true;
                        EXCHANGE_RATE.Focus();
                        return;
                    }
                    if (iString.ISNull(e.Row["LOAN_CURR_AMOUNT"]) == string.Empty)
                    {
                        MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10127"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                        e.Cancel = true;
                        LOAN_CURR_AMOUNT.Focus();
                        return;
                    }

                }
                if (iString.ISNull(e.Row["LOAN_AMOUNT"]) == string.Empty)
                {
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10197"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    e.Cancel = true;
                    LOAN_AMOUNT.Focus();
                    return;
                }
            }
            
            if (iString.ISNull(e.Row["LOAN_ACCOUNT_CONTROL_ID"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10123"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                LOAN_ACCOUNT_CONTROL_NAME.Focus();
                return;
            }
            if (iString.ISNull(e.Row["LOAN_BANK_ID"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10200"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                LOAN_BANK_NAME.Focus();
                return;
            }
        }

        private void idaLONE_MASTER_PreDelete(ISPreDeleteEventArgs e)
        {
            
        }

        private void idaLONE_MASTER_NewRowMoved(object pSender, ISBindingEventArgs pBindingManager)
        {
            Init_Item(LOAN_KIND.EditValue);
        }
        
        #endregion




    }
}