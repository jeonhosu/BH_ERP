using System;
using System.Data;
using System.Drawing;
using System.Windows.Forms;
using System.Collections.Generic;
using System.Text;

using Syncfusion.Windows.Forms;
using Syncfusion.Windows.Forms.Tools;
using Syncfusion.Windows.Forms.Grid;
using InfoSummit.Win.ControlAdv;
using ISCommonUtil;

namespace FCMF0814
{
    public partial class FCMF0814 : Office2007Form
    {
        #region ----- Variables -----

        ISFunction.ISConvert iString = new ISFunction.ISConvert();
        ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        #endregion;

        #region ----- Constructor -----

        public FCMF0814()
        {
            InitializeComponent();
        }

        public FCMF0814(Form pMainForm, ISAppInterface pAppInterface)
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
            idcDEFAULT_VALUE.SetCommandParamValue("W_GROUP_CODE", "TAX_CODE");
            idcDEFAULT_VALUE.ExecuteNonQuery();
            TAX_CODE_NAME_0.EditValue = idcDEFAULT_VALUE.GetCommandParamValue("O_CODE_NAME");
            TAX_CODE_0.EditValue = idcDEFAULT_VALUE.GetCommandParamValue("O_CODE");

            //일반과세자구분 구분.
            idcDEFAULT_VALUE.SetCommandParamValue("W_GROUP_CODE", "TAX_PAYER_TYPE");
            idcDEFAULT_VALUE.ExecuteNonQuery();
            TAX_PAYER_TYPE_DESC.EditValue = idcDEFAULT_VALUE.GetCommandParamValue("O_CODE_NAME");
            TAX_PAYER_TYPE.EditValue = idcDEFAULT_VALUE.GetCommandParamValue("O_CODE");

            //환급 구분.
            idcDEFAULT_VALUE.SetCommandParamValue("W_GROUP_CODE", "TAX_REFUND_TYPE");
            idcDEFAULT_VALUE.ExecuteNonQuery();
            TAX_REFUND_TYPE_DESC.EditValue = idcDEFAULT_VALUE.GetCommandParamValue("O_CODE_NAME");
            TAX_REFUND_TYPE.EditValue = idcDEFAULT_VALUE.GetCommandParamValue("O_CODE");

            //과세기간.
            DateTime vGetDateTime = GetDate();

            ISCommonUtil.ISFunction.ISDateTime vDate = new ISCommonUtil.ISFunction.ISDateTime();
            DateTime vMonthFirstDay = vDate.ISMonth_1st(vGetDateTime);

            ISSUE_DATE_FR_0.EditValue = vMonthFirstDay;
            ISSUE_DATE_TO_0.EditValue = vGetDateTime;

            WRITE_DATE.EditValue = ISSUE_DATE_TO_0.EditValue;
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

            idaREPORT.Fill();
            
            if (itbREPORT.SelectedTab.TabIndex == 1)
            {
                ISSUE_DATE_FR.Focus();
            }
        }

        private void SetCommonParameter(object pGroup_Code, object pEnabled_YN)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", pGroup_Code);
            ildCOMMON.SetLookupParamValue("W_ENABLED_YN", pEnabled_YN);
        }

        private void isSetAddressParameter(object pAddress)
        {
            ildADDRESS.SetLookupParamValue("W_ADDRESS", pAddress);
        }

        #endregion;

        #region ----- XL Print 1 (매입) Method ----

        private void XLPrinting_1(string pOutChoice, ISDataAdapter pData1)
        {// pOutChoice : 출력구분.
            //string vMessageText = string.Empty;
            //string vSaveFileName = string.Empty;

            //int vCountRow = pData1.OraSelectData.Rows.Count;

            //if (vCountRow < 1)
            //{
            //    vMessageText = string.Format("Without Data");
            //    isAppInterfaceAdv1.OnAppMessage(vMessageText);
            //    System.Windows.Forms.Application.DoEvents();
            //    return;
            //}

            //System.Windows.Forms.Application.UseWaitCursor = true;
            //this.Cursor = System.Windows.Forms.Cursors.WaitCursor;
            //System.Windows.Forms.Application.DoEvents();

            //int vPageNumber = 0;

            //vMessageText = string.Format(" Printing Starting...");
            //isAppInterfaceAdv1.OnAppMessage(vMessageText);
            //System.Windows.Forms.Application.DoEvents();

            //XLPrinting xlPrinting = new XLPrinting(isAppInterfaceAdv1.AppInterface, isMessageAdapter1);

            //try
            //{// 폼에 있는 항목들중 기본적으로 출력해야 하는 값.
            //    idcVAT_PERIOD.ExecuteNonQuery();
            //    string vPeriod = string.Format("( {0} )", idcVAT_PERIOD.GetCommandParamValue("O_PERIOD"));
            //    string vISSUE_PERIOD = String.Format("({0:D2}월 {1:D2}일 ~ {2:D2}월 {3:D2}일)", ISSUE_PERIOD_FR.DateTimeValue.Month, ISSUE_PERIOD_FR.DateTimeValue.Day, ISSUE_DATE_TO.DateTimeValue.Month, ISSUE_DATE_TO.DateTimeValue.Day);
                
            //    // open해야 할 파일명 지정.
            //    //-------------------------------------------------------------------------------------
            //    xlPrinting.OpenFileNameExcel = "FCMF0814_001.xls";
            //    //-------------------------------------------------------------------------------------
            //    // 파일 오픈.
            //    //-------------------------------------------------------------------------------------
            //    bool isOpen = xlPrinting.XLFileOpen();
            //    //-------------------------------------------------------------------------------------

            //    //-------------------------------------------------------------------------------------
            //    if (isOpen == true)
            //    {
            //        // 헤더 인쇄.
            //        idaREPORT.Fill();
            //        if (idaREPORT.SelectRows.Count > 0)
            //        {
            //            xlPrinting.HeaderWrite(idaREPORT, vPeriod, vISSUE_PERIOD);
            //        }

            //        //과세표준인쇄.
            //        idaPRINT_TAX_STANDARD.Fill();
            //        if (igrPRINT_TAX_STANDARD.RowCount > 0)
            //        {
            //            xlPrinting.XLLine_3(igrPRINT_TAX_STANDARD);
            //        }

            //        // 실제 인쇄
            //        vPageNumber = xlPrinting.LineWrite(pData1, pData2);

            //        //출력구분에 따른 선택(인쇄 or file 저장)
            //        if (pOutChoice == "PRINT")
            //        {
            //            xlPrinting.Printing(1, vPageNumber);
            //        }
            //        else if (pOutChoice == "FILE")
            //        {
            //            xlPrinting.SAVE("VAT_1_");
            //        }

            //        //-------------------------------------------------------------------------------------
            //        xlPrinting.Dispose();
            //        //-------------------------------------------------------------------------------------

            //        vMessageText = string.Format("Printing End [Total Page : {0}]", vPageNumber);
            //        isAppInterfaceAdv1.AppInterface.OnAppMessageEvent(vMessageText);
            //        System.Windows.Forms.Application.DoEvents();
            //    }
            //    else
            //    {
            //        vMessageText = "Excel File Open Error";
            //        isAppInterfaceAdv1.AppInterface.OnAppMessageEvent(vMessageText);
            //        System.Windows.Forms.Application.DoEvents();
            //    }
            //    //-------------------------------------------------------------------------------------
            //}
            //catch (System.Exception ex)
            //{
            //    xlPrinting.Dispose();

            //    vMessageText = ex.Message;
            //    isAppInterfaceAdv1.AppInterface.OnAppMessageEvent(vMessageText);
            //    System.Windows.Forms.Application.DoEvents();
            //}

            //System.Windows.Forms.Application.UseWaitCursor = false;
            //this.Cursor = System.Windows.Forms.Cursors.Default;
            //System.Windows.Forms.Application.DoEvents();
        }

        #endregion;

        #region ----- Text File Export Methods ----

        private void ExportTXT(ISDataAdapter pData)
        {
            int vCountRow = pData.OraSelectData.Rows.Count;
            if (vCountRow < 1)
            {
                return;
            }

            isAppInterfaceAdv1.OnAppMessage("Export Text Start...");

            int euckrCodepage = 51949; 
            System.IO.FileStream vWriteFile = null;
            System.Text.StringBuilder vSaveString = new System.Text.StringBuilder();

            saveFileDialog1.Title = "Save File";
            saveFileDialog1.FileName = WRITE_DATE.DateTimeValue.ToShortDateString().Replace("-", "");
            saveFileDialog1.DefaultExt = ".101";
            System.IO.DirectoryInfo vSaveFolder = new System.IO.DirectoryInfo(System.Environment.GetFolderPath(Environment.SpecialFolder.Desktop));
            saveFileDialog1.InitialDirectory = vSaveFolder.FullName;
            saveFileDialog1.Filter = "Text Files (*.101)|*.101";
            if (saveFileDialog1.ShowDialog() == System.Windows.Forms.DialogResult.OK)
            {
                Application.UseWaitCursor = true;
                this.Cursor = System.Windows.Forms.Cursors.WaitCursor;
                Application.DoEvents();
            
                string vsSaveTextFileName = saveFileDialog1.FileName;
                try
                {
                    vWriteFile = System.IO.File.Open(vsSaveTextFileName, System.IO.FileMode.Create, System.IO.FileAccess.Write, System.IO.FileShare.None);
                    foreach(DataRow cRow in pData.OraSelectData.Rows)
                    {
                        vSaveString = new System.Text.StringBuilder();  //초기화.
                        vSaveString.Append(cRow["REPORT_FILE"]);
                        vSaveString.Append("\r\n");

                        //기존
                        //byte[] vSaveBytes = new System.Text.UnicodeEncoding().GetBytes(vSaveString.ToString());

                        //신규.
                        System.Text.Encoding vEUCKR = System.Text.Encoding.GetEncoding(euckrCodepage);
                        byte[] vSaveBytes = vEUCKR.GetBytes(vSaveString.ToString()); 

                        int vSaveStrigLength = vSaveBytes.Length;
                        vWriteFile.Write(vSaveBytes, 0, vSaveStrigLength);

                        
                    }
                }
                catch (System.Exception ex)
                {
                    string vMessage = ex.Message;
                    isAppInterfaceAdv1.OnAppMessage(vMessage);
                    Application.DoEvents();
                    Application.UseWaitCursor = false;
                    this.Cursor = System.Windows.Forms.Cursors.Default;
                }

                isAppInterfaceAdv1.OnAppMessage("Export Text End");
                vWriteFile.Dispose();
            }
            Application.DoEvents();
            Application.UseWaitCursor = false;
            this.Cursor = System.Windows.Forms.Cursors.Default;                        
        }

        //public void ExportTXT_File(ISDataAdapter pData)
        //{
        //    int vCountRow = pData.OraSelectData.Rows.Count;
        //    if (vCountRow < 1)
        //    {
        //        return;
        //    }

        //    isAppInterfaceAdv1.OnAppMessage("Export Text Start...");

        //    System.IO.Stream vWrite = null; ;
        //    System.Text.StringBuilder vSaveString = new System.Text.StringBuilder();

        //    saveFileDialog1.Title = "Save File";
        //    saveFileDialog1.FileName = WRITE_DATE.DateTimeValue.ToShortDateString().Replace("-", "");
        //    saveFileDialog1.DefaultExt = ".101";
        //    System.IO.DirectoryInfo vSaveFolder = new System.IO.DirectoryInfo(System.Environment.GetFolderPath(Environment.SpecialFolder.Desktop));
        //    saveFileDialog1.InitialDirectory = vSaveFolder.FullName;
        //    saveFileDialog1.Filter = "Text Files (*.101)|*.101";
        //    if (saveFileDialog1.ShowDialog() == System.Windows.Forms.DialogResult.OK)
        //    {
        //        Application.UseWaitCursor = true;
        //        this.Cursor = System.Windows.Forms.Cursors.WaitCursor;
        //        Application.DoEvents();

        //        string vsSaveTextFileName = saveFileDialog1.FileName;
        //        try
        //        {
        //            //vWriteFile = System.IO.File.Open(vsSaveTextFileName, System.IO.FileMode.Create, System.IO.FileAccess.Write, System.IO.FileShare.None);
        //            vWrite = System.IO.File.OpenWrite(vsSaveTextFileName);
        //            foreach (DataRow cRow in pData.OraSelectData.Rows)
        //            {
        //                vSaveString = new System.Text.StringBuilder();  //초기화.
        //                vSaveString.Append(cRow["REPORT_FILE"]);
        //                vSaveString.Append("\r\n");

        //                System.IO.StreamWriter(vWrite, Encoding.Default);

        //                //byte[] vSaveBytes = new System.Text.UnicodeEncoding().GetBytes(vSaveString.ToString());
        //                //int vSaveStrigLength = vSaveBytes.Length;
        //                //vWriteFile.Write(vSaveBytes, 0, vSaveStrigLength);
        //            }
        //        }
        //        catch (System.Exception ex)
        //        {
        //            string vMessage = ex.Message;
        //            isAppInterfaceAdv1.OnAppMessage(vMessage);
        //            Application.DoEvents();
        //            Application.UseWaitCursor = false;
        //            this.Cursor = System.Windows.Forms.Cursors.Default;
        //        }

        //        isAppInterfaceAdv1.OnAppMessage("Export Text End");
        //        vWriteFile.Dispose();
        //    }
        //    Application.DoEvents();
        //    Application.UseWaitCursor = false;
        //    this.Cursor = System.Windows.Forms.Cursors.Default;
        //} 

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
                    if (idaREPORT.IsFocused)
                    {
                        idaREPORT.Update();
                    }                    
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Cancel)
                {
                    if (idaREPORT.IsFocused)
                    {
                        idaREPORT.Cancel();
                    }                  
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {
                    if (idaREPORT.IsFocused)
                    {
                        idaREPORT.Delete();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Print)
                {
                    XLPrinting_1("PRINT", idaREPORT);
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Export)
                {
                    XLPrinting_1("FILE", idaREPORT);
                }
            }
        }

        #endregion;

        #region ----- Form Event ------

        private void FCMF0814_Load(object sender, EventArgs e)
        {
            idaREPORT.FillSchema();
        }

        private void FCMF0814_Shown(object sender, EventArgs e)
        {
            Set_Default_Value();
        }

        private void itbREPORT_Click(object sender, EventArgs e)
        {
            if (itbREPORT.SelectedTab.TabIndex == 1)
            {
                ISSUE_DATE_FR.Focus();
            }            
        }

        private void ibtnSET_REPORT_FILE_ButtonClick_1(object pSender, EventArgs pEventArgs)
        {
            if (iString.ISNull(TAX_CODE_0.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10007"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                TAX_CODE_NAME_0.Focus();
                return;
            }

            if (iString.ISNull(ISSUE_DATE_FR.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10010"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                ISSUE_DATE_FR_0.Focus();
                return;
            }
            if (iString.ISNull(ISSUE_DATE_TO.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10011"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                ISSUE_DATE_TO_0.Focus();
                return;
            }
            if (Convert.ToDateTime(ISSUE_DATE_FR.EditValue) > Convert.ToDateTime(ISSUE_DATE_TO.EditValue))
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10012"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                ISSUE_DATE_FR_0.Focus();
                return;
            }
            if (iString.ISNull(ISSUE_DATE_TO.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10298"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                WRITE_DATE.Focus();
                return;
            }

            idaREPORT_FILE.Fill();
            ExportTXT(idaREPORT_FILE);

            //string mMESSAGE;
            //idcSET_REPORT_FILE.ExecuteNonQuery();
            //mMESSAGE = iString.ISNull(idcSET_REPORT_FILE.GetCommandParamValue("O_MESSAGE"));
            //if (mMESSAGE != String.Empty)
            //{
            //    MessageBoxAdv.Show(mMESSAGE, "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);
            //}
        }
        
        #endregion

        #region ----- Lookup Event -----

        private void ilaTAX_CODE_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter("TAX_CODE", "Y");
        }

        private void ilaTAX_PAYER_TYPE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter("TAX_PAYER_TYPE", "Y");
        }

        private void ilaBANK_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildBANK.SetLookupParamValue("W_ENABLED_YN", "Y");
        }

        private void ilaBANK_ACCOUNT_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildBANK_ACCOUNT.SetLookupParamValue("W_ENABLED_YN", "Y");
        }

        private void ilaTAX_REFUND_TYPE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter("TAX_REFUND_TYPE", "Y");
        }

        private void ilaADDRESS_RefreshLookupData(object pSender, ISRefreshLookupDataEventArgs e)
        {
            isSetAddressParameter(e.FilterString);
        }
        #endregion

        #region ----- Adapter Event : TAX_STANDARD ------
        
        private void idaTAX_STANDARD_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {
            if (iString.ISNull(e.Row["VAT_NUM"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10008"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["PRESIDENT_NAME"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10002"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["LEGAL_NUM"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10004"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
        }

        private void idaREPORT_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {
            if (iString.ISNull(e.Row["DPR_ASSET_ID"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10232"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
        }

        private void idaREPORT_PreDelete(ISPreDeleteEventArgs e)
        {       
            if (e.Row.RowState != DataRowState.Added)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10047"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            
        }

        #endregion

    }
}