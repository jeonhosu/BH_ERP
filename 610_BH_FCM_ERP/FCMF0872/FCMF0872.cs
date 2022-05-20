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

namespace FCMF0872
{
    public partial class FCMF0872 : Office2007Form
    {
        #region ----- Variables -----

        private ISFunction.ISConvert iString = new ISFunction.ISConvert();
        private ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        #endregion;

        #region ----- Constructor -----

        public FCMF0872(Form pMainForm, ISAppInterface pAppInterface)
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

            idaBLD_AMT_SPEC.Fill();
            idaSUM_BLD_AMT_SPEC.Fill();
            igrBLD_AMT_SPEC.Focus();
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

        private void Default_Value_INSERT()
        {
            igrBLD_AMT_SPEC.SetCellValue("IN_DATE", System.DateTime.Today);
            igrBLD_AMT_SPEC.SetCellValue("OUT_DATE", System.DateTime.Today);

            igrBLD_AMT_SPEC.SetCellValue("DEPOSIT", 0);
            igrBLD_AMT_SPEC.SetCellValue("MONTH_RENT", 0);
            igrBLD_AMT_SPEC.SetCellValue("MONTN_FEE", 0);
        }

        private void get_SET_TERM_AMT()
        {
            idcSET_TERM_AMT.ExecuteNonQuery();
            object vDEEMED_RENT = idcSET_TERM_AMT.GetCommandParamValue("O_DEEMED_RENT");
            object vTERM_RENT = idcSET_TERM_AMT.GetCommandParamValue("O_TERM_RENT");
            object vTERM_FEE = idcSET_TERM_AMT.GetCommandParamValue("O_TERM_FEE");

            //2013-10-15 김대영d 요청 수기 수정 가능하도록 
            if (iString.ISNull(igrBLD_AMT_SPEC.GetCellValue("DEEMED_RENT")) == string.Empty)
            {
                igrBLD_AMT_SPEC.SetCellValue("DEEMED_RENT", vDEEMED_RENT);
            }
            if (iString.ISNull(igrBLD_AMT_SPEC.GetCellValue("TERM_RENT")) == string.Empty)
            {
                igrBLD_AMT_SPEC.SetCellValue("TERM_RENT", vTERM_RENT);
            }
            if (iString.ISNull(igrBLD_AMT_SPEC.GetCellValue("TERM_FEE")) == string.Empty)
            {
                igrBLD_AMT_SPEC.SetCellValue("TERM_FEE", vTERM_FEE);
            }
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
                    if (idaBLD_AMT_SPEC.IsFocused == true)
                    {
                        bool isClosing = IS_CLOSING_YN();
                        if (isClosing == false)
                        {
                            bool isInsert = IS_INSERT_ABLE();
                            if (isInsert == true)
                            {
                                idaBLD_AMT_SPEC.AddOver();
                                Default_Value_INSERT();
                            }
                        }
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddUnder)
                {
                    if (idaBLD_AMT_SPEC.IsFocused == true)
                    {
                        bool isClosing = IS_CLOSING_YN();
                        if (isClosing == false)
                        {
                            bool isInsert = IS_INSERT_ABLE();
                            if (isInsert == true)
                            {
                                idaBLD_AMT_SPEC.AddUnder();
                                Default_Value_INSERT();
                            }
                        }
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Update)
                {
                    if (idaBLD_AMT_SPEC.IsFocused == true)
                    {
                        bool isClosing = IS_CLOSING_YN();
                        if (isClosing == false)
                        {
                            idaBLD_AMT_SPEC.Update();
                            SearchDB();
                        }
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Cancel)
                {
                    if (idaBLD_AMT_SPEC.IsFocused == true)
                    {
                        idaBLD_AMT_SPEC.Cancel();
                    }
                    else if (idaSUM_BLD_AMT_SPEC.IsFocused == true)
                    {
                        idaSUM_BLD_AMT_SPEC.Cancel();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {
                    if (idaBLD_AMT_SPEC.IsFocused == true)
                    {
                        bool isClosing = IS_CLOSING_YN();
                        if (isClosing == false)
                        {
                            idaBLD_AMT_SPEC.Delete();
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

                    XLPrinting_1("PRINT", igrBLD_AMT_SPEC);
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

                    XLPrinting_1("FILE", igrBLD_AMT_SPEC);
                }
            }
        }

        #endregion;

        #region ----- Form Event -----

        private void FCMF0872_Load(object sender, EventArgs e)
        {
            idaBLD_AMT_SPEC.FillSchema();

            PERIOD_YEAR.EditValue = iDate.ISYear(System.DateTime.Today);

            CLOSING_YN.EditValue = "N";
        }
        
        private void FCMF0872_Shown(object sender, EventArgs e)
        {
            IDC_SET_TAX_CODE.ExecuteNonQuery();
            W_TAX_DESC.EditValue = IDC_SET_TAX_CODE.GetCommandParamValue("O_TAX_DESC");
            W_TAX_CODE.EditValue = IDC_SET_TAX_CODE.GetCommandParamValue("O_TAX_CODE");
        }

        
        #endregion

        #region ----- Lookup Event -----

        private void ilaVAT_GROUND_YN_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter("VAT_GROUND_YN", "Y");
        }

        #endregion

        #region ----- Grid Event -----

        private void igrBLD_AMT_SPEC_CurrentCellAcceptedChanges(object pSender, ISGridAdvExChangedEventArgs e)
        {
            get_SET_TERM_AMT();
        }

        #endregion

        #region ----- XL Print 1 Method ----

        private void XLPrinting_1(string pOutChoice, InfoSummit.Win.ControlAdv.ISGridAdvEx p_grid_BLD_AMT_SPEC)
        {
            string vMessageText = string.Empty;
            string vSaveFileName = string.Empty;

            int vCountRow = p_grid_BLD_AMT_SPEC.RowCount;

            if (vCountRow < 1)
            {
                vMessageText = string.Format("Without Data");
                isAppInterfaceAdv1.OnAppMessage(vMessageText);
                System.Windows.Forms.Application.DoEvents();
                return;
            }

            idaPRINT_BLD_AMT_SPEC.Fill();

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
                xlPrinting.OpenFileNameExcel = "FCMF0872_001.xls";
                //-------------------------------------------------------------------------------------

                //-------------------------------------------------------------------------------------
                bool isOpen = xlPrinting.XLFileOpen();
                //-------------------------------------------------------------------------------------

                //-------------------------------------------------------------------------------------
                if (isOpen == true)
                {
                    vPageNumber = xlPrinting.LineWrite(p_grid_BLD_AMT_SPEC, idaSUM_BLD_AMT_SPEC, idaPRINT_BLD_AMT_SPEC);

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