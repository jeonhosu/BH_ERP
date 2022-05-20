using System;

namespace FCMF0225
{
    /// <summary>
    /// XLPrint Class를 이용해 Report물 제어 
    /// </summary>
    public class XLPrinting
    {
        #region ----- Variables -----

        private InfoSummit.Win.ControlAdv.ISGridAdvEx mGridAdvEx;

        private InfoSummit.Win.ControlAdv.ISProgressBar mProgressBar1;
        private InfoSummit.Win.ControlAdv.ISProgressBar mProgressBar2;

        

        private XL.XLPrint mPrinting = null;

        private string mMessageError = string.Empty;

        private string mXLOpenFileName = string.Empty;

        private int[] mIndexGridHeader1COL = new int[0] { };
        private int[] mIndexGridHeader0COL = new int[0] { };
        private int[] mIndexXLHeader1COL = new int[0] { }; //엑셀 해더1에 출력할 열 위치 지정
        private int[] mIndexXLHeader0COL = new int[0] { }; //엑셀 해더0에 출력할 열 위치 지정

        private int[] mIndexGridColumns = new int[0] { };
        private int[] mIndexXLWriteColumn = new int[0] { }; //엑셀에 출력할 열 위치 지정

        private int mPositionPrintLineSTART = 7;            //내용 출력시 엑셀 시작 행 위치 지정

        private int mSumWriteLine = 0;        //엑셀에 출력되는 행 누적 값
        private int mRepeatIncrement = 38;    //실제 출력되는 행의 시작부터 끝 행의 범위
        private int mSumPrintingLineCopy = 1; //엑셀의 선택된 쉬트에 복사되어질 시작 행 위치 및 누적 행 값
        private int mMaxIncrementCopy = 45;   //반복 복사되어질 행의 최대 범위

        private int mXLColumnAreaSTART = 1;   //복사되어질 쉬트의 폭, 시작열
        private int mXLColumnAreaEND = 65;    //복사되어질 쉬트의 폭, 종료열

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
        /// Message 출력할 Grid
        /// </summary>
        public InfoSummit.Win.ControlAdv.ISGridAdvEx MessageGridEx
        {
            set
            {
                mGridAdvEx = value;
            }
        }

        /// <summary>
        /// 전체 Data 진행 ProgressBar
        /// </summary>
        public InfoSummit.Win.ControlAdv.ISProgressBar ProgressBar1
        {
            set
            {
                mProgressBar1 = value;
            }
        }

        /// <summary>
        /// Page당 Data 진행 ProgressBar
        /// </summary>
        public InfoSummit.Win.ControlAdv.ISProgressBar ProgressBar2
        {
            set
            {
                mProgressBar2 = value;
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

        public XLPrinting()
        {
            mPrinting = new XL.XLPrint();
        }

        #endregion;

        #region ----- Interior Use Methods ----

        #region ----- MessageGrid Methods ----

        private void MessageGrid(string pMessage)
        {
            int vCountRow = mGridAdvEx.RowCount;
            vCountRow = vCountRow + 1;
            mGridAdvEx.RowCount = vCountRow;

            int vCurrentRow = vCountRow - 1;

            mGridAdvEx.SetCellValue(vCurrentRow, 0, pMessage);

            mGridAdvEx.CurrentCellMoveTo(vCurrentRow, 0);
            mGridAdvEx.Focus();
            mGridAdvEx.CurrentCellActivate(vCurrentRow, 0);
        }

        #endregion;

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
            }

            return IsOpen;
        }

        #endregion;

        #region ----- Line Clear All Methods ----

        private void XlAllLineClear(XL.XLPrint pPrinting)
        {
            int vXLColumn1 = 2;  //No[OPERATION_SEQ_NO]
            int vXLColumn2 = 4;  //공정명[OPERATION_DESCRIPTION]
            int vXLColumn3 = 11; //공정 진행시 작업 조건[OPERATION_COMMENT]

            int vXLDrawLineColumnSTART = 2; //선그리기, 시작 열
            int vXLDrawLineColumnEND = 45;  //선그리기, 종료 열

            object vObject = null;
            int vMaxPrintingLine = mMaxIncrementCopy;

            //pPrinting.XLActiveSheet(2);
            pPrinting.XLActiveSheet("SourceTab1");

            for (int vXLine = mPositionPrintLineSTART; vXLine < vMaxPrintingLine; vXLine++)
            {
                pPrinting.XLSetCell(vXLine, vXLColumn1, vObject); //No[OPERATION_SEQ_NO]
                pPrinting.XLSetCell(vXLine, vXLColumn2, vObject); //공정명[OPERATION_DESCRIPTION]
                pPrinting.XLSetCell(vXLine, vXLColumn3, vObject); //공정 진행시 작업 조건[OPERATION_COMMENT]

                if (vXLine < mMaxIncrementCopy)
                {
                    pPrinting.XL_LineClear(vXLine, vXLDrawLineColumnSTART, vXLDrawLineColumnEND);
                }
            }
        }

        #endregion;

        #region ----- Line Clear Methods ----

        //XlLineClear(mPrinting, vPrintingLine);
        private void XlLineClear(XL.XLPrint pPrinting, int pPrintingLine)
        {
            int vXLColumn1 = 2;  //No[OPERATION_SEQ_NO]
            int vXLColumn2 = 4;  //공정명[OPERATION_DESCRIPTION]
            int vXLColumn3 = 11; //공정 진행시 작업 조건[OPERATION_COMMENT]

            int vXLDrawLineColumnSTART = 2; //선그리기, 시작 열
            int vXLDrawLineColumnEND = 45;  //선그리기, 종료 열

            object vObject = null;
            int vMaxPrintingLine = mMaxIncrementCopy;

            for (int vXLine = pPrintingLine; vXLine < vMaxPrintingLine; vXLine++)
            {
                pPrinting.XLSetCell(vXLine, vXLColumn1, vObject); //No[OPERATION_SEQ_NO]
                pPrinting.XLSetCell(vXLine, vXLColumn2, vObject); //공정명[OPERATION_DESCRIPTION]
                pPrinting.XLSetCell(vXLine, vXLColumn3, vObject); //공정 진행시 작업 조건[OPERATION_COMMENT]

                if (vXLine < mMaxIncrementCopy)
                {
                    pPrinting.XL_LineClear(vXLine, vXLDrawLineColumnSTART, vXLDrawLineColumnEND);
                }
            }
        }

        #endregion;

        #region ----- Title Methods ----

        private void XLTitle(int pRow, int pColumn, string pTitle)
        {
            try
            {
                mPrinting.XLActiveSheet("SourceTab1"); //mPrinting.XLActiveSheet(2);
                mPrinting.XLSetCell(pRow, pColumn, pTitle);
            }
            catch (System.Exception ex)
            {
                mMessageError = string.Format("{0}", ex.Message);
            }
        }

        #endregion;

        #region ----- Header Left Methods ----

        private void XLHeaderLeft(int pRow, int pColumn, string pContent)
        {
            try
            {
                mPrinting.XLActiveSheet("SourceTab1"); //mPrinting.XLActiveSheet(2);
                mPrinting.XLSetCell(pRow, pColumn, pContent);
            }
            catch (System.Exception ex)
            {
                mMessageError = string.Format("{0}", ex.Message);
            }
        }

        #endregion;

        #region ----- Header Right Methods ----

        private void XLHeaderRight(int pRow, int pColumn, string pContent)
        {
            try
            {
                mPrinting.XLActiveSheet("SourceTab1"); //mPrinting.XLActiveSheet(2);
                mPrinting.XLSetCell(pRow, pColumn, pContent);
            }
            catch (System.Exception ex)
            {
                mMessageError = string.Format("{0}", ex.Message);
            }
        }

        #endregion;

        #region ----- Footer Left Methods ----

        private void XLFooterLeft(int pRow, int pColumn, string pContent)
        {
            try
            {
                mPrinting.XLActiveSheet("SourceTab1"); //mPrinting.XLActiveSheet(2);
                mPrinting.XLSetCell(pRow, pColumn, pContent);
            }
            catch (System.Exception ex)
            {
                mMessageError = string.Format("{0}", ex.Message);
            }
        }

        #endregion;

        #region ----- Footer Right Methods ----

        private void XLFooterRight(int pRow, int pColumn, string pContent)
        {
            try
            {
                mPrinting.XLActiveSheet("SourceTab1"); //mPrinting.XLActiveSheet(2);
                mPrinting.XLSetCell(pRow, pColumn, pContent);
            }
            catch (System.Exception ex)
            {
                mMessageError = string.Format("{0}", ex.Message);
            }
        }

        #endregion;

        #region ----- Print Header Methods ----

        private void XLHeader(string pTitle, string pHeaderLeft, string pHeaderRight)
        {
            try
            {
                XLTitle(2, 2, pTitle);

                XLHeaderLeft(4, 2, pHeaderLeft);
                XLHeaderRight(4, 54, pHeaderRight);
            }
            catch (System.Exception ex)
            {
                mMessageError = string.Format("{0}", ex.Message);
            }
        }

        #endregion;

        #region ----- Print Footer Methods ----

        private void XLFooter(string pFooterLeft, string pFooterRight)
        {
            try
            {
                XLFooterLeft(45, 2, pFooterLeft);
                XLFooterRight(45, 45, pFooterRight);
            }
            catch (System.Exception ex)
            {
                mMessageError = string.Format("{0}", ex.Message);
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
                    "BANK_NAME",             //은행명  
                    "SLIP_DATE",             //기표일자
                    "SLIP_NUM",              //기표번호
                    "GL_DATE",               //회계일자
                    "CURRENCY_CODE",         //통화    
                    "DR_AMOUNT",             //차변
                    "DR_CURR_AMOUNT",        //대변
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
                    2,  //BANK_NAME             //은행명
                    12, //SLIP_DATE             //기표일자
                    17, //SLIP_NUM              //기표번호
                    23, //GL_DATE               //회계일자
                    28, //CURRENCY_CODE         //통화
                    34, //CR_AMOUNT             //차변
                    50, //DR_CURR_AMOUNT        //대변
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
                    "DR_AMOUNT",             //차변금액
                    "CR_AMOUNT",             //대변금액
                    "DR_CURR_AMOUNT",        //차변외화
                    "CR_CURR_AMOUNT"         //대변외화
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
                    34, //DR_AMOUNT             //차변금액
                    42, //CR_AMOUNT             //대변금액
                    50, //DR_CURR_AMOUNT        //차변외화
                    58  //CR_CURR_AMOUNT        //대변외화
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
                    "BANK_NAME",             //은행명  
                    "SLIP_DATE",             //기표일자
                    "SLIP_NUM",              //기표번호
                    "GL_DATE",               //회계일자
                    "CURRENCY_CODE",         //통화    
                    "DR_AMOUNT",             //차변금액
                    "CR_AMOUNT",             //대변금액
                    "DR_CURR_AMOUNT",        //차변외화
                    "CR_CURR_AMOUNT"         //대변외화
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
                    2,  //BANK_NAME             //은행명
                    12, //SLIP_DATE             //기표일자
                    17, //SLIP_NUM              //기표번호
                    23, //GL_DATE               //회계일자
                    28, //CURRENCY_CODE         //통화
                    34, //DR_AMOUNT             //차변금액
                    42, //CR_AMOUNT             //대변금액
                    50, //DR_CURR_AMOUNT        //차변외화
                    58  //CR_CURR_AMOUNT        //대변외화
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

        private object ConvertDateTime(object pObject)
        {
            object vObject = null;

            try
            {
                if (pObject != null)
                {
                    bool IsConvert = pObject is System.DateTime;
                    if (IsConvert == true)
                    {
                        System.DateTime vDateTime = (System.DateTime)pObject;
                        //string vTextDateTimeLong = vDateTime.ToString("yyyy-MM-dd HH:mm:ss", null);
                        string vTextDateTimeLong = vDateTime.ToString("yyyy-MM-dd", null);
                        string vTextDateTimeShort = vDateTime.ToShortDateString();
                        vObject = vTextDateTimeLong;
                    }
                }
            }
            catch (System.Exception ex)
            {
                mMessageError = string.Format("{0}", ex.Message);
            }

            return vObject;
        }

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
                            if (vCol == 1)
                            {
                                vObject = pGrid.GetCellValue(vRow, mIndexGridColumns[vCol]);
                                vObject = ConvertDateTime(vObject);
                            }
                            else if (vCol == 3)
                            {
                                vObject = pGrid.GetCellValue(vRow, mIndexGridColumns[vCol]);
                                vObject = ConvertDateTime(vObject);
                            }
                            else if (vCol == 5)
                            {
                                vObject = pGrid.GetCellValue(vRow, mIndexGridColumns[vCol]);
                                vObject = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vObject);
                            }
                            else if (vCol == 6)
                            {
                                vObject = pGrid.GetCellValue(vRow, mIndexGridColumns[vCol]);
                                vObject = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vObject);
                            }
                            else if (vCol == 7)
                            {
                                vObject = pGrid.GetCellValue(vRow, mIndexGridColumns[vCol]);
                                vObject = string.Format("{0:###,###,###,###,###,###,###,##0.0000}", vObject);
                            }
                            else if (vCol == 8)
                            {
                                vObject = pGrid.GetCellValue(vRow, mIndexGridColumns[vCol]);
                                vObject = string.Format("{0:###,###,###,###,###,###,###,##0.0000}", vObject);
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
        public int XLWirte(InfoSummit.Win.ControlAdv.ISGridAdvEx pGrid, int pTerritory, string pPeriodFrom, string pPeriodTo, string pUserName, string pCaption)
        {
            string vMessageText = string.Empty;

            string vPrintingDate = System.DateTime.Now.ToString("yyyy-MM-dd", null);
            string vPrintingTime = System.DateTime.Now.ToString("HH:mm:ss", null);

            int vPageNumber = 0;

            try
            {
                int vTotalRow = pGrid.RowCount; //Grid의 총 행수

                //[출력될 열 지정]
                XLDefineHeaderColumn(pGrid);
                XLDefinePrintColumn(pGrid);

                //vTotalRow = 60;
                while (vTotalRow > mSumWriteLine)
                {
                    vPageNumber++;

                    //[Header]
                    string vTitle = "Bank Check List";
                    string vHeaderLeft = string.Format("Inquiry Period : {0} ~ {1}", pPeriodFrom, pPeriodTo);
                    switch (pTerritory)
                    {
                        case 1: //Default
                            vTitle = "Bank Check List";
                            vHeaderLeft = string.Format("Inquiry Period : {0} ~ {1}", pPeriodFrom, pPeriodTo);
                            break;
                        case 2: //KR
                            vTitle = "제예금 은행별 체크 List";
                            vHeaderLeft = string.Format("조회년월 : {0} ~ {1}", pPeriodFrom, pPeriodTo);
                            break;
                    }
                    string vHeaderRight = string.Format("Page : {0}", vPageNumber);
                    XLHeader(vTitle, vHeaderLeft, vHeaderRight);

                    //[Footer]
                    string vFooterLeft = string.Format("{0} {1} - {2}", vPrintingDate, vPrintingTime, pUserName);
                    string vFooterRight = string.Format("{0}", pCaption);
                    XLFooter(vFooterLeft, vFooterRight);

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

            return vPageNumber;
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

                mPrinting.XLActiveSheet("SourceTab1"); //mPrinting.XLActiveSheet(2);
                object vRangeSource = mPrinting.XLGetRange(vPrintHeaderColumnSTART, 1, mMaxIncrementCopy, vPrintHeaderColumnEND); //[원본], [Sheet2.Cell("A1:AS67")], 엑셀 쉬트에서 복사 시작할 행번호, 엑셀 쉬트에서 복사 시작할 열번호, 엑셀 쉬트에서 복사 종료할 행번호, 엑셀 쉬트에서 복사 종료할 열번호

                mPrinting.XLActiveSheet("Destination"); //mPrinting.XLActiveSheet(1);
                object vRangeDestination = mPrinting.XLGetRange(vCopyPrintingRowSTART, 1, vCopyPrintingRowEnd, vPrintHeaderColumnEND); //[대상], [Sheet1.Cell("A1:AS67")], 엑셀 쉬트에서 복사 시작할 행번호, 엑셀 쉬트에서 복사 시작할 열번호, 엑셀 쉬트에서 복사 종료할 행번호, 엑셀 쉬트에서 복사 종료할 열번호
                mPrinting.XLCopyRange(vRangeSource, vRangeDestination);
            }
            catch (System.Exception ex)
            {
                mMessageError = string.Format("{0}", ex.Message);
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
            }
        }

        #endregion;

        #endregion;
    }
}
