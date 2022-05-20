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

namespace HRMF0305
{
    public partial class HRMF0305 : Office2007Form
    {
        
        #region ----- Variables -----

        ISFunction.ISDateTime iDateTime = new ISFunction.ISDateTime();
        ISFunction.ISConvert iString = new ISFunction.ISConvert();

        #endregion;
        
        #region ----- Constructor -----

        public HRMF0305(Form pMainForm, ISAppInterface pAppInterface)
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

        private void Search_DB()
        {
            if (CORP_ID_0.EditValue == null)
            {// 업체.
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10001"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                CORP_NAME_0.Focus();
                return;
            }
            if (START_DATE_0.EditValue == null)
            {// 시작일자
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10010"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                START_DATE_0.Focus();
                return;
            }
            if (END_DATE_0.EditValue == null)
            {// 종료일자
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10011"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                END_DATE_0.Focus();
                return;
            }
            if (Convert.ToDateTime(START_DATE_0.EditValue) > Convert.ToDateTime( END_DATE_0.EditValue))
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10012"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                START_DATE_0.Focus();
                return;
            }

            idaDUTY_PERIOD.OraSelectData.AcceptChanges();
            idaDUTY_PERIOD.Refillable = true;

            idaDUTY_PERIOD.SetSelectParamValue("W_SEARCH_TYPE", "R");
            idaDUTY_PERIOD.Fill();
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

        private void Set_BTN_STATE()
        {
            string mAPPROVE_STATE = iString.ISNull(APPROVE_STATUS_0.EditValue);
            int mIDX_SELECT_YN = igrDUTY_PERIOD.GetColumnToIndex("APPROVE_YN");
            if (mAPPROVE_STATE == String.Empty || mAPPROVE_STATE == "R")
            {
                btnOK.Enabled = false;
                btnCANCEL.Enabled = false;
                btnRETURN.Enabled = false;

                igrDUTY_PERIOD.GridAdvExColElement[mIDX_SELECT_YN].Updatable = 0;
            }
            else
            {
                btnOK.Enabled = true;
                btnCANCEL.Enabled = true;
                btnRETURN.Enabled = true;

                igrDUTY_PERIOD.GridAdvExColElement[mIDX_SELECT_YN].Updatable = 1;
            }
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
                xlPrinting.OpenFileNameExcel = "HRMF0305_001.xls";
                xlPrinting.XLFileOpen();

                int vTerritory = GetTerritory(igrDUTY_PERIOD.TerritoryLanguage);
                string vPeriodFrom = START_DATE_0.DateTimeValue.ToString("yyyy-MM-dd", null);
                string vPeriodTo = END_DATE_0.DateTimeValue.ToString("yyyy-MM-dd", null);

                string vUserName = string.Format("[{0}]{1}", isAppInterfaceAdv1.DEPT_NAME, isAppInterfaceAdv1.DISPLAY_NAME);

                int viCutStart = this.Text.LastIndexOf("]") + 1;
                string vCaption = this.Text.Substring(0, viCutStart);

                //xlPrinting.Req_Person_Name = "신 청 자 : " + igrDUTY_PERIOD.GetCellValue("REQUEST_PERSON_NAME");

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
                    Search_DB();
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddOver)
                {
                    if(idaDUTY_PERIOD.IsFocused)
                    {
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.AddUnder)
                {
                    if (idaDUTY_PERIOD.IsFocused)
                    {
                    }
                }
                else if (e.AppMainButtonType == ISUtil.Enum.AppMainButtonType.Update)
                {
                    if (idaDUTY_PERIOD.IsFocused)
                    {
                        
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

        private void HRMF0305_Load(object sender, EventArgs e)
        {
            idaDUTY_PERIOD.FillSchema();
            START_DATE_0.EditValue = DateTime.Today.AddDays(-7);
            END_DATE_0.EditValue = DateTime.Today.AddDays(7);
            
            // CORP SETTING
            DefaultCorporation();
            
            //LOOKUP SETTING
            ildAPPROVE_STATUS.SetLookupParamValue("W_GROUP_CODE", "DUTY_APPROVE_STATUS");
            ildAPPROVE_STATUS.SetLookupParamValue("W_ENABLED_FLAG_YN", "Y");
            ildSEARCH_TYPE.SetLookupParamValue("W_GROUP_CODE", "SEARCH_TYPE");
            ildSEARCH_TYPE.SetLookupParamValue("W_ENABLED_FLAG_YN", "Y");

            //DefaultSetFormReSize();		//[Child Form, Mdi Form에 맞게 ReSize]
            irbAPPR_A.CheckedState = ISUtil.Enum.CheckedState.Checked;
            EMAIL_STATUS.EditValue = "N";
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

        private void btnOK_ButtonClick(object pSender, EventArgs pEventArgs)
        {// 승인
            // EMAIL STATUS.
            if (iString.ISNull(APPROVE_STATUS_0.EditValue) == "A".ToString())
            {
                EMAIL_STATUS.EditValue = "A_OK";
            }
            else if (iString.ISNull(APPROVE_STATUS_0.EditValue) == "B".ToString())
            {
                EMAIL_STATUS.EditValue = "B_OK";
            }
            else
            {
                EMAIL_STATUS.EditValue = "N";
            }

            idaDUTY_PERIOD.SetUpdateParamValue("P_APPROVE_FLAG", "OK");
            idaDUTY_PERIOD.Update();

            idaDUTY_PERIOD.Fill();
        }

        private void btnCANCEL_ButtonClick(object pSender, EventArgs pEventArgs)
        {// 취소
            // EMAIL STATUS.
            if (iString.ISNull(APPROVE_STATUS_0.EditValue) == "A".ToString())
            {
                EMAIL_STATUS.EditValue = "A_CANCEL";
            }
            else if (iString.ISNull(APPROVE_STATUS_0.EditValue) == "B".ToString())
            {
                EMAIL_STATUS.EditValue = "B_CANCEL";
            }
            else if (iString.ISNull(APPROVE_STATUS_0.EditValue) == "C".ToString())
            {
                EMAIL_STATUS.EditValue = "C_CANCEL";
            }
            else
            {
                EMAIL_STATUS.EditValue = "N";
            }
            idaDUTY_PERIOD.SetUpdateParamValue("P_APPROVE_FLAG", "CANCEL");
            idaDUTY_PERIOD.Update();

            idaDUTY_PERIOD.Fill();
        }

        private void btnRETURN_ButtonClick(object pSender, EventArgs pEventArgs)
        {
            if (CORP_ID_0.EditValue == null)
            {// 업체.
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10001"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                CORP_NAME_0.Focus();
                return;
            }
            if (START_DATE_0.EditValue == null)
            {// 시작일자
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10010"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                START_DATE_0.Focus();
                return;
            }
            if (END_DATE_0.EditValue == null)
            {// 종료일자
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10011"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                END_DATE_0.Focus();
                return;
            }
            if (Convert.ToDateTime(START_DATE_0.EditValue) > Convert.ToDateTime(END_DATE_0.EditValue))
            {
                MessageBoxAdv.Show(isMessageAdapter1.ReturnText("FCM_10012"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                START_DATE_0.Focus();
                return;
            }

            Application.UseWaitCursor = true;
            this.Cursor = System.Windows.Forms.Cursors.WaitCursor;
            DialogResult dlgResultValue;
            Form vHRMF0305_RETURN = new HRMF0305_RETURN(isAppInterfaceAdv1.AppInterface
                                                        , CORP_ID_0.EditValue
                                                        , START_DATE_0.EditValue
                                                        , END_DATE_0.EditValue
                                                        , APPROVE_STATUS_0.EditValue
                                                        , DUTY_ID_0.EditValue
                                                        , FLOOR_ID_0.EditValue
                                                        , PERSON_ID_0.EditValue
                                                        );
            dlgResultValue = vHRMF0305_RETURN.ShowDialog();
            if (dlgResultValue == DialogResult.OK)
            {
            }
            vHRMF0305_RETURN.Dispose();

            Search_DB();
            this.Cursor = System.Windows.Forms.Cursors.Default;
            Application.UseWaitCursor = false;
        }

        private void irbSTATUS_CheckChanged(object sender, EventArgs e)
        {
            ISRadioButtonAdv iStatus = sender as ISRadioButtonAdv;
            APPROVE_STATUS_0.EditValue = iStatus.RadioCheckedString;

            Set_BTN_STATE();  // 버튼 상태 변경.
            Search_DB();
        }

        private void igrDUTY_PERIOD_CellDoubleClick(object pSender)
        {
            string mAPPROVE_STATE = iString.ISNull(APPROVE_STATUS_0.EditValue);
            if (mAPPROVE_STATE == String.Empty || mAPPROVE_STATE == "R")
            {
                return;
            }
            if (igrDUTY_PERIOD.RowIndex < 0 && igrDUTY_PERIOD.ColIndex == igrDUTY_PERIOD.GetColumnToIndex("APPROVE_YN"))
            {
                for (int r = 0; r < igrDUTY_PERIOD.RowCount; r++)
                {
                    if (iString.ISNull(igrDUTY_PERIOD.GetCellValue(r, igrDUTY_PERIOD.GetColumnToIndex("APPROVE_YN")), "N") == "Y".ToString())
                    {
                        igrDUTY_PERIOD.SetCellValue(r, igrDUTY_PERIOD.GetColumnToIndex("APPROVE_YN"), "N");
                    }
                    else
                    {
                        igrDUTY_PERIOD.SetCellValue(r, igrDUTY_PERIOD.GetColumnToIndex("APPROVE_YN"), "Y");
                    }
                }
            }
        }

        #endregion  

        #region ----- Adapter Event -----

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

        private void idaDUTY_PERIOD_UpdateCompleted(object pSender)
        {
            // EMAIL 발송.
            idcEMAIL_SEND.SetCommandParamValue("P_GUBUN", EMAIL_STATUS.EditValue);
            idcEMAIL_SEND.SetCommandParamValue("P_SOURCE_TYPE", "DUTY");
            idcEMAIL_SEND.SetCommandParamValue("P_CORP_ID", CORP_ID_0.EditValue);
            idcEMAIL_SEND.SetCommandParamValue("P_WORK_DATE", DateTime.Today);
            idcEMAIL_SEND.SetCommandParamValue("P_REQ_DATE", DateTime.Today);
            idcEMAIL_SEND.ExecuteNonQuery();
        }

        private void idaDUTY_PERIOD_PreDelete(ISPreDeleteEventArgs e)
        {
        }

        private void idaDUTY_PERIOD_NewRowMoved(object pSender, ISBindingEventArgs pBindingManager)
        {
            //if (igrDUTY_PERIOD.RowCount != 0)
            //{
                isSearch_WorkCalendar(igrDUTY_PERIOD.GetCellValue("PERSON_ID"), igrDUTY_PERIOD.GetCellValue("START_DATE"), igrDUTY_PERIOD.GetCellValue("END_DATE"));
            //}
        }

        #endregion

        #region ----- LookUp Event -----
        private void ilaAPPROVE_STATUS_0_SelectedRowData(object pSender)
        {
            idaDUTY_PERIOD.Fill();
        }

        private void ilaFLOOR_0_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildCOMMON.SetLookupParamValue("W_GROUP_CODE", "FLOOR");
            ildCOMMON.SetLookupParamValue("W_ENABLED_FLAG_YN", "Y");
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
            ildPERIOD_TIME.SetLookupParamValue("W_START_YN", "Y".ToString());
            ildPERIOD_TIME.SetLookupParamValue("W_END_YN", null);
        }

        private void ilaEND_TIME_PrePopupShow(object pSender, ISLookupPopupShowEventArgs e)
        {
            ildPERIOD_TIME.SetLookupParamValue("W_WORK_DATE", igrDUTY_PERIOD.GetCellValue("END_DATE"));
            ildPERIOD_TIME.SetLookupParamValue("W_START_YN", null);
            ildPERIOD_TIME.SetLookupParamValue("W_END_YN", "Y".ToString());
        }        
        #endregion

    }
}