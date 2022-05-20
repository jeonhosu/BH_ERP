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

        private bool mIsSecondPageWriting = false; //2��° �������� ��� �Ǵ°�?

        private string mXLOpenFileName = string.Empty;

        private int mPrintingLineSTART_SOURCE1 = 42;  //Line
        private int mPrintingLineSTART_SOURCE2 = 15;   //Line

        private int mCopyLineSUM = 1;        //������ ���õ� ��Ʈ�� ����Ǿ��� ���� �� ��ġ, ���� �� ����
        private int mIncrementCopyMAX = 58;  //����Ǿ��� ���� ����

        private int mCopyColumnSTART = 1; //����Ǿ�  �� �� ���� ��
        private int mCopyColumnEND = 56;  //������ ���õ� ��Ʈ�� ����Ǿ��� �� �� ��ġ

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

            pGDColumn[0] = pGrid.GetColumnToIndex("SEQ");           //�Ϸù�ȣ
            pGDColumn[1] = pGrid.GetColumnToIndex("TAX_REG_NO");    //����ڵ�Ϲ�ȣ
            pGDColumn[2] = pGrid.GetColumnToIndex("SUPPLIER_NAME"); //��ȣ(���θ�)
            pGDColumn[3] = pGrid.GetColumnToIndex("COMPANY_CNT");   //�ż�
            pGDColumn[4] = pGrid.GetColumnToIndex("GL_AMOUNT_1");   //���ް���_������
            pGDColumn[5] = pGrid.GetColumnToIndex("GL_AMOUNT_2");   //���ް���_�ʾ����
            pGDColumn[6] = pGrid.GetColumnToIndex("GL_AMOUNT_3");   //���ް���_�鸸����
            pGDColumn[7] = pGrid.GetColumnToIndex("GL_AMOUNT_4");   //���ް���_õ����
            pGDColumn[8] = pGrid.GetColumnToIndex("GL_AMOUNT_5");   //���ް���_������
            pGDColumn[9] = pGrid.GetColumnToIndex("VAT_AMOUNT_1");  //����_������
            pGDColumn[10] = pGrid.GetColumnToIndex("VAT_AMOUNT_2"); //����_�ʾ����
            pGDColumn[11] = pGrid.GetColumnToIndex("VAT_AMOUNT_3"); //����_�鸸����
            pGDColumn[12] = pGrid.GetColumnToIndex("VAT_AMOUNT_4"); //����_õ����
            pGDColumn[13] = pGrid.GetColumnToIndex("VAT_AMOUNT_5"); //����_������


            pXLColumn[0] = 3;   //�Ϸù�ȣ
            pXLColumn[1] = 6;   //����ڵ�Ϲ�ȣ
            pXLColumn[2] = 12;  //��ȣ(���θ�)
            pXLColumn[3] = 22;  //�ż�
            pXLColumn[4] = 25;  //���ް���_������
            pXLColumn[5] = 27;  //���ް���_�ʾ����
            pXLColumn[6] = 30;  //���ް���_�鸸����
            pXLColumn[7] = 33;  //���ް���_õ����
            pXLColumn[8] = 36;  //���ް���_������
            pXLColumn[9] = 39;  //����_������
            pXLColumn[10] = 41; //����_�ʾ����
            pXLColumn[11] = 44; //����_�鸸����
            pXLColumn[12] = 47; //����_õ����
            pXLColumn[13] = 50; //����_������
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

                    //�ΰ���ġ���Ű���
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

                    //����ڵ�Ϲ�ȣ
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

                    //�ΰ���ġ���Ű���
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

                    //����ڵ�Ϲ�ȣ
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

                    //��ȣ(���θ�)
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

                    //����(��ǥ��)
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

                    //����������(��ȭ��ȣ)
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

                    //�ŷ��Ⱓ
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

                    //�ۼ�����
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

            int vCol_COM_CNT = 19;  //����ó��
            int vCol_COM_REC = 24;  //�ż�
            int vCol_GL_JO = 28;    //���ް���_������
            int vCol_GL_UK = 30;    //���ް���_�ʾ����
            int vCol_GL_MAN = 33;   //���ް���_�鸸����
            int vCol_GL_CHUN = 36;  //���ް���_õ����
            int vCol_GL_WON = 39;   //���ް���_������
            int vCol_VAT_JO = 42;   //����������
            int vCol_VAT_UK = 44;   //���׽ʾ����
            int vCol_VAT_MAN = 47;  //���׹鸸����
            int vCol_VAT_CHUN = 50; //����õ����
            int vCol_VAT_WON = 53;  //���׿�����

            try
            {
                vCountRow = p_grid_UP_AP_SUM_VAT_TAX.RowCount;

                if (vCountRow > 0)
                {
                    mPrinting.XLActiveSheet("SOURCE1");

                    //���� : �հ�
                    vXLine = 20;
                    vRow = 0;

                    //����ó�� : �հ�
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

                    //�ż� : �հ�
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

                    //���ް���_������ : �հ�
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

                    //���ް���_�ʾ���� : �հ�
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

                    //���ް���_�鸸���� : �հ�
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

                    //���ް���_õ���� : �հ�
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

                    //���ް���_������ : �հ�
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

                    //����_������ : �հ�
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

                    //����_�ʾ���� : �հ�
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

                    //����_�鸸���� : �հ�
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

                    //����_õ���� : �հ�
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

                    //����_������ : �հ�
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


                    //���� : ���� : ����ڵ�Ϲ�ȣ
                    vXLine = 22;
                    vRow = 1;

                    //����ó�� : ����
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

                    //�ż� : ����
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

                    //���ް���_������ : ����
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

                    //���ް���_�ʾ���� : ����
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

                    //���ް���_�鸸���� : ����
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

                    //���ް���_õ���� : ����
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

                    //���ް���_������ : ����
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

                    //����_������ : ����
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

                    //����_�ʾ���� : ����
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

                    //����_�鸸���� : ����
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

                    //����_õ���� : ����
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

                    //����_������ : ����
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


                    //���� : ���� : �ֹε�Ϲ�ȣ
                    vXLine = 24;
                    vRow = 1;

                    //����ó�� : ����
                    vXLColumn = vCol_COM_CNT;
                    mPrinting.XLSetCell(vXLine, vXLColumn, "0");

                    //�ż� : ����
                    vXLColumn = vCol_COM_REC;
                    mPrinting.XLSetCell(vXLine, vXLColumn, "0");

                    //���ް���_������ : ����
                    vXLColumn = vCol_GL_WON;
                    mPrinting.XLSetCell(vXLine, vXLColumn, "0");

                    //����_������ : ����
                    vXLColumn = vCol_VAT_WON;
                    mPrinting.XLSetCell(vXLine, vXLColumn, "0");


                    //----------------------------------------------------------------------------
                    //////////////////////////////////////////////////////////////////////////////
                    //----------------------------------------------------------------------------


                    //���� : ���� : �Ұ�
                    vXLine = 26;
                    vRow = 1;

                    //����ó�� : ����
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

                    //�ż� : ����
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

                    //���ް���_������ : ����
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

                    //���ް���_�ʾ���� : ����
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

                    //���ް���_�鸸���� : ����
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

                    //���ް���_õ���� : ����
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

                    //���ް���_������ : ����
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

                    //����_������ : ����
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

                    //����_�ʾ���� : ����
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

                    //����_�鸸���� : ����
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

                    //����_õ���� : ����
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

                    //����_������ : ����
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




                    //���� : ���ڿ� : ����ڵ�Ϲ�ȣ
                    vXLine = 28;
                    vRow = 2;

                    //����ó�� : ���ڿ�
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

                    //�ż� : ���ڿ�
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

                    //���ް���_������ : ���ڿ�
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

                    //���ް���_�ʾ���� : ���ڿ�
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

                    //���ް���_�鸸���� : ���ڿ�
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

                    //���ް���_õ���� : ���ڿ�
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

                    //���ް���_������ : ���ڿ�
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

                    //����_������ : ���ڿ�
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

                    //����_�ʾ���� : ���ڿ�
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

                    //����_�鸸���� : ���ڿ�
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

                    //����_õ���� : ���ڿ�
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

                    //����_������ : ���ڿ�
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


                    //���� : ���ڿ� : �ֹε�Ϲ�ȣ
                    vXLine = 30;
                    vRow = 2;

                    //����ó�� : ���ڿ�
                    vXLColumn = vCol_COM_CNT;
                    mPrinting.XLSetCell(vXLine, vXLColumn, "0");

                    //�ż� : ���ڿ�
                    vXLColumn = vCol_COM_REC;
                    mPrinting.XLSetCell(vXLine, vXLColumn, "0");

                    //���ް���_������ : ���ڿ�
                    vXLColumn = vCol_GL_WON;
                    mPrinting.XLSetCell(vXLine, vXLColumn, "0");

                    //����_������ : ���ڿ�
                    vXLColumn = vCol_VAT_WON;
                    mPrinting.XLSetCell(vXLine, vXLColumn, "0");


                    //----------------------------------------------------------------------------
                    //////////////////////////////////////////////////////////////////////////////
                    //----------------------------------------------------------------------------


                    //���� : ���ڿ� : �Ұ�
                    vXLine = 32;
                    vRow = 2;

                    //����ó�� : ���ڿ�
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

                    //�ż� : ���ڿ�
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

                    //���ް���_������ : ���ڿ�
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

                    //���ް���_�ʾ���� : ���ڿ�
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

                    //���ް���_�鸸���� : ���ڿ�
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

                    //���ް���_õ���� : ���ڿ�
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

                    //���ް���_������ : ���ڿ�
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

                    //����_������ : ���ڿ�
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

                    //����_�ʾ���� : ���ڿ�
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

                    //����_�鸸���� : ���ڿ�
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

                    //����_õ���� : ���ڿ�
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

                    //����_������ : ���ڿ�
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
            int vXLine = pXLine; //������ ������ ǥ�õǴ� �� ��ȣ

            int vGDColumnIndex = 0;
            int vXLColumnIndex = 0;

            object vObject = null;
            string vConvertString = string.Empty;
            decimal vConvertDecimal = 0m;
            bool IsConvert = false;

            try
            {
                mPrinting.XLActiveSheet("DESTINATION");

                //�Ϸù�ȣ
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

                //����ڵ�Ϲ�ȣ
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

                //��ȣ(���θ�)
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

                //�ż�
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

                //���ް���_������
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

                //���ް���_�ʾ����
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

                //���ް���_�鸸����
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

                //���ް���_õ����
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

                //���ް���_������
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

                //����_������
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

                //����_�ʾ����
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

                //����_�鸸����
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

                //����_õ����
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

                //����_������
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
                            //������ ���̸�...
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
                vPrintingLineEND = mCopyLineSUM - 9; //1~58: mCopyLineSUM=59���� ������ ��µǴ� ���� 50 ���� �̹Ƿ�, 9�� ���� �ȴ�
            }
            else
            {
                vPrintingLineEND = mCopyLineSUM - 6; //1~58: mCopyLineSUM=59���� ������ ��µǴ� ���� 53 ���� �̹Ƿ�, 6�� ���� �ȴ�
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

        //ù��° ������ ����
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

            object vRangeSource = pPrinting.XLGetRange(mCopyColumnSTART, 1, mIncrementCopyMAX, mCopyColumnEND); //[����], [Sheet2.Cell("A1:AS67")], ���� ��Ʈ���� ���� ������ ���ȣ, ���� ��Ʈ���� ���� ������ ����ȣ, ���� ��Ʈ���� ���� ������ ���ȣ, ���� ��Ʈ���� ���� ������ ����ȣ
            pPrinting.XLActiveSheet("DESTINATION");
            object vRangeDestination = pPrinting.XLGetRange(vCopyPrintingRowSTART, 1, vCopyPrintingRowEnd, mCopyColumnEND); //[���], [Sheet1.Cell("A1:AS67")], ���� ��Ʈ���� ���� ������ ���ȣ, ���� ��Ʈ���� ���� ������ ����ȣ, ���� ��Ʈ���� ���� ������ ���ȣ, ���� ��Ʈ���� ���� ������ ����ȣ
            pPrinting.XLCopyRange(vRangeSource, vRangeDestination);

            mPageNumber++; //������ ��ȣ
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
