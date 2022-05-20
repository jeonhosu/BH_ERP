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

namespace FCMF0912
{
    public partial class FCMF0912 : Office2007Form
    {
        #region ----- Variables -----

        ISFunction.ISConvert iString = new ISFunction.ISConvert();
        ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        #endregion;

        #region ----- Constructor -----

        public FCMF0912()
        {
            InitializeComponent();
        }

        public FCMF0912(Form pMainForm, ISAppInterface pAppInterface)
        {
            InitializeComponent();
            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;
        }

        #endregion;

        #region ----- Private Methods ----
        
        private void SearchDB()
        {            
            idaENDING_AMOUNT.Fill();
            idaCLOSING_AMOUNT.Fill();
            idaCLOSING_SLIP.Fill();

            // 분개 합계 표시
            idcCLOSING_SLIP_SUM.ExecuteNonQuery();
            DR_AMOUNT.EditValue = idcCLOSING_SLIP_SUM.GetCommandParamValue("O_DR_AMOUNT");
            CR_AMOUNT.EditValue = idcCLOSING_SLIP_SUM.GetCommandParamValue("O_CR_AMOUNT");
            GAP_AMOUNT.EditValue = idcCLOSING_SLIP_SUM.GetCommandParamValue("O_GAP_AMOUNT");

            if (itbCLOSING.SelectedIndex == 0)
            {
                igrENDING_AMOUNT.Focus();
            }
            else if (itbCLOSING.SelectedIndex == 1)
            {
                igrCLOSING_AMOUNT.Focus();
            }
            else if (itbCLOSING.SelectedIndex == 2)
            {
                igrCLOSING_SLIP.Focus();
            }
        }

        private void SetCommonParameter(object pGroup_Code, object pEnabled_YN)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", pGroup_Code);
            ildCOMMON.SetLookupParamValue("W_ENABLED_YN", pEnabled_YN);
        }

        private void SetInsert_EndingAmount()
        {
            igrENDING_AMOUNT.SetCellValue("PERIOD_NAME", PERIOD_NAME_0.EditValue);

            igrENDING_AMOUNT.CurrentCellMoveTo(igrENDING_AMOUNT.GetColumnToIndex("ACCOUNT_CODE"));
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
                    if (idaENDING_AMOUNT.IsFocused)
                    {
                        idaENDING_AMOUNT.AddOver();
                        SetInsert_EndingAmount();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddUnder)
                {
                    if (idaENDING_AMOUNT.IsFocused)
                    {
                        idaENDING_AMOUNT.AddUnder();
                        SetInsert_EndingAmount();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Update)
                {
                    if (idaENDING_AMOUNT.IsFocused)
                    {
                        idaENDING_AMOUNT.Update();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Cancel)
                {
                    if (idaENDING_AMOUNT.IsFocused)
                    {
                        idaENDING_AMOUNT.Cancel();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {
                    if (idaENDING_AMOUNT.IsFocused)
                    {
                        idaENDING_AMOUNT.Delete();
                    }
                }
            }
        }

        #endregion;

        #region ----- Form Event -----

        private void FCMF0912_Load(object sender, EventArgs e)
        {
            idaCLOSING_AMOUNT.FillSchema();
            idaCLOSING_SLIP.FillSchema();
            idaENDING_AMOUNT.FillSchema();
        }

        private void FCMF0912_Shown(object sender, EventArgs e)
        {
            PERIOD_NAME_0.EditValue = iDate.ISYearMonth(DateTime.Today);
        }

        private void ibtnSET_CLOSING_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            if (iString.ISNull(PERIOD_NAME_0.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10226"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                PERIOD_NAME_0.Focus();
                return;
            }
            Application.UseWaitCursor = true;
            this.Cursor = System.Windows.Forms.Cursors.WaitCursor;

            object mMessage;
            idcCLOSING_SET.ExecuteNonQuery();
            mMessage = idcCLOSING_SET.GetCommandParamValue("O_MESSAGE");
            
            this.Cursor = System.Windows.Forms.Cursors.Default;
            Application.UseWaitCursor = false;

            if (iString.ISNull(mMessage) != string.Empty)
            {
                MessageBoxAdv.Show(mMessage.ToString(), "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
        }

        private void btnCREATE_SLIP_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            if (iString.ISNull(PERIOD_NAME_0.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10226"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                PERIOD_NAME_0.Focus();
                return;
            }

            Application.UseWaitCursor = true;
            this.Cursor = System.Windows.Forms.Cursors.WaitCursor;

            object mMessage;
            idcINSERT_CLOSING_SLIP.ExecuteNonQuery();
            mMessage = idcINSERT_CLOSING_SLIP.GetCommandParamValue("O_MESSAGE");

            this.Cursor = System.Windows.Forms.Cursors.Default;
            Application.UseWaitCursor = false;

            if (iString.ISNull(mMessage) != string.Empty)
            {
                MessageBoxAdv.Show(mMessage.ToString(), "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
        }

        private void btnCANCEL_SLIP_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            if (iString.ISNull(PERIOD_NAME_0.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10226"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                PERIOD_NAME_0.Focus();
                return;
            }

            Application.UseWaitCursor = true;
            this.Cursor = System.Windows.Forms.Cursors.WaitCursor;

            object mMessage;
            idcCANCEL_CLOSING_SLIP.ExecuteNonQuery();
            mMessage = idcCANCEL_CLOSING_SLIP.GetCommandParamValue("O_MESSAGE");

            this.Cursor = System.Windows.Forms.Cursors.Default;
            Application.UseWaitCursor = false;

            if (iString.ISNull(mMessage) != string.Empty)
            {
                MessageBoxAdv.Show(mMessage.ToString(), "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
        }

        #endregion       

        #region ----- Lookup Event -----
        
        private void ilaCLOSING_ENDING_ACCOUNT_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCLOSING_ENDING_ACCOUNT.SetLookupParamValue("W_ENABLED_YN", "Y");
        }

        private void ilaACCOUNT_CONTROL_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildACCOUNT_CONTROL.SetLookupParamValue("W_ENABLED_YN", "Y");
        }

        private void ilaCLOSING_ACCOUNT_TYPE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter("CLOSING_ACCOUNT_TYPE", "Y");
        }

        private void ilaPERIOD_SelectedRowData(object pSender)
        {
            SearchDB();
        }

        #endregion

        #region ----- Adapter Event -----

        private void idaCLOSING_ACCOUNT_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {
            if (iString.ISNull(e.Row["PERIOD_NAME"]) == String.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10226"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["ACCOUNT_CONTROL_ID"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10123"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                igrENDING_AMOUNT.CurrentCellMoveTo(igrENDING_AMOUNT.GetColumnToIndex("ACCOUNT_CODE"));
                return;
            }
            if (iString.ISNull(e.Row["ACCOUNT_CODE"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10123"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                igrENDING_AMOUNT.CurrentCellMoveTo(igrENDING_AMOUNT.GetColumnToIndex("ACCOUNT_CODE"));
                return;
            }
            if (iString.ISNull(e.Row["ENDING_AMOUNT"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10074", "&&VALUE:=Ending Amount(기말금액)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                igrENDING_AMOUNT.CurrentCellMoveTo(igrENDING_AMOUNT.GetColumnToIndex("ENDING_AMOUNT"));
                return;
            }
        }

        private void idaCLOSING_ACCOUNT_PreDelete(ISPreDeleteEventArgs e)
        {
            if (iString.ISNull(e.Row["PERIOD_NAME"]) == String.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10226"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["ACCOUNT_CONTROL_ID"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10123"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                igrENDING_AMOUNT.CurrentCellMoveTo(igrENDING_AMOUNT.GetColumnToIndex("ACCOUNT_CODE"));
                return;
            }
        }

        #endregion

    }
}