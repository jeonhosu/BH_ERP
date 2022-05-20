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

namespace FCMF0875
{
    public partial class FCMF0875 : Office2007Form
    {
        #region ----- Variables -----

        private ISFunction.ISConvert iString = new ISFunction.ISConvert();
        private ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        #endregion;

        #region ----- Constructor -----

        public FCMF0875(Form pMainForm, ISAppInterface pAppInterface)
        {
            InitializeComponent();
            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;
        }

        #endregion;

        #region ----- Private Methods ----

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

            idaUP_EXPORT_RESULT.Fill();
            idaLIST_EXPORT_RESULT.Fill();
            igrUP_EXPORT_RESULT.Focus();
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
                    if (idaUP_EXPORT_RESULT.IsFocused == true)
                    {
                        idaUP_EXPORT_RESULT.Cancel();
                    }
                    else if (idaLIST_EXPORT_RESULT.IsFocused == true)
                    {
                        idaLIST_EXPORT_RESULT.Cancel();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {

                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Print)
                {
                    object vObject1 = W_TAX_DESC.EditValue;
                    object vObject2 = PERIOD_YEAR.EditValue;
                    object vObject3 = VAT_REPORT_NM.EditValue;
                    object vObject4 = CREATE_DATE.EditValue;
                    object vObject5 = DEAL_DATE_FR.EditValue;
                    object vObject6 = DEAL_DATE_TO.EditValue;
                    if (iString.ISNull(vObject1) == string.Empty || iString.ISNull(vObject2) == string.Empty || iString.ISNull(vObject3) == string.Empty || iString.ISNull(vObject4) == string.Empty || iString.ISNull(vObject5) == string.Empty || iString.ISNull(vObject6) == string.Empty)
                    {
                        //사업장, 과세년도, 신고기간구분, 작성일자, 거래기간은 필수 입니다.
                        MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10368"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                        return;
                    }

                    XLPrinting_1("PRINT", igrUP_EXPORT_RESULT, igrLIST_EXPORT_RESULT);
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Export)
                {
                    object vObject1 = W_TAX_DESC.EditValue;
                    object vObject2 = PERIOD_YEAR.EditValue;
                    object vObject3 = VAT_REPORT_NM.EditValue;
                    object vObject4 = CREATE_DATE.EditValue;
                    object vObject5 = DEAL_DATE_FR.EditValue;
                    object vObject6 = DEAL_DATE_TO.EditValue;
                    if (iString.ISNull(vObject1) == string.Empty || iString.ISNull(vObject2) == string.Empty || iString.ISNull(vObject3) == string.Empty || iString.ISNull(vObject4) == string.Empty || iString.ISNull(vObject5) == string.Empty || iString.ISNull(vObject6) == string.Empty)
                    {
                        //사업장, 과세년도, 신고기간구분, 작성일자, 거래기간은 필수 입니다.
                        MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10368"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                        return;
                    }

                    XLPrinting_1("FILE", igrUP_EXPORT_RESULT, igrLIST_EXPORT_RESULT);
                }
            }
        }

        #endregion;

        #region ----- Form Event -----

        private void FCMF0875_Load(object sender, EventArgs e)
        {
            idaUP_EXPORT_RESULT.FillSchema();

            PERIOD_YEAR.EditValue = iDate.ISYear(System.DateTime.Today);

            CREATE_DATE.EditValue = System.DateTime.Today;

            CLOSING_YN.EditValue = "N";
        }
        
        private void FCMF0875_Shown(object sender, EventArgs e)
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
            ildPOP_VAT_REPORT_MNG.SetLookupParamValue("W_OPERATING_UNIT_ID", 42);
        }

        #endregion

        #region ----- Grid Event -----

        private void igrZERO_TAX_SPEC_CurrentCellAcceptedChanges(object pSender, ISGridAdvExChangedEventArgs e)
        {
            InfoSummit.Win.ControlAdv.ISGridAdvEx vGrid = pSender as InfoSummit.Win.ControlAdv.ISGridAdvEx;

            int vIndexColunm = vGrid.GetColumnToIndex("PUBLISH_DATE");

            if (e.ColIndex == vIndexColunm)
            {
                object vObject = vGrid.GetCellValue("PUBLISH_DATE");
                vGrid.SetCellValue("SHIPPING_DATE", vObject);
            }
        }

        #endregion

        #region ----- XL Print 1 Method ----

        private void XLPrinting_1(string pOutChoice, InfoSummit.Win.ControlAdv.ISGridAdvEx p_grid_UP_EXPORT_RESULT, InfoSummit.Win.ControlAdv.ISGridAdvEx p_grid_LIST_EXPORT_RESULT)
        {
            string vMessageText = string.Empty;
            string vSaveFileName = string.Empty;

            int vCountRow = p_grid_UP_EXPORT_RESULT.RowCount;

            if (vCountRow < 1)
            {
                vMessageText = string.Format("Without Data");
                isAppInterfaceAdv1.OnAppMessage(vMessageText);
                System.Windows.Forms.Application.DoEvents();
                return;
            }

            idaPRINT_EXPORT_RESULT_TITLE.Fill();

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
                //-------------------------------------------------------------------------------------
                xlPrinting.OpenFileNameExcel = "FCMF0875_001.xls";
                //-------------------------------------------------------------------------------------

                //-------------------------------------------------------------------------------------
                bool isOpen = xlPrinting.XLFileOpen();
                //-------------------------------------------------------------------------------------

                //-------------------------------------------------------------------------------------
                if (isOpen == true)
                {
                    vPageNumber = xlPrinting.LineWrite(p_grid_UP_EXPORT_RESULT, p_grid_LIST_EXPORT_RESULT, idaPRINT_EXPORT_RESULT_TITLE);

                    if (pOutChoice == "PRINT")
                    {
                        xlPrinting.Printing(1, vPageNumber);
                    }
                    else if (pOutChoice == "FILE")
                    {
                        xlPrinting.SAVE("TAX_");
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