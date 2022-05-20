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

namespace FCMF0885
{
    public partial class FCMF0885 : Office2007Form
    {
        #region ----- Variables -----

        private ISFunction.ISConvert iString = new ISFunction.ISConvert();
        private ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        #endregion;

        #region ----- Constructor -----

        public FCMF0885(Form pMainForm, ISAppInterface pAppInterface)
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

            idaLIST_FOREIGN_CURRENCY_SPEC.Fill();
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

        private bool IS_INSERT_ABLE()
        {
            bool isInsert = true;

            object vObject1 = W_TAX_DESC.EditValue;
            object vObject2 = PERIOD_YEAR.EditValue;
            object vObject3 = VAT_REPORT_NM.EditValue;
            if (iString.ISNull(vObject1) == string.Empty || iString.ISNull(vObject2) == string.Empty || iString.ISNull(vObject3) == string.Empty)
            {
                isInsert = false;
                //사업장, 과세년도, 신고기간구분은 필수 입니다.
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10366"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            }

            return isInsert;
        }

        private void DefaultValueInsert()
        {
            igrLIST_FOREIGN_CURRENCY_SPEC.SetCellValue("GUBUN_ITEM", "Y");
            igrLIST_FOREIGN_CURRENCY_SPEC.SetCellValue("UNIT", "PCS");
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
                    if (idaLIST_FOREIGN_CURRENCY_SPEC.IsFocused == true)
                    {
                        bool isClosing = IS_CLOSING_YN();
                        if (isClosing == false)
                        {
                            bool isInsert = IS_INSERT_ABLE();
                            if (isInsert == true)
                            {
                                idaLIST_FOREIGN_CURRENCY_SPEC.AddOver();
                                DefaultValueInsert();
                            }
                        }
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddUnder)
                {
                    if (idaLIST_FOREIGN_CURRENCY_SPEC.IsFocused == true)
                    {
                        bool isClosing = IS_CLOSING_YN();
                        if (isClosing == false)
                        {
                            bool isInsert = IS_INSERT_ABLE();
                            if (isInsert == true)
                            {
                                idaLIST_FOREIGN_CURRENCY_SPEC.AddUnder();
                                DefaultValueInsert();
                            }
                        }
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Update)
                {
                    if (idaLIST_FOREIGN_CURRENCY_SPEC.IsFocused == true)
                    {
                        bool isClosing = IS_CLOSING_YN();
                        if (isClosing == false)
                        {
                            idaLIST_FOREIGN_CURRENCY_SPEC.Update();
                        }
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Cancel)
                {
                    if (idaLIST_FOREIGN_CURRENCY_SPEC.IsFocused == true)
                    {
                        idaLIST_FOREIGN_CURRENCY_SPEC.Cancel();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {
                    if (idaLIST_FOREIGN_CURRENCY_SPEC.IsFocused == true)
                    {
                        bool isClosing = IS_CLOSING_YN();
                        if (isClosing == false)
                        {
                            idaLIST_FOREIGN_CURRENCY_SPEC.Delete();
                        }
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Print)
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

                    XLPrinting_1("PRINT", igrLIST_FOREIGN_CURRENCY_SPEC);
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Export)
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

                    XLPrinting_1("FILE", igrLIST_FOREIGN_CURRENCY_SPEC);
                }
            }
        }

        #endregion;

        #region ----- Form Event -----

        private void FCMF0885_Load(object sender, EventArgs e)
        {
            idaLIST_FOREIGN_CURRENCY_SPEC.FillSchema();

            PERIOD_YEAR.EditValue = iDate.ISYear(System.DateTime.Today);
        }
        
        private void FCMF0885_Shown(object sender, EventArgs e)
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

        private void XLPrinting_1(string pOutChoice, InfoSummit.Win.ControlAdv.ISGridAdvEx p_grid_LIST_EXPORT_CONFIRM)
        {
            string vMessageText = string.Empty;
            string vSaveFileName = string.Empty;

            int vCountRow = p_grid_LIST_EXPORT_CONFIRM.RowCount;

            if (vCountRow < 1)
            {
                vMessageText = string.Format("Without Data");
                isAppInterfaceAdv1.OnAppMessage(vMessageText);
                System.Windows.Forms.Application.DoEvents();
                return;
            }

            idaPRINT_FOREIGN_CURRENCY_SPEC.Fill();

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
                xlPrinting.OpenFileNameExcel = "FCMF0885_001.xls";
                //-------------------------------------------------------------------------------------

                //-------------------------------------------------------------------------------------
                bool isOpen = xlPrinting.XLFileOpen();
                //-------------------------------------------------------------------------------------

                //-------------------------------------------------------------------------------------
                if (isOpen == true)
                {
                    vPageNumber = xlPrinting.LineWrite(p_grid_LIST_EXPORT_CONFIRM, idaPRINT_FOREIGN_CURRENCY_SPEC);

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

        #region ----- Grid Event -----

        private void CREATE_EXPORT_CONFIRM_ButtonClick(object pSender, EventArgs pEventArgs)
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

            object vObject_CLOSING_YN = CLOSING_YN.EditValue;
            string vClosingYN = ConvertString(vObject_CLOSING_YN);
            if (vClosingYN == "Y")
            {
                //해당 신고기간의 자료는 마감되어 변경할 수 없습니다.
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10365"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
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
                    idcCREATE_FOREIGN_CURRENCY_SPEC.ExecuteNonQuery();

                    //해당 작업을 정상적으로 처리 완료하였습니다.
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10112"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);

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