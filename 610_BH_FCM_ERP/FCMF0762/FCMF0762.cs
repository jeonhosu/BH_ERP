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

namespace FCMF0762
{
    public partial class FCMF0762 : Office2007Form
    {
        #region ----- Variables -----

        private ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();
        private ISFunction.ISConvert iString = new ISFunction.ISConvert();

        private string[,] mQuarter;
        private string[,] mMonth;
        private string[,] mHalf;

        #endregion;

        #region ----- Constructor -----

        public FCMF0762()
        {
            InitializeComponent();
        }

        public FCMF0762(Form pMainForm, ISAppInterface pAppInterface)
        {
            InitializeComponent();
            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;
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
                System.Windows.Forms.Application.DoEvents();
            }

            return vConvertDecimal;
        }

        private decimal ConvertNumber(string pStringNumber)
        {
            decimal vConvertDecimal = 0m;

            try
            {
                bool isNull = string.IsNullOrEmpty(pStringNumber);
                if (isNull != true)
                {
                    vConvertDecimal = decimal.Parse(pStringNumber);
                }

            }
            catch (System.Exception ex)
            {
                isAppInterfaceAdv1.OnAppMessage(ex.Message);
                System.Windows.Forms.Application.DoEvents();
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

        #region ----- Private Methods ----

        private void SetCommonParameter(string pGroup_Code, string pEnabled_YN)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", pGroup_Code);
            ildCOMMON.SetLookupParamValue("W_ENABLED_YN", pEnabled_YN);
        }

        //월 조회 조건 - 결산월 가져오기
        private void GetValue_MONTH()
        {
            idaMONTH.SetSelectParamValue("W_GROUP_CODE", "MONTH");
            idaMONTH.SetSelectParamValue("W_ENABLED_YN", "Y");
            idaMONTH.Fill();

            object vObject_NAME = null;
            object vObject_CODE = null;
            int vCountArray = idaMONTH.OraSelectData.Rows.Count;
            mMonth = new string[vCountArray, 2];

            for (int vRow = 0; vRow < vCountArray; vRow++)
            {
                vObject_NAME = idaMONTH.OraSelectData.Rows[vRow]["CODE_NAME"];
                vObject_CODE = idaMONTH.OraSelectData.Rows[vRow]["CODE"];
                mMonth[vRow, 0] = iString.ISNull(vObject_NAME);
                mMonth[vRow, 1] = iString.ISNull(vObject_CODE);
            }
        }

        //월 조회 조건 - 결산월 기본값 설정
        private void Default_MONTH()
        {
            int vMonth = System.DateTime.Today.Month;
            int vIndexArray = vMonth - 1;

            MONTH_FR_NAME.EditValue = mMonth[0, 0];
            MONTH_FR_CODE.EditValue = mMonth[0, 1];

            MONTH_TO_NAME.EditValue = mMonth[vIndexArray, 0];
            MONTH_TO_CODE.EditValue = mMonth[vIndexArray, 1];
        }

        //월 조회 조건 - 그리드 헤더 결산월 변경
        private void SetGridMONTH()
        {
            string vMonthString = iString.ISNull(MONTH_FR_CODE.EditValue);
            vMonthString = vMonthString.Substring(1, 2);
            int vMonth = int.Parse(vMonthString);

            int vIndexArrayCurrent = vMonth - 1;
            int vIndexArrayBefore = 0;

            string vMonthCurrent = mMonth[vIndexArrayCurrent, 0];
            string vMonthBefore = string.Empty;

            if (vMonth == 1)
            {
                vMonthBefore = mMonth[11, 0];
            }
            else
            {
                vIndexArrayBefore = vIndexArrayCurrent - 1;
                vMonthBefore = mMonth[vIndexArrayBefore, 0];
            }

            igrFACTORY_COST_MONTH.GridAdvExColElement[1].HeaderElement[1].TL1_KR = vMonthCurrent;
            igrFACTORY_COST_MONTH.GridAdvExColElement[3].HeaderElement[1].TL1_KR = vMonthBefore;

            igrFACTORY_COST_MONTH.ResetDraw = true;
        }

        //분기 조회 조건 - 결산분기 가져오기
        private void GetValue_QUARTER()
        {
            idaQUARTER.SetSelectParamValue("W_GROUP_CODE", "QUARTER");
            idaQUARTER.SetSelectParamValue("W_ENABLED_YN", "Y");
            idaQUARTER.Fill();

            object vObject_NAME = null;
            object vObject_CODE = null;
            int vCountArray = idaQUARTER.OraSelectData.Rows.Count;
            mQuarter = new string[vCountArray, 2];

            for (int vRow = 0; vRow < vCountArray; vRow++)
            {
                vObject_NAME = idaQUARTER.OraSelectData.Rows[vRow]["CODE_NAME"];
                vObject_CODE = idaQUARTER.OraSelectData.Rows[vRow]["CODE"];
                mQuarter[vRow, 0] = iString.ISNull(vObject_NAME);
                mQuarter[vRow, 1] = iString.ISNull(vObject_CODE);
            }
        }

        //분기 조회 조건 - 결산분기 기본값 설정
        private void Default_QUARTER()
        {
            int vMonth = System.DateTime.Today.Month;

            QUARTER_FR_NAME.EditValue = mQuarter[0, 0];
            QUARTER_FR_CODE.EditValue = mQuarter[0, 1];

            if (vMonth == 1 || vMonth == 2 || vMonth == 3)
            {
                QUARTER_TO_NAME.EditValue = mQuarter[0, 0];
                QUARTER_TO_CODE.EditValue = mQuarter[0, 1];
            }
            else if (vMonth == 4 || vMonth == 5 || vMonth == 6)
            {
                QUARTER_TO_NAME.EditValue = mQuarter[1, 0];
                QUARTER_TO_CODE.EditValue = mQuarter[1, 1];
            }
            else if (vMonth == 7 || vMonth == 8 || vMonth == 9)
            {
                QUARTER_TO_NAME.EditValue = mQuarter[2, 0];
                QUARTER_TO_CODE.EditValue = mQuarter[2, 1];
            }
            else if (vMonth == 10 || vMonth == 11 || vMonth == 12)
            {
                QUARTER_TO_NAME.EditValue = mQuarter[3, 0];
                QUARTER_TO_CODE.EditValue = mQuarter[3, 1];
            }
        }

        //분기 조회 조건 - 그리드 헤더 결산분기 변경
        private void SetGridQUARTER()
        {
            object vObject_NAME_Current = QUARTER_FR_NAME.EditValue;
            object vObject_CODE_Current = QUARTER_FR_CODE.EditValue;


            string vCODE_Current = iString.ISNull(vObject_CODE_Current);
            string vNAME_Before = string.Empty;

            if (vCODE_Current == mQuarter[0, 1])
            {
                vNAME_Before = mQuarter[3, 0];
            }
            else if (vCODE_Current == mQuarter[1, 1])
            {
                vNAME_Before = mQuarter[0, 0];
            }
            else if (vCODE_Current == mQuarter[2, 1])
            {
                vNAME_Before = mQuarter[1, 0];
            }
            else if (vCODE_Current == mQuarter[3, 1])
            {
                vNAME_Before = mQuarter[2, 0];
            }

            igrFACTORY_COST_QUARTER.GridAdvExColElement[1].HeaderElement[1].TL1_KR = iString.ISNull(vObject_NAME_Current);
            igrFACTORY_COST_QUARTER.GridAdvExColElement[3].HeaderElement[1].TL1_KR = vNAME_Before;

            igrFACTORY_COST_QUARTER.ResetDraw = true;
        }

        //번기 조회 조건 - 결산반기 가져오기
        private void GetValue_HALF()
        {
            idaHALF.SetSelectParamValue("W_GROUP_CODE", "HALF_YEARLY");
            idaHALF.SetSelectParamValue("W_ENABLED_YN", "Y");
            idaHALF.Fill();

            object vObject_NAME = null;
            object vObject_CODE = null;
            int vCountArray = idaHALF.OraSelectData.Rows.Count;
            mHalf = new string[vCountArray, 2];

            for (int vRow = 0; vRow < vCountArray; vRow++)
            {
                vObject_NAME = idaHALF.OraSelectData.Rows[vRow]["CODE_NAME"];
                vObject_CODE = idaHALF.OraSelectData.Rows[vRow]["CODE"];
                mHalf[vRow, 0] = iString.ISNull(vObject_NAME);
                mHalf[vRow, 1] = iString.ISNull(vObject_CODE);
            }
        }

        //반기 조회 조건 - 결산반기 기본값 설정
        private void Default_HALF()
        {
            int vMonth = System.DateTime.Today.Month;
            int vIndexArray = vMonth - 1;

            HALF_FR_NAME.EditValue = mHalf[0, 0];
            HALF_FR_CODE.EditValue = mHalf[0, 1];

            if (vMonth > 0 && vMonth < 7)
            {
                HALF_TO_NAME.EditValue = mHalf[0, 0];
                HALF_TO_CODE.EditValue = mHalf[0, 1];
            }
            else
            {
                HALF_TO_NAME.EditValue = mHalf[1, 0];
                HALF_TO_CODE.EditValue = mHalf[1, 1];
            }
        }

        //반기 조회 조건 - 그리드 헤더 결산반기 변경
        private void SetGridHALF()
        {
            string vHalfString = iString.ISNull(HALF_FR_CODE.EditValue);
            vHalfString = vHalfString.Substring(1, 2);
            int vHalf = int.Parse(vHalfString);

            string vHalfCurrent = string.Empty;
            string vHalfBefore = string.Empty;

            if (vHalf == 1)
            {
                vHalfCurrent = mHalf[0, 0];
                vHalfBefore = mHalf[1, 0];
            }
            else
            {
                vHalfCurrent = mHalf[1, 0];
                vHalfBefore = mHalf[0, 0];
            }

            igrFACTORY_COST_HALF.GridAdvExColElement[1].HeaderElement[1].TL1_KR = vHalfCurrent;
            igrFACTORY_COST_HALF.GridAdvExColElement[3].HeaderElement[1].TL1_KR = vHalfBefore;

            igrFACTORY_COST_HALF.ResetDraw = true;
        }

        //년 조회 조건 - 그리드 헤더 해당년도기수 변경
        private void get_FISCAL_COUNT(string pYear)
        {
            idcFISCAL_COUNT.SetCommandParamValue("W_FISCAL_YEAR", pYear);
            idcFISCAL_COUNT.ExecuteNonQuery();
            object vObject_FISCAL_COUNT = idcFISCAL_COUNT.GetCommandParamValue("O_FISCAL_COUNT");

            decimal vFiscalCountCurrent = ConvertNumber(vObject_FISCAL_COUNT);
            decimal vFiscalCountAfter = vFiscalCountCurrent - 1;

            string vFiscalCurrent = string.Format("제{0}(당)기", vFiscalCountCurrent);
            string vFiscalBefore = string.Format("제{0}(전)기", vFiscalCountAfter);

            igrFACTORY_COST_YEAR.GridAdvExColElement[4].HeaderElement[0].TL1_KR = vFiscalCurrent;
            igrFACTORY_COST_YEAR.GridAdvExColElement[6].HeaderElement[0].TL1_KR = vFiscalBefore;

            igrFACTORY_COST_YEAR.ResetDraw = true;
        }

        #endregion;

        #region ----- Search Methods ----

        //월 조회
        private void DBSearch_0()
        {
            object vObject1 = FS_SET_ID_0.EditValue;
            object vObject2 = PERIOD_YEAR_0.EditValue;
            object vObject3 = MONTH_FR_NAME.EditValue;
            object vObject4 = MONTH_TO_NAME.EditValue;
            if (iString.ISNull(vObject1) == string.Empty || iString.ISNull(vObject2) == string.Empty || iString.ISNull(vObject3) == string.Empty || iString.ISNull(vObject4) == string.Empty)
            {
                //재무제표양식세트, 결산년도, 결산월을 선택하세요!
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10338"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                FS_SET_NAME_0.Focus();
                return;
            }


            vObject3 = MONTH_FR_CODE.EditValue;
            vObject4 = MONTH_TO_CODE.EditValue;
            string vMonthFrString = iString.ISNull(vObject3);
            string vMonthToString = iString.ISNull(vObject4);
            decimal vMonthFrDecimal = ConvertNumber(vMonthFrString.Substring(1, 2));
            decimal vMonthToDecimal = ConvertNumber(vMonthToString.Substring(1, 2));
            if (vMonthFrDecimal > vMonthToDecimal)
            {
                //종료기간은 시작기간 보다 커야 합니다.
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10345"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                FS_SET_NAME_0.Focus();
                return;
            }

            //SetGridMONTH();

            idaFS_FACTORY_COST_MONTH.SetSelectParamValue("W_DATA_GB", "M");
            idaFS_FACTORY_COST_MONTH.Fill();
        }

        //분기 조회
        private void DBSearch_1()
        {
            object vObject1 = FS_SET_ID_1.EditValue;
            object vObject2 = PERIOD_YEAR_1.EditValue;
            object vObject3 = QUARTER_FR_NAME.EditValue;
            object vObject4 = QUARTER_TO_NAME.EditValue;
            if (iString.ISNull(vObject1) == string.Empty || iString.ISNull(vObject2) == string.Empty || iString.ISNull(vObject3) == string.Empty || iString.ISNull(vObject4) == string.Empty)
            {
                //재무제표양식세트, 결산년도, 결산분기를 선택하세요!
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10308"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                FS_SET_NAME_1.Focus();
                return;
            }

            //SetGridQUARTER();

            idaFACTORY_COST_QUARTER.SetSelectParamValue("W_DATA_GB", "Q");
            idaFACTORY_COST_QUARTER.Fill();
        }

        //반기 조회
        private void DBSearch_2()
        {
            object vObject1 = FS_SET_ID_2.EditValue;
            object vObject2 = PERIOD_YEAR_2.EditValue;
            object vObject3 = HALF_FR_NAME.EditValue;
            object vObject4 = HALF_TO_NAME.EditValue;
            if (iString.ISNull(vObject1) == string.Empty || iString.ISNull(vObject2) == string.Empty || iString.ISNull(vObject3) == string.Empty || iString.ISNull(vObject4) == string.Empty)
            {
                //재무제표양식세트, 결산년도, 결산반기를 선택하세요!
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10339"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                FS_SET_NAME_2.Focus();
                return;
            }

            //SetGridHALF();

            idaFS_FACTORY_COST_HALF.SetSelectParamValue("W_DATA_GB", "H");
            idaFS_FACTORY_COST_HALF.Fill();
        }

        //년 조회
        private void DBSearch_3()
        {
            object vObject1 = FS_SET_ID_3.EditValue;
            object vObject2 = PERIOD_FROM.EditValue;
            object vObject3 = PERIOD_TO.EditValue;
            if (iString.ISNull(vObject1) == string.Empty || iString.ISNull(vObject2) == string.Empty || iString.ISNull(vObject3) == string.Empty)
            {
                //재무제표양식세트와 기간을 선택하세요!  FCM_10319
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10319"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                FS_SET_ID_3.Focus();
                return;
            }

            object vObject = PERIOD_TO.EditValue;
            string vDate = ConvertString(vObject);

            string vYear = vDate.Substring(0, 4);

            get_FISCAL_COUNT(vYear);

            idaFS_FACTORY_COST_YEAR.SetSelectParamValue("W_CLOSING_YEAR", vYear);
            idaFS_FACTORY_COST_YEAR.SetSelectParamValue("W_DATA_GB", "Y");
            idaFS_FACTORY_COST_YEAR.Fill();
        }

        #endregion;

        #region ----- Assembly Run Methods ----

        private void AssmblyRun_Manual(object pAssembly_ID, DateTime pPERIOD_DATE_FR, DateTime pPERIOD_DATE_TO, 
                                        object pITEM_CODE, object pITEM_NAME)
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
                            vParam[6] = iString.ISNull(pITEM_NAME).Trim();
                            vParam[7] = pITEM_CODE;
                            vParam[8] = pPERIOD_DATE_FR;
                            vParam[9] = pPERIOD_DATE_TO;

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
                    int vIndexTAB = isTAB.SelectedIndex;
                    if (vIndexTAB == 0)
                    {
                        DBSearch_0();
                    }
                    else if (vIndexTAB == 1)
                    {
                        DBSearch_1();
                    }
                    else if (vIndexTAB == 2)
                    {
                        DBSearch_2();
                    }
                    else if (vIndexTAB == 3)
                    {
                        DBSearch_3();
                    }
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
                    int vIndexTAB = isTAB.SelectedIndex;
                    if (vIndexTAB == 3)
                    {
                        object vObject1 = FS_SET_ID_3.EditValue;
                        object vObject2 = PERIOD_FROM.EditValue;
                        object vObject3 = PERIOD_TO.EditValue;
                        if (iString.ISNull(vObject1) == string.Empty || iString.ISNull(vObject2) == string.Empty || iString.ISNull(vObject3) == string.Empty)
                        {
                            //재무제표양식세트와 기간을 선택하세요!  FCM_10319
                            MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10319"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                            FS_SET_ID_3.Focus();
                            return;
                        }

                        int vCountRow = igrFACTORY_COST_YEAR.RowCount;
                        if (vCountRow < 1)
                        {
                            //출력할 자료가 없습니다.
                            MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10439"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                            return;
                        }

                        XLPrinting_1("PRINT", igrFACTORY_COST_YEAR);
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Export)
                {
                    int vIndexTAB = isTAB.SelectedIndex;
                    if (vIndexTAB == 3)
                    {
                        object vObject1 = FS_SET_ID_3.EditValue;
                        object vObject2 = PERIOD_FROM.EditValue;
                        object vObject3 = PERIOD_TO.EditValue;
                        if (iString.ISNull(vObject1) == string.Empty || iString.ISNull(vObject2) == string.Empty || iString.ISNull(vObject3) == string.Empty)
                        {
                            //재무제표양식세트와 기간을 선택하세요!  FCM_10319
                            MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10319"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                            FS_SET_ID_3.Focus();
                            return;
                        }

                        int vCountRow = igrFACTORY_COST_YEAR.RowCount;
                        if (vCountRow < 1)
                        {
                            //출력할 자료가 없습니다.
                            MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10439"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                            return;
                        }

                        XLPrinting_1("FILE", igrFACTORY_COST_YEAR);
                    }
                }
            }
        }

        #endregion;

        #region ----- Form Event -----

        private void FCMF0762_Load(object sender, EventArgs e)
        {
            PERIOD_YEAR_0.EditValue = iDate.ISYear(System.DateTime.Today);
            PERIOD_YEAR_1.EditValue = iDate.ISYear(System.DateTime.Today);
            PERIOD_YEAR_2.EditValue = iDate.ISYear(System.DateTime.Today);

            int vYear = System.DateTime.Today.Year;
            System.DateTime vDate = new System.DateTime(vYear, 1, 1);
            PERIOD_FROM.EditValue = iDate.ISYearMonth(vDate);
            PERIOD_TO.EditValue = iDate.ISYearMonth(DateTime.Today);

            GetValue_MONTH();
            GetValue_QUARTER();
            GetValue_HALF();
        }

        private void FCMF0762_Shown(object sender, EventArgs e)
        {
            Default_QUARTER();
            //SetGridQUARTER();

            Default_MONTH();
            //SetGridMONTH();

            Default_HALF();
            //SetGridHALF();


            FS_SET_NAME_0.Focus();
        }

        private void igrFACTORY_COST_MONTH_CellDoubleClick(object pSender)
        {
            //월
            if (igrFACTORY_COST_MONTH.RowIndex < 0)
            {
                return;
            }

            DateTime vPERIOD_DATE_FR = iDate.ISMonth_1st(string.Format("{0}-01", PERIOD_YEAR_0.EditValue));
            DateTime vPERIOD_DATE_TO = iDate.ISMonth_Last(string.Format("{0}-12", PERIOD_YEAR_0.EditValue));
            if (igrFACTORY_COST_MONTH.ColIndex == 3)  //합계
            {
                //시작일
                if (iString.ISNull(MONTH_FR_CODE.EditValue) == "M01")  //1월
                {
                    vPERIOD_DATE_FR = iDate.ISMonth_1st(string.Format("{0}-01", PERIOD_YEAR_0.EditValue));
                }
                else if (iString.ISNull(MONTH_FR_CODE.EditValue) == "M02")  //2월
                {
                    vPERIOD_DATE_FR = iDate.ISMonth_1st(string.Format("{0}-02", PERIOD_YEAR_0.EditValue));
                }
                else if (iString.ISNull(MONTH_FR_CODE.EditValue) == "M03")  //3월
                {
                    vPERIOD_DATE_FR = iDate.ISMonth_1st(string.Format("{0}-03", PERIOD_YEAR_0.EditValue));
                }
                else if (iString.ISNull(MONTH_FR_CODE.EditValue) == "M04")  //4월
                {
                    vPERIOD_DATE_FR = iDate.ISMonth_1st(string.Format("{0}-04", PERIOD_YEAR_0.EditValue));
                }
                else if (iString.ISNull(MONTH_FR_CODE.EditValue) == "M05")  //5월
                {
                    vPERIOD_DATE_FR = iDate.ISMonth_1st(string.Format("{0}-05", PERIOD_YEAR_0.EditValue));
                }
                else if (iString.ISNull(MONTH_FR_CODE.EditValue) == "M06")  //6월
                {
                    vPERIOD_DATE_FR = iDate.ISMonth_1st(string.Format("{0}-06", PERIOD_YEAR_0.EditValue));
                }
                else if (iString.ISNull(MONTH_FR_CODE.EditValue) == "M07")  //7월
                {
                    vPERIOD_DATE_FR = iDate.ISMonth_1st(string.Format("{0}-07", PERIOD_YEAR_0.EditValue));
                }
                else if (iString.ISNull(MONTH_FR_CODE.EditValue) == "M08")  //8월
                {
                    vPERIOD_DATE_FR = iDate.ISMonth_1st(string.Format("{0}-08", PERIOD_YEAR_0.EditValue));
                }
                else if (iString.ISNull(MONTH_FR_CODE.EditValue) == "M09")  //9월
                {
                    vPERIOD_DATE_FR = iDate.ISMonth_1st(string.Format("{0}-09", PERIOD_YEAR_0.EditValue));
                }
                else if (iString.ISNull(MONTH_FR_CODE.EditValue) == "M10")  //10월
                {
                    vPERIOD_DATE_FR = iDate.ISMonth_1st(string.Format("{0}-10", PERIOD_YEAR_0.EditValue));
                }
                else if (iString.ISNull(MONTH_FR_CODE.EditValue) == "M11")  //11월
                {
                    vPERIOD_DATE_FR = iDate.ISMonth_1st(string.Format("{0}-11", PERIOD_YEAR_0.EditValue));
                }
                else if (iString.ISNull(MONTH_FR_CODE.EditValue) == "M12")  //12월
                {
                    vPERIOD_DATE_FR = iDate.ISMonth_1st(string.Format("{0}-12", PERIOD_YEAR_0.EditValue));
                }
                //종료일
                if (iString.ISNull(MONTH_FR_CODE.EditValue) == "M01")  //1월
                {
                    vPERIOD_DATE_TO = iDate.ISMonth_Last(string.Format("{0}-01", PERIOD_YEAR_0.EditValue));
                }
                else if (iString.ISNull(MONTH_FR_CODE.EditValue) == "M02")  //2월
                {
                    vPERIOD_DATE_TO = iDate.ISMonth_Last(string.Format("{0}-02", PERIOD_YEAR_0.EditValue));
                }
                else if (iString.ISNull(MONTH_FR_CODE.EditValue) == "M03")  //3월
                {
                    vPERIOD_DATE_TO = iDate.ISMonth_Last(string.Format("{0}-03", PERIOD_YEAR_0.EditValue));
                }
                else if (iString.ISNull(MONTH_FR_CODE.EditValue) == "M04")  //4월
                {
                    vPERIOD_DATE_TO = iDate.ISMonth_Last(string.Format("{0}-04", PERIOD_YEAR_0.EditValue));
                }
                else if (iString.ISNull(MONTH_FR_CODE.EditValue) == "M05")  //5월
                {
                    vPERIOD_DATE_TO = iDate.ISMonth_Last(string.Format("{0}-05", PERIOD_YEAR_0.EditValue));
                }
                else if (iString.ISNull(MONTH_FR_CODE.EditValue) == "M06")  //6월
                {
                    vPERIOD_DATE_TO = iDate.ISMonth_Last(string.Format("{0}-06", PERIOD_YEAR_0.EditValue));
                }
                else if (iString.ISNull(MONTH_FR_CODE.EditValue) == "M07")  //7월
                {
                    vPERIOD_DATE_TO = iDate.ISMonth_Last(string.Format("{0}-07", PERIOD_YEAR_0.EditValue));
                }
                else if (iString.ISNull(MONTH_FR_CODE.EditValue) == "M08")  //8월
                {
                    vPERIOD_DATE_TO = iDate.ISMonth_Last(string.Format("{0}-08", PERIOD_YEAR_0.EditValue));
                }
                else if (iString.ISNull(MONTH_FR_CODE.EditValue) == "M09")  //9월
                {
                    vPERIOD_DATE_TO = iDate.ISMonth_Last(string.Format("{0}-09", PERIOD_YEAR_0.EditValue));
                }
                else if (iString.ISNull(MONTH_FR_CODE.EditValue) == "M10")  //10월
                {
                    vPERIOD_DATE_TO = iDate.ISMonth_Last(string.Format("{0}-10", PERIOD_YEAR_0.EditValue));
                }
                else if (iString.ISNull(MONTH_FR_CODE.EditValue) == "M11")  //11월
                {
                    vPERIOD_DATE_TO = iDate.ISMonth_Last(string.Format("{0}-11", PERIOD_YEAR_0.EditValue));
                }
                else if (iString.ISNull(MONTH_FR_CODE.EditValue) == "M12")  //12월
                {
                    vPERIOD_DATE_TO = iDate.ISMonth_Last(string.Format("{0}-12", PERIOD_YEAR_0.EditValue));
                }
            }
            else if (igrFACTORY_COST_MONTH.ColIndex == 4 || igrFACTORY_COST_MONTH.ColIndex == 5)
            {
                vPERIOD_DATE_FR = iDate.ISMonth_1st(string.Format("{0}-01", PERIOD_YEAR_0.EditValue));
                vPERIOD_DATE_TO = iDate.ISMonth_Last(string.Format("{0}-01", PERIOD_YEAR_0.EditValue));
            }
            else if (igrFACTORY_COST_MONTH.ColIndex == 6 || igrFACTORY_COST_MONTH.ColIndex == 7)
            {
                vPERIOD_DATE_FR = iDate.ISMonth_1st(string.Format("{0}-02", PERIOD_YEAR_0.EditValue));
                vPERIOD_DATE_TO = iDate.ISMonth_Last(string.Format("{0}-02", PERIOD_YEAR_0.EditValue));
            }
            else if (igrFACTORY_COST_MONTH.ColIndex == 8 || igrFACTORY_COST_MONTH.ColIndex == 9)
            {
                vPERIOD_DATE_FR = iDate.ISMonth_1st(string.Format("{0}-03", PERIOD_YEAR_0.EditValue));
                vPERIOD_DATE_TO = iDate.ISMonth_Last(string.Format("{0}-03", PERIOD_YEAR_0.EditValue));
            }
            else if (igrFACTORY_COST_MONTH.ColIndex == 10 || igrFACTORY_COST_MONTH.ColIndex == 11)
            {
                vPERIOD_DATE_FR = iDate.ISMonth_1st(string.Format("{0}-04", PERIOD_YEAR_0.EditValue));
                vPERIOD_DATE_TO = iDate.ISMonth_Last(string.Format("{0}-04", PERIOD_YEAR_0.EditValue));
            }
            else if (igrFACTORY_COST_MONTH.ColIndex == 12 || igrFACTORY_COST_MONTH.ColIndex == 13)
            {
                vPERIOD_DATE_FR = iDate.ISMonth_1st(string.Format("{0}-05", PERIOD_YEAR_0.EditValue));
                vPERIOD_DATE_TO = iDate.ISMonth_Last(string.Format("{0}-05", PERIOD_YEAR_0.EditValue));
            }
            else if (igrFACTORY_COST_MONTH.ColIndex == 14 || igrFACTORY_COST_MONTH.ColIndex == 15)
            {
                vPERIOD_DATE_FR = iDate.ISMonth_1st(string.Format("{0}-06", PERIOD_YEAR_0.EditValue));
                vPERIOD_DATE_TO = iDate.ISMonth_Last(string.Format("{0}-06", PERIOD_YEAR_0.EditValue));
            }
            else if (igrFACTORY_COST_MONTH.ColIndex == 16 || igrFACTORY_COST_MONTH.ColIndex == 17)
            {
                vPERIOD_DATE_FR = iDate.ISMonth_1st(string.Format("{0}-07", PERIOD_YEAR_0.EditValue));
                vPERIOD_DATE_TO = iDate.ISMonth_Last(string.Format("{0}-07", PERIOD_YEAR_0.EditValue));
            }
            else if (igrFACTORY_COST_MONTH.ColIndex == 18 || igrFACTORY_COST_MONTH.ColIndex == 19)
            {
                vPERIOD_DATE_FR = iDate.ISMonth_1st(string.Format("{0}-08", PERIOD_YEAR_0.EditValue));
                vPERIOD_DATE_TO = iDate.ISMonth_Last(string.Format("{0}-08", PERIOD_YEAR_0.EditValue));
            }
            else if (igrFACTORY_COST_MONTH.ColIndex == 20 || igrFACTORY_COST_MONTH.ColIndex == 21)
            {
                vPERIOD_DATE_FR = iDate.ISMonth_1st(string.Format("{0}-09", PERIOD_YEAR_0.EditValue));
                vPERIOD_DATE_TO = iDate.ISMonth_Last(string.Format("{0}-09", PERIOD_YEAR_0.EditValue));
            }
            else if (igrFACTORY_COST_MONTH.ColIndex == 22 || igrFACTORY_COST_MONTH.ColIndex == 23)
            {
                vPERIOD_DATE_FR = iDate.ISMonth_1st(string.Format("{0}-10", PERIOD_YEAR_0.EditValue));
                vPERIOD_DATE_TO = iDate.ISMonth_Last(string.Format("{0}-10", PERIOD_YEAR_0.EditValue));
            }
            else if (igrFACTORY_COST_MONTH.ColIndex == 24 || igrFACTORY_COST_MONTH.ColIndex == 25)
            {
                vPERIOD_DATE_FR = iDate.ISMonth_1st(string.Format("{0}-11", PERIOD_YEAR_0.EditValue));
                vPERIOD_DATE_TO = iDate.ISMonth_Last(string.Format("{0}-11", PERIOD_YEAR_0.EditValue));
            }
            else if (igrFACTORY_COST_MONTH.ColIndex == 26 || igrFACTORY_COST_MONTH.ColIndex == 27)
            {
                vPERIOD_DATE_FR = iDate.ISMonth_1st(string.Format("{0}-12", PERIOD_YEAR_0.EditValue));
                vPERIOD_DATE_TO = iDate.ISMonth_Last(string.Format("{0}-12", PERIOD_YEAR_0.EditValue));
            }
            object vITEM_CODE = igrFACTORY_COST_MONTH.GetCellValue("ITEM_CODE");
            object vITEM_NAME = igrFACTORY_COST_MONTH.GetCellValue("ITEM_NAME");
            if (iString.ISNull(vITEM_CODE) != string.Empty)
            {
                AssmblyRun_Manual("FCMF0295", vPERIOD_DATE_FR, vPERIOD_DATE_TO, vITEM_CODE, vITEM_NAME);
            }
        }

        private void igrFACTORY_COST_QUARTER_CellDoubleClick(object pSender)
        {
            //분기
            if (igrFACTORY_COST_QUARTER.RowIndex < 0)
            {
                return;
            }

            DateTime vPERIOD_DATE_FR = iDate.ISMonth_1st(string.Format("{0}-01", PERIOD_YEAR_1.EditValue));
            DateTime vPERIOD_DATE_TO = iDate.ISMonth_Last(string.Format("{0}-03", PERIOD_YEAR_1.EditValue));
            if (igrFACTORY_COST_QUARTER.ColIndex == 6 || igrFACTORY_COST_QUARTER.ColIndex == 7)
            {
                vPERIOD_DATE_FR = iDate.ISMonth_1st(string.Format("{0}-04", PERIOD_YEAR_1.EditValue));
                vPERIOD_DATE_TO = iDate.ISMonth_Last(string.Format("{0}-06", PERIOD_YEAR_1.EditValue));
            }
            else if (igrFACTORY_COST_QUARTER.ColIndex == 8 || igrFACTORY_COST_QUARTER.ColIndex == 9)
            {
                vPERIOD_DATE_FR = iDate.ISMonth_1st(string.Format("{0}-07", PERIOD_YEAR_1.EditValue));
                vPERIOD_DATE_TO = iDate.ISMonth_Last(string.Format("{0}-09", PERIOD_YEAR_1.EditValue));
            }
            else if (igrFACTORY_COST_QUARTER.ColIndex == 10 || igrFACTORY_COST_QUARTER.ColIndex == 11)
            {
                vPERIOD_DATE_FR = iDate.ISMonth_1st(string.Format("{0}-10", PERIOD_YEAR_1.EditValue));
                vPERIOD_DATE_TO = iDate.ISMonth_Last(string.Format("{0}-12", PERIOD_YEAR_1.EditValue));
            }
            object vITEM_CODE = igrFACTORY_COST_QUARTER.GetCellValue("ITEM_CODE");
            object vITEM_NAME = igrFACTORY_COST_QUARTER.GetCellValue("ITEM_NAME");
            if (iString.ISNull(vITEM_CODE) != string.Empty)
            {
                AssmblyRun_Manual("FCMF0295", vPERIOD_DATE_FR, vPERIOD_DATE_TO, vITEM_CODE, vITEM_NAME);
            }
        }

        private void igrFACTORY_COST_HALF_CellDoubleClick(object pSender)
        {
            //반기
            if (igrFACTORY_COST_HALF.RowIndex < 0)
            {
                return;
            }

            DateTime vPERIOD_DATE_FR = iDate.ISMonth_1st(string.Format("{0}-01", PERIOD_YEAR_2.EditValue));
            DateTime vPERIOD_DATE_TO = iDate.ISMonth_Last(string.Format("{0}-06", PERIOD_YEAR_2.EditValue));
            if (igrFACTORY_COST_HALF.ColIndex == 6 || igrFACTORY_COST_HALF.ColIndex == 7)
            {
                vPERIOD_DATE_FR = iDate.ISMonth_1st(string.Format("{0}-07", PERIOD_YEAR_2.EditValue));
                vPERIOD_DATE_TO = iDate.ISMonth_Last(string.Format("{0}-12", PERIOD_YEAR_2.EditValue));
            }
            object vITEM_CODE = igrFACTORY_COST_HALF.GetCellValue("ITEM_CODE");
            object vITEM_NAME = igrFACTORY_COST_HALF.GetCellValue("ITEM_NAME");
            if (iString.ISNull(vITEM_CODE) != string.Empty)
            {
                AssmblyRun_Manual("FCMF0295", vPERIOD_DATE_FR, vPERIOD_DATE_TO, vITEM_CODE, vITEM_NAME);
            }
        }

        private void igrFACTORY_COST_YEAR_CellDoubleClick(object pSender)
        {
            //년
            if (igrFACTORY_COST_YEAR.RowIndex < 0)
            {
                return;
            }
            DateTime vPERIOD_DATE_FR = iDate.ISMonth_1st(PERIOD_FROM.EditValue);
            DateTime vPERIOD_DATE_TO = iDate.ISMonth_Last(PERIOD_TO.EditValue);
            if (igrFACTORY_COST_YEAR.ColIndex == 6 || igrFACTORY_COST_YEAR.ColIndex == 7)
            {
                vPERIOD_DATE_FR = iDate.ISDate_Month_Add(vPERIOD_DATE_FR, -12);
                vPERIOD_DATE_TO = iDate.ISDate_Month_Add(vPERIOD_DATE_TO, -12);
            }
            object vITEM_CODE = igrFACTORY_COST_YEAR.GetCellValue("ITEM_CODE");
            object vITEM_NAME = igrFACTORY_COST_YEAR.GetCellValue("ITEM_NAME");
            if (iString.ISNull(vITEM_CODE) != string.Empty)
            {
                AssmblyRun_Manual("FCMF0295", vPERIOD_DATE_FR, vPERIOD_DATE_TO, vITEM_CODE, vITEM_NAME);
            }
        }

        #endregion

        #region ----- Lookup Event -----

        private void ilaFS_SET_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter("FS_SET", "Y");
        }

        private void ilaFS_SET_1_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter("FS_SET", "Y");
        }

        private void ilaFS_SET_2_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter("FS_SET", "Y");
        }

        private void ilaFS_SET_3_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter("FS_SET", "Y");
        }

        private void ilaMONTH_FR_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter("MONTH", "Y");
        }

        private void ilaMONTH_TO_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter("MONTH", "Y");
        }

        private void ilaQUARTER_FR_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter("QUARTER", "Y");
        }

        private void ilaQUARTER_TO_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter("QUARTER", "Y");
        }

        private void ilaHALF_FR_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter("HALF_YEARLY", "Y");
        }

        private void ilaHALF_TO_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter("HALF_YEARLY", "Y");
        }

        #endregion

        #region ----- EditAdv Event -----

        private void PERIOD_TO_EditValueChanged(object pSender)
        {
            object vObject = PERIOD_TO.EditValue;
            string vDate = ConvertString(vObject);
            int vLength = vDate.Length;

            string vYear = string.Empty;
            string vYearMonth = string.Empty;

            if (vLength == 7)
            {
                vYear = vDate.Substring(0, 4);
                vYearMonth = string.Format("{0}-01", vYear);

                PERIOD_FROM.EditValue = vYearMonth;
            }
        }

        #endregion

        #region ----- XL Print 1 Method ----

        private void XLPrinting_1(string pOutChoice, InfoSummit.Win.ControlAdv.ISGridAdvEx p_grid_FACTORY_COST_YEAR)
        {
            string vMessageText = string.Empty;
            string vSaveFileName = string.Empty;

            int vCountRow = p_grid_FACTORY_COST_YEAR.RowCount;

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
                xlPrinting.OpenFileNameExcel = "FCMF0762_001.xls";
                //-------------------------------------------------------------------------------------

                //-------------------------------------------------------------------------------------
                bool isOpen = xlPrinting.XLFileOpen();
                //-------------------------------------------------------------------------------------

                //-------------------------------------------------------------------------------------
                if (isOpen == true)
                {
                    vPageNumber = xlPrinting.LineWrite(p_grid_FACTORY_COST_YEAR, idaPRINT_TITLE);

                    if (pOutChoice == "PRINT")
                    {
                        xlPrinting.Printing(1, vPageNumber);
                    }
                    else if (pOutChoice == "FILE")
                    {
                        xlPrinting.SAVE("FS_");
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