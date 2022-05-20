using System;
using ISCommonUtil;

namespace FCMF0878
{
    public class XLPrinting
    {
        #region ----- Variables -----

        private ISFunction.ISConvert iConv = new ISFunction.ISConvert();
        private ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        private InfoSummit.Win.ControlAdv.ISAppInterface mAppInterface = null;
        private InfoSummit.Win.ControlAdv.ISMessageAdapter mMessageAdapter = null;
        
        private XL.XLPrint mPrinting = null;

        private string mMessageError = string.Empty;

        private int mPageNumber = 0;

        private bool mIsNewPage = false;

        private bool mIsSecondPageWriting = false; //2��° �������� ��� �Ǵ°�?

        private string mXLOpenFileName = string.Empty;

        private int mPrintingLineSTART_SOURCE1 = 33;  //Line
        private int mPrintingLineSTART_SOURCE2 = 13;   //Line

        private int mCopyLineSUM = 1;        //������ ���õ� ��Ʈ�� ����Ǿ��� ���� �� ��ġ, ���� �� ����
        private int mIncrementCopyMAX = 61;  //����Ǿ��� ���� ����

        private int mCopyColumnSTART = 1; //����Ǿ�  �� �� ���� ��
        private int mCopyColumnEND = 44;  //������ ���õ� ��Ʈ�� ����Ǿ��� �� �� ��ġ

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
            pGDColumn = new int[9];
            pXLColumn = new int[9];

            pGDColumn[0] = pGrid.GetColumnToIndex("SEQ");           //�Ϸù�ȣ
            pGDColumn[1] = pGrid.GetColumnToIndex("TAX_REG_NO");    //����ڵ�Ϲ�ȣ
            pGDColumn[2] = pGrid.GetColumnToIndex("SUPPLIER_NAME"); //��ȣ(���θ�)
            pGDColumn[3] = pGrid.GetColumnToIndex("COMPANY_CNT");   //�ż�
            pGDColumn[4] = pGrid.GetColumnToIndex("GL_AMOUNT_1");   //���԰���_������
            pGDColumn[5] = pGrid.GetColumnToIndex("GL_AMOUNT_2");   //���԰���_�ʾ����
            pGDColumn[6] = pGrid.GetColumnToIndex("GL_AMOUNT_3");   //���԰���_�鸸����
            pGDColumn[7] = pGrid.GetColumnToIndex("GL_AMOUNT_4");   //���԰���_õ����
            pGDColumn[8] = pGrid.GetColumnToIndex("GL_AMOUNT_5");   //���԰���_������


            pXLColumn[0] = 3;   //�Ϸù�ȣ
            pXLColumn[1] = 5;   //����ڵ�Ϲ�ȣ
            pXLColumn[2] = 11;  //��ȣ(���θ�)
            pXLColumn[3] = 22;  //�ż�
            pXLColumn[4] = 25;  //���԰���_������
            pXLColumn[5] = 27;  //���԰���_�ʾ����
            pXLColumn[6] = 30;  //���԰���_�鸸����
            pXLColumn[7] = 33;  //���԰���_õ����
            pXLColumn[8] = 36;  //���԰���_������
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

        private void XLHeader(InfoSummit.Win.ControlAdv.ISDataAdapter p_adapter_PRINT_SUM_TAX_TITLE)
        {
            int vCountRow = 0;
            int vXLine = 0;
            int vXLColumn = 0;
            object vObject = null;
            string vConvertString = string.Empty;
            bool IsConvert = false;

            try
            {
                vCountRow = p_adapter_PRINT_SUM_TAX_TITLE.OraSelectData.Rows.Count;

                if (vCountRow > 0)
                {
                    mPrinting.XLActiveSheet("SOURCE2");

                    //�ΰ���ġ���Ű���
                    vObject = p_adapter_PRINT_SUM_TAX_TITLE.OraSelectData.Rows[0]["FISCAL_YEAR"];
                    vXLine = 5;
                    vXLColumn = 16;
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
                    vObject = p_adapter_PRINT_SUM_TAX_TITLE.OraSelectData.Rows[0]["VAT_NUMBER"];
                    vXLine = 7;
                    vXLColumn = 25;
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
                    vObject = p_adapter_PRINT_SUM_TAX_TITLE.OraSelectData.Rows[0]["FISCAL_YEAR"];
                    vXLine = 5;
                    vXLColumn = 16;
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
                    vObject = p_adapter_PRINT_SUM_TAX_TITLE.OraSelectData.Rows[0]["VAT_NUMBER"];
                    vXLine = 9;
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

                    //��ȣ(���θ�)
                    vObject = p_adapter_PRINT_SUM_TAX_TITLE.OraSelectData.Rows[0]["CORP_NAME"];
                    vXLine = 9;
                    vXLColumn = 31;
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
                    vObject = p_adapter_PRINT_SUM_TAX_TITLE.OraSelectData.Rows[0]["PRESIDENT_NAME"];
                    vXLine = 11;
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

                    //����������(��ȭ��ȣ)
                    vObject = p_adapter_PRINT_SUM_TAX_TITLE.OraSelectData.Rows[0]["LOCATION"];
                    vXLine = 11;
                    vXLColumn = 31;
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
                    vObject = p_adapter_PRINT_SUM_TAX_TITLE.OraSelectData.Rows[0]["DEAL_TERM"];
                    vXLine = 13;
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

                    //�ۼ�����
                    vObject = p_adapter_PRINT_SUM_TAX_TITLE.OraSelectData.Rows[0]["CREATE_DATE"];
                    vXLine = 13;
                    vXLColumn = 31;
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

        private void XLSUM(InfoSummit.Win.ControlAdv.ISGridAdvEx p_grid_UP_AP_SUM_TAX)
        {
            int vRow = 0;
            int vCountRow = 0;
            int vGDColumnIndex = 0;
            int vXLine = 0;
            int vXLColumn = 0;
            int vIDX_VAT_TYPE = p_grid_UP_AP_SUM_TAX.GetColumnToIndex("VAT_TYPE");

            object vObject = null;
            string vConvertString = string.Empty;
            decimal vConvertDecimal = 0m;
            bool IsConvert = false;

            int vCol_COMPANY_CNT = 12;   //����ó��
            int vCol_TOTAL_RECORD = 17;  //�ż�
            int vCol_GL_JO = 20;         //���Աݾ�_������
            int vCol_GL_UK = 24;         //���Աݾ�_�ʾ����
            int vCol_GL_MAN = 29;        //���Աݾ�_�鸸����
            int vCol_GL_CHUN = 34;       //���Աݾ�_õ����
            int vCol_GL_WON = 39;        //���Աݾ�_������

            try
            {
                vCountRow = p_grid_UP_AP_SUM_TAX.RowCount;

                if (vCountRow > 0)
                {
                    mPrinting.XLActiveSheet("SOURCE1");

                    for (vRow = 0; vRow < vCountRow; vRow++)
                    {
                        if (iConv.ISNull(p_grid_UP_AP_SUM_TAX.GetCellValue(vRow, vIDX_VAT_TYPE)) == "SUM")
                        {
                            //���� : �հ�
                            vXLine = 19;
                        }
                        else if (iConv.ISNull(p_grid_UP_AP_SUM_TAX.GetCellValue(vRow, vIDX_VAT_TYPE)) == "Y")
                        {
                            //���� : ���ڼ��ݰ�꼭
                            vXLine = 21;
                        }
                        else if (iConv.ISNull(p_grid_UP_AP_SUM_TAX.GetCellValue(vRow, vIDX_VAT_TYPE)) != "Y")
                        {
                            //���� : ���ڼ��ݰ�꼭 ��
                            vXLine = 24;
                        }

                        //����ó�� : �հ�
                        vGDColumnIndex = p_grid_UP_AP_SUM_TAX.GetColumnToIndex("COMPANY_CNT");
                        vObject = p_grid_UP_AP_SUM_TAX.GetCellValue(vRow, vGDColumnIndex);
                        vXLColumn = vCol_COMPANY_CNT;
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
                        vGDColumnIndex = p_grid_UP_AP_SUM_TAX.GetColumnToIndex("TOTAL_RECORD");
                        vObject = p_grid_UP_AP_SUM_TAX.GetCellValue(vRow, vGDColumnIndex);
                        vXLColumn = vCol_TOTAL_RECORD;
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

                        //���Աݾ�_������ : �հ�
                        vGDColumnIndex = p_grid_UP_AP_SUM_TAX.GetColumnToIndex("GL_AMOUNT_1");
                        vObject = p_grid_UP_AP_SUM_TAX.GetCellValue(vRow, vGDColumnIndex);
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

                        //���Աݾ�_�ʾ���� : �հ�
                        vGDColumnIndex = p_grid_UP_AP_SUM_TAX.GetColumnToIndex("GL_AMOUNT_2");
                        vObject = p_grid_UP_AP_SUM_TAX.GetCellValue(vRow, vGDColumnIndex);
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

                        //���Աݾ�_�鸸���� : �հ�
                        vGDColumnIndex = p_grid_UP_AP_SUM_TAX.GetColumnToIndex("GL_AMOUNT_3");
                        vObject = p_grid_UP_AP_SUM_TAX.GetCellValue(vRow, vGDColumnIndex);
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

                        //���Աݾ�_õ���� : �հ�
                        vGDColumnIndex = p_grid_UP_AP_SUM_TAX.GetColumnToIndex("GL_AMOUNT_4");
                        vObject = p_grid_UP_AP_SUM_TAX.GetCellValue(vRow, vGDColumnIndex);
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

                        //���Աݾ�_������ : �հ�
                        vGDColumnIndex = p_grid_UP_AP_SUM_TAX.GetColumnToIndex("GL_AMOUNT_5");
                        vObject = p_grid_UP_AP_SUM_TAX.GetCellValue(vRow, vGDColumnIndex);
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

                //���԰���_������
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

                //���԰���_�ʾ����
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

                //���԰���_�鸸����
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

                //���԰���_õ����
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

                //���԰���_������
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

        public int LineWrite(InfoSummit.Win.ControlAdv.ISGridAdvEx p_grid_UP_AP_SUM_TAX, InfoSummit.Win.ControlAdv.ISGridAdvEx p_grid_LIST_AP_SUM_TAX, InfoSummit.Win.ControlAdv.ISDataAdapter p_adapter_PRINT_SUM_TAX_TITLE)
        {
            mPageNumber = 0;
            string vMessage = string.Empty;

            int[] vGDColumn;
            int[] vXLColumn;

            int vPrintingLine = 0;

            try
            {
                int vTotal1ROW = p_grid_LIST_AP_SUM_TAX.RowCount;

                #region ----- Header/SUM Write ----

                XLHeader(p_adapter_PRINT_SUM_TAX_TITLE);
                XLSUM(p_grid_UP_AP_SUM_TAX);

                mCopyLineSUM = CopyAndPaste(mPrinting, mCopyLineSUM);

                #endregion;

                #region ----- Line Write ----

                if (vTotal1ROW > 0)
                {
                    int vCountROW1 = 0;

                    vPrintingLine = mPrintingLineSTART_SOURCE1;

                    SetArray1(p_grid_LIST_AP_SUM_TAX, out vGDColumn, out vXLColumn);

                    for (int vRow1 = 0; vRow1 < vTotal1ROW; vRow1++)
                    {
                        vCountROW1++;

                        vMessage = string.Format("Grid2 : {0}/{1}", vCountROW1, vTotal1ROW);
                        mAppInterface.OnAppMessageEvent(vMessage);
                        System.Windows.Forms.Application.DoEvents();

                        vPrintingLine = XLLine(p_grid_LIST_AP_SUM_TAX, vRow1, vPrintingLine, vGDColumn, vXLColumn);

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
                vPrintingLineEND = mCopyLineSUM - 7; //1~58: mCopyLineSUM=62���� ������ ��µǴ� ���� 55 ���� �̹Ƿ�, 7�� ���� �ȴ�
            }
            else
            {
                vPrintingLineEND = mCopyLineSUM - 7; //1~58: mCopyLineSUM=62���� ������ ��µǴ� ���� 55 ���� �̹Ƿ�, 7�� ���� �ȴ�
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
            int vRowSTART = vCopyPrintingRowEnd - 6;

            if (mPageNumber != 1)
            {
                mPrinting.XLSetCell(vRowSTART, 40, mPageNumber);
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
