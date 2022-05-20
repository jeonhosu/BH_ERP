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

namespace HRMF0511
{
    public partial class HRMF0511 : Office2007Form
    {
        ISCommonUtil.ISFunction.ISConvert iString = new ISFunction.ISConvert();
        ISCommonUtil.ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        #region ----- Variables -----



        #endregion;
        
        #region ----- Constructor -----

        public HRMF0511(Form pMainForm, ISAppInterface pAppInterface)
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
            ildCORP.SetLookupParamValue("W_PAY_CONTROL_YN", "Y");
            ildCORP.SetLookupParamValue("W_ENABLED_FLAG_YN", "N");

            // LOOKUP DEFAULT VALUE SETTING - CORP
            idcDEFAULT_CORP.SetCommandParamValue("W_PAY_CONTROL_YN", "Y");
            idcDEFAULT_CORP.SetCommandParamValue("W_ENABLED_FLAG_YN", "N");
            idcDEFAULT_CORP.ExecuteNonQuery();
            CORP_NAME_0.EditValue = idcDEFAULT_CORP.GetCommandParamValue("O_CORP_NAME");
            CORP_ID_0.EditValue = idcDEFAULT_CORP.GetCommandParamValue("O_CORP_ID");
        }

        private void Init_Insert()
        {
            igrPAYMENT_SETUP.SetCellValue("CORP_ID", CORP_ID_0.EditValue);

            igrPAYMENT_SETUP.SetCellValue("ALLOWANCE_ID", igrALLOWANCE.GetCellValue("ALLOWANCE_ID"));
            igrPAYMENT_SETUP.SetCellValue("ALLOWANCE_NAME", igrALLOWANCE.GetCellValue("ALLOWANCE_NAME"));

            WAGE_TYPE.EditValue = WAGE_TYPE_0.EditValue;
            WAGE_TYPE_NAME.EditValue = WAGE_TYPE_NAME_0.EditValue;
            ALLOWANCE_TYPE_NAME.EditValue = ALLOWANCE_TYPE_NAME_0.EditValue;
            ALLOWANCE_TYPE.EditValue = ALLOWANCE_TYPE_0.EditValue;
            TAX_YN.CheckBoxValue = "Y";
            ROOKIE_YN.CheckBoxValue = "Y";
            EXCEPTION_YN.CheckBoxValue = "Y";
            MONTHLY_PAY_YN.CheckBoxValue = "Y";
            GRADE_YN.CheckBoxValue = "Y";
            PAY_MASTER_YN.CheckBoxValue = "Y";
            ADD_ALLOWANCE_YN.CheckBoxValue = "Y";
            RETIRE_ADJUSTMENT_YN.CheckBoxValue = "Y";
            EMPLOYMENT_INSUR_YN.CheckBoxValue = "Y";
            DIGIT_NUMBER.EditValue = 0;
            TEMP_RETIRE_YN.CheckBoxValue = "Y";
            ENABLED_FLAG.CheckBoxValue = "Y";
        }

        private void Init_CALCULATE(object pValue)
        {
            if (iString.ISNull(FOCUSED_ITEM.EditValue) == string.Empty || iString.ISNull(pValue) == string.Empty)
            {
            }
            else if (Convert.ToString(FOCUSED_ITEM.EditValue) == Convert.ToString("SYSTEM_CALCULATION"))
            {
                SYSTEM_CALCULATION.EditValue = string.Format("{0}{1} ", SYSTEM_CALCULATION.EditValue, pValue);
                SYSTEM_CALCULATION.TextSelectionStart = SYSTEM_CALCULATION.TextValue.Length;
                SYSTEM_CALCULATION.Focus();

            }
            else if (Convert.ToString(FOCUSED_ITEM.EditValue) == Convert.ToString("IF_CONDITION"))
            {
                IF_CONDITION.EditValue = string.Format("{0}{1} ", IF_CONDITION.EditValue, pValue);
                IF_CONDITION.TextSelectionStart = IF_CONDITION.TextValue.Length;
                IF_CONDITION.Focus();
            }
            else if (Convert.ToString(FOCUSED_ITEM.EditValue) == Convert.ToString("TRUE_VALUE"))
            {
                TRUE_VALUE.EditValue = string.Format("{0}{1} ", TRUE_VALUE.EditValue, pValue);
                TRUE_VALUE.TextSelectionStart = TRUE_VALUE.TextValue.Length;
                TRUE_VALUE.Focus();
            }
            else if (Convert.ToString(FOCUSED_ITEM.EditValue) == Convert.ToString("FALSE_VALUE"))
            {
                FALSE_VALUE.EditValue = string.Format("{0}{1} ", FALSE_VALUE.EditValue, pValue);
                FALSE_VALUE.TextSelectionStart = FALSE_VALUE.TextValue.Length;
                FALSE_VALUE.Focus();
            }
        }

        private void Search_DB()
        {
            if (CORP_ID_0.EditValue == null)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10001"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                CORP_NAME_0.Focus();
                return;
            }
            if (iString.ISNull(STD_YYYYMM_0.EditValue) == String.Empty)
            {// 시작일자
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10036"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                STD_YYYYMM_0.Focus();
                return;
            }
            if (iString.ISNull(ALLOWANCE_TYPE_0.EditValue) == String.Empty)
            {// 지급/항목구분
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Allowance Type(지급/공제 구분)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                ALLOWANCE_TYPE_NAME_0.Focus();
                return;
            }
            if (iString.ISNull(WAGE_TYPE_0.EditValue) == String.Empty)
            {// 지급/항목구분
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Wage Type(급상여 구분)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                WAGE_TYPE_NAME_0.Focus();
                return;
            }
            idaALLOWANCE_INFO.Fill();
            igrALLOWANCE.Focus();
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
                    if (idaALLOWANCE_INFO.IsFocused)
                    {
                        idaALLOWANCE_INFO.AddOver();
                    }
                    else if (idaPAYMENT_SETUP.IsFocused)
                    {
                        idaPAYMENT_SETUP.AddOver();
                        Init_Insert();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddUnder)
                {
                    if (idaALLOWANCE_INFO.IsFocused)
                    {
                        idaALLOWANCE_INFO.AddUnder();
                    }
                    else if (idaPAYMENT_SETUP.IsFocused)
                    {
                        idaPAYMENT_SETUP.AddUnder();
                        Init_Insert();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Update)
                {
                    idaALLOWANCE_INFO.Update();
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Cancel)
                {
                    if (idaALLOWANCE_INFO.IsFocused)
                    {
                        idaALLOWANCE_INFO.Cancel();
                    }
                    else if (idaPAYMENT_SETUP.IsFocused)
                    {
                        idaPAYMENT_SETUP.Cancel();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {
                    if (idaALLOWANCE_INFO.IsFocused)
                    {
                        idaALLOWANCE_INFO.Delete();
                    }
                    else if (idaPAYMENT_SETUP.IsFocused)
                    {
                        idaPAYMENT_SETUP.Delete();
                    }
                }
            }
        }
        #endregion;

        #region ----- Form Event -----
        private void HRMF0511_Load(object sender, EventArgs e)
        {
            //idaPAY_MASTER_HEADER.FillSchema();
            idaALLOWANCE_INFO.FillSchema();

            STD_YYYYMM_0.EditValue = iDate.ISYearMonth(DateTime.Today);
                                    
            DefaultCorporation();              //Default Corp.
            //DefaultSetFormReSize();		//[Child Form, Mdi Form에 맞게 ReSize]           
        }
        #endregion  

        #region ----- Adapter Event -----
        // 지급/공제 항목 정보.
        private void idaALLOWANCE_INFO_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {
            if (iString.ISNull(ALLOWANCE_TYPE_0.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Allowance Type(지급/공제 구분)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["ALLOWANCE_CODE"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Allowance Code(항목 코드)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["ALLOWANCE_NAME"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Allowance Name(항목명)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["EFFECTIVE_DATE_FR"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Effective Date From(적용 시작일자)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }            
        }

        private void idaALLOWANCE_INFO_PreDelete(ISPreDeleteEventArgs e)
        {
            if (e.Row.RowState != DataRowState.Added)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10029", "&&VALUE:=Data(해당 자료)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);        // 모듈 코드 입력
                e.Cancel = true;
                return;
            }
        }
        // Pay Master 항목.
        private void idaPAYMENT_SETUP_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {
            if (e.Row["CORP_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Corporation(업체)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }

            if (iString.ISNull(STD_YYYYMM_0.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Standard Year Month From(적용 년월)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }

            if (e.Row["ALLOWANCE_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Allowance Name(지급/공제 항목)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            
            if (iString.ISNull(e.Row["PAY_TYPE"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Pay Type(급여제)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }

            if (iString.ISNull(e.Row["DECIMAL_TYPE"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Decimal Type(절사 타입)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }

            if (e.Row["DIGIT_NUMBER"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Digit Number(소수점 자릿수)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
        }

        private void idaPAYMENT_SETUP_PreDelete(ISPreDeleteEventArgs e)
        {
            if (e.Row.RowState != DataRowState.Added)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10029", "&&VALUE:=Data(해당 자료)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);        // 모듈 코드 입력
                e.Cancel = true;
                return;
            }
        }
        #endregion

        #region ----- LookUp Event -----
        private void ilaYYYYMM_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildYYYYMM.SetLookupParamValue("W_START_YYYYMM", "2001-01");
            ildYYYYMM.SetLookupParamValue("W_END_YYYYMM", iDate.ISYearMonth(DateTime.Today));
        }

        private void ilaALLOWANCE_TYPE_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", "ALLOWANCE_TYPE");
            ildCOMMON.SetLookupParamValue("W_ENABLED_FLAG", "N");
        }
        
        private void ilaPAY_TYPE_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", "PAY_TYPE");
            ildCOMMON.SetLookupParamValue("W_ENABLED_FLAG", "N");
        }

        private void ilaALLOWANCE_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildALLOWANCE.SetLookupParamValue("W_ALLOWANCE_TYPE", ALLOWANCE_TYPE_0.EditValue);
            ildALLOWANCE.SetLookupParamValue("W_ENABLED_FLAG_YN", "N");
        }

        private void ilaPAY_TYPE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", "PAY_TYPE");
            ildCOMMON.SetLookupParamValue("W_ENABLED_FLAG", "Y");
        }

        private void ildSEX_TYPE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", "SEX_TYPE");
            ildCOMMON.SetLookupParamValue("W_ENABLED_FLAG", "Y");
        }

        private void ilaDECIMAL_TYPE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", "DECIMAL_TYPE");
            ildCOMMON.SetLookupParamValue("W_ENABLED_FLAG", "Y");
        }

        private void ilaWAGE_TYPE_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCOMMON_W.SetLookupParamValue("W_GROUP_CODE", "CLOSING_TYPE");
            ildCOMMON_W.SetLookupParamValue("W_WHERE", "HC.VALUE1 = 'PAY' ");
            ildCOMMON_W.SetLookupParamValue("W_ENABLED_FLAG_YN", "N");
        }
        #endregion
        
        private void igrPAYMENT_SET_ALL_CellDoubleClick(object pSender)
        {
            Init_CALCULATE(igrPAYMENT_SET_ALL.GetCellValue("PAYMENT_SET_CODE"));
        }

        private void igrALLOWANCE_ALL_CellDoubleClick(object pSender)
        {
            Init_CALCULATE(igrALLOWANCE_ALL.GetCellValue("ALLOWANCE_CODE"));            
        }

        private void igrDUTY_ITEM_ALL_CellDoubleClick(object pSender)
        {
            Init_CALCULATE(igrDUTY_ITEM_ALL.GetCellValue("DUTY_ITEM"));                
        }

        private void SYSTEM_CALCULATION_CurrentEditValidating(object pSender, ISEditAdvValidatingEventArgs e)
        {
            FOCUSED_ITEM.EditValue = SYSTEM_CALCULATION.Name;
        }

        private void IF_CONDITION_CurrentEditValidating(object pSender, ISEditAdvValidatingEventArgs e)
        {
            FOCUSED_ITEM.EditValue = IF_CONDITION.Name;
        }

        private void TRUE_VALUE_CurrentEditValidating(object pSender, ISEditAdvValidatingEventArgs e)
        {
            FOCUSED_ITEM.EditValue = TRUE_VALUE.Name;
        }

        private void FALSE_VALUE_CurrentEditValidating(object pSender, ISEditAdvValidatingEventArgs e)
        {
            FOCUSED_ITEM.EditValue = FALSE_VALUE.Name;
        }

        //private void isButton1_ButtonClick(object pSender, EventArgs pEventArgs)
        //{
        //    isGridAdvEx1.ColCount = idaPAYMENT_SETUP.SelectColumns.Count + 1;
        //    isGridAdvEx1.RowCount = 0;
        //    isGridAdvEx1.RowCount = idaPAYMENT_SETUP.SelectRows.Count;

        //    for (int i = 0; i < idaPAYMENT_SETUP.SelectRows.Count; i++)
        //    {
        //        for (int j = 0; j < idaPAYMENT_SETUP.SelectColumns.Count; j++)
        //        {

        //            isGridAdvEx1.SetCellValue(i, j, idaPAYMENT_SETUP.SelectRows[i][j]);
        //        }

        //        isGridAdvEx1.SetCellValue(i, idaPAYMENT_SETUP.SelectColumns.Count, idaPAYMENT_SETUP.SelectRows[i].RowState.ToString());
        //    }


        //}

    }
}