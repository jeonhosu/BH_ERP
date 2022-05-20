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

namespace HRMF9501
{
    public partial class HRMF9501 : Office2007Form
    {
        #region ----- Variables -----

        private ISFunction.ISConvert iString = new ISFunction.ISConvert();
        private ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        #endregion;
        
        #region ----- Constructor -----

        public HRMF9501(Form pMainForm, ISAppInterface pAppInterface)
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
        }

        private void Initial_Insert_Pay_Master()
        {
            // Pay Master Initial....
            igrCOMMON_HEADER.SetCellValue("START_YYYYMM", iDate.ISMonth_1st(STD_YYYYMM_0.EditValue));
            igrCOMMON_HEADER.SetCellValue("CORP_ID", CORP_ID_0.EditValue);
            igrCOMMON_HEADER.SetCellValue("CORP_NAME", CORP_NAME_0.EditValue);
            igrCOMMON_HEADER.SetCellValue("PAY_PROVIDE_YN", "Y");
            igrCOMMON_HEADER.SetCellValue("BONUS_PROVIDE_YN", "Y");
            igrCOMMON_HEADER.SetCellValue("YEAR_PROVIDE_YN", "Y");
            igrCOMMON_HEADER.SetCellValue("INSUR_YN", "Y");
            igrCOMMON_HEADER.CurrentCellMoveTo(igrCOMMON_HEADER.GetColumnToIndex("CORP_NAME"));
            igrCOMMON_HEADER.CurrentCellActivate(igrCOMMON_HEADER.GetColumnToIndex("CORP_NAME"));

            HEADER_DATA_STATE.EditValue = "U";
            igrCOMMON_HEADER.Focus();
        }

        private void Initial_Insert_Allowance()
        {
            igrPAY_ALLOWANCE.SetCellValue("ENABLED_FLAG", "Y");
        }

        private void Initial_Insert_Deduction()
        {
            igrPAY_DEDUCTION.SetCellValue("ENABLED_FLAG", "Y");
        }

        private void Search_DB()
        {
            if (iString.ISNull(STD_YYYYMM_0.EditValue) == String.Empty)
            {// 시작일자
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10036"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                STD_YYYYMM_0.Focus();
                return;
            }
            idaCOMMON_HEADER.Fill();
            igrCOMMON_HEADER.Focus();
        }

        private void isSet_Adapter_Status()
        {
            for (int hr = 0; hr < idaCOMMON_HEADER.SelectRows.Count; hr++)
            {
                if (idaCOMMON_HEADER.SelectRows[hr].RowState != DataRowState.Unchanged)
                {
                    for (int r = 0; r < igrPAY_ALLOWANCE.RowCount; r++)
                    {//지급사항 수정.
                        idaPAY_ALLOWANCE.SelectRows[r].AcceptChanges();
                        idaPAY_ALLOWANCE.SelectRows[r].SetAdded();
                    }

                    for (int r = 0; r < igrPAY_DEDUCTION.RowCount ; r++)
                    {//공제사항 수정.
                        idaPAY_DEDUCTION.SelectRows[r].AcceptChanges();
                        idaPAY_DEDUCTION.SelectRows[r].SetAdded();
                    }
                }
            }
        }

        private void isSet_HEADER_Status()
        {
            int vIDX_START_YYYYMM = igrCOMMON_HEADER.GetColumnToIndex("START_YYYYMM");
            idaCOMMON_HEADER.MoveFirst("");
            igrCOMMON_HEADER.BeginUpdate();
            for (int i = 0; i < idaCOMMON_HEADER.CurrentRows.Count; i++)
            {
                if (idaCOMMON_HEADER.CurrentRows[i].RowState == DataRowState.Unchanged)
                {
                    for (int j = 0; j < idaPAY_ALLOWANCE.CurrentRows.Count; j++)
                    {
                        if (idaPAY_ALLOWANCE.CurrentRows[j].RowState != DataRowState.Unchanged)
                        {
                            if (idaCOMMON_HEADER.CurrentRows[i].RowState == DataRowState.Unchanged)
                            {
                                igrCOMMON_HEADER.SetCellValue(j, vIDX_START_YYYYMM , STD_YYYYMM_0.EditValue);
                            }
                        }
                    }
                    idaCOMMON_HEADER.MoveNext("");
                }
            }
            igrCOMMON_HEADER.EndUpdate();

            //foreach (DataRow row in idaPAY_ALLOWANCE.OraSelectData.Rows)
            //{
            //    if (row.RowState != DataRowState.Unchanged)
            //    {
            //        object vob = row["MasterKeyId"];
            //        idaPAY_MASTER_HEADER.OraSelectData.Rows[(int)row["MasterKeyId"]]["START_YYYYMM"] = STD_YYYYMM_0.EditValue;
            //    }
            //}

            //decimal vPAY_HEADER_ID = 0;
            // 지급항목 변경 여부 체크 하여 헤더 상태 변경//
            //for (int vROW = 0; vROW < idaPAY_ALLOWANCE.SelectRows.Count; vROW++)
            //{
            //    if (idaPAY_ALLOWANCE.SelectRows[vROW].RowState != DataRowState.Unchanged)
            //    {
            //        if (idaPAY_ALLOWANCE.MasterAdapter.CurrentRow.RowState == DataRowState.Unchanged)
            //        {
            //            idaPAY_ALLOWANCE.MasterAdapter.CurrentRow["START_YYYYMM"] = STD_YYYYMM_0.EditValue;
            //        }

            //        //vPAY_HEADER_ID = iString.ISDecimaltoZero(idaPAY_ALLOWANCE.SelectRows[vROW]["PAY_HEADER_ID"]);
            //        //idaPAY_MASTER_HEADER.MoveFirst(START_YYYYMM.Name);
            //        //for (int r = 0; r < idaPAY_MASTER_HEADER.SelectRows.Count; r++)
            //        //{
            //        //    if (iString.ISDecimaltoZero(idaPAY_MASTER_HEADER.SelectRows[r]["PAY_HEADER_ID"]) == vPAY_HEADER_ID)
            //        //    {
            //        //        if (idaPAY_MASTER_HEADER.SelectRows[r].RowState == DataRowState.Unchanged)
            //        //        {
            //        //            //위치 이동(아답터)
            //        //            idaPAY_ALLOWANCE.MasterAdapter.CurrentRow["START_YYYYMM"] = STD_YYYYMM_0.EditValue;
            //        //            idaPAY_ALLOWANCE.MasterAdapter.CurrentRow.SetModified();
            //        //        }
            //        //    }
            //        //}
            //    }
            //}

            //// 공제항목 변경 여부 체크 하여 헤더 상태 변경//
            //for (int vROW = 0; vROW < idaPAY_DEDUCTION.SelectRows.Count; vROW++)
            //{
            //    if (idaPAY_DEDUCTION.SelectRows[vROW].RowState != DataRowState.Unchanged)
            //    {
            //        vPAY_HEADER_ID = iString.ISDecimaltoZero(idaPAY_DEDUCTION.SelectRows[vROW]["PAY_HEADER_ID"]);
            //        for (int r = 0; r < idaPAY_MASTER_HEADER.SelectRows.Count; r++)
            //        {
            //            if (iString.ISDecimaltoZero(idaPAY_MASTER_HEADER.SelectRows[r]["PAY_HEADER_ID"]) == vPAY_HEADER_ID)
            //            {
            //                if (idaPAY_MASTER_HEADER.SelectRows[r].RowState == DataRowState.Unchanged)
            //                {
            //                    idaPAY_ALLOWANCE.MasterAdapter.CurrentRow["START_YYYYMM"] = STD_YYYYMM_0.EditValue;
            //                    idaPAY_ALLOWANCE.MasterAdapter.CurrentRow.SetModified();
            //                }
            //            }
            //        }
            //    }
            //}
        }

        #endregion;

        #region ----- Convert decimal  Method ----

        private decimal ConvertNumber(object pObject)
        {
            bool vIsConvert = false;
            decimal vConvertDecimal = 0m;

            try
            {
                if (pObject != null)
                {
                    vIsConvert = pObject is decimal;
                    if (vIsConvert == true)
                    {
                        decimal vIsConvertNum = (decimal)pObject;
                        vConvertDecimal = vIsConvertNum;
                    }
                }

            }
            catch (System.Exception ex)
            {
                isAppInterfaceAdv1.OnAppMessage(ex.Message);
            }

            return vConvertDecimal;
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
                    if (idaCOMMON_HEADER.IsFocused)
                    {
                        idaCOMMON_HEADER.AddOver();
                        Initial_Insert_Pay_Master();
                    }
                    else if (idaPAY_ALLOWANCE.IsFocused)
                    {
                        idaPAY_ALLOWANCE.AddOver();
                        Initial_Insert_Allowance();
                    }
                    else if (idaPAY_DEDUCTION.IsFocused)
                    {
                        idaPAY_DEDUCTION.AddOver();
                        Initial_Insert_Deduction();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddUnder)
                {
                    if (idaCOMMON_HEADER.IsFocused)
                    {
                        idaCOMMON_HEADER.AddUnder();
                        Initial_Insert_Pay_Master();
                    }
                    else if (idaPAY_ALLOWANCE.IsFocused)
                    {
                        idaPAY_ALLOWANCE.AddUnder();
                        Initial_Insert_Allowance();
                    }
                    else if (idaPAY_DEDUCTION.IsFocused)
                    {
                        idaPAY_DEDUCTION.AddUnder();
                        Initial_Insert_Deduction();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Update)
                {
                    idaCOMMON_HEADER.Update();
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Cancel)
                {
                    if (idaCOMMON_HEADER.IsFocused)
                    {
                        HEADER_DATA_STATE.EditValue = "N";
                        idaCOMMON_HEADER.Cancel();
                    }
                    else if (idaPAY_ALLOWANCE.IsFocused)
                    {                        
                        idaPAY_ALLOWANCE.Cancel();
                        int vCOUNT = 0;
                        for (int i = 0; i < idaPAY_DEDUCTION.CurrentRows.Count; i++)
                        {
                            if (idaPAY_DEDUCTION.CurrentRows[i].RowState != DataRowState.Unchanged)
                            {
                                vCOUNT = vCOUNT + 1;
                            }
                        }
                        if (vCOUNT == 0 && iString.ISNull(HEADER_DATA_STATE.EditValue, "N") == "N")
                        {
                            idaCOMMON_HEADER.Cancel();
                        }
                    }
                    else if (idaPAY_DEDUCTION.IsFocused)
                    {
                        idaPAY_DEDUCTION.Cancel();
                        int vCOUNT = 0;
                        for (int i = 0; i < idaPAY_ALLOWANCE.CurrentRows.Count; i++)
                        {
                            if (idaPAY_ALLOWANCE.CurrentRows[i].RowState != DataRowState.Unchanged)
                            {
                                vCOUNT = vCOUNT + 1;
                            }
                        }
                        if (vCOUNT == 0 && iString.ISNull(HEADER_DATA_STATE.EditValue, "N") == "N")
                        {
                            idaCOMMON_HEADER.Cancel();
                        }
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {
                    if (idaCOMMON_HEADER.IsFocused)
                    {
                        if (idaPAY_ALLOWANCE.CurrentRow.RowState == DataRowState.Added)
                        {
                            HEADER_DATA_STATE.EditValue = "N";
                        }
                        else
                        {
                            HEADER_DATA_STATE.EditValue = "U";
                        }
                        idaCOMMON_HEADER.Delete();
                    }
                    else if (idaPAY_ALLOWANCE.IsFocused)
                    {
                        if (idaPAY_ALLOWANCE.CurrentRow.RowState == DataRowState.Added)
                        {
                            int vCOUNT = 0;
                            for (int i = 0; i < idaPAY_ALLOWANCE.CurrentRows.Count; i++)
                            {
                                if (idaPAY_ALLOWANCE.CurrentRows[i].RowState != DataRowState.Unchanged)
                                {
                                    vCOUNT = vCOUNT + 1;
                                }
                            }
                            for (int i = 0; i < idaPAY_DEDUCTION.CurrentRows.Count; i++)
                            {
                                if (idaPAY_DEDUCTION.CurrentRows[i].RowState != DataRowState.Unchanged)
                                {
                                    vCOUNT = vCOUNT + 1;
                                }
                            }
                            if (vCOUNT == 0 && iString.ISNull(HEADER_DATA_STATE.EditValue, "N") == "N")
                            {
                                idaCOMMON_HEADER.Cancel();
                            }
                        }
                        else
                        {
                            LINE_DATA_STATE.EditValue = "U";
                        }
                        idaPAY_ALLOWANCE.Delete();                        
                    }
                    else if (idaPAY_DEDUCTION.IsFocused)
                    {
                        if (idaPAY_DEDUCTION.CurrentRow.RowState == DataRowState.Added)
                        {
                            int vCOUNT = 0;
                            for (int i = 0; i < idaPAY_ALLOWANCE.CurrentRows.Count; i++)
                            {
                                if (idaPAY_ALLOWANCE.CurrentRows[i].RowState != DataRowState.Unchanged)
                                {
                                    vCOUNT = vCOUNT + 1;
                                }
                            }
                            for (int i = 0; i < idaPAY_DEDUCTION.CurrentRows.Count; i++)
                            {
                                if (idaPAY_DEDUCTION.CurrentRows[i].RowState != DataRowState.Unchanged)
                                {
                                    vCOUNT = vCOUNT + 1;
                                }
                            }
                            if (vCOUNT == 0 && iString.ISNull(HEADER_DATA_STATE.EditValue, "N") == "N")
                            {
                                idaCOMMON_HEADER.Cancel();
                            }
                        }
                        else
                        {
                            LINE_DATA_STATE.EditValue = "U";
                        }
                        idaPAY_DEDUCTION.Delete();
                    }
                }
            }
        }

        #endregion;

        #region ----- Form Event -----

        private void HRMF9501_Load(object sender, EventArgs e)
        {
            idaCOMMON_HEADER.FillSchema();
            idaPAY_ALLOWANCE.FillSchema();
            idaPAY_DEDUCTION.FillSchema();
        }

        private void HRMF9501_Shown(object sender, EventArgs e)
        {
            STD_YYYYMM_0.EditValue = iDate.ISYearMonth(DateTime.Today);
        }

        private void igrPAY_ALLOWANCE_CurrentCellChanged(object pSender, ISGridAdvExChangedEventArgs e)
        {
            LINE_DATA_STATE.EditValue = "U";
        }

        private void igrPAY_DEDUCTION_CurrentCellChanged(object pSender, ISGridAdvExChangedEventArgs e)
        {
            LINE_DATA_STATE.EditValue = "U";
        }

        #endregion  

        #region ----- Adapter Event -----

        private void idaPERSON_UpdateCompleted(object pSender)
        {
            Search_DB();
        }

        // Pay Master 항목.
        private void idaGRADE_HEADER_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {
            if (iString.ISNull(STD_YYYYMM_0.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Standard Period"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["CORP_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Corporation"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["PRINT_TYPE"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10327"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["PAY_TYPE"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Pay Type"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
        }

        private void idaGRADE_HEADER_PreDelete(ISPreDeleteEventArgs e)
        {
            if (e.Row.RowState != DataRowState.Added)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10029", "&&VALUE:=Data"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);        // 모듈 코드 입력
                e.Cancel = true;
                return;
            }
        }

        // Allowance 항목.
        private void idaPAY_ALLOWANCE_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {
            if (e.Row["ALLOWANCE_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Payment Allowance"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["ALLOWANCE_AMOUNT"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Allowance Amount"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
        }

        // Deduction 항목.
        private void idaPAY_DEDUCTION_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {
            if (e.Row["ALLOWANCE_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Deduction Allowance"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["ALLOWANCE_AMOUNT"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Allowance Amount"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
        }

        #endregion

        #region ----- LookUp Event -----

        private void ilaCORP_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCORP.SetLookupParamValue("W_ENABLED_FLAG_YN", "Y");
        }

        private void ILA_CORP_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCORP.SetLookupParamValue("W_ENABLED_FLAG_YN", "Y");
        }
        private void ilaYYYYMM_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildYYYYMM.SetLookupParamValue("W_START_YYYYMM", "2001-01");
            ildYYYYMM.SetLookupParamValue("W_END_YYYYMM", iDate.ISYearMonth(DateTime.Today));
        }

        private void ilaPAY_TYPE_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", "PAY_TYPE");
            ildCOMMON.SetLookupParamValue("W_ENABLED_FLAG", "N");
        }

        private void ilaPAY_TYPE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", "PAY_TYPE");
            ildCOMMON.SetLookupParamValue("W_ENABLED_FLAG", "Y");
        }

        private void ilaALLOWANCE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCOMMON_W.SetLookupParamValue("W_GROUP_CODE", "ALLOWANCE");
            ildCOMMON_W.SetLookupParamValue("W_WHERE", "HC.VALUE8 = 'Y'");
            ildCOMMON_W.SetLookupParamValue("W_ENABLED_FLAG", "Y");
        }

        private void ilaDEDUCTION_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCOMMON_W.SetLookupParamValue("W_GROUP_CODE", "DEDUCTION");
            ildCOMMON_W.SetLookupParamValue("W_WHERE", "HC.VALUE8 = 'Y'");
            ildCOMMON_W.SetLookupParamValue("W_ENABLED_FLAG", "Y");
        }

        private void ilaPRINT_TYPE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", "PRINT_TYPE");
            ildCOMMON.SetLookupParamValue("W_ENABLED_FLAG", "Y");
        }

        #endregion

    }
}