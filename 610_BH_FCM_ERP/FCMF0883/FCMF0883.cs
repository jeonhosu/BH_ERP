using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using System.Runtime.InteropServices;       //호환되지 않은DLL을 사용할 때.

using Syncfusion.Windows.Forms;
using Syncfusion.Windows.Forms.Tools;
using Syncfusion.Windows.Forms.Grid;

using InfoSummit.Win.ControlAdv;
using ISCommonUtil;

namespace FCMF0883
{
    public partial class FCMF0883 : Office2007Form
    {
        #region ----- API Dll Import -----

        [DllImport("fcrypt_es.dll")]
        public static extern int DSFC_EncryptFile(int hWnd, string pszPlainFilePathName, string pszEncFilePathName, string pszPassword, uint nOption);

        #endregion;

        #region ----- Variables -----

        private ISFunction.ISConvert iString = new ISFunction.ISConvert();
        private ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        string inputPath;
        string OutputPath;
        string Password;
        uint DSFC_OPT_OVERWRITE_OUTPUT;
        int nRet;

        #endregion;

        #region ----- Constructor -----

        public FCMF0883(Form pMainForm, ISAppInterface pAppInterface)
        {
            InitializeComponent();
            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;
        }

        #endregion;

        #region ----- User Methods ----

        private void SearchDB()
        {
            object vObject1 = W_TAX_DESC.EditValue;
            object vObject2 = PERIOD_YEAR.EditValue;
            object vObject3 = VAT_REPORT_NM.EditValue;
            if (iString.ISNull(vObject1) == string.Empty || iString.ISNull(vObject2) == string.Empty || iString.ISNull(vObject3) == string.Empty)
            {
                //사업장, 과세년도, 신고기간구분은 필수 입니다.
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10366"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }

            try
            {
                idaLIST_VAT_E_FILE.Fill();

                //object vObject_CREATE_YN = CREATE_YN.EditValue;
                //string vCREATEYN = ConvertString(vObject_CREATE_YN);
                //if (vCREATEYN == "Y")
                //{
                    IDA_FILE_DOWN_VAT_E_FILE.Fill();
                //}
            }
            catch (System.Exception ex)
            {
                MessageBoxAdv.Show(ex.Message, "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            }
        }

        private void SetCommonParameter(object pGroup_Code, object pEnabled_YN)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", pGroup_Code);
            ildCOMMON.SetLookupParamValue("W_ENABLED_YN", pEnabled_YN);
        }

        private bool IS_CLOSING_YN()
        {
            bool isClosing = false;

            object vObject = CLOSING_YN.EditValue;
            if (iString.ISNull(vObject) == string.Empty || iString.ISNull(vObject) == "Y")
            {
                isClosing = true;
                //해당 신고기간의 자료는 마감되어 변경할 수 없습니다.
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10365"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            }

            return isClosing;
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

        #region ----- MDi ToolBar Button Event -----

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
                    if (idaLIST_VAT_E_FILE.IsFocused == true)
                    {
                        Save_LIST_VAT_E_FILE();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Cancel)
                {
                    if (idaLIST_VAT_E_FILE.IsFocused == true)
                    {
                        idaLIST_VAT_E_FILE.Cancel();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {
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

        #region ----- Form Event -----

        private void FCMF0883_Load(object sender, EventArgs e)
        {
            idaLIST_VAT_E_FILE.FillSchema();

            PERIOD_YEAR.EditValue = iDate.ISYear(System.DateTime.Today);
        }
        
        private void FCMF0883_Shown(object sender, EventArgs e)
        {
            IDC_SET_TAX_CODE.ExecuteNonQuery();
            W_TAX_DESC.EditValue = IDC_SET_TAX_CODE.GetCommandParamValue("O_TAX_DESC");
            W_TAX_CODE.EditValue = IDC_SET_TAX_CODE.GetCommandParamValue("O_TAX_CODE");
        }

        #endregion

        #region ----- Lookup Event -----

        private void ilaTAX_CODE_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter("TAX_CODE", "Y");
        }

        private void ilaPOP_VAT_REPORT_MNG_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            
        }

        private void ilaVAT_PRESENTER_GB_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter("VAT_PRESENTER_GB", "Y");
        }

        private void ilaVAT_LEVIER_GB_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter("VAT_LEVIER_GB", "Y");
        }

        private void ilaVAT_REFUND_GB_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter("VAT_REFUND_GB", "Y");
        }

        #endregion

        #region ----- Save Method -----

        private bool Save_LIST_VAT_E_FILE()
        {
            bool vIsSave = false;

            bool isClosing = IS_CLOSING_YN();
            if (isClosing == false)
            {
                try
                {
                    idaLIST_VAT_E_FILE.Update();

                    vIsSave = true;
                }
                catch
                {
                }
            }

            return vIsSave;
        }

        #endregion;

        #region ----- Button Event-----

        private void CREATE_EXPORT_CONFIRM_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            object vObject01 = W_TAX_DESC.EditValue;
            object vObject02 = PERIOD_YEAR.EditValue;
            object vObject03 = VAT_REPORT_NM.EditValue;

            object vObject04 = TITLE_14.EditValue;
            object vObject05 = TITLE_01_1.EditValue;
            object vObject06 = TITLE_01_2.EditValue;

            object vObject07 = DEAL_BANK.EditValue;
            object vObject08 = DEAL_BRANCH.EditValue;
            object vObject09 = ACC_NO.EditValue;

            object vObject10 = HOMETAX_USER_ID.EditValue;

            object vObject11 = VAT_PRESENTER_GB_NAME.EditValue;
            object vObject12 = VAT_LEVIER_GB_NAME.EditValue;
            if (iString.ISNull(vObject01) == string.Empty
             || iString.ISNull(vObject02) == string.Empty
             || iString.ISNull(vObject03) == string.Empty
             || iString.ISNull(vObject04) == string.Empty
             || iString.ISNull(vObject05) == string.Empty
             || iString.ISNull(vObject06) == string.Empty
             || iString.ISNull(vObject07) == string.Empty
             || iString.ISNull(vObject08) == string.Empty
             || iString.ISNull(vObject09) == string.Empty
             || iString.ISNull(vObject10) == string.Empty
             || iString.ISNull(vObject11) == string.Empty
             || iString.ISNull(vObject12) == string.Empty)
            {
                //작성일자부터 환급구분까지의 항목은 모두 필수 입니다.
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10394"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }

            object vObject_CLOSING_YN = CLOSING_YN.EditValue;
            string vClosingYN = ConvertString(vObject_CLOSING_YN);
            if (vClosingYN == "Y")
            {
                //해당 신고기간의 자료는 마감되어 변경할 수 없습니다.
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10365"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }

            if (E_FILE_SURTAX_YN.CheckedState == ISUtil.Enum.CheckedState.Unchecked)
            {
                //전자신고파일 생성 대상 명세서 여부의 부가세신고서는 필수 입니다.
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10395"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }

            System.Windows.Forms.DialogResult vChoiceValue;

            string vMessageString1 = isMessageAdapter1.ReturnText("FCM_10376"); //기초자료를 생성하시겠습니까?
            string vMessageString2 = isMessageAdapter1.ReturnText("FCM_10377"); //기존 자료가 삭제되고 (재)생성됩니다.
            string vMessage = string.Format("{0}\n\n{1}", vMessageString1, vMessageString2);
            vChoiceValue = MessageBoxAdv.Show(vMessage, "Warning", System.Windows.Forms.MessageBoxButtons.YesNo, System.Windows.Forms.MessageBoxIcon.Question, System.Windows.Forms.MessageBoxDefaultButton.Button2);

            try
            {
                if (vChoiceValue == System.Windows.Forms.DialogResult.Yes)
                {
                    bool vIsSave = Save_LIST_VAT_E_FILE();

                    if (vIsSave == true)
                    {
                        idcCREATE_VAT_E_FILE.ExecuteNonQuery();

                        //해당 작업을 정상적으로 처리 완료하였습니다.
                        MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10112"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);

                        SearchDB();
                    }
                }
            }
            catch (System.Exception ex)
            {
                MessageBoxAdv.Show(ex.Message, "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            }
        }

        private void VAT_REPORT_FILE_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            object vObject_CREATE_YN = CREATE_YN.EditValue;
            string vCreateYN = ConvertString(vObject_CREATE_YN);
            if (vCreateYN == "Y")
            {

                //전산매체 암호화 암호 입력 받기.
                DialogResult vdlgResult;
                object vENCRYPT_PASSWORD = String.Empty;
                FCMF0883_FILE vFCMF0883_FILE = new FCMF0883_FILE(isAppInterfaceAdv1.AppInterface);
                vdlgResult = vFCMF0883_FILE.ShowDialog();
                if (vdlgResult == DialogResult.OK)
                {
                    vENCRYPT_PASSWORD = vFCMF0883_FILE.Get_Encrypt_Password;
                }

                if (iString.ISNull(vENCRYPT_PASSWORD) == string.Empty)
                {
                    return;
                }

                IDA_FILE_DOWN_VAT_E_FILE.Fill();
                ExportTXT(vENCRYPT_PASSWORD, IDA_FILE_DOWN_VAT_E_FILE);
            }
            else
            {
                //선택한 신고기간의 전자신고파일이 생성되어 있지 않습니다.
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10387"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }
        }

        #endregion

        #region ----- Text File Export Method ----

        private void ExportTXT(object pENCRYPT_PASSWORD, InfoSummit.Win.ControlAdv.ISDataAdapter pAdapter)
        {
            bool vIsDialogOpen = false;
            bool vIsSuccess = false;
            string vMessage = string.Empty;
            int vCountRow = pAdapter.OraSelectData.Rows.Count;
            if (vCountRow < 1)
            {
                vMessage = isMessageAdapter1.ReturnText("FCM_10391"); //자료가 없습니다.
                isAppInterfaceAdv1.OnAppMessage(vMessage);
                System.Windows.Forms.Application.DoEvents();
                return;
            }

            string vString1 = isMessageAdapter1.ReturnText("FCM_10388"); //부가세전자신고파일생성
            string vString2 = isMessageAdapter1.ReturnText("FCM_10389");     //내려받기
            string vString3 = isMessageAdapter1.ReturnText("FCM_10390");     //완료 되었습니다.
            string vString4 = isMessageAdapter1.ReturnText("FCM_10392");     //실패했습니다.

            int euckrCodepage = 51949;
            System.IO.FileStream vWriteFile = null;
            System.Text.StringBuilder vSaveString = new System.Text.StringBuilder();

            string vFilePath = "C:\\ersdata"; 
            string vDefaultExpansion = ".101";
            string vFileNameSave = TITLE_14.DateTimeValue.ToShortDateString().Replace("-", "");
            string vSaveTextFileName = String.Empty;

            //파일 경로 디렉토리 존재 여부 체크(없으면 생성).
            if (System.IO.Directory.Exists(vFilePath) == false)
            {
                System.IO.Directory.CreateDirectory(vFilePath);
            }

            saveFileDialog1.RestoreDirectory = true;
            saveFileDialog1.Title = vString1;
            saveFileDialog1.FileName = string.Format("{0}{1}", vFileNameSave, vDefaultExpansion);
            saveFileDialog1.DefaultExt = vDefaultExpansion;
            //System.IO.DirectoryInfo vSaveFolder = new System.IO.DirectoryInfo(System.Environment.GetFolderPath(Environment.SpecialFolder.Desktop));  //바탕화면 지정.
            System.IO.DirectoryInfo vSaveFolder = new System.IO.DirectoryInfo(vFilePath);
            saveFileDialog1.InitialDirectory = vSaveFolder.FullName;
            saveFileDialog1.Filter = "Text Files (*.101)|*.101";
            if (saveFileDialog1.ShowDialog() == System.Windows.Forms.DialogResult.OK)
            {
                vIsDialogOpen = true;
                vMessage = string.Format("{0} {1} ...", vString1, vString2); //부가세전자신고파일생성 내려받기 ...
                isAppInterfaceAdv1.OnAppMessage(vMessage);

                System.Windows.Forms.Application.UseWaitCursor = true;
                this.Cursor = System.Windows.Forms.Cursors.WaitCursor;
                System.Windows.Forms.Application.DoEvents();

                vSaveTextFileName = saveFileDialog1.FileName;
                try
                {
                    vWriteFile = System.IO.File.Open(vSaveTextFileName, System.IO.FileMode.Create, System.IO.FileAccess.Write, System.IO.FileShare.None);
                    foreach (System.Data.DataRow vRow in pAdapter.OraSelectData.Rows)
                    {
                        vSaveString = new System.Text.StringBuilder();  //초기화
                        vSaveString.Append(vRow["REPORT_CONTENT"]);
                        vSaveString.Append("\r\n");

                        System.Text.Encoding vEUCKR = System.Text.Encoding.GetEncoding(euckrCodepage);
                        byte[] vSaveBytes = vEUCKR.GetBytes(vSaveString.ToString());

                        int vSaveStrigLength = vSaveBytes.Length;
                        vWriteFile.Write(vSaveBytes, 0, vSaveStrigLength);
                    }

                    vIsSuccess = true;
                }
                catch (System.Exception ex)
                {
                    isAppInterfaceAdv1.OnAppMessage(ex.Message);
                    System.Windows.Forms.Application.DoEvents();

                    System.Windows.Forms.Application.UseWaitCursor = false;
                    this.Cursor = System.Windows.Forms.Cursors.Default;
                }

                vWriteFile.Dispose();

                //기존 동일한 파일 삭제.
                if (System.IO.File.Exists(vSaveTextFileName) == false)
                {
                    MessageBoxAdv.Show("암호화 대상 전자파일이 존재하지 않습니다. 확인하세요", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    return;
                }

                nRet = 0;
                inputPath = vSaveTextFileName;// "20120410.201";//pFileName;
                OutputPath = string.Format("{0}.erc", vSaveTextFileName);
                Password = pENCRYPT_PASSWORD.ToString();
                DSFC_OPT_OVERWRITE_OUTPUT = 1;
                nRet = DSFC_EncryptFile(0, inputPath, OutputPath, Password, DSFC_OPT_OVERWRITE_OUTPUT);
                if (nRet != 0)
                {
                    MessageBox.Show("Encrypt Error", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }

                System.IO.File.Delete(vSaveTextFileName);
                System.IO.File.Copy(OutputPath, inputPath, true);
                System.IO.File.Delete(OutputPath);                
            }

            System.Windows.Forms.Application.DoEvents();
            System.Windows.Forms.Application.UseWaitCursor = false;
            this.Cursor = System.Windows.Forms.Cursors.Default;

            if (vIsDialogOpen == true)
            {
                if (vIsSuccess == true)
                {
                    vMessage = string.Format("{0} {1} {2}", vString1, vString2, vString3); //부가세전자신고파일생성 내려받기 완료 되었습니다.
                    isAppInterfaceAdv1.OnAppMessage(vMessage);
                    MessageBoxAdv.Show(vMessage, "Information", MessageBoxButtons.OK, MessageBoxIcon.Information);
                }
                else
                {
                    vMessage = string.Format("{0} {1}", vString1, vString4); //부가세전자신고파일생성 실패했습니다.
                    isAppInterfaceAdv1.OnAppMessage(vMessage);
                    MessageBoxAdv.Show(vMessage, "Information", MessageBoxButtons.OK, MessageBoxIcon.Information);
                }
            }
        }

        #endregion
    }
}