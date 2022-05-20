using System;

namespace FCMF0551
{
    public class XLPrinting
    {
        #region ----- Variables -----

        private InfoSummit.Win.ControlAdv.ISAppInterface mAppInterface = null;
        private InfoSummit.Win.ControlAdv.ISMessageAdapter mMessageAdapter = null;

        private XL.XLPrint mPrinting = null;

        private string mMessageError = string.Empty;

        private int mPageNumber = 0;

        private string mPrintingDateTime = string.Empty;

        private bool mIsNewPage = false;

        private string mXLOpenFileName = string.Empty;

        private int mPrintingLineSTART1 = 7; //���� ��½� ���� ���� �� ��ġ ����

        private int mCopyLineSUM = 1;        //������ ���õ� ��Ʈ�� ����Ǿ��� ���� �� ��ġ
        private int mIncrementCopyMAX = 31;  //����Ǿ��� ���� ����

        private int mCopyColumnSTART = 1; //����Ǿ�  �� �� ���� ��
        private int mCopyColumnEND = 70;  //������ ���õ� ��Ʈ�� ����Ǿ��� �� �� ��ġ

        private string mAccountCode = string.Empty;
        private string mAccountName = string.Empty;

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

        #region ----- Array Set ----

        private void SetArray1(InfoSummit.Win.ControlAdv.ISGridAdvEx pGrid, out int[] pGDColumn, out int[] pXLColumn)
        {
            pGDColumn = new int[7];
            pXLColumn = new int[7];

            pGDColumn[0] = pGrid.GetColumnToIndex("GL_DATE");           //����
            pGDColumn[1] = pGrid.GetColumnToIndex("REMARK");            //����
            pGDColumn[2] = pGrid.GetColumnToIndex("DR_AMOUNT");         //����
            pGDColumn[3] = pGrid.GetColumnToIndex("CR_AMOUNT");         //�뺯
            pGDColumn[4] = pGrid.GetColumnToIndex("REMAIN_AMOUNT");     //�ܾ�
            //------------ 2011.7.6 ��ȭ�ݾ� ��� ��û ������ �߰� �۾� -------------
            pGDColumn[5] = pGrid.GetColumnToIndex("DR_CURRENCY_AMOUNT");//����(��ȭ)
            pGDColumn[6] = pGrid.GetColumnToIndex("CR_CURRENCY_AMOUNT");//�뺯(��ȭ)
            //-----------------------------------------------------------------------

            pXLColumn[0] = 02;   //����
            pXLColumn[1] = 07;   //����
            pXLColumn[2] = 20;   //����
            pXLColumn[3] = 28;   //�뺯
            pXLColumn[4] = 36;   //�ܾ�
            pXLColumn[5] = 44;   //����(��ȭ)
            pXLColumn[6] = 52;   //�뺯(��ȭ)

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
            bool IsConvert = false;
            pConvertDateTimeShort = string.Empty;

            try
            {
                if (pObject != null)
                {
                    IsConvert = pObject is System.DateTime;
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

            return IsConvert;
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

            int vLineColumnSTART = mCopyColumnSTART + 1;
            int vLineColumnEND = mCopyColumnEND - 1;

            try
            {
                mPrinting.XLActiveSheet("Destination");

                mPrinting.XL_LineDraw_Bottom(vXLine, vLineColumnSTART, vLineColumnEND, 1);

                //����
                vGDColumnIndex = pGDColumn[0];
                vXLColumnIndex = pXLColumn[0];
                vObject = pGrid.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertDate(vObject, out vConvertString);
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

                //����
                vGDColumnIndex = pGDColumn[1];
                vXLColumnIndex = pXLColumn[1];
                vObject = pGrid.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0}", vConvertString);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);

                    if (vConvertString == "�̿��ݾ�"
                     || vConvertString == "������"
                     || vConvertString == "�Ѵ���")
                    {
                        mPrinting.XL_LineDraw_TopBottom(vXLine, vLineColumnSTART, vLineColumnEND, 2);
                        mPrinting.XLCellAlignmentHorizontal(vXLine, pXLColumn[1], vXLine, pXLColumn[1], "C");
                    }
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                //����
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

                //�뺯
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

                //�ܾ�
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

                //����(��ȭ)
                vGDColumnIndex = pGDColumn[5];
                vXLColumnIndex = pXLColumn[5];
                vObject = pGrid.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true && Convert.ToDecimal(vObject) != 0)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,###.0000}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                //�뺯(��ȭ)
                vGDColumnIndex = pGDColumn[6];
                vXLColumnIndex = pXLColumn[6];
                vObject = pGrid.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true && Convert.ToDecimal(vObject) != 0)
                {
                    vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,###.0000}", vConvertDecimal);
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

        public int LineWrite(InfoSummit.Win.ControlAdv.ISGridAdvEx pGrid, string pPeriod, string pSupplierCustomerName)
        {
            string vMessage = string.Empty;
            mIsNewPage = false;

            mPrintingDateTime = string.Format("{0}", System.DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss", null));

            int[] vGDColumn;
            int[] vXLColumn;

            int vPrintingLine = mPrintingLineSTART1;

            object vObject = null;
            bool IsConvert = false;
            int vAccountCodeColumnIndex = pGrid.GetColumnToIndex("ACCOUNT_CODE");
            int vAccountNameColumnIndex = pGrid.GetColumnToIndex("ACCOUNT_DESC");
            string tmpAccountCode = string.Empty;
            bool vIsPageSkip = false;

            try
            {
                int vTotalRow = pGrid.RowCount;

                #region ----- First Write ----

                if (vTotalRow > 0)
                {
                    int vCountRow = 0;

                    //-------------------------------------------------------
                    //[�ʱⰪ ����]
                    //-------------------------------------------------------
                    vObject = pGrid.GetCellValue(0, vAccountCodeColumnIndex);
                    IsConvert = IsConvertString(vObject, out tmpAccountCode);
                    vObject = pGrid.GetCellValue(0, vAccountNameColumnIndex);
                    IsConvert = IsConvertString(vObject, out mAccountName);
                    mAccountCode = tmpAccountCode;
                    //-------------------------------------------------------

                    SetArray1(pGrid, out vGDColumn, out vXLColumn);

                    mPrinting.XLActiveSheet("SourceTab1");
                    mPrinting.XLSetCell(3, 2, pPeriod);
                    mPrinting.XLSetCell(5, 13, pSupplierCustomerName);

                    mCopyLineSUM = CopyAndPaste(mCopyLineSUM);

                    for (int vRow = 0; vRow < vTotalRow; vRow++)
                    {
                        vObject = pGrid.GetCellValue(vRow, vAccountNameColumnIndex);
                        IsConvert = IsConvertString(vObject, out mAccountName);
                        vObject = pGrid.GetCellValue(vRow, vAccountCodeColumnIndex);
                        IsConvert = IsConvertString(vObject, out mAccountCode);

                        if (IsConvert == true)
                        {
                            if (mAccountCode != tmpAccountCode)
                            {
                                tmpAccountCode = mAccountCode;
                                vIsPageSkip = true;
                            }
                            else
                            {
                                vIsPageSkip = false;
                            }
                        }
                        else
                        {
                            vIsPageSkip = false;
                        }

                        IsNewPage(vPrintingLine, vIsPageSkip);
                        if (mIsNewPage == true)
                        {
                            vPrintingLine = (mCopyLineSUM - mIncrementCopyMAX) + (mPrintingLineSTART1 - 1);
                        }

                        vCountRow++;
                        vMessage = string.Format("{0}/{1}", vCountRow, vTotalRow);
                        mAppInterface.OnAppMessageEvent(vMessage);
                        System.Windows.Forms.Application.DoEvents();

                        vPrintingLine = XlLine1(pGrid, vRow, vPrintingLine, vGDColumn, vXLColumn);
                    }

                    if (vTotalRow == vCountRow)
                    {
                        //������ ���̸�...
                        PageNumberSetCell(vPrintingLine);
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

        private void IsNewPage(int pPrintingLine, bool pIsPageSkip)
        {
            int vPrintingLineEND = mCopyLineSUM - 2; // mCopyLineSUM = 48, 48 - 2 = 46, 46���� Page Skip �ϱ����� 48���� 2�� ��.
            if (vPrintingLineEND < pPrintingLine)
            {
                mIsNewPage = true;

                PageNumberSetCell(pPrintingLine);

                mCopyLineSUM = CopyAndPaste(mCopyLineSUM);
            }
            else if (pIsPageSkip == true)
            {
                mIsNewPage = true;

                PageNumberSetCell(pPrintingLine);

                mCopyLineSUM = CopyAndPaste(mCopyLineSUM);
            }
            else
            {
                mIsNewPage = false;
            }
        }

        #endregion;

        #region ----- Page Number Method ----

        private void PageNumberSetCell(int pXLine)
        {
            string vPageNumberText = string.Empty;
            int vPageNumber = mPageNumber;
            int vRowSTART = pXLine;
            int vRowEND = pXLine;
            int vColumnSTART = 52;
            int vColumnEND = 69;

            vPageNumberText = string.Format("{0} [{1}]", mPrintingDateTime, vPageNumber);

            mPrinting.XLCellMerge(vRowSTART, vColumnSTART, vRowEND, vColumnEND, false);
            mPrinting.XLSetCell(vRowSTART, vColumnSTART, vPageNumberText); //������ ��ȣ, XLcell[��, ��]
            mPrinting.XLCellAlignmentHorizontal(vRowSTART, vColumnSTART, vRowEND, vColumnSTART, "R");
        }

        #endregion;

        #region ----- Copy&Paste Sheet Method ----

        //ù��° ������ ����
        private int CopyAndPaste(int pCopySumPrintingLine)
        {
            int vCopySumPrintingLine = pCopySumPrintingLine;

            int vCopyPrintingRowSTART = vCopySumPrintingLine;
            vCopySumPrintingLine = vCopySumPrintingLine + mIncrementCopyMAX;
            int vCopyPrintingRowEnd = vCopySumPrintingLine;
            mPrinting.XLActiveSheet("SourceTab1");
            object vRangeSource = mPrinting.XLGetRange(mCopyColumnSTART, 1, mIncrementCopyMAX, mCopyColumnEND); //[����], [Sheet2.Cell("A1:AS67")], ���� ��Ʈ���� ���� ������ ���ȣ, ���� ��Ʈ���� ���� ������ ����ȣ, ���� ��Ʈ���� ���� ������ ���ȣ, ���� ��Ʈ���� ���� ������ ����ȣ
            mPrinting.XLActiveSheet("Destination");
            object vRangeDestination = mPrinting.XLGetRange(vCopyPrintingRowSTART, 1, vCopyPrintingRowEnd, mCopyColumnEND); //[���], [Sheet1.Cell("A1:AS67")], ���� ��Ʈ���� ���� ������ ���ȣ, ���� ��Ʈ���� ���� ������ ����ȣ, ���� ��Ʈ���� ���� ������ ���ȣ, ���� ��Ʈ���� ���� ������ ����ȣ
            mPrinting.XLCopyRange(vRangeSource, vRangeDestination);

            mPageNumber++; //������ ��ȣ

            int vXLine = pCopySumPrintingLine + 4;
            string vAccountName = string.Format("�������� : [{0}] {1}", mAccountCode, mAccountName);
            mPrinting.XLSetCell(vXLine, 45, vAccountName);

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
            string vSaveFileName = string.Format("{0}{1:D3}", pSaveFileName, vMaxNumber);

            vSaveFileName = string.Format("{0}\\{1}.xls", vWallpaperFolder, vSaveFileName);
            mPrinting.XLSave(vSaveFileName);
        }

        #endregion;
    }
}