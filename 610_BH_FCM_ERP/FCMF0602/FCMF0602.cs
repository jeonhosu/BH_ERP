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

namespace FCMF0602
{
    public partial class FCMF0602 : Office2007Form
    {
        #region ----- Variables -----

        ISFunction.ISConvert iString = new ISFunction.ISConvert();
        ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        #endregion;

        #region ----- Constructor -----

        public FCMF0602()
        {
            InitializeComponent();
        }

        public FCMF0602(Form pMainForm, ISAppInterface pAppInterface)
        {
            InitializeComponent();
            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;
        }

        #endregion;

        #region ----- Private Methods ----

        private void Set_Default_Value()
        {
            // Budget Select Type.
            idcDEFAULT_VALUE.SetCommandParamValue("W_GROUP_CODE", "BUDGET_CAPACITY");
            idcDEFAULT_VALUE.ExecuteNonQuery();

            APPROVE_STATUS_0.EditValue =idcDEFAULT_VALUE.GetCommandParamValue("O_CODE");
            APPROVE_STATUS_NAME_0.EditValue = idcDEFAULT_VALUE.GetCommandParamValue("O_CODE_NAME");
        }

        private void SearchDB()
        {
            if (iString.ISNull(PERIOD_NAME_0.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10036"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                PERIOD_NAME_0.Focus();
                return;
            }

            idaBUDGET_ADD.Fill();
            Set_Total_Amount();
            igrBUDGET_ADD.Focus();
        }

        private void Budget_Add_Insert()
        {
            igrBUDGET_ADD.SetCellValue("BUDGET_TYPE", BUDGET_TYPE_0.EditValue);
            igrBUDGET_ADD.SetCellValue("BUDGET_TYPE_NAME", BUDGET_TYPE_NAME_0.EditValue);
            igrBUDGET_ADD.SetCellValue("BUDGET_PERIOD", PERIOD_NAME_0.EditValue);

            int mIDX_COL = igrBUDGET_ADD.GetColumnToIndex("BUDGET_TYPE_NAME");
            igrBUDGET_ADD.CurrentCellMoveTo(mIDX_COL);
            igrBUDGET_ADD.CurrentCellActivate(mIDX_COL);
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
            int vIDXCol = igrBUDGET_ADD.GetColumnToIndex("AMOUNT");
            for (int r = 0; r < idaBUDGET_ADD.SelectRows.Count; r++)
            {
                vAmount = 0;
                vAmount = igrBUDGET_ADD.GetCellValue(r, vIDXCol);
                vTotal_Amount = vTotal_Amount + iString.ISDecimaltoZero(vAmount);
            }
            TOTAL_AMOUNT.EditValue = vTotal_Amount;
        }

        private void EXE_BUDGET_ADD_STATUS(object pPERIOD_NAME, object pAPPROVE_STATUS, object pAPPROVE_FLAG)
        {
            if (iString.ISNull(pPERIOD_NAME) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10036"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                PERIOD_NAME_0.Focus();
                return;
            }
            idaBUDGET_ADD.Update(); //수정사항 반영.

            string mMESSAGE;
            idcBUDGET_ADD_STATUS.SetCommandParamValue("P_APPROVE_STATUS", pAPPROVE_STATUS);
            idcBUDGET_ADD_STATUS.SetCommandParamValue("P_APPROVE_FLAG", pAPPROVE_FLAG);
            idcBUDGET_ADD_STATUS.ExecuteNonQuery();

            mMESSAGE = iString.ISNull(idcBUDGET_ADD_STATUS.GetCommandParamValue("O_MESSAGE"));
            if (mMESSAGE != string.Empty)
            {
                MessageBoxAdv.Show(mMESSAGE, "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }

            SearchDB();
        }

        private void Set_Grid_Item_Status(DataRow pDataRow)
        {
            bool mEnabled_YN = true;
            int mIDX_Col;

            // 신청금액.
            mIDX_Col = igrBUDGET_ADD.GetColumnToIndex("AMOUNT");
            igrBUDGET_ADD.GridAdvExColElement[mIDX_Col].Insertable = 0;
            igrBUDGET_ADD.GridAdvExColElement[mIDX_Col].Updatable = 0;
            igrBUDGET_ADD.GridAdvExColElement[mIDX_Col].ReadOnly = true;
            // 신청사유.
            mIDX_Col = igrBUDGET_ADD.GetColumnToIndex("CAUSE_NAME");
            igrBUDGET_ADD.GridAdvExColElement[mIDX_Col].Insertable = 0;
            igrBUDGET_ADD.GridAdvExColElement[mIDX_Col].Updatable = 0;
            igrBUDGET_ADD.GridAdvExColElement[mIDX_Col].ReadOnly = true;
            // 비고.
            mIDX_Col = igrBUDGET_ADD.GetColumnToIndex("DESCRIPTION");
            igrBUDGET_ADD.GridAdvExColElement[mIDX_Col].Insertable = 0;
            igrBUDGET_ADD.GridAdvExColElement[mIDX_Col].Updatable = 0;
            igrBUDGET_ADD.GridAdvExColElement[mIDX_Col].ReadOnly = true;
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
                    // 신청금액.
                    mIDX_Col = igrBUDGET_ADD.GetColumnToIndex("AMOUNT");
                    igrBUDGET_ADD.GridAdvExColElement[mIDX_Col].Insertable = 1;
                    igrBUDGET_ADD.GridAdvExColElement[mIDX_Col].Updatable = 1;
                    igrBUDGET_ADD.GridAdvExColElement[mIDX_Col].ReadOnly = false;
                    // 신청사유.
                    mIDX_Col = igrBUDGET_ADD.GetColumnToIndex("CAUSE_NAME");
                    igrBUDGET_ADD.GridAdvExColElement[mIDX_Col].Insertable = 1;
                    igrBUDGET_ADD.GridAdvExColElement[mIDX_Col].Updatable = 1;
                    igrBUDGET_ADD.GridAdvExColElement[mIDX_Col].ReadOnly = false;
                    // 비고.
                    mIDX_Col = igrBUDGET_ADD.GetColumnToIndex("DESCRIPTION");
                    igrBUDGET_ADD.GridAdvExColElement[mIDX_Col].Insertable = 1;
                    igrBUDGET_ADD.GridAdvExColElement[mIDX_Col].Updatable = 1;
                    igrBUDGET_ADD.GridAdvExColElement[mIDX_Col].ReadOnly = false;
                }
            }
            igrBUDGET_ADD.ResetDraw = true;
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
                    if (idaBUDGET_ADD.IsFocused)
                    {
                        idaBUDGET_ADD.AddOver();
                        Budget_Add_Insert();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddUnder)
                {
                    if (idaBUDGET_ADD.IsFocused)
                    {
                        idaBUDGET_ADD.AddUnder();
                        Budget_Add_Insert();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Update)
                {
                    if (idaBUDGET_ADD.IsFocused)
                    {
                        try
                        {
                            idaBUDGET_ADD.Update();
                        }
                        catch
                        {
                        }
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Cancel)
                {
                    if (idaBUDGET_ADD.IsFocused)
                    {
                        idaBUDGET_ADD.Cancel();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {
                    if (idaBUDGET_ADD.IsFocused)
                    {
                        idaBUDGET_ADD.Delete();
                    }
                }
            }
        }

        #endregion;

        #region ----- Form Event -----

        private void FCMF0602_Load(object sender, EventArgs e)
        {
            idaBUDGET_ADD.FillSchema();
        }

        private void FCMF0602_Shown(object sender, EventArgs e)
        {
            PERIOD_NAME_0.EditValue = iDate.ISYearMonth(DateTime.Today);
            icbALL_RECORD_FLAG.CheckBoxValue = "N";
        }

        private void ibtREQ_APPROVE_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            idaBUDGET_ADD.Update();

            object mValue;
            int mRowCount = igrBUDGET_ADD.RowCount;
            int mIDX_COL = igrBUDGET_ADD.GetColumnToIndex("APPROVE_STATUS");

            for (int R = 0; R < mRowCount; R++)
            {
                if (iString.ISNull(igrBUDGET_ADD.GetCellValue(R, mIDX_COL)) == "N".ToString())
                {// 승인미요청 건에 대해서 승인 처리.
                    idcAPPROVE_REQUEST.SetCommandParamValue("W_BUDGET_TYPE", igrBUDGET_ADD.GetCellValue(R, igrBUDGET_ADD.GetColumnToIndex("BUDGET_TYPE")));
                    idcAPPROVE_REQUEST.SetCommandParamValue("W_BUDGET_PERIOD", igrBUDGET_ADD.GetCellValue(R, igrBUDGET_ADD.GetColumnToIndex("BUDGET_PERIOD")));
                    idcAPPROVE_REQUEST.SetCommandParamValue("W_DEPT_ID", igrBUDGET_ADD.GetCellValue(R, igrBUDGET_ADD.GetColumnToIndex("DEPT_ID")));
                    idcAPPROVE_REQUEST.SetCommandParamValue("W_ACCOUNT_CONTROL_ID", igrBUDGET_ADD.GetCellValue(R, igrBUDGET_ADD.GetColumnToIndex("ACCOUNT_CONTROL_ID")));
                    idcAPPROVE_REQUEST.ExecuteNonQuery();

                    mValue = DBNull.Value;
                    mValue = idcAPPROVE_REQUEST.GetCommandParamValue("O_APPROVE_STATUS");
                    igrBUDGET_ADD.SetCellValue(R, igrBUDGET_ADD.GetColumnToIndex("APPROVE_STATUS"), mValue);

                    mValue = DBNull.Value;
                    mValue = idcAPPROVE_REQUEST.GetCommandParamValue("O_APPROVE_STATUS_NAME");
                    igrBUDGET_ADD.SetCellValue(R, igrBUDGET_ADD.GetColumnToIndex("APPROVE_STATUS_NAME"), mValue);
                }
            }
            idaBUDGET_ADD.OraSelectData.AcceptChanges();
            idaBUDGET_ADD.Refillable = true;
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
            SetCommonParameter_W("BUDGET_TYPE", "Value1 = 'ADD'", "N");
        }

        private void ilaAPPROVE_STATUS_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter("BUDGET_CAPACITY", DBNull.Value, "N");
        }

        private void ilaACCOUNT_CONTROL_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildACCOUNT_CONTROL.SetLookupParamValue("W_BUDGET_CONTROL_YN", "N");
            ildACCOUNT_CONTROL.SetLookupParamValue("W_ENABLED_YN", "N");
        }

        private void ilaBUDGET_TYPE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter_W("BUDGET_TYPE", "Value1 = 'ADD'", "Y");
        }

        private void ilaDEPT_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildDEPT.SetLookupParamValue("W_DEPT_CODE_FR", null);
            ildDEPT.SetLookupParamValue("W_ENABLED_YN", "Y");
            ildDEPT.SetLookupParamValue("W_CHECK_CAPACITY", "C");
        }

        private void ilaACCOUNT_CONTROL_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildACCOUNT_CONTROL.SetLookupParamValue("W_BUDGET_CONTROL_YN", "N");
            ildACCOUNT_CONTROL.SetLookupParamValue("W_ENABLED_YN", "Y");
        }

        private void ilaCAUSE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter_W("BUDGET_CAUSE", "Value1 = 'ADD'", "Y");
        }

        #endregion

        #region ----- Adapter Event -----
        
        private void idaBUDGET_ADD_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {
            if (iString.ISNull(e.Row["BUDGET_TYPE"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Budget Type(예산타입)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
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

        private void idaBUDGET_ADD_PreDelete(ISPreDeleteEventArgs e)
        {
            if (iString.ISNull(e.Row["LAST_YN"]) == "N".ToString())
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10262"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
        }

        private void idaBUDGET_ADD_PreNewRowMoved(object pSender, ISBindingEventArgs pBindingManager)
        {
            Set_Grid_Item_Status(pBindingManager.DataRow);
        }

        #endregion

    }
}