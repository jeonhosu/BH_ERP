using System;

namespace HRMF0538
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

        private string mXLOpenFileName = string.Empty;

        private int mPrintingLineSTART = 12;  //Line

        private int mCopyLineSUM = 1;        //������ ���õ� ��Ʈ�� ����Ǿ��� ���� �� ��ġ, ���� �� ����
        private int mIncrementCopyMAX = 49;  //����Ǿ��� ���� ����

        private int mCopyColumnSTART = 1; //����Ǿ�  �� �� ���� ��
        private int mCopyColumnEND = 69;  //������ ���õ� ��Ʈ�� ����Ǿ��� �� �� ��ġ

        //Header Write Infomation
        private string mCorporationName = string.Empty;
        private string mUserName = string.Empty;
        private string mYYYYMM_From = string.Empty;
        private string mYYYYMM_To = string.Empty;
        private string mWageTypeName = string.Empty;
        private string mTemp_DepartmentName = string.Empty;
        private string mPAY_YYYYMM = string.Empty;
        private string mPringingDateTime = string.Empty;

        private string mMessageValue1 = string.Empty;  //�μ��հ�
        private string mMessageValue2 = string.Empty; //���հ�

        private int[] mXLColumnHeader = null;

        //Copy�Ҷ� �����ؾ��� ���� �� ��ġ ���
        private int[] mRowMerge = new int[12] { -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 }; //�� �������� �� ��ġ�Ⱑ �Ǿ�� �� �� ����
        private int mCountRow = 0; //�����ؾ��� ���� �� ��ġ Count
        private int mMegerColumnStart = 0; //�����ؾ��� ���� ���� �� ��
        private int mMegerColumnEnd = 0;   //�����ؾ��� ���� ���� �� ��

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

        #region ----- Initialize ----

        #region ----- Array Set 1 ----

        private void SetArray1()
        {
            mXLColumnHeader = new int[8];

            mXLColumnHeader[01] = 2;  //Title
            mXLColumnHeader[02] = 8;  //�����
            mXLColumnHeader[03] = 8;  //�޿�����
            mXLColumnHeader[04] = 26; //�μ�
            mXLColumnHeader[05] = 61; //������
            mXLColumnHeader[06] = 61; //�������
            mXLColumnHeader[07] = 64; //��ü
        }

        #endregion;

        #region ----- Array Set 2 ----

        private void SetArray2(InfoSummit.Win.ControlAdv.ISGridAdvEx pGrid, out int[] pGridColumn, out int[] pXLColumn)
        {
            pGridColumn = new int[54];
            pXLColumn = new int[52];

            //�����ڵ� : �����׸�[ALLOWANCE]
            //�����ڵ� : �����׸�[DEDUCTION]

            pGridColumn[01] = pGrid.GetColumnToIndex("DEPT_NAME");           //�μ�
            pGridColumn[02] = pGrid.GetColumnToIndex("PERSON_NUM");          //���
            pGridColumn[03] = pGrid.GetColumnToIndex("PAY_TYPE_NAME");       //�޿�����[�޿���]
            pGridColumn[04] = pGrid.GetColumnToIndex("A01");                 //�⺻��
            pGridColumn[05] = pGrid.GetColumnToIndex("A26");                 //���޼���
            pGridColumn[06] = pGrid.GetColumnToIndex("A14");                 //Ư�ټ���
            pGridColumn[07] = pGrid.GetColumnToIndex("A35");                 //������Ư�ټ���
            pGridColumn[08] = pGrid.GetColumnToIndex("A20");                 //�˻����
            pGridColumn[09] = pGrid.GetColumnToIndex("A24");                 //�ڱⰳ�߼���
            pGridColumn[10] = pGrid.GetColumnToIndex("A25");                 //����������
            pGridColumn[11] = pGrid.GetColumnToIndex("A17");                 //���°���
            pGridColumn[12] = pGrid.GetColumnToIndex("D03");                 //���ο���
            pGridColumn[13] = pGrid.GetColumnToIndex("D04");                 //��뺸��
            pGridColumn[14] = pGrid.GetColumnToIndex("D13");                 //�������
            pGridColumn[15] = pGrid.GetColumnToIndex("D15");                 //����ҵ漼
            pGridColumn[16] = pGrid.GetColumnToIndex("D14");                 //��Ÿ����
            pGridColumn[17] = pGrid.GetColumnToIndex("TOT_SUPPLY_AMOUNT");   //�����Ѿ�
            pGridColumn[18] = pGrid.GetColumnToIndex("POST_NAME");           //����
            pGridColumn[19] = pGrid.GetColumnToIndex("NAME");                //����
            pGridColumn[20] = pGrid.GetColumnToIndex("BAISC_DAILY_AMOUNT");  //�ϱ�
            pGridColumn[21] = pGrid.GetColumnToIndex("A11");                 //�ð��ܼ���
            pGridColumn[22] = pGrid.GetColumnToIndex("A12");                 //�������
            pGridColumn[23] = pGrid.GetColumnToIndex("A34");                 //������祱
            pGridColumn[24] = pGrid.GetColumnToIndex("A02");                 //��å����
            pGridColumn[25] = pGrid.GetColumnToIndex("A06");                 //�ڰݼ���
            pGridColumn[26] = pGrid.GetColumnToIndex("A19");                 //��ź�
            pGridColumn[27] = pGrid.GetColumnToIndex("A10");                 //�޻󿩼ұ޺�
            pGridColumn[28] = pGrid.GetColumnToIndex("A07");                 //��Ÿ����
            pGridColumn[29] = pGrid.GetColumnToIndex("D05");                 //�ǰ�����
            pGridColumn[30] = pGrid.GetColumnToIndex("D01");                 //�ҵ漼
            pGridColumn[31] = pGrid.GetColumnToIndex("D11");                 //�۾�������
            pGridColumn[32] = pGrid.GetColumnToIndex("D16");                 //�����ֹμ�
            pGridColumn[33] = pGrid.GetColumnToIndex("");                    //
            pGridColumn[34] = pGrid.GetColumnToIndex("TOT_DED_AMOUNT");      //�����Ѿ�
            pGridColumn[35] = pGrid.GetColumnToIndex("JOIN_DATE");           //�Ի�����
            pGridColumn[36] = pGrid.GetColumnToIndex("RETIRE_DATE");         //�������
            pGridColumn[37] = pGrid.GetColumnToIndex("GENERAL_HOURLY_PAY_AMOUNT");   //���ñ�
            pGridColumn[38] = pGrid.GetColumnToIndex("A09");                 //�󿩱�
            pGridColumn[39] = pGrid.GetColumnToIndex("A13");                 //�߰�����
            pGridColumn[40] = pGrid.GetColumnToIndex("A03");                 //�������
            pGridColumn[41] = pGrid.GetColumnToIndex("A31");                 //��������
            pGridColumn[42] = pGrid.GetColumnToIndex("A22");                 //�����������
            pGridColumn[43] = pGrid.GetColumnToIndex("A04");                 //����Ȱ������
            pGridColumn[44] = pGrid.GetColumnToIndex("A21");                 //���ܱٷμ���
            pGridColumn[45] = pGrid.GetColumnToIndex("A32");                 //���Ƽ���
            pGridColumn[46] = pGrid.GetColumnToIndex("D06");                 //�����
            pGridColumn[47] = pGrid.GetColumnToIndex("D02");                 //�ֹμ�
            pGridColumn[48] = pGrid.GetColumnToIndex("D21");                 //���νſ뺸��
            pGridColumn[49] = pGrid.GetColumnToIndex("D27");                 //�����Ư��
            pGridColumn[50] = pGrid.GetColumnToIndex("D07");                 //�ǰ���������
            pGridColumn[51] = pGrid.GetColumnToIndex("REAL_AMOUNT");         //�����޾�
            /////����ҵ漼 �� �����ֹμ��� ������ ��/////
            pGridColumn[52] = pGrid.GetColumnToIndex("D25");                 //�����ҵ漼
            pGridColumn[53] = pGrid.GetColumnToIndex("D26");                 //�����ֹμ�

            pXLColumn[01] = 2;  //�μ�    
            pXLColumn[02] = 5;  //���    
            pXLColumn[03] = 8;  //�޿�����
            pXLColumn[04] = 12; //�⺻��  
            pXLColumn[05] = 16; //���޼���
            pXLColumn[06] = 20; //Ư�ټ���
            pXLColumn[07] = 24; //������Ư
            pXLColumn[08] = 28; //�˻����
            pXLColumn[09] = 32; //�ڱⰳ��
            pXLColumn[10] = 36; //��������
            pXLColumn[11] = 40; //���°���
            pXLColumn[12] = 44; //���ο���
            pXLColumn[13] = 48; //��뺸��
            pXLColumn[14] = 52; //������
            pXLColumn[15] = 56; //����ҵ�
            pXLColumn[16] = 60; //��Ÿ����
            pXLColumn[17] = 64; //�����Ѿ�
            pXLColumn[18] = 2;  //����    
            pXLColumn[19] = 5;  //����    
            pXLColumn[20] = 8;  //�ϱ�    
            pXLColumn[21] = 12; //�ð��ܼ�
            pXLColumn[22] = 16; //�������
            pXLColumn[23] = 20; //�ټӼ���
            pXLColumn[24] = 24; //��å����
            pXLColumn[25] = 28; //�ڰݼ���
            pXLColumn[26] = 32; //��ź�  
            pXLColumn[27] = 36; //�޻󿩼�
            pXLColumn[28] = 40; //��Ÿ����
            pXLColumn[29] = 44; //�ǰ�����
            pXLColumn[30] = 48; //�ҵ漼  
            pXLColumn[31] = 52; //�۾�����
            pXLColumn[32] = 56; //�����ֹ�
            pXLColumn[33] = 60; //        
            pXLColumn[34] = 64; //�����Ѿ�
            pXLColumn[35] = 2;  //�Ի�����
            pXLColumn[36] = 5;  //�������
            pXLColumn[37] = 8;  //���ñ�
            pXLColumn[38] = 12; //�󿩱�  
            pXLColumn[39] = 16; //�߰�����
            pXLColumn[40] = 20; //        
            pXLColumn[41] = 24; //��������
            pXLColumn[42] = 28; //�������
            pXLColumn[43] = 32; //����Ȱ��
            pXLColumn[44] = 36; //���ܱٷ�
            pXLColumn[45] = 40; //���Ƽ���        
            pXLColumn[46] = 44; //�����
            pXLColumn[47] = 48; //�ֹμ�  
            pXLColumn[48] = 52; //���νſ�
            pXLColumn[49] = 56; //�����Ư��
            pXLColumn[50] = 60; //�ǰ�����        
            pXLColumn[51] = 64; //�����޾�


            mMegerColumnStart = pXLColumn[1];
            mMegerColumnEnd = pXLColumn[3];
        }

        #endregion;

        #region ----- IsConvert Methods -----

        #region ----- String Convert Method -----

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

        #endregion;

        #region ----- Number Convert Method -----

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

        private bool IsConvertNumber(string pStringNumber, out decimal pConvertDecimal)
        {
            bool vIsConvert = false;
            pConvertDecimal = 0m;

            try
            {
                if (pStringNumber != null)
                {
                    decimal vIsConvertNum = decimal.Parse(pStringNumber);
                    pConvertDecimal = vIsConvertNum;
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

        #region ----- Date Convert Method -----

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

        #endregion;

        #region ----- Header Write Method ----

        private void XLHeader(int pXLine, string pUserName, string pPrintingDateTime, string pYYYYMM_From, string pYYYYMM_To)
        {
            bool vIsNull = false;
            int vXLine = pXLine + 1;

            try
            {
                mPrinting.XLActiveSheet("SourceTab1");

                //System.Drawing.Point vCellPoint01 = new System.Drawing.Point(2, 2);    //Title
                //System.Drawing.Point vCellPoint02 = new System.Drawing.Point(4, 6);    //�����
                //System.Drawing.Point vCellPoint03 = new System.Drawing.Point(5, 6);    //�޿�����
                //System.Drawing.Point vCellPoint04 = new System.Drawing.Point(5, 19);   //�μ�
                //System.Drawing.Point vCellPoint05 = new System.Drawing.Point(4, 56);   //������
                //System.Drawing.Point vCellPoint06 = new System.Drawing.Point(5, 56);   //�������
                //System.Drawing.Point vCellPoint07 = new System.Drawing.Point(44, 41);  //��ü

                //Title
                bool vIsNull1 = string.IsNullOrEmpty(pYYYYMM_From);
                bool vIsNull2 = string.IsNullOrEmpty(pYYYYMM_To);
                if (vIsNull1 != true && vIsNull2 != true)
                {
                    string vYear_From = pYYYYMM_From.Substring(0, 4);
                    string vMonth_From = pYYYYMM_From.Substring(5, 2);
                    string vYear_To = pYYYYMM_To.Substring(0, 4);
                    string vMonth_To = pYYYYMM_To.Substring(5, 2);
                    string vTitle = string.Format("{0}�� {1}�� ~ {2}�� {3}�� ����", vYear_From, vMonth_From, vYear_To, vMonth_To);
                    mPrinting.XLSetCell(vXLine, mXLColumnHeader[1], vTitle);
                }
                else
                {
                    mPrinting.XLSetCell(vXLine, mXLColumnHeader[1], null);
                }

                //-------------------------------------------------------------------
                vXLine = vXLine + 3;
                //-------------------------------------------------------------------

                //�����
                vIsNull = string.IsNullOrEmpty(pUserName);
                if (vIsNull != true)
                {
                    mPrinting.XLSetCell(vXLine, mXLColumnHeader[2], pUserName);
                }
                else
                {
                    mPrinting.XLSetCell(vXLine, mXLColumnHeader[2], null);
                }

                //-------------------------------------------------------------------
                vXLine = vXLine + 1;
                //-------------------------------------------------------------------

                //�������
                vIsNull = string.IsNullOrEmpty(pPrintingDateTime);
                if (vIsNull != true)
                {
                    mPrinting.XLSetCell(vXLine, mXLColumnHeader[6], pPrintingDateTime);
                }
                else
                {
                    mPrinting.XLSetCell(vXLine, mXLColumnHeader[6], null);
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

        private int XLLine(InfoSummit.Win.ControlAdv.ISGridAdvEx pGrid, int pGridRow, int pXLine, int[] pGridColumn, int[] pXLColumn)
        {
            bool vIsValueViewTemp = false;
            int vXLine = pXLine; //������ ������ ǥ�õǴ� �� ��ȣ

            object vGetValue = null;
            int vGridIndexColumn = 0;
            int vXLIndexColumn = 0;

            string vConvertString = string.Empty;
            decimal vConvertDecimal = 0m;
            decimal vConvertDecimal2 = 0m;
            bool IsConvert = false;
            bool IsMerge = false;

            string vInWonSu = string.Empty; //�ο���

            try
            {
                mPrinting.XLActiveSheet("Destination");

                #region ----- [01] ~ [17] ----

                //[01]
                vXLIndexColumn = pXLColumn[1];
                vGridIndexColumn = pGridColumn[1];
                ////vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertString(vGetValue, out vConvertString);
                    if (IsConvert == true)
                    {
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[01]";
                        }
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[01]";
                    }
                    mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                }

                //[02]
                vXLIndexColumn = pXLColumn[2];
                vGridIndexColumn = pGridColumn[2];
                ////vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertString(vGetValue, out vConvertString);
                    if (IsConvert == true)
                    {
                        vInWonSu = vConvertString;
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[02]";
                        }
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[02]";
                    }
                    mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                }

                //[03]
                vXLIndexColumn = pXLColumn[3];
                vGridIndexColumn = pGridColumn[3];
                ////vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertString(vGetValue, out vConvertString);
                    if (IsConvert == true)
                    {
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[03]";
                        }
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[03]";
                    }
                    mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                }

                //[04]
                vXLIndexColumn = pXLColumn[4];
                vGridIndexColumn = pGridColumn[4];
                ////vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertNumber(vGetValue, out vConvertDecimal);
                    if (IsConvert == true)
                    {
                        vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[04]";
                        }
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[04]";
                    }
                    mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                }

                //[05]
                vXLIndexColumn = pXLColumn[5];
                vGridIndexColumn = pGridColumn[5];
                ////vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertNumber(vGetValue, out vConvertDecimal);
                    if (IsConvert == true)
                    {
                        vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[05]";
                        }
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[05]";
                    }
                    mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                }

                //[06]
                vXLIndexColumn = pXLColumn[6];
                vGridIndexColumn = pGridColumn[6];
                ////vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertNumber(vGetValue, out vConvertDecimal);
                    if (IsConvert == true)
                    {
                        vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[06]";
                        }
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[06]";
                    }
                    mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                }

                //[07]
                vXLIndexColumn = pXLColumn[7];
                vGridIndexColumn = pGridColumn[7];
                ////vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertNumber(vGetValue, out vConvertDecimal);
                    if (IsConvert == true)
                    {
                        vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[07]";
                        }
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[07]";
                    }
                    mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                }

                //[08]
                vXLIndexColumn = pXLColumn[8];
                vGridIndexColumn = pGridColumn[8];
                ////vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertNumber(vGetValue, out vConvertDecimal);
                    if (IsConvert == true)
                    {
                        vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);

                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[08]";
                        }
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[08]";
                    }
                    mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                }

                //[09]
                vXLIndexColumn = pXLColumn[9];
                vGridIndexColumn = pGridColumn[9];
                ////vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertNumber(vGetValue, out vConvertDecimal);
                    if (IsConvert == true)
                    {
                        vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);

                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[09]";
                        }
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[09]";
                    }
                    mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                }

                //[10]
                vXLIndexColumn = pXLColumn[10];
                vGridIndexColumn = pGridColumn[10];
                ////vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertNumber(vGetValue, out vConvertDecimal);
                    if (IsConvert == true)
                    {
                        vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);

                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[10]";
                        }
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[10]";
                    }
                    mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                }

                //[11]
                vXLIndexColumn = pXLColumn[11];
                vGridIndexColumn = pGridColumn[11];
                ////vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertNumber(vGetValue, out vConvertDecimal);
                    if (IsConvert == true)
                    {
                        vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);

                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[11]";
                        }
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[11]";
                    }
                    mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                }

                //[12]
                vXLIndexColumn = pXLColumn[12];
                vGridIndexColumn = pGridColumn[12];
                ////vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertNumber(vGetValue, out vConvertDecimal);
                    if (IsConvert == true)
                    {
                        vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);

                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[12]";
                        }
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[12]";
                    }
                    mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                }

                //[13]
                vXLIndexColumn = pXLColumn[13];
                vGridIndexColumn = pGridColumn[13];
                ////vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertNumber(vGetValue, out vConvertDecimal);
                    if (IsConvert == true)
                    {
                        vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);

                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[13]";
                        }
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[13]";
                    }
                    mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                }

                //[14]
                vXLIndexColumn = pXLColumn[14];
                vGridIndexColumn = pGridColumn[14];
                ////vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertNumber(vGetValue, out vConvertDecimal);
                    if (IsConvert == true)
                    {
                        vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);

                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[14]";
                        }
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[14]";
                    }
                    mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                }

                //[15]
                vXLIndexColumn = pXLColumn[15];
                vGridIndexColumn = pGridColumn[15];
                ////vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertNumber(vGetValue, out vConvertDecimal);

                    vGetValue = pGrid.GetCellValue(pGridRow, pGridColumn[52]);
                    IsConvert = IsConvertNumber(vGetValue, out vConvertDecimal2);
                    if (IsConvert == true)
                    {
                        vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal + vConvertDecimal2);
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);

                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[15]";
                        }
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[15]";
                    }
                    mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                }

                //[16]
                vXLIndexColumn = pXLColumn[16];
                vGridIndexColumn = pGridColumn[16];
                ////vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertNumber(vGetValue, out vConvertDecimal);
                    if (IsConvert == true)
                    {
                        vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);

                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[16]";
                        }
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[16]";
                    }
                    mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                }

                //[17]
                vXLIndexColumn = pXLColumn[17];
                vGridIndexColumn = pGridColumn[17];
                ////vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertNumber(vGetValue, out vConvertDecimal);
                    if (IsConvert == true)
                    {
                        vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);

                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[17]";
                        }
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[17]";
                    }
                    mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                }

                #endregion;

                //-------------------------------------------------------------------
                vXLine = vXLine + 1;
                //-------------------------------------------------------------------

                #region ----- [18] ~ [34] ----

                //[18]
                vXLIndexColumn = pXLColumn[18];
                vGridIndexColumn = pGridColumn[18];
                ////vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertString(vGetValue, out vConvertString);
                    if (IsConvert == true)
                    {
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[18]";
                        }
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[18]";
                    }
                    mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                }

                //[19]
                vXLIndexColumn = pXLColumn[19];
                vGridIndexColumn = pGridColumn[19];
                ////vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertString(vGetValue, out vConvertString);
                    if (IsConvert == true)
                    {
                        if (mMessageValue1 == vConvertString || mMessageValue2 == vConvertString)
                        {
                            mRowMerge[mCountRow] = 1;

                            IsMerge = true;

                            int vStartRow = vXLine - 1;
                            int vStartCol = pXLColumn[1];

                            //XL Cell ���� ����� --------------------------------
                            vGetValue = null;
                            mPrinting.XLSetCell((vXLine - 1), pXLColumn[1], vGetValue);
                            mPrinting.XLSetCell((vXLine - 1), pXLColumn[2], vGetValue);
                            mPrinting.XLSetCell(vXLine, pXLColumn[18], vGetValue);
                            mPrinting.XLSetCell(vXLine, pXLColumn[19], vGetValue);
                            mPrinting.XLSetCell((vXLine + 1), pXLColumn[35], vGetValue);
                            mPrinting.XLSetCell((vXLine + 1), pXLColumn[36], vGetValue);
                            //----------------------------------------------------

                            mPrinting.XLSetCell(vStartRow, vStartCol, vConvertString); //�μ��հ�

                            mPrinting.XLSetCell((vStartRow + 1), vStartCol, vInWonSu); //�ο� ���
                        }
                        else
                        {
                            mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                        }
                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[19]";
                        }

                        if (IsMerge == false)
                        {
                            mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                        }
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[19]";
                    }

                    if (IsMerge == false)
                    {
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }

                //[20]
                vXLIndexColumn = pXLColumn[20];
                vGridIndexColumn = pGridColumn[20];
                ////vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertNumber(vGetValue, out vConvertDecimal);
                    if (IsConvert == true)
                    {
                        vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[20]";
                        }
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[20]";
                    }
                    mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                }

                //[21]
                vXLIndexColumn = pXLColumn[21];
                vGridIndexColumn = pGridColumn[21];
                ////vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertNumber(vGetValue, out vConvertDecimal);
                    if (IsConvert == true)
                    {
                        vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[21]";
                        }
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[21]";
                    }
                    mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                }

                //[22]
                vXLIndexColumn = pXLColumn[22];
                vGridIndexColumn = pGridColumn[22];
                //vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertNumber(vGetValue, out vConvertDecimal);
                    if (IsConvert == true)
                    {
                        vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[22]";
                        }
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[22]";
                    }
                    mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                }

                //[23]
                vXLIndexColumn = pXLColumn[23];
                vGridIndexColumn = pGridColumn[23];
                //vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertNumber(vGetValue, out vConvertDecimal);
                    if (IsConvert == true)
                    {
                        vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[23]";
                        }
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[23]";
                    }
                    mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                }

                //[24]
                vXLIndexColumn = pXLColumn[24];
                vGridIndexColumn = pGridColumn[24];
                //vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertNumber(vGetValue, out vConvertDecimal);
                    if (IsConvert == true)
                    {
                        vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[24]";
                        }
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[24]";
                    }
                    mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                }

                //[25]
                vXLIndexColumn = pXLColumn[25];
                vGridIndexColumn = pGridColumn[25];
                //vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertNumber(vGetValue, out vConvertDecimal);
                    if (IsConvert == true)
                    {
                        vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[25]";
                        }
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[25]";
                    }
                    mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                }

                //[26]
                vXLIndexColumn = pXLColumn[26];
                vGridIndexColumn = pGridColumn[26];
                //vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertNumber(vGetValue, out vConvertDecimal);
                    if (IsConvert == true)
                    {
                        vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[26]";
                        }
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[26]";
                    }
                    mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                }

                //[27]
                vXLIndexColumn = pXLColumn[27];
                vGridIndexColumn = pGridColumn[27];
                //vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertNumber(vGetValue, out vConvertDecimal);
                    if (IsConvert == true)
                    {
                        vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[27]";
                        }
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[27]";
                    }
                    mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                }

                //[28]
                vXLIndexColumn = pXLColumn[28];
                vGridIndexColumn = pGridColumn[28];
                //vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertNumber(vGetValue, out vConvertDecimal);
                    if (IsConvert == true)
                    {
                        vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[28]";
                        }
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[28]";
                    }
                    mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                }

                //[29]
                vXLIndexColumn = pXLColumn[29];
                vGridIndexColumn = pGridColumn[29];
                //vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertNumber(vGetValue, out vConvertDecimal);
                    if (IsConvert == true)
                    {
                        vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[29]";
                        }
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[29]";
                    }
                    mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                }

                //[30]
                vXLIndexColumn = pXLColumn[30];
                vGridIndexColumn = pGridColumn[30];
                //vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertNumber(vGetValue, out vConvertDecimal);
                    if (IsConvert == true)
                    {
                        vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[30]";
                        }
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[30]";
                    }
                    mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                }

                //[31]
                vXLIndexColumn = pXLColumn[31];
                vGridIndexColumn = pGridColumn[31];
                //vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertNumber(vGetValue, out vConvertDecimal);
                    if (IsConvert == true)
                    {
                        vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[31]";
                        }
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[31]";
                    }
                    mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                }

                //[32]
                vXLIndexColumn = pXLColumn[32];
                vGridIndexColumn = pGridColumn[32];
                //vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertNumber(vGetValue, out vConvertDecimal);

                    vGetValue = pGrid.GetCellValue(pGridRow, pGridColumn[53]);
                    IsConvert = IsConvertNumber(vGetValue, out vConvertDecimal2); ;
                    if (IsConvert == true)
                    {
                        vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal + vConvertDecimal2);
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[32]";
                        }
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[32]";
                    }
                    mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                }

                //[33]
                vXLIndexColumn = pXLColumn[33];
                vGridIndexColumn = pGridColumn[33];
                //vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertNumber(vGetValue, out vConvertDecimal);
                    if (IsConvert == true)
                    {
                        vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[33]";
                        }
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[33]";
                    }
                    mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                }

                //[34]
                vXLIndexColumn = pXLColumn[34];
                vGridIndexColumn = pGridColumn[34];
                //vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertNumber(vGetValue, out vConvertDecimal);
                    if (IsConvert == true)
                    {
                        vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[34]";
                        }
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[34]";
                    }
                    mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                }

                #endregion;

                //-------------------------------------------------------------------
                vXLine = vXLine + 1;
                //-------------------------------------------------------------------

                #region ----- [35] ~ [51] ----

                //[35]
                vXLIndexColumn = pXLColumn[35];
                vGridIndexColumn = pGridColumn[35];
                //vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertString(vGetValue, out vConvertString);
                    if (IsConvert == true)
                    {
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[35]";
                        }

                        if (IsMerge == false)
                        {
                            mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                        }
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[35]";
                    }

                    if (IsMerge == false)
                    {
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }

                //[36]
                vXLIndexColumn = pXLColumn[36];
                vGridIndexColumn = pGridColumn[36];
                //vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertString(vGetValue, out vConvertString);
                    if (IsConvert == true)
                    {
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[36]";
                        }

                        if (IsMerge == false)
                        {
                            mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                        }
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[36]";
                    }

                    if (IsMerge == false)
                    {
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }

                //[37]
                vXLIndexColumn = pXLColumn[37];
                vGridIndexColumn = pGridColumn[37];
                //vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertNumber(vGetValue, out vConvertDecimal);
                    if (IsConvert == true)
                    {
                        vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[37]";
                        }
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[37]";
                    }
                    mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                }

                //[38]
                vXLIndexColumn = pXLColumn[38];
                vGridIndexColumn = pGridColumn[38];
                //vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertNumber(vGetValue, out vConvertDecimal);
                    if (IsConvert == true)
                    {
                        vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[38]";
                        }
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[38]";
                    }
                    mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                }

                //[39]
                vXLIndexColumn = pXLColumn[39];
                vGridIndexColumn = pGridColumn[39];
                //vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertNumber(vGetValue, out vConvertDecimal);
                    if (IsConvert == true)
                    {
                        vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[39]";
                        }
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[39]";
                    }
                    mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                }

                //[40]
                vXLIndexColumn = pXLColumn[40];
                vGridIndexColumn = pGridColumn[40];
                //vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertNumber(vGetValue, out vConvertDecimal);
                    if (IsConvert == true)
                    {
                        vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[40]";
                        }
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[40]";
                    }
                    mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                }

                //[41]
                vXLIndexColumn = pXLColumn[41];
                vGridIndexColumn = pGridColumn[41];
                //vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertNumber(vGetValue, out vConvertDecimal);
                    if (IsConvert == true)
                    {
                        vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[41]";
                        }
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[41]";
                    }
                    mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                }

                //[42]
                vXLIndexColumn = pXLColumn[42];
                vGridIndexColumn = pGridColumn[42];
                //vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertNumber(vGetValue, out vConvertDecimal);
                    if (IsConvert == true)
                    {
                        vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[42]";
                        }
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[42]";
                    }
                    mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                }

                //[43]
                vXLIndexColumn = pXLColumn[43];
                vGridIndexColumn = pGridColumn[43];
                //vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertNumber(vGetValue, out vConvertDecimal);
                    if (IsConvert == true)
                    {
                        vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[43]";
                        }
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[43]";
                    }
                    mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                }

                //[44]
                vXLIndexColumn = pXLColumn[44];
                vGridIndexColumn = pGridColumn[44];
                //vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertNumber(vGetValue, out vConvertDecimal);
                    if (IsConvert == true)
                    {
                        vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[44]";
                        }
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[44]";
                    }
                    mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                }

                //[45]
                vXLIndexColumn = pXLColumn[45];
                vGridIndexColumn = pGridColumn[45];
                //vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertNumber(vGetValue, out vConvertDecimal);
                    if (IsConvert == true)
                    {
                        vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[45]";
                        }
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[45]";
                    }
                    mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                }

                //[46]
                vXLIndexColumn = pXLColumn[46];
                vGridIndexColumn = pGridColumn[46];
                //vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertNumber(vGetValue, out vConvertDecimal);
                    if (IsConvert == true)
                    {
                        vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[46]";
                        }
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[46]";
                    }
                    mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                }

                //[47]
                vXLIndexColumn = pXLColumn[47];
                vGridIndexColumn = pGridColumn[47];
                //vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertNumber(vGetValue, out vConvertDecimal);
                    if (IsConvert == true)
                    {
                        vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[47]";
                        }
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[47]";
                    }
                    mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                }

                //[48]
                vXLIndexColumn = pXLColumn[48];
                vGridIndexColumn = pGridColumn[48];
                //vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertNumber(vGetValue, out vConvertDecimal);
                    if (IsConvert == true)
                    {
                        vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[48]";
                        }
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[48]";
                    }
                    mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                }

                //[49]
                vXLIndexColumn = pXLColumn[49];
                vGridIndexColumn = pGridColumn[49];
                //vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertNumber(vGetValue, out vConvertDecimal);
                    if (IsConvert == true)
                    {
                        vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[49]";
                        }
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[49]";
                    }
                    mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                }

                //[50]
                vXLIndexColumn = pXLColumn[50];
                vGridIndexColumn = pGridColumn[50];
                //vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertNumber(vGetValue, out vConvertDecimal);
                    if (IsConvert == true)
                    {
                        vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[50]";
                        }
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[50]";
                    }
                    mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                }

                //[51]
                vXLIndexColumn = pXLColumn[51];
                vGridIndexColumn = pGridColumn[51];
                //vGridIndexColumn = -1;
                if (vGridIndexColumn != -1)
                {
                    vGetValue = pGrid.GetCellValue(pGridRow, vGridIndexColumn);
                    IsConvert = IsConvertNumber(vGetValue, out vConvertDecimal);
                    if (IsConvert == true)
                    {
                        vConvertString = string.Format("{0:#,###,###,###,###,###,###,###,###,##0}", vConvertDecimal);
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                    else
                    {
                        if (vIsValueViewTemp == false)
                        {
                            vConvertString = string.Empty;
                        }
                        else
                        {
                            vConvertString = "[51]";
                        }
                        mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                    }
                }
                else
                {
                    if (vIsValueViewTemp == false)
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = "[51]";
                    }
                    mPrinting.XLSetCell(vXLine, vXLIndexColumn, vConvertString);
                }

                #endregion;

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


            mCountRow++;


            pXLine = vXLine;

            return pXLine;
        }

        #endregion;

        #region ----- Cell Merge Methods ----

        private void CellMerge(int pCopySumPrintingLine, int pCountRow, int[] pRowMerge)
        {
            int vXLine = 0;
            int vCountRowMerge = pRowMerge.Length;

            try
            {
                for (int vCount = 0; vCount < vCountRowMerge; vCount++)
                {
                    if (pRowMerge[vCount] == 1)
                    {
                        vXLine = (pCopySumPrintingLine - mIncrementCopyMAX) + mPrintingLineSTART + (vCount * 3);
                        int vStartRow = vXLine - 1;
                        int vStartCol = mMegerColumnStart;
                        int vEndRow = vXLine - 1;
                        int vEndCol = mMegerColumnEnd - 1;

                        mPrinting.XLCellMerge(vStartRow, vStartCol, vEndRow, vEndCol, false);

                        vStartRow = vXLine;
                        vEndRow = vXLine + 1;

                        mPrinting.XLCellMerge(vStartRow, vStartCol, vEndRow, vEndCol, false);
                    }

                    mRowMerge[vCount] = -1;
                }

                mCountRow = 0; //�����ؾ��� ���� �� ��ġ Count, 0���� Set
            }
            catch (System.Exception ex)
            {
                mMessageError = ex.Message;
            }
        }

        #endregion;

        #region ----- [DepartmentName] Excel Wirte Method ----

        private void DepartmentNameWrite(InfoSummit.Win.ControlAdv.ISGridAdvEx pGrid, int pRowGrid, int pXLine)
        {
            object vGetValue = null;
            bool IsConvert = false;
            int vGridIndexRow = pRowGrid + 1;
            int vGridIndexColumn = 0;
            string vConvertString = string.Empty;

            string vGridColumn = "DEPT_NAME";  //�μ�
            vGridIndexColumn = pGrid.GetColumnToIndex(vGridColumn);

            int vXLine = (pXLine - mIncrementCopyMAX) + 5;
            int vXLColumn = 26; //�μ�

            vGetValue = pGrid.GetCellValue(vGridIndexRow, vGridIndexColumn);
            IsConvert = IsConvertString(vGetValue, out vConvertString);
            if (IsConvert == true)
            {
                mPrinting.XLSetCell(vXLine, vXLColumn, vConvertString);

                mTemp_DepartmentName = vConvertString;
            }
            else
            {
                vConvertString = mTemp_DepartmentName;
                mPrinting.XLSetCell(vXLine, vXLColumn, vConvertString);
            }

            //------------------------------------------------------------

            vGridColumn = "WAGE_TYPE_NAME";  //�޻󿩱���
            vGridIndexColumn = pGrid.GetColumnToIndex(vGridColumn);

            vXLColumn = 8; //�޻󿩱���

            vGetValue = pGrid.GetCellValue(vGridIndexRow, vGridIndexColumn);
            IsConvert = IsConvertString(vGetValue, out vConvertString);
            if (IsConvert == true)
            {
                mPrinting.XLSetCell(vXLine, vXLColumn, vConvertString);

                mWageTypeName = vConvertString;
            }
            else
            {
                vConvertString = mWageTypeName;
                mPrinting.XLSetCell(vXLine, vXLColumn, vConvertString);
            }

            //------------------------------------------------------------

            vGridColumn = "PAY_YYYYMM";  //���޳��
            vGridIndexColumn = pGrid.GetColumnToIndex(vGridColumn);

            vXLine = vXLine - 1;
            vXLColumn = 26; //���޳��

            vGetValue = pGrid.GetCellValue(vGridIndexRow, vGridIndexColumn);
            IsConvert = IsConvertString(vGetValue, out vConvertString);
            if (IsConvert == true)
            {
                mPrinting.XLSetCell(vXLine, vXLColumn, vConvertString);

                mPAY_YYYYMM = vConvertString;
            }
            else
            {
                vConvertString = mPAY_YYYYMM;
                mPrinting.XLSetCell(vXLine, vXLColumn, vConvertString);
            }

            //------------------------------------------------------------
            //������ ��ȣ
            vXLColumn = 61;
            mPrinting.XLSetCell(vXLine, vXLColumn, mPageNumber.ToString());
        }

        #endregion;

        #region ----- Excel Rate Line Clear Method ----

        private void RateLineClear(int pPrintingLine)
        {
            int vStartRow = pPrintingLine;
            int vStartCol = mCopyColumnSTART + 1;
            int vEndRow = mCopyLineSUM - 1;
            int vEndCol = mCopyColumnEND;
            int vDrawRow = pPrintingLine;

            mPrinting.XL_LineClearALL(vStartRow, vStartCol, vEndRow, vEndCol);
            mPrinting.XLCellColorBrush(vStartRow, vStartCol, vEndRow, vEndCol, System.Drawing.Color.White);
            mPrinting.XL_LineDraw_Top(vDrawRow, vStartCol, vEndCol, 2);
        }

        #endregion;

        #endregion;

        #region ----- Excel Wirte [Line] Methods ----

        public int LineWrite(InfoSummit.Win.ControlAdv.ISGridAdvEx pGrid, string pUserName, string pCorporationName, string pYYYYMM_FROM, string pYYYYMM_TO)
        {
            mPageNumber = 0;
            string vMessage = string.Empty;

            string vPrintingDate = System.DateTime.Now.ToString("yyyy-MM-dd", null);
            string vPrintingTime = System.DateTime.Now.ToString("HH:mm:ss", null);
            mPringingDateTime = string.Format("{0} {1}", vPrintingDate, vPrintingTime);

            int[] vGridColumn;
            int[] vXLColumn;

            int vPrintingLine = 0;

            try
            {
                int vTotal1ROW = pGrid.RowCount;

                #region ----- Sheet Copy ----

                bool vIsPageSkip = false; //�μ��հ� �̰ų� ���հ��̸� ������ �ѱ�

                mMessageValue1 = mMessageAdapter.ReturnText("FCM_10217");  //�μ��հ�
                mMessageValue2 = mMessageAdapter.ReturnText("EAPP_10045"); //���հ�

                mCorporationName = pCorporationName;   //��ü
                mUserName = pUserName;                 //�����
                mYYYYMM_From = pYYYYMM_FROM;           //��³��_����
                mYYYYMM_To = pYYYYMM_TO;               //��³��_����

                SetArray1();

                XLHeader(1, mUserName, mPringingDateTime, mYYYYMM_From, mYYYYMM_To);
                mCopyLineSUM = CopyAndPaste(mCopyLineSUM);
                DepartmentNameWrite(pGrid, 0, mCopyLineSUM);

                #endregion;

                #region ----- Line Write ----

                if (vTotal1ROW > 0)
                {
                    int vCountROW1 = 0;

                    vPrintingLine = mPrintingLineSTART;

                    SetArray2(pGrid, out vGridColumn, out vXLColumn);

                    for (int vRow1 = 0; vRow1 < vTotal1ROW; vRow1++)
                    {
                        vCountROW1++;

                        vMessage = string.Format("Row : {0}/{1}", vCountROW1, vTotal1ROW);
                        mAppInterface.OnAppMessageEvent(vMessage);
                        System.Windows.Forms.Application.DoEvents();

                        vPrintingLine = XLLine(pGrid, vRow1, vPrintingLine, vGridColumn, vXLColumn);

                        if (vTotal1ROW == vCountROW1)
                        {
                            //������ ���̸�...


                            CellMerge(mCopyLineSUM, mCountRow, mRowMerge);

                            //��ü
                            mPrinting.XLSetCell(vPrintingLine, 64, mCorporationName);

                            //��µ� �������� ��µ��� ���� ���� �� ����
                            RateLineClear(vPrintingLine);
                        }
                        else
                        {
                            vIsPageSkip = IsSkipPage(pGrid, vRow1, vGridColumn[19]); //�μ��� ������ �ѱ� ����

                            IsNewPage(vIsPageSkip, vPrintingLine, pGrid, vRow1);
                            if (mIsNewPage == true)
                            {
                                vPrintingLine = (mCopyLineSUM - mIncrementCopyMAX) + (mPrintingLineSTART - 1);
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

        #region ----- Skip Page iF Methods ----

        private bool IsSkipPage(InfoSummit.Win.ControlAdv.ISGridAdvEx pGrid, int pRowGrid, int pGridColumn)
        {
            bool vIsPageSkip = false;

            string vConvertString_1 = string.Empty;
            string vConvertString_2 = string.Empty;

            object vGetValue_2 = pGrid.GetCellValue((pRowGrid + 1), pGridColumn);
            bool vIsConvert_2 = IsConvertString(vGetValue_2, out vConvertString_2);

            object vGetValue_1 = pGrid.GetCellValue(pRowGrid, pGridColumn);
            bool vIsConvert_1 = IsConvertString(vGetValue_1, out vConvertString_1);
            if (vIsConvert_1 == true)
            {
                if (mMessageValue1 == vConvertString_1)
                {
                    if (vIsConvert_2 == true)
                    {
                        if (mMessageValue2 == vConvertString_2)
                        {
                            vIsPageSkip = false;
                        }
                        else
                        {
                            vIsPageSkip = true;
                        }
                    }
                    else
                    {
                        vIsPageSkip = true;
                    }
                }
            }

            return vIsPageSkip;
        }

        #endregion;

        #region ----- New Page iF Methods ----

        private void IsNewPage(bool pIsPageSkep, int pPrintingLine, InfoSummit.Win.ControlAdv.ISGridAdvEx pGrid, int pRowGrid)
        {
            int vPrintingLineEND = mCopyLineSUM - 3; //1~49: mCopyLineSUM=50���� ������ ��µǴ� ���� 47 �̹Ƿ�, 3�� ���� �ȴ�
            if (vPrintingLineEND < pPrintingLine)
            {
                CellMerge(mCopyLineSUM, mCountRow, mRowMerge);

                //��ü
                mPrinting.XLSetCell(pPrintingLine, 64, mCorporationName);

                mIsNewPage = true;
                mCopyLineSUM = CopyAndPaste(mCopyLineSUM);

                //�μ�
                DepartmentNameWrite(pGrid, pRowGrid, mCopyLineSUM);
            }
            else if (pIsPageSkep == true)
            {
                CellMerge(mCopyLineSUM, mCountRow, mRowMerge);

                //��ü
                mPrinting.XLSetCell(pPrintingLine, 64, mCorporationName);

                //��µ� �������� ��µ��� ���� ���� �� ����
                RateLineClear(pPrintingLine);

                //Sheet Copy
                mIsNewPage = true;
                mCopyLineSUM = CopyAndPaste(mCopyLineSUM);

                //�μ�
                DepartmentNameWrite(pGrid, pRowGrid, mCopyLineSUM);
            }
            else
            {
                mIsNewPage = false;
            }
        }

        #endregion;

        #region ----- Copy&Paste Sheet Method ----

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