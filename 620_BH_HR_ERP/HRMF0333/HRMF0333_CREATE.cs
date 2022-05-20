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

namespace HRMF0333
{
    public partial class HRMF0333_CREATE : Office2007Form
    {
        ISFunction.ISConvert iConv = new ISFunction.ISConvert();
        ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        public HRMF0333_CREATE(Form pMainForm, ISAppInterface pAppInterface, object pCorp_ID, object pWork_YYYYMM)
        {
            InitializeComponent();
            isAppInterfaceAdv1.AppInterface = pAppInterface;

            CORP_ID.EditValue = pCorp_ID;
            WORK_YYYYMM.EditValue = pWork_YYYYMM;
        }

        #region ----- Private / Method ----- 

        private void Search_DB(object pCreated_Method)
        {
            idaCALENDAR_SET.Cancel();
            if (iConv.ISNull(WORK_YYYYMM.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10375"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                WORK_YYYYMM.Focus();
                return;
            }
            if (WORK_TYPE_ID.EditValue == null)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Work Type(교대 유형)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                WORK_TYPE.Focus();
                return;
            }
            if (iConv.ISNull(pCreated_Method) == string.Empty)
            {
                pCreated_Method = "A";
            }

            // 기적용일수 조회.
            IDC_PRE_WORK_DAY_P.SetCommandParamValue("W_CREATED_METHOD", pCreated_Method);
            IDC_PRE_WORK_DAY_P.ExecuteNonQuery();
            PRE_WORK_DAY.EditValue = IDC_PRE_WORK_DAY_P.GetCommandParamValue("O_DAY_COUNT");

            idaCALENDAR_SET.SetSelectParamValue("W_CREATED_METHOD", pCreated_Method);
            idaCALENDAR_SET.Fill();
            igrCALENDAR_SET.Focus();

            int mRecordCount = idaCALENDAR_SET.SelectRows.Count;
            if (mRecordCount == 0)
            {
                Init_Work_Plan_STD();
            }
            SEARCH_DB_DETAIL();
            WORK_TYPE.Focus();
        }
    

        private void SEARCH_DB_DETAIL()
        {
            IDA_CALENDAR_DETAIL_1.Cancel();
            IDA_CALENDAR_DETAIL_2.Cancel();

            IDA_CALENDAR_DETAIL_1.Fill();
            IDA_CALENDAR_DETAIL_2.Fill(); 
        }

        private void isSetCommonLookUpParameter(string P_GROUP_CODE, String P_USABLE_YN)
        {
            ILD_COMMON.SetLookupParamValue("W_GROUP_CODE", P_GROUP_CODE);
            ILD_COMMON.SetLookupParamValue("W_ENABLED_FLAG_YN", P_USABLE_YN);
        }

        #endregion

        #region ----- Initialize -----

        private void Insert_Before_Apply_Day()
        {
        }

        private bool Insert_Holy_Type()
        { 
            if (WORK_TYPE_ID.EditValue == null)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Work Type(교대 유형)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                WORK_TYPE.Focus();
                return false;
            }

            return true;
        }                
        
        private void Init_Cell_Status()
        {
            if (iConv.ISNumtoZero(igrCALENDAR_SET.GetCellValue("HOLY_TYPE")) == Convert.ToInt32(-1))
            {
                igrCALENDAR_SET.GridAdvExColElement[igrCALENDAR_SET.GetColumnToIndex("HOLY_TYPE")].Insertable = 0;
                igrCALENDAR_SET.GridAdvExColElement[igrCALENDAR_SET.GetColumnToIndex("HOLY_TYPE")].Updatable = 0;
                igrCALENDAR_SET.GridAdvExColElement[igrCALENDAR_SET.GetColumnToIndex("HOLY_TYPE_NAME")].Insertable = 0;
                igrCALENDAR_SET.GridAdvExColElement[igrCALENDAR_SET.GetColumnToIndex("HOLY_TYPE_NAME")].Updatable = 0;

                igrCALENDAR_SET.CurrentCellMoveTo(3);
            }
            else
            {
                igrCALENDAR_SET.GridAdvExColElement[igrCALENDAR_SET.GetColumnToIndex("HOLY_TYPE")].Insertable = 1;
                igrCALENDAR_SET.GridAdvExColElement[igrCALENDAR_SET.GetColumnToIndex("HOLY_TYPE")].Updatable = 1;
                igrCALENDAR_SET.GridAdvExColElement[igrCALENDAR_SET.GetColumnToIndex("HOLY_TYPE_NAME")].Insertable = 1;
                igrCALENDAR_SET.GridAdvExColElement[igrCALENDAR_SET.GetColumnToIndex("HOLY_TYPE_NAME")].Updatable = 1;

                igrCALENDAR_SET.CurrentCellMoveTo(1);
            }
        }

        private void Init_Work_Plan()
        {
            //기존 자료 삭제.
            igrCALENDAR_SET.BeginUpdate();
            idaCALENDAR_SET.OraSelectData.AcceptChanges();
            for (int i = 0; i < idaCALENDAR_SET.SelectRows.Count; i++)
            {
                idaCALENDAR_SET.OraSelectData.Rows[i].SetAdded();
            }
            idaCALENDAR_SET.Refillable = false;
            igrCALENDAR_SET.EndUpdate();
            
            igrCALENDAR_SET.CurrentCellMoveTo(0, 0);
            igrCALENDAR_SET.CurrentCellActivate(0, 0);
            igrCALENDAR_SET.Focus();
        }

        private void Init_Work_Plan_STD()
        {
            idaWORK_PLAN_STD.Fill();
            if (idaWORK_PLAN_STD.SelectRows.Count == 0)
            {
                return;
            }

            igrCALENDAR_SET.BeginUpdate();
            for (int i = 0; i < idaWORK_PLAN_STD.SelectRows.Count; i++)
            {
                idaCALENDAR_SET.AddUnder();
                for (int j = 0; j < igrCALENDAR_SET.GridAdvExColElement.Count; j++)
                {
                    igrCALENDAR_SET.SetCellValue(i, j, idaWORK_PLAN_STD.SelectRows[i][j]);
                }
            }
            igrCALENDAR_SET.EndUpdate();

            igrCALENDAR_SET.CurrentCellMoveTo(0, 0);
            igrCALENDAR_SET.CurrentCellActivate(0, 0);
            igrCALENDAR_SET.Focus();            
        }

        private Boolean Save_Work_Plan()
        {
            string mCREATED_METHOD;
            //if (iConv.ISNull(PERSON_ID_1.EditValue) != string.Empty)
            //{
            //    mCREATED_METHOD = "P".ToString();
            //}
            //else if (iConv.ISNull(FLOOR_ID_0.EditValue) != string.Empty)
            //{
            //    mCREATED_METHOD = "D".ToString();
            //}
            //else
            //{
            //    mCREATED_METHOD = "A".ToString();
            //}
            mCREATED_METHOD = "A".ToString();
            try
            {
                // 기존자료 삭제.
                idcDELETE_CALENDAR_SET.SetCommandParamValue("W_CREATED_METHOD", mCREATED_METHOD);
                idcDELETE_CALENDAR_SET.ExecuteNonQuery();

                Init_Work_Plan();
                            
                //기적용일수 저장.
                IDC_SAVE_PRE_WORK_DAY.SetCommandParamValue("P_CREATED_METHOD", mCREATED_METHOD);
                IDC_SAVE_PRE_WORK_DAY.ExecuteNonQuery();

                //근무 일정 저장.
                idaCALENDAR_SET.SetInsertParamValue("P_CREATED_METHOD", mCREATED_METHOD);
                idaCALENDAR_SET.SetDeleteParamValue("W_CREATED_METHOD", mCREATED_METHOD);
                idaCALENDAR_SET.Update();
            }
            catch (Exception EX)
            {
                MessageBoxAdv.Show(EX.Message, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return false;
            }
            return true;
        }

        #endregion

        #region ----- isAppInterfaceAdv1_AppMainButtonClick Events -----

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
        
        #region ----- Form Event -----

        private void HRMF0333_CREATE_Load(object sender, EventArgs e)
        {
            idaCALENDAR_SET.FillSchema();
        }

        private void HRMF0333_CREATE_Shown(object sender, EventArgs e)
        { 
            BTN_DAILY_SELECT.BringToFront();
            BTN_DAILY_CANCEL.BringToFront();
            BTN_DAILY_SAVE.BringToFront();

            idcYYYYMM_TERM.SetCommandParamValue("W_YYYYMM", WORK_YYYYMM.EditValue);
            idcYYYYMM_TERM.ExecuteNonQuery();
            WORK_DATE_FR.EditValue = Convert.ToDateTime(idcYYYYMM_TERM.GetCommandParamValue("O_START_DATE"));
            WORK_DATE_TO.EditValue = Convert.ToDateTime(idcYYYYMM_TERM.GetCommandParamValue("O_END_DATE")); 
        }

        private void igrCALENDAR_SET_CurrentCellValidating(object pSender, ISGridAdvExValidatingEventArgs e)
        {
            if (e.ColIndex == igrCALENDAR_SET.GetColumnToIndex("HOLY_TYPE"))
            {
                igrCALENDAR_SET.CurrentCellActivate(igrCALENDAR_SET.GetColumnToIndex("DAY_COUNT"));
            }
        }
        
        private void BTN_SAVE_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            if (Save_Work_Plan() == false)
            {
                return;
            }
        }

        private void BTN_CLOSEDL_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            this.Close();
        }
         
        private void btnINSERT_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            if (Insert_Holy_Type() == false)
            {
                return;
            }
            idaCALENDAR_SET.AddUnder();
            if (igrCALENDAR_SET.RowIndex == Convert.ToInt32(0))
            {
                Insert_Before_Apply_Day();
            }
            Init_Cell_Status();
            if (iConv.ISNull(WORK_TYPE.EditValue).Substring(0, 2) == "11" 
               && iConv.ISNumtoZero(igrCALENDAR_SET.GetCellValue("HOLY_TYPE")) != Convert.ToInt32(-1))
            {
                idaCALENDAR_SET.Delete();
            }            
        }

        private void btnDELETE_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            idaCALENDAR_SET.Delete();
        }

        private void btnCANCEL_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            idaCALENDAR_SET.Cancel();
        }

        private void BTN_DAILY_SELECT_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            SEARCH_DB_DETAIL();
        }

        private void BTN_DAILY_CANCEL_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            IDA_CALENDAR_DETAIL_1.Cancel();
            IDA_CALENDAR_DETAIL_2.Cancel();
        }

        private void BTN_DAILY_SAVE_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            IDA_CALENDAR_DETAIL_1.Update();
            IDA_CALENDAR_DETAIL_2.Update();
        }

        private void BTN_DAILY_CREATE_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            UseWaitCursor = true;
            this.Cursor = System.Windows.Forms.Cursors.WaitCursor;
            Application.DoEvents();

            //월 근무기준 변경 내역 저장 
            if (Save_Work_Plan() == false)
            {
                return;
            }

            string mCREATED_METHOD;
            //2015.03.30 J.LAKE 변경 -> 근무계획 생성 방법 변경 --             
            //if (iString.ISNull(PERSON_ID.EditValue) != string.Empty)
            //{
            //    mCREATED_METHOD = "P".ToString();
            //}
            //else if (iString.ISNull(DEPT_ID.EditValue) != string.Empty)
            //{
            //    mCREATED_METHOD = "D".ToString();
            //}
            //else
            //{
            //    mCREATED_METHOD = "A".ToString();
            //}
            //2015.03.30 J.LAKE 변경 -> 근무계획 생성 방법 변경 -- 
            mCREATED_METHOD = "A".ToString();

            string vSTATUS = "F";
            string vMESSAGE = null;
            IDC_SET_CALENDAR_DETAIL.SetCommandParamValue("P_CREATE_TYPE", mCREATED_METHOD);
            IDC_SET_CALENDAR_DETAIL.ExecuteNonQuery();
            vSTATUS = iConv.ISNull(IDC_SET_CALENDAR_DETAIL.GetCommandParamValue("O_STATUS"));
            vMESSAGE = iConv.ISNull(IDC_SET_CALENDAR_DETAIL.GetCommandParamValue("O_MESSAGE"));
            if (IDC_SET_CALENDAR_DETAIL.ExcuteError || vSTATUS == "F")
            {
                UseWaitCursor = false;
                this.Cursor = Cursors.Default;
                Application.DoEvents();
                MessageBoxAdv.Show(vMESSAGE, "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }
            UseWaitCursor = false;
            this.Cursor = Cursors.Default;
            Application.DoEvents();
            if (vMESSAGE != string.Empty)
            {
                MessageBoxAdv.Show(vMESSAGE, "Infomatioin", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }

            //일근무계획 생성 
            SEARCH_DB_DETAIL();
        }

        private void BTN_SET_WORKCALENDAR_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            if (iConv.ISNull(WORK_YYYYMM.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10375"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                WORK_YYYYMM.Focus();
                return;
            }
            if (iConv.ISNull(WORK_TYPE_ID.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Work Type(교대 유형)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                WORK_TYPE.Focus();
                return;
            }
            if (WORK_DATE_FR.EditValue == null)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10010"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                WORK_DATE_FR.Focus();
                return;
            }
            if (WORK_DATE_TO.EditValue == null)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10011"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                WORK_DATE_TO.Focus();
                return;
            }

            try
            {
                //일 근무기준 update//
                IDA_CALENDAR_DETAIL_1.Update();
                IDA_CALENDAR_DETAIL_2.Update();
            }
            catch (Exception Ex)
            {
                MessageBoxAdv.Show(Ex.Message, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }

            if (IDA_CALENDAR_DETAIL_1.CurrentRows.Count == 0)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10420"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }

            string mCREATED_METHOD;
            //2015.03.30 J.LAKE 변경 -> 근무계획 생성 방법 변경 --             
            //if (iString.ISNull(PERSON_ID.EditValue) != string.Empty)
            //{
            //    mCREATED_METHOD = "P".ToString();
            //}
            //else if (iString.ISNull(DEPT_ID.EditValue) != string.Empty)
            //{
            //    mCREATED_METHOD = "D".ToString();
            //}
            //else
            //{
            //    mCREATED_METHOD = "A".ToString();
            //}
            //2015.03.30 J.LAKE 변경 -> 근무계획 생성 방법 변경 -- 
            mCREATED_METHOD = "A".ToString();

            string vSTATUS = "F";
            string vMESSAGE = null;
            IDC_SET_WORKCALENDAR.SetCommandParamValue("P_CREATE_TYPE", mCREATED_METHOD);
            IDC_SET_WORKCALENDAR.ExecuteNonQuery();
            vSTATUS = iConv.ISNull(IDC_SET_WORKCALENDAR.GetCommandParamValue("O_STATUS"));
            vMESSAGE = iConv.ISNull(IDC_SET_WORKCALENDAR.GetCommandParamValue("O_MESSAGE"));
            if (IDC_SET_WORKCALENDAR.ExcuteError || vSTATUS == "F")
            {
                UseWaitCursor = false;
                this.Cursor = Cursors.Default;
                Application.DoEvents();
                MessageBoxAdv.Show(vMESSAGE, "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }
            UseWaitCursor = false;
            this.Cursor = Cursors.Default;
            Application.DoEvents();
            if (vMESSAGE != string.Empty)
            {
                MessageBoxAdv.Show(vMESSAGE, "Infomatioin", MessageBoxButtons.OK, MessageBoxIcon.Information);
            } 
        }

        #endregion

        #region ----- Lookup Event -----

        private void ilaWORK_TYPE_SelectedRowData(object pSender)
        {
            Search_DB("A");
        }

        private void ilaPERSON_SelectedRowData(object pSender)
        {
             
        }

        private void ilaDEPT_SelectedRowData(object pSender)
        {
           
        }

        private void ilaDEPT_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ILD_DEPT.SetLookupParamValue("W_CORP_ID", CORP_ID.EditValue);
            ILD_DEPT.SetLookupParamValue("W_USABLE_CHECK_YN", "Y");
        }

        private void ilaWORK_TYPE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            isSetCommonLookUpParameter("WORK_TYPE", "Y");
        }

        private void ilaHOLY_TYPE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            isSetCommonLookUpParameter("HOLY_TYPE", "Y");
        }

        private void ilaFLOOR_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ILD_FLOOR.SetLookupParamValue("W_GROUP_CODE", "FLOOR");
            ILD_FLOOR.SetLookupParamValue("W_ENABLED_FLAG_YN", "N");
        }

        #endregion

        #region ----- Adapter Event -----

        private void idaCALENDAR_SET_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {
            //if (iConv.ISNull(START_DATE.EditValue) == string.Empty)
            //{
            //    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10010"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            //    return;
            //}
            //if (iConv.ISNull(END_DATE.EditValue) == string.Empty)
            //{
            //    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10011"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            //    return;
            //}
            if (iConv.ISNull(WORK_TYPE_ID.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Work Type(교대 유형)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }

            if (iConv.ISNull(WORK_TYPE.EditValue).Substring(0, 2) == "11")
            {
            }
            else
            {
                if (iConv.ISNull(e.Row["HOLY_TYPE"]) == String.Empty)
                {
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Holy Type(근무구분)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    return;
                }
                if (iConv.ISNull(e.Row["HOLY_TYPE_NAME"]) == String.Empty)
                {
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Holy Type Name(근무명) "), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    return;
                }
                if (iConv.ISNull(e.Row["DAY_COUNT"]) == String.Empty)
                {
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Day Count(근무일수) "), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    return;
                }
            }
        }

        private void IDA_CALENDAR_DETAIL_1_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {
            if (iConv.ISNull(e.Row["WORK_DATE"]) == String.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Work Date(근무일자)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iConv.ISNull(e.Row["DUTY_ID"]) == String.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Duty Type(근태)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iConv.ISNull(e.Row["HOLY_TYPE"]) == String.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Holy Type(근무)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
        }

        private void IDA_CALENDAR_DETAIL_2_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {
            if (iConv.ISNull(e.Row["WORK_DATE"]) == String.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Work Date(근무일자)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iConv.ISNull(e.Row["DUTY_ID"]) == String.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Duty Type(근태)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iConv.ISNull(e.Row["HOLY_TYPE"]) == String.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Holy Type(근무)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
        }

        private void idaCALENDAR_SET_NewRowMoved(object pSender, ISBindingEventArgs pBindingManager)
        {
            Init_Cell_Status();
        }

        #endregion

        #region ----- Edit Event -----

        #endregion

    }
}