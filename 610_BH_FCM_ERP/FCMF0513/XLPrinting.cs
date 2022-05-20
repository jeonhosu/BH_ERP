using System;

namespace FCMF0513
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

        private int mPrintingLineFIRST1 = 10; //��� ���� �� ���� ��ġ

        private int mPrintingLineSTART1 = 10; //���� ��½� ���� ���� �� ��ġ ����

        private int mPrintingLineFIRST2 = 4; //��� ���� �� ���� ��ġ

        private int mPrintingLineSTART2 = 4; //���� ��½� ���� ���� �� ��ġ ����

        private int mMaxLinePrinting = 67;

        private int mCopyLineSUM = 1;        //������ ���õ� ��Ʈ�� ����Ǿ��� ���� �� ��ġ
        private int mIncrementCopyMAX = 67;  //����Ǿ��� ���� ����

        private int mCopyColumnSTART = 1; //����Ǿ�  �� �� ���� ��
        private int mCopyColumnEND = 46;  //������ ���õ� ��Ʈ�� ����Ǿ��� �� �� ��ġ

        private string mtmpString1 = string.Empty;
        private string mtmpString2 = string.Empty;

        private string mMessageValue1 = string.Empty; //�Ұ�[EAPP_10046]
        private string mMessageValue2 = string.Empty; //�Ѱ����ڱ�[FCM_10222]

        private string mMessageValue3 = string.Empty; //�Ա�[FCM_10212]
        private string mMessageValue4 = string.Empty; //���[FCM_10213]
        private string mMessageValue5 = string.Empty; //��ü[FCM_10230]
        private string mMessageValue6 = string.Empty; //�Ա��հ�[FCM_10214]
        private string mMessageValue7 = string.Empty; //����հ�[FCM_10215]

        private bool mIsPrinted = false; //�ڱ���Ȳ�� ��� �ߴ���?

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

        #region ----- Line Clear All Methods ----

        private void XlLineClear(int pPrintingLine)
        {
            try
            {
                mPrinting.XLActiveSheet("Destination");

                int vStartRow = pPrintingLine + 1;
                int vStartCol = mCopyColumnSTART + 1;
                int vEndRow = mCopyLineSUM - 3;
                int vEndCol = mCopyColumnEND - 1;

                if (pPrintingLine > vEndRow)
                {
                    return;
                }

                if (vStartRow > vEndRow)
                {
                    vStartRow = vEndRow; //�����ϴ� ���� �����, ������ �� ���� ���� Ŀ���Ƿ�, ������ �� ���� ��
                }

                if (vStartRow == vEndRow)
                {
                    mPrinting.XL_LineClear(vStartRow, vStartCol, vEndCol);
                }
                else
                {
                    mPrinting.XL_LineClearInSide(vStartRow, vStartCol, vEndRow, vEndCol);
                }
            }
            catch (System.Exception ex)
            {
                mMessageError = ex.Message;
            }
        }

        #endregion;

        #region ----- Cell Merge Methods ----

        private void CellMerge(int pXLine, int[] pXLColumn, string pMessageValue)
        {
            try
            {
                int vXLine = pXLine - 1;

                mPrinting.XLActiveSheet("Destination");

                object vObject = null;
                mPrinting.XLSetCell(vXLine, pXLColumn[1], vObject);

                int vStartRow = vXLine;
                int vStartCol = pXLColumn[0];
                int vEndRow = vXLine;
                int vEndCol = pXLColumn[2] - 1;

                mPrinting.XLCellMerge(vStartRow, vStartCol, vEndRow, vEndCol, false);

                mPrinting.XLSetCell(vXLine, pXLColumn[0], pMessageValue);

                mPrinting.XL_LineDraw_TopBottom(vXLine, vStartCol, (mCopyColumnEND - 1), 2);
            }
            catch (System.Exception ex)
            {
                mMessageError = ex.Message;
            }
        }

        #endregion;

        #region ----- Line SLIP Methods ----

        #region ----- Array Set ----

        private void SetArray1(InfoSummit.Win.ControlAdv.ISGridAdvEx pGrid, out int[] pGDColumn, out int[] pXLColumn)
        {
            pGDColumn = new int[8];
            pXLColumn = new int[8];

            pGDColumn[0] = pGrid.GetColumnToIndex("TR_MANAGE_NAME");       //����
            pGDColumn[1] = pGrid.GetColumnToIndex("BANK_NAME");            //����
            pGDColumn[2] = pGrid.GetColumnToIndex("BEGIN_AMOUNT");         //�����ܾ�
            pGDColumn[3] = pGrid.GetColumnToIndex("DR_AMOUNT");            //�����Ա�
            pGDColumn[4] = pGrid.GetColumnToIndex("CR_AMOUNT");            //�������
            pGDColumn[5] = pGrid.GetColumnToIndex("REMAIN_AMOUNT");        //�����ܾ�
            pGDColumn[6] = pGrid.GetColumnToIndex("CURRENCY_CODE");        //��ȭ
            pGDColumn[7] = pGrid.GetColumnToIndex("REMAIN_CURR_AMOUNT");   //�����ܾ�[��ȭ�ܾ�]

            pXLColumn[0] = 2;    //����
            pXLColumn[1] = 6;    //����
            pXLColumn[2] = 16;   //�����ܾ�
            pXLColumn[3] = 22;   //�����Ա�
            pXLColumn[4] = 27;   //�������
            pXLColumn[5] = 32;   //�����ܾ�
            pXLColumn[6] = 38;   //��ȭ
            pXLColumn[7] = 40;   //�����ܾ�[��ȭ�ܾ�]
        }

        private void SetArray2(out string[] pDBColumn, out int[] pXLColumn)
        {
            pDBColumn = new string[5];
            pXLColumn = new int[5];


            pDBColumn[0] = "ACCOUNT_DR_CR_NAME";  //����
            pDBColumn[1] = "BANK_NAME";           //�����
            pDBColumn[2] = "REMARK";              //����
            pDBColumn[3] = "DEPOSIT_AMOUNT";      //����/����
            pDBColumn[4] = "BILL_AMOUNT";         //����

            pXLColumn[0] = 2;    //����
            pXLColumn[1] = 6;    //�����
            pXLColumn[2] = 15;   //����
            pXLColumn[3] = 29;   //����/����
            pXLColumn[4] = 36;   //����
        }

        #endregion;

        #region ----- Convert decimal  Method ----

        private decimal ConvertNumber(string pStringNumber)
        {
            decimal vConvertDecimal = 0m;

            try
            {
                bool isNull = string.IsNullOrEmpty(pStringNumber);
                if (isNull != true)
                {
                    vConvertDecimal = decimal.Parse(pStringNumber);
                }

            }
            catch (System.Exception ex)
            {
                mMessageError = ex.Message;
                mAppInterface.OnAppMessageEvent(mMessageError);
                System.Windows.Forms.Application.DoEvents();
            }

            return vConvertDecimal;
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

        #region ----- XlLine1 Methods -----

        private int XlLine1(InfoSummit.Win.ControlAdv.ISGridAdvEx pGrid, int pGridRow, int pXLine, int[] pGDColumn, int[] pXLColumn)
        {
            int vXLine = pXLine; //������ ������ ǥ�õǴ� �� ��ȣ

            int vGDColumnIndex = 0;
            int vXLColumnIndex = 0;

            object vObject = null;
            string vConvertString = string.Empty;
            decimal vConvertDecimal = 0m;
            bool IsConvert = false;

            try
            {
                mPrinting.XLActiveSheet("Destination");

                //[BANK_NAME]����
                vGDColumnIndex = pGDColumn[1];
                vXLColumnIndex = pXLColumn[1];
                vObject = pGrid.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    if (mtmpString2 != vConvertString)
                    {
                        vConvertString = string.Format("{0}", vConvertString);
                        mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);

                        mtmpString2 = vConvertString;

                        int vDrawLineColumnSTART = vXLColumnIndex;
                        int vDrawLineColumnEND = pXLColumn[2] - 1;

                        mPrinting.XL_LineDraw_Top(vXLine, vDrawLineColumnSTART, vDrawLineColumnEND, 1);
                    }
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                //[TR_MANAGE_NAME]����
                vGDColumnIndex = pGDColumn[0];
                vXLColumnIndex = pXLColumn[0];
                vObject = pGrid.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    if (mtmpString1 != vConvertString)
                    {
                        vConvertString = string.Format("{0}", vConvertString);
                        mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);

                        mtmpString1 = vConvertString;

                        int vDrawLineColumnSTART = mCopyColumnSTART + 1;
                        int vDrawLineColumnEND = mCopyColumnEND - 1;

                        mPrinting.XL_LineDraw_Top(vXLine, vDrawLineColumnSTART, vDrawLineColumnEND, 2);

                        if (mMessageValue1 == vConvertString)
                        {
                            vDrawLineColumnSTART = pXLColumn[0];
                            vDrawLineColumnEND = pXLColumn[2] - 1;
                            mPrinting.XLSetCell(vXLine, vXLColumnIndex, null);
                            mPrinting.XLCellMerge(vXLine, vDrawLineColumnSTART, vXLine, vDrawLineColumnEND, false);
                            mPrinting.XLSetCell(vXLine, vDrawLineColumnSTART, vConvertString);

                            //vDrawLineColumnSTART = pXLColumn[0];
                            //vDrawLineColumnEND = mCopyColumnEND - 1;

                            //mPrinting.XLCellAlignmentHorizontal(vXLine, vXLColumnIndex, vXLine, vXLColumnIndex, "C");
                            //mPrinting.XL_LineDraw_TopBottom(vXLine, vDrawLineColumnSTART, vDrawLineColumnEND, 2);

                            //vDrawLineColumnSTART = pXLColumn[0];
                            //vDrawLineColumnEND = pXLColumn[1] -1;
                            //mPrinting.XL_LineClearRIGHT(vXLine, vDrawLineColumnSTART, vDrawLineColumnEND);
                        }
                    }
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                //[BEGIN_AMOUNT]�����ܾ�
                vGDColumnIndex = pGDColumn[2];
                vXLColumnIndex = pXLColumn[2];
                vObject = pGrid.GetCellValue(pGridRow, vGDColumnIndex);
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

                //[DR_AMOUNT]�����Ա�
                vGDColumnIndex = pGDColumn[3];
                vXLColumnIndex = pXLColumn[3];
                vObject = pGrid.GetCellValue(pGridRow, vGDColumnIndex);
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

                //[CR_AMOUNT]�������
                vGDColumnIndex = pGDColumn[4];
                vXLColumnIndex = pXLColumn[4];
                vObject = pGrid.GetCellValue(pGridRow, vGDColumnIndex);
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

                //[REMAIN_AMOUNT]�����ܾ�
                vGDColumnIndex = pGDColumn[5];
                vXLColumnIndex = pXLColumn[5];
                vObject = pGrid.GetCellValue(pGridRow, vGDColumnIndex);
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

                //[CURRENCY_CODE]��ȭ
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

                //[REMAIN_CURR_AMOUNT]�����ܾ�[��ȭ�ܾ�]
                vGDColumnIndex = pGDColumn[7];
                vXLColumnIndex = pXLColumn[7];
                vObject = pGrid.GetCellValue(pGridRow, vGDColumnIndex);
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
                vXLine++;
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

        #region ----- XlLine2 Methods -----

        private int XlLine2(System.Data.DataRow pRow, int pXLine, string[] pDBColumn, int[] pXLColumn)
        {
            int vXLine = pXLine; //������ ������ ǥ�õǴ� �� ��ȣ

            int vXLColumnIndex = 0;

            object vObject = null;
            string vConvertString = string.Empty;
            decimal vConvertDecimal = 0m;
            bool IsConvert = false;

            try
            {
                mPrinting.XLActiveSheet("Destination");

                //[BANK_NAME]�����
                vXLColumnIndex = pXLColumn[1];
                vObject = pRow[pDBColumn[1]];
                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    if (mtmpString2 != vConvertString)
                    {
                        vConvertString = string.Format("{0}", vConvertString);
                        mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);

                        mtmpString2 = vConvertString;

                        int vDrawLineColumnSTART = vXLColumnIndex;
                        int vDrawLineColumnEND = pXLColumn[2] - 1;

                        mPrinting.XL_LineDraw_Top(vXLine, vDrawLineColumnSTART, vDrawLineColumnEND, 1);
                    }
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                //[ACCOUNT_DR_CR_NAME]����
                vXLColumnIndex = pXLColumn[0];
                vObject = pRow[pDBColumn[0]];
                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    if (mtmpString1 != vConvertString)
                    {
                        vConvertString = string.Format("{0}", vConvertString);
                        mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);

                        mtmpString1 = vConvertString;

                        int vDrawLineColumnSTART = mCopyColumnSTART + 1;
                        int vDrawLineColumnEND = mCopyColumnEND - 1;

                        mPrinting.XL_LineDraw_Top(vXLine, vDrawLineColumnSTART, vDrawLineColumnEND, 2);

                        if (mMessageValue6 == vConvertString)
                        {
                            vDrawLineColumnSTART = pXLColumn[0];
                            vDrawLineColumnEND = pXLColumn[3] - 1;
                            mPrinting.XLSetCell(vXLine, vXLColumnIndex, null);
                            mPrinting.XLCellMerge(vXLine, vDrawLineColumnSTART, vXLine, vDrawLineColumnEND, false);
                            mPrinting.XLSetCell(vXLine, vDrawLineColumnSTART, vConvertString);

                            //vDrawLineColumnSTART = pXLColumn[0];
                            //vDrawLineColumnEND = pXLColumn[1] - 1;
                            //mPrinting.XL_LineClearRIGHT(vXLine, vDrawLineColumnSTART, vDrawLineColumnEND);

                            //vDrawLineColumnSTART = pXLColumn[1];
                            //vDrawLineColumnEND = pXLColumn[2] - 1;
                            //mPrinting.XL_LineClearRIGHT(vXLine, vDrawLineColumnSTART, vDrawLineColumnEND);

                            mPrinting.XLCellAlignmentHorizontal(vXLine, vXLColumnIndex, vXLine, vXLColumnIndex, "C");
                            mPrinting.XL_LineDraw_TopBottom(vXLine, vDrawLineColumnSTART, vDrawLineColumnEND, 2);

                            //vDrawLineColumnSTART = pXLColumn[0];
                            //vDrawLineColumnEND = pXLColumn[1] - 1;
                            //mPrinting.XL_LineClearTOP(vXLine, vDrawLineColumnSTART, vDrawLineColumnEND);
                        }
                        else if (mMessageValue7 == vConvertString)
                        {
                            vDrawLineColumnSTART = pXLColumn[0];
                            vDrawLineColumnEND = pXLColumn[3] - 1;
                            mPrinting.XLSetCell(vXLine, vXLColumnIndex, null);
                            mPrinting.XLCellMerge(vXLine, vDrawLineColumnSTART, vXLine, vDrawLineColumnEND, false);
                            mPrinting.XLSetCell(vXLine, vDrawLineColumnSTART, vConvertString);

                            //vDrawLineColumnSTART = pXLColumn[0];
                            //vDrawLineColumnEND = pXLColumn[1] - 1;
                            //mPrinting.XL_LineClearRIGHT(vXLine, vDrawLineColumnSTART, vDrawLineColumnEND);

                            //vDrawLineColumnSTART = pXLColumn[1];
                            //vDrawLineColumnEND = pXLColumn[2] - 1;
                            //mPrinting.XL_LineClearRIGHT(vXLine, vDrawLineColumnSTART, vDrawLineColumnEND);

                            mPrinting.XLCellMerge(vXLine, vDrawLineColumnSTART, vXLine, vDrawLineColumnEND, false);
                            mPrinting.XLCellAlignmentHorizontal(vXLine, vXLColumnIndex, vXLine, vXLColumnIndex, "C");
                            mPrinting.XL_LineDraw_TopBottom(vXLine, vDrawLineColumnSTART, vDrawLineColumnEND, 2);

                            //vDrawLineColumnSTART = pXLColumn[0];
                            //vDrawLineColumnEND = pXLColumn[1] - 1;
                            //mPrinting.XL_LineClearTOP(vXLine, vDrawLineColumnSTART, vDrawLineColumnEND);
                        }
                    }
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                //[REMARK]����
                vXLColumnIndex = pXLColumn[2];
                vObject = pRow[pDBColumn[2]];
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

                //[DEPOSIT_AMOUNT]����/����
                vXLColumnIndex = pXLColumn[3];
                vObject = pRow[pDBColumn[3]];
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

                //[BILL_AMOUNT]����
                vXLColumnIndex = pXLColumn[4];
                vObject = pRow[pDBColumn[4]];
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
                vXLine++;
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

        public int LineWrite(InfoSummit.Win.ControlAdv.ISGridAdvEx pGrid, InfoSummit.Win.ControlAdv.ISDataAdapter pAdapter, string pDate)
        {
            string vMessage = string.Empty;
            mIsNewPage = false;
            mIsPrinted = false;

            int[] vGDColumn;
            int[] vXLColumn;
            string[] vDBColumn;

            int vPrintingLine = mPrintingLineSTART1;

            try
            {
                int vBy = 57; // 52; // 32;
                int vTotal = 0;
                int vCountDBRow = 0;

                int vTotalRow = pGrid.RowCount;
                if (pAdapter.OraSelectData != null)
                {
                    vCountDBRow = pAdapter.OraSelectData.Rows.Count;
                }

                if (vCountDBRow > 0)
                {
                    vTotal = vTotalRow + vCountDBRow + 4 + 2; //4 : �ι�° Sheet[SourceTab2]�� ���, Ÿ��Ʋ, ��������ȣ ������ ���, 2 : SourceTab3�� �����ʿ����
                }
                else
                {
                    vTotal = vTotalRow + vCountDBRow;
                }
                
                mPageTotalNumber = vTotal / vBy;
                mPageTotalNumber = (vTotal % vBy) == 0 ? mPageTotalNumber : (mPageTotalNumber + 1);

                #region ----- First Write ----
                if (vTotalRow > 0)
                {
                    int vCountRow = 0;

                    SetArray1(pGrid, out vGDColumn, out vXLColumn);

                    mPrinting.XLActiveSheet("SourceTab1");
                    mPrinting.XLSetCell(4, 2, pDate);

                    mMessageValue1 = mMessageAdapter.ReturnText("EAPP_10046");  //�Ұ�[EAPP_10046]
                    mMessageValue2 = mMessageAdapter.ReturnText("FCM_10222");   //�Ѱ����ڱ�[FCM_10222]

                    int vSheet1LIneMAX = 51; // 46; //32; //SourceTab1 ���� ��µǴ� ���
                    if (vTotalRow > vSheet1LIneMAX)
                    {
                        mIncrementCopyMAX = 67; // 62; //42;
                    }
                    else
                    {
                        mIncrementCopyMAX = vTotalRow + 9;
                    }
                    mCopyLineSUM = CopyAndPaste(mPrinting, mCopyLineSUM);

                    for (int vRow = 0; vRow < vTotalRow; vRow++)
                    {
                        vCountRow++;
                        vMessage = string.Format("{0}/{1}", vCountRow, vTotalRow);
                        mAppInterface.OnAppMessageEvent(vMessage);
                        System.Windows.Forms.Application.DoEvents();

                        vPrintingLine = XlLine1(pGrid, vRow, vPrintingLine, vGDColumn, vXLColumn);
                        mIsPrinted = true;

                        if (vTotalRow == vCountRow)
                        {
                            CellMerge(vPrintingLine, vXLColumn, mMessageValue2);
                        }
                        else
                        {
                            IsNewPage(vPrintingLine);
                            if (mIsNewPage == true)
                            {
                                vPrintingLine = (mCopyLineSUM - mIncrementCopyMAX) + (mPrintingLineFIRST1 - 1);
                                mtmpString1 = string.Empty;
                                mtmpString2 = string.Empty;
                            }
                        }
                    }
                }
                #endregion;

                #region ----- Second Write ----
                vTotalRow = vCountDBRow;
                if (vTotalRow > 0)
                {
                    int vCountRow = 0;

                    mMessageValue3 = mMessageAdapter.ReturnText("FCM_10212"); //�Ա�[FCM_10212]
                    mMessageValue4 = mMessageAdapter.ReturnText("FCM_10213"); //���[FCM_10213]
                    mMessageValue5 = mMessageAdapter.ReturnText("FCM_10230"); //��ü[FCM_10230]
                    mMessageValue6 = mMessageAdapter.ReturnText("FCM_10214"); //�Ա��հ�[FCM_10214]
                    mMessageValue7 = mMessageAdapter.ReturnText("FCM_10215"); //����հ�[FCM_10215]

                    SetArray2(out vDBColumn, out vXLColumn);

                    if (mIsPrinted == false)
                    {
                        int vSheet2LIneMAX = 63; // 58; // 38; //SourceTab2 ���� ��µǴ� ���
                        if (vTotalRow > vSheet2LIneMAX)
                        {
                            mIncrementCopyMAX = 67; //62; //42;
                        }
                        else
                        {
                            mIncrementCopyMAX = vTotalRow + 3;
                        }

                        //���ڱ� ��ȹ�� ��� �� �ߴٸ�
                        mCopyLineSUM = SecondCopyAndPaste2(mPrinting, mCopyLineSUM);

                        vPrintingLine = (mCopyLineSUM - mIncrementCopyMAX) + (mPrintingLineSTART2 - 1);
                    }
                    else
                    {
                        if (mPageTotalNumber > 1)
                        {
                            int vRest = mMaxLinePrinting - mCopyLineSUM; //���� �۾� Sheet�� ���� ��� ���ϱ�
                            int vLineWrite = vTotalRow + 4 + 2; //4 : ����� ��, ���, Ÿ��Ʋ, ������ ���� ���Ե� ���, 2 : SourceTab3�� �����ʿ����
                            if (vLineWrite < vRest)
                            {
                                mCopyLineSUM++;
                                mIncrementCopyMAX = vTotalRow + 3;
                            }
                            else
                            {
                                mCopyLineSUM = mCopyLineSUM + vRest;

                                mCopyLineSUM++;
                                mIncrementCopyMAX = vTotalRow + 3;
                            }
                        }
                        else
                        {
                            mCopyLineSUM++;
                            mIncrementCopyMAX = vTotalRow + 3;
                        }
                        //���ڱ� ��ȹ�� ��� �ߴٸ�
                        mCopyLineSUM = SecondCopyAndPaste2(mPrinting, mCopyLineSUM);

                        vPrintingLine = (mCopyLineSUM - mIncrementCopyMAX) + (mPrintingLineSTART2 - 1);
                    }

                    foreach (System.Data.DataRow vRow in pAdapter.OraSelectData.Rows)
                    {
                        vCountRow++;
                        vMessage = string.Format("{0}/{1}", vCountRow, vTotalRow);
                        mAppInterface.OnAppMessageEvent(vMessage);
                        System.Windows.Forms.Application.DoEvents();

                        vPrintingLine = XlLine2(vRow, vPrintingLine, vDBColumn, vXLColumn);

                        if (vTotalRow == vCountRow)
                        {
                            mCopyLineSUM = ThirdCopyAndPaste(mPrinting, mCopyLineSUM);
                        }
                        else
                        {
                            IsNewPage(vPrintingLine);
                            if (mIsNewPage == true)
                            {
                                vPrintingLine = (mCopyLineSUM - mIncrementCopyMAX) + (mPrintingLineFIRST2 - 1);
                                mtmpString1 = string.Empty;
                                mtmpString2 = string.Empty;
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

            mPrintingLineSTART1 = vPrintingLine;

            return mPageNumber;
        }

        #endregion;

        #region ----- New Page iF Methods ----

        private void IsNewPage(int pPrintingLine)
        {
            int vPrintingLineEND = mCopyLineSUM - 1;
            if (vPrintingLineEND < pPrintingLine)
            {
                mIsNewPage = true;
                mCopyLineSUM = SecondCopyAndPaste2(mPrinting, mCopyLineSUM);
            }
            else
            {
                mIsNewPage = false;
            }
        }

        #endregion;

        #region ----- Copy&Paste Sheet Method ----

        //ù��° ������ ����
        private int CopyAndPaste(XL.XLPrint pPrinting, int pCopySumPrintingLine)
        {
            int vCopySumPrintingLine = pCopySumPrintingLine;

            int vCopyPrintingRowSTART = vCopySumPrintingLine;
            vCopySumPrintingLine = vCopySumPrintingLine + mIncrementCopyMAX;
            int vCopyPrintingRowEnd = vCopySumPrintingLine;
            pPrinting.XLActiveSheet("SourceTab1");
            object vRangeSource = pPrinting.XLGetRange(mCopyColumnSTART, 1, mIncrementCopyMAX, mCopyColumnEND); //[����], [Sheet2.Cell("A1:AS67")], ���� ��Ʈ���� ���� ������ ���ȣ, ���� ��Ʈ���� ���� ������ ����ȣ, ���� ��Ʈ���� ���� ������ ���ȣ, ���� ��Ʈ���� ���� ������ ����ȣ
            pPrinting.XLActiveSheet("Destination");
            object vRangeDestination = pPrinting.XLGetRange(vCopyPrintingRowSTART, 1, vCopyPrintingRowEnd, mCopyColumnEND); //[���], [Sheet1.Cell("A1:AS67")], ���� ��Ʈ���� ���� ������ ���ȣ, ���� ��Ʈ���� ���� ������ ����ȣ, ���� ��Ʈ���� ���� ������ ���ȣ, ���� ��Ʈ���� ���� ������ ����ȣ
            pPrinting.XLCopyRange(vRangeSource, vRangeDestination);


            if (mPageTotalNumber > 1)
            {
                mPageNumber++; //������ ��ȣ
                mPrinting.XLCellMerge(vCopyPrintingRowEnd, 23, vCopyPrintingRowEnd, 26, false);
                string vPageNumberText = string.Format("Page {0}/{1}", mPageNumber, mPageTotalNumber);
                mPrinting.XLSetCell(vCopyPrintingRowEnd, 23, vPageNumberText); //������ ��ȣ, XLcell[��, ��]
            }

            return vCopySumPrintingLine;
        }

        private int SecondCopyAndPaste2(XL.XLPrint pPrinting, int pCopySumPrintingLine)
        {
            int vCopySumPrintingLine = pCopySumPrintingLine;

            int vCopyPrintingRowSTART = vCopySumPrintingLine;
            vCopySumPrintingLine = vCopySumPrintingLine + mIncrementCopyMAX;
            int vCopyPrintingRowEnd = vCopySumPrintingLine;
            pPrinting.XLActiveSheet("SourceTab2");
            object vRangeSource = pPrinting.XLGetRange(mCopyColumnSTART, 1, mIncrementCopyMAX, mCopyColumnEND); //[����], [Sheet2.Cell("A1:AS67")], ���� ��Ʈ���� ���� ������ ���ȣ, ���� ��Ʈ���� ���� ������ ����ȣ, ���� ��Ʈ���� ���� ������ ���ȣ, ���� ��Ʈ���� ���� ������ ����ȣ
            pPrinting.XLActiveSheet("Destination");
            object vRangeDestination = pPrinting.XLGetRange(vCopyPrintingRowSTART, 1, vCopyPrintingRowEnd, mCopyColumnEND); //[���], [Sheet1.Cell("A1:AS67")], ���� ��Ʈ���� ���� ������ ���ȣ, ���� ��Ʈ���� ���� ������ ����ȣ, ���� ��Ʈ���� ���� ������ ���ȣ, ���� ��Ʈ���� ���� ������ ����ȣ
            pPrinting.XLCopyRange(vRangeSource, vRangeDestination);

            return vCopySumPrintingLine;
        }

        private int ThirdCopyAndPaste(XL.XLPrint pPrinting, int pCopySumPrintingLine)
        {
            int vCopySumPrintingLine = pCopySumPrintingLine;
            int vIncrementCopyMAX = 3;

            int vCopyPrintingRowSTART = vCopySumPrintingLine;
            vCopySumPrintingLine = vCopySumPrintingLine + vIncrementCopyMAX;
            int vCopyPrintingRowEnd = vCopySumPrintingLine;
            pPrinting.XLActiveSheet("SourceTab3");
            object vRangeSource = pPrinting.XLGetRange(mCopyColumnSTART, 1, vIncrementCopyMAX, mCopyColumnEND); //[����], [Sheet2.Cell("A1:AS67")], ���� ��Ʈ���� ���� ������ ���ȣ, ���� ��Ʈ���� ���� ������ ����ȣ, ���� ��Ʈ���� ���� ������ ���ȣ, ���� ��Ʈ���� ���� ������ ����ȣ
            pPrinting.XLActiveSheet("Destination");
            object vRangeDestination = pPrinting.XLGetRange(vCopyPrintingRowSTART, 1, vCopyPrintingRowEnd, mCopyColumnEND); //[���], [Sheet1.Cell("A1:AS67")], ���� ��Ʈ���� ���� ������ ���ȣ, ���� ��Ʈ���� ���� ������ ����ȣ, ���� ��Ʈ���� ���� ������ ���ȣ, ���� ��Ʈ���� ���� ������ ����ȣ
            pPrinting.XLCopyRange(vRangeSource, vRangeDestination);

            mPageNumber++; //������ ��ȣ
            int vPageWriteLine = vCopyPrintingRowEnd - 1;
            mPrinting.XLCellMerge(vPageWriteLine, 23, vPageWriteLine, 26, false);
            string vPageNumberText = string.Format("Page {0}/{1}", mPageNumber, mPageTotalNumber);
            mPrinting.XLSetCell(vPageWriteLine, 23, vPageNumberText); //������ ��ȣ, XLcell[��, ��]

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
            string vSaveFileName = string.Format("{0}{1:D3}", pSaveFileName, vMaxNumber);

            vSaveFileName = string.Format("{0}\\{1}.xls", vWallpaperFolder, vSaveFileName);
            mPrinting.XLSave(vSaveFileName);
        }

        #endregion;
    }
}