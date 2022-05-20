using System;
using ISCommonUtil;

namespace PPMF0606
{
    public class XLPrinting
    {
        #region ----- Variables -----

        ISFunction.ISConvert iString = new ISFunction.ISConvert();
        ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        private InfoSummit.Win.ControlAdv.ISAppInterface mAppInterface = null;
        private InfoSummit.Win.ControlAdv.ISMessageAdapter mMessageAdapter = null;

        private XL.XLPrint mPrinting = null;

        // 쉬트명 정의.
        private string mTargetSheet = "DESTINATION";
        private string mSourceSheet1 = "SOURCE1";
        //private string mSourceSheet2 = "SOURCE2";
        
        private string mMessageError = string.Empty;
        private string mXLOpenFileName = string.Empty;

        private int mPageTotalNumber = 0;
        private int mPageNumber = 0;

        private bool mIsNewPage = false;  // 첫 페이지 체크.
        
        // 인쇄된 라인에 합계.
        private int mCopyLineSUM = 0;

        // 인쇄 1장의 최대 인쇄정보.
        private int mCopy_StartCol = 1;
        private int mCopy_StartRow = 1;
        private int mCopy_EndCol = 63;
        private int mCopy_EndRow = 94;
        private int mPrintingLastRow = 92;  //최종 인쇄 라인.

        private int mCurrentStartRow = 14;
        private int mCurrentRow = 14;       //현재 인쇄되는 row 위치.
        private int mCurrentRowAdd = 15;     //페이지 증가후 기본적으로 증가해야 할 row수.
        private int mDefaultPageRow = 12;    // 페이지 증가후 PageCount 기본값.
        
        //보증금, 월세, 합계, 보증금이자, 월세(계) 총합계.
        private decimal mTOT_DEPOSIT_AMOUNT = 0;
        private decimal mTOT_MONTHLY_RENT_AMOUNT = 0;
        private decimal mTOT_LEASE_SUM_AMOUNT = 0;
        private decimal mTOT_DEPOSIT_INTEREST_AMT = 0;
        private decimal mTOT_MONTHLY_RENT_SUM_AMT = 0;

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
        {// 파일명 뒤에 일련번호 증가.
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

        private void SetArray1(InfoSummit.Win.ControlAdv.ISGridAdvEx pGrid, out int[] pGDColumn, out int[] pXLColumn)
        {// 그리드의 컬럼에 대한 컬럼인덱스 값 산출
            pGDColumn = new int[6];
            pXLColumn = new int[6];
            // 그리드 or 아답터 위치.
            pGDColumn[0] = pGrid.GetColumnToIndex("LOCATION_NAME");
            pGDColumn[1] = pGrid.GetColumnToIndex("ITEM_CODE");
            pGDColumn[2] = pGrid.GetColumnToIndex("ITEM_DESCRIPTION");
            pGDColumn[3] = pGrid.GetColumnToIndex("UOM_CODE");
            pGDColumn[4] = pGrid.GetColumnToIndex("ONHAND_QTY");
            pGDColumn[5] = pGrid.GetColumnToIndex("ACTUAL_ONHAND");
                        
            // 엑셀에 인쇄해야 할 위치.
            pXLColumn[0] = 2;
            pXLColumn[1] = 16;
            pXLColumn[2] = 32;
            pXLColumn[3] = 48;
            pXLColumn[4] = 51;
            pXLColumn[5] = 57;
        }

        #endregion;

        #region ----- Array Set 2 ----

        //private void SetArray2(InfoSummit.Win.ControlAdv.ISGridAdvEx pGrid, out int[] pGDColumn, out int[] pXLColumn)
        //{// 그리드의 컬럼에 대한 컬럼인덱스 값 산출
        //    pGDColumn = new int[3];
        //    pXLColumn = new int[3];
        //    // 그리드 or 아답터 위치.
        //    pGDColumn[0] = pGrid.GetColumnToIndex("VAT_COUNT");
        //    pGDColumn[1] = pGrid.GetColumnToIndex("GL_AMOUNT");
        //    pGDColumn[2] = pGrid.GetColumnToIndex("VAT_AMOUNT");

        //    // 엑셀에 인쇄해야 할 위치.
        //    pXLColumn[0] = 20;
        //    pXLColumn[1] = 25;
        //    pXLColumn[2] = 30;
        //}

        #endregion;

        #region ----- Array Set 2  : Adapter 적용시 ----

        //private void SetArray2(System.Data.DataTable pTable, out int[] pGDColumn, out int[] pXLColumn)
        //{// 아답터의 table 값.
        //    pGDColumn = new int[10];
        //    pXLColumn = new int[10];

        //    pGDColumn[0] = pTable.Columns.IndexOf("PO_TYPE_NAME");
        //    pGDColumn[1] = pTable.Columns.IndexOf("DISPLAY_NAME");
        //    pGDColumn[2] = pTable.Columns.IndexOf("PO_DATE");
        //    pGDColumn[3] = pTable.Columns.IndexOf("PO_NO");
        //    pGDColumn[4] = pTable.Columns.IndexOf("SUPPLIER_SHORT_NAME");
        //    pGDColumn[5] = pTable.Columns.IndexOf("PRICE_TERM_NAME");
        //    pGDColumn[6] = pTable.Columns.IndexOf("PAYMENT_METHOD_NAME");
        //    pGDColumn[7] = pTable.Columns.IndexOf("PAYMENT_TERM_NAME");
        //    pGDColumn[8] = pTable.Columns.IndexOf("REMARK");
        //    pGDColumn[9] = pTable.Columns.IndexOf("STEP_DESCRIPTION");


        //    pXLColumn[0] = 9;   //PO_TYPE_NAME
        //    pXLColumn[1] = 25;  //DISPLAY_NAME
        //    pXLColumn[2] = 42;  //PO_DATE
        //    pXLColumn[3] = 54;  //PO_NO
        //    pXLColumn[4] = 9;   //SUPPLIER_SHORT_NAME
        //    pXLColumn[5] = 35;  //PRICE_TERM_NAME
        //    pXLColumn[6] = 14;  //PAYMENT_METHOD_NAME
        //    pXLColumn[7] = 41;  //PAYMENT_TERM_NAME
        //    pXLColumn[8] = 7;   //REMARK
        //    pXLColumn[9] = 49;  //금액
        //}

        #endregion;

        #region ----- IsConvert Methods -----

        private bool IsConvertString(object pObject, out string pConvertString)
        {// 문자열 여부 체크 및 해당 값 리턴.
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
        {// 숫자 여부 체크 및 해당 값 리턴.
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
        {// 날짜 여부 체크 및 해당 값 리턴.
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

        #region ----- Header Write Method ----

        public void HeaderWrite(object pPRINTED_PERSON_NAME, object pPRINTED_DATE, object pPERIOD_NAME)
        {// 헤더 인쇄.
            int vXLine = 0;
            int vXLColumn = 0;

            try
            {
                mPrinting.XLActiveSheet(mSourceSheet1);

                // 출력자
                vXLine = 7;
                vXLColumn = 7;
                mPrinting.XLSetCell(vXLine, vXLColumn, pPRINTED_PERSON_NAME);

                vXLine = 9;
                vXLColumn = 7;
                mPrinting.XLSetCell(vXLine, vXLColumn, pPRINTED_DATE);

                vXLine = 1;
                vXLColumn = 13;
                mPrinting.XLSetCell(vXLine, vXLColumn, pPERIOD_NAME);
            }
            catch (System.Exception ex)
            {
                mMessageError = ex.Message;
                mAppInterface.OnAppMessageEvent(mMessageError);
                System.Windows.Forms.Application.DoEvents();
            }
        }

        #endregion;

        #region ----- Header1 Write Method ----

        private void XLHeader1(object pWAREHOUSE_NAME)
        {// 헤더 인쇄.
            int vXLine = 1; //엑셀에 내용이 표시되는 행 번호
            int vXLColumnIndex = 0;

            // 사용되는 형식 지정.
            //object vObject = null;
            string vConvertString = string.Empty;
            bool IsConvert = false;

            try
            { // 원본을 복사해서 타겟 에 복사해 넣음.
                mPrinting.XLActiveSheet(mSourceSheet1);

                vXLine = 5;
                vXLColumnIndex = 19;
                IsConvert = IsConvertString(pWAREHOUSE_NAME, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("창고명 : {0}", vConvertString);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                //공정명 : 필요 없음.
                //vXLine = 5;
                //vXLColumnIndex = 7;
                //IsConvert = IsConvertString(pOPERATION_DESC, out vConvertString);
                //if (IsConvert == true)
                //{
                //    vConvertString = string.Format("{0}", vConvertString);
                //    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                //}
                //else
                //{
                //    vConvertString = string.Empty;
                //    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                //}

            }
            catch (System.Exception ex)
            {
                mMessageError = ex.Message;
                mAppInterface.OnAppMessageEvent(mMessageError);
                System.Windows.Forms.Application.DoEvents();
            }
        }

        #endregion;

        #region ----- Line Write -----

        private int XLLine(InfoSummit.Win.ControlAdv.ISGridAdvEx pGrid, int pGridRow, int pXLine, int[] pGDColumn, int[] pXLColumn)
        {// pGridRow : 그리드의 현재 읽는 행, pXLine : 엑셀의 인쇄해야 하는 행. pGDColumn : 그리드 위치, pXLColumn : 엑셀 위치.
            int vXLine = pXLine; //엑셀에 내용이 표시되는 행 번호

            int vGDColumnIndex = 0;
            int vXLColumnIndex = 0;
                        
            // 사용되는 형식 지정.
            object vObject = null;
            string vConvertString = string.Empty;
            decimal vConvertDecimal = 0m;
            bool IsConvert = false;

            try
            { // 원본을 복사해서 타겟 에 복사해 넣음.(
                mPrinting.XLActiveSheet(mTargetSheet);
                
                //0
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
                //1 
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
                //2 
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
                //3
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
                //4-수량
                vGDColumnIndex = pGDColumn[4];
                vXLColumnIndex = pXLColumn[4];
                vObject = pGrid.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:###,###,###,###,###,###,###,###.#######}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }   
                //5-실사수량.
                vGDColumnIndex = pGDColumn[5];
                vXLColumnIndex = pXLColumn[5];
                vObject = pGrid.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:###,###,###,###,###,###,###,###}", vConvertDecimal);
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

        #region ----- TOTAL AMOUNT Write Method -----

        private int XL_TOTAL_Line(int pXLine, int[] pXLColumn)
        {// pGridRow : 그리드의 현재 읽는 행, pXLine : 엑셀의 인쇄해야 하는 행. pGDColumn : 그리드 위치, pXLColumn : 엑셀 위치.
            int vXLine = pXLine; //엑셀에 내용이 표시되는 행 번호

            int vXLColumnIndex = 0;

            string vConvertString = string.Empty;
            decimal vConvertDecimal = 0m;
            bool IsConvert = false;

            try
            { // 원본을 복사해서 타겟 에 복사해 넣음.(
                mPrinting.XLActiveSheet(mTargetSheet);

                //10 - 보증금
                vXLColumnIndex = pXLColumn[10];
                IsConvert = IsConvertNumber(mTOT_DEPOSIT_AMOUNT, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:###,###,###,###,###,###,###,###}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                //11 - 월임대료
                vXLColumnIndex = pXLColumn[11];
                IsConvert = IsConvertNumber(mTOT_MONTHLY_RENT_AMOUNT, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:###,###,###,###,###,###,###,###}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                //12 - 합계
                vXLColumnIndex = pXLColumn[12];
                IsConvert = IsConvertNumber(mTOT_LEASE_SUM_AMOUNT, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:###,###,###,###,###,###,###,###}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                //13 - 보증금이자
                vXLColumnIndex = pXLColumn[13];
                IsConvert = IsConvertNumber(mTOT_DEPOSIT_INTEREST_AMT, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:###,###,###,###,###,###,###,###}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                //14 - 월임대료(계)
                vXLColumnIndex = pXLColumn[14];
                IsConvert = IsConvertNumber(mTOT_MONTHLY_RENT_SUM_AMT, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:###,###,###,###,###,###,###,###}", vConvertDecimal);
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

        #endregion;

        #region ----- Excel Wirte [Line] Methods ----

        public int LineWrite(string pOutChoice, InfoSummit.Win.ControlAdv.ISGridAdvEx pGrid
                            , object pPRINTED_PERSON_NAME, object pPRINTED_DATE, object pPERIOD_NAME)
        {// 실제 호출되는 부분.
            mPageNumber = 0;
            string vMessage = string.Empty;

            string vOLD_WAREHOUSE_CODE = string.Empty;
            string vWAREHOUSE_CODE = string.Empty;

            string vPrintingDate = System.DateTime.Now.ToString("yyyy-MM-dd", null);
            string vPrintingTime = System.DateTime.Now.ToString("HH:mm:ss", null);

            //작어장 및 공정.
            int mIDX_WAREHOUSE_CODE = pGrid.GetColumnToIndex("WAREHOUSE_CODE");
            int mIDX_WAREHOUSE_NAME = pGrid.GetColumnToIndex("WAREHOUSE_NAME");

            int[] vGDColumn;
            int[] vXLColumn;
            int vTotalRow = 0;
            int vPageRowCount = 0;
            try
            {
                // 실제인쇄되는 행수.
                //int vBy = 35;         
                vTotalRow = pGrid.RowCount;
                vPageRowCount = mCurrentRow - 2;    //첫장에 대해서는 시작row부터 체크.

                //mPageTotalNumber = vTotal1ROW / vBy;  // 현재 인쇄 장수 / 총 장수 표시 위해.
                //mPageTotalNumber = (vTotal1ROW % vBy) == 0 ? mPageTotalNumber : (mPageTotalNumber + 1);
                // ? 기준 앞에 비교 문장이고 : 기준으로 앞이 참, 뒤가 거짓.
                
                #region ----- Line Write ----

                if (vTotalRow > 0)
                {
                    
                    SetArray1(pGrid, out vGDColumn, out vXLColumn);
                    for (int vRow = 0; vRow < vTotalRow; vRow++)
                    {
                        vMessage = string.Format("Printing : {0}/{1}", vRow, vTotalRow);
                        mAppInterface.OnAppMessageEvent(vMessage);
                        System.Windows.Forms.Application.DoEvents();
                        
                        //-- 다른 작업장일 경우 page skip --//
                        vWAREHOUSE_CODE = iString.ISNull(pGrid.GetCellValue(vRow, mIDX_WAREHOUSE_CODE));
                        if (mPageNumber == 0)
                        {//첫장 인쇄.
                            #region ----- Header Write ----
                            // 헤더 인쇄.
                            HeaderWrite(pPRINTED_PERSON_NAME, pPRINTED_DATE, pPERIOD_NAME);
                            XLHeader1(pGrid.GetCellValue(vRow, mIDX_WAREHOUSE_NAME));

                            #endregion;
                            mCopyLineSUM = CopyAndPaste(mPrinting, mSourceSheet1, 1);
                            mCurrentRow = mCurrentStartRow;  // 여러장 인쇄시 해당 페이지의 시작되는 위치.
                            vPageRowCount = mDefaultPageRow;
                        } 
                        else if (vOLD_WAREHOUSE_CODE != vWAREHOUSE_CODE)
                        {//작업장이 다를 경우.
                            XLHeader1(pGrid.GetCellValue(vRow, mIDX_WAREHOUSE_NAME));
                            mCurrentRow = mCurrentRow + (mPrintingLastRow - vPageRowCount);
                            
                            IsNewPage(mPrintingLastRow, pOutChoice, pPRINTED_PERSON_NAME, pPRINTED_DATE, pPERIOD_NAME);   // 새로운 페이지 체크 및 생성.
                            mCurrentRow = mCurrentRow + mCurrentRowAdd;  // 여러장 인쇄시 해당 페이지의 시작되는 위치.
                            vPageRowCount = mDefaultPageRow;
                        }
                        else
                        {
                            XLHeader1(pGrid.GetCellValue(vRow, mIDX_WAREHOUSE_NAME));
                        }
                        vOLD_WAREHOUSE_CODE = iString.ISNull(pGrid.GetCellValue(vRow, mIDX_WAREHOUSE_CODE));
                        //---------------------------------//

                        mCurrentRow = XLLine(pGrid, vRow, mCurrentRow, vGDColumn, vXLColumn); // 현재 위치 인쇄 후 다음 인쇄행 리턴.
                        vPageRowCount = vPageRowCount + 2;
                                                

                        if (vRow == vTotalRow - 1)
                        {
                            //총합계 인쇄.
                        }
                        else
                        {
                            IsNewPage(vPageRowCount, pOutChoice, pPRINTED_PERSON_NAME, pPRINTED_DATE, pPERIOD_NAME);   // 새로운 페이지 체크 및 생성.
                            if (mIsNewPage == true)
                            {    
                                mCurrentRow = mCurrentRow + mCurrentRowAdd;  // 여러장 인쇄시 해당 페이지의 시작되는 위치.
                                vPageRowCount = mDefaultPageRow;
                            }
                        }
                    }
                }
                #endregion;

                //출력구분에 따른 선택(인쇄 or file 저장)
                if (pOutChoice == "PRINT")
                {
                    Printing(1, mPageNumber);
                }
                else if (pOutChoice == "FILE")
                {
                    SAVE("SFG_");
                }

                //-------------------------------------------------------------------------------------
                Dispose();
                //----------------------------------------------------------------------------------

            }
            catch (System.Exception ex)
            {
                //-------------------------------------------------------------------------------------
                Dispose();
                //----------------------------------------------------------------------------------

                mMessageError = ex.Message;
                mPrinting.XLOpenFileClose();
                mPrinting.XLClose();
            }
            return mPageTotalNumber;
        }

        #endregion;

        #region ----- New Page iF Methods ----

        private void IsNewPage(int pPageRowCount, string pOutChoice, object pPRINTED_PERSON_NAME, object pPRINTED_DATE, object pPERIOD_NAME)
        {
            string vMessage = string.Empty;

            if (pPageRowCount == mPrintingLastRow)
            { // pPrintingLine : 현재 출력된 행.
                if (mPageNumber == 5 && pOutChoice == "PRINT")
                {
                    Printing(1, mPageNumber);   //인쇄.
                    mPrinting.XLOpenFileClose();

                    bool isOpen = XLFileOpen();
                    mPageNumber = 0;                    
                }
                else
                {                    
                    mCopyLineSUM = CopyAndPaste(mPrinting, mSourceSheet1, mCurrentRow + 2);
                }
                mIsNewPage = true;
            }
            else
            {
                mIsNewPage = false;
            }
        }

        #endregion;

        #region ----- Copy&Paste Sheet Method ----

        //지정한 ActiveSheet의 범위에 대해  페이지 복사
        private int CopyAndPaste(XL.XLPrint pPrinting, string pActiveSheet, int pPasteStartRow)
        {
            int vPasteEndRow = pPasteStartRow + mCopy_EndRow;

            //[원본], [Sheet2.Cell("A1:AS67")], 엑셀 쉬트에서 복사 시작할 행번호, 
            //엑셀 쉬트에서 복사 시작할 열번호, 엑셀 쉬트에서 복사 종료할 행번호, 엑셀 쉬트에서 복사 종료할 열번호
            pPrinting.XLActiveSheet(pActiveSheet);            
            object vRangeSource = pPrinting.XLGetRange(mCopy_StartRow, mCopy_StartCol, mCopy_EndRow, mCopy_EndCol);

            //[대상], [Sheet1.Cell("A1:AS67")], 엑셀 쉬트에서 복사 시작할 행번호, 
            //엑셀 쉬트에서 복사 시작할 열번호, 엑셀 쉬트에서 복사 종료할 행번호, 엑셀 쉬트에서 복사 종료할 열번호
            pPrinting.XLActiveSheet(mTargetSheet);
            object vRangeDestination = pPrinting.XLGetRange(pPasteStartRow, mCopy_StartCol, vPasteEndRow, mCopy_EndCol); 
            pPrinting.XLCopyRange(vRangeSource, vRangeDestination);  // 복사.


            mPageNumber++; //페이지 번호
            mPageTotalNumber++; //총페이지번호.
            return vPasteEndRow;


            //int vCopySumPrintingLine = pCopySumPrintingLine;

            //int vCopyPrintingRowSTART = vCopySumPrintingLine;
            //vCopySumPrintingLine = vCopySumPrintingLine + mIncrementCopyMAX;
            //int vCopyPrintingRowEnd = vCopySumPrintingLine;

            //pPrinting.XLActiveSheet("SourceTab1");
            //object vRangeSource = pPrinting.XLGetRange(mCopyColumnSTART, 1, mIncrementCopyMAX, mCopyColumnEND); //[원본], [Sheet2.Cell("A1:AS67")], 엑셀 쉬트에서 복사 시작할 행번호, 엑셀 쉬트에서 복사 시작할 열번호, 엑셀 쉬트에서 복사 종료할 행번호, 엑셀 쉬트에서 복사 종료할 열번호
            //pPrinting.XLActiveSheet("Destination");
            //object vRangeDestination = pPrinting.XLGetRange(vCopyPrintingRowSTART, 1, vCopyPrintingRowEnd, mCopyColumnEND); //[대상], [Sheet1.Cell("A1:AS67")], 엑셀 쉬트에서 복사 시작할 행번호, 엑셀 쉬트에서 복사 시작할 열번호, 엑셀 쉬트에서 복사 종료할 행번호, 엑셀 쉬트에서 복사 종료할 열번호
            //pPrinting.XLCopyRange(vRangeSource, vRangeDestination);  // 복사.


            //mPageNumber++; //페이지 번호
            //// 페이지 번호 표시.
            ////string vPageNumberText = string.Format("Page {0}/{1}", mPageNumber, mPageTotalNumber);
            ////int vRowSTART = vCopyPrintingRowEnd - 2;
            ////int vRowEND = vCopyPrintingRowEnd - 2;
            ////int vColumnSTART = 30;
            ////int vColumnEND = 33;
            ////mPrinting.XLCellMerge(vRowSTART, vColumnSTART, vRowEND, vColumnEND, false);
            ////mPrinting.XLSetCell(vRowSTART, vColumnSTART, vPageNumberText); //페이지 번호, XLcell[행, 열]

            //return vCopySumPrintingLine;
        }

        #endregion;

        #region ----- Printing Methods ----

        public void Printing(int pPageSTART, int pPageEND)
        {
            //mPrinting.XLPreviewPrinting(pPageSTART, pPageEND, 1);
            mPrinting.XLPrinting(pPageSTART, pPageEND, 1);
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
