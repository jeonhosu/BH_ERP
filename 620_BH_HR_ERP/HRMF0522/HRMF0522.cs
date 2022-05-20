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

namespace HRMF0522
{
    public partial class HRMF0522 : Office2007Form
    {
        #region ----- Variables -----

        ISFunction.ISConvert iString = new ISFunction.ISConvert();
        ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        #endregion;

        #region ----- Constructor -----

        public HRMF0522()
        {
            InitializeComponent();
        }

        public HRMF0522(Form pMainForm, ISAppInterface pAppInterface)
        {
            InitializeComponent();
            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;
        }

        #endregion;

        #region ----- Private Methods ----

        private void SearchDB()
        {
            // 명세서 발급
            if (iString.ISNull(iedCORP_ID_0.EditValue) == string.Empty)
            {// 업체 구분
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10001"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                iedCORP_NAME_0.Focus();
                return;
            }
            if (iString.ISNull(iedPAY_YYYYMM.EditValue) == string.Empty)
            {// 지급일자
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10107"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                iedPAY_YYYYMM.Focus();
                return;
            }            
            if (iString.ISNull(iedWAGE_TYPE.EditValue) == string.Empty)
            {// 급상여 선택 
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10105"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                iedWAGE_TYPE_NAME.Focus();
                return;
            }
            
            // 그리드 부분 업데이트 처리
            idaMONTH_PAYMENT.OraSelectData.AcceptChanges();
            idaMONTH_PAYMENT.Refillable = true;

            idaMONTH_PAYMENT.Fill();
            //idaALLOWANCE_INFO.Fill();
            //idaDEDUCTION_INFO.Fill();
            //idaDUTY_INFO.Fill();
        }

        #endregion;

        // 인쇄 부분
        // Print 관련 소스 코드 2011.1.15(토)
        // Print 관련 소스 코드 2011.5.11(수) 수정
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

        #region ----- XL Print 1 Method ----

        private void XLPrinting_1(string pCourse)
        {
            System.DateTime vStartTime = DateTime.Now;
            string vSaveFileName = string.Empty;

            //print type 설정
            DialogResult vdlgResult;
            HRMF0522_PRINT_TYPE vHRMF0522_PRINT_TYPE = new HRMF0522_PRINT_TYPE(isAppInterfaceAdv1.AppInterface);
            vdlgResult = vHRMF0522_PRINT_TYPE.ShowDialog();
            if (vdlgResult == DialogResult.Cancel)
            {
                return;
            }
            string vPRINT_TYPE = iString.ISNull(vHRMF0522_PRINT_TYPE.Get_Printer_Type);
            if (vPRINT_TYPE == string.Empty)
            {
                return;
            }
            vHRMF0522_PRINT_TYPE.Dispose();


            if (vPRINT_TYPE == "PDF")
            {
                SaveFileDialog vSaveFileDialog = new SaveFileDialog();
                vSaveFileDialog.RestoreDirectory = true;
                vSaveFileDialog.Filter = "pdf file(*.pdf)|*.pdf";
                vSaveFileDialog.DefaultExt = "pdf";

                if (vSaveFileDialog.ShowDialog() == DialogResult.OK)
                {
                    vSaveFileName = vSaveFileDialog.FileName;
                }
            }
            pCourse = vPRINT_TYPE;

            string vMessageText = string.Empty;

            string vBoxCheck = string.Empty;
            string vWAGE_TYPE = string.Empty;
            string vPAY_TYPE = string.Empty;

            int vCountCheck = 0;

            object vObject = null;

            int vCountRow = igrMONTH_PAYMENT.RowCount;

            if (vCountRow < 1)
            {
                vMessageText = string.Format("Without Data");
                isAppInterfaceAdv1.OnAppMessage(vMessageText);
                System.Windows.Forms.Application.DoEvents();
                return;
            }

            int vIndexWAGE_TYPE = igrMONTH_PAYMENT.GetColumnToIndex("WAGE_TYPE");
            int vIndexPAY_TYPE = igrMONTH_PAYMENT.GetColumnToIndex("PAY_TYPE");

            int vIndexCheckBox = igrMONTH_PAYMENT.GetColumnToIndex("SELECT_CHECK_YN");
            string vCheckedString = igrMONTH_PAYMENT.GridAdvExColElement[vIndexCheckBox].CheckedString;
            //-------------------------------------------------------------------------------------
            for (int vRow = 0; vRow < vCountRow; vRow++)
            {
                vObject = igrMONTH_PAYMENT.GetCellValue(vRow, vIndexCheckBox);
                vBoxCheck = ConvertString(vObject);
                if (vBoxCheck == vCheckedString)
                {
                    vCountCheck++;
                }
            }

            if (vCountCheck < 1)
            {
                vMessageText = string.Format("Not Select");
                isAppInterfaceAdv1.OnAppMessage(vMessageText);
                System.Windows.Forms.Application.DoEvents();
                return;
            }
            //-------------------------------------------------------------------------------------

            this.Cursor = System.Windows.Forms.Cursors.WaitCursor;
            igbCONDITION.Cursor = System.Windows.Forms.Cursors.WaitCursor;
            System.Windows.Forms.Application.DoEvents();

            int vPageNumber = 0;

            vMessageText = string.Format(" Printing Starting...");
            isAppInterfaceAdv1.OnAppMessage(vMessageText);
            System.Windows.Forms.Application.DoEvents();

            XLPrinting xlPrinting = new XLPrinting(isAppInterfaceAdv1.AppInterface, isMessageAdapter1);

            try
            {
                //-------------------------------------------------------------------------------------
                xlPrinting.OpenFileNameExcel = "HRMF0522_001.xls";
                //-------------------------------------------------------------------------------------

                vPageNumber = xlPrinting.WriteMain(pCourse, igrMONTH_PAYMENT, idaPAY_ALLOWANCE, idaPAY_DEDUCTION, idaDUTY_INFO, idaBONUS_ALLOWANCE, idaBONUS_DEDUCTION, icb_SEAL_FLAG.CheckBoxString , vSaveFileName);
            }
            catch (System.Exception ex)
            {
                vMessageText = ex.Message;
                isAppInterfaceAdv1.AppInterface.OnAppMessageEvent(vMessageText);
                System.Windows.Forms.Application.DoEvents();
            }
            //-------------------------------------------------------------------------------------
            xlPrinting.Dispose();
            //-------------------------------------------------------------------------------------

            System.DateTime vEndTime = DateTime.Now;
            System.TimeSpan vTimeSpan = vEndTime - vStartTime;

            vMessageText = string.Format("Printing End [Total Page : {0}] ---> {1}", vPageNumber, vTimeSpan.ToString());
            isAppInterfaceAdv1.AppInterface.OnAppMessageEvent(vMessageText);
            System.Windows.Forms.Application.DoEvents();

            this.Cursor = System.Windows.Forms.Cursors.Default;
            igbCONDITION.Cursor = System.Windows.Forms.Cursors.Default;
            System.Windows.Forms.Application.DoEvents();
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
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Cancel)
                {
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Print)
                {
                    XLPrinting_1(""); // 출력 함수 호출

                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10035"), "", MessageBoxButtons.OK, MessageBoxIcon.None);
                    // 인쇄 완료 메시지 출력
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Export)
                {
                    XLPrinting_1("FILE"); // 출력 함수 호출
                }
            }
        }

        #endregion;

        #region ----- Form Event ------

        private void HRMF0522_Load(object sender, EventArgs e)
        {
            // Lookup SETTING
            ildCORP.SetLookupParamValue("W_PAY_CONTROL_YN", "Y");
            ildCORP.SetLookupParamValue("W_ENABLED_FLAG_YN", "N");

            // LOOKUP DEFAULT VALUE SETTING - CORP
            idcDEFAULT_CORP.SetCommandParamValue("W_PAY_CONTROL_YN", "Y");
            idcDEFAULT_CORP.SetCommandParamValue("W_ENABLED_FLAG_YN", "N");
            idcDEFAULT_CORP.ExecuteNonQuery();

            iedCORP_NAME_0.EditValue = idcDEFAULT_CORP.GetCommandParamValue("O_CORP_NAME");
            iedCORP_ID_0.EditValue = idcDEFAULT_CORP.GetCommandParamValue("O_CORP_ID");

            iedPAY_YYYYMM.EditValue = iDate.ISYearMonth(DateTime.Today);
            iedPAY_YYYYMM_TO.EditValue = iDate.ISYearMonth(DateTime.Today);
            iedSTART_DATE.EditValue = iDate.ISMonth_1st(DateTime.Today);
            iedEND_DATE.EditValue = iDate.ISMonth_Last(DateTime.Today);

            // 그리드 부분 업데이트 처리 위함.
            idaMONTH_PAYMENT.FillSchema();

            isAppInterfaceAdv1.OnAppMessage("");
        }

        // 전체선택 버튼
        private void btnSELECT_ALL_0_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            for (int i = 0; i < igrMONTH_PAYMENT.RowCount; i++)
            {
                igrMONTH_PAYMENT.SetCellValue(i, igrMONTH_PAYMENT.GetColumnToIndex("SELECT_CHECK_YN"), "Y");
            }
            idaMONTH_PAYMENT.OraSelectData.AcceptChanges();
            idaMONTH_PAYMENT.Refillable = true;

            string vMessageText = string.Format("Select Row [{0}]", igrMONTH_PAYMENT.RowCount);
            isAppInterfaceAdv1.OnAppMessage(vMessageText);
            System.Windows.Forms.Application.DoEvents();
        }

        // 취소 버튼
        private void btnCONFIRM_CANCEL_0_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            for (int i = 0; i < igrMONTH_PAYMENT.RowCount; i++)
            {
                igrMONTH_PAYMENT.SetCellValue(i, igrMONTH_PAYMENT.GetColumnToIndex("SELECT_CHECK_YN"), "N");
            }            
            idaMONTH_PAYMENT.OraSelectData.AcceptChanges();
            idaMONTH_PAYMENT.Refillable = true;

            isAppInterfaceAdv1.OnAppMessage("Select Row [0]");
            System.Windows.Forms.Application.DoEvents();
        }

        #endregion

        #region ----- Lookup Event ----- 

        private void ilaPAY_TYPE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", "PAY_TYPE");
            ildCOMMON.SetLookupParamValue("W_ENABLED_FLAG_YN", "Y");
        }

        private void ilaWAGE_TYPE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCOMMON_W.SetLookupParamValue("W_GROUP_CODE", "CLOSING_TYPE");
            ildCOMMON_W.SetLookupParamValue("W_WHERE", "VALUE1 = 'PAY' ");
            ildCOMMON_W.SetLookupParamValue("W_ENABLED_FLAG_YN", "Y");
        }

        private void ilaYYYYMM_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildYYYYMM.SetLookupParamValue("W_START_YYYYMM", "2001-01");
            ildYYYYMM.SetLookupParamValue("W_END_YYYYMM", iDate.ISYearMonth(iDate.ISDate_Month_Add(DateTime.Today, 2)));
        }

        private void ilaDEPT_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildDEPT.SetLookupParamValue("W_USABLE_CHECK_YN", "Y");
        }

        #endregion

        private void igbCONDITION_Paint(object sender, PaintEventArgs e)
        {

        }
    }
}