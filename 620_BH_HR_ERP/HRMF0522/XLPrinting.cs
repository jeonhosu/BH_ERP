using System;

namespace HRMF0522
{
    public class XLPrinting
    {
        #region ----- Variables -----

        private InfoSummit.Win.ControlAdv.ISAppInterface mAppInterface = null;
        private InfoSummit.Win.ControlAdv.ISMessageAdapter mMessageAdapter = null;

        private XL.XLPrint mPrinting = null;

        private string mMessageError = string.Empty;

        //private int mPageTotalNumber = 0;
        private int mPageNumber = 0;

        //private bool mIsNewPage = false;

        private string mXLOpenFileName = string.Empty;

        private int mPrintingLineSTART = 1;  //Line

        private int mCopyLineSUM = 1;        //엑셀의 선택된 쉬트의 복사되어질 시작 행 위치, 복사 행 누적
        private int mIncrementCopyMAX = 72;  //복사되어질 행의 범위

        private int mCopyColumnSTART = 1; //복사되어  진 행 누적 수
        private int mCopyColumnEND = 45;  //엑셀의 선택된 쉬트의 복사되어질 끝 열 위치

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

        #region ----- Array Set 1 ----

        private void SetArray1(System.Data.DataTable pTable, out int[] pGDColumn, out int[] pXLColumn)
        {
            pGDColumn = new int[2];
            pXLColumn = new int[2];

            pGDColumn[0] = pTable.Columns.IndexOf("ALLOWANCE_NAME");       //급여 지급명
            pGDColumn[1] = pTable.Columns.IndexOf("ALLOWANCE_AMOUNT");     //급여 지급금액

            pXLColumn[0] = 6;    //급여 지급명
            pXLColumn[1] = 15;   //급여 지급명액
        }

        #endregion;

        #region ----- Array Set 2 ----

        private void SetArray2(System.Data.DataTable pTable, out int[] pGDColumn, out int[] pXLColumn)
        {
            pGDColumn = new int[2];
            pXLColumn = new int[2];

            pGDColumn[0] = pTable.Columns.IndexOf("DEDUCTION_NAME");       //급여 공제명
            pGDColumn[1] = pTable.Columns.IndexOf("DEDUCTION_AMOUNT");     //급여 공제금액

            pXLColumn[0] = 25;   //급여 공제명
            pXLColumn[1] = 34;   //급여 공제금액
        }

        #endregion;

        #region ----- Array Set 3 ----

        private void SetArray3(System.Data.DataTable pTable, out int[] pGDColumn, out int[] pXLColumn)
        {
            pGDColumn = new int[2];
            pXLColumn = new int[2];

            pGDColumn[0] = pTable.Columns.IndexOf("ALLOWANCE_NAME");       //상여 지급명
            pGDColumn[1] = pTable.Columns.IndexOf("ALLOWANCE_AMOUNT");     //상여 지급금액

            pXLColumn[0] = 6;    //상여 지급명
            pXLColumn[1] = 15;   //상여 지급명액
        }

        #endregion;

        #region ----- Array Set 4 ----

        private void SetArray4(System.Data.DataTable pTable, out int[] pGDColumn, out int[] pXLColumn)
        {
            pGDColumn = new int[2];
            pXLColumn = new int[2];

            pGDColumn[0] = pTable.Columns.IndexOf("DEDUCTION_NAME");       //상여 공제명
            pGDColumn[1] = pTable.Columns.IndexOf("DEDUCTION_AMOUNT");     //상여 공제금액

            pXLColumn[0] = 25;   //상여 공제명
            pXLColumn[1] = 34;   //상여 공제금액
        }

        #endregion;

        #region ----- Array Set 5 ----

        private void SetArray5(System.Data.DataTable pTable, out int[] pGDColumn, out int[] pXLColumn)
        {
            pGDColumn = new int[17];
            pXLColumn = new int[17];

            pGDColumn[0] = pTable.Columns.IndexOf("TOTAL_ATT_TIME");        //기본근무시간 
            pGDColumn[1] = pTable.Columns.IndexOf("OVER_TIME");             //연장근무  
            pGDColumn[2] = pTable.Columns.IndexOf("NIGHT_BONUS_TIME");      //야간근무
            pGDColumn[3] = pTable.Columns.IndexOf("HOLIDAY_TIME");          //휴일근무
            pGDColumn[4] = pTable.Columns.IndexOf("HOLIDAY_OVER_TIME");     //휴일연장근무 
            pGDColumn[5] = pTable.Columns.IndexOf("LATE_TIME");             //근태공제 
            pGDColumn[6] = pTable.Columns.IndexOf("CREATION_NUM");          //발생연차 
            pGDColumn[7] = pTable.Columns.IndexOf("REMAIN_NUM");            //잔여연차 
            pGDColumn[8] = pTable.Columns.IndexOf("BASE_AMOUNT");           //기본급 
            pGDColumn[9] = pTable.Columns.IndexOf("TOTAL_ATT_DAY");         //근무일수 
            pGDColumn[10] = pTable.Columns.IndexOf("S_HOLY_1_COUNT");       //주휴일수 
            pGDColumn[11] = pTable.Columns.IndexOf("H_HOLY_1_COUNT");       //공휴일수 
            pGDColumn[12] = pTable.Columns.IndexOf("HOLY_0_COUNT");         //무휴일수 
            pGDColumn[13] = pTable.Columns.IndexOf("DUTY_11");              //결근 
            pGDColumn[14] = pTable.Columns.IndexOf("LATE_DED_COUNT");       //지각/조퇴회수 
            pGDColumn[15] = pTable.Columns.IndexOf("THIS_DUTY_20_NUM");     //당월사용연차수
            pGDColumn[16] = pTable.Columns.IndexOf("USE_NUM");              //누적사용연차수

            pXLColumn[0] = 4;       //기본근무시간
            pXLColumn[1] = 9;       //연장근무
            pXLColumn[2] = 14;      //야간근무
            pXLColumn[3] = 19;      //휴일근무
            pXLColumn[4] = 24;      //휴일연장근무
            pXLColumn[5] = 29;      //근태공제
            pXLColumn[6] = 34;      //발생연차 
            pXLColumn[7] = 39;      //잔여연차
            pXLColumn[8] = 4;       //기본급
            pXLColumn[9] = 8;       //근무일수
            pXLColumn[10] = 12;     //주휴일수 
            pXLColumn[11] = 16;     //공휴일수 
            pXLColumn[12] = 20;     //무휴일수 
            pXLColumn[13] = 24;     //결근
            pXLColumn[14] = 29;     //지각/조퇴회수 
            pXLColumn[15] = 34;     //당월사용연차수
            pXLColumn[16] = 39;     //누적사용연차수
        }

        #endregion;

        #region ----- Array Set 6 ----

        private void SetArray6(InfoSummit.Win.ControlAdv.ISGridAdvEx pGrid, out int[] pGDColumn, out int[] pXLColumn)
        {
            pGDColumn = new int[27];
            pXLColumn = new int[26];

            pGDColumn[0] = pGrid.GetColumnToIndex("WAGE_TYPE_NAME");            //Title
            pGDColumn[1] = pGrid.GetColumnToIndex("DEPT_NAME");                 //부서
            pGDColumn[2] = pGrid.GetColumnToIndex("POST_NAME");                 //직위
            pGDColumn[3] = pGrid.GetColumnToIndex("PERSON_NUM");                //사번
            pGDColumn[4] = pGrid.GetColumnToIndex("NAME");                      //이름

            pGDColumn[5] = pGrid.GetColumnToIndex("NAME");                      //성명
            pGDColumn[6] = pGrid.GetColumnToIndex("PERSON_NUM");                //사번
            pGDColumn[7] = pGrid.GetColumnToIndex("DEPT_NAME");                 //부서
            pGDColumn[8] = pGrid.GetColumnToIndex("POST_NAME");                 //직위
            pGDColumn[9] = pGrid.GetColumnToIndex("JOB_CLASS_NAME");            //직군
            pGDColumn[10] = pGrid.GetColumnToIndex("SUPPLY_DATE");              //지급일
            pGDColumn[11] = pGrid.GetColumnToIndex("BANK_NAME");                //입금은행
            pGDColumn[12] = pGrid.GetColumnToIndex("BANK_ACCOUNTS");            //입금계좌

            pGDColumn[13] = pGrid.GetColumnToIndex("BASIC_AMOUNT");             //기본급
            pGDColumn[14] = pGrid.GetColumnToIndex("HOURLY_AMOUNT");            //시급
            pGDColumn[15] = pGrid.GetColumnToIndex("GENERAL_HOURLY_AMOUNT");    //통상시급

            pGDColumn[16] = pGrid.GetColumnToIndex("TOT_PAY_DED_AMOUNT");       //급여 총공제액
            pGDColumn[17] = pGrid.GetColumnToIndex("TOT_PAY_SUP_AMOUNT");       //급여 총지급액
            pGDColumn[18] = pGrid.GetColumnToIndex("REAL_PAY_AMOUNT");          //급여 실지급액

            pGDColumn[19] = pGrid.GetColumnToIndex("TOT_BONUS_DED_AMOUNT");     //상여 총공제액
            pGDColumn[20] = pGrid.GetColumnToIndex("TOT_BONUS_SUP_AMOUNT");     //상여 총지급액
            pGDColumn[21] = pGrid.GetColumnToIndex("REAL_BONUS_AMOUNT");        //상여 실지급액

            pGDColumn[22] = pGrid.GetColumnToIndex("TOT_SUPPLY_AMOUNT");        //총지급액
            pGDColumn[23] = pGrid.GetColumnToIndex("TOT_DED_AMOUNT");           //총공제액
            pGDColumn[24] = pGrid.GetColumnToIndex("REAL_AMOUNT");              //총 실지급액

            pGDColumn[25] = pGrid.GetColumnToIndex("DESCRIPTION");              //비고
            pGDColumn[26] = pGrid.GetColumnToIndex("NOTIFICATION");             //알림

            pXLColumn[0] = 4;       //Title
            pXLColumn[1] = 8;       //부서
            pXLColumn[2] = 8;       //직위
            pXLColumn[3] = 8;       //사번
            pXLColumn[4] = 8;       //이름

            pXLColumn[5] = 9;       //성명
            pXLColumn[6] = 22;      //사번
            pXLColumn[7] = 36;      //부서
            pXLColumn[8] = 9;       //직위
            pXLColumn[9] = 22;      //직군
            pXLColumn[10] = 36;     //지급일
            pXLColumn[11] = 9;      //입금은행
            pXLColumn[12] = 22;     //입금계좌

            pXLColumn[13] = 32;     //기본급
            pXLColumn[14] = 36;     //시급
            pXLColumn[15] = 40;     //통상시급

            pXLColumn[16] = 34;     //급여 총공제액
            pXLColumn[17] = 15;     //급여 총지급액
            pXLColumn[18] = 34;     //급여 실지급액

            pXLColumn[19] = 34;     //상여 총공제액
            pXLColumn[20] = 15;     //상여 총지급액
            pXLColumn[21] = 34;     //상여 실지급액

            pXLColumn[22] = 15;     //총지급액
            pXLColumn[23] = 34;     //총공제액
            pXLColumn[24] = 25;     //총 실지급액

            pXLColumn[25] = 4;      //비고
        }

        #endregion;

        #region ----- Convert String Method ----

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
                mAppInterface.OnAppMessageEvent(ex.Message);
                System.Windows.Forms.Application.DoEvents();
            }

            return vString;
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

        private bool IsConvertDate(object pObject, out System.DateTime pConvertDateTimeShort)
        {
            bool vIsConvert = false;
            pConvertDateTimeShort = new System.DateTime();

            try
            {
                if (pObject != null)
                {
                    vIsConvert = pObject is System.DateTime;
                    if (vIsConvert == true)
                    {
                        System.DateTime vDateTime = (System.DateTime)pObject;
                        pConvertDateTimeShort = vDateTime;
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

        #region ----- Line Write 1 Method -----

        //급여 지급
        private int XLLine_1(System.Data.DataRow pRow, int pXLine, int[] pGDColumn, int[] pXLColumn)
        {
            int vXLine = pXLine; //엑셀에 내용이 표시되는 행 번호

            int vDBColumnIndex = 0;
            int vXLColumnIndex = 0;

            object vObject = null;
            string vConvertString = string.Empty;
            decimal vConvertDecimal = 0m;
            bool IsConvert = false;

            try
            {
                mPrinting.XLActiveSheet("Destination");

                //급여 지급명
                vDBColumnIndex = pGDColumn[0];
                vXLColumnIndex = pXLColumn[0];
                vObject = pRow[vDBColumnIndex];
                IsConvert = IsConvertString(vObject, out vConvertString);
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

                //급여 지급금액
                vDBColumnIndex = pGDColumn[1];
                vXLColumnIndex = pXLColumn[1];
                vObject = pRow[vDBColumnIndex];
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

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

            pXLine = vXLine;

            return pXLine;
        }

        #endregion;

        #region ----- Line Write 2 Method -----

        //급여 공제
        private int XLLine_2(System.Data.DataRow pRow, int pXLine, int[] pGDColumn, int[] pXLColumn)
        {
            int vXLine = pXLine; //엑셀에 내용이 표시되는 행 번호

            int vDBColumnIndex = 0;
            int vXLColumnIndex = 0;

            object vObject = null;
            string vConvertString = string.Empty;
            decimal vConvertDecimal = 0m;
            bool IsConvert = false;

            try
            {
                mPrinting.XLActiveSheet("Destination");

                //급여 공제명
                vDBColumnIndex = pGDColumn[0];
                vXLColumnIndex = pXLColumn[0];
                vObject = pRow[vDBColumnIndex];
                IsConvert = IsConvertString(vObject, out vConvertString);
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

                //급여 공제금액
                vDBColumnIndex = pGDColumn[1];
                vXLColumnIndex = pXLColumn[1];
                vObject = pRow[vDBColumnIndex];
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

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

            pXLine = vXLine;

            return pXLine;
        }

        #endregion;

        #region ----- Line Write 3 Method -----

        //상여 지급
        private int XLLine_3(System.Data.DataRow pRow, int pXLine, int[] pGDColumn, int[] pXLColumn)
        {
            int vXLine = pXLine; //엑셀에 내용이 표시되는 행 번호

            int vDBColumnIndex = 0;
            int vXLColumnIndex = 0;

            object vObject = null;
            string vConvertString = string.Empty;
            decimal vConvertDecimal = 0m;
            bool IsConvert = false;

            try
            {
                mPrinting.XLActiveSheet("Destination");

                //상여 지급명
                vDBColumnIndex = pGDColumn[0];
                vXLColumnIndex = pXLColumn[0];
                vObject = pRow[vDBColumnIndex];
                IsConvert = IsConvertString(vObject, out vConvertString);
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

                //상여 지급금액
                vDBColumnIndex = pGDColumn[1];
                vXLColumnIndex = pXLColumn[1];
                vObject = pRow[vDBColumnIndex];
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

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

            pXLine = vXLine;

            return pXLine;
        }

        #endregion;

        #region ----- Line Write 4 Method -----

        //상여 공제
        private int XLLine_4(System.Data.DataRow pRow, int pXLine, int[] pGDColumn, int[] pXLColumn)
        {
            int vXLine = pXLine; //엑셀에 내용이 표시되는 행 번호

            int vDBColumnIndex = 0;
            int vXLColumnIndex = 0;

            object vObject = null;
            string vConvertString = string.Empty;
            decimal vConvertDecimal = 0m;
            bool IsConvert = false;

            try
            {
                mPrinting.XLActiveSheet("Destination");

                //상여 공제명
                vDBColumnIndex = pGDColumn[0];
                vXLColumnIndex = pXLColumn[0];
                vObject = pRow[vDBColumnIndex];
                IsConvert = IsConvertString(vObject, out vConvertString);
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

                //상여 공제금액
                vDBColumnIndex = pGDColumn[1];
                vXLColumnIndex = pXLColumn[1];
                vObject = pRow[vDBColumnIndex];
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

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

            pXLine = vXLine;

            return pXLine;
        }

        #endregion;

        #region ----- Line Write 5 Method -----

        //근무시간 및 부가내역
        private int XLLine_5(System.Data.DataRow pRow, int pXLine, int[] pGDColumn, int[] pXLColumn)
        {
            int vXLine = pXLine; //엑셀에 내용이 표시되는 행 번호

            int vDBColumnIndex = 0;
            int vXLColumnIndex = 0;

            object vObject = null;
            string vConvertString = string.Empty;
            decimal vConvertDecimal = 0m;
            bool IsConvert = false;

            try
            {
                mPrinting.XLActiveSheet("Destination");

                //기본근무
                vDBColumnIndex = pGDColumn[0];
                vXLColumnIndex = pXLColumn[0];
                vObject = pRow[vDBColumnIndex];
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    if (vConvertDecimal != 0)
                    {
                        vConvertString = string.Format("{0:#,##0.###}", vConvertDecimal);
                    }
                    else
                    {
                        vConvertString = string.Empty;
                    }
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                //연장근무 
                vDBColumnIndex = pGDColumn[1];
                vXLColumnIndex = pXLColumn[1];
                vObject = pRow[vDBColumnIndex];
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    if (vConvertDecimal != 0)
                    {
                        vConvertString = string.Format("{0:#,##0.###}", vConvertDecimal);
                    }
                    else
                    {
                        vConvertString = string.Empty;
                    }
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                //야간근무 
                vDBColumnIndex = pGDColumn[2];
                vXLColumnIndex = pXLColumn[2];
                vObject = pRow[vDBColumnIndex];
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    if (vConvertDecimal != 0)
                    {
                        vConvertString = string.Format("{0:#,##0.###}", vConvertDecimal);
                    }
                    else
                    {
                        vConvertString = string.Empty;
                    }
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                //휴일근무
                vDBColumnIndex = pGDColumn[3];
                vXLColumnIndex = pXLColumn[3];
                vObject = pRow[vDBColumnIndex];
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    if (vConvertDecimal != 0)
                    {
                        vConvertString = string.Format("{0:#,##0.###}", vConvertDecimal);
                    }
                    else
                    {
                        vConvertString = string.Empty;
                    }
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                //휴일연장근무
                vDBColumnIndex = pGDColumn[4];
                vXLColumnIndex = pXLColumn[4];
                vObject = pRow[vDBColumnIndex];
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    if (vConvertDecimal != 0)
                    {
                        vConvertString = string.Format("{0:#,##0.###}", vConvertDecimal);
                    }
                    else
                    {
                        vConvertString = string.Empty;
                    }
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                //근태공제
                vDBColumnIndex = pGDColumn[5];
                vXLColumnIndex = pXLColumn[5];
                vObject = pRow[vDBColumnIndex];
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    if (vConvertDecimal != 0)
                    {
                        vConvertString = string.Format("{0:#,##0.###}", vConvertDecimal);
                    }
                    else
                    {
                        vConvertString = string.Empty;
                    }
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                //발생연차
                vDBColumnIndex = pGDColumn[6];
                vXLColumnIndex = pXLColumn[6];
                vObject = pRow[vDBColumnIndex];
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    if (vConvertDecimal != 0)
                    {
                        vConvertString = string.Format("{0:#,##0.###}", vConvertDecimal);
                    }
                    else
                    {
                        vConvertString = string.Empty;
                    }
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                //잔여연차
                vDBColumnIndex = pGDColumn[7];
                vXLColumnIndex = pXLColumn[7];
                vObject = pRow[vDBColumnIndex];
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    if (vConvertDecimal != 0)
                    {
                        vConvertString = string.Format("{0:#,##0.###}", vConvertDecimal);
                    }
                    else
                    {
                        vConvertString = string.Empty;
                    }
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                //-------------------------------------------------------------------
                vXLine = vXLine + 4;
                //-------------------------------------------------------------------

                //기본일급
                vDBColumnIndex = pGDColumn[8];
                vXLColumnIndex = pXLColumn[8];
                vObject = pRow[vDBColumnIndex];
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    if (vConvertDecimal != 0)
                    {
                        vConvertString = string.Format("{0:##,###,##0}", vConvertDecimal);
                    }
                    else
                    {
                        vConvertString = string.Empty;
                    }
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                //근무일수
                vDBColumnIndex = pGDColumn[9];
                vXLColumnIndex = pXLColumn[9];
                vObject = pRow[vDBColumnIndex];
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:##,###,###}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                //주휴일수
                vDBColumnIndex = pGDColumn[10];
                vXLColumnIndex = pXLColumn[10];
                vObject = pRow[vDBColumnIndex];
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:##,###,###}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                //공휴일수
                vDBColumnIndex = pGDColumn[11];
                vXLColumnIndex = pXLColumn[11];
                vObject = pRow[vDBColumnIndex];
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:##,###,###}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                //무휴일수
                vDBColumnIndex = pGDColumn[12];
                vXLColumnIndex = pXLColumn[12];
                vObject = pRow[vDBColumnIndex];
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:##,###,###}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                //결근
                vDBColumnIndex = pGDColumn[13];
                vXLColumnIndex = pXLColumn[13];
                vObject = pRow[vDBColumnIndex];
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:##,###,###}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                //지각/조퇴/외출
                vDBColumnIndex = pGDColumn[14];
                vXLColumnIndex = pXLColumn[14];
                vObject = pRow[vDBColumnIndex];
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:##,###,###}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                //당월사용연차
                vDBColumnIndex = pGDColumn[15];
                vXLColumnIndex = pXLColumn[15];
                vObject = pRow[vDBColumnIndex];
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:##,###,###}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                //누적사용연차
                vDBColumnIndex = pGDColumn[16];
                vXLColumnIndex = pXLColumn[16];
                vObject = pRow[vDBColumnIndex];
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:##,###,###}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
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

        #region ----- Line Write 6 Method -----
        
        //Heaer 및 인적사항, 총금액
        private int XLLine_6(InfoSummit.Win.ControlAdv.ISGridAdvEx pGrid, int pGridRow, int pXLine, int[] pGDColumn, int[] pXLColumn, string pCourse)
        {
            int vXLine = pXLine; //엑셀에 내용이 표시되는 행 번호

            int vGDColumnIndex = 0;
            int vXLColumnIndex = 0;

            object vObject = null;
            string vConvertString = string.Empty;
            decimal vConvertDecimal = 0m;
            System.DateTime vConvertDateTime = new System.DateTime();
            bool IsConvert = false;

            try
            {
                mPrinting.XLActiveSheet("Destination");

                //Title
                vGDColumnIndex = pGDColumn[0];
                vXLColumnIndex = pXLColumn[0];
                vObject = pGrid.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertString(vObject, out vConvertString);
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

                //-------------------------------------------------------------------
                vXLine = vXLine + 10;
                //-------------------------------------------------------------------

                //부서
                vGDColumnIndex = pGDColumn[1];
                vXLColumnIndex = pXLColumn[1];
                vObject = pGrid.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertString(vObject, out vConvertString);
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

                //-------------------------------------------------------------------
                vXLine = vXLine + 2;
                //-------------------------------------------------------------------

                //직위
                vGDColumnIndex = pGDColumn[2];
                vXLColumnIndex = pXLColumn[2];
                vObject = pGrid.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertString(vObject, out vConvertString);
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

                //-------------------------------------------------------------------
                vXLine = vXLine + 2;
                //-------------------------------------------------------------------

                //사번
                vGDColumnIndex = pGDColumn[3];
                vXLColumnIndex = pXLColumn[3];
                vObject = pGrid.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertString(vObject, out vConvertString);
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

                //-------------------------------------------------------------------
                vXLine = vXLine + 2;
                //-------------------------------------------------------------------

                //이름
                vGDColumnIndex = pGDColumn[4];
                vXLColumnIndex = pXLColumn[4];
                vObject = pGrid.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertString(vObject, out vConvertString);
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

                //-------------------------------------------------------------------
                vXLine = vXLine + 9;
                //-------------------------------------------------------------------

                //성명
                vGDColumnIndex = pGDColumn[5];
                vXLColumnIndex = pXLColumn[5];
                vObject = pGrid.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertString(vObject, out vConvertString);
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

                //사번
                vGDColumnIndex = pGDColumn[6];
                vXLColumnIndex = pXLColumn[6];
                vObject = pGrid.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertString(vObject, out vConvertString);
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

                //부서
                vGDColumnIndex = pGDColumn[7];
                vXLColumnIndex = pXLColumn[7];
                vObject = pGrid.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertString(vObject, out vConvertString);
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

                //-------------------------------------------------------------------
                vXLine = vXLine + 1;
                //-------------------------------------------------------------------

                //직위
                vGDColumnIndex = pGDColumn[8];
                vXLColumnIndex = pXLColumn[8];
                vObject = pGrid.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertString(vObject, out vConvertString);
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

                //직군
                vGDColumnIndex = pGDColumn[9];
                vXLColumnIndex = pXLColumn[9];
                vObject = pGrid.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertString(vObject, out vConvertString);
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

                //지급일
                vGDColumnIndex = pGDColumn[10];
                vXLColumnIndex = pXLColumn[10];
                vObject = pGrid.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertDate(vObject, out vConvertDateTime);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0}", vConvertDateTime.ToShortDateString());
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                //-------------------------------------------------------------------
                vXLine = vXLine + 1;
                //-------------------------------------------------------------------

                //입금은행
                vGDColumnIndex = pGDColumn[11];
                vXLColumnIndex = pXLColumn[11];
                vObject = pGrid.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertString(vObject, out vConvertString);
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

                //입금계좌
                vGDColumnIndex = pGDColumn[12];
                vXLColumnIndex = pXLColumn[12];
                vObject = pGrid.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertString(vObject, out vConvertString);
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

                //-------------------------------------------------------------------
                vXLine = vXLine + 10;
                //-------------------------------------------------------------------

                ////기본급
                //vGDColumnIndex = pGDColumn[13];
                //vXLColumnIndex = pXLColumn[13];
                //vObject = pGrid.GetCellValue(pGridRow, vGDColumnIndex);
                //IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                //if (IsConvert == true)
                //{
                //    vConvertString = string.Format("{0:#}", vConvertDecimal);
                //    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                //}
                //else
                //{
                //    vConvertString = string.Empty;
                //    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                //}

                ////시급
                //vGDColumnIndex = pGDColumn[14];
                //vXLColumnIndex = pXLColumn[14];
                //vObject = pGrid.GetCellValue(pGridRow, vGDColumnIndex);
                //IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                //if (IsConvert == true)
                //{
                //    vConvertString = string.Format("{0:#}", vConvertDecimal);
                //    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                //}
                //else
                //{
                //    vConvertString = string.Empty;
                //    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                //}

                ////통상시급
                //vGDColumnIndex = pGDColumn[15];
                //vXLColumnIndex = pXLColumn[15];
                //vObject = pGrid.GetCellValue(pGridRow, vGDColumnIndex);
                //IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                //if (IsConvert == true)
                //{
                //    vConvertString = string.Format("{0:#}", vConvertDecimal);
                //    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                //}
                //else
                //{
                //    vConvertString = string.Empty;
                //    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                //}

                if (pCourse == "DAILY")
                {
                    //-------------------------------------------------------------------
                    vXLine = vXLine + 15;
                    //-------------------------------------------------------------------

                    //급여_총공제액
                    vGDColumnIndex = pGDColumn[16];
                    vXLColumnIndex = pXLColumn[16];
                    vObject = pGrid.GetCellValue(pGridRow, vGDColumnIndex);
                    IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                    if (IsConvert == true)
                    {
                        vConvertString = string.Format("{0:#}", vConvertDecimal);
                        mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                    }
                    else
                    {
                        vConvertString = string.Empty;
                        mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                    }

                    //-------------------------------------------------------------------
                    vXLine = vXLine + 1;
                    //-------------------------------------------------------------------

                    //급여_총지급액
                    vGDColumnIndex = pGDColumn[17];
                    vXLColumnIndex = pXLColumn[17];
                    vObject = pGrid.GetCellValue(pGridRow, vGDColumnIndex);
                    IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                    if (IsConvert == true)
                    {
                        vConvertString = string.Format("{0:#}", vConvertDecimal);
                        mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                    }
                    else
                    {
                        vConvertString = string.Empty;
                        mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                    }

                    //급여_실지급액
                    vGDColumnIndex = pGDColumn[18];
                    vXLColumnIndex = pXLColumn[18];
                    vObject = pGrid.GetCellValue(pGridRow, vGDColumnIndex);
                    IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                    if (IsConvert == true)
                    {
                        vConvertString = string.Format("{0:#}", vConvertDecimal);
                        mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                    }
                    else
                    {
                        vConvertString = string.Empty;
                        mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                    }

                    //-------------------------------------------------------------------
                    vXLine = vXLine + 6;
                    //-------------------------------------------------------------------

                    //상여_총공제액
                    vGDColumnIndex = pGDColumn[19];
                    vXLColumnIndex = pXLColumn[19];
                    vObject = pGrid.GetCellValue(pGridRow, vGDColumnIndex);
                    IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                    if (IsConvert == true)
                    {
                        vConvertString = string.Format("{0:#}", vConvertDecimal);
                        mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                    }
                    else
                    {
                        vConvertString = string.Empty;
                        mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                    }

                    //-------------------------------------------------------------------
                    vXLine = vXLine + 1;
                    //-------------------------------------------------------------------

                    //상여_총지급액
                    vGDColumnIndex = pGDColumn[20];
                    vXLColumnIndex = pXLColumn[20];
                    vObject = pGrid.GetCellValue(pGridRow, vGDColumnIndex);
                    IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                    if (IsConvert == true)
                    {
                        vConvertString = string.Format("{0:#}", vConvertDecimal);
                        mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                    }
                    else
                    {
                        vConvertString = string.Empty;
                        mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                    }

                    //상여_실지급액
                    vGDColumnIndex = pGDColumn[21];
                    vXLColumnIndex = pXLColumn[21];
                    vObject = pGrid.GetCellValue(pGridRow, vGDColumnIndex);
                    IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                    if (IsConvert == true)
                    {
                        vConvertString = string.Format("{0:#}", vConvertDecimal);
                        mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                    }
                    else
                    {
                        vConvertString = string.Empty;
                        mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                    }

                    //-------------------------------------------------------------------
                    vXLine = vXLine + 1;
                    //-------------------------------------------------------------------
                }
                else if (pCourse == "MONTH")
                {
                    //-------------------------------------------------------------------
                    vXLine = vXLine + 24;
                    //-------------------------------------------------------------------
                }

                //총지급액
                vGDColumnIndex = pGDColumn[22];
                vXLColumnIndex = pXLColumn[22];
                vObject = pGrid.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                //총공제액
                vGDColumnIndex = pGDColumn[23];
                vXLColumnIndex = pXLColumn[23];
                vObject = pGrid.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                //-------------------------------------------------------------------
                vXLine = vXLine + 1;
                //-------------------------------------------------------------------

                //총_실지급액
                vGDColumnIndex = pGDColumn[24];
                vXLColumnIndex = pXLColumn[24];
                vObject = pGrid.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                //-------------------------------------------------------------------
                vXLine = vXLine + 3;
                //-------------------------------------------------------------------

                //비고
                vGDColumnIndex = pGDColumn[26];  // 알림 //
                vXLColumnIndex = pXLColumn[25];                
                vObject = pGrid.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertString(vObject, out vConvertString);
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

            pXLine = vXLine;

            return pXLine;
        }

        #endregion;

        //30장씩
        #region ----- Excel Main Wirte  Method ----

        public int WriteMain(string pCourse, InfoSummit.Win.ControlAdv.ISGridAdvEx pGrid_MONTH_PAYMENT, InfoSummit.Win.ControlAdv.ISDataAdapter pData_PAY_ALLOWANCE, InfoSummit.Win.ControlAdv.ISDataAdapter pData_PAY_DEDUCTION, InfoSummit.Win.ControlAdv.ISDataAdapter pData_DUTY_INFO, InfoSummit.Win.ControlAdv.ISDataAdapter pData_BONUS_ALLOWANCE, InfoSummit.Win.ControlAdv.ISDataAdapter pData_BONUS_DEDUCTION, string pSEAL_FLAG, string pSaveFileName)
        {
            string vMessageText = string.Empty;
            object vObject = null;
            string vBoxCheck = string.Empty;
            string vWAGE_TYPE = string.Empty;
            string vPAY_TYPE = string.Empty;

            int vIndexWAGE_TYPE = pGrid_MONTH_PAYMENT.GetColumnToIndex("WAGE_TYPE");
            int vIndexPAY_TYPE = pGrid_MONTH_PAYMENT.GetColumnToIndex("PAY_TYPE");

            int vIndexCheckBox = pGrid_MONTH_PAYMENT.GetColumnToIndex("SELECT_CHECK_YN");
            string vCheckedString = pGrid_MONTH_PAYMENT.GridAdvExColElement[vIndexCheckBox].CheckedString;

            bool isOpen = XLFileOpen();

            mPageNumber = 0;

            int[] vGDColumn_1;
            int[] vXLColumn_1;

            int[] vGDColumn_2;
            int[] vXLColumn_2;

            int[] vGDColumn_3;
            int[] vXLColumn_3;

            int[] vGDColumn_4;
            int[] vXLColumn_4;

            int[] vGDColumn_5;
            int[] vXLColumn_5;

            int[] vGDColumn_6;
            int[] vXLColumn_6;

            int vTotalRow = pGrid_MONTH_PAYMENT.RowCount;
            int vRowCount = 0;

            int vPrintingLine = 0;

            int vSecondPrinting = 29; //30번째에 인쇄
            int vCountPrinting = 0;

            SetArray1(pData_PAY_ALLOWANCE.OraSelectData, out vGDColumn_1, out vXLColumn_1);
            SetArray2(pData_PAY_DEDUCTION.OraSelectData, out vGDColumn_2, out vXLColumn_2);
            SetArray3(pData_BONUS_ALLOWANCE.OraSelectData, out vGDColumn_3, out vXLColumn_3);
            SetArray4(pData_BONUS_DEDUCTION.OraSelectData, out vGDColumn_4, out vXLColumn_4);
            SetArray5(pData_DUTY_INFO.OraSelectData, out vGDColumn_5, out vXLColumn_5);
            SetArray6(pGrid_MONTH_PAYMENT, out vGDColumn_6, out vXLColumn_6);

            for (int vRow = 0; vRow < vTotalRow; vRow++)
            {
                vRowCount++;                
                pGrid_MONTH_PAYMENT.Cursor = System.Windows.Forms.Cursors.WaitCursor;

                vMessageText = string.Format("Grid : {0}/{1}", vRowCount, vTotalRow);
                mAppInterface.OnAppMessageEvent(vMessageText);
                System.Windows.Forms.Application.DoEvents();

                vObject = pGrid_MONTH_PAYMENT.GetCellValue(vRow, vIndexCheckBox);
                vBoxCheck = ConvertString(vObject);
                if (vBoxCheck == vCheckedString)
                {
                    pGrid_MONTH_PAYMENT.CurrentCellMoveTo(vRow, vIndexCheckBox);
                    pGrid_MONTH_PAYMENT.Focus();
                    pGrid_MONTH_PAYMENT.CurrentCellActivate(vRow, vIndexCheckBox);
                    if (isOpen == true)
                    {
                        vCountPrinting++;

                        vObject = pGrid_MONTH_PAYMENT.GetCellValue(vRow, vIndexWAGE_TYPE);
                        vWAGE_TYPE = ConvertString(vObject);
                        vObject = pGrid_MONTH_PAYMENT.GetCellValue(vRow, vIndexPAY_TYPE);
                        vPAY_TYPE = ConvertString(vObject);

                        if (vWAGE_TYPE == "P1" && (vPAY_TYPE == "2" || vPAY_TYPE == "4"))
                        {
                            mCopyLineSUM = CopyAndPaste(mPrinting, mCopyLineSUM, "DAILY", pSEAL_FLAG);
                            vPrintingLine = (mCopyLineSUM - mIncrementCopyMAX) + (mPrintingLineSTART - 1);

                            //생산직
                            int vLinePrinting_1 = vPrintingLine + 40;
                            for (int vRow1 = 0; vRow1 < pData_PAY_ALLOWANCE.OraSelectData.Rows.Count; vRow1++)
                            {
                                vLinePrinting_1 = XLLine_1(pData_PAY_ALLOWANCE.OraSelectData.Rows[vRow1], vLinePrinting_1, vGDColumn_1, vXLColumn_1); //급여 지급
                            }

                            int vLinePrinting_2 = vPrintingLine + 40;
                            for (int vRow2 = 0; vRow2 < pData_PAY_DEDUCTION.OraSelectData.Rows.Count; vRow2++)
                            {
                                vLinePrinting_2 = XLLine_2(pData_PAY_DEDUCTION.OraSelectData.Rows[vRow2], vLinePrinting_2, vGDColumn_2, vXLColumn_2); //급여 공제
                            }

                            int vLinePrinting_3 = vPrintingLine + 54;
                            for (int vRow3 = 0; vRow3 < pData_BONUS_ALLOWANCE.OraSelectData.Rows.Count; vRow3++)
                            {
                                vLinePrinting_3 = XLLine_3(pData_BONUS_ALLOWANCE.OraSelectData.Rows[vRow3], vLinePrinting_3, vGDColumn_3, vXLColumn_3); //상여 지급
                            }

                            int vLinePrinting_4 = vPrintingLine + 54;
                            for (int vRow4 = 0; vRow4 < pData_BONUS_DEDUCTION.OraSelectData.Rows.Count; vRow4++)
                            {
                                vLinePrinting_4 = XLLine_4(pData_BONUS_DEDUCTION.OraSelectData.Rows[vRow4], vLinePrinting_4, vGDColumn_4, vXLColumn_4); //상여 공제
                            }

                            int vLinePrinting_5 = vPrintingLine + 31;
                            for (int vRow5 = 0; vRow5 < pData_DUTY_INFO.OraSelectData.Rows.Count; vRow5++)
                            {
                                vLinePrinting_5 = XLLine_5(pData_DUTY_INFO.OraSelectData.Rows[vRow5], vLinePrinting_5, vGDColumn_5, vXLColumn_5); //근무시간 및 부가내역
                            }

                            vPrintingLine = XLLine_6(pGrid_MONTH_PAYMENT, vRow, vPrintingLine, vGDColumn_6, vXLColumn_6, "DAILY"); //Heaer 및 인적사항, 총금액
                        }
                        else
                        {
                            mCopyLineSUM = CopyAndPaste(mPrinting, mCopyLineSUM, "MONTH", pSEAL_FLAG);
                            vPrintingLine = (mCopyLineSUM - mIncrementCopyMAX) + (mPrintingLineSTART - 1);

                            //관리직
                            int vLinePrinting_1 = vPrintingLine + 40;
                            for (int vRow1 = 0; vRow1 < pData_PAY_ALLOWANCE.OraSelectData.Rows.Count; vRow1++)
                            {
                                vLinePrinting_1 = XLLine_1(pData_PAY_ALLOWANCE.OraSelectData.Rows[vRow1], vLinePrinting_1, vGDColumn_1, vXLColumn_1); //급여 지급
                            }

                            int vLinePrinting_2 = vPrintingLine + 40;
                            for (int vRow2 = 0; vRow2 < pData_PAY_DEDUCTION.OraSelectData.Rows.Count; vRow2++)
                            {
                                vLinePrinting_2 = XLLine_2(pData_PAY_DEDUCTION.OraSelectData.Rows[vRow2], vLinePrinting_2, vGDColumn_2, vXLColumn_2); //급여 공제
                            }

                            int vLinePrinting_5 = vPrintingLine + 31;
                            for (int vRow5 = 0; vRow5 < pData_DUTY_INFO.OraSelectData.Rows.Count; vRow5++)
                            {
                                vLinePrinting_5 = XLLine_5(pData_DUTY_INFO.OraSelectData.Rows[vRow5], vLinePrinting_5, vGDColumn_5, vXLColumn_5); //근무시간 및 부가내역
                            }

                            vPrintingLine = XLLine_6(pGrid_MONTH_PAYMENT, vRow, vPrintingLine, vGDColumn_6, vXLColumn_6, "MONTH"); //Heaer 및 인적사항, 총금액
                        }

                        if (pCourse == "PRINT")
                        {
                            if (vTotalRow == vRowCount)
                            {
                                Printing(1, vCountPrinting);
                            }
                            else if (vSecondPrinting < vCountPrinting)
                            {
                                Printing(1, vCountPrinting);

                                mPrinting.XLOpenFileClose();
                                isOpen = XLFileOpen();

                                vCountPrinting = 0;
                                vPrintingLine = 1;
                                mCopyLineSUM = 1;
                            }
                        }
                        else if (pCourse == "PDF")
                        {

                            if (vTotalRow == vRowCount)
                            {
                                PDF_Save(pSaveFileName);
                            }
                            else if (vSecondPrinting < vCountPrinting)
                            {
                                PDF_Save(pSaveFileName);

                                mPrinting.XLOpenFileClose();
                                isOpen = XLFileOpen();

                                vCountPrinting = 0;
                                vPrintingLine = 1;
                                mCopyLineSUM = 1;
                            }
                        }
                        else if (pCourse == "FILE")
                        {
                            if (vTotalRow == vRowCount)
                            {
                                SAVE("PAY_");
                            }
                            else if (vSecondPrinting < vCountPrinting)
                            {
                                SAVE("PAY_");

                                mPrinting.XLOpenFileClose();
                                isOpen = XLFileOpen();

                                vCountPrinting = 0;
                                vPrintingLine = 1;
                                mCopyLineSUM = 1;
                            }
                        }
                        pGrid_MONTH_PAYMENT.SetCellValue(vRow, vIndexCheckBox, "N");
                    }
                }
                else if (vTotalRow == vRowCount)
                {
                    if (isOpen == true)
                    {
                        if (pCourse == "PRINT")
                        {
                            Printing(1, vCountPrinting);
                        }
                        else if (pCourse == "FILE")
                        {
                            SAVE("PAY_");
                        }
                    }
                }
            }

            return mPageNumber;
        }

        #endregion;

        #endregion;

        #region ----- Copy&Paste Sheet Method ----

        //첫번째 페이지 복사
        private int CopyAndPaste(XL.XLPrint pPrinting, int pCopySumPrintingLine, string pCourse, string vSeal_Flag)
        {
            int vCopySumPrintingLine = pCopySumPrintingLine;

            int vCopyPrintingRowSTART = vCopySumPrintingLine;
            vCopySumPrintingLine = vCopySumPrintingLine + mIncrementCopyMAX;
            int vCopyPrintingRowEnd = vCopySumPrintingLine;

            if (pCourse == "DAILY")
            {
                pPrinting.XLActiveSheet("SourceTab1");
                if(vSeal_Flag == "N")
                {
                    mPrinting.XLDeleteBarCode(pIndexImage: 3);
                }
            }
            else if (pCourse == "MONTH")
            {
                pPrinting.XLActiveSheet("SourceTab2");
                if (vSeal_Flag == "N")
                {
                    mPrinting.XLDeleteBarCode(pIndexImage: 3);
                }
            }

            object vRangeSource = pPrinting.XLGetRange(mCopyColumnSTART, 1, mIncrementCopyMAX, mCopyColumnEND); //[원본], [Sheet2.Cell("A1:AS67")], 엑셀 쉬트에서 복사 시작할 행번호, 엑셀 쉬트에서 복사 시작할 열번호, 엑셀 쉬트에서 복사 종료할 행번호, 엑셀 쉬트에서 복사 종료할 열번호
            pPrinting.XLActiveSheet("Destination");
            object vRangeDestination = pPrinting.XLGetRange(vCopyPrintingRowSTART, 1, vCopyPrintingRowEnd, mCopyColumnEND); //[대상], [Sheet1.Cell("A1:AS67")], 엑셀 쉬트에서 복사 시작할 행번호, 엑셀 쉬트에서 복사 시작할 열번호, 엑셀 쉬트에서 복사 종료할 행번호, 엑셀 쉬트에서 복사 종료할 열번호
            pPrinting.XLCopyRange(vRangeSource, vRangeDestination);


            mPageNumber++; //페이지 번호

            return vCopySumPrintingLine;
        }

        #endregion;

        #region ----- Printing Methods ----

        public void Printing(int pPageSTART, int pPageEND)
        {
            mPrinting.XLPrinting(pPageSTART, pPageEND);
        }

        #endregion;

        #region ----- Save Methods ----

        public void SAVE(string pSaveFileName)
        {
            System.IO.DirectoryInfo vWallpaperFolder = new System.IO.DirectoryInfo(Environment.GetFolderPath(Environment.SpecialFolder.DesktopDirectory));

            int vMaxNumber = MaxIncrement(vWallpaperFolder.ToString(), pSaveFileName);
            vMaxNumber = vMaxNumber + 1;
            string vSaveFileName = string.Format("{0}{1:D3}", pSaveFileName, vMaxNumber);

            vSaveFileName = string.Format("{0}\\{1}.xls", vWallpaperFolder.ToString(), vSaveFileName);
            mPrinting.XLSave(vSaveFileName);
        }

        public void PDF_Save(string pSaveFileName)
        {
            if (pSaveFileName == string.Empty)
            {
                return;
            }
            mPrinting.XLDeleteSheet("SourceTab1");
            mPrinting.XLDeleteSheet("SourceTab2");

            ////전호수 주석
            //System.IO.DirectoryInfo vWallpaperFolder = new System.IO.DirectoryInfo(Environment.GetFolderPath(Environment.SpecialFolder.Desktop));

            //int vMaxNumber = MaxIncrement(vWallpaperFolder.ToString(), pSaveFileName);
            //vMaxNumber = vMaxNumber + 1;
            //string vSaveFileName = string.Format("{0}{1:D2}.pdf", pSaveFileName, vMaxNumber);

            //vSaveFileName = string.Format("{0}\\{1}.pdf", vWallpaperFolder, vSaveFileName);

            mPrinting.XLSaveAs_PDF(pSaveFileName);
            //mPrinting.XLSave(vSaveFileName);
        }

        #endregion;
    }
}