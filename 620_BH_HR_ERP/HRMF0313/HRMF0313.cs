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

namespace HRMF0313
{
    public partial class HRMF0313 : Office2007Form
    {
        #region ----- Variables -----

        private ISFunction.ISConvert iString = new ISFunction.ISConvert();
        private ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        //private ISCommonUtil.ISFunction.ISDateTime mGetDate = new ISCommonUtil.ISFunction.ISDateTime();

        #endregion;

        #region ----- Constructor -----

        public HRMF0313(Form pMainForm, ISAppInterface pAppInterface)
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
            CORP_NAME_0.EditValue = idcDEFAULT_CORP.GetCommandParamValue("O_CORP_NAME");
            CORP_ID_0.EditValue = idcDEFAULT_CORP.GetCommandParamValue("O_CORP_ID");
        }

        private void Search_DB()
        {
            if (CORP_ID_0.EditValue == null)
            {// 업체.
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10001"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                CORP_NAME_0.Focus();
                return;
            }
            if (START_DATE_0.EditValue == null)
            {// 근무일자
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10010"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                START_DATE_0.Focus();
                return;
            }
                        
            idaDAY_LEAVE.Fill();
            igrDAY_LEAVE.Focus();
        }

        private void isSearch_WorkCalendar(Object pPerson_ID, Object pWork_Date)
        {            
            if (iString.ISNull(pWork_Date) == string.Empty)
            {
                return;
            }
            WORK_DATE_8.EditValue = pWork_Date;

            idaWORK_CALENDAR.SetSelectParamValue("W_START_DATE", pWork_Date);
            idaWORK_CALENDAR.SetSelectParamValue("W_END_DATE", pWork_Date);
            idaWORK_CALENDAR.Fill();
            idaDAY_HISTORY.Fill();
            idaDUTY_PERIOD.Fill();            
        }

        private void isSearch_Day_History(int pAdd_Day)
        {
            if (iString.ISNull(WORK_DATE_8.EditValue) == string.Empty)
            {
                return;
            }
            WORK_DATE_8.EditValue = Convert.ToDateTime(WORK_DATE_8.EditValue).AddDays(pAdd_Day);
            idaDAY_HISTORY.Fill();
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
            int mIDX_PERSION_ID = igrDAY_LEAVE.GetColumnToIndex("PERSON_ID");
            int mIDX_DUTY_NAME = igrDAY_LEAVE.GetColumnToIndex("DUTY_NAME");
            int mIDX_START = igrDAY_LEAVE.GetColumnToIndex("OPEN_TIME");
            int mIDX_END = igrDAY_LEAVE.GetColumnToIndex("NIGHT_BONUS_TIME");
            if (iString.ISNumtoZero(igrDAY_LEAVE.GetCellValue(pROW, mIDX_PERSION_ID)) == -10)
            {
                mCell_Status = 0;
            }
            else
            {
                mCell_Status = 1;
            }
            igrDAY_LEAVE.GridAdvExColElement[mIDX_DUTY_NAME].Insertable = mCell_Status;
            igrDAY_LEAVE.GridAdvExColElement[mIDX_DUTY_NAME].Updatable = mCell_Status;
            for (int c = mIDX_START; c <= mIDX_END; c++)
            {
                igrDAY_LEAVE.GridAdvExColElement[c].Insertable = mCell_Status;
                igrDAY_LEAVE.GridAdvExColElement[c].Updatable = mCell_Status;
            }
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
                    if (idaDAY_LEAVE.IsFocused)
                    {
                        idaDAY_LEAVE.Update();                        
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Cancel)
                {
                    if (idaDAY_LEAVE.IsFocused)
                    {
                        idaDAY_LEAVE.Cancel();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {
                    if (idaDAY_LEAVE.IsFocused)
                    {
                        idaDAY_LEAVE.Delete();
                    }
                }
            }
        }
        #endregion;

        #region ----- Form Event -----

        private void HRMF0313_Load(object sender, EventArgs e)
        {
            this.Visible = true;

            idaDAY_LEAVE.FillSchema();
            START_DATE_0.EditValue = DateTime.Today;
            END_DATE_0.EditValue = DateTime.Today;
            
            // CORP SETTING
            DefaultCorporation();

            // LEAVE CLOSE TYPE SETTING
            ildLEAVE_CLOSE_TYPE_0.SetLookupParamValue("W_GROUP_CODE", "LEAVE_CLOSE_TYPE");
            ildLEAVE_CLOSE_TYPE_0.SetLookupParamValue("W_ENABLED_FLAG_YN", "Y");

            idcDEFAULT_VALUE.SetCommandParamValue("W_GROUP_CODE", "LEAVE_CLOSE_TYPE");
            idcDEFAULT_VALUE.ExecuteNonQuery();
            LEAVE_CLOSE_TYPE_NAME_0.EditValue = idcDEFAULT_VALUE.GetCommandParamValue("O_CODE_NAME").ToString();
            LEAVE_CLOSE_TYPE_0.EditValue = idcDEFAULT_VALUE.GetCommandParamValue("O_CODE").ToString();

            //DefaultSetFormReSize();             //[Child Form, Mdi Form에 맞게 ReSize]
        }

        private void ibtLEAVE_DATETIME_UPDATE_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            if (CORP_ID_0.EditValue == null)
            {// 업체.
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10001"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                CORP_NAME_0.Focus();
                return;
            }
            if (START_DATE_0.EditValue == null)
            {// 근무 시작일자
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10010"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                START_DATE_0.Focus();
                return;
            }
            if (END_DATE_0.EditValue == null)
            {// 근무 종료일자
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10011"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                START_DATE_0.Focus();
                return;
            }

            Application.UseWaitCursor = true;
            this.Cursor = System.Windows.Forms.Cursors.WaitCursor;
            Application.DoEvents();

            string mSTATUS = "F";
            string mMessage = null;
            isDataTransaction1.BeginTran();
            idcLEAVE_DATETIME_UPDATE.ExecuteNonQuery();
            mSTATUS = idcLEAVE_DATETIME_UPDATE.GetCommandParamValue("O_STATUS").ToString();
            mMessage = idcLEAVE_DATETIME_UPDATE.GetCommandParamValue("O_MESSAGE").ToString();
            Application.UseWaitCursor = false;
            this.Cursor = System.Windows.Forms.Cursors.Default;
            Application.DoEvents();

            if (idcLEAVE_DATETIME_UPDATE.ExcuteError || mSTATUS == "F")
            {
                isDataTransaction1.RollBack();
                MessageBoxAdv.Show(mMessage, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }

            isDataTransaction1.Commit();
            MessageBoxAdv.Show(mMessage, "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);

            // refill.
            Search_DB();
        }
        
        private void ibtSET_OT_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            if (CORP_ID_0.EditValue == null)
            {// 업체.
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10001"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                CORP_NAME_0.Focus();
                return;
            }
            if (START_DATE_0.EditValue == null)
            {// 근무 시작일자
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10010"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                START_DATE_0.Focus();
                return;
            }
            if (END_DATE_0.EditValue == null)
            {// 근무 종료일자
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10011"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                START_DATE_0.Focus();
                return;
            }

            Application.UseWaitCursor = true;
            this.Cursor = System.Windows.Forms.Cursors.WaitCursor;
            Application.DoEvents();

            string mSTATUS = "F";
            string mMessage = null;
            isDataTransaction1.BeginTran();
            idcSET_OT.ExecuteNonQuery();
            mSTATUS = idcSET_OT.GetCommandParamValue("O_STATUS").ToString();
            mMessage = idcSET_OT.GetCommandParamValue("O_MESSAGE").ToString();
            Application.UseWaitCursor = false;
            this.Cursor = System.Windows.Forms.Cursors.Default;
            Application.DoEvents();

            if (idcSET_OT.ExcuteError || mSTATUS == "F")
            {
                isDataTransaction1.RollBack();
                MessageBoxAdv.Show(mMessage, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }

            isDataTransaction1.Commit();
            MessageBoxAdv.Show(mMessage, "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);

            // refill.
            Search_DB();
        }

        private void ibtCLOSE_OK_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            if (CORP_ID_0.EditValue == null)
            {// 업체.
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10001"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                CORP_NAME_0.Focus();
                return;
            }
            if (START_DATE_0.EditValue == null)
            {// 근무 시작일자
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10010"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                START_DATE_0.Focus();
                return;
            }
            if (END_DATE_0.EditValue == null)
            {// 근무 종료일자
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10011"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                START_DATE_0.Focus();
                return;
            }

            Application.UseWaitCursor = true;
            this.Cursor = System.Windows.Forms.Cursors.WaitCursor;
            Application.DoEvents();

            string mSTATUS = "F";
            string mMessage = null;
            isDataTransaction1.BeginTran();

            idcDATA_CLOSE_PROC.ExecuteNonQuery();
            mSTATUS = idcDATA_CLOSE_PROC.GetCommandParamValue("O_STATUS").ToString();
            mMessage = idcDATA_CLOSE_PROC.GetCommandParamValue("O_MESSAGE").ToString();
            Application.UseWaitCursor = false;
            this.Cursor = System.Windows.Forms.Cursors.Default;
            Application.DoEvents();

            if (idcSET_OT.ExcuteError || mSTATUS == "F")
            {
                isDataTransaction1.RollBack();
                MessageBoxAdv.Show(mMessage, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }
            isDataTransaction1.Commit();
            MessageBoxAdv.Show(mMessage, "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);

            // refill.
            Search_DB();
        }

        private void ibtCLOSE_CANCEL_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            if (CORP_ID_0.EditValue == null)
            {// 업체.
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10001"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                CORP_NAME_0.Focus();
                return;
            }
            if (START_DATE_0.EditValue == null)
            {// 근무 시작일자
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10010"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                START_DATE_0.Focus();
                return;
            }
            if (END_DATE_0.EditValue == null)
            {// 근무 종료일자
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10011"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                START_DATE_0.Focus();
                return;
            }

            Application.UseWaitCursor = true;
            this.Cursor = System.Windows.Forms.Cursors.WaitCursor;
            Application.DoEvents();

            string mSTATUS = "F";
            string mMessage = null;
            isDataTransaction1.BeginTran();

            idcDATA_CLOSE_CANCEL.ExecuteNonQuery();
            mSTATUS = idcDATA_CLOSE_CANCEL.GetCommandParamValue("O_STATUS").ToString();
            mMessage = idcDATA_CLOSE_CANCEL.GetCommandParamValue("O_MESSAGE").ToString();
            Application.UseWaitCursor = false;
            this.Cursor = System.Windows.Forms.Cursors.Default;
            Application.DoEvents();

            if (idcSET_OT.ExcuteError || mSTATUS == "F")
            {
                isDataTransaction1.RollBack();
                MessageBoxAdv.Show(mMessage, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }
            isDataTransaction1.Commit();
            MessageBoxAdv.Show(mMessage, "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);

            // refill.
            Search_DB();
        }    

        private void ibtnUP_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            isSearch_Day_History(1);
        }

        private void ibtnDOWN_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            isSearch_Day_History(-1);
        }

        private void igrDAY_LEAVE_CurrentCellValidating(object pSender, ISGridAdvExValidatingEventArgs e)
        {            
            if (e.ColIndex == igrDAY_LEAVE.GetColumnToIndex("OPEN_TIME") || e.ColIndex == igrDAY_LEAVE.GetColumnToIndex("OPEN_TIME1")
                || e.ColIndex == igrDAY_LEAVE.GetColumnToIndex("CLOSE_TIME") || e.ColIndex == igrDAY_LEAVE.GetColumnToIndex("CLOSE_TIME1"))
            {
                object mHoly_Type = igrDAY_LEAVE.GetCellValue("HOLY_TYPE");
                object mWork_Date = igrDAY_LEAVE.GetCellValue("WORK_DATE");
                object mWork_DateTime = e.NewValue;
                object mIO_Flag = "-";
                if (e.ColIndex == igrDAY_LEAVE.GetColumnToIndex("OPEN_TIME") || e.ColIndex == igrDAY_LEAVE.GetColumnToIndex("OPEN_TIME1"))
                {
                    mIO_Flag = "IN";
                }
                else if (e.ColIndex == igrDAY_LEAVE.GetColumnToIndex("CLOSE_TIME") || e.ColIndex == igrDAY_LEAVE.GetColumnToIndex("CLOSE_TIME1"))
                {
                    mIO_Flag = "OUT";
                }
                if (Check_Work_Date_time(mHoly_Type, mIO_Flag, mWork_Date, mWork_DateTime) == false)
                {
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10151"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    return;
                }
            }
        }

        private void igrDAY_LEAVE_CellDoubleClick(object pSender)
        {
            string vCOL_NAME = null;
            if (igrDAY_LEAVE.GetColumnToIndex("OPEN_TIME") == igrDAY_LEAVE.ColIndex)
            {
                vCOL_NAME = "OPEN_TIME";
            }
            else if (igrDAY_LEAVE.GetColumnToIndex("CLOSE_TIME") == igrDAY_LEAVE.ColIndex)
            {
                vCOL_NAME = "CLOSE_TIME";
            }

            if (igrDAY_LEAVE.GetColumnToIndex(vCOL_NAME) == igrDAY_LEAVE.ColIndex)
            {
                if (iString.ISNull(igrDAY_LEAVE.GetCellValue(vCOL_NAME)) == string.Empty)
                {
                    idcWORK_IO_TIME.SetCommandParamValue("W_WORK_TYPE", igrDAY_LEAVE.GetCellValue("WORK_TYPE_GROUP"));
                    idcWORK_IO_TIME.SetCommandParamValue("W_HOLY_TYPE", igrDAY_LEAVE.GetCellValue("HOLY_TYPE"));
                    idcWORK_IO_TIME.SetCommandParamValue("W_WORK_DATE", igrDAY_LEAVE.GetCellValue("WORK_DATE"));
                    idcWORK_IO_TIME.ExecuteNonQuery();
                    if (vCOL_NAME == "OPEN_TIME")
                    {//출근
                        igrDAY_LEAVE.SetCellValue(vCOL_NAME, idcWORK_IO_TIME.GetCommandParamValue("O_OPEN_TIME"));
                    }
                    else if (vCOL_NAME == "CLOSE_TIME")
                    {//퇴근
                        igrDAY_LEAVE.SetCellValue(vCOL_NAME, idcWORK_IO_TIME.GetCommandParamValue("O_CLOSE_TIME"));
                    }
                }
            }
        }

        #endregion  

        #region ----- Adapter Event -----

        private void idaDAY_LEAVE_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {
            if (e.Row["PERSON_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Person Info(사원 정보)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["WORK_DATE"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Work Date(근무일자)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["CORP_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Corporate Name(업체)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["DUTY_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Duty Name(근태)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["HOLY_TYPE"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Holy type(근무)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (Check_Work_Date_time(e.Row["HOLY_TYPE"], "IN", e.Row["WORK_DATE"], e.Row["OPEN_TIME"]) == false)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10151"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (Check_Work_Date_time(e.Row["HOLY_TYPE"], "IN", e.Row["WORK_DATE"], e.Row["OPEN_TIME1"]) == false)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10151"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (Check_Work_Date_time(e.Row["HOLY_TYPE"], "OUT", e.Row["WORK_DATE"], e.Row["CLOSE_TIME"]) == false)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10151"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (Check_Work_Date_time(e.Row["HOLY_TYPE"], "OUT", e.Row["WORK_DATE"], e.Row["CLOSE_TIME1"]) == false)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10151"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
        }

        private void idaDAY_LEAVE_PreNewRowMoved(object pSender, ISBindingEventArgs pBindingManager)
        {
            if (pBindingManager.RowPosition > -1)
            {
                Set_Grid_Status(pBindingManager.RowPosition);
            }
        }
       
        private void idaDAY_LEAVE_NewRowMoved(object pSender, ISBindingEventArgs pBindingManager)
        {
            isSearch_WorkCalendar(igrDAY_LEAVE.GetCellValue("PERSON_ID"), igrDAY_LEAVE.GetCellValue("WORK_DATE"));
        }

        #endregion

        #region ----- LookUp Event -----
        private void ilaDEPT_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildDEPT_0.SetLookupParamValue("W_USABLE_CHECK_YN", "N");
        }

        private void ildHOLY_TYPE_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", "HOLY_TYPE");
            ildCOMMON.SetLookupParamValue("W_ENABLED_FLAG_YN", "N");
        }

        private void ilaWORK_TYPE_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", "WORK_TYPE");
            ildCOMMON.SetLookupParamValue("W_ENABLED_FLAG_YN", "N");
        }

        private void ilaFLOOR_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", "FLOOR");
            ildCOMMON.SetLookupParamValue("W_ENABLED_FLAG_YN", "N");
        }

        private void ilaDUTY_MODIFY_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", "DUTY");
            ildCOMMON.SetLookupParamValue("W_ENABLED_FLAG_YN", "Y");
        }

        private void ilaJOB_CATEGORY_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", "JOB_CATEGORY");
            ildCOMMON.SetLookupParamValue("W_ENABLED_FLAG_YN", "Y");
        }

        private void ilaDUTY_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", "DUTY");
            ildCOMMON.SetLookupParamValue("W_ENABLED_FLAG_YN", "Y");
        }

        private void ilaFLOOR_0_PrePopupShow_1(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildFLOOR_0.SetLookupParamValue("W_GROUP_CODE", "FLOOR");
            ildFLOOR_0.SetLookupParamValue("W_ENABLED_FLAG_YN", "N");
        }

        #endregion

        #region ----- Edit Event -----

        private void START_DATE_0_EditValueChanged(object pSender)
        {
            //System.DateTime vDate = START_DATE_0.DateTimeValue;
            //END_DATE_0.EditValue = mGetDate.ISMonth_Last(vDate);
            END_DATE_0.EditValue = START_DATE_0.EditValue; ;
        }

        #endregion
    }
}