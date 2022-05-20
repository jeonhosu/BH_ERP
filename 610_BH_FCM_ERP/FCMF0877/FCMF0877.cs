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

namespace FCMF0877
{
    public partial class FCMF0877 : Office2007Form
    {
        #region ----- Variables -----

        private ISFunction.ISConvert iString = new ISFunction.ISConvert();
        private ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        #endregion;

        #region ----- Constructor -----

        public FCMF0877(Form pMainForm, ISAppInterface pAppInterface)
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

            idaUP_AR_SUM_VAT_TAX.Fill();

            idaLIST_AR_SUM_VAT_TAX_1.SetSelectParamValue("ELEC_TAX_YN", "Y");
            idaLIST_AR_SUM_VAT_TAX_1.Fill();

            idaLIST_AR_SUM_VAT_TAX_2.SetSelectParamValue("ELEC_TAX_YN", "N");
            idaLIST_AR_SUM_VAT_TAX_2.Fill();

            igrUP_AR_SUM_VAT_TAX.Focus();
        }

        private void SetCommonParameter(object pGroup_Code, object pEnabled_YN)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", pGroup_Code);
            ildCOMMON.SetLookupParamValue("W_ENABLED_YN", pEnabled_YN);
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
                    if (idaUP_AR_SUM_VAT_TAX.IsFocused == true)
                    {
                        idaUP_AR_SUM_VAT_TAX.Cancel();
                    }
                    else if (idaLIST_AR_SUM_VAT_TAX_1.IsFocused == true)
                    {
                        idaLIST_AR_SUM_VAT_TAX_1.Cancel();
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

                    XLPrinting_1("PRINT", igrUP_AR_SUM_VAT_TAX, igrLIST_AR_SUM_VAT_TAX_2);
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

                    XLPrinting_1("FILE", igrUP_AR_SUM_VAT_TAX, igrLIST_AR_SUM_VAT_TAX_2);
                }
            }
        }

        #endregion;

        #region ----- Form Event -----

        private void FCMF0877_Load(object sender, EventArgs e)
        {
            idaUP_AR_SUM_VAT_TAX.FillSchema();

            PERIOD_YEAR.EditValue = iDate.ISYear(System.DateTime.Today);

            CREATE_DATE.EditValue = System.DateTime.Today;
        }
        
        private void FCMF0877_Shown(object sender, EventArgs e)
        {
            IDC_SET_TAX_CODE.ExecuteNonQuery();
            W_TAX_DESC.EditValue = IDC_SET_TAX_CODE.GetCommandParamValue("O_TAX_DESC");
            W_TAX_CODE.EditValue = IDC_SET_TAX_CODE.GetCommandParamValue("O_TAX_CODE");

            idcVAT_CLASS_0.SetCommandParamValue("W_GROUP_CODE", "VAT_CLASS");
            idcVAT_CLASS_0.ExecuteNonQuery();
            VAT_CLASS_NAME_0.EditValue = idcVAT_CLASS_0.GetCommandParamValue("O_CODE_NAME");
            VAT_CLASS_CODE_0.EditValue = idcVAT_CLASS_0.GetCommandParamValue("O_CODE");
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

        private void ilaVAT_CLASS_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter("VAT_CLASS", "Y");
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

        private void XLPrinting_1(string pOutChoice, InfoSummit.Win.ControlAdv.ISGridAdvEx p_grid_UP_AR_SUM_VAT_TAX, InfoSummit.Win.ControlAdv.ISGridAdvEx p_grid_LIST_AR_SUM_VAT_TAX_2)
        {
            string vMessageText = string.Empty;
            string vSaveFileName = string.Empty;

            int vCountRow = p_grid_UP_AR_SUM_VAT_TAX.RowCount;

            if (vCountRow < 1)
            {
                vMessageText = string.Format("Without Data");
                isAppInterfaceAdv1.OnAppMessage(vMessageText);
                System.Windows.Forms.Application.DoEvents();
                return;
            }

            idaPRINT_SUM_VAT_TAX_TITLE.Fill();

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
                xlPrinting.OpenFileNameExcel = "FCMF0877_001.xls";
                //-------------------------------------------------------------------------------------

                //-------------------------------------------------------------------------------------
                bool isOpen = xlPrinting.XLFileOpen();
                //-------------------------------------------------------------------------------------

                //-------------------------------------------------------------------------------------
                if (isOpen == true)
                {
                    vPageNumber = xlPrinting.LineWrite(p_grid_UP_AR_SUM_VAT_TAX, p_grid_LIST_AR_SUM_VAT_TAX_2, idaPRINT_SUM_VAT_TAX_TITLE);

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