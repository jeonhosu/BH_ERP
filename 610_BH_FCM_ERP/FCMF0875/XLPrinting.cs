using System;

namespace FCMF0875
{
    public class XLPrinting
    {
        #region ----- Variables -----

        private InfoSummit.Win.ControlAdv.ISAppInterface mAppInterface = null;
        private InfoSummit.Win.ControlAdv.ISMessageAdapter mMessageAdapter = null;

        private XL.XLPrint mPrinting = null;

        private string mMessageError = string.Empty;

        private int mPageNumber = 0;

        private bool mIsNewPage = false;

        private bool mIsSecondPageWriting = false; //2번째 페이지가 출력 되는가?

        private string mXLOpenFileName = string.Empty;

        private int mPrintingLineSTART_SOURCE1 = 16;  //Line
        private int mPrintingLineSTART_SOURCE2 = 8;   //Line

        private int mCopyLineSUM = 1;        //엑셀의 선택된 쉬트의 복사되어질 시작 행 위치, 복사 행 누적
        private int mIncrementCopyMAX = 32;  //복사되어질 행의 범위

        private int mCopyColumnSTART = 1; //복사되어  진 행 누적 수
        private int mCopyColumnEND = 44;  //엑셀의 선택된 쉬트의 복사되어질 끝 열 위치

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

        private void SetArray1(InfoSummit.Win.ControlAdv.ISGridAdvEx pGrid, out int[] pGDColumn, out int[] pXLColumn)
        {
            pGDColumn = new int[7];
            pXLColumn = new int[7];

            pGDColumn[0] = pGrid.GetColumnToIndex("SEQ"); //출력_일련번호
            pGDColumn[1] = pGrid.GetColumnToIndex("EXPORT_NO"); //수출신고번호
            pGDColumn[2] = pGrid.GetColumnToIndex("VAT_ISSUE_DATE"); //선(기)적일자
            pGDColumn[3] = pGrid.GetColumnToIndex("CURRENCY_CODE"); //통화코드
            pGDColumn[4] = pGrid.GetColumnToIndex("PRINT_EXCHANGE_RATE"); //환율_출력용
            pGDColumn[5] = pGrid.GetColumnToIndex("PRINT_CURRENCY_AMOUNT"); //외화금액_출력용
            pGDColumn[6] = pGrid.GetColumnToIndex("GL_AMOUNT"); //원화


            pXLColumn[0] = 2;   //출력_일련번호
            pXLColumn[1] = 4;   //수출신고번호
            pXLColumn[2] = 14;  //선(기)적일자
            pXLColumn[3] = 19;  //통화코드
            pXLColumn[4] = 23;  //환율_출력용
            pXLColumn[5] = 28;  //외화금액_출력용
            pXLColumn[6] = 36;  //원화
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

        #region ----- Header Write Method ----

        private void XLHeader(InfoSummit.Win.ControlAdv.ISDataAdapter p_adapter_PRINT_EXPORT_RESULT_TITLE)
        {
            int vCountRow = 0;
            int vXLine = 0;
            int vXLColumn = 0;
            object vObject = null;
            string vConvertString = string.Empty;
            bool IsConvert = false;

            try
            {
                vCountRow = p_adapter_PRINT_EXPORT_RESULT_TITLE.OraSelectData.Rows.Count;

                if (vCountRow > 0)
                {
                    mPrinting.XLActiveSheet("SOURCE2");

                    //부가가치세신고기수
                    vObject = p_adapter_PRINT_EXPORT_RESULT_TITLE.OraSelectData.Rows[0]["FISCAL_YEAR"];
                    vXLine = 4;
                    vXLColumn = 2;
                    IsConvert = IsConvertString(vObject, out vConvertString);
                    if (IsConvert == true)
                    {
                        vConvertString = string.Format("{0}", vConvertString);
                        mPrinting.XLSetCell(vXLine, vXLColumn, vConvertString);
                    }
                    else
                    {
                        vConvertString = string.Empty;
                        mPrinting.XLSetCell(vXLine, vXLColumn, vConvertString);
                    }

                    //사업자등록번호
                    vObject = p_adapter_PRINT_EXPORT_RESULT_TITLE.OraSelectData.Rows[0]["VAT_NUMBER"];
                    vXLine = 5;
                    vXLColumn = 27;
                    IsConvert = IsConvertString(vObject, out vConvertString);
                    if (IsConvert == true)
                    {
                        vConvertString = string.Format("{0}", vConvertString);
                        mPrinting.XLSetCell(vXLine, vXLColumn, vConvertString);
                    }
                    else
                    {
                        vConvertString = string.Empty;
                        mPrinting.XLSetCell(vXLine, vXLColumn, vConvertString);
                    }

                    mPrinting.XLActiveSheet("SOURCE1");

                    //부가가치세신고기수
                    vObject = p_adapter_PRINT_EXPORT_RESULT_TITLE.OraSelectData.Rows[0]["FISCAL_YEAR"];
                    vXLine = 4;
                    vXLColumn = 2;
                    IsConvert = IsConvertString(vObject, out vConvertString);
                    if (IsConvert == true)
                    {
                        vConvertString = string.Format("{0}", vConvertString);
                        mPrinting.XLSetCell(vXLine, vXLColumn, vConvertString);
                    }
                    else
                    {
                        vConvertString = string.Empty;
                        mPrinting.XLSetCell(vXLine, vXLColumn, vConvertString);
                    }

                    //사업자등록번호
                    vObject = p_adapter_PRINT_EXPORT_RESULT_TITLE.OraSelectData.Rows[0]["VAT_NUMBER"];
                    vXLine = 5;
                    vXLColumn = 10;
                    IsConvert = IsConvertString(vObject, out vConvertString);
                    if (IsConvert == true)
                    {
                        vConvertString = string.Format("{0}", vConvertString);
                        mPrinting.XLSetCell(vXLine, vXLColumn, vConvertString);
                    }
                    else
                    {
                        vConvertString = string.Empty;
                        mPrinting.XLSetCell(vXLine, vXLColumn, vConvertString);
                    }

                    //상호(법인명)
                    vObject = p_adapter_PRINT_EXPORT_RESULT_TITLE.OraSelectData.Rows[0]["CORP_NAME"];
                    vXLine = 5;
                    vXLColumn = 27;
                    IsConvert = IsConvertString(vObject, out vConvertString);
                    if (IsConvert == true)
                    {
                        vConvertString = string.Format("{0}", vConvertString);
                        mPrinting.XLSetCell(vXLine, vXLColumn, vConvertString);
                    }
                    else
                    {
                        vConvertString = string.Empty;
                        mPrinting.XLSetCell(vXLine, vXLColumn, vConvertString);
                    }

                    //성명(대표자)
                    vObject = p_adapter_PRINT_EXPORT_RESULT_TITLE.OraSelectData.Rows[0]["PRESIDENT_NAME"];
                    vXLine = 6;
                    vXLColumn = 10;
                    IsConvert = IsConvertString(vObject, out vConvertString);
                    if (IsConvert == true)
                    {
                        vConvertString = string.Format("{0}", vConvertString);
                        mPrinting.XLSetCell(vXLine, vXLColumn, vConvertString);
                    }
                    else
                    {
                        vConvertString = string.Empty;
                        mPrinting.XLSetCell(vXLine, vXLColumn, vConvertString);
                    }

                    //사업장소재지(전화번호)
                    vObject = p_adapter_PRINT_EXPORT_RESULT_TITLE.OraSelectData.Rows[0]["LOCATION"];
                    vXLine = 6;
                    vXLColumn = 27;
                    IsConvert = IsConvertString(vObject, out vConvertString);
                    if (IsConvert == true)
                    {
                        vConvertString = string.Format("{0}", vConvertString);
                        mPrinting.XLSetCell(vXLine, vXLColumn, vConvertString);
                    }
                    else
                    {
                        vConvertString = string.Empty;
                        mPrinting.XLSetCell(vXLine, vXLColumn, vConvertString);
                    }

                    //업태
                    vObject = p_adapter_PRINT_EXPORT_RESULT_TITLE.OraSelectData.Rows[0]["BUSINESS_ITEM"];
                    vXLine = 7;
                    vXLColumn = 10;
                    IsConvert = IsConvertString(vObject, out vConvertString);
                    if (IsConvert == true)
                    {
                        vConvertString = string.Format("{0}", vConvertString);
                        mPrinting.XLSetCell(vXLine, vXLColumn, vConvertString);
                    }
                    else
                    {
                        vConvertString = string.Empty;
                        mPrinting.XLSetCell(vXLine, vXLColumn, vConvertString);
                    }

                    //종목
                    vObject = p_adapter_PRINT_EXPORT_RESULT_TITLE.OraSelectData.Rows[0]["BUSINESS_TYPE"];
                    vXLine = 7;
                    vXLColumn = 27;
                    IsConvert = IsConvertString(vObject, out vConvertString);
                    if (IsConvert == true)
                    {
                        vConvertString = string.Format("{0}", vConvertString);
                        mPrinting.XLSetCell(vXLine, vXLColumn, vConvertString);
                    }
                    else
                    {
                        vConvertString = string.Empty;
                        mPrinting.XLSetCell(vXLine, vXLColumn, vConvertString);
                    }

                    //거래기간
                    vObject = p_adapter_PRINT_EXPORT_RESULT_TITLE.OraSelectData.Rows[0]["DEAL_TERM"];
                    vXLine = 8;
                    vXLColumn = 10;
                    IsConvert = IsConvertString(vObject, out vConvertString);
                    if (IsConvert == true)
                    {
                        vConvertString = string.Format("{0}", vConvertString);
                        mPrinting.XLSetCell(vXLine, vXLColumn, vConvertString);
                    }
                    else
                    {
                        vConvertString = string.Empty;
                        mPrinting.XLSetCell(vXLine, vXLColumn, vConvertString);
                    }

                    //작성일자
                    vObject = p_adapter_PRINT_EXPORT_RESULT_TITLE.OraSelectData.Rows[0]["CREATE_DATE"];
                    vXLine = 8;
                    vXLColumn = 35;
                    IsConvert = IsConvertString(vObject, out vConvertString);
                    if (IsConvert == true)
                    {
                        vConvertString = string.Format("{0}", vConvertString);
                        mPrinting.XLSetCell(vXLine, vXLColumn, vConvertString);
                    }
                    else
                    {
                        vConvertString = string.Empty;
                        mPrinting.XLSetCell(vXLine, vXLColumn, vConvertString);
                    }
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

        #region ----- Sum Write Method ----

        private void XLSUM(InfoSummit.Win.ControlAdv.ISGridAdvEx p_grid_UP_EXPORT_RESULT)
        {
            int vCountRow = 0;
            int vGDColumnIndex = 0;
            int vXLine = 10;
            int vXLColumn = 0;
            object vObject = null;
            string vConvertString = string.Empty;
            decimal vConvertDecimal = 0m;
            bool IsConvert = false;

            decimal vGuBun = 0;

            try
            {
                vCountRow = p_grid_UP_EXPORT_RESULT.RowCount;

                if (vCountRow > 0)
                {
                    mPrinting.XLActiveSheet("SOURCE1");

                    for (int vRow = 0; vRow < vCountRow; vRow++)
                    {
                        vGDColumnIndex = p_grid_UP_EXPORT_RESULT.GetColumnToIndex("SEQ");
                        vObject = p_grid_UP_EXPORT_RESULT.GetCellValue(vRow, vGDColumnIndex);
                        IsConvert = IsConvertString(vObject, out vConvertString);
                        if (IsConvert == true)
                        {
                            vGuBun = decimal.Parse(vConvertString);

                            if (vGuBun == 9)
                            {
                                vXLine = 10;
                            }
                            else if (vGuBun == 10)
                            {
                                vXLine = 11;
                            }
                            else if (vGuBun == 11)
                            {
                                vXLine = 12;
                            }
                        }

                        //건수
                        vGDColumnIndex = p_grid_UP_EXPORT_RESULT.GetColumnToIndex("DATA_CNT");
                        vObject = p_grid_UP_EXPORT_RESULT.GetCellValue(vRow, vGDColumnIndex);
                        vXLColumn = 17;
                        IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                        if (IsConvert == true)
                        {
                            vConvertString = string.Format("{0:##,###,###,###,###,###,###,###,###}", vConvertDecimal);
                            mPrinting.XLSetCell(vXLine, vXLColumn, vConvertString);
                        }
                        else
                        {
                            vConvertString = string.Empty;
                            mPrinting.XLSetCell(vXLine, vXLColumn, vConvertString);
                        }

                        //외화금액
                        vGDColumnIndex = p_grid_UP_EXPORT_RESULT.GetColumnToIndex("CURRENCY_AMOUNT");
                        vObject = p_grid_UP_EXPORT_RESULT.GetCellValue(vRow, vGDColumnIndex);
                        vXLColumn = 23;
                        IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                        if (IsConvert == true)
                        {
                            vConvertString = string.Format("{0:##,###,###,###,###,###,###,###,###.##}", vConvertDecimal);
                            mPrinting.XLSetCell(vXLine, vXLColumn, vConvertString);

                            if (vGuBun == 10)
                            {
                                mPrinting.XLSetCell(15, 28, vConvertString);
                            }
                        }
                        else
                        {
                            vConvertString = string.Empty;
                            mPrinting.XLSetCell(vXLine, vXLColumn, vConvertString);
                        }

                        //원화금액
                        vGDColumnIndex = p_grid_UP_EXPORT_RESULT.GetColumnToIndex("GL_AMOUNT");
                        vObject = p_grid_UP_EXPORT_RESULT.GetCellValue(vRow, vGDColumnIndex);
                        vXLColumn = 31;
                        IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                        if (IsConvert == true)
                        {
                            vConvertString = string.Format("{0:##,###,###,###,###,###,###,###,###}", vConvertDecimal);
                            mPrinting.XLSetCell(vXLine, vXLColumn, vConvertString);

                            if (vGuBun == 10)
                            {
                                mPrinting.XLSetCell(15, 36, vConvertString);
                            }
                        }
                        else
                        {
                            vConvertString = string.Empty;
                            mPrinting.XLSetCell(vXLine, vXLColumn, vConvertString);
                        }

                        //비고
                        vGDColumnIndex = p_grid_UP_EXPORT_RESULT.GetColumnToIndex("REMARKS");
                        vObject = p_grid_UP_EXPORT_RESULT.GetCellValue(vRow, vGDColumnIndex);
                        vXLColumn = 39;
                        IsConvert = IsConvertString(vObject, out vConvertString);
                        if (IsConvert == true)
                        {
                            vConvertString = string.Format("{0}", vConvertString);
                            mPrinting.XLSetCell(vXLine, vXLColumn, vConvertString);
                        }
                        else
                        {
                            vConvertString = string.Empty;
                            mPrinting.XLSetCell(vXLine, vXLColumn, vConvertString);
                        }
                    }
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

        private int XLLine(InfoSummit.Win.ControlAdv.ISGridAdvEx pGrid, int pGridRow, int pXLine, int[] pGDColumn, int[] pXLColumn)
        {
            int vXLine = pXLine; //엑셀에 내용이 표시되는 행 번호

            int vGDColumnIndex = 0;
            int vXLColumnIndex = 0;

            object vObject = null;
            string vConvertString = string.Empty;
            decimal vConvertDecimal = 0m;
            bool IsConvert = false;

            try
            {
                mPrinting.XLActiveSheet("DESTINATION");

                //출력_일련번호
                vGDColumnIndex = pGDColumn[0];
                vXLColumnIndex = pXLColumn[0];
                vObject = pGrid.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:##,###,###,###,###,###,###,###,###}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                //수출신고번호
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

                //선(기)적일자
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

                //통화코드
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

                //환율_출력용
                vGDColumnIndex = pGDColumn[4];
                vXLColumnIndex = pXLColumn[4];
                vObject = pGrid.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertDecimal = decimal.Parse(vConvertString);
                    vConvertString = string.Format("{0:##,###,###,###,###,###,###,###,###.00}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                //외화금액_출력용
                vGDColumnIndex = pGDColumn[5];
                vXLColumnIndex = pXLColumn[5];
                vObject = pGrid.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertDecimal = decimal.Parse(vConvertString);
                    vConvertString = string.Format("{0:##,###,###,###,###,###,###,###,###.00}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                //원화
                vGDColumnIndex = pGDColumn[6];
                vXLColumnIndex = pXLColumn[6];
                vObject = pGrid.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:##,###,###,###,###,###,###,###,###}", vConvertDecimal);
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

        public int LineWrite(InfoSummit.Win.ControlAdv.ISGridAdvEx p_grid_UP_EXPORT_RESULT, InfoSummit.Win.ControlAdv.ISGridAdvEx p_grid_LIST_EXPORT_RESULT, InfoSummit.Win.ControlAdv.ISDataAdapter p_adapter_PRINT_EXPORT_RESULT_TITLE)
        {
            mPageNumber = 0;
            string vMessage = string.Empty;

            int[] vGDColumn;
            int[] vXLColumn;

            int vPrintingLine = 0;

            try
            {
                int vTotal1ROW = p_grid_LIST_EXPORT_RESULT.RowCount;

                #region ----- Header/SUM Write ----

                XLHeader(p_adapter_PRINT_EXPORT_RESULT_TITLE);
                XLSUM(p_grid_UP_EXPORT_RESULT);

                mCopyLineSUM = CopyAndPaste(mPrinting, mCopyLineSUM);

                #endregion;

                #region ----- Line Write ----

                if (vTotal1ROW > 0)
                {
                    int vCountROW1 = 0;

                    vPrintingLine = mPrintingLineSTART_SOURCE1;

                    SetArray1(p_grid_LIST_EXPORT_RESULT, out vGDColumn, out vXLColumn);

                    for (int vRow1 = 0; vRow1 < vTotal1ROW; vRow1++)
                    {
                        vCountROW1++;

                        vMessage = string.Format("Grid2 : {0}/{1}", vCountROW1, vTotal1ROW);
                        mAppInterface.OnAppMessageEvent(vMessage);
                        System.Windows.Forms.Application.DoEvents();

                        vPrintingLine = XLLine(p_grid_LIST_EXPORT_RESULT, vRow1, vPrintingLine, vGDColumn, vXLColumn);

                        if (vTotal1ROW == vCountROW1)
                        {
                            //마지막 행이면...
                        }
                        else
                        {
                            IsNewPage(vPrintingLine);
                            if (mIsNewPage == true)
                            {
                                if (mIsSecondPageWriting == false)
                                {
                                    vPrintingLine = (mCopyLineSUM - mIncrementCopyMAX) + (mPrintingLineSTART_SOURCE1 - 1);
                                }
                                else
                                {
                                    vPrintingLine = (mCopyLineSUM - mIncrementCopyMAX) + (mPrintingLineSTART_SOURCE2 - 1);
                                }
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
            int vPrintingLineEND = mCopyLineSUM - 3; //1~32: mCopyLineSUM=33에서 내용이 출력되는 행이 30 까지 이므로, 3을 빼면 된다
            if (vPrintingLineEND < pPrintingLine)
            {
                mIsNewPage = true;
                mIsSecondPageWriting = true;
                mCopyLineSUM = CopyAndPaste(mPrinting, mCopyLineSUM);
            }
            else if (mIsSecondPageWriting == true && vPrintingLineEND < pPrintingLine)
            {
                mIsNewPage = true;
                mCopyLineSUM = CopyAndPaste(mPrinting, mCopyLineSUM);
            }
            else
            {
                mIsNewPage = false;
            }
        }

        #endregion;

        #region ----- Copy&Paste Sheet Method ----

        //첫번째 페이지 복사
        private int CopyAndPaste(XL.XLPrint pPrinting, int pCopySumPrintingLine)
        {
            int vCopySumPrintingLine = pCopySumPrintingLine;

            int vCopyPrintingRowSTART = vCopySumPrintingLine;
            vCopySumPrintingLine = vCopySumPrintingLine + mIncrementCopyMAX;
            int vCopyPrintingRowEnd = vCopySumPrintingLine;

            if (mIsSecondPageWriting == false)
            {
                pPrinting.XLActiveSheet("SOURCE1");
            }
            else
            {
                pPrinting.XLActiveSheet("SOURCE2");
            }

            object vRangeSource = pPrinting.XLGetRange(mCopyColumnSTART, 1, mIncrementCopyMAX, mCopyColumnEND); //[원본], [Sheet2.Cell("A1:AS67")], 엑셀 쉬트에서 복사 시작할 행번호, 엑셀 쉬트에서 복사 시작할 열번호, 엑셀 쉬트에서 복사 종료할 행번호, 엑셀 쉬트에서 복사 종료할 열번호
            pPrinting.XLActiveSheet("DESTINATION");
            object vRangeDestination = pPrinting.XLGetRange(vCopyPrintingRowSTART, 1, vCopyPrintingRowEnd, mCopyColumnEND); //[대상], [Sheet1.Cell("A1:AS67")], 엑셀 쉬트에서 복사 시작할 행번호, 엑셀 쉬트에서 복사 시작할 열번호, 엑셀 쉬트에서 복사 종료할 행번호, 엑셀 쉬트에서 복사 종료할 열번호
            pPrinting.XLCopyRange(vRangeSource, vRangeDestination);

            mPageNumber++; //페이지 번호
            int vRowSTART = vCopyPrintingRowEnd - 2;
            mPrinting.XLSetCell(vRowSTART, 40, mPageNumber);

            return vCopySumPrintingLine;
        }

        #endregion;

        #region ----- Printing Methods ----

        public void Printing(int pPageSTART, int pPageEND)
        {
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
