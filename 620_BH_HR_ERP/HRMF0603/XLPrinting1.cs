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

namespace HRMF0603
{
    public class XLPrinting1
    {
        #region ----- Variables -----

        ISFunction.ISConvert iString = new ISFunction.ISConvert();
        ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        private InfoSummit.Win.ControlAdv.ISAppInterface mAppInterface = null;
        private InfoSummit.Win.ControlAdv.ISMessageAdapter mMessageAdapter = null;

        private XL.XLPrint mPrinting = null;

        private string mMessageError = string.Empty;

        private int mPageNumber = 0;

        private string mXLOpenFileName = string.Empty;

        private int mPrintingLineSTART = 6;  //Line

        private int mCopyLineSUM = 1;        //엑셀의 선택된 쉬트의 복사되어질 시작 행 위치, 복사 행 누적
        private int mIncrementCopyMAX = 43; //복사되어질 행의 범위

        private int mCopyColumnSTART = 1;    //복사되어  진 행 누적 수
        private int mCopyColumnEND = 50;     //엑셀의 선택된 쉬트의 복사되어질 끝 열 위치

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

        public XLPrinting1(InfoSummit.Win.ControlAdv.ISAppInterface pAppInterface, InfoSummit.Win.ControlAdv.ISMessageAdapter pMessageAdapter)
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

        #region ----- Array Set 1 ----

        private void SetArray1(InfoSummit.Win.ControlAdv.ISGridAdvEx pGrid_RETIRE_ADJUSTMENT, out int[] pGDColumn, out int[] pXLColumn)
        {
            pGDColumn = new int[50];
            pXLColumn = new int[50];

            pGDColumn[00] = pGrid_RETIRE_ADJUSTMENT.GetColumnToIndex("PERSON_NUM");              // 사번
            pGDColumn[01] = pGrid_RETIRE_ADJUSTMENT.GetColumnToIndex("NAME");                    // 성명
            pGDColumn[02] = pGrid_RETIRE_ADJUSTMENT.GetColumnToIndex("REPRE_NUM");               // 주민번호
            pGDColumn[03] = pGrid_RETIRE_ADJUSTMENT.GetColumnToIndex("POST_NAME");               // 직책
            pGDColumn[04] = pGrid_RETIRE_ADJUSTMENT.GetColumnToIndex("OPERATING_UNIT_NAME");     // 사업장
            pGDColumn[05] = pGrid_RETIRE_ADJUSTMENT.GetColumnToIndex("DEPT_NAME");               // 부서
            pGDColumn[06] = pGrid_RETIRE_ADJUSTMENT.GetColumnToIndex("ADDR");                    // 주소
            pGDColumn[07] = pGrid_RETIRE_ADJUSTMENT.GetColumnToIndex("JOIN_DATE");               // 입사일
            pGDColumn[08] = pGrid_RETIRE_ADJUSTMENT.GetColumnToIndex("EXPIRE_DATE");             // 중도정산일
            pGDColumn[09] = pGrid_RETIRE_ADJUSTMENT.GetColumnToIndex("RETIRE_DATE");             // 퇴사일
            pGDColumn[10] = pGrid_RETIRE_ADJUSTMENT.GetColumnToIndex("CLOSED_DATE");             // 지급일
            pGDColumn[11] = pGrid_RETIRE_ADJUSTMENT.GetColumnToIndex("CONTINUE_DAY");            // 근속기간
            pGDColumn[12] = pGrid_RETIRE_ADJUSTMENT.GetColumnToIndex("DED_DAY");                 // 휴직기간
            pGDColumn[13] = pGrid_RETIRE_ADJUSTMENT.GetColumnToIndex("BANK_ACCOUNTS");           // 계좌번호

            pGDColumn[14] = pGrid_RETIRE_ADJUSTMENT.GetColumnToIndex("TOTAL_PAY_AMOUNT");        // 산정급여
            pGDColumn[15] = pGrid_RETIRE_ADJUSTMENT.GetColumnToIndex("ETC_PAY_AMOUNT");          // 산정상여/연차
            pGDColumn[16] = pGrid_RETIRE_ADJUSTMENT.GetColumnToIndex("TOTAL_SUM_AMOUNT");        // 합계
            pGDColumn[17] = pGrid_RETIRE_ADJUSTMENT.GetColumnToIndex("DAY_AVG_AMOUNT");          // 평균임금
            pGDColumn[18] = pGrid_RETIRE_ADJUSTMENT.GetColumnToIndex("RETIRE_AMOUNT");           // 퇴직금

            pGDColumn[19] = pGrid_RETIRE_ADJUSTMENT.GetColumnToIndex("START_DATE1");             // 시작 날짜1
            pGDColumn[20] = pGrid_RETIRE_ADJUSTMENT.GetColumnToIndex("START_DATE2");             // 시작 날짜2
            pGDColumn[21] = pGrid_RETIRE_ADJUSTMENT.GetColumnToIndex("START_DATE3");             // 시작 날짜3
            pGDColumn[22] = pGrid_RETIRE_ADJUSTMENT.GetColumnToIndex("START_DATE4");             // 시작 날짜4
            pGDColumn[23] = pGrid_RETIRE_ADJUSTMENT.GetColumnToIndex("END_DATE1");               // 마지막 날짜1
            pGDColumn[24] = pGrid_RETIRE_ADJUSTMENT.GetColumnToIndex("END_DATE2");               // 마지막 날짜2
            pGDColumn[25] = pGrid_RETIRE_ADJUSTMENT.GetColumnToIndex("END_DATE3");               // 마지막 날짜3
            pGDColumn[26] = pGrid_RETIRE_ADJUSTMENT.GetColumnToIndex("END_DATE4");               // 마지막 날짜4
            pGDColumn[27] = pGrid_RETIRE_ADJUSTMENT.GetColumnToIndex("DAY1");                    // 근무일수1
            pGDColumn[28] = pGrid_RETIRE_ADJUSTMENT.GetColumnToIndex("DAY2");                    // 근무일수2
            pGDColumn[29] = pGrid_RETIRE_ADJUSTMENT.GetColumnToIndex("DAY3");                    // 근무일수3
            pGDColumn[30] = pGrid_RETIRE_ADJUSTMENT.GetColumnToIndex("DAY4");                    // 근무일수4
            pGDColumn[31] = pGrid_RETIRE_ADJUSTMENT.GetColumnToIndex("DAY_SUM");                 // 합계[근무일수]

            pGDColumn[32] = pGrid_RETIRE_ADJUSTMENT.GetColumnToIndex("RETIRE_AMOUNT");           // 퇴직금
            pGDColumn[33] = pGrid_RETIRE_ADJUSTMENT.GetColumnToIndex("INCOME_TAX_AMOUNT");       // 소득세[퇴직소득세]
            pGDColumn[34] = pGrid_RETIRE_ADJUSTMENT.GetColumnToIndex("RETIRE_INSUR_AMOUNT");     // 단체퇴직보험금
            pGDColumn[35] = pGrid_RETIRE_ADJUSTMENT.GetColumnToIndex("RESIDENT_TAX_AMOUNT");     // 주민세[퇴직지방소득세]
            pGDColumn[36] = pGrid_RETIRE_ADJUSTMENT.GetColumnToIndex("HONORARY_AMOUNT");         // 명예퇴직수당등
            pGDColumn[37] = pGrid_RETIRE_ADJUSTMENT.GetColumnToIndex("HEALTH_INSUR_AMOUNT");     // 건강보험정산
            pGDColumn[38] = pGrid_RETIRE_ADJUSTMENT.GetColumnToIndex("RETIRE_PENSION_AMOUNT");   // 퇴직연금
            pGDColumn[39] = pGrid_RETIRE_ADJUSTMENT.GetColumnToIndex("ETC_DED_AMOUNT");          // 기타공제
            pGDColumn[40] = pGrid_RETIRE_ADJUSTMENT.GetColumnToIndex("TAX_FREE_AMOUNT");         // 비과세소득
            pGDColumn[41] = pGrid_RETIRE_ADJUSTMENT.GetColumnToIndex("");                        //
            pGDColumn[42] = pGrid_RETIRE_ADJUSTMENT.GetColumnToIndex("TOTAL_HONORARY_AMOUNT_2"); // 기타지급
            pGDColumn[43] = pGrid_RETIRE_ADJUSTMENT.GetColumnToIndex("");                        //
            pGDColumn[44] = pGrid_RETIRE_ADJUSTMENT.GetColumnToIndex("RETIRE_TOTAL_AMOUNT");     // 지급총액
            pGDColumn[45] = pGrid_RETIRE_ADJUSTMENT.GetColumnToIndex("DED_TOTAL_AMOUNT");        // 공제총액
            pGDColumn[46] = pGrid_RETIRE_ADJUSTMENT.GetColumnToIndex("");                        //
            pGDColumn[47] = pGrid_RETIRE_ADJUSTMENT.GetColumnToIndex("REAL_TOTAL_AMOUNT");       // 차인지급액
            pGDColumn[48] = pGrid_RETIRE_ADJUSTMENT.GetColumnToIndex("PRINT_DATE");              // 인쇄일시
            pGDColumn[49] = pGrid_RETIRE_ADJUSTMENT.GetColumnToIndex("NAME1");                   // 영수인

            //---------------------------------------------------------------------------------------------------------------------

            pXLColumn[00] = 7;  // 사번
            pXLColumn[01] = 21; // 성명
            pXLColumn[02] = 32; // 주민번호
            pXLColumn[03] = 44; // 직책
            pXLColumn[04] = 7;  // 사업장
            pXLColumn[05] = 21; // 부서
            pXLColumn[06] = 32; // 주소
            pXLColumn[07] = 7;  // 입사일
            pXLColumn[08] = 21; // 최초입사일
            pXLColumn[09] = 32; // 퇴사일
            pXLColumn[10] = 44; // 지급일
            pXLColumn[11] = 7;  // 근속기간
            pXLColumn[12] = 21; // 휴직기간
            pXLColumn[13] = 32; // 계좌번호

            pXLColumn[14] = 2;  // 산정급여
            pXLColumn[15] = 11; // 산정상여/연차
            pXLColumn[16] = 20; // 합계
            pXLColumn[17] = 31; // 평균임금
            pXLColumn[18] = 40; // 퇴직급

            pXLColumn[19] = 9;  // 시작 날짜1
            pXLColumn[20] = 17; // 시작 날짜2
            pXLColumn[21] = 25; // 시작 날짜3
            pXLColumn[22] = 33; // 시작 날짜4
            pXLColumn[23] = 9;  // 마지막 날짜1
            pXLColumn[24] = 17; // 마지막 날짜2
            pXLColumn[25] = 25; // 마지막 날짜3
            pXLColumn[26] = 33; // 마지막 날짜4
            pXLColumn[27] = 9;  // 근무일수1
            pXLColumn[28] = 17; // 근무일수2
            pXLColumn[29] = 25; // 근무일수3
            pXLColumn[30] = 33; // 근무일수4
            pXLColumn[31] = 41; // 합계[근무일수]

            pXLColumn[32] = 14; // 퇴직금
            pXLColumn[33] = 38; // 소득세[퇴직소득세]
            pXLColumn[34] = 14; // 단체퇴직보험금
            pXLColumn[35] = 38; // 주민세[퇴직지방소득세]
            pXLColumn[36] = 14; // 명예퇴직수당등
            pXLColumn[37] = 38; // 건강보험정산
            pXLColumn[38] = 14; // 퇴직연금
            pXLColumn[39] = 38; // 기타공제
            pXLColumn[40] = 14; // 비과세소득
            pXLColumn[41] = 38; //
            pXLColumn[42] = 14; // 기타지급
            pXLColumn[43] = 38; //
            pXLColumn[44] = 14; // 지급총액
            pXLColumn[45] = 38; // 공제총액
            pXLColumn[46] = 14; //
            pXLColumn[47] = 38; // 차인지급액
            pXLColumn[48] = 38; // 인쇄일시
            pXLColumn[49] = 38; // 영수인
        }

        #endregion;

        #region ----- Array Set 2 ----

        private void SetArray2(System.Data.DataTable pTable, out int[] pGDColumn, out int[] pXLColumn)
        {
            pGDColumn = new int[11];
            pXLColumn = new int[5];

            pGDColumn[00] = pTable.Columns.IndexOf("A01");           // 기본급
            pGDColumn[01] = pTable.Columns.IndexOf("A26");           // 주휴수당
            pGDColumn[02] = pTable.Columns.IndexOf("A02");           // 직책수당
            pGDColumn[03] = pTable.Columns.IndexOf("A31");           // 복지수당
            pGDColumn[04] = pTable.Columns.IndexOf("A03");           // 근속수당
            pGDColumn[05] = pTable.Columns.IndexOf("A13");           // 야간수당
            pGDColumn[06] = pTable.Columns.IndexOf("A14");           // 특근수당
            pGDColumn[07] = pTable.Columns.IndexOf("A12");           // 연장수당
            pGDColumn[08] = pTable.Columns.IndexOf("A19");           // 통신보조금
            pGDColumn[09] = pTable.Columns.IndexOf("A_ETC");         // 그외급여항목
            pGDColumn[10] = pTable.Columns.IndexOf("TOTAL_AMOUNT");  // 합계

            //----------------------------------------------------------------------------

            pXLColumn[00] = 9;  // 1
            pXLColumn[01] = 17; // 2
            pXLColumn[02] = 25; // 3
            pXLColumn[03] = 33; // 4
            pXLColumn[04] = 41; // 합계
        }

        #endregion;

        #region ----- Line Write Method 1 -----

        private int XLLine1(InfoSummit.Win.ControlAdv.ISGridAdvEx pGrid_RETIRE_ADJUSTMENT, int pGridRow, int pXLine, int[] pGDColumn, int[] pXLColumn, string pCourse)
        {
            int vXLine = pXLine; // 엑셀에 내용이 표시되는 행 번호

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

                #region ----- [00] ~ [13] -----

                // 사번
                vGDColumnIndex = pGDColumn[0];
                vXLColumnIndex = pXLColumn[0];
                vObject = pGrid_RETIRE_ADJUSTMENT.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0}", vConvertString);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    //vConvertString = "[00]";
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 성명
                vGDColumnIndex = pGDColumn[1];
                vXLColumnIndex = pXLColumn[1];
                vObject = pGrid_RETIRE_ADJUSTMENT.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0}", vConvertString);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    //vConvertString = "[01]";
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 주민번호
                vGDColumnIndex = pGDColumn[2];
                vXLColumnIndex = pXLColumn[2];
                vObject = pGrid_RETIRE_ADJUSTMENT.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0}", vConvertString);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    //vConvertString = "[02]";
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 직책
                vGDColumnIndex = pGDColumn[3];
                vXLColumnIndex = pXLColumn[3];
                vObject = pGrid_RETIRE_ADJUSTMENT.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0}", vConvertString);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    //vConvertString = "[03]";
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                //-------------------------------------------------------------------
                vXLine = vXLine + 1;
                //-------------------------------------------------------------------

                // 사업장
                vGDColumnIndex = pGDColumn[4];
                vXLColumnIndex = pXLColumn[4];
                vObject = pGrid_RETIRE_ADJUSTMENT.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0}", vConvertString);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    //vConvertString = "[04]";
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 부서
                vGDColumnIndex = pGDColumn[5];
                vXLColumnIndex = pXLColumn[5];
                vObject = pGrid_RETIRE_ADJUSTMENT.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0}", vConvertString);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    //vConvertString = "[05]";
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 주소
                vGDColumnIndex = pGDColumn[6];
                vXLColumnIndex = pXLColumn[6];
                vObject = pGrid_RETIRE_ADJUSTMENT.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0}", vConvertString);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    //vConvertString = "[06]";
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                //-------------------------------------------------------------------
                vXLine = vXLine + 1;
                //-------------------------------------------------------------------

                // 입사일
                vGDColumnIndex = pGDColumn[7];
                vXLColumnIndex = pXLColumn[7];
                vObject = pGrid_RETIRE_ADJUSTMENT.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertDate(vObject, out vConvertDateTime);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0}", vConvertDateTime.ToShortDateString());
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    //vConvertString = "[07]";
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 중도정산일
                vGDColumnIndex = pGDColumn[8];
                vXLColumnIndex = pXLColumn[8];
                vObject = pGrid_RETIRE_ADJUSTMENT.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertDate(vObject, out vConvertDateTime);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0}", vConvertDateTime.ToShortDateString());
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    //vConvertString = "[08]";
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 퇴사일
                vGDColumnIndex = pGDColumn[9];
                vXLColumnIndex = pXLColumn[9];
                vObject = pGrid_RETIRE_ADJUSTMENT.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertDate(vObject, out vConvertDateTime);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0}", vConvertDateTime.ToShortDateString());
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    //vConvertString = "[09]";
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 지급일
                vGDColumnIndex = pGDColumn[10];
                vXLColumnIndex = pXLColumn[10];
                vObject = pGrid_RETIRE_ADJUSTMENT.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertDate(vObject, out vConvertDateTime);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0}", vConvertDateTime.ToShortDateString());
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    //vConvertString = "[10]";
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                //-------------------------------------------------------------------
                vXLine = vXLine + 1;
                //-------------------------------------------------------------------

                // 근속기간
                vGDColumnIndex = pGDColumn[11];
                vXLColumnIndex = pXLColumn[11];
                vObject = pGrid_RETIRE_ADJUSTMENT.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0}", vConvertString);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    //vConvertString = "[11]";
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 휴직기간
                vGDColumnIndex = pGDColumn[12];
                vXLColumnIndex = pXLColumn[12];
                vObject = pGrid_RETIRE_ADJUSTMENT.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,###}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    //vConvertString = "[12]";
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 계좌번호
                vGDColumnIndex = pGDColumn[13];
                vXLColumnIndex = pXLColumn[13];
                vObject = pGrid_RETIRE_ADJUSTMENT.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0}", vConvertString);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    //vConvertString = "[13]";
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                #endregion;

                //-------------------------------------------------------------------
                vXLine = vXLine + 4;
                //-------------------------------------------------------------------

                #region ----- [14] ~ [18] -----

                // 산정급여
                vGDColumnIndex = pGDColumn[14];
                vXLColumnIndex = pXLColumn[14];
                vObject = pGrid_RETIRE_ADJUSTMENT.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,###}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    //vConvertString = "[14]";
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 산정상여/연차
                vGDColumnIndex = pGDColumn[15];
                vXLColumnIndex = pXLColumn[15];
                vObject = pGrid_RETIRE_ADJUSTMENT.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,###}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    //vConvertString = "[15]";
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 합계
                vGDColumnIndex = pGDColumn[16];
                vXLColumnIndex = pXLColumn[16];
                vObject = pGrid_RETIRE_ADJUSTMENT.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,###}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    //vConvertString = "[16]";
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 평균임금
                vGDColumnIndex = pGDColumn[17];
                vXLColumnIndex = pXLColumn[17];
                vObject = pGrid_RETIRE_ADJUSTMENT.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,###}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    //vConvertString = "[17]";
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 퇴직금
                vGDColumnIndex = pGDColumn[18];
                vXLColumnIndex = pXLColumn[18];
                vObject = pGrid_RETIRE_ADJUSTMENT.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,###}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    //vConvertString = "[18]";
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                #endregion;

                //-------------------------------------------------------------------
                vXLine = vXLine + 2;
                //-------------------------------------------------------------------

                #region ----- [19] ~ [31] -----

                // 시작 날짜 1
                vGDColumnIndex = pGDColumn[19];
                vXLColumnIndex = pXLColumn[19];
                vObject = pGrid_RETIRE_ADJUSTMENT.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertDate(vObject, out vConvertDateTime);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0}", vConvertDateTime.ToShortDateString());
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    //vConvertString = "[19]";
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 시작 날짜 2
                vGDColumnIndex = pGDColumn[20];
                vXLColumnIndex = pXLColumn[20];
                vObject = pGrid_RETIRE_ADJUSTMENT.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertDate(vObject, out vConvertDateTime);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0}", vConvertDateTime.ToShortDateString());
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    //vConvertString = "[20]";
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 시작 날짜 3
                vGDColumnIndex = pGDColumn[21];
                vXLColumnIndex = pXLColumn[21];
                vObject = pGrid_RETIRE_ADJUSTMENT.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertDate(vObject, out vConvertDateTime);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0}", vConvertDateTime.ToShortDateString());
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    //vConvertString = "[21]";
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 시작 날짜 4
                vGDColumnIndex = pGDColumn[22];
                vXLColumnIndex = pXLColumn[22];
                vObject = pGrid_RETIRE_ADJUSTMENT.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertDate(vObject, out vConvertDateTime);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0}", vConvertDateTime.ToShortDateString());
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    //vConvertString = "[22]";
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                //-------------------------------------------------------------------
                vXLine = vXLine + 1;
                //-------------------------------------------------------------------

                // 마지막 날짜 1
                vGDColumnIndex = pGDColumn[23];
                vXLColumnIndex = pXLColumn[23];
                vObject = pGrid_RETIRE_ADJUSTMENT.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertDate(vObject, out vConvertDateTime);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0}", vConvertDateTime.ToShortDateString());
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    //vConvertString = "[23]";
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 마지막 날짜 2
                vGDColumnIndex = pGDColumn[24];
                vXLColumnIndex = pXLColumn[24];
                vObject = pGrid_RETIRE_ADJUSTMENT.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertDate(vObject, out vConvertDateTime);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0}", vConvertDateTime.ToShortDateString());
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    //vConvertString = "[24]";
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 마지막 날짜 3
                vGDColumnIndex = pGDColumn[25];
                vXLColumnIndex = pXLColumn[25];
                vObject = pGrid_RETIRE_ADJUSTMENT.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertDate(vObject, out vConvertDateTime);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0}", vConvertDateTime.ToShortDateString());
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    //vConvertString = "[25]";
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 마지막 날짜 4
                vGDColumnIndex = pGDColumn[26];
                vXLColumnIndex = pXLColumn[26];
                vObject = pGrid_RETIRE_ADJUSTMENT.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertDate(vObject, out vConvertDateTime);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0}", vConvertDateTime.ToShortDateString());
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    //vConvertString = "[26]";
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                //-------------------------------------------------------------------
                vXLine = vXLine + 1;
                //-------------------------------------------------------------------

                // 근무일수 1
                vGDColumnIndex = pGDColumn[27];
                vXLColumnIndex = pXLColumn[27];
                vObject = pGrid_RETIRE_ADJUSTMENT.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,###}일", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    //vConvertString = "[27]";
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 근무일수 2
                vGDColumnIndex = pGDColumn[28];
                vXLColumnIndex = pXLColumn[28];
                vObject = pGrid_RETIRE_ADJUSTMENT.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,###}일", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    //vConvertString = "[28]";
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 근무일수 3
                vGDColumnIndex = pGDColumn[29];
                vXLColumnIndex = pXLColumn[29];
                vObject = pGrid_RETIRE_ADJUSTMENT.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,###}일", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    //vConvertString = "[29]";
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 근무일수 4
                vGDColumnIndex = pGDColumn[30];
                vXLColumnIndex = pXLColumn[30];
                vObject = pGrid_RETIRE_ADJUSTMENT.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,###}일", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    //vConvertString = "[30]";
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 합계[근무일수]
                vGDColumnIndex = pGDColumn[31];
                vXLColumnIndex = pXLColumn[31];
                vObject = pGrid_RETIRE_ADJUSTMENT.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,###}일", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    //vConvertString = "[31]";
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                #endregion;

                //-------------------------------------------------------------------
                vXLine = vXLine + 16;
                //-------------------------------------------------------------------

                #region ----- [32] ~ [49] -----

                // 퇴직금
                vGDColumnIndex = pGDColumn[32];
                vXLColumnIndex = pXLColumn[32];
                vObject = pGrid_RETIRE_ADJUSTMENT.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,###}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    //vConvertString = "[32]";
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 소득세[퇴직소득세]
                vGDColumnIndex = pGDColumn[33];
                vXLColumnIndex = pXLColumn[33];
                vObject = pGrid_RETIRE_ADJUSTMENT.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,###}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    //vConvertString = "[33]";
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                //-------------------------------------------------------------------
                vXLine = vXLine + 1;
                //-------------------------------------------------------------------

                // 단체퇴직보험금
                vGDColumnIndex = pGDColumn[34];
                vXLColumnIndex = pXLColumn[34];
                vObject = pGrid_RETIRE_ADJUSTMENT.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0}", vConvertString);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    //vConvertString = "[34]";
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 주민세[퇴직지방소득세]
                vGDColumnIndex = pGDColumn[35];
                vXLColumnIndex = pXLColumn[35];
                vObject = pGrid_RETIRE_ADJUSTMENT.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,###}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    //vConvertString = "[35]";
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                //-------------------------------------------------------------------
                vXLine = vXLine + 1;
                //-------------------------------------------------------------------

                // 명예퇴직수당등
                vGDColumnIndex = pGDColumn[36];
                vXLColumnIndex = pXLColumn[36];
                vObject = pGrid_RETIRE_ADJUSTMENT.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,###}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    //vConvertString = "[36]";
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 건강보험정산
                vGDColumnIndex = pGDColumn[37];
                vXLColumnIndex = pXLColumn[37];
                vObject = pGrid_RETIRE_ADJUSTMENT.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,###}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    //vConvertString = "[37]";
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                //-------------------------------------------------------------------
                vXLine = vXLine + 1;
                //-------------------------------------------------------------------

                // 퇴직연금
                vGDColumnIndex = pGDColumn[38];
                vXLColumnIndex = pXLColumn[38];
                vObject = pGrid_RETIRE_ADJUSTMENT.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0}", vConvertString);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    //vConvertString = "[38]";
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 기타공제
                vGDColumnIndex = pGDColumn[39];
                vXLColumnIndex = pXLColumn[39];
                vObject = pGrid_RETIRE_ADJUSTMENT.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,###}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    //vConvertString = "[39]";
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                //-------------------------------------------------------------------
                vXLine = vXLine + 1;
                //-------------------------------------------------------------------

                // 비과세소득
                vGDColumnIndex = pGDColumn[40];
                vXLColumnIndex = pXLColumn[40];
                vObject = pGrid_RETIRE_ADJUSTMENT.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0}", vConvertString);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    //vConvertString = "[40]";
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // X
                vGDColumnIndex = pGDColumn[41];
                vXLColumnIndex = pXLColumn[41];
                //vObject = pGrid_RETIRE_ADJUSTMENT.GetCellValue(pGridRow, vGDColumnIndex);
                vObject = null;

                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0}", vConvertString);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    //vConvertString = "[41]";
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                //-------------------------------------------------------------------
                vXLine = vXLine + 1;
                //-------------------------------------------------------------------
                // 기타지급
                vGDColumnIndex = pGDColumn[42];
                vXLColumnIndex = pXLColumn[42];
                vObject = pGrid_RETIRE_ADJUSTMENT.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,###}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    //vConvertString = "[42]";
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // X
                vGDColumnIndex = pGDColumn[43];
                vXLColumnIndex = pXLColumn[43];
                //vObject = pGrid_RETIRE_ADJUSTMENT.GetCellValue(pGridRow, vGDColumnIndex);
                vObject = null;

                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0}", vConvertString);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    //vConvertString = "[43]";
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                //-------------------------------------------------------------------
                vXLine = vXLine + 1;
                //-------------------------------------------------------------------

                // 지급총액
                vGDColumnIndex = pGDColumn[44];
                vXLColumnIndex = pXLColumn[44];
                vObject = pGrid_RETIRE_ADJUSTMENT.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,###}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    //vConvertString = "[44]";
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 공제총액
                vGDColumnIndex = pGDColumn[45];
                vXLColumnIndex = pXLColumn[45];
                vObject = pGrid_RETIRE_ADJUSTMENT.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,###}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    //vConvertString = "[45]";
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                //-------------------------------------------------------------------
                vXLine = vXLine + 1;
                //-------------------------------------------------------------------

                // X
                vGDColumnIndex = pGDColumn[46];
                vXLColumnIndex = pXLColumn[46];
                //vObject = pGrid_RETIRE_ADJUSTMENT.GetCellValue(pGridRow, vGDColumnIndex);
                vObject = null;

                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0}", vConvertString);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    //vConvertString = "[46]";
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                // 차인지급액
                vGDColumnIndex = pGDColumn[47];
                vXLColumnIndex = pXLColumn[47];
                vObject = pGrid_RETIRE_ADJUSTMENT.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,###}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    //vConvertString = "[47]";
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                //-------------------------------------------------------------------
                vXLine = vXLine + 1;
                //-------------------------------------------------------------------

                // 인쇄일시
                vGDColumnIndex = pGDColumn[48];
                vXLColumnIndex = pXLColumn[48];
                vObject = pGrid_RETIRE_ADJUSTMENT.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0}", vConvertString);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    //vConvertString = "[48]";
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                //-------------------------------------------------------------------
                vXLine = vXLine + 1;
                //-------------------------------------------------------------------

                // 영수인
                vGDColumnIndex = pGDColumn[49];
                vXLColumnIndex = pXLColumn[49];
                vObject = pGrid_RETIRE_ADJUSTMENT.GetCellValue(pGridRow, vGDColumnIndex);

                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0} (인)", vConvertString);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    //vConvertString = "[49]";
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
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

            pXLine = vXLine;

            return pXLine;
        }

        #endregion;

        #region ----- Line Write Method 2 -----

        private void XLLine2(System.Data.DataTable pTable, int pXLine, int[] pGDColumn, int[] pXLColumn, int pColumn)
        {
            int vXLine = pXLine; // 엑셀에 내용이 표시되는 행 번호

            int vGDColumnIndex = 0;
            int vXLColumnIndex = 0;

            object vObject = null;
            string vConvertString = string.Empty;
            decimal vConvertDecimal = 0m;
            bool IsConvert = false;

            try
            {
                if (pTable == null && pTable.Rows == null)
                {
                    return;
                }

                if (pTable.Rows.Count < 1)
                {
                    return;
                }

                mPrinting.XLActiveSheet("Destination");

                // 기본급
                vGDColumnIndex = pGDColumn[0];
                vXLColumnIndex = pXLColumn[pColumn];
                vObject = pTable.Rows[0][vGDColumnIndex];
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

                //-------------------------------------------------------------------
                vXLine = vXLine + 1;
                //-------------------------------------------------------------------

                // 주휴수당
                vGDColumnIndex = pGDColumn[1];
                vXLColumnIndex = pXLColumn[pColumn];
                vObject = pTable.Rows[0][vGDColumnIndex];
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

                //-------------------------------------------------------------------
                vXLine = vXLine + 1;
                //-------------------------------------------------------------------

                // 직책수당
                vGDColumnIndex = pGDColumn[2];
                vXLColumnIndex = pXLColumn[pColumn];
                vObject = pTable.Rows[0][vGDColumnIndex];
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

                //-------------------------------------------------------------------
                vXLine = vXLine + 1;
                //-------------------------------------------------------------------

                // 복지수당
                vGDColumnIndex = pGDColumn[3];
                vXLColumnIndex = pXLColumn[pColumn];
                vObject = pTable.Rows[0][vGDColumnIndex];
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

                //-------------------------------------------------------------------
                vXLine = vXLine + 1;
                //-------------------------------------------------------------------

                // 근속수당
                vGDColumnIndex = pGDColumn[4];
                vXLColumnIndex = pXLColumn[pColumn];
                vObject = pTable.Rows[0][vGDColumnIndex];
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

                //-------------------------------------------------------------------
                vXLine = vXLine + 1;
                //-------------------------------------------------------------------

                // 야간수당
                vGDColumnIndex = pGDColumn[5];
                vXLColumnIndex = pXLColumn[pColumn];
                vObject = pTable.Rows[0][vGDColumnIndex];
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

                //-------------------------------------------------------------------
                vXLine = vXLine + 1;
                //-------------------------------------------------------------------

                // 특근수당
                vGDColumnIndex = pGDColumn[6];
                vXLColumnIndex = pXLColumn[pColumn];
                vObject = pTable.Rows[0][vGDColumnIndex];
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

                //-------------------------------------------------------------------
                vXLine = vXLine + 1;
                //-------------------------------------------------------------------

                // 연장수당
                vGDColumnIndex = pGDColumn[7];
                vXLColumnIndex = pXLColumn[pColumn];
                vObject = pTable.Rows[0][vGDColumnIndex];
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

                //-------------------------------------------------------------------
                vXLine = vXLine + 1;
                //-------------------------------------------------------------------

                // 통신보조금
                vGDColumnIndex = pGDColumn[8];
                vXLColumnIndex = pXLColumn[pColumn];
                vObject = pTable.Rows[0][vGDColumnIndex];
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

                //-------------------------------------------------------------------
                vXLine = vXLine + 1;
                //-------------------------------------------------------------------

                // 그외급여항목
                vGDColumnIndex = pGDColumn[9];
                vXLColumnIndex = pXLColumn[pColumn];
                vObject = pTable.Rows[0][vGDColumnIndex];
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

                //-------------------------------------------------------------------
                vXLine = vXLine + 1;
                //-------------------------------------------------------------------

                // 합계
                vGDColumnIndex = pGDColumn[10];
                vXLColumnIndex = pXLColumn[pColumn];
                vObject = pTable.Rows[0][vGDColumnIndex];
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
        }

        #endregion;

        #region ----- Excel Write RetireAdjustment  Method ----

        public int WriteRetireAdjustment(InfoSummit.Win.ControlAdv.ISGridAdvEx pGrid_RETIRE_ADJUSTMENT, InfoSummit.Win.ControlAdv.ISDataAdapter pida_DETAIL_RETIRE_PAYMENT, InfoSummit.Win.ControlAdv.ISDataAdapter pida_SUM_RETIRE_PAYMENT, string pOutChoice)
        {
            mAppInterface.OnAppMessageEvent("XL File Open...");
            System.Windows.Forms.Application.DoEvents();

            bool isOpen = XLFileOpen();

            string vMessageText = string.Empty;
            mCopyLineSUM = 1;
            mPageNumber = 0;

            int[] vGDColumn;
            int[] vXLColumn;

            int vTotalRow = pGrid_RETIRE_ADJUSTMENT.RowCount;
            int vRowCount = 0;

            int vPrintingLine = 0;

            int vSecondPrinting = 9; //1인당 3페이지이므로, 3*10=30번째에 인쇄
            int vCountPrinting = 0;

            object vObject_YYYYMM = null;
            int vLinePrinting = 0; //3. 퇴직금 선정내역 인쇄 시작 행
            bool IsConvert = false;
            string vConvertString = string.Empty;
            for (int vRow = 0; vRow < vTotalRow; vRow++)
            {
                vRowCount++;
                pGrid_RETIRE_ADJUSTMENT.Cursor = System.Windows.Forms.Cursors.WaitCursor;

                vMessageText = string.Format("Printing : {0}/{1}", vRowCount, vTotalRow);
                mAppInterface.OnAppMessageEvent(vMessageText);
                System.Windows.Forms.Application.DoEvents();

                if (isOpen == true)
                {
                    vCountPrinting++;

                    mCopyLineSUM = CopyAndPaste(mPrinting, mCopyLineSUM, "SRC_TAB1");
                    vPrintingLine = (mCopyLineSUM - mIncrementCopyMAX) + (mPrintingLineSTART - 1);

                    pGrid_RETIRE_ADJUSTMENT.CurrentCellMoveTo(vRow, 0);
                    pGrid_RETIRE_ADJUSTMENT.Focus();
                    pGrid_RETIRE_ADJUSTMENT.CurrentCellActivate(vRow, 0);

                    //---------------------------------------------------------------------------------------------------------
                    // 1. 퇴직금 인적사항 / 3. 퇴직금 정산내역
                    //---------------------------------------------------------------
                    SetArray1(pGrid_RETIRE_ADJUSTMENT, out vGDColumn, out vXLColumn);
                    //---------------------------------------------------------------

                    vPrintingLine = XLLine1(pGrid_RETIRE_ADJUSTMENT, vRow, vPrintingLine, vGDColumn, vXLColumn, "SRC_TAB1");

                    //---------------------------------------------------------------------------------------------------------
                    // 3. 퇴직금 선정내역
                    vLinePrinting = vPrintingLine - 25;
                    //---------------------------------------------------------------
                    SetArray2(pida_DETAIL_RETIRE_PAYMENT.OraSelectData, out vGDColumn, out vXLColumn);
                    //---------------------------------------------------------------
                    vObject_YYYYMM = pGrid_RETIRE_ADJUSTMENT.GetCellValue("PAY_YYYYMM1");
                    IsConvert = IsConvertString(vObject_YYYYMM, out vConvertString);
                    if (IsConvert == true)
                    {
                        pida_DETAIL_RETIRE_PAYMENT.SetSelectParamValue("W_PAY_YYYYMM", vConvertString);
                        pida_DETAIL_RETIRE_PAYMENT.Fill();

                        XLLine2(pida_DETAIL_RETIRE_PAYMENT.OraSelectData, vLinePrinting, vGDColumn, vXLColumn, 0);
                    }

                    vObject_YYYYMM = pGrid_RETIRE_ADJUSTMENT.GetCellValue("PAY_YYYYMM2");
                    IsConvert = IsConvertString(vObject_YYYYMM, out vConvertString);
                    if (IsConvert == true)
                    {
                        pida_DETAIL_RETIRE_PAYMENT.SetSelectParamValue("W_PAY_YYYYMM", vConvertString);
                        pida_DETAIL_RETIRE_PAYMENT.Fill();

                        XLLine2(pida_DETAIL_RETIRE_PAYMENT.OraSelectData, vLinePrinting, vGDColumn, vXLColumn, 1);
                    }

                    vObject_YYYYMM = pGrid_RETIRE_ADJUSTMENT.GetCellValue("PAY_YYYYMM3");
                    IsConvert = IsConvertString(vObject_YYYYMM, out vConvertString);
                    if (IsConvert == true)
                    {
                        pida_DETAIL_RETIRE_PAYMENT.SetSelectParamValue("W_PAY_YYYYMM", vConvertString);
                        pida_DETAIL_RETIRE_PAYMENT.Fill();

                        XLLine2(pida_DETAIL_RETIRE_PAYMENT.OraSelectData, vLinePrinting, vGDColumn, vXLColumn, 2);
                    }

                    vObject_YYYYMM = pGrid_RETIRE_ADJUSTMENT.GetCellValue("PAY_YYYYMM4");
                    IsConvert = IsConvertString(vObject_YYYYMM, out vConvertString);
                    if (IsConvert == true)
                    {
                        pida_DETAIL_RETIRE_PAYMENT.SetSelectParamValue("W_PAY_YYYYMM", vConvertString);
                        pida_DETAIL_RETIRE_PAYMENT.Fill();

                        XLLine2(pida_DETAIL_RETIRE_PAYMENT.OraSelectData, vLinePrinting, vGDColumn, vXLColumn, 3);
                    }

                    //합계
                    pida_SUM_RETIRE_PAYMENT.Fill();
                    XLLine2(pida_SUM_RETIRE_PAYMENT.OraSelectData, vLinePrinting, vGDColumn, vXLColumn, 4);
                    //---------------------------------------------------------------------------------------------------------

                    if (pOutChoice == "PRINT")
                    {
                        if (vSecondPrinting < vCountPrinting)
                        {
                            Printing(1, vSecondPrinting);

                            mPrinting.XLOpenFileClose();

                            mAppInterface.OnAppMessageEvent("XL File Open...");
                            System.Windows.Forms.Application.DoEvents();
                            isOpen = XLFileOpen();

                            vCountPrinting = 0;
                            vPrintingLine = 1;
                            mCopyLineSUM = 1;
                        }
                        else if (vTotalRow == vRowCount)
                        {
                            Printing(1, vCountPrinting);
                            //PreView(1, vCountPrinting);
                        }
                    }
                    else if (pOutChoice == "FILE")
                    {

                        if (vSecondPrinting < vCountPrinting)
                        {
                            SAVE("RETIRE_");

                            mPrinting.XLOpenFileClose();

                            mAppInterface.OnAppMessageEvent("XL File Open...");
                            System.Windows.Forms.Application.DoEvents();
                            isOpen = XLFileOpen();

                            vCountPrinting = 0;
                            vPrintingLine = 1;
                            mCopyLineSUM = 1;
                        }
                        else if (vTotalRow == vRowCount)
                        {
                            SAVE("RETIRE_");
                        }
                    }
                }
            }

            mPrinting.XLOpenFileClose();

            return mPageNumber;
        }

        #endregion;

        #region ----- Copy&Paste Sheet Method ----

        //첫번째 페이지 복사
        private int CopyAndPaste(XL.XLPrint pPrinting, int pCopySumPrintingLine, string pCourse)
        {
            int vCopySumPrintingLine = pCopySumPrintingLine;

            int vCopyPrintingRowSTART = vCopySumPrintingLine;
            vCopySumPrintingLine = vCopySumPrintingLine + mIncrementCopyMAX;
            int vCopyPrintingRowEnd = vCopySumPrintingLine;

            if (pCourse == "SRC_TAB1")
            {
                pPrinting.XLActiveSheet("SourceTab1");
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

        public void PreView(int pPageSTART, int pPageEND)
        {
            try
            {
                mPrinting.XLPreviewPrinting(pPageSTART, pPageEND, 1);
            }
            catch (System.Exception ex)
            {
                mMessageError = string.Format("{0}", ex.Message);
            }
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

        #endregion;
        
        #endregion;
    }
}