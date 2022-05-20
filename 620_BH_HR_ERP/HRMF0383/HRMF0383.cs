using System;
using System.Data;
using System.Drawing;
using System.Windows.Forms;
using System.Collections.Generic;

using Syncfusion.Windows.Forms;
using Syncfusion.Windows.Forms.Tools;
using Syncfusion.Windows.Forms.Grid;
using InfoSummit.Win.ControlAdv;

namespace HRMF0383
{
    public partial class HRMF0383 : Office2007Form
    {
        #region ----- Variables -----

        private ISCommonUtil.ISFunction.ISConvert iConv = new ISCommonUtil.ISFunction.ISConvert();
        private ISCommonUtil.ISFunction.ISDateTime ISDate = new ISCommonUtil.ISFunction.ISDateTime();

        #endregion;

        #region ----- Constructor -----

        public HRMF0383()
        {
            InitializeComponent();
        }

        public HRMF0383(Form pMainForm, ISAppInterface pAppInterface)
        {
            InitializeComponent();
            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;
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
                        SearchWorkType();
                    }
                    else if (vIndexTAB == 2)
                    {
                        SearchFloor(); 
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
                    if (idaMODIFY_WORK_TYPE.IsFocused)
                    {
                        MODIFY_WORK_TYPE_Save();
                    }
                    else if (idaWORK_CALENDAR.IsFocused)
                    {
                        idaWORK_CALENDAR.Update();
                    }
                    else if (idaMODIFY_FLOOR.IsFocused)
                    {
                        MODIFY_FLOOR_Save();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Cancel)
                {
                    
                    if (idaMODIFY_WORK_TYPE.IsFocused)
                    {
                        idaMODIFY_WORK_TYPE.Cancel();
                    }
                    else if (idaWORK_CALENDAR.IsFocused)
                    {
                        idaWORK_CALENDAR.Cancel();
                    }
                    else if (idaMODIFY_FLOOR.IsFocused)
                    {
                        idaMODIFY_FLOOR.Cancel();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {
                    if (idaMODIFY_HISTORY_0.IsFocused)
                    {
                        Delete_WORK_TYPE();
                    }
                    else if (idaMODIFY_HISTORY_1.IsFocused)
                    {
                        Delete_FLOOR();
                    }
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
            catch (System.Exception ex)
            {
                isAppInterfaceAdv1.OnAppMessage(ex.Message);
                System.Windows.Forms.Application.DoEvents();
            }

            return vDateTime;
        }

        #endregion;

        #region ----- Private Method ----

        private void DefaultCorporation()
        {
            STD_DATE_0.EditValue = System.DateTime.Today;
            STD_DATE_1.EditValue = System.DateTime.Today;

            //System.DateTime vDate = new System.DateTime(2011, 7, 14);
            //STD_DATE_0.EditValue = vDate;
            //STD_DATE_1.EditValue = vDate;

            // 조회년월 SETTING
            ildYYYYMM_0.SetLookupParamValue("W_START_YYYYMM", "2010-01");

            //WORK_YYYYMM_2.EditValue = ISDate.ISYearMonth(DateTime.Today);
            WORK_YYYYMM_2.EditValue = ISDate.ISYearMonth(STD_DATE_0.DateTimeValue);
            idcYYYYMM_TERM.SetCommandParamValue("W_YYYYMM", WORK_YYYYMM_2.EditValue);
            idcYYYYMM_TERM.ExecuteNonQuery();
            DATE_SEARCH_START_1.EditValue = idcYYYYMM_TERM.GetCommandParamValue("O_START_DATE");
            DATE_CREATE_START_2.EditValue = STD_DATE_0.DateTimeValue;
            DATE_CREATE_END_2.EditValue = idcYYYYMM_TERM.GetCommandParamValue("O_END_DATE");

            // Lookup SETTING
            ildCORP_0.SetLookupParamValue("W_DUTY_CONTROL_YN", "Y");
            ildCORP_0.SetLookupParamValue("W_ENABLED_FLAG_YN", "N");

            // LOOKUP DEFAULT VALUE SETTING - CORP
            idcDEFAULT_CORP.SetCommandParamValue("W_DUTY_CONTROL_YN", "Y");
            idcDEFAULT_CORP.SetCommandParamValue("W_ENABLED_FLAG_YN", "N");
            idcDEFAULT_CORP.ExecuteNonQuery();
            CORP_NAME_0.EditValue = idcDEFAULT_CORP.GetCommandParamValue("O_CORP_NAME");
            CORP_ID_0.EditValue = idcDEFAULT_CORP.GetCommandParamValue("O_CORP_ID");
            CORP_NAME_1.EditValue = idcDEFAULT_CORP.GetCommandParamValue("O_CORP_NAME");
            CORP_ID_1.EditValue = idcDEFAULT_CORP.GetCommandParamValue("O_CORP_ID");

            //작업장
            idcDEFAULT_FLOOR.ExecuteNonQuery();
            FLOOR_NAME_0.EditValue = idcDEFAULT_FLOOR.GetCommandParamValue("O_FLOOR_NAME");
            FLOOR_ID_0.EditValue = idcDEFAULT_FLOOR.GetCommandParamValue("O_FLOOR_ID");
            FLOOR_NAME_1.EditValue = idcDEFAULT_FLOOR.GetCommandParamValue("O_FLOOR_NAME");
            FLOOR_ID_1.EditValue = idcDEFAULT_FLOOR.GetCommandParamValue("O_FLOOR_ID");

            object oPERSON_NAME = idcDEFAULT_FLOOR.GetCommandParamValue("O_PERSON_NAME");
            object oCAPACITY = idcDEFAULT_FLOOR.GetCommandParamValue("O_CAPACITY"); //권한
            string vCAPACITY = ConvertString(oCAPACITY);


            //FLOOR_NAME_0.EditValue = "후가공";
            //FLOOR_ID_0.EditValue = 3707;

            //FLOOR_NAME_1.EditValue = "후가공";
            //FLOOR_ID_1.EditValue = 3707;


            
            ////인사담당자이면 -- 담당자의 담당하는 작업장만 보게 하려고
            //if (vCAPACITY == "C")
            //{
            //    FLOOR_NAME_0.ReadOnly = false;
            //    isGroupBox1.PromptTextElement[0].TL1_KR = string.Format("{0} - {1}[{2}]", isGroupBox1.PromptText, oPERSON_NAME, "인사담당");
            //}
            //else
            //{
            //    FLOOR_NAME_0.ReadOnly = true;
            //    isGroupBox1.PromptTextElement[0].TL1_KR = string.Format("{0} - {1}[{2}]", isGroupBox1.PromptText, oPERSON_NAME, FLOOR_NAME_0.EditValue);
            //}
        }

        private void DefaultEmploye()
        {
            idcDEFAULT_EMPLOYE_TYPE_0.SetCommandParamValue("W_GROUP_CODE", "EMPLOYE_TYPE");
            idcDEFAULT_EMPLOYE_TYPE_0.ExecuteNonQuery();
            EMPLOYE_TYPE_NAME_0.EditValue = idcDEFAULT_EMPLOYE_TYPE_0.GetCommandParamValue("O_CODE_NAME");
            EMPLOYE_TYPE_0.EditValue = idcDEFAULT_EMPLOYE_TYPE_0.GetCommandParamValue("O_CODE");

            EMPLOYE_TYPE_NAME_1.EditValue = idcDEFAULT_EMPLOYE_TYPE_0.GetCommandParamValue("O_CODE_NAME");
            EMPLOYE_TYPE_1.EditValue = idcDEFAULT_EMPLOYE_TYPE_0.GetCommandParamValue("O_CODE");
        }

        private void SetCommonParameter(object pGroup_Code, object pEnabled_YN)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", pGroup_Code);
            ildCOMMON.SetLookupParamValue("W_ENABLED_YN", pEnabled_YN);
        }

        private void SearchFloor()
        {
            ISCommonUtil.ISFunction.ISConvert vString = new ISCommonUtil.ISFunction.ISConvert();

            object vObject1 = FLOOR_NAME_1.EditValue;
            object vObject2 = PERSON_NAME_1.EditValue;
            if (vString.ISNull(vObject1) == string.Empty && vString.ISNull(vObject2) == string.Empty)
            {
                //검색 조건을 선택 하세요!
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10305"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }

            try
            {
                idaMODIFY_FLOOR.Fill();
            }
            catch(System.Exception ex)
            {
                isAppInterfaceAdv1.OnAppMessage(ex.Message);
                System.Windows.Forms.Application.DoEvents();
            }
        }

        private void SearchWorkType()
        {
            ISCommonUtil.ISFunction.ISConvert vString = new ISCommonUtil.ISFunction.ISConvert();

            object vObject1 = FLOOR_NAME_0.EditValue;
            object vObject2 = WORK_TYPE_NAME_0.EditValue;
            object vObject3 = PERSON_NAME_0.EditValue;
            if (vString.ISNull(vObject1) == string.Empty && vString.ISNull(vObject2) == string.Empty && vString.ISNull(vObject3) == string.Empty)
            {
                //검색 조건을 선택 하세요!
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10305"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }

            try
            {
                idaMODIFY_WORK_TYPE.Fill();
            }
            catch (System.Exception ex)
            {
                isAppInterfaceAdv1.OnAppMessage(ex.Message);
                System.Windows.Forms.Application.DoEvents();
            }
        }

        #endregion;

        #region ----- Form Event -----

        private void HRMF0383_Load(object sender, EventArgs e)
        {
            DefaultCorporation();
            DefaultEmploye();

            idaMODIFY_WORK_TYPE.FillSchema();
        }

        private void HRMF0383_Shown(object sender, EventArgs e)
        {
        }

        #endregion;

        #region ----- Grid Event ----

        private void igrPERSON_INFO_CellDoubleClick(object pSender)
        {
            isTAB.SelectedIndex = 1;
        }

        #endregion;

        #region ----- Method Event -----

        private void MODIFY_WORK_TYPE_Save()
        {
            string vMessage = string.Empty;

            idaMODIFY_WORK_TYPE.Update();

            object vObject = O_SUCCESS_FLAG_0.EditValue;
            string vSuccess = ConvertString(vObject);

            if (vSuccess == "Y")
            {
                try
                {
                    //FCM_10296 //근무 계획표 수정 하였습니다.
                    //FCM_10341 //다시 조회를 하십시오!
                    vMessage = string.Format("{0}\n\n{1}", O_MESSAGE_0.EditValue, isMessageAdapter1.ReturnText("FCM_10341"));
                    MessageBoxAdv.Show(vMessage, "Information", MessageBoxButtons.OK, MessageBoxIcon.Information);
                }
                catch (System.Exception ex)
                {
                    MessageBoxAdv.Show(ex.Message, "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                }
            }
            else 
            {
                try
                {
                    vMessage = string.Format("{0}", O_MESSAGE_0.EditValue);
                    MessageBoxAdv.Show(vMessage, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
                catch (System.Exception ex)
                {
                    MessageBoxAdv.Show(ex.Message, "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                }
            }
        }

        private void MODIFY_FLOOR_Save()
        {
            string vMessage = string.Empty;
            idaMODIFY_FLOOR.Update();

            object vObject = O_SUCCESS_FLAG_2.EditValue;
            string vSuccess = ConvertString(vObject);

            if (vSuccess == "Y")
            {

                try
                {
                    //FCM_10344 //작업장을 수정 하였습니다.
                    //FCM_10341 //다시 조회를 하십시오!
                    vMessage = string.Format("{0}\n\n{1}", isMessageAdapter1.ReturnText("FCM_10344"), isMessageAdapter1.ReturnText("FCM_10341"));
                    MessageBoxAdv.Show(vMessage, "Information", MessageBoxButtons.OK, MessageBoxIcon.Information);
                }
                catch (System.Exception ex)
                {
                    MessageBoxAdv.Show(ex.Message, "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                }
            }
            else
            {
                try
                {
                    vMessage = string.Format("{0}", O_MESSAGE_2.EditValue);
                    MessageBoxAdv.Show(vMessage, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
                catch (System.Exception ex)
                {
                    MessageBoxAdv.Show(ex.Message, "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                }
            }
        }

        private void Delete_WORK_TYPE()
        {
            string vMessage = string.Empty;

            object vObject = igrMODIFY_HISTORY_WORKTYPE.GetCellValue("LAST_YN");
            string vLastYN = ConvertString(vObject);

            int vCountRow = igrMODIFY_HISTORY_WORKTYPE.RowCount;

            if (vLastYN == "Y" && vCountRow > 1)
            {
                System.Windows.Forms.DialogResult vChoice;

                object vObject_PERSON_NAME = igrMODIFY_HISTORY_WORKTYPE.GetCellValue("PERSON_NAME");
                object vObject_PERSON_NUMBER = igrMODIFY_HISTORY_WORKTYPE.GetCellValue("PERSON_NUMBER");
                object vObject_WORK_TYPE_NAME = igrMODIFY_HISTORY_WORKTYPE.GetCellValue("H_WORK_TYPE_NAME");
                object vObject_EFFECTIVE_DATE_FR = igrMODIFY_HISTORY_WORKTYPE.GetCellValue("EFFECTIVE_DATE_FR");

                string vPERSON_NAME = ConvertString(vObject_PERSON_NAME);
                string vPERSON_NUMBER = ConvertString(vObject_PERSON_NUMBER);
                string vWORK_TYPE_NAME = ConvertString(vObject_WORK_TYPE_NAME);
                System.DateTime vEFFECTIVE_DATE_FR = ConvertDateTime(vObject_EFFECTIVE_DATE_FR);

                //삭제 하시겠습니까?
                vMessage = string.Format("{0}[{1}]\n{2}\n{3}\n\n{4}", vPERSON_NAME, vPERSON_NUMBER, vWORK_TYPE_NAME, vEFFECTIVE_DATE_FR.ToShortDateString(), isMessageAdapter1.ReturnText("EAPP_10030"));

                vChoice = MessageBoxAdv.Show(vMessage, "Delete", System.Windows.Forms.MessageBoxButtons.YesNo, System.Windows.Forms.MessageBoxIcon.Question, System.Windows.Forms.MessageBoxDefaultButton.Button2);

                if (vChoice == System.Windows.Forms.DialogResult.Yes)
                {
                    try
                    {
                        object vW_WORK_CORP_ID = igrMODIFY_HISTORY_WORKTYPE.GetCellValue("WORK_CORP_ID");
                        object vW_PERSON_ID = igrMODIFY_HISTORY_WORKTYPE.GetCellValue("PERSON_ID");
                        object vW_EFFECTIVE_DATE_FR = igrMODIFY_HISTORY_WORKTYPE.GetCellValue("EFFECTIVE_DATE_FR");
                        object vW_EFFECTIVE_DATE_TO = igrMODIFY_HISTORY_WORKTYPE.GetCellValue("EFFECTIVE_DATE_TO");

                        idcDELETE_PERSON_HISTORY.SetCommandParamValue("W_MODIFY_TAB", "W");
                        idcDELETE_PERSON_HISTORY.SetCommandParamValue("W_WORK_CORP_ID", vW_WORK_CORP_ID);
                        idcDELETE_PERSON_HISTORY.SetCommandParamValue("W_PERSON_ID", vW_PERSON_ID);
                        idcDELETE_PERSON_HISTORY.SetCommandParamValue("W_EFFECTIVE_DATE_FR", vW_EFFECTIVE_DATE_FR);
                        idcDELETE_PERSON_HISTORY.SetCommandParamValue("W_EFFECTIVE_DATE_TO", vW_EFFECTIVE_DATE_TO);

                        idcDELETE_PERSON_HISTORY.ExecuteNonQuery();

                        object vObject_DELETE_SUCCESS_FLAG = idcDELETE_PERSON_HISTORY.GetCommandParamValue("O_DELETE_SUCCESS_FLAG");
                        object vObject_MODIFY_SUCCESS_WORK_TYPE = idcDELETE_PERSON_HISTORY.GetCommandParamValue("O_MODIFY_SUCCESS_WORK_TYPE");

                        string vDELETE_SUCCESS_FLAG = ConvertString(vObject_DELETE_SUCCESS_FLAG);
                        string vMODIFY_SUCCESS_WORK_TYPE = ConvertString(vObject_MODIFY_SUCCESS_WORK_TYPE);

                        if (vDELETE_SUCCESS_FLAG == "Y")
                        {
                            //삭제 하였습니다. [ FCM_10356]
                            //다시 조회를 하십시오! [ FCM_10341]
                            vMessage = string.Format("{0}\n\n{1}\n\n{2}", isMessageAdapter1.ReturnText("FCM_10356"), vMODIFY_SUCCESS_WORK_TYPE, isMessageAdapter1.ReturnText("FCM_10341"));
                            MessageBoxAdv.Show(vMessage, "Information", MessageBoxButtons.OK, MessageBoxIcon.Information);
                        }
                    }
                    catch (System.Exception ex)
                    {
                        isAppInterfaceAdv1.OnAppMessage(ex.Message);
                        System.Windows.Forms.Application.DoEvents();
                    }
                }
            }
            else
            {
                //삭제할 수 없습니다! [EAPP_10013]
                vMessage = string.Format("{0}", isMessageAdapter1.ReturnText("EAPP_10013"));
                MessageBoxAdv.Show(vMessage, "Information", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
        }

        private void Delete_FLOOR()
        {
            string vMessage = string.Empty;

            object vObject = igrMODIFY_HISTORY_FLOOR.GetCellValue("LAST_YN");
            string vLastYN = ConvertString(vObject);

            int vCountRow = igrMODIFY_HISTORY_FLOOR.RowCount;

            if (vLastYN == "Y" && vCountRow > 1)
            {
                System.Windows.Forms.DialogResult vChoice;

                object vObject_PERSON_NAME = igrMODIFY_HISTORY_FLOOR.GetCellValue("PERSON_NAME");
                object vObject_PERSON_NUMBER = igrMODIFY_HISTORY_FLOOR.GetCellValue("PERSON_NUMBER");
                object vObject_FLOOR_NAME = igrMODIFY_HISTORY_FLOOR.GetCellValue("H_FLOOR_NAME");
                object vObject_EFFECTIVE_DATE_FR = igrMODIFY_HISTORY_FLOOR.GetCellValue("EFFECTIVE_DATE_FR");

                string vPERSON_NAME = ConvertString(vObject_PERSON_NAME);
                string vPERSON_NUMBER = ConvertString(vObject_PERSON_NUMBER);
                string vFLOOR_NAME = ConvertString(vObject_FLOOR_NAME);
                System.DateTime vEFFECTIVE_DATE_FR = ConvertDateTime(vObject_EFFECTIVE_DATE_FR);

                //삭제 하시겠습니까?
                vMessage = string.Format("{0}[{1}]\n{2}\n{3}\n\n{4}", vPERSON_NAME, vPERSON_NUMBER, vFLOOR_NAME, vEFFECTIVE_DATE_FR.ToShortDateString(), isMessageAdapter1.ReturnText("EAPP_10030"));
                vChoice = MessageBoxAdv.Show(vMessage, "Delete", System.Windows.Forms.MessageBoxButtons.YesNo, System.Windows.Forms.MessageBoxIcon.Question, System.Windows.Forms.MessageBoxDefaultButton.Button2);

                if (vChoice == System.Windows.Forms.DialogResult.Yes)
                {
                    try
                    {
                        object vW_WORK_CORP_ID = igrMODIFY_HISTORY_FLOOR.GetCellValue("WORK_CORP_ID");
                        object vW_PERSON_ID = igrMODIFY_HISTORY_FLOOR.GetCellValue("PERSON_ID");
                        object vW_EFFECTIVE_DATE_FR = igrMODIFY_HISTORY_FLOOR.GetCellValue("EFFECTIVE_DATE_FR");
                        object vW_EFFECTIVE_DATE_TO = igrMODIFY_HISTORY_FLOOR.GetCellValue("EFFECTIVE_DATE_TO");

                        idcDELETE_PERSON_HISTORY.SetCommandParamValue("W_MODIFY_TAB", "F");
                        idcDELETE_PERSON_HISTORY.SetCommandParamValue("W_WORK_CORP_ID", vW_WORK_CORP_ID);
                        idcDELETE_PERSON_HISTORY.SetCommandParamValue("W_PERSON_ID", vW_PERSON_ID);
                        idcDELETE_PERSON_HISTORY.SetCommandParamValue("W_EFFECTIVE_DATE_FR", vW_EFFECTIVE_DATE_FR);
                        idcDELETE_PERSON_HISTORY.SetCommandParamValue("W_EFFECTIVE_DATE_TO", vW_EFFECTIVE_DATE_TO);

                        idcDELETE_PERSON_HISTORY.ExecuteNonQuery();

                        object vObject_DELETE_SUCCESS_FLAG = idcDELETE_PERSON_HISTORY.GetCommandParamValue("O_DELETE_SUCCESS_FLAG");

                        string vDELETE_SUCCESS_FLAG = ConvertString(vObject_DELETE_SUCCESS_FLAG);

                        if (vDELETE_SUCCESS_FLAG == "Y")
                        {
                            //삭제 하였습니다. [ FCM_10356]
                            //다시 조회를 하십시오! [ FCM_10341]
                            vMessage = string.Format("{0}\n\n{1}", isMessageAdapter1.ReturnText("FCM_10356"), isMessageAdapter1.ReturnText("FCM_10341"));
                            MessageBoxAdv.Show(vMessage, "Information", MessageBoxButtons.OK, MessageBoxIcon.Information);
                        }
                    }
                    catch (System.Exception ex)
                    {
                        isAppInterfaceAdv1.OnAppMessage(ex.Message);
                        System.Windows.Forms.Application.DoEvents();
                    }
                }
            }
            else
            {
                //삭제할 수 없습니다! [EAPP_10013]
                vMessage = string.Format("{0}", isMessageAdapter1.ReturnText("EAPP_10013"));
                MessageBoxAdv.Show(vMessage, "Information", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
        }

        #endregion;

        #region ----- LookUP Event ----

        private void ilaWORK_TYPE_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", "WORK_TYPE");
            ildCOMMON.SetLookupParamValue("W_ENABLED_FLAG_YN", "N");
        }

        private void ilaWORK_TYPE_1_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", "WORK_TYPE");
            ildCOMMON.SetLookupParamValue("W_ENABLED_FLAG_YN", "N");
        }

        private void ilaWORK_TYPE_2_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", "WORK_TYPE");
            ildCOMMON.SetLookupParamValue("W_ENABLED_FLAG_YN", "N");
        }

        private void ilaFLOOR_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildFLOOR_0.SetLookupParamValue("W_GROUP_CODE", "FLOOR");
            ildFLOOR_0.SetLookupParamValue("W_ENABLED_FLAG_YN", "Y");
        }

        private void ilaFLOOR_1_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildFLOOR_1.SetLookupParamValue("W_GROUP_CODE", "FLOOR");
            ildFLOOR_1.SetLookupParamValue("W_ENABLED_FLAG_YN", "Y");
        }

        private void ilaFLOOR_2_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildFLOOR_0.SetLookupParamValue("W_GROUP_CODE", "FLOOR");
            ildFLOOR_0.SetLookupParamValue("W_ENABLED_FLAG_YN", "Y");
        }

        private void ilaEMPLOYE_TYPE_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter("EMPLOYE_TYPE", "Y");
        }

        private void ilaEMPLOYE_TYPE_2_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter("EMPLOYE_TYPE", "Y");
        }

        private void ilaYYYYMM_0_SelectedRowData(object pSender)
        {
            object vObject = WORK_YYYYMM_2.EditValue;
            string vYYYYMM = ConvertString(vObject);
            if (string.IsNullOrEmpty(vYYYYMM) == false)
            {
                System.DateTime v1stDate = ISDate.ISMonth_1st(vYYYYMM);
                System.DateTime vLastDate = ISDate.ISMonth_Last(vYYYYMM);
                DATE_CREATE_START_2.EditValue = v1stDate.ToShortDateString();
                DATE_CREATE_END_2.EditValue = vLastDate.ToShortDateString();
            }
        }

        private void ilaDUTY_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", "DUTY");
            ildCOMMON.SetLookupParamValue("W_ENABLED_FLAG_YN", "Y");
        }

        private void ilaHOLY_TYPE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", "HOLY_TYPE");
            ildCOMMON.SetLookupParamValue("W_ENABLED_FLAG_YN", "Y");
        }

        private void ilaOCPT_2_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildOCPT_2.SetLookupParamValue("W_GROUP_CODE", "OCPT");
            ildOCPT_2.SetLookupParamValue("W_ENABLED_FLAG_YN", "Y");
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

        private void STD_DATE_EditValueChanged(object pSender)
        {
            string vYYYYMM = string.Format("{0:D4}-{1:D2}", STD_DATE_0.DateTimeValue.Year, STD_DATE_0.DateTimeValue.Month);
            System.DateTime v1stDate = ISDate.ISMonth_1st(vYYYYMM);
            System.DateTime vLastDate = ISDate.ISMonth_Last(vYYYYMM);
            WORK_YYYYMM_2.EditValue = vYYYYMM;

            DATE_SEARCH_START_1.EditValue = v1stDate.ToShortDateString();

            DATE_CREATE_START_2.DateTimeValue = STD_DATE_0.DateTimeValue;
            DATE_CREATE_END_2.EditValue = vLastDate.ToShortDateString();
        }

        #endregion

        #region ----- Adapter Event ----

        private void idaMODIFY_FLOOR_NewRowMoved(object pSender, ISBindingEventArgs pBindingManager)
        {
            idaMODIFY_HISTORY_1.Fill();
        }

        private void idaMODIFY_WORK_TYPE_NewRowMoved(object pSender, ISBindingEventArgs pBindingManager)
        {
            idaMODIFY_HISTORY_0.Fill();
        }

        private void ilaCOST_CENTER_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCOST_CENTER.SetLookupParamValue("W_ENABLED_FLAG_YN", "Y");
        }

        private void ilaCOST_CENTER_SelectedRowData(object pSender)
        {
            System.Windows.Forms.SendKeys.Send("{TAB}");
        }

        #endregion

    }
}