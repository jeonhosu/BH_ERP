using System;

namespace FCMF0701
{
    /// <summary>
    /// XLPrint Class�� �̿��� Report�� ����
    /// </summary>
    public class XLPrinting
    {
        #region ----- Variables -----

        private InfoSummit.Win.ControlAdv.ISAppInterfaceAdv mIsAppInterFace;

        private XL.XLPrint mPrinting = null;

        private string mMessageError = string.Empty;

        private int mPageTotalNumber = 0;
        private int mPageNumber = 0;

        private string mXLOpenFileName = string.Empty;

        private int[] mIndexGridHeader1COL = new int[0] { };
        private int[] mIndexGridHeader0COL = new int[0] { };
        private int[] mIndexXLHeader1COL = new int[0] { }; //���� �ش�1�� ����� �� ��ġ ����
        private int[] mIndexXLHeader0COL = new int[0] { }; //���� �ش�0�� ����� �� ��ġ ����

        private int[] mIndexGridColumns = new int[0] { };
        private int[] mIndexXLWriteColumn = new int[0] { }; //������ ����� �� ��ġ ����

        private int mPositionPrintLineSTART = 8; //���� ��½� ���� ���� �� ��ġ ����
        private int mSumWriteLine = 0;           //������ ��µǴ� �� ���� ��
        private int mRepeatIncrement = 43;       //���� ��µǴ� ���� ���ۺ��� �� ���� ����(���� �� 8~50������ ���� 43 ���� �ݺ� �Ǵ� ����)
        
        private int mSumPrintingLineCopy = 1;    //������ ���õ� ��Ʈ�� ����Ǿ��� ���� �� ��ġ �� ���� �� ��
        private int mMaxIncrementCopy = 52;      //�ݺ� ����Ǿ��� ���� �ִ� ����

        private int mXLColumnAreaSTART = 1;      //����Ǿ��� ��Ʈ�� ��, ���ۿ�
        private int mXLColumnAreaEND = 46;       //����Ǿ��� ��Ʈ�� ��, ���῭

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

        public XLPrinting(InfoSummit.Win.ControlAdv.ISAppInterfaceAdv pIsAppInterFace)
        {
            mPrinting = new XL.XLPrint();
            mIsAppInterFace = pIsAppInterFace;
        }

        #endregion;

        #region ----- Interior Use Methods ----

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
                mIsAppInterFace.OnAppMessage(mMessageError);
                System.Windows.Forms.Application.DoEvents();
            }

            return IsOpen;
        }

        #endregion;

        #region ----- Print Header Methods ----

        private void XLHeader(string pTitle, string pHeaderCenter, string pHeaderRight)
        {
            try
            {
                mPrinting.XLActiveSheet("SourceTab1");

                mPrinting.XLSetCell(2, 2, pTitle);

                mPrinting.XLSetCell(4, 2, pHeaderCenter);

                mPrinting.XLSetCell(5, 34, pHeaderRight);
            }
            catch (System.Exception ex)
            {
                mMessageError = string.Format("{0}", ex.Message);
                mIsAppInterFace.OnAppMessage(mMessageError);
                System.Windows.Forms.Application.DoEvents();
            }
        }

        #endregion;

        #region ----- Print Footer Methods ----

        private void XLFooter(string pFooterLeft)
        {
            try
            {
                mPrinting.XLActiveSheet("SourceTab1"); //mPrinting.XLActiveSheet(2);
                mPrinting.XLSetCell(51, 2, pFooterLeft);
            }
            catch (System.Exception ex)
            {
                mMessageError = string.Format("{0}", ex.Message);
                mIsAppInterFace.OnAppMessage(mMessageError);
                System.Windows.Forms.Application.DoEvents();
            }
        }

        #endregion;

        #region ----- Define Header Column Methods ----

        private void XLDefineHeaderColumn(InfoSummit.Win.ControlAdv.ISGridAdvEx pGrid)
        {
            try
            {
                //---------------------------------------------------------------------------------
                //Header_1
                //---------------------------------------------------------------------------------
                //Grid�� [Edit] ���� [DataColumn] ���� �ִ� �� �̸��� ���� �ϸ� �ȴ�.
                string[] vGridHeaderColumnNames_1 = new string[] //Header_1
                {
                      "REMAIN_DR_AMOUNT"  //����
                    , "BEFORE_CR_AMOUNT"  //�뺯
                };

                int vIndexColumn = 0;
                mIndexGridHeader1COL = new int[vGridHeaderColumnNames_1.Length];

                foreach (string vName in vGridHeaderColumnNames_1)
                {
                    mIndexGridHeader1COL[vIndexColumn] = pGrid.GetColumnToIndex(vName);
                    vIndexColumn++;
                }

                //������ ��µ� �� ��ġ ����
                int[] vXLHeaderColumnNames_1 = new int[] //Header_1
                {
                       2  //REMAIN_DR_AMOUNT  -  ����
                    , 23  //BEFORE_CR_AMOUNT  -  �뺯
                };
                mIndexXLHeader1COL = new int[vXLHeaderColumnNames_1.Length];
                for (int vCol = 0; vCol < vXLHeaderColumnNames_1.Length; vCol++)
                {
                    mIndexXLHeader1COL[vCol] = vXLHeaderColumnNames_1[vCol];
                }

                //---------------------------------------------------------------------------------
                //Header_0
                //---------------------------------------------------------------------------------
                //Grid�� [Edit] ���� [DataColumn] ���� �ִ� �� �̸��� ���� �ϸ� �ȴ�.
                string[] vGridHeaderColumnNames_0 = new string[]
                {
                      "REMAIN_DR_AMOUNT"        //�ܾ�
                    , "THIS_DR_AMOUNT"          //���
                    , "BEFORE_DR_AMOUNT"        //�̿�
                    , "FORM_ITEM_NAME"          //��������
                    , "BEFORE_CR_AMOUNT"        //�̿�
                    , "THIS_CR_AMOUNT"          //���
                    , "REMAIN_CR_AMOUNT"        //�ܾ�
                };

                vIndexColumn = 0;
                mIndexGridHeader0COL = new int[vGridHeaderColumnNames_0.Length];

                foreach (string vName in vGridHeaderColumnNames_0)
                {
                    mIndexGridHeader0COL[vIndexColumn] = pGrid.GetColumnToIndex(vName);
                    vIndexColumn++;
                }

                //������ ��µ� �� ��ġ ����
                int[] vXLHeaderColumnNames_0 = new int[]
                {
                       2  //REMAIN_DR_AMOUNT  -  �ܾ�
                    ,  8  //THIS_DR_AMOUNT    -  ���
                    , 14  //BEFORE_DR_AMOUNT  -  �̿�
                    , 20  //FORM_ITEM_NAME    -  ��������
                    , 28  //BEFORE_CR_AMOUNT  -  �̿�
                    , 34  //THIS_CR_AMOUNT    -  ���
                    , 40  //REMAIN_CR_AMOUNT  -  �ܾ�
                };
                mIndexXLHeader0COL = new int[vXLHeaderColumnNames_0.Length];
                for (int vCol = 0; vCol < vXLHeaderColumnNames_0.Length; vCol++)
                {
                    mIndexXLHeader0COL[vCol] = vXLHeaderColumnNames_0[vCol];
                }
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
                      "REMAIN_DR_AMOUNT"        //�ܾ�
                    , "THIS_DR_AMOUNT"          //���
                    , "BEFORE_DR_AMOUNT"        //�̿�
                    , "FORM_ITEM_NAME"          //��������
                    , "BEFORE_CR_AMOUNT"        //�̿�
                    , "THIS_CR_AMOUNT"          //���
                    , "REMAIN_CR_AMOUNT"        //�ܾ�
                };

                int vIndexColumn = 0;
                mIndexGridColumns = new int[vGridDataColumns.Length];

                foreach (string vName in vGridDataColumns)
                {
                    mIndexGridColumns[vIndexColumn] = pGrid.GetColumnToIndex(vName);
                    vIndexColumn++;
                }

                //������ ��µ� �� ��ġ ����
                int[] vXLColumns = new int[]
                {
                       2  //REMAIN_DR_AMOUNT  -  �ܾ�
                    ,  8  //THIS_DR_AMOUNT    -  ���
                    , 14  //BEFORE_DR_AMOUNT  -  �̿�
                    , 20  //FORM_ITEM_NAME    -  ��������
                    , 28  //BEFORE_CR_AMOUNT  -  �̿�
                    , 34  //THIS_CR_AMOUNT    -  ���
                    , 40  //REMAIN_CR_AMOUNT  -  �ܾ�
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
                mIsAppInterFace.OnAppMessage(mMessageError);
                System.Windows.Forms.Application.DoEvents();
            }
        }

        #endregion;

        #region ----- Print HeaderColumns Methods ----

        private void XLHeaderColumns(InfoSummit.Win.ControlAdv.ISGridAdvEx pGrid, int pTerritory, int pXLWriteLineStart)
        {
            int vXLHeaderRow_1 = pXLWriteLineStart - 2; //mPositionPrintLineSTART - 2, ��µ� ������ �� ��ġ���� ���� ���� �����Ƿ� 2�� ����.
            int vXLHeaderRow_0 = pXLWriteLineStart - 1; //mPositionPrintLineSTART - 1, ��µ� ������ �� ��ġ���� ���� ���� �����Ƿ� 1�� ����.

            object vObject = null;
            int vCountColumn = 0;
            int vGetIndexGridColumn = 0;

            //---------------------------------------------------------------------------------
            //Header_1
            //---------------------------------------------------------------------------------
            try
            {
                vCountColumn = mIndexGridHeader1COL.Length;

                if (vCountColumn < 1)
                {
                    return;
                }

                //Header Columns
                for (int vCol = 0; vCol < vCountColumn; vCol++)
                {
                    vGetIndexGridColumn = mIndexGridHeader1COL[vCol];
                    switch (pTerritory)
                    {
                        case 1: //Default
                            vObject = pGrid.GridAdvExColElement[vGetIndexGridColumn].HeaderElement[1].Default;
                            mPrinting.XLSetCell(vXLHeaderRow_1, mIndexXLHeader1COL[vCol], vObject);
                            break;
                        case 2: //KR
                            vObject = pGrid.GridAdvExColElement[vGetIndexGridColumn].HeaderElement[1].TL1_KR;
                            mPrinting.XLSetCell(vXLHeaderRow_1, mIndexXLHeader1COL[vCol], vObject);
                            break;
                    }
                }
            }
            catch (System.Exception ex)
            {
                mMessageError = string.Format("{0}", ex.Message);
            }

            //---------------------------------------------------------------------------------
            //Header_0
            //---------------------------------------------------------------------------------
            try
            {
                vCountColumn = mIndexGridHeader0COL.Length;

                if (vCountColumn < 1)
                {
                    return;
                }

                //Header Columns
                for (int vCol = 0; vCol < vCountColumn; vCol++)
                {
                    vGetIndexGridColumn = mIndexGridHeader0COL[vCol];
                    switch (pTerritory)
                    {
                        case 1: //Default
                            vObject = pGrid.GridAdvExColElement[vGetIndexGridColumn].HeaderElement[0].Default;
                            mPrinting.XLSetCell(vXLHeaderRow_0, mIndexXLHeader0COL[vCol], vObject);
                            break;
                        case 2: //KR
                            vObject = pGrid.GridAdvExColElement[vGetIndexGridColumn].HeaderElement[0].TL1_KR;
                            mPrinting.XLSetCell(vXLHeaderRow_0, mIndexXLHeader0COL[vCol], vObject);
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
                            if (vCol == 0 || vCol == 1 || vCol == 2 || vCol == 4 || vCol == 5 || vCol == 6)
                            {
                                vObject = pGrid.GetCellValue(vRow, mIndexGridColumns[vCol]);
                                vObject = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vObject);
                            }
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
                mIsAppInterFace.OnAppMessage(mMessageError);
                System.Windows.Forms.Application.DoEvents();
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
                pSumWriteLine = pSumWriteLine + mRepeatIncrement;
                vPrintingRowEND = pSumWriteLine;

                XLContentWrite(mPrinting, pGrid, pTotalRow, mPositionPrintLineSTART, mIndexXLWriteColumn, vPrintingRowSTART, vPrintingRowEND);
            }
            catch (System.Exception ex)
            {
                mMessageError = string.Format("{0}", ex.Message);
                mIsAppInterFace.OnAppMessage(mMessageError);
                System.Windows.Forms.Application.DoEvents();
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
        public int XLWirte(InfoSummit.Win.ControlAdv.ISGridAdvEx pGrid, int pTerritory, string pHeaderCenter, string pPeriod, string pUserName, string pCaption)
        {
            string vMessageText = string.Empty;

            string vPrintingDate = System.DateTime.Now.ToString("yyyy-MM-dd", null);
            string vPrintingTime = System.DateTime.Now.ToString("HH:mm:ss", null);

            try
            {
                int vTotalRow = pGrid.RowCount; //Grid�� �� ���

                int vBy = mRepeatIncrement;
                mPageTotalNumber = vTotalRow / vBy;
                mPageTotalNumber = (vTotalRow % vBy) == 0 ? mPageTotalNumber : (mPageTotalNumber + 1);

                //[��µ� �� ����]
                XLDefineHeaderColumn(pGrid);
                XLDefinePrintColumn(pGrid);

                while (vTotalRow > mSumWriteLine)
                {
                    mPageNumber++;

                    //[Header]
                    string vTitle = pHeaderCenter;
                    string vHeaderCenter = string.Format("Inquiry Period : {0}(Monthly Account)", pPeriod);
                    string vHeaderRight = string.Format("Write Date : {0}", vPrintingDate);
                    switch (pTerritory)
                    {
                        case 1: //Default
                            vTitle = pHeaderCenter;
                            vHeaderCenter = string.Format("Inquiry Period : {0}(Monthly Account)", pPeriod);
                            vHeaderRight = string.Format("Write Date : ", vPrintingDate);
                            break;
                        case 2: //KR
                            vTitle = pHeaderCenter;
                            vHeaderCenter = string.Format("���س�� : {0}(����)", pPeriod);
                            vHeaderRight = string.Format("�ۼ����� : {0}", vPrintingDate);
                            break;
                    }
                    XLHeader(vTitle, vHeaderCenter, vHeaderRight);

                    //[Footer]
                    string vFooterLeft = string.Format("[{0} {1}]", vPrintingDate, vPrintingTime);
                    XLFooter(vFooterLeft);

                    //[Header Columns]
                    XLHeaderColumns(pGrid, pTerritory, mPositionPrintLineSTART);


                    //[Content_Printing]
                    mSumWriteLine = NewPage(pGrid, vTotalRow, mSumWriteLine);


                    ////[Sheet2]������ [Sheet1]�� �ٿ��ֱ�
                    mSumPrintingLineCopy = CopyAndPaste(mSumPrintingLineCopy);
                }
            }
            catch
            {
                mPrinting.XLOpenFileClose();
                mPrinting.XLClose();
            }

            return mPageNumber;
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

                string vPageNumberText = string.Format("Page {0}/{1}", mPageNumber, mPageTotalNumber);
                mPrinting.XLSetCell((mMaxIncrementCopy - 1), 20, vPageNumberText);

                mPrinting.XLActiveSheet("SourceTab1"); //mPrinting.XLActiveSheet(2);
                object vRangeSource = mPrinting.XLGetRange(vPrintHeaderColumnSTART, 1, mMaxIncrementCopy, vPrintHeaderColumnEND); //[����], [Sheet2.Cell("A1:AS67")], ���� ��Ʈ���� ���� ������ ���ȣ, ���� ��Ʈ���� ���� ������ ����ȣ, ���� ��Ʈ���� ���� ������ ���ȣ, ���� ��Ʈ���� ���� ������ ����ȣ

                mPrinting.XLActiveSheet("Destination"); //mPrinting.XLActiveSheet(1);
                object vRangeDestination = mPrinting.XLGetRange(vCopyPrintingRowSTART, 1, vCopyPrintingRowEnd, vPrintHeaderColumnEND); //[���], [Sheet1.Cell("A1:AS67")], ���� ��Ʈ���� ���� ������ ���ȣ, ���� ��Ʈ���� ���� ������ ����ȣ, ���� ��Ʈ���� ���� ������ ���ȣ, ���� ��Ʈ���� ���� ������ ����ȣ
                mPrinting.XLCopyRange(vRangeSource, vRangeDestination);
            }
            catch (System.Exception ex)
            {
                mMessageError = string.Format("{0}", ex.Message);
                mIsAppInterFace.OnAppMessage(mMessageError);
                System.Windows.Forms.Application.DoEvents();
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
                mIsAppInterFace.OnAppMessage(mMessageError);
                System.Windows.Forms.Application.DoEvents();
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
                mIsAppInterFace.OnAppMessage(mMessageError);
                System.Windows.Forms.Application.DoEvents();
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
                mIsAppInterFace.OnAppMessage(mMessageError);
                System.Windows.Forms.Application.DoEvents();
            }
        }

        #endregion;

        #endregion;
    }
}
