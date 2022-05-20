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

namespace HRMF0212
{
    public partial class HRMF0212 : Office2007Form
    {
        ISFunction.ISConvert iConv = new ISFunction.ISConvert();

        #region ----- Constructor -----

        public HRMF0212(Form pMainForm, ISAppInterface pAppInterface)
        {
            this.Visible = false;
            this.DoubleBuffered = true;

            InitializeComponent();

            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;
        }
        #endregion;

        #region ----- Property / Method ----
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
            ildCORP.SetLookupParamValue("W_DUTY_CONTROL_YN", "Y");
            ildCORP.SetLookupParamValue("W_ENABLED_FLAG_YN", "N");

            // LOOKUP DEFAULT VALUE SETTING - CORP
            idcDEFAULT_CORP.SetCommandParamValue("W_DUTY_CONTROL_YN", "Y");
            idcDEFAULT_CORP.SetCommandParamValue("W_ENABLED_FLAG_YN", "N");
            idcDEFAULT_CORP.ExecuteNonQuery();
            //CORP_NAME_0.EditValue = idcDEFAULT_CORP.GetCommandParamValue("O_CORP_NAME");
            //CORP_ID_0.EditValue = idcDEFAULT_CORP.GetCommandParamValue("O_CORP_ID");
        }

        private void SEARCH_DB()
        {
            if (START_DATE_0.EditValue != null && string.IsNullOrEmpty(START_DATE_0.EditValue.ToString()))
            {// 시작일자
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10010"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }
            if (END_DATE_0.EditValue != null && string.IsNullOrEmpty(END_DATE_0.EditValue.ToString()))
            {// 종료일자
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10011"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }
            if (iConv.ISNull(EMPLOYE_TYPE_0.EditValue) == string.Empty)
            {// 입퇴사 구분 
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10055"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }
            idaJOIN_RETIRE.Fill();
            igrJOIN_RETIRE.Focus();
        }

        #endregion

        #region ----- Territory : Get Prompt ----

        private object GetPrompt(InfoSummit.Win.ControlAdv.ISRadioButtonAdv pRaidoButton)
        {
            object vPrompt = string.Empty;
            switch(isAppInterfaceAdv1.AppInterface.OraConnectionInfo.TerritoryLanguage)
            {
                case ISUtil.Enum.TerritoryLanguage.TL1_KR:
                    vPrompt = pRaidoButton.PromptTextElement[0].TL1_KR;
                    vPrompt = string.Format("{0} 내역", vPrompt);
                    break;
                case ISUtil.Enum.TerritoryLanguage.TL2_CN:
                    vPrompt = pRaidoButton.PromptTextElement[0].TL2_CN;
                    vPrompt = string.Format("{0} List", vPrompt);
                    break;
                case ISUtil.Enum.TerritoryLanguage.TL3_VN:
                    vPrompt = pRaidoButton.PromptTextElement[0].TL3_VN;
                    vPrompt = string.Format("{0} List", vPrompt);
                    break;
                case ISUtil.Enum.TerritoryLanguage.TL4_JP:
                    vPrompt = pRaidoButton.PromptTextElement[0].TL4_JP;
                    vPrompt = string.Format("{0} List", vPrompt);
                    break;
                case ISUtil.Enum.TerritoryLanguage.TL5_XAA:
                    vPrompt = pRaidoButton.PromptTextElement[0].TL5_XAA;
                    vPrompt = string.Format("{0} List", vPrompt);
                    break;
                default:
                    vPrompt = pRaidoButton.PromptTextElement[0].Default;
                    vPrompt = string.Format("{0} List", vPrompt);
                    break;
            }
            return vPrompt;
        }

        #endregion;

        #region ----- XL Print 1 Method ----

        private void XLPrinting_1(string pOutChoice, InfoSummit.Win.ControlAdv.ISGridAdvEx pGrid)
        {// pOutChoice : 출력구분.
            object mTitle = string.Empty;
            object mCORP_NAME = string.Empty;
            object mPERIOD_DATE = string.Empty;
            object mPRINTED_DATE = string.Empty;
            object mPRINTED_BY = string.Empty;

            string vMessageText = string.Empty;
            string vSaveFileName = string.Empty;

            int vCountRow = pGrid.RowCount;

            if (vCountRow < 1)
            {
                vMessageText = string.Format("Without Data");
                isAppInterfaceAdv1.OnAppMessage(vMessageText);
                Application.DoEvents();
                return;
            }

            //파일 저장시 파일명 지정.
            if (pOutChoice == "FILE")
            {
                System.IO.DirectoryInfo vSaveFolder = new System.IO.DirectoryInfo(System.Environment.GetFolderPath(Environment.SpecialFolder.MyDocuments));
                vSaveFileName = "Employee_";

                saveFileDialog1.Title = "Excel Save";
                saveFileDialog1.FileName = vSaveFileName;
                saveFileDialog1.DefaultExt = "xls";
                if (saveFileDialog1.ShowDialog() != DialogResult.OK)
                {
                    return;
                }
                else
                {
                    vSaveFileName = saveFileDialog1.FileName;
                    System.IO.FileInfo vFileName = new System.IO.FileInfo(vSaveFileName);
                    try
                    {
                        if (vFileName.Exists)
                        {
                            vFileName.Delete();
                        }
                    }
                    catch(Exception EX)
                    {
                        MessageBoxAdv.Show(EX.Message, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                        return;
                    }
                }
            }
            vMessageText = string.Format(" Printing Starting...");
            isAppInterfaceAdv1.OnAppMessage(vMessageText);
            Application.UseWaitCursor = true;
            this.Cursor = Cursors.WaitCursor;
            Application.DoEvents();

            int vPageNumber = 0;
            //int vTerritory = GetTerritory(isAppInterfaceAdv1.AppInterface.OraConnectionInfo.TerritoryLanguage);
            
            XLPrinting xlPrinting = new XLPrinting(isAppInterfaceAdv1.AppInterface, isMessageAdapter1);
            try
            {// 폼에 있는 항목들중 기본적으로 출력해야 하는 값.
                // open해야 할 파일명 지정.
                //-------------------------------------------------------------------------------------
                xlPrinting.OpenFileNameExcel = "HRMF0212_001.xls";
                //-------------------------------------------------------------------------------------
                // 파일 오픈.
                //-------------------------------------------------------------------------------------
                bool isOpen = xlPrinting.XLFileOpen();
                //-------------------------------------------------------------------------------------

                //-------------------------------------------------------------------------------------
                if (isOpen == true)
                {
                    if (iConv.ISNull(EMPLOYE_TYPE_0.EditValue) == "1")
                    {
                        mTitle = GetPrompt(irbJOIN);
                    }
                    else if (iConv.ISNull(EMPLOYE_TYPE_0.EditValue) == "3")
                    {
                        mTitle = GetPrompt(irbRETIRE);
                    }
                    else
                    {
                        mTitle = "Non Title";
                    }

                    // 헤더 인쇄.
                    IDC_PRINTED_VALUE.ExecuteNonQuery();
                    // 실제 인쇄
                    vPageNumber = xlPrinting.ExcelWrite(mTitle, IDC_PRINTED_VALUE, pGrid);

                    //출력구분에 따른 선택(인쇄 or file 저장)
                    if (pOutChoice == "PRINT")
                    {
                        xlPrinting.Printing(1, vPageNumber);
                    }
                    else if (pOutChoice == "FILE")
                    {
                        xlPrinting.SAVE("VAT_CREDITCARD_");
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

        #region ----- isAppInterfaceAdv1_AppMainButtonClick -----
        public void isAppInterfaceAdv1_AppMainButtonClick(ISAppButtonEvents e)
        {
            if (this.IsActive)
            {
                if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Search)
                {
                    SEARCH_DB();
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddOver)
                {
                    if (idaJOIN_RETIRE.IsFocused)
                    {
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddUnder)
                {
                    if (idaJOIN_RETIRE.IsFocused)
                    {
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Update)
                {
                    if (idaJOIN_RETIRE.IsFocused)
                    {
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Cancel)
                {

                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {

                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Print)
                {
                    XLPrinting_1("PRINT", igrJOIN_RETIRE);
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Export)
                {
                    XLPrinting_1("FILE", igrJOIN_RETIRE);
                }
            }
        }
        #endregion

        #region ----- Form Event -----

        private void HRMF0212_Load(object sender, EventArgs e)
        {
            ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();
            this.Visible = true;

            START_DATE_0.EditValue = iDate.ISMonth_1st(DateTime.Today);
            END_DATE_0.EditValue = DateTime.Today;

            DefaultCorporation();
            //DefaultSetFormReSize();		//[Child Form, Mdi Form에 맞게 ReSize]
        }

        private void irbEMPLOYE_TYPE_0_CheckChanged(object sender, EventArgs e)
        {
            ISRadioButtonAdv isEMPLOYE_TYPE = sender as ISRadioButtonAdv;
            EMPLOYE_TYPE_0.EditValue = isEMPLOYE_TYPE.RadioCheckedString;

            //Refill
            SEARCH_DB();
        }
        #endregion

        #region ----- Data Adapter Event -----

        private void isDataAdapter1_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {            
        }

        private void isDataAdapter1_PreDelete(ISPreDeleteEventArgs e)
        {           
        }
        #endregion

        #region ----- Lookup Event -----

        private void ilaPOST_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            //POST
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", "POST");
            ildCOMMON.SetLookupParamValue("W_ENABLED_FLAG_YN", "Y");
        }

        private void ilaDEPT_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildDEPT.SetLookupParamValue("W_USABLE_CHECK_YN", "N");
        }

        private void ILA_FLOOR_W_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            //POST
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", "FLOOR");
            ildCOMMON.SetLookupParamValue("W_ENABLED_FLAG_YN", "Y");
        }

        private void ILA_JOB_CLASS_W_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            //POST
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", "JOB_CLASS");
            ildCOMMON.SetLookupParamValue("W_ENABLED_FLAG_YN", "Y");
        }

        private void ilaPERSON_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
        }

        private void ilaPERSON_0_SelectedRowData(object pSender)
        {
            SEARCH_DB();
        }

        #endregion

        
    }
}