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

namespace FCMF0716
{
    public partial class FCMF0716 : Office2007Form
    {
        #region ----- Variables -----

        ISFunction.ISConvert iString = new ISFunction.ISConvert();
        ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        private string mCompany = string.Empty;

        #endregion;

        #region ----- Constructor -----

        public FCMF0716()
        {
            InitializeComponent();
        }

        public FCMF0716(Form pMainForm, ISAppInterface pAppInterface)
        {
            InitializeComponent();
            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;
        }

        #endregion;

        #region ----- Private Methods ----

        private void SearchDB()
        {
            if (iString.ISNull(PERIOD_NAME_0.EditValue) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10036"), "Waring", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                PERIOD_NAME_0.Focus();
                return;
            }
            SetGridPeriod();

            idaBALANCE_MS.Fill();
            igrBALANCE_MS.Focus();
        }

        private void SetGridPeriod()
        {
            if (iString.ISNull(PERIOD_NAME_0.EditValue) == string.Empty)
            {
                return;
            }
            DateTime mCurrent_Date;
            object mYEAR_COUNT;

            // 당기 기간/회계기수 설정
            idcPROMPT_YEAR.SetCommandParamValue("W_PERIOD_NAME", PERIOD_NAME_0.EditValue);
            idcPROMPT_YEAR.ExecuteNonQuery();
            mYEAR_COUNT = idcPROMPT_YEAR.GetCommandParamValue("O_PROMPT");
            igrBALANCE_MS.GridAdvExColElement[2].HeaderElement[1].TL1_KR = iString.ISNull(mYEAR_COUNT);

            idcPROMPT_PERIOD_YEAR.SetCommandParamValue("W_PERIOD_NAME", PERIOD_NAME_0.EditValue);
            idcPROMPT_PERIOD_YEAR.ExecuteNonQuery();
            THIS_YEAR_PERIOD.EditValue = idcPROMPT_PERIOD_YEAR.GetCommandParamValue("O_PROMPT");

            // 전기 기간/회계기수 설정
            mCurrent_Date = Convert.ToDateTime(string.Format("{0}{1}", PERIOD_NAME_0.EditValue, "-01"));
            mCurrent_Date = Convert.ToDateTime(string.Format("{0}-{1}-{2}", mCurrent_Date.Year - 1, mCurrent_Date.Month, "01"));
            idcPROMPT_YEAR.SetCommandParamValue("W_PERIOD_NAME", iDate.ISYearMonth(mCurrent_Date));
            idcPROMPT_YEAR.ExecuteNonQuery();
            mYEAR_COUNT = idcPROMPT_YEAR.GetCommandParamValue("O_PROMPT");
            igrBALANCE_MS.GridAdvExColElement[4].HeaderElement[1].TL1_KR = iString.ISNull(mYEAR_COUNT);

            idcPROMPT_PERIOD_YEAR.SetCommandParamValue("W_PERIOD_NAME", iDate.ISYearMonth(mCurrent_Date));
            idcPROMPT_PERIOD_YEAR.ExecuteNonQuery();
            PREVIOUS_YEAR_PERIOD.EditValue = idcPROMPT_PERIOD_YEAR.GetCommandParamValue("O_PROMPT");

            igrBALANCE_MS.ResetDraw = true;
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
                    if (idaBALANCE_MS.IsFocused)
                    {
                        idaBALANCE_MS.Cancel();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {
                    if (idaBALANCE_MS.IsFocused)
                    {
                        idaBALANCE_MS.Delete();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Print)
                {
                    XLPrinting(igrBALANCE_MS, "PRINT");
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Export)
                {
                    XLPrinting(igrBALANCE_MS, "FILE");
                }
            }
        }

        #endregion;

        #region ----- Form Event -----

        private void FCMF0716_Load(object sender, EventArgs e)
        {
            CompanySearch();
        }

        private void FCMF0716_Shown(object sender, EventArgs e)
        {
            PERIOD_NAME_0.EditValue = iDate.ISYearMonth(DateTime.Today);
            SetGridPeriod();
        }

        #endregion
        
        #region ----- Lookup Event -----

        private void ilaPERIOD_NAME_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {

        }

        #endregion



        #region ----- Territory Get Methods ----

        private int GetTerritory(ISUtil.Enum.TerritoryLanguage pTerritoryEnum)
        {
            int vTerritory = 0;

            switch (pTerritoryEnum)
            {
                case ISUtil.Enum.TerritoryLanguage.Default:
                    vTerritory = 1;
                    break;
                case ISUtil.Enum.TerritoryLanguage.TL1_KR:
                    vTerritory = 2;
                    break;
                case ISUtil.Enum.TerritoryLanguage.TL2_CN:
                    vTerritory = 3;
                    break;
                case ISUtil.Enum.TerritoryLanguage.TL3_VN:
                    vTerritory = 4;
                    break;
                case ISUtil.Enum.TerritoryLanguage.TL4_JP:
                    vTerritory = 5;
                    break;
                case ISUtil.Enum.TerritoryLanguage.TL5_XAA:
                    vTerritory = 6;
                    break;
            }

            return vTerritory;
        }

        #endregion;

        #region ----- XL Print Methods ----

        private void XLPrinting(InfoSummit.Win.ControlAdv.ISGridAdvEx pGrid, string pOutChoice)
        {
            System.Windows.Forms.Application.UseWaitCursor = true;
            this.Cursor = System.Windows.Forms.Cursors.WaitCursor;
            System.Windows.Forms.Application.DoEvents();

            string vMessageText = string.Empty;
            int vPageTotal = 0;
            int vPageNumber = 0;

            int vTerritory = GetTerritory(isAppInterfaceAdv1.AppInterface.OraConnectionInfo.TerritoryLanguage);

            object vThisYearPeriod = THIS_YEAR_PERIOD.EditValue;
            object vPreviousYearPeriod = PREVIOUS_YEAR_PERIOD.EditValue;

            string vHeaderThis = null;
            string vHeaderPrevious = null;

            if (vTerritory == 1)
            {
                vHeaderThis = pGrid.GridAdvExColElement[2].HeaderElement[1].Default;
                vHeaderPrevious = pGrid.GridAdvExColElement[4].HeaderElement[1].Default;
            }
            else if (vTerritory == 2)
            {
                vHeaderThis = pGrid.GridAdvExColElement[2].HeaderElement[1].TL1_KR;
                vHeaderPrevious = pGrid.GridAdvExColElement[4].HeaderElement[1].TL1_KR;
            }

            int vCountRowGrid = pGrid.RowCount;
            if (vCountRowGrid > 0)
            {
                vMessageText = string.Format("Printing Starting");
                isAppInterfaceAdv1.OnAppMessage(vMessageText);
                System.Windows.Forms.Application.DoEvents();

                XLPrinting xlPrinting = new XLPrinting(isAppInterfaceAdv1.AppInterface, isMessageAdapter1);

                try
                {
                    //-------------------------------------------------------------------------------------
                    if (mCompany == "Flex_ERP_FC")
                    {
                        xlPrinting.OpenFileNameExcel = "FCMF0716_001.xls";
                    }
                    else if (mCompany == "Flex_ERP_BH")
                    {
                    }
                    //-------------------------------------------------------------------------------------

                    //-------------------------------------------------------------------------------------
                    bool isOpen = xlPrinting.XLFileOpen();
                    //-------------------------------------------------------------------------------------

                    //-------------------------------------------------------------------------------------
                    if (isOpen == true)
                    {
                        vPageNumber = xlPrinting.LineWrite(pGrid, vThisYearPeriod, vPreviousYearPeriod, vHeaderThis, vHeaderPrevious);

                        if (pOutChoice == "PRINT")
                        {
                            ////[PRINT]
                            ////xlPrinting.Printing(3, 4); //시작 페이지 번호, 종료 페이지 번호
                            xlPrinting.Printing(1, vPageNumber);
                        }
                        else if (pOutChoice == "FILE")
                        {

                            ////[SAVE]
                            xlPrinting.Save("COST_"); //저장 파일명
                        }


                        vPageTotal = vPageTotal + vPageNumber;
                    }
                    //-------------------------------------------------------------------------------------

                    //-------------------------------------------------------------------------------------
                    xlPrinting.Dispose();
                    //-------------------------------------------------------------------------------------
                }
                catch (System.Exception ex)
                {
                    string vMessage = ex.Message;
                    xlPrinting.Dispose();
                }
            }

            //-------------------------------------------------------------------------
            vMessageText = string.Format("Print End [Total Page : {0}]", vPageTotal);
            isAppInterfaceAdv1.AppInterface.OnAppMessageEvent(vMessageText);
            System.Windows.Forms.Application.DoEvents();

            System.Windows.Forms.Application.UseWaitCursor = false;
            this.Cursor = System.Windows.Forms.Cursors.Default;
            System.Windows.Forms.Application.DoEvents();
        }

        #endregion;

        #region ----- Company Search Methods ----

        private void CompanySearch()
        {
            string vStartupPath = System.Windows.Forms.Application.StartupPath;
            //vStartupPath = "C:\\Program Files\\Flex_ERP_FC\\Kor";
            //vStartupPath = "C:\\Program Files\\Flex_ERP_BH\\Kor";


            int vCutStart = vStartupPath.LastIndexOf("\\");
            string vCutStringFiRST = vStartupPath.Substring(0, vCutStart);

            vCutStart = vCutStringFiRST.LastIndexOf("\\") + 1;
            int vCutLength = vCutStringFiRST.Length - vCutStart;
            mCompany = vCutStringFiRST.Substring(vCutStart, vCutLength);
        }

        #endregion;

    }
}