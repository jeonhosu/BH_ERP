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

namespace FCMF0514
{
    public partial class FCMF0514 : Office2007Form
    {
        #region ----- Variables -----

        ISFunction.ISConvert iString = new ISFunction.ISConvert();
        ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        //int mAccount_Book_ID;
        //string mCurrency_Code;

        #endregion;

        #region ----- Constructor -----

        public FCMF0514()
        {
            InitializeComponent();
        }

        public FCMF0514(Form pMainForm, ISAppInterface pAppInterface)
        {
            InitializeComponent();
            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;
        }

        #endregion;

        #region ----- Private Methods ----

        private void SearchDB()
        {
            idaDEPOSIT_MASTER.Fill();
            isgBANK_ACCOUNT_LIST.Focus();
        }

        private void Insert_Loan_Master()
        {

            BANK_ACCOUNT_NUM.Focus();
        }

        private void SetCommonParameter(string pGroup_Code, string pEnabled_YN)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", pGroup_Code);
            ildCOMMON.SetLookupParamValue("W_ENABLED_YN", pEnabled_YN);
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
                    if (idaDEPOSIT_MASTER.IsFocused)
                    {
                        idaDEPOSIT_MASTER.AddOver();
                        Insert_Loan_Master();
                     }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddUnder)
                {
                    if (idaDEPOSIT_MASTER.IsFocused)
                    {                        
                        idaDEPOSIT_MASTER.AddUnder();
                        Insert_Loan_Master();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Update)
                {
                    idaDEPOSIT_MASTER.Update();
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Cancel)
                {
                    if (idaDEPOSIT_MASTER.IsFocused)
                    {
                        idaDEPOSIT_MASTER.Cancel();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {
                    if (idaDEPOSIT_MASTER.IsFocused)
                    {
                        idaDEPOSIT_MASTER.Delete();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Print)
                {
                    if (idaDEPOSIT_MASTER.IsFocused)
                    {
                    } 
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Export)
                {
                    if (idaDEPOSIT_MASTER.IsFocused)
                    {
                    }
                }
            }
        }

        #endregion;

        #region ----- Form Event -----

        private void FCMF0514_Load(object sender, EventArgs e)
        {
            idaDEPOSIT_MASTER.FillSchema();
        }

        #endregion

        #region ----- Lookup Event -----


        private void ilaCURRENCY_CODE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCURRENCY_CODE.SetLookupParamValue("W_ENABLED_YN", "Y");
        }

        private void ilaINTEREST_TYPE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter("INTEREST_TYPE", "Y");
        }
        
        private void ilaINTEREST_PAYMENT_TYPE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter("INTEREST_PAYMENT_TYPE", "Y");
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

        private void ilaSTATUS_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter("TRANS_STATUS", "Y");
        }

        private void ilaDEPOSIT_TYPE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter("DEPOSIT_GB", "Y");
        }

        private void ilaACCOUNT_TYPE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter("ACCOUNT_TYPE", "Y");
        }

        private void diposit_curr_amount()
        {
            decimal vRate = 0;
            decimal vDeposit_Amount = 0;

            vRate = Convert.ToDecimal(EXCHANGE_RATE.EditValue.ToString());
            vDeposit_Amount = Convert.ToDecimal(DEPOSIT_AMOUNT.EditValue.ToString());

            if (vRate > 0)
            {
                DEPOSIT_CURR_AMOUNT.EditValue = vRate * vDeposit_Amount;
            }
            else
            {
                DEPOSIT_CURR_AMOUNT.EditValue = vDeposit_Amount;
            }
        }

        private void cancel_amount()
        {
            decimal vCancel_Rate = 0;
            decimal vCancel_Amount = 0;
            decimal vCancel_Prin_Amount = 0;
            decimal vCancel_Inter_Amount = 0;
            decimal vFinal_Amount = 0;

            vCancel_Rate = Convert.ToDecimal(CANCEL_EXCHANGE_RATE.EditValue.ToString());
            vCancel_Amount = Convert.ToDecimal(CANCEL_AMOUNT.EditValue.ToString());
            vCancel_Prin_Amount = Convert.ToDecimal(CANCEL_PRIN_AMOUNT.EditValue.ToString());
            vCancel_Inter_Amount = Convert.ToDecimal(CANCEL_INTER_AMOUNT.EditValue.ToString());
            vFinal_Amount = Convert.ToDecimal(FINAL_AMOUNT.EditValue.ToString());

            if (vCancel_Rate > 0)
            {
                CANCEL_CURR_AMOUNT.EditValue = vCancel_Rate * vCancel_Amount;
                CANCEL_PRIN_CURR_AMOUNT.EditValue = vCancel_Rate * vCancel_Prin_Amount;
                CANCEL_INTER_CURR_AMOUNT.EditValue = vCancel_Rate * vCancel_Inter_Amount;
                FINAL_CURR_AMOUNT.EditValue = vCancel_Rate * vFinal_Amount;
            }
            else
            {
                CANCEL_CURR_AMOUNT.EditValue = vCancel_Amount;
                CANCEL_PRIN_CURR_AMOUNT.EditValue = vCancel_Prin_Amount;
                CANCEL_INTER_CURR_AMOUNT.EditValue = vCancel_Inter_Amount;
                FINAL_CURR_AMOUNT.EditValue = vFinal_Amount;
            }
        }
       
        #region ----- Adapter Event -----

        //private void idaLONE_MASTER_PreRowUpdate(ISPreRowUpdateEventArgs e)
        //{
        //    if (iString.ISNull(e.Row["LOAN_NUM"]) == string.Empty)
        //    {
        //        MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10192"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
        //        e.Cancel = true;
        //        LOAN_NUM.Focus();
        //        return;
        //    }
        //    if (iString.ISNull(e.Row["LOAN_KIND"]) == string.Empty)
        //    {
        //        MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10193"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
        //        e.Cancel = true;
        //        DEPOSIT_GB.Focus();
        //        return;
        //    }
        //    if (iString.ISNull(e.Row["LOAN_TYPE"]) == string.Empty)
        //    {
        //        MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10194"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
        //        e.Cancel = true;
        //        LOAN_TYPE_NAME.Focus();
        //        return;
        //    }
        //    if (iString.ISNull(e.Row["LOAN_USE"]) == string.Empty)
        //    {
        //        MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10195"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
        //        e.Cancel = true;
        //        LOAN_USE_NAME.Focus();
        //        return;
        //    }
        //    if (iString.ISNull(e.Row["LOAN_KIND"]) == "2")
        //    {
        //        if (iString.ISNull(e.Row["L_ISSUE_DATE"]) == string.Empty)
        //        {
        //            MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10196"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
        //            e.Cancel = true;
        //            PAYMENT_DATE.Focus();
        //            return;
        //        }
        //        if (iString.ISNull(e.Row["L_DUE_DATE"]) == string.Empty)
        //        {
        //            MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10145"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
        //            e.Cancel = true;
        //            L_DUE_DATE.Focus();
        //            return;
        //        }
        //        if (iString.ISNull(e.Row["L_CURRENCY_CODE"]) == string.Empty)
        //        {
        //            MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10124"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
        //            e.Cancel = true;
        //            L_CURRENCY_CODE.Focus();
        //            return;
        //        }
        //        if (mCurrency_Code != iString.ISNull(e.Row["L_CURRENCY_CODE"]))
        //        {
        //            if (iString.ISNull(e.Row["L_EXCHANGE_RATE"]) == string.Empty)
        //            {
        //                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10125"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
        //                e.Cancel = true;
        //                L_EXCHANGE_RATE.Focus();
        //                return;
        //            }
        //            if (iString.ISNull(e.Row["LIMIT_CURR_AMOUNT"]) == string.Empty)
        //            {
        //                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10127"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
        //                e.Cancel = true;
        //                LIMIT_CURR_AMOUNT.Focus();
        //                return;
        //            }
        //        }
        //        if (iString.ISNull(e.Row["LIMIT_AMOUNT"]) == string.Empty)
        //        {
        //            MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10197"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
        //            e.Cancel = true;
        //            DEPOSIT_AMOUNT.Focus();
        //            return;
        //        }
        //    }
        //    else
        //    {
        //        if (iString.ISNull(e.Row["ISSUE_DATE"]) == string.Empty)
        //        {
        //            MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10196"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
        //            e.Cancel = true;
        //            ISSUE_DATE.Focus();
        //            return;
        //        }
        //        if (iString.ISNull(e.Row["DUE_DATE"]) == string.Empty)
        //        {
        //            MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10145"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
        //            e.Cancel = true;
        //            DUE_DATE.Focus();
        //            return;
        //        }
        //        if (iString.ISNull(e.Row["CURRENCY_CODE"]) == string.Empty)
        //        {
        //            MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10124"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
        //            e.Cancel = true;
        //            CURRENCY_CODE.Focus();
        //            return;
        //        }
        //        if (mCurrency_Code != iString.ISNull(e.Row["CURRENCY_CODE"]))
        //        {
        //            if (iString.ISNull(e.Row["EXCHANGE_RATE"]) == string.Empty)
        //            {
        //                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10125"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
        //                e.Cancel = true;
        //                EXCHANGE_RATE.Focus();
        //                return;
        //            }
        //            if (iString.ISNull(e.Row["LOAN_CURR_AMOUNT"]) == string.Empty)
        //            {
        //                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10127"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
        //                e.Cancel = true;
        //                LOAN_CURR_AMOUNT.Focus();
        //                return;
        //            }

        //        }
        //        if (iString.ISNull(e.Row["LOAN_AMOUNT"]) == string.Empty)
        //        {
        //            MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10197"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
        //            e.Cancel = true;
        //            LOAN_AMOUNT.Focus();
        //            return;
        //        }
        //    }
            
        //    if (iString.ISNull(e.Row["LOAN_ACCOUNT_CONTROL_ID"]) == string.Empty)
        //    {
        //        MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10123"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
        //        e.Cancel = true;
        //        LOAN_ACCOUNT_CONTROL_NAME.Focus();
        //        return;
        //    }
        //    if (iString.ISNull(e.Row["LOAN_BANK_ID"]) == string.Empty)
        //    {
        //        MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10200"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
        //        e.Cancel = true;
        //        LOAN_BANK_NAME.Focus();
        //        return;
        //    }
        //    if (iString.ISNull(e.Row["LOAN_BANK_ACCOUNT_ID"]) == string.Empty)
        //    {
        //        MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10136"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
        //        e.Cancel = true;
        //        BANK_ACCOUNT_CODE.Focus();
        //        return;
        //    }
        //}

        #endregion


    }
}