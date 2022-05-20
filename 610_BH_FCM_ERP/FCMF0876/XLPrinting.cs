using System;

namespace FCMF0876
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

        private int mPrintingLineSTART_SOURCE1 = 42;  //Line
        private int mPrintingLineSTART_SOURCE2 = 15;   //Line

        private int mCopyLineSUM = 1;        //엑셀의 선택된 쉬트의 복사되어질 시작 행 위치, 복사 행 누적
        private int mIncrementCopyMAX = 58;  //복사되어질 행의 범위

        private int mCopyColumnSTART = 1; //복사되어  진 행 누적 수
        private int mCopyColumnEND = 56;  //엑셀의 선택된 쉬트의 복사되어질 끝 열 위치

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
            pGDColumn = new int[14];
            pXLColumn = new int[14];

            pGDColumn[0] = pGrid.GetColumnToIndex("SEQ");           //일련번호
            pGDColumn[1] = pGrid.GetColumnToIndex("TAX_REG_NO");    //사업자등록번호
            pGDColumn[2] = pGrid.GetColumnToIndex("SUPPLIER_NAME"); //상호(법인명)
            pGDColumn[3] = pGrid.GetColumnToIndex("COMPANY_CNT");   //매수
            pGDColumn[4] = pGrid.GetColumnToIndex("GL_AMOUNT_1");   //공급가액_조단위
            pGDColumn[5] = pGrid.GetColumnToIndex("GL_AMOUNT_2");   //공급가액_십억단위
            pGDColumn[6] = pGrid.GetColumnToIndex("GL_AMOUNT_3");   //공급가액_백만단위
            pGDColumn[7] = pGrid.GetColumnToIndex("GL_AMOUNT_4");   //공급가액_천단위
            pGDColumn[8] = pGrid.GetColumnToIndex("GL_AMOUNT_5");   //공급가액_원단위
            pGDColumn[9] = pGrid.GetColumnToIndex("VAT_AMOUNT_1");  //세액_조단위
            pGDColumn[10] = pGrid.GetColumnToIndex("VAT_AMOUNT_2"); //세액_십억단위
            pGDColumn[11] = pGrid.GetColumnToIndex("VAT_AMOUNT_3"); //세액_백만단위
            pGDColumn[12] = pGrid.GetColumnToIndex("VAT_AMOUNT_4"); //세액_천단위
            pGDColumn[13] = pGrid.GetColumnToIndex("VAT_AMOUNT_5"); //세액_원단위


            pXLColumn[0] = 3;   //일련번호
            pXLColumn[1] = 6;   //사업자등록번호
            pXLColumn[2] = 12;  //상호(법인명)
            pXLColumn[3] = 22;  //매수
            pXLColumn[4] = 25;  //공급가액_조단위
            pXLColumn[5] = 27;  //공급가액_십억단위
            pXLColumn[6] = 30;  //공급가액_백만단위
            pXLColumn[7] = 33;  //공급가액_천단위
            pXLColumn[8] = 36;  //공급가액_원단위
            pXLColumn[9] = 39;  //세액_조단위
            pXLColumn[10] = 41; //세액_십억단위
            pXLColumn[11] = 44; //세액_백만단위
            pXLColumn[12] = 47; //세액_천단위
            pXLColumn[13] = 50; //세액_원단위
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

        private void XLHeader(InfoSummit.Win.ControlAdv.ISDataAdapter p_adapter_PRINT_SUM_VAT_TAX_TITLE)
        {
            int vCountRow = 0;
            int vXLine = 0;
            int vXLColumn = 0;
            object vObject = null;
            string vConvertString = string.Empty;
            bool IsConvert = false;

            try
            {
                vCountRow = p_adapter_PRINT_SUM_VAT_TAX_TITLE.OraSelectData.Rows.Count;

                if (vCountRow > 0)
                {
                    mPrinting.XLActiveSheet("SOURCE2");

                    //부가가치세신고기수
                    vObject = p_adapter_PRINT_SUM_VAT_TAX_TITLE.OraSelectData.Rows[0]["FISCAL_YEAR"];
                    vXLine = 5;
                    vXLColumn = 3;
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
                    vObject = p_adapter_PRINT_SUM_VAT_TAX_TITLE.OraSelectData.Rows[0]["VAT_NUMBER"];
                    vXLine = 8;
                    vXLColumn = 44;
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
                    vObject = p_adapter_PRINT_SUM_VAT_TAX_TITLE.OraSelectData.Rows[0]["FISCAL_YEAR"];
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

                    //사업자등록번호
                    vObject = p_adapter_PRINT_SUM_VAT_TAX_TITLE.OraSelectData.Rows[0]["VAT_NUMBER"];
                    vXLine = 9;
                    vXLColumn = 11;
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
                    vObject = p_adapter_PRINT_SUM_VAT_TAX_TITLE.OraSelectData.Rows[0]["CORP_NAME"];
                    vXLine = 9;
                    vXLColumn = 38;
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
                    vObject = p_adapter_PRINT_SUM_VAT_TAX_TITLE.OraSelectData.Rows[0]["PRESIDENT_NAME"];
                    vXLine = 11;
                    vXLColumn = 11;
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
                    vObject = p_adapter_PRINT_SUM_VAT_TAX_TITLE.OraSelectData.Rows[0]["LOCATION"];
                    vXLine = 11;
                    vXLColumn = 38;
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
                    vObject = p_adapter_PRINT_SUM_VAT_TAX_TITLE.OraSelectData.Rows[0]["DEAL_TERM"];
                    vXLine = 13;
                    vXLColumn = 11;
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
                    vObject = p_adapter_PRINT_SUM_VAT_TAX_TITLE.OraSelectData.Rows[0]["CREATE_DATE"];
                    vXLine = 13;
                    vXLColumn = 38;
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

        private void XLSUM(InfoSummit.Win.ControlAdv.ISGridAdvEx p_grid_UP_AP_SUM_VAT_TAX)
        {
            int vRow = 0;
            int vCountRow = 0;
            int vGDColumnIndex = 0;
            int vXLine = 0;
            int vXLColumn = 0;
            object vObject = null;
            string vConvertString = string.Empty;
            decimal vConvertDecimal = 0m;
            bool IsConvert = false;

            int vCol_COM_CNT = 19;  //매입처수
            int vCol_COM_REC = 24;  //매수
            int vCol_GL_JO = 28;    //공급가액_조단위
            int vCol_GL_UK = 30;    //공급가액_십억단위
            int vCol_GL_MAN = 33;   //공급가액_백만단위
            int vCol_GL_CHUN = 36;  //공급가액_천단위
            int vCol_GL_WON = 39;   //공급가액_원단위
            int vCol_VAT_JO = 42;   //세액조단위
            int vCol_VAT_UK = 44;   //세액십억단위
            int vCol_VAT_MAN = 47;  //세액백만단위
            int vCol_VAT_CHUN = 50; //세액천단위
            int vCol_VAT_WON = 53;  //세액원단위

            try
            {
                vCountRow = p_grid_UP_AP_SUM_VAT_TAX.RowCount;

                if (vCountRow > 0)
                {
                    mPrinting.XLActiveSheet("SOURCE1");

                    //구분 : 합계
                    vXLine = 20;
                    vRow = 0;

                    //매입처수 : 합계
                    vGDColumnIndex = p_grid_UP_AP_SUM_VAT_TAX.GetColumnToIndex("COM_CNT");
                    vObject = p_grid_UP_AP_SUM_VAT_TAX.GetCellValue(vRow, vGDColumnIndex);
                    vXLColumn = vCol_COM_CNT;
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

                    //매수 : 합계
                    vGDColumnIndex = p_grid_UP_AP_SUM_VAT_TAX.GetColumnToIndex("COM_REC");
                    vObject = p_grid_UP_AP_SUM_VAT_TAX.GetCellValue(vRow, vGDColumnIndex);
                    vXLColumn = vCol_COM_REC;
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

                    //공급가액_조단위 : 합계
                    vGDColumnIndex = p_grid_UP_AP_SUM_VAT_TAX.GetColumnToIndex("COM_GL_1");
                    vObject = p_grid_UP_AP_SUM_VAT_TAX.GetCellValue(vRow, vGDColumnIndex);
                    vXLColumn = vCol_GL_JO;
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

                    //공급가액_십억단위 : 합계
                    vGDColumnIndex = p_grid_UP_AP_SUM_VAT_TAX.GetColumnToIndex("COM_GL_2");
                    vObject = p_grid_UP_AP_SUM_VAT_TAX.GetCellValue(vRow, vGDColumnIndex);
                    vXLColumn = vCol_GL_UK;
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

                    //공급가액_백만단위 : 합계
                    vGDColumnIndex = p_grid_UP_AP_SUM_VAT_TAX.GetColumnToIndex("COM_GL_3");
                    vObject = p_grid_UP_AP_SUM_VAT_TAX.GetCellValue(vRow, vGDColumnIndex);
                    vXLColumn = vCol_GL_MAN;
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

                    //공급가액_천단위 : 합계
                    vGDColumnIndex = p_grid_UP_AP_SUM_VAT_TAX.GetColumnToIndex("COM_GL_4");
                    vObject = p_grid_UP_AP_SUM_VAT_TAX.GetCellValue(vRow, vGDColumnIndex);
                    vXLColumn = vCol_GL_CHUN;
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

                    //공급가액_원단위 : 합계
                    vGDColumnIndex = p_grid_UP_AP_SUM_VAT_TAX.GetColumnToIndex("COM_GL_5");
                    vObject = p_grid_UP_AP_SUM_VAT_TAX.GetCellValue(vRow, vGDColumnIndex);
                    vXLColumn = vCol_GL_WON;
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

                    //세액_조단위 : 합계
                    vGDColumnIndex = p_grid_UP_AP_SUM_VAT_TAX.GetColumnToIndex("COM_VAT_1");
                    vObject = p_grid_UP_AP_SUM_VAT_TAX.GetCellValue(vRow, vGDColumnIndex);
                    vXLColumn = vCol_VAT_JO;
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

                    //세액_십억단위 : 합계
                    vGDColumnIndex = p_grid_UP_AP_SUM_VAT_TAX.GetColumnToIndex("COM_VAT_2");
                    vObject = p_grid_UP_AP_SUM_VAT_TAX.GetCellValue(vRow, vGDColumnIndex);
                    vXLColumn = vCol_VAT_UK;
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

                    //세액_백만단위 : 합계
                    vGDColumnIndex = p_grid_UP_AP_SUM_VAT_TAX.GetColumnToIndex("COM_VAT_3");
                    vObject = p_grid_UP_AP_SUM_VAT_TAX.GetCellValue(vRow, vGDColumnIndex);
                    vXLColumn = vCol_VAT_MAN;
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

                    //세액_천단위 : 합계
                    vGDColumnIndex = p_grid_UP_AP_SUM_VAT_TAX.GetColumnToIndex("COM_VAT_4");
                    vObject = p_grid_UP_AP_SUM_VAT_TAX.GetCellValue(vRow, vGDColumnIndex);
                    vXLColumn = vCol_VAT_CHUN;
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

                    //세액_원단위 : 합계
                    vGDColumnIndex = p_grid_UP_AP_SUM_VAT_TAX.GetColumnToIndex("COM_VAT_5");
                    vObject = p_grid_UP_AP_SUM_VAT_TAX.GetCellValue(vRow, vGDColumnIndex);
                    vXLColumn = vCol_VAT_WON;
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


                    //----------------------------------------------------------------------------
                    //////////////////////////////////////////////////////////////////////////////
                    //----------------------------------------------------------------------------


                    //구분 : 전자 : 사업자등록번호
                    vXLine = 22;
                    vRow = 1;

                    //매입처수 : 전자
                    vGDColumnIndex = p_grid_UP_AP_SUM_VAT_TAX.GetColumnToIndex("COM_CNT");
                    vObject = p_grid_UP_AP_SUM_VAT_TAX.GetCellValue(vRow, vGDColumnIndex);
                    vXLColumn = vCol_COM_CNT;
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

                    //매수 : 전자
                    vGDColumnIndex = p_grid_UP_AP_SUM_VAT_TAX.GetColumnToIndex("COM_REC");
                    vObject = p_grid_UP_AP_SUM_VAT_TAX.GetCellValue(vRow, vGDColumnIndex);
                    vXLColumn = vCol_COM_REC;
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

                    //공급가액_조단위 : 전자
                    vGDColumnIndex = p_grid_UP_AP_SUM_VAT_TAX.GetColumnToIndex("COM_GL_1");
                    vObject = p_grid_UP_AP_SUM_VAT_TAX.GetCellValue(vRow, vGDColumnIndex);
                    vXLColumn = vCol_GL_JO;
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

                    //공급가액_십억단위 : 전자
                    vGDColumnIndex = p_grid_UP_AP_SUM_VAT_TAX.GetColumnToIndex("COM_GL_2");
                    vObject = p_grid_UP_AP_SUM_VAT_TAX.GetCellValue(vRow, vGDColumnIndex);
                    vXLColumn = vCol_GL_UK;
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

                    //공급가액_백만단위 : 전자
                    vGDColumnIndex = p_grid_UP_AP_SUM_VAT_TAX.GetColumnToIndex("COM_GL_3");
                    vObject = p_grid_UP_AP_SUM_VAT_TAX.GetCellValue(vRow, vGDColumnIndex);
                    vXLColumn = vCol_GL_MAN;
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

                    //공급가액_천단위 : 전자
                    vGDColumnIndex = p_grid_UP_AP_SUM_VAT_TAX.GetColumnToIndex("COM_GL_4");
                    vObject = p_grid_UP_AP_SUM_VAT_TAX.GetCellValue(vRow, vGDColumnIndex);
                    vXLColumn = vCol_GL_CHUN;
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

                    //공급가액_원단위 : 전자
                    vGDColumnIndex = p_grid_UP_AP_SUM_VAT_TAX.GetColumnToIndex("COM_GL_5");
                    vObject = p_grid_UP_AP_SUM_VAT_TAX.GetCellValue(vRow, vGDColumnIndex);
                    vXLColumn = vCol_GL_WON;
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

                    //세액_조단위 : 전자
                    vGDColumnIndex = p_grid_UP_AP_SUM_VAT_TAX.GetColumnToIndex("COM_VAT_1");
                    vObject = p_grid_UP_AP_SUM_VAT_TAX.GetCellValue(vRow, vGDColumnIndex);
                    vXLColumn = vCol_VAT_JO;
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

                    //세액_십억단위 : 전자
                    vGDColumnIndex = p_grid_UP_AP_SUM_VAT_TAX.GetColumnToIndex("COM_VAT_2");
                    vObject = p_grid_UP_AP_SUM_VAT_TAX.GetCellValue(vRow, vGDColumnIndex);
                    vXLColumn = vCol_VAT_UK;
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

                    //세액_백만단위 : 전자
                    vGDColumnIndex = p_grid_UP_AP_SUM_VAT_TAX.GetColumnToIndex("COM_VAT_3");
                    vObject = p_grid_UP_AP_SUM_VAT_TAX.GetCellValue(vRow, vGDColumnIndex);
                    vXLColumn = vCol_VAT_MAN;
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

                    //세액_천단위 : 전자
                    vGDColumnIndex = p_grid_UP_AP_SUM_VAT_TAX.GetColumnToIndex("COM_VAT_4");
                    vObject = p_grid_UP_AP_SUM_VAT_TAX.GetCellValue(vRow, vGDColumnIndex);
                    vXLColumn = vCol_VAT_CHUN;
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

                    //세액_원단위 : 전자
                    vGDColumnIndex = p_grid_UP_AP_SUM_VAT_TAX.GetColumnToIndex("COM_VAT_5");
                    vObject = p_grid_UP_AP_SUM_VAT_TAX.GetCellValue(vRow, vGDColumnIndex);
                    vXLColumn = vCol_VAT_WON;
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


                    //----------------------------------------------------------------------------
                    //////////////////////////////////////////////////////////////////////////////
                    //----------------------------------------------------------------------------


                    //구분 : 전자 : 주민등록번호
                    vXLine = 24;
                    vRow = 1;

                    //매입처수 : 전자
                    vXLColumn = vCol_COM_CNT;
                    mPrinting.XLSetCell(vXLine, vXLColumn, "0");

                    //매수 : 전자
                    vXLColumn = vCol_COM_REC;
                    mPrinting.XLSetCell(vXLine, vXLColumn, "0");

                    //공급가액_원단위 : 전자
                    vXLColumn = vCol_GL_WON;
                    mPrinting.XLSetCell(vXLine, vXLColumn, "0");

                    //세액_원단위 : 전자
                    vXLColumn = vCol_VAT_WON;
                    mPrinting.XLSetCell(vXLine, vXLColumn, "0");


                    //----------------------------------------------------------------------------
                    //////////////////////////////////////////////////////////////////////////////
                    //----------------------------------------------------------------------------


                    //구분 : 전자 : 소계
                    vXLine = 26;
                    vRow = 1;

                    //매입처수 : 전자
                    vGDColumnIndex = p_grid_UP_AP_SUM_VAT_TAX.GetColumnToIndex("COM_CNT");
                    vObject = p_grid_UP_AP_SUM_VAT_TAX.GetCellValue(vRow, vGDColumnIndex);
                    vXLColumn = vCol_COM_CNT;
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

                    //매수 : 전자
                    vGDColumnIndex = p_grid_UP_AP_SUM_VAT_TAX.GetColumnToIndex("COM_REC");
                    vObject = p_grid_UP_AP_SUM_VAT_TAX.GetCellValue(vRow, vGDColumnIndex);
                    vXLColumn = vCol_COM_REC;
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

                    //공급가액_조단위 : 전자
                    vGDColumnIndex = p_grid_UP_AP_SUM_VAT_TAX.GetColumnToIndex("COM_GL_1");
                    vObject = p_grid_UP_AP_SUM_VAT_TAX.GetCellValue(vRow, vGDColumnIndex);
                    vXLColumn = vCol_GL_JO;
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

                    //공급가액_십억단위 : 전자
                    vGDColumnIndex = p_grid_UP_AP_SUM_VAT_TAX.GetColumnToIndex("COM_GL_2");
                    vObject = p_grid_UP_AP_SUM_VAT_TAX.GetCellValue(vRow, vGDColumnIndex);
                    vXLColumn = vCol_GL_UK;
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

                    //공급가액_백만단위 : 전자
                    vGDColumnIndex = p_grid_UP_AP_SUM_VAT_TAX.GetColumnToIndex("COM_GL_3");
                    vObject = p_grid_UP_AP_SUM_VAT_TAX.GetCellValue(vRow, vGDColumnIndex);
                    vXLColumn = vCol_GL_MAN;
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

                    //공급가액_천단위 : 전자
                    vGDColumnIndex = p_grid_UP_AP_SUM_VAT_TAX.GetColumnToIndex("COM_GL_4");
                    vObject = p_grid_UP_AP_SUM_VAT_TAX.GetCellValue(vRow, vGDColumnIndex);
                    vXLColumn = vCol_GL_CHUN;
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

                    //공급가액_원단위 : 전자
                    vGDColumnIndex = p_grid_UP_AP_SUM_VAT_TAX.GetColumnToIndex("COM_GL_5");
                    vObject = p_grid_UP_AP_SUM_VAT_TAX.GetCellValue(vRow, vGDColumnIndex);
                    vXLColumn = vCol_GL_WON;
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

                    //세액_조단위 : 전자
                    vGDColumnIndex = p_grid_UP_AP_SUM_VAT_TAX.GetColumnToIndex("COM_VAT_1");
                    vObject = p_grid_UP_AP_SUM_VAT_TAX.GetCellValue(vRow, vGDColumnIndex);
                    vXLColumn = vCol_VAT_JO;
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

                    //세액_십억단위 : 전자
                    vGDColumnIndex = p_grid_UP_AP_SUM_VAT_TAX.GetColumnToIndex("COM_VAT_2");
                    vObject = p_grid_UP_AP_SUM_VAT_TAX.GetCellValue(vRow, vGDColumnIndex);
                    vXLColumn = vCol_VAT_UK;
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

                    //세액_백만단위 : 전자
                    vGDColumnIndex = p_grid_UP_AP_SUM_VAT_TAX.GetColumnToIndex("COM_VAT_3");
                    vObject = p_grid_UP_AP_SUM_VAT_TAX.GetCellValue(vRow, vGDColumnIndex);
                    vXLColumn = vCol_VAT_MAN;
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

                    //세액_천단위 : 전자
                    vGDColumnIndex = p_grid_UP_AP_SUM_VAT_TAX.GetColumnToIndex("COM_VAT_4");
                    vObject = p_grid_UP_AP_SUM_VAT_TAX.GetCellValue(vRow, vGDColumnIndex);
                    vXLColumn = vCol_VAT_CHUN;
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

                    //세액_원단위 : 전자
                    vGDColumnIndex = p_grid_UP_AP_SUM_VAT_TAX.GetColumnToIndex("COM_VAT_5");
                    vObject = p_grid_UP_AP_SUM_VAT_TAX.GetCellValue(vRow, vGDColumnIndex);
                    vXLColumn = vCol_VAT_WON;
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




                    //----------------------------------------------------------------------------
                    //////////////////////////////////////////////////////////////////////////////
                    //----------------------------------------------------------------------------
                    //----------------------------------------------------------------------------
                    //////////////////////////////////////////////////////////////////////////////
                    //----------------------------------------------------------------------------
                    //----------------------------------------------------------------------------
                    //////////////////////////////////////////////////////////////////////////////
                    //----------------------------------------------------------------------------




                    //구분 : 전자외 : 사업자등록번호
                    vXLine = 28;
                    vRow = 2;

                    //매입처수 : 전자외
                    vGDColumnIndex = p_grid_UP_AP_SUM_VAT_TAX.GetColumnToIndex("COM_CNT");
                    vObject = p_grid_UP_AP_SUM_VAT_TAX.GetCellValue(vRow, vGDColumnIndex);
                    vXLColumn = vCol_COM_CNT;
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

                    //매수 : 전자외
                    vGDColumnIndex = p_grid_UP_AP_SUM_VAT_TAX.GetColumnToIndex("COM_REC");
                    vObject = p_grid_UP_AP_SUM_VAT_TAX.GetCellValue(vRow, vGDColumnIndex);
                    vXLColumn = vCol_COM_REC;
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

                    //공급가액_조단위 : 전자외
                    vGDColumnIndex = p_grid_UP_AP_SUM_VAT_TAX.GetColumnToIndex("COM_GL_1");
                    vObject = p_grid_UP_AP_SUM_VAT_TAX.GetCellValue(vRow, vGDColumnIndex);
                    vXLColumn = vCol_GL_JO;
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

                    //공급가액_십억단위 : 전자외
                    vGDColumnIndex = p_grid_UP_AP_SUM_VAT_TAX.GetColumnToIndex("COM_GL_2");
                    vObject = p_grid_UP_AP_SUM_VAT_TAX.GetCellValue(vRow, vGDColumnIndex);
                    vXLColumn = vCol_GL_UK;
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

                    //공급가액_백만단위 : 전자외
                    vGDColumnIndex = p_grid_UP_AP_SUM_VAT_TAX.GetColumnToIndex("COM_GL_3");
                    vObject = p_grid_UP_AP_SUM_VAT_TAX.GetCellValue(vRow, vGDColumnIndex);
                    vXLColumn = vCol_GL_MAN;
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

                    //공급가액_천단위 : 전자외
                    vGDColumnIndex = p_grid_UP_AP_SUM_VAT_TAX.GetColumnToIndex("COM_GL_4");
                    vObject = p_grid_UP_AP_SUM_VAT_TAX.GetCellValue(vRow, vGDColumnIndex);
                    vXLColumn = vCol_GL_CHUN;
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

                    //공급가액_원단위 : 전자외
                    vGDColumnIndex = p_grid_UP_AP_SUM_VAT_TAX.GetColumnToIndex("COM_GL_5");
                    vObject = p_grid_UP_AP_SUM_VAT_TAX.GetCellValue(vRow, vGDColumnIndex);
                    vXLColumn = vCol_GL_WON;
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

                    //세액_조단위 : 전자외
                    vGDColumnIndex = p_grid_UP_AP_SUM_VAT_TAX.GetColumnToIndex("COM_VAT_1");
                    vObject = p_grid_UP_AP_SUM_VAT_TAX.GetCellValue(vRow, vGDColumnIndex);
                    vXLColumn = vCol_VAT_JO;
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

                    //세액_십억단위 : 전자외
                    vGDColumnIndex = p_grid_UP_AP_SUM_VAT_TAX.GetColumnToIndex("COM_VAT_2");
                    vObject = p_grid_UP_AP_SUM_VAT_TAX.GetCellValue(vRow, vGDColumnIndex);
                    vXLColumn = vCol_VAT_UK;
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

                    //세액_백만단위 : 전자외
                    vGDColumnIndex = p_grid_UP_AP_SUM_VAT_TAX.GetColumnToIndex("COM_VAT_3");
                    vObject = p_grid_UP_AP_SUM_VAT_TAX.GetCellValue(vRow, vGDColumnIndex);
                    vXLColumn = vCol_VAT_MAN;
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

                    //세액_천단위 : 전자외
                    vGDColumnIndex = p_grid_UP_AP_SUM_VAT_TAX.GetColumnToIndex("COM_VAT_4");
                    vObject = p_grid_UP_AP_SUM_VAT_TAX.GetCellValue(vRow, vGDColumnIndex);
                    vXLColumn = vCol_VAT_CHUN;
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

                    //세액_원단위 : 전자외
                    vGDColumnIndex = p_grid_UP_AP_SUM_VAT_TAX.GetColumnToIndex("COM_VAT_5");
                    vObject = p_grid_UP_AP_SUM_VAT_TAX.GetCellValue(vRow, vGDColumnIndex);
                    vXLColumn = vCol_VAT_WON;
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


                    //----------------------------------------------------------------------------
                    //////////////////////////////////////////////////////////////////////////////
                    //----------------------------------------------------------------------------


                    //구분 : 전자외 : 주민등록번호
                    vXLine = 30;
                    vRow = 2;

                    //매입처수 : 전자외
                    vXLColumn = vCol_COM_CNT;
                    mPrinting.XLSetCell(vXLine, vXLColumn, "0");

                    //매수 : 전자외
                    vXLColumn = vCol_COM_REC;
                    mPrinting.XLSetCell(vXLine, vXLColumn, "0");

                    //공급가액_원단위 : 전자외
                    vXLColumn = vCol_GL_WON;
                    mPrinting.XLSetCell(vXLine, vXLColumn, "0");

                    //세액_원단위 : 전자외
                    vXLColumn = vCol_VAT_WON;
                    mPrinting.XLSetCell(vXLine, vXLColumn, "0");


                    //----------------------------------------------------------------------------
                    //////////////////////////////////////////////////////////////////////////////
                    //----------------------------------------------------------------------------


                    //구분 : 전자외 : 소계
                    vXLine = 32;
                    vRow = 2;

                    //매입처수 : 전자외
                    vGDColumnIndex = p_grid_UP_AP_SUM_VAT_TAX.GetColumnToIndex("COM_CNT");
                    vObject = p_grid_UP_AP_SUM_VAT_TAX.GetCellValue(vRow, vGDColumnIndex);
                    vXLColumn = vCol_COM_CNT;
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

                    //매수 : 전자외
                    vGDColumnIndex = p_grid_UP_AP_SUM_VAT_TAX.GetColumnToIndex("COM_REC");
                    vObject = p_grid_UP_AP_SUM_VAT_TAX.GetCellValue(vRow, vGDColumnIndex);
                    vXLColumn = vCol_COM_REC;
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

                    //공급가액_조단위 : 전자외
                    vGDColumnIndex = p_grid_UP_AP_SUM_VAT_TAX.GetColumnToIndex("COM_GL_1");
                    vObject = p_grid_UP_AP_SUM_VAT_TAX.GetCellValue(vRow, vGDColumnIndex);
                    vXLColumn = vCol_GL_JO;
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

                    //공급가액_십억단위 : 전자외
                    vGDColumnIndex = p_grid_UP_AP_SUM_VAT_TAX.GetColumnToIndex("COM_GL_2");
                    vObject = p_grid_UP_AP_SUM_VAT_TAX.GetCellValue(vRow, vGDColumnIndex);
                    vXLColumn = vCol_GL_UK;
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

                    //공급가액_백만단위 : 전자외
                    vGDColumnIndex = p_grid_UP_AP_SUM_VAT_TAX.GetColumnToIndex("COM_GL_3");
                    vObject = p_grid_UP_AP_SUM_VAT_TAX.GetCellValue(vRow, vGDColumnIndex);
                    vXLColumn = vCol_GL_MAN;
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

                    //공급가액_천단위 : 전자외
                    vGDColumnIndex = p_grid_UP_AP_SUM_VAT_TAX.GetColumnToIndex("COM_GL_4");
                    vObject = p_grid_UP_AP_SUM_VAT_TAX.GetCellValue(vRow, vGDColumnIndex);
                    vXLColumn = vCol_GL_CHUN;
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

                    //공급가액_원단위 : 전자외
                    vGDColumnIndex = p_grid_UP_AP_SUM_VAT_TAX.GetColumnToIndex("COM_GL_5");
                    vObject = p_grid_UP_AP_SUM_VAT_TAX.GetCellValue(vRow, vGDColumnIndex);
                    vXLColumn = vCol_GL_WON;
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

                    //세액_조단위 : 전자외
                    vGDColumnIndex = p_grid_UP_AP_SUM_VAT_TAX.GetColumnToIndex("COM_VAT_1");
                    vObject = p_grid_UP_AP_SUM_VAT_TAX.GetCellValue(vRow, vGDColumnIndex);
                    vXLColumn = vCol_VAT_JO;
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

                    //세액_십억단위 : 전자외
                    vGDColumnIndex = p_grid_UP_AP_SUM_VAT_TAX.GetColumnToIndex("COM_VAT_2");
                    vObject = p_grid_UP_AP_SUM_VAT_TAX.GetCellValue(vRow, vGDColumnIndex);
                    vXLColumn = vCol_VAT_UK;
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

                    //세액_백만단위 : 전자외
                    vGDColumnIndex = p_grid_UP_AP_SUM_VAT_TAX.GetColumnToIndex("COM_VAT_3");
                    vObject = p_grid_UP_AP_SUM_VAT_TAX.GetCellValue(vRow, vGDColumnIndex);
                    vXLColumn = vCol_VAT_MAN;
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

                    //세액_천단위 : 전자외
                    vGDColumnIndex = p_grid_UP_AP_SUM_VAT_TAX.GetColumnToIndex("COM_VAT_4");
                    vObject = p_grid_UP_AP_SUM_VAT_TAX.GetCellValue(vRow, vGDColumnIndex);
                    vXLColumn = vCol_VAT_CHUN;
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

                    //세액_원단위 : 전자외
                    vGDColumnIndex = p_grid_UP_AP_SUM_VAT_TAX.GetColumnToIndex("COM_VAT_5");
                    vObject = p_grid_UP_AP_SUM_VAT_TAX.GetCellValue(vRow, vGDColumnIndex);
                    vXLColumn = vCol_VAT_WON;
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

                //일련번호
                vGDColumnIndex = pGDColumn[0];
                vXLColumnIndex = pXLColumn[0];
                vObject = pGrid.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:##,###,###,###,###,###,###,###,###}", vConvertDecimal);
                    mPrinting.XLSetCell((vXLine - 1), vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell((vXLine - 1), vXLColumnIndex, vConvertString);
                }

                //사업자등록번호
                vGDColumnIndex = pGDColumn[1];
                vXLColumnIndex = pXLColumn[1];
                vObject = pGrid.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0}", vConvertString);
                    mPrinting.XLSetCell((vXLine - 1), vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell((vXLine - 1), vXLColumnIndex, vConvertString);
                }

                //상호(법인명)
                vGDColumnIndex = pGDColumn[2];
                vXLColumnIndex = pXLColumn[2];
                vObject = pGrid.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0}", vConvertString);
                    mPrinting.XLSetCell((vXLine - 1), vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell((vXLine - 1), vXLColumnIndex, vConvertString);
                }

                //매수
                vGDColumnIndex = pGDColumn[3];
                vXLColumnIndex = pXLColumn[3];
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

                //공급가액_조단위
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

                //공급가액_십억단위
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

                //공급가액_백만단위
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

                //공급가액_천단위
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

                //공급가액_원단위
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

                //세액_조단위
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

                //세액_십억단위
                vGDColumnIndex = pGDColumn[10];
                vXLColumnIndex = pXLColumn[10];
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

                //세액_백만단위
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

                //세액_천단위
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

                //세액_원단위
                vGDColumnIndex = pGDColumn[13];
                vXLColumnIndex = pXLColumn[13];
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

        public int LineWrite(InfoSummit.Win.ControlAdv.ISGridAdvEx p_grid_UP_AP_SUM_VAT_TAX, InfoSummit.Win.ControlAdv.ISGridAdvEx p_grid_LIST_AP_SUM_VAT_TAX_2, InfoSummit.Win.ControlAdv.ISDataAdapter p_adapter_PRINT_SUM_VAT_TAX_TITLE)
        {
            mPageNumber = 0;
            string vMessage = string.Empty;

            int[] vGDColumn;
            int[] vXLColumn;

            int vPrintingLine = 0;

            try
            {
                int vTotal1ROW = p_grid_LIST_AP_SUM_VAT_TAX_2.RowCount;

                #region ----- Header/SUM Write ----

                XLHeader(p_adapter_PRINT_SUM_VAT_TAX_TITLE);
                XLSUM(p_grid_UP_AP_SUM_VAT_TAX);

                mCopyLineSUM = CopyAndPaste(mPrinting, mCopyLineSUM);

                #endregion;

                #region ----- Line Write ----

                if (vTotal1ROW > 0)
                {
                    int vCountROW1 = 0;

                    vPrintingLine = mPrintingLineSTART_SOURCE1;

                    SetArray1(p_grid_LIST_AP_SUM_VAT_TAX_2, out vGDColumn, out vXLColumn);

                    for (int vRow1 = 0; vRow1 < vTotal1ROW; vRow1++)
                    {
                        vCountROW1++;

                        vMessage = string.Format("Grid2 : {0}/{1}", vCountROW1, vTotal1ROW);
                        mAppInterface.OnAppMessageEvent(vMessage);
                        System.Windows.Forms.Application.DoEvents();

                        vPrintingLine = XLLine(p_grid_LIST_AP_SUM_VAT_TAX_2, vRow1, vPrintingLine, vGDColumn, vXLColumn);

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
            int vPrintingLineEND = 0;

            if (mPageNumber == 1)
            {
                vPrintingLineEND = mCopyLineSUM - 9; //1~58: mCopyLineSUM=59에서 내용이 출력되는 행이 50 까지 이므로, 9을 빼면 된다
            }
            else
            {
                vPrintingLineEND = mCopyLineSUM - 6; //1~58: mCopyLineSUM=59에서 내용이 출력되는 행이 53 까지 이므로, 6을 빼면 된다
            }
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
            int vRowSTART = vCopyPrintingRowEnd - 5;

            if (mPageNumber != 1)
            {
                mPrinting.XLSetCell(vRowSTART, 51, mPageNumber);
            }

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
