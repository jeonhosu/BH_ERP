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

namespace FCMF0810
{
    public partial class FCMF0810 : Office2007Form
    {
        #region ----- Variables -----

        ISFunction.ISConvert iString = new ISFunction.ISConvert();
        ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        #endregion;

        #region ----- Constructor -----

        public FCMF0810()
        {
            InitializeComponent();
        }

        public FCMF0810(Form pMainForm, ISAppInterface pAppInterface)
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

            //자산취득기간.
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

            idaDPR_ASSET.Fill();
            idaDPR_ASSET_DETAIL.Fill();

            if (itbDPR_ASSET.SelectedTab.TabIndex == 1)
            {
                igrDPR_ASSET.Focus();
            }
            else if (itbDPR_ASSET.SelectedTab.TabIndex == 2)
            {
                igrDPR_ASSET_DETAIL.Focus();
            }
        }

        private void SetCommonParameter(object pGroup_Code, object pEnabled_YN)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", pGroup_Code);
            ildCOMMON.SetLookupParamValue("W_ENABLED_YN", pEnabled_YN);
        }

        private void Show_Slip_Detail()
        {
            int mSLIP_HEADER_ID = iString.ISNumtoZero(igrDPR_ASSET_DETAIL.GetCellValue("INTERFACE_HEADER_ID"));
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

        #region ----- XL Print 1 Method ----

        private void XLPrinting_1(string pOutChoice, InfoSummit.Win.ControlAdv.ISGridAdvEx pGrid, ISGridAdvEx pGrid_DETAIL)
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
                //string vType = string.Format("{0}", V_ITEM_CATEGORY_DESC.EditValue);
                //string vCharge = string.Format("{0}", V_PO_PERSON_NAME.EditValue);
                string vPeriod = string.Format("년  기({0} ~ {1})", ISSUE_DATE_FR_0.DateTimeValue.ToShortDateString(), ISSUE_DATE_TO_0.DateTimeValue.ToShortDateString());
                // open해야 할 파일명 지정.
                //-------------------------------------------------------------------------------------
                xlPrinting.OpenFileNameExcel = "FCMF0810_001.xls";
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
                        xlPrinting.HeaderWrite(idaOPERATING_UNIT, vPeriod);
                    }
                    // 실제 인쇄
                    vPageNumber = xlPrinting.LineWrite(pGrid, pGrid_DETAIL, vPeriod);

                    //출력구분에 따른 선택(인쇄 or file 저장)
                    if (pOutChoice == "PRINT")
                    {
                        xlPrinting.Printing(1, vPageNumber);
                    }
                    else if (pOutChoice == "FILE")
                    {
                        xlPrinting.SAVE("OT_");
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
                    if (idaDPR_ASSET_DETAIL.IsFocused)
                    {
                        idaDPR_ASSET_DETAIL.Update();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Cancel)
                {
                    if (idaDPR_ASSET_DETAIL.IsFocused)
                    {
                        idaDPR_ASSET_DETAIL.Cancel();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {
                    if (idaDPR_ASSET_DETAIL.IsFocused)
                    {
                        idaDPR_ASSET_DETAIL.Delete();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Print)
                {
                    XLPrinting_1("PRINT", igrDPR_ASSET, igrDPR_ASSET_DETAIL);
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Export)
                {
                    XLPrinting_1("FILE", igrDPR_ASSET, igrDPR_ASSET_DETAIL);
                }
            }
        }

        #endregion;

        #region ----- Form Event -----

        private void FCMF0810_Load(object sender, EventArgs e)
        {
            idaDPR_ASSET.FillSchema();
            idaDPR_ASSET_DETAIL.FillSchema();
        }

        private void FCMF0810_Shown(object sender, EventArgs e)
        {
            Set_Default_Value();
        }
        
        private void ibtnSET_DPR_ASSET_ButtonClick(object pSender, EventArgs pEventArgs)
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
            idcSET_DPR_ASSET.ExecuteNonQuery();
            mMESSAGE = iString.ISNull(idcSET_DPR_ASSET.GetCommandParamValue("O_MESSAGE"));
            if (mMESSAGE != String.Empty)
            {
                MessageBoxAdv.Show(mMESSAGE, "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
        }

        private void itbDPR_ASSET_Click(object sender, EventArgs e)
        {
            if (itbDPR_ASSET.SelectedTab.TabIndex == 1)
            {
                igrDPR_ASSET.Focus();
            }
            else if (itbDPR_ASSET.SelectedTab.TabIndex == 2)
            {
                igrDPR_ASSET_DETAIL.Focus();
            }
        }

        private void igrDPR_ASSET_DETAIL_CellDoubleClick(object pSender)
        {
            Show_Slip_Detail();
        }

        #endregion

        #region ----- Lookup Event : Search -----

        private void ilaTAX_CODE_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter("TAX_CODE", "Y");
        }

        #endregion

        #region ----- Adapter Event : Depreciation Asset Detail ------

        private void idaDPR_ASSET_DETAIL_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {
            if (iString.ISNull(e.Row["DPR_ASSET_ID"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10232"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["ACQUIRE_DATE"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10203"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["ACCOUNT_CONTROL_ID"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10123"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["CUSTOMER_ID"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10135"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["GL_AMOUNT"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10208"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["VAT_AMOUNT"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10281"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["VAT_ASSET_GB"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10282"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
        }

        private void idaDPR_ASSET_DETAIL_PreDelete(ISPreDeleteEventArgs e)
        {
            if (e.Row.RowState != DataRowState.Added)
            {
                if (iString.ISNull(e.Row["DPR_ASSET_ID"]) == string.Empty)
                {
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10232"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    e.Cancel = true;
                    return;
                }
            }
        }

        #endregion

    }
}