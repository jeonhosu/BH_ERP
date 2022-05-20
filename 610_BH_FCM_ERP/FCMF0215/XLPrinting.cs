using System;

namespace FCMF0215
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

        private int mPrintingLineSTART = 18;  //Line

        private int mCopyLineSUM = 1;        //엑셀의 선택된 쉬트의 복사되어질 시작 행 위치, 복사 행 누적
        private int mIncrementCopyMAX = 67;  //복사되어질 행의 범위

        private int mCopyColumnSTART = 1; //복사되어  진 행 누적 수
        private int mCopyColumnEND = 46;  //엑셀의 선택된 쉬트의 복사되어질 끝 열 위치

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

        #region ----- Array Set 1 ----

        private void SetArray1(System.Data.DataTable pTable, out int[] pTableColumn, out int[] pExcelColumn)
        {
            pTableColumn = new int[7];
            pExcelColumn = new int[7];

            pTableColumn[00] = pTable.Columns.IndexOf("GL_NUM");       //전표번호[GL_NUM]
            pTableColumn[01] = pTable.Columns.IndexOf("SLIP_DATE");    //작성일자[SLIP_DATE]
            pTableColumn[02] = pTable.Columns.IndexOf("DEPT_NAME");    //작성부서[DEPT_NAME]
            pTableColumn[03] = pTable.Columns.IndexOf("PERSON_NAME");  //작성자[PERSON_NAME]
            pTableColumn[04] = pTable.Columns.IndexOf("GL_DATE");      //회계일자[GL_DATE]
            pTableColumn[05] = pTable.Columns.IndexOf("GL_DATE");      //회계일자[GL_DATE]
            pTableColumn[06] = pTable.Columns.IndexOf("SLIP_NUM");     //기표번호[SLIP_NUM]


            pExcelColumn[00] = 2;    //전표번호[GL_NUM]
            pExcelColumn[01] = 31;   //작성일자[SLIP_DATE]
            pExcelColumn[02] = 31;   //작성부서[DEPT_NAME]
            pExcelColumn[03] = 31;   //작성자[PERSON_NAME]
            pExcelColumn[04] = 31;   //회계일자[GL_DATE]
            pExcelColumn[05] = 2;    //회계일자[GL_DATE]
            pExcelColumn[06] = 30;   //기표번호[SLIP_NUM]
        }

        #endregion;

        #region ----- Array Set 2 ----

        private void SetArray2(System.Data.DataTable pTable, out int[] pTableColumn, out int[] pExcelColumn)
        {
            pTableColumn = new int[22];
            pExcelColumn = new int[22];

            pTableColumn[00] = pTable.Columns.IndexOf("DR_AMOUNT");
            pTableColumn[01] = pTable.Columns.IndexOf("CR_AMOUNT");
            pTableColumn[02] = pTable.Columns.IndexOf("ACCOUNT_CODE");
            pTableColumn[03] = pTable.Columns.IndexOf("ACCOUNT_DESC");
            pTableColumn[04] = pTable.Columns.IndexOf("MANAGEMENT1_DESC");
            pTableColumn[05] = pTable.Columns.IndexOf("MANAGEMENT2_DESC");
            pTableColumn[06] = pTable.Columns.IndexOf("REFER1_DESC");
            pTableColumn[07] = pTable.Columns.IndexOf("REFER2_DESC");
            pTableColumn[08] = pTable.Columns.IndexOf("REFER3_DESC");
            pTableColumn[09] = pTable.Columns.IndexOf("REFER4_DESC");
            pTableColumn[10] = pTable.Columns.IndexOf("REFER5_DESC");
            pTableColumn[11] = pTable.Columns.IndexOf("REFER6_DESC");
            pTableColumn[12] = pTable.Columns.IndexOf("REFER7_DESC");
            pTableColumn[13] = pTable.Columns.IndexOf("REFER8_DESC");
            pTableColumn[14] = pTable.Columns.IndexOf("REFER9_DESC");
            pTableColumn[15] = pTable.Columns.IndexOf("REFER10_DESC");
            pTableColumn[16] = pTable.Columns.IndexOf("REFER11_DESC");
            pTableColumn[17] = pTable.Columns.IndexOf("REFER12_DESC");
            pTableColumn[18] = pTable.Columns.IndexOf("CURRENCY_CODE");
            pTableColumn[19] = pTable.Columns.IndexOf("EXCHANGE_RATE");
            pTableColumn[20] = pTable.Columns.IndexOf("GL_CURRENCY_AMOUNT");
            pTableColumn[21] = pTable.Columns.IndexOf("REMARK");


            pExcelColumn[00] = 4;   //DR_AMOUNT
            pExcelColumn[01] = 9;   //CR_AMOUNT
            pExcelColumn[02] = 4;   //ACCOUNT_CODE
            pExcelColumn[03] = 4;   //ACCOUNT_DESC
            pExcelColumn[04] = 14;  //(MANAGEMENT1)MANAGEMENT1_DESC
            pExcelColumn[05] = 22;  //(MANAGEMENT2)MANAGEMENT2_DESC
            pExcelColumn[06] = 30;  //(REFER1)REFER1_DESC
            pExcelColumn[07] = 38;  //(REFER2)REFER2_DESC
            pExcelColumn[08] = 14;  //(REFER3)REFER3_DESC
            pExcelColumn[09] = 22;  //(REFER4)REFER4_DESC
            pExcelColumn[10] = 30;  //(REFER5)REFER5_DESC
            pExcelColumn[11] = 38;  //(REFER5)REFER6_DESC
            pExcelColumn[12] = 14;  //(REFER6)REFER7_DESC
            pExcelColumn[13] = 22;  //(REFER7)REFER8_DESC
            pExcelColumn[14] = 30;  //(REFER8)REFER9_DESC
            pExcelColumn[15] = 38;  //(REFER8)REFER10_DESC
            pExcelColumn[16] = 14;  //(REFER8)REFER11_DESC
            pExcelColumn[17] = 22;  //(REFER8)REFER12_DESC
            pExcelColumn[18] = 30;  //CURRENCY_CODE
            pExcelColumn[19] = 33;  //EXCHANGE_RATE
            pExcelColumn[20] = 38;  //GL_CURRENCY_AMOUNT
            pExcelColumn[21] = 14;  //REMARK
        }

        #endregion;

        #region ----- IsConvert String Method -----

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

        #region ----- IsConvert Number Method -----

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

        private bool IsConvertNumber(string pStringDecimal, out decimal pConvertDecimal)
        {
            bool vIsConvert = false;
            pConvertDecimal = 0m;

            try
            {
                bool vIsNull = string.IsNullOrEmpty(pStringDecimal); //null = true, not null = false
                if (vIsNull != true)
                {
                    decimal vIsConvertNum = decimal.Parse(pStringDecimal);
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

        #region ----- IsConvert Date Method -----

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

        #region ----- DOC APPROVAL LINE Method ----

        private void XLApprovalLine(System.Data.DataRow pROW, int[] pTableColumn, int[] pExcelColumn)
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

        #region ----- Header Write Method ----

        private void XLHeader(System.Data.DataRow pROW, int[] pTableColumn, int[] pExcelColumn)
        {
            int vTableColumnIndex = 0;
            int vExcelColumnIndex = 0;

            object vObject = null;
            string vConvertString = string.Empty;
            System.DateTime vConvertDateTime = new System.DateTime();

            bool IsConvert = false;

            try
            {
                mPrinting.XLActiveSheet("SourceTab1");

                //전표번호[GL_NUM]
                vTableColumnIndex = pTableColumn[0];
                vExcelColumnIndex = pExcelColumn[0];
                vObject = pROW[vTableColumnIndex];
                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0}", vConvertString);
                    mPrinting.XLSetCell(11, vExcelColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(11, vExcelColumnIndex, vConvertString);
                }

                //작성일자[SLIP_DATE]
                vTableColumnIndex = pTableColumn[1];
                vExcelColumnIndex = pExcelColumn[1];
                vObject = pROW[vTableColumnIndex];
                IsConvert = IsConvertDate(vObject, out vConvertDateTime);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0}", vConvertDateTime.ToShortDateString());
                    mPrinting.XLSetCell(11, vExcelColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(11, vExcelColumnIndex, vConvertString);
                }

                //작성부서[DEPT_NAME]
                vTableColumnIndex = pTableColumn[2];
                vExcelColumnIndex = pExcelColumn[2];
                vObject = pROW[vTableColumnIndex];
                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0}", vConvertString);
                    mPrinting.XLSetCell(12, vExcelColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(12, vExcelColumnIndex, vConvertString);
                }

                //작성자[PERSON_NAME]
                vTableColumnIndex = pTableColumn[3];
                vExcelColumnIndex = pExcelColumn[3];
                vObject = pROW[vTableColumnIndex];
                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0}", vConvertString);
                    mPrinting.XLSetCell(13, vExcelColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(13, vExcelColumnIndex, vConvertString);
                }

                //회계일자[GL_DATE]
                vTableColumnIndex = pTableColumn[4];
                vExcelColumnIndex = pExcelColumn[4];
                vObject = pROW[vTableColumnIndex];
                IsConvert = IsConvertDate(vObject, out vConvertDateTime);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0}", vConvertDateTime.ToShortDateString());
                    mPrinting.XLSetCell(14, vExcelColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(14, vExcelColumnIndex, vConvertString);
                }

                //회계일자[GL_DATE]
                vTableColumnIndex = pTableColumn[5];
                vExcelColumnIndex = pExcelColumn[5];
                vObject = pROW[vTableColumnIndex];
                IsConvert = IsConvertDate(vObject, out vConvertDateTime);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0}", vConvertDateTime.ToShortDateString());
                    mPrinting.XLSetCell(66, vExcelColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(66, vExcelColumnIndex, vConvertString);
                }

                //기표번호[SLIP_NUM]
                vTableColumnIndex = pTableColumn[6];
                vExcelColumnIndex = pExcelColumn[6];
                vObject = pROW[vTableColumnIndex];
                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0}", vConvertString);
                    mPrinting.XLSetCell(66, vExcelColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(66, vExcelColumnIndex, vConvertString);
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

        private int XLLine(System.Data.DataRow pROW, int pXLine, int[] pTableColumn, int[] pExcelColumn)
        {
            int vXLine = pXLine; //엑셀에 내용이 표시되는 행 번호

            int vTableColumnIndex = 0;
            int vExcelColumnIndex = 0;

            object vObject = null;
            string vConvertString = string.Empty;
            decimal vConvertDecimal = 0m;
            bool IsConvert = false;

            try
            {
                mPrinting.XLActiveSheet("Destination");

                #region ----- ROW 1 ----

                //[DR_AMOUNT]
                vTableColumnIndex = pTableColumn[0];
                vExcelColumnIndex = pExcelColumn[0];
                vObject = pROW[vTableColumnIndex];
                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0}", vConvertString);
                    mPrinting.XLSetCell(vXLine, vExcelColumnIndex, vConvertString);

                    //차변합계
                    vConvertString = vConvertString.Replace(",", "");
                    IsConvertNumber(vConvertString, out vConvertDecimal);
                    mDR_AMOUNT = mDR_AMOUNT + vConvertDecimal;
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vExcelColumnIndex, vConvertString);
                }

                //[CR_AMOUNT]
                vTableColumnIndex = pTableColumn[1];
                vExcelColumnIndex = pExcelColumn[1];
                vObject = pROW[vTableColumnIndex];
                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0}", vConvertString);
                    mPrinting.XLSetCell(vXLine, vExcelColumnIndex, vConvertString);

                    //대변합계
                    vConvertString = vConvertString.Replace(",", "");
                    IsConvertNumber(vConvertString, out vConvertDecimal);
                    mCR_AMOUNT = mCR_AMOUNT + vConvertDecimal;
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vExcelColumnIndex, vConvertString);
                }

                //(MANAGEMENT1)MANAGEMENT1_DESC
                vTableColumnIndex = pTableColumn[4];
                vExcelColumnIndex = pExcelColumn[4];
                vObject = pROW[vTableColumnIndex];
                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0}", vConvertString);
                    mPrinting.XLSetCell(vXLine, vExcelColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vExcelColumnIndex, vConvertString);
                }

                //(MANAGEMENT2)MANAGEMENT2_DESC
                vTableColumnIndex = pTableColumn[5];
                vExcelColumnIndex = pExcelColumn[5];
                vObject = pROW[vTableColumnIndex];
                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0}", vConvertString);
                    mPrinting.XLSetCell(vXLine, vExcelColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vExcelColumnIndex, vConvertString);
                }

                //(REFER1)REFER1_DESC
                vTableColumnIndex = pTableColumn[6];
                vExcelColumnIndex = pExcelColumn[6];
                vObject = pROW[vTableColumnIndex];
                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0}", vConvertString);
                    mPrinting.XLSetCell(vXLine, vExcelColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vExcelColumnIndex, vConvertString);
                }

                //(REFER2)REFER2_DESC
                vTableColumnIndex = pTableColumn[7];
                vExcelColumnIndex = pExcelColumn[7];
                vObject = pROW[vTableColumnIndex];
                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0}", vConvertString);
                    mPrinting.XLSetCell(vXLine, vExcelColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vExcelColumnIndex, vConvertString);
                }

                #endregion;

                //-------------------------------------------------------------------
                vXLine = vXLine + 1;
                //-------------------------------------------------------------------

                #region ----- ROW 2 ----

                //(REFER3)REFER3_DESC
                vTableColumnIndex = pTableColumn[8];
                vExcelColumnIndex = pExcelColumn[8];
                vObject = pROW[vTableColumnIndex];
                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0}", vConvertString);
                    mPrinting.XLSetCell(vXLine, vExcelColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vExcelColumnIndex, vConvertString);
                }

                //(REFER4)REFER4_DESC
                vTableColumnIndex = pTableColumn[9];
                vExcelColumnIndex = pExcelColumn[9];
                vObject = pROW[vTableColumnIndex];
                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0}", vConvertString);
                    mPrinting.XLSetCell(vXLine, vExcelColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vExcelColumnIndex, vConvertString);
                }

                //(REFER5)REFER5_DESC
                vTableColumnIndex = pTableColumn[10];
                vExcelColumnIndex = pExcelColumn[10];
                vObject = pROW[vTableColumnIndex];
                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0}", vConvertString);
                    mPrinting.XLSetCell(vXLine, vExcelColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vExcelColumnIndex, vConvertString);
                }

                //(REFER6)REFER6_DESC
                vTableColumnIndex = pTableColumn[11];
                vExcelColumnIndex = pExcelColumn[11];
                vObject = pROW[vTableColumnIndex];
                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0}", vConvertString);
                    mPrinting.XLSetCell(vXLine, vExcelColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vExcelColumnIndex, vConvertString);
                }

                #endregion;

                //-------------------------------------------------------------------
                vXLine = vXLine + 1;
                //-------------------------------------------------------------------

                #region ----- ROW 3 ----

                //(REFER7)REFER7_DESC
                vTableColumnIndex = pTableColumn[12];
                vExcelColumnIndex = pExcelColumn[12];
                vObject = pROW[vTableColumnIndex];
                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0}", vConvertString);
                    mPrinting.XLSetCell(vXLine, vExcelColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vExcelColumnIndex, vConvertString);
                }

                //(REFER8)REFER8_DESC
                vTableColumnIndex = pTableColumn[13];
                vExcelColumnIndex = pExcelColumn[13];
                vObject = pROW[vTableColumnIndex];
                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0}", vConvertString);
                    mPrinting.XLSetCell(vXLine, vExcelColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vExcelColumnIndex, vConvertString);
                }

                //(REFER9)REFER9_DESC
                vTableColumnIndex = pTableColumn[14];
                vExcelColumnIndex = pExcelColumn[14];
                vObject = pROW[vTableColumnIndex];
                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0}", vConvertString);
                    mPrinting.XLSetCell(vXLine, vExcelColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vExcelColumnIndex, vConvertString);
                }

                //(REFER10)REFER10_DESC
                vTableColumnIndex = pTableColumn[15];
                vExcelColumnIndex = pExcelColumn[15];
                vObject = pROW[vTableColumnIndex];
                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0}", vConvertString);
                    mPrinting.XLSetCell(vXLine, vExcelColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vExcelColumnIndex, vConvertString);
                }

                #endregion;

                //-------------------------------------------------------------------
                vXLine = vXLine + 1;
                //-------------------------------------------------------------------

                #region ----- ROW 4 ----

                //[ACCOUNT_CODE]
                vTableColumnIndex = pTableColumn[2];
                vExcelColumnIndex = pExcelColumn[2];
                vObject = pROW[vTableColumnIndex];
                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0}", vConvertString);
                    mPrinting.XLSetCell(vXLine, vExcelColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vExcelColumnIndex, vConvertString);
                }

                //(REFER11)REFER11_DESC
                vTableColumnIndex = pTableColumn[16];
                vExcelColumnIndex = pExcelColumn[16];
                vObject = pROW[vTableColumnIndex];
                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0}", vConvertString);
                    mPrinting.XLSetCell(vXLine, vExcelColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vExcelColumnIndex, vConvertString);
                }

                //(REFER12)REFER12_DESC
                vTableColumnIndex = pTableColumn[17];
                vExcelColumnIndex = pExcelColumn[17];
                vObject = pROW[vTableColumnIndex];
                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0}", vConvertString);
                    mPrinting.XLSetCell(vXLine, vExcelColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vExcelColumnIndex, vConvertString);
                }

                //CURRENCY_CODE
                vTableColumnIndex = pTableColumn[18];
                vExcelColumnIndex = pExcelColumn[18];
                vObject = pROW[vTableColumnIndex];
                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0}", vConvertString);
                    mPrinting.XLSetCell(vXLine, vExcelColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vExcelColumnIndex, vConvertString);
                }

                //EXCHANGE_RATE
                vTableColumnIndex = pTableColumn[19];
                vExcelColumnIndex = pExcelColumn[19];
                vObject = pROW[vTableColumnIndex];
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vExcelColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vExcelColumnIndex, vConvertString);
                }

                //GL_CURRENCY_AMOUNT
                vTableColumnIndex = pTableColumn[20];
                vExcelColumnIndex = pExcelColumn[20];
                vObject = pROW[vTableColumnIndex];
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vExcelColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vExcelColumnIndex, vConvertString);
                }

                #endregion;

                //-------------------------------------------------------------------
                vXLine = vXLine + 1;
                //-------------------------------------------------------------------

                #region ----- ROW 5 ----

                //[ACCOUNT_DESC]
                vTableColumnIndex = pTableColumn[3];
                vExcelColumnIndex = pExcelColumn[3];
                vObject = pROW[vTableColumnIndex];
                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0}", vConvertString);
                    mPrinting.XLSetCell(vXLine, vExcelColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vExcelColumnIndex, vConvertString);
                }

                //REMARK
                vTableColumnIndex = pTableColumn[21];
                vExcelColumnIndex = pExcelColumn[21];
                vObject = pROW[vTableColumnIndex];
                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0}", vConvertString);
                    mPrinting.XLSetCell(vXLine, vExcelColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vExcelColumnIndex, vConvertString);
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

        #endregion;

        #region ----- Excel Wirte [Line] Methods ----

        public int LineWrite(System.Data.DataTable pTable_SLIP_HEADER, System.Data.DataTable pTable_PRINT_SLIP_LINE, int pCurruntRow
                            , System.Data.DataTable pTable_DOC_APPROVAL_LINE, System.Data.DataTable pDOC_APPROVAL_LINE_FI)
        {
            mPageNumber = 0;
            string vMessage = string.Empty;

            string vPrintingDate = System.DateTime.Now.ToString("yyyy-MM-dd", null);
            string vPrintingTime = System.DateTime.Now.ToString("HH:mm:ss", null);

            int[] vTableColumn;
            int[] vExcelColumn;

            int vPrintingLine = 0;

            try
            {
                int vBy = 8;
                int vTotal1ROW = pTable_PRINT_SLIP_LINE.Rows.Count;

                mPageTotalNumber = vTotal1ROW / vBy;
                mPageTotalNumber = (vTotal1ROW % vBy) == 0 ? mPageTotalNumber : (mPageTotalNumber + 1);

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

                #region ----- Header Write ----

                int vRowCount_SLIP_HEADER = pTable_SLIP_HEADER.Rows.Count;

                if (vRowCount_SLIP_HEADER > 0)
                {
                    SetArray1(pTable_SLIP_HEADER, out vTableColumn, out vExcelColumn);

                    XLHeader(pTable_SLIP_HEADER.Rows[pCurruntRow], vTableColumn, vExcelColumn);

                    mCopyLineSUM = CopyAndPaste(mCopyLineSUM);
                }

                #endregion;

                #region ----- Line Write ----

                if (vTotal1ROW > 0)
                {
                    int vCountROW1 = 0;

                    vPrintingLine = mPrintingLineSTART;

                    SetArray2(pTable_PRINT_SLIP_LINE, out vTableColumn, out vExcelColumn);

                    foreach(System.Data.DataRow vROW in pTable_PRINT_SLIP_LINE.Rows)
                    {
                        vCountROW1++;

                        vMessage = string.Format("Rows : {0}/{1}", vCountROW1, vTotal1ROW);
                        mAppInterface.OnAppMessageEvent(vMessage);
                        System.Windows.Forms.Application.DoEvents();

                        vPrintingLine = XLLine(vROW, vPrintingLine, vTableColumn, vExcelColumn);

                        if (vTotal1ROW == vCountROW1)
                        {
                            //마지막 행이면...
                            int vRowEnd = mCopyLineSUM - 10;

                            mPrinting.XLSetCell(vRowEnd, 2, "합계");
                            string vDRAmount = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", mDR_AMOUNT);
                            mPrinting.XLSetCell(vRowEnd, 4, vDRAmount);
                            string vCRAmount = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", mCR_AMOUNT);
                            mPrinting.XLSetCell(vRowEnd, 9, vCRAmount);
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
            }

            return mPageNumber;
        }

        #endregion;

        #region ----- New Page iF Methods ----

        private void IsNewPage(int pPrintingLine)
        {
            int vPrintingLineEND = mCopyLineSUM - 11; //1~67: mCopyLineSUM=68에서 내용이 출력되는 행이 57 이므로, 11을 빼면 된다
            if (vPrintingLineEND < pPrintingLine)
            {
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
            string vPageNumberText = string.Format("Page {0}/{1}", mPageNumber, mPageTotalNumber);
            int vRowPageNumber = vCopyPrintingRowEnd - 2;
            int vColumnPageNumber = 21;
            mPrinting.XLSetCell(vRowPageNumber, vColumnPageNumber, vPageNumberText); //페이지 번호, XLcell[행, 열]

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

            vSaveFileName = string.Format("{0}\\{1}.xls", vWallpaperFolder, vSaveFileName);
            mPrinting.XLSave(vSaveFileName);
        }

        #endregion;
    }
}
