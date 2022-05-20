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

        #region ----- Array Set ----

        private void SetArray(out string[] pDBColumn, out int[] pXLColumn)
        {
            pDBColumn = new string[36];
            pXLColumn = new int[24];

            string vDBColumn01 = "DR_AMOUNT";
            string vDBColumn02 = "CR_AMOUNT";
            string vDBColumn03 = "ACCOUNT_CODE";
            string vDBColumn04 = "ACCOUNT_DESC";
            string vDBColumn09 = "MANAGEMENT1";
            string vDBColumn10 = "MANAGEMENT1_DESC";
            string vDBColumn11 = "MANAGEMENT2";
            string vDBColumn12 = "MANAGEMENT2_DESC";
            string vDBColumn13 = "REFER1";
            string vDBColumn14 = "REFER1_DESC";
            string vDBColumn15 = "REFER2";
            string vDBColumn16 = "REFER2_DESC";
            string vDBColumn17 = "REFER3";
            string vDBColumn18 = "REFER3_DESC";
            string vDBColumn19 = "REFER4";
            string vDBColumn20 = "REFER4_DESC";
            string vDBColumn21 = "REFER5";
            string vDBColumn22 = "REFER5_DESC";
            string vDBColumn25 = "CURRENCY_CODE";
            string vDBColumn26 = "EXCHANGE_RATE";
            string vDBColumn27 = "GL_CURRENCY_AMOUNT";
            string vDBColumn30 = "REMARK";
            string vDBColumn31 = "REFER6";
            string vDBColumn32 = "REFER6_DESC";
            string vDBColumn33 = "REFER7";
            string vDBColumn34 = "REFER7_DESC";
            string vDBColumn35 = "REFER8";
            string vDBColumn36 = "REFER8_DESC";

            pDBColumn[0] = vDBColumn01;  //DR_AMOUNT
            pDBColumn[1] = vDBColumn02;  //CR_AMOUNT
            pDBColumn[2] = vDBColumn03;  //ACCOUNT_CODE
            pDBColumn[3] = vDBColumn04;  //ACCOUNT_DESC
            pDBColumn[8] = vDBColumn09;  //MANAGEMENT1
            pDBColumn[9] = vDBColumn10;  //MANAGEMENT1_DESC
            pDBColumn[10] = vDBColumn11;  //MANAGEMENT2
            pDBColumn[11] = vDBColumn12;  //MANAGEMENT2_DESC
            pDBColumn[12] = vDBColumn13;  //REFER1
            pDBColumn[13] = vDBColumn14;  //REFER1_DESC
            pDBColumn[14] = vDBColumn15;  //REFER2
            pDBColumn[15] = vDBColumn16;  //REFER2_DESC
            pDBColumn[16] = vDBColumn17;  //REFER3
            pDBColumn[17] = vDBColumn18;  //REFER3_DESC
            pDBColumn[18] = vDBColumn19;  //REFER4
            pDBColumn[19] = vDBColumn20;  //REFER4_DESC
            pDBColumn[20] = vDBColumn21;  //REFER5
            pDBColumn[21] = vDBColumn22;  //REFER5_DESC
            pDBColumn[24] = vDBColumn25;  //CURRENCY_CODE
            pDBColumn[25] = vDBColumn26;  //EXCHANGE_RATE
            pDBColumn[26] = vDBColumn27;  //GL_CURRENCY_AMOUNT
            pDBColumn[29] = vDBColumn30;  //REMARK
            pDBColumn[30] = vDBColumn31;  //REFER6
            pDBColumn[31] = vDBColumn32;  //REFER6_DESC
            pDBColumn[32] = vDBColumn33;  //REFER7
            pDBColumn[33] = vDBColumn34;  //REFER7_DESC
            pDBColumn[34] = vDBColumn35;  //REFER8
            pDBColumn[35] = vDBColumn36;  //REFER8_DESC

            int vXLColumn01 = 4;   //DR_AMOUNT
            int vXLColumn02 = 9;   //CR_AMOUNT
            int vXLColumn03 = 4;   //ACCOUNT_CODE
            int vXLColumn04 = 4;   //ACCOUNT_DESC
            int vXLColumn07 = 14;  //(MANAGEMENT1)MANAGEMENT1_DESC
            int vXLColumn08 = 30;  //(MANAGEMENT2)MANAGEMENT2_DESC
            int vXLColumn09 = 14;  //(REFER1)REFER1_DESC
            int vXLColumn10 = 30;  //(REFER2)REFER2_DESC
            int vXLColumn11 = 14;  //(REFER3)REFER3_DESC
            int vXLColumn12 = 22;  //(REFER4)REFER4_DESC
            int vXLColumn13 = 30;  //(REFER5)REFER5_DESC
            int vXLColumn16 = 14;  //CURRENCY_CODE
            int vXLColumn17 = 17;  //EXCHANGE_RATE
            int vXLColumn18 = 22;  //GL_CURRENCY_AMOUNT
            int vXLColumn21 = 14;  //REMARK
            int vXLColumn22 = 38;  //(REFER6)REFER6_DESC
            int vXLColumn23 = 30;  //(REFER7)REFER7_DESC
            int vXLColumn24 = 38;  //(REFER8)REFER8_DESC

            pXLColumn[0] = vXLColumn01;  //DR_AMOUNT
            pXLColumn[1] = vXLColumn02;  //CR_AMOUNT
            pXLColumn[2] = vXLColumn03;  //ACCOUNT_CODE
            pXLColumn[3] = vXLColumn04;  //ACCOUNT_DESC
            pXLColumn[6] = vXLColumn07;  //(MANAGEMENT1)MANAGEMENT1_DESC
            pXLColumn[7] = vXLColumn08;  //(MANAGEMENT2)MANAGEMENT2_DESC
            pXLColumn[8] = vXLColumn09;  //(REFER1)REFER1_DESC
            pXLColumn[9] = vXLColumn10;  //(REFER2)REFER2_DESC
            pXLColumn[10] = vXLColumn11;  //(REFER3)REFER3_DESC
            pXLColumn[11] = vXLColumn12;  //(REFER4)REFER4_DESC
            pXLColumn[12] = vXLColumn13;  //(REFER5)REFER5_DESC
            pXLColumn[15] = vXLColumn16;  //CURRENCY_CODE
            pXLColumn[16] = vXLColumn17;  //EXCHANGE_RATE
            pXLColumn[17] = vXLColumn18;  //GL_CURRENCY_AMOUNT
            pXLColumn[20] = vXLColumn21;  //REMARK
            pXLColumn[21] = vXLColumn22;  //(REFER6)REFER6_DESC
            pXLColumn[22] = vXLColumn23;  //(REFER7)REFER7_DESC
            pXLColumn[23] = vXLColumn24;  //(REFER8)REFER8_DESC
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
            bool IsConvert2 = false;

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
                vColumnName1 = pDBColumn[9];
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

                //(MANAGEMENT2)MANAGEMENT2_DESC
                vColumnName1 = pDBColumn[11];
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

                //REFER1_DESC
                vColumnName1 = pDBColumn[13];
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

                //REFER2_DESC
                vColumnName1 = pDBColumn[15];
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

                vXLine++;
                //--------------------------------------------------------------------------------------------------

                //REFER3_DESC
                vColumnName1 = pDBColumn[17];
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

                //REFER4_DESC
                vColumnName1 = pDBColumn[19];
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

                //REFER5_DESC
                vColumnName1 = pDBColumn[21];
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

                //REFER6_DESC
                vColumnName1 = pDBColumn[31];
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

                //CURRENCY_CODE
                vColumnName1 = pDBColumn[24];
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

                //EXCHANGE_RATE
                vColumnName1 = pDBColumn[25];
                vXLColumnIndex = pXLColumn[16];
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
                vColumnName1 = pDBColumn[26];
                vXLColumnIndex = pXLColumn[17];
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

                //REFER7_DESC
                vColumnName1 = pDBColumn[33];
                vXLColumnIndex = pXLColumn[22];
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

                //REFER8_DESC
                vColumnName1 = pDBColumn[35];
                vXLColumnIndex = pXLColumn[23];
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
                vColumnName1 = pDBColumn[29];
                vXLColumnIndex = pXLColumn[20];
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


            pPrintingLine = vXLine;
            IsNewPage(pPrintingLine);
            if (mIsNewPage == true)
            {
                pPrintingLine = mPositionPrintLineSTART;
            }

            return pPrintingLine;
        }

        #endregion;

        #endregion;

        #region ----- Excel Wirte [Line] Methods ----

        public int LineWrite(InfoSummit.Win.ControlAdv.ISDataAdapter pData)
        {
            string vMessage = string.Empty;
            mIsNewPage = false;

            string[] vDBColumn;
            int[] vXLColumn;

            mDR_AMOUNT = 0;
            mCR_AMOUNT = 0;

            int vPrintingLine = mPositionPrintLineSTART;

            try
            {
                int vTotalRow = pData.OraSelectData.Rows.Count;
                mPageTotalNumber = vTotalRow / 8;
                mPageTotalNumber = (vTotalRow % 8) == 0 ? mPageTotalNumber : (mPageTotalNumber + 1);

                int vCountRow = 0;

                SetArray(out vDBColumn, out vXLColumn);

                foreach (System.Data.DataRow vRow in pData.OraSelectData.Rows)
                {
                    vCountRow++;

                    vPrintingLine = XlLine(mPrinting, vRow, vPrintingLine, vDBColumn, vXLColumn);

                    if (vTotalRow == vCountRow)
                    {
                        if (mPositionPrintLineSTART != vPrintingLine) //66라인의 1페이지 출력물에서 2페이지 준비 때문에 미리 표시된 쉬트에 대해 Skip 되도록 하기위해 비교
                        {
                            mPrinting.XLSetCell(58, 2, "합계");
                            string vDRAmount = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", mDR_AMOUNT);
                            mPrinting.XLSetCell(58, 4, vDRAmount);
                            string vCRAmount = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", mCR_AMOUNT);
                            mPrinting.XLSetCell(58, 9, vCRAmount);

                            mCopySumPrintingLine = CopyAndPaste(mPrinting, mCopySumPrintingLine);
                        }

                        XlAllLineClear(mPrinting);
                    }

                    vMessage = string.Format("{0}", (Convert.ToSingle(vCountRow) / Convert.ToSingle(vTotalRow)) * 100F);
                    mAppInterface.OnAppMessageEvent(vMessage);
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