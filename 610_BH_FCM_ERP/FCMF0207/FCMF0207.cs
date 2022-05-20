using System;
using System.Data;
using System.Drawing;
using System.Windows.Forms;
using System.Collections.Generic;

using System.IO;
using Syncfusion.Windows.Forms;
using Syncfusion.Windows.Forms.Tools;
using Syncfusion.Windows.Forms.Grid;
using InfoSummit.Win.ControlAdv;
using ISCommonUtil;

namespace FCMF0207
{
    public partial class FCMF0207 : Office2007Form
    {
        ISFunction.ISConvert iString = new ISFunction.ISConvert();
        ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        #region ----- Variables -----

        
        #endregion;

        #region ----- Constructor -----

        public FCMF0207()
        {
            InitializeComponent();
        }

        public FCMF0207(Form pMainForm, ISAppInterface pAppInterface)
        {
            InitializeComponent();
            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;
        }

        #endregion;

        #region ----- Private Methods -----

        private void Search_DB()
        {
            UPLOAD_FILE_PATH.EditValue = String.Empty;
            IDA_SLIP_EXCEL.SetSelectParamValue("P_SOB_ID", isAppInterfaceAdv1.SOB_ID);
            IDA_SLIP_EXCEL.Fill();
            IGR_SLIP_EXCEL.Focus();
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

        #region ----- Excel Upload -----

        private void Select_Excel_File()
        {
            try
            {
                DirectoryInfo vOpenFolder = new DirectoryInfo(Environment.GetFolderPath(Environment.SpecialFolder.MyDocuments));

                openFileDialog1.Title = "Select Open File";
                openFileDialog1.Filter = "Excel File(*.xls;*.xlsx)|*.xls;*.xlsx|All File(*.*)|*.*";
                openFileDialog1.DefaultExt = "xls";
                openFileDialog1.FileName = "*.xls;*.xlsx";
                if (openFileDialog1.ShowDialog() == DialogResult.OK)
                {
                    UPLOAD_FILE_PATH.EditValue = openFileDialog1.FileName;
                }
                else
                {
                    UPLOAD_FILE_PATH.EditValue = string.Empty;
                }
            }
            catch (Exception ex)
            {
                isAppInterfaceAdv1.OnAppMessage(ex.Message);
                Application.DoEvents();
            }
        }
                
        private void Excel_Upload()
        {
            string vMessage = string.Empty;
            bool vXL_Load_OK = false;

            if (iString.ISNull(UPLOAD_FILE_PATH.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_90004", string.Format("&&FIELD_NAME:={0}", Get_Edit_Prompt(UPLOAD_FILE_PATH))), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }
            Application.UseWaitCursor = true;
            this.Cursor = Cursors.WaitCursor;
            Application.DoEvents();

            //기존자료 삭제.
            IDC_DELETE_EXCEL_UPLOAD.ExecuteNonQuery();
            if (IDC_DELETE_EXCEL_UPLOAD.ExcuteError == true)
            {
                Application.UseWaitCursor = false;
                this.Cursor = Cursors.Default;
                Application.DoEvents();
                return;
            }

            //기존작업 취소.
            IDA_EXCEL_UPLOAD.Cancel();

            string vOPenFileName = UPLOAD_FILE_PATH.EditValue.ToString();
            XL_Upload vXL_Upload = new XL_Upload(isAppInterfaceAdv1, isMessageAdapter1);
            try
            {
                vXL_Upload.OpenFileName = vOPenFileName;
                vXL_Load_OK = vXL_Upload.OpenXL();
            }
            catch(Exception ex)
            {
                isAppInterfaceAdv1.OnAppMessage(ex.Message);

                Application.UseWaitCursor = false;
                this.Cursor = Cursors.Default;
                Application.DoEvents();
                return;
            }

            try
            {
                if (vXL_Load_OK == true)
                {
                    vXL_Load_OK = vXL_Upload.LoadXL(IDA_EXCEL_UPLOAD, 2);
                    if (vXL_Load_OK == false)
                    {
                        IDA_EXCEL_UPLOAD.Cancel();
                    }
                    else
                    {
                        IDA_EXCEL_UPLOAD.Update();
                    }
                }
            }
            catch (Exception ex)
            {
                isAppInterfaceAdv1.OnAppMessage(ex.Message);
                vXL_Upload.DisposeXL();

                Application.UseWaitCursor = false;
                this.Cursor = Cursors.Default;
                Application.DoEvents();
                return;
            }
            vXL_Upload.DisposeXL();
            Application.UseWaitCursor = false;
            this.Cursor = Cursors.Default;
            Application.DoEvents();
        }

        private void Set_Slip_Transfer()
        {
            DialogResult dlgResult;
            dlgResult = MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10303"), "Question", MessageBoxButtons.YesNo, MessageBoxIcon.Question);
            if (dlgResult == DialogResult.No)
            {
                return;
            }
            Application.UseWaitCursor = true;
            this.Cursor = Cursors.WaitCursor;
            Application.DoEvents();

            string vSTATUS = "F";
            object vMESSAGE = string.Empty;

            IDC_SET_SLIP_TRANSFER.ExecuteNonQuery();
            vSTATUS = IDC_SET_SLIP_TRANSFER.GetCommandParamValue("O_STATUS").ToString();
            vMESSAGE = IDC_SET_SLIP_TRANSFER.GetCommandParamValue("O_MESSAGE");
            if (IDC_SET_SLIP_TRANSFER.ExcuteError == true || vSTATUS == "F")
            {
                Application.UseWaitCursor = false;
                this.Cursor = Cursors.Default;
                Application.DoEvents();
                if (iString.ISNull(vMESSAGE) != string.Empty)
                {
                    MessageBoxAdv.Show(vMESSAGE.ToString(), "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
                return;
            }

            Application.UseWaitCursor = false;
            this.Cursor = Cursors.Default;
            Application.DoEvents();
        }

        private void Cancel_Slip_Transfer()
        {
            DialogResult dlgResult;
            dlgResult = MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10333"), "Question", MessageBoxButtons.YesNo, MessageBoxIcon.Question);
            if (dlgResult == DialogResult.No)
            {
                return;
            }

            Application.UseWaitCursor = true;
            this.Cursor = Cursors.WaitCursor;
            Application.DoEvents();

            string vSTATUS = "F";
            object vMESSAGE = String.Empty;

            IDC_CANCEL_SLIP_TRANSFER.ExecuteNonQuery();
            vSTATUS = IDC_CANCEL_SLIP_TRANSFER.GetCommandParamValue("O_STATUS").ToString();
            vMESSAGE = IDC_CANCEL_SLIP_TRANSFER.GetCommandParamValue("O_MESSAGE");
            if (IDC_CANCEL_SLIP_TRANSFER.ExcuteError == true || vSTATUS == "F")
            {
                Application.UseWaitCursor = false;
                this.Cursor = Cursors.Default;
                Application.DoEvents();
                if (iString.ISNull(vMESSAGE) != string.Empty)
                {
                    MessageBoxAdv.Show(vMESSAGE.ToString(), "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
                return;
            }

            Application.UseWaitCursor = false;
            this.Cursor = Cursors.Default;
            Application.DoEvents();
        }

        #endregion

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

        #region ----- Form Event -----


        private void FCMF0207_Load(object sender, EventArgs e)
        {
            IDA_SLIP_EXCEL.FillSchema();
            IDA_EXCEL_UPLOAD.FillSchema();
        }

        private void FCMF0207_Shown(object sender, EventArgs e)
        {
            
        }

        private void BTN_SELECT_EXCEL_FILE_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            Select_Excel_File();
        }

        private void BTN_FILE_UPLOAD_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            IDA_SLIP_EXCEL.SetSelectParamValue("P_SOB_ID", -1);
            IDA_SLIP_EXCEL.Fill();
            Excel_Upload();
            Search_DB();
        }

        private void BTN_SLIP_OK_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            Set_Slip_Transfer();
            Search_DB();
        }

        private void BTN_SLIP_CANCEL_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            Cancel_Slip_Transfer();
            Search_DB();
        }
        
        #endregion

        #region ----- Lookup Event -----


        #endregion

        #region ----- Adapeter Event -----
    
        #endregion


    }
}