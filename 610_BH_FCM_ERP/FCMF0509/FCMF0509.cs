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

namespace FCMF0509
{
    public partial class FCMF0509 : Office2007Form
    {
        #region ----- Variables -----

        ISFunction.ISConvert iString = new ISFunction.ISConvert();
        ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        object mCurrency_Code;

        #endregion;

        #region ----- Constructor -----

        public FCMF0509()
        {
            InitializeComponent();
        }

        public FCMF0509(Form pMainForm, ISAppInterface pAppInterface)
        {
            InitializeComponent();
            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;
        }

        #endregion;

        #region ----- Private Methods ----

        private void SearchDB()
        {
            idaLC_MASTER.Fill();
            igrLC_LIST.Focus();
        }

        private void Insert_LC()
        {
            CURRENCY_CODE.EditValue = mCurrency_Code;

            idcDEFAULT_VALUE.SetCommandParamValue("W_GROUP_CODE", "TRANS_STATUS");
            idcDEFAULT_VALUE.ExecuteNonQuery();
            TRANS_TRANS_NAME.EditValue = idcDEFAULT_VALUE.GetCommandParamValue("O_CODE_NAME");
            TRANS_STATUS.EditValue = idcDEFAULT_VALUE.GetCommandParamValue("O_CODE");
            LC_NUM.Focus();
        }

        private void Open_Amount()
        {
            decimal pExchange_Rate = iString.ISDecimaltoZero(EXCHANGE_RATE.EditValue, 1);
            decimal pOpen_Curr_Amount = iString.ISDecimaltoZero(OPEN_CURR_AMOUNT.EditValue);
            decimal mOpenAmount = Math.Round(pExchange_Rate * pOpen_Curr_Amount, 2);
            if (iString.ISDecimaltoZero(OPEN_AMOUNT.EditValue, 0) == 0)
            {
                OPEN_AMOUNT.EditValue = mOpenAmount;
            }
        }

        private void Init_Currency_Amount()
        {
            if (iString.ISNull(CURRENCY_CODE.EditValue) == string.Empty || CURRENCY_CODE.EditValue.ToString() == mCurrency_Code.ToString())
            {
                EXCHANGE_RATE.EditValue = DBNull.Value;

                if (iString.ISDecimaltoZero(OPEN_CURR_AMOUNT.EditValue) != Convert.ToDecimal(0))
                {
                    OPEN_CURR_AMOUNT.EditValue = 0;
                }
                EXCHANGE_RATE.ReadOnly = true;
                EXCHANGE_RATE.Insertable = false;
                EXCHANGE_RATE.Updatable = false;

                OPEN_CURR_AMOUNT.ReadOnly = true;
                OPEN_CURR_AMOUNT.Insertable = false;
                OPEN_CURR_AMOUNT.Updatable = false;

                EXCHANGE_RATE.TabStop = false;
                OPEN_CURR_AMOUNT.TabStop = false;
            }
            else
            {
                EXCHANGE_RATE.ReadOnly = false;
                EXCHANGE_RATE.Insertable = true;
                EXCHANGE_RATE.Updatable = true;

                OPEN_CURR_AMOUNT.ReadOnly = false;
                OPEN_CURR_AMOUNT.Insertable = true;
                OPEN_CURR_AMOUNT.Updatable = true;

                EXCHANGE_RATE.TabStop = true;
                OPEN_CURR_AMOUNT.TabStop = true;
            }
            EXCHANGE_RATE.Refresh();
            OPEN_CURR_AMOUNT.Refresh();
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
                    if (idaLC_MASTER.IsFocused)
                    {
                        idaLC_MASTER.AddOver();
                        Insert_LC();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddUnder)
                {
                    if (idaLC_MASTER.IsFocused)
                    {
                        idaLC_MASTER.AddUnder();
                        Insert_LC();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Update)
                {
                    if (idaLC_MASTER.IsFocused)
                    {
                        idaLC_MASTER.Update();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Cancel)
                {
                    if (idaLC_MASTER.IsFocused)
                    {
                        idaLC_MASTER.Cancel();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {
                    if (idaLC_MASTER.IsFocused)
                    {
                        idaLC_MASTER.Delete();
                    }
                }
            }
        }

        #endregion;

        #region ----- Form Event -----

        private void FCMF0509_Load(object sender, EventArgs e)
        {
            idaLC_MASTER.FillSchema();
        }

        private void FCMF0509_Shown(object sender, EventArgs e)
        {
            idcACCOUNT_BOOK.ExecuteNonQuery();
            mCurrency_Code = idcACCOUNT_BOOK.GetCommandParamValue("O_CURRENCY_CODE");            
        }

        private void EXCHANGE_RATE_CurrentEditValidated(object pSender, ISEditAdvValidatedEventArgs e)
        {
            Open_Amount();
        }

        private void OPEN_CURR_AMOUNT_CurrentEditValidated(object pSender, ISEditAdvValidatedEventArgs e)
        {
            Open_Amount();
        }

        #endregion

        #region ----- Lookup Event -----

        private void ilaBANK_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildBANK.SetLookupParamValue("W_ENABLED_YN", "Y");
        }

        private void ilaTRANS_STATUS_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", "TRANS_STATUS");
            ildCOMMON.SetLookupParamValue("W_ENABLED_YN", "Y");
        }

        private void ilaSUPPLIER_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildSUPPLIER.SetLookupParamValue("W_SUPP_CUST_TYPE", "S");
            ildSUPPLIER.SetLookupParamValue("W_ENABLED_YN", "Y");
        }

        private void ilaCURRENCY_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCURRENCY.SetLookupParamValue("W_ENABLED_YN", "Y");
        }

        private void ilaCURRENCY_SelectedRowData(object pSender)
        {
            Init_Currency_Amount();
        }
        
        #endregion

        #region ----- Adapter Event -----

        private void idaLC_MASTER_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {
            if (iString.ISNull(LC_NUM.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10240"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(TRANS_STATUS.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10241"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(BANK_ID.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10200"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(OPEN_DATE.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10242", "&&VALUE:=OPEN"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(CURRENCY_CODE.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10124"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(OPEN_AMOUNT.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10243", "&&VALUE:=OPEN"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
        }

        private void idaLC_MASTER_NewRowMoved(object pSender, ISBindingEventArgs pBindingManager)
        {
            Init_Currency_Amount();
        }

        #endregion

    }
}