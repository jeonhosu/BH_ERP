using System;

namespace FCMF0227
{
    /// <summary>
    /// XLPrint Class�� �̿��� Report�� ���� 
    /// </summary>
    public class XLPrinting
    {
        #region ----- Variables -----

        private InfoSummit.Win.ControlAdv.ISGridAdvEx mGridAdvEx;

        private InfoSummit.Win.ControlAdv.ISProgressBar mProgressBar1;
        private InfoSummit.Win.ControlAdv.ISProgressBar mProgressBar2;

        

        private XL.XLPrint mPrinting = null;

        private string mMessageError = string.Empty;

        private string mXLOpenFileName = string.Empty;

        private int[] mIndexGridColumns = new int[0] { };

        private int mPositionPrintLineSTART = 6; //���� ��½� ���� ���� �� ��ġ ����
        private int[] mIndexXLWriteColumn = new int[0] { }; //������ ����� �� ��ġ ����

        private int mSumWriteLine = 0; //������ ��µǴ� �� ���� ��
        private int mMaxIncrement = 44; //���� ��µǴ� ���� ���ۺ��� �� ���� ����
        private int mSumPrintingLineCopy = 1; //������ ���õ� ��Ʈ�� ����Ǿ��� ���� �� ��ġ �� ���� �� ��
        private int mMaxIncrementCopy = 45; //�ݺ� ����Ǿ��� ���� �ִ� ����

        private int mXLColumnAreaSTART = 1; //����Ǿ��� ��Ʈ�� ��, ���ۿ�
        private int mXLColumnAreaEND = 65;  //����Ǿ��� ��Ʈ�� ��, ���῭

        #endregion;

        #region ----- Property -----

        /// <summary>
        /// ��� Error Message ���
        /// </summary>
        public string ErrorMessage
        {
            get
            {
                return mMessageError;
            }
        }

        /// <summary>
        /// Message ����� Grid
        /// </summary>
        public InfoSummit.Win.ControlAdv.ISGridAdvEx MessageGridEx
        {
            set
            {
                mGridAdvEx = value;
            }
        }

        /// <summary>
        /// ��ü Data ���� ProgressBar
        /// </summary>
        public InfoSummit.Win.ControlAdv.ISProgressBar ProgressBar1
        {
            set
            {
                mProgressBar1 = value;
            }
        }

        /// <summary>
        /// Page�� Data ���� ProgressBar
        /// </summary>
        public InfoSummit.Win.ControlAdv.ISProgressBar ProgressBar2
        {
            set
            {
                mProgressBar2 = value;
            }
        }

        /// <summary>
        /// Ope�� Excel File �̸�
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
                mPrinting.XLOpenFile(mXLOpenFileName);

                IsOpen = true;
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
            int vXLColumn2 = 4;  //������[OPERATION_DESCRIPTION]
            int vXLColumn3 = 11; //���� ����� �۾� ����[OPERATION_COMMENT]

            int vXLDrawLineColumnSTART = 2; //���׸���, ���� ��
            int vXLDrawLineColumnEND = 45;  //���׸���, ���� ��

            object vObject = null;
            int vMaxPrintingLine = mMaxIncrementCopy;

            //pPrinting.XLActiveSheet(2);
            pPrinting.XLActiveSheet("SourceTab1");

            for (int vXLine = mPositionPrintLineSTART; vXLine < vMaxPrintingLine; vXLine++)
            {
                pPrinting.XLSetCell(vXLine, vXLColumn1, vObject); //No[OPERATION_SEQ_NO]
                pPrinting.XLSetCell(vXLine, vXLColumn2, vObject); //������[OPERATION_DESCRIPTION]
                pPrinting.XLSetCell(vXLine, vXLColumn3, vObject); //���� ����� �۾� ����[OPERATION_COMMENT]

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
            int vXLColumn2 = 4;  //������[OPERATION_DESCRIPTION]
            int vXLColumn3 = 11; //���� ����� �۾� ����[OPERATION_COMMENT]

            int vXLDrawLineColumnSTART = 2; //���׸���, ���� ��
            int vXLDrawLineColumnEND = 45;  //���׸���, ���� ��

            object vObject = null;
            int vMaxPrintingLine = mMaxIncrementCopy;

            for (int vXLine = pPrintingLine; vXLine < vMaxPrintingLine; vXLine++)
            {
                pPrinting.XLSetCell(vXLine, vXLColumn1, vObject); //No[OPERATION_SEQ_NO]
                pPrinting.XLSetCell(vXLine, vXLColumn2, vObject); //������[OPERATION_DESCRIPTION]
                pPrinting.XLSetCell(vXLine, vXLColumn3, vObject); //���� ����� �۾� ����[OPERATION_COMMENT]

                if (vXLine < mMaxIncrementCopy)
                {
                    pPrinting.XL_LineClear(vXLine, vXLDrawLineColumnSTART, vXLDrawLineColumnEND);
                }
            }
        }

        #endregion;

        #region ----- Title Methods ----

        private void XLTitle(int pRow, int pColumn, string pTitle)
        {
            try
            {
                //mPrinting.XLActiveSheet(2);
                mPrinting.XLActiveSheet("SourceTab1");
                mPrinting.XLSetCell(pRow, pColumn, pTitle);
            }
            catch (System.Exception ex)
            {
                mMessageError = string.Format("{0}", ex.Message);
            }
        }

        #endregion;

        #region ----- Header Left Methods ----

        private void XLHeaderLeft(int pRow, int pColumn, string pContent)
        {
            try
            {
                //mPrinting.XLActiveSheet(2);
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

        private void XLHeaderRight(int pRow, int pColumn, string pContent)
        {
            try
            {
                //mPrinting.XLActiveSheet(2);
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

        private void XLFooterLeft(int pRow, int pColumn, string pContent)
        {
            try
            {
                //mPrinting.XLActiveSheet(2);
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

        private void XLFooterRight(int pRow, int pColumn, string pContent)
        {
            try
            {
                //mPrinting.XLActiveSheet(2);
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

        private void XLHeader(string pTitle, string pHeaderLeft, string pHeaderRight)
        {
            try
            {
                XLTitle(2, 2, pTitle);

                XLHeaderLeft(4, 2, pHeaderLeft);
                XLHeaderRight(4, 34, pHeaderRight);
            }
            catch (System.Exception ex)
            {
                mMessageError = string.Format("{0}", ex.Message);
            }
        }

        #endregion;

        #region ----- Print Footer Methods ----

        private void XLFooter(string pFooterLeft, string pFooterRight)
        {
            try
            {
                XLFooterLeft(66, 2, pFooterLeft);
                XLFooterRight(66, 34, pFooterRight);
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
                //Grid�� [Edit] ���� [DataColumn] ���� �ִ� �� �̸��� ���� �ϸ� �ȴ�.
                string[] vGridDataColumns = new string[]
                {
                    "ACCOUNT_CODE",
                    "PERIOD_NAME",
                    "GL_DATE",
                    "GL_NUM",
                    "DEPT_NAME",
                    "DR_AMOUNT",
                    "CR_AMOUNT",
                    "REMAIN_AMOUNT",
                    "REMARK",
                    "MANAGEMENT1",
                    "GL_CURRENCY_AMOUNT",
                    "EXCHANGE_RATE",
                    "REFER_DATE1",
                    "REFER_DATE2",
                    "TAX_REG_NO",
                    "CUSTOMER_MANE"
                };

                int vIndexRow = 0;
                mIndexGridColumns = new int[vGridDataColumns.Length];

                foreach (string vName in vGridDataColumns)
                {
                    mIndexGridColumns[vIndexRow] = pGrid.GetColumnToIndex(vName);
                    vIndexRow++;
                }

                //������ ��µ� �� ��ġ ����
                int[] vXLColumns = new int[]
                {
                    2,  //ACCOUNT_CODE
                    6,  //PERIOD_NAME
                    10, //GL_DATE
                    14, //GL_NUM
                    18, //DEPT_NAME
                    21, //DR_AMOUNT
                    25, //CR_AMOUNT
                    29, //REMAIN_AMOUNT
                    33, //REMARK
                    36, //MANAGEMENT1
                    40, //GL_CURRENCY_AMOUNT
                    44, //EXCHANGE_RATE
                    47, //REFER_DATE1
                    51, //REFER_DATE2
                    55, //TAX_REG_NO
                    60  //CUSTOMER_MANE"
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
            int vXLine = pXLine - 1; //mPositionPrintLineSTART - 1, ��µ� ������ �� ��ġ���� ���� ���� �����Ƿ� 1�� ����.
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
                        case 0: //Default
                            vObject = pGrid.GridAdvExColElement[vGetIndexGridColumn].HeaderElement[0].Default;
                            mPrinting.XLSetCell(vXLine, mIndexXLWriteColumn[vCol], vObject);
                            break;
                        case 1: //KR
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
                            vObject = pGrid.GetCellValue(vRow, vCol);
                            pPrinting.XLSetCell(vXLine, pXLColumn[vCol], vObject);
                        }

                        //vObject = pGrid.GetCellValue(vRow, 3);
                        //vObject = ConvertDateTime(vObject);
                        //pPrinting.XLSetCell(vXLine, pXLColumn[3], vObject);
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

                    mProgressBar2.BarFillPercent = (Convert.ToSingle(vXLine - pXLine) / Convert.ToSingle(pPrintingRowEND - pPrintingRowSTART)) * 100F;
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
        /// <para>XLWirte(ISGridAdvEx, ���) :: Excel�� ���õ� Sheet�� �� Spread</para>
        /// <para>pGrid : ��ȸ�� Grid Object</para>
        /// <para>pTerritory : ���õ� ��� ���� Index</para>
        /// </summary>
        public int XLWirte(InfoSummit.Win.ControlAdv.ISGridAdvEx pGrid, int pTerritory, string pPeriodFrom, string pPeriodTo)
        {
            string vMessageText = string.Empty;

            string vPrintingDate = System.DateTime.Now.ToString("yyyy-MM-dd", null);
            string vPrintingTime = System.DateTime.Now.ToString("HH:mm:ss", null);

            int vPageNumber = 0;

            try
            {
                int vTotalRow = pGrid.RowCount; //Grid�� �� ���

                vMessageText = string.Format("Total Grid Row : {0}", vTotalRow);
                MessageGrid(vMessageText);

                //[��µ� �� ����]
                XLDefinePrintColumn(pGrid);

                //vTotalRow = 60;
                while (vTotalRow > mSumWriteLine)
                {
                    vPageNumber++;

                    //[Header]
                    string vTitle = "Slip Line List";
                    string vHeaderLeft = string.Format("Inquiry Period : {0} ~ {1}", pPeriodFrom, pPeriodTo);
                    switch (pTerritory)
                    {
                        case 0: //Default
                            vTitle = "Slip Line List";
                            vHeaderLeft = string.Format("Inquiry Period : {0} ~ {1}", pPeriodFrom, pPeriodTo);
                            break;
                        case 1: //KR
                            vTitle = "������ ��ȸ";
                            vHeaderLeft = string.Format("��ȸ��� : {0} ~ {1}", pPeriodFrom, pPeriodTo);
                            break;
                    }
                    string vHeaderRight = string.Format("Page : {0}", vPageNumber);
                    XLHeader(vTitle, vHeaderLeft, vHeaderRight);

                    //[Footer]
                    string vFooterLeft = string.Format("{0} {1}", vPrintingDate, vPrintingTime);
                    string vFooterRight = string.Format("{0}", "FCMF0225");
                    XLFooter(vFooterLeft, vFooterRight);

                    //[Header Columns]
                    XLHeaderColumns(pGrid, pTerritory, mPositionPrintLineSTART);


                    //[Content_Printing]
                    mSumWriteLine = NewPage(pGrid, vTotalRow, mSumWriteLine);
                    

                    ////[Sheet2]������ [Sheet1]�� �ٿ��ֱ�
                    mSumPrintingLineCopy = CopyAndPaste(mSumPrintingLineCopy);

                    vMessageText = string.Format("[Page : {0:D2}] {1:D3} | {2:D3}", vPageNumber, mSumWriteLine, mSumPrintingLineCopy);
                    MessageGrid(vMessageText);

                    mProgressBar1.BarFillPercent = (Convert.ToSingle(mSumWriteLine) / Convert.ToSingle(vTotalRow)) * 100F;
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

        //[Sheet2]������ [Sheet1]�� �ٿ��ֱ�
        private int CopyAndPaste(int pCopySumPrintingLine)
        {
            int vPrintHeaderColumnSTART = mXLColumnAreaSTART; //����Ǿ��� ��Ʈ�� ��, ���ۿ�
            int vPrintHeaderColumnEND = mXLColumnAreaEND;     //����Ǿ��� ��Ʈ�� ��, ���῭

            int vCopySumPrintingLine = pCopySumPrintingLine;

            try
            {
                int vCopyPrintingRowSTART = vCopySumPrintingLine;
                vCopySumPrintingLine = vCopySumPrintingLine + mMaxIncrementCopy;
                int vCopyPrintingRowEnd = vCopySumPrintingLine;
                //mPrinting.XLActiveSheet(2);
                mPrinting.XLActiveSheet("SourceTab1");
                object vRangeSource = mPrinting.XLGetRange(vPrintHeaderColumnSTART, 1, mMaxIncrementCopy, vPrintHeaderColumnEND); //[����], [Sheet2.Cell("A1:AS67")], ���� ��Ʈ���� ���� ������ ���ȣ, ���� ��Ʈ���� ���� ������ ����ȣ, ���� ��Ʈ���� ���� ������ ���ȣ, ���� ��Ʈ���� ���� ������ ����ȣ
                //mPrinting.XLActiveSheet(1);
                mPrinting.XLActiveSheet("Destination");
                object vRangeDestination = mPrinting.XLGetRange(vCopyPrintingRowSTART, 1, vCopyPrintingRowEnd, vPrintHeaderColumnEND); //[���], [Sheet1.Cell("A1:AS67")], ���� ��Ʈ���� ���� ������ ���ȣ, ���� ��Ʈ���� ���� ������ ����ȣ, ���� ��Ʈ���� ���� ������ ���ȣ, ���� ��Ʈ���� ���� ������ ����ȣ
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