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

namespace HRMF0223
{
    public partial class HRMF0223 : Office2007Form
    {
        #region ----- Variables -----

        ISFunction.ISConvert iConv = new ISFunction.ISConvert();
        ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        #endregion;

        #region ----- Constructor -----

        public HRMF0223()
        {
            InitializeComponent();
        }

        public HRMF0223(Form pMainForm, ISAppInterface pAppInterface)
        {
            InitializeComponent();
            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;
        }

        #endregion;

        #region ----- Private Methods ----

        private void DefaultValues()
        {
            // Lookup SETTING
            ILD_CORP_1.SetLookupParamValue("W_DEPT_CONTROL_YN", "Y");
            ILD_CORP_1.SetLookupParamValue("W_ENABLED_FLAG_YN", "N");

            // LOOKUP DEFAULT VALUE SETTING - CORP
            idcDEFAULT_CORP.SetCommandParamValue("W_DEPT_CONTROL_YN", "Y");
            idcDEFAULT_CORP.SetCommandParamValue("W_ENABLED_FLAG_YN", "N");
            idcDEFAULT_CORP.ExecuteNonQuery();

            CORP_NAME_2.EditValue = idcDEFAULT_CORP.GetCommandParamValue("O_CORP_NAME");
            CORP_ID_2.EditValue = idcDEFAULT_CORP.GetCommandParamValue("O_CORP_ID");
            CORP_NAME_1.EditValue = idcDEFAULT_CORP.GetCommandParamValue("O_CORP_NAME");
            CORP_ID_1.EditValue = idcDEFAULT_CORP.GetCommandParamValue("O_CORP_ID");
        }

        private void Search_DB()
        {
            if (TB_EDUCATION.SelectedTab.TabIndex == 2)
            {
                if (iConv.ISNull(CORP_ID_1.EditValue) == string.Empty)
                {
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10001"), "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    //e.Cancel = true; 
                    return;
                }

                if (iConv.ISNull(STAT_DATE.EditValue) == string.Empty)
                {
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10010"), "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    //e.Cancel = true;
                    return;
                }

                if (iConv.ISNull(END_DATE.EditValue) == string.Empty)
                {
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10011"), "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    //e.Cancel = true;
                    return;
                }

                if (Convert.ToDateTime(STAT_DATE.EditValue) > Convert.ToDateTime(END_DATE.EditValue))
                {
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10012"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    STAT_DATE.Focus();
                    return;
                }

                IDA_EDUCATION_STATE_1.Fill();
                IGR_EDUCATION_CURRENT.Focus(); 
            }

            else if (TB_EDUCATION.SelectedTab.TabIndex == 3 )
            {
                

                if (iConv.ISNull(CORP_ID_2.EditValue) == string.Empty)
                {
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10001"), "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    //e.Cancel = true;
                    return;
                }

                if (iConv.ISNull(STD_DATE_2.EditValue) == string.Empty)
                {
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10015"), "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    //e.Cancel = true;
                    return;
                }

                IDA_PERSON_2.Fill();
                IGR_PERSON_INFO.Focus();
            }
        }

        private void SetCommonParameter(object pGroup_Code, object pEnabled_YN)
        {
            ILD_COMMON.SetLookupParamValue("W_GROUP_CODE", pGroup_Code);
            ILD_COMMON.SetLookupParamValue("W_ENABLED_FLAG_YN", pEnabled_YN);
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
                    if (IDA_EDUCATION_STATE_1.IsFocused)
                    {
                        IDA_EDUCATION_STATE_1.AddOver();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddUnder)
                {
                    if (IDA_EDUCATION_STATE_1.IsFocused)
                    {
                        IDA_EDUCATION_STATE_1.AddUnder();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Update)
                {
                    if (IDA_EDUCATION_STATE_1.IsFocused)
                    {
                        IDA_EDUCATION_STATE_1.Update();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Cancel)
                {
                    if (IDA_EDUCATION_STATE_1.IsFocused)
                    {
                        IDA_EDUCATION_STATE_1.Cancel();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {
                    if (IDA_EDUCATION_STATE_1.IsFocused)
                    {
                        IDA_EDUCATION_STATE_1.Delete();
                    }
                }
            }
        }

        #endregion;

        #region ----Form event -----

        private void HRMF0223_Load(object sender, EventArgs e)
        {
            IDA_EDUCATION_STATE_1.FillSchema();
        }

        private void HRMF0223_Shown(object sender, EventArgs e)
        {
            DefaultValues();

            STAT_DATE.EditValue = iDate.ISMonth_1st(DateTime.Today);
            END_DATE.EditValue = DateTime.Today;
            STD_DATE_2.EditValue = DateTime.Today;
        }
        #endregion

        #region ------ Lookup event ------

        private void ILA_PERSON_0_SelectedRowData(object pSender)
        {
            Search_DB();
        }

        private void ILA_PERSON_1_SelectedRowData(object pSender)
        {
            Search_DB();
        }

        private void ILA_DEPT_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ILD_DEPT_2.SetLookupParamValue("W_USABLE_CHECK_YN", "Y");
        }

        private void ILA_DEPT_1_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ILD_DEPT_1.SetLookupParamValue("W_USABLE_CHECK_YN", "Y");
        }

        private void ILA_FLOOR_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter("FLOOR", "Y");
        }

        private void ILA_FLOOR_1_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter("FLOOR", "Y");
        }

        private void ILA_POST_1_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter("JOB_CATEGORY", "Y");
        }

        #endregion 


        #region ------ button event ------

        private void bXL_Choice_Deduction_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            Select_Excel_File();
        }

        private void bXL_UpLoad_Deduction_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            Excel_Upload();  // 계좌 업로드 //   
        }

        #endregion

        #region ----- Excel Upload : Asset Master -----

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
                    FILE_PATH_MASTER.EditValue = openFileDialog1.FileName;
                }
                else
                {
                    FILE_PATH_MASTER.EditValue = string.Empty;
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
            string vSTATUS = string.Empty;
            string vMESSAGE = string.Empty;
            bool vXL_Load_OK = false;

            if (iConv .ISNull(FILE_PATH_MASTER.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_90004", string.Format("&&FIELD_NAME:={0}", Get_Edit_Prompt(FILE_PATH_MASTER))), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }
            Application.UseWaitCursor = true;
            this.Cursor = Cursors.WaitCursor;
            Application.DoEvents();

            string vOPenFileName = FILE_PATH_MASTER.EditValue.ToString();
            XL_Upload vXL_Upload = new XL_Upload(isAppInterfaceAdv1, isMessageAdapter1);

            try
            {
                vXL_Upload.OpenFileName = vOPenFileName;
                vXL_Load_OK = vXL_Upload.OpenXL();
            }
            catch (Exception ex)
            {
                isAppInterfaceAdv1.OnAppMessage(ex.Message);

                Application.UseWaitCursor = false;
                this.Cursor = Cursors.Default;
                Application.DoEvents();
                return;
            }


            // 업로드 아답터 fill //
            IDA_XLUPLOAD_EDUCATION .Fill();

            try
            {
                if (vXL_Load_OK == true)
                {
                    vXL_Load_OK = vXL_Upload.LoadXL_10(IDA_XLUPLOAD_EDUCATION, 2);

                    if (vXL_Load_OK == false)
                    {
                        IDA_XLUPLOAD_EDUCATION.Cancel();
                        MessageBoxAdv.Show(vMESSAGE, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    }
                    else
                    {
                        IDA_XLUPLOAD_EDUCATION.Update();
                    }
                }
            }
            catch (Exception ex)
            {
                IDA_XLUPLOAD_EDUCATION.Cancel();

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

        #endregion



    }
}