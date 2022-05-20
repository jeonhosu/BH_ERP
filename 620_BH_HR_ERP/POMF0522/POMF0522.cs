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

namespace POMF0522
{
    public partial class POMF0522 : Office2007Form
    {
        ISFunction.ISConvert iString = new ISFunction.ISConvert();
        ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        #region ----- Variables -----

        private string mRadioValue = string.Empty;
        ISCommonUtil.ISFunction.ISConvert iConvert = new ISFunction.ISConvert();

        #endregion;

        #region ----- Constructor -----

        public POMF0522(Form pMainForm, ISAppInterface pAppInterface)
        {
            InitializeComponent();
            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;
        }

        #endregion;

        #region ----- Private Methods ----
        private void Header_Setting()
        {
            iedPO_PERSON_ID.EditValue = isAppInterfaceAdv1.PERSON_ID;
            iedPO_PERSON_NAME.EditValue = isAppInterfaceAdv1.DISPLAY_NAME;

            iedPO_DEPT_ID.EditValue = isAppInterfaceAdv1.DEPT_ID;
            iedPO_DEPT_NAME.EditValue = isAppInterfaceAdv1.DEPT_NAME;

            iedPO_DATE.EditValue = DateTime.Today;

            isDataCommand1.ExecuteNonQuery();

            //IDA_REQUEST.Refillable = true;  // ADDED, BY MJSHIN
            //IDA_REQUEST.Fill();             // ADDED, BY MJSHIN

            SUPPLIER_ENABLE();              // ADDED, BY MJSHIN
            //BUTTON_ENABLE();                // ADDED, BY MJSHIN
        }
        
 


        //======================================================================================================
        // 라인의 전체 발주금액 구하는 루틴
        //======================================================================================================
        private void Group_Total_Amount()
        {
            Decimal vAmount = 0;

            for (int i = 0; i < ISG_LINE.RowCount; i++)
            {
                vAmount += (Convert.ToDecimal(ISG_LINE.GetCellValue(i, ISG_LINE.GetColumnToIndex("ITEM_AMOUNT"))));
            }

            iedTOTAL_AMOUNT.EditValue = vAmount;
        }
        //======================================================================================================
 
        #endregion;

        #region ----- Events -----

        private void isAppInterfaceAdv1_AppMainButtonClick(ISAppButtonEvents e)
        {
            if (this.IsActive)
            {
                if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Search)
                {
                    if (TAB_MAIN.SelectedIndex == 0)
                    {
                        IDA_HEADER.Fill();
                    }
                    else if (TAB_MAIN.SelectedIndex == 1)
                    {
                        IDA_PO_LIST.Fill();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddOver)
                {
                    if (IDA_HEADER.IsFocused)
                    {
                        IDA_HEADER.AddOver();
                        Header_Setting();
                    }
                    else if (IDA_LINE.IsFocused)
                    {
                        IDA_LINE.AddOver();
                    }
                    
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddUnder)
                {
                    if (IDA_HEADER.IsFocused)
                    {
                        IDA_HEADER.AddUnder();
                        Header_Setting();
                    }
                    else if (IDA_LINE.IsFocused)
                    {
                        IDA_LINE.AddUnder();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Update)
                {
                    if ((iedHEADER_STATUS.EditValue.ToString() != "CPO") && (iedHEADER_STATUS.EditValue.ToString() != ""))
                    {
                        MessageBoxAdv.Show(isMessageAdapter1.ReturnText("PO_10002"), "WARRING", MessageBoxButtons.OK, MessageBoxIcon.Warning);

                        return;
                    }


                    //if (isLINE_DA.VisbleCurrentRowCount == 0)
                    //{
                    //    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("PO_10005"), "WARRING", MessageBoxButtons.OK, MessageBoxIcon.Warning);

                    //    return;
                    //}
                     
                    IDA_HEADER.Update();
                    IDA_HEADER.Fill();
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Cancel)
                {
                    if (IDA_HEADER.IsFocused)
                    {
                        IDA_HEADER.Cancel();
                    }
                    else if (IDA_LINE.IsFocused)
                    {
                        IDA_LINE.Cancel();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {

                    if (IDA_HEADER.IsFocused)
                    {
                        IDA_HEADER.Delete();
                    }
                    else if (IDA_LINE.IsFocused)
                    {
                        IDA_LINE.Delete();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Print)
                {
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Export)
                {
                }
            }
        }


        #endregion;

        #region ----- Form Events -----

        private void POMF0522_Load(object sender, EventArgs e)
        {
            V_DATE_FR.EditValue = iDate.ISMonth_1st(DateTime.Today);
            V_DATE_TO.EditValue = DateTime.Today;

            IDA_HEADER.FillSchema();

            RD_ALL.Checked = true;
            V_DELIVERY_FLAG.EditValue = Convert.ToString("A");
        }

 
        private void isHEADER_DA_ExcuteKeySearch(object pSender)
        {

            IDA_HEADER.Fill();
            Group_Total_Amount();

            SUPPLIER_ENABLE();  // ADDED, BY MJSHIN
        }

        private void isGridAdvEx1_CurrentCellValidating(object pSender, ISGridAdvExValidatingEventArgs e)
        {
            switch (ISG_LINE.GridAdvExColElement[e.ColIndex].DataColumn.ToString())
            {
                case "ADJUST_QTY":

                    ISG_LINE.SetCellValue("PO_QTY", Convert.ToDecimal(e.NewValue) + Convert.ToDecimal(ISG_LINE.GetCellValue("REQUEST_QTY")));
                    ISG_LINE.SetCellValue("ITEM_AMOUNT", (Convert.ToDecimal(e.NewValue) + Convert.ToDecimal(ISG_LINE.GetCellValue("REQUEST_QTY"))) * Convert.ToDecimal(ISG_LINE.GetCellValue("ITEM_PRICE")));

                    Group_Total_Amount();
                    break;

                case "ITEM_PRICE":
                    ISG_LINE.SetCellValue("ITEM_AMOUNT", Convert.ToDecimal(e.NewValue) * Convert.ToDecimal(ISG_LINE.GetCellValue("PO_QTY")));

                    Group_Total_Amount();
                    break;

                default:
                    break;
            }
        }

        private void iedPO_DATE_CurrentEditValidating(object pSender, ISEditAdvValidatingEventArgs e)
        {
            if (iedPO_DATE.DateTimeValue > DateTime.Today)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("PO_10001"), "WARRING", MessageBoxButtons.OK, MessageBoxIcon.Warning);

                iedPO_DATE.EditValue = DateTime.Today;
            }
        }

        private void isSUPPLIER_LA_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            //isSUPPLIER_LD.SetLookupParamValue("W_CLASS_CODE", "PO");

            //if (isLINE_DA.VisbleCurrentRowCount > 0)
            //{
            //    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("PO_10003"), "WARRING", MessageBoxButtons.OK, MessageBoxIcon.Warning);

            //    e.Cancel = true;
            //}
        }



        private void isSUPPLIER_LA2_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            //isSUPPLIER_LD2.SetLookupParamValue("W_CLASS_CODE", "PO");
        }

        private void isSUPPLIER_LA2_SelectedRowData(object pSender)
        {
            isDataCommand2.ExecuteNonQuery();
        }

        private void SUPPLIER_ENABLE()  // ADDED, BY MJSHIN
        {
            if (ISG_LINE.RowCount != 0)
            {
                iedSUPPLIER_NAME.Insertable = false;
                iedSUPPLIER_NAME.Updatable = false;
                iedSUPPLIER_NAME.Refresh();
                //iedCURRENCY_CODE.Insertable = false;  // 통화수정가능토록 변경, 2011-08-26, By MJSHIN // 
                //iedCURRENCY_CODE.Updatable = false;
                //iedCURRENCY_CODE.Refresh();
            }
            else
            {
                iedSUPPLIER_NAME.Insertable = true;
                iedSUPPLIER_NAME.Updatable = true;
                iedSUPPLIER_NAME.Refresh();
                //iedCURRENCY_CODE.Insertable = true;
                //iedCURRENCY_CODE.Updatable = true;
                //iedCURRENCY_CODE.Refresh();
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

        #region ----- Convert String Methods ----

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
            catch
            {
            }

            return vString;
        }

        #endregion;

        #region ----- Export File Name Methods ----

        private string SetExportFileName(string pExportFileName)
        {
            string vExportFileName = string.Empty;

            try
            {
                vExportFileName = pExportFileName;
                vExportFileName = vExportFileName.Replace("/", "_");
                vExportFileName = vExportFileName.Replace("\\", "_");
                vExportFileName = vExportFileName.Replace("*", "_");
                vExportFileName = vExportFileName.Replace("<", "_");
                vExportFileName = vExportFileName.Replace(">", "_");
                vExportFileName = vExportFileName.Replace("|", "_");
                vExportFileName = vExportFileName.Replace("?", "_");
                vExportFileName = vExportFileName.Replace(":", "_");
                vExportFileName = vExportFileName.Replace(" ", "_");
            }
            catch
            {
            }

            return vExportFileName;
        }

        #endregion;

        #region ----- XL Print Methods ----

        //private void XLPrinting(int pChoiceXLSheet, string pRadioValue)
        //{
        //    bool isError = false;
        //    string vMessageText = string.Empty;
        //    string vSaveFileName = string.Empty;

        //    //저장 파일 이름 : 매출처_PO_No
        //    string vFirst = ConvertString(iedSUPPLIER_NAME.EditValue); //매출처
        //    string vSecond = ConvertString(iedPO_NO.EditValue);        //PO_No
        //    vSaveFileName = string.Format("{0}_{1}_{2:D2}", vFirst, vSecond, pChoiceXLSheet);
        //    vSaveFileName = SetExportFileName(vSaveFileName);

        //    int vCountRowDB = IDA_HEADER.OraSelectData.Rows.Count;

        //    if (vCountRowDB < 1)
        //    {
        //        vMessageText = string.Format("Without Data");
        //        isAppInterfaceAdv1.OnAppMessage(vMessageText);
        //        System.Windows.Forms.Application.DoEvents();
        //        return;
        //    }

        //    if (pRadioValue == "EXCEL" || pRadioValue == "PDF")
        //    {
        //        if (pRadioValue == "EXCEL")
        //        {
        //            saveFileDialog1.Title = "Excel Save";
        //            saveFileDialog1.DefaultExt = "xls";
        //            saveFileDialog1.Filter = "Excel Files *.xls|*.xls";
        //        }
        //        else if (pRadioValue == "PDF")
        //        {
        //            saveFileDialog1.Title = "PDF Save";
        //            saveFileDialog1.DefaultExt = "pdf";
        //            saveFileDialog1.Filter = "PDF Files *.pdf|*.pdf";
        //        }

        //        saveFileDialog1.FileName = vSaveFileName;
        //        System.IO.DirectoryInfo vSaveFolder = new System.IO.DirectoryInfo(System.Environment.GetFolderPath(Environment.SpecialFolder.Desktop));
        //        saveFileDialog1.InitialDirectory = vSaveFolder.FullName;
        //        if (saveFileDialog1.ShowDialog() != System.Windows.Forms.DialogResult.OK)
        //        {
        //            return;
        //        }

        //        vSaveFileName = saveFileDialog1.FileName;
        //    }

        //    System.Windows.Forms.Application.UseWaitCursor = true;
        //    this.Cursor = System.Windows.Forms.Cursors.WaitCursor;
        //    System.Windows.Forms.Application.DoEvents();

        //    int vPageNumber = 0;
        //    int vTerritory = GetTerritory(isAppInterfaceAdv1.AppInterface.OraConnectionInfo.TerritoryLanguage);

        //    vMessageText = string.Format(" Printing Starting");
        //    isAppInterfaceAdv1.OnAppMessage(vMessageText);
        //    System.Windows.Forms.Application.DoEvents();

        //    //XLPrinting xlPrinting = new XLPrinting(isAppInterfaceAdv1.AppInterface, isMessageAdapter1);

        //    try
        //    {
        //        vMessageText = string.Empty;
        //        string vPrintingDate = string.Format("{0:D2}/{1:D2}", System.DateTime.Now.Month, System.DateTime.Now.Day);
        //        string vPrintingUser = isAppInterfaceAdv1.AppInterface.DisplayName;

        //        //-------------------------------------------------------------------------------------
        //        xlPrinting.OpenFileNameExcel = "POMF0522_001.xls";
        //        //-------------------------------------------------------------------------------------

        //        //-------------------------------------------------------------------------------------
        //        bool isOpen = xlPrinting.XLFileOpen();
        //        //-------------------------------------------------------------------------------------

        //        //-------------------------------------------------------------------------------------
        //        if (isOpen == true)
        //        {
        //            vPageNumber = xlPrinting.LineWrite(pChoiceXLSheet, IDA_HEADER, ISG_LINE, iedTOTAL_AMOUNT);

        //            ////[PRINT]
        //            ////xlPrinting.Printing(3, 4); //시작 페이지 번호, 종료 페이지 번호
        //            //xlPrinting.Printing(1, vPageNumber);

        //            ////[SAVE]
        //            //xlPrinting.Save("ORDER_"); //Excel 저장 파일명
        //            //xlPrinting.PDF("ORDER_");  //PDF   저장 파일명

        //            if (pRadioValue == "PRINT")
        //            {
        //                xlPrinting.Printing(1, vPageNumber);
        //            }
        //            else if (pRadioValue == "EXCEL")
        //            {
        //                xlPrinting.DeleteSheet();
        //                xlPrinting.SAVE(vSaveFileName); //Excel 파일명
        //            }
        //            else if (pRadioValue == "PDF")
        //            {
        //                xlPrinting.DeleteSheet();
        //                xlPrinting.PDF(vSaveFileName);  //PDF 파일명
        //            }

        //            System.Threading.Thread.Sleep(2000);
        //            //-------------------------------------------------------------------------------------
        //            xlPrinting.Dispose();
        //            //-------------------------------------------------------------------------------------
        //        }
        //        else
        //        {
        //            vMessageText = "Excel File Open Error";
        //        }
        //        //-------------------------------------------------------------------------------------
        //    }
        //    catch (System.Exception ex)
        //    {
        //        isError = true;
        //        vMessageText = ex.Message;
        //        xlPrinting.Dispose();
        //    }

        //    if (isError != true)
        //    {
        //        //-------------------------------------------------------------------------------------
        //        vMessageText = string.Format("{0} Printing End [Total Page : {1}]", vMessageText, vPageNumber);
        //        isAppInterfaceAdv1.AppInterface.OnAppMessageEvent(vMessageText);
        //        System.Windows.Forms.Application.DoEvents();
        //        //-------------------------------------------------------------------------------------
        //    }
        //    else
        //    {
        //        MessageBoxAdv.Show(vMessageText, "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
        //    }

        //    xlPrinting.KillProcess_Excel();

        //    System.Windows.Forms.Application.UseWaitCursor = false;
        //    this.Cursor = System.Windows.Forms.Cursors.Default;
        //    System.Windows.Forms.Application.DoEvents();
        //}

        //private void isButton3_ButtonClick(object pSender, EventArgs pEventArgs)
        //{
        //    XLPrinting(1, mRadioValue); //구매 발주(일반)
        //}

        //private void isButton4_ButtonClick(object pSender, EventArgs pEventArgs)
        //{
        //    XLPrinting(2, mRadioValue); //구매 발주(발송)
        //}

        //private void isButton5_ButtonClick(object pSender, EventArgs pEventArgs)
        //{
        //    XLPrinting(3, mRadioValue); //구매 발주(외자)
        //}

        private void isRadioButtonAdv_CheckChanged(object sender, EventArgs e)
        {
            ISRadioButtonAdv vRadio = sender as ISRadioButtonAdv;

            if (vRadio.Checked == true)
            {
                mRadioValue = vRadio.RadioCheckedString;
            }
        }

        private void POMF0522_Shown(object sender, EventArgs e)
        {
            isGroupBox7.BringToFront();
            isRadioButtonAdv1.CheckedState = ISUtil.Enum.CheckedState.Checked;
        }

        #endregion;



        #region  -- Radio Button --
        private void RD_NOT_DELIVERY_CheckChanged(object sender, EventArgs e)
        {
            if (RD_NOT_DELIVERY.Checked == true)
            {
                V_DELIVERY_FLAG.EditValue = RD_NOT_DELIVERY.CheckedString.ToString();
            }
        }

        private void RD_DELIVERY_CheckChanged(object sender, EventArgs e)
        {
            if (RD_DELIVERY.Checked == true)
            {
                V_DELIVERY_FLAG.EditValue = RD_DELIVERY.CheckedString.ToString();
            }
        }

        private void RD_ALL_CheckChanged(object sender, EventArgs e)
        {
            if (RD_ALL.Checked == true)
            {
                V_DELIVERY_FLAG.EditValue = RD_ALL.CheckedString.ToString();
            }
        }
        #endregion;

        #region  -- PO LIST Double Click --
        private void ISG_PO_LIST_CellDoubleClick(object pSender)
        {
            if (IDA_HEADER.Refillable == true && IDA_LINE.Refillable == true )
            {
                iedPO_HEADER_ID.EditValue = ISG_PO_LIST.GetCellValue("PO_HEADER_ID");

                IDA_HEADER.OraSelectData.AcceptChanges();
                IDA_HEADER.Refillable = true;


                

                IDA_HEADER.Fill();
                Group_Total_Amount();

                SUPPLIER_ENABLE();  // ADDED, BY MJSHIN

                TAB_MAIN.SelectedIndex = 0;
                
            }
            else
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("PO_10014"), "WARRING", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            }
        }
        #endregion;

        private void ISG_LINE_CurrentCellChanged(object pSender, ISGridAdvExChangedEventArgs e)
        {
            switch (ISG_LINE.GridAdvExColElement[e.ColIndex].DataColumn.ToString())
            {
                case "PO_QTY":

                    ISG_LINE.SetCellValue("ITEM_AMOUNT", Convert.ToDecimal(e.NewValue) * Convert.ToDecimal(ISG_LINE.GetCellValue("ITEM_PRICE")));

                    break;

                case "ITEM_PRICE":

                    ISG_LINE.SetCellValue("ITEM_AMOUNT", Convert.ToDecimal(e.NewValue) * Convert.ToDecimal(ISG_LINE.GetCellValue("PO_QTY")));

                    break;

                default:
                    break;
            }
        }
    }
}