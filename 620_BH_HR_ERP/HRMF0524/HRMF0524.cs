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

namespace HRMF0524
{
    public partial class HRMF0524 : Office2007Form
    {
        #region ----- Variables -----

        ISCommonUtil.ISFunction.ISConvert iString = new ISFunction.ISConvert();
        ISCommonUtil.ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        #endregion;

        #region ----- Constructor -----

        public HRMF0524()
        {
            InitializeComponent();
        }

        public HRMF0524(Form pMainForm, ISAppInterface pAppInterface)
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

        private void Search_DB()
        {
            if (itbPAYMENT_SLIP.SelectedTab.TabIndex == 1)
            {
                if (iString.ISNull(CORP_ID_0.EditValue) == string.Empty)
                {
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10001"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    CORP_NAME_0.Focus();
                    return;
                }
                if (iString.ISNull(PAY_YYYYMM_0.EditValue) == String.Empty)
                {// 급여년월
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10036"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    PAY_YYYYMM_0.Focus();
                    return;
                }
                if (iString.ISNull(WAGE_TYPE_0.EditValue) == string.Empty)
                {// 급상여 구분
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10105"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    WAGE_TYPE_NAME_0.Focus();
                    return;
                }            
                idaPAYMENT_SLIP_SUM.Fill();
                SLIP_SUM_AMOUNT();  // 전표 합계.
                igrSLIP_SUM.Focus();
            }
            else if (itbPAYMENT_SLIP.SelectedTab.TabIndex == 2)
            {
                if (iString.ISNull(JOB_CODE_0.EditValue) == String.Empty)
                {
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10155"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    JOB_DESC_0.Focus();
                    return;
                }

                idaSELECT_AUTO_DOC_H.Fill();
                H_SLIP_TYPE_NAME.Focus();
            }
        }

        private void SLIP_SUM_AMOUNT()
        {
            int IDX_DR = igrSLIP_SUM.GetColumnToIndex("DR_AMOUNT");
            int IDX_CR = igrSLIP_SUM.GetColumnToIndex("CR_AMOUNT");

            decimal vDR_SUM = 0;
            decimal vCR_SUM = 0;
            for (int R = 0; R < igrSLIP_SUM.RowCount; R++)
            {
                vDR_SUM = vDR_SUM + iString.ISDecimaltoZero(igrSLIP_SUM.GetCellValue(R, IDX_DR));
                vCR_SUM = vCR_SUM + iString.ISDecimaltoZero(igrSLIP_SUM.GetCellValue(R, IDX_CR));
            }
            DR_SUM.EditValue = vDR_SUM;
            CR_SUM.EditValue = vCR_SUM;
            GAP_AMOUNT.EditValue = System.Math.Abs(vDR_SUM - vCR_SUM) * -1;
        }

        private void Insert_Document_Header()
        {
            H_ENABLED_FLAG.CheckBoxValue = "Y";
            H_EFFECTIVE_DATE_FR.EditValue = iDate.ISMonth_1st(DateTime.Today);

            H_SLIP_TYPE_NAME.Focus();
        }
        
        private void Insert_Document_Line()
        {
            igrDOCUMENT_LINE.SetCellValue("ENABLED_FLAG", "Y");
            igrDOCUMENT_LINE.SetCellValue("EFFECTIVE_DATE_FR", iDate.ISMonth_1st(DateTime.Today));

            igrDOCUMENT_LINE.CurrentCellMoveTo(igrDOCUMENT_LINE.GetColumnToIndex("ACCOUNT_CODE"));
            igrDOCUMENT_LINE.CurrentCellActivate(igrDOCUMENT_LINE.GetColumnToIndex("ACCOUNT_CODE"));
            igrDOCUMENT_LINE.Focus();
        }

        private void Insert_Allowance()
        {
            igrALLOWANCE.CurrentCellMoveTo(igrALLOWANCE.GetColumnToIndex("ALLOWANCE_NAME"));
            igrALLOWANCE.CurrentCellActivate(igrALLOWANCE.GetColumnToIndex("ALLOWANCE_NAME"));
            igrALLOWANCE.Focus();
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
                    if (idaSELECT_AUTO_DOC_H.IsFocused)
                    {
                        idaSELECT_AUTO_DOC_H.AddOver();
                        Insert_Document_Header();
                    }
                    else if (idaSELECT_AUTO_DOC_L.IsFocused)
                    {
                        idaSELECT_AUTO_DOC_L.AddOver();
                        Insert_Document_Line();
                    }
                    else if (idaDOCUMENT_ALLOWANCE.IsFocused)
                    {
                        idaDOCUMENT_ALLOWANCE.AddOver();
                        Insert_Allowance();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddUnder)
                {
                    if (idaSELECT_AUTO_DOC_H.IsFocused)
                    {
                        idaSELECT_AUTO_DOC_H.AddUnder();
                        Insert_Document_Header();
                    }
                    else if (idaSELECT_AUTO_DOC_L.IsFocused)
                    {
                        idaSELECT_AUTO_DOC_L.AddUnder();
                        Insert_Document_Line();
                    }
                    else if (idaDOCUMENT_ALLOWANCE.IsFocused)
                    {
                        idaDOCUMENT_ALLOWANCE.AddUnder();
                        Insert_Allowance();
                    }   
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Update)
                {
                    if (idaSELECT_AUTO_DOC_H.IsFocused || idaSELECT_AUTO_DOC_L.IsFocused || idaDOCUMENT_ALLOWANCE.IsFocused)
                    {
                        idaSELECT_AUTO_DOC_H.Update();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Cancel)
                {
                    if (idaPAYMENT_SLIP_SUM.IsFocused)
                    {
                        idaPAYMENT_SLIP_SUM.Cancel();
                    }
                    else if (idaSELECT_AUTO_DOC_H.IsFocused)
                    {
                        idaDOCUMENT_ALLOWANCE.Cancel();
                        idaSELECT_AUTO_DOC_L.Cancel();
                        idaSELECT_AUTO_DOC_H.Cancel();
                    }
                    else if (idaSELECT_AUTO_DOC_L.IsFocused)
                    {
                        idaDOCUMENT_ALLOWANCE.Cancel();
                        idaSELECT_AUTO_DOC_L.Cancel();
                    }
                    else if (idaDOCUMENT_ALLOWANCE.IsFocused)
                    {
                        idaDOCUMENT_ALLOWANCE.Cancel();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {
                    if (idaPAYMENT_SLIP_SUM.IsFocused)
                    {
                        idaPAYMENT_SLIP_SUM.Delete();
                    }
                    else if (idaSELECT_AUTO_DOC_H.IsFocused)
                    {
                        for (int i = 0; i < igrALLOWANCE.RowCount; i++)
                        {
                            idaDOCUMENT_ALLOWANCE.CurrentRows[i].Delete();
                        }
                        for (int i = 0; i < igrDOCUMENT_LINE.RowCount; i++)
                        {
                            idaSELECT_AUTO_DOC_L.CurrentRows[i].Delete();
                        }
                        idaSELECT_AUTO_DOC_H.Delete();
                    }
                    else if (idaSELECT_AUTO_DOC_L.IsFocused)
                    {
                        for (int i = 0; i < igrALLOWANCE.RowCount; i++)
                        {
                            idaDOCUMENT_ALLOWANCE.CurrentRows[i].Delete();
                        }
                        idaSELECT_AUTO_DOC_L.Delete();
                    }
                    else if (idaDOCUMENT_ALLOWANCE.IsFocused)
                    {
                        idaDOCUMENT_ALLOWANCE.Delete();
                    }
                }
            }
        }

        #endregion;

        #region ----- Form Event ------

        private void HRMF0524_Load(object sender, EventArgs e)
        {
            idaSELECT_AUTO_DOC_H.FillSchema();
            idaSELECT_AUTO_DOC_L.FillSchema();
            idaDOCUMENT_ALLOWANCE.FillSchema();
        }

        private void HRMF0524_Shown(object sender, EventArgs e)
        {
            PAY_YYYYMM_0.EditValue = iDate.ISYearMonth(DateTime.Today);
            DefaultCorporation();              //Default Corp.
        }

        private void SET_SLIP_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            if (CORP_ID_0.EditValue == null)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10001"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                CORP_NAME_0.Focus();
                return;
            }
            if (iString.ISNull(PAY_YYYYMM_0.EditValue) == String.Empty)
            {// 급여년월
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10036"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                PAY_YYYYMM_0.Focus();
                return;
            }
            if (iString.ISNull(WAGE_TYPE_0.EditValue) == string.Empty)
            {// 급상여 구분
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10105"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                WAGE_TYPE_NAME_0.Focus();
                return;
            }

            DialogResult vdlgResult;
            vdlgResult = MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10303"), "Question", MessageBoxButtons.YesNo, MessageBoxIcon.Question);
            if (vdlgResult == DialogResult.No)
            {
                return;
            }

            isDataTransaction1.BeginTran();
            string vSTATUS = "F";
            string vMESSAGE = null;
            Application.DoEvents();
            Application.UseWaitCursor = true;
            this.Cursor = System.Windows.Forms.Cursors.WaitCursor;
            idcSET_SLIP.ExecuteNonQuery();
            vSTATUS = iString.ISNull(idcSET_SLIP.GetCommandParamValue("O_STATUS"));
            vMESSAGE = iString.ISNull(idcSET_SLIP.GetCommandParamValue("O_MESSAGE"));            
            Application.DoEvents();
            Application.UseWaitCursor = false;
            this.Cursor = System.Windows.Forms.Cursors.Default;
            if(idcSET_SLIP.ExcuteError || vSTATUS == "F")
            {
                isDataTransaction1.RollBack();
                MessageBoxAdv.Show(vMESSAGE, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }
            isDataTransaction1.Commit();
            // refill.
            Search_DB();
        }

        private void CANCEL_SLIP_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            if (CORP_ID_0.EditValue == null)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10001"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                CORP_NAME_0.Focus();
                return;
            }
            if (iString.ISNull(PAY_YYYYMM_0.EditValue) == String.Empty)
            {// 급여년월
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10036"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                PAY_YYYYMM_0.Focus();
                return;
            }
            if (iString.ISNull(WAGE_TYPE_0.EditValue) == string.Empty)
            {// 급상여 구분
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10105"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                WAGE_TYPE_NAME_0.Focus();
                return;
            }

            DialogResult vdlgResult;
            vdlgResult = MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10333"), "Question", MessageBoxButtons.YesNo, MessageBoxIcon.Question);
            if (vdlgResult == DialogResult.No)
            {
                return;
            }

            isDataTransaction1.BeginTran();
            string vSTATUS = "F";
            string vMESSAGE = null;
            Application.DoEvents();
            Application.UseWaitCursor = true;
            this.Cursor = System.Windows.Forms.Cursors.WaitCursor;
            idcCANCEL_SLIP.ExecuteNonQuery();
            vSTATUS = iString.ISNull(idcCANCEL_SLIP.GetCommandParamValue("O_STATUS"));
            vMESSAGE = iString.ISNull(idcCANCEL_SLIP.GetCommandParamValue("O_MESSAGE"));
            Application.DoEvents();
            Application.UseWaitCursor = false;
            this.Cursor = System.Windows.Forms.Cursors.Default;
            if (idcCANCEL_SLIP.ExcuteError || vSTATUS == "F")
            {
                isDataTransaction1.RollBack();
                MessageBoxAdv.Show(vMESSAGE, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }
            isDataTransaction1.Commit();
            // refill.
            Search_DB();
        }
        
        #endregion

        #region ------ Lookup Event ------
        
        private void ilaYYYYMM_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildYYYYMM.SetLookupParamValue("W_START_YYYYMM", "2001-01");
            ildYYYYMM.SetLookupParamValue("W_END_YYYYMM", iDate.ISYearMonth(iDate.ISDate_Month_Add(DateTime.Today,2)));
        }

        private void ilaWAGE_TYPE_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCOMMON_W.SetLookupParamValue("W_GROUP_CODE", "CLOSING_TYPE");
            ildCOMMON_W.SetLookupParamValue("W_WHERE", "HC.VALUE1 = 'PAY' ");
            ildCOMMON_W.SetLookupParamValue("W_ENABLED_FLAG_YN", "N");
        }

        private void ilaJOB_CODE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildJOB_CODE.SetLookupParamValue("W_ENABLED_YN", "Y");
        }

        private void ilaDIR_INDIR_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", "DIR_INDIR_TYPE");
            ildCOMMON.SetLookupParamValue("W_ENABLED_FLAG_YN", "Y");
        }

        private void ilaSLIP_TYPE_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ild_FI_COMMON.SetLookupParamValue("W_GROUP_CODE", "SLIP_TYPE");
            ild_FI_COMMON.SetLookupParamValue("W_ENABLED_YN", "Y");
        }

        private void ilaVENDOR_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildVENDOR.SetLookupParamValue("W_ENABLED_YN", "Y");
        }

        private void ilaSLIP_TYPE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ild_FI_COMMON.SetLookupParamValue("W_GROUP_CODE", "SLIP_TYPE");
            ild_FI_COMMON.SetLookupParamValue("W_ENABLED_YN", "Y");
        }

        private void ilaACCOUNT_DR_CR_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ild_FI_COMMON.SetLookupParamValue("W_GROUP_CODE", "ACCOUNT_DR_CR");
            ild_FI_COMMON.SetLookupParamValue("W_ENABLED_YN", "Y");
        }

        private void ilaPAY_ALLOWANCE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCOMMON.SetLookupParamValue("W_ENABLED_FLAG_YN", "Y");
        }

        private void ilaACCOUNT_CODE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildACCOUNT_CONTROL.SetLookupParamValue("W_ENABLED_YN", "Y");
        }

        #endregion

        #region ----- Adapter Event -----

        private void idaSELECT_AUTO_DOC_H_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {
            if (iString.ISNull(e.Row["SLIP_TYPE"]) == String.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10116"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["JOB_CODE"]) == String.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10155"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["JOB_DESC"]) == String.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10155"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["EFFECTIVE_DATE_FR"]) == String.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10010"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
        }

        private void idaSELECT_AUTO_DOC_H_PreDelete(ISPreDeleteEventArgs e)
        {
            if (e.Row.RowState != DataRowState.Added)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10029", "&&VALUE:=Data(해당 자료)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);        // 모듈 코드 입력
                e.Cancel = true;
                return;
            }
        }

        private void idaSELECT_AUTO_DOC_L_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {
            if (iString.ISNull(e.Row["ACCOUNT_CONTROL_ID"]) == String.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10123"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["ACCOUNT_DR_CR"]) == String.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10122"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["EFFECTIVE_DATE_FR"]) == String.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10010"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
        }

        #endregion

    }
}