using System;

namespace FCMF0551
{
    public class XLPrinting
    {
        #region ----- Variables -----

        private InfoSummit.Win.ControlAdv.ISAppInterface mAppInterface = null;
        private InfoSummit.Win.ControlAdv.ISMessageAdapter mMessageAdapter = null;

        private XL.XLPrint mPrinting = null;

        private string mMessageError = string.Empty;

        private int mPageNumber = 0;

        private string mPrintingDateTime = string.Empty;

        private bool mIsNewPage = false;

        private string mXLOpenFileName = string.Empty;

        private int mPrintingLineSTART1 = 7; //라인 출력시 엑셀 시작 행 위치 지정

        private int mCopyLineSUM = 1;        //엑셀의 선택된 쉬트의 복사되어질 시작 행 위치
        private int mIncrementCopyMAX = 31;  //복사되어질 행의 범위

        private int mCopyColumnSTART = 1; //복사되어  진 행 누적 수
        private int mCopyColumnEND = 70;  //엑셀의 선택된 쉬트의 복사되어질 끝 열 위치

        private string mAccountCode = string.Empty;
        private string mAccountName = string.Empty;

        #endregion;

        #region ----- Property -----

        public string ErrorMessage
        {
            get
            {
                return mMessageError;
            }
        }

        public string OpenFileNameExcel
        {
            set
            {
                mXLOpenFileName = value;
            }
        }

        #endregion;

        #region ----- Constructor -----

        public XLPrinting(InfoSummit.Win.ControlAdv.ISAppInterface pAppInterface, InfoSummit.Win.ControlAdv.ISMessageAdapter pMessageAdapter)
        {
            mPrinting = new XL.XLPrint();
            mAppInterface = pAppInterface;
            mMessageAdapter = pMessageAdapter;
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

        #region ----- Dispose -----

        public void Dispose()
        {
            mPrinting.XLOpenFileClose();
            mPrinting.XLClose();
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

        #region ----- Line SLIP Methods ----

        #region ----- Array Set ----

        private void SetArray1(InfoSummit.Win.ControlAdv.ISGridAdvEx pGrid, out int[] pGDColumn, out int[] pXLColumn)
        {
            pGDColumn = new int[7];
            pXLColumn = new int[7];

            pGDColumn[0] = pGrid.GetColumnToIndex("GL_DATE");           //일자
            pGDColumn[1] = pGrid.GetColumnToIndex("REMARK");            //적요
            pGDColumn[2] = pGrid.GetColumnToIndex("DR_AMOUNT");         //차변
            pGDColumn[3] = pGrid.GetColumnToIndex("CR_AMOUNT");         //대변
            pGDColumn[4] = pGrid.GetColumnToIndex("REMAIN_AMOUNT");     //잔액
            //------------ 2011.7.6 외화금액 출력 요청 건으로 추가 작업 -------------
            pGDColumn[5] = pGrid.GetColumnToIndex("DR_CURRENCY_AMOUNT");//차변(외화)
            pGDColumn[6] = pGrid.GetColumnToIndex("CR_CURRENCY_AMOUNT");//대변(외화)
            //-----------------------------------------------------------------------

            pXLColumn[0] = 02;   //일자
            pXLColumn[1] = 07;   //적요
            pXLColumn[2] = 20;   //차변
            pXLColumn[3] = 28;   //대변
            pXLColumn[4] = 36;   //잔액
            pXLColumn[5] = 44;   //차변(외화)
            pXLColumn[6] = 52;   //대변(외화)

        }

        #endregion;

        #region ----- IsConvert Methods -----

        private bool IsConvertString(object pObject, out string pConvertString)
        {
            bool vIsConvert = false;
            pConvertString = string.Empty;

            try
            {
                if (pObject != null)
                {
                    vIsConvert = pObject is string;
                    if (vIsConvert == true)
                    {
                        pConvertString = pObject as string;
                    }
                }

            }
            catch (System.Exception ex)
            {
                mMessageError = ex.Message;
                mAppInterface.OnAppMessageEvent(mMessageError);
                System.Windows.Forms.Application.DoEvents();
            }

            return vIsConvert;
        }

        private bool IsConvertNumber(object pObject, out decimal pConvertDecimal)
        {
            bool vIsConvert = false;
            pConvertDecimal = 0m;

            try
            {
                if (pObject != null)
                {
                    vIsConvert = pObject is decimal;
                    if (vIsConvert == true)
                    {
                        decimal vIsConvertNum = (decimal)pObject;
                        pConvertDecimal = vIsConvertNum;
                    }
                }

            }
            catch (System.Exception ex)
            {
                mMessageError = ex.Message;
                mAppInterface.OnAppMessageEvent(mMessageError);
                System.Windows.Forms.Application.DoEvents();
            }

            return vIsConvert;
        }

        private bool IsConvertDate(object pObject, out string pConvertDateTimeShort)
        {
            bool IsConvert = false;
            pConvertDateTimeShort = string.Empty;

            try
            {
                if (pObject != null)
                {
                    IsConvert = pObject is System.DateTime;
                    if (IsConvert == true)
                    {
                        System.DateTime vDateTime = (System.DateTime)pObject;
                        pConvertDateTimeShort = vDateTime.ToShortDateString();
                    }
                }
            }
            catch (System.Exception ex)
            {
                mMessageError = ex.Message;
                mAppInterface.OnAppMessageEvent(mMessageError);
                System.Windows.Forms.Application.DoEvents();
            }

            return IsConvert;
        }

        #endregion;

        #region ----- XlLine1 Methods -----

        private int XlLine1(InfoSummit.Win.ControlAdv.ISGridAdvEx pGrid, int pGridRow, int pXLine, int[] pGDColumn, int[] pXLColumn)
        {
            int vXLine = pXLine; //엑셀에 내용이 표시되는 행 번호

            int vGDColumnIndex = 0;
            int vXLColumnIndex = 0;

            object vObject = null;
            string vConvertString = string.Empty;
            decimal vConvertDecimal = 0m;
            bool IsConvert = false;

            int vLineColumnSTART = mCopyColumnSTART + 1;
            int vLineColumnEND = mCopyColumnEND - 1;

            try
            {
                mPrinting.XLActiveSheet("Destination");

                mPrinting.XL_LineDraw_Bottom(vXLine, vLineColumnSTART, vLineColumnEND, 1);

                //일자
                vGDColumnIndex = pGDColumn[0];
                vXLColumnIndex = pXLColumn[0];
                vObject = pGrid.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertDate(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0}", vConvertString);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                //적요
                vGDColumnIndex = pGDColumn[1];
                vXLColumnIndex = pXLColumn[1];
                vObject = pGrid.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0}", vConvertString);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);

                    if (vConvertString == "이월금액"
                     || vConvertString == "월누계"
                     || vConvertString == "총누계")
                    {
                        mPrinting.XL_LineDraw_TopBottom(vXLine, vLineColumnSTART, vLineColumnEND, 2);
                        mPrinting.XLCellAlignmentHorizontal(vXLine, pXLColumn[1], vXLine, pXLColumn[1], "C");
                    }
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                //차변
                vGDColumnIndex = pGDColumn[2];
                vXLColumnIndex = pXLColumn[2];
                vObject = pGrid.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,###}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                //대변
                vGDColumnIndex = pGDColumn[3];
                vXLColumnIndex = pXLColumn[3];
                vObject = pGrid.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,###}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                //잔액
                vGDColumnIndex = pGDColumn[4];
                vXLColumnIndex = pXLColumn[4];
                vObject = pGrid.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,###}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                //차변(외화)
                vGDColumnIndex = pGDColumn[5];
                vXLColumnIndex = pXLColumn[5];
                vObject = pGrid.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true && Convert.ToDecimal(vObject) != 0)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,###.0000}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                //대변(외화)
                vGDColumnIndex = pGDColumn[6];
                vXLColumnIndex = pXLColumn[6];
                vObject = pGrid.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true && Convert.ToDecimal(vObject) != 0)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,###.0000}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                //-------------------------------------------------------------------
                vXLine++;
                //-------------------------------------------------------------------
            }
            catch (System.Exception ex)
            {
                mMessageError = ex.Message;
                mAppInterface.OnAppMessageEvent(mMessageError);
                System.Windows.Forms.Application.DoEvents();
            }


            pXLine = vXLine;

            return pXLine;
        }

        #endregion;

        #endregion;

        #region ----- Excel Wirte [Line] Methods ----

        public int LineWrite(InfoSummit.Win.ControlAdv.ISGridAdvEx pGrid, string pPeriod, string pSupplierCustomerName)
        {
            string vMessage = string.Empty;
            mIsNewPage = false;

            mPrintingDateTime = string.Format("{0}", System.DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss", null));

            int[] vGDColumn;
            int[] vXLColumn;

            int vPrintingLine = mPrintingLineSTART1;

            object vObject = null;
            bool IsConvert = false;
            int vAccountCodeColumnIndex = pGrid.GetColumnToIndex("ACCOUNT_CODE");
            int vAccountNameColumnIndex = pGrid.GetColumnToIndex("ACCOUNT_DESC");
            string tmpAccountCode = string.Empty;
            bool vIsPageSkip = false;

            try
            {
                int vTotalRow = pGrid.RowCount;

                #region ----- First Write ----

                if (vTotalRow > 0)
                {
                    int vCountRow = 0;

                    //-------------------------------------------------------
                    //[초기값 설정]
                    //-------------------------------------------------------
                    vObject = pGrid.GetCellValue(0, vAccountCodeColumnIndex);
                    IsConvert = IsConvertString(vObject, out tmpAccountCode);
                    vObject = pGrid.GetCellValue(0, vAccountNameColumnIndex);
                    IsConvert = IsConvertString(vObject, out mAccountName);
                    mAccountCode = tmpAccountCode;
                    //-------------------------------------------------------

                    SetArray1(pGrid, out vGDColumn, out vXLColumn);

                    mPrinting.XLActiveSheet("SourceTab1");
                    mPrinting.XLSetCell(3, 2, pPeriod);
                    mPrinting.XLSetCell(5, 13, pSupplierCustomerName);

                    mCopyLineSUM = CopyAndPaste(mCopyLineSUM);

                    for (int vRow = 0; vRow < vTotalRow; vRow++)
                    {
                        vObject = pGrid.GetCellValue(vRow, vAccountNameColumnIndex);
                        IsConvert = IsConvertString(vObject, out mAccountName);
                        vObject = pGrid.GetCellValue(vRow, vAccountCodeColumnIndex);
                        IsConvert = IsConvertString(vObject, out mAccountCode);

                        if (IsConvert == true)
                        {
                            if (mAccountCode != tmpAccountCode)
                            {
                                tmpAccountCode = mAccountCode;
                                vIsPageSkip = true;
                            }
                            else
                            {
                                vIsPageSkip = false;
                            }
                        }
                        else
                        {
                            vIsPageSkip = false;
                        }

                        IsNewPage(vPrintingLine, vIsPageSkip);
                        if (mIsNewPage == true)
                        {
                            vPrintingLine = (mCopyLineSUM - mIncrementCopyMAX) + (mPrintingLineSTART1 - 1);
                        }

                        vCountRow++;
                        vMessage = string.Format("{0}/{1}", vCountRow, vTotalRow);
                        mAppInterface.OnAppMessageEvent(vMessage);
                        System.Windows.Forms.Application.DoEvents();

                        vPrintingLine = XlLine1(pGrid, vRow, vPrintingLine, vGDColumn, vXLColumn);
                    }

                    if (vTotalRow == vCountRow)
                    {
                        //마지막 행이면...
                        PageNumberSetCell(vPrintingLine);
                    }
                }

                #endregion;
            }
            catch (System.Exception ex)
            {
                mMessageError = ex.Message;
                mPrinting.XLOpenFileClose();
                mPrinting.XLClose();
            }

            return mPageNumber;
        }

        #endregion;

        #region ----- New Page iF Methods ----

        private void IsNewPage(int pPrintingLine, bool pIsPageSkip)
        {
            int vPrintingLineEND = mCopyLineSUM - 2; // mCopyLineSUM = 48, 48 - 2 = 46, 46에서 Page Skip 하기위해 48에서 2를 뺌.
            if (vPrintingLineEND < pPrintingLine)
            {
                mIsNewPage = true;

                PageNumberSetCell(pPrintingLine);

                mCopyLineSUM = CopyAndPaste(mCopyLineSUM);
            }
            else if (pIsPageSkip == true)
            {
                mIsNewPage = true;

                PageNumberSetCell(pPrintingLine);

                mCopyLineSUM = CopyAndPaste(mCopyLineSUM);
            }
            else
            {
                mIsNewPage = false;
            }
        }

        #endregion;

        #region ----- Page Number Method ----

        private void PageNumberSetCell(int pXLine)
        {
            string vPageNumberText = string.Empty;
            int vPageNumber = mPageNumber;
            int vRowSTART = pXLine;
            int vRowEND = pXLine;
            int vColumnSTART = 52;
            int vColumnEND = 69;

            vPageNumberText = string.Format("{0} [{1}]", mPrintingDateTime, vPageNumber);

            mPrinting.XLCellMerge(vRowSTART, vColumnSTART, vRowEND, vColumnEND, false);
            mPrinting.XLSetCell(vRowSTART, vColumnSTART, vPageNumberText); //페이지 번호, XLcell[행, 열]
            mPrinting.XLCellAlignmentHorizontal(vRowSTART, vColumnSTART, vRowEND, vColumnSTART, "R");
        }

        #endregion;

        #region ----- Copy&Paste Sheet Method ----

        //첫번째 페이지 복사
        private int CopyAndPaste(int pCopySumPrintingLine)
        {
            int vCopySumPrintingLine = pCopySumPrintingLine;

            int vCopyPrintingRowSTART = vCopySumPrintingLine;
            vCopySumPrintingLine = vCopySumPrintingLine + mIncrementCopyMAX;
            int vCopyPrintingRowEnd = vCopySumPrintingLine;
            mPrinting.XLActiveSheet("SourceTab1");
            object vRangeSource = mPrinting.XLGetRange(mCopyColumnSTART, 1, mIncrementCopyMAX, mCopyColumnEND); //[원본], [Sheet2.Cell("A1:AS67")], 엑셀 쉬트에서 복사 시작할 행번호, 엑셀 쉬트에서 복사 시작할 열번호, 엑셀 쉬트에서 복사 종료할 행번호, 엑셀 쉬트에서 복사 종료할 열번호
            mPrinting.XLActiveSheet("Destination");
            object vRangeDestination = mPrinting.XLGetRange(vCopyPrintingRowSTART, 1, vCopyPrintingRowEnd, mCopyColumnEND); //[대상], [Sheet1.Cell("A1:AS67")], 엑셀 쉬트에서 복사 시작할 행번호, 엑셀 쉬트에서 복사 시작할 열번호, 엑셀 쉬트에서 복사 종료할 행번호, 엑셀 쉬트에서 복사 종료할 열번호
            mPrinting.XLCopyRange(vRangeSource, vRangeDestination);

            mPageNumber++; //페이지 번호

            int vXLine = pCopySumPrintingLine + 4;
            string vAccountName = string.Format("계정과목 : [{0}] {1}", mAccountCode, mAccountName);
            mPrinting.XLSetCell(vXLine, 45, vAccountName);

            return vCopySumPrintingLine;
        }

        #endregion;

        #region ----- Printing Methods ----

        public void Printing(int pPageSTART, int pPageEND)
        {
            mPrinting.XLPrinting(pPageSTART, pPageEND);
        }

        public void PreviewPrinting(int pPageSTART, int pPageEND)
        {
            mPrinting.XLPreviewPrinting(pPageSTART, pPageEND, 1);
        }

        #endregion;

        #region ----- Save Methods ----

        public void Save(string pSaveFileName)
        {
            System.IO.DirectoryInfo vWallpaperFolder = new System.IO.DirectoryInfo(Environment.GetFolderPath(Environment.SpecialFolder.DesktopDirectory));

            int vMaxNumber = MaxIncrement(vWallpaperFolder.ToString(), pSaveFileName);
            vMaxNumber = vMaxNumber + 1;
            string vSaveFileName = string.Format("{0}{1:D3}", pSaveFileName, vMaxNumber);

            vSaveFileName = string.Format("{0}\\{1}.xls", vWallpaperFolder, vSaveFileName);
            mPrinting.XLSave(vSaveFileName);
        }

        #endregion;
    }
}