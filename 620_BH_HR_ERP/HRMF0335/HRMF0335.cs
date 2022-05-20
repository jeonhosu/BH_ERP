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

namespace HRMF0335
{
    public partial class HRMF0335 : Office2007Form
    {
        #region ----- Variables -----

        ISFunction.ISDateTime iDateTime = new ISFunction.ISDateTime();
        ISFunction.ISConvert iString = new ISFunction.ISConvert();

        private bool mIsFirst = false;

        #endregion;
        
        #region ----- Constructor -----

        public HRMF0335(Form pMainForm, ISAppInterface pAppInterface)
        {
            InitializeComponent();
            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;
        }

        #endregion;

        #region ----- Private Methods ----
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

            //작업장
            idcDEFAULT_FLOOR.ExecuteNonQuery();
            FLOOR_NAME_0.EditValue = idcDEFAULT_FLOOR.GetCommandParamValue("O_FLOOR_NAME");
            FLOOR_ID_0.EditValue = idcDEFAULT_FLOOR.GetCommandParamValue("O_FLOOR_ID");
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

            idaDUTY_PERIOD.OraSelectData.AcceptChanges();
            idaDUTY_PERIOD.Refillable = true;

            idaDUTY_PERIOD.SetSelectParamValue("W_SEARCH_TYPE", "W");
            idaDUTY_PERIOD.Fill();
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

        #endregion;

        #region ----- isAppInterfaceAdv1_AppMainButtonClick Events -----
        
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
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddUnder)
                {
                    if (idaDUTY_PERIOD.IsFocused)
                    {
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
            }
        }
        #endregion;

        #region ----- Form Event -----

        private void HRMF0335_Load(object sender, EventArgs e)
        {
            idaDUTY_PERIOD.FillSchema();
            iSTART_DATE_0.EditValue = DateTime.Today.AddDays(-7);
            iEND_DATE_0.EditValue = DateTime.Today.AddDays(7);
            
            // CORP SETTING
            DefaultCorporation();
            
            //LOOKUP SETTING
            ildAPPROVE_STATUS.SetLookupParamValue("W_GROUP_CODE", "DUTY_APPROVE_STATUS");
            ildAPPROVE_STATUS.SetLookupParamValue("W_ENABLED_FLAG_YN", "Y");
            ildSEARCH_TYPE.SetLookupParamValue("W_GROUP_CODE", "SEARCH_TYPE");
            ildSEARCH_TYPE.SetLookupParamValue("W_ENABLED_FLAG_YN", "Y");

            //DefaultSetFormReSize();		//[Child Form, Mdi Form에 맞게 ReSize]
            irbAPPR_A.CheckedState = ISUtil.Enum.CheckedState.Checked;
            EMAIL_STATUS.EditValue = "N";
        }

        private void HRMF0335_Shown(object sender, EventArgs e)
        {
            mIsFirst = true;
        }

        private void igrDUTY_PERIOD_CurrentCellValidating(object pSender, ISGridAdvExValidatingEventArgs e)
        {// 시작일자 또는 종료일자 변경시 근무계획 조회.
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
        }

        private void ibtOK_ButtonClick(object pSender, EventArgs pEventArgs)
        {// 승인
            // EMAIL STATUS.
            if (iString.ISNull(APPROVE_STATUS_0.EditValue) == "A".ToString())
            {
                EMAIL_STATUS.EditValue = "A_OK";
            }
            else if (iString.ISNull(APPROVE_STATUS_0.EditValue) == "B".ToString())
            {
                EMAIL_STATUS.EditValue = "B_OK";
            }
            else
            {
                EMAIL_STATUS.EditValue = "N";
            }

            idaDUTY_PERIOD.SetUpdateParamValue("P_APPROVE_FLAG", "OK");
            idaDUTY_PERIOD.Update();

            idaDUTY_PERIOD.Fill();
        }

        private void ibtCANCEL_ButtonClick(object pSender, EventArgs pEventArgs)
        {// 취소
            // EMAIL STATUS.
            if (iString.ISNull(APPROVE_STATUS_0.EditValue) == "A".ToString())
            {
                EMAIL_STATUS.EditValue = "A_CANCEL";
            }
            else if (iString.ISNull(APPROVE_STATUS_0.EditValue) == "B".ToString())
            {
                EMAIL_STATUS.EditValue = "B_CANCEL";
            }
            else if (iString.ISNull(APPROVE_STATUS_0.EditValue) == "C".ToString())
            {
                EMAIL_STATUS.EditValue = "C_CANCEL";
            }
            else
            {
                EMAIL_STATUS.EditValue = "N";
            }
            idaDUTY_PERIOD.SetUpdateParamValue("P_APPROVE_FLAG", "CANCEL");
            idaDUTY_PERIOD.Update();

            idaDUTY_PERIOD.Fill();
        }

        //반려
        private void btnRETURN_ButtonClick(object pSender, EventArgs pEventArgs)
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
            if (Convert.ToDateTime(iSTART_DATE_0.EditValue) > Convert.ToDateTime(iEND_DATE_0.EditValue))
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10012"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                iSTART_DATE_0.Focus();
                return;
            }

            Application.UseWaitCursor = true;
            this.Cursor = System.Windows.Forms.Cursors.WaitCursor;
            DialogResult dlgResultValue;
            Form vHRMF0335_RETURN = new HRMF0335_RETURN(isAppInterfaceAdv1.AppInterface
                                                        , CORP_ID_0.EditValue
                                                        , iSTART_DATE_0.EditValue
                                                        , iEND_DATE_0.EditValue
                                                        , APPROVE_STATUS_0.EditValue
                                                        , iDUTY_ID_0.EditValue
                                                        , FLOOR_ID_0.EditValue
                                                        , PERSON_ID_0.EditValue
                                                        );
            dlgResultValue = vHRMF0335_RETURN.ShowDialog();
            if (dlgResultValue == DialogResult.OK)
            {
            }
            vHRMF0335_RETURN.Dispose();

            isSearch_DB();
            this.Cursor = System.Windows.Forms.Cursors.Default;
            Application.UseWaitCursor = false;
        }

        private void irbSTATUS_CheckChanged(object sender, EventArgs e)
        {
            ISRadioButtonAdv iStatus = sender as ISRadioButtonAdv;
            APPROVE_STATUS_0.EditValue = iStatus.RadioCheckedString;

            if (mIsFirst == false)
            {
                return;
            }

            Set_BTN_STATE();

            isSearch_DB();
        }

        private void igrDUTY_PERIOD_CellDoubleClick(object pSender)
        {
            string mAPPROVE_STATE = iString.ISNull(APPROVE_STATUS_0.EditValue);
            if (mAPPROVE_STATE == String.Empty || mAPPROVE_STATE == "R")
            {
                return;
            }

            if (igrDUTY_PERIOD.RowIndex < 0 && igrDUTY_PERIOD.ColIndex == igrDUTY_PERIOD.GetColumnToIndex("APPROVE_YN"))
            {
                for (int r = 0; r < igrDUTY_PERIOD.RowCount; r++)
                {
                    if (iString.ISNull(igrDUTY_PERIOD.GetCellValue(r, igrDUTY_PERIOD.GetColumnToIndex("APPROVE_YN")), "N") == "Y".ToString())
                    {
                        igrDUTY_PERIOD.SetCellValue(r, igrDUTY_PERIOD.GetColumnToIndex("APPROVE_YN"), "N");
                    }
                    else
                    {
                        igrDUTY_PERIOD.SetCellValue(r, igrDUTY_PERIOD.GetColumnToIndex("APPROVE_YN"), "Y");
                    }
                }
            }
        }

        #endregion  

        #region ----- Adapter Event -----

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

        private void idaDUTY_PERIOD_UpdateCompleted(object pSender)
        {

            // EMAIL 발송.
            idcEMAIL_SEND.SetCommandParamValue("P_GUBUN", EMAIL_STATUS.EditValue);
            idcEMAIL_SEND.SetCommandParamValue("P_SOURCE_TYPE", "DUTY");
            idcEMAIL_SEND.SetCommandParamValue("P_CORP_ID", CORP_ID_0.EditValue);
            idcEMAIL_SEND.SetCommandParamValue("P_WORK_DATE", DateTime.Today);
            idcEMAIL_SEND.SetCommandParamValue("P_REQ_DATE", DateTime.Today);
            idcEMAIL_SEND.ExecuteNonQuery();
        }

        private void idaDUTY_PERIOD_PreDelete(ISPreDeleteEventArgs e)
        {
        }

        private void idaDUTY_PERIOD_NewRowMoved(object pSender, ISBindingEventArgs pBindingManager)
        {
            //if (igrDUTY_PERIOD.RowCount != 0)
            //{
                isSearch_WorkCalendar(igrDUTY_PERIOD.GetCellValue("PERSON_ID"), igrDUTY_PERIOD.GetCellValue("START_DATE"), igrDUTY_PERIOD.GetCellValue("END_DATE"));
            //}
        }

        #endregion

        #region ----- LookUp Event -----
        private void ilaAPPROVE_STATUS_0_SelectedRowData(object pSender)
        {
            idaDUTY_PERIOD.Fill();
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
            ildPERIOD_TIME.SetLookupParamValue("W_START_YN", "Y".ToString());
            ildPERIOD_TIME.SetLookupParamValue("W_END_YN", null);
        }

        private void ilaEND_TIME_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildPERIOD_TIME.SetLookupParamValue("W_WORK_DATE", igrDUTY_PERIOD.GetCellValue("END_DATE"));
            ildPERIOD_TIME.SetLookupParamValue("W_START_YN", null);
            ildPERIOD_TIME.SetLookupParamValue("W_END_YN", "Y".ToString());
        }

        private void ilaFLOOR_1_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildFLOOR_1.SetLookupParamValue("W_GROUP_CODE", "FLOOR");
            ildFLOOR_1.SetLookupParamValue("W_ENABLED_FLAG_YN", "Y");
        }

        #endregion

        #region ----- Button Event -----

        private void Set_BTN_STATE()
        {
            string mAPPROVE_STATE = iString.ISNull(APPROVE_STATUS_0.EditValue);
            int mIDX_SELECT_YN = igrDUTY_PERIOD.GetColumnToIndex("APPROVE_YN");
            if (mAPPROVE_STATE == String.Empty || mAPPROVE_STATE == "R")
            {
                btnOK.Enabled = false;
                btnCANCEL.Enabled = false;
                btnRETURN.Enabled = false;

                igrDUTY_PERIOD.GridAdvExColElement[mIDX_SELECT_YN].Updatable = 0;
            }
            else
            {
                btnOK.Enabled = true;
                btnCANCEL.Enabled = true;
                btnRETURN.Enabled = true;

                igrDUTY_PERIOD.GridAdvExColElement[mIDX_SELECT_YN].Updatable = 1;
            }
        }

        #endregion

        #region ----- Edit Event -----

        private void iSTART_DATE_0_EditValueChanged(object pSender)
        {
            System.DateTime vDate = iSTART_DATE_0.DateTimeValue;
            iEND_DATE_0.EditValue = vDate.AddDays(14);
        }

        #endregion
    }
}