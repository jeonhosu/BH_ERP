using System;

namespace HRMF0537
{
    public class XLPrinting
    {
        #region ----- Variables -----

        private InfoSummit.Win.ControlAdv.ISAppInterface mAppInterface = null;
        private InfoSummit.Win.ControlAdv.ISMessageAdapter mMessageAdapter = null;

        private XL.XLPrint mPrinting = null;

        private string mMessageError = string.Empty;

        private int mPageTotalNumber = 0;
        private int mPageNumber = 0;

        private bool mIsNewPage = false;

        private string mXLOpenFileName = string.Empty;

        private int mPrintingLineSTART = 12;  //Line

        private int mCopyLineSUM = 1;        //엑셀의 선택된 쉬트의 복사되어질 시작 행 위치, 복사 행 누적
        private int mIncrementCopyMAX = 45;  //복사되어질 행의 범위

        private int mCopyColumnSTART = 1; //복사되어  진 행 누적 수
        private int mCopyColumnEND = 63;  //엑셀의 선택된 쉬트의 복사되어질 끝 열 위치

        //Header Write Infomation
        private string mCorporationName = string.Empty;
        private string mUserName = string.Empty;
        private string mYYYYMM = string.Empty;
        private string mWageTypeName = string.Empty;
        private string mDepartmentName = string.Empty;
        private string mPringingDateTime = string.Empty;

        private string mMessageValue1 = string.Empty;  //부서합계
        private string mMessageValue2 = string.Empty; //총합계

        private int[] mXLColumnHeader = null;

        //Copy할때 병합해야할 셀의 행 위치 기억
        private int[] mRowMerge = new int[8] { -1, -1, -1, -1, -1, -1, -1, -1 };
        private int mCountRow = 0; //병합해야할 셀의 행 위치 Count
        private int mMegerColumnStart = 0; //병합해야할 셀의 시작 열 값
        private int mMegerColumnEnd = 0;   //병합해야할 셀의 종료 열 값

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

        #region ----- Initialize ----

        #region ----- Array Set 1 ----

        private void SetArray1()
        {
            mXLColumnHeader = new int[8];

            mXLColumnHeader[01] = 2;  //Title
            mXLColumnHeader[02] = 6;  //출력자
            mXLColumnHeader[03] = 6;  //급여구분
            mXLColumnHeader[04] = 19; //부서
            mXLColumnHeader[05] = 56; //페이지
            mXLColumnHeader[06] = 56; //출력일자
            mXLColumnHeader[07] = 41; //업체
        }

        #endregion;

        #region ----- Array Set 2 ----

        private void SetArray2(InfoSummit.Win.ControlAdv.ISGridAdvEx pGrid, out int[] pGridColumn, out int[] pXLColumn)
        {
            pGridColumn = new int[69];
            pXLColumn = new int[69];

            //공통코드 : 지급항목[ALLOWANCE]
            //공통코드 : 기타 지급항목[ALLOWANCE_ETC]

            pGridColumn[01] = pGrid.GetColumnToIndex("DEPT_NAME");                    //부서
            pGridColumn[02] = pGrid.GetColumnToIndex("PERSON_NUM");                   //사원번호
            pGridColumn[03] = pGrid.GetColumnToIndex(""); //기본급
            pGridColumn[04] = pGrid.GetColumnToIndex("TOTAL_ATT_DAY"); //정산근무
            pGridColumn[05] = pGrid.GetColumnToIndex("HOLY_1_TIME"); //휴일특근
            pGridColumn[06] = pGrid.GetColumnToIndex("DUTY_30"); //근무(공가)
            pGridColumn[07] = pGrid.GetColumnToIndex("TOT_DED_COUNT"); //미근무
            pGridColumn[08] = pGrid.GetColumnToIndex("A01");                          //기본급[지급항목]
            pGridColumn[09] = pGrid.GetColumnToIndex("A08");                          //가족수당
            pGridColumn[10] = pGrid.GetColumnToIndex("A02");                          //직책수당
            pGridColumn[11] = pGrid.GetColumnToIndex("A03");                          //근속수당
            pGridColumn[12] = pGrid.GetColumnToIndex("A18"); //연차수당
            pGridColumn[13] = pGrid.GetColumnToIndex("D01");                          //소득세
            pGridColumn[14] = pGrid.GetColumnToIndex("D02");                          //주민세
            pGridColumn[15] = pGrid.GetColumnToIndex("D03");                          //국민연금
            pGridColumn[16] = pGrid.GetColumnToIndex("D05");                          //건강보험
            pGridColumn[17] = pGrid.GetColumnToIndex("TOT_SUPPLY_AMOUNT");            //총지급액[총지급액]
            pGridColumn[18] = pGrid.GetColumnToIndex("POST_NAME");                    //직위
            pGridColumn[19] = pGrid.GetColumnToIndex("NAME");                         //성명
            pGridColumn[20] = pGrid.GetColumnToIndex(""); //일급
            pGridColumn[21] = pGrid.GetColumnToIndex("OVER_TIME"); //연장근로(연장시간)
            pGridColumn[22] = pGrid.GetColumnToIndex("HOLY_1_OT"); //휴일연장
            pGridColumn[23] = pGrid.GetColumnToIndex("S_HOLY_1_COUNT"); //주차
            pGridColumn[24] = pGrid.GetColumnToIndex("WEEKLY_DED_COUNT"); //미주차
            pGridColumn[25] = pGrid.GetColumnToIndex("A06");                          //자격수당
            pGridColumn[26] = pGrid.GetColumnToIndex("A11");                          //시간외수당
            pGridColumn[27] = pGrid.GetColumnToIndex("A12");                          //연장수당
            pGridColumn[28] = pGrid.GetColumnToIndex("A13");                          //야간수당
            pGridColumn[29] = pGrid.GetColumnToIndex("A14");                          //특근수당
            pGridColumn[30] = pGrid.GetColumnToIndex("D04");                          //고용보험
            pGridColumn[31] = pGrid.GetColumnToIndex("D18");                          //사우회
            pGridColumn[32] = pGrid.GetColumnToIndex(""); //식대
            pGridColumn[33] = pGrid.GetColumnToIndex(""); //가불금
            pGridColumn[34] = pGrid.GetColumnToIndex("TOT_DED_AMOUNT");               //총공제액[총공제액]
            pGridColumn[35] = pGrid.GetColumnToIndex(""); //정식입사일
            pGridColumn[36] = pGrid.GetColumnToIndex("WAGE_TYPE_NAME");               //급상여구분
            pGridColumn[37] = pGrid.GetColumnToIndex(""); //시급
            pGridColumn[38] = pGrid.GetColumnToIndex("NIGHT_BONUS_TIME"); //야간근로(야간시간)
            pGridColumn[39] = pGrid.GetColumnToIndex("HOLY_1_NIGHT"); //휴일야간
            pGridColumn[40] = pGrid.GetColumnToIndex("HOLY_1_COUNT"); //유휴
            pGridColumn[41] = pGrid.GetColumnToIndex("DUTY_30"); //공가
            pGridColumn[42] = pGrid.GetColumnToIndex("A33");                          //만근수당
            pGridColumn[43] = pGrid.GetColumnToIndex("A17");                          //지각외출조퇴
            pGridColumn[44] = pGrid.GetColumnToIndex("A22");                          //결근
            pGridColumn[45] = pGrid.GetColumnToIndex("A25");                          //차량유지비
            pGridColumn[46] = pGrid.GetColumnToIndex("A07");                          //기타수당
            pGridColumn[47] = pGrid.GetColumnToIndex(""); //경조사비
            pGridColumn[48] = pGrid.GetColumnToIndex(""); //카드대
            pGridColumn[49] = pGrid.GetColumnToIndex("D14");                          //기타
            pGridColumn[50] = pGrid.GetColumnToIndex(""); //동호회
            pGridColumn[51] = pGrid.GetColumnToIndex("REAL_AMOUNT");                  //실지급액[실지급액]
            pGridColumn[52] = pGrid.GetColumnToIndex("");                             //
            pGridColumn[53] = pGrid.GetColumnToIndex("");                             //
            pGridColumn[54] = pGrid.GetColumnToIndex("");                             //
            pGridColumn[55] = pGrid.GetColumnToIndex("");                             //
            pGridColumn[56] = pGrid.GetColumnToIndex("LATE_TIME");                    //근태공제
            pGridColumn[57] = pGrid.GetColumnToIndex("HOLY_0_COUNT");                 //무휴
            pGridColumn[58] = pGrid.GetColumnToIndex("");                             //통상시급
            pGridColumn[59] = pGrid.GetColumnToIndex("");                             //
            pGridColumn[60] = pGrid.GetColumnToIndex("A09");                          //상여금
            pGridColumn[61] = pGrid.GetColumnToIndex("A32");                          //야간장려수당
            pGridColumn[62] = pGrid.GetColumnToIndex("A10");                          //전월소급분
            pGridColumn[63] = pGrid.GetColumnToIndex("");                             //무급휴가
            pGridColumn[64] = pGrid.GetColumnToIndex("D16");                          //정산소득세
            pGridColumn[65] = pGrid.GetColumnToIndex("D17");                          //정산주민세
            pGridColumn[66] = pGrid.GetColumnToIndex("");                             //국민연금소급분
            pGridColumn[67] = pGrid.GetColumnToIndex("");                             //건강연말정산
            pGridColumn[68] = pGrid.GetColumnToIndex("");                             //비과세총액

            pXLColumn[01] = 2;  //부서
            pXLColumn[02] = 5;  //사원번호
            pXLColumn[03] = 8;  //기본급
            pXLColumn[04] = 11; //정산근무
            pXLColumn[05] = 14; //휴일특근
            pXLColumn[06] = 17; //근무(공가)
            pXLColumn[07] = 20; //미근무
            pXLColumn[08] = 23; //기본급[지급항목]
            pXLColumn[09] = 27; //가족수당
            pXLColumn[10] = 31; //직책수당
            pXLColumn[11] = 35; //근속수당
            pXLColumn[12] = 39; //연차수당
            pXLColumn[13] = 43; //소득세
            pXLColumn[14] = 47; //주민세
            pXLColumn[15] = 51; //국민연금
            pXLColumn[16] = 55; //건강보험
            pXLColumn[17] = 59; //총지급액[총지급액]
            pXLColumn[18] = 2;  //직위
            pXLColumn[19] = 5;  //성명
            pXLColumn[20] = 8;  //일급
            pXLColumn[21] = 11; //연장근로
            pXLColumn[22] = 14; //휴일연장
            pXLColumn[23] = 17; //주차
            pXLColumn[24] = 20; //미주차
            pXLColumn[25] = 23; //자격수당
            pXLColumn[26] = 27; //시간외수당
            pXLColumn[27] = 31; //년차수당
            pXLColumn[28] = 35; //야간수당
            pXLColumn[29] = 39; //특근수당
            pXLColumn[30] = 43; //고용보험
            pXLColumn[31] = 47; //사우회
            pXLColumn[32] = 51; //식대
            pXLColumn[33] = 55; //가불금
            pXLColumn[34] = 59; //총공제액[총공제액]
            pXLColumn[35] = 2;  //정식입사일
            pXLColumn[36] = 5;  //급상여구분
            pXLColumn[37] = 8;  //시급
            pXLColumn[38] = 11; //야간근로
            pXLColumn[39] = 14; //휴일야간
            pXLColumn[40] = 17; //유휴
            pXLColumn[41] = 20; //공가
            pXLColumn[42] = 23; //만근수당
            pXLColumn[43] = 27; //지각외출조퇴
            pXLColumn[44] = 31; //결근
            pXLColumn[45] = 35; //차량유지비
            pXLColumn[46] = 39; //기타수당
            pXLColumn[47] = 43; //경조사비
            pXLColumn[48] = 47; //카드대
            pXLColumn[49] = 51; //기타
            pXLColumn[50] = 55; //동호회
            pXLColumn[51] = 59; //실지급액[실지급액]
            pXLColumn[52] = 2;  //
            pXLColumn[53] = 5;  //
            pXLColumn[54] = 8;  //
            pXLColumn[55] = 11; //
            pXLColumn[56] = 14; //근태공제
            pXLColumn[57] = 17; //무휴
            pXLColumn[58] = 20; //통상시급
            pXLColumn[59] = 23; //
            pXLColumn[60] = 27; //상여금
            pXLColumn[61] = 31; //야간장려수당
            pXLColumn[62] = 35; //전월소급분
            pXLColumn[63] = 39; //무급휴가
            pXLColumn[64] = 43; //정산소득세
            pXLColumn[65] = 47; //정산주민세
            pXLColumn[66] = 51; //국민연금소급분
            pXLColumn[67] = 55; //건강연말정산
            pXLColumn[68] = 59; //비과세총액

            mMegerColumnStart = pXLColumn[1];
            mMegerColumnEnd = pXLColumn[3];
        }

        #endregion;

        #region ----- IsConvert Methods -----

        #region ----- String Convert Method -----

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

        #endregion;

        #region ----- Number Convert Method -----

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

        private bool IsConvertNumber(string pStringNumber, out decimal pConvertDecimal)
        {
            bool vIsConvert = false;
            pConvertDecimal = 0m;

            try
            {
                if (pStringNumber != null)
                {
                    decimal vIsConvertNum = decimal.Parse(pStringNumber);
                    pConvertDecimal = vIsConvertNum;
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

        #endregion;

        #region ----- Date Convert Method -----

        private bool IsConvertDate(object pObject, out string pConvertDateTimeShort)
        {
            bool vIsConvert = false;
            pConvertDateTimeShort = string.Empty;

            try
            {
                if (pObject != null)
                {
                    bool IsConvert = pObject is System.DateTime;
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

            return vIsConvert;
        }

        #endregion;

        #endregion;

        #region ----- Header Write Method ----

        private void XLHeader(int pXLine, string pUserName, string pPrintingDateTime, string pYYYYMM, string pWageTypeName, string pDepartment_NAME, string pPageString, string pCorporationName)
        {
            bool vIsNull = false;
            int vXLine = pXLine + 1;

            try
            {
                mPrinting.XLActiveSheet("Destination");

                //System.Drawing.Point vCellPoint01 = new System.Drawing.Point(2, 2);    //Title
                //System.Drawing.Point vCellPoint02 = new System.Drawing.Point(4, 6);    //출력자
                //System.Drawing.Point vCellPoint03 = new System.Drawing.Point(5, 6);    //급여구분
                //System.Drawing.Point vCellPoint04 = new System.Drawing.Point(5, 19);   //부서
                //System.Drawing.Point vCellPoint05 = new System.Drawing.Point(4, 56);   //페이지
                //System.Drawing.Point vCellPoint06 = new System.Drawing.Point(5, 56);   //출력일자
                //System.Drawing.Point vCellPoint07 = new System.Drawing.Point(44, 41);  //업체

                //Title
                vIsNull = string.IsNullOrEmpty(pYYYYMM);
                if (vIsNull != true)
                {
                    string vYear = pYYYYMM.Substring(0, 4);
                    string vMonth = pYYYYMM.Substring(5, 2);
                    string vTitle = string.Format("{0}년 {1}월 급여 대장", vYear, vMonth);
                    mPrinting.XLSetCell(vXLine, mXLColumnHeader[1], vTitle);
                }
                else
                {
                    mPrinting.XLSetCell(vXLine, mXLColumnHeader[1], null);
                }

                //-------------------------------------------------------------------
                vXLine = vXLine + 2;
                //-------------------------------------------------------------------

                //출력자
                vIsNull = string.IsNullOrEmpty(pUserName);
                if (vIsNull != true)
                {
                    mPrinting.XLSetCell(vXLine, mXLColumnHeader[2], pUserName);
                }
                else
                {
                    mPrinting.XLSetCell(vXLine, mXLColumnHeader[2], null);
                }

                //-------------------------------------------------------------------
                vXLine = vXLine + 1;
                //-------------------------------------------------------------------

                //급여구분
                vIsNull = string.IsNullOrEmpty(pWageTypeName);
                if (vIsNull != true)
                {
                    mPrinting.XLSetCell(vXLine, mXLColumnHeader[3], pWageTypeName);
                }
                else
                {
                    mPrinting.XLSetCell(vXLine, mXLColumnHeader[3], "전체");
                }

                //부서
                vIsNull = string.IsNullOrEmpty(pDepartment_NAME);
                if (vIsNull != true)
                {
                    mPrinting.XLSetCell(vXLine, mXLColumnHeader[4], pDepartment_NAME);
                }
                else
                {
                    mPrinting.XLSetCell(vXLine, mXLColumnHeader[4], "전체");
                }

                //-------------------------------------------------------------------
                vXLine = vXLine - 1;
                //-------------------------------------------------------------------

                //페이지
                vIsNull = string.IsNullOrEmpty(pPageString);
                if (vIsNull != true)
                {
                    mPrinting.XLSetCell(vXLine, mXLColumnHeader[5], pPageString);
                }
                else
                {
                    mPrinting.XLSetCell(vXLine, mXLColumnHeader[5], null);
                }

                //-------------------------------------------------------------------
                vXLine = vXLine + 1;
                //-------------------------------------------------------------------

                //출력일자
                vIsNull = string.IsNullOrEmpty(pPrintingDateTime);
                if (vIsNull != true)
                {
                    mPrinting.XLSetCell(vXLine, mXLColumnHeader[6], pPrintingDateTime);
                }
                else
                {
                    mPrinting.XLSetCell(vXLine, mXLColumnHeader[6], null);
                }

                //-------------------------------------------------------------------
                vXLine = vXLine + 39;
                //-------------------------------------------------------------------

                //업체
                vIsNull = string.IsNullOrEmpty(pCorporationName);
                if (vIsNull != true)
                {
                    mPrinting.XLSetCell(vXLine, mXLColumnHeader[7], pCorporationName);
                }
                else
                {
                    mPrinting.XLSetCell(vXLine, mXLColumnHeader[7], null);
                }
            }
            catch (System.Exception ex)
            {
                mMessageError = ex.Message;
                mAppInterface.OnAppMessageEvent(mMessageError);
                System.Windows.Forms.Application.DoEvents();
            }
        }

        #endregion;

        #region ----- Line Write Method -----

        private int XLLine(InfoSummit.Win.ControlAdv.ISGridAdvEx pGrid, int pGridRow, int pXLine, int[] pGridColumn, int[] pXLColumn)
        {
            bool vIsValueViewTemp = true; //false
            int vXLine = pXLine; //엑셀에 내용이 표시되는 행 번호

            object vGetValue = null;
            int vGridIndexColumn = 0;
            int vXLIndexColumn = 0;

            string vConvertString = string.Empty;
            decimal vConvertDecimal = 0m;
            bool IsConvert = false;
            bool IsMerge = false;

            try
            {
                mPrinting.XLActiveSheet("Destination");

                #region ----- [01] ~ [17] ----

                //[01]
                vXLIndexColumn = pXLColumn[1];
                vGridIndexColumn = pGridColumn[1];
                ////vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertString(vGetValue, out vConvertString);
                    if (IsConvert == true)
                    {
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[01]";
                        }
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[01]";
                    }
                    mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                }

                //[02]
                vXLIndexColumn = pXLColumn[2];
                vGridIndexColumn = pGridColumn[2];
                ////vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertString(vGetValue, out vConvertString);
                    if (IsConvert == true)
                    {
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[02]";
                        }
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[02]";
                    }
                    mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                }

                //[03]
                vXLIndexColumn = pXLColumn[3];
                vGridIndexColumn = pGridColumn[3];
                ////vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertString(vGetValue, out vConvertString);
                    if (IsConvert == true)
                    {
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[03]";
                        }
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[03]";
                    }
                    mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                }

                //[04]
                vXLIndexColumn = pXLColumn[4];
                vGridIndexColumn = pGridColumn[4];
                ////vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertString(vGetValue, out vConvertString);
                    if (IsConvert == true)
                    {
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[04]";
                        }
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[04]";
                    }
                    mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                }

                //[05]
                vXLIndexColumn = pXLColumn[5];
                vGridIndexColumn = pGridColumn[5];
                ////vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertString(vGetValue, out vConvertString);
                    if (IsConvert == true)
                    {
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[05]";
                        }
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[05]";
                    }
                    mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                }

                //[06]
                vXLIndexColumn = pXLColumn[6];
                vGridIndexColumn = pGridColumn[6];
                ////vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertString(vGetValue, out vConvertString);
                    if (IsConvert == true)
                    {
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[06]";
                        }
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[06]";
                    }
                    mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                }

                //[07]
                vXLIndexColumn = pXLColumn[7];
                vGridIndexColumn = pGridColumn[7];
                ////vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertString(vGetValue, out vConvertString);
                    if (IsConvert == true)
                    {
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[07]";
                        }
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[07]";
                    }
                    mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                }

                //[08]
                vXLIndexColumn = pXLColumn[8];
                vGridIndexColumn = pGridColumn[8];
                ////vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertNumber(vGetValue, out vConvertDecimal);
                    if (IsConvert == true)
                    {
                        vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);

                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[08]";
                        }
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[08]";
                    }
                    mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                }

                //[09]
                vXLIndexColumn = pXLColumn[9];
                vGridIndexColumn = pGridColumn[9];
                ////vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertNumber(vGetValue, out vConvertDecimal);
                    if (IsConvert == true)
                    {
                        vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);

                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[09]";
                        }
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[09]";
                    }
                    mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                }

                //[10]
                vXLIndexColumn = pXLColumn[10];
                vGridIndexColumn = pGridColumn[10];
                ////vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertNumber(vGetValue, out vConvertDecimal);
                    if (IsConvert == true)
                    {
                        vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);

                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[10]";
                        }
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[10]";
                    }
                    mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                }

                //[11]
                vXLIndexColumn = pXLColumn[11];
                vGridIndexColumn = pGridColumn[11];
                ////vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertNumber(vGetValue, out vConvertDecimal);
                    if (IsConvert == true)
                    {
                        vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);

                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[11]";
                        }
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[11]";
                    }
                    mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                }

                //[12]
                vXLIndexColumn = pXLColumn[12];
                vGridIndexColumn = pGridColumn[12];
                ////vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertNumber(vGetValue, out vConvertDecimal);
                    if (IsConvert == true)
                    {
                        vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);

                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[12]";
                        }
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[12]";
                    }
                    mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                }

                //[13]
                vXLIndexColumn = pXLColumn[13];
                vGridIndexColumn = pGridColumn[13];
                ////vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertNumber(vGetValue, out vConvertDecimal);
                    if (IsConvert == true)
                    {
                        vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);

                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[13]";
                        }
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[13]";
                    }
                    mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                }

                //[14]
                vXLIndexColumn = pXLColumn[14];
                vGridIndexColumn = pGridColumn[14];
                ////vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertNumber(vGetValue, out vConvertDecimal);
                    if (IsConvert == true)
                    {
                        vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);

                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[14]";
                        }
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[14]";
                    }
                    mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                }

                //[15]
                vXLIndexColumn = pXLColumn[15];
                vGridIndexColumn = pGridColumn[15];
                ////vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertNumber(vGetValue, out vConvertDecimal);
                    if (IsConvert == true)
                    {
                        vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);

                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[15]";
                        }
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[15]";
                    }
                    mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                }

                //[16]
                vXLIndexColumn = pXLColumn[16];
                vGridIndexColumn = pGridColumn[16];
                ////vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertNumber(vGetValue, out vConvertDecimal);
                    if (IsConvert == true)
                    {
                        vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);

                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[16]";
                        }
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[16]";
                    }
                    mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                }

                //[17]
                vXLIndexColumn = pXLColumn[17];
                vGridIndexColumn = pGridColumn[17];
                ////vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertNumber(vGetValue, out vConvertDecimal);
                    if (IsConvert == true)
                    {
                        vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);

                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[17]";
                        }
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[17]";
                    }
                    mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                }

                #endregion;

                #region ----- [18] ~ [34] ----

                vXLine++;
                //--------------------------------------------------------------------------------------------------

                //[18]
                vXLIndexColumn = pXLColumn[18];
                vGridIndexColumn = pGridColumn[18];
                ////vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertString(vGetValue, out vConvertString);
                    if (IsConvert == true)
                    {
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[18]";
                        }
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[18]";
                    }
                    mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                }

                //[19]
                vXLIndexColumn = pXLColumn[19];
                vGridIndexColumn = pGridColumn[19];
                ////vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertString(vGetValue, out vConvertString);
                    if (IsConvert == true)
                    {
                        if (mMessageValue1 == vConvertString || mMessageValue2 == vConvertString)
                        {
                            mRowMerge[mCountRow] = 1;

                            IsMerge = true;

                            int vStartRow = vXLine - 1;
                            int vStartCol = pXLColumn[1];

                            //XL Cell 내용 지우기 --------------------------------
                            vGetValue = null;
                            mPrinting.XLSetCell((vXLine - 1), pXLColumn[1], vGetValue);
                            mPrinting.XLSetCell((vXLine - 1), pXLColumn[2], vGetValue);
                            mPrinting.XLSetCell(vXLine, pXLColumn[18], vGetValue);
                            mPrinting.XLSetCell(vXLine, pXLColumn[19], vGetValue);
                            mPrinting.XLSetCell((vXLine + 1), pXLColumn[35], vGetValue);
                            mPrinting.XLSetCell((vXLine + 1), pXLColumn[36], vGetValue);
                            mPrinting.XLSetCell((vXLine + 2), pXLColumn[52], vGetValue);
                            mPrinting.XLSetCell((vXLine + 2), pXLColumn[53], vGetValue);
                            //----------------------------------------------------

                            mPrinting.XLSetCell(vStartRow, vStartCol, vConvertString);
                        }
                        else
                        {
                            mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                        }
                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[19]";
                        }

                        if (IsMerge == false)
                        {
                            mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                        }
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[19]";
                    }

                    if (IsMerge == false)
                    {
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }

                //[20]
                vXLIndexColumn = pXLColumn[20];
                vGridIndexColumn = pGridColumn[20];
                ////vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertString(vGetValue, out vConvertString);
                    if (IsConvert == true)
                    {
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[20]";
                        }
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[20]";
                    }
                    mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                }

                //[21]
                vXLIndexColumn = pXLColumn[21];
                vGridIndexColumn = pGridColumn[21];
                ////vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertString(vGetValue, out vConvertString);
                    if (IsConvert == true)
                    {
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[21]";
                        }
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[21]";
                    }
                    mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                }

                //[22]
                vXLIndexColumn = pXLColumn[22];
                vGridIndexColumn = pGridColumn[22];
                //vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertString(vGetValue, out vConvertString);
                    if (IsConvert == true)
                    {
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[22]";
                        }
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[22]";
                    }
                    mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                }

                //[23]
                vXLIndexColumn = pXLColumn[23];
                vGridIndexColumn = pGridColumn[23];
                //vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertString(vGetValue, out vConvertString);
                    if (IsConvert == true)
                    {
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[23]";
                        }
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[23]";
                    }
                    mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                }

                //[24]
                vXLIndexColumn = pXLColumn[24];
                vGridIndexColumn = pGridColumn[24];
                //vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertString(vGetValue, out vConvertString);
                    if (IsConvert == true)
                    {
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[24]";
                        }
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[24]";
                    }
                    mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                }

                //[25]
                vXLIndexColumn = pXLColumn[25];
                vGridIndexColumn = pGridColumn[25];
                //vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertNumber(vGetValue, out vConvertDecimal);
                    if (IsConvert == true)
                    {
                        vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[25]";
                        }
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[25]";
                    }
                    mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                }

                //[26]
                vXLIndexColumn = pXLColumn[26];
                vGridIndexColumn = pGridColumn[26];
                //vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertNumber(vGetValue, out vConvertDecimal);
                    if (IsConvert == true)
                    {
                        vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[26]";
                        }
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[26]";
                    }
                    mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                }

                //[27]
                vXLIndexColumn = pXLColumn[27];
                vGridIndexColumn = pGridColumn[27];
                //vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertNumber(vGetValue, out vConvertDecimal);
                    if (IsConvert == true)
                    {
                        vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[27]";
                        }
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[27]";
                    }
                    mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                }

                //[28]
                vXLIndexColumn = pXLColumn[28];
                vGridIndexColumn = pGridColumn[28];
                //vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertNumber(vGetValue, out vConvertDecimal);
                    if (IsConvert == true)
                    {
                        vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[28]";
                        }
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[28]";
                    }
                    mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                }

                //[29]
                vXLIndexColumn = pXLColumn[29];
                vGridIndexColumn = pGridColumn[29];
                //vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertNumber(vGetValue, out vConvertDecimal);
                    if (IsConvert == true)
                    {
                        vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[29]";
                        }
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[29]";
                    }
                    mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                }

                //[30]
                vXLIndexColumn = pXLColumn[30];
                vGridIndexColumn = pGridColumn[30];
                //vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertNumber(vGetValue, out vConvertDecimal);
                    if (IsConvert == true)
                    {
                        vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[30]";
                        }
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[30]";
                    }
                    mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                }

                //[31]
                vXLIndexColumn = pXLColumn[31];
                vGridIndexColumn = pGridColumn[31];
                //vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertNumber(vGetValue, out vConvertDecimal);
                    if (IsConvert == true)
                    {
                        vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[31]";
                        }
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[31]";
                    }
                    mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                }

                //[32]
                vXLIndexColumn = pXLColumn[32];
                vGridIndexColumn = pGridColumn[32];
                //vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertNumber(vGetValue, out vConvertDecimal);
                    if (IsConvert == true)
                    {
                        vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[32]";
                        }
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[32]";
                    }
                    mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                }

                //[33]
                vXLIndexColumn = pXLColumn[33];
                vGridIndexColumn = pGridColumn[33];
                //vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertNumber(vGetValue, out vConvertDecimal);
                    if (IsConvert == true)
                    {
                        vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[33]";
                        }
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[33]";
                    }
                    mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                }

                //[34]
                vXLIndexColumn = pXLColumn[34];
                vGridIndexColumn = pGridColumn[34];
                //vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertNumber(vGetValue, out vConvertDecimal);
                    if (IsConvert == true)
                    {
                        vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[34]";
                        }
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[34]";
                    }
                    mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                }

                #endregion;

                #region ----- [35] ~ [51] ----

                vXLine++;
                //--------------------------------------------------------------------------------------------------

                //[35]
                vXLIndexColumn = pXLColumn[35];
                vGridIndexColumn = pGridColumn[35];
                //vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertDate(vGetValue, out vConvertString);
                    if (IsConvert == true)
                    {
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[35]";
                        }

                        if (IsMerge == false)
                        {
                            mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                        }
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[35]";
                    }

                    if (IsMerge == false)
                    {
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }

                //[36]
                vXLIndexColumn = pXLColumn[36];
                vGridIndexColumn = pGridColumn[36];
                //vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertString(vGetValue, out vConvertString);
                    if (IsConvert == true)
                    {
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[36]";
                        }

                        if (IsMerge == false)
                        {
                            mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                        }
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[36]";
                    }

                    if (IsMerge == false)
                    {
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }

                //[37]
                vXLIndexColumn = pXLColumn[37];
                vGridIndexColumn = pGridColumn[37];
                //vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertString(vGetValue, out vConvertString);
                    if (IsConvert == true)
                    {
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[37]";
                        }
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[37]";
                    }
                    mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                }

                //[38]
                vXLIndexColumn = pXLColumn[38];
                vGridIndexColumn = pGridColumn[38];
                //vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertString(vGetValue, out vConvertString);
                    if (IsConvert == true)
                    {
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[38]";
                        }
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[38]";
                    }
                    mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                }

                //[39]
                vXLIndexColumn = pXLColumn[39];
                vGridIndexColumn = pGridColumn[39];
                //vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertString(vGetValue, out vConvertString);
                    if (IsConvert == true)
                    {
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[39]";
                        }
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[39]";
                    }
                    mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                }

                //[40]
                vXLIndexColumn = pXLColumn[40];
                vGridIndexColumn = pGridColumn[40];
                //vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertString(vGetValue, out vConvertString);
                    if (IsConvert == true)
                    {
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[40]";
                        }
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[40]";
                    }
                    mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                }

                //[41]
                vXLIndexColumn = pXLColumn[41];
                vGridIndexColumn = pGridColumn[41];
                //vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertString(vGetValue, out vConvertString);
                    if (IsConvert == true)
                    {
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[41]";
                        }
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[41]";
                    }
                    mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                }

                //[42]
                vXLIndexColumn = pXLColumn[42];
                vGridIndexColumn = pGridColumn[42];
                //vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertNumber(vGetValue, out vConvertDecimal);
                    if (IsConvert == true)
                    {
                        vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[42]";
                        }
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[42]";
                    }
                    mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                }

                //[43]
                vXLIndexColumn = pXLColumn[43];
                vGridIndexColumn = pGridColumn[43];
                //vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertNumber(vGetValue, out vConvertDecimal);
                    if (IsConvert == true)
                    {
                        vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[43]";
                        }
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[43]";
                    }
                    mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                }

                //[44]
                vXLIndexColumn = pXLColumn[44];
                vGridIndexColumn = pGridColumn[44];
                //vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertNumber(vGetValue, out vConvertDecimal);
                    if (IsConvert == true)
                    {
                        vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[44]";
                        }
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[44]";
                    }
                    mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                }

                //[45]
                vXLIndexColumn = pXLColumn[45];
                vGridIndexColumn = pGridColumn[45];
                //vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertNumber(vGetValue, out vConvertDecimal);
                    if (IsConvert == true)
                    {
                        vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[45]";
                        }
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[45]";
                    }
                    mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                }

                //[46]
                vXLIndexColumn = pXLColumn[46];
                vGridIndexColumn = pGridColumn[46];
                //vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertNumber(vGetValue, out vConvertDecimal);
                    if (IsConvert == true)
                    {
                        vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[46]";
                        }
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[46]";
                    }
                    mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                }

                //[47]
                vXLIndexColumn = pXLColumn[47];
                vGridIndexColumn = pGridColumn[47];
                //vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertNumber(vGetValue, out vConvertDecimal);
                    if (IsConvert == true)
                    {
                        vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[47]";
                        }
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[47]";
                    }
                    mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                }

                //[48]
                vXLIndexColumn = pXLColumn[48];
                vGridIndexColumn = pGridColumn[48];
                //vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertNumber(vGetValue, out vConvertDecimal);
                    if (IsConvert == true)
                    {
                        vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[48]";
                        }
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[48]";
                    }
                    mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                }

                //[49]
                vXLIndexColumn = pXLColumn[49];
                vGridIndexColumn = pGridColumn[49];
                //vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertNumber(vGetValue, out vConvertDecimal);
                    if (IsConvert == true)
                    {
                        vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[49]";
                        }
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[49]";
                    }
                    mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                }

                //[50]
                vXLIndexColumn = pXLColumn[50];
                vGridIndexColumn = pGridColumn[50];
                //vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertNumber(vGetValue, out vConvertDecimal);
                    if (IsConvert == true)
                    {
                        vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[50]";
                        }
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[50]";
                    }
                    mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                }

                //[51]
                vXLIndexColumn = pXLColumn[51];
                vGridIndexColumn = pGridColumn[51];
                //vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertNumber(vGetValue, out vConvertDecimal);
                    if (IsConvert == true)
                    {
                        vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[51]";
                        }
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[51]";
                    }
                    mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                }

                #endregion;

                #region ----- [52] ~ [58] ----

                vXLine++;
                //--------------------------------------------------------------------------------------------------

                //[52]
                vXLIndexColumn = pXLColumn[52];
                vGridIndexColumn = pGridColumn[52];
                //vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertString(vGetValue, out vConvertString);
                    if (IsConvert == true)
                    {
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[52]";
                        }

                        if (IsMerge == false)
                        {
                            mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                        }
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[52]";
                    }

                    if (IsMerge == false)
                    {
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }

                //[53]
                vXLIndexColumn = pXLColumn[53];
                vGridIndexColumn = pGridColumn[53];
                //vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertString(vGetValue, out vConvertString);
                    if (IsConvert == true)
                    {
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[53]";
                        }

                        if (IsMerge == false)
                        {
                            mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                        }
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[53]";
                    }

                    if (IsMerge == false)
                    {
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }

                //[54]
                vXLIndexColumn = pXLColumn[54];
                vGridIndexColumn = pGridColumn[54];
                //vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertString(vGetValue, out vConvertString);
                    if (IsConvert == true)
                    {
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[54]";
                        }
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[54]";
                    }
                    mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                }

                //[55]
                vXLIndexColumn = pXLColumn[55];
                vGridIndexColumn = pGridColumn[55];
                //vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertString(vGetValue, out vConvertString);
                    if (IsConvert == true)
                    {
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[55]";
                        }
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[55]";
                    }
                    mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                }

                //[56]
                vXLIndexColumn = pXLColumn[56];
                vGridIndexColumn = pGridColumn[56];
                //vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertString(vGetValue, out vConvertString);
                    if (IsConvert == true)
                    {
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[56]";
                        }
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[56]";
                    }
                    mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                }

                //[57]
                vXLIndexColumn = pXLColumn[57];
                vGridIndexColumn = pGridColumn[57];
                //vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertString(vGetValue, out vConvertString);
                    if (IsConvert == true)
                    {
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[57]";
                        }
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[57]";
                    }
                    mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                }

                //[58]
                vXLIndexColumn = pXLColumn[58];
                vGridIndexColumn = pGridColumn[58];
                //vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertString(vGetValue, out vConvertString);
                    if (IsConvert == true)
                    {
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[58]";
                        }
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[58]";
                    }
                    mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                }

                //[59]
                vXLIndexColumn = pXLColumn[59];
                vGridIndexColumn = pGridColumn[59];
                //vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertNumber(vGetValue, out vConvertDecimal);
                    if (IsConvert == true)
                    {
                        vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[59]";
                        }
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[59]";
                    }
                    mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                }

                //[60]
                vXLIndexColumn = pXLColumn[60];
                vGridIndexColumn = pGridColumn[60];
                //vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertNumber(vGetValue, out vConvertDecimal);
                    if (IsConvert == true)
                    {
                        vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[60]";
                        }
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[60]";
                    }
                    mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                }

                //[61]
                vXLIndexColumn = pXLColumn[61];
                vGridIndexColumn = pGridColumn[61];
                //vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertNumber(vGetValue, out vConvertDecimal);
                    if (IsConvert == true)
                    {
                        vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[61]";
                        }
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[61]";
                    }
                    mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                }

                //[62]
                vXLIndexColumn = pXLColumn[62];
                vGridIndexColumn = pGridColumn[62];
                //vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertNumber(vGetValue, out vConvertDecimal);
                    if (IsConvert == true)
                    {
                        vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[62]";
                        }
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[62]";
                    }
                    mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                }

                //[63]
                vXLIndexColumn = pXLColumn[63];
                vGridIndexColumn = pGridColumn[63];
                //vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertNumber(vGetValue, out vConvertDecimal);
                    if (IsConvert == true)
                    {
                        vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[63]";
                        }
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[63]";
                    }
                    mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                }

                //[64]
                vXLIndexColumn = pXLColumn[64];
                vGridIndexColumn = pGridColumn[64];
                //vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertNumber(vGetValue, out vConvertDecimal);
                    if (IsConvert == true)
                    {
                        vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[64]";
                        }
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[64]";
                    }
                    mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                }

                //[65]
                vXLIndexColumn = pXLColumn[65];
                vGridIndexColumn = pGridColumn[65];
                //vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertNumber(vGetValue, out vConvertDecimal);
                    if (IsConvert == true)
                    {
                        vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[65]";
                        }
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[65]";
                    }
                    mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                }

                //[66]
                vXLIndexColumn = pXLColumn[66];
                vGridIndexColumn = pGridColumn[66];
                //vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertNumber(vGetValue, out vConvertDecimal);
                    if (IsConvert == true)
                    {
                        vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[66]";
                        }
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[66]";
                    }
                    mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                }

                //[67]
                vXLIndexColumn = pXLColumn[67];
                vGridIndexColumn = pGridColumn[67];
                //vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertNumber(vGetValue, out vConvertDecimal);
                    if (IsConvert == true)
                    {
                        vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[67]";
                        }
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[67]";
                    }
                    mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                }

                //[68]
                vXLIndexColumn = pXLColumn[68];
                vGridIndexColumn = pGridColumn[68];
                //vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertNumber(vGetValue, out vConvertDecimal);
                    if (IsConvert == true)
                    {
                        vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[68]";
                        }
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[68]";
                    }
                    mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                }

                #endregion;

                //-------------------------------------------------------------------
                vXLine = vXLine + 1;
                //-------------------------------------------------------------------
            }
            catch (System.Exception ex)
            {
                mMessageError = ex.Message;
                mAppInterface.OnAppMessageEvent(mMessageError);
                System.Windows.Forms.Application.DoEvents();
            }


            mCountRow++;


            pXLine = vXLine;

            return pXLine;
        }

        #endregion;

        #region ----- Cell Merge Methods ----

        private void CellMerge(int pCopySumPrintingLine, int pCountRow, int[] pRowMerge)
        {
            int vXLine = 0;
            int vCountRowMerge = pRowMerge.Length;

            try
            {
                for (int vCount = 0; vCount < vCountRowMerge; vCount++)
                {
                    if (pRowMerge[vCount] == 1)
                    {
                        vXLine = (pCopySumPrintingLine - mIncrementCopyMAX) + mPrintingLineSTART + (vCount * 4);
                        int vStartRow = vXLine - 1;
                        int vStartCol = mMegerColumnStart; // pXLColumn[1];
                        int vEndRow = vXLine + 2;
                        int vEndCol = mMegerColumnEnd - 1; // pXLColumn[3] - 1;

                        mPrinting.XLCellMerge(vStartRow, vStartCol, vEndRow, vEndCol, false);
                    }

                    mRowMerge[vCount] = -1;
                }

                mCountRow = 0; //병합해야할 셀의 행 위치 Count, 0으로 Set
            }
            catch (System.Exception ex)
            {
                mMessageError = ex.Message;
            }
        }

        #endregion;

        #endregion;

        #region ----- Excel Wirte [Line] Methods ----

        public int LineWrite(InfoSummit.Win.ControlAdv.ISGridAdvEx pGrid, string pUserName, string pCorporationName, string pYYYYMM, string pWageTypeName, string pDepartmentName)
        {
            mPageNumber = 0;
            string vMessage = string.Empty;

            string vPrintingDate = System.DateTime.Now.ToString("yyyy-MM-dd", null);
            string vPrintingTime = System.DateTime.Now.ToString("HH:mm:ss", null);
            mPringingDateTime = string.Format("{0} {1}", vPrintingDate, vPrintingTime);

            int[] vGridColumn;
            int[] vXLColumn;

            int vPrintingLine = 0;

            try
            {
                int vBy = 8;
                int vTotal1ROW = pGrid.RowCount;

                mPageTotalNumber = vTotal1ROW / vBy;
                mPageTotalNumber = (vTotal1ROW % vBy) == 0 ? mPageTotalNumber : (mPageTotalNumber + 1);

                #region ----- Sheet Copy ----

                mMessageValue1 = mMessageAdapter.ReturnText("FCM_10217");  //부서합계
                mMessageValue2 = mMessageAdapter.ReturnText("EAPP_10045"); //총합계

                mCorporationName = pCorporationName;   //업체
                mUserName = pUserName;                 //출력자
                mYYYYMM = pYYYYMM;                     //출력년월
                mWageTypeName = pWageTypeName;         //급여구분
                mDepartmentName = pDepartmentName;     //부서

                SetArray1();

                mCopyLineSUM = CopyAndPaste(mCopyLineSUM);

                #endregion;

                #region ----- Line Write ----

                if (vTotal1ROW > 0)
                {
                    int vCountROW1 = 0;

                    vPrintingLine = mPrintingLineSTART;

                    SetArray2(pGrid, out vGridColumn, out vXLColumn);

                    vTotal1ROW = 72;
                    for (int vRow1 = 0; vRow1 < vTotal1ROW; vRow1++)
                    {
                        vCountROW1++;

                        vMessage = string.Format("Grid1 : {0}/{1}", vCountROW1, vTotal1ROW);
                        mAppInterface.OnAppMessageEvent(vMessage);
                        System.Windows.Forms.Application.DoEvents();

                        vPrintingLine = XLLine(pGrid, vRow1, vPrintingLine, vGridColumn, vXLColumn);

                        if (vTotal1ROW == vCountROW1)
                        {
                            //마지막 행이면...
                            CellMerge(mCopyLineSUM, mCountRow, mRowMerge);
                        }
                        else
                        {
                            IsNewPage(vPrintingLine);
                            if (mIsNewPage == true)
                            {
                                vPrintingLine = (mCopyLineSUM - mIncrementCopyMAX) + (mPrintingLineSTART - 1);
                            }
                        }
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

        private void IsNewPage(int pPrintingLine)
        {
            int vPrintingLineEND = mCopyLineSUM - 3; //1~45: mCopyLineSUM=46에서 내용이 출력되는 행이 43 이므로, 3을 빼면 된다
            if (vPrintingLineEND < pPrintingLine)
            {
                CellMerge(mCopyLineSUM, mCountRow, mRowMerge);

                mIsNewPage = true;
                mCopyLineSUM = CopyAndPaste(mCopyLineSUM);
            }
            else
            {
                mIsNewPage = false;
            }
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
            //string vPageString = string.Format("{0} / {1}", mPageNumber, mPageTotalNumber);
            string vPageString = string.Format("{0}", mPageNumber);
            //------------------------------------------------------------------------------------------------------------
            XLHeader(pCopySumPrintingLine, mUserName, mPringingDateTime, mYYYYMM, mWageTypeName, mDepartmentName, vPageString, mCorporationName);
            //------------------------------------------------------------------------------------------------------------

            return vCopySumPrintingLine;
        }

        #endregion;

        #region ----- Printing Methods ----

        public void Printing(int pPageSTART, int pPageEND)
        {
            mPrinting.XLPrinting(pPageSTART, pPageEND);
            mPrinting.XLPreviewPrinting(pPageSTART, pPageEND, 1);
        }

        #endregion;

        #region ----- Save Methods ----

        public void SAVE(string pSaveFileName)
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
