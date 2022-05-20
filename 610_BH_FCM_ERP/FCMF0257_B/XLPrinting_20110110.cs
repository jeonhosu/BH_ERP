using System;

namespace FCMF0257
{
    /// <summary>
    /// XLPrint Class�� �̿��� Report�� ���� 
    /// </summary>
    public class XLPrinting
    {
        #region ----- Variables -----

        private XL.XLPrint mPrinting = null;

        private InfoSummit.Win.ControlAdv.ISAppInterfaceAdv mIsAppInterFace;

        private string mMessageError = string.Empty;

        private string mXLOpenFileName = string.Empty;

        private int mTotalRowGrid = 0; //Grid Total Row

        private int[] mIndexGridColumns = new int[0] { };
        private int[] mIndexXLWriteColumn = new int[0] { }; //������ ����� �� ��ġ ����

        private int mPositionPrintLineSTART = 6; //���� ��½� ���� ���� �� ��ġ ����
        private int mSumWriteLine = 0; //������ ��µǴ� �� ���� ��
        private int mMaxIncrementRead = 30; //�ݺ� �о� ���� ���

        private int mSumPrintingLineCopy = 1; //������ ���õ� ��Ʈ�� ����Ǿ��� ���� �� ��ġ �� ���� �� ��
        private int mMaxIncrementCopy = 37; //�ݺ� ����Ǿ��� ���� �ִ� ����

        private int mXLColumnAreaSTART = 1; //����Ǿ��� ��Ʈ�� ��, ���ۿ�
        private int mXLColumnAreaEND = 66;  //����Ǿ��� ��Ʈ�� ��, ���῭

        private string mAccountDate = string.Empty;
        private string mAccountCode = string.Empty;

        private decimal mSum_Debit_Amount = 0;  //�����ݾ�
        private decimal mSum_Credit_Amount = 0; //�뺯�ݾ�
        private decimal mSum_Remain_Amount = 0; //�ܾױݾ�

        private decimal mTotal_Debit_Amount = 0;  //�����ݾ�
        private decimal mTotal_Credit_Amount = 0; //�뺯�ݾ�
        private decimal mTotal_Remain_Amount = 0; //�ܾױݾ�

        private bool mIsCarryOver = false; //�̿��ݾ� ����?
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

        #region ----- Print Footer Methods ----

        private void XLFooter(string pFooterLeft)
        {
            try
            {
                mPrinting.XLActiveSheet("SourceTab1"); //mPrinting.XLActiveSheet(2);
                mPrinting.XLSetCell(36, 2, pFooterLeft);
            }
            catch (System.Exception ex)
            {
                mMessageError = string.Format("{0}", ex.Message);
            }
        }

        #endregion;

        #region ----- Convert Date Methods ----

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

        #region ----- Convert String Methods ----

        private string ConvertString(object pObject)
        {
            string vString = string.Empty;

            try
            {
                if (pObject != null)
                {
                    bool IsConvert = pObject is string;
                    if (IsConvert == true)
                    {
                        vString = pObject as string;
                    }
                }
            }
            catch (System.Exception ex)
            {
                mMessageError = string.Format("{0}", ex.Message);
            }

            return vString;
        }

        #endregion;

        #region ----- Print Header Methods ----

        private void XLHeader(InfoSummit.Win.ControlAdv.ISGridAdvEx pGrid, int pIndexRow, string pDateTime)
        {
            try
            {
                mPrinting.XLActiveSheet("SourceTab1");

                int vIndexDataColumn01 = pGrid.GetColumnToIndex("ACCOUNT_DESC");    //������
                int vIndexDataColumn02 = pGrid.GetColumnToIndex("ACCOUNT_CODE");    //�����ڵ�

                System.Drawing.Point vGridPoint01 = new System.Drawing.Point(pIndexRow, vIndexDataColumn01);  //������
                System.Drawing.Point vGridPoint02 = new System.Drawing.Point(pIndexRow, vIndexDataColumn02);  //�����ڵ�

                System.Drawing.Point vXLPoint01 = new System.Drawing.Point(1, 2);    //������[�����ڵ�]
                System.Drawing.Point vXLPoint02 = new System.Drawing.Point(2, 42);   //�Ⱓ

                //������[�����ڵ�]
                object vObject1 = pGrid.GetCellValue(vGridPoint01.X, vGridPoint01.Y);
                object vObject2 = pGrid.GetCellValue(vGridPoint02.X, vGridPoint02.Y);
                if (vObject1 != null)
                {
                    object vObject3 = string.Format("{0}({1})", vObject1, vObject2);
                    mPrinting.XLSetCell(vXLPoint01.X, vXLPoint01.Y, vObject3);
                }
                else
                {
                    vObject1 = null;
                    mPrinting.XLSetCell(vXLPoint01.X, vXLPoint01.Y, vObject1);
                }

                //[�Ⱓ]
                mPrinting.XLSetCell(vXLPoint02.X, vXLPoint02.Y, pDateTime);
            }
            catch (System.Exception ex)
            {
                mMessageError = string.Format("{0}", ex.Message);
                mIsAppInterFace.OnAppMessage(mMessageError);
                System.Windows.Forms.Application.DoEvents();
            }
        }

        #endregion;

        #region ----- Print Content Write Methods ----

        private void XLContentWrite(InfoSummit.Win.ControlAdv.ISGridAdvEx pGrid, int pIndexRow, int pXLine, bool vNullValue)
        {
            object vObject = null;

            try
            {
                mPrinting.XLActiveSheet("SourceTab1");

                int vIndexDataColumn01 = pGrid.GetColumnToIndex("GL_DATE");          //ȸ������
                int vIndexDataColumn02 = pGrid.GetColumnToIndex("MANAGEMENT_DESC");  //�����׸�
                int vIndexDataColumn03 = pGrid.GetColumnToIndex("REMARK");           //����
                int vIndexDataColumn04 = pGrid.GetColumnToIndex("GL_NUM");           //��ǥ��ȣ
                int vIndexDataColumn05 = pGrid.GetColumnToIndex("DR_AMOUNT");        //�����ݾ�
                int vIndexDataColumn06 = pGrid.GetColumnToIndex("CR_AMOUNT");        //�뺯�ݾ�
                int vIndexDataColumn07 = pGrid.GetColumnToIndex("REMAIN_AMOUNT");    //�ܾױݾ�

                System.Drawing.Point vGridPoint01 = new System.Drawing.Point(pIndexRow, vIndexDataColumn01);  //ȸ������
                System.Drawing.Point vGridPoint02 = new System.Drawing.Point(pIndexRow, vIndexDataColumn02);  //�����׸�
                System.Drawing.Point vGridPoint03 = new System.Drawing.Point(pIndexRow, vIndexDataColumn03);  //����
                System.Drawing.Point vGridPoint04 = new System.Drawing.Point(pIndexRow, vIndexDataColumn04);  //��ǥ��ȣ
                System.Drawing.Point vGridPoint05 = new System.Drawing.Point(pIndexRow, vIndexDataColumn05);  //�����ݾ�
                System.Drawing.Point vGridPoint06 = new System.Drawing.Point(pIndexRow, vIndexDataColumn06);  //�뺯�ݾ�
                System.Drawing.Point vGridPoint07 = new System.Drawing.Point(pIndexRow, vIndexDataColumn07);  //�ܾױݾ�

                System.Drawing.Point vXLPoint01 = new System.Drawing.Point(pXLine, 2);         //ȸ������
                System.Drawing.Point vXLPoint02 = new System.Drawing.Point(pXLine, 8);         //�����׸�
                System.Drawing.Point vXLPoint03 = new System.Drawing.Point((pXLine + 1), 8);   //����
                System.Drawing.Point vXLPoint04 = new System.Drawing.Point(pXLine, 31);        //��ǥ��ȣ
                System.Drawing.Point vXLPoint05 = new System.Drawing.Point(pXLine, 40);        //�����ݾ�
                System.Drawing.Point vXLPoint06 = new System.Drawing.Point(pXLine, 49);        //�뺯�ݾ�
                System.Drawing.Point vXLPoint07 = new System.Drawing.Point(pXLine, 58);        //�ܾױݾ�

                //ȸ������
                vObject = pGrid.GetCellValue(vGridPoint01.X, vGridPoint01.Y);
                if (vObject != null && vNullValue == false)
                {
                    vObject = ConvertDate(vObject);
                    mPrinting.XLSetCell(vXLPoint01.X, vXLPoint01.Y, vObject);
                }
                else
                {
                    vObject = null;
                    mPrinting.XLSetCell(vXLPoint01.X, vXLPoint01.Y, vObject);
                }

                //�����׸�
                vObject = pGrid.GetCellValue(vGridPoint02.X, vGridPoint02.Y);
                if (vObject != null && vNullValue == false)
                {
                    mPrinting.XLSetCell(vXLPoint02.X, vXLPoint02.Y, vObject);
                }
                else
                {
                    vObject = null;
                    mPrinting.XLSetCell(vXLPoint02.X, vXLPoint02.Y, vObject);
                }

                //����
                vObject = pGrid.GetCellValue(vGridPoint03.X, vGridPoint03.Y);
                if (vObject != null && vNullValue == false)
                {
                    mPrinting.XLSetCell(vXLPoint03.X, vXLPoint03.Y, vObject);
                }
                else
                {
                    vObject = null;
                    mPrinting.XLSetCell(vXLPoint03.X, vXLPoint03.Y, vObject);
                }

                //��ǥ��ȣ
                vObject = pGrid.GetCellValue(vGridPoint04.X, vGridPoint04.Y);
                if (vObject != null && vNullValue == false)
                {
                    mPrinting.XLSetCell(vXLPoint04.X, vXLPoint04.Y, vObject);
                }
                else
                {
                    vObject = null;
                    mPrinting.XLSetCell(vXLPoint04.X, vXLPoint04.Y, vObject);
                }

                //�����ݾ�
                vObject = pGrid.GetCellValue(vGridPoint05.X, vGridPoint05.Y);
                if (vObject != null && vNullValue == false)
                {
                    mPrinting.XLSetCell(vXLPoint05.X, vXLPoint05.Y, vObject);
                }
                else
                {
                    vObject = null;
                    mPrinting.XLSetCell(vXLPoint05.X, vXLPoint05.Y, vObject);
                }

                //�뺯�ݾ�
                vObject = pGrid.GetCellValue(vGridPoint06.X, vGridPoint06.Y);
                if (vObject != null && vNullValue == false)
                {
                    mPrinting.XLSetCell(vXLPoint06.X, vXLPoint06.Y, vObject);
                }
                else
                {
                    vObject = null;
                    mPrinting.XLSetCell(vXLPoint06.X, vXLPoint06.Y, vObject);
                }

                //�ܾױݾ�
                vObject = pGrid.GetCellValue(vGridPoint07.X, vGridPoint07.Y);
                if (vObject != null && vNullValue == false)
                {
                    mPrinting.XLSetCell(vXLPoint07.X, vXLPoint07.Y, vObject);
                }
                else
                {
                    vObject = null;
                    mPrinting.XLSetCell(vXLPoint07.X, vXLPoint07.Y, vObject);
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

        #region ----- Page Skip iF Methods ----

        private bool PageSkip(InfoSummit.Win.ControlAdv.ISGridAdvEx pGrid, int pIndexRow)
        {
            bool vIsSkip = false;
            mIsCarryOver = false;

            object vObject1 = null;
            object vObject2 = null;
            object vObject3 = null;

            string vAccountDate = string.Empty;
            string vAccountCode = string.Empty;
            string vMenagement = string.Empty;

            int vIndexDataColumn01 = pGrid.GetColumnToIndex("GL_DATE");          //ȸ������
            int vIndexDataColumn02 = pGrid.GetColumnToIndex("ACCOUNT_CODE");     //�����ڵ�
            int vIndexDataColumn03 = pGrid.GetColumnToIndex("MANAGEMENT_DESC");  //�����׸�

            System.Drawing.Point vGridPoint01 = new System.Drawing.Point(pIndexRow, vIndexDataColumn01);  //ȸ������
            System.Drawing.Point vGridPoint02 = new System.Drawing.Point(pIndexRow, vIndexDataColumn02);  //�����ڵ�
            System.Drawing.Point vGridPoint03 = new System.Drawing.Point(pIndexRow, vIndexDataColumn03);  //�����׸�

            vObject1 = pGrid.GetCellValue(vGridPoint01.X, vGridPoint01.Y);  //ȸ������
            vObject2 = pGrid.GetCellValue(vGridPoint02.X, vGridPoint02.Y);  //�����ڵ�
            vObject3 = pGrid.GetCellValue(vGridPoint03.X, vGridPoint03.Y);  //�����׸�

            if (vObject3 != null)
            {
                vMenagement = ConvertString(vObject3);
                if (vMenagement == "�̿��ݾ�")
                {
                    vObject3 = pGrid.GetCellValue((vGridPoint03.X + 1), vGridPoint03.Y);  //�����׸�
                    if (vObject3 != null)
                    {
                        vMenagement = ConvertString(vObject3);
                        if (vMenagement == "�̿��ݾ�")
                        {
                            mIsCarryOver = true;
                            vIsSkip = true;
                            return vIsSkip;
                        }
                        else
                        {
                            mIsCarryOver = false;
                            vIsSkip = false;
                            return vIsSkip;
                        }
                    }
                }
            }
            else
            {
                return vIsSkip;
            }

            if (vObject1 != null)
            {
                vObject1 = ConvertDate(vObject1);
                vAccountDate = ConvertString(vObject1);
                vAccountDate = vAccountDate.Substring(0, 7);
            }

            if (vObject2 != null)
            {
                vAccountCode = ConvertString(vObject2);
            }

            bool isNull1 = string.IsNullOrEmpty(vAccountDate);
            bool isNull2 = string.IsNullOrEmpty(vAccountCode);
            if (isNull1 != true && isNull2 != true)
            {
                if (mAccountDate != vAccountDate)
                {
                    mAccountDate = vAccountDate;
                    vIsSkip = true;
                }
                else if (mAccountCode != vAccountCode)
                {
                    mAccountCode = vAccountCode;
                    vIsSkip = true;
                }
            }

            return vIsSkip;
        }

        #endregion;

        #region ----- New Page iF Methods ----

        private int NewPage(InfoSummit.Win.ControlAdv.ISGridAdvEx pGrid, int pSumWriteLine, string pPeriod, string pFooterLeft)
        {
            int vXLine = mPositionPrintLineSTART;
            int vPrintingRowSTART = 0;
            int vPrintingRowEND = 0;
            bool vIsSkip = false;

            try
            {
                vPrintingRowSTART = pSumWriteLine;
                pSumWriteLine = pSumWriteLine + (mMaxIncrementRead / 2);
                vPrintingRowEND = pSumWriteLine;

                //[Header]
                XLHeader(pGrid, vPrintingRowSTART, pPeriod);

                //[Footer]
                XLFooter(pFooterLeft);

                for (int vRow = vPrintingRowSTART; vRow < vPrintingRowEND; vRow++)
                {
                    if (vRow < mTotalRowGrid)
                    {
                        vIsSkip = PageSkip(pGrid, vRow);
                        if (vIsSkip == true)
                        {
                            string tmpString = string.Format("{0} - {1}", mAccountCode, mAccountDate);
                            XLFooter(tmpString);
                            if (mIsCarryOver == true)
                            {
                                XLContentWrite(pGrid, vRow, vXLine, false);
                                mIsCarryOver = false;
                                pSumWriteLine = vRow + 1;
                            }
                            else
                            {
                                pSumWriteLine = vRow;
                            }
                            break;
                        }

                        XLContentWrite(pGrid, vRow, vXLine, false);
                    }
                    else
                    {
                        XLContentWrite(pGrid, vRow, vXLine, true); //������ �������� �࿡ ����� ���� ������, �� ������ ��µǰ� true �� �ѱ�
                    }

                    vXLine = vXLine + 2;
                }
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
        public int XLWirte(InfoSummit.Win.ControlAdv.ISGridAdvEx pGrid, int pTerritory, string pPeriod, string pUserName, string pCaption)
        {
            string vMessageText = string.Empty;

            string vPrintingDate = System.DateTime.Now.ToString("yyyy-MM-dd", null);
            string vPrintingTime = System.DateTime.Now.ToString("HH:mm:ss", null);

            int vPageNumber = 0;

            try
            {
                mTotalRowGrid = pGrid.RowCount; //Grid�� �� ���

                if (mTotalRowGrid > 0)
                {
                    int vRowIndex = 0; //�����׸�[�̿��ݾ�] Skip�� RowIndex��
                    object vObject1 = null;
                    object vObject2 = null;
                    object vObject3 = null;
                    string vMenagement = string.Empty;
                    int vIndexDataColumn01 = pGrid.GetColumnToIndex("ACCOUNT_CODE");       //�����ڵ�
                    int vIndexDataColumn02 = pGrid.GetColumnToIndex("GL_DATE");            //ȸ������
                    int vIndexDataColumn03 = pGrid.GetColumnToIndex("MANAGEMENT_DESC");    //�����׸�

                    vObject1 = pGrid.GetCellValue(vRowIndex, vIndexDataColumn01);   //�����ڵ�
                    mAccountCode = ConvertString(vObject1);

                    //���� ���� '�̿��ݾ�' �̸�, ���� ���� ���� �а� �Ϸ��� vRowIndex �� 1����
                    vObject3 = pGrid.GetCellValue(vRowIndex, vIndexDataColumn03);    //�����׸�
                    vMenagement = ConvertString(vObject3);
                    if (vMenagement == "�̿��ݾ�")
                    {
                        vRowIndex++;
                    }

                    //������ vRowIndex ���� �� '�̿��ݾ�' �̸�, ���� ���� ���� �а� �Ϸ��� vRowIndex �� 1 ����
                    //���� ������ Skip�� ����
                    vObject3 = pGrid.GetCellValue(vRowIndex, vIndexDataColumn03);    //�����׸�
                    vMenagement = ConvertString(vObject3);
                    if (vMenagement == "�̿��ݾ�")
                    {
                        vRowIndex--;
                    }

                    vObject2 = pGrid.GetCellValue(vRowIndex, vIndexDataColumn02);   //ȸ������

                    mAccountDate = ConvertString(ConvertDate(vObject2));
                    mAccountDate = mAccountDate.Substring(0, 7);
                    
                }

                while (mTotalRowGrid > mSumWriteLine)
                {
                    vPageNumber++;

                    string vFooterLeft = string.Format("{0} {1}", vPrintingDate, vPrintingTime);
                    //[Content_Printing]
                    mSumWriteLine = NewPage(pGrid, mSumWriteLine, pPeriod, vFooterLeft);


                    ////[Sheet2]������ [Sheet1]�� �ٿ��ֱ�
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

                mPrinting.XLActiveSheet("SourceTab1"); //mPrinting.XLActiveSheet(2);
                object vRangeSource = mPrinting.XLGetRange(vPrintHeaderColumnSTART, 1, mMaxIncrementCopy, vPrintHeaderColumnEND); //[����], [Sheet2.Cell("A1:AS67")], ���� ��Ʈ���� ���� ������ ���ȣ, ���� ��Ʈ���� ���� ������ ����ȣ, ���� ��Ʈ���� ���� ������ ���ȣ, ���� ��Ʈ���� ���� ������ ����ȣ

                mPrinting.XLActiveSheet("Destination"); //mPrinting.XLActiveSheet(1);
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