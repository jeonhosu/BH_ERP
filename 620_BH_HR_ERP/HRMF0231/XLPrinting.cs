using System;
using ISCommonUtil;

namespace HRMF0231
{
    public class XLPrinting
    {
        #region ----- Variables -----

        private InfoSummit.Win.ControlAdv.ISAppInterface mAppInterface = null;
        private InfoSummit.Win.ControlAdv.ISMessageAdapter mMessageAdapter = null;

        ISFunction.ISConvert iConv = new ISFunction.ISConvert();

        private XL.XLPrint mPrinting = null;

        private string mMessageError = string.Empty;

        private string mXLOpenFileName = string.Empty;

        private int mPrintingLineSTART = 1;  //Line

        private int mCopyLineSUM = 1;        //������ ���õ� ��Ʈ�� ����Ǿ��� ���� �� ��ġ, ���� �� ����
        private int mIncrementCopyMAX = 33;  //����Ǿ��� ���� ����

        private int mCopyColumnSTART = 1; //���� ��
        private int mCopyColumnEND = 46;  //���� ��

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

        private void SetArray1(out string[] pNameColumn, out int[] pXLColumn)
        {
            pNameColumn = new string[20];
            pXLColumn = new int[20];

            pNameColumn[00] = "CERTIFICATE_TYPE_NAME"; //����
            pNameColumn[01] = "PRINT_NUM";             //�߱޹�ȣ
            pNameColumn[02] = "PERSON_NAME";           //����
            pNameColumn[03] = "RRN";                   //�ֹε�Ϲ�ȣ
            pNameColumn[04] = "PERSON_ADDRESS";        //�ּ�
            pNameColumn[05] = "POST_NAME";             //����[��å]
            pNameColumn[06] = "DEPT_NAME";             //�μ�
            pNameColumn[07] = "WORKING_NAME";          //������
            pNameColumn[08] = "JOIN_DATE";             //�Ի�����
            pNameColumn[09] = "EMPLOYMENT_PERIOD";      //�����Ⱓ[��������]
            pNameColumn[10] = "CONTINUE_YEAR";         //�ٹ��Ⱓ
            pNameColumn[11] = "DESCRIPTION";           //�뵵 
            pNameColumn[12] = "SEND_ORG";              //����ó
            pNameColumn[14] = "PRINT_DATE";            //�μ�����
            pNameColumn[15] = "CORP_ADDRESS";          //ȸ���ּ�
            pNameColumn[16] = "CORP_NAME";             //ȸ���
            pNameColumn[17] = "PRESIDENT_NAME";        //��ǥ�̻�
            pNameColumn[18] = "CORP_NAME";             //ȸ���
            pNameColumn[19] = "STAMP";                 //���� 


            pXLColumn[00] = 2;   //����
            pXLColumn[01] = 2;   //�߱޹�ȣ
            pXLColumn[02] = 10;  //����
            pXLColumn[03] = 30;  //�ֹε�Ϲ�ȣ
            pXLColumn[04] = 10;  //�ּ�
            pXLColumn[05] = 10;  //����[��å]
            pXLColumn[06] = 30;  //�μ�
            pXLColumn[07] = 10;  //������
            pXLColumn[08] = 30;  //�Ի�����
            pXLColumn[09] = 10;  //�����Ⱓ[��������]
            pXLColumn[10] = 36;  //�ٹ��Ⱓ
            pXLColumn[11] = 10;  //�뵵
            pXLColumn[12] = 10;  //����ó

            pXLColumn[13] = 2;   //����

            pXLColumn[14] = 3;   //�μ�����
            pXLColumn[15] = 14;  //ȸ���ּ�
            pXLColumn[16] = 14;  //ȸ���
            pXLColumn[17] = 14;  //��ǥ�̻�
            pXLColumn[18] = 14;  //ȸ���
            pXLColumn[19] = 2;   //ȸ���

        }

        #endregion;

        #region ----- IsConvert String Method -----

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

        #region ----- IsConvert Number Method -----

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

        #endregion;

        #region ----- IsConvert Date Method -----

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

        #region ----- Line Write Method -----

        private bool XLLine(System.Data.DataRow pROW, object pLANG_CODE, int pXLine, string[] pNameColumn, int[] pXLColumn)
        {
            bool isPrinting = false;

            int vXLine = pXLine; //������ ������ ǥ�õǴ� �� ��ȣ

            string vNameColumn = string.Empty;
            int vXLColumnIndex = 0;

            object vObject = null;
            string vConvertString = string.Empty;
            bool IsConvert = false;

            try
            {
                mPrinting.XLActiveSheet("Destination");

                //����
                vNameColumn = pNameColumn[0];
                vXLColumnIndex = pXLColumn[0];
                vObject = pROW[vNameColumn];
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
                vXLine = vXLine + 3;
                //-------------------------------------------------------------------

                ////�߱޹�ȣ
                vNameColumn = pNameColumn[1];
                vXLColumnIndex = pXLColumn[1];
                vObject = pROW[vNameColumn];
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
                vNameColumn = pNameColumn[2];
                vXLColumnIndex = pXLColumn[2];
                vObject = pROW[vNameColumn];
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

                //�ֹε�Ϲ�ȣ
                vNameColumn = pNameColumn[3];
                vXLColumnIndex = pXLColumn[3];
                vObject = pROW[vNameColumn];
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

                //�ּ�
                vNameColumn = pNameColumn[4];
                vXLColumnIndex = pXLColumn[4];
                vObject = pROW[vNameColumn];
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

                //����[��å]
                vNameColumn = pNameColumn[5];
                vXLColumnIndex = pXLColumn[5];
                vObject = pROW[vNameColumn];
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
                vNameColumn = pNameColumn[6];
                vXLColumnIndex = pXLColumn[6];
                vObject = pROW[vNameColumn];
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
                //������
                vNameColumn = pNameColumn[7];
                vXLColumnIndex = pXLColumn[7];
                vObject = pROW[vNameColumn];
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

                //�Ի�����
                vNameColumn = pNameColumn[8];
                vXLColumnIndex = pXLColumn[8];
                vObject = pROW[vNameColumn];
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

                //�����Ⱓ
                vNameColumn = pNameColumn[9];
                vXLColumnIndex = pXLColumn[9];
                vObject = pROW[vNameColumn];
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

                //�ٹ��Ⱓ
                vNameColumn = pNameColumn[10];
                vXLColumnIndex = pXLColumn[10];
                vObject = pROW[vNameColumn];
                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    vConvertString = string.Format("({0})", vConvertString);
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

                //�뵵
                vNameColumn = pNameColumn[11];
                vXLColumnIndex = pXLColumn[11];
                vObject = pROW[vNameColumn];
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
                //FCM_10190 : �� ����� ���� ���� �����ϰ� ������ �����մϴ�.
                //FCM_10191 : �� ����� ���� ���� �ٹ��Ͽ����� �����մϴ�.
                //01 : ��������
                //02 : �������
                //03 : ��������
                vXLColumnIndex = pXLColumn[13];
                vObject = pROW["CERTIFICATE_TYPE"];
                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    if (vConvertString == "01")
                    {
                        if (iConv.ISNull(pLANG_CODE) == "EN")
                        {
                            vConvertString = mMessageAdapter.ReturnText("FCM_10507"); 
                        }
                        else
                        {
                            vConvertString = mMessageAdapter.ReturnText("FCM_10190");
                        }                        
                    }
                    else if (vConvertString == "02")
                    {
                        if (iConv.ISNull(pLANG_CODE) == "EN")
                        {
                            vConvertString = mMessageAdapter.ReturnText("FCM_10508");
                        }
                        else
                        {
                            vConvertString = mMessageAdapter.ReturnText("FCM_10191");
                        }
                    }
                    else if (vConvertString == "03")
                    {
                        vConvertString = string.Empty;
                    }
                    else
                    {
                        vConvertString = string.Empty;
                    }

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

                //�μ�����
                vNameColumn = pNameColumn[14];
                vXLColumnIndex = pXLColumn[14];
                vObject = pROW[vNameColumn];
                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    string vYear = vConvertString.Substring(0, 4);
                    string vMonth = vConvertString.Substring(5, 2);
                    string vDay = vConvertString.Substring(8, 2);
                    vConvertString = string.Format("{0}�� {1}�� {2}��", vYear, vMonth, vDay);
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

                //ȸ���ּ�
                vNameColumn = pNameColumn[15];
                vXLColumnIndex = pXLColumn[15];
                vObject = pROW[vNameColumn];
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

                //ȸ���
                vNameColumn = pNameColumn[16];
                vXLColumnIndex = pXLColumn[16];
                vObject = pROW[vNameColumn];
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

                //��ǥ�̻�
                vNameColumn = pNameColumn[17];
                vXLColumnIndex = pXLColumn[17];
                vObject = pROW[vNameColumn];
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
                vXLine = vXLine + 3;
                //-------------------------------------------------------------------

                //ȸ���(����)
                vNameColumn = pNameColumn[19];
                vXLColumnIndex = pXLColumn[19];
                vObject = pROW[vNameColumn];
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

                isPrinting = true;
            }
            catch (System.Exception ex)
            {
                mMessageError = ex.Message;
                mAppInterface.OnAppMessageEvent(mMessageError);
                System.Windows.Forms.Application.DoEvents();
            }

            return isPrinting;
        }

        #endregion;

        #endregion;

        #region ----- Excel Wirte [Line] Methods ----

        public bool LineWrite(System.Data.DataRow pROW, object pLANG_CODE)
        {
            bool isPrinting = false;
            string vMessage = string.Empty;

            string[] vNameColumn;
            int[] vXLColumn;

            int vPrintingLine = 0;

            try
            {
                mCopyLineSUM = CopyAndPaste(mCopyLineSUM, pLANG_CODE);

                #region ----- Line Write ----

                if (pROW != null)
                {
                    vPrintingLine = mPrintingLineSTART;

                    SetArray1(out vNameColumn, out vXLColumn);

                    isPrinting = XLLine(pROW, pLANG_CODE, vPrintingLine, vNameColumn, vXLColumn);
                }

                #endregion;
            }
            catch (System.Exception ex)
            {
                mMessageError = ex.Message;
                mAppInterface.OnAppMessageEvent(mMessageError);
                System.Windows.Forms.Application.DoEvents();
            }

            return isPrinting;
        }

        #endregion;

        #region ----- Copy&Paste Sheet Method ----

        private int CopyAndPaste(int pCopySumPrintingLine, object pLANG_CODE)
        {
            int vCopySumPrintingLine = pCopySumPrintingLine;

            int vCopyPrintingRowSTART = vCopySumPrintingLine;
            vCopySumPrintingLine = vCopySumPrintingLine + mIncrementCopyMAX;
            int vCopyPrintingRowEnd = vCopySumPrintingLine;

            string vSOURCE_TAB = "SourceTab_KO";
            if (iConv.ISNull(pLANG_CODE) == "EN")
            {
                vSOURCE_TAB = "SourceTab_EN";
            }

            mPrinting.XLActiveSheet(vSOURCE_TAB);
            object vRangeSource = mPrinting.XLGetRange(mCopyColumnSTART, 1, mIncrementCopyMAX, mCopyColumnEND); //[����], [Sheet2.Cell("A1:AS67")], ���� ��Ʈ���� ���� ������ ���ȣ, ���� ��Ʈ���� ���� ������ ����ȣ, ���� ��Ʈ���� ���� ������ ���ȣ, ���� ��Ʈ���� ���� ������ ����ȣ
            mPrinting.XLActiveSheet("Destination");
            object vRangeDestination = mPrinting.XLGetRange(vCopyPrintingRowSTART, 1, vCopyPrintingRowEnd, mCopyColumnEND); //[���], [Sheet1.Cell("A1:AS67")], ���� ��Ʈ���� ���� ������ ���ȣ, ���� ��Ʈ���� ���� ������ ����ȣ, ���� ��Ʈ���� ���� ������ ���ȣ, ���� ��Ʈ���� ���� ������ ����ȣ
            mPrinting.XLCopyRange(vRangeSource, vRangeDestination);

            return vCopySumPrintingLine;
        }

        #endregion;

        #region ----- Printing Methods ----

        public void Printing(int pPageSTART, int pPageEND, int pCopies)
        {
            mPrinting.XLPreviewPrinting(pPageSTART, pPageEND, pCopies);
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
