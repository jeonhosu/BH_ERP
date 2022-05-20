using System;

namespace HRMF0522
{
    public class XLPrinting
    {
        #region ----- Variables -----

        private InfoSummit.Win.ControlAdv.ISAppInterface mAppInterface = null;
        private InfoSummit.Win.ControlAdv.ISMessageAdapter mMessageAdapter = null;

        private XL.XLPrint mPrinting = null;

        private string mMessageError = string.Empty;

        //private int mPageTotalNumber = 0;
        private int mPageNumber = 0;

        //private bool mIsNewPage = false;

        private string mXLOpenFileName = string.Empty;

        private int mPrintingLineSTART = 1;  //Line

        private int mCopyLineSUM = 1;        //������ ���õ� ��Ʈ�� ����Ǿ��� ���� �� ��ġ, ���� �� ����
        private int mIncrementCopyMAX = 72;  //����Ǿ��� ���� ����

        private int mCopyColumnSTART = 1; //����Ǿ�  �� �� ���� ��
        private int mCopyColumnEND = 45;  //������ ���õ� ��Ʈ�� ����Ǿ��� �� �� ��ġ

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

        private void SetArray1(System.Data.DataTable pTable, out int[] pGDColumn, out int[] pXLColumn)
        {
            pGDColumn = new int[2];
            pXLColumn = new int[2];

            pGDColumn[0] = pTable.Columns.IndexOf("ALLOWANCE_NAME");       //�޿� ���޸�
            pGDColumn[1] = pTable.Columns.IndexOf("ALLOWANCE_AMOUNT");     //�޿� ���ޱݾ�

            pXLColumn[0] = 6;    //�޿� ���޸�
            pXLColumn[1] = 15;   //�޿� ���޸��
        }

        #endregion;

        #region ----- Array Set 2 ----

        private void SetArray2(System.Data.DataTable pTable, out int[] pGDColumn, out int[] pXLColumn)
        {
            pGDColumn = new int[2];
            pXLColumn = new int[2];

            pGDColumn[0] = pTable.Columns.IndexOf("DEDUCTION_NAME");       //�޿� ������
            pGDColumn[1] = pTable.Columns.IndexOf("DEDUCTION_AMOUNT");     //�޿� �����ݾ�

            pXLColumn[0] = 25;   //�޿� ������
            pXLColumn[1] = 34;   //�޿� �����ݾ�
        }

        #endregion;

        #region ----- Array Set 3 ----

        private void SetArray3(System.Data.DataTable pTable, out int[] pGDColumn, out int[] pXLColumn)
        {
            pGDColumn = new int[2];
            pXLColumn = new int[2];

            pGDColumn[0] = pTable.Columns.IndexOf("ALLOWANCE_NAME");       //�� ���޸�
            pGDColumn[1] = pTable.Columns.IndexOf("ALLOWANCE_AMOUNT");     //�� ���ޱݾ�

            pXLColumn[0] = 6;    //�� ���޸�
            pXLColumn[1] = 15;   //�� ���޸��
        }

        #endregion;

        #region ----- Array Set 4 ----

        private void SetArray4(System.Data.DataTable pTable, out int[] pGDColumn, out int[] pXLColumn)
        {
            pGDColumn = new int[2];
            pXLColumn = new int[2];

            pGDColumn[0] = pTable.Columns.IndexOf("DEDUCTION_NAME");       //�� ������
            pGDColumn[1] = pTable.Columns.IndexOf("DEDUCTION_AMOUNT");     //�� �����ݾ�

            pXLColumn[0] = 25;   //�� ������
            pXLColumn[1] = 34;   //�� �����ݾ�
        }

        #endregion;

        #region ----- Array Set 5 ----

        private void SetArray5(System.Data.DataTable pTable, out int[] pGDColumn, out int[] pXLColumn)
        {
            pGDColumn = new int[17];
            pXLColumn = new int[17];

            pGDColumn[0] = pTable.Columns.IndexOf("TOTAL_ATT_TIME");        //�⺻�ٹ��ð� 
            pGDColumn[1] = pTable.Columns.IndexOf("OVER_TIME");             //����ٹ�  
            pGDColumn[2] = pTable.Columns.IndexOf("NIGHT_BONUS_TIME");      //�߰��ٹ�
            pGDColumn[3] = pTable.Columns.IndexOf("HOLIDAY_TIME");          //���ϱٹ�
            pGDColumn[4] = pTable.Columns.IndexOf("HOLIDAY_OVER_TIME");     //���Ͽ���ٹ� 
            pGDColumn[5] = pTable.Columns.IndexOf("LATE_TIME");             //���°��� 
            pGDColumn[6] = pTable.Columns.IndexOf("CREATION_NUM");          //�߻����� 
            pGDColumn[7] = pTable.Columns.IndexOf("REMAIN_NUM");            //�ܿ����� 
            pGDColumn[8] = pTable.Columns.IndexOf("BASE_AMOUNT");           //�⺻�� 
            pGDColumn[9] = pTable.Columns.IndexOf("TOTAL_ATT_DAY");         //�ٹ��ϼ� 
            pGDColumn[10] = pTable.Columns.IndexOf("S_HOLY_1_COUNT");       //�����ϼ� 
            pGDColumn[11] = pTable.Columns.IndexOf("H_HOLY_1_COUNT");       //�����ϼ� 
            pGDColumn[12] = pTable.Columns.IndexOf("HOLY_0_COUNT");         //�����ϼ� 
            pGDColumn[13] = pTable.Columns.IndexOf("DUTY_11");              //��� 
            pGDColumn[14] = pTable.Columns.IndexOf("LATE_DED_COUNT");       //����/����ȸ�� 
            pGDColumn[15] = pTable.Columns.IndexOf("THIS_DUTY_20_NUM");     //�����뿬����
            pGDColumn[16] = pTable.Columns.IndexOf("USE_NUM");              //������뿬����

            pXLColumn[0] = 4;       //�⺻�ٹ��ð�
            pXLColumn[1] = 9;       //����ٹ�
            pXLColumn[2] = 14;      //�߰��ٹ�
            pXLColumn[3] = 19;      //���ϱٹ�
            pXLColumn[4] = 24;      //���Ͽ���ٹ�
            pXLColumn[5] = 29;      //���°���
            pXLColumn[6] = 34;      //�߻����� 
            pXLColumn[7] = 39;      //�ܿ�����
            pXLColumn[8] = 4;       //�⺻��
            pXLColumn[9] = 8;       //�ٹ��ϼ�
            pXLColumn[10] = 12;     //�����ϼ� 
            pXLColumn[11] = 16;     //�����ϼ� 
            pXLColumn[12] = 20;     //�����ϼ� 
            pXLColumn[13] = 24;     //���
            pXLColumn[14] = 29;     //����/����ȸ�� 
            pXLColumn[15] = 34;     //�����뿬����
            pXLColumn[16] = 39;     //������뿬����
        }

        #endregion;

        #region ----- Array Set 6 ----

        private void SetArray6(InfoSummit.Win.ControlAdv.ISGridAdvEx pGrid, out int[] pGDColumn, out int[] pXLColumn)
        {
            pGDColumn = new int[27];
            pXLColumn = new int[26];

            pGDColumn[0] = pGrid.GetColumnToIndex("WAGE_TYPE_NAME");            //Title
            pGDColumn[1] = pGrid.GetColumnToIndex("DEPT_NAME");                 //�μ�
            pGDColumn[2] = pGrid.GetColumnToIndex("POST_NAME");                 //����
            pGDColumn[3] = pGrid.GetColumnToIndex("PERSON_NUM");                //���
            pGDColumn[4] = pGrid.GetColumnToIndex("NAME");                      //�̸�

            pGDColumn[5] = pGrid.GetColumnToIndex("NAME");                      //����
            pGDColumn[6] = pGrid.GetColumnToIndex("PERSON_NUM");                //���
            pGDColumn[7] = pGrid.GetColumnToIndex("DEPT_NAME");                 //�μ�
            pGDColumn[8] = pGrid.GetColumnToIndex("POST_NAME");                 //����
            pGDColumn[9] = pGrid.GetColumnToIndex("JOB_CLASS_NAME");            //����
            pGDColumn[10] = pGrid.GetColumnToIndex("SUPPLY_DATE");              //������
            pGDColumn[11] = pGrid.GetColumnToIndex("BANK_NAME");                //�Ա�����
            pGDColumn[12] = pGrid.GetColumnToIndex("BANK_ACCOUNTS");            //�Աݰ���

            pGDColumn[13] = pGrid.GetColumnToIndex("BASIC_AMOUNT");             //�⺻��
            pGDColumn[14] = pGrid.GetColumnToIndex("HOURLY_AMOUNT");            //�ñ�
            pGDColumn[15] = pGrid.GetColumnToIndex("GENERAL_HOURLY_AMOUNT");    //���ñ�

            pGDColumn[16] = pGrid.GetColumnToIndex("TOT_PAY_DED_AMOUNT");       //�޿� �Ѱ�����
            pGDColumn[17] = pGrid.GetColumnToIndex("TOT_PAY_SUP_AMOUNT");       //�޿� �����޾�
            pGDColumn[18] = pGrid.GetColumnToIndex("REAL_PAY_AMOUNT");          //�޿� �����޾�

            pGDColumn[19] = pGrid.GetColumnToIndex("TOT_BONUS_DED_AMOUNT");     //�� �Ѱ�����
            pGDColumn[20] = pGrid.GetColumnToIndex("TOT_BONUS_SUP_AMOUNT");     //�� �����޾�
            pGDColumn[21] = pGrid.GetColumnToIndex("REAL_BONUS_AMOUNT");        //�� �����޾�

            pGDColumn[22] = pGrid.GetColumnToIndex("TOT_SUPPLY_AMOUNT");        //�����޾�
            pGDColumn[23] = pGrid.GetColumnToIndex("TOT_DED_AMOUNT");           //�Ѱ�����
            pGDColumn[24] = pGrid.GetColumnToIndex("REAL_AMOUNT");              //�� �����޾�

            pGDColumn[25] = pGrid.GetColumnToIndex("DESCRIPTION");              //���
            pGDColumn[26] = pGrid.GetColumnToIndex("NOTIFICATION");             //�˸�

            pXLColumn[0] = 4;       //Title
            pXLColumn[1] = 8;       //�μ�
            pXLColumn[2] = 8;       //����
            pXLColumn[3] = 8;       //���
            pXLColumn[4] = 8;       //�̸�

            pXLColumn[5] = 9;       //����
            pXLColumn[6] = 22;      //���
            pXLColumn[7] = 36;      //�μ�
            pXLColumn[8] = 9;       //����
            pXLColumn[9] = 22;      //����
            pXLColumn[10] = 36;     //������
            pXLColumn[11] = 9;      //�Ա�����
            pXLColumn[12] = 22;     //�Աݰ���

            pXLColumn[13] = 32;     //�⺻��
            pXLColumn[14] = 36;     //�ñ�
            pXLColumn[15] = 40;     //���ñ�

            pXLColumn[16] = 34;     //�޿� �Ѱ�����
            pXLColumn[17] = 15;     //�޿� �����޾�
            pXLColumn[18] = 34;     //�޿� �����޾�

            pXLColumn[19] = 34;     //�� �Ѱ�����
            pXLColumn[20] = 15;     //�� �����޾�
            pXLColumn[21] = 34;     //�� �����޾�

            pXLColumn[22] = 15;     //�����޾�
            pXLColumn[23] = 34;     //�Ѱ�����
            pXLColumn[24] = 25;     //�� �����޾�

            pXLColumn[25] = 4;      //���
        }

        #endregion;

        #region ----- Convert String Method ----

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
                mAppInterface.OnAppMessageEvent(ex.Message);
                System.Windows.Forms.Application.DoEvents();
            }

            return vString;
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

        #region ----- Line Write 1 Method -----

        //�޿� ����
        private int XLLine_1(System.Data.DataRow pRow, int pXLine, int[] pGDColumn, int[] pXLColumn)
        {
            int vXLine = pXLine; //������ ������ ǥ�õǴ� �� ��ȣ

            int vDBColumnIndex = 0;
            int vXLColumnIndex = 0;

            object vObject = null;
            string vConvertString = string.Empty;
            decimal vConvertDecimal = 0m;
            bool IsConvert = false;

            try
            {
                mPrinting.XLActiveSheet("Destination");

                //�޿� ���޸�
                vDBColumnIndex = pGDColumn[0];
                vXLColumnIndex = pXLColumn[0];
                vObject = pRow[vDBColumnIndex];
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

                //�޿� ���ޱݾ�
                vDBColumnIndex = pGDColumn[1];
                vXLColumnIndex = pXLColumn[1];
                vObject = pRow[vDBColumnIndex];
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#}", vConvertDecimal);
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

        #region ----- Line Write 2 Method -----

        //�޿� ����
        private int XLLine_2(System.Data.DataRow pRow, int pXLine, int[] pGDColumn, int[] pXLColumn)
        {
            int vXLine = pXLine; //������ ������ ǥ�õǴ� �� ��ȣ

            int vDBColumnIndex = 0;
            int vXLColumnIndex = 0;

            object vObject = null;
            string vConvertString = string.Empty;
            decimal vConvertDecimal = 0m;
            bool IsConvert = false;

            try
            {
                mPrinting.XLActiveSheet("Destination");

                //�޿� ������
                vDBColumnIndex = pGDColumn[0];
                vXLColumnIndex = pXLColumn[0];
                vObject = pRow[vDBColumnIndex];
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

                //�޿� �����ݾ�
                vDBColumnIndex = pGDColumn[1];
                vXLColumnIndex = pXLColumn[1];
                vObject = pRow[vDBColumnIndex];
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#}", vConvertDecimal);
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

        #region ----- Line Write 3 Method -----

        //�� ����
        private int XLLine_3(System.Data.DataRow pRow, int pXLine, int[] pGDColumn, int[] pXLColumn)
        {
            int vXLine = pXLine; //������ ������ ǥ�õǴ� �� ��ȣ

            int vDBColumnIndex = 0;
            int vXLColumnIndex = 0;

            object vObject = null;
            string vConvertString = string.Empty;
            decimal vConvertDecimal = 0m;
            bool IsConvert = false;

            try
            {
                mPrinting.XLActiveSheet("Destination");

                //�� ���޸�
                vDBColumnIndex = pGDColumn[0];
                vXLColumnIndex = pXLColumn[0];
                vObject = pRow[vDBColumnIndex];
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

                //�� ���ޱݾ�
                vDBColumnIndex = pGDColumn[1];
                vXLColumnIndex = pXLColumn[1];
                vObject = pRow[vDBColumnIndex];
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#}", vConvertDecimal);
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

        #region ----- Line Write 4 Method -----

        //�� ����
        private int XLLine_4(System.Data.DataRow pRow, int pXLine, int[] pGDColumn, int[] pXLColumn)
        {
            int vXLine = pXLine; //������ ������ ǥ�õǴ� �� ��ȣ

            int vDBColumnIndex = 0;
            int vXLColumnIndex = 0;

            object vObject = null;
            string vConvertString = string.Empty;
            decimal vConvertDecimal = 0m;
            bool IsConvert = false;

            try
            {
                mPrinting.XLActiveSheet("Destination");

                //�� ������
                vDBColumnIndex = pGDColumn[0];
                vXLColumnIndex = pXLColumn[0];
                vObject = pRow[vDBColumnIndex];
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

                //�� �����ݾ�
                vDBColumnIndex = pGDColumn[1];
                vXLColumnIndex = pXLColumn[1];
                vObject = pRow[vDBColumnIndex];
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#}", vConvertDecimal);
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

        #region ----- Line Write 5 Method -----

        //�ٹ��ð� �� �ΰ�����
        private int XLLine_5(System.Data.DataRow pRow, int pXLine, int[] pGDColumn, int[] pXLColumn)
        {
            int vXLine = pXLine; //������ ������ ǥ�õǴ� �� ��ȣ

            int vDBColumnIndex = 0;
            int vXLColumnIndex = 0;

            object vObject = null;
            string vConvertString = string.Empty;
            decimal vConvertDecimal = 0m;
            bool IsConvert = false;

            try
            {
                mPrinting.XLActiveSheet("Destination");

                //�⺻�ٹ�
                vDBColumnIndex = pGDColumn[0];
                vXLColumnIndex = pXLColumn[0];
                vObject = pRow[vDBColumnIndex];
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    if (vConvertDecimal != 0)
                    {
                        vConvertString = string.Format("{0:#,##0.###}", vConvertDecimal);
                    }
                    else
                    {
                        vConvertString = string.Empty;
                    }
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                //����ٹ� 
                vDBColumnIndex = pGDColumn[1];
                vXLColumnIndex = pXLColumn[1];
                vObject = pRow[vDBColumnIndex];
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    if (vConvertDecimal != 0)
                    {
                        vConvertString = string.Format("{0:#,##0.###}", vConvertDecimal);
                    }
                    else
                    {
                        vConvertString = string.Empty;
                    }
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                //�߰��ٹ� 
                vDBColumnIndex = pGDColumn[2];
                vXLColumnIndex = pXLColumn[2];
                vObject = pRow[vDBColumnIndex];
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    if (vConvertDecimal != 0)
                    {
                        vConvertString = string.Format("{0:#,##0.###}", vConvertDecimal);
                    }
                    else
                    {
                        vConvertString = string.Empty;
                    }
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                //���ϱٹ�
                vDBColumnIndex = pGDColumn[3];
                vXLColumnIndex = pXLColumn[3];
                vObject = pRow[vDBColumnIndex];
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    if (vConvertDecimal != 0)
                    {
                        vConvertString = string.Format("{0:#,##0.###}", vConvertDecimal);
                    }
                    else
                    {
                        vConvertString = string.Empty;
                    }
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                //���Ͽ���ٹ�
                vDBColumnIndex = pGDColumn[4];
                vXLColumnIndex = pXLColumn[4];
                vObject = pRow[vDBColumnIndex];
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    if (vConvertDecimal != 0)
                    {
                        vConvertString = string.Format("{0:#,##0.###}", vConvertDecimal);
                    }
                    else
                    {
                        vConvertString = string.Empty;
                    }
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                //���°���
                vDBColumnIndex = pGDColumn[5];
                vXLColumnIndex = pXLColumn[5];
                vObject = pRow[vDBColumnIndex];
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    if (vConvertDecimal != 0)
                    {
                        vConvertString = string.Format("{0:#,##0.###}", vConvertDecimal);
                    }
                    else
                    {
                        vConvertString = string.Empty;
                    }
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                //�߻�����
                vDBColumnIndex = pGDColumn[6];
                vXLColumnIndex = pXLColumn[6];
                vObject = pRow[vDBColumnIndex];
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    if (vConvertDecimal != 0)
                    {
                        vConvertString = string.Format("{0:#,##0.###}", vConvertDecimal);
                    }
                    else
                    {
                        vConvertString = string.Empty;
                    }
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                //�ܿ�����
                vDBColumnIndex = pGDColumn[7];
                vXLColumnIndex = pXLColumn[7];
                vObject = pRow[vDBColumnIndex];
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    if (vConvertDecimal != 0)
                    {
                        vConvertString = string.Format("{0:#,##0.###}", vConvertDecimal);
                    }
                    else
                    {
                        vConvertString = string.Empty;
                    }
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                //-------------------------------------------------------------------
                vXLine = vXLine + 4;
                //-------------------------------------------------------------------

                //�⺻�ϱ�
                vDBColumnIndex = pGDColumn[8];
                vXLColumnIndex = pXLColumn[8];
                vObject = pRow[vDBColumnIndex];
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    if (vConvertDecimal != 0)
                    {
                        vConvertString = string.Format("{0:##,###,##0}", vConvertDecimal);
                    }
                    else
                    {
                        vConvertString = string.Empty;
                    }
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                //�ٹ��ϼ�
                vDBColumnIndex = pGDColumn[9];
                vXLColumnIndex = pXLColumn[9];
                vObject = pRow[vDBColumnIndex];
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:##,###,###}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                //�����ϼ�
                vDBColumnIndex = pGDColumn[10];
                vXLColumnIndex = pXLColumn[10];
                vObject = pRow[vDBColumnIndex];
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:##,###,###}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                //�����ϼ�
                vDBColumnIndex = pGDColumn[11];
                vXLColumnIndex = pXLColumn[11];
                vObject = pRow[vDBColumnIndex];
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:##,###,###}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                //�����ϼ�
                vDBColumnIndex = pGDColumn[12];
                vXLColumnIndex = pXLColumn[12];
                vObject = pRow[vDBColumnIndex];
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:##,###,###}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                //���
                vDBColumnIndex = pGDColumn[13];
                vXLColumnIndex = pXLColumn[13];
                vObject = pRow[vDBColumnIndex];
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:##,###,###}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                //����/����/����
                vDBColumnIndex = pGDColumn[14];
                vXLColumnIndex = pXLColumn[14];
                vObject = pRow[vDBColumnIndex];
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:##,###,###}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                //�����뿬��
                vDBColumnIndex = pGDColumn[15];
                vXLColumnIndex = pXLColumn[15];
                vObject = pRow[vDBColumnIndex];
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:##,###,###}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                //������뿬��
                vDBColumnIndex = pGDColumn[16];
                vXLColumnIndex = pXLColumn[16];
                vObject = pRow[vDBColumnIndex];
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:##,###,###}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
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

        #region ----- Line Write 6 Method -----
        
        //Heaer �� ��������, �ѱݾ�
        private int XLLine_6(InfoSummit.Win.ControlAdv.ISGridAdvEx pGrid, int pGridRow, int pXLine, int[] pGDColumn, int[] pXLColumn, string pCourse)
        {
            int vXLine = pXLine; //������ ������ ǥ�õǴ� �� ��ȣ

            int vGDColumnIndex = 0;
            int vXLColumnIndex = 0;

            object vObject = null;
            string vConvertString = string.Empty;
            decimal vConvertDecimal = 0m;
            System.DateTime vConvertDateTime = new System.DateTime();
            bool IsConvert = false;

            try
            {
                mPrinting.XLActiveSheet("Destination");

                //Title
                vGDColumnIndex = pGDColumn[0];
                vXLColumnIndex = pXLColumn[0];
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
                vXLine = vXLine + 10;
                //-------------------------------------------------------------------

                //�μ�
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

                //-------------------------------------------------------------------
                vXLine = vXLine + 2;
                //-------------------------------------------------------------------

                //����
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

                //-------------------------------------------------------------------
                vXLine = vXLine + 2;
                //-------------------------------------------------------------------

                //���
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

                //-------------------------------------------------------------------
                vXLine = vXLine + 2;
                //-------------------------------------------------------------------

                //�̸�
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

                //-------------------------------------------------------------------
                vXLine = vXLine + 9;
                //-------------------------------------------------------------------

                //����
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

                //���
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

                //�μ�
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

                //-------------------------------------------------------------------
                vXLine = vXLine + 1;
                //-------------------------------------------------------------------

                //����
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

                //����
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

                //������
                vGDColumnIndex = pGDColumn[10];
                vXLColumnIndex = pXLColumn[10];
                vObject = pGrid.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertDate(vObject, out vConvertDateTime);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0}", vConvertDateTime.ToShortDateString());
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

                //�Ա�����
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

                //�Աݰ���
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

                //-------------------------------------------------------------------
                vXLine = vXLine + 10;
                //-------------------------------------------------------------------

                ////�⺻��
                //vGDColumnIndex = pGDColumn[13];
                //vXLColumnIndex = pXLColumn[13];
                //vObject = pGrid.GetCellValue(pGridRow, vGDColumnIndex);
                //IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                //if (IsConvert == true)
                //{
                //    vConvertString = string.Format("{0:#}", vConvertDecimal);
                //    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                //}
                //else
                //{
                //    vConvertString = string.Empty;
                //    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                //}

                ////�ñ�
                //vGDColumnIndex = pGDColumn[14];
                //vXLColumnIndex = pXLColumn[14];
                //vObject = pGrid.GetCellValue(pGridRow, vGDColumnIndex);
                //IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                //if (IsConvert == true)
                //{
                //    vConvertString = string.Format("{0:#}", vConvertDecimal);
                //    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                //}
                //else
                //{
                //    vConvertString = string.Empty;
                //    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                //}

                ////���ñ�
                //vGDColumnIndex = pGDColumn[15];
                //vXLColumnIndex = pXLColumn[15];
                //vObject = pGrid.GetCellValue(pGridRow, vGDColumnIndex);
                //IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                //if (IsConvert == true)
                //{
                //    vConvertString = string.Format("{0:#}", vConvertDecimal);
                //    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                //}
                //else
                //{
                //    vConvertString = string.Empty;
                //    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                //}

                if (pCourse == "DAILY")
                {
                    //-------------------------------------------------------------------
                    vXLine = vXLine + 15;
                    //-------------------------------------------------------------------

                    //�޿�_�Ѱ�����
                    vGDColumnIndex = pGDColumn[16];
                    vXLColumnIndex = pXLColumn[16];
                    vObject = pGrid.GetCellValue(pGridRow, vGDColumnIndex);
                    IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                    if (IsConvert == true)
                    {
                        vConvertString = string.Format("{0:#}", vConvertDecimal);
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

                    //�޿�_�����޾�
                    vGDColumnIndex = pGDColumn[17];
                    vXLColumnIndex = pXLColumn[17];
                    vObject = pGrid.GetCellValue(pGridRow, vGDColumnIndex);
                    IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                    if (IsConvert == true)
                    {
                        vConvertString = string.Format("{0:#}", vConvertDecimal);
                        mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                    }
                    else
                    {
                        vConvertString = string.Empty;
                        mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                    }

                    //�޿�_�����޾�
                    vGDColumnIndex = pGDColumn[18];
                    vXLColumnIndex = pXLColumn[18];
                    vObject = pGrid.GetCellValue(pGridRow, vGDColumnIndex);
                    IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                    if (IsConvert == true)
                    {
                        vConvertString = string.Format("{0:#}", vConvertDecimal);
                        mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                    }
                    else
                    {
                        vConvertString = string.Empty;
                        mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                    }

                    //-------------------------------------------------------------------
                    vXLine = vXLine + 6;
                    //-------------------------------------------------------------------

                    //��_�Ѱ�����
                    vGDColumnIndex = pGDColumn[19];
                    vXLColumnIndex = pXLColumn[19];
                    vObject = pGrid.GetCellValue(pGridRow, vGDColumnIndex);
                    IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                    if (IsConvert == true)
                    {
                        vConvertString = string.Format("{0:#}", vConvertDecimal);
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

                    //��_�����޾�
                    vGDColumnIndex = pGDColumn[20];
                    vXLColumnIndex = pXLColumn[20];
                    vObject = pGrid.GetCellValue(pGridRow, vGDColumnIndex);
                    IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                    if (IsConvert == true)
                    {
                        vConvertString = string.Format("{0:#}", vConvertDecimal);
                        mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                    }
                    else
                    {
                        vConvertString = string.Empty;
                        mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                    }

                    //��_�����޾�
                    vGDColumnIndex = pGDColumn[21];
                    vXLColumnIndex = pXLColumn[21];
                    vObject = pGrid.GetCellValue(pGridRow, vGDColumnIndex);
                    IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                    if (IsConvert == true)
                    {
                        vConvertString = string.Format("{0:#}", vConvertDecimal);
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
                else if (pCourse == "MONTH")
                {
                    //-------------------------------------------------------------------
                    vXLine = vXLine + 24;
                    //-------------------------------------------------------------------
                }

                //�����޾�
                vGDColumnIndex = pGDColumn[22];
                vXLColumnIndex = pXLColumn[22];
                vObject = pGrid.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                //�Ѱ�����
                vGDColumnIndex = pGDColumn[23];
                vXLColumnIndex = pXLColumn[23];
                vObject = pGrid.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#}", vConvertDecimal);
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

                //��_�����޾�
                vGDColumnIndex = pGDColumn[24];
                vXLColumnIndex = pXLColumn[24];
                vObject = pGrid.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:#}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                //-------------------------------------------------------------------
                vXLine = vXLine + 3;
                //-------------------------------------------------------------------

                //���
                vGDColumnIndex = pGDColumn[26];  // �˸� //
                vXLColumnIndex = pXLColumn[25];                
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

        //30�徿
        #region ----- Excel Main Wirte  Method ----

        public int WriteMain(string pCourse, InfoSummit.Win.ControlAdv.ISGridAdvEx pGrid_MONTH_PAYMENT, InfoSummit.Win.ControlAdv.ISDataAdapter pData_PAY_ALLOWANCE, InfoSummit.Win.ControlAdv.ISDataAdapter pData_PAY_DEDUCTION, InfoSummit.Win.ControlAdv.ISDataAdapter pData_DUTY_INFO, InfoSummit.Win.ControlAdv.ISDataAdapter pData_BONUS_ALLOWANCE, InfoSummit.Win.ControlAdv.ISDataAdapter pData_BONUS_DEDUCTION, string pSEAL_FLAG, string pSaveFileName)
        {
            string vMessageText = string.Empty;
            object vObject = null;
            string vBoxCheck = string.Empty;
            string vWAGE_TYPE = string.Empty;
            string vPAY_TYPE = string.Empty;

            int vIndexWAGE_TYPE = pGrid_MONTH_PAYMENT.GetColumnToIndex("WAGE_TYPE");
            int vIndexPAY_TYPE = pGrid_MONTH_PAYMENT.GetColumnToIndex("PAY_TYPE");

            int vIndexCheckBox = pGrid_MONTH_PAYMENT.GetColumnToIndex("SELECT_CHECK_YN");
            string vCheckedString = pGrid_MONTH_PAYMENT.GridAdvExColElement[vIndexCheckBox].CheckedString;

            bool isOpen = XLFileOpen();

            mPageNumber = 0;

            int[] vGDColumn_1;
            int[] vXLColumn_1;

            int[] vGDColumn_2;
            int[] vXLColumn_2;

            int[] vGDColumn_3;
            int[] vXLColumn_3;

            int[] vGDColumn_4;
            int[] vXLColumn_4;

            int[] vGDColumn_5;
            int[] vXLColumn_5;

            int[] vGDColumn_6;
            int[] vXLColumn_6;

            int vTotalRow = pGrid_MONTH_PAYMENT.RowCount;
            int vRowCount = 0;

            int vPrintingLine = 0;

            int vSecondPrinting = 29; //30��°�� �μ�
            int vCountPrinting = 0;

            SetArray1(pData_PAY_ALLOWANCE.OraSelectData, out vGDColumn_1, out vXLColumn_1);
            SetArray2(pData_PAY_DEDUCTION.OraSelectData, out vGDColumn_2, out vXLColumn_2);
            SetArray3(pData_BONUS_ALLOWANCE.OraSelectData, out vGDColumn_3, out vXLColumn_3);
            SetArray4(pData_BONUS_DEDUCTION.OraSelectData, out vGDColumn_4, out vXLColumn_4);
            SetArray5(pData_DUTY_INFO.OraSelectData, out vGDColumn_5, out vXLColumn_5);
            SetArray6(pGrid_MONTH_PAYMENT, out vGDColumn_6, out vXLColumn_6);

            for (int vRow = 0; vRow < vTotalRow; vRow++)
            {
                vRowCount++;                
                pGrid_MONTH_PAYMENT.Cursor = System.Windows.Forms.Cursors.WaitCursor;

                vMessageText = string.Format("Grid : {0}/{1}", vRowCount, vTotalRow);
                mAppInterface.OnAppMessageEvent(vMessageText);
                System.Windows.Forms.Application.DoEvents();

                vObject = pGrid_MONTH_PAYMENT.GetCellValue(vRow, vIndexCheckBox);
                vBoxCheck = ConvertString(vObject);
                if (vBoxCheck == vCheckedString)
                {
                    pGrid_MONTH_PAYMENT.CurrentCellMoveTo(vRow, vIndexCheckBox);
                    pGrid_MONTH_PAYMENT.Focus();
                    pGrid_MONTH_PAYMENT.CurrentCellActivate(vRow, vIndexCheckBox);
                    if (isOpen == true)
                    {
                        vCountPrinting++;

                        vObject = pGrid_MONTH_PAYMENT.GetCellValue(vRow, vIndexWAGE_TYPE);
                        vWAGE_TYPE = ConvertString(vObject);
                        vObject = pGrid_MONTH_PAYMENT.GetCellValue(vRow, vIndexPAY_TYPE);
                        vPAY_TYPE = ConvertString(vObject);

                        if (vWAGE_TYPE == "P1" && (vPAY_TYPE == "2" || vPAY_TYPE == "4"))
                        {
                            mCopyLineSUM = CopyAndPaste(mPrinting, mCopyLineSUM, "DAILY", pSEAL_FLAG);
                            vPrintingLine = (mCopyLineSUM - mIncrementCopyMAX) + (mPrintingLineSTART - 1);

                            //������
                            int vLinePrinting_1 = vPrintingLine + 40;
                            for (int vRow1 = 0; vRow1 < pData_PAY_ALLOWANCE.OraSelectData.Rows.Count; vRow1++)
                            {
                                vLinePrinting_1 = XLLine_1(pData_PAY_ALLOWANCE.OraSelectData.Rows[vRow1], vLinePrinting_1, vGDColumn_1, vXLColumn_1); //�޿� ����
                            }

                            int vLinePrinting_2 = vPrintingLine + 40;
                            for (int vRow2 = 0; vRow2 < pData_PAY_DEDUCTION.OraSelectData.Rows.Count; vRow2++)
                            {
                                vLinePrinting_2 = XLLine_2(pData_PAY_DEDUCTION.OraSelectData.Rows[vRow2], vLinePrinting_2, vGDColumn_2, vXLColumn_2); //�޿� ����
                            }

                            int vLinePrinting_3 = vPrintingLine + 54;
                            for (int vRow3 = 0; vRow3 < pData_BONUS_ALLOWANCE.OraSelectData.Rows.Count; vRow3++)
                            {
                                vLinePrinting_3 = XLLine_3(pData_BONUS_ALLOWANCE.OraSelectData.Rows[vRow3], vLinePrinting_3, vGDColumn_3, vXLColumn_3); //�� ����
                            }

                            int vLinePrinting_4 = vPrintingLine + 54;
                            for (int vRow4 = 0; vRow4 < pData_BONUS_DEDUCTION.OraSelectData.Rows.Count; vRow4++)
                            {
                                vLinePrinting_4 = XLLine_4(pData_BONUS_DEDUCTION.OraSelectData.Rows[vRow4], vLinePrinting_4, vGDColumn_4, vXLColumn_4); //�� ����
                            }

                            int vLinePrinting_5 = vPrintingLine + 31;
                            for (int vRow5 = 0; vRow5 < pData_DUTY_INFO.OraSelectData.Rows.Count; vRow5++)
                            {
                                vLinePrinting_5 = XLLine_5(pData_DUTY_INFO.OraSelectData.Rows[vRow5], vLinePrinting_5, vGDColumn_5, vXLColumn_5); //�ٹ��ð� �� �ΰ�����
                            }

                            vPrintingLine = XLLine_6(pGrid_MONTH_PAYMENT, vRow, vPrintingLine, vGDColumn_6, vXLColumn_6, "DAILY"); //Heaer �� ��������, �ѱݾ�
                        }
                        else
                        {
                            mCopyLineSUM = CopyAndPaste(mPrinting, mCopyLineSUM, "MONTH", pSEAL_FLAG);
                            vPrintingLine = (mCopyLineSUM - mIncrementCopyMAX) + (mPrintingLineSTART - 1);

                            //������
                            int vLinePrinting_1 = vPrintingLine + 40;
                            for (int vRow1 = 0; vRow1 < pData_PAY_ALLOWANCE.OraSelectData.Rows.Count; vRow1++)
                            {
                                vLinePrinting_1 = XLLine_1(pData_PAY_ALLOWANCE.OraSelectData.Rows[vRow1], vLinePrinting_1, vGDColumn_1, vXLColumn_1); //�޿� ����
                            }

                            int vLinePrinting_2 = vPrintingLine + 40;
                            for (int vRow2 = 0; vRow2 < pData_PAY_DEDUCTION.OraSelectData.Rows.Count; vRow2++)
                            {
                                vLinePrinting_2 = XLLine_2(pData_PAY_DEDUCTION.OraSelectData.Rows[vRow2], vLinePrinting_2, vGDColumn_2, vXLColumn_2); //�޿� ����
                            }

                            int vLinePrinting_5 = vPrintingLine + 31;
                            for (int vRow5 = 0; vRow5 < pData_DUTY_INFO.OraSelectData.Rows.Count; vRow5++)
                            {
                                vLinePrinting_5 = XLLine_5(pData_DUTY_INFO.OraSelectData.Rows[vRow5], vLinePrinting_5, vGDColumn_5, vXLColumn_5); //�ٹ��ð� �� �ΰ�����
                            }

                            vPrintingLine = XLLine_6(pGrid_MONTH_PAYMENT, vRow, vPrintingLine, vGDColumn_6, vXLColumn_6, "MONTH"); //Heaer �� ��������, �ѱݾ�
                        }

                        if (pCourse == "PRINT")
                        {
                            if (vTotalRow == vRowCount)
                            {
                                Printing(1, vCountPrinting);
                            }
                            else if (vSecondPrinting < vCountPrinting)
                            {
                                Printing(1, vCountPrinting);

                                mPrinting.XLOpenFileClose();
                                isOpen = XLFileOpen();

                                vCountPrinting = 0;
                                vPrintingLine = 1;
                                mCopyLineSUM = 1;
                            }
                        }
                        else if (pCourse == "PDF")
                        {

                            if (vTotalRow == vRowCount)
                            {
                                PDF_Save(pSaveFileName);
                            }
                            else if (vSecondPrinting < vCountPrinting)
                            {
                                PDF_Save(pSaveFileName);

                                mPrinting.XLOpenFileClose();
                                isOpen = XLFileOpen();

                                vCountPrinting = 0;
                                vPrintingLine = 1;
                                mCopyLineSUM = 1;
                            }
                        }
                        else if (pCourse == "FILE")
                        {
                            if (vTotalRow == vRowCount)
                            {
                                SAVE("PAY_");
                            }
                            else if (vSecondPrinting < vCountPrinting)
                            {
                                SAVE("PAY_");

                                mPrinting.XLOpenFileClose();
                                isOpen = XLFileOpen();

                                vCountPrinting = 0;
                                vPrintingLine = 1;
                                mCopyLineSUM = 1;
                            }
                        }
                        pGrid_MONTH_PAYMENT.SetCellValue(vRow, vIndexCheckBox, "N");
                    }
                }
                else if (vTotalRow == vRowCount)
                {
                    if (isOpen == true)
                    {
                        if (pCourse == "PRINT")
                        {
                            Printing(1, vCountPrinting);
                        }
                        else if (pCourse == "FILE")
                        {
                            SAVE("PAY_");
                        }
                    }
                }
            }

            return mPageNumber;
        }

        #endregion;

        #endregion;

        #region ----- Copy&Paste Sheet Method ----

        //ù��° ������ ����
        private int CopyAndPaste(XL.XLPrint pPrinting, int pCopySumPrintingLine, string pCourse, string vSeal_Flag)
        {
            int vCopySumPrintingLine = pCopySumPrintingLine;

            int vCopyPrintingRowSTART = vCopySumPrintingLine;
            vCopySumPrintingLine = vCopySumPrintingLine + mIncrementCopyMAX;
            int vCopyPrintingRowEnd = vCopySumPrintingLine;

            if (pCourse == "DAILY")
            {
                pPrinting.XLActiveSheet("SourceTab1");
                if(vSeal_Flag == "N")
                {
                    mPrinting.XLDeleteBarCode(pIndexImage: 3);
                }
            }
            else if (pCourse == "MONTH")
            {
                pPrinting.XLActiveSheet("SourceTab2");
                if (vSeal_Flag == "N")
                {
                    mPrinting.XLDeleteBarCode(pIndexImage: 3);
                }
            }

            object vRangeSource = pPrinting.XLGetRange(mCopyColumnSTART, 1, mIncrementCopyMAX, mCopyColumnEND); //[����], [Sheet2.Cell("A1:AS67")], ���� ��Ʈ���� ���� ������ ���ȣ, ���� ��Ʈ���� ���� ������ ����ȣ, ���� ��Ʈ���� ���� ������ ���ȣ, ���� ��Ʈ���� ���� ������ ����ȣ
            pPrinting.XLActiveSheet("Destination");
            object vRangeDestination = pPrinting.XLGetRange(vCopyPrintingRowSTART, 1, vCopyPrintingRowEnd, mCopyColumnEND); //[���], [Sheet1.Cell("A1:AS67")], ���� ��Ʈ���� ���� ������ ���ȣ, ���� ��Ʈ���� ���� ������ ����ȣ, ���� ��Ʈ���� ���� ������ ���ȣ, ���� ��Ʈ���� ���� ������ ����ȣ
            pPrinting.XLCopyRange(vRangeSource, vRangeDestination);


            mPageNumber++; //������ ��ȣ

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

        public void SAVE(string pSaveFileName)
        {
            System.IO.DirectoryInfo vWallpaperFolder = new System.IO.DirectoryInfo(Environment.GetFolderPath(Environment.SpecialFolder.DesktopDirectory));

            int vMaxNumber = MaxIncrement(vWallpaperFolder.ToString(), pSaveFileName);
            vMaxNumber = vMaxNumber + 1;
            string vSaveFileName = string.Format("{0}{1:D3}", pSaveFileName, vMaxNumber);

            vSaveFileName = string.Format("{0}\\{1}.xls", vWallpaperFolder.ToString(), vSaveFileName);
            mPrinting.XLSave(vSaveFileName);
        }

        public void PDF_Save(string pSaveFileName)
        {
            if (pSaveFileName == string.Empty)
            {
                return;
            }
            mPrinting.XLDeleteSheet("SourceTab1");
            mPrinting.XLDeleteSheet("SourceTab2");

            ////��ȣ�� �ּ�
            //System.IO.DirectoryInfo vWallpaperFolder = new System.IO.DirectoryInfo(Environment.GetFolderPath(Environment.SpecialFolder.Desktop));

            //int vMaxNumber = MaxIncrement(vWallpaperFolder.ToString(), pSaveFileName);
            //vMaxNumber = vMaxNumber + 1;
            //string vSaveFileName = string.Format("{0}{1:D2}.pdf", pSaveFileName, vMaxNumber);

            //vSaveFileName = string.Format("{0}\\{1}.pdf", vWallpaperFolder, vSaveFileName);

            mPrinting.XLSaveAs_PDF(pSaveFileName);
            //mPrinting.XLSave(vSaveFileName);
        }

        #endregion;
    }
}