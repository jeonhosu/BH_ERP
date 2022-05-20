using System;
using ISCommonUtil;

namespace FCMF0880
{
    public class XLPrinting
    {
        #region ----- Variables -----

        ISFunction.ISConvert iConv = new ISFunction.ISConvert();
        ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        private InfoSummit.Win.ControlAdv.ISAppInterface mAppInterface = null;
        private InfoSummit.Win.ControlAdv.ISMessageAdapter mMessageAdapter = null;

        private XL.XLPrint mPrinting = null;

        private string mMessageError = string.Empty;

        private int mPageNumber = 0;

        private string mXLOpenFileName = string.Empty;

        private int mCopyLineSUM = 1;        //������ ���õ� ��Ʈ�� ����Ǿ��� ���� �� ��ġ, ���� �� ����
        private int mIncrementCopyMAX = 41;  //����Ǿ��� ���� ����

        private int mCopyColumnSTART = 1; //����Ǿ�  �� �� ���� ��
        private int mCopyColumnEND = 42;  //������ ���õ� ��Ʈ�� ����Ǿ��� �� �� ��ġ

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

        private void XLHeader(InfoSummit.Win.ControlAdv.ISDataAdapter pIDA_PRINT_NO_DEDUCTION_TITLE)
        {
            int vCountRow = 0;
            int vXLine = 0;
            int vXLColumn = 0;
            object vObject = null;
            string vConvertString = string.Empty;
            bool IsConvert = false;

            try
            {
                vCountRow = pIDA_PRINT_NO_DEDUCTION_TITLE.OraSelectData.Rows.Count;

                if (vCountRow > 0)
                {
                    mPrinting.XLActiveSheet("SOURCE1");

                    //�ΰ���ġ���Ű���
                    vObject = pIDA_PRINT_NO_DEDUCTION_TITLE.OraSelectData.Rows[0]["FISCAL_YEAR"];
                    vXLine = 4;
                    vXLColumn = 2;
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
                    vObject = pIDA_PRINT_NO_DEDUCTION_TITLE.OraSelectData.Rows[0]["CORP_NAME"];
                    vXLine = 6;
                    vXLColumn = 7;
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
                    vObject = pIDA_PRINT_NO_DEDUCTION_TITLE.OraSelectData.Rows[0]["PRESIDENT_NAME"];
                    vXLine = 6;
                    vXLColumn = 24;
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
                    vObject = pIDA_PRINT_NO_DEDUCTION_TITLE.OraSelectData.Rows[0]["VAT_NUMBER"];
                    vXLine = 6;
                    vXLColumn = 35;
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

        private void XLSUM(InfoSummit.Win.ControlAdv.ISGridAdvEx pIGR_UP_EXPORT_RESULT)
        {
            int vCountRow = 0;
            int vGDColumnIndex = 0;
            int vXLine = 10;
            int vXLColumn = 0;
            object vObject = null;
            string vConvertString = string.Empty;
            decimal vConvertDecimal = 0m;
            bool IsConvert = false;

            decimal vGuBun = 0;

            try
            {
                vCountRow = pIGR_UP_EXPORT_RESULT.RowCount;

                if (vCountRow > 0)
                {
                    mPrinting.XLActiveSheet("SOURCE1");

                    for (int vRow = 0; vRow < vCountRow; vRow++)
                    {
                        vGDColumnIndex = pIGR_UP_EXPORT_RESULT.GetColumnToIndex("SORT_NUM");
                        vObject = pIGR_UP_EXPORT_RESULT.GetCellValue(vRow, vGDColumnIndex);
                        IsConvert = IsConvertNumber(vObject, out vGuBun);
                        if (IsConvert == true)
                        {
                            if (vGuBun == 1)
                            {
                                vXLine = 11;
                            }
                            else if (vGuBun == 2)
                            {
                                vXLine = 12;
                            }
                            else if (vGuBun == 3)
                            {
                                vXLine = 13;
                            }
                            else if (vGuBun == 4)
                            {
                                vXLine = 14;
                            }
                            else if (vGuBun == 5)
                            {
                                vXLine = 15;
                            }
                            else if (vGuBun == 6)
                            {
                                vXLine = 16;
                            }
                            else if (vGuBun == 7)
                            {
                                vXLine = 17;
                            }
                            else if (vGuBun == 8)
                            {
                                vXLine = 18;
                            }
                            else if (vGuBun == 99)
                            {
                                vXLine = 19;
                            }
                        }

                        //�ż�
                        vGDColumnIndex = pIGR_UP_EXPORT_RESULT.GetColumnToIndex("VAT_COUNT");
                        vObject = pIGR_UP_EXPORT_RESULT.GetCellValue(vRow, vGDColumnIndex);
                        vXLColumn = 20;
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

                        //���ް���
                        vGDColumnIndex = pIGR_UP_EXPORT_RESULT.GetColumnToIndex("GL_AMOUNT");
                        vObject = pIGR_UP_EXPORT_RESULT.GetCellValue(vRow, vGDColumnIndex);
                        vXLColumn = 25;
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

                        //���Լ���
                        vGDColumnIndex = pIGR_UP_EXPORT_RESULT.GetColumnToIndex("VAT_AMOUNT");
                        vObject = pIGR_UP_EXPORT_RESULT.GetCellValue(vRow, vGDColumnIndex);
                        vXLColumn = 32;
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

                        //���
                        vGDColumnIndex = pIGR_UP_EXPORT_RESULT.GetColumnToIndex("REMARK");
                        vObject = pIGR_UP_EXPORT_RESULT.GetCellValue(vRow, vGDColumnIndex);
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
            }
            catch (System.Exception ex)
            {
                mMessageError = ex.Message;
                mAppInterface.OnAppMessageEvent(mMessageError);
                System.Windows.Forms.Application.DoEvents();
            }
        }

        #endregion;

        #region ----- 3. ������Լ��� �Ⱥа�� ���� �μ� : Write Method ----

        private void XL_ADJUST_3(InfoSummit.Win.ControlAdv.ISDataAdapter pIDA_ADJUST_3)
        {
            int vCountRow = 0;
            int vXLine = 23;
            int vXLColumn = 0;

            object vObject = null;
            string vConvertString = string.Empty;
            decimal vConvertDecimal = 0m;
            bool IsConvert = false;

            try
            {
                vCountRow = pIDA_ADJUST_3.CurrentRows.Count;

                if (vCountRow > 0)
                {
                    mPrinting.XLActiveSheet("SOURCE1");

                    foreach (System.Data.DataRow vRow in pIDA_ADJUST_3.CurrentRows)
                    {                        
                        if (iConv.ISNumtoZero(vRow["SEQ_NO"]) <= 5)
                        {                            
                            //����,�鼼��� ������Ծ� ���ް��� 
                            vObject = vRow["SUPPLY_AMT"];                                                        
                            IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                            if (IsConvert == true)
                            {
                                vConvertString = string.Format("{0:##,###,###,###,###,###,###,###,###}", vConvertDecimal);
                            }
                            else
                            {
                                vConvertString = string.Empty;
                            }
                            vXLColumn = 4;
                            mPrinting.XLSetCell(vXLine, vXLColumn, vConvertString);

                            //����,�鼼��� ������Ծ� ����
                            vObject = vRow["VAT_AMT"];
                            IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                            if (IsConvert == true)
                            {
                                vConvertString = string.Format("{0:##,###,###,###,###,###,###,###,###}", vConvertDecimal);
                            }
                            else
                            {
                                vConvertString = string.Empty;
                            }
                            vXLColumn = 11;
                            mPrinting.XLSetCell(vXLine, vXLColumn, vConvertString);

                            //�Ѱ��ް��׵� 
                            vObject = vRow["TAX_SUPPLY_AMT"];
                            IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                            if (IsConvert == true)
                            {
                                vConvertString = string.Format("{0:##,###,###,###,###,###,###,###,###}", vConvertDecimal);
                            }
                            else
                            {
                                vConvertString = string.Empty;
                            }
                            vXLColumn = 17;
                            mPrinting.XLSetCell(vXLine, vXLColumn, vConvertString);

                            //�鼼���ް��׵� 
                            vObject = vRow["NON_TAX_SUPPLY_AMT"];
                            IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                            if (IsConvert == true)
                            {
                                vConvertString = string.Format("{0:##,###,###,###,###,###,###,###,###}", vConvertDecimal);
                            }
                            else
                            {
                                vConvertString = string.Empty;
                            }
                            vXLColumn = 25;
                            mPrinting.XLSetCell(vXLine, vXLColumn, vConvertString);

                            //�Ұ������Լ��� 
                            vObject = vRow["NO_VAT_AMT"];
                            IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                            if (IsConvert == true)
                            {
                                vConvertString = string.Format("{0:##,###,###,###,###,###,###,###,###}", vConvertDecimal);
                            }
                            else
                            {
                                vConvertString = string.Empty;
                            }
                            vXLColumn = 33;
                            mPrinting.XLSetCell(vXLine, vXLColumn, vConvertString);

                            vXLine = vXLine + 1;
                        }
                        else if (iConv.ISNumtoZero(vRow["SEQ_NO"]) == 99)
                        {
                            vXLine = 28;

                            //����,�鼼��� ������Ծ� ���ް��� 
                            vObject = vRow["SUPPLY_AMT"];
                            IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                            if (IsConvert == true)
                            {
                                vConvertString = string.Format("{0:##,###,###,###,###,###,###,###,###}", vConvertDecimal);
                            }
                            else
                            {
                                vConvertString = string.Empty;
                            }
                            vXLColumn = 4;
                            mPrinting.XLSetCell(vXLine, vXLColumn, vConvertString);

                            //����,�鼼��� ������Ծ� ����
                            vObject = vRow["VAT_AMT"];
                            IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                            if (IsConvert == true)
                            {
                                vConvertString = string.Format("{0:##,###,###,###,###,###,###,###,###}", vConvertDecimal);
                            }
                            else
                            {
                                vConvertString = string.Empty;
                            }
                            vXLColumn = 11;
                            mPrinting.XLSetCell(vXLine, vXLColumn, vConvertString);
                            
                            //�Ұ������Լ��� 
                            vObject = vRow["NO_VAT_AMT"];
                            IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                            if (IsConvert == true)
                            {
                                vConvertString = string.Format("{0:##,###,###,###,###,###,###,###,###}", vConvertDecimal);
                            }
                            else
                            {
                                vConvertString = string.Empty;
                            }
                            vXLColumn = 33;
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

        #region ----- 4. ������Լ��� ���� ���� �μ� : Write Method ----

        private void XL_ADJUST_4(InfoSummit.Win.ControlAdv.ISDataAdapter pIDA_ADJUST_4)
        {
            int vCountRow = 0;
            int vXLine = 32;
            int vXLColumn = 0;

            object vObject = null;
            string vConvertString = string.Empty;
            decimal vConvertDecimal = 0m;
            bool IsConvert = false;

            try
            {
                vCountRow = pIDA_ADJUST_4.CurrentRows.Count;

                if (vCountRow > 0)
                {
                    mPrinting.XLActiveSheet("SOURCE1");

                    foreach (System.Data.DataRow vRow in pIDA_ADJUST_4.CurrentRows)
                    {
                        if (iConv.ISNumtoZero(vRow["SEQ_NO"]) <= 2)
                        {
                            //�����鼼����� �Ѱ�����Լ��� 
                            vObject = vRow["VAT_AMT"];
                            IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                            if (IsConvert == true)
                            {
                                vConvertString = string.Format("{0:##,###,###,###,###,###,###,###,###}", vConvertDecimal);
                            }
                            else
                            {
                                vConvertString = string.Empty;
                            }
                            vXLColumn = 4;
                            mPrinting.XLSetCell(vXLine, vXLColumn, vConvertString);

                            //�鼼������(%) 
                            vObject = vRow["NON_TAX_RATE"];
                            IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                            if (IsConvert == true)
                            {
                                vConvertString = string.Format("{0:###,###.####}", vConvertDecimal);
                            }
                            else
                            {
                                vConvertString = string.Empty;
                            }
                            vXLColumn = 11;
                            mPrinting.XLSetCell(vXLine, vXLColumn, vConvertString);

                            //�Ұ������Լ���
                            vObject = vRow["NO_VAT_AMT"];
                            IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                            if (IsConvert == true)
                            {
                                vConvertString = string.Format("{0:##,###,###,###,###,###,###,###,###}", vConvertDecimal);
                            }
                            else
                            {
                                vConvertString = string.Empty;
                            }
                            vXLColumn = 17;
                            mPrinting.XLSetCell(vXLine, vXLColumn, vConvertString);

                            //��������Լ��� 
                            vObject = vRow["PRE_VAT_AMT"];
                            IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                            if (IsConvert == true)
                            {
                                vConvertString = string.Format("{0:##,###,###,###,###,###,###,###,###}", vConvertDecimal);
                            }
                            else
                            {
                                vConvertString = string.Empty;
                            }
                            vXLColumn = 25;
                            mPrinting.XLSetCell(vXLine, vXLColumn, vConvertString);

                            //����Ǵ°������Լ��� 
                            vObject = vRow["ADDITION_VAT_AMT"];
                            IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                            if (IsConvert == true)
                            {
                                vConvertString = string.Format("{0:##,###,###,###,###,###,###,###,###}", vConvertDecimal);
                            }
                            else
                            {
                                vConvertString = string.Empty;
                            }
                            vXLColumn = 33;
                            mPrinting.XLSetCell(vXLine, vXLColumn, vConvertString);

                            vXLine = vXLine + 1;
                        }
                        else if (iConv.ISNumtoZero(vRow["SEQ_NO"]) == 99)
                        {
                            vXLine = 34;

                            //�����鼼����� �Ѱ�����Լ��� 
                            vObject = vRow["VAT_AMT"];
                            IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                            if (IsConvert == true)
                            {
                                vConvertString = string.Format("{0:##,###,###,###,###,###,###,###,###}", vConvertDecimal);
                            }
                            else
                            {
                                vConvertString = string.Empty;
                            }
                            vXLColumn = 4;
                            mPrinting.XLSetCell(vXLine, vXLColumn, vConvertString);

                            //�鼼������(%) 
                            vObject = vRow["NON_TAX_RATE"];
                            IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                            if (IsConvert == true)
                            {
                                vConvertString = string.Format("{0:###,###.####}", vConvertDecimal);
                            }
                            else
                            {
                                vConvertString = string.Empty;
                            }
                            vXLColumn = 11;
                            mPrinting.XLSetCell(vXLine, vXLColumn, vConvertString);

                            //�Ұ������Լ���
                            vObject = vRow["NO_VAT_AMT"];
                            IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                            if (IsConvert == true)
                            {
                                vConvertString = string.Format("{0:##,###,###,###,###,###,###,###,###}", vConvertDecimal);
                            }
                            else
                            {
                                vConvertString = string.Empty;
                            }
                            vXLColumn = 17;
                            mPrinting.XLSetCell(vXLine, vXLColumn, vConvertString);

                            //��������Լ��� 
                            vObject = vRow["PRE_VAT_AMT"];
                            IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                            if (IsConvert == true)
                            {
                                vConvertString = string.Format("{0:##,###,###,###,###,###,###,###,###}", vConvertDecimal);
                            }
                            else
                            {
                                vConvertString = string.Empty;
                            }
                            vXLColumn = 25;
                            mPrinting.XLSetCell(vXLine, vXLColumn, vConvertString);

                            //����Ǵ°������Լ��� 
                            vObject = vRow["ADDITION_VAT_AMT"];
                            IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                            if (IsConvert == true)
                            {
                                vConvertString = string.Format("{0:##,###,###,###,###,###,###,###,###}", vConvertDecimal);
                            }
                            else
                            {
                                vConvertString = string.Empty;
                            }
                            vXLColumn = 33;
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
        
        #region ----- Total Sum Write Method ----

        private void XL_TOTAL_SUM(InfoSummit.Win.ControlAdv.ISDataAdapter p_adapter_SUM_SUPPLY_AMT)
        {
            int vCountRow = 0;
            int vXLine = 0;
            int vXLColumn = 0;
            object vObject = null;
            string vConvertString = string.Empty;
            decimal vConvertDecimal = 0m;
            bool IsConvert = false;

            try
            {
                vCountRow = p_adapter_SUM_SUPPLY_AMT.OraSelectData.Rows.Count;

                if (vCountRow > 0)
                {
                    mPrinting.XLActiveSheet("SOURCE1");

                    //�Ѱ��ް���  ��
                    vObject = p_adapter_SUM_SUPPLY_AMT.OraSelectData.Rows[0]["GL_AMOUNT"];
                    vXLine = 23;
                    vXLColumn = 17;
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

        #endregion;

        #region ----- Excel Wirte [Line] Methods ----

        public int LineWrite(InfoSummit.Win.ControlAdv.ISGridAdvEx pIGR_LIST_NO_DEDUCTION
                            , InfoSummit.Win.ControlAdv.ISDataAdapter pIDA_PRINT_NO_DEDUCTION_TITLE
                            , InfoSummit.Win.ControlAdv.ISDataAdapter pIDA_PRINT_ADJUST_3
                            , InfoSummit.Win.ControlAdv.ISDataAdapter pIDA_PRINT_ADJUST_4)
        {
            mPageNumber = 0;
            string vMessage = string.Empty;

            try
            {
                #region ----- Header/SUM Write ----

                XLHeader(pIDA_PRINT_NO_DEDUCTION_TITLE);
                XLSUM(pIGR_LIST_NO_DEDUCTION);
                XL_ADJUST_3(pIDA_PRINT_ADJUST_3);
                XL_ADJUST_4(pIDA_PRINT_ADJUST_4);

                mCopyLineSUM = CopyAndPaste(mCopyLineSUM);

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

        //public int LineWrite(InfoSummit.Win.ControlAdv.ISGridAdvEx p_grid_LIST_NO_DEDUCTION, InfoSummit.Win.ControlAdv.ISDataAdapter p_adapter_PRINT_NO_DEDUCTION_TITLE, InfoSummit.Win.ControlAdv.ISDataAdapter p_adapter_SUM_SUPPLY_AMT)
        //{
        //    mPageNumber = 0;
        //    string vMessage = string.Empty;

        //    try
        //    {
        //        #region ----- Header/SUM Write ----

        //        XLHeader(p_adapter_PRINT_NO_DEDUCTION_TITLE);
        //        XLSUM(p_grid_LIST_NO_DEDUCTION);
        //        XL_TOTAL_SUM(p_adapter_SUM_SUPPLY_AMT);

        //        mCopyLineSUM = CopyAndPaste(mCopyLineSUM);

        //        #endregion;
        //    }
        //    catch (System.Exception ex)
        //    {
        //        mMessageError = ex.Message;
        //        mPrinting.XLOpenFileClose();
        //        mPrinting.XLClose();
        //    }

        //    return mPageNumber;
        //}

        #endregion;

        #region ----- Copy&Paste Sheet Method ----

        //ù��° ������ ����
        private int CopyAndPaste(int pCopySumPrintingLine)
        {
            int vCopySumPrintingLine = pCopySumPrintingLine;

            int vCopyPrintingRowSTART = vCopySumPrintingLine;
            vCopySumPrintingLine = vCopySumPrintingLine + mIncrementCopyMAX;
            int vCopyPrintingRowEnd = vCopySumPrintingLine;

            mPrinting.XLActiveSheet("SOURCE1");

            object vRangeSource = mPrinting.XLGetRange(mCopyColumnSTART, 1, mIncrementCopyMAX, mCopyColumnEND); //[����], [Sheet2.Cell("A1:AS67")], ���� ��Ʈ���� ���� ������ ���ȣ, ���� ��Ʈ���� ���� ������ ����ȣ, ���� ��Ʈ���� ���� ������ ���ȣ, ���� ��Ʈ���� ���� ������ ����ȣ
            mPrinting.XLActiveSheet("DESTINATION");
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
