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

namespace FCMF0612
{
    public partial class FCMF0612 : Office2007Form
    {
        #region ----- Variables -----

        ISFunction.ISConvert iString = new ISFunction.ISConvert();
        ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        #endregion;

        #region ----- Constructor -----

        public FCMF0612()
        {
            InitializeComponent();
        }

        public FCMF0612(Form pMainForm, ISAppInterface pAppInterface)
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

            //APPROVE_STATUS_0.EditValue = idcDEFAULT_VALUE.GetCommandParamValue("O_CODE");
            //APPROVE_STATUS_NAME_0.EditValue = idcDEFAULT_VALUE.GetCommandParamValue("O_CODE_NAME");
        }

        private void SearchDB()
        {
            if (iString.ISNull(BUDGET_YEAR_0.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10022"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                BUDGET_YEAR_0.Focus();
                return;
            }
            idaPLAN_YEAR_APPROVE.Fill();
            idaPLAN_MONTH_APPROVE.Fill();

            Set_Plan_Month_Header();    //헤더 설정.
            Set_Total_Amount();
            Set_Tab_Focus();    

            //string mACCOUNT_CODE = "-".ToString();
            //string mROW_ACCOUNT_CODE;
            //if (igrBUDGET_ACCOUNT.RowCount > 0)
            //{
            //    mACCOUNT_CODE = iString.ISNull(igrBUDGET_ACCOUNT.GetCellValue("ACCOUNT_CODE"));
            //}
            //Set_Plan_Month_Header();    //헤더 설정.
            //idaBUDGET_ACCOUNT.Fill();
            //Set_Total_Amount();

            //int mIDX_COL = igrBUDGET_ACCOUNT.GetColumnToIndex("ACCOUNT_CODE");
            //for (int r = 0; r < igrBUDGET_ACCOUNT.RowCount; r++)
            //{
            //    mROW_ACCOUNT_CODE = iString.ISNull(igrBUDGET_ACCOUNT.GetCellValue(r, mIDX_COL));
            //    if (mACCOUNT_CODE == mROW_ACCOUNT_CODE)
            //    {
            //        igrBUDGET_ACCOUNT.CurrentCellMoveTo(r, mIDX_COL);
            //        igrBUDGET_ACCOUNT.CurrentCellActivate(r, mIDX_COL);
            //        return;
            //    }
            //}
            //igrBUDGET_ACCOUNT.Focus();
        }

        private void SetCommonParameter(object pGroupCode, object pCodeName, object pEnabled_YN)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", pGroupCode);
            ildCOMMON.SetLookupParamValue("W_CODE_NAME", pCodeName);
            ildCOMMON.SetLookupParamValue("W_ENABLED_YN", pEnabled_YN);
        }

        private void Set_Plan_Month_Header()
        {
            int mStart_Col = 7;
            idaMONTH_HEADER.Fill();
            if (idaMONTH_HEADER.SelectRows.Count == 0)
            {
                igrPLAN_MONTH.GridAdvExColElement[mStart_Col + 0].HeaderElement[0].Default = string.Format("{0}-{1}", BUDGET_YEAR_0.EditValue, "01");
                igrPLAN_MONTH.GridAdvExColElement[mStart_Col + 1].HeaderElement[0].Default = string.Format("{0}-{1}", BUDGET_YEAR_0.EditValue, "02");
                igrPLAN_MONTH.GridAdvExColElement[mStart_Col + 2].HeaderElement[0].Default = string.Format("{0}-{1}", BUDGET_YEAR_0.EditValue, "03");
                igrPLAN_MONTH.GridAdvExColElement[mStart_Col + 3].HeaderElement[0].Default = string.Format("{0}-{1}", BUDGET_YEAR_0.EditValue, "04");
                igrPLAN_MONTH.GridAdvExColElement[mStart_Col + 4].HeaderElement[0].Default = string.Format("{0}-{1}", BUDGET_YEAR_0.EditValue, "05");
                igrPLAN_MONTH.GridAdvExColElement[mStart_Col + 5].HeaderElement[0].Default = string.Format("{0}-{1}", BUDGET_YEAR_0.EditValue, "06");
                igrPLAN_MONTH.GridAdvExColElement[mStart_Col + 6].HeaderElement[0].Default = string.Format("{0}-{1}", BUDGET_YEAR_0.EditValue, "07");
                igrPLAN_MONTH.GridAdvExColElement[mStart_Col + 7].HeaderElement[0].Default = string.Format("{0}-{1}", BUDGET_YEAR_0.EditValue, "08");
                igrPLAN_MONTH.GridAdvExColElement[mStart_Col + 8].HeaderElement[0].Default = string.Format("{0}-{1}", BUDGET_YEAR_0.EditValue, "09");
                igrPLAN_MONTH.GridAdvExColElement[mStart_Col + 9].HeaderElement[0].Default = string.Format("{0}-{1}", BUDGET_YEAR_0.EditValue, "10");
                igrPLAN_MONTH.GridAdvExColElement[mStart_Col + 10].HeaderElement[0].Default = string.Format("{0}-{1}", BUDGET_YEAR_0.EditValue, "11");
                igrPLAN_MONTH.GridAdvExColElement[mStart_Col + 11].HeaderElement[0].Default = string.Format("{0}-{1}", BUDGET_YEAR_0.EditValue, "12");
                igrPLAN_MONTH.GridAdvExColElement[mStart_Col + 12].HeaderElement[0].Default = string.Format("{0}-{1}", BUDGET_YEAR_0.EditValue, isMessageAdapter1.ReturnText("EAPP_10045"));
            }
            else
            {
                igrPLAN_MONTH.GridAdvExColElement[mStart_Col + 0].HeaderElement[0].Default = iString.ISNull(idaMONTH_HEADER.CurrentRow["MONTH_1"]);
                igrPLAN_MONTH.GridAdvExColElement[mStart_Col + 1].HeaderElement[0].Default = iString.ISNull(idaMONTH_HEADER.CurrentRow["MONTH_2"]);
                igrPLAN_MONTH.GridAdvExColElement[mStart_Col + 2].HeaderElement[0].Default = iString.ISNull(idaMONTH_HEADER.CurrentRow["MONTH_3"]);
                igrPLAN_MONTH.GridAdvExColElement[mStart_Col + 3].HeaderElement[0].Default = iString.ISNull(idaMONTH_HEADER.CurrentRow["MONTH_4"]);
                igrPLAN_MONTH.GridAdvExColElement[mStart_Col + 4].HeaderElement[0].Default = iString.ISNull(idaMONTH_HEADER.CurrentRow["MONTH_5"]);
                igrPLAN_MONTH.GridAdvExColElement[mStart_Col + 5].HeaderElement[0].Default = iString.ISNull(idaMONTH_HEADER.CurrentRow["MONTH_6"]);
                igrPLAN_MONTH.GridAdvExColElement[mStart_Col + 6].HeaderElement[0].Default = iString.ISNull(idaMONTH_HEADER.CurrentRow["MONTH_7"]);
                igrPLAN_MONTH.GridAdvExColElement[mStart_Col + 7].HeaderElement[0].Default = iString.ISNull(idaMONTH_HEADER.CurrentRow["MONTH_8"]);
                igrPLAN_MONTH.GridAdvExColElement[mStart_Col + 8].HeaderElement[0].Default = iString.ISNull(idaMONTH_HEADER.CurrentRow["MONTH_9"]);
                igrPLAN_MONTH.GridAdvExColElement[mStart_Col + 9].HeaderElement[0].Default = iString.ISNull(idaMONTH_HEADER.CurrentRow["MONTH_10"]);
                igrPLAN_MONTH.GridAdvExColElement[mStart_Col + 10].HeaderElement[0].Default = iString.ISNull(idaMONTH_HEADER.CurrentRow["MONTH_11"]);
                igrPLAN_MONTH.GridAdvExColElement[mStart_Col + 11].HeaderElement[0].Default = iString.ISNull(idaMONTH_HEADER.CurrentRow["MONTH_12"]);
                igrPLAN_MONTH.GridAdvExColElement[mStart_Col + 12].HeaderElement[0].Default = iString.ISNull(idaMONTH_HEADER.CurrentRow["YEAR_TOTAL"]);
            }
            igrPLAN_MONTH.ResetDraw = true;
        }

        private void Set_Total_Amount()
        {
            decimal vTotal_Amount = 0;
            object vAmount;
            int vIDXCol;
            // 년예산.
            vIDXCol = igrPLAN_YEAR.GetColumnToIndex("YEAR_AMOUNT");
            if (vIDXCol == -1)
            {
                return;
            }  
            for (int r = 0; r < idaPLAN_YEAR_APPROVE.SelectRows.Count; r++)
            {
                vAmount = 0;
                vAmount = igrPLAN_YEAR.GetCellValue(r, vIDXCol);
                vTotal_Amount = vTotal_Amount + iString.ISDecimaltoZero(vAmount);
            }
            YEAR_TOTAL_AMOUNT.EditValue = vTotal_Amount;

            // 월예산.
            vTotal_Amount = 0;
            vAmount = 0;
            vIDXCol = -1;
            vIDXCol = igrPLAN_MONTH.GetColumnToIndex("YEAR_TOTAL");
            if (vIDXCol == -1)
            {
                return;
            }
            for (int r = 0; r < idaPLAN_MONTH_APPROVE.SelectRows.Count; r++)
            {
                vAmount = 0;
                vAmount = igrPLAN_MONTH.GetCellValue(r, vIDXCol);
                vTotal_Amount = vTotal_Amount + iString.ISDecimaltoZero(vAmount);
            }
            MONTH_TOTAL_AMOUNT.EditValue = vTotal_Amount;
        }

        private void Set_Grid_Year_Item_Status(DataRow pDataRow)
        {
            bool mEnabled_YN = true;
            int mIDX_Col;

            //선택승인.
            icbCHECK_YN.Enabled = false;
            mIDX_Col = igrPLAN_YEAR.GetColumnToIndex("CHECK_YN");
            igrPLAN_YEAR.GridAdvExColElement[mIDX_Col].Insertable = 0;
            igrPLAN_YEAR.GridAdvExColElement[mIDX_Col].Updatable = 0;
            igrPLAN_YEAR.GridAdvExColElement[mIDX_Col].ReadOnly = true;
            if (pDataRow != null)
            {
                if (iString.ISNull(icbALL_RECORD_FLAG.CheckBoxValue) == "Y".ToString())
                {
                    mEnabled_YN = false;
                }

                if (mEnabled_YN == true)
                {
                    //선택승인.
                    icbCHECK_YN.Enabled = true;
                    mIDX_Col = igrPLAN_YEAR.GetColumnToIndex("CHECK_YN");
                    igrPLAN_YEAR.GridAdvExColElement[mIDX_Col].Insertable = 1;
                    igrPLAN_YEAR.GridAdvExColElement[mIDX_Col].Updatable = 1;
                    igrPLAN_YEAR.GridAdvExColElement[mIDX_Col].ReadOnly = false;
                }
            }
            igrPLAN_YEAR.ResetDraw = true;
        }

        private void Set_Grid_Item_Status(DataRow pDataRow)
        {
            bool mEnabled_YN = true;
            int mStart_Col = 7;
            igrPLAN_MONTH.GridAdvExColElement[mStart_Col + 0].Insertable = 0;
            igrPLAN_MONTH.GridAdvExColElement[mStart_Col + 0].Updatable = 0;
            igrPLAN_MONTH.GridAdvExColElement[mStart_Col + 0].ReadOnly = true;
            igrPLAN_MONTH.GridAdvExColElement[mStart_Col + 1].Insertable = 0;
            igrPLAN_MONTH.GridAdvExColElement[mStart_Col + 1].Updatable = 0;
            igrPLAN_MONTH.GridAdvExColElement[mStart_Col + 1].ReadOnly = true;
            igrPLAN_MONTH.GridAdvExColElement[mStart_Col + 2].Insertable = 0;
            igrPLAN_MONTH.GridAdvExColElement[mStart_Col + 2].Updatable = 0;
            igrPLAN_MONTH.GridAdvExColElement[mStart_Col + 2].ReadOnly = true;
            igrPLAN_MONTH.GridAdvExColElement[mStart_Col + 3].Insertable = 0;
            igrPLAN_MONTH.GridAdvExColElement[mStart_Col + 3].Updatable = 0;
            igrPLAN_MONTH.GridAdvExColElement[mStart_Col + 3].ReadOnly = true;
            igrPLAN_MONTH.GridAdvExColElement[mStart_Col + 4].Insertable = 0;
            igrPLAN_MONTH.GridAdvExColElement[mStart_Col + 4].Updatable = 0;
            igrPLAN_MONTH.GridAdvExColElement[mStart_Col + 4].ReadOnly = true;
            igrPLAN_MONTH.GridAdvExColElement[mStart_Col + 5].Insertable = 0;
            igrPLAN_MONTH.GridAdvExColElement[mStart_Col + 5].Updatable = 0;
            igrPLAN_MONTH.GridAdvExColElement[mStart_Col + 5].ReadOnly = true;
            igrPLAN_MONTH.GridAdvExColElement[mStart_Col + 6].Insertable = 0;
            igrPLAN_MONTH.GridAdvExColElement[mStart_Col + 6].Updatable = 0;
            igrPLAN_MONTH.GridAdvExColElement[mStart_Col + 6].ReadOnly = true;
            igrPLAN_MONTH.GridAdvExColElement[mStart_Col + 7].Insertable = 0;
            igrPLAN_MONTH.GridAdvExColElement[mStart_Col + 7].Updatable = 0;
            igrPLAN_MONTH.GridAdvExColElement[mStart_Col + 7].ReadOnly = true;
            igrPLAN_MONTH.GridAdvExColElement[mStart_Col + 8].Insertable = 0;
            igrPLAN_MONTH.GridAdvExColElement[mStart_Col + 8].Updatable = 0;
            igrPLAN_MONTH.GridAdvExColElement[mStart_Col + 8].ReadOnly = true;
            igrPLAN_MONTH.GridAdvExColElement[mStart_Col + 9].Insertable = 0;
            igrPLAN_MONTH.GridAdvExColElement[mStart_Col + 9].Updatable = 0;
            igrPLAN_MONTH.GridAdvExColElement[mStart_Col + 9].ReadOnly = true;
            igrPLAN_MONTH.GridAdvExColElement[mStart_Col + 10].Insertable = 0;
            igrPLAN_MONTH.GridAdvExColElement[mStart_Col + 10].Updatable = 0;
            igrPLAN_MONTH.GridAdvExColElement[mStart_Col + 10].ReadOnly = true;
            igrPLAN_MONTH.GridAdvExColElement[mStart_Col + 11].Insertable = 0;
            igrPLAN_MONTH.GridAdvExColElement[mStart_Col + 11].Updatable = 0;
            igrPLAN_MONTH.GridAdvExColElement[mStart_Col + 11].ReadOnly = true;
            if (pDataRow != null)
            {
                if (iString.ISNull(icbALL_RECORD_FLAG.CheckBoxValue) == "Y".ToString() ||
                    (iString.ISNull(pDataRow["APPROVE_STATUS"]) != "A".ToString() &&
                    iString.ISNull(pDataRow["APPROVE_STATUS"]) != "N".ToString()))
                {
                    mEnabled_YN = false;
                }

                if (iString.ISNull(pDataRow["MONTH_1_YN"]) == "Y" && mEnabled_YN == true)
                {
                    igrPLAN_MONTH.GridAdvExColElement[mStart_Col + 0].Insertable = 1;
                    igrPLAN_MONTH.GridAdvExColElement[mStart_Col + 0].Updatable = 1;
                    igrPLAN_MONTH.GridAdvExColElement[mStart_Col + 0].ReadOnly = false;
                }
                if (iString.ISNull(pDataRow["MONTH_2_YN"]) == "Y" && mEnabled_YN == true)
                {
                    igrPLAN_MONTH.GridAdvExColElement[mStart_Col + 1].Insertable = 1;
                    igrPLAN_MONTH.GridAdvExColElement[mStart_Col + 1].Updatable = 1;
                    igrPLAN_MONTH.GridAdvExColElement[mStart_Col + 1].ReadOnly = false;
                }
                if (iString.ISNull(pDataRow["MONTH_3_YN"]) == "Y" && mEnabled_YN == true)
                {
                    igrPLAN_MONTH.GridAdvExColElement[mStart_Col + 2].Insertable = 1;
                    igrPLAN_MONTH.GridAdvExColElement[mStart_Col + 2].Updatable = 1;
                    igrPLAN_MONTH.GridAdvExColElement[mStart_Col + 2].ReadOnly = false;
                }
                if (iString.ISNull(pDataRow["MONTH_4_YN"]) == "Y" && mEnabled_YN == true)
                {
                    igrPLAN_MONTH.GridAdvExColElement[mStart_Col + 3].Insertable = 1;
                    igrPLAN_MONTH.GridAdvExColElement[mStart_Col + 3].Updatable = 1;
                    igrPLAN_MONTH.GridAdvExColElement[mStart_Col + 3].ReadOnly = false;
                }
                if (iString.ISNull(pDataRow["MONTH_5_YN"]) == "Y" && mEnabled_YN == true)
                {
                    igrPLAN_MONTH.GridAdvExColElement[mStart_Col + 4].Insertable = 1;
                    igrPLAN_MONTH.GridAdvExColElement[mStart_Col + 4].Updatable = 1;
                    igrPLAN_MONTH.GridAdvExColElement[mStart_Col + 4].ReadOnly = false;
                }
                if (iString.ISNull(pDataRow["MONTH_6_YN"]) == "Y" && mEnabled_YN == true)
                {
                    igrPLAN_MONTH.GridAdvExColElement[mStart_Col + 5].Insertable = 1;
                    igrPLAN_MONTH.GridAdvExColElement[mStart_Col + 5].Updatable = 1;
                    igrPLAN_MONTH.GridAdvExColElement[mStart_Col + 5].ReadOnly = false;
                }
                if (iString.ISNull(pDataRow["MONTH_7_YN"]) == "Y" && mEnabled_YN == true)
                {
                    igrPLAN_MONTH.GridAdvExColElement[mStart_Col + 6].Insertable = 1;
                    igrPLAN_MONTH.GridAdvExColElement[mStart_Col + 6].Updatable = 1;
                    igrPLAN_MONTH.GridAdvExColElement[mStart_Col + 6].ReadOnly = false;
                }
                if (iString.ISNull(pDataRow["MONTH_8_YN"]) == "Y" && mEnabled_YN == true)
                {
                    igrPLAN_MONTH.GridAdvExColElement[mStart_Col + 7].Insertable = 1;
                    igrPLAN_MONTH.GridAdvExColElement[mStart_Col + 7].Updatable = 1;
                    igrPLAN_MONTH.GridAdvExColElement[mStart_Col + 7].ReadOnly = false;
                }
                if (iString.ISNull(pDataRow["MONTH_9_YN"]) == "Y" && mEnabled_YN == true)
                {
                    igrPLAN_MONTH.GridAdvExColElement[mStart_Col + 8].Insertable = 1;
                    igrPLAN_MONTH.GridAdvExColElement[mStart_Col + 8].Updatable = 1;
                    igrPLAN_MONTH.GridAdvExColElement[mStart_Col + 8].ReadOnly = false;
                }
                if (iString.ISNull(pDataRow["MONTH_10_YN"]) == "Y" && mEnabled_YN == true)
                {
                    igrPLAN_MONTH.GridAdvExColElement[mStart_Col + 9].Insertable = 1;
                    igrPLAN_MONTH.GridAdvExColElement[mStart_Col + 9].Updatable = 1;
                    igrPLAN_MONTH.GridAdvExColElement[mStart_Col + 9].ReadOnly = false;
                }
                if (iString.ISNull(pDataRow["MONTH_11_YN"]) == "Y" && mEnabled_YN == true)
                {
                    igrPLAN_MONTH.GridAdvExColElement[mStart_Col + 10].Insertable = 1;
                    igrPLAN_MONTH.GridAdvExColElement[mStart_Col + 10].Updatable = 1;
                    igrPLAN_MONTH.GridAdvExColElement[mStart_Col + 10].ReadOnly = false;
                }
                if (iString.ISNull(pDataRow["MONTH_12_YN"]) == "Y" && mEnabled_YN == true)
                {
                    igrPLAN_MONTH.GridAdvExColElement[mStart_Col + 11].Insertable = 1;
                    igrPLAN_MONTH.GridAdvExColElement[mStart_Col + 11].Updatable = 1;
                    igrPLAN_MONTH.GridAdvExColElement[mStart_Col + 11].ReadOnly = false;
                }
            }
            igrPLAN_MONTH.ResetDraw = true;
        }

        private void Set_Tab_Focus()
        {
            if (itbBUDGET_PLAN.SelectedTab.TabIndex == 1)
            {
                igrPLAN_YEAR.Focus();
            }
            else if (itbBUDGET_PLAN.SelectedTab.TabIndex == 2)
            {
                igrPLAN_MONTH.Focus();
            }
        }

        private void Insert_BUDGET_YEAR_PLAN()
        {
            int mIDX_Col;
            igrPLAN_YEAR.SetCellValue("BUDGET_YEAR", BUDGET_YEAR_0.EditValue);


            mIDX_Col = igrPLAN_YEAR.GetColumnToIndex("BUDGET_YEAR");
            igrPLAN_YEAR.CurrentCellMoveTo(mIDX_Col);
            igrPLAN_YEAR.CurrentCellActivate(mIDX_Col);
            igrPLAN_YEAR.Focus();
        }

        private void Set_CheckBox()
        {
            int mIDX_Col = igrPLAN_YEAR.GetColumnToIndex("CHECK_YN");
            object mCheck_YN = icbCHECK_YN.CheckBoxValue;
            for (int r = 0; r < igrPLAN_YEAR.RowCount; r++)
            {
                igrPLAN_YEAR.SetCellValue(r, mIDX_Col, mCheck_YN);
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
                    
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddUnder)
                {
                    
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Update)
                {
                    if (idaPLAN_MONTH_APPROVE.IsFocused)
                    {
                        idaPLAN_MONTH_APPROVE.Update();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Cancel)
                {
                    if (idaPLAN_YEAR_APPROVE.IsFocused)
                    {
                        idaPLAN_YEAR_APPROVE.Cancel();
                    }
                    else if ( idaPLAN_MONTH_APPROVE.IsFocused)
                    {
                        idaPLAN_MONTH_APPROVE.Cancel();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {
                    if (idaPLAN_YEAR_APPROVE.IsFocused)
                    {
                        idaPLAN_YEAR_APPROVE.Delete();
                    }
                    else if (idaPLAN_MONTH_APPROVE.IsFocused)
                    {
                        idaPLAN_MONTH_APPROVE.Delete();
                    }
                }
            }
        }

        #endregion;

        #region ----- Form Event -----

        private void FCMF0612_Load(object sender, EventArgs e)
        {
            idaBUDGET_ACCOUNT.FillSchema();
            idaPLAN_YEAR_APPROVE.FillSchema();
            idaPLAN_MONTH_APPROVE.FillSchema();
        }

        private void FCMF0612_Shown(object sender, EventArgs e)
        {
            BUDGET_YEAR_0.EditValue = DateTime.Today.Year;
            Set_Plan_Month_Header();
            irbAPPR_A.CheckedState = ISUtil.Enum.CheckedState.Checked;
            EMAIL_STATUS.EditValue = "N";
            icbALL_RECORD_FLAG.CheckedState = ISUtil.Enum.CheckedState.Unchecked;
        }

        private void irbAPPROVE_STATUS_CheckChanged(object sender, EventArgs e)
        {
            ISRadioButtonAdv iStatus = sender as ISRadioButtonAdv;
            APPROVE_STATUS_9.EditValue = iStatus.RadioButtonString;
            SearchDB();
        }
        
        private void ibtOK_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            // EMAIL STATUS.
            if (iString.ISNull(APPROVE_STATUS_9.EditValue) == "A".ToString())
            {
                EMAIL_STATUS.EditValue = "A_OK";
            }
            else if (iString.ISNull(APPROVE_STATUS_9.EditValue) == "B".ToString())
            {
                EMAIL_STATUS.EditValue = "B_OK";
            }
            else
            {
                EMAIL_STATUS.EditValue = "N";
            }

            idaPLAN_YEAR_APPROVE.SetUpdateParamValue("P_APPROVE_FLAG", "OK");
            idaPLAN_YEAR_APPROVE.Update();

            idaPLAN_YEAR_APPROVE.Fill();
            idaPLAN_MONTH_APPROVE.Fill();
        }

        private void ibtCANCEL_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            // EMAIL STATUS.
            if (iString.ISNull(APPROVE_STATUS_9.EditValue) == "A".ToString())
            {
                EMAIL_STATUS.EditValue = "A_CANCEL";
            }
            else if (iString.ISNull(APPROVE_STATUS_9.EditValue) == "B".ToString())
            {
                EMAIL_STATUS.EditValue = "B_CANCEL";
            }
            else if (iString.ISNull(APPROVE_STATUS_9.EditValue) == "C".ToString())
            {
                EMAIL_STATUS.EditValue = "C_CANCEL";
            }
            else
            {
                EMAIL_STATUS.EditValue = "N";
            }

            idaPLAN_YEAR_APPROVE.SetUpdateParamValue("P_APPROVE_FLAG", "CANCEL");
            idaPLAN_YEAR_APPROVE.Update();

            idaPLAN_YEAR_APPROVE.Fill();
            idaPLAN_MONTH_APPROVE.Fill();
        }
        
        private void ibtnCONFIRM_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            string mMESSAGE;
            if (iString.ISNull(BUDGET_YEAR_0.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10022"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                BUDGET_YEAR_0.Focus();
                return;
            }

            idcBUDGET_PLAN_YEAR_CONFIRM.ExecuteNonQuery();
            mMESSAGE = iString.ISNull(idcBUDGET_PLAN_YEAR_CONFIRM.GetCommandParamValue("O_MESSAGE"));
            if (mMESSAGE != string.Empty)
            {
                MessageBoxAdv.Show(mMESSAGE, "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }   
        }

        private void ibtnEXECUTE_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            string mMESSAGE;
            if (iString.ISNull(BUDGET_YEAR_0.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10022"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                BUDGET_YEAR_0.Focus();
                return;
            }

            // 변경사항 저장.
            idaBUDGET_ACCOUNT.Update();

            idcBUDGET_PERIOD.ExecuteNonQuery();
            mMESSAGE = iString.ISNull(idcBUDGET_PERIOD.GetCommandParamValue("O_MESSAGE"));
            if (mMESSAGE != string.Empty)
            {
                MessageBoxAdv.Show(mMESSAGE, "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }    
        }

        private void ibtREQ_APPROVE_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            String mMESSAGE;
            try
            {
                idaBUDGET_ACCOUNT.Update();                
            }
            catch
            {
            }
            idcAPPROVE_REQUEST.ExecuteNonQuery();
            mMESSAGE = iString.ISNull(idcAPPROVE_REQUEST.GetCommandParamValue("O_MESSAGE"));
            if (mMESSAGE != string.Empty)
            {
                MessageBoxAdv.Show(mMESSAGE, "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
        }

        private void icbCHECK_YN_CheckedChange(object pSender, ISCheckEventArgs e)
        {
            Set_CheckBox();
        }

        private void itbBUDGET_PLAN_Click(object sender, EventArgs e)
        {
            Set_Tab_Focus();
        }

        #endregion

        #region ----- Lookup Event -----

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
            ildDEPT_FR_TO.SetLookupParamValue("W_CHECK_CAPACITY", "Y");
            ildDEPT_FR_TO.SetLookupParamValue("W_ENABLED_YN", "N");
        }

        private void ilaDEPT_TO_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildDEPT_FR_TO.SetLookupParamValue("W_DEPT_CODE_FR", DEPT_CODE_FR_0.EditValue);
            ildDEPT_FR_TO.SetLookupParamValue("W_CHECK_CAPACITY", "Y");
            ildDEPT_FR_TO.SetLookupParamValue("W_ENABLED_YN", "N");
        }

        private void ilaDEPT_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildDEPT_FR_TO.SetLookupParamValue("W_DEPT_CODE_FR", null);
            ildDEPT_FR_TO.SetLookupParamValue("W_CHECK_CAPACITY", "Y");
            ildDEPT_FR_TO.SetLookupParamValue("W_ENABLED_YN", "N");
        }

        private void ilaACCOUNT_CONTROL_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildACCOUNT_CONTROL.SetLookupParamValue("W_ENABLED_YN", "N");
        }

        #endregion

        #region ----- Adapter Event -----

        private void idaPLAN_YEAR_APPROVE_PreNewRowMoved(object pSender, ISBindingEventArgs pBindingManager)
        {
            Set_Grid_Year_Item_Status(pBindingManager.DataRow);
        }

        private void idaPLAN_MONTH_APPROVE_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {
            if (iString.ISNull(BUDGET_YEAR_0.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10022"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }
            if (iString.ISNull(e.Row["DEPT_ID"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Department(예산부서)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["ACCOUNT_CONTROL_ID"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Account Code(예산 계정)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
        }

        private void idaPLAN_MONTH_APPROVE_PreNewRowMoved(object pSender, ISBindingEventArgs pBindingManager)
        {
            Set_Grid_Item_Status(pBindingManager.DataRow);
        }

        private void idaBUDGET_ACCOUNT_NewRowMoved(object pSender, ISBindingEventArgs pBindingManager)
        {
            idaPLAN_YEAR_APPROVE.Fill();
            idaPLAN_MONTH_APPROVE.Fill();
        }

        private void idaPLAN_MONTH_APPROVE_UpdateCompleted(object pSender)
        {
            SearchDB();
        }
        
        #endregion

    }
}