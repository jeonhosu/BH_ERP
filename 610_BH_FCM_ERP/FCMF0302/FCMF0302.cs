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

namespace FCMF0302
{
    public partial class FCMF0302 : Office2007Form
    {
        ISFunction.ISConvert iString = new ISFunction.ISConvert();
        ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        #region ----- Variables -----

        object mCurrency_Code;
        
        #endregion;

        #region ----- Constructor -----

        public FCMF0302()
        {
            InitializeComponent();
        }

        public FCMF0302(Form pMainForm, ISAppInterface pAppInterface)
        {
            InitializeComponent();
            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;
        }

        #endregion;

        #region ----- Private Methods -----

        private void Search_DB()
        {
            if (iString.ISNull(ASSET_CATEGORY_ID_0.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10101"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                ASSET_CATEGORY_NAME_0.Focus();
                return;
            };
            idaASSET_MASTER.Fill();
            igrASSET_MASTER.Focus();
        }

        private void Search_DB_HISTORY()
        {
            idaASSET_HISTORY.Fill();
        }

        private void Insert_Asset_Master()
        {
            CURRENCY_CODE.EditValue = mCurrency_Code;
            Init_Currency_Amount();

            DPR_YN.CheckBoxValue = "Y";
            IFRS_DPR_YN.CheckBoxValue = "Y";
            ACQUIRE_DATE.EditValue = DateTime.Today;
            REGISTER_DATE.EditValue = DateTime.Today;

            idcASSET_STATUS.SetCommandParamValue("W_GROUP_CODE", "ASSET_STATUS");
            idcASSET_STATUS.ExecuteNonQuery();
            ASSET_STATUS_CODE.EditValue = idcASSET_STATUS.GetCommandParamValue("O_CODE");
            ASSET_STATUS_NAME.EditValue = idcASSET_STATUS.GetCommandParamValue("O_CODE_NAME");
            ASSET_CODE.Focus();
        }

        private void Insert_Asset_History()
        {
            // 자산마스터 내용 INSERT.
            igrASSET_HISTORY.SetCellValue("CHARGE_DATE", DateTime.Today);
            igrASSET_HISTORY.SetCellValue("CURRENCY_CODE", CURRENCY_CODE.EditValue);
            igrASSET_HISTORY.SetCellValue("EXCHANGE_RATE", EXCHANGE_RATE.EditValue);
            igrASSET_HISTORY.SetCellValue("CURR_AMOUNT", CURR_AMOUNT.EditValue);
            igrASSET_HISTORY.SetCellValue("AMOUNT", 0);
            igrASSET_HISTORY.SetCellValue("QTY", QTY.EditValue);
            igrASSET_HISTORY.SetCellValue("DEPT_ID", MANAGE_DEPT_ID.EditValue);
            igrASSET_HISTORY.SetCellValue("DEPT_NAME", MANAGE_DEPT_NAME.EditValue);
            igrASSET_HISTORY.SetCellValue("LOCATION_ID", LOCATION_ID.EditValue);
            igrASSET_HISTORY.SetCellValue("LOCATION_NAME", LOCATION_NAME.EditValue);
            igrASSET_HISTORY.SetCellValue("COST_CENTER_ID", COST_CENTER_ID.EditValue);
            igrASSET_HISTORY.SetCellValue("COST_CENTER_NAME", CC_DESC.EditValue);
            igrASSET_HISTORY.SetCellValue("BF_CURRENCY_CODE", CURRENCY_CODE.EditValue);
            igrASSET_HISTORY.SetCellValue("BF_EXCHANGE_RATE", EXCHANGE_RATE.EditValue);
            igrASSET_HISTORY.SetCellValue("BF_CURR_AMOUNT", CURR_AMOUNT.EditValue);
            igrASSET_HISTORY.SetCellValue("BF_AMOUNT", AMOUNT.EditValue);
            igrASSET_HISTORY.SetCellValue("BF_QTY", QTY.EditValue);
            igrASSET_HISTORY.SetCellValue("BF_DEPT_ID", MANAGE_DEPT_ID.EditValue);
            igrASSET_HISTORY.SetCellValue("BF_DEPT_NAME", MANAGE_DEPT_NAME.EditValue);
            igrASSET_HISTORY.SetCellValue("BF_LOCATION_ID", LOCATION_ID.EditValue);
            igrASSET_HISTORY.SetCellValue("BF_LOCATION_NAME", LOCATION_NAME.EditValue);
            igrASSET_HISTORY.SetCellValue("BF_COST_CENTER_ID", COST_CENTER_ID.EditValue);
            igrASSET_HISTORY.SetCellValue("BF_COST_CENTER_NAME", CC_DESC.EditValue);
            igrASSET_HISTORY.SetCellValue("ASSET_ID", igrASSET_MASTER.GetCellValue("ASSET_ID"));
            Init_H_Currency_Amount();
        }

        private void SetCommon_Lookup_Parameter(string pGroup_Code, string pEnabled_YN)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", pGroup_Code);
            ildCOMMON.SetLookupParamValue("W_ENABLED_YN", pEnabled_YN);
        }
        
        private void Init_Currency_Amount()
        {
            if (iString.ISNull(CURRENCY_CODE.EditValue) == string.Empty || CURRENCY_CODE.EditValue.ToString() == mCurrency_Code.ToString())
            {
                if (iString.ISDecimaltoZero(EXCHANGE_RATE.EditValue) != Convert.ToDecimal(0))
                {
                    EXCHANGE_RATE.EditValue = DBNull.Value;   
                }
                if (iString.ISDecimaltoZero(CURR_AMOUNT.EditValue) != Convert.ToDecimal(0))
                {
                    CURR_AMOUNT.EditValue = 0;
                }
                EXCHANGE_RATE.ReadOnly = true;
                EXCHANGE_RATE.Insertable = false;
                EXCHANGE_RATE.Updatable = false;

                CURR_AMOUNT.ReadOnly = true;
                CURR_AMOUNT.Insertable = false;
                CURR_AMOUNT.Updatable = false;

                EXCHANGE_RATE.TabStop = false;
                CURR_AMOUNT.TabStop = false;
            }
            else
            {
                EXCHANGE_RATE.ReadOnly = false;
                EXCHANGE_RATE.Insertable = true;
                EXCHANGE_RATE.Updatable = true;

                CURR_AMOUNT.ReadOnly = false;
                CURR_AMOUNT.Insertable = true;
                CURR_AMOUNT.Updatable = true;

                EXCHANGE_RATE.TabStop = true;
                CURR_AMOUNT.TabStop = true;
            }
            EXCHANGE_RATE.Refresh();
            CURR_AMOUNT.Refresh();
        }

        private void Init_H_Currency_Amount()
        {
            if (iString.ISNull(igrASSET_HISTORY.GetCellValue("CURRENCY_CODE")) == string.Empty 
                || iString.ISNull(igrASSET_HISTORY.GetCellValue("CURRENCY_CODE")) == mCurrency_Code.ToString())
            {                
                igrASSET_HISTORY.GridAdvExColElement[igrASSET_HISTORY.GetColumnToIndex("EXCHANGE_RATE")].ReadOnly = 1;
                igrASSET_HISTORY.GridAdvExColElement[igrASSET_HISTORY.GetColumnToIndex("EXCHANGE_RATE")].Insertable = 0;
                igrASSET_HISTORY.GridAdvExColElement[igrASSET_HISTORY.GetColumnToIndex("EXCHANGE_RATE")].Updatable = 0;

                igrASSET_HISTORY.GridAdvExColElement[igrASSET_HISTORY.GetColumnToIndex("CURR_AMOUNT")].ReadOnly = 1;
                igrASSET_HISTORY.GridAdvExColElement[igrASSET_HISTORY.GetColumnToIndex("CURR_AMOUNT")].Insertable = 0;
                igrASSET_HISTORY.GridAdvExColElement[igrASSET_HISTORY.GetColumnToIndex("CURR_AMOUNT")].Updatable = 0;
            }
            else
            {
                igrASSET_HISTORY.GridAdvExColElement[igrASSET_HISTORY.GetColumnToIndex("EXCHANGE_RATE")].ReadOnly = 0;
                igrASSET_HISTORY.GridAdvExColElement[igrASSET_HISTORY.GetColumnToIndex("EXCHANGE_RATE")].Insertable = 1;
                igrASSET_HISTORY.GridAdvExColElement[igrASSET_HISTORY.GetColumnToIndex("EXCHANGE_RATE")].Updatable = 1;

                igrASSET_HISTORY.GridAdvExColElement[igrASSET_HISTORY.GetColumnToIndex("CURR_AMOUNT")].ReadOnly = 0;
                igrASSET_HISTORY.GridAdvExColElement[igrASSET_HISTORY.GetColumnToIndex("CURR_AMOUNT")].Insertable = 1;
                igrASSET_HISTORY.GridAdvExColElement[igrASSET_HISTORY.GetColumnToIndex("CURR_AMOUNT")].Updatable = 1;
            }
            igrASSET_HISTORY.Refresh();
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
                    if (idaASSET_MASTER.IsFocused)
                    {
                        idaASSET_MASTER.AddOver();
                        Insert_Asset_Master();
                    }
                    else if (idaASSET_HISTORY.IsFocused)
                    {
                        idaASSET_HISTORY.AddOver();
                        Insert_Asset_History();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddUnder)
                {
                    if (idaASSET_MASTER.IsFocused)
                    {
                        idaASSET_MASTER.AddUnder();
                        Insert_Asset_Master();
                    }
                    else if (idaASSET_HISTORY.IsFocused)
                    {
                        idaASSET_HISTORY.AddUnder();
                        Insert_Asset_History();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Update)
                {
                    idaASSET_MASTER.Update();
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Cancel)
                {
                    if (idaASSET_MASTER.IsFocused)
                    {
                        idaASSET_MASTER.Cancel();
                    }
                    else if (idaASSET_HISTORY.IsFocused)
                    {
                        idaASSET_HISTORY.Cancel();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {
                    if (idaASSET_MASTER.IsFocused)
                    {
                        idaASSET_MASTER.Delete();
                    }
                    else if (idaASSET_HISTORY.IsFocused)
                    {
                        idaASSET_HISTORY.Delete();
                    }
                }
            }
        }

        #endregion;

        #region ----- Form Event -----


        private void FCMF0302_Load(object sender, EventArgs e)
        {
            idaASSET_MASTER.FillSchema();
        }

        private void FCMF0302_Shown(object sender, EventArgs e)
        {
            idcACCOUNT_BOOK.ExecuteNonQuery();
            mCurrency_Code = idcACCOUNT_BOOK.GetCommandParamValue("O_CURRENCY_CODE");
        }

        private void PROGRESS_YEAR_CurrentEditValidated(object pSender, ISEditAdvValidatedEventArgs e)
        {
            if (iString.ISNull(CC_DESC.EditValue) == string.Empty)
            {
                CC_DESC.EditValue = EXCHANGE_RATE.EditValue;
            }
        }

        private void DPR_PROGRESS_YEAR_CurrentEditValidated(object pSender, ISEditAdvValidatedEventArgs e)
        {
            idcDPR_RATE.SetCommandParamValue("W_DPR_TYPE", "10");
            idcDPR_RATE.SetCommandParamValue("W_DPR_METHOD_TYPE", DPR_METHOD_TYPE.EditValue);
            idcDPR_RATE.SetCommandParamValue("W_SOB_ID", isAppInterfaceAdv1.SOB_ID);
            idcDPR_RATE.SetCommandParamValue("W_PROGRESS_YEAR", DPR_PROGRESS_YEAR.EditValue);
            idcDPR_RATE.ExecuteNonQuery();
            DPR_RATE.EditValue = idcDPR_RATE.GetCommandParamValue("O_DPR_RATE");
        }

        private void IFRS_PROGRESS_YEAR_CurrentEditValidated(object pSender, ISEditAdvValidatedEventArgs e)
        {
            idcDPR_RATE.SetCommandParamValue("W_DPR_TYPE", "10");
            idcDPR_RATE.SetCommandParamValue("W_DPR_METHOD_TYPE", IFRS_DPR_METHOD_TYPE.EditValue);
            idcDPR_RATE.SetCommandParamValue("W_SOB_ID", isAppInterfaceAdv1.SOB_ID);
            idcDPR_RATE.SetCommandParamValue("W_PROGRESS_YEAR", IFRS_PROGRESS_YEAR.EditValue);
            idcDPR_RATE.ExecuteNonQuery();
            IFRS_DPR_RATE.EditValue = idcDPR_RATE.GetCommandParamValue("O_DPR_RATE");
        }

        private void itbASSET_MASTER_Click(object sender, EventArgs e)
        {
            if (itbASSET_MASTER.SelectedTab.TabIndex == itpASSET_HISTORY.TabIndex)
            {
                igrASSET_HISTORY.Focus();
            }
            else
            {
                igrASSET_MASTER.Focus();
            }
        }

        private void ACQUIRE_DATE_CurrentEditValidated(object pSender, ISEditAdvValidatedEventArgs e)
        {
            if (iString.ISNull(ACQUIRE_DATE.EditValue) != String.Empty)
            {
                REGISTER_DATE.EditValue = ACQUIRE_DATE.EditValue;
            }
        }

        #endregion
        
        #region ----- Lookup Event -----

        private void ilaASSET_CATEGORY_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildASSET_CATEGORY.SetLookupParamValue("W_ENABLED_YN", "N");
        }

        private void ilaCOSTCENTER_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCOSTCENTER.SetLookupParamValue("W_ENABLED_YN", "Y");
        }

        private void ilaEXPENSE_TYPE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommon_Lookup_Parameter("EXPENSE_TYPE", "Y");
        }

        private void ilaACCOUNT_CONTROL_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildACCOUNT_CONTROL.SetLookupParamValue("W_ENABLED_YN", "Y");
        }

        private void ilaIFRS_DPR_METHOD_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommon_Lookup_Parameter("DPR_METHOD_TYPE", "Y");
        }

        private void ilaDEPT_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildDEPT.SetLookupParamValue("W_ENABLED_YN", "Y");
        }

        private void ilaDPR_METHOD_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommon_Lookup_Parameter("DPR_METHOD_TYPE", "Y");
        }

        private void ilaASSET_LOCATION_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommon_Lookup_Parameter("ASSET_LOCATION", "Y");
        }

        private void ilaCURRENCY_CODE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCURRENCY.SetLookupParamValue("W_ENABLED_YN", "Y");
        }

        private void ilaASSET_STATUS_NAME_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommon_Lookup_Parameter("ASSET_STATUS", "Y");
        }

        private void ilaASSET_CATEGORY_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildASSET_CATEGORY.SetLookupParamValue("W_ENABLED_YN", "Y");
        }

        private void ilaCURRENCY_CODE_SelectedRowData(object pSender)
        {
            Init_Currency_Amount();
        }

        private void ilaASSET_STATUS_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommon_Lookup_Parameter("ASSET_STATUS", "Y");
        }

        private void ilaCUSTOMER_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCUSTOMER.SetLookupParamValue("W_SUPP_CUST_TYPE", "S");
            ildCUSTOMER.SetLookupParamValue("W_ENABLED_YN", "Y");
        }

        private void ilaDPR_METHOD_SelectedRowData(object pSender)
        {
            if (iString.ISNull(COST_CENTER_ID.EditValue) == string.Empty)
            {                
                IFRS_DPR_METHOD_NAME.EditValue = DPR_METHOD_NAME.EditValue;
                IFRS_DPR_METHOD_TYPE.EditValue = DPR_METHOD_TYPE.EditValue;
            }
        }

        private void ilaH_ASSET_CHARGE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommon_Lookup_Parameter("ASSET_CHARGE", "Y");
        }

        private void ilaH_CURRENCY_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCURRENCY.SetLookupParamValue("W_ENABLED_YN", "Y");
        }

        private void ilaH_ASSET_LOCATION_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommon_Lookup_Parameter("ASSET_LOCATION", "Y");
        }

        private void ilaH_DEPT_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildDEPT.SetLookupParamValue("W_ENABLED_YN", "Y");
        }

        private void ilaH_CURRENCY_SelectedRowData(object pSender)
        {
            Init_H_Currency_Amount();
        }

        #endregion

        #region ----- Adapeter Event -----

        private void idaASSET_MASTER_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {
            if (iString.ISNull(e.Row["ASSET_CODE"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10201"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }            
            if (iString.ISNull(e.Row["ASSET_DESC"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10201"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                ASSET_DESC.Focus();
                return;
            }
            if (iString.ISNull(e.Row["EXPENSE_TYPE"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10216"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                EXPENSE_TYPE_NAME.Focus();
                return;
            }
            if (iString.ISNull(e.Row["ASSET_CATEGORY_ID"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10093"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                ASSET_CATEGORY_NAME.Focus();
                return;
            }            
            if (iString.ISNull(e.Row["ACQUIRE_DATE"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10203"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                ACQUIRE_DATE.Focus();
                return;
            }
            if (iString.ISNull(e.Row["REGISTER_DATE"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10204"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                REGISTER_DATE.Focus();
                return;
            }
            if (iString.ISNull(e.Row["LOCATION_ID"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10205"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                LOCATION_NAME.Focus();
                return;
            }            
            //if (iString.ISNull(e.Row["CURRENCY_CODE"]) == string.Empty)
            //{
            //    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10124"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            //    e.Cancel = true;
            //    CURRENCY_CODE.Focus();
            //    return;
            //}
            //if (iString.ISNull(e.Row["CURRENCY_CODE"]) == string.Empty)
            //{
            //    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10124"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            //    e.Cancel = true;
            //    CURRENCY_CODE.Focus();
            //    return;
            //}
            if (iString.ISNull(e.Row["AMOUNT"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10208"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                AMOUNT.Focus();
                return;
            }
            if (iString.ISNull(DPR_YN.CheckBoxValue) == "Y".ToString())
            {
                if (iString.ISNull(e.Row["DPR_METHOD_TYPE"]) == string.Empty)
                {
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10097"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    e.Cancel = true;
                    DPR_METHOD_NAME.Focus();
                    return;
                }
                if (iString.ISNull(e.Row["DPR_PROGRESS_YEAR"]) == string.Empty)
                {
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10098"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    e.Cancel = true;
                    DPR_PROGRESS_YEAR.Focus();
                    return;
                }
            }
            if (iString.ISNull(IFRS_DPR_YN.CheckBoxValue) == "Y".ToString())
            {
                if (iString.ISNull(e.Row["IFRS_DPR_METHOD_TYPE"]) == string.Empty)
                {
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10097"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    e.Cancel = true;
                    IFRS_DPR_METHOD_NAME.Focus();
                    return;
                }
                if (iString.ISNull(e.Row["IFRS_PROGRESS_YEAR"]) == string.Empty)
                {
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10098"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    e.Cancel = true;
                    IFRS_PROGRESS_YEAR.Focus();
                    return;
                }
            }
        }

        private void idaASSET_MASTER_PreDelete(ISPreDeleteEventArgs e)
        {
            if (e.Row.RowState != DataRowState.Added)
            {
                if (iString.ISNull(e.Row["ASSET_CODE"]) == string.Empty)
                {
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10209"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    e.Cancel = true;
                    return;
                }
            }
        }

        private void idaASSET_MASTER_PreNewRowMoved(object pSender, ISBindingEventArgs pBindingManager)
        {
            if (pBindingManager.RowPosition < 0)
            {
                return;
            }
            Search_DB_HISTORY();
        }

        private void idaASSET_HISTORY_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {
            if (iString.ISNull(e.Row["ASSET_ID"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10232"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }    
            if (iString.ISNull(e.Row["CHARGE_DATE"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10223"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                igrASSET_HISTORY.CurrentCellMoveTo(igrASSET_HISTORY.RowIndex, igrASSET_HISTORY.GetColumnToIndex("CHARGE_DATE"));
                igrASSET_HISTORY.Focus();
                return;
            }
            if (iString.ISNull(e.Row["CHARGE_ID"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10224"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                igrASSET_HISTORY.CurrentCellMoveTo(igrASSET_HISTORY.RowIndex, igrASSET_HISTORY.GetColumnToIndex("CHARGE_NAME"));
                igrASSET_HISTORY.Focus();
                return;
            }
        }

        private void idaASSET_HISTORY_PreDelete(ISPreDeleteEventArgs e)
        {

        }

        private void idaASSET_HISTORY_NewRowMoved(object pSender, ISBindingEventArgs pBindingManager)
        {
            if (igrASSET_HISTORY.RowIndex > -1)
            {
                Init_H_Currency_Amount();
            }
        }
    
        #endregion


    }
}