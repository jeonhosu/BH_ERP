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

namespace HRMF0306
{
    public partial class HRMF0306 : Office2007Form
    {
        ISFunction.ISDateTime iDate = new ISFunction.ISDateTime();
        ISFunction.ISConvert iString = new ISFunction.ISConvert();


        #region ----- Variables -----



        #endregion;

        #region ----- Constructor -----

        public HRMF0306(Form pMainForm, ISAppInterface pAppInterface)
        {
            InitializeComponent();
            this.MdiParent = pMainForm;
            isAppInterfaceAdv1.AppInterface = pAppInterface;
        }

        #endregion;

        #region ----- Private Methods -----
        private void DefaultSetFormReSize()
        {//[Child Form, Mdi Form에 맞게 ReSize]
            int vMinusWidth = 4;
            int vMinusHeight = 54;
            System.Drawing.Size vSize = this.MdiParent.ClientSize;
            this.Width = vSize.Width - vMinusWidth;
            this.Height = vSize.Height - vMinusHeight;
        }

        private void DefaultCorporation()
        {
            // Lookup SETTING
            ildCORP.SetLookupParamValue("W_DUTY_CONTROL_YN", "Y");
            ildCORP.SetLookupParamValue("W_ENABLED_FLAG_YN", "N");

            // LOOKUP DEFAULT VALUE SETTING - CORP
            idcDEFAULT_CORP.SetCommandParamValue("W_DUTY_CONTROL_YN", "Y");
            idcDEFAULT_CORP.SetCommandParamValue("W_ENABLED_FLAG_YN", "N");
            idcDEFAULT_CORP.ExecuteNonQuery();
            CORP_NAME_0.EditValue = idcDEFAULT_CORP.GetCommandParamValue("O_CORP_NAME");
            CORP_ID_0.EditValue = idcDEFAULT_CORP.GetCommandParamValue("O_CORP_ID");
        }

        private void SEARCH_DB()
        {
            if (CORP_ID_0.EditValue == null)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10001"), "Warning", MessageBoxButtons.OK,MessageBoxIcon.Warning);
                CORP_NAME_0.Focus();
                return;
            }
            if (STD_DATE_0.EditValue == null)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10036"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                STD_DATE_0.Focus();
                return;
            }

            idaOT_HEADER.Fill();
            REQ_TYPE_NAME.Focus();
        }

        private bool isOT_Header_Check()
        {
            if (DUTY_MANAGER_ID_0.EditValue == null)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Floor Name(작업장)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return false;
            }
            return  true;
        }

        private void isOT_Header()
        {
            CORP_ID.EditValue = CORP_ID_0.EditValue;
            REQ_DATE.EditValue = iDate.ISGetDate();
            REQ_PERSON_ID.EditValue = isAppInterfaceAdv1.PERSON_ID;
            DUTY_MANAGER_ID.EditValue = DUTY_MANAGER_ID_0.EditValue;
            DUTY_MANAGER_NAME.EditValue = DUTY_MANAGER_NAME_0.EditValue;
            OT_HEADER_ID.EditValue = -1;

            idcDV_REQ_TYPE.SetCommandParamValue("W_GROUP_CODE", "REQ_TYPE");
            idcDV_REQ_TYPE.ExecuteNonQuery();
            REQ_TYPE.EditValue = idcDV_REQ_TYPE.GetCommandParamValue("O_CODE");
            REQ_TYPE_NAME.EditValue = idcDV_REQ_TYPE.GetCommandParamValue("O_CODE_NAME");

            REQ_TYPE_NAME.Focus();
        }

        private bool isOT_Line_Check()
        {
            if (OT_HEADER_ID.EditValue == null)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10239"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return false;
            }
            if (iString.ISNull(APPROVE_STATUS.EditValue, "A") != "A".ToString() && iString.ISNull(APPROVE_STATUS.EditValue, "A") != "N".ToString())
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10042", "&&VALUE:=Addition Request(추가신청)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return false;
            }
            return true;
        }

        private bool Check_Work_Date_time(object pHoly_Type, object IO_Flag, object pWork_Date, object pNew_Work_Date)
        {
            bool mCheck_Value = false;

            if (iString.ISNull(pHoly_Type) == string.Empty)
            {
                return (mCheck_Value);
            }
            if (iString.ISNull(IO_Flag) == string.Empty)
            {
                return (mCheck_Value);
            }
            if (iString.ISNull(pWork_Date) == string.Empty)
            {
                return (mCheck_Value);
            }
            if (iString.ISNull(pNew_Work_Date) == string.Empty)
            {
                return true;
            }

            if ((pHoly_Type.ToString() == "0".ToString() || pHoly_Type.ToString() == "1".ToString() || pHoly_Type.ToString() == "2".ToString()
                || pHoly_Type.ToString() == "D".ToString() || pHoly_Type.ToString() == "S".ToString())
                && IO_Flag.ToString() == "IN".ToString())
            {// 주간, 무휴, 유휴, DAY, SWING --> 같은 날짜.
                if (Convert.ToDateTime(pWork_Date).Date == Convert.ToDateTime(pNew_Work_Date).Date)
                {
                    mCheck_Value = true;
                }
            }
            else if ((pHoly_Type.ToString() == "3".ToString() || pHoly_Type.ToString() == "N".ToString())
                && IO_Flag.ToString() == "IN".ToString())
            {// 주간, 야간, 무휴, 유휴, DAY, NIGHT --> 같은 날짜.
                if (Convert.ToDateTime(pWork_Date).Date <= Convert.ToDateTime(pNew_Work_Date).Date
                    && Convert.ToDateTime(pNew_Work_Date).Date <= Convert.ToDateTime(pWork_Date).AddDays(1).Date)
                {
                    mCheck_Value = true;
                }
            }
            else if ((pHoly_Type.ToString() == "0".ToString() || pHoly_Type.ToString() == "1".ToString() || pHoly_Type.ToString() == "2".ToString()
         || pHoly_Type.ToString() == "D".ToString() || pHoly_Type.ToString() == "S".ToString())
              && IO_Flag.ToString() == "OUT".ToString())
            {// 주간, 무휴, 유휴, DAY, SWING --> 같은 날짜.
                if (Convert.ToDateTime(pWork_Date).Date <= Convert.ToDateTime(pNew_Work_Date).Date
                    && Convert.ToDateTime(pNew_Work_Date).Date <= Convert.ToDateTime(pWork_Date).AddDays(1).Date)
                {
                    mCheck_Value = true;
                }
            }
            else if ((pHoly_Type.ToString() == "3".ToString() || pHoly_Type.ToString() == "N".ToString())
           && IO_Flag.ToString() == "OUT".ToString())
            {// 주간, 야간, 무휴, 유휴, DAY, NIGHT --> 같은 날짜.
                if (Convert.ToDateTime(pWork_Date).Date <= Convert.ToDateTime(pNew_Work_Date).Date
                    && Convert.ToDateTime(pNew_Work_Date).Date <= Convert.ToDateTime(pWork_Date).AddDays(1).Date)
                {
                    mCheck_Value = true;
                }
            }
            return (mCheck_Value);
        }
        #endregion;

        //-- Report 관련 코드
        #region ----- XL Export Methods ----

        private void ExportXL(ISGridAdvEx pGrid)
        {
            string vMessage = string.Empty;
            int vCountRows = pGrid.RowCount;

            if (vCountRows > 0)
            {
                saveFileDialog1.Title = "Excel_Save";
                saveFileDialog1.FileName = "Ex_00";
                saveFileDialog1.DefaultExt = "xls";
                System.IO.DirectoryInfo vSaveFolder = new System.IO.DirectoryInfo(System.Environment.GetFolderPath(Environment.SpecialFolder.Desktop));
                saveFileDialog1.InitialDirectory = vSaveFolder.FullName;
                saveFileDialog1.Filter = "Excel Files (*.xls)|*.xls";
                if (saveFileDialog1.ShowDialog() == System.Windows.Forms.DialogResult.OK)
                {
                    System.Windows.Forms.Application.DoEvents();

                    string vsSaveExcelFileName = saveFileDialog1.FileName;

                    XLExport mExport = new XLExport();
                    int vTerritory = GetTerritory(pGrid.TerritoryLanguage);
                    string vOpenExcelFileName = "HRMF0306_002.xls";

                    bool vbXLSaveOK = mExport.ExcelExport(pGrid, vTerritory, vOpenExcelFileName, vsSaveExcelFileName, this.Text, this);
                    if (vbXLSaveOK == true)
                    {
                        vMessage = string.Format("Save OK [{0}]", vsSaveExcelFileName);
                        isAppInterfaceAdv1.OnAppMessage(vMessage);
                        System.Windows.Forms.Application.DoEvents();
                    }
                    else
                    {
                        vMessage = string.Format("Save Err [{0}]", vsSaveExcelFileName);
                        isAppInterfaceAdv1.OnAppMessage(vMessage);
                        System.Windows.Forms.Application.DoEvents();
                    }
                }
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

        #region ----- XL Print 1 Methods -----

        private void XLPrinting1()
        {
            string vMessageText = string.Empty;

            XLPrinting xlPrinting = new XLPrinting();

            try
            {
                //-------------------------------------------------------------------------
                xlPrinting.OpenFileNameExcel = "HRMF0306_001.xls";
                xlPrinting.XLFileOpen();

                int vTerritory = GetTerritory(igrOT_LINE.TerritoryLanguage);
                string vPeriodFrom = STD_DATE_0.DateTimeValue.ToString("yyyy-MM-dd", null);
                //string vPeriodTo = iEND_DATE_0.DateTimeValue.ToString("yyyy-MM-dd", null);

                string vUserName = string.Format("[{0}]{1}", isAppInterfaceAdv1.DEPT_NAME, isAppInterfaceAdv1.DISPLAY_NAME);

                int viCutStart = this.Text.LastIndexOf("]") + 1;
                string vCaption = this.Text.Substring(0, viCutStart);
                
                // Report 상단에 출력될 항목의 값을 넘겨주는 부분
                xlPrinting.Req_Type = REQ_TYPE_NAME.EditValue;
                xlPrinting.Req_Num = "신청번호 : " + REQ_NUM.EditValue;
                xlPrinting.Duty_Manager_Nam = "작 업 장 : " + DUTY_MANAGER_NAME.EditValue;
                xlPrinting.Req_Person_Name = "신 청 자 : " + REQ_PERSON_NAME.EditValue;

                int vPageNumber = xlPrinting.XLWirte(igrOT_LINE, vTerritory, vPeriodFrom, /*vPeriodTo,*/ vUserName, vCaption);

                xlPrinting.Printing(1, vPageNumber); //시작 페이지 번호, 종료 페이지 번호
                //xlPrinting.Printing(3, 4);


                //xlPrinting.Save("Cashier_"); //저장 파일명

                //xlPrinting.PreView();

                xlPrinting.Dispose();
                //-------------------------------------------------------------------------

                vMessageText = string.Format("Print End! [Page : {0}]", vPageNumber);
                isAppInterfaceAdv1.OnAppMessage(vMessageText);
            }
            catch (System.Exception ex)
            {
                string vMessage = ex.Message;
                xlPrinting.Dispose();
            }
        }

        #endregion;

        #region ----- isAppInterfaceAdv1_AppMainButtonClick Events -----
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
                    if (idaOT_LINE.IsFocused)
                    {
                        if (isOT_Line_Check() != false)
                        {
                            idaOT_LINE.AddOver();
                            igrOT_LINE.SetCellValue("WORK_DATE", STD_DATE_0.EditValue);
                        }
                    }
                    else
                    {
                        if (isOT_Header_Check() != false)
                        {
                            idaOT_HEADER.AddOver();
                            isOT_Header();
                        }                        
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddUnder)
                {
                    if (idaOT_LINE.IsFocused)
                    {
                        if (isOT_Line_Check() != false)
                        {
                            idaOT_LINE.AddUnder();
                            igrOT_LINE.SetCellValue("WORK_DATE", STD_DATE_0.EditValue);
                        }
                    }
                    else
                    {
                        if (isOT_Header_Check() != false)
                        {
                            idaOT_HEADER.AddUnder();
                            isOT_Header();
                        }
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Update)
                {
                    try
                    {
                        idaOT_HEADER.Update();
                    }
                    catch
                    {
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Cancel)
                {
                    if (idaOT_HEADER.IsFocused)
                    {
                        idaOT_LINE.Cancel();
                        idaOT_HEADER.Cancel();
                    }
                    else if (idaOT_LINE.IsFocused)
                    {
                        idaOT_LINE.Cancel();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {
                    if (idaOT_HEADER.IsFocused)
                    {
                        for (int r = 0; r < idaOT_LINE.SelectRows.Count; r++)
                        {
                            idaOT_LINE.Delete();
                        }
                        idaOT_HEADER.Delete();                        
                    }
                    else if (idaOT_LINE.IsFocused)
                    {
                        idaOT_LINE.Delete();
                    }                    
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Print) //인쇄버튼
                {
                    XLPrinting1();
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Export) //엑셀파일 버튼
                {
                    /*if (idaDUTY_PERIOD.IsFocused == true) // 어뎁터가 하나 이상일 경우 else if문으로 사용
                    {
                        ExportXL(idaDUTY_PERIOD);
                    }*/

                    ExportXL(igrOT_LINE);
                }
            }
        }
        #endregion;

        #region ----- Form Event -----

        private void HRMF0306_Load(object sender, EventArgs e)
        {
            STD_DATE_0.EditValue = DateTime.Today;

            idaOT_HEADER.FillSchema();
            
            // Lookup SETTING
            ildREQ_TYPE.SetLookupParamValue("W_GROUP_CODE", "REQ_TYPE");
            ildREQ_TYPE.SetLookupParamValue("W_USABLE_CHECK_YN", "N");

            DefaultCorporation();
            //DefaultSetFormReSize();		//[Child Form, Mdi Form에 맞게 ReSize]
        }

        private void ibtSELECT_PERSON_ButtonClick(object pSender, EventArgs pEventArgs)
        {//대상산출
            int mRECORD_COUNT = 0;

            if (isOT_Line_Check() == false)
            {
                return;
            }

            idcOT_LINE_COUNT.ExecuteNonQuery();
            mRECORD_COUNT = Convert.ToInt32(idcOT_LINE_COUNT.GetCommandParamValue("O_RECORD_COUNT"));
            if (mRECORD_COUNT != Convert.ToInt32(0))
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10044", "&&VALUE:=Request Number's Data(신청번호에 대한 라인자료)&&TEXT:=Search(조회)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }

            idaOT_LINE.Cancel();

            idaINSERT_PERSON.Fill();

            igrOT_LINE.BeginUpdate();
            for (int i = 0; i < idaINSERT_PERSON.OraDataSet().Rows.Count; i++)
            {
                idaOT_LINE.AddUnder();
                for (int j = 0; j < igrOT_LINE.GridAdvExColElement.Count - 1; j++)
                {
                    igrOT_LINE.SetCellValue(i, j + 1, idaINSERT_PERSON.OraDataSet().Rows[i][j]);
                }
            }
            igrOT_LINE.EndUpdate();
            igrOT_LINE.CurrentCellMoveTo(0, 0);
            igrOT_LINE.CurrentCellActivate(0, 0);
            igrOT_LINE.Focus();
        }

        private void btnAPPR_REQUEST_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            if (isOT_Line_Check() == false)
            {
                return;
            }
            idaOT_HEADER.Update();

            idcAPPROVAL_REQUEST.ExecuteNonQuery();

            // EMAIL 발송.
            idcEMAIL_SEND.SetCommandParamValue("P_GUBUN", "A");
            idcEMAIL_SEND.SetCommandParamValue("P_SOURCE_TYPE", "OT");
            idcEMAIL_SEND.SetCommandParamValue("P_CORP_ID", CORP_ID.EditValue);
            idcEMAIL_SEND.SetCommandParamValue("P_WORK_DATE", REQ_DATE.EditValue);
            idcEMAIL_SEND.SetCommandParamValue("P_REQ_DATE", REQ_DATE.EditValue);
            idcEMAIL_SEND.ExecuteNonQuery();

            // 다시 조회.
            idaOT_HEADER.SetSelectParamValue("W_OT_HEADER_ID", OT_HEADER_ID.EditValue); 
            idaOT_HEADER.Fill();
        }

        private void igrOT_LINE_CurrentCellValidating(object pSender, ISGridAdvExValidatingEventArgs e)
        {   
            if (e.ColIndex == igrOT_LINE.GetColumnToIndex("WORK_DATE"))
            {
                if (e.NewValue != null)
                {// Null 이 아닐 경우만 처리
                    idcOT_STD_TIME.SetCommandParamValue("W_WORK_DATE", e.NewValue);
                    idcOT_STD_TIME.SetCommandParamValue("W_DANGJIK_YN", igrOT_LINE.GetCellValue(e.RowIndex, igrOT_LINE.GetColumnToIndex("DANGJIK_YN")));
                    idcOT_STD_TIME.SetCommandParamValue("W_ALL_NIGHT_YN", igrOT_LINE.GetCellValue(e.RowIndex, igrOT_LINE.GetColumnToIndex("ALL_NIGHT_YN")));
                    idcOT_STD_TIME.ExecuteNonQuery();
                    igrOT_LINE.SetCellValue("AFTER_OT_START", idcOT_STD_TIME.GetCommandParamValue("O_AFTER_OT_START"));
                    igrOT_LINE.SetCellValue("AFTER_OT_END", idcOT_STD_TIME.GetCommandParamValue("O_AFTER_OT_END"));
                    igrOT_LINE.SetCellValue("BEFORE_OT_START", idcOT_STD_TIME.GetCommandParamValue("O_BEFORE_OT_START"));
                    igrOT_LINE.SetCellValue("BEFORE_OT_END", idcOT_STD_TIME.GetCommandParamValue("O_BEFORE_OT_END"));
                }
            }
            else if (e.ColIndex == igrOT_LINE.GetColumnToIndex("DANGJIK_YN"))
            {
                idcOT_STD_TIME.SetCommandParamValue("W_WORK_DATE", igrOT_LINE.GetCellValue(e.RowIndex, igrOT_LINE.GetColumnToIndex("WORK_DATE")));
                idcOT_STD_TIME.SetCommandParamValue("W_DANGJIK_YN", e.NewValue);
                idcOT_STD_TIME.SetCommandParamValue("W_ALL_NIGHT_YN", igrOT_LINE.GetCellValue(e.RowIndex, igrOT_LINE.GetColumnToIndex("ALL_NIGHT_YN")));
                idcOT_STD_TIME.ExecuteNonQuery();
                igrOT_LINE.SetCellValue("AFTER_OT_START", idcOT_STD_TIME.GetCommandParamValue("O_AFTER_OT_START"));
                igrOT_LINE.SetCellValue("AFTER_OT_END", idcOT_STD_TIME.GetCommandParamValue("O_AFTER_OT_END"));
                igrOT_LINE.SetCellValue("BEFORE_OT_START", idcOT_STD_TIME.GetCommandParamValue("O_BEFORE_OT_START"));
                igrOT_LINE.SetCellValue("BEFORE_OT_END", idcOT_STD_TIME.GetCommandParamValue("O_BEFORE_OT_END"));
            }
            else if (e.ColIndex == igrOT_LINE.GetColumnToIndex("ALL_NIGHT_YN"))
            {
                idcOT_STD_TIME.SetCommandParamValue("W_WORK_DATE", igrOT_LINE.GetCellValue(e.RowIndex, igrOT_LINE.GetColumnToIndex("WORK_DATE")));
                idcOT_STD_TIME.SetCommandParamValue("W_DANGJIK_YN", igrOT_LINE.GetCellValue(e.RowIndex, igrOT_LINE.GetColumnToIndex("DANGJIK_YN")));
                idcOT_STD_TIME.SetCommandParamValue("W_ALL_NIGHT_YN", e.NewValue);
                idcOT_STD_TIME.ExecuteNonQuery();
                igrOT_LINE.SetCellValue("AFTER_OT_START", idcOT_STD_TIME.GetCommandParamValue("O_AFTER_OT_START"));
                igrOT_LINE.SetCellValue("AFTER_OT_END", idcOT_STD_TIME.GetCommandParamValue("O_AFTER_OT_END"));
                igrOT_LINE.SetCellValue("BEFORE_OT_START", idcOT_STD_TIME.GetCommandParamValue("O_BEFORE_OT_START"));
                igrOT_LINE.SetCellValue("BEFORE_OT_END", idcOT_STD_TIME.GetCommandParamValue("O_BEFORE_OT_END"));
            }
        }
        
        private void igrOT_LINE_CellDoubleClick(object pSender)
        {
            if (igrOT_LINE.RowIndex < 0 && igrOT_LINE.ColIndex == igrOT_LINE.GetColumnToIndex("ALL_NIGHT_YN"))
            {
                for (int r = 0; r < igrOT_LINE.RowCount; r++)
                {
                    if (iString.ISNull(igrOT_LINE.GetCellValue(r, igrOT_LINE.GetColumnToIndex("ALL_NIGHT_YN")), "N") == "Y".ToString())
                    {
                        igrOT_LINE.SetCellValue(r, igrOT_LINE.GetColumnToIndex("ALL_NIGHT_YN"), "N");
                        idcOT_STD_TIME.SetCommandParamValue("W_PERSON_ID", igrOT_LINE.GetCellValue(r, igrOT_LINE.GetColumnToIndex("PERSON_ID")));
                        idcOT_STD_TIME.SetCommandParamValue("W_WORK_DATE", igrOT_LINE.GetCellValue(r, igrOT_LINE.GetColumnToIndex("WORK_DATE")));
                        idcOT_STD_TIME.SetCommandParamValue("W_DANGJIK_YN", "N");
                        idcOT_STD_TIME.SetCommandParamValue("W_ALL_NIGHT_YN", "N");
                        idcOT_STD_TIME.ExecuteNonQuery();
                        igrOT_LINE.SetCellValue(r, igrOT_LINE.GetColumnToIndex("AFTER_OT_START"), idcOT_STD_TIME.GetCommandParamValue("O_AFTER_OT_START"));
                        igrOT_LINE.SetCellValue(r, igrOT_LINE.GetColumnToIndex("AFTER_OT_END"), idcOT_STD_TIME.GetCommandParamValue("O_AFTER_OT_END"));
                        igrOT_LINE.SetCellValue(r, igrOT_LINE.GetColumnToIndex("BEFORE_OT_START"), idcOT_STD_TIME.GetCommandParamValue("O_BEFORE_OT_START"));
                        igrOT_LINE.SetCellValue(r, igrOT_LINE.GetColumnToIndex("BEFORE_OT_END"), idcOT_STD_TIME.GetCommandParamValue("O_BEFORE_OT_END"));
                    }
                    else
                    {
                        igrOT_LINE.SetCellValue(r, igrOT_LINE.GetColumnToIndex("ALL_NIGHT_YN"), "Y");
                        idcOT_STD_TIME.SetCommandParamValue("W_PERSON_ID", igrOT_LINE.GetCellValue(r, igrOT_LINE.GetColumnToIndex("PERSON_ID")));
                        idcOT_STD_TIME.SetCommandParamValue("W_WORK_DATE", igrOT_LINE.GetCellValue(r, igrOT_LINE.GetColumnToIndex("WORK_DATE")));
                        idcOT_STD_TIME.SetCommandParamValue("W_ALL_NIGHT_YN", "Y");
                        idcOT_STD_TIME.ExecuteNonQuery();
                        igrOT_LINE.SetCellValue(r, igrOT_LINE.GetColumnToIndex("AFTER_OT_START"), idcOT_STD_TIME.GetCommandParamValue("O_AFTER_OT_START"));
                        igrOT_LINE.SetCellValue(r, igrOT_LINE.GetColumnToIndex("AFTER_OT_END"), idcOT_STD_TIME.GetCommandParamValue("O_AFTER_OT_END"));
                        igrOT_LINE.SetCellValue(r, igrOT_LINE.GetColumnToIndex("BEFORE_OT_START"), idcOT_STD_TIME.GetCommandParamValue("O_BEFORE_OT_START"));
                        igrOT_LINE.SetCellValue(r, igrOT_LINE.GetColumnToIndex("BEFORE_OT_END"), idcOT_STD_TIME.GetCommandParamValue("O_BEFORE_OT_END"));
                    }
                }       
            }
            else if (igrOT_LINE.RowIndex < 0 && igrOT_LINE.ColIndex == igrOT_LINE.GetColumnToIndex("LUNCH_YN"))
            {
                for (int r = 0; r < igrOT_LINE.RowCount; r++)
                {
                    if (iString.ISNull(igrOT_LINE.GetCellValue(r, igrOT_LINE.GetColumnToIndex("LUNCH_YN")), "N") == "Y".ToString())
                    {
                        igrOT_LINE.SetCellValue(r, igrOT_LINE.GetColumnToIndex("LUNCH_YN"), "N");                        
                    }
                    else
                    {
                        igrOT_LINE.SetCellValue(r, igrOT_LINE.GetColumnToIndex("LUNCH_YN"), "Y");
                    }
                }       
            }
            else if (igrOT_LINE.RowIndex < 0 && igrOT_LINE.ColIndex == igrOT_LINE.GetColumnToIndex("DINNER_YN"))
            {
                for (int r = 0; r < igrOT_LINE.RowCount; r++)
                {
                    if (iString.ISNull(igrOT_LINE.GetCellValue(r, igrOT_LINE.GetColumnToIndex("DINNER_YN")), "N") == "Y".ToString())
                    {
                        igrOT_LINE.SetCellValue(r, igrOT_LINE.GetColumnToIndex("DINNER_YN"), "N");
                    }
                    else
                    {
                        igrOT_LINE.SetCellValue(r, igrOT_LINE.GetColumnToIndex("DINNER_YN"), "Y");
                    }
                }
            }
            else if (igrOT_LINE.RowIndex < 0 && igrOT_LINE.ColIndex == igrOT_LINE.GetColumnToIndex("MIDNIGHT_YN"))
            {
                for (int r = 0; r < igrOT_LINE.RowCount; r++)
                {
                    if (iString.ISNull(igrOT_LINE.GetCellValue(r, igrOT_LINE.GetColumnToIndex("MIDNIGHT_YN")), "N") == "Y".ToString())
                    {
                        igrOT_LINE.SetCellValue(r, igrOT_LINE.GetColumnToIndex("MIDNIGHT_YN"), "N");
                    }
                    else
                    {
                        igrOT_LINE.SetCellValue(r, igrOT_LINE.GetColumnToIndex("MIDNIGHT_YN"), "Y");
                    }
                }
            }
        }

        #endregion

        #region ----- Adapter Event ------
        private void idaOT_HEADER_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {
            if (iString.ISNull(e.Row["REQ_TYPE"]) == string.Empty)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Request Type(신청구분)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["REQ_DATE"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Request Date(신청 일자)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["CORP_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Corporation(업체 정보)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["DUTY_MANAGER_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Duty Control Level(근태관리 단위)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["REQ_PERSON_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Request Person(신청자)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
        }

        private void idaOT_HEADER_PreDelete(ISPreDeleteEventArgs e)
        {
            //if (igrOT_LINE.RowCount != 0)
            //{// 라인 존재.
            //    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("EAPP_10016"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            //    e.Cancel = true;
            //    return;
            //}

            //if (e.Row["OT_HEADER_ID"] == DBNull.Value)
            //{
            //    MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=Request Number(신청 번호)"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            //    e.Cancel = true;
            //    return;
            //}
        }
        #endregion

        #region ----- LookUP Event ----
        private void ilaWORK_TYPE_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", "WORK_TYPE");
        }
      
        private void ilaPERSON_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildPERSON_0.SetLookupParamValue("W_END_DATE", STD_DATE_0.EditValue);
        }

        private void ilaPERSON_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildPERSON_0.SetLookupParamValue("W_END_DATE", STD_DATE_0.EditValue);
        }

        private void ilaDUTY_MANAGER_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildDUTY_MANAGER.SetLookupParamValue("W_END_DATE", STD_DATE_0.EditValue);
        }
        #endregion

    }
}