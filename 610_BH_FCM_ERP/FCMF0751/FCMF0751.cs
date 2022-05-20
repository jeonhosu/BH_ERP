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

namespace FCMF0751
{
    public partial class FCMF0751 : Office2007Form
    {
        #region ----- Variables -----

        private ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();
        private ISFunction.ISConvert iString = new ISFunction.ISConvert();

        private bool mIsSearch = false;

        #endregion;

        #region ----- Constructor -----

        public FCMF0751()
        {
            InitializeComponent();
        }

        public FCMF0751(Form pMainForm, ISAppInterface pAppInterface)
        {
            InitializeComponent();
            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;
        }

        #endregion;

        #region ----- Private Methods ----

        private void SetCommonParameter(string pGroup_Code, string pEnabled_YN)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", pGroup_Code);
            ildCOMMON.SetLookupParamValue("W_ENABLED_YN", pEnabled_YN);
        }

        private void DBSearch()
        {
            object vObject1 = FS_SET_ID_0.EditValue;
            object vObject2 = PERIOD_FROM.EditValue;
            object vObject3 = PERIOD_TO.EditValue;
            if (iString.ISNull(vObject1) == string.Empty || iString.ISNull(vObject2) == string.Empty || iString.ISNull(vObject3) == string.Empty)
            {
                //재무제표양식세트와 기간을 선택하세요!  FCM_10319
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10319"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                FS_SET_NAME_0.Focus();
                return;
            }


            if (mIsSearch == true)
            {
                idaTRIAL_BALANCE.Fill();
            }
            else
            {
                //종료년월은 필수입니다.
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10219"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                PERIOD_TO.Focus();
                return;
            }
        }

        #endregion;


        #region ----- Assembly Run Methods ----

        private void AssmblyRun_Manual(object pAssembly_ID)
        {
            this.Cursor = Cursors.WaitCursor;
            Application.DoEvents();

            string vCurrAssemblyFileVersion = string.Empty;
            object vFS_TYPE_ID = t_FORM_TYPE_ID.EditValue;
            IDC_GET_FS_TYPE_NAME.SetCommandParamValue("W_COMMON_ID", vFS_TYPE_ID);
            IDC_GET_FS_TYPE_NAME.ExecuteNonQuery();
            object vFS_TYPE_NAME = IDC_GET_FS_TYPE_NAME.GetCommandParamValue("O_RETURN_VALUE");

            //[EAPP_ASSEMBLY_INFO_G.MENU_ENTRY_PROCESS_START]
            IDC_MENU_ENTRY_MANUAL_START.SetCommandParamValue("W_ASSEMBLY_ID", pAssembly_ID);
            IDC_MENU_ENTRY_MANUAL_START.ExecuteNonQuery();

            string vREAD_FLAG = iString.ISNull(IDC_MENU_ENTRY_MANUAL_START.GetCommandParamValue("O_READ_FLAG"));
            string vUSER_TYPE = iString.ISNull(IDC_MENU_ENTRY_MANUAL_START.GetCommandParamValue("O_USER_TYPE"));
            string vPRINT_FLAG = iString.ISNull(IDC_MENU_ENTRY_MANUAL_START.GetCommandParamValue("O_PRINT_FLAG"));

            decimal vASSEMBLY_INFO_ID = iString.ISDecimaltoZero(IDC_MENU_ENTRY_MANUAL_START.GetCommandParamValue("O_ASSEMBLY_INFO_ID"));
            string vASSEMBLY_ID = iString.ISNull(IDC_MENU_ENTRY_MANUAL_START.GetCommandParamValue("O_ASSEMBLY_ID"));
            string vASSEMBLY_NAME = iString.ISNull(IDC_MENU_ENTRY_MANUAL_START.GetCommandParamValue("O_ASSEMBLY_NAME"));
            string vASSEMBLY_FILE_NAME = iString.ISNull(IDC_MENU_ENTRY_MANUAL_START.GetCommandParamValue("O_ASSEMBLY_FILE_NAME"));

            string vASSEMBLY_VERSION = iString.ISNull(IDC_MENU_ENTRY_MANUAL_START.GetCommandParamValue("O_ASSEMBLY_VERSION"));
            string vDIR_FULL_PATH = iString.ISNull(IDC_MENU_ENTRY_MANUAL_START.GetCommandParamValue("O_DIR_FULL_PATH"));

            System.IO.FileInfo vFile = new System.IO.FileInfo(vASSEMBLY_FILE_NAME);
            if (vFile.Exists)
            {
                vCurrAssemblyFileVersion = System.Diagnostics.FileVersionInfo.GetVersionInfo(vASSEMBLY_FILE_NAME).FileVersion;
            }


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

                            object[] vParam = new object[10];
                            vParam[0] = this.MdiParent;
                            vParam[1] = isAppInterfaceAdv1.AppInterface;
                            vParam[2] = vFS_TYPE_NAME;
                            vParam[3] = vFS_TYPE_ID;
                            vParam[4] = FS_SET_NAME_0.EditValue;
                            vParam[5] = FS_SET_ID_0.EditValue;
                            vParam[6] = iString.ISNull(igrTRIAL_BALANCE.GetCellValue("ITEM_NAME")).Trim();
                            vParam[7] = igrTRIAL_BALANCE.GetCellValue("ITEM_CODE");
                            vParam[8] = iDate.ISMonth_1st(PERIOD_FROM.EditValue);
                            vParam[9] = iDate.ISMonth_Last(PERIOD_TO.EditValue);

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
                        if (iString.ISNull(vRow["REPORT_FILE_NAME"]) != string.Empty)
                        {
                            vReportFileName = iString.ISNull(vRow["REPORT_FILE_NAME"]);
                            vReportFileNameTarget = string.Format("_{0}", vReportFileName);
                        }
                        if (iString.ISNull(vRow["REPORT_PATH_FTP"]) != string.Empty)
                        {
                            vPathReportFTP = iString.ISNull(vRow["REPORT_PATH_FTP"]);
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


        #region ----- MDi Main ToolBar Button Event -----

        private void isAppInterfaceAdv1_AppMainButtonClick(ISAppButtonEvents e)
        {
            if (this.IsActive)
            {
                if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Search)
                {
                    DBSearch();
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
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Print)
                {
                    object vObject1 = FS_SET_ID_0.EditValue;
                    object vObject2 = PERIOD_FROM.EditValue;
                    object vObject3 = PERIOD_TO.EditValue;
                    if (iString.ISNull(vObject1) == string.Empty || iString.ISNull(vObject2) == string.Empty || iString.ISNull(vObject3) == string.Empty)
                    {
                        //재무제표양식세트와 기간을 선택하세요!  FCM_10319
                        MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10319"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                        FS_SET_NAME_0.Focus();
                        return;
                    }

                    int vCountRow = igrTRIAL_BALANCE.RowCount;
                    if (vCountRow < 1)
                    {
                        //출력할 자료가 없습니다.
                        MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10439"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                        return;
                    }

                    XLPrinting_1("PRINT", igrTRIAL_BALANCE);
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Export)
                {
                    object vObject1 = FS_SET_ID_0.EditValue;
                    object vObject2 = PERIOD_FROM.EditValue;
                    object vObject3 = PERIOD_TO.EditValue;
                    if (iString.ISNull(vObject1) == string.Empty || iString.ISNull(vObject2) == string.Empty || iString.ISNull(vObject3) == string.Empty)
                    {
                        //재무제표양식세트와 기간을 선택하세요!  FCM_10319
                        MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10319"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                        FS_SET_NAME_0.Focus();
                        return;
                    }

                    int vCountRow = igrTRIAL_BALANCE.RowCount;
                    if (vCountRow < 1)
                    {
                        //출력할 자료가 없습니다.
                        MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10439"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                        return;
                    }

                    XLPrinting_1("FILE", igrTRIAL_BALANCE);
                }
            }
        }

        #endregion;

        #region ----- Form Event -----

        private void FCMF0751_Load(object sender, EventArgs e)
        {
            int vYear = System.DateTime.Today.Year;
            System.DateTime vDate = new System.DateTime(vYear, 1, 1);
            PERIOD_FROM.EditValue = iDate.ISYearMonth(vDate);
            PERIOD_TO.EditValue = iDate.ISYearMonth(DateTime.Today);
        }

        private void FCMF0751_Shown(object sender, EventArgs e)
        {
            FS_SET_NAME_0.Focus();
        }
         
        private void igrTRIAL_BALANCE_CellDoubleClick(object pSender)
        {
            if (igrTRIAL_BALANCE.RowIndex < 0)
            {
                return;
            }

            if (iString.ISNull(igrTRIAL_BALANCE.GetCellValue("ITEM_CODE")) != string.Empty)
            {
                AssmblyRun_Manual("FCMF0295");
            }
        }

        #endregion

        #region ----- Lookup Event -----

        private void ilaFS_SET_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter("FS_SET", "Y");
        }

        #endregion

        #region ----- EditAdv Event -----

        private void PERIOD_TO_EditValueChanged(object pSender)
        {
            mIsSearch = false;
            object vObject = PERIOD_TO.EditValue;
            string vDate = iString.ISNull(vObject);
            int vLength = vDate.Length;

            string vYear = string.Empty;
            string vYearMonth = string.Empty;

            if (vLength == 7)
            {
                vYear = vDate.Substring(0, 4);
                vYearMonth = string.Format("{0}-01", vYear);

                PERIOD_FROM.EditValue = vYearMonth;

                mIsSearch = true;
            }
        }

        #endregion

        #region ----- XL Print 1 Method ----

        private void XLPrinting_1(string pOutChoice, InfoSummit.Win.ControlAdv.ISGridAdvEx p_grid_TRIAL_BALANCE)
        {
            string vMessageText = string.Empty;
            string vSaveFileName = string.Empty;

            int vCountRow = p_grid_TRIAL_BALANCE.RowCount;

            if (vCountRow < 1)
            {
                vMessageText = string.Format("Without Data");
                isAppInterfaceAdv1.OnAppMessage(vMessageText);
                System.Windows.Forms.Application.DoEvents();
                return;
            }

            idaPRINT_TITLE.Fill();

            System.Windows.Forms.Application.UseWaitCursor = true;
            this.Cursor = System.Windows.Forms.Cursors.WaitCursor;
            System.Windows.Forms.Application.DoEvents();

            int vPageNumber = 0;

            vMessageText = string.Format(" Printing Starting...");
            isAppInterfaceAdv1.OnAppMessage(vMessageText);
            System.Windows.Forms.Application.DoEvents();

            XLPrinting xlPrinting = new XLPrinting(isAppInterfaceAdv1.AppInterface, isMessageAdapter1);

            try
            {
                vMessageText = string.Format("XL Opening...");
                isAppInterfaceAdv1.OnAppMessage(vMessageText);
                System.Windows.Forms.Application.DoEvents();

                //-------------------------------------------------------------------------------------
                xlPrinting.OpenFileNameExcel = "FCMF0751_001.xls";
                //-------------------------------------------------------------------------------------

                //-------------------------------------------------------------------------------------
                bool isOpen = xlPrinting.XLFileOpen();
                //-------------------------------------------------------------------------------------

                //-------------------------------------------------------------------------------------
                if (isOpen == true)
                {
                    vPageNumber = xlPrinting.LineWrite(p_grid_TRIAL_BALANCE, idaPRINT_TITLE);

                    if (pOutChoice == "PRINT")
                    {
                        xlPrinting.Printing(1, vPageNumber);
                    }
                    else if (pOutChoice == "FILE")
                    {
                        xlPrinting.SAVE("TRIAL_");
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

    }
}