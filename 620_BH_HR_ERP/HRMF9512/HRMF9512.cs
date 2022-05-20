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

namespace HRMF9512
{
    public partial class HRMF9512 : Office2007Form
    {
        ISCommonUtil.ISFunction.ISConvert iString = new ISFunction.ISConvert();
        ISCommonUtil.ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        #region ----- Variables -----



        #endregion;
        
        #region ----- Constructor -----

        public HRMF9512(Form pMainForm, ISAppInterface pAppInterface)
        {
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
            ildCORP.SetLookupParamValue("W_PAY_CONTROL_YN", "Y");
            ildCORP.SetLookupParamValue("W_ENABLED_FLAG_YN", "N");

            // LOOKUP DEFAULT VALUE SETTING - CORP
            idcDEFAULT_CORP.SetCommandParamValue("W_PAY_CONTROL_YN", "Y");
            idcDEFAULT_CORP.SetCommandParamValue("W_ENABLED_FLAG_YN", "N");
            idcDEFAULT_CORP.ExecuteNonQuery();
            CORP_NAME_0.EditValue = idcDEFAULT_CORP.GetCommandParamValue("O_CORP_NAME");
            CORP_ID_0.EditValue = idcDEFAULT_CORP.GetCommandParamValue("O_CORP_ID");

            P_CORP_NAME_0.EditValue = CORP_NAME_0.EditValue;
            P_CORP_ID_0.EditValue = CORP_ID_0.EditValue;
        }

        private void Init_Payment_Rule_Insert()
        {
            igrPAYMENT_RULE.SetCellValue("CORP_ID", CORP_ID_0.EditValue);
            igrPAYMENT_RULE.SetCellValue("START_MONTH", 0);
            igrPAYMENT_RULE.SetCellValue("END_MONTH", 0);
            igrPAYMENT_RULE.SetCellValue("ENABLED_FLAG", "Y");
            igrPAYMENT_RULE.SetCellValue("EFFECTIVE_YYYYMM_FR", iDate.ISYearMonth(DateTime.Today));
        }

        private void Init_Person_Payment_Rule_Insert()
        {
            igrPERSON_PAYMENT_RULE.SetCellValue("CORP_ID", P_CORP_ID_0.EditValue);
            igrPERSON_PAYMENT_RULE.SetCellValue("ENABLED_FLAG", "Y");
            igrPERSON_PAYMENT_RULE.SetCellValue("EFFECTIVE_YYYYMM_FR", iDate.ISYearMonth(DateTime.Today));
        }

        private void isSetCommonLookUpParameter(string P_GROUP_CODE, string P_USABLE_YN)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", P_GROUP_CODE);
            ildCOMMON.SetLookupParamValue("W_ENABLED_FLAG_YN", P_USABLE_YN);
        }

        private void isSetCommonLookUpParameter(string P_GROUP_CODE, string P_WHERE, string P_USABLE_YN)
        {
            ildCOMMON_W.SetLookupParamValue("W_GROUP_CODE", P_GROUP_CODE);
            ildCOMMON_W.SetLookupParamValue("W_WHERE", P_WHERE);
            ildCOMMON_W.SetLookupParamValue("W_ENABLED_FLAG_YN", P_USABLE_YN);
        }

        private void Search_DB()
        {
            if (itbPAYMENT_RULE.SelectedTab.TabIndex == 1)
            {
                if (iString.ISNull(STD_YYYYMM_0.EditValue) == String.Empty)
                {// 시작일자
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10036"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    STD_YYYYMM_0.Focus();
                    return;
                }
                idaPAYMENT_RULE.Fill();
                igrPAYMENT_RULE.Focus();
            }
            else if (itbPAYMENT_RULE.SelectedTab.TabIndex == 2)
            {
                if (iString.ISNull(P_STD_YYYYMM_0.EditValue) == String.Empty)
                {// 시작일자
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10036"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    P_STD_YYYYMM_0.Focus();
                    return;
                }
                idaPERSON_PAYMENT_RULE.Fill();
                igrPERSON_PAYMENT_RULE.Focus();
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
                    if (idaPAYMENT_RULE.IsFocused)
                    {
                        idaPAYMENT_RULE.AddOver();
                        Init_Payment_Rule_Insert();
                    }
                    else if (idaPERSON_PAYMENT_RULE.IsFocused)
                    {
                        idaPERSON_PAYMENT_RULE.AddOver();
                        Init_Person_Payment_Rule_Insert();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddUnder)
                {
                    if (idaPAYMENT_RULE.IsFocused)
                    {
                        idaPAYMENT_RULE.AddUnder();
                        Init_Payment_Rule_Insert();
                    }
                    else if (idaPERSON_PAYMENT_RULE.IsFocused)
                    {
                        idaPERSON_PAYMENT_RULE.AddUnder();
                        Init_Person_Payment_Rule_Insert();
                    } 
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Update)
                {
                    if (idaPAYMENT_RULE.IsFocused)
                    {
                        idaPAYMENT_RULE.Update();
                    }
                    else if (idaPERSON_PAYMENT_RULE.IsFocused)
                    {
                        idaPERSON_PAYMENT_RULE.Update();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Cancel)
                {
                    if (idaPAYMENT_RULE.IsFocused)
                    {
                        idaPAYMENT_RULE.Cancel();
                    }
                    else if (idaPERSON_PAYMENT_RULE.IsFocused)
                    {
                        idaPERSON_PAYMENT_RULE.Cancel();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {
                    if (idaPAYMENT_RULE.IsFocused)
                    {
                        idaPAYMENT_RULE.Delete();
                    }
                    else if (idaPERSON_PAYMENT_RULE.IsFocused)
                    {
                        idaPERSON_PAYMENT_RULE.Delete();
                    }
                }
            }
        }
        #endregion;

        #region ----- Form Event -----

        private void HRMF9512_Load(object sender, EventArgs e)
        {
            idaPAYMENT_RULE.FillSchema();
            idaPERSON_PAYMENT_RULE.FillSchema();
        }

        private void HRMF9512_Shown(object sender, EventArgs e)
        {
            STD_YYYYMM_0.EditValue = iDate.ISYearMonth(DateTime.Today);
            P_STD_YYYYMM_0.EditValue = iDate.ISYearMonth(DateTime.Today);
            P_START_DATE_0.EditValue = iDate.ISMonth_1st(DateTime.Today);
            P_END_DATE_0.EditValue = iDate.ISMonth_Last(DateTime.Today);

            //DefaultCorporation();              //Default Corp.
            //DefaultSetFormReSize();		//[Child Form, Mdi Form에 맞게 ReSize] 
        }

        #endregion  

        #region ----- Adapter Event -----
        // Pay Master 항목.
        private void idaGRADE_HEADER_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {
            if (e.Row["CORP_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Corporation(업체)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            
            if (e.Row["PERSON_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Person(사원)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["PAY_TYPE"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Pay Type(급여제)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["PAY_GRADE_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Pay Grade(직급)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }

            if (iString.ISNull(e.Row["EFFECTIVE_YYYYMM_FR"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Start Year Month(시작년월)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
        }

        private void idaGRADE_HEADER_PreDelete(ISPreDeleteEventArgs e)
        {
            if (e.Row.RowState != DataRowState.Added)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10029", "&&VALUE:=Data(해당 자료)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);        // 모듈 코드 입력
                e.Cancel = true;
                return;
            }
        }

        // Allowance 항목.
        private void idaPAY_ALLOWANCE_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {
            if (e.Row["ALLOWANCE_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Allowance(항목)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["ALLOWANCE_AMOUNT"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Allowance Amount(금액)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
        }

        private void idaPAY_ALLOWANCE_PreDelete(ISPreDeleteEventArgs e)
        {
            if (e.Row.RowState != DataRowState.Added)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10029", "&&VALUE:=Data(해당 자료)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);        // 모듈 코드 입력
                e.Cancel = true;
                return;
            }
        }

        // PAYMENT RULE
        private void idaPAYMENT_RULE_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {
            if (iString.ISNull(e.Row["WAGE_TYPE"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Wage Type(급상여 구분)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }

            if (e.Row["JOIN_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Join(입사구분)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }

            if (e.Row["PAY_TYPE"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Pay Type(급여제)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }

            if (iString.ISNull(e.Row["STD_START_DATE"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Standard Start Date(기준 시작일자)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }

            if (iString.ISNull(e.Row["STD_END_DATE"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Standard End Date(기준 종료일자)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            
            if (iString.ISNull(e.Row["EFFECTIVE_YYYYMM_FR"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Start Year Month(적용 시작년월)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
        }

        private void idaPAYMENT_RULE_PreDelete(ISPreDeleteEventArgs e)
        {
            if (e.Row.RowState != DataRowState.Added)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10029", "&&VALUE:=Data(해당 자료)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);        // 모듈 코드 입력
                e.Cancel = true;
                return;
            }
        }

        private void idaPERSON_PAYMENT_RULE_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {
            if (e.Row["PERSON_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Join(입사구분)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }

            if (iString.ISNull(e.Row["EFFECTIVE_YYYYMM_FR"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Start Year Month(적용 시작년월)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
        }

        private void idaPERSON_PAYMENT_RULE_PreDelete(ISPreDeleteEventArgs e)
        {
            if (e.Row.RowState != DataRowState.Added)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10029", "&&VALUE:=Data(해당 자료)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);        // 모듈 코드 입력
                e.Cancel = true;
                return;
            }
        }

        #endregion

        #region ----- LookUp Event ------
        
        private void ilaCORP_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCORP.SetLookupParamValue("W_ENABLED_FLAG_YN", "Y");
        }
        
        private void ilaYYYYMM_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildYYYYMM.SetLookupParamValue("W_START_YYYYMM", "2001-01");
            ildYYYYMM.SetLookupParamValue("W_END_YYYYMM", iDate.ISYearMonth(DateTime.Today));
        }

        private void ilaWAGE_TYPE_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            isSetCommonLookUpParameter("CLOSING_TYPE", " VALUE1 = 'PAY' ", "N");
        }
        
        private void ilaPAY_TYPE_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            isSetCommonLookUpParameter("PAY_TYPE", "N");
        }

        private void ilaJOIN_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            isSetCommonLookUpParameter("JOIN", "N");
        }

        private void ilaPAY_TYPE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            isSetCommonLookUpParameter("PAY_TYPE", "Y");
        }

        private void ilaJOIN_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            isSetCommonLookUpParameter("JOIN", "Y");
        }

        private void ilaSTD_START_DATE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            isSetCommonLookUpParameter("DATE_ITEM", "Y");
        }

        private void ilaSTD_END_DATE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            isSetCommonLookUpParameter("DATE_ITEM", "Y");
        }

        private void ilaWAGE_TYPE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            isSetCommonLookUpParameter("CLOSING_TYPE", " VALUE1 = 'PAY' ", "Y");
        }

        private void ilaEFFECTIVE_YYYYMM_FR_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildYYYYMM.SetLookupParamValue("W_START_YYYYMM", "2001-01");
            ildYYYYMM.SetLookupParamValue("W_END_YYYYMM", iDate.ISYearMonth(DateTime.Today));
        }

        private void ilaEFFECTIVE_YYYYMM_TO_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildYYYYMM.SetLookupParamValue("W_START_YYYYMM", "2001-01");
            ildYYYYMM.SetLookupParamValue("W_END_YYYYMM", "2100-12");
        }

        private void ilaP_DEPT_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildDEPT.SetLookupParamValue("W_USABLE_CHECK_YN", "N");
        }

        private void ilaP_EFFECTIVE_YYYYMM_FR_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildYYYYMM.SetLookupParamValue("W_START_YYYYMM", "2001-01");
            ildYYYYMM.SetLookupParamValue("W_END_YYYYMM", iDate.ISYearMonth(DateTime.Today));
        }

        private void ilaP_EFFECTIVE_YYYYMM_TO_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildYYYYMM.SetLookupParamValue("W_START_YYYYMM", "2001-01");
            ildYYYYMM.SetLookupParamValue("W_END_YYYYMM", "2100-12");
        }

        private void ilaP_PERSON_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildP_PERSON_0.SetLookupParamValue("W_CORP_TYPE", "4");
        }

        private void ilaP_PERSON_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildP_PERSON_0.SetLookupParamValue("W_CORP_TYPE", "4");
        }

        #endregion

    }
}