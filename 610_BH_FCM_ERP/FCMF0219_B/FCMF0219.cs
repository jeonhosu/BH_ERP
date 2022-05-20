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

namespace FCMF0219
{
    public partial class FCMF0219 : Office2007Form
    {
        #region ----- Variables -----

        ISFunction.ISConvert iString = new ISFunction.ISConvert();
        ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        #endregion;

        #region ----- Constructor -----

        public FCMF0219()
        {
            InitializeComponent();
        }

        public FCMF0219(Form pMainForm, ISAppInterface pAppInterface)
        {
            InitializeComponent();
            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;
        }

        #endregion;

        #region ----- Private Methods ----

        private void Search_DB()
        {
            idaSLIP_LIST_IF.Fill();
            igrSLIP_LIST_IF.Focus();
        }

        private void Set_Control_Item_Prompt()
        {
            idaCONTROL_ITEM_PROMPT.Fill();
            if (idaCONTROL_ITEM_PROMPT.OraSelectData.Rows.Count > 0)
            {
                MANAGEMENT1_PROMPT.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["MANAGEMENT1_NAME"];
                MANAGEMENT2_PROMPT.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["MANAGEMENT2_NAME"];
                REFER1_PROMPT.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["REFER1_NAME"];
                REFER2_PROMPT.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["REFER2_NAME"];
                REFER3_PROMPT.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["REFER3_NAME"];
                REFER4_PROMPT.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["REFER4_NAME"];
                REFER5_PROMPT.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["REFER5_NAME"];
                REFER6_PROMPT.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["REFER6_NAME"];
                REFER7_PROMPT.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["REFER7_NAME"];
                REFER8_PROMPT.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["REFER8_NAME"];
                //REFER_RATE_PROMPT.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["REFER_RATE_NAME"];
                //REFER_AMOUNT_PROMPT.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["REFER_AMOUNT_NAME"];
                //REFER_DATE1_PROMPT.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["REFER_DATE1_NAME"];
                //REFER_DATE2_PROMPT.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["REFER_DATE2_NAME"];

                MANAGEMENT1_YN.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["MANAGEMENT1_YN"];
                MANAGEMENT2_YN.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["MANAGEMENT2_YN"];
                REFER1_YN.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["REFER1_YN"];
                REFER2_YN.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["REFER2_YN"];
                REFER3_YN.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["REFER3_YN"];
                REFER4_YN.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["REFER4_YN"];
                REFER5_YN.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["REFER5_YN"];
                REFER6_YN.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["REFER6_YN"];
                REFER7_YN.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["REFER7_YN"];
                REFER8_YN.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["REFER8_YN"];
                //VOUCH_YN.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["VOUCH_YN"];
                //REFER_RATE_YN.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["REFER_RATE_YN"];
                //REFER_AMOUNT_YN.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["REFER_AMOUNT_YN"];
                //REFER_DATE1_YN.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["REFER_DATE1_YN"];
                //REFER_DATE2_YN.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["REFER_DATE2_YN"];

                MANAGEMENT1_LOOKUP_YN.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["MANAGEMENT1_LOOKUP_YN"];
                MANAGEMENT2_LOOKUP_YN.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["MANAGEMENT2_LOOKUP_YN"];
                REFER1_LOOKUP_YN.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["REFER1_LOOKUP_YN"];
                REFER2_LOOKUP_YN.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["REFER2_LOOKUP_YN"];
                REFER3_LOOKUP_YN.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["REFER3_LOOKUP_YN"];
                REFER4_LOOKUP_YN.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["REFER4_LOOKUP_YN"];
                REFER5_LOOKUP_YN.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["REFER5_LOOKUP_YN"];
                REFER6_LOOKUP_YN.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["REFER6_LOOKUP_YN"];
                REFER7_LOOKUP_YN.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["REFER7_LOOKUP_YN"];
                REFER8_LOOKUP_YN.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["REFER8_LOOKUP_YN"];

                MANAGEMENT1_LOOKUP_TYPE.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["MANAGEMENT1_LOOKUP_TYPE"];
                MANAGEMENT2_LOOKUP_TYPE.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["MANAGEMENT2_LOOKUP_TYPE"];
                REFER1_LOOKUP_TYPE.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["REFER1_LOOKUP_TYPE"];
                REFER2_LOOKUP_TYPE.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["REFER2_LOOKUP_TYPE"];
                REFER3_LOOKUP_TYPE.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["REFER3_LOOKUP_TYPE"];
                REFER4_LOOKUP_TYPE.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["REFER4_LOOKUP_TYPE"];
                REFER5_LOOKUP_TYPE.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["REFER5_LOOKUP_TYPE"];
                REFER6_LOOKUP_TYPE.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["REFER6_LOOKUP_TYPE"];
                REFER7_LOOKUP_TYPE.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["REFER7_LOOKUP_TYPE"];
                REFER8_LOOKUP_TYPE.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["REFER8_LOOKUP_TYPE"];

                MANAGEMENT1_DATA_TYPE.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["MANAGEMENT1_DATA_TYPE"];
                MANAGEMENT2_DATA_TYPE.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["MANAGEMENT2_DATA_TYPE"];
                REFER1_DATA_TYPE.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["REFER1_DATA_TYPE"];
                REFER2_DATA_TYPE.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["REFER2_DATA_TYPE"];
                REFER3_DATA_TYPE.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["REFER3_DATA_TYPE"];
                REFER4_DATA_TYPE.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["REFER4_DATA_TYPE"];
                REFER5_DATA_TYPE.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["REFER5_DATA_TYPE"];
                REFER6_DATA_TYPE.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["REFER6_DATA_TYPE"];
                REFER7_DATA_TYPE.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["REFER7_DATA_TYPE"];
                REFER8_DATA_TYPE.EditValue = idaCONTROL_ITEM_PROMPT.CurrentRow["REFER8_DATA_TYPE"];
            }
            else
            {
                MANAGEMENT1_PROMPT.EditValue = null;
                MANAGEMENT2_PROMPT.EditValue = null;
                REFER1_PROMPT.EditValue = null;
                REFER2_PROMPT.EditValue = null;
                REFER3_PROMPT.EditValue = null;
                REFER4_PROMPT.EditValue = null;
                REFER5_PROMPT.EditValue = null;
                REFER6_PROMPT.EditValue = null;
                REFER7_PROMPT.EditValue = null;
                REFER8_PROMPT.EditValue = null;
                //REFER_RATE_PROMPT.EditValue = null;
                //REFER_AMOUNT_PROMPT.EditValue = null;
                //REFER_DATE1_PROMPT.EditValue = null;
                //REFER_DATE2_PROMPT.EditValue = null;

                MANAGEMENT1_YN.EditValue = "F".ToString();
                MANAGEMENT2_YN.EditValue = "F".ToString();
                REFER1_YN.EditValue = "F".ToString();
                REFER2_YN.EditValue = "F".ToString();
                REFER3_YN.EditValue = "F".ToString();
                REFER4_YN.EditValue = "F".ToString();
                REFER5_YN.EditValue = "F".ToString();
                REFER6_YN.EditValue = "F".ToString();
                REFER7_YN.EditValue = "F".ToString();
                REFER8_YN.EditValue = "F".ToString();
                //VOUCH_YN.EditValue = "F".ToString();
                //REFER_RATE_YN.EditValue = "F".ToString();
                //REFER_AMOUNT_YN.EditValue = "F".ToString();
                //REFER_DATE1_YN.EditValue = "F".ToString();
                //REFER_DATE2_YN.EditValue = "F".ToString();


                MANAGEMENT1_LOOKUP_YN.EditValue = "N".ToString();
                MANAGEMENT2_LOOKUP_YN.EditValue = "N".ToString();
                REFER1_LOOKUP_YN.EditValue = "N".ToString();
                REFER2_LOOKUP_YN.EditValue = "N".ToString();
                REFER3_LOOKUP_YN.EditValue = "N".ToString();
                REFER4_LOOKUP_YN.EditValue = "N".ToString();
                REFER5_LOOKUP_YN.EditValue = "N".ToString();
                REFER6_LOOKUP_YN.EditValue = "N".ToString();
                REFER7_LOOKUP_YN.EditValue = "N".ToString();
                REFER8_LOOKUP_YN.EditValue = "N".ToString();

                MANAGEMENT1_LOOKUP_TYPE.EditValue = null;
                MANAGEMENT2_LOOKUP_TYPE.EditValue = null;
                REFER1_LOOKUP_TYPE.EditValue = null;
                REFER2_LOOKUP_TYPE.EditValue = null;
                REFER3_LOOKUP_TYPE.EditValue = null;
                REFER4_LOOKUP_TYPE.EditValue = null;
                REFER5_LOOKUP_TYPE.EditValue = null;
                REFER6_LOOKUP_TYPE.EditValue = null;
                REFER7_LOOKUP_TYPE.EditValue = null;
                REFER8_LOOKUP_TYPE.EditValue = null;

                MANAGEMENT1_DATA_TYPE.EditValue = "VARCHAR2".ToString();
                MANAGEMENT2_DATA_TYPE.EditValue = "VARCHAR2".ToString();
                REFER1_DATA_TYPE.EditValue = "VARCHAR2".ToString();
                REFER2_DATA_TYPE.EditValue = "VARCHAR2".ToString();
                REFER3_DATA_TYPE.EditValue = "VARCHAR2".ToString();
                REFER4_DATA_TYPE.EditValue = "VARCHAR2".ToString();
                REFER5_DATA_TYPE.EditValue = "VARCHAR2".ToString();
                REFER6_DATA_TYPE.EditValue = "VARCHAR2".ToString();
                REFER7_DATA_TYPE.EditValue = "VARCHAR2".ToString();
                REFER8_DATA_TYPE.EditValue = "VARCHAR2".ToString();
            }
        }

        private void SetCommonParameter(string pGroup_Code, string pEnabled_YN)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", pGroup_Code);
            ildCOMMON.SetLookupParamValue("W_ENABLED_YN", pEnabled_YN);
        }

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

        private void DefaultSetDate1()
        {
            DateTime vGetDateTime = GetDate();

            ISCommonUtil.ISFunction.ISDateTime vDate = new ISCommonUtil.ISFunction.ISDateTime();
            DateTime vMonthFirstDay = vDate.ISMonth_1st(vGetDateTime);

            SLIP_DATE_FR_0.EditValue = vMonthFirstDay;
            SLIP_DATE_TO_0.EditValue = vGetDateTime;
        }

        #endregion;

        #region ----- XL Export Methods ----

        private void ExportXL(ISDataAdapter pAdapter)
        {
            int vCountRow = pAdapter.OraSelectData.Rows.Count;
            if (vCountRow < 1)
            {
                return;
            }

            string vsMessage = string.Empty;
            string vsSheetName = "Slip_Line";

            saveFileDialog1.Title = "Excel_Save";
            saveFileDialog1.FileName = "XL_00";
            saveFileDialog1.DefaultExt = "xls";
            System.IO.DirectoryInfo vSaveFolder = new System.IO.DirectoryInfo(System.Environment.GetFolderPath(Environment.SpecialFolder.Desktop));
            saveFileDialog1.InitialDirectory = vSaveFolder.FullName;
            saveFileDialog1.Filter = "Excel Files (*.xls)|*.xls";
            if (saveFileDialog1.ShowDialog() == System.Windows.Forms.DialogResult.OK)
            {
                string vsSaveExcelFileName = saveFileDialog1.FileName;
                XL.XLPrint xlExport = new XL.XLPrint();
                bool vXLSaveOK = xlExport.XLExport(pAdapter.OraSelectData, vsSaveExcelFileName, vsSheetName);
                if (vXLSaveOK == true)
                {
                    vsMessage = string.Format("Save OK [{0}]", vsSaveExcelFileName);
                    MessageBoxAdv.Show(vsMessage);
                }
                else
                {
                    vsMessage = string.Format("Save Err [{0}]", vsSaveExcelFileName);
                    MessageBoxAdv.Show(vsMessage);
                }
                xlExport.XLClose();
            }
        }

        #endregion;

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

        #region ----- XL Print 1 Methods ----

        private void XLPrinting1()
        {
            string vMessageText = string.Empty;
            int vPageTotal = 0;
            int vPageNumber = 0;

            int vTerritory = GetTerritory(isAppInterfaceAdv1.AppInterface.OraConnectionInfo.TerritoryLanguage);

            int vCountRowGrid = igrSLIP_LIST_IF.RowCount;
            if (vCountRowGrid > 0)
            {
                vMessageText = string.Format("Printing Start");
                isAppInterfaceAdv1.AppInterface.OnAppMessageEvent(vMessageText);
                System.Windows.Forms.Application.DoEvents();


                System.Windows.Forms.Application.UseWaitCursor = true;
                this.Cursor = System.Windows.Forms.Cursors.WaitCursor;
                System.Windows.Forms.Application.DoEvents();


                int vIndexCheckBox = igrSLIP_LIST_IF.GetColumnToIndex("CHECK_BOX");
                string vCheckedString = igrSLIP_LIST_IF.GridAdvExColElement[vIndexCheckBox].CheckedString;
                //-------------------------------------------------------------------------------------
                for (int vRow = 0; vRow < vCountRowGrid; vRow++)
                {
                    igrSLIP_LIST_IF.CurrentCellMoveTo(vRow, vIndexCheckBox);
                    igrSLIP_LIST_IF.Focus();
                    igrSLIP_LIST_IF.CurrentCellActivate(vRow, vIndexCheckBox);

                    object vObject = igrSLIP_LIST_IF.GetCellValue(vRow, vIndexCheckBox);
                    if (vObject != null)
                    {
                        bool IsConvert = vObject is string;
                        if (IsConvert == true)
                        {
                            string vBoxCheck = vObject as string;
                            if (vBoxCheck == vCheckedString)
                            {
                                //-------------------------------------------------------------------------------------
                                XLPrinting xlPrinting = new XLPrinting(isAppInterfaceAdv1.AppInterface);

                                try
                                {
                                    //-------------------------------------------------------------------------------------
                                    xlPrinting.OpenFileNameExcel = "FCMF0219_001.xls";
                                    xlPrinting.PrintingLineMAX = 57;         //엑셀에 출력될 총 라인
                                    xlPrinting.IncrementCopyMAX = 67;        //엑셀 쉬트에 복사될 총 라인수
                                    xlPrinting.PositionPrintLineSTART = 18;  //라인 출력시 엑셀 시작 행 위치 지정
                                    xlPrinting.CopySumPrintingLine = 1;      //엑셀의 선택된 쉬트의 복사되어질 시작 행 위치
                                    //-------------------------------------------------------------------------------------

                                    //-------------------------------------------------------------------------------------
                                    bool isOpen = xlPrinting.XLFileOpen();
                                    //-------------------------------------------------------------------------------------

                                    if (isOpen == true)
                                    {
                                        //-------------------------------------------------------------------------------------
                                        xlPrinting.HeaderWrite(igrSLIP_LIST_IF, vRow);

                                        vPageNumber = xlPrinting.LineWrite(ilaSLIP_LINE_PRINT);

                                        xlPrinting.Printing(1, vPageNumber); //시작 페이지 번호, 종료 페이지 번호
                                        ////xlPrinting.Printing(3, 4);

                                        //Check한 Lot, 하나 하나를 저장 및 인쇄한다. Excel Object가 Lot 갯수 만큼 메모리에 생성 된다.
                                        //xlPrinting.Save("SLIP_"); //저장 파일명
                                        //-------------------------------------------------------------------------------------
                                    }

                                    //-------------------------------------------------------------------------------------
                                    xlPrinting.Dispose();
                                    //-------------------------------------------------------------------------------------
                                }
                                catch (System.Exception ex)
                                {
                                    string vMessage = ex.Message;
                                    xlPrinting.Dispose();
                                }
                                //-------------------------------------------------------------------------------------

                                vPageTotal = vPageTotal + vPageNumber;
                            }
                        }
                    }
                }
                //-------------------------------------------------------------------------------------
            }

            //-------------------------------------------------------------------------
            vMessageText = string.Format("Print End ^.^ [Tatal Page : {0}]", vPageTotal);
            isAppInterfaceAdv1.AppInterface.OnAppMessageEvent(vMessageText);
            System.Windows.Forms.Application.DoEvents();


            System.Windows.Forms.Application.UseWaitCursor = false;
            this.Cursor = System.Windows.Forms.Cursors.Default;
            System.Windows.Forms.Application.DoEvents();

            idaSLIP_LIST_IF.OraSelectData.AcceptChanges();
            idaSLIP_LIST_IF.Refillable = true;
        }

        #endregion;

        #region ----- Initialize Event -----

        private void Init_GL_Amount()
        {
            GL_AMOUNT.EditValue = iString.ISDecimaltoZero(GL_CURRENCY_AMOUNT.EditValue) * iString.ISDecimaltoZero(EXCHANGE_RATE.EditValue);
        }

        private void Init_DR_CR_Amount()
        {
            SLIP_QUERY_STATUS.EditValue = "NON-QUERY";
            if (igrSLIP_LINE.RowCount > 0)
            {
            }
            Init_Total_GL_Amount();
        }

        private void Init_Total_GL_Amount()
        {
            SLIP_QUERY_STATUS.EditValue = "NON-QUERY";
            decimal vDR_Amount = Convert.ToDecimal(0);
            decimal vCR_Amount = Convert.ToDecimal(0);
            decimal vCurrency_DR_Amount = Convert.ToInt32(0);
            if (igrSLIP_LINE.RowCount > 0)
            {
                for (int r = 0; r < igrSLIP_LINE.RowCount; r++)
                {
                    if (iString.ISNull(igrSLIP_LINE.GetCellValue(r, igrSLIP_LINE.GetColumnToIndex("ACCOUNT_DR_CR")), "3") == "1".ToString())
                    {
                        vDR_Amount = vDR_Amount + iString.ISDecimaltoZero(igrSLIP_LINE.GetCellValue(r, igrSLIP_LINE.GetColumnToIndex("GL_AMOUNT")));
                        vCurrency_DR_Amount = vCurrency_DR_Amount + iString.ISDecimaltoZero(igrSLIP_LINE.GetCellValue(r, igrSLIP_LINE.GetColumnToIndex("GL_CURRENCY_AMOUNT")));
                    }
                    else if (iString.ISNull(igrSLIP_LINE.GetCellValue(r, igrSLIP_LINE.GetColumnToIndex("ACCOUNT_DR_CR")), "3") == "2".ToString())
                    {
                        vCR_Amount = vCR_Amount + iString.ISDecimaltoZero(igrSLIP_LINE.GetCellValue(r, igrSLIP_LINE.GetColumnToIndex("GL_AMOUNT")));
                    }
                }
            }       
            TOTAL_DR_AMOUNT.EditValue = iString.ISDecimaltoZero(vDR_Amount);
            TOTAL_CR_AMOUNT.EditValue = iString.ISDecimaltoZero(vCR_Amount);
            MARGIN_AMOUNT.EditValue = -(System.Math.Abs(iString.ISDecimaltoZero(vDR_Amount) - iString.ISDecimaltoZero(vCR_Amount))); ;
        }

        #endregion

        #region ----- Lookup Event -----

        private void ilaSLIP_NUM_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildSLIP_NUM.SetLookupParamValue("W_SLIP_TYPE_CLASS", null);
        }

        private void ilaSLIP_TYPE_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            SetCommonParameter("SLIP_TYPE", "Y");
        }

        private void ilaDEPT_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildDEPT.SetLookupParamValue("W_ENABLED_YN", "Y");
        }

        #endregion

        #region ----- Form Event -----

        private void FCMF0219_Load(object sender, EventArgs e)
        {
            idaSLIP_HEADER_IF.FillSchema();
            SLIP_QUERY_STATUS.EditValue = "NON-QUERY";
            //SLIP_DATE_FR_0.EditValue = iDate.ISDate_Add(DateTime.Today, -7);
            //SLIP_DATE_TO_0.EditValue = iDate.ISGetDate();

            DefaultSetDate1();
        }

        private void igrSLIP_LIST_CellDoubleClick(object pSender)
        {
            if (igrSLIP_LIST_IF.RowIndex > -1)
            {
                if (iString.ISNull(igrSLIP_LIST_IF.GetCellValue("HEADER_INTERFACE_ID")) != string.Empty)
                {
                    idaSLIP_LIST_IF.MoveFocus = true;

                    SLIP_QUERY_STATUS.EditValue = "QUERY";
                    itbSLIP.SelectedIndex = 1;
                    itbSLIP.SelectedTab.Focus();
                    idaSLIP_HEADER_IF.SetSelectParamValue("W_HEADER_INTERFACE_ID", igrSLIP_LIST_IF.GetCellValue("HEADER_INTERFACE_ID"));
                    idaSLIP_HEADER_IF.Fill();
                    SLIP_TYPE_NAME.Focus();
                }
            }
        }

        private void idaSLIP_LINE_NewRowMoved(object pSender, ISBindingEventArgs pBindingManager)
        {
            Search_Control_Item_Prompt();
            if (SLIP_QUERY_STATUS.EditValue.ToString() != "QUERY".ToString())
            {
                Init_DR_CR_Amount();
            }
            Init_Total_GL_Amount();
            idaSLIP_LINE_IF.OraSelectData.AcceptChanges();
            idaSLIP_LINE_IF.Refillable = true;
        }

        private void Search_Control_Item_Prompt()
        {
            Init_Control_Item_Value();
            Set_Control_Item_Prompt();
        }

        private void Init_Control_Item_Value()
        {
            MANAGEMENT1_PROMPT.EditValue = null;
            MANAGEMENT2_PROMPT.EditValue = null;
            REFER1_PROMPT.EditValue = null;
            REFER2_PROMPT.EditValue = null;
            REFER3_PROMPT.EditValue = null;
            REFER4_PROMPT.EditValue = null;
            REFER5_PROMPT.EditValue = null;

            idaCONTROL_ITEM_PROMPT.Cancel();
        }

        #endregion

        #region ----- Events -----

        private void isAppInterfaceAdv1_AppMainButtonClick(ISAppButtonEvents e)
        {
            if (this.IsActive)
            {
                if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Search)
                {
                    Search_DB();
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
                    if (idaSLIP_LIST_IF.IsFocused == true)
                    {
                        idaSLIP_LIST_IF.Cancel();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Print)
                {
                    XLPrinting1();
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Export)
                {
                    ExportXL(idaSLIP_LIST_IF);
                }
            }
        }

        #endregion;

    }
}