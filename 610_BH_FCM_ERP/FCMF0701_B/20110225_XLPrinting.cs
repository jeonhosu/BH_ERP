using System;

namespace FCMF0701
{
    /// <summary>
    /// XLPrint Class를 이용해 Report물 제어
    /// </summary>
    public class XLPrinting
    {
        #region ----- Variables -----

        private InfoSummit.Win.ControlAdv.ISAppInterfaceAdv mIsAppInterFace;

        private XL.XLPrint mPrinting = null;

        private string mMessageError = string.Empty;

        private int mPageTotalNumber = 0;
        private int mPageNumber = 0;

        private string mXLOpenFileName = string.Empty;

        private int[] mIndexGridHeader1COL = new int[0] { };
        private int[] mIndexGridHeader0COL = new int[0] { };
        private int[] mIndexXLHeader1COL = new int[0] { }; //엑셀 해더1에 출력할 열 위치 지정
        private int[] mIndexXLHeader0COL = new int[0] { }; //엑셀 해더0에 출력할 열 위치 지정

        private int[] mIndexGridColumns = new int[0] { };
        private int[] mIndexXLWriteColumn = new int[0] { }; //엑셀에 출력할 열 위치 지정

        private int mPositionPrintLineSTART = 8; //내용 출력시 엑셀 시작 행 위치 지정
        private int mSumWriteLine = 0;           //엑셀에 출력되는 행 누적 값
        private int mRepeatIncrement = 43;       //실제 출력되는 행의 시작부터 끝 행의 범위(실제 행 8~50까지의 간격 43 행을 반복 되는 범위)
        
        private int mSumPrintingLineCopy = 1;    //엑셀의 선택된 쉬트에 복사되어질 시작 행 위치 및 누적 행 값
        private int mMaxIncrementCopy = 52;      //반복 복사되어질 행의 최대 범위

        private int mXLColumnAreaSTART = 1;      //복사되어질 쉬트의 폭, 시작열
        private int mXLColumnAreaEND = 46;       //복사되어질 쉬트의 폭, 종료열

        #endregion;

        #region ----- Property -----

        /// <summary>
        /// 모든 Error Message 출력
        /// </summary>
        public string ErrorMessage
        {
            get
            {
                return mMessageError;
            }
        }

        /// <summary>
        /// Ope할 Excel File 이름
        /// </summary>
        public string OpenFileNameExcel
        {
            set
            {
                mXLOpenFileName = value;
            }
        }

        #endregion;

        #region ----- Constructor -----

        public XLPrinting(InfoSummit.Win.ControlAdv.ISAppInterfaceAdv pIsAppInterFace)
        {
            mPrinting = new XL.XLPrint();
            mIsAppInterFace = pIsAppInterFace;
        }

        #endregion;

        #region ----- Interior Use Methods ----

        #region ----- MaxIncrement Methods ----

        private int MaxIncrement(string pPathBase, string pSaveFileName)
        {
            int vMaxNumber = 0;
            System.IO.DirectoryInfo vFolder = new System.IO.DirectoryInfo(pPathBase);
            string vPattern = string.Format("{0}*", pSaveFileName);
            System.IO.FileInfo[] vFiles = vFolder.GetFiles(vPattern);

            foreach (System.IO.FileInfo vFile in vFiles)
            {
                string vFileNameExt = vFile.Name;
                int vCutStart = vFileNameExt.LastIndexOf(".");
                string vFileName = vFileNameExt.Substring(0, vCutStart);

                int vCutRight = 3;
                int vSkip = vFileName.Length - vCutRight;
                string vTextNumber = vFileName.Substring(vSkip, vCutRight);
                int vNumber = int.Parse(vTextNumber);

                if (vNumber > vMaxNumber)
                {
                    vMaxNumber = vNumber;
                }
            }

            return vMaxNumber;
        }

        #endregion;

        #endregion;

        #region ----- XLPrint Define Methods ----

        #region ----- Dispose -----

        public void Dispose()
        {
            mPrinting.XLOpenFileClose();
            mPrinting.XLClose();
        }

        #endregion;

        #region ----- XL File Open -----

        public bool XLFileOpen()
        {
            bool IsOpen = false;

            try
            {
                IsOpen = mPrinting.XLOpenFile(mXLOpenFileName);
            }
            catch (System.Exception ex)
            {
                mMessageError = ex.Message;
                mIsAppInterFace.OnAppMessage(mMessageError);
                System.Windows.Forms.Application.DoEvents();
            }

            return IsOpen;
        }

        #endregion;

        #region ----- Print Header Methods ----

        private void XLHeader(string pTitle, string pHeaderCenter, string pHeaderRight)
        {
            try
            {
                mPrinting.XLActiveSheet("SourceTab1");

                mPrinting.XLSetCell(2, 2, pTitle);

                mPrinting.XLSetCell(4, 2, pHeaderCenter);

                mPrinting.XLSetCell(5, 34, pHeaderRight);
            }
            catch (System.Exception ex)
            {
                mMessageError = string.Format("{0}", ex.Message);
                mIsAppInterFace.OnAppMessage(mMessageError);
                System.Windows.Forms.Application.DoEvents();
            }
        }

        #endregion;

        #region ----- Print Footer Methods ----

        private void XLFooter(string pFooterLeft)
        {
            try
            {
                mPrinting.XLActiveSheet("SourceTab1"); //mPrinting.XLActiveSheet(2);
                mPrinting.XLSetCell(51, 2, pFooterLeft);
            }
            catch (System.Exception ex)
            {
                mMessageError = string.Format("{0}", ex.Message);
                mIsAppInterFace.OnAppMessage(mMessageError);
                System.Windows.Forms.Application.DoEvents();
            }
        }

        #endregion;

        #region ----- Define Header Column Methods ----

        private void XLDefineHeaderColumn(InfoSummit.Win.ControlAdv.ISGridAdvEx pGrid)
        {
            try
            {
                //---------------------------------------------------------------------------------
                //Header_1
                //---------------------------------------------------------------------------------
                //Grid의 [Edit] 상의 [DataColumn] 열에 있는 열 이름을 지정 하면 된다.
                string[] vGridHeaderColumnNames_1 = new string[] //Header_1
                {
                      "REMAIN_DR_AMOUNT"  //차변
                    , "BEFORE_CR_AMOUNT"  //대변
                };

                int vIndexColumn = 0;
                mIndexGridHeader1COL = new int[vGridHeaderColumnNames_1.Length];

                foreach (string vName in vGridHeaderColumnNames_1)
                {
                    mIndexGridHeader1COL[vIndexColumn] = pGrid.GetColumnToIndex(vName);
                    vIndexColumn++;
                }

                //엑셀에 출력될 열 위치 지정
                int[] vXLHeaderColumnNames_1 = new int[] //Header_1
                {
                       2  //REMAIN_DR_AMOUNT  -  차변
                    , 23  //BEFORE_CR_AMOUNT  -  대변
                };
                mIndexXLHeader1COL = new int[vXLHeaderColumnNames_1.Length];
                for (int vCol = 0; vCol < vXLHeaderColumnNames_1.Length; vCol++)
                {
                    mIndexXLHeader1COL[vCol] = vXLHeaderColumnNames_1[vCol];
                }

                //---------------------------------------------------------------------------------
                //Header_0
                //---------------------------------------------------------------------------------
                //Grid의 [Edit] 상의 [DataColumn] 열에 있는 열 이름을 지정 하면 된다.
                string[] vGridHeaderColumnNames_0 = new string[]
                {
                      "REMAIN_DR_AMOUNT"        //잔액
                    , "THIS_DR_AMOUNT"          //당월
                    , "BEFORE_DR_AMOUNT"        //이월
                    , "FORM_ITEM_NAME"          //계정과목
                    , "BEFORE_CR_AMOUNT"        //이월
                    , "THIS_CR_AMOUNT"          //당월
                    , "REMAIN_CR_AMOUNT"        //잔액
                };

                vIndexColumn = 0;
                mIndexGridHeader0COL = new int[vGridHeaderColumnNames_0.Length];

                foreach (string vName in vGridHeaderColumnNames_0)
                {
                    mIndexGridHeader0COL[vIndexColumn] = pGrid.GetColumnToIndex(vName);
                    vIndexColumn++;
                }

                //엑셀에 출력될 열 위치 지정
                int[] vXLHeaderColumnNames_0 = new int[]
                {
                       2  //REMAIN_DR_AMOUNT  -  잔액
                    ,  8  //THIS_DR_AMOUNT    -  당월
                    , 14  //BEFORE_DR_AMOUNT  -  이월
                    , 20  //FORM_ITEM_NAME    -  계정과목
                    , 28  //BEFORE_CR_AMOUNT  -  이월
                    , 34  //THIS_CR_AMOUNT    -  당월
                    , 40  //REMAIN_CR_AMOUNT  -  잔액
                };
                mIndexXLHeader0COL = new int[vXLHeaderColumnNames_0.Length];
                for (int vCol = 0; vCol < vXLHeaderColumnNames_0.Length; vCol++)
                {
                    mIndexXLHeader0COL[vCol] = vXLHeaderColumnNames_0[vCol];
                }
            }
            catch (System.Exception ex)
            {
                mMessageError = string.Format("{0}", ex.Message);
            }
        }

        #endregion;

        #region ----- Define Print Column Methods ----

        private void XLDefinePrintColumn(InfoSummit.Win.ControlAdv.ISGridAdvEx pGrid)
        {
            try
            {
                //Grid의 [Edit] 상의 [DataColumn] 열에 있는 열 이름을 지정 하면 된다.
                string[] vGridDataColumns = new string[]
                {
                      "REMAIN_DR_AMOUNT"        //잔액
                    , "THIS_DR_AMOUNT"          //당월
                    , "BEFORE_DR_AMOUNT"        //이월
                    , "FORM_ITEM_NAME"          //계정과목
                    , "BEFORE_CR_AMOUNT"        //이월
                    , "THIS_CR_AMOUNT"          //당월
                    , "REMAIN_CR_AMOUNT"        //잔액
                };

                int vIndexColumn = 0;
                mIndexGridColumns = new int[vGridDataColumns.Length];

                foreach (string vName in vGridDataColumns)
                {
                    mIndexGridColumns[vIndexColumn] = pGrid.GetColumnToIndex(vName);
                    vIndexColumn++;
                }

                //엑셀에 출력될 열 위치 지정
                int[] vXLColumns = new int[]
                {
                       2  //REMAIN_DR_AMOUNT  -  잔액
                    ,  8  //THIS_DR_AMOUNT    -  당월
                    , 14  //BEFORE_DR_AMOUNT  -  이월
                    , 20  //FORM_ITEM_NAME    -  계정과목
                    , 28  //BEFORE_CR_AMOUNT  -  이월
                    , 34  //THIS_CR_AMOUNT    -  당월
                    , 40  //REMAIN_CR_AMOUNT  -  잔액
                };
                mIndexXLWriteColumn = new int[vXLColumns.Length];
                for (int vCol = 0; vCol < vXLColumns.Length; vCol++)
                {
                    mIndexXLWriteColumn[vCol] = vXLColumns[vCol];
                }
            }
            catch (System.Exception ex)
            {
                mMessageError = string.Format("{0}", ex.Message);
                mIsAppInterFace.OnAppMessage(mMessageError);
                System.Windows.Forms.Application.DoEvents();
            }
        }

        #endregion;

        #region ----- Print HeaderColumns Methods ----

        private void XLHeaderColumns(InfoSummit.Win.ControlAdv.ISGridAdvEx pGrid, int pTerritory, int pXLWriteLineStart)
        {
            int vXLHeaderRow_1 = pXLWriteLineStart - 2; //mPositionPrintLineSTART - 2, 출력될 내용의 행 위치에서 한행 위에 있으므로 2을 뺀다.
            int vXLHeaderRow_0 = pXLWriteLineStart - 1; //mPositionPrintLineSTART - 1, 출력될 내용의 행 위치에서 한행 위에 있으므로 1을 뺀다.

            object vObject = null;
            int vCountColumn = 0;
            int vGetIndexGridColumn = 0;

            //---------------------------------------------------------------------------------
            //Header_1
            //---------------------------------------------------------------------------------
            try
            {
                vCountColumn = mIndexGridHeader1COL.Length;

                if (vCountColumn < 1)
                {
                    return;
                }

                //Header Columns
                for (int vCol = 0; vCol < vCountColumn; vCol++)
                {
                    vGetIndexGridColumn = mIndexGridHeader1COL[vCol];
                    switch (pTerritory)
                    {
                        case 1: //Default
                            vObject = pGrid.GridAdvExColElement[vGetIndexGridColumn].HeaderElement[1].Default;
                            mPrinting.XLSetCell(vXLHeaderRow_1, mIndexXLHeader1COL[vCol], vObject);
                            break;
                        case 2: //KR
                            vObject = pGrid.GridAdvExColElement[vGetIndexGridColumn].HeaderElement[1].TL1_KR;
                            mPrinting.XLSetCell(vXLHeaderRow_1, mIndexXLHeader1COL[vCol], vObject);
                            break;
                    }
                }
            }
            catch (System.Exception ex)
            {
                mMessageError = string.Format("{0}", ex.Message);
            }

            //---------------------------------------------------------------------------------
            //Header_0
            //---------------------------------------------------------------------------------
            try
            {
                vCountColumn = mIndexGridHeader0COL.Length;

                if (vCountColumn < 1)
                {
                    return;
                }

                //Header Columns
                for (int vCol = 0; vCol < vCountColumn; vCol++)
                {
                    vGetIndexGridColumn = mIndexGridHeader0COL[vCol];
                    switch (pTerritory)
                    {
                        case 1: //Default
                            vObject = pGrid.GridAdvExColElement[vGetIndexGridColumn].HeaderElement[0].Default;
                            mPrinting.XLSetCell(vXLHeaderRow_0, mIndexXLHeader0COL[vCol], vObject);
                            break;
                        case 2: //KR
                            vObject = pGrid.GridAdvExColElement[vGetIndexGridColumn].HeaderElement[0].TL1_KR;
                            mPrinting.XLSetCell(vXLHeaderRow_0, mIndexXLHeader0COL[vCol], vObject);
                            break;
                    }
                }
            }
            catch (System.Exception ex)
            {
                mMessageError = string.Format("{0}", ex.Message);
            }
        }

        #endregion;

        #region ----- Print Content Write Methods ----

        private void XLContentWrite(XL.XLPrint pPrinting, InfoSummit.Win.ControlAdv.ISGridAdvEx pGrid, int pTotalRow, int pXLine, int[] pXLColumn, int pPrintingRowSTART, int pPrintingRowEND)
        {
            int vXLine = pXLine;
            int vCountColumn = pXLColumn.Length;

            object vObject = null;

            try
            {
                //Grid Content, XL Write
                for (int vRow = pPrintingRowSTART; vRow < pPrintingRowEND; vRow++)
                {
                    if (vRow < pTotalRow)
                    {
                        for (int vCol = 0; vCol < vCountColumn; vCol++)
                        {
                            if (vCol == 0 || vCol == 1 || vCol == 2 || vCol == 4 || vCol == 5 || vCol == 6)
                            {
                                vObject = pGrid.GetCellValue(vRow, mIndexGridColumns[vCol]);
                                vObject = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vObject);
                            }
                            else
                            {
                                vObject = pGrid.GetCellValue(vRow, mIndexGridColumns[vCol]);
                            }
                            pPrinting.XLSetCell(vXLine, pXLColumn[vCol], vObject);
                        }
                    }
                    else
                    {
                        for (int vCol = 0; vCol < vCountColumn; vCol++)
                        {
                            vObject = null;
                            pPrinting.XLSetCell(vXLine, pXLColumn[vCol], vObject);
                        }
                    }

                    vXLine++;
                }
            }
            catch (System.Exception ex)
            {
                mMessageError = string.Format("{0}", ex.Message);
                mIsAppInterFace.OnAppMessage(mMessageError);
                System.Windows.Forms.Application.DoEvents();
            }
        }

        #endregion;

        #region ----- New Page iF Methods ----

        private int NewPage(InfoSummit.Win.ControlAdv.ISGridAdvEx pGrid, int pTotalRow, int pSumWriteLine)
        {
            int vPrintingRowSTART = 0;
            int vPrintingRowEND = 0;

            try
            {
                vPrintingRowSTART = pSumWriteLine;
                pSumWriteLine = pSumWriteLine + mRepeatIncrement;
                vPrintingRowEND = pSumWriteLine;

                XLContentWrite(mPrinting, pGrid, pTotalRow, mPositionPrintLineSTART, mIndexXLWriteColumn, vPrintingRowSTART, vPrintingRowEND);
            }
            catch (System.Exception ex)
            {
                mMessageError = string.Format("{0}", ex.Message);
                mIsAppInterFace.OnAppMessage(mMessageError);
                System.Windows.Forms.Application.DoEvents();
            }

            return pSumWriteLine;
        }

        #endregion;

        #region ----- Excel Wirte Methods ----

        /// <summary>
        /// <para>XLWirte(ISGridAdvEx, 언어) :: Excel의 선택된 Sheet에 값 Spread</para>
        /// <para>pGrid : 조회된 Grid Object</para>
        /// <para>pTerritory : 선택된 언어 종류 Index</para>
        /// </summary>
        public int XLWirte(InfoSummit.Win.ControlAdv.ISGridAdvEx pGrid, int pTerritory, string pHeaderCenter, string pPeriod, string pUserName, string pCaption)
        {
            string vMessageText = string.Empty;

            string vPrintingDate = System.DateTime.Now.ToString("yyyy-MM-dd", null);
            string vPrintingTime = System.DateTime.Now.ToString("HH:mm:ss", null);

            try
            {
                int vTotalRow = pGrid.RowCount; //Grid의 총 행수

                int vBy = mRepeatIncrement;
                mPageTotalNumber = vTotalRow / vBy;
                mPageTotalNumber = (vTotalRow % vBy) == 0 ? mPageTotalNumber : (mPageTotalNumber + 1);

                //[출력될 열 지정]
                XLDefineHeaderColumn(pGrid);
                XLDefinePrintColumn(pGrid);

                while (vTotalRow > mSumWriteLine)
                {
                    mPageNumber++;

                    //[Header]
                    string vTitle = pHeaderCenter;
                    string vHeaderCenter = string.Format("Inquiry Period : {0}(Monthly Account)", pPeriod);
                    string vHeaderRight = string.Format("Write Date : {0}", vPrintingDate);
                    switch (pTerritory)
                    {
                        case 1: //Default
                            vTitle = pHeaderCenter;
                            vHeaderCenter = string.Format("Inquiry Period : {0}(Monthly Account)", pPeriod);
                            vHeaderRight = string.Format("Write Date : ", vPrintingDate);
                            break;
                        case 2: //KR
                            vTitle = pHeaderCenter;
                            vHeaderCenter = string.Format("기준년월 : {0}(월계)", pPeriod);
                            vHeaderRight = string.Format("작성일자 : {0}", vPrintingDate);
                            break;
                    }
                    XLHeader(vTitle, vHeaderCenter, vHeaderRight);

                    //[Footer]
                    string vFooterLeft = string.Format("[{0} {1}]", vPrintingDate, vPrintingTime);
                    XLFooter(vFooterLeft);

                    //[Header Columns]
                    XLHeaderColumns(pGrid, pTerritory, mPositionPrintLineSTART);


                    //[Content_Printing]
                    mSumWriteLine = NewPage(pGrid, vTotalRow, mSumWriteLine);


                    ////[Sheet2]내용을 [Sheet1]에 붙여넣기
                    mSumPrintingLineCopy = CopyAndPaste(mSumPrintingLineCopy);
                }
            }
            catch
            {
                mPrinting.XLOpenFileClose();
                mPrinting.XLClose();
            }

            return mPageNumber;
        }

        #endregion;

        #region ----- Excel Copy&Paste Methods ----

        //[Sheet2]내용을 [Sheet1]에 붙여넣기
        private int CopyAndPaste(int pCopySumPrintingLine)
        {
            int vPrintHeaderColumnSTART = mXLColumnAreaSTART; //복사되어질 쉬트의 폭, 시작열
            int vPrintHeaderColumnEND = mXLColumnAreaEND;     //복사되어질 쉬트의 폭, 종료열

            int vCopySumPrintingLine = pCopySumPrintingLine;

            try
            {
                int vCopyPrintingRowSTART = vCopySumPrintingLine;
                vCopySumPrintingLine = vCopySumPrintingLine + mMaxIncrementCopy;
                int vCopyPrintingRowEnd = vCopySumPrintingLine;

                string vPageNumberText = string.Format("Page {0}/{1}", mPageNumber, mPageTotalNumber);
                mPrinting.XLSetCell((mMaxIncrementCopy - 1), 20, vPageNumberText);

                mPrinting.XLActiveSheet("SourceTab1"); //mPrinting.XLActiveSheet(2);
                object vRangeSource = mPrinting.XLGetRange(vPrintHeaderColumnSTART, 1, mMaxIncrementCopy, vPrintHeaderColumnEND); //[원본], [Sheet2.Cell("A1:AS67")], 엑셀 쉬트에서 복사 시작할 행번호, 엑셀 쉬트에서 복사 시작할 열번호, 엑셀 쉬트에서 복사 종료할 행번호, 엑셀 쉬트에서 복사 종료할 열번호

                mPrinting.XLActiveSheet("Destination"); //mPrinting.XLActiveSheet(1);
                object vRangeDestination = mPrinting.XLGetRange(vCopyPrintingRowSTART, 1, vCopyPrintingRowEnd, vPrintHeaderColumnEND); //[대상], [Sheet1.Cell("A1:AS67")], 엑셀 쉬트에서 복사 시작할 행번호, 엑셀 쉬트에서 복사 시작할 열번호, 엑셀 쉬트에서 복사 종료할 행번호, 엑셀 쉬트에서 복사 종료할 열번호
                mPrinting.XLCopyRange(vRangeSource, vRangeDestination);
            }
            catch (System.Exception ex)
            {
                mMessageError = string.Format("{0}", ex.Message);
                mIsAppInterFace.OnAppMessage(mMessageError);
                System.Windows.Forms.Application.DoEvents();
            }

            return vCopySumPrintingLine;
        }

        #endregion;

        #region ----- Printing Methods ----

        public void Printing(int pPageSTART, int pPageEND)
        {
            try
            {
                mPrinting.XLPrinting(pPageSTART, pPageEND);
            }
            catch (System.Exception ex)
            {
                mMessageError = string.Format("{0}", ex.Message);
                mIsAppInterFace.OnAppMessage(mMessageError);
                System.Windows.Forms.Application.DoEvents();
            }
        }

        public void PreView()
        {
            try
            {
                mPrinting.XLPrintPreview();
            }
            catch (System.Exception ex)
            {
                mMessageError = string.Format("{0}", ex.Message);
                mIsAppInterFace.OnAppMessage(mMessageError);
                System.Windows.Forms.Application.DoEvents();
            }
        }

        #endregion;

        #region ----- Save Methods ----

        public void Save(string pSaveFileName)
        {
            try
            {
                System.IO.DirectoryInfo vWallpaperFolder = new System.IO.DirectoryInfo(Environment.GetFolderPath(Environment.SpecialFolder.DesktopDirectory));

                int vMaxNumber = MaxIncrement(vWallpaperFolder.ToString(), pSaveFileName);
                vMaxNumber = vMaxNumber + 1;
                string vSaveFileName = string.Format("{0}{1:D3}", pSaveFileName, vMaxNumber);

                vSaveFileName = string.Format("{0}\\{1}.xls", vWallpaperFolder, vSaveFileName);
                mPrinting.XLSave(vSaveFileName);
            }
            catch (System.Exception ex)
            {
                mMessageError = string.Format("{0}", ex.Message);
                mIsAppInterFace.OnAppMessage(mMessageError);
                System.Windows.Forms.Application.DoEvents();
            }
        }

        #endregion;

        #endregion;
    }
}
