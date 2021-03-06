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
    public partial class HRMF0333 : Office2007Form
    {
        #region ----- Variables -----

        private ISFunction.ISDateTime ISDate = new ISFunction.ISDateTime();
        private ISFunction.ISConvert iString = new ISFunction.ISConvert();

        #endregion;

        #region ----- Constructor -----

        public HRMF0333(Form pMainForm, ISAppInterface pAppInterface)
        {
            InitializeComponent();
            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;
        }

        #endregion;

        #region ----- Default Set Methods ----

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
            // 조회년월 SETTING
            ildYYYYMM.SetLookupParamValue("W_START_YYYYMM", "2010-01");

            WORK_YYYYMM_0.EditValue = ISDate.ISYearMonth(DateTime.Today);
            WORK_PERIOD_3.EditValue = ISDate.ISYearMonth(DateTime.Today);

            idcYYYYMM_TERM.SetCommandParamValue("W_YYYYMM", WORK_YYYYMM_0.EditValue);
            idcYYYYMM_TERM.ExecuteNonQuery();
            START_DATE_0.EditValue = idcYYYYMM_TERM.GetCommandParamValue("O_START_DATE");
            END_DATE_0.EditValue = idcYYYYMM_TERM.GetCommandParamValue("O_END_DATE");

            // Lookup SETTING
            ildCORP.SetLookupParamValue("W_DUTY_CONTROL_YN", "Y");
            ildCORP.SetLookupParamValue("W_ENABLED_FLAG_YN", "N");

            // LOOKUP DEFAULT VALUE SETTING - CORP
            idcDEFAULT_CORP.SetCommandParamValue("W_DUTY_CONTROL_YN", "Y");
            idcDEFAULT_CORP.SetCommandParamValue("W_ENABLED_FLAG_YN", "N");
            idcDEFAULT_CORP.ExecuteNonQuery();
            CORP_NAME_0.EditValue = idcDEFAULT_CORP.GetCommandParamValue("O_CORP_NAME");
            CORP_ID_0.EditValue = idcDEFAULT_CORP.GetCommandParamValue("O_CORP_ID");

            WORK_CORP_NAME_2.EditValue = idcDEFAULT_CORP.GetCommandParamValue("O_CORP_NAME");
            WORK_CORP_ID_2.EditValue = idcDEFAULT_CORP.GetCommandParamValue("O_CORP_ID");

            WORK_DATE_FR_2.EditValue = ISDate.ISMonth_1st(System.DateTime.Today);
            WORK_DATE_TO_2.EditValue = ISDate.ISMonth_Last(System.DateTime.Today);
        }

        #endregion;

        #region ----- Search Methods ----

        private void isSEARCH_DB()
        {
            if (CORP_ID_0.EditValue == null)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10001"), "Warning", MessageBoxButtons.OK,MessageBoxIcon.Warning);
                CORP_NAME_0.Focus();
                return;
            }
            if (string.IsNullOrEmpty(WORK_YYYYMM_0.EditValue.ToString()))
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10036"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                WORK_YYYYMM_0.Focus();
                return;
            }
            idaPERSON_INFO.Fill();
            igrPERSON_INFO.Focus();
        }

        private void Seaech_Not_Create_Work_Calendar()
        {
            try
            {
                idaSELECT_NOT_CREATE_WORKCALENDAR.Fill();
            }
            catch (System.Exception ex)
            {
                isAppInterfaceAdv1.OnAppMessage(ex.Message);
                System.Windows.Forms.Application.DoEvents();
            }
        }

        private void Seaech_ilaLIST_CREATED_CALENDAR_SET()
        {
            try
            {
                ilaLIST_CREATED_CALENDAR_SET.Fill();
            }
            catch (System.Exception ex)
            {
                isAppInterfaceAdv1.OnAppMessage(ex.Message);
                System.Windows.Forms.Application.DoEvents();
            }
        }

        #endregion;

        #region ----- Private Methods ----

        private void Person_Info()
        {
            PERSON_NAME_1.EditValue = igrPERSON_INFO.GetCellValue("NAME");
            JOB_CATEGORY_NAME_1.EditValue = igrPERSON_INFO.GetCellValue("JOB_CATEGORY_NAME");
            JOIN_DATE_1.EditValue = igrPERSON_INFO.GetCellValue("JOIN_DATE");
            RETIRE_DATE_1.EditValue = igrPERSON_INFO.GetCellValue("RETIRE_DATE");
            START_DATE_1.EditValue = igrPERSON_INFO.GetCellValue("START_DATE");
            END_DATE_1.EditValue = igrPERSON_INFO.GetCellValue("END_DATE");
        }

        private void ISCalendarCreated(string pForm_ID)
        {
            if (pForm_ID == "HRMF0333_CREATE")
            {
                //MessageBoxAdv.Show("생성완료", "Ok", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
        }

        private string  ISCap_Check()
        {// 근무계획표 변경 권한 체크.
            string sCap_Level;
            idcCAP_LEVEL.SetCommandParamValue("W_MODULE_CODE", "20".ToString());
            idcCAP_LEVEL.ExecuteNonQuery();
            sCap_Level = idcCAP_LEVEL.GetCommandParamValue("O_CAP_LEVEL").ToString();
            return sCap_Level;
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
            else if ((pHoly_Type.ToString() == "0".ToString() || pHoly_Type.ToString() == "1".ToString() || pHoly_Type.ToString() == "2".ToString()
         || pHoly_Type.ToString() == "D".ToString() || pHoly_Type.ToString() == "S".ToString())
              && IO_Flag.ToString() == "OUT".ToString())
            {// 주간, 무휴, 유휴, DAY, SWING --> 같은 날짜.
                if (Convert.ToDateTime(pWork_Date).Date <= Convert.ToDateTime(pNew_Work_Date).Date
                    && Convert.ToDateTime(pNew_Work_Date).Date <= Convert.ToDateTime(pWork_Date).AddDays(1).Date)
                {
                    mCheck_Value = true;
                }
            }
            else if ((pHoly_Type.ToString() == "3".ToString() || pHoly_Type.ToString() == "N".ToString())
           && IO_Flag.ToString() == "OUT".ToString())
            {// 주간, 야간, 무휴, 유휴, DAY, NIGHT --> 같은 날짜.
                if (Convert.ToDateTime(pWork_Date).Date <= Convert.ToDateTime(pNew_Work_Date).Date
                    && Convert.ToDateTime(pNew_Work_Date).Date <= Convert.ToDateTime(pWork_Date).AddDays(1).Date)
                {
                    mCheck_Value = true;
                }
            }
            return(mCheck_Value);
        }

        #endregion;

        #region ----- MDi ToolBar Button Event -----

        private void isAppInterfaceAdv1_AppMainButtonClick(ISAppButtonEvents e)
        {
            if (this.IsActive)
            {
                if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Search)
                {
                    int vIndexTAB = isTAB.SelectedIndex;

                    if (vIndexTAB == 0)
                    {
                        isSEARCH_DB();
                    }
                    else if (vIndexTAB == 1)
                    {
                        Seaech_Not_Create_Work_Calendar();
                    }
                    else if (vIndexTAB == 2)
                    {
                        Seaech_ilaLIST_CREATED_CALENDAR_SET();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddOver)
                {

                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddUnder)
                {

                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Update)
                {
                    if (idaWORKCALENDAR.IsFocused)
                    {
                        // 권한 체크
                        if (ISCap_Check() != "C".ToString())
                        {
                            MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_10009", "&&CAP:=Create Work Calendar(근무계획표 생성)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                            return;
                        }
                        idaPERSON_INFO.Update();
                    }
                    else if (ilaLIST_CREATED_CALENDAR_SET.IsFocused)
                    {
                        ilaLIST_CREATED_CALENDAR_SET.Update();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Cancel)
                {
                    if (idaWORKCALENDAR.IsFocused)
                    {
                        idaWORKCALENDAR.Cancel();
                    }
                    else if (ilaLIST_CREATED_CALENDAR_SET.IsFocused)
                    {
                        ilaLIST_CREATED_CALENDAR_SET.Cancel();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {
                    if (idaWORKCALENDAR.IsFocused)
                    {
                        idaWORKCALENDAR.Delete();
                    }
                    else if (ilaLIST_CREATED_CALENDAR_SET.IsFocused)
                    {
                        ilaLIST_CREATED_CALENDAR_SET.Delete();
                    }
                }
            }
        }

        #endregion;

        #region ----- Form Event -----

        private void HRMF0333_Load(object sender, EventArgs e)
        {
            ISDate = new ISFunction.ISDateTime();

            DefaultCorporation();            
            //DefaultSetFormReSize();		//[Child Form, Mdi Form에 맞게 ReSize]

            ilaLIST_CREATED_CALENDAR_SET.FillSchema();
        }
        
        private void ibtCALENDAR_CREATE_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            if (CORP_ID_0.EditValue == null)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10001"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }
            if (string.IsNullOrEmpty(WORK_YYYYMM_0.EditValue.ToString()))
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10036"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }

            // 권한 체크
            if (ISCap_Check() != "C".ToString())
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_10009", "&&CAP:=Create Work Calendar(근무계획표 생성)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }
            
            System.Windows.Forms.DialogResult vdlgResultValue;
            Form vHRMF0333_CREATE = new HRMF0333_CREATE(this.MdiParent, isAppInterfaceAdv1.AppInterface,
                                                            CORP_ID_0.EditValue, WORK_YYYYMM_0.EditValue);
            vdlgResultValue = vHRMF0333_CREATE.ShowDialog();
            vHRMF0333_CREATE.Dispose();
        }

        private void igrWORK_CALENDAR_CurrentCellValidating(object pSender, ISGridAdvExValidatingEventArgs e)
        {
            object mHoly_Type = igrWORK_CALENDAR.GetCellValue("HOLY_TYPE");
            object mWork_Date = igrWORK_CALENDAR.GetCellValue("WORK_DATE");
            object mNew_Work_Date;

            if (e.ColIndex == igrWORK_CALENDAR.GetColumnToIndex("OPEN_TIME"))
            {// 출근일자
                mNew_Work_Date = e.NewValue;
                if (Check_Work_Date_time(mHoly_Type, "IN".ToString(), mWork_Date, mNew_Work_Date) == false)
                {
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10151"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    return;
                }
            }

            if (e.ColIndex == igrWORK_CALENDAR.GetColumnToIndex("CLOSE_TIME"))
            {// 출근일자
                mNew_Work_Date = e.NewValue;
                if (Check_Work_Date_time(mHoly_Type, "OUT".ToString(), mWork_Date, mNew_Work_Date) == false)
                {
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10151"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    return;
                }
            }
        }
      
        #endregion

        #region ----- Adapter Event -----

        private void idaWORKCALENDAR_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {
            if (e.Row["PERSON_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Person Name(사원 정보)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["WORK_DATE"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Work Date(근무 일자)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["DUTY_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Duty Name(근태 정보)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["HOLY_TYPE"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Holy Type(근무 정보)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }

            if (e.Row["HOLY_TYPE"].ToString() == "1".ToString() || e.Row["HOLY_TYPE"].ToString() == "0".ToString())
            {// 휴일
                if (e.Row["OPEN_TIME"] != DBNull.Value || e.Row["CLOSE_TIME"] != DBNull.Value)
                {
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10040", "&&VALUE:=Plan Open Time/Plan Close Time(계획 출근/퇴근 정보)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    e.Cancel = true;
                    return;
                }
            }
            else
            {
                if (e.Row["OPEN_TIME"] == DBNull.Value && e.Row["CLOSE_TIME"] == DBNull.Value)
                {
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Plan Open Time/Plan Close Time(계획 출근/퇴근 정보)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    e.Cancel = true;
                    return;
                }
            }

            if (Check_Work_Date_time(e.Row["HOLY_TYPE"], "IN".ToString(), e.Row["WORK_DATE"], e.Row["OPEN_TIME"]) == false)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10151"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }

            if (Check_Work_Date_time(e.Row["HOLY_TYPE"], "OUT".ToString(), e.Row["WORK_DATE"], e.Row["CLOSE_TIME"]) == false)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10151"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
        }

        private void idaWORKCALENDAR_PreDelete(ISPreDeleteEventArgs e)
        {
            MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10029", "&&VALUE:=Data(해당 자료)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            e.Cancel = true;
            return;
        }
        #endregion

        #region ----- LookUP Event ----

        private void ilaWORK_TYPE_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", "WORK_TYPE");
            ildCOMMON.SetLookupParamValue("W_ENABLED_FLAG_YN", "N");
        }

        private void ilaWORK_TYPE_2_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", "WORK_TYPE");
            ildCOMMON.SetLookupParamValue("W_ENABLED_FLAG_YN", "N");
        }

        private void ilaWORK_TYPE_3_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", "WORK_TYPE");
            ildCOMMON.SetLookupParamValue("W_ENABLED_FLAG_YN", "N");
        }

        private void ilaDUTY_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", "DUTY");
            ildCOMMON.SetLookupParamValue("W_ENABLED_FLAG_YN", "N");
        }

        private void ilaHOLY_TYPE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", "HOLY_TYPE");
            ildCOMMON.SetLookupParamValue("W_ENABLED_FLAG_YN", "Y");
        }

        private void ilaHOLY_TYPE_SelectedRowData(object pSender)
        {
            object mOPEN_TIME;
            object mCLOSE_TIME;
            idcWORK_IO_TIME.ExecuteNonQuery();
            mOPEN_TIME = idcWORK_IO_TIME.GetCommandParamValue("O_OPEN_TIME");
            mCLOSE_TIME = idcWORK_IO_TIME.GetCommandParamValue("O_CLOSE_TIME");
            igrWORK_CALENDAR.SetCellValue("OPEN_TIME", mOPEN_TIME);
            igrWORK_CALENDAR.SetCellValue("CLOSE_TIME", mCLOSE_TIME);
        }

        private void ilaFLOOR_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildFLOOR_0.SetLookupParamValue("W_GROUP_CODE", "FLOOR");
            ildFLOOR_0.SetLookupParamValue("W_ENABLED_FLAG_YN", "N");
        }

        private void ilaFLOOR_2_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildFLOOR_2.SetLookupParamValue("W_GROUP_CODE", "FLOOR");
            ildFLOOR_2.SetLookupParamValue("W_ENABLED_FLAG_YN", "N");
        }

        private void ilaEMPLOYE_TYPE_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", "EMPLOYE_TYPE");
            ildCOMMON.SetLookupParamValue("W_ENABLED_YN", "Y");
        }

        private void ilaCREATED_METHOD_3_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCREATED_METHOD_3.SetLookupParamValue("W_GROUP_CODE", "CREATED_METHOD");
            ildCREATED_METHOD_3.SetLookupParamValue("W_ENABLED_YN", "Y");
        }

        #endregion

        #region ----- Edit Event ----

        private void WORK_DATE_FR_2_EditValueChanged(object pSender)
        {
            WORK_DATE_TO_2.EditValue = ISDate.ISMonth_Last(WORK_DATE_FR_2.DateTimeValue);
        }

        private void WORK_DATE_FR_3_EditValueChanged(object pSender)
        {
            WORK_DATE_TO_3.EditValue = ISDate.ISMonth_Last(WORK_DATE_FR_3.DateTimeValue);
        }

        #endregion
    }
}