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

namespace POMF0723
{
    public partial class POMF0723 : Office2007Form
    {
        #region ----- Variables -----

        ISFunction.ISConvert iConv = new ISFunction.ISConvert();
        ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        #endregion;

        #region ----- Constructor -----

        public POMF0723(Form pMainForm, ISAppInterface pAppInterface)
        {
            InitializeComponent();
            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;
        }

        #endregion;

        #region ----- Private Methods ----

        private void GET_SLIP_INTERFACE()
        {
            IDC_DIST_SLIP_INTERFACE.ExecuteNonQuery();
            V_IF_SLIP_FLAG.CheckBoxValue = IDC_DIST_SLIP_INTERFACE.GetCommandParamValue("X_IF_SLIP_FLAG");
            V_SLIP_NUM.EditValue = IDC_DIST_SLIP_INTERFACE.GetCommandParamValue("X_IF_SLIP_NUM");
            V_SLIP_PERSON.EditValue = IDC_DIST_SLIP_INTERFACE.GetCommandParamValue("X_IF_SLIP_PERSON");
            V_IF_SLIP_HEADER_ID.EditValue = IDC_DIST_SLIP_INTERFACE.GetCommandParamValue("X_IF_SLIP_HEADER_ID");
            V_SLIP_DATE.EditValue = IDC_DIST_SLIP_INTERFACE.GetCommandParamValue("X_IF_SLIP_DATE");            
        }

        private void View_FCMF0206()
        { 
            object vSlip_Date;
            object vSlip_Num;

            Application.UseWaitCursor = true;
            System.Windows.Forms.Cursor.Current = Cursors.WaitCursor;
            Application.DoEvents();
 
            vSlip_Date = V_SLIP_DATE.EditValue;
            vSlip_Num = V_SLIP_NUM.EditValue;
            if (iConv.ISNull(vSlip_Num) == string.Empty)
            {
                return;
            }
            AssmblyRun_Manual("FCMF0206", vSlip_Date, vSlip_Date, vSlip_Num); 

            Application.UseWaitCursor = false;
            System.Windows.Forms.Cursor.Current = Cursors.Default;
            Application.DoEvents(); 
        }

        #endregion;


        #region ----- Territory Get Methods ----

        private int GetTerritory(ISUtil.Enum.TerritoryLanguage pTerritoryEnum)
        {
            int vTerritory = 0;

            switch (pTerritoryEnum)
            {
                case ISUtil.Enum.TerritoryLanguage.Default:
                    vTerritory = 1;
                    break;
                case ISUtil.Enum.TerritoryLanguage.TL1_KR:
                    vTerritory = 2;
                    break;
                case ISUtil.Enum.TerritoryLanguage.TL2_CN:
                    vTerritory = 3;
                    break;
                case ISUtil.Enum.TerritoryLanguage.TL3_VN:
                    vTerritory = 4;
                    break;
                case ISUtil.Enum.TerritoryLanguage.TL4_JP:
                    vTerritory = 5;
                    break;
                case ISUtil.Enum.TerritoryLanguage.TL5_XAA:
                    vTerritory = 6;
                    break;
            }

            return vTerritory;
        }

        private object Get_Edit_Prompt(InfoSummit.Win.ControlAdv.ISEditAdv pEdit)
        {
            int mIDX = 0;
            object mPrompt = null;
            switch (isAppInterfaceAdv1.AppInterface.OraConnectionInfo.TerritoryLanguage)
            {
                case ISUtil.Enum.TerritoryLanguage.Default:
                    mPrompt = pEdit.PromptTextElement[mIDX].Default;
                    break;
                case ISUtil.Enum.TerritoryLanguage.TL1_KR:
                    mPrompt = pEdit.PromptTextElement[mIDX].TL1_KR;
                    break;
                case ISUtil.Enum.TerritoryLanguage.TL2_CN:
                    mPrompt = pEdit.PromptTextElement[mIDX].TL2_CN;
                    break;
                case ISUtil.Enum.TerritoryLanguage.TL3_VN:
                    mPrompt = pEdit.PromptTextElement[mIDX].TL3_VN;
                    break;
                case ISUtil.Enum.TerritoryLanguage.TL4_JP:
                    mPrompt = pEdit.PromptTextElement[mIDX].TL4_JP;
                    break;
                case ISUtil.Enum.TerritoryLanguage.TL5_XAA:
                    mPrompt = pEdit.PromptTextElement[mIDX].TL5_XAA;
                    break;
            }
            return mPrompt;
        }

        #endregion;

        #region ----- Assembly Run Methods ----

        private void AssmblyRun_Manual(object pAssembly_ID, object pGL_Date_Fr, object pGL_Date_To, object pGL_Num)
        {
            this.Cursor = Cursors.WaitCursor;
            Application.DoEvents();

            string vCurrAssemblyFileVersion = string.Empty;

            //[EAPP_ASSEMBLY_INFO_G.MENU_ENTRY_PROCESS_START]
            IDC_MENU_ENTRY_MANUAL_START.SetCommandParamValue("W_ASSEMBLY_ID", pAssembly_ID);
            IDC_MENU_ENTRY_MANUAL_START.ExecuteNonQuery();
            
            string vREAD_FLAG = iConv.ISNull(IDC_MENU_ENTRY_MANUAL_START.GetCommandParamValue("O_READ_FLAG"));
            string vUSER_TYPE = iConv.ISNull(IDC_MENU_ENTRY_MANUAL_START.GetCommandParamValue("O_USER_TYPE"));
            string vPRINT_FLAG = iConv.ISNull(IDC_MENU_ENTRY_MANUAL_START.GetCommandParamValue("O_PRINT_FLAG"));

            decimal vASSEMBLY_INFO_ID = iConv.ISDecimaltoZero(IDC_MENU_ENTRY_MANUAL_START.GetCommandParamValue("O_ASSEMBLY_INFO_ID"));
            string vASSEMBLY_ID = iConv.ISNull(IDC_MENU_ENTRY_MANUAL_START.GetCommandParamValue("O_ASSEMBLY_ID"));
            string vASSEMBLY_NAME = iConv.ISNull(IDC_MENU_ENTRY_MANUAL_START.GetCommandParamValue("O_ASSEMBLY_NAME"));
            string vASSEMBLY_FILE_NAME = iConv.ISNull(IDC_MENU_ENTRY_MANUAL_START.GetCommandParamValue("O_ASSEMBLY_FILE_NAME"));

            string vASSEMBLY_VERSION = iConv.ISNull(IDC_MENU_ENTRY_MANUAL_START.GetCommandParamValue("O_ASSEMBLY_VERSION"));
            string vDIR_FULL_PATH = iConv.ISNull(IDC_MENU_ENTRY_MANUAL_START.GetCommandParamValue("O_DIR_FULL_PATH"));

            System.IO.FileInfo vFile = new System.IO.FileInfo(vASSEMBLY_FILE_NAME);
            if (vFile.Exists)
            {
                vCurrAssemblyFileVersion = System.Diagnostics.FileVersionInfo.GetVersionInfo(vASSEMBLY_FILE_NAME).FileVersion;
            }

            vREAD_FLAG = "Y";  //무조건 인쇄

            //1. Assembly file Name(.dll) 있을겨우만 실행//
            if (vASSEMBLY_FILE_NAME != string.Empty)
            {
                //2. 읽기 권한 있을 경우만 실행 //
                if (vREAD_FLAG == "Y")
                {
                    if (vCurrAssemblyFileVersion != vASSEMBLY_VERSION)
                    {
                        ISFileTransferAdv vFileTransferAdv = new ISFileTransferAdv();

                        vFileTransferAdv.Host = isAppInterfaceAdv1.AppInterface.AppHostInfo.Host;
                        vFileTransferAdv.Port = isAppInterfaceAdv1.AppInterface.AppHostInfo.Port;
                        vFileTransferAdv.UserId = isAppInterfaceAdv1.AppInterface.AppHostInfo.UserId;
                        vFileTransferAdv.Password = isAppInterfaceAdv1.AppInterface.AppHostInfo.Password;
                        if (isAppInterfaceAdv1.AppInterface.AppHostInfo.Passive == "Y")
                        {
                            vFileTransferAdv.UsePassive = true;
                        }
                        else
                        {
                            vFileTransferAdv.UsePassive = false;
                        }

                        vFileTransferAdv.SourceDirectory = vDIR_FULL_PATH;
                        vFileTransferAdv.SourceFileName = vASSEMBLY_FILE_NAME;
                        vFileTransferAdv.TargetDirectory = Application.StartupPath;
                        vFileTransferAdv.TargetFileName = "_" + vASSEMBLY_FILE_NAME;

                        if (vFileTransferAdv.Download() == true)
                        {
                            try
                            {
                                System.IO.File.Delete(vASSEMBLY_FILE_NAME);
                                System.IO.File.Move("_" + vASSEMBLY_FILE_NAME, vASSEMBLY_FILE_NAME);
                            }
                            catch
                            {
                                try
                                {
                                    System.IO.FileInfo vFileInfo = new System.IO.FileInfo("_" + vASSEMBLY_FILE_NAME);
                                    if (vFileInfo.Exists == true)
                                    {
                                        try
                                        {
                                            System.IO.File.Delete("_" + vASSEMBLY_FILE_NAME);
                                        }
                                        catch
                                        {
                                            // ignore
                                        }
                                    }
                                }
                                catch
                                {
                                    //ignore
                                }
                            }
                        }

                        //report update//
                        ReportUpdate(vASSEMBLY_INFO_ID);
                    }

                    try
                    {
                        System.Reflection.Assembly vAssembly = System.Reflection.Assembly.LoadFrom(vASSEMBLY_FILE_NAME);
                        Type vType = vAssembly.GetType(vAssembly.GetName().Name + "." + vAssembly.GetName().Name);

                        if (vType != null)
                        {
                            if (vFile.Exists)
                            {
                                vCurrAssemblyFileVersion = System.Diagnostics.FileVersionInfo.GetVersionInfo(vASSEMBLY_FILE_NAME).FileVersion;
                            }

                            object[] vParam = new object[5];
                            vParam[0] = this.MdiParent;
                            vParam[1] = isAppInterfaceAdv1.AppInterface;
                            vParam[2] = pGL_Date_Fr;     //전표일자
                            vParam[3] = pGL_Date_To;     //전표일자
                            vParam[4] = pGL_Num;      //전표번호 

                            object vCreateInstance = Activator.CreateInstance(vType, vParam);
                            Office2007Form vForm = vCreateInstance as Office2007Form;
                            Point vPoint = new Point(30, 30);
                            vForm.Location = vPoint;
                            vForm.StartPosition = FormStartPosition.Manual;
                            vForm.Text = string.Format("{0}[{1}] - {2}", vASSEMBLY_NAME, vASSEMBLY_ID, vCurrAssemblyFileVersion);

                            vForm.Show();
                        }
                        else
                        {
                            MessageBoxAdv.Show("Form Namespace Error");
                        }
                    }
                    catch
                    {
                        //
                    }
                }
            }

            this.Cursor = Cursors.Default;
            Application.DoEvents();
        }

        //report download//
        private void ReportUpdate(object pAssemblyInfoID)
        {
            string vPathReportFTP = string.Empty;
            string vReportFileName = string.Empty;
            string vReportFileNameTarget = string.Empty;

            try
            {
                IDA_REPORT_INFO_DOWNLOAD.SetSelectParamValue("W_ASSEMBLY_INFO_ID", pAssemblyInfoID);
                IDA_REPORT_INFO_DOWNLOAD.Fill();
                if (IDA_REPORT_INFO_DOWNLOAD.OraSelectData.Rows.Count > 0)
                {
                    ISFileTransferAdv vFileTransferAdv = new ISFileTransferAdv();

                    vFileTransferAdv.Host = isAppInterfaceAdv1.AppInterface.AppHostInfo.Host;
                    vFileTransferAdv.Port = isAppInterfaceAdv1.AppInterface.AppHostInfo.Port;
                    if (isAppInterfaceAdv1.AppInterface.AppHostInfo.Passive == "Y")
                    {
                        vFileTransferAdv.UsePassive = true;
                    }
                    else
                    {
                        vFileTransferAdv.UsePassive = false;
                    }
                    vFileTransferAdv.UserId = isAppInterfaceAdv1.AppInterface.AppHostInfo.UserId;
                    vFileTransferAdv.Password = isAppInterfaceAdv1.AppInterface.AppHostInfo.Password;

                    foreach (System.Data.DataRow vRow in IDA_REPORT_INFO_DOWNLOAD.OraSelectData.Rows)
                    {
                        if (iConv.ISNull(vRow["REPORT_FILE_NAME"]) != string.Empty)
                        {
                            vReportFileName = iConv.ISNull(vRow["REPORT_FILE_NAME"]);
                            vReportFileNameTarget = string.Format("_{0}", vReportFileName);
                        }
                        if (iConv.ISNull(vRow["REPORT_PATH_FTP"]) != string.Empty)
                        {
                            vPathReportFTP = iConv.ISNull(vRow["REPORT_PATH_FTP"]);
                        }

                        if (vReportFileName != string.Empty && vPathReportFTP != string.Empty)
                        {
                            string vPathReportClient = string.Format("{0}\\{1}", System.Windows.Forms.Application.StartupPath, "Report");
                            System.IO.DirectoryInfo vReport = new System.IO.DirectoryInfo(vPathReportClient);
                            if (vReport.Exists == false) //있으면 True, 없으면 False
                            {
                                vReport.Create();
                            }
                            ////------------------------------------------------------------------------
                            ////[Test Path]
                            ////------------------------------------------------------------------------
                            //string vPathTest = @"K:\00_2_FXE\ERPMain\FXEMain\bin\Debug";
                            //string vPathReportClient = string.Format("{0}\\{1}", vPathTest, "Report");
                            ////------------------------------------------------------------------------

                            vFileTransferAdv.SourceDirectory = vPathReportFTP;
                            vFileTransferAdv.SourceFileName = vReportFileName;
                            vFileTransferAdv.TargetDirectory = vPathReportClient;
                            vFileTransferAdv.TargetFileName = vReportFileNameTarget;

                            string vFullPathReportClient = string.Format("{0}\\{1}", vPathReportClient, vReportFileName);
                            string vFullPathReportTarget = string.Format("{0}\\{1}", vPathReportClient, vReportFileNameTarget);

                            if (vFileTransferAdv.Download() == true)
                            {
                                try
                                {
                                    System.IO.File.Delete(vFullPathReportClient);
                                    System.IO.File.Move(vFullPathReportTarget, vFullPathReportClient);
                                }
                                catch
                                {
                                    try
                                    {
                                        System.IO.FileInfo vFileInfo = new System.IO.FileInfo(vFullPathReportTarget);
                                        if (vFileInfo.Exists == true)
                                        {
                                            System.IO.File.Delete(vFullPathReportTarget);
                                        }
                                    }
                                    catch
                                    {
                                        //
                                    }
                                }
                            }
                        }
                    }
                }
            }
            catch (System.Exception ex)
            {
                string vMessage = ex.Message;
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
                    IDA_DIST_RESULT.Fill();

                    //전표 전송정보//
                    GET_SLIP_INTERFACE();
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddOver)
                {

                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddUnder)
                {

                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Update)
                {

                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Cancel)
                {

                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {

                }
            }
        }

        #endregion;

        #region ----- Form event -----

        private void POMF0723_Load(object sender, EventArgs e)
        {
            IDA_DIST_RESULT.FillSchema();
        }

        // PERIOD LOOKUP 선택시 동작 //
        private void ILA_PERIOD_SelectedRowData(object pSender)
        {
            IDC_PERIOD_STATUS.ExecuteNonQuery();
            IDA_DIST_RESULT.Fill();
            IDA_ERROR_LINE.Fill();

            //전표 전송정보//
            GET_SLIP_INTERFACE();
        }

        // 수불생성 버튼 //
        private void ISB_CREATE_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            H_ADJ_CLOSE_RESULT.EditValue = Convert.ToString("PROCESSING");
            Application.DoEvents();

            string vSTATUS = "F";
            string vMESSAGE = null;
            IDC_CREATE.ExecuteNonQuery();
            vSTATUS = iConv.ISNull(IDC_CREATE.GetCommandParamValue("X_RESULT_STATUS"));
            vMESSAGE = iConv.ISNull(IDC_CREATE.GetCommandParamValue("X_RESULT_MSG"));
            if (IDC_CREATE.ExcuteError || vSTATUS == "F")
            {
                if (vMESSAGE != string.Empty)
                {
                    MessageBoxAdv.Show(vMESSAGE, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
                H_ADJ_CLOSE_RESULT.EditValue = Convert.ToString("");
                Application.DoEvents();
                return;
            }

            IDC_PERIOD_STATUS.ExecuteNonQuery();
            IDA_DIST_RESULT.Fill();
            IDA_ERROR_LINE.Fill();

            //전표 전송정보//
            GET_SLIP_INTERFACE();
        }

        // 수불마감 버튼 //
        private void ISB_CLOSE_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            string vSTATUS = "F";
            string vMESSAGE = null;
            IDC_ADJ_CLOSE.ExecuteNonQuery();
            vSTATUS = iConv.ISNull(IDC_ADJ_CLOSE.GetCommandParamValue("X_RESULT_STATUS"));
            vMESSAGE = iConv.ISNull(IDC_ADJ_CLOSE.GetCommandParamValue("X_RESULT_MSG"));
            if (IDC_ADJ_CLOSE.ExcuteError || vSTATUS == "F")
            {
                if (vMESSAGE != string.Empty)
                {
                    MessageBoxAdv.Show(vMESSAGE, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
                return;
            }

            IDC_PERIOD_STATUS.ExecuteNonQuery();
        }

        // 마감취소 버튼 //
        private void ISB_CANCEL_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            string vSTATUS = "F";
            string vMESSAGE = null;
            IDC_ADJ_CLOSE_CANCEL.ExecuteNonQuery();
            vSTATUS = iConv.ISNull(IDC_ADJ_CLOSE_CANCEL.GetCommandParamValue("X_RESULT_STATUS"));
            vMESSAGE = iConv.ISNull(IDC_ADJ_CLOSE_CANCEL.GetCommandParamValue("X_RESULT_MSG"));
            if (IDC_ADJ_CLOSE_CANCEL.ExcuteError || vSTATUS == "F")
            {
                if (vMESSAGE != string.Empty)
                {
                    MessageBoxAdv.Show(vMESSAGE, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
                return;
            }

            IDC_PERIOD_STATUS.ExecuteNonQuery();
        }

        private void ISB_DELETE_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            string vSTATUS = "F";
            string vMESSAGE = null;
            IDC_DELETE.ExecuteNonQuery();
            vSTATUS = iConv.ISNull(IDC_DELETE.GetCommandParamValue("X_RESULT_STATUS"));
            vMESSAGE = iConv.ISNull(IDC_DELETE.GetCommandParamValue("X_RESULT_MSG"));
            if (IDC_DELETE.ExcuteError || vSTATUS == "F")
            {
                if (vMESSAGE != string.Empty)
                {
                    MessageBoxAdv.Show(vMESSAGE, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
                return;
            }

            IDC_PERIOD_STATUS.ExecuteNonQuery();
            IDA_DIST_RESULT.Fill();
            IDA_ERROR_LINE.Fill();
        }


        private void ISB_SET_SLIP_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            if (MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10303"), "Question", MessageBoxButtons.YesNo, MessageBoxIcon.Question) == DialogResult.No)
            {
                return;
            }

            if (iConv.ISNull(V_PERIOD_NAME.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10442"), "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                V_PERIOD_NAME.Focus();
                return;
            }

            Application.UseWaitCursor = true;
            this.Cursor = System.Windows.Forms.Cursors.WaitCursor;
            Application.DoEvents();
             
            string vSTATUS = "F";
            string vMESSAGE = null;
              
            //전표 발생
            vSTATUS = "F";
            vMESSAGE = null;
            IDC_SET_PO_CHARGE_DIST_SLIP.ExecuteNonQuery();
            vSTATUS = iConv.ISNull(IDC_SET_PO_CHARGE_DIST_SLIP.GetCommandParamValue("O_STATUS"));
            vMESSAGE = iConv.ISNull(IDC_SET_PO_CHARGE_DIST_SLIP.GetCommandParamValue("O_MESSAGE"));
            if (IDC_SET_PO_CHARGE_DIST_SLIP.ExcuteError || vSTATUS == "F")
            { 
                //이메일 전송상태 변경 - 오류 때문에 강제 변경.
                Application.UseWaitCursor = false;
                this.Cursor = System.Windows.Forms.Cursors.Default;
                Application.DoEvents();
                if (vMESSAGE != string.Empty)
                {
                    MessageBoxAdv.Show(vMESSAGE, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
                return;
            }

            //전표 전송정보//
            GET_SLIP_INTERFACE();
            
            Application.UseWaitCursor = false;
            this.Cursor = System.Windows.Forms.Cursors.Default;
            Application.DoEvents();

            MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10334"), "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);
        }

        private void ISB_CANCEL_SLIP_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            if (MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10333"), "Question", MessageBoxButtons.YesNo, MessageBoxIcon.Question) == DialogResult.No)
            {
                return;
            }

            if (iConv.ISNull(V_PERIOD_NAME.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10442"), "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                V_PERIOD_NAME.Focus();
                return;
            }

            Application.UseWaitCursor = true;
            this.Cursor = System.Windows.Forms.Cursors.WaitCursor;
            Application.DoEvents();

            string vSTATUS = "F";
            string vMESSAGE = null;
            
            //전표 취소
            vSTATUS = "F";
            vMESSAGE = null;
            IDC_CANCEL_PO_CHARGE_DIST_SLIP.ExecuteNonQuery();
            vSTATUS = iConv.ISNull(IDC_CANCEL_PO_CHARGE_DIST_SLIP.GetCommandParamValue("O_STATUS"));
            vMESSAGE = iConv.ISNull(IDC_CANCEL_PO_CHARGE_DIST_SLIP.GetCommandParamValue("O_MESSAGE"));
            if (IDC_CANCEL_PO_CHARGE_DIST_SLIP.ExcuteError || vSTATUS == "F")
            {
                //이메일 전송상태 변경 - 오류 때문에 강제 변경.
                Application.UseWaitCursor = false;
                this.Cursor = System.Windows.Forms.Cursors.Default;
                Application.DoEvents();
                if (vMESSAGE != string.Empty)
                {
                    MessageBoxAdv.Show(vMESSAGE, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
                return;
            }

            //전표 전송정보//
            GET_SLIP_INTERFACE();

            Application.UseWaitCursor = false;
            this.Cursor = System.Windows.Forms.Cursors.Default;
            Application.DoEvents();

            MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10336"), "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);
        }


        private void BTN_VIEW_SLIP_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            View_FCMF0206();
        }

        #endregion

        #region ----- Lookup Event -----

        private void ILA_PERIOD_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ILD_PERIOD.SetLookupParamValue("W_CLOSE_TYPE", Convert.ToString("PO_CHARGE"));
        }

        #endregion



    }
}