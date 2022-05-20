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

namespace HRMF0379
{
    public partial class HRMF0379 : Office2007Form
    {
        #region ----- Variables -----

        private ISFunction.ISConvert iString = new ISFunction.ISConvert();
        private ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        //private ISCommonUtil.ISFunction.ISDateTime mGetDate = new ISCommonUtil.ISFunction.ISDateTime();

        #endregion;

        #region ----- Constructor -----

        public HRMF0379(Form pMainForm, ISAppInterface pAppInterface)
        {
            this.Visible = false;
            this.DoubleBuffered = true;

            InitializeComponent();
            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;
        }

        #endregion;

        #region ----- Private Methods -----

        private void DefaultSetFormReSize()
        {//[Child Form, Mdi Form에 맞게 ReSize]
            int vMinusWidth = 4;
            int vMinusHeight = 54;
            System.Drawing.Size vSize = this.MdiParent.ClientSize;
            this.Width = vSize.Width - vMinusWidth;
            this.Height = vSize.Height - vMinusHeight;
        }

        private void DefaultCorporation()
        {
            // Lookup SETTING
            ildCORP.SetLookupParamValue("W_DUTY_CONTROL_YN", "Y");
            ildCORP.SetLookupParamValue("W_ENABLED_FLAG_YN", "N");

            // LOOKUP DEFAULT VALUE SETTING - CORP
            idcDEFAULT_CORP.SetCommandParamValue("W_DUTY_CONTROL_YN", "Y");
            idcDEFAULT_CORP.SetCommandParamValue("W_ENABLED_FLAG_YN", "N");
            idcDEFAULT_CORP.ExecuteNonQuery();
            W_WORK_CORP_DESC.EditValue = idcDEFAULT_CORP.GetCommandParamValue("O_CORP_NAME");
            W_WORK_CORP_ID.EditValue = idcDEFAULT_CORP.GetCommandParamValue("O_CORP_ID");
        }

        private void Set_Transfer_Flag(int pTab_Index)
        {
            W_TRANSFER_FLAG.EditValue = "B";
            if (pTab_Index == 0)
            {
                W_TRANSFER_FLAG.EditValue = "C";    //확정승인-급여 미반영//
                BTN_TRANSFER_CANCEL.Visible = false;

                BTN_SET_OT_AMOUNT.Visible = true;
                BTN_TRANSFER_OK.Visible = true;
            }
            else if(pTab_Index == 1)
            {
                W_TRANSFER_FLAG.EditValue = "I";    //확정승인-급여 미반영//
                BTN_SET_OT_AMOUNT.Visible = false;
                BTN_TRANSFER_OK.Visible = false;

                BTN_TRANSFER_CANCEL.Visible = true;                
            }
        }

        private void Search_DB()
        {
            if (W_WORK_CORP_ID.EditValue == null)
            {// 업체.
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10001"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                W_WORK_CORP_DESC.Focus();
                return;
            }
            if (W_WORK_DATE_FR.EditValue == null)
            {// 근무일자
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10010"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                W_WORK_DATE_FR.Focus();
                return;
            }
            if (W_WORK_DATE_TO.EditValue == null)
            {// 근무일자
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10011"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                W_WORK_DATE_TO.Focus();
                return;
            }

            if (TB_MAIN.SelectedIndex == 0)
            {
                IDA_OT_SUM_TRANS_YET.Fill();
                IGR_OT_SUM_TRANS_YET.Focus();

                IDC_NO_CREATE_OT_AMOUNT_P.ExecuteNonQuery();
                PT_MESSAGE.PromptTextElement[0].Default = iString.ISNull(IDC_NO_CREATE_OT_AMOUNT_P.GetCommandParamValue("O_MESSAGE"));
                PT_MESSAGE.PromptTextElement[0].TL1_KR = iString.ISNull(IDC_NO_CREATE_OT_AMOUNT_P.GetCommandParamValue("O_MESSAGE"));
                PT_MESSAGE.Invalidate();
            }
            else if (TB_MAIN.SelectedIndex == 1)
            {
                IDA_OT_SUM_TRANS_OK.Fill();
                IGR_OT_SUM_TRANS_OK.Focus();
            }
        }

        private bool SET_OT_AMOUNT()
        {
            if (W_WORK_CORP_ID.EditValue == null)
            {// 업체.
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10001"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                W_WORK_CORP_DESC.Focus();
                return false;
            }
            if (W_WORK_DATE_FR.EditValue == null)
            {// 근무일자
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10010"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                W_WORK_DATE_FR.Focus();
                return false;
            }
            if (W_WORK_DATE_TO.EditValue == null)
            {// 근무일자
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10011"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                W_WORK_DATE_TO.Focus();
                return false;
            }

            if (iString.ISNull(W_TRANSFER_FLAG.EditValue) == string.Empty || iString.ISNull(W_TRANSFER_FLAG.EditValue) != "C")
            {//처리 상태
                MessageBoxAdv.Show("Status [Confirm] is not mismatch. Check Button status", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return false;
            }
           
            Application.UseWaitCursor = true;
            this.Cursor = System.Windows.Forms.Cursors.WaitCursor;
            Application.DoEvents();

            string mSTATUS = "F";
            string mMessage = null;
            
            IDC_CREATE_OT_AMOUNT.ExecuteNonQuery();

            mSTATUS = iString.ISNull(IDC_CREATE_OT_AMOUNT.GetCommandParamValue("O_STATUS"));
            mMessage = iString.ISNull(IDC_CREATE_OT_AMOUNT.GetCommandParamValue("O_MESSAGE"));
            if (IDC_CREATE_OT_AMOUNT.ExcuteError || mSTATUS == "F")
            {
                Application.UseWaitCursor = false;
                this.Cursor = System.Windows.Forms.Cursors.Default;
                Application.DoEvents();

                MessageBoxAdv.Show(mMessage, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return false;
            }
        
            Application.UseWaitCursor = false;
            this.Cursor = System.Windows.Forms.Cursors.Default;
            Application.DoEvents();

            return true;
        }

        private bool SET_OT_TRANS_OK()
        {
            if (W_WORK_CORP_ID.EditValue == null)
            {// 업체.
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10001"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                W_WORK_CORP_DESC.Focus();
                return false;
            }
            if (W_WORK_DATE_FR.EditValue == null)
            {// 근무일자
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10010"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                W_WORK_DATE_FR.Focus();
                return false;
            }
            if (W_WORK_DATE_TO.EditValue == null)
            {// 근무일자
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10011"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                W_WORK_DATE_TO.Focus();
                return false;
            }
            if (iString.ISNull(W_PAY_YYYYMM.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10107"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return false;
            }
            if (iString.ISNull(W_WAGE_TYPE.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10105"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return false;
            }

            if (iString.ISNull(W_TRANSFER_FLAG.EditValue) == string.Empty || iString.ISNull(W_TRANSFER_FLAG.EditValue) != "C")
            {//처리 상태
                MessageBoxAdv.Show("Status [Confirm] is not mismatch. Check Button status", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return false;
            }
           
            Application.UseWaitCursor = true;
            this.Cursor = System.Windows.Forms.Cursors.WaitCursor;
            Application.DoEvents();

            string mSTATUS = "F";
            string mMessage = null;

            IDC_NO_CREATE_OT_AMOUNT_P.ExecuteNonQuery();
            mSTATUS = iString.ISNull(IDC_NO_CREATE_OT_AMOUNT_P.GetCommandParamValue("O_STATUS"));
            mMessage = iString.ISNull(IDC_NO_CREATE_OT_AMOUNT_P.GetCommandParamValue("O_MESSAGE"));
            if (IDC_NO_CREATE_OT_AMOUNT_P.ExcuteError || mSTATUS == "F")
            {
                Application.UseWaitCursor = false;
                this.Cursor = System.Windows.Forms.Cursors.Default;
                Application.DoEvents();

                MessageBoxAdv.Show(mMessage, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return false;
            }


            int mIDX_SELECT_YN = IGR_OT_SUM_TRANS_YET.GetColumnToIndex("SELECT_YN");
            int mIDX_PERSON_ID = IGR_OT_SUM_TRANS_YET.GetColumnToIndex("PERSON_ID");
            mSTATUS = "F";
            mMessage = null;
            for (int vRow = 0; vRow < IGR_OT_SUM_TRANS_YET.RowCount; vRow++)
            {
                if (IGR_OT_SUM_TRANS_YET.GetCellValue(vRow, mIDX_SELECT_YN).ToString() == "Y")
                {
                    IGR_OT_SUM_TRANS_YET.CurrentCellMoveTo(mIDX_SELECT_YN, vRow);
                    IGR_OT_SUM_TRANS_YET.CurrentCellActivate(mIDX_SELECT_YN, vRow);

                    IDC_TRANSFER_SALARY_OT_OK.SetCommandParamValue("W_PERSON_ID", IGR_OT_SUM_TRANS_YET.GetCellValue(vRow, mIDX_PERSON_ID));
                    IDC_TRANSFER_SALARY_OT_OK.SetCommandParamValue("P_SELECT_YN", IGR_OT_SUM_TRANS_YET.GetCellValue(vRow, mIDX_SELECT_YN));
                    IDC_TRANSFER_SALARY_OT_OK.SetCommandParamValue("P_EVENT_STATUS", "C_OK");
                    IDC_TRANSFER_SALARY_OT_OK.ExecuteNonQuery();
                    mSTATUS = iString.ISNull(IDC_TRANSFER_SALARY_OT_OK.GetCommandParamValue("O_STATUS"));
                    mMessage = iString.ISNull(IDC_TRANSFER_SALARY_OT_OK.GetCommandParamValue("O_MESSAGE"));

                    if (IDC_TRANSFER_SALARY_OT_OK.ExcuteError || mSTATUS == "F")
                    {
                        Application.UseWaitCursor = false;
                        this.Cursor = System.Windows.Forms.Cursors.Default;
                        Application.DoEvents();

                        MessageBoxAdv.Show(mMessage, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                        return false;
                    }
                }

            }
            Application.UseWaitCursor = false;
            this.Cursor = System.Windows.Forms.Cursors.Default;
            Application.DoEvents();

            return true;
        }

        private bool SET_OT_TRANS_CANCEL()
        {
            if (W_WORK_CORP_ID.EditValue == null)
            {// 업체.
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10001"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                W_WORK_CORP_DESC.Focus();
                return false;
            }
            if (W_WORK_DATE_FR.EditValue == null)
            {// 근무일자
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10010"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                W_WORK_DATE_FR.Focus();
                return false;
            }
            if (W_WORK_DATE_TO.EditValue == null)
            {// 근무일자
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10011"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                W_WORK_DATE_TO.Focus();
                return false;
            }
            if (iString.ISNull(W_PAY_YYYYMM.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10107"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return false;
            }
            if (iString.ISNull(W_WAGE_TYPE.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10105"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return false;
            }


            if (iString.ISNull(W_TRANSFER_FLAG.EditValue) == string.Empty || iString.ISNull(W_TRANSFER_FLAG.EditValue) != "I")
            {//처리 상태
                MessageBoxAdv.Show("Status [Interface] is not mismatch. Check Button status", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return false;
            }
            
            Application.UseWaitCursor = true;
            this.Cursor = System.Windows.Forms.Cursors.WaitCursor;
            Application.DoEvents();

            int mIDX_SELECT_YN = IGR_OT_SUM_TRANS_OK.GetColumnToIndex("SELECT_YN");
            int mIDX_PERSON_ID = IGR_OT_SUM_TRANS_OK.GetColumnToIndex("PERSON_ID");

            string mSTATUS = "F";
            string mMessage = null;
            for (int vRow = 0; vRow < IGR_OT_SUM_TRANS_OK.RowCount; vRow++)
            {
                if (IGR_OT_SUM_TRANS_OK.GetCellValue(vRow, mIDX_SELECT_YN).ToString() == "Y")
                {
                    IGR_OT_SUM_TRANS_OK.CurrentCellMoveTo(mIDX_SELECT_YN, vRow);
                    IGR_OT_SUM_TRANS_OK.CurrentCellActivate(mIDX_SELECT_YN, vRow);

                    IDC_TRANSFER_SALARY_OT_CANCEL.SetCommandParamValue("W_PERSON_ID", IGR_OT_SUM_TRANS_OK.GetCellValue(vRow, mIDX_PERSON_ID));
                    IDC_TRANSFER_SALARY_OT_CANCEL.SetCommandParamValue("P_SELECT_YN", IGR_OT_SUM_TRANS_OK.GetCellValue(vRow, mIDX_SELECT_YN));
                    IDC_TRANSFER_SALARY_OT_CANCEL.SetCommandParamValue("P_EVENT_STATUS", "I_CANCEL");
                    IDC_TRANSFER_SALARY_OT_CANCEL.ExecuteNonQuery();
                    mSTATUS = iString.ISNull(IDC_TRANSFER_SALARY_OT_CANCEL.GetCommandParamValue("O_STATUS"));
                    mMessage = iString.ISNull(IDC_TRANSFER_SALARY_OT_CANCEL.GetCommandParamValue("O_MESSAGE"));

                    if (IDC_TRANSFER_SALARY_OT_CANCEL.ExcuteError || mSTATUS == "F")
                    {
                        Application.UseWaitCursor = false;
                        this.Cursor = System.Windows.Forms.Cursors.Default;
                        Application.DoEvents();

                        MessageBoxAdv.Show(mMessage, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                        return false;
                    }
                }

            }
            Application.UseWaitCursor = false;
            this.Cursor = System.Windows.Forms.Cursors.Default;
            Application.DoEvents();

            return true;
        }

        private bool Check_Work_Date_time(object pHoly_Type, object IO_Flag, object pWork_Date, object pNew_Work_Date)
        {
            bool mCheck_Value = false;

            if (iString.ISNull(pHoly_Type) == string.Empty)
            {
                return (mCheck_Value);
            }
            if (iString.ISNull(IO_Flag) == string.Empty)
            {
                return (mCheck_Value);
            }
            if (iString.ISNull(pWork_Date) == string.Empty)
            {
                return (mCheck_Value); 
            }
            if (iString.ISNull(pNew_Work_Date) == string.Empty)
            {
                return true;
            }

            if ((pHoly_Type.ToString() == "0".ToString() || pHoly_Type.ToString() == "1".ToString() || pHoly_Type.ToString() == "2".ToString()
                || pHoly_Type.ToString() == "D".ToString() || pHoly_Type.ToString() == "S".ToString())
                && IO_Flag.ToString() == "IN".ToString())
            {// 주간, 무휴, 유휴, DAY, SWING --> 같은 날짜.
                if (Convert.ToDateTime(pWork_Date).Date == Convert.ToDateTime(pNew_Work_Date).Date)
                {
                    mCheck_Value = true;
                }
            }
            else if ((pHoly_Type.ToString() == "3".ToString() || pHoly_Type.ToString() == "N".ToString())
                && IO_Flag.ToString() == "IN".ToString())
            {// 주간, 야간, 무휴, 유휴, DAY, NIGHT --> 같은 날짜.
                if (Convert.ToDateTime(pWork_Date).Date <= Convert.ToDateTime(pNew_Work_Date).Date
                    && Convert.ToDateTime(pNew_Work_Date).Date <= Convert.ToDateTime(pWork_Date).AddDays(1).Date)
                {
                    mCheck_Value = true;
                }
            }
            else if (IO_Flag.ToString() == "OUT".ToString())
            {// 주간, 무휴, 유휴, DAY, SWING --> 같은 날짜.
                mCheck_Value = true;
            }
            else if (IO_Flag.ToString() == "OUT".ToString())
            {// 주간, 야간, 무휴, 유휴, DAY, NIGHT --> 같은 날짜.
                mCheck_Value = true;
            }
         //   else if ((pHoly_Type.ToString() == "0".ToString() || pHoly_Type.ToString() == "1".ToString() || pHoly_Type.ToString() == "2".ToString()
         //|| pHoly_Type.ToString() == "D".ToString() || pHoly_Type.ToString() == "S".ToString())
         //     && IO_Flag.ToString() == "OUT".ToString())
         //   {// 주간, 무휴, 유휴, DAY, SWING --> 같은 날짜.
         //       if (Convert.ToDateTime(pWork_Date).Date <= Convert.ToDateTime(pNew_Work_Date).Date
         //           && Convert.ToDateTime(pNew_Work_Date).Date <= Convert.ToDateTime(pWork_Date).AddDays(1).Date)
         //       {
         //           mCheck_Value = true;
         //       }
         //   }
         //   else if ((pHoly_Type.ToString() == "3".ToString() || pHoly_Type.ToString() == "N".ToString())
         //  && IO_Flag.ToString() == "OUT".ToString())
         //   {// 주간, 야간, 무휴, 유휴, DAY, NIGHT --> 같은 날짜.
         //       if (Convert.ToDateTime(pWork_Date).Date <= Convert.ToDateTime(pNew_Work_Date).Date
         //           && Convert.ToDateTime(pNew_Work_Date).Date <= Convert.ToDateTime(pWork_Date).AddDays(1).Date)
         //       {
         //           mCheck_Value = true;
         //       }
         //   }
            return (mCheck_Value);
        }

        private void Set_Grid_Status(ISGridAdvEx pGRID, int pROW)
        {
            
        }

        private void Insert_OT_LIST()
        {
            int vPreRowPosition = IDA_OT_SUM_TRANS_YET.CurrentRowPosition() -1;

            if (vPreRowPosition > -1 && iString.ISNull(IGR_OT_SUM_TRANS_YET.GetCellValue("WORK_DATE")) == string.Empty)
            {
                IGR_OT_SUM_TRANS_YET.SetCellValue("WORK_DATE", IDA_OT_SUM_TRANS_YET.CurrentRows[vPreRowPosition]["WORK_DATE"]);
            }
            IGR_OT_SUM_TRANS_YET.CurrentCellMoveTo(IGR_OT_SUM_TRANS_YET.GetColumnToIndex("WORK_DATE"));
        }

        #endregion;

        #region ----- isAppInterfaceAdv1_AppMainButtonClick Events -----

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
                    if (IDA_OT_SUM_TRANS_YET.IsFocused)
                    {
                        IDA_OT_SUM_TRANS_YET.Cancel();
                    }
                    else if (IDA_OT_SUM_TRANS_OK.IsFocused)
                    {
                        IDA_OT_SUM_TRANS_OK.Cancel();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {
                    if (IDA_OT_SUM_TRANS_YET.IsFocused)
                    {
                        if (IDA_OT_SUM_TRANS_YET.CurrentRow.RowState == DataRowState.Added)
                        {
                            IDA_OT_SUM_TRANS_YET.Delete();
                        }
                    }
                    else if (IDA_OT_SUM_TRANS_OK.IsFocused)
                    {
                        if (IDA_OT_SUM_TRANS_OK.CurrentRow.RowState == DataRowState.Added)
                        {
                            IDA_OT_SUM_TRANS_OK.Delete();
                        }
                    }
                }
            }
        }
        #endregion;

        #region ----- Form Event -----

        private void HRMF0379_Load(object sender, EventArgs e)
        {
            this.Visible = true;

            W_PERIOD_NAME.EditValue = iDate.ISYearMonth(DateTime.Today);
            W_WORK_DATE_FR.EditValue = iDate.ISMonth_1st(DateTime.Today);
            W_WORK_DATE_TO.EditValue = iDate.ISMonth_Last(DateTime.Today);
            
            // CORP SETTING
            DefaultCorporation();

            IDA_OT_SUM_TRANS_YET.FillSchema();
            IDA_OT_SUM_TRANS_OK.FillSchema();
        }

        private void HRMF0379_Shown(object sender, EventArgs e)
        {
            Set_Transfer_Flag(TB_MAIN.SelectedIndex);
        }
        
        private void TB_MAIN_Click(object sender, EventArgs e)
        {
            Set_Transfer_Flag(TB_MAIN.SelectedIndex);
        }

        private void BTN_SET_OT_AMOUNT_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            if (SET_OT_AMOUNT() == true)
            {
                Search_DB();
            }
        }

        private void BTN_TRANSFER_CANCEL_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            if(SET_OT_TRANS_CANCEL() == true)
            {
                Search_DB();
            }
        }

        private void BTN_TRANSFER_OK_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            if (SET_OT_TRANS_OK() == true)
            {
                Search_DB();
            }
        }

        private void IGR_OT_SUM_TRANS_YET_CurrentCellChanged(object pSender, ISGridAdvExChangedEventArgs e)
        {
            if (IGR_OT_SUM_TRANS_YET.RowIndex < 0)
            {
                return;
            }
            int vIDX_SELECT_YN = IGR_OT_SUM_TRANS_YET.GetColumnToIndex("SELECT_YN");
            if (e.ColIndex == vIDX_SELECT_YN)
            {
                IGR_OT_SUM_TRANS_YET.LastConfirmChanges();
                IDA_OT_SUM_TRANS_YET.OraSelectData.AcceptChanges();
                IDA_OT_SUM_TRANS_YET.Refillable = true;
            }      
        }

        private void IGR_OT_SUM_TRANS_OK_CurrentCellChanged(object pSender, ISGridAdvExChangedEventArgs e)
        {
            if (IGR_OT_SUM_TRANS_OK.RowIndex < 0)
            {
                return;
            }
            int vIDX_SELECT_YN = IGR_OT_SUM_TRANS_OK.GetColumnToIndex("SELECT_YN");
            if (e.ColIndex == vIDX_SELECT_YN)
            {
                IGR_OT_SUM_TRANS_OK.LastConfirmChanges();
                IDA_OT_SUM_TRANS_OK.OraSelectData.AcceptChanges();
                IDA_OT_SUM_TRANS_OK.Refillable = true;
            }      
        }

        private void CB_TRANS_OK_CheckedChange(object pSender, ISCheckEventArgs e)
        {
            if (IGR_OT_SUM_TRANS_YET.RowCount < 1)
            {
                return;
            }

            int vIDX_SELECT_YN = IGR_OT_SUM_TRANS_YET.GetColumnToIndex("SELECT_YN");
            for (int vRow = 0; vRow < IGR_OT_SUM_TRANS_YET.RowCount; vRow++)
            {
                IGR_OT_SUM_TRANS_YET.SetCellValue(vRow, vIDX_SELECT_YN, CB_TRANS_OK.CheckBoxValue);
            }
            IGR_OT_SUM_TRANS_YET.LastConfirmChanges();
            IDA_OT_SUM_TRANS_YET.OraSelectData.AcceptChanges();
            IDA_OT_SUM_TRANS_YET.Refillable = true;
        }

        private void CB_TRANS_CANCEL_CheckedChange(object pSender, ISCheckEventArgs e)
        {
            if (IGR_OT_SUM_TRANS_OK.RowCount < 1)
            {
                return;
            }

            int vIDX_SELECT_YN = IGR_OT_SUM_TRANS_OK.GetColumnToIndex("SELECT_YN");
            for (int vRow = 0; vRow < IGR_OT_SUM_TRANS_OK.RowCount; vRow++)
            {
                IGR_OT_SUM_TRANS_OK.SetCellValue(vRow, vIDX_SELECT_YN, CB_TRANS_CANCEL.CheckBoxValue);
            }
            IGR_OT_SUM_TRANS_OK.LastConfirmChanges();
            IDA_OT_SUM_TRANS_OK.OraSelectData.AcceptChanges();
            IDA_OT_SUM_TRANS_OK.Refillable = true;
        }

        #endregion  

        #region ----- Adapter Event -----
       
        #endregion

        #region ----- LookUp Event -----
        
        private void ilaCORP_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCORP.SetLookupParamValue("W_DUTY_CONTROL_YN", "Y");
        }

        private void ilaDEPT_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildDEPT_0.SetLookupParamValue("W_USABLE_CHECK_YN", "N");
        }

        private void ILA_W_OT_TYPE_STATUS_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", "OT_TYPE_STATUS");
            ildCOMMON.SetLookupParamValue("W_ENABLED_FLAG_YN", "N");
        }

        private void ilaFLOOR_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", "FLOOR");
            ildCOMMON.SetLookupParamValue("W_ENABLED_FLAG_YN", "N");
        }

        private void ILA_W_WAGE_TYPE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ILD_COMMON_W.SetLookupParamValue("W_GROUP_CODE", "CLOSING_TYPE");
            ILD_COMMON_W.SetLookupParamValue("W_WHERE", " VALUE1 = 'PAY' ");
            ILD_COMMON_W.SetLookupParamValue("W_ENABLED_FLAG_YN", "Y");
        }

        private void ILA_W_YYYYMM_SelectedRowData(object pSender)
        {
            W_PAY_YYYYMM.EditValue = W_PERIOD_NAME.EditValue;
        }

        #endregion

        #region ----- Edit Event -----

        private void W_WORK_DATE_FR_EditValueChanged(object pSender)
        {            
            W_WORK_DATE_TO.EditValue = W_WORK_DATE_FR.EditValue; ;
        }

        #endregion


    }
}