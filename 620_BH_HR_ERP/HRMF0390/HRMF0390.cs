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

namespace HRMF0390
{
    public partial class HRMF0390 : Office2007Form
    {
        #region ----- Variables -----

        private ISCommonUtil.ISFunction.ISDateTime iSDate = new ISCommonUtil.ISFunction.ISDateTime();
        private ISCommonUtil.ISFunction.ISConvert iString = new ISCommonUtil.ISFunction.ISConvert();

        private ISCommonUtil.ISFunction.ISDateTime mGetDate = new ISCommonUtil.ISFunction.ISDateTime();

        private bool mFirst = false;

        #endregion;

        #region ----- Constructor -----

        public HRMF0390(Form pMainForm, ISAppInterface pAppInterface)
        {
            InitializeComponent();
            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;
        }

        #endregion;

        #region ----- Default Set Method ----

        private void DefaultSetFormReSize()
        {//[Child Form, Mdi Form에 맞게 ReSize]
            int vMinusWidth = 4;
            int vMinusHeight = 54;
            System.Drawing.Size vSize = this.MdiParent.ClientSize;
            this.Width = vSize.Width - vMinusWidth;
            this.Height = vSize.Height - vMinusHeight;
        }

        //업체
        private void DefaultCorporation()
        {
            // Lookup SETTING
            ildCORP.SetLookupParamValue("W_DUTY_CONTROL_YN", "Y");
            ildCORP.SetLookupParamValue("W_ENABLED_FLAG_YN", "N");

            // LOOKUP DEFAULT VALUE SETTING - CORP
            idcDEFAULT_CORP.SetCommandParamValue("W_DUTY_CONTROL_YN", "Y");
            idcDEFAULT_CORP.SetCommandParamValue("W_ENABLED_FLAG_YN", "N");
            idcDEFAULT_CORP.ExecuteNonQuery();
            CORP_NAME_1.EditValue = idcDEFAULT_CORP.GetCommandParamValue("O_CORP_NAME");
            CORP_ID_1.EditValue = idcDEFAULT_CORP.GetCommandParamValue("O_CORP_ID");

            CORP_NAME_2.EditValue = idcDEFAULT_CORP.GetCommandParamValue("O_CORP_NAME");
            CORP_ID_2.EditValue = idcDEFAULT_CORP.GetCommandParamValue("O_CORP_ID");
        }

        //작업장
        private void DefaultFloor()
        {
            idcDEFAULT_FLOOR.ExecuteNonQuery();
            object vObject_FLOOR_NAME = idcDEFAULT_FLOOR.GetCommandParamValue("O_FLOOR_NAME"); //작업장명
            object vObject_FLOOR_ID = idcDEFAULT_FLOOR.GetCommandParamValue("O_FLOOR_ID"); //작업장_ID

            object oPERSON_NUMBER = idcDEFAULT_FLOOR.GetCommandParamValue("O_PERSON_NUMBER"); //사원번호
            object oPERSON_NAME = idcDEFAULT_FLOOR.GetCommandParamValue("O_PERSON_NAME"); //사원명
            object oWORK_TYPE_ID = idcDEFAULT_FLOOR.GetCommandParamValue("O_WORK_TYPE_ID"); //교대유형_ID
            object oWORK_TYPE_NAME = idcDEFAULT_FLOOR.GetCommandParamValue("O_WORK_TYPE_NAME"); //교대유형_명
            object oCAPACITY = idcDEFAULT_FLOOR.GetCommandParamValue("O_CAPACITY"); //권한

            FLOOR_NAME_1.EditValue = vObject_FLOOR_NAME;
            FLOOR_ID_1.EditValue = vObject_FLOOR_ID;

            FLOOR_NAME_2.EditValue = vObject_FLOOR_NAME;
            FLOOR_ID_2.EditValue = vObject_FLOOR_ID;

            FLOOR_NAME_3.EditValue = vObject_FLOOR_NAME;
            FLOOR_ID_3.EditValue = vObject_FLOOR_ID;
        }

        #endregion;

        #region ----- Search Method ----

        private void Search_DB_1(string pRadioCheckedString)
        {
            ISCommonUtil.ISFunction.ISConvert vString = new ISCommonUtil.ISFunction.ISConvert();

            if (CORP_ID_1.EditValue == null)
            {// 업체.
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10001"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                CORP_NAME_1.Focus();
                return;
            }
            if (WORK_DATE_FR_1.EditValue == null)
            {// 근무일자
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10010"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                WORK_DATE_FR_1.Focus();
                return;
            }
            if (WORK_DATE_TO_1.EditValue == null)
            {// 근무일자
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10010"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                WORK_DATE_TO_1.Focus();
                return;
            }
            object vObject1 = FLOOR_NAME_1.EditValue;
            object vObject2 = WORK_TYPE_NAME_1.EditValue;
            object vObject3 = PERSON_NAME_1.EditValue;
            if (vString.ISNull(vObject1) == string.Empty && vString.ISNull(vObject2) == string.Empty && vString.ISNull(vObject3) == string.Empty)
            {
                //검색 조건을 선택 하세요!
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10305"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }

            idaDAY_INTERFACE_TRANS_1.OraSelectData.AcceptChanges();
            idaDAY_INTERFACE_TRANS_1.Refillable = true;

            this.Cursor = Cursors.WaitCursor;
            this.UseWaitCursor = true;
            idaDAY_INTERFACE_TRANS_1.SetSelectParamValue("W_CONNECT_LEVEL", "A");
            idaDAY_INTERFACE_TRANS_1.SetSelectParamValue("W_SORT", pRadioCheckedString);
            idaDAY_INTERFACE_TRANS_1.Fill();
            igrDAY_INTERFACE_1.Focus();
            this.Cursor = Cursors.Default;
            this.UseWaitCursor = false;
        }

        private void Search_DB_2()
        {
            ISCommonUtil.ISFunction.ISConvert vString = new ISCommonUtil.ISFunction.ISConvert();

            if (CORP_ID_2.EditValue == null)
            {// 업체.
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10001"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                CORP_NAME_2.Focus();
                return;
            }
            if (WORK_DATE_FR_2.EditValue == null)
            {// 근무일자
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10010"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                WORK_DATE_FR_2.Focus();
                return;
            }
            if (WORK_DATE_TO_2.EditValue == null)
            {// 근무일자
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10010"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                WORK_DATE_TO_2.Focus();
                return;
            }
            object vObject1 = FLOOR_NAME_2.EditValue;
            object vObject2 = WORK_TYPE_NAME_2.EditValue;
            object vObject3 = PERSON_NAME_2.EditValue;
            if (vString.ISNull(vObject1) == string.Empty && vString.ISNull(vObject2) == string.Empty && vString.ISNull(vObject3) == string.Empty)
            {
                //검색 조건을 선택 하세요!
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10305"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }

            this.Cursor = Cursors.WaitCursor;
            this.UseWaitCursor = true;
            idaDAY_INTERFACE_TRANS_2.Fill();

            object vObject_1 = idaDAY_INTERFACE_TRANS_2.GetSelectParamValue("W_CORP_ID");
            object vObject_2 = idaDAY_INTERFACE_TRANS_2.GetSelectParamValue("W_WORK_DATE_FR");
            object vObject_3 = idaDAY_INTERFACE_TRANS_2.GetSelectParamValue("W_WORK_DATE_TO");
            object vObject_4 = idaDAY_INTERFACE_TRANS_2.GetSelectParamValue("W_WORK_TYPE_ID");
            object vObject_5 = idaDAY_INTERFACE_TRANS_2.GetSelectParamValue("W_FLOOR_ID");
            object vObject_6 = idaDAY_INTERFACE_TRANS_2.GetSelectParamValue("W_PERSON_ID");
            object vObject_7 = idaDAY_INTERFACE_TRANS_2.GetSelectParamValue("W_CONNECT_PERSON_ID");
            object vObject_8 = idaDAY_INTERFACE_TRANS_2.GetSelectParamValue("W_SOB_ID");
            object vObject_9 = idaDAY_INTERFACE_TRANS_2.GetSelectParamValue("W_ORG_ID");

            igrDAY_INTERFACE_2.Focus();
            this.Cursor = Cursors.Default;
            this.UseWaitCursor = false;
        }

        private void Search_DB_3()
        {
            ISCommonUtil.ISFunction.ISConvert vString = new ISCommonUtil.ISFunction.ISConvert();

            if (WORK_DATE_FR_3.EditValue == null)
            {// 근무일자
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10010"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                WORK_DATE_FR_3.Focus();
                return;
            }
            if (WORK_DATE_TO_3.EditValue == null)
            {// 근무일자
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10010"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                WORK_DATE_TO_3.Focus();
                return;
            }

            this.Cursor = Cursors.WaitCursor;
            this.UseWaitCursor = true;
            idaDAY_INTERFACE_TRANS_3.Fill();

            object vObject_1 = idaDAY_INTERFACE_TRANS_3.GetSelectParamValue("W_CORP_ID");
            object vObject_2 = idaDAY_INTERFACE_TRANS_3.GetSelectParamValue("W_WORK_DATE_FR");
            object vObject_3 = idaDAY_INTERFACE_TRANS_3.GetSelectParamValue("W_WORK_DATE_TO");
            object vObject_4 = idaDAY_INTERFACE_TRANS_3.GetSelectParamValue("W_WORK_TYPE_ID");
            object vObject_5 = idaDAY_INTERFACE_TRANS_3.GetSelectParamValue("W_FLOOR_ID");
            object vObject_6 = idaDAY_INTERFACE_TRANS_3.GetSelectParamValue("W_PERSON_ID");
            object vObject_8 = idaDAY_INTERFACE_TRANS_3.GetSelectParamValue("W_SOB_ID");
            object vObject_9 = idaDAY_INTERFACE_TRANS_3.GetSelectParamValue("W_ORG_ID");

            igrDAY_INTERFACE_3.Focus();
            this.Cursor = Cursors.Default;
            this.UseWaitCursor = false;
        }

        private void isSearch_WorkCalendar(Object pPerson_ID, Object pWork_Date)
        {
            ISFunction.ISConvert iConvert = new ISFunction.ISConvert();
            if (iConvert.ISNull(pWork_Date) == string.Empty)
            {
                return;
            }
            WORK_DATE_8.EditValue = WORK_DATE_FR_1.EditValue;

            idaWORK_CALENDAR.SetSelectParamValue("W_END_DATE", pWork_Date);
            idaDAY_HISTORY.Fill();
            idaDUTY_PERIOD.Fill();
            idaWORK_CALENDAR.Fill();
        }

        private void isSearch_Day_History(int pAdd_Day)
        {
            ISFunction.ISConvert iConvert = new ISFunction.ISConvert();
            if (iConvert.ISNull(WORK_DATE_8.EditValue) == string.Empty)
            {
                return;
            }
            WORK_DATE_8.EditValue = Convert.ToDateTime(WORK_DATE_8.EditValue).AddDays(pAdd_Day);
            idaDAY_HISTORY.Fill();
        }

        #endregion;

        #region ----- MDi TooBar Button Events -----

        private void isAppInterfaceAdv1_AppMainButtonClick(ISAppButtonEvents e)
        {
            if (this.IsActive)
            {
                if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Search)
                {
                    int vIndexTAB = isTab.SelectedIndex;

                    if (vIndexTAB == 0)
                    {
                        Search_DB_1("A");
                    }
                    else if (vIndexTAB == 1)
                    {
                        Search_DB_2();
                    }
                    else if (vIndexTAB == 2)
                    {
                        Search_DB_3();
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
                    if (idaDAY_INTERFACE_TRANS_2.IsFocused)
                    {
                        try
                        {
                            idaDAY_INTERFACE_TRANS_2.Update();
                        }
                        catch (System.Exception ex)
                        {
                            MessageBoxAdv.Show(ex.Message, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                        }
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Cancel)
                {
                    if (idaDAY_INTERFACE_TRANS_1.IsFocused)
                    {
                        idaDAY_INTERFACE_TRANS_1.Cancel();
                    }
                    else if (idaDAY_INTERFACE_TRANS_2.IsFocused)
                    {
                        idaDAY_INTERFACE_TRANS_2.Cancel();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Print)
                {
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Export)
                {
                }
            }
        }
        #endregion;

        #region ----- Form Event -----

        private void HRMF0390_Load(object sender, EventArgs e)
        {
            ISCommonUtil.ISFunction.ISDateTime vGetDate = new ISCommonUtil.ISFunction.ISDateTime();
            System.DateTime vDate = vGetDate.ISGetDate();

            WORK_DATE_FR_1.EditValue = vGetDate.ISMonth_1st(vDate);
            WORK_DATE_TO_1.EditValue = mGetDate.ISMonth_Last(vDate);

            WORK_DATE_FR_2.EditValue = DateTime.Today;
            WORK_DATE_TO_2.EditValue = DateTime.Today;

            WORK_DATE_FR_3.EditValue = vGetDate.ISMonth_1st(vDate);
            WORK_DATE_TO_3.EditValue = mGetDate.ISMonth_Last(vDate);

            SET_DATE_1.EditValue = DateTime.Today;
            SET_DATE_2.EditValue = DateTime.Today;
            SET_DATE_3.EditValue = DateTime.Today;

            idaDAY_INTERFACE_TRANS_1.FillSchema();

            idaDAY_INTERFACE_TRANS_2.FillSchema();
            
            //업체
            DefaultCorporation();

            //작업장
            DefaultFloor();
        }

        private void HRMF0390_Shown(object sender, EventArgs e)
        {
            irbTRANS_N_1.CheckedState = ISUtil.Enum.CheckedState.Checked;

            isAppInterfaceAdv1.AppInterface.OnAppMessageEvent("");
            System.Windows.Forms.Application.DoEvents();
        }

        #endregion

        #region ----- TRANSFER Event -----

        private void irbSTATUS_CheckChanged(object sender, EventArgs e)
        {
            ISRadioButtonAdv isINOUT = sender as ISRadioButtonAdv;
            TRANSFER_YN_1.EditValue = isINOUT.RadioCheckedString;

            // refill.
            if (mFirst == true)
            {
                Search_DB_1("A");
            }

            mFirst = true;
        }

        #endregion

        #region ----- Button Event -----

        //출퇴근 조회 : 출퇴근집계
        private void ibtSET_DAY_INTERFACE_ButtonClick(object pSender, EventArgs pEventArgs)
        {// 출퇴근 집계

            string mMessage;

            if (CORP_ID_1.EditValue == null)
            {// 업체.
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10001"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                CORP_NAME_1.Focus();
                return;
            }
            if (SET_DATE_1.EditValue == null)
            {// 근무일자
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10010"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                SET_DATE_1.Focus();
                return;
            }

            idcSET_DAY_INTERFACE.SetCommandParamValue("P_CONNECT_LEVEL", "C");
            idcSET_DAY_INTERFACE.SetCommandParamValue("P_WORK_DATE", SET_DATE_1.EditValue);
            idcSET_DAY_INTERFACE.ExecuteNonQuery();
            mMessage = idcSET_DAY_INTERFACE.GetCommandParamValue("O_MESSAGE").ToString();
            MessageBoxAdv.Show(mMessage, "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);

            Search_DB_1("A");
        }

        //출퇴근 수정 : 출퇴근집계
        private void ibtnSET_DAY_INTERFACE_2_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            string mMessage;

            if (CORP_ID_2.EditValue == null)
            {// 업체.
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10001"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                CORP_NAME_2.Focus();
                return;
            }
            if (SET_DATE_2.EditValue == null)
            {// 근무일자
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10010"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                SET_DATE_2.Focus();
                return;
            }

            idcSET_DAY_INTERFACE.SetCommandParamValue("P_CONNECT_LEVEL", "C");
            idcSET_DAY_INTERFACE.SetCommandParamValue("P_WORK_DATE", SET_DATE_2.EditValue);
            idcSET_DAY_INTERFACE.ExecuteNonQuery();
            mMessage = idcSET_DAY_INTERFACE.GetCommandParamValue("O_MESSAGE").ToString();
            MessageBoxAdv.Show(mMessage, "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);

            Search_DB_2();
        }

        //중복퇴근 조회 : 출퇴근집계
        private void ibtnSET_DAY_INTERFACE_3_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            string mMessage;

            if (CORP_ID_3.EditValue == null)
            {// 업체.
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10001"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                CORP_NAME_3.Focus();
                return;
            }
            if (SET_DATE_3.EditValue == null)
            {// 근무일자
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10010"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                SET_DATE_3.Focus();
                return;
            }

            idcSET_DAY_INTERFACE.SetCommandParamValue("P_CONNECT_LEVEL", "C");
            idcSET_DAY_INTERFACE.SetCommandParamValue("P_WORK_DATE", SET_DATE_2.EditValue);
            idcSET_DAY_INTERFACE.ExecuteNonQuery();
            mMessage = idcSET_DAY_INTERFACE.GetCommandParamValue("O_MESSAGE").ToString();
            MessageBoxAdv.Show(mMessage, "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);

            Search_DB_3();
        }

        private void ibtnUP_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            isSearch_Day_History(1);
        }

        private void ibtnDOWN_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            isSearch_Day_History(-1);
        }

        #endregion

        #region ----- Adapter Event -----
        private void idaDAY_INTERFACE_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {
            if (e.Row["PERSON_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Person ID(사원 정보)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
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
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Corporation Name(업체)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
        }

        private void idaDAY_INTERFACE_PreDelete(ISPreDeleteEventArgs e)
        {            
        }

        private void idaDAY_INTERFACE_NewRowMoved(object pSender, ISBindingEventArgs pBindingManager)
        {
            isSearch_WorkCalendar(igrDAY_INTERFACE_1.GetCellValue("PERSON_ID"), igrDAY_INTERFACE_1.GetCellValue("WORK_DATE"));
        }

        #endregion

        #region ----- LookUp Event -----

        private void ildWORK_TYPE_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", "WORK_TYPE");
            ildCOMMON.SetLookupParamValue("W_ENABLED_FLAG_YN", "N");
        }

        private void ilaFLOOR_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildFLOOR_0.SetLookupParamValue("W_GROUP_CODE", "FLOOR");
            ildFLOOR_0.SetLookupParamValue("W_ENABLED_FLAG_YN", "N");
        }

        private void ilaDUTY_MODIFY_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", "DUTY_MODIFY");
            ildCOMMON.SetLookupParamValue("W_ENABLED_FLAG_YN", "Y");
        }

        private void ilaWORK_TYPE_1_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", "WORK_TYPE");
            ildCOMMON.SetLookupParamValue("W_ENABLED_FLAG_YN", "N");
        }

        private void ilaFLOOR_1_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildFLOOR_0.SetLookupParamValue("W_GROUP_CODE", "FLOOR");
            ildFLOOR_0.SetLookupParamValue("W_ENABLED_FLAG_YN", "N");
        }

        private void ilaWORK_TYPE_2_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", "WORK_TYPE");
            ildCOMMON.SetLookupParamValue("W_ENABLED_FLAG_YN", "N");
        }

        private void ilaFLOOR_2_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildFLOOR_0.SetLookupParamValue("W_GROUP_CODE", "FLOOR");
            ildFLOOR_0.SetLookupParamValue("W_ENABLED_FLAG_YN", "N");
        }

        #endregion

        #region ----- Radio Button Event -----

        private void SORT_CheckChanged(object sender, EventArgs e)
        {
            InfoSummit.Win.ControlAdv.ISRadioButtonAdv vRadio = sender as InfoSummit.Win.ControlAdv.ISRadioButtonAdv;

            if (vRadio.Checked == true)
            {
                string vStringGet = vRadio.RadioCheckedString;

                Search_DB_1(vStringGet);
            }
        }

        #endregion

        #region ----- Edit Event -----

        private void WORK_DATE_FR_EditValueChanged(object pSender)
        {
            System.DateTime vDate = WORK_DATE_FR_1.DateTimeValue;
            WORK_DATE_TO_1.EditValue = mGetDate.ISMonth_Last(vDate);
        }

        private void SET_DATE_2_EditValueChanged(object pSender)
        {
            WORK_DATE_FR_2.EditValue = SET_DATE_2.EditValue;
            WORK_DATE_TO_2.EditValue = SET_DATE_2.EditValue;
        }

        private void WORK_DATE_FR_2_EditValueChanged(object pSender)
        {
            WORK_DATE_TO_2.EditValue = WORK_DATE_FR_2.EditValue;
        }

        private void WORK_DATE_FR_3_EditValueChanged(object pSender)
        {
            System.DateTime vDate = WORK_DATE_FR_3.DateTimeValue;
            WORK_DATE_TO_3.EditValue = mGetDate.ISMonth_Last(vDate);
        }

        #endregion
    }
}