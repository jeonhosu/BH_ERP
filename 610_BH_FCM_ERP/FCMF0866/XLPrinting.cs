using System;

namespace FCMF0866
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

        private int mPrintingLineSTART_SOURCE2 = 11;   //Line

        private int mCopyLineSUM = 1;        //������ ���õ� ��Ʈ�� ����Ǿ��� ���� �� ��ġ, ���� �� ����
        private int mIncrementCopyMAX = 38;  //����Ǿ��� ���� ����

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
            pGDColumn = new int[6];
            pXLColumn = new int[6];

            pGDColumn[0] = pGrid.GetColumnToIndex("DPR_ASSET_GB"); //�ڻ걸��
            pGDColumn[1] = pGrid.GetColumnToIndex("VAT_ISSUE_DATE"); //���޹�������
            pGDColumn[2] = pGrid.GetColumnToIndex("SUPPLIER_NAME"); //�ŷ�ó��
            pGDColumn[3] = pGrid.GetColumnToIndex("SPEC_CONTENTS"); //ǰ��׳���
            pGDColumn[4] = pGrid.GetColumnToIndex("SUP_AMOUNT"); //���ް���
            pGDColumn[5] = pGrid.GetColumnToIndex("SURTAX"); //�ΰ���


            pXLColumn[0] = 2;   //�ڻ걸��
            pXLColumn[1] = 8;   //���޹�������
            pXLColumn[2] = 13;  //�ŷ�ó��
            pXLColumn[3] = 22;  //ǰ��׳���
            pXLColumn[4] = 32;  //���ް���
            pXLColumn[5] = 39;  //�ΰ���
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

        private void XLHeader(InfoSummit.Win.ControlAdv.ISDataAdapter p_adapter_PRINT_BUILDING_DPR_SPEC_TITLE)
        {
            int vCountRow = 0;
            int vXLine = 0;
            int vXLColumn = 0;
            object vObject = null;
            string vConvertString = string.Empty;
            bool IsConvert = false;

            try
            {
                vCountRow = p_adapter_PRINT_BUILDING_DPR_SPEC_TITLE.OraSelectData.Rows.Count;

                if (vCountRow > 0)
                {
                    mPrinting.XLActiveSheet("SOURCE2");

                    //�ΰ���ġ���Ű���
                    vObject = p_adapter_PRINT_BUILDING_DPR_SPEC_TITLE.OraSelectData.Rows[0]["FISCAL_YEAR"];
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
                    vObject = p_adapter_PRINT_BUILDING_DPR_SPEC_TITLE.OraSelectData.Rows[0]["CORP_NAME"];
                    vXLine = 7;
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
                    vObject = p_adapter_PRINT_BUILDING_DPR_SPEC_TITLE.OraSelectData.Rows[0]["VAT_NUMBER"];
                    vXLine = 7;
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

                    //����
                    vObject = p_adapter_PRINT_BUILDING_DPR_SPEC_TITLE.OraSelectData.Rows[0]["BUSINESS_ITEM"];
                    vXLine = 8;
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

                    //����
                    vObject = p_adapter_PRINT_BUILDING_DPR_SPEC_TITLE.OraSelectData.Rows[0]["BUSINESS_TYPE"];
                    vXLine = 8;
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

                    mPrinting.XLActiveSheet("SOURCE1");

                    //�ΰ���ġ���Ű���
                    vObject = p_adapter_PRINT_BUILDING_DPR_SPEC_TITLE.OraSelectData.Rows[0]["FISCAL_YEAR"];
                    vXLine = 5;
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
                    vObject = p_adapter_PRINT_BUILDING_DPR_SPEC_TITLE.OraSelectData.Rows[0]["CORP_NAME"];
                    vXLine = 8;
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
                    vObject = p_adapter_PRINT_BUILDING_DPR_SPEC_TITLE.OraSelectData.Rows[0]["VAT_NUMBER"];
                    vXLine = 8;
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

                    //����
                    vObject = p_adapter_PRINT_BUILDING_DPR_SPEC_TITLE.OraSelectData.Rows[0]["BUSINESS_ITEM"];
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

                    //����
                    vObject = p_adapter_PRINT_BUILDING_DPR_SPEC_TITLE.OraSelectData.Rows[0]["BUSINESS_TYPE"];
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

                    //�ۼ�����
                    vObject = p_adapter_PRINT_BUILDING_DPR_SPEC_TITLE.OraSelectData.Rows[0]["CREATE_DATE"];
                    vXLine = 19;
                    vXLColumn = 23;
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

                    //������
                    vObject = p_adapter_PRINT_BUILDING_DPR_SPEC_TITLE.OraSelectData.Rows[0]["CORP_NAME"];
                    vXLine = 20;
                    vXLColumn = 23;
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

                    //���Ҽ�����
                    vObject = p_adapter_PRINT_BUILDING_DPR_SPEC_TITLE.OraSelectData.Rows[0]["TAX_OFFICE_NAME"];
                    vXLine = 22;
                    vXLColumn = 4;
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

        private void XLSUM(InfoSummit.Win.ControlAdv.ISGridAdvEx p_grid_LIST_BUILDING_DPR_SPEC_MST)
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
                vCountRow = p_grid_LIST_BUILDING_DPR_SPEC_MST.RowCount;

                if (vCountRow > 0)
                {
                    mPrinting.XLActiveSheet("SOURCE1");

                    for (int vRow = 0; vRow < vCountRow; vRow++)
                    {
                        vGDColumnIndex = p_grid_LIST_BUILDING_DPR_SPEC_MST.GetColumnToIndex("SEQ");
                        vObject = p_grid_LIST_BUILDING_DPR_SPEC_MST.GetCellValue(vRow, vGDColumnIndex);
                        IsConvert = IsConvertNumber(vObject, out vGuBun);
                        if (IsConvert == true)
                        {
                            if (vGuBun == 5) //�հ�
                            {
                                vXLine = 12;
                            }
                            else if (vGuBun == 6) //(1)�ǹ�.���๰
                            {
                                vXLine = 13;
                            }
                            else if (vGuBun == 7) //(2)�����ġ
                            {
                                vXLine = 14;
                            }
                            else if (vGuBun == 8) //(3)������ݱ�
                            {
                                vXLine = 15;
                            }
                            else if (vGuBun == 9) //(4)��Ÿ�������ڻ�
                            {
                                vXLine = 16;
                            }
                        }

                        //�Ǽ�
                        vGDColumnIndex = p_grid_LIST_BUILDING_DPR_SPEC_MST.GetColumnToIndex("ASSET_CNT");
                        vObject = p_grid_LIST_BUILDING_DPR_SPEC_MST.GetCellValue(vRow, vGDColumnIndex);
                        vXLColumn = 15;
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
                        vGDColumnIndex = p_grid_LIST_BUILDING_DPR_SPEC_MST.GetColumnToIndex("SUP_AMOUNT");
                        vObject = p_grid_LIST_BUILDING_DPR_SPEC_MST.GetCellValue(vRow, vGDColumnIndex);
                        vXLColumn = 21;
                        IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                        if (IsConvert == true)
                        {
                            vConvertString = string.Format("{0:##,###,###,###,###,###,###,###,###.##}", vConvertDecimal);
                            mPrinting.XLSetCell(vXLine, vXLColumn, vConvertString);
                        }
                        else
                        {
                            vConvertString = string.Empty;
                            mPrinting.XLSetCell(vXLine, vXLColumn, vConvertString);
                        }

                        //�ΰ���
                        vGDColumnIndex = p_grid_LIST_BUILDING_DPR_SPEC_MST.GetColumnToIndex("SURTAX");
                        vObject = p_grid_LIST_BUILDING_DPR_SPEC_MST.GetCellValue(vRow, vGDColumnIndex);
                        vXLColumn = 30;
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
                        vGDColumnIndex = p_grid_LIST_BUILDING_DPR_SPEC_MST.GetColumnToIndex("REMARKS");
                        vObject = p_grid_LIST_BUILDING_DPR_SPEC_MST.GetCellValue(vRow, vGDColumnIndex);
                        vXLColumn = 37;
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

                //�ڻ걸��
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

                //���޹�������
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

                //�ŷ�ó��
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

                //ǰ��׳���
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

                //���ް���
                vGDColumnIndex = pGDColumn[4];
                vXLColumnIndex = pXLColumn[4];
                vObject = pGrid.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:##,###,###,###,###,###,###,###,###.##}", vConvertDecimal);
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }
                else
                {
                    vConvertString = string.Empty;
                    mPrinting.XLSetCell(vXLine, vXLColumnIndex, vConvertString);
                }

                //�ΰ���
                vGDColumnIndex = pGDColumn[5];
                vXLColumnIndex = pXLColumn[5];
                vObject = pGrid.GetCellValue(pGridRow, vGDColumnIndex);
                IsConvert = IsConvertNumber(vObject, out vConvertDecimal);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("{0:##,###,###,###,###,###,###,###,###.##}", vConvertDecimal);
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

        #endregion;

        #region ----- Excel Wirte [Line] Methods ----

        public int LineWrite(InfoSummit.Win.ControlAdv.ISGridAdvEx p_grid_LIST_BUILDING_DPR_SPEC_MST, InfoSummit.Win.ControlAdv.ISGridAdvEx p_grid_LIST_BUILDING_DPR_SPEC_DET, InfoSummit.Win.ControlAdv.ISDataAdapter p_adapter_PRINT_BUILDING_DPR_SPEC_TITLE)
        {
            mPageNumber = 0;
            string vMessage = string.Empty;

            int[] vGDColumn;
            int[] vXLColumn;

            int vPrintingLine = 0;

            try
            {
                int vTotal1ROW = p_grid_LIST_BUILDING_DPR_SPEC_DET.RowCount;

                #region ----- Header/SUM Write ----

                XLHeader(p_adapter_PRINT_BUILDING_DPR_SPEC_TITLE);
                XLSUM(p_grid_LIST_BUILDING_DPR_SPEC_MST);

                mCopyLineSUM = CopyAndPaste("SOURCE1", mCopyLineSUM);

                #endregion;

                #region ----- Line Write ----

                if (vTotal1ROW > 0)
                {
                    int vCountROW1 = 0;

                    vPrintingLine = mPrintingLineSTART_SOURCE2;

                    SetArray1(p_grid_LIST_BUILDING_DPR_SPEC_DET, out vGDColumn, out vXLColumn);

                    mCopyLineSUM = CopyAndPaste("SOURCE2", mCopyLineSUM);
                    vPrintingLine = (mCopyLineSUM - mIncrementCopyMAX) + (mPrintingLineSTART_SOURCE2 - 1);

                    for (int vRow1 = 0; vRow1 < vTotal1ROW; vRow1++)
                    {
                        vCountROW1++;

                        vMessage = string.Format("Grid2 : {0}/{1}", vCountROW1, vTotal1ROW);
                        mAppInterface.OnAppMessageEvent(vMessage);
                        System.Windows.Forms.Application.DoEvents();

                        vPrintingLine = XLLine(p_grid_LIST_BUILDING_DPR_SPEC_DET, vRow1, vPrintingLine, vGDColumn, vXLColumn);

                        if (vTotal1ROW == vCountROW1)
                        {
                            //������ ���̸�...
                        }
                        else
                        {
                            IsNewPage(vPrintingLine);
                            if (mIsNewPage == true)
                            {
                                vPrintingLine = (mCopyLineSUM - mIncrementCopyMAX) + (mPrintingLineSTART_SOURCE2 - 1);
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
            int vPrintingLineEND = mCopyLineSUM - 1; //1~38: mCopyLineSUM=39���� ������ ��µǴ� ���� 38 ���� �̹Ƿ�, 1�� ���� �ȴ�
            if (vPrintingLineEND < pPrintingLine)
            {
                mIsNewPage = true;
                mCopyLineSUM = CopyAndPaste("SOURCE2", mCopyLineSUM);
            }
            else
            {
                mIsNewPage = false;
            }
        }

        #endregion;

        #region ----- Copy&Paste Sheet Method ----

        //ù��° ������ ����
        private int CopyAndPaste(string pSheetTab, int pCopySumPrintingLine)
        {
            int vCopySumPrintingLine = pCopySumPrintingLine;

            int vCopyPrintingRowSTART = vCopySumPrintingLine;
            vCopySumPrintingLine = vCopySumPrintingLine + mIncrementCopyMAX;
            int vCopyPrintingRowEnd = vCopySumPrintingLine;

            mPrinting.XLActiveSheet(pSheetTab);

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
