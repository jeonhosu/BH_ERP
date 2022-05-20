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

namespace FCMF0886
{
    public partial class FCMF0886 : Office2007Form
    {
        #region ----- Variables -----

        private ISFunction.ISConvert iString = new ISFunction.ISConvert();
        private ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        #endregion;

        #region ----- Constructor -----

        public FCMF0886(Form pMainForm, ISAppInterface pAppInterface)
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

            idaLIST_ELEC_TAX_PUB.Fill();
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
                    if (idaLIST_ELEC_TAX_PUB.IsFocused == true)
                    {
                        bool isClosing = IS_CLOSING_YN();
                        if (isClosing == false)
                        {
                            idaLIST_ELEC_TAX_PUB.Update();

                            SearchDB();
                        }
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Cancel)
                {
                    if (idaLIST_ELEC_TAX_PUB.IsFocused == true)
                    {
                        idaLIST_ELEC_TAX_PUB.Cancel();
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
                        //사업장, 과세년도, 신고기간구분, 작성일자는 필수 입니다.
                        MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10438"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                        return;
                    }

                    int vCountRow = igrLIST_ELEC_TAX_PUB_1.RowCount;
                    if (vCountRow < 1)
                    {
                        //출력할 자료가 없습니다.
                        MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10439"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                        return;
                    }

                    XLPrinting_1("PRINT", idaLIST_ELEC_TAX_PUB);
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
                        //사업장, 과세년도, 신고기간구분, 작성일자는 필수 입니다.
                        MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10438"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                        return;
                    }

                    int vCountRow = igrLIST_ELEC_TAX_PUB_1.RowCount;
                    if (vCountRow < 1)
                    {
                        //출력할 자료가 없습니다.
                        MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10439"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                        return;
                    }

                    XLPrinting_1("FILE", idaLIST_ELEC_TAX_PUB);
                }
            }
        }

        #endregion;

        #region ----- Form Event -----

        private void FCMF0886_Load(object sender, EventArgs e)
        {
            idaLIST_ELEC_TAX_PUB.FillSchema();

            PERIOD_YEAR.EditValue = iDate.ISYear(System.DateTime.Today);

            CREATE_DATE.EditValue = System.DateTime.Today;

            CLOSING_YN.EditValue = "N";
        }
        
        private void FCMF0886_Shown(object sender, EventArgs e)
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

        private void XLPrinting_1(string pOutChoice, InfoSummit.Win.ControlAdv.ISDataAdapter p_adapter_LIST_ELEC_TAX_PUB)
        {
            string vMessageText = string.Empty;
            string vSaveFileName = string.Empty;

            if (p_adapter_LIST_ELEC_TAX_PUB.OraSelectData == null && p_adapter_LIST_ELEC_TAX_PUB.OraSelectData.Rows == null)
            {
                vMessageText = string.Format("Without Data");
                isAppInterfaceAdv1.OnAppMessage(vMessageText);
                System.Windows.Forms.Application.DoEvents();
                return;
            }

            int vCountRow = p_adapter_LIST_ELEC_TAX_PUB.OraSelectData.Rows.Count;

            if (vCountRow < 1)
            {
                vMessageText = string.Format("Without Data");
                isAppInterfaceAdv1.OnAppMessage(vMessageText);
                System.Windows.Forms.Application.DoEvents();
                return;
            }

            idaPRINT_ELEC_TAX_PUB.Fill();

            System.Windows.Forms.Application.UseWaitCursor = true;
            this.Cursor = System.Windows.Forms.Cursors.WaitCursor;
            System.Windows.Forms.Application.DoEvents();

            vMessageText = string.Format(" Printing Starting...");
            isAppInterfaceAdv1.OnAppMessage(vMessageText);
            System.Windows.Forms.Application.DoEvents();

            XLPrinting xlPrinting = new XLPrinting(isAppInterfaceAdv1.AppInterface, isMessageAdapter1);

            try
            {
                //-------------------------------------------------------------------------------------
                xlPrinting.OpenFileNameExcel = "FCMF0886_001.xls";
                //-------------------------------------------------------------------------------------

                //-------------------------------------------------------------------------------------
                bool isOpen = xlPrinting.XLFileOpen();
                //-------------------------------------------------------------------------------------

                //-------------------------------------------------------------------------------------
                if (isOpen == true)
                {
                    xlPrinting.LineWrite(p_adapter_LIST_ELEC_TAX_PUB, idaPRINT_ELEC_TAX_PUB);

                    if (pOutChoice == "PRINT")
                    {
                        xlPrinting.Printing(1, 1);
                    }
                    else if (pOutChoice == "FILE")
                    {
                        xlPrinting.SAVE("TAX_");
                    }

                    //-------------------------------------------------------------------------------------
                    xlPrinting.Dispose();
                    //-------------------------------------------------------------------------------------

                    isAppInterfaceAdv1.AppInterface.OnAppMessageEvent("Printing End");
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

        #region ----- Button Event -----

        private void CREATE_EXPORT_CONFIRM_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            object vObject1 = W_TAX_CODE.EditValue;
            object vObject2 = PERIOD_YEAR.EditValue;
            object vObject3 = VAT_REPORT_NM.EditValue;
            if (iString.ISNull(vObject1) == string.Empty || iString.ISNull(vObject2) == string.Empty || iString.ISNull(vObject3) == string.Empty)
            {
                //사업장, 과세년도, 신고기간구분은 필수 입니다.
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10366"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
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
                    idcCREATE_ELEC_TAX_PUB.ExecuteNonQuery();

                    vMessage = string.Format("{0}", idcCREATE_ELEC_TAX_PUB.GetCommandParamValue("O_MESSAGE"));
                    MessageBoxAdv.Show(vMessage, "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);

                    SearchDB();
                }
            }
            catch (System.Exception ex)
            {
                MessageBoxAdv.Show(ex.Message, "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            }
        }

        #endregion
    }
}