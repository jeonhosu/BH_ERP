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

namespace FCMF0272
{
    public partial class FCMF0272 : Office2007Form
    {
        #region ----- Variables -----

        private ISFunction.ISConvert iString = new ISFunction.ISConvert();
        private ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        #endregion;

        #region ----- Constructor -----

        public FCMF0272(Form pMainForm, ISAppInterface pAppInterface)
        {
            InitializeComponent();
            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;
        }

        #endregion;

        #region ----- Private Methods ----

        private void SearchDB_Tab_0()
        {
            object vObject1 = GL_DATE_FR_0.EditValue;
            if (iString.ISNull(vObject1) == string.Empty)
            {
                //시작일자는 필수입니다
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10010"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }

            object vObject2 = GL_DATE_TO_0.EditValue;
            if (iString.ISNull(vObject2) == string.Empty)
            {
                //종료일자는 필수입니다
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10011"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }

            if (Convert.ToDateTime(GL_DATE_FR_0.EditValue) > Convert.ToDateTime(GL_DATE_TO_0.EditValue))
            {
                //종료일은 시작일 이후이어야 합니다.
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10345"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                GL_DATE_FR_0.Focus();
                return;
            }

            object vObject3 = ACCOUNT_CODE_FR_0.EditValue;
            object vObject4 = ACCOUNT_CODE_TO_0.EditValue;
            if (iString.ISNull(vObject3) == string.Empty || iString.ISNull(vObject4) == string.Empty)
            {
                //계정과목은 필수입니다.
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10123"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }

            int vACCOUNT_CODE_FR_0 = ConvertInteger(vObject3);
            int vACCOUNT_CODE_TO_0 = ConvertInteger(vObject4);
            if (vACCOUNT_CODE_FR_0 > vACCOUNT_CODE_TO_0)
            {
                //종료계정은 시작계정 이후의 계정이어야 합니다.
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10414"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                ACCOUNT_CODE_FR_0.Focus();
                return;
            }

            idaLIST_ACCOUNT.Fill();
            igrLIST_ACCOUNT.Focus();
        }

        private void SearchDB_Tab_1()
        {
            object vObject1 = GL_DATE_FR_0.EditValue;
            if (iString.ISNull(vObject1) == string.Empty)
            {
                //시작일자는 필수입니다
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10010"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }

            object vObject2 = GL_DATE_TO_0.EditValue;
            if (iString.ISNull(vObject2) == string.Empty)
            {
                //종료일자는 필수입니다
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10011"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }

            if (Convert.ToDateTime(GL_DATE_FR_0.EditValue) > Convert.ToDateTime(GL_DATE_TO_0.EditValue))
            {
                //종료일은 시작일 이후이어야 합니다.
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10345"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                GL_DATE_FR_0.Focus();
                return;
            }

            object vObject3 = ACCOUNT_CODE_FR_0.EditValue;
            object vObject4 = ACCOUNT_CODE_TO_0.EditValue;
            if (iString.ISNull(vObject3) == string.Empty || iString.ISNull(vObject4) == string.Empty)
            {
                //계정과목은 필수입니다.
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10123"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }

            int vACCOUNT_CODE_FR_0 = ConvertInteger(vObject3);
            int vACCOUNT_CODE_TO_0 = ConvertInteger(vObject4);
            if (vACCOUNT_CODE_FR_0 > vACCOUNT_CODE_TO_0)
            {
                //종료계정은 시작계정 이후의 계정이어야 합니다.
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10414"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                ACCOUNT_CODE_FR_0.Focus();
                return;
            }

            idaLIST_GENERAL_LEDGER_ALL.Fill();
            igrLIST_GENERAL_LEDGER_ALL.Focus();
        }

        #endregion;

        #region ----- Convert decimal  Method ----

        private int ConvertInteger(object pObject)
        {
            bool vIsConvert = false;
            int vConvertInteger = 0;

            try
            {
                if (pObject != null)
                {
                    vIsConvert = pObject is string;
                    if (vIsConvert == true)
                    {
                        string vString = pObject as string;
                        vConvertInteger = int.Parse(vString);
                    }
                }

            }
            catch (System.Exception ex)
            {
                isAppInterfaceAdv1.OnAppMessage(ex.Message);
                System.Windows.Forms.Application.DoEvents();
            }

            return vConvertInteger;
        }

        #endregion;

        #region ----- XL Print 1 Method -----

        private void XLPrinting(string pOutChoice)
        {
            if (isTAB.SelectedTab.TabIndex == 1)
            {
                //계정별 인쇄
                XLPrinting_1(pOutChoice);
            }
            else if (isTAB.SelectedTab.TabIndex == 2)
            {
                //전체 인쇄
                XLPrinting_2(pOutChoice);
            }
            Application.UseWaitCursor = false;
            this.Cursor = Cursors.Default;
            Application.DoEvents();
        }

        private void XLPrinting_1(string pOutChoice)
        {
            string vMessageText = string.Empty;
            string vSaveFileName = string.Empty;

            int vCountRow = igrLIST_GENERAL_LEDGER_ACCOUNT.RowCount;
            if (vCountRow < 1)
            {
                vMessageText = string.Format("Without Data");
                isAppInterfaceAdv1.OnAppMessage(vMessageText);
                System.Windows.Forms.Application.DoEvents();
                return;
            }

            //출력구분이 파일인 경우 처리.
            if (pOutChoice == "FILE")
            {
                System.IO.DirectoryInfo vSaveFolder = new System.IO.DirectoryInfo(System.Environment.GetFolderPath(Environment.SpecialFolder.MyDocuments));
                vSaveFileName = "Account_ledger";

                saveFileDialog1.Title = "Excel Save";
                saveFileDialog1.FileName = vSaveFileName;
                saveFileDialog1.Filter = "Excel file(*.xls)|*.xls";
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
                    catch (Exception EX)
                    {
                        MessageBoxAdv.Show(EX.Message, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                        return;
                    }
                }
                vMessageText = string.Format(" Writing Starting...");
            }
            else
            {
                vMessageText = string.Format(" Printing Starting...");
            }

            System.Windows.Forms.Application.UseWaitCursor = true;
            this.Cursor = System.Windows.Forms.Cursors.WaitCursor;
            System.Windows.Forms.Application.DoEvents();

            int vPageNumber = 0;
            XLPrinting xlPrinting = new XLPrinting(isAppInterfaceAdv1.AppInterface, isMessageAdapter1);

            try
            {
                // open해야 할 파일명 지정.
                //-------------------------------------------------------------------------------------
                xlPrinting.OpenFileNameExcel = "FCMF0272_001.xls";
                //-------------------------------------------------------------------------------------
                // 파일 오픈.
                //-------------------------------------------------------------------------------------
                bool isOpen = xlPrinting.XLFileOpen();
                //-------------------------------------------------------------------------------------

                //-------------------------------------------------------------------------------------
                if (isOpen == true)
                {
                    //헤더 데이터 설정
                    IDC_DATE_FORMAT.SetCommandParamValue("P_DATE", GL_DATE_FR_0.EditValue);
                    IDC_DATE_FORMAT.ExecuteNonQuery();
                    object vDATE_FORMAT = IDC_DATE_FORMAT.GetCommandParamValue("O_DATE");
                    object vPeriod = vDATE_FORMAT;

                    IDC_DATE_FORMAT.SetCommandParamValue("P_DATE", GL_DATE_TO_0.EditValue);
                    IDC_DATE_FORMAT.ExecuteNonQuery();
                    vDATE_FORMAT = IDC_DATE_FORMAT.GetCommandParamValue("O_DATE");
                    vPeriod = String.Format("{0} ~ {1}", vPeriod, vDATE_FORMAT);

                    object vACCOUNT_CODE = igrLIST_ACCOUNT.GetCellValue("ACCOUNT_CODE");
                    object vACCOUNT_DESC = igrLIST_ACCOUNT.GetCellValue("ACCOUNT_DESC");
                    vACCOUNT_DESC = string.Format("({0}){1}", vACCOUNT_CODE, vACCOUNT_DESC);

                    //헤더 인쇄
                    xlPrinting.HeaderWrite_1(vPeriod, vACCOUNT_DESC);
                    //라인 인쇄
                    vPageNumber = xlPrinting.LineWrite_1(igrLIST_GENERAL_LEDGER_ACCOUNT);

                    //출력구분에 따른 선택(인쇄 or file 저장)
                    if (pOutChoice == "PRINT")
                    {
                        xlPrinting.Printing(1, vPageNumber);
                    }
                    else if (pOutChoice == "FILE")
                    {
                        xlPrinting.SAVE(vSaveFileName);
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

        private void XLPrinting_2(string pOutChoice)
        {
            string vMessageText = string.Empty;
            string vSaveFileName = string.Empty;

            int vCountRow = igrLIST_GENERAL_LEDGER_ALL.RowCount;
            if (vCountRow < 1)
            {
                vMessageText = string.Format("Without Data");
                isAppInterfaceAdv1.OnAppMessage(vMessageText);
                System.Windows.Forms.Application.DoEvents();
                return;
            }

            //출력구분이 파일인 경우 처리.
            if (pOutChoice == "FILE")
            {
                System.IO.DirectoryInfo vSaveFolder = new System.IO.DirectoryInfo(System.Environment.GetFolderPath(Environment.SpecialFolder.MyDocuments));
                vSaveFileName = "Account_ledger_All";

                saveFileDialog1.Title = "Excel Save";
                saveFileDialog1.FileName = vSaveFileName;
                saveFileDialog1.Filter = "Excel file(*.xls)|*.xls";
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
                    catch (Exception EX)
                    {
                        MessageBoxAdv.Show(EX.Message, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                        return;
                    }
                }
                vMessageText = string.Format(" Writing Starting...");
            }
            else
            {
                vMessageText = string.Format(" Printing Starting...");
            }

            System.Windows.Forms.Application.UseWaitCursor = true;
            this.Cursor = System.Windows.Forms.Cursors.WaitCursor;
            System.Windows.Forms.Application.DoEvents();

            int vPageNumber = 0;
            XLPrinting xlPrinting = new XLPrinting(isAppInterfaceAdv1.AppInterface, isMessageAdapter1);

            try
            {
                // open해야 할 파일명 지정.
                //-------------------------------------------------------------------------------------
                xlPrinting.OpenFileNameExcel = "FCMF0272_002.xls";
                //-------------------------------------------------------------------------------------
                // 파일 오픈.
                //-------------------------------------------------------------------------------------
                bool isOpen = xlPrinting.XLFileOpen();
                //-------------------------------------------------------------------------------------

                //-------------------------------------------------------------------------------------
                if (isOpen == true)
                {
                    //헤더 데이터 설정
                    IDC_DATE_FORMAT.SetCommandParamValue("P_DATE", GL_DATE_FR_0.EditValue);
                    IDC_DATE_FORMAT.ExecuteNonQuery();
                    object vDATE_FORMAT = IDC_DATE_FORMAT.GetCommandParamValue("O_DATE");
                    object vPeriod = vDATE_FORMAT;

                    IDC_DATE_FORMAT.SetCommandParamValue("P_DATE", GL_DATE_TO_0.EditValue);
                    IDC_DATE_FORMAT.ExecuteNonQuery();
                    vDATE_FORMAT = IDC_DATE_FORMAT.GetCommandParamValue("O_DATE");
                    vPeriod = String.Format("{0} ~ {1}", vPeriod, vDATE_FORMAT);

                    //헤더 인쇄
                    xlPrinting.HeaderWrite_2(vPeriod);
                    //라인 인쇄
                    vPageNumber = xlPrinting.LineWrite_2(igrLIST_GENERAL_LEDGER_ALL);

                    //출력구분에 따른 선택(인쇄 or file 저장)
                    if (pOutChoice == "PRINT")
                    {
                        xlPrinting.Printing(1, vPageNumber);
                    }
                    else if (pOutChoice == "FILE")
                    {
                        xlPrinting.SAVE(vSaveFileName);
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

        #region ----- MDi ToolBar Button Event -----

        private void isAppInterfaceAdv1_AppMainButtonClick(ISAppButtonEvents e)
        {
            if (this.IsActive)
            {
                if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Search)
                {
                    int vIndexTAB = isTAB.SelectedIndex;

                    if (vIndexTAB == 0)
                    {
                        SearchDB_Tab_0();
                    }
                    else if (vIndexTAB == 1)
                    {
                        SearchDB_Tab_1();
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
                    if (idaLIST_ACCOUNT.IsFocused == true)
                    {
                        idaLIST_ACCOUNT.Cancel();
                    }
                    else if (idaLIST_GENERAL_LEDGER_ACCOUNT.IsFocused == true)
                    {
                        idaLIST_GENERAL_LEDGER_ACCOUNT.Cancel();
                    }
                    else if (idaLIST_GENERAL_LEDGER_ALL.IsFocused == true)
                    {
                        idaLIST_GENERAL_LEDGER_ALL.Cancel();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {

                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Print)
                {
                    XLPrinting("PRINT");
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Export)
                {
                    XLPrinting("FILE");
                }
            }
        }

        #endregion;

        #region ----- Form Event -----

        private void FCMF0272_Load(object sender, EventArgs e)
        {
            GL_DATE_FR_0.EditValue = System.DateTime.Today;
            GL_DATE_TO_0.EditValue = System.DateTime.Today;
        }
        
        private void FCMF0272_Shown(object sender, EventArgs e)
        {

        }

        #endregion

        #region ----- Adapter Event -----

        private void idaLIST_ACCOUNT_NewRowMoved(object pSender, ISBindingEventArgs pBindingManager)
        {
            int vCountRow = 0;
            try
            {
                if (idaLIST_ACCOUNT.OraSelectData.Rows != null)
                {
                    vCountRow = idaLIST_ACCOUNT.OraSelectData.Rows.Count;
                }

                if (vCountRow > 0)
                {
                    idaLIST_GENERAL_LEDGER_ACCOUNT.Fill();
                }
                else
                {
                    igrLIST_GENERAL_LEDGER_ACCOUNT.RowCount = 0;
                }
            }
            catch (System.Exception ex)
            {
                MessageBoxAdv.Show(ex.Message);
            }
        }

        #endregion

        #region ----- Grid Event -----

        private void igrLIST_GENERAL_LEDGER_ACCOUNT_CellDoubleClick(object pSender)
        {
            if (igrLIST_GENERAL_LEDGER_ACCOUNT.RowIndex > -1)
            {
                int vSLIP_HEADER_ID = iString.ISNumtoZero(igrLIST_GENERAL_LEDGER_ACCOUNT.GetCellValue("SLIP_HEADER_ID"));
                if (vSLIP_HEADER_ID > Convert.ToInt32(0))
                {
                    System.Windows.Forms.Application.UseWaitCursor = true;
                    this.Cursor = System.Windows.Forms.Cursors.WaitCursor;

                    FCMF0205.FCMF0205 vFCMF0205 = new FCMF0205.FCMF0205(this.MdiParent, isAppInterfaceAdv1.AppInterface, vSLIP_HEADER_ID);
                    vFCMF0205.Show();

                    this.Cursor = System.Windows.Forms.Cursors.Default;
                    System.Windows.Forms.Application.UseWaitCursor = false;
                }
            }
        }

        private void igrLIST_GENERAL_LEDGER_ALL_CellDoubleClick(object pSender)
        {
            if (igrLIST_GENERAL_LEDGER_ALL.RowIndex > -1)
            {
                int vSLIP_HEADER_ID = iString.ISNumtoZero(igrLIST_GENERAL_LEDGER_ALL.GetCellValue("SLIP_HEADER_ID"));
                if (vSLIP_HEADER_ID > Convert.ToInt32(0))
                {
                    System.Windows.Forms.Application.UseWaitCursor = true;
                    this.Cursor = System.Windows.Forms.Cursors.WaitCursor;

                    FCMF0205.FCMF0205 vFCMF0205 = new FCMF0205.FCMF0205(this.MdiParent, isAppInterfaceAdv1.AppInterface, vSLIP_HEADER_ID);
                    vFCMF0205.Show();

                    this.Cursor = System.Windows.Forms.Cursors.Default;
                    System.Windows.Forms.Application.UseWaitCursor = false;
                }
            }
        }

        #endregion

        #region ----- Lookup Event -----

        private void ilaACCOUNT_CODE_FR_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildACCOUNT_CONTROL_0.SetLookupParamValue("W_ACCOUNT_SET_ID", null);
            ildACCOUNT_CONTROL_0.SetLookupParamValue("W_ACCOUNT_CODE", null);
        }

        private void ilaACCOUNT_CODE_TO_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildACCOUNT_CONTROL_0.SetLookupParamValue("W_ACCOUNT_SET_ID", null);
            ildACCOUNT_CONTROL_0.SetLookupParamValue("W_ACCOUNT_CODE", ACCOUNT_CODE_FR_0.EditValue);
        }

        #endregion
    }
}