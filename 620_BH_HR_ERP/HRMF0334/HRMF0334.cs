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

namespace HRMF0334
{
    public partial class HRMF0334 : Office2007Form
    {
        #region ----- Variables -----

        ISFunction.ISDateTime iDateTime = new ISFunction.ISDateTime();
        ISFunction.ISConvert iString = new ISFunction.ISConvert();

        private decimal[] mDuty_ID;

        private string mCAPACITY = string.Empty;

        string mDutyName = string.Empty;
        
        #endregion;

        #region ----- Constructor -----

        public HRMF0334(Form pMainForm, ISAppInterface pAppInterface)
        {
            InitializeComponent();
            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;
        }

        #endregion;

        #region ----- Get Date Method -----

        private DateTime GetDate()
        {
            DateTime vDateTime = DateTime.Today;

            try
            {
                idcGetDate.ExecuteNonQuery();
                object vObject = idcGetDate.GetCommandParamValue("X_LOCAL_DATE");

                bool isConvert = vObject is DateTime;
                if (isConvert == true)
                {
                    vDateTime = (DateTime)vObject;
                }
            }
            catch (Exception ex)
            {
                string vMessage = ex.Message;
                vDateTime = new DateTime(9999, 12, 31, 23, 59, 59);
            }
            return vDateTime;
        }

        #endregion;

        #region ----- Convert DateTime Methods ----

        private System.DateTime ConvertDateTime(object pObject)
        {
            System.DateTime vDateTime = new System.DateTime();

            try
            {
                if (pObject != null)
                {
                    bool IsConvert = pObject is System.DateTime;
                    if (IsConvert == true)
                    {
                        vDateTime = (System.DateTime)pObject;
                    }
                }
            }
            catch
            {

            }

            return vDateTime;
        }

        #endregion;

        #region ----- Convert String Method ----

        private string ConvertString(object pObject)
        {
            string vString = string.Empty;

            try
            {
                if (pObject != null)
                {
                    bool IsConvert = pObject is string;
                    if (IsConvert == true)
                    {
                        vString = pObject as string;
                    }
                }
            }
            catch (System.Exception ex)
            {
                isAppInterfaceAdv1.OnAppMessage(ex.Message);
                System.Windows.Forms.Application.DoEvents();
            }

            return vString;
        }

        #endregion;

        #region ----- Private Methods -----

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

            //작업장
            idcDEFAULT_FLOOR.ExecuteNonQuery();
            FLOOR_NAME_0.EditValue = idcDEFAULT_FLOOR.GetCommandParamValue("O_FLOOR_NAME");
            FLOOR_ID_0.EditValue = idcDEFAULT_FLOOR.GetCommandParamValue("O_FLOOR_ID");

            object oPERSON_NAME = idcDEFAULT_FLOOR.GetCommandParamValue("O_PERSON_NAME");
            object oCAPACITY = idcDEFAULT_FLOOR.GetCommandParamValue("O_CAPACITY"); //권한
            mCAPACITY = ConvertString(oCAPACITY);
        }

        private void isSearch_DB()
        {
            if (CORP_ID_0.EditValue == null)
            {// 업체.
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10001"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                CORP_NAME_0.Focus();
                return;
            }
            if (iSTART_DATE_0.EditValue == null)
            {// 시작일자
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10010"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                iSTART_DATE_0.Focus();
                return;
            }
            if (iEND_DATE_0.EditValue == null)
            {// 종료일자
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10011"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                iEND_DATE_0.Focus();
                return;
            }
            if (Convert.ToDateTime(iSTART_DATE_0.EditValue) > Convert.ToDateTime( iEND_DATE_0.EditValue))
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10012"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                iSTART_DATE_0.Focus();
                return;
            }

            idaDUTY_PERIOD.Fill();
            igrDUTY_PERIOD.Focus();
        }

        private void isSearch_WorkCalendar(Object pPerson_ID, Object pStart_Date, Object pEnd_Date)
        {            
            idaWORK_CALENDAR.SetSelectParamValue("W_PERSON_ID", pPerson_ID);
            idaWORK_CALENDAR.SetSelectParamValue("W_START_DATE", pStart_Date);
            idaWORK_CALENDAR.SetSelectParamValue("W_END_DATE", pEnd_Date);

            if (pStart_Date != DBNull.Value && pEnd_Date != DBNull.Value)
            {
                idaHOLIDAY_MANAGEMENT.SetSelectParamValue("W_START_YEAR", iDateTime.ISYear(Convert.ToDateTime(pStart_Date)));
                idaHOLIDAY_MANAGEMENT.SetSelectParamValue("W_END_YEAR", iDateTime.ISYear(Convert.ToDateTime(pEnd_Date)));
            }
            idaWORK_CALENDAR.Fill();
            idaHOLIDAY_MANAGEMENT.Fill();
        }

        private bool isAdd_DB_Check()
        {// 데이터 추가시 검증.
            if (CORP_ID_0.EditValue == null)
            {// 업체.
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10001"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                CORP_NAME_0.Focus();
                return false;
            }
            return true;
        }

        //그리드의 시간을 보이게 할 때 사용할 근태[외출, 지각] id 값 가져오기[2011-08-10]
        private void Append_SelectDuty()
        {
            try
            {
                //시간 입력하는 열, 추가/수정 못 하도록
                //시작시간
                igrDUTY_PERIOD.GridAdvExColElement[5].Insertable = 0; //수정불가
                igrDUTY_PERIOD.GridAdvExColElement[5].Updatable = 0;

                //종료시간
                igrDUTY_PERIOD.GridAdvExColElement[7].Insertable = 0;
                igrDUTY_PERIOD.GridAdvExColElement[7].Updatable = 0;

                object vObject = null;
                idaSELECT_DUTY.Fill();
                int vCountRow = idaSELECT_DUTY.OraSelectData.Rows.Count;

                if (vCountRow > 0)
                {
                    mDuty_ID = new decimal[vCountRow];
                    for(int vRow = 0; vRow <vCountRow; vRow++)
                    {
                        vObject = idaSELECT_DUTY.OraSelectData.Rows[vRow]["COMMON_ID"];
                        mDuty_ID[vRow] = iString.ISDecimaltoZero(vObject);
                    }
                }
            }
            catch (System.Exception ex)
            {
                isAppInterfaceAdv1.OnAppMessage(ex.Message);
                System.Windows.Forms.Application.DoEvents();
            }
        }

        #endregion;

        #region ----- MDi ToolBar Button Event -----
        
        private void isAppInterfaceAdv1_AppMainButtonClick(ISAppButtonEvents e)
        {
            if (this.IsActive)
            {
                if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Search)
                {
                    isSearch_DB();
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddOver)
                {
                    if(idaDUTY_PERIOD.IsFocused)
                    {
                        if (isAdd_DB_Check() == false)
                        {
                            return;
                        }

                        idaDUTY_PERIOD.AddOver();

                        igrDUTY_PERIOD.SetCellValue("START_DATE", DateTime.Today.Date);
                        igrDUTY_PERIOD.SetCellValue("END_DATE", DateTime.Today.Date);
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddUnder)
                {
                    if (idaDUTY_PERIOD.IsFocused)
                    {
                        if (isAdd_DB_Check() == false)
                        {
                            return;
                        }
                        idaDUTY_PERIOD.AddUnder();

                        igrDUTY_PERIOD.SetCellValue("START_DATE", DateTime.Today.Date);
                        igrDUTY_PERIOD.SetCellValue("END_DATE", DateTime.Today.Date);
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Update)
                {
                    if (idaDUTY_PERIOD.IsFocused)
                    {
                        idaDUTY_PERIOD.Update();                        
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Cancel)
                {
                    if (idaDUTY_PERIOD.IsFocused)
                    {
                        idaDUTY_PERIOD.Cancel();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {
                    if (idaDUTY_PERIOD.IsFocused)
                    {
                        idaDUTY_PERIOD.Delete();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Print) //인쇄버튼
                {
                    XLPrinting1("PRINT", igrDUTY_PERIOD);
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Export) //엑셀파일 버튼
                {
                    XLPrinting1("FILE", igrDUTY_PERIOD);
                }
            }
        }

        #endregion;

        #region ----- Form Event -----

        private void HRMF0334_Load(object sender, EventArgs e)
        {
            idaDUTY_PERIOD.FillSchema();
            iSTART_DATE_0.EditValue = DateTime.Today.AddDays(-7);
            iEND_DATE_0.EditValue = DateTime.Today.AddDays(7);

            DefaultCorporation();

            // LOOKUP DEFAULT VALUE SETTING - DUTY_APPROVE_STATUS
            idcDEFAULT_VALUE.SetCommandParamValue("W_GROUP_CODE", "DUTY_APPROVE_STATUS");
            idcDEFAULT_VALUE.ExecuteNonQuery();
            iAPPROVE_STATUS_NAME_0.EditValue = idcDEFAULT_VALUE.GetCommandParamValue("O_CODE_NAME");
            iAPPROVE_STATUS_0.EditValue = idcDEFAULT_VALUE.GetCommandParamValue("O_CODE");

            // LOOKUP DEFAULT VALUE SETTING - SEARCH_TYPE
            idcDEFAULT_VALUE.SetCommandParamValue("W_GROUP_CODE", "SEARCH_TYPE");
            idcDEFAULT_VALUE.ExecuteNonQuery();
            iSEARCH_TYPE_NAME_0.EditValue = idcDEFAULT_VALUE.GetCommandParamValue("O_CODE_NAME");
            iSEARCH_TYPE_0.EditValue = idcDEFAULT_VALUE.GetCommandParamValue("O_CODE");

            Append_SelectDuty();
        }

        #endregion

        #region ----- Grid Event -----

        private void igrDUTY_PERIOD_CurrentCellValidating(object pSender, ISGridAdvExValidatingEventArgs e)
        {
            string vString_REQUEST_LIMIT_COUNT = string.Empty;
            int vREQUEST_LIMIT_COUNT = 0;

            try
            {
                // 시작일자 또는 종료일자 변경시 근무계획 조회.
                if (e.ColIndex == igrDUTY_PERIOD.GetColumnToIndex("NAME"))
                {
                    isSearch_WorkCalendar(igrDUTY_PERIOD.GetCellValue("PERSON_ID"), igrDUTY_PERIOD.GetCellValue("START_DATE"), igrDUTY_PERIOD.GetCellValue("END_DATE"));
                }

                if (e.ColIndex == igrDUTY_PERIOD.GetColumnToIndex("START_DATE"))
                {
                    isSearch_WorkCalendar(igrDUTY_PERIOD.GetCellValue("PERSON_ID"), e.NewValue, igrDUTY_PERIOD.GetCellValue("END_DATE"));
                }
                if (e.ColIndex == igrDUTY_PERIOD.GetColumnToIndex("END_DATE"))
                {
                    isSearch_WorkCalendar(igrDUTY_PERIOD.GetCellValue("PERSON_ID"), igrDUTY_PERIOD.GetCellValue("START_DATE"), e.NewValue);
                }

                //---------------------------------------------------------------------------------------------
                ///////////////////////////////////////////////////////////////////////////////////////////////
                //---------------------------------------------------------------------------------------------

                if (mCAPACITY == "C")
                {
                    return;
                }

                InfoSummit.Win.ControlAdv.ISGridAdvEx vGrid = pSender as InfoSummit.Win.ControlAdv.ISGridAdvEx;

                int vIndexColunm = vGrid.GetColumnToIndex("START_DATE");

                if (e.ColIndex == vIndexColunm)
                {
                    System.DateTime vCurrentDate = GetDate();
                    object vObject = vGrid.GetCellValue("START_DATE");
                    System.DateTime vRequestDate = ConvertDateTime(vObject);
                    System.TimeSpan vSubtractDate = vCurrentDate - vRequestDate;

                    idcGET_REQUEST_LIMIT.SetCommandParamValue("W_CODE", "DUTY_PERIOD_LIMIT");
                    idcGET_REQUEST_LIMIT.ExecuteNonQuery();
                    object o_REQUEST_LIMIT_COUNT = idcGET_REQUEST_LIMIT.GetCommandParamValue("O_REQUEST_LIMIT_COUNT");
                    vString_REQUEST_LIMIT_COUNT = ConvertString(o_REQUEST_LIMIT_COUNT);
                    vREQUEST_LIMIT_COUNT = int.Parse(vString_REQUEST_LIMIT_COUNT);

                    int vSubDay = vSubtractDate.Days;
                    if (vSubDay > vREQUEST_LIMIT_COUNT) //3
                    {
                        //일 전의 고정근태를 신청할 수 없습니다!
                        string vMessage = string.Format("{0}{1}", vREQUEST_LIMIT_COUNT, isMessageAdapter1.ReturnText("FCM_10367"));
                        MessageBoxAdv.Show(vMessage, "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                        e.Cancel = true;
                    }
                    else
                    {
                        vGrid.SetCellValue("END_DATE", vObject);
                    }
                }
            }
            catch (System.Exception ex)
            {
                isAppInterfaceAdv1.OnAppMessage(ex.Message);
                System.Windows.Forms.Application.DoEvents();
            }
        }

        #endregion

        #region ----- Apply Method -----

        //승인신청 버튼
        private void btnAPPR_REQUEST_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            try
            {
                idaDUTY_PERIOD.Update();

                if (idaDUTY_PERIOD.CurrentRow.RowState == DataRowState.Unchanged)
                {
                    Apply();
                }
            }
            catch (System.Exception ex)
            {
                MessageBoxAdv.Show(ex.Message, "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            }
        }

        private void Apply()
        {
            try
            {
                int mRowCount = igrDUTY_PERIOD.RowCount;
                for (int R = 0; R < mRowCount; R++)
                {
                    if (iString.ISNull(igrDUTY_PERIOD.GetCellValue(R, igrDUTY_PERIOD.GetColumnToIndex("APPROVE_STATUS"))) == "N".ToString())
                    {// 승인미요청 건에 대해서 승인 처리.
                        idcAPPROVAL_REQUEST.SetCommandParamValue("W_DUTY_PERIOD_ID", igrDUTY_PERIOD.GetCellValue(R, igrDUTY_PERIOD.GetColumnToIndex("DUTY_PERIOD_ID")));
                        idcAPPROVAL_REQUEST.ExecuteNonQuery();

                        object mValue;
                        mValue = idcAPPROVAL_REQUEST.GetCommandParamValue("O_APPROVE_STATUS");
                        igrDUTY_PERIOD.SetCellValue(R, igrDUTY_PERIOD.GetColumnToIndex("APPROVE_STATUS"), mValue);
                        mValue = idcAPPROVAL_REQUEST.GetCommandParamValue("O_APPROVE_STATUS_NAME");
                        igrDUTY_PERIOD.SetCellValue(R, igrDUTY_PERIOD.GetColumnToIndex("APPROVE_STATUS_NAME"), mValue);
                    }
                }

                // EMAIL 발송.
                idcEMAIL_SEND.SetCommandParamValue("P_GUBUN", "A");
                idcEMAIL_SEND.SetCommandParamValue("P_SOURCE_TYPE", "DUTY");
                idcEMAIL_SEND.SetCommandParamValue("P_CORP_ID", CORP_ID_0.EditValue);
                idcEMAIL_SEND.SetCommandParamValue("P_WORK_DATE", DateTime.Today);
                idcEMAIL_SEND.SetCommandParamValue("P_REQ_DATE", DateTime.Today);
                idcEMAIL_SEND.ExecuteNonQuery();

                idaDUTY_PERIOD.OraSelectData.AcceptChanges();
                idaDUTY_PERIOD.Refillable = true;

                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10277"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
            catch (System.Exception ex)
            {
                MessageBoxAdv.Show(ex.Message, "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            }
        }

        #endregion

        #region ----- Adapter Event -----

        private void idaDUTY_PERIOD_NewRowMoved_1(object pSender, ISBindingEventArgs pBindingManager)
        {
            isSearch_WorkCalendar(igrDUTY_PERIOD.GetCellValue("PERSON_ID"), igrDUTY_PERIOD.GetCellValue("START_DATE"), igrDUTY_PERIOD.GetCellValue("END_DATE"));
        }

        private void idaDUTY_PERIOD_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {
            if(e.Row["PERSON_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=사원 정보"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["START_DATE"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=시작일자"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["END_DATE"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=종료일자"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (Convert.ToDateTime(e.Row["START_DATE"]) > Convert.ToDateTime(e.Row["END_DATE"]))
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10012"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }

            if (String.IsNullOrEmpty(e.Row["DESCRIPTION"].ToString()))
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=사유"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
        }

        private void idaDUTY_PERIOD_PreDelete(ISPreDeleteEventArgs e)
        {
        
        }

        private void idaDUTY_PERIOD_NewRowMoved(object pSender, ISBindingEventArgs pBindingManager)
        {
            //if (igrDUTY_PERIOD.RowCount != 0)
            //{
            //    isSearch_WorkCalendar(igrDUTY_PERIOD.GetCellValue("PERSON_ID"), igrDUTY_PERIOD.GetCellValue("START_DATE"), igrDUTY_PERIOD.GetCellValue("END_DATE"));
            //}
            isSearch_WorkCalendar(igrDUTY_PERIOD.GetCellValue("PERSON_ID"), igrDUTY_PERIOD.GetCellValue("START_DATE"), igrDUTY_PERIOD.GetCellValue("END_DATE"));
        }

        private void ilaPERSON_1_SelectedRowData(object pSender)
        {
            System.Windows.Forms.SendKeys.Send("{TAB}");
        }

        private void ilaSTART_TIME_SelectedRowData(object pSender)
        {
            System.Windows.Forms.SendKeys.Send("{TAB}");
        }

        private void ilaEND_TIME_SelectedRowData(object pSender)
        {
            System.Windows.Forms.SendKeys.Send("{TAB}");
        }

        #endregion

        #region ----- LookUp Event -----

        private void ilaAPPROVE_STATUS_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildAPPROVE_STATUS.SetLookupParamValue("W_GROUP_CODE", "DUTY_APPROVE_STATUS");
            ildAPPROVE_STATUS.SetLookupParamValue("W_ENABLED_FLAG_YN", "Y");
        }

        private void ilaSEARCH_TYPE_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildSEARCH_TYPE.SetLookupParamValue("W_GROUP_CODE", "SEARCH_TYPE");
            ildSEARCH_TYPE.SetLookupParamValue("W_ENABLED_FLAG_YN", "Y");
        }

        private void ilaFLOOR_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", "FLOOR");
            ildCOMMON.SetLookupParamValue("W_ENABLED_FLAG_YN", "Y");
        }
        
        private void ilaDUTY_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildDUTY_0.SetLookupParamValue("W_GROUP_CODE", "DUTY");
            ildDUTY_0.SetLookupParamValue("W_ENABLED_FLAG_YN", "Y");
        }

        private void ildDUTY_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", "DUTY");
            ildCOMMON.SetLookupParamValue("W_ENABLED_FLAG_YN", "Y");
        }

        private void ilaSTART_TIME_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildPERIOD_TIME.SetLookupParamValue("W_WORK_DATE", igrDUTY_PERIOD.GetCellValue("START_DATE"));
            ildPERIOD_TIME.SetLookupParamValue("W_START_YN", "Y");
            ildPERIOD_TIME.SetLookupParamValue("W_END_YN", null);
        }

        private void ilaEND_TIME_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildPERIOD_TIME.SetLookupParamValue("W_WORK_DATE", igrDUTY_PERIOD.GetCellValue("END_DATE"));
            ildPERIOD_TIME.SetLookupParamValue("W_START_YN", null);
            ildPERIOD_TIME.SetLookupParamValue("W_END_YN", "Y");
        }

        private void ilaFLOOR_1_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildFLOOR_1.SetLookupParamValue("W_GROUP_CODE", "FLOOR");
            ildFLOOR_1.SetLookupParamValue("W_ENABLED_FLAG_YN", "Y");
        }
        
        #endregion

        #region ----- Visible Method -----

        //[2011-08-09]추가
        private void ilaDUTY_SelectedRowData(object pSender)
        {
            int vCountExist = 0;
            int vCountRow = mDuty_ID.Length;

            object vObject = igrDUTY_PERIOD.GetCellValue("DUTY_ID"); //HRM_COMMON.COMMON_ID
            decimal vDutyID = iString.ISDecimaltoZero(vObject);

            vObject = igrDUTY_PERIOD.GetCellValue("DUTY_NAME");
            mDutyName = iString.ISNull(vObject);

            for (int vRow = 0; vRow < vCountRow; vRow++)
            {
                if (vDutyID == mDuty_ID[vRow])
                {
                    vCountExist++;
                }
            }

            if (vCountExist > 0)
            {
                //igrDUTY_PERIOD.GridAdvExColElement[5].Visible = 1; //START_TIME
                //igrDUTY_PERIOD.GridAdvExColElement[7].Visible = 1; //END_TIME

                //시작시간
                igrDUTY_PERIOD.GridAdvExColElement[5].Insertable = 1; //수정 가능
                igrDUTY_PERIOD.GridAdvExColElement[5].Updatable = 1;

                //종료시간
                igrDUTY_PERIOD.GridAdvExColElement[7].Insertable = 1;
                igrDUTY_PERIOD.GridAdvExColElement[7].Updatable = 1;

                igrDUTY_PERIOD.SetCellValue("START_TIME", null);
                igrDUTY_PERIOD.SetCellValue("END_TIME", null);

                if (mDutyName == "조퇴")
                {
                    idcGET_HOLY_TYPE_WORK_CALENDAR.ExecuteNonQuery();
                    object vOjbect_HolyType = idcGET_HOLY_TYPE_WORK_CALENDAR.GetCommandParamValue("O_HOLY_TYPE");
                    string vString_HolyType = ConvertString(vOjbect_HolyType);

                    if (vString_HolyType == "2")
                    {
                        igrDUTY_PERIOD.SetCellValue("START_TIME", "13:30");
                        igrDUTY_PERIOD.SetCellValue("END_TIME", "17:30");
                        igrDUTY_PERIOD.GridAdvExColElement[7].Insertable = 0;
                        igrDUTY_PERIOD.GridAdvExColElement[7].Updatable = 0;
                    }
                    else if (vString_HolyType == "3")
                    {
                        igrDUTY_PERIOD.SetCellValue("START_TIME", "02:00");
                        igrDUTY_PERIOD.SetCellValue("END_TIME", "06:00");
                        igrDUTY_PERIOD.GridAdvExColElement[7].Insertable = 0;
                        igrDUTY_PERIOD.GridAdvExColElement[7].Updatable = 0;
                    }
                }
                else
                {
                    igrDUTY_PERIOD.GridAdvExColElement[7].Insertable = 1;
                    igrDUTY_PERIOD.GridAdvExColElement[7].Updatable = 1;
                }
            }
            else
            {
                igrDUTY_PERIOD.SetCellValue("START_TIME", null);
                igrDUTY_PERIOD.SetCellValue("END_TIME", null);

                //시작시간
                igrDUTY_PERIOD.GridAdvExColElement[5].Insertable = 0; //수정 불가능
                igrDUTY_PERIOD.GridAdvExColElement[5].Updatable = 0;

                //종료시간
                igrDUTY_PERIOD.GridAdvExColElement[7].Insertable = 0;
                igrDUTY_PERIOD.GridAdvExColElement[7].Updatable = 0;
            }

            igrDUTY_PERIOD.ResetDraw = true;
            igrDUTY_PERIOD.Refresh();
            igrDUTY_PERIOD.Update();

            System.Windows.Forms.SendKeys.Send("{TAB}");
        }

        #endregion

        #region ----- Edit Event -----

        private void iSTART_DATE_0_EditValueChanged(object pSender)
        {
            System.DateTime vDate = iSTART_DATE_0.DateTimeValue;
            iEND_DATE_0.EditValue = vDate.AddDays(14);
        }

        #endregion

        #region ----- XL Print 1 Method ----

        private void XLPrinting1(string pOutChoice, InfoSummit.Win.ControlAdv.ISGridAdvEx pGrid)
        {
            string vMessageText = string.Empty;
            string vSaveFileName = string.Empty;

            int vCountRow = pGrid.RowCount;

            if (vCountRow < 1)
            {
                vMessageText = string.Format("Without Data");
                isAppInterfaceAdv1.OnAppMessage(vMessageText);
                System.Windows.Forms.Application.DoEvents();
                return;
            }

            System.Windows.Forms.Application.UseWaitCursor = true;
            this.Cursor = System.Windows.Forms.Cursors.WaitCursor;
            System.Windows.Forms.Application.DoEvents();

            int vPageNumber = 0;

            vMessageText = string.Format(" Printing Starting...");
            isAppInterfaceAdv1.OnAppMessage(vMessageText);
            System.Windows.Forms.Application.DoEvents();

            XLPrinting xlPrinting = new XLPrinting(isAppInterfaceAdv1.AppInterface, isMessageAdapter1);

            try
            {
                string vUserName = string.Format("{0}[{1}]", isAppInterfaceAdv1.AppInterface.LoginDescription, isAppInterfaceAdv1.DEPT_NAME);

                //-------------------------------------------------------------------------------------
                xlPrinting.OpenFileNameExcel = "HRMF0334_001.xls";
                //-------------------------------------------------------------------------------------

                //-------------------------------------------------------------------------------------
                vMessageText = string.Format("XL Open...");
                isAppInterfaceAdv1.OnAppMessage(vMessageText);
                System.Windows.Forms.Application.DoEvents();

                bool isOpen = xlPrinting.XLFileOpen();
                //-------------------------------------------------------------------------------------

                //-------------------------------------------------------------------------------------
                if (isOpen == true)
                {
                    vPageNumber = xlPrinting.LineWrite(pGrid, vUserName);

                    if (pOutChoice == "PRINT")
                    {
                        xlPrinting.Printing(1, vPageNumber);
                    }
                    else if (pOutChoice == "FILE")
                    {
                        xlPrinting.SAVE("DUTY_");
                    }

                    //-------------------------------------------------------------------------------------
                    xlPrinting.Dispose();
                    //-------------------------------------------------------------------------------------

                    vMessageText = string.Format("Printing End [Total Page : {0}]", vPageNumber);
                    isAppInterfaceAdv1.AppInterface.OnAppMessageEvent(vMessageText);
                    System.Windows.Forms.Application.DoEvents();
                }
                else
                {
                    vMessageText = "Excel File Open Error";
                    isAppInterfaceAdv1.AppInterface.OnAppMessageEvent(vMessageText);
                    System.Windows.Forms.Application.DoEvents();
                }
                //-------------------------------------------------------------------------------------
            }
            catch (System.Exception ex)
            {
                xlPrinting.Dispose();

                vMessageText = ex.Message;
                isAppInterfaceAdv1.AppInterface.OnAppMessageEvent(vMessageText);
                System.Windows.Forms.Application.DoEvents();
            }

            System.Windows.Forms.Application.UseWaitCursor = false;
            this.Cursor = System.Windows.Forms.Cursors.Default;
            System.Windows.Forms.Application.DoEvents();
        }

        #endregion;
    }
}