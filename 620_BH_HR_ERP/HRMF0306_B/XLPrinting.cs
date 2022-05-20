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

namespace HRMF0306
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

        // Report 상단에 출력될 항목
        private object mReq_Type;
        private object mReq_Num;
        private object mDuty_Manager_Name;
        private object mReq_Person_Name;

        private XL.XLPrint mPrinting = null;

        private string mMessageError = string.Empty;

        private string mXLOpenFileName = string.Empty;

        private int[] mIndexGridColumns = new int[0] { };

        private int mPositionPrintLineSTART = 9; //내용 출력시 엑셀 시작 행 위치 지정
        private int[] mIndexXLWriteColumn = new int[0] { }; //엑셀에 출력할 열 위치 지정

        private int mSumWriteLine = 0; //엑셀에 출력되는 행 누적 값
        private int mMaxIncrement = 36; //실제 출력되는 행의 시작부터 끝 행의 범위
        private int mSumPrintingLineCopy = 1; //엑셀의 선택된 쉬트에 복사되어질 시작 행 위치 및 누적 행 값
        private int mMaxIncrementCopy = 45; //반복 복사되어질 행의 최대 범위

        private int mXLColumnAreaSTART = 1; //복사되어질 쉬트의 폭, 시작열
        private int mXLColumnAreaEND = 62;  //복사되어질 쉬트의 폭, 종료열

        #endregion;

        #region ----- Property -----

        // Report 상단에 출력될 항목 - 제목 타입
        public object Req_Type
        {
            set
            {
                mReq_Type = value;
            }
        }

        // Report 상단에 출력될 항목 - 신청번호
        public object Req_Num
        {
            set
            {
                mReq_Num = value;
            }
        }

        // Report 상단에 출력될 항목 - 작업장
        public object Duty_Manager_Nam
        {
            set
            {
                mDuty_Manager_Name = value;
            }
        }

        // Report 상단에 출력될 항목 - 신청자
        public object Req_Person_Name
        {
            set
            {
                mReq_Person_Name = value;
            }
        }

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

        #region ----- Title_Type Methods ----
        // Report Title Type 출력 처리 함수
        private void XLTitleType(int pRow, int pColumn, object pType)
        {
            try
            {
                mPrinting.XLActiveSheet("SourceTab1");
                mPrinting.XLSetCell(pRow, pColumn, pType);
            }
            catch (System.Exception ex)
            {
                mMessageError = string.Format("{0}", ex.Message);
            }
        }

        #endregion;

        #region ----- Title Methods ----
        // Report Title 출력 처리 함수
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
        // Report HeaderLeft 부분 출력 처리 함수
        private void XLHeaderLeft(int pRow, int pColumn, object pContent)
        {
            try
            {
                mPrinting.XLActiveSheet("SourceTab1"); 
                mPrinting.XLSetCell(pRow, pColumn, pContent);
            }
            catch (System.Exception ex)
            {
                mMessageError = string.Format("{0}", ex.Message);
            }
        }

        #endregion;

        #region ----- Header Left Methods ----
        // Report HeaderCenter 부분 출력 처리 함수
        private void XLHeaderCenter(int pRow, int pColumn, object pContent)
        {
            try
            {
                mPrinting.XLActiveSheet("SourceTab1");
                mPrinting.XLSetCell(pRow, pColumn, pContent);
            }
            catch (System.Exception ex)
            {
                mMessageError = string.Format("{0}", ex.Message);
            }
        }

        #endregion;

        #region ----- Header Right Methods ----
        // Report HeaderRight 부분 출력 처리 함수
        private void XLHeaderRight(int pRow, int pColumn, object pContent)
        {
            try
            {
                mPrinting.XLActiveSheet("SourceTab1");
                mPrinting.XLSetCell(pRow, pColumn, pContent);
            }
            catch (System.Exception ex)
            {
                mMessageError = string.Format("{0}", ex.Message);
            }
        }

        #endregion;

        #region ----- Footer Left Methods ----

        private void XLFooterLeft(int pRow, int pColumn, object pContent)
        {
            try
            {
                mPrinting.XLActiveSheet("SourceTab1");
                mPrinting.XLSetCell(pRow, pColumn, pContent);
            }
            catch (System.Exception ex)
            {
                mMessageError = string.Format("{0}", ex.Message);
            }
        }

        #endregion;

        #region ----- Footer Right Methods ----

        private void XLFooterRight(int pRow, int pColumn, object pContent)
        {
            try
            {
                mPrinting.XLActiveSheet("SourceTab1"); 
                mPrinting.XLSetCell(pRow, pColumn, pContent);
            }
            catch (System.Exception ex)
            {
                mMessageError = string.Format("{0}", ex.Message);
            }
        }

        #endregion;

        #region ----- Print Header Methods ----

        private void XLHeader(object pType, string pTitle, object pHeaderLeft, object pHeaderCenter, object pHeaderRight)
        {
            try
            {
                XLTitleType(2, 21, pType);
                XLTitle(2, 25, pTitle);

                XLHeaderLeft(6, 1, pHeaderLeft);
                XLHeaderCenter(6, 27, pHeaderCenter);
                XLHeaderRight(6, 56, pHeaderRight);
            }
            catch (System.Exception ex)
            {
                mMessageError = string.Format("{0}", ex.Message);
            }
        }

        #endregion;

        #region ----- Print Footer Methods ----

        private void XLFooter(object pFooterLeft, object pFooterRight)
        {
            try
            {
                XLFooterLeft(45, 1, pFooterLeft);    //출력일시
                XLFooterRight(45, 57, pFooterRight); //페이지 번호
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
                    "NAME",
                    "POST_NAME",
                    "JOB_CATEGORY_NAME",
                    "WORK_DATE",
                    "DANGJIK_YN",
                    "ALL_NIGHT_YN",
                    "AFTER_OT_START",
                    "AFTER_OT_END",
                    "BEFORE_OT_START",
                    "BEFORE_OT_END",
                    "LUNCH_YN",
                    "DINNER_YN",
                    "MIDNIGHT_YN", 
                    "DESCRIPTION"
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
                    1, //NAME               성명    
                    5, //POST_NAME          직위    
                    8, //JOB_CATEGORY_NAME  직구분  
                    11,//WORK_DATE          근무일자
                    16,//DANGJIK_YN         당직    
                    18,//ALL_NIGHT_YN       철야    
                    20,//AFTER_OT_START     근무후  
                    27,//AFTER_OT_END       근무후  
                    34,//BEFORE_OT_START    근무전  
                    41,//BEFORE_OT_END      근무전  
                    48,//LUNCH_YN           중식    
                    50,//DINNER_YN          석식    
                    52,//MIDNIGHT_YN        야식    
                    54 //DESCRIPTION        사유    
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

        private void XLHeaderColumns(InfoSummit.Win.ControlAdv.ISGridAdvEx pGrid, int pTerritory, int pXLine)
        {
            int vXLine = pXLine - 1; //mPositionPrintLineSTART - 1, 출력될 내용의 행 위치에서 한행 위에 있으므로 1을 뺀다.
            int vCountColumn = mIndexGridColumns.Length;

            object vObject = null;
            int vGetIndexGridColumn = 0;

            try
            {
                if (mIndexGridColumns.Length < 1)
                {
                    return;
                }

                //Header Columns
                for (int vCol = 0; vCol < vCountColumn; vCol++)
                {
                    vGetIndexGridColumn = mIndexGridColumns[vCol];
                    switch (pTerritory)
                    {
                        case 1: //Default
                            vObject = pGrid.GridAdvExColElement[vGetIndexGridColumn].HeaderElement[0].Default;
                            mPrinting.XLSetCell(vXLine, mIndexXLWriteColumn[vCol], vObject);
                            break;
                        case 2: //KR
                            vObject = pGrid.GridAdvExColElement[vGetIndexGridColumn].HeaderElement[0].TL1_KR;
                            mPrinting.XLSetCell(vXLine, mIndexXLWriteColumn[vCol], vObject);
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

        private object ConvertDateTime(object pObject, int vCol)
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

                        if(vCol == 3)
                        {
                            vTextDateTimeLong = vDateTime.ToString("yyyy-MM-dd", null);
                        }

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
                            if ((vCol == 3) || (vCol == 6) || (vCol == 7) || (vCol == 8) || (vCol == 9)) 
                            {
                                vObject = pGrid.GetCellValue(vRow, mIndexGridColumns[vCol]);
                                vObject = ConvertDateTime(vObject, vCol);
                            }                                                        
                            /*if ((vCol == 2) || (vCol == 4))
                            {
                                vObject = pGrid.GetCellValue(vRow, mIndexGridColumns[vCol]);
                                vObject = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vObject);
                            }*/
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
                pSumWriteLine = pSumWriteLine + mMaxIncrement;
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
        public int XLWirte(InfoSummit.Win.ControlAdv.ISGridAdvEx pGrid, int pTerritory, string pPeriodFrom, /*string pPeriodTo,*/ string pUserName, string pCaption)
        {
            string vMessageText = string.Empty;

            string vPrintingDate = System.DateTime.Now.ToString("yyyy-MM-dd", null);
            string vPrintingTime = System.DateTime.Now.ToString("HH:mm:ss", null);

            int vPageNumber = 0;

            try
            {
                int vTotalRow = pGrid.RowCount; //Grid의 총 행수

                //[출력될 열 지정]
                XLDefinePrintColumn(pGrid);

                //vTotalRow = 60;
                while (vTotalRow > mSumWriteLine)
                {
                    vPageNumber++;

                    //[Header]
                    string vTitle = "Extension Duty Application Form";
                    switch (pTerritory)
                    {
                        case 1: //Default
                            vTitle = "Extension Duty Application Form";
                            break;
                        case 2: //KR
                            vTitle = "연 장 근 무 신 청 서";
                            break;
                    }

                    object vType = mReq_Type;                  // REQ_TYPE_NAME     //제목타입
                    object vHeaderLeft = mReq_Num;             // REQ_NUM           //신청번호
                    object vHeaderCenter = mDuty_Manager_Name; // DUTY_MANAGER_NAME //작업장
                    object vHeaderRight = mReq_Person_Name;    // REQ_PERSON_NAME   //신청자

                    XLHeader(vType, vTitle, vHeaderLeft, vHeaderCenter, vHeaderRight); //제목타입, 제목, 신청번호, 작업장, 신청자

                    //[Footer]
                    string vFooterLeft = string.Format("[ {0} {1} ]", vPrintingDate, vPrintingTime);
                    string vFooterRight = string.Format("Page : {0}", vPageNumber);
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
