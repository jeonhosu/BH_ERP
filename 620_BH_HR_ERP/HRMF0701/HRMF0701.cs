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

namespace HRMF0701
{
    public partial class HRMF0701 : Office2007Form
    {
        #region ----- Variables -----

        ISFunction.ISConvert iString = new ISFunction.ISConvert();
        ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        #endregion;

        #region ----- Constructor -----

        public HRMF0701()
        {
            InitializeComponent();
        }

        public HRMF0701(Form pMainForm, ISAppInterface pAppInterface)
        {
            InitializeComponent();
            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;
        }

        #endregion;

        #region ----- User Make Methods ----

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

        private void DefaultDate()
        {
            if (DateTime.Today.Month <= 2)
            {
                DateTime dLastYearMonthDay = new DateTime(DateTime.Today.AddYears(-1).Year, 12, 31);
                STANDARD_DATE_0.EditValue = dLastYearMonthDay;
            }
            else
            {
                DateTime dLastYearMonthDay = new DateTime(DateTime.Today.Year, 12, 31);
                STANDARD_DATE_0.EditValue = dLastYearMonthDay;
            }
        }

        private DateTime GetDateTime()
        {
            DateTime vDateTime = DateTime.Today;

            try
            {
                idcGetDate.ExecuteNonQuery();
                object vObject = idcGetDate.GetCommandParamValue("X_LOCAL_DATE");

                bool isConvert = vObject is DateTime;
                if (isConvert == true)
                {
                    vDateTime = (DateTime)vObject;
                }
            }
            catch (Exception ex)
            {
                string vMessage = ex.Message;
                vDateTime = new DateTime(9999, 12, 31, 23, 59, 59);
            }
            return vDateTime;
        }

        private void SEARCH_DB()
        {
            string vMessage = string.Empty;
            if (CORP_ID_0.EditValue == null)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10001"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                CORP_NAME_0.Focus();
                return;
            }
            if (STANDARD_DATE_0.EditValue == null)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10036"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                STANDARD_DATE_0.Focus();
                return;
            }

            try
            {
                string vPERSON_NAME = iString.ISNull(IGR_PERSON.GetCellValue("PERSON_NUM"));
                int vIDX_Col = IGR_PERSON.GetColumnToIndex("PERSON_NUM");

                IDA_PERSON.Fill();
                if (IGR_PERSON.RowCount > 0)
                {
                    for (int vRow = 0; vRow < IGR_PERSON.RowCount; vRow++)
                    {
                        if (vPERSON_NAME == iString.ISNull(IGR_PERSON.GetCellValue(vRow, vIDX_Col)))
                        {
                            IGR_PERSON.CurrentCellActivate(vRow, 0);
                            IGR_PERSON.CurrentCellMoveTo(vRow, 0);
                        }
                    }
                }
                IGR_PERSON.Focus();
            }
            catch (System.Exception ex)
            {
                vMessage = string.Format("Adapter Fill Error\n{0}", ex.Message);
                MessageBoxAdv.Show(vMessage, "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            }
        }

        private void SET_TB_ADJUSTMENT_FOCUS()
        {
            if (TB_ADJUSTMENT.SelectedTab.TabIndex == 1)
            {
                REPRE_NUM.Focus();
            }
            else if (TB_ADJUSTMENT.SelectedTab.TabIndex == 2)
            {
                IGR_FAMILY.Focus();
            }
            else if (TB_ADJUSTMENT.SelectedTab.TabIndex == 3)
            {
                INCOME_OUTSIDE_AMT.Focus();
            }
            else if (TB_ADJUSTMENT.SelectedTab.TabIndex == 4)
            {
                IGR_SAVING_INFO.Focus();
            }
            else if (TB_ADJUSTMENT.SelectedTab.TabIndex == 5)
            {
                IGR_DONATION_INFO.Focus();
            }
            else if (TB_ADJUSTMENT.SelectedTab.TabIndex == 6)
            {
                IGR_DONATION_ADJUSTMENT.Focus();
            }
        }

        private void SetCommon(object pGROUP_CODE, object pENABLED_FLAG_YN)
        {
            ILD_COMMON.SetLookupParamValue("W_GROUP_CODE", pGROUP_CODE);
            ILD_COMMON.SetLookupParamValue("W_ENABLED_FLAG_YN", pENABLED_FLAG_YN);
        }

        private void CREATE_SUPPORT_FAMILY()
        {
            string vMessage = string.Empty;
            if (CORP_ID_0.EditValue == null)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10001"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                CORP_NAME_0.Focus();
                return;
            }
            if (STANDARD_DATE_0.EditValue == null)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10036"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                STANDARD_DATE_0.Focus();
                return;
            }
            if (isBatchCreate.CheckedState == ISUtil.Enum.CheckedState.Unchecked && iString.ISNull(PERSON_ID.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(string.Format("[개별생성] {0}", isMessageAdapter1.ReturnText("FCM_10028")), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }

            DialogResult vdlgResult;
            vdlgResult = MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_10067"), "Question", MessageBoxButtons.YesNo, MessageBoxIcon.Question);
            if (vdlgResult == DialogResult.No)
            {
                return;
            }

            Application.UseWaitCursor = true;
            this.Cursor = Cursors.WaitCursor;
            Application.DoEvents();

            string mSTATUS = "F";
            string mMESSAGE = null;
            isDataTransaction1.BeginTran();

            if (iString.ISNull(ADJUST_YYYY.EditValue) == String.Empty)
            {
                string mYYYY = iDate.ISYear(iDate.ISGetDate(STANDARD_DATE_0.EditValue));
                IDC_FAMAILY_CREATE.SetCommandParamValue("P_YEAR_YYYY", mYYYY);
            }
            else
            {
                IDC_FAMAILY_CREATE.SetCommandParamValue("P_YEAR_YYYY", ADJUST_YYYY.EditValue);
            }
            if (isBatchCreate.CheckedState == ISUtil.Enum.CheckedState.Unchecked)
            {
                IDC_FAMAILY_CREATE.SetCommandParamValue("P_PERSON_ID", PERSON_ID.EditValue);
            }
            else
            {
                IDC_FAMAILY_CREATE.SetCommandParamValue("P_PERSON_ID", System.DBNull.Value);
            }
            
            IDC_FAMAILY_CREATE.ExecuteNonQuery();
            mSTATUS = iString.ISNull(IDC_FAMAILY_CREATE.GetCommandParamValue("O_STATUS"));
            mMESSAGE = iString.ISNull(IDC_FAMAILY_CREATE.GetCommandParamValue("O_MESSAGE"));
            if (IDC_FAMAILY_CREATE.ExcuteError || mSTATUS == "F")
            {
                isDataTransaction1.RollBack();
                MessageBoxAdv.Show(mMESSAGE, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }
            isDataTransaction1.Commit();
            isAppInterfaceAdv1.OnAppMessage(mMESSAGE);
            Application.UseWaitCursor = false;
            this.Cursor = Cursors.Default;
            Application.DoEvents();
        }

        private void CREATE_DONATION_ADJUSTMENT()
        {
            if (CORP_ID_0.EditValue == null)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10001"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                CORP_NAME_0.Focus();
                return;
            }
            if (STANDARD_DATE_0.EditValue == null)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10036"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                STANDARD_DATE_0.Focus();
                return;
            }
            if (isBatchCreate.CheckedState == ISUtil.Enum.CheckedState.Unchecked && iString.ISNull(PERSON_ID.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(string.Format("[개별생성] {0}", isMessageAdapter1.ReturnText("FCM_10028")), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }

            DialogResult vdlgResult;
            vdlgResult = MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_10067"), "Question", MessageBoxButtons.YesNo, MessageBoxIcon.Question);
            if (vdlgResult == DialogResult.No)
            {
                return;
            }

            Application.UseWaitCursor = true;
            this.Cursor = Cursors.WaitCursor;
            Application.DoEvents();

            string mSTATUS = "F";
            string mMESSAGE = null;
            isDataTransaction1.BeginTran();

            if (iString.ISNull(ADJUST_YYYY.EditValue) == String.Empty)
            {
                string mYYYY = iDate.ISYear(iDate.ISGetDate(STANDARD_DATE_0.EditValue));
                IDC_DONATION_ADJUSTMENT.SetCommandParamValue("P_YEAR_YYYY", mYYYY);                
            }
            else
            {
                IDC_DONATION_ADJUSTMENT.SetCommandParamValue("P_YEAR_YYYY", ADJUST_YYYY.EditValue);
            }

            if (isBatchCreate.CheckedState == ISUtil.Enum.CheckedState.Unchecked)
            {
                IDC_DONATION_ADJUSTMENT.SetCommandParamValue("P_PERSON_ID", PERSON_ID.EditValue);
            }
            else
            {
                IDC_DONATION_ADJUSTMENT.SetCommandParamValue("P_PERSON_ID", System.DBNull.Value);
            }

            IDC_DONATION_ADJUSTMENT.ExecuteNonQuery();
            mSTATUS = iString.ISNull(IDC_DONATION_ADJUSTMENT.GetCommandParamValue("O_STATUS"));
            mMESSAGE = iString.ISNull(IDC_DONATION_ADJUSTMENT.GetCommandParamValue("O_MESSAGE"));
            if (IDC_DONATION_ADJUSTMENT.ExcuteError || mSTATUS == "F")
            {
                isDataTransaction1.RollBack();
                MessageBoxAdv.Show(mMESSAGE, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }
            isDataTransaction1.Commit();
            isAppInterfaceAdv1.OnAppMessage(mMESSAGE);
            Application.UseWaitCursor = false;
            this.Cursor = Cursors.Default;
            Application.DoEvents();

            MessageBoxAdv.Show("기부금 조정명세서 생성을 완료하였습니다. \r\n연말정산 계산을 하셔야 [기부금 해당연도 공제금액]이 반영됩니다.", "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);
        }

        private void Show_Address_Live()
        {
            Application.UseWaitCursor = true;
            this.Cursor = System.Windows.Forms.Cursors.WaitCursor;
            Application.DoEvents();
            
            DialogResult dlgRESULT;
            EAPF0299.EAPF0299 vEAPF0299 = new EAPF0299.EAPF0299(this.MdiParent, isAppInterfaceAdv1.AppInterface, LIVE_ZIP_CODE.EditValue, LIVE_ADDR1.EditValue);
            dlgRESULT = vEAPF0299.ShowDialog();

            if (dlgRESULT == DialogResult.OK)
            {
                LIVE_ZIP_CODE.EditValue = vEAPF0299.Get_Zip_Code;
                LIVE_ADDR1.EditValue = vEAPF0299.Get_Address;
            }
            vEAPF0299.Dispose();
            this.Cursor = System.Windows.Forms.Cursors.Default;
            Application.UseWaitCursor = false;
            Application.DoEvents();
        }

        #endregion;

        #region ----- 주민번호 체크 ------

        private string REPRE_NUM_CHECK(object pREPRE_NUM)
        {
            string isReturnValue = "N".ToString();
            if (iString.ISNull(pREPRE_NUM) == string.Empty)
            {
                return isReturnValue;
            }
            idcREPRE_NUM_CHECK.SetCommandParamValue("P_REPRE_NUM", pREPRE_NUM);
            idcREPRE_NUM_CHECK.ExecuteNonQuery();
            isReturnValue = idcREPRE_NUM_CHECK.GetCommandParamValue("O_RETURN_VALUE").ToString();
            return isReturnValue;
        }

        #endregion;

        #region ----- Main Button Events -----

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
                    if (IDA_SAVING_INFO.IsFocused || (IDA_PERSON.IsFocused && TB_ADJUSTMENT.SelectedTab.TabIndex == 4))
                    {
                        IDA_SAVING_INFO.AddOver();
                    }
                    else if (IDA_DONATION_INFO.IsFocused || (IDA_PERSON.IsFocused && TB_ADJUSTMENT.SelectedTab.TabIndex == 5))
                    {
                        IDA_DONATION_INFO.AddOver();
                    }
                    else if (IDA_DONATION_ADJUSTMENT.IsFocused || (IDA_PERSON.IsFocused && TB_ADJUSTMENT.SelectedTab.TabIndex == 6))
                    {
                        IDA_DONATION_ADJUSTMENT.AddOver();
                    }
                    SET_TB_ADJUSTMENT_FOCUS();
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddUnder)
                {
                    if (IDA_SAVING_INFO.IsFocused || (IDA_PERSON.IsFocused && TB_ADJUSTMENT.SelectedTab.TabIndex == 4))
                    {
                        IDA_SAVING_INFO.AddUnder();
                    }
                    else if (IDA_DONATION_INFO.IsFocused || (IDA_PERSON.IsFocused && TB_ADJUSTMENT.SelectedTab.TabIndex == 5))
                    {
                        IDA_DONATION_INFO.AddUnder();
                    }
                    else if (IDA_DONATION_ADJUSTMENT.IsFocused || (IDA_PERSON.IsFocused && TB_ADJUSTMENT.SelectedTab.TabIndex == 6))
                    {
                        IDA_DONATION_ADJUSTMENT.AddUnder();
                    }
                    SET_TB_ADJUSTMENT_FOCUS();
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Update)
                {
                    try
                    {
                        IDA_PERSON.Update();
                    }
                    catch (Exception Ex)
                    {

                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Cancel)
                {
                    if (IDA_PERSON.IsFocused)
                    {
                        IDA_DONATION_ADJUSTMENT.Cancel();
                        IDA_DONATION_INFO.Cancel();
                        IDA_SAVING_INFO.Cancel();
                        IDA_FAMILY_AMOUNT.Cancel();
                        IDA_FAMILY.Cancel();
                        IDA_PERSON.Cancel();
                    }
                    else if (IDA_FAMILY.IsFocused)
                    {
                        IDA_FAMILY.Cancel();
                    }
                    else if (IDA_FAMILY_AMOUNT.IsFocused)
                    {
                        IDA_FAMILY_AMOUNT.Cancel();
                    }
                    else if (IDA_FOUNDATION.IsFocused)
                    {
                        IDA_FOUNDATION.Cancel();
                    }
                    else if (IDA_SAVING_INFO.IsFocused)
                    {
                        IDA_SAVING_INFO.Cancel();
                    }
                    else if (IDA_DONATION_INFO.IsFocused)
                    {
                        IDA_DONATION_INFO.Cancel();
                    }
                    else if (IDA_DONATION_ADJUSTMENT.IsFocused)
                    {
                        IDA_DONATION_ADJUSTMENT.Cancel();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {
                    if (IDA_FAMILY.IsFocused)
                    {
                        IDA_FAMILY.Delete();
                    }
                    else if (IDA_FAMILY_AMOUNT.IsFocused)
                    {
                        IDA_FAMILY_AMOUNT.Delete();
                    }
                    else if (IDA_FOUNDATION.IsFocused)
                    {
                        IDA_FOUNDATION.Delete();
                    }
                    else if (IDA_SAVING_INFO.IsFocused)
                    {
                        IDA_SAVING_INFO.Delete();
                    }
                    else if (IDA_DONATION_INFO.IsFocused)
                    {
                        IDA_DONATION_INFO.Delete();
                    }
                    else if (IDA_DONATION_ADJUSTMENT.IsFocused)
                    {
                        IDA_DONATION_ADJUSTMENT.Delete();
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

        #region ----- This Form Events -----

        private void HRMF0701_Load(object sender, EventArgs e)
        {
            IDA_PERSON.FillSchema();
            IDA_FAMILY.FillSchema();
            IDA_FAMILY_AMOUNT.FillSchema();
            IDA_FOUNDATION.FillSchema();
            IDA_SAVING_INFO.FillSchema();
            IDA_DONATION_INFO.FillSchema();
            IDA_DONATION_ADJUSTMENT.FillSchema();
        }

        private void HRMF0701_Shown(object sender, EventArgs e)
        {
            DefaultDate();
            DefaultCorporation();            
            isBatchCreate.CheckedState = ISUtil.Enum.CheckedState.Unchecked;
            PM_DONATION.PromptTextElement[0].Default = "기부금명세서를 작성하셨을 경우 [기부금 조정명세서]를 생성하시기 바랍니다.\r\n해당연도 기부금 공제대상금액이 생성됩니다";
        }

        private void BTN_FAMILY_CREATE_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            CREATE_SUPPORT_FAMILY();
        }

        private void BTN_DONATION_CREATE_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            CREATE_DONATION_ADJUSTMENT();
        }

        private void TB_ADJUSTMENT_Click(object sender, EventArgs e)
        {
            SET_TB_ADJUSTMENT_FOCUS();
        }

        private void IGR_DONATION_ADJUSTMENT_CurrentCellChanged(object pSender, ISGridAdvExChangedEventArgs e)
        {
            int mIDX_DOAN_AMT = IGR_DONATION_ADJUSTMENT.GetColumnToIndex("DONA_AMT");
            int mIDX_PRE_DONA_DED_AMT = IGR_DONATION_ADJUSTMENT.GetColumnToIndex("PRE_DONA_DED_AMT");
            decimal mTOTAL_DONA_AMT = 0;
            if (e.ColIndex == mIDX_DOAN_AMT)
            {
                mTOTAL_DONA_AMT = iString.ISDecimaltoZero(e.NewValue) - 
                                    iString.ISDecimaltoZero(IGR_DONATION_ADJUSTMENT.GetCellValue("PRE_DONA_DED_AMT"));
                IGR_DONATION_ADJUSTMENT.SetCellValue("TOTAL_DONA_AMT", mTOTAL_DONA_AMT);
            }
            else if (e.ColIndex == mIDX_PRE_DONA_DED_AMT)
            {
                mTOTAL_DONA_AMT = iString.ISDecimaltoZero(IGR_DONATION_ADJUSTMENT.GetCellValue("DONA_AMT")) -
                                    iString.ISDecimaltoZero(e.NewValue);
                IGR_DONATION_ADJUSTMENT.SetCellValue("TOTAL_DONA_AMT", mTOTAL_DONA_AMT);
            }
        }

        private void LIVE_ZIP_CODE_KeyDown(object pSender, KeyEventArgs e)
        {
            if(e.KeyCode == Keys.Enter)
            {
                Show_Address_Live();
            }
        }

        private void LIVE_ADDR1_KeyDown(object pSender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
            {
                Show_Address_Live();
            }
        }

        private void IGR_FAMILY_CurrentCellChanged(object pSender, ISGridAdvExChangedEventArgs e)
        {
            int vIDX_BASE_YN = IGR_FAMILY.GetColumnToIndex("BASE_YN");
            if (e.ColIndex == vIDX_BASE_YN && iString.ISNull(IGR_FAMILY.GetCellValue("YEAR_RELATION_CODE")) == "3")
            {
                IGR_FAMILY.SetCellValue("SPOUSE_YN", e.NewValue);
            }
        }

        #endregion;

        #region ----- Lookup Event -----

        private void ilaCORP_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {

        }

        private void ilaPERSON_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {

        }

        private void ilaEDUCATION_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommon("EDU_LMT", "Y");
        }

        private void ILA_RESIDENT_TYPE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommon("RESIDENT_TYPE", "Y");
        }

        private void ILA_NATION_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommon("NATION", "Y");
        }

        private void ILA_NATIONALITY_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommon("NATIONALITY_TYPE", "Y");
        }

        private void ILA_HOUSEHOLD_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommon("HOUSEHOLD_TYPE", "Y");
        }

        private void ilaADDRESS_RefreshLookupData(object pSender, ISRefreshLookupDataEventArgs e)
        {
            ildADDRESS.SetLookupParamValue("W_ADDRESS", LIVE_ZIP_CODE.EditValue);
        }

        private void ILA_SAVING_TYPE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommon("SAVING_TYPE", "Y");
        }

        private void ILA_YEAR_BANK_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommon("YEAR_BANK", "Y");
        }

        private void ILA_DONATION_TYPE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommon("DONATION_TYPE", "Y");
        }

        private void ILA_YEAR_RELATION_5_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommon("YEAR_RELATION", "Y");
        }

        private void ILA_DONATION_TYPE_6_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommon("DONATION_TYPE", "Y");
        }

        #endregion

        #region ----- Adapter Event -----

        private void idaPERSON_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {
            if (iString.ISNull(e.Row["PERSON_ID"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=[Person No]"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["REPRE_NUM"]) == string.Empty)
            {
                MessageBoxAdv.Show("[주민번호가]가 정확하지 않습니다. 확인하세요", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (REPRE_NUM_CHECK(e.Row["REPRE_NUM"]) == "N".ToString())
            {
                MessageBoxAdv.Show("[주민번호가]가 정확하지 않습니다. 확인하세요", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["RESIDENT_TYPE"]) == string.Empty)
            {
                MessageBoxAdv.Show("[거주구분]이 정확하지 않습니다. 확인하세요", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["NATION_ID"]) == string.Empty)
            {
                MessageBoxAdv.Show("[국가]가 정확하지 않습니다. 확인하세요", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["NATIONALITY_TYPE"]) == string.Empty)
            {
                MessageBoxAdv.Show("[내외국인 구분]이 정확하지 않습니다. 확인하세요", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;  
            }
            if (iString.ISNull(e.Row["HOUSEHOLD_TYPE"]) == string.Empty)
            {
                MessageBoxAdv.Show("[세대주 구분]이 정확하지 않습니다. 확인하세요", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["LIVE_ADDR1"]) == string.Empty)
            {
                MessageBoxAdv.Show("[주소]가 정확하지 않습니다. 확인하세요", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
        }

        private void IDA_FAMILY_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {
            if (iString.ISNull(ADJUST_YYYY.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show("[정산년도]가 정확하지 않습니다. 확인하세요", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["YEAR_RELATION_CODE"]) == string.Empty)
            {
                MessageBoxAdv.Show("[관계]가 정확하지 않습니다. 확인하세요", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["FAMILY_NAME"]) == string.Empty)
            {
                MessageBoxAdv.Show("[성명]이 정확하지 않습니다. 확인하세요", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["REPRE_NUM"]) == string.Empty)
            {
                MessageBoxAdv.Show("[주민번호가]가 정확하지 않습니다. 확인하세요", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (REPRE_NUM_CHECK(e.Row["REPRE_NUM"]) == "N".ToString())
            {
                MessageBoxAdv.Show("[주민번호가]가 정확하지 않습니다. 확인하세요", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }

            //인적공제 처리 검증//
            IDC_CHECK_SUPPORT_FAMILY.SetCommandParamValue("W_REPRE_NUM", e.Row["REPRE_NUM"]);
            IDC_CHECK_SUPPORT_FAMILY.SetCommandParamValue("W_YEAR_YYYY", e.Row["YEAR_YYYY"]);
            IDC_CHECK_SUPPORT_FAMILY.SetCommandParamValue("P_YEAR_RELATION_CODE", e.Row["YEAR_RELATION_CODE"]);
            IDC_CHECK_SUPPORT_FAMILY.SetCommandParamValue("P_BASE_YN", e.Row["BASE_YN"]);
            IDC_CHECK_SUPPORT_FAMILY.SetCommandParamValue("P_SPOUSE_YN", e.Row["SPOUSE_YN"]);
            IDC_CHECK_SUPPORT_FAMILY.SetCommandParamValue("P_OLD_YN", e.Row["OLD_YN"]);
            IDC_CHECK_SUPPORT_FAMILY.SetCommandParamValue("P_OLD1_YN", e.Row["OLD1_YN"]);
            IDC_CHECK_SUPPORT_FAMILY.SetCommandParamValue("P_WOMAN_YN", e.Row["WOMAN_YN"]);
            IDC_CHECK_SUPPORT_FAMILY.SetCommandParamValue("P_CHILD_YN", e.Row["CHILD_YN"]);
            IDC_CHECK_SUPPORT_FAMILY.SetCommandParamValue("P_BIRTH_YN", e.Row["BIRTH_YN"]);
            IDC_CHECK_SUPPORT_FAMILY.ExecuteNonQuery();
            string vSTATUS = iString.ISNull(IDC_CHECK_SUPPORT_FAMILY.GetCommandParamValue("O_STATUS"));
            string vMESSAGE = iString.ISNull(IDC_CHECK_SUPPORT_FAMILY.GetCommandParamValue("O_MESSAGE"));
            if (IDC_CHECK_SUPPORT_FAMILY.ExcuteError || vSTATUS == "F")
            {
                if(vMESSAGE != string.Empty)
                {
                  MessageBoxAdv.Show(vMESSAGE, "Warning", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
                e.Cancel = true;
                return;
            }
        }

        private void IDA_FAMILY_AMOUNT_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {
            if (iString.ISNull(ADJUST_YYYY.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show("[정산년도]가 정확하지 않습니다. 확인하세요", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["YEAR_RELATION_CODE"]) == string.Empty)
            {
                MessageBoxAdv.Show("[관계]가 정확하지 않습니다. 확인하세요", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["FAMILY_NAME"]) == string.Empty)
            {
                MessageBoxAdv.Show("[성명]이 정확하지 않습니다. 확인하세요", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["REPRE_NUM"]) == string.Empty)
            {
                MessageBoxAdv.Show("[주민번호가]가 정확하지 않습니다. 확인하세요", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (REPRE_NUM_CHECK(e.Row["REPRE_NUM"]) == "N".ToString())
            {
                MessageBoxAdv.Show("[주민번호가]가 정확하지 않습니다. 확인하세요", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            //if (iString.ISNull(e.Row["EDUCATION_TYPE"]) == string.Empty && iString.ISDecimaltoZero(e.Row["EDU_AMT"]) != 0)
            //{
            //    MessageBoxAdv.Show("[교육비 구분]을 선택하지 않고 교육비를 입력했습니다. 확인하세요", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            //    e.Cancel = true;
            //    return;
            //}
            //if (iString.ISNull(e.Row["EDUCATION_TYPE"]) != string.Empty && iString.ISDecimaltoZero(e.Row["EDU_AMT"]) == 0)
            //{
            //    MessageBoxAdv.Show("[교육비 구분]을 선택하지 하고 교육비를 입력하지 않았습니다. 확인하세요", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            //    e.Cancel = true;
            //    return;
            //}
            //if (iString.ISDecimaltoZero(e.Row["EDUCATION_AMOUNT_LMT"]) < iString.ISDecimaltoZero(e.Row["EDU_AMT"]))
            //{
            //    MessageBoxAdv.Show("[교육비 한도]를 초과했습니다. 확인하세요", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            //    e.Cancel = true;
            //    return;
            //}
        }

        private void IDA_SAVING_INFO_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {
            if (iString.ISNull(ADJUST_YYYY.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show("[정산년도]가 정확하지 않습니다. 확인하세요", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["SAVING_TYPE"]) == string.Empty)
            {
                MessageBoxAdv.Show("[연금저축구분]이 정확하지 않습니다. 확인하세요", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["BANK_CODE"]) == string.Empty)
            {
                MessageBoxAdv.Show("[금융기관]이 정확하지 않습니다. 확인하세요", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["ACCOUNT_NUM"]) == string.Empty)
            {
                MessageBoxAdv.Show("[계좌번호]가 정확하지 않습니다. 확인하세요", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["SAVING_TYPE"]) == "41" && iString.ISNumtoZero(e.Row["SAVING_COUNT"], 0) == 0)
            {
                MessageBoxAdv.Show("[장기주식형저축소득공제]은 [납입연차]를 입력해야 합니다. 확인하세요", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["SAVING_AMOUNT"]) == string.Empty)
            {
                MessageBoxAdv.Show("[불입금액]이 정확하지 않습니다. 확인하세요", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
        }

        private void IDA_DONATION_INFO_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {
            if (iString.ISNull(ADJUST_YYYY.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show("[정산년도]가 정확하지 않습니다. 확인하세요", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["DONA_TYPE"]) == string.Empty)
            {
                MessageBoxAdv.Show("[기부금 유형]이 정확하지 않습니다. 확인하세요", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["FAMILY_NAME"]) == string.Empty)
            {
                MessageBoxAdv.Show("[기부자 성명]이 정확하지 않습니다. 확인하세요", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["REPRE_NUM"]) == string.Empty)
            {
                MessageBoxAdv.Show("[기부자 주민번호]가 정확하지 않습니다. 확인하세요", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["RELATION_CODE"]) == string.Empty)
            {
                MessageBoxAdv.Show("[기부자 관계]가 정확하지 않습니다. 확인하세요", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["CORP_NAME"]) == string.Empty)
            {
                MessageBoxAdv.Show("[기부처 상호]가 정확하지 않습니다. 확인하세요", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["CORP_TAX_REG_NO"]) == string.Empty)
            {
                MessageBoxAdv.Show("[기부처 사업자번호]가 정확하지 않습니다. 확인하세요", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["DONA_COUNT"]) == string.Empty)
            {
                MessageBoxAdv.Show("[기부 건수]가 정확하지 않습니다. 확인하세요", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["DONA_AMT"]) == string.Empty)
            {
                MessageBoxAdv.Show("[기부 금액]이 정확하지 않습니다. 확인하세요", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
        }

        private void IDA_DONATION_ADJUSTMENT_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {
            if (iString.ISNull(ADJUST_YYYY.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show("[정산년도]가 정확하지 않습니다. 확인하세요", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["DONA_TYPE"]) == string.Empty)
            {
                MessageBoxAdv.Show("[기부금 유형]이 정확하지 않습니다. 확인하세요", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["DONA_YYYY"]) == string.Empty)
            {
                MessageBoxAdv.Show("[기부 년도]가 정확하지 않습니다. 확인하세요", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNumtoZero(ADJUST_YYYY.EditValue) < iString.ISNumtoZero(e.Row["DONA_YYYY"]))
            {
                MessageBoxAdv.Show("[기부 년도]가 [정산년도] 이후 일수는 없습니다. 확인하세요", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["DONA_AMT"]) == string.Empty)
            {
                MessageBoxAdv.Show("[기부 금액]이 정확하지 않습니다. 확인하세요", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
        }

        private void IDA_FAMILY_AMOUNT_PreNewRowMoved(object pSender, ISBindingEventArgs pBindingManager)
        {
            if (pBindingManager.DataRow == null)
            {
                return;
            }

            int vIDX_CASH_AMT = IGR_FAMILY_AMOUNT.GetColumnToIndex("CASH_AMT");
            if (iString.ISNull(pBindingManager.DataRow["AMOUNT_TYPE"]) == "2")
            {
                IGR_FAMILY_AMOUNT.GridAdvExColElement[vIDX_CASH_AMT].Insertable = 0;
                IGR_FAMILY_AMOUNT.GridAdvExColElement[vIDX_CASH_AMT].Updatable = 0;
            }
            else
            {
                IGR_FAMILY_AMOUNT.GridAdvExColElement[vIDX_CASH_AMT].Insertable = 1;
                IGR_FAMILY_AMOUNT.GridAdvExColElement[vIDX_CASH_AMT].Updatable = 1;
            }
        }

        private void IDA_FOUNDATION_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {
            int vCount = 0;
            if (iString.ISDecimaltoZero(e.Row["LONG_HOUSE_INTER_AMT_1"], 0) != 0)
            {
                vCount = vCount + 1;
            }
            if (iString.ISDecimaltoZero(e.Row["LONG_HOUSE_INTER_AMT_2"], 0) != 0)
            {
                vCount = vCount + 1;
            }
            if (iString.ISDecimaltoZero(e.Row["LONG_HOUSE_INTER_AMT_3_FIX"], 0) != 0)
            {
                vCount = vCount + 1;
            }
            if (iString.ISDecimaltoZero(e.Row["LONG_HOUSE_INTER_AMT_3_ETC"], 0) != 0)
            {
                vCount = vCount + 1;
            }
            if (vCount > 1)
            {
                MessageBoxAdv.Show("1,000만원 한도금액, 1,500만원 한도금액 또는 500만원 한도금액중 하나만 입력 가능합니다.", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
        }

        #endregion

        
    }
}