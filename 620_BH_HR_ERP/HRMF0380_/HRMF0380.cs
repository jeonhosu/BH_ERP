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

namespace HRMF0380
{
    public partial class HRMF0380 : Office2007Form
    {
        #region ----- Variables -----

        private ISFunction.ISConvert iString = new ISFunction.ISConvert();
        private ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        //private ISCommonUtil.ISFunction.ISDateTime mGetDate = new ISCommonUtil.ISFunction.ISDateTime();

        #endregion;

        #region ----- Constructor -----

        public HRMF0380(Form pMainForm, ISAppInterface pAppInterface)
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

        private void Set_Visible_GB(int pTab_Index)
        {
            if (pTab_Index == 0)
            {
                GB_APPROVAL.Visible = false;
                GB_ERROR.Visible = true;
            }
            else if(pTab_Index == 1)
            {
                GB_ERROR.Visible = false;
                GB_APPROVAL.Visible = true;      
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
                IDA_OT_LIST_ERROR.Fill();
                IGR_OT_LIST_ERROR.Focus();
            }
            else if (TB_MAIN.SelectedIndex == 1)
            {
                IDA_OT_LIST.Fill();
                IGR_OT_LIST.Focus();
            }
        }

        private bool SET_OT_LIST_APPROVAL(string pBTN_STATUS)
        {
            if (pBTN_STATUS == string.Empty)
            {//처리 상태
                MessageBoxAdv.Show("Approval Status is not found. Check Button status", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return false;
            }
            if (pBTN_STATUS == "A_OK" || pBTN_STATUS == "A_CANCEL")
            {// 처리 상태
                MessageBoxAdv.Show("Approval Status is All Search. Check Button status", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return false;
            }
            if (pBTN_STATUS == "I_OK" || pBTN_STATUS == "I_CANCEL")
            {// 처리 상태
                MessageBoxAdv.Show("Approval Status is Salary Interface. Check Button status", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return false;
            }
            
            Application.UseWaitCursor = true;
            this.Cursor = System.Windows.Forms.Cursors.WaitCursor;
            Application.DoEvents();

            int mIDX_SELECT_YN = IGR_OT_LIST.GetColumnToIndex("SELECT_YN");
            int mIDX_WORK_DATE = IGR_OT_LIST.GetColumnToIndex("WORK_DATE");
            int mIDX_PERSON_ID = IGR_OT_LIST.GetColumnToIndex("PERSON_ID");
            int mIDX_STATUS_FLAG =  IGR_OT_LIST.GetColumnToIndex("STATUS_FLAG");
            int mIDX_REJECT_DESC= IGR_OT_LIST.GetColumnToIndex("REJECT_DESC");

            string mSTATUS = "F";
            string mMessage = null;
            for (int vRow = 0; vRow < IGR_OT_LIST.RowCount; vRow++)
            {
                if (IGR_OT_LIST.GetCellValue(vRow, mIDX_SELECT_YN).ToString() == "Y")
                {
                    IGR_OT_LIST.CurrentCellMoveTo(mIDX_SELECT_YN, vRow);
                    IGR_OT_LIST.CurrentCellActivate(mIDX_SELECT_YN, vRow);

                    IDC_OT_LIST_APPROVAL.SetCommandParamValue("W_WORK_DATE", IGR_OT_LIST.GetCellValue(vRow, mIDX_WORK_DATE));
                    IDC_OT_LIST_APPROVAL.SetCommandParamValue("W_PERSON_ID", IGR_OT_LIST.GetCellValue(vRow, mIDX_PERSON_ID));
                    IDC_OT_LIST_APPROVAL.SetCommandParamValue("P_SELECT_YN", IGR_OT_LIST.GetCellValue(vRow, mIDX_SELECT_YN));
                    IDC_OT_LIST_APPROVAL.SetCommandParamValue("P_STATUS_FLAG", IGR_OT_LIST.GetCellValue(vRow, mIDX_STATUS_FLAG));
                    IDC_OT_LIST_APPROVAL.SetCommandParamValue("P_EVENT_STATUS", pBTN_STATUS);
                    IDC_OT_LIST_APPROVAL.SetCommandParamValue("P_REJECT_DESC", IGR_OT_LIST.GetCellValue(vRow, mIDX_REJECT_DESC));
                    IDC_OT_LIST_APPROVAL.ExecuteNonQuery();
                    mSTATUS = iString.ISNull(IDC_OT_LIST_APPROVAL.GetCommandParamValue("O_STATUS"));
                    mMessage = iString.ISNull(IDC_OT_LIST_APPROVAL.GetCommandParamValue("O_MESSAGE"));                 

                    if (IDC_OT_LIST_APPROVAL.ExcuteError || mSTATUS == "F")
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

        private void Set_Grid_Status(int pROW)
        {
            int mCell_Status = 1;
            int mIDX_PERSION_ID = IGR_OT_LIST.GetColumnToIndex("PERSON_ID");
            int mIDX_DUTY_NAME = IGR_OT_LIST.GetColumnToIndex("DUTY_NAME");
            int mIDX_START = IGR_OT_LIST.GetColumnToIndex("OPEN_TIME");
            int mIDX_END = IGR_OT_LIST.GetColumnToIndex("NIGHT_BONUS_TIME");
            if (iString.ISNumtoZero(IGR_OT_LIST.GetCellValue(pROW, mIDX_PERSION_ID)) == -10)
            {
                mCell_Status = 0;
            }
            else
            {
                mCell_Status = 1;
            }
            IGR_OT_LIST.GridAdvExColElement[mIDX_DUTY_NAME].Insertable = mCell_Status;
            IGR_OT_LIST.GridAdvExColElement[mIDX_DUTY_NAME].Updatable = mCell_Status;
            for (int c = mIDX_START; c <= mIDX_END; c++)
            {
                IGR_OT_LIST.GridAdvExColElement[c].Insertable = mCell_Status;
                IGR_OT_LIST.GridAdvExColElement[c].Updatable = mCell_Status;
            }
        }

        private void Insert_OT_LIST()
        {
            int vPreRowPosition = IDA_OT_LIST_ERROR.CurrentRowPosition() -1;

            if (vPreRowPosition > -1 && iString.ISNull(IGR_OT_LIST_ERROR.GetCellValue("WORK_DATE")) == string.Empty)
            {
                IGR_OT_LIST_ERROR.SetCellValue("WORK_DATE", IDA_OT_LIST_ERROR.CurrentRows[vPreRowPosition]["WORK_DATE"]);
            }
            IGR_OT_LIST_ERROR.CurrentCellMoveTo(IGR_OT_LIST_ERROR.GetColumnToIndex("WORK_DATE"));
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
                    if (IDA_OT_LIST_ERROR.IsFocused)
                    {
                        IDA_OT_LIST_ERROR.AddOver();
                        Insert_OT_LIST();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddUnder)
                {
                    if (IDA_OT_LIST_ERROR.IsFocused)
                    {
                        IDA_OT_LIST_ERROR.AddUnder();
                        Insert_OT_LIST();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Update)
                {
                    if (IDA_OT_LIST_ERROR.IsFocused)
                    {
                        IDA_OT_LIST_ERROR.Update();
                    }
                    else if (IDA_OT_LIST.IsFocused)
                    {
                        IDA_OT_LIST.Update();                        
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Cancel)
                {
                    if (IDA_OT_LIST_ERROR.IsFocused)
                    {
                        IDA_OT_LIST_ERROR.Cancel();
                    }
                    else if (IDA_OT_LIST.IsFocused)
                    {
                        IDA_OT_LIST.Cancel();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {
                    if (IDA_OT_LIST_ERROR.IsFocused)
                    {
                        IDA_OT_LIST_ERROR.Delete();
                    }
                    else if (IDA_OT_LIST.IsFocused)
                    {

                    }
                }
            }
        }
        #endregion;

        #region ----- Form Event -----

        private void HRMF0380_Load(object sender, EventArgs e)
        {
            this.Visible = true;
                        
            W_WORK_DATE_FR.EditValue = DateTime.Today;
            W_WORK_DATE_TO.EditValue = DateTime.Today;
            
            // CORP SETTING
            DefaultCorporation();

            idcDEFAULT_VALUE.SetCommandParamValue("W_GROUP_CODE", "OT_TYPE_STATUS");
            idcDEFAULT_VALUE.ExecuteNonQuery();
            W_STATUS_FLAG_DESC.EditValue = idcDEFAULT_VALUE.GetCommandParamValue("O_CODE_NAME");
            W_STATUS_FLAG.EditValue = idcDEFAULT_VALUE.GetCommandParamValue("O_CODE");

            IDA_OT_LIST_ERROR.FillSchema();
            IDA_OT_LIST.FillSchema();
        }

        private void HRMF0380_Shown(object sender, EventArgs e)
        {
            Set_Visible_GB(TB_MAIN.SelectedIndex);
        }

        private void IGR_OT_LIST_CurrentCellChanged(object pSender, ISGridAdvExChangedEventArgs e)
        {
            if (IGR_OT_LIST.RowIndex < 0)
            {
                return;
            }
            int vIDX_SELECT_YN = IGR_OT_LIST.GetColumnToIndex("SELECT_YN");
            if(e.ColIndex == vIDX_SELECT_YN)
            {
                IGR_OT_LIST.LastConfirmChanges();
                IDA_OT_LIST.OraSelectData.AcceptChanges();
                IDA_OT_LIST.Refillable = true;
            }            
        }

        
        private void TB_MAIN_Click(object sender, EventArgs e)
        {
            Set_Visible_GB(TB_MAIN.SelectedIndex);
        }


        private void CB_SELECT_YN_CheckedChange(object pSender, ISCheckEventArgs e)
        {
            if (IGR_OT_LIST.RowCount < 1)
            {
                return;
            }

            int vIDX_SELECT_YN = IGR_OT_LIST.GetColumnToIndex("SELECT_YN");
            for (int vRow = 0; vRow < IGR_OT_LIST.RowCount; vRow++)
            {
                IGR_OT_LIST.SetCellValue(vRow, vIDX_SELECT_YN, CB_SELECT_YN.CheckBoxValue);
            }
            IGR_OT_LIST.LastConfirmChanges();
            IDA_OT_LIST.OraSelectData.AcceptChanges();
            IDA_OT_LIST.Refillable = true;
        }

        private void BTN_CONFIRM_OK_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            if (SET_OT_LIST_APPROVAL("C_OK") == true)
            {
                // refill.
                Search_DB();
            }
        }

        private void BTN_CONFIRM_CANCEL_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            if (SET_OT_LIST_APPROVAL("C_CANCEL") == true)
            {
                // refill.
                Search_DB();
            }
        }

        private void BTN_REJECT_OK_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            if (SET_OT_LIST_APPROVAL("R_OK") == true)
            {
                // refill.
                Search_DB();
            }
        }

        private void BTN_REJECT_CANCEL_ButtonClick(object pSender, EventArgs pEventArgs)
        {
           if (SET_OT_LIST_APPROVAL("R_CANCEL") == true)
            {
                // refill.
                Search_DB();
            }
        }


        private void ibtSET_OT_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            
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

        private void ILA_W_OT_TYPE_STATUS_SelectedRowData(object pSender)
        {
            if (iString.ISNull(W_STATUS_FLAG.EditValue) == "A" || iString.ISNull(W_STATUS_FLAG.EditValue) == "I")
            {
                BTN_CONFIRM_OK.Enabled = false;
                BTN_CONFIRM_CANCEL.Enabled = false;
                BTN_REJECT_OK.Enabled = false;
                BTN_REJECT_CANCEL.Enabled = false;
            }
            else
            {
                BTN_CONFIRM_OK.Enabled = true;
                BTN_CONFIRM_CANCEL.Enabled = true;
                BTN_REJECT_OK.Enabled = true;
                BTN_REJECT_CANCEL.Enabled = true;
            }
        }

        private void ILA_OT_TYPE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ILD_OT_TYPE.SetLookupParamValue("W_ENABLED_FLAG", "Y");
        }

        private void ILA_OT_PERSON_SelectedRowData(object pSender)
        {
            try
            {
                IDC_REAL_OT_TIME_P.ExecuteNonQuery();
                object vREAL_OT_TIME = IDC_REAL_OT_TIME_P.GetCommandParamValue("O_REAL_OT_TIME");
                if (IDC_REAL_OT_TIME_P.ExcuteError)
                {
                    return;
                }
                IGR_OT_LIST_ERROR.SetCellValue("REAL_OT_TIME", vREAL_OT_TIME);
            }
            catch
            {

            }
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