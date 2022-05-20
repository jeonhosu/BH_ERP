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

namespace HRMF0304
{
    public partial class HRMF0304 : Office2007Form
    {
        
        #region ----- Variables -----

        ISFunction.ISDateTime iDateTime = new ISFunction.ISDateTime();
        ISFunction.ISConvert iString = new ISFunction.ISConvert();
        
        #endregion;

        #region ----- Constructor -----

        public HRMF0304(Form pMainForm, ISAppInterface pAppInterface)
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

        private void isSearch_DB()
        {
            if (CORP_ID_0.EditValue == null)
            {// 업체.
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10001"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                CORP_NAME_0.Focus();
                return;
            }
            if (iSTART_DATE_0.EditValue == null)
            {// 시작일자
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10010"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                iSTART_DATE_0.Focus();
                return;
            }
            if (iEND_DATE_0.EditValue == null)
            {// 종료일자
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10011"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                iEND_DATE_0.Focus();
                return;
            }
            if (Convert.ToDateTime(iSTART_DATE_0.EditValue) > Convert.ToDateTime( iEND_DATE_0.EditValue))
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10012"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                iSTART_DATE_0.Focus();
                return;
            }

            idaDUTY_PERIOD.Fill();
            igrDUTY_PERIOD.Focus();
        }

        private void isSearch_WorkCalendar(Object pPerson_ID, Object pStart_Date, Object pEnd_Date)
        {            
            idaWORK_CALENDAR.SetSelectParamValue("W_PERSON_ID", pPerson_ID);
            idaWORK_CALENDAR.SetSelectParamValue("W_START_DATE", pStart_Date);
            idaWORK_CALENDAR.SetSelectParamValue("W_END_DATE", pEnd_Date);

            if (pStart_Date != DBNull.Value && pEnd_Date != DBNull.Value)
            {
                idaHOLIDAY_MANAGEMENT.SetSelectParamValue("W_START_YEAR", iDateTime.ISYear(Convert.ToDateTime(pStart_Date)));
                idaHOLIDAY_MANAGEMENT.SetSelectParamValue("W_END_YEAR", iDateTime.ISYear(Convert.ToDateTime(pEnd_Date)));
            }
            idaWORK_CALENDAR.Fill();
            idaHOLIDAY_MANAGEMENT.Fill();
        }

        private bool isAdd_DB_Check()
        {// 데이터 추가시 검증.
            if (CORP_ID_0.EditValue == null)
            {// 업체.
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10001"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                CORP_NAME_0.Focus();
                return false;
            }
            return true;
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
                    bool vbXLSaveOK = mExport.ExcelExport(pGrid, vTerritory, vsSaveExcelFileName, this.Text, this);
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

        #region ----- XL Print 1 Methods ----

        private void XLPrinting1()
        {
            string vMessageText = string.Empty;

            XLPrinting xlPrinting = new XLPrinting();

            try
            {
                //-------------------------------------------------------------------------
                xlPrinting.OpenFileNameExcel = "HRMF0304_001.xls";
                xlPrinting.XLFileOpen();

                int vTerritory = GetTerritory(igrDUTY_PERIOD.TerritoryLanguage);
                string vPeriodFrom = iSTART_DATE_0.DateTimeValue.ToString("yyyy-MM-dd", null);
                string vPeriodTo = iEND_DATE_0.DateTimeValue.ToString("yyyy-MM-dd", null);

                string vUserName = string.Format("[{0}]{1}", isAppInterfaceAdv1.DEPT_NAME, isAppInterfaceAdv1.DISPLAY_NAME);

                int viCutStart = this.Text.LastIndexOf("]") + 1;
                string vCaption = this.Text.Substring(0, viCutStart);

                xlPrinting.Req_Person_Name = "신 청 자 : " + igrDUTY_PERIOD.GetCellValue("REQUEST_PERSON_NAME");

                int vPageNumber = xlPrinting.XLWirte(igrDUTY_PERIOD, vTerritory, vPeriodFrom, vPeriodTo, vUserName, vCaption);

                xlPrinting.Printing(1, vPageNumber); //시작 페이지 번호, 종료 페이지 번호
                //xlPrinting.Printing(3, 4);


                xlPrinting.Save("Cashier_"); //저장 파일명

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
                    isSearch_DB();
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddOver)
                {
                    if(idaDUTY_PERIOD.IsFocused)
                    {
                        if (isAdd_DB_Check() == false)
                        {
                            return;
                        }

                        idaDUTY_PERIOD.AddOver();

                        igrDUTY_PERIOD.SetCellValue("START_DATE", DateTime.Today.Date);
                        igrDUTY_PERIOD.SetCellValue("END_DATE", DateTime.Today.Date);
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddUnder)
                {
                    if (idaDUTY_PERIOD.IsFocused)
                    {
                        if (isAdd_DB_Check() == false)
                        {
                            return;
                        }
                        idaDUTY_PERIOD.AddUnder();

                        igrDUTY_PERIOD.SetCellValue("START_DATE", DateTime.Today.Date);
                        igrDUTY_PERIOD.SetCellValue("END_DATE", DateTime.Today.Date);
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Update)
                {
                    if (idaDUTY_PERIOD.IsFocused)
                    {
                        idaDUTY_PERIOD.Update();                        
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Cancel)
                {
                    if (idaDUTY_PERIOD.IsFocused)
                    {
                        idaDUTY_PERIOD.Cancel();
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Delete)
                {
                    if (idaDUTY_PERIOD.IsFocused)
                    {
                        idaDUTY_PERIOD.Delete();
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
                    }
                    */

                    ExportXL(igrDUTY_PERIOD);

                }
            }
        }
        #endregion;

        #region ----- Form Event -----
        private void HRMF0304_Load(object sender, EventArgs e)
        {
            idaDUTY_PERIOD.FillSchema();
            iSTART_DATE_0.EditValue = DateTime.Today.AddDays(-7);
            iEND_DATE_0.EditValue = DateTime.Today.AddDays(7);

            DefaultCorporation();

            // LOOKUP DEFAULT VALUE SETTING - DUTY_APPROVE_STATUS
            idcDEFAULT_VALUE.SetCommandParamValue("W_GROUP_CODE", "DUTY_APPROVE_STATUS");
            idcDEFAULT_VALUE.ExecuteNonQuery();
            iAPPROVE_STATUS_NAME_0.EditValue = idcDEFAULT_VALUE.GetCommandParamValue("O_CODE_NAME");
            iAPPROVE_STATUS_0.EditValue = idcDEFAULT_VALUE.GetCommandParamValue("O_CODE");

            // LOOKUP DEFAULT VALUE SETTING - SEARCH_TYPE
            idcDEFAULT_VALUE.SetCommandParamValue("W_GROUP_CODE", "SEARCH_TYPE");
            idcDEFAULT_VALUE.ExecuteNonQuery();
            iSEARCH_TYPE_NAME_0.EditValue = idcDEFAULT_VALUE.GetCommandParamValue("O_CODE_NAME");
            iSEARCH_TYPE_0.EditValue = idcDEFAULT_VALUE.GetCommandParamValue("O_CODE");
        }

        private void igrDUTY_PERIOD_CurrentCellValidating(object pSender, ISGridAdvExValidatingEventArgs e)
        {// 시작일자 또는 종료일자 변경시 근무계획 조회.
            if (e.ColIndex == igrDUTY_PERIOD.GetColumnToIndex("NAME"))
            {
                isSearch_WorkCalendar(igrDUTY_PERIOD.GetCellValue("PERSON_ID"), igrDUTY_PERIOD.GetCellValue("START_DATE"), igrDUTY_PERIOD.GetCellValue("END_DATE"));
            }

            if (e.ColIndex == igrDUTY_PERIOD.GetColumnToIndex("START_DATE"))
            {
                isSearch_WorkCalendar(igrDUTY_PERIOD.GetCellValue("PERSON_ID"), e.NewValue, igrDUTY_PERIOD.GetCellValue("END_DATE"));                
            }
            if (e.ColIndex == igrDUTY_PERIOD.GetColumnToIndex("END_DATE"))
            {
                isSearch_WorkCalendar(igrDUTY_PERIOD.GetCellValue("PERSON_ID"), igrDUTY_PERIOD.GetCellValue("START_DATE"), e.NewValue);
            }
        }
        
        private void btnAPPR_REQUEST_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            idaDUTY_PERIOD.Update();

            int mRowCount = igrDUTY_PERIOD.RowCount;
            for (int R = 0; R < mRowCount; R++)
            {
                if(iString.ISNull(igrDUTY_PERIOD.GetCellValue(R, igrDUTY_PERIOD.GetColumnToIndex("APPROVE_STATUS"))) == "N".ToString())
                {// 승인미요청 건에 대해서 승인 처리.
                    idcAPPROVAL_REQUEST.SetCommandParamValue("W_DUTY_PERIOD_ID", igrDUTY_PERIOD.GetCellValue(R, igrDUTY_PERIOD.GetColumnToIndex("DUTY_PERIOD_ID")));
                    idcAPPROVAL_REQUEST.ExecuteNonQuery();

                    object mValue;
                    mValue = idcAPPROVAL_REQUEST.GetCommandParamValue("O_APPROVE_STATUS");
                    igrDUTY_PERIOD.SetCellValue(R, igrDUTY_PERIOD.GetColumnToIndex("APPROVE_STATUS"), mValue);
                    mValue = idcAPPROVAL_REQUEST.GetCommandParamValue("O_APPROVE_STATUS_NAME");
                    igrDUTY_PERIOD.SetCellValue(R, igrDUTY_PERIOD.GetColumnToIndex("APPROVE_STATUS_NAME"), mValue);
                }
            }

            // EMAIL 발송.
            idcEMAIL_SEND.SetCommandParamValue("P_GUBUN", "A");
            idcEMAIL_SEND.SetCommandParamValue("P_SOURCE_TYPE", "DUTY");
            idcEMAIL_SEND.SetCommandParamValue("P_CORP_ID", CORP_ID_0.EditValue);
            idcEMAIL_SEND.SetCommandParamValue("P_WORK_DATE", DateTime.Today);
            idcEMAIL_SEND.SetCommandParamValue("P_REQ_DATE", DateTime.Today);
            idcEMAIL_SEND.ExecuteNonQuery();

            idaDUTY_PERIOD.OraSelectData.AcceptChanges();
            idaDUTY_PERIOD.Refillable = true;
        }

        #endregion

        #region ----- Adapter Event -----
        private void idaDUTY_PERIOD_NewRowMoved_1(object pSender, ISBindingEventArgs pBindingManager)
        {
            isSearch_WorkCalendar(igrDUTY_PERIOD.GetCellValue("PERSON_ID"), igrDUTY_PERIOD.GetCellValue("START_DATE"), igrDUTY_PERIOD.GetCellValue("END_DATE"));
        }

        private void idaDUTY_PERIOD_PreRowUpdate(ISPreRowUpdateEventArgs e)
        {
            if(e.Row["PERSON_ID"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=사원 정보"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["START_DATE"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=시작일자"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (e.Row["END_DATE"] == DBNull.Value)
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=종료일자"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
            if (Convert.ToDateTime(e.Row["START_DATE"]) > Convert.ToDateTime(e.Row["END_DATE"]))
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10012"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }

            if (String.IsNullOrEmpty(e.Row["DESCRIPTION"].ToString()))
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10037", "&&VALUE:=사유"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                e.Cancel = true;
                return;
            }
        }

        private void idaDUTY_PERIOD_PreDelete(ISPreDeleteEventArgs e)
        {
        
        }

        private void idaDUTY_PERIOD_NewRowMoved(object pSender, ISBindingEventArgs pBindingManager)
        {
            //if (igrDUTY_PERIOD.RowCount != 0)
            //{
            //    isSearch_WorkCalendar(igrDUTY_PERIOD.GetCellValue("PERSON_ID"), igrDUTY_PERIOD.GetCellValue("START_DATE"), igrDUTY_PERIOD.GetCellValue("END_DATE"));
            //}
            isSearch_WorkCalendar(igrDUTY_PERIOD.GetCellValue("PERSON_ID"), igrDUTY_PERIOD.GetCellValue("START_DATE"), igrDUTY_PERIOD.GetCellValue("END_DATE"));
        }

        #endregion

        #region ----- LookUp Event -----

        private void ilaAPPROVE_STATUS_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildAPPROVE_STATUS.SetLookupParamValue("W_GROUP_CODE", "DUTY_APPROVE_STATUS");
            ildAPPROVE_STATUS.SetLookupParamValue("W_ENABLED_FLAG_YN", "Y");
        }

        private void ilaSEARCH_TYPE_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildSEARCH_TYPE.SetLookupParamValue("W_GROUP_CODE", "SEARCH_TYPE");
            ildSEARCH_TYPE.SetLookupParamValue("W_ENABLED_FLAG_YN", "Y");
        }

        private void ilaFLOOR_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", "FLOOR");
            ildCOMMON.SetLookupParamValue("W_ENABLED_FLAG_YN", "N");
        }
        
        private void ilaDUTY_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", "DUTY");
            ildCOMMON.SetLookupParamValue("W_ENABLED_FLAG_YN", "N");
        }

        private void ildDUTY_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", "DUTY");
            ildCOMMON.SetLookupParamValue("W_ENABLED_FLAG_YN", "Y");
        }

        private void ilaSTART_TIME_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildPERIOD_TIME.SetLookupParamValue("W_WORK_DATE", igrDUTY_PERIOD.GetCellValue("START_DATE"));
            ildPERIOD_TIME.SetLookupParamValue("W_START_YN", "Y");
            ildPERIOD_TIME.SetLookupParamValue("W_END_YN", null);
        }

        private void ilaEND_TIME_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildPERIOD_TIME.SetLookupParamValue("W_WORK_DATE", igrDUTY_PERIOD.GetCellValue("END_DATE"));
            ildPERIOD_TIME.SetLookupParamValue("W_START_YN", null);
            ildPERIOD_TIME.SetLookupParamValue("W_END_YN", "Y");
        }
        
        #endregion

    }
}