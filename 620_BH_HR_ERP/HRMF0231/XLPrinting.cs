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

        private int mCopyLineSUM = 1;        //엑셀의 선택된 쉬트의 복사되어질 시작 행 위치, 복사 행 누적
        private int mIncrementCopyMAX = 33;  //복사되어질 행의 범위

        private int mCopyColumnSTART = 1; //시작 열
        private int mCopyColumnEND = 46;  //종료 열

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

            pNameColumn[00] = "CERTIFICATE_TYPE_NAME"; //증명서
            pNameColumn[01] = "PRINT_NUM";             //발급번호
            pNameColumn[02] = "PERSON_NAME";           //성명
            pNameColumn[03] = "RRN";                   //주민등록번호
            pNameColumn[04] = "PERSON_ADDRESS";        //주소
            pNameColumn[05] = "POST_NAME";             //직위[직책]
            pNameColumn[06] = "DEPT_NAME";             //부서
            pNameColumn[07] = "WORKING_NAME";          //담당업무
            pNameColumn[08] = "JOIN_DATE";             //입사일자
            pNameColumn[09] = "EMPLOYMENT_PERIOD";      //재직기간[최초일자]
            pNameColumn[10] = "CONTINUE_YEAR";         //근무기간
            pNameColumn[11] = "DESCRIPTION";           //용도 
            pNameColumn[12] = "SEND_ORG";              //제출처
            pNameColumn[14] = "PRINT_DATE";            //인쇄일자
            pNameColumn[15] = "CORP_ADDRESS";          //회사주소
            pNameColumn[16] = "CORP_NAME";             //회사명
            pNameColumn[17] = "PRESIDENT_NAME";        //대표이사
            pNameColumn[18] = "CORP_NAME";             //회사명
            pNameColumn[19] = "STAMP";                 //직인 


            pXLColumn[00] = 2;   //증명서
            pXLColumn[01] = 2;   //발급번호
            pXLColumn[02] = 10;  //성명
            pXLColumn[03] = 30;  //주민등록번호
            pXLColumn[04] = 10;  //주소
            pXLColumn[05] = 10;  //직위[직책]
            pXLColumn[06] = 30;  //부서
            pXLColumn[07] = 10;  //담당업무
            pXLColumn[08] = 30;  //입사일자
            pXLColumn[09] = 10;  //재직기간[최초일자]
            pXLColumn[10] = 36;  //근무기간
            pXLColumn[11] = 10;  //용도
            pXLColumn[12] = 10;  //제출처

            pXLColumn[13] = 2;   //내용

            pXLColumn[14] = 3;   //인쇄일자
            pXLColumn[15] = 14;  //회사주소
            pXLColumn[16] = 14;  //회사명
            pXLColumn[17] = 14;  //대표이사
            pXLColumn[18] = 14;  //회사명
            pXLColumn[19] = 2;   //회사명

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

            int vXLine = pXLine; //엑셀에 내용이 표시되는 행 번호

            string vNameColumn = string.Empty;
            int vXLColumnIndex = 0;

            object vObject = null;
            string vConvertString = string.Empty;
            bool IsConvert = false;

            try
            {
                mPrinting.XLActiveSheet("Destination");

                //증명서
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

                ////발급번호
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

                //성명
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

                //주민등록번호
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

                //주소
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

                //직위[직책]
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

                //부서
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
                //담당업무
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

                //입사일자
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

                //재직기간
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

                //근무기간
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

                //용도
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

                //내용
                //FCM_10190 : 위 사람은 상기와 같이 재직하고 있음을 증명합니다.
                //FCM_10191 : 위 사람은 상기와 같이 근무하였음을 증명합니다.
                //01 : 재직증명서
                //02 : 경력증명서
                //03 : 퇴직증명서
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

                //인쇄일자
                vNameColumn = pNameColumn[14];
                vXLColumnIndex = pXLColumn[14];
                vObject = pROW[vNameColumn];
                IsConvert = IsConvertString(vObject, out vConvertString);
                if (IsConvert == true)
                {
                    string vYear = vConvertString.Substring(0, 4);
                    string vMonth = vConvertString.Substring(5, 2);
                    string vDay = vConvertString.Substring(8, 2);
                    vConvertString = string.Format("{0}년 {1}월 {2}일", vYear, vMonth, vDay);
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

                //회사주소
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

                //회사명
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

                //대표이사
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

                //회사명(직인)
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
            object vRangeSource = mPrinting.XLGetRange(mCopyColumnSTART, 1, mIncrementCopyMAX, mCopyColumnEND); //[원본], [Sheet2.Cell("A1:AS67")], 엑셀 쉬트에서 복사 시작할 행번호, 엑셀 쉬트에서 복사 시작할 열번호, 엑셀 쉬트에서 복사 종료할 행번호, 엑셀 쉬트에서 복사 종료할 열번호
            mPrinting.XLActiveSheet("Destination");
            object vRangeDestination = mPrinting.XLGetRange(vCopyPrintingRowSTART, 1, vCopyPrintingRowEnd, mCopyColumnEND); //[대상], [Sheet1.Cell("A1:AS67")], 엑셀 쉬트에서 복사 시작할 행번호, 엑셀 쉬트에서 복사 시작할 열번호, 엑셀 쉬트에서 복사 종료할 행번호, 엑셀 쉬트에서 복사 종료할 열번호
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
