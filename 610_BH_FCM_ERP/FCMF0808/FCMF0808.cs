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

namespace FCMF0808
{
    public partial class FCMF0808 : Office2007Form
    {
        #region ----- Variables -----

        ISFunction.ISConvert iString = new ISFunction.ISConvert();
        ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        #endregion;

        #region ----- Constructor -----

        public FCMF0808()
        {
            InitializeComponent();
        }

        public FCMF0808(Form pMainForm, ISAppInterface pAppInterface)
        {
            InitializeComponent();
            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;
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

        private void Set_Default_Value()
        {
            //사업장 구분.
            idcDV_TAX_CODE.SetCommandParamValue("W_GROUP_CODE", "TAX_CODE");
            idcDV_TAX_CODE.ExecuteNonQuery();
            TAX_CODE_NAME_0.EditValue = idcDV_TAX_CODE.GetCommandParamValue("O_CODE_NAME");
            TAX_CODE_0.EditValue = idcDV_TAX_CODE.GetCommandParamValue("O_CODE");

            //세금계산서 발행기간.
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

            idaVAT_EXPORT.Fill();
            igrVAT_EXPORT.Focus();
        }

        private void SetCommonParameter(object pGroup_Code, object pEnabled_YN)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", pGroup_Code);
            ildCOMMON.SetLookupParamValue("W_ENABLED_YN", pEnabled_YN);
        }

        private void SET_INSERT_EXPORT()
        {
            igrVAT_EXPORT.SetCellValue("TAX_CODE", TAX_CODE_0.EditValue);
            igrVAT_EXPORT.SetCellValue("TAX_CODE_DESC", TAX_CODE_NAME_0.EditValue);
            igrVAT_EXPORT.SetCellValue("SHIPPING_DATE", WRITE_DATE.EditValue);
            igrVAT_EXPORT.CurrentCellMoveTo(igrVAT_EXPORT.GetColumnToIndex("DOCUMENT_NUM"));
            igrVAT_EXPORT.CurrentCellActivate(igrVAT_EXPORT.GetColumnToIndex("DOCUMENT_NUM"));
            igrVAT_EXPORT.Focus();
        }

        private void SET_BASE_AMOUNT(object pEXCHANGE_RATE, object pCURR_AMOUNT)
        {            
            decimal mBASE_AMOUNT = 0;        
            mBASE_AMOUNT = iString.ISDecimaltoZero(pEXCHANGE_RATE) * iString.ISDecimaltoZero(pCURR_AMOUNT);
            mBASE_AMOUNT = Math.Round(mBASE_AMOUNT, 0);
            igrVAT_EXPORT.SetCellValue("BASE_AMOUNT", mBASE_AMOUNT);            
        }

        private void Show_Slip_Detail()
        {
            int mSLIP_HEADER_ID = iString.ISNumtoZero(igrVAT_EXPORT.GetCellValue("INTERFACE_HEADER_ID"));
            if (mSLIP_HEADER_ID != Convert.ToInt32(0))
            {
                Application.UseWaitCursor = true;
                this.Cursor = System.Windows.Forms.Cursors.WaitCursor;

                FCMF0204.FCMF0204 vFCMF0204 = new FCMF0204.FCMF0204(this.MdiParent, isAppInterfaceAdv1.AppInterface, mSLIP_HEADER_ID);
                vFCMF0204.Show();

                this.Cursor = System.Windows.Forms.Cursors.Default;
                Application.UseWaitCursor = false;
            }
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

        #region ----- XL Print 1 Method ----

        private void XLPrinting_1(string pOutChoice, InfoSummit.Win.ControlAdv.ISGridAdvEx pGrid)
        {// pOutChoice : 출력구분.
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
            {// 폼에 있는 항목들중 기본적으로 출력해야 하는 값.
                idcVAT_PERIOD.ExecuteNonQuery();
                string vPeriod = string.Format("( {0} )", idcVAT_PERIOD.GetCommandParamValue("O_PERIOD"));
                string vISSUE_PERIOD = String.Format("{0} ~ {1}", ISSUE_DATE_FR_0.DateTimeValue.ToShortDateString(), ISSUE_DATE_TO_0.DateTimeValue.ToShortDateString());
                string vWRITE_DATE = String.Format("{0}", WRITE_DATE.DateTimeValue.ToShortDateString());

                // open해야 할 파일명 지정.
                //-------------------------------------------------------------------------------------
                xlPrinting.OpenFileNameExcel = "FCMF0808_001.xls";
                //-------------------------------------------------------------------------------------
                // 파일 오픈.
                //-------------------------------------------------------------------------------------
                bool isOpen = xlPrinting.XLFileOpen();
                //-------------------------------------------------------------------------------------

                //-------------------------------------------------------------------------------------
                if (isOpen == true)
                {
                    // 헤더 인쇄.
                    idaOPERATING_UNIT.Fill();
                    if (idaOPERATING_UNIT.SelectRows.Count > 0)
                    {
                        xlPrinting.HeaderWrite(idaOPERATING_UNIT, vPeriod, vISSUE_PERIOD, vWRITE_DATE);
                    }
                    // 실제 인쇄
                    vPageNumber = xlPrinting.LineWrite(pGrid, vPeriod);

                    //출력구분에 따른 선택(인쇄 or file 저장)
                    if (pOutChoice == "PRINT")
                    {
                        xlPrinting.Printing(1, vPageNumber);
                    }
                    else if (pOutChoice == "FILE")
                    {
                        xlPrinting.SAVE("VAT_EXPORT_");
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
                    if (idaVAT_EXPORT.IsFocused)
                    {
                        idaVAT_EXPORT.AddOver();
                        SET_INSERT_EXPORT();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddUnder)
                {
                    if (idaVAT_EXPORT.IsFocused)
                    {
                        idaVAT_EXPORT.AddUnder();
                        SET_INSERT_EXPORT();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Update)
                {
                    if (idaVAT_EXPORT.IsFocused)
                    {
                        idaVAT_EXPORT.Update();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Cancel)
                {
                    if (idaVAT_EXPORT.IsFocused)
                    {
                        idaVAT_EXPORT.Cancel();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {
                    if (idaVAT_EXPORT.IsFocused)
                    {
                        idaVAT_EXPORT.Delete();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Print)
                {
                    XLPrinting_1("PRINT", igrVAT_EXPORT);
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Export)
                {
                    XLPrinting_1("FILE", igrVAT_EXPORT);
                }
            }
        }

        #endregion;

        #region ----- Form Event -----

        private void FCMF0808_Load(object sender, EventArgs e)
        {
            idaVAT_EXPORT.FillSchema();
        }

        private void FCMF0808_Shown(object sender, EventArgs e)
        {
            Set_Default_Value();
        }

        private void igrVAT_EXPORT_CellDoubleClick(object pSender)
        {
            Show_Slip_Detail();
        }

        private void igrVAT_EXPORT_CurrentCellChanged(object pSender, ISGridAdvExChangedEventArgs e)
        {
            int mIDX_EXCHANGE_RATE = igrVAT_EXPORT.GetColumnToIndex("EXCHANGE_RATE");
            int mIDX_CURR_AMOUNT = igrVAT_EXPORT.GetColumnToIndex("CURR_AMOUNT");
            if (e.ColIndex == mIDX_EXCHANGE_RATE)
            {
                SET_BASE_AMOUNT(e.NewValue, igrVAT_EXPORT.GetCellValue("CURR_AMOUNT"));
            }
            else if (e.ColIndex == mIDX_CURR_AMOUNT)
            {
                SET_BASE_AMOUNT(igrVAT_EXPORT.GetCellValue("EXCHANGE_RATE"), e.NewValue);
            }
            
        }

        private void ibtnSET_EXPORT_ButtonClick(object pSender, EventArgs pEventArgs)
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

            string mMESSAGE;
            idcSET_CREATE_EXPORT.ExecuteNonQuery();
            mMESSAGE = iString.ISNull(idcSET_CREATE_EXPORT.GetCommandParamValue("O_MESSAGE"));
            if (mMESSAGE != String.Empty)
            {
                MessageBoxAdv.Show(mMESSAGE, "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
        }

        #endregion

        #region ----- Lookup Event : Search -----

        private void ilaTAX_CODE_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter("TAX_CODE", "Y");
        }
        
        #endregion

        #region ----- Lookup Event : Grid -----
        
        private void ilaCURRENCY_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCURRENCY.SetLookupParamValue("W_EXCEPT_BASE_YN", "Y");
            ildCURRENCY.SetLookupParamValue("W_ENABLED_YN", "Y");
        }
        
        #endregion

        #region ----- Adapter Event : VAT_EXPORT -----

        private void idaVAT_EXPORT_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {
            if (iString.ISNull(e.Row["TAX_CODE"]) == String.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10007"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["DOCUMENT_NUM"]) == String.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10280"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }

            if (iString.ISNull(e.Row["SHIPPING_DATE"]) == String.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10242", "&&VALUE:=Shipping Date(선적일자)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["CURRENCY_CODE"]) == String.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10124"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["EXCHANGE_RATE"]) == String.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10268"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
        }

        private void idaVAT_EXPORT_PreDelete(ISPreDeleteEventArgs e)
        {

        }

        #endregion

    }
}