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

namespace FCMF0813
{
    public partial class FCMF0813 : Office2007Form
    {
        #region ----- Variables -----

        ISFunction.ISConvert iString = new ISFunction.ISConvert();
        ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        #endregion;

        #region ----- Constructor -----

        public FCMF0813()
        {
            InitializeComponent();
        }

        public FCMF0813(Form pMainForm, ISAppInterface pAppInterface)
        {
            InitializeComponent();
            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;
        }

        #endregion;

        #region ----- Private Methods ----

        private DateTime GetDate()
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

        private void Set_Default_Value()
        {
            //사업장 구분.
            idcDV_TAX_CODE.SetCommandParamValue("W_GROUP_CODE", "TAX_CODE");
            idcDV_TAX_CODE.ExecuteNonQuery();
            TAX_CODE_NAME_0.EditValue = idcDV_TAX_CODE.GetCommandParamValue("O_CODE_NAME");
            TAX_CODE_0.EditValue = idcDV_TAX_CODE.GetCommandParamValue("O_CODE");

            //자산취득기간.
            DateTime vGetDateTime = GetDate();

            ISCommonUtil.ISFunction.ISDateTime vDate = new ISCommonUtil.ISFunction.ISDateTime();
            DateTime vMonthFirstDay = vDate.ISMonth_1st(vGetDateTime);

            ISSUE_DATE_FR_0.EditValue = vMonthFirstDay;
            ISSUE_DATE_TO_0.EditValue = vGetDateTime;

            WRITE_DATE_0.EditValue = ISSUE_DATE_TO_0.EditValue;
        }

        private void SEARCH_DB()
        {
            if (iString.ISNull(TAX_CODE_0.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10007"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                TAX_CODE_NAME_0.Focus();
                return;
            }

            if (iString.ISNull(ISSUE_DATE_FR_0.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10010"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                ISSUE_DATE_FR_0.Focus();
                return;
            }
            if (iString.ISNull(ISSUE_DATE_TO_0.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10011"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                ISSUE_DATE_FR_0.Focus();
                return;
            }
            if (Convert.ToDateTime(ISSUE_DATE_FR_0.EditValue) > Convert.ToDateTime(ISSUE_DATE_TO_0.EditValue))
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10012"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                ISSUE_DATE_FR_0.Focus();
                return;
            }

            idaBUSINESS_MASTER.Fill();
            idaVAT_DECLARATION.Fill();
            idaTAX_STANDARD.Fill();
            if (itbVAT_DECLARATION.SelectedTab.TabIndex == 1)
            {
                ISSUE_PERIOD_FR.Focus();
            }
            else if (itbVAT_DECLARATION.SelectedTab.TabIndex == 2)
            {
                BALANCE_TAX_VAT.Focus();
            }
            else if (itbVAT_DECLARATION.SelectedTab.TabIndex == 3)
            {
                SS_TAX_INVOICE_AMT.Focus();
            }
            else if (itbVAT_DECLARATION.SelectedTab.TabIndex == 4)
            {
                igrTAX_STANDARD.Focus();
            }
        }

        private void SetCommonParameter(object pGroup_Code, object pEnabled_YN)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", pGroup_Code);
            ildCOMMON.SetLookupParamValue("W_ENABLED_YN", pEnabled_YN);
        }

        #endregion;

        #region ----- XL Print 1 (매입) Method ----

        private void XLPrinting_1(string pOutChoice, ISDataAdapter pData1, ISDataAdapter pData2)
        {// pOutChoice : 출력구분.
            string vMessageText = string.Empty;
            string vSaveFileName = string.Empty;

            int vCountRow = pData1.OraSelectData.Rows.Count;

            if (vCountRow < 1)
            {
                vMessageText = string.Format("Without Data");
                isAppInterfaceAdv1.OnAppMessage(vMessageText);
                System.Windows.Forms.Application.DoEvents();
                return;
            }

            System.Windows.Forms.Application.UseWaitCursor = true;
            this.Cursor = System.Windows.Forms.Cursors.WaitCursor;
            System.Windows.Forms.Application.DoEvents();

            int vPageNumber = 0;

            vMessageText = string.Format(" Printing Starting...");
            isAppInterfaceAdv1.OnAppMessage(vMessageText);
            System.Windows.Forms.Application.DoEvents();

            XLPrinting xlPrinting = new XLPrinting(isAppInterfaceAdv1.AppInterface, isMessageAdapter1);

            try
            {// 폼에 있는 항목들중 기본적으로 출력해야 하는 값.
                idcVAT_PERIOD.ExecuteNonQuery();
                string vPeriod = string.Format("( {0} )", idcVAT_PERIOD.GetCommandParamValue("O_PERIOD"));
                string vISSUE_PERIOD = String.Format("({0:D2}월 {1:D2}일 ~ {2:D2}월 {3:D2}일)", ISSUE_PERIOD_FR.DateTimeValue.Month, ISSUE_PERIOD_FR.DateTimeValue.Day, ISSUE_DATE_TO.DateTimeValue.Month, ISSUE_DATE_TO.DateTimeValue.Day);
                
                // open해야 할 파일명 지정.
                //-------------------------------------------------------------------------------------
                xlPrinting.OpenFileNameExcel = "FCMF0813_001.xls";
                //-------------------------------------------------------------------------------------
                // 파일 오픈.
                //-------------------------------------------------------------------------------------
                bool isOpen = xlPrinting.XLFileOpen();
                //-------------------------------------------------------------------------------------

                //-------------------------------------------------------------------------------------
                if (isOpen == true)
                {
                    // 헤더 인쇄.
                    idaBUSINESS_MASTER.Fill();
                    if (idaBUSINESS_MASTER.SelectRows.Count > 0)
                    {
                        xlPrinting.HeaderWrite(idaBUSINESS_MASTER, vPeriod, vISSUE_PERIOD);
                    }

                    //과세표준인쇄.
                    idaPRINT_TAX_STANDARD.Fill();
                    if (igrPRINT_TAX_STANDARD.RowCount > 0)
                    {
                        xlPrinting.XLLine_3(igrPRINT_TAX_STANDARD);
                    }

                    // 실제 인쇄
                    vPageNumber = xlPrinting.LineWrite(pData1, pData2);

                    //출력구분에 따른 선택(인쇄 or file 저장)
                    if (pOutChoice == "PRINT")
                    {
                        xlPrinting.Printing(1, vPageNumber);
                    }
                    else if (pOutChoice == "FILE")
                    {
                        xlPrinting.SAVE("VAT_1_");
                    }

                    //-------------------------------------------------------------------------------------
                    xlPrinting.Dispose();
                    //-------------------------------------------------------------------------------------

                    vMessageText = string.Format("Printing End [Total Page : {0}]", vPageNumber);
                    isAppInterfaceAdv1.AppInterface.OnAppMessageEvent(vMessageText);
                    System.Windows.Forms.Application.DoEvents();
                }
                else
                {
                    vMessageText = "Excel File Open Error";
                    isAppInterfaceAdv1.AppInterface.OnAppMessageEvent(vMessageText);
                    System.Windows.Forms.Application.DoEvents();
                }
                //-------------------------------------------------------------------------------------
            }
            catch (System.Exception ex)
            {
                xlPrinting.Dispose();

                vMessageText = ex.Message;
                isAppInterfaceAdv1.AppInterface.OnAppMessageEvent(vMessageText);
                System.Windows.Forms.Application.DoEvents();
            }

            System.Windows.Forms.Application.UseWaitCursor = false;
            this.Cursor = System.Windows.Forms.Cursors.Default;
            System.Windows.Forms.Application.DoEvents();
        }

        #endregion;
        
        #region ----- Events -----

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
                    
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddUnder)
                {
                    
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Update)
                {
                    if (idaTAX_STANDARD.IsFocused)
                    {
                        idaTAX_STANDARD.Update();
                    }
                    else
                    {
                        idaVAT_DECLARATION.Update();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Cancel)
                {
                    if (idaVAT_DECLARATION.IsFocused)
                    {
                        idaVAT_DECLARATION.Cancel();
                    }
                    else if (idaDECLARATION_ATTACH.IsFocused)
                    {
                        idaDECLARATION_ATTACH.Cancel();
                    }
                    else if (idaTAX_STANDARD.IsFocused)
                    {
                        idaTAX_STANDARD.Cancel();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {
                    if (idaVAT_DECLARATION.IsFocused)
                    {
                        idaVAT_DECLARATION.Delete();
                    }
                    else if (idaDECLARATION_ATTACH.IsFocused)
                    {
                        idaDECLARATION_ATTACH.Delete();
                    }
                    else if (idaTAX_STANDARD.IsFocused)
                    {
                        idaTAX_STANDARD.Delete();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Print)
                {
                    XLPrinting_1("PRINT", idaVAT_DECLARATION, idaDECLARATION_ATTACH);
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Export)
                {
                    XLPrinting_1("FILE", idaVAT_DECLARATION, idaDECLARATION_ATTACH);
                }
            }
        }

        #endregion;

        #region ----- Form Event ------

        private void FCMF0813_Load(object sender, EventArgs e)
        {
            idaVAT_DECLARATION.FillSchema();
            idaTAX_STANDARD.FillSchema();
        }

        private void FCMF0813_Shown(object sender, EventArgs e)
        {
            Set_Default_Value();
        }

        private void itbVAT_DECLARATION_Click(object sender, EventArgs e)
        {
            if (itbVAT_DECLARATION.SelectedTab.TabIndex == 1)
            {
                ISSUE_PERIOD_FR.Focus();
            }
            else if (itbVAT_DECLARATION.SelectedTab.TabIndex == 2)
            {
                BALANCE_TAX_VAT.Focus();
            }
            else if (itbVAT_DECLARATION.SelectedTab.TabIndex == 3)
            {
                SS_TAX_INVOICE_AMT.Focus();
            }
            else if (itbVAT_DECLARATION.SelectedTab.TabIndex == 4)
            {
                igrTAX_STANDARD.Focus();
            }
        }

        private void ibtnSET_DECLARATION_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            if (iString.ISNull(TAX_CODE_0.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10007"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                TAX_CODE_NAME_0.Focus();
                return;
            }

            if (iString.ISNull(ISSUE_DATE_FR_0.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10010"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                ISSUE_DATE_FR_0.Focus();
                return;
            }
            if (iString.ISNull(ISSUE_DATE_TO_0.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10011"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                ISSUE_DATE_TO_0.Focus();
                return;
            }
            if (Convert.ToDateTime(ISSUE_DATE_FR_0.EditValue) > Convert.ToDateTime(ISSUE_DATE_TO_0.EditValue))
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10012"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                ISSUE_DATE_FR_0.Focus();
                return;
            }

            string mMESSAGE;
            idcSET_DECLARATION.ExecuteNonQuery();
            mMESSAGE = iString.ISNull(idcSET_DECLARATION.GetCommandParamValue("O_MESSAGE"));
            if (mMESSAGE != String.Empty)
            {
                MessageBoxAdv.Show(mMESSAGE, "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
        }

        #endregion

        #region ----- Lookup Event -----

        private void ilaTAX_CODE_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter("TAX_CODE", "Y");
        }
        
        #endregion

        #region ----- Adapter Event : TAX_STANDARD ------
        
        private void idaTAX_STANDARD_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {
            if (iString.ISNull(e.Row["TAX_AMOUNT"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10243", "&&VALUE:="), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
        }
        //private void idaDPR_ASSET_DETAIL_PreRowUpdate(ISPreRowUpdateEventArgs e)
        //{
        //    if (iString.ISNull(e.Row["DPR_ASSET_ID"]) == string.Empty)
        //    {
        //        MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10232"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
        //        e.Cancel = true;
        //        return;
        //    }
        //    if (iString.ISNull(e.Row["ACQUIRE_DATE"]) == string.Empty)
        //    {
        //        MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10203"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
        //        e.Cancel = true;
        //        return;
        //    }
        //    if (iString.ISNull(e.Row["ACCOUNT_CONTROL_ID"]) == string.Empty)
        //    {
        //        MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10123"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
        //        e.Cancel = true;
        //        return;
        //    }
        //    if (iString.ISNull(e.Row["CUSTOMER_ID"]) == string.Empty)
        //    {
        //        MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10135"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
        //        e.Cancel = true;
        //        return;
        //    }
        //    if (iString.ISNull(e.Row["GL_AMOUNT"]) == string.Empty)
        //    {
        //        MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10208"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
        //        e.Cancel = true;
        //        return;
        //    }
        //    if (iString.ISNull(e.Row["VAT_AMOUNT"]) == string.Empty)
        //    {
        //        MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10281"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
        //        e.Cancel = true;
        //        return;
        //    }
        //    if (iString.ISNull(e.Row["VAT_ASSET_GB"]) == string.Empty)
        //    {
        //        MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10282"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
        //        e.Cancel = true;
        //        return;
        //    }
        //}

        //private void idaDPR_ASSET_DETAIL_PreDelete(ISPreDeleteEventArgs e)
        //{
        //    if (e.Row.RowState != DataRowState.Added)
        //    {
        //        if (iString.ISNull(e.Row["DPR_ASSET_ID"]) == string.Empty)
        //        {
        //            MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10232"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
        //            e.Cancel = true;
        //            return;
        //        }
        //    }
        //}

        #endregion
        
    }
}