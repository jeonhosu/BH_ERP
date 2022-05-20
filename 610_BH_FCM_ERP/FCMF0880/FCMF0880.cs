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

namespace FCMF0880
{
    public partial class FCMF0880 : Office2007Form
    {
        #region ----- Variables -----

        private ISFunction.ISConvert iConv = new ISFunction.ISConvert();
        private ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        #endregion;

        #region ----- Constructor -----

        public FCMF0880(Form pMainForm, ISAppInterface pAppInterface)
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
            object vObject2 = W_PERIOD_YEAR.EditValue;
            object vObject3 = W_VAT_REPORT_NM.EditValue;
            if (iConv.ISNull(vObject1) == string.Empty || iConv.ISNull(vObject2) == string.Empty || iConv.ISNull(vObject3) == string.Empty)
            {
                //사업장, 과세년도, 신고기간구분은 필수 입니다.
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10366"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }

            idaLIST_NO_DEDUCTION.Fill();
            idaSUM_NO_DEDUCTION.Fill();
            igrLIST_NO_DEDUCTION.Focus();
        }

        private void SetCommonParameter(object pGroup_Code, object pEnabled_YN)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", pGroup_Code);
            ildCOMMON.SetLookupParamValue("W_ENABLED_YN", pEnabled_YN);
        }

        private void Set_GRID_STATUS_ROW()
        {
            if (igrSUM_NO_DEDUCTION.RowCount < 1)
            {
                return;
            }
            int vSTATUS = 0;                // INSERTABLE, UPDATABLE;

            int vROW = igrSUM_NO_DEDUCTION.RowIndex;
            object vNO_DED_CODE = igrSUM_NO_DEDUCTION.GetCellValue("NO_DED_CODE");
            int vIDX_GL_AMOUNT = igrSUM_NO_DEDUCTION.GetColumnToIndex("GL_AMOUNT");
            int vIDX_VAT_AMOUNT = igrSUM_NO_DEDUCTION.GetColumnToIndex("VAT_AMOUNT");

            if (iConv.ISNull(vNO_DED_CODE) == "990")
            {
                vSTATUS = 0;
            }
            else
            {
                vSTATUS = 1;
            }

            igrSUM_NO_DEDUCTION.GridAdvExColElement[vIDX_GL_AMOUNT].Insertable = vSTATUS;
            igrSUM_NO_DEDUCTION.GridAdvExColElement[vIDX_GL_AMOUNT].Updatable = vSTATUS;

            igrSUM_NO_DEDUCTION.GridAdvExColElement[vIDX_VAT_AMOUNT].Insertable = vSTATUS;
            igrSUM_NO_DEDUCTION.GridAdvExColElement[vIDX_VAT_AMOUNT].Updatable = vSTATUS;
        }

        private void SHOW_ADJUST_3()
        {
            FCMF0880_3 vFCMF0880_3 = new FCMF0880_3(this.MdiParent, isAppInterfaceAdv1.AppInterface
                                                    , W_TAX_DESC.EditValue, W_TAX_CODE.EditValue
                                                    , W_VAT_REPORT_NM.EditValue
                                                    , W_DEAL_DATE_FR.EditValue, W_DEAL_DATE_TO.EditValue
                                                    , igrSUM_NO_DEDUCTION.GetCellValue("NO_DED_TYPE")
                                                    , igrSUM_NO_DEDUCTION.GetCellValue("NO_DED_DESC")
                                                    , igrSUM_NO_DEDUCTION.GetCellValue("NO_DED_CODE"));
            vFCMF0880_3.ShowDialog();
            if (iConv.ISNull(vFCMF0880_3.Get_Save_Flag) == "SAVE")
            {
                IDC_GET_ADJUST_AMOUNT.SetCommandParamValue("P_NO_DED_TYPE", igrSUM_NO_DEDUCTION.GetCellValue("NO_DED_TYPE"));
                IDC_GET_ADJUST_AMOUNT.SetCommandParamValue("P_NO_DED_CODE", igrSUM_NO_DEDUCTION.GetCellValue("NO_DED_CODE"));
                IDC_GET_ADJUST_AMOUNT.SetCommandParamValue("P_ADJUST_TYPE", "3");
                IDC_GET_ADJUST_AMOUNT.ExecuteNonQuery();
                decimal vADJUST_AMOUNT = iConv.ISDecimaltoZero(IDC_GET_ADJUST_AMOUNT.GetCommandParamValue("O_ADJUST_AMOUNT"));
                if(IDC_GET_ADJUST_AMOUNT.ExcuteError)
                {
                    vADJUST_AMOUNT = 0;
                }

                decimal vVAT_RATE = 0.1M;
                decimal vVAT_AMOUNT = Math.Truncate(vADJUST_AMOUNT * vVAT_RATE);

                igrSUM_NO_DEDUCTION.SetCellValue("GL_AMOUNT", vADJUST_AMOUNT);
                igrSUM_NO_DEDUCTION.SetCellValue("VAT_AMOUNT", vVAT_AMOUNT);

                idaSUM_NO_DEDUCTION.Update();
            }

            vFCMF0880_3.Dispose();
        }

        private void SHOW_ADJUST_4()
        {
            FCMF0880_4 vFCMF0880_4 = new FCMF0880_4(this.MdiParent, isAppInterfaceAdv1.AppInterface
                                                    , W_TAX_DESC.EditValue, W_TAX_CODE.EditValue
                                                    , W_VAT_REPORT_NM.EditValue
                                                    , W_DEAL_DATE_FR.EditValue, W_DEAL_DATE_TO.EditValue
                                                    , igrSUM_NO_DEDUCTION.GetCellValue("NO_DED_TYPE")
                                                    , igrSUM_NO_DEDUCTION.GetCellValue("NO_DED_DESC")
                                                    , igrSUM_NO_DEDUCTION.GetCellValue("NO_DED_CODE"));
            vFCMF0880_4.ShowDialog();
            if (iConv.ISNull(vFCMF0880_4.Get_Save_Flag) == "SAVE")
            {
                IDC_GET_ADJUST_AMOUNT.SetCommandParamValue("P_NO_DED_TYPE", igrSUM_NO_DEDUCTION.GetCellValue("NO_DED_TYPE"));
                IDC_GET_ADJUST_AMOUNT.SetCommandParamValue("P_NO_DED_CODE", igrSUM_NO_DEDUCTION.GetCellValue("NO_DED_CODE"));
                IDC_GET_ADJUST_AMOUNT.SetCommandParamValue("P_ADJUST_TYPE", "4");
                IDC_GET_ADJUST_AMOUNT.ExecuteNonQuery();
                decimal vADJUST_AMOUNT = iConv.ISDecimaltoZero(IDC_GET_ADJUST_AMOUNT.GetCommandParamValue("O_ADJUST_AMOUNT"));
                if (IDC_GET_ADJUST_AMOUNT.ExcuteError)
                {
                    vADJUST_AMOUNT = 0;
                }

                decimal vVAT_RATE = 0.1M;
                decimal vVAT_AMOUNT = Math.Floor(vADJUST_AMOUNT * vVAT_RATE);

                igrSUM_NO_DEDUCTION.SetCellValue("GL_AMOUNT", vADJUST_AMOUNT);
                igrSUM_NO_DEDUCTION.SetCellValue("VAT_AMOUNT", vVAT_AMOUNT);

                idaSUM_NO_DEDUCTION.Update();
            }

            vFCMF0880_4.Dispose();
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
                    idaSUM_NO_DEDUCTION.Update();
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Cancel)
                {
                    if (idaLIST_NO_DEDUCTION.IsFocused == true)
                    {
                        idaLIST_NO_DEDUCTION.Cancel();
                    }
                    else if (idaSUM_NO_DEDUCTION.IsFocused == true)
                    {
                        idaSUM_NO_DEDUCTION.Cancel();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {

                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Print)
                {
                    object vObject1 = W_TAX_DESC.EditValue;
                    object vObject2 = W_PERIOD_YEAR.EditValue;
                    object vObject3 = W_VAT_REPORT_NM.EditValue;
                    if (iConv.ISNull(vObject1) == string.Empty || iConv.ISNull(vObject2) == string.Empty || iConv.ISNull(vObject3) == string.Empty)
                    {
                        //사업장, 과세년도, 신고기간구분은 필수 입니다.
                        MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10366"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                        return;
                    }

                    XLPrinting_1("PRINT", igrLIST_NO_DEDUCTION);
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Export)
                {
                    object vObject1 = W_TAX_DESC.EditValue;
                    object vObject2 = W_PERIOD_YEAR.EditValue;
                    object vObject3 = W_VAT_REPORT_NM.EditValue;
                    if (iConv.ISNull(vObject1) == string.Empty || iConv.ISNull(vObject2) == string.Empty || iConv.ISNull(vObject3) == string.Empty)
                    {
                        //사업장, 과세년도, 신고기간구분은 필수 입니다.
                        MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10366"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                        return;
                    }

                    XLPrinting_1("FILE", igrLIST_NO_DEDUCTION);
                }
            }
        }

        #endregion;

        #region ----- Form Event -----

        private void FCMF0880_Load(object sender, EventArgs e)
        {
            idaLIST_NO_DEDUCTION.FillSchema();

            W_PERIOD_YEAR.EditValue = iDate.ISYear(System.DateTime.Today);
        }
        
        private void FCMF0880_Shown(object sender, EventArgs e)
        {
            IDC_SET_TAX_CODE.ExecuteNonQuery();
            W_TAX_DESC.EditValue = IDC_SET_TAX_CODE.GetCommandParamValue("O_TAX_DESC");
            W_TAX_CODE.EditValue = IDC_SET_TAX_CODE.GetCommandParamValue("O_TAX_CODE");
        }

        private void igrSUM_NO_DEDUCTION_CellDoubleClick(object pSender)
        {
            if (iConv.ISNull(igrSUM_NO_DEDUCTION.GetCellValue("NO_DED_CODE")) == "110")
            {
                SHOW_ADJUST_3();
            }
            else if (iConv.ISNull(igrSUM_NO_DEDUCTION.GetCellValue("NO_DED_CODE")) == "120")
            {
                SHOW_ADJUST_4();
            }
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
        
        private void igrSUM_NO_DEDUCTION_CurrentCellValidated(object pSender, ISGridAdvExValidatedEventArgs e)
        {
            if (igrSUM_NO_DEDUCTION.RowCount < 1)
            {
                return;
            }

            decimal vAMOUNT = 0;
            int vIDX_GL_AMOUNT = igrSUM_NO_DEDUCTION.GetColumnToIndex("GL_AMOUNT");
            int vIDX_VAT_AMOUNT = igrSUM_NO_DEDUCTION.GetColumnToIndex("VAT_AMOUNT");

            Decimal vGL_RATE = iConv.ISDecimaltoZero(10);
            Decimal vVAT_RATE = iConv.ISDecimaltoZero(0.1);

            if (e.ColIndex == vIDX_GL_AMOUNT)
            {
                if (iConv.ISDecimaltoZero(igrSUM_NO_DEDUCTION.GetCellValue("VAT_AMOUNT"), 0) == 0)
                {
                    vAMOUNT = vVAT_RATE * iConv.ISDecimaltoZero(e.CellValue, 0);
                    igrSUM_NO_DEDUCTION.SetCellValue("VAT_AMOUNT", vAMOUNT);
                }
            }
            else if (e.ColIndex == vIDX_VAT_AMOUNT)
            {
                if (iConv.ISDecimaltoZero(igrSUM_NO_DEDUCTION.GetCellValue("GL_AMOUNT"), 0) == 0)
                {
                    vAMOUNT = vGL_RATE * iConv.ISDecimaltoZero(e.CellValue, 0);
                    igrSUM_NO_DEDUCTION.SetCellValue("GL_AMOUNT", vAMOUNT);
                }
            }
        }

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

        private void XLPrinting_1(string pOutChoice, InfoSummit.Win.ControlAdv.ISGridAdvEx p_grid_LIST_NO_DEDUCTION)
        {
            string vMessageText = string.Empty;
            string vSaveFileName = string.Empty;

            int vCountRow = p_grid_LIST_NO_DEDUCTION.RowCount;

            if (vCountRow < 1)
            {
                vMessageText = string.Format("Without Data");
                isAppInterfaceAdv1.OnAppMessage(vMessageText);
                System.Windows.Forms.Application.DoEvents();
                return;
            }

            idaPRINT_NO_DEDUCTION_TITLE.Fill();
            IDA_PRINT_ADJUST_3.Fill();
            IDA_PRINT_ADJUST_4.Fill();

            //idaSUM_SUPPLY_AMT.Fill();

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
                xlPrinting.OpenFileNameExcel = "FCMF0880_001.xls";
                //-------------------------------------------------------------------------------------

                //-------------------------------------------------------------------------------------
                bool isOpen = xlPrinting.XLFileOpen();
                //-------------------------------------------------------------------------------------

                //-------------------------------------------------------------------------------------
                if (isOpen == true)
                {
                    vPageNumber = xlPrinting.LineWrite(p_grid_LIST_NO_DEDUCTION, idaPRINT_NO_DEDUCTION_TITLE, IDA_PRINT_ADJUST_3, IDA_PRINT_ADJUST_4);
                    //vPageNumber = xlPrinting.LineWrite(p_grid_LIST_NO_DEDUCTION, idaPRINT_NO_DEDUCTION_TITLE, idaSUM_SUPPLY_AMT);

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

        #region ----- Adapter Event -----

        private void idaSUM_NO_DEDUCTION_PreNewRowMoved(object pSender, ISBindingEventArgs pBindingManager)
        {
            if (pBindingManager.DataRow == null)
            {
                return;
            }
            //Set_GRID_STATUS_ROW();
        }

        #endregion

    }
}