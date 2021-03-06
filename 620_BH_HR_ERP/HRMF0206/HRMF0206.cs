using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using Syncfusion.Windows.Forms;
using Syncfusion.Windows.Forms.Tools;
using Syncfusion.Windows.Forms.Grid;
using InfoSummit.Win.ControlAdv;
using ISCommonUtil;

namespace HRMF0206
{
    public partial class HRMF0206 : Office2007Form
    {
        #region ----- Variables -----

        ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();
        ISFunction.ISConvert iString = new ISFunction.ISConvert();

        private string mMessageError = string.Empty;

        #endregion;

        #region ----- UpLoad / DownLoad Variables -----

        private InfoSummit.Win.ControlAdv.ISFileTransferAdv mFileTransferAdv;
        private ItemImageInfomationFTP mImageFTP;

        private string mFTP_Source_Directory = string.Empty;            // ftp 소스 디렉토리.
        private string mClient_Base_Path = System.Windows.Forms.Application.StartupPath;    // 현재 디렉토리.
        private string mClient_Target_Directory = string.Empty;         // 실제 디렉토리 
        private string mClient_ImageDirectory = string.Empty;           // 클라이언트 이미지 디렉토리.
        private string mFileExtension = string.Empty;                   // 확장자명.

        private bool mIsGetInformationFTP = false;                      // FTP 정보 상태.
        private bool mIsFormLoad = false;                               // NEWMOVE 이벤트 제어.
        private int mStartPage = 1;                                     // 시작 페이지

        #endregion;

        #region ----- initialize -----
        public HRMF0206(Form pMainForm, ISAppInterface pAppInterface)
        {
            this.DoubleBuffered = true;
            this.Visible = false;
            InitializeComponent();

            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;

            mIsFormLoad = false;
        }
        #endregion
                
        #region ----- DATA FIND ------
        
        private void SEARCH_DB()
        {
            if (iedCORP_ID_0.EditValue == null)
            {// 업체 구분
                //MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10033"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                MessageBoxAdv.Show("업체명을 선택해주세요.");
                iedCORP_NAME_0.Focus();
                return;
            }
            else
            {
                // 데이터 조회.
                idaPERSON.SetSelectParamValue("W_SOB_ID", isAppInterfaceAdv1.SOB_ID);
                idaPERSON.SetSelectParamValue("W_ORG_ID", isAppInterfaceAdv1.ORG_ID);
                /*
                idaPERSON.Fill();
                igrPERSON_INFO.Focus();
                */

                idaPERSON.OraSelectData.AcceptChanges();
                idaPERSON.Update();
                idaPERSON.Fill();

                idaPAYMENT_INFO.Fill();
                idaSCHOLARSHIP.Fill();
                idaFAMILY.Fill();
                idaLICENSE.Fill();
                idaCAREER.Fill();
                idaFOREIGN_LANGUAGE.Fill();
                idaREWARD_PUNISHMENT.Fill();
                idaEDUCATION.Fill();
                idaPAYMENT_INFO.Fill();
                idaHISTORY.Fill();
                idaARMY.Fill();
                idaBODY.Fill();
            }            
        }
       
        #endregion       
        
        #region  ------ Property / Method -----
        private void DefaultSetFormReSize()
        {//[Child Form, Mdi Form에 맞게 ReSize]
            int vMinusWidth = 4;
            int vMinusHeight = 54;
            System.Drawing.Size vSize = this.MdiParent.ClientSize;
            this.Width = vSize.Width - vMinusWidth;
            this.Height = vSize.Height - vMinusHeight;
        }

        private void isSetCommonLookUpParameter(string P_GROUP_CODE, string P_CODE_NAME, String P_USABLE_YN)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", P_GROUP_CODE);
            ildCOMMON.SetLookupParamValue("W_CODE_NAME", P_CODE_NAME);
            ildCOMMON.SetLookupParamValue("W_ENABLED_FLAG_YN", P_USABLE_YN);
        }

        #endregion

        // 인쇄 부분
        // Print 관련 소스 코드 2011.6.27(월)
        #region ----- XL Export Methods ----

        private void ExportXL(ISDataAdapter pAdapter)
        {
            int vCountRow = pAdapter.OraSelectData.Rows.Count;
            if (vCountRow < 1)
            {
                return;
            }

            string vsMessage = string.Empty;
            string vsSheetName = "Slip_Line";

            saveFileDialog1.Title = "Excel_Save";
            saveFileDialog1.FileName = "XL_00";
            saveFileDialog1.DefaultExt = "xls";
            System.IO.DirectoryInfo vSaveFolder = new System.IO.DirectoryInfo(System.Environment.GetFolderPath(Environment.SpecialFolder.Desktop));
            saveFileDialog1.InitialDirectory = vSaveFolder.FullName;
            saveFileDialog1.Filter = "Excel Files (*.xls)|*.xls";
            if (saveFileDialog1.ShowDialog() == System.Windows.Forms.DialogResult.OK)
            {
                string vsSaveExcelFileName = saveFileDialog1.FileName;
                XL.XLPrint xlExport = new XL.XLPrint();
                bool vXLSaveOK = xlExport.XLExport(pAdapter.OraSelectData, vsSaveExcelFileName, vsSheetName);
                if (vXLSaveOK == true)
                {
                    vsMessage = string.Format("Save OK [{0}]", vsSaveExcelFileName);
                    MessageBoxAdv.Show(vsMessage);
                }
                else
                {
                    vsMessage = string.Format("Save Err [{0}]", vsSaveExcelFileName);
                    MessageBoxAdv.Show(vsMessage);
                }
                xlExport.XLClose();
            }
        }

        #endregion;

        #region ----- Territory Get Methods ----

        private int GetTerritory(ISUtil.Enum.TerritoryLanguage pTerritoryEnum)
        {
            int vTerritory = 0;

            switch (pTerritoryEnum)
            {
                case ISUtil.Enum.TerritoryLanguage.Default:
                    vTerritory = 1;
                    break;
                case ISUtil.Enum.TerritoryLanguage.TL1_KR:
                    vTerritory = 2;
                    break;
                case ISUtil.Enum.TerritoryLanguage.TL2_CN:
                    vTerritory = 3;
                    break;
                case ISUtil.Enum.TerritoryLanguage.TL3_VN:
                    vTerritory = 4;
                    break;
                case ISUtil.Enum.TerritoryLanguage.TL4_JP:
                    vTerritory = 5;
                    break;
                case ISUtil.Enum.TerritoryLanguage.TL5_XAA:
                    vTerritory = 6;
                    break;
            }

            return vTerritory;
        }

        #endregion;

        #region ----- XLPrinting1 Methods -----

        private void XLPrinting1(string pOutChoice)
        {
            string vMessageText = string.Empty;

            XLPrinting xlPrinting = new XLPrinting();

            try
            {
                //-------------------------------------------------------------------------
                xlPrinting.OpenFileNameExcel = "HRMF0206_001.xls";
                xlPrinting.XLFileOpen();
                //-------------------------------------------------------------------------

                //xlPrinting.PreView();

                // 전체 Grid
                int vTerritory1  = GetTerritory(igrPERSON_INFO.TerritoryLanguage);          // 기본사항1
                int vTerritory2  = GetTerritory(IGR_PAYMENT_INFO.TerritoryLanguage);         // 기본사항2
                int vTerritory3  = GetTerritory(igrREPORT_SCHOLARSHIP.TerritoryLanguage);   // 학력사항
                int vTerritory4  = GetTerritory(igrREPORT_FAMILY.TerritoryLanguage);        // 가족사항
                int vTerritory5  = GetTerritory(igrREPORT_LICENSE.TerritoryLanguage);       // 자격사항
                int vTerritory6  = GetTerritory(igrREPORT_CAREER.TerritoryLanguage);        // 경력사항
                int vTerritory7  = GetTerritory(igrREPORT_F_LANGUAGE.TerritoryLanguage);    // 어학사항
                int vTerritory8  = GetTerritory(igrREPORT_RE_PUNISHMENT.TerritoryLanguage); // 상벌사항
                int vTerritory9  = GetTerritory(igrREPORT_EDU.TerritoryLanguage);           // 교육사항
                int vTerritory10 = GetTerritory(IGR_HISTORY.TerritoryLanguage);       // 발령사항
                int vTerritory11 = GetTerritory(igrARMY.TerritoryLanguage);          // 병역사항
                int vTerritory12 = GetTerritory(igrREPORT_BODY.TerritoryLanguage);          // 신체사항

                // 접속자 정보
                string vUserName = string.Format("{0}", isAppInterfaceAdv1.DISPLAY_NAME);

                // 출력 날짜 및 시간
                System.DateTime vPrintTime = DateTime.Now;
                string vPrintDateTime = string.Format("{0}", vPrintTime.ToString("yyyy-MM-dd"));               

                int vPageNumber = 0;
                int vPageCnt = 0; // 20page씩 나누어 출력할 때, 페이지가 출력된 후 값을 0으로 다시 초기화하여 장 수를 체크하기 위함.

                // 체크한 항목 정보
                int vIndexCheckBox = igrPERSON_INFO.GetColumnToIndex("SELECT_CHECK_YN"); // select의 컬럼 인덱스
                int vTotalRow = igrPERSON_INFO.RowCount; // igrPERSON_INFO의 총 행수

                for (int nRow = 0; nRow < vTotalRow; nRow++)
                {
                    if ((string)igrPERSON_INFO.GetCellValue(nRow, vIndexCheckBox) == "Y") // 선택 항목에 체크되어진 것만 출력하기 위한 조건
                    {
                        // Main이 되는 igrPERSON_INFO Grid의 Line 단위 정보 확인
                        igrPERSON_INFO.CurrentCellMoveTo(nRow, 0);
                        igrPERSON_INFO.Focus();
                        igrPERSON_INFO.CurrentCellActivate(nRow, 0);

                        // 증명사진 Image 경로 및 파일명
                        string sDownLoadFile = isViewItemImage();

                        // 출력과 연관된 Grid 전체를 Writing하기 위한 부분
                        xlPrinting.XLWirte(igrPERSON_INFO, nRow, vTerritory1, vPrintDateTime, vUserName, sDownLoadFile, 1);
                        xlPrinting.XLWirte(IGR_PAYMENT_INFO, nRow, vTerritory2, vPrintDateTime, vUserName, sDownLoadFile, 2);
                        xlPrinting.XLWirte(igrREPORT_SCHOLARSHIP, nRow, vTerritory3, vPrintDateTime, vUserName, sDownLoadFile, 3);
                        xlPrinting.XLWirte(igrREPORT_FAMILY, nRow, vTerritory4, vPrintDateTime, vUserName, sDownLoadFile, 4);
                        xlPrinting.XLWirte(igrREPORT_LICENSE, nRow, vTerritory5, vPrintDateTime, vUserName, sDownLoadFile, 5);
                        xlPrinting.XLWirte(igrREPORT_CAREER, nRow, vTerritory6, vPrintDateTime, vUserName, sDownLoadFile, 6);
                        xlPrinting.XLWirte(igrREPORT_F_LANGUAGE, nRow, vTerritory7, vPrintDateTime, vUserName, sDownLoadFile, 7);
                        xlPrinting.XLWirte(igrREPORT_RE_PUNISHMENT, nRow, vTerritory8, vPrintDateTime, vUserName, sDownLoadFile, 8);
                        xlPrinting.XLWirte(igrREPORT_EDU, nRow, vTerritory9, vPrintDateTime, vUserName, sDownLoadFile, 9);
                        xlPrinting.XLWirte(IGR_HISTORY, nRow, vTerritory10, vPrintDateTime, vUserName, sDownLoadFile, 10);
                        xlPrinting.XLWirte(igrARMY, nRow, vTerritory11, vPrintDateTime, vUserName, sDownLoadFile, 11);
                        xlPrinting.XLWirte(igrREPORT_BODY, nRow, vTerritory12, vPrintDateTime, vUserName, sDownLoadFile, 12);

                        vPageNumber++;
                        vPageCnt++;

                        // 20page 이상일 경우, 20page씩 나눠서 출력하는 부분
                        if (vPageCnt > 19)
                        {
                            if (pOutChoice == "PRINT")
                            {
                                xlPrinting.Printing(mStartPage, vPageNumber);
                            }
                            else if (pOutChoice == "FILE")
                            {
                                xlPrinting.Save("Person_Card_"); //저장 파일명                    
                            }
                            mStartPage = vPageNumber+1;
                            vPageCnt = 0;

                            xlPrinting.XLOpenClose(); // Excel File Close and Open
                        } 
                       
                        //체크해제
                        igrPERSON_INFO.SetCellValue(nRow, vIndexCheckBox, "N");
                        igrPERSON_INFO.LastConfirmChanges();
                        idaPAYMENT_INFO.OraSelectData.AcceptChanges();
                        idaPAYMENT_INFO.Refillable = true;
                    }
                }

                if (pOutChoice == "PRINT")
                {
                    xlPrinting.Printing(mStartPage, vPageNumber); //시작 페이지 번호, 종료 페이지 번호
                    //xlPrinting.PreView();
                }
                else if (pOutChoice == "FILE")
                {
                    xlPrinting.Save("Person_Card_"); //저장 파일명                    
                }

                xlPrinting.Dispose();
                //-------------------------------------------------------------------------

                //vMessageText = string.Format("Print End! [Page : {0}]", vPageNumber);
                //isAppInterfaceAdv1.OnAppMessage(vMessageText);
            }
            catch (System.Exception ex)
            {
                string vMessage = ex.Message;
                xlPrinting.Dispose();
            }


            /*
            try
            {
                //-------------------------------------------------------------------------
                xlPrinting.OpenFileNameExcel = "HRMF0206_001.xls";
                xlPrinting.XLFileOpen();
                //-------------------------------------------------------------------------

                //xlPrinting.PreView();

                // 전체 Grid
                int vTerritory1  = GetTerritory(igrPERSON_INFO.TerritoryLanguage);          // 기본사항1
                int vTerritory2  = GetTerritory(igrPAYTYPE_BANK.TerritoryLanguage);         // 기본사항2
                int vTerritory3  = GetTerritory(igrREPORT_SCHOLARSHIP.TerritoryLanguage);   // 학력사항
                int vTerritory4  = GetTerritory(igrREPORT_FAMILY.TerritoryLanguage);        // 가족사항
                int vTerritory5  = GetTerritory(igrREPORT_LICENSE.TerritoryLanguage);       // 자격사항
                int vTerritory6  = GetTerritory(igrREPORT_CAREER.TerritoryLanguage);        // 경력사항
                int vTerritory7  = GetTerritory(igrREPORT_F_LANGUAGE.TerritoryLanguage);    // 어학사항
                int vTerritory8  = GetTerritory(igrREPORT_RE_PUNISHMENT.TerritoryLanguage); // 상벌사항
                int vTerritory9  = GetTerritory(igrREPORT_EDU.TerritoryLanguage);           // 교육사항
                int vTerritory10 = GetTerritory(igrREPORT_HISTORY.TerritoryLanguage);       // 발령사항
                int vTerritory11 = GetTerritory(igrREPORT_ARMY.TerritoryLanguage);          // 병역사항
                int vTerritory12 = GetTerritory(igrREPORT_BODY.TerritoryLanguage);          // 신체사항

                // 접속자 정보
                string vUserName = string.Format("{0}", isAppInterfaceAdv1.DISPLAY_NAME);

                // 출력 날짜 및 시간
                System.DateTime vPrintTime = DateTime.Now;
                string vPrintDateTime = string.Format("{0}", vPrintTime.ToString("yyyy-MM-dd"));               

                int vPageNumber = 0;
                int vPageCnt = 0; // 20page씩 나누어 출력할 때, 페이지가 출력된 후 값을 0으로 다시 초기화하여 장 수를 체크하기 위함.

                // 체크한 항목 정보
                int vIndexCheckBox = igrPERSON_INFO.GetColumnToIndex("SELECT_CHECK_YN"); // select의 컬럼 인덱스
                int vTotalRow = igrPERSON_INFO.RowCount; // igrPERSON_INFO의 총 행수

                for (int nRow = 0; nRow < vTotalRow; nRow++)
                {
                    if ((string)igrPERSON_INFO.GetCellValue(nRow, vIndexCheckBox) == "Y") // 선택 항목에 체크되어진 것만 출력하기 위한 조건
                    {
                        // Main이 되는 igrPERSON_INFO Grid의 Line 단위 정보 확인
                        igrPERSON_INFO.CurrentCellMoveTo(nRow, 0);
                        igrPERSON_INFO.Focus();
                        igrPERSON_INFO.CurrentCellActivate(nRow, 0);

                        // 증명사진 Image 경로 및 파일명
                        string sDownLoadFile = isViewItemImage();

                        // 출력과 연관된 Grid 전체를 Writing하기 위한 부분
                        xlPrinting.XLWirte(igrPERSON_INFO, nRow, vTerritory1, vPrintDateTime, vUserName, sDownLoadFile, 1);
                        xlPrinting.XLWirte(igrPAYTYPE_BANK, nRow, vTerritory2, vPrintDateTime, vUserName, sDownLoadFile, 2);
                        xlPrinting.XLWirte(igrREPORT_SCHOLARSHIP, nRow, vTerritory3, vPrintDateTime, vUserName, sDownLoadFile, 3);
                        xlPrinting.XLWirte(igrREPORT_FAMILY, nRow, vTerritory4, vPrintDateTime, vUserName, sDownLoadFile, 4);
                        xlPrinting.XLWirte(igrREPORT_LICENSE, nRow, vTerritory5, vPrintDateTime, vUserName, sDownLoadFile, 5);
                        xlPrinting.XLWirte(igrREPORT_CAREER, nRow, vTerritory6, vPrintDateTime, vUserName, sDownLoadFile, 6);
                        xlPrinting.XLWirte(igrREPORT_F_LANGUAGE, nRow, vTerritory7, vPrintDateTime, vUserName, sDownLoadFile, 7);
                        xlPrinting.XLWirte(igrREPORT_RE_PUNISHMENT, nRow, vTerritory8, vPrintDateTime, vUserName, sDownLoadFile, 8);
                        xlPrinting.XLWirte(igrREPORT_EDU, nRow, vTerritory9, vPrintDateTime, vUserName, sDownLoadFile, 9);
                        xlPrinting.XLWirte(igrREPORT_HISTORY, nRow, vTerritory10, vPrintDateTime, vUserName, sDownLoadFile, 10);
                        xlPrinting.XLWirte(igrREPORT_ARMY, nRow, vTerritory11, vPrintDateTime, vUserName, sDownLoadFile, 11);
                        xlPrinting.XLWirte(igrREPORT_BODY, nRow, vTerritory12, vPrintDateTime, vUserName, sDownLoadFile, 12);

                        vPageNumber++;
                        vPageCnt++;

                        // 20page 이상일 경우, 20page씩 나눠서 출력하는 부분
                        if (vPageCnt > 19)
                        {
                            xlPrinting.Printing(mStartPage, vPageNumber);
                            mStartPage = vPageNumber+1;
                            vPageCnt = 0;

                            // Excel File Close
                            
                        }                        
                    }
                }

                xlPrinting.Printing(mStartPage, vPageNumber); //시작 페이지 번호, 종료 페이지 번호

                //xlPrinting.Save("Cashier_"); //저장 파일명

                //xlPrinting.PreView();

                xlPrinting.Dispose();
                //-------------------------------------------------------------------------

                //vMessageText = string.Format("Print End! [Page : {0}]", vPageNumber);
                //isAppInterfaceAdv1.OnAppMessage(vMessageText);
            }
            catch (System.Exception ex)
            {
                string vMessage = ex.Message;
                xlPrinting.Dispose();
            } 
            */
        }

        #endregion;

        #region --- Application_MainButtonClick ---

        private void isAppInterfaceAdv1_AppMainButtonClick(ISAppButtonEvents e)
        {
            if (this.IsActive)
            {
                if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Search)
                {
                    SEARCH_DB();
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddOver)
                {                    
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddUnder)
                {                    
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Update)
                {                 
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Cancel)
                {                   
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {                    
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Print)
                {
                    XLPrinting1("PRINT"); // 출력 함수 호출

                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10035"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    // 인쇄 완료 메시지 출력
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Export)
                {
                    XLPrinting1("FILE");
                }
            }
        }

        #endregion

        #region ----- Form Event -----

        private void HRMF0206_Load(object sender, EventArgs e)
        {
            this.Visible = true;
            mIsFormLoad = true;

            // Lookup SETTING
            ildCORP.SetLookupParamValue("W_PAY_CONTROL_YN", "Y");
            ildCORP.SetLookupParamValue("W_ENABLED_FLAG_YN", "N");

            // LOOKUP DEFAULT VALUE SETTING - CORP
            idcDEFAULT_CORP.SetCommandParamValue("W_PAY_CONTROL_YN", "Y");
            idcDEFAULT_CORP.SetCommandParamValue("W_ENABLED_FLAG_YN", "N");
            idcDEFAULT_CORP.ExecuteNonQuery();

            iedCORP_NAME_0.EditValue = idcDEFAULT_CORP.GetCommandParamValue("O_CORP_NAME");
            iedCORP_ID_0.EditValue = idcDEFAULT_CORP.GetCommandParamValue("O_CORP_ID");

            // 그리드 부분 업데이트 처리 위함.
            idaPERSON.FillSchema();
        }
        
        private void HRMF0206_Shown(object sender, EventArgs e)
        {
            mIsGetInformationFTP = GetInfomationFTP();
            if (mIsGetInformationFTP == true)
            {
                MakeDirectory();
                FTPInitializtion();
            }
            mIsFormLoad = false;
        }

        #endregion

        #region ----- Adapter Event -----

        private bool isDelete_Validate(string pTabPage)
        {
            bool ibReturn_Value = false;
            if (pTabPage == "itpPERSON_MASTER")
            {
                ibReturn_Value = false;
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10029", "&&VALUE:=Person Infomation(사원정보)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);   // 사원정보 삭제 불가.
            }
            return ibReturn_Value;
        }

        // 인사기본 검증---------------------------------------------------------------
        private void idaPERSON_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {
            if (e.Row.RowState != DataRowState.Added)
            {// Added 상태가 아닐경우 체크.
                if (e.Row["PERSON_ID"] == DBNull.Value)
                {
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Person Infomation(사원정보)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    e.Cancel = true;
                    return;
                }
                if (string.IsNullOrEmpty(e.Row["PERSON_NUM"].ToString()))
                {
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Person Infomation(사원정보)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    e.Cancel = true;
                    return;
                }
            }
            if (string.IsNullOrEmpty(e.Row["NAME"].ToString()))
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Person Name(성명)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["CORP_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Corporation(업체)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["OPERATING_UNIT_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Operating Unit(사업장)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["DEPT_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Department(부서)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["NATION_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=국가"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["JOB_CLASS_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Job Class(직군)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["JOB_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Job(직종)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["POST_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Post(직위)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["OCPT_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Ocpt(직무)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["ABIL_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Abil(직책)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["PAY_GRADE_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Pay Grade(직급)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (string.IsNullOrEmpty(e.Row["REPRE_NUM"].ToString()))
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Repre Num(주민번호)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (string.IsNullOrEmpty(e.Row["SEX_TYPE"].ToString()))
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Sex Type(성별)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["JOIN_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=입사구분"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["ORI_JOIN_DATE"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Ori Join Date(그룹입사일)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["JOIN_DATE"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Join Date(입사일)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["RETIRE_DATE"]) != string.Empty && iString.ISNull(e.Row["RETIRE_ID"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10170"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (iString.ISNull(e.Row["RETIRE_DATE"]) == string.Empty && iString.ISNull(e.Row["RETIRE_ID"]) != string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10171"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (string.IsNullOrEmpty(e.Row["DIR_INDIR_TYPE"].ToString()))
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Dir/InDir Type(직간접 구분)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (string.IsNullOrEmpty(e.Row["EMPLOYE_TYPE"].ToString()))
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Employee Status(재직구분)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["JOB_CATEGORY_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Job Category(직구분)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["FLOOR_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Floor(작업장)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
        }

        private void idaPERSON_PreDelete(ISPreDeleteEventArgs e)
        {
            if (e.Row.RowState != DataRowState.Added)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10029", "&&VALUE:=Person Infomation(인사정보)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
        }

// 신체사항 검증---------------------------------------------------------------
        private void idaBODY_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {
            if (e.Row["PERSON_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Person Infomation(사원정보)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
        }

        private void idaBODY_PreDelete(ISPreDeleteEventArgs e)
        {
            if (e.Row.RowState != DataRowState.Added && e.Row["PERSON_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10028"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
        }


// 병역사항 검증---------------------------------------------------------------
        private void idaARMY_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {
            if (e.Row["PERSON_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Person Infomation(사원정보)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["ARMY_KIND_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Army Kind(군별)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["ARMY_STATUS_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Army Status(역종)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["ARMY_GRADE_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Army Grade(계급)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
        }

        private void idaARMY_PreDelete(ISPreDeleteEventArgs e)
        {
            if (e.Row.RowState != DataRowState.Added && e.Row["PERSON_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10028"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
        }

// 가족사항 검증---------------------------------------------------------------
        private void idaFAMILY_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {
            if (e.Row["PERSON_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Person Infomation(사원정보)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (string.IsNullOrEmpty(e.Row["FAMILY_NAME"].ToString()))
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Family Name(성명)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["RELATION_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Family Relation(가족 관계)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
        }

        private void idaFAMILY_PreDelete(ISPreDeleteEventArgs e)
        {
            if (e.Row.RowState != DataRowState.Added && e.Row["PERSON_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10028"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
        }

// 경력사항 검증---------------------------------------------------------------
        private void idaCAREE_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {
            if (e.Row["PERSON_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Person Infomation(사원정보)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (string.IsNullOrEmpty(e.Row["COMPANY_NAME"].ToString()))
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Corporation(회사명)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (String.IsNullOrEmpty(e.Row["DEPT_NAME"].ToString()))
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Department(부서명)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["START_DATE"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Join Date(입사일자)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["END_DATE"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Retire Date(퇴사일자)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
        }

        private void idaCAREE_PreDelete(ISPreDeleteEventArgs e)
        {
            if (e.Row.RowState != DataRowState.Added && e.Row["PERSON_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10028"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
        }

// 학력사항 검증---------------------------------------------------------------
        private void idaSCHOLARSHIP_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {
            if (e.Row["PERSON_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Person Infomation(사원정보)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["SCHOLARSHIP_TYPE_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Scholarship Type(학력타입)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["GRADUATION_TYPE_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Graduation Type(졸업구분)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["ADMISSION_YYYYMM"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Admission Date(입학일자)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }            
            if (string.IsNullOrEmpty(e.Row["SCHOOL_NAME"].ToString()))
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=School Name(학교명)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
        }

        private void idaSCHOLARSHIP_PreDelete(ISPreDeleteEventArgs e)
        {
            if (e.Row.RowState != DataRowState.Added && e.Row["PERSON_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10028"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
        }

// 교육사항 검증---------------------------------------------------------------
        private void idaEDUCATION_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {
            if (e.Row["PERSON_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Person Infomation(사원정보)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["START_DATE"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Education Start Date(교육 시작일자)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (string.IsNullOrEmpty(e.Row["EDU_CURRICULUM"].ToString()))
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Education Curriculum(교육명)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
        }

        private void idaEDUCATION_PreDelete(ISPreDeleteEventArgs e)
        {
            if (e.Row.RowState != DataRowState.Added && e.Row["PERSON_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10028"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
        }

// 평가사항 검증---------------------------------------------------------------
        private void idaRESULT_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {
            if (e.Row["PERSON_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Person Infomation(사원정보)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (string.IsNullOrEmpty(e.Row["RESULT_YYYY"].ToString()))
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Result Year Month(평가 년월)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
        }

        private void idaRESULT_PreDelete(ISPreDeleteEventArgs e)
        {
            if (e.Row.RowState != DataRowState.Added && e.Row["PERSON_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10028"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
        }
        
// 자격사항 검증---------------------------------------------------------------
        private void idaLICENSE_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {
            if (e.Row["PERSON_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Person Infomation(사원정보)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["LICENSE_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=License Kind(자격증 종류)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["LICENSE_DATE"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=License Get Date(취득일)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
        }

        private void idaLICENSE_PreDelete(ISPreDeleteEventArgs e)
        {
            if (e.Row.RowState != DataRowState.Added && e.Row["PERSON_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10028"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
        }

// 어학사항 검증---------------------------------------------------------------
        private void idaFOREIGN_LANGUAGE_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {
            if (e.Row["PERSON_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Person Infomation(사원정보)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["EXAM_DATE"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Exam Date(응시 일자)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["EXAM_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Exam Kind(검정 종류)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
        }

        private void idaFOREIGN_LANGUAGE_PreDelete(ISPreDeleteEventArgs e)
        {
            if (e.Row.RowState != DataRowState.Added && e.Row["PERSON_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10028"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
        }

// 상벌사항 검증---------------------------------------------------------------
        private void idaREWARD_PUNISHMENT_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {
            if (e.Row["PERSON_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Person Infomation(사원정보)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (string.IsNullOrEmpty(e.Row["RP_TYPE"].ToString()))
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Reward/Punishment Type(상벌구분)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["RP_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Reward/Punishment Kind(상벌 항목)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["RP_DATE"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Reward/Punishment Date(상벌 일자)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["RP_ORG"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Reward/Punishment Organization(시행처"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
        }

        private void idaREWARD_PUNISHMENT_PreDelete(ISPreDeleteEventArgs e)
        {
            if (e.Row.RowState != DataRowState.Added && e.Row["PERSON_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10028"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
        }

        // 신원보증 검증---------------------------------------------------------------
        private void idaREFERENCE_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {// 신원보증
            if (e.Row["PERSON_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Person Infomation(사원정보)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["REFERENCE_TYPE"].ToString() == "I".ToString())
            {
                if (string.IsNullOrEmpty(e.Row["INSUR_NAME"].ToString()))
                {
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Insurance Name(보험명)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    e.Cancel = true;
                    return;
                }
                if (e.Row["INSUR_START_DATE"] == DBNull.Value)
                {
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Insurance Start Date(보험시작일)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    e.Cancel = true;
                    return;
                }
            }
            else if (e.Row["REFERENCE_TYPE"].ToString() == "P".ToString())
            {
                if (string.IsNullOrEmpty(e.Row["GUAR_NAME1"].ToString()))
                {
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Reference Name(보증인)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    e.Cancel = true;
                    return;
                }
                if (string.IsNullOrEmpty(e.Row["GUAR_REPRE_NUM1"].ToString()))
                {
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Repre Num(주민번호)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    e.Cancel = true;
                    return;
                }
                if (e.Row["GUAR_RELATION_ID1"] == DBNull.Value)
                {
                    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Reference Relation(보증인 관계)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    e.Cancel = true;
                    return;
                }
            }
            else
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Reference Kind(보증유형)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            
        }

        private void idaREFERENCE_PreDelete(ISPreDeleteEventArgs e)
        {
            if (e.Row.RowState != DataRowState.Added && e.Row["PERSON_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10028"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
        }

        #endregion

        #region ----- idaPERSON NewRowMoved Event -----        
        private void idaPERSON_NewRowMoved(object pSender, ISBindingEventArgs pBindingManager)
        {
            if (mIsFormLoad == true)
            {
                return;
            }

            isViewItemImage();
        }
        #endregion

        #region ----- lookup adapter event -----

        private void ilaCORP_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCORP.SetLookupParamValue("W_ENABLED_FLAG_YN", "N");
        }

        private void ilaCORP_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCORP.SetLookupParamValue("W_ENABLED_FLAG_YN", "Y");
        }

        private void ilaDEPT_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            if (iedCORP_ID_0.EditValue == null)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_10011"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            ildDEPT.SetLookupParamValue("W_CORP_ID", iedCORP_ID_0.EditValue);
            ildDEPT.SetLookupParamValue("W_DEPT_LEVEL", DBNull.Value);
            ildDEPT.SetLookupParamValue("W_USABLE_CHECK_YN", "N");
        }

        private void ilaEMPLOYE_TYPE_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            isSetCommonLookUpParameter("EMPLOYE_TYPE", null, "N");
        }

        private void ilaEMPLOYE_TYPE_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            isSetCommonLookUpParameter("EMPLOYE_TYPE", null, "Y");
        }        

        #endregion

        #region ----- is View Item Image Method -----
        /*
        private void isViewItemImage()
        {
            if (mIsFormLoad == true)
            {
                return;
            }

            bool isView = false;
            string vDownLoadFile = string.Empty;

            string vPersonNumber = igrPERSON_INFO.GetCellValue("PERSON_NUM") as string;
            string vTargetFileName = string.Format("{0}{1}", vPersonNumber.ToUpper(), mFileExtension);

            bool isDown = DownLoadItem(vTargetFileName);
            if (isDown == true)
            {
                vDownLoadFile = string.Format("{0}\\{1}", mClient_ImageDirectory, vTargetFileName);
                isView = ImageView(vDownLoadFile);
            }
            else
            {
                ipbPERSON.ImageLocation = string.Empty;
            }
        }
        */
        
     
        private string isViewItemImage()
        {
            if (mIsFormLoad == true)
            {
                return null;
            }

            bool isView = false;
            string vDownLoadFile = string.Empty;

            string vPersonNumber = igrPERSON_INFO.GetCellValue("PERSON_NUM") as string;
            string vTargetFileName = string.Format("{0}{1}", vPersonNumber.ToUpper(), mFileExtension);

            bool isDown = DownLoadItem(vTargetFileName);
            if (isDown == true)
            {
                vDownLoadFile = string.Format("{0}\\{1}", mClient_ImageDirectory, vTargetFileName);
                isView = ImageView(vDownLoadFile);
            }
            else
            {
                ipbPERSON.ImageLocation = string.Empty;
            }
            return vDownLoadFile;
        }

        #endregion;

        #region ----- Make Directory ----

        private void MakeDirectory()
        {
            System.IO.DirectoryInfo vClient_ImageDirectory = new System.IO.DirectoryInfo(mClient_ImageDirectory);
            if (vClient_ImageDirectory.Exists == false) //있으면 True, 없으면 False
            {
                vClient_ImageDirectory.Create();
            }
        }

        #endregion;

        #region ----- Image View ----

        private bool ImageView(string pFileName)
        {
            bool isView = false;

            bool isExist = System.IO.File.Exists(pFileName);
            if (isExist == true)
            {
                ipbPERSON.ImageLocation = pFileName;
                isView = true;
            }

            return isView;
        }

        #endregion;

        #region ----- Get Information FTP Methods -----

        private bool GetInfomationFTP()
        {
            bool isGet = false;
            try
            {
                idcFTP_INFO.SetCommandParamValue("W_FTP_INFO_CODE", "101");
                idcFTP_INFO.ExecuteNonQuery();
                mImageFTP = new ItemImageInfomationFTP();

                mImageFTP.Host = iString.ISNull(idcFTP_INFO.GetCommandParamValue("O_FTP_IP"));
                mImageFTP.Port = iString.ISNull(idcFTP_INFO.GetCommandParamValue("O_FTP_PORT"));
                mImageFTP.UserID = iString.ISNull(idcFTP_INFO.GetCommandParamValue("O_FTP_USER_ID"));
                mImageFTP.Password = iString.ISNull(idcFTP_INFO.GetCommandParamValue("O_FTP_PASSWORD"));

                mFTP_Source_Directory = iString.ISNull(idcFTP_INFO.GetCommandParamValue("O_FTP_SOURCEPATH"));
                mClient_Target_Directory = iString.ISNull(idcFTP_INFO.GetCommandParamValue("O_CLIENT_TARGETPATH"));
                mFileExtension = iString.ISNull(idcFTP_INFO.GetCommandParamValue("O_FILE_EXTENSION"));
                mClient_ImageDirectory = string.Format("{0}\\{1}", mClient_Base_Path, mClient_Target_Directory);

                Application.DoEvents();

                if (mImageFTP.Host != string.Empty)
                {
                    isGet = true;
                }
            }
            catch (System.Exception ex)
            {
                isAppInterfaceAdv1.OnAppMessage(ex.Message);
                System.Windows.Forms.Application.DoEvents();
            }

            return isGet;
        }

        #endregion;

        #region ----- FTP Initialize -----

        private void FTPInitializtion()
        {
            mFileTransferAdv = new ISFileTransferAdv();
            mFileTransferAdv.Host = mImageFTP.Host;
            mFileTransferAdv.Port = mImageFTP.Port;
            mFileTransferAdv.UserId = mImageFTP.UserID;
            mFileTransferAdv.Password = mImageFTP.Password;
        }

        #endregion;

        #region ----- Image Upload Methods -----

        private bool UpLoadItem()
        {
            bool isUp = false;

            openFileDialog1.FileName = string.Format("*{0}", mFileExtension);
            openFileDialog1.Filter = string.Format("Image Files (*{0})|*{1}", mFileExtension, mFileExtension);
            if (openFileDialog1.ShowDialog() == DialogResult.OK)
            {
                try
                {
                    string vChoiceFileFullPath = openFileDialog1.FileName;
                    string vChoiceFilePath = vChoiceFileFullPath.Substring(0, vChoiceFileFullPath.LastIndexOf(@"\"));
                    string vChoiceFileName = vChoiceFileFullPath.Substring(vChoiceFileFullPath.LastIndexOf(@"\") + 1);

                    mFileTransferAdv.ShowProgress = true;
                    //--------------------------------------------------------------------------------

                    string vSourceFileName = vChoiceFileName;

                    string vTargetFileName = igrPERSON_INFO.GetCellValue("PERSON_NUM") as string;
                    vTargetFileName = string.Format("{0}{1}", vTargetFileName.ToUpper(), mFileExtension);

                    mFileTransferAdv.SourceDirectory = vChoiceFilePath;
                    mFileTransferAdv.SourceFileName = vSourceFileName;
                    mFileTransferAdv.TargetDirectory = mFTP_Source_Directory;
                    mFileTransferAdv.TargetFileName = vTargetFileName;

                    bool isUpLoad = mFileTransferAdv.Upload();

                    if (isUpLoad == true)
                    {
                        isUp = true;
                        bool isView = ImageView(vChoiceFileFullPath);
                    }
                    else
                    {
                    }
                }
                catch
                {
                }
            }
            System.IO.Directory.SetCurrentDirectory(mClient_Base_Path);
            return isUp;
        }


        private void ibtPERSON_PICTURE_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            if (mIsGetInformationFTP == true)
            {
                UpLoadItem();
            }
        }


        #endregion;

        #region ----- Image Download Methods -----

        private bool DownLoadItem(string pFileName)
        {
            bool isDown = false;

            if (mIsGetInformationFTP == false)
            {
                return isDown;
            }

            string vSourceDownLoadFile = string.Format("{0}\\{1}", mClient_ImageDirectory, pFileName);
            string vTargetDownLoadFile = string.Format("{0}\\_{1}", mClient_ImageDirectory, pFileName);

            string vBeforeSourceFileName = string.Format("{0}", pFileName);
            string vBeforeTargetFileName = string.Format("_{0}", pFileName);

            mFileTransferAdv.ShowProgress = false;
            //--------------------------------------------------------------------------------

            mFileTransferAdv.SourceDirectory = mFTP_Source_Directory;
            mFileTransferAdv.SourceFileName = vBeforeSourceFileName;
            mFileTransferAdv.TargetDirectory = mClient_ImageDirectory;
            mFileTransferAdv.TargetFileName = vBeforeTargetFileName;

            isDown = mFileTransferAdv.Download();

            if (isDown == true)
            {
                try
                {
                    System.IO.File.Delete(vSourceDownLoadFile);
                    System.IO.File.Move(vTargetDownLoadFile, vSourceDownLoadFile);

                    isDown = true;
                }
                catch
                {
                    try
                    {
                        System.IO.FileInfo vDownFileInfo = new System.IO.FileInfo(vTargetDownLoadFile);
                        if (vDownFileInfo.Exists == true)
                        {
                            try
                            {
                                System.IO.File.Delete(vTargetDownLoadFile);
                            }
                            catch
                            {
                                // ignore
                            }
                        }
                    }
                    catch
                    {
                        //ignore
                    }
                }
            }
            else
            {
                try
                {
                    System.IO.FileInfo vDownFileInfo = new System.IO.FileInfo(vTargetDownLoadFile);
                    if (vDownFileInfo.Exists == true)
                    {
                        try
                        {
                            System.IO.File.Delete(vTargetDownLoadFile);
                        }
                        catch
                        {
                            // ignore
                        }
                    }
                }
                catch
                {
                    //ignore
                }
            }

            return isDown;
        }

        #endregion;

        #region ----- Form Event -----
        
        private void iedNAME_0_KeyUp(object pSender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
            {
                SEARCH_DB();
            }
        }

        // 전체선택 버튼
        private void btnSELECT_ALL_0_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            for (int i = 0; i < igrPERSON_INFO.RowCount; i++)
            {
                igrPERSON_INFO.SetCellValue(i, igrPERSON_INFO.GetColumnToIndex("SELECT_CHECK_YN"), "Y");
            }
        }

        // 취소 버튼
        private void btnCONFIRM_CANCEL_0_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            for (int i = 0; i < igrPERSON_INFO.RowCount; i++)
            {
                igrPERSON_INFO.SetCellValue(i, igrPERSON_INFO.GetColumnToIndex("SELECT_CHECK_YN"), "N");
            }
        }

        private void HRMF0206_FormClosing(object sender, FormClosingEventArgs e)
        {
            if (mIsGetInformationFTP == true)
            {
                System.IO.DirectoryInfo vClient_ImageDirectory = new System.IO.DirectoryInfo(mClient_ImageDirectory);
                if (vClient_ImageDirectory.Exists == true)
                {
                    try
                    {
                        vClient_ImageDirectory.Delete(true);
                    }
                    catch
                    {
                    }
                }
            }
        }   

        #endregion
     
    }

    #region ----- User Make Class -----

    public class ItemImageInfomationFTP
    {
        #region ----- Variables -----

        private string mHost = string.Empty;
        private string mPort = string.Empty;
        private string mUserID = string.Empty;
        private string mPassword = string.Empty;

        #endregion;

        #region ----- Constructor -----

        public ItemImageInfomationFTP()
        {
        }

        public ItemImageInfomationFTP(string pHost, string pPort, string pUserID, string pPassword)
        {
            mHost = pHost;
            mPort = pPort;
            mUserID = pUserID;
            mPassword = pPassword;
        }

        #endregion;

        #region ----- Property -----

        public string Host
        {
            get
            {
                return mHost;
            }
            set
            {
                mHost = value;
            }
        }

        public string Port
        {
            get
            {
                return mPort;
            }
            set
            {
                mPort = value;
            }
        }

        public string UserID
        {
            get
            {
                return mUserID;
            }
            set
            {
                mUserID = value;
            }
        }

        public string Password
        {
            get
            {
                return mPassword;
            }
            set
            {
                mPassword = value;
            }
        }

        #endregion;
    }

    #endregion;
}