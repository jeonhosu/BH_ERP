using System;
using System.Data;
using System.Drawing;
using System.Windows.Forms;
using System.Collections.Generic;
using System.Runtime.InteropServices;       //호환되지 않은DLL을 사용할 때.

using Syncfusion.Windows.Forms;
using Syncfusion.Windows.Forms.Tools;
using Syncfusion.Windows.Forms.Grid;
using InfoSummit.Win.ControlAdv;
using ISCommonUtil;

namespace HRMF0721
{
    public partial class HRMF0721 : Office2007Form
    {
        #region ----- API Dll Import -----

        [DllImport("fcrypt_es.dll")]
        extern public static int DSFC_EncryptFile(int hWnd, string pszPlainFilePathName, string pszEncFilePathName, string pszPassword, uint nOption);

        string inputPath;
        string OutputPath;
        string Password;
        uint DSFC_OPT_OVERWRITE_OUTPUT;
        int nRet;

        #endregion;
        
        #region ----- Variables -----

        ISFunction.ISConvert iConv = new ISFunction.ISConvert();
        ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        #endregion;

        #region ----- Constructor -----

        public HRMF0721()
        {
            InitializeComponent();
        }

        public HRMF0721(Form pMainForm, ISAppInterface pAppInterface)
        {
            InitializeComponent();
            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;            
        }

        #endregion;

        #region ----- Private Methods ----
        
        private void DefaultCorporation()
        {
            try
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
            catch (System.Exception ex)
            {
                isAppInterfaceAdv1.OnAppMessage(ex.Message);
                System.Windows.Forms.Application.DoEvents();
            }
        }

        private void SearchDB()
        {
            if (iConv.ISNull(CORP_ID_0.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10001"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                CORP_NAME_0.Focus();
                return;
            }
            if (iConv.ISNull(START_DATE.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10010"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                START_DATE.Focus();
                return;
            }
            if (iConv.ISNull(END_DATE.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10011"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                END_DATE.Focus();
                return;
            }
            if (iDate.ISGetDate(END_DATE.EditValue) < iDate.ISGetDate(START_DATE.EditValue))
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10012"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                START_DATE.Focus();
                return;
            }
            if (iDate.ISYear(START_DATE.EditValue) != iDate.ISYear(END_DATE.EditValue))
            {
                MessageBoxAdv.Show("시작일자와 종료일자가 다른 년도입니다. 확인하세요", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                START_DATE.Focus();
                return;
            }
            YYYY_0.EditValue = iDate.ISYear(END_DATE.EditValue);
            IDA_eFILE_INFO.Fill();
        }

        private void SetParameter(object pGROUP_CODE, object pENABLED_FLAG)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", pGROUP_CODE);
            ildCOMMON.SetLookupParamValue("W_ENABLED_FLAG_YN", pENABLED_FLAG);
        }

        private string EXPORT_VALIDATE()
        {
            string vRETURN = "N";
            if (iConv.ISNull(CORP_ID_0.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10007"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return vRETURN;
            }

            if (iConv.ISNull(START_DATE.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10010"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return vRETURN;
            }
            if (iConv.ISNull(END_DATE.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10011"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return vRETURN;
            }
            if (Convert.ToDateTime(START_DATE.EditValue) > Convert.ToDateTime(END_DATE.EditValue))
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10012"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return vRETURN;
            }
            if (iConv.ISNull(NAME.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(string.Format("{0}은(는)은 필수입니다. 확인하세요", Get_Edit_Prompt(NAME)), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return vRETURN;
            }
            if (iConv.ISNull(TEL_NUMBER.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(string.Format("{0}은(는)은 필수입니다. 확인하세요", Get_Edit_Prompt(TEL_NUMBER)), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return vRETURN;
            }
            if (iConv.ISNull(TAX_PROGRAM_CODE.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(string.Format("{0}은(는)은 필수입니다. 확인하세요", Get_Edit_Prompt(TAX_PROGRAM_CODE)), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return vRETURN;
            }
            if (iConv.ISNull(USE_LANGUAGE_CODE.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(string.Format("{0}은(는)은 필수입니다. 확인하세요", Get_Edit_Prompt(USE_LANGUAGE_CODE)), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return vRETURN;
            }
            if (iConv.ISNull(SUBMIT_AGENT.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(string.Format("{0}은(는)은 필수입니다. 확인하세요", Get_Edit_Prompt(SUBMIT_AGENT_DESC)), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return vRETURN;
            }
            if (iConv.ISNull(SUBMIT_PERIOD.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(string.Format("{0}은(는)은 필수입니다. 확인하세요", Get_Edit_Prompt(SUBMIT_PERIOD_DESC)), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return vRETURN;
            }
            if (iConv.ISNull(HOMETAX_LOGIN_ID.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(string.Format("{0}은(는)은 필수입니다. 확인하세요", Get_Edit_Prompt(HOMETAX_LOGIN_ID)), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return vRETURN;
            }
            if (iConv.ISNull(WRITE_DATE.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(string.Format("{0}은(는)은 필수입니다. 확인하세요", Get_Edit_Prompt(WRITE_DATE)), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return vRETURN;
            }

            if (IGR_ADJUST_FILE_LIST.RowCount < 1)
            {
                MessageBoxAdv.Show("생성할 원천징수의무자 자료 건수가 존재하지 않습니다. 조회후 다시 실행하세요", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return vRETURN;
            }
            vRETURN = "Y";
            return vRETURN;
        }

        private void Button_Control(string pEnabled_YN)
        {
            if (pEnabled_YN == "Y")
            {
                BTN_YEAR_ADJUST_FILE.Enabled = true;
                BTN_MEDIC_FILE.Enabled = true;
                BTN_DONATION_FILE.Enabled = true;
            }
            else
            {
                BTN_YEAR_ADJUST_FILE.Enabled = false;
                BTN_MEDIC_FILE.Enabled = false;
                BTN_DONATION_FILE.Enabled = false;
            }

        }

        #endregion;

        #region ---- 에디터 프롬프트 리턴 -----
        
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

        #endregion

        #region ----- Text File Export Methods ----

        private void ExportTXT(string pFileName, string pFILE_TYPE, ISDataAdapter pData)
        {
            object vFIX_STRING = null;
            int vCountRow = pData.OraSelectData.Rows.Count;
            if (vCountRow < 1)
            {
                return;
            }

            //전산매체 암호화 암호 입력 받기.
            DialogResult vdlgResult;
            object vENCRYPT_PASSWORD = String.Empty;
            HRMF0721_FILE vHRMF0721_FILE = new HRMF0721_FILE(isAppInterfaceAdv1.AppInterface);
            vdlgResult = vHRMF0721_FILE.ShowDialog();
            if (vdlgResult == DialogResult.OK)
            {
                vENCRYPT_PASSWORD = vHRMF0721_FILE.Get_Encrypt_Password;
            }

            if (iConv.ISNull(vENCRYPT_PASSWORD) == string.Empty)
            {
                return;
            }

            Button_Control("N");  //버튼 사용 불가 만들기.
            if (pFILE_TYPE == "ADJUST")
            {
                vFIX_STRING = "C";
            }
            else if (pFILE_TYPE == "MEDICAL")
            {
                vFIX_STRING = "CA";
            }
            else if (pFILE_TYPE == "DONATION")
            {
                vFIX_STRING = "H";
            }

            isAppInterfaceAdv1.OnAppMessage("Export Text Start...");

            string vSaveTextFileName = String.Empty;
            string vFileName = string.Empty;
            string vFilePath = "C:\\ersdata";

            int euckrCodepage = 51949;
            System.IO.FileStream vWriteFile = null;
            System.Text.StringBuilder vSaveString = new System.Text.StringBuilder();

            //파일 경로 디렉토리 존재 여부 체크(없으면 생성).
            if (System.IO.Directory.Exists(vFilePath) == false)
            {
                System.IO.Directory.CreateDirectory(vFilePath);
            }

            vFileName = String.Format("{0}{1}", vFIX_STRING, iConv.ISNull(pFileName).Replace("-", "").Substring(0, 7));
            saveFileDialog1.Title = "Save File";
            saveFileDialog1.FileName = vFileName;
            saveFileDialog1.DefaultExt = String.Format(".{0}", iConv.ISNull(pFileName).Replace("-", "").Substring(7, 3));
            //System.IO.DirectoryInfo vSaveFolder = new System.IO.DirectoryInfo(System.Environment.GetFolderPath(Environment.SpecialFolder.Desktop));
            System.IO.DirectoryInfo vSaveFolder = new System.IO.DirectoryInfo(vFilePath);
            saveFileDialog1.InitialDirectory = vSaveFolder.FullName;
            saveFileDialog1.Filter = String.Format("Text Files (*.{0})|*.{0}", iConv.ISNull(pFileName).Replace("-", "").Substring(7, 3));
            if (saveFileDialog1.ShowDialog() == System.Windows.Forms.DialogResult.OK)
            {
                Application.UseWaitCursor = true;
                this.Cursor = System.Windows.Forms.Cursors.WaitCursor;
                Application.DoEvents();

                vSaveTextFileName = saveFileDialog1.FileName;
                try
                {
                    vWriteFile = System.IO.File.Open(vSaveTextFileName, System.IO.FileMode.Create, System.IO.FileAccess.Write, System.IO.FileShare.None);
                    foreach (DataRow cRow in pData.OraSelectData.Rows)
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
                    Button_Control("Y");  //버튼 사용 만들기.
                    string vMessage = ex.Message;
                    isAppInterfaceAdv1.OnAppMessage(vMessage);
                    Application.DoEvents();
                    Application.UseWaitCursor = false;
                    this.Cursor = System.Windows.Forms.Cursors.Default;
                }
                isAppInterfaceAdv1.OnAppMessage("Complete, Export Text~!");
                vWriteFile.Dispose();

                //기존 동일한 파일 삭제.
                if (System.IO.File.Exists(vSaveTextFileName) == false)
                {
                    Button_Control("Y");  //버튼 사용 만들기.
                    Application.DoEvents();
                    Application.UseWaitCursor = false;
                    this.Cursor = System.Windows.Forms.Cursors.Default;
                    MessageBoxAdv.Show("암호화 대상 전자파일이 존재하지 않습니다. 확인하세요", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    return;
                }

                nRet = 0;
                inputPath = vSaveTextFileName;// "20120410.201";//pFileName;
                OutputPath = string.Format("{0}.erc", vSaveTextFileName);
                Password = vENCRYPT_PASSWORD.ToString();
                DSFC_OPT_OVERWRITE_OUTPUT = 1;
                nRet = DSFC_EncryptFile(0, inputPath, OutputPath, Password, DSFC_OPT_OVERWRITE_OUTPUT);
                if (nRet != 0)
                {
                    Button_Control("Y");  //버튼 사용 만들기.
                    Application.DoEvents();
                    Application.UseWaitCursor = false;
                    this.Cursor = System.Windows.Forms.Cursors.Default;
                    MessageBox.Show(String.Format("Encrypt Error : {0}", nRet), "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }

                System.IO.File.Delete(vSaveTextFileName);
                System.IO.File.Copy(OutputPath, inputPath, true);
                System.IO.File.Delete(OutputPath);                
            }
            Button_Control("Y");  //버튼 사용 만들기.
            Application.DoEvents();
            Application.UseWaitCursor = false;
            this.Cursor = System.Windows.Forms.Cursors.Default;
        }

        private void ExportTXT_BAK(string pFileName, string pFILE_TYPE, ISDataAdapter pData)
        {
            object vFIX_STRING = null;
            int vCountRow = pData.OraSelectData.Rows.Count;
            if (vCountRow < 1)
            {
                return;
            }

            Button_Control("N");  //버튼 사용 불가 만들기.
            if (pFILE_TYPE == "ADJUST")
            {
                vFIX_STRING = "C";
            }
            else if (pFILE_TYPE == "MEDICAL")
            {
                vFIX_STRING = "CA";
            }
            else if (pFILE_TYPE == "DONATION")
            {
                vFIX_STRING = "H";
            }

            isAppInterfaceAdv1.OnAppMessage("Export Text Start...");

            int euckrCodepage = 51949;
            System.IO.FileStream vWriteFile = null;
            System.Text.StringBuilder vSaveString = new System.Text.StringBuilder();
            
            saveFileDialog1.Title = "Save File";
            saveFileDialog1.FileName = String.Format("{0}{1}", vFIX_STRING, iConv.ISNull(pFileName).Replace("-", "").Substring(0, 7));
            saveFileDialog1.DefaultExt = String.Format(".{0}", iConv.ISNull(pFileName).Replace("-", "").Substring(7, 3));
            System.IO.DirectoryInfo vSaveFolder = new System.IO.DirectoryInfo(System.Environment.GetFolderPath(Environment.SpecialFolder.Desktop));
            saveFileDialog1.InitialDirectory = vSaveFolder.FullName;
            saveFileDialog1.Filter = String.Format("Text Files (*.{0})|*.{0}", iConv.ISNull(pFileName).Replace("-", "").Substring(7, 3));
            if (saveFileDialog1.ShowDialog() == System.Windows.Forms.DialogResult.OK)
            {
                Application.UseWaitCursor = true;
                this.Cursor = System.Windows.Forms.Cursors.WaitCursor;
                Application.DoEvents();

                string vsSaveTextFileName = saveFileDialog1.FileName;
                try
                {
                    vWriteFile = System.IO.File.Open(vsSaveTextFileName, System.IO.FileMode.Create, System.IO.FileAccess.Write, System.IO.FileShare.None);
                    foreach (DataRow cRow in pData.OraSelectData.Rows)
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
                    Button_Control("Y");  //버튼 사용 만들기.
                    string vMessage = ex.Message;
                    isAppInterfaceAdv1.OnAppMessage(vMessage);
                    Application.DoEvents();
                    Application.UseWaitCursor = false;
                    this.Cursor = System.Windows.Forms.Cursors.Default;
                }
                isAppInterfaceAdv1.OnAppMessage("Complete, Export Text~!");
                vWriteFile.Dispose();
            }
            Button_Control("Y");  //버튼 사용 만들기.
            Application.DoEvents();
            Application.UseWaitCursor = false;
            this.Cursor = System.Windows.Forms.Cursors.Default;
        }

        public void ExportTXT_File(ISDataAdapter pData)
        {
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
                    IDA_eFILE_INFO.Update();
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Cancel)
                {
                    if (IDA_eFILE_INFO.IsFocused)
                    {
                        IDA_eFILE_INFO.Cancel();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {
                    if (IDA_eFILE_INFO.IsFocused)
                    {
                        IDA_eFILE_INFO.Delete();
                    }
                }
            }
        }

        #endregion;

        #region ----- Form Event -----

        private void HRMF0721_Load(object sender, EventArgs e)
        {

        }

        private void HRMF0721_Shown(object sender, EventArgs e)
        {
            DefaultCorporation();

            //기준일자.
            YYYY_0.EditValue = iDate.ISYear(DateTime.Today);
            START_DATE.EditValue = iDate.ISMonth_1st(string.Format("{0}-01", iDate.ISYear(DateTime.Today)));
            END_DATE.EditValue = iDate.ISMonth_Last(string.Format("{0}-12", DateTime.Today.Year));

            YYYY_0.Focus();
            WRITE_DATE.EditValue = DateTime.Today;
        }

        private void IGR_ADJUST_FILE_LIST_CurrentCellChanged(object pSender, ISGridAdvExChangedEventArgs e)
        {
            if (e.RowIndex < 0)
            {
                return;
            }
            IGR_ADJUST_FILE_LIST.LastConfirmChanges();        
            IDA_ADJUST_FILE_LIST.OraSelectData.AcceptChanges();
            IDA_ADJUST_FILE_LIST.Refillable = true;            
        }

        private void START_DATE_0_CurrentEditValidated(object pSender, ISEditAdvValidatedEventArgs e)
        {
            END_DATE.EditValue = string.Format("{0}-12-31", iDate.ISYear(START_DATE.EditValue));
        }


        private void BTN_YEAR_ADJUST_FILE_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            int vIDX_SELECT_YN = IGR_ADJUST_FILE_LIST.GetColumnToIndex("SELECT_YN");
            int vIDX_OPERATING_UNIT_ID = IGR_ADJUST_FILE_LIST.GetColumnToIndex("OPERATING_UNIT_ID");
            int vIDX_VAT_NUMBER = IGR_ADJUST_FILE_LIST.GetColumnToIndex("VAT_NUMBER");
            int vIDX_TAX_OFFICE_CODE = IGR_ADJUST_FILE_LIST.GetColumnToIndex("TAX_OFFICE_CODE");
            int vIDX_REC_ADJUST_PERSON_COUNT = IGR_ADJUST_FILE_LIST.GetColumnToIndex("REC_ADJUST_PERSON_COUNT");
            for (int r = 0; r < IGR_ADJUST_FILE_LIST.RowCount; r++)
            {
                if (iConv.ISNull(IGR_ADJUST_FILE_LIST.GetCellValue(r, vIDX_SELECT_YN)) == "Y")
                {
                    IGR_ADJUST_FILE_LIST.CurrentCellMoveTo(r, vIDX_SELECT_YN);

                    if (EXPORT_VALIDATE() != "Y")
                    {
                        return;
                    }
                    
                    object vOPERATING_UNIT_ID = IGR_ADJUST_FILE_LIST.GetCellValue(r, vIDX_OPERATING_UNIT_ID);
                    string vVAT_NUMBER = iConv.ISNull(IGR_ADJUST_FILE_LIST.GetCellValue(r, vIDX_VAT_NUMBER));
                    object vTAX_OFFICE_CODE = IGR_ADJUST_FILE_LIST.GetCellValue(r, vIDX_TAX_OFFICE_CODE);
                    if (iConv.ISNull(vOPERATING_UNIT_ID) == string.Empty)
                    {
                        MessageBoxAdv.Show(string.Format("{0}은(는)은 필수입니다. 확인하세요", "사업장 정보"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                        return;
                    }
                    if (vVAT_NUMBER == string.Empty)
                    {
                        MessageBoxAdv.Show(string.Format("{0}은(는)은 필수입니다. 확인하세요", "사업자번호"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                        return;
                    }
                    if (iConv.ISNull(vTAX_OFFICE_CODE) == string.Empty)
                    {
                        MessageBoxAdv.Show(string.Format("{0}은(는)은 필수입니다. 확인하세요", "관할 세무서"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                        return;
                    }

                    IDA_YEAR_ADJUST_FILE.SetSelectParamValue("P_OPERATING_UNIT_ID", vOPERATING_UNIT_ID);
                    IDA_YEAR_ADJUST_FILE.Fill();
                    ExportTXT(vVAT_NUMBER, "ADJUST", IDA_YEAR_ADJUST_FILE);

                    //생성된 자료수 체크//
                    IDC_GET_YEAR_ADJUST_FILE_P.SetCommandParamValue("P_OPERATING_UNIT_ID", vOPERATING_UNIT_ID);
                    IDC_GET_YEAR_ADJUST_FILE_P.ExecuteNonQuery();
                    object vREC_COUNT = IDC_GET_YEAR_ADJUST_FILE_P.GetCommandParamValue("O_REC_COUNT");
                    
                    IGR_ADJUST_FILE_LIST.SetCellValue(r, vIDX_REC_ADJUST_PERSON_COUNT, vREC_COUNT);
                    IGR_ADJUST_FILE_LIST.SetCellValue(r, vIDX_SELECT_YN, "N");
                }
            }
            IGR_ADJUST_FILE_LIST.LastConfirmChanges();
            IDA_ADJUST_FILE_LIST.OraSelectData.AcceptChanges();
            IDA_ADJUST_FILE_LIST.Refillable = true;            
        }

        private void BTN_MEDIC_FILE_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            int vIDX_SELECT_YN = IGR_ADJUST_FILE_LIST.GetColumnToIndex("SELECT_YN");
            int vIDX_OPERATING_UNIT_ID = IGR_ADJUST_FILE_LIST.GetColumnToIndex("OPERATING_UNIT_ID");
            int vIDX_VAT_NUMBER = IGR_ADJUST_FILE_LIST.GetColumnToIndex("VAT_NUMBER");
            int vIDX_TAX_OFFICE_CODE = IGR_ADJUST_FILE_LIST.GetColumnToIndex("TAX_OFFICE_CODE");
            int vIDX_REC_MEDIC_PERSON_COUNT = IGR_ADJUST_FILE_LIST.GetColumnToIndex("REC_MEDIC_PERSON_COUNT");
            for (int r = 0; r < IGR_ADJUST_FILE_LIST.RowCount; r++)
            {
                if (iConv.ISNull(IGR_ADJUST_FILE_LIST.GetCellValue(r, vIDX_SELECT_YN)) == "Y")
                {
                    IGR_ADJUST_FILE_LIST.CurrentCellMoveTo(r, vIDX_SELECT_YN);

                    if (EXPORT_VALIDATE() != "Y")
                    {
                        return;
                    }

                    object vOPERATING_UNIT_ID = IGR_ADJUST_FILE_LIST.GetCellValue(r, vIDX_OPERATING_UNIT_ID);
                    string vVAT_NUMBER = iConv.ISNull(IGR_ADJUST_FILE_LIST.GetCellValue(r, vIDX_VAT_NUMBER));
                    object vTAX_OFFICE_CODE = IGR_ADJUST_FILE_LIST.GetCellValue(r, vIDX_TAX_OFFICE_CODE);
                    if (iConv.ISNull(vOPERATING_UNIT_ID) == string.Empty)
                    {
                        MessageBoxAdv.Show(string.Format("{0}은(는)은 필수입니다. 확인하세요", "사업장 정보"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                        return;
                    }
                    if (vVAT_NUMBER == string.Empty)
                    {
                        MessageBoxAdv.Show(string.Format("{0}은(는)은 필수입니다. 확인하세요", "사업자번호"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                        return;
                    }
                    if (iConv.ISNull(vTAX_OFFICE_CODE) == string.Empty)
                    {
                        MessageBoxAdv.Show(string.Format("{0}은(는)은 필수입니다. 확인하세요", "관할 세무서"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                        return;
                    }

                    IDA_MEDICAL_FILE.SetSelectParamValue("P_OPERATING_UNIT_ID", vOPERATING_UNIT_ID);
                    IDA_MEDICAL_FILE.Fill();
                    ExportTXT(vVAT_NUMBER, "MEDICAL", IDA_MEDICAL_FILE);

                    //생성된 자료수 체크//                             
                    IDC_GET_YEAR_MEDICAL_FILE_P.SetCommandParamValue("P_OPERATING_UNIT_ID", vOPERATING_UNIT_ID);
                    IDC_GET_YEAR_MEDICAL_FILE_P.ExecuteNonQuery();
                    object vREC_COUNT = IDC_GET_YEAR_MEDICAL_FILE_P.GetCommandParamValue("O_REC_COUNT");

                    IGR_ADJUST_FILE_LIST.SetCellValue(r, vIDX_REC_MEDIC_PERSON_COUNT, vREC_COUNT);
                    IGR_ADJUST_FILE_LIST.SetCellValue(r, vIDX_SELECT_YN, "N");
                }
            }
            IGR_ADJUST_FILE_LIST.LastConfirmChanges();
            IDA_ADJUST_FILE_LIST.OraSelectData.AcceptChanges();
            IDA_ADJUST_FILE_LIST.Refillable = true;   
        }

        private void BTN_DONATION_FILE_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            int vIDX_SELECT_YN = IGR_ADJUST_FILE_LIST.GetColumnToIndex("SELECT_YN");
            int vIDX_OPERATING_UNIT_ID = IGR_ADJUST_FILE_LIST.GetColumnToIndex("OPERATING_UNIT_ID");
            int vIDX_VAT_NUMBER = IGR_ADJUST_FILE_LIST.GetColumnToIndex("VAT_NUMBER");
            int vIDX_TAX_OFFICE_CODE = IGR_ADJUST_FILE_LIST.GetColumnToIndex("TAX_OFFICE_CODE");
            int vIDX_REC_DONA_PERSON_COUNT = IGR_ADJUST_FILE_LIST.GetColumnToIndex("REC_DONA_PERSON_COUNT");
            for (int r = 0; r < IGR_ADJUST_FILE_LIST.RowCount; r++)
            {
                if (iConv.ISNull(IGR_ADJUST_FILE_LIST.GetCellValue(r, vIDX_SELECT_YN)) == "Y")
                {
                    IGR_ADJUST_FILE_LIST.CurrentCellMoveTo(r, vIDX_SELECT_YN);

                    if (EXPORT_VALIDATE() != "Y")
                    {
                        return;
                    }

                    object vOPERATING_UNIT_ID = IGR_ADJUST_FILE_LIST.GetCellValue(r, vIDX_OPERATING_UNIT_ID);
                    string vVAT_NUMBER = iConv.ISNull(IGR_ADJUST_FILE_LIST.GetCellValue(r, vIDX_VAT_NUMBER));
                    object vTAX_OFFICE_CODE = IGR_ADJUST_FILE_LIST.GetCellValue(r, vIDX_TAX_OFFICE_CODE);
                    if (iConv.ISNull(vOPERATING_UNIT_ID) == string.Empty)
                    {
                        MessageBoxAdv.Show(string.Format("{0}은(는)은 필수입니다. 확인하세요", "사업장 정보"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                        return;
                    }
                    if (vVAT_NUMBER == string.Empty)
                    {
                        MessageBoxAdv.Show(string.Format("{0}은(는)은 필수입니다. 확인하세요", "사업자번호"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                        return;
                    }
                    if (iConv.ISNull(vTAX_OFFICE_CODE) == string.Empty)
                    {
                        MessageBoxAdv.Show(string.Format("{0}은(는)은 필수입니다. 확인하세요", "관할 세무서"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                        return;
                    }

                    IDA_DONATION_FILE.SetSelectParamValue("P_OPERATING_UNIT_ID", vOPERATING_UNIT_ID);
                    IDA_DONATION_FILE.Fill();
                    ExportTXT(vVAT_NUMBER, "DONATION", IDA_DONATION_FILE);

                    //생성된 자료수 체크//                    
                    IDC_GET_YEAR_DONA_FILE_P.SetCommandParamValue("P_OPERATING_UNIT_ID", vOPERATING_UNIT_ID);
                    IDC_GET_YEAR_DONA_FILE_P.ExecuteNonQuery();
                    object vREC_COUNT = IDC_GET_YEAR_DONA_FILE_P.GetCommandParamValue("O_REC_COUNT");

                    IGR_ADJUST_FILE_LIST.SetCellValue(r, vIDX_REC_DONA_PERSON_COUNT, vREC_COUNT);
                    IGR_ADJUST_FILE_LIST.SetCellValue(r, vIDX_SELECT_YN, "N");
                }
            }
            IGR_ADJUST_FILE_LIST.LastConfirmChanges();
            IDA_ADJUST_FILE_LIST.OraSelectData.AcceptChanges();
            IDA_ADJUST_FILE_LIST.Refillable = true;   
        }

        #endregion


        #region ----- Lookup Event -----
        
        private void ILA_SUBMIT_AGENT_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetParameter("SUBMIT_AGENT", "Y");
        }

        private void ILA_SUBMIT_PERIOD_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetParameter("SUBMIT_PERIOD", "Y");
        }

        private void ILA_TAX_OFFICE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetParameter("TAX_OFFICE", "Y");
        }

        private void ILA_SUBMIT_PERIOD_SelectedRowData(object pSender)
        {
            if (iConv.ISNull(SUBMIT_PERIOD.EditValue) == "3")
            {
                DateTime vStart_Date = new DateTime(iConv.ISNumtoZero(YYYY_0.EditValue, DateTime.Today.Year), DateTime.Today.Month - 1, 1);
                START_DATE.EditValue = vStart_Date;
                END_DATE.EditValue = iDate.ISMonth_Last(vStart_Date);
            }
            else if (iConv.ISNull(SUBMIT_PERIOD.EditValue) == "2")
            {
                DateTime vStart_Date = new DateTime(iConv.ISNumtoZero(YYYY_0.EditValue, DateTime.Today.Year), DateTime.Today.Month - 1, 1);
                START_DATE.EditValue = vStart_Date;
                END_DATE.EditValue = iDate.ISMonth_Last(vStart_Date);
            }
            else
            {
                DateTime vStart_Date = new DateTime(iConv.ISNumtoZero(YYYY_0.EditValue, DateTime.Today.Year), 1, 1);
                DateTime vEnd_Date = new DateTime(iConv.ISNumtoZero(YYYY_0.EditValue, DateTime.Today.Year), 12, 31);
                START_DATE.EditValue = vStart_Date;
                END_DATE.EditValue = vEnd_Date;
            }
        }

        #endregion

        #region ----- Adapter Event -----

        private void IDA_eFILE_INFO_NewRowMoved(object pSender, ISBindingEventArgs pBindingManager)
        {
            if (pBindingManager.DataRow == null)
            {
                return;
            }
            IDA_ADJUST_FILE_LIST.Fill();
        }

        private void IDA_eFILE_INFO_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {
            if (iConv.ISNull(e.Row["CORP_ID"]) == string.Empty)
            {
                MessageBoxAdv.Show("업체정보가 정확하지 않습니다. 확인하세요", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                CORP_NAME_0.Focus();
                return;
            }
            if (iConv.ISNull(e.Row["OPERATING_UNIT_ID"]) == string.Empty)
            {
                MessageBoxAdv.Show("사업장정보가 정확하지 않습니다. 확인하세요", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                CORP_NAME_0.Focus();
                return;
            }
            if (iConv.ISNull(e.Row["CORP_NAME"]) == string.Empty)
            {
                MessageBoxAdv.Show(string.Format("{0}은 필수입니다. 확인하세요", Get_Edit_Prompt(CORP_NAME)), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                CORP_NAME_0.Focus();
                return;
            }
            if (iConv.ISNull(e.Row["PRESIDENT_NAME"]) == string.Empty)
            {
                MessageBoxAdv.Show(string.Format("{0}은(는) 필수입니다. 확인하세요", Get_Edit_Prompt(PRESIDENT_NAME)), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                CORP_NAME_0.Focus();
                return;
            }
            //if (iConv.ISNull(e.Row["VAT_NUMBER"]) == string.Empty)
            //{
            //    MessageBoxAdv.Show(string.Format("{0}은(는) 필수입니다. 확인하세요", Get_Edit_Prompt(VAT_NUMBER)), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            //    CORP_NAME_0.Focus();
            //    return;
            //}
            //if (iConv.ISNull(e.Row["TAX_OFFICE_CODE"]) == string.Empty)
            //{
            //    MessageBoxAdv.Show(string.Format("{0}은(는) 필수입니다. 확인하세요", Get_Edit_Prompt(TAX_OFFICE_CODE)), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            //    CORP_NAME_0.Focus();
            //    return;
            //}
            //if (iConv.ISNull(e.Row["TAX_OFFICE_NAME"]) == string.Empty)
            //{
            //    MessageBoxAdv.Show(string.Format("{0}은(는) 필수입니다. 확인하세요", Get_Edit_Prompt(TAX_OFFICE_NAME)), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            //    CORP_NAME_0.Focus();
            //    return;
            //}
        }

        private void IDA_ADJUST_FILE_LIST_PreNewRowMoved(object pSender, ISBindingEventArgs pBindingManager)
        {
            if (pBindingManager.DataRow == null)
            {
                return;
            }
            int vIDX_SELECT_YN = IGR_ADJUST_FILE_LIST.GetColumnToIndex("SELECT_YN");
            if (iConv.ISNull(pBindingManager.DataRow["VAT_NUMBER"]) == string.Empty)
            {
                IGR_ADJUST_FILE_LIST.GridAdvExColElement[vIDX_SELECT_YN].Insertable = 0;
                IGR_ADJUST_FILE_LIST.GridAdvExColElement[vIDX_SELECT_YN].Updatable = 0;
            }
            else
            {
                IGR_ADJUST_FILE_LIST.GridAdvExColElement[vIDX_SELECT_YN].Insertable = 1;
                IGR_ADJUST_FILE_LIST.GridAdvExColElement[vIDX_SELECT_YN].Updatable = 1;
            }
        }

        #endregion

    }
}