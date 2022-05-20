using System;

namespace FCMF0257
{
    /// <summary>
    /// XLPrint Class를 이용해 Report물 제어 
    /// </summary>
    public class XLPrinting
    {
        #region ----- Variables -----

        private XL.XLPrint mPrinting = null;

        private InfoSummit.Win.ControlAdv.ISAppInterfaceAdv mIsAppInterFace;
        private InfoSummit.Win.ControlAdv.ISMessageAdapter mIsMessageAdapter;

        private string mMessageError = string.Empty;

        private string mXLOpenFileName = string.Empty;

        private int mTotalRowGrid = 0; //Grid Total Row

        private int[] mIndexGridColumns = new int[0] { };
        private int[] mIndexXLWriteColumn = new int[0] { }; //엑셀에 출력할 열 위치 지정

        private int mPositionPrintLineSTART = 6; //내용 출력시 엑셀 시작 행 위치 지정
        private int mSumWriteLine = 0; //엑셀에 출력되는 행 누적 값
        private int mMaxIncrementRead = 30; //반복 읽어 들일 행수

        private int mSumPrintingLineCopy = 1; //엑셀의 선택된 쉬트에 복사되어질 시작 행 위치 및 누적 행 값
        private int mMaxIncrementCopy = 37; //반복 복사되어질 행의 최대 범위

        private int mXLColumnAreaSTART = 1; //복사되어질 쉬트의 폭, 시작열
        private int mXLColumnAreaEND = 66;  //복사되어질 쉬트의 폭, 종료열

        private string mAccountDate = string.Empty;
        private string mAccountCode = string.Empty;
        private string mCarryOver = string.Empty;

        private decimal mSum_Debit_Amount = 0;  //차변금액
        private decimal mSum_Credit_Amount = 0; //대변금액
        private decimal mSum_Remain_Amount = 0; //잔액금액

        private decimal mTotal_Debit_Amount = 0;  //차변금액
        private decimal mTotal_Credit_Amount = 0; //대변금액
        private decimal mTotal_Remain_Amount = 0; //잔액금액

        private string mStringCarryOver = string.Empty;

        private int mDeleteLine_LastMemory = 0; //한 페이지가 출력된후 다음 페이지로 넘기기 전에 내용을 지우기 위한 행위치 기억

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

        public XLPrinting(InfoSummit.Win.ControlAdv.ISAppInterfaceAdv pIsAppInterFace, InfoSummit.Win.ControlAdv.ISMessageAdapter pIsMessageAdapter)
        {
            mPrinting = new XL.XLPrint();

            mIsAppInterFace = pIsAppInterFace;
            mIsMessageAdapter = pIsMessageAdapter;
            mStringCarryOver = mIsMessageAdapter.ReturnText("FCM_10165");
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

        #region ----- Delete Line Methods ----

        private void DeleteLineXL(InfoSummit.Win.ControlAdv.ISGridAdvEx pGrid, int pXLine)
        {
            mPrinting.XLActiveSheet("SourceTab1");

            pXLine = pXLine + 2; //2를 더한건 한 줄더 지우기 위해
            int vXLineDelete = mPositionPrintLineSTART;
            while(vXLineDelete < pXLine)
            {
                XLContentWrite(pGrid, 0, vXLineDelete, true);
                vXLineDelete = vXLineDelete + 2;
            }

            mPrinting.XLActiveSheet("Destination");
        }

        #endregion;

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

        #region ----- Convert decimal Methods ----

        #region ----- Print Footer Methods ----

        private void XLFooter(string pFooterLeft)
        {
            try
            {
                mPrinting.XLActiveSheet("SourceTab1"); //mPrinting.XLActiveSheet(2);
                mPrinting.XLSetCell(36, 2, pFooterLeft);
            }
            catch (System.Exception ex)
            {
                mMessageError = string.Format("{0}", ex.Message);
            }
        }

        #endregion;

        #region ----- Convert Date Methods ----

        private object ConvertDate(object pObject)
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
            catch (System.Exception ex)
            {
                mMessageError = string.Format("{0}", ex.Message);
            }

            return vString;
        }

        #endregion;

        #region ----- Convert decimal Methods ----

        private decimal ConvertDecimal(object pObject)
        {
            decimal vDecimal = 0m;

            try
            {
                if (pObject != null)
                {
                    bool IsConvert = pObject is decimal;
                    if (IsConvert == true)
                    {
                        vDecimal = (decimal)pObject;
                    }
                }
            }
            catch (System.Exception ex)
            {
                mMessageError = string.Format("{0}", ex.Message);
            }

            return vDecimal;
        }

        #endregion;

        #region ----- Print Header Methods ----

        private void XLHeader(InfoSummit.Win.ControlAdv.ISGridAdvEx pGrid, int pIndexRow, string pDateTime)
        {
            try
            {
                mPrinting.XLActiveSheet("SourceTab1");

                int vIndexDataColumn01 = pGrid.GetColumnToIndex("ACCOUNT_DESC");    //계정명
                int vIndexDataColumn02 = pGrid.GetColumnToIndex("ACCOUNT_CODE");    //계정코드

                System.Drawing.Point vGridPoint01 = new System.Drawing.Point(pIndexRow, vIndexDataColumn01);  //계정명
                System.Drawing.Point vGridPoint02 = new System.Drawing.Point(pIndexRow, vIndexDataColumn02);  //계정코드

                System.Drawing.Point vXLPoint01 = new System.Drawing.Point(1, 2);    //계정명[계정코드]
                System.Drawing.Point vXLPoint02 = new System.Drawing.Point(2, 42);   //기간

                //계정명[계정코드]
                object vObject1 = pGrid.GetCellValue(vGridPoint01.X, vGridPoint01.Y);
                object vObject2 = pGrid.GetCellValue(vGridPoint02.X, vGridPoint02.Y);
                if (vObject1 != null)
                {
                    object vObject3 = string.Format("{0}({1})", vObject1, vObject2);
                    mPrinting.XLSetCell(vXLPoint01.X, vXLPoint01.Y, vObject3);
                }
                else
                {
                    vObject1 = null;
                    mPrinting.XLSetCell(vXLPoint01.X, vXLPoint01.Y, vObject1);
                }

                //[기간]
                mPrinting.XLSetCell(vXLPoint02.X, vXLPoint02.Y, pDateTime);
            }
            catch (System.Exception ex)
            {
                mMessageError = string.Format("{0}", ex.Message);
                mIsAppInterFace.OnAppMessage(mMessageError);
                System.Windows.Forms.Application.DoEvents();
            }
        }

        #endregion;

        #region ----- Print Content Write Methods ----

        private void XLContentWrite(InfoSummit.Win.ControlAdv.ISGridAdvEx pGrid, int pIndexRow, int pXLine, bool vNullValue)
        {
            object vObject = null;

            try
            {
                mPrinting.XLActiveSheet("SourceTab1");

                string vMenagement = string.Empty; //관리항목[이월금액]

                int vIndexDataColumn01 = pGrid.GetColumnToIndex("GL_DATE");          //회계일자
                int vIndexDataColumn02 = pGrid.GetColumnToIndex("MANAGEMENT_DESC");  //관리항목
                int vIndexDataColumn03 = pGrid.GetColumnToIndex("REMARK");           //적요
                int vIndexDataColumn04 = pGrid.GetColumnToIndex("GL_NUM");           //전표번호
                int vIndexDataColumn05 = pGrid.GetColumnToIndex("DR_AMOUNT");        //차변금액
                int vIndexDataColumn06 = pGrid.GetColumnToIndex("CR_AMOUNT");        //대변금액
                int vIndexDataColumn07 = pGrid.GetColumnToIndex("REMAIN_AMOUNT");    //잔액금액

                System.Drawing.Point vGridPoint01 = new System.Drawing.Point(pIndexRow, vIndexDataColumn01);  //회계일자
                System.Drawing.Point vGridPoint02 = new System.Drawing.Point(pIndexRow, vIndexDataColumn02);  //관리항목
                System.Drawing.Point vGridPoint03 = new System.Drawing.Point(pIndexRow, vIndexDataColumn03);  //적요
                System.Drawing.Point vGridPoint04 = new System.Drawing.Point(pIndexRow, vIndexDataColumn04);  //전표번호
                System.Drawing.Point vGridPoint05 = new System.Drawing.Point(pIndexRow, vIndexDataColumn05);  //차변금액
                System.Drawing.Point vGridPoint06 = new System.Drawing.Point(pIndexRow, vIndexDataColumn06);  //대변금액
                System.Drawing.Point vGridPoint07 = new System.Drawing.Point(pIndexRow, vIndexDataColumn07);  //잔액금액

                System.Drawing.Point vXLPoint01 = new System.Drawing.Point(pXLine, 2);         //회계일자
                System.Drawing.Point vXLPoint02 = new System.Drawing.Point(pXLine, 8);         //관리항목
                System.Drawing.Point vXLPoint03 = new System.Drawing.Point((pXLine + 1), 8);   //적요
                System.Drawing.Point vXLPoint04 = new System.Drawing.Point(pXLine, 31);        //전표번호
                System.Drawing.Point vXLPoint05 = new System.Drawing.Point(pXLine, 40);        //차변금액
                System.Drawing.Point vXLPoint06 = new System.Drawing.Point(pXLine, 49);        //대변금액
                System.Drawing.Point vXLPoint07 = new System.Drawing.Point(pXLine, 58);        //잔액금액

                //회계일자
                vObject = pGrid.GetCellValue(vGridPoint01.X, vGridPoint01.Y);
                if (vObject != null && vNullValue == false)
                {
                    vObject = ConvertDate(vObject);
                    mPrinting.XLSetCell(vXLPoint01.X, vXLPoint01.Y, vObject);
                }
                else
                {
                    vObject = null;
                    mPrinting.XLSetCell(vXLPoint01.X, vXLPoint01.Y, vObject);
                }

                //관리항목
                vObject = pGrid.GetCellValue(vGridPoint02.X, vGridPoint02.Y);
                if (vObject != null && vNullValue == false)
                {
                    mPrinting.XLSetCell(vXLPoint02.X, vXLPoint02.Y, vObject);
                    vMenagement = ConvertString(vObject);
                }
                else
                {
                    vObject = null;
                    mPrinting.XLSetCell(vXLPoint02.X, vXLPoint02.Y, vObject);
                }

                //적요
                vObject = pGrid.GetCellValue(vGridPoint03.X, vGridPoint03.Y);
                if (vObject != null && vNullValue == false)
                {
                    mPrinting.XLSetCell(vXLPoint03.X, vXLPoint03.Y, vObject);
                }
                else
                {
                    vObject = null;
                    mPrinting.XLSetCell(vXLPoint03.X, vXLPoint03.Y, vObject);
                }

                //전표번호
                vObject = pGrid.GetCellValue(vGridPoint04.X, vGridPoint04.Y);
                if (vObject != null && vNullValue == false)
                {
                    mPrinting.XLSetCell(vXLPoint04.X, vXLPoint04.Y, vObject);
                }
                else
                {
                    vObject = null;
                    mPrinting.XLSetCell(vXLPoint04.X, vXLPoint04.Y, vObject);
                }

                //차변금액
                vObject = pGrid.GetCellValue(vGridPoint05.X, vGridPoint05.Y);
                if (vObject != null && vNullValue == false)
                {
                    decimal vDebit_Amount = ConvertDecimal(vObject);
                    string sDebit_Amount = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vDebit_Amount);
                    mPrinting.XLSetCell(vXLPoint05.X, vXLPoint05.Y, sDebit_Amount);
                    if (vMenagement != mStringCarryOver)
                    {
                        mSum_Debit_Amount = mSum_Debit_Amount + vDebit_Amount;
                    }
                    mTotal_Debit_Amount = mTotal_Debit_Amount + vDebit_Amount;
                }
                else
                {
                    vObject = null;
                    mPrinting.XLSetCell(vXLPoint05.X, vXLPoint05.Y, vObject);
                }

                //대변금액
                vObject = pGrid.GetCellValue(vGridPoint06.X, vGridPoint06.Y);
                if (vObject != null && vNullValue == false)
                {
                    decimal vCredit_Amount = ConvertDecimal(vObject);
                    string sCredit_Amount = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vCredit_Amount);
                    mPrinting.XLSetCell(vXLPoint06.X, vXLPoint06.Y, sCredit_Amount);
                    if (vMenagement != mStringCarryOver)
                    {
                        mSum_Credit_Amount = mSum_Credit_Amount + vCredit_Amount;
                    }
                    mTotal_Credit_Amount = mTotal_Credit_Amount + vCredit_Amount;
                }
                else
                {
                    vObject = null;
                    mPrinting.XLSetCell(vXLPoint06.X, vXLPoint06.Y, vObject);
                }

                //잔액금액
                vObject = pGrid.GetCellValue(vGridPoint07.X, vGridPoint07.Y);
                if (vObject != null && vNullValue == false)
                {
                    decimal vRemain_Amount = ConvertDecimal(vObject);
                    string sRemain_Amount = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vRemain_Amount);
                    mPrinting.XLSetCell(vXLPoint07.X, vXLPoint07.Y, sRemain_Amount);
                    if (vMenagement != mStringCarryOver)
                    {
                        mSum_Remain_Amount = mSum_Remain_Amount + vRemain_Amount;
                    }
                    mTotal_Remain_Amount = mTotal_Remain_Amount + vRemain_Amount;
                }
                else
                {
                    vObject = null;
                    mPrinting.XLSetCell(vXLPoint07.X, vXLPoint07.Y, vObject);
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

        #region ----- Sum Write Methods ----

        private void XLSumWirte(int pXLine)
        {
            try
            {
                int vXLColumn01 = 40;    //차변금액
                int vXLColumn02 = 49;    //대변금액
                int vXLColumn03 = 58;    //잔액금액

                //월계
                mPrinting.XLSetCell(pXLine, 8, "월계");

                //차변금액
                string vSum_Debit_Amount = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", mSum_Debit_Amount);
                mPrinting.XLSetCell(pXLine, vXLColumn01, vSum_Debit_Amount);

                //대변금액
                string vSum_Credit_Amount = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", mSum_Credit_Amount);
                mPrinting.XLSetCell(pXLine, vXLColumn02, vSum_Credit_Amount);

                //잔액금액
                string vSum_Remain_Amount = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", mSum_Remain_Amount);
                mPrinting.XLSetCell(pXLine, vXLColumn03, vSum_Remain_Amount);

                pXLine = pXLine + 2;

                //누계
                mPrinting.XLSetCell(pXLine, 8, "누계");

                //차변금액
                string vTotal_Debit_Amount = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", mTotal_Debit_Amount);
                mPrinting.XLSetCell(pXLine, vXLColumn01, vTotal_Debit_Amount);

                //대변금액
                string vTotal_Credit_Amount = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", mTotal_Credit_Amount);
                mPrinting.XLSetCell(pXLine, vXLColumn02, vTotal_Credit_Amount);

                //잔액금액
                string vTotal_Remain_Amount = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", mTotal_Remain_Amount);
                mPrinting.XLSetCell(pXLine, vXLColumn03, vTotal_Remain_Amount);

                mSum_Debit_Amount = 0;
                mSum_Credit_Amount = 0;
                mSum_Remain_Amount = 0;

                mTotal_Debit_Amount = 0;
                mTotal_Credit_Amount = 0;
                mTotal_Remain_Amount = 0;

                mDeleteLine_LastMemory = pXLine;
            }
            catch (System.Exception ex)
            {
                mMessageError = string.Format("{0}", ex.Message);
                mIsAppInterFace.OnAppMessage(mMessageError);
                System.Windows.Forms.Application.DoEvents();
            }
        }

        #endregion;

        #region ----- Page Skip iF Methods ----

        private bool PageSkip(InfoSummit.Win.ControlAdv.ISGridAdvEx pGrid, int pIndexRow)
        {
            bool vIsSkip = false;

            object vObject1 = null;
            object vObject2 = null;
            object vObject3 = null;

            string vAccountDate = string.Empty;
            string vAccountCode = string.Empty;
            string vMenagement = string.Empty;

            int vIndexDataColumn01 = pGrid.GetColumnToIndex("ACCOUNT_CODE");     //계정코드
            int vIndexDataColumn02 = pGrid.GetColumnToIndex("GL_DATE");          //회계일자
            int vIndexDataColumn03 = pGrid.GetColumnToIndex("MANAGEMENT_DESC");  //관리항목

            System.Drawing.Point vGridPoint01 = new System.Drawing.Point(pIndexRow, vIndexDataColumn01);  //계정코드
            System.Drawing.Point vGridPoint02 = new System.Drawing.Point(pIndexRow, vIndexDataColumn02);  //회계일자
            System.Drawing.Point vGridPoint03 = new System.Drawing.Point(pIndexRow, vIndexDataColumn03);  //관리항목

            vObject1 = pGrid.GetCellValue(vGridPoint01.X, vGridPoint01.Y);  //계정코드
            vObject2 = pGrid.GetCellValue(vGridPoint02.X, vGridPoint02.Y);  //회계일자
            vObject3 = pGrid.GetCellValue(vGridPoint03.X, vGridPoint03.Y);  //관리항목

            //계정코드
            vAccountCode = ConvertString(vObject1);

            //회계일자
            vObject2 = ConvertDate(vObject2);
            vAccountDate = ConvertString(vObject2);
            vAccountDate = vAccountDate.Substring(0, 7);

            //관리항목
            vMenagement = ConvertString(vObject3);

            if (mAccountCode == vAccountCode &&  mCarryOver == mStringCarryOver)
            {
                mAccountDate = vAccountDate;
                mCarryOver = vMenagement;
                return false;
            }

            bool isNull1 = string.IsNullOrEmpty(vAccountDate);
            bool isNull2 = string.IsNullOrEmpty(vAccountCode);
            if (isNull1 != true && isNull2 != true)
            {
                if (mAccountCode != vAccountCode)
                {
                    mAccountCode = vAccountCode;
                    vIsSkip = true;
                }
                else if (mAccountDate != vAccountDate)
                {
                    mAccountDate = vAccountDate;
                    vIsSkip = true;
                }
            }

            mCarryOver = vMenagement;

            return vIsSkip;
        }

        #endregion;

        #region ----- New Page iF Methods ----

        private int NewPage(InfoSummit.Win.ControlAdv.ISGridAdvEx pGrid, int pSumWriteLine, string pPeriod, string pFooterLeft)
        {
            int vXLine = mPositionPrintLineSTART;
            int vPrintingRowSTART = 0;
            int vPrintingRowEND = 0;
            int vXLineLast = 0;

            bool vIsSkip = false;
            bool vIsLast = false;

            try
            {
                vPrintingRowSTART = pSumWriteLine;
                pSumWriteLine = pSumWriteLine + (mMaxIncrementRead / 2);
                vPrintingRowEND = pSumWriteLine;

                //[Header]
                XLHeader(pGrid, vPrintingRowSTART, pPeriod);

                //[Footer]
                XLFooter(pFooterLeft);

                for (int vRow = vPrintingRowSTART; vRow < vPrintingRowEND; vRow++)
                {
                    if (vRow < mTotalRowGrid)
                    {
                        vIsSkip = PageSkip(pGrid, vRow);
                        if (vIsSkip == true)
                        {
                            pSumWriteLine = vRow;

                            

                            //int vXLineDelete = vXLine;
                            //for (int vRow2 = pSumWriteLine; vRow2 < vPrintingRowEND; vRow2++)
                            //{
                            //    XLContentWrite(pGrid, vRow2, vXLineDelete, true);
                            //    vXLineDelete = vXLineDelete + 2;
                            //}



                            //mDeleteLine_LastMemory = vXLine;

                            XLSumWirte(vXLine); //합계, 누계

                            break;
                        }

                        XLContentWrite(pGrid, vRow, vXLine, false);
                    }
                    else
                    {
                        //마지막 페이지의 마지막 행 위치 기억
                        if (vIsLast == false)
                        {
                            vXLineLast = vXLine;
                            vIsLast = true;
                        }

                        XLContentWrite(pGrid, vRow, vXLine, true); //마지막 페이지에 출력할 행이 없으면, 빈 값으로 출력되게 true 값 넘김
                    }

                    vXLine = vXLine + 2;

                    if (vIsLast != true)
                    {
                        //-----------------------------------------------------------------
                        pGrid.CurrentCellMoveTo(vRow, 0);
                        pGrid.Focus();
                        pGrid.CurrentCellActivate(vRow, 0);

                        mMessageError = string.Format("{0:D4}/{1:D4}", vRow, mTotalRowGrid);
                        mIsAppInterFace.OnAppMessage(mMessageError);
                        System.Windows.Forms.Application.DoEvents();
                        //-----------------------------------------------------------------
                    }
                }

                //마지막 페이지에 합계, 누계 Write
                if (vIsLast == true)
                {
                    XLSumWirte(vXLineLast); //합계, 누계
                }
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
        public int XLWirte(InfoSummit.Win.ControlAdv.ISGridAdvEx pGrid, int pTerritory, string pPeriod, string pUserName, string pCaption)
        {
            string vMessageText = string.Empty;

            string vPrintingDate = System.DateTime.Now.ToString("yyyy-MM-dd", null);
            string vPrintingTime = System.DateTime.Now.ToString("HH:mm:ss", null);

            int vPageNumber = 0;

            try
            {
                mTotalRowGrid = pGrid.RowCount; //Grid의 총 행수

                //초기치 값 설정
                //첫 페이지 Skip에 비교될 값 지정
                if (mTotalRowGrid > 0)
                {
                    int vRowIndex = 0;

                    object vObject1 = null;
                    object vObject2 = null;
                    object vObject3 = null;

                    int vIndexDataColumn01 = pGrid.GetColumnToIndex("ACCOUNT_CODE");       //계정코드
                    int vIndexDataColumn02 = pGrid.GetColumnToIndex("GL_DATE");            //회계일자
                    int vIndexDataColumn03 = pGrid.GetColumnToIndex("MANAGEMENT_DESC");    //관리항목

                    vObject1 = pGrid.GetCellValue(vRowIndex, vIndexDataColumn01);          //계정코드
                    vObject2 = pGrid.GetCellValue(vRowIndex, vIndexDataColumn02);          //회계일자
                    vObject3 = pGrid.GetCellValue(vRowIndex, vIndexDataColumn03);          //관리항목

                    mAccountCode = ConvertString(vObject1);                //계정코드

                    mAccountDate = ConvertString(ConvertDate(vObject2));   //회계일자
                    mAccountDate = mAccountDate.Substring(0, 7);

                    mCarryOver = ConvertString(vObject3);                  //관리항목
                    
                }

                while (mTotalRowGrid > mSumWriteLine)
                {
                    vPageNumber++;

                    string vFooterLeft = string.Format("{0} {1}", vPrintingDate, vPrintingTime);
                    //[Content_Printing]
                    mSumWriteLine = NewPage(pGrid, mSumWriteLine, pPeriod, vFooterLeft);


                    ////[Sheet2]내용을 [Sheet1]에 붙여넣기
                    mSumPrintingLineCopy = CopyAndPaste(mSumPrintingLineCopy);


                    //다음 페이지 출력을 위해, 현재 출력된 값 지우기
                    DeleteLineXL(pGrid, mDeleteLine_LastMemory);
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