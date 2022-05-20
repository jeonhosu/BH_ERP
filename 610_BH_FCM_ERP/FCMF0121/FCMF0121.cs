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

namespace FCMF0121
{
    public partial class FCMF0121 : Office2007Form
    {
        #region ----- Variables -----

        ISFunction.ISConvert iString = new ISFunction.ISConvert();
        ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        #endregion;

        #region ----- Constructor -----

        public FCMF0121()
        {
            InitializeComponent();
        }

        public FCMF0121(Form pMainForm, ISAppInterface pAppInterface)
        {
            InitializeComponent();
            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;
        }

        #endregion;

        #region ----- Private Methods ----
        
        private void SEARCH_DB()
        {
            idaACCOUNT_SET.Fill();
            igrACCOUNT_CONTROL.Focus();
        }

        private void isSetCommonParameter(string pGroup_Code, string pEnabled_YN)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", pGroup_Code);
            ildCOMMON.SetLookupParamValue("W_ENABLED_YN", pEnabled_YN);
        }

        private void INSERT_ACCOUNT_SET()
        {
            ACCOUNT_SET_ID.Focus();
        }

        private void INSERT_ACCOUNT_CODE()
        {
            EFFECTIVE_DATE_FR.EditValue = iDate.ISMonth_1st(DateTime.Today);
            ENABLED_FLAG.CheckBoxValue = "Y";
            ACCOUNT_CODE.Focus();
        }

        #endregion;

        #region ----- Events -----

        private void isAppInterfaceAdv1_AppMainButtonClick(ISAppButtonEvents e)
        {
            if (this.IsActive)
            {
                if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Search)
                {
                    SEARCH_DB();
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddOver)
                {
                    if (idaACCOUNT_SET.IsFocused)
                    {
                        idaACCOUNT_SET.AddOver();
                        INSERT_ACCOUNT_SET();
                    }
                    else if (idaACCOUNT_CONTROL.IsFocused)
                    {
                        idaACCOUNT_CONTROL.AddOver();
                        INSERT_ACCOUNT_CODE();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddUnder)
                {
                    if (idaACCOUNT_SET.IsFocused)
                    {
                        idaACCOUNT_SET.AddUnder();
                        INSERT_ACCOUNT_SET();
                    }
                    else if (idaACCOUNT_CONTROL.IsFocused)
                    {
                        idaACCOUNT_CONTROL.AddUnder();
                        INSERT_ACCOUNT_CODE();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Update)
                {
                    if (idaACCOUNT_SET.IsFocused)
                    {
                        idaACCOUNT_SET.Update();
                    }
                    else if (idaACCOUNT_CONTROL.IsFocused)
                    {
                        idaACCOUNT_CONTROL.Update();
                    }                    
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Cancel)
                {
                    if (idaACCOUNT_SET.IsFocused)
                    {
                        idaACCOUNT_SET.Cancel();
                    }
                    else if (idaACCOUNT_CONTROL.IsFocused)
                    {
                        idaACCOUNT_CONTROL.Cancel();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {
                    if (idaACCOUNT_SET.IsFocused)
                    {
                        idaACCOUNT_SET.Delete();
                    }
                    else if (idaACCOUNT_CONTROL.IsFocused)
                    {
                        idaACCOUNT_CONTROL.Delete();
                    }
                }
            }
        }

        #endregion;

        #region ----- Form Event -----

        private void FCMF0121_Load(object sender, EventArgs e)
        {
            idaACCOUNT_SET.FillSchema();
            idaACCOUNT_CONTROL.FillSchema();
        }

        private void FCMF0121_Shown(object sender, EventArgs e)
        {

        }

        private void ACCOUNT_DESC_CurrentEditValidated(object pSender, ISEditAdvValidatedEventArgs e)
        {
            if (iString.ISNull(ACCOUNT_DESC_S.EditValue) == string.Empty)
            {
                ACCOUNT_DESC_S.EditValue = ACCOUNT_DESC.EditValue;
            }
        }

        #endregion

        #region ----- Lookup Event ------
        
        private void ilaACCOUNT_DR_CR_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            isSetCommonParameter("ACCOUNT_DR_CR", "Y");
        }

        private void ilaGL_TYPE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            isSetCommonParameter("GL_TYPE", "Y");
        }

        private void ilaFS_TYPE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            isSetCommonParameter("FORM_TYPE", "Y");
        }

        private void ilaLIQUIDATE_METHOD_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            isSetCommonParameter("LIQUIDATE_METHOD_TYPE", "Y");
        }

        private void ilaACCOUNT_CLASS_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            isSetCommonParameter("ACCOUNT_CLASS", "Y");
        }

        private void ilaREFER_ITEM_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            isSetCommonParameter("MANAGEMENT_CODE", "Y");
        }

        private void ilaACCOUNT_CONTROL_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildACCOUNT_CONTROL.SetLookupParamValue("W_ENABLED_YN", "N");
        }

        private void ilaRELATE_ACCOUNT_CODE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildACCOUNT_CONTROL.SetLookupParamValue("W_ENABLED_YN", "N");
        }

        private void ilaUP_ACCOUNT_CODE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildACCOUNT_CONTROL.SetLookupParamValue("W_ENABLED_YN", "N");
        }

        #endregion

        #region ----- Adapter Event ------

        private void idaACCOUNT_SET_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {
            if (e.Row["ACCOUNT_SET_ID"] == DBNull.Value)
            {// 계정SET ID
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10086", "&&VALUE:=Account Set ID(계정 세트ID)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["ACCOUNT_SET_CODE"]) == string.Empty)
            {// 계정세트코드
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10086", "&&VALUE:=Account Set Code(계정 세트코드)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["ACCOUNT_SET_NAME"]) == string.Empty)
            {// 계정세트명
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10086", "&&VALUE:=Account Set Name(계정 세트명)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["ACCOUNT_LEVEL"] == DBNull.Value)
            {// 계정세트레벨
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10086", "&&VALUE:=Account Level(계정 세트 레벨)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
        }

        private void idaACCOUNT_SET_PreDelete(ISPreDeleteEventArgs e)
        {
            if (e.Row.RowState != DataRowState.Added)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10029", "&&VALUE:=Data(해당 자료)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);        // 모듈 코드 입력
                e.Cancel = true;
                return;
            }
        }

        private void idaACCOUNT_CONTROL_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {
            if (iString.ISNull(e.Row["ACCOUNT_CODE"]) == string.Empty)
            {// 계정코드
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10087", "&&VALUE:=Account Code(계정 코드)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["ACCOUNT_DESC"]) == string.Empty)
            {// 계정명
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10087", "&&VALUE:=Account Desc(계정명)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["ACCOUNT_DR_CR"]) == string.Empty)
            {// 차대구분
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10088", "&&VALUE:=Account DR/CR(차대 구분)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["EFFECTIVE_DATE_FR"] == DBNull.Value)
            {// 적용 시작일자
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10088", "&&VALUE:=Effective Date From(적용 시작일자)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }

            //if (Convert.ToString(e.Row["ACCOUNT_MICH_YN"]) == "Y" && iString.ISNull(e.Row["LIQUIDATE_METHOD_TYPE"]) == string.Empty)
            //{// 미청산 항목 --> 반제처리 방법 선택.
            //    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10102"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            //    e.Cancel = true;
            //    return;
            //}
            //if (Convert.ToString(e.Row["ACCOUNT_MICH_YN"]) == "N" && iString.ISNull(e.Row["LIQUIDATE_METHOD_TYPE"]) != string.Empty)
            //{// 미청산 항목 --> 반제처리 방법 선택.
            //    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10103"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            //    e.Cancel = true;
            //    return;
            //}

            if (Convert.ToString(e.Row["BUDGET_ENABLED_FLAG"]) == "N" && Convert.ToString(e.Row["BUDGET_CONTROL_FLAG"]) == "Y")
            {// 예산사용과 예산통제 검증
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10266"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }

            if (Convert.ToString(e.Row["MNS_ACCOUNT_FLAG"]) == "Y" && iString.ISNull(e.Row["RELATE_ACCOUNT_CODE"]) == string.Empty)
            {// 차감계정과 연동계정 검증
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10264"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (Convert.ToString(e.Row["MNS_ACCOUNT_FLAG"]) == "N" && iString.ISNull(e.Row["RELATE_ACCOUNT_CODE"]) != string.Empty)
            {// 차감계정과 연동계정 검증
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10265"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }

            ///////////////////////////////////////////////////////////////////////////////////////////////
            if (e.Row["REFER1_ID"] == DBNull.Value && (e.Row["DR_NEED_YN1"].ToString() == "Y".ToString() || e.Row["CR_NEED_YN1"].ToString() == "Y".ToString()))
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10090", "&&FIELD_NAME:=Refer Item1(관리항목1)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["REFER2_ID"] == DBNull.Value && (e.Row["DR_NEED_YN2"].ToString() == "Y".ToString() || e.Row["CR_NEED_YN2"].ToString() == "Y".ToString()))
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10090", "&&FIELD_NAME:=Refer Item2(관리항목2)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["REFER3_ID"] == DBNull.Value && (e.Row["DR_NEED_YN3"].ToString() == "Y".ToString() || e.Row["CR_NEED_YN3"].ToString() == "Y".ToString()))
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10090", "&&FIELD_NAME:=Refer Item3(관리항목3)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["REFER4_ID"] == DBNull.Value && (e.Row["DR_NEED_YN4"].ToString() == "Y".ToString() || e.Row["CR_NEED_YN4"].ToString() == "Y".ToString()))
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10090", "&&FIELD_NAME:=Refer Item4(관리항목4)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["REFER5_ID"] == DBNull.Value && (e.Row["DR_NEED_YN5"].ToString() == "Y".ToString() || e.Row["CR_NEED_YN5"].ToString() == "Y".ToString()))
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10090", "&&FIELD_NAME:=Refer Item5(관리항목5)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["REFER6_ID"] == DBNull.Value && (e.Row["DR_NEED_YN6"].ToString() == "Y".ToString() || e.Row["CR_NEED_YN6"].ToString() == "Y".ToString()))
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10090", "&&FIELD_NAME:=Refer Item6(관리항목6)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["REFER7_ID"] == DBNull.Value && (e.Row["DR_NEED_YN7"].ToString() == "Y".ToString() || e.Row["CR_NEED_YN7"].ToString() == "Y".ToString()))
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10090", "&&FIELD_NAME:=Refer Item7(관리항목7)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["REFER8_ID"] == DBNull.Value && (e.Row["DR_NEED_YN8"].ToString() == "Y".ToString() || e.Row["CR_NEED_YN8"].ToString() == "Y".ToString()))
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10090", "&&FIELD_NAME:=Refer Item8(관리항목8)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["REFER9_ID"] == DBNull.Value && (e.Row["DR_NEED_YN9"].ToString() == "Y".ToString() || e.Row["CR_NEED_YN9"].ToString() == "Y".ToString()))
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10090", "&&FIELD_NAME:=Refer Item9(관리항목9)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["REFER10_ID"] == DBNull.Value && (e.Row["DR_NEED_YN10"].ToString() == "Y".ToString() || e.Row["CR_NEED_YN10"].ToString() == "Y".ToString()))
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10090", "&&FIELD_NAME:=Refer Item10관리항목10)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["REFER11_ID"] == DBNull.Value && (e.Row["DR_NEED_YN11"].ToString() == "Y".ToString() || e.Row["CR_NEED_YN11"].ToString() == "Y".ToString()))
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10090", "&&FIELD_NAME:=Refer Item11(관리항목11)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["REFER12_ID"] == DBNull.Value && (e.Row["DR_NEED_YN12"].ToString() == "Y".ToString() || e.Row["CR_NEED_YN12"].ToString() == "Y".ToString()))
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10090", "&&FIELD_NAME:=Refer Item12(관리항목12)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["REFER13_ID"] == DBNull.Value && (e.Row["DR_NEED_YN13"].ToString() == "Y".ToString() || e.Row["CR_NEED_YN13"].ToString() == "Y".ToString()))
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10090", "&&FIELD_NAME:=Refer Item13(관리항목13)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["REFER14_ID"] == DBNull.Value && (e.Row["DR_NEED_YN14"].ToString() == "Y".ToString() || e.Row["CR_NEED_YN14"].ToString() == "Y".ToString()))
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10090", "&&FIELD_NAME:=Refer Item14(관리항목14)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            ///////////////////////////////////////////////////////////////////////////////////////////////
        }

        private void idaACCOUNT_CONTROL_PreDelete(ISPreDeleteEventArgs e)
        {
            if (e.Row.RowState != DataRowState.Added)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10029", "&&VALUE:=Data(해당 자료)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);        // 모듈 코드 입력
                e.Cancel = true;
                return;
            }
        }

        #endregion

    }
}