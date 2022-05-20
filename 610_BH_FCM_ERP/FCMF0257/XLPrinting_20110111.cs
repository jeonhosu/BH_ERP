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
        private InfoSummit.Win.ControlAdv.ISMessageAdapter mIsMessageAdapter;

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
        private string mCarryOver = string.Empty;

        private decimal mSum_Debit_Amount = 0;  //�����ݾ�
        private decimal mSum_Credit_Amount = 0; //�뺯�ݾ�
        private decimal mSum_Remain_Amount = 0; //�ܾױݾ�

        private decimal mTotal_Debit_Amount = 0;  //�����ݾ�
        private decimal mTotal_Credit_Amount = 0; //�뺯�ݾ�
        private decimal mTotal_Remain_Amount = 0; //�ܾױݾ�

        private string mStringCarryOver = string.Empty;

        private int mDeleteLine_LastMemory = 0; //�� �������� ��µ��� ���� �������� �ѱ�� ���� ������ ����� ���� ����ġ ���

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

        public XLPrinting(InfoSummit.Win.ControlAdv.ISAppInterfaceAdv pIsAppInterFace, InfoSummit.Win.ControlAdv.ISMessageAdapter pIsMessageAdapter)
        {
            mPrinting = new XL.XLPrint();

            mIsAppInterFace = pIsAppInterFace;
            mIsMessageAdapter = pIsMessageAdapter;
            mStringCarryOver = mIsMessageAdapter.ReturnText("FCM_10165");
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

        #region ----- Delete Line Methods ----

        private void DeleteLineXL(InfoSummit.Win.ControlAdv.ISGridAdvEx pGrid, int pXLine)
        {
            mPrinting.XLActiveSheet("SourceTab1");

            pXLine = pXLine + 2; //2�� ���Ѱ� �� �ٴ� ����� ����
            int vXLineDelete = mPositionPrintLineSTART;
            while(vXLineDelete < pXLine)
            {
                XLContentWrite(pGrid, 0, vXLineDelete, true);
                vXLineDelete = vXLineDelete + 2;
            }

            mPrinting.XLActiveSheet("Destination");
        }

        #endregion;

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

        #region ----- Convert decimal Methods ----

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

        #region ----- Convert decimal Methods ----

        private decimal ConvertDecimal(object pObject)
        {
            decimal vDecimal = 0m;

            try
            {
                if (pObject != null)
                {
                    bool IsConvert = pObject is decimal;
                    if (IsConvert == true)
                    {
                        vDecimal = (decimal)pObject;
                    }
                }
            }
            catch (System.Exception ex)
            {
                mMessageError = string.Format("{0}", ex.Message);
            }

            return vDecimal;
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

                string vMenagement = string.Empty; //�����׸�[�̿��ݾ�]

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
                    vMenagement = ConvertString(vObject);
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
                    decimal vDebit_Amount = ConvertDecimal(vObject);
                    string sDebit_Amount = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vDebit_Amount);
                    mPrinting.XLSetCell(vXLPoint05.X, vXLPoint05.Y, sDebit_Amount);
                    if (vMenagement != mStringCarryOver)
                    {
                        mSum_Debit_Amount = mSum_Debit_Amount + vDebit_Amount;
                    }
                    mTotal_Debit_Amount = mTotal_Debit_Amount + vDebit_Amount;
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
                    decimal vCredit_Amount = ConvertDecimal(vObject);
                    string sCredit_Amount = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vCredit_Amount);
                    mPrinting.XLSetCell(vXLPoint06.X, vXLPoint06.Y, sCredit_Amount);
                    if (vMenagement != mStringCarryOver)
                    {
                        mSum_Credit_Amount = mSum_Credit_Amount + vCredit_Amount;
                    }
                    mTotal_Credit_Amount = mTotal_Credit_Amount + vCredit_Amount;
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
                    decimal vRemain_Amount = ConvertDecimal(vObject);
                    string sRemain_Amount = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vRemain_Amount);
                    mPrinting.XLSetCell(vXLPoint07.X, vXLPoint07.Y, sRemain_Amount);
                    if (vMenagement != mStringCarryOver)
                    {
                        mSum_Remain_Amount = mSum_Remain_Amount + vRemain_Amount;
                    }
                    mTotal_Remain_Amount = mTotal_Remain_Amount + vRemain_Amount;
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

        #region ----- Sum Write Methods ----

        private void XLSumWirte(int pXLine)
        {
            try
            {
                int vXLColumn01 = 40;    //�����ݾ�
                int vXLColumn02 = 49;    //�뺯�ݾ�
                int vXLColumn03 = 58;    //�ܾױݾ�

                //����
                mPrinting.XLSetCell(pXLine, 8, "����");

                //�����ݾ�
                string vSum_Debit_Amount = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", mSum_Debit_Amount);
                mPrinting.XLSetCell(pXLine, vXLColumn01, vSum_Debit_Amount);

                //�뺯�ݾ�
                string vSum_Credit_Amount = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", mSum_Credit_Amount);
                mPrinting.XLSetCell(pXLine, vXLColumn02, vSum_Credit_Amount);

                //�ܾױݾ�
                string vSum_Remain_Amount = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", mSum_Remain_Amount);
                mPrinting.XLSetCell(pXLine, vXLColumn03, vSum_Remain_Amount);

                pXLine = pXLine + 2;

                //����
                mPrinting.XLSetCell(pXLine, 8, "����");

                //�����ݾ�
                string vTotal_Debit_Amount = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", mTotal_Debit_Amount);
                mPrinting.XLSetCell(pXLine, vXLColumn01, vTotal_Debit_Amount);

                //�뺯�ݾ�
                string vTotal_Credit_Amount = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", mTotal_Credit_Amount);
                mPrinting.XLSetCell(pXLine, vXLColumn02, vTotal_Credit_Amount);

                //�ܾױݾ�
                string vTotal_Remain_Amount = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", mTotal_Remain_Amount);
                mPrinting.XLSetCell(pXLine, vXLColumn03, vTotal_Remain_Amount);

                mSum_Debit_Amount = 0;
                mSum_Credit_Amount = 0;
                mSum_Remain_Amount = 0;

                mTotal_Debit_Amount = 0;
                mTotal_Credit_Amount = 0;
                mTotal_Remain_Amount = 0;

                mDeleteLine_LastMemory = pXLine;
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

            object vObject1 = null;
            object vObject2 = null;
            object vObject3 = null;

            string vAccountDate = string.Empty;
            string vAccountCode = string.Empty;
            string vMenagement = string.Empty;

            int vIndexDataColumn01 = pGrid.GetColumnToIndex("ACCOUNT_CODE");     //�����ڵ�
            int vIndexDataColumn02 = pGrid.GetColumnToIndex("GL_DATE");          //ȸ������
            int vIndexDataColumn03 = pGrid.GetColumnToIndex("MANAGEMENT_DESC");  //�����׸�

            System.Drawing.Point vGridPoint01 = new System.Drawing.Point(pIndexRow, vIndexDataColumn01);  //�����ڵ�
            System.Drawing.Point vGridPoint02 = new System.Drawing.Point(pIndexRow, vIndexDataColumn02);  //ȸ������
            System.Drawing.Point vGridPoint03 = new System.Drawing.Point(pIndexRow, vIndexDataColumn03);  //�����׸�

            vObject1 = pGrid.GetCellValue(vGridPoint01.X, vGridPoint01.Y);  //�����ڵ�
            vObject2 = pGrid.GetCellValue(vGridPoint02.X, vGridPoint02.Y);  //ȸ������
            vObject3 = pGrid.GetCellValue(vGridPoint03.X, vGridPoint03.Y);  //�����׸�

            //�����ڵ�
            vAccountCode = ConvertString(vObject1);

            //ȸ������
            vObject2 = ConvertDate(vObject2);
            vAccountDate = ConvertString(vObject2);
            vAccountDate = vAccountDate.Substring(0, 7);

            //�����׸�
            vMenagement = ConvertString(vObject3);

            if (mAccountCode == vAccountCode &&  mCarryOver == mStringCarryOver)
            {
                mAccountDate = vAccountDate;
                mCarryOver = vMenagement;
                return false;
            }

            bool isNull1 = string.IsNullOrEmpty(vAccountDate);
            bool isNull2 = string.IsNullOrEmpty(vAccountCode);
            if (isNull1 != true && isNull2 != true)
            {
                if (mAccountCode != vAccountCode)
                {
                    mAccountCode = vAccountCode;
                    vIsSkip = true;
                }
                else if (mAccountDate != vAccountDate)
                {
                    mAccountDate = vAccountDate;
                    vIsSkip = true;
                }
            }

            mCarryOver = vMenagement;

            return vIsSkip;
        }

        #endregion;

        #region ----- New Page iF Methods ----

        private int NewPage(InfoSummit.Win.ControlAdv.ISGridAdvEx pGrid, int pSumWriteLine, string pPeriod, string pFooterLeft)
        {
            int vXLine = mPositionPrintLineSTART;
            int vPrintingRowSTART = 0;
            int vPrintingRowEND = 0;
            int vXLineLast = 0;

            bool vIsSkip = false;
            bool vIsLast = false;

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
                            pSumWriteLine = vRow;

                            

                            //int vXLineDelete = vXLine;
                            //for (int vRow2 = pSumWriteLine; vRow2 < vPrintingRowEND; vRow2++)
                            //{
                            //    XLContentWrite(pGrid, vRow2, vXLineDelete, true);
                            //    vXLineDelete = vXLineDelete + 2;
                            //}



                            //mDeleteLine_LastMemory = vXLine;

                            XLSumWirte(vXLine); //�հ�, ����

                            break;
                        }

                        XLContentWrite(pGrid, vRow, vXLine, false);
                    }
                    else
                    {
                        //������ �������� ������ �� ��ġ ���
                        if (vIsLast == false)
                        {
                            vXLineLast = vXLine;
                            vIsLast = true;
                        }

                        XLContentWrite(pGrid, vRow, vXLine, true); //������ �������� ����� ���� ������, �� ������ ��µǰ� true �� �ѱ�
                    }

                    vXLine = vXLine + 2;

                    if (vIsLast != true)
                    {
                        //-----------------------------------------------------------------
                        pGrid.CurrentCellMoveTo(vRow, 0);
                        pGrid.Focus();
                        pGrid.CurrentCellActivate(vRow, 0);

                        mMessageError = string.Format("{0:D4}/{1:D4}", vRow, mTotalRowGrid);
                        mIsAppInterFace.OnAppMessage(mMessageError);
                        System.Windows.Forms.Application.DoEvents();
                        //-----------------------------------------------------------------
                    }
                }

                //������ �������� �հ�, ���� Write
                if (vIsLast == true)
                {
                    XLSumWirte(vXLineLast); //�հ�, ����
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

                //�ʱ�ġ �� ����
                //ù ������ Skip�� �񱳵� �� ����
                if (mTotalRowGrid > 0)
                {
                    int vRowIndex = 0;

                    object vObject1 = null;
                    object vObject2 = null;
                    object vObject3 = null;

                    int vIndexDataColumn01 = pGrid.GetColumnToIndex("ACCOUNT_CODE");       //�����ڵ�
                    int vIndexDataColumn02 = pGrid.GetColumnToIndex("GL_DATE");            //ȸ������
                    int vIndexDataColumn03 = pGrid.GetColumnToIndex("MANAGEMENT_DESC");    //�����׸�

                    vObject1 = pGrid.GetCellValue(vRowIndex, vIndexDataColumn01);          //�����ڵ�
                    vObject2 = pGrid.GetCellValue(vRowIndex, vIndexDataColumn02);          //ȸ������
                    vObject3 = pGrid.GetCellValue(vRowIndex, vIndexDataColumn03);          //�����׸�

                    mAccountCode = ConvertString(vObject1);                //�����ڵ�

                    mAccountDate = ConvertString(ConvertDate(vObject2));   //ȸ������
                    mAccountDate = mAccountDate.Substring(0, 7);

                    mCarryOver = ConvertString(vObject3);                  //�����׸�
                    
                }

                while (mTotalRowGrid > mSumWriteLine)
                {
                    vPageNumber++;

                    string vFooterLeft = string.Format("{0} {1}", vPrintingDate, vPrintingTime);
                    //[Content_Printing]
                    mSumWriteLine = NewPage(pGrid, mSumWriteLine, pPeriod, vFooterLeft);


                    ////[Sheet2]������ [Sheet1]�� �ٿ��ֱ�
                    mSumPrintingLineCopy = CopyAndPaste(mSumPrintingLineCopy);


                    //���� ������ ����� ����, ���� ��µ� �� �����
                    DeleteLineXL(pGrid, mDeleteLine_LastMemory);
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