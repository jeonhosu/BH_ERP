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

namespace FCMF0805
{
    public partial class FCMF0805 : Office2007Form
    {
        #region ----- Variables -----

        ISFunction.ISConvert iString = new ISFunction.ISConvert();
        ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        #endregion;

        #region ----- Constructor -----

        public FCMF0805()
        {
            InitializeComponent();
        }

        public FCMF0805(Form pMainForm, ISAppInterface pAppInterface)
        {
            InitializeComponent();
            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;

            //int vCountRow = ((ISGridAdvEx)(pObject)).RowCount;
            //((mdiMMPS52)(this.MdiParent)).StatusSTRIP_Form_Open_iF_Value.Text = "0";
            //(()(this.MdiParent)).

            //System.Type vType = this.MdiParent.GetType();
            //object vO1 = Convert.ChangeType(pMainForm, System.Type.GetType(vType.FullName));
            string vPathReport = string.Empty;
            object vObject = this.MdiParent.Tag;
            if (vObject != null)
            {
                bool isConvert = vObject is string;
                if (isConvert == true)
                {
                    vPathReport = vObject as string;
                }
            }
        }

        #endregion;

        #region ----- Private Methods ----

        private DateTime GetDate()
        {
            DateTime vDateTime = DateTime.Today;

            try
            {
                idcGetDate.ExecuteNonQuery();
                object vObject = idcGetDate.GetCommandParamValue("X_LOCAL_DATE");

                bool isConvert = vObject is DateTime;
                if (isConvert == true)
                {
                    vDateTime = (DateTime)vObject;
                }
            }
            catch (Exception ex)
            {
                string vMessage = ex.Message;
                vDateTime = new DateTime(9999, 12, 31, 23, 59, 59);
            }
            return vDateTime;
        }

        private void Default_Value()
        {
            //?????? ????.
            idcDV_TAX_CODE.SetCommandParamValue("W_GROUP_CODE", "TAX_CODE");
            idcDV_TAX_CODE.ExecuteNonQuery();
            TAX_CODE_NAME_0.EditValue = idcDV_TAX_CODE.GetCommandParamValue("O_CODE_NAME");
            TAX_CODE_0.EditValue = idcDV_TAX_CODE.GetCommandParamValue("O_CODE");

            //?????????? ????????.
            DateTime vGetDateTime = GetDate();

            ISCommonUtil.ISFunction.ISDateTime vDate = new ISCommonUtil.ISFunction.ISDateTime();
            DateTime vMonthFirstDay = vDate.ISMonth_1st(vGetDateTime);

            ISSUE_DATE_FR_0.EditValue = vMonthFirstDay;
            ISSUE_DATE_TO_0.EditValue = vGetDateTime;

            WRITE_DATE.EditValue = ISSUE_DATE_TO_0.EditValue;
        }

        private void SEARCH_DB()
        {
            if (iString.ISNull(TAX_CODE_0.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10007"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                TAX_CODE_NAME_0.Focus();
                return;
            }

            if (iString.ISNull(ISSUE_DATE_FR_0.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10010"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                ISSUE_DATE_FR_0.Focus();
                return;
            }
            if (iString.ISNull(ISSUE_DATE_TO_0.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10011"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                ISSUE_DATE_FR_0.Focus();
                return;
            }
            if (Convert.ToDateTime(ISSUE_DATE_FR_0.EditValue) > Convert.ToDateTime(ISSUE_DATE_TO_0.EditValue))
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10012"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                ISSUE_DATE_FR_0.Focus();
                return;
            }

            if (itbBILL.SelectedTab.TabIndex == 1)
            {
                idaBILL_1.Fill();

                //?????? ??????.
                idaPRINT_BILL_1_SUM.Fill();
                idaPRINT_BILL_1_DETAIL.Fill();

                igrBILL_1.Focus();                
            }
            else if (itbBILL.SelectedTab.TabIndex == 2)
            {
                idaBILL_2.Fill();

                //?????? ??????.
                idaPRINT_BILL_2_SUM.Fill();
                idaPRINT_BILL_2_DETAIL.Fill();
                igrBILL_2.Focus();
            }
        }

        private void SetCommonParameter(object pGroup_Code, object pEnabled_YN)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", pGroup_Code);
            ildCOMMON.SetLookupParamValue("W_ENABLED_YN", pEnabled_YN);
        }

        private void SHOW_TAX_INVOICE_DETAIL(object pTAX_CODE, object pVAT_GUBUN, object pCUSTOMER_ID)
        {
            if (iString.ISNull(pVAT_GUBUN) == string.Empty)
            {
                return;
            }
            if (iString.ISNull(pCUSTOMER_ID) == string.Empty)
            {
                return;
            }
            if (iString.ISNull(pTAX_CODE) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10007"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }
            if (iString.ISNull(ISSUE_DATE_FR_0.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10010"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }
            if (iString.ISNull(ISSUE_DATE_TO_0.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10011"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }
            if (Convert.ToDateTime(ISSUE_DATE_FR_0.EditValue) > Convert.ToDateTime(ISSUE_DATE_TO_0.EditValue))
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10012"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                ISSUE_DATE_FR_0.Focus();
                return;
            }
            
            Application.UseWaitCursor = true;
            this.Cursor = System.Windows.Forms.Cursors.WaitCursor;

            System.Windows.Forms.DialogResult dlgVALUE;
            TAX_INVOICE_DETAIL vTAX_INVOICE_DETAIL = new TAX_INVOICE_DETAIL(isAppInterfaceAdv1.AppInterface, pTAX_CODE, pVAT_GUBUN
                                                                        , ISSUE_DATE_FR_0.EditValue, ISSUE_DATE_TO_0.EditValue, pCUSTOMER_ID);
            dlgVALUE = vTAX_INVOICE_DETAIL.ShowDialog();
            if (dlgVALUE == DialogResult.OK)
            {

            }
            Application.UseWaitCursor = false;
            this.Cursor = System.Windows.Forms.Cursors.Default;
        }

        #endregion;

        #region ----- Territory Get Methods ----

        private int GetTerritory(ISUtil.Enum.TerritoryLanguage pTerritoryEnum)
        {
            int vTerritory = -1;

            switch (pTerritoryEnum)
            {
                case ISUtil.Enum.TerritoryLanguage.Default:
                    vTerritory = 0;
                    break;
                case ISUtil.Enum.TerritoryLanguage.TL1_KR:
                    vTerritory = 1;
                    break;
                case ISUtil.Enum.TerritoryLanguage.TL2_CN:
                    vTerritory = 2;
                    break;
                case ISUtil.Enum.TerritoryLanguage.TL3_VN:
                    vTerritory = 3;
                    break;
                case ISUtil.Enum.TerritoryLanguage.TL4_JP:
                    vTerritory = 4;
                    break;
                case ISUtil.Enum.TerritoryLanguage.TL5_XAA:
                    vTerritory = 5;
                    break;
            }

            return vTerritory;
        }

        #endregion;

        #region ----- XL Print 1 (????) Method ----

        private void XLPrinting_1(string pOutChoice, InfoSummit.Win.ControlAdv.ISGridAdvEx pGrid, ISGridAdvEx pGrid_Detail)
        {// pOutChoice : ????????.
            string vMessageText = string.Empty;
            string vSaveFileName = string.Empty;

            int vCountRow = pGrid.RowCount;

            if (vCountRow < 1)
            {
                vMessageText = string.Format("Without Data");
                isAppInterfaceAdv1.OnAppMessage(vMessageText);
                System.Windows.Forms.Application.DoEvents();
                return;
            }

            System.Windows.Forms.Application.UseWaitCursor = true;
            this.Cursor = System.Windows.Forms.Cursors.WaitCursor;
            System.Windows.Forms.Application.DoEvents();

            int vPageNumber = 0;
            //int vTerritory = GetTerritory(isAppInterfaceAdv1.AppInterface.OraConnectionInfo.TerritoryLanguage);

            vMessageText = string.Format(" Printing Starting...");
            isAppInterfaceAdv1.OnAppMessage(vMessageText);
            System.Windows.Forms.Application.DoEvents();

            XLPrinting xlPrinting = new XLPrinting(isAppInterfaceAdv1.AppInterface, isMessageAdapter1);

            try
            {// ???? ???? ???????? ?????????? ???????? ???? ??.
                idcVAT_PERIOD.ExecuteNonQuery();
                string vPeriod = string.Format("( {0} )", idcVAT_PERIOD.GetCommandParamValue("O_PERIOD"));
                string vISSUE_PERIOD = String.Format("{0} ~ {1}", ISSUE_DATE_FR_0.DateTimeValue.ToShortDateString(), ISSUE_DATE_TO_0.DateTimeValue.ToShortDateString());
                string vWRITE_DATE = String.Format("{0}", WRITE_DATE.DateTimeValue.ToShortDateString());

                // open???? ?? ?????? ????.
                //-------------------------------------------------------------------------------------
                xlPrinting.OpenFileNameExcel = "FCMF0805_001.xls";
                //-------------------------------------------------------------------------------------
                // ???? ????.
                //-------------------------------------------------------------------------------------
                bool isOpen = xlPrinting.XLFileOpen();
                //-------------------------------------------------------------------------------------

                //-------------------------------------------------------------------------------------
                if (isOpen == true)
                {
                    // ???? ????.
                    idaOPERATING_UNIT.Fill();
                    if (idaOPERATING_UNIT.SelectRows.Count > 0)
                    {
                        xlPrinting.HeaderWrite(idaOPERATING_UNIT, vPeriod, vISSUE_PERIOD, vWRITE_DATE);
                    }
                    // ???? ????
                    vPageNumber = xlPrinting.LineWrite(pGrid, pGrid_Detail);

                    //?????????? ???? ????(???? or file ????)
                    if (pOutChoice == "PRINT")
                    {
                        xlPrinting.Printing(1, vPageNumber);
                    }
                    else if (pOutChoice == "FILE")
                    {
                        xlPrinting.SAVE("BILL_1_");
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

        #region ----- XL Print 2 (????) Method ----

        private void XLPrinting_2(string pOutChoice, InfoSummit.Win.ControlAdv.ISGridAdvEx pGrid, ISGridAdvEx pGrid_Detail)
        {// pOutChoice : ????????.
            string vMessageText = string.Empty;
            string vSaveFileName = string.Empty;

            int vCountRow = pGrid.RowCount;

            if (vCountRow < 1)
            {
                vMessageText = string.Format("Without Data");
                isAppInterfaceAdv1.OnAppMessage(vMessageText);
                System.Windows.Forms.Application.DoEvents();
                return;
            }

            System.Windows.Forms.Application.UseWaitCursor = true;
            this.Cursor = System.Windows.Forms.Cursors.WaitCursor;
            System.Windows.Forms.Application.DoEvents();

            int vPageNumber = 0;
            //int vTerritory = GetTerritory(isAppInterfaceAdv1.AppInterface.OraConnectionInfo.TerritoryLanguage);

            vMessageText = string.Format(" Printing Starting...");
            isAppInterfaceAdv1.OnAppMessage(vMessageText);
            System.Windows.Forms.Application.DoEvents();

            XLPrinting xlPrinting = new XLPrinting(isAppInterfaceAdv1.AppInterface, isMessageAdapter1);

            try
            {// ???? ???? ???????? ?????????? ???????? ???? ??.
                idcVAT_PERIOD.ExecuteNonQuery();
                string vPeriod = string.Format("( {0} )", idcVAT_PERIOD.GetCommandParamValue("O_PERIOD"));
                string vISSUE_PERIOD = String.Format("{0} ~ {1}", ISSUE_DATE_FR_0.DateTimeValue.ToShortDateString(), ISSUE_DATE_TO_0.DateTimeValue.ToShortDateString());
                string vWRITE_DATE = String.Format("{0}", WRITE_DATE.DateTimeValue.ToShortDateString());

                // open???? ?? ?????? ????.
                //-------------------------------------------------------------------------------------
                xlPrinting.OpenFileNameExcel = "FCMF0805_002.xls";
                //-------------------------------------------------------------------------------------
                // ???? ????.
                //-------------------------------------------------------------------------------------
                bool isOpen = xlPrinting.XLFileOpen();
                //-------------------------------------------------------------------------------------

                //-------------------------------------------------------------------------------------
                if (isOpen == true)
                {
                    // ???? ????.
                    idaOPERATING_UNIT.Fill();
                    if (idaOPERATING_UNIT.SelectRows.Count > 0)
                    {
                        xlPrinting.HeaderWrite(idaOPERATING_UNIT, vPeriod, vISSUE_PERIOD, vWRITE_DATE);
                    }
                    // ???? ????
                    vPageNumber = xlPrinting.LineWrite(pGrid, pGrid_Detail);

                    //?????????? ???? ????(???? or file ????)
                    if (pOutChoice == "PRINT")
                    {
                        xlPrinting.Printing(1, vPageNumber);
                    }
                    else if (pOutChoice == "FILE")
                    {
                        xlPrinting.SAVE("BILL_2_");
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
        
        #region ----- Events -----

        private void isAppInterfaceAdv1_AppMainButtonClick(ISAppButtonEvents e)
        {
            if (this.IsActive)
            {
                if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Search)
                {
                    SEARCH_DB();
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
                    if (idaBILL_1.IsFocused)
                    {
                        idaBILL_1.Cancel();
                    }
                    else if (idaBILL_2.IsFocused)
                    {
                        idaBILL_2.Cancel();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {

                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Print)
                {
                    if (itbBILL.SelectedTab.TabIndex == 1)
                    {
                        XLPrinting_1("PRINT", igrPRINT_BILL_1_SUM, igrPRINT_BILL_1_DETAIL);
                    }
                    else if (itbBILL.SelectedTab.TabIndex == 2)
                    {
                        XLPrinting_2("PRINT", igrPRINT_BILL_2_SUM, igrPRINT_BILL_2_DETAIL);
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Export)
                {
                    if (itbBILL.SelectedTab.TabIndex == 1)
                    {
                        XLPrinting_1("FILE", igrPRINT_BILL_1_SUM, igrPRINT_BILL_1_DETAIL);
                    }
                    else if (itbBILL.SelectedTab.TabIndex == 2)
                    {
                        XLPrinting_2("FILE", igrPRINT_BILL_2_SUM, igrPRINT_BILL_2_DETAIL);
                    }
                }
            }
        }

        #endregion;

        #region ----- Form Event ------

        private void FCMF0805_Load(object sender, EventArgs e)
        {

        }

        private void FCMF0805_Shown(object sender, EventArgs e)
        {
            Default_Value();
        }

        private void itbTAX_INVOICE_SelectedIndexChanged(object sender, EventArgs e)
        {
            SEARCH_DB();
        }

        private void igrTAX_INVOICE_1_CellDoubleClick(object pSender)
        {
            SHOW_TAX_INVOICE_DETAIL(igrBILL_1.GetCellValue("TAX_CODE")
                                    , igrBILL_1.GetCellValue("VAT_GUBUN")
                                    , igrBILL_1.GetCellValue("CUSTOMER_ID"));
        }

        private void igrTAX_INVOICE_2_CellDoubleClick(object pSender)
        {
            SHOW_TAX_INVOICE_DETAIL(igrBILL_2.GetCellValue("TAX_CODE")
                                    , igrBILL_2.GetCellValue("VAT_GUBUN")
                                    , igrBILL_2.GetCellValue("CUSTOMER_ID"));
        }

        #endregion

        #region ------ Lookup Event ------
        
        private void ilaTAX_CODE_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter("TAX_CODE", "Y");
        }

        private void ilaCUSTOMER_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCUSTOMER.SetLookupParamValue("W_ENABLED_YN", "Y");
        }

        #endregion

        #region ------ Adater Event ------


        #endregion

    }
}