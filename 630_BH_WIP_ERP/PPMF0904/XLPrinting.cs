using System;
using ISCommonUtil;

namespace PPMF0904
{
    public class XLPrinting
    {
        #region ----- Variables -----

        ISFunction.ISConvert iString = new ISFunction.ISConvert();
        ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();

        private InfoSummit.Win.ControlAdv.ISAppInterface mAppInterface = null;
        private InfoSummit.Win.ControlAdv.ISMessageAdapter mMessageAdapter = null;

        private XL.XLPrint mPrinting = null;

        // ��Ʈ�� ����.
        private string mTargetSheet = "Sheet1";
        private string mSourceSheet1 = "Source1";
        private string mSourceSheet2 = "Source2";

        private string mMessageError = string.Empty;
        private string mXLOpenFileName = string.Empty;

        //private int mPageTotalNumber = 0;
        private int mPageNumber = 0;

        private bool mIsNewPage = false;  // ù ������ üũ.

        // �μ�� ���ο� �հ�.
        private int mCopyLineSUM = 0;

        // �μ� 1���� �ִ� �μ�����.
        private int mCopy_StartCol = 1;
        private int mCopy_StartRow = 1;
        private int mCopy_EndCol = 67;
        private int mCopy_EndRow = 36;
        private int mPrintingLastRow = 35;  //���� ������ �μ� ���� ����.

        private int mCurrentRow = 5;        //���� �μ�Ǵ� row ��ġ.
        private int mDefaultPageRow = 4;    //������ skip�� ����Ǵ� �⺻ PageCount �⺻��.

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

        #region ----- Array Set 1 ----

        private void SetArray1(InfoSummit.Win.ControlAdv.ISGridAdvEx pGrid, out int[] pGDColumn, out int[] pXLColumn)
        {// �׸����� �÷��� ���� �÷��ε��� �� ����
            pGDColumn = new int[15];
            pXLColumn = new int[15];
            // �׸��� or �ƴ��� ��ġ.
            pGDColumn[0] = pGrid.GetColumnToIndex("INVOICE_NO");
            pGDColumn[1] = pGrid.GetColumnToIndex("PURCHASE_DATE");
            pGDColumn[2] = pGrid.GetColumnToIndex("SUPPLIER_NAME");
            pGDColumn[3] = pGrid.GetColumnToIndex("BOM_ITEM_CODE");
            pGDColumn[4] = pGrid.GetColumnToIndex("BOM_ITEM_DESCRIPTION");
            pGDColumn[5] = pGrid.GetColumnToIndex("JOB_NO");
            pGDColumn[6] = pGrid.GetColumnToIndex("PURCHASE_UOM_QTY");
            pGDColumn[7] = pGrid.GetColumnToIndex("INVOICE_UOM_QTY");
            pGDColumn[8] = pGrid.GetColumnToIndex("ITEM_UOM_CODE");
            pGDColumn[9] = pGrid.GetColumnToIndex("CURRENCY_CODE");
            pGDColumn[10] = pGrid.GetColumnToIndex("ITEM_PRICE");
            pGDColumn[11] = pGrid.GetColumnToIndex("ITEM_AMOUNT");
            pGDColumn[12] = pGrid.GetColumnToIndex("EXCHANGE_RATE");
            pGDColumn[13] = pGrid.GetColumnToIndex("EXCHANGE_ITEM_AMOUNT");

            // ������ �μ��ؾ� �� ��ġ.
            pXLColumn[0] = 1;
            pXLColumn[1] = 6;
            pXLColumn[2] = 10;
            pXLColumn[3] = 18;
            pXLColumn[4] = 25;
            pXLColumn[5] = 35;
            pXLColumn[6] = 42;
            pXLColumn[7] = 46;
            pXLColumn[8] = 49;
            pXLColumn[9] = 51;
            pXLColumn[10] = 53;
            pXLColumn[11] = 56;
            pXLColumn[12] = 60;
            pXLColumn[13] = 63;
        }

        #endregion;

        #region ----- IsConvert Methods -----

        private bool IsConvertString(object pObject, out string pConvertString)
        {// ���ڿ� ���� üũ �� �ش� �� ����.
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
        {// ���� ���� üũ �� �ش� �� ����.
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
        {// ��¥ ���� üũ �� �ش� �� ����.
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

        #region ----- Excel Write -----

        #region ----- Header Write Method ----

        public void HeaderWrite(int pTerritory1, Object pV_DATE_FR, object pV_DATE_TO)
        {// ��� �μ�.
            int vXLine = 0;
            int vXLColumn = 0;

            try
            {
                if (pTerritory1 == 1)
                {
                    mPrinting.XLActiveSheet(mSourceSheet2);
                }
                else
                {
                    mPrinting.XLActiveSheet(mSourceSheet1);
                }
                

                //corporation
                vXLine = 3;
                vXLColumn = 5;

                mPrinting.XLSetCell(vXLine, vXLColumn, pV_DATE_FR);

                //period
                vXLine = 3;
                vXLColumn = 10;

                mPrinting.XLSetCell(vXLine, vXLColumn, pV_DATE_TO);

            }
            catch (System.Exception ex)
            {
                mMessageError = ex.Message;
                mAppInterface.OnAppMessageEvent(mMessageError);
                System.Windows.Forms.Application.DoEvents();
            }
        }

        #endregion;

        #region ----- Excel Write [Line] Method -----

        private int LineWrite(InfoSummit.Win.ControlAdv.ISGridAdvEx pGrid, int pGridRow, int pXLine, int[] pGDColumn, int[] pXLColumn)
        {// pGridRow : �׸����� ���� �д� ��, pXLine : ������ �μ��ؾ� �ϴ� ��
            int vXLine = pXLine; //������ ������ ǥ�õǴ� �� ��ȣ

            // ���Ǵ� ���� ����.
            object vObject = null;
            string vConvertString = string.Empty;

            //���� ���� ���� ��.
            //decimal vConvertDecimal = 0m;
            //DateTime vCONVERT_DATE = new DateTime(); ;
            //vConvertString = string.Format("{0:###,###,###,###,###,###,###,###}", vConvertDecimal);
            try
            { // ������ �����ؼ� Ÿ�� �� ������ ����.(
                mPrinting.XLActiveSheet(mTargetSheet);

                //0 - Invoice No
                vObject = pGrid.GetCellValue(pGridRow, pGDColumn[0]);
                if (iString.ISNull(vObject) != string.Empty)
                {
                    vConvertString = string.Format("{0}", vObject);
                }
                else
                {
                    vConvertString = string.Empty;
                }
                mPrinting.XLSetCell(vXLine, pXLColumn[0], vConvertString);

                //1 - ������
                vObject = pGrid.GetCellValue(pGridRow, pGDColumn[1]);
                if (iString.ISNull(vObject) != string.Empty)
                {
                    vConvertString = string.Format("{0}", vObject);
                }
                else
                {
                    vConvertString = string.Empty;
                }
                mPrinting.XLSetCell(vXLine, pXLColumn[1], vConvertString);

                //2-����ó
                vObject = pGrid.GetCellValue(pGridRow, pGDColumn[2]);
                if (iString.ISNull(vObject) != string.Empty)
                {
                    vConvertString = string.Format("{0}", vObject);
                }
                else
                {
                    vConvertString = string.Empty;
                }
                mPrinting.XLSetCell(vXLine, pXLColumn[2], vConvertString);

                //3 - �ڵ�
                vObject = pGrid.GetCellValue(pGridRow, pGDColumn[3]);
                if (iString.ISNull(vObject) != string.Empty)
                {
                    vConvertString = string.Format("{0}", vObject);
                }
                else
                {
                    vConvertString = string.Empty;
                }
                mPrinting.XLSetCell(vXLine, pXLColumn[3], vConvertString);

                //4 - �𵨸�.
                vObject = pGrid.GetCellValue(pGridRow, pGDColumn[4]);
                if (iString.ISNull(vObject) != string.Empty)
                {
                    vConvertString = string.Format("{0}", vObject);
                }
                else
                {
                    vConvertString = string.Empty;
                }
                mPrinting.XLSetCell(vXLine, pXLColumn[4], vConvertString);

                //5 - Lot No.
                vObject = pGrid.GetCellValue(pGridRow, pGDColumn[5]);
                if (iString.ISNull(vObject) != string.Empty)
                {
                    vConvertString = string.Format("{0}", vObject);
                }
                else
                {
                    vConvertString = string.Empty;
                }
                mPrinting.XLSetCell(vXLine, pXLColumn[5], vConvertString);

                //5 - �Ǹ��Է�
                vObject = pGrid.GetCellValue(pGridRow, pGDColumn[6]);
                if (iString.ISNull(vObject) != string.Empty)
                {
                    vConvertString = string.Format("{0}", vObject);
                }
                else
                {
                    vConvertString = string.Empty;
                }
                mPrinting.XLSetCell(vXLine, pXLColumn[6], vConvertString);

                //6 - Invoice��
                vObject = pGrid.GetCellValue(pGridRow, pGDColumn[7]);
                if (iString.ISNull(vObject) != string.Empty)
                {
                    vConvertString = string.Format("{0}", vObject);
                }
                else
                {
                    vConvertString = string.Empty;
                }
                mPrinting.XLSetCell(vXLine, pXLColumn[7], vConvertString);

                //7 - ����
                vObject = pGrid.GetCellValue(pGridRow, pGDColumn[8]);
                if (iString.ISNull(vObject) != string.Empty)
                {
                    vConvertString = string.Format("{0}", vObject);
                }
                else
                {
                    vConvertString = string.Empty;
                }
                mPrinting.XLSetCell(vXLine, pXLColumn[8], vConvertString);

                //8 - ����
                vObject = pGrid.GetCellValue(pGridRow, pGDColumn[9]);
                if (iString.ISNull(vObject) != string.Empty)
                {
                    vConvertString = string.Format("{0}", vObject);
                }
                else
                {
                    vConvertString = string.Empty;
                }
                mPrinting.XLSetCell(vXLine, pXLColumn[9], vConvertString);

                //9 - ��ȭ
                vObject = pGrid.GetCellValue(pGridRow, pGDColumn[10]);
                if (iString.ISNull(vObject) != string.Empty)
                {
                    vConvertString = string.Format("{0}", vObject);
                }
                else
                {
                    vConvertString = string.Empty;
                }
                mPrinting.XLSetCell(vXLine, pXLColumn[10], vConvertString);

                //10 - �ܰ�
                vObject = pGrid.GetCellValue(pGridRow, pGDColumn[11]);
                if (iString.ISNull(vObject) != string.Empty)
                {
                    vConvertString = string.Format("{0}", vObject);
                }
                else
                {
                    vConvertString = string.Empty;
                }
                mPrinting.XLSetCell(vXLine, pXLColumn[11], vConvertString);

                //11 - ��ȭ�ݾ�
                vObject = pGrid.GetCellValue(pGridRow, pGDColumn[12]);
                if (iString.ISNull(vObject) != string.Empty)
                {
                    vConvertString = string.Format("{0}", vObject);
                }
                else
                {
                    vConvertString = string.Empty;
                }
                mPrinting.XLSetCell(vXLine, pXLColumn[12], vConvertString);

                //12 - ȯ��
                vObject = pGrid.GetCellValue(pGridRow, pGDColumn[13]);
                if (iString.ISNull(vObject) != string.Empty)
                {
                    vConvertString = string.Format("{0}", vObject);
                }
                else
                {
                    vConvertString = string.Empty;
                }
                mPrinting.XLSetCell(vXLine, pXLColumn[13], vConvertString);

                //13 - ��ȭ�ݾ�
                vObject = pGrid.GetCellValue(pGridRow, pGDColumn[14]);
                if (iString.ISNull(vObject) != string.Empty)
                {
                    vConvertString = string.Format("{0}", vObject);
                }
                else
                {
                    vConvertString = string.Empty;
                }
                mPrinting.XLSetCell(vXLine, pXLColumn[14], vConvertString);
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

        #region ----- PageNumber Write Method -----

        private void XLPageNumber(string pActiveSheet, object pPageNumber)
        {// ���������� ������Ʈ �����ϱ� ���� ������Ʈ�� ����ϰ� ��Ʈ�� �����Ѵ�.

            int vXLRow = 31; //������ ������ ǥ�õǴ� �� ��ȣ
            int vXLCol = 40;

            try
            { // ������ �����ؼ� Ÿ�� �� ������ ����.(
                mPrinting.XLActiveSheet(pActiveSheet);
                mPrinting.XLSetCell(vXLRow, vXLCol, pPageNumber);
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

        #region ----- Excel Wirte MAIN Methods ----

        public int ExcelWrite(InfoSummit.Win.ControlAdv.ISGridAdvEx pGrid, int pTerritory1, object pV_DATE_FR, object pV_DATE_TO)
        {// ���� ȣ��Ǵ� �κ�.

            string vMessage = string.Empty;

            int[] vGDColumn;
            int[] vXLColumn;
            int vTotalRow = 0;
            int vPageRowCount = 0;
            
            try
            {
                HeaderWrite(pTerritory1, pV_DATE_FR, pV_DATE_TO);
                //HeaderWrite(pPrinted_Value);
                // ������ �����ؼ� Ÿ�꽬Ʈ�� �ٿ� �ִ´�.
                if (pTerritory1 == 1)
                {
                    mCopyLineSUM = CopyAndPaste(mPrinting, mSourceSheet2, 1);
                }
                else
                {
                    mCopyLineSUM = CopyAndPaste(mPrinting, mSourceSheet1, 1);
                }
                       
                vTotalRow = pGrid.RowCount;
                vPageRowCount = mCurrentRow - 1;    //ù�忡 ���ؼ��� ����row���� üũ.

                #region ----- Line Write ----

                if (vTotalRow > 0)
                {
                    SetArray1(pGrid, out vGDColumn, out vXLColumn);
                    for (int vRow = 0; vRow < vTotalRow; vRow++)
                    {
                        vMessage = string.Format("Printing : {0}/{1}", vRow, vTotalRow);
                        mAppInterface.OnAppMessageEvent(vMessage);
                        System.Windows.Forms.Application.DoEvents();

                        mCurrentRow = LineWrite(pGrid, vRow, mCurrentRow, vGDColumn, vXLColumn); // ���� ��ġ �μ� �� ���� �μ��� ����.
                        vPageRowCount = vPageRowCount + 1;

                        if (vRow == vTotalRow - 1)
                        {
                            // ������ ������ �̸� ó���� ���� ���
                            // ��������� �Ǵ� �հ踦 ǥ���Ѵ� �� ���.
                            //mCurrentRow = XLTOTAL_Line(9);      //�հ�.
                            //mCurrentRow = XLTOTAL_Line(13);     // ������ȭ �հ�.
                        }
                        else
                        {
                            IsNewPage(vPageRowCount, pTerritory1);   // ���ο� ������ üũ �� ����.
                            if (mIsNewPage == true)
                            {
                                mCurrentRow = mCurrentRow + mCopy_EndRow - mPrintingLastRow + mDefaultPageRow;  // ������ �μ�� �ش� �������� ���۵Ǵ� ��ġ.
                                vPageRowCount = mDefaultPageRow;
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
            if (mPageNumber == 0)
            {
                mPageNumber = 1;
            }
            return mPageNumber;
        }

        #endregion;

        #region ----- New Page iF Methods ----

        private void IsNewPage(int pPageRowCount, int pTerritory1)
        {
            int iDefaultEndRow = 1;
            if (pPageRowCount == mPrintingLastRow)
            { // pPrintingLine : ���� ��µ� ��.
                mIsNewPage = true;
                iDefaultEndRow = mCopy_EndRow - mPrintingLastRow;

                if (pTerritory1 == 1)
                {
                    mCopyLineSUM = CopyAndPaste(mPrinting, mSourceSheet2, mCurrentRow + iDefaultEndRow);
                }
                else
                {
                    mCopyLineSUM = CopyAndPaste(mPrinting, mSourceSheet1, mCurrentRow + iDefaultEndRow);
                }
                
            }
            else
            {
                mIsNewPage = false;
            }
        }

        #endregion;

        #region ----- Copy&Paste Sheet Method ----

        //������ ActiveSheet�� ������ ����  ������ ����
        private int CopyAndPaste(XL.XLPrint pPrinting, string pActiveSheet, int pPasteStartRow)
        {
            int vPasteEndRow = pPasteStartRow + mCopy_EndRow;

            // page�� ǥ��.
            mPageNumber = mPageNumber + 1;
            XLPageNumber(pActiveSheet, mPageNumber);

            //[����], [Sheet2.Cell("A1:AS67")], ���� ��Ʈ���� ���� ������ ���ȣ, 
            //���� ��Ʈ���� ���� ������ ����ȣ, ���� ��Ʈ���� ���� ������ ���ȣ, ���� ��Ʈ���� ���� ������ ����ȣ
            pPrinting.XLActiveSheet(pActiveSheet);
            object vRangeSource = pPrinting.XLGetRange(mCopy_StartRow, mCopy_StartCol, mCopy_EndRow, mCopy_EndCol);

            //[���], [Sheet1.Cell("A1:AS67")], ���� ��Ʈ���� ���� ������ ���ȣ, 
            //���� ��Ʈ���� ���� ������ ����ȣ, ���� ��Ʈ���� ���� ������ ���ȣ, ���� ��Ʈ���� ���� ������ ����ȣ
            pPrinting.XLActiveSheet(mTargetSheet);
            object vRangeDestination = pPrinting.XLGetRange(pPasteStartRow, mCopy_StartCol, vPasteEndRow, mCopy_EndCol);
            pPrinting.XLCopyRange(vRangeSource, vRangeDestination);  // ����.

            return vPasteEndRow;


            //int vCopySumPrintingLine = pCopySumPrintingLine;

            //int vCopyPrintingRowSTART = vCopySumPrintingLine;
            //vCopySumPrintingLine = vCopySumPrintingLine + mIncrementCopyMAX;
            //int vCopyPrintingRowEnd = vCopySumPrintingLine;

            //pPrinting.XLActiveSheet("SourceTab1");
            //object vRangeSource = pPrinting.XLGetRange(mCopyColumnSTART, 1, mIncrementCopyMAX, mCopyColumnEND); //[����], [Sheet2.Cell("A1:AS67")], ���� ��Ʈ���� ���� ������ ���ȣ, ���� ��Ʈ���� ���� ������ ����ȣ, ���� ��Ʈ���� ���� ������ ���ȣ, ���� ��Ʈ���� ���� ������ ����ȣ
            //pPrinting.XLActiveSheet("Destination");
            //object vRangeDestination = pPrinting.XLGetRange(vCopyPrintingRowSTART, 1, vCopyPrintingRowEnd, mCopyColumnEND); //[���], [Sheet1.Cell("A1:AS67")], ���� ��Ʈ���� ���� ������ ���ȣ, ���� ��Ʈ���� ���� ������ ����ȣ, ���� ��Ʈ���� ���� ������ ���ȣ, ���� ��Ʈ���� ���� ������ ����ȣ
            //pPrinting.XLCopyRange(vRangeSource, vRangeDestination);  // ����.


            //mPageNumber++; //������ ��ȣ
            //// ������ ��ȣ ǥ��.
            ////string vPageNumberText = string.Format("Page {0}/{1}", mPageNumber, mPageTotalNumber);
            ////int vRowSTART = vCopyPrintingRowEnd - 2;
            ////int vRowEND = vCopyPrintingRowEnd - 2;
            ////int vColumnSTART = 30;
            ////int vColumnEND = 33;
            ////mPrinting.XLCellMerge(vRowSTART, vColumnSTART, vRowEND, vColumnEND, false);
            ////mPrinting.XLSetCell(vRowSTART, vColumnSTART, vPageNumberText); //������ ��ȣ, XLcell[��, ��]

            //return vCopySumPrintingLine;
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
            if (pSaveFileName == string.Empty)
            {
                return;
            }
            mPrinting.XLSave(pSaveFileName);
        }

        #endregion;
    }
}
