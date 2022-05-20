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

namespace FCMF0601
{
    public partial class FCMF0601 : Office2007Form
    {
        #region ----- Variables -----
        ISFunction.ISConvert iString = new ISFunction.ISConvert();
        ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        #endregion;

        #region ----- Constructor -----

        public FCMF0601()
        {
            InitializeComponent();
        }

        public FCMF0601(Form pMainForm, ISAppInterface pAppInterface)
        {
            InitializeComponent();
            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;
        }

        #endregion;

        #region ----- Private Methods ----

        private void Search_DB()
        {
            if (iString.ISNull(BUDGET_YEAR_0.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10022"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                BUDGET_YEAR_0.Focus();
                return;
            }

            idaBUDGET.SetSelectParamValue("P_BUDGET_CONTROL_YN", "N");
            idaBUDGET.SetSelectParamValue("P_CHECK_CAPACITY", "Y");

            idaBUDGET_ACCOUNT.SetSelectParamValue("P_CHECK_CAPACITY", "C");
            idaBUDGET_ACCOUNT.SetSelectParamValue("P_ENABLED_YN", "Y");
            idaBUDGET_ACCOUNT.Fill();

            igrBUDGET_ACCOUNT.Focus();
            //Set_Total_Amount();
        }

        //private void Set_Total_Amount()
        //{
        //    decimal vTotal_Base_Amount = 0;
        //    decimal vTotal_Add_Amount = 0;
        //    decimal vTotal_Move_Amount = 0;
        //    decimal vTotal_Next_Amount = 0;
        //    object vAmount;
        //    int vIDX_Base_Col = igrBUDGET.GetColumnToIndex("BASE_AMOUNT");
        //    int vIDX_Add_Col = igrBUDGET.GetColumnToIndex("ADD_AMOUNT");
        //    int vIDX_Move_Col = igrBUDGET.GetColumnToIndex("MOVE_AMOUNT");
        //    int vIDX_Next_Col = igrBUDGET.GetColumnToIndex("NEXT_AMOUNT");

        //    for (int r = 0; r < idaBUDGET.SelectRows.Count; r++)
        //    {
        //        vAmount = 0;
        //        vAmount = igrBUDGET.GetCellValue(r, vIDX_Base_Col);
        //        vTotal_Base_Amount = vTotal_Base_Amount + iString.ISDecimaltoZero(vAmount);

        //        vAmount = 0;
        //        vAmount = igrBUDGET.GetCellValue(r, vIDX_Add_Col);
        //        vTotal_Add_Amount = vTotal_Add_Amount + iString.ISDecimaltoZero(vAmount);

        //        vAmount = 0;
        //        vAmount = igrBUDGET.GetCellValue(r, vIDX_Move_Col);
        //        vTotal_Move_Amount = vTotal_Move_Amount + iString.ISDecimaltoZero(vAmount);

        //        vAmount = 0;
        //        vAmount = igrBUDGET.GetCellValue(r, vIDX_Next_Col);
        //        vTotal_Next_Amount = vTotal_Next_Amount + iString.ISDecimaltoZero(vAmount);
        //    }
        //    TOTAL_BASE_AMOUNT.EditValue = vTotal_Base_Amount;
        //    TOTAL_ADD_AMOUNT.EditValue = vTotal_Add_Amount;
        //    TOTAL_MOVE_AMOUNT.EditValue = vTotal_Move_Amount;
        //    TOTAL_NEXT_AMOUNT.EditValue = vTotal_Next_Amount;
        //}

        private void Set_CheckBox(int pIDX_Col)
        {// 그리드 체크박스 전체 선택/ 선택 취소 기능.
            string mCheckBox_Value;
            for (int r = 0; r < igrBUDGET.RowCount; r++)
            {
                mCheckBox_Value = iString.ISNull(igrBUDGET.GetCellValue(r, pIDX_Col), "N");
                if (mCheckBox_Value == "Y".ToString())
                {
                    igrBUDGET.SetCellValue(r, pIDX_Col, "N");
                }
                else
                {
                    igrBUDGET.SetCellValue(r, pIDX_Col, "Y");
                }
            }
        }

        #endregion;

        #region ----- Events -----

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
                    if (idaBUDGET.IsFocused)
                    {
                        idaBUDGET.Update();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Cancel)
                {
                    if (idaBUDGET.IsFocused)
                    {
                        idaBUDGET.Cancel();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {
                    
                }
            }
        }

        #endregion;

        #region ----- Forms Event ------
        
        private void FCMF0601_Load(object sender, EventArgs e)
        {
            idaBUDGET_ACCOUNT.FillSchema();
        }

        private void FCMF0601_Shown(object sender, EventArgs e)
        {
            BUDGET_YEAR_0.EditValue = DateTime.Today.Year;
        }

        private void igrBUDGET_CellDoubleClick(object pSender)
        {
            if (igrBUDGET.RowIndex < 0 && igrBUDGET.ColIndex == igrBUDGET.GetColumnToIndex("MOVE_YN"))
            {
                Set_CheckBox(igrBUDGET.ColIndex);
            }
            else if (igrBUDGET.RowIndex < 0 && igrBUDGET.ColIndex == igrBUDGET.GetColumnToIndex("NEXT_PERIOD_YN"))
            {
                Set_CheckBox(igrBUDGET.ColIndex);
            }
            else if (igrBUDGET.RowIndex < 0 && igrBUDGET.ColIndex == igrBUDGET.GetColumnToIndex("ENABLED_YN"))
            {
                Set_CheckBox(igrBUDGET.ColIndex);
            }
            else if (igrBUDGET.RowIndex < 0 && igrBUDGET.ColIndex == igrBUDGET.GetColumnToIndex("CLOSED_YN"))
            {
                Set_CheckBox(igrBUDGET.ColIndex);
            }
        }
        
        //private void ibtnEXE_NEXT_ButtonClick(object pSender, EventArgs pEventArgs)
        //{
        //    string mMESSAGE;
        //    if (iString.ISNull(PERIOD_NAME_0.EditValue) == string.Empty)
        //    {
        //        MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10036"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
        //        PERIOD_NAME_0.Focus();
        //        return;
        //    }
        //    idcEXE_BUDGET_NEXT_PERIOD.ExecuteNonQuery();
        //    mMESSAGE = iString.ISNull(idcEXE_BUDGET_NEXT_PERIOD.GetCommandParamValue("O_MESSAGE"));
        //    if (mMESSAGE != string.Empty)
        //    {
        //        MessageBoxAdv.Show(mMESSAGE, "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);
        //    }           
        //}

        //private void ibtnEXE_CLOSE_ButtonClick(object pSender, EventArgs pEventArgs)
        //{
        //    string mMESSAGE;
        //    if (iString.ISNull(PERIOD_NAME_0.EditValue) == string.Empty)
        //    {
        //        MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10036"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
        //        PERIOD_NAME_0.Focus();
        //        return;
        //    }
        //    idcBUDGET_CLOSE.ExecuteNonQuery();
        //    mMESSAGE = iString.ISNull(idcBUDGET_CLOSE.GetCommandParamValue("O_MESSAGE"));
        //    if (mMESSAGE != string.Empty)
        //    {
        //        MessageBoxAdv.Show(mMESSAGE, "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);
        //    }
        //}

        #endregion

        #region ----- Lookup Event ------

        private void ilaACCOUNT_CONTROL_FR_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildACCOUNT_CONTROL.SetLookupParamValue("W_ACCOUNT_CODE_FR", null);
            ildACCOUNT_CONTROL.SetLookupParamValue("W_ENABLED_YN", "N");
        }

        private void ilaACCOUNT_CONTROL_TO_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildACCOUNT_CONTROL.SetLookupParamValue("W_ACCOUNT_CODE_FR", ACCOUNT_CODE_FR_0.EditValue);
            ildACCOUNT_CONTROL.SetLookupParamValue("W_ENABLED_YN", "N");
        }

        private void ilaDEPT_FR_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildDEPT_FR_TO.SetLookupParamValue("W_DEPT_CODE_FR", null);
            ildDEPT_FR_TO.SetLookupParamValue("W_CHECK_CAPACITY", "C");
            ildDEPT_FR_TO.SetLookupParamValue("W_ENABLED_YN", "N");
        }

        private void ilaDEPT_TO_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildDEPT_FR_TO.SetLookupParamValue("W_DEPT_CODE_FR", DEPT_CODE_FR_0.EditValue);
            ildDEPT_FR_TO.SetLookupParamValue("W_CHECK_CAPACITY", "C");
            ildDEPT_FR_TO.SetLookupParamValue("W_ENABLED_YN", "N");
        }

        private void ilaACCOUNT_CONTROL_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildACCOUNT_CONTROL.SetLookupParamValue("W_ENABLED_YN", "N");
        }

        #endregion

        #region ----- Adapter Event -----

        private void idaBUDGET_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {
            if (iString.ISNull(e.Row["BUDGET_PERIOD"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Budget Period(예산년월)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["DEPT_ID"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Department(부서)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["ACCOUNT_CONTROL_ID"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Account Code(계정)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
        }

        private void idaBUDGET_PreDelete(ISPreDeleteEventArgs e)
        {
            if (e.Row.RowState != DataRowState.Added)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10029", "&&VALUE:=Data(데이터)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);        // 모듈 코드 입력
                e.Cancel = true;
                return;
            }
        }

        #endregion

    }
}