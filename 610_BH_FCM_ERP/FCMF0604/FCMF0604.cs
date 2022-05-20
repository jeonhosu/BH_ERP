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

namespace FCMF0604
{
    public partial class FCMF0604 : Office2007Form
    {
        #region ----- Variables -----

        ISFunction.ISConvert iString = new ISFunction.ISConvert();
        ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        #endregion;

        #region ----- Constructor -----

        public FCMF0604()
        {
            InitializeComponent();
        }

        public FCMF0604(Form pMainForm, ISAppInterface pAppInterface)
        {
            InitializeComponent();
            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;
        }

        #endregion;

        #region ----- Private Methods ----

        private void Set_Default_CAPACITY()
        {
            // Budget Select Type.
            idcDEFAULT_VALUE.SetCommandParamValue("W_GROUP_CODE", "BUDGET_CAPACITY");
            idcDEFAULT_VALUE.ExecuteNonQuery();

            APPROVE_STATUS_0.EditValue = idcDEFAULT_VALUE.GetCommandParamValue("O_CODE");
            APPROVE_STATUS_NAME_0.EditValue = idcDEFAULT_VALUE.GetCommandParamValue("O_CODE_NAME");
        }

        private void Set_Default_Value()
        {
            // Budget Select Type.
            idcDEFAULT_VALUE.SetCommandParamValue("W_GROUP_CODE", "BUDGET_SELECT_TYPE");
            idcDEFAULT_VALUE.ExecuteNonQuery();

            SELECT_TYPE_0.EditValue = idcDEFAULT_VALUE.GetCommandParamValue("O_CODE");
            SELECT_TYPE_NAME_0.EditValue = idcDEFAULT_VALUE.GetCommandParamValue("O_CODE_NAME");            
        }

        private void SearchDB()
        {
            if (iString.ISNull(PERIOD_NAME_0.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10036"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                PERIOD_NAME_0.Focus();
                return;
            }

            idaBUDGET_MOVE.Fill();
            Set_Total_Amount();
            igrBUDGET_MOVE.Focus();
        }

        private void Budget_Move_Insert()
        {
            BUDGET_PERIOD.EditValue = PERIOD_NAME_0.EditValue;
            BUDGET_PERIOD.Focus();
        }

        private void SetCommonParameter(object pGroupCode, object pCodeName, object pEnabled_YN)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", pGroupCode);
            ildCOMMON.SetLookupParamValue("W_CODE_NAME", pCodeName);
            ildCOMMON.SetLookupParamValue("W_ENABLED_YN", pEnabled_YN);
        }

        private void SetCommonParameter_W(object pGroupCode, object pWhere, object pEnabled_YN)
        {
            ildCOMMON_W.SetLookupParamValue("W_GROUP_CODE", pGroupCode);
            ildCOMMON_W.SetLookupParamValue("W_WHERE", pWhere);
            ildCOMMON_W.SetLookupParamValue("W_ENABLED_YN", pEnabled_YN);
        }

        private void Set_Total_Amount()
        {
            decimal vTotal_Amount = 0;
            object vAmount;
            int vIDXCol = igrBUDGET_MOVE.GetColumnToIndex("AMOUNT");
            for (int r = 0; r < idaBUDGET_MOVE.SelectRows.Count; r++)
            {
                vAmount = 0;
                vAmount = igrBUDGET_MOVE.GetCellValue(r, vIDXCol);
                vTotal_Amount = vTotal_Amount + iString.ISDecimaltoZero(vAmount);
            }
            TOTAL_AMOUNT.EditValue = vTotal_Amount;
        }

        private void Set_Approve_Request()      // 승인요청.
        {
            object mValue;
            int mRowCount = igrBUDGET_MOVE.RowCount;
            int mIDX_COL = igrBUDGET_MOVE.GetColumnToIndex("APPROVE_STATUS");

            for (int R = 0; R < mRowCount; R++)
            {
                if (iString.ISNull(igrBUDGET_MOVE.GetCellValue(R, mIDX_COL)) == "N".ToString())
                {// 승인미요청 건에 대해서 승인 처리.
                    idcAPPROVE_REQUEST.SetCommandParamValue("W_BUDGET_PERIOD", igrBUDGET_MOVE.GetCellValue(R, igrBUDGET_MOVE.GetColumnToIndex("BUDGET_PERIOD")));
                    idcAPPROVE_REQUEST.SetCommandParamValue("W_FROM_DEPT_ID", igrBUDGET_MOVE.GetCellValue(R, igrBUDGET_MOVE.GetColumnToIndex("FROM_DEPT_ID")));
                    idcAPPROVE_REQUEST.SetCommandParamValue("W_FROM_ACCOUNT_CONTROL_ID", igrBUDGET_MOVE.GetCellValue(R, igrBUDGET_MOVE.GetColumnToIndex("FROM_ACCOUNT_CONTROL_ID")));
                    idcAPPROVE_REQUEST.SetCommandParamValue("W_TO_DEPT_ID", igrBUDGET_MOVE.GetCellValue(R, igrBUDGET_MOVE.GetColumnToIndex("TO_DEPT_ID")));
                    idcAPPROVE_REQUEST.SetCommandParamValue("W_TO_ACCOUNT_CONTROL_ID", igrBUDGET_MOVE.GetCellValue(R, igrBUDGET_MOVE.GetColumnToIndex("TO_ACCOUNT_CONTROL_ID")));
                    idcAPPROVE_REQUEST.ExecuteNonQuery();

                    mValue = DBNull.Value;
                    mValue = idcAPPROVE_REQUEST.GetCommandParamValue("O_APPROVE_STATUS");
                    igrBUDGET_MOVE.SetCellValue(R, igrBUDGET_MOVE.GetColumnToIndex("APPROVE_STATUS"), mValue);

                    mValue = DBNull.Value;
                    mValue = idcAPPROVE_REQUEST.GetCommandParamValue("O_APPROVE_STATUS_NAME");
                    igrBUDGET_MOVE.SetCellValue(R, igrBUDGET_MOVE.GetColumnToIndex("APPROVE_STATUS_NAME"), mValue);
                }
            }
            idaBUDGET_MOVE.OraSelectData.AcceptChanges();
            idaBUDGET_MOVE.Refillable = true;
        }

        private void EXE_BUDGET_ADD_STATUS(object pPERIOD_NAME, object pAPPROVE_STATUS, object pAPPROVE_FLAG)
        {
            if (iString.ISNull(pPERIOD_NAME) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10036"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                PERIOD_NAME_0.Focus();
                return;
            }
            idaBUDGET_MOVE.Update(); //수정사항 반영.

            string mMESSAGE;
            idcBUDGET_MOVE_STATUS.SetCommandParamValue("P_APPROVE_STATUS", pAPPROVE_STATUS);
            idcBUDGET_MOVE_STATUS.SetCommandParamValue("P_APPROVE_FLAG", pAPPROVE_FLAG);
            idcBUDGET_MOVE_STATUS.ExecuteNonQuery();

            mMESSAGE = iString.ISNull(idcBUDGET_MOVE_STATUS.GetCommandParamValue("O_MESSAGE"));
            if (mMESSAGE != string.Empty)
            {
                MessageBoxAdv.Show(mMESSAGE, "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }

            SearchDB();
        }

        private void Set_Grid_Item_Status(DataRow pDataRow)
        {
            bool mEnabled_YN = true;

            // 신청금액.
            AMOUNT.Updatable = false;
            CAUSE_NAME.Updatable = false;
            DESCRIPTION.Updatable = false;
            if (pDataRow != null)
            {
                if (iString.ISNull(icbALL_RECORD_FLAG.CheckBoxValue) == "Y".ToString() ||
                    (iString.ISNull(pDataRow["APPROVE_STATUS"]) != "A".ToString() &&
                    iString.ISNull(pDataRow["APPROVE_STATUS"]) != "N".ToString()))
                {
                    if (pDataRow.RowState != DataRowState.Added)
                    {
                        mEnabled_YN = false;
                    }
                }
                if (mEnabled_YN == true)
                {
                    AMOUNT.Updatable = true;
                    CAUSE_NAME.Updatable = true;
                    DESCRIPTION.Updatable = true;
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
                    SearchDB();
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddOver)
                {
                    if (idaBUDGET_MOVE.IsFocused)
                    {
                        idaBUDGET_MOVE.AddOver();
                        Budget_Move_Insert();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddUnder)
                {
                    if (idaBUDGET_MOVE.IsFocused)
                    {
                        idaBUDGET_MOVE.AddUnder();
                        Budget_Move_Insert();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Update)
                {
                    if (idaBUDGET_MOVE.IsFocused)
                    {
                        try
                        {
                            idaBUDGET_MOVE.Update();
                        }
                        catch
                        {
                        }
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Cancel)
                {
                    if (idaBUDGET_MOVE.IsFocused)
                    {
                        idaBUDGET_MOVE.Cancel();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {
                    if (idaBUDGET_MOVE.IsFocused)
                    {
                        idaBUDGET_MOVE.Delete();
                    }
                }
            }
        }

        #endregion;

        #region ----- Form Event -----

        private void FCMF0604_Load(object sender, EventArgs e)
        {
            idaBUDGET_MOVE.FillSchema();
        }

        private void FCMF0604_Shown(object sender, EventArgs e)
        {            
            PERIOD_NAME_0.EditValue = iDate.ISYearMonth(DateTime.Today);
            icbALL_RECORD_FLAG.CheckBoxValue = "N";
            Set_Default_Value();
        }

        private void ibtREQ_APPROVE_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            idaBUDGET_MOVE.Update();
            Set_Approve_Request();     // 승인요청.            
        }

        private void ibtnOK_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            EXE_BUDGET_ADD_STATUS(PERIOD_NAME_0.EditValue, "A", "OK");
        }

        private void ibtnCANCEL_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            EXE_BUDGET_ADD_STATUS(PERIOD_NAME_0.EditValue, "C", "CANCEL");
        }

        #endregion
        
        #region ----- Lookup Event -----

        private void ilaDEPT_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildDEPT.SetLookupParamValue("W_DEPT_CODE_FR", null);
            ildDEPT.SetLookupParamValue("W_ENABLED_YN", "N");
            ildDEPT.SetLookupParamValue("W_CHECK_CAPACITY", "C");
        }

        private void ilaBUDGET_TYPE_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter_W("BUDGET_TYPE", "Value1 = 'MOVE'", "N");
        }

        private void ilaAPPROVE_STATUS_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter("BUDGET_CAPACITY", DBNull.Value, "N");
        }

        private void ilaACCOUNT_CONTROL_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildACCOUNT_CONTROL.SetLookupParamValue("W_ENABLED_YN", "N");
        }

        private void ilaBUDGET_TYPE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter_W("BUDGET_TYPE", "Value1 = 'MOVE'", "Y");
        }

        private void ilaFROM_DEPT_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildDEPT.SetLookupParamValue("W_DEPT_CODE_FR", null);
            ildDEPT.SetLookupParamValue("W_ENABLED_YN", "Y");
            ildDEPT.SetLookupParamValue("W_CHECK_CAPACITY", "C");
        }

        private void ilaTO_DEPT_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildDEPT.SetLookupParamValue("W_DEPT_CODE_FR", null);
            ildDEPT.SetLookupParamValue("W_ENABLED_YN", "Y");
            ildDEPT.SetLookupParamValue("W_CHECK_CAPACITY", "C");
        }
        
        private void ilaFROM_ACCOUNT_CONTROL_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildACCOUNT_CONTROL.SetLookupParamValue("W_ENABLED_YN", "Y");
        }

        private void ilaTO_ACCOUNT_CONTROL_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildACCOUNT_CONTROL.SetLookupParamValue("W_ENABLED_YN", "Y");
        }

        private void ilaCAUSE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter_W("BUDGET_CAUSE", "Value1 = 'MOVE'", "Y");
        }

        private void ilaSELECT_TYPE_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter("BUDGET_SELECT_TYPE", DBNull.Value, "Y");
        }

        #endregion

        #region ----- Adapter Event -----

        private void idaBUDGET_MOVE_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {
            if (iString.ISNull(e.Row["BUDGET_PERIOD"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Budget Period(예산년월)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["FROM_DEPT_ID"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=From Department(전용 (전) 부서)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["FROM_ACCOUNT_CONTROL_ID"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=From Account Code(전용 (전) 계정)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["TO_DEPT_ID"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=To Department(전용 (후) 부서)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["TO_ACCOUNT_CONTROL_ID"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=TO Account Code(전용 (후) 계정)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["FROM_ACCOUNT_CONTROL_ID"]) == iString.ISNull(e.Row["TO_ACCOUNT_CONTROL_ID"]))
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10267"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["AMOUNT"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Amount(예산금액)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["CAUSE_ID"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Cause(신청사유)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
        }

        private void idaBUDGET_MOVE_PreDelete(ISPreDeleteEventArgs e)
        {
            if (iString.ISNull(e.Row["LAST_YN"]) == "N".ToString())
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10262"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
        }

        private void idaBUDGET_MOVE_PreNewRowMoved(object pSender, ISBindingEventArgs pBindingManager)
        {
            Set_Grid_Item_Status(pBindingManager.DataRow);
        }

        #endregion

    }
}