using System;

namespace FCMF0216
{
    public class XLPrinting
    {
        #region ----- Variables -----

        private InfoSummit.Win.ControlAdv.ISAppInterface mAppInterface = null;

        private InfoSummit.Win.ControlAdv.ISProgressBar mProgressBar1;
        private InfoSummit.Win.ControlAdv.ISProgressBar mProgressBar2;

        private InfoSummit.Win.ControlAdv.ISGridAdvEx mMessageGrid;

        private XL.XLPrint mPrinting = null;

        private string mMessageError = string.Empty;

        private int mPageTotalNumber = 0;
        private int mPageNumber = 0;
        private int mCopySumPrintingLine = 1; //엑셀의 선택된 쉬트의 복사되어질 시작 행 위치
        private bool mIsNewPage = false;

        private string mXLOpenFileName = string.Empty;
        private int mPrintingLineMAX = 57;
        private int mIncrementCopyMAX = 67;
        private int mPositionPrintLineSTART = 18; //라인 출력시 엑셀 시작 행 위치 지정

        private decimal mDR_AMOUNT = 0; //차변합계
        private decimal mCR_AMOUNT = 0; //대변합계

        #endregion;

        #region ----- Property -----

        public string ErrorMessage
        {
            get
            {
                return mMessageError;
            }
        }

        public InfoSummit.Win.ControlAdv.ISProgressBar ProgressBar1
        {
            set
            {
                mProgressBar1 = value;
            }
        }

        public InfoSummit.Win.ControlAdv.ISProgressBar ProgressBar2
        {
            set
            {
                mProgressBar2 = value;
            }
        }

        public InfoSummit.Win.ControlAdv.ISGridAdvEx MessageGridEx
        {
            set
            {
                mMessageGrid = value;
            }
        }

        public string OpenFileNameExcel
        {
            set
            {
                mXLOpenFileName = value;
            }
        }

        public int PrintingLineMAX
        {
            set
            {
                mPrintingLineMAX = value;
            }
        }

        public int IncrementCopyMAX
        {
            set
            {
                mIncrementCopyMAX = value;
            }
        }

        public int PositionPrintLineSTART
        {
            set
            {
                mPositionPrintLineSTART = value;
            }
        }

        public int CopySumPrintingLine
        {
            set
            {
                mCopySumPrintingLine = value;
            }
        }

        #endregion;

        #region ----- Constructor -----

        public XLPrinting(InfoSummit.Win.ControlAdv.ISAppInterface pAppInterface)
        {
            mPrinting = new XL.XLPrint();
            mAppInterface = pAppInterface;
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

        #region ----- MessageGrid Methods ----

        private void MessageGrid(string pMessage)
        {
            int vCountRow = mMessageGrid.RowCount;
            vCountRow = vCountRow + 1;
            mMessageGrid.RowCount = vCountRow;

            int vCurrentRow = vCountRow - 1;

            mMessageGrid.SetCellValue(vCurrentRow, 0, pMessage);

            mMessageGrid.CurrentCellMoveTo(vCurrentRow, 0);
            mMessageGrid.Focus();
            mMessageGrid.CurrentCellActivate(vCurrentRow, 0);
        }

        #endregion;

        #region ----- Convert DateTime Methods ----

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
                        string vTextDateTimeLong = vDateTime.ToString("yyyy-MM-dd HH:mm:ss", null);
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

                int vCutRight = 2;
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

        #region ----- Line Clear All Methods ----

        private void XlAllLineClear(XL.XLPrint pPrinting)
        {
            int vXLColumn01 = 4;
            int vXLColumn02 = 9;
            int vXLColumn03 = 14;
            int vXLColumn04 = 17;
            int vXLColumn05 = 22;
            int vXLColumn06 = 30;
            int vXLColumn07 = 38;


            object vObject = null;
            int vPrintingLineMAX = mPrintingLineMAX + 1;

            pPrinting.XLActiveSheet("SourceTab1");

            for (int vXLine = mPositionPrintLineSTART; vXLine < vPrintingLineMAX; vXLine++)
            {
                pPrinting.XLSetCell(vXLine, vXLColumn01, vObject);
                pPrinting.XLSetCell(vXLine, vXLColumn02, vObject);
                pPrinting.XLSetCell(vXLine, vXLColumn03, vObject);
                pPrinting.XLSetCell(vXLine, vXLColumn04, vObject);
                pPrinting.XLSetCell(vXLine, vXLColumn05, vObject);
                pPrinting.XLSetCell(vXLine, vXLColumn06, vObject);
                pPrinting.XLSetCell(vXLine, vXLColumn07, vObject);
            }
        }

        #endregion;

        #region ----- Excel Wirte [Header] Methods ----

        public void HeaderWrite(InfoSummit.Win.ControlAdv.ISGridAdvEx pGrid, int pIndexRow)
        {
            object vObject = null;
            try
            {
                int vIndexRowCurrent = pIndexRow;

                int vIndexColumn_01 = pGrid.GetColumnToIndex("GL_NUM");          //전표번호[GL_NUM]
                int vIndexColumn_02 = pGrid.GetColumnToIndex("SLIP_DATE");       //작성일자[SLIP_DATE]
                int vIndexColumn_03 = pGrid.GetColumnToIndex("DEPT_NAME");       //작성부서[DEPT_NAME]
                int vIndexColumn_04 = pGrid.GetColumnToIndex("PERSON_NAME");     //작성자[PERSON_NAME]
                int vIndexColumn_05 = pGrid.GetColumnToIndex("GL_DATE");         //회계일자[GL_DATE]
                int vIndexColumn_07 = pGrid.GetColumnToIndex("SLIP_NUM");        //기표번호[SLIP_NUM]

                System.Drawing.Point vGridPoint01 = new System.Drawing.Point(vIndexRowCurrent, vIndexColumn_01);  //전표번호[GL_NUM]
                System.Drawing.Point vGridPoint02 = new System.Drawing.Point(vIndexRowCurrent, vIndexColumn_02);  //작성일자[SLIP_DATE]
                System.Drawing.Point vGridPoint03 = new System.Drawing.Point(vIndexRowCurrent, vIndexColumn_03);  //작성부서[DEPT_NAME]
                System.Drawing.Point vGridPoint04 = new System.Drawing.Point(vIndexRowCurrent, vIndexColumn_04);  //작성자[PERSON_NAME]
                System.Drawing.Point vGridPoint05 = new System.Drawing.Point(vIndexRowCurrent, vIndexColumn_05);  //회계일자[GL_DATE]
                System.Drawing.Point vGridPoint07 = new System.Drawing.Point(vIndexRowCurrent, vIndexColumn_07);  //기표번호[SLIP_NUM]

                System.Drawing.Point vCellPoint01 = new System.Drawing.Point(11, 2);  //전표번호[GL_NUM]
                System.Drawing.Point vCellPoint02 = new System.Drawing.Point(11, 31);  //작성일자[SLIP_DATE]
                System.Drawing.Point vCellPoint03 = new System.Drawing.Point(12, 31);  //작성부서[DEPT_NAME]
                System.Drawing.Point vCellPoint04 = new System.Drawing.Point(13, 31);  //작성자[PERSON_NAME]
                System.Drawing.Point vCellPoint05 = new System.Drawing.Point(14, 31);  //회계일자[GL_DATE]

                System.Drawing.Point vCellPoint06 = new System.Drawing.Point(66, 2);  //회계일자[GL_DATE]
                System.Drawing.Point vCellPoint07 = new System.Drawing.Point(66, 30); //기표번호[SLIP_NUM]

                mPrinting.XLActiveSheet("SourceTab1"); //셀에 문자를 넣기 위해 쉬트 선택

                //전표번호[GL_NUM]
                vObject = pGrid.GetCellValue(vGridPoint01.X, vGridPoint01.Y);
                if (vObject != null)
                {
                    mPrinting.XLSetCell(vCellPoint01.X, vCellPoint01.Y, vObject);
                }
                else
                {
                    vObject = null;
                    mPrinting.XLSetCell(vCellPoint01.X, vCellPoint01.Y, vObject);
                }

                //작성일자[SLIP_DATE]
                vObject = pGrid.GetCellValue(vGridPoint02.X, vGridPoint02.Y);
                if (vObject != null)
                {
                    vObject = ConvertDate(vObject);
                    mPrinting.XLSetCell(vCellPoint02.X, vCellPoint02.Y, vObject);
                }
                else
                {
                    vObject = null;
                    mPrinting.XLSetCell(vCellPoint02.X, vCellPoint02.Y, vObject);
                }

                //작성부서명[DEPT_NAME]
                vObject = pGrid.GetCellValue(vGridPoint03.X, vGridPoint03.Y);
                if (vObject != null)
                {
                    mPrinting.XLSetCell(vCellPoint03.X, vCellPoint03.Y, vObject);
                }
                else
                {
                    vObject = null;
                    mPrinting.XLSetCell(vCellPoint03.X, vCellPoint03.Y, vObject);
                }

                //작성자 이름[PERSON_NAME]
                vObject = pGrid.GetCellValue(vGridPoint04.X, vGridPoint04.Y);
                if (vObject != null)
                {
                    mPrinting.XLSetCell(vCellPoint04.X, vCellPoint04.Y, vObject);
                }
                else
                {
                    vObject = null;
                    mPrinting.XLSetCell(vCellPoint04.X, vCellPoint04.Y, vObject);
                }

                //회계일자[GL_DATE]
                vObject = pGrid.GetCellValue(vGridPoint05.X, vGridPoint05.Y);
                if (vObject != null)
                {
                    vObject = ConvertDate(vObject);
                    mPrinting.XLSetCell(vCellPoint05.X, vCellPoint05.Y, vObject);
                }
                else
                {
                    vObject = null;
                    mPrinting.XLSetCell(vCellPoint05.X, vCellPoint05.Y, vObject);
                }



                //[Bottom]
                //--------------------------------------------------------------------------------------------------
                //회계일자[GL_DATE]
                vObject = pGrid.GetCellValue(vGridPoint05.X, vGridPoint05.Y);
                if (vObject != null)
                {
                    vObject = ConvertDate(vObject);
                    mPrinting.XLSetCell(vCellPoint06.X, vCellPoint06.Y, vObject);
                }
                else
                {
                    vObject = null;
                    mPrinting.XLSetCell(vCellPoint06.X, vCellPoint06.Y, vObject);
                }

                //기표번호[SLIP_NUM]
                vObject = pGrid.GetCellValue(vGridPoint07.X, vGridPoint07.Y);
                if (vObject != null)
                {
                    mPrinting.XLSetCell(vCellPoint07.X, vCellPoint07.Y, vObject);
                }
                else
                {
                    vObject = null;
                    mPrinting.XLSetCell(vCellPoint07.X, vCellPoint07.Y, vObject);
                }
            }
            catch (System.Exception ex)
            {
                mMessageError = ex.Message;
                mPrinting.XLOpenFileClose();
                mPrinting.XLClose();
            }
        }

        #endregion;

        #region ----- Line SLIP Methods ----

        #region ----- Array Set 0 ----

        private void SetArray0(System.Data.DataTable pTable, out int[] pTableColumn, out int[] pExcelColumn)
        {
            pTableColumn = new int[7];
            pExcelColumn = new int[7];

            pTableColumn[00] = pTable.Columns.IndexOf("APPROVAL_1");
            pTableColumn[01] = pTable.Columns.IndexOf("APPROVAL_2");
            pTableColumn[02] = pTable.Columns.IndexOf("APPROVAL_3");
            pTableColumn[03] = pTable.Columns.IndexOf("APPROVAL_4");
            pTableColumn[04] = pTable.Columns.IndexOf("APPROVAL_5");
            pTableColumn[05] = pTable.Columns.IndexOf("APPROVAL_6");
            pTableColumn[06] = pTable.Columns.IndexOf("APPROVAL_7");


            pExcelColumn[00] = 18;   //담당
            pExcelColumn[01] = 22;   //대리
            pExcelColumn[02] = 26;   //과장
            pExcelColumn[03] = 30;   //차장
            pExcelColumn[04] = 34;   //부장
            pExcelColumn[05] = 38;   //임원
            pExcelColumn[06] = 42;   //대표이사
        }

        #endregion;

        #region ----- Array Set ----

        private void SetArray(out string[] pDBColumn, out int[] pXLColumn)
        {
            pDBColumn = new string[22];
            pXLColumn = new int[22];

            string vDBColumn01 = "DR_AMOUNT";
            string vDBColumn02 = "CR_AMOUNT";
            string vDBColumn03 = "ACCOUNT_CODE";
            string vDBColumn04 = "ACCOUNT_DESC";
            string vDBColumn05 = "MANAGEMENT1_DESC";
            string vDBColumn06 = "MANAGEMENT2_DESC";
            string vDBColumn07 = "REFER1_DESC";
            string vDBColumn08 = "REFER2_DESC";
            string vDBColumn09 = "REFER3_DESC";
            string vDBColumn10 = "REFER4_DESC";
            string vDBColumn11 = "REFER5_DESC";
            string vDBColumn12 = "REFER6_DESC";
            string vDBColumn13 = "REFER7_DESC";
            string vDBColumn14 = "REFER8_DESC";
            string vDBColumn15 = "REFER9_DESC";
            string vDBColumn16 = "REFER10_DESC";
            string vDBColumn17 = "REFER11_DESC";
            string vDBColumn18 = "REFER12_DESC";
            string vDBColumn19 = "CURRENCY_CODE";
            string vDBColumn20 = "EXCHANGE_RATE";
            string vDBColumn21 = "GL_CURRENCY_AMOUNT";
            string vDBColumn22 = "REMARK";

            pDBColumn[0] = vDBColumn01;  //DR_AMOUNT
            pDBColumn[1] = vDBColumn02;  //CR_AMOUNT
            pDBColumn[2] = vDBColumn03;  //ACCOUNT_CODE
            pDBColumn[3] = vDBColumn04;  //ACCOUNT_DESC
            pDBColumn[4] = vDBColumn05;  //MANAGEMENT1_DESC
            pDBColumn[5] = vDBColumn06;  //MANAGEMENT2_DESC
            pDBColumn[6] = vDBColumn07;  //REFER1_DESC
            pDBColumn[7] = vDBColumn08;  //REFER2_DESC
            pDBColumn[8] = vDBColumn09;  //REFER3_DESC
            pDBColumn[9] = vDBColumn10;  //REFER4_DESC
            pDBColumn[10] = vDBColumn11;  //REFER5_DESC
            pDBColumn[11] = vDBColumn12;  //REFER6_DESC
            pDBColumn[12] = vDBColumn13;  //REFER7_DESC
            pDBColumn[13] = vDBColumn14;  //REFER8_DESC
            pDBColumn[14] = vDBColumn15;  //REFER9_DESC
            pDBColumn[15] = vDBColumn16;  //REFER10_DESC
            pDBColumn[16] = vDBColumn17;  //REFER11_DESC
            pDBColumn[17] = vDBColumn18;  //REFER12_DESC
            pDBColumn[18] = vDBColumn19;  //CURRENCY_CODE
            pDBColumn[19] = vDBColumn20;  //EXCHANGE_RATE
            pDBColumn[20] = vDBColumn21;  //GL_CURRENCY_AMOUNT
            pDBColumn[21] = vDBColumn22;  //REMARK

            int vXLColumn01 = 4;   //DR_AMOUNT
            int vXLColumn02 = 9;   //CR_AMOUNT
            int vXLColumn03 = 4;   //ACCOUNT_CODE
            int vXLColumn04 = 4;   //ACCOUNT_DESC
            int vXLColumn05 = 14;  //(MANAGEMENT1)MANAGEMENT1_DESC
            int vXLColumn06 = 22;  //(MANAGEMENT2)MANAGEMENT2_DESC
            int vXLColumn07 = 30;  //(REFER1)REFER1_DESC
            int vXLColumn08 = 38;  //(REFER2)REFER2_DESC
            int vXLColumn09 = 14;  //(REFER3)REFER3_DESC
            int vXLColumn10 = 22;  //(REFER4)REFER4_DESC
            int vXLColumn11 = 30;  //(REFER5)REFER5_DESC
            int vXLColumn12 = 38;  //(REFER5)REFER6_DESC
            int vXLColumn13 = 14;  //(REFER6)REFER7_DESC
            int vXLColumn14 = 22;  //(REFER7)REFER8_DESC
            int vXLColumn15 = 30;  //(REFER8)REFER9_DESC
            int vXLColumn16 = 38;  //(REFER8)REFER10_DESC
            int vXLColumn17 = 14;  //(REFER8)REFER11_DESC
            int vXLColumn18 = 22;  //(REFER8)REFER12_DESC
            int vXLColumn19 = 30;  //CURRENCY_CODE
            int vXLColumn20 = 33;  //EXCHANGE_RATE
            int vXLColumn21 = 38;  //GL_CURRENCY_AMOUNT
            int vXLColumn22 = 14;  //REMARK

            pXLColumn[0] = vXLColumn01;  //DR_AMOUNT
            pXLColumn[1] = vXLColumn02;  //CR_AMOUNT
            pXLColumn[2] = vXLColumn03;  //ACCOUNT_CODE
            pXLColumn[3] = vXLColumn04;  //ACCOUNT_DESC
            pXLColumn[4] = vXLColumn05;  //(MANAGEMENT1)MANAGEMENT1_DESC
            pXLColumn[5] = vXLColumn06;  //(MANAGEMENT2)MANAGEMENT2_DESC
            pXLColumn[6] = vXLColumn07;  //(REFER1)REFER1_DESC
            pXLColumn[7] = vXLColumn08;  //(REFER2)REFER2_DESC
            pXLColumn[8] = vXLColumn09;  //(REFER3)REFER3_DESC
            pXLColumn[9] = vXLColumn10;  //(REFER4)REFER4_DESC
            pXLColumn[10] = vXLColumn11;  //(REFER5)REFER5_DESC
            pXLColumn[11] = vXLColumn12;  //(REFER5)REFER6_DESC
            pXLColumn[12] = vXLColumn13;  //(REFER6)REFER7_DESC
            pXLColumn[13] = vXLColumn14;  //(REFER7)REFER8_DESC
            pXLColumn[14] = vXLColumn15;  //(REFER8)REFER9_DESC
            pXLColumn[15] = vXLColumn16;  //(REFER6)REFER10_DESC
            pXLColumn[16] = vXLColumn17;  //(REFER7)REFER11_DESC
            pXLColumn[17] = vXLColumn18;  //(REFER8)REFER12_DESC
            pXLColumn[18] = vXLColumn19;  //CURRENCY_CODE
            pXLColumn[19] = vXLColumn20;  //EXCHANGE_RATE
            pXLColumn[20] = vXLColumn21;  //GL_CURRENCY_AMOUNT
            pXLColumn[21] = vXLColumn22;  //REMARK
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
            }

            return vIsConvert;
        }

        #endregion;

        #region ----- DOC APPROVAL LINE Method ----

        public void XLApprovalLine(System.Data.DataRow pROW, int[] pTableColumn, int[] pExcelColumn)
        {
            int vTableColumnIndex = 0;
            int vExcelColumnIndex = 0;

            object vObject = null;
            string vConvertString = string.Empty;

            bool IsConvert = false;

            try
            {
                mPrinting.XLActiveSheet("SourceTab1");

                //APPROVAL_1
                vTableColumnIndex = pTableColumn[0];
                vExcelColumnIndex = pExcelColumn[0];
                vObject = pROW[vTableColumnIndex];
                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0}", vConvertString);
                    mPrinting.XLSetCell(6, vExcelColumnIndex, vConvertString);
                    //mPrinting.XLSetCell(61, vExcelColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(6, vExcelColumnIndex, vConvertString);
                    //mPrinting.XLSetCell(61, vExcelColumnIndex, vConvertString);
                }

                //APPROVAL_2
                vTableColumnIndex = pTableColumn[1];
                vExcelColumnIndex = pExcelColumn[1];
                vObject = pROW[vTableColumnIndex];
                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0}", vConvertString);
                    mPrinting.XLSetCell(6, vExcelColumnIndex, vConvertString);
                    //mPrinting.XLSetCell(61, vExcelColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(6, vExcelColumnIndex, vConvertString);
                    //mPrinting.XLSetCell(61, vExcelColumnIndex, vConvertString);
                }

                //APPROVAL_3
                vTableColumnIndex = pTableColumn[2];
                vExcelColumnIndex = pExcelColumn[2];
                vObject = pROW[vTableColumnIndex];
                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0}", vConvertString);
                    mPrinting.XLSetCell(6, vExcelColumnIndex, vConvertString);
                    //mPrinting.XLSetCell(61, vExcelColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(6, vExcelColumnIndex, vConvertString);
                    //mPrinting.XLSetCell(61, vExcelColumnIndex, vConvertString);
                }

                //APPROVAL_4
                vTableColumnIndex = pTableColumn[3];
                vExcelColumnIndex = pExcelColumn[3];
                vObject = pROW[vTableColumnIndex];
                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0}", vConvertString);
                    mPrinting.XLSetCell(6, vExcelColumnIndex, vConvertString);
                    //mPrinting.XLSetCell(61, vExcelColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(6, vExcelColumnIndex, vConvertString);
                    //mPrinting.XLSetCell(61, vExcelColumnIndex, vConvertString);
                }

                //APPROVAL_5
                vTableColumnIndex = pTableColumn[4];
                vExcelColumnIndex = pExcelColumn[4];
                vObject = pROW[vTableColumnIndex];
                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0}", vConvertString);
                    mPrinting.XLSetCell(6, vExcelColumnIndex, vConvertString);
                    //mPrinting.XLSetCell(61, vExcelColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(6, vExcelColumnIndex, vConvertString);
                    //mPrinting.XLSetCell(61, vExcelColumnIndex, vConvertString);
                }

                //APPROVAL_6
                vTableColumnIndex = pTableColumn[5];
                vExcelColumnIndex = pExcelColumn[5];
                vObject = pROW[vTableColumnIndex];
                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0}", vConvertString);
                    mPrinting.XLSetCell(6, vExcelColumnIndex, vConvertString);
                    //mPrinting.XLSetCell(61, vExcelColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(6, vExcelColumnIndex, vConvertString);
                    //mPrinting.XLSetCell(61, vExcelColumnIndex, vConvertString);
                }

                //APPROVAL_7
                vTableColumnIndex = pTableColumn[6];
                vExcelColumnIndex = pExcelColumn[6];
                vObject = pROW[vTableColumnIndex];
                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0}", vConvertString);
                    mPrinting.XLSetCell(6, vExcelColumnIndex, vConvertString);
                    //mPrinting.XLSetCell(61, vExcelColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(6, vExcelColumnIndex, vConvertString);
                    //mPrinting.XLSetCell(61, vExcelColumnIndex, vConvertString);
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


        #region ----- FI DOC APPROVAL LINE Method ----

        private void XLApprovalLine_FI(System.Data.DataRow pROW, int[] pTableColumn, int[] pExcelColumn)
        {
            int vTableColumnIndex = 0;
            int vExcelColumnIndex = 0;

            object vObject = null;
            string vConvertString = string.Empty;

            bool IsConvert = false;

            try
            {
                mPrinting.XLActiveSheet("SourceTab1");
                int vROW = 61;

                //APPROVAL_1
                vTableColumnIndex = pTableColumn[0];
                vExcelColumnIndex = pExcelColumn[0];
                vObject = pROW[vTableColumnIndex];
                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0}", vConvertString);
                    mPrinting.XLSetCell(vROW, vExcelColumnIndex, vConvertString);
                    //mPrinting.XLSetCell(61, vExcelColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vROW, vExcelColumnIndex, vConvertString);
                    //mPrinting.XLSetCell(61, vExcelColumnIndex, vConvertString);
                }

                //APPROVAL_2
                vTableColumnIndex = pTableColumn[1];
                vExcelColumnIndex = pExcelColumn[1];
                vObject = pROW[vTableColumnIndex];
                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0}", vConvertString);
                    mPrinting.XLSetCell(vROW, vExcelColumnIndex, vConvertString);
                    //mPrinting.XLSetCell(61, vExcelColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vROW, vExcelColumnIndex, vConvertString);
                    //mPrinting.XLSetCell(61, vExcelColumnIndex, vConvertString);
                }

                //APPROVAL_3
                vTableColumnIndex = pTableColumn[2];
                vExcelColumnIndex = pExcelColumn[2];
                vObject = pROW[vTableColumnIndex];
                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0}", vConvertString);
                    mPrinting.XLSetCell(vROW, vExcelColumnIndex, vConvertString);
                    //mPrinting.XLSetCell(61, vExcelColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vROW, vExcelColumnIndex, vConvertString);
                    //mPrinting.XLSetCell(61, vExcelColumnIndex, vConvertString);
                }

                //APPROVAL_4
                vTableColumnIndex = pTableColumn[3];
                vExcelColumnIndex = pExcelColumn[3];
                vObject = pROW[vTableColumnIndex];
                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0}", vConvertString);
                    mPrinting.XLSetCell(vROW, vExcelColumnIndex, vConvertString);
                    //mPrinting.XLSetCell(61, vExcelColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vROW, vExcelColumnIndex, vConvertString);
                    //mPrinting.XLSetCell(61, vExcelColumnIndex, vConvertString);
                }

                //APPROVAL_5
                vTableColumnIndex = pTableColumn[4];
                vExcelColumnIndex = pExcelColumn[4];
                vObject = pROW[vTableColumnIndex];
                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0}", vConvertString);
                    mPrinting.XLSetCell(vROW, vExcelColumnIndex, vConvertString);
                    //mPrinting.XLSetCell(61, vExcelColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vROW, vExcelColumnIndex, vConvertString);
                    //mPrinting.XLSetCell(61, vExcelColumnIndex, vConvertString);
                }

                //APPROVAL_6
                vTableColumnIndex = pTableColumn[5];
                vExcelColumnIndex = pExcelColumn[5];
                vObject = pROW[vTableColumnIndex];
                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0}", vConvertString);
                    mPrinting.XLSetCell(vROW, vExcelColumnIndex, vConvertString);
                    //mPrinting.XLSetCell(61, vExcelColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vROW, vExcelColumnIndex, vConvertString);
                    //mPrinting.XLSetCell(61, vExcelColumnIndex, vConvertString);
                }

                //APPROVAL_7
                vTableColumnIndex = pTableColumn[6];
                vExcelColumnIndex = pExcelColumn[6];
                vObject = pROW[vTableColumnIndex];
                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0}", vConvertString);
                    mPrinting.XLSetCell(vROW, vExcelColumnIndex, vConvertString);
                    //mPrinting.XLSetCell(61, vExcelColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vROW, vExcelColumnIndex, vConvertString);
                    //mPrinting.XLSetCell(61, vExcelColumnIndex, vConvertString);
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

        #region ----- XlLine Methods -----

        private int XlLine(XL.XLPrint pPrinting, System.Data.DataRow pRow, int pPrintingLine, string[] pDBColumn, int[] pXLColumn)
        {
            int vXLine = pPrintingLine; //엑셀에 내용이 표시되는 행 번호

            string vColumnName1= string.Empty;
            string vColumnName2 = string.Empty;
            int vXLColumnIndex = 0;

            string vConvertString1 = string.Empty;
            string vConvertString2 = string.Empty;
            decimal vConvertDecimal = 0m;
            bool IsConvert1 = false;

            try
            {
                //[DR_AMOUNT]
                vColumnName1 = pDBColumn[0];
                vXLColumnIndex = pXLColumn[0];
                IsConvert1 = IsConvertString(pRow[vColumnName1], out vConvertString1);
                if (IsConvert1 == true)
                {
                    pPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString1);

                    vConvertString1 = vConvertString1.Replace(",", "");
                    IsConvertNumber(vConvertString1, out vConvertDecimal);
                    mDR_AMOUNT = mDR_AMOUNT + vConvertDecimal;
                }
                else
                {
                    vConvertString1 = string.Empty;
                    pPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString1);
                }

                //[CR_AMOUNT]
                vColumnName1 = pDBColumn[1];
                vXLColumnIndex = pXLColumn[1];
                IsConvert1 = IsConvertString(pRow[vColumnName1], out vConvertString1);
                if (IsConvert1 == true)
                {
                    pPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString1);

                    vConvertString1 = vConvertString1.Replace(",", "");
                    IsConvertNumber(vConvertString1, out vConvertDecimal);
                    mCR_AMOUNT = mCR_AMOUNT + vConvertDecimal;
                }
                else
                {
                    vConvertString1 = string.Empty;
                    pPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString1);
                }

                //(MANAGEMENT1)MANAGEMENT1_DESC
                vColumnName1 = pDBColumn[4];
                vXLColumnIndex = pXLColumn[4];
                IsConvert1 = IsConvertString(pRow[vColumnName1], out vConvertString1);
                if (IsConvert1 == true)
                {
                    vConvertString1 = string.Format("{0}", vConvertString1);
                    pPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString1);
                }
                else
                {
                    vConvertString1 = string.Empty;
                    pPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString1);
                }

                //(MANAGEMENT2)MANAGEMENT2_DESC
                vColumnName1 = pDBColumn[5];
                vXLColumnIndex = pXLColumn[5];
                IsConvert1 = IsConvertString(pRow[vColumnName1], out vConvertString1);
                if (IsConvert1 == true)
                {
                    vConvertString1 = string.Format("{0}", vConvertString1);
                    pPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString1);
                }
                else
                {
                    vConvertString1 = string.Empty;
                    pPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString1);
                }
                //(REFER1)REFER1_DESC
                vColumnName1 = pDBColumn[6];
                vXLColumnIndex = pXLColumn[6];
                IsConvert1 = IsConvertString(pRow[vColumnName1], out vConvertString1);
                if (IsConvert1 == true)
                {
                    vConvertString1 = string.Format("{0}", vConvertString1);
                    pPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString1);
                }
                else
                {
                    vConvertString1 = string.Empty;
                    pPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString1);
                }

                //(REFER2)REFER2_DESC
                vColumnName1 = pDBColumn[7];
                vXLColumnIndex = pXLColumn[7];
                IsConvert1 = IsConvertString(pRow[vColumnName1], out vConvertString1);
                if (IsConvert1 == true)
                {
                    vConvertString1 = string.Format("{0}", vConvertString1);
                    pPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString1);
                }
                else
                {
                    vConvertString1 = string.Empty;
                    pPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString1);
                }

                vXLine++;
                //--------------------------------------------------------------------------------------------------

                //(REFER3)REFER3_DESC
                vColumnName1 = pDBColumn[8];
                vXLColumnIndex = pXLColumn[8];
                IsConvert1 = IsConvertString(pRow[vColumnName1], out vConvertString1);
                if (IsConvert1 == true)
                {
                    vConvertString1 = string.Format("{0}", vConvertString1);
                    pPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString1);
                }
                else
                {
                    vConvertString1 = string.Empty;
                    pPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString1);
                }

                //(REFER4)REFER4_DESC
                vColumnName1 = pDBColumn[9];
                vXLColumnIndex = pXLColumn[9];
                IsConvert1 = IsConvertString(pRow[vColumnName1], out vConvertString1);
                if (IsConvert1 == true)
                {
                    vConvertString1 = string.Format("{0}", vConvertString1);
                    pPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString1);
                }
                else
                {
                    vConvertString1 = string.Empty;
                    pPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString1);
                }

                //(REFER5)REFER5_DESC
                vColumnName1 = pDBColumn[10];
                vXLColumnIndex = pXLColumn[10];
                IsConvert1 = IsConvertString(pRow[vColumnName1], out vConvertString1);
                if (IsConvert1 == true)
                {
                    vConvertString1 = string.Format("{0}", vConvertString1);
                    pPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString1);
                }
                else
                {
                    vConvertString1 = string.Empty;
                    pPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString1);
                }

                //(REFER6)REFER6_DESC
                vColumnName1 = pDBColumn[11];
                vXLColumnIndex = pXLColumn[11];
                IsConvert1 = IsConvertString(pRow[vColumnName1], out vConvertString1);
                if (IsConvert1 == true)
                {
                    vConvertString1 = string.Format("{0}", vConvertString1);
                    pPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString1);
                }
                else
                {
                    vConvertString1 = string.Empty;
                    pPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString1);
                }

                vXLine++;
                //--------------------------------------------------------------------------------------------------

                //(REFER7)REFER7_DESC
                vColumnName1 = pDBColumn[12];
                vXLColumnIndex = pXLColumn[12];
                IsConvert1 = IsConvertString(pRow[vColumnName1], out vConvertString1);
                if (IsConvert1 == true)
                {
                    vConvertString1 = string.Format("{0}", vConvertString1);
                    pPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString1);
                }
                else
                {
                    vConvertString1 = string.Empty;
                    pPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString1);
                }

                //(REFER8)REFER8_DESC
                vColumnName1 = pDBColumn[13];
                vXLColumnIndex = pXLColumn[13];
                IsConvert1 = IsConvertString(pRow[vColumnName1], out vConvertString1);
                if (IsConvert1 == true)
                {
                    vConvertString1 = string.Format("{0}", vConvertString1);
                    pPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString1);
                }
                else
                {
                    vConvertString1 = string.Empty;
                    pPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString1);
                }

                //(REFER9)REFER9_DESC
                vColumnName1 = pDBColumn[14];
                vXLColumnIndex = pXLColumn[14];
                IsConvert1 = IsConvertString(pRow[vColumnName1], out vConvertString1);
                if (IsConvert1 == true)
                {
                    vConvertString1 = string.Format("{0}", vConvertString1);
                    pPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString1);
                }
                else
                {
                    vConvertString1 = string.Empty;
                    pPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString1);
                }

                //(REFER10)REFER10_DESC
                vColumnName1 = pDBColumn[15];
                vXLColumnIndex = pXLColumn[15];
                IsConvert1 = IsConvertString(pRow[vColumnName1], out vConvertString1);
                if (IsConvert1 == true)
                {
                    vConvertString1 = string.Format("{0}", vConvertString1);
                    pPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString1);
                }
                else
                {
                    vConvertString1 = string.Empty;
                    pPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString1);
                }

                vXLine++;
                //--------------------------------------------------------------------------------------------------

                //[ACCOUNT_CODE]
                vColumnName1 = pDBColumn[2];
                vXLColumnIndex = pXLColumn[2];
                IsConvert1 = IsConvertString(pRow[vColumnName1], out vConvertString1);
                if (IsConvert1 == true)
                {
                    vConvertString1 = string.Format("{0}", vConvertString1);
                    pPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString1);
                }
                else
                {
                    vConvertString1 = string.Empty;
                    pPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString1);
                }
                //(REFER11)REFER11_DESC
                vColumnName1 = pDBColumn[16];
                vXLColumnIndex = pXLColumn[16];
                IsConvert1 = IsConvertString(pRow[vColumnName1], out vConvertString1);
                if (IsConvert1 == true)
                {
                    vConvertString1 = string.Format("{0}", vConvertString1);
                    pPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString1);
                }
                else
                {
                    vConvertString1 = string.Empty;
                    pPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString1);
                }
                //(REFER12)REFER12_DESC
                vColumnName1 = pDBColumn[17];
                vXLColumnIndex = pXLColumn[17];
                IsConvert1 = IsConvertString(pRow[vColumnName1], out vConvertString1);
                if (IsConvert1 == true)
                {
                    vConvertString1 = string.Format("{0}", vConvertString1);
                    pPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString1);
                }
                else
                {
                    vConvertString1 = string.Empty;
                    pPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString1);
                }

                //CURRENCY_CODE
                vColumnName1 = pDBColumn[18];
                vXLColumnIndex = pXLColumn[18];
                IsConvert1 = IsConvertString(pRow[vColumnName1], out vConvertString1);
                if (IsConvert1 == true)
                {
                    vConvertString1 = string.Format("{0}", vConvertString1);
                    pPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString1);
                }
                else
                {
                    vConvertString1 = string.Empty;
                    pPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString1);
                }

                //EXCHANGE_RATE
                vColumnName1 = pDBColumn[19];
                vXLColumnIndex = pXLColumn[19];
                IsConvert1 = IsConvertNumber(pRow[vColumnName1], out vConvertDecimal);
                if (IsConvert1 == true)
                {
                    //vConvertString1 = string.Format("{0:###,###,###,###,###,###,###,###.0000}", vConvertDecimal);
                    //pPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString1);
                    pPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertDecimal);
                }
                else
                {
                    vConvertString1 = string.Empty;
                    pPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString1);
                }

                //GL_CURRENCY_AMOUNT
                vColumnName1 = pDBColumn[20];
                vXLColumnIndex = pXLColumn[20];
                IsConvert1 = IsConvertNumber(pRow[vColumnName1], out vConvertDecimal);
                if (IsConvert1 == true)
                {
                    //vConvertString1 = string.Format("{0:###,###,###,###,###,###,###,###.0000}", vConvertDecimal);
                    //pPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString1);
                    pPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertDecimal);
                }
                else
                {
                    vConvertString1 = string.Empty;
                    pPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString1);
                }

                vXLine++;
                //--------------------------------------------------------------------------------------------------

                //[ACCOUNT_DESC]
                vColumnName1 = pDBColumn[3];
                vXLColumnIndex = pXLColumn[3];
                IsConvert1 = IsConvertString(pRow[vColumnName1], out vConvertString1);
                if (IsConvert1 == true)
                {
                    vConvertString1 = string.Format("{0}", vConvertString1);
                    pPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString1);
                }
                else
                {
                    vConvertString1 = string.Empty;
                    pPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString1);
                }

                //REMARK
                vColumnName1 = pDBColumn[21];
                vXLColumnIndex = pXLColumn[21];
                IsConvert1 = IsConvertString(pRow[vColumnName1], out vConvertString1);
                if (IsConvert1 == true)
                {
                    vConvertString1 = string.Format("{0}", vConvertString1);
                    pPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString1);
                }
                else
                {
                    vConvertString1 = string.Empty;
                    pPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString1);
                }

                vXLine++;
                //--------------------------------------------------------------------------------------------------
            }
            catch (System.Exception ex)
            {
                mMessageError = ex.Message;
                mAppInterface.OnAppMessageEvent(mMessageError);
            }

            return vXLine;
        }

        #endregion;

        #endregion;

        #region ----- Excel Wirte [Line] Methods ----

        public int LineWrite(InfoSummit.Win.ControlAdv.ISDataAdapter pData, System.Data.DataTable pTable_DOC_APPROVAL_LINE, System.Data.DataTable pDOC_APPROVAL_LINE_FI)
        {
            string vMessage = string.Empty;
            mIsNewPage = false;

            string[] vDBColumn;
            int[] vXLColumn;

            int[] vTableColumn;
            int[] vExcelColumn;

            mDR_AMOUNT = 0;
            mCR_AMOUNT = 0;

            int vPrintingLine = mPositionPrintLineSTART;

            try
            {
                int vTotalRow = pData.OraSelectData.Rows.Count;
                mPageTotalNumber = vTotalRow / 8;
                mPageTotalNumber = (vTotalRow % 8) == 0 ? mPageTotalNumber : (mPageTotalNumber + 1);

                #region ----- Approval Line Write ----

                int vRowCount_DOC_APPROVAL_LINE = pTable_DOC_APPROVAL_LINE.Rows.Count;

                if (vRowCount_DOC_APPROVAL_LINE > 0)
                {
                    SetArray0(pTable_DOC_APPROVAL_LINE, out vTableColumn, out vExcelColumn);

                    XLApprovalLine(pTable_DOC_APPROVAL_LINE.Rows[0], vTableColumn, vExcelColumn);
                }

                #endregion;

                #region ----- FI Approval Line Write ----

                vRowCount_DOC_APPROVAL_LINE = pDOC_APPROVAL_LINE_FI.Rows.Count;

                if (vRowCount_DOC_APPROVAL_LINE > 0)
                {
                    SetArray0(pDOC_APPROVAL_LINE_FI, out vTableColumn, out vExcelColumn);

                    XLApprovalLine_FI(pDOC_APPROVAL_LINE_FI.Rows[0], vTableColumn, vExcelColumn);
                }

                #endregion;

                int vCountRow = 0;

                SetArray(out vDBColumn, out vXLColumn);

                foreach (System.Data.DataRow vRow in pData.OraSelectData.Rows)
                {
                    vCountRow++;

                    vPrintingLine = XlLine(mPrinting, vRow, vPrintingLine, vDBColumn, vXLColumn);

                    if (vTotalRow == vCountRow)
                    {
                        int vSpare = (mPrintingLineMAX + 1) - vPrintingLine;
                        vPrintingLine = vPrintingLine + vSpare;
                        mPrinting.XLSetCell(vPrintingLine, 2, "합계"); //Line 58
                        string vDRAmount = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", mDR_AMOUNT);
                        mPrinting.XLSetCell(vPrintingLine, 4, vDRAmount);
                        string vCRAmount = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", mCR_AMOUNT);
                        mPrinting.XLSetCell(vPrintingLine, 9, vCRAmount);

                        mCopySumPrintingLine = CopyAndPaste(mPrinting, mCopySumPrintingLine);
                    }
                    else
                    {
                        IsNewPage(vPrintingLine);
                        if (mIsNewPage == true)
                        {
                            vPrintingLine = mPositionPrintLineSTART;
                        }
                    }

                    vMessage = string.Format("{0}/{1}", vCountRow, vTotalRow);
                    mAppInterface.OnAppMessageEvent(vMessage);
                    System.Windows.Forms.Application.DoEvents();
                }
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
            if (mPrintingLineMAX < pPrintingLine)
            {
                mIsNewPage = true;
                mCopySumPrintingLine = CopyAndPaste(mPrinting, mCopySumPrintingLine);

                XlAllLineClear(mPrinting);
            }
            else
            {
                mIsNewPage = false;
            }
        }

        #endregion;

        #region ----- Excel Copy&Paste Methods ----

        //[Sheet2]내용을 [Sheet1]에 붙여넣기
        private int CopyAndPaste(XL.XLPrint pPrinting, int pCopySumPrintingLine)
        {
            int vPrintHeaderColumnSTART = 1; //복사되어질 쉬트의 폭, 시작열
            int vPrintHeaderColumnEND = 46;  //복사되어질 쉬트의 폭, 종료열

            int vCopySumPrintingLine = pCopySumPrintingLine;

            mPageNumber++; //페이지 번호
            string vPageNumberText = string.Format("Page {0}/{1}", mPageNumber, mPageTotalNumber);
            mPrinting.XLActiveSheet("SourceTab1"); //이 함수를 호출 하지 않으면 그림파일이 XL Sheet에 Insert 되지 않는다.
            mPrinting.XLSetCell(66, 21, vPageNumberText); //페이지 번호, XLcell[행, 열]

            int vCopyPrintingRowSTART = vCopySumPrintingLine;
            vCopySumPrintingLine = vCopySumPrintingLine + mIncrementCopyMAX;
            int vCopyPrintingRowEnd = vCopySumPrintingLine;
            mPrinting.XLActiveSheet("SourceTab1");
            object vRangeSource = pPrinting.XLGetRange(vPrintHeaderColumnSTART, 1, mIncrementCopyMAX, vPrintHeaderColumnEND); //[원본], [Sheet2.Cell("A1:AS67")], 엑셀 쉬트에서 복사 시작할 행번호, 엑셀 쉬트에서 복사 시작할 열번호, 엑셀 쉬트에서 복사 종료할 행번호, 엑셀 쉬트에서 복사 종료할 열번호
            pPrinting.XLActiveSheet("Destination");
            object vRangeDestination = pPrinting.XLGetRange(vCopyPrintingRowSTART, 1, vCopyPrintingRowEnd, vPrintHeaderColumnEND); //[대상], [Sheet1.Cell("A1:AS67")], 엑셀 쉬트에서 복사 시작할 행번호, 엑셀 쉬트에서 복사 시작할 열번호, 엑셀 쉬트에서 복사 종료할 행번호, 엑셀 쉬트에서 복사 종료할 열번호
            pPrinting.XLCopyRange(vRangeSource, vRangeDestination);

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
            string vSaveFileName = string.Format("{0}{1:D2}", pSaveFileName, vMaxNumber);

            vSaveFileName = string.Format("{0}\\{1}.xls", vWallpaperFolder, vSaveFileName);
            mPrinting.XLSave(vSaveFileName);
        }

        #endregion;
    }
}