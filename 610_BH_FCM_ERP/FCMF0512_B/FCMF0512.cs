﻿using System;
using System.Data;
using System.Drawing;
using System.Windows.Forms;
using System.Collections.Generic;

using Syncfusion.Windows.Forms;
using Syncfusion.Windows.Forms.Tools;
using Syncfusion.Windows.Forms.Grid;
using InfoSummit.Win.ControlAdv;
using ISCommonUtil;

namespace FCMF0512
{
    public partial class FCMF0512 : Office2007Form
    {
        ISFunction.ISConvert iString = new ISFunction.ISConvert();
        ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        #region ----- Variables -----



        #endregion;

        #region ----- Constructor -----

        public FCMF0512()
        {
            InitializeComponent();
        }

        public FCMF0512(Form pMainForm, ISAppInterface pAppInterface)
        {
            InitializeComponent();
            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;
        }

        #endregion;

        #region ----- Private Methods ----
        private void Search_DB()
        {
            idaTR_DAILY_SUM_1.Fill();
            idaTR_DAILY_SUM_2.Fill();
            idaTR_DAILY_110.Fill();
            idaTR_DAILY_120.Fill();
            idaTR_DAILY_130_1.Fill();
            idaTR_DAILY_140.Fill();
            idaTR_DAILY_210_1.Fill();
            idaTR_DAILY_210_2.Fill();
            idaTR_DAILY_210_3.Fill();
            idaTR_DAILY_210_4.Fill();
            idaTR_DAILY_SLIP.Fill();
            idaTR_DAILY_FUND_MOVE.Fill();
        }
                
        //private void SetCommon_Lookup_Parameter(string pGroup_Code, string pEnabled_YN)
        //{
        //    ildCOMMON.SetLookupParamValue("W_GROUP_CODE", pGroup_Code);
        //    ildCOMMON.SetLookupParamValue("W_ENABLED_YN", pEnabled_YN);
        //}
        #endregion;

        #region ----- XL Export Methods ----

        private void ExportXL()
        {
            System.Windows.Forms.Application.UseWaitCursor = true;
            this.Cursor = System.Windows.Forms.Cursors.WaitCursor;
            System.Windows.Forms.Application.DoEvents();

            string vMessageText = string.Empty;
            int vPageTotal = 0;
            int vPageNumber = 0;
            int vCountRowGrid1 = 0;
            int vCountRowGrid2 = 0;

            int vCountLinePrinting = 0;
            int vCopyLineSUM = 0;

            int vSkipLine = 0;

            bool isOpen = false;

            int vTerritory = GetTerritory(isAppInterfaceAdv1.AppInterface.OraConnectionInfo.TerritoryLanguage);

            string vWeekName = WeekName(GL_DATE_0.DateTimeValue);
            string vDate = string.Format("{0}년 {1:D2}월 {2:D2}일[{3}]", GL_DATE_0.DateTimeValue.Year, GL_DATE_0.DateTimeValue.Month, GL_DATE_0.DateTimeValue.Day, vWeekName);

            int vCountTAB = itbTR_DAILY.TabCount;

            vMessageText = string.Format("Excel Export Starting");
            isAppInterfaceAdv1.OnAppMessage(vMessageText);
            System.Windows.Forms.Application.DoEvents();

            XLInterface xlPrinting = null;

            try
            {
                XL.XLPrint vPrinting = new XL.XLPrint();
                isOpen = vPrinting.XLOpenFile("FCMF0512_001.xls");
                if (isOpen == false)
                {
                    return;
                }

                try
                {
                    InfoSummit.Win.ControlAdv.ISGridAdvEx[] vGrid = new InfoSummit.Win.ControlAdv.ISGridAdvEx[2];
                    for (int vIndexTAB = 0; vIndexTAB < vCountTAB; vIndexTAB++)
                    {
                        itbTR_DAILY.SelectedIndex = vIndexTAB;
                        itbTR_DAILY.SelectedTab.Focus();

                        //-------------------------------------------------------------------------------------
                        if (vIndexTAB == 0)
                        {
                            vGrid[0] = igrTR_DAILY_SUM_1;
                            vGrid[1] = igrTR_DAILY_SUM_2;
                            vCountRowGrid1 = vGrid[0].RowCount;
                            vCountRowGrid2 = vGrid[1].RowCount;
                            if (vCountRowGrid1 > 0 || vCountRowGrid2 > 0)
                            {
                                //자금일보 [SourceTab1]
                                xlPrinting = new XLPrinting01(vPrinting, isAppInterfaceAdv1.AppInterface, isMessageAdapter1);
                                xlPrinting.PrintingLineFIRST = 10;
                                xlPrinting.PrintingLineSTART = 10;
                                xlPrinting.CopyLineSUM = 1;
                                vPageNumber = xlPrinting.LineWrite(vGrid, vDate);
                                vPageTotal = vPageTotal + vPageNumber;

                                vSkipLine = 42 - xlPrinting.CopyLineSUM;
                                vCopyLineSUM = xlPrinting.CopyLineSUM + (vSkipLine + 1);
                                vCountLinePrinting = vCopyLineSUM - 1;
                            }
                        }
                        else if (vIndexTAB == 1)
                        {
                            vGrid[0] = igrTR_DAILY_110;
                            vCountRowGrid1 = vGrid[0].RowCount;
                            if (vCountRowGrid1 > 0)
                            {
                                //현금 및 예금 현황 [SourceTab2]
                                xlPrinting = new XLPrinting02(vPrinting, isAppInterfaceAdv1.AppInterface, isMessageAdapter1);
                                xlPrinting.PrintingLineFIRST = 4;
                                xlPrinting.PrintingLineSTART = vCountLinePrinting + xlPrinting.PrintingLineSTART;
                                xlPrinting.CopyLineSUM = vCopyLineSUM;
                                vPageNumber = xlPrinting.LineWrite(vGrid, vDate);
                                vPageTotal = vPageTotal + vPageNumber;
                                
                                vCopyLineSUM = xlPrinting.CopyLineSUM;
                                vCountLinePrinting = vCopyLineSUM - 1;
                            }
                        }
                        else if (vIndexTAB == 2)
                        {
                            vGrid[0] = igrDEPOSIT;
                            vCountRowGrid1 = vGrid[0].RowCount;
                            if (vCountRowGrid1 > 0)
                            {
                                //정기 예/적금 현황 [SourceTab3]
                                xlPrinting = new XLPrinting03(vPrinting, isAppInterfaceAdv1.AppInterface, isMessageAdapter1);
                                xlPrinting.PrintingLineFIRST = 4;
                                xlPrinting.PrintingLineSTART = vCountLinePrinting + xlPrinting.PrintingLineSTART;
                                xlPrinting.CopyLineSUM = vCopyLineSUM;
                                vPageNumber = xlPrinting.LineWrite(vGrid, vDate);
                                vPageTotal = vPageTotal + vPageNumber;
                                
                                vCopyLineSUM = xlPrinting.CopyLineSUM;
                                vCountLinePrinting = vCopyLineSUM - 1;
                            }
                        }
                        else if (vIndexTAB == 3)
                        {
                            vGrid[0] = igrTR_DAILY_130_1;
                            vCountRowGrid1 = vGrid[0].RowCount;
                            if (vCountRowGrid1 > 0)
                            {
                                //받을 어음 현황 [SourceTab4]
                                xlPrinting = new XLPrinting04(vPrinting, isAppInterfaceAdv1.AppInterface, isMessageAdapter1);
                                xlPrinting.PrintingLineFIRST = 5;
                                xlPrinting.PrintingLineSTART = vCountLinePrinting + xlPrinting.PrintingLineSTART;
                                xlPrinting.CopyLineSUM = vCopyLineSUM;
                                vPageNumber = xlPrinting.LineWrite(vGrid, vDate);
                                vPageTotal = vPageTotal + vPageNumber;
                                
                                vCopyLineSUM = xlPrinting.CopyLineSUM;
                                vCountLinePrinting = vCopyLineSUM - 1;
                            }
                        }
                        else if (vIndexTAB == 4)
                        {
                            vGrid[0] = igrPAYALBE_BILL;
                            vCountRowGrid1 = vGrid[0].RowCount;
                            if (vCountRowGrid1 > 0)
                            {
                                //지급 어음 [SourceTab5]
                                xlPrinting = new XLPrinting05(vPrinting, isAppInterfaceAdv1.AppInterface, isMessageAdapter1);
                                xlPrinting.PrintingLineFIRST = 5;
                                xlPrinting.PrintingLineSTART = vCountLinePrinting + xlPrinting.PrintingLineSTART;
                                xlPrinting.CopyLineSUM = vCopyLineSUM;
                                vPageNumber = xlPrinting.LineWrite(vGrid, vDate);
                                vPageTotal = vPageTotal + vPageNumber;
                                
                                vCopyLineSUM = xlPrinting.CopyLineSUM;
                                vCountLinePrinting = vCopyLineSUM - 1;
                            }
                        }
                        else if (vIndexTAB == 5)
                        {
                            vGrid[0] = igrLOAN_1;
                            vCountRowGrid1 = vGrid[0].RowCount;
                            if (vCountRowGrid1 > 0)
                            {
                                //일반 대출 [SourceTab6]
                                xlPrinting = new XLPrinting06(vPrinting, isAppInterfaceAdv1.AppInterface, isMessageAdapter1);
                                xlPrinting.PrintingLineFIRST = 4;
                                xlPrinting.PrintingLineSTART = vCountLinePrinting + xlPrinting.PrintingLineSTART;
                                xlPrinting.CopyLineSUM = vCopyLineSUM;
                                vPageNumber = xlPrinting.LineWrite(vGrid, vDate);
                                vPageTotal = vPageTotal + vPageNumber;
                                
                                vCopyLineSUM = xlPrinting.CopyLineSUM;
                                vCountLinePrinting = vCopyLineSUM - 1;
                            }
                        }
                        else if (vIndexTAB == 6)
                        {
                            vGrid[0] = igrLOAN_4;
                            vCountRowGrid1 = vGrid[0].RowCount;
                            if (vCountRowGrid1 > 0)
                            {
                                //사채 [SourceTab7]
                                xlPrinting = new XLPrinting07(vPrinting, isAppInterfaceAdv1.AppInterface, isMessageAdapter1);
                                xlPrinting.PrintingLineFIRST = 4;
                                xlPrinting.PrintingLineSTART = vCountLinePrinting + xlPrinting.PrintingLineSTART;
                                xlPrinting.CopyLineSUM = vCopyLineSUM;
                                vPageNumber = xlPrinting.LineWrite(vGrid, vDate);
                                vPageTotal = vPageTotal + vPageNumber;
                                
                                vCopyLineSUM = xlPrinting.CopyLineSUM;
                                vCountLinePrinting = vCopyLineSUM - 1;
                            }
                        }
                        else if (vIndexTAB == 7)
                        {
                            vGrid[0] = igrLOAN_2;
                            vCountRowGrid1 = vGrid[0].RowCount;
                            if (vCountRowGrid1 > 0)
                            {
                                //한도 대출 [SourceTab8]
                                xlPrinting = new XLPrinting08(vPrinting, isAppInterfaceAdv1.AppInterface, isMessageAdapter1);
                                xlPrinting.PrintingLineFIRST = 5;
                                xlPrinting.PrintingLineSTART = vCountLinePrinting + xlPrinting.PrintingLineSTART;
                                xlPrinting.CopyLineSUM = vCopyLineSUM;
                                vPageNumber = xlPrinting.LineWrite(vGrid, vDate);
                                vPageTotal = vPageTotal + vPageNumber;
                                
                                vCopyLineSUM = xlPrinting.CopyLineSUM;
                                vCountLinePrinting = vCopyLineSUM - 1;
                            }
                        }
                        else if (vIndexTAB == 8)
                        {
                            vGrid[0] = igrLOAN_3;
                            vCountRowGrid1 = vGrid[0].RowCount;
                            if (vCountRowGrid1 > 0)
                            {
                                //회전대 [SourceTab9]
                                xlPrinting = new XLPrinting09(vPrinting, isAppInterfaceAdv1.AppInterface, isMessageAdapter1);
                                xlPrinting.PrintingLineFIRST = 5;
                                xlPrinting.PrintingLineSTART = vCountLinePrinting + xlPrinting.PrintingLineSTART;
                                xlPrinting.CopyLineSUM = vCopyLineSUM;
                                vPageNumber = xlPrinting.LineWrite(vGrid, vDate);
                                vPageTotal = vPageTotal + vPageNumber;
                                
                                vCopyLineSUM = xlPrinting.CopyLineSUM;
                                vCountLinePrinting = vCopyLineSUM - 1;
                            }
                        }
                        else if (vIndexTAB == 9)
                        {
                            vGrid[0] = igrTR_SLIP;
                            vCountRowGrid1 = vGrid[0].RowCount;
                            if (vCountRowGrid1 > 0)
                            {
                                //자금 입/출내역 [SourceTab10]
                                xlPrinting = new XLPrinting10(vPrinting, isAppInterfaceAdv1.AppInterface, isMessageAdapter1);
                                xlPrinting.PrintingLineFIRST = 4;
                                xlPrinting.PrintingLineSTART = vCountLinePrinting + xlPrinting.PrintingLineSTART;
                                xlPrinting.CopyLineSUM = vCopyLineSUM;
                                vPageNumber = xlPrinting.LineWrite(vGrid, vDate);
                                vPageTotal = vPageTotal + vPageNumber;
                                
                                vCopyLineSUM = xlPrinting.CopyLineSUM;
                                vCountLinePrinting = vCopyLineSUM - 1;
                            }
                        }
                        else if (vIndexTAB == 10)
                        {
                            vGrid[0] = igrFUND_MOVE;
                            vCountRowGrid1 = vGrid[0].RowCount;
                            if (vCountRowGrid1 > 0)
                            {
                                //이체 입/출내역 [SourceTab11]
                                xlPrinting = new XLPrinting11(vPrinting, isAppInterfaceAdv1.AppInterface, isMessageAdapter1);
                                xlPrinting.PrintingLineFIRST = 4;
                                xlPrinting.PrintingLineSTART = vCountLinePrinting + xlPrinting.PrintingLineSTART;
                                xlPrinting.CopyLineSUM = vCopyLineSUM;
                                vPageNumber = xlPrinting.LineWrite(vGrid, vDate);
                                vPageTotal = vPageTotal + vPageNumber;
                            }
                        }
                        //-------------------------------------------------------------------------------------

                    }
                }
                catch (System.Exception ex)
                {
                    vMessageText = ex.Message;
                    isAppInterfaceAdv1.AppInterface.OnAppMessageEvent(vMessageText);
                    System.Windows.Forms.Application.DoEvents();

                    vPrinting.XLOpenFileClose();
                    vPrinting.XLClose();

                    xlPrinting.Dispose();
                }

                //-------------------------------------------------------------------------
                xlPrinting.Save("SLIP_"); //SAVE
                //-------------------------------------------------------------------------

                vPrinting.XLOpenFileClose();
                vPrinting.XLClose();

                xlPrinting.Dispose();
            }
            catch (System.Exception ex)
            {
                vMessageText = ex.Message;
                isAppInterfaceAdv1.AppInterface.OnAppMessageEvent(vMessageText);
                System.Windows.Forms.Application.DoEvents();

                xlPrinting.Dispose();
            }

            vMessageText = string.Format("Excel Export End [Total Page : {0}]", vPageTotal);
            isAppInterfaceAdv1.AppInterface.OnAppMessageEvent(vMessageText);
            System.Windows.Forms.Application.DoEvents();

            System.Windows.Forms.Application.UseWaitCursor = false;
            this.Cursor = System.Windows.Forms.Cursors.Default;
            System.Windows.Forms.Application.DoEvents();
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

        #region ----- Week Name Method ----

        private string WeekName(System.DateTime pDate)
        {
            string vWeekName = string.Empty;

            switch (pDate.DayOfWeek)
            {
                case DayOfWeek.Monday:
                    vWeekName = "월";
                    break;
                case DayOfWeek.Tuesday:
                    vWeekName = "화";
                    break;
                case DayOfWeek.Wednesday:
                    vWeekName = "수";
                    break;
                case DayOfWeek.Thursday:
                    vWeekName = "목";
                    break;
                case DayOfWeek.Friday:
                    vWeekName = "금";
                    break;
                case DayOfWeek.Saturday:
                    vWeekName = "토";
                    break;
                case DayOfWeek.Sunday:
                    vWeekName = "일";
                    break;
            }

            return vWeekName;
        }

        #endregion;

        #region ----- XL Print Methods ----

        private void XLPrinting(InfoSummit.Win.ControlAdv.ISGridAdvEx[] pGrid, int pIndexTab)
        {
            System.Windows.Forms.Application.UseWaitCursor = true;
            this.Cursor = System.Windows.Forms.Cursors.WaitCursor;
            System.Windows.Forms.Application.DoEvents();

            string vMessageText = string.Empty;
            int vPageTotal = 0;
            int vPageNumber = 0;

            int vTerritory = GetTerritory(isAppInterfaceAdv1.AppInterface.OraConnectionInfo.TerritoryLanguage);

            string vWeekName = WeekName(GL_DATE_0.DateTimeValue);
            string vDate = string.Format("{0}년 {1:D2}월 {2:D2}일[{3}]", GL_DATE_0.DateTimeValue.Year, GL_DATE_0.DateTimeValue.Month, GL_DATE_0.DateTimeValue.Day, vWeekName);

            int vCountRowGrid = pGrid[0].RowCount;
            if (vCountRowGrid > 0)
            {
                vMessageText = string.Format("Printing Starting");
                isAppInterfaceAdv1.OnAppMessage(vMessageText);
                System.Windows.Forms.Application.DoEvents();

                XLInterface xlPrinting = null;

                //-------------------------------------------------------------------------------------
                if (pIndexTab == 0)
                {
                    //자금일보 [SourceTab1]
                    xlPrinting = new XLPrinting01(isAppInterfaceAdv1.AppInterface, isMessageAdapter1);
                    xlPrinting.PrintingLineFIRST = 10;
                    xlPrinting.PrintingLineSTART = 10;
                    xlPrinting.CopyLineSUM = 1;
                }
                else if (pIndexTab == 1)
                {
                    //현금 및 예금 현황 [SourceTab2]
                    xlPrinting = new XLPrinting02(isAppInterfaceAdv1.AppInterface, isMessageAdapter1);
                    xlPrinting.PrintingLineFIRST = 4;
                    xlPrinting.PrintingLineSTART = 4;
                    xlPrinting.CopyLineSUM = 1;
                }
                else if (pIndexTab == 2)
                {
                    // 정기 예.적금 현황 [SourceTab3]
                    xlPrinting = new XLPrinting03(isAppInterfaceAdv1.AppInterface, isMessageAdapter1);
                    xlPrinting.PrintingLineFIRST = 4;
                    xlPrinting.PrintingLineSTART = 4;
                    xlPrinting.CopyLineSUM = 1;
                }
                else if (pIndexTab == 3)
                {
                    // 받을 어음 현황 [SourceTab4]
                    xlPrinting = new XLPrinting04(isAppInterfaceAdv1.AppInterface, isMessageAdapter1);
                    xlPrinting.PrintingLineFIRST = 5;
                    xlPrinting.PrintingLineSTART = 5;
                    xlPrinting.CopyLineSUM = 1;
                }
                else if (pIndexTab == 4)
                {
                    // 지급 어음 [SourceTab5]
                    xlPrinting = new XLPrinting05(isAppInterfaceAdv1.AppInterface, isMessageAdapter1);
                    xlPrinting.PrintingLineFIRST = 5;
                    xlPrinting.PrintingLineSTART = 5;
                    xlPrinting.CopyLineSUM = 1;
                }
                else if (pIndexTab == 5)
                {
                    // 일반 대출 [SourceTab6]
                    xlPrinting = new XLPrinting06(isAppInterfaceAdv1.AppInterface, isMessageAdapter1);
                    xlPrinting.PrintingLineFIRST = 4;
                    xlPrinting.PrintingLineSTART = 4;
                    xlPrinting.CopyLineSUM = 1;
                }
                else if (pIndexTab == 6)
                {
                    // 사채 [SourceTab7]
                    xlPrinting = new XLPrinting07(isAppInterfaceAdv1.AppInterface, isMessageAdapter1);
                    xlPrinting.PrintingLineFIRST = 4;
                    xlPrinting.PrintingLineSTART = 4;
                    xlPrinting.CopyLineSUM = 1;
                }
                else if (pIndexTab == 7)
                {
                    // 한도 대출 [SourceTab8]
                    xlPrinting = new XLPrinting08(isAppInterfaceAdv1.AppInterface, isMessageAdapter1);
                    xlPrinting.PrintingLineFIRST = 5;
                    xlPrinting.PrintingLineSTART = 5;
                    xlPrinting.CopyLineSUM = 1;
                }
                else if (pIndexTab == 8)
                {
                    // 회전대 [SourceTab9]
                    xlPrinting = new XLPrinting09(isAppInterfaceAdv1.AppInterface, isMessageAdapter1);
                    xlPrinting.PrintingLineFIRST = 5;
                    xlPrinting.PrintingLineSTART = 5;
                    xlPrinting.CopyLineSUM = 1;
                }
                else if (pIndexTab == 9)
                {
                    // 자금 입/출내역 [SourceTab10]
                    xlPrinting = new XLPrinting10(isAppInterfaceAdv1.AppInterface, isMessageAdapter1);
                    xlPrinting.PrintingLineFIRST = 4;
                    xlPrinting.PrintingLineSTART = 4;
                    xlPrinting.CopyLineSUM = 1;
                }
                else if (pIndexTab == 10)
                {
                    // 이체 입/출내역 [SourceTab11]
                    xlPrinting = new XLPrinting11(isAppInterfaceAdv1.AppInterface, isMessageAdapter1);
                    xlPrinting.PrintingLineFIRST = 4;
                    xlPrinting.PrintingLineSTART = 4;
                    xlPrinting.CopyLineSUM = 1;
                }
                //-------------------------------------------------------------------------------------

                try
                {
                    //-------------------------------------------------------------------------------------
                    xlPrinting.OpenFileNameExcel = "FCMF0512_001.xls";
                    //-------------------------------------------------------------------------------------

                    //-------------------------------------------------------------------------------------
                    bool isOpen = xlPrinting.XLFileOpen();
                    //-------------------------------------------------------------------------------------

                    //-------------------------------------------------------------------------------------
                    if (isOpen == true)
                    {
                        vPageNumber = xlPrinting.LineWrite(pGrid, vDate);

                        ////[PRINT]
                        ////xlPrinting.Printing(3, 4); //시작 페이지 번호, 종료 페이지 번호
                        xlPrinting.Printing(1, vPageNumber);

                        ////[SAVE]
                        //xlPrinting.Save("SLIP_"); //저장 파일명


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

        #region ----- Tab Loop Methods ----

        private void TabLoopPrinting()
        {
            InfoSummit.Win.ControlAdv.ISGridAdvEx[] vGrid = new InfoSummit.Win.ControlAdv.ISGridAdvEx[2];

            int vCountTAB = itbTR_DAILY.TabCount;
            for (int vIndexTAB = 0; vIndexTAB < vCountTAB; vIndexTAB++)
            {
                itbTR_DAILY.SelectedIndex = vIndexTAB;
                itbTR_DAILY.SelectedTab.Focus();

                if (vIndexTAB == 0)
                {
                    vGrid[0] = igrTR_DAILY_SUM_1;
                    vGrid[1] = igrTR_DAILY_SUM_2;
                    XLPrinting(vGrid, vIndexTAB); //자금일보
                }
                else if (vIndexTAB == 1)
                {
                    vGrid[0] = igrTR_DAILY_110;
                    XLPrinting(vGrid, vIndexTAB); //현금 및 예금 현황
                }
                else if (vIndexTAB == 2)
                {
                    vGrid[0] = igrDEPOSIT;
                    XLPrinting(vGrid, vIndexTAB); // 정기 예.적금 현황
                }
                else if (vIndexTAB == 3)
                {
                    vGrid[0] = igrTR_DAILY_130_1;
                    XLPrinting(vGrid, vIndexTAB); // 받을 어음 현황
                }
                else if (vIndexTAB == 4)
                {
                    vGrid[0] = igrPAYALBE_BILL;
                    XLPrinting(vGrid, vIndexTAB); // 지급 어음
                }
                else if (vIndexTAB == 5)
                {
                    vGrid[0] = igrLOAN_1;
                    XLPrinting(vGrid, vIndexTAB); // 일반 대출
                }
                else if (vIndexTAB == 6)
                {
                    vGrid[0] = igrLOAN_4;
                    XLPrinting(vGrid, vIndexTAB); // 사채
                }
                else if (vIndexTAB == 7)
                {
                    vGrid[0] = igrLOAN_2;
                    XLPrinting(vGrid, vIndexTAB); // 한도 대출
                }
                else if (vIndexTAB == 8)
                {
                    vGrid[0] = igrLOAN_3;
                    XLPrinting(vGrid, vIndexTAB); // 회전대
                }
                else if (vIndexTAB == 9)
                {
                    vGrid[0] = igrTR_SLIP;
                    XLPrinting(vGrid, vIndexTAB); // 자금 입/출내역
                }
                else if (vIndexTAB == 10)
                {
                    vGrid[0] = igrFUND_MOVE;
                    XLPrinting(vGrid, vIndexTAB); // 자금이체
                }
            }
        }

        #endregion;

        #region ----- Tab Printing Methods ----

        private void TabPrinting()
        {
            InfoSummit.Win.ControlAdv.ISGridAdvEx[] vGrid = new InfoSummit.Win.ControlAdv.ISGridAdvEx[2];

            int vIndexTAB = itbTR_DAILY.SelectedIndex;

            if (vIndexTAB == 0)
            {
                vGrid[0] = igrTR_DAILY_SUM_1;
                vGrid[1] = igrTR_DAILY_SUM_2;
                XLPrinting(vGrid, vIndexTAB); //자금일보
            }
            else if (vIndexTAB == 1)
            {
                vGrid[0] = igrTR_DAILY_110;
                XLPrinting(vGrid, vIndexTAB); //현금 및 예금 현황
            }
            else if (vIndexTAB == 2)
            {
                vGrid[0] = igrDEPOSIT;
                XLPrinting(vGrid, vIndexTAB); // 정기 예.적금 현황
            }
            else if (vIndexTAB == 3)
            {
                vGrid[0] = igrTR_DAILY_130_1;
                XLPrinting(vGrid, vIndexTAB); // 받을 어음 현황
            }
            else if (vIndexTAB == 4)
            {
                vGrid[0] = igrPAYALBE_BILL;
                XLPrinting(vGrid, vIndexTAB); // 지급 어음
            }
            else if (vIndexTAB == 5)
            {
                vGrid[0] = igrLOAN_1;
                XLPrinting(vGrid, vIndexTAB); // 일반 대출
            }
            else if (vIndexTAB == 6)
            {
                vGrid[0] = igrLOAN_4;
                XLPrinting(vGrid, vIndexTAB); // 사채
            }
            else if (vIndexTAB == 7)
            {
                vGrid[0] = igrLOAN_2;
                XLPrinting(vGrid, vIndexTAB); // 한도 대출
            }
            else if (vIndexTAB == 8)
            {
                vGrid[0] = igrLOAN_3;
                XLPrinting(vGrid, vIndexTAB); // 회전대
            }
            else if (vIndexTAB == 9)
            {
                vGrid[0] = igrTR_SLIP;
                XLPrinting(vGrid, vIndexTAB); // 자금 입/출내역
            }
            else if (vIndexTAB == 10)
            {
                vGrid[0] = igrFUND_MOVE;
                XLPrinting(vGrid, vIndexTAB); // 자금이체
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
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Print)
                {
                    TabPrinting();
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Export)
                {
                    ExportXL();
                }
            }
        }

        #endregion;

        #region ----- Form Event -----
        
        private void FCMF0512_Load(object sender, EventArgs e)
        {
        
        }

        private void FCMF0512_Shown(object sender, EventArgs e)
        {
            GL_DATE_0.EditValue = DateTime.Today;

            //System.DateTime vtmpDate = new DateTime(2010, 12, 11);
            //GL_DATE_0.EditValue = vtmpDate;
        }

        private void ibtnTR_CREATE_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            object mMessage;
            idcTR_DAILY_SUM.ExecuteNonQuery();
            mMessage = idcTR_DAILY_SUM.GetCommandParamValue("O_MESSAGE");
            if (iString.ISNull(mMessage) != string.Empty)
            {
                MessageBoxAdv.Show(mMessage.ToString(),  "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
        }

        #endregion
        
        #region ----- Lookup Event -----
        
        #endregion

        #region ----- Adapeter Event -----
       
        private void idaASSET_CATEGORY_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {
            if (iString.ISNull(e.Row["ASSET_CATEGORY_CODE"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10093"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["ASSET_CATEGORY_NAME"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10094"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["ASSET_TYPE"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10095"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["DPR_METHOD_TYPE"]) != string.Empty && iString.ISNull(e.Row["PROGRESS_YEAR_RATE"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10098"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["IFRS_DPR_METHOD_TYPE"]) != string.Empty && iString.ISNull(e.Row["IFRS_PROGRESS_YEAR_RATE"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10098"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            //if (iString.ISNull(e.Row["ACCOUNT_CONTROL_ID"]) == string.Empty)
            //{
            //    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10088", "&&VALUE:=Account Name(계정)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            //    e.Cancel = true;
            //    return;
            //}
            //if (iString.ISNull(e.Row["RESIDUAL_VALUE_AMOUNT"]) == string.Empty)
            //{
            //    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10088", "&&VALUE:=Residual Value Amount(잔존가액)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            //    e.Cancel = true;
            //    return;
            //}
            if (iString.ISNull(e.Row["EFFECTIVE_DATE_FR"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10010"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["EFFECTIVE_DATE_TO"]) != string.Empty &&
               Convert.ToDateTime(e.Row["EFFECTIVE_DATE_FR"]) > Convert.ToDateTime(e.Row["EFFECTIVE_DATE_TO"]))
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10012"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
        }

        private void idaASSET_CATEGORY_PreDelete(ISPreDeleteEventArgs e)
        {
            if (e.Row.RowState != DataRowState.Added)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10029", "&&VALUE:= Data(해당 데이터)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
        }

        #endregion
    }
}