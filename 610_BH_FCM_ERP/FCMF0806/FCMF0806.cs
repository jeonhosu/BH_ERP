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

namespace FCMF0806
{
    public partial class FCMF0806 : Office2007Form
    {
        #region ----- Variables -----

        ISFunction.ISConvert iString = new ISFunction.ISConvert();
        ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        #endregion;

        #region ----- Constructor -----

        public FCMF0806()
        {
            InitializeComponent();
        }

        public FCMF0806(Form pMainForm, ISAppInterface pAppInterface)
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

            idaCREDIT_CARD_1.Fill();
            idaPRINT_CREDITCARD_1.Fill();       // 인쇄 전용 그리드.

            igrCREDITCARD_1.Focus();
        }

        private void SetCommonParameter(object pGroup_Code, object pEnabled_YN)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", pGroup_Code);
            ildCOMMON.SetLookupParamValue("W_ENABLED_YN", pEnabled_YN);
        }

        private void SET_GRID_CELL_STATE(DataRow pDataRow)
        {
            bool mREAD_ONLY_YN = true;
            int mINSERT_YN = 0;
            int mUPDATE_YN = 0;
            int mIDX_COL;

            if (pDataRow == null || iString.ISDecimaltoZero(pDataRow["VAT_ID"]) == 0)
            {
                mREAD_ONLY_YN = true;
                mINSERT_YN = 0;
                mUPDATE_YN = 0;
            }
            else
            {
                mREAD_ONLY_YN = false;
                mINSERT_YN = 1;
                mUPDATE_YN = 1;
            }

            mIDX_COL = igrCREDITCARD_1.GetColumnToIndex("CUSTOMER_DESC");
            igrCREDITCARD_1.GridAdvExColElement[mIDX_COL].ReadOnly = mREAD_ONLY_YN;
            igrCREDITCARD_1.GridAdvExColElement[mIDX_COL].Insertable = mINSERT_YN;
            igrCREDITCARD_1.GridAdvExColElement[mIDX_COL].Updatable = mUPDATE_YN;

            mIDX_COL = igrCREDITCARD_1.GetColumnToIndex("VAT_ISSUE_DATE");
            igrCREDITCARD_1.GridAdvExColElement[mIDX_COL].ReadOnly = mREAD_ONLY_YN;
            igrCREDITCARD_1.GridAdvExColElement[mIDX_COL].Insertable = mINSERT_YN;
            igrCREDITCARD_1.GridAdvExColElement[mIDX_COL].Updatable = mUPDATE_YN;

            mIDX_COL = igrCREDITCARD_1.GetColumnToIndex("GL_AMOUNT");
            igrCREDITCARD_1.GridAdvExColElement[mIDX_COL].ReadOnly = mREAD_ONLY_YN;
            igrCREDITCARD_1.GridAdvExColElement[mIDX_COL].Insertable = mINSERT_YN;
            igrCREDITCARD_1.GridAdvExColElement[mIDX_COL].Updatable = mUPDATE_YN;

            mIDX_COL = igrCREDITCARD_1.GetColumnToIndex("VAT_AMOUNT");
            igrCREDITCARD_1.GridAdvExColElement[mIDX_COL].ReadOnly = mREAD_ONLY_YN;
            igrCREDITCARD_1.GridAdvExColElement[mIDX_COL].Insertable = mINSERT_YN;
            igrCREDITCARD_1.GridAdvExColElement[mIDX_COL].Updatable = mUPDATE_YN;

            mIDX_COL = igrCREDITCARD_1.GetColumnToIndex("CREDITCARD_NUM");
            igrCREDITCARD_1.GridAdvExColElement[mIDX_COL].ReadOnly = mREAD_ONLY_YN;
            igrCREDITCARD_1.GridAdvExColElement[mIDX_COL].Insertable = mINSERT_YN;
            igrCREDITCARD_1.GridAdvExColElement[mIDX_COL].Updatable = mUPDATE_YN;

            igrCREDITCARD_1.ResetDraw = true;
        }

        private void Show_Slip_Detail()
        {
            int mSLIP_HEADER_ID = iString.ISNumtoZero(igrCREDITCARD_1.GetCellValue("SLIP_HEADER_ID"));
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
                idcVAT_PERIOD_TYPE.ExecuteNonQuery();
                string vPeriod = string.Format("( {0} )", idcVAT_PERIOD_TYPE.GetCommandParamValue("O_PERIOD"));

                // open해야 할 파일명 지정.
                //-------------------------------------------------------------------------------------
                xlPrinting.OpenFileNameExcel = "FCMF0806_001.xls";
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
                    vPageNumber = xlPrinting.LineWrite(pGrid, vPeriod);

                    //출력구분에 따른 선택(인쇄 or file 저장)
                    if (pOutChoice == "PRINT")
                    {
                        xlPrinting.Printing(1, vPageNumber);
                    }
                    else if (pOutChoice == "FILE")
                    {
                        xlPrinting.SAVE("VAT_CREDITCARD_");
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
                    if (idaCREDIT_CARD_1.IsFocused)
                    {

                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddUnder)
                {
                    if (idaCREDIT_CARD_1.IsFocused)
                    {

                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Update)
                {
                    if (idaCREDIT_CARD_1.IsFocused)
                    {
                        idaCREDIT_CARD_1.Update();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Cancel)
                {
                    if (idaCREDIT_CARD_1.IsFocused)
                    {
                        idaCREDIT_CARD_1.Cancel();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {
                    if (idaCREDIT_CARD_1.IsFocused)
                    {
                        idaCREDIT_CARD_1.Delete();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Print)
                {
                    if (itbCREDITCARD.SelectedTab.TabIndex == 1)
                    {
                        XLPrinting_1("PRINT", igrPRINT_CREDITCARD_1);
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Export)
                {
                    if (itbCREDITCARD.SelectedTab.TabIndex == 1)
                    {
                        XLPrinting_1("FILE", igrPRINT_CREDITCARD_1);
                    }
                }
            }
        }

        #endregion;

        #region ----- Form Event -----

        private void FCMF0806_Load(object sender, EventArgs e)
        {
            
        }

        private void FCMF0806_Shown(object sender, EventArgs e)
        {
            Set_Default_Value();
        }

        private void igrCREDITCARD_1_CellDoubleClick(object pSender)
        {
            Show_Slip_Detail();
        }

        #endregion

        #region ----- Lookup Event ------

        private void ilaTAX_CODE_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter("TAX_CODE", "Y");
        }

        private void ilaCUSTOMER_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCUSTOMER.SetLookupParamValue("W_ENABLED_YN", "Y");
        }

        private void ilaCREDIT_CARD_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCREDIT_CARD.SetLookupParamValue("W_ENABLED_YN", "Y");
        }

        #endregion

        #region ----- Adapter Event : CreditCard1 -----
        
        private void idaCREDIT_CARD_1_PreNewRowMoved(object pSender, ISBindingEventArgs pBindingManager)
        {
            //본 화면에서는 수정 안함 => 수정사항 발생시 전표 수정.
            //SET_GRID_CELL_STATE(pBindingManager.DataRow);
        }
        
        #endregion


    }
}