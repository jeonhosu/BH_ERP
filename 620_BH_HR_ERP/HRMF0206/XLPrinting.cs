using System;
using ISCommonUtil;

namespace HRMF0206
{
    /// <summary>
    /// XLPrint Class�� �̿��� Report�� ���� 
    /// </summary>
    public class XLPrinting
    {
        #region ----- Variables -----

        ISFunction.ISConvert iConv = new ISFunction.ISConvert();
        ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();


        private InfoSummit.Win.ControlAdv.ISGridAdvEx mGridAdvEx;
        private InfoSummit.Win.ControlAdv.ISProgressBar mProgressBar1;
        private InfoSummit.Win.ControlAdv.ISProgressBar mProgressBar2;

        private XL.XLPrint mPrinting = null;

        private string mMessageError = string.Empty;

        private string mXLOpenFileName = string.Empty;

        private int[] mIndexGridColumns = new int[0] { };

        private int mPositionPrintLineSTART = 1; //���� ��½� ���� ���� �� ��ġ ����
        private int[] mIndexXLWriteColumn = new int[0] { }; //������ ����� �� ��ġ ����

        private int mMaxIncrement = 45; //���� ��µǴ� ���� ���ۺ��� �� ���� ����
        private int mSumPrintingLineCopy = 1; //������ ���õ� ��Ʈ�� ����Ǿ��� ���� �� ��ġ �� ���� �� ��
        private int mMaxIncrementCopy = 67; //�ݺ� ����Ǿ��� ���� �ִ� ����

        private int mXLColumnAreaSTART = 1; //����Ǿ��� ��Ʈ�� ��, ���ۿ�
        private int mXLColumnAreaEND = 45;  //����Ǿ��� ��Ʈ�� ��, ���῭

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
                IsOpen = mPrinting.XLOpenFile(mXLOpenFileName);
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

        #region ----- Define Print Column Methods ----

        private void XLDefinePrintColumn(InfoSummit.Win.ControlAdv.ISGridAdvEx pGrid)
        {
            try
            {
                //Grid�� [Edit] ���� [DataColumn] ���� �ִ� �� �̸��� ���� �ϸ� �ȴ�.
                string[] vGridDataColumns = new string[]
                {
                    "NAME",
                    "PERSON_NUM",
                    "DEPT_NAME",
                    "POST_NAME",
                    "JOB_CLASS_NAME",
                    "SUPPLY_DATE",
                    "BANK_NAME",
                    "BANK_ACCOUNTS",
                    "REAL_AMOUNT"
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
                    28,
                    28,
                    28,
                    29,
                    29,
                    29,
                    30,
                    30,
                    60
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
                        case 1: //Default
                            vObject = pGrid.GridAdvExColElement[vGetIndexGridColumn].HeaderElement[0].Default;
                            mPrinting.XLSetCell(vXLine, mIndexXLWriteColumn[vCol], vObject);
                            break;
                        case 2: //KR
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
                        //string vTextDateTimeLong = vDateTime.ToString("yyyy-MM-dd HH:mm:ss", null);
                        string vTextDateTimeLong = vDateTime.ToString("yyyy�� MM�� dd��", null);
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

                //XLContentWrite(mPrinting, pGrid, pTotalRow, mPositionPrintLineSTART, mIndexXLWriteColumn, vPrintingRowSTART, vPrintingRowEND);
            }
            catch (System.Exception ex)
            {
                mMessageError = string.Format("{0}", ex.Message);
            }

            return pSumWriteLine;
        }

        #endregion;

        #region ----- Report Title -----

        private void ReportTitle()
        {
            //======================================================================================
            // ���� �� �⺻���� �׸�� ��� �κ�
            //======================================================================================
            //����
            mPrinting.XLSetCell(5, 13, "��   ��   ��   ��   ǥ");
            //�⺻����
            mPrinting.XLSetCell(10, 3, "��   ��   ��   ��");
            //����
            mPrinting.XLSetCell(12, 11, "��      ��");
            //����
            mPrinting.XLSetCell(12, 22, "��  ��  ��");
            //�޿�����
            mPrinting.XLSetCell(12, 33, "��  ��  ��");
            //�μ�
            mPrinting.XLSetCell(14, 11, "��      ��");
            //��å
            mPrinting.XLSetCell(14, 22, "��      å");
            //�ֹε�Ϲ�ȣ
            mPrinting.XLSetCell(14, 33, "�ֹε�Ϲ�ȣ");
            //���
            mPrinting.XLSetCell(16, 11, "���  ��ȣ");
            //����
            mPrinting.XLSetCell(16, 22, "��      ��");
            //�������
            mPrinting.XLSetCell(16, 33, "��  ��  ��");
            //�Ի�����
            mPrinting.XLSetCell(18, 11, "�Ի�  ����");
            //����
            mPrinting.XLSetCell(18, 22, "���  ����");
            //����
            mPrinting.XLSetCell(18, 33, "����  ��ȣ");
            //��ȭ��ȣ
            mPrinting.XLSetCell(20, 11, "��  ��  ��");
            //�̸���
            mPrinting.XLSetCell(20, 22, "��ȭ  ��ȣ");
            //��������
            mPrinting.XLSetCell(20, 33, "�޴�  ��ȭ");
            //======================================================================================
            // å���ӱ� �׸��
            //======================================================================================
            //å���ӱ�
            mPrinting.XLSetCell(44, 25, "å���ӱ�");
            //����Ⱓ
            mPrinting.XLSetCell(44, 27, "����Ⱓ");
            //�⺻��
            //mPrinting.XLSetCell(44, 33, "�⺻��"); //���� ������ �μ��ϴ� �κп��� ó����//
            //======================================================================================
            // �з»��� �׸��
            //======================================================================================
            //�з»���
            mPrinting.XLSetCell(23, 3, "�з»���");
            //���
            mPrinting.XLSetCell(23, 5, "�������");
            //��ű�
            mPrinting.XLSetCell(23, 10, "�� �� ��");
            //�з�
            mPrinting.XLSetCell(23, 16, "�� ��");
            //����
            mPrinting.XLSetCell(23, 19, "�� ��");
            //======================================================================================
            // �������� �׸��
            //======================================================================================
            //��������
            mPrinting.XLSetCell(23, 25, "��������");
            //����
            mPrinting.XLSetCell(23, 27, "�� ��");
            //����
            mPrinting.XLSetCell(23, 30, "�� ��");
            //�������
            mPrinting.XLSetCell(23, 34, "�������");
            //�з�
            mPrinting.XLSetCell(23, 38, "�� ��");
            //�ٹ�ó
            mPrinting.XLSetCell(23, 41, "�� �� ó");
            //======================================================================================
            // �ڰݻ��� �׸��
            //======================================================================================
            //�ڰ�/����
            mPrinting.XLSetCell(32, 3, "�ڰ�/����");
            //�ڰ�����
            mPrinting.XLSetCell(32, 5, "�ڰ�����");
            //���
            mPrinting.XLSetCell(32, 12, "���");
            //�����
            mPrinting.XLSetCell(32, 17, "�����");
            //======================================================================================
            // ��»��� �׸��
            //======================================================================================
            //��»���
            mPrinting.XLSetCell(32, 25, "��»���");
            //�ٹ��Ⱓ
            mPrinting.XLSetCell(32, 27, "�ٹ��Ⱓ");
            //�ٹ�ó
            mPrinting.XLSetCell(32, 33, "�ٹ�ó");
            //����
            mPrinting.XLSetCell(32, 38, "����");
            //������
            mPrinting.XLSetCell(32, 41, "������");
            //======================================================================================
            // ���л��� �׸��
            //======================================================================================
            //����
            mPrinting.XLSetCell(38, 3, "�� ��");
            //���б���
            mPrinting.XLSetCell(38, 5, "���б���");
            //����
            mPrinting.XLSetCell(38, 11, "�� ��");
            //���
            mPrinting.XLSetCell(38, 17, "���");
            //����
            mPrinting.XLSetCell(38, 20, "�� ��");
            //======================================================================================
            // ǥâ/¡����� �׸��
            //======================================================================================
            //ǥâ/¡��
            mPrinting.XLSetCell(38, 25, "ǥâ/¡��");
            //�������
            mPrinting.XLSetCell(38, 27, "�������");
            //�������
            mPrinting.XLSetCell(38, 33, "�������");
            //����
            mPrinting.XLSetCell(38, 37, "����");
            //����
            mPrinting.XLSetCell(38, 41, "����");
            //======================================================================================
            // �������� �׸��
            //======================================================================================
            //����
            mPrinting.XLSetCell(44, 3, "�� ��");
            //��������
            mPrinting.XLSetCell(44, 5, "��������");
            //�Ⱓ
            mPrinting.XLSetCell(44, 11, "�� ��");
            //������
            mPrinting.XLSetCell(44, 18, "������");
            //======================================================================================
            // �߷ɻ��� �׸��
            //======================================================================================
            //�߷��̷�
            mPrinting.XLSetCell(50, 3, "�� �� �� ��");
            //�߷�����
            mPrinting.XLSetCell(50, 5, "�߷�����");
            //�߷�
            mPrinting.XLSetCell(50, 12, "�� ��");
            //�μ�
            mPrinting.XLSetCell(50, 18, "�� ��");
            //��å
            mPrinting.XLSetCell(50, 23, "�� å");
            //����
            mPrinting.XLSetCell(50, 27, "�� ��");
            //����
            mPrinting.XLSetCell(50, 31, "�� ��");
            //ȣ��
            mPrinting.XLSetCell(50, 35, "ȣ ��");
            //���
            mPrinting.XLSetCell(50, 39, "�� ��");
            //======================================================================================
            // ��ü/���»��� �׸��
            //======================================================================================
            //����
            mPrinting.XLSetCell(28, 3, "����");
            //���
            mPrinting.XLSetCell(28, 16, "���");
            //��ü
            mPrinting.XLSetCell(29, 3, "��ü");
            //����
            mPrinting.XLSetCell(29, 16, "����");
            //�ּ�
            mPrinting.XLSetCell(30, 3, "�ּ�");
            //======================================================================================
            // ���� �ϴ��� ��� ���� �׸��
            //======================================================================================
            //�����
            mPrinting.XLSetCell(65, 27, "����� : ");
            //�������
            mPrinting.XLSetCell(65, 37, "������� : ");
        }

        #endregion;

        private void XLContentWrite(InfoSummit.Win.ControlAdv.ISGridAdvEx pGrid, int pIndexRow, int pTotalRow, int pCnt, string pPrintDateTime, string pUserName)
        {
            try
            {
                mPrinting.XLActiveSheet("SourceTab1");

                if (pCnt == 1)
                {   
                    // �⺻ ����1
                    int vIndexDataColumn1 = pGrid.GetColumnToIndex("NAME");                 // ����
                    int vIndexDataColumn2 = pGrid.GetColumnToIndex("JOB_CATEGORY_NAME");    // ������
                    int vIndexDataColumn3 = pGrid.GetColumnToIndex("OPERATING_UNIT_NAME");  // �����
                    int vIndexDataColumn4 = pGrid.GetColumnToIndex("DEPT_NAME");            // �μ�    
                    int vIndexDataColumn5 = pGrid.GetColumnToIndex("ABIL_NAME");            // ��å    
                    int vIndexDataColumn6 = pGrid.GetColumnToIndex("REPRE_NUM");            // �ֹι�ȣ
                    int vIndexDataColumn7 = pGrid.GetColumnToIndex("PERSON_NUM");           // ���    
                    int vIndexDataColumn8 = pGrid.GetColumnToIndex("POST_NAME");            // ����    
                    int vIndexDataColumn9 = pGrid.GetColumnToIndex("FLOOR_NAME");           // �۾���
                    int vIndexDataColumn10 = pGrid.GetColumnToIndex("JOIN_DATE");           // �Ի�����
                    int vIndexDataColumn11 = pGrid.GetColumnToIndex("RETIRE_DATE");         // �������
                    int vIndexDataColumn12 = pGrid.GetColumnToIndex("EMAIL");               // �̸���
                    int vIndexDataColumn13 = pGrid.GetColumnToIndex("TELEPHON_NO");         // ��ȭ��ȣ
                    int vIndexDataColumn14 = pGrid.GetColumnToIndex("HP_PHONE_NO");         // �޴���ȭ
                    int vIndexDataColumn15 = pGrid.GetColumnToIndex("PRSN_ADDR1");          // �ּ�1
                    int vIndexDataColumn16 = pGrid.GetColumnToIndex("PRSN_ADDR2");          // �ּ�2
                    

                    //����
                    mPrinting.XLSetCell(12, 16, pGrid.GetCellValue(pIndexRow, vIndexDataColumn1));
                    //����
                    mPrinting.XLSetCell(12, 27, pGrid.GetCellValue(pIndexRow, vIndexDataColumn2));
                    //�����
                    mPrinting.XLSetCell(12, 38, pGrid.GetCellValue(pIndexRow, vIndexDataColumn3));

                    //�μ�
                    mPrinting.XLSetCell(14, 16, pGrid.GetCellValue(pIndexRow, vIndexDataColumn4));
                    //��å
                    mPrinting.XLSetCell(14, 27, pGrid.GetCellValue(pIndexRow, vIndexDataColumn5));
                    //�ֹι�ȣ
                    mPrinting.XLSetCell(14, 38, pGrid.GetCellValue(pIndexRow, vIndexDataColumn6));

                    //���
                    mPrinting.XLSetCell(16, 16, pGrid.GetCellValue(pIndexRow, vIndexDataColumn7));
                    //����
                    mPrinting.XLSetCell(16, 27, pGrid.GetCellValue(pIndexRow, vIndexDataColumn8));
                    //�۾���
                    mPrinting.XLSetCell(16, 38, pGrid.GetCellValue(pIndexRow, vIndexDataColumn9));

                    //�Ի�����
                    object vJoinDate = pGrid.GetCellValue(pIndexRow, vIndexDataColumn10);
                    string vDate = string.Empty;
                    if (iConv.ISNull(vJoinDate) == string.Empty)
                    {
                        vDate = string.Empty;
                    }
                    else if (iDate.ISDate(vJoinDate) == true)
                    {
                        vDate = iDate.ISGetDate(vJoinDate).ToString("yyyy-MM-dd");
                    }
                    else
                    {
                        vDate = string.Empty;
                    }
                    mPrinting.XLSetCell(18, 16, vDate);


                    //DateTime dJoinDate = Convert.ToDateTime(pGrid.GetCellValue(pIndexRow, vIndexDataColumn10));
                    //object vJoinDate = dJoinDate.ToString("yyyy-MM-dd", null).Replace("0001-01-01", null);
                    //mPrinting.XLSetCell(18, 16, vJoinDate);

                    //�������
                    object vRetireDate = pGrid.GetCellValue(pIndexRow, vIndexDataColumn11);
                    vDate = string.Empty;
                    if (iConv.ISNull(vRetireDate) == string.Empty)
                    {
                        vDate = string.Empty;
                    }
                    else if (iDate.ISDate(vRetireDate) == true)
                    {
                        vDate = iDate.ISGetDate(vRetireDate).ToString("yyyy-MM-dd");
                    }
                    else
                    {
                        vDate = string.Empty;
                    }
                    mPrinting.XLSetCell(18, 27, vDate);


                    //DateTime dRetireDate = Convert.ToDateTime(pGrid.GetCellValue(pIndexRow, vIndexDataColumn11));
                    //object vRetireDate1 = dRetireDate.ToString("yyyy", null);
                    //object vRetireDate2 = dRetireDate.ToString("yyyy-MM-dd", null).Replace("0001-01-01", null);
                    //if (vRetireDate1.ToString() == "0001")
                    //{
                    //    mPrinting.XLSetCell(18, 27, "");
                    //}
                    //else
                    //{
                    //    mPrinting.XLSetCell(18, 27, vRetireDate2);
                    //}

                    //�̸���
                    mPrinting.XLSetCell(20, 16, pGrid.GetCellValue(pIndexRow, vIndexDataColumn12));
                    //��ȭ��ȣ
                    mPrinting.XLSetCell(20, 27, pGrid.GetCellValue(pIndexRow, vIndexDataColumn13));
                    //�޴���ȭ
                    mPrinting.XLSetCell(20, 38, pGrid.GetCellValue(pIndexRow, vIndexDataColumn14));

                    //�ּ�
                    object vAddress = string.Format("{0} {1}", pGrid.GetCellValue(pIndexRow, vIndexDataColumn15), pGrid.GetCellValue(pIndexRow, vIndexDataColumn16));
                    mPrinting.XLSetCell(30, 5, vAddress);
                    
                }
                else if (pCnt == 2)
                {
                    int vIndexDataColumn1 = pGrid.GetColumnToIndex("BANK_NAME");      // �����  
                    int vIndexDataColumn2 = pGrid.GetColumnToIndex("BANK_ACCOUNTS");  // ���¹�ȣ
                    int vIndexDataColumn3 = pGrid.GetColumnToIndex("PAYMENT_DATE");   // ����Ⱓ
                    int vIndexDataColumn4 = pGrid.GetColumnToIndex("BASE_AMOUNT");    // ���ޱݾ� 
                    int vIndexDataColumn5 = pGrid.GetColumnToIndex("PAY_TYPE");       // �޿�����
                    object vPAY_TYPE = pGrid.GetCellValue(pIndexRow, vIndexDataColumn5);
                    if (iConv.ISNull(vPAY_TYPE) == "3")
                    {
                        mPrinting.XLSetCell(44, 33, "����");
                    }
                    else
                    {
                        mPrinting.XLSetCell(44, 33, "�⺻��");
                    }

                    //����Ⱓ
                    mPrinting.XLSetCell(45 + pIndexRow, 27, pGrid.GetCellValue(pIndexRow, vIndexDataColumn3));
                    //�⺻��
                    mPrinting.XLSetCell(45 + pIndexRow, 33, pGrid.GetCellValue(pIndexRow, vIndexDataColumn4));


                    if (pIndexRow < 1)
                    {
                        //�����
                        mPrinting.XLSetCell(18, 38, pGrid.GetCellValue(pIndexRow, vIndexDataColumn1));
                        //���¹�ȣ
                        mPrinting.XLSetCell(19, 38, pGrid.GetCellValue(pIndexRow, vIndexDataColumn2));
                    }
                }
                else if (pCnt == 3)
                {
                    int vIndexDataColumn1 = pGrid.GetColumnToIndex("SCHOLARSHIP_TYPE_NAME"); // �з�         
                    int vIndexDataColumn2 = pGrid.GetColumnToIndex("GRADUATION_YYYYMM");     // ��������
                    int vIndexDataColumn3 = pGrid.GetColumnToIndex("SCHOOL_NAME");           // ��ű�
                    int vIndexDataColumn4 = pGrid.GetColumnToIndex("SPECIAL_STUDY_NAME");    // ����                

                    //�з�
                    mPrinting.XLSetCell(24 + pIndexRow, 16, pGrid.GetCellValue(pIndexRow, vIndexDataColumn1));
                    //��������
                    mPrinting.XLSetCell(24 + pIndexRow, 5, pGrid.GetCellValue(pIndexRow, vIndexDataColumn2));
                    //��ű�
                    mPrinting.XLSetCell(24 + pIndexRow, 10, pGrid.GetCellValue(pIndexRow, vIndexDataColumn3));
                    //���� 
                    mPrinting.XLSetCell(24 + pIndexRow, 19, pGrid.GetCellValue(pIndexRow, vIndexDataColumn4));
                }
                else if (pCnt == 4)
                {
                    int vIndexDataColumn1 = pGrid.GetColumnToIndex("FAMILY_NAME");    // ����    
                    int vIndexDataColumn2 = pGrid.GetColumnToIndex("RELATION_NAME");  // ����    
                    int vIndexDataColumn3 = pGrid.GetColumnToIndex("BIRTHDAY");       // �������
                    int vIndexDataColumn4 = pGrid.GetColumnToIndex("COMPANY_NAME");   // ȸ��� 
                    int vIndexDataColumn5 = pGrid.GetColumnToIndex("END_SCH_NAME");   // �з�

                    //���� 
                    mPrinting.XLSetCell(24 + pIndexRow, 30, pGrid.GetCellValue(pIndexRow, vIndexDataColumn1));
                    //����
                    mPrinting.XLSetCell(24 + pIndexRow, 27, pGrid.GetCellValue(pIndexRow, vIndexDataColumn2));
                    //������� 
                    mPrinting.XLSetCell(24 + pIndexRow, 34, pGrid.GetCellValue(pIndexRow, vIndexDataColumn3));
                    //ȸ���
                    mPrinting.XLSetCell(24 + pIndexRow, 41, pGrid.GetCellValue(pIndexRow, vIndexDataColumn4));
                    //�з�
                    mPrinting.XLSetCell(24 + pIndexRow, 38, pGrid.GetCellValue(pIndexRow, vIndexDataColumn5));
                }
                else if (pCnt == 5)
                {
                    int vIndexDataColumn1 = pGrid.GetColumnToIndex("LICENSE_NAME");         // �ڰ�����
                    int vIndexDataColumn2 = pGrid.GetColumnToIndex("LICENSE_GRADE_NAME");   // �ڰݵ��
                    int vIndexDataColumn3 = pGrid.GetColumnToIndex("LICENSE_DATE");         // �������

                    //�ڰ�����
                    mPrinting.XLSetCell(33 + pIndexRow, 5, pGrid.GetCellValue(pIndexRow, vIndexDataColumn1));
                    //�ڰݵ��
                    mPrinting.XLSetCell(33 + pIndexRow, 12, pGrid.GetCellValue(pIndexRow, vIndexDataColumn2));
                    //�������
                    mPrinting.XLSetCell(33 + pIndexRow, 17, pGrid.GetCellValue(pIndexRow, vIndexDataColumn3));
                }
                else if (pCnt == 6)
                {
                    int vIndexDataColumn1 = pGrid.GetColumnToIndex("COMPANY_NAME");   // �ٹ�ó  
                    int vIndexDataColumn2 = pGrid.GetColumnToIndex("POST_NAME");      // ����    
                    int vIndexDataColumn3 = pGrid.GetColumnToIndex("JOB_NAME");       // ������
                    int vIndexDataColumn4 = pGrid.GetColumnToIndex("CAREER_WORK_PERIOD");     // �Ի��� ~ �����

                    //�ٹ�ó
                    mPrinting.XLSetCell(33 + pIndexRow, 33, pGrid.GetCellValue(pIndexRow, vIndexDataColumn1));
                    //����
                    mPrinting.XLSetCell(33 + pIndexRow, 38, pGrid.GetCellValue(pIndexRow, vIndexDataColumn2));
                    //������
                    mPrinting.XLSetCell(33 + pIndexRow, 41, pGrid.GetCellValue(pIndexRow, vIndexDataColumn3));
                    //�ٹ��Ⱓ
                    mPrinting.XLSetCell(33 + pIndexRow, 27, pGrid.GetCellValue(pIndexRow, vIndexDataColumn4));
                }
                else if (pCnt == 7)
                {
                    int vIndexDataColumn1 = pGrid.GetColumnToIndex("LANGUAGE_NAME");  // ���б���
                    int vIndexDataColumn2 = pGrid.GetColumnToIndex("EXAM_NAME");      // ��������
                    int vIndexDataColumn3 = pGrid.GetColumnToIndex("EXAM_LEVEL");     // ���    
                    int vIndexDataColumn4 = pGrid.GetColumnToIndex("SCORE");          // ����    

                    //���б���
                    mPrinting.XLSetCell(39 + pIndexRow, 5, pGrid.GetCellValue(pIndexRow, vIndexDataColumn1));
                    //��������
                    mPrinting.XLSetCell(39 + pIndexRow, 11, pGrid.GetCellValue(pIndexRow, vIndexDataColumn2));
                    //���
                    mPrinting.XLSetCell(39 + pIndexRow, 17, pGrid.GetCellValue(pIndexRow, vIndexDataColumn3));
                    //����
                    mPrinting.XLSetCell(39 + pIndexRow, 20, pGrid.GetCellValue(pIndexRow, vIndexDataColumn4));
                }
                else if (pCnt == 8)
                {
                    int vIndexDataColumn1 = pGrid.GetColumnToIndex("RP_TYPE_NAME");    // �������
                    int vIndexDataColumn2 = pGrid.GetColumnToIndex("RP_NAME");         // �������
                    int vIndexDataColumn3 = pGrid.GetColumnToIndex("RP_DATE");         // �������
                    int vIndexDataColumn4 = pGrid.GetColumnToIndex("RP_DESCRIPTION");  // �������

                    //�������
                    mPrinting.XLSetCell(39 + pIndexRow, 33, pGrid.GetCellValue(pIndexRow, vIndexDataColumn1));
                    //�������
                    mPrinting.XLSetCell(39 + pIndexRow, 37, pGrid.GetCellValue(pIndexRow, vIndexDataColumn2));
                    //�������
                    mPrinting.XLSetCell(39 + pIndexRow, 27, pGrid.GetCellValue(pIndexRow, vIndexDataColumn3));
                    //�������
                    mPrinting.XLSetCell(39 + pIndexRow, 41, pGrid.GetCellValue(pIndexRow, vIndexDataColumn4));
                }
                else if (pCnt == 9)  // �������� //
                {
                    int vIndexDataColumn1 = pGrid.GetColumnToIndex("EDUCATION_PERIOD");// �����Ⱓ
                    int vIndexDataColumn2 = pGrid.GetColumnToIndex("EDU_ORG");         // ��������
                    int vIndexDataColumn3 = pGrid.GetColumnToIndex("EDU_CURRICULUM");  // ��������

                    //�����Ⱓ
                    mPrinting.XLSetCell(45 + pIndexRow, 11, pGrid.GetCellValue(pIndexRow, vIndexDataColumn1));
                    //��������
                    mPrinting.XLSetCell(45 + pIndexRow, 5, pGrid.GetCellValue(pIndexRow, vIndexDataColumn2));
                    //��������
                    mPrinting.XLSetCell(45 + pIndexRow, 18, pGrid.GetCellValue(pIndexRow, vIndexDataColumn3));
                }
                else if (pCnt == 10)
                {
                    int vIndexDataColumn1 = pGrid.GetColumnToIndex("CHARGE_DATE");    // �߷�����
                    int vIndexDataColumn2 = pGrid.GetColumnToIndex("CHARGE_NAME");    // �߷�    
                    int vIndexDataColumn3 = pGrid.GetColumnToIndex("DESCRIPTION");    // ���    
                    int vIndexDataColumn4 = pGrid.GetColumnToIndex("DEPT_NAME");      // �μ�    
                    int vIndexDataColumn5 = pGrid.GetColumnToIndex("POST_NAME");      // ����    
                    int vIndexDataColumn6 = pGrid.GetColumnToIndex("ABIL_NAME");      // ��å    
                    int vIndexDataColumn7 = pGrid.GetColumnToIndex("PAY_GRADE_NAME"); // ����    

                    //�߷�����
                    mPrinting.XLSetCell(51 + pIndexRow, 5, pGrid.GetCellValue(pIndexRow, vIndexDataColumn1));
                    //�߷�
                    mPrinting.XLSetCell(51 + pIndexRow, 12, pGrid.GetCellValue(pIndexRow, vIndexDataColumn2));
                    //���
                    mPrinting.XLSetCell(51 + pIndexRow, 39, pGrid.GetCellValue(pIndexRow, vIndexDataColumn3));
                    //�μ�
                    mPrinting.XLSetCell(51 + pIndexRow, 18, pGrid.GetCellValue(pIndexRow, vIndexDataColumn4));
                    //����
                    mPrinting.XLSetCell(51 + pIndexRow, 31, pGrid.GetCellValue(pIndexRow, vIndexDataColumn5));
                    //��å
                    mPrinting.XLSetCell(51 + pIndexRow, 23, pGrid.GetCellValue(pIndexRow, vIndexDataColumn6));
                    //����
                    mPrinting.XLSetCell(51 + pIndexRow, 27, pGrid.GetCellValue(pIndexRow, vIndexDataColumn7));
                }
                else if (pCnt == 11)
                {
                    int vIndexDataColumn1 = pGrid.GetColumnToIndex("ARMY_KIND_NAME");     // ����
                    int vIndexDataColumn2 = pGrid.GetColumnToIndex("ARMY_GRADE_NAME");    // ��� 
                    int vIndexDataColumn3 = pGrid.GetColumnToIndex("ARMY_END_TYPE_NAME"); // ��������
                    //int vIndexDataColumn4 = pGrid.GetColumnToIndex("DESCRIPTION");      // ����

                    // �����׸� - ����, ���, ��������
                    object vArmyInfo = pGrid.GetCellValue(pIndexRow, vIndexDataColumn1).ToString() + ", "
                                     + pGrid.GetCellValue(pIndexRow, vIndexDataColumn2).ToString() + ", "
                                     + pGrid.GetCellValue(pIndexRow, vIndexDataColumn3).ToString();

                    mPrinting.XLSetCell(29 + pIndexRow, 19, vArmyInfo);

                    //����
                    //mPrinting.XLSetCell(28 + pIndexRow, 5, pGrid.GetCellValue(pIndexRow, vIndexDataColumn4));
                }
                else if (pCnt == 12)
                {
                    int vIndexDataColumn1 = pGrid.GetColumnToIndex("HEIGHT");         // Ű    
                    int vIndexDataColumn2 = pGrid.GetColumnToIndex("WEIGHT");         // ������
                    int vIndexDataColumn3 = pGrid.GetColumnToIndex("BLOOD_NAME");     // ������
                    int vIndexDataColumn4 = pGrid.GetColumnToIndex("DISABLED_NAME");  // ���
                    int vIndexDataColumn5 = pGrid.GetColumnToIndex("DESCRIPTION");    // ����
                    
                    // ��ü�׸� - Ű, ������, ������
                    object vBodyInfo = pGrid.GetCellValue(pIndexRow, vIndexDataColumn1).ToString() + "cm, "
                                     + pGrid.GetCellValue(pIndexRow, vIndexDataColumn2).ToString() + "kg, "
                                     + pGrid.GetCellValue(pIndexRow, vIndexDataColumn3).ToString();

                    mPrinting.XLSetCell(29 + pIndexRow, 5, vBodyInfo);

                    //���
                    mPrinting.XLSetCell(28 + pIndexRow, 19, pGrid.GetCellValue(pIndexRow, vIndexDataColumn4));
                    //����
                    mPrinting.XLSetCell(28 + pIndexRow, 5, pGrid.GetCellValue(pIndexRow, vIndexDataColumn5));
                }
            }
            catch (System.Exception ex)
            {
                mMessageError = string.Format("{0}", ex.Message);
            }
        }

        #endregion;

        #region ----- Excel Open and Close ----

        public void XLOpenClose()
        {
            mPrinting.XLOpenFileClose();

            XLFileOpen();
        }
        #endregion;

        #region ----- Excel Wirte Methods ----

        public void XLWirte(InfoSummit.Win.ControlAdv.ISGridAdvEx pGrid, int pRow, int pTerritory, string pPrintDateTime, string pUserName, string pImageName, int pCnt)
        {
            string vMessageText = string.Empty;

            //int vPageNumber = 0;
            int vTotalRow = pGrid.RowCount; // Grid�� �� ���

            try
            {               
                if (pCnt == 1)
                {
                    for (int vRow = 0; vRow <= pRow; vRow++)
                    {
                        //vPageNumber++;

                        //[Content_Printing]
                        XLContentWrite(pGrid, vRow, pRow, pCnt, pPrintDateTime, pUserName);
                    }
                }
 
                if (pCnt != 1)
                {
                    for (int vRow = 0; vRow < vTotalRow; vRow++)
                    {
                        //vPageNumber++;

                        //[Content_Printing]
                        XLContentWrite(pGrid, vRow, vTotalRow, pCnt, pPrintDateTime, pUserName);
                    }
                }

                if (pCnt == 12) // 12��° ������ Grid�� ���,
                {
                    //----------------------------------------[ ������� ��� �κ� ]------------------------------------------
                    if (pRow != 0)
                    {
                        int vIndexImage = mPrinting.CountBarCodeImage;
                        int vCountImage = mPrinting.CountBarCodeImage;
                        for (int vRow = 0; vRow < vCountImage; vRow++)
                        {
                            mPrinting.XLDeleteBarCode(vIndexImage);
                            vIndexImage--;
                        }

                        mPrinting.CountBarCodeImage = 0;
                    }

                    System.Drawing.SizeF vSize = new System.Drawing.SizeF(95.2283F, 110.99701F);
                    System.Drawing.PointF vPoint = new System.Drawing.PointF(25F, 125F);
                    mPrinting.XLBarCode(pImageName, vSize, vPoint);
                    //--------------------------------------------------------------------------------------------------------

                    //�λ系�� ������ �׸���� ������ִ� �Լ� ȣ��
                    ReportTitle();

                    //���� �ϴܿ� ��� ���� ǥ��
                    mPrinting.XLSetCell(65, 31, pUserName);
                    mPrinting.XLSetCell(65, 41, pPrintDateTime);

                    //[Sheet2]������ [Sheet1]�� �ٿ��ֱ�
                    mSumPrintingLineCopy = CopyAndPaste(mSumPrintingLineCopy);

                    //-------------------------------------------------------------------------------------------------------
                    // ������ ���� ���� �κ�
                    // (SourceTab1�� ������ ��� -> Destination�� ���� -> SourceTab1 ������ ���� ��, ���� ������ ��� 
                    //-------------------------------------------------------------------------------------------------------
                    mPrinting.XLActiveSheet("SourceTab1");
                    int vStartRow = mPositionPrintLineSTART; //���� �� ��ġ ����
                    int vStartCol = mXLColumnAreaSTART;  // +1
                    int vEndRow = mMaxIncrementCopy; // -2
                    int vEndCol = mXLColumnAreaEND;  // -1
                    mPrinting.XLSetCell(vStartRow, vStartCol, vEndRow, vEndCol, null);                  
                }
            }
            catch
            {
                mPrinting.XLOpenFileClose();
                mPrinting.XLClose();
            }
        }

        #endregion;

        #region ----- Excel Copy&Paste Methods ----

        //[Sheet2]������ [Sheet1]�� �ٿ��ֱ�
        private int CopyAndPaste(int pCopySumPrintingLine)
        {
            int vPrintHeaderColumnSTART = mXLColumnAreaSTART; //����Ǿ��� ��Ʈ�� ��, ���ۿ�
            int vPrintHeaderColumnEND = mXLColumnAreaEND;     //����Ǿ��� ��Ʈ�� ��, ���῭

            int vCopySumPrintingLine = 0;
            vCopySumPrintingLine = pCopySumPrintingLine;

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
            //mPrinting.XLPrintPreview();
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

    }
}
#endregion;