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

namespace HRMF0502
{
    public partial class HRMF0502 : Office2007Form
    {
        #region ----- Variables -----

        private ISFunction.ISConvert iString = new ISFunction.ISConvert();
        private ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        #endregion;
        
        #region ----- Constructor -----

        public HRMF0502(Form pMainForm, ISAppInterface pAppInterface)
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
            START_YYYYMM.EditValue = STD_YYYYMM_0.EditValue;
            CORP_ID.EditValue = igrPERSON.GetCellValue("CORP_ID");
            PERSON_ID.EditValue = igrPERSON.GetCellValue("PERSON_ID");
            PAY_GRADE_NAME.EditValue = igrPERSON.GetCellValue("PAY_GRADE_NAME");
            PAY_GRADE_ID.EditValue = igrPERSON.GetCellValue("PAY_GRADE_ID");
            PAY_PROVIDE_YN.CheckBoxValue = "Y";
            BONUS_PROVIDE_YN.CheckBoxValue = "Y";
            YEAR_PROVIDE_YN.CheckBoxValue = "Y";
            HIRE_INSUR_YN.CheckBoxValue = "Y";

            HEADER_DATA_STATE.EditValue = "U";
            PRINT_TYPE_NAME.Focus();
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

            string vPERSON_NAME = iString.ISNull(igrPERSON.GetCellValue("NAME"));
            int vIDX_Col = igrPERSON.GetColumnToIndex("NAME");
            idaPERSON.Fill();
            if (igrPERSON.RowCount > 0)
            {
                for (int vRow = 0; vRow < igrPERSON.RowCount; vRow++)
                {
                    if (vPERSON_NAME == iString.ISNull(igrPERSON.GetCellValue(vRow, vIDX_Col)))
                    {
                        igrPERSON.CurrentCellActivate(vRow, vIDX_Col);
                        igrPERSON.CurrentCellMoveTo(vRow, vIDX_Col);
                    }
                }
            }
            igrPERSON.Focus();
        }

        private void isSET_ALLOWANCE()
        {
            idaGRADE_STEP_AMOUNT.Fill();

            if (idaGRADE_STEP_AMOUNT.OraSelectData.Rows.Count == 0)
            {
                return;
            }
            
            // 반환된 RECORD COUNT 만큼 루프를 돌며 GRID의 값과 비교 --> 있으면 수정, 없으면 ADD.
            for (int R = 0; R < idaGRADE_STEP_AMOUNT.OraSelectData.Rows.Count; R++)
            {
                int Row_Index = -1;
                int RECORD_VALUE = Convert.ToInt32(idaGRADE_STEP_AMOUNT.OraSelectData.Rows[R]["ALLOWANCE_ID"]);

                for (int GR = 0; GR < igrPAY_ALLOWANCE.RowCount; GR++)
                {
                    int GRID_VALUE = Convert.ToInt32(igrPAY_ALLOWANCE.GetCellValue(GR, igrPAY_ALLOWANCE.GetColumnToIndex("ALLOWANCE_ID")));
                    if (RECORD_VALUE == GRID_VALUE)
                    {
                        Row_Index = GR;
                    }
                }
                if (Row_Index == -1)
                {
                    idaPAY_ALLOWANCE.AddUnder();
                    igrPAY_ALLOWANCE.SetCellValue("PAY_HEADER_ID", PAY_HEADER_ID.EditValue);
                    igrPAY_ALLOWANCE.SetCellValue("ALLOWANCE_ID", idaGRADE_STEP_AMOUNT.OraSelectData.Rows[R]["ALLOWANCE_ID"]);
                    igrPAY_ALLOWANCE.SetCellValue("ALLOWANCE_NAME", idaGRADE_STEP_AMOUNT.OraSelectData.Rows[R]["ALLOWANCE_NAME"]);
                    igrPAY_ALLOWANCE.SetCellValue("ALLOWANCE_AMOUNT", idaGRADE_STEP_AMOUNT.OraSelectData.Rows[R]["ALLOWANCE_AMOUNT"]);
                    igrPAY_ALLOWANCE.SetCellValue("ENABLED_FLAG", "Y");
                }
                else
                {
                    igrPAY_ALLOWANCE.SetCellValue(Row_Index, igrPAY_ALLOWANCE.GetColumnToIndex("ALLOWANCE_AMOUNT"), idaGRADE_STEP_AMOUNT.OraSelectData.Rows[R]["ALLOWANCE_AMOUNT"]);
                }
            }
        }

        private void isSet_Adapter_Status()
        {
            for (int hr = 0; hr < idaPAY_MASTER_HEADER.SelectRows.Count; hr++)
            {
                if (idaPAY_MASTER_HEADER.SelectRows[hr].RowState != DataRowState.Unchanged)
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
            idaPERSON.MoveFirst("");
            igrPERSON.BeginUpdate();
            for (int m = 0; m < idaPERSON.OraSelectData.Rows.Count; m++)
            {
                for (int i = 0; i < idaPAY_MASTER_HEADER.CurrentRows.Count; i++)
                {
                    if (idaPAY_MASTER_HEADER.CurrentRows[i].RowState == DataRowState.Unchanged)
                    {
                        for (int j = 0; j < idaPAY_ALLOWANCE.CurrentRows.Count; j++)
                        {
                            if (idaPAY_ALLOWANCE.CurrentRows[j].RowState != DataRowState.Unchanged)
                            {
                                if (idaPAY_MASTER_HEADER.CurrentRows[i].RowState == DataRowState.Unchanged)
                                {
                                    START_YYYYMM.EditValue = STD_YYYYMM_0.EditValue;
                                }
                            }
                        }
                        idaPAY_MASTER_HEADER.MoveNext("");
                    }
                }
                idaPERSON.MoveNext("");
            }
            igrPERSON.EndUpdate();

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

        #region ----- Sum_Amount Method ----

        private void Sum_Amount()
        {
            object vObject = null;
            object vObject_ENABLED_FLAG = null;
            int vIndexColumnGrid = 0;
            int vIndexColumn_ENABLED_FLAG = 0;
            string vENABLED_FLAG = string.Empty;
            decimal vAmount = 0m;
            decimal vAmountSum = 0m;

            SUM_AMOUNT_ALLOWANCE.EditValue = vAmountSum;
            SUM_AMOUNT_DEDUCTION.EditValue = vAmountSum;

            int vCountRow = igrPAY_ALLOWANCE.RowCount;
            if (vCountRow > 0)
            {
                vIndexColumnGrid = igrPAY_ALLOWANCE.GetColumnToIndex("ALLOWANCE_AMOUNT");
                vIndexColumn_ENABLED_FLAG = igrPAY_ALLOWANCE.GetColumnToIndex("ENABLED_FLAG");
                for(int vRow= 0; vRow < vCountRow; vRow++)
                {
                    vObject = igrPAY_ALLOWANCE.GetCellValue(vRow, vIndexColumnGrid);
                    vObject_ENABLED_FLAG = igrPAY_ALLOWANCE.GetCellValue(vRow, vIndexColumn_ENABLED_FLAG);
                    vENABLED_FLAG = ConvertString(vObject_ENABLED_FLAG);
                    if (vENABLED_FLAG == "Y")
                    {
                        vAmount = ConvertNumber(vObject);
                        vAmountSum = vAmountSum + vAmount;
                    }
                }

                SUM_AMOUNT_ALLOWANCE.EditValue = vAmountSum;
            }

            vCountRow = igrPAY_DEDUCTION.RowCount;
            if (vCountRow > 0)
            {
                vAmountSum = 0m;
                vIndexColumnGrid = igrPAY_DEDUCTION.GetColumnToIndex("ALLOWANCE_AMOUNT");
                vIndexColumn_ENABLED_FLAG = igrPAY_DEDUCTION.GetColumnToIndex("ENABLED_FLAG");
                for (int vRow = 0; vRow < vCountRow; vRow++)
                {
                    vObject = igrPAY_DEDUCTION.GetCellValue(vRow, vIndexColumnGrid);
                    vObject_ENABLED_FLAG = igrPAY_DEDUCTION.GetCellValue(vRow, vIndexColumn_ENABLED_FLAG);
                    vENABLED_FLAG = ConvertString(vObject_ENABLED_FLAG);
                    if (vENABLED_FLAG == "Y")
                    {
                        vAmount = ConvertNumber(vObject);
                        vAmountSum = vAmountSum + vAmount;
                    }
                }

                SUM_AMOUNT_DEDUCTION.EditValue = vAmountSum;
            }
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
                    if (idaPERSON.IsFocused || idaPAY_MASTER_HEADER.IsFocused)
                    {
                        idaPAY_MASTER_HEADER.AddOver();
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
                    if (idaPERSON.IsFocused || idaPAY_MASTER_HEADER.IsFocused)
                    {
                        idaPAY_MASTER_HEADER.AddUnder();
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
                    idaPERSON.Update();
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Cancel)
                {
                    if (idaPERSON.IsFocused || idaPAY_MASTER_HEADER.IsFocused)
                    {
                        HEADER_DATA_STATE.EditValue = "N";
                        idaPAY_MASTER_HEADER.Cancel();
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
                            idaPAY_MASTER_HEADER.Cancel();
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
                            idaPAY_MASTER_HEADER.Cancel();
                        }
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {
                    if (idaPERSON.IsFocused || idaPAY_MASTER_HEADER.IsFocused)
                    {
                        if (idaPAY_ALLOWANCE.CurrentRow.RowState == DataRowState.Added)
                        {
                            HEADER_DATA_STATE.EditValue = "N";
                        }
                        else
                        {
                            HEADER_DATA_STATE.EditValue = "U";
                        }
                        idaPAY_MASTER_HEADER.Delete();
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
                                idaPAY_MASTER_HEADER.Cancel();
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
                                idaPAY_MASTER_HEADER.Cancel();
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

        private void HRMF0502_Load(object sender, EventArgs e)
        {
            idaPERSON.FillSchema();
            idaPAY_MASTER_HEADER.FillSchema();
            idaPAY_ALLOWANCE.FillSchema();
            idaPAY_DEDUCTION.FillSchema();

            STD_YYYYMM_0.EditValue = iDate.ISYearMonth(DateTime.Today);
            
            DefaultCorporation();              //Default Corp.
            //DefaultSetFormReSize();		//[Child Form, Mdi Form에 맞게 ReSize]           
        }

        private void HRMF0502_Shown(object sender, EventArgs e)
        {
            SUM_AMOUNT_ALLOWANCE.BringToFront();
            SUM_AMOUNT_DEDUCTION.BringToFront();
        }

        private void igrPAY_ALLOWANCE_CurrentCellChanged(object pSender, ISGridAdvExChangedEventArgs e)
        {
            LINE_DATA_STATE.EditValue = "U";
        }
        
        private void igrPAY_DEDUCTION_CurrentCellChanged(object pSender, ISGridAdvExChangedEventArgs e)
        {
            LINE_DATA_STATE.EditValue = "U";
        }

        private void BTN_GEN_HOURLY_DETAIL_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            if (iString.ISNull(STD_YYYYMM_0.EditValue) == String.Empty)
            {// 시작일자
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10036"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }

            if (iString.ISNull(PERSON_ID.EditValue) == String.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10028"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }

            HRMF0502_DETAIL vHRMF0502_DETAIL = new HRMF0502_DETAIL(this.MdiParent, isAppInterfaceAdv1.AppInterface,
                                                                    STD_YYYYMM_0.EditValue, PERSON_NAME.EditValue, PERSON_ID.EditValue);
            vHRMF0502_DETAIL.ShowDialog();
            vHRMF0502_DETAIL.Dispose();
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
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Standard Year Month(기준년월)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
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
            if (e.Row["PRINT_TYPE"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10327"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
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

        // Deduction 항목.
        private void idaPAY_DEDUCTION_PreRowUpdate(ISPreRowUpdateEventArgs e)
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

        private void idaPAY_DEDUCTION_PreDelete(ISPreDeleteEventArgs e)
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
            ildYYYYMM.SetLookupParamValue("W_END_YYYYMM", iDate.ISYearMonth(iDate.ISDate_Month_Add(DateTime.Today, 2)));
        }

        private void ilaPAY_GRADE_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", "PAY_GRADE");
            ildCOMMON.SetLookupParamValue("W_ENABLED_FLAG", "N");
        }

        private void ilaPAY_TYPE_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", "PAY_TYPE");
            ildCOMMON.SetLookupParamValue("W_ENABLED_FLAG", "N");
        }

        private void ilaPERSON_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            string vSTD_YYYYMM = iString.ISNull(STD_YYYYMM_0.EditValue);
            ildPERSON_0.SetLookupParamValue("W_START_DATE", iDate.ISMonth_1st(vSTD_YYYYMM));
            ildPERSON_0.SetLookupParamValue("W_END_DATE", iDate.ISMonth_Last(vSTD_YYYYMM));
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

        private void ilaBANK_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", "BANK");
            ildCOMMON.SetLookupParamValue("W_ENABLED_FLAG", "Y");
        }

        private void ilaGRADE_STEP_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            if (PAY_GRADE_ID.EditValue == null)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Pay Grade(직급)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
            }
            if (iString.ISNull(PAY_TYPE.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Pay Type(급여제)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
            }
            
            ildGRADE_STEP.SetLookupParamValue("W_ENABLED_FLAG", "Y");
        }

        private void ilaGRADE_STEP_SelectedRowData(object pSender)
        {
            isSET_ALLOWANCE();
        }

        private void ilaPERSON_0_PrePopupShow_1(object pSender, ISLookupPopupShowEventArgs e)
        {
            string vYYYYMM = iString.ISNull(STD_YYYYMM_0.EditValue);
            string vYYYY = vYYYYMM.Substring(0, 4);
            string vMM = vYYYYMM.Substring(5, 2);
            int vYYYY_Integer = int.Parse(vYYYY);
            int vMM_Integer = int.Parse(vMM);
            System.DateTime vDateTime = iDate.ISMonth_Last(new System.DateTime(vYYYY_Integer, vMM_Integer, 1));
            ildPERSON_0.SetLookupParamValue("W_WORK_DATE_TO", vDateTime);
        }
        #endregion

        #region ----- Grid Event -----

        private void igrPERSON_CellMoved(object pSender, ISGridAdvExCellClickEventArgs e)
        {
            Sum_Amount();
        }

        #endregion  

    }
}